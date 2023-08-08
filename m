Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A375D774A1A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 22:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjHHUS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 16:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234700AbjHHUSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 16:18:45 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 41ADA59B3;
        Tue,  8 Aug 2023 12:23:09 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3786Wk7Z062958;
        Tue, 8 Aug 2023 01:32:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691476366;
        bh=m/z+ZEorE7Nb1tbGH4kNDp3mTcCQejFrJD/Y819NZo4=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=VdhOLCEYcaI1faJJZCkJxVg5Zr21yp0BB6AhS/mt61R/IK5fYk59ewVEAzaaNsBoM
         GW+W+FCKr4LqUgtvMMvQXNkhOkHNjnouCFFU7Rz4GH4hySjag/xbX812oIA0jKYVck
         3Ptw5d6S8WxaZ5gJVtRfx8wyENS7rsgEk6t/nDlI=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3786WjGo120625
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Aug 2023 01:32:45 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 8
 Aug 2023 01:32:45 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 8 Aug 2023 01:32:45 -0500
Received: from [172.24.227.112] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3786WduE080841;
        Tue, 8 Aug 2023 01:32:40 -0500
Message-ID: <958bd2bc-4f82-fe42-264d-01a6bcb65990@ti.com>
Date:   Tue, 8 Aug 2023 12:02:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 5/6] arm64: dts: ti: k3-am625-beagleplay: Add HDMI
 support
Content-Language: en-US
To:     Aradhya Bhatia <a-bhatia1@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Will Deacon <will@kernel.org>,
        Francesco Dolcini <francesco@dolcini.it>
CC:     Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Rahul T R <r-ravikumar@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>, Jai Luthra <j-luthra@ti.com>
References: <20230807153307.22174-1-a-bhatia1@ti.com>
 <20230807153307.22174-6-a-bhatia1@ti.com>
