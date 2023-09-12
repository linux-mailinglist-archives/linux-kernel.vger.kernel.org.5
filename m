Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B00C79D5B4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 18:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233549AbjILQEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 12:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236446AbjILQEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 12:04:02 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E74E10EC
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 09:03:59 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-57767b2058cso1432092a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 09:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694534638; x=1695139438; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a6IEiebYtaNWwrsshV/U8aJNjQtckNYm4YDy7ZwvHk0=;
        b=OYYbrye1fxLladMt+SMtI/xkXFhHvM1npUrS7TMqJEM/Mta1V1D5nW9FvqymF9NTGs
         2f8GAQ47C8Dv7DzCG7+6+cx9Eqhsg+HmYK9tAorPW7jOYdSUoQp81+ln4Z9u5bTO355X
         JWj5PhwWJYmScLfyMdQQwSXrfweNbSHUS2QyINaPqc5LGWpGiGaBX+W0E9KKUPNXK6Bf
         E0PygbbDeVVXEiA3mic0OYuC4oLWrG0qmkghdzLuBUgjK7sznd4HLp0VwXz9HObkJe/8
         fclaq0TtEuLddTOc8+eHjd377tWvshIm3NYlwK3ZeBs5rZmVxpruFl3HZoa1oLSjchW+
         zRsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694534638; x=1695139438;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a6IEiebYtaNWwrsshV/U8aJNjQtckNYm4YDy7ZwvHk0=;
        b=KXUej3GtGzTr5V2IwhYxheR2K9PJRaSrQVfdu3oy96G9tKBAM5vZmJg63zZhElBsKA
         rOVqUbaAoApIt+HzXSzgdCtoCiZJxal4m5tvakALE8D8CjYnhNGjGGE5p8CAvLFBQBay
         ck9oD1DBqEjm0iMuk1J4d66MIYxHXBaG6/u/tmZF+21Jb/O28udpaz0Cd+JwVHr0fTOB
         w1DQpFWxIw9k4NMCoyeuImUMjdzvnhrwZHiUawgRW5l3d9qWD032gO6XjMT1EkYIs4kb
         RZASorAPuw6bqP5A7g90Shkp8FATi4rIP6EfzIw5+f4vdAze4KzcMPL5/1hFAj+DmRnp
         R/mw==
X-Gm-Message-State: AOJu0YwgViNJ72y7flUAkKdS6ar0WcCrZwi6AwwRS1B7LQTgRWmNIUCj
        uJMoeldjWshvAKKuyOs91GPuRBxOAaT6GAnAayilIA==
X-Google-Smtp-Source: AGHT+IG3noHG6FYLtzLIluiR3u0Rd84DPW5Wczy2NDTWS7CKSjMcq+RFAhJnj3LRv8OdA6Ru45QaY42xitI3Dh91tuQ=
X-Received: by 2002:a17:90a:6c24:b0:273:dffd:664a with SMTP id
 x33-20020a17090a6c2400b00273dffd664amr9212178pjj.20.1694534638421; Tue, 12
 Sep 2023 09:03:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230820210640.585311-1-qyousef@layalina.io> <20230820210640.585311-3-qyousef@layalina.io>
 <CAKfTPtDY48jpO+b-2KXawzxh-ty+FMKX6YUXioNR7kpgO=ua6Q@mail.gmail.com>
 <20230829163740.uadhv2jfjuumqk3w@airbuntu> <CAKfTPtCP6uX79dOrzN4PxFTMBFrDAMOOrWyZrsVypUQ0RY7BAA@mail.gmail.com>
 <20230907215555.exjxho34ntkjmn6r@airbuntu> <CAKfTPtA8Ljy4NBqjw8Wj4pEFc-OCR55QPuwh+5GgrHN6u+ugsg@mail.gmail.com>
 <20230910174638.qe7jqq6mq36brh6o@airbuntu>
In-Reply-To: <20230910174638.qe7jqq6mq36brh6o@airbuntu>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 12 Sep 2023 18:03:47 +0200
Message-ID: <CAKfTPtBFAXO=CgqSJ1+y=2ppb5t4oErCtvV336fS6J2nSjBCkQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] sched: cpufreq: Fix apply_dvfs_headroom() escaping
 uclamp constraints
