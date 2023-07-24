Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9430475F7C6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 15:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbjGXNGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 09:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjGXNGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 09:06:45 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67983A8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 06:06:44 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-5221ee899a0so2577595a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 06:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690204003; x=1690808803;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JYygFMggGVe1zI/JIHbo+p6fCmuCVgx3GGAaIyTlLvY=;
        b=r6xZ6whuQsNJ3drndhh+IFfnwFo6AYl6z8XvNaLauYxgTRTxB5kbzDNXxnVrecISrk
         /k+/LFLW3OdF3fgHtWool+fHO8QC7fAWFoJBgrCjG6K0TTLlr/7Hjz1aEOLRiyODUl2M
         UWcNPokDsfGWa0exXeL7JE+0Aug+ceU1CEFzAs2rjgB3zeoIbMRGG6KEO0CRZwX/n26w
         iOjBNYe6D1/3/vAg5X7eu6soTFct1aEy0lpqSEO/wDshOTVqJvuTmK6X55+4hYfSH5WO
         tWG47eqboyv9iTxz7jSIMRGV+wdnaYFsZZhgVXwQx6ZurVC+uT6g81l8+bmYb2zPE89U
         nkRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690204003; x=1690808803;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JYygFMggGVe1zI/JIHbo+p6fCmuCVgx3GGAaIyTlLvY=;
        b=e0Xmm4i1jyWC/A5vdvnTe6ACHTW+CbcUpG7s6VkAHDVX5vbkns7efjvfCeJ2k90MZ+
         0SZ4TD1zpfPP3u8Or+YBa1+PQlEuv3H5ikoj5G3qHVpPqBWhFzuMBfyvJf7DGNKTVg6Y
         AHDuOS+bkW3Fe8nQ02ilOJZmOEYW3UefK4jjTen3FpCf1yBELDRAPGTtTWpUcDHIuoWS
         3su/3FtIIV8NHw255IeigKTUuu7KevRQiVrPSCZJ3XyxmdVZ2d7dDixWQexSdajwoIo6
         TtH0pgyiVykjYaxbsJW8zOT+5jk5u7IAJO/xJ0sIQSMtzX8Sa8g5qbwFbFoC877A8Ops
         2C/Q==
X-Gm-Message-State: ABy/qLbB78hlCTRoAn2Hds2q9ZGuehqddoIjQrhSVtLhfOh340Hf5awV
        x9QenfgLs1gM4najb0/GoKNn6Sp3qc8fUw9wQrDdYQ==
X-Google-Smtp-Source: APBJJlFmHB5wgyhUits8ck7F8v11ihM4VMsqNRcZAyXTrKO+t8FTgs0VmoD2EaG2Yp15diJ0AajQXcpPoCquQUmd9ms=
X-Received: by 2002:a17:906:76cd:b0:99b:4174:77f6 with SMTP id
 q13-20020a17090676cd00b0099b417477f6mr8569609ejn.33.1690204002816; Mon, 24
 Jul 2023 06:06:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230706135144.324311-1-vincent.guittot@linaro.org>
 <20230711154718.gudn32sru5opwvlw@airbuntu> <CAKfTPtC2NyZcVukzsYAEdhyxv__AURVuJ1JUoh8NGBmq0mL1hQ@mail.gmail.com>
 <39d63092-0e1d-2a0b-37e4-eea6789f8055@arm.com>
In-Reply-To: <39d63092-0e1d-2a0b-37e4-eea6789f8055@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 24 Jul 2023 15:06:31 +0200
Message-ID: <CAKfTPtB5VCLcKpmFpdq5Yq4ypAyoiv04t=ab6f2RnGodhNp5kA@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: remove util_est boosting
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Qais Yousef <qyousef@layalina.io>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org
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

On Fri, 21 Jul 2023 at 18:09, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 12/07/2023 17:30, Vincent Guittot wrote:
> > On Tue, 11 Jul 2023 at 17:47, Qais Yousef <qyousef@layalina.io> wrote:
> >>
> >> On 07/06/23 15:51, Vincent Guittot wrote:
> >>> There is no need to use runnable_avg when estimating util_est and that
> >>> even generates wrong behavior because one includes blocked tasks whereas
> >>> the other one doesn't. This can lead to accounting twice the waking task p,
> >>> once with the blocked runnable_avg and another one when adding its
> >>> util_est.
>
> ... and we don't have this issue for the util_avg case since we have:
>
> 7317         } else if (p && task_cpu(p) != cpu && dst_cpu == cpu)
>                              ^^^^^^^^^^^^^^^^^^
> 7318                 util += task_util(p);
>
> >>> cpu's runnable_avg is already used when computing util_avg which is then
> >>> compared with util_est.
>
> We discussed why I have to use max(X, runnable) for X=util and
> X=util_est in v2:
>
> https://lkml.kernel.org/r/251b524a-2c44-3892-1bae-03f879d6a64b@arm.com
>
> -->
>
> I need the util_est = max(util_est, runnable) further down as well. Just
> want to fetch runnable only once.
>
> util = 50, task_util = 5, util_est = 60, task_util_est = 10, runnable = 70
>
> max(70 + 5, 60 + 10) != max (70 + 5, 70 + 10) when dst_cpu == cpu
>

