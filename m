Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B16C77764E9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 18:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjHIQTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 12:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjHIQTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 12:19:30 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19A1ED;
        Wed,  9 Aug 2023 09:19:29 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 379GJJQ2035445;
        Wed, 9 Aug 2023 11:19:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691597959;
        bh=4L4w9V2E0ffBRn9NIuGgpaaT1kiu+Z6Kt/BJvvSXl3k=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=rKv2s8RMUWJUiw7vuWCdZNRILAFteeIY7PeXYXaC6dSn322Jr/KmPSOAQg5jiGH4Q
         A50DsuiI/Tb3IFVOoPAAFYSg5V7R/0WHTS7H5XoVS+mQpBD3J8YX8ANANOGJ8klLXr
         k6vBkEKxtJ37/FwkppAlEhMblGrdj6KJrw/nwMx0=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 379GJJtW046202
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Aug 2023 11:19:19 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 9
 Aug 2023 11:19:18 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 9 Aug 2023 11:19:18 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 379GJIok002502;
        Wed, 9 Aug 2023 11:19:18 -0500
Date:   Wed, 9 Aug 2023 11:19:18 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Jai Luthra <j-luthra@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Esteban Blanc <eblanc@baylibre.com>, <jneanne@baylibre.com>,
        <aseketeli@baylibre.com>, <jpanis@baylibre.com>, <u-kumar1@ti.com>
Subject: Re: [PATCH v5 1/6] arm64: dts: ti: k3-j7200-som-p0: Add TP6594
 family PMICs
Message-ID: <20230809161918.ckqfnkaov5jdysca@random>
References: <20230809-tps6594-v5-0-485fd3d63670@ti.com>
 <20230809-tps6594-v5-1-485fd3d63670@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230809-tps6594-v5-1-485fd3d63670@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20:17-20230809, Jai Luthra wrote:
> From: Esteban Blanc <eblanc@baylibre.com>
> 
> This patch adds support for TPS6594 PMIC family on wakup I2C0 bus.
> Theses devices provides regulators (bucks and LDOs), but also
> GPIOs, a RTC, a watchdog, an ESM (Error Signal Monitor)
> which monitors the SoC error output signal, and a PFSM
> (Pre-configurable Finite State Machine) which manages the
> operational modes of the PMIC.
> 
> Signed-off-by: Esteban Blanc <eblanc@baylibre.com>
> Signed-off-by: Jai Luthra <j-luthra@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi | 157 ++++++++++++++++++++++++++++
>  1 file changed, 157 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
> index b37f4f88ece4..fbbd8bfa368c 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
> @@ -127,6 +127,14 @@ J721E_WKUP_IOPAD(0x9c, PIN_INPUT_PULLUP, 0) /* (H21) WKUP_I2C0_SDA */
>  	};
>  };
>  
> +&wkup_pmx3 {
> +	pmic_irq_pins_default: pmic-irq-pins-default {

This fails dtbs_check on next-20230809:
	pmic-irq-default-pins


> +		pinctrl-single,pins = <
> +			J721E_WKUP_IOPAD(0x01c, PIN_INPUT, 7) /* (E18) WKUP_GPIO0_84 */
> +		>;
> +	};
> +};
> +
>  &main_pmx0 {
>  	main_i2c0_pins_default: main-i2c0-default-pins {
>  		pinctrl-single,pins = <
> @@ -264,6 +272,155 @@ eeprom@50 {
>  		compatible = "atmel,24c256";
>  		reg = <0x50>;
>  	};
> +
> +	tps659414: pmic@48 {
> +		compatible = "ti,tps6594-q1";
> +		reg = <0x48>;
> +		ti,primary-pmic;
> +		system-power-controller;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pmic_irq_pins_default>;
> +		interrupt-parent = <&wkup_gpio0>;
> +		interrupts = <84 IRQ_TYPE_EDGE_FALLING>;
> +
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +
> +		buck1-supply = <&vsys_3v3>;
> +		buck2-supply = <&vsys_3v3>;
> +		buck3-supply = <&vsys_3v3>;
> +		buck4-supply = <&vsys_3v3>;
> +		buck5-supply = <&vsys_3v3>;
> +		ldo1-supply = <&vsys_3v3>;
> +		ldo2-supply = <&vsys_3v3>;
> +		ldo3-supply = <&vsys_3v3>;
> +		ldo4-supply = <&vsys_3v3>;
> +
> +		regulators {
> +			bucka1: buck1 {
> +				regulator-name = "vda_mcu_1v8";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			bucka2: buck2 {
> +				regulator-name = "vdd_mcuio_1v8";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			bucka3: buck3 {
> +				regulator-name = "vdd_mcu_0v85";
> +				regulator-min-microvolt = <850000>;
> +				regulator-max-microvolt = <850000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			bucka4: buck4 {
> +				regulator-name = "vdd_ddr_1v1";
> +				regulator-min-microvolt = <1100000>;
> +				regulator-max-microvolt = <1100000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			bucka5: buck5 {
> +				regulator-name = "vdd_phyio_1v8";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldoa1: ldo1 {
> +				regulator-name = "vdd1_lpddr4_1v8";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldoa2: ldo2 {
> +				regulator-name = "vda_dll_0v8";
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <800000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldoa3: ldo3 {
> +				regulator-name = "vdd_wk_0v8";
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <800000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldoa4: ldo4 {
> +				regulator-name = "vda_pll_1v8";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +		};
> +	};
> +
> +	lp876441: pmic@4c {
> +		compatible = "ti,lp8764-q1";
> +		reg = <0x4c>;
> +		system-power-controller;
> +		interrupt-parent = <&wkup_gpio0>;
> +		interrupts = <84 IRQ_TYPE_EDGE_FALLING>;
> +
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +
> +		buck1-supply = <&vsys_3v3>;
> +		buck2-supply = <&vsys_3v3>;
> +		buck3-supply = <&vsys_3v3>;
> +		buck4-supply = <&vsys_3v3>;
> +
> +		regulators: regulators {
> +			buckb1: buck1 {
> +				regulator-name = "vdd_cpu_avs";
> +				regulator-min-microvolt = <600000>;
> +				regulator-max-microvolt = <900000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			buckb2: buck2 {
> +				regulator-name = "vdd_ram_0v85";
> +				regulator-min-microvolt = <850000>;
> +				regulator-max-microvolt = <850000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			buckb3: buck3 {
> +				regulator-name = "vdd_core_0v85";
> +				regulator-min-microvolt = <850000>;
> +				regulator-max-microvolt = <850000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			buckb4: buck4 {
> +				regulator-name = "vdd_io_1v8";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +		};
> +	};
>  };
>  
>  &ospi0 {
> 
> -- 
> 2.41.0
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
