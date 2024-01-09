Return-Path: <linux-kernel+bounces-20901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B2C828727
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:33:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3BAC2875D4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 13:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D6738FB7;
	Tue,  9 Jan 2024 13:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V27oYiMn"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14ABA3984A
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 13:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-28d7870574bso1259602a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 05:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704807191; x=1705411991; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HpVlVJ/RQGEJ1rvUCc6A3Ljjn+64q3ODdp483E8ssZg=;
        b=V27oYiMnfEBSC4/NnsDz/ERGrt0a33M2SIX+mX2pUoIGtv97Jmz7NnQCc+qviuGb8Z
         EcSMpQ7DZhroilQtmemBgk/FWyvbKyHxBzAHXkfa3g9u4GAYs1NZ64L22IPvOJ7a7da+
         RXQ4I2mlf7mFFS0JMphm9qY0/HiPwzjKrfVu4eufkM0I1j0MFAgt/447HNuIJj4UjKgV
         LDMZ/8SOjWK4dBuqSaKvfuvRbNTp4HtXElvyfg7eRvqGsNO0nq573TYmWOxiuyAXNvlP
         avsirLL5q0E5SfUw6X+Hpdl13x8acjTdWqoHEuKUuZipN5MQJEkdgV38z5vQm1r2mthN
         Ygjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704807191; x=1705411991;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HpVlVJ/RQGEJ1rvUCc6A3Ljjn+64q3ODdp483E8ssZg=;
        b=Rz/2J6/4p8fAa29guUbJ/gbbX5zIPGPFecWoyogeVIFyzO7yJl20nmqNb8L586vSt5
         vKsf6wFAC2jBYrmj0RANnwHLdk/kGcxb70v56HTHwThVLl0IJyxgWumNFzqQV/iNy4gG
         ACjGkzxbpS8Wou4uPVrKEBTttTl+mzNjd4bZV+jVovRwYxPiUSkSMyO5rGSDiacjhIgT
         NC4E5XJ8RXU1/otbSYRtSZSnLDnNh7WRhni6XFLfsbEtcs63yRjhvELCAQYp34DTZnS9
         Gl8TY92AFrjt/d2Mw6uVMmnILFiNy+0caKMGouyWKrhWgLcqMAubMoKFV5N6sd3ukGzn
         VgMQ==
X-Gm-Message-State: AOJu0YwfZnHKERa4EshUxNnCq8TrSKzZYs6/AceWYkUOXhWX8/SZh0+a
	gNH6lGZo4rv3jqYiKUUx9agVmULr0rFuBcMBxeRkcIDy35oPPw==
X-Google-Smtp-Source: AGHT+IF1Jlg21jntY2f/r7bcEmT8wkpsmnUQVYvthZyqxU3f68k3t2w5ZLFd3lOIZRY2u1b3QOC3bVdVc4v5JhmvIaY=
X-Received: by 2002:a17:90a:db45:b0:28b:bc2e:9d5f with SMTP id
 u5-20020a17090adb4500b0028bbc2e9d5fmr1991475pjx.84.1704807191420; Tue, 09 Jan
 2024 05:33:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108134843.429769-1-vincent.guittot@linaro.org>
 <20240108134843.429769-5-vincent.guittot@linaro.org> <0a64731f-f6fa-4382-a5cb-a29061eff2d6@arm.com>
In-Reply-To: <0a64731f-f6fa-4382-a5cb-a29061eff2d6@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 9 Jan 2024 14:33:00 +0100
Message-ID: <CAKfTPtCZVCB1yoocEUjLweodqkLVsF-+WwJzYruD17b0YKxS5A@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] sched: Rename arch_update_thermal_pressure into arch_update_hw_pressure
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

On Tue, 9 Jan 2024 at 12:56, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 08/01/2024 14:48, Vincent Guittot wrote:
> > Now that cpufreq provides a pressure value to the scheduler, rename
>
> I.e. that thermal (e.g. IPA governor) switches from average
> (rq->avg_(thermal/hw).load_avg) (1) to instantenous (cpu_pressure) (2).
> I rememeber a related dicussion during LPC 2018 :-)
>
> > arch_update_thermal_pressure into HW pressure to reflect that it returns
> > a pressure applied by HW (i.e. with a high frequency change) and not
> > always related to thermal mitigation but also generated by max current
> > limitation as an example. Such high frequency signal needs filtering to be
> > smoothed and provide an value that reflects the average available capacity
> > into the scheduler time scale.
>
> So 'drivers/cpufreq/qcom-cpufreq-hw.c' is the only user of (1) right
> now. Are we expecting more users here? If this stays the only user,
> maybe it can do the averages by itself and we can completely switch to (2)?

Yes I expect more users for this high frequency change which is
typically 1ms and below. And I prefer to keep PELT averaging
calculation inside scheduler instead of letting driver doing their own
averaging which will be most of the time not aligned with what
scheduler wants

>
> [...]
>

