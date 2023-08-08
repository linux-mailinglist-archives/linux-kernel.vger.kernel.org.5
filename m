Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A406C7742ED
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233751AbjHHRw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235131AbjHHRv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:51:59 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08D49EFF
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:23:13 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fbea14706eso49855495e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 09:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google; t=1691511784; x=1692116584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cPxy7oN760iWQrMghsO3cIyhshW0R7BPSaYAZcv5ihU=;
        b=cD7Sfhdeqp7iabvg8vBQgTMRvhuB6i8gkTtjwBIqen5YMu7LUKeUtO1GxRxSTSuOB1
         DCEqb0vfrJER2gxsO9O1sotZBMaHj20iaMdmBVNXFBheMGWHF0XlLMQoOGolh91EVq85
         H1F1D2ZSN4Bu3CCr/nbW1f5bHcbBElgglsxXCZvb/+tldWFiuMxYPojmlzayLXa7kwXB
         v5aEabLvHrfk1HIOjG0dyB6XEZoOads6PIPKMk2Tz0UgAu7lwHY25RoezQ2L4yXpycCB
         ZEBd0h2rczf3giToKhudJBr16a5rrxRiyRbayoMnZ7ziuse+1A5zs/7VGFugbRrWHrfA
         nVZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691511784; x=1692116584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cPxy7oN760iWQrMghsO3cIyhshW0R7BPSaYAZcv5ihU=;
        b=UNYlBO1OvCMzkUuaIp/LDQZTslvxZPjPefd5eapSNtn3iXRN0ruF5m20CHMHObzFdG
         gwfhkdo0fqH6JcakdebfnsjOIGXxXVWiV097UnnO0WY/4jWcI7ae/2Azq0gcMkmk7xCM
         TVJV1Mf0UKno6JAriwdmCvEmyVDyD2rWfHT1J0jbKx4iKMPBRXgS8gkgBdXbHZPT9d7N
         ZiOeGgqGdauDBE7brguNUFbUzjMrIFYzqLCZTzp3pwQadHHFmSHTCB/LcEnuZ3XgFh/v
         iHVPWzO+yVvF/WQPUOcTPHc3rZWIaH7/YpdJKrC/6QCgkR5Zc4XtxdQgT8rfNBRqiyPB
         6C6g==
X-Gm-Message-State: AOJu0YzSB82f24ewoZ+Sot8uQP/OXHPXqUMIlRCTFIMzXEPxIzJC3/LN
        JvRul3PeuU1Q0uLWgjnq2VjR2QTyxS8o0S54o15R0U+8xw1jM/B9SPo=
X-Google-Smtp-Source: AGHT+IH/ScqC4gzyiVhBdZBVc/AlLCb1vByVv9V9UrCnUDm3VOT+ghvWJ0CtcewDmuDqMzpF2MsX0ZvPa84RBoBWRiQ=
X-Received: by 2002:a05:600c:211:b0:3fe:18d8:a61b with SMTP id
 17-20020a05600c021100b003fe18d8a61bmr262881wmi.29.1691511783788; Tue, 08 Aug
 2023 09:23:03 -0700 (PDT)
MIME-Version: 1.0
References: <006901d9be8c$f4439930$dccacb90$@telus.net> <CAJZ5v0hqPb1+tzGiOCSKr=4QcjnRKT5Gd8FcNbD_Gz5CnAw8tw@mail.gmail.com>
 <CAAYoRsUu-5u73cSASua133EE3+zTRbTgq-kEn2L52e4=n6X46g@mail.gmail.com> <CAJZ5v0jiQ-JFsFAFQFTZVGe-NobaRp7oo95R=Dju9b54n6iKEw@mail.gmail.com>
In-Reply-To: <CAJZ5v0jiQ-JFsFAFQFTZVGe-NobaRp7oo95R=Dju9b54n6iKEw@mail.gmail.com>
From:   Doug Smythies <dsmythies@telus.net>
Date:   Tue, 8 Aug 2023 09:22:54 -0700
Message-ID: <CAAYoRsU2=qOUhBKSRskcoRXSgBudWgDNVvKtJA+c22cPa8EZ1Q@mail.gmail.com>
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

