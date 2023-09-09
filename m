Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19ED7799769
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 12:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344551AbjIIKdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 06:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjIIKdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 06:33:15 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729A89D;
        Sat,  9 Sep 2023 03:33:09 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-502984f5018so3369673e87.3;
        Sat, 09 Sep 2023 03:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694255587; x=1694860387; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2jLlXXOyhc9SXE5vU1HVy8u9vI+LbSelX0lbP92wNOk=;
        b=MBmEH6Cx1o6G207YBEJK1+eC+WHv5OhREMRnNHy9N7M+AnFD3jengYGXFpt+5lmAX8
         ihOdPJv7aR6mDgs2koJVntOIuU2L/BuE2fQpei6yEAmo5cgBAQNxmV4un2IguMOlaQTj
         wwZ3DjDGEn4GndyS3QCpH6SQMdBEK5We2zPR1VtVYwkEV9sNdFe8dM6AsyJidh1Cs6+j
         6zXOlT8XCPSiDZ67D+DJFwbCtBTLMW+EmUvUZPDsh6LNOp4OZTCU79biZTz8oMirivD0
         uOCEGMS9e0iN1342xsjkAas9GBDzsC1cZkd0RUqxsfH5bZ823/YCE2gNOcQWrLuFAjYT
         u8Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694255587; x=1694860387;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2jLlXXOyhc9SXE5vU1HVy8u9vI+LbSelX0lbP92wNOk=;
        b=i202Qgwu2z6SOj2rq045N5wSUR8lLLqUtAs9xQgSCrhylJtFJEew+khTSVX+D8Lz/N
         a4CU/KHPQGCXK8oNVOf2d5GHI50wk4UJkqveeJwZP320jkXznBHQFLKSubmw92O9RIar
         rm6PVmb98WCbCuG/CDWmH7TACwlhmjKgj/HHgD99TF02r6OQHI8qjv+FPa9ELvJUsRX7
         Mkl0RstFInz5poJTK+cB98bKa3yoZqRM2xQ69kvZXsDPpht5uMJZZeNj6T0yxhJqSUK8
         P40gTG2e2wqK+x2vLimNtMg/gP08jCx3tKiPHitwKmKxIByaikv5W05a/e9Y+Xne/nYm
         w+ig==
X-Gm-Message-State: AOJu0YyJmCtbX2qiJSJIrOhH1Jc9Sf8/OZywlhX8rAYYbiC1OWRuCoUP
        EdQKpDuczoq4uCC00qumU5Y=
X-Google-Smtp-Source: AGHT+IFeenYRO+blp1la6LbDqavFiT8oEl5pnk7kYsQpLFoFHc8jkyjsslaJXCsLpDzI+fjowf+Bqw==
X-Received: by 2002:a05:6512:10d1:b0:500:86cf:1249 with SMTP id k17-20020a05651210d100b0050086cf1249mr4427668lfg.61.1694255587393;
        Sat, 09 Sep 2023 03:33:07 -0700 (PDT)
Received: from [192.168.89.248] ([46.251.193.106])
        by smtp.gmail.com with ESMTPSA id r22-20020ac252b6000000b004fe3c53bb69sm574767lfm.307.2023.09.09.03.33.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Sep 2023 03:33:07 -0700 (PDT)
Message-ID: <98754ef3-3411-45a7-9e38-56832ce413f7@gmail.com>
Date:   Sat, 9 Sep 2023 13:33:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] pinctrl: sunxi: h616: add extra gpio banks
Content-Language: en-US
To:     =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Andre Przywara <andre.przywara@arm.com>
Cc:     linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230909094529.6083-1-iuncuim@gmail.com>
 <4832858.GXAFRqVoOG@jernej-laptop>
From:   Mikhail Kalashnikov <iuncuim@gmail.com>
In-Reply-To: <4832858.GXAFRqVoOG@jernej-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for your comment.

I added a changelog in response to the first message/

