Return-Path: <linux-kernel+bounces-23463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B95182AD29
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D908283384
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF7B154B6;
	Thu, 11 Jan 2024 11:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aoo04vf5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="K81EZiqd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E00154A7;
	Thu, 11 Jan 2024 11:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 11 Jan 2024 11:14:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1704971669;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YgWimBfCghmvTyej1VSylfdgr36MT18JiOhaIZ+vP9g=;
	b=aoo04vf5YQiEhfoKRfSHf1cStpanEZXiF4LSOT/E1/8Jv6iBnJgWnJgCBfRg8PzTOOauZG
	WSpvJU6/k/tcQIH5P8NeFQlDketRv6yDJZWzij+gulViqdqwRJv4O/czMQcZ+NHdD3qB4A
	9HnRNiz1+PjtjJ5d8PIeT/QC6EyTsNWTDA4Ixi3M7TLBr8hSDTH4pWgjcu6Axg4WMbMM8W
	UMJiQS/L9hev6z7c64MSTtxlkbflE+4yJNZgF1MawippJHcjlP65eHjGzbIWBKUxyVssAQ
	Cn/Wh3iOcjpKnkFYHGlKll+2yFJPUdHcCazTuIe60lCkJOym8iAuUQYgKD19Fw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1704971669;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YgWimBfCghmvTyej1VSylfdgr36MT18JiOhaIZ+vP9g=;
	b=K81EZiqd+fPowBHzEVvvhVnfAP54ONL3MX6uI4gZ1CLLNbbj6Bw7TgyXqDLYQPC88FW9Yq
	wMd+MyOhNLbBrKAw==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] Revert "sched/cpufreq: Rework schedutil governor
 performance estimation" and dependent commits
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Ingo Molnar <mingo@kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To:
 <CAHk-=wgWcYX2oXKtgvNN2LLDXP7kXkbo-xTfumEjmPbjSer2RQ@mail.gmail.com>
References:
 <CAHk-=wgWcYX2oXKtgvNN2LLDXP7kXkbo-xTfumEjmPbjSer2RQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170497166812.398.7952345082738260965.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     250ce3c1169743f3575cc5937fccd72380052795
Gitweb:        https://git.kernel.org/tip/250ce3c1169743f3575cc5937fccd72380052795
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Thu, 11 Jan 2024 11:45:17 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 11 Jan 2024 11:51:10 +01:00

Revert "sched/cpufreq: Rework schedutil governor performance estimation" and dependent commits

This reverts the following commits:

  b3edde44e5d450 ("cpufreq/schedutil: Use a fixed reference frequency")
  f12560779f9d73 ("sched/cpufreq: Rework iowait boost")
  9c0b4bb7f6303c ("sched/cpufreq: Rework schedutil governor performance estimation")

Because Linus reported a bad performance regression with the
sched_util governor, that increased the time his empty
kernel build took from 22 to 44 seconds (and can be similarly
measured in full builds as well) - and bisected it back to 9c0b4bb7f6303c.

Until we have a proper fix, revert the broken commit and its
dependent commits.

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Bisected-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/CAHk-=wgWcYX2oXKtgvNN2LLDXP7kXkbo-xTfumEjmPbjSer2RQ@mail.gmail.com
---
 include/linux/energy_model.h     |  1 +-
 kernel/sched/core.c              | 90 +++++++++++++++++--------------
 kernel/sched/cpufreq_schedutil.c | 90 +++++++++----------------------
 kernel/sched/fair.c              | 22 +-------
 kernel/sched/sched.h             | 84 ++++++++++++++++++++++++++---
 5 files changed, 160 insertions(+), 127 deletions(-)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index 88d91e0..c19e7ef 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -243,6 +243,7 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
 	scale_cpu = arch_scale_cpu_capacity(cpu);
 	ref_freq = arch_scale_freq_ref(cpu);
 
