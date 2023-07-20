Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA3775B088
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 15:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbjGTNzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 09:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbjGTNzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 09:55:48 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B3B212C
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 06:55:46 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-5217ad95029so1026349a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 06:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689861344; x=1690466144;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lgRpPp4gKHVA+ve/J4YPNrMBXW+cnST8bq74bnuxOfY=;
        b=WNiehueKQ/j2uLApw6xq9k6GlTjB5rwMNoNZQ47R0NrzVavg5scEYv7vP/2n4KmOTa
         b3i2ST5HmLu6CJwotJasiZLXwximi1HnlciXB0ScUAEQHFfvZu9dDew91k/7FGrr6fD4
         teMoMD7iAzEAGZb8hn35bDuA4XXVYxn5OGUIUOcn2zEZYktCAysyqST/aZ4auoP3TQ3J
         qlnhlvIkXPWDoE5NwqFlUqIYr3bWAIyaMmZTNP189+Sj+3SnU7Wusc7OtteQiY9lTUlY
         JGqw52b6NXnYNYh5OPmFM4INgJkiJbsy7XvB0HP/+h/21DCUJoqaOifMxmx1lazG98eR
         f4PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689861344; x=1690466144;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lgRpPp4gKHVA+ve/J4YPNrMBXW+cnST8bq74bnuxOfY=;
        b=WLjRegY1Eskl1l2osfUkW4oO7U0eRerjOqH0LE5pMuJJTgvy3fy8F62xMWqaGbZDpz
         EGlb4Olls31fU5zpcLZRjvBZpIJxGPzjbrahM0BsfhhRU5EGf1zg6HZmcK1iSKtBvz4C
         1iMStFt84MqbEfAuTV1/chnVap07Y0rT1omR4XpdhTcXElCExKux91LQVJMdm2MahFAG
         Cz9ZMB3IVoqKeh6L+jCX/ck8vmFDOdzJ6gdFOa3NYXvPYzZ97omYOJiek/zpQnY1JB1Y
         ghSLnOm6DjDo4R2uluICy2BLcraLxEMRHQmkRz1iWNIHAbwrR1wnE2+IhmK8cLGTq2gv
         6Awg==
X-Gm-Message-State: ABy/qLbtNix0fvYRwwKSDUBdoJxO2pCwXOOhi4HMpr7fFPSJkdklTWWI
        zGwyWqPt7JP84lPGBtulXIx2h/FokAecxA7T5MSFcQ==
X-Google-Smtp-Source: APBJJlF9MeWUTENUTzFXv6Et7nC03toZ3ulyjZMVTQD5MQGY7kkKy280Fdd+9Ps7L/Dw+IEOJ+n51xq5enEWpWcrhWM=
X-Received: by 2002:a05:6402:514:b0:521:ae63:ee63 with SMTP id
 m20-20020a056402051400b00521ae63ee63mr4815003edv.16.1689861344535; Thu, 20
 Jul 2023 06:55:44 -0700 (PDT)
MIME-Version: 1.0
References: <80956e8f-761e-b74-1c7a-3966f9e8d934@linutronix.de>
 <CAKfTPtCSsLz+qD-xUnm4N1HyZqtQD+rYVagnSur+hfUHEk0sYg@mail.gmail.com> <ad370ab-5694-d6e4-c888-72bdc635824@linutronix.de>
