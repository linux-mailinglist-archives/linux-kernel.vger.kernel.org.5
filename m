Return-Path: <linux-kernel+bounces-53993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD2A84A8F0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 23:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7764B1F303E1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F11D6027A;
	Mon,  5 Feb 2024 22:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="V9YZBRSM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ry/YskJH"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8160A60256;
	Mon,  5 Feb 2024 22:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707170558; cv=fail; b=L4sYiUCzvgJEAHvjaaIM+6/DL1lBEIAhYnCn5ynrmSownYcp2hb1ckoaThxskBSesqvvl1s6jeCYxd6/cqKtZ4i/szIGje/R95vn9NXJ6QZ+gLrioa8U6ymre9oxgnp44AgJ3CjelNQ+U4UfH51qwUQo+gwFmbAFYZs+kicSToY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707170558; c=relaxed/simple;
	bh=NcYaB6soiPMGd77SJ4cRMDRSfCJBhQ8DwwNYhjwYIyw=;
	h=To:Cc:Subject:From:Message-ID:References:Date:In-Reply-To:
	 Content-Type:MIME-Version; b=PXxpDW72faUB4XPuIPtOAZ7JWk5vvCuA3fC/X5kbbDisnFUXKawvnyxdpAKw9ZPKgWCELXI4ViX7p8En1XrE8RbWjyW779D0oPjW/X9WUBjXPgnbGHRjZtLhI0atJkArGFSXqz8xRfjpiev8sQ310ezs5UgFdJFY0ILfLRuYwtA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=V9YZBRSM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ry/YskJH; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 415LDxav016021;
	Mon, 5 Feb 2024 22:02:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-11-20;
 bh=aesKaKatfjanB+yKFoVtF2JU66dTdu+BYoHeQU45vZM=;
 b=V9YZBRSMrkQGwjc/XFzIZPRRLdH0iYiQkWoycotcWxnqr67BLyGEz02seMgI7kBDvmU5
 9Km0Ujq2fTPK4IeA31ou4GTnR79qHmmPtNSZGzsP4MIdON2FovfxTOxD1DL8r+UO1sGo
 dM382zDZF9i5PA2xSAyEK0wxUyLTQSMsrnyikR0axMGgepq8bAQ+q2ljKsXtelyq3D6V
 im0Ta7YeG6ypvwlJbyk9Jq+2I1nYhWFL2bndKlryIZe0aGumgYyAVDfP1+FhB0b9qkAS
 s1oT++rS7O6vc6rUYDJ0asueQ0m6GLll8hCGThV5OKcJfo8dv7I8aNMEn2m8SKd7aurU Ww== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1c93w9u3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Feb 2024 22:02:18 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 415KTHVR038421;
	Mon, 5 Feb 2024 22:02:17 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bx6djmg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Feb 2024 22:02:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S3VB5T4CjeLsXI3qzuai2DjPZYfYd91HljjYqSmdmb46U4Wd1o0hPk37ohJej1wVFg9EltXLy+PZngUaErIpgACcf4kPUhGjzJJJsoykBD0ul9pBR0h8+BplqdwpA7sV8qGGFx3g2Bf6NNL4QOczE7YGzltZLVcYmo1lvpvxqVrw/Z3mAGMwckYwqZQWvBrcObNGEg9QGMaUzvIy7sngXHwyCvYdAA5Xpy+5cal9o0FHK3MQhLI8hwXBdaWFf/NPouzaB++snHGv1gY5SQA9omJlqh4d+DpuHo/19f3q91FanMKMqn49rQZBdh9f4ZrXr0cF9359KSALuzL3v1w9hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aesKaKatfjanB+yKFoVtF2JU66dTdu+BYoHeQU45vZM=;
 b=FgwfEAvMo6H/bFxXu2s1kLX5scV2WZJUeE/LNnUQwemk8OKUhAUjRU+sCjkvgiv8ncWeCFsaSX5/JT8TFzuBlfkiRAFrliy9RIq108HCWLEXCpxzqJXVrHqYOG7fMsVwhkmR0S25iKHYxHwdRFDY+mDsz/smD4RrxPmh1GV+IujPxEqCxs33V2msyqBWEdnYw9DYaR9G8Nry4uwUE3JP0wukDV64A4lBj/1MugV7NEJQdpQHtiZLe9mN0qAlki5xMWDKPxKTJEkd/9eFpdFLsR4lA9FQKVQHZE6TN72vdVE5hSPx2Y4QrvZfn7GibegLmr2sOvM/U44j1FSLuNEAyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aesKaKatfjanB+yKFoVtF2JU66dTdu+BYoHeQU45vZM=;
 b=Ry/YskJHJRvT9dCY0LExsMLa4nX6V4qlETcI8R+H1pAWMFj/YuF3F/r7kmjTD49MmFTPVJVHy+RhE/VGKm8pVq+7ALIBYTmihj29leXOXQC5PDLQrl593+zaGn4j6AP37EHy44TgQao+WHjYCw0KNfgM3FBe5HgEnflztbLqZes=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SA1PR10MB5888.namprd10.prod.outlook.com (2603:10b6:806:22b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 22:02:14 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::3676:ea76:7966:1654]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::3676:ea76:7966:1654%4]) with mapi id 15.20.7249.035; Mon, 5 Feb 2024
 22:02:14 +0000
