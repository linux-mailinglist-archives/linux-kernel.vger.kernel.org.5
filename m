Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25AB37B7698
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 04:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240903AbjJDCXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 22:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbjJDCXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 22:23:51 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34996AF;
        Tue,  3 Oct 2023 19:23:47 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-690b7cb71aeso370183b3a.0;
        Tue, 03 Oct 2023 19:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696386226; x=1696991026; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5AxRDVC6vFOTOhTeIWXyy4DMe0oh9ZHTrLAq3N1EqvU=;
        b=STInohuPt3q5ijgdcHyt+JawH7p544IC29mLcZGl+w/7YpsLU2S+KZGGC6FJE6CMzL
         Bxf2VHYvFumxVpLFCFhfKm90CziyDQ6zgZsYDLHUWZbDbsGjEF0fsX2V0Gww5gl/S73g
         aO6c6viQ3EcxoxH+Y/jjECjEhgCo9OmnOiIgbv2lad+poGlqrTavdkUrw+BL0Lytv8L1
         ijFavvAI2E85Ji+dggbZs59axg6vKiRdJ4TQ6pwevRTUGLCqVwdKj+ALhWD1R5G5h/cn
         lbG0+gVEK5x5G5kpI/u6r5wNsMmQA99oDxCuN0BsRVvcNA8cnPst8yJMX+1JVb/sYB63
         NVng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696386226; x=1696991026;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5AxRDVC6vFOTOhTeIWXyy4DMe0oh9ZHTrLAq3N1EqvU=;
        b=dwfP/ItAS5UMa2vmIn+hPYsOXLqrdfoe16YasRY8JoZpKrEECq+1Y3tMuW6GHD5Xgf
         kpufUtcskQ24UmmvXBVNqGyFb75UF/KBI8rxXbTqJsRk59WfJ1QYFSpirTe9DYbIr7bH
         k1LCTWBpi6M6h1SuqMFabBantsDvqyUV7fUaogTH1MVITwpR8KYYaGATpcuyCARNBaHf
         WMONtpDQSVDsuMNMwtOvLMnwjDfv5NbKifMGcw3iA/Fh7A69nb1S5bi6vFgVUq55NZXi
         hoIwAFwILnnn5rlUGHX9WhmB3EFBlFq0/LD+7zL6ru4cBrpKoM6NtXRoRGFNpkqv+BbC
         rZ8A==
X-Gm-Message-State: AOJu0Yx5uQrPUKHT7+KzcO4lfLLxJH5ZfFoGo0srdv2Dv+XhSRy2DV4D
        4c4iaJpQbXCoce5+rAMXhH4=
X-Google-Smtp-Source: AGHT+IHr43C9UpuPjijwGKWCPZ2JzQZLnm2P/0H9xaztkMXZt/aiLspYKZvNXILMFKzqzx2QCLK4GA==
X-Received: by 2002:a05:6a00:15c5:b0:690:9a5a:e34e with SMTP id o5-20020a056a0015c500b006909a5ae34emr7938626pfu.12.1696386226465;
        Tue, 03 Oct 2023 19:23:46 -0700 (PDT)
Received: from [10.10.14.80] (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id s18-20020a62e712000000b006878cc942f1sm2046801pfh.54.2023.10.03.19.23.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Oct 2023 19:23:46 -0700 (PDT)
Message-ID: <634eefdd-b3af-8f8b-ab43-6037194ad522@gmail.com>
Date:   Wed, 4 Oct 2023 10:22:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v9 1/2] ARM: dts: aspeed: Minerva: Add Facebook Minerva
 (AST2600) BMC
To:     patrick@stwcx.xyz, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     peter.yin@quantatw.com
References: <20230907064514.1764010-1-peteryin.openbmc@gmail.com>
 <20230907064514.1764010-2-peteryin.openbmc@gmail.com>
