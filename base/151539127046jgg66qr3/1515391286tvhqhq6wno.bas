Attribute VB_Name = "objFSO"
Option Compare Database
Option Explicit

' ������� ���������� ������� FSO (FileSystemObject)
' Release 1.3 �� 22.10.2015
' �����: ������� ������ (aka Joss) banderlogi@bk.ru
' ��������: freeware - ��������� �������������. ������ �������������, �� ����������.
'
' �� ������� ����������� �.�.������ "Visual Basic 6.0, Visual Basic for Applications 6.0"
'
' ��������� ������ FileSystemObject ������������ ����� ��������������� ���������
' �������� (�������), ����������� �������� ���������� � �������� ������� ����������
' � ��������� ��������� �������� � ���������� ���� �������.
' ��������� ������ �������� ��������� ������
' FileSystemObject - ������������ ������ � �������� ������� ����������
' Drives - �������� ������� Drive, ������ �� ������� ������������� ����� � �����
'          ������ � �������� ������� ���������� � ������ ����
' Drive - ������������ ����������� � �������� ����� ����������
' Folders - ��������� Folders �������� ������� Folder, ������ �� �������
'           ������������ � ����� ������������ ��������� ��������
' Folder - ������������ ������ � ���������� ��������� �����, � ������������ � ��
'          ������� ���������, � ����� � ������� ����������� ����� � ��������
'          ���������� �����.
' Files - ��������� Files �������� ������� File, ������ �� ������� ������������
'         ����� � ����� ������
' File - ������������ ������ � ���������� � �������� �����, ������� �����������
'        � �������� �����
' TextStream - ������������ �������� ������/������ ��� ���������� �����, ���������
'              � ������ ����������������� �������
'
' ������ ���������� �������� ����� ��� ������ ������� FileSystemObject (����� ���,
' ��� ������������� ������ �� ������ �������).
'
' ����������: ����� ����� ���������� ��������� ��������: ���� ������ ���������� FileSystemObject �
' ������� ������ ������ ���������� FileSystemObject.
'
' FileSystemObject (������) - ������������ ������ � �������� ������� ����������. ������
' �������� �������� ������ ��������� ������ FileSystemObject, �������� "������ �����" �
' � �������� ������� ����������. ������ ����� ��� �������� �������� ������ � ������
' �������� ������, �� ������� � ���������
'

'---------------------------------------------------------------------------------------
' Procedure : fnBuildPath
' DateTime  : 13.06.2006 14:24
' Author    : DSonnyh
' Purpose   : �������� ������ ����� ������� ���������� � ���������� ����� ���� \ (���� ��� ���)
'---------------------------------------------------------------------------------------
'
Public Function fnBuildPath(strPath As String, strName As String) As String
' strPath - ������, ������� ����� ������� ��� �������������� ��������
' strName - ������, ������� ����� �������������� ����� �������� ��� �����
   On Error GoTo fnBuildPath_Error
    
    Dim objFSO As Object
    Set objFSO = CreateObject("Scripting.FileSystemObject")

    fnBuildPath = objFSO.BuildPath(strPath, strName)
    Set objFSO = Nothing

   On Error GoTo 0
   Exit Function

fnBuildPath_Error:

    MsgBox "Error " & Err.Number & " (" & Err.Description & ") in procedure fnBuildPath of Module objFSO"
    Set objFSO = Nothing

End Function

'---------------------------------------------------------------------------------------
' Procedure : sbCopyFile
' DateTime  : 22.06.2006 16:54
' Author    : DSonnyh
' Purpose   : ����������� ������ ��� ���������� ������ �� ����� ����� � ������
'---------------------------------------------------------------------------------------
'
Public Sub sbCopyFile(strSource As String, strDestination As String, Optional blnOverwriteFiles As Boolean = True)
' ����������� ������ ��� ���������� ������ �� ����� ����� � ������
' strSource - ���� � ��� ����������� �����
' strDestination - ���� � �������������� ��� �����, � ������� ����� ������������ �����������
' blnOverwriteFiles - ����, ��������, ����� �� ���������� ���� ������������ ������ �������������
'   � ��� �� ������. True (�� ���������) �������� ������ ����� ������ ������������� ��� ��������������

   On Error GoTo sbCopyFile_Error


   Dim objFSO As Object
   Set objFSO = CreateObject("Scripting.FileSystemObject")

   objFSO.CopyFile strSource, strDestination, blnOverwriteFiles
   Set objFSO = Nothing

   On Error GoTo 0
   Exit Sub

