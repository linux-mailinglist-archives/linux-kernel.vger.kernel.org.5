Return-Path: <linux-kernel+bounces-92363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA2C871F1E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7332F1C24827
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4135C022;
	Tue,  5 Mar 2024 12:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GA7d0Psy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CuWYT4PI"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784B35BAC2;
	Tue,  5 Mar 2024 12:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709641535; cv=fail; b=NLRilvpj0jred4Wczi0a0HPknss8DGhINTJ49bmcn3EiU4IqU7A9j+U2mM8hvzyHULb5EI3IOI4SCu0/IXpwWwGHDLIxciODysj4ZgJ//WMn38SSn1o+gTfTflQ3gkWMkRp2WUtH79n4xJELdGDNa8D9qlqY+LOgddpsmugdX5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709641535; c=relaxed/simple;
	bh=SvpvN7SqYiuaL8SbKBFdXmDJS0vxFwJu90qkoBf582U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=niRL8xIYdDt5VF0d9F38BnpGTvyj3H/iAYXpm7c1jd41O4lQGUj/qtXv1/Ropyx0xqS8nbGv7jQ5trmJ7yOiOl22aC86zLpGvNOPyeBd2l1vH3lSIyK06tyt5QlZ+ZHl6YcG3qDXcVJVp/MijTBCT5RsMn7lHCAu/xUBKCJrJMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GA7d0Psy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CuWYT4PI; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4259hoh1008900;
	Tue, 5 Mar 2024 12:25:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=13n9ouR2zm9X33sNFnsZjnNWn1NaVlv/mOpl+rAf6Ew=;
 b=GA7d0PsyFpBFTLGQP9thN64MOnnIp1Fgt6Mv346bNGkpH3S0he4PmrwC9WIcQ5hyqHzy
 E7KvS0WnbXDl9muyEpb/YhfhuzOuEr3zlxlOQuR3DrIUYx49w6m9Cg3qkVNMlL9EjASB
 2kJouyLM9ZHKjeZEjMoQNpK0irWFDtj3jM2eIv0DUELg2x/Jj0Xya//qT+4Dbi3GC7yK
 aYF2l/ajkX2KTxZFAIcTtlYUDsoJq4joTjkmRtU2L07+Jv+LZ6E9Ys6nmvuXTXpyq4eE
 51vY+CVTWls2p8DPV90rkTes3f1o9tGEIusrONG1XbnjffwNj+yIxZihQq+hYDaCONvG eA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wktw46081-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Mar 2024 12:25:17 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 425BXZnt012375;
	Tue, 5 Mar 2024 12:25:17 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wktj7frwy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Mar 2024 12:25:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IDq42cqJRnKFskX72n2BQLbS6c+sxXFdh3CCpdhbpcx/wRxghqu7Cb6XE2WILOBMVBwff+q6j+USVQ85Fd6fZb+hDBNC1Yi6zeg1p5EPGfIGekhm0uC9usmWBn3PVpPKpm7q1wjKYWOCx9128I7H9/dudUyRLI1hHCcFU0gJ2bhtPHXrQQHaYXtS78xEXfwfn4UZCYx1d2tYAoVADHyF263yfV/sQXUqs2HMhlN1vvckyWp2pGuVc1mAx7X6FrErZkh54qIvvgYRhHNqur9IE5otqym064I3qw3ZE+RLjSs41x8J2X/IUUnE52AeuUTQQoPMFs362GYnq5Sau9B7xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=13n9ouR2zm9X33sNFnsZjnNWn1NaVlv/mOpl+rAf6Ew=;
 b=e7T5+Qxsih9IfCJRr5zqaQFViMfyre+HsNG51T0LjdoqGHP2aYZ1O3njRhL3v22fw2BsDzxTXGei2B27U6CGK2EpXiUD3KCfgWnRWxX4bktkNnwol6A/BIESx6TQ2tqziE7E/vLNvUxDmgB9XbhMFtNuJxcg1eRjSGgxMTxMntpVxEq/s/ryopOZk6O966ARdfjN/H9Ngqdvmd2+1mvkRgPAQ/4UNlyv/75e4bhwJKoZTB3kd2Rey9oyZ61YyqeEWVY7Te2XfPcNfxU7ROL9kDwcHpQZOXt5inkChXD2VWd6nU36/xrn5+0k8sWItiE9Ewz5nM+XonvfMTgVbDdDGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=13n9ouR2zm9X33sNFnsZjnNWn1NaVlv/mOpl+rAf6Ew=;
 b=CuWYT4PICniRwnp7ydQn/SUjr9uqZGQdIR1FPEimes4OHA/O+YIoUVdo8xlQib625Fekz18zgBqsG0R4sLTXm/uoIVrThdWSKU90E9PlqcLwCV/xZ9IyEmqzsXoacV49AnVuCz2Z6DQCXfGKiXy0ZkDdxg5fNgIfq1FgiAwfJIQ=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB6507.namprd10.prod.outlook.com (2603:10b6:510:202::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Tue, 5 Mar
 2024 12:25:14 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff%4]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 12:25:14 +0000
