Return-Path: <linux-kernel+bounces-119314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E21A788C6F2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 721CD1F6705B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E26213C8EC;
	Tue, 26 Mar 2024 15:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OgfpU00w"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873A613C834;
	Tue, 26 Mar 2024 15:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711466938; cv=none; b=bfyb3tdLxixrtnM+gYkcEmPdLFDip5369n8chrJxZeF62dxhRr1TJOOfrCMZjcC0ILlGFIPQGYkaZ9NVIjmSaglP+GgMko54U7UGXiINN8CK0yX6i06KHatFhjZDwEvGi+N8hAHZIat0gzIXt6itVZdqFD1OrxIbWQT3x8oeKkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711466938; c=relaxed/simple;
	bh=wCL3fEbfpyRSku00DoRko0dQ73Sk8Kak6d4QH77NvPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=F+1jGRzCjs/46V85w6bNq3G9G9y9Z3Z681q9uUF2N7OasOovhmfpryqElQaEfKte4x0dC8KxZlZv5eoxXvkehAutIZ59yUZlOpru5v4MAQlgV3clQPXXCWjBU2jPl/Kew2etXe2rPAbfhmxF/XZlslx4E5SXn/UQKMHaghdpRUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OgfpU00w; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e74bd85f26so4483758b3a.1;
        Tue, 26 Mar 2024 08:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711466936; x=1712071736; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=FIY50RgDm2vI8Gw1swzwmh17Wp6x/4zajY9XIyEBLJ4=;
        b=OgfpU00wV9/yosELO0QqpE4R69Atr37eSnT48YDK86F+Z1Wq7nl2tgMrPmajOI4DmH
         WB55GjVLIj9MiIAo6lcTr8tXUhtSTCNE+nSD3+oQWNN3oMlTQMGYtPB9RLy4OGNJ0Qb8
         LbeBTsEEJLO46lWKlEeVaq+/CG9n0TPmDKYJOQ7ETFE3Xq1F9vRoEcQnIqMvB9KTXK8a
         e/pC53EllmvUC9gYpEKl0hTVehR7G+JLU1t18E8OqviixGWnW0xAdMj0hY/kUMCsbmqV
         VjTHW2E3/2l28rjSu6ukg5fE0NfMvZ4z0e0zKpPoOBvyBMqkARomepUJuVeoeoQfcKnh
         N02g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711466936; x=1712071736;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FIY50RgDm2vI8Gw1swzwmh17Wp6x/4zajY9XIyEBLJ4=;
        b=IAyvc8Vc7uV3fuOkmsi3yhV7GYWmYIGHjCAwumMPI1ggJWkBn6lcYki5PN6fI8f3AK
         5C5XWmBvsdG+Lz1ofjThVuHvIARtFFdfr16MkjZWRIZdVL0v7c+Y3VpA1OAQMzSSCzin
         L6BEKsn7zm7aZ4E+dbdDskrxVZ0chMW8E/oLsc7NrRcU5uLpYVcfPD5Uk0somEGEbCFZ
         YIhPyoKajk13VhM5kUoqo0OUNYL5QMt+Wx0VmFr44nEIdxxwyYX+ZDjSUbq/3tiIIJAc
         G1cxMzdJNIn3x9RT5WPjoYEvTucO5R404NHzjXsYYLkKifwjK3YD5Ep7m9lHUNapah7A
         Ubbg==
X-Forwarded-Encrypted: i=1; AJvYcCXm+wJ3STG6anAYe8GXxRsjefxbrcf8BmM+phYbOmazmyIQn3RR6drUFDBbLTjv9bOZrflmqzT+elo1QL2z4EoxeWR4is8lxX/PMAkLYPfo5gMCERRvMnendV+AxgAbZpP2U5UQske34GbLZAEanb/CLugeX7B+2M3ks9oPcG3/etk1v5E+vo2k
X-Gm-Message-State: AOJu0Yx8GXekGkqMLRuyi59OJ7ZzESP7erOhDi54xLAoPKsw9S6mPSjW
	YfxvLoUA+zWFqlabjUne8qSfMSIVexmmjHcoxShiIpJOgRH5cJAU
X-Google-Smtp-Source: AGHT+IE3KuAiTexLPP92NGx679jGJTKmCvs25T3l5aT6IUU3C3463a9Ds0/ILHSeyuop7Jcy2I9n9g==
X-Received: by 2002:a05:6a00:188b:b0:6e3:b1b3:139f with SMTP id x11-20020a056a00188b00b006e3b1b3139fmr83173pfh.17.1711466935503;
        Tue, 26 Mar 2024 08:28:55 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i18-20020aa78b52000000b006e567c81d14sm6074904pfd.43.2024.03.26.08.28.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 08:28:54 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <ff5b9f0d-d658-4907-a6c3-ed6d5ef27765@roeck-us.net>
Date: Tue, 26 Mar 2024 08:28:52 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] drivers: watchdog: ast2500 and ast2600 support
 bootstatus
Content-Language: en-US
To: Peter Yin <peteryin.openbmc@gmail.com>, patrick@stwcx.xyz,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20240326150027.3015958-1-peteryin.openbmc@gmail.com>
 <20240326150027.3015958-5-peteryin.openbmc@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240326150027.3015958-5-peteryin.openbmc@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/26/24 08:00, Peter Yin wrote:
> Add WDIOF_EXTERN1 and WDIOF_CARDRESET bootstatus in ast2600
> 
> Regarding the AST2600 specification, the WDTn Timeout Status Register
> (WDT10) has bit 1 reserved. Bit 1 of the status register indicates
> on ast2500 if the boot was from the second boot source.
> It does not indicate that the most recent reset was triggered by
> the watchdog. The code should just be changed to set WDIOF_CARDRESET
> if bit 0 of the status register is set.
> 
> Include SCU register to veriy WDIOF_EXTERN1 in ast2600 SCU74 or
> ast2500 SCU3C when bit1 is set.
> 
> Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
> ---
>   drivers/watchdog/aspeed_wdt.c | 53 ++++++++++++++++++++++++-----------
>   1 file changed, 37 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
> index b4773a6aaf8c..52afc5240b1c 100644
> --- a/drivers/watchdog/aspeed_wdt.c
> +++ b/drivers/watchdog/aspeed_wdt.c
> @@ -11,10 +11,12 @@
>   #include <linux/io.h>
>   #include <linux/kernel.h>
>   #include <linux/kstrtox.h>
> +#include <linux/mfd/syscon.h>
>   #include <linux/module.h>
>   #include <linux/of.h>
>   #include <linux/of_irq.h>
>   #include <linux/platform_device.h>
> +#include <linux/regmap.h>
>   #include <linux/watchdog.h>
>   
>   static bool nowayout = WATCHDOG_NOWAYOUT;
> @@ -65,23 +67,32 @@ MODULE_DEVICE_TABLE(of, aspeed_wdt_of_table);
>   #define WDT_RELOAD_VALUE	0x04
>   #define WDT_RESTART		0x08
>   #define WDT_CTRL		0x0C
> -#define   WDT_CTRL_BOOT_SECONDARY	BIT(7)
> -#define   WDT_CTRL_RESET_MODE_SOC	(0x00 << 5)
> -#define   WDT_CTRL_RESET_MODE_FULL_CHIP	(0x01 << 5)
> -#define   WDT_CTRL_RESET_MODE_ARM_CPU	(0x10 << 5)
> -#define   WDT_CTRL_1MHZ_CLK		BIT(4)
> -#define   WDT_CTRL_WDT_EXT		BIT(3)
> -#define   WDT_CTRL_WDT_INTR		BIT(2)
> -#define   WDT_CTRL_RESET_SYSTEM		BIT(1)
> -#define   WDT_CTRL_ENABLE		BIT(0)
> +#define WDT_CTRL_BOOT_SECONDARY	BIT(7)
> +#define WDT_CTRL_RESET_MODE_SOC	(0x00 << 5)
> +#define WDT_CTRL_RESET_MODE_FULL_CHIP	(0x01 << 5)
> +#define WDT_CTRL_RESET_MODE_ARM_CPU	(0x10 << 5)
> +#define WDT_CTRL_1MHZ_CLK		BIT(4)
> +#define WDT_CTRL_WDT_EXT		BIT(3)
> +#define WDT_CTRL_WDT_INTR		BIT(2)
> +#define WDT_CTRL_RESET_SYSTEM		BIT(1)
> +#define WDT_CTRL_ENABLE		BIT(0)
>   #define WDT_TIMEOUT_STATUS	0x10
> -#define   WDT_TIMEOUT_STATUS_IRQ		BIT(2)
> -#define   WDT_TIMEOUT_STATUS_BOOT_SECONDARY	BIT(1)
> +#define WDT_TIMEOUT_STATUS_IRQ		BIT(2)
> +#define WDT_TIMEOUT_STATUS_BOOT_SECONDARY	BIT(1)
> +#define WDT_TIMEOUT_STATUS_EVENT		BIT(0)
>   #define WDT_CLEAR_TIMEOUT_STATUS	0x14
> -#define   WDT_CLEAR_TIMEOUT_AND_BOOT_CODE_SELECTION	BIT(0)
> +#define WDT_CLEAR_TIMEOUT_AND_BOOT_CODE_SELECTION	BIT(0)
>   #define WDT_RESET_MASK1		0x1c
>   #define WDT_RESET_MASK2		0x20
>   
> +/*
> + * Ast2600 SCU74 bit1 is External reset flag
> + * Ast2500 SCU3C bit1 is External reset flag
> + */
> +#define   EXTERN_RESET_FLAG		BIT(1)
> +#define   AST2500_SYSTEM_RESET_EVENT	(0x3C)
> +#define   AST2600_SYSTEM_RESET_EVENT	(0x74)

() around constants does not add any value.

> +
>   /*
>    * WDT_RESET_WIDTH controls the characteristics of the external pulse (if
>    * enabled), specifically:
> @@ -458,15 +469,25 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
>   		writel(duration - 1, wdt->base + WDT_RESET_WIDTH);
>   	}
>   
> +	struct regmap *scu_base = syscon_regmap_lookup_by_phandle(dev->of_node,
> +							     "aspeed,scu");
>   	status = readl(wdt->base + WDT_TIMEOUT_STATUS);
> -	if (status & WDT_TIMEOUT_STATUS_BOOT_SECONDARY) {
> +	if (status & WDT_TIMEOUT_STATUS_EVENT)
>   		wdt->wdd.bootstatus = WDIOF_CARDRESET;
>   
> -		if (of_device_is_compatible(np, "aspeed,ast2400-wdt") ||
> -		    of_device_is_compatible(np, "aspeed,ast2500-wdt"))
> -			wdt->wdd.groups = bswitch_groups;
> +	if (of_device_is_compatible(np, "aspeed,ast2600-wdt")) {
> +		regmap_read(scu_base, AST2600_SYSTEM_RESET_EVENT, &status);

scu_base as returned from syscon_regmap_lookup_by_phandle() can be an ERR_PTR.
If it is, this will crash. On top of ttat, regmap_read() can also return an
error. If it does, status will be unmodified, and WDIOF_EXTERN1 will be set randomly.
This will most definitely happen if REGMAP support is disabled (there is nothing
in Kconfig requiring that REGMAP must be enabled for this driver).

Guenter


