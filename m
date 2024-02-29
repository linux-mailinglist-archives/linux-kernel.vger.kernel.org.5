Return-Path: <linux-kernel+bounces-87710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C1486D80E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 00:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E906B218D0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 23:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42CC313D2EF;
	Thu, 29 Feb 2024 23:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OpXiQId4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kkmBJurS"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4D842A8C
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 23:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709250957; cv=fail; b=X0JvpXSV4FiVJ69LeqUCrE5E1MPZaX/PHMLrWzDeyt2XloK+hHvLCD9CenVJPoCJxMAHZX5z9aQ53XYb2keCtD9WzO38xirLjVKxqfw37CbZ9smpf7uyCpa2gdRdV6BhuAwckTfvyocl8xL62Y4DSt0ycAscCun5LfMXw9kMPM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709250957; c=relaxed/simple;
	bh=JOUxf98yyCKIv1gOAK4LyXpSsGZCbtcPuP+753tN83Q=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=AdMXPRcuhHch7Cet4bVQsIFtv8TIzzTdU48QfK+Gf2QtDwA4Ab++RXE6CwYtvtb5RLQIpnpuyDWslGXawnN347hAPctFCUTls+0letjUI5Ao+KHbNHtQ8EF6Ckufw4vjJogWLTWkGTYRBinNWMCuCOb/Yr3DNianVONHI7iPGM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OpXiQId4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kkmBJurS; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41TNDYJp001143;
	Thu, 29 Feb 2024 23:54:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-11-20;
 bh=JOUxf98yyCKIv1gOAK4LyXpSsGZCbtcPuP+753tN83Q=;
 b=OpXiQId4JcYzlEyJtsdVkkUy1Va4KB39uNMZoQ7/XnoEK+duBlu0kIa9Cxe5dyTbB/Vc
 AC1eASJG62u5ibL5wuJ2JxiSsUrxCXZLtmhU8kr6N9s1at8na8guQvsJb+FcgMyK86jS
 77S+y7vEK8n0TWz9+ncacIXYgQSRV6Ev3Fk8ElTUVvfNyoAFK4yjqpUGYsLGQhiXX5/0
 +3igxS2mDympjAAsln9PNHDS7hioNO28igJQj9T5t7MF95AokwkyyX95jb1RSwU8WykI
 JydRjDfthDCIOSwZ89TcvzoSIVDAIG7Ng6sZhUS/6RcgGyLp6m6/vQxWsioJBqDfomFq tA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf8gdqdk0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Feb 2024 23:54:20 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41TM1G6g005741;
	Thu, 29 Feb 2024 23:54:20 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wjrrb7m3e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Feb 2024 23:54:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k/NcrhSPUEFQvZ7C+PRwcuPDSyqqt6+v8cOsvl7mr+exdRdJDPAv2U+ZwDdFEnDQ5VzUnY1rIqL7npV34B6Ctzc24KsplCoNAkG2dW93gbYcNlz7jC/EpNsuaZBFi0hBO35oUVe+z3fBO4KfUw4XYODBgQnf6egkzfN+0fy36dVOTqHZ9b4e9Sx9rAh9d8sM89aufa2msqqHX6XkCGZ3DvzevXhlX4qO6wHEKxO+p23O/NVbGcUU14ZHbt6EzFd6DZY3mjkxPoAtG0AUDOsz2g3npLOIKTI56CQigZ+LMcopshry/A5SVf5yYI6XwSWFMrHicy2LOJ9ZLr33ccZ5TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JOUxf98yyCKIv1gOAK4LyXpSsGZCbtcPuP+753tN83Q=;
 b=LLg3EnOhhBK8PfAFv6aU65+DvTCJ238SHMPAQPlUwH0yfxLTUUxvIfTNXEX1iCHi9EOG6SxiJuVjiLpcr/VQ08QYlBkPxzF+Rvq+CAzYMv0Q4l0SJfrqiaMEsE0jRvsBb88QZvibmgrOa45tenLrk1v1KNb3agmBwgo7f33+Gz+WNstH8j3USDZWQh/impHh0izQ/xuQ+157ZSl/+w2kAboLnmfmWqYl+i2faSEp9wd4MDdM6n9///aDyub/gJBXjRJtnY6kFIrHKuJTV5eTcWQT5vfFGiVx5+na2XrHXogKw9xXdv87IUCIoX8/yx5FZu/in0ivN7yfk551KrROow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JOUxf98yyCKIv1gOAK4LyXpSsGZCbtcPuP+753tN83Q=;
 b=kkmBJurSm3iDx8Nv9VQOs6bQjOVLxkQnWDW4XVxdDFVTS5ofynOaYqm0xiIwiJlJ9B0+QnQzydTBZdXdBLXZjDgH9bfi1TApyOQr1ESSwP8lE5xV+vavMxNAEUHw+19COEqLRxkRsbJcIuM/XAiIGic4UXwQ7/Wk7/tJiBmGOGA=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SA1PR10MB7697.namprd10.prod.outlook.com (2603:10b6:806:38f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.27; Thu, 29 Feb
 2024 23:54:17 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::2bb1:744:f397:1d4f]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::2bb1:744:f397:1d4f%6]) with mapi id 15.20.7316.039; Thu, 29 Feb 2024
 23:54:17 +0000
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
 <20240213055554.1802415-24-ankur.a.arora@oracle.com>
 <Zd85iRyY6-zlo2wl@localhost.localdomain> <871q8v7otl.fsf@oracle.com>
 <ZeBPXNFkipU9yytp@localhost.localdomain>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, peterz@infradead.org,
        torvalds@linux-foundation.org, paulmck@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        vincent.guittot@linaro.org, willy@infradead.org, mgorman@suse.de,
        jpoimboe@kernel.org, mark.rutland@arm.com, jgross@suse.com,
        andrew.cooper3@citrix.com, bristot@kernel.org,
        mathieu.desnoyers@efficios.com, geert@linux-m68k.org,
        glaubitz@physik.fu-berlin.de, anton.ivanov@cambridgegreys.com,
        mattst88@gmail.com, krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@aculab.com, richard@nod.at, mjguzik@gmail.com,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH 23/30] sched/fair: handle tick expiry under lazy preemption
