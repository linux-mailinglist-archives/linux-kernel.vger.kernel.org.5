Return-Path: <linux-kernel+bounces-149043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0CC78A8AF0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 681BB28666C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 18:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B56173343;
	Wed, 17 Apr 2024 18:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SO17Gtz4"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C337017109A;
	Wed, 17 Apr 2024 18:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713378036; cv=none; b=jmL3vHgiQMRUIsVUU6cL4ODR8jDMrr6vtxpQOQlCjaQGtrNvUUMNu56iG7OvNQtXoo6iypkF2lPw8aghGDjzTxgrbKYzd5W4uOAjYTQp9HNCmst4SeNSYsGtSn0rHLcxoQnFESVx+QZ5UeliRCme49cnlNze/4BchNM+CNrZ9Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713378036; c=relaxed/simple;
	bh=QTy1uOP4RHZQB2JvlA74CbksC3jZmMiqgqD8WB6bOhs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IOEQWkXk+Evsb5kuKoXC7Pd9JzKj9S4F3e5gy/Y3dlFOni9LzjKzJGs8xbABeuqFQ9AZTZLfIRjwYNYr6KH7kIAzwK4qzvk8S+ne8e5M1AucW3YFFen443FPhAtxcgf8bvVoZT2SosHm+jKBLnH6LriKeub9TJJXney6mrShrOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SO17Gtz4; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-518a56cdc03so5511760e87.1;
        Wed, 17 Apr 2024 11:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713378033; x=1713982833; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=48QPMkUrojznECdYqYE3dhoGPTvtwzBbZbvBIFF59pI=;
        b=SO17Gtz4HWK34qOVShBrXhKDjQ8KTR1LtGGF8qA3ntwQO2os3JRXvxUfOwEZN1JL5O
         I6xGXZAweVDXLcUhKrjokCyRNHqR6C1+xenD1mZMSbFOX9H7M49MXpVWr49ZPtqh8XRl
         0hr4nYSZKKvkJAO6mdvfzdvkJKoaNqjGiJ1NbAqdDfxPeKIbKJqrLDcEfiik7Ejbyfew
         2SFoy6DQATd+6XTyLv+dgq0Sp+CTCnxfOv9Xxin9gzwL1wAhVgHug2jweLqtn0nIQBsc
         tO3VhL46zOtX5d+05b0tsSD3M0yugz8lTiaXJU2uOkREtJwFs5uDNVC6a2EfemrNEnjo
         DklA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713378033; x=1713982833;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=48QPMkUrojznECdYqYE3dhoGPTvtwzBbZbvBIFF59pI=;
        b=YuxABuJA1rchtAzfUt/FKztpxySJ4Wjmyx5dpJ/ax6SibjgQn5iu+jgFQlB91j11ey
         icTU58p9YBo4Lsvnzi1m+pKYN4NUPXIbDYSZi/yLWDOxeNTOnZlOAOiTdLbtBYv5g2MA
         F0y6vfyVBVIpylBgE2YJAP8a9aJGBAo72jfN4uJ3dNBWVWM1AFjFHeS/a5tTXqqI59/F
         TGKGvLoAbfEeBuWeEaAwZwjUe+wgTEzB4vgpUTaSbzjckOPoUXjYLrUBAR0cAqL83fTl
         PtGbkA71bHHzNCZfZ0zTWQX63YC4UOkdZD7IXMzvnvpN9jftaH63UItslZS/Zs18/N3m
         UbtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdLD6wm1vEfTg6LGKjARFu953hRyN9l+AyPGxjIwlamuXQBUe5osyjQjOSsFZyqKED0jSGEc/NT09WUJEx7BHNtrnGJ5ntUTPgJUCbKhRn16En6faSccmgBeg0iYwgQd3+vD9E5O3u9YMxLzxGHB9iYSEsGT9pUX8ZgZkSGlxIWTVyxFDIDV8o
X-Gm-Message-State: AOJu0YxBaXqENR2gAt6H+haXKTU5AxI4dPluKONuI/xa9/xR8/XxMb4P
	MGrUEPe71+zCqR/OEdYRyfH3zjQANUw4JtqmUXmE/W3CtN+j9G8O
X-Google-Smtp-Source: AGHT+IGJW3vK7CXrR4lO73FgrvK84R77Y6SVOiE+CEZS0nEZE/Y0fOqIn2VWRX08++ENrykqPR5DKg==
X-Received: by 2002:ac2:57db:0:b0:518:a56d:dc25 with SMTP id k27-20020ac257db000000b00518a56ddc25mr35292lfo.38.1713378032612;
        Wed, 17 Apr 2024 11:20:32 -0700 (PDT)
Received: from ?IPV6:2001:14ba:7426:df00::2? (drtxq0yyyyyyyyyyyyyby-3.rev.dnainternet.fi. [2001:14ba:7426:df00::2])
        by smtp.gmail.com with ESMTPSA id m6-20020ac24ac6000000b00517737b4d5dsm2016940lfp.151.2024.04.17.11.20.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Apr 2024 11:20:32 -0700 (PDT)
Message-ID: <43af9cc9-1afe-42ae-bf69-b285b52a7882@gmail.com>
Date: Wed, 17 Apr 2024 21:20:31 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 5/6] watchdog: ROHM BD96801 PMIC WDG driver
Content-Language: en-US, en-GB
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Wim Van Sebroeck <wim@linux-watchdog.org>,
 Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
