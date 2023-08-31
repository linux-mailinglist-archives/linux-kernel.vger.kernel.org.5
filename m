Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81F6278EACE
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 12:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345152AbjHaKqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 06:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245032AbjHaKqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 06:46:37 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3688BE45
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 03:46:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kdKtvHXMvugW5dR1FkQx3WnjmWHEpQ1bYvj//iTvptnQqbrWD5JPFxdyAOyKIf5rJ4yWsEWOfMuWBnJo8bJjXedNKcAJz55iKf3cuUosQoTyTvyvgeaka3aWnUwh+kjehHMcPoxvQBAdsbG0jZjuRW7WYWImnWrataRHML/YwJz25mL52MqMfFVw0tGAUP3xNj98AMVah0GUQGWo8xMl1aWqualG62CGGorekIV+NYfZgBwXX38uMm0Wp4sKjOZxtt3EFXv9zEKQpevY2Ycx4/Cv0270zBcyA+DGARPVv05q2mU/iQKA3dkPJ2+9fDinGFRiFNNtnQNVRfg47UI6iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N700d41axJmuUDbgbPsF0gLqf4w1V9LDbR0F2kNTLks=;
 b=BDV0Q2hiwDcoTCJAYBvV8jbcROuZq6ChvwubKJiKA4DV6imNCKbYE/KlosQLdPMjtrAFnfCgvJZVqlQCHFclAUlU3Pg5mNg5RwWjKUqwBl4vTKEIB7ZXSj2aSOxHyupsvA97vfFN3n9u7DEadlXKF7ZmOtn24fcEs2iMtDk2D+UXRkEaJXDdru1KG3SYus2Up4vcQGs2cDSZDomg0O2NmL7JOJaZ+xcMjkKUFKsDfecNUxjYOiTKiPsmUrMH37PGIPRZI21TC3b0t9/11Tr8uL95oT0ejkBJLxMQmcMhS7yMzJUYv7BMKtpF22LeAK+sQgtquuohaDcoOD9pZ6ia+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=manifault.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N700d41axJmuUDbgbPsF0gLqf4w1V9LDbR0F2kNTLks=;
 b=gnypNJvXYo2VdDt2768QEQizaW6XhTXDgx6ymx9/jnGKKkTEMANx4EZ/D/1uLPoyYXhJw9BNIKzpUBWaIqFlfEmYTtuqbs/ZU12I1oaqd3I1wU4xjOmKIIJjEi+I1C5EOn7yIQYT/w4NZjLXDSx8YGlfNe2IeB88+6DCW7pA3yE=
