Return-Path: <linux-kernel+bounces-69354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D487C8587C5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 22:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 571A51F23D8F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 21:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6210A1487E4;
	Fri, 16 Feb 2024 21:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SvJaCzwu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CbBw1b2n"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20A11468FE
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 21:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708118039; cv=fail; b=N98/lIy5FDwaKna3v+lUJhw/4MvY1vLWQ+BDcMgvqh22tRgPL1SsbJ4sm6U++aMbdLw49nqwrMH0Ehbkb3UU04s9TNIk/2HDfCB9fZotpSB6h0P15bpVtfDUlcM4720+uWzZnWuW/pEOxq+7AJlbLykpK/+wVUNsYsK4k7DE7fM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708118039; c=relaxed/simple;
	bh=H0JZum5ES+kw9HDtgbRLmJS7ZMB/DGKWwIw/KZwLn64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c+fC5lvyRNX2sHePThWkQnM9gZfxe2FBln4u37Oe+odH2mu1cOnEvCyYR6gp95srMTB4lI8UcVyNIVho7iF+1NPr+taH+JSqGDPEwuffiKmOHV2fpBsmo5soHaRh+dDWFs7xpm5NRMqsMdQkToDpj4xu0vAEAHQ9zms5aihkyzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SvJaCzwu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CbBw1b2n; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41GKDor6012510;
	Fri, 16 Feb 2024 21:13:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=Zyj5W/hf5fQSEZwMGqMHlWaHWhn7dkZCnmqh3nzq8a0=;
 b=SvJaCzwuFlkngzUkH6QOCm6LPDEMMxPgwses7Sz9fnOUPtCxxDb9CBoYiuYGJvp+cTrK
 j4WITKH9YivFJrAHkzXdF6L2rP1gK7vUp66NngMvdqwUc+NWeAfZoO877p2oCRAqukqb
 7AxDqsZ8HNmjvjjwO0Vnlv28otLHVaqL3iWlxxQWJ80WSubcSpaf9ZocaWTPw8Fbe3QH
 foqiEJOCzb852x/eD7v8lz0ipQ9tLXN7H3QZKVBOnBE/ht18Z1GjUMW0O39QVvPvPkmC
 ryocQsVxDfB89hBugi/pNaxFzlXMYS04QXytQHXoBuqfYV1N3kJzb9IjG+VZG6V5clQ1 Xg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w9301659j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Feb 2024 21:13:49 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41GL4CMO024548;
	Fri, 16 Feb 2024 21:13:38 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5ykk0v8y-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Feb 2024 21:13:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IM8Z4Rg7sSGh5h+SXJcRjXElgZGT7mC35vy3bHb76TwEBdgxz7BG6VY/yPADdfJq+xPSuInbEFdaiK6jglKT6A59HwVn+bgmF413d36Fy9HWnKmdN9fTVZdvcLuHXHXAmGCEo6l1SbPfbJANL/pyaK5uVONJKI6vDGcH9NrrzLBpQHhg9pcdGC2vRHIL1x3sAye+XbQO2jpHlWKOy+C4pRU3AFtGe2VUX/bfVvtnf4ftCoMOUYsDdCtNHS8moBEZRZsbdrxEuGnuK9avnCVXVtS3rupEsY3wqOipsrty8qoirPBYOquVPeK16M7g4Wcp6kQk21D3triAy1yzCXjkNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zyj5W/hf5fQSEZwMGqMHlWaHWhn7dkZCnmqh3nzq8a0=;
 b=WFRlmtUJZ1Jb4y7TaOrhHEK8VPC0mrEZ2b6DHaireyHCYHJjuTEZGaR3fUWKLAjkMrW8Csg5vnHpDyhXdgfeeLJ3J7iN0sCTY0kFyBumQgfqTRrG8ksF/PUCXBqsrn0ZQaRo4Nrd8nVYiqQSlzls17LWwAEoiJc7cG2yhKqIJDCVVG6TU/NvYs64bKDPbx95rnjxynDZZ6NLblql8idLpvEayBkzsTrudwt2JwJhNVjkpnh1H9lAXg32Hc9RNmCDW0Jub+WK8wmyR7Mo+GrGWj9l/CWbXL8J9eurQRKSkftRSE/Gf1zONrfOLsC8pQh2NKzncoxHFQ/hDHbICTJJuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zyj5W/hf5fQSEZwMGqMHlWaHWhn7dkZCnmqh3nzq8a0=;
 b=CbBw1b2n4wxdDJ7LAHgpFUR0ZiVi14p/nwqAd6SCobReksXGw8OiYeFIVmM7FGM1ty7B+6AiutqI2KntqMiIsFKU6ozuWxduOLLtBEx2PbAFc1r9Gw5zTif3w7StngmXBKgqLnDQACrmU+8zZoeaBwR/sTxGfNIrECLXjofi9L8=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by DS7PR10MB4909.namprd10.prod.outlook.com (2603:10b6:5:3b0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Fri, 16 Feb
 2024 21:13:33 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::7eeb:3b3e:601:2e14]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::7eeb:3b3e:601:2e14%3]) with mapi id 15.20.7292.029; Fri, 16 Feb 2024
 21:13:33 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc: akpm@linux-foundation.org, willy@infradead.org, apopple@nvidia.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v2 4/6] mm/migrate_device: convert __migrate_device_pages() to folios
