Return-Path: <linux-kernel+bounces-92365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B6E871F21
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EB29B247F4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168105A7A2;
	Tue,  5 Mar 2024 12:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dPbnjh56";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wFFR2G7Z"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDC25A782;
	Tue,  5 Mar 2024 12:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709641546; cv=fail; b=Aiu7OOAO/wg4ypwGlwJsfN/Hbsl9IlDhMJoa/9zfVIEwSsBWA6SVGCwYZ/TK7+CUpjXIvpseQ5qt1Jv1iAVQxJDautqm0pyp47mZCCV/Nuz3CzN1O1XyMrwo4mJ/lVMIBgusi2LMkCEx1D1OdQRQXnXSukqw3KmYBXetSHTBzDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709641546; c=relaxed/simple;
	bh=J+HUoIPe64MNmCWEjIY8rByj/JZdON21xNbDlAMXEPk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Wd3xXTnE+6y+tv0+gPK8fTkFRDrh5J1LPkawM08JRDqijW87++wCR2N2s62/xum66xhcsoTP8oDbvBXXjrqcwKAMaxaQK9WaubeGJbX79cAn8DiUKly7huwQN5Y1Nc/Sb/yaJdAHUcmDvCeRaV+8ZdeAcM443m+VK6BLqFt/m4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dPbnjh56; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wFFR2G7Z; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4259hjct008661;
	Tue, 5 Mar 2024 12:25:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=xYkRLZfVHfuOdW6TM0xPCxKwhxhbBH+gJXagOvV95Mc=;
 b=dPbnjh56J9ZFVQy8EDwjz056ZCwBocUy+4oVvCRVg2OwQbn3zjblg8X/IgwpckwI0KIE
 XmB7KUjeYxfSv7x1zKpUi7svLHnChQrMeGwspJim4RKy100XNq3FdbuLWmwIP0KfPYmR
 SipIcBs160NLixtY+m7TGnROJoaN0ZXfczS4E+TfOUEoLxq7Ov63kD+UK3eIcn/4ljq0
 lzmHiFJ5uTBPvRl9+I0MQMBir+v5zZogkYlrnHKuqFQmd+9KYaaH9X0pbZNdIhvrPYgu
 0hiJUXcW8YzcWFqDRwrFTB1nYmTuOrtD3sfF5gdOTq5PqEPaYFsTFCum34Wgierp+BsZ XA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wkv5de71j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Mar 2024 12:25:20 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 425BXVtD012259;
	Tue, 5 Mar 2024 12:25:20 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wktj7fs0w-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Mar 2024 12:25:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OzcERrKe4yE7gqgIEJCCKlRws0k232522Up3mhQ3f510AekJFoE4rc+SmEjWLaS+zQiV1i1J6CeMWL5xqHIfx7LJpP4IN0fAjtXhGkLgtrWFeydEf2kQu+2CsJGE2i8KLpNIS+qGb+4+jFAHtvRnpBcIddmTt0UB49rIGVNft+dz9SdAP5NX0SJleMSSC2yMFPr09vEjuWBoR2hmTFdIdlHH3T/RZpBYgig1CcKLrNz735w7dhKKeE6PtSE/bEOIMHISOQC5bdxZ1Zit3rxQizxwJfetBkZw3nJ+XSPNb2DfuG8wxiTCgBB2komdIVfamoLulRxfDJLexU7TKeLK2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xYkRLZfVHfuOdW6TM0xPCxKwhxhbBH+gJXagOvV95Mc=;
 b=KujtxEueg1BUcUYIyjjIkM/ElJGqScxl46USc6w8GlnPQF+JakIx2iAlNUHWmrYZ+MdtELCQQMx2cttuqKAArTIQR7kQxmPwSJkwRguE2n7JjLUuRf/V7IvR8/0LURQ/p5mw/UvQvpE/Ajz0wf8KbHMy7AjVFAZfLnuXyXzoiobH7wNLeKgWtD8eu+i2mBS4GvuxF2fMh/8JGrRzFR7d/k8GMMmhL1gAS/eKGLb/iSI5dBu9fkIhzsOEF4NwBiIwTu0kn1K/EuvNOR6FFoXhU4SxNj2OcG/PV57YUaepvCiiUj1HMtgcEarZF7FCTjvIHc7+uxUsl5yrz/a8oEIwaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xYkRLZfVHfuOdW6TM0xPCxKwhxhbBH+gJXagOvV95Mc=;
 b=wFFR2G7ZmSTiQtvbFhQl/+o45e87KoICDs76jBn0i+eTTx59wJI2YkjHwRSB5Mabzbvg+nZWNnoGhcZCw0yw3dHIF+hYoliVKPKYAhiiUOHQ7qP4HpAMAhiO457abwvPxEaS0vPZgcyFnGcXjnWQSKBJX3ebMrOKbxWmqBpNLOs=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB6507.namprd10.prod.outlook.com (2603:10b6:510:202::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Tue, 5 Mar
 2024 12:25:18 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff%4]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 12:25:18 +0000
