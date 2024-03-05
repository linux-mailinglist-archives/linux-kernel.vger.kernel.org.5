Return-Path: <linux-kernel+bounces-92138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06296871BC0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:41:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 720521F23B62
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A84176EF3;
	Tue,  5 Mar 2024 10:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="t67obG0p"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D8E5F574
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 10:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709634206; cv=none; b=OXB9uVsW0jlkuffZ8x2Jmld2SBszsbCtUSxkmw8MFl2dPNPuqxgA1tm4WMux2atvLCGISBh8R/hLk02CCeXG5l5gSXrWblIeCDrWooIoU0/fXqdxLfhWbVAkM/YpK7LdNQzZOy5LfkI7yEgg+cwdqJAVUxvL7xp3jNI8dwrutuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709634206; c=relaxed/simple;
	bh=cgRGXD9ZFjusYxyNzcIsYAnQbaC1CKsDHAOhr1XdZBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z+D22HfATArpE0UmIcro5cEJ1ThmUkj+SlnGvNyEBNf5sqTDMIi3vxXxZLHY/HeMGmIgviqaTk8PwubRYd5rV7bCMcgpmn7V+D7RnVHiaT9qwpYZ88uJK3Zz41zVOBL29bpgbFKk2lU5CjCSWUQK1Mzmj0Uzx+lNIiZ3GA+FAlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=t67obG0p; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-412eddd14b9so2454725e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 02:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1709634203; x=1710239003; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pH0qNdvDcbtYm421RfhQxAod4eV9sm4IcyGy9K/hDoU=;
        b=t67obG0pTGP5ix63P9NrvmXX1PM+WPdyfgxjMK/XpvygVEneqSRihQrwNOvg9cyVNp
         HojWe/Wtygq48VwdN7or0c7hHGbAaWe/UOLM5OSHrNQZvSu4walcKDS45we6FvNXQdlo
         4uAzjS3+GmdDPs4OCX82c1NLr55SHg+jAVViQxAD4D9agAC+/SeGHLSOSoXn4CIgnXqS
         aiWmCNATjOAVW3Z6Dd+yL8bJQOb3pUtAX2o4uVoFd5VCigf3lbI596jbX+bmiG/c7mTu
         sP3QC1Y2Ac3W3RmN5AM5H/AfdCN08v+SsAbKfnaswaC8rUiN9+G6vY6MhXkHYpoE+ZN/
         F1YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709634203; x=1710239003;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pH0qNdvDcbtYm421RfhQxAod4eV9sm4IcyGy9K/hDoU=;
        b=LsbIRLBOC+qtKoV6oqEiM2iTpG3WYMdAgZvgoJl0Is2IG0cnWngxiEJKTE2mpbtpAL
         XtJMF5To82r9lOy4uKDtHkqyONy85Tn0195i6OJmzc2VDN3kXDCngx9RWAPchoWCEIqN
         2kt6qM0MRDVb4KW2+oTk0Q8g14VObXwbF0viXMgmOr1wL60Bu3eolp9XET+I5PWWQeT7
         Skrrm9KJ+PmiCEd8aux38qPTiTW5qHOzErgs6FPmAiITrweh8kYLhQ1ZelEnuO+6jNxN
         PG/tJjmqFDtAsZS9N0th/RJhGtuy0zJ+YieXp9okDtuETvFEapbFvNOta0IsMoroqUmV
         HTsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNn2FRirM30f8YxUQgRlqYro98UKcCOVocUqdTVp5nN8CfdUbpZBM/7rezZCssbH71ES15QT3QJTSwQBZBAq5CEUtXjPiu7dDL/EVk
X-Gm-Message-State: AOJu0YzxgH80mcKPC2u96yDhZWIdlU36wwFHwpuWbZxbk5+qP2M1UON1
	oWHM1M+4yE2zCBke9BOG1+kglzQEHDP/zTyeYHjznji/m57gurKlx9M7HVrXd8M=
X-Google-Smtp-Source: AGHT+IEmW4xhNvYCQRq7z/XW3e5WjGjb5U6gcA5VwQNvde/0sfKrlD5FcAYT9Bvi8rbtFb0Mme++Sw==
X-Received: by 2002:a05:600c:c17:b0:412:ef30:2fc6 with SMTP id fm23-20020a05600c0c1700b00412ef302fc6mr421878wmb.30.1709634202825;
        Tue, 05 Mar 2024 02:23:22 -0800 (PST)
