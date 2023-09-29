Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7107B2D6D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 10:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232869AbjI2IBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 04:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232862AbjI2IBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 04:01:37 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C1DCDD
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 01:01:31 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-32167a4adaaso13181146f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 01:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695974489; x=1696579289; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yqgUS7wJ1G03tinBZqXJ1SkurpIUlMBVyenZP4LmNNQ=;
        b=oWPYbCG3ZvfhtLEWmxyqUVlNawQmiBMckugbR6z5qyYdpidq/ENHqWt+/FuW2mLAW+
         raCQuweC0upu2EXArjptASw3gqujsEi4L4rhXYxCWl9IexDyhVd764WSDsVn7xWgWw1c
         OTddeyqNr9t22SDYFSA+SHZcrlUmEw14l4FATN6LyHKXl9ChipXv3cLt8gDv3qtFXyn8
         tgiGJJA5zIyycWpgxQBjPh8t20/k+VI8lo5f6tq16w9CSd9533h8rIAP4+Q7hQLGtMew
         orI9PGHq0A4ZnBo2EsnHgtyQDyQlGBCdH2YpoJfFAm+LkRh8uCoU0D0i+BgHjvjsR5A/
         4euw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695974489; x=1696579289;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yqgUS7wJ1G03tinBZqXJ1SkurpIUlMBVyenZP4LmNNQ=;
        b=V0yqdrIXUegS51OloFX0FAq7uPxYBE9jOlnQYz/g/nZHDQubn0jyPM1hB++0CYxINh
         qpn2hd7R2mUUf0XFWGQeOIJUYRMbXvomGJ3ADO09znBEMgIKj5wnQvThUlb1+1s3HzSg
         N6VbIY48TE5wgEdbS53MH8anN6sItwfXvBqLAeoLWyDyODHSokDT/J0nnBkWvaMKeMzo
         cc2pHbfWceDzlDipPVMTctzCOzimEFGRhKy3bH68ZS6fkQnra6or38wLzkUQGN8pZR8G
         cuzUCFT8Qwo68qQQ1vndvWaFkvUx9fWbCrN2XKEyYeX6wSi5Wqan5ZXu3GPWyVV72OIf
         8+Gw==
X-Gm-Message-State: AOJu0YxG4te/4Tq/Zx+Jzf+InScj+joNrz82ikVpPVbypKbaAMYuv1Vt
        0CgyK30X/+5UY8UGjaOEnvut4g==
X-Google-Smtp-Source: AGHT+IFF6D7gLCaTRJBIayLWemsQAjQF0xCX8b58zlZoMz8qWEZ+IbGdv72ZMDksJAId3mlv8/Sseg==
X-Received: by 2002:a5d:4006:0:b0:321:5e13:3829 with SMTP id n6-20020a5d4006000000b003215e133829mr3120086wrp.1.1695974488744;
        Fri, 29 Sep 2023 01:01:28 -0700 (PDT)
Received: from vingu-book ([2a01:e0a:f:6020:215e:6126:9867:da1f])
        by smtp.gmail.com with ESMTPSA id w10-20020adfd4ca000000b0031762e89f94sm20852413wrk.117.2023.09.29.01.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 01:01:28 -0700 (PDT)
Date:   Fri, 29 Sep 2023 10:01:26 +0200
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
Message-ID: <ZRaEViPRHOGeH0MM@vingu-book>
References: <CAKfTPtCP6uX79dOrzN4PxFTMBFrDAMOOrWyZrsVypUQ0RY7BAA@mail.gmail.com>
 <20230907215555.exjxho34ntkjmn6r@airbuntu>
 <CAKfTPtA8Ljy4NBqjw8Wj4pEFc-OCR55QPuwh+5GgrHN6u+ugsg@mail.gmail.com>
 <20230910174638.qe7jqq6mq36brh6o@airbuntu>
 <CAKfTPtBFAXO=CgqSJ1+y=2ppb5t4oErCtvV336fS6J2nSjBCkQ@mail.gmail.com>
 <20230916192509.bportepj7dbgp6ro@airbuntu>
 <CAKfTPtA5JqNCauG-rP3wGfq+p8EEVx9Tvwj6ksM3SYCwRmfCTg@mail.gmail.com>
 <20230924172301.7lqdcsnpqk7trtno@airbuntu>
 <ZRW86K0Y1ECd4NRG@vingu-book>
 <20230928220504.gcft523kvt5jlfoi@airbuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230928220504.gcft523kvt5jlfoi@airbuntu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeudi 28 sept. 2023 à 23:05:04 (+0100), Qais Yousef a écrit :
