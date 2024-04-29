Return-Path: <linux-kernel+bounces-162096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F478B55C7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07A091F2361D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 10:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F6D39AC7;
	Mon, 29 Apr 2024 10:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jKnJiCly"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95261EB2F
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 10:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714387790; cv=none; b=VwoGAPSl/6CZtFK5rZaUyCiCmDsg5013lc6x6Wmi/qJs8Ph0JJsmXDGQ+CdaiI9060RhuQybj5jW5bpJII5XN61h2pItzuhcQVFPtHY/+G4QrS/S1n2Q3LkWAb2LHq1ljvmUXFsDtCxlWo/r1AhsH7WnRrYnrO1ebbAA9aR5508=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714387790; c=relaxed/simple;
	bh=UJFvPPh0/QlMypN0TnrTOQMDf0epez0uqhSyuMj9eqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nM0zl9xnOKwt+DeUL1gkc5C9lasKFDpngY1+Ookx0la84GogdFoktNa22Cg5QJ81zQzz3cDSVU8TO+vCJsTmJDovG8Z8PJWJfmRFSvjUndpIHuHkRu77eSRj1g9cTktOdRLuKi2Xdn8JfedvZloXxAu2uY9Dndm0SvudGEeS3xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jKnJiCly; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5d8b519e438so3225219a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 03:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714387788; x=1714992588; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u+iVpNJBX2gJKOKBcpgOxaTNFvPSLwXG51MweiMNRXw=;
        b=jKnJiClyIDKR1ryiOhdLJ6YyD/KhD+p7gE2Ix2WGW/nRyE1G/cP1/hzqMz8hP7vQ1X
         WlPsGpBpoAcIHLGTCyQAcWizd8cI8PxXBg3QclkgH8A96eqYFrklL8/5RXwvE5gY6AR1
         yUMhmnMCGGQ00oyZiqUjJaM1yeJ7DII4oSVYDc/+rA++GIk/qG8SpoikjdDeqE2hK0CQ
         U5DE/ND7J3NmootVEswVkVvKXY/uQhV5KZEsMv6zruxbJoabs424nfUNEEN50KxZq/7S
         6DqlcS6PUySFeO9LvA/KPV7+OIx7yO2tCTHZck6a+/Me4Ad/qSz6sJ7Qu4tdpVtoK+AJ
         vzzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714387788; x=1714992588;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u+iVpNJBX2gJKOKBcpgOxaTNFvPSLwXG51MweiMNRXw=;
        b=DHjXIzlihZ6tXhdSk0fQ/c4ld8qd5rLOZi2ENciozbcBWmv2G11wRLRUqtVYw0HxHV
         pGmdjrxYb3S02TNLTitMdY814GT2VHUfiAS79fWY2VbFvSDTRqxerFEq8EoBVdGmLF1w
         1hcqN3N2VZwIVmRsdr1gtlCLvS8nexFtNPOuUevFCRw0SCpkk12lhxzW8fWu3LNWGO4f
         nlkBOYRXkTWEBRiyzGqVeYDaHpKqOb8eCeOaLze8/Eq0PPiIAQms1VFC1VHw4EoxtcC8
         znrTt/WrhAC0gVZwuaRg2nWOW7J2qE0hbj+ST1rXLcXa7vDO+80UgHaesGDuvicddezx
         60wg==
X-Forwarded-Encrypted: i=1; AJvYcCWbvK29tzOxxqCy6coVD+50ZNaTfjUYmi3doJOEtecjSzJ57JMAVacXNYyhtuO3n+IXKKAdkDoXypX0aHzIis/mNkUm4s632aVgqfXQ
X-Gm-Message-State: AOJu0YyCsnftSL2MoB7Gy+Pli1lmevhtC7Tf8yfBcIfxVWKKx7c4Qy47
	UPCiu/Zz/wnW7ugM2xKFBYyoLWmdUeSGdgQJk5Ty1lBgzv8nca69SuvcOSgjKGU=