Received: from airbuntu (92.40.185.97.threembb.co.uk. [92.40.185.97])
        by smtp.gmail.com with ESMTPSA id d10-20020a05600c3aca00b00412e8370a93sm3715659wms.27.2024.03.05.02.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 02:23:22 -0800 (PST)
Date: Tue, 5 Mar 2024 10:23:18 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: dietmar.eggemann@arm.com, pierre.gondois@arm.com, mingo@kernel.org,
	peterz@infradead.org, vincent.guittot@linaro.org,
	yu.c.chen@intel.com, linux-kernel@vger.kernel.org,
	nysal@linux.ibm.com, aboorvad@linux.ibm.com, srikar@linux.ibm.com,
	vschneid@redhat.com, morten.rasmussen@arm.com
Subject: Re: [PATCH v4 1/2] sched/fair: Add EAS checks before updating
 overutilized
Message-ID: <20240305102318.6qfib44f2ciffomw@airbuntu>
References: <20240301151725.874604-1-sshegde@linux.ibm.com>
 <20240301151725.874604-2-sshegde@linux.ibm.com>
 <20240303185059.wvjkrrn7liwl4wtv@airbuntu>
 <5c6259a2-fadd-41c6-aa41-91f3af01272c@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5c6259a2-fadd-41c6-aa41-91f3af01272c@linux.ibm.com>

