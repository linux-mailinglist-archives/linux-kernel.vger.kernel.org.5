Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA1C7D24A3
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 18:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbjJVQsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 12:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjJVQsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 12:48:11 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81610E7;
        Sun, 22 Oct 2023 09:48:09 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-5842c251d7cso1181177eaf.1;
        Sun, 22 Oct 2023 09:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697993289; x=1698598089; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=zaC0k6XVBVVgzv+xMwI1MNbASVkxCUyoOYu0hkRSSx8=;
        b=ko0wuXCQLb659lUWo00baA+xGDMeyfhIb9NiQWn+Ubz6bDEUS4NowLJ1lBl84Dfjv+
         LtdBtijul0bJRD7UKms9MlkT7BhngDhqrkbm2Edx0cKWVjVuhssbEUyRpAK9mhtyCcKD
         ZwqXUMPjfxvbyl4aOIC0SVrhjZTtlrbYuOXGS3c6swT52z3wdx6caiF4WhIjIo8fTd9z
         swiImy2ROSi/k0d03pwN10Sv1hB/NNuaH1eh1dDf88qwrrw03IndX1UcEWR0zCqP8Tnn
         9fE3+6XxRZgp8mgamGZyYUXHJ3MlSV4XiflZACTG+v366/9N0VmOzjFREWFC2nQuY8EF
         fOMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697993289; x=1698598089;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zaC0k6XVBVVgzv+xMwI1MNbASVkxCUyoOYu0hkRSSx8=;
        b=G7hWE5zvKEayydFxnZylsIxqsvxWwlRQ4ADMhgHUatmA7QgjHMzNTR977bwbvSM6Ay
         WVvC/bOuAja8RlnfEp3JhdfdoQvDvgGz9lxzo1KGi0A03oirzHQ2rqGV2tcOa1y1lKN3
         KXZlkqEzj6DDuFORjOXGyFlICg9SXpJq9EVS6UZsUwXAdejEfbeaFolP8Bv6EPx29wNx
         ZRgP2t7W0hr5QEKzPbNh9i6jd9l1ucBs6YJ73M7yDUg6mk9nw4gYXgBeX4rOBoNvmssz
         qU4IRvIzjTzhOuae2yL+KoKhNOJN+UG6gU3bFtzRcurcDild6cGKAI4VeynNcjeowfeX
         9ZwA==
X-Gm-Message-State: AOJu0YxExdIVAfgD1A9Yv74vF4qGAmJbaHoT9wq1qmYYr5E0nDl5GCat
        +P+rL8joj9KpXsVP99gbds4=
X-Google-Smtp-Source: AGHT+IGpkNvGgZVMKkF8ZxGYFUTvP28BBBEKhlGAJdl1GmJbCGwO7rIiSfOHfkeIf2OwE4ATpvi6Ig==
X-Received: by 2002:a05:6358:9146:b0:140:f6ab:b11e with SMTP id r6-20020a056358914600b00140f6abb11emr8468882rwr.28.1697993288607;
        Sun, 22 Oct 2023 09:48:08 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f10-20020a631f0a000000b0056b27af8715sm4456037pgf.43.2023.10.22.09.48.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Oct 2023 09:48:08 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <c6149f04-4cf6-8dcc-3aca-d926f49a34d7@roeck-us.net>
Date:   Sun, 22 Oct 2023 09:48:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2] watchdog: apple: Deactivate on suspend
Content-Language: en-US
To:     j@jannau.net, Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231016-apple-watchdog-suspend-v2-1-7ffff8042dbc@jannau.net>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20231016-apple-watchdog-suspend-v2-1-7ffff8042dbc@jannau.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/15/23 23:58, Janne Grunau via B4 Relay wrote:
> From: Janne Grunau <j@jannau.net>
> 
> The watchdog remains active after putting the system into suspend. Add
> PM callbacks to deactivate the watchdog on suspend an re-activate it on
> resume.
> 
> Signed-off-by: Janne Grunau <j@jannau.net>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Changes in v2:
> - use DEFINE_SIMPLE_DEV_PM_OPS
> - Link to v1: https://lore.kernel.org/r/20230930-apple-watchdog-suspend-v1-1-1998c0be9fd7@jannau.net
> ---
>   drivers/watchdog/apple_wdt.c | 25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/watchdog/apple_wdt.c b/drivers/watchdog/apple_wdt.c
> index eddeb0fede89..d4f739932f0b 100644
> --- a/drivers/watchdog/apple_wdt.c
> +++ b/drivers/watchdog/apple_wdt.c
> @@ -173,6 +173,8 @@ static int apple_wdt_probe(struct platform_device *pdev)
>   	if (!wdt->clk_rate)
>   		return -EINVAL;
>   
> +	platform_set_drvdata(pdev, wdt);
> +
>   	wdt->wdd.ops = &apple_wdt_ops;
>   	wdt->wdd.info = &apple_wdt_info;
>   	wdt->wdd.max_timeout = U32_MAX / wdt->clk_rate;
> @@ -190,6 +192,28 @@ static int apple_wdt_probe(struct platform_device *pdev)
>   	return devm_watchdog_register_device(dev, &wdt->wdd);
>   }
>   
> +static int apple_wdt_resume(struct device *dev)
> +{
> +	struct apple_wdt *wdt = dev_get_drvdata(dev);
> +
> +	if (watchdog_active(&wdt->wdd) || watchdog_hw_running(&wdt->wdd))
> +		apple_wdt_start(&wdt->wdd);
> +
> +	return 0;
> +}
> +
> +static int apple_wdt_suspend(struct device *dev)
> +{
> +	struct apple_wdt *wdt = dev_get_drvdata(dev);
> +
> +	if (watchdog_active(&wdt->wdd) || watchdog_hw_running(&wdt->wdd))
> +		apple_wdt_stop(&wdt->wdd);
> +
> +	return 0;
> +}
> +
> +static DEFINE_SIMPLE_DEV_PM_OPS(apple_wdt_pm_ops, apple_wdt_suspend, apple_wdt_resume);
> +
>   static const struct of_device_id apple_wdt_of_match[] = {
>   	{ .compatible = "apple,wdt" },
>   	{},
> @@ -200,6 +224,7 @@ static struct platform_driver apple_wdt_driver = {
>   	.driver = {
>   		.name = "apple-watchdog",
>   		.of_match_table = apple_wdt_of_match,
> +		.pm = pm_sleep_ptr(&apple_wdt_pm_ops),
>   	},
>   	.probe = apple_wdt_probe,
>   };
> 
> ---
> base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
> change-id: 20230930-apple-watchdog-suspend-7f73831130fb
> 
> Best regards,

