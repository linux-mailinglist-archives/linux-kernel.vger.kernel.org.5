Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6AC78BE3F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 08:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231980AbjH2GHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 02:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233831AbjH2GG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 02:06:56 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB82112D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 23:06:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cv6AwYLje70TeAXXz5bcBd22/fFXo2c5GxnrSmd3Bycgc1V5Jbf3fwCT0Po73WrwFi7H3aLWhEjEVruj+XjoMriSUvVmEPaXSa5v19Y3u0QKXgO1k4fcKfJ0YafmrYCNV7SwwOUq1KWT44grMNiJXDhmgSnAyr4US/xpzFrCM2MOCnBvYXTuWLDtNH/JFu/1bTfJHJ/It+qJ967I2lnlu/O63lxTS1IulMBVYmQhLgctWrpSx5xitbOi1FA9wEvrb+4rPoXJdc/LpIp0n2FmHGWI0J5S3DLd78ETYsS2zl7EsENO5zRK07UgARjBDwCsQFF/u/xjzKmJX9IkEIFglg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NfVar12pI5wLuHapPnY1eDoN+/L9lW0b6BNagKW6NRY=;
 b=JWtriI6o8Jca05hK19DqZ1ol8zRGnV1NaUztygPKUCjrvcoPBZlj4Q1M/gNigUML3lF8O5ZFRnEOm2xed2bchvNZM3/X2tJF3YHzDxUPydHA9Ilw5MsgBSlw5W5C2OuYAdRbMqpAiF4ojwPfoqfSFoyEw1DiZfoY9TcrB3Bfy8HG23BiApLSh5TT20B5qQMaLvh3fWLATXeJKmNvioa+Bk6JTVMXbFxeIERFZjiFspk9BkgaW8T0JfGuGZj21VL6VufA7S6ouj4GdD6ftyRYKa49I2kP20CASIT9LsDJAx+sUTaWBTqkwqhyzYIAfI0A+kwljr5rBcihcGAXTpLIuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NfVar12pI5wLuHapPnY1eDoN+/L9lW0b6BNagKW6NRY=;
 b=zUaxamSql9PSUtF68cPMY3oxQxfdeyJozQ9Xuy98bQyvTeNcDlMMM6+48hcUbGj6e2D9CUxvJWsq1DVbTvjQp0hfOKfyCjGaXiPO2n/bXkTiTEfPVIuvXVZXAo/N8AGDgfWfU5TUYOXVrf5b05Onj6L2+FPeGcct/KeC8HhLCk8=
