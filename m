Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4337C8BBB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 18:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjJMQsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 12:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJMQsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 12:48:21 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BAAE95
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 09:48:19 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39DGlxiR080123;
        Fri, 13 Oct 2023 11:47:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1697215679;
        bh=mlNF1wQCjraZ1qdm9BsC9O7cX2OVWnskNBedZH7esJ0=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=raTC4BZbF/4RGaq4reWMpsuL+bf5HkZktLU4kyBSzX+XpZ8Siy3vC0xakOS0BAwtg
         Gx5CKqMBXLa8z7UhCu0mNur4rNGGIdmjXzCMxRpspPdBQfhzi1mSvtHDVuo8aURc1C
         eSS+G7ca4R1PC18GLICAxENDTIIBnAyz+WAA00UA=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39DGlxwP010647
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 13 Oct 2023 11:47:59 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 13
 Oct 2023 11:47:59 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 13 Oct 2023 11:47:58 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39DGlwfp019040;
        Fri, 13 Oct 2023 11:47:58 -0500
Date:   Fri, 13 Oct 2023 11:47:58 -0500
From:   Bryan Brattlof <bb@ti.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>
CC:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ARM Linux Mailing List <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/2] arm64: dts: ti: k3-am62p: Add nodes for more IPs
Message-ID: <20231013164758.aazyzkr62mgiuqiw@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20231010035903.520635-4-bb@ti.com>
 <20231010035903.520635-5-bb@ti.com>
 <79bc9fe7-0a35-4f07-b34e-367a4b1e1755@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <79bc9fe7-0a35-4f07-b34e-367a4b1e1755@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Vignesh!

On October 12, 2023 thus sayeth Vignesh Raghavendra:
> On 10/10/23 09:29, Bryan Brattlof wrote:
> > From: Vignesh Raghavendra <vigneshr@ti.com>
> > 
> > The am62px shares many of the same IP as the existing am62x family
> > of SoCs, Introduce more nodes for hardware available on the am62p5.
> > 
> > Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> > Signed-off-by: Bryan Brattlof <bb@ti.com>
> > ---
> >  arch/arm64/boot/dts/ti/k3-am62p-main.dtsi    | 835 ++++++++++++++++++-
> >  arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi     | 191 +++++
> >  arch/arm64/boot/dts/ti/k3-am62p-thermal.dtsi |  47 ++
> >  arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi  |  67 ++
> >  arch/arm64/boot/dts/ti/k3-am62p.dtsi         |   2 +
> >  5 files changed, 1141 insertions(+), 1 deletion(-)
> >  create mode 100644 arch/arm64/boot/dts/ti/k3-am62p-thermal.dtsi
> > 
> > diff --git a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
> > index c24ff905437ff..b754c18c3325b 100644
> > --- a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
> > +++ b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
> > @@ -40,9 +40,29 @@ gic_its: msi-controller@1820000 {
> >  		};
> >  	};
> >  
> > +	main_conf: syscon@100000 {
> > +		compatible = "ti,j721e-system-controller", "syscon", "simple-mfd";
> 
> simple-bus is sufficient
> 

Ah cool! I can fix that

> > +		reg = <0x00 0x00100000 0x00 0x20000>;
> > +		#address-cells = <1>;
> > +		#size-cells = <1>;
> > +		ranges = <0x0 0x00 0x00100000 0x20000>;
> > +
> > +		phy_gmii_sel: phy@4044 {
> > +			compatible = "ti,am654-phy-gmii-sel";
> > +			reg = <0x4044 0x8>;
> > +			#phy-cells = <1>;
> > +		};
> > +
> > +		epwm_tbclk: clock-controller@4130 {
> > +			compatible = "ti,am62-epwm-tbclk";
> > +			reg = <0x4130 0x4>;
> > +			#clock-cells = <1>;
> > +		};
> > +	};
> > +
> >  	dmss: bus@48000000 {
> >  		bootph-all;
> 
> Here and elsehwere, Lets keep this property at the last, prefer to have compatible,
>  reg, reg-names to be at the beginning
>

Sounds good :)

> > -		compatible = "simple-mfd";
> > +		compatible = "simple-bus";
> 
> This is already address by [0]
> 
> [0] https://lore.kernel.org/linux-arm-kernel/20231005151302.1290363-2-vigneshr@ti.com/
> 

