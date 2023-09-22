Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 295107AA9A8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 09:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbjIVHEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 03:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjIVHEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 03:04:36 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC0C194
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 00:04:28 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9ada2e6e75fso230859366b.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 00:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695366267; x=1695971067; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d11MyHLSxPw+t8/RS5zpmIoRffEzNYMR6CarslWvWd4=;
        b=Ox8VCF/aV5mfL2e8PbITPhEpdatTOcMa6+3NOAIpy9obiTX+b2hTuZQW3n68RRSdb3
         UMvBNVq47ZQbJCuWZOpK7tjqF1yLlBZvQzPUobyRcm2mL3aD3vxPerqwrvStX8VYkUCY
         cNjfYgElBjGD+4gFP7Y8YEvm8CBOVjKoyj6onJ5OugLYKBdq6HduMovw4vSN3jspuDyZ
         oOBth7qdKZRRu94gcD1W3RbvXGFBdSFhHz+6jVlbUCpTdkvT0dPzspzSsWcY01RsjvRn
         q8J6pTREYzEKqckBpK/XcIdHQ4ZjNRgp+7h72v8WrkPff5ncSG5Mgf/US1OMUmLichWD
         /TfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695366267; x=1695971067;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d11MyHLSxPw+t8/RS5zpmIoRffEzNYMR6CarslWvWd4=;
        b=wK9LsLhhNQtdHi/kQqG3GZan4O3ZIC4ya7VuPEOCpIpsi0TFur/90PM7F54nUbmG2O
         9xunLNaiOluCjmYGRrx2xPfuoslR81kuNR63q+sNWNzwKPRRgGYjM/jDW3DCGxVX/Wau
         MiVQS3PDAOUuSoQC+dURooZYUwsGiniMfm/Vcj3lUPDS6aXrYv1X3pSdNFw4+KhgsoYP
         32o0vOQs0ktPuOvMejEhNd6on7AvCEiF/SkkJlQwDigdCRs/WnzARCRufaiF6JIVpeGn
         NKI0a9F58fwYyXwOre/RS/mVJi218S7rQSw+DxtPyDo7O2HECmM3rfGTSuf0UqEvlOsS
         ZSag==
X-Gm-Message-State: AOJu0YyqChzBKdNQ5J0nCamB1EFRekGvxPwp4d7Srtzx2UqXmY2iEGWQ
        HCZmyi84W1nIwNVa75fLSYoifQ==
X-Google-Smtp-Source: AGHT+IHogO17PwLU2znvUyO9/8APZZX660ORod7y/QACP44i/hmpfok6sl1Snj+DJ7SMPw5CPZR9ng==
X-Received: by 2002:a17:906:5386:b0:9a1:aea2:d18d with SMTP id g6-20020a170906538600b009a1aea2d18dmr6110360ejo.48.1695366267198;
        Fri, 22 Sep 2023 00:04:27 -0700 (PDT)
Received: from [10.41.192.245] ([77.241.232.19])
        by smtp.gmail.com with ESMTPSA id cb8-20020a170906a44800b00988dbbd1f7esm2209898ejb.213.2023.09.22.00.04.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Sep 2023 00:04:26 -0700 (PDT)
Message-ID: <3ce5feac-df61-586c-f617-dac916541821@linaro.org>
Date:   Fri, 22 Sep 2023 09:03:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1 1/1] ARM: dts: aspeed: yosemite4: Add i2c-mux/eeprom
 devices
Content-Language: en-US
To:     Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>, patrick@stwcx.xyz,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20230922064127.283625-1-Delphine_CC_Chiu@wiwynn.com>
 <20230922064127.283625-2-Delphine_CC_Chiu@wiwynn.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230922064127.283625-2-Delphine_CC_Chiu@wiwynn.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,WEIRD_QUOTING
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/09/2023 08:41, Delphine CC Chiu wrote:
> Revise Yosemite 4 devicetree for i2c-mux and eeprom,
> also the following changes:

