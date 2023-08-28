Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85BAA78A91B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 11:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbjH1Jnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 05:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjH1Jng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 05:43:36 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6357DCA;
        Mon, 28 Aug 2023 02:43:34 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1bc3d94d40fso22955905ad.3;
        Mon, 28 Aug 2023 02:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693215814; x=1693820614;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=A+VZDAzBAelc0XI5KsnXKmCjPMfxaqkHPwGhy0jrP/w=;
        b=jKxGkAxEh5+u0o6gnULcVppH673jhluzFOAi+ZdCsHejHSP8x80snUWnJLFcu4YBUY
         in/GMzzPjce2BztPYMNU0PGcuVkC4NPkoeWgVGmzBpaQ5WxBhUEvPnMUKR9ykgzenL1j
         1BfBiRY355HcrVKQGbXn2RsQPOxRNezJQUPIhjgMaMgCuD6FsXiHTunICzLJ7dbCCL/L
         oea30czJcYc/UgmwnuvrAIXN4Vh6lMgZg8y03Kv81lfeAb+v7FClbw/h7yLNDKHDizoV
         pjPS5+3io8KthJR4oHIu/xMcsMhK9k1G0kaqK2R1K/80qrikXjvH5SqIWoOdFd5Ryjj8
         d6yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693215814; x=1693820614;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A+VZDAzBAelc0XI5KsnXKmCjPMfxaqkHPwGhy0jrP/w=;
        b=YmPkDm4fn7JUZsIEwA7Y7OPQuufrBga4jtziWaogAAUejSUYSeqUdXZZhEYfLxPs1h
         x52EFDedtw+dlvH3fmBe7Hwxal/fgVcUdbjCyZ42fI9h/Ni3qHpufy0Dp0mMO5jhMqNw
         oOPt1dXJnxzRw5w5RY68lSRogSctOL1cLo8KeFA3cZQaKEoXyECpz5GwoMN+qun+61K1
         v933RHLILH4ZBZCdi6404K9BORI/eDeQ4jCrvJzV1TLxzcHH+3wZEBOr9LCdbEZNwmQK
         Wy7jhE8y7KOel73HDOWqm2WfyAAV2dy4xSq66GrbK/4QD1cbN0qKNYBoPp9QGAKRPD2S
         olQQ==
X-Gm-Message-State: AOJu0Yzb3PyaSzJURAv/U25snZvvqN8gjefNeGYSvGJQiMYXngoFVAP/
        M2DKHplqShdavB8ZuK7xJL8=
X-Google-Smtp-Source: AGHT+IFAcfj8FyufMbgtk+qhNrA7eC8XTYN/dZK7OOY2qm5vtWic9OBrOsG8G5vWvStEICnm7F7yoQ==
X-Received: by 2002:a17:902:e542:b0:1bf:826:9e30 with SMTP id n2-20020a170902e54200b001bf08269e30mr32760534plf.16.1693215813789;
        Mon, 28 Aug 2023 02:43:33 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id je1-20020a170903264100b001bb99e188fcsm6850331plb.194.2023.08.28.02.43.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 02:43:33 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <76b94aa6-3efe-6e05-0149-7c88b56518ba@roeck-us.net>
Date:   Mon, 28 Aug 2023 02:43:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V2] watchdog: of_xilinx_wdt: Remove unnecessary clock
 disable call in the remove path
Content-Language: en-US
To:     Srinivas Neeli <srinivas.neeli@amd.com>,
        shubhrajyoti.datta@amd.com, michal.simek@amd.com,
        wim@linux-watchdog.org, christophe.jaillet@wanadoo.fr
Cc:     linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        git@amd.com, neelisrinivas18@gmail.com
References: <20230828093756.3598755-1-srinivas.neeli@amd.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230828093756.3598755-1-srinivas.neeli@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/28/23 02:37, Srinivas Neeli wrote:
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
> ---
> Changes in V2:
> -> Fixed typo in "To" list(linux@roeck-us.net).
> ---
>   drivers/watchdog/of_xilinx_wdt.c | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/watchdog/of_xilinx_wdt.c b/drivers/watchdog/of_xilinx_wdt.c
> index 05657dc1d36a..777272f7d326 100644
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
> @@ -218,18 +218,24 @@ static int xwdt_probe(struct platform_device *pdev)
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

Still missing clk_disable() here.

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