Received: from MW4PR02CA0016.namprd02.prod.outlook.com (2603:10b6:303:16d::22)
 by CY5PR12MB6432.namprd12.prod.outlook.com (2603:10b6:930:38::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Tue, 29 Aug
 2023 06:06:50 +0000
Received: from CO1PEPF000044F1.namprd05.prod.outlook.com
 (2603:10b6:303:16d:cafe::6d) by MW4PR02CA0016.outlook.office365.com
 (2603:10b6:303:16d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35 via Frontend
 Transport; Tue, 29 Aug 2023 06:06:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F1.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.16 via Frontend Transport; Tue, 29 Aug 2023 06:06:49 +0000
Received: from BLR-L-RKODSARA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 29 Aug
 2023 01:06:42 -0500
From:   Raghavendra K T <raghavendra.kt@amd.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
CC:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Mel Gorman" <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "David Hildenbrand" <david@redhat.com>, <rppt@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bharata B Rao <bharata@amd.com>,
        Aithal Srikanth <sraithal@amd.com>,
        "kernel test robot" <oliver.sang@intel.com>,
        Raghavendra K T <raghavendra.kt@amd.com>,
        Sapkal Swapnil <Swapnil.Sapkal@amd.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>
Subject: [RFC PATCH V1 0/6] sched/numa: Enhance disjoint VMA scanning
Date:   Tue, 29 Aug 2023 11:36:08 +0530
Message-ID: <cover.1693287931.git.raghavendra.kt@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F1:EE_|CY5PR12MB6432:EE_
X-MS-Office365-Filtering-Correlation-Id: f32f8580-b87a-40d0-a865-08dba8562258
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NblIUSCQHME22L/SxmFkaW5d9qhjO02fajR7yfVhcBdSa4qvA4l/yS/VdjQpIOA545x4fJ6zg6X45vC8pGJM8cUORRNVEp95DDF0HAWBGzNi/7qy06EoljGy0uA96tmqcUHjSKI7SNPQUHAZtNFTN14Y0JOIl/JGKRxwr1xxIG/4fArLa60WOGLMzu2qWI6XzcJ6GLjXnlJJB1OiuY+viVEw8Pt+6k//P1Xzv4Ncm+FustLEgLxAat9a5+yOdPxRqiJ9YqI8wX3mj4XqfN8qVQTX3Lsi/5YgE4b0gBEFoae7DgIpEuKuwTEbfwTwkOut6onm6U+L90IdbQQ2SLc0SQf2+QnY2ftUsNse9sXIKS47Wqo8F1o68RU9vF48B8shp2EcCwlGGdcMzgbCeL9gqSicrMmgk8TBj3GCGJ27/RK9TpLnNLMnmj+sgLO6mhQsYcC7bGJlG7JSNiMdT0paN4wSau3L1HqCA2UDoHekrKXA7ITxpb18taPc4vd8GP26O3bWnC13N8qyXxNq//alFx6L4PvUx4fwaX3RzUXeqosrR0BAzvcGv9MDhkLgF0R8ImSaQHzyRpVcPSekboUDWYjo6PBXtt9+ILx6ythfEQHUPRqlTjD1VOBfKwWZmvUlYso1Uo2UTLtQaOrtFR57xtqKF3LQbCvEQgZieL5CPLWtdfz05cXb3b457czcYuBBZ20gICM7tmHRtQqsDZ0M3RO7fRvHefkL70MlLNK6+PMqwBMwYIbzJCmtV3/aD8xq4BGw2RyGS2SARvG4jtvFDuV4/+N3t1JQ22NfiI8RaTlrh//1l7dkJ76QGgDY3NbC
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(39860400002)(346002)(136003)(82310400011)(186009)(1800799009)(451199024)(46966006)(36840700001)(40470700004)(2616005)(83380400001)(40460700003)(4326008)(5660300002)(8936002)(8676002)(36860700001)(426003)(336012)(7416002)(47076005)(36756003)(40480700001)(16526019)(6666004)(82740400003)(54906003)(70206006)(70586007)(316002)(478600001)(110136005)(81166007)(356005)(966005)(26005)(41300700001)(2906002)(7696005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 06:06:49.8384
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f32f8580-b87a-40d0-a865-08dba8562258
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6432
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit fc137c0ddab2 ("sched/numa: enhance vma scanning logic") [1]
VMA scanning is allowed if:
1) The task had accessed the VMA. 
 Rationale: Reduce overhead for the tasks that had not
touched VMA. Also filter out unnecessary scanning.

2) Early phase of the VMA scan where mm->numa_scan_seq is less than 2.
 Rationale: Understanding initial characteristics of VMAs and also
 prevent VMA scanning unfairness.

While that works for most of the times to reduce scanning overhead,
 there are some corner cases associated with it.

This was found in an internal LKP run and also reported by [2]. There was
an attempt to fix.

Link: https://lore.kernel.org/linux-mm/cover.1685506205.git.raghavendra.kt@amd.com/T/

This is a fully different series after Mel's feedback to address the issue
 and also a continuation of enhancing VMA scanning for NUMA balancing.

Problem statement (Disjoint VMA set):
======================================
Let's look at some of the corner cases with a below example of tasks and their
access pattern.

Consider N tasks (threads) of a process.
Set1 tasks accessing vma_x (group of VMAs)
Set2 tasks accessing vma_y (group of VMAs)

             Set1                      Set2
        -------------------         --------------------
        | task_1..task_n/2 |       | task_n/2+1..task_n |
        -------------------         --------------------	
                 |                             |
                 V                             V
        -------------------         --------------------
        |     vma_x       |         |     vma_y         |
        -------------------         --------------------	

Corner cases:
(a) Out of N tasks, not all of them gets fair opportunity to scan. (PeterZ).
suppose Set1 tasks gets more opportunity to scan (May be because of the
activity pattern of tasks or other reasons in current design) in the above
example, then vma_x gets scanned more number of times than vma_y.

some experiment is also done here which illustrates this unfairness:
Link: https://lore.kernel.org/lkml/c730dee0-a711-8a8e-3eb1-1bfdd21e6add@amd.com/

(b) Sizes of vmas can differ.
Suppose size of vma_y is far greater than the size of vma_x, then a bigger
portion of vma_y can potentially be left unscanned since scanning is bounded
by scan_size of 256MB (default) for each iteration.

(c) Highly active threads trap a few VMAs frequently, and some of the VMAs not 
accessed for long time can potentially get starved of scanning indefinitely
(Mel). There is a possibility of lack of enough hints/details about VMAs if it
is needed later for migration.

(d) Allocation of memory in some specific manner (Mel).
One example could be, Suppose a main thread allocates memory and it is not
active. When other threads tries to act upon it, they may not have much
hints about it, if the corresponding VMA was not scanned.

(e) VMAs that are created after two full scans of mm (mm->numa_scan_seq > 2)
will never get scanned. (Observed rarely but very much possible depending on
workload behaviour).

Above this, a combination of some of the above (e.g., (a) and (b)) can
potentially amplifyi/worsen the side effect.

This patchset, tries to address the above issues by enhancing unconditional
VMA scanning logic.

High level ideas:
=================
Idea-1) Depending on vma_size, populate a per vma_scan_select value, decrement it
and when it hits zero do force scan (Mel).
vma_scan_select value is again repopulated when it hits zero.

This is how VMA scanning phases looks like after implementation:

|<---p1--->|<-----p2----->|<-----p2----->|...

