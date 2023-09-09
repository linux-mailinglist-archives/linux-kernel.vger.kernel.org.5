Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC7E4799759
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 12:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244238AbjIIKbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 06:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjIIKb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 06:31:29 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70FB1E6B;
        Sat,  9 Sep 2023 03:31:24 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2ba1e9b1fa9so49151571fa.3;
        Sat, 09 Sep 2023 03:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694255483; x=1694860283; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z1QXWwhx8HHJNs3L3At3kyUw+Pfhtv8MWWwdYceOjmE=;
        b=pNw204aW3q99alz2kBlmld5wllyVe3pwFJzurYx0vIOtL+1O+/E6uuhiDjAUtHlBVj
         0gCGo6khhbZBKnORt8xM2z1xSTKdqaxYthJogOsvTMDkbvzwCNO15H2sLx64BM624Zsg
         eM22QgmfzhRXJeUBsDPnkvdHAnHX+PKhV0slWWuvdlU9gpXiSB0kIE/oDqwmR0Xc/g10
         wspTem+55FHp//hmVdOv18e9ALQgDwULrzknyH3W2gVcQBMqnNh0LTgtaz85NGK7C8Q7
         st/yMlJoznBlt6K6+O/Lq6JXVYKLkxViXZQFigeESxC4xLxXAmW3TJo+P9e13ZCa/+lp
         33rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694255483; x=1694860283;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z1QXWwhx8HHJNs3L3At3kyUw+Pfhtv8MWWwdYceOjmE=;
        b=kY0Pk/GoAT4Oe7pxVcQO9qY5QI1z++Tahwbuy9PEgxSbyz8z5YLxyYwockk1D8Sxgk
         TKDN1dpLjDKAxeVKT3E1dAlXH76+nwkVEgLka4/3O8faLBQAiiIdWGPxhZlSedoik4ww
         5BDwQCf3IFEUxu2n2/bV5uglx9xh5WFCAeNWtcYs8o/y44h7K8bYzfE04L3Pf4lO0qOy
         k7zvbhzDEp7hrdB15wbGmtk/wdgL5x29EA2587Fhc5T1wd43xbd2i9yrUuZR82mY6UNm
         pmZDZeZgYGszLQscpvGYuqH7ne03NBIwmAwj2DfpT0dtfavDA9rhTWPeOS9XDB0T/z60
         p89w==
X-Gm-Message-State: AOJu0Yx4MhuiopIh9neLwfmtDJv58+63+4Hpt8ZNiXSU7ScywIztElX5
        W31odGJuepHc9yBcRngCxdM=
X-Google-Smtp-Source: AGHT+IEVvRMUyELSH1480hd+d//wYt2262WZxbhYLQuHUVH/bt5FMGKoh5SYtnMhIoxV0+oQgCs/OA==
X-Received: by 2002:a2e:850b:0:b0:2bc:e827:a4ff with SMTP id j11-20020a2e850b000000b002bce827a4ffmr4032520lji.9.1694255482318;
        Sat, 09 Sep 2023 03:31:22 -0700 (PDT)
Received: from [192.168.89.248] ([46.251.193.106])
        by smtp.gmail.com with ESMTPSA id f7-20020a2e9187000000b002bcd94f9714sm607435ljg.126.2023.09.09.03.31.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Sep 2023 03:31:21 -0700 (PDT)
Message-ID: <620d45f6-5fc9-49d3-8bea-ce6f1cb7911b@gmail.com>
Date:   Sat, 9 Sep 2023 13:31:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] pinctrl: sunxi: h616: add extra gpio banks
Content-Language: en-US
From:   Mikhail Kalashnikov <iuncuim@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Andre Przywara <andre.przywara@arm.com>
Cc:     linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230909094529.6083-1-iuncuim@gmail.com>
In-Reply-To: <20230909094529.6083-1-iuncuim@gmail.com>
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

Sorry, missed this part.
Changes from v1:
  * replaced gpio alt functions from"csi_mclk1" and "ncsi_fsin0"  to "csi"
  * fix file newline
Thanks to Andre for the review.

