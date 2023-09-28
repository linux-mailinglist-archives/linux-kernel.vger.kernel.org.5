Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5A67B245C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 19:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbjI1Run (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 13:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbjI1Rul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 13:50:41 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C6D19D
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 10:50:36 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-406402933edso48663065e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 10:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695923435; x=1696528235; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rBp5HqD0tLRHc7bAI1R6qVW85SPF+x7eguIC7vgBlx0=;
        b=yP5oENxKhozeecISnNH3wyRpnYrcx7jdzhqKboSU/PaxkiKaJ22VNqUxay7IFlItwy
         kXu5TnhQmVBtlIYiv1aB51IXe7KNOkrfgMCwlUN38uTHRfZDDOz80IRhfihu4KpkUxu7
         RFuBxzq7uUW3PuNTU1FxsyLX7udMxuEx2L3NDgLclBSI9gbAhC5Z8U+YP3ujskhl6g5R
         Ms8GP0jkDARVkxlyZmfVS0UI9qYPdEbpZcxTRJGh9NjEfzQMjBSHoQqEVRS3ynpm21dW
         2Z+SYwRlHXBN7g+DaQ6nSSAOKXgwE1325yxlMaGlk8LX4W1TJGSgZE9ueacTGCwbUBEx
         LP5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695923435; x=1696528235;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rBp5HqD0tLRHc7bAI1R6qVW85SPF+x7eguIC7vgBlx0=;
        b=MOHAeMByyBtWg4gYgcgZ/R8ML2d0KCPZgbyWbSC2H4rm2vYgIdILL21IlVTiZL0umW
         lRaQkoNG3a4FsCJM4ON/dRtReSn9zEl9A6zs8i6Anomi7d41Yuk/GiHDwii68HqzRA63
         D1H7drw+5Clfv3dLYBuozhg+oq8zXmGTtZx69K1CEkmJ2VOkvVhZwm47vWK2UqbFPMyF
         EfZn5Si+53lq7cmjnIcUtb0xOKqE35RqLy9ZmWtOuIAW/A6WlOYiTkWaheb9VfBre8Vg
         PJcGUL6NVQ1f82VMwOJGHpIYCf9/ee0tw93Bp+XTU4TliC4f0Suio+buP/Tn8qPlba78
         p8Lg==
X-Gm-Message-State: AOJu0YxSKAES8RZGSbE4v1jXL3IcZ9qyFPi9JXqCGaRrz/WWz6P0g/zF
        7jonMSStAXsKXfHTkJwgcyeH/A==
X-Google-Smtp-Source: AGHT+IGxf47nwJPacPL9IaYz20PruXMpgDixgzhYS60cbse5Ft4Orv/R9deXOwVsQ0Moh/LgPIeiAg==
X-Received: by 2002:adf:e701:0:b0:315:9e1b:4ea6 with SMTP id c1-20020adfe701000000b003159e1b4ea6mr1819009wrm.58.1695923435063;
        Thu, 28 Sep 2023 10:50:35 -0700 (PDT)
Received: from vingu-book ([2a01:e0a:f:6020:215e:6126:9867:da1f])
        by smtp.gmail.com with ESMTPSA id z16-20020a056000111000b003176eab8868sm19711682wrw.82.2023.09.28.10.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 10:50:34 -0700 (PDT)
Date:   Thu, 28 Sep 2023 19:50:32 +0200
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     Qais Yousef <qyousef@layalina.io>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [PATCH 2/4] sched: cpufreq: Fix apply_dvfs_headroom() escaping
 uclamp constraints
Message-ID: <ZRW86K0Y1ECd4NRG@vingu-book>
References: <CAKfTPtDY48jpO+b-2KXawzxh-ty+FMKX6YUXioNR7kpgO=ua6Q@mail.gmail.com>
 <20230829163740.uadhv2jfjuumqk3w@airbuntu>
 <CAKfTPtCP6uX79dOrzN4PxFTMBFrDAMOOrWyZrsVypUQ0RY7BAA@mail.gmail.com>
 <20230907215555.exjxho34ntkjmn6r@airbuntu>
 <CAKfTPtA8Ljy4NBqjw8Wj4pEFc-OCR55QPuwh+5GgrHN6u+ugsg@mail.gmail.com>
 <20230910174638.qe7jqq6mq36brh6o@airbuntu>
 <CAKfTPtBFAXO=CgqSJ1+y=2ppb5t4oErCtvV336fS6J2nSjBCkQ@mail.gmail.com>
 <20230916192509.bportepj7dbgp6ro@airbuntu>
 <CAKfTPtA5JqNCauG-rP3wGfq+p8EEVx9Tvwj6ksM3SYCwRmfCTg@mail.gmail.com>
 <20230924172301.7lqdcsnpqk7trtno@airbuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230924172301.7lqdcsnpqk7trtno@airbuntu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le dimanche 24 sept. 2023 à 18:23:01 (+0100), Qais Yousef a écrit :
> On 09/24/23 09:58, Vincent Guittot wrote:
> 
> > > Shouldn't it be (568+128)*1.25 = 870? Which is almost the 860 above. We calmped
> > > the 812 to 800, with rounding errors that almost accounts for the 10 points
> > > difference between 870 and 860..
> > 
> > no I voluntarily use 568 + 128*1.25. I added dvfs headroom for irq
> > just to ensure that you will not raise that I removed the headroom for
> > irq and focus on the use case but it might have created more
> > confusion.
> > 
> > My example above demonstrate that only taking care of cases with null
> > irq pressure is not enough and you can still ends up above 800
> > 
> > IIUC you point with uclamp_max. It is a performance limit that you
> > don't want to cross because of CFS.This means that we should not go
> > above 800 in my example because of cfs utilization: Irq needs between
> > 128 and CFS asks 568 so the system needs 696 which is below the 800
> > uclamp. Even if you add the dvfs headroom on irq, the system is still
> > below 800. Only when you add dfvs headroom to cfs then you go above
> > 800 but it's not needed because uclamp say that you should not go
> 
> Yep, absolutely. It seems we agree that CFS shouldn't go above 800 if it is
> capped even if there's headroom, but the question you have on the way it is

At least I want to ensure that cpufreq has the right information to make a
smart decision. In the example above, it's not needed to go above 800 for
neither cfs nor irq.

> being applied. As long as we agree on this part which is a fundamental behavior
> question that I thought is the pain point, the implementation details are
> certainly something that I can improve on.
> 
> > above 800 because of CFS so we should stay at 800 whereas both current
> > formula and your new formula return a value above 800
> 
> I'm not sure how to handle irq, rt and dl here to be honest. They seem to have
> been taken as an 'additional' demand on top of CFS. So yes, we'll go above but
> irq, and dl don't have knowledge about ucalmp_max. RT does and will be equally
> capped like CFS. I kept current behavior the same, but I did wonder about them
> too in patch 4.
> 
> So in a system where there are active CFS, RT, DL and IRQ and both CFS and RT
> had a cap of 800, then they won't ask for me. But once we add IRQ and DL on
> top, then we'll go above.
> 
> You think we shouldn't? See below for a suggestion.

I'm afraid that the answer is not that straight forward

In the example above should we still stay at uclamp value if we now set uclamp
to 680 ?

And what about a uclamp of 160 ?

> 
> > > I am still not sure if you mean we are mixing up the code and we need better
> > > abstraction or something else.
> > >
> > > Beside the abstraction problem, which I agree with, I can't see what I am
> > > mixing up yet :( Sorry I think I need more helping hand to see it.
> > 
> > There is a mix between actual utilization and performance limit and
> > when we add both we then lose important information as highlighted by
> > my example. If the current formula is not correct because we can go
> > above uclamp_max value, your proposal is not better. And the root
> > cause is mainly coming from adding utilization with performance limit
> > (i.e. uclamp)
> > 
> > That's why I said that we need a new interface to enable cpufreq to
> > not blindly apply its headroom but to make smarter decision at cpufreq
> > level
> 
> Okay I see. I tend to agree here too. The question is should cpufreq take each
> util (cfs, rt, dl, irq) as input and do the decision on its own. Or should the
> scheduler add them and pass the aggregated value? If the latter, how can
> cpufreq know how to apply the limit? From what I see all these decisions has to
> happen in the same function but not split.

I'm not in favor of showing all details to cpufreq because it will have to
follow the internal changes. In instead, I was thinking of something like:

/* Function name to be changed */
unsigned_long effective_cpu_util(int cpu, unsigned int *min, unsigned int *max)

The function returns the actual utilization of the CPU and some minimum and
maximum limits with the possibility to have the min and/or Actual values > Max
because the min would be a hard minimum value whereas max only a soft maximum
value.

Min would be the minimum perf to provide to the cpu : typically DL_bw + irq
Actual would be the actual utilization of the cpu: cfs+rt+dl+irq (after scaling
  everything in the normal range)
Max would be the maximum needed performance for normal work: typically the
minimum between uclamp and capacity

Then cpufreq can use these 3 values to compute a performance level and it 
will know up to which perf level it should go and if it is worth it.
Something likr:

/* get scheduler statistic */
target = effective_cpu_util(cpu, util, &min, &max)

/* ensure min perf for dl and irq + some margin for others */
target = min + headroom

/* check if we really need to go to max */
if ((actual + headroom) < max)
  max = actual + headroom

/* use max of the 2 values */
target = max(target, max)

I put all this in the below quick patch which only compiled but not tested


---
 include/linux/energy_model.h     |  1 -
 kernel/sched/core.c              | 98 +++++++++++++++++---------------
 kernel/sched/cpufreq_schedutil.c |  6 +-
 kernel/sched/fair.c              |  4 +-
 kernel/sched/sched.h             |  7 ++-
 5 files changed, 61 insertions(+), 55 deletions(-)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index e4cf9baf5f9e..c424a1bcec38 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -261,7 +261,6 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
 	scale_cpu = arch_scale_cpu_capacity(cpu);
 	ref_freq = em_get_capacity_ref_freq(cpu, pd);

-	max_util = map_util_perf(max_util);
 	max_util = min(max_util, allowed_cpu_cap);
 	freq = map_util_freq(max_util, ref_freq, scale_cpu);

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 6560392f2f83..030564f5be24 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7404,18 +7404,13 @@ int sched_core_idle_cpu(int cpu)
  * required to meet deadlines.
  */
 unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
-				 enum cpu_util_type type,
-				 struct task_struct *p)
+				 unsigned long *min,
+				 unsigned long *max)
 {
-	unsigned long dl_util, util, irq, max;
+	unsigned long dl_util, util, irq, scale;
 	struct rq *rq = cpu_rq(cpu);

-	max = arch_scale_cpu_capacity(cpu);
-
-	if (!uclamp_is_used() &&
-	    type == FREQUENCY_UTIL && rt_rq_is_runnable(&rq->rt)) {
-		return max;
-	}
+	scale = arch_scale_cpu_capacity(cpu);

 	/*
 	 * Early check to see if IRQ/steal time saturates the CPU, can be
@@ -7423,9 +7418,16 @@ unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
 	 * update_irq_load_avg().
 	 */
 	irq = cpu_util_irq(rq);
-	if (unlikely(irq >= max))
-		return max;
+	if (unlikely(irq >= scale)) {
+		if (min)
+			*min = scale;
+		if (max)
+			*max = scale;
+		return scale;
+	}

+	if (min)
+		min = irq + cpu_bw_dl(rq);
 	/*
 	 * Because the time spend on RT/DL tasks is visible as 'lost' time to
 	 * CFS tasks and we use the same metric to track the effective
@@ -7439,29 +7441,13 @@ unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
 	 * frequency will be gracefully reduced with the utilization decay.
 	 */
 	util = util_cfs + cpu_util_rt(rq);
-	if (type == FREQUENCY_UTIL)
-		util = uclamp_rq_util_with(rq, util, p);
+	util += cpu_util_dl(rq);

-	dl_util = cpu_util_dl(rq);
-
-	/*
-	 * For frequency selection we do not make cpu_util_dl() a permanent part
-	 * of this sum because we want to use cpu_bw_dl() later on, but we need
-	 * to check if the CFS+RT+DL sum is saturated (ie. no idle time) such
-	 * that we select f_max when there is no idle time.
-	 *
-	 * NOTE: numerical errors or stop class might cause us to not quite hit
-	 * saturation when we should -- something for later.
-	 */
-	if (util + dl_util >= max)
-		return max;
-
-	/*
-	 * OTOH, for energy computation we need the estimated running time, so
-	 * include util_dl and ignore dl_bw.
-	 */
-	if (type == ENERGY_UTIL)
-		util += dl_util;
+	if (util >= scale) {
+		if (max)
+			*max = scale;
+		return scale;
+	}

 	/*
 	 * There is still idle time; further improve the number by using the
@@ -7472,28 +7458,48 @@ unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
 	 *   U' = irq + --------- * U
 	 *                 max
 	 */
-	util = scale_irq_capacity(util, irq, max);
+	util = scale_irq_capacity(util, irq, scale);
 	util += irq;

+	if (max)
+		*max = uclamp_rq_util_with(rq, util, NULL);
+
+	return min(scale, util);
+}
+
+
+/*
+ *  TODO: move this in cpufreq
+ */
+unsigned long effective_cpu_perf(int cpu, unsigned long util_cfs,
+				 struct task_struct *p)
+{
+	unsigned long actual, target;
+
+	/* Get utilization stats */
+	actual = effective_cpu_util(cpu, util_cfs, &min, &max);
+
 	/*
-	 * Bandwidth required by DEADLINE must always be granted while, for
-	 * FAIR and RT, we use blocked utilization of IDLE CPUs as a mechanism
-	 * to gracefully reduce the frequency when no tasks show up for longer
-	 * periods of time.
-	 *
-	 * Ideally we would like to set bw_dl as min/guaranteed freq and util +
-	 * bw_dl as requested freq. However, cpufreq is not yet ready for such
-	 * an interface. So, we only do the latter for now.
+	 * Provide at least enough capacity for DL + irq plus some headroom
+	 * for other activities
 	 */
-	if (type == FREQUENCY_UTIL)
-		util += cpu_bw_dl(rq);
+	target =  map_util_perf(min);

-	return min(max, util);
+	actual = map_util_perf(actual);
+	/* Actually we don't need to target the max performance */
+	if (actual < max)
+		max = actual;
+
+	/*
+	 * Ensure at least minimum perf target while providing more computa capacity when
+	 * possible
+	 */
+	target = max(target,max);
 }

 unsigned long sched_cpu_util(int cpu)
 {
-	return effective_cpu_util(cpu, cpu_util_cfs(cpu), ENERGY_UTIL, NULL);
+	return effective_cpu_util(cpu, cpu_util_cfs(cpu), NULL, NULL);
 }
 #endif /* CONFIG_SMP */

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index e2b9c8c3d69a..ef6b4b09ac12 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -162,7 +162,6 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
 	unsigned int freq;
 	struct cpufreq_policy *policy = sg_policy->policy;

