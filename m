Return-Path: <linux-kernel+bounces-77707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26AA9860944
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 04:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B715B239A0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 03:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE5FC2FD;
	Fri, 23 Feb 2024 03:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dt7zP8dw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GlVVlRLA"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFC9BE6F
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 03:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708658162; cv=fail; b=lT8cuWQDvh5bdzkovmOHvFBiPG2dvbU1phIC17u4/VTZtT+BaW3ARqr42Nnbkq3eONmUyrw4DaNQ3ec48LB9TwGcEyIduLrp+wKnOG2ht4ste9smLf4a3Ozhrd3Q4x45MmFgm4j19G8PK/XTRRu+TdD9RwTC6SselCc5oU/3FZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708658162; c=relaxed/simple;
	bh=YkJkWt/y/vqQ/0PL+zjoj3sV4S5OxayPdccVB/YW2OU=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=tKTXwPW06nj5a8U9nRlBlV3pDHlB5igZGK5tFvJbtFzDsXU/ECnLZIl6bYR5a5X+6b8dklo+Q+cECZMN6ZZSHj2RAj9am3YT4b0NKcn+6GjIsrjgPhmOdI6EZq6dJNtiEcCX+SNCquYZ8BpFxHdnlX2D0dnvHgQtGhTXs0r4O6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dt7zP8dw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GlVVlRLA; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41MIYNjY031432;
	Fri, 23 Feb 2024 03:14:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-11-20;
 bh=YkJkWt/y/vqQ/0PL+zjoj3sV4S5OxayPdccVB/YW2OU=;
 b=dt7zP8dwvtAztJKgwet1PlXHt+aJdOQ/3oS5gFSPQVNj30p0LqfopJoIqohBSaPcT047
 6mOgxzbw0L8KDIXBj9FsrNvnDbQbCfgwL6munUlZQ1SyoFMe2PDuu+vm5eSGYry+0eDU
 b2CJfOS7rGc5u9wg7ckkrJFu0OqJGw6BqtcrXHtwcd2DPxdy+7XzSRGDaCUga3Z41XqK
 Qrg1HvoOk9HRmkJGM3Ei30HqeMyTg4xF1/50nsdjNzsRAVzZfL2NqT63tRDU7Aemf3OF
 l0fFMueqfwleLOmRWvWgTqinOWsk1JPmQgZwulBBV7f/vWt9a93cQaDX6X8yn8nTLRcF EQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wakd2ehju-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Feb 2024 03:14:32 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41N16iSF037744;
	Fri, 23 Feb 2024 03:14:30 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wak8bhqs8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Feb 2024 03:14:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L2nl+lwPe9z6G92FWVZdFEpW7DJzEPvw5/gh4/cp48GqTuQUZJ46gFyJcSvrvxyL/0oa55nfWzdAz3bEKmTYgltD7PxWIxN7H6foD896vfGaVsUfyC/B/vpgs30RVYCDjbIBvHMVLzdKCIDGmdU8/IM7Qoxux3sYXwbjoqJw+OzR4HCDtNXKZAk+GuJhv0h4QgpgtPWyk8yH5R3ByXJauFieIpYZL745bFYfYjU2N38+GXMVV8SeILRAricIHCDmyQC68VAwittODGLQKkUyZNuMp/YTxJdMSOXWIasQWws2oR+sePDsNzSCZa+x9LjFkC0x9l0kzV0XJIWZg+zsCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YkJkWt/y/vqQ/0PL+zjoj3sV4S5OxayPdccVB/YW2OU=;
 b=VlE9OUkofydHHLuA7fsN2cCu29YFCJfBZLL09Z5cuaq1ZNOrcUmKQkBmxMLSGpF3yqShb/4PADn+mBWrAi0w5Ia92Gx41/g2zu6zVLwTw6+5WrMWDNZBlq/nMojy7Tru1lSv9jmT9lgXEyvV24qmJnyvq2AsMxBz6mUTJ4yhN4E0xTAZJ2LxAt7V37HKgNHhjGNod4zHJgTVYvFKV5x/NjaPn/AbUFU48Xsk6Ls/JN1ErTmbulfvFzslN7Xwm/os36UPnD8UjKcqpZWZ4dpmXeZe6+cZFbn2YzfcCMdXy80cBRjgXPn1q6flsiWgzxKSiClHaV97zffwGdt/ahGkRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YkJkWt/y/vqQ/0PL+zjoj3sV4S5OxayPdccVB/YW2OU=;
 b=GlVVlRLAPqCMhbxBcXvr9uf3wIC9pFTTuDzdlcvQdQzLxdFN/9msWEE4YS7tcvEBSe8PBJqlINOwe9UQo1dqUhDkfacV9QWFavad1CWFlNI3o3LMqQoHSIHzm7LyG1Uj2lwJxTuM3FWGfn5DogdD9IZppHVDIBWo3P9eUV0OEQI=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by BY5PR10MB4259.namprd10.prod.outlook.com (2603:10b6:a03:212::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.26; Fri, 23 Feb
 2024 03:14:28 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685%4]) with mapi id 15.20.7292.036; Fri, 23 Feb 2024
 03:14:28 +0000
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
 <15fcf98c-58c5-fa08-2e21-f3b0baf058e6@amd.com> <87zfvtg2mh.ffs@tglx>
 <f1a5fe09-f4bc-0dc5-edda-6b3e690bc0e3@amd.com> <87ttm0dwhk.ffs@tglx>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Raghavendra K T <raghavendra.kt@amd.com>,
        Ankur Arora
 <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, akpm@linux-foundation.org, luto@kernel.org,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, jpoimboe@kernel.org,
        mark.rutland@arm.com, jgross@suse.com, andrew.cooper3@citrix.com,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@ACULAB.COM, richard@nod.at, mjguzik@gmail.com,
        jon.grimm@amd.com, bharata@amd.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com