On 03/04/24 13:54, Shrikanth Hegde wrote:
> 
> 
> On 3/4/24 12:20 AM, Qais Yousef wrote:
> > On 03/01/24 20:47, Shrikanth Hegde wrote:
> >> Overutilized field of root domain is only used for EAS(energy aware scheduler)
> 
> [...]
> 
> 
> Hi Qais, Thanks for taking a look. 
> 
> >> ---
> >>  kernel/sched/fair.c | 49 +++++++++++++++++++++++++++------------------
> >>  1 file changed, 30 insertions(+), 19 deletions(-)
> >>
> >> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >> index 6a16129f9a5c..a71f8a1506e4 100644
> >> --- a/kernel/sched/fair.c
> >> +++ b/kernel/sched/fair.c
> >> @@ -6670,15 +6670,29 @@ static inline bool cpu_overutilized(int cpu)
> >>  	return !util_fits_cpu(cpu_util_cfs(cpu), rq_util_min, rq_util_max, cpu);
> >>  }
> >>
> >> -static inline void update_overutilized_status(struct rq *rq)
> >> +static inline void set_rd_overutilized_status(struct root_domain *rd,
> >> +					      unsigned int status)
> >>  {
> >> -	if (!READ_ONCE(rq->rd->overutilized) && cpu_overutilized(rq->cpu)) {
> >> -		WRITE_ONCE(rq->rd->overutilized, SG_OVERUTILIZED);
> >> -		trace_sched_overutilized_tp(rq->rd, SG_OVERUTILIZED);
> >> -	}
> > 
> > Can we add
> > 
> > 	if (!sched_energy_enabled())
> > 		return;
> 
> This is very close to what i had till v2. But it was pointed out that, it 
> would end up calling sched_energy_enabled twice in  check_update_overutilized_status. 

It's a static key. It will either patch the code to be a NOP and return, or
work normally. I don't see a problem.

> In check_update_overutilized_status, it would be better to avoid access to 
> overutilized and computing cpu_overutilized if EAS is not enabled. 

cpu_overutilized() could gain a protection with sched_energy_enabled() too.
I think it's better to encapsulate the deps within the function.

> 
> I am okay with either code. keeping sched_energy_enabled in set_rd_overutilized_status
> would be less code and more readable. But would call sched_energy_enabled twice. 
> 
> Dietmar, Pierre, 
> Could you please provide your inputs here? 

I prefer not sprinkling sched_energy_enabled() for every user. But FWIW the
code looks correct to me and these stylistic issues are not a blocker for me

Reviewed-by: Qais Yousef <qyousef@layalina.io>

> 
> 
> > 
> > here and avoid sprinkling the condition in other various places instead?
> > 
> >> +	WRITE_ONCE(rd->overutilized, status);
> >> +	trace_sched_overutilized_tp(rd, !!status);
> >> +}
> >> +
> >> +static inline void check_update_overutilized_status(struct rq *rq)
> >> +{
> >> +	/*
> >> +	 * overutilized field is used for load balancing decisions only
> >> +	 * if energy aware scheduler is being used
> >> +	 */
> > 
> > nit: I think this comment is unnecessary but I don't mind keeping it
> > 
> >> +	if (!sched_energy_enabled())
> >> +		return;
> >> +
> >> +	if (!READ_ONCE(rq->rd->overutilized) && cpu_overutilized(rq->cpu))
> >> +		set_rd_overutilized_status(rq->rd, SG_OVERUTILIZED);
> >>  }
> >>  #else
> >> -static inline void update_overutilized_status(struct rq *rq) { }
> >> +static inline void check_update_overutilized_status(struct rq *rq) { }
> >> +static inline void set_rd_overutilized_status(struct root_domain *rd,
> >> +					      unsigned int status) { }
> >>  #endif
> >>
> >>  /* Runqueue only has SCHED_IDLE tasks enqueued */
> >> @@ -6779,7 +6793,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> >>  	 * and the following generally works well enough in practice.
> >>  	 */
> >>  	if (!task_new)
> >> -		update_overutilized_status(rq);
> >> +		check_update_overutilized_status(rq);
> >>
> >>  enqueue_throttle:
> >>  	assert_list_leaf_cfs_rq(rq);
> >> @@ -9902,7 +9916,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
> >>  		if (nr_running > 1)
> >>  			*sg_status |= SG_OVERLOAD;
> >>
> >> -		if (cpu_overutilized(i))
> >> +		if (sched_energy_enabled() && cpu_overutilized(i))
> > 
> > I think we can drop sched_energy_enable() here if we add it to
> > set_rd_overutilized_status()
> 
> we can avoid additional call to cpu_overutilized. So we should keep it. 
> 
> > 
> >>  			*sg_status |= SG_OVERUTILIZED;
> >>
> >>  #ifdef CONFIG_NUMA_BALANCING
> >> @@ -10596,19 +10610,16 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
> >>  		env->fbq_type = fbq_classify_group(&sds->busiest_stat);
> >>
> >>  	if (!env->sd->parent) {
> >> -		struct root_domain *rd = env->dst_rq->rd;
> >> -
> >>  		/* update overload indicator if we are at root domain */
> >> -		WRITE_ONCE(rd->overload, sg_status & SG_OVERLOAD);
> >> +		WRITE_ONCE(env->dst_rq->rd->overload, sg_status & SG_OVERLOAD);
> >>
> >>  		/* Update over-utilization (tipping point, U >= 0) indicator */
> >> -		WRITE_ONCE(rd->overutilized, sg_status & SG_OVERUTILIZED);
> >> -		trace_sched_overutilized_tp(rd, sg_status & SG_OVERUTILIZED);
> >> -	} else if (sg_status & SG_OVERUTILIZED) {
> >> -		struct root_domain *rd = env->dst_rq->rd;
> >> -
> >> -		WRITE_ONCE(rd->overutilized, SG_OVERUTILIZED);
> >> -		trace_sched_overutilized_tp(rd, SG_OVERUTILIZED);
> >> +		if (sched_energy_enabled()) {
> > 
> > ditto
> 
> First comment would apply for these two.
> 
> >> +			set_rd_overutilized_status(env->dst_rq->rd,
> >> +						   sg_status & SG_OVERUTILIZED);
> >> +		}
> >> +	} else if (sched_energy_enabled() && (sg_status & SG_OVERUTILIZED)) {
> > 
> > ditto
> > 
> >> +		set_rd_overutilized_status(env->dst_rq->rd, SG_OVERUTILIZED);
> >>  	}
> >>
> >>  	update_idle_cpu_scan(env, sum_util);
> >> @@ -12609,7 +12620,7 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
> >>  		task_tick_numa(rq, curr);
> >>
> >>  	update_misfit_status(curr, rq);
> >> -	update_overutilized_status(task_rq(curr));
> >> +	check_update_overutilized_status(task_rq(curr));
> >>
> >>  	task_tick_core(rq, curr);
> >>  }
> >> --
> >> 2.39.3
> >>