Received: from SN7P222CA0016.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::16)
 by PH7PR12MB7209.namprd12.prod.outlook.com (2603:10b6:510:204::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Thu, 31 Aug
 2023 10:45:44 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:124:cafe::f5) by SN7P222CA0016.outlook.office365.com
 (2603:10b6:806:124::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.22 via Frontend
 Transport; Thu, 31 Aug 2023 10:45:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Thu, 31 Aug 2023 10:45:43 +0000
Received: from BLR5CG134614W.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 31 Aug
 2023 05:45:36 -0500
From:   K Prateek Nayak <kprateek.nayak@amd.com>
To:     <void@manifault.com>
CC:     <linux-kernel@vger.kernel.org>, <peterz@infradead.org>,
        <mingo@redhat.com>, <juri.lelli@redhat.com>,
        <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
        <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
        <bristot@redhat.com>, <vschneid@redhat.com>, <tj@kernel.org>,
        <roman.gushchin@linux.dev>, <gautham.shenoy@amd.com>,
        <aaron.lu@intel.com>, <wuyun.abel@bytedance.com>,
        <kernel-team@meta.com>, <kprateek.nayak@amd.com>
Subject: [RFC PATCH 1/3] sched/fair: Move SHARED_RUNQ related structs and definitions into sched.h
Date:   Thu, 31 Aug 2023 16:15:06 +0530
Message-ID: <20230831104508.7619-2-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230831104508.7619-1-kprateek.nayak@amd.com>
References: <31aeb639-1d66-2d12-1673-c19fed0ab33a@amd.com>
 <20230831104508.7619-1-kprateek.nayak@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|PH7PR12MB7209:EE_
X-MS-Office365-Filtering-Correlation-Id: 462aeeaf-16d8-473f-0b35-08dbaa0f6d25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6DC7PVxSgFF2pUcVDQI9eASIMyeTtYQb72adHTIN3/qR/+TbBMNgeyaWzqCIRyksr4mUWYpkqLzpB2qW7kWqwfskJI7KTkBpNTiAbSsIxp46m5v9CFhvh8Llbnxzdy3bd+rMnimL0oGwk1h72Hpunkdlw8qDvwqnFoDNzv4BOaJmWubHfIC81deVCBlA/4k17fyvvCUAPSfyACHSAv1Z+E5PxnZS1I4RoycXlqdxcWsSIhPG0jWBYfmRICTTSO3ilG22pP0u+WNje6w04f3PcgfU2q1YjDeTdL+YgMYP/+OYWQhugaFVhp1GNU1GCd/tAwb9ReJ0cMYrt4bEijmVqoaybNEF6B3tIwYRRO1wxmeaHnD+5K6Kwpzxj/cvPVKWzOvdJwDLuWLKYWjZh2vI/EMtFhUAqF48E27pqibgojolzFKPU9H/vWB1p0zwvMCuE75sEETaxRXsDPhpwQ0qbG691BuS10LHgFeYxXgpkIfJsaJAjN4cirZ3+QmAwORA3HHGpdNJR1k1f4rHuu3VgYevMWz4MTFA7y6+OoTybYKznSRRfk9thYdtH5NaQVkXZWOydvwdJycmMNATxJWriGrhEIyFlbJKctqauUIk/wlHo18d++q0CMGbMreQlbCZKIl/DilCP8GV28TpWI/pCcUhcY4r/ASHshluHy87jzBWF1uSrkmDXctj8I8b/S9H+qHtoMz38/Zqb7wfhuRF1sycx72ReisS7ZN3OX6SgWZjTJockjfAE7CEUv1k+vq8O2HB4Bvv0rr/IA8/LgSGyw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(376002)(396003)(39860400002)(186009)(1800799009)(82310400011)(451199024)(46966006)(40470700004)(36840700001)(356005)(81166007)(82740400003)(8936002)(6666004)(478600001)(70206006)(7696005)(54906003)(70586007)(6916009)(316002)(41300700001)(40460700003)(26005)(2616005)(16526019)(36756003)(8676002)(2906002)(86362001)(5660300002)(83380400001)(36860700001)(40480700001)(1076003)(426003)(336012)(47076005)(4326008)(7416002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 10:45:43.4807
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 462aeeaf-16d8-473f-0b35-08dbaa0f6d25
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7209
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move struct shared_runq_shard, struct shared_runq, SHARED_RUNQ_SHARD_SZ
and SHARED_RUNQ_MAX_SHARDS definitions into sched.h

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 kernel/sched/fair.c  | 68 --------------------------------------------
 kernel/sched/sched.h | 68 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+), 68 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d67d86d3bfdf..bf844ffa79c2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -139,74 +139,6 @@ static int __init setup_sched_thermal_decay_shift(char *str)
 }
 __setup("sched_thermal_decay_shift=", setup_sched_thermal_decay_shift);
 
