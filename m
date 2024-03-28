Return-Path: <linux-kernel+bounces-123783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0549F890DB7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 866131F27D1C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1812631A83;
	Thu, 28 Mar 2024 22:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="1UCFopmC"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8149221373
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 22:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711665459; cv=none; b=J69QaJdrdLkB/Mh3i9b9VwxdqOcryMUsNTNwVQV6mGlFbPhvWjWXg+GUs+rKKLNe7M6rnYPkFhWfwElR8kkp9SbhwwhfN+vFbaR5GkpTMU8ECAC4k77XQNE8s8NshdiiWLbNut5fxH1hIVb31KK+wM53pwUBsoW3MH1gWECkaCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711665459; c=relaxed/simple;
	bh=Vkr1WxMhlFLO+x2ZcWsJgIMf8lc7J4Up6fBFg90WuTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i8UtkREuRCS73VPtLzAqs4X5Fmu2LJo8+O+0paFoCLllrkZrpwrDLTnBw60kQAMSJYu3lWEzTSD6qPJv4Pyz5lnbZ71GyLtyzn9tKJdZKYcJM0aejJwIG80KSM7qZHKudHQzgkz4XIOTKWtF/gmXGRqoCyysOVzvvzz1BJN4Edw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=1UCFopmC; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3417a3151c5so944333f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 15:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1711665456; x=1712270256; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VkPtcG4acJAFYV4pyrGTORem1a2S7l8qw1NBVRkOxbk=;
        b=1UCFopmCMEOG73qoR3lKT+izIQbjb5uSexQbsRmI/dHvPaMyvs4UMs43E62HkIJ/5m
         adSXaNDpNleHYSfVCCT4nZ6/bbQ6vHFQ9ZqN6YdRli753+Y3yOE3WzvZ0nIicch/dsVY
         ErHDkTWTJLHGf8AUSs3Ya8x0l1HR1r1NoJl/SM1Ze4wEq+JicwBRfY+QA3gOHO9BNheD
         wXA5Rev9ZIgaKvpuGBgg9Iwu5AfcSZE5D9B7eDgNz580VSAOjnfUWnbGHGJ+CW7iGmJ/
         2GDz/pG81PAOTOBpektjVW/NARiBUCOUfDSLJODqRqN3oiV9KcA1nm21o/rb7bcfCJTg
         Zvrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711665456; x=1712270256;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VkPtcG4acJAFYV4pyrGTORem1a2S7l8qw1NBVRkOxbk=;
        b=WJ3cZbGyI55QK4W0ByENSGCcNtb/W9kwbkOzg2DejdqlW77U/sPqU5YimmwqldPaBv
         ypGAuZKFeXQsOEpwKDg1GjHaSXBjrAMcS88i0Fd0PETjISA92kyZGEAWIuCPwcqa3tW7
         xmbo6aTPyDgmmIca41BtLgB1+U9KDnqgbcDVUt2eUZkcd/m6bREC7QpfB9vUnmqYuIy6
         93P5bekQ6siRJEsw6n4zXMZfXqEUIpWEx1ySIXzX1k/COKIDiA9zeelhwoGy6kaB9QBL
         eJzm8oomB6KaHgUQJ8wBWaFNpUY46jE060WAtkU6Xjr7x4iDUV568xa2FKwo5EeLmaFA
         72CA==
X-Forwarded-Encrypted: i=1; AJvYcCVct8AB2t2zMEyutMXNYpiWLcZ6MmRPGKa+uRRLiYll9UarF1uVED3kbCpY/hd5FksXHkxB4WTuS7aqBOcN5lMlAx+DAPUJVK6kUPWw
X-Gm-Message-State: AOJu0Yyfqllchnv8osSDMuzhPIfMB+Pab6UJvY7ABdIOgDL8M+KSZrfK
	StjjECsKlfnVHRPQtUEFgK3OYU6CudW52zTELwiGk2YPtJYo53V8LXS5hh8fR7w=
X-Google-Smtp-Source: AGHT+IHWEbOGYStLbJMwmtVNWmZxv+uVba1JGzpF1FPRnMxw0jc7hnuO8hg9jvIX9ZJLjqpITu+5aQ==
X-Received: by 2002:a05:6000:1b04:b0:33e:d396:bc41 with SMTP id f4-20020a0560001b0400b0033ed396bc41mr200985wrz.71.1711665455743;
        Thu, 28 Mar 2024 15:37:35 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id u18-20020a5d6ad2000000b0033d202abf01sm2743274wrw.28.2024.03.28.15.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 15:37:35 -0700 (PDT)
