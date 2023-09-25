Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB8F87AD7AF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 14:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbjIYMHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 08:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231414AbjIYMHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 08:07:31 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758CC139
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 05:06:45 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-277564f049dso1042053a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 05:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695643604; x=1696248404; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FVUt6ZlZlt1P8Ceh/hubtNxz/DIJsD3wgxBUc0MmUI4=;
        b=w4saT8oIzQkG+JYGgqyG+F32lUbbWI9jtiblAasfHRhPIHkfG0ew4wOIatOi0CL9cD
         8zMYm+Nohxgk3/iynUo9+ZOjXT8p/Lxfmzge8bdHbDbhi3B2lppxsFlru0JZUnF5j8HF
         jYnPAlDB7mX+fuJPEEGv5BP0p0P2y4AyOgFSCIhMghbMOr9MqJmgx/eLDOLhMbxmLROB
         jwo6thYC7J1soJJDAyaROGbWR3ByE/O0qPk7OthI3RMKpig1VLnTOY8iafy9cAdbTF/t
         LFWQXZ1xu17ZVGFKOM2EqD8OdrNKrRbjvdPys2GVeB1qwnRofpSxABH7V4m19pARb4LF
         HgKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695643604; x=1696248404;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FVUt6ZlZlt1P8Ceh/hubtNxz/DIJsD3wgxBUc0MmUI4=;
        b=jOHnJxmMgYcGmuYuT65kdKvw8H6/Nv4IM4UVdPvCukMrQoiGhn8WrH2jjqh+eTPZBO
         uTjoq37QvTVrHX3Mkh4AH8wu4IVWCfvJjBcHPXgF3OApydEIrrzisg5ZBdMWXGMFiSCD
         GyTvKnWWtFLrIyH7s22kC4na0Ifw+uy3BTckpUXuMJuQJwTssLemY42ytfWQXhDZiYyc
         xNM+Ob6wgNB/nFlLXkYqmbhZvSqoZUw4tfobsWfBZgW49j5Z/BBYVhjizVSxLzQahO4o
         sUYTjCzkyQ0+mCZ/TqU3eVd/w12wUv5U05JC/1iM9bKbX46hcKZ6yYkAr4W4xIyyxsXu
         ns4w==
X-Gm-Message-State: AOJu0Yy5wNUIIQ3gHr2xMOlaSRYbItsVE894dRYCMCJftIGiOmtXXIIB
        kVW28yYxpXVgr10B0obMqmVR+JzHQsOfaAaF106LlQ==
X-Google-Smtp-Source: AGHT+IHTZAYH6v2yVOscns05lwBAjB14afRWd6clMBTAdvhJtdZPNbdfJYyNaZhnqQS2GA/pbd76KDTydWoU80lawxU=
X-Received: by 2002:a17:90a:5a81:b0:268:b0b:a084 with SMTP id
 n1-20020a17090a5a8100b002680b0ba084mr4015345pji.46.1695643604484; Mon, 25 Sep
 2023 05:06:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230901130312.247719-1-vincent.guittot@linaro.org>
 <20230901130312.247719-4-vincent.guittot@linaro.org> <ZQwKnnXbjLOYUSjO@arm.com>
In-Reply-To: <ZQwKnnXbjLOYUSjO@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 25 Sep 2023 14:06:32 +0200
Message-ID: <CAKfTPtCM_dsWcD6qru_nLYpDH9_OoziMy5d3zAofXNsXzG94xQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] cpufreq/schedutil: use a fixed reference frequency
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, sudeep.holla@arm.com,
        gregkh@linuxfoundation.org, rafael@kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        viresh.kumar@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-pm@vger.kernel.org, conor.dooley@microchip.com,
        suagrfillet@gmail.com, ajones@ventanamicro.com, lftan@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Sept 2023 at 11:19, Ionela Voinescu <ionela.voinescu@arm.com> wrote:
>
> On Friday 01 Sep 2023 at 15:03:11 (+0200), Vincent Guittot wrote:
> > cpuinfo_max_freq can change at runtime because of boost as example. This
> > implies that the value could not be the same than the one that has been
> > used when computing the capacity of a CPU.
> >
> > The new arch_scale_freq_ref() returns a fixed and coherent frequency
> > reference that can be used when computing a frequency based on utilization.
> >
> > Use this arch_scale_freq_ref() when available and fallback to
> > cpuinfo.max_freq otherwise.
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  kernel/sched/cpufreq_schedutil.c | 29 +++++++++++++++++++++++++++--
> >  1 file changed, 27 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > index 4492608b7d7f..9996ef429e2b 100644
> > --- a/kernel/sched/cpufreq_schedutil.c
> > +++ b/kernel/sched/cpufreq_schedutil.c
> > @@ -114,6 +114,31 @@ static void sugov_deferred_update(struct sugov_policy *sg_policy)
> >       }
> >  }
> >
> > +#ifdef arch_scale_freq_ref
> > +/**
> > + * arch_scale_freq_ref_policy - get the reference frequency of a given CPU that
> > + * has been used to correlate frequency and compute capacity.
> > + * @cpu: the CPU in question.
> > + *
> > + * Return: the reference CPU frequency.
> > + */
> > +static __always_inline
> > +unsigned long  arch_scale_freq_ref_policy(struct cpufreq_policy *policy)
>
> This should not be an arch_ function as it's only a wrapper over an
> arch_ function and not a function that different architectures might
> implement differently usually in architecture specific code.

I expect this function to disappear at some point once all arch will
use it that why I named it arch_* but I can rename it

>
> > +{
> > +     return arch_scale_freq_ref(policy->cpu);
>
> It might make it easier to read if arch_scale_freq_ref() had a default
> implementation that returned 0.

I will use the suggestion made by Peter to have only one function


>
> Then this code would simply become:
>
> freq = arch_scale_freq_ref(policy->cpu);
> if (freq)
>         return freq;
> else if (arch_scale_freq_invariant())
>         return ..
> ..
>
> This approach is similar to the use of arch_freq_get_on_cpu() in
> cpufreq.c, and, as there, having a chosen maximum frequency of 0 would
> not be a valid value.
>
> > +}
> > +#else
> > +static __always_inline
> > +unsigned long  arch_scale_freq_ref_policy(struct cpufreq_policy *policy)
> > +{
> > +     if (arch_scale_freq_invariant())
> > +             return policy->cpuinfo.max_freq;
> > +
> > +
> > +     return policy->cur;
> > +}
> > +#endif
> > +
> >  /**
> >   * get_next_freq - Compute a new frequency for a given cpufreq policy.
> >   * @sg_policy: schedutil policy object to compute the new frequency for.
> > @@ -139,11 +164,11 @@ static void sugov_deferred_update(struct sugov_policy *sg_policy)
> >  static unsigned int get_next_freq(struct sugov_policy *sg_policy,
> >                                 unsigned long util, unsigned long max)
> >  {
> > +     unsigned int freq;
> >       struct cpufreq_policy *policy = sg_policy->policy;
> > -     unsigned int freq = arch_scale_freq_invariant() ?
> > -                             policy->cpuinfo.max_freq : policy->cur;
> >
> >       util = map_util_perf(util);
> > +     freq = arch_scale_freq_ref_policy(policy);
>
> Given its single use here, it would likely be better to place the code
> above directly here, rather than create a wrapper over a few lines of
> code.
>
> Hope it helps,
> Ionela.
>
> >       freq = map_util_freq(util, freq, max);
> >
> >       if (freq == sg_policy->cached_raw_freq && !sg_policy->need_freq_update)
> > --
> > 2.34.1
> >
> >
