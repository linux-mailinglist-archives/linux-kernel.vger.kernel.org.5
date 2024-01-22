Return-Path: <linux-kernel+bounces-33846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD5C836F71
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE3A11F2E89C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3AD4643E;
	Mon, 22 Jan 2024 17:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yog+BDAp"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D104F4642C;
	Mon, 22 Jan 2024 17:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705945172; cv=none; b=iPn+4zrKq9hIzR4DRxtkbY5V9X/bYxXq/HtLTM98RetPqebqeBe0oHLhufLcAty2qeacnTAZbLsLpKe+MlHNGGdf6nYcn0f+PYqJhhlSQhTMtxe1srJxjXTMvtw8cLJuYPe78Uqspy851Caz4YIThxSNnUUKA+wb1KyIy4vwpxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705945172; c=relaxed/simple;
	bh=hfCd1Y5oYmxXeZ+dlaZix8KLaxz5lElV/rFBFaBiI98=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GuLw/iJZ9jcN3QUBvqA5CVOh5wwND/OsG6NN0wQPYeeWUdQ7i2LBvoq+6BlU3MERV8a7C1RvEwgZhvUmfw+Mx/V5tILbs6kxKX2NQaXQhc3uvAXAKv8+Z3VQpMjxaKkkUlx9SPBVYVbAkxKdYoW231U5yjUy0RdTQpDyWXrvR7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yog+BDAp; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d74dce86f7so10233225ad.2;
        Mon, 22 Jan 2024 09:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705945170; x=1706549970; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=iRlYTVmwRF54QEgOCDB+moTbTPswdx4GRYVGmNIHl68=;
        b=Yog+BDAp9WKLRGP3QHvNKVUpxA5sGv1LmgSBhB/nDyV0JuOL9lieXlK5yEgTXpZwVm
         MzQjyRkmlrBfbBihDY1zbi5Z1V5vLgblztnAMwjUpLo0mveaK/N0zPSAuL1Rkj4XIJw4
         CvklL654x0b8YKmb6dpzRVWfD7bWXZ4ddbZC/QsIaRlMXG9djUslDBhUaawKLArXn8O5
         15NE3C/ah38VvVYbNQvd5XBnWrfOwL7cMlMXlXkDo5Q/nEKmBRBNJrHCMsUY+mCqQ04+
         1e6SR9letSfo9T9izEdwiYMUAlkXNoKxWzA4sce3W7ovU6/vthuEG5zKHR70TDCCUW4G
         QCDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705945170; x=1706549970;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iRlYTVmwRF54QEgOCDB+moTbTPswdx4GRYVGmNIHl68=;
        b=WSgBpLU3Y+yU9DY4OkC6XbhvRxGX50KEyH+4mojTWZ+7RSzi4KfFwC5xBc7QGdBxp4
         MD5DOkFZ1GBVPLdUnlbh7YMNp30VEeofu7M6cfo0P1BN8XhqvB1ZU1tdsHeYfYa9mGSy
         3Tg4FZBSXuiiPJ8qnju8LoFVIlDT4lyS0Gr1CpzdMSQ+xCaEEVSE9A8IzY9l+LxdPbh9
         wcaN3klzpqx+EH/D3TkGd1GVCYGl3mcNS8EqXzV+EmE/qq1cJQBunfSX807qoytG0KG1
         4MwZ8pdS0Dvwh4iasE43vEKr2BYk9ErDdt/olU12tXl6+sCKeC9bX465v1F4jbufGi5w
         PXSg==
X-Gm-Message-State: AOJu0Yx+zHKjBc3RHANpcOV3ll1mfTvFAumGcoL3zbY1hDixHo+DaHPe
	MEQxROeqpIBUT83L6B16zkFYIGlmym4oeKKJqXGMBdAc1najlw1L
X-Google-Smtp-Source: AGHT+IFdOn4FdPrIQ0ppWcJpcTrHrmkNQ2x1tWtSGsVJVEb3zvx0+1VfIsNOGwNuwwtazqcsdF25Kw==
X-Received: by 2002:a17:903:25d1:b0:1d7:ebe:9d4e with SMTP id jc17-20020a17090325d100b001d70ebe9d4emr4423977plb.92.1705945170002;
        Mon, 22 Jan 2024 09:39:30 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v20-20020a170902f0d400b001d74cee458asm2317033pla.107.2024.01.22.09.39.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 09:39:29 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <a5a807c1-76ef-4cf7-a2cf-bc432c420ded@roeck-us.net>