sbCopyFile_Error:

    MsgBox "Error " & Err.Number & " (" & Err.Description & ") in procedure sbCopyFile of Module objFSO"
    Set objFSO = Nothing

End Sub

'---------------------------------------------------------------------------------------
' Procedure : sbCopyFolder
' DateTime  : 13.06.2006 14:13
' Author    : DSonnyh
' Purpose   : ����������� ����������� ����� �� ���� ���������� � �������� �����
'---------------------------------------------------------------------------------------
'
Public Sub sbCopyFolder(strSource As String, strDestination As String, Optional blnOverwriteFiles As Boolean = True)
' strSource - ���� � ��� ���������� �����
' strDestination - ����, �����������, ���� ����� ������������ �����
' blnOverwriteFiles - ����, ��������, ����� �� ���������� ���� ������������ ������ �������������
'   � ��� �� ������. True (�� ���������) �������� ������ ����� ������ ������������� ��� ��������������
' ��� ��������� ����� blnOverwriteFiles � False, ���� ����� strSource ��� ���-�� � � ���������� ����������
' � strDestination, ������������ ������ ������� ���������� 58: File already exists
' �������� � �������� ������ �� ���������� Null ���������� ������ 94: Invalid Use of Null
' ���� ����� �� ������, ������������ ������������ � � strSource � � strDestination ����� � ��������� �������
' "Read only" (������ ��� ������), � ������������� �� ��������� ����� blnOverwriteFiles ������������ ������
' ������� ���������� 70: Permission Denied
'
   On Error GoTo sbCopyFolder_Error
    
   Dim objFSO As Object
   Set objFSO = CreateObject("Scripting.FileSystemObject")
   objFSO.CopyFolder strSource, strDestination, blnOverwriteFiles
   Set objFSO = Nothing

   On Error GoTo 0
   Exit Sub

sbCopyFolder_Error:

    MsgBox "Error " & Err.Number & " (" & Err.Description & ") in procedure sbCopyFolder of Module objFSO"
    Set objFSO = Nothing

End Sub

'---------------------------------------------------------------------------------------
' Procedure : sbCreateFolder
' DateTime  : 13.06.2006 14:44
' Author    : DSonnyh
' Purpose   : �������� ����� ����� � �������� ������
'---------------------------------------------------------------------------------------
'
Public Sub sbCreateFolder(strPath As String)
' strPath - ��� ����������� �����, ����� ���� ������������� ������. ���� strPath ��������
' ������ ��� �����, ��� ��������� � ������� ����� �� ������� �����
' �������� � �������� ������ �� ���������� Null ���������� ������ 94: Invalid Use of Null
' ���� strPath ���������� ��� ������������ �����, ������������ ������ 58: File already exists

   On Error GoTo sbCreateFolder_Error

   Dim objFSO As Object
   Set objFSO = CreateObject("Scripting.FileSystemObject")
    objFSO.CreateFolder strPath
    Set objFSO = Nothing

   On Error GoTo 0
   Exit Sub

sbCreateFolder_Error:

    MsgBox "Error " & Err.Number & " (" & Err.Description & ") in procedure sbCreateFolder of Module objFSO"
    Set objFSO = Nothing

End Sub

'---------------------------------------------------------------------------------------
' Procedure : fnCreateFolder
' Author    : Dmitriy
' Date      : 26.04.2015
' Purpose   :
'---------------------------------------------------------------------------------------
'
Public Function fnCreateFolder(strPath As String) As Boolean
' strPath - ��� ����������� �����, ����� ���� ������������� ������. ���� strPath ��������
' ������ ��� �����, ��� ��������� � ������� ����� �� ������� �����
' �������� � �������� ������ �� ���������� Null ���������� ������ 94: Invalid Use of Null
' ���� strPath ���������� ��� ������������ �����, ������������ ������ 58: File already exists

    Dim bResult As Boolean


   On Error GoTo fnCreateFolder_Error

    Dim objFSO As Object
    Set objFSO = CreateObject("Scripting.FileSystemObject")
    objFSO.CreateFolder strPath
    Set objFSO = Nothing
    bResult = True
    fnCreateFolder = bResult

   On Error GoTo 0
   Exit Function

