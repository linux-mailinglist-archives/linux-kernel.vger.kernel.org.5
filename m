Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7E92811FED
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 21:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442469AbjLMU1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 15:27:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjLMU1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 15:27:13 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C52DC;
        Wed, 13 Dec 2023 12:27:17 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BDKR6Xp129822;
        Wed, 13 Dec 2023 14:27:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1702499226;
        bh=3LweBZsiB2/n+R258Lwo7eKUhPIvogWGaaXEhf1nq3w=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=ed1CKN9G+6myXpgjDcX4ag5dMjKVuxOUMP6D1tzBg2QlhSbPTDIXZgYvhm8AxHIY1
         KpvZQQDoWGIDGwjxGvV/mgi8ZbOuJYocuKGsPhwfvAuHq8EdstfLuprfIVLts2/OJF
         AuZ2OdoQEyAml0i9Kt5PrfEMN38/60nEFg/4Fono=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BDKR6iK053121
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 Dec 2023 14:27:06 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 13
 Dec 2023 14:27:06 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 13 Dec 2023 14:27:05 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
        by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BDKR5Ld001406;
        Wed, 13 Dec 2023 14:27:05 -0600
Date:   Wed, 13 Dec 2023 14:27:05 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Vaishnav Achath <vaishnav.a@ti.com>
CC:     <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <j-choudhary@ti.com>, <u-kumar1@ti.com>
Subject: Re: [PATCH 2/3] arm64: dts: ti: Introduce J722S family of SoCs
Message-ID: <20231213202705.6tspycl5qicb6gwd@germproof>
References: <20231213124930.3012-1-vaishnav.a@ti.com>
 <20231213124930.3012-3-vaishnav.a@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231213124930.3012-3-vaishnav.a@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18:19-20231213, Vaishnav Achath wrote:
> The J722S is a family of  application processors built for Automotive and
> Linux Application development. Scalable Arm Cortex-A53 performance and
> embedded features, such as multi high-definition display support,
> 3D-graphics acceleration, 4K video acceleration, and extensive peripherals
> make the J722S well-suited for a broad range of automation and industrial
> application, including automotive digital instrumentation, automotive
> displays, industrial HMI, and more.

Trim this down please
> 
> Some highlights of J722S SoC are:
>     * Quad-Cortex-A53s (running up to 1.4GHz) in a single cluster.
>     * One Device manager Cortext-R5F for system power and resource
>       management, two Cortex-R5F for Functional Safety or
>       general-purpose usage and two C7x floating point vector DSPs
>       with Matrix Multiply Accelerator(MMA) for deep learning.
>     * One 3D GPU up to 50 GLFOPS
>     * H.264/H.265, JPEG Video Encode/Decode.
>     * Display support: 3x display support over OLDI/LVDS (1x OLDI-DL, 1x or
>       2x OLDI-SL), DSI, or DPI. Up to 3840x1080@60fps resolution
>     * Integrated Giga-bit Ethernet switch supporting up to a total of two
>       external ports (TSN capable).
>     * Vision Processing Accelerator (VPAC) with image signal processor
>       and Depth and Motion Processing Accelerator (DMPAC).
>     * 7xUARTs, 3xSPI, 5xI2C, 2xUSB2, 2xCAN-FD, 3xMMC and SD, GPMC for
>       NAND/FPGA connection, OSPI memory controller, 5xMcASP for audio,
>       4xCSI-RX for Camera, 1 PCIe Gen3 controller, eCAP/eQEP,
>       ePWM, among other peripherals.
>     * Dedicated Centralized Hardware Security Module with support for
>       secure boot, debug security and crypto acceleration and trusted
>       execution environment.
>     * One 32-bit DDR Subsystem that supports LPDDR4 memory type.

Trim this down to what is different from AM62P?

> 
> J722S family of SoCs is a superset of the AM62P SoC family and shares
> similar memory map, thus the nodes are being reused from AM62P includes
> instead of duplicating the definitions. Unused nodes with dependencies
> are kept disabled and will be enabled later when the dependencies are
> enabled.
> 
> For those interested, more details about this SoC can be found in the
> Technical Reference Manual here:
> 	https://www.ti.com/lit/zip/sprujb3
> 
> Co-developed-by: Jayesh Choudhary <j-choudhary@ti.com>
> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
> ---
> 
> checkpatch error is ignored for arch/arm64/boot/dts/ti/k3-pinctrl.h:
> ERROR: Macros with complex values should be enclosed in parentheses
> 
> However, we do not need parentheses enclosing the values for this
> macro as we do intend it to generate two separate values as has been
> done for other similar platforms.
> 
> Depends on:
> https://lore.kernel.org/all/20231211132600.25289-1-vaishnav.a@ti.com/
> https://lore.kernel.org/all/20231213081318.26203-1-vaishnav.a@ti.com/
> 
>  arch/arm64/boot/dts/ti/k3-j722s.dtsi | 275 +++++++++++++++++++++++++++
>  arch/arm64/boot/dts/ti/k3-pinctrl.h  |   3 +
>  2 files changed, 278 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/ti/k3-j722s.dtsi
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j722s.dtsi b/arch/arm64/boot/dts/ti/k3-j722s.dtsi
> new file mode 100644
> index 000000000000..dbd762bfd779
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-j722s.dtsi
> @@ -0,0 +1,275 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Device Tree Source for J722S SoC Family
> + *
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
> +	model = "Texas Instruments K3 J722S SoC";
> +	compatible = "ti,j722s";
> +	interrupt-parent = <&gic500>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
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

