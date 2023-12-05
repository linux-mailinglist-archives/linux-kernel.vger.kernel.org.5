Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB266805BE0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbjLEQWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 11:22:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjLEQWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 11:22:44 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5901B8
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 08:22:49 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-2868605fa4aso1861891a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 08:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701793369; x=1702398169; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AdOQcLNJtx1RJsEFnV0+ExH0oUNzKgaT4GmF+lpyZV8=;
        b=yj6olYLejPT6mKV2FFdDzRkGgMEFuuYN12+RMS0KFu/R4suexcYqOVjjiUePSoVmRv
         5C6fXV2e4A3F1Oc/aNCCNmOlC+oEckrZDU74DW3QHe6Ws/AcldR1bUg2mjkXii9lWwgr
         7vL2kN47jg5PCsaYd37zKdekmVCK7HQwfBP6zuQeYBrTy9iIviNnwJfRbEiGJHvxyY6l
         N6dFVp43yjdZIuLhxi9Q6CEL43Fw3zFBjD4niOBICe5CnRDze6VoSfkM3uV9zuHvddUS
         TCjpWeguP5sD05T0A8Ft/T1wCjwVzEAbqa1LKKYEfcz6AOgsuo6IHyPVojL87mYZtn1P
         AtLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701793369; x=1702398169;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AdOQcLNJtx1RJsEFnV0+ExH0oUNzKgaT4GmF+lpyZV8=;
        b=ETHdPb0PjnFV5q3zxPeHdSdv2/FUc3F1SevWiA8qAhjIGoIPtmyZInhVjlxWOSFo3A
         aZm41iuH9Gg116poM97fYDkn7RN18VcD/rds4gpBWvXpitQ4jogrlcfiUAhXsQoKdZz0
         FmfYf5Otl4l7P6AJ9Yq+Rbuib0lGJZBZBwmNJryLL7mSMT5a1zQPfI4HDeHr+GaXAe64
         C9fsDrM0e/roGm/Gg3aMlWLllRBIhw4nOhzaS0kSaIKG7yrrMlgN6s818KGdsWvXwLeQ
         4WjRXyn2LyMOXQMjCbsPordXWrc+uxFe48vYTnjFbFjoiFQXVObPqrvOJoEEEdLMOHVd
         o1Aw==
X-Gm-Message-State: AOJu0YxhvhLZpRrDpESg4fJv5KxBkYCPnHNplpYiJzUGpeUTZnv4PoE6
        hlAe00o20UCzibK6/niRkeFOC6lyxe2ZLPr74FNVCA==
X-Google-Smtp-Source: AGHT+IEa9p0Qy9HD/N51+DytFQkjfcxRAQCCIt2wr664Er8FHh99N/PZW92tSVgORgjfZF93TIQtC0GZl6n+1J44aTw=
X-Received: by 2002:a17:90a:ec12:b0:286:6cc0:b91a with SMTP id
 l18-20020a17090aec1200b002866cc0b91amr1150326pjy.81.1701793368717; Tue, 05
 Dec 2023 08:22:48 -0800 (PST)
MIME-Version: 1.0
References: <cover.1696345700.git.Hongyan.Xia2@arm.com> <5564fc23d5e6425d069c36b4cef48edbe77fe64d.1696345700.git.Hongyan.Xia2@arm.com>
 <CAKfTPtBahrEDyaWqyyivmo=9Jagq4OBDv1bQm4AcBP2Xq_EpRw@mail.gmail.com> <7cad55e3-3a61-498a-9364-7a2d69a20757@arm.com>
In-Reply-To: <7cad55e3-3a61-498a-9364-7a2d69a20757@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 5 Dec 2023 17:22:37 +0100
Message-ID: <CAKfTPtB4nY+OY4w3MpLjP=Bi7sVW2bWj74_LW+J8qdzcWueg3A@mail.gmail.com>
Subject: Re: [RFC PATCH 1/6] sched/uclamp: Track uclamped util_avg in sched_avg
To:     Hongyan Xia <hongyan.xia2@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Qais Yousef <qyousef@layalina.io>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Christian Loehle <christian.loehle@arm.com>,
        linux-kernel@vger.kernel.org
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

