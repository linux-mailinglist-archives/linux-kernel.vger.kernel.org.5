Return-Path: <linux-kernel+bounces-35096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFB5838C20
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CB1A1F26389
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3325D5C8E2;
	Tue, 23 Jan 2024 10:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GB83W9lN"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31C350A77;
	Tue, 23 Jan 2024 10:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706006022; cv=none; b=nZCzTvaFpZUf2MY8p8sE2LzTHj7+sUGd6aV+fOpKqZGvzjNBJ2P1hsLfE/82NyvNiL47z2LJsDkKS5ps2LaMA28STm3H65Bt+u7CB5OTrYUDAqMx6rh5CONzNuqnC76xjBZ3cxmlNqVGSHrsv4EzMr+YdHCag3l5wE3uAmQX7DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706006022; c=relaxed/simple;
	bh=b/HjrJfU8EEcbsztZmBbn++VHf0B5By+qe8X/6IIxsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YLb38ExKxOzqCpBOAUGA1Ij/RqqFlUEiUhSXZt+CGemtZvF7+9YCFzrdJ089dtUqNxf18HVy80+XDCf04O/Lh9FyKyO4B84jX4s6Azut1Qy9Bc+CajbWJbhyTWnkyJvDz85rni1EbqaWdkvMDQ4ZHGFQ3V9bKf7WXVV+Be0jf+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GB83W9lN; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6dac225bf42so2228203b3a.0;
        Tue, 23 Jan 2024 02:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706006020; x=1706610820; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=/kWlrAsaCmjeiYXkdVA1YyhGdw7+xla0wi8v7ASUMKs=;
        b=GB83W9lNmdspxUa6QTZsNb8Ujm05Y8jhYIpvIfZ9JF4PJnS44YEevPKCbPM1OwqUdz
         uUS+CdHM32TBUZhnuSnOdixhJPcT+lavYhWMYXNo20UoPkOvqcWN12wQC7roHu+Geq9b
         Bw4+HHh0TRN571MrqhZJ8Q0pymdUjJGmq+XypdO4bVOls1Qt2CTEoUPIkM70ifIJwWsI
         RFfEIDE2x67F7rWVLWwH73mvJ5jCVVF0dD3ZPGbDdGgHAFQWqJX9D8PuEYqxq+UhB8KS
         qS12BeLIBQr1sKEfOFCZRRgSlixIAiT4f4wIbmG6gp8XjnvcrfU1slpHpYLTA5J9GSq7
         +BsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706006020; x=1706610820;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/kWlrAsaCmjeiYXkdVA1YyhGdw7+xla0wi8v7ASUMKs=;
        b=LqEt/WNl9GQEh6rdLCDh9zJPsos9VwKC0oNr8FpzsiMn8KanzoWQl2zD1/x2tVg1sL
         7cDrntrHiU2IIKBaQe8wlH1famMoko7iOnQDWcVM2QErGaooY5XgL+Pmp3AOvFJmtFly
         +aDO/BUPmdRVCZu4qnhr6DL/p3hOdV1iZ/6/AIMATb3blPJ5WYh1PKO3x0y33bHV6eq8
         8lgSKnVfnQRZG2qPLGT75Tl0Td+GXAMYxK2SpKIwoRqxBueCfsE+eJsUcQgWQ+AEwacj
         nmt9Oa2NF8XbJ4AebcoA1ynwBBqeUqmrTbscdG2+x2YawVRjWrJUmhPioXfeJtPezxZp
         v2bg==
X-Gm-Message-State: AOJu0YyoqagC+vYee5ZzFGGQt+yr66mAmvYsAjRrj2pyhmXfdzVts9dT
	zyMIYr2QIo5qkoP+xhcYRZ2RlJ9mVpFZmhoh3DBlfvXaxiT/ECTA
X-Google-Smtp-Source: AGHT+IGrJKjC7DZB2KY9UVMvpA7JZWHnkbXtxo9wARqs/IFIHwZKoLUU1eo7dM+YGQqKl2cfhivS6A==
X-Received: by 2002:aa7:9841:0:b0:6dd:8092:6c63 with SMTP id n1-20020aa79841000000b006dd80926c63mr238938pfq.63.1706006019786;
        Tue, 23 Jan 2024 02:33:39 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y22-20020a62b516000000b006dbd2405882sm5501006pfe.148.2024.01.23.02.33.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 02:33:39 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <726bd8ef-2074-4ae7-89fe-36e2bc70d02e@roeck-us.net>
Date: Tue, 23 Jan 2024 02:33:36 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] watchdog: s3c2410_wdt: update to use new
 exynos_pmu_*() apis
Content-Language: en-US
To: Peter Griffin <peter.griffin@linaro.org>, arnd@arndb.de,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 wim@linux-watchdog.org, conor+dt@kernel.org, alim.akhtar@samsung.com,
 jaewon02.kim@samsung.com, chanho61.park@samsung.com,
 semen.protsenko@linaro.org
Cc: kernel-team@android.com, tudor.ambarus@linaro.org,
 andre.draszik@linaro.org, saravanak@google.com, willmcvicker@google.com,
 linux-fsd@tesla.com, linux-watchdog@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
References: <20240122225710.1952066-1-peter.griffin@linaro.org>
 <20240122225710.1952066-4-peter.griffin@linaro.org>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240122225710.1952066-4-peter.griffin@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/22/24 14:57, Peter Griffin wrote:
> Instead of obtaining the PMU regmap directly use the new exynos_pmu_*()
> APIs. The exynos_pmu_ APIs allow support of newer Exynos SoCs that have
> atomic set/clear bit hardware and platforms where the PMU registers can
> only be accessed via SMC call.
> 