fnCreateFolder_Error:

'    MsgBox "Error " & Err.Number & " (" & Err.Description & ") in procedure fnCreateFolder of Module mdl_FSO"
    Set objFSO = Nothing
    Err.Clear

End Function


'---------------------------------------------------------------------------------------
' Procedure : sbDeleteFile
' DateTime  : 22.05.2006 16:45
' Author    : DSonnyh
' Purpose   : �������� ������ ��� ���������� ������
'---------------------------------------------------------------------------------------
'
Public Sub sbDeleteFile(strFileSpec As String, Optional blnForce As Boolean = False)
' �������� ������ ���������� ������������ � ������������ - ��� �� �������� � �������.
' objFSO - ������ �� ��������� ������ FileSystemObject
' strFileSpec - ���� � ��� ���������� ����� (������). ����� ���� ��� ����������, ��� �
'            �������������. ���� �� ������, �� ���������, ��� ��������� ����� ��������� �
'            ������� ��������. ����� ��������� ������� (* � !), �� ������ � ����� � ���������� �����
'            ���� ���� �� ���������� (��� �� ���������� �� ������ �����, ���������������� ��������� �������),
'            ������������ ������ 53: File not found
' blnForce - (boolean) ����, ��������, ����� �� ��������� ����� � ��������� Read only (������ ��� ������)
'            False (�� ���������) �� ��������� ������� ����� �����
' ���� ��������� ���� ����� ��� ����� ������� "������ ��� ������" (Read only) � ���� Force �� ��������� � True,
' ������������ ������ 70: Permission Denied
' �������� � �������� ������ �� ���������� Null ���������� ������ 94: Invalid Use of Null

   On Error GoTo sbDeleteFile_Error
   Dim objFSO As Object
   Set objFSO = CreateObject("Scripting.FileSystemObject")
    objFSO.DeleteFile strFileSpec, blnForce
    Set objFSO = Nothing
    

   On Error GoTo 0
Exit_sbDeleteFile:
   Exit Sub

sbDeleteFile_Error:

If Err.Number = 70 Then
'    Set objFSO = Nothing
    Resume Next
Else
    MsgBox "������ " & Err.Number & " (" & Err.Description & ") � ��������� sbDeleteFile � Module objFSO"
    Set objFSO = Nothing
    Resume Exit_sbDeleteFile
End If

End Sub

'---------------------------------------------------------------------------------------
' Procedure : sbDeleteFolder
' DateTime  : 02.10.2006 15:08
' Author    : DSonnyh
' Purpose   : �������� ����� ��� ���������� ����� ������ �� ���� ����������.
'---------------------------------------------------------------------------------------
'
Public Sub sbDeleteFolder(strFolderSpec As String, Optional blnForce As Boolean = False)
' �������� ����� ���������� ������������ � ������������ - ��� �� �������� � �������.
' objFSO - ������ �� ��������� ������ FileSystemObject
' strFolderSpec - ���� � ��� �������� ����� (�����). ����� ���� ��� ����������, ��� �
'            �������������. ���� �� ������, �� ���������, ��� ��������� ����� ��������� � �������
'            �������� �������� �����. ����� ��������� ������� (* � !), �� ������ � ��������� �����
'            ���� ����� �� ���������� (��� �� ���������� �� ����� �����, ��������������� ��������� �������),
'            ������������ ������ 76: Path not found
' blnForce - (boolean) ����, ��������, ����� �� ��������� ����� � ��������� Read only (������ ��� ������)
'            False (�� ���������) �� ��������� ������� ����� �����
' ���� ��������� ����� ��� ���-�� �� � ����������� ����� ������� "������ ��� ������" (Read only) � ����
' Force �� ��������� � True, ������������ ������ 70: Permission Denied
' �������� � �������� ������ �� ���������� Null ���������� ������ 94: Invalid Use of Null

   On Error GoTo sbDeleteFolder_Error

    
   Dim objFSO As Object
   Set objFSO = CreateObject("Scripting.FileSystemObject")
   objFSO.DeleteFolder strFolderSpec, blnForce
   Set objFSO = Nothing
    

   On Error GoTo 0
Exit_sbDeleteFolder:
   Exit Sub

