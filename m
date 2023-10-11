Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3DD57C4748
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 03:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344653AbjJKBaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 21:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344633AbjJKBaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 21:30:01 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA45593
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 18:29:58 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id ada2fe7eead31-45289a987ddso2266722137.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 18:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696987798; x=1697592598; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lWuFBKKqDhyH9ygjY+VwyypVN7up/CrH54/6kzMnugU=;
        b=QyJTGLqLeoOB+O1GSHja5tPQojfB2TRfv7pzcTPvTwlY/94sgg8q7LpHWRG3wq8OMN
         7GILwoq7HG55XkSLjDv9Kf8wNBMx/iuEzRIIUOQNM0kIre7gLOS6ZgDuIcjMn7dZA3z5
         ZKFae8gsWPprB9qNWn+4EX0KCScRl/jm53KYx5X/Vd8FHKUzrG1vfUMNjJS+783oLJZM
         ZArZB4MmVdXy8j5VBJZ6Y4cX8j2Y552dN8oZETSezXgdZEm6u2eQf+6TkCN7HRFkKI9H
         Plo3Nodj1fs8FvBmlXXEoIVBBBVgXxNkiMV52xwREDQisEsjVcpH1FQTBxhpC3FGzC25
         qz8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696987798; x=1697592598;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lWuFBKKqDhyH9ygjY+VwyypVN7up/CrH54/6kzMnugU=;
        b=AXfo2I5sffYYYnpQWuow1AiJPYhw1r77QH7bHk3U6nkYzlHXgJnyWwEUqklfvaSb8/
         HHvGz3q7ZtBi865vQOG0nh9sfWilnbxwKLOyWA6jfce+BY8FkhQGGl7sdP03Pf4CZ14z
         LrPXDlwex3kh7HESLRxHOlqx+j19EuRHQqhPLcfX0OexTjLXu14O8aYaApGz2Qa2uHPV
         6mJX6PZEM9bQD8qjLia8xcWSB606PPBpiL/QL5aCmpbCNyUcsaCKuxfHLfY/qndtnsYN
         N7CEU5bMjJH32q1jROX11Srsb3uvMaWShJ8sczEjp/6BXAgTqre6oe7XS5ofdnjFvlX1
         CYRg==
X-Gm-Message-State: AOJu0YxR1yrO4zvYpud9JvTwPuupvTeCrOM0AaXSYtfVp3LQ13djIp5j
        +DmNK1RTG/OG6RrAjMW40G4ZtIf6asFfUIJQG6sjumqmvQosQpmAMR8=
X-Google-Smtp-Source: AGHT+IFCWB/Ae+449zxX31uUmJSvyG4meqJ8N8WMX+ukDDkIGR2Aqp6p5NLpGxM5oQfeDcPRNUQwmc+p7LFJrZQySUM=
X-Received: by 2002:a67:f5c8:0:b0:44e:93f4:3c85 with SMTP id
 t8-20020a67f5c8000000b0044e93f43c85mr14894882vso.12.1696987797618; Tue, 10
 Oct 2023 18:29:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230424131121.155649464@linuxfoundation.org> <CA+G9fYstB_fROK9LHYuQ8dc2ArieGGAW_x69eEX-eAi5xMeE3Q@mail.gmail.com>
 <20230426170945.0ec0f1ef@gandalf.local.home> <20230426181415.17c893f5@gandalf.local.home>
 <CA+G9fYtd=dJEM=+xOHA9Egs88r+gEfrnW_gFnTFm4of5uTQ7mA@mail.gmail.com>
In-Reply-To: <CA+G9fYtd=dJEM=+xOHA9Egs88r+gEfrnW_gFnTFm4of5uTQ7mA@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 11 Oct 2023 06:59:46 +0530
Message-ID: <CA+G9fYt518bg10DVo=ag=iGB8dj_NQZEmEty1CdkU3Cj+gtW0w@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/29] 4.19.282-rc1 review
To:     Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, stable@vger.kernel.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de,
        Mark Rutland <mark.rutland@arm.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven and Greg,