Date: Thu, 28 Mar 2024 22:37:33 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] sched: Consolidate cpufreq updates
Message-ID: <20240328223733.jwohkuq5azhcgroz@airbuntu>
References: <20240324020139.1032473-1-qyousef@layalina.io>
 <ceecb0ac-13ce-4862-a41a-5ceac08a5df2@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ceecb0ac-13ce-4862-a41a-5ceac08a5df2@arm.com>

On 03/26/24 14:44, Christian Loehle wrote:
> Hi Qais,
> Some first thoughts, I'll do some more thinking and testing though.

Thanks for having a look.

> I wonder if the increased latency of applying the new freq later
> (context-switch vs enqueue) has any measurable impact for some
> workloads for somewhat higher delay switching platforms.
> 
> On 24/03/2024 02:01, Qais Yousef wrote:
> > Improve the interaction with cpufreq governors by making the
> > cpufreq_update_util() calls more intentional.
> > 
> > At the moment we send them when load is updated for CFS, bandwidth for
> > DL and at enqueue/dequeue for RT. But this can lead to too many updates
> > sent in a short period of time and potentially be ignored at a critical
> > moment due to the rate_limit_us in schedutil.
> > 
> > For example, simultaneous task enqueue on the CPU where 2nd task is
> > bigger and requires higher freq. The trigger to cpufreq_update_util() by
> > the first task will lead to dropping the 2nd request until tick. Or
> > another CPU in the same policy triggers a freq update shortly after.
> Out of curiosity: Is that significant anywhere?

It is hard to quantify. But simultaneous enqueue problem are common in
practice. I think I have been raising the issue in various places on the list
so far on how our wake up path in EAS needs to improve on how to balances.
There are a number of corner cases where it lags behind.

This is not the major motivation FWIW. Just an example.

> It is unfortunate for sure, but the delay until the 'big' freq update
> is also bounded.

Could you expand on this please?

> 
> > 
> > Updates at enqueue for RT are not strictly required. Though they do help
> > to reduce the delay for switching the frequency and the potential
> > observation of lower frequency during this delay. But current logic
> > doesn't intentionally (at least to my understanding) try to speed up the
> > request.
> > 
> > To help reduce the amount of cpufreq updates and make them more
> > purposeful, consolidate them into these locations:
> > 
> > 1. context_switch()
> > 2. task_tick_fair()
> > 3. {attach, detach}_entity_load_avg()
> > 4. update_blocked_averages()
> > 
> > The update at context switch should help guarantee that DL and RT get
> > the right frequency straightaway when they're RUNNING. As mentioned
> > though the update will happen slightly after enqueue_task(); though in
> > an ideal world these tasks should be RUNNING ASAP and this additional
> > delay should be negligible. For fair tasks we need to make sure we send
> > a single update for every decay for the root cfs_rq. Any changes to the
> > rq will be deferred until the next task is ready to run, or we hit TICK.
> > But we are guaranteed the task is running at a level that meets its
> > requirements after enqueue.
> > 
> > To guarantee RT and DL tasks updates are never missed, we add a new
> > SCHED_CPUFREQ_FORCE_UPDATE to ignore the rate_limit_us. If we are
> > already running at the right freq, the governor will end up doing
> > nothing, but we eliminate the risk of the task ending up accidentally
> > running at the wrong freq due to rate_limit_us.
> > 
> > Similarly for iowait boost. We also handle a case of a boost reset
> > prematurely by adding a guard against TICK_NSEC in sugov_iowait_apply()
> > in similar fashion to sugov_iowait_reset().
> > 
> > The new SCHED_CPUFREQ_FORCE_UPDATE should not impact the rate limit
> > time stamps otherwise we can end up delaying updates for normal
> > requests.
> With the new updates and the assumed default of 2ms does rate_limit_us
> even make sense then? It is very often ignored with these changes, so

The normal case is fair tasks triggering the updates. And these tasks are not
in_iowait most of the time. So the common case is still not to force an update.

> unless rate_limit_us==2000 && CONFIG_HZ=1000 SCHED_CPUFREQ_FORCE_UPDATE
> would dominate for many workloads, wouldn't it?

I don't think so. RT/DL tasks are priviliged and a minority. And iowait is not
the common case. There are scenarios where it is, but that doesn't make it the
overall common case still.

Also keep in mind that schedutil will not send an update unless this will lead
to a frequency change. RT by default will run at max. So if there are multiple
RT tasks context switching only the first one will send a request. The rest
will end up with an overhead - which I alluded to the fact I can optimize to
remove this overhead somewhere in the commit message.

