Return-Path: <linux-kernel+bounces-34673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FE68385F5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 04:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 543F81C27C34
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 03:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5F410F1;
	Tue, 23 Jan 2024 03:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HnDXaCK4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uXUat5uM"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295DF811
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 03:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705979960; cv=fail; b=UuFZnU+2tICg9PKpnMXDB9X7ZdtoIZp3JxTAyERCFhSlUzQZtO6nvZB+BMaek/vBMdmPZ75C2XMTzwzxs/rGEDAjfYnAaZky8I4Q7UjEcfYdTsp53aQ7XJEO9Xg3NCh0bB0NLbM2J9mHFFwM/F+jP15jUD+CpXcX9olbbXLD13Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705979960; c=relaxed/simple;
	bh=dqwaC4B2ziqjkHWf/LaKrK2h6Hgocu/Sty7tXCX5j8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WprSvzmI0mNAEeuXTjfM5jpsunKJEyVJbapt3C+EwmYkG1WvnUaBRVuP8ezr5LK5Nf+IFz6lyJr14kxYkjMKCSM03j2VNMbR5zfbEVd8X+pol8993dmtz/+QuyyqLEqr9IFjkjuJfbuPCiGAyCHQgxrYqmPFUfrPWhnrbQHFDmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HnDXaCK4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uXUat5uM; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40N2T8Gh029176;
	Tue, 23 Jan 2024 03:19:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=5w60H3Qf5/aR59YukTJggKRftwfSpMlEiKtpWIhCE78=;
 b=HnDXaCK4WXGvmoQMUuWwiXnaKtTr3kR3lxz6IYag1Y8IBriP2XBAb+Yoj5ytYm4Slgbp
 gN/B1njkJ937WXB3SJL94pgpvP6oAQMK+QRtnny8ObEaLjHfqCbQ5PB1cfi/alKEeg6z
 a3e+td3v++rLWulRDWuUA9KtgKOdaZAyzXNlX3nCEyNV0l35z8Mg7BunjH6HqH4bKIlz
 WqN7uyQaXTI4NwFKZNFk9IPQRyVU41Yl0eYD2h08h15ic6HuSNd5s7hRXWmBJKw+FSWX
 kSiMfzWzOXkefT8jxYmlvopsvLk/nnkgI93XjV86kGQ5JQICbnljCAk5LUU2BzWJr0MG lw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7cxw3vk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jan 2024 03:19:10 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40N18Tci016166;
	Tue, 23 Jan 2024 03:19:09 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vs321n2eq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jan 2024 03:19:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ts4Bmo7SY5zrV8RNKrlR/l0GASo6W8LAumkn3bOr3LeyO0DSYLd0/bgXS3KzXhqal7D4T0KZ778nzR4Ps3eEHd+CnRL99R1tKLcvMtMmjEMSKe0ebNed8adsi5zQkje+2+30khyfsxrjx049R+tfBpb/Xgt63RyrDqqeprGxWO88bZVyXnd9ehNYn0ipms7HUYaTcAkLK0pfGoOrRhHRnC8Lxu5b+u8V5rMa4uXd1Lm5x2C7QLWeKPj94VDy1QNMyUhfM1ayr/Nd6hmNZAWpQ4VVUAUp61QLIZGbfn2DrcwhRl+i0zGY1mfF+1gZljb/HK3nbUD1PA45+bSlfCRM5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5w60H3Qf5/aR59YukTJggKRftwfSpMlEiKtpWIhCE78=;
 b=cNs3AuT+DCmfR/4qAUpqPYq4Q1jXktQ4peXNobe5mWXySim4i6SMOW+8zQmI9Et9x08K5gDH67IBJ3I/wTTW8rZnDEdUiE3D0OAc0UUgjEwlWgF4R4yT8HLnUcCoDOD101DbF/Xf9M9iBo9SpUdd/7UfONvScARYBOE+gCGHkhQV7w2frtfuaplWBsPvf9gXsMu1WNsOCiEPg+GC+4mUvoiS300BYo5ovx+j0ICIZEyAdwfS5oV0YuYxMKu0XSKaneiCo3YYISkAzj431f5FhfEu6ttnIv/xGPMK9dVxN69BYI1Jhmy4ijoOm7BOYI58nYPTwHVRU8/5UmFeXdftFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5w60H3Qf5/aR59YukTJggKRftwfSpMlEiKtpWIhCE78=;
 b=uXUat5uMMmKL1hcgYTS/I97sKl86wt3ybnPXCOdmDybaIreY5wS2zUdNIoPOV3PlZDqTx8hEJIo46emnMxnnzCzgenjjWXHr9sQfyyG+1t4+CudRLKZQV2Ph9VCNW5HnX2S2zJJYP2SlIOxGThFu8MMzgn++v6va4HY6vKXHD+0=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CH0PR10MB5019.namprd10.prod.outlook.com (2603:10b6:610:c8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Tue, 23 Jan
 2024 03:19:08 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606%4]) with mapi id 15.20.7202.031; Tue, 23 Jan 2024
 03:19:08 +0000
