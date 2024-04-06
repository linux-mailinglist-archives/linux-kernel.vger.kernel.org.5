Return-Path: <linux-kernel+bounces-133758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8244489A837
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 03:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC984B21830
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 01:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75360FBF0;
	Sat,  6 Apr 2024 01:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eDbJ6+28";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MvRaseaK"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0001291E;
	Sat,  6 Apr 2024 01:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712366880; cv=fail; b=rzO1H1IW8nwIKObriHnIHNdNBmwEcmCRlIJe4RYT0Wbpt06ZkUWr5lsr7utCJays9jeWcmMf3C+HN8QvEmF9uzl4j4ELGnsKh++LolYM/josbeu8jOcQwfvLn0oYGrcb2bc0UjsFhijvPa790yDFX2js9+8COpi421ozEf3zdio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712366880; c=relaxed/simple;
	bh=14lFPkIg9Di6WbFHY6OCbmdz9oUuiHQLW86ZVzvxGLU=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=NxWD2tQMDTpAYwVpc9mJJLhtxwUaHH2Dh7aqGRScAK7M1CR4Gdi1gpGKCzziWNIl1w5x+R8QMwO+tgkDW0fTu8jEltl7HJJltOhWD5Y5IitwssMOnCmfbS+67gDCeA3pJOa0C04y6E2d4pvj7OIr5/ib+D+XAfl32itfOsg3zV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eDbJ6+28; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MvRaseaK; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4361O6sU031260;
	Sat, 6 Apr 2024 01:27:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : in-reply-to : message-id : references : date : content-type :
 mime-version; s=corp-2023-11-20;
 bh=85jnFGR2gg8UG+26ztyn9cLqPcKY0dyRFQU3h1rQBFc=;
 b=eDbJ6+28UNg1djePWQeFMeytsgqfr56HBSnTLgFd0+TY7IuoSmq8i49Helt7n4BbN3lZ
 BQUlRfPXUyF3RQohxiZaaOJuGEsGgydv+NGCq5qLsm+9MkA5qCT4a3ShUVoECEu+AXNH
 PnHg69FKsISu++BHzITP7Qwl42RyfCqEmrW8y+rba37ggb1o2O8o2yI1ncv1G+tsLPXJ
 xnNZIAvKILfNm/vwxWQmOBEOQB4fn1rZiM0Z43qnu4EZ+1Z3i1EmwmTod6GndnoxXKc4
 CLJbuV85NOwuX0WYbWTrOIqfgmhYgL3bjkEs2DU3hPrbR4QcIbdMhnEytwCueUczGwct JA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x9evyvmey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 06 Apr 2024 01:27:51 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4360GP0T030568;
	Sat, 6 Apr 2024 01:27:49 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3x9emrtk4n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 06 Apr 2024 01:27:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lfmIjxF7v9J5+vsvSX7wxEnvwqb5+Pjqz62sr5DnpsxAFr6S9mTCqhyBtE5lF9wvg0NZLsUsRBP7KnVpoVTcldQQXos8lYiAa2lAlSovvuIGL42nAkxBqYyCSBEC01/tNn2BuD6Y1bcx/mSGJny0dGuEMmmHzC48eptDc/uRnMZZZlRuV6kpLVNGn+kpwb39px/N1iCziHi3ZDpNJUiHKRjmY2BZfKQ10Wso2qRfqqZ5dCnLnFqkT4NSdo8+bczXz1gzppozpStH54czvkAOCJ8mJPJBRlHQpb4f+dRWNzgBCrzHQSURO9UMzKSZi7NKA9Akq0VTNk8ARH7ctK9K5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=85jnFGR2gg8UG+26ztyn9cLqPcKY0dyRFQU3h1rQBFc=;
 b=TSEKp4wSFm6SOT0emtV1rDzZ7Vje+srndHOr05k80zHj5yyUCOQuDyeA5Rp6QyokeXuOqulTlIrzAxVuRysoCQS3OYiI42p1yoGnqrEZNTphMjD2pcdvUXvKM9JYMDTwJF8pieyDH3/78l36417u2wXQlFBSod9lN46XgsH251TyCL1+3tCHf1HLa5YOERcpP8a29RCbWRwWe+Y2St//XgCikOsF9eW8QYEdcl/TyAy++4xGCMUV7zhdTLNec7FW71oEvHKQCcWgkDE4UcRB7cUKocwwL6QboEQNxFfcHxd4IkeIDQz6s4BMGNoKqLlowC3DUnUyM0+ng90mjBGwIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=85jnFGR2gg8UG+26ztyn9cLqPcKY0dyRFQU3h1rQBFc=;
 b=MvRaseaKno2xBJOVdbBkmwmdGAyKEkz7iUk2B1P433pJpJW+7ZH72oaid/tbzRUD1JtnuHTs953EesZoNPfN0d51bsgojXmCp0VRKgheSi+R/dcyl95RGrhGJKdvDW7qUyJdhRK2pdG1p5CIDxahGklxvHwMJ+F0WOIfnzhKd+k=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SN4PR10MB5557.namprd10.prod.outlook.com (2603:10b6:806:200::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.48; Sat, 6 Apr
 2024 01:27:47 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::7856:8db7:c1f6:fc59]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::7856:8db7:c1f6:fc59%4]) with mapi id 15.20.7409.042; Sat, 6 Apr 2024
 01:27:47 +0000
