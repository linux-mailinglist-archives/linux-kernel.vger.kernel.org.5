Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3D076BA1F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 18:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233444AbjHAQ4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 12:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233244AbjHAQ4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 12:56:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D89E42114;
        Tue,  1 Aug 2023 09:56:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D7BE61638;
        Tue,  1 Aug 2023 16:56:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DEE0C433C7;
        Tue,  1 Aug 2023 16:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690908977;
        bh=bRSvjQunUP9yovqAQ96bucssEOT5sj5mD8xWzV3Px4Q=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=HmtgyFmrFiQBDoe/wT1NEWRCT2cRd7s/N7x7MFxMaNOwRts1yi5Dt1jlCw0ZtIKYt
         1iAPgviM85CXM05FLS+4jAeH3vy/pmTehsfD+ffIXoG5EYrWmpic3annYv6hnM6Vw6
         rZZd4bl4zlBcUGjgGx20QRHiEONyJs3j7ruY/TtkalEvjiDYl74ODukQd9onsUI3/K
         GLsSULAvewtUGYzOhjBPaYnAaGn8FQAc+okVXYmHCrtGrlLXZB6kTP+pBfEgC41RoS
         RPiUDXTVafRmxqRxuO5MxDMHYK+CBpo3Z7VhyNTU/Vrpdrx/zmFhMWA6xl8v+4Pnum
         izFL+YMCCq9yg==
Message-ID: <64ae76ef-a85a-7cc7-6bc3-a8ea46621d73@kernel.org>
Date:   Tue, 1 Aug 2023 19:56:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v8 2/5] arm64: dts: ti: k3-j784s4-main: Add WIZ and SERDES
 PHY nodes
Content-Language: en-US
To:     Jayesh Choudhary <j-choudhary@ti.com>, nm@ti.com, vigneshr@ti.com
Cc:     s-vadapalli@ti.com, afd@ti.com, kristo@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, a-bhatia1@ti.com, r-ravikumar@ti.com,
        sabiya.d@ti.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230801070019.219660-1-j-choudhary@ti.com>
 <20230801070019.219660-3-j-choudhary@ti.com>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20230801070019.219660-3-j-choudhary@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/08/2023 10:00, Jayesh Choudhary wrote:
