Return-Path: <linux-kernel+bounces-25054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A6B82C6F8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 23:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D7182863B8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 22:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F41C17734;
	Fri, 12 Jan 2024 22:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hv5cXUtY"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C9F175B0
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 22:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-428405a0205so16241cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 14:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705096996; x=1705701796; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9lHgN5qvgn7BlYDMVD9NaB939Lp8cACoBD9pFBrl1e8=;
        b=hv5cXUtYVrK6GgP8gCLp8elexbbAzOMHeHxdrGzKjJHSHhzZuAn2l5l4hmLcOSNec2
         s1D6o0mR+YzVGQ4SkznC4YSDeAvVc4CwETOe6kmCh9VfrvtYaC30C1slmKRLM1jZ4Enk
         6M5SPt2+wvMEJrgOxbjsRrlrNrHnwgvNacty1W6/dRr+NU+RU33kp9CtMvLKAmheoHhg
         vAYty9zdaftg0t/7ZVD5u/EdS76Th7PSqdslWBeaSRMaOw+x1lX43IsxRuCWq1OizN3/
         uKrdT52RxnqS29Jh59lIOu2Dm6tgHK7m2lfspAZaObHZh5YAhJuWSHz/j7sKmYJ06OwI
         BTMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705096996; x=1705701796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9lHgN5qvgn7BlYDMVD9NaB939Lp8cACoBD9pFBrl1e8=;
        b=DaaBgrtGy1+WwrR+aOZFPD3NqXF5Vrdlg8GNsY6km2ueX/hRI5bZpbxlbsyPO5pDrc
         cxbH5yCz+8hLLWWUsaQTrSujwNReFx2qEtV3AzvCA1okB4k7WA9e7uvgAxw9DXQUwt2q
         Uyx/0KJVPzf4Sneb3rHaTbDGwdQ3oiekwVTomHahdA1JmWT8HyRwHSuedco0Fpw/GjKe
         9GSA+FN4EtIm6z/7B0qb9HucfuYuKASQ+Fac8aUYbcRdySmgT9lA7Y5LxssGwDBIXOhP
         5K4ieKLjLyvy+afbl+HKX5NxO1qxaGhbZtSg4Sxm4n2FJ/F0U8PdxnIyFXbknhTtvXSJ
         RIMg==
X-Gm-Message-State: AOJu0YyGgFr2kWLaJ9wzQH5mpqyoKu7GT93EAYQToA19moiZnE1jWHVS
	TPWiqD5FeWe3Su+tGAQMmBgMWwrCJNCt9mubyc//uMVp6LnO
X-Google-Smtp-Source: AGHT+IFYF/m2xgNcuqcb4/FbnoeqqUGLh9dFt6e8c8HCujTIksvXc3E02pJYkniEr3zNANu4be8EiMzLheZdRMp6fy8=
X-Received: by 2002:a05:622a:14c8:b0:429:c835:cd9f with SMTP id
 u8-20020a05622a14c800b00429c835cd9fmr524482qtx.12.1705096995694; Fri, 12 Jan
 2024 14:03:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231111014933.1934562-1-davidai@google.com> <20231111014933.1934562-2-davidai@google.com>
 <865y231jvj.wl-maz@kernel.org> <CAGETcx9-n0z5buWgtLZ+6VxW2jEko1GWzkGtGhFiZEq-x_G4nw@mail.gmail.com>
 <867clpaxel.wl-maz@kernel.org>
In-Reply-To: <867clpaxel.wl-maz@kernel.org>
From: Saravana Kannan <saravanak@google.com>
Date: Fri, 12 Jan 2024 14:02:39 -0800
Message-ID: <CAGETcx_8x4p7WTwqQiVGdtHftVjFUJruXsOXwJXgDi0GdEtLNA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: cpufreq: add virtual cpufreq device
To: Marc Zyngier <maz@kernel.org>
Cc: David Dai <davidai@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sudeep Holla <sudeep.holla@arm.com>, Quentin Perret <qperret@google.com>, 
	Masami Hiramatsu <mhiramat@google.com>, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Pavan Kondeti <quic_pkondeti@quicinc.com>, Gupta Pankaj <pankaj.gupta@amd.com>, 
	Mel Gorman <mgorman@suse.de>, kernel-team@android.com, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry for the delay in response. Was very busy for a while and then
holidays started.

On Fri, Dec 8, 2023 at 12:52=E2=80=AFAM Marc Zyngier <maz@kernel.org> wrote=
:
>
> On Thu, 07 Dec 2023 22:44:36 +0000,
> Saravana Kannan <saravanak@google.com> wrote:
> >
> > On Wed, Nov 15, 2023 at 12:49=E2=80=AFAM Marc Zyngier <maz@kernel.org> =
wrote:
> > >
> > > On Sat, 11 Nov 2023 01:49:29 +0000,
> > > David Dai <davidai@google.com> wrote:
> > > >
> > > > Adding bindings to represent a virtual cpufreq device.
> > > >
> > > > Virtual machines may expose MMIO regions for a virtual cpufreq devi=
ce
> > > > for guests to read frequency information or to request frequency
> > > > selection. The virtual cpufreq device has an individual controller =
for
> > > > each frequency domain.
> > >
> > > I would really refrain form having absolute frequencies here. A
> > > virtual machine can be migrated, and there are *zero* guarantees that
> > > the target system has the same clock range as the source.
> > >
> > > This really should be a relative number, much like the capacity. That=
,
> > > at least, can be migrated across systems.
> >
> > There's nothing in this patch that mandates absolute frequency.
> > In true KVM philosophy, we leave it to the VMM to decide.
>
> This has nothing to do with KVM. It would apply to any execution
> environment, including QEMU in TCG mode.
>
> To quote the original patch:
>
> +    description:
> +      Address and size of region containing frequency controls for each =
of the
> +      frequency domains. Regions for each frequency domain is placed
> +      contiugously and contain registers for controlling DVFS(Dynamic Fr=
equency
> +      and Voltage) characteristics. The size of the region is proportion=
al to
> +      total number of frequency domains.
>
> What part of that indicates that *relative* frequencies are
> acceptable? The example explicitly uses the opp-v2 binding, which
> clearly is about absolute frequency.

We can update the doc to make that clearer and update the example too.

> To reiterate: absolute frequencies are not the right tool for the job,
> and they should explicitly be described as relative in the spec. Not
> left as a "whatev'" option for the execution environment to interpret.

I think it depends on the use case. If there's no plan to migrate the
VM across different devices, there's no need to do the unnecessary
normalization back and forth.

And if we can translate between pCPU frequency and a normalized
frequency, we can do the same for whatever made up frequencies too. In
fact, we plan to do exactly that in our internal use cases for this.
There's nothing here that prevents the VMM from doing that.

Also, if there are hardware virtualized performance counters (AMU,
CPPC, etc) that are used for frequency normalization, then we have to
use the real frequencies in those devices otherwise the "current
frequency" can be 2 GHz while the max normalized frequency is 1024
KHz. That'll mess up load tracking.

Thanks,
Saravana