On 09.09.2023 13:14, Jernej Škrabec wrote:
> Dne sobota, 09. september 2023 ob 11:45:29 CEST je Mikhail Kalashnikov
> napisal(a):
>> From: iuncuim <iuncuim@gmail.com>
>>
>> Some SoCs from the H616 family (such as the T507) have the same die but
>> more output pins that are used for additional peripherals. The T507 SoC
>> don't have a built-in multiphy like the AC200 or AC300 connected ti the
>> bank A. With the T507 these pins can be freely used for any other
>> application. This patch adds the missing muxes on banks A, D and E.
>>
>> Signed-off-by: Mikhail Kalashnikov <iuncuim@gmail.com>
>> ---
> You missed changelog here. What are changes in regards to v1?
>
> Best regards,
> Jernej
>
>>   drivers/pinctrl/sunxi/pinctrl-sun50i-h616.c | 380 +++++++++++++++++++-
>>   1 file changed, 366 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/pinctrl/sunxi/pinctrl-sun50i-h616.c
>> b/drivers/pinctrl/sunxi/pinctrl-sun50i-h616.c index d6ca720ee..10d4e1ef1
>> 100644
>> --- a/drivers/pinctrl/sunxi/pinctrl-sun50i-h616.c
>> +++ b/drivers/pinctrl/sunxi/pinctrl-sun50i-h616.c
>> @@ -16,33 +16,81 @@
>>   #include "pinctrl-sunxi.h"
>>
>>   static const struct sunxi_desc_pin h616_pins[] = {
>> -	/* Internal connection to the AC200 part */
>> +	/* Internally connected to the AC200 part in the H616 SoC */
>>   	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 0),
>> -		  SUNXI_FUNCTION(0x2, "emac1")),	/* ERXD1 */
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "emac1"),		/* ERXD1
> */
>> +		  SUNXI_FUNCTION(0x4, "i2c0"),		/* SCK */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 0)),	/*
> PA_EINT0 */
>>   	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 1),
>> -		  SUNXI_FUNCTION(0x2, "emac1")),	/* ERXD0 */
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "emac1"),		/* ERXD0
> */
>> +		  SUNXI_FUNCTION(0x4, "i2c0"),		/* SDA */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 1)),	/*
> PA_EINT1 */
>>   	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 2),
>> -		  SUNXI_FUNCTION(0x2, "emac1")),	/* ECRS_DV */
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "emac1"),		/* ECRS_DV
> */
>> +		  SUNXI_FUNCTION(0x4, "i2c1"),		/* SCK */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 2)),	/*
> PA_EINT2 */
>>   	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 3),
>> -		  SUNXI_FUNCTION(0x2, "emac1")),	/* ERXERR */
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "emac1"),		/* ERXERR
> */
>> +		  SUNXI_FUNCTION(0x4, "i2c1"),		/* SDA */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 3)),	/*
> PA_EINT3 */
>>   	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 4),
>> -		  SUNXI_FUNCTION(0x2, "emac1")),	/* ETXD1 */
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "emac1"),		/* ETXD1
> */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 4)),	/*
> PA_EINT4 */
>>   	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 5),
>> -		  SUNXI_FUNCTION(0x2, "emac1")),	/* ETXD0 */
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "emac1"),		/* ETXD0
> */
>> +		  SUNXI_FUNCTION(0x3, "h_i2s0"),	/* DOUT0 */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 5)),	/*
> PA_EINT5 */
>>   	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 6),
>> -		  SUNXI_FUNCTION(0x2, "emac1")),	/* ETXCK */
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "emac1"),		/* ETXCK
> */
>> +		  SUNXI_FUNCTION(0x3, "h_i2s0"),	/* MCLK */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 6)),	/*
> PA_EINT6 */
>>   	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 7),
>> -		  SUNXI_FUNCTION(0x2, "emac1")),	/* ETXEN */
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "emac1"),		/* ETXEN
> */
>> +		  SUNXI_FUNCTION(0x3, "h_i2s0"),	/* BCLK */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 7)),	/*
> PA_EINT7 */
>>   	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 8),
>> -		  SUNXI_FUNCTION(0x2, "emac1")),	/* EMDC */
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "emac1"),		/* EMDC */
>> +		  SUNXI_FUNCTION(0x3, "h_i2s0"),	/* LRCK */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 8)),	/*
> PA_EINT8 */
>>   	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 9),
>> -		  SUNXI_FUNCTION(0x2, "emac1")),	/* EMDIO */
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "emac1"),		/* EMDIO
> */
>> +		  SUNXI_FUNCTION(0x3, "h_i2s0"),	/* DIN0 */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 9)),	/*
> PA_EINT9 */
>>   	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 10),
>> -		  SUNXI_FUNCTION(0x2, "i2c3")),		/* SCK
> */
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "i2c3"),		/* SCK */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 10)),	/*
> PA_EINT10 */
>>   	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 11),
>> -		  SUNXI_FUNCTION(0x2, "i2c3")),		/* SDA
> */
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "i2c3"),		/* SDA */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 11)),	/*
> PA_EINT11 */
>>   	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 12),
>> -		  SUNXI_FUNCTION(0x2, "pwm5")),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "pwm5"),
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 12)),	/*
> PA_EINT12 */
>>   	/* Hole */
>>   	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 0),
>>   		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> @@ -149,6 +197,310 @@ static const struct sunxi_desc_pin h616_pins[] = {
>>   		  SUNXI_FUNCTION(0x4, "spi0"),		/* HOLD
> */
>>   		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 16)),	/*
> PC_EINT16 */
>>   	/* Hole */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 0),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D0 */
>> +		  SUNXI_FUNCTION(0x3, "lvds0"),		/* VP0 */
>> +		  SUNXI_FUNCTION(0x4, "ts0"),		/* CLK */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 0)),	/*
> PD_EINT0 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 1),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D1 */
>> +		  SUNXI_FUNCTION(0x3, "lvds0"),		/* VN0 */
>> +		  SUNXI_FUNCTION(0x4, "ts0"),		/* ERR */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 1)),	/*
> PD_EINT1 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 2),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D2 */
>> +		  SUNXI_FUNCTION(0x3, "lvds0"),		/* VP1 */
>> +		  SUNXI_FUNCTION(0x4, "ts0"),		/* SYNC
> */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 2)),	/*
> PD_EINT2 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 3),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D3 */
>> +		  SUNXI_FUNCTION(0x3, "lvds0"),		/* VN1 */
>> +		  SUNXI_FUNCTION(0x4, "ts0"),		/* DVLD
> */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 3)),	/*
> PD_EINT3 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 4),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D4 */
>> +		  SUNXI_FUNCTION(0x3, "lvds0"),		/* VP2 */
>> +		  SUNXI_FUNCTION(0x4, "ts0"),		/* D0 */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 4)),	/*
> PD_EINT4 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 5),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D5 */
>> +		  SUNXI_FUNCTION(0x3, "lvds0"),		/* VN2 */
>> +		  SUNXI_FUNCTION(0x4, "ts0"),		/* D1 */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 5)),	/*
> PD_EINT5 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 6),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D6 */
>> +		  SUNXI_FUNCTION(0x3, "lvds0"),		/* VPC */
>> +		  SUNXI_FUNCTION(0x4, "ts0"),		/* D2 */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 6)),	/*
> PD_EINT6 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 7),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D7 */
>> +		  SUNXI_FUNCTION(0x3, "lvds0"),		/* VNC */
>> +		  SUNXI_FUNCTION(0x4, "ts0"),		/* D3 */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 7)),	/*
> PD_EINT7 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 8),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D8 */
>> +		  SUNXI_FUNCTION(0x3, "lvds0"),		/* VP3 */
>> +		  SUNXI_FUNCTION(0x4, "ts0"),		/* D4 */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 8)),	/*
> PD_EINT8 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 9),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D9 */
>> +		  SUNXI_FUNCTION(0x3, "lvds0"),		/* VN3 */
>> +		  SUNXI_FUNCTION(0x4, "ts0"), 		/* D5 */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 9)),	/*
> PD_EINT9 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 10),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D10 */
>> +		  SUNXI_FUNCTION(0x3, "lvds1"),		/* VP0 */
>> +		  SUNXI_FUNCTION(0x4, "ts0"), 		/* D6 */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 10)),	/*
> PD_EINT10 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 11),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D11 */
>> +		  SUNXI_FUNCTION(0x3, "lvds1"),		/* VN0 */
>> +		  SUNXI_FUNCTION(0x4, "ts0"), 		/* D7 */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 11)),	/*
> PD_EINT11 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 12),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D12 */
>> +		  SUNXI_FUNCTION(0x3, "lvds1"),		/* VP1 */
>> +		  SUNXI_FUNCTION(0x4, "sim"), 		/* VPPEN
> */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 12)),	/*
> PD_EINT12 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 13),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D13 */
>> +		  SUNXI_FUNCTION(0x3, "lvds1"),		/* VN1 */
>> +		  SUNXI_FUNCTION(0x4, "sim"),		/* VPPPP
> */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 13)),	/*
> PD_EINT13 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 14),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D14 */
>> +		  SUNXI_FUNCTION(0x3, "lvds1"),		/* VP2 */
>> +		  SUNXI_FUNCTION(0x4, "sim"),		/* PWREN
> */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 14)),	/*
> PD_EINT14 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 15),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D15 */
>> +		  SUNXI_FUNCTION(0x3, "lvds1"),		/* VN2 */
>> +		  SUNXI_FUNCTION(0x4, "sim"),		/* CLK */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 15)),	/*
> PD_EINT15 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 16),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D16 */
>> +		  SUNXI_FUNCTION(0x3, "lvds1"),		/* VPC */
>> +		  SUNXI_FUNCTION(0x4, "sim"),		/* DATA
> */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 16)),	/*
> PD_EINT16 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 17),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D17 */
>> +		  SUNXI_FUNCTION(0x3, "lvds1"),		/* VNC */
>> +		  SUNXI_FUNCTION(0x4, "sim"),		/* RST */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 17)),	/*
> PD_EINT17 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 18),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D18 */
>> +		  SUNXI_FUNCTION(0x3, "lvds1"),		/* VP3 */
>> +		  SUNXI_FUNCTION(0x4, "sim"),		/* DET */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 18)),	/*
> PD_EINT18 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 19),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D19 */
>> +		  SUNXI_FUNCTION(0x3, "lvds1"),		/* VN3 */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 19)),	/*
> PD_EINT19 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 20),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D20 */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 20)),	/*
> PD_EINT20 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 21),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D21 */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 21)),	/*
> PD_EINT21 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 22),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D22 */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 22)),	/*
> PD_EINT22 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 23),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D23 */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 23)),	/*
> PD_EINT23 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 24),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* CLK */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 24)),	/*
> PD_EINT24 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 25),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* DE */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 25)),	/*
> PD_EINT25 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 26),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* HSYNC
> */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 26)),	/*
> PD_EINT26 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 27),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* VSYNC
> */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 27)),	/*
> PD_EINT27 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 28),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "pwm0"),
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 28)),	/*
> PD_EINT28 */
>> +	/* Hole */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 0),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "csi"),		/*  PCLK
> */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 0)),	/*
> PE_EINT0 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 1),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "csi"),		/*  MCLK
> */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 1)),	/*
> PE_EINT1 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 2),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "csi"),		/*
> HSYNC  */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 2)),	/*
> PE_EINT2 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 3),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "csi"),		/*
> VSYNC  */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 3)),	/*
> PE_EINT3 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 4),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "csi"),		/*  D0
> */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 4)),	/*
> PE_EINT4 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 5),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "csi"),		/*  D1
> */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 5)),	/*
> PE_EINT5 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 6),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "csi"),		/*  D2
> */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 6)),	/*
> PE_EINT6 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 7),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "csi"),		/*  D3
> */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 7)),	/*
> PE_EINT7 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 8),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "csi"),		/*  D4
> */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 8)),	/*
> PE_EINT8 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 9),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "csi"),		/*  D5
> */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 9)),	/*
> PE_EINT9 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 10),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "csi"),		/*  D6
> */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 10)),	/*
> PE_EINT10 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 11),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "csi"),		/*  D7
> */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 11)),	/*
> PE_EINT11 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 12),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "csi"),		/*  D8
> */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 12)),	/*
> PE_EINT12 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 13),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "csi"),		/*  D9
> */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 13)),	/*
> PE_EINT13 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 14),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "csi"),		/*  D10
> */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 14)),	/*
> PE_EINT14 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 15),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "csi"),		/*  D11
> */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 15)),	/*
> PE_EINT15 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 16),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "csi"),		/*  D12
> */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 16)),	/*
> PE_EINT16 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 17),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "csi"),		/*  D13
> */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 17)),	/*
> PE_EINT17 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 18),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "csi"),		/*  D14
> */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 18)),	/*
> PE_EINT18 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 19),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "csi"),		/*  D15
> */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 19)),	/*
> PE_EINT19 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 20),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "csi"),		/*  SCK
> */
>> +		  SUNXI_FUNCTION(0x5, "i2c2"),		/*  SCK
> */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 20)),	/*
> PE_EINT20 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 21),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "csi"),		/*  SDA
> */
>> +		  SUNXI_FUNCTION(0x5, "i2c2"),		/*  SDA
> */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 21)),	/*
> PE_EINT21 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 22),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "csi"),		/*
> FSIN0 */
>> +		  SUNXI_FUNCTION(0x4, "tcon0"),		/*  TRIG0
> */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 22)),	/*
> PE_EINT22 */
>> +	/* Hole */
>>   	SUNXI_PIN(SUNXI_PINCTRL_PIN(F, 0),
>>   		  SUNXI_FUNCTION(0x0, "gpio_in"),
>>   		  SUNXI_FUNCTION(0x1, "gpio_out"),
>
>
>
