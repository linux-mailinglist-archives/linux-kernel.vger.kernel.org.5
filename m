Return-Path: <linux-kernel+bounces-33888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF50F836FF1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B6A2288976
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E06B53E1C;
	Mon, 22 Jan 2024 18:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="o+tb7JoV"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2003053E0F
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 18:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705946539; cv=none; b=WfCm5DAOGJJ/cl8tyiqwwtAh/VufzUqUfBNbkANZIKHM6acWJAd7xDxPKc6xyEaVHHFU4ODvogY9kA6ssR0mko/aI6FMzK7bzXSjcN5yEAlLeHNgKoj4zoNX1DmN4fnnhVxaj1GZvwaBoY/9DxbjF+G290NYdJfGLGxDibdTliQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705946539; c=relaxed/simple;
	bh=rqycLbZNKZ0EznszsO7TDBUYMDYamhKL4fqnxt5/Lg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IteBVClRFCzmvwqxn+6hMmRUh9XGX0Yh+70FC3tpuUZbIj12kvIKpDLoa4ZwwbNXOPCHkVq4dRJZ4WYJwtbA3wAvHG4jGwX+QsopK6sWJ2qx+cCrUXZKyrUmX2MIBNcjg73VgLBrGRyGFs9WTbjCURQinxJaX56aUDRadDBXgn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=o+tb7JoV; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40eab3912d5so15329145e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 10:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1705946535; x=1706551335; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1/2taydVKFc/zS2Ify5COKaLyTkcbE4jXXmTeD7BXjk=;
        b=o+tb7JoVUWo5bUeIR0pbsY2vDXugYgB95WhVoujgfWkkLN4FDvBmngJuMEYG+6eBNM
         0AV/7/6v05iMKYtuAR5t1wVNx0u5MII2uIVvW//WhgAgqmZeQJxRBgIIMVolTzXlKh6N
         hyQML4CTEyJX7g++01YbTwnkK+Tn+NNz/v8Ns8g9bv41lDvhzUYtvSH9NNb7YUrNkYYN
         WeHF4UPPzm01VeqztEjBJNIhSw9GwnT87TJIJe+CzeZrb/HawLz1un/rVwrQxdq1x8Mn
         Jr2sDqI670Na9Qd1KYGuQXYKcjmKDDRnqYzcRRWfESpfYIi4IQt3FWaP6PKk2I1N4plU
         Lpug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705946535; x=1706551335;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1/2taydVKFc/zS2Ify5COKaLyTkcbE4jXXmTeD7BXjk=;
        b=CvssVa6FK80GbKI9kUsipH5V95kQmzxUhBont4EzLWdQ4EwOuPI/BI+mkeG/qS76rs
         lGaI6HChI6ox2/4c+7XwAncFtoFzB5bNn3cqxGs/ApQteCMGux6SPayWPYrej7KLQtLC
         rhoBUE9vYzr3edab7ZKdqKsAXXFZO+13yG488+7bpWe6MQIbiL501eijz/8W15Tq94Gp
         ZzaqoyblkEHGtNhZzbEeJ6uVcIhS0SgN8OUq0CmZC0RO0MqlC5QfR9zcHRikD/aX0S0P
         zYAgttJwUupmBAswgYKa0JUC/h47Wks8DshB2reEl0Bz0ZtsB5xnhJXSeGXtrlpGqR2X
         h7nA==
X-Gm-Message-State: AOJu0YwXUK8trs+EkD1Nw+hRzhsksGXpmzJudPhCJ/VsyzO8TjdZlcoV
	DMLrtdVMfAM/ysJ+4lAMdX+zLdG6JygMJPACXgacXNvenkM1SwHzyG0UNwIcvxY=
X-Google-Smtp-Source: AGHT+IExjO4jydlIPFwCw7cy8KKzxDUr4S25Q9t5jDKP9qi3dY5jyk6TyqJtKt/uKkvZ2UeQ3xYXzQ==
X-Received: by 2002:a05:600c:4fd5:b0:40e:397e:16e7 with SMTP id o21-20020a05600c4fd500b0040e397e16e7mr2834604wmq.3.1705946534982;
        Mon, 22 Jan 2024 10:02:14 -0800 (PST)
Received: from airbuntu ([213.122.231.14])
        by smtp.gmail.com with ESMTPSA id l13-20020a05600c4f0d00b0040e85f86515sm21943020wmq.29.2024.01.22.10.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 10:02:14 -0800 (PST)
Date: Mon, 22 Jan 2024 18:02:12 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org,
	Pierre Gondois <Pierre.Gondois@arm.com>
Subject: Re: [PATCH v4 1/2] sched/fair: Check a task has a fitting cpu when
 updating misfit
Message-ID: <20240122180212.67csjrnsbs7vq57i@airbuntu>
References: <20240105222014.1025040-1-qyousef@layalina.io>
 <20240105222014.1025040-2-qyousef@layalina.io>
 <213f94df-cc36-4281-805d-9f56cbfef796@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <213f94df-cc36-4281-805d-9f56cbfef796@arm.com>

On 01/22/24 09:59, Dietmar Eggemann wrote:
> On 05/01/2024 23:20, Qais Yousef wrote:
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
> > capacity level based on its p->cpus_ptr. To do so safely, we convert the
> > list to be RCU protected.
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
> 
> ... no busy task stands for no misfit scenario?

