Return-Path: <linux-kernel+bounces-75435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2E185E8A3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 21:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4028C282CB4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 20:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA981272B3;
	Wed, 21 Feb 2024 19:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Pa+B9D9N";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ghTiKLu0"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873AC7FBBC
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 19:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708545293; cv=fail; b=O3mgRU+Ec24QVCpRcTu3VcGsLuD0XgisoH48B+OrtcdoitXwoxoJ9M+D7GtThGOn01aLHulhs31i7FY6rtlJA9U6+aLXc5CYhwc3FWhIqxtx0ShcIKOEGoJLUHnFbV+821qAcLUHYocKvtimdlr4kxB8Vvq4AJx34wjKV0bdBOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708545293; c=relaxed/simple;
	bh=kPxS4EAyairmy6xtzNF0NFQv/BrkCAo4HauF3H+AoZM=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NBDA5yOYrzLrGNyjPTc8VopwtxXA8TLYJ10myGCEaJpbP+pPqlHGIjO/reic13NoCmvSbVtwGtXQyfSGXgx1jg5yWxfc1xEunynJhIM+u4EidS4jUF4wgcTX2xR1Uee/l6eZAYAiP6ZLihuz4mnbtU0mJGDNNhuO8mmwvvUl5sg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Pa+B9D9N; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ghTiKLu0; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41LJLYmx018205;
	Wed, 21 Feb 2024 19:54:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2023-11-20;
 bh=NUvn77bzAJcWeR9Vm4nTJA/CBsD9YWAWBwtKHd9acXI=;
 b=Pa+B9D9NLYTCTnE8iwqZW6+45+fPGAJnagIscNWuXY6663bwUj+ameN4j3AsEHUQXewv
 2wplo+uCUQWphRuT8ZuxKR8FYEW6pDgZnV8sGtChoFDUDOlHaMKQC8RcvXE9C7rc4NRe
 +N9/30tWrCS+uZR1fr1H0AHfwxbBLkCL44BL3wcMuGWkLvloYTi3vfo8pAzUbVyOxKt1
 EZ1zRtk1XdV1emQQqEKbGDx1KbLqRA1FlFD4XVqA7k9gXRy3T5hhnlBWNlJlhDu0LBYk
 vN6q3Gbsq+npVaa+qF32GKFlnhP1xT2/kjuUnmWNukMaa/UpC2n9jmgbLtQRsFv15Z4y Ww== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wanbvjmg4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Feb 2024 19:54:46 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41LJVHNE039742;
	Wed, 21 Feb 2024 19:54:44 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wak89j7rb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Feb 2024 19:54:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZGVfye/PbVGQZ+1ep+iUEVXqtT3F154U5azTbukZYEo8F3zJb6uByVkCb7HvZeodyv/6iWQeA3yQ9w3mxB918NqXPuXgKpde1/7VN3+GM4BhlKonzSkwERjuikBqBZst2LzJd15lRG+V2yVz5Hfrm4IQPMw15smIHSzs+Ccr1ziPqaLmu6sXk8hoti5sivRkWsPPTrt3ciqPIPujC3S5cp6ZTuIDXDo+2XJI7UVqfpHXKHTX5QKoacrN93PZCcnllH7l5lUwoDrWHfFIOEqNgLWfhEwgBouhpKPMJ1HV/zXAvIw2sEuZ/CIB6nuRr2sK2rMweERWGXhLmhnMLyX0ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NUvn77bzAJcWeR9Vm4nTJA/CBsD9YWAWBwtKHd9acXI=;
 b=MBpk6nDfVDzZfKJVfLfX/+7SBFOa7YlYFuFEncrVQBrv0uN+Zi1/FmRHLd9OQ3iAJZeG12sGg8tGuSxSI/KUI9RrhKiyTBQx60B4SDZr0W7RBJ0PmRcKb9AxrccqLCjyfMU86gtO5t3/d2GB7llOdNzYJC7r/VJ1G0p0TXVbVpVxgfJWzLHpRQIbu0Lbw2GUzsR+/6dwzorHvhOnUuMNiVc9Vhiu5Ln0NH9Q5ItXNnlMxtbc6Mp2pJQQcNVdBTq1ccHasETiJRCKiA5XBbytWDDfKjtJJyaTDjtRiFcN/d4UeKa7QRdBKjrMdh68AH+7Ft6FkhJbKof2QZLyxaI4zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NUvn77bzAJcWeR9Vm4nTJA/CBsD9YWAWBwtKHd9acXI=;
 b=ghTiKLu0NVRzQfjQJA67Cxfp5GMspRjrgyYcdfx5jraUrFdoZiUKp4ONCUuuzaxRyr6qdzsZeg1j2JTJxCT7JlBVmlSBAEnF4ZPYcxlAx05URm49PSF+cpH2rIH6ZLpHva1dqy72iIL9HDA9YpA/VPhyM39F9yYg1Nk4SKWl2aI=
