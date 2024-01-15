Return-Path: <linux-kernel+bounces-25724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1143D82D4FB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 09:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BAF7281AC7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 08:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919798493;
	Mon, 15 Jan 2024 08:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LWpcI1tV"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7FD847A
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 08:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5ce6b5e3c4eso3566997a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 00:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705306918; x=1705911718; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0EKYsp2xFmSVYaS86Gpj+vRKi5Fv8R8FrWQsCr7yev0=;
        b=LWpcI1tV1mmBtAmwbjI9YdOrjXmJ8g6laBXITfNRQGq88ufhu4GSU8n0EOflNagj/2
         uS1HMqo9YPmTjQJ6BjqFteRO1R9JIG6IV7S/ddXULHYDvIKzJpovT+g5VY/vsbX1mKEY
         H89MnTbJFbH5ChtBaK+lSWJxuPxa7AGYg8amTa0atLF63shYNjj2DqA7Dpgoyh01I8id
         L8RSfOU/piaWUh9UOSbQbFDO1WrAztWLmMMUDYlFTzkh2yy7jH+V42BoJX6Pw1wEBAD0
         Fx9zfw26uNcRqWYr24XJFhCnFdmSz44FrwX5utbIdYvee0QOk6wRNrpR6t5J69yHtZaS
         2VGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705306918; x=1705911718;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0EKYsp2xFmSVYaS86Gpj+vRKi5Fv8R8FrWQsCr7yev0=;
        b=hC/h07TID6w9Q6YAm105u1wNLZtjNabOynts7SPNByRRfzINDQyaEdt1zynpm0IL4I
         Vkph/cqJ30YIrxwil1APobsNuSDiHTPIyQEOYFBz2wogQXK8wZ6OC4HlEJ8NXdJkgokC
         29jJ+p1EpjuyOZuB9z1g6y1AgUl60ymBlmbjuZkHmo04rhBOzWg9fVSbrRmFN0DFou2U
         5Q1vy/mizGbkB96ZKINSOtTm9ACxBWm8+P34zVltkB3MuPt/z07PRghF0DKZtL61M6xJ
         PdmBfLIRZOfY60jKbqBrRVP9Sg2A/u8kHQNfCVKfJXoioOg+qCBWkzPdUc80flbu7LAo
         95Zg==
X-Gm-Message-State: AOJu0Yw39nJ6DLRcNEWu/646j4+X1l51wIfEj9px7B/BYKwE7uDEbOjt
	9N2O7270kz5saO+WCnkDfL07RT+SFx62zpWl5GWT9uhKvSOU9w==
X-Google-Smtp-Source: AGHT+IGzhvjPeJt4tfpT6RVK0EJtUW67/1pIzsXo+md9QHr82rTOaCyk0S+fy8OyafMN+DoMvwXUS/yP327eyTMsSVw=
X-Received: by 2002:a05:6a20:3d01:b0:19a:7ca5:77f4 with SMTP id
 y1-20020a056a203d0100b0019a7ca577f4mr2345525pzi.53.1705306918429; Mon, 15 Jan
 2024 00:21:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZZwBi/YmnMqm7zrO@gmail.com> <CAHk-=wgWcYX2oXKtgvNN2LLDXP7kXkbo-xTfumEjmPbjSer2RQ@mail.gmail.com>
 <CAHk-=wiXpsxMcQb7MhL-AxOityTajK0G8eWeBOzX-qBJ9X2DSw@mail.gmail.com>
 <CAHk-=wjK28MUqBZzBSMEM8vdJhDOuXGSWPmmp04GEt9CXtW6Pw@mail.gmail.com>
 <20240114091240.xzdvqk75ifgfj5yx@wyes-pc> <ZaPC7o44lEswxOXp@vingu-book>
 <20240114123759.pjs7ctexcpc6pshl@wyes-pc> <CAKfTPtCz+95dR38c_u6_7JbkVt=czj5N2dKYVV-zk9dgbk16hw@mail.gmail.com>
 <20240114151250.5wfexq44o3mdm3nh@airbuntu> <CAKfTPtAMxiTbvAYav1JQw+MhjzDPCZDrMLL2JOfsc0GWp+FnOA@mail.gmail.com>
 <20240114195815.nes4bn53tc25djbh@airbuntu>
