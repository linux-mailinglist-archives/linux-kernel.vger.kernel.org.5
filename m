Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533A47D9C8E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 17:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbjJ0PHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 11:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbjJ0PHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 11:07:08 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFABD10E;
        Fri, 27 Oct 2023 08:07:04 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5a7c95b8d14so16733867b3.3;
        Fri, 27 Oct 2023 08:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698419224; x=1699024024; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=mo3O0p+CzwKWAWB1pfHPZ/CuSeHzf50SCiiPDlGgfRM=;
        b=ZPul4VaLKoLQ3ZJmVGjPrmuuU2BupRz/YrvbZ5R/sUcDJOUV41/tTILqbEKkNBWf4R
         7qYzUQBSs4R+gX0V+4H6Ge3r/hI2E8IBYVQU2puUX2gYw0ICxlKN1kfUNxJR+FB8DDYi
         nI23AY+mzlpWaPQkjxy0UaL6FyaVqVXYrj8T9H2HyaPs8DeXqWssnt8FZg9+pLr3pv0u
         35cNh3YJ7LrTENfCaxZnYR7P3rajCYynkqYM48SRTX6+pVmXiW+bTEnZKIxKeaVtuTqO
         7o2jDB28yYtjY3glafn7RjZkPh9yNo8fP5RT5plQrVKsgT4NwLQgrRAtAWLk3CG3EwyQ
         pw3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698419224; x=1699024024;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mo3O0p+CzwKWAWB1pfHPZ/CuSeHzf50SCiiPDlGgfRM=;
        b=qbpLnORwVh1AUhkCbafZQbawafeDLQsa2dLphUeG2xvxo/uc/PvkdW7HYka/l1920U
         aqQDKg79DCrZE+Ph5H7a9BcvQkSNOtjioQHizJvyKjbe0Zn4NbaoVgIpxpQd5zlkEEuY
         ms4NEY0kMzXTqeZIjlbjkh7SqC+kB/7M4zTaX0/JNHqTj9HhEki1ohU+7aJb8ngOyWR2
         qWpu7f9ef/Mk3PLJtoXn+DS998lD6lA3bsyxkopDI4u1X6ed4SgqZOyeIm02Xk+Xe47W
         KpO9YFAGqmEneEfgRNzzJPqi6AahUKw9mIgKADhmxvunLJrZ+abDVT+RHJGEUQ+k3V3o
         57Bw==
X-Gm-Message-State: AOJu0YylKMuASQaNECjmzVvfWos1mXlgXCyf+3yPcq4R6KviqAl1CcEr
        5puorlyLs+RQoiWANeQOFHg=
X-Google-Smtp-Source: AGHT+IEUA15s9csObhGY1VaWPXTJtNoAaDlDKUPl616L6wjUxkjVM3XBSTS10OJ6jaS8PfKdZ/8TuQ==
X-Received: by 2002:a05:690c:f88:b0:593:47ff:bd7 with SMTP id df8-20020a05690c0f8800b0059347ff0bd7mr3474380ywb.46.1698419223770;
        Fri, 27 Oct 2023 08:07:03 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u84-20020a818457000000b005af9da2225bsm753862ywf.20.2023.10.27.08.07.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Oct 2023 08:07:03 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <22b4d0d7-ee50-2b64-ef0a-745b166230ea@roeck-us.net>
Date:   Fri, 27 Oct 2023 08:07:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/2] watchdog: aspeed: Add support for aspeed,reset-mask
 DT property
Content-Language: en-US
To:     Zev Weiss <zev@bewilderbeest.net>,
        Andrew Jeffery <andrew@aj.id.au>,
        Joel Stanley <joel@jms.id.au>,
        "Milton D. Miller II" <mdmii@outlook.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, openbmc@lists.ozlabs.org
Cc:     Eddie James <eajames@linux.ibm.com>,
        Ivan Mikhaylov <i.mikhaylov@yadro.com>,
        =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>
References: <20230922104231.1434-4-zev@bewilderbeest.net>
 <20230922104231.1434-6-zev@bewilderbeest.net>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230922104231.1434-6-zev@bewilderbeest.net>
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

On 9/22/23 03:42, Zev Weiss wrote:
> This property allows the device-tree to specify how the Aspeed
> watchdog timer's reset mask register(s) should be set, so that
> peripherals can be individually exempted from (or opted in to) being
> reset when the watchdog timer expires.
> 
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/aspeed_wdt.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
> index b72a858bbac7..b4773a6aaf8c 100644
> --- a/drivers/watchdog/aspeed_wdt.c
> +++ b/drivers/watchdog/aspeed_wdt.c
> @@ -79,6 +79,8 @@ MODULE_DEVICE_TABLE(of, aspeed_wdt_of_table);
>   #define   WDT_TIMEOUT_STATUS_BOOT_SECONDARY	BIT(1)
>   #define WDT_CLEAR_TIMEOUT_STATUS	0x14
>   #define   WDT_CLEAR_TIMEOUT_AND_BOOT_CODE_SELECTION	BIT(0)
> +#define WDT_RESET_MASK1		0x1c
> +#define WDT_RESET_MASK2		0x20
>   
>   /*
>    * WDT_RESET_WIDTH controls the characteristics of the external pulse (if
> @@ -402,6 +404,8 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
>   
>   	if ((of_device_is_compatible(np, "aspeed,ast2500-wdt")) ||
>   		(of_device_is_compatible(np, "aspeed,ast2600-wdt"))) {
> +		u32 reset_mask[2];
> +		size_t nrstmask = of_device_is_compatible(np, "aspeed,ast2600-wdt") ? 2 : 1;
>   		u32 reg = readl(wdt->base + WDT_RESET_WIDTH);
>   
>   		reg &= wdt->cfg->ext_pulse_width_mask;
> @@ -419,6 +423,13 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
>   			reg |= WDT_OPEN_DRAIN_MAGIC;
>   
>   		writel(reg, wdt->base + WDT_RESET_WIDTH);
> +
> +		ret = of_property_read_u32_array(np, "aspeed,reset-mask", reset_mask, nrstmask);
> +		if (!ret) {
> +			writel(reset_mask[0], wdt->base + WDT_RESET_MASK1);
> +			if (nrstmask > 1)
> +				writel(reset_mask[1], wdt->base + WDT_RESET_MASK2);
> +		}
>   	}
>   
>   	if (!of_property_read_u32(np, "aspeed,ext-pulse-duration", &duration)) {