On 09.09.2023 12:45, Mikhail Kalashnikov wrote:
> From: iuncuim <iuncuim@gmail.com>
>
> Some SoCs from the H616 family (such as the T507) have the same die but
> more output pins that are used for additional peripherals. The T507 SoC
> don't have a built-in multiphy like the AC200 or AC300 connected ti the
> bank A. With the T507 these pins can be freely used for any other application.
> This patch adds the missing muxes on banks A, D and E.
>
> Signed-off-by: Mikhail Kalashnikov <iuncuim@gmail.com>
> ---
>   drivers/pinctrl/sunxi/pinctrl-sun50i-h616.c | 380 +++++++++++++++++++-
>   1 file changed, 366 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/pinctrl/sunxi/pinctrl-sun50i-h616.c b/drivers/pinctrl/sunxi/pinctrl-sun50i-h616.c
> index d6ca720ee..10d4e1ef1 100644
> --- a/drivers/pinctrl/sunxi/pinctrl-sun50i-h616.c
> +++ b/drivers/pinctrl/sunxi/pinctrl-sun50i-h616.c
> @@ -16,33 +16,81 @@
>   #include "pinctrl-sunxi.h"
>   
>   static const struct sunxi_desc_pin h616_pins[] = {
> -	/* Internal connection to the AC200 part */
> +	/* Internally connected to the AC200 part in the H616 SoC */
>   	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 0),
> -		  SUNXI_FUNCTION(0x2, "emac1")),	/* ERXD1 */
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "emac1"),		/* ERXD1 */
> +		  SUNXI_FUNCTION(0x4, "i2c0"),		/* SCK */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 0)),	/* PA_EINT0 */
>   	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 1),
> -		  SUNXI_FUNCTION(0x2, "emac1")),	/* ERXD0 */
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "emac1"),		/* ERXD0 */
> +		  SUNXI_FUNCTION(0x4, "i2c0"),		/* SDA */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 1)),	/* PA_EINT1 */
>   	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 2),
> -		  SUNXI_FUNCTION(0x2, "emac1")),	/* ECRS_DV */
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "emac1"),		/* ECRS_DV */
> +		  SUNXI_FUNCTION(0x4, "i2c1"),		/* SCK */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 2)),	/* PA_EINT2 */
>   	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 3),
> -		  SUNXI_FUNCTION(0x2, "emac1")),	/* ERXERR */
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "emac1"),		/* ERXERR */
> +		  SUNXI_FUNCTION(0x4, "i2c1"),		/* SDA */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 3)),	/* PA_EINT3 */
>   	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 4),
> -		  SUNXI_FUNCTION(0x2, "emac1")),	/* ETXD1 */
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "emac1"),		/* ETXD1 */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 4)),	/* PA_EINT4 */
>   	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 5),
> -		  SUNXI_FUNCTION(0x2, "emac1")),	/* ETXD0 */
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "emac1"),		/* ETXD0 */
> +		  SUNXI_FUNCTION(0x3, "h_i2s0"),	/* DOUT0 */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 5)),	/* PA_EINT5 */
>   	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 6),
> -		  SUNXI_FUNCTION(0x2, "emac1")),	/* ETXCK */
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "emac1"),		/* ETXCK */
> +		  SUNXI_FUNCTION(0x3, "h_i2s0"),	/* MCLK */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 6)),	/* PA_EINT6 */
>   	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 7),
> -		  SUNXI_FUNCTION(0x2, "emac1")),	/* ETXEN */
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "emac1"),		/* ETXEN */
> +		  SUNXI_FUNCTION(0x3, "h_i2s0"),	/* BCLK */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 7)),	/* PA_EINT7 */
>   	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 8),
> -		  SUNXI_FUNCTION(0x2, "emac1")),	/* EMDC */
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "emac1"),		/* EMDC */
> +		  SUNXI_FUNCTION(0x3, "h_i2s0"),	/* LRCK */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 8)),	/* PA_EINT8 */
>   	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 9),
> -		  SUNXI_FUNCTION(0x2, "emac1")),	/* EMDIO */
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "emac1"),		/* EMDIO */
> +		  SUNXI_FUNCTION(0x3, "h_i2s0"),	/* DIN0 */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 9)),	/* PA_EINT9 */
>   	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 10),
> -		  SUNXI_FUNCTION(0x2, "i2c3")),		/* SCK */
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "i2c3"),		/* SCK */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 10)),	/* PA_EINT10 */
>   	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 11),
> -		  SUNXI_FUNCTION(0x2, "i2c3")),		/* SDA */
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "i2c3"),		/* SDA */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 11)),	/* PA_EINT11 */
>   	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 12),
> -		  SUNXI_FUNCTION(0x2, "pwm5")),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "pwm5"),
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 12)),	/* PA_EINT12 */
>   	/* Hole */
>   	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 0),
>   		  SUNXI_FUNCTION(0x0, "gpio_in"),
> @@ -149,6 +197,310 @@ static const struct sunxi_desc_pin h616_pins[] = {
>   		  SUNXI_FUNCTION(0x4, "spi0"),		/* HOLD */
>   		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 16)),	/* PC_EINT16 */
>   	/* Hole */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 0),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D0 */
> +		  SUNXI_FUNCTION(0x3, "lvds0"),		/* VP0 */
> +		  SUNXI_FUNCTION(0x4, "ts0"),		/* CLK */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 0)),	/* PD_EINT0 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 1),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D1 */
> +		  SUNXI_FUNCTION(0x3, "lvds0"),		/* VN0 */
> +		  SUNXI_FUNCTION(0x4, "ts0"),		/* ERR */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 1)),	/* PD_EINT1 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 2),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D2 */
> +		  SUNXI_FUNCTION(0x3, "lvds0"),		/* VP1 */
> +		  SUNXI_FUNCTION(0x4, "ts0"),		/* SYNC */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 2)),	/* PD_EINT2 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 3),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D3 */
> +		  SUNXI_FUNCTION(0x3, "lvds0"),		/* VN1 */
> +		  SUNXI_FUNCTION(0x4, "ts0"),		/* DVLD */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 3)),	/* PD_EINT3 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 4),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D4 */
> +		  SUNXI_FUNCTION(0x3, "lvds0"),		/* VP2 */
> +		  SUNXI_FUNCTION(0x4, "ts0"),		/* D0 */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 4)),	/* PD_EINT4 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 5),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D5 */
> +		  SUNXI_FUNCTION(0x3, "lvds0"),		/* VN2 */
> +		  SUNXI_FUNCTION(0x4, "ts0"),		/* D1 */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 5)),	/* PD_EINT5 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 6),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D6 */
> +		  SUNXI_FUNCTION(0x3, "lvds0"),		/* VPC */
> +		  SUNXI_FUNCTION(0x4, "ts0"),		/* D2 */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 6)),	/* PD_EINT6 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 7),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D7 */
> +		  SUNXI_FUNCTION(0x3, "lvds0"),		/* VNC */
> +		  SUNXI_FUNCTION(0x4, "ts0"),		/* D3 */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 7)),	/* PD_EINT7 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 8),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D8 */
> +		  SUNXI_FUNCTION(0x3, "lvds0"),		/* VP3 */
> +		  SUNXI_FUNCTION(0x4, "ts0"),		/* D4 */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 8)),	/* PD_EINT8 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 9),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D9 */
> +		  SUNXI_FUNCTION(0x3, "lvds0"),		/* VN3 */
> +		  SUNXI_FUNCTION(0x4, "ts0"), 		/* D5 */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 9)),	/* PD_EINT9 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 10),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D10 */
> +		  SUNXI_FUNCTION(0x3, "lvds1"),		/* VP0 */
> +		  SUNXI_FUNCTION(0x4, "ts0"), 		/* D6 */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 10)),	/* PD_EINT10 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 11),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D11 */
> +		  SUNXI_FUNCTION(0x3, "lvds1"),		/* VN0 */
> +		  SUNXI_FUNCTION(0x4, "ts0"), 		/* D7 */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 11)),	/* PD_EINT11 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 12),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D12 */
> +		  SUNXI_FUNCTION(0x3, "lvds1"),		/* VP1 */
> +		  SUNXI_FUNCTION(0x4, "sim"), 		/* VPPEN */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 12)),	/* PD_EINT12 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 13),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D13 */
> +		  SUNXI_FUNCTION(0x3, "lvds1"),		/* VN1 */
> +		  SUNXI_FUNCTION(0x4, "sim"),		/* VPPPP */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 13)),	/* PD_EINT13 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 14),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D14 */
> +		  SUNXI_FUNCTION(0x3, "lvds1"),		/* VP2 */
> +		  SUNXI_FUNCTION(0x4, "sim"),		/* PWREN */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 14)),	/* PD_EINT14 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 15),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D15 */
> +		  SUNXI_FUNCTION(0x3, "lvds1"),		/* VN2 */
> +		  SUNXI_FUNCTION(0x4, "sim"),		/* CLK */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 15)),	/* PD_EINT15 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 16),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D16 */
> +		  SUNXI_FUNCTION(0x3, "lvds1"),		/* VPC */
> +		  SUNXI_FUNCTION(0x4, "sim"),		/* DATA */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 16)),	/* PD_EINT16 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 17),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D17 */
> +		  SUNXI_FUNCTION(0x3, "lvds1"),		/* VNC */
> +		  SUNXI_FUNCTION(0x4, "sim"),		/* RST */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 17)),	/* PD_EINT17 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 18),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D18 */
> +		  SUNXI_FUNCTION(0x3, "lvds1"),		/* VP3 */
> +		  SUNXI_FUNCTION(0x4, "sim"),		/* DET */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 18)),	/* PD_EINT18 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 19),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D19 */
> +		  SUNXI_FUNCTION(0x3, "lvds1"),		/* VN3 */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 19)),	/* PD_EINT19 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 20),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D20 */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 20)),	/* PD_EINT20 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 21),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D21 */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 21)),	/* PD_EINT21 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 22),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D22 */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 22)),	/* PD_EINT22 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 23),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D23 */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 23)),	/* PD_EINT23 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 24),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* CLK */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 24)),	/* PD_EINT24 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 25),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* DE */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 25)),	/* PD_EINT25 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 26),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* HSYNC */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 26)),	/* PD_EINT26 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 27),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* VSYNC */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 27)),	/* PD_EINT27 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 28),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "pwm0"),
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 28)),	/* PD_EINT28 */
> +	/* Hole */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 0),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "csi"),		/*  PCLK  */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 0)),	/* PE_EINT0 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 1),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "csi"),		/*  MCLK  */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 1)),	/* PE_EINT1 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 2),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "csi"),		/*  HSYNC  */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 2)),	/* PE_EINT2 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 3),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "csi"),		/*  VSYNC  */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 3)),	/* PE_EINT3 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 4),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "csi"),		/*  D0  */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 4)),	/* PE_EINT4 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 5),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "csi"),		/*  D1  */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 5)),	/* PE_EINT5 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 6),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "csi"),		/*  D2  */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 6)),	/* PE_EINT6 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 7),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "csi"),		/*  D3  */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 7)),	/* PE_EINT7 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 8),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "csi"),		/*  D4  */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 8)),	/* PE_EINT8 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 9),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "csi"),		/*  D5  */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 9)),	/* PE_EINT9 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 10),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "csi"),		/*  D6  */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 10)),	/* PE_EINT10 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 11),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "csi"),		/*  D7  */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 11)),	/* PE_EINT11 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 12),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "csi"),		/*  D8  */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 12)),	/* PE_EINT12 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 13),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "csi"),		/*  D9  */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 13)),	/* PE_EINT13 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 14),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "csi"),		/*  D10  */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 14)),	/* PE_EINT14 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 15),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "csi"),		/*  D11  */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 15)),	/* PE_EINT15 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 16),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "csi"),		/*  D12  */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 16)),	/* PE_EINT16 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 17),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "csi"),		/*  D13  */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 17)),	/* PE_EINT17 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 18),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "csi"),		/*  D14  */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 18)),	/* PE_EINT18 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 19),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "csi"),		/*  D15  */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 19)),	/* PE_EINT19 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 20),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "csi"),		/*  SCK  */
> +		  SUNXI_FUNCTION(0x5, "i2c2"),		/*  SCK  */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 20)),	/* PE_EINT20 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 21),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "csi"),		/*  SDA */
> +		  SUNXI_FUNCTION(0x5, "i2c2"),		/*  SDA  */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 21)),	/* PE_EINT21 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 22),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "csi"),		/*  FSIN0 */
> +		  SUNXI_FUNCTION(0x4, "tcon0"),		/*  TRIG0  */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 22)),	/* PE_EINT22 */
> +	/* Hole */
>   	SUNXI_PIN(SUNXI_PINCTRL_PIN(F, 0),
>   		  SUNXI_FUNCTION(0x0, "gpio_in"),
>   		  SUNXI_FUNCTION(0x1, "gpio_out"),
