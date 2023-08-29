Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC7C78BE42
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 08:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233582AbjH2GHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 02:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232887AbjH2GHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 02:07:34 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2073.outbound.protection.outlook.com [40.107.101.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81B7124
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 23:07:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F1kiLtsi4Z1kYvfFbAVgY9f7V4ZyIU3WE+ATfG8Uj8NvknrOjLRMkP8IsgY7Xa8amYPzzBGaZHB6/K8IGhidf5RzrcyBiw4hqP7dvgxhGpj1ihkOIEyE9uxHOoF9vrZttKpAHZQ4V/51n4Y4TGKI3i7H7rum/PU00DNLaGsd68MuyHzDUWgVPo7ChvZw+2S8RdSP7A/mX3wDYAB6YPhAVkfxpe1N0kVsH6d/B+WArC4C+3Hu38nBdMHPknKPmwe0/jEZs1i4LeKysBw0Rjre3HjlPpYF+1GZoZEtCd8v+AtZXO2mkcWI13LcTIoBfsNyCilxcOD5uxIG7zdsCA5iYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RNKcjTamJ6O4ps8dbHURIi8t9orAhAQlAyfobLURR6E=;
 b=BZT9X/14cX6PBuIUUyTk+BIbUBU6hUz9E4C6r0DYZQJ8BKNaIIMmr0c/v//G3lFSkiYoZtMQJRd65BzN4+vR1FqxrdloUEpCRZPcOkibCrARA8cCTR0Ih18Z+AvU4ZZRFQ8Oz4REo+tGlq0WtLRZrGUQYGJ9LxQqgCagzMkXoFprKNvUYtn3nuRoah8uPCfmjPGHpf3t4KTzXLa2iqY5FRhcHMhxJsVg7OdRdhemnAY+MBYupQuhRTbR94TzeOSjVpTzv9p4kYwoT9mUbW4aHHWzT2Jx3jTab48uc6Mqu38HIp0JY//CLcceBINxBu2isRd4LQmIXu+7NltwV5flgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNKcjTamJ6O4ps8dbHURIi8t9orAhAQlAyfobLURR6E=;
 b=3mGiw0ZXdvJ2/JjVJsRIOWV1/r9OnOhCW0JdEetVwdlFgnpyIC1hbfZxDTsDXRMpxJnqVJh/HMA4/uGq8ZeMMH+XFtDH9/U6GD7MuNup8U/dekizajHudMZIUZj9pnKrpJXdu/ZhIbatT/5pD6zSFvdjpY7w0dWloN3RfG0qkFs=
Received: from DS7PR03CA0097.namprd03.prod.outlook.com (2603:10b6:5:3b7::12)
 by PH0PR12MB8798.namprd12.prod.outlook.com (2603:10b6:510:28d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Tue, 29 Aug
 2023 06:07:26 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10b6:5:3b7:cafe::e4) by DS7PR03CA0097.outlook.office365.com
 (2603:10b6:5:3b7::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35 via Frontend
 Transport; Tue, 29 Aug 2023 06:07:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Tue, 29 Aug 2023 06:07:26 +0000
Received: from BLR-L-RKODSARA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 29 Aug
 2023 01:07:20 -0500
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
Subject: [RFC PATCH V1 2/6] sched/numa: Add disjoint vma unconditional scan logic
Date:   Tue, 29 Aug 2023 11:36:10 +0530
Message-ID: <87e3c08bd1770dd3e6eee099c01e595f14c76fc3.1693287931.git.raghavendra.kt@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1693287931.git.raghavendra.kt@amd.com>
References: <cover.1693287931.git.raghavendra.kt@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|PH0PR12MB8798:EE_
X-MS-Office365-Filtering-Correlation-Id: 84d78275-2e4f-4253-3882-08dba85637f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yGJI9A0Hcrp7Br9gKC955LxrMkyGtsrMKk0mUOHSaf5QwVVFZtzqEe1EF6Kr6iUE4vHyIqgPEYzKVZft3BcyyHBiWPswCAwP9W5TQ3zkgVubJSayk3R1JgrH6qPlhf/peSF0IGpElfhTwbjrldBSfxjHYkm5sOA0yUaSyywhkjMihkGdRWim7L05kGo2vDaYYaRhSyaaDXGokLYxh8oo2E548Ct75KcjRBzr54fT7gqhAsViWJEpxFlyVXfIzg5HNinqDLdSrUp97+Qwe3oegmwU5Kv6GJ16TMufGjGvh8FhFPi5aRUzCpxviN5/j29YTNN3NQGm/RXPobhqQQFuQY3zZjGyP2V4To93OlBQEgRgN6lNt4GzNiY6LQz37QHOPriEOu6RX6iNxQGir3LPNmp34iFXuuwJZ98E/yNnnKm8pbUZopHZqwZP1rQciLx9pLW4HQRViptSJR1Js+cwlPXjhbViLeIeIbPGq7jLtBjMMZOvY4pISpRyAjDLIUrAgae+OtFT5TZAjUzoMREGnVKJNxJ/vk/ynaHZFcpc+3Jsu6V4FIYlTONTpgf9VnpvDgwfW+kxDl6kshbrvyoGvTu5tinfViS3a+pqBWubHyWSghjt3p2iuYJkmdYBjDEWnLgBByURMpVzmh/oC7yJ9lMZSwfdbcrepE1MqwlH0S11yu1dZlJ7LEcdi5aIVYmtWtow8gEj6d1QN4+PsOAdmoe3mkjg/cRC8Iwqlx6KTIsE1AFpa+O+jOJODE+PV99nf/1vjxB2Llie0m/90qo8oakPTUlftq+glbYSEEHjGSQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(136003)(346002)(396003)(82310400011)(186009)(1800799009)(451199024)(46966006)(36840700001)(40470700004)(6666004)(7696005)(83380400001)(966005)(478600001)(336012)(426003)(26005)(16526019)(2906002)(7416002)(54906003)(70586007)(2616005)(316002)(41300700001)(110136005)(70206006)(5660300002)(4326008)(8936002)(8676002)(40460700003)(36756003)(40480700001)(356005)(36860700001)(47076005)(81166007)(82740400003)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 06:07:26.1707
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84d78275-2e4f-4253-3882-08dba85637f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8798
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit fc137c0ddab2 ("sched/numa: enhance vma scanning logic")
VMA scanning is allowed if:
1) The task had accessed the VMA.
 Rationale: Reduce overhead for the tasks that had not
touched VMA. Also filter out unnecessary scanning.

2) Early phase of the VMA scan where mm->numa_scan_seq is less than 2.
 Rationale: Understanding initial characteristics of VMAs and also
 prevent VMA scanning unfairness.

