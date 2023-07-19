Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7287591E5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 11:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjGSJpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 05:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjGSJp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 05:45:27 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499181BE4;
        Wed, 19 Jul 2023 02:45:23 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36J9jFGm037558;
        Wed, 19 Jul 2023 04:45:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1689759915;
        bh=6k8nWeTmJSA+oC1ZHw0onB2rmqB4/nI626R3nCHO7Fc=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=u6oVchi7Rtom/0P34iqA5NK6TT4vKLtV5HP2oZu8xXKSumu0KvVGHsXKQN+To42TW
         WlFo6UUU4Tn4H3pt8Fi6outuPBDhn/5ZHT1B0amWuxrl0YQHHYWyeEdL+SZj/r4ST/
         TJrguvV3OYFUy70mhTyGhg6/FeDeWvVG7VfSkfSY=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36J9jFJG018999
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 19 Jul 2023 04:45:15 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 19
 Jul 2023 04:45:14 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 19 Jul 2023 04:45:14 -0500
Received: from [172.24.227.83] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36J9jACH050339;
        Wed, 19 Jul 2023 04:45:11 -0500
Message-ID: <24fa9784-7781-7259-d53a-a76a017198f1@ti.com>
Date:   Wed, 19 Jul 2023 15:15:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 2/2] arm64: dts: ti: k3-j721s2: Add overlay to enable
 main CPSW2G with GESI
Content-Language: en-US
To:     Siddharth Vadapalli <s-vadapalli@ti.com>, <nm@ti.com>,
        <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <afd@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Ravi Gunasekaran <r-gunasekaran@ti.com>
References: <20230710094328.1359377-1-s-vadapalli@ti.com>
 <20230710094328.1359377-3-s-vadapalli@ti.com>