-	util = map_util_perf(util);
 	freq = get_capacity_ref_freq(policy);
 	freq = map_util_freq(util, freq, max);

@@ -179,8 +178,7 @@ static void sugov_get_util(struct sugov_cpu *sg_cpu)
 	struct rq *rq = cpu_rq(sg_cpu->cpu);

 	sg_cpu->bw_dl = cpu_bw_dl(rq);
-	sg_cpu->util = effective_cpu_util(sg_cpu->cpu, util,
-					  FREQUENCY_UTIL, NULL);
+	sg_cpu->util = effective_cpu_perf(sg_cpu->cpu, util, NULL);
 }

 /**
@@ -427,7 +425,7 @@ static void sugov_update_single_perf(struct update_util_data *hook, u64 time,
 		sg_cpu->util = prev_util;

 	cpufreq_driver_adjust_perf(sg_cpu->cpu, map_util_perf(sg_cpu->bw_dl),
-				   map_util_perf(sg_cpu->util), max_cap);
+				   sg_cpu->util, max_cap);

 	sg_cpu->sg_policy->last_freq_update_time = time;
 }
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 06d6d0dde48a..50568e2fa1ba 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7570,7 +7570,7 @@ static inline void eenv_pd_busy_time(struct energy_env *eenv,
 	for_each_cpu(cpu, pd_cpus) {
 		unsigned long util = cpu_util(cpu, p, -1, 0);

-		busy_time += effective_cpu_util(cpu, util, ENERGY_UTIL, NULL);
+		busy_time += effective_cpu_util(cpu, util, NULL, NULL);
 	}

 	eenv->pd_busy_time = min(eenv->pd_cap, busy_time);
@@ -7602,7 +7602,7 @@ eenv_pd_max_util(struct energy_env *eenv, struct cpumask *pd_cpus,
 		 * NOTE: in case RT tasks are running, by default the
 		 * FREQUENCY_UTIL's utilization can be max OPP.
 		 */
