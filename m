Return-Path: <linux-kernel+bounces-15609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55CA5822EC9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 14:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB32B28512D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 13:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FB51B270;
	Wed,  3 Jan 2024 13:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jSLzNE3w"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B938419BCC
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 13:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-28c23a0df1eso3458135a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 05:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704289275; x=1704894075; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LvuPjU/IgmMeJVXibAVcHoabpAAtu1SyJkkN9yxBvKY=;
        b=jSLzNE3wl2d+5mCzkH116gN/LlHafdn2w7BZcky4QmUcfDv72G50fzQXCZIvx9kcSV
         wMbU5pTBOcn+F4tx/FScEO4SjiD63jJphIXFYnuKowax5rE3VZZgnfbCae5dgNArVzJ8
         HLqDUp9ghfkQvG5TxHLR2n5YPJ2W/Z57RH7zmFWX5qNyJLuwxzfuTGsneZrwAaaqnj6b
         eO8unsalJ4kIs/Js7JoFuh7kxCDBIBwfMGYA9Bp1KScmiweKhDl9lOT4cY/qrgZbjzkd
         4RXbKvGgOEJBVxxqGER0xJaDTHFErelJT/j3Uht/otYsJRPY2bqoBVdM6ILjUqvO5hxh
         vtqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704289275; x=1704894075;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LvuPjU/IgmMeJVXibAVcHoabpAAtu1SyJkkN9yxBvKY=;
        b=hSdgSAcPCHdmHkk0egqxl+V7bpSCdnV7K2v60xy/ov73UbzIl7hkbRpGMSqWmA8bbE
         0syzwIacX7pQIBme44+Dbm8lXV3n8IAjjMkkpvce2GTXNFDfis4zoYumlJZzzjPb54Ev
         y3ks4Mm4HDWz+KVuP4iuzh6Cok5vLq38GwSk0F/Y3iR1cHSQ20R1/6WxP1YljmHUOJut
         PtjJsxvBXOYEZZmFO+1AvRKq27SWyAfvCxI1azQ6vEuQMDHetIUxLTbzdfXchlw/f/vt
         UFdr2pErTYTdmbPZ7Ki6uxSVq/1kQ/LD6T5DbEB2Xc7U//uKzHiWfJZ702adu76d1PGo
         Rlfg==
X-Gm-Message-State: AOJu0YwhBPVUE/zAEEB7fRejnrTcMuW8veWfboYGNWBoXYouI7U06yIo
	uhHrUP3PE2tvJQxfwY1FPa64YFhmZQLezJ0Xg5jFwpMVnQPLjw==
X-Google-Smtp-Source: AGHT+IFgMREW0a+5RgXL5UBvl62QyyRG13LxltUKOAWoZ8mPkanEmqAeA6bEMPIkqbHOKcVM477djGZ8URCoGIJ7l0U=
X-Received: by 2002:a17:90a:df90:b0:28c:146e:31e7 with SMTP id
 p16-20020a17090adf9000b0028c146e31e7mr5428986pjv.0.1704289275013; Wed, 03 Jan
 2024 05:41:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208015242.385103-1-qyousef@layalina.io> <20231208015242.385103-2-qyousef@layalina.io>
 <CAKfTPtAKainBfpPOKTJ21zQmmYw7O0Z0v8utfg=QTBtE1L5O_w@mail.gmail.com>
 <20231212124037.at47izy5xp6lsxh2@airbuntu> <20231229002529.sidy6wxmclhzlzib@airbuntu>
In-Reply-To: <20231229002529.sidy6wxmclhzlzib@airbuntu>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 3 Jan 2024 14:41:03 +0100
Message-ID: <CAKfTPtCu7_Z8RCMeSJGzyu79Af-gypyqLyyWQkuZsMHgnf3CzQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] sched/fair: Be less aggressive in calling cpufreq_update_util()
To: Qais Yousef <qyousef@layalina.io>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>, Wei Wang <wvw@google.com>, 
	Rick Yiu <rickyiu@google.com>, Chung-Kai Mei <chungkai@google.com>, 
	Hongyan Xia <hongyan.xia2@arm.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 29 Dec 2023 at 01:25, Qais Yousef <qyousef@layalina.io> wrote:
