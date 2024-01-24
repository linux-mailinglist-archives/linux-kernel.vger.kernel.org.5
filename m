Return-Path: <linux-kernel+bounces-36354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3439D839F9A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 03:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70D931C2267F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 02:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07F6168A9;
	Wed, 24 Jan 2024 02:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oW8uOWID";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zeczbsfp"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634CE1640B;
	Wed, 24 Jan 2024 02:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706064487; cv=fail; b=oGYxpyk02FjDdnhzRaVYGio55RDSu4awaU0g+v46Eiun0cJDA8YD5eYQLB2ty2IOwhJwUTdr6aWJmFRRDuMDQBJryMJUbxX8rLyx7K9D/yemZcG0+xdf2dqhajUhBqMPDN/+C25tTc5khVafB3Nx/MH6pGrYw6NtR434FP1oQus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706064487; c=relaxed/simple;
	bh=M5UiBgH8dDhgpMcpfVTHPnboCrGgpZgw4HEG1l3YxUU=;
	h=To:Cc:Subject:From:Message-ID:References:Date:In-Reply-To:
	 Content-Type:MIME-Version; b=O6sr7y2JYzMmgsCMZeUSm0PfsveWymU5fKd6qlSQdlYdk9YXJjKMJ2+DOvjysmwx7NVb6CkQZXZ2QxqcekcDRqSMQEgh8qbejqxdmL9Prs2+GHOGx5jgXcPbrfmamMUAfRNo0ZysqZ0/xY+IfYRI2pdNOf9t8feIiggFrE9TFpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oW8uOWID; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zeczbsfp; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40NN3Gng010897;
	Wed, 24 Jan 2024 02:47:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-11-20;
 bh=ZdsKS9SY9OuWL4RKfFHS1TZ5f3UOcunjRnuCzc4OIYE=;
 b=oW8uOWIDE/WLTY6/U3F4MOKki7Ay9x8Q65JDjYdyoT4cFy98gbest66kI9KIb4SqsPpj
 82y/21lPFU3hbtuYAyZS2zgYdgwjnA2+qoL0nMgBs/bdRvO3NY2vqc6n+J0YOIRN8Hdv
 XRAHag7Quy98yJ4GyUR9ucMXBFPfjuH070Fc9t7q+IA6Di83XTyKZ3G+MUK9BdQI/1Ai
 4IUYMUvPHaLCZhZA8oNssyLuPFE5t+KHf9eXeYsuASF6tFCMVkqmURTICZV1Czosi01x
 FaVOra2TQRiYTEY5vOgj4x3anKppDY5x0GdgLTjhogomCH+625/yDeInDiR2I5ctt57n Dw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7cwfyc0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 02:47:59 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40O1UMLX005437;
	Wed, 24 Jan 2024 02:47:59 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vs371rrew-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 02:47:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bTJArFISqxbPgwMq3aE5ojDUl58ygduDWnkiR8ODycL7EnY4ojJxC4jHmolpsUXQtCrOtlESEzjP3QPjU0T3QuMTDHa+JOBzSCH6gkU8elyK1LnLHiMeRnzsiiEeWv3lT5OxmkRuReeETL7c4a3SBOK7r2iH6IA8nQ1ekaSPx5oqlf21GRJlYfO+46wvbYs+1emebON9YB77eFRlkwA3MjMmOgialbpxBO7paIYXw9AtUFn4AF7Ktflq8Xy5GGdAx8YD+9/J3HttNjELEsWBpzH7/bzi+8go06NJZUbmJoNsE96zJ56kFLqqOf0+Yf/Wbw8KJYw9E/lTNE/gjEtFMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZdsKS9SY9OuWL4RKfFHS1TZ5f3UOcunjRnuCzc4OIYE=;
 b=LVVj3meJzeW5chtVxmZt4nlRll63iuwzv2NCrGiQ3K6X2RwWKG+zFcTW1uN58P1LUBx0er+IJa9l6KpmbepqL8/QzCUKXjwlAszl/+yJCVbuDXt1/ySmieWt4UXjTHoiXoAbOlUWB21BQB5NvE+zBmTpVyPasze+LYS/Lr5l9MtAvNTFszuXkOzNsk2djK6ZK5jIJ+5c70MmukQmXSpfquNwCMN4Z7pApWQ3rHvjms43Q3XSOdfJDJlfVSaEtRx//cGB5vNeZnjieiZb6wgPPcdV80E3xBI54BHCNDoiz+pp/oW4wLGxl84/6qytbccHy6FUcFUSEGWFL9NyQqEcXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZdsKS9SY9OuWL4RKfFHS1TZ5f3UOcunjRnuCzc4OIYE=;
 b=zeczbsfpUI7YwI/O6eKGyPKxs9+HYWnh59nALuDG4t9BLcXXOKxXTssP8x4NMPDBDCpb8J5YhhmHd+xNCXefFMd40mUcMOo+8EV4g9q7yJub/ndVdwx+9YmavloAh9uHbPH5cXN7WEZzfmDI/Nje5fBltMGG3rH9CxqFBlpPlZo=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SJ2PR10MB7057.namprd10.prod.outlook.com (2603:10b6:a03:4c8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 02:47:55 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::3676:ea76:7966:1654]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::3676:ea76:7966:1654%4]) with mapi id 15.20.7202.035; Wed, 24 Jan 2024
 02:47:55 +0000
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: satishkh@cisco.com, sebaddel@cisco.com, kartilak@cisco.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot
 <abaci@linux.alibaba.com>
