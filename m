Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE0827CF45B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 11:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345167AbjJSJr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 05:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345142AbjJSJrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 05:47:53 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E69212D;
        Thu, 19 Oct 2023 02:47:48 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7CBE66607322;
        Thu, 19 Oct 2023 10:47:46 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697708867;
        bh=7xiLgAWwIFk1dFnXbidKZdiKZFn6z3+04VFtX1qgSoI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=HvIohbwJ2OfW94AAQrEP5PzNrbL3nTN+pffivZuv499dlR2NlQrkZiq9HPxswq6N3
         8fwITaPlr6/36suCI+7Xe/qiz/n681C27/zh62hadNwXfX1ji3cL7cz75Ku9H5S/kI
         qlF33fLU6SqBIiLGYeqAesGD5ut5yOHkk/0238xzWAKMgiw0F0OwWHP2ywF4fXOdqK
         w07HSWC+XPGn5ezVpCwMY47qmSsisk6nArLJWfDgR3NOoxx/fVIQYNYkMkLCfpuF8b
         jWQQ1i6aqBCjfSHge7j4J90pr1aOevtbuV+Ae8Sx+jZvYRsvQVPuszhe3/LHYjKs1b
         NrBv0expeLG1g==
Message-ID: <69a0bd5c-58ef-4fb2-a8c8-35f6e277f76b@collabora.com>
Date:   Thu, 19 Oct 2023 11:47:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/4] arm64: dts: Add MediaTek MT8188 dts and evaluation
 board and Makefile
Content-Language: en-US
To:     Jason-ch Chen <jason-ch.chen@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Eugen Hristev <eugen.hristev@collabora.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Alexandre Mergnat <amergnat@baylibre.com>
Cc:     =?UTF-8?Q?N=C3=ADcolas_F_=2E_R_=2E_A_=2E_Prado?= 
        <nfraprado@collabora.com>, Chen-Yu Tsai <wenst@chromium.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20231019075458.28290-1-jason-ch.chen@mediatek.com>
 <20231019075458.28290-5-jason-ch.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231019075458.28290-5-jason-ch.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 19/10/23 09:54, Jason-ch Chen ha scritto:
