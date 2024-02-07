Return-Path: <linux-kernel+bounces-56324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F25184C8B3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D141288D2E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905F41427E;
	Wed,  7 Feb 2024 10:32:08 +0000 (UTC)
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FE11426E;
	Wed,  7 Feb 2024 10:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707301928; cv=none; b=h402IQFYays2SVxseuCOBExmdKoWsEUlFa4ca3mvE7j8pGcHemQwmBjTg0/Klw6nRvIWIwmaq0VhvXWV7WOiJ0ULS1pT0QKhp3gTi3ifhCdA0XpsW0DvVF1vYK2LtBqnsZb9q1Qt8lmxwZ9OWibCuTr1zXnvmLd9V99Ui74A3Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707301928; c=relaxed/simple;
	bh=1XKEolIsIp/5hVeT4bPe0rZg6lLF8aMKSVIINjLWPeg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DILIGOB7seEyhJ7E5y3RVgBIMfildd0d4xodijZEkBs7dED3yhM0O8KRYScIP0F64AjfzV01EMCd0em07/ITZf9o0EMVp24an+QFEaGkqbc13mkfkLjf0AUttQHAgXsZUHfQl9wEkcALeRVMCa0y5TCE4QEcYBDpHcDLOCmHVRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6e2b466d213so107965a34.0;
        Wed, 07 Feb 2024 02:32:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707301925; x=1707906725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n5+EowyRiZdMJIElOQsxYtkfwJqzskK9PAiJ97COOrw=;
        b=Cyv7sFy71h2+Y96hOPy1+i0a+zWmVm1nACIXQQzJ5idtV8HttZ+ImM5eTpOKDe0YM4
         QU1Cxq2DPnD1+uZ6O8oWcMAe0l+NWeiT5vzAbnhXBgCRfy/o7OGnxGcLhniAOWnaBeg6
         4EzVG1UaMzx4CQKD8kAPZeysNB16pCHJPwHgzqT7usfs3Yv3qjLO+Kk4cAs8/SMg4eNO
         oqJbZf8mjFe9W+usdz2VYQmrk3qn+OhZhxL74c0+WcH4T5hvHMHAXnWe9Ejwk2CnjP/8
         xvT+gRRGqCDUEHrW389vNIvrj8f8RjXMZEUqpz6XpB/IysZWEpZcg2FfKnRMTig1Wk4x
         Li0Q==
X-Gm-Message-State: AOJu0YzyUR4kKWlf9/o8y7fMY2IWuiEhAMbzOibRgpInMLsx04R9G8Ti
	vtw0ppSXFV38xhwTfGkW4f31fCb2GvyAOhsF47yoixtlaqqaNdnAynyXDCwvgWyRSKXDs4pDk/g
	6C1oJGnVDCnKpPfTex6czja4oApE=
X-Google-Smtp-Source: AGHT+IH1BVO+a12P6PqUM77NbRGVafxf+curnd4kWSdx5YVbXKLueuY1OFk3wJMNbF41fZTMF9J9+svJy82ITSQUpvs=
X-Received: by 2002:a05:6820:405:b0:59a:bfb:f556 with SMTP id
 o5-20020a056820040500b0059a0bfbf556mr5255066oou.0.1707301925587; Wed, 07 Feb
 2024 02:32:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117095714.1524808-1-lukasz.luba@arm.com> <5a38043f-6de3-4038-b1d9-314090e7b44e@arm.com>
In-Reply-To: <5a38043f-6de3-4038-b1d9-314090e7b44e@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 7 Feb 2024 11:31:53 +0100
Message-ID: <CAJZ5v0i-U+Sqbb4z1oBcafWyDfQB=zO3+kKwa2ckdMh6mjsMkw@mail.gmail.com>
Subject: Re: [PATCH v7 00/23] Introduce runtime modifiable Energy Model
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: rafael@kernel.org, dietmar.eggemann@arm.com, linux-pm@vger.kernel.org, 
	rui.zhang@intel.com, amit.kucheria@verdurent.com, amit.kachhap@gmail.com, 
	daniel.lezcano@linaro.org, viresh.kumar@linaro.org, len.brown@intel.com, 
	pavel@ucw.cz, mhiramat@kernel.org, qyousef@layalina.io, 
	linux-kernel@vger.kernel.org, wvw@google.com, xuewen.yan94@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lukasz,

On Wed, Feb 7, 2024 at 10:15=E2=80=AFAM Lukasz Luba <lukasz.luba@arm.com> w=
rote:
>
> Hi Rafael,
>
> On 1/17/24 09:56, Lukasz Luba wrote:
> > Hi all,
> >
> > This patch set adds a new feature which allows to modify Energy Model (=
EM)
> > power values at runtime. It will allow to better reflect power model of
> > a recent SoCs and silicon. Different characteristics of the power usage
> > can be leveraged and thus better decisions made during task placement i=
n EAS.
> >
>
> [snip]
>
> >
> >
> > Lukasz Luba (23):
> >    PM: EM: Add missing newline for the message log
> >    PM: EM: Extend em_cpufreq_update_efficiencies() argument list
> >    PM: EM: Find first CPU active while updating OPP efficiency
> >    PM: EM: Refactor em_pd_get_efficient_state() to be more flexible
> >    PM: EM: Introduce em_compute_costs()
> >    PM: EM: Check if the get_cost() callback is present in
> >      em_compute_costs()
> >    PM: EM: Split the allocation and initialization of the EM table
> >    PM: EM: Introduce runtime modifiable table
> >    PM: EM: Use runtime modified EM for CPUs energy estimation in EAS
> >    PM: EM: Add functions for memory allocations for new EM tables
> >    PM: EM: Introduce em_dev_update_perf_domain() for EM updates
> >    PM: EM: Add em_perf_state_from_pd() to get performance states table
> >    PM: EM: Add performance field to struct em_perf_state and optimize
> >    PM: EM: Support late CPUs booting and capacity adjustment
> >    PM: EM: Optimize em_cpu_energy() and remove division
> >    powercap/dtpm_cpu: Use new Energy Model interface to get table
> >    powercap/dtpm_devfreq: Use new Energy Model interface to get table
> >    drivers/thermal/cpufreq_cooling: Use new Energy Model interface
> >    drivers/thermal/devfreq_cooling: Use new Energy Model interface
> >    PM: EM: Change debugfs configuration to use runtime EM table data
> >    PM: EM: Remove old table
> >    PM: EM: Add em_dev_compute_costs()
> >    Documentation: EM: Update with runtime modification design
> >
> >   Documentation/power/energy-model.rst | 183 ++++++++++-
> >   drivers/powercap/dtpm_cpu.c          |  39 ++-
> >   drivers/powercap/dtpm_devfreq.c      |  34 +-
> >   drivers/thermal/cpufreq_cooling.c    |  45 ++-
> >   drivers/thermal/devfreq_cooling.c    |  49 ++-
> >   include/linux/energy_model.h         | 165 ++++++----
> >   kernel/power/energy_model.c          | 472 +++++++++++++++++++++++---=
-
> >   7 files changed, 819 insertions(+), 168 deletions(-)
> >
>
> The patch set went through decent review. If you don't have any issues,
> I will collect the tags and send the v8 which will be re-based on some
> recent linux next (or please tell me your preferred branch).

Blease base it on 6.8-rc3.

