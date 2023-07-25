Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 953DB76220B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 21:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbjGYTMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 15:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjGYTL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 15:11:59 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2EF010C9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 12:11:57 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fbd33a57b6so59461695e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 12:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google; t=1690312316; x=1690917116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dFu1/8H+5Qp3bz+p6T54wT9cdMriRmcHOC+NLv3kA60=;
        b=Q7NuD/Z7Z5o/nIglXDXm/AxtNVI9wsGFchH1b8OgRvubZZpE5uKoe0du/SdBha1cSq
         pXKYmtWM5+cTQLkX1gtXpMm9bkaAZTpZhGrNhWADyNQX3M4ybHlJNg54bQtSV9+iTJmh
         VvQ7d8WpWBe/MHgbeDuXQfuQqNchcVAzXHOP/WMhoeGdAFbC8ATYT7/6ty6eN7gY03Sy
         qkEuWl1em/xD1LO3IMSNtB7dm5nlbulk+tVbfBOtvMWA6TXDRLdiSNDHMVsQijOaEKkA
         x8NpNmgz7kfcZaoRDe3DCKIWlIrs5IdtP8Q7ceWpyP58h16OylJni20zcAk6+Cbm/ySX
         Lvjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690312316; x=1690917116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dFu1/8H+5Qp3bz+p6T54wT9cdMriRmcHOC+NLv3kA60=;
        b=VfvehrxiJCGHFIatH6RFr4ym6hL3LXj+7UACDVD/bIbjQjjIitT1TkW47VNyr9rsUI
         ibtMBULV/z+Ysdn15HgfqjHYiMeEOmTihCEcLJ+nl7HZXEU2zBtIEcqWV2pZZuDiaqfG
         YHhWZ1hQBAi3kLLcWLs2Kn/yAUL5WiqnbeB4brt9fPo4B/OUpfDSX2z4cN1AfHwOIoYh
         UBrI5s/Rs/ZBv/1f4T+nr/8zECEfjbZmpKYGtYoMqwvePlvgJgtpC3fTOcveNQpq8Zcw
         mI9gbJQ8EUlvEwOyIAfKzJdZChtt31sOgw9Hq3EFT3GoV39RQNeYShePUCyAgh7qJJjS
         8Jsg==
X-Gm-Message-State: ABy/qLYqba48Umo+4VKsj8NCX1Jub4I7A4yym5ojqmyoe+ONz4eWJPv5
        xpi4hXcFUNPvLGSvJRvcbGxt71LEmOjitc4aHI2aug==
X-Google-Smtp-Source: APBJJlHh27x7jB7//c/mirSsWzhC8Cbxha+deBktaFaWSI4ITVoOappyPOSm7V2z628RLf6gW3UVGeBf1KiyXoSmfYc=
X-Received: by 2002:a05:600c:364d:b0:3f9:b244:c294 with SMTP id
 y13-20020a05600c364d00b003f9b244c294mr11216290wmq.35.1690312316411; Tue, 25
 Jul 2023 12:11:56 -0700 (PDT)
MIME-Version: 1.0
References: <006901d9be8c$f4439930$dccacb90$@telus.net> <CAJZ5v0hqPb1+tzGiOCSKr=4QcjnRKT5Gd8FcNbD_Gz5CnAw8tw@mail.gmail.com>
In-Reply-To: <CAJZ5v0hqPb1+tzGiOCSKr=4QcjnRKT5Gd8FcNbD_Gz5CnAw8tw@mail.gmail.com>
From:   Doug Smythies <dsmythies@telus.net>
Date:   Tue, 25 Jul 2023 12:11:47 -0700
Message-ID: <CAAYoRsUu-5u73cSASua133EE3+zTRbTgq-kEn2L52e4=n6X46g@mail.gmail.com>
Subject: Re: [PATCH] x86/aperfmperf: Make stale CPU frequency response within limits.
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-pm@vger.kernel.org,
        "the arch/x86 maintainers" <x86@kernel.org>,
        yang.jie@linux.intel.com, linux-kernel@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Doug Smythies <dsmythies@telus.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

