Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81E9278A9A2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 12:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbjH1KJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 06:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbjH1KI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 06:08:58 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD2FC6;
        Mon, 28 Aug 2023 03:08:56 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-68bec3a1c0fso2035865b3a.1;
        Mon, 28 Aug 2023 03:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693217335; x=1693822135;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Px+VTNqgl0u5Hg8gTCpxmritfFHrkhQKKGOP/kk1zcQ=;
        b=KEiX9pJQd6JOFP8bXYjjmGRM80hqKqnY+SQm8GEAFZd7P5ZA4HYAhG5DPhRM3wVguU
         53HpXHYpjA0Lig4aCQQJ8/09XAPj2043TXO30UEvhxE5HB1qJsV/Mfb+Ym+oEdFPvnuI
         dkloSdhpRbcB3rsmnTMG0SEWkO20CtvjG7ZtqozxIGMviiNMuQXIkxDHeOCppkvBiq8I
         CjDQHQnXtVnCM9PjVyJwgGNbSrMSj8tX+42Hcn0bLPnf3dnn58C70FXj5sMj4apZ8/ep
         byiZkcfUIPX6eCjEZnPNFtp+ef/c64MinFzW164muDWazCO6sWBeYK1oOjq4Y/r2SL5Y
         Fz8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693217335; x=1693822135;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Px+VTNqgl0u5Hg8gTCpxmritfFHrkhQKKGOP/kk1zcQ=;
        b=ArKk5Gtt8ufuNYyQ0bUzra0Z+OGI3OWgiJQkXPwWmCPDyDpWzcMQlln5BHiWf5JqsS
         vx8rH4qDbCve9TOexSPiDPDKrrfM2Ot94zJ4MCEl4Haq9UXdIuuFCAqCwSjqPW9WpYF4
         fiMpLpdgTjSxhOlMsWCB0El3NOuT4pZB0HaIklRIFKHieNCQwr0ziUcF1E8AmRWVVeZx
         OOZx/ylLDjAHyJdmpWrsS9JIykX94cz0AyXPqlwlkNtciWXv8Op0MeEPff3jGnIEci4+
         X1u4yUxDyU3F4zCfyXMUeFP1tds/6qLjI1C1oSkriH/1Oyu0Q2D2Gp1C7j8mkjGibc8T
         eN4Q==
X-Gm-Message-State: AOJu0Yx38Bc7HDca42RzeqJ5MPRBJIdR/1ny+OuIMqB9VLaL1ncnMaZh
        zVNvxL9etrkjGIV9IF8Zddc=
X-Google-Smtp-Source: AGHT+IGnVVNxFFeReJcEE6yFuLP676D39PoOFzgYJe70aFILFtPRV1kw/N1Nx5UETNliuV0BRrl+RQ==
X-Received: by 2002:a05:6a21:7786:b0:14c:84e6:1ab4 with SMTP id bd6-20020a056a21778600b0014c84e61ab4mr6093657pzc.33.1693217335473;
        Mon, 28 Aug 2023 03:08:55 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f15-20020a170902ff0f00b001bb8895848bsm6857100plj.71.2023.08.28.03.08.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 03:08:54 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <615a0579-b36e-8303-1050-5b39466921b9@roeck-us.net>
Date:   Mon, 28 Aug 2023 03:08:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V3] watchdog: of_xilinx_wdt: Remove unnecessary clock
 disable call in the remove path
Content-Language: en-US
To:     Srinivas Neeli <srinivas.neeli@amd.com>,
        shubhrajyoti.datta@amd.com, michal.simek@amd.com,
        wim@linux-watchdog.org, christophe.jaillet@wanadoo.fr
Cc:     linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        git@amd.com, neelisrinivas18@gmail.com
References: <20230828095006.3602426-1-srinivas.neeli@amd.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230828095006.3602426-1-srinivas.neeli@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/28/23 02:50, Srinivas Neeli wrote:
> There is a mismatch in axi clock enable and disable calls.
> The axi clock is enabled and disabled by the probe function,
> then it is again disabled in the remove path.
> So observed the call trace while removing the module.
> Use the clk_enable() and devm_clk_get_prepared() functions
> instead of devm_clk_get_enable() to avoid an extra clock disable
> call from the remove path.
> 
>   Call trace:
>    clk_core_disable+0xb0/0xc0
>    clk_disable+0x30/0x4c
>    clk_disable_unprepare+0x18/0x30
>    devm_clk_release+0x24/0x40
>    devres_release_all+0xc8/0x190
>    device_unbind_cleanup+0x18/0x6c
>    device_release_driver_internal+0x20c/0x250
>    device_release_driver+0x18/0x24
>    bus_remove_device+0x124/0x130
>    device_del+0x174/0x440
> 
> Fixes: 4de0224c6fbe ("watchdog: of_xilinx_wdt: Use devm_clk_get_enabled() helper")
> Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Changes in V3:
> -> Added "clk_disable() in xwdt_selftest() error path.
> Changes in V2:
> -> Fixed typo in "To" list(linux@roeck-us.net).
> ---
>   drivers/watchdog/of_xilinx_wdt.c | 13 ++++++++++---
>   1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/watchdog/of_xilinx_wdt.c b/drivers/watchdog/of_xilinx_wdt.c
> index 05657dc1d36a..352853e6fe71 100644
> --- a/drivers/watchdog/of_xilinx_wdt.c
> +++ b/drivers/watchdog/of_xilinx_wdt.c
> @@ -187,7 +187,7 @@ static int xwdt_probe(struct platform_device *pdev)
>   
>   	watchdog_set_nowayout(xilinx_wdt_wdd, enable_once);
>   
> -	xdev->clk = devm_clk_get_enabled(dev, NULL);
> +	xdev->clk = devm_clk_get_prepared(dev, NULL);
>   	if (IS_ERR(xdev->clk)) {
>   		if (PTR_ERR(xdev->clk) != -ENOENT)
>   			return PTR_ERR(xdev->clk);
> @@ -218,18 +218,25 @@ static int xwdt_probe(struct platform_device *pdev)
>   	spin_lock_init(&xdev->spinlock);
>   	watchdog_set_drvdata(xilinx_wdt_wdd, xdev);
>   
> +	rc = clk_enable(xdev->clk);
> +	if (rc) {
> +		dev_err(dev, "unable to enable clock\n");
> +		return rc;
> +	}
> +
>   	rc = xwdt_selftest(xdev);
>   	if (rc == XWT_TIMER_FAILED) {
>   		dev_err(dev, "SelfTest routine error\n");
> +		clk_disable(xdev->clk);
>   		return rc;
>   	}
>   
> +	clk_disable(xdev->clk);
> +
>   	rc = devm_watchdog_register_device(dev, xilinx_wdt_wdd);
>   	if (rc)
>   		return rc;
>   
> -	clk_disable(xdev->clk);
> -
>   	dev_info(dev, "Xilinx Watchdog Timer with timeout %ds\n",
>   		 xilinx_wdt_wdd->timeout);
>   