In-reply-to: <ZeBPXNFkipU9yytp@localhost.localdomain>
Date: Thu, 29 Feb 2024 15:54:42 -0800
Message-ID: <87a5ni6d31.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0390.namprd04.prod.outlook.com
 (2603:10b6:303:81::35) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SA1PR10MB7697:EE_
X-MS-Office365-Filtering-Correlation-Id: 251d49be-fa87-4b7d-a85d-08dc3981bda9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	oYFj0MnbYHAt5Kc3IURynYQtW5KEeMebp0EOHK15/Vy/k8leyTmF9U5iYr5Soyn2auo5DyVcyhyJLpQMwbgls3LTJvrCL7Az3l5kD9WJ7cRltLReKEBKRycDRkpAP9HG31Wgbn4CD2sD/rsvkDE47K3wVCuP+6hN93aPjhSIKNFX831dwh5i9xh7nN1QHIYMfkq1dXDfdiEvR5Eb090yw93mzSvNsKUE1xkiWHXBcOsggSUGnYPk9R+/yrqjvGKgdqe8XDvPSXsKHBEMvm5wiPaasbvE6Ntln6SZYhiBEKtKHz0W65mkEfa3TStqnx7AqHAKRFHI+a3PfXZpvOyQycpjZsCpWGr4GA9lLQJykqLQve1clrFKsoO2u2RFh50FaWEV6KTXk/ifTq0jfPuu1sA6K8n2Kmu7ngrTKw8vVmUBKZZbPq3X4D8K40YRG6Tzluatjkb+iBIW6lQpacuWUfIzK/6gGZb5MD1dloOGpPvUhAn/e3pA7n20F5GtyCCKou3jpKb6PENU4Rrvtb6rJh4rQN/LJAymOHijJamCXNN4axnkh42thd1cYv1YZdWZoCQv91xJPEE/usMyik+pfaXRReecgfUpoJQm5e7R+aJDPvm3oRV/R+HKNwG9UG/M
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?gg/ZqfO8KiCiAjcXUEI67/Efkec6fEy/iRIwbCPSMbDqRlqDchfvPT2y7/ex?=
 =?us-ascii?Q?C7TFOqyLaA/i2vnHNBKg83HverF4UAp6/zrBrvXYOW7sod6FfS98PhuE06e0?=
 =?us-ascii?Q?JqPT6wVwQFi0uw5D177CWc8/XEYjiDWLV8xByuufCr9EbXO7ReiR9pm1pG/C?=
 =?us-ascii?Q?x0Pl7gzWfWKfKOKo8nCVDk4IGYlAuuM8PR/83oNxiwwgmMrVzdLRljdhm8p6?=
 =?us-ascii?Q?j9/udWI1L+tEYJKhOQrKp5Q7Z96r85Nf6+gVtzaIlGmtvWOg9j1aykh9DcPj?=
 =?us-ascii?Q?uHUgp9SWBLUfevkHa+O0pPl8FQDtj2YYKHS+shKo9mmKFRAMvlkHCobyJ7Up?=
 =?us-ascii?Q?ehQrjuHYuwsmKX/GMUx7egFyKJrSm8YxycokAhZFDcHqyJBhowvTgCpM/X0I?=
 =?us-ascii?Q?LksLIqZWGm27FVxV/wf7Wiy4ghJS9DEmtX5Nua3V1iCnDeXwZ6RXGi6G+NMs?=
 =?us-ascii?Q?Ztbak35wkGcjslU0M5WfJz6FhRgM9W2OI8K3UoWR98OLvkToTm3dcwzSTLah?=
 =?us-ascii?Q?NfBxbCqVRvFpWvG40mUF2FKmU4cqgKB593a04S3fkyEh0qs0cAMBUtdlrhRL?=
 =?us-ascii?Q?DozrsoayZSLOpn0a1r1P4CK/JUeGThiUqeDMDn7B/9CtPttE/09R5dgc23Nq?=
 =?us-ascii?Q?KDYjyGhZtxj5VtuqHKtFP4x9NuUHiGMqrU9to2Z/bgSRyQ80EEabyppqfW0/?=
 =?us-ascii?Q?r/nvLzVQ/0Vlf4cs7gKFi3/wphxUGTzwtHGyA7Dl/QqO0+/lwihM9uQN8y4n?=
 =?us-ascii?Q?WgOO3d+sp3sTq+B3E3ectn2i6N1nFBPdlZ6f6mgrGrdU9qTYIAfAbbT0j0d1?=
 =?us-ascii?Q?tJedWvwEfijqA3spFTNr9PRxLMhTTGJayNwUnpb6jC5td5enNxSyI+9a8Xs8?=
 =?us-ascii?Q?+WWdOHeeNw8o0WUkspormPvwvBERlFMd9EdZuv6eONwGU6jNVLb+XlJxDmE+?=
 =?us-ascii?Q?lqY4Vy1TJCscLp+nK70lWXmvKFXxa1EguEpVpFCFUnjkVNNUOmtEc5UTrunS?=
 =?us-ascii?Q?ERQlj3FawYJ7LYH2ayjKLoPgFpTSaBlFOEz/17x/J9iQyacomiPeCCynJNhX?=
 =?us-ascii?Q?Qt3ggV7JvVZi8AzCJzEhm+HQAv52duJhFme97nWMPSAoEVyvZ38Z44aYVlRC?=
 =?us-ascii?Q?FdnofP9ZCIDZBbu35fQLMBGLrMJS/LgpJpVLYQ6rRzM4Fzz/jolBh+Ey0hrt?=
 =?us-ascii?Q?zbWO5VfPEPmL5DSbhfYZ64mMDWmckhwYDjhrB8LnRiNaHJgDgN7bV7lH1uVu?=
 =?us-ascii?Q?NrlvqMMOcIIRyUfht96WJm1C2HT0+cehuWht3BLm810TSePxRCNmz7w6708M?=
 =?us-ascii?Q?yCeYE5rCL9EyhqjTM7Iit1sgYzU5PAKSjVKopd41+/PHfmBdt1JmqXqtJHPt?=
 =?us-ascii?Q?QdQALGiVAp41ZATk3aqNAm82D0whrYsFJR13djOG+5s/9dXh7tDDBU/cu5jL?=
 =?us-ascii?Q?KRZp8kg/HlQb+DrCfZNDznEq9CY9YpKGkNKhEeCHB4+YXgowwQIkoBu1vg8z?=
 =?us-ascii?Q?Us7W/VWMvwY8yN3R6OnIp+P8S1qQVzvFr20h06Ql0afN0gpmSdZvvMwvcoot?=
 =?us-ascii?Q?PA/MYZB3NAOnaLTL8sUlV6EBTMxY1Xs65tHRkqgXsvNSTo5kAZRg6j2HEasA?=
 =?us-ascii?Q?Cg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	dnv/F0BMD4Z8+IHltCtKeBQ1ylUNPbtRoeSQKv1aGe1/NwYk4ADF+eLHO3l/7bUdxoaNxZMI1UhqZk1p6BV1TQKz2Xg5d8R8jNw+UMd/Lscpe8wCDyN0cUWnZgJFEXyLgb3IFImoDyDhlGVzq9MCOjIezWyOS3SNPg4VQBq/H8QnIwPMPqtnHwc/Skc7TatGh5ckqi1H9E7QO4fgnhXRYctbVgf4AScCdwlUq7RIcEqVgWU9K2++zBCMFRYYuyWLAan3s6sCs+vceRdURsOPqGMWTGgM28vNOF/B7d8JJaOTjjodiBl9fswIBAwWPqKz34A5Cj56LgFty2mJelZEuz2NuDjhVOQHfQ1VeZvqgo7GHbOooApNBBgvn9A+NWnynmsbgWTFnI5U5iOFlfbE8VFZXuTlnQWe66en9n9e3AdpS+b0nA6s2rhY2LZ4NcfUORsKrEoczS6FZnQp3hxZVi8exFjkoLCpcwbq1B90bSUjO7hqiXpt2bwsKe4rTLQNSr/nxXeNFwY3TuVRKgPX5jRzxCSOrB8XEuCrrCUssuS19LeSHhJ7BrrTtInz7y4BdtloKwlThQZUvuuR8a/ETzt58cw7E+rxbbHat5kqKlY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 251d49be-fa87-4b7d-a85d-08dc3981bda9
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 23:54:17.7113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jXgPb0BHjhgxAXjEtkpQqVP+Zfhn6MRSUtfV4g9RiYv3SH5nDxnjBYRwOpp6HgjY1MDsP/TcS50HaAHOJqHva3iZx9QkZYC9GAZReEn7Zmw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7697
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_06,2024-02-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402290187
X-Proofpoint-ORIG-GUID: n3O0TT3_iAQG5oIixS2K_c9LUvcJnpen
X-Proofpoint-GUID: n3O0TT3_iAQG5oIixS2K_c9LUvcJnpen