From: John Garry <john.g.garry@oracle.com>
To: jejb@linux.ibm.com, martin.petersen@oracle.com, chenxiang66@hisilicon.com,
        jinpu.wang@cloud.ionos.com, artur.paszkiewicz@intel.com,
        yanaijie@huawei.com, dlemoal@kernel.org, ipylypiv@google.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH 3/6] scsi: hisi_sas: Use LIBSAS_SHT_BASE_NO_SLAVE_INIT
Date: Tue,  5 Mar 2024 12:24:49 +0000
Message-Id: <20240305122452.340471-4-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240305122452.340471-1-john.g.garry@oracle.com>
References: <20240305122452.340471-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0273.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::21) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB6507:EE_
X-MS-Office365-Filtering-Correlation-Id: 20fa29f2-d70c-4aab-f980-08dc3d0f4f6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	iRVE6wzQ04lBIFEkv5ONo8uVIwa2h77vdi6pMobSgE2F5IKvrbibSfgc8nhrdH/H469JQRoHHyDlNul9UieHRGPA/PIYP5Vz6qGvLCPAGSSL7fD/yDB2wCik9QNjwk4LFxVLEaJLFBoSECriTzsr1kLOzw/beGIRbuI0LEwwZM4g4/hFOIx5cB7v/GycTMFCf0V+jfyT5QIqz/KUnCdULIBEU7YjDGfd9cLaqoBbYNQdN1N5uKbvMMRiY/Exf/sgXtVutDETEITff9RXS0Msa62ZCnsjY4iDNx/9JDAHWxlDtRE4ZPVhGFZER6orNxOlh4f6EkArYxBxB1V2JxERrS/YiZqERCoeZhXm0tgiVrXRLLOUooUlCq7lz5gqYkcxz2PEk/M4thouKUZzarGOia0Nq8u5kgYH8y/0an/ezPBp/6/HOielwGV1lu/rRt4/cThWFCOmOMNriyIh+ktpVyjkXDk8EXeVIKTlfXNJekyHwMWAH1tQ3AZ7qodBCgMhhcho12ow+dmo0hrpIcpBRW890lMMEpmxauVs7S+xeADIZC8jATePv1VPl/Z1hfSkzbIOpohEaVVFpBHdlyTJIdNBeEyuZYKKGjSdOMYHOFJArsC0oLQTdtF3kw2UnKT+V7uQzBSoWb9jFqBY5HIqPV/VqYVp2E7i8Toh/yZTaLA=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?aYuZrTVODFBqJfYb+AFyShrsoFEUjJK5uPxalmZVSnNfpRHdiiZEKVz1b/TL?=
 =?us-ascii?Q?l/bVL9A99SydQ+NpLxpUlUHPXZzdL4QAUnoYP7Vx4/asX5TwzaCmgwR54oIG?=
 =?us-ascii?Q?fwwfkZQf2Pm3ELHEJaCsmmC+Lh5VoQ3aL0PZyz5gsYADJH54A0xIoS+U4rjy?=
 =?us-ascii?Q?vSjz16b5lDUkS1AiqNEELh9/M7HAH+UQL/kUojemxUTcubOiZfZMKkZkoXs3?=
 =?us-ascii?Q?zmRTHLDujER0OmFtHh2o6ryl0sEdGH38bQOaKTo59bBEMMVPiiIGIdgeW2Oo?=
 =?us-ascii?Q?5fmp5TDvNJaAoZA2gKMeVN73lpZ+WBiUTW36453UhSCtLFbgtKaQSwUjtxD5?=
 =?us-ascii?Q?7VNRruXLy0KzHimmzXwLfUJf6L1q72hjZdBulnShnmtcHQQAa/d8PeALepZD?=
 =?us-ascii?Q?piq7wzjf5iBuGV4cQF0ow/Wu3EBY+L+Gu+IjroUtSlwCR9QWQtV4lO4Kxhgp?=
 =?us-ascii?Q?3rqD7N3OEsqZ3As1KeA8lJajSIdlCCYsnWAxrze/eYBSqsuMmd2AXDCYZKnX?=
 =?us-ascii?Q?wnsaEJ1V+evvK3XiJAwdMsuck99coZ0W03KspeYtsSVHtgRTMNKiOQKjJLJG?=
 =?us-ascii?Q?qYnWOommoHYxeJPxxdyTXKRZbDiETwnC7cvD5puBVACxkF9+HOFOSTPlzfAP?=
 =?us-ascii?Q?gvG8zOAynwDLM92am0GMJj1XpTzR4wHPEiSXD646qYfZq4xHo5if5xI6mDMg?=
 =?us-ascii?Q?naIUxjiSb4orX9wFxvy0uhXc2Y1AXWKl2OKgNCRaE8MZO4O101kM2fCfkgxr?=
 =?us-ascii?Q?s/TpRkEbNucwbwXo1UwvTx1Iv5AMMSKTrcJOOP7tbkiDniEKh9CzBkVHnozP?=
 =?us-ascii?Q?a9ms5TeVGWcZBnoeW4VP4cy0t3/4fTZuMgOY5l+NAJ+nObPD/INTULrjBM41?=
 =?us-ascii?Q?k3raVxudmTwEywCAB/CXTcBsAFL5ihs9W5P2tFel9qi7kYUvjWiDn0sY/wif?=
 =?us-ascii?Q?LV7KCGpwkhvOEYtZz3EkRKki5iaRd5Qalv0Zkoet0INLdTiZ0vSWBTq2h1pI?=
 =?us-ascii?Q?JN7Artl+RDGtCzbW1umqKvGY76NB4SOfGBG3oO3nN3QIfx6XUk+qx8Prjchk?=
 =?us-ascii?Q?FNemLJkv1zHc7LQx4ww5BXXfNgOgVjFkw61S17sqGe5qqqlGTjksiFjyaVf9?=
 =?us-ascii?Q?Iciz9AiU78xH5eQuC4v+V5ln8YNTlQxgK6JIS9yxP+UpfKLjZsRzyDYJkbin?=
 =?us-ascii?Q?GZS6Erw6YhhZTnFh3Db+DWim9VeVMKCwkYDnQVPfcoOeYFu/4jAednefFRAL?=
 =?us-ascii?Q?U4dV0SBZTcxndpSrb3dhm45cDWq461zPFa3lpRmpU3ytM9/L+vJW2J8bQCSe?=
 =?us-ascii?Q?bIznRsuPNsP+FOXKwb/YpCAxyKsPxwMjwzrmLWG3od/qYtgqVn+lmKSJU8jh?=
 =?us-ascii?Q?lDdr7cc2hRigkxWv8BFjP+BaYVYLKRbDiMnNSHW/GF4Aq+u4M/Cj4uzB5BqB?=
 =?us-ascii?Q?S4pasKsqB/40Bb3N2X/CwjnskRW5BuV0oe4szoLA7Z9aiNvzNpYUKe+QFfZl?=
 =?us-ascii?Q?EYMz7sGpbNJ/8Njm0/RMLAiMB815u8Hlo8nnuQLDbYDqX9PXmxxcatKqO0dZ?=
 =?us-ascii?Q?FRnK3cL5CRw2vIP6ZnZiBG+C5Uso11EZLxuZL2O9M+JhQtMoq0O63OWcLhyq?=
 =?us-ascii?Q?Jg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	uAkX712/xQrIeeqyZV3lwbbiIcr9g2NCtRUwIhmkYoWRPwJsKXXsJ7GI9/6Erg6wLXaA9QJWtfUtNnKKH5cbO22K56B3du0cHKntfdr4q3dW2nZgdhN1E8EBFIcSvf8x36N/cn8um3vfSbpJ01zoZQ4Ws5VWDkEuVf0ulFpDKkGA2DhT0R5C/oYyL4skYbseZZ1rsTuOuJFolTG/R++cLZQhdcl8eyRSJ35S84S1YwdaEE7hFt6VHymdhPUiyLfbQ+KUIS2AKq7Hk7IQo3YpD8WwiU0vS/BDcjnWv3yzrxAcuFoC2CRPsI4m15goE1oRJDkaLdf7zRNA8+Ct5aIiQW7gxYkItFsg+DPMpeml06JEEjiadPJ063IRX9ogiyeSZ3otdOJWQJB2jumwmmlY4LPBhMUm9HUSRwqIpFnbp94O35gXF28RJC3cAqu1JV15fhzYYutTyTqDtT5R28cdmHAds3vA9objsV3kXMlkQsHYUD3iETUA0upJCstDR2QvPWmyLjsApZuJYi6r1Kc9aXF3qojhhIHmSeMjSWIeOANdSQYCxH4TaeUqE1Ou/IRI+OcY1QAm0lqHmrWcWP6CCnQHIJ9KQk4ujwUFAkw9CCw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20fa29f2-d70c-4aab-f980-08dc3d0f4f6f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 12:25:14.7325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zqx4x1z3HfLJlBbo9/MweGrujMMKGUKxMKAUr4YEunN++MUbJsA43OFNis2QVMsUOrtnQh+YDYtm5NR7BdSRSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6507
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-05_08,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 adultscore=0 bulkscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403050099
X-Proofpoint-ORIG-GUID: l2VgYEvPw5ihwECjbr3R24HrA6gcWAXU
X-Proofpoint-GUID: l2VgYEvPw5ihwECjbr3R24HrA6gcWAXU

