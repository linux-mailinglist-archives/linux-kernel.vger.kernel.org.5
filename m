Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B360A7ED94F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 03:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344510AbjKPCYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 21:24:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344508AbjKPCYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 21:24:23 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37833127
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 18:24:20 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5b02ed0f886so4228327b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 18:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700101459; x=1700706259; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LSZ+R0SqSzDzKoZBVcJ1mA+eTEuDRTwjKPgQcB0rBEk=;
        b=q4zPeLVMeDHerqDEMZdDflEzHOPf/yZKpaMP3vGbaXuLxaFWDQeWWH5Msi1f8ZcSNh
         Kd6yt7kxCfLz3DAMSs9GbuS+PPURtCRhzd0G1rEO7NxdVLo2BYAdggAb+cjpHlGgIalr
         eNpeySySiBDX8NJNPukGPTNH1Hwo8NElCEP5QrmppOw/ioThNXaP+t5Lua8/OSHigG3W
         LQcr7gCgMxxfrujvHut78PkGubayrDNRgU4aIfu0Zr492mUkRCn7EWMHDW1d1qn132xg
         v/l9oquV/EkrVUx/DUtFc2l92iF1oPfU0PrIM5SYeVfaK2Z8sMncG6Ptx6Im3/NkPccC
         M6jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700101459; x=1700706259;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LSZ+R0SqSzDzKoZBVcJ1mA+eTEuDRTwjKPgQcB0rBEk=;
        b=mhXGP/YYmasiMJ3RNqOT8FXuCKmH4qMZb7DSPNnwwn4G5mijg/s6waVuhKoOy1fZsK
         CGoSR8mF6rmlfMu8RpsxXQwrRzvDJoF9F5juvwqzbOuRNv26oiHQSYjOA0S9CbcO3QR+
         YwS+67UFuR2ht9fjAGsqkuVWNbc8ySi4t0nSuFQOcQaqxfgOEgKxCQjhM2qc74e/fDZI
         he8xGpOdq5wzFi0/LYcMY2LDzcj9r8QdOt4tMTHSeZxbFNQpNvXR9f1uRWq5Eni8Q5bB
         t5jxrA53+QuE6Q6/so6mCJgg2MdP2XTrGU8iiC3ozf/hJOD5xP1QrY+m287OQPDQMsSy
         2B4Q==
X-Gm-Message-State: AOJu0Yxz2nrFQRI2EV+h0Zry+XB7/HqW5p/Ugbk+SMs/vNweOIIeZvyA
        pXD+pZOSNE8hWg5qDgturbIOz4uhbQE6HL5Z
X-Google-Smtp-Source: AGHT+IEFkRjPRA+t8bnXs4r4alzEC6UzKUxHSRyn9fc3Cf7ttKBPYuT2Hd+c68LlEN9cCFYG3gXViVMxsm4UDLTD
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a81:4f90:0:b0:5a7:b543:7f0c with SMTP
 id d138-20020a814f90000000b005a7b5437f0cmr404902ywb.10.1700101459465; Wed, 15
 Nov 2023 18:24:19 -0800 (PST)
Date:   Thu, 16 Nov 2023 02:24:08 +0000
In-Reply-To: <20231116022411.2250072-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20231116022411.2250072-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
Message-ID: <20231116022411.2250072-4-yosryahmed@google.com>
Subject: [PATCH v3 3/5] mm: memcg: make stats flushing threshold per-memcg
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>,
        Waiman Long <longman@redhat.com>, kernel-team@cloudflare.com,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A global counter for the magnitude of memcg stats update is maintained
on the memcg side to avoid invoking rstat flushes when the pending
updates are not significant. This avoids unnecessary flushes, which are
not very cheap even if there isn't a lot of stats to flush. It also
avoids unnecessary lock contention on the underlying global rstat lock.

Make this threshold per-memcg. The scheme is followed where percpu (now
also per-memcg) counters are incremented in the update path, and only
propagated to per-memcg atomics when they exceed a certain threshold.

This provides two benefits:
(a) On large machines with a lot of memcgs, the global threshold can be
reached relatively fast, so guarding the underlying lock becomes less
effective. Making the threshold per-memcg avoids this.

(b) Having a global threshold makes it hard to do subtree flushes, as we
cannot reset the global counter except for a full flush. Per-memcg
counters removes this as a blocker from doing subtree flushes, which
helps avoid unnecessary work when the stats of a small subtree are
needed.

Nothing is free, of course. This comes at a cost:
(a) A new per-cpu counter per memcg, consuming NR_CPUS * NR_MEMCGS * 4
bytes. The extra memory usage is insigificant.