From: John Garry <john.g.garry@oracle.com>
To: jejb@linux.ibm.com, martin.petersen@oracle.com, chenxiang66@hisilicon.com,
        jinpu.wang@cloud.ionos.com, artur.paszkiewicz@intel.com,
        yanaijie@huawei.com, dlemoal@kernel.org, ipylypiv@google.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH 6/6] scsi: isci: Use LIBSAS_SHT_BASE
Date: Tue,  5 Mar 2024 12:24:52 +0000
Message-Id: <20240305122452.340471-7-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240305122452.340471-1-john.g.garry@oracle.com>
References: <20240305122452.340471-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR08CA0026.namprd08.prod.outlook.com
 (2603:10b6:208:239::31) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB6507:EE_
X-MS-Office365-Filtering-Correlation-Id: e64776bc-90ea-4583-32aa-08dc3d0f5198
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	5T0qAOpx8LfSztoB4yOS4i5O6QkTuAnld7viA8SwdIEiqy6kknHuOfWxsLmBzVdssgZFVDll49KaUpyDNfTbRDEUDDQeQcDnCVC77fZ8WNJ6jXNEdAOzexWCf63DL9RPjmzbZzaqdBW4+LnPq4obi2OHMozVwP++SIYRlddoiKiLwcIWCJcazXJvutd+Nc2cSDf4+RLo42r8zPDq/v0+9NkqycqHvoY7CBfczOx155wEaTaxZAI44UTDjkliN2QiOavlx0Qf9MsNt4ZEwLyzmlotEF07EYsEi9FZADPfpbP4eCaCmQ+AEaqdhNbVDzTFN8WnsghuHEmq9DK3REoWO4zX4c/RDD3cBD6F5XuKiDj4I1aKYjPJoZ2P7LEYM4qh7+yZfzKLaXejlVx2DaAX2cF71FJ5+DLuWWcdvwqDYETYiwMty4WL9nXwi356F/Q2zGUGb6HSFDfLeViU9AiTl3oqBd6zWNRBzE8cYZvl3a8rS5bT0uajDiHgZytb9NGMl/xOnI0j8NrchzbVrHEDjjd7xS1UrvPhdLVvRJUaCjyT7/L/fpYApbUDGtyiM9CgvoUdI1jnZApVjr2V87CkAMiB+cb7BsiV0eA4bqpy3vzwbzj+kd9DUT+RxMqzxynx6gz5G/C7jh7sp72U9UNwCNUdM8OeOMMqzKXjszQZZhE=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?/k8W5kMu9Eft4cw9iVFqMmUjMKpznYFEGgZ1y+9F1byRvQlTL5qEpeioIUcW?=
 =?us-ascii?Q?JD0OxrdjZ5Rlb0qKLgS7JZ3EoHAqekR8LhWSY6OyCHvI+5CyN8aSklkL+qz7?=
 =?us-ascii?Q?XSBs3ai9cPH7neYJb7GjuLYwmcBVXn4YD0OMAg4HMgp5RhEB129CbyB+Orkz?=
 =?us-ascii?Q?wpDH0mfrAPTsKL7RIY2QwFshOReQZ908vV9NCexn8x3gHl/2/979BVBNwnxm?=
 =?us-ascii?Q?vwVJhUoqvgWyprjWATVO3FkkP9RXLsL8P1Q1WsSb12NfJCs9Ci8xkVVoBn3q?=
 =?us-ascii?Q?i3lelA6LHS2EGdpXNX2qt/qwBIMWG3nyuM9kBu/xjPfm/7+PAKl1zm9fwLTC?=
 =?us-ascii?Q?2gVCWyYjeslkypSkqQSnifDDV85XpfvLmyadmTJonMdsw3fruhPbLPGYOerM?=
 =?us-ascii?Q?3MKp+4XZYHL44C7qBppFUE2De5zqLhzybOkKFcYmU2mRN+Ud2vKVsS6grlov?=
 =?us-ascii?Q?jPubJ60Tx9NYQjd29WWrxF81fUO6/JwgobtphXfiy8AygdvXmEsmaOzItowf?=
 =?us-ascii?Q?tEswGjUql+swkbmBxd5dxR/UO5x6+kzuMhlC394GZ2eVuqGgFbULyqBr6qag?=
 =?us-ascii?Q?sb88zvKxqTit3IMHQeYfSqfLF5uPP/xPo4IPowkC/AzV2inLGfl4SW4nEFlH?=
 =?us-ascii?Q?T3uHusClzKvXWvlaT3qccmkcbUbJjZgKND+3N8UUDfCpWQf8kHM6xaZ2XH5h?=
 =?us-ascii?Q?rA/IeSjWp3zJvo4arhTQluUifDV5Y9paNahu2zdZoihzNwj7F29JoxfMX11y?=
 =?us-ascii?Q?OWJwwqkqhH/jQwGzHaT+1vc8g70Rf7gqeXY6scKELNYyewV06YIN7l9qMI6e?=
 =?us-ascii?Q?gh1gpXHFI9bQ3swxx4O6gw7uNM8lXjgZOY9DCg4NdzdBvjwBwb+zTwy1Iq4N?=
 =?us-ascii?Q?WTbks2meW7X6li9XNw6U5o2BlFGXGKpJ7/SMWzAqxXL2E95nHg9uzZy7+Hda?=
 =?us-ascii?Q?eIAP1t4Da1eT53sXSo4AZVwOcKxK0JqY8J+BPb+hhtBZrrGydJ8A/eOe73S6?=
 =?us-ascii?Q?qfTXaHVl6KeF1uRaAy2aAmGNQrbD5nzoD6Zyj54eUNFqZ04oovq/TT3Xq7vG?=
 =?us-ascii?Q?TJHXHY0XQ6i183zRB49KlY+c7LVlWLtD2uZuNtvCohNrrUL1tEQrd1tnV+/t?=
 =?us-ascii?Q?YGHJZ/ar2pLa6iILg3K7SWCDl4wHEwbkLARqtfV8Y81+4T+ox7TbPHBpvYQE?=
 =?us-ascii?Q?CSQ9+SNTOLsbntMBXByin3xg6s/gfICGnj5Zsou0RjOogk0LChNuDZqGEWWZ?=
 =?us-ascii?Q?qL3B7fbvREDwGpmuV7ZcQdVdlJ3XOS5wVxhZG36z2BCQcS1/KUsK7EuLJkuA?=
 =?us-ascii?Q?jjWFZWibU+S6WqiokDfXAyK3X+2l6c+DlC8ZASXKtxGGSgJXwSb5IPNjf50L?=
 =?us-ascii?Q?75gXOamC6ledgZTlUyuxRI7Z2/V+aj6qLelLsZd2x3xMqv392kf8TNXtw45s?=
 =?us-ascii?Q?oXlCvRTju3m2YmwM/UtVszpKdubNUIOWe3g0xVWqHu4jrth4aSxueOlfkGCU?=
 =?us-ascii?Q?mkZ7DTZLBb0SNdHq6kCbBQs1OsKkGS1uE54s4zdfrlXeusbNfT5uIepQYKwc?=
 =?us-ascii?Q?vyyxRwruOB+yPeL/M53UGVS19H+BYIeC61FxElXQSqHtbZl3VZl8R3zD2wIh?=
 =?us-ascii?Q?PQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	/8LRxD4oIsLJwBx3RqsFLawrDtWiuz/batX0NFVAx3K4ADvhSzs2CzVO8kgd+g3eI1iTLp/MObOHPjaQZVDcv3dNMh4PosBs0aGiCM8/mz9jawuZEjPAebrM5z/5u2NhhLiStcvOlKhG0ofnRS0AHzm55B97PePZqNaWPokKQH+SNZZC2s0DNdXit5GpZxlwLmH3yZIplS4uklLK1CAwT/TPFuoU2x+KMTelQD4vQ9EduCAmZ9KqrBjSIaTAwRH+riuJL3DR61NFlDbH5e9ThcYU98zkWtipab/plieT+undawnOUxeb0M0ANhH/iSiSKrrbg0T6IsnOxkc4wsoVd0r+rqvKXkOqADfLT4c7xXzYL0/LD24b+KTwdBT1x9N4sqBSPy07tov5OtRjV7HQ81sZSPHfHlZuf1pd/WTQ2bq7GTgzkxK6Dj0ggA2GvmUT3eBoeEJF6tQuEz2m2tup5MRkij8BjYVEt2hbDJCVlTwKtRZocYkdtLG+F102ipzRlPMQH3gvcIUjNpUJmwFjqTz1t+vcUkuc+HVRVUGAxXZY2WXRBw5++KGUj5kwCv8zhNVn6VGW8NgVEJcdLWOZRC5oloFNxWVUBUfb/OjvuE4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e64776bc-90ea-4583-32aa-08dc3d0f5198
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 12:25:18.3601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pdCZsxaf7lN3naFQh88WOKc8Dsf6MkjoPt8a7B6X7IVqmeG76MHpHG5SIQwNhaK2829jbWgTYxWn/BDp7/egxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6507
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-05_08,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 adultscore=0 bulkscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403050099
X-Proofpoint-GUID: DLiiPi_zdNVt4UyX5_Cjg7HAtaBuvdnQ
X-Proofpoint-ORIG-GUID: DLiiPi_zdNVt4UyX5_Cjg7HAtaBuvdnQ