To: Fullway Wang <fullwaywang@outlook.com>
Cc: bootc@bootc.net, martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        fullwaywang@tencent.com
Subject: Re: [PATCH] target: sbp: integer overflow and potential memory
 corruption
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1h6impo5p.fsf@ca-mkp.ca.oracle.com>
References: <PH7PR20MB59258C767EF853A54273B3A7BF712@PH7PR20MB5925.namprd20.prod.outlook.com>
Date: Mon, 05 Feb 2024 17:02:12 -0500
In-Reply-To: <PH7PR20MB59258C767EF853A54273B3A7BF712@PH7PR20MB5925.namprd20.prod.outlook.com>
	(Fullway Wang's message of "Thu, 18 Jan 2024 11:19:59 +0800")
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0056.namprd05.prod.outlook.com
 (2603:10b6:a03:74::33) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SA1PR10MB5888:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b4f1be7-ee2d-4fc4-6ae7-08dc26961c93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ppfHhipYeFMDgMkf2HaVTllyVKg7KDZUfs+sNoPTxYRr8Y+VWUFe7MGj42tVLKMXFc1uIukez4uphHisHIVF8QPl8gBV5R9Pka2mP4sxyezaYFm0Nf3kIIvaIMgp4zS5yF2eN3GBbZV8qLyfoWXQqXCb05EuQqrCYPD6apdvkksVlbPYFDo9LIOTo5wYxwsRXEjuYWg6DqhxB+aOFR3v8XarlIeEXMiq+sQHxxITkhB9CFibtK7IaTyjz6e3gvPy+clL9puY2vPKqtDV054bSm+3dBQEb89V6focXXElrtdUjcLMeKPCiacUVNGekdFTL1/5PFxloUEZEI5FcPO/oNrySFep1UWw+htpZXVVzA/9SlQWHSe+Mgykf7Kdfru4/sVe+Sbz8jZWzBhrmTgbqelNVWSm/cBcDmal0TWZRr281U9ygh5O57dFe9fDwC5fBV1FK4vHL1BX6bGvM2lI/tRYH1H5/z/8DCH2c1Vhzaz4sgPDf+ZaUEdNx6NR7IULecOByO0Rzzx9PdnQr/Odg5OA9m/0ud5eElZfN4SzChh/T6jZOmEUKX5WJqak/GIY
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(136003)(366004)(396003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(66556008)(66476007)(41300700001)(38100700002)(478600001)(2906002)(5660300002)(4744005)(83380400001)(26005)(6512007)(36916002)(6506007)(6486002)(8936002)(8676002)(4326008)(66946007)(6916009)(316002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Ot9/OSSB6yNZL/ytAVah9uD3xv9B/qmnpcaVKZxXo3b93S2bBRULp5wtrvAj?=
 =?us-ascii?Q?TS4CAWb+oROxRriziAs5gIgWaHNyR5FrP+MO7M4D00J2gCL1TCZKkAQ/XmNA?=
 =?us-ascii?Q?KoFFr4oKj7b3nlDV5ZGEMpTWY7rcVWXvG6XpBRauY49w4ddQ9W8vHJqqCqe0?=
 =?us-ascii?Q?3tbHj/rhJnXzwzZMuiYeS+rH1uVD2OowdpDZG/V2rCYvL30oPpb/bGGeMBck?=
 =?us-ascii?Q?6hFO6DAytMSDX5uM5NfJ/XeCFRt4rg+4HrZ0nHyag1iKqKGEwUFq0bCMxVMV?=
 =?us-ascii?Q?JCF4CAPifyc6Zdemk8y79gOhBnldDYgqyqcAcs/yOXxOys1KXi0+fks/5RGJ?=
 =?us-ascii?Q?NidmqlqD7jjEWIHsUOU5SkHQflCZeuo6j6ixikYZemeu8WQO2jpVGRu4z4JO?=
 =?us-ascii?Q?ggY54Bfb5jgofGUAcz5R2rFYl/FFNcxUsCDQpNWstnDAfZwgpwqlnfILFjE1?=
 =?us-ascii?Q?W10DH92qFnM1tGka+4XpHxjkZo7Fqc18SR9kcirAWQ7TGgOpw6dQq62Zqj9Q?=
 =?us-ascii?Q?V4uN8NnhXGrKqYL7bY56W8p5k+M/DoDivrc9dQVS2HT2kgPsRF8bmPvC9bin?=
 =?us-ascii?Q?5iW5pBEt9Gwb8nYdq+Q0SS9n0jE+5qwOBOmDVqGYMUQw+ufP2HkRmwTATh2b?=
 =?us-ascii?Q?SEPg5wvqIX/SxsO1+XI8kz2cO7Sbw1FZ4/oWfMrde966GmS4ZVr883cNy++7?=
 =?us-ascii?Q?PQRZ5jU4Lr4AxL6n1k8sU8l2PvbJsqTLw7/b1xKyl/KUS4caUFe7woj3/DnJ?=
 =?us-ascii?Q?xQhXtWHS4T7EU/c0wEo801rxQd+/x3DTQCz97c8v8HCZwKMXIL6RjcW+UMyD?=
 =?us-ascii?Q?uKb0wyOieC1M3vMBgB+h1m78tjWfPz2pCjtK0vEB0LthCHZzYjlRaathqMMI?=
 =?us-ascii?Q?0winhHS+SqHs+U5pspDqh10xN2N+6YNWBvZCbvDlZ4E/YpuDqg3iAt1SUf78?=
 =?us-ascii?Q?HcYzEuPbb6nEpjEoa06JkqigTpS11EW7qwGUvWbqZoplAwTsSsgRAyupd2Cp?=
 =?us-ascii?Q?UylLLOc1totFSL292cr8k+SW6umdCDmKnBesK8Q6Cf3Y2FQyPLZXjSDA/NEo?=
 =?us-ascii?Q?URcRrq+clASkgvR93NbGZiGgU0+hwOJxAVOQD5Cp0XlI0FM2vVvcCtVVVOeF?=
 =?us-ascii?Q?FNM8lTP0N7g3v2bcs9Ls2QYdU5jev0a8Sgcnnz/jQWypGn+SpUDvMsERmRf+?=
 =?us-ascii?Q?ffqJcGG5iKJsciWkF0Yo0odaaNv0rhVg4esrUzykKY5vxHpIbSJP+PqBtqLC?=
 =?us-ascii?Q?oaG/bRK5GyEzXDDFJSavoJWWBOeItSarOMdlN1PPjFdE5D2vf8Dms1y0zV/0?=
 =?us-ascii?Q?F7RaWF4gHXcLeL14fWLGqar9z5tih/j8yjNG1D1ok6uCfsL/pyGuwc6hiTfl?=
 =?us-ascii?Q?Lex68l2GBCKlk4lazsv4gApDcqx05YmFVmk1SKN/bCunk7TjcdM1lqfs6yDt?=
 =?us-ascii?Q?2u8kgyKBWF/TWiQe5pXlMAsnhdsVazNcXhKZux6wMqQmje3C8tXLk/y2mMTj?=
 =?us-ascii?Q?XLbpE+DT/E6SVA9gtG+lM3jwNN3WbJncTh43BS62z9VPo102vwNhp7BgE1bM?=
 =?us-ascii?Q?sAIbeetZdBQTZU7gB8WO/yuOxDcdd9MOvmmAAeIn2Iw5O/mzyOKrnbNJxUQ7?=
 =?us-ascii?Q?Kw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	oju4IQD5VANITSTE7hW4ZPxlRWd5fmR2brWkFl+4UEjxSIUc574Vsg35QaOfLqBwJWTR6Lur78mbLrdowJuya5TxCSFRY+utGauU5Lw2s4JQDGKVKI8V2SDbFALfinVaYhVMMlZ/Fk8gXZra3/jQXi/02prZesU0HwBTTv+vl1kOhGFByFZFEn1QdAEJZZLAP0AIPMfzTVM2+y3/g/Xg8ldEOXUN27xw+TpdLwdH2FwULodv3dJ4Fvp0Ou+aJnxdDPXrDqpzfX8Ty5BYWyJNdcpwz+zj+1jkbub1YAFyXUXqWxyVUVjAS0X6064yEZdHVDGGpxga8C/KFlrYVK90G7n+Xmw3JDFNFi9Jj+/6WhL6/qxc2YLO3AVbszT/DY4xgcJbJo30OZ0kfv5i2QSAcrYOi/aj7VF6DDn0stqp5Cq9qBFaHlooA6q3tY/cx6UJmPL9dFnaBGU8LRu1TjFcwplq150OHTN8GaHvO4MRfca/OIffu7rJxuZRRNwqEKSR/8dnNMo/XsraFgwxCSBumMZl2L7bM2UskIFCtdvHhkkkQ5tZ7SaENRUHUPhucr6L8foz/+ansLYRUERRtd3RX+oe/2vhQDxeBBDjCkrCzTM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b4f1be7-ee2d-4fc4-6ae7-08dc26961c93
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 22:02:14.7027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5aBIR3b5FXY1njpbFs0/uL2nkjLBxwGmvq1qVF5dAz3hhh8G6dlHTAiFr8FIsIDZd63wbV32IQblahEE0pcUX3Q0zI6k3FzzPx0MjzXWp6Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5888
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_16,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 mlxlogscore=521 phishscore=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402050165
X-Proofpoint-ORIG-GUID: pCs-7oOZwC2IN6YgwwGI9l7qy-vHFVjT
X-Proofpoint-GUID: pCs-7oOZwC2IN6YgwwGI9l7qy-vHFVjT


Fullway,

> The code in sbp_make_tpg() is confusing because tpgt was limited
> to UINT_MAX but the datatype of tpg->tport_tpgt is actually u16.
> Correctly fix the data type problem to avoid integer overflow.
>
> This is similar to CVE-2015-4036 in the sense that sbp is a clone
> of vhost/scsi, and the bug was inherited but never fixed.

> +#define SBP_MAX_TARGET	256

Why 256?

-- 
Martin K. Petersen	Oracle Linux Engineering