Date: Fri, 16 Feb 2024 13:13:18 -0800
Message-ID: <20240216211320.222431-4-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240216211320.222431-1-sidhartha.kumar@oracle.com>
References: <20240216211320.222431-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR01CA0028.prod.exchangelabs.com (2603:10b6:208:71::41)
 To CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|DS7PR10MB4909:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e271ba0-0976-4c89-cbb6-08dc2f342218
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	FUyb7f1munmSpR/UF2LJPu05v+cEdkvEzvd25TvAFFacogGUKkP7vRcx1BY2CR83p1fn6+awsmgrEubIH3Z1YXVDt0KwmW07GhbXdJkriLCrdpBBZ2k5QMHpO195tsgsBvCW3Fwosn6WaJll1sFol29EkCMRrM+Yr4++/2WswoBjMi6Cfa9vA2XjZOIT0+8EsrehzcqsvnCDSjPPHaGM+j/4bJmiCROuLGz24MZ2QpSRP1h5tO6vm877Cbo5YJV+xeUI4Mm3yEhiu1D+uZF7uGCZQ/eZ3pwZvYbBbZ3t3KAl50Cs23K6L7QcXuBsaHOWKTx15yl91PKTt0aJSdvdnoeNJRmIug0Ha+B3c182D1mZx9IU31KYQ1kTtstY+cfE7hHTwlvJo8DDzMqgVcgBeBl1nbfBemD4/FWcZXXKzyYDQzdGWw3yd14Qjwvyy8ffxJWaDrtQGPYi+5ndHcyv1F2XSfOaRh3jwQYAVFRs/xLSdXdND/CyI3SarDgP5BwIRKU+57URkT1UUvzYhmeNG769/iMrrUiL0donm66oUlZofpAk2bIVxIDiJ0vYXv+o
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(396003)(376002)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(86362001)(36756003)(38100700002)(6486002)(41300700001)(6506007)(316002)(6666004)(478600001)(6512007)(83380400001)(2616005)(107886003)(1076003)(4326008)(5660300002)(8676002)(8936002)(2906002)(66476007)(66946007)(44832011)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?4xIVIZPamx/1xZcasHBsVPox7dPBNcBxwLVYz8+1qZUTWPvdJWSEn5odBqJs?=
 =?us-ascii?Q?tOYwLHtU+zgkzuMCxCc6E7Nte68k5RiYY4Hs9MdmEkR7T4Q9HDxUEBLUAbD+?=
 =?us-ascii?Q?aL1tdh/7pkveIeXrpXV39vYdHllw50JwJsOHo97gcGCG/USwYJrlj1QflEYg?=
 =?us-ascii?Q?uLRTZg2pg1XRISNSoH8F1el+MtyAsIu4sJr/kunPLIksJf/4yJFH243Wj9Qn?=
 =?us-ascii?Q?Z0IttKKSJUqjJT84unmIqhfNf/XwEJK1uv6DJTPvxLHX4bNpU+Ol6IOcQWEb?=
 =?us-ascii?Q?7I0YzWltfkm0g0TUCCWzxm6xQZaWtyUTn2occL01qzv3/5Dh7zldzcLY0Jw5?=
 =?us-ascii?Q?VrUeRC3of9rAkTW+9MfoH6Bbc22g2E8pVAK3gRV1xrNPK63T6VkBa51qK6/q?=
 =?us-ascii?Q?bpuPPILAW+6+sWE4VOXQbHxuZ0OZNEkmn3uaNkPmqkPyiZMD5ArkLC8hHaGR?=
 =?us-ascii?Q?kQlfAi8SfN2URPIUxzEpjJ2f5qf4UFOreTfwzTsjCvQG4DqG6o88l/kn0Bmw?=
 =?us-ascii?Q?d0MgcBNpUPUo/ewte6B6+S6lym03CTs/Bs44QoWhgfT3C65Tta4BdXnrIpXy?=
 =?us-ascii?Q?viii0pl6DtOUtP+4HSAI53O/hiJ7QUvIFWg8WtCqnhTQufyLzRXLOMAE6UrJ?=
 =?us-ascii?Q?cKfLghy9M2+CScqzfDuJW5IzgoAd0p2QypvFpNszr5Cc+Y8+CdEHyOSVr2pY?=
 =?us-ascii?Q?0CTCUaPVEJR8ngGihbW3ymSz6WlV28LUvN0ZhfdYCaQMijUfd7BrTIX32KXo?=
 =?us-ascii?Q?EzVoI98nOUqR4HpUifz+YVyJDsQWJ2+s/0NAvcZ041qCxJsxxYPPiDgGho4t?=
 =?us-ascii?Q?hTvpXvez1jpcKrXE1QZoiRYFnFsEr9StAOiaFiXeBDYq9j9BqAeRuVcqsxpO?=
 =?us-ascii?Q?pil4l++NdY1nArTnLfg/WBCvo8v9IqqaiLEwlx87nPK4YQqtyDLQ46Y781zk?=
 =?us-ascii?Q?blRTC6t+OEVBPm9d8qDH9x6wIwY+aDz0MitdCCRXy4n5MVHUKef+whOGIMpg?=
 =?us-ascii?Q?uCvY65xYogh68ardle8xlKWXOOHLCc09XUkFn/wdHlPqobqxR321PtxRcRsk?=
 =?us-ascii?Q?uUtjvt7nzQOqV1wRl1vGTe5WPGA3Wqtp+8FhBoMrIvBKTOLvKAeL56lEocf9?=
 =?us-ascii?Q?ifCK1rVcMRpwmEjmEfoWqQ7ad1n7JuLQR1z1sg+nP6ojb6MQaIJZqocNOvSp?=
 =?us-ascii?Q?R1evfkgNtzbVwSfahHMkgjsQoAfAdoGAGZUQFYm37gW2yPRi7E5GeIelHCdC?=
 =?us-ascii?Q?yriYHsUWeC2TK8VAlCb097jJZVgSS8tCU7CbubsiF9m7fJpoQNqKMjsGQ5Ga?=
 =?us-ascii?Q?FeSZdX5jnWD/nMLQqxYnCHlxVR0OFL844cvXmnYqZFyC8SKQ/HV9qHPYXSo6?=
 =?us-ascii?Q?4tJT02a1JltTmIwQXM7fH9bu6bRu5PgnyVrPf3WQNWiQQ6SWZdcaou7jiCui?=
 =?us-ascii?Q?EaZjTvvOl3TOb4BFjzA5pR35dzYVgAS01fRCF3MShog84TGbWUyO2LKGFYq0?=
 =?us-ascii?Q?Caph1n4eXLemS1M2+x25zCsFyW9Ti16H1zjjcjWPjk5ddIxqgv5mnuLWhrez?=
 =?us-ascii?Q?2h1SOqfPfiDe192OsgxZfeC6nB1/yKYdNDD0/O2kih952pVKV2/2pklwSSIV?=
 =?us-ascii?Q?GV6wuTmg7OH6KbvCIKmKvuY=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	65DvB0RVyAHZmhsDHyznxtxkGOfObuL1AtS7jIc/k+UtshofJxQPSFL+hLkCs2ofdiC2ZF1CYeJ8aOqZ97BisxNX96J2Vqksmg3YzeU2kBtxyvDrxe9yXOxQQ9pBreQ5ICSIAwTcp5bK21bLlgoXlgkjjIjvcf2fyZUMvtgF/MKLfEQpTRqlsl69cOXKqCyht/jL6mhAT9MIxG8+SCqcgMG+Vn5qpOk6YPz7G3dvG+Xj/II/Awc+H8wEzBLUns9XrD7+kZtTOZzJ67lnDpeVcwZ3iPgVGoeCdQDQS8u7E4oGmpMC1gIPg6oW2sT+9cVTFSWPwafiffQqoqquNr/dxhzWw5xyWfGLnfZAbA9/88ahfCfcSQt1B5WG0QB7tTwBYje9nK6VR2PFCv0W8Vgl90xjsUMr3vDLVDWBTiEtuJA4jWCVkuJxGvQk4Jqa/UQev5q0Py6rKEyNL1fxdDLVT1WnwzW9u7Crlkd0jc4PVqghS00ovRrbNKk3Wu8hHyJwXAGNsDjoBY5H05hBQNd0W9A/wxG25BLR7kw0sf9O5mZShUhu+7rgbnQtpXeqddiWSNuKSedFfxUrHc8yYYOM9IZYj006VSww6GFRWhwqSUA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e271ba0-0976-4c89-cbb6-08dc2f342218
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 21:13:33.7990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qj993p6B44s+1iA9mSiSeuKOsq3KxFGt+9cE4yKuCbwMKPsitfUJR8/Ws8NGDCxUqqqjowpJJH7erzomenDftCZ/Vwt2gPdjrGGU9jaF0JU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4909
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_20,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402160167
X-Proofpoint-GUID: 02ZLLdcM3jvpYzz0UW4H6UAdR0vVPaK2
X-Proofpoint-ORIG-GUID: 02ZLLdcM3jvpYzz0UW4H6UAdR0vVPaK2