Subject: Re: [PATCH 00/30] PREEMPT_AUTO: support lazy rescheduling
In-reply-to: <87ttm0dwhk.ffs@tglx>
Date: Thu, 22 Feb 2024 19:14:52 -0800
Message-ID: <87bk87c1n7.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0334.namprd04.prod.outlook.com
 (2603:10b6:303:8a::9) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|BY5PR10MB4259:EE_
X-MS-Office365-Filtering-Correlation-Id: 4270a721-30d2-4d45-27a7-08dc341d8bc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	0imrkStRAFLHirIBw94T8RM21Dnu+D1jA+u5rXYsw0X1ZBp0nQTK54UNUp1uYDZv24rcrBtmydq+e2h1vQiUhLSD+tmtMvnnRv3xO/8MjzWMzTX8cfhMmwf7ZmwGRc/27pI9e3i9sCf0Xeb6BQl2FL2e2vln8lDyq14XyEM7LJ2fftbZLKnncK0Ydwk6/Eg6aTPnMWm8goCylyCPUFIp+k4KDqJuc+4sEyUUc6UBEsVY4BMugor9lOhs7K64MXPk8UvwW5liX2OPgcsESYhbYr4bHXi19cgZFg7VCXsJ9AxOw2fSNr9lO9RMDoT/HU7+w9uW45+iWbGMJ8h4yNn3WCsSMYhpFUFbwqf371uCSr60gslJKQtCIAvKQXc+pTMFCWukpjbxa9e3YGgSlr3S8Yzk1q3IHp8cKmSnvz5aisT8uXbu0zxS5jn6FAOVyr9E5+Hps3nrxAOjeoTTYbuxCMfw45tlfcGzeBN6koskHNX64OJs8seMPcHwPOcbRxxIB/Mx4vfy4tGXnfoNPPS8ndGBcAzsUJgotb0+BEPNTdo=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?LlKdukFbGd1PvoPkLm0BQHrnMSSfVCDaH14UsTcC1QyEm0UMLEA/aRiEfizn?=
 =?us-ascii?Q?j9fAWBdqO7oKZawmmiaqQ6dA3wJDuLcMV1yn6c6YBtJ/38pQXoLGVTowmquJ?=
 =?us-ascii?Q?8W0SKTEJ1R2gndTYbeWL4MNipLJjQxCVTdYXUqBURCZpz0r2VI7jWni0fWr3?=
 =?us-ascii?Q?j3dGzQ7aGY1LAD3oYg7rMORxUkGfVO85UEzjBul4c28ldMlfGThd9AeEOhnS?=
 =?us-ascii?Q?bsSSId692zFtYeOxf/hccwpTHjDCc9W63RHEok9L/gmS4TC4RkyJKQWPasHQ?=
 =?us-ascii?Q?1X7Z7YUpU0lPK/OcZBYEKcGZGWTg4orQh6IkEUlTTL3t0UKLg1IEsyoDWxZR?=
 =?us-ascii?Q?l8W/39NaK6YmQ+YcZw3FpyElds5cTim7c1RYtxWU2lCCOBOZ1/uSuf9PG6V4?=
 =?us-ascii?Q?JO80nWxuxxBtawfxsenk+Vgx6TAvGv/WcnFdEWzxsoah518J1IVk68dpoeT7?=
 =?us-ascii?Q?zJcjGp0JGaYzAWjP9I1h49idmemqJvpSsueypv3ghRyQxsdYtjQ6TWSnzBpu?=
 =?us-ascii?Q?aQzK7aj07r/Xqbp3DHTe8DyW/hwJQxCmfR0b3TVGpMjH+lMlRf+DIr95PHAn?=
 =?us-ascii?Q?ViMHpmUvawuqMDYw9bJbuMz0AtsZzT2K1J/kx4Ia/f/U8K4OMv00+SJZP8vF?=
 =?us-ascii?Q?2cG0hqK4i8BzP/3YcgIK0hVgbwRgiZM4t8Hwz2rDLdlxFV64TYSwBa35yHyk?=
 =?us-ascii?Q?Lw1yLWKFW4y7uLjJRFbxAnCF1Lqb4nuHj+o7uINwU1/1kBtB7LiACOtUDeBw?=
 =?us-ascii?Q?oo7fvDDGbmHAJv7gWcyGq35II6p9TqgPZU+gvv8Fe6bKYzJP43gf0rovcxc7?=
 =?us-ascii?Q?SUgW5xoWfJcFykX84iV28nqOiO/w27wdV24OIUlfsxNVLXH1+treaX+srzvP?=
 =?us-ascii?Q?wPVFYZ5I7++puGAcwqz5qdZyDa3yrECK7+fL2F4GYJU7OEI99uQy1oVMGdTp?=
 =?us-ascii?Q?JRYFsXvxsL270XJNkgzhQWNNO2uObGc5FAjdEtrw32m5XaQkB+/tKMUA7s1f?=
 =?us-ascii?Q?qyxl7B8Xcrsar3okXGORFK+GiDOqa7iZHyCZumv5PGa+QCSKxhHj5FKqVSCQ?=
 =?us-ascii?Q?2QJeXecmYaMG+Hmszv7eGhr8xOk5P0Uuxju86ZRa6rhcpiv1FUOmJoSIBZlh?=
 =?us-ascii?Q?oT5aNQ9YzmU4qquErtuGZqsJ0aCLFgbG7mMQ8pPzviMq6KY2Pj0c83uxArgx?=
 =?us-ascii?Q?xu9aQYflBsFT4Ha/MUQ7rfWHiAuBS4msseALKqFSlM7sgVVlyhSM5FMYk2bO?=
 =?us-ascii?Q?r15HszIHRJlSLR5Bh4MUitG15UpIjf+ao2LBTYwLjzcxt5RJ8B+xlBisBrNS?=
 =?us-ascii?Q?odymKK7ck9ha4/hqrTEGG491sqkhvngpI3Ld16SdR3ifwR7eLYVcLvIE4IVT?=
 =?us-ascii?Q?XuITMInzuIRgQqZJ610WxhH1ifs5llMVuxshqPIKVSkVm/nMeKCBVdAMFSah?=
 =?us-ascii?Q?fMmPGXtOjp9QLiCLAZ6Z+7gdx5mdN+UAHBNZq6xqK09L/H6oByi5lVo4WCKb?=
 =?us-ascii?Q?shUQF/4NiDWJQ+AVk31bgWm6W227YsCscVquRAKhAlqNWzXCmQxLUyShSsNG?=
 =?us-ascii?Q?2TF893wXXtCIs8PWIR9G6NZfbSMU4A3ialiaJI8Tw2mpN/RWrcy0gIuHFMqR?=
 =?us-ascii?Q?QQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	BsgKVoqSgmftv79dxX92kG3YE/SaLoaaUEW61mVbG5++j9X9qXXYAZlupCQ4E+I6OHR+NyA1a9S3bmORkbAY6NQYnAy5EBbPd4ZJ6eM/F0RC/zsijymiz7ncJl1Wn0qtDv4aBWo8d2ENN698bevXGpuQf8Z2oRFM4hMfDK7C0gAR/sqSe2gj4ZXa1HqQyAuP7XHwKQupLueiZP1HL1nvK74DMBZN+1XIrQYcq12uj7teSwkkTftnA+i7wQYm1q1Ioa7Y+7jJo6ne817eXLyKlL4Oyu7f8l+BBj5jkyHwSK1C3KA/m//grGyM3qNJOIQLAhXGGJPC8L99Aej6ahrqi5LC86OzqXnSVkL1aMPJFZRruYrN1rlTYEMNWgVlkN1Bs3lZvJC4J0e/ptBJulbsuiVRoMmWF8uVD3vX3CEdrHRYyNVppJV5zGCDwWOzGbKtJez2WavCw/vEIWQFKvonr8zS99hLjOwUxEoVWCrlSFa0wggt6kGCqPrkK9txhAGx9cztN2Mcui0HQFh22uJPQ7kniDPMIgU89zIx1eWtUHSYde8P90RbhP0ivhMvWuSFaa8kpMcC8oja5u7PSNBFQ8p5kASGf7lOBbjWvWI6CSo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4270a721-30d2-4d45-27a7-08dc341d8bc3
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 03:14:28.5353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oA8KegldCEK/lr/ZnuFG8L3dNVsazQvy/6zGiZOBrKSCG8Z4+/4lY3hXNlU5HDZ7Cbb8QeE0rd7UVmpL9QQhnyvJ/matQcOiTMG5JdrPxqU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4259
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 bulkscore=0 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=983
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402230021
X-Proofpoint-GUID: wBGZ0ma3eFjGru1sJgd7OlZwRm3jfE0V
X-Proofpoint-ORIG-GUID: wBGZ0ma3eFjGru1sJgd7OlZwRm3jfE0V


