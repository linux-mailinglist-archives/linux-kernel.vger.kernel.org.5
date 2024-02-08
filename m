Return-Path: <linux-kernel+bounces-58467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A3784E6E5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3070E1C25646
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B93823CD;
	Thu,  8 Feb 2024 17:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iKJE6Vcc"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F9E7F7EA;
	Thu,  8 Feb 2024 17:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707413933; cv=none; b=pBonXpb4jlvX3uZJ8nTxXhUUZwJiqICkDMPrZH0ilt0ebKJyd7KH/a1+/34OwOFiRSo4+fIt1QTw3E9TIfJCkbT7+LnycU5BlUb/Kg34lT2mqY/EHVbYUEmEYyW6umJHGVW2BSolxaR8Y6Bn7D3vwHj2p6KyQ6jPxi+6nr+idws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707413933; c=relaxed/simple;
	bh=JmWFJ+DvIwEQw4StzeZ6D85odnGQY5JE98T7juiACHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TnfJfSwtsge0ltlXfVMEsp20TZn3nIEyZ7Q2Y+C3i+vCUE3t7avOEF/3raNkLmhJJq5G5SCMDC8dVQj0F7jve9n7kpehNjDZpS4FIFnh8b1TUIKGzAIjRPNE7nsDxjslSPlmBKICI+TPIORyn8nTRmXnBNNeWpYUMVyNbIwosBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iKJE6Vcc; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e0311797c5so51789b3a.2;
        Thu, 08 Feb 2024 09:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707413931; x=1708018731; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=vBDL223sQRgPjT0jCJTLSJtXPkj2jxjQ7B9mKv/ZjLw=;
        b=iKJE6VccyUsJyfvRtcHFq8zHsLHxBPI2HRiTjmK2GCaRQJCepzMwbpr/OlmYeAyi1I
         3px/otzWoTzU19uKjVvkplqjTWuzzfRuXVlS6fThad8zrTxxoOdcHBlhLrFk9Se1whfY
         viQ8n4CLMPW7oSTlu+kGS5M2fhCKdUUnv2ppVwqKhF8p2/84Iom3+vuB2z+nhwt7OrSj
         edKE79TCIi9/8NKwLCbQOk+u97pjo5/AFSkQ/Vkgte1+tPtUGWJhsfFnHdKTgHvXPn3z
         bfk/VtrNveiTN1JsIIXG0BtW/6RQ9BiKQk865Xy1ByhahzRgzDKo19F/Yb8oYlvWnHJI
         eeEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707413931; x=1708018731;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vBDL223sQRgPjT0jCJTLSJtXPkj2jxjQ7B9mKv/ZjLw=;
        b=q46p7CMozMMq87WRiJE0NULGR5Y0Y5XF/jAKyB6QP27UK6DRdhituFWpQXUQOKxgng
         uBtpqDn6d9KXa0vu0BI2NG20300Iw1mfVXO1ShgDhOZRwdRxMz/Ziv/3UOqik2bBXPNe
         22715AShN6bjzxe7Rfyn1JspWdjVmzAjlZjNhqzYqiXuaHn1i6EiG+FEDuY2kjuLQv7r
         Yk+vls3LCU3g3VDQ+x6z4vu/Ja0OvvftJTZt4OFFz7GF4QdZtrbTgxS/I84YxKbVz1AK
         zudkZ/UhRY8kGTOS74o6xRxJ5QFFPIBENpi+Cpq3JRSIwprUycg+8lVfZ8ArdiHvQOi5
         18MQ==
X-Gm-Message-State: AOJu0YzP4HIQydDNKQ0ha3fMbznE2gWinOCSmoEIINzQu5AftKXE82om
	9LxSNGEA5Rj9AifwigRsiSIP9yDOuQ6T0ESi2UoK5EySz0xDA4BD