To:     Qais Yousef <qyousef@layalina.io>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Sept 2023 at 19:46, Qais Yousef <qyousef@layalina.io> wrote:
>
> On 09/08/23 16:30, Vincent Guittot wrote:
>
> > > Hmm IIUC, no. irq pressure will be added on top as normal. It's just cfs+rt
> > > will be restricted by their uclamp settings _after_ the headroom is applied.
> >
> > But then you mixed some utilization level (irq pressure)  which is
> > time related with some performance/bandwidth limitation which is freq
> > related. And I think that part of the reason why we can't agree on
> > where to put headroom and how to take into account uclamp
>
> I did not change how this part works. We can drop patch 4 completely if this is
> what is causing the confusion.
>
> What I changed is the order of applying uclamp_rq_util_with() and
> apply_dvfs_headroom(). The rest is still the same as-is in the code today.
>
> >
> > >
> > > > above 512 whatever the current (720)  formula or your proposal (608).
> > > > In the case of uclamp, it should be applied after having been scaled
> > > > by irq time.
> > >
> > > I lost you a bit here. I'm not sure how you reached the 720 and 608 numbers.
> >
> > My bad, I finally decided to use an irq pressure of 128 in my
> > calculation but forgot to change the value in my email
> >
> > >
> > > So the way I'm proposing it here
> > >
> > >         util = cfs + rt + dvfs_headroom(cfs+rt) = 800 + 0.25 * 800 = 1000
> > >         util = uclamp_rq_util_with(rq, util, NULL) = 512
> > >         util = scale_rq_capacity(512, 256, 1024) = 0.75 * 512 = 384
> > >         util += dvfs_headroom(irq) = 384 + 256 + 0.25 * 256 = 704
> > >         util += dvfs_headroom(dl_bw) = 704
> > >
> > > >
> > > > So we should have reported utilization of 720 with a bandwidth
> > > > requirement of 512 and then cpufreq can applies its headroom if needed
> > >
> > > The key part I'm changing is this
> > >
> > >         util = cfs + rt + dvfs_headroom(cfs+rt) = 800 + 0.25 * 800 = 1000
> > >         util = uclamp_rq_util_with(rq, util, NULL) = 512
> > >
> > > Before we had (assume irq, rt and dl are 0 for simplicity and a single task is
> > > running)
> > >
> > >         util = cfs = 800
> > >         util = uclamp_rq_util_with(rq, util, NULL) = 512
> > >         util = dvfs_headroom(util) = 512 * 0.25 * 512 = 640
> > >
> > > So we are running higher than we are allowed to. So applying the headroom
> > > after taking uclamp constraints into account is the problem.
> >
> > But I think it's not correct because you mixed some utilization level
> > with some performance requirement. IIRC, you said that the
> > uclamp/min/max must not be seen as an utilization level but a
> > performance hint. In such case, you can't add it to some other
> > utilization because it defeats its original purpose
>
> But this is what we do today already. I didn't change this part. See below.

And it seems that what is done today doesn't work correctly for you.
Your proposal to include cpufreq headroom into the scheduler is not
correct IMO and it only applies for some cases. Then, the cpufreq
driver can have some really good reason to apply some headroom even
with an uclamp value but it can't make any decision.

I think that we should use another way to fix your problem with how
uclamp than reordering how headroom is applied by cpufreq. Mixing
utilization and performance in one signal hide some differences that
cpufreq can make a good use of.

As an example:

cfs util = 650
cfs uclamp = 800
irq = 128

cfs with headroom 650*1.25=812 is clamped to 800

Final utilization will be : 800(1024-128)/1024+128*1.25=860 which is
above the target of 800.

When we look at the detail, we have:

cfs util once scaled to the full range is only 650(1024-128)/1024= 568

After applying irq (even with some headroom) 568+128*1.25 = 728 which
is below the uclamp of 800 so shouldn't we stay at 800 in this case ?

>
> >
> > >
> > > IIUC and your concerns are about how scheduler and schedutil are interacting
> > > loses some abstraction, then yeah this makes sense and can refactor code to
> > > better abstract the two and keep them decoupled.
> > >
> > > But if you think the order the headroom is applied should be the way it is,
> > > then this doesn't fix the problem.
> > >
> > > A good use case to consider is a single task running at 1024. If I want to
> > > limit it to 80% using uclamp_max, how can this be enforced? With current code,
> > > the task will continue to run at 1024; which is the problem.
> >
> > Single case is the easy part
> >
> > >
> > > Running at 640 instead of 512 is still a problem too as this could be 1 or
> > > 2 OPP higher than what we want to allow; and there could be significant power
> > > difference between those OPPs.
> >
> > That's my point.
> >
> > Your proposal tries to fix the simple case of 1 task with a uclamp_max
> > but If we want to move in this direction, we should fix all cases.
>
> I think I am addressing all cases. I don't think I understand the problem
> you're trying to highlight. Is the RFC patch 4 is what is causing the
> confusion? That one is not related to fixing uclamp_max; it's just me
> questioning the status quo of which pressure signal requires the headroom.

No patch 4 doesn't cause me confusion.

>
> The main change being done here actually is to apply_dvfs_headroom() *before*
> doing uclamp_rq_util_with(). I am not sure how you see this mixing.

Because dvfs_headroom is a cpufreq hints and you want to apply it
somewhere else.

>
> Current code performs apply_dvfs_headroom() *after*; which what causes the CPU
> to run at a performance level higher than rq->uclamp[UCLAMP_MAX].
>
> It doesn't matter how many tasks on the rq, if rq->uclamp[UCLAMP_MAX] is set to
> 800, then the CPU should not vote to max (assuminig all other pressures are 0).

You can't remove the irq pressure from the picture. If
rq->uclamp[UCLAMP_MAX] is set to 800 means that cpu must not go above
800, it should apply also after taking into account other inputs. At
least up to some level as described in my example above

>
> Handling of irq pressure etc is not changed.
>
> > I probably need to put my idea in real code to see what it means but
> > we should provide 2 value to cpufreq: an utilization level and a
> > performance hint which would max aggregate the various performance
> > hints that we have
>
> Hmm. This reads to me code structure change. From my perspective; the correct
> behavior is to apply the headroom before restricting the performance level.
>
> It seems you're seeing a better way to aggregate all the pressures when taking
> uclamp into account. Which I am starting to see your point if this is what
> you're saying.  Though I haven't changed the existing relationship. I did try
> to question some things in patch 4, my thoughts were specific to headroom, but
> it seems you have more generalized form.
>
> I do agree in general it seems scheduler and schedutil are getting tightly
> coupled code wise and it would be good to provide generic cpufreq interfaces to
> potentially allow other governors to hook in and benefit.
>
> Whether this is something desired or not, I don't know as I remember Peter and
> Rafael wanted schedutil to grow to become the de-facto governor. It seems the
> right thing anyway.
>
>
> Thanks!
>
> --
> Qais Yousef
