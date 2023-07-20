Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4C775A7F8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 09:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbjGTHjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 03:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGTHjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 03:39:14 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A31C210C
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 00:39:12 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f9fdb0ef35so727944e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 00:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689838751; x=1690443551;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PUmEP4NMtoq7hfewJPHlF9PBem9bbM0Vzi1CRs7wseI=;
        b=XiJLGtw3WDu65WrFrhiYek3AIqVVvyDKhga/VWmRlUWL/2QPtMHzj1o+qqjE2Ez8rl
         9u6PZuLiFGm9zZVGS3cFDUdXsFnhmL9D5dbAOs1bUEYuc/6QeITuo5Xmee6wr3KBNC9t
         +0ShCwn26bRBCeWNgtDTg18bcN1CpYF65aHVOE3X+cQfeKQx6bK8EYESI7yPxOPxmbsq
         ttwaUk42lUPa/kzbWpyggqpLLZ+kl/VZsuAIxDtYeLjcqXOzduhwH6DGshnAEtY2XL7w
         n9Dtk7kLwqMsy+bdp4Xfr9zN4ydCzxE2aXdNU0VHdAyPRUTuadXvbjojAaAL5Ju326QJ
         KexQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689838751; x=1690443551;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PUmEP4NMtoq7hfewJPHlF9PBem9bbM0Vzi1CRs7wseI=;
        b=i0gpYbmmabyB46rH2D930iY/GtT1yqpsD15XFaJlAr7PuCBsXTDul/B2Ysp+/tvOxb
         TZ0eVMJYMxS/JuM1xMgmPpWSP6kW8RJCdS7VJFClICzwkBuE7wpLosHZjhJTO3rL1rFy
         CUUmLGL4nzCGjyjro7Xyx9nPYK2g+/i/Kshah4Lkchomaa04G1g7xtkxi/hcj2jEhDNJ
         6N/J0I2Izt/sVXitnx4hetBJ7Moof4SgySisJW3Km9UXxFzOS86r+BVcOB3Sjl6MlqZt
         aO3hlvlRcDuY9h0ZjtmGemEjBHel3YJez5boi9YBL8bRdwGQKQpLP260wKUdJg5YNjX2
         nS9A==
X-Gm-Message-State: ABy/qLZVva3X8Ou2kZTsYuaxKlDbKoJ/K/ISDmcMs1ACy2EhVr1OycZ1
        T02lGlQjSjW9Wg2RWEWt9ftQDU9xk1wjXV3oCGchXQ==
X-Google-Smtp-Source: APBJJlHqEx7+IrH9sIrlLTZHgYVJpquwsGGRD3I0EXug6D8sWA6PuJSNjNhZYHUb7jDbjTvFd6ZePGwORtWkePjtE7k=
X-Received: by 2002:a05:6512:3083:b0:4fd:cc8c:54e5 with SMTP id
 z3-20020a056512308300b004fdcc8c54e5mr963170lfd.41.1689838750704; Thu, 20 Jul
 2023 00:39:10 -0700 (PDT)
MIME-Version: 1.0
References: <80956e8f-761e-b74-1c7a-3966f9e8d934@linutronix.de>
In-Reply-To: <80956e8f-761e-b74-1c7a-3966f9e8d934@linutronix.de>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 20 Jul 2023 09:38:59 +0200
Message-ID: <CAKfTPtCSsLz+qD-xUnm4N1HyZqtQD+rYVagnSur+hfUHEk0sYg@mail.gmail.com>
Subject: Re: Stopping the tick on a fully loaded system
To:     Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jul 2023 at 08:51, Anna-Maria Behnsen
<anna-maria@linutronix.de> wrote:
>
> Hi,
>
> during tests of the timer pull model, Gautham observed regressions under
> load. With the timer pull model in place, going idle is more expensive. My
> naive assumption, that a system which is fully loaded will not go idle was
> simply wrong. Under a fully loaded system (top shows ~1% idle), some CPUs
> go idle and stop the tick for several us and come back to work and this
> heavily repeats.
>
> Peter and tglx helped me to track it down to find the reason: The governor
> which decides if the tick will be stopped only looks at the next timer but
> does not take into account how busy the system is. Here Peter pointed to
> the scheduler avg_idle value.
>
> Beside the existing avg_idle, I introduced really_avg_idle which is not
> limited to twice max_idle_balance_cost but also updated in
> ttwu_do_activate() when avg_idle is updated.
>
> With tracing, I was able to see that in the fully loaded case, 75%-80% of
> the idle periods have been shorter than the really_avg_idle value. (trace
> printk of really_avg_idle values directly at the begin of
> tick_nohz_next_event(); enabling sched_wakeup tracepoint; take the delta
> between the timestamps of the first and the latter as idle time).
>
> A generalized approach to prevent going idle, when the system is loaded,
> would be to add a check how busy the system is to tick_nohz_next_event().

