Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7B877FCF0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 19:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353940AbjHQRY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 13:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353964AbjHQRYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 13:24:07 -0400
Received: from forward100a.mail.yandex.net (forward100a.mail.yandex.net [178.154.239.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E97BF;
        Thu, 17 Aug 2023 10:24:05 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net [IPv6:2a02:6b8:c18:58f:0:640:3768:0])
        by forward100a.mail.yandex.net (Yandex) with ESMTP id 8AB4542B22;
        Thu, 17 Aug 2023 20:23:59 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id eNlanO1DeiE0-BZ6ruBVo;
        Thu, 17 Aug 2023 20:23:58 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=6tel.net; s=mail; t=1692293038;
        bh=6YTQIq8NWPN5PQRtWMWS4gPfohHEdCmzLWqD6NAJA9Q=;
        h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=jKBXA2VfBZ6nR0VB2d7xFJmXh4Yo+atN/jZCG65qgU73pzixMg5N61F1Hlrz1rxF6
         TZoUP+7fpL65aZ6X1MHGciIwGi2oG78HZQAkxG/JbdVzWyVoBZD5JK3UzgZ7kCZgxJ
         7OhqUbRr+W3NylBuQ+7WVtzkS82LU/JI3AiibqoA=
Authentication-Results: mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net; dkim=pass header.i=@6tel.net
From:   Muhammed Efe Cetin <efectn@6tel.net>
To:     krzysztof.kozlowski@linaro.org
Cc:     conor+dt@kernel.org, devicetree@vger.kernel.org, efectn@6tel.net,
        heiko@sntech.de, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, robh+dt@kernel.org,
        sebastian.reichel@collabora.com
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: Add Orange Pi 5
Date:   Thu, 17 Aug 2023 20:23:34 +0300
Message-ID: <20230817172334.51831-1-efectn@6tel.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <a80a8f73-eef4-311b-c508-726956471880@linaro.org>
References: <a80a8f73-eef4-311b-c508-726956471880@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Thanks for review, i'll fix them and send v2 soon.

On 15.08.2023 16:45, Krzysztof Kozlowski wrote:
> On 15/08/2023 14:59, Muhammed Efe Cetin wrote:
>> Add initial support for OPi5 that includes support for USB2, PCIe2, Sata,
>> Sdmmc, SPI Flash, PMIC.
>>
>> Signed-off-by: Muhammed Efe Cetin <efectn@6tel.net>
>> ---
>>   .../boot/dts/rockchip/rk3588s-orangepi-5.dts  | 873 ++++++++++++++++++
> 
> Without Makefile this won't be build, so this was not ever tested.
> 
>>   1 file changed, 873 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dts
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dts b/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dts
>> new file mode 100644
>> index 000000000000..85071084a207
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dts
>> @@ -0,0 +1,873 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +
>> +/dts-v1/;
>> +
>> +#include <dt-bindings/pinctrl/rockchip.h>
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/input/input.h>
>> +#include "rk3588s.dtsi"
>> +
>> +/ {
>> +	model = "Xunlong Orange Pi 5";
>> +	compatible = "xunlong,orangepi-5", "rockchip,rk3588s";
>> +
>> +	aliases {
>> +		mmc0 = &sdmmc;
>> +		serial2 = &uart2;
>> +	};
>> +
>> +	chosen {
>> +		stdout-path = "serial2:1500000n8";
>> +	};
>> +
>> +	leds {
>> +		compatible = "gpio-leds";
>> +		pinctrl-names = "default";
>> +		pinctrl-0 =<&leds_gpio>;
>> +
>> +		led@1 {
> 
> Unit address is not correct here, it is not a bus. This should be
> reported as warning, so you did not check for warnings.
> 
> It does not look like you tested the DTS against bindings. Please run
> `make dtbs_check W=1` (see
> Documentation/devicetree/bindings/writing-schema.rst or
> https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
> for instructions).
> 
>> +			gpios = <&gpio1 RK_PA2 GPIO_ACTIVE_HIGH>;
>> +			label = "status_led";
>> +			linux,default-trigger = "heartbeat";
>> +			linux,default-trigger-delay-ms = <0>;
>> +		};
>> +	};
>> +
>> +	adc-keys {
>> +		compatible = "adc-keys";
>> +		io-channels = <&saradc 1>;
>> +		io-channel-names = "buttons";
>> +		keyup-threshold-microvolt = <1800000>;
>> +		poll-interval = <100>;
>> +
>> +		vol-up-key {
>> +			label = "volume up";
>> +			linux,code = <KEY_VOLUMEUP>;
>> +			press-threshold-microvolt = <17000>;
>> +		};
>> +
>> +		vol-down-key {
>> +			label = "volume down";
>> +			linux,code = <KEY_VOLUMEDOWN>;
>> +			press-threshold-microvolt = <417000>;
>> +		};
>> +
>> +		menu-key {
>> +			label = "menu";
>> +			linux,code = <KEY_MENU>;
>> +			press-threshold-microvolt = <890000>;
>> +		};
>> +
>> +		back-key {
>> +			label = "back";
>> +			linux,code = <KEY_BACK>;
>> +			press-threshold-microvolt = <1235000>;
>> +		};
>> +	};
>> +
>> +	backlight: backlight {
>> +		compatible = "pwm-backlight";
>> +		brightness-levels = <  0  20  20  21  21  22  22  23
>> +					  23  24  24  25  25  26  26  27
>> +					  27  28  28  29  29  30  30  31
>> +					  31  32  32  33  33  34  34  35
>> +					  35  36  36  37  37  38  38  39
>> +					  40  41  42  43  44  45  46  47
>> +					  48  49  50  51  52  53  54  55
>> +					  56  57  58  59  60  61  62  63
>> +					  64  65  66  67  68  69  70  71
>> +					  72  73  74  75  76  77  78  79
>> +					  80  81  82  83  84  85  86  87
>> +					  88  89  90  91  92  93  94  95
>> +					  96  97  98  99 100 101 102 103
>> +					  104 105 106 107 108 109 110 111
>> +					  112 113 114 115 116 117 118 119
>> +					  120 121 122 123 124 125 126 127
>> +					  128 129 130 131 132 133 134 135
>> +					  136 137 138 139 140 141 142 143
>> +					  144 145 146 147 148 149 150 151
>> +					  152 153 154 155 156 157 158 159
>> +					  160 161 162 163 164 165 166 167
>> +					  168 169 170 171 172 173 174 175
>> +					  176 177 178 179 180 181 182 183
>> +					  184 185 186 187 188 189 190 191
>> +					  192 193 194 195 196 197 198 199
>> +					  200 201 202 203 204 205 206 207
>> +					  208 209 210 211 212 213 214 215
>> +					  216 217 218 219 220 221 222 223
>> +					  224 225 226 227 228 229 230 231
>> +					  232 233 234 235 236 237 238 239
>> +					  240 241 242 243 244 245 246 247
>> +					  248 249 250 251 252 253 254 255>;
>> +		default-brightness-level = <200>;
>> +		pwms = <&pwm2 0 25000 0>;
>> +	};
>> +
>> +	backlight_1: backlight_1 {
> 
> No underscores in node names, use -
> 
>> +		compatible = "pwm-backlight";
>> +		brightness-levels = <  0  20  20  21  21  22  22  23
>> +					  23  24  24  25  25  26  26  27
>> +					  27  28  28  29  29  30  30  31
> 
> ...
> 
>> +
>> +&combphy0_ps {
>> +	status = "okay";
>> +};
>> +
>> +&combphy2_psu {
>> +	status = "okay";
>> +};
>> +
>> +&cpu_b0 {
>> +	cpu-supply = <&vdd_cpu_big0_s0>;
>> +	mem-supply = <&vdd_cpu_big0_mem_s0>;
>> +};
>> +
>> +&cpu_b1 {
>> +	cpu-supply = <&vdd_cpu_big0_s0>;
>> +	mem-supply = <&vdd_cpu_big0_mem_s0>;
>> +};
>> +
>> +&cpu_b2 {
>> +	cpu-supply = <&vdd_cpu_big1_s0>;
>> +	mem-supply = <&vdd_cpu_big1_mem_s0>;
>> +};
>> +
>> +&cpu_b3 {
>> +	cpu-supply = <&vdd_cpu_big1_s0>;
>> +	mem-supply = <&vdd_cpu_big1_mem_s0>;
>> +};
>> +
>> +&cpu_l0 {
>> +	cpu-supply = <&vdd_cpu_lit_s0>;
>> +	mem-supply = <&vdd_cpu_lit_mem_s0>;
>> +};
>> +
>> +&cpu_l1 {
>> +	cpu-supply = <&vdd_cpu_lit_s0>;
>> +	mem-supply = <&vdd_cpu_lit_mem_s0>;
>> +};
>> +
>> +&cpu_l2 {
>> +	cpu-supply = <&vdd_cpu_lit_s0>;
>> +	mem-supply = <&vdd_cpu_lit_mem_s0>;
>> +};
>> +
>> +&cpu_l3 {
>> +	cpu-supply = <&vdd_cpu_lit_s0>;
>> +	mem-supply = <&vdd_cpu_lit_mem_s0>;
>> +};
>> +
>> +&gmac1 {
>> +	clock_in_out = "output";
>> +	phy-handle = <&rgmii_phy1>;
>> +	phy-mode = "rgmii-rxid";
>> +	pinctrl-0 = <&gmac1_miim
>> +					&gmac1_tx_bus2
>> +					&gmac1_rx_bus2
>> +					&gmac1_rgmii_clk
>> +					&gmac1_rgmii_bus>;
> 
> Messed alignment.
> 
>> +	pinctrl-names = "default";
>> +	snps,reset-gpio = <&gpio3 RK_PB2 GPIO_ACTIVE_LOW>;
>> +	snps,reset-active-low;
>> +	snps,reset-delays-us = <0 20000 100000>;
>> +	tx_delay = <0x42>;
>> +	status = "okay";
>> +};
>> +
> 
> ...
> 
>> +
>> +&sfc {
>> +	pinctrl-0 = <&fspim0_pins>;
>> +	pinctrl-names = "default";
>> +	max-freq = <100000000>;
>> +	#address-cells = <1>;
>> +	#size-cells = <0>;
>> +	status = "okay";
>> +
>> +	spi_flash: spi-flash@0 {
>> +		compatible = "jedec,spi-nor";
>> +		reg = <0x0>;
>> +		spi-max-frequency = <100000000>;
>> +		spi-tx-bus-width = <1>;
>> +		spi-rx-bus-width = <4>;
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +		status = "okay";
> 
> okay is by default, was it disabled anywhere?
> 
>> +
>> +		partitions {
>> +			compatible = "fixed-partitions";
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +
>> +			loader@0 {
>> +				label = "loader";
>> +				reg = <0x0 0x1000000>;
>> +			};
>> +		};
>> +	};
>> +};
>> +
> 
> 
> Best regards,
> Krzysztof
> 

Regards,
Efe