Received: from SJ0PR10MB4478.namprd10.prod.outlook.com (2603:10b6:a03:2d4::19)
 by IA1PR10MB6898.namprd10.prod.outlook.com (2603:10b6:208:422::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Wed, 21 Feb
 2024 19:54:43 +0000
Received: from SJ0PR10MB4478.namprd10.prod.outlook.com
 ([fe80::a37d:536d:d642:16be]) by SJ0PR10MB4478.namprd10.prod.outlook.com
 ([fe80::a37d:536d:d642:16be%3]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 19:54:43 +0000
From: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "x86@kernel.org" <x86@kernel.org>,
        "tglx@linutronix.de"
	<tglx@linutronix.de>,
        "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>,
        Keith Lucas <keith.lucas@oracle.com>,
        Andrew
 Brownsword <andrew.brownsword@oracle.com>,
        Dave Kleikamp
	<dave.kleikamp@oracle.com>,
        Joe Jin <joe.jin@oracle.com>
Subject: PKRU issue while using alternate signal stack
Thread-Topic: PKRU issue while using alternate signal stack
Thread-Index: AQHaZP+kqpoEJ0V8Y0CzEfRXd/T1Lw==
Date: Wed, 21 Feb 2024 19:54:42 +0000
Message-ID: 
 <SJ0PR10MB447870F586BFD2F326F55C819F572@SJ0PR10MB4478.namprd10.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR10MB4478:EE_|IA1PR10MB6898:EE_
x-ms-office365-filtering-correlation-id: 10d1be44-b07a-4152-4883-08dc3316f26f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 OmyF8Muy8cP3eL1A2xYefJzxS6wjdnRErNxRJ7OmaA8lTAcO+DTt9sbeD/wgr9QYdI+iA7ld1JvgMBWsS9u17gjL5QwS8LFVf+Ln3dkzWH2GzCRmfDMZXIo9hVUE/3+FTsbx8iL6zEw7gGz/N6bMkkWAN/53O2SX9wzHXnnE7a/NEDn6sJnzkOQkN/tSy3ZvBF8xaUrHoGM+aXYKgsK5WIbgQhDWACjbJFz9UlFUvSLV6bj/JGPtKPqbRlgjkwayOJvYGJZQH0USX1ggXij28jsBvqnATvJGvmsxHBmg5pJOyGvf2hu3/KOsp77ejtWgxUP+v7LZ2IBCRfoUx+0unqYEnRM2oezagz6MpAjqcAWqKPfaLzdGUvkTctclY9kfDC3doNduzBL29dDWVRvk6K+Z2KTIHZQ0K/LJE1rJ8aPkVNiT93ibZo7FWBZBdjScK5Nnb9AoNfyLRINOCpX062K4eHMtZ+fZKPyZw8OaPceFrgSoYau1EIL3xVcHyKRJLC3+iWNnm1PqfMQjWWfkpbbloQLntDFLuhLxxrXYL2jOe3YOAvP7AW8wpm3fxfpg9KhtstdgEhuLvfysJBHB+j5f1nivEZUqE+Y0kPzu0niuZXABBIUVmBwrAJ7cXWar
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4478.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?14VGpeiXOKiWpQJ7V2jTZcokPF+5FVqO+R77DZTlHbj6KAJ/yxv+MXpJ?=
 =?Windows-1252?Q?aXMLw7h4NRpbKWW82JP0LrgDLCtgzoFv7Ng9mqkrqRxuJsoVySI2AMdA?=
 =?Windows-1252?Q?5MhCRxtKKwJ5wfJKYNJp3FUsZF8hUrolL4CjNefbjXTfQqxXXUhTKtF5?=
 =?Windows-1252?Q?QfdhSWv/6HMj7FCQd6DxnCu4mPyafu9pgUWchoEs0yfgh+FHVIopbEaB?=
 =?Windows-1252?Q?9SbV42NvtuMSBkbRWXXuw4liGds+20BEHFfer3pHOK2zHPyleGNjTqkZ?=
 =?Windows-1252?Q?pwJdt5dHO+HrCZFqJ2MZMYDxuso8kspNIU8JxrTVhhwCB7bJPjZ2rgTp?=
 =?Windows-1252?Q?EsuuASMdXiOsniRURedp1SVSXX0W4jAgIJtCQNqUcsellA6mPL8w299N?=
 =?Windows-1252?Q?Hc7SzQeJntqleGCyTcP6PVgkYajlT/8dFOdD3js3cW/r/gdtgXv8kMyY?=
 =?Windows-1252?Q?YmDYhKIBElaqRWGnG1NvG+Omk+5laoKSBGBY96SMDvifUP4CRvkKKTKo?=
 =?Windows-1252?Q?nJKW74bfpwE9AcdeYjZdqQe5GcKZoNV70gW8NsQj8YOKxd6unsOoFgyp?=
 =?Windows-1252?Q?bV80wBDlK+P6k/VlsaPV+YwI32sOCosiVQtxfQXJaC3aW+7QMPp4vSSc?=
 =?Windows-1252?Q?RvHYyoq6xiQ+YFSEPaBIPxVuIwZcqN5WfZAGUFZCg7K5lRFXXWcer6dZ?=
 =?Windows-1252?Q?8VveNqzhsPVz9BTRHJ+Wax0r8R75AgPyJdR7X0feYcKkpfxcutvuueUz?=
 =?Windows-1252?Q?iKWv4nTlCRrt9ZjX7kE8PFazXYiBIzY5xhAE8RqxRG+gSULlxnOaadCi?=
 =?Windows-1252?Q?RVPh5uJUQO211GcMgt2XdTaw6pSLpbzU0EGSPWCBTS2X65fwqkuiloLt?=
 =?Windows-1252?Q?KBEeqbf8FFeBQdFTzxp0zUAZhXGcOB/7DlzCjqVjunZZ0r7VRo4lqGWx?=
 =?Windows-1252?Q?ZLOSv/igFzb8AbMOiAW3sWtz90LcMHEJTENjR3p4H+OEI3KAwQv2QHoQ?=
 =?Windows-1252?Q?uZVmVn0U8nDocj5vlT8jIAdRCX3MUMCFxI/PMUDOwuaeUBdSa4pO2/iq?=
 =?Windows-1252?Q?DDHmdKiS3QS4BX+872fsqcJ855YJz/L2vbA3a4HWxvhggkuTGE90SCop?=
 =?Windows-1252?Q?v9MhobmXctHdnwLB/ZQyeBqTFuepMQJmbPt3zIZfZjY8DQ2aauApJ6IG?=
 =?Windows-1252?Q?mGi7rYwH48nNGy+60TYPQ1NdMt3W2p8FdC5QWbtSjsBAda4ypUU+48JP?=
 =?Windows-1252?Q?bAaBrPcsuuwSMUd6eUBt7Ea73moMkliF6b3dkovUgh+7ZC+xml62j8KI?=
 =?Windows-1252?Q?fpKXc3VmKD45KW8QNFU5Ffp8ooex1+OaMyWhOEVUIA92eYdzhF+D7y3p?=
 =?Windows-1252?Q?7unL5cpO9XG22RRr0YnIFk4AbSEmdwPuWC1PbLSUZfP6eu3LqQafNLUf?=
 =?Windows-1252?Q?70NcauKvDiLwbu678PtT0NA8JhcnS4MV8DJSWyIz+kjdPLSuIRjpyxfD?=
 =?Windows-1252?Q?ggC7rkvyxgUEmsG40J5uzBi4gslmKPguiYP8rf0ODLUxL1v3eopVa4dE?=
 =?Windows-1252?Q?dRq4rEJ1DfHTL42N+n0L6UsYkyYD4BQVpbTInF+jbdD28an2n0TVBuC8?=
 =?Windows-1252?Q?3Nt72VHsHW8dPGBaZWRTRqq1fhzen2rpoDtS1V4JzzOyzUJaqmI0+jEQ?=
 =?Windows-1252?Q?srw1cRsOKYX9/V88kQOtIjQMnYhGsJzl?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	EMHJ1puiLLue6Uz4eb4unp3bScfFDoYOIQ/BJJijWYBhpYay9VFTVOXLcRkcriUl8S1li9eApG/phOWDcRGVHtRv+Wad2w4Y3Zq8uoDmYP4bdkmoBHzIduVEix3fXvosIBu/XmGxMEr8mEctQK1N3KG8e2mxhbxwqhfwbmx5POjxrJTeblsdE2e3jeXcKgUWSzj6rKCSGWL40zfTzRqZ2Fh/xCi7MqB3IY3jmxXocaGSPhmanHh2SAk1jHHYcvP1HfbYBps8AQWgq8DLIvVl0Sgyo6ur4l7zYAiTBUaIu1axRsf36sLSow8eAHuFEV+GK9X1WKszHKZ9j4FVTXIg/ghMN7EQJSgn+zCmAB0DSxdwlrFoM+WkhreU9lePe2sagP+0E3fCRkPjCIpS4DTeNnNYvAo8bJPr7vFgnK8Daz36OKXXvXY5sJMiGzV6TB6oVJvQvLiqADYhu+EpQdjIdrK7BK4DzXR8XsrUPzjbYaWLus27cvfppexBgy6To3KSyVqUBHO0AdAzAzEXC3Mov5KO/8S9iC+orXEG/0EN1oK2ymENuMP5GychpkAQP6fuMzYSAGDkulnroOrghzWCp3g3+9WiS5sqWyZWDcG3YOg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4478.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10d1be44-b07a-4152-4883-08dc3316f26f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2024 19:54:42.9119
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s2cces6SVo05EhCBXazrqRLyuC8mLyGWgUJkb7f/tmNctLO0CxYEmLvGCVVK+7vouu5+QIaedrlVtmfoBGmVpvF0snQQeIL050uIUe6CdTk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6898
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-21_07,2024-02-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402210155
X-Proofpoint-GUID: vcBpj65tQoxroMpWamT4OM6Ovo_5hHFJ
X-Proofpoint-ORIG-GUID: vcBpj65tQoxroMpWamT4OM6Ovo_5hHFJ

(Re-sending to the list, previous email had some formatting issues. I apolo=
gize.)=0A=
=0A=
Hello,=0A=
 =0A=
We=92re running into an issue with delayed PKRU update for signal handling,=
 for which we don=92t have a proposed solution yet.=0A=
 =0A=
Our use case is this:=0A=
 =0A=
The application has many threads that runs code that is deemed to be untrus=
ted. Each thread has its stack/code protected by a non-zero pkey, and the P=
KRU register is set up such that only that particular non-zero pkey is enab=
led. Each thread also sets up an alternate signal stack to handle signals, =
which is protected by pkey zero. The pkeys man page documents that the PKRU=
 will be reset to init_pku when the signal handler it is invoked, which mea=
ns that pkey zero access is enabled, and so the alt sig stack is protected =
with pkey zero. But this reset happens after the kernel attempts to push fp=
state to the alternate stack, which is not (yet) accessible by the kernel, =
which leads to a new SIGSEGV being sent to the application, terminating it.=
=0A=
 =0A=
This is the relevant snippet:=0A=
 =0A=
In handle_signal():=0A=
 =0A=
..=0A=
        failed =3D (setup_rt_frame(ksig, regs) < 0); <- pkru reset should h=
appen before this=0A=
        if (!failed) {=0A=
                /*=0A=
                 * Clear the direction flag as per the ABI for function ent=
ry.=0A=
                 *=0A=
                 * Clear RF when entering the signal handler, because=0A=
                 * it might disable possible debug exception from the=0A=
                 * signal handler.=0A=
                 *=0A=
                 * Clear TF for the case when it wasn't set by debugger to=
=0A=
                 * avoid the recursive send_sigtrap() in SIGTRAP handler.=
=0A=
                 */=0A=
                regs->flags &=3D ~(X86_EFLAGS_DF|X86_EFLAGS_RF|X86_EFLAGS_T=
F);=0A=
                /*=0A=
                 * Ensure the signal handler starts with the new fpu state.=
=0A=
                 */=0A=
                fpu__clear_user_states(fpu); <- pkru resets here, via pkru_=
write_default()=0A=
        }=0A=
        signal_setup_done(failed, ksig, stepping);=0A=
..=0A=
 =0A=
Failure path: setup_rt_frame() -> x64_setup_rt_frame() -> get_sigframe() ->=
 copy_fpstate_to_sigframe() -> __clear_user() -> fails, with SIGSEGV and si=
_code set to SEGV_PKUERR.=0A=
 =0A=
The PKRU value is reset to the default (enabling pkey 0 only) in fpu__clear=
_user_states().=0A=
 =0A=
If the pkru_write_default() call were to move up the flow here, before copy=
_fpstate_to_sigframe(), then the signal handling would work as expected. Bu=
t this code/flow is quite complicated, and we=92d appreciate some expert op=
inion.=0A=
 =0A=
Thanks,=0A=
Aruna=0A=
 =0A=
 =

