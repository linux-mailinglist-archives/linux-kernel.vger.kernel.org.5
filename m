Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BCAD7AED2C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 14:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234700AbjIZMru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 08:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233739AbjIZMrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 08:47:48 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2DCC9;
        Tue, 26 Sep 2023 05:47:42 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id e9e14a558f8ab-35156de5404so2247335ab.2;
        Tue, 26 Sep 2023 05:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695732461; x=1696337261; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Po1UgbM+4WAxANqKIvCI07RBqF+k+8sm8Tm1iyFobo=;
        b=c4ZUwCZaNo5N6w+GjyQPflRcKNOZmPNgevnUDvQDSQhtfiw+Di8xSJhoNIkQ2vOE9g
         FrbBCr4cHKKov0/wIWBqP5HN6BigDMbOej5AtED9f74Whj2AKRajI4Su1BzqowZsJ6sn
         fi7AXjOSFkfQ+dxouzck5xqT77tgft39HyihTPa9hmcUkLMuzyzknzrBCJHu2Not5PXy
         fvw1bZt1JjS22m6L+S3NZoYh/nZegved2FwMRafbkueAuGA+89nhsH8SAvYl7jzPAA6C
         YZRcZgGoMcozW8MvJDokSwtJsDjIWOhL4qc50hEWa4HktmAFB5m+ARXTor+vFpb3NyS8
         p5OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695732461; x=1696337261;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Po1UgbM+4WAxANqKIvCI07RBqF+k+8sm8Tm1iyFobo=;
        b=l+f86nPrCojFt33CR4Em0NZxa5EznkPK+tElF2d8rnVW/vAeSStYXVcLKQhEAJ06dU
         ya9AkSMBAk8cpeoII0vdsxvNzMj8qpM1ovmhPQKkkbLTlNDVIdRLSqOcroJuss77yoEs
         VljGqOUzX2tjhUcNg0HiABD+mYica1rKuvtg1BGGJGRMM8APrDEgDGHAjlDl4OfZxoC6
         +bLvGqbvAVkqn6uZNuRFDe2G57d81tR5L/+7QytMz5pOMIqUKaajPFKfNvnd9Vg+HPpG
         BI1CghzWkbb7l+DdznPOVxFkhOO9iBRUDW4zZ9wMohA3y6gOj2G6eJU09lbKW2dyN5uw
         DHZw==
X-Gm-Message-State: AOJu0YzJ6x9Z65k3cNIW1HY9r+AaVZGR4Te1edOkJfgsCGc87CpTDKie
        Ayml+mUO7IzC6QPhsjxDRKE=
X-Google-Smtp-Source: AGHT+IE/WxnBOFt31/pepOYHNbOwk2m1BpvlHdCdIzuQmwCrzwSbMwEafgnS8C67S0AtJ616UQu0mg==
X-Received: by 2002:a05:6e02:1092:b0:351:1311:c282 with SMTP id r18-20020a056e02109200b003511311c282mr8710113ilj.9.1695732461382;
        Tue, 26 Sep 2023 05:47:41 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l14-20020a056e021c0e00b0035129b9c61bsm2230212ilh.45.2023.09.26.05.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 05:47:41 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 26 Sep 2023 05:47:39 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Subject: Re: [PATCH v1 1/1] watchdog: gpio_wdt: Make use of device properties
Message-ID: <09644d52-3023-42ce-9106-1c625c49790d@roeck-us.net>
References: <20230925123543.2945710-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925123543.2945710-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 03:35:43PM +0300, Andy Shevchenko wrote:
> Convert the module to be property provider agnostic and allow
> it to be used on non-OF platforms.
> 
> Include mod_devicetable.h explicitly to replace the dropped of.h
> which included mod_devicetable.h indirectly.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/gpio_wdt.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/watchdog/gpio_wdt.c b/drivers/watchdog/gpio_wdt.c
> index 0923201ce874..a7b814ea740b 100644
> --- a/drivers/watchdog/gpio_wdt.c
> +++ b/drivers/watchdog/gpio_wdt.c
> @@ -5,12 +5,13 @@
>   * Author: 2013, Alexander Shiyan <shc_work@mail.ru>
>   */
>  
> -#include <linux/err.h>
>  #include <linux/delay.h>
> -#include <linux/module.h>
> +#include <linux/err.h>
>  #include <linux/gpio/consumer.h>
> -#include <linux/of.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
>  #include <linux/platform_device.h>
> +#include <linux/property.h>
>  #include <linux/watchdog.h>
>  
>  static bool nowayout = WATCHDOG_NOWAYOUT;
> @@ -106,7 +107,6 @@ static const struct watchdog_ops gpio_wdt_ops = {
>  static int gpio_wdt_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> -	struct device_node *np = dev->of_node;
>  	struct gpio_wdt_priv *priv;
>  	enum gpiod_flags gflags;
>  	unsigned int hw_margin;
> @@ -119,7 +119,7 @@ static int gpio_wdt_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, priv);
>  
> -	ret = of_property_read_string(np, "hw_algo", &algo);
> +	ret = device_property_read_string(dev, "hw_algo", &algo);
>  	if (ret)
>  		return ret;
>  	if (!strcmp(algo, "toggle")) {
> @@ -136,16 +136,14 @@ static int gpio_wdt_probe(struct platform_device *pdev)
>  	if (IS_ERR(priv->gpiod))
>  		return PTR_ERR(priv->gpiod);
>  
> -	ret = of_property_read_u32(np,
> -				   "hw_margin_ms", &hw_margin);
> +	ret = device_property_read_u32(dev, "hw_margin_ms", &hw_margin);
>  	if (ret)
>  		return ret;
>  	/* Disallow values lower than 2 and higher than 65535 ms */
>  	if (hw_margin < 2 || hw_margin > 65535)
>  		return -EINVAL;
>  
> -	priv->always_running = of_property_read_bool(np,
> -						     "always-running");
> +	priv->always_running = device_property_read_bool(dev, "always-running");
>  
>  	watchdog_set_drvdata(&priv->wdd, priv);
>  
> -- 
> 2.40.0.1.gaa8946217a0b
> 
