Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 877DE77829E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 23:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbjHJVT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 17:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjHJVTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 17:19:23 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6989C2D57;
        Thu, 10 Aug 2023 14:19:15 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37ALJ6Q4038293;
        Thu, 10 Aug 2023 16:19:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691702346;
        bh=mptyD5f2GRMc9M1HK5cgkrfyCrKSjRGcCbWLek84jn0=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=EM+LjR24Qtb8S+I22BNxPcDxmTjn4v7J2UaNOrvJ3fk+xbO/HZQSpr8KW3bwbhi01
         DmZbue2Cr2+4DP5auvs5ys+dZfOKC3QK6kUYxpdA1jfySEVBv2eEVm5oFpmaX/1IO9
         KgytRqfIRJdYDaSGqGhe82LbJburaeAnI6UYvvFc=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37ALJ6Rc050315
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Aug 2023 16:19:06 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 10
 Aug 2023 16:19:06 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 10 Aug 2023 16:19:06 -0500
Received: from [10.250.38.120] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37ALJ5DA016003;
        Thu, 10 Aug 2023 16:19:05 -0500
Message-ID: <581a2e01-323c-8127-7ddc-05d0ac5d3a80@ti.com>
Date:   Thu, 10 Aug 2023 16:19:05 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 3/3] arm64: dts: ti: Add support for the AM62P5-SK
Content-Language: en-US
To:     Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230810045314.2676833-1-vigneshr@ti.com>
 <20230810045314.2676833-4-vigneshr@ti.com>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <20230810045314.2676833-4-vigneshr@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/23 11:53 PM, Vignesh Raghavendra wrote:
> From: Bryan Brattlof <bb@ti.com>
> 
> Add basic support for the AM62P5-SK platform with UART and ramdisk as

We usually call the boards "SK-AM6xx", with the SK- first, assuming this
board is named the same way you should fix that here and in the files.

