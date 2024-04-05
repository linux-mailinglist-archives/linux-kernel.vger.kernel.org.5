Return-Path: <linux-kernel+bounces-132846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4050E899B15
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8292282214
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F65A18E02;
	Fri,  5 Apr 2024 10:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y4kZtx7H"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD1C28E34
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 10:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712313830; cv=none; b=KCmTb0G+DotEV+M7OBy1fVil1md9M932tzG+UZhnP9Dc9AOio+z2oLW1PxZCGY4juBAJN17TkMZ+8pAQGHvJuDS2Z66tzLCxQgYdZMd22bUVPZogW7wPvLCHr9i4CFTGVVS/A/bJyyQl7uzke8xNbklljJkFoWG+CuF3pAH0W58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712313830; c=relaxed/simple;
	bh=7C/5UZ82qZYHIwBYCH/b91zTPm2w3L2sycm6zi6fjFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gPW6Qe7g9U09QDOVo9cC3UbEQloEOTZvOqV9/fvEi6l+Yr4H01OmDExzfUQud1S+qY+9vIwq9bFIXgSvJupuQV/zGrMptvhw9B2KI28OzQN2HCkwhSgDWmy7lxVs6ohFleJYvPPd5qRfWMVkH+B+q9hyfWhd9HdZ6mTPvBjtGQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y4kZtx7H; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-53fa455cd94so1678610a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 03:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712313828; x=1712918628; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OV4Gr8neyIZMoii5TkHku5I1pPAWBRVzVd5KTEEicxc=;
        b=Y4kZtx7HEkC1ueRNR9dNRWDHltJCvdIRKr6QtvINdDOW9LJU+bZ6N8Cp/okIPxnME0
         Vm1U2YbPlIXGS6AFqcrgyfYcXQoCSE3Krnj9FEtfngqwB9+Hm8BBd8Y6S8r2ZLypFMB/
         Pm9ENrU+1PlliCJ3h/KUFLYJ/2rk0tiNBEiFOHi4j031EZ2C3riOXS7Fbdta1yggIAr1
         WC4RshRgcDSh4NyICI0Cw+czw9xMMujTbyUSdc5rRtToyZRx7ffFI5CnGSfk9cYKzj1u
         lk4qRKdlqfrlz0wc4r/Ck/uvwHM5nM1jN/urmX0hrNzQPrYzj7aEIMZAYRtlhYCEs2JC
         gGzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712313828; x=1712918628;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OV4Gr8neyIZMoii5TkHku5I1pPAWBRVzVd5KTEEicxc=;
        b=SOq1GRS9MzSNS+KhtMD1VQ8AAizZAuwSAqsg5L6n2itC2DL7IAzSlehC11A25t6Uyy
         8/89bXxn+5LvmQZq7z09sfRTQY9U6HOpGTmk7TCZZ7GX86+OFBpCyf0PsagDc5SWUCKo
         SP+ecl+C+zndmlRzvkgPeDGBEz0wSNNoa+RGsC4ZJww0uAZg8lith+GMD/IrRoUi7o/d
         3k6OFKGkZUr9vuL82s2oY0YGDKOy6xbEkLxio35479U8lxVuqRkftDPw/NnpTCwg+Tks
         AZ+2ut+fHOuBgW3o3JanWbzdXNCZDL4q3jYd2WeeYAiL2ymUCkBUDBbYIwGUkTdZHJNY
         N7EQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjI+GLv4e7snKQFujCfbe7gMeUWFZLzMFkBRe0KuufKtRmyBvRPPSkVfnlfDlUOH4HqiSgSq7VrreXF9svlb0Gkx/wBr75e2D7ykiY
X-Gm-Message-State: AOJu0YyygPJqN0SNYmx0oPcMxqBNGmjqawyoQpcy7RgYfpKvsSvZBBXq
	MCjGE/q9OzspMxXVkcxScDzd5rv9Ve2AXg57H7S2ipGHM2M4qsnMrOyYwI/RLbc=
X-Google-Smtp-Source: AGHT+IEHh74q9CMsOrU6OsYsQfAok8LvDJdvMvAqww4JBXgggCs2EKE/0m+u/9H3FLEhSawgz43Opw==
X-Received: by 2002:a05:6a20:5509:b0:1a3:d618:cfdf with SMTP id ko9-20020a056a20550900b001a3d618cfdfmr937992pzb.26.1712313828015;
        Fri, 05 Apr 2024 03:43:48 -0700 (PDT)
Received: from localhost ([122.172.85.136])
        by smtp.gmail.com with ESMTPSA id l18-20020a170903245200b001e293a6ec19sm1239761pls.230.2024.04.05.03.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 03:43:47 -0700 (PDT)
Date: Fri, 5 Apr 2024 16:13:45 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Aleksandr Mishin <amishin@t-argos.ru>
Cc: Ionela Voinescu <ionela.voinescu@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] cppc_cpufreq: Fix possible null pointer dereference
Message-ID: <20240405104345.kcb55mwhdcpdv53x@vireshk-i7>
References: <20240405094005.18545-1-amishin@t-argos.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405094005.18545-1-amishin@t-argos.ru>

On 05-04-24, 12:40, Aleksandr Mishin wrote:
> cppc_cpufreq_get_rate() and hisi_cppc_cpufreq_get_rate() can be called from
> different places with various parameters. So cpufreq_cpu_get() can return
> null as 'policy' in some circumstances.
> Fix this bug by adding null return check.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: a28b2bfc099c ("cppc_cpufreq: replace per-cpu data array with a list")
> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 64420d9cfd1e..5f7e04e8497b 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -741,6 +741,9 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
>  {
>  	struct cppc_perf_fb_ctrs fb_ctrs_t0 = {0}, fb_ctrs_t1 = {0};
>  	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
> +	if (!policy)
> +		return -ENODEV;
> +
>  	struct cppc_cpudata *cpu_data = policy->driver_data;
>  	u64 delivered_perf;
>  	int ret;
> @@ -822,6 +825,9 @@ static struct cpufreq_driver cppc_cpufreq_driver = {
>  static unsigned int hisi_cppc_cpufreq_get_rate(unsigned int cpu)
>  {
>  	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
> +	if (!policy)
> +		return -ENODEV;
> +
>  	struct cppc_cpudata *cpu_data = policy->driver_data;
>  	u64 desired_perf;
>  	int ret;

Does this compile fine ?

-- 
viresh