Date: Mon, 22 Jan 2024 22:19:06 -0500
From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To: Yajun Deng <yajun.deng@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mmap: introduce vma_range_init()
Message-ID: <20240123031906.pwbjuzdpl6hqiptj@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	Yajun Deng <yajun.deng@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
References: <20240111021526.3461825-1-yajun.deng@linux.dev>
 <20240122220031.pwiravglee7o7k34@revolver>
 <20240122154031.b710f834b14d9027176f439a@linux-foundation.org>
 <20240123001830.glqdmrv2qc56zfpc@revolver>
 <2a1d6a9b-f486-44c8-6d1d-e6bab4dc3ced@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a1d6a9b-f486-44c8-6d1d-e6bab4dc3ced@linux.dev>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT1P288CA0001.CANP288.PROD.OUTLOOK.COM (2603:10b6:b01::14)
 To DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CH0PR10MB5019:EE_
X-MS-Office365-Filtering-Correlation-Id: af9e1759-67b4-4301-b4ef-08dc1bc20fa0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	KsZuEh0QHtClqbA+5QIFACDk1YEUaSESKysalZ/16e3Yn263syNq1s2daiur0waFJG73Ax70XdA8q44Xc3zoEW4OFJRyqD5UiXSKaIodluD+t3g2WMSo8eLsK+1bwI1V4u6HW5u/RmLrYH3uk53H0fjYs9QMkrvadk7V7kI4p2A94YwRmgoPp2zhtU3CkD8j5vB6EUjcJwliNOPiWacY2Rw9zCeQW7xV/8D5s3lkg8zaan4Xw/+R3LJpWcRQ8cx/BiQIFB8OzC5JeMHEhxJmDwze6XIaT8vWIhLrTu8+zlpjcgOTuh1mIhEg+rByVFyzqXdAz/C3JAkb1p/7gahgDlL11EichV93yg1HMfhsYZDPRkoF8BQnNF9tie8gDbiLTbST7leJ8vM8iftI3A+8MoDMO9KprD2Im1G7SGfHv0xEHPMhN5Iwa2H90MbOuAesGi994UJOeYaKzfYqsK/RchnjuTzGqpGJGZvwNcs4BXTDs9eaW5XxChcSECp7tfh+q50CvBKVaVyQ0jf6KeI2vXZEIxidAMxpTKdfGfxD2q+N/TOGRdhtDO/HD2A3pYJX
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(136003)(396003)(366004)(39860400002)(376002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(83380400001)(1076003)(26005)(4326008)(8676002)(8936002)(6916009)(66946007)(66556008)(5660300002)(66476007)(316002)(86362001)(38100700002)(478600001)(6486002)(2906002)(33716001)(9686003)(6512007)(6506007)(41300700001)(53546011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?qoCeT732zWXWDbV+DNCW4W60LVOjC8IEN439bMpWcDIWAOos+yvELGLKJUWd?=
 =?us-ascii?Q?T7v5zgmcMu4Xx/dkgvfsihW+3ohRyMp76gZBv8hxvl1guwkAjv5NWI884kEY?=
 =?us-ascii?Q?5eBDBMCyKGkbjx3nDo3WJfbz28qU1u+e5CzFUfovpa4z6sEsx/eXc/Fzxc2Y?=
 =?us-ascii?Q?Pm3lIqRzIe0n5btZzSb6ggvOU5p4fnsTPGe36u8ndrRl0LXc6yU+t0N+5uK8?=
 =?us-ascii?Q?6iPIwtZ0T8QoxKxffBoucBQND9a4VpXLh2gg/92H9K15ZzEg42jKqQ6Sn9xQ?=
 =?us-ascii?Q?Yc+0mW55hSFcKLbndGy9y7LtRmGj3/uzA0jTpyffLFmOuibGOlGPdm7cn+xC?=
 =?us-ascii?Q?xfdsYRIG09DnhFFUC/ARJ9Nh0slWnrMmiu0CEk1iRsenG7i99L0B+tnl6Ysj?=
 =?us-ascii?Q?G/VhWrj/SnFjhJnfV2ppyoQF6YZpGOgFU6DZXI5FQhrjoJO8qVJEPf+MQkAG?=
 =?us-ascii?Q?lI4ODTn17nukhgd2s5hOvE/Dku1denP3Jjgcyh251ny2OIeTZNZNKHh/7w0/?=
 =?us-ascii?Q?LRhu/zFLjHEy+mikYnBMTlMJBTRpm8RspjvjNd2AMIUCwyHbseNK1Gk/pXY9?=
 =?us-ascii?Q?wU8mhyHX8G3nC5vsZBFqw5fkK/ZEMpKhjA30SMRUc5+0gCypuLDEE6Hd94V1?=
 =?us-ascii?Q?N8CDUqn3HKv2TOm9lFZBqdM+8ArTm3tsoNw7nREuVE45fzqajRSwblJsq/Lw?=
 =?us-ascii?Q?3ZG8es90QHWaNKNghYu0iYZMKSXGWhHdQ1ghIZHzR6hLaQ02nUaFRhwNve0V?=
 =?us-ascii?Q?5pt3yqVryFoe4nmjLI0vx7Qu8VKY0PWbS5mC3pIdKKK3MRLrKefco495pPWA?=
 =?us-ascii?Q?o0FAa8iYDV20bTvxEGDV7KEYaXWc8OKV9VmuvC/8ExmH+cGz9ebE9DEsZuR/?=
 =?us-ascii?Q?ndygViLuYBT+QthIgJ26c3E1JKMgMza/NRYyvfdcbG7K/Z4+sGo8wk7CG89o?=
 =?us-ascii?Q?FuiRBisTIH8kA8ZgJmKcBlBxQe8TMpsRMJj15xZr/QK4Q0t3NN/j/f8mMCbQ?=
 =?us-ascii?Q?DDzl+ESGGKAIOw3URJm8jXOkBS4ZmRZ8Enm9Y13czI0R9iV+Lm5fLqVMvWHm?=
 =?us-ascii?Q?PCNB/AAobHCQaqJLQG8lmqI8cNRn7LdHg1inr5UqvhnYrxYauFjNIwIoqMOv?=
 =?us-ascii?Q?6WBmqlvs+uRKW8p6Zr8CYHtxIVVUWQ50aYtbF3pL1eWW4fxY2+hNoZYNdNJF?=
 =?us-ascii?Q?1zy07Y48rea1Aox+W0XVXpHDzG5GZ67Q+nv/XlsVYsS8PZXrPk7TNkvJGDqT?=
 =?us-ascii?Q?9eCqW2d99tzVRjjSM2pSIgHhwBtTbDKWHtOWg/rmy0HDijn5DxxOjDeAbJ7q?=
 =?us-ascii?Q?PjDpNy2WLTfq5rhdRkqOtVsGugD7kRuPQ2D+NZQlp8SpimWR9KZ1YKXcaJpC?=
 =?us-ascii?Q?r0g4MlF3sdkK/oOaQs0pLw2qUx+QpU3myUEH2UtzkOYNPHIjUXHa9a/Klbki?=
 =?us-ascii?Q?Thy9DmJNOUL5hivvb2QuH6Rjs4W1UJ+4qAPsCRy/KVm7OA2TcBrxMi1DcB5Q?=
 =?us-ascii?Q?pPWKqNF2UYcA1IGxLzXPHkZaPR1NBvRPkw78FpXSr9mQG7u+HoVtK/CH8yIQ?=
 =?us-ascii?Q?LCbnEJTT2j8CN1OaVBy1NW0OdX1SfAOpiLkw6s7i?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	5p806tWECKOOgp1HZ2MHPJvE62GVYLMGlCUXNK8UvlGRQn0NAfobigUMVk6ew67zJ2EJyigeqh9bci6WrvcXxn4tVf/z24QXiAwsytpUienQRMuasixXLA/29BWwUqXFTDxCyiNE8bQ50qWYObhY+Jo+vVM4RAyH1CGijzOY89uQ2raoiUb5HTQFa4Ky83zgqm4Ttet4bKLQ0MzS50NazW8uMtxSCpuWFWIQlOMPp8l0FXj1DGmZnSOqRXSc2OKRDO6yLuRuWyf97EotX//rm8QoPLeysWElA4KHbKDrwOjFmtW6/RpSENJ2df58dd/jgMfRzy7KNAqgLhdHyDIZ6ZhfCUoI5hyBP25aaNaAb1NQlKnwewg1WcFmHm1roznL1X21cLR5g1N9MBV3i70OuKXr4N5QAHoRNuSi5dbgLiBnaGvBr3nxH63eaG/k3aJ92C2LSlZjilrTi/6zCjt9e00fdy/ghRE2hhleFs7SmU1zX3gM12r6GH8YWuIHRrZtXNyVnDx5vLc4Pi6A1awk6Z7SHHTov+63NRQu+pnJgc26NEQSbz3UDIDUGkvSz/VWe2F8oQGBZsyMTfmerhRrYwTQh5PSxpCaIgrwgmdncIA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af9e1759-67b4-4301-b4ef-08dc1bc20fa0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 03:19:08.0495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zi2IWU85mFDJU0yzSa2o4yGn13lNGOZ3rRsJmV8RBsnarsdSXsHG5HuZZZvYKWyIMFIOaPSbElfAwZG1hb74AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5019
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-22_12,2024-01-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401230021
X-Proofpoint-ORIG-GUID: 2dg9c8bsfBlkbovXV01qx73vqDnU8bOk
X-Proofpoint-GUID: 2dg9c8bsfBlkbovXV01qx73vqDnU8bOk

* Yajun Deng <yajun.deng@linux.dev> [240122 21:23]:
> 
> On 2024/1/23 08:18, Liam R. Howlett wrote:
> > * Andrew Morton <akpm@linux-foundation.org> [240122 18:40]:
> > > On Mon, 22 Jan 2024 17:00:31 -0500 "Liam R. Howlett" <Liam.Howlett@Oracle.com> wrote:
> > > 
> > > > * Yajun Deng <yajun.deng@linux.dev> [240110 21:15]:
> > > > > There is a lot of code needs to set the range of vma, introduce
> > > > > vma_range_init() to initialize the range of vma.
> > > > > 
> > > > > Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> > > > > ---
> > > > >   include/linux/mm.h |  9 +++++++++
> > > > >   mm/mmap.c          | 29 +++++++----------------------
> > > > >   2 files changed, 16 insertions(+), 22 deletions(-)
> > > > This isn't a whole lot of code, are there others?  We're losing code
> > > > clarity in favour of saving 6 lines?
> > > > 
> > > Oh.  I thought it was a nice cleanup which made things more clear.
> > I'm not totally against it; that's why I suggested the changes below. I
> > think a name change would go a long way for clarity. It's not as much as
> > I though it would be though.
> > 
> > > > > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > > > > index f5a97dec5169..abb4534be3cc 100644
> > > > > --- a/include/linux/mm.h
> > > > > +++ b/include/linux/mm.h
> > > > > @@ -3516,6 +3516,15 @@ static inline bool range_in_vma(struct vm_area_struct *vma,
> > > > >   	return (vma && vma->vm_start <= start && end <= vma->vm_end);
> > > > >   }
> > > > > +static inline void vma_range_init(struct vm_area_struct *vma,
> > > > Any reason this can't be in mm/internal.h ?
> > > That would be good.
> > One other thing, do we trust this to be inlined correctly by the
> > compiler or should this be __always_inline?  I'd expect it to be okay as
> > it is, but I've been proven wrong in a perf trace before..
> > 
> 
> Okay, I would take __always_inline and put it in mm/internal.h in v2.

I'm not confident in this suggestion as the rest.
Please rename the function when you move it.

> 
> > > > vma_range_set(), vma_set_range(), or just vma_range() might be a better
> > > > name?  My thinking is that some of these are actually modifying the vma
> > > > and not just initializing it, right?
> > > I'd vote for vma_set_range().
                      ^  This part, use vma_set_range() please.

> > Using vma_set_range() leaves vma_range() or vma_size(), which could be
> > added for the calculations of vma->vm_end - vma->vm_start.  Davidlohr
> > suggested such a beast a few years ago, but that one would need to live
> > in the include/linux/mm.h as it occurs a lot more.
> > 
> > $ git grep "vma->vm_end - vma->vm_start" | wc -l
> > 198
> > 
> > .. for just those named vma.
> > 
> 