On Tue, 5 Dec 2023 at 15:24, Hongyan Xia <hongyan.xia2@arm.com> wrote:
>
> On 04/12/2023 16:07, Vincent Guittot wrote:
> > On Wed, 4 Oct 2023 at 11:05, Hongyan Xia <Hongyan.Xia2@arm.com> wrote:
> >>
> >> From: Hongyan Xia <hongyan.xia2@arm.com>
> >>
> >> Track a uclamped version of util_avg in sched_avg, which clamps util_avg
> >> within [uclamp[UCLAMP_MIN], uclamp[UCLAMP_MAX]] every time util_avg is
> >> updated. At the CFS rq level, cfs_rq->avg.util_avg_uclamp must always be
> >> the sum of all util_avg_uclamp of entities on this cfs_rq. So, each
> >> time the util_avg_uclamp of an entity gets updated, we also track the
> >> delta and update the cfs_rq.
> >
> > No please don't do that. Don't start to mix several different signals
> > in one. Typically uclamp_min doen't say you want to use at least this
> > amount of cpu capacity.
>
> But I'd say with uclamp, PELT is already broken and is a mixed signal

PELT has nothing to do with uclamp, you could argue that EAS is making
a wrong use or mix of PELT signals and uclamp hints to select a CPU
but PELT itself is not impacted by uclamp and should stay out of
uclamp policy.

> anyway. When uclamp is used, a util_avg value X doesn't mean X, it means
> X under some rq uclamp, and the worst part is that the rq uclamp may or
> may not have anything to do with this task's uclamp.

I think that you are mixing PELT and how it is(was) used by EAS.

Have you looked at the latest tip/sched/core and the changes in
effective_cpu_util(int cpu, unsigned long util_cfs, unsigned long
*min, unsigned long *max) ?

We return 3 values:
- the actual utilization which is not impacted by uclamp
- a targeted min value which takes into account uclamp_min
- a targeted max value which takes into account uclamp_max

https://lore.kernel.org/lkml/20231122133904.446032-1-vincent.guittot@linaro.org/

>
> Pretending X is a true PELT value now (and not a mixed value) is why we
> have so many problems today. For example in the frequency spike problem,
> if a task A has no idle time under uclamp_max, its PELT does not reflect
> reality. The moment another task B comes in and uncap the rq uclamp_max,

you are mixing 2 things. The PELT signal of the task is correct.

> the current scheduler code thinks the 1024 of A means a real 1024, which
> is wrong and is exactly why we see a spike when B joins. It's also why

This is the true actual utilization, the actual util_avg of A is
really 1024. But users want to give a hint to lower its needs with
uclamp_max.

> we need to special case 0 spare capacity with recent patches, because rq
> util_avg has lost its original PELT meaning under uclamp.
>
> Because X is not the true PELT, we always have to do something to bring
> it back into reality. What the current max aggregation code does is to
> introduce corner cases, like treating 0 spare capacity as potential
> opportunity to queue more tasks (which creates further problems in my
> tests), and maybe introducing uclamp load balancing special cases in the
> future, or introducing uclamp filtering to delay the effect of wrong
> PELT values.
>
> What this series does is not much different. We keep the somewhat wrong
> value X, but we also remember under what uclamp values did we get that X
> to bring things back into reality, which means now we have [X,
> uclamp_min when X happens, uclamp_max when X happens]. To save space,
> this becomes [X, clamped X], which is what this series does. The
> original PELT value X is kept, but we use the clamped X in several
> places to improve our decisions.
>
> >
> > With tasks with a util_avg of 10 but a uclamp min of 1024 what does it
> > mean when you start  to sum this value ?
>
> Like I replied in another comment, assuming a uclamp_min of 1024 is a
> hint to run the task on the big CPUs, I don't think it's right to

not especially to run on a big but to say that the task needs more
performance than what its actual utilization looks

> directly use uclamp as a CPU placement indicator. A uclamp value may
> come from ADFP from userspace. An ADPF uclamp_min value of little CPU
> capacity + 1 certainly doesn't mean a game on purpose wants to avoid the
> little core. It simply means it wants at least this much performance,
> and whether this results in placing the game thread on a big CPU is
> purely the job of EAS (or CAS, etc.). We want to use little CPU + 1 as
> uclamp_min because we know the SoC and the little CPU is bad, but uclamp
> should be generic and should not rely on knowing the SoC.
>
> Basically, under sum aggregation one would not use a uclamp_min value of
> 1024 to place a small task on a big core. A uclamp_min of 1024 under sum
> aggregation has the meaning in ADPF, which is a hint to try to run me as
> fast as possible.
>
> >
> >
> >> [...]
