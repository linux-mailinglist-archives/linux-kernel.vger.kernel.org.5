Return-Path: <linux-kernel+bounces-73768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB4585CAD3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 23:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 604EA284DAA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 22:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C58C153BF4;
	Tue, 20 Feb 2024 22:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="W/cZudm9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pf+V5DIT"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5872F153BE4
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 22:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708468695; cv=fail; b=tqNjoDd2D2WKZ31rQFDsPj12IexSAeC9YUberajsbCfg7Abk9SaC3cZ+Kx3sH0/qBkU58qDcz/ZUV37GpsoueepWXm9ik90oy/nF5BmpYzZqaaGGD0RTXO1zhJB8ohyDeAFtpE4Tv/qHkwLRBEJKDtE2Gxo0hn8Z2J343KveOa0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708468695; c=relaxed/simple;
	bh=AzpCGFtUoJIlQPFoxmBvWzuoj31GKrTAXjM1jhMJ3U4=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=Idi8OhuMV2/Q7W9ln/PfSD+40OpLD3Mt/Eew+pq+auJ3yLvBl87Hp4QiSCQfbwmSAcJ5g12UkYGhuNYaYxn2Z9Msp8mU+b93zBuW5735vzNL1d5iTAmtTbznNJ6Wf8QXsSCQo/srQJ5xmW+pLXjbtg0RW+v5YYoAe+I686/b7FA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=W/cZudm9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pf+V5DIT; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41KKTYsp003166;
	Tue, 20 Feb 2024 22:36:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-11-20;
 bh=zwCEjOwsORZjeRk/S63/adKg7n7/YQc8DdZgPzmt0LI=;
 b=W/cZudm9BK1Lk3BXlBayx/4GPHNO8h3bCC4qtP7wG600vpdyYKFgV4oEADdHLm4lE7ub
 ZyQQtGupIQNjSMYmM6bSc13bxbPAdHC7foSl9ICYMFNNMa0DUeCfA8E/oSjaevYF0uUE
 lEj0ZBduZNFLlkjjcVPo0DwqX5J97BIwko56Pd3VATDkvKQmtokS+1XRwZ5+qmVNl1Yn
 my2YLn9S64xdJ/UkHASzqhEQKI3gN/H2kXI9EshSUmo+QRQe61c/7AqTrI22jtOtYRXY
 iXYoienjIhjJ819k2i/8GKHrsvaye7lhhvudPoDHTHrit0kuk/6OPmq/nLS9RQv6LM2R UA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wanbvg3cf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Feb 2024 22:36:42 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41KLxeHK013043;
	Tue, 20 Feb 2024 22:36:42 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wak881dcq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Feb 2024 22:36:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O6Vnf4vtDWfkfkB3zdWU34XVmU4JfosuuF1g0W8xG5m4tOieTkiiw7xhdSpyFofthTyB+c9Ue2LiSnJvzN0arJpICIazCmHJPEZUMnz1z/Zo3m5LF5F+kNhldMH5k9xO0eZlTHhUvJ+4lHF8eCAF8kiVnp51UmmBnYsK2AsxraV50dSVKVapFoYKBcIWQuOy+xOPGfXsoZ23CaGytCjUJvz8d7IgVVGCkfIDZ+u/v/F7B3p5v8zsbGN3qbfAiOiaWe3whkx3HWk4DXEx6xQJ/vKLf00F+w6m1QKkKFeEzQz/Dx5kJgs5PJkh3PjpydXZgn69NIaO8nInFyqVDjZUVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zwCEjOwsORZjeRk/S63/adKg7n7/YQc8DdZgPzmt0LI=;
 b=Axu1a2wZSHoSq584expY4yeBpBMf3bGWWmgFfcAlOe5FI89rQ+8smEuYU6889QvNwuxv/DhtWoM10tsq+6aS88DBpI9kbxQ0ClYMejlT3pD01IecyhbhNRDGG+P8cfcz28IdGAA9tKdWsBymM+P8YvSJaIbwyJ4amOeR+D6EuGlPNN3IC6cY2EjxAFWVSJG4RlliFS8zhORiPSJmM+CaBdfhQNVhtTatbpiE43RV/Gn0gIpMiYxp4bgWEVhLIlVlcsarDHJr0hYS3k19oW2PYMgJJoFAJ5EEbYRsKoPznWNW0u5EZEp07uoeYECL08WIWqGjDm4uV0/MqVU7zErsGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zwCEjOwsORZjeRk/S63/adKg7n7/YQc8DdZgPzmt0LI=;
 b=pf+V5DITz7U2tQo7HYb3bidFLku/NpSjJ9M/tFSUIB2hTm9+IrpF/IrRT8EVgnjxmgiVNVotJsT18XXBpEztZgulqVnMLPnvLXKVVjxzhxl+Ekt18pnQ79zrqy7D3p5P1t/pAubUQX2Bx7CDweMei5IZEdUXVsrN9hGrvsdRSt4=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DM4PR10MB6256.namprd10.prod.outlook.com (2603:10b6:8:b5::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.39; Tue, 20 Feb 2024 22:36:39 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685%4]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 22:36:39 +0000
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
 <20240213055554.1802415-6-ankur.a.arora@oracle.com> <87sf1o8oh2.ffs@tglx>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org,
        torvalds@linux-foundation.org, paulmck@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org, willy@infradead.org,
        mgorman@suse.de, jpoimboe@kernel.org, mark.rutland@arm.com,
        jgross@suse.com, andrew.cooper3@citrix.com, bristot@kernel.org,
        mathieu.desnoyers@efficios.com, geert@linux-m68k.org,
        glaubitz@physik.fu-berlin.de, anton.ivanov@cambridgegreys.com,
        mattst88@gmail.com, krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@ACULAB.COM, richard@nod.at, mjguzik@gmail.com,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        Ankur Arora
 <ankur.a.arora@oracle.com>