> On 09/28/23 19:50, Vincent Guittot wrote:
> 
> > > 
> > > Yep, absolutely. It seems we agree that CFS shouldn't go above 800 if it is
> > > capped even if there's headroom, but the question you have on the way it is
> > 
> > At least I want to ensure that cpufreq has the right information to make a
> > smart decision. In the example above, it's not needed to go above 800 for
> > neither cfs nor irq.
> 
> Okay you want to do even bigger rework :-) I thought I might have pushed some
> boundary with the rework I had in mind hehe.
> 
> > I'm not in favor of showing all details to cpufreq because it will have to
> > follow the internal changes. In instead, I was thinking of something like:
> > 
> > /* Function name to be changed */
> > unsigned_long effective_cpu_util(int cpu, unsigned int *min, unsigned int *max)
> > 
> > The function returns the actual utilization of the CPU and some minimum and
> > maximum limits with the possibility to have the min and/or Actual values > Max
> > because the min would be a hard minimum value whereas max only a soft maximum
> > value.
> > 
> > Min would be the minimum perf to provide to the cpu : typically DL_bw + irq
> > Actual would be the actual utilization of the cpu: cfs+rt+dl+irq (after scaling
> >   everything in the normal range)
> > Max would be the maximum needed performance for normal work: typically the
> > minimum between uclamp and capacity
> > 
> > Then cpufreq can use these 3 values to compute a performance level and it 
> > will know up to which perf level it should go and if it is worth it.
> > Something likr:
> 
> Okay thanks! I think I have better clarity now. Let me try to rework the
> patches.

This is the patch with everything amended, some pieces were missing in the previous version.

---
 include/linux/energy_model.h     |   1 -
 kernel/sched/core.c              | 103 +++++++++++++++++--------------
 kernel/sched/cpufreq_schedutil.c |   6 +-
 kernel/sched/fair.c              |   4 +-
 kernel/sched/sched.h             |   7 ++-
 5 files changed, 66 insertions(+), 55 deletions(-)

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
index 6560392f2f83..e5476703ba49 100644
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
+	unsigned long util, irq, scale;
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
+		*min = irq + cpu_bw_dl(rq);
 	/*
 	 * Because the time spend on RT/DL tasks is visible as 'lost' time to
 	 * CFS tasks and we use the same metric to track the effective
@@ -7439,29 +7441,13 @@ unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
 	 * frequency will be gracefully reduced with the utilization decay.
 	 */
 	util = util_cfs + cpu_util_rt(rq);
-	if (type == FREQUENCY_UTIL)
-		util = uclamp_rq_util_with(rq, util, p);
-
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
+	util += cpu_util_dl(rq);

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
@@ -7472,28 +7458,53 @@ unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
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
+	unsigned long actual, target, min, max;
+	struct rq *rq = cpu_rq(cpu);
+
+	/* Get utilization stats */
+	actual = effective_cpu_util(cpu, util_cfs, &min, &max);
+
+	/* Check how max would be changed with p */
+	if (p)
+		max = min(max, uclamp_rq_util_with(rq, util_cfs, p));
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
+	return max(target,max);
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
index 17ae151e90c0..4cae9d7c4d8f 100644
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
+				 unsigned long *max);
+
 /*
  * Verify the fitness of task @p to run on @cpu taking into account the
  * CPU original capacity and the runtime/deadline ratio of the task.
--
2.34.1

> 
> 
> Cheers
> 
> --
> Qais Yousef