(b) More work on the update side, although in the common case it will
only be percpu counter updates. The amount of work scales with the
number of ancestors (i.e. tree depth). This is not a new concept, adding
a cgroup to the rstat tree involves a parent loop, so is charging.
Testing results below show no significant regressions.

(c) The error margin in the stats for the system as a whole increases
from NR_CPUS * MEMCG_CHARGE_BATCH to NR_CPUS * MEMCG_CHARGE_BATCH *
NR_MEMCGS. This is probably fine because we have a similar per-memcg
error in charges coming from percpu stocks, and we have a periodic
flusher that makes sure we always flush all the stats every 2s anyway.

This patch was tested to make sure no significant regressions are
introduced on the update path as follows. The following benchmarks were
ran in a cgroup that is 2 levels deep (/sys/fs/cgroup/a/b/):

(1) Running 22 instances of netperf on a 44 cpu machine with
hyperthreading disabled. All instances are run in a level 2 cgroup, as
well as netserver:
  # netserver -6
  # netperf -6 -H ::1 -l 60 -t TCP_SENDFILE -- -m 10K

Averaging 20 runs, the numbers are as follows:
Base: 40198.0 mbps
Patched: 38629.7 mbps (-3.9%)

The regression is minimal, especially for 22 instances in the same
cgroup sharing all ancestors (so updating the same atomics).

(2) will-it-scale page_fault tests. These tests (specifically
per_process_ops in page_fault3 test) detected a 25.9% regression before
for a change in the stats update path [1]. These are the
numbers from 10 runs (+ is good) on a machine with 256 cpus:

             LABEL            |     MEAN    |   MEDIAN    |   STDDEV   |
------------------------------+-------------+-------------+-------------
  page_fault1_per_process_ops |             |             |            |
  (A) base                    | 270249.164  | 265437.000  | 13451.836  |
  (B) patched                 | 261368.709  | 255725.000  | 13394.767  |
                              | -3.29%      | -3.66%      |            |
  page_fault1_per_thread_ops  |             |             |            |
  (A) base                    | 242111.345  | 239737.000  | 10026.031  |
  (B) patched                 | 237057.109  | 235305.000  | 9769.687   |
                              | -2.09%      | -1.85%      |            |
  page_fault1_scalability     |             |             |
  (A) base                    | 0.034387    | 0.035168    | 0.0018283  |
  (B) patched                 | 0.033988    | 0.034573    | 0.0018056  |
                              | -1.16%      | -1.69%      |            |
  page_fault2_per_process_ops |             |             |
  (A) base                    | 203561.836  | 203301.000  | 2550.764   |
  (B) patched                 | 197195.945  | 197746.000  | 2264.263   |
                              | -3.13%      | -2.73%      |            |
  page_fault2_per_thread_ops  |             |             |
  (A) base                    | 171046.473  | 170776.000  | 1509.679   |
  (B) patched                 | 166626.327  | 166406.000  | 768.753    |
                              | -2.58%      | -2.56%      |            |
  page_fault2_scalability     |             |             |
  (A) base                    | 0.054026    | 0.053821    | 0.00062121 |
  (B) patched                 | 0.053329    | 0.05306     | 0.00048394 |
                              | -1.29%      | -1.41%      |            |
  page_fault3_per_process_ops |             |             |
  (A) base                    | 1295807.782 | 1297550.000 | 5907.585   |
  (B) patched                 | 1275579.873 | 1273359.000 | 8759.160   |
                              | -1.56%      | -1.86%      |            |
  page_fault3_per_thread_ops  |             |             |
  (A) base                    | 391234.164  | 390860.000  | 1760.720   |
  (B) patched                 | 377231.273  | 376369.000  | 1874.971   |
                              | -3.58%      | -3.71%      |            |
  page_fault3_scalability     |             |             |
  (A) base                    | 0.60369     | 0.60072     | 0.0083029  |
  (B) patched                 | 0.61733     | 0.61544     | 0.009855   |
                              | +2.26%      | +2.45%      |            |

All regressions seem to be minimal, and within the normal variance for
the benchmark. The fix for [1] assumes that 3% is noise -- and there
were no further practical complaints), so hopefully this means that such
variations in these microbenchmarks do not reflect on practical
workloads.

(3) I also ran stress-ng in a nested cgroup and did not observe any
obvious regressions.

