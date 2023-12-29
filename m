Return-Path: <linux-kernel+bounces-13243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE07E8201E5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 22:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 870461F22A03
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 21:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2338F14A85;
	Fri, 29 Dec 2023 21:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EndgX7zQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4041428C;
	Fri, 29 Dec 2023 21:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-50e7aed08f4so3959045e87.0;
        Fri, 29 Dec 2023 13:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703885618; x=1704490418; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VLcf4DnNjmVH1eBKYP8AQ3JzGt3sfPALVBGV4694RPo=;
        b=EndgX7zQlXO1GVbBkzYkeGu3KQ5Vp8ggB8cf9nqIvFjK+T0Uoe3axF45Z5/+iMxZtu
         WOT8v8LLlykLXX/1RuaX3EGEjlmnNjcmzgugp3mXJHtbr1nGe705TX3xAWQysp1wn/o1
         yVDNesIOmlPnTeAy5fVLMAKCHxFVhSR1u7Dcr9ldqG5ZkoBoiFdR7FirDeWJ9sDH03XR
         6S1B3DVwT83yLdfCpXAn3pmnShIpbi9hBjgm+lxJnRdTHVptmT6ZdXQPzXUxf3d/tfS6
         GNlBoGCz5FQWzgdsCSuEPOhQxpPNdWZKJeboAA4vaQ6yHD7bgL5XlKLL+DEJHsJJZ5SL
         wvKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703885618; x=1704490418;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VLcf4DnNjmVH1eBKYP8AQ3JzGt3sfPALVBGV4694RPo=;
        b=uhP+gPm9GlNsn4EEgJ2udso0/gwHozjYoVYHpdlN4pbrWHyoK7uTXk/EJWyb/wKAM9
         vbIEM3WOBb/2PVLhiMBiEAycEkA67Q2pTlvvytaqfmr1fhUeHXkeb3ECnJ1eFpIqKaI0
         G2BCrrdg5G6XymeASEp2wPlO5fKKyCi/VzCohWX+R4NdSzmD5KPHK6pnTolS2LUApu7v
         qeKiJQZE1UMzFl77pQtF95FBPp+YWimOcx/LmU7oi0w0EirtOVdWQLRdS8ZGCUPngJG9
         QGSUbbKGLTiOLPXHkJVFOowWolkLSqQ/aZ7M2uOmq7dDcFAL36ofsL3+bBwfbfhEl/Ak
         8P/A==
X-Gm-Message-State: AOJu0Yx0wYC3usRFuHPjbsUcriyRKcXTvrdFxN2jnoZJYYD34TA39OZc
	WK3fq5nTeK+Vivx8vyHCt0g=
X-Google-Smtp-Source: AGHT+IGwfDXludHVFnm1qfqxuo6bcwP2xZNNv1q2LaeYV4UdYmNuV1VFEz+0azGr8gH4jtOVSxgZ/A==
X-Received: by 2002:a19:670c:0:b0:50e:77e0:dc45 with SMTP id b12-20020a19670c000000b0050e77e0dc45mr4592680lfc.6.1703885617867;
        Fri, 29 Dec 2023 13:33:37 -0800 (PST)
Received: from mobilestation ([95.79.203.166])
        by smtp.gmail.com with ESMTPSA id be44-20020a056512252c00b0050e78f5178asm1788495lfb.262.2023.12.29.13.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Dec 2023 13:33:37 -0800 (PST)
Date: Sat, 30 Dec 2023 00:33:35 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hoan Tran <hoan@os.amperecomputing.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andy@kernel.org>, 
	Jisheng Zhang <jszhang@kernel.org>, Drew Fustini <dfustini@baylibre.com>
Subject: Re: [PATCH v1] gpio: dwapb: Use generic request, free and set_config
Message-ID: <rgdbbvp5x5fp7m3klikacizt5rbg3iyfwk6glr2yrdmcxxrzxi@6godabmsp2ub>
References: <20231229130758.84214-1-emil.renner.berthing@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231229130758.84214-1-emil.renner.berthing@canonical.com>

On Fri, Dec 29, 2023 at 02:07:51PM +0100, Emil Renner Berthing wrote:
> This way GPIO will be denied on pins already claimed by other devices
> and basic pin configuration (pull-up, pull-down etc.) can be done
> through the userspace GPIO API.
> 
> Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

LGTM. Thanks!
Acked-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> ---
>  drivers/gpio/gpio-dwapb.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-dwapb.c b/drivers/gpio/gpio-dwapb.c
> index 8c59332429c2..798235791f70 100644
> --- a/drivers/gpio/gpio-dwapb.c
> +++ b/drivers/gpio/gpio-dwapb.c
> @@ -416,11 +416,12 @@ static int dwapb_gpio_set_config(struct gpio_chip *gc, unsigned offset,
>  {
>  	u32 debounce;
>  
> -	if (pinconf_to_config_param(config) != PIN_CONFIG_INPUT_DEBOUNCE)
> -		return -ENOTSUPP;
> +	if (pinconf_to_config_param(config) == PIN_CONFIG_INPUT_DEBOUNCE) {
> +		debounce = pinconf_to_config_argument(config);
> +		return dwapb_gpio_set_debounce(gc, offset, debounce);
> +	}
>  
> -	debounce = pinconf_to_config_argument(config);
> -	return dwapb_gpio_set_debounce(gc, offset, debounce);
> +	return gpiochip_generic_config(gc, offset, config);
>  }
>  
>  static int dwapb_convert_irqs(struct dwapb_gpio_port_irqchip *pirq,
> @@ -530,10 +531,14 @@ static int dwapb_gpio_add_port(struct dwapb_gpio *gpio,
>  	port->gc.fwnode = pp->fwnode;
>  	port->gc.ngpio = pp->ngpio;
>  	port->gc.base = pp->gpio_base;
> +	port->gc.request = gpiochip_generic_request;
> +	port->gc.free = gpiochip_generic_free;
>  
>  	/* Only port A support debounce */
>  	if (pp->idx == 0)
>  		port->gc.set_config = dwapb_gpio_set_config;
> +	else
> +		port->gc.set_config = gpiochip_generic_config;
>  
>  	/* Only port A can provide interrupts in all configurations of the IP */
>  	if (pp->idx == 0)
> -- 
> 2.43.0
> 

