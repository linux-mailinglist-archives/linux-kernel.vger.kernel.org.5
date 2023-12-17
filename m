Return-Path: <linux-kernel+bounces-2761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FFEC81617A
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 18:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50CC21C20CFC
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 17:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BED447A64;
	Sun, 17 Dec 2023 17:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="Xb29EMtd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BB847A52
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 17:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40c2308faedso28508715e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 09:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1702835911; x=1703440711; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zjSwC3QXCT9m5wbkVuevhDt7iqPHObPwr4PaZ7/DBvg=;
        b=Xb29EMtdbGMF/h516UcwPoHjzWU7nv81dZL+7k3HWPDIrVrBkrFOyzT1AcMbpkCbzK
         k0YbbZIPUGn+M3w3MeGaQ+9CAjXuzkeywngdoyCviYCmFZv4SF5D5Kisx8rdXQhmKNMJ
         mhZGeR96XcCEbZhNAmMHcTU/Q4KFkaU7RKH/87Tl12i6iOZzTtqjcw32f/tvCVi3Ix9T
         ObtRMG6AvVbXiq3BpAB1iTqnl/mdRd/lOUyin44mqgkDsvtyBUJii/nevJ3v9oXJ7Xk1
         6x30y0R1QRXXYKAL+Do0hwXHt1Yx1l1tUiB+OjMwbjUR22GMdQcCdq7EmVYxm0MhjULF
         65OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702835911; x=1703440711;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zjSwC3QXCT9m5wbkVuevhDt7iqPHObPwr4PaZ7/DBvg=;
        b=OGHcA+EI2+2MZcTgzbC5osMKzrrLJq/nncY2uYvNW7t05Ko7k8Qf55uN1ixBYgGYL3
         UYrLAsN0OHcl8yIoVHa+ReWT+zNZNOp56vcE1korbDlWasfpZzCp4zV/qmso3JApfaDb
         xww3e9y9BNrrxzRTHYeoxLCOi5dHENC4OtndyPNRLvEcYWC0VV5jGzJ95DtcW2xX5xlH
         6kxkVvR7SsPARRfWInikohBloX+LAgb6D42yu39mF7ACFiJF2OviyaTQehCtl0Dy31+n
         zXjCuZUJX7U3CK+JLuPBvSqZZLWUsDYBcBKcUl9yo9UqLcxyQXQt1+65SN8mWNBD2Nm5
         R4SA==
X-Gm-Message-State: AOJu0YxowZCQxqsgFLgdqhCv97HbY+K29fi6KlgmjecyjrtWqnJyxjN5
	LMRKclwkL/Uex7rQu/WqNkPJqw==
X-Google-Smtp-Source: AGHT+IHktBGekQOiJ92lEz2pskG1CMlNkvRmzusZ08VRymePko2LN9lBbaQGbObPXE3ogeCuXc4ZkQ==
X-Received: by 2002:a05:600c:350c:b0:40c:2990:45c7 with SMTP id h12-20020a05600c350c00b0040c299045c7mr8164302wmq.86.1702835910479;
        Sun, 17 Dec 2023 09:58:30 -0800 (PST)
Received: from airbuntu (host86-135-101-43.range86-135.btcentralplus.com. [86.135.101.43])
        by smtp.gmail.com with ESMTPSA id q12-20020a05600c46cc00b0040b4c59f133sm38711691wmo.1.2023.12.17.09.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 09:58:30 -0800 (PST)
Date: Sun, 17 Dec 2023 17:58:29 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	rafael@kernel.org, dietmar.eggemann@arm.com, rui.zhang@intel.com,
	amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
	daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
	len.brown@intel.com, pavel@ucw.cz, mhiramat@kernel.org,
	wvw@google.com
Subject: Re: [PATCH v5 03/23] PM: EM: Find first CPU active while updating
 OPP efficiency
Message-ID: <20231217175829.a6hqz7mqlvrujsvs@airbuntu>
References: <20231129110853.94344-1-lukasz.luba@arm.com>
 <20231129110853.94344-4-lukasz.luba@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231129110853.94344-4-lukasz.luba@arm.com>

On 11/29/23 11:08, Lukasz Luba wrote:
> The Energy Model might be updated at runtime and the energy efficiency
> for each OPP may change. Thus, there is a need to update also the
> cpufreq framework and make it aligned to the new values. In order to
> do that, use a first active CPU from the Performance Domain. This is
> needed since the first CPU in the cpumask might be offline when we
> run this code path.

I didn't understand the problem here. It seems you're fixing a race, but the
description is not clear to me what the race is.

> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  kernel/power/energy_model.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> index 42486674b834..aa7c89f9e115 100644
> --- a/kernel/power/energy_model.c
> +++ b/kernel/power/energy_model.c
> @@ -243,12 +243,19 @@ em_cpufreq_update_efficiencies(struct device *dev, struct em_perf_state *table)
>  	struct em_perf_domain *pd = dev->em_pd;
>  	struct cpufreq_policy *policy;
>  	int found = 0;
> -	int i;
> +	int i, cpu;
>  
>  	if (!_is_cpu_device(dev) || !pd)
>  		return;
>  
> -	policy = cpufreq_cpu_get(cpumask_first(em_span_cpus(pd)));
> +	/* Try to get a CPU which is active and in this PD */
> +	cpu = cpumask_first_and(em_span_cpus(pd), cpu_active_mask);
> +	if (cpu >= nr_cpu_ids) {
> +		dev_warn(dev, "EM: No online CPU for CPUFreq policy\n");
> +		return;
> +	}
> +
> +	policy = cpufreq_cpu_get(cpu);

Shouldn't policy be NULL here if all policy->realted_cpus were offlined?


Cheers

--
Qais Yousef

>  	if (!policy) {
>  		dev_warn(dev, "EM: Access to CPUFreq policy failed\n");
>  		return;
> -- 
> 2.25.1
> 

