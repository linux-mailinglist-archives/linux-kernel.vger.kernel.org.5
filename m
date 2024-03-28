Return-Path: <linux-kernel+bounces-122860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6CF488FE86
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9C4D1C22724
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 12:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8143C7F7C6;
	Thu, 28 Mar 2024 12:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T730x2aY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n2TiKzFW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E124E7EEEA;
	Thu, 28 Mar 2024 12:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711627281; cv=none; b=RRvFRbRFd3cDuDXqniq4mwMcsYBqJ6B6FUdEncfCYW8lGA+H8vgPHIbnQpt+0Y7h1VFHaAZTkZwpEb7XDtTzeosJV6OeFfYMD+vlCmtxFGT3Bi0YLSaHqkPLBjdo3Dzz4EeWNaoFNzRXulccqHD2djlHYH6kWeJPtkhYfSFIOmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711627281; c=relaxed/simple;
	bh=FXPWLt4hKUD+8+VEdZhRa5zZ67IOmtoy6oB063PboCA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=amIulIa4rxelX5woBrGK/br8JJXaJgiUNdZmDsCjhggc3dfL1bMNodNnxaH52YCLz7LKednnqK3sjWzFmcHI/1wbnJBdjiJwUghDU3rmwxnaWHA52Al0WJF1btWFJZlMhsH/jX4Zffvub+aFHF6HxLLnCfR4itVUuhH9GIKwHX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T730x2aY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n2TiKzFW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 28 Mar 2024 12:01:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711627269;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P5H0cL2UtrzxQxpNNxHNrH63E3tDXQ6DFxE+gF/LZR4=;
	b=T730x2aY+NF/M/fJaC0vkk3YpuwN2ap7dclRMxBwUJCSRL/39Eu206NC3znPzKmxES4n+0
	YMcOb367i1ECeg9MMVga4cew+fDzEdRWD8t3yBas0s4XHRCzoJqT3ckZM3c8EHMu4A2Xdj
	u0fQ6sqIcdgY9CaVYGJjEYXcSKKtrRILw3jvqMpyk0EOXbMMJOQXKKm5Vz6e9XKKaPBXbi
	ab9aZPlrR4l+0p3XMLCDEmHCocRYwHBd97ymklQJQSfoFOiS3KD12ySBErmJ2/pNM7T0oy
	E7Z2S2KC+OxCQgSYiYqpv/vnGFM7XuS3I3tSGR3yZTI/SSxptRWKV9jifYD/Rw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711627269;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P5H0cL2UtrzxQxpNNxHNrH63E3tDXQ6DFxE+gF/LZR4=;
	b=n2TiKzFWfdloIQpvkQHqhJpzdcS3GTvOHfc63r7pYaygrbAPtor/326Vu2UC93zHwDlhAm
	snREpQHFJipWMZCw==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/balancing: Simplify the sg_status bitmask and
 use separate sg_overloaded and sg_overutilized flags
Cc: Ingo Molnar <mingo@kernel.org>, Qais Yousef <qyousef@layalina.io>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <nbsqbP@gmail.com>
References: <nbsqbP@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171162726794.10875.4732465085064226072.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     f322c65c648eac74cf1f13691a562a0738aa9e35
Gitweb:        https://git.kernel.org/tip/f322c65c648eac74cf1f13691a562a0738aa9e35
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Thu, 28 Mar 2024 12:00:14 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 28 Mar 2024 12:17:53 +01:00

sched/balancing: Simplify the sg_status bitmask and use separate sg_overloaded and sg_overutilized flags

SG_OVERLOADED and SG_OVERUTILIZED flags plus the sg_status bitmask are an
unnecessary complication that only make the code harder to read and slower.

