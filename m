Return-Path: <linux-kernel+bounces-24060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB6F82B636
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 21:48:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5302E1F2556E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 20:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6AD58116;
	Thu, 11 Jan 2024 20:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJeyBa2b"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3149758112
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 20:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a29c4bbb2f4so623836166b.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 12:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705006103; x=1705610903; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KV+0YZRCNpmvlOaNZbvRNqloa0+eAKz7UjI+kYephqI=;
        b=OJeyBa2bJY5nEhJNkS0etlpkDFM1xxTiXsH96db5ILQn+nnRJVqAfp0oobz9ORtjs2
         dQFsulGcXXLJ+zhBZVfEDy6nNz5G+56eCxU57AOqQKCjO49ipgsbN+scqSa5ises6tyw
         5ru9K52Zj6eh30oex/xrvCzT92nLyxSIX5CFMOInDxQxEt+ULfQ1rwDEN4agUHz6Kc9e
         PyTHWy1UfO/kF3fyvh6XUn3WAEfuRIfQl0MKnLgUdEA/OMrS42YrfO6etui6bL/gtF/f
         KwUzPPLnzBSLmWtbJtiZu7177Y4pmLpXcG5UTy52wAdoTG6IpIsq8jV+zzZv09WPcOZt
         QUtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705006103; x=1705610903;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KV+0YZRCNpmvlOaNZbvRNqloa0+eAKz7UjI+kYephqI=;
        b=kZDUemUVqWvhThmy3AOgAEKRMhPr6P18tDPfIVCKtacHSpS2VRfzo9H6cUrVDbQZ15
         th7gYJGz+AJl4/PiI6DQ5YwOoZgj0iThR9GjIHsnmCmMvR+/H5N3UApRZ8raND81f8a9
         QT1cuMR8jpr9PVqVtoxsB7VvqJP2ZxDY00ieaEQdpBVCO5hGQNiIgwi/4JJcOpbEEsxK
         TkWfnUWuEg2k2TqaFlohb1rfBJJrFU6tcqHSUNruCTsW8STw7Nk7aOtpF9Mdd70Nb1W8
         bTFE+G2afZQYDboKNIS3MoavXZU0KAPMxOFIkvXV2hxcxY0k+zLlRdr/JOcwK1DckFFf
         Z2yQ==
X-Gm-Message-State: AOJu0YxF3QQQuAxzZCdyKdBKEBsX6/LtD5gB7Rujexg5bxfTlXG4z69J
	2PLLotfFpR8Aq6OzfANVPYU=
X-Google-Smtp-Source: AGHT+IEx8m3ZgkQX8iCT/rlNDYkwqNi2YeOupCSNqJPPN3t5+Vefss3hGAggmbDb/ZnQi6hcXvpW9A==
X-Received: by 2002:a17:906:da04:b0:a28:125:8133 with SMTP id fi4-20020a170906da0400b00a2801258133mr110221ejb.134.1705006103052;
        Thu, 11 Jan 2024 12:48:23 -0800 (PST)
Received: from gmail.com (1F2EF3FE.nat.pool.telekom.hu. [31.46.243.254])
        by smtp.gmail.com with ESMTPSA id k13-20020a1709062a4d00b00a290920c78csm977370eje.187.2024.01.11.12.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 12:48:22 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Thu, 11 Jan 2024 21:48:20 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>
Subject: [PATCH] Revert "sched/cpufreq: Rework schedutil governor performance
 estimation" and dependent commit
Message-ID: <ZaBUFETV53cRF7RB@gmail.com>
References: <ZTz9RpZxfxysYCmt@gmail.com>
 <ZZwBi/YmnMqm7zrO@gmail.com>
 <CAHk-=wgWcYX2oXKtgvNN2LLDXP7kXkbo-xTfumEjmPbjSer2RQ@mail.gmail.com>
 <CAHk-=wiXpsxMcQb7MhL-AxOityTajK0G8eWeBOzX-qBJ9X2DSw@mail.gmail.com>
 <CAHk-=wjK28MUqBZzBSMEM8vdJhDOuXGSWPmmp04GEt9CXtW6Pw@mail.gmail.com>
 <ZZ/MY0KEGXotqGHY@gmail.com>
 <CAKfTPtCR5U++CF93aUq8i+j9G5nLRvUUbCESX=CwemYu9LKOqQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtCR5U++CF93aUq8i+j9G5nLRvUUbCESX=CwemYu9LKOqQ@mail.gmail.com>


* Vincent Guittot <vincent.guittot@linaro.org> wrote:

> On Thu, 11 Jan 2024 at 12:09, Ingo Molnar <mingo@kernel.org> wrote:
> >
> >
> > * Linus Torvalds <torvalds@linux-foundation.org> wrote:
> >
> > > On Wed, 10 Jan 2024 at 14:41, Linus Torvalds
> > > <torvalds@linux-foundation.org> wrote:
> > > >
> > > > It's one of these two:
> > > >
> > > >   f12560779f9d sched/cpufreq: Rework iowait boost
> > > >   9c0b4bb7f630 sched/cpufreq: Rework schedutil governor performance estimation
> > > >
> > > > one more boot to go, then I'll try to revert whichever causes my
> > > > machine to perform horribly much worse.
> > >
> > > I guess it should come as no surprise that the result is
> > >
> > >    9c0b4bb7f6303c9c4e2e34984c46f5a86478f84d is the first bad commit
> > >
> > > but to revert cleanly I will have to revert all of
> > >
> > >       b3edde44e5d4 ("cpufreq/schedutil: Use a fixed reference frequency")
> > >       f12560779f9d ("sched/cpufreq: Rework iowait boost")
> > >       9c0b4bb7f630 ("sched/cpufreq: Rework schedutil governor
> > > performance estimation")
> > >
> > > This is on a 32-core (64-thread) AMD Ryzen Threadripper 3970X, fwiw.
> > >
> > > I'll keep that revert in my private test-tree for now (so that I have
> > > a working machine again), but I'll move it to my main branch soon
> > > unless somebody has a quick fix for this problem.
> >
> > Thanks a lot for bisecting this, and ack on the revert in any case, these
> > are relatively fresh changes that clearly didn't get enough testing - sorry!
> 
> b3edde44e5d4 ("cpufreq/schedutil: Use a fixed reference frequency") is
> linked with other patches.

Indeed.

> I can provide a clean revert of only :
> f12560779f9d ("sched/cpufreq: Rework iowait boost")
> 9c0b4bb7f630 ("sched/cpufreq: Rework schedutil governor performance estimation")

I've done this too, see this new commit in sched/urgent:

  60ee1706bd11 ("Revert "sched/cpufreq: Rework schedutil governor performance estimation" and dependent commit")

Also attached below.

> if the fix that i proposed doesn't work:
> https://lore.kernel.org/all/ZZ+ixagkxRPYyTCE@vingu-book/

Yeah - although of course Linus is free to just pull the revert as well. 
I'll try to reproduce the regression locally as well.

Thanks,

	Ingo

===============================>
From: Ingo Molnar <mingo@kernel.org>
Date: Thu, 11 Jan 2024 11:45:17 +0100
Subject: [PATCH] Revert "sched/cpufreq: Rework schedutil governor performance estimation" and dependent commit

This reverts the following commits:

  f12560779f9d73 ("sched/cpufreq: Rework iowait boost")
  9c0b4bb7f6303c ("sched/cpufreq: Rework schedutil governor performance estimation")

Because Linus reported a bad performance regression with the
sched_util governor, that increased the time his empty
kernel build took from 22 to 44 seconds (and can be similarly
measured in full builds as well) - and bisected it back to 9c0b4bb7f6303c.

Until we have a proper fix, revert the broken commit and its
dependent commit.

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Bisected-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/CAHk-=wgWcYX2oXKtgvNN2LLDXP7kXkbo-xTfumEjmPbjSer2RQ@mail.gmail.com
---
 include/linux/energy_model.h     |  1 +
 kernel/sched/core.c              | 90 +++++++++++++++++++++++-----------------
 kernel/sched/cpufreq_schedutil.c | 64 +++++++++++-----------------
 kernel/sched/fair.c              | 22 ++--------
 kernel/sched/sched.h             | 84 +++++++++++++++++++++++++++++++++----
 5 files changed, 158 insertions(+), 103 deletions(-)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index 88d91e087471..c19e7effe764 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -243,6 +243,7 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
 	scale_cpu = arch_scale_cpu_capacity(cpu);
 	ref_freq = arch_scale_freq_ref(cpu);
 
+	max_util = map_util_perf(max_util);
 	max_util = min(max_util, allowed_cpu_cap);
 	freq = map_util_freq(max_util, ref_freq, scale_cpu);
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9116bcc90346..038eeaf76d2d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7468,13 +7468,18 @@ int sched_core_idle_cpu(int cpu)
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
@@ -7482,49 +7487,45 @@ unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
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
@@ -7535,15 +7536,28 @@ unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
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
index 95c3c097083e..5f8729c41d0a 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -47,7 +47,7 @@ struct sugov_cpu {
 	u64			last_update;
 
 	unsigned long		util;
-	unsigned long		bw_min;
+	unsigned long		bw_dl;
 
 	/* The field below is for single-CPU policies only: */
 #ifdef CONFIG_NO_HZ_COMMON
@@ -164,6 +164,7 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
 	struct cpufreq_policy *policy = sg_policy->policy;
 	unsigned int freq;
 
+	util = map_util_perf(util);
 	freq = get_capacity_ref_freq(policy);
 	freq = map_util_freq(util, freq, max);
 
@@ -174,31 +175,14 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
 	return cpufreq_driver_resolve_freq(policy, freq);
 }
 
