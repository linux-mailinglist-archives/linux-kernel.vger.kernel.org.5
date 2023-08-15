Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5DB77CD7E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 15:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237447AbjHONp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 09:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237446AbjHONpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 09:45:21 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D5F41987
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 06:45:18 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-317c3ac7339so4637778f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 06:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692107117; x=1692711917;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xcPUWysXDTiKfw7gZ8FtN9+LX48DKX4a+XFMxnig2RQ=;
        b=M7RTjmd48w11YdcpK96o0eRSzZ037MNkV+HZEEuC2zUhMeMQqSgQpfNGK/nll10pJu
         J6W43MWyDBnilAR0jgeDw2E5DC45xAi6gutKMf6rSu5f7b4w46gWz/Xt2K0gir1s4HyB
         SF5zpiw+tMYBhS2pjGMTu4fAGd4k3+PnQ60q26ktPyWC4qCo3lDkDFRRXrQ1E2q9Kcma
         J1ZxK0NT6CuIiZSCEd67+2w2K9GnO2Zu9jcwrBdTSzUgevJvf5b+55aIpHONG3VFld/m
         Kq+vjPstU35EPnw4bVYXjkdF+ZK00sBpPJTaUhA8YUn7N1lsf4nsMwXVlCTT2jCIqwtI
         dglw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692107117; x=1692711917;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xcPUWysXDTiKfw7gZ8FtN9+LX48DKX4a+XFMxnig2RQ=;
        b=Eo8vnoHsjUOdhTyU+NS4B56PQ3ubusIY3gDFS/8yV3022fHtI/5fiVby50b4YsqLTS
         7ZPhJmcaaVjQcjjGHQQDZOngo4cUb+I2okFj8aDW8w+A9TPlIqL3bXCL87py5fLOnjy1
         w0o6+bmhH/yKdZdPmcbtrd0Njttauu1apH/BoijlLf4/ZoT6eQQyEew69X+BQ5AeGq3i
         FVAGBOaSYj46sFQHf2y+sPDMbi6qHUTNPg4vVue4BucMqFdaRAAADZ+2zj/0daL+Rsja
         pNryLZ8e1cLvXBoaLebkFGKUrqWJErd7rIR51QikDwjkKwgrHSNLpDUuhHkGQqbiba+6
         nzRQ==
X-Gm-Message-State: AOJu0YwQG4BPIfEG7U3fNbtrEFqBzVm5F5zd9oFAZUrsn0yb33Tearaa
        GF/FxbshMxtznB0GY5UtiFZCAw==
X-Google-Smtp-Source: AGHT+IGOhWSAUTJVLUdJ50unBGIbYPraM5efuHT0Xv/Q3OR3+4nOlIO5hF3MoMxq1vhiEk9zAwDe7w==
X-Received: by 2002:adf:e74f:0:b0:317:6314:96e2 with SMTP id c15-20020adfe74f000000b00317631496e2mr9097744wrn.14.1692107116984;
        Tue, 15 Aug 2023 06:45:16 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id v9-20020a5d6b09000000b0031759e6b43fsm18004088wrw.39.2023.08.15.06.45.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Aug 2023 06:45:16 -0700 (PDT)
Message-ID: <a80a8f73-eef4-311b-c508-726956471880@linaro.org>
Date:   Tue, 15 Aug 2023 15:45:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: Add Orange Pi 5
Content-Language: en-US
To:     Muhammed Efe Cetin <efectn@6tel.net>,
        linux-rockchip@lists.infradead.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        heiko@sntech.de, sebastian.reichel@collabora.com
References: <cover.1692102057.git.efectn@6tel.net>
 <a1eca379d151c3f91f4cd4e1751ba389096c4f13.1692102057.git.efectn@6tel.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <a1eca379d151c3f91f4cd4e1751ba389096c4f13.1692102057.git.efectn@6tel.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/08/2023 14:59, Muhammed Efe Cetin wrote:
