Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2DE7977C6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234883AbjIGQdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241795AbjIGQcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:32:55 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4986EB7
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 09:32:27 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-31ad779e6b3so1116861f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 09:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694104283; x=1694709083; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gmjr5UpU43MeSeIRw6DXV3UDbwxWAdsQzgPvfmhxLYE=;
        b=PKGKlxTCSpyNBOKjbp4VPU8nhFyPDHnbVdX7AD+mSaMKojFl1LLnDPifmd0dGhGLKP
         9ASz1OxBs7ZhhLmax5AUugQkiVDYOeMSeQIdF6UULfhq20v5CGunYLNzHTbOZR49CnW3
         g99zKKQT4j0w9of/ml/ycCadjutpKPRIU99FoNTmT+ClhRkqq3CyE4wPw62EJrLiaqGW
         EgFeM+Si/9N0Yhd3iBhuPZ+KdBQX9dmGrh/dWORPToJQPRQfs51AdJEeN5cmR+N3H0Qb
         35AR9xfCUobZU0YDZP3UZbsY/uWJi/Slhfm7Tsz6YRQbuqdYZ+GOsJ0NCwloXV5eTWfy
         3abQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694104283; x=1694709083;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gmjr5UpU43MeSeIRw6DXV3UDbwxWAdsQzgPvfmhxLYE=;
        b=OVcqxA3w7ECeTWeBwxriZ3yKpAgKfyy4iY1aAXJieTW320J5aFZjSRVj80KO0EIwaZ
         LyYY3mzydTxiZaMx/UEjH6ZRvPfdmEYL2SuVcMq7IthNpbWHcOCX456NNNSsoChFRpvv
         aYsMszkE341rIK02j2PYWIxGEGuX+gjjDre34QPnAQeYVJJsJTqWGCEOgqynHIgSHu/1
         yLQfneOFoboBW5koYuRdkWGG5cAXb/HcONqwYfAwkNkiwYiYs8MqTGQFdAeSgLeYn1XD
         y9qFHnfJAV4jpuepTrA9hLbfMPnWAhU645WxCa0OS+KaEqbs3kgh1rIUpwpA5aI1XYPv
         /d+g==
X-Gm-Message-State: AOJu0Yy0BCm9OuuX9d1oHtoBRGk6+5sQNWWi2VcVu7hgTYeOWjMdc4jJ
        qKTT4+cWl3cpOL7vbqz//T++j1DnDkBT4RMML+Oj6Q==
X-Google-Smtp-Source: AGHT+IFL4mJSVN5Q4y9x2wXjsiO7oalgR37HkfDL2LpSJ49fYbLaZ41/2W4HbAU5KOqfz7oCa2LzeA==
X-Received: by 2002:a05:6402:615:b0:523:d1ab:b2ec with SMTP id n21-20020a056402061500b00523d1abb2ecmr3925764edv.35.1694067084345;
        Wed, 06 Sep 2023 23:11:24 -0700 (PDT)
Received: from [192.168.0.22] (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id w13-20020aa7dccd000000b005256e0797acsm9299224edu.37.2023.09.06.23.11.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 23:11:23 -0700 (PDT)
Message-ID: <56334793-3d21-1f2c-2f5c-01ba2f306813@linaro.org>
Date:   Thu, 7 Sep 2023 08:11:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 1/2] arm:dts: am3517-evm: Fix LED3/4 pinmux
Content-Language: en-US
To:     Adam Ford <aford173@gmail.com>, linux-omap@vger.kernel.org
Cc:     aford@beaconembedded.com,
        =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Derald D. Woods" <woods.technical@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230907010159.330555-1-aford173@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230907010159.330555-1-aford173@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/2023 03:01, Adam Ford wrote:
> The pinmux for LED3 and LED4 are incorrectly attached to the
> omap3_pmx_core when they should be connected to the omap3_pmx_wkup
> pin mux.  This was likely masked by the fact that the bootloader
> used to do all the pinmuxing.
> 
> Fixes: 0dbf99542caf ("ARM: dts: am3517-evm: Add User LEDs and Pushbutton")
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
> This likely cannot apply to the original series, because the file has
> moved.  I can generate a separate patch for the pre-move device trees
> if necesssary.  The original location was:
>   arch/arm/boot/dts/am3517-evm.dts
> 
> diff --git a/arch/arm/boot/dts/ti/omap/am3517-evm.dts b/arch/arm/boot/dts/ti/omap/am3517-evm.dts
> index af9df15274be..738189ddc8d5 100644
> --- a/arch/arm/boot/dts/ti/omap/am3517-evm.dts
> +++ b/arch/arm/boot/dts/ti/omap/am3517-evm.dts
> @@ -271,13 +271,6 @@ OMAP3_CORE1_IOPAD(0x21c4, PIN_INPUT_PULLUP | MUX_MODE0)  /* i2c3_sda */
>  		>;
>  	};
>  
> -	leds_pins: leds-pins {
> -		pinctrl-single,pins = <
> -			OMAP3_WKUP_IOPAD(0x2a24, PIN_OUTPUT_PULLUP | MUX_MODE4)	/* jtag_emu0.gpio_11 */
> -			OMAP3_WKUP_IOPAD(0x2a26, PIN_OUTPUT_PULLUP | MUX_MODE4)	/* jtag_emu1.gpio_31 */
> -		>;
> -	};
> -
>  	mmc1_pins: mmc1-pins {
>  		pinctrl-single,pins = <
>  			OMAP3_CORE1_IOPAD(0x2144, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_clk.sdmmc1_clk */
> @@ -355,3 +348,12 @@ OMAP3430_CORE2_IOPAD(0x25e2, PIN_INPUT | MUX_MODE3)	/* etk_d3.hsusb1_data7 */
>  		>;
>  	};
>  };
> +
> +&omap3_pmx_wkup {
> +	leds_pins: pinmux_leds_pins {

Come on... why moving it and changing the name to incorrect one? Isn't a
move cut-paste?

Best regards,
Krzysztof