-		eff_util = effective_cpu_util(cpu, util, FREQUENCY_UTIL, tsk);
+		eff_util = effective_cpu_perf(cpu, util, tsk);
 		max_util = max(max_util, eff_util);
 	}

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 17ae151e90c0..e79cb1110e8d 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2988,10 +2988,13 @@ enum cpu_util_type {
 	ENERGY_UTIL,
 };

-unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
-				 enum cpu_util_type type,
+unsigned long effective_cpu_perf(int cpu, unsigned long util_cfs,
 				 struct task_struct *p);

+unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
+				 unsigned long *min,
+				 unsigned long *max)
+
 /*
  * Verify the fitness of task @p to run on @cpu taking into account the
  * CPU original capacity and the runtime/deadline ratio of the task.
--
2.34.1


> 
> It seems the sticking point is how we interpret irq pressure with uclamp. It
> seems you think we should apply any uclamp capping to this, which I think would
> make sense.
> 
> And DL bandwidth we need to max() with the aggregated value.
> 
> So I think the formula could be
> 
> 	util = cfs + rt pressure + irq pressure
> 
> 	unsigned long cpufreq_convert_util_to_freq(rq, util, dl_bw)
> 	{
> 		eff_util = apply_dvfs_headroom(util);
> 		eff_util = uclamp_rq_util_with(rq, util, NULL);
> 
> 		eff_util = max(eff_util, dl_bw);
> 	}
> 
> so we add the utilization of cfs, rt and irq (as per current formula). And then
> let cpufreq do the headroom and limit management.
> 
> I changed the way we handle dl_bw as it is actually requesting to run at
> a specific level and not really a pressure. So we max() it with eff_util.
> 
> If there's a DL task on the rq then it'd be running and the frequency it
> needs is defined by its bandwidth.
> 
> We could also keep it as it is with
> 
> 	unsigned long cpufreq_convert_util_to_freq(rq, util, dl_bw)
> 	{
> 		eff_util = apply_dvfs_headroom(util);
> 		eff_util = uclamp_rq_util_with(rq, util, NULL);
> 
> 		eff_util += dl_bw;
> 	}
> 
> RT has uclamp knowledge so it'll either run at max or whatever value it might
> have requested via uclamp_min. But DL doesn't set any uclamp_min and must be
> either added or max()ed. I'm not sure which is more correct yet, but maybe
> adding actually is better to ensure the CPU runs higher to handle all the tasks
> on the rq.
> 
> What do you think?
> 
> 
> Thanks!
> 
> --
> Qais Yousef
