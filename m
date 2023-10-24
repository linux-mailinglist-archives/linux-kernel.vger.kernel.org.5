Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1913C7D4AF5
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 10:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233972AbjJXIwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 04:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233939AbjJXIwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 04:52:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864C0D7B;
        Tue, 24 Oct 2023 01:52:27 -0700 (PDT)
Date:   Tue, 24 Oct 2023 08:52:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698137545;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aYLSgSmfEX5h8g1Cbl2QcHxaZ5RLzEHT9cO/7p5eK40=;
        b=dqPk5plGFRfPN6j5SsqQ2dLpn9CstUX5V+BwlWsGlZftHcfZd9DWea06+YsU1kwSQKOopR
        wfQ4WR5G4Gi033by+kFDDh8GoqI+gK1EhrSImndhD67WV6dm5kDPr5/lqWLK0YjrBpbP2B
        rSknM388wB5k3cZAiGUb7b2NtzCrT5aRUZuXuGd/qOTomho/f68LY91TI8v0KtH/0liYMW
        sKwi/A7hpnRQ2B9lnAO6MiO+iSfeHKLJzq9RZGzi1yC39MGOs2okDWtRkhd0kKamRm84+F
        VhjP7bTwYAL0tCd0BoCM61dTEtYAQZQd+/53ioan/sevpCYrbWDqYloPIXoHRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698137545;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aYLSgSmfEX5h8g1Cbl2QcHxaZ5RLzEHT9cO/7p5eK40=;
        b=FAywwt2CHktB+tK0j79Tdakp8Lj6tZQlmXXwKdX95RZH4KSwL0ATbumMyFKWz6z3nqjLOe
        eFGtfjnFbikdMbAQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Remove SIS_PROP
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231020134337.GD33965@noisy.programming.kicks-ass.net>
References: <20231020134337.GD33965@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <169813754422.3135.6065400628387990388.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     984ffb6a4366752c949f7b39640aecdce222607f
Gitweb:        https://git.kernel.org/tip/984ffb6a4366752c949f7b39640aecdce222607f
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 20 Oct 2023 12:35:33 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 24 Oct 2023 10:38:44 +02:00

sched/fair: Remove SIS_PROP

SIS_UTIL seems to work well, lets remove the old thing.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lkml.kernel.org/r/20231020134337.GD33965@noisy.programming.kicks-ass.net
---
 include/linux/sched/topology.h |  2 +-
 kernel/sched/core.c            |  5 +---
 kernel/sched/fair.c            | 48 +---------------------------------
 kernel/sched/features.h        |  1 +-
 kernel/sched/sched.h           |  3 +--
 5 files changed, 59 deletions(-)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 4c14fe1..de545ba 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -109,8 +109,6 @@ struct sched_domain {
 	u64 max_newidle_lb_cost;
 	unsigned long last_decay_max_lb_cost;
 
-	u64 avg_scan_cost;		/* select_idle_sibling */
-
 #ifdef CONFIG_SCHEDSTATS
 	/* load_balance() stats */
 	unsigned int lb_count[CPU_MAX_IDLE_TYPES];
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5e1fb8a..7a0c161 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3792,9 +3792,6 @@ ttwu_do_activate(struct rq *rq, struct task_struct *p, int wake_flags,
 		if (rq->avg_idle > max)
 			rq->avg_idle = max;
 
-		rq->wake_stamp = jiffies;
-		rq->wake_avg_idle = rq->avg_idle / 2;
-
 		rq->idle_stamp = 0;
 	}
 #endif
@@ -9953,8 +9950,6 @@ void __init sched_init(void)
 		rq->online = 0;
 		rq->idle_stamp = 0;
 		rq->avg_idle = 2*sysctl_sched_migration_cost;
-		rq->wake_stamp = jiffies;
-		rq->wake_avg_idle = rq->avg_idle;
 		rq->max_idle_balance_cost = sysctl_sched_migration_cost;
 
 		INIT_LIST_HEAD(&rq->cfs_tasks);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 523b5ae..8767988 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7209,45 +7209,9 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool 
 	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_rq_mask);
 	int i, cpu, idle_cpu = -1, nr = INT_MAX;
 	struct sched_domain_shared *sd_share;
-	struct rq *this_rq = this_rq();
-	int this = smp_processor_id();
-	struct sched_domain *this_sd = NULL;
-	u64 time = 0;
 
 	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
 
-	if (sched_feat(SIS_PROP) && !has_idle_core) {
-		u64 avg_cost, avg_idle, span_avg;
-		unsigned long now = jiffies;
-
-		this_sd = rcu_dereference(*this_cpu_ptr(&sd_llc));
-		if (!this_sd)
-			return -1;
-
-		/*
-		 * If we're busy, the assumption that the last idle period
-		 * predicts the future is flawed; age away the remaining
-		 * predicted idle time.
-		 */
-		if (unlikely(this_rq->wake_stamp < now)) {
-			while (this_rq->wake_stamp < now && this_rq->wake_avg_idle) {
-				this_rq->wake_stamp++;
-				this_rq->wake_avg_idle >>= 1;
-			}
-		}
-
-		avg_idle = this_rq->wake_avg_idle;
-		avg_cost = this_sd->avg_scan_cost + 1;
-
-		span_avg = sd->span_weight * avg_idle;
-		if (span_avg > 4*avg_cost)
-			nr = div_u64(span_avg, avg_cost);
-		else
-			nr = 4;
-
-		time = cpu_clock(this);
-	}
-
 	if (sched_feat(SIS_UTIL)) {
 		sd_share = rcu_dereference(per_cpu(sd_llc_shared, target));
 		if (sd_share) {
@@ -7301,18 +7265,6 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool 
 	if (has_idle_core)
 		set_idle_cores(target, false);
 
-	if (sched_feat(SIS_PROP) && this_sd && !has_idle_core) {
-		time = cpu_clock(this) - time;
-
-		/*
-		 * Account for the scan cost of wakeups against the average
-		 * idle time.
-		 */
-		this_rq->wake_avg_idle -= min(this_rq->wake_avg_idle, time);
-
-		update_avg(&this_sd->avg_scan_cost, time);
-	}
-
 	return idle_cpu;
 }
 
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index f770168..a3ddf84 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -49,7 +49,6 @@ SCHED_FEAT(TTWU_QUEUE, true)
 /*
  * When doing wakeups, attempt to limit superfluous scans of the LLC domain.
  */
-SCHED_FEAT(SIS_PROP, false)
 SCHED_FEAT(SIS_UTIL, true)
 
 /*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index ef4fe7b..2e5a954 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1059,9 +1059,6 @@ struct rq {
 	u64			idle_stamp;
 	u64			avg_idle;
 
-	unsigned long		wake_stamp;
-	u64			wake_avg_idle;
-
 	/* This is used to determine avg_idle's max value */
 	u64			max_idle_balance_cost;
 