Juri Lelli <juri.lelli@redhat.com> writes:

> On 28/02/24 22:43, Ankur Arora wrote:
>> Juri Lelli <juri.lelli@redhat.com> writes:
>
> ..
>
>> > For deadline we call resched_curr_tick() from the throttle part of
>> > update_curr_dl_se() if the dl_se happens to not be the leftmost anymore,
>> > so in this case I believe we really want to reschedule straight away and
>> > not wait for the second time around (otherwise we might be breaking the
>> > new leftmost tasks guarantees)?
>>
>> Yes, agreed, this looks like it breaks the deadline invariant for both
>> preempt=none and preempt=voluntary.
>>
>> For RT, update_curr_rt() seems to have a similar problem if the task
>> doesn't have RUNTIME_INF.
>>
>> Relatedly, do you think there's a similar problem when switching to
>> a task with a higher scheduling class?
>> (Related to code is in patch 25, 26.)
>>
>> For preempt=voluntary, wakeup_preempt() will do the right thing, but
>
> Right.
>
>> for preempt=none, we only reschedule lazily so the target might
>> continue to run until the end of the tick.
>
> Hummm, not sure honestly, but I seem to understand that with
> preempt=none we want to be super conservative wrt preemptions, so maybe
> current behavior (1 tick of laziness) is OK? Otherwise what would be the

Yeah, that's kind of where I'm thinking of getting to. Be lazy so long
as we don't violate guarantees.

> difference wrt preempt=voluntary from a scheduler pow? Yes, it might
> break deadline guarantees, but if you wanted to use preempt=none maybe
> there is a strong reason for it, I'm thinking.

Yeah, the difference between preempt=none and preempt=voluntary is
looking narrower and narrower, and maybe a bit artificial in that
there seem to be very few cases where the two models would actually
differ in behaviour.

Thanks
Ankur

>> Thanks for the review, btw.
>
> Sure. Thanks for working on this actually! :)
>
> Best,
> Juri

