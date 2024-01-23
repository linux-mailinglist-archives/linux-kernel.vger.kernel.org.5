Return-Path: <linux-kernel+bounces-35186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11AB6838D4A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 12:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3705A1C21EE3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064305D752;
	Tue, 23 Jan 2024 11:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FiEaYuCJ"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5AA5DF2E
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 11:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706008788; cv=none; b=X3xHGiR4RypZoNBFc/M/carwOtevg7vOQQfXYtwobcq0AIWRkWHyGREL/sPXeg9bvFndH/y6EPhthEQwNzzvLbJA6gpf7IJ7jkN1ZvFUFKOoz0Q303+ca3/gUeUSGukzAXRJGggqiAPz8iGmrjDThGvoJMmCPoVzVJpwHcKuqWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706008788; c=relaxed/simple;
	bh=GgwNwAKqntZhpBHXUdkraU4i1oGsVWSOKkMIn/QnXQ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N19aQKkC0a5tM285/pq+hmFcXDZp1Iu84uwXAo1FGgSGNfTcp2s22wfkTv9BRfy9W6IgD9uD5//NR07Q7vh7mDKr7wN304SvebGQ2320ocRNS/2KJ9sDodFhK1qNK/LAzd+MsW3JMxmhXxrP5krwVwz7posM44JKjmm0KMPOU9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FiEaYuCJ; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3387ef9fc62so3929768f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 03:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706008784; x=1706613584; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=umkoF8lD5EXJ084c1Yy2JMluWPz6456uub3hg+7fmD4=;
        b=FiEaYuCJNKXT8gW7gGkOGmdNfECBYC+aX4VVpYzMlWFaO9S3eD4oSjySHxw4ayNTyA
         Iy7q9D5Tg274FyqMhQSXsDzmuHqyrjZdxv/SZ6UJ72mHJzLXNxGS3AD3JbqrGfGJtPo+
         QUmDlJIjA33avgswjE1iAJNJqS2MjuGH4M+sAV3ISE481/3jNMJa73a5Rob3T7zPQE7E
         t9p8aR8YWcK5bOcdN3cvTWLhy8vOguDMG+jhcxO5tJxERaEmw5IhLYR0r5hCRS+/rqjX
         m8hgsxWdtSdMnADy/IVBhs/XWevnBKw+NPIl9K6puGme0VsyNqncXWDRB9UiZPAP2sbd
         jobw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706008784; x=1706613584;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=umkoF8lD5EXJ084c1Yy2JMluWPz6456uub3hg+7fmD4=;
        b=TGWrUZ16sG1EC80Y9JNP8noTxn6E77rMAgJuy1yKmhixdEmTskg4nvqdkPNubRmFOJ
         1MNdTmgPZlwkXROBnT+ga8hoJ7xe2Y4FuMK/N0nKVUK6wqwYmUoabGRdIBy/KJpm/Klv
         tjnyiDKWPqr3eMOHhLa6abS/CkPFi1uy7kngMIlJH5khukN1duOQ8NxFVhCrRd8ZswHy
         I7iE6LaAdY/ne2ta9OVpMOq0pX61ESfJbbbmn4xA4a4bYgQ19rzguI6O4ZjWvUUynNoh
         pSdx7KwFBV+bebl4rvt5YtDq5w8UDm8x3gKiLQ9gbM/n/t2dFVaw99+Vuoag+Ow2r/oz
         RU7A==
X-Gm-Message-State: AOJu0YxwwP2yV+dGXOwQZRDcXlHEx0sIWZ98deSAcDo88TnQvHhR+54J
	cjf2e45xlPt2Ubsgo/t9W73+iLjOfph48ig8PwvPKVVMCfMtpmlePL4d059GmQw=
X-Google-Smtp-Source: AGHT+IG2ZE7D+Wjj1Jx+XVzdo5feRrtg+NTa3+oUQ+xaXK3Kk2B5ESqbltT6j/+SBRtMz8eXwL7lMQ==
X-Received: by 2002:a05:6000:49:b0:337:c0e1:ef with SMTP id k9-20020a056000004900b00337c0e100efmr2497292wrx.1.1706008784389;
        Tue, 23 Jan 2024 03:19:44 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id i7-20020a5d6307000000b00337d71bb3c0sm12208876wru.46.2024.01.23.03.19.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 03:19:44 -0800 (PST)