> From: jason-ch chen <Jason-ch.Chen@mediatek.com>
> 
> MT8188 is a SoC based on 64bit ARMv8 architecture. It contains 6 CA55
> and 2 CA78 cores. MT8188 share many HW IP with MT65xx series.
> 
> We add basic chip support for MediaTek MT8188 on evaluation board.
> 
> Signed-off-by: jason-ch chen <Jason-ch.Chen@mediatek.com>
> ---
>   arch/arm64/boot/dts/mediatek/Makefile       |   1 +
>   arch/arm64/boot/dts/mediatek/mt8188-evb.dts | 388 ++++++++
>   arch/arm64/boot/dts/mediatek/mt8188.dtsi    | 949 ++++++++++++++++++++
>   3 files changed, 1338 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-evb.dts
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8188.dtsi
> 
> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
> index e6e7592a3645..8900b939ed52 100644
> --- a/arch/arm64/boot/dts/mediatek/Makefile
> +++ b/arch/arm64/boot/dts/mediatek/Makefile
> @@ -44,6 +44,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-krane-sku0.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-krane-sku176.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-pumpkin.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-evb.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt8188-evb.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-asurada-hayato-r1.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-asurada-hayato-r5-sku2.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-asurada-spherion-r0.dtb
> diff --git a/arch/arm64/boot/dts/mediatek/mt8188-evb.dts b/arch/arm64/boot/dts/mediatek/mt8188-evb.dts
> new file mode 100644
> index 000000000000..773bf84cfb94
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8188-evb.dts
> @@ -0,0 +1,388 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (C) 2023 MediaTek Inc.
> + */
> +/dts-v1/;
> +#include "mt8188.dtsi"
> +#include "mt6359.dtsi"
> +
> +/ {
> +	model = "MediaTek MT8188 evaluation board";
> +	compatible = "mediatek,mt8188-evb", "mediatek,mt8188";
> +
> +	aliases {
> +		serial0 = &uart0;
> +		i2c0 = &i2c0;
> +		i2c1 = &i2c1;
> +		i2c2 = &i2c2;
> +		i2c3 = &i2c3;
> +		i2c4 = &i2c4;
> +		i2c5 = &i2c5;
> +		i2c6 = &i2c6;
> +		mmc0 = &mmc0;
> +	};
> +
> +	chosen: chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	memory@40000000 {
> +		device_type = "memory";
> +		reg = <0 0x40000000 0 0x80000000>;
> +	};
> +
> +	reserved_memory: reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		scp_mem_reserved: memory@50000000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0 0x50000000 0 0x2900000>;
> +			no-map;
> +		};
> +	};
> +};
> +
> +&auxadc {
> +	status = "okay";
> +};
> +
> +&i2c0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c0_pins>;
> +	clock-frequency = <400000>;
> +	status = "okay";
> +};
> +
> +&i2c1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c1_pins>;
> +	clock-frequency = <400000>;
> +	status = "okay";
> +};
> +
> +&i2c2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c2_pins>;
> +	clock-frequency = <400000>;
> +	status = "okay";
> +};
> +
> +&i2c3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c3_pins>;
> +	clock-frequency = <400000>;
> +	status = "okay";
> +};
> +
> +&i2c4 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c4_pins>;
> +	clock-frequency = <400000>;
> +	status = "okay";
> +};
> +
> +&i2c5 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c5_pins>;
> +	clock-frequency = <400000>;
> +	status = "okay";
> +};
> +
> +&i2c6 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c6_pins>;
> +	clock-frequency = <400000>;
> +	status = "okay";
> +};
> +
> +&mmc0 {
> +	status = "okay";
> +	pinctrl-names = "default", "state_uhs";
> +	pinctrl-0 = <&mmc0_default_pins>;
> +	pinctrl-1 = <&mmc0_uhs_pins>;
> +	bus-width = <8>;
> +	max-frequency = <200000000>;

...that's how it should be ordered:

&mmc0 {
	bus-width = <8>;
	hs400-ds-delay = <0x1481b>;
	max-frequency = <200000000>;

	cap-mmc-highspeed;
	cap-mmc-hw-reset;
	mmc-hs200-1_8v;
	mmc-hs400-1_8v;
	no-sdio;
	no-sd;
	non-removable;

	vmmc-supply = ...
	vqmmc-supply = ...

	pinctrl-0 ...
	pinctrl-1 ...
	pinctrl-names ...

	status = "okay";
};

> +	cap-mmc-highspeed;
> +	mmc-hs200-1_8v;
> +	mmc-hs400-1_8v;
> +	supports-cqe;
> +	cap-mmc-hw-reset;
> +	no-sdio;
> +	no-sd;
> +	hs400-ds-delay = <0x1481b>;
> +	vmmc-supply = <&mt6359_vemc_1_ldo_reg>;
> +	vqmmc-supply = <&mt6359_vufs_ldo_reg>;
> +	non-removable;
> +};
> +
> +&mt6359_vcore_buck_reg {
> +	regulator-always-on;
> +};
> +
> +&mt6359_vgpu11_buck_reg {
> +	regulator-always-on;
> +};
> +
> +&mt6359_vpu_buck_reg {
> +	regulator-always-on;
> +};
> +
> +&mt6359_vrf12_ldo_reg {
> +	regulator-always-on;
> +};
> +
> +&nor_flash {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&nor_pins_default>;
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	flash@0 {
> +		compatible = "jedec,spi-nor";
> +		reg = <0>;
> +		spi-max-frequency = <52000000>;
> +	};
> +};
> +
> +&pio {
> +	adsp_uart_pins: adsp-uart-pins {
> +		pins-adsp-uart {

pins-tx-rx {

> +			pinmux = <PINMUX_GPIO35__FUNC_O_ADSP_UTXD0>,
> +				 <PINMUX_GPIO36__FUNC_I1_ADSP_URXD0>;
> +		};
> +	};
> +

..snip..

> +
> +	mmc0_uhs_pins: mmc0-uhs-pins {
> +		pins-cmd-dat {
> +			pinmux = <PINMUX_GPIO161__FUNC_B1_MSDC0_DAT0>,
> +				 <PINMUX_GPIO160__FUNC_B1_MSDC0_DAT1>,
> +				 <PINMUX_GPIO159__FUNC_B1_MSDC0_DAT2>,
> +				 <PINMUX_GPIO158__FUNC_B1_MSDC0_DAT3>,
> +				 <PINMUX_GPIO154__FUNC_B1_MSDC0_DAT4>,
> +				 <PINMUX_GPIO153__FUNC_B1_MSDC0_DAT5>,
> +				 <PINMUX_GPIO152__FUNC_B1_MSDC0_DAT6>,
> +				 <PINMUX_GPIO151__FUNC_B1_MSDC0_DAT7>,
> +				 <PINMUX_GPIO156__FUNC_B1_MSDC0_CMD>;
> +			input-enable;
> +			drive-strength = <8>;
> +			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
> +		};
> +
> +		pins-clk {

pins-clk-ds {
	pinmux = <PINMUX_GPIO157__FUNC_B1_MSDC0_CLK>,
		 <PINMUX_GPIO162__FUNC_B0_MSDC0_DSL>;
	drive-strength = <8>;
	bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
};

...that's shorter: both pins are anyway sharing the same drive strength and bias.

> +			pinmux = <PINMUX_GPIO157__FUNC_B1_MSDC0_CLK>;
> +			drive-strength = <8>;
> +			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
> +		};
> +
> +		pins-ds {
> +			pinmux = <PINMUX_GPIO162__FUNC_B0_MSDC0_DSL>;
> +			drive-strength = <8>;
> +			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
> +		};
> +
> +		pins-rst {
> +			pinmux = <PINMUX_GPIO155__FUNC_O_MSDC0_RSTB>;
> +			drive-strength = <8>;
> +			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
> +		};
> +	};
> +
> +	nor_pins_default: nor-pins {
> +		pins0 {

pins-io-ck {

> +			pinmux = <PINMUX_GPIO127__FUNC_B0_SPINOR_IO0>,
> +				 <PINMUX_GPIO125__FUNC_O_SPINOR_CK>,
> +				 <PINMUX_GPIO128__FUNC_B0_SPINOR_IO1>;
> +			bias-pull-down;
> +		};
> +
> +		pins1 {

pins-io-cs {

> +			pinmux = <PINMUX_GPIO126__FUNC_O_SPINOR_CS>,
> +				 <PINMUX_GPIO129__FUNC_B0_SPINOR_IO2>,
> +				 <PINMUX_GPIO130__FUNC_B0_SPINOR_IO3>;
> +			bias-pull-up;
> +		};
> +	};
> +
> +	spi0_pins: spi0-pins {
> +		pins-spi {
> +			pinmux = <PINMUX_GPIO69__FUNC_O_SPIM0_CSB>,
> +				 <PINMUX_GPIO70__FUNC_O_SPIM0_CLK>,
> +				 <PINMUX_GPIO71__FUNC_B0_SPIM0_MOSI>,
> +				 <PINMUX_GPIO72__FUNC_B0_SPIM0_MISO>;
> +			bias-disable;
> +		};
> +	};
> +
> +	spi1_pins: spi1-pins {
> +		pins-spi {
> +			pinmux = <PINMUX_GPIO75__FUNC_O_SPIM1_CSB>,
> +				 <PINMUX_GPIO76__FUNC_O_SPIM1_CLK>,
> +				 <PINMUX_GPIO77__FUNC_B0_SPIM1_MOSI>,
> +				 <PINMUX_GPIO78__FUNC_B0_SPIM1_MISO>;
> +			bias-disable;
> +		};
> +	};
> +
> +	spi2_pins: spi2-pins {
> +		pins-spi {
> +			pinmux = <PINMUX_GPIO79__FUNC_O_SPIM2_CSB>,
> +				 <PINMUX_GPIO80__FUNC_O_SPIM2_CLK>,
> +				 <PINMUX_GPIO81__FUNC_B0_SPIM2_MOSI>,
> +				 <PINMUX_GPIO82__FUNC_B0_SPIM2_MISO>;
> +			bias-disable;
> +		};
> +	};
> +
> +	uart0_pins: uart0-pins {
> +		pins-uart0 {

pins-rx-tx {

> +			pinmux = <PINMUX_GPIO31__FUNC_O_UTXD0>,
> +				 <PINMUX_GPIO32__FUNC_I1_URXD0>;
> +			bias-pull-up;
> +		};
> +	};
> +};
> +

..snip..

> diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
> new file mode 100644
> index 000000000000..c5af32fb7e85
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
> @@ -0,0 +1,949 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (c) 2023 MediaTek Inc.
> + *
> + */
> +
> +/dts-v1/;
> +#include <dt-bindings/clock/mediatek,mt8188-clk.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/phy/phy.h>
> +#include <dt-bindings/pinctrl/mediatek,mt8188-pinfunc.h>
> +#include <dt-bindings/power/mediatek,mt8188-power.h>
> +
> +/ {
> +	compatible = "mediatek,mt8188";
> +	interrupt-parent = <&gic>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu0: cpu@0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a55";
> +			reg = <0x000>;
> +			enable-method = "psci";
> +			clock-frequency = <2000000000>;
> +			capacity-dmips-mhz = <282>;
> +			cpu-idle-states = <&cpu_off_l &cluster_off_l>;
> +			i-cache-size = <32768>;
> +			i-cache-line-size = <64>;
> +			i-cache-sets = <128>;
> +			d-cache-size = <32768>;
> +			d-cache-line-size = <64>;
> +			d-cache-sets = <128>;
> +			next-level-cache = <&l2_0>;
> +			#cooling-cells = <2>;
> +		};
> +
> +		cpu1: cpu@100 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a55";
> +			reg = <0x100>;
> +			enable-method = "psci";
> +			clock-frequency = <2000000000>;
> +			capacity-dmips-mhz = <282>;
> +			cpu-idle-states = <&cpu_off_l &cluster_off_l>;
> +			i-cache-size = <32768>;
> +			i-cache-line-size = <64>;
> +			i-cache-sets = <128>;
> +			d-cache-size = <32768>;
> +			d-cache-line-size = <64>;
> +			d-cache-sets = <128>;
> +			next-level-cache = <&l2_0>;
> +			#cooling-cells = <2>;
> +		};
> +
> +		cpu2: cpu@200 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a55";
> +			reg = <0x200>;
> +			enable-method = "psci";
> +			clock-frequency = <2000000000>;
> +			capacity-dmips-mhz = <282>;
> +			cpu-idle-states = <&cpu_off_l &cluster_off_l>;
> +			i-cache-size = <32768>;
> +			i-cache-line-size = <64>;
> +			i-cache-sets = <128>;
> +			d-cache-size = <32768>;
> +			d-cache-line-size = <64>;
> +			d-cache-sets = <128>;
> +			next-level-cache = <&l2_0>;
> +			#cooling-cells = <2>;
> +		};
> +
> +		cpu3: cpu@300 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a55";
> +			reg = <0x300>;
> +			enable-method = "psci";
> +			clock-frequency = <2000000000>;
> +			capacity-dmips-mhz = <282>;
> +			cpu-idle-states = <&cpu_off_l &cluster_off_l>;
> +			i-cache-size = <32768>;
> +			i-cache-line-size = <64>;
> +			i-cache-sets = <128>;
> +			d-cache-size = <32768>;
> +			d-cache-line-size = <64>;
> +			d-cache-sets = <128>;
> +			next-level-cache = <&l2_0>;
> +			#cooling-cells = <2>;
> +		};
> +
> +		cpu4: cpu@400 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a55";
> +			reg = <0x400>;
> +			enable-method = "psci";
> +			clock-frequency = <2000000000>;
> +			capacity-dmips-mhz = <282>;
> +			cpu-idle-states = <&cpu_off_l &cluster_off_l>;
> +			i-cache-size = <32768>;
> +			i-cache-line-size = <64>;
> +			i-cache-sets = <128>;
> +			d-cache-size = <32768>;
> +			d-cache-line-size = <64>;
> +			d-cache-sets = <128>;
> +			next-level-cache = <&l2_0>;
> +			#cooling-cells = <2>;
> +		};
> +
> +		cpu5: cpu@500 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a55";
> +			reg = <0x500>;
> +			enable-method = "psci";
> +			clock-frequency = <2000000000>;
> +			capacity-dmips-mhz = <282>;
> +			cpu-idle-states = <&cpu_off_l &cluster_off_l>;
> +			i-cache-size = <32768>;
> +			i-cache-line-size = <64>;
> +			i-cache-sets = <128>;
> +			d-cache-size = <32768>;
> +			d-cache-line-size = <64>;
> +			d-cache-sets = <128>;
> +			next-level-cache = <&l2_0>;
> +			#cooling-cells = <2>;
> +		};
> +
> +		cpu6: cpu@600 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a78";
> +			reg = <0x600>;
> +			enable-method = "psci";
> +			clock-frequency = <2600000000>;
> +			capacity-dmips-mhz = <1024>;
> +			cpu-idle-states = <&cpu_off_b &cluster_off_b>;
> +			i-cache-size = <65536>;
> +			i-cache-line-size = <64>;
> +			i-cache-sets = <256>;
> +			d-cache-size = <65536>;
> +			d-cache-line-size = <64>;
> +			d-cache-sets = <256>;
> +			next-level-cache = <&l2_1>;
> +			#cooling-cells = <2>;
> +		};
> +
> +		cpu7: cpu@700 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a78";
> +			reg = <0x700>;
> +			enable-method = "psci";
> +			clock-frequency = <2600000000>;
> +			capacity-dmips-mhz = <1024>;
> +			cpu-idle-states = <&cpu_off_b &cluster_off_b>;
> +			i-cache-size = <65536>;
> +			i-cache-line-size = <64>;
> +			i-cache-sets = <256>;
> +			d-cache-size = <65536>;
> +			d-cache-line-size = <64>;
> +			d-cache-sets = <256>;
> +			next-level-cache = <&l2_1>;
> +			#cooling-cells = <2>;
> +		};
> +
> +		cpu-map {
> +			cluster0 {
> +				core0 {
> +					cpu = <&cpu0>;
> +				};
> +
> +				core1 {
> +					cpu = <&cpu1>;
> +				};
> +
> +				core2 {
> +					cpu = <&cpu2>;
> +				};
> +
> +				core3 {
> +					cpu = <&cpu3>;
> +				};
> +
> +				core4 {
> +					cpu = <&cpu4>;
> +				};
> +
> +				core5 {
> +					cpu = <&cpu5>;
> +				};
> +
> +				core6 {
> +					cpu = <&cpu6>;
> +				};
> +
> +				core7 {
> +					cpu = <&cpu7>;
> +				};
> +			};
> +		};
> +
> +		idle-states {
> +			entry-method = "psci";
> +
> +			cpu_off_l: cpu-off-l {
> +				compatible = "arm,idle-state";
> +				arm,psci-suspend-param = <0x00010000>;
> +				local-timer-stop;
> +				entry-latency-us = <50>;
> +				exit-latency-us = <95>;
> +				min-residency-us = <580>;
> +			};
> +
> +			cpu_off_b: cpu-off-b {
> +				compatible = "arm,idle-state";
> +				arm,psci-suspend-param = <0x00010000>;
> +				local-timer-stop;
> +				entry-latency-us = <45>;
> +				exit-latency-us = <140>;
> +				min-residency-us = <740>;
> +			};
> +
> +			cluster_off_l: cluster-off-l {
> +				compatible = "arm,idle-state";
> +				arm,psci-suspend-param = <0x01010010>;
> +				local-timer-stop;
> +				entry-latency-us = <55>;
> +				exit-latency-us = <155>;
> +				min-residency-us = <840>;
> +			};
> +
> +			cluster_off_b: cluster-off-b {
> +				compatible = "arm,idle-state";
> +				arm,psci-suspend-param = <0x01010010>;
> +				local-timer-stop;
> +				entry-latency-us = <50>;
> +				exit-latency-us = <200>;
> +				min-residency-us = <1000>;
> +			};
> +		};
> +
> +		l2_0: l2-cache0 {
> +			compatible = "cache";
> +			cache-level = <2>;

NACK. You're not specifying the L2 cache correctly.

Hint: the missing properties are
cache-size
cache-line-size
cache-sets

> +			next-level-cache = <&l3_0>;
> +			cache-unified;
> +		};
> +
> +		l2_1: l2-cache1 {
> +			compatible = "cache";
> +			cache-level = <2>;

Same here. Please properly define the L2 cache.

> +			next-level-cache = <&l3_0>;
> +			cache-unified;
> +		};
> +
> +		l3_0: l3-cache {
> +			compatible = "cache";

And again.

This SoC has 256KB L2 shared between the two A78 cores, 128KB L2 shared
between the A55 cores, and 2MB of L3 cache shared across all.

> +			cache-level = <3>;
> +			cache-unified;
> +		};
> +	};
> +
> +	clk13m: oscillator-13m {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <13000000>;
> +		clock-output-names = "clk13m";
> +	};
> +
> +	clk26m: oscillator-26m {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <26000000>;
> +		clock-output-names = "clk26m";
> +	};
> +
> +	clk32k: oscillator-32k {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <32768>;
> +		clock-output-names = "clk32k";
> +	};
> +
> +	pmu-a55 {
> +		compatible = "arm,cortex-a55-pmu";
> +		interrupt-parent = <&gic>;
> +		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH &ppi_cluster0>;
> +	};
> +
> +	pmu-a78 {
> +		compatible = "arm,cortex-a78-pmu";
> +		interrupt-parent = <&gic>;
> +		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH &ppi_cluster1>;
> +	};

