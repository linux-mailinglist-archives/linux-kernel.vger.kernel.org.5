Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7C2076B9D3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 18:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbjHAQk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 12:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbjHAQk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 12:40:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253422108;
        Tue,  1 Aug 2023 09:40:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B330461625;
        Tue,  1 Aug 2023 16:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE837C433C7;
        Tue,  1 Aug 2023 16:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690908024;
        bh=9Zj4ne5Gw6euat2eGPvypb6viKCkkWGRlyGCVFFJRcc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=E9DcE+GSgFKqxSzSWJBElAs0Eto1a+wxzwLRpWuqlvCVEAo2qVQTNCm5W5kfDU6SM
         kOCmemaorRqWdwSJoYfPG9Uv6ik1DPi9iuSOIJqUuBuIY5pDOgEGtHxdzQvlrG2SHT
         JG2KPP4whaz/CRc956ZD/mHH9/wdlXOPBotTUXbYSnBC5xE8p6UhqRvpVq6TnzhraQ
         iaYI/hV8cFVUc0+6NOHQP7pPAzqCSDwAZa5LYHOu0AxaTs/QAx34Ib6QC44yVNYbNw
         iMGiGRq4QeRLod2YRfWl5Xy41VB9DQj72aufZSORroo1tExdgjyxDg0F6//18y2VQM
         ZaK4M6ZJobCAw==
Message-ID: <1cd8af90-c4f3-99c8-50b2-bf379d5b76f0@kernel.org>
Date:   Tue, 1 Aug 2023 19:40:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v8 4/5] arm64: dts: ti: k3-j784s4-evm: Enable
 DisplayPort-0
Content-Language: en-US
To:     Jayesh Choudhary <j-choudhary@ti.com>, nm@ti.com, vigneshr@ti.com
Cc:     s-vadapalli@ti.com, afd@ti.com, kristo@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, a-bhatia1@ti.com, r-ravikumar@ti.com,
        sabiya.d@ti.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230801070019.219660-1-j-choudhary@ti.com>
 <20230801070019.219660-5-j-choudhary@ti.com>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20230801070019.219660-5-j-choudhary@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/08/2023 10:00, Jayesh Choudhary wrote:
> From: Rahul T R <r-ravikumar@ti.com>
> 
> Enable display for J784S4 EVM.
> 
> Add assigned clocks for DSS, DT node for DisplayPort PHY and pinmux for
> DP HPD. Add the clock frequency for serdes_refclk.
> 
> Add the endpoint nodes to describe connection from:
> DSS => MHDP => DisplayPort connector.
> 
> Also add the GPIO expander-4 node and pinmux for main_i2c4 which is
> required for controlling DP power. Set status for all required nodes
> for DP-0 as "okay".
> 
> Signed-off-by: Rahul T R <r-ravikumar@ti.com>
> [j-choudhary@ti.com: move all the changes together to enable DP-0 in EVM]
> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-j784s4-evm.dts | 117 +++++++++++++++++++++++
>  1 file changed, 117 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
> index 7ad152a1b90f..1145a7f046e2 100644
> --- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
> @@ -249,6 +249,28 @@ vdd_sd_dv: regulator-TLV71033 {
>  		states = <1800000 0x0>,
>  			 <3300000 0x1>;
>  	};
> +
> +	dp0_pwr_3v3: regulator-dp0-prw {
> +		compatible = "regulator-fixed";
> +		regulator-name = "dp0-pwr";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpio = <&exp4 0 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
> +	dp0: dp0-connector {

dp0-connector is not a standard name.

https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

how about connector-dp0?

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
>  };
>  
>  &main_pmx0 {
> @@ -286,6 +308,19 @@ vdd_sd_dv_pins_default: vdd-sd-dv-default-pins {
>  			J784S4_IOPAD(0x020, PIN_INPUT, 7) /* (AJ35) MCAN15_RX.GPIO0_8 */
>  		>;
>  	};
> +
> +	dp0_pins_default: dp0-pins-default {
> +		pinctrl-single,pins = <
> +			J784S4_IOPAD(0x0cc, PIN_INPUT, 12) /* (AM37) SPI0_CS0.DP0_HPD */
> +		>;
> +	};
> +
> +	main_i2c4_pins_default: main-i2c4-pins-default {
> +		pinctrl-single,pins = <
> +			J784S4_IOPAD(0x014, PIN_INPUT_PULLUP, 8) /* (AG33) MCAN14_TX.I2C4_SCL */
> +			J784S4_IOPAD(0x010, PIN_INPUT_PULLUP, 8) /* (AH33) MCAN13_RX.I2C4_SDA */
> +		>;
> +	};
>  };
>  
>  &wkup_pmx2 {
> @@ -827,3 +862,85 @@ adc {
>  		ti,adc-channels = <0 1 2 3 4 5 6 7>;
>  	};
>  };
> +
> +&serdes_refclk {
> +	status = "okay";
> +	clock-frequency = <100000000>;
> +};
> +
> +&dss {
> +	status = "okay";
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
> +	port {
> +		dpi0_out: endpoint {
> +			remote-endpoint = <&dp0_in>;
> +		};
> +	};
> +};
> +
> +&main_i2c4 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_i2c4_pins_default>;
> +	clock-frequency = <400000>;
> +
> +	exp4: gpio@20 {
> +		compatible = "ti,tca6408";
> +		reg = <0x20>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
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
