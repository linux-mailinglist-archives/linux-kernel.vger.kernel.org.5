Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF05D80F3A3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 17:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235269AbjLLQwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 11:52:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235115AbjLLQws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 11:52:48 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF1011A;
        Tue, 12 Dec 2023 08:52:40 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BCGqOxS013645;
        Tue, 12 Dec 2023 10:52:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1702399944;
        bh=1MUe3Fn2h5Bh4AZuLfrUVgvBk2Kq/67ffcBC8IxjSJk=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=ZLsFKZ2Y3vPZAvr+BluZxWemhANjfPDQykyDci0oo6pgAQSi0rIFG6GgKXjv6I2MH
         gdzFXUnnKsr2/BUg+eyKE6jWya5VOS+3vC3B5vbcpm+mtJX7JhWSbqB0GsvZ33DsY2
         Z2ZqY85Ox9GbTO8hPxYrmk5Th4sTkrvQlh7DqNxg=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BCGqOdT033179
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Dec 2023 10:52:24 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 12
 Dec 2023 10:52:23 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 12 Dec 2023 10:52:24 -0600
Received: from localhost (reidt-hp-z2.dhcp.ti.com [128.247.81.215])
        by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BCGqN6T037633;
        Tue, 12 Dec 2023 10:52:23 -0600
Date:   Tue, 12 Dec 2023 10:52:23 -0600
From:   reidt <reidt@ti.com>
To:     Neha Malcom Francis <n-francis@ti.com>
CC:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <a-nandan@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <eblanc@baylibre.com>, <jneanne@baylibre.com>,
        <aseketeli@baylibre.com>, <jpanis@baylibre.com>, <u-kumar1@ti.com>,
        <j-luthra@ti.com>, <vaishnav.a@ti.com>, <hnagalla@ti.com>,
        <devarsht@ti.com>
Subject: Re: [PATCH v10 1/7] arm64: dts: ti: k3-j7200-som-p0: Add TP6594
 family PMICs
Message-ID: <20231212165223.lowflzvrut6yxtgy@reidt-HP-Z2>
References: <20231208114919.3429562-1-n-francis@ti.com>
 <20231208114919.3429562-2-n-francis@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231208114919.3429562-2-n-francis@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17:19-20231208, Neha Malcom Francis wrote:
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
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---

Reviewed-by: Reid Tonking <reidt@ti.com>

>  arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi | 153 ++++++++++++++++++++
>  1 file changed, 153 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
> index 5a300d4c8ba0..ea47f10d393a 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
> @@ -127,6 +127,14 @@ J721E_WKUP_IOPAD(0x9c, PIN_INPUT_PULLUP, 0) /* (H21) WKUP_I2C0_SDA */
>  	};
>  };
>  
> +&wkup_pmx3 {
> +	pmic_irq_pins_default: pmic-irq-default-pins {
> +		pinctrl-single,pins = <
> +			J721E_WKUP_IOPAD(0x01c, PIN_INPUT, 7) /* (E18) WKUP_GPIO0_84 */
> +		>;
> +	};
> +};
> +
>  &main_pmx0 {
>  	main_i2c0_pins_default: main-i2c0-default-pins {
>  		pinctrl-single,pins = <
> @@ -264,6 +272,151 @@ eeprom@50 {
>  		compatible = "atmel,24c256";
>  		reg = <0x50>;
>  	};
> +
> +	tps659414: pmic@48 {
> +		compatible = "ti,tps6594-q1";
> +		reg = <0x48>;
> +		system-power-controller;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pmic_irq_pins_default>;
> +		interrupt-parent = <&wkup_gpio0>;
> +		interrupts = <84 IRQ_TYPE_EDGE_FALLING>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +		ti,primary-pmic;
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
> +		gpio-controller;
> +		#gpio-cells = <2>;
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
> +				bootph-pre-ram;
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
> -- 
> 2.34.1
> 
> 
