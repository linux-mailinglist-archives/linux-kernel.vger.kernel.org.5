Return-Path: <linux-kernel+bounces-98350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 419DB8778BB
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 23:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD18C1F2159E
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 22:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72723B79F;
	Sun, 10 Mar 2024 22:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EMCPQ/XS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BYQNU15p"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95023B2BD;
	Sun, 10 Mar 2024 22:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710109007; cv=fail; b=UgVTkLvBp0moFB7VOICRdhwVHCSReMaUoaHqLfWq6TOr2qEhDkfj+Svlfb/9fYt6JXYa4Bg6HNjuCFIkl3O5qesgOvc8pm9jyEwbaoLe2H/wYNZMEBaCemjdb1Qn8gpV3fSI/dTPNnHGtPjd3LdaWASSqnnH22gbes7H7b51c5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710109007; c=relaxed/simple;
	bh=VxLsHKSUjShrJyoSrTGkcGaaO4dnCSIHjBxuItUOFfM=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=WZszlpJqJYTFCNtCUguu5NHcBQxxTwe9RYLNd8BTR8r6mwauFIqQzIlKLzExp3O683kfG8m53xoC2WfDLZpnM7CcckXvAo9nSfXM3SWpbw4pjHJPyeeB/Dly32CwiUII0V97DxK5lAtatXNDwmr9cilj1Mubn9p93bY/w1HQiq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EMCPQ/XS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BYQNU15p; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42ALt1Z3031725;
	Sun, 10 Mar 2024 22:16:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : in-reply-to : message-id : references : date : content-type :
 mime-version; s=corp-2023-11-20;
 bh=cZqOAFdsZaEjjF7TvrMZciDXS4fMySxl5am6XjGU2Go=;
 b=EMCPQ/XSKXQyy790ryw0RgoldK7/UKZi8xHFBjodrSptSbRePcD8SNJ1jX49VLsbL1zk
 QhuBOXoK8TEV8rB5CD9REA5qrB1oO7N0mVJ+b+9rspjTre0x5sg95usk+K2kUM/ODq48
 blsqhiQe7iNzV7ZJd+D3Q1a4UNAHSdavMzj1BxEf7f1p8kQXU6hVVSAozpG3BZYoPFcl
 qokA11yjZ7vl0mBZ/Y4+a8jFEhYzO0BmGGptdGOMuW8sm8bBSQCKWTVs3aYqisMC/MGL
 uxuHPILt751906yZ1gUcVRPxoLBbZgBs7rKSaIoPJjUEP1klJcR7f2gumBRFPMgaa1me ew== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wrftd9s0s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 10 Mar 2024 22:16:25 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42AK37BM038029;
	Sun, 10 Mar 2024 22:16:25 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wre7b75t7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 10 Mar 2024 22:16:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C6FTruHF70NQb3idQbG8D7YUdFaaPmPsZuQGCqY6gQ2BlRef9lSfHwYVzQYaOUxu90lbuDKKjX9v0HOaX3ph338wZ0tTrA6O/Q7c+8obq2Iptl6fOf80vkLp4x6ab5XjpLktz6YdTznLLQTo+aRbpGIXMhq3zWOPj1BDpCw3FC499CEh+cQ0kc175xSs80J35tPPh9a1glUY906irnqflYplahmTKLKen67zehlUQ34+UNA1wFLUvZX32I9LMB4NsQYVb4GrVLhwCYQWQdibf5QVny+c+tem15eg7FLu97mRKIACJafmsmsULocbw1F4jM3oDdwW5AAMTcWkqWjhgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cZqOAFdsZaEjjF7TvrMZciDXS4fMySxl5am6XjGU2Go=;
 b=I/FiIvXEVyO09uqWs47nZe9XkyqAOk52yWMn3RrKuMMPVwotg3+ghLlcDNgyvcs4hM2H6QikrwEhgfiMrasU9pMwNpDhH4iD+jqXkNTrLIGZwlA/omAG8toJsVwj39qxPOTiK0sOmLvw3OMrAIUQS9zXsO2YSdR+Y0k7vy7EBjjW0XrPS8NGZBVJOeB6sNuuTHRromlCwepFUDTrB9F5ZhpPv5hA3w1L9PoxjTRigJ0xC8UAYM6a+WNe0GeM2PnJofAi8MYxUjhBBIPn6/V0REbzaGgzqjetFk/8FQ8n5pjIkTDvpXBnW1eHo6lsqNk7abEa+cnDaut8Du5qlKq2kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cZqOAFdsZaEjjF7TvrMZciDXS4fMySxl5am6XjGU2Go=;
 b=BYQNU15pJsXe+Y94D6YWbRtQBOK2p5XTBnuIvAeITT+0NOb3AOVYoCgj3gOHVqNDrh7DWWJ9vPLyDMqUSSayKVPVn/ot1zGMTOnvBN3biDeneEefJaW+uNyFtHebBNGAhXHOMYLpu7AJLCFLFcv2faYXF4MGsnA6JQVJ9aOmEHc=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH8PR10MB6527.namprd10.prod.outlook.com (2603:10b6:510:229::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.34; Sun, 10 Mar
 2024 22:16:23 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::7856:8db7:c1f6:fc59]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::7856:8db7:c1f6:fc59%4]) with mapi id 15.20.7362.031; Sun, 10 Mar 2024
 22:16:22 +0000
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Doug Gilbert <dgilbert@interlog.com>,
        "James E.J. Bottomley"
 <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Manoj N. Kumar" <manoj@linux.ibm.com>,
        "Matthew R. Ochs"
 <mrochs@linux.ibm.com>,
        Uma Krishnan <ukrishn@linux.ibm.com>,
        Kai
 =?utf-8?Q?M=C3=A4kisara?= <Kai.Makisara@kolumbus.fi>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0/5] scsi: constify struct class usage
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20240302-class_cleanup-scsi-v1-0-b9096b990e27@marliere.net>
	(Ricardo B. Marliere's message of "Sat, 02 Mar 2024 13:47:21 -0300")
Organization: Oracle Corporation
Message-ID: <yq1v85td979.fsf@ca-mkp.ca.oracle.com>
References: <20240302-class_cleanup-scsi-v1-0-b9096b990e27@marliere.net>
Date: Sun, 10 Mar 2024 18:16:20 -0400
Content-Type: text/plain
X-ClientProxiedBy: PH8PR21CA0014.namprd21.prod.outlook.com
 (2603:10b6:510:2ce::28) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|PH8PR10MB6527:EE_
X-MS-Office365-Filtering-Correlation-Id: daba8f1e-de51-4552-211b-08dc414fb7e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	z0CwIveQY+NcH+yUboEciKzc09uKKUIUjhEdsbyCUIn1rXeuEs8HxG7LiLdLVu3SivSCkTrAOe5wK5UjCkNRem80cJ/lHc5GXOT13GR2uFbWnBLs1X8goGLRDj7OEOX4ACj231Yj4e8toeuLTK94x6zpNEKxBDS8bktEq6B2KaHD3jDK/6kPH6rfDuLrzOXVfE0xXIrZOyX1QGQE9phpvtO9VYfB5IYpdgM+niYu9iqY81bNS8KxfdX93WcymkyEzfBQpOWvATL+AJCIRUL1Bd8d02lWO5VdDfXOfrf/p6uQ/aWd0Ja9+2gJ5cLD8YTxVQYv49TA9sRmF0lT6yzdNufxZepjs1FcVrV1ZHRyGcvr0fBgun1XY4aFheSoUUBScKTXy481YJwncLjGZTRLjRGFWtD7O1DjOlkPf8emagNGUyr7mwt7rY1cuOIySXV00XFrRPKcccmBuFHklOu/ucAMD3YtGaSfRprLo7rdrn2ybSotXSN9A34FisVM3JhxP42Myz38owRx/hqNeFEm0XlWf/LCH2/nOUAtcSzoJlp5QfUI64TSo7td2J3SjHGNPUQYVbmAnZetDONPjC8w6JSDLUYps5ETuza6H8HlKU21TxakDMP6S77DNat11uLDVc4S25zbU2Vao6gvIMEvDtHwGW6ModHw1xCnxTr+nV0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?vy7hdZ5jzYzouOAKZ6AmLyG3iX2qNJdkKF1yI2k3z3ePb7POsTmIxPBBUEKf?=
 =?us-ascii?Q?iISG/MZK8RZHFiOi4TkTphkRMqsX8szOb8FjxVCMX9rXFO5HLyHTNEAJKsHR?=
 =?us-ascii?Q?npP8fDi2sPdmh4n2Kzq2AAjTygVepauFblqwIq6WzwhM2HpJ1LMTOhmixqef?=
 =?us-ascii?Q?pC65ftGGzw2IJ5OwkP1ivqwiaJv9pQ8Z0cr2oI02VORGRf5nhcmbV06CPVd9?=
 =?us-ascii?Q?/gmueKukp/6qXKIEuMgGRv+takvnsCr2v3W3Nc/bUbKrWhrSoLXp2Kof+x20?=
 =?us-ascii?Q?390AytkaYUmnFNM42p3q30nBnuzMqsmXPfzGMzqTv70d8Qjb4tuTVAFt6XP9?=
 =?us-ascii?Q?XKwiOAosKBzkfhfcnmOn8CeqdZOMjpVAPw6ltvQE+T8HtDrPDuKKFcb6th99?=
 =?us-ascii?Q?o6W9W6+uh88hU7b6Xd8VXORRGnlZx+Zh0HKlu8d4cBBUOzMYHNkGIi4GYPhv?=
 =?us-ascii?Q?wjUt1KOBxogZvrXrk0RnM1dFrPwaLf0nf9MXuF2Kp28YJt0UJ+egSC22ULUX?=
 =?us-ascii?Q?CwWUJdp+yp0aIJD96+yUJlYfr42niHYQp3gViPJp0nZa8jydp7MWJ+b+an1v?=
 =?us-ascii?Q?ei6sW9WU6xPyGbLN29ps7l5xbn8vzrZZgqab/Wr9G1G02GFVHdVunAhh5h+D?=
 =?us-ascii?Q?zv8L9AeG7b/LAea6xSaGdClaFYvJQDrWwT75NgMxNUSGadN0N97lhRA37ios?=
 =?us-ascii?Q?+uahDLobXVVirbo7sZ+X30sJKrGYWG8wwAD8wrcEte3llwZe/x8dUA7HrzLq?=
 =?us-ascii?Q?+pbMzx1C7iB0lnmPDGG1pZmO2Ue/vPZKqcURMlR0/Pu3JD9E+H3+/5d8icjz?=
 =?us-ascii?Q?De/A9WSXOLG2bwrYOlcbllXXvtWABlKW9s1465AJrDXl6Beu3O0f7b7zE4kO?=
 =?us-ascii?Q?fcM6kp05/D/0k2sHip1xf8vLTiQ5jAGRr11nkEy+8sNqAGp0LUoO9z9WSUHA?=
 =?us-ascii?Q?2DXrPQV+i5QU5BerlTLS0aqX8QP5qwkP4B5yiLCC0oaqSO+jLO+E0HUR1bMz?=
 =?us-ascii?Q?Axl9vcCG95uyFTu2aGRXUvyxttsi0Owv1scZmKGl59WPsB9fdJF5UFTmyJwC?=
 =?us-ascii?Q?vMnQFwdwY5+G6SPQj49fas21TtTCKjLnJIOkWvqPDmL6Jaz9Q9ecOspy8dK4?=
 =?us-ascii?Q?YUL81+x5Rhe1HmtYE91ud97u2R2nYYyCXD7X1YCX6RpCmjzzoNwKn2Gh8kPG?=
 =?us-ascii?Q?nElzdnTzd5f7WEOCh+HayAiis2G0LAo9JQ6jujVOoG4E5nANhiGUHiLYMuG3?=
 =?us-ascii?Q?H4WTE0ORLASgE1hvaJlHZ5rLtOF806eFX3wctGpsde6ECdM2BVNmZLE03DtQ?=
 =?us-ascii?Q?3Xv06o2iCbN//olcRn1yR9Ul0Sj4bWaQk/Ood7HH3jy+Ku48S4z6O2rLrmJL?=
 =?us-ascii?Q?aKdxVnAtYkc0vwzmAW/X4CjDHAIS5G5sHxCAckhrIdsaUJkrXpBZqsb3pjZT?=
 =?us-ascii?Q?no3SSVI3WczuoFd4YlnZHJ3oG709jsRTN6d/ar9QOIpdLaH7A2GDmzgRYrNl?=
 =?us-ascii?Q?0WYZfos7VgmewzjSv8UXGjUWBTa2hIvoonN4+JZ42Bq6/Hz6WXV0+yk9lg1w?=
 =?us-ascii?Q?Wr07YnsaXrOhIPljngsmuOUEqTUZ862V0RjcVSd+QP2ZAWJdWQcNy8mXAqOC?=
 =?us-ascii?Q?WQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Mh2JxndyYgN/XI6U6fkdp+Y0axZfrs3JKR1RvKrTQloJMShS2LpvyzfLCQyBtjzs6sVMnJ/ljo5/YJK3YYQDabaKl4kObeXC1amb9xA/MF5AWr/MB95pscQCmu/5YNN24dIshkaO/TMLDyIqH6R+tZhJRtuu4ezgJ02tNx1gydAYEPTEohhjQ/+JEas4xldOwG3WHzMuQmKZEyhDXxinRQ7mN00ZiTqNlGT/31WaCLZQyWJU28cz7uWsXdlyOt1KfHqAAwIqbLOK8OBsdkidjsBfQ4WQMCgvmJiRSCZgSQ3FHPb2IRn+XmDjzGS5hozhtm6F6Jkzpp4nhfXpwWOLFslpSQ14jXdUGo7o4yuTpOPyyUlUe5OPiZuP4y6mbYdUQ9ntTkjEUe+5Hi33SwtT3lZX23F2tXtfp2sOsq42HxmZEBgRhzlUbA1PSIX+hOFvf9StZ5bIr8puVtR4OMDBLAaq4OdEQBfnfd3srUBCoAdEXGPRDVTxgtLfOClOI6wfimeJoVRjfOTA0ahW6sq70y30+GKPcdpofmLbttDx/mxfIgF6z5JsDTq/qn+y8x9Cz3XeaPN5dHppOpH9wvJVFnm5xhKkvqNsLH8qXPdRz4M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daba8f1e-de51-4552-211b-08dc414fb7e9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2024 22:16:22.4587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qLs2MvNro0H68M28s+eleAtw+L9xnaKnhnWxEH/lIhG7WmUTmn3t7WyZ/P2MXrPZzhwzZ3hrYPcDlXnlDyQgIy9oqqZiRgRq/TtX/rd3IY4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6527
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-10_14,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=870 bulkscore=0 phishscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403100181
X-Proofpoint-ORIG-GUID: f7n3VDzuLA9bTNqBlHUt3kO5Wm4QtboS
X-Proofpoint-GUID: f7n3VDzuLA9bTNqBlHUt3kO5Wm4QtboS


Ricardo,

> This is a simple and straight forward cleanup series that aims to make
> the class structures in scsi constant. This has been possible since
> 2023 [1].

Applied to 6.9/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

