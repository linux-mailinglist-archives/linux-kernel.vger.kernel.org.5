Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75EF17BB74A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 14:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbjJFMEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 08:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232154AbjJFMEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 08:04:40 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D115C2;
        Fri,  6 Oct 2023 05:04:37 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 396C4RWS105980;
        Fri, 6 Oct 2023 07:04:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1696593867;
        bh=M6+ry1ovNm/y3J7F8fD7p1PHB+uQxzV/QFgfUqT153g=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=e+I4uTM7mOZMIQdfsp8xSMzIA2LP+YfbwFo+guFWYuF8pwKkp9jPiZEhX0BFV0Yx0
         fD+QnjsSdYGigx05m50GUcV3S9RBiNlhBbQX3rhSJIDdbsXa7uBD6zZevX7EOlwFh1
         EQA8a+eIWtbUevE3MFGe8Qr9L/ZnH5wBx2kmW+8A=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 396C4RYl030453
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 6 Oct 2023 07:04:27 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 6
 Oct 2023 07:04:27 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 6 Oct 2023 07:04:27 -0500
Received: from [10.250.135.44] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 396C4Kvg094970;
        Fri, 6 Oct 2023 07:04:21 -0500
Message-ID: <930b663c-f8bc-569f-a919-01347acdd951@ti.com>
Date:   Fri, 6 Oct 2023 15:04:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 2/3] arm64: dts: ti: Add overlay for NAND daughter card
To:     Nitin Yadav <n-yadav@ti.com>, <nm@ti.com>, <vigneshr@ti.com>
CC:     <kristo@kernel.org>, <robh+dt@kernel.org>, <conor+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20231005093739.4071934-1-n-yadav@ti.com>
 <20231005093739.4071934-3-n-yadav@ti.com>
Content-Language: en-US
From:   Roger Quadros <rogerq@ti.com>
In-Reply-To: <20231005093739.4071934-3-n-yadav@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5.10.2023 12.37, Nitin Yadav wrote:
> Introduce k3-am62-lp-sk-nand.dtso overlay file to support
> the X8 NAND EXPANSION BOARD card (PROC143E1) for AM62x LP SK
> board. NAND has partitions for different boot components as
> below:
> 
> 0x000000000000-0x000000200000 : "NAND.tiboot3
> 0x000000200000-0x000000400000 : "NAND.tispl
> 0x000000400000-0x000000600000 : "NAND.tiboot3.backup
> 0x000000600000-0x000000a00000 : "NAND.u-boot
> 0x000000a00000-0x000000a40000 : "NAND.u-boot-env
> 0x000000a40000-0x000000a80000 : "NAND.u-boot-env.backup
> 0x000000a80000-0x000040000000 : "NAND.file-system
> 
> Disable mcasp1 node in DT to avoid pinmux conflict. Update
> Makefile to include k3-am62-lp-sk-nand.dtso.
> 
> Signed-off-by: Nitin Yadav <n-yadav@ti.com>
> Reviewed-by: Roger Quadros <rogerq@kernel.org>
> ---
>   arch/arm64/boot/dts/ti/Makefile               |   3 +-
>   .../arm64/boot/dts/ti/k3-am62-lp-sk-nand.dtso | 119 ++++++++++++++++++
>   2 files changed, 121 insertions(+), 1 deletion(-)
>   create mode 100644 arch/arm64/boot/dts/ti/k3-am62-lp-sk-nand.dtso
> 
> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
> index b3516419f95d..f6e3ff55f787 100644
> --- a/arch/arm64/boot/dts/ti/Makefile
> +++ b/arch/arm64/boot/dts/ti/Makefile
> @@ -18,7 +18,8 @@ dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-nonwifi-yavia.dtb
>   dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-wifi-dahlia.dtb
>   dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-wifi-dev.dtb
>   dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-wifi-yavia.dtb
> -dtb-$(CONFIG_ARCH_K3) += k3-am62-lp-sk.dtb
> +k3-am62-lp-sk-nand-dtbs := k3-am62-lp-sk.dtb k3-am62-lp-sk-nand.dtbo
> +dtb-$(CONFIG_ARCH_K3) += k3-am62-lp-sk-nand.dtb
>   dtb-$(CONFIG_ARCH_K3) += k3-am62x-sk-hdmi-audio.dtbo
>   
>   # Boards with AM62Ax SoC
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-lp-sk-nand.dtso b/arch/arm64/boot/dts/ti/k3-am62-lp-sk-nand.dtso
> new file mode 100644
> index 000000000000..0f4e26db534b
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-am62-lp-sk-nand.dtso
> @@ -0,0 +1,119 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
> + */
> +
> +/dts-v1/;
> +/plugin/;
> +
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +
> +#include "k3-pinctrl.h"
> +
> +&mcasp1 {
> +	status = "disabled";
> +};
> +
> +&main_pmx0 {
> +	gpmc0_pins_default: gpmc0-pins-default {
> +		pinctrl-single,pins = <
> +			AM62X_IOPAD(0x003c, PIN_INPUT, 0) /* (M25) GPMC0_AD0 */
> +			AM62X_IOPAD(0x0040, PIN_INPUT, 0) /* (N23) GPMC0_AD1 */
> +			AM62X_IOPAD(0x0044, PIN_INPUT, 0) /* (N24) GPMC0_AD2 */
> +			AM62X_IOPAD(0x0048, PIN_INPUT, 0) /* (N25) GPMC0_AD3 */
> +			AM62X_IOPAD(0x004c, PIN_INPUT, 0) /* (P24) GPMC0_AD4 */
> +			AM62X_IOPAD(0x0050, PIN_INPUT, 0) /* (P22) GPMC0_AD5 */
> +			AM62X_IOPAD(0x0054, PIN_INPUT, 0) /* (P21) GPMC0_AD6 */
> +			AM62X_IOPAD(0x0058, PIN_INPUT, 0) /* (R23) GPMC0_AD7 */
> +			AM62X_IOPAD(0x0084, PIN_OUTPUT, 0) /* (L23) GPMC0_ADVn_ALE */
> +			AM62X_IOPAD(0x0088, PIN_OUTPUT, 0) /* (L24) GPMC0_OEn_REn */
> +			AM62X_IOPAD(0x008c, PIN_OUTPUT, 0) /* (L25) GPMC0_WEn */
> +			AM62X_IOPAD(0x0090, PIN_OUTPUT, 0) /* (M24) GPMC0_BE0n_CLE */
> +			AM62X_IOPAD(0x00a8, PIN_OUTPUT, 0) /* (M21) GPMC0_CSn0 */
> +			AM62X_IOPAD(0x0098, PIN_INPUT, 0) /* (U23) GPMC0_WAIT0 */
> +		>;
> +	};
> +};
> +
> +&gpmc0 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&gpmc0_pins_default>;
> +	ranges = <0 0 0x00 0x51000000 0x01000000>; /* CS0 space. Min partition = 16MB */