In-Reply-To: <ad370ab-5694-d6e4-c888-72bdc635824@linutronix.de>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 20 Jul 2023 15:55:33 +0200
Message-ID: <CAKfTPtDpOCQTpXRQaQqkCgwK3HZQ2KdfG4-+nKjUvfK3NUZ0Pg@mail.gmail.com>
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jul 2023 at 15:00, Anna-Maria Behnsen
<anna-maria@linutronix.de> wrote:
>
> Hi Vincent,
>
> On Thu, 20 Jul 2023, Vincent Guittot wrote:
>
> > On Thu, 20 Jul 2023 at 08:51, Anna-Maria Behnsen
> > <anna-maria@linutronix.de> wrote:
> > >
> > > Hi,
> > >
> > > during tests of the timer pull model, Gautham observed regressions under
> > > load. With the timer pull model in place, going idle is more expensive. My
> > > naive assumption, that a system which is fully loaded will not go idle was
> > > simply wrong. Under a fully loaded system (top shows ~1% idle), some CPUs
> > > go idle and stop the tick for several us and come back to work and this
> > > heavily repeats.
> > >
> > > Peter and tglx helped me to track it down to find the reason: The governor
> > > which decides if the tick will be stopped only looks at the next timer but
> > > does not take into account how busy the system is. Here Peter pointed to
> > > the scheduler avg_idle value.
> > >
> > > Beside the existing avg_idle, I introduced really_avg_idle which is not
> > > limited to twice max_idle_balance_cost but also updated in
> > > ttwu_do_activate() when avg_idle is updated.
> > >
> > > With tracing, I was able to see that in the fully loaded case, 75%-80% of
> > > the idle periods have been shorter than the really_avg_idle value. (trace
> > > printk of really_avg_idle values directly at the begin of
> > > tick_nohz_next_event(); enabling sched_wakeup tracepoint; take the delta
> > > between the timestamps of the first and the latter as idle time).
> > >
> > > A generalized approach to prevent going idle, when the system is loaded,
> > > would be to add a check how busy the system is to tick_nohz_next_event().
> >
> > Would it be better to let the cpuidle governor decide whether to stop
> > or not the tick instead ?
> > With your change, tick_nohz_next_event() becomes an random value which
> > might return something else than the real next event
> >
> > you might me interested by this:
> > https://lore.kernel.org/all/20230105145159.1089531-1-kajetan.puchalski@arm.com/
> >
> > They use cpu utilization to stay in shallow c-states some of which
> > don't stop the tick. Maybe you extend this to make sure to not stop
> > the tick for high load
>
> I had also a look at teo. It makes things better but does not solve the
> underlying problem that I see here - please correct me if I missed
> something or if I'm simply wrong:
>
> Yes, the governors have to decide in the end, whether it makes sense to
> stop the tick or not. For this decision, the governors require information
> about the current state of the core and how long nothing has to be done
> propably. At the moment the governors therefore call
> tick_nohz_get_sleep_length(). This checks first whether the tick can be
> stopped. Then it takes into account whether rcu, irq_work, arch_work needs
> the CPU or a timer softirq is pending. If non of this is true, then the
> timers are checked. So tick_nohz_get_sleep_length() isn't only based on
> timers already.

yes but all these are boolean to say that they rely on the tick to
work correctly

>
> The information about the sleep length of the scheduler perspective is
> completely missing in the current existing check for the probable sleep
> length.

The scheduler is not able to estimate the sleep length and its
avg_idle is just a rough and wrong estimate which already fails to do
its job in several cases. It's quite difficult to predict a sleep
duration if not impossible. Even the cpuidle governors which are the
expert for this often fail. That's partly why teo has been added
because the menu governor was failing to correctly predict sleep
duration for some systems.

>
> Sure, teo takes scheduler utilization into account directly in the
> governor. But for me it is not comprehensible, why the CPU utilization
> check is done after asking for the possible sleep length where timers are
> taken into account. If the CPU is busy anyway, the information generated by
> tick_nohz_next_event() is irrelevant. And when the CPU is not busy, then it
> makes sense to ask for the sleep length also from a timer perspective.

You should ask teo's maintainer and contributors for a detailed
explanation about the policy and why they check cpu utilization after
getting the next timer event

>
> When this CPU utilization check is implemented directly inside the
> governor, every governor has to implement it on it's own. So wouldn't it
> make sense to implement a "how utilized is the CPU out of a scheduler
> perspective" in one place and use this as the first check in
> tick_nohz_get_sleep_length()/tick_nohz_next_event()?

tick_nohz_get_sleep_length() is not the probable sleep length but the
next timer event.

whereas it's not clear what an utilized cpu means.

Next timer event and cpu's utilization are 2 different parameters and
the governors might want to apply different "weights" on these
parameters in their policy.

>
> > >
> > > In my PoC (find it at the end) it's simply checked whether the
> > > really_avg_idle value is smaller than TICK_NSEC. It's not possible to use
> > > the existing avg_idle value as it is always smaller than TICK_NSEC on 250HZ
> > > systems. But there regressions occur under load and the standard deviation
> > > of the test results were in the same range as the regression (between 5 and
> > > 10%).
> > >
> > > So I wanted to understand the avg_idle values and examined the distribution
> > > with different load scenarios. There my next naive assumption was, that
> > > under load mainly short values will be seen. This is true, when the system
> > > is halfway loaded (top shows ~50% idle). But when the system is fully
> > > loaded, the avg_idle values are no longer 'focused' on small values.
> >
> > avg_idle is broken for what you want to do. It is updated only when
> > you leave an idle state which means that it stays stuck to the old avg
> > idle time when your system is fully busy

Trying to predict sleep duration is quite complex and needs other
inputs than just the scheduler's one. As an example, predicting irq is
another source of uncertainty in your sleep duration. As a side note,
I have already seen some test results where randomly selecting an idle
state was doing as good as current governors.

Vincent

> >
>
> As I said, I'm not familiar with scheduler internals. If avg_idle is not
> the right thing, there might be another possibility to generate the
> information about a possible sleep length out of the already existing
> scheduler data.
>
> Thanks,
>
>         Anna-Maria
>
