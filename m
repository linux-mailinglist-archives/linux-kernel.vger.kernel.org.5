Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0BE799F26
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 19:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjIJRqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 13:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbjIJRqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 13:46:47 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98D6184
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 10:46:41 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-401d24f1f27so42158055e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 10:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1694368000; x=1694972800; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qh2kaLFowUOwQcBmNU98JavMmScgK3sBFtHoOQrdNuI=;
        b=0qfUuPQHzx74XcBLJVNOK8JqMx0NOGkdtczvrQEQPbN52UPVkS7itbN2aKQwU775Jp
         4Bw6FdwuYJQqpR9F9iyjWbh2/m4UcjUC7beLQ+DKEtxBZZfx9OlVZ8KuBmF1PImkB4+i
         Kp7Hs/a5ovTBvulXAKexoyHICIf9f6QVRhnV+4qFgBdq6fZk2hfb9HlyAwY1LXe5siq9
         IMSz4jAbCpvvwWQy+BU7pJVJ2g5snD/3Im5xhoapF1DOiIotPNtAnWTrLyl1626sQhCI
         XYkTF5tOgOjN5A01tMNoARpjmoTAfn68QWhiGzcQ1vrLfnR4mvjPdcfrTvF4C2EsTPmF
         /l6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694368000; x=1694972800;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qh2kaLFowUOwQcBmNU98JavMmScgK3sBFtHoOQrdNuI=;
        b=WFhMr7ohYLjWu8xt3Seo7sX5ad/YmvJkTEKeLk1o0qMppRqk34NDEGpPM49JlaZIMS
         dtjvYplTvvquFJXWHRf3zurOrA6zgz4lxS3vdpXoZCDdj/PGEWz9d8Y/9MBFjjt1SiPp
         mllnwLVPyNF9kTSw0LgWRKsHbitfRwcXX1qwlD4xSk+ENYa4U7p4fiRZ1aOUjGXq8kus
         dKqcdetO5tVQv7G9/hGNPouv2j4cz3co0a63k1zfTgsvaxXCBkE9nqQsKB17dKLVAbT4
         AyxiBoRzjrAHU5kyAIzARi4Ls1+az10sxqifsPYK7S6MQqyK3qfC9k7GaF5SGIcYLqa4
         ADWA==
X-Gm-Message-State: AOJu0Ywm88cihlnNBKPGSmIsZr75eOZNgYLXeK1/adKIvRMpWQHTgfBQ
        mFjpak+He5ffCT8eAS7NKHdZZQ==
X-Google-Smtp-Source: AGHT+IGEZd9lskJ6SoICN6s8gmM/IKfahAD74b+G6TibQaVDV6r+O2GXki6EIExxVjomG7+oJ6qsow==
X-Received: by 2002:a7b:c389:0:b0:401:d947:c8a9 with SMTP id s9-20020a7bc389000000b00401d947c8a9mr6322305wmj.19.1694368000195;
        Sun, 10 Sep 2023 10:46:40 -0700 (PDT)