Algorithm:
p1: New VMA, initial phase do not scan till scan_delay.

p2: Allow scanning if the task has accessed VMA or vma_scan_select hit zero.

Reinitialize vma_scan_select and repeat p2.

pros/cons:
+  : Ratelimiting is inbuilt to the approach
+  : vma_size is taken into account for scanning
+/-: Scanning continues forever
-  : Changes in vma size is taken care after force scan. i.e.,
   vma_scan_select is repopulated only after vma_scan_select hits zero.

Idea-1 can potentially cover all the issues mentioned above.

Idea-2) Take bitmask_weight of latest access_pids value (suggested by Bharata).
If number of tasks accessing vma is >= 1, unconditionally allow scanning.

Idea-3 ) Take bitmask_weight of access_pid history of VMA. If number of tasks
accessing VMA is > THRESHOLD (=3), unconditionally allow scanning.

Rationale (Idea-2,3): Do not miss out scanning of critical VMAs.

Idea-4) Have a per vma_scan_seq. allow the unconditional scan till vma_scan_seq
reaches a value proportional (or equal) to vma_size/scan_size.
This a complimentary to Idea-1.

this is how VMA scanning phases looks like after implementation:

|<--p1--->|<-----p2----->|<-----p3----->|<-----p4----->...||<-----p2----->|<-----p3----->|<-----p4-----> ...||
                                                        RESET                                               RESET
Algorithm:
p1: New VMA, initial phase do not scan till scan_delay.

p2: Allow scanning if task has accessed VMA or vma_scan_seq has reached till
 f(vma_size)/scan_size) for e.g., f = 1/2 * vma_size/scan_size.

p3: Allow scanning if task has accessed VMA or vma_scan_seq has reached till
 f(vma_size)/scan_size in a rate limited manner. This is an optional phase.

p4: Allow scanning iff task has accessed VMA.

Reset after p4 (optional).

Repeat p2, p3 p4

Motivation: Allow agressive scanning in the beginning followed by a rate
limited scanning. And then completely disallow scanning to avoid unnecessary
scanning. Reset time could be a function of scan_delay and chosen long enough
to aid long running task to forget history and start afresh.

+  : Ratelimiting need to be taken care separately if needed.
+/-: Scanning continues only if RESET of vma_scan_seq is implemented.
+  : changes in vma size is taken care in every scan.

 Current patch series implements Ideas 1, 2, 3 + extension of access PID history
idea from PeterZ.

Results:
======
Base: 6.5.0-rc6+ (4853c74bd7ab)
SUT: Milan w/ 2 numa nodes 256 cpus

mmtest		numa01_THREAD_ALLOC manual run:

		base		patched
real		1m22.758s	1m9.200s
user		249m49.540s	229m30.039s
sys		0m25.040s	3m10.451s
	
numa_pte_updates 	6985	1573363
numa_hint_faults 	2705	1022623
numa_hint_faults_local 	2279	389633
numa_pages_migrated 	426	632990

kernbench
			base			patched
Amean     user-256    21989.09 (   0.00%)    21677.36 *   1.42%*
Amean     syst-256    10171.34 (   0.00%)    10818.28 *  -6.36%*
Amean     elsp-256      166.81 (   0.00%)      168.40 *  -0.95%*

Duration User       65973.18    65038.00
Duration System     30538.92    32478.59
Duration Elapsed      529.52      533.09

Ops NUMA PTE updates                  976844.00      962680.00
Ops NUMA hint faults                  226763.00      245620.00
Ops NUMA pages migrated               220146.00      207025.00
Ops AutoNUMA cost                       1144.84        1238.77

Improvements in other benchmarks I have tested.
Time based:
Hashjoin	4.21%
Btree	 	2.04%
XSbench		0.36%

Throughput based:
Graph500 	-3.62%
Nas.bt		3.69%
Nas.ft		21.91%

Note: VMA scanning improvements [1] has refined scanning so much that
system overhead we re-introduce with additional scan look glaringly
high. But If we consider the difference between before [1] and current
series, overall scanning overhead is considerably reduced.

1. Link: https://lore.kernel.org/lkml/cover.1677672277.git.raghavendra.kt@amd.com/T/#t
2. Link: https://lore.kernel.org/lkml/cover.1683033105.git.raghavendra.kt@amd.com/

Note: Patch description is again repeated in some patches to avoid any
need to copy from cover letter again.

Peter Zijlstra (1):
  sched/numa: Increase tasks' access history

Raghavendra K T (5):
  sched/numa: Move up the access pid reset logic
  sched/numa: Add disjoint vma unconditional scan logic
  sched/numa: Remove unconditional scan logic using mm numa_scan_seq
  sched/numa: Allow recently accessed VMAs to be scanned
  sched/numa: Allow scanning of shared VMAs

 include/linux/mm.h       |  12 +++--
 include/linux/mm_types.h |   5 +-
 kernel/sched/fair.c      | 109 ++++++++++++++++++++++++++++++++-------
 3 files changed, 102 insertions(+), 24 deletions(-)

-- 
2.34.1