Date: Mon, 22 Jan 2024 09:39:27 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] watchdog: rzg2l_wdt: Add suspend/resume support
Content-Language: en-US
To: Claudiu <claudiu.beznea@tuxon.dev>, wim@linux-watchdog.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 geert+renesas@glider.be, magnus.damm@gmail.com, mturquette@baylibre.com,
 sboyd@kernel.org, p.zabel@pengutronix.de, biju.das.jz@bp.renesas.com
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-clk@vger.kernel.org, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20240122111115.2861835-1-claudiu.beznea.uj@bp.renesas.com>
 <20240122111115.2861835-8-claudiu.beznea.uj@bp.renesas.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240122111115.2861835-8-claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/22/24 03:11, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> The RZ/G3S supports deep sleep states where power to most of the IP blocks
> is cut off. To ensure proper working of the watchdog when resuming from
> such states, the suspend function is stopping the watchdog and the resume
> function is starting it. There is no need to configure the watchdog
> in case the watchdog was stopped prior to starting suspend.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>   drivers/watchdog/rzg2l_wdt.c | 26 ++++++++++++++++++++++++++
>   1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/watchdog/rzg2l_wdt.c b/drivers/watchdog/rzg2l_wdt.c
> index 9333dc1a75ab..186796b739f7 100644
> --- a/drivers/watchdog/rzg2l_wdt.c
> +++ b/drivers/watchdog/rzg2l_wdt.c
> @@ -279,6 +279,7 @@ static int rzg2l_wdt_probe(struct platform_device *pdev)
>   	priv->wdev.timeout = WDT_DEFAULT_TIMEOUT;
>   
>   	watchdog_set_drvdata(&priv->wdev, priv);
> +	dev_set_drvdata(dev, priv);
>   	ret = devm_add_action_or_reset(&pdev->dev, rzg2l_wdt_pm_disable, &priv->wdev);
>   	if (ret)
>   		return ret;
> @@ -300,10 +301,35 @@ static const struct of_device_id rzg2l_wdt_ids[] = {
>   };
>   MODULE_DEVICE_TABLE(of, rzg2l_wdt_ids);
>   
> +static int rzg2l_wdt_suspend_late(struct device *dev)
> +{
> +	struct rzg2l_wdt_priv *priv = dev_get_drvdata(dev);
> +
> +	if (!watchdog_active(&priv->wdev))
> +		return 0;
> +
> +	return rzg2l_wdt_stop(&priv->wdev);
> +}
> +
> +static int rzg2l_wdt_resume_early(struct device *dev)
> +{
> +	struct rzg2l_wdt_priv *priv = dev_get_drvdata(dev);
> +
> +	if (!watchdog_active(&priv->wdev))
> +		return 0;
> +
> +	return rzg2l_wdt_start(&priv->wdev);
> +}
> +
> +static const struct dev_pm_ops rzg2l_wdt_pm_ops = {
> +	LATE_SYSTEM_SLEEP_PM_OPS(rzg2l_wdt_suspend_late, rzg2l_wdt_resume_early)
> +};
> +
>   static struct platform_driver rzg2l_wdt_driver = {
>   	.driver = {
>   		.name = "rzg2l_wdt",
>   		.of_match_table = rzg2l_wdt_ids,
> +		.pm = pm_ptr(&rzg2l_wdt_pm_ops),

I think this will create a build error if CONFIG_PM=n because rzg2l_wdt_pm_ops
will be unused but is not marked with __maybe_unused. But then the driver won't be
operational with CONFIG_PM=n, so I really wonder if it makes sense to include any
such conditional code instead of making the driver depend on CONFIG_PM.

I really don't think it is desirable to suggest that the driver would work with
CONFIG_PM=n if that isn't really true.

Guenter

>   	},
>   	.probe = rzg2l_wdt_probe,
>   };