Oops, I guess I haven't been paying attention :$

> >  		#address-cells = <2>;
> >  		#size-cells = <2>;
> >  		dma-ranges;

...

> > +
> > +	main_gpio0: gpio@600000 {
> > +		compatible = "ti,am64-gpio", "ti,keystone-gpio";
> > +		reg = <0x0 0x00600000 0x0 0x100>;
> 
> 
> 		reg = <0x00 0x00600000 0x0 0x100>;
> 

Ah I wasn't even looking for that.. I'll fix that everywhere

> > +		gpio-controller;
> > +		#gpio-cells = <2>;
> > +		interrupt-parent = <&main_gpio_intr>;
> > +		interrupts = <190>, <191>, <192>,
> > +			     <193>, <194>, <195>;
> > +		interrupt-controller;
> > +		#interrupt-cells = <2>;
> > +		ti,ngpio = <92>;
> > +		ti,davinci-gpio-unbanked = <0>;
> > +		power-domains = <&k3_pds 77 TI_SCI_PD_EXCLUSIVE>;
> > +		clocks = <&k3_clks 77 0>;
> > +		clock-names = "gpio";
> > +	};
> > +
> > +	main_gpio1: gpio@601000 {
> > +		compatible = "ti,am64-gpio", "ti,keystone-gpio";
> > +		reg = <0x0 0x00601000 0x0 0x100>;
> 
> Same here
> 
> > +		gpio-controller;
> > +		#gpio-cells = <2>;
> > +		interrupt-parent = <&main_gpio_intr>;
> > +		interrupts = <180>, <181>, <182>,
> > +			     <183>, <184>, <185>;
> > +		interrupt-controller;
> > +		#interrupt-cells = <2>;
> > +		ti,ngpio = <52>;
> > +		ti,davinci-gpio-unbanked = <0>;
> > +		power-domains = <&k3_pds 78 TI_SCI_PD_EXCLUSIVE>;
> > +		clocks = <&k3_clks 78 0>;
> > +		clock-names = "gpio";
> > +	};
> > +
> > +	sdhci0: mmc@fa10000 {
> > +		compatible = "ti,am64-sdhci-8bit";
> > +		reg = <0x00 0x0fa10000 0x00 0x1000>, <0x00 0x0fa18000 0x00 0x400>;
> > +		interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
> > +		power-domains = <&k3_pds 57 TI_SCI_PD_EXCLUSIVE>;
> > +		clocks = <&k3_clks 57 1>, <&k3_clks 57 2>;
> > +		clock-names = "clk_ahb", "clk_xin";
> > +		assigned-clocks = <&k3_clks 57 2>;
> > +		assigned-clock-parents = <&k3_clks 57 4>;
> > +		mmc-ddr-1_8v;
> > +		mmc-hs200-1_8v;
> > +		mmc-hs400-1_8v;
> > +		bus-width = <8>;
> > +		ti,clkbuf-sel = <0x7>;
> > +		ti,otap-del-sel-legacy = <0x0>;
> > +		ti,otap-del-sel-mmc-hs = <0x0>;
> > +		ti,otap-del-sel-ddr52 = <0x5>;
> > +		ti,otap-del-sel-hs200 = <0x5>;
> > +		ti,itap-del-sel-legacy = <0xa>;
> > +		ti,itap-del-sel-mmc-hs = <0x1>;
> > +		ti,otap-del-sel-hs400 = <0x5>;
> > +		ti,strobe-sel = <0x77>;
> 
> Do we have prelim datasheet? Are these values derived from such a source?
>

No datasheet that I'm aware of yet, I know HS200 and HS400 are somewhat 
stable but these values would probably need to be adjusted.

> > +		ti,trm-icp = <0x8>;
> > +		status = "disabled";
> > +	};

....

