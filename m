Return-Path: <linux-kernel+bounces-1867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EABD8154F1
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 01:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3BFE1C24708
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 00:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158DDF4F1;
	Sat, 16 Dec 2023 00:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TT63tMUY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="a8zWX9iC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02775D511
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 00:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BFK8Fab018693;
	Sat, 16 Dec 2023 00:18:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=I2k2P08udj5Pm12hlWzhN/R+czbyzO9Ot0D2GTzlTSM=;
 b=TT63tMUYzm8HP6iBg9wGMfICYbRnHc7tBzhGU+EvmGVj0DyHsakf+32S/O3ptZpJgRgm
 aKFkkkKOjVhrzWF8id0tgv1pBMQJR9lP1JAmcxccFCy9SzsSe3Kw2psigVgfybaI2v0f
 rZlAz3/DJhbMriH9ULurIeHHsVNrypWCNyXFyuSvbCq9Yzd2hdhPqdY41R+t5qo/RnDb
 6ACmHNeOPtFMwXZEl5emq1osQ47jT6lAMR0AXX7CJqRR1mFOcay+fOgMltnlJBfjQX80
 Df42PEpIrkSc+ufr3+qUgKSm1w9micNGU3e5TMID7O/ovwGUp0kawXRIAMF8BkR9szRc VQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uwfrrvy8d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 16 Dec 2023 00:18:38 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BFLuKYW021489;
	Sat, 16 Dec 2023 00:18:38 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uvepcmaas-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 16 Dec 2023 00:18:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SCiPCnTHyh9m8Dc+7fikttcwKfy8nDTGyP5wn+OhGXWv6lkPCmcBmLKWfkjkILJ+gxdTVgykpHoGzJVTk4NLrDI+jJa+JBy458lYxDSaeapgQTZ0Q/LISTQIl6nH5jqHLpVKLu9sRdbLsykYiiscR/Trc7FPRD6FV/yCTFtHKT2Nm69YFqR9ALJl6X87fsGlVmO6pgwFAgys51mSneqxeWIPDBl3cPprOe8miYWjGcrIOiG3SU7RVkIxVwsBWFxrFlT6AStylvdSCdNmUIErnpgZ1s/Z16aAZKREAxWtyHah/dwHpsauJKJL2u/EiEtL3OCmfNf0/KVXOtMXhl/J5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I2k2P08udj5Pm12hlWzhN/R+czbyzO9Ot0D2GTzlTSM=;
 b=DePDeEEYGkbqS+Os9onKzeQtB9W5XJKy8U5H3jl+9Ml11No9OmrHnkaJtNeKxm9U3T4LE0JaBHY92YASZEkmFYEUpD/vPy6qlxL4geE5NREgtI3XKnPrgLKum8ciIWHc1mu9MlernydxYz0bNsnA83hYYVu7JmUyn9ZAmJXFEEYYa+UWapjwDEaWyeUwbcFcZNyv8i4Zb6yn73Mh7r+Cx169FsfyPJohHFwtJOdOxAkcK/Rfk3tNYby/mxDEpJVNtzk/9WBT6UhvykKwalX88qm+Sf3z2t1SIAftJqrehH6jxrLlgEPLhjVaop5hj/K6E/tk69uzcuYR0hJyFOJA0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I2k2P08udj5Pm12hlWzhN/R+czbyzO9Ot0D2GTzlTSM=;
 b=a8zWX9iCgPxsTDf0Ev4OO1MiRlLg4aR6raR8/JVIUxB9rrKzO3W0AvpmrIzYk7iFbvy18L8PtbboxDG6XWdqcejt3BdizA0sQvWxhsCIlRyuU/Aptl7hyw8CnKHbW66yX5BjJl1ectfKPeh7nZEIH12pKZ1jKLcB4xmPQFJRAm0=