Use standard template for scsi_host_template structure to reduce
duplication.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/scsi/isci/init.c | 22 +---------------------
 1 file changed, 1 insertion(+), 21 deletions(-)

diff --git a/drivers/scsi/isci/init.c b/drivers/scsi/isci/init.c
index d0a23ce4afba..49e64232def1 100644
--- a/drivers/scsi/isci/init.c
+++ b/drivers/scsi/isci/init.c
@@ -155,31 +155,11 @@ static const struct attribute_group *isci_sdev_groups[] = {
 };
 
 static const struct scsi_host_template isci_sht = {
-
-	.module				= THIS_MODULE,
-	.name				= DRV_NAME,
-	.proc_name			= DRV_NAME,
-	.queuecommand			= sas_queuecommand,
-	.dma_need_drain			= ata_scsi_dma_need_drain,
-	.target_alloc			= sas_target_alloc,
-	.slave_configure		= sas_slave_configure,
+	LIBSAS_SHT_BASE
 	.scan_finished			= isci_host_scan_finished,
 	.scan_start			= isci_host_start,
-	.change_queue_depth		= sas_change_queue_depth,
-	.bios_param			= sas_bios_param,
 	.can_queue			= ISCI_CAN_QUEUE_VAL,
-	.this_id			= -1,
 	.sg_tablesize			= SG_ALL,
-	.max_sectors			= SCSI_DEFAULT_MAX_SECTORS,
-	.eh_abort_handler		= sas_eh_abort_handler,
-	.eh_device_reset_handler        = sas_eh_device_reset_handler,
-	.eh_target_reset_handler        = sas_eh_target_reset_handler,
-	.slave_alloc			= sas_slave_alloc,
-	.target_destroy			= sas_target_destroy,
-	.ioctl				= sas_ioctl,
-#ifdef CONFIG_COMPAT
-	.compat_ioctl			= sas_ioctl,
-#endif
 	.shost_groups			= isci_host_groups,
 	.sdev_groups			= isci_sdev_groups,
 	.track_queue_depth		= 1,
-- 
2.31.1


