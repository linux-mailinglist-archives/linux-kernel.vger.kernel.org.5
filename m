Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C4580F7C7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 21:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377335AbjLLUV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 15:21:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377223AbjLLUV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 15:21:26 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E908CA
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 12:21:32 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40c3984f0cdso46161895e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 12:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702412490; x=1703017290; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wZErAioQf1LZERsxfMR3lKDsZegEE6G271TmDjbBTrk=;
        b=hNjSeSwUm9XHQEEc+Vh8If8Y9r3RWQhNkArqgHbBCFTOKgC6oj8V4s+VziIhaR5eQR
         PyeslvWnx55vcDOBZyfWKs0uCfREFrAn1dN3OLxDayuKATP5LikS9zl2Ss4vxTm12bql
         tzKh6eZwF3B5HRq9Nn5o3NWnvpZfvWB4sTBogU01g7R1i50oHIIrpFMaMDV1pIOpi4ph
         hikTPGAniZXk0HIY8qZhjDwEWmOJ+ZoF70JvjepY1+teAWRpPTe1BOA0EC6ZHaDRIMBY
         iOn+d6NPbo/pmiabnqOwfX33ME7fhSVOrIdRuLk51oqlYZdAq8zcUSfcsnt8aJqzAhrp
         Hrlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702412490; x=1703017290;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wZErAioQf1LZERsxfMR3lKDsZegEE6G271TmDjbBTrk=;
        b=sdCPwNwneSNzRtEv8TxOKZFf+1EQ5FHCPfYhboZEvvHLNSiMg2k9ke5ycLTXqrzOhy
         akbxdMKypAPu7zntfbNoDa9AKLJyzU9Nvh/9Jw7on+Nrep2GSLruUUXpTBgz7Hm71jzm
         sxG3Q75e6CEdwr0gZTpH6is4O93WaAh6W8E9TmOVkhbjQoZrI1kyz8Hwa/Qc27mJmBUd
         Iqk1pkFCn6XJwwgWUh3NCo77pigY93ir8x09l2QrVcCtu9vDHyQGSlUnuwBWOIEdDdx/
         8Ozl151rw2btOWwx35EsF+vL4yr1ApfP8ciDyu2UivfGy4Z7STAN3BwjIyI//0zAf0mY
         4k/A==
X-Gm-Message-State: AOJu0YypHT1RZWOCGfLLA+oEtslBpsusGHoaEC+7o6KhodTEGvEYJASE
        E+QF7ZsnlYgtOUIGvH51Id4OlA==
X-Google-Smtp-Source: AGHT+IHCvjjcxkTZ8tLlmQz/LBPpAEuUcszYII3Aol0l37yJ2R7Y+P0aPz+zLd00EpkfPVJplPfJ2g==
X-Received: by 2002:a7b:cd15:0:b0:40c:29a7:643f with SMTP id f21-20020a7bcd15000000b0040c29a7643fmr3983987wmj.131.1702412490596;
        Tue, 12 Dec 2023 12:21:30 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id li14-20020a170907198e00b00a1f738318a5sm6178368ejc.155.2023.12.12.12.21.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 12:21:30 -0800 (PST)
Message-ID: <72a749b9-b9be-4496-9bcc-37519044c109@linaro.org>
Date:   Tue, 12 Dec 2023 21:21:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/8] ARM: dts: aspeed: System1: Add i2c and muxes
Content-Language: en-US
To:     Ninad Palsule <ninad@linux.ibm.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        joel@jms.id.au, andrew@codeconstruct.com.au, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, keescook@chromium.org,
        tony.luck@intel.com, gpiccoli@igalia.com,
        johannes.holland@infineon.com, linux@roeck-us.net,
        broonie@kernel.org
Cc:     patrick.rudolph@9elements.com, vincent@vtremblay.dev,
        peteryin.openbmc@gmail.com, lakshmiy@us.ibm.com,
        bhelgaas@google.com, naresh.solanki@9elements.com,
        alexander.stein@ew.tq-group.com, festevam@denx.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-hardening@vger.kernel.org,
        geissonator@yahoo.com
References: <20231212164004.1683589-1-ninad@linux.ibm.com>
 <20231212164004.1683589-5-ninad@linux.ibm.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231212164004.1683589-5-ninad@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/2023 17:40, Ninad Palsule wrote:
> This commit adds i2c devices and muxes.
> 
> Tested:
>     This board is tested using the simics simulator.
> 
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> ---
>  .../dts/aspeed/aspeed-bmc-ibm-system1.dts     | 577 ++++++++++++++++++
>  1 file changed, 577 insertions(+)
> 

Why do you split new submission into multiple chunks? The logical
feature here is new board, so all your DTS patches adding new board
should be in one patch.

> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
> index 01291b407f59..0557bff9f36a 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
> @@ -11,6 +11,65 @@ / {
>  	model = "System1";
>  	compatible = "ibm,system1-bmc", "aspeed,ast2600";
>  
> +	aliases {
> +		i2c16 = &i2c8mux1chn0;
> +		i2c17 = &i2c8mux1chn1;
> +		i2c18 = &i2c8mux1chn2;
> +		i2c19 = &i2c8mux1chn3;
> +		i2c20 = &i2c8mux1chn4;
> +		i2c21 = &i2c8mux1chn5;
> +		i2c22 = &i2c8mux1chn6;
> +		i2c23 = &i2c8mux1chn7;
> +		i2c24 = &i2c3mux0chn0;
> +		i2c25 = &i2c3mux0chn1;
> +		i2c26 = &i2c3mux0chn2;
> +		i2c27 = &i2c3mux0chn3;
> +		i2c28 = &i2c3mux0chn4;
> +		i2c29 = &i2c3mux0chn5;
> +		i2c30 = &i2c3mux0chn6;
> +		i2c31 = &i2c3mux0chn7;
> +		i2c32 = &i2c6mux0chn0;
> +		i2c33 = &i2c6mux0chn1;
> +		i2c34 = &i2c6mux0chn2;
> +		i2c35 = &i2c6mux0chn3;
> +		i2c36 = &i2c6mux0chn4;
> +		i2c37 = &i2c6mux0chn5;
> +		i2c38 = &i2c6mux0chn6;
> +		i2c39 = &i2c6mux0chn7;
> +		i2c40 = &i2c7mux0chn0;
> +		i2c41 = &i2c7mux0chn1;
> +		i2c42 = &i2c7mux0chn2;
> +		i2c43 = &i2c7mux0chn3;
> +		i2c44 = &i2c7mux0chn4;
> +		i2c45 = &i2c7mux0chn5;
> +		i2c46 = &i2c7mux0chn6;
> +		i2c47 = &i2c7mux0chn7;
> +		i2c48 = &i2c8mux0chn0;
> +		i2c49 = &i2c8mux0chn1;
> +		i2c50 = &i2c8mux0chn2;
> +		i2c51 = &i2c8mux0chn3;
> +		i2c52 = &i2c8mux0chn4;
> +		i2c53 = &i2c8mux0chn5;
> +		i2c54 = &i2c8mux0chn6;
> +		i2c55 = &i2c8mux0chn7;
> +		i2c56 = &i2c14mux0chn0;
> +		i2c57 = &i2c14mux0chn1;
> +		i2c58 = &i2c14mux0chn2;
> +		i2c59 = &i2c14mux0chn3;
> +		i2c60 = &i2c14mux0chn4;
> +		i2c61 = &i2c14mux0chn5;
> +		i2c62 = &i2c14mux0chn6;
> +		i2c63 = &i2c14mux0chn7;
> +		i2c64 = &i2c15mux0chn0;
> +		i2c65 = &i2c15mux0chn1;
> +		i2c66 = &i2c15mux0chn2;
> +		i2c67 = &i2c15mux0chn3;
> +		i2c68 = &i2c15mux0chn4;
> +		i2c69 = &i2c15mux0chn5;
> +		i2c70 = &i2c15mux0chn6;
> +		i2c71 = &i2c15mux0chn7;
> +	};
> +
>  	chosen {
>  		stdout-path = &uart5;
>  		bootargs = "console=ttyS4,115200n8 earlycon";
> @@ -54,10 +113,12 @@ vga_memory: region@bf000000 {
>  			reg = <0xbf000000 0x01000000>;  /* 16M */
>  		};
>  	};
> +

You need to clean your patchset...


>  };
>  
>  &adc1 {
>  	status = "okay";
> +

Really.

>  	aspeed,int-vref-microvolt = <2500000>;
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_adc8_default
> @@ -186,3 +247,519 @@ &kcs3 {
>  	aspeed,lpc-io-reg = <0xca2>;
>  	aspeed,lpc-interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
>  };
> +
> +&i2c0 {
> +	status = "okay";
> +};
> +
> +&i2c1 {
> +	status = "okay";
> +};
> +
> +&i2c2 {
> +	status = "okay";
> +};
> +
> +&i2c3 {
> +	status = "okay";
> +
> +	i2c-mux@70 {
> +		compatible = "nxp,pca9548";
> +		reg = <0x70>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		status = "okay";

Drop

> +		i2c-mux-idle-disconnect;
> +
> +		i2c3mux0chn0: i2c@0 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0>;
> +		};
> +
> +		i2c3mux0chn1: i2c@1 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <1>;
> +		};
> +
> +		i2c3mux0chn2: i2c@2 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <2>;
> +		};
> +
> +		i2c3mux0chn3: i2c@3 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <3>;
> +		};
> +
> +		i2c3mux0chn4: i2c@4 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <4>;
> +		};
> +
> +		i2c3mux0chn5: i2c@5 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <5>;
> +		};
> +
> +		i2c3mux0chn6: i2c@6 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <6>;
> +		};
> +
> +		i2c3mux0chn7: i2c@7 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <7>;
> +		};
> +	};
> +};
> +
> +&i2c4 {
> +	status = "okay";
> +};
> +
> +&i2c5 {
> +	status = "okay";
> +};
> +
> +&i2c6 {
> +	status = "okay";
> +
> +	i2c-mux@70 {
> +		compatible = "nxp,pca9548";
> +		reg = <0x70>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		status = "okay";

Drop

Other places as well.


Best regards,
Krzysztof