> Is that fine for all platforms? Platforms I'm aware of will drop older
> requests when they couldn't be served yet and a new one is sent, can
> we assume that generally?

Aren't we dropping the requests in schedutil here too and this leads to
the same problem?

The current contract based on my understanding is that the kernel doesn't
expect these to be dropped. If we expect them, then there has to be error
reporting by the driver otherwise Linux will mistakenly think the frequency
changed and drop future requests to the next frequency.

I don't think rate_limit is the mechanism to handle hardware failure to honour
the request - if that is a problem. We need the driver to let us know. To
my knowledge there's no interface between drivers and governors for this. But
I could be wrong. If I am not mistaken, maybe we should add one.

> > Note worthy that we still have the following race condition on systems
> > that have shared policy:
> > 
> > * CPUs with shared policy can end up sending simultaneous cpufreq
> >   updates requests where the 2nd one will be unlucky and get blocked by
> >   the rate_limit_us (schedutil).
> > 
> > We can potentially address this limitation later, but it is out of the
> > scope of this patch.
> 
> Which has now gotten worse I'm afraid.

How come?

> With a shared policy the "update at context switch" at least theoretically
> no longer works for any freq update delay > 0.
> It could be a non-issue, but confirming that isn't straightforward IMO.

Hmm. I did run tests on Pixel 6 and Apple M1 and didn't notice something. It'd
be good if you can elaborate more on the problem you're seeing.

FWIW the race to which CPU initiates the update between CPUs in shared policies
doesn't change with this patch. It being done at enqueue or context switch
doesn't matter, no?

> > +DEFINE_STATIC_KEY_FALSE(cpufreq_update_enabled);
> > +
> >  /**
> >   * cpufreq_add_update_util_hook - Populate the CPU's update_util_data pointer.
> >   * @cpu: The CPU to set the pointer for.
> > @@ -33,6 +35,8 @@ void cpufreq_add_update_util_hook(int cpu, struct update_util_data *data,
> >  	if (WARN_ON(!data || !func))
> >  		return;
> >  
> > +	static_branch_enable(&cpufreq_update_enabled);
> > +
> FWIW here's the lockdep splat:

Thanks for catching this.

> > @@ -294,17 +301,29 @@ static void sugov_iowait_boost(struct sugov_cpu *sg_cpu, u64 time,
> >   * being more conservative on tasks which does sporadic IO operations.
> >   */
> >  static unsigned long sugov_iowait_apply(struct sugov_cpu *sg_cpu, u64 time,
> > -			       unsigned long max_cap)
> > +			       unsigned long max_cap, unsigned int flags)
> >  {
> > +	bool forced_update = flags & SCHED_CPUFREQ_FORCE_UPDATE;
> > +	s64 delta_ns = time - sg_cpu->last_update;
> > +
> >  	/* No boost currently required */
> >  	if (!sg_cpu->iowait_boost)
> >  		return 0;
> >  
> > +	if (forced_update)
> > +		goto apply_boost;
> > +
> >  	/* Reset boost if the CPU appears to have been idle enough */
> >  	if (sugov_iowait_reset(sg_cpu, time, false))
> >  		return 0;
> >  
> >  	if (!sg_cpu->iowait_boost_pending) {
> > +		/*
> > +		 * Reduce boost only if a tick has elapsed since last request.
> > +		 */
> > +		if (delta_ns <= TICK_NSEC)
> > +			goto apply_boost;
> > +
> 
> That makes the entire reduce logic below dead code.

Hmm yes you're right. This is band aid tbh. This logic needs reworking. I did
go down the path of converting this to per-task iowait boost FWIW. But
hopefully I can leave this to you now ;-)

For the time being, I could:

1. Check against a constant 1ms.
2. Drop the reduce logic in favour of the reset logic (my vote goes here)
3. Keep the current behavior the same and guard iowait boost updates with the
   decay. But I think this defeats the purpose of this patch to make sure
   changes are intentional and aren't accidentally dropped if unlucky.

FWIW, I did hit this problem when changing the default sched period. So it has
more hidden dependencies.

> If delta_ns > TICK_NSEC then sugov_iowait_reset() will have returned early
> anyway and reset the boost.
> In theory the current iowait boost (probabilisticly because of rate_limit_us)
> determined the boost level more or less by the fraction of iowait wakeups
> to non-wakeups.
> Did that ever work in a meaningful way? Maybe not.
> But of course just relying on the reset opens up the boost to linger for
> even longer.
> Anyway the iowait boost needs some rework in both intel_pstate and sugov
> if we switch to a context-switch freq update IMO.
> 
> 
> >  		/*
> >  		 * No boost pending; reduce the boost value.
> >  		 */
> > @@ -315,6 +334,7 @@ static unsigned long sugov_iowait_apply(struct sugov_cpu *sg_cpu, u64 time,
> >  		}
> >  	}
> >  
> > +apply_boost:
> >  	sg_cpu->iowait_boost_pending = false;
> >  
> >  	/*
> > @@ -351,17 +371,28 @@ static inline bool sugov_update_single_common(struct sugov_cpu *sg_cpu,
> >  					      u64 time, unsigned long max_cap,
> >  					      unsigned int flags)
> >  {
> > +	bool forced_update = flags & SCHED_CPUFREQ_FORCE_UPDATE;
> > +	struct sugov_policy *sg_policy = sg_cpu->sg_policy;
> > +	bool iowait_boost = flags & SCHED_CPUFREQ_IOWAIT;
> >  	unsigned long boost;
> >  
> > +	/*
> > +	 * Forced updates are initiated by iowait and RT/DL tasks. If the
> > +	 * latter, verify that it's not our worker thread that is initiating
> > +	 * this forced update.
> > +	 */
> > +	if (forced_update && !iowait_boost && current == sg_policy->thread)
> > +		return false;
> > +
> I don't quite see why this isn't just
> if (current == sg_policy->thread)
> Is there a reason?