sbDeleteFolder_Error:

    MsgBox "������ " & Err.Number & " (" & Err.Description & ") � ��������� sbDeleteFolder � Module objFSO"
    Set objFSO = Nothing
    Resume Exit_sbDeleteFolder

End Sub

'---------------------------------------------------------------------------------------
' Procedure : fnDriveExists
' DateTime  : 02.10.2006 16:20
' Author    : DSonnyh
' Purpose   : �������� ������������� ����� � ��������� ������ �� ��������� ������
'---------------------------------------------------------------------------------------
'
Public Function fnDriveExists(strDriveSpec As String) As Boolean
' ���������� True - ���� ���� ����������
' objFSO - ������ �� ��������� ������ FileSystemObject
' strDrive - ��� ������������ �����. ��� ���������� ����������� ����� strDriveSpec ���������
' ����� ����� �� �����������
' �������� � �������� ������ �� ���������� Null ���������� ������ 94: Invalid Use of Null

   On Error GoTo fnDriveExists_Error
    
   Dim objFSO As Object
   Set objFSO = CreateObject("Scripting.FileSystemObject")
    fnDriveExists = objFSO.DriveExists(strDriveSpec)
    Set objFSO = Nothing

   On Error GoTo 0
Exit_fnDriveExists:
   Exit Function

fnDriveExists_Error:

    MsgBox "������ " & Err.Number & " (" & Err.Description & ") � ��������� fnDriveExists � Module objFSO"
    Set objFSO = Nothing
    Resume Exit_fnDriveExists


End Function

'---------------------------------------------------------------------------------------
' Procedure : fnFileExists
' DateTime  : 17.08.2006 13:06
' Author    : DSonnyh
' Purpose   : �������� ������������� ����� �� ��������� ������ ��� � ����
'---------------------------------------------------------------------------------------
'
Public Function fnFileExists(strFileName As String) As Boolean
' objFSO - ������ �� ��������� ������ FileSystemObject
' strFileSpec - ���� � ��� ������������ �����. ����� ���� ��� ����������, ��� � �������������.
'           �� ����� ��������� ������� ��������. ���� ���� ������, ���� ������ � ������� ��������
'           �������� �����.
' �������� � �������� ������ �� ���������� Null ���������� ������ 94: Invalid Use of Null

   On Error GoTo fnFileExists_Error

   Dim objFSO As Object
   Set objFSO = CreateObject("Scripting.FileSystemObject")
   fnFileExists = objFSO.FileExists(strFileName)
   Set objFSO = Nothing

   On Error GoTo 0
Exit_fnFileExists:
   Exit Function

fnFileExists_Error:

    MsgBox "������ " & Err.Number & " (" & Err.Description & ") � ��������� fnFileExists � Module objFSO"
    Set objFSO = Nothing
    Resume Exit_fnFileExists

End Function
'---------------------------------------------------------------------------------------
' Procedure : fnFolderExists
' DateTime  : 17.08.2006 13:06
' Author    : DSonnyh
' Purpose   : �������� ������������� ����� � �������� ������ �� ��������� ������ ��� � ����
'---------------------------------------------------------------------------------------
'
Public Function fnFolderExists(strFolderName As String) As Boolean
' objFSO - ������ �� ��������� ������ FileSystemObject
' strFolderSpec - ���� � ��� ������������ �����. ����� ���� ��� ����������, ��� � �������������.
'           �� ����� ��������� ������� ��������. ���� ���� ������, ����� ������ � ������� ��������
'           �������� �����.
' �������� � �������� ������ �� ���������� Null ���������� ������ 94: Invalid Use of Null

   On Error GoTo fnFolderExists_Error

   Dim objFSO As Object
   Set objFSO = CreateObject("Scripting.FileSystemObject")
   fnFolderExists = objFSO.FolderExists(strFolderName)
   Set objFSO = Nothing

   On Error GoTo 0
Exit_fnFolderExists:
   Exit Function

fnFolderExists_Error:

    MsgBox "������ " & Err.Number & " (" & Err.Description & ") � ��������� fnFolderExists � Module objFSO"
    Set objFSO = Nothing
    Resume Exit_fnFolderExists


End Function