We only ever set them separately:

 thule:~/tip> git grep SG_OVER kernel/sched/
 kernel/sched/fair.c:            set_rd_overutilized_status(rq->rd, SG_OVERUTILIZED);
 kernel/sched/fair.c:                    *sg_status |= SG_OVERLOADED;
 kernel/sched/fair.c:                    *sg_status |= SG_OVERUTILIZED;
 kernel/sched/fair.c:                            *sg_status |= SG_OVERLOADED;
 kernel/sched/fair.c:            set_rd_overloaded(env->dst_rq->rd, sg_status & SG_OVERLOADED);
 kernel/sched/fair.c:                                       sg_status & SG_OVERUTILIZED);
 kernel/sched/fair.c:    } else if (sg_status & SG_OVERUTILIZED) {
 kernel/sched/fair.c:            set_rd_overutilized_status(env->dst_rq->rd, SG_OVERUTILIZED);
 kernel/sched/sched.h:#define SG_OVERLOADED              0x1 /* More than one runnable task on a CPU. */
 kernel/sched/sched.h:#define SG_OVERUTILIZED            0x2 /* One or more CPUs are over-utilized. */
 kernel/sched/sched.h:           set_rd_overloaded(rq->rd, SG_OVERLOADED);

And use them separately, which results in suboptimal code:

                /* update overload indicator if we are at root domain */
                set_rd_overloaded(env->dst_rq->rd, sg_status & SG_OVERLOADED);

                /* Update over-utilization (tipping point, U >= 0) indicator */
                set_rd_overutilized_status(env->dst_rq->rd,

Introduce separate sg_overloaded and sg_overutilized flags in update_sd_lb_stats()
and its lower level functions, and change all of them to 'bool'.

Remove the now unused SG_OVERLOADED and SG_OVERUTILIZED flags.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Qais Yousef <qyousef@layalina.io>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/ZgVPhODZ8/nbsqbP@gmail.com
---
 kernel/sched/fair.c  | 33 ++++++++++++++++-----------------
 kernel/sched/sched.h | 17 ++++++-----------
 2 files changed, 22 insertions(+), 28 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f29efd5..ebc8d5f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6688,19 +6688,18 @@ static inline bool cpu_overutilized(int cpu)
 /*
  * overutilized value make sense only if EAS is enabled
  */
-static inline int is_rd_overutilized(struct root_domain *rd)
+static inline bool is_rd_overutilized(struct root_domain *rd)
 {
 	return !sched_energy_enabled() || READ_ONCE(rd->overutilized);
 }
 
-static inline void set_rd_overutilized(struct root_domain *rd,
-					      unsigned int status)
+static inline void set_rd_overutilized(struct root_domain *rd, bool flag)
 {
 	if (!sched_energy_enabled())
 		return;
 
-	WRITE_ONCE(rd->overutilized, status);
-	trace_sched_overutilized_tp(rd, !!status);
+	WRITE_ONCE(rd->overutilized, flag);
+	trace_sched_overutilized_tp(rd, flag);
 }
 
 static inline void check_update_overutilized_status(struct rq *rq)
@@ -6711,7 +6710,7 @@ static inline void check_update_overutilized_status(struct rq *rq)
 	 */
 
 	if (!is_rd_overutilized(rq->rd) && cpu_overutilized(rq->cpu))
-		set_rd_overutilized(rq->rd, SG_OVERUTILIZED);
+		set_rd_overutilized(rq->rd, 1);
 }
 #else
 static inline void check_update_overutilized_status(struct rq *rq) { }
@@ -9940,7 +9939,8 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 				      struct sd_lb_stats *sds,
 				      struct sched_group *group,
 				      struct sg_lb_stats *sgs,
-				      int *sg_status)
+				      bool *sg_overloaded,
+				      bool *sg_overutilized)
 {
 	int i, nr_running, local_group;
 
@@ -9961,10 +9961,10 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 		sgs->sum_nr_running += nr_running;
 
 		if (nr_running > 1)
-			*sg_status |= SG_OVERLOADED;
+			*sg_overloaded = 1;
 
 		if (cpu_overutilized(i))
-			*sg_status |= SG_OVERUTILIZED;
+			*sg_overutilized = 1;
 
 #ifdef CONFIG_NUMA_BALANCING
 		sgs->nr_numa_running += rq->nr_numa_running;
@@ -9986,7 +9986,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 			/* Check for a misfit task on the cpu */
 			if (sgs->group_misfit_task_load < rq->misfit_task_load) {
 				sgs->group_misfit_task_load = rq->misfit_task_load;
-				*sg_status |= SG_OVERLOADED;
+				*sg_overloaded = 1;
 			}
 		} else if (env->idle && sched_reduced_capacity(rq, env->sd)) {
 			/* Check for a task running on a CPU with reduced capacity */
@@ -10612,7 +10612,7 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 	struct sg_lb_stats *local = &sds->local_stat;
 	struct sg_lb_stats tmp_sgs;
 	unsigned long sum_util = 0;
-	int sg_status = 0;
+	bool sg_overloaded = 0, sg_overutilized = 0;
 
 	do {
 		struct sg_lb_stats *sgs = &tmp_sgs;
@@ -10628,7 +10628,7 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 				update_group_capacity(env->sd, env->dst_cpu);
 		}
 
-		update_sg_lb_stats(env, sds, sg, sgs, &sg_status);
+		update_sg_lb_stats(env, sds, sg, sgs, &sg_overloaded, &sg_overutilized);
 
 		if (!local_group && update_sd_pick_busiest(env, sds, sg, sgs)) {
 			sds->busiest = sg;
@@ -10657,13 +10657,12 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 
 	if (!env->sd->parent) {
 		/* update overload indicator if we are at root domain */
-		set_rd_overloaded(env->dst_rq->rd, sg_status & SG_OVERLOADED);
+		set_rd_overloaded(env->dst_rq->rd, sg_overloaded);
 
 		/* Update over-utilization (tipping point, U >= 0) indicator */
-		set_rd_overutilized(env->dst_rq->rd,
-					   sg_status & SG_OVERUTILIZED);
-	} else if (sg_status & SG_OVERUTILIZED) {
-		set_rd_overutilized(env->dst_rq->rd, SG_OVERUTILIZED);
+		set_rd_overutilized(env->dst_rq->rd, sg_overloaded);
+	} else if (sg_overutilized) {
+		set_rd_overutilized(env->dst_rq->rd, sg_overutilized);
 	}
 
 	update_idle_cpu_scan(env, sum_util);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 07c6669..7c39dbf 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -713,7 +713,7 @@ struct rt_rq {
 	} highest_prio;
 #endif
 #ifdef CONFIG_SMP
-	int			overloaded;
+	bool			overloaded;
 	struct plist_head	pushable_tasks;
 
 #endif /* CONFIG_SMP */
@@ -757,7 +757,7 @@ struct dl_rq {
 		u64		next;
 	} earliest_dl;
 
-	int			overloaded;
+	bool			overloaded;
 
 	/*
 	 * Tasks on this rq that can be pushed away. They are kept in
@@ -850,10 +850,6 @@ struct perf_domain {
 	struct rcu_head rcu;
 };
 
-/* Scheduling group status flags */
-#define SG_OVERLOADED		0x1 /* More than one runnable task on a CPU. */
-#define SG_OVERUTILIZED		0x2 /* One or more CPUs are over-utilized. */
-
 /*
  * We add the notion of a root-domain which will be used to define per-domain
  * variables. Each exclusive cpuset essentially defines an island domain by
@@ -874,10 +870,10 @@ struct root_domain {
 	 * - More than one runnable task
 	 * - Running task is misfit
 	 */
-	int			overloaded;
+	bool			overloaded;
 
 	/* Indicate one or more cpus over-utilized (tipping point) */
-	int			overutilized;
+	bool			overutilized;
 
 	/*
 	 * The bit corresponding to a CPU gets set here if such CPU has more
@@ -2540,9 +2536,8 @@ static inline void add_nr_running(struct rq *rq, unsigned count)
 	}
 
 #ifdef CONFIG_SMP
-	if (prev_nr < 2 && rq->nr_running >= 2) {
-		set_rd_overloaded(rq->rd, SG_OVERLOADED);
-	}
+	if (prev_nr < 2 && rq->nr_running >= 2)
+		set_rd_overloaded(rq->rd, 1);
 #endif
 
 	sched_update_tick_dependency(rq);

