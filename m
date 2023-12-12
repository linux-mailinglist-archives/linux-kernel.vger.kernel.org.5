Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05B3E80F7D3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 21:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377341AbjLLUZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 15:25:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377223AbjLLUZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 15:25:02 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEBEBBC
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 12:25:06 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40c3fe6c1b5so32352005e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 12:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702412705; x=1703017505; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gg2VhOkDAyFX8Rm+h8gLNSLn5Q4DtPM59iL23zDHgQs=;
        b=T9M78ciO7obQ6/ysQ3NlXE3GXsN6xk1paWoiipTleqYvxel5GIbRmGGvZCxENpy2Kg
         mbfLzo77bKIOMCH9zFZ5qqtWn3Ms3VH3EzbJ4KFEBVGEV+IkAkWnkMo1X5hWZkJ9Emsh
         9Pi2XUoINIcOnPVB/ts+TaxNDpjCR52pbQJAs0VO+YQWJGkdOsGfQNJKMk++b0lzvoCN
         05I9sK8bV0rd55+hUwG2dGDlXHKgHAXdxh4iHbS3jNJNEyolY7cPwsJSUZV5ZZLBoS4M
         xBapEu421XaXs7g8FkRVn6f7ouoqs6fC2m36EQJV1m4F3gqUleBEpQKWsBA8OMCP5C1y
         dibQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702412705; x=1703017505;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gg2VhOkDAyFX8Rm+h8gLNSLn5Q4DtPM59iL23zDHgQs=;
        b=ue0lGk5MHZA9M3Nayzzt6eEx4E3iOHQaS0B1PMcLBDiGQ/MmkqF1X5hHT2TYzu8OkS
         1Tot31cuWW30FRh+tmVsAHe3sLaMQVvntVxUJatbiv11l2j+VoULukZLM1hGjIpryvqG
         BzECYHRIROJUt0h4Mlw1v21SBPRs4VVXOIjJ0ZotQIZ5gy9jHTyNhOBZ26EuKR8kJTWM
         FiZ08sEVbRXQlBMaY7a2tZqhEep1M3+MqzhKAZzcra+g7HHnPw9bNbovNaE+JtOVCyUE
         Y+DqPsgGCZldvMNtKU4ODtQolAoGI9EfskV4arypnnuFMqmu/XeIzYXAffX7z/EGWvUP
         TWsg==
X-Gm-Message-State: AOJu0Yx2fA2pjyoVHo+HOco4nlUJAwCz03PT9fccCiMajv0UvWbb7oPv
        St64b+rjcx9K2bNwYRIsAE3jew==
X-Google-Smtp-Source: AGHT+IFQ06+o3v5U4i6nHVsfc7/wjTk6EGqq94+TOdJn7emzkIZzmR60D09Xdf40+S0+UEH+AGjfQQ==
X-Received: by 2002:a7b:c44b:0:b0:40c:3751:b661 with SMTP id l11-20020a7bc44b000000b0040c3751b661mr3360042wmi.61.1702412705095;
        Tue, 12 Dec 2023 12:25:05 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id w6-20020a5d6806000000b00336103442d2sm10177965wru.76.2023.12.12.12.25.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 12:25:04 -0800 (PST)
Message-ID: <1b19af6f-645a-4913-b9db-49b1f3ad54f9@linaro.org>
Date:   Tue, 12 Dec 2023 21:25:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 6/8] ARM: dts: aspeed: System1: GPIO, Fan ctrl, Led
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
 <20231212164004.1683589-7-ninad@linux.ibm.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231212164004.1683589-7-ninad@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,WEIRD_QUOTING
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/2023 17:40, Ninad Palsule wrote:
> This commit adds following devices to the device tree.
> - GPIO pin assignements, GPIO expansion devices
> - LED brinker devices
> - Fan controllers
> 
> Tested:
>     This board is tested using the simics simulator.
> 
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> ---
>  .../dts/aspeed/aspeed-bmc-ibm-system1.dts     | 547 +++++++++++++++++-

Squash it.