> rootfs.
> 
> Schematics is at https://www.ti.com/lit/zip/sprr487
> 
> Signed-off-by: Bryan Brattlof <bb@ti.com>
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---
>   arch/arm64/boot/dts/ti/Makefile         |   3 +
>   arch/arm64/boot/dts/ti/k3-am62p5-sk.dts | 169 ++++++++++++++++++++++++
>   2 files changed, 172 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
> 
> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
> index 437a3d7e8e3a..5a09cad74c44 100644
> --- a/arch/arm64/boot/dts/ti/Makefile
> +++ b/arch/arm64/boot/dts/ti/Makefile
> @@ -23,6 +23,9 @@ dtb-$(CONFIG_ARCH_K3) += k3-am62-lp-sk.dtb
>   # Boards with AM62Ax SoC
>   dtb-$(CONFIG_ARCH_K3) += k3-am62a7-sk.dtb
>   
> +# Boards with AM62Px SoC
> +dtb-$(CONFIG_ARCH_K3) += k3-am62p5-sk.dtb
> +
>   # Boards with AM64x SoC
>   dtb-$(CONFIG_ARCH_K3) += k3-am642-evm.dtb
>   dtb-$(CONFIG_ARCH_K3) += k3-am642-phyboard-electra-rdk.dtb
> diff --git a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
> new file mode 100644
> index 000000000000..b0882211448e
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
> @@ -0,0 +1,169 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Device Tree file for the AM62P5-SK
> + * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
> + *
> + * Schematics: https://www.ti.com/lit/zip/sprr487
> + */
> +
> +/dts-v1/;
> +
> +#include "k3-am62p5.dtsi"
> +
> +/ {
> +	compatible = "ti,am62p5-sk", "ti,am62p5";
> +	model = "Texas Instruments AM62P5 SK";
> +
> +	aliases {
> +		serial0 = &wkup_uart0;
> +		serial2 = &main_uart0;
> +		serial3 = &main_uart1;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial2:115200n8";

You can set the path here directly to the node:

stdout-path = &main_uart0;

Then the default baud rate can be defined/selected in
the node with:

current-speed = <115200>;

> +	};
> +
> +	memory@80000000 {
> +		/* 8G RAM */
> +		reg = <0x00000000 0x80000000 0x00000000 0x80000000>,
> +		      <0x00000008 0x80000000 0x00000001 0x80000000>;
> +		device_type = "memory";
> +		bootph-pre-ram;
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		secure_tfa_ddr: tfa@9e780000 {
> +			reg = <0x00 0x9e780000 0x00 0x80000>;
> +			alignment = <0x1000>;

You cannot allocate from this memory, no need for alignment.

> +			no-map;
> +		};
> +
> +		secure_ddr: optee@9e800000 {
> +			reg = <0x00 0x9e800000 0x00 0x01800000>; /* for OP-TEE */
> +			alignment = <0x1000>;

Same.

> +			no-map;
> +		};
> +
> +		wkup_r5fss0_core0_memory_region: r5f-dma-memory@9c900000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x00 0x9c900000 0x00 0x01e00000>;
> +			no-map;
> +		};
> +	};
> +};
> +
> +&cbass_main {
> +	bootph-pre-ram;

I'm thinking we will need this for any AM62P based board, should
we bubble this up into the common .dtsi files? Same for most of the
other instances at the end of this file.

Andrew

> +};
> +
> +&main_pmx0 {
> +	status = "okay";
> +	bootph-pre-ram;
> +
> +	main_uart0_pins_default: main-uart0-default-pins {
> +		bootph-pre-ram;
> +		pinctrl-single,pins = <
> +			AM62PX_IOPAD(0x1c8, PIN_INPUT, 0)	/* (A22) UART0_RXD */
> +			AM62PX_IOPAD(0x1cc, PIN_OUTPUT, 0)	/* (B22) UART0_TXD */
> +			AM62PX_IOPAD(0x1d0, PIN_INPUT, 0)	/* (A23) UART0_CTSn */
> +			AM62PX_IOPAD(0x1d4, PIN_OUTPUT, 0)	/* (C22) UART0_RTSn */
> +		>;
> +	};
> +
> +	main_uart1_pins_default: main-uart1-default-pins {
> +		bootph-pre-ram;
> +		pinctrl-single,pins = <
> +			AM62PX_IOPAD(0x194, PIN_INPUT, 2)	/* (D25) MCASP0_AXR3 */
> +			AM62PX_IOPAD(0x198, PIN_OUTPUT, 2)	/* (E25) MCASP0_AXR2 */
> +			AM62PX_IOPAD(0x1ac, PIN_INPUT, 2)	/* (G23) MCASP0_AFSR */
> +			AM62PX_IOPAD(0x1b0, PIN_OUTPUT, 2)	/* (G20) MCASP0_ACLKR */
> +		>;
> +	};
> +};
> +
> +&main_timer0 {
> +	bootph-pre-ram;
> +};
> +
> +&main_uart0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_uart0_pins_default>;
> +	status = "okay";
> +	bootph-pre-ram;
> +};
> +
> +&main_uart1 {
> +	/* Main UART1 is used by TIFS firmware */
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_uart1_pins_default>;
> +	status = "reserved";
> +	bootph-pre-ram;
> +};
> +
> +&cbass_mcu {
> +	bootph-pre-ram;
> +};
> +
> +&mcu_pmx0 {
> +	status = "okay";
> +	bootph-pre-ram;
> +
> +	wkup_uart0_pins_default: wkup-uart0-default-pins {
> +		bootph-pre-ram;
> +		pinctrl-single,pins = <
> +			AM62PX_MCU_IOPAD(0x02c, PIN_INPUT, 0)	/* (C7) WKUP_UART0_CTSn */
> +			AM62PX_MCU_IOPAD(0x030, PIN_OUTPUT, 0)	/* (C6) WKUP_UART0_RTSn */
> +			AM62PX_MCU_IOPAD(0x024, PIN_INPUT, 0)	/* (D8) WKUP_UART0_RXD */
> +			AM62PX_MCU_IOPAD(0x028, PIN_OUTPUT, 0)	/* (D7) WKUP_UART0_TXD */
> +		>;
> +	};
> +};
> +
> +&cbass_wakeup {
> +	bootph-pre-ram;
> +};
> +
> +&wkup_uart0 {
> +	/* WKUP UART0 is used by DM firmware */
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&wkup_uart0_pins_default>;
> +	status = "reserved";
> +	bootph-pre-ram;
> +};
> +
> +&wkup_conf {
> +	bootph-pre-ram;
> +};
> +
> +&chipid {
> +	bootph-pre-ram;
> +};
> +
> +&dmss {
> +	bootph-pre-ram;
> +};
> +
> +&dmsc {
> +	bootph-pre-ram;
> +};
> +
> +&k3_pds {
> +	bootph-pre-ram;
> +};
> +
> +&k3_clks {
> +	bootph-pre-ram;
> +};
> +
> +&k3_reset {
> +	bootph-pre-ram;
> +};
> +
> +&secure_proxy_main {
> +	bootph-pre-ram;
> +};