'---------------------------------------------------------------------------------------
' Procedure : fnGetAbsolutePathName
' DateTime  : 02.10.2006 16:08
' Author    : DSonnyh
' Purpose   : ��������� ������� ����� ����� ��� ����� �� ��� �������������� �����
'---------------------------------------------------------------------------------------
'
Public Function fnGetAbsolutePathName(strPath As String) As String
' objFSO - ������ �� ��������� ������ FileSystemObject
' strPath - ������, ������� ����� ������� ��� �������������� ����� ����� ��� �����
' ������� ������� ����� ���������� � ����� ����� Path
' �������� � �������� ������ �� ���������� Null ���������� ������ 94: Invalid Use of Null

   On Error GoTo fnGetAbsolutePathName_Error
    
   Dim objFSO As Object
   Set objFSO = CreateObject("Scripting.FileSystemObject")
   fnGetAbsolutePathName = objFSO.GetAbsolutePathName(strPath)
   Set objFSO = Nothing

   On Error GoTo 0
Exit_fnGetAbsolutePathName:
   Exit Function

fnGetAbsolutePathName_Error:

    MsgBox "������ " & Err.Number & " (" & Err.Description & ") � ��������� fnGetAbsolutePathName � Module objFSO"
    Set objFSO = Nothing
    Resume Exit_fnGetAbsolutePathName


End Function

'---------------------------------------------------------------------------------------
' Procedure : fnGetBaseName
' DateTime  : 24.05.2006 12:36
' Author    : DSonnyh
' Purpose   : ��������� ���������� ���������� - ����� ����� ��� ����� (��� ����������)
'           : �� ��� ������� ��� �������������� �����
'---------------------------------------------------------------------------------------
'
Public Function fnGetBaseName(strPath As String) As String
' objFSO - ������ �� ��������� ������ FileSystemObject
' strPath - ������, ������� ����� ������� ��� �������������� ����� ����� ��� �����
' ������� ������� ����� ���������� � ����� ����� Path
' �������� � �������� ������ �� ���������� Null ���������� ������ 94: Invalid Use of Null

   On Error GoTo fnGetBaseName_Error

   Dim objFSO As Object
   Set objFSO = CreateObject("Scripting.FileSystemObject")
   fnGetBaseName = objFSO.GetBaseName(strPath)
   Set objFSO = Nothing

   On Error GoTo 0
Exit_fnGetBaseName:
   Exit Function

fnGetBaseName_Error:

    MsgBox "������ " & Err.Number & " (" & Err.Description & ") � ��������� fnGetBaseName � Module objFSOx"
    Set objFSO = Nothing
    Resume Exit_fnGetBaseName


End Function

'---------------------------------------------------------------------------------------
' Procedure : fnGetDriveName
' DateTime  : 02.10.2006 16:43
' Author    : DSonnyh
' Purpose   : ��������� ����� ����� �� ����� ����� ��� �����
'---------------------------------------------------------------------------------------
'
Public Function fnGetDriveName(strPath As String) As String
' objFSO - ������ �� ��������� ������ FileSystemObject
' strPath - ������, ������� ����� ���� (����� ����� ��� �����)
' ���� �� ��������� ����� ������ ���������� ��� �����, ����� ���������� ������ ������
' �� �������������� ���� ���������� ��� ����� ������
' �������� � �������� ������ �� ���������� Null ���������� ������ 94: Invalid Use of Null

   On Error GoTo fnGetDriveName_Error

   Dim objFSO As Object
   Set objFSO = CreateObject("Scripting.FileSystemObject")
   fnGetDriveName = objFSO.GetDriveName(strPath)
   Set objFSO = Nothing

   On Error GoTo 0
Exit_fnGetDriveName:
   Exit Function

fnGetDriveName_Error:

    MsgBox "������ " & Err.Number & " (" & Err.Description & ") � ��������� fnGetDriveName � Module objFSO"
    Set objFSO = Nothing
    Resume Exit_fnGetDriveName


End Function

'---------------------------------------------------------------------------------------
' Procedure : fnGetExtensionName
' DateTime  : 06.10.2006 14:20
' Author    : DSonnyh
' Purpose   : ��������� ���������� �� ��������� ����� �����
'---------------------------------------------------------------------------------------
'
Public Function fnGetExtensionName(strPath As String) As String
' objFSO - ������ �� ��������� ������ FileSystemObject
' strPath - ������, ������� ����� ������� ��� �������������� ���� ����� �����
' ���� ���������� �� ����������, ������������ ������ ������
' �������� � �������� ��������� Null ���������� ������ 94: Invalid Use of Null

   On Error GoTo fnGetExtensionName_Error
    
   Dim objFSO As Object
   Set objFSO = CreateObject("Scripting.FileSystemObject")
   fnGetExtensionName = objFSO.GetExtensionName(strPath)
   Set objFSO = Nothing


   On Error GoTo 0
