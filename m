Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97FA680C2A5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 09:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233813AbjLKIEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 03:04:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjLKID7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 03:03:59 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1F9CE
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 00:04:05 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40b27726369so44664085e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 00:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702281844; x=1702886644; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4X844S4gQ3q6FO7d+ISC3qroJ9OqVpigsE30Kp2i1EI=;
        b=jmWQ4uG5HSznrnkkBDbzMNJUBhPj6wNPpCb2KMjec7r6EI9XZ8vWAZ0fq359qaLXvi
         vR80zT313avXEqIBFhsG2mmIsssnRwRUasbXApBUq4o742trkjjjnsnSswiyu0YadQNv
         OeliSZPCP/jWYVWG00rCcdVzDbwiAoNwHTMSQU9dtx5VX2R/Sy16wVzbeGxfW69SBJJW
         Syb13qV4TMJVMq1Uc2au7Q9wemc4dRmJYE0mbQKJlspY5dZ5Ba86kHHE5ew7ziUvzUqd
         fS/3sPH8tI7U2swa4AGcv5CtM9SYb7S5glPhIWFuDFzshhevT0bBxcTJaPF7b3Khogfx
         mqJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702281844; x=1702886644;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4X844S4gQ3q6FO7d+ISC3qroJ9OqVpigsE30Kp2i1EI=;
        b=r6GmHtA6V+LUyj/+zkIqTJnUxtVNQS4PkiBhvug4Klr0lHh2j7M5Acn53uiDh+NMEA
         ZFmBcKTMFbVwaWFXWyYMEfsCdZXFyOh7ttxlOXXzMv3VYH6r3R3Ro0xVh1DT/oqmBGVa
         8SA2drgibM1JNu5dgljKkT8mqBXISr1mJ4mVsfZ2J+YgYq89l86Jylj62ENNzRkkVsUg
         YjGKY+t+jmpdFmm42BDbmal/CRqlSQAc6N+YZ+alDT110pV/pPpW44kTrcJQNtST/qwU
         QebF0JH68Xa2Ho2QYQGKprCJzUdlTboSz3ikUCVHACMtsPN8bFePHZLdgGbArerP3cLc
         0cww==
X-Gm-Message-State: AOJu0Yw9onkdhGmhpA8hry+AHWKSSzeNRh10wpVc5tp1VnjrhqsFiYRr
        DyI3DAZeof/ryG3mNFPM9woq4A==
X-Google-Smtp-Source: AGHT+IGWl4ZndXMqtUrJiuOaCIcekxuZKSwk43cQUeMDLX00AtYT07c82Zs4ZMrVYTwV3quRfG7JOg==
X-Received: by 2002:a05:600c:141:b0:40c:426b:fd22 with SMTP id w1-20020a05600c014100b0040c426bfd22mr965958wmm.135.1702281843606;
        Mon, 11 Dec 2023 00:04:03 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id s18-20020adfea92000000b0033342d2bf02sm7857177wrm.25.2023.12.11.00.04.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Dec 2023 00:04:03 -0800 (PST)
Message-ID: <1f59a4f5-7082-4a36-806e-2fff4d1e5d7d@linaro.org>
Date:   Mon, 11 Dec 2023 09:04:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/14] ARM: dts: aspeed: yosemite4: Revise i2c11 and
 i2c12 schematic change
Content-Language: en-US
To:     Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>, patrick@stwcx.xyz,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20231211024947.3990898-1-Delphine_CC_Chiu@wiwynn.com>
 <20231211024947.3990898-9-Delphine_CC_Chiu@wiwynn.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231211024947.3990898-9-Delphine_CC_Chiu@wiwynn.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,WEIRD_QUOTING
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/2023 03:49, Delphine CC Chiu wrote:
> Revise i2c11 and i2c12 schematic change:
> - remove space for adm1272 compatible
> - enable interrupt setting for pca9555
> - add eeprom for yosemite4 medusa board/BSM use
> - remove temperature sensor for yosemite4 schematic change
> - add power sensor for power module reading

You should split your patch into several, per one logical change.