Hmm, I don't get your point here. Why should they be equal ?

Below is a example to describe my problem:

task A with util_avg=200 util_est=300 runnable=200
task A is attached to CPU0 so it contributes to CPU0's util_avg and
runnable_avg.

In eenv_pd_max_util() we call cpu_util(cpu, p, dst_cpu, 1) to get the
max utilization and the OPP to use to compute energy.

Let say that there is nothing else running on CPU0 and CPU1 and the
both belong to the same performance domain so
CPU0 util_avg= 200 util_est=0 runnable_avg=200
CPU1 util_avg=0 util_est=0 runnable_avg=0

For CPU0, cpu_util(cpu, p, dst_cpu, 1) will return (200 + 300) = 500
For CPU1, cpu_util(cpu, p, dst_cpu, 1) will return (0 + 300) = 300

If there is an OPP with a capacity between these 2 values, CPU1 will
use a lower OPP than CPU0 and its computed energy will be lower.

The condition  if (max_spare_cap_cpu >= 0 && max_spare_cap >
prev_spare_cap) filters some cases when CPU0 and CPU1 have the exact
same spare capacity. But we often see a smaller spare capacity for
CPU0 because of small side activities like cpufreq, timer, irq, rcu
... The difference is often only 1 but enough to bypass the condition
above. task A will migrate to CPU1 whereas there is no need. Then it
will move back to CPU0 once CPU1 will have a smaller spare capacity

I ran a test on snapdragon RB5 with the latest tip/sched/core. I start
3 tasks: 1 large enough to be on medium CPUs and 2 small enough to
stay on little CPUs during 30 seconds
With tip/sched/core, the 3 tasks are migrating around 3665
With the patch, there is only 8 migration at the beginning of the test

> <--
>
> But I assume your point is that:
>
> 7327       if (boost)
> 7328           util_est = max(util_est, runnable);
>
> 7356       if (dst_cpu == cpu)                                   <-- (1)
> 7357           util_est += _task_util_est(p);
> 7358       else if (p && unlikely(task_on_rq_queued(p) || current == p))
> 7359           lsub_positive(&util_est, _task_util_est(p));
> 7360
> 7361       util = max(util, util_est);
>
> --> (1) doesn't work anymore in case `util_est == runnable`.
>
> It will break the assumption for the if condition depicted in
> cpu_util()'s comment:

exactly
>
> 7331  * During wake-up (2) @p isn't enqueued yet and doesn't contribute
> 7332  * to any cpu_rq(cpu)->cfs.avg.util_est.enqueued.
> 7333  * If @dst_cpu == @cpu add it to "simulate" cpu_util after @p
> 7334  * has been enqueued.
>
> (2) eenv_pd_max_util() and find_energy_efficient_cpu() call-site.
>
> <---
>
> Rerunning Jankbench tests on Pix6 will tell if boosting util_avg instead
> of both will still show the anticipated results. Likelihood is high that
> it will since we do `util = max(util, util_est)` at the end of cpu_util().

 I think the same

>
> >>> In some situation, feec will not select prev_cpu but another one on the
> >>> same performance domain because of higher max_util
> >>>
> >>> Fixes: 7d0583cf9ec7 ("sched/fair, cpufreq: Introduce 'runnable boosting'")
> >>> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> >>> ---
> >>
> >> Can we verify the numbers that introduced this magic boost are still valid
> >> please?
> >
> > TBH I don't expect it but I agree it's worth checking. Dietmar could
> > you rerun your tests with this change ?
>
> Could do. But first lets understand the issue properly.
>
> >> Otherwise LGTM.
> >>
> >>
> >> Thanks!
> >>
> >> --
> >>
> >> Qais Yousef
> >>
> >>>  kernel/sched/fair.c | 3 ---
> >>>  1 file changed, 3 deletions(-)
> >>>
> >>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >>> index a80a73909dc2..77c9f5816c31 100644
> >>> --- a/kernel/sched/fair.c
> >>> +++ b/kernel/sched/fair.c
> >>> @@ -7289,9 +7289,6 @@ cpu_util(int cpu, struct task_struct *p, int dst_cpu, int boost)
> >>>
> >>>               util_est = READ_ONCE(cfs_rq->avg.util_est.enqueued);
> >>>
> >>> -             if (boost)
> >>> -                     util_est = max(util_est, runnable);
> >>> -
> >>>               /*
> >>>                * During wake-up @p isn't enqueued yet and doesn't contribute
> >>>                * to any cpu_rq(cpu)->cfs.avg.util_est.enqueued.
> >>> --
> >>> 2.34.1
> >>>
>