No. One change, one commit. This is absolutely unreviewable and
unbisectable.

> - Enable adc 15, tpm, wdt2
> - Change spi-tx/rx-bus-width to duo mode

Why?

> - Add device mp5023, pmbus for Flex power module
> - Change ina230 to ina233, pca9846 to pca9546

Why?

> - Set adc128d818 and max31790 config
> - Add jtag1 and gpio0 config
> 
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> ---
> Changelog:
>  v1 - Add gpio and eeprom devices
>     - Enable adc 15, tpm, wdt2
>     - Change spi-tx/rx-bus-width to duo mode
>     - Add device mp5023, pmbus for Flex power module
>     - Change ina230 to ina233, pca9846 to pca9546
>     - Set adc128d818 and max31790 config
>     - Add jtag1 and gpio0 config
>     - Separate binding dosument to corresponding driver patches
> ---
>  .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 897 ++++++++++++++++--
>  1 file changed, 843 insertions(+), 54 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> index 64075cc41d92..894ee25c2654 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> @@ -17,6 +17,25 @@ aliases {
>  		serial6 = &uart7;
>  		serial7 = &uart8;
>  		serial8 = &uart9;
> +
> +		i2c16 = &imux16;
> +		i2c17 = &imux17;
> +		i2c18 = &imux18;
> +		i2c19 = &imux19;
> +		i2c20 = &imux20;
> +		i2c21 = &imux21;
> +		i2c22 = &imux22;
> +		i2c23 = &imux23;
> +		i2c24 = &imux24;
> +		i2c25 = &imux25;
> +		i2c26 = &imux26;
> +		i2c27 = &imux27;
> +		i2c28 = &imux28;
> +		i2c29 = &imux29;
> +		i2c30 = &imux30;
> +		i2c31 = &imux31;
> +		i2c32 = &imux32;
> +		i2c33 = &imux33;
>  	};
>  
>  	chosen {
> @@ -32,7 +51,26 @@ iio-hwmon {
>  		compatible = "iio-hwmon";
>  		io-channels = <&adc0 0>, <&adc0 1>, <&adc0 2>, <&adc0 3>,
>  				<&adc0 4>, <&adc0 5>, <&adc0 6>, <&adc0 7>,
> -				<&adc1 0>, <&adc1 1>;
> +				<&adc1 0>, <&adc1 1>, <&adc1 7>;
> +	};
> +
> +	spi_gpio: spi-gpio {
> +		status = "okay";

okay is  by default, why do you need it?

> +		compatible = "spi-gpio";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		gpio-sck = <&gpio0 ASPEED_GPIO(X, 3) GPIO_ACTIVE_HIGH>;
> +		gpio-mosi = <&gpio0 ASPEED_GPIO(X, 4) GPIO_ACTIVE_HIGH>;
> +		gpio-miso = <&gpio0 ASPEED_GPIO(X, 5) GPIO_ACTIVE_HIGH>;
> +		num-chipselects = <1>;
> +		cs-gpios = <&gpio0 ASPEED_GPIO(X, 0) GPIO_ACTIVE_LOW>;
> +
> +		tpmdev@0 {
> +			compatible = "tcg,tpm_tis-spi";
> +			spi-max-frequency = <33000000>;
> +			reg = <0>;
> +		};
>  	};
>  };
>  

...

>  
>  	power-sensor@43 {
> -		compatible = "ti,ina230";
> +		compatible = "ti,ina233";
>  		reg = <0x43>;
> +		resistor-calibration = /bits/ 16 <0x0a00>;
> +		current-lsb= /bits/ 16 <0x0001>;
>  	};
>  
>  	power-sensor@44 {
> -		compatible = "ti,ina230";
> +		compatible = "ti,ina233";

Nope, you are doing why too many changes. One logical change, one patch.
You must explain WHY you are doing this.

>  		reg = <0x44>;
> +		resistor-calibration = /bits/ 16 <0x0a00>;
> +		current-lsb= /bits/ 16 <0x0001>;
>  	};
>  