Exit_fnGetExtensionName:
   Exit Function

fnGetExtensionName_Error:

    MsgBox "������ " & Err.Number & " (" & Err.Description & ") � ��������� fnGetExtensionName � Module objFSO"
    Set objFSO = Nothing
    Resume Exit_fnGetExtensionName


End Function

'---------------------------------------------------------------------------------------
' Procedure : fnGetFileName
' DateTime  : 06.10.2006 14:25
' Author    : DSonnyh
' Purpose   : ��������� ����� (� �����������) �� ������� ����� (����) �����
'---------------------------------------------------------------------------------------
'
Public Function fnGetFileName(strPath As String) As String
' objFSO - ������ �� ��������� ������ FileSystemObject
' strPath - ������, ������� ����� ������� ��� �������������� ���� ����� �����
' ���� �� ��������� ����� ���������� ���������� ��� �����, ������������ ������ ������
' �������� � �������� ��������� Null ���������� ������ 94: Invalid Use of Null
   
   On Error GoTo fnGetFileName_Error

   Dim objFSO As Object
   Set objFSO = CreateObject("Scripting.FileSystemObject")
    fnGetFileName = objFSO.GetFileName(strPath)
    Set objFSO = Nothing

   On Error GoTo 0
Exit_fnGetFileName:
   Exit Function

fnGetFileName_Error:

    MsgBox "������ " & Err.Number & " (" & Err.Description & ") � ��������� fnGetFileName � Module objFSO"
    Set objFSO = Nothing
    Resume Exit_fnGetFileName


End Function

'---------------------------------------------------------------------------------------
' Procedure : fnGetParentFolderName
' DateTime  : 24.05.2006 12:21
' Author    : DSonnyh
' Purpose   : ��������� ����� �����, ���������� ������������� ����������� ������� �����
'---------------------------------------------------------------------------------------
'
Public Function fnGetParentFolderName(strFileName As String) As String
' objFSO - ������ �� ��������� ������ FileSystemObject
' strPath - ������, ������� ����� ������� ��� �������������� ���� ����� �����
' ��������� ����� �����, ���������� ������������� �����������
' ������� ����� (����) ����� ��� �����
' ���� �� ��������� ����� ���������� ���������� ��� �����, ������������ ������ ������
' �������� � �������� ��������� Null ���������� ������ 94: Invalid Use of Null

   On Error GoTo fnGetParentFolderName_Error

   Dim objFSO As Object
   Set objFSO = CreateObject("Scripting.FileSystemObject")
   fnGetParentFolderName = objFSO.GetParentFolderName(strFileName)
   Set objFSO = Nothing

   On Error GoTo 0
   Exit Function

fnGetParentFolderName_Error:

    MsgBox "Error " & Err.Number & " (" & Err.Description & ") in procedure fnGetParentFolderName of Module objFSO"
    Set objFSO = Nothing

End Function

'---------------------------------------------------------------------------------------
' Procedure : fnGetTempName
' DateTime  : 10.10.2006 16:57
' Author    : DSonnyh
' Purpose   : ��������� ����� ��� ���������� �����
'---------------------------------------------------------------------------------------
'
Public Function fnGetTempName() As String
' ����� �� ������� ����, �� ������ ����������� ���.
' ��� ��������� ����� ����� ������������ myTmpFolderName = objFSO.GetBaseName(objFSO.GetTempName)
    
   On Error GoTo fnGetTempName_Error

   Dim objFSO As Object
   Set objFSO = CreateObject("Scripting.FileSystemObject")
   fnGetTempName = objFSO.GetTempName
   Set objFSO = Nothing

   On Error GoTo 0
Exit_fnGetTempName:
   Exit Function

fnGetTempName_Error:

    MsgBox "������ " & Err.Number & " (" & Err.Description & ") � ��������� fnGetTempName � Module objFSO"
    Set objFSO = Nothing
    Resume Exit_fnGetTempName


End Function


