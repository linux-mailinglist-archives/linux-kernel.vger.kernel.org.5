Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777A2768AE3
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 06:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjGaE7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 00:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjGaE7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 00:59:34 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57066199
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 21:59:32 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9923833737eso594946566b.3
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 21:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1690779571; x=1691384371;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qrkIJKgEcmeXoLAMKXgkeWr+wYG1LbeUQ4DUDd8TYUQ=;
        b=H92v2l8E1+qkgukj/ixKmKteN7oXuA7+mZgNN2l5FDV8Js/JFNl6fMIzlXzkDhngrs
         l5Njlm5XevTNBR5R1+8YTV8fr64E3+QHyDLCIJ5XWGKCkk8rLWFeod2LFukGz2V6KgAn
         orW3hXo7HBl/TJzR52YbVUlEMmGbOz2cTOzMfJRTJRgMCNrmphNc//3Gb6MOyOi5wh3V
         LStUiCASK5LhYzfLBWETFgCtiuBDDUk08Xda/Slx0gTveWrkT8OVlgYFbdAyhLTMwGYW
         EiC+0vaB7Tcwmb8mZKfr8DwuNK7nRPxD7q0rrp6oKsjjtSBK1yKxbIRsHoJzbCkCHSCH
         JUew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690779571; x=1691384371;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qrkIJKgEcmeXoLAMKXgkeWr+wYG1LbeUQ4DUDd8TYUQ=;
        b=QtKhl8fdkN3Kt45+BAeIpuJpZbHviIl01tvwWTEeaAnuGg442AeLPYIZXPNwNmrvgi
         bHZuU0U7/+TQ6ufTVTYpPDjTgT/i8b6DR1sG2IgGCrff1fyfRLx8riTEDo8LCoo/9gg+
         B2m8pl8qm+98/kI5f4WDUmJbJj1zUNQDeF334DTOD+XhOXgcVWuDbKL0Yt6S4hG6W5yi
         T7haqDI0bgzL202SgnChMpNXzumYs3tGl2v9Y/6/D7WgjrybxKmQFfOIVZnbsliFu7K7
         WONOFTI6RMfNyz/dCoGAp9GVlYNw5S47on0lqDJxD3z6gGPrHvdn7L/jSATAHgwX881Z
         u2cA==
X-Gm-Message-State: ABy/qLYCaUvXAp/uR47lzZwTTcmi3DE53QHLlzo9M26Wzk94ngN/J/mZ
        r8/b+MwIuOQlEvEd8Bu9NVIvbzFGqz+lc0A6o5q1uLNR
X-Google-Smtp-Source: APBJJlGhMvZTNm0GlL8lkhSvFfHj6APHkNyBEpWtPj/xowbLABPG7/cpya4zTqBWZlsgrLTkaUYZXg==
X-Received: by 2002:a17:906:54:b0:99b:d243:157c with SMTP id 20-20020a170906005400b0099bd243157cmr6320493ejg.31.1690779570675;
        Sun, 30 Jul 2023 21:59:30 -0700 (PDT)
Received: from [10.0.2.15] ([82.78.167.79])
        by smtp.gmail.com with ESMTPSA id u17-20020a1709060b1100b00992bea2e9d2sm5644603ejg.62.2023.07.30.21.59.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Jul 2023 21:59:30 -0700 (PDT)
Message-ID: <d41b6bfe-f968-764c-3e3c-a4550c3eee17@tuxon.dev>
Date:   Mon, 31 Jul 2023 07:59:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] MAINTAINERS: update Claudiu Beznea's email address
To:     Conor Dooley <conor@kernel.org>
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com
References: <20230714183852.8370-1-claudiu.beznea@tuxon.dev>
 <20230728-hypertext-nullify-50c9f318db85@spud>
Content-Language: en-US
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20230728-hypertext-nullify-50c9f318db85@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28.07.2023 18:36, Conor Dooley wrote:
> Claudiu,
> 
> On Fri, Jul 14, 2023 at 09:38:52PM +0300, Claudiu Beznea wrote:
>> Update MAINTAINERS entries with a valid email address as the Microchip
>> one is no longer valid.
> 
> I'm not sure how you want this patch to get to the soc tree (I figure it
> should grow a cc to the soc maintainer alias & be resent) but in the
> meantime I applied this directly to at91-next so that at least patches
> generated against linux-next will arrive in your inbox.

Thanks, Conor!