On Tue, Jul 25, 2023 at 11:31=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.o=
rg> wrote:
> On Tue, Jul 25, 2023 at 2:14=E2=80=AFAM Doug Smythies <dsmythies@telus.ne=
t> wrote:
> >
> > Currently, when the CPU frequency is stale the nominal clock frequency
> > is returned by calls to arch_freq_get_on_cpu(). Some users are
> > confused by the high reported frequency when their system is idle
> > and/or it is above a reduced maximum they set.
> >
> > This patch will return the policy minimum as the stale frequency reply
> > from arch_freq_get_on_cpu().
> >
> > Reported-by: Yang Jie <yang.jie@linux.intel.com>
> > Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=3D217597
> > Signed-off-by: Doug Smythies <dsmythies@telus.net>
> > ---
> >  arch/x86/kernel/cpu/aperfmperf.c | 13 +++++--------
> >  drivers/cpufreq/cpufreq.c        | 18 ++++++++++++++++++
> >  include/linux/cpufreq.h          |  5 +++++
> >  3 files changed, 28 insertions(+), 8 deletions(-)
> >
> > diff --git a/arch/x86/kernel/cpu/aperfmperf.c b/arch/x86/kernel/cpu/ape=
rfmperf.c
> > index fdbb5f07448f..44cc96864d94 100644
> > --- a/arch/x86/kernel/cpu/aperfmperf.c
> > +++ b/arch/x86/kernel/cpu/aperfmperf.c
> > @@ -418,9 +418,10 @@ unsigned int arch_freq_get_on_cpu(int cpu)
> >         unsigned long last;
> >         u64 acnt, mcnt;
> >
> > -       if (!cpu_feature_enabled(X86_FEATURE_APERFMPERF))
> > -               goto fallback;
> > -
> > +       if (!cpu_feature_enabled(X86_FEATURE_APERFMPERF)){
> > +               freq =3D cpufreq_quick_get(cpu);
> > +               return freq ? freq : cpufreq_quick_get_min(cpu);
> > +       }
> >         do {
> >                 seq =3D raw_read_seqcount_begin(&s->seq);
> >                 last =3D s->last_update;
> > @@ -433,13 +434,9 @@ unsigned int arch_freq_get_on_cpu(int cpu)
> >          * which covers idle and NOHZ full CPUs.
> >          */
> >         if (!mcnt || (jiffies - last) > MAX_SAMPLE_AGE)
> > -               goto fallback;
> > +               return cpufreq_quick_get_min(cpu);
> >
> >         return div64_u64((cpu_khz * acnt), mcnt);
> > -
> > -fallback:
> > -       freq =3D cpufreq_quick_get(cpu);
> > -       return freq ? freq : cpu_khz;
>
> It looks to me like modifying cpufreq_quick_get) to return policy->min
> if policy->cur is 0 would work in a similar way, wouldn't it?

For the configuration of intel_cpufreq driver (intel_pstate in
passive mode), schedutil governor, HWP enabled, for
a stale frequency  policy->cur is not 0 and will always
be whatever the min value was when the driver was initialized,
regardless of what has been set since.

The patch I submitted deals with that situation also.

A complete list of driver/governor/HWP stale frequency
replies can be found on the bugzilla report at:

https://bugzilla.kernel.org/attachment.cgi?id=3D304694

There might be push back on some of the performance
governor stale frequency replies. I could not figure out
a performance governor dependant reply.

Also there are other callers to cpufreq_quick_get
and I was not sure I could mess with the function
response for them. For example
drivers/devfreq/tegra30-devfreq.c
and drivers/thermal/cpufreq_cooling.c
and drivers/powercap/dtpm_cpu.c

>
> >  }
> >
> >  static int __init bp_init_aperfmperf(void)
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index 50bbc969ffe5..a0b24f61a5b0 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -1796,6 +1796,24 @@ unsigned int cpufreq_quick_get_max(unsigned int =
cpu)
> >  }
> >  EXPORT_SYMBOL(cpufreq_quick_get_max);
> >
> > +/**
> > + * cpufreq_quick_get_min - return the min frequency for a given CPU
> > + * @cpu: CPU number
> > + */
> > +unsigned int cpufreq_quick_get_min(unsigned int cpu)
> > +{
> > +       struct cpufreq_policy *policy =3D cpufreq_cpu_get(cpu);
> > +       unsigned int ret_freq =3D 0;
> > +
> > +       if (policy) {
> > +               ret_freq =3D policy->min;
> > +               cpufreq_cpu_put(policy);
> > +       }
> > +
> > +       return ret_freq;
> > +}
> > +EXPORT_SYMBOL(cpufreq_quick_get_min);
> > +
> >  /**
> >   * cpufreq_get_hw_max_freq - get the max hardware frequency of the CPU
> >   * @cpu: CPU number
> > diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> > index 172ff51c1b2a..c74dcb5f9263 100644
> > --- a/include/linux/cpufreq.h
> > +++ b/include/linux/cpufreq.h
> > @@ -220,6 +220,7 @@ static inline bool policy_is_shared(struct cpufreq_=
policy *policy)
> >  unsigned int cpufreq_get(unsigned int cpu);
> >  unsigned int cpufreq_quick_get(unsigned int cpu);
> >  unsigned int cpufreq_quick_get_max(unsigned int cpu);
> > +unsigned int cpufreq_quick_get_min(unsigned int cpu);
> >  unsigned int cpufreq_get_hw_max_freq(unsigned int cpu);
> >  void disable_cpufreq(void);
> >
> > @@ -250,6 +251,10 @@ static inline unsigned int cpufreq_quick_get_max(u=
nsigned int cpu)
> >  {
> >         return 0;
> >  }
> > +static inline unsigned int cpufreq_quick_get_min(unsigned int cpu)
> > +{
> > +       return 0;
> > +}
> >  static inline unsigned int cpufreq_get_hw_max_freq(unsigned int cpu)
> >  {
> >         return 0;
> > --
> > 2.25.1
> >
> >