Question: Is the ARM DSU PMU broken also on this SoC's TZ firmware?!

> +
> +	psci {
> +		compatible = "arm,psci-1.0";
> +		method = "smc";
> +	};
> +
> +	timer: timer {
> +		compatible = "arm,armv8-timer";
> +		interrupt-parent = <&gic>;
> +		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH 0>,
> +			     <GIC_PPI 14 IRQ_TYPE_LEVEL_HIGH 0>,
> +			     <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH 0>,
> +			     <GIC_PPI 10 IRQ_TYPE_LEVEL_HIGH 0>;
> +		clock-frequency = <13000000>;
> +	};
> +
> +	soc {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		compatible = "simple-bus";
> +		ranges;
> +
> +		gic: interrupt-controller@c000000 {
> +			compatible = "arm,gic-v3";
> +			#interrupt-cells = <4>;
> +			#redistributor-regions = <1>;
> +			interrupt-parent = <&gic>;
> +			interrupt-controller;
> +			reg = <0 0x0c000000 0 0x40000>,
> +			      <0 0x0c040000 0 0x200000>;
> +			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH 0>;
> +
> +			ppi-partitions {
> +				ppi_cluster0: interrupt-partition-0 {
> +					affinity = <&cpu0 &cpu1 &cpu2 &cpu3 &cpu4 &cpu5>;
> +				};
> +
> +				ppi_cluster1: interrupt-partition-1 {
> +					affinity = <&cpu6 &cpu7>;
> +				};
> +			};
> +		};
> +
> +		topckgen: syscon@10000000 {
> +			compatible = "mediatek,mt8188-topckgen", "syscon";
> +			reg = <0 0x10000000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		infracfg_ao: syscon@10001000 {
> +			compatible = "mediatek,mt8188-infracfg-ao", "syscon";
> +			reg = <0 0x10001000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		pericfg: syscon@10003000 {
> +			compatible = "mediatek,mt8188-pericfg", "syscon";
> +			reg = <0 0x10003000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		pio: pinctrl@10005000 {
> +			compatible = "mediatek,mt8188-pinctrl";
> +			reg = <0 0x10005000 0 0x1000>,
> +			      <0 0x11c00000 0 0x1000>,
> +			      <0 0x11e10000 0 0x1000>,
> +			      <0 0x11e20000 0 0x1000>,
> +			      <0 0x11ea0000 0 0x1000>,
> +			      <0 0x1000b000 0 0x1000>;
> +			reg-names = "iocfg0", "iocfg_rm",
> +				    "iocfg_lt", "iocfg_lm", "iocfg_rt",
> +				    "eint";

			reg-names = "iocfg0", "iocfg_rm", "iocfg_lt",
				    "iocfg_lm", "iocfg_rt", "eint";

one less line :-)

> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			gpio-ranges = <&pio 0 0 176>;
> +			interrupt-controller;
> +			interrupts = <GIC_SPI 235 IRQ_TYPE_LEVEL_HIGH 0>;
> +			#interrupt-cells = <2>;
> +		};
> +
> +		watchdog: watchdog@10007000 {
> +			compatible = "mediatek,mt8188-wdt";
> +			mediatek,disable-extrst;
> +			reg = <0 0x10007000 0 0x100>;

mediatek,disable-extrst goes here.

> +			#reset-cells = <1>;
> +		};
> +
> +		apmixedsys: syscon@1000c000 {
> +			compatible = "mediatek,mt8188-apmixedsys", "syscon";
> +			reg = <0 0x1000c000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		systimer: timer@10017000 {
> +			compatible = "mediatek,mt8188-timer", "mediatek,mt6765-timer";
> +			reg = <0 0x10017000 0 0x1000>;
> +			reg-names = "sys_timer_base";

You don't need reg-names here but anyway, if you really want to keep that, please
no underscores when possible.

> +			interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&clk13m>;
> +		};
> +

Regards,
Angelo