To: Arnd Bergmann <arnd@kernel.org>
Cc: "Manoj N. Kumar" <manoj@linux.ibm.com>,
        "Matthew R. Ochs"
 <mrochs@linux.ibm.com>,
        Uma Krishnan <ukrishn@linux.ibm.com>,
        "Martin K.
 Petersen" <martin.petersen@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Nathan Chancellor
 <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Bill
 Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] [v2] cxlflash: fix function pointer cast warnings
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20240404161524.3473857-1-arnd@kernel.org> (Arnd Bergmann's
	message of "Thu, 4 Apr 2024 18:14:58 +0200")
Organization: Oracle Corporation
Message-ID: <yq1il0vqnzv.fsf@ca-mkp.ca.oracle.com>
References: <20240404161524.3473857-1-arnd@kernel.org>
Date: Fri, 05 Apr 2024 21:27:45 -0400
Content-Type: text/plain
X-ClientProxiedBy: PH0PR07CA0066.namprd07.prod.outlook.com
 (2603:10b6:510:f::11) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SN4PR10MB5557:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	oEv1fGxva8YZtQSLZjXOo8zK56XfRKac1AnHOXvxj1utAl8dcPUyA2vuV18L8+KCY0pMN1R7Yhz7WaRiTnMh+6qDSY834UU9SPjg0v9WN1W2vOdZuBNrA9rzpMgeBZQTx2BjJhQ2RT2vAHtK4nFK/L+7iSNLH0gHxSFJ7HlFsdKs3c7dniKUDDJTPzc28CkuolQI1PRxry7UT1XWL3DllXNfUIhJmYKpr8y7gmp24N0hUotqgosRvpyezw/6dTsvV3wEKoRFFbXEbBUDr43Et3Mplu1ps8mOXQ8dnIGp3YyXPthjXvCISErLxGSlT5sWuAu5+qFvWwcXD0VGeI5+hBWx50l7jzr3yGgUAZNMQXyZKTm+VAIKrQ1m7nBOjuuP+7GnWnLt9x0yHvaYfF1c6WhwN1yI6S2Z9aH+mgcVlkm8YTecHaO5ww9QTTNEgEoqbFDKOF8AG6W4mkT6o1iZ/2zgmHuO2Ip5xo9TCAunIOydjE6KJTmip5zNXpECq1u856T9E5yXH57Md4sz57qBgEJdE8sJTJan+w550IlX7xOZx77QdTnmIAbljNdkfSim/U35tjhdmeW2MVbgqRJOPfPuc4m8yIN/mTV7seHoOAab3i/zZ83u6Eg1vPdFGQiSD0nyUbC63xPcl+ksiVhicnQ6naD+jFandREcSbRUR1M=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?4xwyU4EaEQBkPvuPYvYfJYWpZz7sk0Ga+DAUV5MfSxAduy1mjCw1EjtMsLw6?=
 =?us-ascii?Q?DpBGPcS/PQoSVEB0uYhQJd39fpRJ+cCDsroFgHQhigUby+d2kI7wdXK+hVg1?=
 =?us-ascii?Q?d7Pxh5dM7DxUvH7IIEjTe1pCWK7YC+liXex3C1GpmHHTA0efQ+ret9TNJ/Sy?=
 =?us-ascii?Q?ADHbUHPuRoVm7mYjuPM45vAyUpx0fSRu6vX7Fqs3+wkP0kQqDLI0J7puQDOh?=
 =?us-ascii?Q?wQI9lIVtdk5+MVMWwFWvbFarl/qtpMql9lftju73lzgG2ZhFfdefTrPcm7i8?=
 =?us-ascii?Q?SQ37LhooQzyvVV6mD86u+UJbZmfactAgNz8ilGEQtxgsrL98P3kqtjfyKRYF?=
 =?us-ascii?Q?mkNsGX8ggdjg7WbnBxcq8WKh2NGXcy0/3z0gHMBHOY3+lm6gRNm7W7YFwizu?=
 =?us-ascii?Q?F+SnKxLOZfQQ7si+4ixKU4W4SCb7w9qRjrEHYsSXc+ZmwoC4EeW7IISi6pw0?=
 =?us-ascii?Q?/1rbeyNocu5mKKXtnGkGv2hBMM2rFaRn2x8Rc5axNxD337OKbcoYCdhAeuzH?=
 =?us-ascii?Q?fFZ2bUXHNAPKNmN/ETnQYP10iQiSU2MDf/dTq/jYXOxhxH5FuUpRny1hOyLp?=
 =?us-ascii?Q?u/DIQjRkcJ1+JrEH1uEoaFCYftc1RSaV/ISzrivoCgeWZL5Grd0rIJavhoBJ?=
 =?us-ascii?Q?S8xrmMOaPJsoYNJZSnOqDfZvKAWrr16AVIVVxdj/aV4gwqtaxbe+jBX7dSLe?=
 =?us-ascii?Q?p9DrgA2G33MSOPdFOmTPaQNolQ2zBHr+WZiZLt6gMtf00DJiEUb0AP/ROj/c?=
 =?us-ascii?Q?eZ13UIGHc2QXc4cOLiE73NCM/kltBVOBW2CPgHYqiFXT4E/q2LF2bMT9G2vl?=
 =?us-ascii?Q?WcDFbgsdwDqb3/06r8yR67q8wc+cSoz/XZ+sPUudAhGlRtbPdbrEm2KkihTk?=
 =?us-ascii?Q?yG9OYGlHZ5x0NZpibkrkI9CQUWRixDlgRnUQbUcRLkJeni2IS8awqHj7uFbk?=
 =?us-ascii?Q?bMe3XgAhjt9QKNI46am+HahnzkOmsTTjBeouo0r8DuFriA+ZFW3DSvTyCOX9?=
 =?us-ascii?Q?1GIbqLqfXRbHH8nR3iadTf0TNb+WTGVWWyXsXfYHJd/SZBaCC4cAhJho6IZv?=
 =?us-ascii?Q?bNCjF4TFYBo1caXrUU17rt3Af8jtpcbdSOXwTRZLSnUWrk3yEdknKGls6YaW?=
 =?us-ascii?Q?KGzmfc8W38vbb4qV8g93m5CccRYFum5l7T4ytc6X/Q9OQ9Iq5+yAnKrZUthe?=
 =?us-ascii?Q?K5B8rUc5JjY1dkNQwpjfup+7mwIcEip9VkzsfA/F/NrdVTXIcSqRKtxfs8Sj?=
 =?us-ascii?Q?H/5fqWp375Y8sC1YGGi1O9XnAbL6g/va+Cl5og7OGOVp5vtscScvaKGq2rqm?=
 =?us-ascii?Q?fmvWcgCLAtFc8RUuBVkYGh1g1qYJGW2k0572dmMoRWrnYegZ8bh/YcyV8ppI?=
 =?us-ascii?Q?pbjwpLmXqFM9QKp/OaaslMs99f0YmCU5zRwEE7IaTQoGoNB+7BR8F4B9hdiH?=
 =?us-ascii?Q?OOfQljE5lCeS11plfYB66seozQvflkwgYJ18Xtg3x4eJ0tXvcLshnz3FBPE2?=
 =?us-ascii?Q?3GEnZ/l9pMTR/qm7XzZELbI6R0KFmCKTs5kkzjqndHDTR7ToBzPP1nPRqZai?=
 =?us-ascii?Q?Y0656Z1+Sdm/8WgimowTQZWuqWLxquBTj7wEY3qq9FGU4TsWHZTUK8/VSyL0?=
 =?us-ascii?Q?1Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	LS3xRURJwQT6+ESwm/niUBxzjHTsEVXoekkIUGRwi8/SXLzFq7Su9/PI/4fWOXxlaetTRZyM5OaXEpxloJ7snfxh6bjZdY7kT/CJgHdDxKrBHnQnTaO8rR2jPjggZQxC33JO126GTeHZCoJTYY85J6Myuy1DhJqt/ziQQf0dHSngPXjF4O8AombNiavAUszD+udIvkNwq80/lNdB3/8VQf4/5nb3FZBhfYMt9xbvw7GJ+tfydKYW5qa0+86HYOHJXr/5GxQqTHPP42dwoQ1cYiIci3ibEDaXHSsCb9qWbXQ6aLMsGQ12imKXVrK/lSeNPk/KEXJvk3Vrt/JAwARZ+MGzdr7RrNPmV+MBtyb59Cq01VCRO8KS9OiCDOMtKZt+6yXAWdghCdIgDR/OVQu51ww8JD1Ext28HhysjvNiTgiLYSdrpZsp/9Cv3SjOSlFuMlgmQLNAKjTrZRMX6S8C5G8uhPaaxQ1qsUDsSimJtd1jHt5LZ13Il9MWoDEhG33VdshdhWKTsyNf7SZH2KO+sljYIWSssxRltBs7gUvYC/8iFisRY1rbk0cWg91/oIbuiUQJTLNhbUw7c19TXsp8ht6LTQJVZbIXMt17+DhjnkU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 762c0d62-267f-4f36-554f-08dc55d8c41f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2024 01:27:47.3218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MaCIImx4xAsWIFRQ2P17vS8S0teA13EQ66C6EJIkzjooLzekzGQybZ+7kr/DemClM3V77iCcQtL2z+zcoKGndCpJJoDH1VJ3MPXwhsekY0A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5557
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_31,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 spamscore=0 phishscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404060009
X-Proofpoint-GUID: bMxyp37XVFPLbLAg0LIHmP43tlY5i9L8
X-Proofpoint-ORIG-GUID: bMxyp37XVFPLbLAg0LIHmP43tlY5i9L8


Arnd,

> Calling a function through an incompatible pointer type causes breaks
> kcfi, so clang warns about the assignments:
>
> drivers/scsi/cxlflash/main.c:3498:3: error: cast from 'int (*)(struct
> cxlflash_cfg *, struct ht_cxlflash_lun_provision *)' to 'hioctl' (aka
> 'int (*)(struct cxlflash_cfg *, void *)') converts to incompatible
> function type [-Werror,-Wcast-function-type-strict]
>  3498 |                 (hioctl)cxlflash_lun_provision },
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/scsi/cxlflash/main.c:3500:3: error: cast from 'int (*)(struct
> cxlflash_cfg *, struct ht_cxlflash_afu_debug *)' to 'hioctl' (aka 'int
> (*)(struct cxlflash_cfg *, void *)') converts to incompatible function
> type [-Werror,-Wcast-function-type-strict]
>  3500 |                 (hioctl)cxlflash_afu_debug },
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Address these by changing the functions to have the correct type
> and replace the function pointer cast with a cast of its argument.

Applied to 6.10/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

