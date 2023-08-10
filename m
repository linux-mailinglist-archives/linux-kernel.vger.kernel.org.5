Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 864BB77828D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 23:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjHJVLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 17:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjHJVLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 17:11:48 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66392D52;
        Thu, 10 Aug 2023 14:11:46 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37ALBX8I024585;
        Thu, 10 Aug 2023 16:11:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691701893;
        bh=vd4gwHJ9sWWTSkb3azBtxPZhSPuWsQ2LT3uoiKcEX6E=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=PIBhYhh666Oedqs8iRzuq54vLRgtAHfIyb+mzd3wZtruxPfvCQs0E3y161U97kFFH
         tmEb8oborsJTa2jqRiEUN1ifk00xc1HGbqDB9SG1yZsugxLwuOyva+Tb94HmoAMhaM
         DB0Nd5vZJYQvW6Recn6sZAKzxJexRbiGAY9RCw4I=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37ALBXHp021147
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Aug 2023 16:11:33 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 10
 Aug 2023 16:11:32 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 10 Aug 2023 16:11:32 -0500
Received: from [10.250.38.120] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37ALBWq1009775;
        Thu, 10 Aug 2023 16:11:32 -0500
Message-ID: <ab0a9c7d-1895-38be-9a11-3e6114b6f6b1@ti.com>
Date:   Thu, 10 Aug 2023 16:11:32 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/3] arm64: dts: ti: Introduce AM62P5 family of SoCs
To:     Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230810045314.2676833-1-vigneshr@ti.com>
 <20230810045314.2676833-3-vigneshr@ti.com>