>  			adc@33 {
> @@ -492,34 +1070,34 @@ gpio@61 {
>  			};
>  		};
>  
> -		i2c@1 {
> +		imux31: i2c@1 {
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> -			reg = <0>;
> +			reg = <1>;
>  
>  			adc@1f {
>  				compatible = "ti,adc128d818";
>  				reg = <0x1f>;
> -				ti,mode = /bits/ 8 <2>;
> +				ti,mode = /bits/ 8 <1>;
>  			};
>  
>  			pwm@20{
> -				compatible = "max31790";
> +				compatible = "maxim,max31790";
> +				pwm-as-tach = <4 5>;
>  				reg = <0x20>;
> -				#address-cells = <1>;
> -				#size-cells = <0>;
>  			};
>  
>  			gpio@22{
>  				compatible = "ti,tca6424";
>  				reg = <0x22>;
> +				gpio-controller;
> +				#gpio-cells = <2>;
>  			};
>  
> -			pwm@23{
> -				compatible = "max31790";
> -				reg = <0x23>;
> -				#address-cells = <1>;
> -				#size-cells = <0>;
> +			pwm@2f{

Missing space

...

> +&gpio0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_gpiu2_default &pinctrl_gpiu3_default
> +		     &pinctrl_gpiu4_default &pinctrl_gpiu5_default
> +		     &pinctrl_gpiu6_default>;
> +	gpio-line-names =
> +	/*A0-A7*/       "","","","","","","","",
> +	/*B0-B7*/       "FLT_HSC_SERVER_SLOT8_N","AC_ON_OFF_BTN_CPLD_SLOT5_N",
> +			"PWRGD_SLOT1_STBY","PWRGD_SLOT2_STBY",
> +			"PWRGD_SLOT3_STBY","PWRGD_SLOT4_STBY","","",
> +	/*C0-C7*/       "PRSNT_NIC3_N","","","","FM_NIC0_WAKE_N",
> +			"FM_NIC1_WAKE_N","","RST_PCIE_SLOT2_N",
> +	/*D0-D7*/       "","","","","","","","",
> +	/*E0-E7*/       "PRSNT_NIC1_N","PRSNT_NIC2_N","","RST_PCIE_SLOT1_N",
> +			"","","","",
> +	/*F0-F7*/       "FM_RESBTN_SLOT1_BMC_N","FM_RESBTN_SLOT2_BMC_N",
> +			"FM_RESBTN_SLOT3_BMC_N","FM_RESBTN_SLOT4_BMC_N",
> +			"PRSNT_SB_SLOT1_N","PRSNT_SB_SLOT2_N",
> +			"PRSNT_SB_SLOT3_N","PRSNT_SB_SLOT4_N",
> +	/*G0-G7*/       "","","","","","","","",
> +	/*H0-H7*/       "","","","","","","","",
> +	/*I0-I7*/       "","","","","","ALT_MEDUSA_ADC_N",
> +			"ALT_SMB_BMC_CPLD2_N",
> +			"INT_SPIDER_ADC_R_N",
> +	/*J0-J7*/       "","","","","","","","",
> +	/*K0-K7*/       "","","","","","","","",
> +	/*L0-L7*/       "","","","","","","ALT_MEDUSA_P12V_EFUSE_N","",
> +	/*M0-M7*/       "EN_NIC0_POWER_BMC_R","EN_NIC1_POWER_BMC_R",
> +			"INT_MEDUSA_IOEXP_TEMP_N","FLT_P12V_NIC0_N",
> +			"INT_SMB_BMC_SLOT1_4_BMC_N",
> +			"AC_ON_OFF_BTN_CPLD_SLOT6_N","","",
> +	/*N0-N7*/       "FLT_HSC_SERVER_SLOT1_N","FLT_HSC_SERVER_SLOT2_N",
> +			"FLT_HSC_SERVER_SLOT3_N","FLT_HSC_SERVER_SLOT4_N",
> +			"FM_BMC_READY_R2","FLT_P12V_STBY_BMC_N","","",
> +	/*O0-O7*/       "AC_ON_OFF_BTN_CPLD_SLOT8_N","RST_SMB_NIC1_R_N",
> +			"RST_SMB_NIC2_R_N","RST_SMB_NIC3_R_N",
> +			"FLT_P3V3_NIC2_N","FLT_P3V3_NIC3_N",
> +			"","",
> +	/*P0-P7*/       "ALT_SMB_BMC_CPLD1_N","'BTN_BMC_R2_N",
> +			"EN_P3V_BAT_SCALED_R","PWRGD_P5V_USB_BMC",
> +			"FM_BMC_RTCRST_R","RST_USB_HUB_R_N",
> +			"FLAG_P5V_USB_BMC_N","",
> +	/*Q0-Q7*/       "AC_ON_OFF_BTN_CPLD_SLOT1_N","AC_ON_OFF_BTN_CPLD_SLOT2_N",
> +			"AC_ON_OFF_BTN_CPLD_SLOT3_N","AC_ON_OFF_BTN_CPLD_SLOT4_N",
> +			"PRSNT_SB_SLOT5_N","PRSNT_SB_SLOT6_N",
> +			"PRSNT_SB_SLOT7_N","PRSNT_SB_SLOT8_N",
> +	/*R0-R7*/       "AC_ON_OFF_BTN_CPLD_SLOT7_N","INT_SMB_BMC_SLOT5_8_BMC_N",
> +			"FM_PWRBRK_NIC_BMC_R2","RST_PCIE_SLOT4_N",
> +			"RST_PCIE_SLOT5_N","RST_PCIE_SLOT6_N",
> +			"RST_PCIE_SLOT7_N","RST_PCIE_SLOT8_N",
> +	/*S0-S7*/       "FM_NIC2_WAKE_N","FM_NIC3_WAKE_N",
> +			"EN_NIC3_POWER_BMC_R","SEL_BMC_JTAG_MUX_R",
> +			"","ALT_P12V_AUX_N","FAST_PROCHOT_N",
> +			"SPI_WP_DISABLE_STATUS_R_N",
> +	/*T0-T7*/       "","","","","","","","",
> +	/*U0-U7*/       "","","FLT_P3V3_NIC1_N","FLT_P12V_NIC1_N",
> +			"FLT_P12V_NIC2_N","FLT_P12V_NIC3_N",
> +			"FLT_P3V3_NIC0_N","",
> +	/*V0-V7*/       "FM_RESBTN_SLOT5_BMC_N","FM_RESBTN_SLOT6_BMC_N",
> +			"FM_RESBTN_SLOT7_BMC_N","FM_RESBTN_SLOT8_BMC_N",
> +			"","","","",
> +	/*W0-W7*/       "PRSNT_TPM_BMC_N","PRSNT_OCP_DEBUG_BMC_N","ALT_TEMP_BMC_N","ALT_RTC_BMC_N",
> +			"","","","",
> +	/*X0-X7*/       "","LT_HSC_SERVER_SLOT6_N","FLT_HSC_SERVER_SLOT7_N","","","",
> +			"PWRGD_SLOT5_STBY","PWRGD_SLOT6_STBY",
> +	/*Y0-Y7*/       "","","SPI_LOCK_REQ_BMC_N","PWRGD_SLOT7_STBY","","","EN_NIC2_POWER_BMC_R","",
> +	/*Z0-Z7*/       "EN_P5V_USB_CPLD_R","'FLT_HSC_SERVER_SLOT5_N",
> +			"PWRGD_SLOT8_STBY","","","","","";
> +
> +	pin_gpio_b4 {

We have been here. No underscores in node names.

Best regards,
Krzysztof

