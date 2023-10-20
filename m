Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 371C27D1179
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 16:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377537AbjJTOX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 10:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377499AbjJTOXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 10:23:52 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10EF2D53
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 07:23:50 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6be1bc5aa1cso794043b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 07:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697811829; x=1698416629; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kPSg6YbAJ9dydtHDvFmYfqGSuz9Cya55UUtEzlaAeGQ=;
        b=nIQykx6Pv0dgbLP1DL4jSV1xWIguGaR4S0hdH5bEB4w3K0SeXc/lfP8G3C2a9gGAFG
         1s+8uA0ei6PgykbtrJqvlhIy/69fSGQqwsF96qhx2fNptiNABfUrnaN8z+TGBGOtgheD
         mupQ58rQmXbyHpx19TDrDvjcyX0nGdmqzax5k2Te9Zy+r72F1RQKCX+JO4Wct7AknQvP
         GvKKQAlh9tqb4jZiYGb0CluAlgw7I3w5C/YgvF7/8+kYGL7irFumDaJxg6JeJdaRWGjN
         h9rbLkpDgw2TJj516ZJoOowvPSObeVPpqgNw6+gjFWFu2M1RdSdeZIe8XF72ygGs6S2K
         UmVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697811829; x=1698416629;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kPSg6YbAJ9dydtHDvFmYfqGSuz9Cya55UUtEzlaAeGQ=;
        b=hu1RCQNdNxaMOw/06ykWc07bJXhC4ov85qTLtUZoeN0SRYt50K/pu86+kBDHBkTKY3
         2ka3O54LtgJR+KxkTAnOD/eCp20ZOeqcTWYwRfrrectCpEoBMc1fObmtwf6CjadEcWOI
         3oSKcgsK+mqxQmU/zDCw9y6UitBqC38Nu5epmo4pObl6jJky60zdGT+VbM1shVdvWPrq
         tcBgBc0dBtBwL6AvPXIqQGtUjwWGQ7h1QhHMD1u5fIJTFynrxINZckbDv6PVHGCjmWaO
         O4Vl/o4kblbIn97MoDnV9uYfcrWzN+xuD/6UnIOzTCikYgQdLN+20dhEYSMG07a/YVtj
         Wg0A==
X-Gm-Message-State: AOJu0YwI+E1gMhfdykDBX+DMuURwsYz9EtrazgjiexC9YSJmltLJ2r4L
        JKwE/7eSKwQezxztsJf9OhX4qr96/toKgvpJtqy10g==
X-Google-Smtp-Source: AGHT+IGmNpNuiYoq0oRxDLUNVlBI4C4N9PoMg8NRK8iCd/hrtqwOmUnDLraW7ovfvvq8U3IKpTbI1RF7h7I3hV0qwgA=
X-Received: by 2002:a05:6a21:1a1:b0:17b:6ef4:6897 with SMTP id
 le33-20020a056a2101a100b0017b6ef46897mr2279836pzb.2.1697811829508; Fri, 20
 Oct 2023 07:23:49 -0700 (PDT)
MIME-Version: 1.0
References: <20231019033323.54147-1-yangyicong@huawei.com> <20231020134337.GD33965@noisy.programming.kicks-ass.net>
In-Reply-To: <20231020134337.GD33965@noisy.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 20 Oct 2023 16:23:38 +0200
Message-ID: <CAKfTPtB=rc3qdFmZM-L_i64YhSytK5k1GitmKeRSbqKPzXOcJA@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Remove SIS_PROP
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Yicong Yang <yangyicong@huawei.com>, mingo@redhat.com,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        tim.c.chen@linux.intel.com, yu.c.chen@intel.com,
        gautham.shenoy@amd.com, mgorman@suse.de, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        prime.zeng@huawei.com, yangyicong@hisilicon.com,
        jonathan.cameron@huawei.com, ego@linux.vnet.ibm.com,
        srikar@linux.vnet.ibm.com, linuxarm@huawei.com, 21cnbao@gmail.com,
        kprateek.nayak@amd.com, wuyun.abel@bytedance.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Oct 2023 at 15:44, Peter Zijlstra <peterz@infradead.org> wrote:
>
>
>
> Since this had me looking at all that code, I did the below.
>
> Holler if there's objections etc..
>
> ---
> Subject: sched/fair: Remove SIS_PROP
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Fri Oct 20 12:35:33 CEST 2023
>
> SIS_UTIL seems to work well, lets remove the old thing.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Acked-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  include/linux/sched/topology.h |    2 -
>  kernel/sched/core.c            |    5 ----
>  kernel/sched/fair.c            |   48 -----------------------------------------
>  kernel/sched/features.h        |    1
>  kernel/sched/sched.h           |    3 --
>  5 files changed, 59 deletions(-)
>
> --- a/include/linux/sched/topology.h
> +++ b/include/linux/sched/topology.h
> @@ -109,8 +109,6 @@ struct sched_domain {
>         u64 max_newidle_lb_cost;
>         unsigned long last_decay_max_lb_cost;
>
> -       u64 avg_scan_cost;              /* select_idle_sibling */
> -
>  #ifdef CONFIG_SCHEDSTATS
>         /* load_balance() stats */
>         unsigned int lb_count[CPU_MAX_IDLE_TYPES];
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3792,9 +3792,6 @@ ttwu_do_activate(struct rq *rq, struct t
>                 if (rq->avg_idle > max)
>                         rq->avg_idle = max;
>
> -               rq->wake_stamp = jiffies;
> -               rq->wake_avg_idle = rq->avg_idle / 2;
> -
>                 rq->idle_stamp = 0;
>         }
>  #endif
> @@ -9991,8 +9988,6 @@ void __init sched_init(void)
>                 rq->online = 0;
>                 rq->idle_stamp = 0;
>                 rq->avg_idle = 2*sysctl_sched_migration_cost;
> -               rq->wake_stamp = jiffies;
> -               rq->wake_avg_idle = rq->avg_idle;
>                 rq->max_idle_balance_cost = sysctl_sched_migration_cost;
>
>                 INIT_LIST_HEAD(&rq->cfs_tasks);
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7209,45 +7209,9 @@ static int select_idle_cpu(struct task_s
>         struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_rq_mask);
>         int i, cpu, idle_cpu = -1, nr = INT_MAX;
>         struct sched_domain_shared *sd_share;
> -       struct rq *this_rq = this_rq();
> -       int this = smp_processor_id();
> -       struct sched_domain *this_sd = NULL;
> -       u64 time = 0;
>
>         cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
>
> -       if (sched_feat(SIS_PROP) && !has_idle_core) {
> -               u64 avg_cost, avg_idle, span_avg;
> -               unsigned long now = jiffies;
> -
> -               this_sd = rcu_dereference(*this_cpu_ptr(&sd_llc));
> -               if (!this_sd)
> -                       return -1;
> -
> -               /*
> -                * If we're busy, the assumption that the last idle period
> -                * predicts the future is flawed; age away the remaining
> -                * predicted idle time.
> -                */
> -               if (unlikely(this_rq->wake_stamp < now)) {
> -                       while (this_rq->wake_stamp < now && this_rq->wake_avg_idle) {
> -                               this_rq->wake_stamp++;
> -                               this_rq->wake_avg_idle >>= 1;
> -                       }
> -               }
> -
> -               avg_idle = this_rq->wake_avg_idle;
> -               avg_cost = this_sd->avg_scan_cost + 1;
> -
> -               span_avg = sd->span_weight * avg_idle;
> -               if (span_avg > 4*avg_cost)
> -                       nr = div_u64(span_avg, avg_cost);
> -               else
> -                       nr = 4;
> -
> -               time = cpu_clock(this);
> -       }
> -
>         if (sched_feat(SIS_UTIL)) {
>                 sd_share = rcu_dereference(per_cpu(sd_llc_shared, target));
>                 if (sd_share) {
> @@ -7301,18 +7265,6 @@ static int select_idle_cpu(struct task_s
>         if (has_idle_core)
>                 set_idle_cores(target, false);
>
> -       if (sched_feat(SIS_PROP) && this_sd && !has_idle_core) {
> -               time = cpu_clock(this) - time;
> -
> -               /*
> -                * Account for the scan cost of wakeups against the average
> -                * idle time.
> -                */
> -               this_rq->wake_avg_idle -= min(this_rq->wake_avg_idle, time);
> -
> -               update_avg(&this_sd->avg_scan_cost, time);
> -       }
> -
>         return idle_cpu;
>  }
>
> --- a/kernel/sched/features.h
> +++ b/kernel/sched/features.h
> @@ -49,7 +49,6 @@ SCHED_FEAT(TTWU_QUEUE, true)
>  /*
>   * When doing wakeups, attempt to limit superfluous scans of the LLC domain.
>   */
> -SCHED_FEAT(SIS_PROP, false)
>  SCHED_FEAT(SIS_UTIL, true)
>
>  /*
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1059,9 +1059,6 @@ struct rq {
>         u64                     idle_stamp;
>         u64                     avg_idle;
>
> -       unsigned long           wake_stamp;
> -       u64                     wake_avg_idle;
> -
>         /* This is used to determine avg_idle's max value */
>         u64                     max_idle_balance_cost;
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
