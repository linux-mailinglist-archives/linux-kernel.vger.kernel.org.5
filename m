Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B032878EAF8
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 12:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244986AbjHaKry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 06:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345266AbjHaKrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 06:47:42 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E89FCFE
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 03:47:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XcoOI4a1rvQPQSJ6jqZfzZRyfmPo5VWGzKHw6LX2ZMj08/3xwPFeDz80r00QyH/RMt9vjCBKawA92yLP2/tV9qKnwwhnvinlTLlblnbBWuyk5MQbdWw9ov0ZNQIr00R99zJkxYN6OUn0zCxsBehmhE8E6xZU8soTskWc/i/E8VUm/CcdzTmfLlJWm2fHWv+Zr9SB0+soQXV2CZuBBXSBYIXJatQcn3ajshvtCFy+080jlJ1MgPexzHy3Pk+d+gs22o0YmdqXYQxbwmQOeIBaOilCJNE8tz0fTcg4LHLhqaZEVzB+g/Sc2GHGr5H2mPR9nZ33akqOwXv9As8zqfE/aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D3fOzSlPbtQ9G5Lbjw7F56CqkwjWnTdafUCdwc8+Ex0=;
 b=LuJppmoPXeQGyrw4FqVt3u9+U6plMNq8N02BdYIb36A2PntTvpV47IKNj1EoDjZ6Tsap+wv765/CaE+qWbbkWP+KMvANYJ0BXj3Zi0ese9wyqlJvupwpkUM3cOWOYm15eEMqXolK1vxxCrJ6HtkQZjQOggXIAokJa/0MUrQDhZRa+rTW6rhSEvifWysB7k3QzK3OBllX+vCj4KIE005yUg6XHNCOORsTfFxHKR+4vZbGW60EPJPq+FJaplpkzFmIkqb11V1Jztn0CjGQ4tSisLClXxWX4FUjEiowj9whwYWQdntztAyPbAf2/v2vk92m5SKK8cWVAuXSPcpduJrYtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=manifault.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D3fOzSlPbtQ9G5Lbjw7F56CqkwjWnTdafUCdwc8+Ex0=;
 b=WKf6naKNR4/YNVrxQQcNHWz9hngxvytOSBvnUO4wAkMLok76t6hxyF/YqgEkvPvzBYH+xkJt3QaBnV7elLy7mEa3HTgMCjJBxmkh/bOPTVzKnlwyN9kCu4fia2IrwKZYj9Owc6hhv3KsPR5BvfKPQmCCbytr+tHdi5WGyyRUPTA=
Received: from SA9P221CA0016.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::21)
 by SJ2PR12MB7920.namprd12.prod.outlook.com (2603:10b6:a03:4c6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.21; Thu, 31 Aug
 2023 10:46:23 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10b6:806:25:cafe::c1) by SA9P221CA0016.outlook.office365.com
 (2603:10b6:806:25::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.22 via Frontend
 Transport; Thu, 31 Aug 2023 10:46:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Thu, 31 Aug 2023 10:46:22 +0000
Received: from BLR5CG134614W.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 31 Aug
 2023 05:46:16 -0500
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
Subject: [RFC PATCH 3/3] sched/fair: Add a per-shard overload flag
Date:   Thu, 31 Aug 2023 16:15:08 +0530
Message-ID: <20230831104508.7619-4-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|SJ2PR12MB7920:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fe56222-ee3f-464e-5872-08dbaa0f84af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GOFkzdm//JE8Vc3vXMV91uLMpXNvcOCqti3w+O6iGqmGOKv1B9RRBBwe4Q3GxBpqLA9SXhcAZ9OP/vtuR0MYzJ1oFzsKCxzxCwxx5BoavxH20dkEZKdlg/0NwJp2+a4z10W+klLYyer+s7tWa5U0GhDC13deCrdKeLMAHtX1hgi34qJZqg98W3GpDDY6Haig7NEeFoRX2SfscPJiAmMsix0weH7ufQUGc7w+8TFK7kCJYCZ4A4YJ5dh+wdDsB98883lVe61e6V7YTcwA8TeePjn591xqm/SBhQLGoN2LNfj7kp1vyCL+hrPy6lX5fM4l2MxF+IMZimHwPxNeBsFQ6LNAFKPlDjPF14Zynrfez3tIinU+U+YFSUDvR1omqQvhmKAaFIGGnlbV0lOkwZleZ1ad1dA/eUsenVIyebQczcF2iEAoVwU/PvgWQFPqpCt0JRBxuKzRfmycQkRgElgc31YrhJdz3VACIy0F/sEh6H1A2tY7+4i9pCC9l0VqO9kGgGhkQWEtMsWOLpUsQtf6Z6aNyhcxHN/t2TmrHO+SKRamkQk6m1p7WDkfOngfs8s+Q57GqMrwPI2KW2Y0SxVVQQ0YbTR0ucFjyvZso9Etjjr6i3Yfz5a65ZOz4KmuVYQ6+5e5VoDhuQpRjBccY5+ty2Rg+S5l1jsYt04AKbimKEYpUDxtcDjZXeDuvzPmYzjWaQwZKoyKv7nxZJYVfu46Y3Nf5E4i7GTluk5lnLePSrMR5GuwytACUFhOPg1DIrhKEXm8lB3L3qTPqr+77xqORw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(136003)(346002)(396003)(451199024)(82310400011)(186009)(1800799009)(40470700004)(36840700001)(46966006)(4326008)(8936002)(8676002)(5660300002)(316002)(6916009)(36756003)(54906003)(2906002)(70206006)(70586007)(7416002)(41300700001)(40460700003)(7696005)(36860700001)(16526019)(336012)(26005)(426003)(1076003)(40480700001)(81166007)(82740400003)(6666004)(356005)(478600001)(2616005)(47076005)(83380400001)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 10:46:22.9747
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fe56222-ee3f-464e-5872-08dbaa0f84af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7920
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even with the two patches, I still observe the following lock
contention when profiling the tbench 128-clients run with IBS:

  -   12.61%  swapper          [kernel.vmlinux]         [k] native_queued_spin_lock_slowpath
     - 10.94% native_queued_spin_lock_slowpath
        - 10.73% _raw_spin_lock
           - 9.57% __schedule
                schedule_idle
                do_idle
              + cpu_startup_entry
           - 0.82% task_rq_lock
                newidle_balance
                pick_next_task_fair
                __schedule
                schedule_idle
                do_idle
              + cpu_startup_entry

Since David mentioned rq->avg_idle check is probably not the right step
towards the solution, this experiment introduces a per-shard
"overload" flag. Similar to "rq->rd->overload", per-shard overload flag
notifies of the possibility of one or more rq covered in the shard's
domain having a queued task. shard's overload flag is set at the same
time as "rq->rd->overload", and is cleared when shard's list is found
to be empty.

With these changes, following are the results for tbench 128-clients:

tip				: 1.00 (var: 1.00%)
tip + v3 + series till patch 2	: 0.41 (var: 1.15%) (diff: -58.81%)
tip + v3 + full series		: 1.01 (var: 0.36%) (diff: +00.92%)

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 kernel/sched/fair.c  | 13 +++++++++++--
 kernel/sched/sched.h | 17 +++++++++++++++++
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 446ffdad49e1..31fe109fdaf0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -186,6 +186,7 @@ static void shared_runq_reassign_domains(void)
 		rq->cfs.shared_runq = shared_runq;
 		rq->cfs.shard = &shared_runq->shards[shard_idx];
 		rq_unlock(rq, &rf);
+		WRITE_ONCE(rq->cfs.shard->overload, 0);
 	}
 }
 