Subject: Re: [PATCH 05/30] sched: *_tsk_need_resched() now takes resched_t
 as param
In-reply-to: <87sf1o8oh2.ffs@tglx>
Date: Tue, 20 Feb 2024 14:37:01 -0800
Message-ID: <87msruiwz6.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0236.namprd04.prod.outlook.com
 (2603:10b6:303:87::31) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DM4PR10MB6256:EE_
X-MS-Office365-Filtering-Correlation-Id: af2218b9-a349-4208-1c44-08dc32646736
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	K+z/UV67qGBJ7PUfzH6zQTOsVnI4xMGMMZaAqoighNwa5OQTWoWLssmq5y3Yl7SW6pZK1AVwwR3QLPUHxLvCrxTlRDesim+RLyw9UHE7LaMZNueprLuqwnZMrLvFb47ws58aErY9rE4RcdZkGWtLbfvLzOyFH86phvEQ/LiMFTXfR8b6i1IO8lEow5uT9lqumIPhj1H3JBIQMqpCN4843AbelJBDGr4cntoGS9bOUqbtYMPWVJ38uZpQNJv60A5MJHmD30ieS5ROieTZsYEYJjS+I1aJEmyywjC/HJefZFvEamSKe8/G+MaZ1wTov2MFGEixnes1TwJEtH9WYGuBLqqmepEeIFW1pybefQUuLctoKRXdenASB5WfUBg08qjt0lKTOm25p/w5xk8HRQxDb89aNCckEZ6f4JUqIikDfzUlBJ/oJHsBudr9tLFQzpsEQeX91DWhgqhx117iNCiIK9Iyu6PMbusHW8KIwpv/WDLNJyCfUUumPu06E/ZFv8wbHrpu/x/Crp0paknQpOJSkB6TGjKefqhKeu+KGA7oXGE=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?59YAoOGI2SaQrGiF2mDmUxHfOPaFFX9Eo4ogbjDnrssLHj65mWn9Zc9CukDu?=
 =?us-ascii?Q?EjItTdNNel4QSQl8DJcHyXCaXVH61LyycCkEImycdx45cNw8yknl0DiNqESu?=
 =?us-ascii?Q?GAnSGoWejSF0v7BfTIIilzGajDFKw8aAf4Xd8cLBGZ7cJLg+No5dRT6BCnBA?=
 =?us-ascii?Q?WDsZnJ52G/TXlvT3qeM/gKmKTfHlL86RdPtmPhLxC+NyarRxqQ6hLhumn/20?=
 =?us-ascii?Q?Hw4s0Amziy5G+08XvTSWYAo5WjMSBupJ4GjQS6g6Y1DPtMzdMMmUaTNy4gSj?=
 =?us-ascii?Q?UDTRsEYRmHEaXgWgThG7gb8adm0ewrkGApKb3LMyZXvv9K1ck7R3m4Jt9xLd?=
 =?us-ascii?Q?QT39sum60uVMQI44Zxbulcfv2HBe1ZTKK8+5r+v9nyMdXOoi8Nx3WeYAO1kK?=
 =?us-ascii?Q?Qfr9QuBCNggcO4t31GKWx35PUldNe6zC4d0Qy3ZV1QgS3lxp8jI1I7Ewg5kI?=
 =?us-ascii?Q?2LbbIJ/r7LPcu9YRZOxy92QcIxvSw9z1zufV9yzqSKLPUJChEHvqtGjym8Xf?=
 =?us-ascii?Q?JwPrx6gDqiuuRvkAkSqkGOFUPNNUTo5w9r0FAe6hJETHLE1wJx3KPvhhaZe3?=
 =?us-ascii?Q?89EU85JrR0PLBhQ2kbOqg14LghNRJhkbE24M6xzh7+tRg+kGemNDnuZRRzHV?=
 =?us-ascii?Q?SFBq6gB2zA/6DDpQEzkg5Vq9dN1ny/PFiO0BuwnZWcrZNQ8bpmJa3imIdK56?=
 =?us-ascii?Q?0hKa4NYwICssYi3iZfm0vYSj+J4peAd5aDrtVdaHTRtlpVe28j7TAmVNB5js?=
 =?us-ascii?Q?WY7tVjVnduJK0W72FTmA6CvVsIfm/vltXOxIfRWgi/+k0dL8WDPTk6EFs5Pj?=
 =?us-ascii?Q?Xu3VDI2FT1G2ZAncfQEbAVw77qqs8MIN6mOukb5inJjjAgJqX90yrfFl7pU0?=
 =?us-ascii?Q?fEUpdsjNt3/Lqro6CtEs4NjYYkMbdCfdlTI5482CU3u9sGGE+9oTesu8Un2t?=
 =?us-ascii?Q?RPM5NztFCdN1z7BX4bnq868RfJuBTivvj9ISzimCSzS9MospLNtLLufA3MJi?=
 =?us-ascii?Q?kY/GsA4ShgBl/h4eqm/gkDEsu4INcsSHRP/Qnzg8f3bn5vrfSJ4cMMWoCiY7?=
 =?us-ascii?Q?IIYcABTsvsy8la4M3qoux8mlAJPx45JpQVV8jaRlT8kxm54AASGfm7xpQVlP?=
 =?us-ascii?Q?Oqp7PLn7B1k1CYTImzaCekI9oz3sOXQIgXwf0LEtsTbBP+u4jrYEQFuwjVa3?=
 =?us-ascii?Q?mS0pnWe/ZBSVrilb8lXwWDvGZ53seG2RmV45jKUbZIE0YpoNZ8FGwrVe0Os5?=
 =?us-ascii?Q?NNKTeetu68G8x779btMmzVCkWCjDxBW3gYoS/tV2rYqW37OTyG6JAykQa25w?=
 =?us-ascii?Q?ejnzpK4FVoCFiO28GL/5lz9UThr1Tb4s6+4qt/1/QboNQOBT1M5ixLFveaMb?=
 =?us-ascii?Q?JaaZJ1PxXfR0a+E4BtuieagmP0wml/PdI67fhvZSXJPjIag25L1x0e7pYwRv?=
 =?us-ascii?Q?avVkkvK1ApYzNMxQQu7L9vvmFXxSBtoskWkWOBf3Nt7p9oUkvas05HO2fp/o?=
 =?us-ascii?Q?imtf1BUFYESWE9yodQph0LttmOAq9CiK3HfNl+82xHSi6TmRX0QEpAPjel71?=
 =?us-ascii?Q?mN95/UtyQp5hFG1OnOgoiIJixNChyjnCpEnPShPuAKi6OOUEeBka5tt43cYl?=
 =?us-ascii?Q?9Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	6IFWzv+3z0wvVWIrH7QVLJzo+JHQ5oif7M3yYciihw2ktpdI9uEmJ0yEiw6Z7Jbpdq8UtymBHOdUxSogxrqa2GjkYd+XywP1PTiJfoykeUX5mwMhMi5wtLMcPXOdougwRnTozoEnwwRwIRn7MtnnolrYSXaklsqIuSDzeMbymO7UPcdSuLnaKCwNHbuUJowmPmslosHipQow+MXdq9AyDFQhBXs/h8Y8BvU1ePPTvKcvNjwP9qZUNqP92w8Ds9o1UcfYLd3LEiDwTA9v7F2ePJyK2/M0nuNcTdUVSJFPHHdY/4W26yQC4BXD3d/EBB+R+EQtAB0AKldQsbQ+4jMyAlrcfqi91u0hKaYdvVNTbom6yHgob5zWyA85A1nJR88a8vBBaI4v4ngpnJhGjy1mAqUK+Sl300eRM//SeRLXc1jdAiiQ8bFpkXjfOnoLMCtMMGNZohFuHrQbvuFaQRJ0OTsq5sOT6cVDA1RIxOv21CMW2n4ECO5UjYzn2NUvndb/LN8u64PUWSEh2XlLb2RA6gWYMzouYvliQPIMrO79TMQK20yZ1/gXgig19IvJU7kSZHFMGL0zglyZshnyYjqnI6ItLbprc3fhjZq3V/s0QOw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af2218b9-a349-4208-1c44-08dc32646736
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 22:36:39.0492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IQThiBL+55LQXMutO/iDyMdC4ctae12S/Edcdb9KIwTb9nwno6d+2ELWNvqalhhZ02EsxgrEozEvjzgo0iHZOP5bGQv3OtEjh3i6Zq+wOlQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6256
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402200163
X-Proofpoint-GUID: SY7nP2woB9r7SdicG5HC7JC8ZkPNL3yC
X-Proofpoint-ORIG-GUID: SY7nP2woB9r7SdicG5HC7JC8ZkPNL3yC


