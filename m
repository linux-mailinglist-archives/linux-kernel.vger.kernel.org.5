Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC72D76C425
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 06:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbjHBE2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 00:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231815AbjHBE2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 00:28:32 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1FF91704
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 21:28:30 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fbd33a57b6so69357845e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 21:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1690950509; x=1691555309;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QxcJxZeLWMHA1jTlTlNhXnSmHm/0Pvbh9+6mG9VUrpw=;
        b=FA1JQ+QZV+Hn0aNlxUPH4m4HsSUNBNf39Ds1S6EF5FQ/6PbFDETpWWOg15Z+895DpD
         KSUWCj3htiACR5LsVRBFZyeqyLBPSI+J9OzzVyQa9KS6+PdwkCR9I+FpWJuS3dDjuwBE
         xrMk7BOAXMwvUqY1ffg1RhSr5u/1FmELk8bxJ6PL/3zfFr4dBpcM4dUgetg6ubI0532z
         wj8Ak2MQhSWrgytyxa/e5owyQcIvzx0fnhFnFG8a1cBUBbje0Obs9PomN1LKcE5OYcz0
         ds+1aEUo30sG8iENdZJwMZXrBx/saOx60vfoQynizPABlPOsGHAio4Ux0zTHnc18uxT6
         4z1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690950509; x=1691555309;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QxcJxZeLWMHA1jTlTlNhXnSmHm/0Pvbh9+6mG9VUrpw=;
        b=W/kw19/joyH165nwOg1Ojjj3W8UIWgml6UiXhKopBqXMJbuKl3wK/AGYxXdjyUr2FI
         ZGRkVC3evgVMwzh0qQpXyOYvH7FQbuzBfwr7FX+8+aQSBVsxbAR9iAhRQRt2kB0TAyav
         zV1FyJK36Ot4HpC1pi8/r7iIgE6d0MS4fN3Inc+qo29FOl4cFjpyye5GDlZX/k63JrwY
         P6ZUAi3rQo8tXvoPT/BswKq0REfMbujlrOMrESTZrb4QH9VH7VU5imm4+1mAYMacHV9K
         cB/lrGVqUNibTM7ELH7LObl2eaGhqLgSGW7TYf7PZd83Iw0BxmCeniQe4T2mWZeEsyhE
         IiQA==
X-Gm-Message-State: ABy/qLZSA4AtuSkPwbNlG4dwbWm6uk3+w0G3cPRNUY7Fnn6YKLItr6Ed
        FMVY5U6wbUpMt8HYe4MmCDou5A==
X-Google-Smtp-Source: APBJJlFU3HpMAygm+uFVhLKIe+I3fjz1LQjDjFxXrrWsLD1kcsC/j30WgA65+jGEXkgp9uFHD2aAxQ==
X-Received: by 2002:a7b:cb8e:0:b0:3fe:1cac:37d7 with SMTP id m14-20020a7bcb8e000000b003fe1cac37d7mr3950467wmi.10.1690950509072;
        Tue, 01 Aug 2023 21:28:29 -0700 (PDT)
Received: from [10.0.2.15] ([82.78.167.79])
        by smtp.gmail.com with ESMTPSA id w11-20020a05600c014b00b003fc16ee2864sm527260wmm.48.2023.08.01.21.28.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Aug 2023 21:28:28 -0700 (PDT)
Message-ID: <f5954748-c132-c7aa-aa7d-6aa90f5fa141@tuxon.dev>
Date:   Wed, 2 Aug 2023 07:28:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 46/50] ARM: at91: Kconfig: add config flag for SAM9X7
 SoC
Content-Language: en-US
To:     Varshini Rajendran <varshini.rajendran@microchip.com>,
        linux@armlinux.org.uk, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230728103042.267646-1-varshini.rajendran@microchip.com>
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20230728103042.267646-1-varshini.rajendran@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28.07.2023 13:30, Varshini Rajendran wrote:
> Add config flag for sam9x7 SoC.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

> ---
>  arch/arm/mach-at91/Kconfig | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
> index a8c022b4c053..49d38a3a47de 100644
> --- a/arch/arm/mach-at91/Kconfig
> +++ b/arch/arm/mach-at91/Kconfig
> @@ -141,11 +141,28 @@ config SOC_SAM9X60
>  	help
>  	  Select this if you are using Microchip's SAM9X60 SoC
>  
> +config SOC_SAM9X7
> +	bool "SAM9X7"
> +	depends on ARCH_MULTI_V5
> +	select ATMEL_AIC5_IRQ
> +	select ATMEL_PM if PM
> +	select ATMEL_SDRAMC
> +	select CPU_ARM926T
> +	select HAVE_AT91_USB_CLK
> +	select HAVE_AT91_GENERATED_CLK
> +	select HAVE_AT91_SAM9X60_PLL
> +	select MEMORY
> +	select PINCTRL_AT91
> +	select SOC_SAM_V4_V5
> +	select SRAM if PM
> +	help
> +	  Select this if you are using Microchip's SAM9X7 SoC
> +
>  comment "Clocksource driver selection"
>  
>  config ATMEL_CLOCKSOURCE_PIT
>  	bool "Periodic Interval Timer (PIT) support"
> -	depends on SOC_AT91SAM9 || SOC_SAM9X60 || SOC_SAMA5
> +	depends on SOC_AT91SAM9 || SOC_SAM9X60 || SOC_SAM9X7 || SOC_SAMA5
>  	default SOC_AT91SAM9 || SOC_SAMA5
>  	select ATMEL_PIT
>  	help
> @@ -155,7 +172,7 @@ config ATMEL_CLOCKSOURCE_PIT
>  
>  config ATMEL_CLOCKSOURCE_TCB
>  	bool "Timer Counter Blocks (TCB) support"
> -	default SOC_AT91RM9200 || SOC_AT91SAM9 || SOC_SAM9X60 || SOC_SAMA5
> +	default SOC_AT91RM9200 || SOC_AT91SAM9 || SOC_SAM9X60 || SOC_SAM9X7 || SOC_SAMA5
>  	select ATMEL_TCB_CLKSRC
>  	help
>  	  Select this to get a high precision clocksource based on a
> @@ -166,7 +183,7 @@ config ATMEL_CLOCKSOURCE_TCB
>  
>  config MICROCHIP_CLOCKSOURCE_PIT64B
>  	bool "64-bit Periodic Interval Timer (PIT64B) support"
> -	default SOC_SAM9X60 || SOC_SAMA7
> +	default SOC_SAM9X60 || SOC_SAM9X7 || SOC_SAMA7
>  	select MICROCHIP_PIT64B
>  	help
>  	  Select this to get a high resolution clockevent (SAM9X60) or