'---------------------------------------------------------------------------------------
' Procedure : sbMoveFile
' DateTime  : 10.10.2006 17:05
' Author    : DSonnyh
' Purpose   : ����������� ������ ��� ���������� ������ �� ����� ����� � ������
'---------------------------------------------------------------------------------------
'
Public Sub sbMoveFile(strSource As String, strDestination As String)
' objFSO - ������ �� ��������� ������ FileSystemObject
' strSource - ���� � ��� ������������� �����
' strDestination - ����, ������������, ���� ����� ������������ �����������
' strDestination �� ����� ��������� ������� ��������
' strSource ����� ��������� ������� ��������, �� ������ � ����� �����
' ���� ���� strSource �� ����������, ������������ ������ ������� ���������� 53: File not found
' ���� strDestination ��� ����������, ������������ ������ ������� ���������� 58: File already exists
' ���� strDestination �� �������� ����������� \ � �������� ���������� �������, � strSource ��� �������� �������,
' ������������ ������ ������� ���������� 70: Permission Denied
' ���� ���� strDestination ����� ������� "������ ��� ������" (Real only), ������������ ������ �������
' ���������� 70: Permission Denied
' �������� � �������� ��������� Null ���������� ������ 94: Invalid Use of Null

   On Error GoTo sbMoveFile_Error

   Dim objFSO As Object
   Set objFSO = CreateObject("Scripting.FileSystemObject")
   objFSO.MoveFile strSource, strDestination
   Set objFSO = Nothing

   On Error GoTo 0
Exit_sbMoveFile:
   Exit Sub

sbMoveFile_Error:

    MsgBox "������ " & Err.Number & " (" & Err.Description & ") � ��������� sbMoveFile � Module objFSO"
    Set objFSO = Nothing
    Resume Exit_sbMoveFile

End Sub


'---------------------------------------------------------------------------------------
' Procedure : sbMoveFolder
' DateTime  : 10.10.2006 17:25
' Author    : DSonnyh
' Purpose   : ����������� ����� �� ����� ������������� � ��� ������� � �������� �����
'---------------------------------------------------------------------------------------
'
Public Sub sbMoveFolder(strSource As String, strDestination As String)
' objFSO - ������ �� ��������� ������ FileSystemObject
' strSource - ���� � ��� ������������ �����
' strDestination - ����, ������������, ���� ����� ������������ �����������
' strDestination �� ����� ��������� ������� ��������
' strSource ����� ��������� ������� ��������, �� ������ � ����� �����
' ���� strSource �� ����������, ������������ ������ ������� ���������� 76: Path not found
' ���� ����� �� ������, ������������ ������������ � � strSource � � strDestination ����� � ��������� �������
' "Read only" (������ ��� ������),������������ ������ ������� ���������� 70: Permission Denied
' �������� � �������� ������ �� ���������� Null ���������� ������ 94: Invalid Use of Null

   On Error GoTo sbMoveFolder_Error

   Dim objFSO As Object
   Set objFSO = CreateObject("Scripting.FileSystemObject")
   objFSO.MoveFolder strSource, strDestination
   Set objFSO = Nothing

   On Error GoTo 0
Exit_sbMoveFolder:
   Exit Sub

sbMoveFolder_Error:

    MsgBox "������ " & Err.Number & " (" & Err.Description & ") � ��������� sbMoveFolder � Module objFSO"
    Set objFSO = Nothing
    Resume Exit_sbMoveFolder

End Sub

'---------------------------------------------------------------------------------------
' Procedure : fnGetSpecialFolder
' DateTime  : 22.10.2015 13:06
' Author    : DSonnyh
' Purpose   : ��������� ���� � ��������� ������
'---------------------------------------------------------------------------------------
'
Public Function fnGetSpecialFolder(intConst As Integer) As String
' ����������. ��������� ������ �� ������ Folder, ��������� � ����� �� ���� ����������� �����
' - ����� Windows, ��������� ����� � ����� ��������� ������.
' ���������� ��������� ������ �� ������ ���� Folder.
' objFSO - ������ �� ��������� ������ FileSystemObject
' ��� ���������   ��������    ��������
' WindowsFolder   0   ����� Windows, ���������� �����, ������������� ������������ �������� Windows
' SystemFolder    1   ��������� �����, ���������� ����������, ������ � �������� ���������.
' TemporaryFolder 2   ����� ������� ��� �������� ��������� ������.
'                     ��������������� ���������� ����� TMP.

    Dim sResult As String
    On Error GoTo fnGetSpecialFolder_Error
   
    Dim objFSO As Object
    Set objFSO = CreateObject("Scripting.FileSystemObject")
    sResult = objFSO.GetSpecialFolder(intConst)
    Set objFSO = Nothing

    fnGetSpecialFolder = sResult

