Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1A887EE7EC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 20:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjKPT7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 14:59:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKPT7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 14:59:24 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC33196;
        Thu, 16 Nov 2023 11:59:17 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AGJx5dE122289;
        Thu, 16 Nov 2023 13:59:05 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1700164745;
        bh=xAv6mdk1i22ngG4jhyo/6Zdw+x5QwPe1Y8LkmFmYFBY=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=Eb0vDyk/zyNPxy5CLxAspoayQf2JhXlE2XLf/K1/Dv5YdgO37rFS8UvQwN6/3hEmM
         lVczIqj3XTNWPVUapjgXYtqcR44ClYboQTJTKqX+sEg73Sjpam1bbYGGG1uZSFhDvr
         A5o2POLfAQHWHi7C0x9S41mKzLGaljDDpqsJVq50=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AGJx5nI023009
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 16 Nov 2023 13:59:05 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 16
 Nov 2023 13:59:04 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 16 Nov 2023 13:59:04 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AGJx4Fs031195;
        Thu, 16 Nov 2023 13:59:04 -0600
Date:   Thu, 16 Nov 2023 13:59:04 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Andrew Davis <afd@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: dts: keystone: Reduce soc0 node content indent level
Message-ID: <20231116195904.7lppxahgyzcvhf4e@bless>
References: <20231116164936.87975-1-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231116164936.87975-1-afd@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any reason why linux-arm-kernel@lists.infradead.org which is listed in
MAINTAINERS is skipped?