From:   Ravi Gunasekaran <r-gunasekaran@ti.com>
In-Reply-To: <20230710094328.1359377-3-s-vadapalli@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/10/23 3:13 PM, Siddharth Vadapalli wrote:
> From: Kishon Vijay Abraham I <kishon@ti.com>
> 
> The MAIN CPSW2G instance of CPSW on J721S2 SoC can be enabled with the GESI
> Expansion Board connected to the J7 Common-Proc-Board. Use the overlay
> to enable this.
> 
> Add alias for the MAIN CPSW2G port to enable kernel to fetch MAC address
> directly from U-Boot.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
>  arch/arm64/boot/dts/ti/Makefile               |  2 +
>  .../dts/ti/k3-j721s2-evm-gesi-exp-board.dtso  | 85 +++++++++++++++++++
>  2 files changed, 87 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/ti/k3-j721s2-evm-gesi-exp-board.dtso
> 
> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
> index 6dd7b6f1d6ab..019a8be19b93 100644
> --- a/arch/arm64/boot/dts/ti/Makefile
> +++ b/arch/arm64/boot/dts/ti/Makefile
> @@ -51,6 +51,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-j721e-sk.dtb
>  # Boards with J721s2 SoC
>  dtb-$(CONFIG_ARCH_K3) += k3-am68-sk-base-board.dtb
>  dtb-$(CONFIG_ARCH_K3) += k3-j721s2-common-proc-board.dtb
> +dtb-$(CONFIG_ARCH_K3) += k3-j721s2-evm-gesi-exp-board.dtbo
>  
>  # Boards with J784s4 SoC
>  dtb-$(CONFIG_ARCH_K3) += k3-am69-sk.dtb
> @@ -58,3 +59,4 @@ dtb-$(CONFIG_ARCH_K3) += k3-j784s4-evm.dtb
>  
>  # Enable support for device-tree overlays
>  DTC_FLAGS_k3-am6548-iot2050-advanced-m2 += -@
> +DTC_FLAGS_k3-j721s2-common-proc-board += -@
> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-evm-gesi-exp-board.dtso b/arch/arm64/boot/dts/ti/k3-j721s2-evm-gesi-exp-board.dtso
> new file mode 100644
> index 000000000000..9ababfeef904
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-evm-gesi-exp-board.dtso
> @@ -0,0 +1,85 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/**
> + * DT Overlay for MAIN CPSW2G using GESI Expansion Board with J7 common processor board.
> + *
> + * GESI Board Product Link: https://www.ti.com/tool/J7EXPCXEVM
> + *
> + * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
> + */
> +
> +/dts-v1/;
> +/plugin/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/net/ti-dp83867.h>
> +
> +#include "k3-pinctrl.h"
> +
> +&{/} {
> +	aliases {
> +		ethernet1 = "/bus@100000/ethernet@c200000/ethernet-ports/port@1";
> +	};
> +};
> +
> +&main_pmx0 {
> +	main_cpsw_mdio_pins_default: main-cpsw-mdio-pins-default {
> +		pinctrl-single,pins = <
> +			J721S2_IOPAD(0x0c0, PIN_OUTPUT, 6) /* (T28) MCASP1_AXR0.MDIO0_MDC */
> +			J721S2_IOPAD(0x0bc, PIN_INPUT, 6) /* (V28) MCASP1_AFSX.MDIO0_MDIO */
> +		>;
> +	};
> +
> +	rgmii1_pins_default: rgmii1-pins-default {
> +		pinctrl-single,pins = <
> +			J721S2_IOPAD(0x0b8, PIN_INPUT, 6) /* (AA24) MCASP1_ACLKX.RGMII1_RD0 */
> +			J721S2_IOPAD(0x0a0, PIN_INPUT, 6) /* (AB25) MCASP0_AXR12.RGMII1_RD1 */
> +			J721S2_IOPAD(0x0a4, PIN_INPUT, 6) /* (T23) MCASP0_AXR13.RGMII1_RD2 */
> +			J721S2_IOPAD(0x0a8, PIN_INPUT, 6) /* (U24) MCASP0_AXR14.RGMII1_RD3 */
> +			J721S2_IOPAD(0x0b0, PIN_INPUT, 6) /* (AD26) MCASP1_AXR3.RGMII1_RXC */
> +			J721S2_IOPAD(0x0ac, PIN_INPUT, 6) /* (AC25) MCASP0_AXR15.RGMII1_RX_CTL */
> +			J721S2_IOPAD(0x08c, PIN_OUTPUT, 6) /* (T25) MCASP0_AXR7.RGMII1_TD0 */
> +			J721S2_IOPAD(0x090, PIN_OUTPUT, 6) /* (W24) MCASP0_AXR8.RGMII1_TD1 */
> +			J721S2_IOPAD(0x094, PIN_OUTPUT, 6) /* (AA25) MCASP0_AXR9.RGMII1_TD2 */
> +			J721S2_IOPAD(0x098, PIN_OUTPUT, 6) /* (V25) MCASP0_AXR10.RGMII1_TD3 */
> +			J721S2_IOPAD(0x0b4, PIN_OUTPUT, 6) /* (U25) MCASP1_AXR4.RGMII1_TXC */
> +			J721S2_IOPAD(0x09c, PIN_OUTPUT, 6) /* (T24) MCASP0_AXR11.RGMII1_TX_CTL */
> +		>;
> +	};
> +};
> +
> +&exp1 {
> +	p15 {
> +		/* P15 - EXP_MUX2 */
> +		gpio-hog;
> +		gpios = <13 GPIO_ACTIVE_HIGH>;
> +		output-high;
> +		line-name = "EXP_MUX2";
> +	};
> +};
> +
> +&main_cpsw {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&rgmii1_pins_default>;
> +};
> +
> +&main_cpsw_mdio {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_cpsw_mdio_pins_default>;
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	main_cpsw_phy0: ethernet-phy@0 {
> +		reg = <0>;
> +		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
> +		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
> +		ti,min-output-impedance;
> +	};
> +};
> +
> +&main_cpsw_port1 {
> +	status = "okay";
> +	phy-mode = "rgmii-rxid";
> +	phy-handle = <&main_cpsw_phy0>;
> +};

Reviewed-by: Ravi Gunasekaran <r-gunasekaran@ti.com>

-- 
Regards,
Ravi