Received: from CO1PR10MB4705.namprd10.prod.outlook.com (2603:10b6:303:96::11)
 by MN2PR10MB4287.namprd10.prod.outlook.com (2603:10b6:208:1da::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.33; Sat, 16 Dec
 2023 00:18:20 +0000
Received: from CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::67e:d770:a6fd:6d00]) by CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::67e:d770:a6fd:6d00%4]) with mapi id 15.20.7091.030; Sat, 16 Dec 2023
 00:18:20 +0000
From: chris hyser <chris.hyser@oracle.com>
To: "Chris Hyser" <chris.hyser@oracle.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Mel Gorman" <mgorman@suse.de>, linux-kernel@vger.kernel.org
Cc: "Konrad Wilk" <konrad.wilk@oracle.com>
Subject: [RFC 0/2] How effective is numa_preferred_nid w.r.t. NUMA performance?
Date: Fri, 15 Dec 2023 19:17:59 -0500
Message-Id: <20231216001801.3015832-1-chris.hyser@oracle.com>
X-Mailer: git-send-email 2.39.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0044.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::19) To CO1PR10MB4705.namprd10.prod.outlook.com
 (2603:10b6:303:96::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4705:EE_|MN2PR10MB4287:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ba82dd9-b2f4-4838-66ab-08dbfdcc825c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	hF9znIF9vIcKsrOZyAJRGgAEIwUdESC19wFaKK/wZDWkWTVahhs2qb7bGZJEDJryzHhyE76GK9IruzLkePD3Cjzys9jQagkR+az0A/vRXXrce5W7SUN9LdTarPl4lESMYngJmxN117BaqyNIE6S/exPppjbZ2lZeKIaUmDCzXfBHVLn9XnJzK04Ep6p2zoV32bwq+XxloERnf4udoPCSWKhNlqWLQRupKqERJC2VRNRIcpHP0yrfyNzaRktH9sAM+tbBorgYKEmNPTV+U7LMkZ01WfiXvg0NbTZle5AayteE6cPPbHWeySPV6tCzXIrIEZ0Zt89xjgX7VWHEGd37qMatoc+dHKbM7iyGTBlk6caVjLfwZWddOsGkQgYbG+rBTXf8dJChEf+kB/21H6EHmpEVxTOsm9SDFjnTnHcENQPpxa7eohdhnwmDOpcXbewtfyHfjhYn19fFq5WaV2ggYpUW9A3L4gAx1f23EfaKXqZq+XhzyNhzky3T3c6H7c/i+0CPrGBRsTzQel4GyNM27CHBHP64g8YaJdxDk0h7f6c=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4705.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(376002)(366004)(136003)(346002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(66899024)(316002)(66946007)(66556008)(66476007)(8936002)(8676002)(4326008)(478600001)(6486002)(110136005)(966005)(41300700001)(36756003)(30864003)(2906002)(86362001)(5660300002)(38100700002)(6666004)(6512007)(6506007)(83380400001)(2616005)(1076003)(26005)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Y0R4Y1z8UA+vaiW9CbarbzFVOLwL9hystFLPofdF/hT3ls+K5e1/Rv6jCArv?=
 =?us-ascii?Q?l9jgC4rHvEZSqpXvPdrElddQl388tDfrOOCKVODao2B3S6l+kESMAEH/aBgm?=
 =?us-ascii?Q?FTDwOr7zaDQcu0Cz6nva6mmgaQvKiVYGYqL/Rco4S9EAOEapdCWWIpjghaPk?=
 =?us-ascii?Q?+xmEWG7DfQ9ahG8zgGogBMnSMLOP+eva5GHgUGWf2jXTEDs94HMAnH3dsC4P?=
 =?us-ascii?Q?dHceWtkap/FAJ38TuvdhA/3mLwPdhn9FDDYa2fjjDWVDUCgJTRUwD5P2B0FG?=
 =?us-ascii?Q?R6i+z49pvs7CVMXjiXT0g4aLCjyFFUb6SZAHVODTRgiuxRgwXPnFAtYWZ1rw?=
 =?us-ascii?Q?wtXDkEF8B1WYFNRLXr0Ew6B7E47zNb0Arwo5ekTiAeRx3aC/L1mmDpZGTqvE?=
 =?us-ascii?Q?UvuE36FBiNw/LQQPQxn+gZ5v/Jed07D29Rg2H/T8sLfi3M9JYyDNt70bew4M?=
 =?us-ascii?Q?9sL5jCkZ6r38gN5gSC+NgyqrrylBcga2G5I0BwKgZI975uslQZquoWjM/e7K?=
 =?us-ascii?Q?fHep1RSHpvMJjcDv6FbQ541zrsoT8x2u5Eadn7lb9pLSsjdjfLD5mYgzMTg2?=
 =?us-ascii?Q?At5/WKdFr+E9FwLx5baST26X1xTtplnFnHyMysViLqPhH24NuI4Km/1pEzdU?=
 =?us-ascii?Q?LAbPHmOVmEobV+n0I2+m5FtS+7rzwtZIJM3CavwL3PAAe8zmp+QK0QmqQNSD?=
 =?us-ascii?Q?5bB4+uzcRl6FoSmKQiyzMsmGOD4tZ3Py+66GyWaZi2SE5ZswC5Noxjujds63?=
 =?us-ascii?Q?A4KrcqvUtXXmCPMF/VSctOMIQvZ6WlyNeMBp0q1jYJqGRzPT+r382wlQozv3?=
 =?us-ascii?Q?wuS48XK+IXYGsnxYnk8dxvdo2NRkJO3R1Nnceeca9TR2pqswabjFrqX4zsQ1?=
 =?us-ascii?Q?UoFnL+Csc3O2rgDOhmlH+02/6kN6y6uqW8CUVaNib0KIhj7gc3xtFNdQSmWj?=
 =?us-ascii?Q?DkhqiS9eJDEPhNCbnB/AKiOdwWyqgkYRqMaSAVEVCJ1Q54yQYxeKntq2UJm9?=
 =?us-ascii?Q?T/3McRiah+7/U5uQ+hU4ckz1wFXGOnmFAWAN36GQFFrnB+qsukehgDToL1ah?=
 =?us-ascii?Q?k1/iaJuzOKHrCIsfxoAB07umeACQp8EzviLKIYLaJ3udk+3ug80iSBxaEr2E?=
 =?us-ascii?Q?irhi2nYCO4r+a48f6Q+NGV0Xom10QhwGVE5wSWdX29Teb+qtAoxUyCggqVPj?=
 =?us-ascii?Q?WRbQRFl1adoOYG8qkQe+paelrpGn+84td0Wbxy3yMo1d1+jfJVX20z4tXYen?=
 =?us-ascii?Q?+FZfWsyaXLDMiEyOavy/HsBH2Y0Pj2BEQh1aCT5ubrZ+0T0yIalXV2Z8yGME?=
 =?us-ascii?Q?/3BJwheDZIprI/xe3bQ0cm2Y3ahfsbtaGtXXnUmzFV0KMsS5lrVGK5p4FuRk?=
 =?us-ascii?Q?60sh1BR5MQzh+Sk/ZTueHFGYS71boYbT7AKT3f2E0xu29ZAgC1QUN0AGkJb+?=
 =?us-ascii?Q?5w9pA/FOo+jc/gPHRLeJJzSNwibsdbIxJuY3p/FfSY3zlx71UlHa8L6wBPDu?=
 =?us-ascii?Q?fqxbTWsWmkzXeACJO0YNfnzxVLlpKz09+/fsSOaRiWrW88J2QVhoSfPTuXS3?=
 =?us-ascii?Q?piou050LFp3Pr1wxVmCOHFoIGDbnqDeQv0Ao+up7?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	riSlE3R1JdPWSb6LodA50XDoFLaOnyu4dJLApkYKcD1Wn8FMhCsyJoBKotLwbCsHjLLYgZrZ4O6FWzt+c+9l6gcopj/JuTQWEUzqNenxbM+Ezae7cpxcmaUPoJpdKT2bICALGkflHUc3ixV2bJgFpKSZPC70ZpmKc/JB0UqSq1ZVhGRsFHYnePFKhESApLLq1JUI5fwIHO1RPw85qXT9D9XvdfZdvlzM9jQ4tiNFCOJWsvNKw94I39wJD/ZWF8bVIpiJii5k17I43VkgBkIwZ/8QqVL3ctuycUcN1vapDGb3NP24K4epEjA0yVSSVo+p29JSMfYvKyzYjG1I0OzhA0G9bojI79zLKZGsfHLBZfSeThjtvluWwQEj9iM+Gsr0AHIXdJpz6GYbapcLJPtZbyzmg6HlDYGj49EESZzjuBvqJDI9xQi67YdasBEW2YbRDrLkdLrOuCV4GZk8KZ8R6TLbkwaKUs7EqZITfzyqV5rpFR1M3gkohF+nm9ydpbG+ZN14Eo5AwLGmxtcJZyQUgGZyDT+DYvJMhnsOwJ6L35N1jKvcNW0R8hkXSAAAmJ6F3uBLJRC/VgZIEIWuFBfDoH5pm2xkBTnrZEquZau0ZCQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ba82dd9-b2f4-4838-66ab-08dbfdcc825c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4705.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2023 00:18:20.7518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WVM4bF+Gzu1ud6OpmNhN0qQ9kIamgMb+r3ZcVSDVDAe/wvqMCoTM+H0EGuDqh7fe/PPyalm17XkeWjm/KWoUMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4287
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-15_11,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312160001
X-Proofpoint-GUID: l0FzhA2bsxRj-NJSn0a8bQRttji7zGT9
X-Proofpoint-ORIG-GUID: l0FzhA2bsxRj-NJSn0a8bQRttji7zGT9

The commentary around the initial Oracle Soft Affinity proposal [1] had
recommended investigating the use of numa_preferred_nid as a better solution.
The primary driver for the original proposal (as well as now) is better NUMA
performance involving important task's accessing RDMA pinned memory. I wanted a
fairly simple test to explore the various aspects of NUMA performance and that
didn't require lots of time running TPC-C on a tuned DB as Subhra had done. I
needed something that would allow both task and memory placement, with usable
NUMA sensitivity and I think I stumbled onto something quite useful. As the test
is only concerned with the NUMA effects of scheduler/balancer placement
decisions, no locks, no communications, no syscalls etc during the timed loop,
it does not represent any actual useful load. Thus making it, I suppose, a NUMA
micro-benchmark.

A simplified description of the resulting benchmark is first a probe process
which times an outer loop doing a specified "counts" worth of a tight inner
loop. The inner loop in sequential mode would access every u64 in a large
buffer, but in this case it is an equivalent number of random (u64 aligned)
indexes into the memory buffer accessed by a 64-bit read then 64-bit write (the
code provides seq vs rand access as well as various access patterns, but this is
the combo most interesting for this). The probe's buffer memory is either
allowed to float or be bound to particular NUMA nodes while also allowing the
NUMA affinity of the process itself to be set (uses hard affinity) as well as
supporting use of the prctl() in patch 2 to set a "Preferred Node Affinity". The
main difference between this and probably dozens of similar programs is that the
probe isn't the benchmark; its just an extremely NUMA sensitive process. If you
run it by itself on an idle system it will park on a CPU, fill up the associated
caches and tell you absolutely nothing. 

What ultimately makes this interesting is running it in the presence of load,
specifically a constant percentage of cpu-only load replicated and pinned on
each CPU. So, for example, HTOP would show all but one CPU at say 60% (what I
used in generating the results here, but the "effect" occurs even with just a 1%
load) with that lone CPU running the probe and pegged at 100%. The result of
this is the load balancer really feeling the need to balance and the NUMA
awareness of those placement decisions are clearly discernible in the probe's
measured times. As well, the runtimes are sufficiently short to enable tracing
the entire life of the probe and categorizing all migrations as 'same core',
'same node', and 'cross node'. 

The above is a minimal description of the benchmark. I will be making this
available if people are interested (that and when I get internal stuff sorted),
so after the holidays.

In terms of showing results, I also have test data for an AMD 8-node and an
ARM64 2-node box. I've also run tests exploring the benchmark over a range of
different migration_cost_ns values.  Again, if people are interested, I have
data to share. 

Test Results:
--------------
The below tests were run on an Intel(R) Xeon(R) Platinum 8167M CPU @ 2.00GHz
box. This has two LLC-spanned memory nodes and 104 CPUs. The kernel was recent
tip:sched/core with the included patches (POC only) just to show the changes.

Key:
-----------------
NB   - auto-numa-balancing (0 - off, 1 - on)
PNID - the prctl() "forced" numa_preferred_nid, ie 'Preferred Node Affinity'.
           (given 2 nodes:  0, 1, and -1 for not_set)
Mem  - represents the Memory node when memory is bound, else 'F' floating,
           ie not set
CPU  - represents the CPUs of the node that the probe is hard-affined to, else
           'F' floating, ie not set
Avg  - the average time of the probe's measurements in secs

Each line below represents the average of 64 test runs with the indicated
parameters.

NumSamples: 64 
Kernel: 6.7.0-rc1_ch_pna7_7+_#213 SMP PREEMPT_DYNAMIC Thu Dec  7 15:16:59 EST 2023
Load: 60
CPU_Model: IntelR XeonR Platinum 8167M CPU @ 2.00GHz
NUM_CPUS: 104
migration_cost_ns: 500000

       Avg       max     min     stdv  |       Test Parameters
----------------------------------------------------------------------
[00]  136.50   141.76   122.08   2.95  |  PNID: -1 NB: 0 Mem: 0 CPU: 0
[01]  168.78   172.07   156.04   2.58  |  PNID: -1 NB: 0 Mem: 0 CPU: 1
[02]  173.15   180.73   153.41   4.89  |  PNID: -1 NB: 0 Mem: 0 CPU: F
[03]  165.95   169.17   162.13   1.57  |  PNID: -1 NB: 0 Mem: 1 CPU: 0
[04]  137.23   144.28   123.75   4.97  |  PNID: -1 NB: 0 Mem: 1 CPU: 1
[05]  179.90   187.21   165.90   3.73  |  PNID: -1 NB: 0 Mem: 1 CPU: F
[06]  163.87   170.68   147.56   6.31  |  PNID: -1 NB: 0 Mem: F CPU: 0
[07]  168.96   174.40   156.51   3.74  |  PNID: -1 NB: 0 Mem: F CPU: 1
[08]  180.71   185.51   169.74   3.33  |  PNID: -1 NB: 0 Mem: F CPU: F
 
[09]  135.68   139.28   119.92   2.93  |  PNID: -1 NB: 1 Mem: 0 CPU: 0
[10]  166.60   169.82   160.05   1.76  |  PNID: -1 NB: 1 Mem: 0 CPU: 1
[11]  171.97   181.91   163.94   3.70  |  PNID: -1 NB: 1 Mem: 0 CPU: F
[12]  164.01   170.34   152.37   2.82  |  PNID: -1 NB: 1 Mem: 1 CPU: 0
[13]  138.01   142.27   135.20   1.22  |  PNID: -1 NB: 1 Mem: 1 CPU: 1
[14]  177.07   184.39   163.89   3.56  |  PNID: -1 NB: 1 Mem: 1 CPU: F
[15]  165.70   171.33   154.46   2.41  |  PNID: -1 NB: 1 Mem: F CPU: 0
[16]  165.18   170.83   149.12   5.99  |  PNID: -1 NB: 1 Mem: F CPU: 1
[17]  148.91   163.04   134.31   5.48  |  PNID: -1 NB: 1 Mem: F CPU: F

[18]  135.63   138.63   122.85   2.07  |  PNID:  0 NB: 1 Mem: 0 CPU: 0
[19]  162.38   170.60   146.03   6.73  |  PNID:  0 NB: 1 Mem: 0 CPU: 1
[20]  129.20   135.26   114.55   3.28  |  PNID:  0 NB: 1 Mem: 0 CPU: F
[21]  161.71   168.72   144.87   5.55  |  PNID:  0 NB: 1 Mem: 1 CPU: 0
[22]  135.72   140.44   123.34   3.10  |  PNID:  0 NB: 1 Mem: 1 CPU: 1
[23]  155.07   162.20   138.71   4.50  |  PNID:  0 NB: 1 Mem: 1 CPU: F
[24]  163.42   169.29   146.95   5.04  |  PNID:  0 NB: 1 Mem: F CPU: 0
[25]  165.90   170.44   157.56   1.67  |  PNID:  0 NB: 1 Mem: F CPU: 1
[26]  140.45   148.37   117.02   5.81  |  PNID:  0 NB: 1 Mem: F CPU: F

[27]  135.26   140.78   123.29   2.30  |  PNID:  1 NB: 1 Mem: 0 CPU: 0
[28]  166.22   169.51   148.18   2.65  |  PNID:  1 NB: 1 Mem: 0 CPU: 1
[29]  157.91   165.94   153.48   2.75  |  PNID:  1 NB: 1 Mem: 0 CPU: F
[30]  162.08   166.76   148.14   3.37  |  PNID:  1 NB: 1 Mem: 1 CPU: 0
[31]  136.86   140.03   127.42   2.01  |  PNID:  1 NB: 1 Mem: 1 CPU: 1
[32]  131.85   141.38   114.66   5.55  |  PNID:  1 NB: 1 Mem: 1 CPU: F
[33]  163.64   169.48   149.35   2.74  |  PNID:  1 NB: 1 Mem: F CPU: 0
[34]  165.94   170.47   156.10   2.41  |  PNID:  1 NB: 1 Mem: F CPU: 1
[35]  145.28   154.64   137.84   3.60  |  PNID:  1 NB: 1 Mem: F CPU: F

Observations:
---------------
First we see the expected results that memory and cpu bound/pinned on the same
node {0,4,9,13,18,22,27,31} is quite a bit faster than when bound/pinned on
different nodes {1,3,10,12,19,21,28,30}. Completely unexpected was that when
binding memory to a node but allowing the CPU to float (ie, let the scheduler
"schedule", the load balancer "balance") or both float, the performance is as
bad or worse than pinning CPU's and memory on different nodes {2,5,8,11,14}. NB
does help when both memory and the CPU float.

How is that possible? I did some traces of the probe with identical
params/kernel etc. These were then categorized as "same-core", "same-node (minus
same core)", and "cross-node".

Given this platform, a reasonable hypothesis is that cross-node migrations are
trashing the LLC and that is a big deal from a pure NUMA perspective. Is there a
general correlation between the number of cross-node migrations and the longer
completion times?  The answer I believe is yes. (The below are representative
samples versus averages as there is still a manual step.)

When both memory and the CPUs are pinned (same node or diff) we see no
cross-node migrations (the 1 is from when the probe started on a different node
than it later hard affined to)

		    CPU: 0, Mem: 0, NB=0, PNID=-1
    -----------------------------------------------------------------
    num_migrations_samecore : 846       num_migrations_samecore : 887
    num_migrations_samenode : 2442      num_migrations_samenode : 2375
    num_migrations_crossnode: 1         num_migrations_crossnode: 1
    num_migrations: 3289                num_migrations: 3263

		    CPU: 1, Mem: 1, NB=0, PNID=-1
    -----------------------------------------------------------------
    num_migrations_samecore : 822       num_migrations_samecore : 886
    num_migrations_samenode : 2156      num_migrations_samenode : 1982
    num_migrations_crossnode: 0         num_migrations_crossnode: 0
    num_migrations: 2978                num_migrations: 2868

		    CPU: 0, Mem: 1, NB=0, PNID=-1
    -----------------------------------------------------------------
    num_migrations_samecore : 1038      num_migrations_samecore : 1055
    num_migrations_samenode : 2892      num_migrations_samenode : 2824
    num_migrations_crossnode: 0         num_migrations_crossnode: 1
    num_migrations: 3931                num_migrations: 3879


Compared to both CPU and memory allowed to float (as well as the impact of NB
and PNID):
		    CPU: F, Mem: F, NB=0, PNID=-1
    -----------------------------------------------------------------
    num_migrations_samecore : 681       num_migrations_samecore : 800
    num_migrations_samenode : 2306      num_migrations_samenode : 2255
    num_migrations_crossnode: 1548      num_migrations_crossnode: 1503
    num_migrations: 4535                num_migrations: 4558

		    CPU: F, Mem: F, NB=1, PNID=-1
    -----------------------------------------------------------------
    num_migrations_samecore : 799       num_migrations_samecore : 646
    num_migrations_samenode : 3098      num_migrations_samenode : 2775
    num_migrations_crossnode: 104       num_migrations_crossnode: 236
    num_migrations: 4001                num_migrations: 3657

		    CPU: F, Mem: F, NB=1, PNID=0
    -----------------------------------------------------------------
    num_migrations_samecore : 718       num_migrations_samecore : 737
    num_migrations_samenode : 3148      num_migrations_samenode : 3274
    num_migrations_crossnode: 2         num_migrations_crossnode: 7 
    num_migrations: 3868                num_migrations: 4018

We see that NB does have a big impact (decrease in cross-node migrations) and
confirmed by much better measured times. line {17} vs line {8}.

In terms of the primary use case, pinned RDMA mem buffers, the interesting
results are where the CPU is allowed to float with memory pinned
{2,5,8,11,14,17,20,23,26,29,32,35}. What do the migration counts look like for
those accesses:

		    CPU: F, Mem: 0, NB=0, PNID=-1
    -----------------------------------------------------------------
    num_migrations_samecore : 788       num_migrations_samecore : 739
    num_migrations_samenode : 2251      num_migrations_samenode : 2292
    num_migrations_crossnode: 1738      num_migrations_crossnode: 1500
    num_migrations: 4777                num_migrations: 4531 

		    CPU: F, Mem: 0, NB=1, PNID=-1
    -----------------------------------------------------------------
    num_migrations_samecore : 663       num_migrations_samecore : 657
    num_migrations_samenode : 2434      num_migrations_samenode : 2427
    num_migrations_crossnode: 1344      num_migrations_crossnode: 1499
    num_migrations: 4441                num_migrations: 4583

		    CPU: F, Mem: 0, NB=1, PNID=0
    -----------------------------------------------------------------
    num_migrations_samecore : 653       num_migrations_samecore : 665
    num_migrations_samenode : 2954      num_migrations_samenode : 2880
    num_migrations_crossnode: 7         num_migrations_crossnode: 12
    num_migrations: 3614                num_migrations: 3557

From a purely NUMA perspective, accurately setting the preferred node from user
space, "Preferred Node Affinity", appears to be a substantial win as can be seen
by comparing lines {2, 11} vs line {20} and lines {5, 14} vs line {32}. 

We also see that NB does not have nearly the same effect with the CPU node
floating and the memory bound as when both were floating. The function
task_numa_work() does clearly skip non-migratable VMAs. The issue with this is
that when enabling NB, the most important accesses of some tasks aren't tracked,
while the accesses that are can lead to the wrong value for numa_preferred_nid,
and thus NB gets turned off.

On digging into this further, there was a 2014 presentation "Automatic NUMA
Balancing" [2] which declares support for "unmovable" memory as a future,
recognizes it's value in correctly setting numa_preferred_nid, but says it is
unclear if it is worthwhile. I am currently working on enabling this and running
such tests. 

As a final note, I will have a chance to validate the effects of these changes
against the DB next month.


[1] [RFC PATCH 0/3] Scheduler Soft Affinity
https://lore.kernel.org/lkml/20190626224718.21973-1-subhra.mazumdar@oracle.com/

[2] "Automatic NUMA Balancing",
https://events.static.linuxfound.org/sites/events/files/slides/summit2014_riel_chegu_w_0340_automatic_numa_balancing_0.pdf


