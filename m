Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62AAE7A8DA2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 22:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjITUO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 16:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjITUOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 16:14:54 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE23A9;
        Wed, 20 Sep 2023 13:14:48 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c3d6d88231so1656475ad.0;
        Wed, 20 Sep 2023 13:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695240888; x=1695845688; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=iBAkISg4liJpMSv79ebj2TeKhgO/99XxEW65IYWMigQ=;
        b=MdjFWySsnCCx6jy//SfWXKUVvYIWNmGWBHU2BV9hFd8KrNplYqiobZwWieUIn8tomf
         1Vf8s93XEF4iLgUin1QBLwTpfBWH+IuwRsqUnR/7H9TfA4fu8zuP+1uLQ3A7skeaW1tn
         6P8SFfQ/26WGNN5+yL6dBeymRWrHo0f9s+q1nD1Y4nNvIXwFYQ8QaFc+yVhU15hv6Td3
         qGyyUmMGljhIOm7KdWSRQ2oGjsJBlEuJ6ba0ZIsSBrY2etYXh32QhnjM23pMWEquk0nP
         n4ZkqiyhfVFBvIniy/7HwrK9GEblMKucIMjwV6IexkXVtZ4qDcKuCrukJutnG0HQIGNN
         W7Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695240888; x=1695845688;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iBAkISg4liJpMSv79ebj2TeKhgO/99XxEW65IYWMigQ=;
        b=FTdWeV7uZKoevf1ozSrR3ul9Q+swQEdnpTm1IlwGWJuQPEGvgnp4nuzY9XDoTdmK82
         oMVYmPVCggcaYyMytsLkoaKu0eZMFYwziTUvwrv1agjqFnsTkstONIM4OlddRvNQGJmq
         UnxhvVtwngkPL8YW0S+XsnuJDLcCJiSqg9ueUVwhkrVgIe0mx95zx3L8BY2HAq9GZKNH
         k71/1YBjYoDse/R9TFZmSUcLnQSEHZdXRKama2mEtgBTtLsvHqbu4vuoqKkTSdvrp+Om
         b95U0VGgVOlVMGD52sLfy/a6ktUrbzGCHVsWs8dG1XWNZ57gK86jLMB6JVtySqKhpTlD
         GwXg==
X-Gm-Message-State: AOJu0YzdMW2DNdEn6BOUHgA0qixE2ERIy6E6ejAvzbIQdtgc38gLxfFY
        daBzVUFkZTZrjRmcZ39gjPN1AtlcskU=
X-Google-Smtp-Source: AGHT+IEmCDf8b3mlYUNXqLfFkKrJ9PDxO9NjeDkIOVQFK/O/Z5JIlGM1JSxzUBcTuFaxCR1315FDQw==
X-Received: by 2002:a17:903:1211:b0:1c3:61d9:2b32 with SMTP id l17-20020a170903121100b001c361d92b32mr2187662plh.45.1695240887675;
        Wed, 20 Sep 2023 13:14:47 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e12-20020a170902d38c00b001b9de4fb749sm1311015pld.20.2023.09.20.13.14.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 13:14:46 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <f1abf571-c903-ad51-10eb-1e20d2b3ab75@roeck-us.net>
Date:   Wed, 20 Sep 2023 13:14:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 4/6] watchdog: ar7_wdt: remove driver to prepare for
 platform removal
Content-Language: en-US
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mips@vger.kernel.org
Cc:     Jonas Gorski <jonas.gorski@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230920201035.3445-1-wsa+renesas@sang-engineering.com>
 <20230920201035.3445-5-wsa+renesas@sang-engineering.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230920201035.3445-5-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/23 13:10, Wolfram Sang wrote:
> AR7 is going to be removed from the Kernel, so remove its watchdog
> support. This allows us to remove the platform because this driver
> includes a platform specific header.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/Kconfig   |   6 -
>   drivers/watchdog/Makefile  |   1 -
>   drivers/watchdog/ar7_wdt.c | 315 -------------------------------------
>   3 files changed, 322 deletions(-)
>   delete mode 100644 drivers/watchdog/ar7_wdt.c
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 751458959411..b9f715d73fe8 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1768,12 +1768,6 @@ config SIBYTE_WDOG
>   	  To compile this driver as a loadable module, choose M here.
>   	  The module will be called sb_wdog.
>   
> -config AR7_WDT
> -	tristate "TI AR7 Watchdog Timer"
> -	depends on AR7 || (MIPS && 32BIT && COMPILE_TEST)
> -	help
> -	  Hardware driver for the TI AR7 Watchdog Timer.
> -
>   config TXX9_WDT
>   	tristate "Toshiba TXx9 Watchdog Timer"
>   	depends on CPU_TX49XX || (MIPS && COMPILE_TEST)
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index 7eab9de311cb..7cbc34514ec1 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -168,7 +168,6 @@ obj-$(CONFIG_INDYDOG) += indydog.o
>   obj-$(CONFIG_JZ4740_WDT) += jz4740_wdt.o
>   obj-$(CONFIG_WDT_MTX1) += mtx-1_wdt.o
>   obj-$(CONFIG_SIBYTE_WDOG) += sb_wdog.o
> -obj-$(CONFIG_AR7_WDT) += ar7_wdt.o
>   obj-$(CONFIG_TXX9_WDT) += txx9wdt.o
>   obj-$(CONFIG_OCTEON_WDT) += octeon-wdt.o
>   octeon-wdt-y := octeon-wdt-main.o octeon-wdt-nmi.o
> diff --git a/drivers/watchdog/ar7_wdt.c b/drivers/watchdog/ar7_wdt.c
> deleted file mode 100644
> index cdcaeb0961ac..000000000000