References: <cover.1712920132.git.mazziesaccount@gmail.com>
 <d52fd63e98635293022e5a607fd763b580e24189.1712920132.git.mazziesaccount@gmail.com>
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <d52fd63e98635293022e5a607fd763b580e24189.1712920132.git.mazziesaccount@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/12/24 14:22, Matti Vaittinen wrote:
> Introduce driver for WDG block on ROHM BD96801 scalable PMIC.
> 
> This driver only supports watchdog with I2C feeding and delayed
> response detection. Whether the watchdog toggles PRSTB pin or
> just causes an interrupt can be configured via device-tree.
> 
> The BD96801 PMIC HW supports also window watchdog (too early
> feeding detection) and Q&A mode. These are not supported by
> this driver.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> ---
> Revision history:
> RFCv1 => RFCv2:
> - remove always running
> - add IRQ handling
> - call emergency_restart()
> - drop MODULE_ALIAS and add MODULE_DEVICE_TABLE
> ---
>   drivers/watchdog/Kconfig       |  13 ++
>   drivers/watchdog/Makefile      |   1 +
>   drivers/watchdog/bd96801_wdt.c | 389 +++++++++++++++++++++++++++++++++
>   3 files changed, 403 insertions(+)
>   create mode 100644 drivers/watchdog/bd96801_wdt.c
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 6bee137cfbe0..d97e735e1faa 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -181,6 +181,19 @@ config BD957XMUF_WATCHDOG
>   	  watchdog. Alternatively say M to compile the driver as a module,
>   	  which will be called bd9576_wdt.
>   
> +config BD96801_WATCHDOG
> +	tristate "ROHM BD96801 PMIC Watchdog"
> +	depends on MFD_ROHM_BD96801
> +	select WATCHDOG_CORE
> +	help
> +	  Support for the watchdog in the ROHM BD96801 PMIC. Watchdog can be
> +	  configured to only generate IRQ or to trigger system reset via reset
> +	  pin.
> +
> +	  Say Y here to include support for the ROHM BD96801 watchdog.
> +	  Alternatively say M to compile the driver as a module,
> +	  which will be called bd96801_wdt.
> +
>   config CROS_EC_WATCHDOG
>   	tristate "ChromeOS EC-based watchdog"
>   	select WATCHDOG_CORE
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index 3710c218f05e..31bc94436c81 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -217,6 +217,7 @@ obj-$(CONFIG_XEN_WDT) += xen_wdt.o
>   
>   # Architecture Independent
>   obj-$(CONFIG_BD957XMUF_WATCHDOG) += bd9576_wdt.o
> +obj-$(CONFIG_BD96801_WATCHDOG) += bd96801_wdt.o
>   obj-$(CONFIG_CROS_EC_WATCHDOG) += cros_ec_wdt.o
>   obj-$(CONFIG_DA9052_WATCHDOG) += da9052_wdt.o
>   obj-$(CONFIG_DA9055_WATCHDOG) += da9055_wdt.o
> diff --git a/drivers/watchdog/bd96801_wdt.c b/drivers/watchdog/bd96801_wdt.c
> new file mode 100644
> index 000000000000..08fab9a87aec
> --- /dev/null
> +++ b/drivers/watchdog/bd96801_wdt.c
> @@ -0,0 +1,389 @@

..

> +static int find_closest_fast(int target, int *sel, int *val)
> +{
> +	int i;
> +	int window = FASTNG_MIN;
> +
> +	for (i = 0; i < 8 && window < target; i++)
> +		window <<= 1;
> +
> +	*val = window;
> +	*sel = i;
> +
> +	if (i == 8)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static int find_closest_slow_by_fast(int fast_val, int *target, int *slowsel)
> +{
> +	int sel;
> +	static const int multipliers[] = {2, 4, 8, 16};
> +
> +	for (sel = 0; sel < ARRAY_SIZE(multipliers) &&
> +	     multipliers[sel] * fast_val < *target; sel++)
> +		;
> +
> +	if (sel == ARRAY_SIZE(multipliers))
> +		return -EINVAL;
> +
> +	*slowsel = sel;
> +	*target = multipliers[sel] * fast_val;
> +
> +	return 0;
> +}
> +
> +static int find_closest_slow(int *target, int *slow_sel, int *fast_sel)
> +{
> +	static const int multipliers[] = {2, 4, 8, 16};
> +	int i, j;
> +	int val = 0;
> +	int window = FASTNG_MIN;
> +
> +	for (i = 0; i < 8; i++) {
> +		for (j = 0; j < ARRAY_SIZE(multipliers); j++) {
> +			int slow;
> +
> +			slow = window * multipliers[j];
> +			if (slow >= *target && (!val || slow < val)) {
> +				val = slow;
> +				*fast_sel = i;
> +				*slow_sel = j;
> +			}
> +		}
> +		window <<= 1;
> +	}
> +	if (!val)
> +		return -EINVAL;
> +
> +	*target = val;
> +
> +	return 0;
> +}

Thanks to the review comments by George, I took a more careful look on 
the supported watchdog time-outs. It appears the functions above don't 
work as intended. I think the logic is flawed, and some of the values 
correspond to an early design sample.

I will fix (and test) the timeout computations for the next version - 
but it is likely to take some time since I'd rather sent the v3 without 
the 'RFC'. Just wanted to warn people that it might be best to postpone 
proper review to v3.

Sorry...

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