Content-Language: en-US
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <20230810045314.2676833-3-vigneshr@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/23 11:53 PM, Vignesh Raghavendra wrote:
> From: Bryan Brattlof <bb@ti.com>
> 
> The AM62Px is an extension of the existing Sitara AM62x low-cost family
> of application processors built for Automotive and Linux Application
> development. Scalable Arm Cortex-A53 performance and embedded features,
> such as: multi high-definition display support, 3D-graphics
> acceleration, 4K video acceleration, and extensive peripherals make the
> AM62Px well-suited for a broad range of automation and industrial
> application, including automotive digital instrumentation, automotive
> displays, industrial HMI, and more.
> 
> Some highlights of AM62P SoC are:
> * Quad-Cortex-A53s (running up to 1.4GHz) in a single cluster.
>    Dual/Single core variants are provided in the same package to allow HW
>    compatible designs.
> * One Device manager Cortext-R5F for system power and resource
>    management, and one Cortex-R5F for Functional Safety or
>    general-purpose usage.
> * One 3D GPU up to 50 GLFOPS
> * H.264/H.265 Video Encode/Decode.
> * Display support: 3x display support over OLDI/LVDS (1x OLDI-DL, 1x or
>    2x OLDI-SL), DSI, or DPI. Up to 3840x1080@60fps resolution
> * Integrated Giga-bit Ethernet switch supporting up to a total of two
>    external ports (TSN capable).
> * 9xUARTs, 5xSPI, 6xI2C, 2xUSB2, 3xCAN-FD, 3xMMC and SD, GPMC for
>    NAND/FPGA connection, OSPI memory controller, 3xMcASP for audio,
>    1xCSI-RX-4L for Camera, eCAP/eQEP, ePWM, among other peripherals.
> * Dedicated Centralized Hardware Security Module with support for secure
>    boot, debug security and crypto acceleration and trusted execution
>    environment.
> * One 32-bit DDR Subsystem that supports LPDDR4, DDR4 memory types.
> * Multiple low power modes support, ex: Deep sleep, Standby, MCU-only,
>    enabling battery powered system design.
> 
> For those interested, more details about this SoC can be found in the
> Technical Reference Manual here:
> 
>      https://www.ti.com/lit/pdf/spruj83
> 
> Signed-off-by: Bryan Brattlof <bb@ti.com>
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---
>   arch/arm64/boot/dts/ti/k3-am62p-main.dtsi   | 129 ++++++++++++++++++++
>   arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi    |  16 +++
>   arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi |  30 +++++
>   arch/arm64/boot/dts/ti/k3-am62p.dtsi        | 109 +++++++++++++++++
>   arch/arm64/boot/dts/ti/k3-am62p5.dtsi       | 107 ++++++++++++++++
>   arch/arm64/boot/dts/ti/k3-pinctrl.h         |   3 +
>   6 files changed, 394 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
>   create mode 100644 arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi
>   create mode 100644 arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi
>   create mode 100644 arch/arm64/boot/dts/ti/k3-am62p.dtsi
>   create mode 100644 arch/arm64/boot/dts/ti/k3-am62p5.dtsi
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
> new file mode 100644
> index 000000000000..3ce70be634b9
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
> @@ -0,0 +1,129 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Device Tree file for the AM62P main domain peripherals
> + * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
> + */
> +
> +&cbass_main {
> +	oc_sram: sram@70000000 {
> +		compatible = "mmio-sram";
> +		reg = <0x00 0x70000000 0x00 0x10000>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0x00 0x00 0x70000000 0x10000>;
> +	};
> +
> +	gic500: interrupt-controller@1800000 {
> +		compatible = "arm,gic-v3";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +		#interrupt-cells = <3>;
> +		interrupt-controller;
> +		reg = <0x00 0x01800000 0x00 0x10000>,	/* GICD */
> +		      <0x00 0x01880000 0x00 0xc0000>,	/* GICR */
> +		      <0x01 0x00000000 0x00 0x2000>,    /* GICC */
> +		      <0x01 0x00010000 0x00 0x1000>,    /* GICH */
> +		      <0x01 0x00020000 0x00 0x2000>;    /* GICV */
> +		/*
> +		 * vcpumntirq:
> +		 * virtual CPU interface maintenance interrupt
> +		 */
> +		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +
> +		gic_its: msi-controller@1820000 {
> +			compatible = "arm,gic-v3-its";
> +			reg = <0x00 0x01820000 0x00 0x10000>;
> +			socionext,synquacer-pre-its = <0x1000000 0x400000>;
> +			msi-controller;
> +			#msi-cells = <1>;
> +		};
> +	};
> +
> +	dmss: bus@48000000 {
> +		compatible = "simple-mfd";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		dma-ranges;
> +		ranges = <0x00 0x48000000 0x00 0x48000000 0x00 0x06400000>;
> +
> +		ti,sci-dev-id = <25>;
> +
> +		secure_proxy_main: mailbox@4d000000 {
> +			compatible = "ti,am654-secure-proxy";
> +			#mbox-cells = <1>;
> +			reg-names = "target_data", "rt", "scfg";
> +			reg = <0x00 0x4d000000 0x00 0x80000>,
> +			      <0x00 0x4a600000 0x00 0x80000>,
> +			      <0x00 0x4a400000 0x00 0x80000>;
> +			interrupt-names = "rx_012";
> +			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
> +		};
> +	};
> +
> +	dmsc: system-controller@44043000 {
> +		compatible = "ti,k2g-sci";
> +		ti,host-id = <12>;
> +		mbox-names = "rx", "tx";
> +		mboxes = <&secure_proxy_main 12>,
> +			 <&secure_proxy_main 13>;
> +		reg-names = "debug_messages";
> +		reg = <0x00 0x44043000 0x00 0xfe0>;
> +
> +		k3_pds: power-controller {
> +			compatible = "ti,sci-pm-domain";
> +			#power-domain-cells = <2>;
> +		};
> +
> +		k3_clks: clock-controller {
> +			compatible = "ti,k2g-sci-clk";
> +			#clock-cells = <2>;
> +		};
> +
> +		k3_reset: reset-controller {
> +			compatible = "ti,sci-reset";
> +			#reset-cells = <2>;
> +		};
> +	};
> +
> +	main_pmx0: pinctrl@f4000 {
> +		compatible = "pinctrl-single";
> +		reg = <0x00 0xf4000 0x00 0x2ac>;
> +		#pinctrl-cells = <1>;
> +		pinctrl-single,register-width = <32>;
> +		pinctrl-single,function-mask = <0xffffffff>;
> +		status = "disabled";

Any reason we disable this by default here? I get it is not very useful
without any child nodes, but still it is technically complete as far
as the binding cares, right?

> +	};
> +
> +	main_timer0: timer@2400000 {
> +		compatible = "ti,am654-timer";
> +		reg = <0x00 0x2400000 0x00 0x400>;
> +		interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&k3_clks 36 2>;
> +		clock-names = "fck";
> +		assigned-clocks = <&k3_clks 36 2>;
> +		assigned-clock-parents = <&k3_clks 36 3>;
> +		power-domains = <&k3_pds 36 TI_SCI_PD_EXCLUSIVE>;
> +		ti,timer-pwm;
> +	};
> +
> +	main_uart0: serial@2800000 {
> +		compatible = "ti,am64-uart", "ti,am654-uart";
> +		reg = <0x00 0x02800000 0x00 0x100>;
> +		interrupts = <GIC_SPI 178 IRQ_TYPE_LEVEL_HIGH>;
> +		power-domains = <&k3_pds 146 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 146 0>;
> +		clock-names = "fclk";
> +		status = "disabled";
> +	};
> +
> +	main_uart1: serial@2810000 {
> +		compatible = "ti,am64-uart", "ti,am654-uart";
> +		reg = <0x00 0x02810000 0x00 0x100>;
> +		interrupts = <GIC_SPI 179 IRQ_TYPE_LEVEL_HIGH>;
> +		power-domains = <&k3_pds 152 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 152 0>;
> +		clock-names = "fclk";
> +		status = "disabled";
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi
> new file mode 100644
> index 000000000000..bd6e8c12a1e8
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi
> @@ -0,0 +1,16 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Device Tree file for the AM62P mcu domain peripherals

Lot of the documents call this the "MCU" domain, all caps, same for WAKEUP and
MAIN domains, no big deal either way.

> + * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
> + */
> +
> +&cbass_mcu {
> +	mcu_pmx0: pinctrl@4084000 {
> +		compatible = "pinctrl-single";
> +		reg = <0x00 0x04084000 0x00 0x88>;
> +		#pinctrl-cells = <1>;
> +		pinctrl-single,register-width = <32>;
> +		pinctrl-single,function-mask = <0xffffffff>;
> +		status = "disabled";
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi
> new file mode 100644
> index 000000000000..da8430222948
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi
> @@ -0,0 +1,30 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Device Tree file for the AM62P wakeup domain peripherals
> + * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
> + */
> +
> +&cbass_wakeup {
> +	wkup_conf: bus@43000000 {
> +		compatible = "simple-bus";
> +		reg = <0x00 0x43000000 0x00 0x20000>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0x00 0x00 0x43000000 0x20000>;
> +
> +		chipid: chipid@14 {
> +			compatible = "ti,am654-chipid";
> +			reg = <0x14 0x4>;
> +		};
> +	};
> +
> +	wkup_uart0: serial@2b300000 {
> +		compatible = "ti,am64-uart", "ti,am654-uart";
> +		reg = <0x00 0x2b300000 0x00 0x100>;
> +		interrupts = <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>;
> +		power-domains = <&k3_pds 114 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 114 0>;
> +		clock-names = "fclk";
> +		status = "disabled";
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/ti/k3-am62p.dtsi b/arch/arm64/boot/dts/ti/k3-am62p.dtsi
> new file mode 100644
> index 000000000000..305dda92ae7f
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-am62p.dtsi
> @@ -0,0 +1,109 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Device Tree file for the AM62P5 SoC family
> + * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
> + */
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/soc/ti,sci_pm_domain.h>
> +
> +#include "k3-pinctrl.h"
> +
> +/ {
> +	model = "Texas Instruments K3 AM62P5 SoC";
> +	compatible = "ti,am62p5";
> +	interrupt-parent = <&gic500>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	chosen { };

This empty chosen node doing anything for us?

Otherwise LGTM,

Acked-by: Andrew Davis <afd@ti.com>

> +
> +	firmware {
> +		optee {
> +			compatible = "linaro,optee-tz";
> +			method = "smc";
> +		};
> +
> +		psci: psci {
> +			compatible = "arm,psci-1.0";
> +			method = "smc";
> +		};
> +	};
> +
> +	a53_timer0: timer-cl0-cpu0 {
> +		compatible = "arm,armv8-timer";
> +		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>, /* cntpsirq */
> +			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>, /* cntpnsirq */
> +			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>, /* cntvirq */
> +			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>; /* cnthpirq */
> +	};
> +
> +	pmu: pmu {
> +		compatible = "arm,cortex-a53-pmu";
> +		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
> +	};
> +
> +	cbass_main: bus@f0000 {
> +		compatible = "simple-bus";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +
> +		ranges = <0x00 0x000f0000 0x00 0x000f0000 0x00 0x00030000>, /* Main MMRs */
> +			 <0x00 0x00420000 0x00 0x00420000 0x00 0x00001000>, /* ESM0 */
> +			 <0x00 0x00600000 0x00 0x00600000 0x00 0x00001100>, /* GPIO */
> +			 <0x00 0x00703000 0x00 0x00703000 0x00 0x00000200>, /* USB0 debug trace */
> +			 <0x00 0x0070c000 0x00 0x0070c000 0x00 0x00000200>, /* USB1 debug trace */
> +			 <0x00 0x00a40000 0x00 0x00a40000 0x00 0x00000800>, /* Timesync router */
> +			 <0x00 0x01000000 0x00 0x01000000 0x00 0x01b28400>, /* First peripheral window */
> +			 <0x00 0x08000000 0x00 0x08000000 0x00 0x00200000>, /* Main CPSW */
> +			 <0x00 0x0e000000 0x00 0x0e000000 0x00 0x01d20000>, /* Second peripheral window */
> +			 <0x00 0x0fd00000 0x00 0x0fd00000 0x00 0x00020000>, /* GPU */
> +			 <0x00 0x20000000 0x00 0x20000000 0x00 0x0a008000>, /* Third peripheral window */
> +			 <0x00 0x30040000 0x00 0x30040000 0x00 0x00080000>, /* PRUSS-M */
> +			 <0x00 0x30101000 0x00 0x30101000 0x00 0x00010100>, /* CSI window */
> +			 <0x00 0x30200000 0x00 0x30200000 0x00 0x00010000>, /* DSS */
> +			 <0x00 0x30210000 0x00 0x30210000 0x00 0x00010000>, /* VPU */
> +			 <0x00 0x31000000 0x00 0x31000000 0x00 0x00050000>, /* USB0 DWC3 Core window */
> +			 <0x00 0x31100000 0x00 0x31100000 0x00 0x00050000>, /* USB1 DWC3 Core window */
> +			 <0x00 0x40900000 0x00 0x40900000 0x00 0x00030000>, /* SA3UL */
> +			 <0x00 0x43600000 0x00 0x43600000 0x00 0x00010000>, /* SA3 sproxy data */
> +			 <0x00 0x44043000 0x00 0x44043000 0x00 0x00000fe0>, /* TI SCI DEBUG */
> +			 <0x00 0x44860000 0x00 0x44860000 0x00 0x00040000>, /* SA3 sproxy config */
> +			 <0x00 0x48000000 0x00 0x48000000 0x00 0x06400000>, /* DMSS */
> +			 <0x00 0x60000000 0x00 0x60000000 0x00 0x08000000>, /* FSS0 DAT1 */
> +			 <0x00 0x70000000 0x00 0x70000000 0x00 0x00010000>, /* OCSRAM */
> +			 <0x01 0x00000000 0x01 0x00000000 0x00 0x00310000>, /* A53 PERIPHBASE */
> +			 <0x05 0x00000000 0x05 0x00000000 0x01 0x00000000>, /* FSS0 DAT3 */
> +
> +			 /* MCU Domain Range */
> +			 <0x00 0x04000000 0x00 0x04000000 0x00 0x01ff1400>, /* Peripheral Window */
> +
> +			 /* Wakeup Domain Range */
> +			 <0x00 0x00b00000 0x00 0x00b00000 0x00 0x00002400>, /* VTM */
> +			 <0x00 0x2b000000 0x00 0x2b000000 0x00 0x00300400>, /* Peripheral Window */
> +			 <0x00 0x43000000 0x00 0x43000000 0x00 0x00020000>; /* WKUP CTRL MMR */
> +
> +		cbass_mcu: bus@4000000 {
> +			compatible = "simple-bus";
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges = <0x00 0x04000000 0x00 0x04000000 0x00 0x01ff1400>; /* Peripheral Window */
> +		};
> +
> +		cbass_wakeup: bus@b00000 {
> +			compatible = "simple-bus";
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges = <0x00 0x00b00000 0x00 0x00b00000 0x00 0x00002400>, /* VTM */
> +				 <0x00 0x2b000000 0x00 0x2b000000 0x00 0x00300400>, /* Peripheral Window */
> +				 <0x00 0x43000000 0x00 0x43000000 0x00 0x00020000>; /* WKUP CTRL MMR */
> +		};
> +	};
> +};
> +
> +/* Now include peripherals for each bus segment */
> +#include "k3-am62p-main.dtsi"
> +#include "k3-am62p-mcu.dtsi"
> +#include "k3-am62p-wakeup.dtsi"
> diff --git a/arch/arm64/boot/dts/ti/k3-am62p5.dtsi b/arch/arm64/boot/dts/ti/k3-am62p5.dtsi
> new file mode 100644
> index 000000000000..50147bb63e03
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-am62p5.dtsi
> @@ -0,0 +1,107 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Device Tree file for the AM62P5 SoC family (quad core)
> + * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
> + *
> + * TRM: https://www.ti.com/lit/pdf/spruj83
> + */
> +
> +/dts-v1/;
> +
> +#include "k3-am62p.dtsi"
> +
> +/ {
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu-map {
> +			cluster0: cluster0 {
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
> +			};
> +		};
> +
> +		cpu0: cpu@0 {
> +			compatible = "arm,cortex-a53";
> +			reg = <0x000>;
> +			device_type = "cpu";
> +			enable-method = "psci";
> +			i-cache-size = <0x8000>;
> +			i-cache-line-size = <64>;
> +			i-cache-sets = <256>;
> +			d-cache-size = <0x8000>;
> +			d-cache-line-size = <64>;
> +			d-cache-sets = <128>;
> +			next-level-cache = <&l2_0>;
> +			clocks = <&k3_clks 135 0>;
> +		};
> +
> +		cpu1: cpu@1 {
> +			compatible = "arm,cortex-a53";
> +			reg = <0x001>;
> +			device_type = "cpu";
> +			enable-method = "psci";
> +			i-cache-size = <0x8000>;
> +			i-cache-line-size = <64>;
> +			i-cache-sets = <256>;
> +			d-cache-size = <0x8000>;
> +			d-cache-line-size = <64>;
> +			d-cache-sets = <128>;
> +			next-level-cache = <&l2_0>;
> +			clocks = <&k3_clks 136 0>;
> +		};
> +
> +		cpu2: cpu@2 {
> +			compatible = "arm,cortex-a53";
> +			reg = <0x002>;
> +			device_type = "cpu";
> +			enable-method = "psci";
> +			i-cache-size = <0x8000>;
> +			i-cache-line-size = <64>;
> +			i-cache-sets = <256>;
> +			d-cache-size = <0x8000>;
> +			d-cache-line-size = <64>;
> +			d-cache-sets = <128>;
> +			next-level-cache = <&l2_0>;
> +			clocks = <&k3_clks 137 0>;
> +		};
> +
> +		cpu3: cpu@3 {
> +			compatible = "arm,cortex-a53";
> +			reg = <0x003>;
> +			device_type = "cpu";
> +			enable-method = "psci";
> +			i-cache-size = <0x8000>;
> +			i-cache-line-size = <64>;
> +			i-cache-sets = <256>;
> +			d-cache-size = <0x8000>;
> +			d-cache-line-size = <64>;
> +			d-cache-sets = <128>;
> +			next-level-cache = <&l2_0>;
> +			clocks = <&k3_clks 138 0>;
> +		};
> +	};
> +
> +	l2_0: l2-cache0 {
> +		compatible = "cache";
> +		cache-unified;
> +		cache-level = <2>;
> +		cache-size = <0x80000>;
> +		cache-line-size = <64>;
> +		cache-sets = <512>;
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/ti/k3-pinctrl.h b/arch/arm64/boot/dts/ti/k3-pinctrl.h
> index 6004e0967ec5..2a4e0e084d69 100644
> --- a/arch/arm64/boot/dts/ti/k3-pinctrl.h
> +++ b/arch/arm64/boot/dts/ti/k3-pinctrl.h
> @@ -41,6 +41,9 @@
>   #define AM62AX_IOPAD(pa, val, muxmode)		(((pa) & 0x1fff)) ((val) | (muxmode))
>   #define AM62AX_MCU_IOPAD(pa, val, muxmode)	(((pa) & 0x1fff)) ((val) | (muxmode))
>   
> +#define AM62PX_IOPAD(pa, val, muxmode)		(((pa) & 0x1fff)) ((val) | (muxmode))
> +#define AM62PX_MCU_IOPAD(pa, val, muxmode)	(((pa) & 0x1fff)) ((val) | (muxmode))
> +
>   #define AM62X_IOPAD(pa, val, muxmode)		(((pa) & 0x1fff)) ((val) | (muxmode))
>   #define AM62X_MCU_IOPAD(pa, val, muxmode)	(((pa) & 0x1fff)) ((val) | (muxmode))
>   
