Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E206975133E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 00:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232370AbjGLWLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 18:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjGLWLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 18:11:37 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9177CC0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 15:11:35 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b9ed206018so31175ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 15:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689199895; x=1691791895;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sjZpZfw6zMe+zVTA1zNJcRXQWvdmc1Ro3Swndjb5BXM=;
        b=thDxK8pxeHdDVdSEwFlckAHU+nH9DfDSHvR8IbWZC6Oi+bhPHZjuqjdyv87US11sBj
         X2I0oAxR35+oX4+MAxQ45K4ZR6CJUISfCZEWsMSjkoqlaugz8Djd0+IwtpLUUoL7q3ks
         YHDe5ZIcPvGummnrmMuG1KiBwV9gWY/ac3PbzNJxA5m+jdwSec8vbfR35QrzSwqVZQOs
         fRFgNXADaiWpODBmfQvLKc+16osI5gvrdVphp+23o8HaQH/FwE7dKNdjB1C2xrYZ2nd4
         f+Y0NlNasV6tNAZ+LfrsMrb20juk+bl0/8MeKxumxPF1IyJIXl16KdurwInqmOwR7/K0
         D4ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689199895; x=1691791895;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sjZpZfw6zMe+zVTA1zNJcRXQWvdmc1Ro3Swndjb5BXM=;
        b=E3KMWKfSYxhDLEQi0PpZYJV1LbIIJD+uj4s23G+ODxGfcrZg5wLjn54RqLRLGTBAVm
         oLOqgEqjFR2y6JbRNpP4eac+6kn2S7HAr0SkOdySwHBkZtDuKp8WT/zCVSw1c5og0Xr8
         5FrMa1CrFeRW7qUrjtGA4tqkIDgeyxomfUyf5l/+zkw/EhOjxOWnD65lXvTSyRSgzK6M
         n1XartYuEZiX2iCjKmBWnKaBjwQ7ftdfPWRbnsUMZAmI2L6O6yFSH2yKzektvePBwvZj
         U0kVAM/vonn+kO/DE5zRRXf6LOfVK9/bhYR2kG9wwp7lcKh8jDDxuDppD/jPB94k4Wb8
         NyqQ==
X-Gm-Message-State: ABy/qLaSTWxLJ2J6CSNrCPwmIxpPnDrA0/hWLnnZ8O3hBP/OaXk47nxu
        /CuURrT1yXtpPKLoHGJwTotk/g==
X-Google-Smtp-Source: APBJJlFwXK91c9zYUg1Dpl3t6/Er1YjRVqGLR7+7r+vBSGr3fHGAvpAopYDUOtWT5HQhzj0Y68Zumw==
X-Received: by 2002:a17:902:e54b:b0:1b8:5216:bfd2 with SMTP id n11-20020a170902e54b00b001b85216bfd2mr296365plf.11.1689199894909;
        Wed, 12 Jul 2023 15:11:34 -0700 (PDT)
Received: from bsegall-glaptop.localhost (c-73-158-249-138.hsd1.ca.comcast.net. [73.158.249.138])
        by smtp.gmail.com with ESMTPSA id s3-20020a170902a50300b001afd821c057sm4460754plq.58.2023.07.12.15.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 15:11:34 -0700 (PDT)
From:   Benjamin Segall <bsegall@google.com>
To:     Phil Auld <pauld@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v6 2/2] Sched/fair: Block nohz tick_stop when cfs
 bandwidth in use
References: <20230712133357.381137-1-pauld@redhat.com>
        <20230712133357.381137-3-pauld@redhat.com>
Date:   Wed, 12 Jul 2023 15:11:32 -0700
In-Reply-To: <20230712133357.381137-3-pauld@redhat.com> (Phil Auld's message
        of "Wed, 12 Jul 2023 09:33:57 -0400")
Message-ID: <xm264jm8g4q3.fsf@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Phil Auld <pauld@redhat.com> writes:

> CFS bandwidth limits and NOHZ full don't play well together.  Tasks
> can easily run well past their quotas before a remote tick does
> accounting.  This leads to long, multi-period stalls before such
> tasks can run again. Currently, when presented with these conflicting
> requirements the scheduler is favoring nohz_full and letting the tick
> be stopped. However, nohz tick stopping is already best-effort, there
> are a number of conditions that can prevent it, whereas cfs runtime
> bandwidth is expected to be enforced.
>
> Make the scheduler favor bandwidth over stopping the tick by setting
> TICK_DEP_BIT_SCHED when the only running task is a cfs task with
> runtime limit enabled. We use cfs_b->hierarchical_quota to
> determine if the task requires the tick.
>
> Add check in pick_next_task_fair() as well since that is where
> we have a handle on the task that is actually going to be running.
>
> Add check in sched_can_stop_tick() to cover some edge cases such
> as nr_running going from 2->1 and the 1 remains the running task.
>
> Add sched_feat HZ_BW (off by default) to control the tick_stop
> behavior.

I think this looks good now.
Reviewed-By: Ben Segall <bsegall@google.com>

>
> Signed-off-by: Phil Auld <pauld@redhat.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> ---
> v6: restore check for fair_sched_class
>
> v5: Reworked checks to use newly-fixed cfs_b->hierarchical_quota to
> check for bw
> constraints. 
>
> v4: Made checks for runtime_enabled hierarchical. 
>
> v3: Moved sched_cfs_bandwidth_active() prototype to sched.h outside of
> guards to
> silence -Wmissing-prototypes.
>
> v2:  Ben pointed out that the bit could get cleared in the dequeue path
> if we migrate a newly enqueued task without preempting curr. Added a
> check for that edge case to sched_can_stop_tick. Removed the call to
> sched_can_stop_tick from sched_fair_update_stop_tick since it was
> redundant.
>
>  kernel/sched/core.c     | 26 ++++++++++++++++++++++
>  kernel/sched/fair.c     | 49 +++++++++++++++++++++++++++++++++++++++++
>  kernel/sched/features.h |  2 ++
>  kernel/sched/sched.h    |  1 +
>  4 files changed, 78 insertions(+)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index f80697a79baf..8a2ed4c0b709 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1194,6 +1194,20 @@ static void nohz_csd_func(void *info)
>  #endif /* CONFIG_NO_HZ_COMMON */
>  
>  #ifdef CONFIG_NO_HZ_FULL
> +static inline bool __need_bw_check(struct rq *rq, struct task_struct *p)
> +{
> +	if (rq->nr_running != 1)
> +		return false;
> +
> +	if (p->sched_class != &fair_sched_class)
> +		return false;
> +
> +	if (!task_on_rq_queued(p))
> +		return false;
> +
> +	return true;
> +}
> +
>  bool sched_can_stop_tick(struct rq *rq)
>  {
>  	int fifo_nr_running;
> @@ -1229,6 +1243,18 @@ bool sched_can_stop_tick(struct rq *rq)
>  	if (rq->nr_running > 1)
>  		return false;
>  
> +	/*
> +	 * If there is one task and it has CFS runtime bandwidth constraints
> +	 * and it's on the cpu now we don't want to stop the tick.
> +	 * This check prevents clearing the bit if a newly enqueued task here is
> +	 * dequeued by migrating while the constrained task continues to run.
> +	 * E.g. going from 2->1 without going through pick_next_task().
> +	 */
> +	if (sched_feat(HZ_BW) && __need_bw_check(rq, rq->curr)) {
> +		if (cfs_task_bw_constrained(rq->curr))
> +			return false;
> +	}
> +
>  	return true;
>  }
>  #endif /* CONFIG_NO_HZ_FULL */
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index d9b3d4617e16..acd9f317aad1 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6140,6 +6140,46 @@ static void __maybe_unused unthrottle_offline_cfs_rqs(struct rq *rq)
>  	rcu_read_unlock();
>  }
>  
> +bool cfs_task_bw_constrained(struct task_struct *p)
> +{
> +	struct cfs_rq *cfs_rq = task_cfs_rq(p);
> +
> +	if (!cfs_bandwidth_used())
> +		return false;
> +
> +	if (cfs_rq->runtime_enabled ||
> +	    tg_cfs_bandwidth(cfs_rq->tg)->hierarchical_quota != RUNTIME_INF)
> +		return true;
> +
> +	return false;
> +}
> +
> +#ifdef CONFIG_NO_HZ_FULL
> +/* called from pick_next_task_fair() */
> +static void sched_fair_update_stop_tick(struct rq *rq, struct task_struct *p)
> +{
> +	int cpu = cpu_of(rq);
> +
> +	if (!sched_feat(HZ_BW) || !cfs_bandwidth_used())
> +		return;
> +
> +	if (!tick_nohz_full_cpu(cpu))
> +		return;
> +
> +	if (rq->nr_running != 1)
> +		return;
> +
> +	/*
> +	 *  We know there is only one task runnable and we've just picked it. The
> +	 *  normal enqueue path will have cleared TICK_DEP_BIT_SCHED if we will
> +	 *  be otherwise able to stop the tick. Just need to check if we are using
> +	 *  bandwidth control.
> +	 */
> +	if (cfs_task_bw_constrained(p))
> +		tick_nohz_dep_set_cpu(cpu, TICK_DEP_BIT_SCHED);
> +}
> +#endif
> +
>  #else /* CONFIG_CFS_BANDWIDTH */
>  
>  static inline bool cfs_bandwidth_used(void)
> @@ -6182,9 +6222,17 @@ static inline struct cfs_bandwidth *tg_cfs_bandwidth(struct task_group *tg)
>  static inline void destroy_cfs_bandwidth(struct cfs_bandwidth *cfs_b) {}
>  static inline void update_runtime_enabled(struct rq *rq) {}
>  static inline void unthrottle_offline_cfs_rqs(struct rq *rq) {}
> +bool cfs_task_bw_constrained(struct task_struct *p)
> +{
> +	return false;
> +}
>  
>  #endif /* CONFIG_CFS_BANDWIDTH */
>  
> +#if !defined(CONFIG_CFS_BANDWIDTH) || !defined(CONFIG_NO_HZ_FULL)
> +static inline void sched_fair_update_stop_tick(struct rq *rq, struct task_struct *p) {}
> +#endif
> +
>  /**************************************************
>   * CFS operations on tasks:
>   */
> @@ -8098,6 +8146,7 @@ done: __maybe_unused;
>  		hrtick_start_fair(rq, p);
>  
>  	update_misfit_status(p, rq);
> +	sched_fair_update_stop_tick(rq, p);
>  
>  	return p;
>  
> diff --git a/kernel/sched/features.h b/kernel/sched/features.h
> index ee7f23c76bd3..6fdf1fdf6b17 100644
> --- a/kernel/sched/features.h
> +++ b/kernel/sched/features.h
> @@ -101,3 +101,5 @@ SCHED_FEAT(LATENCY_WARN, false)
>  
>  SCHED_FEAT(ALT_PERIOD, true)
>  SCHED_FEAT(BASE_SLICE, true)
> +
> +SCHED_FEAT(HZ_BW, false)
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 63822c9238cc..d6d346bc78aa 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -465,6 +465,7 @@ extern void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b, struct cfs_bandwidth
>  extern void __refill_cfs_bandwidth_runtime(struct cfs_bandwidth *cfs_b);
>  extern void start_cfs_bandwidth(struct cfs_bandwidth *cfs_b);
>  extern void unthrottle_cfs_rq(struct cfs_rq *cfs_rq);
> +extern bool cfs_task_bw_constrained(struct task_struct *p);
>  
>  extern void init_tg_rt_entry(struct task_group *tg, struct rt_rq *rt_rq,
>  		struct sched_rt_entity *rt_se, int cpu,