Would it be better to let the cpuidle governor decide whether to stop
or not the tick instead ?
With your change, tick_nohz_next_event() becomes an random value which
might return something else than the real next event

you might me interested by this:
https://lore.kernel.org/all/20230105145159.1089531-1-kajetan.puchalski@arm.com/

They use cpu utilization to stay in shallow c-states some of which
don't stop the tick. Maybe you extend this to make sure to not stop
the tick for high load

>
> In my PoC (find it at the end) it's simply checked whether the
> really_avg_idle value is smaller than TICK_NSEC. It's not possible to use
> the existing avg_idle value as it is always smaller than TICK_NSEC on 250HZ
> systems. But there regressions occur under load and the standard deviation
> of the test results were in the same range as the regression (between 5 and
> 10%).
>
> So I wanted to understand the avg_idle values and examined the distribution
> with different load scenarios. There my next naive assumption was, that
> under load mainly short values will be seen. This is true, when the system
> is halfway loaded (top shows ~50% idle). But when the system is fully
> loaded, the avg_idle values are no longer 'focused' on small values.

avg_idle is broken for what you want to do. It is updated only when
you leave an idle state which means that it stays stuck to the old avg
idle time when your system is fully busy

>
> Here I stopped and started to write the mail. I don't know the reason for
> the distribution under load and I also don't know if the idea of checking
> the system load in tick_nohz_next_event() is good or not. And last but not
> least, scheduler is a closed book for me...

IMO, this is a job for cpuidle governor which decide to stop or not
the tick when selecting an idle state

>
> Thanks,
>
>         Anna-Maria
>
> ---8<---
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -2307,6 +2307,7 @@ static inline bool owner_on_cpu(struct t
>
>  /* Returns effective CPU energy utilization, as seen by the scheduler */
>  unsigned long sched_cpu_util(int cpu);
> +u64 sched_cpu_really_avg_idle(int cpu);
>  #endif /* CONFIG_SMP */
>
>  #ifdef CONFIG_RSEQ
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3753,6 +3753,7 @@ ttwu_do_activate(struct rq *rq, struct t
>                 u64 max = 2*rq->max_idle_balance_cost;
>
>                 update_avg(&rq->avg_idle, delta);
> +               update_avg(&rq->really_avg_idle, delta);
>
>                 if (rq->avg_idle > max)
>                         rq->avg_idle = max;
> @@ -7455,6 +7456,12 @@ unsigned long sched_cpu_util(int cpu)
>  {
>         return effective_cpu_util(cpu, cpu_util_cfs(cpu), ENERGY_UTIL, NULL);
>  }
> +
> +u64 sched_cpu_really_avg_idle(int cpu)
> +{
> +       struct rq *rq = cpu_rq(cpu);
> +       return rq->really_avg_idle;
> +}
>  #endif /* CONFIG_SMP */
>
>  /**
> @@ -9988,6 +9995,7 @@ void __init sched_init(void)
>                 rq->online = 0;
>                 rq->idle_stamp = 0;
>                 rq->avg_idle = 2*sysctl_sched_migration_cost;
> +               rq->really_avg_idle = 2*sysctl_sched_migration_cost;
>                 rq->wake_stamp = jiffies;
>                 rq->wake_avg_idle = rq->avg_idle;
>                 rq->max_idle_balance_cost = sysctl_sched_migration_cost;
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1073,6 +1073,7 @@ struct rq {
>  #endif
>         u64                     idle_stamp;
>         u64                     avg_idle;
> +       u64                     really_avg_idle;
>
>         unsigned long           wake_stamp;
>         u64                     wake_avg_idle;
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -800,7 +800,7 @@ static inline bool local_timer_softirq_p
>
>  static ktime_t tick_nohz_next_event(struct tick_sched *ts, int cpu)
>  {
> -       u64 basemono, next_tick, delta, expires;
> +       u64 basemono, next_tick, delta, expires, sched_avg_idle;
>         unsigned long basejiff;
>         unsigned int seq;
>
> @@ -823,8 +823,11 @@ static ktime_t tick_nohz_next_event(stru
>          * minimal delta which brings us back to this place
>          * immediately. Lather, rinse and repeat...
>          */
> -       if (rcu_needs_cpu() || arch_needs_cpu() ||
> -           irq_work_needs_cpu() || local_timer_softirq_pending()) {
> +       sched_avg_idle = sched_cpu_really_avg_idle(cpu);
> +       if (sched_avg_idle <= (u64)TICK_NSEC) {
> +               next_tick = basemono + sched_avg_idle;
> +       } else if (rcu_needs_cpu() || arch_needs_cpu() ||
> +                  irq_work_needs_cpu() || local_timer_softirq_pending()) {
>                 next_tick = basemono + TICK_NSEC;
>         } else {
>                 /*