On Wed, Jul 26, 2023 at 7:43=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
> On Tue, Jul 25, 2023 at 9:12=E2=80=AFPM Doug Smythies <dsmythies@telus.ne=
t> wrote:
> > On Tue, Jul 25, 2023 at 11:31=E2=80=AFAM Rafael J. Wysocki <rafael@kern=
el.org> wrote:
> > > On Tue, Jul 25, 2023 at 2:14=E2=80=AFAM Doug Smythies <dsmythies@telu=
s.net> wrote:
> > > >
> > > > Currently, when the CPU frequency is stale the nominal clock freque=
ncy
> > > > is returned by calls to arch_freq_get_on_cpu(). Some users are
> > > > confused by the high reported frequency when their system is idle
> > > > and/or it is above a reduced maximum they set.
> > > >
> > > > This patch will return the policy minimum as the stale frequency re=
ply
> > > > from arch_freq_get_on_cpu().
> > > >
> > > > Reported-by: Yang Jie <yang.jie@linux.intel.com>
> > > > Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=3D217597
> > > > Signed-off-by: Doug Smythies <dsmythies@telus.net>
> > > > ---
> > > >  arch/x86/kernel/cpu/aperfmperf.c | 13 +++++--------
> > > >  drivers/cpufreq/cpufreq.c        | 18 ++++++++++++++++++
> > > >  include/linux/cpufreq.h          |  5 +++++
> > > >  3 files changed, 28 insertions(+), 8 deletions(-)
> > > >
> > > > diff --git a/arch/x86/kernel/cpu/aperfmperf.c b/arch/x86/kernel/cpu=
/aperfmperf.c
> > > > index fdbb5f07448f..44cc96864d94 100644
> > > > --- a/arch/x86/kernel/cpu/aperfmperf.c
> > > > +++ b/arch/x86/kernel/cpu/aperfmperf.c
> > > > @@ -418,9 +418,10 @@ unsigned int arch_freq_get_on_cpu(int cpu)
> > > >         unsigned long last;
> > > >         u64 acnt, mcnt;
> > > >
> > > > -       if (!cpu_feature_enabled(X86_FEATURE_APERFMPERF))
> > > > -               goto fallback;
> > > > -
> > > > +       if (!cpu_feature_enabled(X86_FEATURE_APERFMPERF)){
> > > > +               freq =3D cpufreq_quick_get(cpu);
> > > > +               return freq ? freq : cpufreq_quick_get_min(cpu);
> > > > +       }
> > > >         do {
> > > >                 seq =3D raw_read_seqcount_begin(&s->seq);
> > > >                 last =3D s->last_update;
> > > > @@ -433,13 +434,9 @@ unsigned int arch_freq_get_on_cpu(int cpu)
> > > >          * which covers idle and NOHZ full CPUs.
> > > >          */
> > > >         if (!mcnt || (jiffies - last) > MAX_SAMPLE_AGE)
> > > > -               goto fallback;
> > > > +               return cpufreq_quick_get_min(cpu);
> > > >
> > > >         return div64_u64((cpu_khz * acnt), mcnt);
> > > > -
> > > > -fallback:
> > > > -       freq =3D cpufreq_quick_get(cpu);
> > > > -       return freq ? freq : cpu_khz;
> > >
> > > It looks to me like modifying cpufreq_quick_get) to return policy->mi=
n
> > > if policy->cur is 0 would work in a similar way, wouldn't it?
> >
> > For the configuration of intel_cpufreq driver (intel_pstate in
> > passive mode), schedutil governor, HWP enabled, for
> > a stale frequency  policy->cur is not 0 and will always
> > be whatever the min value was when the driver was initialized,
> > regardless of what has been set since.
>
> So I would prefer to address this in the intel_pstate driver than to
> work around it in the core.

Okay, but I would need some help with it. I already tried to
figure out a fix before starting this thread, and have tried
again since your comment. I haven't been able to figure
it out.

An example of the issue:
Use the ondemand governor and set some
minimum and also put a load on CPU 5 such that the
governor asks for a non-min and non-max pstate.
Then switch to the schedutil governor, and terminate
the load on CPU 5, and look at CPU frequencies:

$ grep . /sys/devices/system/cpu/cpufreq/policy*/scaling_cur_freq
/sys/devices/system/cpu/cpufreq/policy0/scaling_cur_freq:1000000
/sys/devices/system/cpu/cpufreq/policy10/scaling_cur_freq:1000000
/sys/devices/system/cpu/cpufreq/policy11/scaling_cur_freq:1000000
/sys/devices/system/cpu/cpufreq/policy1/scaling_cur_freq:4799871
/sys/devices/system/cpu/cpufreq/policy2/scaling_cur_freq:4800027
/sys/devices/system/cpu/cpufreq/policy3/scaling_cur_freq:1000000
/sys/devices/system/cpu/cpufreq/policy4/scaling_cur_freq:1000000
/sys/devices/system/cpu/cpufreq/policy5/scaling_cur_freq:1300000
/sys/devices/system/cpu/cpufreq/policy6/scaling_cur_freq:1000000
/sys/devices/system/cpu/cpufreq/policy7/scaling_cur_freq:4800736
/sys/devices/system/cpu/cpufreq/policy8/scaling_cur_freq:1000000
/sys/devices/system/cpu/cpufreq/policy9/scaling_cur_freq:1000000