>  1 file changed, 542 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
> index b8e7e52d4600..75562aa63701 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
> @@ -114,6 +114,99 @@ vga_memory: region@bf000000 {
>  		};
>  	};
>  
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		bmc-ready {

It does not look like you tested the DTS against bindings. Please run
`make dtbs_check W=1` (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
for instructions).

> +			gpios = <&gpio0 ASPEED_GPIO(L, 7) GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		bmc-hb {

None of these were tested.


>  	/*A0-A7*/	"","","","","","","","",
> -	/*B0-B7*/	"","","","","","","","",
> +	/*B0-B7*/	"","","","","bmc-tpm-reset","","","",

Really? You just added these lines. There is no point in adding a new
line and immediately changing it.

This points how your split is artificial and not helpful.
...


>  &i2c2 {
> @@ -486,6 +744,20 @@ regulator@43 {
>  &i2c6 {
>  	status = "okay";
>  
> +	fan-controller@52 {
> +		compatible = "maxim,max31785a";
> +		reg = <0x52>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;

Why do you need cells?

> +	};
> +
> +	fan-controller@54 {
> +		compatible = "maxim,max31785a";
> +		reg = <0x54>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;

Why do you need cells?

> +	};
> +
>  	i2c-mux@70 {
>  		compatible = "nxp,pca9548";
>  		reg = <0x70>;
> @@ -522,6 +794,48 @@ i2c6mux0chn4: i2c@4 {
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  			reg = <4>;
> +
> +			led-controller@60 {
> +				compatible = "nxp,pca9551";
> +				reg = <0x60>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +
> +				led@0 {
> +					label = "enclosure-id-led";
> +					reg = <0>;
> +					retain-state-shutdown;
> +					default-state = "keep";
> +					type = <PCA955X_TYPE_LED>;
> +				};
> +
> +				led@1 {
> +					label = "attention-led";
> +					reg = <1>;
> +					retain-state-shutdown;
> +					default-state = "keep";
> +					type = <PCA955X_TYPE_LED>;
> +				};
> +
> +				led@2 {
> +					label = "enclosure-fault-rollup-led";
> +					reg = <2>;
> +					retain-state-shutdown;
> +					default-state = "keep";
> +					type = <PCA955X_TYPE_LED>;
> +				};
> +
> +				led@3 {
> +					label = "power-on-led";
> +					reg = <3>;
> +					retain-state-shutdown;
> +					default-state = "keep";
> +					type = <PCA955X_TYPE_LED>;
> +				};
> +			};
>  		};
>  
>  		i2c6mux0chn5: i2c@5 {
> @@ -542,6 +856,44 @@ i2c6mux0chn7: i2c@7 {
>  			reg = <7>;
>  		};
>  	};
> +
> +	pca3: pca9539@74 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


> +		compatible = "nxp,pca9539";
> +		reg = <0x74>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +	};
> +
> +	pca4: pca9539@77 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


> +		compatible = "nxp,pca9539";
> +		reg = <0x77>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +
> +		gpio-line-names =
> +			"PE_NVMED0_EXP_PRSNT_N",
> +			"PE_NVMED1_EXP_PRSNT_N",
> +			"PE_NVMED2_EXP_PRSNT_N",
> +			"PE_NVMED3_EXP_PRSNT_N",
> +			"LED_FAULT_NVMED0",
> +			"LED_FAULT_NVMED1",
> +			"LED_FAULT_NVMED2",
> +			"LED_FAULT_NVMED3",
> +			"FAN0_PRESENCE_R_N",
> +			"FAN1_PRESENCE_R_N",
> +			"FAN2_PRESENCE_R_N",
> +			"FAN3_PRESENCE_R_N",
> +			"FAN4_PRESENCE_R_N",
> +			"FAN5_PRESENCE_N",
> +			"FAN6_PRESENCE_N",
> +			"";
> +	};
>  };
>  
>  &i2c7 {
> @@ -809,6 +1161,191 @@ regulator@41 {
>  		compatible = "infineon,ir38263";
>  		reg = <0x41>;
>  	};
> +
> +	led-controller@61 {
> +		compatible = "nxp,pca9552";
> +		reg = <0x61>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +

...

> +		led@15 {
> +			label = "pe-cp-drv3-perst";
> +			reg = <15>;
> +			retain-state-shutdown;
> +			default-state = "keep";
> +			type = <PCA955X_TYPE_LED>;
> +		};
> +	};
> +
> +	pca1: pca9539@75 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation




Best regards,
Krzysztof

