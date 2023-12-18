Return-Path: <linux-kernel+bounces-2888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8BD8163C6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 01:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30F84B21A9C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 00:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0839BA2D;
	Mon, 18 Dec 2023 00:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KvgYyFQQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438E8628;
	Mon, 18 Dec 2023 00:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-77f50307a1fso233498485a.3;
        Sun, 17 Dec 2023 16:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702859146; x=1703463946; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d2dgbHqKqOooANmUi7+6zI6/vCPSVaeEIUE45T2aF8E=;
        b=KvgYyFQQyOdg9lLTDgDVS5i/9tKalcu+3X5EL9L2hxOUh+qumcNr8ywpT96tKrh/Ud
         utyIIKtnmYpTtyOHT5tLirZVASHzP4pASHGGwoX4a4yjj4Kg3ajzeeBfJMcWh8n92Q9e
         755wCK3oUkkVuJmcCXQrmb2+fNj6wr76IILNbt3fowj7BOIgSYC1y8bSSdKpRiotS+d4
         1JPmfYv1ZjwXY6YL8oRXk/9unQBu1gdr8NUNtVal8F8ZQVpitW0d0i3J2b3Q5nCIBQUu
         dUNo6mW76ZVW+2W+hQ3huhZRZsxqMOESOyym/VaKaA24p8mPNGXxMv5Grwe1Di2lXKBY
         t/PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702859146; x=1703463946;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d2dgbHqKqOooANmUi7+6zI6/vCPSVaeEIUE45T2aF8E=;
        b=K1x9SnsMb0zjCiuNCZxX3HDMSuyrGVp562U8N6BTXyTpZm3oMlPWxEBLZfZMTCeULe
         quviUQ93D2kGXX8VDbwUIaXoZTfwpoLQSD1F7kMZzX2ug5qffTt/B2ZPaWn8TyvPgsXj
         ApmtwWdBx5zZ8PXi6qLoDejCYgjNMlrKRkT99AF3oBYLsRrfpMXM7mwvrqklJgGhLJZ1
         fOooXlt7IGzbU+o3IgX17bpBRgfvKv8Vp2vcXMPqfJOXiC75+ryiHc9q+zyjbnUF/CaN
         imwiCEwcH+PemrdUyi2+GrRCNYjp35SwINAntYaZ+cznf/HgTeByIVKEbe/QJFUJt582
         2OUg==
X-Gm-Message-State: AOJu0YzymLlS8LJ0Y5llehO+rrFfVVm4uHACPOr326K0XK6bS3ezwVj7
	SUaVB7cUqpfAFSg6P7olb2c=
X-Google-Smtp-Source: AGHT+IGtBOEQs+PB20vUfDb+rfoLohqPy39cT2sb97YjV0+ju+5bvyEVyTVcTd7z/h8+jjlXaw3jTg==
X-Received: by 2002:ae9:f808:0:b0:77e:fba3:9d1a with SMTP id x8-20020ae9f808000000b0077efba39d1amr16813398qkh.126.1702859145922;
        Sun, 17 Dec 2023 16:25:45 -0800 (PST)
Received: from [192.168.20.212] (107-015-241-140.res.spectrum.com. [107.15.241.140])
        by smtp.gmail.com with ESMTPSA id uw2-20020a05620a4d8200b0077f103c8ad6sm7895662qkn.82.2023.12.17.16.25.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Dec 2023 16:25:45 -0800 (PST)
Message-ID: <9a6dd3ac-acb1-2222-918a-d325c56bbded@gmail.com>
Date: Sun, 17 Dec 2023 19:25:43 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 2/3] arm64: dts: rockchip: Add support for NanoPi R6S
Content-Language: en-US
To: efectn@6tel.net, linux-rockchip@lists.infradead.org
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, heiko@sntech.de,
 sebastian.reichel@collabora.com, jonas@kwiboo.se,
 Muhammed Efe Cetin <efectn@protonmail.com>
References: <cover.1702647349.git.efectn@protonmail.com>
 <25d84712ee3765f5f28dfd355a2392f20f388824.1702647349.git.efectn@protonmail.com>