> > +
> > +	usbss1: dwc3-usb@f910000 {
> > +		compatible = "ti,am62-usb";
> > +		reg = <0x00 0x0f910000 0x00 0x800>;
> > +		clocks = <&k3_clks 162 3>;
> > +		clock-names = "ref";
> > +		ti,syscon-phy-pll-refclk = <&wkup_conf 0x4018>;
> 
> wkup_conf is no longer a syscon node. Does this still work?
>

Oh man, I didn't even notice, I was having trouble with the MDIO and I 
turned it off, but for USB I don't recall even checking :$

I'll double check before I send out v2

> > +		#address-cells = <2>;
> > +		#size-cells = <2>;
> > +		power-domains = <&k3_pds 179 TI_SCI_PD_EXCLUSIVE>;
> > +		ranges;
> > +		status = "disabled";
> > +
> > +		usb1: usb@31100000 {
> > +			compatible = "snps,dwc3";
> > +			reg = <0x00 0x31100000 0x00 0x50000>;
> > +			interrupts = <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>, /* irq.0 */
> > +				     <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>; /* irq.0 */
> > +			interrupt-names = "host", "peripheral";
> > +			maximum-speed = "high-speed";
> > +			dr_mode = "otg";
> > +		};
> > +	};

...

> > +	cpsw3g: ethernet@8000000 {
> > +		compatible = "ti,am642-cpsw-nuss";
> > +		#address-cells = <2>;
> > +		#size-cells = <2>;
> > +		reg = <0x00 0x08000000 0x00 0x200000>;
> > +		reg-names = "cpsw_nuss";
> > +		ranges = <0x00 0x00 0x00 0x08000000 0x00 0x200000>;
> > +		clocks = <&k3_clks 13 0>;
> > +		assigned-clocks = <&k3_clks 13 3>;
> > +		assigned-clock-parents = <&k3_clks 13 11>;
> > +		clock-names = "fck";
> > +		power-domains = <&k3_pds 13 TI_SCI_PD_EXCLUSIVE>;
> > +
> > +		dmas = <&main_pktdma 0xc600 15>,
> > +		       <&main_pktdma 0xc601 15>,
> > +		       <&main_pktdma 0xc602 15>,
> > +		       <&main_pktdma 0xc603 15>,
> > +		       <&main_pktdma 0xc604 15>,
> > +		       <&main_pktdma 0xc605 15>,
> > +		       <&main_pktdma 0xc606 15>,
> > +		       <&main_pktdma 0xc607 15>,
> > +		       <&main_pktdma 0x4600 15>;
> > +		dma-names = "tx0", "tx1", "tx2", "tx3", "tx4", "tx5", "tx6",
> > +			    "tx7", "rx";
> > +
> > +		ethernet-ports {
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +
> > +			cpsw_port1: port@1 {
> > +				reg = <1>;
> > +				ti,mac-only;
> > +				label = "port1";
> > +				phys = <&phy_gmii_sel 1>;
> > +				mac-address = [00 00 00 00 00 00];
> > +				ti,syscon-efuse = <&wkup_conf 0x200>;
> 
> 
> Same here
>
> > +			};
> > +
> > +			cpsw_port2: port@2 {
> > +				reg = <2>;
> > +				ti,mac-only;
> > +				label = "port2";
> > +				phys = <&phy_gmii_sel 2>;
> > +				mac-address = [00 00 00 00 00 00];
> > +			};
> > +		};
> > +
> > +		cpsw3g_mdio: mdio@f00 {
> > +			compatible = "ti,cpsw-mdio","ti,davinci_mdio";
> > +			reg = <0x00 0xf00 0x00 0x100>;
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +			clocks = <&k3_clks 13 0>;
> > +			clock-names = "fck";
> > +			bus_freq = <1000000>;
> > +			status = "disabled";
> > +		};
> > +
> > +		cpts@3d000 {
> > +			compatible = "ti,j721e-cpts";
> > +			reg = <0x00 0x3d000 0x00 0x400>;
> > +			clocks = <&k3_clks 13 3>;
> > +			clock-names = "cpts";
> > +			interrupts-extended = <&gic500 GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
> > +			interrupt-names = "cpts";
> > +			ti,cpts-ext-ts-inputs = <4>;
> > +			ti,cpts-periodic-outputs = <2>;
> > +		};
> > +	};
> > +

...

> > +
> > +	mcu_esm: esm@4100000 {
> > +		bootph-pre-ram;
> > +		compatible = "ti,j721e-esm";
> > +		reg = <0x00 0x4100000 0x00 0x1000>;
> > +		ti,esm-pins = <0>, <1>, <2>, <85>;
> 
> 
> Do we want to keep it reserved by default as this maybe under MCU FW control?
> 

Yeah that's a better idea

Thanks for the review Vignesh!
~Bryan
