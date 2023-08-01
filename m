Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9215A76B9E2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 18:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbjHAQsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 12:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbjHAQsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 12:48:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7AD10E;
        Tue,  1 Aug 2023 09:48:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 66E0261635;
        Tue,  1 Aug 2023 16:48:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52CB7C433C8;
        Tue,  1 Aug 2023 16:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690908489;
        bh=dAGSBpdgP559FQfd7iCLmLEEcO7xGZkJcOuwn1Nlil8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=sqaFUW4wBrWJpdPRWZQ+TG6HaObURMrJlIV6GAauSFNYhfGFydQ4LxHDHTjxSvPFk
         O7B8W6EYZoXFN87b/qwxYqjdlQKhxFi4yGBQJjOKvITbyIWaoxqFO+zUTWZchWI26M
         7ASrONtD1obsvVpEl5VCmLlp9dkg/ga0RdaVRUkcmNSSZjJqC1nU/nt/dZxfozqE9P
         ISypzgMxpl4y0WtVNOMjvaikAJW+gRQSHsAf8SQyEPWINNoH19S2gbG92EsMTwror+
         +EDrK7whevGWqUGxwk6FnIoxyI+KBKY9Sj1TKwFPCn2EXt5K9HLRCCXRIVlHEuu5TM
         hQg/icLzo7NVQ==
Message-ID: <b7d18f79-9063-2bc0-f17e-3f96abde5827@kernel.org>
Date:   Tue, 1 Aug 2023 19:48:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v8 5/5] arm64: dts: ti: k3-am69-sk: Add DP and HDMI
 support
