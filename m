Return-Path: <linux-kernel+bounces-96950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B73876385
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7677282778
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A8F5787B;
	Fri,  8 Mar 2024 11:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QJwNPjmW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hKudWT3l"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1835644D;
	Fri,  8 Mar 2024 11:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709898265; cv=fail; b=TWJj0j/jQseY2utmjwwNV2BquLGJ1ScCJcTgHC+1VeBFPOvYEsOW2Bbj/RdkR3MzRDbZFQ3UExeKS81R0LLbTaTotS3NIOiZNnGqqo2WgPaeTk3GV9P7XCt0PEKhu8uuu4u3NNXYnlJdw7C7WlON/ASJN1omL1sjPRkksC/UW+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709898265; c=relaxed/simple;
	bh=E/dcPLu6Lz3El0S8QZ/uNzCIBRsJxjHj+Xbbvi86x/E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A6dQewc7wC2Xe7D+akPyGuBS48+ZHrWpwGA/ZUTwVKsOL472Qiayw/jNCUB89zsXAn8kWe/A3+mEwJsK9v8eKFpJlVowUVAnGBFa1nNWqQ0gwOcgnMRdsKRkNeycWWcaliRABl5N9oXMj4mSk2uNK7h626ZFm/bvJV0hSNFDpmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QJwNPjmW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hKudWT3l; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 428Ai3R0013363;
	Fri, 8 Mar 2024 11:44:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=gEMF2c8+1quWP4bKrF9MGgTKynTT0l3MT+qkfrZl60A=;
 b=QJwNPjmWXLDgc+aZoBzm7crXw0cLjs/pJlRFSwgdQJwOP4nCK2XR599BFIzLNBI+Y+LS
 bQ5wUuZoVnKHfC068oA7rb6djCjKYr4FRhDkocUxC0Y0i7xxo2LH2pQXhndJWXsK0j1l
 JP7dRqL+uV/0Df0MTe2pQCcBV74ed3pRyKH2VnJIjHMFRqgaiLo33t1dkXyw3dLWGWlY
 ZuflQdmUXKJVG+I7JwE4aabfcmGrtcd4nXvbcFHEtJuHxVj3yWSMoTGCn3qb9pGXtJNJ
 jzBPoAo+xDJll9xnoI4OzMgmTLuHVfk9Ey0w1dmf98nvAZjqk9aZVcZYNTs8Q9oPgUXp LA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wkuqvpk88-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Mar 2024 11:44:03 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 428AveFi015993;
	Fri, 8 Mar 2024 11:43:55 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wktjcpmv3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Mar 2024 11:43:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IaTwgou4By6A7BCpdrDfELu6ZWkF1Au8xfp/D42VRi7CQ3xPjmDUFhKoo3fHaK7GgbowrfZKP0tr7b6KsbfMhpM0rHS34UzI9zEyv8MTEdLvm14m20eaYg7irHI2nl6Fbx7rfN8EuLEV1Br+fGMpikj9gel65OpDR91gKG/i7uUuZQ4LLJVvIVd9aouq4MVrd33nsQ5V+9VWxzy9bHNofk7KMv/mEk/dxyjVg8OSPuDCEyiaP7iY+05uxfIJIqixflUgL9pXgOz1X5Zac9tTpCglVS8xkynkOhCgjHIMzE13uwr/AurbPfE7YVcIVewNCRfwVo21jss1eF5/y/55tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gEMF2c8+1quWP4bKrF9MGgTKynTT0l3MT+qkfrZl60A=;
 b=eJ49/VAw8F0zxLJ157zE2zQAfXx7yEvPCJbPp1Ee9omxv9QAnipUCH24sylfYGZ4kZzjnwPNZgYkYBZssSnhvzR6g6DFBPEa5ruLXdp6HQueE/SyJmeJbZVo4XzfaQ/yVVURxyR3OqR2JloL3DVIFA02yBsxwgqm85sts0Paq5gdsjNjjcg3BR9rIjfXWBseBwYDxnV2BAA9jNPOI1/ihxjn+rN3PmEDV4SqfE+YkETiBSGTYjKCCBvreQwpAofP+P/ZiV59UNtDUhUK2zmZSnJE6tJcT+wkhLwfnt9WUg7rpstzXzCqvUg9kzGJ1GDBLy0vgl5mvP2jlJstcqigKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gEMF2c8+1quWP4bKrF9MGgTKynTT0l3MT+qkfrZl60A=;
 b=hKudWT3lKgsA3et74lHWAnCjfbO4RUuD16xlZXS2735FQ877rKIsqr9wsPYHeEvzCNZcXkyiNxsEp1W0FxZEzUciZE1Z/8iyy4aj1UFlqIh4bbD8+JxgysoJM9rm+JVMW3zH5jyxIGA0CILsRewLWxwA0qYvNBGO4GR23POBe4A=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CO1PR10MB4595.namprd10.prod.outlook.com (2603:10b6:303:98::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Fri, 8 Mar
 2024 11:43:53 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324%4]) with mapi id 15.20.7362.019; Fri, 8 Mar 2024
 11:43:53 +0000