+	max_util = map_util_perf(max_util);
 	max_util = min(max_util, allowed_cpu_cap);
 	freq = map_util_freq(max_util, ref_freq, scale_cpu);
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index db4be49..2de77a6 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7467,13 +7467,18 @@ int sched_core_idle_cpu(int cpu)
  * required to meet deadlines.
  */
 unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
-				 unsigned long *min,
-				 unsigned long *max)
+				 enum cpu_util_type type,
+				 struct task_struct *p)
 {
-	unsigned long util, irq, scale;
+	unsigned long dl_util, util, irq, max;
 	struct rq *rq = cpu_rq(cpu);
 
-	scale = arch_scale_cpu_capacity(cpu);
+	max = arch_scale_cpu_capacity(cpu);
+
+	if (!uclamp_is_used() &&
+	    type == FREQUENCY_UTIL && rt_rq_is_runnable(&rq->rt)) {
+		return max;
+	}
 
 	/*
 	 * Early check to see if IRQ/steal time saturates the CPU, can be
@@ -7481,49 +7486,45 @@ unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
 	 * update_irq_load_avg().
 	 */
 	irq = cpu_util_irq(rq);
-	if (unlikely(irq >= scale)) {
-		if (min)
-			*min = scale;
-		if (max)
-			*max = scale;
-		return scale;
-	}
-
-	if (min) {
-		/*
-		 * The minimum utilization returns the highest level between:
-		 * - the computed DL bandwidth needed with the IRQ pressure which
-		 *   steals time to the deadline task.
-		 * - The minimum performance requirement for CFS and/or RT.
-		 */
-		*min = max(irq + cpu_bw_dl(rq), uclamp_rq_get(rq, UCLAMP_MIN));
-
-		/*
-		 * When an RT task is runnable and uclamp is not used, we must
-		 * ensure that the task will run at maximum compute capacity.
-		 */
-		if (!uclamp_is_used() && rt_rq_is_runnable(&rq->rt))
-			*min = max(*min, scale);
-	}
+	if (unlikely(irq >= max))
+		return max;
 
 	/*
 	 * Because the time spend on RT/DL tasks is visible as 'lost' time to
 	 * CFS tasks and we use the same metric to track the effective
 	 * utilization (PELT windows are synchronized) we can directly add them
 	 * to obtain the CPU's actual utilization.
+	 *
+	 * CFS and RT utilization can be boosted or capped, depending on
+	 * utilization clamp constraints requested by currently RUNNABLE
+	 * tasks.
+	 * When there are no CFS RUNNABLE tasks, clamps are released and
+	 * frequency will be gracefully reduced with the utilization decay.
 	 */
 	util = util_cfs + cpu_util_rt(rq);
-	util += cpu_util_dl(rq);
+	if (type == FREQUENCY_UTIL)
+		util = uclamp_rq_util_with(rq, util, p);
+
+	dl_util = cpu_util_dl(rq);
 
 	/*
-	 * The maximum hint is a soft bandwidth requirement, which can be lower
-	 * than the actual utilization because of uclamp_max requirements.
+	 * For frequency selection we do not make cpu_util_dl() a permanent part
+	 * of this sum because we want to use cpu_bw_dl() later on, but we need
+	 * to check if the CFS+RT+DL sum is saturated (ie. no idle time) such
+	 * that we select f_max when there is no idle time.
+	 *
+	 * NOTE: numerical errors or stop class might cause us to not quite hit
+	 * saturation when we should -- something for later.
 	 */
-	if (max)
-		*max = min(scale, uclamp_rq_get(rq, UCLAMP_MAX));
+	if (util + dl_util >= max)
+		return max;
 
-	if (util >= scale)
-		return scale;
+	/*
+	 * OTOH, for energy computation we need the estimated running time, so
+	 * include util_dl and ignore dl_bw.
+	 */
+	if (type == ENERGY_UTIL)
+		util += dl_util;
 
 	/*
 	 * There is still idle time; further improve the number by using the
@@ -7534,15 +7535,28 @@ unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
 	 *   U' = irq + --------- * U
 	 *                 max
 	 */
-	util = scale_irq_capacity(util, irq, scale);
+	util = scale_irq_capacity(util, irq, max);
 	util += irq;
 
-	return min(scale, util);
+	/*
+	 * Bandwidth required by DEADLINE must always be granted while, for
+	 * FAIR and RT, we use blocked utilization of IDLE CPUs as a mechanism
+	 * to gracefully reduce the frequency when no tasks show up for longer
+	 * periods of time.
+	 *
+	 * Ideally we would like to set bw_dl as min/guaranteed freq and util +
+	 * bw_dl as requested freq. However, cpufreq is not yet ready for such
+	 * an interface. So, we only do the latter for now.
+	 */
+	if (type == FREQUENCY_UTIL)
+		util += cpu_bw_dl(rq);
+
+	return min(max, util);
 }
 
 unsigned long sched_cpu_util(int cpu)
 {
-	return effective_cpu_util(cpu, cpu_util_cfs(cpu), NULL, NULL);
+	return effective_cpu_util(cpu, cpu_util_cfs(cpu), ENERGY_UTIL, NULL);
 }
 #endif /* CONFIG_SMP */
 
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 95c3c09..5888176 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -47,7 +47,7 @@ struct sugov_cpu {
 	u64			last_update;
 
 	unsigned long		util;
-	unsigned long		bw_min;
+	unsigned long		bw_dl;
 
 	/* The field below is for single-CPU policies only: */
 #ifdef CONFIG_NO_HZ_COMMON
@@ -115,28 +115,6 @@ static void sugov_deferred_update(struct sugov_policy *sg_policy)
 }
 
 /**
- * get_capacity_ref_freq - get the reference frequency that has been used to
- * correlate frequency and compute capacity for a given cpufreq policy. We use
- * the CPU managing it for the arch_scale_freq_ref() call in the function.
- * @policy: the cpufreq policy of the CPU in question.
- *
- * Return: the reference CPU frequency to compute a capacity.
- */
-static __always_inline
-unsigned long get_capacity_ref_freq(struct cpufreq_policy *policy)
-{
-	unsigned int freq = arch_scale_freq_ref(policy->cpu);
-
-	if (freq)
-		return freq;
-
-	if (arch_scale_freq_invariant())
-		return policy->cpuinfo.max_freq;
-
-	return policy->cur;
-}
-
-/**
  * get_next_freq - Compute a new frequency for a given cpufreq policy.
  * @sg_policy: schedutil policy object to compute the new frequency for.
  * @util: Current CPU utilization.
@@ -162,9 +140,10 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
 				  unsigned long util, unsigned long max)
 {
 	struct cpufreq_policy *policy = sg_policy->policy;
-	unsigned int freq;
+	unsigned int freq = arch_scale_freq_invariant() ?
+				policy->cpuinfo.max_freq : policy->cur;
 
-	freq = get_capacity_ref_freq(policy);
+	util = map_util_perf(util);
 	freq = map_util_freq(util, freq, max);
 
 	if (freq == sg_policy->cached_raw_freq && !sg_policy->need_freq_update)
@@ -174,31 +153,14 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
 	return cpufreq_driver_resolve_freq(policy, freq);
 }
 
-unsigned long sugov_effective_cpu_perf(int cpu, unsigned long actual,
-				 unsigned long min,
-				 unsigned long max)
-{
-	/* Add dvfs headroom to actual utilization */
-	actual = map_util_perf(actual);
-	/* Actually we don't need to target the max performance */
-	if (actual < max)
-		max = actual;
-
-	/*
-	 * Ensure at least minimum performance while providing more compute
-	 * capacity when possible.
-	 */
-	return max(min, max);
-}
-
-static void sugov_get_util(struct sugov_cpu *sg_cpu, unsigned long boost)
+static void sugov_get_util(struct sugov_cpu *sg_cpu)
 {
-	unsigned long min, max, util = cpu_util_cfs_boost(sg_cpu->cpu);
+	unsigned long util = cpu_util_cfs_boost(sg_cpu->cpu);
+	struct rq *rq = cpu_rq(sg_cpu->cpu);
 
-	util = effective_cpu_util(sg_cpu->cpu, util, &min, &max);
-	util = max(util, boost);
-	sg_cpu->bw_min = min;
-	sg_cpu->util = sugov_effective_cpu_perf(sg_cpu->cpu, util, min, max);
+	sg_cpu->bw_dl = cpu_bw_dl(rq);
+	sg_cpu->util = effective_cpu_util(sg_cpu->cpu, util,
+					  FREQUENCY_UTIL, NULL);
 }
 
 /**
@@ -289,16 +251,18 @@ static void sugov_iowait_boost(struct sugov_cpu *sg_cpu, u64 time,
  * This mechanism is designed to boost high frequently IO waiting tasks, while
  * being more conservative on tasks which does sporadic IO operations.
  */
