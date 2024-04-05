Return-Path: <linux-kernel+bounces-132492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2941F8995D4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3002286A47
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 06:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38B823748;
	Fri,  5 Apr 2024 06:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GOJjR2Vb"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E53F17543
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 06:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712299722; cv=none; b=KsH66bYM0DbgHPCBBM6YWlPm1pJn7lwMr14W8lFKF9phhaOQUZmIA59MHyq0wfcIjKfujRab6IevmK8Yv14fCg70KNxBjmc0tyUNi2AxKDFhs9gyV1vom2BJg53L9Hauh4LpG56K1czykYtK9sRuP78HojMSVoaON4sJ5t26HrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712299722; c=relaxed/simple;
	bh=/b8O9gBIJDbC8t7IFTk9NqyR6nI2lxc2utw0dqInQsE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FE0zSN3vgCGEEh0R+zPSn7jpm1igUwIbRNy1mlo5qwoOyoxXBbPaNJvk6GA7pe39nPpbXn6aGk+C+nFo4cX1HXoJx0PPKjeMLt3aTak1oWthVzv1+JooDt2sAw9eqpUp0FakBmiuwO9J6msA40gV1FKbZAeDYVVX62QD77Fvlro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GOJjR2Vb; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-415446af364so17215465e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 23:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712299719; x=1712904519; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FYA+SCSxfqEp0pTsowJFPNSyASe14I0IoFn+b3BXCPQ=;
        b=GOJjR2VbhaWghYSpgpGMaJ55VbLAVo4eRP4Jy9UQWcbgGOlZVsxneNgy0j2bSoSu73
         TWNG/fUOm25MJa3cUMBeUkosVHkLLLm+BHFjKSzGGMQEhC0epWGnnMh125ZMIBMkkqXX
         4hPmgntGYtMGZI0ueyS+CZHhffj6h2Fj6fmuBDwJFlgiUpFQnu/nS1Vf3k9EC/K3XEv4
         B5uPqpAsX8BrkS+IzjmP467HyB9bjCBA6mYfAIpq4CsSrjO2S7lvzc6/sccmrGULnViF
         E/ZPTRXJZ2v8/ublop7vSuA6HyaxVtlB7yqKXpYOIJeKhhdxWWKJOgsHlE9haN9AL38U
         zQgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712299719; x=1712904519;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FYA+SCSxfqEp0pTsowJFPNSyASe14I0IoFn+b3BXCPQ=;
        b=isXpFXwV472CcLXFsEcsrqjg7r4mm3Oa1CBaMRTiUm1mG2Ua2g7DFY4jVGYbLCs9ud
         2ZnvEy2diPNyNlzozgy2KER1SVjwwsj1UCOtXdBLtJucjjAY8RVX/wu6KLN3ieohyiDN
         q70kfrkEt3nTBIy1iOrhZZYjTrEJPWcQ+ECAYcm/CYhcdlmhLl5yh6VOw836CbYMTINw
         BYZQd9u67mzZbFP0PYHXhKgRFRiFtNN1k6nCWJHNSTxAcwhb/XmSdA+WT2ufCgkt1h+/
         oBI1lvArm01/wyW/TMo/JRkMCvnVqYQFlgKe5amnW2b5SpUiZm+geUAy5/bKCu8RVSQg
         HkBg==
X-Forwarded-Encrypted: i=1; AJvYcCXoXsIA91Nl6citm2FNoSrAXfInc5kIq3YxraRxzuXJ/1I6VA/pQc2NBO3GxK64oW00syWBQ7MiQsM9WXDutPY9TSdwFCmSMQGaEWTa
X-Gm-Message-State: AOJu0YxiPlo02QsZmOrWWy+L/2H4Vwksigv5vMHR6p4kD9VWnspUrWR+
	eUNkGyPrCtgXGSib5HWCXS5eqLs7AfiiutXqKJ5w8jTCUpS++NaXDfts6ccElBk=