> Add initial support for OPi5 that includes support for USB2, PCIe2, Sata,
> Sdmmc, SPI Flash, PMIC.
> 
> Signed-off-by: Muhammed Efe Cetin <efectn@6tel.net>
> ---
>  .../boot/dts/rockchip/rk3588s-orangepi-5.dts  | 873 ++++++++++++++++++

Without Makefile this won't be build, so this was not ever tested.

>  1 file changed, 873 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dts
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dts b/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dts
> new file mode 100644
> index 000000000000..85071084a207
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dts
> @@ -0,0 +1,873 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/pinctrl/rockchip.h>
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include "rk3588s.dtsi"
> +
> +/ {
> +	model = "Xunlong Orange Pi 5";
> +	compatible = "xunlong,orangepi-5", "rockchip,rk3588s";
> +
> +	aliases {
> +		mmc0 = &sdmmc;
> +		serial2 = &uart2;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial2:1500000n8";
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 =<&leds_gpio>;
> +
> +		led@1 {

Unit address is not correct here, it is not a bus. This should be
reported as warning, so you did not check for warnings.

It does not look like you tested the DTS against bindings. Please run
`make dtbs_check W=1` (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
for instructions).

> +			gpios = <&gpio1 RK_PA2 GPIO_ACTIVE_HIGH>;
> +			label = "status_led";
> +			linux,default-trigger = "heartbeat";
> +			linux,default-trigger-delay-ms = <0>;
> +		};
> +	};
> +
> +	adc-keys {
> +		compatible = "adc-keys";
> +		io-channels = <&saradc 1>;
> +		io-channel-names = "buttons";
> +		keyup-threshold-microvolt = <1800000>;
> +		poll-interval = <100>;
> +
> +		vol-up-key {
> +			label = "volume up";
> +			linux,code = <KEY_VOLUMEUP>;
> +			press-threshold-microvolt = <17000>;
> +		};
> +
> +		vol-down-key {
> +			label = "volume down";
> +			linux,code = <KEY_VOLUMEDOWN>;
> +			press-threshold-microvolt = <417000>;
> +		};
> +
> +		menu-key {
> +			label = "menu";
> +			linux,code = <KEY_MENU>;
> +			press-threshold-microvolt = <890000>;
> +		};
> +
> +		back-key {
> +			label = "back";
> +			linux,code = <KEY_BACK>;
> +			press-threshold-microvolt = <1235000>;
> +		};
> +	};
> +
> +	backlight: backlight {
> +		compatible = "pwm-backlight";
> +		brightness-levels = <  0  20  20  21  21  22  22  23
> +					  23  24  24  25  25  26  26  27
> +					  27  28  28  29  29  30  30  31
> +					  31  32  32  33  33  34  34  35
> +					  35  36  36  37  37  38  38  39
> +					  40  41  42  43  44  45  46  47
> +					  48  49  50  51  52  53  54  55
> +					  56  57  58  59  60  61  62  63
> +					  64  65  66  67  68  69  70  71
> +					  72  73  74  75  76  77  78  79
> +					  80  81  82  83  84  85  86  87
> +					  88  89  90  91  92  93  94  95
> +					  96  97  98  99 100 101 102 103
> +					  104 105 106 107 108 109 110 111
> +					  112 113 114 115 116 117 118 119
> +					  120 121 122 123 124 125 126 127
> +					  128 129 130 131 132 133 134 135
> +					  136 137 138 139 140 141 142 143
> +					  144 145 146 147 148 149 150 151
> +					  152 153 154 155 156 157 158 159
> +					  160 161 162 163 164 165 166 167
> +					  168 169 170 171 172 173 174 175
> +					  176 177 178 179 180 181 182 183
> +					  184 185 186 187 188 189 190 191
> +					  192 193 194 195 196 197 198 199
> +					  200 201 202 203 204 205 206 207
> +					  208 209 210 211 212 213 214 215
> +					  216 217 218 219 220 221 222 223
> +					  224 225 226 227 228 229 230 231
> +					  232 233 234 235 236 237 238 239
> +					  240 241 242 243 244 245 246 247
> +					  248 249 250 251 252 253 254 255>;
> +		default-brightness-level = <200>;
> +		pwms = <&pwm2 0 25000 0>;
> +	};
> +
> +	backlight_1: backlight_1 {

No underscores in node names, use -

> +		compatible = "pwm-backlight";
> +		brightness-levels = <  0  20  20  21  21  22  22  23
> +					  23  24  24  25  25  26  26  27
> +					  27  28  28  29  29  30  30  31

...

> +
> +&combphy0_ps {
> +	status = "okay";
> +};
> +
> +&combphy2_psu {
> +	status = "okay";
> +};
> +
> +&cpu_b0 {
> +	cpu-supply = <&vdd_cpu_big0_s0>;
> +	mem-supply = <&vdd_cpu_big0_mem_s0>;
> +};
> +
> +&cpu_b1 {
> +	cpu-supply = <&vdd_cpu_big0_s0>;
> +	mem-supply = <&vdd_cpu_big0_mem_s0>;
> +};
> +
> +&cpu_b2 {
> +	cpu-supply = <&vdd_cpu_big1_s0>;
> +	mem-supply = <&vdd_cpu_big1_mem_s0>;
> +};
> +
> +&cpu_b3 {
> +	cpu-supply = <&vdd_cpu_big1_s0>;
> +	mem-supply = <&vdd_cpu_big1_mem_s0>;
> +};
> +
> +&cpu_l0 {
> +	cpu-supply = <&vdd_cpu_lit_s0>;
> +	mem-supply = <&vdd_cpu_lit_mem_s0>;
> +};
> +
> +&cpu_l1 {
> +	cpu-supply = <&vdd_cpu_lit_s0>;
> +	mem-supply = <&vdd_cpu_lit_mem_s0>;
> +};
> +
> +&cpu_l2 {
> +	cpu-supply = <&vdd_cpu_lit_s0>;
> +	mem-supply = <&vdd_cpu_lit_mem_s0>;
> +};
> +
> +&cpu_l3 {
> +	cpu-supply = <&vdd_cpu_lit_s0>;
> +	mem-supply = <&vdd_cpu_lit_mem_s0>;
> +};
> +
> +&gmac1 {
> +	clock_in_out = "output";
> +	phy-handle = <&rgmii_phy1>;
> +	phy-mode = "rgmii-rxid";
> +	pinctrl-0 = <&gmac1_miim
> +					&gmac1_tx_bus2
> +					&gmac1_rx_bus2
> +					&gmac1_rgmii_clk
> +					&gmac1_rgmii_bus>;

Messed alignment.

> +	pinctrl-names = "default";
> +	snps,reset-gpio = <&gpio3 RK_PB2 GPIO_ACTIVE_LOW>;
> +	snps,reset-active-low;
> +	snps,reset-delays-us = <0 20000 100000>;
> +	tx_delay = <0x42>;
> +	status = "okay";
> +};
> +

...

> +
> +&sfc {
> +	pinctrl-0 = <&fspim0_pins>;
> +	pinctrl-names = "default";
> +	max-freq = <100000000>;
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	status = "okay";
> +
> +	spi_flash: spi-flash@0 {
> +		compatible = "jedec,spi-nor";
> +		reg = <0x0>;
> +		spi-max-frequency = <100000000>;
> +		spi-tx-bus-width = <1>;
> +		spi-rx-bus-width = <4>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		status = "okay";

okay is by default, was it disabled anywhere?

> +
> +		partitions {
> +			compatible = "fixed-partitions";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			loader@0 {
> +				label = "loader";
> +				reg = <0x0 0x1000000>;
> +			};
> +		};
> +	};
> +};
> +


Best regards,
Krzysztof