From: John Garry <john.g.garry@oracle.com>
To: jejb@linux.ibm.com, martin.petersen@oracle.com, chenxiang66@hisilicon.com,
        jinpu.wang@cloud.ionos.com, artur.paszkiewicz@intel.com,
        yanaijie@huawei.com, dlemoal@kernel.org, ipylypiv@google.com,
        cassel@kernel.org
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 5/6] scsi: mvsas: Use LIBSAS_SHT_BASE
Date: Fri,  8 Mar 2024 11:43:38 +0000
Message-Id: <20240308114339.1340549-6-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240308114339.1340549-1-john.g.garry@oracle.com>
References: <20240308114339.1340549-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0140.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::25) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CO1PR10MB4595:EE_
X-MS-Office365-Filtering-Correlation-Id: 570687db-77cb-415c-7c02-08dc3f650785
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	tVEN5I2ZL0pM1bjKQw/YOeFOKmYUD4eQ43A4ptoHyhqYP96ZStim/ro7HULFcyIxJhhPF3SwGhQfqlw+JCEqIbXL5dF+pE8qOHWOuNcwr7BdDkVErgfKAKv157b57/cKPvudCyMxwZO5aRsduHZ5aCZYWDVU3rDZMvN3/RK0daxA6CG7h+0H5uvQM+fktrPOUdaIdLYzYTjis45gTBNI/EvoLGM6iBTRt905MP/9fgxT0D7Ok7ngTO9E+VHFQTSLLHJIpefpm9cFT9uPsOplzOmOm5BdNTWtXmO4odUZRve8W91ZCZTRiIPXPWRPCwVb0cZi0aZv5VCKFwH7Ail9y/lJhXBJVAbO9Di70QXOZDmPSG4+4L9qCeEyEedadQzBPw46lmFsxYTpsdJGUCOEFzMi933N4SkzTuShB9m33eGo4qOaiXfE1ZNzU+2jQH/cV5vaK+P2mewCagY3+8WVwXXLkLpuLsv+ro95EJTm8yfRQ+MbW/TT/tQnbb20tizOyMkKP7tpdkp8u06UNFjTUcFHFK/fmTHn1OpLRbSdRq9IqqBomSyH+XApd6+BjWoq47K7+nPzU5dyAlVf8ZGD6LchagvUqcXgwYISiknggRRdOlt+gaM16hYv5dZtAQhqazP1tx2Sa1tpBqqMRY4Jdwin5cOL3AfH+GIZ4Ij4jWw=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?QA1T3kjoyUyrUqCKpP4Y2iXY8PnPFFFfbtphTu5QFjIaNR8E/guudLc+CRM5?=
 =?us-ascii?Q?X+G2qSeR4pWo6D9xuqqwf722/c3VAeS++t1ZTA/cbV/2ynOp9f0aJ4i02HTD?=
 =?us-ascii?Q?jLReieYGAKAxl1PqxXr3bU9nVdcUkT/n+g3wbCfgYnbfUuU3l5u4BB33++Li?=
 =?us-ascii?Q?lPKeBTVx614A54HxIDWENTtUsLviWRkJauA4GkiWwlCqx6X2N5mGnY22XPKH?=
 =?us-ascii?Q?aW4u5/7hb/sMxfpOSqPbcI7FGhTDGoVt04o76lNh4A+TDd/PHcdX90GarJZS?=
 =?us-ascii?Q?fE3FthLXqJQ1mWWFffEBC2RbgxW+k3vPDuewjvYMYHEgfBJ4eP9+smT40Bgx?=
 =?us-ascii?Q?xpUk+tWs8oUlyqVHRaUOCFZgzzQWMvYILoVSsPC8OwXog0FoThTtMfoS+l2H?=
 =?us-ascii?Q?uD9tMziVgkTciAQG3WnzgwaQIbEOgdydDEiySFevqpkHmP+KRbGGDaGIJ7Nl?=
 =?us-ascii?Q?OPLnkgBCGA8AbkVn43rRqxojzA3bR6JzPMvQQ8pggdQS/8bhWLTVWo9MD27D?=
 =?us-ascii?Q?HmtPkBOObmm0Nyr8t0cWG4StzP18NhCNEi/8nG90DjvVn6DNZ31ewSg6S8S0?=
 =?us-ascii?Q?SUGxLbMo6i/RxhOxSXfBnnpEdnZpUIDhO4Po2ppj1bB3RNc1cHOoGJ3jVrAh?=
 =?us-ascii?Q?GkZp0NhFypc5l3oU5/P3Bywr9D83Tbk+7LH9x1RfdnCl7bXyHQlitTM6QERb?=
 =?us-ascii?Q?geoBoUqOh5cQPWuLWmannXd9Hq1/OdBRIO+ip5H9yUgoioiOKrIDx7G1lopu?=
 =?us-ascii?Q?rBOencuXYAXTS8fLpjLUTwsEplM+ueBXi/prddXvHl81qkvmtqPqkzqB3WxG?=
 =?us-ascii?Q?W0HH3SQZMvLBDhM5w4SizLkgfNRJCVBEhsqCir/N9Ac+Vcb03f58qLtwSgGr?=
 =?us-ascii?Q?ahKdZ+hNfJTn9C5e6HgcoQ1806v2LPdDteJ+guKvVhfRl/Q909E+q95AoEaf?=
 =?us-ascii?Q?GOasTY4j48uhPKnMyGrs/RGdQ67Hwd0lxcMmq5sjVVEIBtJCw2AbvLtLZuzU?=
 =?us-ascii?Q?URjdGaD9Tujj3PNDSEoCZ5KlUmviah7lVGAi9Rm3ZbHn1KOOYk6rzXg40sPZ?=
 =?us-ascii?Q?9KcZ8zfD1yAQ0L7g86W80QRfconOUnXtvHGCgZBGj68FQ/xcnVXkRX1VbzEY?=
 =?us-ascii?Q?6QSkuzRqRMtrTB1lbALdsDGtvbSSF319IeYVjx1q5ItpfyamO3Vqgw0UjgXI?=
 =?us-ascii?Q?ISRXr/3q+KU30USAkxUSk8RWxn7dXqav54ZO5rgagTGmeGMuLvi4aa8MZVUU?=
 =?us-ascii?Q?W+NINO7p5k1RKPiaO6DmSNMAk7/P1xaNhwpY5mhHyHnDr9+ls9Lym+CO0Yq3?=
 =?us-ascii?Q?iGHixN8XqotmPXaguHlcoKJq/Fr5G7odv1P9ObYxRK3qC0GG8nSh1dX/3wHG?=
 =?us-ascii?Q?NE7OScKoF1XdMARuIEgCre5f/fV30k00vUOBu237g9LVgNGsr96+103h5GDH?=
 =?us-ascii?Q?3S5mCxfWui77fdOwZVYz9+4wDS4WNqy6uA62H/7xpm9jMGGHlewrgX95m6MG?=
 =?us-ascii?Q?FTQZ3Qxb/IVH3j4adRjIAS+kxQ9ItoSJLZjijDsLwk9QgXoSj2PhO9zkE87c?=
 =?us-ascii?Q?7UwV0RJDB4/E5SphLp2GReD6weKtGFitq6+4YMlq6jtpWLP9+BUeQM6Tc7ZA?=
 =?us-ascii?Q?4A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	2h4Pu5eRvPlWum8mgWwENmVNhjPppwm6Rvl6w81XGdhlNRE4jAujKVnuDcie2eqZwG6kVH8PwOm4mqA3JY6715kytdqrRzgRUoND36NpTRkWJqk8sj6COri8WOAgEJbgITVl7ozXbyefAnYUWh/l9GAJviedhndlvaIou+sKpNWTWTM1xMUzTxv4XJOTMwSLOnTstBiLWQrwC1pm+atTZauE6KKcpO++9K3CLqmow7/rlKmSbc+BjznzwUxiyrF35QTdFso+cOtKNZmW34j3UbwdCETcBgipA4EYXOZG4u3FRHxqphZ3Wi3W6cCddyiMY4rC46+aW+5DIxFg2a/gaeNzOcBNTKue6PNM2RPdu09gJFkEfYfNIjSibY/oqkqhsE0V6YHVhnJqNwZcLbfQ1miyoSUtJytgzyGEkfVi22NU28W5p9GbLOa8i6Vx11WhNy6hwLL/1ADSB1t5RFMT3JuQftSeLdYIzpxg6Ef4giSwnLkVK8ljOaV1ubcsivqejVPkUICA0MWs64RPFI19wFw5lgOSW4EU889uXJLbKeo/OJkMvLscSa+dCM7zz9o8GHPzxXaeHjIu9AgrshdBaaxA1CTU6Ydd4hSf1FKv4AU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 570687db-77cb-415c-7c02-08dc3f650785
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 11:43:53.1301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SniJ6dP2u0sMEjCPMUEPc9oSveRORA9RANjRnoLHyo6SbeBUVXvVgCfcBVsk1vryDhNgKWA1iUfqRa6mwC3CeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4595
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403080093
X-Proofpoint-GUID: FEL7vWrqnaMGiEZ2F8HXmcW0dHJoDQkn
X-Proofpoint-ORIG-GUID: FEL7vWrqnaMGiEZ2F8HXmcW0dHJoDQkn

