Return-Path: <linux-kernel+bounces-25498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F315E82D127
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 16:21:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B7EA28222C
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 15:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2097023DE;
	Sun, 14 Jan 2024 15:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FZHBD6uG"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E307E
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 15:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-28d2c1389e8so6677940a91.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 07:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705245670; x=1705850470; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SzyvJUGvedVohMElLvYed6eWhwfFl/8HQ2/9qBk1dT0=;
        b=FZHBD6uGEAdxbzXSnwCZm/Kh8rQuJgBoQwz3Elt6nzKM7MzZXhR90mr1QyEt0P44r9
         2Plna3qQVr5yAUXlL0myjB+Ks8tTN7N2hmUXMYpisS4k6ZQpmXHGoUBG9F0BPVRjYOax
         ZKS5h1K2mK9YGLu3Tm4PW0qfJjUS6XMnw8cmEA9yFTWqQ+2VRaBQXLIzu6qT3sqiqjjc
         Nghvk/qtt5ivIYfBIXvDhVAuxZlNyXj+fVXUklBB5gz3put6AFw9Gtr69OOO22eaciXK
         VMixdU2jmR3M1chseirzXgqtpF8tTE7Yah0aL7bSJVXw4MRNBwN2DvnDKa26Bh/kBHuB
         awZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705245670; x=1705850470;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SzyvJUGvedVohMElLvYed6eWhwfFl/8HQ2/9qBk1dT0=;
        b=VjwxplCcf7nOjyHA6pCw8autrzUtLIbRwpxDeEcAnZbLbVyO5gSV2aXwFjbgkh5FEm
         PjFgE5secWpO88dPcTmMbfVxU1bxI1gJtN5hSGA3dfp+50DSWJQf9gvtkX2wOZ+PZPm8
         UD6MtLqBPFFAeKr2qeL6QbWn2ObwF8OQCLv7MSluCakAW0cyN1DLXR52EsGhA6je9K8T
         8X2uzK3McFo/A7h6qzfH+2vllp6fnwgITb/IAKFfmiLLrkuH/5sIgL9XGJPUBMi9VUXF
         3Gnz5RRVEpj+h38DEjPcRDRolhfNzTZJ7Ogeb9YGvWHBC+d+UEGznp5SwdqgZZmexiSU
         P6vw==
X-Gm-Message-State: AOJu0YxxTsUt0mgrpv3RxQSoyR3laYhkofByPJXbg8+f8Guz99m6ntuF
	9vEGiEKiGV7XGO+d27yDGthQ89GyarIjhhAKvQ8f4M0geNz4dQ==
X-Google-Smtp-Source: AGHT+IEs8pCVB+XUMVxsPdp5JHbf1WqhNJ5rBBeenY2em8Rd6YEg/h2q+hTglh4h5xc+kWgPVFlB61coC67sf/Jc1p4=
X-Received: by 2002:a17:90b:345:b0:28d:2737:a894 with SMTP id
 fh5-20020a17090b034500b0028d2737a894mr2918877pjb.26.1705245670150; Sun, 14
 Jan 2024 07:21:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZTz9RpZxfxysYCmt@gmail.com> <ZZwBi/YmnMqm7zrO@gmail.com>
 <CAHk-=wgWcYX2oXKtgvNN2LLDXP7kXkbo-xTfumEjmPbjSer2RQ@mail.gmail.com>
 <CAHk-=wiXpsxMcQb7MhL-AxOityTajK0G8eWeBOzX-qBJ9X2DSw@mail.gmail.com>
 <CAHk-=wjK28MUqBZzBSMEM8vdJhDOuXGSWPmmp04GEt9CXtW6Pw@mail.gmail.com>
 <20240114091240.xzdvqk75ifgfj5yx@wyes-pc> <ZaPC7o44lEswxOXp@vingu-book>
 <20240114123759.pjs7ctexcpc6pshl@wyes-pc> <CAKfTPtCz+95dR38c_u6_7JbkVt=czj5N2dKYVV-zk9dgbk16hw@mail.gmail.com>
 <20240114151250.5wfexq44o3mdm3nh@airbuntu>
In-Reply-To: <20240114151250.5wfexq44o3mdm3nh@airbuntu>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Sun, 14 Jan 2024 16:20:58 +0100
Message-ID: <CAKfTPtAMxiTbvAYav1JQw+MhjzDPCZDrMLL2JOfsc0GWp+FnOA@mail.gmail.com>
Subject: Re: [GIT PULL] Scheduler changes for v6.8
To: Qais Yousef <qyousef@layalina.io>
Cc: Wyes Karny <wkarny@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 14 Jan 2024 at 16:12, Qais Yousef <qyousef@layalina.io> wrote:
>
> On 01/14/24 14:03, Vincent Guittot wrote:
>
> > Thanks for the trace. It was really helpful and I think that I got the
> > root cause.
> >
> > The problem comes from get_capacity_ref_freq() which returns current
> > freq when arch_scale_freq_invariant() is not enable, and the fact that
> > we apply map_util_perf() earlier in the path now which is then capped
> > by max capacity.
> >
> > Could you try the below ?
> >
> > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > index e420e2ee1a10..611c621543f4 100644
> > --- a/kernel/sched/cpufreq_schedutil.c
> > +++ b/kernel/sched/cpufreq_schedutil.c
> > @@ -133,7 +133,7 @@ unsigned long get_capacity_ref_freq(struct
> > cpufreq_policy *policy)
> >         if (arch_scale_freq_invariant())
> >                 return policy->cpuinfo.max_freq;
> >
> > -       return policy->cur;
> > +       return policy->cur + policy->cur >> 2;
> >  }
> >
> >  /**
>
> Is this a test patch or a proper fix? I can't see it being the latter. It seems

It's a proper fix. It's the same mechanism that is used already :
 - Either you add margin on the utilization to go above current freq
before it is fully used. This si what was done previously
 - or you add margin on the freq range to select a higher freq than
current one before it become fully used

> the current logic fails when util is already 1024, and I think we're trying to
> fix the invariance issue too late.
>
> Is the problem that we can't read policy->cur in the scheduler to fix the util
> while it's being updated that's why it's done here in this case?
>
> If this is the problem, shouldn't the logic be if util is max then always go to
> max frequency? I don't think we have enough info to correct the invariance here
> IIUC. All we can see the system is saturated at this frequency and whether
> a small jump or a big jump is required is hard to tell.
>
> Something like this
>
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 95c3c097083e..473d0352030b 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -164,8 +164,12 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
>         struct cpufreq_policy *policy = sg_policy->policy;
>         unsigned int freq;
>
> -       freq = get_capacity_ref_freq(policy);
> -       freq = map_util_freq(util, freq, max);
> +       if (util != max) {
> +               freq = get_capacity_ref_freq(policy);
> +               freq = map_util_freq(util, freq, max);
> +       } else {
> +               freq = policy->cpuinfo.max_freq;
> +       }

This is not correct because you will have to wait to reach full
utilization at the current OPP possibly the lowest OPP before moving
directly to max OPP

>
>         if (freq == sg_policy->cached_raw_freq && !sg_policy->need_freq_update)
>                 return sg_policy->next_freq;