Use standard template for scsi_host_template structure to reduce
duplication.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/scsi/hisi_sas/hisi_sas_v1_hw.c | 18 +-----------------
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c | 18 +-----------------
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 18 +-----------------
 3 files changed, 3 insertions(+), 51 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
index 3c555579f9a1..161feae3acab 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
@@ -1735,28 +1735,12 @@ static struct attribute *host_v1_hw_attrs[] = {
 ATTRIBUTE_GROUPS(host_v1_hw);
 
 static const struct scsi_host_template sht_v1_hw = {
-	.name			= DRV_NAME,
-	.proc_name		= DRV_NAME,
-	.module			= THIS_MODULE,
-	.queuecommand		= sas_queuecommand,
-	.dma_need_drain		= ata_scsi_dma_need_drain,
-	.target_alloc		= sas_target_alloc,
+	LIBSAS_SHT_BASE_NO_SLAVE_INIT
 	.slave_configure	= hisi_sas_slave_configure,
 	.scan_finished		= hisi_sas_scan_finished,
 	.scan_start		= hisi_sas_scan_start,
-	.change_queue_depth	= sas_change_queue_depth,
-	.bios_param		= sas_bios_param,
-	.this_id		= -1,
 	.sg_tablesize		= HISI_SAS_SGE_PAGE_CNT,
-	.max_sectors		= SCSI_DEFAULT_MAX_SECTORS,
-	.eh_device_reset_handler = sas_eh_device_reset_handler,
-	.eh_target_reset_handler = sas_eh_target_reset_handler,
 	.slave_alloc		= hisi_sas_slave_alloc,
-	.target_destroy		= sas_target_destroy,
-	.ioctl			= sas_ioctl,
-#ifdef CONFIG_COMPAT
-	.compat_ioctl		= sas_ioctl,
-#endif
 	.shost_groups		= host_v1_hw_groups,
 	.host_reset             = hisi_sas_host_reset,
 };
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
index b5d379ebe05d..d89e97e8f5c2 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
@@ -3567,28 +3567,12 @@ static void map_queues_v2_hw(struct Scsi_Host *shost)
 }
 
 static const struct scsi_host_template sht_v2_hw = {
-	.name			= DRV_NAME,
-	.proc_name		= DRV_NAME,
-	.module			= THIS_MODULE,
-	.queuecommand		= sas_queuecommand,
-	.dma_need_drain		= ata_scsi_dma_need_drain,
-	.target_alloc		= sas_target_alloc,
+	LIBSAS_SHT_BASE_NO_SLAVE_INIT
 	.slave_configure	= hisi_sas_slave_configure,
 	.scan_finished		= hisi_sas_scan_finished,
 	.scan_start		= hisi_sas_scan_start,
-	.change_queue_depth	= sas_change_queue_depth,
-	.bios_param		= sas_bios_param,
-	.this_id		= -1,
 	.sg_tablesize		= HISI_SAS_SGE_PAGE_CNT,
-	.max_sectors		= SCSI_DEFAULT_MAX_SECTORS,
-	.eh_device_reset_handler = sas_eh_device_reset_handler,
-	.eh_target_reset_handler = sas_eh_target_reset_handler,
 	.slave_alloc		= hisi_sas_slave_alloc,
-	.target_destroy		= sas_target_destroy,
-	.ioctl			= sas_ioctl,
-#ifdef CONFIG_COMPAT
-	.compat_ioctl		= sas_ioctl,
-#endif
 	.shost_groups		= host_v2_hw_groups,
 	.sdev_groups		= sdev_groups_v2_hw,
 	.host_reset		= hisi_sas_host_reset,
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index ebdfb7e7c88d..756660588a1e 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -3320,30 +3320,14 @@ static void hisi_sas_map_queues(struct Scsi_Host *shost)
 }
 
 static const struct scsi_host_template sht_v3_hw = {
-	.name			= DRV_NAME,
-	.proc_name		= DRV_NAME,
-	.module			= THIS_MODULE,
-	.queuecommand		= sas_queuecommand,
-	.dma_need_drain		= ata_scsi_dma_need_drain,
-	.target_alloc		= sas_target_alloc,
+	LIBSAS_SHT_BASE_NO_SLAVE_INIT
 	.slave_configure	= slave_configure_v3_hw,
 	.scan_finished		= hisi_sas_scan_finished,
 	.scan_start		= hisi_sas_scan_start,
 	.map_queues		= hisi_sas_map_queues,
-	.change_queue_depth	= sas_change_queue_depth,
-	.bios_param		= sas_bios_param,
-	.this_id		= -1,
 	.sg_tablesize		= HISI_SAS_SGE_PAGE_CNT,
 	.sg_prot_tablesize	= HISI_SAS_SGE_PAGE_CNT,
-	.max_sectors		= SCSI_DEFAULT_MAX_SECTORS,
-	.eh_device_reset_handler = sas_eh_device_reset_handler,
-	.eh_target_reset_handler = sas_eh_target_reset_handler,
 	.slave_alloc		= hisi_sas_slave_alloc,
-	.target_destroy		= sas_target_destroy,
-	.ioctl			= sas_ioctl,
-#ifdef CONFIG_COMPAT
-	.compat_ioctl		= sas_ioctl,
-#endif
 	.shost_groups		= host_v3_hw_groups,
 	.sdev_groups		= sdev_groups_v3_hw,
 	.tag_alloc_policy	= BLK_TAG_ALLOC_RR,
-- 
2.31.1


