create database healthcare;
use healthcare;

CREATE TABLE Dialysis1 (
    ProviderNumber INT PRIMARY KEY,
    FacilityName VARCHAR(255),
    City VARCHAR(100),
    State CHAR(2),
    County VARCHAR(100),
    ProfitOrNonProfit VARCHAR(20),
    ChainOrganization VARCHAR(255),
    NumOfDialysisStations INT,
    PatientTransfusionCategoryText VARCHAR(255),
    PatientHospitalizationCategoryText VARCHAR(255),
    PatientSurvivalCategoryText VARCHAR(255),
    PatientInfectionCategoryText VARCHAR(255),
    FistulaCategoryText VARCHAR(255),
    SWRCategoryText VARCHAR(255),
    PPPWCategoryText VARCHAR(255),
    PatientsInTransfusionSummary INT,
    PatientsInHypercalcemiaSummary INT,
    PatientsInSerumPhosphorusSummary INT,
    PatientsInHospitalizationSummary INT,
    HospitalizationsInHospitalReadmissionSummary INT,
    PatientsInSurvivalSummary INT,
    PatientsInFistulaSummary INT,
    PatientsInLongTermCatheterSummary INT,
    PatientsInNPCRSummary INT
);


-- KPI 1 : Number of Patients across various summaries

select * from dialysis1;
select
	sum(patientsintransfusionsummary) as Transfusion_Summary, 
	sum(PatientsInHypercalcemiaSummary) as Hypercalcemia_Summary,
    sum(PatientsInSerumPhosphorusSummary) as Serum_Phosphorus_Summary,
    sum(PatientsInHospitalizationSummary) as Hospitalization_Summary,
    sum(HospitalizationsInHospitalReadmissionSummary) as Hospital_Readmission_Summary,
    sum(PatientsInSurvivalSummary) as Survival_Summary,
    sum(PatientsInFistulaSummary) as Fistula_Summary,
    sum(PatientsInLongTermCatheterSummary) as LongTerm_Catheter_Summary,
    sum(PatientsInNPCRSummary) as nPCR_Summary
from dialysis1;

SELECT 'Transfusion Summary' AS Summary, SUM(PatientsInTransfusionSummary) AS Patients FROM dialysis1
UNION
SELECT 'Hypercalcemia Summary', SUM(PatientsInHypercalcemiaSummary) FROM dialysis1
UNION
SELECT 'Serum Phosphorus Summary', SUM(PatientsInSerumPhosphorusSummary) FROM dialysis1
UNION
SELECT 'Hospitalization Summary', SUM(PatientsInHospitalizationSummary) FROM dialysis1
UNION
SELECT 'Hospital Readmission Summary', SUM(HospitalizationsInHospitalReadmissionSummary) FROM dialysis1
UNION
SELECT 'Survival Summary', SUM(PatientsInSurvivalSummary) FROM dialysis1
UNION
SELECT 'Fistula Summary', SUM(PatientsInFistulaSummary) FROM dialysis1
UNION
SELECT 'LongTerm Catheter Summary', SUM(PatientsInLongTermCatheterSummary) FROM dialysis1
UNION
SELECT 'nPCR Summary', SUM(PatientsInNPCRSummary) FROM dialysis1 order by Patients desc;


-- KPI 2 : Profit Vs Non-Profit Stats

Select
	State,
    sum(case when profitornonprofit = "Profit" then 1 else 0 end) as Profit,
    sum(case when profitornonprofit = "Non-Profit" then 1 else 0 end) as 'Non-Profit'
from dialysis1
group by state
order by profit desc;

-- KPI 3 : Chain Organizations w.r.t. Total Performance Score as No Score

select * from dialysis2;
select * from dialysis1;
select 
	d1.ChainOrganization,
    count(d2.totalperformancescore) as 'No Score Count'
from dialysis2 d2
left join dialysis1 d1
on d2.ccn = d1.providernumber
where d2.totalperformancescore = 'No Score'
group by d1.ChainOrganization
order by count(d2.totalperformancescore) desc;


-- KPI 4 : Dialysis Stations Stats

select 
	state,
    count(numofdialysisstations) as 'No. of Dialysis Stations'
from dialysis1
group by state
order by count(numofdialysisstations) desc;


-- KPI 5 : # of Category Text  - As Expected  
   
select * from dialysis1;
select 
	sum(case when PatientTransfusionCategoryText = 'As Expected' then 1 else 0 end) as PatientTransfusion,
    sum(case when PatientHospitalizationCategoryText = 'As Expected' then 1 else 0 end) as PatientHospitalization,
    sum(case when PatientSurvivalCategoryText = 'As Expected' then 1 else 0 end) as PatientSurvival,
    sum(case when PatientInfectionCategoryText = 'As Expected' then 1 else 0 end) as PatientInfection,
    sum(case when FistulaCategoryText = 'As Expected' then 1 else 0 end) as Fistula,
    sum(case when SWRCategoryText = 'As Expected' then 1 else 0 end) as SWRCategory,
    sum(case when PPPWCategoryText = 'As Expected' then 1 else 0 end) as PPPWCategory
from dialysis1;

SELECT 'Patient Transfusion' AS Category, SUM(CASE WHEN PatientTransfusionCategoryText = 'As Expected' THEN 1 ELSE 0 END) AS Num_of_Category FROM dialysis1
UNION
SELECT 'Patient Hospitalization', SUM(CASE WHEN PatientHospitalizationCategoryText = 'As Expected' THEN 1 ELSE 0 END) FROM dialysis1
UNION
SELECT 'Patient Survival', SUM(CASE WHEN PatientSurvivalCategoryText = 'As Expected' THEN 1 ELSE 0 END) FROM dialysis1
UNION
SELECT 'Patient Infection', SUM(CASE WHEN PatientInfectionCategoryText = 'As Expected' THEN 1 ELSE 0 END) FROM dialysis1
UNION
SELECT 'Fistula', SUM(CASE WHEN FistulaCategoryText = 'As Expected' THEN 1 ELSE 0 END) FROM dialysis1
UNION
SELECT 'SWR Category', SUM(CASE WHEN SWRCategoryText = 'As Expected' THEN 1 ELSE 0 END) FROM dialysis1
UNION
SELECT 'PPPW Category', SUM(CASE WHEN PPPWCategoryText = 'As Expected' THEN 1 ELSE 0 END) FROM dialysis1 order by Num_of_Category desc;

-- KPI 6 : Average Payment Reduction Rate

select * from dialysis2;

select avg(paymentreductionpercentage) as 'Avg Payment Reduction Rate' from dialysis2;


