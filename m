Return-Path: <linux-kernel+bounces-21141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17924828A9A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 18:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 383321C23950
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 17:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654713A8FE;
	Tue,  9 Jan 2024 17:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="edJzYx31"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A673B18D
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 17:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-28c0d8dd88bso2119284a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 09:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704819623; x=1705424423; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GlrZoxPpenGOhqFrmUG8PiyHrSyO0oBBT6cMAiO3UNE=;
        b=edJzYx316aVyS2k0loWR5fC0QBxOA0rshXTpdzCNk3vLA0EZ1dK/TKsfwRjttZ6kNf
         NUBD2FSPzPnjBZ6JwBIwSWTA3rbj1hNeQzAHQd23lemvHqLRw3iviDa9O+j90QCShaCA
         8yVVREDolKo2gxEXRGQipd5af15VNQxbdrNpWwqV8mB61LdOhdqVBdyJx5YX+wpyH15i
         uQGw0c6QTL7wl4j1D9UnkaP9xqHv8QCvVquV3d/i2pgbfE2CaCKoQ1HD43EBxpaUxeQI
         1zcZlHySvxv/4qmSdAvthDEShIeyPvIMg2a8/JBHXDE4hcIp3/2WKDqaQjrTtK39Mk07
         4S5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704819623; x=1705424423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GlrZoxPpenGOhqFrmUG8PiyHrSyO0oBBT6cMAiO3UNE=;
        b=j7x9FUJDeC/LnFGDU4Lzn3qRUnmAhTT6Q1mDWJog4+JWLC30wu4jm2jVK9AQ/mHyEA
         JT26r/A0NXqoSLl0VSFURb9TVGXOKivulS0fJyw9qu0shtLrJXjSIbiXNudtYeC/AW1h
         2JT+dyrNrWUzuPtKVqfs6KGHiz45qZh3gcyi7jHHxB1PuG2EobrjwSlWie7C82yOpYro
         2/vI2kS34zCpzVpdOMpp+o6nm1GR4IkbRV//GCUtCtDhzXcH9BDO/rngFs7oJLZ4xJ+Z
         IpyfKkGKGbzY9FOsj28THoH5BGaurH9vnZck6cENwqkuiJKwgpvPTenPyCnFgHV+0WKM
         Pc9Q==
X-Gm-Message-State: AOJu0YwrSAMJexNHZLyZ10Nyax23Xn6O2iqQ3eV9/kD4GeqMTsTLAWsc
	oDtXLXT6nQQ8rY9aQBks9znq+qrgksLkgFtw4EEB3rSfHKnwDg==
X-Google-Smtp-Source: AGHT+IHMr5gazpEPkkx7GMMw3VKwNSvx2iydEkTrkS2t970cjficwCZjM/LewbbmVn86pT0YwcWTH1AtT/Gbqy90bUc=
X-Received: by 2002:a17:90a:ba18:b0:28c:6529:ecb4 with SMTP id
 s24-20020a17090aba1800b0028c6529ecb4mr2374762pjr.98.1704819623455; Tue, 09
 Jan 2024 09:00:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109164655.626085-1-vincent.guittot@linaro.org>
 <20240109164655.626085-2-vincent.guittot@linaro.org> <CAJZ5v0ixmEiOhwBHkDqH8QNtchiszAEi0rY2pDCGHXiWHob0NA@mail.gmail.com>
In-Reply-To: <CAJZ5v0ixmEiOhwBHkDqH8QNtchiszAEi0rY2pDCGHXiWHob0NA@mail.gmail.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 9 Jan 2024 18:00:12 +0100
Message-ID: <CAKfTPtAncXsNa6_8PXfn3Hv0G03WN79QgPQafJqPSo-3oJm6KA@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] cpufreq: Add a cpufreq pressure feedback for the scheduler
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org, 
	sudeep.holla@arm.com, viresh.kumar@linaro.org, agross@kernel.org, 
	andersson@kernel.org, konrad.dybcio@linaro.org, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, bristot@redhat.com, 
	vschneid@redhat.com, lukasz.luba@arm.com, rui.zhang@intel.com, 
	mhiramat@kernel.org, daniel.lezcano@linaro.org, amit.kachhap@gmail.com, 
	corbet@lwn.net, gregkh@linuxfoundation.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	qyousef@layalina.io
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 9 Jan 2024 at 17:49, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Jan 9, 2024 at 5:47=E2=80=AFPM Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >
> > Provide to the scheduler a feedback about the temporary max available
> > capacity. Unlike arch_update_thermal_pressure, this doesn't need to be
> > filtered as the pressure will happen for dozens ms or more.
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
>
> Acked-by: Rafael J. Wysocki <rafael@kernel.org>
>
> and I think I've given the tag on this patch already.