[1]https://lore.kernel.org/all/20190520063534.GB19312@shao2-debian/

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
Tested-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
---
 mm/memcontrol.c | 50 +++++++++++++++++++++++++++++++++----------------
 1 file changed, 34 insertions(+), 16 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 5ae2a8f04be45..74db05237775d 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -630,6 +630,9 @@ struct memcg_vmstats_percpu {
 	/* Cgroup1: threshold notifications & softlimit tree updates */
 	unsigned long		nr_page_events;
 	unsigned long		targets[MEM_CGROUP_NTARGETS];
+
+	/* Stats updates since the last flush */
+	unsigned int		stats_updates;
 };
 
 struct memcg_vmstats {
@@ -644,6 +647,9 @@ struct memcg_vmstats {
 	/* Pending child counts during tree propagation */
 	long			state_pending[MEMCG_NR_STAT];
 	unsigned long		events_pending[NR_MEMCG_EVENTS];
+
+	/* Stats updates since the last flush */
+	atomic64_t		stats_updates;
 };
 
 /*
@@ -663,9 +669,7 @@ struct memcg_vmstats {
  */
 static void flush_memcg_stats_dwork(struct work_struct *w);
 static DECLARE_DEFERRABLE_WORK(stats_flush_dwork, flush_memcg_stats_dwork);
-static DEFINE_PER_CPU(unsigned int, stats_updates);
 static atomic_t stats_flush_ongoing = ATOMIC_INIT(0);
-static atomic_t stats_flush_threshold = ATOMIC_INIT(0);
 static u64 flush_last_time;
 
 #define FLUSH_TIME (2UL*HZ)
@@ -692,26 +696,37 @@ static void memcg_stats_unlock(void)
 	preempt_enable_nested();
 }
 
+
+static bool memcg_should_flush_stats(struct mem_cgroup *memcg)
+{
+	return atomic64_read(&memcg->vmstats->stats_updates) >
+		MEMCG_CHARGE_BATCH * num_online_cpus();
+}
+
 static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
 {
+	int cpu = smp_processor_id();
 	unsigned int x;
 
 	if (!val)
 		return;
 
-	cgroup_rstat_updated(memcg->css.cgroup, smp_processor_id());
+	cgroup_rstat_updated(memcg->css.cgroup, cpu);
+
+	for (; memcg; memcg = parent_mem_cgroup(memcg)) {
+		x = __this_cpu_add_return(memcg->vmstats_percpu->stats_updates,
+					  abs(val));
+
+		if (x < MEMCG_CHARGE_BATCH)
+			continue;
 
-	x = __this_cpu_add_return(stats_updates, abs(val));
-	if (x > MEMCG_CHARGE_BATCH) {
 		/*
-		 * If stats_flush_threshold exceeds the threshold
-		 * (>num_online_cpus()), cgroup stats update will be triggered
-		 * in __mem_cgroup_flush_stats(). Increasing this var further
-		 * is redundant and simply adds overhead in atomic update.
+		 * If @memcg is already flush-able, increasing stats_updates is
+		 * redundant. Avoid the overhead of the atomic update.
 		 */
-		if (atomic_read(&stats_flush_threshold) <= num_online_cpus())
-			atomic_add(x / MEMCG_CHARGE_BATCH, &stats_flush_threshold);
-		__this_cpu_write(stats_updates, 0);
+		if (!memcg_should_flush_stats(memcg))
+			atomic64_add(x, &memcg->vmstats->stats_updates);
+		__this_cpu_write(memcg->vmstats_percpu->stats_updates, 0);
 	}
 }
 
@@ -730,13 +745,12 @@ static void do_flush_stats(void)
 
 	cgroup_rstat_flush(root_mem_cgroup->css.cgroup);
 
-	atomic_set(&stats_flush_threshold, 0);
 	atomic_set(&stats_flush_ongoing, 0);
 }
 
 void mem_cgroup_flush_stats(void)
 {
-	if (atomic_read(&stats_flush_threshold) > num_online_cpus())
+	if (memcg_should_flush_stats(root_mem_cgroup))
 		do_flush_stats();
 }
 
@@ -750,8 +764,8 @@ void mem_cgroup_flush_stats_ratelimited(void)
 static void flush_memcg_stats_dwork(struct work_struct *w)
 {
 	/*
-	 * Always flush here so that flushing in latency-sensitive paths is
-	 * as cheap as possible.
+	 * Deliberately ignore memcg_should_flush_stats() here so that flushing
+	 * in latency-sensitive paths is as cheap as possible.
 	 */
 	do_flush_stats();
 	queue_delayed_work(system_unbound_wq, &stats_flush_dwork, FLUSH_TIME);
@@ -5784,6 +5798,10 @@ static void mem_cgroup_css_rstat_flush(struct cgroup_subsys_state *css, int cpu)
 			}
 		}
 	}
+	statc->stats_updates = 0;
+	/* We are in a per-cpu loop here, only do the atomic write once */
+	if (atomic64_read(&memcg->vmstats->stats_updates))
+		atomic64_set(&memcg->vmstats->stats_updates, 0);
 }
 
 #ifdef CONFIG_MMU
-- 
2.43.0.rc0.421.g78406f8d94-goog

