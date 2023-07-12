Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD4C75133B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 00:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbjGLWJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 18:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjGLWJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 18:09:35 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2AA2C0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 15:09:34 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1b52875b8d9so64735ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 15:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689199774; x=1691791774;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yw0T9zbNuq10rVVlXRmmYbnN+fP5VIzpOUeUiL+vExA=;
        b=kAL1oE0ZDRo3o8KKELeOD6vSczgtPl2HcCST4q1hQEKsam4mjxa6l29RyUxBExUSag
         Yx1nTb7ywgDGnrHvsfiQ83pXwmrOtqXefm86EroD117mnK4l1Zbrajv86OuljlzSzGx6
         kKqyAOqSXEA2P7Vko9poRjBUpBCLTVR0r6T2GrMduYBCmeuca8nmVN/Ppv2Uv3hDtWf1
         mWTOKECJ2aiiR9LAKa6QvYqWUj/JphN7JnkT9+/xaK0538yPQHmpIKeZybP5XgbIJphZ
         hORzjJfsrb1R1pOcaKiDPASiuFUhLZUu6RL7V1stGrFpo1y41/C4+KP8DVuqTNaiHwPh
         FppA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689199774; x=1691791774;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yw0T9zbNuq10rVVlXRmmYbnN+fP5VIzpOUeUiL+vExA=;
        b=BCZ3T4ZZ7fDFqHkJsvF8kg8JIV31Vr3ci9oD60/tb+H5nTAtLLirnZZDadOfRBc/Ne
         FUt7u7OwYqjB1pzyVvvDK+HT/nh4yH455Vo97/GTl/+pglbM3vdbD8nyvGIrrFBCyy9/
         MHJnNpkpQcUQ51VCVyAs414tLtVIjTTY6WDPCjSPXJFEbTMYSFqx3R6cg8KwZcIDStNj
         vLyPOnZqXCqOl0bXz6Aonb9WTP2LtbwaIG7SoCdEn79Psc66nF7dC3tZ3zaC+4l/y9cU
         jGcx+t5csi2W7SKa63uZSbSJCIT5Sf6WbZfgzLzGjgQ0nN3j2iXRYoK1iNpZZ4ZjGx1x
         hwjg==
X-Gm-Message-State: ABy/qLaqQC9vo0JSpdgMLRp4qgFwwO5kEbczRg4k63NGygtPsTzmpRzU
        4/+fUtrChleXQwo0PdJDMx6wcA==
X-Google-Smtp-Source: APBJJlEpvAhpN25x30QKTH7hetqpPi35edsbI2ITgIgCPrPvZ/ZYMJYBP3CCRzzf5EBfokNZJyBfiQ==
X-Received: by 2002:a17:902:d2c8:b0:1b8:9551:de55 with SMTP id n8-20020a170902d2c800b001b89551de55mr354467plc.26.1689199774063;
        Wed, 12 Jul 2023 15:09:34 -0700 (PDT)
Received: from bsegall-glaptop.localhost (c-73-158-249-138.hsd1.ca.comcast.net. [73.158.249.138])
        by smtp.gmail.com with ESMTPSA id h21-20020a62b415000000b0067b24701daasm4013740pfn.86.2023.07.12.15.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 15:09:33 -0700 (PDT)
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
Subject: Re: [PATCH v2 1/2] sched, cgroup: Restore meaning to
 hierarchical_quota
References: <20230712133357.381137-1-pauld@redhat.com>
        <20230712133357.381137-2-pauld@redhat.com>
Date:   Wed, 12 Jul 2023 15:09:31 -0700
In-Reply-To: <20230712133357.381137-2-pauld@redhat.com> (Phil Auld's message
        of "Wed, 12 Jul 2023 09:33:56 -0400")
Message-ID: <xm268rbkg4tg.fsf@google.com>
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