> From: Siddharth Vadapalli <s-vadapalli@ti.com>
> 
> J784S4 SoC has 4 Serdes instances along with their respective WIZ
> instances. Add device-tree nodes for them and disable them by default.
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> [j-choudhary@ti.com: fix serdes_wiz clock order & disable serdes refclk]
> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 172 +++++++++++++++++++++
>  1 file changed, 172 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> index 8a816563706b..fbf5ab94d785 100644
> --- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> @@ -6,9 +6,19 @@
>   */
>  
>  #include <dt-bindings/mux/mux.h>
> +#include <dt-bindings/phy/phy.h>
> +#include <dt-bindings/phy/phy-ti.h>
>  
>  #include "k3-serdes.h"
>  
> +/ {
> +	serdes_refclk: serdes-refclk {

standard name should begin with clock

> +		#clock-cells = <0>;
> +		compatible = "fixed-clock";
> +		status = "disabled";
> +	};
> +};
> +
>  &cbass_main {
>  	msmc_ram: sram@70000000 {
>  		compatible = "mmio-sram";
> @@ -709,6 +719,168 @@ main_sdhci1: mmc@4fb0000 {
>  		status = "disabled";
>  	};
>  
> +	serdes_wiz0: wiz@5060000 {
> +		compatible = "ti,j784s4-wiz-10g";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		power-domains = <&k3_pds 404 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 404 2>, <&k3_clks 404 6>, <&serdes_refclk>, <&k3_clks 404 5>;
> +		clock-names = "fck", "core_ref_clk", "ext_ref_clk", "core_ref1_clk";
> +		assigned-clocks = <&k3_clks 404 6>;
> +		assigned-clock-parents = <&k3_clks 404 10>;
> +		num-lanes = <4>;
> +		#reset-cells = <1>;
> +		#clock-cells = <1>;
> +		ranges = <0x5060000 0x00 0x5060000 0x10000>;
> +> +		status = "disabled";
> +
drop blank lines here and rest of this file where you set status to "disabled".

> +		serdes0: serdes@5060000 {

phy@5060000

> +			compatible = "ti,j721e-serdes-10g";
> +			reg = <0x05060000 0x010000>;
> +			reg-names = "torrent_phy";
> +			resets = <&serdes_wiz0 0>;
> +			reset-names = "torrent_reset";
> +			clocks = <&serdes_wiz0 TI_WIZ_PLL0_REFCLK>,
> +				 <&serdes_wiz0 TI_WIZ_PHY_EN_REFCLK>;
> +			clock-names = "refclk", "phy_en_refclk";
> +			assigned-clocks = <&serdes_wiz0 TI_WIZ_PLL0_REFCLK>,
> +					  <&serdes_wiz0 TI_WIZ_PLL1_REFCLK>,
> +					  <&serdes_wiz0 TI_WIZ_REFCLK_DIG>;
> +			assigned-clock-parents = <&k3_clks 404 6>,
> +						 <&k3_clks 404 6>,
> +						 <&k3_clks 404 6>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			#clock-cells = <1>;
> +
> +			status = "disabled";
> +		};
> +	};
> +
> +	serdes_wiz1: wiz@5070000 {
> +		compatible = "ti,j784s4-wiz-10g";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		power-domains = <&k3_pds 405 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 405 2>, <&k3_clks 405 6>, <&serdes_refclk>, <&k3_clks 405 5>;
> +		clock-names = "fck", "core_ref_clk", "ext_ref_clk", "core_ref1_clk";
> +		assigned-clocks = <&k3_clks 405 6>;
> +		assigned-clock-parents = <&k3_clks 405 10>;
> +		num-lanes = <4>;
> +		#reset-cells = <1>;
> +		#clock-cells = <1>;
> +		ranges = <0x05070000 0x00 0x05070000 0x10000>;
> +
> +		status = "disabled";
> +
> +		serdes1: serdes@5070000 {

phy@5070000
> +			compatible = "ti,j721e-serdes-10g";
> +			reg = <0x05070000 0x010000>;
> +			reg-names = "torrent_phy";
> +			resets = <&serdes_wiz1 0>;
> +			reset-names = "torrent_reset";
> +			clocks = <&serdes_wiz1 TI_WIZ_PLL0_REFCLK>,
> +				 <&serdes_wiz1 TI_WIZ_PHY_EN_REFCLK>;
> +			clock-names = "refclk", "phy_en_refclk";
> +			assigned-clocks = <&serdes_wiz1 TI_WIZ_PLL0_REFCLK>,
> +					  <&serdes_wiz1 TI_WIZ_PLL1_REFCLK>,
> +					  <&serdes_wiz1 TI_WIZ_REFCLK_DIG>;
> +			assigned-clock-parents = <&k3_clks 405 6>,
> +						 <&k3_clks 405 6>,
> +						 <&k3_clks 405 6>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			#clock-cells = <1>;
> +
> +			status = "disabled";
> +		};
> +	};
> +
> +	serdes_wiz2: wiz@5020000 {
> +		compatible = "ti,j784s4-wiz-10g";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		power-domains = <&k3_pds 406 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 406 2>, <&k3_clks 406 6>, <&serdes_refclk>, <&k3_clks 406 5>;
> +		clock-names = "fck", "core_ref_clk", "ext_ref_clk", "core_ref1_clk";
> +		assigned-clocks = <&k3_clks 406 6>;
> +		assigned-clock-parents = <&k3_clks 406 10>;
> +		num-lanes = <4>;
> +		#reset-cells = <1>;
> +		#clock-cells = <1>;
> +		ranges = <0x05020000 0x00 0x05020000 0x10000>;
> +
> +		status = "disabled";
> +
> +		serdes2: serdes@5020000 {

phy@5020000

> +			compatible = "ti,j721e-serdes-10g";
> +			reg = <0x05020000 0x010000>;
> +			reg-names = "torrent_phy";
> +			resets = <&serdes_wiz2 0>;
> +			reset-names = "torrent_reset";
> +			clocks = <&serdes_wiz2 TI_WIZ_PLL0_REFCLK>,
> +				 <&serdes_wiz2 TI_WIZ_PHY_EN_REFCLK>;
> +			clock-names = "refclk", "phy_en_refclk";
> +			assigned-clocks = <&serdes_wiz2 TI_WIZ_PLL0_REFCLK>,
> +					  <&serdes_wiz2 TI_WIZ_PLL1_REFCLK>,
> +					  <&serdes_wiz2 TI_WIZ_REFCLK_DIG>;
> +			assigned-clock-parents = <&k3_clks 406 6>,
> +						 <&k3_clks 406 6>,
> +						 <&k3_clks 406 6>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			#clock-cells = <1>;
> +
> +			status = "disabled";
> +		};
> +	};
> +
> +	serdes_wiz4: wiz@5050000 {
> +		compatible = "ti,j784s4-wiz-10g";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		power-domains = <&k3_pds 407 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 407 2>, <&k3_clks 407 6>, <&serdes_refclk>, <&k3_clks 407 5>;
> +		clock-names = "fck", "core_ref_clk", "ext_ref_clk", "core_ref1_clk";
> +		assigned-clocks = <&k3_clks 407 6>;
> +		assigned-clock-parents = <&k3_clks 407 10>;
> +		num-lanes = <4>;
> +		#reset-cells = <1>;
> +		#clock-cells = <1>;
> +		ranges = <0x05050000 0x00 0x05050000 0x10000>,
> +			 <0xa030a00 0x00 0xa030a00 0x40>; /* DPTX PHY */
> +
> +		status = "disabled";
> +
> +		serdes4: serdes@5050000 {

phy@5050000

> +			/*
> +			 * Note: we also map DPTX PHY registers as the Torrent
> +			 * needs to manage those.
> +			 */
> +			compatible = "ti,j721e-serdes-10g";
> +			reg = <0x05050000 0x010000>,
> +			      <0x0a030a00 0x40>; /* DPTX PHY */
> +			reg-names = "torrent_phy";
> +			resets = <&serdes_wiz4 0>;
> +			reset-names = "torrent_reset";
> +			clocks = <&serdes_wiz4 TI_WIZ_PLL0_REFCLK>,
> +				 <&serdes_wiz4 TI_WIZ_PHY_EN_REFCLK>;
> +			clock-names = "refclk", "phy_en_refclk";
> +			assigned-clocks = <&serdes_wiz4 TI_WIZ_PLL0_REFCLK>,
> +					  <&serdes_wiz4 TI_WIZ_PLL1_REFCLK>,
> +					  <&serdes_wiz4 TI_WIZ_REFCLK_DIG>;
> +			assigned-clock-parents = <&k3_clks 407 6>,
> +						 <&k3_clks 407 6>,
> +						 <&k3_clks 407 6>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			#clock-cells = <1>;
> +
> +			status = "disabled";
> +		};
> +	};
> +
>  	main_navss: bus@30000000 {
>  		compatible = "simple-bus";
>  		#address-cells = <2>;

-- 
cheers,
-roger