From: John Clark <inindev@gmail.com>
In-Reply-To: <25d84712ee3765f5f28dfd355a2392f20f388824.1702647349.git.efectn@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/15/23 8:55 AM, efectn@6tel.net wrote:

> From: Muhammed Efe Cetin <efectn@protonmail.com>
>
> Add basic NanoPi R6S support that comes with USB2, PCIe, SD card, eMMC
> support.
>
> Signed-off-by: Muhammed Efe Cetin <efectn@protonmail.com>
> ---
>   arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>   .../boot/dts/rockchip/rk3588s-nanopi-r6s.dts  | 755 ++++++++++++++++++
>   2 files changed, 756 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6s.dts
>
> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> index 600c420bc..ed2583dcd 100644
> --- a/arch/arm64/boot/dts/rockchip/Makefile
> +++ b/arch/arm64/boot/dts/rockchip/Makefile
> @@ -114,3 +114,4 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-indiedroid-nova.dtb
>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-khadas-edge2.dtb
>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-rock-5a.dtb
>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-orangepi-5.dtb
> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-nanopi-r6s.dtb
> \ No newline at end of file
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6s.dts b/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6s.dts
> new file mode 100644
> index 000000000..e575cc403
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6s.dts
> @@ -0,0 +1,755 @@
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
> +	model = "FriendlyElec NanoPi R6S";
> +	compatible = "friendlyelec,nanopi-r6s", "rockchip,rk3588s";
> +
> +	aliases {
> +		ethernet0 = &gmac1;
> +		mmc0 = &sdmmc;
> +		mmc1 = &sdhci;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial2:1500000n8";
> +	};
> +
> +	adc-keys {
> +		compatible = "adc-keys";
> +		io-channels = <&saradc 0>;
> +		io-channel-names = "buttons";
> +		keyup-threshold-microvolt = <1800000>;
> +		poll-interval = <100>;
> +
> +		button-maskrom {
> +			label = "Maskrom";
> +			linux,code = <KEY_VENDOR>;
> +			press-threshold-microvolt = <1800>;
> +		};
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&key1_pin>;
> +
> +		button-user {
> +			label = "User";
> +			linux,code = <BTN_1>;
> +			gpios = <&gpio1 RK_PC0 GPIO_ACTIVE_LOW>;
> +			debounce-interval = <50>;
> +		};
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		sys_led: led-0 {
> +			label = "sys_led";
> +			gpios = <&gpio1 RK_PC1 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "heartbeat";
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&sys_led_pin>;
> +		};
> +
> +		wan_led: led-1 {
> +			label = "wan_led";
> +			gpios = <&gpio1 RK_PC2 GPIO_ACTIVE_HIGH>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&wan_led_pin>;
> +		};
> +
> +		lan1_led: led-2 {
> +			label = "lan1_led";
> +			gpios = <&gpio1 RK_PC3 GPIO_ACTIVE_HIGH>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&lan1_led_pin>;
> +		};
> +
> +		lan2_led: led-3 {
> +			label = "lan2_led";
> +			gpios = <&gpio1 RK_PC4 GPIO_ACTIVE_HIGH>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&lan2_led_pin>;
> +		};
> +	};
> +
> +	vcc5v0_sys: vcc5v0-sys-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc5v0_sys";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +	};
> +
> +	vcc_1v1_nldo_s3: vcc-1v1-nldo-s3-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc_1v1_nldo_s3";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <1100000>;
> +		regulator-max-microvolt = <1100000>;
> +		vin-supply = <&vcc5v0_sys>;
> +	};
> +
> +	vcc_3v3_sd_s0: vcc-3v3-sd-s0-regulator {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpios = <&gpio4 RK_PB4 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&sd_s0_pwr>;
> +		regulator-name = "vcc_3v3_sd_s0";
> +		regulator-boot-on;
> +		regulator-max-microvolt = <3000000>;
> +		regulator-min-microvolt = <3000000>;
> +		vin-supply = <&vcc_3v3_s3>;
> +	};
> +
> +	vcc_3v3_pcie20: vcc3v3-pcie20-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc_3v3_pcie20";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&vcc_3v3_s3>;
> +	};
> +
> +	vcc5v0_usb: vcc5v0-usb-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc5v0_usb";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&vcc5v0_sys>;
> +	};
> +
> +	vcc5v0_usb_otg0: vcc5v0-usb-otg0-regulator {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpios = <&gpio1 RK_PD2 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&typec5v_pwren>;
> +		regulator-name = "vcc5v0_usb_otg0";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&vcc5v0_usb>;
> +	};
> +
> +	vcc5v0_host_20: vcc5v0-host-20-regulator {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpios = <&gpio4 RK_PB5 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vcc5v0_host20_en>;
> +		regulator-name = "vcc5v0_host_20";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&vcc5v0_usb>;
> +	};
> +};
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
> +};
> +
> +&cpu_b1 {
> +	cpu-supply = <&vdd_cpu_big0_s0>;
> +};
> +
> +&cpu_b2 {
> +	cpu-supply = <&vdd_cpu_big1_s0>;
> +};
> +
> +&cpu_b3 {
> +	cpu-supply = <&vdd_cpu_big1_s0>;
> +};
> +
> +&cpu_l0 {
> +	cpu-supply = <&vdd_cpu_lit_s0>;
> +};
> +
> +&cpu_l1 {
> +	cpu-supply = <&vdd_cpu_lit_s0>;
> +};
> +
> +&cpu_l2 {
> +	cpu-supply = <&vdd_cpu_lit_s0>;
> +};
> +
> +&cpu_l3 {
> +	cpu-supply = <&vdd_cpu_lit_s0>;
> +};
> +
> +&gmac1 {
> +	clock_in_out = "output";
> +	phy-handle = <&rgmii_phy1>;
> +	phy-mode = "rgmii-rxid";
> +	pinctrl-0 = <&gmac1_miim
> +		     &gmac1_tx_bus2
> +		     &gmac1_rx_bus2
> +		     &gmac1_rgmii_clk
> +		     &gmac1_rgmii_bus>;
> +	pinctrl-names = "default";
> +	tx_delay = <0x42>;
> +	status = "okay";
> +};
> +
> +&i2c0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c0m2_xfer>;
> +	status = "okay";
> +
> +	vdd_cpu_big0_s0: regulator@42 {
> +		compatible = "rockchip,rk8602";
> +		reg = <0x42>;
> +		fcs,suspend-voltage-selector = <1>;
> +		regulator-name = "vdd_cpu_big0_s0";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <550000>;
> +		regulator-max-microvolt = <1050000>;
> +		regulator-ramp-delay = <2300>;
> +		vin-supply = <&vcc5v0_sys>;
> +
> +		regulator-state-mem {
> +			regulator-off-in-suspend;
> +		};
> +	};
> +
> +	vdd_cpu_big1_s0: regulator@43 {
> +		compatible = "rockchip,rk8603", "rockchip,rk8602";
> +		reg = <0x43>;
> +		fcs,suspend-voltage-selector = <1>;
> +		regulator-name = "vdd_cpu_big1_s0";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <550000>;
> +		regulator-max-microvolt = <1050000>;
> +		regulator-ramp-delay = <2300>;
> +		vin-supply = <&vcc5v0_sys>;
> +
> +		regulator-state-mem {
> +			regulator-off-in-suspend;
> +		};
> +	};
> +};
> +
> +&i2c2 {
> +	status = "okay";
> +
> +	vdd_npu_s0: rk8602@42 {
> +		compatible = "rockchip,rk8602";
> +		reg = <0x42>;
> +		fcs,suspend-voltage-selector = <1>;
> +		regulator-compatible = "rk860x-reg";
> +		regulator-name = "vdd_npu_s0";
> +		regulator-min-microvolt = <550000>;
> +		regulator-max-microvolt = <950000>;
> +		regulator-ramp-delay = <2300>;
> +		regulator-boot-on;
> +		regulator-always-on;
> +		vin-supply = <&vcc5v0_sys>;
> +
> +		regulator-state-mem {
> +			regulator-off-in-suspend;
> +		};
> +	};
> +};
> +
> +&i2c6 {
> +	clock-frequency = <200000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c6m0_xfer>;
> +	status = "okay";
> +
> +	hym8563: rtc@51 {
> +		compatible = "haoyu,hym8563";
> +		reg = <0x51>;
> +		#clock-cells = <0>;
> +		clock-output-names = "hym8563";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&rtc_int>;
> +		interrupt-parent = <&gpio0>;
> +		interrupts = <RK_PB0 IRQ_TYPE_LEVEL_LOW>;
> +		wakeup-source;
> +	};
> +};
> +
> +&mdio1 {
> +	rgmii_phy1: ethernet-phy@1 {
> +		compatible = "ethernet-phy-id001c.c916";
> +		reg = <0x1>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&rtl8211f_rst>;
> +		reset-assert-us = <20000>;
> +		reset-deassert-us = <100000>;
> +		reset-gpios = <&gpio3 RK_PB7 GPIO_ACTIVE_LOW>;
> +	};
> +};
> +
> +&pcie2x1l1 {
> +	reset-gpios = <&gpio1 RK_PA7 GPIO_ACTIVE_HIGH>;
> +	vpcie3v3-supply = <&vcc_3v3_pcie20>;
> +	status = "okay";
> +};
> +
> +&pcie2x1l2 {
> +	reset-gpios = <&gpio3 RK_PD1 GPIO_ACTIVE_HIGH>;
> +	vpcie3v3-supply = <&vcc_3v3_pcie20>;
> +	status = "okay";
> +};
> +
> +&pinctrl {
> +	gpio-key {
> +		key1_pin: key1-pin {
> +			rockchip,pins = <1 RK_PC0 RK_FUNC_GPIO &pcfg_pull_up>;
> +		};
> +	};
> +
> +	gpio-leds {
> +		sys_led_pin: sys-led-pin {
> +			rockchip,pins =
> +				<1 RK_PC1 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		wan_led_pin: wan-led-pin {
> +			rockchip,pins =
> +				<1 RK_PC2 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		lan1_led_pin: lan1-led-pin {
> +			rockchip,pins =
> +				<1 RK_PC3 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		lan2_led_pin: lan2-led-pin {
> +			rockchip,pins =
> +				<1 RK_PC4 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	hym8563 {
> +		rtc_int: rtc-int {
> +			rockchip,pins = <0 RK_PB0 RK_FUNC_GPIO &pcfg_pull_up>;
> +		};
> +	};
> +
> +	sdmmc {
> +		sd_s0_pwr: sd-s0-pwr {
> +			rockchip,pins = <4 RK_PB4 RK_FUNC_GPIO &pcfg_pull_up>;
> +		};
> +	};
> +
> +	usb {
> +		typec5v_pwren: typec5v-pwren {
> +			rockchip,pins = <1 RK_PD2 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		vcc5v0_host20_en: vcc5v0-host20-en {
> +			rockchip,pins = <4 RK_PB5 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	rtl8211f {
> +		rtl8211f_rst: rtl8211f-rst {
> +			rockchip,pins = <3 RK_PB7 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +};
> +
> +&saradc {
> +	vref-supply = <&avcc_1v8_s0>;
> +	status = "okay";
> +};
> +
> +&sdhci {
> +	bus-width = <8>;
> +	no-sdio;
> +	no-sd;
> +	non-removable;
> +	mmc-hs200-1_8v;
> +	max-frequency = <200000000>;
> +	status = "okay";
> +};
> +
> +&sdmmc {
> +	bus-width = <4>;
> +	cap-sd-highspeed;
> +	disable-wp;
> +	max-frequency = <150000000>;
> +	no-mmc;
> +	no-sdio;
> +	sd-uhs-sdr104;
> +	vmmc-supply = <&vcc_3v3_sd_s0>;
> +	vqmmc-supply = <&vccio_sd_s0>;
> +	status = "okay";
> +};
> +
> +&spi2 {
> +	status = "okay";
> +	assigned-clocks = <&cru CLK_SPI2>;
> +	assigned-clock-rates = <200000000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&spi2m2_cs0 &spi2m2_pins>;
> +	num-cs = <1>;
> +
> +	pmic@0 {
> +		compatible = "rockchip,rk806";
> +		spi-max-frequency = <1000000>;
> +		reg = <0x0>;
> +
> +		interrupt-parent = <&gpio0>;
> +		interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pmic_pins>, <&rk806_dvs1_null>,
> +			    <&rk806_dvs2_null>, <&rk806_dvs3_null>;
> +
> +		vcc1-supply = <&vcc5v0_sys>;
> +		vcc2-supply = <&vcc5v0_sys>;
> +		vcc3-supply = <&vcc5v0_sys>;
> +		vcc4-supply = <&vcc5v0_sys>;
> +		vcc5-supply = <&vcc5v0_sys>;
> +		vcc6-supply = <&vcc5v0_sys>;
> +		vcc7-supply = <&vcc5v0_sys>;
> +		vcc8-supply = <&vcc5v0_sys>;
> +		vcc9-supply = <&vcc5v0_sys>;
> +		vcc10-supply = <&vcc5v0_sys>;
> +		vcc11-supply = <&vcc_2v0_pldo_s3>;
> +		vcc12-supply = <&vcc5v0_sys>;
> +		vcc13-supply = <&vcc_1v1_nldo_s3>;
> +		vcc14-supply = <&vcc_1v1_nldo_s3>;
> +		vcca-supply = <&vcc5v0_sys>;
> +
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +
> +		rk806_dvs1_null: dvs1-null-pins {
> +			pins = "gpio_pwrctrl2";
> +			function = "pin_fun0";
> +		};
> +
> +		rk806_dvs2_null: dvs2-null-pins {
> +			pins = "gpio_pwrctrl2";
> +			function = "pin_fudr_moden0";
> +		};
> +
> +		rk806_dvs3_null: dvs3-null-pins {
> +			pins = "gpio_pwrctrl3";
> +			function = "pin_fun0";
> +		};
> +
> +		regulators {
> +			vdd_gpu_s0: vdd_gpu_mem_s0: dcdc-reg1 {
> +				regulator-boot-on;
> +				regulator-min-microvolt = <550000>;
> +				regulator-max-microvolt = <950000>;
> +				regulator-ramp-delay = <12500>;
> +				regulator-name = "vdd_gpu_s0";
> +				regulator-enable-ramp-delay = <400>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vdd_cpu_lit_s0: vdd_cpu_lit_mem_s0: dcdc-reg2 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <550000>;
> +				regulator-max-microvolt = <950000>;
> +				regulator-ramp-delay = <12500>;
> +				regulator-name = "vdd_cpu_lit_s0";
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vdd_log_s0: dcdc-reg3 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <675000>;
> +				regulator-max-microvolt = <750000>;
> +				regulator-ramp-delay = <12500>;
> +				regulator-name = "vdd_log_s0";
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +					regulator-suspend-microvolt = <750000>;
> +				};
> +			};
> +
> +			vdd_vdenc_s0: vdd_vdenc_mem_s0: dcdc-reg4 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <550000>;
> +				regulator-max-microvolt = <950000>;
> +				regulator-init-microvolt = <750000>;
> +				regulator-ramp-delay = <12500>;
> +				regulator-name = "vdd_vdenc_s0";
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vdd_ddr_s0: dcdc-reg5 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <675000>;
> +				regulator-max-microvolt = <900000>;
> +				regulator-ramp-delay = <12500>;
> +				regulator-name = "vdd_ddr_s0";
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +					regulator-suspend-microvolt = <850000>;
> +				};
> +			};
> +
> +			vdd2_ddr_s3: dcdc-reg6 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-name = "vdd2_ddr_s3";
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +				};
> +			};
> +
> +			vcc_2v0_pldo_s3: dcdc-reg7 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <2000000>;
> +				regulator-max-microvolt = <2000000>;
> +				regulator-ramp-delay = <12500>;
> +				regulator-name = "vdd_2v0_pldo_s3";
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <2000000>;
> +				};
> +			};
> +
> +			vcc_3v3_s3: dcdc-reg8 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-name = "vcc_3v3_s3";
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <3300000>;
> +				};
> +			};
> +
> +			vddq_ddr_s0: dcdc-reg9 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-name = "vddq_ddr_s0";
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vcc_1v8_s3: dcdc-reg10 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-name = "vcc_1v8_s3";
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <1800000>;
> +				};
> +			};
> +
> +			avcc_1v8_s0: pldo-reg1 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-name = "avcc_1v8_s0";
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +					regulator-suspend-microvolt = <1800000>;
> +				};
> +			};
> +
> +			vcc_1v8_s0: pldo-reg2 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-name = "vcc_1v8_s0";
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +					regulator-suspend-microvolt = <1800000>;
> +				};
> +			};
> +
> +			avdd_1v2_s0: pldo-reg3 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <1200000>;
> +				regulator-max-microvolt = <1200000>;
> +				regulator-name = "avdd_1v2_s0";
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vcc_3v3_s0: pldo-reg4 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-ramp-delay = <12500>;
> +				regulator-name = "vcc_3v3_s0";
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};