yes, I preferred to not add it after the crap that I did in the v3
with the cleanup of this [1/5] patch

Thanks

>
> > ---
> >  drivers/cpufreq/cpufreq.c | 36 ++++++++++++++++++++++++++++++++++++
> >  include/linux/cpufreq.h   | 10 ++++++++++
> >  2 files changed, 46 insertions(+)
> >
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index 44db4f59c4cc..f4eee3d107f1 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -2563,6 +2563,40 @@ int cpufreq_get_policy(struct cpufreq_policy *po=
licy, unsigned int cpu)
> >  }
> >  EXPORT_SYMBOL(cpufreq_get_policy);
> >
> > +DEFINE_PER_CPU(unsigned long, cpufreq_pressure);
> > +
> > +/**
> > + * cpufreq_update_pressure() - Update cpufreq pressure for CPUs
> > + * @policy: cpufreq policy of the CPUs.
> > + *
> > + * Update the value of cpufreq pressure for all @cpus in the policy.
> > + */
> > +static void cpufreq_update_pressure(struct cpufreq_policy *policy)
> > +{
> > +       unsigned long max_capacity, capped_freq, pressure;
> > +       u32 max_freq;
> > +       int cpu;
> > +
> > +       cpu =3D cpumask_first(policy->related_cpus);
> > +       max_freq =3D arch_scale_freq_ref(cpu);
> > +       capped_freq =3D policy->max;
> > +
> > +       /*
> > +        * Handle properly the boost frequencies, which should simply c=
lean
> > +        * the cpufreq pressure value.
> > +        */
> > +       if (max_freq <=3D capped_freq) {
> > +               pressure =3D 0;
> > +       } else {
> > +               max_capacity =3D arch_scale_cpu_capacity(cpu);
> > +               pressure =3D max_capacity -
> > +                          mult_frac(max_capacity, capped_freq, max_fre=
q);
> > +       }
> > +
> > +       for_each_cpu(cpu, policy->related_cpus)
> > +               WRITE_ONCE(per_cpu(cpufreq_pressure, cpu), pressure);
> > +}
> > +
> >  /**
> >   * cpufreq_set_policy - Modify cpufreq policy parameters.
> >   * @policy: Policy object to modify.
> > @@ -2618,6 +2652,8 @@ static int cpufreq_set_policy(struct cpufreq_poli=
cy *policy,
> >         policy->max =3D __resolve_freq(policy, policy->max, CPUFREQ_REL=
ATION_H);
> >         trace_cpu_frequency_limits(policy);
> >
> > +       cpufreq_update_pressure(policy);
> > +
> >         policy->cached_target_freq =3D UINT_MAX;
> >
> >         pr_debug("new min and max freqs are %u - %u kHz\n",
> > diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> > index afda5f24d3dd..b1d97edd3253 100644
> > --- a/include/linux/cpufreq.h
> > +++ b/include/linux/cpufreq.h
> > @@ -241,6 +241,12 @@ struct kobject *get_governor_parent_kobj(struct cp=
ufreq_policy *policy);
> >  void cpufreq_enable_fast_switch(struct cpufreq_policy *policy);
> >  void cpufreq_disable_fast_switch(struct cpufreq_policy *policy);
> >  bool has_target_index(void);
> > +
> > +DECLARE_PER_CPU(unsigned long, cpufreq_pressure);
> > +static inline unsigned long cpufreq_get_pressure(int cpu)
> > +{
> > +       return per_cpu(cpufreq_pressure, cpu);
> > +}
> >  #else
> >  static inline unsigned int cpufreq_get(unsigned int cpu)
> >  {
> > @@ -263,6 +269,10 @@ static inline bool cpufreq_supports_freq_invarianc=
e(void)
> >         return false;
> >  }
> >  static inline void disable_cpufreq(void) { }
> > +static inline unsigned long cpufreq_get_pressure(int cpu)
> > +{
> > +       return 0;
> > +}
> >  #endif
> >
> >  #ifdef CONFIG_CPU_FREQ_STAT
> > --
> > 2.34.1
> >

