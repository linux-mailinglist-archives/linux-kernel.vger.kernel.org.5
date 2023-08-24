Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6DE786B29
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 11:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234786AbjHXJI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 05:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235852AbjHXJIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 05:08:41 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B793010FA;
        Thu, 24 Aug 2023 02:08:39 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-56c87f89178so3932363eaf.1;
        Thu, 24 Aug 2023 02:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692868119; x=1693472919;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lm0tI830r7b1k6eqjLAE//fnJZTUoN2+N1OgFGLuY2w=;
        b=klqnJ4HhLwV7DsG3+G2vThgW5bOsDEyHWXrF2yc1SucvBK6mff2U++b3PTgOVxCAkH
         0j1jYR7//YMG9al4scEHbRFEh+HxnWmtpv7OJEqe8nELNhBtRgVrMsqpaMNfFNhUfrhk
         qnyue9f3106g5f1u/QuCisKQWbxb9L3FlHzMuLhhbPQ3enfnwulOgZs0Tzs8M6I8OS7S
         xaOuFzowqhTK3gtNrOeU+73REwn/FYR3zRxz4hx/f/9PzzLM1wuX3cd4GATEBwfu09qp
         glzZYpdTkPlAMSlvB0MzS9WaO/2X2YmM1aB2fdyDjb6iQ0wQk8MMBvLVh9RrMXE/9YbA
         8HCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692868119; x=1693472919;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lm0tI830r7b1k6eqjLAE//fnJZTUoN2+N1OgFGLuY2w=;
        b=NEXFNjWKzwanMhe1SqmsAEha9coa+SUZeKqX6bLLqVhffa1GbQV0z4JA6oQAMx9aRF
         RgKrfYhbJf37o+qq/sSGuCRsfYYEeOcZLf76Ahz8hvAy3i9CFvUcr5XAdpcHKEJzK80T
         8Oej/5Oyz9WZaghITahl+/D8A7yzNu6YH3+vHvsHtQHKRWUm4GcHBIoxfudJdLK12IWx
         L+T/3NHdIRbLgiaecf3O/0HFY3G1B1qIuAUDqpOmrIu10aZv0ytHt3nqA4dd9QZMVvbB
         VEP+YFSbr+7aZ1fJ8+kvScejL02PFPy2JWkxXYvtUCV8NIzi8Ggy5xvXlOyjveoB67Cb
         3mOg==
X-Gm-Message-State: AOJu0YzzGcWgXdSVFSmROXpL1SxBjvsfNDkQLQ68pdUkMubRlajm79gj
        wc/5xWW3UF1qiJg+nvq+738=
X-Google-Smtp-Source: AGHT+IFUPkQRRtuFNyXgghypFm02zhlTxfVAqcL3cd3m+iT8NkMHY6Kn3cDgEf1bo4k5f8Rg3xI4qg==
X-Received: by 2002:a54:478b:0:b0:3a8:ccf0:103f with SMTP id o11-20020a54478b000000b003a8ccf0103fmr962862oic.3.1692868118954;
        Thu, 24 Aug 2023 02:08:38 -0700 (PDT)
Received: from sol (14-203-61-235.static.tpgi.com.au. [14.203.61.235])
        by smtp.gmail.com with ESMTPSA id j3-20020a62e903000000b006879493aca0sm10625377pfh.26.2023.08.24.02.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 02:08:38 -0700 (PDT)
Date:   Thu, 24 Aug 2023 17:08:33 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2] gpiolib: notify user-space about line state changes
 triggered by kernel
Message-ID: <ZOceEeBuX+Nh7DJo@sol>
References: <20230824085544.110417-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824085544.110417-1-brgl@bgdev.pl>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 10:55:44AM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> We currently only emit CHANGED_CONFIG events when the user-space changes
> GPIO config. We won't be notified if changes come from in-kernel. Let's
> call the notifier chain whenever kernel users change direction or any of
> the active-low, debounce or consumer name settings. We don't notify the
> user-space about the persistence as the uAPI has no notion of it.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
> v1 -> v2:
> - use the gpiod_line_state_notify() helper
> - reorder the code in gpiod_set_debounce() for better readability
> 
>  drivers/gpio/gpiolib.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index 40a0022ea719..1cb7731550ca 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -2439,6 +2439,7 @@ int gpiod_direction_input(struct gpio_desc *desc)
>  	}
>  	if (ret == 0) {
>  		clear_bit(FLAG_IS_OUT, &desc->flags);
> +		gpiod_line_state_notify(desc, GPIO_V2_LINE_CHANGED_CONFIG);
>  		ret = gpio_set_bias(desc);
>  	}
>  

gpiod_direction_input() is called by cdev when a line is requested.
So requesting a line now creates two events - REQUESTED and
HANGED_CONFIG? Even worse - it calls gpiod_direction_input() first, so we
will get CHANGED_CONFIG then REQUESTED??

And a config change from cdev can call this and then generate a
CHANGED_CONFIG event itself, so again double events.

Same for output and probably debounce too (that one is a bit more
convoluted).

Cheers,
Kent.

> @@ -2484,8 +2485,10 @@ static int gpiod_direction_output_raw_commit(struct gpio_desc *desc, int value)
>  		gc->set(gc, gpio_chip_hwgpio(desc), val);
>  	}
>  
> -	if (!ret)
> +	if (!ret) {
>  		set_bit(FLAG_IS_OUT, &desc->flags);
> +		gpiod_line_state_notify(desc, GPIO_V2_LINE_CHANGED_CONFIG);
> +	}
>  	trace_gpio_value(desc_to_gpio(desc), 0, val);
>  	trace_gpio_direction(desc_to_gpio(desc), 0, ret);
>  	return ret;
> @@ -2672,9 +2675,16 @@ EXPORT_SYMBOL_GPL(gpiod_set_config);
>  int gpiod_set_debounce(struct gpio_desc *desc, unsigned int debounce)
>  {
>  	unsigned long config;
> +	int ret;
>  
>  	config = pinconf_to_config_packed(PIN_CONFIG_INPUT_DEBOUNCE, debounce);
> -	return gpiod_set_config(desc, config);
> +	ret = gpiod_set_config(desc, config);
> +	if (ret)
> +		return ret;
> +
> +	gpiod_line_state_notify(desc, GPIO_V2_LINE_CHANGED_CONFIG);
> +
> +	return 0;
>  }
>  EXPORT_SYMBOL_GPL(gpiod_set_debounce);
>  
> @@ -2723,6 +2733,7 @@ void gpiod_toggle_active_low(struct gpio_desc *desc)
>  {
>  	VALIDATE_DESC_VOID(desc);
>  	change_bit(FLAG_ACTIVE_LOW, &desc->flags);
> +	gpiod_line_state_notify(desc, GPIO_V2_LINE_CHANGED_CONFIG);
>  }
>  EXPORT_SYMBOL_GPL(gpiod_toggle_active_low);
>  
> @@ -3330,6 +3341,7 @@ int gpiod_set_consumer_name(struct gpio_desc *desc, const char *name)
>  
>  	kfree_const(desc->label);
>  	desc_set_label(desc, name);
> +	gpiod_line_state_notify(desc, GPIO_V2_LINE_CHANGED_CONFIG);
>  
>  	return 0;
>  }
> -- 
> 2.39.2
> 