-/**
- * struct shared_runq - Per-LLC queue structure for enqueuing and migrating
- * runnable tasks within an LLC.
- *
- * struct shared_runq_shard - A structure containing a task list and a spinlock
- * for a subset of cores in a struct shared_runq.
- *
- * WHAT
- * ====
- *
- * This structure enables the scheduler to be more aggressively work
- * conserving, by placing waking tasks on a per-LLC FIFO queue shard that can
- * then be pulled from when another core in the LLC is going to go idle.
- *
- * struct rq stores two pointers in its struct cfs_rq:
- *
- * 1. The per-LLC struct shared_runq which contains one or more shards of
- *    enqueued tasks.
- *
- * 2. The shard inside of the per-LLC struct shared_runq which contains the
- *    list of runnable tasks for that shard.
- *
- * Waking tasks are enqueued in the calling CPU's struct shared_runq_shard in
- * __enqueue_entity(), and are opportunistically pulled from the shared_runq in
- * newidle_balance(). Pulling from shards is an O(# shards) operation.
- *
- * There is currently no task-stealing between shared_runqs in different LLCs,
- * which means that shared_runq is not fully work conserving. This could be
- * added at a later time, with tasks likely only being stolen across
- * shared_runqs on the same NUMA node to avoid violating NUMA affinities.
- *
- * HOW
- * ===
- *
- * A struct shared_runq_shard is comprised of a list, and a spinlock for
- * synchronization.  Given that the critical section for a shared_runq is
- * typically a fast list operation, and that the shared_runq_shard is localized
- * to a subset of cores on a single LLC (plus other cores in the LLC that pull
- * from the shard in newidle_balance()), the spinlock will typically only be
- * contended on workloads that do little else other than hammer the runqueue.
- *
- * WHY
- * ===
- *
- * As mentioned above, the main benefit of shared_runq is that it enables more
- * aggressive work conservation in the scheduler. This can benefit workloads
- * that benefit more from CPU utilization than from L1/L2 cache locality.
- *
- * shared_runqs are segmented across LLCs both to avoid contention on the
- * shared_runq spinlock by minimizing the number of CPUs that could contend on
- * it, as well as to strike a balance between work conservation, and L3 cache
- * locality.
- */
-struct shared_runq_shard {
-	struct list_head list;
-	raw_spinlock_t lock;
-} ____cacheline_aligned;
-
-/* This would likely work better as a configurable knob via debugfs */
-#define SHARED_RUNQ_SHARD_SZ 6
-#define SHARED_RUNQ_MAX_SHARDS \
-	((NR_CPUS / SHARED_RUNQ_SHARD_SZ) + (NR_CPUS % SHARED_RUNQ_SHARD_SZ != 0))
-
-struct shared_runq {
-	unsigned int num_shards;
-	struct shared_runq_shard shards[SHARED_RUNQ_MAX_SHARDS];
-} ____cacheline_aligned;
-
 #ifdef CONFIG_SMP
 
 static DEFINE_PER_CPU(struct shared_runq, shared_runqs);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b504f8f4416b..f50176f720b1 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -545,6 +545,74 @@ do {									\
 # define u64_u32_load(var)      u64_u32_load_copy(var, var##_copy)
 # define u64_u32_store(var, val) u64_u32_store_copy(var, var##_copy, val)
 
+/**
+ * struct shared_runq - Per-LLC queue structure for enqueuing and migrating
+ * runnable tasks within an LLC.
+ *
+ * struct shared_runq_shard - A structure containing a task list and a spinlock
+ * for a subset of cores in a struct shared_runq.
+ *
+ * WHAT
+ * ====
+ *
+ * This structure enables the scheduler to be more aggressively work
+ * conserving, by placing waking tasks on a per-LLC FIFO queue shard that can
+ * then be pulled from when another core in the LLC is going to go idle.
+ *
+ * struct rq stores two pointers in its struct cfs_rq:
+ *
+ * 1. The per-LLC struct shared_runq which contains one or more shards of
+ *    enqueued tasks.
+ *
+ * 2. The shard inside of the per-LLC struct shared_runq which contains the
+ *    list of runnable tasks for that shard.
+ *
+ * Waking tasks are enqueued in the calling CPU's struct shared_runq_shard in
+ * __enqueue_entity(), and are opportunistically pulled from the shared_runq in
+ * newidle_balance(). Pulling from shards is an O(# shards) operation.
+ *
+ * There is currently no task-stealing between shared_runqs in different LLCs,
+ * which means that shared_runq is not fully work conserving. This could be
+ * added at a later time, with tasks likely only being stolen across
+ * shared_runqs on the same NUMA node to avoid violating NUMA affinities.
+ *
+ * HOW
+ * ===
+ *
+ * A struct shared_runq_shard is comprised of a list, and a spinlock for
+ * synchronization.  Given that the critical section for a shared_runq is
+ * typically a fast list operation, and that the shared_runq_shard is localized
+ * to a subset of cores on a single LLC (plus other cores in the LLC that pull
+ * from the shard in newidle_balance()), the spinlock will typically only be
+ * contended on workloads that do little else other than hammer the runqueue.
+ *
+ * WHY
+ * ===
+ *
+ * As mentioned above, the main benefit of shared_runq is that it enables more
+ * aggressive work conservation in the scheduler. This can benefit workloads
+ * that benefit more from CPU utilization than from L1/L2 cache locality.
+ *
+ * shared_runqs are segmented across LLCs both to avoid contention on the
+ * shared_runq spinlock by minimizing the number of CPUs that could contend on
+ * it, as well as to strike a balance between work conservation, and L3 cache
+ * locality.
+ */
+struct shared_runq_shard {
+	struct list_head list;
+	raw_spinlock_t lock;
+} ____cacheline_aligned;
+
+/* This would likely work better as a configurable knob via debugfs */
+#define SHARED_RUNQ_SHARD_SZ 6
+#define SHARED_RUNQ_MAX_SHARDS \
+	((NR_CPUS / SHARED_RUNQ_SHARD_SZ) + (NR_CPUS % SHARED_RUNQ_SHARD_SZ != 0))
+
+struct shared_runq {
+	unsigned int num_shards;
+	struct shared_runq_shard shards[SHARED_RUNQ_MAX_SHARDS];
+} ____cacheline_aligned;
+
 /* CFS-related fields in a runqueue */
 struct cfs_rq {
 	struct load_weight	load;
-- 
2.34.1