Subject: Re: [PATCH] scsi: fnic: clean up some inconsistent indenting
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1ttn3wip8.fsf@ca-mkp.ca.oracle.com>
References: <20240118020128.24432-1-jiapeng.chong@linux.alibaba.com>
Date: Tue, 23 Jan 2024 21:47:53 -0500
In-Reply-To: <20240118020128.24432-1-jiapeng.chong@linux.alibaba.com> (Jiapeng
	Chong's message of "Thu, 18 Jan 2024 10:01:28 +0800")
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0445.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::30) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SJ2PR10MB7057:EE_
X-MS-Office365-Filtering-Correlation-Id: bddb5911-b525-4a23-0a40-08dc1c86ddfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	kSj9Hk6IR+Id5GCLfqnRys/4cw05cdE9VUr09bGe8V6NCNNwugIUsjfRaKYs1PZn4mSyzGNNFzL1JiwsBvC9xJc1PnRh5vVskh/pOnPizcLUqiERlKxVspl2mcgMD7XMxuLmGovrmoB4fIJ5W6ncbxtikNYCIuFPvlOuJtBwK8O4FHVDAF4XSLnzcT0/RQ5bawr7SZcTX1xH5sUDKY0JLKTRiLzxJx+sF2wYfC6mgUGHOa9s+SwkfG7wuwSJVI6/wGscHHNwrEkv+hZOx4g3lWmOpZ1Li45zmOr9asGUFuf+z8kzCAJfdIg/QE12cXKDX5sutGMTKA2G8nT463fgVtV8Lo7AgoTafu54PGPR7LvyMNGAhWRrYNPKuuHPKFwjsiYBsS8dVLywIbUfvlz+hAYn+jRnzab6Gp6wgAQF9g7tH536XCLBzeTB9N7Xgn74EUmiCluaJZajKMokJpU8Qso71xbHHhbkTX1o8/i4RUSHQ+Cxymt8Yd1Z1oDFbYyII2ZESgr48Pvu99A8GdRFhzRK2Z1yAbUmOlRjEew3fqdjHV7aPZaRo23kixDBfg7S
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(366004)(346002)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(2906002)(5660300002)(41300700001)(86362001)(558084003)(38100700002)(316002)(6916009)(66946007)(66476007)(66556008)(6512007)(8676002)(26005)(478600001)(36916002)(6506007)(6486002)(8936002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?RxCdCBgjfC0sEiVdEamyGgWNnKUCN0bchBoNpF5NCeXJozGfBYnvSDve4vP6?=
 =?us-ascii?Q?L8n6WU8Lp1Hw9AW5c5/UMKoikeWmK5eOn2nFonBbghbhC3H6EJ0qOSmrocoq?=
 =?us-ascii?Q?tMqnsG2MGA9fOcwmkXO2dzcM/1XU8DE1ZtJqgVdwHLxqSMbXob66kWbIApxY?=
 =?us-ascii?Q?5NJeKOJdRq5KTLU71A+93a9v0aZod6Nds8BAZ+8sNr6s90f2VAXjTs2BhUs2?=
 =?us-ascii?Q?h3XDNdqFFdKAg4xDIvZsNp6KRrchgCk2LIbbahD1UKJCDxtu+pX5MbLLw9Mw?=
 =?us-ascii?Q?u2/2cFe0cx7uCQ7F28BxsAKoeMePsY5GGTD1nBRLX2ekA5Li1N1vI6C7cZxu?=
 =?us-ascii?Q?3x+SJhFLWR/mtSfYNv1TOFJbtdWu/1f3hVqbQIqXXf/+Sl+SFi418gNr9RAS?=
 =?us-ascii?Q?i6fDoNN+Xnsx+KGMM54uCRsUU/e7VrObyu521KLQlobUWEY8KFhgqoPYEZJR?=
 =?us-ascii?Q?9sqpXv+mqGF3+++0N1wrfpOJew5XHbz2WBNKdLdFTW17l1jZ0L+38pSk88e8?=
 =?us-ascii?Q?TvBcDu4ChIm41VxPSYq768tn2VpDWpz0idSq9EgE1BP9DIJLOVkcFiSNuFGX?=
 =?us-ascii?Q?6Nauud05Esogex4J/4r268bhowL9EDWucd9ZVTwwIrVpoKnvX047ajB7VC37?=
 =?us-ascii?Q?6WfcXdtrrCoVKHL/oyZWNTW4Hyoh0BI0IxSN+YplxUoZq1g0Aw9Ob4sqZlpb?=
 =?us-ascii?Q?LE0B1Sfjk8umk3jVRdlKUI8oRXd8pa1STROEzCwB/F/OapVOGT5Wga+PKAZE?=
 =?us-ascii?Q?kWyEJwdvKS6+QD0IpydOLVf1sdMlRLaOKdbjI3CGBgvEHylbV8HEnJqOn55B?=
 =?us-ascii?Q?EvI2N6zVNUJxiDxCRqEqZa/pkwdDRympjQyPblPSwqcA+vPRnw4+KYoiLNp3?=
 =?us-ascii?Q?Hg9XkeB+jYcvaCWBRSI98xSlWHf3hlkccPwMJvR1nSf/fhzIX0pbjsppiTEO?=
 =?us-ascii?Q?IFAUvXnBPyyAdxPDR0+mVMg8AV4YlJhVcC37qGplxU/vh5hLcUgubki5nSE1?=
 =?us-ascii?Q?xaeZHpnKrlwxhvMy4/bMmnLzLgqkh/cmd0GWLvzpFJ/HeSDte3GQt0K+g7m4?=
 =?us-ascii?Q?fnFh0jNu7ZDecSHsgKNmD997q6RpR/jX2s9uhHPlka+1UgQOcaBUKSPNKpcn?=
 =?us-ascii?Q?7qCs03oHd1Q3bdLVbWQvZFsNDNIjcdlXOJIybA1UqeckpqqjMIyH9Y6ZdURK?=
 =?us-ascii?Q?ldDADgeJWpmK3bxVnuzTBCoVABxjK+mj00AZ+KGpzQILhjVeSHxQtJKGQJFt?=
 =?us-ascii?Q?ozjrruaVhUkF7YqqBZhfPwZE5wdXf6KbUPbwi7ymvN3bVJna9ZRwSeKE3kTr?=
 =?us-ascii?Q?A9gyYrERz2EXvPIi8ixzOfvEyLrn4uq6Y0HYjeS5rogBNrEIcW/Ud5TVU4iR?=
 =?us-ascii?Q?kOF+2iMg1V9ptxrKnsLCluZQwM+oRQmVso/iTv1bS+Dkra/L91LsL83iThzc?=
 =?us-ascii?Q?vzKijZqb1NG7pbfYviCU9SnFDcTUpUWJAjdlO98ZmjPszXqd6jqf2Ym44KpH?=
 =?us-ascii?Q?ezEo8efNgnCtEvcTdA3HPnKXx56dyeTrZTWL+Jk5jTT/vZM1OUhL0mK/wWUC?=
 =?us-ascii?Q?vl2cYXoPeslrXvEJxnVufiFAYqFZ8pDn2lGkOWoQa4z0dctrk571mBU3/Efp?=
 =?us-ascii?Q?tw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	1o1NiQbKUed9FbE705ejzsA9/0euzV3YE2pMLUOLDRyliVRK3W4dFfTqPtFIn9HhnAvO0nLOXrqvC6t6gzbO3wwtpKk4PH4spcKsAI7rvAV/DGsIvCNarvp9H0Rwt1tBgOdbtTaCD+FClRKIUO5CwMQBHKOzuLxuqxldHe7ZChudc+CDU7jFHuZIUq3cYJm+g9RD3SwpuD8ba+LkmjBjmhoov5bn3lq3dp1g2pjGczpx34RZbQY+indFaO7tjt81kBsQ3mFQwoOUUs6UQqw7q0MTceW+kT3aaSN6JzU8rXSXoiUWi010aVyEE4Cu9yl0RvmuEsmgkyM0GaCyfgKmypYMmbVNO32VSV8UuoOxjQDxS6ZDH3HpEQ4ijY7MYmWigcqvzyjGS9XJRiyEmmqFkSPOiQ2b+k0D7b8tAmkBMU9/JVapFdGqaCu5wxYWlJs88c8cxPui7Kt7bkkh4Ra4x+KUWHkb1RoZswvskv+zadOoiDWmBzF+9zOLTfac3ffVGzhrTRMGz3tsVqmjpL9gvIo40lc30zDBF5AHmq5f0VCrg/AbSzRETynjGFq8MlRIvb4b/jAHv+p9Dvbbx4p4hsKemerEtYT+QLqP2+3mYaA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bddb5911-b525-4a23-0a40-08dc1c86ddfe
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 02:47:55.6288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BmY7sLZVvO8C36wgFolc4UUHJbh21hjXrwQiqe7kTPc5fdXjiP8XCGPzy8eggDKL7WUsPSEyHMGYwkD4/u9dpLaFqWTKLp1VfWHf9mIR/VQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7057
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_15,2024-01-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 mlxlogscore=600 mlxscore=0 phishscore=0 adultscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401240019
X-Proofpoint-ORIG-GUID: 4Joyu9zRp9nrICYSe_Ly7rwcWZFrReGO
X-Proofpoint-GUID: 4Joyu9zRp9nrICYSe_Ly7rwcWZFrReGO


Jiapeng,

> No functional modification involved.
>
> drivers/scsi/fnic/fnic_scsi.c:1964 fnic_abort_cmd() warn: inconsistent indenting.

Applied to 6.9/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