X-Google-Smtp-Source: AGHT+IF/8CnN46xmrbPDkOtSJdBW9Qtb34t0WWC6WBtBIZPr1+8/WhFiLRP0oSRWZZcJ7UzLVUxBwg==
X-Received: by 2002:a05:6a21:78a4:b0:1a5:6a85:8ce9 with SMTP id bf36-20020a056a2178a400b001a56a858ce9mr11659322pzc.12.1714387788049;
        Mon, 29 Apr 2024 03:49:48 -0700 (PDT)
Received: from localhost ([122.172.87.52])
        by smtp.gmail.com with ESMTPSA id g2-20020a170902934200b001e25da6f2f2sm19985099plp.68.2024.04.29.03.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 03:49:47 -0700 (PDT)
Date: Mon, 29 Apr 2024 16:19:45 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: liwei <liwei728@huawei.com>, Ionela Voinescu <ionela.voinescu@arm.com>,
	Beata Michalska <beata.michalska@arm.com>,
	Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
Cc: rafael@kernel.org, al.stone@linaro.org, ashwin.chaugule@linaro.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	liwei391@huawei.com, liaoyu15@huawei.com
Subject: Re: [PATCH] cpufreq/cppc: changing highest_perf to nominal_perf in
 cppc_cpufreq_cpu_init()
Message-ID: <20240429104945.esdukn6ayudgyumc@vireshk-i7>
References: <20240428092852.1588188-1-liwei728@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240428092852.1588188-1-liwei728@huawei.com>

CC'ing few folks who are working with the driver.

On 28-04-24, 17:28, liwei wrote:
> When turning on turbo, if frequency configuration takes effect slowly,
> the updated policy->cur may be equal to the frequency configured in
> governor->limits(), performance governor will not adjust the frequency,
> configured frequency will remain at turbo-freq.
> 
> Simplified call stack looks as follows:
> cpufreq_register_driver(&cppc_cpufreq_driver)
> 	...
> 	cppc_cpufreq_cpu_init()
> 		cppc_get_perf_caps()
> 		policy->max = cppc_perf_to_khz(caps, caps->nominal_perf)
> 			cppc_set_perf(highest_perf) // set highest_perf
> 			policy->cur = cpufreq_driver->get() // if cur == policy->max
> 	cpufreq_init_policy()
> 		...
> 		cpufreq_start_governor() // governor: performance
> 			new_freq = cpufreq_driver->get() // if new_freq == policy->max
> 			if (policy->cur != new_freq)
> 			cpufreq_out_of_sync(policy, new_freq)
> 				...
> 				policy->cur = new_freq
> 			...
> 			policy->governor->limits()
> 				__cpufreq_driver_target(policy->max)
> 					if (policy->cur==target)
> 					// generate error, keep set highest_perf
> 						ret
> 					cppc_set_perf(target)
> 
> Fix this by changing highest_perf to nominal_perf in cppc_cpufreq_cpu_init().
> 
> Fixes: 5477fb3bd1e8 ("ACPI / CPPC: Add a CPUFreq driver for use with CPPC")
> Signed-off-by: liwei <liwei728@huawei.com>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 64420d9cfd1e..db04a82b8a97 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -669,14 +669,14 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  	if (caps->highest_perf > caps->nominal_perf)
>  		boost_supported = true;
>  
> -	/* Set policy->cur to max now. The governors will adjust later. */
> -	policy->cur = cppc_perf_to_khz(caps, caps->highest_perf);
> -	cpu_data->perf_ctrls.desired_perf =  caps->highest_perf;
> +	/* Set policy->cur to norm now. */
> +	policy->cur = cppc_perf_to_khz(caps, caps->nominal_perf);
> +	cpu_data->perf_ctrls.desired_perf =  caps->nominal_perf;
>  
>  	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
>  	if (ret) {
>  		pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
> -			 caps->highest_perf, cpu, ret);
> +			 caps->nominal_perf, cpu, ret);
>  		goto out;
>  	}
>  
> -- 
> 2.25.1

-- 
viresh

