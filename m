Return-Path: <linux-kernel+bounces-19861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EED0E8275A7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 17:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20E931C218DE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320C95381B;
	Mon,  8 Jan 2024 16:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pUP2rOtW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2027553E25
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 16:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5ce10b5ee01so1254929a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 08:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704732388; x=1705337188; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hcP4oDQ3eDslDSaUDkl9PzQaFEemmBlUGTQnZjWidg4=;
        b=pUP2rOtW6Xehw5sbW4Db42S3eXL6pYW2eYllWr4cE/Q9bnNaTfOfy1cM8mYZWubd9Z
         rtaVNOTe6OcOY2YwRAL7wh8FCjGxp1gPQdbTndHCfQVcrb2fnYGthuBXnuvWndwMB5/E
         2SC+BM68cnEV6IAyTN7QlvKr1PseDLFkKykt8A/Q+PvGFZgxoOqLxXv4v6y01OFc+cBX
         QdDNQGb8nDrRVQvknzMAT0J5bLR4YE2W5LAh1Hens3v2sqAkmvsfDFsrXhpYrAYJLNpS
         5Zq65cRlis0A16Zg0lkKvJJhcPLNnWPq4TKem4OH7mmUlATYiu51ulayh596kejad5HF
         6vQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704732388; x=1705337188;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hcP4oDQ3eDslDSaUDkl9PzQaFEemmBlUGTQnZjWidg4=;
        b=Pj4fNgNDmqPopzeFqjy3ukauEELGMcGg97WO2wfMfoKKYUymwNU+yMniTpMirLDl24
         j6lWuh2AMvbeH6qz340rJAgb7IHC6iPWP/5RO5zCTmvxVoSeJ3Hdr5XXeIL0v0kf/z1P
         l3ZanOs3LON+dHo3mlHFss6PiTnyXw57nr55096y/M3KYwrBAgkq2WaK5nBWtkS+L7u2
         39eMRs5KQnWAXPXeTAeCz+N24OKGwWTt85j6TYefTljt5ceqqAbANdzeW+gUYwaDwjFi
         IyhgYmYzE4H0D0d3SC68J4MclgVBt1jon5/HAqrCSpFlrCL1AraFzuWoxiiKQDzAUPYo
         M0Gg==
X-Gm-Message-State: AOJu0YwV151pIGEJxxM3mrxmNxB52GRo7fa3JMaIqZq6OWJ1xCvr49iu
	f3CYi50kbtPJAiZr56QNfXcsfmAlZ5tQHPexOWIeIRMuoF5aFw==
X-Google-Smtp-Source: AGHT+IFw0ZW5iYobNEFWZzdpYvN80E//t7DHgMsA/jih0qwTCCuMrTnc/u3iq7XAKVneW1gI6Fz2Ad2vEIHHTTaIGds=
X-Received: by 2002:a05:6a20:1b22:b0:199:995d:e88c with SMTP id
 ch34-20020a056a201b2200b00199995de88cmr5854pzb.24.1704732388407; Mon, 08 Jan
 2024 08:46:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108134843.429769-1-vincent.guittot@linaro.org>
 <20240108134843.429769-2-vincent.guittot@linaro.org> <158a8c60-cb54-43c1-8232-6a0a46cc6d42@arm.com>
In-Reply-To: <158a8c60-cb54-43c1-8232-6a0a46cc6d42@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 8 Jan 2024 17:46:16 +0100
Message-ID: <CAKfTPtC7sM1ZeW4iGN6fzvF9bR0juYePycX3GeWzYQwRBR7XkA@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] cpufreq: Add a cpufreq pressure feedback for the scheduler
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org, 
	sudeep.holla@arm.com, rafael@kernel.org, viresh.kumar@linaro.org, 
	agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org, 
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, bristot@redhat.com, 
	vschneid@redhat.com, lukasz.luba@arm.com, rui.zhang@intel.com, 
	mhiramat@kernel.org, daniel.lezcano@linaro.org, amit.kachhap@gmail.com, 
	corbet@lwn.net, gregkh@linuxfoundation.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	qyousef@layalina.io
Content-Type: text/plain; charset="UTF-8"

On Mon, 8 Jan 2024 at 17:35, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 08/01/2024 14:48, Vincent Guittot wrote:
> > Provide to the scheduler a feedback about the temporary max available
> > capacity. Unlike arch_update_thermal_pressure, this doesn't need to be
> > filtered as the pressure will happen for dozens ms or more.
>
> Is this then related to the 'medium pace system pressure' you mentioned
> in your OSPM '23 talk?
>
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  drivers/cpufreq/cpufreq.c | 36 ++++++++++++++++++++++++++++++++++++
> >  include/linux/cpufreq.h   | 10 ++++++++++
> >  2 files changed, 46 insertions(+)
> >
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index 44db4f59c4cc..fa2e2ea26f7f 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -2563,6 +2563,40 @@ int cpufreq_get_policy(struct cpufreq_policy *policy, unsigned int cpu)
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
> > +     unsigned long max_capacity, capped_freq, pressure;
> > +     u32 max_freq;
> > +     int cpu;
> > +
> > +     /*
> > +      * Handle properly the boost frequencies, which should simply clean
> > +      * the thermal pressure value.
>                ^^^^^^^
> IMHO, this is a copy & paste error from topology_update_thermal_pressure()?
>
> > +      */
> > +     if (max_freq <= capped_freq) {
>
> max_freq seems to be uninitialized.

argh yes, I made crap while cleaning up
both max_freq and capped_freq are uninitialized

>
> > +             pressure = 0;
>
> Is this x86 (turbo boost) specific? IMHO at arm we follow this max freq
> (including boost) relates to 1024 in capacity? Or haven't we made this
> discussion yet?

This is not x86 specific. We can have capped_freq > max_freq on Arm too

Also this bypass all calculation below when max_freq == capped_freq
which is the most common case

>
> > +     } else {
> > +             cpu = cpumask_first(policy->related_cpus);
> > +             max_capacity = arch_scale_cpu_capacity(cpu);
> > +             capped_freq = policy->max;
> > +             max_freq = arch_scale_freq_ref(cpu);
> > +
> > +             pressure = max_capacity -
> > +                        mult_frac(max_capacity, capped_freq, max_freq);
> > +     }
> > +
> > +     for_each_cpu(cpu, policy->related_cpus)
> > +             WRITE_ONCE(per_cpu(cpufreq_pressure, cpu), pressure);
> > +}
> > +
>
> [...]
>