> 
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> ---
>  .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 118 ++++++++++++++----
>  1 file changed, 93 insertions(+), 25 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> index da413325ce30..ccb5ecd8d9a6 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> @@ -821,41 +821,94 @@ imux29: i2c@1 {
>  &i2c11 {
>  	status = "okay";
>  	power-sensor@10 {
> -		compatible = "adi, adm1272";
> +		compatible = "adi,adm1272";
>  		reg = <0x10>;
>  	};
>  
>  	power-sensor@12 {
> -		compatible = "adi, adm1272";
> +		compatible = "adi,adm1272";
>  		reg = <0x12>;
>  	};
>  
> -	gpio@20 {
> +	gpio_ext1: pca9555@20 {

That's not a correct change. You replace good code with bad.

>  		compatible = "nxp,pca9555";
> -		reg = <0x20>;
> +		pinctrl-names = "default";
>  		gpio-controller;
>  		#gpio-cells = <2>;
> -	};
> -
> -	gpio@21 {
> +		reg = <0x20>;
> +		interrupt-parent = <&gpio0>;
> +		interrupts = <94 IRQ_TYPE_LEVEL_LOW>;
> +		gpio-line-names =
> +		"P48V_OCP_GPIO1","P48V_OCP_GPIO2",
> +		"P48V_OCP_GPIO3","FAN_BOARD_0_REVISION_0_R",
> +		"FAN_BOARD_0_REVISION_1_R","FAN_BOARD_1_REVISION_0_R",
> +		"FAN_BOARD_1_REVISION_1_R","RST_MUX_R_N",
> +		"RST_LED_CONTROL_FAN_BOARD_0_N","RST_LED_CONTROL_FAN_BOARD_1_N",
> +		"RST_IOEXP_FAN_BOARD_0_N","RST_IOEXP_FAN_BOARD_1_N",
> +		"PWRGD_LOAD_SWITCH_FAN_BOARD_0_R","PWRGD_LOAD_SWITCH_FAN_BOARD_1_R",
> +		"","";
> +	};
> +
> +	gpio_ext2: pca9555@21 {

Nope

>  		compatible = "nxp,pca9555";
> -		reg = <0x21>;
> +		pinctrl-names = "default";
>  		gpio-controller;
>  		#gpio-cells = <2>;
> -	};
> -
> -	gpio@22 {
> +		reg = <0x21>;
> +		interrupt-parent = <&gpio0>;
> +		interrupts = <94 IRQ_TYPE_LEVEL_LOW>;
> +		gpio-line-names =
> +		"DELTA_MODULE_TYPE","VSENSE_ERR_VDROP_R",
> +		"EN_P48V_AUX_0","EN_P48V_AUX_1",
> +		"MEDUSA_BOARD_REV_0","MEDUSA_BOARD_REV_1",
> +		"MEDUSA_BOARD_REV_2","MEDUSA_BOARD_TYPE",
> +		"HSC_OCP_SLOT_ODD_GPIO1","HSC_OCP_SLOT_ODD_GPIO2",
> +		"HSC_OCP_SLOT_ODD_GPIO3","HSC_OCP_SLOT_EVEN_GPIO1",
> +		"HSC_OCP_SLOT_EVEN_GPIO2","HSC_OCP_SLOT_EVEN_GPIO3",
> +		"ADC_TYPE_0_R","ADC_TYPE_1_R";
> +	};
> +
> +	gpio_ext3: pca9555@22 {

Nope

>  		compatible = "nxp,pca9555";
> -		reg = <0x22>;
> +		pinctrl-names = "default";
>  		gpio-controller;
>  		#gpio-cells = <2>;
> -	};
> -
> -	gpio@23 {
> +		reg = <0x22>;
> +		interrupt-parent = <&gpio0>;
> +		interrupts = <94 IRQ_TYPE_LEVEL_LOW>;
> +		gpio-line-names =
> +		"CARD_TYPE_SLOT1","CARD_TYPE_SLOT2",
> +		"CARD_TYPE_SLOT3","CARD_TYPE_SLOT4",
> +		"CARD_TYPE_SLOT5","CARD_TYPE_SLOT6",
> +		"CARD_TYPE_SLOT7","CARD_TYPE_SLOT8",
> +		"OC_P48V_HSC_0_N","FLT_P48V_HSC_0_N",
> +		"PWRGD_P12V_AUX_1","OC_P48V_HSC_1_N",
> +		"FLT_P48V_HSC_1_N","PWRGD_P12V_AUX_1",
> +		"MEDUSA_ADC_EFUSE_TYPE_R","P12V_HSC_TYPE";
> +	};
> +
> +	gpio_ext4: pca9555@23 {

Nope



Best regards,
Krzysztof