On Thu, 27 Apr 2023 at 15:19, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> Hi Steven,
>
> On Wed, 26 Apr 2023 at 23:14, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > On Wed, 26 Apr 2023 17:09:45 -0400
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > > Now the question is, why is this triggering on 4.19 but not in latest
> > > mainline?
> >
> > I found it, I backported this patch and the warning goes away (at least for
> > me). Can you add this and see if it makes the warning go away for you too?
>
> I have applied this patch on stable-rc 4.19 branch and tested on
> - arm64: Juno-r2
>  - x86_64 device
>
> and the reported problem has been resolved.
>
> Thanks for finding a quick fix patch.
>
> >
> > -- Steve
> >
> > From: Peter Zijlstra <peterz@infradead.org>
> > Date: Fri, 7 Aug 2020 20:50:19 +0200
> > Subject: [PATCH] sched,idle,rcu: Push rcu_idle deeper into the idle path
> >
> > commit 1098582a0f6c4e8fd28da0a6305f9233d02c9c1d upstream.

Can we expect this patch to be merged into 4.19 ?
The reason for the question is, the reported problem is still seen on
stable-rc 4.19.

> >
> > Lots of things take locks, due to a wee bug, rcu_lockdep didn't notice
> > that the locking tracepoints were using RCU.
> >
> > Push rcu_idle_{enter,exit}() as deep as possible into the idle paths,
> > this also resolves a lot of _rcuidle()/RCU_NONIDLE() usage.
> >
> > Specifically, sched_clock_idle_wakeup_event() will use ktime which
> > will use seqlocks which will tickle lockdep, and
> > stop_critical_timings() uses lock.
> >
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Tested-by: Marco Elver <elver@google.com>
> > Link: https://lkml.kernel.org/r/20200821085348.310943801@infradead.org
>
>
> Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>
>
> test log:
>   - https://lkft.validation.linaro.org/scheduler/job/6380295#L1418
>   - https://lkft.validation.linaro.org/scheduler/job/6380303#L1443
>
> > ---
> >  drivers/cpuidle/cpuidle.c | 12 ++++++++----
> >  kernel/sched/idle.c       | 22 ++++++++--------------
> >  2 files changed, 16 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> > index 2d182dc1b49e..01bde6dec13a 100644
> > --- a/drivers/cpuidle/cpuidle.c
> > +++ b/drivers/cpuidle/cpuidle.c
> > @@ -140,13 +140,14 @@ static void enter_s2idle_proper(struct cpuidle_driver *drv,
> >          * executing it contains RCU usage regarded as invalid in the idle
> >          * context, so tell RCU about that.
> >          */
> > -       RCU_NONIDLE(tick_freeze());
> > +       tick_freeze();
> >         /*
> >          * The state used here cannot be a "coupled" one, because the "coupled"
> >          * cpuidle mechanism enables interrupts and doing that with timekeeping
> >          * suspended is generally unsafe.
> >          */
> >         stop_critical_timings();
> > +       rcu_idle_enter();
> >         drv->states[index].enter_s2idle(dev, drv, index);
> >         if (WARN_ON_ONCE(!irqs_disabled()))
> >                 local_irq_disable();
> > @@ -155,7 +156,8 @@ static void enter_s2idle_proper(struct cpuidle_driver *drv,
> >          * first CPU executing it calls functions containing RCU read-side
> >          * critical sections, so tell RCU about that.
> >          */
> > -       RCU_NONIDLE(tick_unfreeze());
> > +       rcu_idle_exit();
> > +       tick_unfreeze();
> >         start_critical_timings();
> >
> >         time_end = ns_to_ktime(local_clock());
> > @@ -224,16 +226,18 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
> >         /* Take note of the planned idle state. */
> >         sched_idle_set_state(target_state);
> >
> > -       trace_cpu_idle_rcuidle(index, dev->cpu);
> > +       trace_cpu_idle(index, dev->cpu);
> >         time_start = ns_to_ktime(local_clock());
> >
> >         stop_critical_timings();
> > +       rcu_idle_enter();
> >         entered_state = target_state->enter(dev, drv, index);
> > +       rcu_idle_exit();
> >         start_critical_timings();
> >
> >         sched_clock_idle_wakeup_event();
> >         time_end = ns_to_ktime(local_clock());
> > -       trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, dev->cpu);
> > +       trace_cpu_idle(PWR_EVENT_EXIT, dev->cpu);
> >
> >         /* The cpu is no longer idle or about to enter idle. */
> >         sched_idle_set_state(NULL);
> > diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> > index 44a17366c8ec..4e3d149d64ad 100644
> > --- a/kernel/sched/idle.c
> > +++ b/kernel/sched/idle.c
> > @@ -53,17 +53,18 @@ __setup("hlt", cpu_idle_nopoll_setup);
> >
> >  static noinline int __cpuidle cpu_idle_poll(void)
> >  {
> > +       trace_cpu_idle(0, smp_processor_id());
> > +       stop_critical_timings();
> >         rcu_idle_enter();
> > -       trace_cpu_idle_rcuidle(0, smp_processor_id());
> >         local_irq_enable();
> > -       stop_critical_timings();
> >
> >         while (!tif_need_resched() &&
> > -               (cpu_idle_force_poll || tick_check_broadcast_expired()))
> > +              (cpu_idle_force_poll || tick_check_broadcast_expired()))
> >                 cpu_relax();
> > -       start_critical_timings();
> > -       trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, smp_processor_id());
> > +
> >         rcu_idle_exit();
> > +       start_critical_timings();
> > +       trace_cpu_idle(PWR_EVENT_EXIT, smp_processor_id());
> >
> >         return 1;
> >  }
> > @@ -90,7 +91,9 @@ void __cpuidle default_idle_call(void)
> >                 local_irq_enable();
> >         } else {
> >                 stop_critical_timings();
> > +               rcu_idle_enter();
> >                 arch_cpu_idle();
> > +               rcu_idle_exit();
> >                 start_critical_timings();
> >         }
> >  }
> > @@ -148,7 +151,6 @@ static void cpuidle_idle_call(void)
> >
> >         if (cpuidle_not_available(drv, dev)) {
> >                 tick_nohz_idle_stop_tick();
> > -               rcu_idle_enter();
> >
> >                 default_idle_call();
> >                 goto exit_idle;
> > @@ -166,19 +168,15 @@ static void cpuidle_idle_call(void)
> >
> >         if (idle_should_enter_s2idle() || dev->use_deepest_state) {
> >                 if (idle_should_enter_s2idle()) {
> > -                       rcu_idle_enter();
> >
> >                         entered_state = cpuidle_enter_s2idle(drv, dev);
> >                         if (entered_state > 0) {
> >                                 local_irq_enable();
> >                                 goto exit_idle;
> >                         }
> > -
> > -                       rcu_idle_exit();
> >                 }
> >
> >                 tick_nohz_idle_stop_tick();
> > -               rcu_idle_enter();
> >
> >                 next_state = cpuidle_find_deepest_state(drv, dev);
> >                 call_cpuidle(drv, dev, next_state);
> > @@ -195,8 +193,6 @@ static void cpuidle_idle_call(void)
> >                 else
> >                         tick_nohz_idle_retain_tick();
> >
> > -               rcu_idle_enter();
> > -
> >                 entered_state = call_cpuidle(drv, dev, next_state);
> >                 /*
> >                  * Give the governor an opportunity to reflect on the outcome
> > @@ -212,8 +208,6 @@ static void cpuidle_idle_call(void)
> >          */
> >         if (WARN_ON_ONCE(irqs_disabled()))
> >                 local_irq_enable();
> > -
> > -       rcu_idle_exit();
> >  }
> >
> >  /*
> > --
> > 2.39.2
>
> - Naresh
>
>
> --
> Linaro LKFT
> https://lkft.linaro.org
