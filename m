Return-Path: <linux-kernel+bounces-58025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E97E84E062
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3500B2863F9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3718371B24;
	Thu,  8 Feb 2024 12:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TUSSU38v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF916E2C9;
	Thu,  8 Feb 2024 12:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707394146; cv=none; b=EMM/8rqQfUtEfgbccV+OUoJu0UNw9gR94F17YS1rFo77gZLa83nak74j+6FQF/HyZdL2zcZzZXZVhkgR6wc87b+KAEhS/ZydaTWIMqW/5t1vmgAB0fxfpRNVuKvRsJ2ndqwsQaiQ50z/dYU8brUR9iL8jC8Hus1mEHQR4F0pzJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707394146; c=relaxed/simple;
	bh=3MMu0Y0CQdulA1m2A3YQhoiuTaMYOljYq8OdGTWMeL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lSiTyOVrVC1un6+ItJzmUAM9y3uUrFEkDRVDCoq1HYpqbOXiv4NQBwUTVSQk7SgG24TC0lxxwY4Tu/5D+3OIZyKtupESU/8cjHYdFVdUGjcfvJ5kYg4bM6mRBFEkXJpyJencbuUXP58hJmsbb3rocthkLqzF7wlrRvjotar5qrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TUSSU38v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EF47C433C7;
	Thu,  8 Feb 2024 12:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707394145;
	bh=3MMu0Y0CQdulA1m2A3YQhoiuTaMYOljYq8OdGTWMeL0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TUSSU38veRFJ+Rx7rU48pMBZsjFYDKTOeZQw+rv26zxOdSn4iZne0n+H9Yz8Br4D2
	 1eDdDBVgP99RfEIms2Cu+Y3SqTp3JahXmknTq2efrcc4jZoZRfChd8SU1Y+7XmYT2j
	 pNTdzOy3XaYyLUhQ6y4HbVnXmO/kKAhD/UOFxfx3XVkP+8jeIuO4rMkJZMjrQvbdnz
	 1SJB0P4DufJq9gj9vK/cpwWaJ9J3SlXPLVX94euxlmyd1nZOuSb86OiX6TdSsHxbjc
	 RM567eHHKDvXUXf6U9aoFq23Xs1LLgD3P3PftiIBzS/teEb2M/pvbYIk+mvXlI0EVW
	 5dy9hG5NQ/YBg==
Date: Thu, 8 Feb 2024 12:09:01 +0000
From: Lee Jones <lee@kernel.org>
To: Xing Tong Wu <xingtong_wu@163.com>
Cc: Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
	Xing Tong Wu <xingtong.wu@siemens.com>,
	Tobias Schaffner <tobias.schaffner@siemens.com>,
	Gerd Haeussler <gerd.haeussler.ext@siemens.com>,
	Henning Schild <henning@hennsch.de>
Subject: Re: [PATCH RESEND 1/1] leds: simatic-ipc-leds-gpio: add support for
 module BX-59A
Message-ID: <20240208120901.GL689448@google.com>
References: <20240204083048.2458-1-xingtong_wu@163.com>
 <20240204083048.2458-2-xingtong_wu@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240204083048.2458-2-xingtong_wu@163.com>

On Sun, 04 Feb 2024, Xing Tong Wu wrote:

> From: Xing Tong Wu <xingtong.wu@siemens.com>
> 
> This is used for the Siemens Simatic IPC BX-59A, which has its LEDs
> connected to GPIOs provided by the Nuvoton NCT6126D
> 
> Signed-off-by: Xing Tong Wu <xingtong.wu@siemens.com>
> ---
>  .../leds/simple/simatic-ipc-leds-gpio-core.c  |  1 +
>  .../simple/simatic-ipc-leds-gpio-f7188x.c     | 42 ++++++++++++++++---
>  2 files changed, 37 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/leds/simple/simatic-ipc-leds-gpio-core.c b/drivers/leds/simple/simatic-ipc-leds-gpio-core.c
> index 667ba1bc3a30..85003fd7f1aa 100644
> --- a/drivers/leds/simple/simatic-ipc-leds-gpio-core.c
> +++ b/drivers/leds/simple/simatic-ipc-leds-gpio-core.c
> @@ -56,6 +56,7 @@ int simatic_ipc_leds_gpio_probe(struct platform_device *pdev,
>  	case SIMATIC_IPC_DEVICE_127E:
>  	case SIMATIC_IPC_DEVICE_227G:
>  	case SIMATIC_IPC_DEVICE_BX_21A:
> +	case SIMATIC_IPC_DEVICE_BX_59A:
>  		break;
>  	default:
>  		return -ENODEV;
> diff --git a/drivers/leds/simple/simatic-ipc-leds-gpio-f7188x.c b/drivers/leds/simple/simatic-ipc-leds-gpio-f7188x.c
> index c7c3a1f986e6..783e74e9a805 100644
> --- a/drivers/leds/simple/simatic-ipc-leds-gpio-f7188x.c
> +++ b/drivers/leds/simple/simatic-ipc-leds-gpio-f7188x.c
> @@ -17,7 +17,10 @@
>  
>  #include "simatic-ipc-leds-gpio.h"
>  
> -static struct gpiod_lookup_table simatic_ipc_led_gpio_table = {
> +static struct gpiod_lookup_table *led_lookup_table;
> +static struct gpiod_lookup_table *led_lookup_table_extra;

No globals please.

Dynamically create them in .probe().

If you need to use them later use dev_{s,g}et_drvdata.

> +static struct gpiod_lookup_table simatic_ipc_led_gpio_table_227g = {
>  	.dev_id = "leds-gpio",
>  	.table = {
>  		GPIO_LOOKUP_IDX("gpio-f7188x-2", 0, NULL, 0, GPIO_ACTIVE_LOW),
> @@ -30,7 +33,7 @@ static struct gpiod_lookup_table simatic_ipc_led_gpio_table = {
>  	},
>  };
>  
> -static struct gpiod_lookup_table simatic_ipc_led_gpio_table_extra = {
> +static struct gpiod_lookup_table simatic_ipc_led_gpio_table_extra_227g = {
>  	.dev_id = NULL, /* Filled during initialization */
>  	.table = {
>  		GPIO_LOOKUP_IDX("gpio-f7188x-3", 6, NULL, 6, GPIO_ACTIVE_HIGH),
> @@ -39,16 +42,43 @@ static struct gpiod_lookup_table simatic_ipc_led_gpio_table_extra = {
>  	},
>  };
>  
> +static struct gpiod_lookup_table simatic_ipc_led_gpio_table_bx_59a = {
> +	.dev_id = "leds-gpio",
> +	.table = {
> +		GPIO_LOOKUP_IDX("gpio-f7188x-2", 0, NULL, 0, GPIO_ACTIVE_LOW),
> +		GPIO_LOOKUP_IDX("gpio-f7188x-2", 3, NULL, 1, GPIO_ACTIVE_LOW),
> +		GPIO_LOOKUP_IDX("gpio-f7188x-5", 3, NULL, 2, GPIO_ACTIVE_LOW),
> +		GPIO_LOOKUP_IDX("gpio-f7188x-5", 2, NULL, 3, GPIO_ACTIVE_LOW),
> +		GPIO_LOOKUP_IDX("gpio-f7188x-7", 7, NULL, 4, GPIO_ACTIVE_LOW),
> +		GPIO_LOOKUP_IDX("gpio-f7188x-7", 4, NULL, 5, GPIO_ACTIVE_LOW),
> +		{} /* Terminating entry */
> +	}
> +};
> +
>  static int simatic_ipc_leds_gpio_f7188x_probe(struct platform_device *pdev)
>  {
> -	return simatic_ipc_leds_gpio_probe(pdev, &simatic_ipc_led_gpio_table,
> -					   &simatic_ipc_led_gpio_table_extra);
> +	const struct simatic_ipc_platform *plat = pdev->dev.platform_data;
> +
> +	switch (plat->devmode) {
> +	case SIMATIC_IPC_DEVICE_227G:
> +		led_lookup_table = &simatic_ipc_led_gpio_table_227g;
> +		led_lookup_table_extra = &simatic_ipc_led_gpio_table_extra_227g;
> +		break;
> +	case SIMATIC_IPC_DEVICE_BX_59A:
> +		led_lookup_table = &simatic_ipc_led_gpio_table_bx_59a;
> +		break;
> +	default:
> +		return -ENODEV;
> +	}
> +
> +	return simatic_ipc_leds_gpio_probe(pdev, led_lookup_table,
> +					   led_lookup_table_extra);
>  }
>  
>  static void simatic_ipc_leds_gpio_f7188x_remove(struct platform_device *pdev)
>  {
> -	simatic_ipc_leds_gpio_remove(pdev, &simatic_ipc_led_gpio_table,
> -				     &simatic_ipc_led_gpio_table_extra);
> +	simatic_ipc_leds_gpio_remove(pdev, led_lookup_table,
> +				     led_lookup_table_extra);
>  }
>  
>  static struct platform_driver simatic_ipc_led_gpio_driver = {
> -- 
> 2.25.1
> 

-- 
Lee Jones [李琼斯]