>
> On 12/12/23 12:40, Qais Yousef wrote:
> > On 12/12/23 12:06, Vincent Guittot wrote:
> >
> > > > @@ -6772,6 +6737,8 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> > > >  enqueue_throttle:
> > > >         assert_list_leaf_cfs_rq(rq);
> > > >
> > >
> > > Here and in the other places below,  you lose :
> > >
> > >  -       } else if (decayed) {
> > >
> > > The decayed condition ensures a rate limit (~1ms) in the number of
> > > calls to cpufreq_update_util.
> > >
> > > enqueue/dequeue/tick don't create any sudden change in the PELT
> > > signals that would require to update cpufreq of the change unlike
> > > attach/detach
> >
> > Okay, thanks for the clue. Let me rethink this again.
>
> Thinking more about this. Do we really need to send freq updates at
> enqueue/attach etc?

Yes, attach and detach are the 2 events which can make abrupt and
significant changes in the utilization of the CPU.

>
> I did an experiment to remove all the updates except in three places:
>
> 1. Context switch (done unconditionally)
> 2. Tick
> 2. update_blocked_averages()

From the PoV of util_avg, attach, detach, tick and
update_blocked_averages are mandatory events to report to cpufreq to
correctly follow utilization.

>
> I tried the below patch on mac mini with m1 SoC, 6.6 kernel; speedometers
> scores were the same (against this series).
>
> I ran perf bench sched pipe to see if the addition in context switch will make
> things worse
>
> before (this series applied):
>
>         # Running 'sched/pipe' benchmark:
>         # Executed 1000000 pipe operations between two processes
>
>              Total time: 20.505 [sec]
>
>               20.505628 usecs/op
>                   48767 ops/sec
>
> after (proposed patch below applied on top):
>
>         # Running 'sched/pipe' benchmark:
>         # Executed 1000000 pipe operations between two processes
>
>              Total time: 19.475 [sec]
>
>               19.475838 usecs/op
>                   51345 ops/sec
>
> I tried against vanilla kernel (without any patches, including some dependency
> backports) using schedutil governor
>
>         # Running 'sched/pipe' benchmark:
>         # Executed 1000000 pipe operations between two processes
>
>              Total time: 22.428 [sec]
>
>               22.428166 usecs/op
>                   44586 ops/sec
>
> (I got higher run to run variance against this kernel)
>
> So things got better. I think we can actually unify all updates to be at
> context switch and tick for all classes.
>
> The one hole is for long running CFS tasks without context switch; no updates
> until tick this means the dvfs headroom needs to cater for that as worst case
> scenario now. I think this is the behavior today actually; but accidental
> updates due to enqueue/dequeue could have helped to issue more updates. If none
> of that happens, then updating load_avg at entity_tick() is what would have
> triggered a frequency update.
>
> I'm not sure if the blocked average one is required to be honest. But feared
> that when the cpu goes to idle we might miss reducing frequencies vote for that
> CPU - which matters on shared cpufreq policies.
>
> I haven't done comprehensive testing of course. But would love to hear any
> thoughts on how we can be more strategic and reduce the number of cpufreq
> updates we send. And iowait boost state needs to be verified.
>
> While testing this series more I did notice that short kworker context switches
> still can cause the frequency to go high. I traced this back to
> __balance_callbacks() in finish_lock_switch() after calling
> uclamp_context_switch(). So I think we do have a problem of updates being
> 'accidental' and we need to improve the interaction with the governor to be
> more intentional keeping in mind all the constraints we have today in h/w and
> software.
>
> --->8---
>
>
> From 6deed09be1d075afa3858ca62dd54826cdb60d44 Mon Sep 17 00:00:00 2001
> From: Qais Yousef <qyousef@layalina.io>
> Date: Tue, 26 Dec 2023 01:23:57 +0000
> Subject: [PATCH] sched/fair: Update freq on tick and context switch and
>  blocked avgs
>
> Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
> ---
>  kernel/sched/cpufreq_schedutil.c |  3 ---
>  kernel/sched/fair.c              | 13 +------------
>  kernel/sched/sched.h             | 15 +--------------
>  3 files changed, 2 insertions(+), 29 deletions(-)
>
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index c0879a985097..553a3d7f02d8 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -166,9 +166,6 @@ static inline bool ignore_short_tasks(int cpu,
>         struct task_struct *p = cpu_rq(cpu)->curr;
>         unsigned long task_util;
>
> -       if (!(flags & SCHED_CPUFREQ_PERF_HINTS))
> -               return false;
> -
>         if (!fair_policy(p->policy))
>                 return false;
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index d63eae534cec..3a30f78b37d3 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5717,8 +5717,6 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
>         sub_nr_running(rq, task_delta);
>
>  done:
> -       cpufreq_update_util(rq, 0);
> -
>         /*
>          * Note: distribution will already see us throttled via the
>          * throttled-list.  rq->lock protects completion.
> @@ -5811,8 +5809,6 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
>  unthrottle_throttle:
>         assert_list_leaf_cfs_rq(rq);
>
> -       cpufreq_update_util(rq, 0);
> -
>         /* Determine whether we need to wake up potentially idle CPU: */
>         if (rq->curr == rq->idle && rq->cfs.nr_running)
>                 resched_curr(rq);
> @@ -6675,8 +6671,6 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>  enqueue_throttle:
>         assert_list_leaf_cfs_rq(rq);
>
> -       cpufreq_update_util(rq, p->in_iowait ? SCHED_CPUFREQ_IOWAIT : 0);
> -
>         hrtick_update(rq);
>  }
>
> @@ -6754,7 +6748,6 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>
>  dequeue_throttle:
>         util_est_update(&rq->cfs, p, task_sleep);
> -       cpufreq_update_util(rq, 0);
>         hrtick_update(rq);
>  }
>
> @@ -8338,7 +8331,6 @@ done: __maybe_unused;
>
>         update_misfit_status(p, rq);
>         sched_fair_update_stop_tick(rq, p);
> -       cpufreq_update_util(rq, 0);
>
>         return p;
>
> @@ -12460,7 +12452,7 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
>
>         update_misfit_status(curr, rq);
>         update_overutilized_status(task_rq(curr));
> -       cpufreq_update_util(rq, SCHED_CPUFREQ_PERF_HINTS);
> +       cpufreq_update_util(rq, current->in_iowait ? SCHED_CPUFREQ_IOWAIT : 0);
>
>         task_tick_core(rq, curr);
>  }
> @@ -12585,7 +12577,6 @@ static void detach_task_cfs_rq(struct task_struct *p)
>         struct sched_entity *se = &p->se;
>
>         detach_entity_cfs_rq(se);
> -       cpufreq_update_util(task_rq(p), 0);
>  }
>
>  static void attach_task_cfs_rq(struct task_struct *p)
> @@ -12593,7 +12584,6 @@ static void attach_task_cfs_rq(struct task_struct *p)
>         struct sched_entity *se = &p->se;
>
>         attach_entity_cfs_rq(se);
> -       cpufreq_update_util(task_rq(p), 0);
>  }
>
>  static void switched_from_fair(struct rq *rq, struct task_struct *p)
> @@ -12839,7 +12829,6 @@ static int __sched_group_set_shares(struct task_group *tg, unsigned long shares)
>                         update_load_avg(cfs_rq_of(se), se, UPDATE_TG);
>                         update_cfs_group(se);
>                 }
> -               cpufreq_update_util(rq, 0);
>                 rq_unlock_irqrestore(rq, &rf);
>         }
>
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 516187ea2b81..e1622e2b82be 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -3076,20 +3076,7 @@ static inline bool uclamp_rq_is_capped(struct rq *rq)
>  /* Request freq update on context switch if necessary */
>  static inline void uclamp_context_switch(struct rq *rq)
>  {
> -       unsigned long uclamp_min;
> -       unsigned long uclamp_max;
> -       unsigned long util;
> -
> -       /* Only RT and FAIR tasks are aware of uclamp */
> -       if (!rt_policy(current->policy) && !fair_policy(current->policy))
> -               return;
> -
> -       uclamp_min = uclamp_eff_value(current, UCLAMP_MIN);
> -       uclamp_max = uclamp_eff_value(current, UCLAMP_MAX);
> -       util = rq->cfs.avg.util_avg;
> -
> -       if (uclamp_min > util || uclamp_max < util)
> -               cpufreq_update_util(rq, SCHED_CPUFREQ_PERF_HINTS);
> +       cpufreq_update_util(rq, current->in_iowait ? SCHED_CPUFREQ_IOWAIT : 0);
>  }
>  #else /* CONFIG_UCLAMP_TASK */
>  static inline unsigned long uclamp_eff_value(struct task_struct *p,
> --
> 2.40.1
>