@@ -202,6 +203,7 @@ static void __shared_runq_drain(struct shared_runq *shared_runq)
 		list_for_each_entry_safe(p, tmp, &shard->list, shared_runq_node)
 			list_del_init(&p->shared_runq_node);
 		raw_spin_unlock(&shard->lock);
+		WRITE_ONCE(shard->overload, 0);
 	}
 }
 
@@ -258,13 +260,20 @@ shared_runq_pop_task(struct shared_runq_shard *shard, int target)
 {
 	struct task_struct *p;
 
-	if (list_empty(&shard->list))
+	if (!READ_ONCE(shard->overload))
 		return NULL;
 
+	if (list_empty(&shard->list)) {
+		WRITE_ONCE(shard->overload, 0);
+		return NULL;
+	}
+
 	raw_spin_lock(&shard->lock);
 	p = list_first_entry_or_null(&shard->list, struct task_struct,
 				     shared_runq_node);
-	if (p && is_cpu_allowed(p, target))
+	if (!p)
+		WRITE_ONCE(shard->overload, 0);
+	else if (is_cpu_allowed(p, target))
 		list_del_init(&p->shared_runq_node);
 	else
 		p = NULL;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index f50176f720b1..e8d4d948f742 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -601,6 +601,20 @@ do {									\
 struct shared_runq_shard {
 	struct list_head list;
 	raw_spinlock_t lock;
+	/*
+	 * shared_runq_shard can contain running tasks.
+	 * In such cases where all the tasks are running,
+	 * it is futile to attempt to pull tasks from the
+	 * list. Overload flag is used to indicate case
+	 * where one or more rq in the shard domain may
+	 * have a queued task. If the flag is 0, it is
+	 * very likely that all tasks in the shard are
+	 * running and cannot be migrated. This is not
+	 * guarded by the shard lock, and since it may
+	 * be updated often, it is placed into its own
+	 * cacheline.
+	 */
+	int overload ____cacheline_aligned;
 } ____cacheline_aligned;
 
 /* This would likely work better as a configurable knob via debugfs */
@@ -2585,6 +2599,9 @@ static inline void add_nr_running(struct rq *rq, unsigned count)
 	if (prev_nr < 2 && rq->nr_running >= 2) {
 		if (!READ_ONCE(rq->rd->overload))
 			WRITE_ONCE(rq->rd->overload, 1);
+
+		if (rq->cfs.shard && !READ_ONCE(rq->cfs.shard->overload))
+			WRITE_ONCE(rq->cfs.shard->overload, 1);
 	}
 #endif
 
-- 
2.34.1

