Return-Path: <linux-kernel+bounces-92364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7636871F1F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C46F2859E5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F82C5C5F0;
	Tue,  5 Mar 2024 12:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OhfS5nSF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kjDyiSHa"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A555BAD5;
	Tue,  5 Mar 2024 12:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709641536; cv=fail; b=NAKNUiajDCI+AzJnSkAUC7R6ceWzJLOrI5x5toqEkPnojLbDsJ9rs5IrEWApe32r60yuOJXwmhnLQ/AmmCvPknx61HY9x5oaCG0kXEcxY90ACf1DTMC3Au0n4/dMraPVXlBnlBR42LiU5xwBg3gmFMP/Hd5CFNxvN/RYQa0dSXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709641536; c=relaxed/simple;
	bh=1zlbJAf/cC0oBko5uknP+vAJSjTNnzqzcmcRQt9h94o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KikZjGENd2WGL9pKogF5Huyd+2VIr/wa7l+wKkp3+k9Uu5oP5/jeXDesjVhHxpPJW1fTbtcNP1mql1GlU7jy4KQvBxI//RQZd7u+rZ22NuLVJ/W3rFpCH5vywGqjnCjv0Zaac5cQcyiX1dRB2mSBNZAKfHtvD1MWZb531NK62Wc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OhfS5nSF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kjDyiSHa; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4259hnlQ031277;
	Tue, 5 Mar 2024 12:25:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=fjBX0v4sJoBZ5nLLP7lElujX+8v9E17/Kx2/i21mcfI=;
 b=OhfS5nSFOUXmzJ6Qnar5bisgoiYIs/56NtEQNuZPczbXvXrkp7RxYENtq3pZc+0PqpQP
 t99huStt8eE/Mnb5FC7PA4Z01jwPkAUx9QQjvkRUatFkz0tRB2myPMfz7JdN6lLvYRMh
 jXXWDUYcd8Y11MT3fpfgIEFXJ9IfnvxUFo7WN6jn1SNnbhdVnUc9UDl70KBON7JW/3Jt
 dfvM2crDHLk+Nwk3YELgkmCjV6gvGMxhpYaHTR47LQUNhA6GX5CmtNgm8/5KsYsrbkFk
 s0gUMp+y463eIg83LO2dfHG4p/r5e7BLJVroTXXXaRzkgmFU3zV0aXWeidTykRQRgQT1 yA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wkthee5fu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Mar 2024 12:25:20 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 425BXVtC012259;
	Tue, 5 Mar 2024 12:25:19 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wktj7fs0w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Mar 2024 12:25:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ixtYCDPiC5UvouuZel9LKwuKZJjb56a4a2XsoqiUBiR9UtZHBW8Q75IE6yuRYLibnB64NvVy7wie/F3lDT/OWX+yxPIQ4lt2nzyW+1i0eVCMejfmmo2jMhdvWmoo4YsY5LpdmUu5OHuzzo6y35DWmFL0fDEJp9Jpaf7I8hlb3Y6X5ARFPBId2PVBl+rUWmEw15pLOEL0NwqXeZyXkntHn0ZuyWAkLVXv504Zo/owurnvdACJ3Prpi1taNFV9goWWO8SC9UXw322g9tkCUIsCDGYUf1tB3CgyOFmRxKgoM3iwjHVeBv4+JIJCXONO8Vo39945UCP7d/v5Czj2iGsxRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fjBX0v4sJoBZ5nLLP7lElujX+8v9E17/Kx2/i21mcfI=;
 b=n5zid8x9JTw9ikzD6kiqqkXJmzW2H4cDT+6acz4WBfietmnBnZnkIEx3hIghhXCRadDSyBLI8LGBHBJg638aohRL95SAuYOBYgqJNoYQactBJ4gBISqVCxUvOJrCR77AnzHFgunj3YYYphNvfH/9JgYMs1o2Y4buE6HW7jXcRPWgiUAKo0oqChAGKNLzKxbumAqURennUzrbNswj6b+1un/T5OBtoZecJyx4OW8WnwpjqTUP+jlvuGoIrZ+9n6GVAWdLESlZnM89kcz+t0RxmryTAvxdc3WWDpDk1uSxxFxp+43LzFGB0+Brug5w9nDSXM6ceimdGba2BL+UW+pnGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fjBX0v4sJoBZ5nLLP7lElujX+8v9E17/Kx2/i21mcfI=;
 b=kjDyiSHaM2GzG0Mc6dbIqLD887RVYV/4yGbwzYHavNfPXwon7TaVEooY4tMH0fW3OE2z2L/awcrUbYRBOFH1vchk0vVZsmgQ6HdBOG9tXPNrY86qQd2e09Oezix4LdcqW+03h3RUcOfjGHbtcz9qAm8a3xmM8Ex0WNXNM1N6k4Y=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB6507.namprd10.prod.outlook.com (2603:10b6:510:202::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Tue, 5 Mar
 2024 12:25:17 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff%4]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 12:25:17 +0000