Exit_fnGetSpecialFolder:

    On Error GoTo 0
    Exit Function

fnGetSpecialFolder_Error:

     MsgBox "Error " & Err.Number & " (" & Err.Description & ") in procedure fnGetSpecialFolder of Module mdl_FSO"
     Resume Exit_fnGetSpecialFolder


End Function

'---------------------------------------------------------------------------------------
' Procedure : fnGetWindowsFolder
' DateTime  : 22.10.2015 15:43
' Author    : DSonnyh
' Purpose   : ��������� ������ �� ������ Folder, ��������� ������ Windows.
'---------------------------------------------------------------------------------------
'
' ����������. ��������� ������ �� ������ Folder, ��������� ������ Windows.
' ���������� ��������� ������ �� ������ ���� Folder.
' objFSO - ������ �� ��������� ������ FileSystemObject
Public Function fnGetWindowsFolder() As String

    Dim sResult As String

    On Error GoTo fnGetWindowsFolder_Error
    Dim objFSO As Object
    Set objFSO = CreateObject("Scripting.FileSystemObject")
    sResult = objFSO.GetSpecialFolder(0)
    Set objFSO = Nothing
    fnGetWindowsFolder = sResult

Exit_fnGetWindowsFolder:

    On Error GoTo 0
    Exit Function

fnGetWindowsFolder_Error:

     MsgBox "Error " & Err.Number & " (" & Err.Description & ") in procedure fnGetWindowsFolder of Module mdl_FSO"
     Resume Exit_fnGetWindowsFolder


End Function

'---------------------------------------------------------------------------------------
' Procedure : fnGetSystemFolder
' DateTime  : 22.10.2015 15:44
' Author    : DSonnyh
' Purpose   : ��������� ������ �� ������ Folder, ��������� ������ System.
'---------------------------------------------------------------------------------------
'
' ����������. ��������� ������ �� ������ Folder, ��������� ������ System.
' ���������� ��������� ������ �� ������ ���� Folder.
' objFSO - ������ �� ��������� ������ FileSystemObject
Public Function fnGetSystemFolder() As String

    Dim sResult As String

    On Error GoTo fnGetSystemFolder_Error
    Dim objFSO As Object
    Set objFSO = CreateObject("Scripting.FileSystemObject")
    sResult = objFSO.GetSpecialFolder(1)
    Set objFSO = Nothing
    fnGetSystemFolder = sResult

Exit_fnGetSystemFolder:

    On Error GoTo 0
    Exit Function

fnGetSystemFolder_Error:

     MsgBox "Error " & Err.Number & " (" & Err.Description & ") in procedure fnGetSystemFolder of Module mdl_FSO"
     Resume Exit_fnGetSystemFolder

End Function

'---------------------------------------------------------------------------------------
' Procedure : fnGetTemporaryFolder
' DateTime  : 22.10.2015 15:44
' Author    : DSonnyh
' Purpose   : ��������� ������ �� ������ Folder, ��������� ������ ��������� ������
'---------------------------------------------------------------------------------------
'
' ����������. ��������� ������ �� ������ Folder, ��������� ������ ��������� ������
' ���������� ��������� ������ �� ������ ���� Folder.
' objFSO - ������ �� ��������� ������ FileSystemObject
Public Function fnGetTemporaryFolder() As String

    Dim sResult As String


    On Error GoTo fnGetTemporaryFolder_Error
    Dim objFSO As Object
    Set objFSO = CreateObject("Scripting.FileSystemObject")
    sResult = objFSO.GetSpecialFolder(2)
    Set objFSO = Nothing
    fnGetTemporaryFolder = sResult

Exit_fnGetTemporaryFolder:

    On Error GoTo 0
    Exit Function

fnGetTemporaryFolder_Error:

     MsgBox "Error " & Err.Number & " (" & Err.Description & ") in procedure fnGetTemporaryFolder of Module mdl_FSO"
     Resume Exit_fnGetTemporaryFolder

End Function
