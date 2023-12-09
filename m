Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD7D80B45B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 13:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjLIM4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 07:56:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjLIM4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 07:56:01 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9855210D8
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 04:56:07 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-33350fcb2c7so2146061f8f.2
        for <linux-kernel@vger.kernel.org>; Sat, 09 Dec 2023 04:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1702126566; x=1702731366; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cha3RMhWzFtMx++aeV38CHkj+sIQkrAxTwK2Y8f1WFw=;
        b=fBClOUl1vwSUpmd269E7sbM99MjyaRlHLLb/IjN4GXKgvqI0jC152vjUkX556PydgJ
         PK+1KKHPSgXfy6idotwyC2oaa6vYT/b8Wj9i/vfdZo26NDvL/S5U4ejMRaA6qJTgXMCm
         u/1I8geQXc5QzHcScp7vDEBBNpBqdoC3H4NKbMDlKnmvoTGX33jWA8l7jlPuwLvzYWwr
         uFSmf4kTGmQlEc4w8Vymzy+9uRnJN6cruTjjetRcIuvLrXq3/JPLIl4bQ2CzkjhIpBtX
         rFaFFRMMYtvkDtN2eO55bvcD7nvAt5mAVFdif7/SrCcPpOjDctoUiEMo0/AxCm/LMhhU
         D+Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702126566; x=1702731366;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cha3RMhWzFtMx++aeV38CHkj+sIQkrAxTwK2Y8f1WFw=;
        b=c1TnYSzpQX2+60PRONyF0D4NCA5NyOG1J8WgSsSaRxdJP7/nCC9kKGoIbc4GOZ58mm
         ZeF15fvtDZy1A1sOktou1s2IVDUl4eqMGbcVQplNzkK9/DFu2WC9tM31n6WrGFvNzlz4
         b8zbES9fWjESwIJ/hoD1AAs0pdrU31er4zBzSbptNXJ9I2ih6yccuZvFAcqrtdI2br33
         uMqPPOd6AeTL3epJF71hV3X/TjvFdh3sdw9P/nnheyEem/7ZPm3M54MvCwp+qwlcAcCC
         uE0kdJ26mIjsTEuyxH4/ZWm4kwKgD3bAGTxWPy0Ugm3ryXalR4CrUBqdOJaUqMr57L9m
         WLsg==
X-Gm-Message-State: AOJu0YwRt2uHGEjNjf2UBMGLSPBPQwJd1ch4gMOW9PD2g3sLBPAgdWya
        gdelkrAF+mIYdZOk/ncIETQHjA==
X-Google-Smtp-Source: AGHT+IFa/1Iy1uYNgD7/XRuRkqfr8XdE2KlpmRUzkBTKu7/i/+f7B/CG9Qn+B4AX9jRSTeQk3dMV8w==
X-Received: by 2002:adf:fdcd:0:b0:333:4052:bfef with SMTP id i13-20020adffdcd000000b003334052bfefmr885370wrs.52.1702126565987;
        Sat, 09 Dec 2023 04:56:05 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.22])
        by smtp.gmail.com with ESMTPSA id cx7-20020a170907168700b009fc576e26e6sm2159109ejd.80.2023.12.09.04.56.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Dec 2023 04:56:05 -0800 (PST)
Message-ID: <80cd8878-da98-4093-9fb5-0b702466a17c@tuxon.dev>
Date:   Sat, 9 Dec 2023 14:56:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: microchip: sama5d27_wlsom1_ek: Remove
 mmc-ddr-3_3v property from sdmmc0 node
Content-Language: en-US
To:     Mihai Sain <mihai.sain@microchip.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     cristian.birsan@microchip.com
References: <20231204072537.2991-1-mihai.sain@microchip.com>
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20231204072537.2991-1-mihai.sain@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04.12.2023 09:25, Mihai Sain wrote:
> On board the sdmmc0 interface is wired to a SD Card socket.
> According with mmc-controller bindings, the mmc-ddr-3_3v property
> is used for eMMC devices to enable high-speed DDR mode (3.3V I/O).
> Remove the mmc-ddr-3_3v property from sdmmc0 node.
> 
> Signed-off-by: Mihai Sain <mihai.sain@microchip.com>

Applied to at91-dt, thanks!

> ---
>  arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1_ek.dts | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1_ek.dts b/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1_ek.dts
> index e055b9e2fe34..15239834d886 100644
> --- a/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1_ek.dts
> +++ b/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1_ek.dts
> @@ -197,7 +197,6 @@ qspi1_flash: flash@0 {
>  
>  &sdmmc0 {
>  	bus-width = <4>;
> -	mmc-ddr-3_3v;
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_sdmmc0_default>;
>  	status = "okay";