> 
> Thanks,
> Conor.
> 
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
>> ---
>>  MAINTAINERS | 22 +++++++++++-----------
>>  1 file changed, 11 insertions(+), 11 deletions(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 3be1bdfe8ecc..0be71ca1cbb2 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -2337,7 +2337,7 @@ F:	drivers/phy/mediatek/
>>  ARM/MICROCHIP (ARM64) SoC support
>>  M:	Conor Dooley <conor@kernel.org>
>>  M:	Nicolas Ferre <nicolas.ferre@microchip.com>
>> -M:	Claudiu Beznea <claudiu.beznea@microchip.com>
>> +M:	Claudiu Beznea <claudiu.beznea@tuxon.dev>
>>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>>  S:	Supported
>>  T:	git https://git.kernel.org/pub/scm/linux/kernel/git/at91/linux.git
>> @@ -2346,7 +2346,7 @@ F:	arch/arm64/boot/dts/microchip/
>>  ARM/Microchip (AT91) SoC support
>>  M:	Nicolas Ferre <nicolas.ferre@microchip.com>
>>  M:	Alexandre Belloni <alexandre.belloni@bootlin.com>
>> -M:	Claudiu Beznea <claudiu.beznea@microchip.com>
>> +M:	Claudiu Beznea <claudiu.beznea@tuxon.dev>
>>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>>  S:	Supported
>>  W:	http://www.linux4sam.org
>> @@ -3248,7 +3248,7 @@ F:	include/uapi/linux/atm*
>>  
>>  ATMEL MACB ETHERNET DRIVER
>>  M:	Nicolas Ferre <nicolas.ferre@microchip.com>
>> -M:	Claudiu Beznea <claudiu.beznea@microchip.com>
>> +M:	Claudiu Beznea <claudiu.beznea@tuxon.dev>
>>  S:	Supported
>>  F:	drivers/net/ethernet/cadence/
>>  
>> @@ -13778,7 +13778,7 @@ F:	Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
>>  F:	drivers/spi/spi-at91-usart.c
>>  
>>  MICROCHIP AUDIO ASOC DRIVERS
>> -M:	Claudiu Beznea <claudiu.beznea@microchip.com>
>> +M:	Claudiu Beznea <claudiu.beznea@tuxon.dev>
>>  L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
>>  S:	Supported
>>  F:	Documentation/devicetree/bindings/sound/atmel*
>> @@ -13801,7 +13801,7 @@ S:	Maintained
>>  F:	drivers/crypto/atmel-ecc.*
>>  
>>  MICROCHIP EIC DRIVER
>> -M:	Claudiu Beznea <claudiu.beznea@microchip.com>
>> +M:	Claudiu Beznea <claudiu.beznea@tuxon.dev>
>>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>>  S:	Supported
>>  F:	Documentation/devicetree/bindings/interrupt-controller/microchip,sama7g5-eic.yaml
>> @@ -13874,7 +13874,7 @@ F:	drivers/video/fbdev/atmel_lcdfb.c
>>  F:	include/video/atmel_lcdc.h
>>  
>>  MICROCHIP MCP16502 PMIC DRIVER
>> -M:	Claudiu Beznea <claudiu.beznea@microchip.com>
>> +M:	Claudiu Beznea <claudiu.beznea@tuxon.dev>
>>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>>  S:	Supported
>>  F:	Documentation/devicetree/bindings/regulator/mcp16502-regulator.txt
>> @@ -13901,7 +13901,7 @@ F:	Documentation/devicetree/bindings/mtd/atmel-nand.txt
>>  F:	drivers/mtd/nand/raw/atmel/*
>>  
>>  MICROCHIP OTPC DRIVER
>> -M:	Claudiu Beznea <claudiu.beznea@microchip.com>
>> +M:	Claudiu Beznea <claudiu.beznea@tuxon.dev>
>>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>>  S:	Supported
>>  F:	Documentation/devicetree/bindings/nvmem/microchip,sama7g5-otpc.yaml
>> @@ -13940,7 +13940,7 @@ F:	Documentation/devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml
>>  F:	drivers/fpga/microchip-spi.c
>>  
>>  MICROCHIP PWM DRIVER
>> -M:	Claudiu Beznea <claudiu.beznea@microchip.com>
>> +M:	Claudiu Beznea <claudiu.beznea@tuxon.dev>
>>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>>  L:	linux-pwm@vger.kernel.org
>>  S:	Supported
>> @@ -13956,7 +13956,7 @@ F:	drivers/iio/adc/at91-sama5d2_adc.c
>>  F:	include/dt-bindings/iio/adc/at91-sama5d2_adc.h
>>  
>>  MICROCHIP SAMA5D2-COMPATIBLE SHUTDOWN CONTROLLER
>> -M:	Claudiu Beznea <claudiu.beznea@microchip.com>
>> +M:	Claudiu Beznea <claudiu.beznea@tuxon.dev>
>>  S:	Supported
>>  F:	Documentation/devicetree/bindings/power/reset/atmel,sama5d2-shdwc.yaml
>>  F:	drivers/power/reset/at91-sama5d2_shdwc.c
>> @@ -13973,7 +13973,7 @@ S:	Supported
>>  F:	drivers/spi/spi-atmel.*
>>  
>>  MICROCHIP SSC DRIVER
>> -M:	Claudiu Beznea <claudiu.beznea@microchip.com>
>> +M:	Claudiu Beznea <claudiu.beznea@tuxon.dev>
>>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>>  S:	Supported
>>  F:	Documentation/devicetree/bindings/misc/atmel-ssc.txt
>> @@ -14002,7 +14002,7 @@ F:	drivers/usb/gadget/udc/atmel_usba_udc.*
>>  
>>  MICROCHIP WILC1000 WIFI DRIVER
>>  M:	Ajay Singh <ajay.kathat@microchip.com>
>> -M:	Claudiu Beznea <claudiu.beznea@microchip.com>
>> +M:	Claudiu Beznea <claudiu.beznea@tuxon.dev>
>>  L:	linux-wireless@vger.kernel.org
>>  S:	Supported
>>  F:	drivers/net/wireless/microchip/wilc1000/
>> -- 
>> 2.39.2
>>