-unsigned long sugov_effective_cpu_perf(int cpu, unsigned long actual,
-				 unsigned long min,
-				 unsigned long max)
+static void sugov_get_util(struct sugov_cpu *sg_cpu)
 {
-	/* Add dvfs headroom to actual utilization */
-	actual = map_util_perf(actual);
-	/* Actually we don't need to target the max performance */
-	if (actual < max)
-		max = actual;
+	unsigned long util = cpu_util_cfs_boost(sg_cpu->cpu);
+	struct rq *rq = cpu_rq(sg_cpu->cpu);
 
-	/*
-	 * Ensure at least minimum performance while providing more compute
-	 * capacity when possible.
-	 */
-	return max(min, max);
-}
-
-static void sugov_get_util(struct sugov_cpu *sg_cpu, unsigned long boost)
-{
-	unsigned long min, max, util = cpu_util_cfs_boost(sg_cpu->cpu);
-
-	util = effective_cpu_util(sg_cpu->cpu, util, &min, &max);
-	util = max(util, boost);
-	sg_cpu->bw_min = min;
-	sg_cpu->util = sugov_effective_cpu_perf(sg_cpu->cpu, util, min, max);
+	sg_cpu->bw_dl = cpu_bw_dl(rq);
+	sg_cpu->util = effective_cpu_util(sg_cpu->cpu, util,
+					  FREQUENCY_UTIL, NULL);
 }
 
 /**
@@ -289,16 +273,18 @@ static void sugov_iowait_boost(struct sugov_cpu *sg_cpu, u64 time,
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
@@ -307,7 +293,7 @@ static unsigned long sugov_iowait_apply(struct sugov_cpu *sg_cpu, u64 time,
 		sg_cpu->iowait_boost >>= 1;
 		if (sg_cpu->iowait_boost < IOWAIT_BOOST_MIN) {
 			sg_cpu->iowait_boost = 0;
-			return 0;
+			return;
 		}
 	}
 
@@ -317,7 +303,10 @@ static unsigned long sugov_iowait_apply(struct sugov_cpu *sg_cpu, u64 time,
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
@@ -339,7 +328,7 @@ static inline bool sugov_cpu_is_busy(struct sugov_cpu *sg_cpu) { return false; }
  */
 static inline void ignore_dl_rate_limit(struct sugov_cpu *sg_cpu)
 {
-	if (cpu_bw_dl(cpu_rq(sg_cpu->cpu)) > sg_cpu->bw_min)
+	if (cpu_bw_dl(cpu_rq(sg_cpu->cpu)) > sg_cpu->bw_dl)
 		sg_cpu->sg_policy->limits_changed = true;
 }
 
@@ -347,8 +336,6 @@ static inline bool sugov_update_single_common(struct sugov_cpu *sg_cpu,
 					      u64 time, unsigned long max_cap,
 					      unsigned int flags)
 {
-	unsigned long boost;
-
 	sugov_iowait_boost(sg_cpu, time, flags);
 	sg_cpu->last_update = time;
 
@@ -357,8 +344,8 @@ static inline bool sugov_update_single_common(struct sugov_cpu *sg_cpu,
 	if (!sugov_should_update_freq(sg_cpu->sg_policy, time))
 		return false;
 
-	boost = sugov_iowait_apply(sg_cpu, time, max_cap);
-	sugov_get_util(sg_cpu, boost);
+	sugov_get_util(sg_cpu);
+	sugov_iowait_apply(sg_cpu, time, max_cap);
 
 	return true;
 }
@@ -442,8 +429,8 @@ static void sugov_update_single_perf(struct update_util_data *hook, u64 time,
 	    sugov_cpu_is_busy(sg_cpu) && sg_cpu->util < prev_util)
 		sg_cpu->util = prev_util;
 
-	cpufreq_driver_adjust_perf(sg_cpu->cpu, sg_cpu->bw_min,
-				   sg_cpu->util, max_cap);
+	cpufreq_driver_adjust_perf(sg_cpu->cpu, map_util_perf(sg_cpu->bw_dl),
+				   map_util_perf(sg_cpu->util), max_cap);
 
 	sg_cpu->sg_policy->last_freq_update_time = time;
 }
@@ -459,10 +446,9 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
 
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
index 533547e3c90a..f2bb83675e4a 100644
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
index 001fe047bd5d..eb7e07a1abcc 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3005,14 +3005,24 @@ static inline void cpufreq_update_util(struct rq *rq, unsigned int flags) {}
 #endif
 
 #ifdef CONFIG_SMP
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
+
 unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
-				 unsigned long *min,
-				 unsigned long *max);
-
-unsigned long sugov_effective_cpu_perf(int cpu, unsigned long actual,
-				 unsigned long min,
-				 unsigned long max);
-
+				 enum cpu_util_type type,
+				 struct task_struct *p);
 
 /*
  * Verify the fitness of task @p to run on @cpu taking into account the
@@ -3069,6 +3079,59 @@ static inline bool uclamp_rq_is_idle(struct rq *rq)
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
@@ -3106,6 +3169,13 @@ static inline unsigned long uclamp_eff_value(struct task_struct *p,
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

