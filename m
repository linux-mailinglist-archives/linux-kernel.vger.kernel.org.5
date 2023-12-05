Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05015805BCE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346178AbjLEPRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 10:17:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346795AbjLEPQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 10:16:58 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07795D5E;
        Tue,  5 Dec 2023 07:17:00 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B5FGmiM111363;
        Tue, 5 Dec 2023 09:16:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1701789408;
        bh=BKzh+kOh02ASiRlhIrGNOM+NRUg1YSYQZynqZVbiX4Q=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=ohq3db3YyM5Cr3/S2RrNv1rrtm3nuBaRdpoOHRVx7eElLzcfYCwz11ZxMr6u2egs5
         75jm7zF1ZmArHJ6HZ1AnIS6YfkO6hyLTumhXYtls+Q2uR9hZMwd8CePKfXHXh7HMR7
         cgfsLPeywtmQVTXLXqPxhjjT8lSyHS8PUpwY/Mxw=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B5FGmII105736
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 5 Dec 2023 09:16:48 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 5
 Dec 2023 09:16:48 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 5 Dec 2023 09:16:47 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B5FGltD080358;
        Tue, 5 Dec 2023 09:16:47 -0600
Date:   Tue, 5 Dec 2023 09:16:47 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Neha Malcom Francis <n-francis@ti.com>
CC:     <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <a-nandan@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <eblanc@baylibre.com>, <jneanne@baylibre.com>,
        <aseketeli@baylibre.com>, <jpanis@baylibre.com>, <u-kumar1@ti.com>,
        <j-luthra@ti.com>, <vaishnav.a@ti.com>, <hnagalla@ti.com>,
        <devarsht@ti.com>
Subject: Re: [PATCH v9 6/7] arm64: dts: ti: k3-j721e-sk: Add TPS6594 family
 PMICs
Message-ID: <20231205151647.vh6rlhro7qlwoerc@knelt>
References: <20231205093439.2298296-1-n-francis@ti.com>
 <20231205093439.2298296-7-n-francis@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231205093439.2298296-7-n-francis@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15:04-20231205, Neha Malcom Francis wrote:
> This patch adds support for TPS6594 PMIC family on wakeup I2C0 bus.
> These devices provide regulators (bucks and LDOs), but also GPIOs, a
> RTC, a watchdog, an ESM (Error Signal Monitor) which monitors the SoC
> error output signal, and a PFSM (Pre-configurable Finite State Machine)
> which manages the operational modes of the PMIC.
> 
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-j721e-sk.dts | 158 +++++++++++++++++++++++++
>  1 file changed, 158 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
> index 42fe8eee9ec8..e600825f7e78 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
> @@ -459,6 +459,13 @@ J721E_IOPAD(0x234, PIN_INPUT, 7) /* (U3) EXT_REFCLK1.GPIO1_12 */
>  };
>  
>  &wkup_pmx0 {
> +	pmic_irq_pins_default: pmic-irq-default-pins {
> +		bootph-pre-ram;
> +		pinctrl-single,pins = <
> +			J721E_WKUP_IOPAD(0x0cc, PIN_INPUT, 7) /* (G28) WKUP_GPIO0_7 */
> +		>;
> +	};
> +
>  	mcu_cpsw_pins_default: mcu-cpsw-default-pins {
>  		pinctrl-single,pins = <
>  			J721E_WKUP_IOPAD(0x84, PIN_INPUT, 0) /* (B24) MCU_RGMII1_RD0 */
> @@ -560,6 +567,157 @@ eeprom@51 {
>  		compatible = "atmel,24c512";
>  		reg = <0x51>;
>  	};
> +
> +	tps659413: pmic@48 {
> +		bootph-pre-ram;

only for the leaf nodes. See
https://libera.irclog.whitequark.org/armlinux/2023-10-19

> +		compatible = "ti,tps6594-q1";
> +		reg = <0x48>;
> +		system-power-controller;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pmic_irq_pins_default>;
> +		interrupt-parent = <&wkup_gpio0>;
> +		interrupts = <9 IRQ_TYPE_EDGE_FALLING>;
> +		ti,primary-pmic;
> +
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +
> +		buck123-supply = <&vsys_3v3>;
> +		buck4-supply = <&vsys_3v3>;
> +		buck5-supply = <&vsys_3v3>;
> +		ldo1-supply = <&vsys_3v3>;
> +		ldo2-supply = <&vsys_3v3>;
> +		ldo3-supply = <&vsys_3v3>;
> +		ldo4-supply = <&vsys_3v3>;
> +
> +		regulators {
> +			bootph-pre-ram;
> +			bucka123: buck123 {
> +				bootph-pre-ram;
> +				regulator-name = "vdd_cpu_avs";
> +				regulator-min-microvolt = <600000>;
> +				regulator-max-microvolt = <900000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			bucka4: buck4 {
> +				regulator-name = "vdd_mcu_0v85";
> +				regulator-min-microvolt = <850000>;
> +				regulator-max-microvolt = <850000>;
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
> +				regulator-name = "vdd_mcuio_1v8";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldoa3: ldo3 {
> +				regulator-name = "vdda_dll_0v8";
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <800000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldoa4: ldo4 {
> +				regulator-name = "vda_mcu_1v8";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +		};
> +	};
> +
> +	tps659411: pmic@4c {
> +		compatible = "ti,tps6594-q1";
> +		reg = <0x4c>;
> +		system-power-controller;
> +		interrupt-parent = <&wkup_gpio0>;
> +		interrupts = <9 IRQ_TYPE_EDGE_FALLING>;
> +
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +
> +		buck1234-supply = <&vsys_3v3>;
> +		buck5-supply = <&vsys_3v3>;
> +		ldo1-supply = <&vsys_3v3>;
> +		ldo2-supply = <&vsys_3v3>;
> +		ldo3-supply = <&vsys_3v3>;
> +		ldo4-supply = <&vsys_3v3>;
> +
> +		regulators {
> +			buckb1234: buck1234 {
> +				regulator-name = "vdd_core_0v8";
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <800000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			buckb5: buck5 {
> +				regulator-name = "vdd_ram_0v85";
> +				regulator-min-microvolt = <850000>;
> +				regulator-max-microvolt = <850000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldob1: ldo1 {
> +				regulator-name = "vdd_sd_dv";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldob2: ldo2 {
> +				regulator-name = "vdd_usb_3v3";
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldob3: ldo3 {
> +				regulator-name = "vdd_io_1v8";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldob4: ldo4 {
> +				regulator-name = "vda_pll_1v8";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +		};
> +	};
>  };
>  
>  &mcu_uart0 {
> -- 
> 2.34.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