The device located at pldo-reg4 is named vcc_3v3_s0

Page 2 of the schematic identifies pldo-reg4 as VCCA_3V3_S0

Therefore, the pldo-reg4 device should be named avcc_3v3_s0 and a 
separate definition for vcc_3v3_s0 should be created.

vcc_3v3_s0 is defined on page 18 as SY6280AAC and is supplied by vcc_3v3_s3

this would be a fixed regulator like:

vcc_3v3_s0: vcc-3v3-s0 {
         compatible = "regulator-fixed";
         regulator-always-on;
         regulator-boot-on;
         regulator-min-microvolt = <3300000>;
         regulator-max-microvolt = <3300000>;
         regulator-name = "vcc_3v3_s0";
         vin-supply = <&vcc_3v3_s3>;
};

schematic: 
https://wiki.friendlyelec.com/wiki/images/f/f7/NanoPi_R6C_2302_SCH.PDF

> +
> +			vccio_sd_s0: pldo-reg5 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-ramp-delay = <12500>;
> +				regulator-name = "vccio_sd_s0";
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			pldo6_s3: pldo-reg6 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-name = "pldo6_s3";
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <1800000>;
> +				};
> +			};
> +
> +			vdd_0v75_s3: nldo-reg1 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <750000>;
> +				regulator-max-microvolt = <750000>;
> +				regulator-name = "vdd_0v75_s3";
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <750000>;
> +				};
> +			};
> +
> +			vdd_ddr_pll_s0: nldo-reg2 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <850000>;
> +				regulator-max-microvolt = <850000>;
> +				regulator-name = "vdd_ddr_pll_s0";
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +					regulator-suspend-microvolt = <850000>;
> +				};
> +			};