Use migrate_pfn_to_folio() so we can work with folios directly in
__migrate_device_pages().

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 mm/migrate_device.c | 36 +++++++++++++++---------------------
 1 file changed, 15 insertions(+), 21 deletions(-)

diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 81623f2d72c2b..d9633c7b1d21b 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -687,17 +687,17 @@ static void __migrate_device_pages(unsigned long *src_pfns,
 	bool notified = false;
 
 	for (i = 0; i < npages; i++) {
-		struct page *newpage = migrate_pfn_to_page(dst_pfns[i]);
-		struct page *page = migrate_pfn_to_page(src_pfns[i]);
+		struct folio *dst = migrate_pfn_to_folio(dst_pfns[i]);
+		struct folio *src = migrate_pfn_to_folio(src_pfns[i]);
 		struct address_space *mapping;
 		int r;
 
-		if (!newpage) {
+		if (!dst) {
 			src_pfns[i] &= ~MIGRATE_PFN_MIGRATE;
 			continue;
 		}
 
-		if (!page) {
+		if (!src) {
 			unsigned long addr;
 
 			if (!(src_pfns[i] & MIGRATE_PFN_MIGRATE))
@@ -719,33 +719,29 @@ static void __migrate_device_pages(unsigned long *src_pfns,
 					migrate->pgmap_owner);
 				mmu_notifier_invalidate_range_start(&range);
 			}
-			migrate_vma_insert_page(migrate, addr, newpage,
+			migrate_vma_insert_page(migrate, addr, &dst->page,
 						&src_pfns[i]);
 			continue;
 		}
 
-		mapping = page_mapping(page);
+		mapping = folio_mapping(src);
 
-		if (is_device_private_page(newpage) ||
-		    is_device_coherent_page(newpage)) {
+		if (folio_is_device_private(dst) ||
+		    folio_is_device_coherent(dst)) {
 			if (mapping) {
-				struct folio *folio;
-
-				folio = page_folio(page);
-
 				/*
 				 * For now only support anonymous memory migrating to
 				 * device private or coherent memory.
 				 *
 				 * Try to get rid of swap cache if possible.
 				 */
-				if (!folio_test_anon(folio) ||
-				    !folio_free_swap(folio)) {
+				if (!folio_test_anon(src) ||
+				    !folio_free_swap(src)) {
 					src_pfns[i] &= ~MIGRATE_PFN_MIGRATE;
 					continue;
 				}
 			}
-		} else if (is_zone_device_page(newpage)) {
+		} else if (folio_is_zone_device(dst)) {
 			/*
 			 * Other types of ZONE_DEVICE page are not supported.
 			 */
@@ -753,13 +749,11 @@ static void __migrate_device_pages(unsigned long *src_pfns,
 			continue;
 		}
 
-		if (migrate && migrate->fault_page == page)
-			r = migrate_folio_extra(mapping, page_folio(newpage),
-						page_folio(page),
-						MIGRATE_SYNC_NO_COPY, 1);
+		if (migrate && migrate->fault_page == &src->page)
+			r = migrate_folio_extra(mapping, dst, src,
+								MIGRATE_SYNC_NO_COPY, 1);
 		else
-			r = migrate_folio(mapping, page_folio(newpage),
-					page_folio(page), MIGRATE_SYNC_NO_COPY);
+			r = migrate_folio(mapping, dst, src, MIGRATE_SYNC_NO_COPY);
 		if (r != MIGRATEPAGE_SUCCESS)
 			src_pfns[i] &= ~MIGRATE_PFN_MIGRATE;
 	}
-- 
2.42.0