From:   Jayesh Choudhary <j-choudhary@ti.com>
In-Reply-To: <20230807153307.22174-6-a-bhatia1@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/08/23 21:03, Aradhya Bhatia wrote:
> From: Nishanth Menon <nm@ti.com>
> 
> The DSS outputs DPI signals via its second video port (VP2). The DPI
> output from DSS is 24 bits (RGB888) and is forwarded to an HDMI
> transmitter (ITE-IT66121) on the BeaglePlay platform. For audio output,
> BeaglePlay uses mcasp1.
> 
> Add pinmux info for DSS DPI signals.
> 
> Further, add support for HDMI audio and video output.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> [a-bhatia1: Edit sound node properties and HDMI node and label names]
> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
> ---
>   .../arm64/boot/dts/ti/k3-am625-beagleplay.dts | 158 ++++++++++++++++++
>   1 file changed, 158 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
> index e07ddff22e07..582410be9570 100644
> --- a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
> @@ -192,6 +192,34 @@ usr: button-usr {
>   
>   	};
>   
> +	hdmi0: connector-hdmi {
> +		compatible = "hdmi-connector";
> +		label = "hdmi";
> +		type = "a";
> +		port {
> +			hdmi_connector_in: endpoint {
> +				remote-endpoint = <&it66121_out>;
> +			};
> +		};
> +	};
> +
> +	sound {
> +		compatible = "simple-audio-card";
> +		simple-audio-card,name = "it66121 HDMI";
> +		simple-audio-card,format = "i2s";
> +		simple-audio-card,bitclock-master = <&hdmi_dailink_master>;
> +		simple-audio-card,frame-master = <&hdmi_dailink_master>;
> +
> +		hdmi_dailink_master: simple-audio-card,cpu {
> +			sound-dai = <&mcasp1>;
> +			system-clock-direction-out;
> +		};
> +
> +		simple-audio-card,codec {
> +			sound-dai = <&it66121>;
> +		};
> +	};
> +
>   	/* Workaround for errata i2329 - just use mdio bitbang */
>   	mdio0: mdio {
>   		compatible = "virtual,mdio-gpio";
> @@ -422,6 +450,57 @@ pmic_irq_pins_default: pmic-irq-default-pins {
>   			AM62X_IOPAD(0x01f4, PIN_INPUT_PULLUP, 0) /* (D16) EXTINTn */
>   		>;
>   	};
> +
> +	hdmi_gpio_pins_default: hdmi-gpio-default-pins {
> +		pinctrl-single,pins = <
> +			AM62X_IOPAD(0x0094, PIN_INPUT_PULLUP | PIN_DEBOUNCE_CONF6, 7) /* (N20) GPMC0_BE1n.GPIO0_36 */
> +			AM62X_IOPAD(0x0054, PIN_OUTPUT_PULLUP, 7) /* (P21) GPMC0_AD6.GPIO0_21 */
> +		>;
> +	};
> +
> +	mcasp_hdmi_pins_default: mcasp-hdmi-default-pins {
> +		pinctrl-single,pins = <
> +			AM62X_IOPAD(0x0090, PIN_INPUT, 2) /* (M24) GPMC0_BE0n_CLE.MCASP1_ACLKX */
> +			AM62X_IOPAD(0x0098, PIN_INPUT, 2) /* (U23) GPMC0_WAIT0.MCASP1_AFSX */
> +			AM62X_IOPAD(0x008c, PIN_OUTPUT, 2) /* (L25) GPMC0_WEn.MCASP1_AXR0 */
> +			AM62X_IOPAD(0x0088, PIN_INPUT, 2) /* (L24) GPMC0_OEn_REn.MCASP1_AXR1 */
> +			AM62X_IOPAD(0x0084, PIN_INPUT, 2) /* (L23) GPMC0_ADVn_ALE.MCASP1_AXR2 */
> +			AM62X_IOPAD(0x007c, PIN_INPUT, 2) /* (P25) GPMC0_CLK.MCASP1_AXR3 */
> +		>;
> +	};
> +
> +	dss0_pins_default: dss0-default-pins {
> +		pinctrl-single,pins = <
> +			AM62X_IOPAD(0x0100, PIN_OUTPUT, 0) /* (AC25) VOUT0_VSYNC */
> +			AM62X_IOPAD(0x00f8, PIN_OUTPUT, 0) /* (AB24) VOUT0_HSYNC */
> +			AM62X_IOPAD(0x0104, PIN_OUTPUT, 0) /* (AC24) VOUT0_PCLK */
> +			AM62X_IOPAD(0x00fc, PIN_OUTPUT, 0) /* (Y20) VOUT0_DE */
> +			AM62X_IOPAD(0x00b8, PIN_OUTPUT, 0) /* (U22) VOUT0_DATA0 */
> +			AM62X_IOPAD(0x00bc, PIN_OUTPUT, 0) /* (V24) VOUT0_DATA1 */
> +			AM62X_IOPAD(0x00c0, PIN_OUTPUT, 0) /* (W25) VOUT0_DATA2 */
> +			AM62X_IOPAD(0x00c4, PIN_OUTPUT, 0) /* (W24) VOUT0_DATA3 */
> +			AM62X_IOPAD(0x00c8, PIN_OUTPUT, 0) /* (Y25) VOUT0_DATA4 */
> +			AM62X_IOPAD(0x00cc, PIN_OUTPUT, 0) /* (Y24) VOUT0_DATA5 */
> +			AM62X_IOPAD(0x00d0, PIN_OUTPUT, 0) /* (Y23) VOUT0_DATA6 */
> +			AM62X_IOPAD(0x00d4, PIN_OUTPUT, 0) /* (AA25) VOUT0_DATA7 */
> +			AM62X_IOPAD(0x00d8, PIN_OUTPUT, 0) /* (V21) VOUT0_DATA8 */
> +			AM62X_IOPAD(0x00dc, PIN_OUTPUT, 0) /* (W21) VOUT0_DATA9 */
> +			AM62X_IOPAD(0x00e0, PIN_OUTPUT, 0) /* (V20) VOUT0_DATA10 */
> +			AM62X_IOPAD(0x00e4, PIN_OUTPUT, 0) /* (AA23) VOUT0_DATA11 */
> +			AM62X_IOPAD(0x00e8, PIN_OUTPUT, 0) /* (AB25) VOUT0_DATA12 */
> +			AM62X_IOPAD(0x00ec, PIN_OUTPUT, 0) /* (AA24) VOUT0_DATA13 */
> +			AM62X_IOPAD(0x00f0, PIN_OUTPUT, 0) /* (Y22) VOUT0_DATA14 */
> +			AM62X_IOPAD(0x00f4, PIN_OUTPUT, 0) /* (AA21) VOUT0_DATA15 */
> +			AM62X_IOPAD(0x005c, PIN_OUTPUT, 1) /* (R24) GPMC0_AD8.VOUT0_DATA16 */
> +			AM62X_IOPAD(0x0060, PIN_OUTPUT, 1) /* (R25) GPMC0_AD9.VOUT0_DATA17 */
> +			AM62X_IOPAD(0x0064, PIN_OUTPUT, 1) /* (T25) GPMC0_AD10.VOUT0_DATA18 */
> +			AM62X_IOPAD(0x0068, PIN_OUTPUT, 1) /* (R21) GPMC0_AD11.VOUT0_DATA19 */
> +			AM62X_IOPAD(0x006c, PIN_OUTPUT, 1) /* (T22) GPMC0_AD12.VOUT0_DATA20 */
> +			AM62X_IOPAD(0x0070, PIN_OUTPUT, 1) /* (T24) GPMC0_AD13.VOUT0_DATA21 */
> +			AM62X_IOPAD(0x0074, PIN_OUTPUT, 1) /* (U25) GPMC0_AD14.VOUT0_DATA22 */
> +			AM62X_IOPAD(0x0078, PIN_OUTPUT, 1) /* (U24) GPMC0_AD15.VOUT0_DATA23 */
> +		>;
> +	};
>   };
>   
>   &mcu_pmx0 {
> @@ -670,6 +749,46 @@ &main_i2c2 {
>   	pinctrl-0 = <&i2c2_1v8_pins_default>;
>   	clock-frequency = <100000>;
>   	status = "okay";
> +
> +	it66121: bridge-hdmi@4c {
> +		compatible = "ite,it66121";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&hdmi_gpio_pins_default>;
> +		reg = <0x4c>;
> +
> +		#sound-dai-cells = <0>;
> +
> +		interrupt-parent = <&main_gpio0>;
> +		interrupts = <36 IRQ_TYPE_EDGE_FALLING>;
> +
> +		vcn33-supply = <&vdd_3v3>;
> +		vcn18-supply = <&buck2_reg>;
> +		vrf12-supply = <&buck3_reg>;
> +

Fix unnecessary line breaks in this node.

> +		reset-gpios = <&main_gpio0 21 GPIO_ACTIVE_LOW>;
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@0 {
> +				reg = <0>;
> +
> +				it66121_in: endpoint {
> +					bus-width = <24>;
> +					remote-endpoint = <&dpi1_out>;
> +				};
> +			};
> +
> +			port@1 {
> +				reg = <1>;
> +
> +				it66121_out: endpoint {
> +					remote-endpoint = <&hdmi_connector_in>;
> +				};
> +			};
> +		};
> +	};
>   };
>   
>   &main_i2c3 {
> @@ -756,3 +875,42 @@ &main_uart6 {
>   	pinctrl-0 = <&wifi_debug_uart_pins_default>;
>   	status = "okay";
>   };
> +
> +&dss {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&dss0_pins_default>;
> +};
> +
> +&dss_ports {
> +	/* VP2: DPI Output */
> +	port@1 {
> +		reg = <1>;
> +
> +		dpi1_out: endpoint {
> +			remote-endpoint = <&it66121_in>;
> +		};
> +	};
> +};
> +
> +&mcasp1 {
> +	status = "okay";
> +	#sound-dai-cells = <0>;
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mcasp_hdmi_pins_default>;
> +
> +	auxclk-fs-ratio = <2177>;
> +
> +	op-mode = <0>;          /* MCASP_IIS_MODE */
> +	tdm-slots = <2>;
> +

Fix unnecessary line breaks in this node.

> +	serial-dir = <  /* 0: INACTIVE, 1: TX, 2: RX */
> +	       1 0 0 0
> +	       0 0 0 0
> +	       0 0 0 0
> +	       0 0 0 0
> +	>;
> +	tx-num-evt = <32>;
> +	rx-num-evt = <32>;
> +};