FYI. This patch will produce warnings during build just like
the AM64 NAND overlay patch.

https://lore.kernel.org/all/20231005132921.2vg6kdcr273bh7et@cabbage/

This also needs to wait till dtc fix is synced into Linux dtc.
https://www.spinics.net/lists/devicetree-compiler/msg04036.html


> +	#address-cells = <2>;
> +	#size-cells = <1>;
> +
> +	nand0_0: nand@0,0 {
> +		compatible = "ti,am64-nand";
> +		reg = <0 0 64>;         /* device IO registers */
> +		interrupt-parent = <&gpmc0>;
> +		interrupts = <0 IRQ_TYPE_NONE>, /* fifoevent */
> +			     <1 IRQ_TYPE_NONE>; /* termcount */
> +		rb-gpios = <&gpmc0 0 GPIO_ACTIVE_HIGH>; /* gpmc_wait0 */
> +		ti,nand-xfer-type = "prefetch-polled";
> +		ti,nand-ecc-opt = "bch8";       /* BCH8: Bootrom limitation */
> +		ti,elm-id = <&elm0>;
> +		nand-bus-width = <8>;
> +		gpmc,device-width = <1>;
> +		gpmc,sync-clk-ps = <0>;
> +		gpmc,cs-on-ns = <0>;
> +		gpmc,cs-rd-off-ns = <40>;
> +		gpmc,cs-wr-off-ns = <40>;
> +		gpmc,adv-on-ns = <0>;
> +		gpmc,adv-rd-off-ns = <25>;
> +		gpmc,adv-wr-off-ns = <25>;
> +		gpmc,we-on-ns = <0>;
> +		gpmc,we-off-ns = <20>;
> +		gpmc,oe-on-ns = <3>;
> +		gpmc,oe-off-ns = <30>;
> +		gpmc,access-ns = <30>;
> +		gpmc,rd-cycle-ns = <40>;
> +		gpmc,wr-cycle-ns = <40>;
> +		gpmc,bus-turnaround-ns = <0>;
> +		gpmc,cycle2cycle-delay-ns = <0>;
> +		gpmc,clk-activation-ns = <0>;
> +		gpmc,wr-access-ns = <40>;
> +		gpmc,wr-data-mux-bus-ns = <0>;
> +
> +		partitions {
> +			compatible = "fixed-partitions";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			partition@0 {
> +				label = "NAND.tiboot3";
> +				reg = <0x00000000 0x00200000>;  /* 2M */
> +			};
> +			partition@200000 {
> +				label = "NAND.tispl";
> +				reg = <0x00200000 0x00200000>;  /* 2M */
> +			};
> +			partition@400000 {
> +				label = "NAND.tiboot3.backup";  /* 2M */
> +				reg = <0x00400000 0x00200000>;  /* BootROM looks at 4M */
> +			};
> +			partition@600000 {
> +				label = "NAND.u-boot";
> +				reg = <0x00600000 0x00400000>;  /* 4M */
> +			};
> +			partition@a00000 {
> +				label = "NAND.u-boot-env";
> +				reg = <0x00a00000 0x00040000>;  /* 256K */
> +			};
> +			partition@a40000 {
> +				label = "NAND.u-boot-env.backup";
> +				reg = <0x00a40000 0x00040000>;  /* 256K */
> +			};
> +			partition@a80000 {
> +				label = "NAND.file-system";
> +				reg = <0x00a80000 0x3f580000>;
> +			};
> +		};
> +	};
> +};
> +
> +&elm0{
> +	status = "okay";
> +};

-- 
cheers,
-roger
