Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC12A7B6C92
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 17:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbjJCPCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 11:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbjJCPCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 11:02:52 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE34AD;
        Tue,  3 Oct 2023 08:02:48 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6910ea9cca1so748223b3a.1;
        Tue, 03 Oct 2023 08:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696345366; x=1696950166; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nS+ccFeanplUyxIAlft8qH746KZhH4ap1TG1HVN92IU=;
        b=LbedeaLwiCYjXXw1pOktqAKzimNV7sS/zTucQGcRInTqDMp5bAkym2al0IeR27fUXJ
         i/gs/JXWwKaFJWeANhpMBsS/BUC7lKKBpRcdmM90Urxc+WE3tQjta9vBmX3F0vApKWOC
         FEvYRQwHs7f/cwg/E1xITn2wfBMCyt0wDoVaEnHbgPUfKK3wnIOEPgqq2dKaQuH6ATuH
         /GVZxCTkHdDw7UeD140jmh96sc86xoorrb0w0HzPqC2LL1fNgWX+DvX78uDkKmB6idIu
         6elbc/8cTG8o4eEt4MRwkEaviVDxHGxBPRTTCovnmsaNBmLbEwEsUxsVX0ZhsKXSyd/O
         Nk/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696345366; x=1696950166;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nS+ccFeanplUyxIAlft8qH746KZhH4ap1TG1HVN92IU=;
        b=sFaUw1mdfNqrNKJzeGF5/r+oWQ9grW6u//2hv35cStl2sv+cJSh53HEMxyNNIij8Du
         TLnFfUSio5C+8usVymJj2uP7ucfHiit/kAfLbnQyC9Xp1Jd+yO7ZA3JJMpSDQIw6lzYd
         ioqT4aygB7LTl2+eOzaPbErOVfXn04xbv8toQELxROics0uly9opWVK4NwMP6GYO4yVQ
         8J9XnFzrUI5YN1o7s2rUxg7H2xFtHv4pdoIxKKB/+HPzMneL0CVMD8NwhBiixFgGWuv/
         akeW27BMNl6EO/EWo/AZbFvXoCF6WjntPpBVJ6OAZNE4o52x8505FTIDM81xbbMiv/VI
         b5LQ==
X-Gm-Message-State: AOJu0YxXP8uhh3o6N74Q5zDjfyH3vIQaHaS+c19QqKIdgTiUx8BhGrBF
        4Ok+5evwQzT31xS7L9qvfnI=
X-Google-Smtp-Source: AGHT+IHSlDJ2mmjoBx/Me+lkCJEt6FVTewL8lb06iJPxb1GKt63w6MNIhtDzqhA4+5n5XL5hnwnN7Q==
X-Received: by 2002:a05:6a20:9144:b0:154:6480:83a4 with SMTP id x4-20020a056a20914400b00154648083a4mr13485861pzc.14.1696345365695;
        Tue, 03 Oct 2023 08:02:45 -0700 (PDT)
Received: from sol (14-200-166-90.static.tpgi.com.au. [14.200.166.90])
        by smtp.gmail.com with ESMTPSA id n15-20020a63b44f000000b00578cc5f4905sm1335986pgu.28.2023.10.03.08.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 08:02:45 -0700 (PDT)
Date:   Tue, 3 Oct 2023 23:02:40 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 04/36] gpio: cdev: use pinctrl_gpio_can_use_line_new()
Message-ID: <ZRwtEG1DamMLZC/3@sol>
References: <20231003145114.21637-1-brgl@bgdev.pl>
 <20231003145114.21637-5-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003145114.21637-5-brgl@bgdev.pl>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2023 at 04:50:42PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Use the improved variant of pinctrl_gpio_can_use_line() which takes a
> pointer to the gpio_chip and a controller-relative offset.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/gpio/gpiolib-cdev.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
> index 31fc71a612c2..54ee075410db 100644
> --- a/drivers/gpio/gpiolib-cdev.c
> +++ b/drivers/gpio/gpiolib-cdev.c
> @@ -2287,8 +2287,7 @@ static void gpio_desc_to_lineinfo(struct gpio_desc *desc,
>  	 * FIXME: find a non-racy way to retrieve this information. Maybe a
>  	 * lock common to both frameworks?
>  	 */
> -	ok_for_pinctrl =
> -		pinctrl_gpio_can_use_line(gc->base + info->offset);
> +	ok_for_pinctrl = pinctrl_gpio_can_use_line_new(gc, info->offset);
>  

_new??  In what sense?

I agree with the change in principle, just not comfortable with the naming.

Cheers,
Kent.