From: John Garry <john.g.garry@oracle.com>
To: jejb@linux.ibm.com, martin.petersen@oracle.com, chenxiang66@hisilicon.com,
        jinpu.wang@cloud.ionos.com, artur.paszkiewicz@intel.com,
        yanaijie@huawei.com, dlemoal@kernel.org, ipylypiv@google.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH 5/6] scsi: mvsas: Use LIBSAS_SHT_BASE
Date: Tue,  5 Mar 2024 12:24:51 +0000
Message-Id: <20240305122452.340471-6-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240305122452.340471-1-john.g.garry@oracle.com>
References: <20240305122452.340471-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0058.namprd02.prod.outlook.com
 (2603:10b6:207:3d::35) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB6507:EE_
X-MS-Office365-Filtering-Correlation-Id: 84d505f6-780e-47b4-3158-08dc3d0f50e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	KZOETXeQZhmqez9hG45dkNzSxme6l4ptfUqZnx7VJS9x79w5wJq0J+ZqcjZnugvrPrJniRMphENHJqCVM1VycuCymjC6yrg7UOi31sCyJjSfEzNqqTMjRg8a19BruBZE6MEkNRBU9uUjo0CowM2sBCaA6tER+Si3WITEcxYDPzlNKg0G7Sj689cngGoKWe6+7hgdZpf8FB6zyBOP/l4RqfAo6te7hqddHlsUZtX0s7Lzjn7UH2ZNk/KcnKQ9PPVu38iD97aHwCDv0q/7Q1ZM9bHDZ/8Uw0oi/c/okfD7mitOEJyOlIwXZE+owNrrkE9Dn9B1vyK0Fgt2YIHMQ9A/ieJ94isf9Lxt9n2YxVujKV6QvNfGDTHYjYodfBlvvNgwJgHJu7twuA5rA6Ib5wraH/dNK60079WZVUW8LEFgnyyAzNN82QiuePplM+407k8JOqdZKnKIBYkB4B7iTs6Iw5fZg5cfsKXkcJEFOnVkv2lfVqXMRQ7oCtnHRigJzWeOaXCRg8leTyPNVQn2sZ8tOQcoNSrTx+UuKlMni+gVCK90voNO52P9XGlJkaew57eJ1HjUWgIZUXE3QmocqFeRCgwEBWBBO0cuVR4sC/60suJUlE1SoCD5GFJ60wLDzsZVpUoJYPJYMYXm+KUwzi6GtXN4Q8jK8rIZKynD30hhPYs=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?LlpE6VHC5Q17zQiGEv9D8mZq9wOxqbNB2WdZtgH7pDG60Y551hIBdkYANA4e?=
 =?us-ascii?Q?8bf/ukBmJwY1Gd+8iPlt95M0CV/4KxLlqNHmlpyIMApA3klZm6Tld8B7f86q?=
 =?us-ascii?Q?+047N5uI5GHr57qjmieFheLg2VU2GDa2wTCgweKDCOMqq6C7yQ4cAVrXTS9E?=
 =?us-ascii?Q?aEODmqQPxhbzry0sEOnIVC7qJ2FJYug2vyS1BiWt1YLIR6r/iKXE684TMgiR?=
 =?us-ascii?Q?0h1P4/J32MJDrrERJRCZDNwJeG3/Lyh9HsgAN8rJaF+bLW7e9HuZsx+g2VFX?=
 =?us-ascii?Q?pzkg7Hr4xN7POuYbgIpSLQdNEzTWB4Vpd4/s2NU321C8c7/nNfYVxzSFJOuE?=
 =?us-ascii?Q?bodKV9xuKryeD9KDV6H8qoOAkpHrLAOEQLPthBAml2B5Eato2uHbVq0Jg/jy?=
 =?us-ascii?Q?xWc/8Gl8mHFEUrZGu74gpDFmF1TLKOjf9IRORW5SF3r9akTCxOmd5J+1F2VO?=
 =?us-ascii?Q?0DR+P8ZVAvJZfA4883dIbBE0FB9ZLFqmsivWb/oUszO11IT5D5RrsM4ldvCe?=
 =?us-ascii?Q?sVj7/OKUwozxtkUUY95aD6L0zS+dq742yPr5mwRiFCg53xXlfLPNbDsjFJb7?=
 =?us-ascii?Q?3Rwj8NV5cmJBrr2vftWf3hnJ6fV6Yl5LeZwZyjKT1zc599CyVlwvGQBXVX19?=
 =?us-ascii?Q?Mu+A4gNC7uotaA6IAVKg8onEPkoMf3tGoFeCS/T8WijjotQWjiL8J8z231Rd?=
 =?us-ascii?Q?x3Gv9YwCHhtR8EuwXNY4sMEKzDZqrLfx2RH9J3bfzPTfsNLiY4O8eTzdsgap?=
 =?us-ascii?Q?TVwP30NnXKC6NVgdxxG3L4IDbhGTlUr5NCZBNFCZBFUhdLMYZTAlYzaQfaY0?=
 =?us-ascii?Q?YtjZfMwQpJvLckMG1RXg2Gq/W3c8FjYGAzOQvVwIR8SrCiSIcfpTDu4E3w5h?=
 =?us-ascii?Q?+cOYWOriT+tiDE19Pk8qaYKhrVYsUjtbPa/geSd5BnqK2kdjP0zGx2i4ONJQ?=
 =?us-ascii?Q?HVpD37JpTFOdeoqQOQAIcmqP6wIQYLQaRGvdBJmB0O7HSbgci6IDCHnCYTE8?=
 =?us-ascii?Q?EvQsnA3sNk6NcCvRNd7SVcf8nIac0pPQ6ojEQZ2KdruWqgrMxHwjwzzX3Vdi?=
 =?us-ascii?Q?qWzVgmWzwrPkLFT4SKL/TM7JQDqYZ6Gw84y5p+DJM7NCzETVYIkjgzJkHacL?=
 =?us-ascii?Q?gXjjXrui3nKkQT2LJVIbdkDc3OUy/9GGzaozxW0nFgm8jWinDaemGYRqHl2c?=
 =?us-ascii?Q?oiyM3ItVs3WiOViqb/bVpXmTTBArUcJv9JAt4HTBmwk4XtUIvM61dZ6SXURZ?=
 =?us-ascii?Q?HK3uuAv6SJYPzhuVJjNYV7MFgiDjCY8esRv3S4zqPjlfqDBntnZXaQjYrEwf?=
 =?us-ascii?Q?ejnfhnzpF/Cc7LD9eoB8NjgGcbvj+Y25ksuAZijoMB3S+8YGm0FXFHG1BQHS?=
 =?us-ascii?Q?8X2pFVbczgMCHLcepSbPoGovrOSdYakIsXKv0s1CBw6qlfTZp/p1p9Ru2hqa?=
 =?us-ascii?Q?IlmyCKudD40W7x/10MMWBawQaGdIGKtL6nKvVnlWb6b58/zPg+guH4a+hTv/?=
 =?us-ascii?Q?Lf4ZlrqR25Q0v8ms1/Q/tlMv7thcQHgmv62ZE/8Ln6BF1YXpnj/ZdvpptIop?=
 =?us-ascii?Q?iCugf4qR+JdiIbqFz9+k3nYgl1aP3IVt6zlTBBQ2d01vwvhEh6m2W/jLQ7uc?=
 =?us-ascii?Q?Zw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	6u8SpXE4IJ8LA/EfXIjq0cf+BDwshoNQa8AtDKBY3Cin1Ug2zddgBvqHPUxSqwuUppDwSw7W1uBa1znMWB60mxcaYgHe8xSEOKkEEuxL2Jf5+H7LlQX3Nq/LR0stBQFPfA6LHsB2vLM/J58a+yef7EukOq4JWPxAgYhVyzJj9g74L33dEcNHB1rqWupmx8Y9zWEu0fdF1++3mPJYWxPWwyCA/S9FSbfzv7IbpiklSWaHxkV2JITlmkAWMEuoGabVjQTEP9bws+bF+oubSt4ALRkizRi7UNhhQv/T2/4lSC2Qw9l0bTmt2L/eQi111xRNkuxvQXSoCjQygN7Fp4w+oXgwGRCAPCbg9t49SGLSDGlXufGIjEy7De/MzUlfUExfjzMKkTxM5RKHUEn8tZNL/3lwlefi4S57zIsPlclEE30+CvPFOaBuI4SkdBdstQVVjEmCZq5ClWtLJGe3U/bRJ5layd6mdKPq9XK8avfm6bBRBL6HC9iCUOm6EOcPgXfjw3ylr8dK5qNnH9haVFbizBgLRIbUcBJn0boZEWewFxCrSt0/NXlZRyU4RSq6QJYlLGlsr6+nIG2UTJJLbxpo6YnX7VmnCF4eXDTqsicaWic=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84d505f6-780e-47b4-3158-08dc3d0f50e0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 12:25:17.1564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pg149/LS5eikeJMlhWIXIvxRFz6DdR0qyBM/xVsXpBYMC7KkR/9V3AkYjX63NWO+ydDtUmKL6eQVf0dltoOOew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6507
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-05_08,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 adultscore=0 bulkscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403050099
X-Proofpoint-ORIG-GUID: wMJSYK_-bIf4cUDXaeYDJrIVHsGdFLXa
X-Proofpoint-GUID: wMJSYK_-bIf4cUDXaeYDJrIVHsGdFLXa

Use standard template for scsi_host_template structure to reduce
duplication.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/scsi/mvsas/mv_init.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/drivers/scsi/mvsas/mv_init.c b/drivers/scsi/mvsas/mv_init.c
index f1090bb5f2c9..c792e4486e54 100644
--- a/drivers/scsi/mvsas/mv_init.c
+++ b/drivers/scsi/mvsas/mv_init.c
@@ -31,28 +31,11 @@ static const struct attribute_group *mvst_sdev_groups[];
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
 	.sdev_groups		= mvst_sdev_groups,
 	.track_queue_depth	= 1,
-- 
2.31.1


