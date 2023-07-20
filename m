Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B60E375ACF2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 13:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbjGTL1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 07:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjGTL1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 07:27:50 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B612BB
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 04:27:46 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fd190065a8so5713485e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 04:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689852465; x=1690457265;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VitHHB/j4E2FbQyt3l4ZXhmBatL++1XQcdyfy56E4ks=;
        b=UP81D3FUZEgZ5vwArWBUB2oJ88gWEaslSg7iBpzTMCFOc2160r9S55a8+tJIRrg037
         G5V97G5DRX+lKnaXrGKPR4RkO26UxgJt8jjwXdNoWrBHL9PMNAnsv0e2pzeSOz6aayAl
         GgHsnvFzVOsygWLwFJrdshYMfLP8UiNe4w6rUzgm251Sl9KOMlBgnslNsEBK92R63K79
         3CBeIc618P5Q76O+MlGW2BwMj9/tyMlJO+D9K+D0MgAqOTCENCbPUWR85mnkqQMb4Vqf
         aaL/+oCGdDcwftsor9jyjkuAV3UbRIyt6R1E0aYe/V07wxOs59hppx63/8unc4uvHjCe
         s/+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689852465; x=1690457265;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VitHHB/j4E2FbQyt3l4ZXhmBatL++1XQcdyfy56E4ks=;
        b=lD+HypNbMtjXxLZYIpNatzfGqliG59FwFrG/RJCDzLQwxGiggfoTm/WhPzDi6IJZDW
         sVWjTTKNoMpz3TqHcl4Fo4PIBdGsn3g/bJK1L7BGBR9OvaxlDxcYdSVtQX+Vg5O0/AOC
         O+DnjgcpPFicez2/Qfr/wdFnx2fLZr7C20yFvwEJAUTmmFNaUbrAb4j6wZEVJeXLL+zR
         6UrW300qrXz6UYXZqMLVVhdjFHffu1nJ+YLmH7thqKuyFHQmSEMLGOMH9qXbNYCpaKTi
         fysgeFwV/jM9W/CfM+ozdg6DJ6wBJ93GfdigOP4D3WY1Sl8m4VqL85fUMc0d2n625911
         pAkA==
X-Gm-Message-State: ABy/qLZ4SvvxAUa5LDML132NXok+4Me8ondpIgdgD5A6LzsPvRcHI2ph
        MoDk06H9u9bPs4kpw1YUfz6scA==
X-Google-Smtp-Source: APBJJlGRfFt2W2jdIn2r2U6UBgB1doiBi48U/0KDhjcLc5ca7PK5H7HtFWHizlOq4SYZw6yBJM3y0A==
X-Received: by 2002:a05:600c:294a:b0:3fc:182:7eac with SMTP id n10-20020a05600c294a00b003fc01827eacmr7015134wmd.33.1689852464852;
        Thu, 20 Jul 2023 04:27:44 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id c7-20020a05600c0ac700b003fbbe41fd78sm973423wmr.10.2023.07.20.04.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 04:27:44 -0700 (PDT)
Date:   Thu, 20 Jul 2023 12:27:42 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Ying Liu <victor.liu@nxp.com>
Cc:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lee@kernel.org" <lee@kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "deller@gmx.de" <deller@gmx.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH] backlight: gpio_backlight: Drop output gpio direction
 check for initial power state
Message-ID: <20230720112742.GA2525277@aspen.lan>
References: <20230720061105.154821-1-victor.liu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720061105.154821-1-victor.liu@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 06:06:27AM +0000, Ying Liu wrote:
> Bootloader may leave gpio direction as input and gpio value as logical low.
> It hints that initial backlight power state should be FB_BLANK_POWERDOWN
> since the gpio value is literally logical low.

To be honest this probably "hints" that the bootloader simply didn't
consider the backlight at all :-) . I'd rather the patch description
focus on what circumstances lead to the current code making a bad
decision. More like:

  If the GPIO pin is in the input state but the backlight is currently
  off due to default pull downs then ...

> So, let's drop output gpio
> direction check and only check gpio value to set the initial power state.

This check was specifically added by Bartosz so I'd be interested in his
opinion of this change (especially since he is now a GPIO maintainer)!

What motivates (or motivated) the need to check the direction rather
than just read that current logic level on the pin?


Daniel.
[I'm done but since Bartosz and Linus were not on copy of the original
thread I've left the rest of the patch below as a convenience ;-) ]


> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
>  drivers/video/backlight/gpio_backlight.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
> index d3bea42407f1..d28c30b2a35d 100644
> --- a/drivers/video/backlight/gpio_backlight.c
> +++ b/drivers/video/backlight/gpio_backlight.c
> @@ -87,8 +87,7 @@ static int gpio_backlight_probe(struct platform_device *pdev)
>  		/* Not booted with device tree or no phandle link to the node */
>  		bl->props.power = def_value ? FB_BLANK_UNBLANK
>  					    : FB_BLANK_POWERDOWN;
> -	else if (gpiod_get_direction(gbl->gpiod) == 0 &&
> -		 gpiod_get_value_cansleep(gbl->gpiod) == 0)
> +	else if (gpiod_get_value_cansleep(gbl->gpiod) == 0)
>  		bl->props.power = FB_BLANK_POWERDOWN;
>  	else
>  		bl->props.power = FB_BLANK_UNBLANK;
> --
> 2.37.1
>
