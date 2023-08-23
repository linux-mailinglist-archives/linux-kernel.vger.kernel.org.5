Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A091785C74
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 17:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237307AbjHWPsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 11:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237300AbjHWPsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 11:48:01 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B93CD1;
        Wed, 23 Aug 2023 08:47:59 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1c8d895a602so3364871fac.2;
        Wed, 23 Aug 2023 08:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692805679; x=1693410479;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jjhuWg+MLT4cMd8T4gNbdCXrYUTU7KElmXTebLc+GdU=;
        b=jCQTWKOFbxWZu9idhMYlU+MbhUyuFNvcHsNFrdWKkWcECnjWw7A+0J5c0SHl3rcTwy
         OqQhdnoE8kWhGHA6EILVOzBMkFh8YFlnpGY+EV8A7zX6QnI7nTj1mu4JR8DAmlkd1bXt
         3kCPp5O4cZbzQDSX+LrbdpTTNLtaJ8SIhQCZ0H08kXcN5iVo8zvRSpNAhKHbBXoUCfmy
         DB0oLRCdJHgNgR6tw2kPQXimU3SYZs/NeSYnKiUWL8azFqw4fC1EUB8BqpH1QxkWomTd
         7Okw7DCE4gz+pi3fYQlI841VjRojuS7gVehzFbG1MkDg7+oJL6D+D5/xNbYo47C7rqvr
         JoYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692805679; x=1693410479;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jjhuWg+MLT4cMd8T4gNbdCXrYUTU7KElmXTebLc+GdU=;
        b=kKFXzEiVh1FAD4W8Z8hqRckiCxi7hMecD5vxRzPBsGsSpGNKovarpaMKX2RU1ur2AI
         5CXJdEmWWTWyal5vV1ii0XMnHAVZzahX1B1dPjCVD4hv5pM7BXNEvfmxyXNo9Tp4wQHt
         0PEbJpxByUlF+LJVywftetXrnz53h4CBh5dxKb5/POHA3gfYPW4vFKC8wj7YGLP2mMyB
         P1xbssTfRBUyoOzaRicxs2Tw6hYZSVp6adq7L8jURXjojzfSnALmNHo4kUzarKAbjWtn
         YDtqBEyur6Qxdr9SX1k4psZ/oJMV7T467lAQHBYg2o94lVRe9xihD4KCZzTmcw912paP
         2h/g==
X-Gm-Message-State: AOJu0YyDifFRyH1kmg0DmRzzlao3BlHQCyC5CxD7ami80tiNl8yUCC7g
        Nm/Ak1ORPBvt/xxnFg9lwZI=
X-Google-Smtp-Source: AGHT+IH+4jRD2kRQ7+Wgz70dKoi2Q6Eu4UXirwYcEDVnPoeKqJLeVmHEGJ8xKA66kPh2Ogh0a5LgNw==
X-Received: by 2002:a05:6871:54d:b0:1bf:54b9:800 with SMTP id t13-20020a056871054d00b001bf54b90800mr13217366oal.59.1692805678935;
        Wed, 23 Aug 2023 08:47:58 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id cm1-20020a17090afa0100b0026940eb686bsm11544660pjb.20.2023.08.23.08.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 08:47:58 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 23 Aug 2023 08:47:57 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Huqiang Qin <huqiang.qin@amlogic.com>
Cc:     wim@linux-watchdog.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        neil.armstrong@linaro.org, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 2/4] watchdog: Add a new struct for Amlogic-GXBB driver
Message-ID: <15d24bb9-7539-40bd-a986-36ee0a57e244@roeck-us.net>
References: <20230802033222.4024946-1-huqiang.qin@amlogic.com>
 <20230802033222.4024946-3-huqiang.qin@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802033222.4024946-3-huqiang.qin@amlogic.com>
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

On Wed, Aug 02, 2023 at 11:32:20AM +0800, Huqiang Qin wrote:
> Add a new structure wdt_params to describe the watchdog difference
> of different chips.
> 
> Signed-off-by: Huqiang Qin <huqiang.qin@amlogic.com>
> Reviewed-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> 
> V1 -> V2: Rename rst_shift to rst and use the BIT() macro to build
>           its initial value.
> 
>  drivers/watchdog/meson_gxbb_wdt.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/watchdog/meson_gxbb_wdt.c b/drivers/watchdog/meson_gxbb_wdt.c
> index 35d80cb39856..18180d91543e 100644
> --- a/drivers/watchdog/meson_gxbb_wdt.c
> +++ b/drivers/watchdog/meson_gxbb_wdt.c
> @@ -22,7 +22,6 @@
>  
>  #define GXBB_WDT_CTRL_CLKDIV_EN			BIT(25)
>  #define GXBB_WDT_CTRL_CLK_EN			BIT(24)
> -#define GXBB_WDT_CTRL_EE_RESET			BIT(21)
>  #define GXBB_WDT_CTRL_EN			BIT(18)
>  #define GXBB_WDT_CTRL_DIV_MASK			(BIT(18) - 1)
>  
> @@ -45,6 +44,10 @@ struct meson_gxbb_wdt {
>  	struct clk *clk;
>  };
>  
> +struct wdt_params {
> +	u32 rst;
> +};
> +
>  static int meson_gxbb_wdt_start(struct watchdog_device *wdt_dev)
>  {
>  	struct meson_gxbb_wdt *data = watchdog_get_drvdata(wdt_dev);
> @@ -140,8 +143,12 @@ static const struct dev_pm_ops meson_gxbb_wdt_pm_ops = {
>  	SET_SYSTEM_SLEEP_PM_OPS(meson_gxbb_wdt_suspend, meson_gxbb_wdt_resume)
>  };
>  
> +static const struct wdt_params gxbb_params = {
> +	.rst = BIT(21),
> +};
> +
>  static const struct of_device_id meson_gxbb_wdt_dt_ids[] = {
> -	 { .compatible = "amlogic,meson-gxbb-wdt", },
> +	 { .compatible = "amlogic,meson-gxbb-wdt", .data = &gxbb_params, },
>  	 { /* sentinel */ },
>  };
>  MODULE_DEVICE_TABLE(of, meson_gxbb_wdt_dt_ids);
> @@ -150,6 +157,7 @@ static int meson_gxbb_wdt_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct meson_gxbb_wdt *data;
> +	struct wdt_params *params;
>  	u32 ctrl_reg;
>  
>  	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> @@ -164,6 +172,8 @@ static int meson_gxbb_wdt_probe(struct platform_device *pdev)
>  	if (IS_ERR(data->clk))
>  		return PTR_ERR(data->clk);
>  
> +	params = (struct wdt_params *)of_device_get_match_data(dev);
> +
>  	platform_set_drvdata(pdev, data);
>  
>  	data->wdt_dev.parent = dev;
> @@ -191,7 +201,7 @@ static int meson_gxbb_wdt_probe(struct platform_device *pdev)
>  	/* Setup with 1ms timebase */
>  	ctrl_reg |= ((clk_get_rate(data->clk) / 1000) &
>  			GXBB_WDT_CTRL_DIV_MASK) |
> -			GXBB_WDT_CTRL_EE_RESET |
> +			params->rst |
>  			GXBB_WDT_CTRL_CLK_EN |
>  			GXBB_WDT_CTRL_CLKDIV_EN;
>  