Message-ID: <da30a68a-e29f-45c8-aa73-02955255a457@linaro.org>
Date: Tue, 23 Jan 2024 12:19:41 +0100
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
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, linux@roeck-us.net,
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
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240122225710.1952066-4-peter.griffin@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/01/2024 23:57, Peter Griffin wrote:
> Instead of obtaining the PMU regmap directly use the new exynos_pmu_*()
> APIs. The exynos_pmu_ APIs allow support of newer Exynos SoCs that have
> atomic set/clear bit hardware and platforms where the PMU registers can
> only be accessed via SMC call.
> 
> As all platforms that have PMU registers use these new APIs, remove the
> syscon regmap lookup code, as it is now redundant.
> 
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
>  drivers/watchdog/Kconfig       |  1 +
>  drivers/watchdog/s3c2410_wdt.c | 25 +++++++++----------------
>  2 files changed, 10 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 7d22051b15a2..b3e90e1ddf14 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -513,6 +513,7 @@ config S3C2410_WATCHDOG
>  	depends on ARCH_S3C64XX || ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST
>  	select WATCHDOG_CORE
>  	select MFD_SYSCON if ARCH_EXYNOS
> +	select EXYNOS_PMU

This does not look compatible with S3C64xx and S5Pv210.

>  	help
>  	  Watchdog timer block in the Samsung S3C64xx, S5Pv210 and Exynos
>  	  SoCs. This will reboot the system when the timer expires with
> diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
> index 349d30462c8c..fd3a9ce870a0 100644
> --- a/drivers/watchdog/s3c2410_wdt.c
> +++ b/drivers/watchdog/s3c2410_wdt.c
> @@ -28,6 +28,8 @@
>  #include <linux/regmap.h>
>  #include <linux/delay.h>
>  
> +#include <linux/soc/samsung/exynos-pmu.h>
> +
>  #define S3C2410_WTCON		0x00
>  #define S3C2410_WTDAT		0x04
>  #define S3C2410_WTCNT		0x08
> @@ -187,7 +189,6 @@ struct s3c2410_wdt {
>  	struct watchdog_device	wdt_device;
>  	struct notifier_block	freq_transition;
>  	const struct s3c2410_wdt_variant *drv_data;
> -	struct regmap *pmureg;
>  };
>  
>  static const struct s3c2410_wdt_variant drv_data_s3c2410 = {
> @@ -355,8 +356,8 @@ static int s3c2410wdt_disable_wdt_reset(struct s3c2410_wdt *wdt, bool mask)
>  	const u32 val = mask ? mask_val : 0;
>  	int ret;
>  
> -	ret = regmap_update_bits(wdt->pmureg, wdt->drv_data->disable_reg,
> -				 mask_val, val);
> +	ret = exynos_pmu_update(wdt->drv_data->disable_reg,
> +				mask_val, val);
>  	if (ret < 0)
>  		dev_err(wdt->dev, "failed to update reg(%d)\n", ret);
>  
> @@ -370,8 +371,8 @@ static int s3c2410wdt_mask_wdt_reset(struct s3c2410_wdt *wdt, bool mask)
>  	const u32 val = (mask ^ val_inv) ? mask_val : 0;
>  	int ret;
>  
> -	ret = regmap_update_bits(wdt->pmureg, wdt->drv_data->mask_reset_reg,
> -				 mask_val, val);
> +	ret = exynos_pmu_update(wdt->drv_data->mask_reset_reg,
> +				mask_val, val);
>  	if (ret < 0)
>  		dev_err(wdt->dev, "failed to update reg(%d)\n", ret);
>  
> @@ -384,8 +385,8 @@ static int s3c2410wdt_enable_counter(struct s3c2410_wdt *wdt, bool en)
>  	const u32 val = en ? mask_val : 0;
>  	int ret;
>  
> -	ret = regmap_update_bits(wdt->pmureg, wdt->drv_data->cnt_en_reg,
> -				 mask_val, val);
> +	ret = exynos_pmu_update(wdt->drv_data->cnt_en_reg,
> +				mask_val, val);
>  	if (ret < 0)
>  		dev_err(wdt->dev, "failed to update reg(%d)\n", ret);
>  
> @@ -617,7 +618,7 @@ static inline unsigned int s3c2410wdt_get_bootstatus(struct s3c2410_wdt *wdt)
>  	if (!(wdt->drv_data->quirks & QUIRK_HAS_PMU_RST_STAT))
>  		return 0;
>  
> -	ret = regmap_read(wdt->pmureg, wdt->drv_data->rst_stat_reg, &rst_stat);
> +	ret = exynos_pmu_read(wdt->drv_data->rst_stat_reg, &rst_stat);
>  	if (ret)
>  		dev_warn(wdt->dev, "Couldn't get RST_STAT register\n");
>  	else if (rst_stat & BIT(wdt->drv_data->rst_stat_bit))
> @@ -698,14 +699,6 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> -	if (wdt->drv_data->quirks & QUIRKS_HAVE_PMUREG) {
> -		wdt->pmureg = syscon_regmap_lookup_by_phandle(dev->of_node,
> -						"samsung,syscon-phandle");
> -		if (IS_ERR(wdt->pmureg))
> -			return dev_err_probe(dev, PTR_ERR(wdt->pmureg),
> -					     "syscon regmap lookup failed.\n");


Continuing topic from the binding: I don't see how you handle probe
deferral, suspend ordering.

Best regards,
Krzysztof


