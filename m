Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 062CA7A891B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 17:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236800AbjITP7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 11:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236860AbjITP7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 11:59:44 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15AED6;
        Wed, 20 Sep 2023 08:59:33 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-502a4f33440so38541e87.1;
        Wed, 20 Sep 2023 08:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695225572; x=1695830372; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SrEwJJIRuSDwYs6rgAIDjXDEIrpiFTV5JGyIwxXdV5M=;
        b=R6pMi6a/9ZwgV6YNvtqExiopRcoIO7frUG+/P3gnlqKKSeWL1t5Jcp4opx6Glod+kh
         i4g3BIpMwSBs/quGmkZbbM8EtAlV2q4QLbPjwaI1eVNgVR1xw632Gz4w+RRehQfP7A7t
         ix4cchk2zORtqdExv9B94AS2jCsa7LYyfJuaUCadhE9jlgHtYh6CKnXxZQFd4yjEJc2I
         XohhIcs3/me34Zjo1+fNOBPbsY8pnIRJFLLmnYvNDbkXlrhhTl/u8Tldh8jDua1JIUeL
         JWdlKPgPjxyNuV72ziNFeEKCXaLRqnKIIRH234cvm1IJoxk8t38Y4JjyoJqtD+3Eff+b
         k8/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695225572; x=1695830372;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SrEwJJIRuSDwYs6rgAIDjXDEIrpiFTV5JGyIwxXdV5M=;
        b=uPjmwEcX4Dne45+xUgTKQNeY4qUzMf6OtwslVNgxi2dkc6Cy+lKME7cURyAGN9udaZ
         Wn/2CEsNeLyipo5CLoMn7D0bF98lAFiv6I1RgpLdsIQZp/frWIBAKi2XuZS71qmU94Ok
         kI+cdDgcYR/Z/iVHHVWAA70Fu0g1iWG9bEjmiEF/ZBhx0fFK6G/JDQNaf30reWUs3YP3
         hA+18Co7q3oRHUT7ImW0JONqZSor3pozxQrJZ6mnrj94d1zWUI8p/sw6gic8K0mIeH6P
         THTJOiSmZk0tnrJPbn9Z8HCKAeyXIOeJzomRw05U4Gj+6b+s70q5dusc0CWnX7BuaUwR
         xdjQ==
X-Gm-Message-State: AOJu0YyqNjgxh1jSqrMqn2rBk6eukkbNOHDj48ti8lmZpy6yTI6JjiwU
        6hEu2J59qQ9ILy/yyVgV9uA=
X-Google-Smtp-Source: AGHT+IEqriHEUwZkvtgRrDaK8dMC09gnBT1UWwuC9l/+0ZAQBxXqofrgQwH4UoXeu/bQ3RVSIZtAIA==
X-Received: by 2002:a19:7714:0:b0:500:c765:bbe with SMTP id s20-20020a197714000000b00500c7650bbemr2560561lfc.0.1695225571535;
        Wed, 20 Sep 2023 08:59:31 -0700 (PDT)
Received: from [192.168.89.225] ([46.251.213.86])
        by smtp.gmail.com with ESMTPSA id v17-20020a197411000000b005009dcb4503sm2730573lfe.249.2023.09.20.08.59.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 08:59:30 -0700 (PDT)
Message-ID: <3bab30f0-3f8b-4140-b80e-6e9a8c011272@gmail.com>
Date:   Wed, 20 Sep 2023 21:59:35 +0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] pinctrl: sunxi: h616: add extra gpio banks
Content-Language: en-US
To:     Andre Przywara <andre.przywara@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230916081615.4237-1-iuncuim@gmail.com>
 <20230920101134.181709e9@donnerap.manchester.arm.com>
From:   Mikhail Kalashnikov <iuncuim@gmail.com>
In-Reply-To: <20230920101134.181709e9@donnerap.manchester.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Ohh, just now I understand that the changelog should be in the cover letter.

If it's critical, I can fix it in the next series.

Thanks

