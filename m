Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF1176396F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 16:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232809AbjGZOnl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 26 Jul 2023 10:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232065AbjGZOnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 10:43:39 -0400
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B216CE;
        Wed, 26 Jul 2023 07:43:38 -0700 (PDT)
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-569b5489e6cso626901eaf.0;
        Wed, 26 Jul 2023 07:43:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690382617; x=1690987417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L0c1yWE0v+Gdqy5SNM2fbnebZ+8ijvAe6qjOROFkPo0=;
        b=WR51e1q7aGfPAW9X1igdUgv3UhPfSXaljpqrwO0xoIUZDkMSZqKkcfdPDnwY9x8Uso
         ridKmpgHeHUVXBVGRPsP3sLxEqLYEq6GubDqYZQknzzE1S690Dtk0/b/1/75ByGCz30m
         +1xRMAzWNtNesaPxg32nCqRaVZiRpg6VS1Pxz+yFutVAvYy8A3m1+seyOzDtBmaBzSK5
         jgKBetGZ+yZ7+tK8UA6HehNjEqbyduSisgz43hRuKUcp5DYFB+rJqoIlHCHjgML/R8Rq
         RRDCcTBDUZ6G7HItg4Ig12BqOhY8EnoXnmrEEpIAUgI0qfxX4IqGL4MSW9RxDzmmWTBr
         FbAg==
X-Gm-Message-State: ABy/qLb0xwcsLkeeRnbVK8zgjORSOV1vwJH4K2VgihlbdbZicnQO5Ujg
        eIZ7GIYX2dRqZvhZJeauidUMvvCzleWW5cQEPvMvA+IoDX4=
X-Google-Smtp-Source: APBJJlEot1TWnEx9OLBHq2rxdXllWLriB2pHNXKA39iLz+HaQZ1tvB9FFWjGQdsV9y9nwDblo5UnNr/4Aqqp8e4O0qc=
X-Received: by 2002:a4a:e5d6:0:b0:563:3b56:5dc1 with SMTP id
 r22-20020a4ae5d6000000b005633b565dc1mr1677694oov.0.1690382617381; Wed, 26 Jul
 2023 07:43:37 -0700 (PDT)
MIME-Version: 1.0
References: <006901d9be8c$f4439930$dccacb90$@telus.net> <CAJZ5v0hqPb1+tzGiOCSKr=4QcjnRKT5Gd8FcNbD_Gz5CnAw8tw@mail.gmail.com>
 <CAAYoRsUu-5u73cSASua133EE3+zTRbTgq-kEn2L52e4=n6X46g@mail.gmail.com>
In-Reply-To: <CAAYoRsUu-5u73cSASua133EE3+zTRbTgq-kEn2L52e4=n6X46g@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 26 Jul 2023 16:43:26 +0200
Message-ID: <CAJZ5v0jiQ-JFsFAFQFTZVGe-NobaRp7oo95R=Dju9b54n6iKEw@mail.gmail.com>
Subject: Re: [PATCH] x86/aperfmperf: Make stale CPU frequency response within limits.
To:     Doug Smythies <dsmythies@telus.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, linux-pm@vger.kernel.org,
        "the arch/x86 maintainers" <x86@kernel.org>,
        yang.jie@linux.intel.com, linux-kernel@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,

On Tue, Jul 25, 2023 at 9:12 PM Doug Smythies <dsmythies@telus.net> wrote:
>
> Hi Rafael,
>
> On Tue, Jul 25, 2023 at 11:31 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > On Tue, Jul 25, 2023 at 2:14 AM Doug Smythies <dsmythies@telus.net> wrote:
> > >
> > > Currently, when the CPU frequency is stale the nominal clock frequency
> > > is returned by calls to arch_freq_get_on_cpu(). Some users are
> > > confused by the high reported frequency when their system is idle
> > > and/or it is above a reduced maximum they set.
> > >
> > > This patch will return the policy minimum as the stale frequency reply
> > > from arch_freq_get_on_cpu().
> > >
> > > Reported-by: Yang Jie <yang.jie@linux.intel.com>
> > > Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=217597
> > > Signed-off-by: Doug Smythies <dsmythies@telus.net>
> > > ---
> > >  arch/x86/kernel/cpu/aperfmperf.c | 13 +++++--------
> > >  drivers/cpufreq/cpufreq.c        | 18 ++++++++++++++++++
> > >  include/linux/cpufreq.h          |  5 +++++
> > >  3 files changed, 28 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/arch/x86/kernel/cpu/aperfmperf.c b/arch/x86/kernel/cpu/aperfmperf.c
> > > index fdbb5f07448f..44cc96864d94 100644
> > > --- a/arch/x86/kernel/cpu/aperfmperf.c
> > > +++ b/arch/x86/kernel/cpu/aperfmperf.c
> > > @@ -418,9 +418,10 @@ unsigned int arch_freq_get_on_cpu(int cpu)
> > >         unsigned long last;
> > >         u64 acnt, mcnt;
> > >
> > > -       if (!cpu_feature_enabled(X86_FEATURE_APERFMPERF))
> > > -               goto fallback;
> > > -
> > > +       if (!cpu_feature_enabled(X86_FEATURE_APERFMPERF)){
> > > +               freq = cpufreq_quick_get(cpu);
> > > +               return freq ? freq : cpufreq_quick_get_min(cpu);
> > > +       }
> > >         do {
> > >                 seq = raw_read_seqcount_begin(&s->seq);
> > >                 last = s->last_update;
> > > @@ -433,13 +434,9 @@ unsigned int arch_freq_get_on_cpu(int cpu)
> > >          * which covers idle and NOHZ full CPUs.
> > >          */
> > >         if (!mcnt || (jiffies - last) > MAX_SAMPLE_AGE)
> > > -               goto fallback;
> > > +               return cpufreq_quick_get_min(cpu);
> > >
> > >         return div64_u64((cpu_khz * acnt), mcnt);
> > > -
> > > -fallback:
> > > -       freq = cpufreq_quick_get(cpu);
> > > -       return freq ? freq : cpu_khz;
> >
> > It looks to me like modifying cpufreq_quick_get) to return policy->min
> > if policy->cur is 0 would work in a similar way, wouldn't it?
>
> For the configuration of intel_cpufreq driver (intel_pstate in
> passive mode), schedutil governor, HWP enabled, for
> a stale frequency  policy->cur is not 0 and will always
> be whatever the min value was when the driver was initialized,
> regardless of what has been set since.

So I would prefer to address this in the intel_pstate driver than to
work around it in the core.

> The patch I submitted deals with that situation also.
>
> A complete list of driver/governor/HWP stale frequency
> replies can be found on the bugzilla report at:
>
> https://bugzilla.kernel.org/attachment.cgi?id=304694
>
> There might be push back on some of the performance
> governor stale frequency replies. I could not figure out
> a performance governor dependant reply.
>
> Also there are other callers to cpufreq_quick_get
> and I was not sure I could mess with the function
> response for them. For example
> drivers/devfreq/tegra30-devfreq.c
> and drivers/thermal/cpufreq_cooling.c
> and drivers/powercap/dtpm_cpu.c

IIUC, all of the above rely on policy->cur being nonzero.

There are other users doing questionable things when
cpufreq_quick_get() returns 0 that I think would be better off if the
min is returned instead.