^^ this is a duplication of am62p5.dtsi? what about the spins with
different CPUs enabled?

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
> +		bootph-all;

Nope.

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
> +			 <0x00 0x0fd80000 0x00 0x0fd80000 0x00 0x00080000>, /* GPU */
> +			 <0x00 0x0fd20000 0x00 0x0fd20000 0x00 0x00000100>, /* JPEGENC0_CORE */
> +			 <0x00 0x0fd20200 0x00 0x0fd20200 0x00 0x00000200>, /* JPEGENC0_CORE_MMU */
> +			 <0x00 0x20000000 0x00 0x20000000 0x00 0x0a008000>, /* Third peripheral window */
> +			 <0x00 0x30040000 0x00 0x30040000 0x00 0x00080000>, /* PRUSS-M */
> +			 <0x00 0x301C0000 0x00 0x301C0000 0x00 0x00001000>, /* DPHY-TX */
> +			 <0x00 0x30101000 0x00 0x30101000 0x00 0x00080100>, /* CSI window */
> +			 <0x00 0x30200000 0x00 0x30200000 0x00 0x00010000>, /* DSS */
> +			 <0x00 0x30210000 0x00 0x30210000 0x00 0x00010000>, /* VPU */
> +			 <0x00 0x30220000 0x00 0x30220000 0x00 0x00010000>, /* DSS1 */
> +			 <0x00 0x30270000 0x00 0x30270000 0x00 0x00010000>, /* DSI-base1 */
> +			 <0x00 0x30500000 0x00 0x30500000 0x00 0x00100000>, /* DSI-base2 */
> +			 <0x00 0x31000000 0x00 0x31000000 0x00 0x00050000>, /* USB0 DWC3 Core window */
> +			 <0x00 0x31200000 0x00 0x31200000 0x00 0x00040000>, /* USB1 DWC3 Core window */
> +			 <0x00 0x40900000 0x00 0x40900000 0x00 0x00030000>, /* SA3UL */
> +			 <0x00 0x43600000 0x00 0x43600000 0x00 0x00010000>, /* SA3 sproxy data */
> +			 <0x00 0x44043000 0x00 0x44043000 0x00 0x00000fe0>, /* TI SCI DEBUG */
> +			 <0x00 0x44860000 0x00 0x44860000 0x00 0x00040000>, /* SA3 sproxy config */
> +			 <0x00 0x48000000 0x00 0x48000000 0x00 0x06408000>, /* DMSS */
> +			 <0x00 0x60000000 0x00 0x60000000 0x00 0x08000000>, /* FSS0 DAT1 */
> +			 <0x00 0x70000000 0x00 0x70000000 0x00 0x00040000>, /* OCSRAM */
> +			 <0x00 0x78400000 0x00 0x78400000 0x00 0x00008000>, /* MAIN R5FSS0 ATCM */
> +			 <0x00 0x78500000 0x00 0x78500000 0x00 0x00008000>, /* MAIN R5FSS0 BTCM */
> +			 <0x00 0x7e000000 0x00 0x7e000000 0x00 0x00200000>, /* C7X_0 L2SRAM */
> +			 <0x00 0x7e200000 0x00 0x7e200000 0x00 0x00200000>, /* C7X_1 L2SRAM */
> +			 <0x01 0x00000000 0x01 0x00000000 0x00 0x00310000>, /* A53 PERIPHBASE */
> +			 <0x05 0x00000000 0x05 0x00000000 0x01 0x00000000>, /* FSS0 DAT3 */
> +
> +			 /* MCU Domain Range */
> +			 <0x00 0x04000000 0x00 0x04000000 0x00 0x01ff1400>,
> +			 <0x00 0x79000000 0x00 0x79000000 0x00 0x00008000>,
> +			 <0x00 0x79020000 0x00 0x79020000 0x00 0x00008000>,
> +			 <0x00 0x79100000 0x00 0x79100000 0x00 0x00040000>,
> +			 <0x00 0x79140000 0x00 0x79140000 0x00 0x00040000>,
> +
> +			 /* Wakeup Domain Range */
> +			 <0x00 0x00b00000 0x00 0x00b00000 0x00 0x00002400>,
> +			 <0x00 0x2b000000 0x00 0x2b000000 0x00 0x00300400>,
> +			 <0x00 0x43000000 0x00 0x43000000 0x00 0x00020000>,
> +			 <0x00 0x78000000 0x00 0x78000000 0x00 0x00008000>,
> +			 <0x00 0x78100000 0x00 0x78100000 0x00 0x00008000>;
> +
> +		cbass_mcu: bus@4000000 {
> +			compatible = "simple-bus";
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges = <0x00 0x04000000 0x00 0x04000000 0x00 0x01ff1400>, /* Peripheral window */
> +				 <0x00 0x79000000 0x00 0x79000000 0x00 0x00008000>, /* MCU R5 ATCM */
> +				 <0x00 0x79020000 0x00 0x79020000 0x00 0x00008000>, /* MCU R5 BTCM */
> +				 <0x00 0x79100000 0x00 0x79100000 0x00 0x00040000>, /* MCU IRAM0 */
> +				 <0x00 0x79140000 0x00 0x79140000 0x00 0x00040000>; /* MCU IRAM1 */
> +			bootph-all;
> +		};
> +
> +		cbass_wakeup: bus@b00000 {
> +			compatible = "simple-bus";
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges = <0x00 0x00b00000 0x00 0x00b00000 0x00 0x00002400>, /* VTM */
> +				 <0x00 0x2b000000 0x00 0x2b000000 0x00 0x00300400>, /* Peripheral Window */
> +				 <0x00 0x43000000 0x00 0x43000000 0x00 0x00020000>, /* WKUP CTRL MMR */
> +				 <0x00 0x78000000 0x00 0x78000000 0x00 0x00008000>, /* DM R5 ATCM*/
> +				 <0x00 0x78100000 0x00 0x78100000 0x00 0x00008000>; /* DM R5 BTCM*/
> +			bootph-all;

Not in the bus nodes.. only in the leaf nodes please.


Also what is wrong with expanding the am62p to include the
missing bus segments instead of duplicating all of them?

> +		};
> +	};
> +
> +	#include "k3-am62p-thermal.dtsi"

