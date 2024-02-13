Return-Path: <linux-kernel+bounces-63437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07382852F48
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 562F3B21F46
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA30D381B8;
	Tue, 13 Feb 2024 11:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TO3y8Ree"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B9F38DCD
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 11:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707823648; cv=none; b=AWEUM+FXIG1a8TPglXbZjVpfvS0/ykCRUOprYzw1xjdRqWN5ZhTCrmW10gwnBCpGUbbYbuHgnyYlZjq/vbKLLKuijIVf8uJ5E/u4EsY8kkgnhcVY7Jnkse1OGirQSOA3CyOJ2qXWMVnepWabKJes3HXkrDWj7SiS+5LX7zul3yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707823648; c=relaxed/simple;
	bh=Kclnb04BY0C4ljJ3zVSxBouZ+rwMgrCaisAJwnrCKhc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XzL/mFsvoSB7Fpl/mClXiy+Nzz8MN3kWeaSGdH0nAuPs32yfYmkaEIPufNAN37cEYAE2KIONHUttaT0E55c65TV7MyJwBHASvCq2GfrquGHe6sqZFEHBe/XlTTR7qGoFKL1uhzxMYHpYy+bjtCrP/uB17Lo6DN0imX44Ryh2f7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TO3y8Ree; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5dbcfa0eb5dso3902156a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 03:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707823646; x=1708428446; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sxqpdHvCilRcVXHUhBIeUrNxDR9OMFt9/5Rvsq+VzvI=;
        b=TO3y8ReecrhR1JTYkZ8FMKKvsRLWgimkarfv8IRg5Cg8FQazhqmROAsPHAD9Gjm8Ng
         NsRFZPPRzcQgv7qss1JWfmt9lvuncHA6fyFmcOQtkZewxfV3ooCSyxwYw6dGbfBd04Ye
         MTvgG7RUImvulgRaqeY2f3QhBIET121zZ8GR7hrFbG/tkOczYnyWTxl2FooGFJjchZf1
         rZo9u+FjEvmu8auxnmaxhF4g2aJhqUwk541PYeAy6EPXrxi2XSdCfO4Ol+yCW4fC9g0y
         mk2NPcR2wyrKa1JuUSeigUm8oKP8bNeVQUCWS661mMf1A7HS9vv8AvNtPD5DKx4YoOAz
         AO/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707823646; x=1708428446;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sxqpdHvCilRcVXHUhBIeUrNxDR9OMFt9/5Rvsq+VzvI=;
        b=iisO49JO5mhADPBuMCkpOTunHOnTRK72SruQ6GuUkb+5jvmd1qerdTFqANTjSOi7Zr
         5r0DBNQ1b+8ecBOtUuh/4XJHMbb4WBcpJu4DIEY2QoauLzuGeobz0t1v4b+j1hc614/I
         OXPdgQEI2R2ozPMC4Hx7ItW9MIvv6XC5VqGpinU86gBAbBNxPRVTWnelNhFaozIhieZd
         Co6HhEdmu9uIYNOnBL1QO6Xr3Cg+5mBBmtidrinTycvnH/wNTNmwSTNxtWrZ3r+7rM6t
         tJyz+H61Mukr0tCtWX2QtuOm/+PyREjhUPAhFjHhRWu/JdVMIRvKFxryreXJPA+8u3Jk
         17UA==
X-Forwarded-Encrypted: i=1; AJvYcCV1WT2WUttlz6x9I91ugzN2gp3wV14jJD+XGjNFlm8alkvfRg/HggbiXX5M28PwNypE9uKeZeKRSog4/HHaLeluVbh51UagQbg/TpU+
X-Gm-Message-State: AOJu0Yyxy3v6evAFX4aa/fZGzn05gPYFqm2FcLCcyISoAPgqya0p9Gb/
	cR3ft4pf5jpKpfQAevcgl2kvzrd4Jx4WvMRZToBrUdwrkydQ++BrPqe2q9QiRfchKp4qAV6VPTo
	f5Nt2sYKS7gdh3oV59ibT/GwruBkcYDpvRy02nQ==
X-Google-Smtp-Source: AGHT+IEyEKDl694KOOGPeEdpUjGKo9ifrYbsCOxVohv+90YnyiFic31rEHSQFLvsBzUeW7zed3Qxqs6HuF9kIBx9nBo=
X-Received: by 2002:a17:90a:d504:b0:293:d50c:b704 with SMTP id
 t4-20020a17090ad50400b00293d50cb704mr5488643pju.19.1707823645870; Tue, 13 Feb
 2024 03:27:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <002f01da5ba0$49cbf810$dd63e830$@telus.net> <CAKfTPtA-jizig0sh_shmkAMudAxDPYHP0SdanZe=Gc57jVKouQ@mail.gmail.com>
 <003801da5bae$02d6f550$0884dff0$@telus.net> <CAKfTPtC7pOtb-srrgQLFbTueLLDqHay+GQBm9=sNsnZDg_UYSQ@mail.gmail.com>
 <000b01da5d09$8219f900$864deb00$@telus.net>
