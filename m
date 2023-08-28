Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F35C78A908
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 11:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbjH1Jhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 05:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbjH1Jhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 05:37:41 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF88FF;
        Mon, 28 Aug 2023 02:37:39 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-68a3ced3ec6so2366934b3a.1;
        Mon, 28 Aug 2023 02:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693215459; x=1693820259;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=vxzRBflxUntFnaa2MuzMKnmbng7MzpJTLHAop0crHuk=;
        b=LEr4V8Mnnl5uxmet/mfPG4jmjuSzCCvO3CqsgyYHIaLYJ/coVTRZI2vOf+XywEEeUq
         WJcAzCN/lrWW2c7vLa9TCTmXj40DtWd45nUd1GRmzptKdRwxJQPVIyWaBNxf8hFK6+nq
         9Lr6HViMG4Qtq4JRuFqWkkWg1tOmDL6/TrNHqsljiSO1Rbi+Lq08Parw6FWuoQLDnZDK
         mXRswMFcOPjwr+mhTb+Z+nXNF360/7CaHZlfq+5+2OlZbII67AMApaWBv3V8yTPpdhzl
         jgAAQMO+noN0V6mb3zM1MMO7FdVjNWuABz3w0/q25o1mOrDVTsTcO0/MmuoP6z8b7+nl
         HGDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693215459; x=1693820259;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vxzRBflxUntFnaa2MuzMKnmbng7MzpJTLHAop0crHuk=;
        b=Rf0zlZ0u1IHDTiP3RLdFM4wnDxRWsWW1PnV8zecanN0XYBG0kDdGV5KqQbtkX54rik
         /jpY08USyfhIGhVa0LGyfBMyq/D9JMMUy8zbUZ3dxmRGX0Q8ZZhu4YySAZZyI6jWqiR8
         LuvsLSM+GQltI94ML+Sn56H8BlQXvD7bgqBUBxVrZbMXfiD6yOjpDzBhjLkMEcFGY4PF
         Wd5Ef+RWytuC+O8JcWNpDl5NFHZqbGN2jzZS7qOmRtBCjKJIRbtUZBLcWxjTeUFDJWG5
         i+qc8/9D2RQOw+1ue0+doV/7e2lAdbpObDDLh1NFlJnQMYuZrDjgsO3TQpj3HU/ab9oX
         MLLQ==
X-Gm-Message-State: AOJu0YxJdv8iv/NJbaKfBRsT7KN+rfq+hJknXCYfu9L0+QUNK7j2sy3Z
        k8ljIEN+G59xnxcnXovZQg8=
X-Google-Smtp-Source: AGHT+IF7T9hma0qTMikAluYwOOEqf/UcyYsX1MWFgu9rlDp3E0ZtSFm2Hv+0HWGgfJJzdCrAROWRIQ==
X-Received: by 2002:a05:6a00:2da2:b0:68a:49bc:e0af with SMTP id fb34-20020a056a002da200b0068a49bce0afmr23564650pfb.1.1693215458781;
        Mon, 28 Aug 2023 02:37:38 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m14-20020aa78a0e000000b0062cf75a9e6bsm6218852pfa.131.2023.08.28.02.37.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 02:37:38 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <09d7be2d-c3ee-286c-7035-5a253d033278@roeck-us.net>
Date:   Mon, 28 Aug 2023 02:37:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] watchdog: of_xilinx_wdt: Remove unnecessary clock disable
 call in the remove path
To:     Srinivas Neeli <srinivas.neeli@amd.com>,
        shubhrajyoti.datta@amd.com, michal.simek@amd.com,
        wim@linux-watchdog.org, linux@roeck-us.ne,
        christophe.jaillet@wanadoo.fr
Cc:     linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        git@amd.com, neelisrinivas18@gmail.com
References: <20230828092044.3597916-1-srinivas.neeli@amd.com>
Content-Language: en-US
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230828092044.3597916-1-srinivas.neeli@amd.com>
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

On 8/28/23 02:20, Srinivas Neeli wrote:
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

Needs clk_disable() here as well.

Guenter

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