In-Reply-To: <20240114195815.nes4bn53tc25djbh@airbuntu>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 15 Jan 2024 09:21:46 +0100
Message-ID: <CAKfTPtCGgJiFDrZYpynCiHBnQx48A9RsAY9-6Hshduo4ymGJLQ@mail.gmail.com>
Subject: Re: [GIT PULL] Scheduler changes for v6.8
To: Qais Yousef <qyousef@layalina.io>
Cc: Wyes Karny <wkarny@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 14 Jan 2024 at 20:58, Qais Yousef <qyousef@layalina.io> wrote:
>
> On 01/14/24 16:20, Vincent Guittot wrote:
> > On Sun, 14 Jan 2024 at 16:12, Qais Yousef <qyousef@layalina.io> wrote:
> > >
> > > On 01/14/24 14:03, Vincent Guittot wrote:
> > >
> > > > Thanks for the trace. It was really helpful and I think that I got the
> > > > root cause.
> > > >
> > > > The problem comes from get_capacity_ref_freq() which returns current
> > > > freq when arch_scale_freq_invariant() is not enable, and the fact that
> > > > we apply map_util_perf() earlier in the path now which is then capped
> > > > by max capacity.
> > > >
> > > > Could you try the below ?
> > > >
> > > > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > > > index e420e2ee1a10..611c621543f4 100644
> > > > --- a/kernel/sched/cpufreq_schedutil.c
> > > > +++ b/kernel/sched/cpufreq_schedutil.c
> > > > @@ -133,7 +133,7 @@ unsigned long get_capacity_ref_freq(struct
> > > > cpufreq_policy *policy)
> > > >         if (arch_scale_freq_invariant())
> > > >                 return policy->cpuinfo.max_freq;
> > > >
> > > > -       return policy->cur;
> > > > +       return policy->cur + policy->cur >> 2;
> > > >  }
> > > >
> > > >  /**
> > >
> > > Is this a test patch or a proper fix? I can't see it being the latter. It seems
> >
> > It's a proper fix. It's the same mechanism that is used already :
> >  - Either you add margin on the utilization to go above current freq
> > before it is fully used. This si what was done previously
> >  - or you add margin on the freq range to select a higher freq than
> > current one before it become fully used
>
> Aren't we applying the 25% headroom twice then?

In some cases, yes. But whereas the 1st one is generic and can be
filtered with uclamp, the 2nd one is there to enable platform without
frequency invariance to jump to the next OPP

>
> >
> > > the current logic fails when util is already 1024, and I think we're trying to
> > > fix the invariance issue too late.
> > >
> > > Is the problem that we can't read policy->cur in the scheduler to fix the util
> > > while it's being updated that's why it's done here in this case?
> > >
> > > If this is the problem, shouldn't the logic be if util is max then always go to
> > > max frequency? I don't think we have enough info to correct the invariance here
> > > IIUC. All we can see the system is saturated at this frequency and whether
> > > a small jump or a big jump is required is hard to tell.
> > >
> > > Something like this
> > >
> > > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > > index 95c3c097083e..473d0352030b 100644
> > > --- a/kernel/sched/cpufreq_schedutil.c
> > > +++ b/kernel/sched/cpufreq_schedutil.c
> > > @@ -164,8 +164,12 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
> > >         struct cpufreq_policy *policy = sg_policy->policy;
> > >         unsigned int freq;
> > >
> > > -       freq = get_capacity_ref_freq(policy);
> > > -       freq = map_util_freq(util, freq, max);
> > > +       if (util != max) {
> > > +               freq = get_capacity_ref_freq(policy);
> > > +               freq = map_util_freq(util, freq, max);
> > > +       } else {
> > > +               freq = policy->cpuinfo.max_freq;
> > > +       }
> >
> > This is not correct because you will have to wait to reach full
> > utilization at the current OPP possibly the lowest OPP before moving
> > directly to max OPP
>
> Isn't this already the case? The ratio (util+headroom/max) will be less than
> 1 until util is 80% (with 25% headroom). And for all values <= 80% * max, we
> will request a frequency smaller than/equal policy->cur, no?

In your proposal, we stay at current OPP until util == 1024 because
util can't be higher than max. And then we switch directly to max_freq

In the previous behavior and with the fix, we can go to the next OPP
because either util can be higher than max (previous behavior) or the
selected freq can be higher than current (fix behavior) and we don't
have to want for util == max

>
> ie:
>
>         util = 600
>         max = 1024
>
>         freq = 1.25 * 600 * policy->cur / 1024 = 0.73 * policy->cur
>
> (util+headroom/max) must be greater than 1 for us to start going above
> policy->cur - which seems to have been working by accident IIUC.

No this is not by accident

>
> So yes my proposal is incorrect, but it seems the conversion is not right to me
> now.
>
> I could reproduce the problem now (thanks Wyes!). I have 3 freqs on my system
>
> 2.2GHz, 2.8GHz and 3.8GHz
>
> which (I believe) translates into capacities
>
> ~592, ~754, 1024
>
> which means we should pick 2.8GHz as soon as util * 1.25 > 592; which
> translates into util = ~473.

Keep in mind that util is the utilization at current OPP not at full
scale because we don't have frequency invariance.

>
> But what I see is that we go to 2.8GHz when we jump from 650 to 680 (see
> attached picture), which is what you'd expect since we apply two headrooms now,
> which means the ratio (util+headroom/max) will be greater than 1 after go above
> this value
>
>         1024 * 0.8 * 0.8 = ~655
>
> So I think the math makes sense logically, but we're missing some other
> correction factor.
>
> When I re-enable CPPC I see for the same test that we go into 3.8GHz straight
> away. My test is simple busyloop via
>
>         cat /dev/zero > /dev/null
>
> I see the CPU util_avg is at 523 at fork. I expected us to run to 2.8GHz here
> to be honest, but I am not sure if util_cfs_boost() and util_est() are maybe
> causing us to be slightly above 523 and that's why we start with max freq.
>
> Or I've done the math wrong :-) But the two don't behave the same for the same
> kernel with and without CPPC.

They will never behave the same because they can't
- with invariance, the utilization is the utilization at max capacity
so we can easily jump several OPP to go directly to the right one
- without invariance, the utilization is the utilization at current
OPP so we can only jump to a limited number of OPP

>
> >
> > >
> > >         if (freq == sg_policy->cached_raw_freq && !sg_policy->need_freq_update)
> > >                 return sg_policy->next_freq;

