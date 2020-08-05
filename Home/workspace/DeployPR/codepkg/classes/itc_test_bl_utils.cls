/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class itc_test_bl_utils {

    static testMethod void myUnitTest() {
    	ShoreTelUser__c suser = new ShoreTelUser__c();
    	suser.First_Name__c = 'test';
    	suser.Last_Name__c = 'tlast';
    	suser.Site__c = 'Wellesley, MA';
    	insert suser;
    	CallType__c calltype = new CallType__c();
    	calltype.Name = 'Inbound';
    	insert calltype;
    	
        Call__c call = new Call__c();
        call.CallType__c = calltype.Id;
        call.ShoreTel_User__c = suser.Id;
        insert call;
        
        call = [select id, CallType__r.name, ShoreTel_User__r.Site__c, CreatedDate from Call__c where id = :call.Id];
        List<sObject> lst = new List<sObject>();
        lst.add(call);
        
        List<InfrastructureStats__c> infstats = itc_bl_utils.UpdateInfraStats(lst, null);
        
        System.assertEquals(1, infstats.size());
        
    }
}