similar, see page 2 of schematic: vdd_ddr_pll_s0: nldo-reg2 -> 
avdd_ddr_pll_s0


> +
> +			avdd_0v75_s0: nldo-reg3 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <750000>;
> +				regulator-max-microvolt = <750000>;
> +				regulator-name = "avdd_0v75_s0";
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vdd_0v85_s0: nldo-reg4 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <850000>;
> +				regulator-max-microvolt = <850000>;
> +				regulator-name = "vdd_0v85_s0";
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};

similar, see page 2 of schematic: vdd_0v85_s0: nldo-reg4 -> avdd_0v85_s0


> +
> +			vdd_0v75_s0: nldo-reg5 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <750000>;
> +				regulator-max-microvolt = <750000>;
> +				regulator-name = "vdd_0v75_s0";
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +		};
> +	};
> +};
> +
> +&tsadc {
> +	status = "okay";
> +};
> +
> +&u2phy2 {
> +	status = "okay";
> +};
> +
> +&u2phy2_host {
> +	phy-supply = <&vcc5v0_host_20>;
> +	status = "okay";
> +};
> +
> +&uart2 {
> +	pinctrl-0 = <&uart2m0_xfer>;
> +	status = "okay";
> +};
> +
> +&usb_host0_ehci {
> +	status = "okay";
> +};
> +
> +&usb_host0_ohci {
> +	status = "okay";
> +};