Yes

> 
> > 	* 1: busy task is pinned to 1 cpu; handled today to not cause
> > 	  misfit
> > 	* f: busy task pinned to little cores, simulates busy background
> > 	  task, demonstrates the problem to be fixed
> > 
> 
> [...]
> 
> > +	/*
> > +	 * If the task affinity is not set to default, make sure it is not
> > +	 * restricted to a subset where no CPU can ever fit it. Triggering
> > +	 * misfit in this case is pointless as it has no where better to move
> > +	 * to. And it can lead to balance_interval to grow too high as we'll
> > +	 * continuously fail to move it anywhere.
> > +	 */
> > +	if (!cpumask_equal(p->cpus_ptr, cpu_possible_mask)) {
> 
> Shouldn't this be cpu_active_mask ?

Hmm. So the intention was to check if the affinity was changed from default.

If we hotplug all but little we could end up with the same problem, yes you're
right.

But if the affinity is set to only to littles and cpu_active_mask is only for
littles too, then we'll also end up with the same problem as they both are
equal.

Better to drop this check then? With the sorted list the common case should be
quick to return as they'll have 1024 as a possible CPU.

> 
> include/linux/cpumask.h
> 
>  * cpu_possible_mask- has bit 'cpu' set iff cpu is populatable
>  * cpu_present_mask - has bit 'cpu' set iff cpu is populated
>  * cpu_online_mask  - has bit 'cpu' set iff cpu available to scheduler
>  * cpu_active_mask  - has bit 'cpu' set iff cpu available to migration
> 
> 
> > +		unsigned long clamped_util = clamp(util, uclamp_min, uclamp_max);
> > +		bool has_fitting_cpu = false;
> > +		struct asym_cap_data *entry;
> > +
> > +		rcu_read_lock();
> > +		list_for_each_entry_rcu(entry, &asym_cap_list, link) {
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
> 
> What happen when we hotplug out all CPUs of one CPU capacity value?
> IMHO, we don't call asym_cpu_capacity_scan() with !new_topology
> (partition_sched_domains_locked()).

Right. I missed that. We can add another intersection check against
cpu_active_mask.

I am assuming the skipping was done by design, not a bug that needs fixing?
I see for suspend (cpuhp_tasks_frozen) the domains are rebuilt, but not for
hotplug.

> 
> > +		rcu_read_unlock();
> > +
> > +		if (!has_fitting_cpu)
> > +			goto out;
> >  	}
> >  
> >  	/*
> > @@ -5083,6 +5127,9 @@ static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
> >  	 * task_h_load() returns 0.
> >  	 */
> >  	rq->misfit_task_load = max_t(unsigned long, task_h_load(p), 1);
> > +	return;
> > +out:
> > +	rq->misfit_task_load = 0;
> >  }
> >  
> >  #else /* CONFIG_SMP */
> > @@ -9583,9 +9630,7 @@ check_cpu_capacity(struct rq *rq, struct sched_domain *sd)
> >   */
> >  static inline int check_misfit_status(struct rq *rq, struct sched_domain *sd)
> >  {
> > -	return rq->misfit_task_load &&
> > -		(arch_scale_cpu_capacity(rq->cpu) < rq->rd->max_cpu_capacity ||
> > -		 check_cpu_capacity(rq, sd));
> > +	return rq->misfit_task_load && check_cpu_capacity(rq, sd);
> 
> You removed 'arch_scale_cpu_capacity(rq->cpu) <
> rq->rd->max_cpu_capacity' here. Why? I can see that with the standard

Based on Pierre review since we no longer trigger misfit for big cores.
I thought Pierre's remark was correct so did the change in v3

	https://lore.kernel.org/lkml/bae88015-4205-4449-991f-8104436ab3ba@arm.com/

> setup (max CPU capacity equal 1024) which is what we probably use 100%
> of the time now. It might get useful again when Vincent will introduce
> his 'user space system pressure' implementation?

I don't mind putting it back if you think it'd be required again in the near
future. I still didn't get a chance to look at Vincent patches properly, but if
there's a clash let's reduce the work.

> 
> >  }
> 
> [...]
> 
> > @@ -1423,8 +1418,8 @@ static void asym_cpu_capacity_scan(void)
> >  
> >  	list_for_each_entry_safe(entry, next, &asym_cap_list, link) {
> >  		if (cpumask_empty(cpu_capacity_span(entry))) {
> > -			list_del(&entry->link);
> > -			kfree(entry);
> > +			list_del_rcu(&entry->link);
> > +			call_rcu(&entry->rcu, free_asym_cap_entry);
> 
> Looks like there could be brief moments in which one CPU capacity group
> of CPUs could be twice in asym_cap_list. I'm thinking about initial
> startup + max CPU frequency related adjustment of CPU capacity
> (init_cpu_capacity_callback()) for instance. Not sure if this is really
> an issue?

I don't think so. As long as the reader sees a consistent value and no crashes
ensued, a momentarily wrong decision in transient or extra work is fine IMO.
I don't foresee a big impact.


Thanks!

--
Qais Yousef

> 
> [...]
> 

