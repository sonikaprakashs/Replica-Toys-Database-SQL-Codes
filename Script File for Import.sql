CREATE TABLE Person
(PersonID INT NOT NULL Primary Key,
LastName VARCHAR (30) NOT NULL,
FirstName VARCHAR (30) NOT NULL,
PhoneNumber CHAR (15) NOT NULL,
PersonType VARCHAR (1) NOT NULL); 

SELECT * FROM Person

CREATE TABLE Model
(ModelNumber CHAR (6) NOT NULL Primary Key,
ModelName VARCHAR (30) NOT NULL,
ModelDescription VARCHAR (100) NOT NULL,
StandardPrice Money NOT NULL);

SELECT * FROM Model

CREATE TABLE AllProblem
(TestID INT NULL,
TestDate DateTime NULL,
TestDescription VARCHAR (200) NULL,
TestResults VARCHAR (300) NULL,
TestComplete VARCHAR (1) NULL,
TesterID INT NULL,
ReportID INT NULL,
RelatedTestID INT NULL,
ProblemReportReportID INT NULL,
ReportDate DateTime NULL,
CompleteDate Datetime NULL,
ProblemDescription VARCHAR (100) NULL,
InjuryYN VARCHAR (3) NULL,
InjuryDescription VARCHAR (80) NULL,
ProblemReportSerialNumber CHAR (10) NULL,
ProblemReportProblemTypeID INT NULL,
ReporterID INT NULL,
ProblemTypeID INT NULL,
TypeDescription VARCHAR (100) NULL,
SerialNumber CHAR (10),
ToyModelNumber CHAR (6) NULL,
OwnerID INT NULL,
PricePaid Money NULL);

SELECT * FROM AllProblem

CREATE TABLE Toy
(SerialNumber CHAR (10) Primary Key NOT NULL,
ModelNumber Char (6) Foreign Key References Model (ModelNumber) NOT NULL,
OwnerID INT Foreign Key References Person (PersonID));

INSERT INTO Toy (SerialNumber, ModelNumber, OwnerID)
SELECT DISTINCT SerialNumber, ToyModelNumber, OwnerID
FROM AllProblem
WHERE SerialNumber IS NOT NULL;

SELECT * FROM Toy

CREATE TABLE ProblemReportType
(ProblemReportTypeID INT Primary Key NOT NULL,
TypeDescription VARCHAR (100) NOT NULL);

INSERT INTO ProblemReportType (ProblemReportTypeID, TypeDescription)
SELECT DISTINCT ProblemTypeID, TypeDescription
FROM AllProblem
WHERE ProblemTypeID IS NOT NULL;

SELECT * FROM ProblemReportType

CREATE TABLE ProblemReport
(ProblemReportID INT NOT NULL Primary Key,
ReportDate DateTime NOT NULL,
CompleteDate DateTime,
ProblemDescription VARCHAR (100) NOT NULL,
InjuryYN VARCHAR (3) NOT NULL,
InjuryDescription VARCHAR (80),
SerialNumber CHAR (10) Foreign Key References Toy (SerialNumber) NOT NULL,
ProblemReportTypeID INT Foreign Key References ProblemReportType (ProblemReportTypeID) NOT NULL,
ReporterID INT Foreign Key References Person (PersonID) NOT NULL,
PricePaid DECIMAL (8,2) NOT NULL);

INSERT INTO ProblemReport 
(ProblemReportID, ReportDate, CompleteDate, ProblemDescription, InjuryYN, InjuryDescription, SerialNumber, 
ProblemReportTypeID, ReporterID, PricePaid)
SELECT DISTINCT ProblemReportReportID, ReportDate, CompleteDate, 
ProblemDescription, InjuryYN, InjuryDescription, ProblemReportSerialNumber, ProblemReportProblemTypeID, 
ReporterID, PricePaid
FROM AllProblem
WHERE ProblemReportReportID IS NOT NULL
ORDER BY ProblemReportReportID;

SELECT * FROM ProblemReport

CREATE TABLE Test
(TestID INT Primary Key NOT NULL,
TestDate DateTime NOT NULL,
TestDescription VARCHAR (300) NOT NULL,
TestResults VARCHAR (200),
TestComplete VARCHAR (1) NOT NULL,
TesterID INT Foreign Key References Person (PersonID), 
ReportID INT Foreign Key References ProblemReport (ProblemReportID),
RelatedTestID INT Foreign Key References Test (TestID));

INSERT INTO Test 
(TestID, TestDate, TestDescription, TestResults, testComplete, testerID, ReportID, RelatedTestID)
SELECT DISTINCT 
TestID, TestDate, TestDescription, TestResults, testComplete, testerID, ReportID, RelatedTestID
FROM AllProblem
WHERE TestID IS NOT NULL;

SELECT * FROM Test