> In cgroupv2 cfs_b->hierarchical_quota is set to -1 for all task
> groups due to the previous fix simply taking the min.  It should
> reflect a limit imposed at that level or by an ancestor. Even
> though cgroupv2 does not require child quota to be less than or
> equal to that of its ancestors the task group will still be
> constrained by such a quota so this should be shown here. Cgroupv1
> continues to set this correctly.
>
> In both cases, add initialization when a new task group is created
> based on the current parent's value (or RUNTIME_INF in the case of
> root_task_group). Otherwise, the field is wrong until a quota is
> changed after creation and __cfs_schedulable() is called.
>
> Fixes: c53593e5cb69 ("sched, cgroup: Don't reject lower cpu.max on ancestors")
> Signed-off-by: Phil Auld <pauld@redhat.com>
> Reviewed-by: Ben Segall <bsegall@google.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Tejun Heo <tj@kernel.org>
> ---
>
> v2: Improve comment about how setting hierarchical_quota correctly
>
> helps the scheduler. Remove extra parens.
>  kernel/sched/core.c  | 13 +++++++++----
>  kernel/sched/fair.c  |  7 ++++---
>  kernel/sched/sched.h |  2 +-
>  3 files changed, 14 insertions(+), 8 deletions(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index a68d1276bab0..f80697a79baf 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -9904,7 +9904,7 @@ void __init sched_init(void)
>  		ptr += nr_cpu_ids * sizeof(void **);
>  
>  		root_task_group.shares = ROOT_TASK_GROUP_LOAD;
> -		init_cfs_bandwidth(&root_task_group.cfs_bandwidth);
> +		init_cfs_bandwidth(&root_task_group.cfs_bandwidth, NULL);
>  #endif /* CONFIG_FAIR_GROUP_SCHED */
>  #ifdef CONFIG_RT_GROUP_SCHED
>  		root_task_group.rt_se = (struct sched_rt_entity **)ptr;
> @@ -11038,11 +11038,16 @@ static int tg_cfs_schedulable_down(struct task_group *tg, void *data)
>  
>  		/*
>  		 * Ensure max(child_quota) <= parent_quota.  On cgroup2,
> -		 * always take the min.  On cgroup1, only inherit when no
> -		 * limit is set:
> +		 * always take the non-RUNTIME_INF min.  On cgroup1, only
> +		 * inherit when no limit is set. In cgroup2 this is used
> +		 * by the scheduler to determine if a given CFS task has a
> +		 * bandwidth constraint at some higher level.
>  		 */

It's still used for determining this on cgroup1 (and the cgroup1 code
still works for that), right?

>  		if (cgroup_subsys_on_dfl(cpu_cgrp_subsys)) {
> -			quota = min(quota, parent_quota);
> +			if (quota == RUNTIME_INF)
> +				quota = parent_quota;
> +			else if (parent_quota != RUNTIME_INF)
> +				quota = min(quota, parent_quota);
>  		} else {
>  			if (quota == RUNTIME_INF)
>  				quota = parent_quota;
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 373ff5f55884..d9b3d4617e16 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6005,13 +6005,14 @@ static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
>  	return idle ? HRTIMER_NORESTART : HRTIMER_RESTART;
>  }
>  
> -void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
> +void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b, struct cfs_bandwidth *parent)
>  {
>  	raw_spin_lock_init(&cfs_b->lock);
>  	cfs_b->runtime = 0;
>  	cfs_b->quota = RUNTIME_INF;
>  	cfs_b->period = ns_to_ktime(default_cfs_period());
>  	cfs_b->burst = 0;
> +	cfs_b->hierarchical_quota = parent ? parent->hierarchical_quota : RUNTIME_INF;
>  
>  	INIT_LIST_HEAD(&cfs_b->throttled_cfs_rq);
>  	hrtimer_init(&cfs_b->period_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED);
> @@ -6168,7 +6169,7 @@ static inline int throttled_lb_pair(struct task_group *tg,
>  	return 0;
>  }
>  
> -void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b) {}
> +void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b, struct cfs_bandwidth *parent) {}
>  
>  #ifdef CONFIG_FAIR_GROUP_SCHED
>  static void init_cfs_rq_runtime(struct cfs_rq *cfs_rq) {}
> @@ -12373,7 +12374,7 @@ int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
>  
>  	tg->shares = NICE_0_LOAD;
>  
> -	init_cfs_bandwidth(tg_cfs_bandwidth(tg));
> +	init_cfs_bandwidth(tg_cfs_bandwidth(tg), tg_cfs_bandwidth(parent));
>  
>  	for_each_possible_cpu(i) {
>  		cfs_rq = kzalloc_node(sizeof(struct cfs_rq),
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index ec7b3e0a2b20..63822c9238cc 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -460,7 +460,7 @@ extern void unregister_fair_sched_group(struct task_group *tg);
>  extern void init_tg_cfs_entry(struct task_group *tg, struct cfs_rq *cfs_rq,
>  			struct sched_entity *se, int cpu,
>  			struct sched_entity *parent);
> -extern void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b);
> +extern void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b, struct cfs_bandwidth *parent);
>  
>  extern void __refill_cfs_bandwidth_runtime(struct cfs_bandwidth *cfs_b);
>  extern void start_cfs_bandwidth(struct cfs_bandwidth *cfs_b);