X-Google-Smtp-Source: AGHT+IHTVPfI8wZQVwV/WvqRqm+1jQjfgbqg3npICXYzkU+J+sod8+GGneWqQf8O0E1jNH0kGbGDDg==
X-Received: by 2002:a05:600c:3b26:b0:416:235d:7635 with SMTP id m38-20020a05600c3b2600b00416235d7635mr628935wms.9.1712299719505;
        Thu, 04 Apr 2024 23:48:39 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id m32-20020a05600c3b2000b004154e48bcdesm5303559wms.14.2024.04.04.23.48.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 23:48:39 -0700 (PDT)
Message-ID: <87d38d4c-14e2-4c64-baba-c9b8bd694339@linaro.org>
Date: Fri, 5 Apr 2024 08:48:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] ACPI: platform-profile: add
 platform_profile_cycle()
Content-Language: en-US
To: Gergo Koteles <soyer@irl.hu>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, Ike Panhc <ike.pan@canonical.com>,
 Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1712282976.git.soyer@irl.hu>
 <fdc1b0b9f910753967b7a9b1996e4923cc63124f.1712282976.git.soyer@irl.hu>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <fdc1b0b9f910753967b7a9b1996e4923cc63124f.1712282976.git.soyer@irl.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Gergo,

please Cc people who commented your changes.

see below:

On 05/04/2024 05:05, Gergo Koteles wrote:
> Some laptops have a key to switch platform profiles.
> 
> Add a platform_profile_cycle() function to cycle between the enabled
> profiles.
> 
> Signed-off-by: Gergo Koteles <soyer@irl.hu>
> ---
>   drivers/acpi/platform_profile.c  | 42 ++++++++++++++++++++++++++++++++
>   include/linux/platform_profile.h |  1 +
>   2 files changed, 43 insertions(+)
> 
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
> index d418462ab791..1579f380d469 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -136,6 +136,48 @@ void platform_profile_notify(void)
>   }
>   EXPORT_SYMBOL_GPL(platform_profile_notify);
>   
> +int platform_profile_cycle(void)
> +{
> +	enum platform_profile_option profile;
> +	enum platform_profile_option next;
> +	int err;
> +
> +	err = mutex_lock_interruptible(&profile_lock);
> +	if (err)
> +		return err;
> +
> +	if (!cur_profile) {
> +		mutex_unlock(&profile_lock);
> +		return -ENODEV;
> +	}
> +
> +	err = cur_profile->profile_get(cur_profile, &profile);
> +	if (err) {
> +		mutex_unlock(&profile_lock);
> +		return err;
> +	}
> +
> +	next = ffs(cur_profile->choices[0] >> (profile + 1)) + profile;
> +
> +	/* current profile is the highest, select the lowest */
> +	if (next == profile)
> +		next = ffs(cur_profile->choices[0]) - 1;
> +
> +	if (WARN_ON((next < 0) || (next >= ARRAY_SIZE(profile_names)))) {
> +		mutex_unlock(&profile_lock);
> +		return -EINVAL;
> +	}

Why do you need to do this?

That can be simplified by:

	[ ... ]

	err = cur_profile->profile_get(cur_profile, &profile);
	if (err)
		goto out;

	profile = (profile + 1) % ARRAY_SIZE(profile_names);

	err = cur_profile->profile_set(cur_profile, next);
out:
	mutex_unlock(&profile_lock);
	
	[ ... ]

> +	err = cur_profile->profile_set(cur_profile, next);
> +	mutex_unlock(&profile_lock);
> +
> +	if (!err)
> +		sysfs_notify(acpi_kobj, NULL, "platform_profile");
> +
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(platform_profile_cycle);
> +
>   int platform_profile_register(struct platform_profile_handler *pprof)
>   {
>   	int err;
> diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
> index e5cbb6841f3a..f5492ed413f3 100644
> --- a/include/linux/platform_profile.h
> +++ b/include/linux/platform_profile.h
> @@ -36,6 +36,7 @@ struct platform_profile_handler {
>   
>   int platform_profile_register(struct platform_profile_handler *pprof);
>   int platform_profile_remove(void);
> +int platform_profile_cycle(void);
>   void platform_profile_notify(void);
>   
>   #endif  /*_PLATFORM_PROFILE_H_*/

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


