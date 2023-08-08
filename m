Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 092F7774CE8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 23:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236192AbjHHVVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 17:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236381AbjHHVUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 17:20:54 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D23108165;
        Tue,  8 Aug 2023 12:20:57 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3786U6qv060793;
        Tue, 8 Aug 2023 01:30:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691476206;
        bh=wF+Od39Rcqfp149eexmbTsgWrXqjZlSJnDdokcfMF7I=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=X3gyPlK6E9S6XUh4WgWqDdXrCLtAwiUggSNP0Axbr5VXHMmo2+Bi0kPPX2+5E6Ho2
         eNFXPlWD2Y5vpStcikSjQDnxjpvBRz8j0RRrH6Nx7p8FpdF8JlZYnpILyKbFuaNsay
         18jUEXdmfqOaw7jNpEOqNQ7FhTC403t4lnMEQWQc=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3786U43S009248
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Aug 2023 01:30:06 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 8
 Aug 2023 01:30:06 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 8 Aug 2023 01:30:06 -0500
Received: from [172.24.227.112] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3786U1gp038423;
        Tue, 8 Aug 2023 01:30:01 -0500
Message-ID: <bf28aa72-532d-630e-8d13-8771c3c120ed@ti.com>
Date:   Tue, 8 Aug 2023 12:00:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 3/6] arm64: dts: ti: k3-am62x-sk-common: Add HDMI
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
 <20230807153307.22174-4-a-bhatia1@ti.com>
From:   Jayesh Choudhary <j-choudhary@ti.com>
In-Reply-To: <20230807153307.22174-4-a-bhatia1@ti.com>
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
> The DSS outputs DPI signals via its second video port (VP2). The DPI
> output from DSS is 24 bits (RGB888) and is forwarded to an HDMI
> transmitter (SIL9022) on the board.
> 
> Add pinmux info for DSS DPI output.
> 
> Add DT nodes for SIL9022 HDMI transmitter (TX), and the HDMI connector
> on the AM625 SK and AM62-LP SK platforms.
> 
> Additionally, connect the output of DSS (VP2) with input of the HDMI TX,
> and the output of HDMI TX to the input of the HDMI connector.
> 
> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
> ---
>   .../arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 93 +++++++++++++++++++
>   1 file changed, 93 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
> index 540ed8a0d7fb..edbe5295373b 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
> @@ -114,6 +114,17 @@ sound_master: simple-audio-card,codec {
>   			clocks = <&tlv320_mclk>;
>   		};
>   	};
> +
> +	hdmi0: connector-hdmi {
> +		compatible = "hdmi-connector";
> +		label = "hdmi";
> +		type = "a";
> +		port {
> +			hdmi_connector_in: endpoint {
> +				remote-endpoint = <&sii9022_out>;
> +			};
> +		};
> +	};
>   };
>   
>   &main_pmx0 {
> @@ -226,6 +237,39 @@ AM62X_IOPAD(0x08c, PIN_OUTPUT, 2) /* (L25/J17) GPMC0_WEN.MCASP1_AXR0 */
>   			AM62X_IOPAD(0x084, PIN_INPUT, 2) /* (L23/K20) GPMC0_ADVN_ALE.MCASP1_AXR2 */
>   		>;
>   	};
> +
> +	main_dss0_pins_default: main-dss0-default-pins {
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

Rest of the pinmux in the file uses padding of 3. Here you are using
padding of 4. Consistency would be good.


> +		>;
> +	};
>   };
>   
>   &mcu_pmx0 {
> @@ -313,6 +357,38 @@ tlv320aic3106: audio-codec@1b {
>   		IOVDD-supply = <&vcc_3v3_sys>;
>   		DRVDD-supply = <&vcc_3v3_sys>;
>   	};
> +
> +	sii9022: bridge-hdmi@3b {
> +		compatible = "sil,sii9022";
> +		reg = <0x3b>;
> +

Line break not needed.

> +		interrupt-parent = <&exp1>;
> +		interrupts = <16 IRQ_TYPE_EDGE_FALLING>;
> +

Same.

> +		#sound-dai-cells = <0>;
> +		sil,i2s-data-lanes = < 0 >;
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@0 {
> +				reg = <0>;
> +
> +				sii9022_in: endpoint {
> +					remote-endpoint = <&dpi1_out>;
> +				};
> +			};
> +
> +			port@1 {
> +				reg = <1>;
> +
> +				sii9022_out: endpoint {
> +					remote-endpoint = <&hdmi_connector_in>;
> +				};
> +			};
> +		};
> +	};
>   };
>   
>   &sdhci0 {
> @@ -410,3 +486,20 @@ &mcasp1 {
>   	tx-num-evt = <32>;
>   	rx-num-evt = <32>;
>   };
> +
> +&dss {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_dss0_pins_default>;
> +};
> +
> +&dss_ports {
> +	/* VP2: DPI Output */
> +	port@1 {
> +		reg = <1>;
> +
> +		dpi1_out: endpoint {
> +			remote-endpoint = <&sii9022_in>;
> +		};
> +	};
> +};