On 20.09.2023 15:11, Andre Przywara wrote:
> On Sat, 16 Sep 2023 11:16:15 +0300
> Mikhail Kalashnikov <iuncuim@gmail.com> wrote:
>
> Hi,
>
>> From: iuncuim <iuncuim@gmail.com>
>>
>> Some SoCs from the H616 family (such as the T507) have the same die but
>> more output pins that are used for additional peripherals. The T507 SoC
>> don't have a built-in multiphy like the AC200 or AC300 connected to the
>> bank A. With the T507 these pins can be freely used for any other application.
>> This patch adds the missing muxes on banks A, D and E.
>>
>> Signed-off-by: Mikhail Kalashnikov <iuncuim@gmail.com>
>>
>> Changes from v2:
>>   * replaced gpio alt functions from "h_i2s0" to "i2s0"
>> https://lore.kernel.org/linux-sunxi/20230909094529.6083-1-iuncuim@gmail.com/
>>
>> Changes from v1:
>>   * replaced gpio alt functions from "csi_mclk1" and "ncsi_fsin0" to "csi"
>>   * fix file newline
>> https://lore.kernel.org/linux-sunxi/20230819092609.8136-1-iuncuim@gmail.com/
>>
>> Thanks to Samuel and Andre for the review.
> So any extra lines like the changelog belong below those three dashes
> here. I hope this can be fixed by the maintainers before committing?
>
> I compared every pin and mux against the manual, and they match up.
> Also I see all previous comments addressed, so the function names are now
> in line with what we use elsewhere.
>
> Reviewed-by: Andre Przywara <andre.przywara@arm.com>
>
> Cheers,
> Andre
>
>
>> ---
>>   drivers/pinctrl/sunxi/pinctrl-sun50i-h616.c | 380 +++++++++++++++++++-
>>   1 file changed, 366 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/pinctrl/sunxi/pinctrl-sun50i-h616.c b/drivers/pinctrl/sunxi/pinctrl-sun50i-h616.c
>> index d6ca720ee..d62f92716 100644
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
>> +		  SUNXI_FUNCTION(0x2, "emac1"),		/* ERXD1 */
>> +		  SUNXI_FUNCTION(0x4, "i2c0"),		/* SCK */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 0)),	/* PA_EINT0 */
>>   	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 1),
>> -		  SUNXI_FUNCTION(0x2, "emac1")),	/* ERXD0 */
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "emac1"),		/* ERXD0 */
>> +		  SUNXI_FUNCTION(0x4, "i2c0"),		/* SDA */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 1)),	/* PA_EINT1 */
>>   	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 2),
>> -		  SUNXI_FUNCTION(0x2, "emac1")),	/* ECRS_DV */
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "emac1"),		/* ECRS_DV */
>> +		  SUNXI_FUNCTION(0x4, "i2c1"),		/* SCK */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 2)),	/* PA_EINT2 */
>>   	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 3),
>> -		  SUNXI_FUNCTION(0x2, "emac1")),	/* ERXERR */
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "emac1"),		/* ERXERR */
>> +		  SUNXI_FUNCTION(0x4, "i2c1"),		/* SDA */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 3)),	/* PA_EINT3 */
>>   	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 4),
>> -		  SUNXI_FUNCTION(0x2, "emac1")),	/* ETXD1 */
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "emac1"),		/* ETXD1 */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 4)),	/* PA_EINT4 */
>>   	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 5),
>> -		  SUNXI_FUNCTION(0x2, "emac1")),	/* ETXD0 */
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "emac1"),		/* ETXD0 */
>> +		  SUNXI_FUNCTION(0x3, "i2s0"),		/* DOUT0 */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 5)),	/* PA_EINT5 */
>>   	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 6),
>> -		  SUNXI_FUNCTION(0x2, "emac1")),	/* ETXCK */
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "emac1"),		/* ETXCK */
>> +		  SUNXI_FUNCTION(0x3, "i2s0"),		/* MCLK */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 6)),	/* PA_EINT6 */
>>   	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 7),
>> -		  SUNXI_FUNCTION(0x2, "emac1")),	/* ETXEN */
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "emac1"),		/* ETXEN */
>> +		  SUNXI_FUNCTION(0x3, "i2s0"),		/* BCLK */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 7)),	/* PA_EINT7 */
>>   	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 8),
>> -		  SUNXI_FUNCTION(0x2, "emac1")),	/* EMDC */
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "emac1"),		/* EMDC */
>> +		  SUNXI_FUNCTION(0x3, "i2s0"),		/* LRCK */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 8)),	/* PA_EINT8 */
>>   	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 9),
>> -		  SUNXI_FUNCTION(0x2, "emac1")),	/* EMDIO */
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "emac1"),		/* EMDIO */
>> +		  SUNXI_FUNCTION(0x3, "i2s0"),		/* DIN0 */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 9)),	/* PA_EINT9 */
>>   	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 10),
>> -		  SUNXI_FUNCTION(0x2, "i2c3")),		/* SCK */
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "i2c3"),		/* SCK */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 10)),	/* PA_EINT10 */
>>   	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 11),
>> -		  SUNXI_FUNCTION(0x2, "i2c3")),		/* SDA */
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "i2c3"),		/* SDA */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 11)),	/* PA_EINT11 */
>>   	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 12),
>> -		  SUNXI_FUNCTION(0x2, "pwm5")),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "pwm5"),
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 12)),	/* PA_EINT12 */
>>   	/* Hole */
>>   	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 0),
>>   		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> @@ -149,6 +197,310 @@ static const struct sunxi_desc_pin h616_pins[] = {
>>   		  SUNXI_FUNCTION(0x4, "spi0"),		/* HOLD */
>>   		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 16)),	/* PC_EINT16 */
>>   	/* Hole */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 0),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D0 */
>> +		  SUNXI_FUNCTION(0x3, "lvds0"),		/* VP0 */
>> +		  SUNXI_FUNCTION(0x4, "ts0"),		/* CLK */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 0)),	/* PD_EINT0 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 1),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D1 */
>> +		  SUNXI_FUNCTION(0x3, "lvds0"),		/* VN0 */
>> +		  SUNXI_FUNCTION(0x4, "ts0"),		/* ERR */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 1)),	/* PD_EINT1 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 2),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D2 */
>> +		  SUNXI_FUNCTION(0x3, "lvds0"),		/* VP1 */
>> +		  SUNXI_FUNCTION(0x4, "ts0"),		/* SYNC */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 2)),	/* PD_EINT2 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 3),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D3 */
>> +		  SUNXI_FUNCTION(0x3, "lvds0"),		/* VN1 */
>> +		  SUNXI_FUNCTION(0x4, "ts0"),		/* DVLD */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 3)),	/* PD_EINT3 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 4),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D4 */
>> +		  SUNXI_FUNCTION(0x3, "lvds0"),		/* VP2 */
>> +		  SUNXI_FUNCTION(0x4, "ts0"),		/* D0 */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 4)),	/* PD_EINT4 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 5),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D5 */
>> +		  SUNXI_FUNCTION(0x3, "lvds0"),		/* VN2 */
>> +		  SUNXI_FUNCTION(0x4, "ts0"),		/* D1 */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 5)),	/* PD_EINT5 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 6),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D6 */
>> +		  SUNXI_FUNCTION(0x3, "lvds0"),		/* VPC */
>> +		  SUNXI_FUNCTION(0x4, "ts0"),		/* D2 */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 6)),	/* PD_EINT6 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 7),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D7 */
>> +		  SUNXI_FUNCTION(0x3, "lvds0"),		/* VNC */
>> +		  SUNXI_FUNCTION(0x4, "ts0"),		/* D3 */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 7)),	/* PD_EINT7 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 8),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D8 */
>> +		  SUNXI_FUNCTION(0x3, "lvds0"),		/* VP3 */
>> +		  SUNXI_FUNCTION(0x4, "ts0"),		/* D4 */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 8)),	/* PD_EINT8 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 9),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D9 */
>> +		  SUNXI_FUNCTION(0x3, "lvds0"),		/* VN3 */
>> +		  SUNXI_FUNCTION(0x4, "ts0"), 		/* D5 */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 9)),	/* PD_EINT9 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 10),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D10 */
>> +		  SUNXI_FUNCTION(0x3, "lvds1"),		/* VP0 */
>> +		  SUNXI_FUNCTION(0x4, "ts0"), 		/* D6 */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 10)),	/* PD_EINT10 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 11),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D11 */
>> +		  SUNXI_FUNCTION(0x3, "lvds1"),		/* VN0 */
>> +		  SUNXI_FUNCTION(0x4, "ts0"), 		/* D7 */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 11)),	/* PD_EINT11 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 12),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D12 */
>> +		  SUNXI_FUNCTION(0x3, "lvds1"),		/* VP1 */
>> +		  SUNXI_FUNCTION(0x4, "sim"), 		/* VPPEN */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 12)),	/* PD_EINT12 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 13),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D13 */
>> +		  SUNXI_FUNCTION(0x3, "lvds1"),		/* VN1 */
>> +		  SUNXI_FUNCTION(0x4, "sim"),		/* VPPPP */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 13)),	/* PD_EINT13 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 14),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D14 */
>> +		  SUNXI_FUNCTION(0x3, "lvds1"),		/* VP2 */
>> +		  SUNXI_FUNCTION(0x4, "sim"),		/* PWREN */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 14)),	/* PD_EINT14 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 15),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D15 */
>> +		  SUNXI_FUNCTION(0x3, "lvds1"),		/* VN2 */
>> +		  SUNXI_FUNCTION(0x4, "sim"),		/* CLK */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 15)),	/* PD_EINT15 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 16),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D16 */
>> +		  SUNXI_FUNCTION(0x3, "lvds1"),		/* VPC */
>> +		  SUNXI_FUNCTION(0x4, "sim"),		/* DATA */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 16)),	/* PD_EINT16 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 17),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D17 */
>> +		  SUNXI_FUNCTION(0x3, "lvds1"),		/* VNC */
>> +		  SUNXI_FUNCTION(0x4, "sim"),		/* RST */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 17)),	/* PD_EINT17 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 18),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D18 */
>> +		  SUNXI_FUNCTION(0x3, "lvds1"),		/* VP3 */
>> +		  SUNXI_FUNCTION(0x4, "sim"),		/* DET */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 18)),	/* PD_EINT18 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 19),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D19 */
>> +		  SUNXI_FUNCTION(0x3, "lvds1"),		/* VN3 */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 19)),	/* PD_EINT19 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 20),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D20 */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 20)),	/* PD_EINT20 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 21),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D21 */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 21)),	/* PD_EINT21 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 22),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D22 */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 22)),	/* PD_EINT22 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 23),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D23 */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 23)),	/* PD_EINT23 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 24),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* CLK */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 24)),	/* PD_EINT24 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 25),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* DE */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 25)),	/* PD_EINT25 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 26),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* HSYNC */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 26)),	/* PD_EINT26 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 27),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* VSYNC */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 27)),	/* PD_EINT27 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 28),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "pwm0"),
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 28)),	/* PD_EINT28 */
>> +	/* Hole */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 0),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "csi"),		/*  PCLK  */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 0)),	/* PE_EINT0 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 1),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "csi"),		/*  MCLK  */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 1)),	/* PE_EINT1 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 2),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "csi"),		/*  HSYNC  */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 2)),	/* PE_EINT2 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 3),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "csi"),		/*  VSYNC  */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 3)),	/* PE_EINT3 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 4),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "csi"),		/*  D0  */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 4)),	/* PE_EINT4 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 5),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "csi"),		/*  D1  */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 5)),	/* PE_EINT5 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 6),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "csi"),		/*  D2  */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 6)),	/* PE_EINT6 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 7),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "csi"),		/*  D3  */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 7)),	/* PE_EINT7 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 8),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "csi"),		/*  D4  */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 8)),	/* PE_EINT8 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 9),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "csi"),		/*  D5  */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 9)),	/* PE_EINT9 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 10),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "csi"),		/*  D6  */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 10)),	/* PE_EINT10 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 11),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "csi"),		/*  D7  */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 11)),	/* PE_EINT11 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 12),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "csi"),		/*  D8  */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 12)),	/* PE_EINT12 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 13),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "csi"),		/*  D9  */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 13)),	/* PE_EINT13 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 14),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "csi"),		/*  D10  */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 14)),	/* PE_EINT14 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 15),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "csi"),		/*  D11  */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 15)),	/* PE_EINT15 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 16),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "csi"),		/*  D12  */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 16)),	/* PE_EINT16 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 17),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "csi"),		/*  D13  */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 17)),	/* PE_EINT17 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 18),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "csi"),		/*  D14  */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 18)),	/* PE_EINT18 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 19),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "csi"),		/*  D15  */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 19)),	/* PE_EINT19 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 20),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "csi"),		/*  SCK  */
>> +		  SUNXI_FUNCTION(0x5, "i2c2"),		/*  SCK  */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 20)),	/* PE_EINT20 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 21),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "csi"),		/*  SDA */
>> +		  SUNXI_FUNCTION(0x5, "i2c2"),		/*  SDA  */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 21)),	/* PE_EINT21 */
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 22),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		  SUNXI_FUNCTION(0x2, "csi"),		/*  FSIN0 */
>> +		  SUNXI_FUNCTION(0x4, "tcon0"),		/*  TRIG0  */
>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 22)),	/* PE_EINT22 */
>> +	/* Hole */
>>   	SUNXI_PIN(SUNXI_PINCTRL_PIN(F, 0),
>>   		  SUNXI_FUNCTION(0x0, "gpio_in"),
>>   		  SUNXI_FUNCTION(0x1, "gpio_out"),
