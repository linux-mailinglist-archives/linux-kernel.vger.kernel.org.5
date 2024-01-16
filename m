Return-Path: <linux-kernel+bounces-27232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F7A82EC7F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 11:04:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F6ED283C2F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 10:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA030134C5;
	Tue, 16 Jan 2024 10:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bRTcgDLW"
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A4C134AD
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 10:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3bd8cd40a04so137985b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 02:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705399462; x=1706004262; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bm75O17vQC1LrxTK+mjkoi5irV67JEYyueoe2Pp+jl8=;
        b=bRTcgDLWMVnE2XKqrk0a8mAjWMolebYIthGrBnrZLGq9BdaSZFsYi60tZKwv4GkgmH
         J0SVCTWrkXUoL4r+Ox+pu3P7wHNqp64uacFXptzcS5dnLD2y7zrhN4a3AjAHyWLobHb1
         G2h4PyNsciIR5/rZ6wmp7zbYOG6NT3BqrWT/Ib92ExyoiLEQ0niHnercbs1bdIl+0Iic
         fqfVvW2zaldDt3R+ZqIFB028oEdVumlIhEl6q1umD/hRLfOlM9kWZZouz+0Zci5/gp1v
         By+siME9efWsDh7utrWfSQUzWr3N0h27H2YNIYUPCwcQWOifcnjGaeBcsZG4GgJSbd/o
         NNgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705399462; x=1706004262;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bm75O17vQC1LrxTK+mjkoi5irV67JEYyueoe2Pp+jl8=;
        b=wQZZuncGJh0xwUZx5cwIIqDLrb3L+ND7oU6UIO0xVGLBR133p2D5Fb2ARqJ1ZEUsmb
         tXIBdlsBrRHcU5Aci1DKaEDPydxoYrCkHd03nORfgHlnAijNJ+9agd3Gyldw3HUg5dWJ
         t0ZvuosmLsr6mpX3O3ZfxDBr1/CwQc1ygkxXsEWrtb2iVdJ+n70nFNUebqaknlV42g/a
         C4Ken8WTdvTi7i6GKT05TvDAUFo0S1CkQaECsT+S1/WO7KbsDCsLFCOln/Od33fin0Ck
         azR4FkM0XMQEs/IiLHToeKWbnQLAGST+nJZ+bWgiwBFidtOYgRhFpUTL8g7GI17UE9qG
         DUWw==
X-Gm-Message-State: AOJu0Yw9RUB9EDuaaD0pm/chqj5UPW+p2yfg35v0zuUAA5Q7H3N8C/xT
	RIx46RRNppAo6oVUp0SNzcbZkVaJpladqu8K7egut9yvrv+4Ow==
X-Google-Smtp-Source: AGHT+IGwjMb/BYuCnq1FivVqlDOALkWQdZERE6W6fIUYsSlT3M5fm/vqQ1M7pP9b7o1c2gH7qAlOXhr4+XdpULLppAk=
X-Received: by 2002:a05:6358:460e:b0:175:597a:5c9 with SMTP id
 y14-20020a056358460e00b00175597a05c9mr9443876rwl.48.1705399462165; Tue, 16
 Jan 2024 02:04:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240114183600.135316-1-vincent.guittot@linaro.org> <ZaZTlcFZaQefnf1v@gmail.com>
In-Reply-To: <ZaZTlcFZaQefnf1v@gmail.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 16 Jan 2024 11:04:10 +0100
Message-ID: <CAKfTPtB5hqAeJ-0T00azkfC-oYET20aJ8Gq69OrS+1caCgErtg@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Fix frequency selection for non invariant case
To: Ingo Molnar <mingo@kernel.org>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, wkarny@gmail.com, 
	torvalds@linux-foundation.org, qyousef@layalina.io, tglx@linutronix.de, 
	rafael@kernel.org, viresh.kumar@linaro.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Jan 2024 at 10:59, Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Vincent Guittot <vincent.guittot@linaro.org> wrote:
>
> > When frequency invariance is not enabled, get_capacity_ref_freq(policy)
> > returns the current frequency and the performance margin applied by
> > map_util_perf(), enabled the utilization to go above the maximum compute
> > capacity and to select a higher frequency than the current one.
> >
> > The performance margin is now applied earlier in the path to take into
> > account some utilization clampings and we can't get an utilization higher
> > than the maximum compute capacity.
> >
> > We must use a frequency above the current frequency to get a chance to
> > select a higher OPP when the current one becomes fully used. Apply
> > the same margin and returns a frequency 25% higher than the current one in
> > order to switch to the next OPP before we fully use the cpu at the current
> > one.
> >
> > Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> > Closes: https://lore.kernel.org/lkml/CAHk-=wgWcYX2oXKtgvNN2LLDXP7kXkbo-xTfumEjmPbjSer2RQ@mail.gmail.com/
> > Reported-by: Wyes Karny <wkarny@gmail.com>
> > Closes: https://lore.kernel.org/lkml/20240114091240.xzdvqk75ifgfj5yx@wyes-pc/
> > Fixes: 9c0b4bb7f630 ("sched/cpufreq: Rework schedutil governor performance estimation")
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > Tested-by: Wyes Karny <wkarny@gmail.com>
> > ---
> >  kernel/sched/cpufreq_schedutil.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > index 95c3c097083e..d12e95d30e2e 100644
> > --- a/kernel/sched/cpufreq_schedutil.c
> > +++ b/kernel/sched/cpufreq_schedutil.c
> > @@ -133,7 +133,11 @@ unsigned long get_capacity_ref_freq(struct cpufreq_policy *policy)
> >       if (arch_scale_freq_invariant())
> >               return policy->cpuinfo.max_freq;
> >
> > -     return policy->cur;
> > +     /*
> > +      * Apply a 25% margin so that we select a higher frequency than
> > +      * the current one before the CPU is full busy
> > +      */
> > +     return policy->cur + (policy->cur >> 2);
> >  }
>
> I've updated the changelog to better express what was broken and how we
> fixed it. Ack?

Looks good

Thanks

>
>         Ingo
>
> ==========================>
> From: Vincent Guittot <vincent.guittot@linaro.org>
> Date: Sun, 14 Jan 2024 19:36:00 +0100
> Subject: [PATCH] sched/fair: Fix frequency selection for non-invariant case
>
> Linus reported a ~50% performance regression on single-threaded
> workloads on his AMD Ryzen system, and bisected it to:
>
>   9c0b4bb7f630 ("sched/cpufreq: Rework schedutil governor performance estimation")
>
> When frequency invariance is not enabled, get_capacity_ref_freq(policy)
> is supposed to return the current frequency and the performance margin
> applied by map_util_perf(), enabling the utilization to go above the
> maximum compute capacity and to select a higher frequency than the current one.
>
> After the changes in 9c0b4bb7f630, the performance margin was applied
> earlier in the path to take into account utilization clampings and
> we couldn't get a utilization higher than the maximum compute capacity,
> and the CPU remained 'stuck' at lower frequencies.
>
> To fix this, we must use a frequency above the current frequency to
> get a chance to select a higher OPP when the current one becomes fully used.
> Apply the same margin and return a frequency 25% higher than the current
> one in order to switch to the next OPP before we fully use the CPU
> at the current one.
>
> [ mingo: Clarified the changelog. ]
>
> Fixes: 9c0b4bb7f630 ("sched/cpufreq: Rework schedutil governor performance estimation")
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Bisected-by: Linus Torvalds <torvalds@linux-foundation.org>
> Reported-by: Wyes Karny <wkarny@gmail.com>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Tested-by: Wyes Karny <wkarny@gmail.com>
> Link: https://lore.kernel.org/r/20240114183600.135316-1-vincent.guittot@linaro.org
> ---
>  kernel/sched/cpufreq_schedutil.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 95c3c097083e..eece6244f9d2 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -133,7 +133,11 @@ unsigned long get_capacity_ref_freq(struct cpufreq_policy *policy)
>         if (arch_scale_freq_invariant())
>                 return policy->cpuinfo.max_freq;
>
> -       return policy->cur;
> +       /*
> +        * Apply a 25% margin so that we select a higher frequency than
> +        * the current one before the CPU is fully busy:
> +        */
> +       return policy->cur + (policy->cur >> 2);
>  }
>
>  /**