Content-Language: en-US
From:   PeterYin <peteryin.openbmc@gmail.com>
In-Reply-To: <20230907064514.1764010-2-peteryin.openbmc@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,WEIRD_QUOTING
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Peter Yin 於 9/7/23 14:45 寫道:
> Add linux device tree entry related to Minerva
> specific devices connected to BMC SoC.
> 
> Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
> ---
>   arch/arm/boot/dts/aspeed/Makefile             |   1 +
>   .../aspeed/aspeed-bmc-facebook-minerva.dts    | 371 ++++++++++++++++++
>   2 files changed, 372 insertions(+)
>   create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
> 
> diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
> index 23cbc7203a8e..b1da302dbcd6 100644
> --- a/arch/arm/boot/dts/aspeed/Makefile
> +++ b/arch/arm/boot/dts/aspeed/Makefile
> @@ -19,6 +19,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
>   	aspeed-bmc-facebook-fuji.dtb \
>   	aspeed-bmc-facebook-galaxy100.dtb \
>   	aspeed-bmc-facebook-greatlakes.dtb \
> +	aspeed-bmc-facebook-minerva.dtb \
>   	aspeed-bmc-facebook-minipack.dtb \
>   	aspeed-bmc-facebook-tiogapass.dtb \
>   	aspeed-bmc-facebook-wedge40.dtb \
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
> new file mode 100644
> index 000000000000..4834473c3c39
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
> @@ -0,0 +1,371 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +// Copyright (c) 2023 Facebook Inc.
> +/dts-v1/;
> +
> +#include "aspeed-g6.dtsi"
> +#include <dt-bindings/gpio/aspeed-gpio.h>
> +#include <dt-bindings/i2c/i2c.h>
> +
> +/ {
> +	model = "Facebook Minerva";
> +	compatible = "facebook,minerva-bmc", "aspeed,ast2600";
> +
> +	aliases {
> +		serial0 = &uart1;
> +		serial4 = &uart5;
> +	};
> +
> +	chosen {
> +		stdout-path = &uart5;
> +	};
> +
> +	memory@80000000 {
> +		device_type = "memory";
> +		reg = <0x80000000 0x80000000>;
> +	};
> +
> +	iio-hwmon {
> +		compatible = "iio-hwmon";
> +		io-channels = <&adc0 0>, <&adc0 1>, <&adc0 2>, <&adc0 3>,
> +			<&adc0 4>, <&adc0 5>, <&adc0 6>, <&adc0 7>,
> +			<&adc1 2>;
> +	};
> +};
> +
> +// HOST BIOS Debug
> +&uart1 {
> +	status = "okay";
> +};
> +
> +// SOL Host Console
> +&uart2 {
> +	status = "okay";
> +	pinctrl-0 = <>;
> +};
> +
> +// SOL BMC Console
> +&uart4 {
> +	status = "okay";
> +	pinctrl-0 = <>;
> +};
> +
> +// BMC Debug Console
> +&uart5 {
> +	status = "okay";
> +};
> +
> +// MTIA
> +&uart6 {
> +	status = "okay";
> +};
> +
> +&uart_routing {
> +	status = "okay";
> +};
> +
> +&vuart1 {
> +	status = "okay";
> +	virtual;
> +	port=<0x3e8>;
> +	sirq = <7>;
> +	sirq-polarity = <0>;
> +	dma-mode;
> +	dma-channel = <12>;
> +};
> +
> +&wdt1 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_wdtrst1_default>;
> +	aspeed,reset-type = "soc";
> +	aspeed,external-signal;
> +	aspeed,ext-push-pull;
> +	aspeed,ext-active-high;
> +	aspeed,ext-pulse-duration = <256>;
> +};
> +
> +&mac3 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_rmii4_default>;
> +	no-hw-checksum;
> +	use-ncsi;
> +	ncsi-ctrl,start-redo-probe;
> +	ncsi-ctrl,no-channel-monitor;
> +	mlx,multi-host;
> +	ncsi-package = <1>;
> +	ncsi-channel = <1>;
> +	ncsi-rexmit = <1>;
> +	ncsi-timeout = <2>;
> +};
> +
> +&rtc {
> +	status = "okay";
> +};
> +
> +&fmc {
> +	status = "okay";
> +
> +	flash@0 {
> +		status = "okay";
> +		m25p,fast-read;
> +		label = "bmc";
> +		spi-max-frequency = <50000000>;
> +#include "openbmc-flash-layout-128.dtsi"
> +	};
> +
> +	flash@1 {
> +		status = "okay";
> +		m25p,fast-read;
> +		label = "alt-bmc";
> +		spi-max-frequency = <50000000>;
> +	};
> +};
> +
> +// BIOS Flash
> +&spi2 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_spi2_default>;
> +
> +	flash@0 {
> +		status = "okay";
> +		m25p,fast-read;
> +		label = "pnor";
> +		spi-max-frequency = <12000000>;
> +		spi-tx-bus-width = <2>;
> +		spi-rx-bus-width = <2>;
> +	};
> +};
> +
> +&kcs2 {
> +	status = "okay";
> +	aspeed,lpc-io-reg = <0xca8>;
> +};
> +
> +&kcs3 {
> +	status = "okay";
> +	aspeed,lpc-io-reg = <0xca2>;
> +};
> +
> +&lpc_snoop {
> +	status = "okay";
> +	snoop-ports = <0x80>;
> +};
> +
> +&peci0 {
> +	status = "okay";
> +	clock-frequency = <1000000>;
> +};
> +
> +&i2c0 {
> +	status = "okay";
> +};
> +
> +&i2c1 {
> +	status = "okay";
> +
> +	tmp75@4B {
> +		compatible = "ti,tmp75";
> +		reg = <0x4B>;
> +	};
> +};
> +
> +&i2c2 {
> +	status = "okay";
> +};
> +
> +&i2c3 {
> +	status = "okay";
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
> +};
> +
> +&i2c7 {
> +	status = "okay";
> +};
> +
> +&i2c8 {
> +	status = "okay";
> +};
> +
> +&i2c9 {
> +	status = "okay";
> +};
> +
> +&i2c11 {
> +	status = "okay";
> +};
> +
> +&i2c12 {
> +	status = "okay";
> +};
> +
> +&i2c13 {
> +	status = "okay";
> +};
> +
> +// To Debug card
> +&i2c14 {
> +	status = "okay";
> +	multi-master;
> +
> +	ipmb@10 {
> +		compatible = "ipmb-dev";
> +		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
> +		i2c-protocol;
> +	};
> +};
> +
> +&i2c15 {
> +	status = "okay";
> +
> +	// SCM FRU
> +	eeprom@50 {
> +		compatible = "atmel,24c64";
> +		reg = <0x50>;
> +	};
> +	// BSM FRU
> +	eeprom@56 {
> +		compatible = "atmel,24c64";
> +		reg = <0x56>;
> +	};
> +};
> +
> +&adc0 {
> +	ref_voltage = <2500>;
> +	status = "okay";
> +	pinctrl-0 = <&pinctrl_adc0_default &pinctrl_adc1_default
> +		&pinctrl_adc2_default &pinctrl_adc3_default
> +		&pinctrl_adc4_default &pinctrl_adc5_default
> +		&pinctrl_adc6_default &pinctrl_adc7_default>;
> +};
> +
> +&adc1 {
> +	ref_voltage = <2500>;
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_adc10_default>;
> +};
> +
> +&ehci1 {
> +	status = "okay";
> +};
> +
> +&gpio0 {
> +	pinctrl-names = "default";
> +	gpio-line-names =
> +	/*A0-A7*/	"","","","","","","","",
> +	/*B0-B7*/	"","","","","","FM_ID_LED_N","","",
> +	/*C0-C7*/	"","","","","","","","",
> +	/*D0-D7*/	"","","SOL_UART_SET","","","","","",
> +	/*E0-E7*/	"","","","","","","","",
> +	/*F0-F7*/	"","","","","","","","",
> +	/*G0-G7*/	"","","","","","","","",
> +	/*H0-H7*/	"","","","","","","","",
> +	/*I0-I7*/	"","","","","","","","",
> +	/*J0-J7*/	"","","","","","","","",
> +	/*K0-K7*/	"","","","","","","","",
> +	/*L0-L7*/	"","","","","","","","",
> +	/*M0-M7*/	"","","","","","","","",
> +	/*N0-N7*/	"LED_POSTCODE_0","LED_POSTCODE_1",
> +			"LED_POSTCODE_2","LED_POSTCODE_3",
> +			"LED_POSTCODE_4","LED_POSTCODE_5",
> +			"LED_POSTCODE_6","LED_POSTCODE_7",
> +	/*O0-O7*/	"","","","","","","","",
> +	/*P0-P7*/	"FP_SYS_PWRBTN_IN_N","BMC_SYS_PWRBTN_OUT_N",
> +			"FP_RST_BTN_IN_N","","","","","",
> +	/*Q0-Q7*/	"","","","","","","","",
> +	/*R0-R7*/	"","","","","","","","",
> +	/*S0-S7*/	"","","","","","","","",
> +	/*T0-T7*/	"","","","","","","","",
> +	/*U0-U7*/	"","","","","","","","",
> +	/*V0-V7*/	"","","","","","","","",
> +	/*W0-W7*/	"","","","","","","","",
> +	/*X0-X7*/	"","","","","","","","",
> +	/*Y0-Y7*/	"","","","","","","","",
> +	/*Z0-Z7*/	"","","","","","","","";
> +};
> +
> +&sgpiom0 {
> +	status = "okay";
> +	max-ngpios = <128>;
> +	ngpios = <128>;
> +	bus-frequency = <2000000>;
> +	gpio-line-names =
> +	/*in - out - in - out */
> +	/*A0-A3 line 0-7*/
> +	"","","","","","ENABLE_SENSORS","","",
> +	/*A4-A7 line 8-15*/
> +	"","","","","","","","",
> +	/*B0-B3 line 16-23*/
> +	"","","","","","BMC_RST_BTN_OUT_N","","",
> +	/*B4-B7 line 24-31*/
> +	"","","","","","","","",
> +	/*C0-C3 line 32-39*/
> +	"","","","","","","","",
> +	/*C4-C7 line 40-47*/
> +	"","","","","","","","",
> +	/*D0-D3 line 48-55*/
> +	"","","","","","","","",
> +	/*D4-D7 line 56-63*/
> +	"","","","","","","","",
> +	/*E0-E3 line 64-71*/
> +	"","","","","","","","",
> +	/*E4-E7 line 72-79*/
> +	"","","","","","","","",
> +	/*F0-F3 line 80-87*/
> +	"","","","","","","","",
> +	/*F4-F7 line 88-95*/
> +	"","","","","","","","",
> +	/*G0-G3 line 96-103*/
> +	"","","","","","","","",
> +	/*G4-G7 line 104-111*/
> +	"","","","","","","","",
> +	/*H0-H3 line 112-119*/
> +	"","","","","PLD_SYS_POWER_GOOD","","","",
> +	/*H4-H7 line 120-127*/
> +	"","","","","","","","",
> +	/*I0-I3 line 128-135*/
> +	"","","","","","","","",
> +	/*I4-I7 line 136-143*/
> +	"","","","","","","","",
> +	/*J0-J3 line 144-151*/
> +	"","","PLD_BIOS_POST_CMPLT_N","","","","","",
> +	/*J4-J7 line 152-159*/
> +	"","","","","","","","",
> +	/*K0-K3 line 160-167*/
> +	"","","","","","","","",
> +	/*K4-K7 line 168-175*/
> +	"","","","","","","","",
> +	/*L0-L3 line 176-183*/
> +	"","","","","","","","",
> +	/*L4-L7 line 184-191*/
> +	"","","","","","","","",
> +	/*M0-M3 line 192-199*/
> +	"","","","","","","","",
> +	/*M4-M7 line 200-207*/
> +	"","","","","","","","",
> +	/*N0-N3 line 208-215*/
> +	"","","","","","","","",
> +	/*N4-N7 line 216-223*/
> +	"","","","","","","","",
> +	/*O0-O3 line 224-231*/
> +	"","","","","","","","",
> +	/*O4-O7 line 232-239*/
> +	"","","","","","","","",
> +	/*P0-P3 line 240-247*/
> +	"","","","","","","","",
> +	/*P4-P7 line 248-255*/
> +	"","","","","","","","";
> +};
Hello Maintainer,
  Are there any recommendations or modifications that you consider 
necessary?

Thanks.

