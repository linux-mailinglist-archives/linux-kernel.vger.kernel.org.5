Return-Path: <linux-kernel+bounces-12875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE64D81FBF6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 00:19:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2F561C21CA9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 23:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0227D10A02;
	Thu, 28 Dec 2023 23:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="J7aSPRDl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E365D1096A
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 23:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40d5ae89c7bso19820425e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 15:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1703805547; x=1704410347; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z/H+grwOlbrL+SWeAIwtloV01NF8ZZaZmR5c4RdwFUo=;
        b=J7aSPRDlnJrd2BtRIlAFgnujdqVfbkcrEf62BDnCC5+QfqZZ7YEuEkj6dDPKCFdQeV
         INeKwKSlibma4gD5FTtm0olS90KBru+g4X6Cn1Tfqw5XUSwlMJdLPN6YdBRcPZih6uGt
         95Yo2iNblvznfMs/8mDwZVg19ayE3fUh1Wnhr1yArwNPyB559TDTaNMAfsHopHDpEf6z
         b1n1fqVJ+O8EYvAWUdYkFwMepw7jJvCR+IJJtkiebvRgAmTGkUh+cVmfEber2feHweXO
         kpv1vb062fz5uFQTiMW8oo9fFXJ7KpNM4mmgJNuSkOHFXftjY/FkbACxjIs+dGRR2dvX
         roBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703805547; x=1704410347;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z/H+grwOlbrL+SWeAIwtloV01NF8ZZaZmR5c4RdwFUo=;
        b=IIaIbaidbLul5utEjkEU5ar20dXzjJRiN2ue5eHYO3j7KU6sBf+IBVAIPZCHObjeWP
         Ij5EhAQ0eCIXD2wphtzGmABmkFYWxPaX8XFZU3qL0Dx8sXmSX3wLjQxTw5IYPy+TFOEb
         VK6fPQY7Hycc6GZda7YWV2BFgwk4nweXipsSGxQtzR90hNOhX0WXrhdEs0Zsm8dbMueM
         u5Nssgsnw/MUlv9K8uSN4JD13OiHyKzN0k1SrEQubC/1cfroGm4zm25SPbUgYjdXPsiB
         gcqK23t8UsrpKMn1JisYM7fl10meJN+8hqKXtnDJfgBhvo74hs4TdN7muyquJF84m3wU
         LOhQ==
X-Gm-Message-State: AOJu0YzO6UEFgWWB8XOeYRrArNYSxt0wypCKfQikTRYczmFi7GAhWZvN
	IJGwmEE9nxyGFdOemBfVGTh6CfRzYRGodA==
X-Google-Smtp-Source: AGHT+IGyJibEQbosSP/k7i/rX47xLERfnWUm1TKd7kRUc3JWzWJr7fZADK9eXIVCxOm7szX9CFzyuw==
X-Received: by 2002:a05:600c:ccd:b0:40d:5562:ea8a with SMTP id fk13-20020a05600c0ccd00b0040d5562ea8amr4852664wmb.77.1703805546847;
        Thu, 28 Dec 2023 15:19:06 -0800 (PST)
Received: from airbuntu (host109-154-238-212.range109-154.btcentralplus.com. [109.154.238.212])
        by smtp.gmail.com with ESMTPSA id iv13-20020a05600c548d00b0040d30af488asm33985831wmb.40.2023.12.28.15.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 15:19:06 -0800 (PST)
Date: Thu, 28 Dec 2023 23:19:04 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched/fair: Check a task has a fitting cpu when
 updating misfit
Message-ID: <20231228231904.56ep5csrg7l6wqxa@airbuntu>
References: <20231212154056.626978-1-qyousef@layalina.io>
 <bae88015-4205-4449-991f-8104436ab3ba@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bae88015-4205-4449-991f-8104436ab3ba@arm.com>

Hi Pierre

On 12/20/23 17:44, Pierre Gondois wrote:
> Hello Qais,
> 
> On 12/12/23 16:40, Qais Yousef wrote:
> > From: Qais Yousef <qais.yousef@arm.com>
> > 
> > If a misfit task is affined to a subset of the possible cpus, we need to
> > verify that one of these cpus can fit it. Otherwise the load balancer
> > code will continuously trigger needlessly leading the balance_interval
> > to increase in return and eventually end up with a situation where real
> > imbalances take a long time to address because of this impossible
> > imbalance situation.
> > 
> > This can happen in Android world where it's common for background tasks
> > to be restricted to little cores.
> > 
> > Similarly if we can't fit the biggest core, triggering misfit is
> > pointless as it is the best we can ever get on this system.
> > 
> > To be able to detect that; we use asym_cap_list to iterate through
> > capacities in the system to see if the task is able to run at a higher
> > capacity level based on its p->cpus_ptr.
> > 
> > To be able to iterate through capacity levels, export asym_cap_list to
> > allow for fast traversal of all available capacity levels in the system.
> > 
> > Test:
> > =====
> > 
> > Add
> > 
> > 	trace_printk("balance_interval = %lu\n", interval)
> > 
> > in get_sd_balance_interval().
> 
> Just in case, to avoid taking into account the 'cpu_busy' factor in
> get_sd_balance_interval(), it might be better to track
> 'sd->balance_interval' directly.