Thomas Gleixner <tglx@linutronix.de> writes:

> On Mon, Feb 12 2024 at 21:55, Ankur Arora wrote:
>
> The subject line reads odd...
>
>> -static inline bool test_tsk_need_resched(struct task_struct *tsk)
>> +static inline bool test_tsk_need_resched(struct task_struct *tsk, resched_t rs)
>>  {
>> -	return unlikely(test_tsk_thread_flag(tsk,TIF_NEED_RESCHED));
>> +	if (IS_ENABLED(CONFIG_PREEMPT_AUTO) || rs == NR_now)
>> +		return unlikely(test_tsk_thread_flag(tsk, tif_resched(rs)));
>> +	else
>> +		return false;
>>  }
>
> Same like the others. This wants wrappers with now/lazy.

So, when working on the scheduler changes, I found the simplest
implementation was to define a function that takes into account
current preemption mode, checks for idle, tick etc and returns
the rescheduling policy, which __resched_curr() carries out.

So, it would be useful to just pass the resched_t as a parameter
instead of having now/lazy wrappers.

That said, as I mention in the other thread, the current primitives
are unnecessarily noisy because everyone needs to use it.

   -static inline bool test_tsk_need_resched(struct task_struct *tsk, resched_t rs)
   +static inline bool __test_tsk_need_resched(struct task_struct *tsk, resched_t rs)
   {
           if (IS_ENABLED(CONFIG_PREEMPT_AUTO) || rs == NR_now)
                   return unlikely(test_tsk_thread_flag(tsk, tif_resched(rs)));
   @@ -1980,6 +1985,11 @@ static inline bool test_tsk_need_resched(struct task_struct *tsk, resched_t rs)
                   return false;
   }

   +static inline bool test_tsk_need_resched(struct task_struct *tsk)
   +{
   +	return __test_tsk_need_resched(tsk, NR_now);
   +}
   +

How about something like this (and similar elsewhere)?

>>  /*
>> @@ -2104,7 +2121,8 @@ static __always_inline bool need_resched(void)
>>
>>  static __always_inline bool need_resched_lazy(void)
>>  {
>> -	return unlikely(tif_need_resched(NR_lazy));
>> +	return IS_ENABLED(CONFIG_PREEMPT_AUTO) &&
>> +		unlikely(tif_need_resched(NR_lazy));
>
> Shouldn't this be folded into the patch which adds need_resched_lazy()?

I think I had messed up a rebase. Will fix.

Thanks

--
ankur

