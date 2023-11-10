Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70E567E8297
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 20:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346252AbjKJTV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 14:21:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346108AbjKJTV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 14:21:26 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62DB23A21D;
        Fri, 10 Nov 2023 07:03:30 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-675b844adc7so12715196d6.0;
        Fri, 10 Nov 2023 07:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699628609; x=1700233409; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=UV9ojQQV9lp7bWpImaulGYCMn8FCIA2tW0lvXELXeTo=;
        b=OGZnRtoGTzxrHJ1CkPfGNRCsUBYcb41RHrq8jl/IVKkJkHd2qDhLdZ+1vWbmuGDk98
         Hq1PECLZHWt8v/fJYhA/LtaG7S+bUJDjtorSPoul2danlBtsM/IN7okPt3fS+5cURGq+
         N9ts7B/IdbxbasdmPI28qTqoY1NcH8jZQK3vx0vogTKkbDJHX+k+2f2PRe5yzsINMRoY
         m9LkI1fgQqNawJ2TWiNcl20XGCPl1hi+8P4EgUr6EbtHmkc3TamOqOhddg5QYy9488Hk
         j0gURBfgAThHcScoB9IytI5rxAheQUYCdqSQ0ML4t9TUgTJ5udYjdTkQPB6F7yVRk2OA
         tcQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699628609; x=1700233409;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UV9ojQQV9lp7bWpImaulGYCMn8FCIA2tW0lvXELXeTo=;
        b=ujW2Xv5A31juGkD0z1qOm5fsVkMeoRQjz/IHlvpKT/NeIEYFzq4Pepf4k/int4X0q/
         Fm5Z4ARsupc7XjMr0fqG50LzUYu3wk7ItoP2XZ5zAUwsvWmQf7KKEvmoW9sbEtAJB5X5
         YzeEMGOCbTRmGEJqOpntH6/PuAY36rs2JMTksf1FBXo0lFDj39TOyan0eBC1trHKrbnb
         DTDe/c4BQPvGQ22qv9o0KYgcZ/3rXa0IEpj1N63267Phy7GvCt11QwU1zwuhJXSAmvaM
         Ct3QJcOF81iBrizpy9mWuVbLMTXfELkvSKjSV3CnUmt93DOIgXlp3V02LseaoSAp9D2z
         DCYw==
X-Gm-Message-State: AOJu0YwQERNCt6PFVwx6XrC6nBVzxtCaKZWMfVDUJ2w40PjhoAT8drr6
        gAHpw4eqAqAWRaTBa68hD5bFJJZdFVo=
X-Google-Smtp-Source: AGHT+IGipuNGdVC4WHAspXXud93VmTTTX3JKUFiRbfJTY8s+prJPnI8DllVZSOcGFaDRXv2yyJlVew==
X-Received: by 2002:a05:6214:f02:b0:65b:22cf:101e with SMTP id gw2-20020a0562140f0200b0065b22cf101emr9818586qvb.54.1699628609329;
        Fri, 10 Nov 2023 07:03:29 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o6-20020a0cecc6000000b0063d5d173a51sm2966535qvq.50.2023.11.10.07.03.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Nov 2023 07:03:28 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <40590367-0a38-4c4c-a608-1174a5ecd5ae@roeck-us.net>
Date:   Fri, 10 Nov 2023 07:03:25 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] watchdog: rti_wdt: Use managed APIs to handle runtime
 PM
Content-Language: en-US
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     Tero Kristo <t-kristo@kernel.org>, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        afd@ti.com, n-francis@ti.com
References: <20231110100726.2930218-1-vigneshr@ti.com>
 <20231110100726.2930218-2-vigneshr@ti.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20231110100726.2930218-2-vigneshr@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/23 02:07, Vignesh Raghavendra wrote:
> Switch to devm_pm_runtime_enable() to simplify error handling in driver
> probe.
> 

This also replaces the call to pm_runtime_resume_and_get() without explanation.
Worse, the next patch conditionally re-introduces pm_runtime_put_sync()
on the probe function.

> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---
>   drivers/watchdog/rti_wdt.c | 30 ++++++++----------------------
>   1 file changed, 8 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/watchdog/rti_wdt.c b/drivers/watchdog/rti_wdt.c
> index 8e1be7ba0103..163bdeb6929a 100644
> --- a/drivers/watchdog/rti_wdt.c
> +++ b/drivers/watchdog/rti_wdt.c
> @@ -236,12 +236,8 @@ static int rti_wdt_probe(struct platform_device *pdev)
>   	if (wdt->freq < 32768)
>   		wdt->freq = wdt->freq * 9 / 10;
>   
> -	pm_runtime_enable(dev);
> -	ret = pm_runtime_resume_and_get(dev);
> -	if (ret < 0) {
> -		pm_runtime_disable(&pdev->dev);
> -		return dev_err_probe(dev, ret, "runtime pm failed\n");
> -	}
> +	devm_pm_runtime_enable(dev);

devm_pm_runtime_enable() returns an error code. I don't think ignoring it
is a good idea.

> +	pm_runtime_get_noresume(dev);

Is this functionally identical to pm_runtime_resume_and_get() ?
That would require further explanation. Why is it not necessary
to resume here ?

Also, doesn't the next patch fix or at least modify this ?

>   
>   	platform_set_drvdata(pdev, wdt);
>   
> @@ -260,7 +256,7 @@ static int rti_wdt_probe(struct platform_device *pdev)
>   	wdt->base = devm_platform_ioremap_resource(pdev, 0);
>   	if (IS_ERR(wdt->base)) {
>   		ret = PTR_ERR(wdt->base);
> -		goto err_iomap;
> +		return ret;
>   	}
>   
>   	if (readl(wdt->base + RTIDWDCTRL) == WDENABLE_KEY) {
> @@ -286,7 +282,7 @@ static int rti_wdt_probe(struct platform_device *pdev)
>   		ret = rti_wdt_setup_hw_hb(wdd, wsize);
>   		if (ret) {
>   			dev_err(dev, "bad window size.\n");
> -			goto err_iomap;
> +			return ret;
>   		}
>   
>   		last_ping = heartbeat_ms - time_left_ms;
> @@ -301,7 +297,7 @@ static int rti_wdt_probe(struct platform_device *pdev)
>   		ret = of_address_to_resource(node, 0, &res);
>   		if (ret) {
>   			dev_err(dev, "No memory address assigned to the region.\n");
> -			goto err_iomap;
> +			return ret;
>   		}
>   
>   		/*
> @@ -312,15 +308,13 @@ static int rti_wdt_probe(struct platform_device *pdev)
>   		reserved_mem_size = resource_size(&res);
>   		if (reserved_mem_size < RESERVED_MEM_MIN_SIZE) {
>   			dev_err(dev, "The size of reserved memory is too small.\n");
> -			ret = -EINVAL;
> -			goto err_iomap;
> +			return -EINVAL;
>   		}
>   
>   		vaddr = memremap(paddr, reserved_mem_size, MEMREMAP_WB);
>   		if (!vaddr) {
>   			dev_err(dev, "Failed to map memory-region.\n");
> -			ret = -ENOMEM;
> -			goto err_iomap;
> +			return -ENOMEM;
>   		}
>   
>   		if (vaddr[0] == PON_REASON_SOF_NUM &&
> @@ -337,19 +331,13 @@ static int rti_wdt_probe(struct platform_device *pdev)
>   	ret = watchdog_register_device(wdd);
>   	if (ret) {
>   		dev_err(dev, "cannot register watchdog device\n");
> -		goto err_iomap;
> +		return ret;
>   	}
>   
>   	if (last_ping)
>   		watchdog_set_last_hw_keepalive(wdd, last_ping);
>   
>   	return 0;
> -
> -err_iomap:
> -	pm_runtime_put_sync(&pdev->dev);
> -	pm_runtime_disable(&pdev->dev);
> -
> -	return ret;
>   }
>   
>   static void rti_wdt_remove(struct platform_device *pdev)
> @@ -357,8 +345,6 @@ static void rti_wdt_remove(struct platform_device *pdev)
>   	struct rti_wdt_device *wdt = platform_get_drvdata(pdev);
>   
>   	watchdog_unregister_device(&wdt->wdd);
> -	pm_runtime_put(&pdev->dev);
> -	pm_runtime_disable(&pdev->dev);
>   }
>   
>   static const struct of_device_id rti_wdt_of_match[] = {