Not really sure about using a direect API instead of regmap. I personally
think that regmap is more generic and like the idea of abstracting hardware
accesses this way. Since that is POV, I won't argue about it. However,

> As all platforms that have PMU registers use these new APIs, remove the
> syscon regmap lookup code, as it is now redundant.
>

if syscon is now no longer needed, why keep selecting MFD_SYSCON below,
and why are linux/mfd/syscon.h and linux/regmap.h still included ?

Also, the driver did not previously only support ARCH_EXYNOS but also
ARCH_S3C64XX and ARCH_S5PV210. It is not entirely (actually, not at all)
clear to me if and how those platforms are now supported. EXYNOS_PMU
still seems to depend on ARCH_EXYNOS. How can the driver select
EXYNOS_PMU if ARCH_EXYNOS=n ?

Also, ARCH_EXYNOS already selects EXYNOS_PMU, so a conditional
"select EXYNOS_PMU if ARCH_EXYNOS" would not make sense (or be required)
either.

Please explain all the above.

Thanks,
Guenter

> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
>   drivers/watchdog/Kconfig       |  1 +
>   drivers/watchdog/s3c2410_wdt.c | 25 +++++++++----------------
>   2 files changed, 10 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 7d22051b15a2..b3e90e1ddf14 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -513,6 +513,7 @@ config S3C2410_WATCHDOG
>   	depends on ARCH_S3C64XX || ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST
>   	select WATCHDOG_CORE
>   	select MFD_SYSCON if ARCH_EXYNOS
> +	select EXYNOS_PMU
>   	help
>   	  Watchdog timer block in the Samsung S3C64xx, S5Pv210 and Exynos
>   	  SoCs. This will reboot the system when the timer expires with
> diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
> index 349d30462c8c..fd3a9ce870a0 100644
> --- a/drivers/watchdog/s3c2410_wdt.c
> +++ b/drivers/watchdog/s3c2410_wdt.c
> @@ -28,6 +28,8 @@
>   #include <linux/regmap.h>
>   #include <linux/delay.h>
>   
> +#include <linux/soc/samsung/exynos-pmu.h>
> +
>   #define S3C2410_WTCON		0x00
>   #define S3C2410_WTDAT		0x04
>   #define S3C2410_WTCNT		0x08
> @@ -187,7 +189,6 @@ struct s3c2410_wdt {
>   	struct watchdog_device	wdt_device;
>   	struct notifier_block	freq_transition;
>   	const struct s3c2410_wdt_variant *drv_data;
> -	struct regmap *pmureg;
>   };
>   
>   static const struct s3c2410_wdt_variant drv_data_s3c2410 = {
> @@ -355,8 +356,8 @@ static int s3c2410wdt_disable_wdt_reset(struct s3c2410_wdt *wdt, bool mask)
>   	const u32 val = mask ? mask_val : 0;
>   	int ret;
>   
> -	ret = regmap_update_bits(wdt->pmureg, wdt->drv_data->disable_reg,
> -				 mask_val, val);
> +	ret = exynos_pmu_update(wdt->drv_data->disable_reg,
> +				mask_val, val);
>   	if (ret < 0)
>   		dev_err(wdt->dev, "failed to update reg(%d)\n", ret);
>   
> @@ -370,8 +371,8 @@ static int s3c2410wdt_mask_wdt_reset(struct s3c2410_wdt *wdt, bool mask)
>   	const u32 val = (mask ^ val_inv) ? mask_val : 0;
>   	int ret;
>   
> -	ret = regmap_update_bits(wdt->pmureg, wdt->drv_data->mask_reset_reg,
> -				 mask_val, val);
> +	ret = exynos_pmu_update(wdt->drv_data->mask_reset_reg,
> +				mask_val, val);
>   	if (ret < 0)
>   		dev_err(wdt->dev, "failed to update reg(%d)\n", ret);
>   
> @@ -384,8 +385,8 @@ static int s3c2410wdt_enable_counter(struct s3c2410_wdt *wdt, bool en)
>   	const u32 val = en ? mask_val : 0;
>   	int ret;
>   
> -	ret = regmap_update_bits(wdt->pmureg, wdt->drv_data->cnt_en_reg,
> -				 mask_val, val);
> +	ret = exynos_pmu_update(wdt->drv_data->cnt_en_reg,
> +				mask_val, val);
>   	if (ret < 0)
>   		dev_err(wdt->dev, "failed to update reg(%d)\n", ret);
>   
> @@ -617,7 +618,7 @@ static inline unsigned int s3c2410wdt_get_bootstatus(struct s3c2410_wdt *wdt)
>   	if (!(wdt->drv_data->quirks & QUIRK_HAS_PMU_RST_STAT))
>   		return 0;
>   
> -	ret = regmap_read(wdt->pmureg, wdt->drv_data->rst_stat_reg, &rst_stat);
> +	ret = exynos_pmu_read(wdt->drv_data->rst_stat_reg, &rst_stat);
>   	if (ret)
>   		dev_warn(wdt->dev, "Couldn't get RST_STAT register\n");
>   	else if (rst_stat & BIT(wdt->drv_data->rst_stat_bit))
> @@ -698,14 +699,6 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
>   	if (ret)
>   		return ret;
>   
> -	if (wdt->drv_data->quirks & QUIRKS_HAVE_PMUREG) {
> -		wdt->pmureg = syscon_regmap_lookup_by_phandle(dev->of_node,
> -						"samsung,syscon-phandle");
> -		if (IS_ERR(wdt->pmureg))
> -			return dev_err_probe(dev, PTR_ERR(wdt->pmureg),
> -					     "syscon regmap lookup failed.\n");
> -	}
> -
>   	wdt_irq = platform_get_irq(pdev, 0);
>   	if (wdt_irq < 0)
>   		return wdt_irq;