Is this correct?

> +};
> +
> +/*
> + * Include peripherals for each bus segment derived
> + * from AM62P and overrides specific to J722S.
> + */
> +#include "k3-am62p-main.dtsi"
> +#include "k3-am62p-mcu.dtsi"
> +#include "k3-am62p-wakeup.dtsi"
> +
> +/* Main domain overrides */
> +
> +&cpsw3g {
> +	status = "disabled";

	here and rest: Why disabled?
> +};
> +
> +&inta_main_dmss {
> +	ti,interrupt-ranges = <5 69 35>;
> +};
> +
> +&mailbox0_cluster0 {
> +	status = "disabled";
> +};
> +
> +&mailbox0_cluster1 {
> +	status = "disabled";
> +};
> +
> +&mailbox0_cluster2 {
> +	status = "disabled";
> +};
> +
> +&mailbox0_cluster3 {
> +	status = "disabled";
> +};
> +
> +&oc_sram {
> +	reg = <0x00 0x70000000 0x00 0x40000>;
> +	ranges = <0x00 0x00 0x70000000 0x40000>;
> +};
> +
> +/* MCU domain overrides */
> +
> +&mcu_r5fss0 {
> +	status = "disabled";
> +};
> +
> +/* wakeup domain overrides */
> +
> +&wkup_r5fss0 {
> +	status = "disabled";
> +};
> diff --git a/arch/arm64/boot/dts/ti/k3-pinctrl.h b/arch/arm64/boot/dts/ti/k3-pinctrl.h
> index 2a4e0e084d69..591be4489f37 100644
> --- a/arch/arm64/boot/dts/ti/k3-pinctrl.h
> +++ b/arch/arm64/boot/dts/ti/k3-pinctrl.h
> @@ -59,6 +59,9 @@
>  #define J721S2_IOPAD(pa, val, muxmode)		(((pa) & 0x1fff)) ((val) | (muxmode))
>  #define J721S2_WKUP_IOPAD(pa, val, muxmode)	(((pa) & 0x1fff)) ((val) | (muxmode))
>  
> +#define J722S_IOPAD(pa, val, muxmode)		(((pa) & 0x1fff)) ((val) | (muxmode))
> +#define J722S_MCU_IOPAD(pa, val, muxmode)	(((pa) & 0x1fff)) ((val) | (muxmode))
> +
>  #define J784S4_IOPAD(pa, val, muxmode)		(((pa) & 0x1fff)) ((val) | (muxmode))
>  #define J784S4_WKUP_IOPAD(pa, val, muxmode)	(((pa) & 0x1fff)) ((val) | (muxmode))
>  
> -- 
> 2.17.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