Received: from airbuntu (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id y10-20020a05600c364a00b00401b242e2e6sm10936663wmq.47.2023.09.10.10.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Sep 2023 10:46:39 -0700 (PDT)
Date:   Sun, 10 Sep 2023 18:46:38 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [PATCH 2/4] sched: cpufreq: Fix apply_dvfs_headroom() escaping
 uclamp constraints
Message-ID: <20230910174638.qe7jqq6mq36brh6o@airbuntu>
References: <20230820210640.585311-1-qyousef@layalina.io>
 <20230820210640.585311-3-qyousef@layalina.io>
 <CAKfTPtDY48jpO+b-2KXawzxh-ty+FMKX6YUXioNR7kpgO=ua6Q@mail.gmail.com>
 <20230829163740.uadhv2jfjuumqk3w@airbuntu>
 <CAKfTPtCP6uX79dOrzN4PxFTMBFrDAMOOrWyZrsVypUQ0RY7BAA@mail.gmail.com>
 <20230907215555.exjxho34ntkjmn6r@airbuntu>
 <CAKfTPtA8Ljy4NBqjw8Wj4pEFc-OCR55QPuwh+5GgrHN6u+ugsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtA8Ljy4NBqjw8Wj4pEFc-OCR55QPuwh+5GgrHN6u+ugsg@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/23 16:30, Vincent Guittot wrote:

> > Hmm IIUC, no. irq pressure will be added on top as normal. It's just cfs+rt
> > will be restricted by their uclamp settings _after_ the headroom is applied.
> 
> But then you mixed some utilization level (irq pressure)  which is
> time related with some performance/bandwidth limitation which is freq
> related. And I think that part of the reason why we can't agree on
> where to put headroom and how to take into account uclamp

I did not change how this part works. We can drop patch 4 completely if this is
what is causing the confusion.

What I changed is the order of applying uclamp_rq_util_with() and
apply_dvfs_headroom(). The rest is still the same as-is in the code today.

> 
> >
> > > above 512 whatever the current (720)  formula or your proposal (608).
> > > In the case of uclamp, it should be applied after having been scaled
> > > by irq time.
> >
> > I lost you a bit here. I'm not sure how you reached the 720 and 608 numbers.
> 
> My bad, I finally decided to use an irq pressure of 128 in my
> calculation but forgot to change the value in my email
> 
> >
> > So the way I'm proposing it here
> >
> >         util = cfs + rt + dvfs_headroom(cfs+rt) = 800 + 0.25 * 800 = 1000
> >         util = uclamp_rq_util_with(rq, util, NULL) = 512
> >         util = scale_rq_capacity(512, 256, 1024) = 0.75 * 512 = 384
> >         util += dvfs_headroom(irq) = 384 + 256 + 0.25 * 256 = 704
> >         util += dvfs_headroom(dl_bw) = 704
> >
> > >
> > > So we should have reported utilization of 720 with a bandwidth
> > > requirement of 512 and then cpufreq can applies its headroom if needed
> >
> > The key part I'm changing is this
> >
> >         util = cfs + rt + dvfs_headroom(cfs+rt) = 800 + 0.25 * 800 = 1000
> >         util = uclamp_rq_util_with(rq, util, NULL) = 512
> >
> > Before we had (assume irq, rt and dl are 0 for simplicity and a single task is
> > running)
> >
> >         util = cfs = 800
> >         util = uclamp_rq_util_with(rq, util, NULL) = 512
> >         util = dvfs_headroom(util) = 512 * 0.25 * 512 = 640
> >
> > So we are running higher than we are allowed to. So applying the headroom
> > after taking uclamp constraints into account is the problem.
> 
> But I think it's not correct because you mixed some utilization level
> with some performance requirement. IIRC, you said that the
> uclamp/min/max must not be seen as an utilization level but a
> performance hint. In such case, you can't add it to some other
> utilization because it defeats its original purpose

But this is what we do today already. I didn't change this part. See below.

> 
> >
> > IIUC and your concerns are about how scheduler and schedutil are interacting
> > loses some abstraction, then yeah this makes sense and can refactor code to
> > better abstract the two and keep them decoupled.
> >
> > But if you think the order the headroom is applied should be the way it is,
> > then this doesn't fix the problem.
> >
> > A good use case to consider is a single task running at 1024. If I want to
> > limit it to 80% using uclamp_max, how can this be enforced? With current code,
> > the task will continue to run at 1024; which is the problem.
> 
> Single case is the easy part
> 
> >
> > Running at 640 instead of 512 is still a problem too as this could be 1 or
> > 2 OPP higher than what we want to allow; and there could be significant power
> > difference between those OPPs.
> 
> That's my point.
> 
> Your proposal tries to fix the simple case of 1 task with a uclamp_max
> but If we want to move in this direction, we should fix all cases.

I think I am addressing all cases. I don't think I understand the problem
you're trying to highlight. Is the RFC patch 4 is what is causing the
confusion? That one is not related to fixing uclamp_max; it's just me
questioning the status quo of which pressure signal requires the headroom.

The main change being done here actually is to apply_dvfs_headroom() *before*
doing uclamp_rq_util_with(). I am not sure how you see this mixing.

Current code performs apply_dvfs_headroom() *after*; which what causes the CPU
to run at a performance level higher than rq->uclamp[UCLAMP_MAX].

It doesn't matter how many tasks on the rq, if rq->uclamp[UCLAMP_MAX] is set to
800, then the CPU should not vote to max (assuminig all other pressures are 0).

Handling of irq pressure etc is not changed.

> I probably need to put my idea in real code to see what it means but
> we should provide 2 value to cpufreq: an utilization level and a
> performance hint which would max aggregate the various performance
> hints that we have

Hmm. This reads to me code structure change. From my perspective; the correct
behavior is to apply the headroom before restricting the performance level.

It seems you're seeing a better way to aggregate all the pressures when taking
uclamp into account. Which I am starting to see your point if this is what
you're saying.  Though I haven't changed the existing relationship. I did try
to question some things in patch 4, my thoughts were specific to headroom, but
it seems you have more generalized form.

I do agree in general it seems scheduler and schedutil are getting tightly
coupled code wise and it would be good to provide generic cpufreq interfaces to
potentially allow other governors to hook in and benefit.

Whether this is something desired or not, I don't know as I remember Peter and
Rafael wanted schedutil to grow to become the de-facto governor. It seems the
right thing anyway.


Thanks!

--
Qais Yousef