non stale frequencies are identified by non round numbers.
observe that CPU 5 still indicates pstate 13.
observe the other stale frequencies are the pstate 10 min
that I set when the governor was ondemand.
Now change the minimum to 1.1 GHz and check it:

$ grep . /sys/devices/system/cpu/cpufreq/policy*/scaling_min_freq
/sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq:1100000
/sys/devices/system/cpu/cpufreq/policy10/scaling_min_freq:1100000
/sys/devices/system/cpu/cpufreq/policy11/scaling_min_freq:1100000
/sys/devices/system/cpu/cpufreq/policy1/scaling_min_freq:1100000
/sys/devices/system/cpu/cpufreq/policy2/scaling_min_freq:1100000
/sys/devices/system/cpu/cpufreq/policy3/scaling_min_freq:1100000
/sys/devices/system/cpu/cpufreq/policy4/scaling_min_freq:1100000
/sys/devices/system/cpu/cpufreq/policy5/scaling_min_freq:1100000
/sys/devices/system/cpu/cpufreq/policy6/scaling_min_freq:1100000
/sys/devices/system/cpu/cpufreq/policy7/scaling_min_freq:1100000
/sys/devices/system/cpu/cpufreq/policy8/scaling_min_freq:1100000
/sys/devices/system/cpu/cpufreq/policy9/scaling_min_freq:1100000

and look at current again:

$ grep . /sys/devices/system/cpu/cpufreq/policy*/scaling_cur_freq
/sys/devices/system/cpu/cpufreq/policy0/scaling_cur_freq:1000000
/sys/devices/system/cpu/cpufreq/policy10/scaling_cur_freq:1000000
/sys/devices/system/cpu/cpufreq/policy11/scaling_cur_freq:1000000
/sys/devices/system/cpu/cpufreq/policy1/scaling_cur_freq:1000000
/sys/devices/system/cpu/cpufreq/policy2/scaling_cur_freq:1000000
/sys/devices/system/cpu/cpufreq/policy3/scaling_cur_freq:1000000
/sys/devices/system/cpu/cpufreq/policy4/scaling_cur_freq:1000000
/sys/devices/system/cpu/cpufreq/policy5/scaling_cur_freq:1300000
/sys/devices/system/cpu/cpufreq/policy6/scaling_cur_freq:4800585
/sys/devices/system/cpu/cpufreq/policy7/scaling_cur_freq:4800177
/sys/devices/system/cpu/cpufreq/policy8/scaling_cur_freq:4799992
/sys/devices/system/cpu/cpufreq/policy9/scaling_cur_freq:4800015

Observe the stale frequencies are unchanged and outside of the
range limits.

> > The patch I submitted deals with that situation also.
> >
> > A complete list of driver/governor/HWP stale frequency
> > replies can be found on the bugzilla report at:
> >
> > https://bugzilla.kernel.org/attachment.cgi?id=3D304694
> >
> > There might be push back on some of the performance
> > governor stale frequency replies. I could not figure out
> > a performance governor dependant reply.
> >
> > Also there are other callers to cpufreq_quick_get
> > and I was not sure I could mess with the function
> > response for them. For example
> > drivers/devfreq/tegra30-devfreq.c
> > and drivers/thermal/cpufreq_cooling.c
> > and drivers/powercap/dtpm_cpu.c
>
> IIUC, all of the above rely on policy->cur being nonzero.
>
> There are other users doing questionable things when
> cpufreq_quick_get() returns 0 that I think would be better off if the
> min is returned instead.

Okay, I'll submit a new patch shortly, with this:

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 50bbc969ffe5..4e91169a83f5 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1768,7 +1768,7 @@ unsigned int cpufreq_quick_get(unsigned int cpu)

        policy =3D cpufreq_cpu_get(cpu);
        if (policy) {
-               ret_freq =3D policy->cur;
+               ret_freq =3D policy->cur ? policy->cur : policy->min;
                cpufreq_cpu_put(policy);
        }

The testing results are in the bugzilla report here:
https://bugzilla.kernel.org/attachment.cgi?id=3D304734

... Doug