On 10:49-20231116, Andrew Davis wrote:
> When the soc0 node was switched to a phandle it decreased the indention
> level but we only did that for the node name to reduce churn. Let's go and
> make the rest of the change now that this DT has solidified and shouldn't
> see as many conflicting changes per cycle.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>  .../boot/dts/ti/keystone/keystone-k2e-evm.dts |  39 +-
>  .../boot/dts/ti/keystone/keystone-k2e.dtsi    | 252 +++----
>  .../dts/ti/keystone/keystone-k2hk-evm.dts     |  62 +-
>  .../boot/dts/ti/keystone/keystone-k2hk.dtsi   | 426 +++++------
>  .../boot/dts/ti/keystone/keystone-k2l-evm.dts |  14 +-
>  .../boot/dts/ti/keystone/keystone-k2l.dtsi    | 664 +++++++++---------
>  6 files changed, 728 insertions(+), 729 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/ti/keystone/keystone-k2e-evm.dts b/arch/arm/boot/dts/ti/keystone/keystone-k2e-evm.dts
> index 6978d6a362f3f..29684fd0d9ef6 100644
> --- a/arch/arm/boot/dts/ti/keystone/keystone-k2e-evm.dts
> +++ b/arch/arm/boot/dts/ti/keystone/keystone-k2e-evm.dts
> @@ -28,29 +28,28 @@ dsp_common_memory: dsp-common-memory@81f800000 {
>  };
>  
>  &soc0 {
> +	clocks {
> +		refclksys: refclksys {
> +			#clock-cells = <0>;
> +			compatible = "fixed-clock";
> +			clock-frequency = <100000000>;
> +			clock-output-names = "refclk-sys";
> +		};
>  
> -		clocks {
> -			refclksys: refclksys {
> -				#clock-cells = <0>;
> -				compatible = "fixed-clock";
> -				clock-frequency = <100000000>;
> -				clock-output-names = "refclk-sys";
> -			};
> -
> -			refclkpass: refclkpass {
> -				#clock-cells = <0>;
> -				compatible = "fixed-clock";
> -				clock-frequency = <100000000>;
> -				clock-output-names = "refclk-pass";
> -			};
> +		refclkpass: refclkpass {
> +			#clock-cells = <0>;
> +			compatible = "fixed-clock";
> +			clock-frequency = <100000000>;
> +			clock-output-names = "refclk-pass";
> +		};
>  
> -			refclkddr3a: refclkddr3a {
> -				#clock-cells = <0>;
> -				compatible = "fixed-clock";
> -				clock-frequency = <100000000>;
> -				clock-output-names = "refclk-ddr3a";
> -			};
> +		refclkddr3a: refclkddr3a {
> +			#clock-cells = <0>;
> +			compatible = "fixed-clock";
> +			clock-frequency = <100000000>;
> +			clock-output-names = "refclk-ddr3a";
>  		};
> +	};
>  };
>  
>  &usb_phy {
> diff --git a/arch/arm/boot/dts/ti/keystone/keystone-k2e.dtsi b/arch/arm/boot/dts/ti/keystone/keystone-k2e.dtsi
> index 65c32946c5223..dc30a126db022 100644
> --- a/arch/arm/boot/dts/ti/keystone/keystone-k2e.dtsi
> +++ b/arch/arm/boot/dts/ti/keystone/keystone-k2e.dtsi
> @@ -48,151 +48,151 @@ aliases {
>  };
>  
>  &soc0 {
> -		/include/ "keystone-k2e-clocks.dtsi"
> +	/include/ "keystone-k2e-clocks.dtsi"
>  
> -		usb: usb@2680000 {
> +	usb: usb@2680000 {
> +		interrupts = <GIC_SPI 152 IRQ_TYPE_EDGE_RISING>;
> +		usb@2690000 {
>  			interrupts = <GIC_SPI 152 IRQ_TYPE_EDGE_RISING>;
> -			usb@2690000 {
> -				interrupts = <GIC_SPI 152 IRQ_TYPE_EDGE_RISING>;
> -			};
>  		};
> +	};
>  
> -		usb1_phy: usb_phy@2620750 {
> -			compatible = "ti,keystone-usbphy";
> -			#address-cells = <1>;
> -			#size-cells = <1>;
> -			reg = <0x2620750 24>;
> -			status = "disabled";
> -		};
> +	usb1_phy: usb_phy@2620750 {
> +		compatible = "ti,keystone-usbphy";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		reg = <0x2620750 24>;
> +		status = "disabled";
> +	};
>  
> -		keystone_usb1: usb@25000000 {
> -			compatible = "ti,keystone-dwc3";
> -			#address-cells = <1>;
> -			#size-cells = <1>;
> -			reg = <0x25000000 0x10000>;
> -			clocks = <&clkusb1>;
> -			clock-names = "usb";
> +	keystone_usb1: usb@25000000 {
> +		compatible = "ti,keystone-dwc3";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		reg = <0x25000000 0x10000>;
> +		clocks = <&clkusb1>;
> +		clock-names = "usb";
> +		interrupts = <GIC_SPI 414 IRQ_TYPE_EDGE_RISING>;
> +		ranges;
> +		dma-coherent;
> +		dma-ranges;
> +		status = "disabled";
> +
> +		usb1: usb@25010000 {
> +			compatible = "snps,dwc3";
> +			reg = <0x25010000 0x70000>;
>  			interrupts = <GIC_SPI 414 IRQ_TYPE_EDGE_RISING>;
> -			ranges;
> -			dma-coherent;
> -			dma-ranges;
> -			status = "disabled";
> -
> -			usb1: usb@25010000 {
> -				compatible = "snps,dwc3";
> -				reg = <0x25010000 0x70000>;
> -				interrupts = <GIC_SPI 414 IRQ_TYPE_EDGE_RISING>;
> -				usb-phy = <&usb1_phy>, <&usb1_phy>;
> -			};
> +			usb-phy = <&usb1_phy>, <&usb1_phy>;
>  		};
> +	};
>  
> -		msm_ram: sram@c000000 {
> -			compatible = "mmio-sram";
> -			reg = <0x0c000000 0x200000>;
> -			ranges = <0x0 0x0c000000 0x200000>;
> -			#address-cells = <1>;
> -			#size-cells = <1>;
> +	msm_ram: sram@c000000 {
> +		compatible = "mmio-sram";
> +		reg = <0x0c000000 0x200000>;
> +		ranges = <0x0 0x0c000000 0x200000>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
>  
> -			bm-sram@1f0000 {
> -				reg = <0x001f0000 0x8000>;
> -			};
> +		bm-sram@1f0000 {
> +			reg = <0x001f0000 0x8000>;
>  		};
> +	};
>  
> -		psc: power-sleep-controller@2350000 {
> -			pscrst: reset-controller {
> -				compatible = "ti,k2e-pscrst", "ti,syscon-reset";
> -				#reset-cells = <1>;
> +	psc: power-sleep-controller@2350000 {
> +		pscrst: reset-controller {
> +			compatible = "ti,k2e-pscrst", "ti,syscon-reset";
> +			#reset-cells = <1>;
>  
> -				ti,reset-bits = <
> -					0xa3c 8 0xa3c 8 0x83c 8 (ASSERT_CLEAR | DEASSERT_SET | STATUS_CLEAR) /* 0: dsp0 */
> -				>;
> -			};
> +			ti,reset-bits = <
> +				0xa3c 8 0xa3c 8 0x83c 8 (ASSERT_CLEAR | DEASSERT_SET | STATUS_CLEAR) /* 0: dsp0 */
> +			>;
>  		};
> +	};
>  
> -		devctrl: device-state-control@2620000 {
> -			dspgpio0: keystone_dsp_gpio@240 {
> -				compatible = "ti,keystone-dsp-gpio";
> -				reg = <0x240 0x4>;
> -				gpio-controller;
> -				#gpio-cells = <2>;
> -				gpio,syscon-dev = <&devctrl 0x240>;
> -			};
> +	devctrl: device-state-control@2620000 {
> +		dspgpio0: keystone_dsp_gpio@240 {
> +			compatible = "ti,keystone-dsp-gpio";
> +			reg = <0x240 0x4>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			gpio,syscon-dev = <&devctrl 0x240>;
>  		};
> +	};
>  
> -		dsp0: dsp@10800000 {
> -			compatible = "ti,k2e-dsp";
> -			reg = <0x10800000 0x00080000>,
> -			      <0x10e00000 0x00008000>,
> -			      <0x10f00000 0x00008000>;
> -			reg-names = "l2sram", "l1pram", "l1dram";
> -			clocks = <&clkgem0>;
> -			ti,syscon-dev = <&devctrl 0x844>;
> -			resets = <&pscrst 0>;
> -			interrupt-parent = <&kirq0>;
> -			interrupts = <0 8>;
> -			interrupt-names = "vring", "exception";
> -			kick-gpios = <&dspgpio0 27 0>;
> -			status = "disabled";
> -		};
> +	dsp0: dsp@10800000 {
> +		compatible = "ti,k2e-dsp";
> +		reg = <0x10800000 0x00080000>,
> +		      <0x10e00000 0x00008000>,
> +		      <0x10f00000 0x00008000>;
> +		reg-names = "l2sram", "l1pram", "l1dram";
> +		clocks = <&clkgem0>;
> +		ti,syscon-dev = <&devctrl 0x844>;
> +		resets = <&pscrst 0>;
> +		interrupt-parent = <&kirq0>;
> +		interrupts = <0 8>;
> +		interrupt-names = "vring", "exception";
> +		kick-gpios = <&dspgpio0 27 0>;
> +		status = "disabled";
> +	};
>  
> -		pcie1: pcie@21020000 {
> -			compatible = "ti,keystone-pcie","snps,dw-pcie";
> -			clocks = <&clkpcie1>;
> -			clock-names = "pcie";
> -			#address-cells = <3>;
> -			#size-cells = <2>;
> -			reg = <0x21021000 0x2000>, <0x21020000 0x1000>, <0x02620128 4>;
> -			ranges = <0x82000000 0 0x60000000 0x60000000
> -				  0 0x10000000>;
> -
> -			status = "disabled";
> -			device_type = "pci";
> -			num-lanes = <2>;
> -			bus-range = <0x00 0xff>;
> -
> -			/* error interrupt */
> -			interrupts = <GIC_SPI 385 IRQ_TYPE_EDGE_RISING>;
> +	pcie1: pcie@21020000 {
> +		compatible = "ti,keystone-pcie","snps,dw-pcie";
> +		clocks = <&clkpcie1>;
> +		clock-names = "pcie";
> +		#address-cells = <3>;
> +		#size-cells = <2>;
> +		reg = <0x21021000 0x2000>, <0x21020000 0x1000>, <0x02620128 4>;
> +		ranges = <0x82000000 0 0x60000000 0x60000000
> +			  0 0x10000000>;
> +
> +		status = "disabled";
> +		device_type = "pci";
> +		num-lanes = <2>;
> +		bus-range = <0x00 0xff>;
> +
> +		/* error interrupt */
> +		interrupts = <GIC_SPI 385 IRQ_TYPE_EDGE_RISING>;
> +		#interrupt-cells = <1>;
> +		interrupt-map-mask = <0 0 0 7>;
> +		interrupt-map = <0 0 0 1 &pcie_intc1 0>, /* INT A */
> +				<0 0 0 2 &pcie_intc1 1>, /* INT B */
> +				<0 0 0 3 &pcie_intc1 2>, /* INT C */
> +				<0 0 0 4 &pcie_intc1 3>; /* INT D */
> +
> +		pcie_msi_intc1: msi-interrupt-controller {
> +			interrupt-controller;
>  			#interrupt-cells = <1>;
> -			interrupt-map-mask = <0 0 0 7>;
> -			interrupt-map = <0 0 0 1 &pcie_intc1 0>, /* INT A */
> -					<0 0 0 2 &pcie_intc1 1>, /* INT B */
> -					<0 0 0 3 &pcie_intc1 2>, /* INT C */
> -					<0 0 0 4 &pcie_intc1 3>; /* INT D */
> -
> -			pcie_msi_intc1: msi-interrupt-controller {
> -				interrupt-controller;
> -				#interrupt-cells = <1>;
> -				interrupt-parent = <&gic>;
> -				interrupts = <GIC_SPI 377 IRQ_TYPE_EDGE_RISING>,
> -					<GIC_SPI 378 IRQ_TYPE_EDGE_RISING>,
> -					<GIC_SPI 379 IRQ_TYPE_EDGE_RISING>,
> -					<GIC_SPI 380 IRQ_TYPE_EDGE_RISING>,
> -					<GIC_SPI 381 IRQ_TYPE_EDGE_RISING>,
> -					<GIC_SPI 382 IRQ_TYPE_EDGE_RISING>,
> -					<GIC_SPI 383 IRQ_TYPE_EDGE_RISING>,
> -					<GIC_SPI 384 IRQ_TYPE_EDGE_RISING>;
> -			};
> -
> -			pcie_intc1: legacy-interrupt-controller {
> -				interrupt-controller;
> -				#interrupt-cells = <1>;
> -				interrupt-parent = <&gic>;
> -				interrupts = <GIC_SPI 373 IRQ_TYPE_EDGE_RISING>,
> -					<GIC_SPI 374 IRQ_TYPE_EDGE_RISING>,
> -					<GIC_SPI 375 IRQ_TYPE_EDGE_RISING>,
> -					<GIC_SPI 376 IRQ_TYPE_EDGE_RISING>;
> -			};
> +			interrupt-parent = <&gic>;
> +			interrupts = <GIC_SPI 377 IRQ_TYPE_EDGE_RISING>,
> +				<GIC_SPI 378 IRQ_TYPE_EDGE_RISING>,
> +				<GIC_SPI 379 IRQ_TYPE_EDGE_RISING>,
> +				<GIC_SPI 380 IRQ_TYPE_EDGE_RISING>,
> +				<GIC_SPI 381 IRQ_TYPE_EDGE_RISING>,
> +				<GIC_SPI 382 IRQ_TYPE_EDGE_RISING>,
> +				<GIC_SPI 383 IRQ_TYPE_EDGE_RISING>,
> +				<GIC_SPI 384 IRQ_TYPE_EDGE_RISING>;
>  		};
>  
> -		mdio: mdio@24200f00 {
> -			compatible = "ti,keystone_mdio", "ti,davinci_mdio";
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -			reg = <0x24200f00 0x100>;
> -			status = "disabled";
> -			clocks = <&clkcpgmac>;
> -			clock-names = "fck";
> -			bus_freq = <2500000>;
> +		pcie_intc1: legacy-interrupt-controller {
> +			interrupt-controller;
> +			#interrupt-cells = <1>;
> +			interrupt-parent = <&gic>;
> +			interrupts = <GIC_SPI 373 IRQ_TYPE_EDGE_RISING>,
> +				<GIC_SPI 374 IRQ_TYPE_EDGE_RISING>,
> +				<GIC_SPI 375 IRQ_TYPE_EDGE_RISING>,
> +				<GIC_SPI 376 IRQ_TYPE_EDGE_RISING>;
>  		};
> -		/include/ "keystone-k2e-netcp.dtsi"
> +	};
> +
> +	mdio: mdio@24200f00 {
> +		compatible = "ti,keystone_mdio", "ti,davinci_mdio";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		reg = <0x24200f00 0x100>;
> +		status = "disabled";
> +		clocks = <&clkcpgmac>;
> +		clock-names = "fck";
> +		bus_freq = <2500000>;
> +	};
> +	/include/ "keystone-k2e-netcp.dtsi"
>  };
> diff --git a/arch/arm/boot/dts/ti/keystone/keystone-k2hk-evm.dts b/arch/arm/boot/dts/ti/keystone/keystone-k2hk-evm.dts
> index 206df8a8d9dd7..15ee877232864 100644
> --- a/arch/arm/boot/dts/ti/keystone/keystone-k2hk-evm.dts
> +++ b/arch/arm/boot/dts/ti/keystone/keystone-k2hk-evm.dts
> @@ -51,42 +51,42 @@ led-debug-3 {
>  };
>  
>  &soc0 {
> -		clocks {
> -			refclksys: refclksys {
> -				#clock-cells = <0>;
> -				compatible = "fixed-clock";
> -				clock-frequency = <122880000>;
> -				clock-output-names = "refclk-sys";
> -			};
> +	clocks {
> +		refclksys: refclksys {
> +			#clock-cells = <0>;
> +			compatible = "fixed-clock";
> +			clock-frequency = <122880000>;
> +			clock-output-names = "refclk-sys";
> +		};
>  
> -			refclkpass: refclkpass {
> -				#clock-cells = <0>;
> -				compatible = "fixed-clock";
> -				clock-frequency = <122880000>;
> -				clock-output-names = "refclk-pass";
> -			};
> +		refclkpass: refclkpass {
> +			#clock-cells = <0>;
> +			compatible = "fixed-clock";
> +			clock-frequency = <122880000>;
> +			clock-output-names = "refclk-pass";
> +		};
>  
> -			refclkarm: refclkarm {
> -				#clock-cells = <0>;
> -				compatible = "fixed-clock";
> -				clock-frequency = <125000000>;
> -				clock-output-names = "refclk-arm";
> -			};
> +		refclkarm: refclkarm {
> +			#clock-cells = <0>;
> +			compatible = "fixed-clock";
> +			clock-frequency = <125000000>;
> +			clock-output-names = "refclk-arm";
> +		};
>  
> -			refclkddr3a: refclkddr3a {
> -				#clock-cells = <0>;
> -				compatible = "fixed-clock";
> -				clock-frequency = <100000000>;
> -				clock-output-names = "refclk-ddr3a";
> -			};
> +		refclkddr3a: refclkddr3a {
> +			#clock-cells = <0>;
> +			compatible = "fixed-clock";
> +			clock-frequency = <100000000>;
> +			clock-output-names = "refclk-ddr3a";
> +		};
>  
> -			refclkddr3b: refclkddr3b {
> -				#clock-cells = <0>;
> -				compatible = "fixed-clock";
> -				clock-frequency = <100000000>;
> -				clock-output-names = "refclk-ddr3b";
> -			};
> +		refclkddr3b: refclkddr3b {
> +			#clock-cells = <0>;
> +			compatible = "fixed-clock";
> +			clock-frequency = <100000000>;
> +			clock-output-names = "refclk-ddr3b";
>  		};
> +	};
>  };
>  
>  &usb_phy {
> diff --git a/arch/arm/boot/dts/ti/keystone/keystone-k2hk.dtsi b/arch/arm/boot/dts/ti/keystone/keystone-k2hk.dtsi
> index da6d3934c2e88..8a898ed25b6f3 100644
> --- a/arch/arm/boot/dts/ti/keystone/keystone-k2hk.dtsi
> +++ b/arch/arm/boot/dts/ti/keystone/keystone-k2hk.dtsi
> @@ -55,241 +55,241 @@ aliases {
>  };
>  
>  &soc0 {
> -		/include/ "keystone-k2hk-clocks.dtsi"
> +	/include/ "keystone-k2hk-clocks.dtsi"
>  
> -		msm_ram: sram@c000000 {
> -			compatible = "mmio-sram";
> -			reg = <0x0c000000 0x600000>;
> -			ranges = <0x0 0x0c000000 0x600000>;
> -			#address-cells = <1>;
> -			#size-cells = <1>;
> +	msm_ram: sram@c000000 {
> +		compatible = "mmio-sram";
> +		reg = <0x0c000000 0x600000>;
> +		ranges = <0x0 0x0c000000 0x600000>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
>  
> -			bm-sram@5f0000 {
> -				reg = <0x5f0000 0x8000>;
> -			};
> +		bm-sram@5f0000 {
> +			reg = <0x5f0000 0x8000>;
>  		};
> +	};
>  
> -		psc: power-sleep-controller@2350000 {
> -			pscrst: reset-controller {
> -				compatible = "ti,k2hk-pscrst", "ti,syscon-reset";
> -				#reset-cells = <1>;
> +	psc: power-sleep-controller@2350000 {
> +		pscrst: reset-controller {
> +			compatible = "ti,k2hk-pscrst", "ti,syscon-reset";
> +			#reset-cells = <1>;
>  
> -				ti,reset-bits = <
> -					0xa3c 8 0xa3c 8 0x83c 8 (ASSERT_CLEAR | DEASSERT_SET | STATUS_CLEAR) /* 0: dsp0 */
> -					0xa40 8 0xa40 8 0x840 8 (ASSERT_CLEAR | DEASSERT_SET | STATUS_CLEAR) /* 1: dsp1 */
> -					0xa44 8 0xa44 8 0x844 8 (ASSERT_CLEAR | DEASSERT_SET | STATUS_CLEAR) /* 2: dsp2 */
> -					0xa48 8 0xa48 8 0x848 8 (ASSERT_CLEAR | DEASSERT_SET | STATUS_CLEAR) /* 3: dsp3 */
> -					0xa4c 8 0xa4c 8 0x84c 8 (ASSERT_CLEAR | DEASSERT_SET | STATUS_CLEAR) /* 4: dsp4 */
> -					0xa50 8 0xa50 8 0x850 8 (ASSERT_CLEAR | DEASSERT_SET | STATUS_CLEAR) /* 5: dsp5 */
> -					0xa54 8 0xa54 8 0x854 8 (ASSERT_CLEAR | DEASSERT_SET | STATUS_CLEAR) /* 6: dsp6 */
> -					0xa58 8 0xa58 8 0x858 8 (ASSERT_CLEAR | DEASSERT_SET | STATUS_CLEAR) /* 7: dsp7 */
> -				>;
> -			};
> +			ti,reset-bits = <
> +				0xa3c 8 0xa3c 8 0x83c 8 (ASSERT_CLEAR | DEASSERT_SET | STATUS_CLEAR) /* 0: dsp0 */
> +				0xa40 8 0xa40 8 0x840 8 (ASSERT_CLEAR | DEASSERT_SET | STATUS_CLEAR) /* 1: dsp1 */
> +				0xa44 8 0xa44 8 0x844 8 (ASSERT_CLEAR | DEASSERT_SET | STATUS_CLEAR) /* 2: dsp2 */
> +				0xa48 8 0xa48 8 0x848 8 (ASSERT_CLEAR | DEASSERT_SET | STATUS_CLEAR) /* 3: dsp3 */
> +				0xa4c 8 0xa4c 8 0x84c 8 (ASSERT_CLEAR | DEASSERT_SET | STATUS_CLEAR) /* 4: dsp4 */
> +				0xa50 8 0xa50 8 0x850 8 (ASSERT_CLEAR | DEASSERT_SET | STATUS_CLEAR) /* 5: dsp5 */
> +				0xa54 8 0xa54 8 0x854 8 (ASSERT_CLEAR | DEASSERT_SET | STATUS_CLEAR) /* 6: dsp6 */
> +				0xa58 8 0xa58 8 0x858 8 (ASSERT_CLEAR | DEASSERT_SET | STATUS_CLEAR) /* 7: dsp7 */
> +			>;
>  		};
> +	};
>  
> -		devctrl: device-state-control@2620000 {
> -			dspgpio0: keystone_dsp_gpio@240 {
> -				compatible = "ti,keystone-dsp-gpio";
> -				reg = <0x240 0x4>;
> -				gpio-controller;
> -				#gpio-cells = <2>;
> -				gpio,syscon-dev = <&devctrl 0x240>;
> -			};
> -
> -			dspgpio1: keystone_dsp_gpio@244 {
> -				compatible = "ti,keystone-dsp-gpio";
> -				reg = <0x244 0x4>;
> -				gpio-controller;
> -				#gpio-cells = <2>;
> -				gpio,syscon-dev = <&devctrl 0x244>;
> -			};
> -
> -			dspgpio2: keystone_dsp_gpio@248 {
> -				compatible = "ti,keystone-dsp-gpio";
> -				reg = <0x248 0x4>;
> -				gpio-controller;
> -				#gpio-cells = <2>;
> -				gpio,syscon-dev = <&devctrl 0x248>;
> -			};
> -
> -			dspgpio3: keystone_dsp_gpio@24c {
> -				compatible = "ti,keystone-dsp-gpio";
> -				reg = <0x24c 0x4>;
> -				gpio-controller;
> -				#gpio-cells = <2>;
> -				gpio,syscon-dev = <&devctrl 0x24c>;
> -			};
> -
> -			dspgpio4: keystone_dsp_gpio@250 {
> -				compatible = "ti,keystone-dsp-gpio";
> -				reg = <0x250 0x4>;
> -				gpio-controller;
> -				#gpio-cells = <2>;
> -				gpio,syscon-dev = <&devctrl 0x250>;
> -			};
> -
> -			dspgpio5: keystone_dsp_gpio@254 {
> -				compatible = "ti,keystone-dsp-gpio";
> -				reg = <0x254 0x4>;
> -				gpio-controller;
> -				#gpio-cells = <2>;
> -				gpio,syscon-dev = <&devctrl 0x254>;
> -			};
> -
> -			dspgpio6: keystone_dsp_gpio@258 {
> -				compatible = "ti,keystone-dsp-gpio";
> -				reg = <0x258 0x4>;
> -				gpio-controller;
> -				#gpio-cells = <2>;
> -				gpio,syscon-dev = <&devctrl 0x258>;
> -			};
> -
> -			dspgpio7: keystone_dsp_gpio@25c {
> -				compatible = "ti,keystone-dsp-gpio";
> -				reg = <0x25c 0x4>;
> -				gpio-controller;
> -				#gpio-cells = <2>;
> -				gpio,syscon-dev = <&devctrl 0x25c>;
> -			};
> +	devctrl: device-state-control@2620000 {
> +		dspgpio0: keystone_dsp_gpio@240 {
> +			compatible = "ti,keystone-dsp-gpio";
> +			reg = <0x240 0x4>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			gpio,syscon-dev = <&devctrl 0x240>;
>  		};
>  
> -		dsp0: dsp@10800000 {
> -			compatible = "ti,k2hk-dsp";
> -			reg = <0x10800000 0x00100000>,
> -			      <0x10e00000 0x00008000>,
> -			      <0x10f00000 0x00008000>;
> -			reg-names = "l2sram", "l1pram", "l1dram";
> -			clocks = <&clkgem0>;
> -			ti,syscon-dev = <&devctrl 0x40>;
> -			resets = <&pscrst 0>;
> -			interrupt-parent = <&kirq0>;
> -			interrupts = <0 8>;
> -			interrupt-names = "vring", "exception";
> -			kick-gpios = <&dspgpio0 27 0>;
> -			status = "disabled";
> +		dspgpio1: keystone_dsp_gpio@244 {
> +			compatible = "ti,keystone-dsp-gpio";
> +			reg = <0x244 0x4>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			gpio,syscon-dev = <&devctrl 0x244>;
>  		};
>  
> -		dsp1: dsp@11800000 {
> -			compatible = "ti,k2hk-dsp";
> -			reg = <0x11800000 0x00100000>,
> -			      <0x11e00000 0x00008000>,
> -			      <0x11f00000 0x00008000>;
> -			reg-names = "l2sram", "l1pram", "l1dram";
> -			clocks = <&clkgem1>;
> -			ti,syscon-dev = <&devctrl 0x44>;
> -			resets = <&pscrst 1>;
> -			interrupt-parent = <&kirq0>;
> -			interrupts = <1 9>;
> -			interrupt-names = "vring", "exception";
> -			kick-gpios = <&dspgpio1 27 0>;
> -			status = "disabled";
> +		dspgpio2: keystone_dsp_gpio@248 {
> +			compatible = "ti,keystone-dsp-gpio";
> +			reg = <0x248 0x4>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			gpio,syscon-dev = <&devctrl 0x248>;
>  		};
>  
> -		dsp2: dsp@12800000 {
> -			compatible = "ti,k2hk-dsp";
> -			reg = <0x12800000 0x00100000>,
> -			      <0x12e00000 0x00008000>,
> -			      <0x12f00000 0x00008000>;
> -			reg-names = "l2sram", "l1pram", "l1dram";
> -			clocks = <&clkgem2>;
> -			ti,syscon-dev = <&devctrl 0x48>;
> -			resets = <&pscrst 2>;
> -			interrupt-parent = <&kirq0>;
> -			interrupts = <2 10>;
> -			interrupt-names = "vring", "exception";
> -			kick-gpios = <&dspgpio2 27 0>;
> -			status = "disabled";
> +		dspgpio3: keystone_dsp_gpio@24c {
> +			compatible = "ti,keystone-dsp-gpio";
> +			reg = <0x24c 0x4>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			gpio,syscon-dev = <&devctrl 0x24c>;
>  		};
>  
> -		dsp3: dsp@13800000 {
> -			compatible = "ti,k2hk-dsp";
> -			reg = <0x13800000 0x00100000>,
> -			      <0x13e00000 0x00008000>,
> -			      <0x13f00000 0x00008000>;
> -			reg-names = "l2sram", "l1pram", "l1dram";
> -			clocks = <&clkgem3>;
> -			ti,syscon-dev = <&devctrl 0x4c>;
> -			resets = <&pscrst 3>;
> -			interrupt-parent = <&kirq0>;
> -			interrupts = <3 11>;
> -			interrupt-names = "vring", "exception";
> -			kick-gpios = <&dspgpio3 27 0>;
> -			status = "disabled";
> +		dspgpio4: keystone_dsp_gpio@250 {
> +			compatible = "ti,keystone-dsp-gpio";
> +			reg = <0x250 0x4>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			gpio,syscon-dev = <&devctrl 0x250>;
>  		};
>  
> -		dsp4: dsp@14800000 {
> -			compatible = "ti,k2hk-dsp";
> -			reg = <0x14800000 0x00100000>,
> -			      <0x14e00000 0x00008000>,
> -			      <0x14f00000 0x00008000>;
> -			reg-names = "l2sram", "l1pram", "l1dram";
> -			clocks = <&clkgem4>;
> -			ti,syscon-dev = <&devctrl 0x50>;
> -			resets = <&pscrst 4>;
> -			interrupt-parent = <&kirq0>;
> -			interrupts = <4 12>;
> -			interrupt-names = "vring", "exception";
> -			kick-gpios = <&dspgpio4 27 0>;
> -			status = "disabled";
> +		dspgpio5: keystone_dsp_gpio@254 {
> +			compatible = "ti,keystone-dsp-gpio";
> +			reg = <0x254 0x4>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			gpio,syscon-dev = <&devctrl 0x254>;
>  		};
>  
> -		dsp5: dsp@15800000 {
> -			compatible = "ti,k2hk-dsp";
> -			reg = <0x15800000 0x00100000>,
> -			      <0x15e00000 0x00008000>,
> -			      <0x15f00000 0x00008000>;
> -			reg-names = "l2sram", "l1pram", "l1dram";
> -			clocks = <&clkgem5>;
> -			ti,syscon-dev = <&devctrl 0x54>;
> -			resets = <&pscrst 5>;
> -			interrupt-parent = <&kirq0>;
> -			interrupts = <5 13>;
> -			interrupt-names = "vring", "exception";
> -			kick-gpios = <&dspgpio5 27 0>;
> -			status = "disabled";
> +		dspgpio6: keystone_dsp_gpio@258 {
> +			compatible = "ti,keystone-dsp-gpio";
> +			reg = <0x258 0x4>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			gpio,syscon-dev = <&devctrl 0x258>;
>  		};
>  
> -		dsp6: dsp@16800000 {
> -			compatible = "ti,k2hk-dsp";
> -			reg = <0x16800000 0x00100000>,
> -			      <0x16e00000 0x00008000>,
> -			      <0x16f00000 0x00008000>;
> -			reg-names = "l2sram", "l1pram", "l1dram";
> -			clocks = <&clkgem6>;
> -			ti,syscon-dev = <&devctrl 0x58>;
> -			resets = <&pscrst 6>;
> -			interrupt-parent = <&kirq0>;
> -			interrupts = <6 14>;
> -			interrupt-names = "vring", "exception";
> -			kick-gpios = <&dspgpio6 27 0>;
> -			status = "disabled";
> +		dspgpio7: keystone_dsp_gpio@25c {
> +			compatible = "ti,keystone-dsp-gpio";
> +			reg = <0x25c 0x4>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			gpio,syscon-dev = <&devctrl 0x25c>;
>  		};
> +	};
>  
> -		dsp7: dsp@17800000 {
> -			compatible = "ti,k2hk-dsp";
> -			reg = <0x17800000 0x00100000>,
> -			      <0x17e00000 0x00008000>,
> -			      <0x17f00000 0x00008000>;
> -			reg-names = "l2sram", "l1pram", "l1dram";
> -			clocks = <&clkgem7>;
> -			ti,syscon-dev = <&devctrl 0x5c>;
> -			resets = <&pscrst 7>;
> -			interrupt-parent = <&kirq0>;
> -			interrupts = <7 15>;
> -			interrupt-names = "vring", "exception";
> -			kick-gpios = <&dspgpio7 27 0>;
> -			status = "disabled";
> -		};
> +	dsp0: dsp@10800000 {
> +		compatible = "ti,k2hk-dsp";
> +		reg = <0x10800000 0x00100000>,
> +		      <0x10e00000 0x00008000>,
> +		      <0x10f00000 0x00008000>;
> +		reg-names = "l2sram", "l1pram", "l1dram";
> +		clocks = <&clkgem0>;
> +		ti,syscon-dev = <&devctrl 0x40>;
> +		resets = <&pscrst 0>;
> +		interrupt-parent = <&kirq0>;
> +		interrupts = <0 8>;
> +		interrupt-names = "vring", "exception";
> +		kick-gpios = <&dspgpio0 27 0>;
> +		status = "disabled";
> +	};
>  
> -		mdio: mdio@2090300 {
> -			compatible = "ti,keystone_mdio", "ti,davinci_mdio";
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -			reg = <0x02090300 0x100>;
> -			status = "disabled";
> -			clocks = <&clkcpgmac>;
> -			clock-names = "fck";
> -			bus_freq = <2500000>;
> -		};
> -		/include/ "keystone-k2hk-netcp.dtsi"
> +	dsp1: dsp@11800000 {
> +		compatible = "ti,k2hk-dsp";
> +		reg = <0x11800000 0x00100000>,
> +		      <0x11e00000 0x00008000>,
> +		      <0x11f00000 0x00008000>;
> +		reg-names = "l2sram", "l1pram", "l1dram";
> +		clocks = <&clkgem1>;
> +		ti,syscon-dev = <&devctrl 0x44>;
> +		resets = <&pscrst 1>;
> +		interrupt-parent = <&kirq0>;
> +		interrupts = <1 9>;
> +		interrupt-names = "vring", "exception";
> +		kick-gpios = <&dspgpio1 27 0>;
> +		status = "disabled";
> +	};
> +
> +	dsp2: dsp@12800000 {
> +		compatible = "ti,k2hk-dsp";
> +		reg = <0x12800000 0x00100000>,
> +		      <0x12e00000 0x00008000>,
> +		      <0x12f00000 0x00008000>;
> +		reg-names = "l2sram", "l1pram", "l1dram";
> +		clocks = <&clkgem2>;
> +		ti,syscon-dev = <&devctrl 0x48>;
> +		resets = <&pscrst 2>;
> +		interrupt-parent = <&kirq0>;
> +		interrupts = <2 10>;
> +		interrupt-names = "vring", "exception";
> +		kick-gpios = <&dspgpio2 27 0>;
> +		status = "disabled";
> +	};
> +
> +	dsp3: dsp@13800000 {
> +		compatible = "ti,k2hk-dsp";
> +		reg = <0x13800000 0x00100000>,
> +		      <0x13e00000 0x00008000>,
> +		      <0x13f00000 0x00008000>;
> +		reg-names = "l2sram", "l1pram", "l1dram";
> +		clocks = <&clkgem3>;
> +		ti,syscon-dev = <&devctrl 0x4c>;
> +		resets = <&pscrst 3>;
> +		interrupt-parent = <&kirq0>;
> +		interrupts = <3 11>;
> +		interrupt-names = "vring", "exception";
> +		kick-gpios = <&dspgpio3 27 0>;
> +		status = "disabled";
> +	};
> +
> +	dsp4: dsp@14800000 {
> +		compatible = "ti,k2hk-dsp";
> +		reg = <0x14800000 0x00100000>,
> +		      <0x14e00000 0x00008000>,
> +		      <0x14f00000 0x00008000>;
> +		reg-names = "l2sram", "l1pram", "l1dram";
> +		clocks = <&clkgem4>;
> +		ti,syscon-dev = <&devctrl 0x50>;
> +		resets = <&pscrst 4>;
> +		interrupt-parent = <&kirq0>;
> +		interrupts = <4 12>;
> +		interrupt-names = "vring", "exception";
> +		kick-gpios = <&dspgpio4 27 0>;
> +		status = "disabled";
> +	};
> +
> +	dsp5: dsp@15800000 {
> +		compatible = "ti,k2hk-dsp";
> +		reg = <0x15800000 0x00100000>,
> +		      <0x15e00000 0x00008000>,
> +		      <0x15f00000 0x00008000>;
> +		reg-names = "l2sram", "l1pram", "l1dram";
> +		clocks = <&clkgem5>;
> +		ti,syscon-dev = <&devctrl 0x54>;
> +		resets = <&pscrst 5>;
> +		interrupt-parent = <&kirq0>;
> +		interrupts = <5 13>;
> +		interrupt-names = "vring", "exception";
> +		kick-gpios = <&dspgpio5 27 0>;
> +		status = "disabled";
> +	};
> +
> +	dsp6: dsp@16800000 {
> +		compatible = "ti,k2hk-dsp";
> +		reg = <0x16800000 0x00100000>,
> +		      <0x16e00000 0x00008000>,
> +		      <0x16f00000 0x00008000>;
> +		reg-names = "l2sram", "l1pram", "l1dram";
> +		clocks = <&clkgem6>;
> +		ti,syscon-dev = <&devctrl 0x58>;
> +		resets = <&pscrst 6>;
> +		interrupt-parent = <&kirq0>;
> +		interrupts = <6 14>;
> +		interrupt-names = "vring", "exception";
> +		kick-gpios = <&dspgpio6 27 0>;
> +		status = "disabled";
> +	};
> +
> +	dsp7: dsp@17800000 {
> +		compatible = "ti,k2hk-dsp";
> +		reg = <0x17800000 0x00100000>,
> +		      <0x17e00000 0x00008000>,
> +		      <0x17f00000 0x00008000>;
> +		reg-names = "l2sram", "l1pram", "l1dram";
> +		clocks = <&clkgem7>;
> +		ti,syscon-dev = <&devctrl 0x5c>;
> +		resets = <&pscrst 7>;
> +		interrupt-parent = <&kirq0>;
> +		interrupts = <7 15>;
> +		interrupt-names = "vring", "exception";
> +		kick-gpios = <&dspgpio7 27 0>;
> +		status = "disabled";
> +	};
> +
> +	mdio: mdio@2090300 {
> +		compatible = "ti,keystone_mdio", "ti,davinci_mdio";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		reg = <0x02090300 0x100>;
> +		status = "disabled";
> +		clocks = <&clkcpgmac>;
> +		clock-names = "fck";
> +		bus_freq = <2500000>;
> +	};
> +	/include/ "keystone-k2hk-netcp.dtsi"
>  };
> diff --git a/arch/arm/boot/dts/ti/keystone/keystone-k2l-evm.dts b/arch/arm/boot/dts/ti/keystone/keystone-k2l-evm.dts
> index be619e39a16f3..7835b3c0e6bff 100644
> --- a/arch/arm/boot/dts/ti/keystone/keystone-k2l-evm.dts
> +++ b/arch/arm/boot/dts/ti/keystone/keystone-k2l-evm.dts
> @@ -28,14 +28,14 @@ dsp_common_memory: dsp-common-memory@81f800000 {
>  };
>  
>  &soc0 {
> -		clocks {
> -			refclksys: refclksys {
> -				#clock-cells = <0>;
> -				compatible = "fixed-clock";
> -				clock-frequency = <122880000>;
> -				clock-output-names = "refclk-sys";
> -			};
> +	clocks {
> +		refclksys: refclksys {
> +			#clock-cells = <0>;
> +			compatible = "fixed-clock";
> +			clock-frequency = <122880000>;
> +			clock-output-names = "refclk-sys";
>  		};
> +	};
>  };
>  
>  &usb_phy {
> diff --git a/arch/arm/boot/dts/ti/keystone/keystone-k2l.dtsi b/arch/arm/boot/dts/ti/keystone/keystone-k2l.dtsi
> index 2062fe561642f..f67d949b872f6 100644
> --- a/arch/arm/boot/dts/ti/keystone/keystone-k2l.dtsi
> +++ b/arch/arm/boot/dts/ti/keystone/keystone-k2l.dtsi
> @@ -39,365 +39,365 @@ aliases {
>  };
>  
>  &soc0 {
> -		/include/ "keystone-k2l-clocks.dtsi"
> -
> -		uart2: serial@2348400 {
> -			compatible = "ti,da830-uart", "ns16550a";
> -			current-speed = <115200>;
> -			reg-shift = <2>;
> -			reg-io-width = <4>;
> -			reg = <0x02348400 0x100>;
> -			clocks = <&clkuart2>;
> -			interrupts = <GIC_SPI 432 IRQ_TYPE_EDGE_RISING>;
> +	/include/ "keystone-k2l-clocks.dtsi"
> +
> +	uart2: serial@2348400 {
> +		compatible = "ti,da830-uart", "ns16550a";
> +		current-speed = <115200>;
> +		reg-shift = <2>;
> +		reg-io-width = <4>;
> +		reg = <0x02348400 0x100>;
> +		clocks = <&clkuart2>;
> +		interrupts = <GIC_SPI 432 IRQ_TYPE_EDGE_RISING>;
> +	};
> +
> +	uart3:	serial@2348800 {
> +		compatible = "ti,da830-uart", "ns16550a";
> +		current-speed = <115200>;
> +		reg-shift = <2>;
> +		reg-io-width = <4>;
> +		reg = <0x02348800 0x100>;
> +		clocks = <&clkuart3>;
> +		interrupts = <GIC_SPI 435 IRQ_TYPE_EDGE_RISING>;
> +	};
> +
> +	gpio1: gpio@2348000 {
> +		compatible = "ti,keystone-gpio";
> +		reg = <0x02348000 0x100>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +		/* HW Interrupts mapped to GPIO pins */
> +		interrupts = <GIC_SPI 152 IRQ_TYPE_EDGE_RISING>,
> +				<GIC_SPI 153 IRQ_TYPE_EDGE_RISING>,
> +				<GIC_SPI 154 IRQ_TYPE_EDGE_RISING>,
> +				<GIC_SPI 155 IRQ_TYPE_EDGE_RISING>,
> +				<GIC_SPI 156 IRQ_TYPE_EDGE_RISING>,
> +				<GIC_SPI 157 IRQ_TYPE_EDGE_RISING>,
> +				<GIC_SPI 158 IRQ_TYPE_EDGE_RISING>,
> +				<GIC_SPI 159 IRQ_TYPE_EDGE_RISING>,
> +				<GIC_SPI 160 IRQ_TYPE_EDGE_RISING>,
> +				<GIC_SPI 161 IRQ_TYPE_EDGE_RISING>,
> +				<GIC_SPI 162 IRQ_TYPE_EDGE_RISING>,
> +				<GIC_SPI 163 IRQ_TYPE_EDGE_RISING>,
> +				<GIC_SPI 164 IRQ_TYPE_EDGE_RISING>,
> +				<GIC_SPI 165 IRQ_TYPE_EDGE_RISING>,
> +				<GIC_SPI 166 IRQ_TYPE_EDGE_RISING>,
> +				<GIC_SPI 167 IRQ_TYPE_EDGE_RISING>,
> +				<GIC_SPI 168 IRQ_TYPE_EDGE_RISING>,
> +				<GIC_SPI 169 IRQ_TYPE_EDGE_RISING>,
> +				<GIC_SPI 170 IRQ_TYPE_EDGE_RISING>,
> +				<GIC_SPI 171 IRQ_TYPE_EDGE_RISING>,
> +				<GIC_SPI 172 IRQ_TYPE_EDGE_RISING>,
> +				<GIC_SPI 173 IRQ_TYPE_EDGE_RISING>,
> +				<GIC_SPI 174 IRQ_TYPE_EDGE_RISING>,
> +				<GIC_SPI 175 IRQ_TYPE_EDGE_RISING>,
> +				<GIC_SPI 176 IRQ_TYPE_EDGE_RISING>,
> +				<GIC_SPI 401 IRQ_TYPE_EDGE_RISING>,
> +				<GIC_SPI 402 IRQ_TYPE_EDGE_RISING>,
> +				<GIC_SPI 403 IRQ_TYPE_EDGE_RISING>,
> +				<GIC_SPI 404 IRQ_TYPE_EDGE_RISING>,
> +				<GIC_SPI 405 IRQ_TYPE_EDGE_RISING>,
> +				<GIC_SPI 406 IRQ_TYPE_EDGE_RISING>,
> +				<GIC_SPI 407 IRQ_TYPE_EDGE_RISING>;
> +		clocks = <&clkgpio>;
> +		clock-names = "gpio";
> +		ti,ngpio = <32>;
> +		ti,davinci-gpio-unbanked = <32>;
> +	};
> +
> +	k2l_pmx: pinmux@2620690 {
> +		compatible = "pinctrl-single";
> +		reg = <0x02620690 0xc>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		#pinctrl-cells = <2>;
> +		pinctrl-single,bit-per-mux;
> +		pinctrl-single,register-width = <32>;
> +		pinctrl-single,function-mask = <0x1>;
> +		status = "disabled";
> +
> +		uart3_emifa_pins: uart3-emifa-pins {
> +			pinctrl-single,bits = <
> +				/* UART3_EMIFA_SEL */
> +				0x0 0x0  0xc0
> +			>;
>  		};
>  
> -		uart3:	serial@2348800 {
> -			compatible = "ti,da830-uart", "ns16550a";
> -			current-speed = <115200>;
> -			reg-shift = <2>;
> -			reg-io-width = <4>;
> -			reg = <0x02348800 0x100>;
> -			clocks = <&clkuart3>;
> -			interrupts = <GIC_SPI 435 IRQ_TYPE_EDGE_RISING>;
> +		uart2_emifa_pins: uart2-emifa-pins {
> +		pinctrl-single,bits = <
> +				/* UART2_EMIFA_SEL */
> +				0x0 0x0  0x30
> +			>;
>  		};
>  
> -		gpio1: gpio@2348000 {
> -			compatible = "ti,keystone-gpio";
> -			reg = <0x02348000 0x100>;
> -			gpio-controller;
> -			#gpio-cells = <2>;
> -			/* HW Interrupts mapped to GPIO pins */
> -			interrupts = <GIC_SPI 152 IRQ_TYPE_EDGE_RISING>,
> -					<GIC_SPI 153 IRQ_TYPE_EDGE_RISING>,
> -					<GIC_SPI 154 IRQ_TYPE_EDGE_RISING>,
> -					<GIC_SPI 155 IRQ_TYPE_EDGE_RISING>,
> -					<GIC_SPI 156 IRQ_TYPE_EDGE_RISING>,
> -					<GIC_SPI 157 IRQ_TYPE_EDGE_RISING>,
> -					<GIC_SPI 158 IRQ_TYPE_EDGE_RISING>,
> -					<GIC_SPI 159 IRQ_TYPE_EDGE_RISING>,
> -					<GIC_SPI 160 IRQ_TYPE_EDGE_RISING>,
> -					<GIC_SPI 161 IRQ_TYPE_EDGE_RISING>,
> -					<GIC_SPI 162 IRQ_TYPE_EDGE_RISING>,
> -					<GIC_SPI 163 IRQ_TYPE_EDGE_RISING>,
> -					<GIC_SPI 164 IRQ_TYPE_EDGE_RISING>,
> -					<GIC_SPI 165 IRQ_TYPE_EDGE_RISING>,
> -					<GIC_SPI 166 IRQ_TYPE_EDGE_RISING>,
> -					<GIC_SPI 167 IRQ_TYPE_EDGE_RISING>,
> -					<GIC_SPI 168 IRQ_TYPE_EDGE_RISING>,
> -					<GIC_SPI 169 IRQ_TYPE_EDGE_RISING>,
> -					<GIC_SPI 170 IRQ_TYPE_EDGE_RISING>,
> -					<GIC_SPI 171 IRQ_TYPE_EDGE_RISING>,
> -					<GIC_SPI 172 IRQ_TYPE_EDGE_RISING>,
> -					<GIC_SPI 173 IRQ_TYPE_EDGE_RISING>,
> -					<GIC_SPI 174 IRQ_TYPE_EDGE_RISING>,
> -					<GIC_SPI 175 IRQ_TYPE_EDGE_RISING>,
> -					<GIC_SPI 176 IRQ_TYPE_EDGE_RISING>,
> -					<GIC_SPI 401 IRQ_TYPE_EDGE_RISING>,
> -					<GIC_SPI 402 IRQ_TYPE_EDGE_RISING>,
> -					<GIC_SPI 403 IRQ_TYPE_EDGE_RISING>,
> -					<GIC_SPI 404 IRQ_TYPE_EDGE_RISING>,
> -					<GIC_SPI 405 IRQ_TYPE_EDGE_RISING>,
> -					<GIC_SPI 406 IRQ_TYPE_EDGE_RISING>,
> -					<GIC_SPI 407 IRQ_TYPE_EDGE_RISING>;
> -			clocks = <&clkgpio>;
> -			clock-names = "gpio";
> -			ti,ngpio = <32>;
> -			ti,davinci-gpio-unbanked = <32>;
> +		uart01_spi2_pins: uart01-spi2-pins {
> +			pinctrl-single,bits = <
> +				/* UART01_SPI2_SEL */
> +				0x0 0x0 0x4
> +			>;
>  		};
>  
> -		k2l_pmx: pinmux@2620690 {
> -			compatible = "pinctrl-single";
> -			reg = <0x02620690 0xc>;
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -			#pinctrl-cells = <2>;
> -			pinctrl-single,bit-per-mux;
> -			pinctrl-single,register-width = <32>;
> -			pinctrl-single,function-mask = <0x1>;
> -			status = "disabled";
> -
> -			uart3_emifa_pins: uart3-emifa-pins {
> -				pinctrl-single,bits = <
> -					/* UART3_EMIFA_SEL */
> -					0x0 0x0  0xc0
> -				>;
> -			};
> -
> -			uart2_emifa_pins: uart2-emifa-pins {
> +		dfesync_rp1_pins: dfesync-rp1-pins {
>  			pinctrl-single,bits = <
> -					/* UART2_EMIFA_SEL */
> -					0x0 0x0  0x30
> -				>;
> -			};
> -
> -			uart01_spi2_pins: uart01-spi2-pins {
> -				pinctrl-single,bits = <
> -					/* UART01_SPI2_SEL */
> -					0x0 0x0 0x4
> -				>;
> -			};
> -
> -			dfesync_rp1_pins: dfesync-rp1-pins {
> -				pinctrl-single,bits = <
> -					/* DFESYNC_RP1_SEL */
> -					0x0 0x0 0x2
> -				>;
> -			};
> -
> -			avsif_pins: avsif-pins {
> -				pinctrl-single,bits = <
> -					/* AVSIF_SEL */
> -					0x0 0x0 0x1
> -				>;
> -			};
> -
> -			gpio_emu_pins: gpio-emu-pins {
> -				pinctrl-single,bits = <
> -				/*
> -				 * GPIO_EMU_SEL[31]: 0-GPIO31, 1-EMU33
> -				 * GPIO_EMU_SEL[30]: 0-GPIO30, 1-EMU32
> -				 * GPIO_EMU_SEL[29]: 0-GPIO29, 1-EMU31
> -				 * GPIO_EMU_SEL[28]: 0-GPIO28, 1-EMU30
> -				 * GPIO_EMU_SEL[27]: 0-GPIO27, 1-EMU29
> -				 * GPIO_EMU_SEL[26]: 0-GPIO26, 1-EMU28
> -				 * GPIO_EMU_SEL[25]: 0-GPIO25, 1-EMU27
> -				 * GPIO_EMU_SEL[24]: 0-GPIO24, 1-EMU26
> -				 * GPIO_EMU_SEL[23]: 0-GPIO23, 1-EMU25
> -				 * GPIO_EMU_SEL[22]: 0-GPIO22, 1-EMU24
> -				 * GPIO_EMU_SEL[21]: 0-GPIO21, 1-EMU23
> -				 * GPIO_EMU_SEL[20]: 0-GPIO20, 1-EMU22
> -				 * GPIO_EMU_SEL[19]: 0-GPIO19, 1-EMU21
> -				 * GPIO_EMU_SEL[18]: 0-GPIO18, 1-EMU20
> -				 * GPIO_EMU_SEL[17]: 0-GPIO17, 1-EMU19
> -				 */
> -					0x4 0x0000 0xfffe0000
> -				>;
> -			};
> -
> -			gpio_timio_pins: gpio-timio-pins {
> -				pinctrl-single,bits = <
> -				/*
> -				 * GPIO_TIMIO_SEL[15]: 0-GPIO15, 1-TIMO7
> -				 * GPIO_TIMIO_SEL[14]: 0-GPIO14, 1-TIMO6
> -				 * GPIO_TIMIO_SEL[13]: 0-GPIO13, 1-TIMO5
> -				 * GPIO_TIMIO_SEL[12]: 0-GPIO12, 1-TIMO4
> -				 * GPIO_TIMIO_SEL[11]: 0-GPIO11, 1-TIMO3
> -				 * GPIO_TIMIO_SEL[10]: 0-GPIO10, 1-TIMO2
> -				 * GPIO_TIMIO_SEL[9]: 0-GPIO9, 1-TIMI7
> -				 * GPIO_TIMIO_SEL[8]: 0-GPIO8, 1-TIMI6
> -				 * GPIO_TIMIO_SEL[7]: 0-GPIO7, 1-TIMI5
> -				 * GPIO_TIMIO_SEL[6]: 0-GPIO6, 1-TIMI4
> -				 * GPIO_TIMIO_SEL[5]: 0-GPIO5, 1-TIMI3
> -				 * GPIO_TIMIO_SEL[4]: 0-GPIO4, 1-TIMI2
> -				 */
> -					0x4 0x0 0xfff0
> -				>;
> -			};
> -
> -			gpio_spi2cs_pins: gpio-spi2cs-pins {
> -				pinctrl-single,bits = <
> -				/*
> -				 * GPIO_SPI2CS_SEL[3]: 0-GPIO3, 1-SPI2CS4
> -				 * GPIO_SPI2CS_SEL[2]: 0-GPIO2, 1-SPI2CS3
> -				 * GPIO_SPI2CS_SEL[1]: 0-GPIO1, 1-SPI2CS2
> -				 * GPIO_SPI2CS_SEL[0]: 0-GPIO0, 1-SPI2CS1
> -				 */
> -					0x4 0x0 0xf
> -				>;
> -			};
> -
> -			gpio_dfeio_pins: gpio-dfeio-pins {
> -				pinctrl-single,bits = <
> -				/*
> -				 * GPIO_DFEIO_SEL[31]: 0-DFEIO17, 1-GPIO63
> -				 * GPIO_DFEIO_SEL[30]: 0-DFEIO16, 1-GPIO62
> -				 * GPIO_DFEIO_SEL[29]: 0-DFEIO15, 1-GPIO61
> -				 * GPIO_DFEIO_SEL[28]: 0-DFEIO14, 1-GPIO60
> -				 * GPIO_DFEIO_SEL[27]: 0-DFEIO13, 1-GPIO59
> -				 * GPIO_DFEIO_SEL[26]: 0-DFEIO12, 1-GPIO58
> -				 * GPIO_DFEIO_SEL[25]: 0-DFEIO11, 1-GPIO57
> -				 * GPIO_DFEIO_SEL[24]: 0-DFEIO10, 1-GPIO56
> -				 * GPIO_DFEIO_SEL[23]: 0-DFEIO9, 1-GPIO55
> -				 * GPIO_DFEIO_SEL[22]: 0-DFEIO8, 1-GPIO54
> -				 * GPIO_DFEIO_SEL[21]: 0-DFEIO7, 1-GPIO53
> -				 * GPIO_DFEIO_SEL[20]: 0-DFEIO6, 1-GPIO52
> -				 * GPIO_DFEIO_SEL[19]: 0-DFEIO5, 1-GPIO51
> -				 * GPIO_DFEIO_SEL[18]: 0-DFEIO4, 1-GPIO50
> -				 * GPIO_DFEIO_SEL[17]: 0-DFEIO3, 1-GPIO49
> -				 * GPIO_DFEIO_SEL[16]: 0-DFEIO2, 1-GPIO48
> -				 */
> -					0x8 0x0 0xffff0000
> -				>;
> -			};
> -
> -			gpio_emifa_pins: gpio-emifa-pins {
> -				pinctrl-single,bits = <
> -				/*
> -				 * GPIO_EMIFA_SEL[15]: 0-EMIFA17, 1-GPIO47
> -				 * GPIO_EMIFA_SEL[14]: 0-EMIFA16, 1-GPIO46
> -				 * GPIO_EMIFA_SEL[13]: 0-EMIFA15, 1-GPIO45
> -				 * GPIO_EMIFA_SEL[12]: 0-EMIFA14, 1-GPIO44
> -				 * GPIO_EMIFA_SEL[11]: 0-EMIFA13, 1-GPIO43
> -				 * GPIO_EMIFA_SEL[10]: 0-EMIFA10, 1-GPIO42
> -				 * GPIO_EMIFA_SEL[9]: 0-EMIFA9, 1-GPIO41
> -				 * GPIO_EMIFA_SEL[8]: 0-EMIFA8, 1-GPIO40
> -				 * GPIO_EMIFA_SEL[7]: 0-EMIFA7, 1-GPIO39
> -				 * GPIO_EMIFA_SEL[6]: 0-EMIFA6, 1-GPIO38
> -				 * GPIO_EMIFA_SEL[5]: 0-EMIFA5, 1-GPIO37
> -				 * GPIO_EMIFA_SEL[4]: 0-EMIFA4, 1-GPIO36
> -				 * GPIO_EMIFA_SEL[3]: 0-EMIFA3, 1-GPIO35
> -				 * GPIO_EMIFA_SEL[2]: 0-EMIFA2, 1-GPIO34
> -				 * GPIO_EMIFA_SEL[1]: 0-EMIFA1, 1-GPIO33
> -				 * GPIO_EMIFA_SEL[0]: 0-EMIFA0, 1-GPIO32
> -				 */
> -					0x8 0x0 0xffff
> -				>;
> -			};
> +				/* DFESYNC_RP1_SEL */
> +				0x0 0x0 0x2
> +			>;
>  		};
>  
> -		msm_ram: sram@c000000 {
> -			compatible = "mmio-sram";
> -			reg = <0x0c000000 0x200000>;
> -			ranges = <0x0 0x0c000000 0x200000>;
> -			#address-cells = <1>;
> -			#size-cells = <1>;
> +		avsif_pins: avsif-pins {
> +			pinctrl-single,bits = <
> +				/* AVSIF_SEL */
> +				0x0 0x0 0x1
> +			>;
> +		};
>  
> -			bm-sram@1f8000 {
> -				reg = <0x001f8000 0x8000>;
> -			};
> +		gpio_emu_pins: gpio-emu-pins {
> +			pinctrl-single,bits = <
> +			/*
> +			 * GPIO_EMU_SEL[31]: 0-GPIO31, 1-EMU33
> +			 * GPIO_EMU_SEL[30]: 0-GPIO30, 1-EMU32
> +			 * GPIO_EMU_SEL[29]: 0-GPIO29, 1-EMU31
> +			 * GPIO_EMU_SEL[28]: 0-GPIO28, 1-EMU30
> +			 * GPIO_EMU_SEL[27]: 0-GPIO27, 1-EMU29
> +			 * GPIO_EMU_SEL[26]: 0-GPIO26, 1-EMU28
> +			 * GPIO_EMU_SEL[25]: 0-GPIO25, 1-EMU27
> +			 * GPIO_EMU_SEL[24]: 0-GPIO24, 1-EMU26
> +			 * GPIO_EMU_SEL[23]: 0-GPIO23, 1-EMU25
> +			 * GPIO_EMU_SEL[22]: 0-GPIO22, 1-EMU24
> +			 * GPIO_EMU_SEL[21]: 0-GPIO21, 1-EMU23
> +			 * GPIO_EMU_SEL[20]: 0-GPIO20, 1-EMU22
> +			 * GPIO_EMU_SEL[19]: 0-GPIO19, 1-EMU21
> +			 * GPIO_EMU_SEL[18]: 0-GPIO18, 1-EMU20
> +			 * GPIO_EMU_SEL[17]: 0-GPIO17, 1-EMU19
> +			 */
> +				0x4 0x0000 0xfffe0000
> +			>;
>  		};
>  
> -		psc: power-sleep-controller@2350000 {
> -			pscrst: reset-controller {
> -				compatible = "ti,k2l-pscrst", "ti,syscon-reset";
> -				#reset-cells = <1>;
> -
> -				ti,reset-bits = <
> -					0xa3c 8 0xa3c 8 0x83c 8 (ASSERT_CLEAR | DEASSERT_SET | STATUS_CLEAR) /* 0: dsp0 */
> -					0xa40 8 0xa40 8 0x840 8 (ASSERT_CLEAR | DEASSERT_SET | STATUS_CLEAR) /* 1: dsp1 */
> -					0xa44 8 0xa44 8 0x844 8 (ASSERT_CLEAR | DEASSERT_SET | STATUS_CLEAR) /* 2: dsp2 */
> -					0xa48 8 0xa48 8 0x848 8 (ASSERT_CLEAR | DEASSERT_SET | STATUS_CLEAR) /* 3: dsp3 */
> -				>;
> -			};
> +		gpio_timio_pins: gpio-timio-pins {
> +			pinctrl-single,bits = <
> +			/*
> +			 * GPIO_TIMIO_SEL[15]: 0-GPIO15, 1-TIMO7
> +			 * GPIO_TIMIO_SEL[14]: 0-GPIO14, 1-TIMO6
> +			 * GPIO_TIMIO_SEL[13]: 0-GPIO13, 1-TIMO5
> +			 * GPIO_TIMIO_SEL[12]: 0-GPIO12, 1-TIMO4
> +			 * GPIO_TIMIO_SEL[11]: 0-GPIO11, 1-TIMO3
> +			 * GPIO_TIMIO_SEL[10]: 0-GPIO10, 1-TIMO2
> +			 * GPIO_TIMIO_SEL[9]: 0-GPIO9, 1-TIMI7
> +			 * GPIO_TIMIO_SEL[8]: 0-GPIO8, 1-TIMI6
> +			 * GPIO_TIMIO_SEL[7]: 0-GPIO7, 1-TIMI5
> +			 * GPIO_TIMIO_SEL[6]: 0-GPIO6, 1-TIMI4
> +			 * GPIO_TIMIO_SEL[5]: 0-GPIO5, 1-TIMI3
> +			 * GPIO_TIMIO_SEL[4]: 0-GPIO4, 1-TIMI2
> +			 */
> +				0x4 0x0 0xfff0
> +			>;
>  		};
>  
> -		osr: sram@70000000 {
> -			compatible = "mmio-sram";
> -			reg = <0x70000000 0x10000>;
> -			#address-cells = <1>;
> -			#size-cells = <1>;
> -			clocks = <&clkosr>;
> +		gpio_spi2cs_pins: gpio-spi2cs-pins {
> +			pinctrl-single,bits = <
> +			/*
> +			 * GPIO_SPI2CS_SEL[3]: 0-GPIO3, 1-SPI2CS4
> +			 * GPIO_SPI2CS_SEL[2]: 0-GPIO2, 1-SPI2CS3
> +			 * GPIO_SPI2CS_SEL[1]: 0-GPIO1, 1-SPI2CS2
> +			 * GPIO_SPI2CS_SEL[0]: 0-GPIO0, 1-SPI2CS1
> +			 */
> +				0x4 0x0 0xf
> +			>;
>  		};
>  
> -		devctrl: device-state-control@2620000 {
> -			dspgpio0: keystone_dsp_gpio@240 {
> -				compatible = "ti,keystone-dsp-gpio";
> -				reg = <0x240 0x4>;
> -				gpio-controller;
> -				#gpio-cells = <2>;
> -				gpio,syscon-dev = <&devctrl 0x240>;
> -			};
> -
> -			dspgpio1: keystone_dsp_gpio@244 {
> -				compatible = "ti,keystone-dsp-gpio";
> -				reg = <0x244 0x4>;
> -				gpio-controller;
> -				#gpio-cells = <2>;
> -				gpio,syscon-dev = <&devctrl 0x244>;
> -			};
> -
> -			dspgpio2: keystone_dsp_gpio@248 {
> -				compatible = "ti,keystone-dsp-gpio";
> -				reg = <0x248 0x4>;
> -				gpio-controller;
> -				#gpio-cells = <2>;
> -				gpio,syscon-dev = <&devctrl 0x248>;
> -			};
> -
> -			dspgpio3: keystone_dsp_gpio@24c {
> -				compatible = "ti,keystone-dsp-gpio";
> -				reg = <0x24c 0x4>;
> -				gpio-controller;
> -				#gpio-cells = <2>;
> -				gpio,syscon-dev = <&devctrl 0x24c>;
> -			};
> +		gpio_dfeio_pins: gpio-dfeio-pins {
> +			pinctrl-single,bits = <
> +			/*
> +			 * GPIO_DFEIO_SEL[31]: 0-DFEIO17, 1-GPIO63
> +			 * GPIO_DFEIO_SEL[30]: 0-DFEIO16, 1-GPIO62
> +			 * GPIO_DFEIO_SEL[29]: 0-DFEIO15, 1-GPIO61
> +			 * GPIO_DFEIO_SEL[28]: 0-DFEIO14, 1-GPIO60
> +			 * GPIO_DFEIO_SEL[27]: 0-DFEIO13, 1-GPIO59
> +			 * GPIO_DFEIO_SEL[26]: 0-DFEIO12, 1-GPIO58
> +			 * GPIO_DFEIO_SEL[25]: 0-DFEIO11, 1-GPIO57
> +			 * GPIO_DFEIO_SEL[24]: 0-DFEIO10, 1-GPIO56
> +			 * GPIO_DFEIO_SEL[23]: 0-DFEIO9, 1-GPIO55
> +			 * GPIO_DFEIO_SEL[22]: 0-DFEIO8, 1-GPIO54
> +			 * GPIO_DFEIO_SEL[21]: 0-DFEIO7, 1-GPIO53
> +			 * GPIO_DFEIO_SEL[20]: 0-DFEIO6, 1-GPIO52
> +			 * GPIO_DFEIO_SEL[19]: 0-DFEIO5, 1-GPIO51
> +			 * GPIO_DFEIO_SEL[18]: 0-DFEIO4, 1-GPIO50
> +			 * GPIO_DFEIO_SEL[17]: 0-DFEIO3, 1-GPIO49
> +			 * GPIO_DFEIO_SEL[16]: 0-DFEIO2, 1-GPIO48
> +			 */
> +				0x8 0x0 0xffff0000
> +			>;
>  		};
>  
> -		dsp0: dsp@10800000 {
> -			compatible = "ti,k2l-dsp";
> -			reg = <0x10800000 0x00100000>,
> -			      <0x10e00000 0x00008000>,
> -			      <0x10f00000 0x00008000>;
> -			reg-names = "l2sram", "l1pram", "l1dram";
> -			clocks = <&clkgem0>;
> -			ti,syscon-dev = <&devctrl 0x844>;
> -			resets = <&pscrst 0>;
> -			interrupt-parent = <&kirq0>;
> -			interrupts = <0 8>;
> -			interrupt-names = "vring", "exception";
> -			kick-gpios = <&dspgpio0 27 0>;
> -			status = "disabled";
> +		gpio_emifa_pins: gpio-emifa-pins {
> +			pinctrl-single,bits = <
> +			/*
> +			 * GPIO_EMIFA_SEL[15]: 0-EMIFA17, 1-GPIO47
> +			 * GPIO_EMIFA_SEL[14]: 0-EMIFA16, 1-GPIO46
> +			 * GPIO_EMIFA_SEL[13]: 0-EMIFA15, 1-GPIO45
> +			 * GPIO_EMIFA_SEL[12]: 0-EMIFA14, 1-GPIO44
> +			 * GPIO_EMIFA_SEL[11]: 0-EMIFA13, 1-GPIO43
> +			 * GPIO_EMIFA_SEL[10]: 0-EMIFA10, 1-GPIO42
> +			 * GPIO_EMIFA_SEL[9]: 0-EMIFA9, 1-GPIO41
> +			 * GPIO_EMIFA_SEL[8]: 0-EMIFA8, 1-GPIO40
> +			 * GPIO_EMIFA_SEL[7]: 0-EMIFA7, 1-GPIO39
> +			 * GPIO_EMIFA_SEL[6]: 0-EMIFA6, 1-GPIO38
> +			 * GPIO_EMIFA_SEL[5]: 0-EMIFA5, 1-GPIO37
> +			 * GPIO_EMIFA_SEL[4]: 0-EMIFA4, 1-GPIO36
> +			 * GPIO_EMIFA_SEL[3]: 0-EMIFA3, 1-GPIO35
> +			 * GPIO_EMIFA_SEL[2]: 0-EMIFA2, 1-GPIO34
> +			 * GPIO_EMIFA_SEL[1]: 0-EMIFA1, 1-GPIO33
> +			 * GPIO_EMIFA_SEL[0]: 0-EMIFA0, 1-GPIO32
> +			 */
> +				0x8 0x0 0xffff
> +			>;
>  		};
> +	};
>  
> -		dsp1: dsp@11800000 {
> -			compatible = "ti,k2l-dsp";
> -			reg = <0x11800000 0x00100000>,
> -			      <0x11e00000 0x00008000>,
> -			      <0x11f00000 0x00008000>;
> -			reg-names = "l2sram", "l1pram", "l1dram";
> -			clocks = <&clkgem1>;
> -			ti,syscon-dev = <&devctrl 0x848>;
> -			resets = <&pscrst 1>;
> -			interrupt-parent = <&kirq0>;
> -			interrupts = <1 9>;
> -			interrupt-names = "vring", "exception";
> -			kick-gpios = <&dspgpio1 27 0>;
> -			status = "disabled";
> +	msm_ram: sram@c000000 {
> +		compatible = "mmio-sram";
> +		reg = <0x0c000000 0x200000>;
> +		ranges = <0x0 0x0c000000 0x200000>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +
> +		bm-sram@1f8000 {
> +			reg = <0x001f8000 0x8000>;
>  		};
> +	};
>  
> -		dsp2: dsp@12800000 {
> -			compatible = "ti,k2l-dsp";
> -			reg = <0x12800000 0x00100000>,
> -			      <0x12e00000 0x00008000>,
> -			      <0x12f00000 0x00008000>;
> -			reg-names = "l2sram", "l1pram", "l1dram";
> -			clocks = <&clkgem2>;
> -			ti,syscon-dev = <&devctrl 0x84c>;
> -			resets = <&pscrst 2>;
> -			interrupt-parent = <&kirq0>;
> -			interrupts = <2 10>;
> -			interrupt-names = "vring", "exception";
> -			kick-gpios = <&dspgpio2 27 0>;
> -			status = "disabled";
> +	psc: power-sleep-controller@2350000 {
> +		pscrst: reset-controller {
> +			compatible = "ti,k2l-pscrst", "ti,syscon-reset";
> +			#reset-cells = <1>;
> +
> +			ti,reset-bits = <
> +				0xa3c 8 0xa3c 8 0x83c 8 (ASSERT_CLEAR | DEASSERT_SET | STATUS_CLEAR) /* 0: dsp0 */
> +				0xa40 8 0xa40 8 0x840 8 (ASSERT_CLEAR | DEASSERT_SET | STATUS_CLEAR) /* 1: dsp1 */
> +				0xa44 8 0xa44 8 0x844 8 (ASSERT_CLEAR | DEASSERT_SET | STATUS_CLEAR) /* 2: dsp2 */
> +				0xa48 8 0xa48 8 0x848 8 (ASSERT_CLEAR | DEASSERT_SET | STATUS_CLEAR) /* 3: dsp3 */
> +			>;
>  		};
> +	};
>  
> -		dsp3: dsp@13800000 {
> -			compatible = "ti,k2l-dsp";
> -			reg = <0x13800000 0x00100000>,
> -			      <0x13e00000 0x00008000>,
> -			      <0x13f00000 0x00008000>;
> -			reg-names = "l2sram", "l1pram", "l1dram";
> -			clocks = <&clkgem3>;
> -			ti,syscon-dev = <&devctrl 0x850>;
> -			resets = <&pscrst 3>;
> -			interrupt-parent = <&kirq0>;
> -			interrupts = <3 11>;
> -			interrupt-names = "vring", "exception";
> -			kick-gpios = <&dspgpio3 27 0>;
> -			status = "disabled";
> +	osr: sram@70000000 {
> +		compatible = "mmio-sram";
> +		reg = <0x70000000 0x10000>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		clocks = <&clkosr>;
> +	};
> +
> +	devctrl: device-state-control@2620000 {
> +		dspgpio0: keystone_dsp_gpio@240 {
> +			compatible = "ti,keystone-dsp-gpio";
> +			reg = <0x240 0x4>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			gpio,syscon-dev = <&devctrl 0x240>;
> +		};
> +
> +		dspgpio1: keystone_dsp_gpio@244 {
> +			compatible = "ti,keystone-dsp-gpio";
> +			reg = <0x244 0x4>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			gpio,syscon-dev = <&devctrl 0x244>;
>  		};
>  
> -		mdio: mdio@26200f00 {
> -			compatible = "ti,keystone_mdio", "ti,davinci_mdio";
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -			reg = <0x26200f00 0x100>;
> -			status = "disabled";
> -			clocks = <&clkcpgmac>;
> -			clock-names = "fck";
> -			bus_freq = <2500000>;
> +		dspgpio2: keystone_dsp_gpio@248 {
> +			compatible = "ti,keystone-dsp-gpio";
> +			reg = <0x248 0x4>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			gpio,syscon-dev = <&devctrl 0x248>;
> +		};
> +
> +		dspgpio3: keystone_dsp_gpio@24c {
> +			compatible = "ti,keystone-dsp-gpio";
> +			reg = <0x24c 0x4>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			gpio,syscon-dev = <&devctrl 0x24c>;
>  		};
> -		/include/ "keystone-k2l-netcp.dtsi"
> +	};
> +
> +	dsp0: dsp@10800000 {
> +		compatible = "ti,k2l-dsp";
> +		reg = <0x10800000 0x00100000>,
> +		      <0x10e00000 0x00008000>,
> +		      <0x10f00000 0x00008000>;
> +		reg-names = "l2sram", "l1pram", "l1dram";
> +		clocks = <&clkgem0>;
> +		ti,syscon-dev = <&devctrl 0x844>;
> +		resets = <&pscrst 0>;
> +		interrupt-parent = <&kirq0>;
> +		interrupts = <0 8>;
> +		interrupt-names = "vring", "exception";
> +		kick-gpios = <&dspgpio0 27 0>;
> +		status = "disabled";
> +	};
> +
> +	dsp1: dsp@11800000 {
> +		compatible = "ti,k2l-dsp";
> +		reg = <0x11800000 0x00100000>,
> +		      <0x11e00000 0x00008000>,
> +		      <0x11f00000 0x00008000>;
> +		reg-names = "l2sram", "l1pram", "l1dram";
> +		clocks = <&clkgem1>;
> +		ti,syscon-dev = <&devctrl 0x848>;
> +		resets = <&pscrst 1>;
> +		interrupt-parent = <&kirq0>;
> +		interrupts = <1 9>;
> +		interrupt-names = "vring", "exception";
> +		kick-gpios = <&dspgpio1 27 0>;
> +		status = "disabled";
> +	};
> +
> +	dsp2: dsp@12800000 {
> +		compatible = "ti,k2l-dsp";
> +		reg = <0x12800000 0x00100000>,
> +		      <0x12e00000 0x00008000>,
> +		      <0x12f00000 0x00008000>;
> +		reg-names = "l2sram", "l1pram", "l1dram";
> +		clocks = <&clkgem2>;
> +		ti,syscon-dev = <&devctrl 0x84c>;
> +		resets = <&pscrst 2>;
> +		interrupt-parent = <&kirq0>;
> +		interrupts = <2 10>;
> +		interrupt-names = "vring", "exception";
> +		kick-gpios = <&dspgpio2 27 0>;
> +		status = "disabled";
> +	};
> +
> +	dsp3: dsp@13800000 {
> +		compatible = "ti,k2l-dsp";
> +		reg = <0x13800000 0x00100000>,
> +		      <0x13e00000 0x00008000>,
> +		      <0x13f00000 0x00008000>;
> +		reg-names = "l2sram", "l1pram", "l1dram";
> +		clocks = <&clkgem3>;
> +		ti,syscon-dev = <&devctrl 0x850>;
> +		resets = <&pscrst 3>;
> +		interrupt-parent = <&kirq0>;
> +		interrupts = <3 11>;
> +		interrupt-names = "vring", "exception";
> +		kick-gpios = <&dspgpio3 27 0>;
> +		status = "disabled";
> +	};
> +
> +	mdio: mdio@26200f00 {
> +		compatible = "ti,keystone_mdio", "ti,davinci_mdio";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		reg = <0x26200f00 0x100>;
> +		status = "disabled";
> +		clocks = <&clkcpgmac>;
> +		clock-names = "fck";
> +		bus_freq = <2500000>;
> +	};
> +	/include/ "keystone-k2l-netcp.dtsi"
>  };
>  
>  &spi0 {
> -- 
> 2.39.2
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
