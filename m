Return-Path: <linux-kernel+bounces-52153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 825588494A3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 08:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26A381F248C9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 07:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BCCC10A28;
	Mon,  5 Feb 2024 07:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c8c9ZoTf"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75ECC111AD
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 07:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707118698; cv=none; b=u/d7gCqE1H7Cx5t8pFguSqFJoyXnI3xCOTQtXHcWaMK8eitN4rHoFj1fqvyK3vumKDRRt+EsiYozsl2ucshvyEXqxYZUz497O9/I/3NDXqZW5OxwJtXJ5en8Aiy2Q3XN8O+vB98VTEcS89Y3CTt4NoV/5Vp7i/O7E9v4ykopWfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707118698; c=relaxed/simple;
	bh=52y/CrfpzJ3Xh30bgq6eajaZLuq7UfJcxxjBggUsG+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A20n2qR82qJUoO9WI8dpwt+SewA1qFwZQHeamd4QcZ4y9F0n8j339iQMt4XCIBrE4VAijn6T7NjseDyf/fKtxHlo+uuE+Zgsg9GMaBa8SSZI2iBUIHSY5Ey+RuwSgMRdMAsg/fAyuzPUvYZDeucXDQ6oqBS2HGWpC6G6bCV702Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c8c9ZoTf; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d953fa3286so28359535ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 23:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707118697; x=1707723497; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WEP2pmkNFzZnlqpvEHga5Kb4ynnO9XIEBYA3Oat6G1g=;
        b=c8c9ZoTfkp7/7v8b0UowSFGyT7hPEunpHvJL+fbuB4T6G/8Zz5iwBytFbyyRfI4T11
         N2bMLZYo1Ty7OdAsuzVjS/BhEsJUCTBIfLnE3IQvwB9hR2OSu2M2wNS9cOtAQTq6fU9a
         AiwbnmRCvUQOSSjNHeH6+zQqATmTmguT82uwWVLHchXNhC/4TsABhfhBZzFnZJzB1CnG
         ZTCMrZPNs8lLed9xV7tAJgly2msuR/KM+7H5+64pjH7UpDAbpeOesvpj5WEDKacdKLgr
         NDqC5A1mbpHbpBz3pVcOVrkzAbOpTZZ25eKwUPG23+umddcIXQWnc8Vw7/l+OkVgNutB
         FQLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707118697; x=1707723497;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WEP2pmkNFzZnlqpvEHga5Kb4ynnO9XIEBYA3Oat6G1g=;
        b=w880GtdtJb8YnqS7EsYhYiLOJ/M4J+FpwjZNGuYVTc2RCu/wNfOnCXT7Xq1c89jnYN
         1UMtjT5bBIq7/WXLO0fzRJD6Ayu/aDIO5DCnkH1mQodmq/pfxsd4+Dao7Le6i8ukA6/t
         rGfJZdnXRi7rL1mJXedgA7CJLk7gAqgIhb69NzBcOLYVeYHcrbJH3Y41JvybaO7xAHKP
         LBWYKM2cwKiS0rD2WkAF0jmDzbLtdkM4KZvsTUkYmD8v4f12mzBcYasVRdzwsvVIrfzK
         bxyTKzx8ebdp0iWHumT0hSfCIiRXimVbvYqaPTsii6sPait8VruBK9r3vsKXiz9epTpP
         f2Fg==
X-Gm-Message-State: AOJu0YxGnJHSyqhlWm2HOTy1if/HOBNDBh0syyJethA7OOOt2b6JLh4t
	Ucyia846w5hr30h54nxRTp0H/+IGIrXkM6yQDGI9Zh/ByV2kng7iGxINCVUzYqo=
X-Google-Smtp-Source: AGHT+IHIPMxdkut02CAeD0jpy2G42WzXmDaMBa0KY2Mu+pdsw6s9EHy2Q/pScdWZ2g+Hh1b2riVbVg==
X-Received: by 2002:a17:902:c40c:b0:1d9:a6e8:1c8c with SMTP id k12-20020a170902c40c00b001d9a6e81c8cmr5425593plk.15.1707118696685;
        Sun, 04 Feb 2024 23:38:16 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWYMMz6O7wshNnmmwb2g2UtuxwSEDKB8eA+JcSYIcn3qzxC3tKql8LoCrB5F01xUl96QuYhs7WYRdN+wWwKYzVDl4eoa+Kt7RMluv0C6fPHf2d+9Vnwup9YNhFdQfKA3XR6o+9/nX6kZavO1Sw2MXhz2mKFGn0kCQswpApauvEdSrKnZTZIQ26okCh0UmrHFMCFM86u3qNdZa5eFwbwLhB7vyIudVmMeSZoJKwiZqj1hRM=
Received: from localhost ([122.172.83.95])
        by smtp.gmail.com with ESMTPSA id j21-20020a170902c3d500b001d7610fdb7csm5608811plj.226.2024.02.04.23.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 23:38:16 -0800 (PST)
Date: Mon, 5 Feb 2024 13:08:14 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Lizhe <sensor1010@163.com>
Cc: vincent.guittot@linaro.org, ilpo.jarvinen@linux.intel.com,
	rafael@kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq/schedutil: When updating limitations, frequency
 modulation interval not become invalid.
Message-ID: <20240205073814.s656yzrv56tecji3@vireshk-i7>
References: <20240204140928.2865-1-sensor1010@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204140928.2865-1-sensor1010@163.com>

On 04-02-24, 06:09, Lizhe wrote:
> If the current frequency scaling policy is schedutil.
> echo schedutil > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
> This would result in an invalid frequency modulation interval.
> In sugov_limit(), sg_policy->limits_changed is set to true.

That will only make us do an extra freq change. What's the problem with that ?

> Signed-off-by: Lizhe <sensor1010@163.com>
> ---
>  drivers/cpufreq/cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 44db4f59c4cc..a0af38fcb7e2 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2631,7 +2631,7 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
>  
>  	if (new_gov == policy->governor) {
>  		pr_debug("governor limits update\n");
> -		cpufreq_governor_limits(policy);
> +		cpufreq_policy_apply_limits(policy);
>  		return 0;
>  	}

-- 
viresh