Thomas Gleixner <tglx@linutronix.de> writes:

> On Wed, Feb 21 2024 at 22:57, Raghavendra K T wrote:
>> On 2/21/2024 10:45 PM, Thomas Gleixner wrote:
>>> On Wed, Feb 21 2024 at 17:53, Raghavendra K T wrote:
>>>> Configuration tested.
>>>> a) Base kernel (6.7),
>>>
>>> Which scheduling model is the baseline using?
>>>
>>
>> baseline is also PREEMPT_DYNAMIC with voluntary preemption
>>
>>>> b) patched with PREEMPT_AUTO voluntary preemption.
>>>> c) patched with PREEMPT_DYNAMIC voluntary preemption.
>
> Which RCU variant do you have enabled with a, b, c ?
>
> I.e. PREEMPT_RCU=?

Raghu please confirm this, but if the defaults were chosen
then we should have:

>> baseline is also PREEMPT_DYNAMIC with voluntary preemption
PREEMPT_RCU=y

>>>> b) patched with PREEMPT_AUTO voluntary preemption.

If this was built with PREEMPT_VOLUNTARY then, PREEMPT_RCU=n.
If with CONFIG_PREEMPT, PREEMPT_RCU=y.

Might be worth rerunning the tests with the other combination
as well (still with voluntary preemption).

>>>> c) patched with PREEMPT_DYNAMIC voluntary preemption.
PREEMPT_RCU=y


Thanks

--
ankur