Use standard template for scsi_host_template structure to reduce
duplication.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/scsi/mvsas/mv_init.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/drivers/scsi/mvsas/mv_init.c b/drivers/scsi/mvsas/mv_init.c
index 43ebb331e216..fb81d267c9cc 100644
--- a/drivers/scsi/mvsas/mv_init.c
+++ b/drivers/scsi/mvsas/mv_init.c
@@ -30,28 +30,11 @@ static const struct attribute_group *mvst_host_groups[];
 #define SOC_SAS_NUM 2
 
 static const struct scsi_host_template mvs_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.queuecommand		= sas_queuecommand,
-	.dma_need_drain		= ata_scsi_dma_need_drain,
-	.target_alloc		= sas_target_alloc,
-	.slave_configure	= sas_slave_configure,
+	LIBSAS_SHT_BASE
 	.scan_finished		= mvs_scan_finished,
 	.scan_start		= mvs_scan_start,
-	.change_queue_depth	= sas_change_queue_depth,
-	.bios_param		= sas_bios_param,
 	.can_queue		= 1,
-	.this_id		= -1,
 	.sg_tablesize		= SG_ALL,
-	.max_sectors		= SCSI_DEFAULT_MAX_SECTORS,
-	.eh_device_reset_handler = sas_eh_device_reset_handler,
-	.eh_target_reset_handler = sas_eh_target_reset_handler,
-	.slave_alloc		= sas_slave_alloc,
-	.target_destroy		= sas_target_destroy,
-	.ioctl			= sas_ioctl,
-#ifdef CONFIG_COMPAT
-	.compat_ioctl		= sas_ioctl,
-#endif
 	.shost_groups		= mvst_host_groups,
 	.track_queue_depth	= 1,
 };
-- 
2.31.1


