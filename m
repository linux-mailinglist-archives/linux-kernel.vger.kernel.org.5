Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81B327B7795
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 08:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjJDGBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 02:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232585AbjJDGBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 02:01:51 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A6AAF
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 23:01:44 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c5ff5f858dso13225225ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 23:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696399304; x=1697004104; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2AsdbIyv3XcAYC3suv1NhcQN7xXYxXg8ts9w0KLbx0U=;
        b=XQhOi5E1pijdvUgbDCU75RzHrMPix5eiY8c8kIJ3EIjwY3qEqbpyx06ck6VMfIZ1+X
         6JryMG7ke4C0MmDo6xULb7hJuUn9zaSpEfdTmnGQCxUVLKlEqFMbdj6s0B4ZsYDZihrh
         EyadvtTDfr6s+JVwIlac96IupSqtgHSp7EYb/C1x/57XHAIzGdp4AOQd0EZtin0r3RND
         d2PRw2xwfsvT+gFM9XmCPQgB9pvQPffS2kIOYFH8/FYgYq3NdrFvvSyhh/lU88McPXeF
         o6F5WcMeTMF4zcIkscIeCOtfk5xc5+miqQBnG5tH4Fjl2SFf1y9baBtQt1W1BM6lUTHo
         ZEng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696399304; x=1697004104;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2AsdbIyv3XcAYC3suv1NhcQN7xXYxXg8ts9w0KLbx0U=;
        b=i+8Oqkj+Z8j/13eZ4hnOSl9j1bqtNMaE3zi8ucCnsmLR9/Gk7fUI3/JB32+BxU+Ikv
         abZZTG+xkBte4TQvl8w5RRPO/T5K3/YfLzcVwSwyeCEKOY/LiyJ/y9JJpQkoEn4w8nL5
         Kw290Vr/pZUmBqJZE6dJhgKfh9E0zNWzH64YhkRtAwrESrUD3GTUU/EJgjxAaMWD4ZGa
         ebnqx92bA1RX7lke7w5nwmsKzoTx3y9UuR6CIbgdHiN/pqcMaFh6hkBFrlDkVtgDpyQ8
         BAiWgcm7pGXTdgX4V+af48ikn7OQil/lkk41VGdxA02Du98AyCIAMPEx4eC9xaM/a/Zz
         5cUQ==
X-Gm-Message-State: AOJu0YxYKpwTOCq7OcbEmYcdoFPaF15NfktCjlMrt3tierGBwN9mHnsF
        Gq8EZ/hc8r53CEGRvZiCrdlYRQ==
X-Google-Smtp-Source: AGHT+IGCj5ut6r5kBF2Dhj8lVGxq0KhDKOo/FWs618LaeYnXFGYjKIhGppdpnZOvRt2vIMJ/oCWYMw==
X-Received: by 2002:a17:902:d485:b0:1c8:791c:d782 with SMTP id c5-20020a170902d48500b001c8791cd782mr502820plg.29.1696399304145;
        Tue, 03 Oct 2023 23:01:44 -0700 (PDT)
Received: from localhost ([122.172.81.92])
        by smtp.gmail.com with ESMTPSA id w9-20020a1709026f0900b001c73f52dbb6sm2752530plk.17.2023.10.03.23.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 23:01:43 -0700 (PDT)
Date:   Wed, 4 Oct 2023 11:31:40 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>, soc@kernel.org
Subject: Re: [PATCH 17/36] pinctrl: spear: use new pinctrl GPIO helpers
Message-ID: <20231004060140.ivkvtabblqesleow@vireshk-i7>
References: <20231003145114.21637-1-brgl@bgdev.pl>
 <20231003145114.21637-18-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003145114.21637-18-brgl@bgdev.pl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-10-23, 16:50, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Replace the pinctrl helpers taking the global GPIO number as argument
> with the improved variants that instead take a pointer to the GPIO chip
> and the controller-relative offset.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/pinctrl/spear/pinctrl-plgpio.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pinctrl/spear/pinctrl-plgpio.c b/drivers/pinctrl/spear/pinctrl-plgpio.c
> index 722681e0b89b..7488f6394318 100644
> --- a/drivers/pinctrl/spear/pinctrl-plgpio.c
> +++ b/drivers/pinctrl/spear/pinctrl-plgpio.c
> @@ -204,14 +204,13 @@ static void plgpio_set_value(struct gpio_chip *chip, unsigned offset, int value)
>  static int plgpio_request(struct gpio_chip *chip, unsigned offset)
>  {
>  	struct plgpio *plgpio = gpiochip_get_data(chip);
> -	int gpio = chip->base + offset;
>  	unsigned long flags;
>  	int ret = 0;
>  
>  	if (offset >= chip->ngpio)
>  		return -EINVAL;
>  
> -	ret = pinctrl_gpio_request(gpio);
> +	ret = pinctrl_gpio_request_new(chip, offset);
>  	if (ret)
>  		return ret;
>  
> @@ -249,14 +248,13 @@ static int plgpio_request(struct gpio_chip *chip, unsigned offset)
>  	if (!IS_ERR(plgpio->clk))
>  		clk_disable(plgpio->clk);
>  err0:
> -	pinctrl_gpio_free(gpio);
> +	pinctrl_gpio_free_new(chip, offset);
>  	return ret;
>  }
>  
>  static void plgpio_free(struct gpio_chip *chip, unsigned offset)
>  {
>  	struct plgpio *plgpio = gpiochip_get_data(chip);
> -	int gpio = chip->base + offset;
>  	unsigned long flags;
>  
>  	if (offset >= chip->ngpio)
> @@ -280,7 +278,7 @@ static void plgpio_free(struct gpio_chip *chip, unsigned offset)
>  	if (!IS_ERR(plgpio->clk))
>  		clk_disable(plgpio->clk);
>  
> -	pinctrl_gpio_free(gpio);
> +	pinctrl_gpio_free_new(chip, offset);
>  }

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