X-Google-Smtp-Source: AGHT+IHUK8/ZaoZR0zIDQxjANMcr1RoGS5slOVTm3xO/S+CEYmK0Fy7myP2tIxhabANP2UHB0i4+Uw==
X-Received: by 2002:a05:6a20:439e:b0:19e:97ee:af55 with SMTP id i30-20020a056a20439e00b0019e97eeaf55mr362578pzl.1.1707413930741;
        Thu, 08 Feb 2024 09:38:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUgyRJQNJHtgVz3gg9QTEpkuUejleleAzoBl4E8c2riuv78RDPkERwr9+HsUt3ndt6Cyo4flGlfODlfzCA7+8H4xFqWHlfxcORIrX723nT/sTN2UrGMPAbIMRxNuVTUNJJFJRroy+5LstwcBXLw8wCrF2aeXW0hDRz5R0oh5SMvdF98dd5SFThV14ebEqwKWxkPzd+5/qKcQuA1mS0AG3ngYxIRbaCSSgdOxAYFUPkYYeOvxmD0OY0IGaQE1e82CjG63YGsqxaZqem3NrbAJpUtppIGsNUECJmB1wuCFr3iYFXnXo82bTHNi9HHbU5lQ3wdjAslotlFJvlTApWHKQ9Kl6Fh/i19Evmn9G1iOmfXucWOo8HWJXODPdXQO0Y3YBh1UYS9TLqJ7JUZM9tigp+Zg1w6qD2L96Bm8iGy/KrdxEiCMO/t8aISIoVuVXgnxS/XuqPn0DxdG3IlP8+HCqzt+1NeY2wfjvdlVbu2KtB0FyjpPBAE8llSOCK9CYxxLENO5jiZNLZcHWuzcWeU0Y+XIjdERZ+5IfhSblX893zioyy1e4TqySrA90C9ghihVm6b8hy7l5r0BW2bbo/2gdwQZ3yDvNuItGsEVO+x3ym356em5eH2MM7iTb8Sug==
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o1-20020a056a001b4100b006e04a659ed6sm4046745pfv.67.2024.02.08.09.38.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Feb 2024 09:38:49 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <a19d2728-c734-4102-8a6b-dbd9e2eba6a0@roeck-us.net>
Date: Thu, 8 Feb 2024 09:38:47 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] watchdog: s3c2410_wdt: use
 exynos_get_pmu_regmap_by_phandle() for PMU regs
Content-Language: en-US
To: Peter Griffin <peter.griffin@linaro.org>, arnd@arndb.de,
 krzysztof.kozlowski@linaro.org, wim@linux-watchdog.org,
 alim.akhtar@samsung.com, jaewon02.kim@samsung.com, semen.protsenko@linaro.org
Cc: alexey.klimov@linaro.org, kernel-team@android.com,
 tudor.ambarus@linaro.org, andre.draszik@linaro.org, saravanak@google.com,
 willmcvicker@google.com, linux-fsd@tesla.com,
 linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
References: <20240208161700.268570-1-peter.griffin@linaro.org>
 <20240208161700.268570-3-peter.griffin@linaro.org>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240208161700.268570-3-peter.griffin@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/8/24 08:17, Peter Griffin wrote:
> Obtain the PMU regmap using the new API added to exynos-pmu driver rather
> than syscon_regmap_lookup_by_phandle(). As this driver no longer depends
> on mfd syscon remove that header and Kconfig dependency.
> 
> Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/Kconfig       | 1 -
>   drivers/watchdog/s3c2410_wdt.c | 8 ++++----
>   2 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 7d22051b15a2..d78fe7137799 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -512,7 +512,6 @@ config S3C2410_WATCHDOG
>   	tristate "S3C6410/S5Pv210/Exynos Watchdog"
>   	depends on ARCH_S3C64XX || ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST
>   	select WATCHDOG_CORE
> -	select MFD_SYSCON if ARCH_EXYNOS
>   	help
>   	  Watchdog timer block in the Samsung S3C64xx, S5Pv210 and Exynos
>   	  SoCs. This will reboot the system when the timer expires with
> diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
> index 349d30462c8c..686cf544d0ae 100644
> --- a/drivers/watchdog/s3c2410_wdt.c
> +++ b/drivers/watchdog/s3c2410_wdt.c
> @@ -24,9 +24,9 @@
>   #include <linux/slab.h>
>   #include <linux/err.h>
>   #include <linux/of.h>
> -#include <linux/mfd/syscon.h>
>   #include <linux/regmap.h>
>   #include <linux/delay.h>
> +#include <linux/soc/samsung/exynos-pmu.h>
>   
>   #define S3C2410_WTCON		0x00
>   #define S3C2410_WTDAT		0x04
> @@ -699,11 +699,11 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
>   		return ret;
>   
>   	if (wdt->drv_data->quirks & QUIRKS_HAVE_PMUREG) {
> -		wdt->pmureg = syscon_regmap_lookup_by_phandle(dev->of_node,
> -						"samsung,syscon-phandle");
> +		wdt->pmureg = exynos_get_pmu_regmap_by_phandle(dev->of_node,
> +						 "samsung,syscon-phandle");
>   		if (IS_ERR(wdt->pmureg))
>   			return dev_err_probe(dev, PTR_ERR(wdt->pmureg),
> -					     "syscon regmap lookup failed.\n");
> +					     "PMU regmap lookup failed.\n");
>   	}
>   
>   	wdt_irq = platform_get_irq(pdev, 0);