In-Reply-To: <000b01da5d09$8219f900$864deb00$@telus.net>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 13 Feb 2024 12:27:14 +0100
Message-ID: <CAKfTPtB8v30LzL3EufRqbfcCceS2nQ_2G8ZHuoD5N1_y-pvFbg@mail.gmail.com>
Subject: Re: sched/cpufreq: Rework schedutil governor performance estimation -
 Regression bisected
To: Doug Smythies <dsmythies@telus.net>
Cc: Ingo Molnar <mingo@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 11 Feb 2024 at 17:43, Doug Smythies <dsmythies@telus.net> wrote:
>
> On 2024.02.11 05:36 Vincent wrote:
> > On Sat, 10 Feb 2024 at 00:16, Doug Smythies <dsmythies@telus.net> wrote:
> >> On 2024.02.09.14:11 Vincent wrote:
> >>> On Fri, 9 Feb 2024 at 22:38, Doug Smythies <dsmythies@telus.net> wrote:
> >>>>
> >>>> I noticed a regression in the 6.8rc series kernels. Bisecting the kernel pointed to:
> >>>>
> >>>> # first bad commit: [9c0b4bb7f6303c9c4e2e34984c46f5a86478f84d]
> >>>> sched/cpufreq: Rework schedutil governor performance estimation
> >>>>
> >>>> There was previous bisection and suggestion of reversion,
> >>>> but I guess it wasn't done in the end. [1]
> >>>
> >>> This has been fixed with
> >>> https://lore.kernel.org/all/170539970061.398.16662091173685476681.tip-bot2@tip-bot2/
> >>
> >> Okay, thanks. I didn't find that one.
> >>
> >>>> The regression: reduced maximum CPU frequency is ignored.
>
> Perhaps I should have said "sometimes ignored".
> With a maximum CPU frequency for all CPUs set to 2.4 GHz and
> a 100% load on CPU 5, its frequency was sampled 1000 times:
> 28.6% of samples were 2.4 GHz.
> 71.4% of samples were 4.8 GHz (the max turbo frequency)
> The results are highly non-repeatable, for example another sample:
> 32.8% of samples were 2.4 GHz.
> 76.2% of samples were 4.8 GHz
>
> Another interesting side note: If load is added to the other CPUs,
> the set maximum CPU frequency is enforced.

Could you trace cpufreq and pstate ? I'd like to understand how
policy->cur can be changed
whereas there is this comment in intel_pstate_set_policy():
        /*
         * policy->cur is never updated with the intel_pstate driver, but it
         * is used as a stale frequency value. So, keep it within limits.
         */

but cpufreq_driver_fast_switch() updates it with the freq returned by
intel_cpufreq_fast_switch()

>
> >>
> >>> This seems to be something new.
> >>> schedutil doesn't impact the max_freq and it's up to cpufreq driver
> >>> select the final freq which should stay within the limits
> >>
> >> Okay. All I know is this is the commit that caused the regression.
> >
> > Could you check if the fix solved your problem ?
>
> Given the tags for that commit:
>
> $ git tag --contains e37617c8e53a
> v6.8-rc1
> v6.8-rc2
> v6.8-rc3
>
> It does not solve issue I have raised herein, as it exists in v6.8-rc1 but not v6.7
>
> >> I do not know why, but I do wonder if there could any relationship with
> >> the old, never fixed, problem of incorrect stale frequencies reported
> >> under the same operating conditions. See the V2 note:
> >> https://lore.kernel.org/all/001d01d9d3a7$71736f50$545a4df0$@telus.net/
> >
> > IIUC the problem is that policy->cur is not used by intel_cpufreq and
> > stays set to the last old/init value.
>
> Yes, exactly.
>
> > Do I get it right that this is only informative ?
>
> I don't know, that is what I was wondering. I do not know if the two issues
> are related or not.
>
> > Normally cpufreq governor checks the new limits and updates current
> > freq if necessary except when fast switch is enabled.
>
> >> where I haven't been able to figure out a solution.
>
> >>>> Conditions:
> >>>> CPU frequency scaling driver: intel_cpufreq (a.k.a intel_pstate in passive mode)
> >>>> CPU frequency scaling governor: schedutil
> >>>> HWP (HardWare Pstate) control (a.k.a. Intel_speedshift): Enabled
> >>>> Processor: Intel(R) Core(TM) i5-10600K CPU @ 4.10GHz
> >>>>
> >>>> I did not check any other conditions, i.e. HWP disabled or the acpi-cpufreq driver.
>
> Changing from HWP enabled to HWP disabled, it works properly.
>
> ...
>
> >>>> [1] https://lore.kernel.org/all/CAKfTPtDCQuJjpi6=zjeWPcLeP+ZY5Dw7XDrZ-LpXqEAAUbXLhA@mail.gmail.com/
>
>