While that works for most of the times to reduce scanning overhead,
 there are some corner cases associated with it.

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

Current patch tries to address the above issues by enhancing unconditional
VMA scanning logic.

High level idea:
Depending on vma_size, populate a per vma_scan_select value, decrement it
and when it hits zero do force scan (Mel).
vma_scan_select value is again repopulated when it hits zero.

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

Reported-by: Aithal Srikanth <sraithal@amd.com>
Reported-by: kernel test robot <oliver.sang@intel.com>
Suggested-by: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>
---
 include/linux/mm_types.h |  1 +
 kernel/sched/fair.c      | 39 +++++++++++++++++++++++++++++++++++++--
 2 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 5e74ce4a28cd..647d9fc5da8d 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -479,6 +479,7 @@ struct vma_numab_state {
 	unsigned long next_scan;
 	unsigned long next_pid_reset;
 	unsigned long access_pids[2];
+	unsigned long vma_scan_select;
 };
 
 /*
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2f2e1568c1d4..23375c10f36e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2928,6 +2928,36 @@ static void reset_ptenuma_scan(struct task_struct *p)
 	p->mm->numa_scan_offset = 0;
 }
 
+#define VMA_4M	(1U << 22)
+#define VMA_RATELIMIT_SCALEDOWN_F	7
+
+static inline unsigned int vma_scan_ratelimit(struct vm_area_struct *vma)
+{
+	unsigned int vma_size, ratelimit = 0;
+
+	/*
+	 * Rate limit the scanning of VMA based on the size.
+	 * vma_size > 4M allow 1 in 2 times.
+	 * vma_size = 4k allow 1 in 9 times.
+	 * 4k < vma_size < 4M scale between 2 and 9
+	 */
+	vma_size = (vma->vm_end - vma->vm_start);
+	if (vma_size)
+		ratelimit  = (VMA_4M / vma_size) >> VMA_RATELIMIT_SCALEDOWN_F;
+	return 1 + ratelimit;
+}
+
+static bool task_disjoint_vma_select(struct vm_area_struct *vma)
+{
+	if (vma->numab_state->vma_scan_select > 0) {
+		vma->numab_state->vma_scan_select--;
+		return false;
+	} else
+		vma->numab_state->vma_scan_select = vma_scan_ratelimit(vma);
+
+	return true;
+}
+
 static bool vma_is_accessed(struct vm_area_struct *vma)
 {
 	unsigned long pids;
@@ -3058,6 +3088,8 @@ static void task_numa_work(struct callback_head *work)
 			/* Reset happens after 4 times scan delay of scan start */
 			vma->numab_state->next_pid_reset =  vma->numab_state->next_scan +
 				msecs_to_jiffies(VMA_PID_RESET_PERIOD);
+
+			vma->numab_state->vma_scan_select = 0;
 		}
 
 		/*
@@ -3077,8 +3109,11 @@ static void task_numa_work(struct callback_head *work)
 			vma->numab_state->access_pids[1] = 0;
 		}
 
-		/* Do not scan the VMA if task has not accessed */
-		if (!vma_is_accessed(vma))
+		/*
+		 * Do not scan the VMA if task has not accessed OR it is still
+		   an unlucky disjoint vma.
+		 */
+		if (!(vma_is_accessed(vma) || task_disjoint_vma_select(vma)))
 			continue;
 
 		do {
-- 
2.34.1