Content-Language: en-US
To:     Jayesh Choudhary <j-choudhary@ti.com>, nm@ti.com, vigneshr@ti.com,
        Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc:     s-vadapalli@ti.com, afd@ti.com, kristo@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, a-bhatia1@ti.com, r-ravikumar@ti.com,
        sabiya.d@ti.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230801070019.219660-1-j-choudhary@ti.com>
 <20230801070019.219660-6-j-choudhary@ti.com>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20230801070019.219660-6-j-choudhary@ti.com>
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
> From: Dasnavis Sabiya <sabiya.d@ti.com>
> 
> AM69 starter kit features an HDMI port and an eDP port.
> 
> Add assigned clocks for DSS, DT node for DisplayPort PHY,
> pinmux for HDMI hotplug and power down, mcu_i2c1 and dss_vout
> for HDMI.
> Also enable Serdes4 settings for DP display.
> 
> Add the endpoint nodes to describe connection from:
> DSS => MHDP => DisplayPort connector
> DSS => TI TFP410 DPI-to-DVI Bridge => HDMI connector
> 
> Signed-off-by: Dasnavis Sabiya <sabiya.d@ti.com>
> [j-choudhary@ti.com: Fix dvi-bridge, dss, mhdp and serdes-refclk]
> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am69-sk.dts | 237 ++++++++++++++++++++++++++
>  1 file changed, 237 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am69-sk.dts b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
> index d282c2c633c1..d9a0794bcf6e 100644
> --- a/arch/arm64/boot/dts/ti/k3-am69-sk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
> @@ -107,6 +107,83 @@ vdd_sd_dv: regulator-tlv71033 {
>  		states = <1800000 0x0>,
>  			 <3300000 0x1>;
>  	};
> +
> +	dp0_pwr_3v3: regulator {

To be consistent with the rest of the file please
use regulator-dp0-pwr

> +		compatible = "regulator-fixed";
> +		regulator-name = "dp0-pwr";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&dp_pwr_en_pins_default>;
> +		gpio = <&main_gpio0 4 0>;	/* DP0_3V3 _EN */
> +		enable-active-high;
> +	};
> +
> +	dp0: connector {

connector-dp0

> +		compatible = "dp-connector";
> +		label = "DP0";
> +		type = "full-size";
> +		dp-pwr-supply = <&dp0_pwr_3v3>;
> +
> +		port {
> +			dp0_connector_in: endpoint {
> +				remote-endpoint = <&dp0_out>;
> +			};
> +		};
> +	};
> +
> +	hdmi-connector {

connector-hdmi

> +		compatible = "hdmi-connector";
> +		label = "hdmi";
> +		type = "a";
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&hdmi_hpd_pins_default>;
> +
> +		ddc-i2c-bus = <&mcu_i2c1>;
> +
> +		/* HDMI_HPD */
> +		hpd-gpios = <&main_gpio0 0 GPIO_ACTIVE_HIGH>;
> +
> +		port {
> +			hdmi_connector_in: endpoint {
> +				remote-endpoint = <&tfp410_out>;
> +			};
> +		};
> +	};
> +
> +	dvi-bridge {

Although DT binding doc for ti,tfp410 says encoder
a name starting with bridge maybe more appropriate.

> +		compatible = "ti,tfp410";
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&hdmi_pdn_pins_default>;
> +
> +		/* HDMI_PDn */
> +		powerdown-gpios = <&wkup_gpio0 14 GPIO_ACTIVE_LOW>;
> +		ti,deskew = <0>;
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@0 {
> +				reg = <0>;
> +
> +				tfp410_in: endpoint {
> +					remote-endpoint = <&dpi1_out0>;
> +					pclk-sample = <1>;
> +				};
> +			};
> +
> +			port@1 {
> +				reg = <1>;
> +
> +				tfp410_out: endpoint {
> +					remote-endpoint = <&hdmi_connector_in>;
> +				};
> +			};
> +		};
> +	};
>  };
>  
>  &main_pmx0 {
> @@ -161,6 +238,57 @@ J784S4_IOPAD(0x008, PIN_INPUT, 7) /* (AJ33) MCAN12_RX.GPIO0_2 */
>  			J784S4_IOPAD(0x004, PIN_INPUT, 7) /* (AG36) MCAN12_TX.GPIO0_1 */
>  		>;
>  	};
> +
> +	dp0_pins_default: dp0-pins-default {
> +		pinctrl-single,pins = <
> +			J784S4_IOPAD(0x014, PIN_INPUT, 13) /* (AG33) MCAN14_TX.DP0_HPD */
> +		>;
> +	};
> +
> +	dp_pwr_en_pins_default: dp-pwr-en-pins-default {
> +		pinctrl-single,pins = <
> +			J784S4_IOPAD(0x010, PIN_INPUT, 7) /* (AH33) MCAN13_RX.GPIO0_4 */
> +		>;
> +	};
> +
> +	dss_vout0_pins_default: dss-vout0-pins-default {
> +		pinctrl-single,pins = <
> +			J784S4_IOPAD(0x074, PIN_OUTPUT, 2) /* (AC33) MCAN2_TX.VOUT0_DATA0 */
> +			J784S4_IOPAD(0x070, PIN_OUTPUT, 2) /* (AH38) MCAN1_RX.VOUT0_DATA1 */
> +			J784S4_IOPAD(0x07c, PIN_OUTPUT, 2) /* (AJ38) MCASP0_AXR3.VOUT0_DATA2 */
> +			J784S4_IOPAD(0x068, PIN_OUTPUT, 2) /* (AE38) MCAN0_RX.VOUT0_DATA3 */
> +			J784S4_IOPAD(0x064, PIN_OUTPUT, 2) /* (AF38) MCAN0_TX.VOUT0_DATA4 */
> +			J784S4_IOPAD(0x060, PIN_OUTPUT, 2) /* (AE36) MCASP2_AXR1.VOUT0_DATA5 */
> +			J784S4_IOPAD(0x05c, PIN_OUTPUT, 2) /* (AC36) MCASP2_AXR0.VOUT0_DATA6 */
> +			J784S4_IOPAD(0x058, PIN_OUTPUT, 2) /* (AE37) MCASP2_AFSX.VOUT0_DATA7 */
> +			J784S4_IOPAD(0x054, PIN_OUTPUT, 2) /* (AD37) MCASP2_ACLKX.VOUT0_DATA8 */
> +			J784S4_IOPAD(0x050, PIN_OUTPUT, 2) /* (AC37) MCASP1_AXR2.VOUT0_DATA9 */
> +			J784S4_IOPAD(0x04c, PIN_OUTPUT, 2) /* (AC32) MCASP1_AXR1.VOUT0_DATA10 */
> +			J784S4_IOPAD(0x048, PIN_OUTPUT, 2) /* (AK33) MCASP0_AXR2.VOUT0_DATA11 */
> +			J784S4_IOPAD(0x044, PIN_OUTPUT, 2) /* (AG37) MCASP0_AXR1.VOUT0_DATA12 */
> +			J784S4_IOPAD(0x040, PIN_OUTPUT, 2) /* (AF37) MCASP0_AXR0.VOUT0_DATA13 */
> +			J784S4_IOPAD(0x03c, PIN_OUTPUT, 2) /* (AK38) MCASP0_AFSX.VOUT0_DATA14 */
> +			J784S4_IOPAD(0x038, PIN_OUTPUT, 2) /* (AK35) MCASP0_ACLKX.VOUT0_DATA15 */
> +			J784S4_IOPAD(0x0c8, PIN_OUTPUT, 2) /* (AJ32) EXT_REFCLK1.VOUT0_DATA16 */
> +			J784S4_IOPAD(0x030, PIN_OUTPUT, 2) /* (AK37) GPIO0_12.VOUT0_DATA17 */
> +			J784S4_IOPAD(0x02c, PIN_OUTPUT, 2) /* (AL32) GPIO0_11.VOUT0_DATA18 */
> +			J784S4_IOPAD(0x028, PIN_OUTPUT, 2) /* (AE33) MCAN16_RX.VOUT0_DATA19 */
> +			J784S4_IOPAD(0x024, PIN_OUTPUT, 2) /* (AH34) MCAN16_TX.VOUT0_DATA20 */
> +			J784S4_IOPAD(0x020, PIN_OUTPUT, 2) /* (AJ35) MCAN15_RX.VOUT0_DATA21 */
> +			J784S4_IOPAD(0x01c, PIN_OUTPUT, 2) /* (AG34) MCAN15_TX.VOUT0_DATA22 */
> +			J784S4_IOPAD(0x018, PIN_OUTPUT, 2) /* (AK36) MCAN14_RX.VOUT0_DATA23 */
> +			J784S4_IOPAD(0x084, PIN_OUTPUT, 2) /* (AG38) MCASP0_AXR5.VOUT0_DE */
> +			J784S4_IOPAD(0x080, PIN_OUTPUT, 2) /* (AK34) MCASP0_AXR4.VOUT0_HSYNC */
> +			J784S4_IOPAD(0x078, PIN_OUTPUT, 2) /* (AH37) MCAN2_RX.VOUT0_PCLK */
> +			J784S4_IOPAD(0x088, PIN_OUTPUT, 2) /* (AF36) MCASP0_AXR6.VOUT0_VSYNC */
> +		>;
> +	};
> +
> +	hdmi_hpd_pins_default: hdmi-hpd-pins-default {
> +		pinctrl-single,pins = <
> +			J784S4_IOPAD(0x000, PIN_INPUT, 7) /* (AN35) EXTINTN.GPIO0_0 */
> +		>;
> +	};
>  };
>  
>  &wkup_pmx2 {
> @@ -231,6 +359,21 @@ J784S4_WKUP_IOPAD(0x064, PIN_INPUT, 7) /* (J36) WKUP_GPIO0_3 */
>  			J784S4_WKUP_IOPAD(0x11c, PIN_INPUT, 7) /* (M34) WKUP_GPIO0_67 */
>  		>;
>  	};
> +
> +	mcu_i2c1_pins_default: mcu-i2c1-pins-default {
> +		pinctrl-single,pins = <
> +			/* (L35) WKUP_GPIO0_8.MCU_I2C1_SCL */
> +			J784S4_WKUP_IOPAD(0x078, PIN_INPUT_PULLUP, 0)
> +			/* (L34) WKUP_GPIO0_9.MCU_I2C1_SDA */
> +			J784S4_WKUP_IOPAD(0x07c, PIN_INPUT_PULLUP, 0)
> +		>;
> +	};
> +
> +	hdmi_pdn_pins_default: hdmi-pdn-pins-default {
> +		pinctrl-single,pins = <
> +			J784S4_WKUP_IOPAD(0x090, PIN_INPUT, 7) /* (H37) WKUP_GPIO0_14 */
> +		>;
> +	};
>  };
>  
>  &wkup_pmx3 {
> @@ -350,3 +493,97 @@ &mcu_cpsw_port1 {
>  	phy-mode = "rgmii-rxid";
>  	phy-handle = <&mcu_phy0>;
>  };
> +
> +&wkup_gpio_intr {
> +	status = "okay";
> +};
> +
> +&mcu_i2c1 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mcu_i2c1_pins_default>;
> +	clock-frequency = <100000>;
> +};
> +
> +&serdes_refclk {
> +	status = "okay";
> +	clock-frequency = <100000000>;
> +};
> +
> +&dss {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&dss_vout0_pins_default>;
> +	assigned-clocks = <&k3_clks 218 2>,
> +			  <&k3_clks 218 5>,
> +			  <&k3_clks 218 14>,
> +			  <&k3_clks 218 18>;
> +	assigned-clock-parents = <&k3_clks 218 3>,
> +				 <&k3_clks 218 7>,
> +				 <&k3_clks 218 16>,
> +				 <&k3_clks 218 22>;
> +};
> +
> +&serdes_wiz4 {
> +	status = "okay";
> +};
> +
> +&serdes4 {
> +	status = "okay";
> +	serdes4_dp_link: phy@0 {
> +		reg = <0>;
> +		cdns,num-lanes = <4>;
> +		#phy-cells = <0>;
> +		cdns,phy-type = <PHY_TYPE_DP>;
> +		resets = <&serdes_wiz4 1>, <&serdes_wiz4 2>,
> +			 <&serdes_wiz4 3>, <&serdes_wiz4 4>;
> +	};
> +};
> +
> +&mhdp {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&dp0_pins_default>;
> +	phys = <&serdes4_dp_link>;
> +	phy-names = "dpphy";
> +};
> +
> +&dss_ports {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	/* DP */
> +	port@0 {
> +		reg = <0>;
> +		dpi0_out: endpoint {
> +			remote-endpoint = <&dp0_in>;
> +		};
> +	};
> +
> +	/* HDMI */
> +	port@1 {
> +		reg = <1>;
> +		dpi1_out0: endpoint {
> +			remote-endpoint = <&tfp410_in>;
> +		};
> +	};
> +};
> +
> +&dp0_ports {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	port@0 {
> +		reg = <0>;
> +		dp0_in: endpoint {
> +			remote-endpoint = <&dpi0_out>;
> +		};
> +	};
> +
> +	port@4 {
> +		reg = <4>;
> +		dp0_out: endpoint {
> +			remote-endpoint = <&dp0_connector_in>;
> +		};
> +	};
> +};

-- 
cheers,
-roger