The compound effect is important.

> 
> Also (and as you said in the commit message), the interest of this patch
> is more to avoid needlessly trying to balance tasks when tasks are pinned
> rather than having a low balance interval. So it might be better to observe

It is about having a low balance interval. Balancing needlessly has a big
consequence on balance interval; which in return on ensuring load balance
happens in timely manner to correct imbalances and handle misfits.

I think phantom domains has been exaggerating these problems.

> either 'sd->nr_balance_failed' or the number of occurrence where
> check_misfit_status() returns 1 and no task is moved.
> 
> When testing the patch, with a CPU-bound task pinned to little CPUs, running
> during 1s (and on one iteration):
> - (top sd)->nr_balance_failed was increased:
>   without patch:
>     150 times
>   with patch:
>     6 times
> - check_misfit_status() returned:
>   without patch:
>   - ret=0: 591
>   - ret=1: 1414
>   with patch
>   - ret=0: 1755
>   - ret=1: 5
> So there should also be improvements in that regard. I could observe
> improvements similar to what you saw regarding the balance_interval.

Thanks for testing!

> 
> > 
> > run
> > 	if [ "$MASK" != "0" ]; then
> > 		adb shell "taskset -a $MASK cat /dev/zero > /dev/null"
> > 	fi
> > 	sleep 10
> > 	// parse ftrace buffer counting the occurrence of each valaue
> > 
> > Where MASK is either:
> > 
> > 	* 0: no busy task running
> > 	* 1: busy task is pinned to 1 cpu; handled today to not cause
> > 	  misfit
> > 	* f: busy task pinned to little cores, simulates busy background
> > 	  task, demonstrates the problem to be fixed
> > 
> > Results:
> > ========
> > 
> > Note how occurrence of balance_interval = 128 overshoots for MASK = f.
> > 
> > BEFORE
> > ------
> > 
> > 	MASK=0
> > 
> > 		   1 balance_interval = 175
> > 		 120 balance_interval = 128
> > 		 846 balance_interval = 64
> > 		  55 balance_interval = 63
> > 		 215 balance_interval = 32
> > 		   2 balance_interval = 31
> > 		   2 balance_interval = 16
> > 		   4 balance_interval = 8
> > 		1870 balance_interval = 4
> > 		  65 balance_interval = 2
> > 
> > 	MASK=1
> > 
> > 		  27 balance_interval = 175
> > 		  37 balance_interval = 127
> > 		 840 balance_interval = 64
> > 		 167 balance_interval = 63
> > 		 449 balance_interval = 32
> > 		  84 balance_interval = 31
> > 		 304 balance_interval = 16
> > 		1156 balance_interval = 8
> > 		2781 balance_interval = 4
> > 		 428 balance_interval = 2
> > 
> > 	MASK=f
> > 
> > 		   1 balance_interval = 175
> > 		1328 balance_interval = 128
> > 		  44 balance_interval = 64
> > 		 101 balance_interval = 63
> > 		  25 balance_interval = 32
> > 		   5 balance_interval = 31
> > 		  23 balance_interval = 16
> > 		  23 balance_interval = 8
> > 		4306 balance_interval = 4
> > 		 177 balance_interval = 2
> > 
> > AFTER
> > -----
> > 
> > Note how the high values almost disappear for all MASK values. The
> > system has background tasks that could trigger the problem without
> > simulate it even with MASK=0.
> > 
> > 	MASK=0
> > 
> > 		 103 balance_interval = 63
> > 		  19 balance_interval = 31
> > 		 194 balance_interval = 8
> > 		4827 balance_interval = 4
> > 		 179 balance_interval = 2
> > 
> > 	MASK=1
> > 
> > 		 131 balance_interval = 63
> > 		   1 balance_interval = 31
> > 		  87 balance_interval = 8
> > 		3600 balance_interval = 4
> > 		   7 balance_interval = 2
> > 
> > 	MASK=f
> > 
> > 		   8 balance_interval = 127
> > 		 182 balance_interval = 63
> > 		   3 balance_interval = 31
> > 		   9 balance_interval = 16
> > 		 415 balance_interval = 8
> > 		3415 balance_interval = 4
> > 		  21 balance_interval = 2
> > 
> > Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> > Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
> > ---
> > 
> > Changes since v1:
> > 
> > 	* Use asym_cap_list (thanks Dietmar) to iterate instead of iterating
> > 	  through every cpu which Vincent was concerned about.
> > 	* Use uclamped util to compare with capacity instead of util_fits_cpu()
> > 	  when iterating through capcities (Dietmar).
> > 	* Update commit log with test results to better demonstrate the problem
> > 
> > v1 discussion: https://lore.kernel.org/lkml/20230820203429.568884-1-qyousef@layalina.io/#t
> > 
> > Food for thoughts: should misfit cause balance_interval to double? This patch
> > will still be needed if the answer is yes to avoid unnecessary misfit-lb to
> > trigger repeatedly anyway.
> > 
> >   kernel/sched/fair.c     | 59 ++++++++++++++++++++++++++++++++++++-----
> >   kernel/sched/sched.h    | 13 +++++++++
> >   kernel/sched/topology.c | 13 +--------
> >   3 files changed, 66 insertions(+), 19 deletions(-)
> > 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index bcea3d55d95d..94e2f659fef9 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -5065,17 +5065,59 @@ static inline int task_fits_cpu(struct task_struct *p, int cpu)
> >   static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
> >   {
> > +	unsigned long uclamp_min, uclamp_max;
> > +	struct asym_cap_data *entry, *next;
> 
> These variables could be moved aside the 'clamped_util' declaration
> as their scope is limited (same remark for 'has_fitting_cpu').
> 
> > +	bool has_fitting_cpu = false;
> > +	unsigned long util, cpu_cap;
> > +	int cpu = cpu_of(rq);
> > +
> >   	if (!sched_asym_cpucap_active())
> >   		return;
> > -	if (!p || p->nr_cpus_allowed == 1) {
> > -		rq->misfit_task_load = 0;
> > -		return;
> > -	}
> > +	if (!p || p->nr_cpus_allowed == 1)
> > +		goto out;
> > -	if (task_fits_cpu(p, cpu_of(rq))) {
> > -		rq->misfit_task_load = 0;
> > -		return;
> > +	cpu_cap = arch_scale_cpu_capacity(cpu);
> > +
> > +	/* If we can't fit the biggest CPU, that's the best we can ever get. */
> > +	if (cpu_cap == SCHED_CAPACITY_SCALE)
> > +		goto out;
> > +
> > +	uclamp_min = uclamp_eff_value(p, UCLAMP_MIN);
> > +	uclamp_max = uclamp_eff_value(p, UCLAMP_MAX);
> > +	util = task_util_est(p);
> > +
> > +	if (util_fits_cpu(util, uclamp_min, uclamp_max, cpu) > 0)
> > +		goto out;
> > +
> > +	/*
> > +	 * If the task affinity is not set to default, make sure it is not
> > +	 * restricted to a subset where no CPU can ever fit it. Triggering
> > +	 * misfit in this case is pointless as it has no where better to move
> > +	 * to. And it can lead to balance_interval to grow too high as we'll
> > +	 * continuously fail to move it anywhere.
> > +	 */
> > +	if (!cpumask_equal(p->cpus_ptr, cpu_possible_mask)) {
> 
> Just to avoid one level of indentation, it might be better to invert the condition.

I think better keep this way and move the variables down here as you suggested.

> 
> > +		unsigned long clamped_util = clamp(util, uclamp_min, uclamp_max);
> > +
> > +		list_for_each_entry_safe(entry, next, &asym_cap_list, link) {
> 
> I think list_for_each_entry_safe() allows to safely remove an element
> from a list, but I'm not sure it protects against a concurrent
> element removal + free.
> 
> I think an rcu would be the right way to protect against that
> in order to safely access asym_cap_list's elements. Otherwise
> asym_cpu_capacity_scan()
> \-list_del(&entry->link);
> \-kfree(entry);
> might free the element.

Hmm I borrowed this usage from there. But yes, you're right there's use after
free here. I was desperate to avoid the rcu conversion I guess :)

> 
> Also, if the list is accessed so many times to look for a CPU with the
> highest capacity, maybe it would be good to order the list and
> access its element from the highest capacity to the lowest.

Good idea. But I'd rather this be split into a different patch. I'll consider
it in next version still if it didn't make things unnecessarily complex.

> 
> > +			if (entry->capacity > cpu_cap) {
> > +				cpumask_t *cpumask;
> > +
> > +				if (clamped_util > entry->capacity)
> > +					continue;
> > +
> > +				cpumask = cpu_capacity_span(entry);
> > +				if (!cpumask_intersects(p->cpus_ptr, cpumask))
> > +					continue;
> > +
> > +				has_fitting_cpu = true;
> > +				break;
> > +			}
> > +		}
> > +
> > +		if (!has_fitting_cpu)
> > +			goto out;
> >   	}
> >   	/*
> > @@ -5083,6 +5125,9 @@ static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
> >   	 * task_h_load() returns 0.
> >   	 */
> >   	rq->misfit_task_load = max_t(unsigned long, task_h_load(p), 1);
> > +	return;
> > +out:
> > +	rq->misfit_task_load = 0;
> >   }
> 
> Along with this function, check_misfit_status() is checking that:
>   rq->cpu_capacity_orig < rq->rd->max_cpu_capacity
> With this patch, maybe this condition is not required anymore.

Yes! Updated

	@@ -9628,9 +9628,7 @@ check_cpu_capacity(struct rq *rq, struct sched_domain *sd)
	  */
	 static inline int check_misfit_status(struct rq *rq, struct sched_domain *sd)
	 {
	-       return rq->misfit_task_load &&
	-               (arch_scale_cpu_capacity(rq->cpu) < rq->rd->max_cpu_capacity ||
	-                check_cpu_capacity(rq, sd));
	+       return rq->misfit_task_load && check_cpu_capacity(rq, sd);
	 }


Thanks!

--
Qais Yousef