The reason is what's written in the comment. These are the conditions where
this check makes sense. We don't want a random out-of-line cpufreq update while
sugov kthread is running to be accidentally dropped.

> 
> >  	sugov_iowait_boost(sg_cpu, time, flags);
> >  	sg_cpu->last_update = time;
> >  
> >  	ignore_dl_rate_limit(sg_cpu);
> >  
> > -	if (!sugov_should_update_freq(sg_cpu->sg_policy, time))
> > +	if (!sugov_should_update_freq(sg_cpu->sg_policy, time, flags))
> >  		return false;
> >  
> > -	boost = sugov_iowait_apply(sg_cpu, time, max_cap);
> > +	boost = sugov_iowait_apply(sg_cpu, time, max_cap, flags);
> >  	sugov_get_util(sg_cpu, boost);
> >  
> >  	return true;
> > @@ -397,7 +428,7 @@ static void sugov_update_single_freq(struct update_util_data *hook, u64 time,
> >  		sg_policy->cached_raw_freq = cached_freq;
> >  	}
> >  
> > -	if (!sugov_update_next_freq(sg_policy, time, next_f))
> > +	if (!sugov_update_next_freq(sg_policy, time, next_f, flags))
> >  		return;
> >  
> >  	/*
> > @@ -449,10 +480,12 @@ static void sugov_update_single_perf(struct update_util_data *hook, u64 time,
> >  	cpufreq_driver_adjust_perf(sg_cpu->cpu, sg_cpu->bw_min,
> >  				   sg_cpu->util, max_cap);
> >  
> > -	sg_cpu->sg_policy->last_freq_update_time = time;
> > +	if (!unlikely(flags & SCHED_CPUFREQ_FORCE_UPDATE))
> > +		sg_cpu->sg_policy->last_freq_update_time = time;
> Is that unlikely? Or rather don't we intend to optimise for the
> SCHED_CPUFREQ_FORCE_UPDATE case, as it's the more time-critical one?
> Just a thought though.

It is unlikely. Fair tasks that are not in iowait boost is the common case.

> >  static inline void remove_entity_load_avg(struct sched_entity *se) {}
> > @@ -6716,14 +6688,6 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> >  	 */
> >  	util_est_enqueue(&rq->cfs, p);
> >  
> > -	/*
> > -	 * If in_iowait is set, the code below may not trigger any cpufreq
> > -	 * utilization updates, so do it here explicitly with the IOWAIT flag
> > -	 * passed.
> > -	 */
> > -	if (p->in_iowait)
> > -		cpufreq_update_util(rq, SCHED_CPUFREQ_IOWAIT);
> > -
> 
> I'm sure you're aware, but of course this also changes behavior in intel_pstate.

I don't expect this to make a difference to intel_pstate. We still send
cpufreq_update_util() with iowait boost flag.

I didn't do another test before sending this patch, but I remember trying on
intel_pstate machine in the past. Will make sure to rerun this test before the
next iteration.


Thanks!

--
Qais Yousef