-static unsigned long sugov_iowait_apply(struct sugov_cpu *sg_cpu, u64 time,
+static void sugov_iowait_apply(struct sugov_cpu *sg_cpu, u64 time,
 			       unsigned long max_cap)
 {
+	unsigned long boost;
+
 	/* No boost currently required */
 	if (!sg_cpu->iowait_boost)
-		return 0;
+		return;
 
 	/* Reset boost if the CPU appears to have been idle enough */
 	if (sugov_iowait_reset(sg_cpu, time, false))
-		return 0;
+		return;
 
 	if (!sg_cpu->iowait_boost_pending) {
 		/*
@@ -307,7 +271,7 @@ static unsigned long sugov_iowait_apply(struct sugov_cpu *sg_cpu, u64 time,
 		sg_cpu->iowait_boost >>= 1;
 		if (sg_cpu->iowait_boost < IOWAIT_BOOST_MIN) {
 			sg_cpu->iowait_boost = 0;
-			return 0;
+			return;
 		}
 	}
 
@@ -317,7 +281,10 @@ static unsigned long sugov_iowait_apply(struct sugov_cpu *sg_cpu, u64 time,
 	 * sg_cpu->util is already in capacity scale; convert iowait_boost
 	 * into the same scale so we can compare.
 	 */
-	return (sg_cpu->iowait_boost * max_cap) >> SCHED_CAPACITY_SHIFT;
+	boost = (sg_cpu->iowait_boost * max_cap) >> SCHED_CAPACITY_SHIFT;
+	boost = uclamp_rq_util_with(cpu_rq(sg_cpu->cpu), boost, NULL);
+	if (sg_cpu->util < boost)
+		sg_cpu->util = boost;
 }
 
 #ifdef CONFIG_NO_HZ_COMMON
@@ -339,7 +306,7 @@ static inline bool sugov_cpu_is_busy(struct sugov_cpu *sg_cpu) { return false; }
  */
 static inline void ignore_dl_rate_limit(struct sugov_cpu *sg_cpu)
 {
-	if (cpu_bw_dl(cpu_rq(sg_cpu->cpu)) > sg_cpu->bw_min)
+	if (cpu_bw_dl(cpu_rq(sg_cpu->cpu)) > sg_cpu->bw_dl)
 		sg_cpu->sg_policy->limits_changed = true;
 }
 
@@ -347,8 +314,6 @@ static inline bool sugov_update_single_common(struct sugov_cpu *sg_cpu,
 					      u64 time, unsigned long max_cap,
 					      unsigned int flags)
 {
-	unsigned long boost;
-
 	sugov_iowait_boost(sg_cpu, time, flags);
 	sg_cpu->last_update = time;
 
@@ -357,8 +322,8 @@ static inline bool sugov_update_single_common(struct sugov_cpu *sg_cpu,
 	if (!sugov_should_update_freq(sg_cpu->sg_policy, time))
 		return false;
 
-	boost = sugov_iowait_apply(sg_cpu, time, max_cap);
-	sugov_get_util(sg_cpu, boost);
+	sugov_get_util(sg_cpu);
+	sugov_iowait_apply(sg_cpu, time, max_cap);
 
 	return true;
 }
@@ -442,8 +407,8 @@ static void sugov_update_single_perf(struct update_util_data *hook, u64 time,
 	    sugov_cpu_is_busy(sg_cpu) && sg_cpu->util < prev_util)
 		sg_cpu->util = prev_util;
 
-	cpufreq_driver_adjust_perf(sg_cpu->cpu, sg_cpu->bw_min,
-				   sg_cpu->util, max_cap);
+	cpufreq_driver_adjust_perf(sg_cpu->cpu, map_util_perf(sg_cpu->bw_dl),
+				   map_util_perf(sg_cpu->util), max_cap);
 
 	sg_cpu->sg_policy->last_freq_update_time = time;
 }
@@ -459,10 +424,9 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
 
 	for_each_cpu(j, policy->cpus) {
 		struct sugov_cpu *j_sg_cpu = &per_cpu(sugov_cpu, j);
-		unsigned long boost;
 
-		boost = sugov_iowait_apply(j_sg_cpu, time, max_cap);
-		sugov_get_util(j_sg_cpu, boost);
+		sugov_get_util(j_sg_cpu);
+		sugov_iowait_apply(j_sg_cpu, time, max_cap);
 
 		util = max(j_sg_cpu->util, util);
 	}
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b803030..f43021f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7820,7 +7820,7 @@ static inline void eenv_pd_busy_time(struct energy_env *eenv,
 	for_each_cpu(cpu, pd_cpus) {
 		unsigned long util = cpu_util(cpu, p, -1, 0);
 
-		busy_time += effective_cpu_util(cpu, util, NULL, NULL);
+		busy_time += effective_cpu_util(cpu, util, ENERGY_UTIL, NULL);
 	}
 
 	eenv->pd_busy_time = min(eenv->pd_cap, busy_time);
@@ -7843,7 +7843,7 @@ eenv_pd_max_util(struct energy_env *eenv, struct cpumask *pd_cpus,
 	for_each_cpu(cpu, pd_cpus) {
 		struct task_struct *tsk = (cpu == dst_cpu) ? p : NULL;
 		unsigned long util = cpu_util(cpu, p, dst_cpu, 1);
-		unsigned long eff_util, min, max;
+		unsigned long eff_util;
 
 		/*
 		 * Performance domain frequency: utilization clamping
@@ -7852,23 +7852,7 @@ eenv_pd_max_util(struct energy_env *eenv, struct cpumask *pd_cpus,
 		 * NOTE: in case RT tasks are running, by default the
 		 * FREQUENCY_UTIL's utilization can be max OPP.
 		 */
-		eff_util = effective_cpu_util(cpu, util, &min, &max);
-
-		/* Task's uclamp can modify min and max value */
-		if (tsk && uclamp_is_used()) {
-			min = max(min, uclamp_eff_value(p, UCLAMP_MIN));
-
-			/*
-			 * If there is no active max uclamp constraint,
-			 * directly use task's one, otherwise keep max.
-			 */
-			if (uclamp_rq_is_idle(cpu_rq(cpu)))
-				max = uclamp_eff_value(p, UCLAMP_MAX);
-			else
-				max = max(max, uclamp_eff_value(p, UCLAMP_MAX));
-		}
-
-		eff_util = sugov_effective_cpu_perf(cpu, eff_util, min, max);
+		eff_util = effective_cpu_util(cpu, util, FREQUENCY_UTIL, tsk);
 		max_util = max(max_util, eff_util);
 	}
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e58a54b..8a70d51 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2994,14 +2994,24 @@ static inline void cpufreq_update_util(struct rq *rq, unsigned int flags) {}
 #endif
 
 #ifdef CONFIG_SMP
-unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
-				 unsigned long *min,
-				 unsigned long *max);
-
-unsigned long sugov_effective_cpu_perf(int cpu, unsigned long actual,
-				 unsigned long min,
-				 unsigned long max);
+/**
+ * enum cpu_util_type - CPU utilization type
+ * @FREQUENCY_UTIL:	Utilization used to select frequency
+ * @ENERGY_UTIL:	Utilization used during energy calculation
+ *
+ * The utilization signals of all scheduling classes (CFS/RT/DL) and IRQ time
+ * need to be aggregated differently depending on the usage made of them. This
+ * enum is used within effective_cpu_util() to differentiate the types of
+ * utilization expected by the callers, and adjust the aggregation accordingly.
+ */
+enum cpu_util_type {
+	FREQUENCY_UTIL,
+	ENERGY_UTIL,
+};
 
+unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
+				 enum cpu_util_type type,
+				 struct task_struct *p);
 
 /*
  * Verify the fitness of task @p to run on @cpu taking into account the
@@ -3058,6 +3068,59 @@ static inline bool uclamp_rq_is_idle(struct rq *rq)
 	return rq->uclamp_flags & UCLAMP_FLAG_IDLE;
 }
 
+/**
+ * uclamp_rq_util_with - clamp @util with @rq and @p effective uclamp values.
+ * @rq:		The rq to clamp against. Must not be NULL.
+ * @util:	The util value to clamp.
+ * @p:		The task to clamp against. Can be NULL if you want to clamp
+ *		against @rq only.
+ *
+ * Clamps the passed @util to the max(@rq, @p) effective uclamp values.
+ *
+ * If sched_uclamp_used static key is disabled, then just return the util
+ * without any clamping since uclamp aggregation at the rq level in the fast
+ * path is disabled, rendering this operation a NOP.
+ *
+ * Use uclamp_eff_value() if you don't care about uclamp values at rq level. It
+ * will return the correct effective uclamp value of the task even if the
+ * static key is disabled.
+ */
+static __always_inline
+unsigned long uclamp_rq_util_with(struct rq *rq, unsigned long util,
+				  struct task_struct *p)
+{
+	unsigned long min_util = 0;
+	unsigned long max_util = 0;
+
+	if (!static_branch_likely(&sched_uclamp_used))
+		return util;
+
+	if (p) {
+		min_util = uclamp_eff_value(p, UCLAMP_MIN);
+		max_util = uclamp_eff_value(p, UCLAMP_MAX);
+
+		/*
+		 * Ignore last runnable task's max clamp, as this task will
+		 * reset it. Similarly, no need to read the rq's min clamp.
+		 */
+		if (uclamp_rq_is_idle(rq))
+			goto out;
+	}
+
+	min_util = max_t(unsigned long, min_util, uclamp_rq_get(rq, UCLAMP_MIN));
+	max_util = max_t(unsigned long, max_util, uclamp_rq_get(rq, UCLAMP_MAX));
+out:
+	/*
+	 * Since CPU's {min,max}_util clamps are MAX aggregated considering
+	 * RUNNABLE tasks with _different_ clamps, we can end up with an
+	 * inversion. Fix it now when the clamps are applied.
+	 */
+	if (unlikely(min_util >= max_util))
+		return min_util;
+
+	return clamp(util, min_util, max_util);
+}
+
 /* Is the rq being capped/throttled by uclamp_max? */
 static inline bool uclamp_rq_is_capped(struct rq *rq)
 {
@@ -3095,6 +3158,13 @@ static inline unsigned long uclamp_eff_value(struct task_struct *p,
 	return SCHED_CAPACITY_SCALE;
 }
 
+static inline
+unsigned long uclamp_rq_util_with(struct rq *rq, unsigned long util,
+				  struct task_struct *p)
+{
+	return util;
+}
+
 static inline bool uclamp_rq_is_capped(struct rq *rq) { return false; }
 
 static inline bool uclamp_is_used(void)

