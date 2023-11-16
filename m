Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3855D7EE2BD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 15:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbjKPO1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 09:27:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjKPO1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 09:27:07 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C29AD;
        Thu, 16 Nov 2023 06:27:03 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AGEQgIl024720;
        Thu, 16 Nov 2023 08:26:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1700144802;
        bh=xbhZckJg0LHMFVWujIIfrxDf2NjzRTaQ1shPZg1Xtt0=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=Xr9A/b8RlHRMimPCAcaJgOMh6etlT/OrSKXChbouBS5nHS6nIcvgzOk+2I5oVlsrE
         JrKThux23TzoED0zziDyPNffM7QN8PXebCUEHsSc6mwCUWfFKTQrpd26poCqJmiwO7
         dz4azlejnV8yEC7vjmnhaKVLbtF70b+dsLwrEs+8=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AGEQgY8107693
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 16 Nov 2023 08:26:42 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 16
 Nov 2023 08:26:41 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 16 Nov 2023 08:26:41 -0600
Received: from [10.250.34.132] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AGEQebH060158;
        Thu, 16 Nov 2023 08:26:41 -0600
Message-ID: <0a74f40d-a175-4c1d-9e6f-63cabdebb587@ti.com>
Date:   Thu, 16 Nov 2023 08:26:40 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] arm64: dts: ti: k3-am625-beagleplay: Add overlays for
 OV5640
Content-Language: en-US
To:     Jai Luthra <j-luthra@ti.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Aradhya Bhatia <a-bhatia1@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Vaishnav Achath <vaishnav.a@ti.com>,
        Julien Massot <julien.massot@collabora.com>,
        Martyn Welch <martyn.welch@collabora.com>
References: <20231115-csi_dts-v1-0-99fc535b2bde@ti.com>
 <20231115-csi_dts-v1-4-99fc535b2bde@ti.com>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <20231115-csi_dts-v1-4-99fc535b2bde@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
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

On 11/15/23 3:51 AM, Jai Luthra wrote:
> Three different OV5640 modules are supported using the FFC connector on
> BeaglePlay:
> - Digilent PCam 5C
> - ALINX AN5641
> - TEVI-OV5640-*-RPI
> 
> The Digilent and ALINX modules supply a 12Mhz XCLK to the sensor, while
> the TEVI module supplies a 24Mhz XCLK, thus requiring a separate
> overlay.
> 
> Signed-off-by: Jai Luthra <j-luthra@ti.com>
> ---
>   arch/arm64/boot/dts/ti/Makefile                    |  7 ++
>   .../dts/ti/k3-am625-beagleplay-csi2-ov5640.dtso    | 77 ++++++++++++++++++++++
>   .../ti/k3-am625-beagleplay-csi2-tevi-ov5640.dtso   | 77 ++++++++++++++++++++++
>   3 files changed, 161 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
> index 77a347f9f47d..e49e32414560 100644
> --- a/arch/arm64/boot/dts/ti/Makefile
> +++ b/arch/arm64/boot/dts/ti/Makefile
> @@ -9,9 +9,15 @@
>   # alphabetically.
>   
>   # Boards with AM62x SoC
> +k3-am625-beagleplay-csi2-ov5640-dtbs := k3-am625-beagleplay.dtb \
> +	k3-am625-beagleplay-csi2-ov5640.dtbo
> +k3-am625-beagleplay-csi2-tevi-ov5640-dtbs := k3-am625-beagleplay.dtb \
> +	k3-am625-beagleplay-csi2-tevi-ov5640.dtbo
>   k3-am625-sk-hdmi-audio-dtbs := k3-am625-sk.dtb k3-am62x-sk-hdmi-audio.dtbo
>   k3-am62-lp-sk-hdmi-audio-dtbs := k3-am62-lp-sk.dtb k3-am62x-sk-hdmi-audio.dtbo
>   dtb-$(CONFIG_ARCH_K3) += k3-am625-beagleplay.dtb
> +dtb-$(CONFIG_ARCH_K3) += k3-am625-beagleplay-csi2-ov5640.dtb
> +dtb-$(CONFIG_ARCH_K3) += k3-am625-beagleplay-csi2-tevi-ov5640.dtb


We don't need .dtb files for each overlay combination, you should leave these
as overlays only, and just apply them at boot time as needed.

To test apply them at build time, you can use the CONFIG_OF_ALL_DTBS
method that Rob suggested here[0].

# Build time test only, enabled by CONFIG_OF_ALL_DTBS
dtb- += \
	k3-am625-beagleplay-overlay-test1.dtb \
	k3-am625-beagleplay-overlay-test2.dtb
k3-am625-beagleplay-overlay-test1-dtbs := k3-am625-beagleplay.dtb \
	k3-am625-beagleplay-csi2-ov5640.dtbo
k3-am625-beagleplay-overlay-test1-dtbs := k3-am625-beagleplay.dtb \
	k3-am625-beagleplay-csi2-tevi-ov5640.dtbo

dtb-$(CONFIG_ARCH_K3) += k3-am625-beagleplay-csi2-ov5640.dtbo
dtb-$(CONFIG_ARCH_K3) += k3-am625-beagleplay-csi2-tevi-ov5640.dtbo

[0] https://lore.kernel.org/all/CAL_Jsq+8jisrwEqzz7tZnsV9g2+LmThwpO7sHRFA-zh+6q8XuA@mail.gmail.com/

>   dtb-$(CONFIG_ARCH_K3) += k3-am625-phyboard-lyra-rdk.dtb
>   dtb-$(CONFIG_ARCH_K3) += k3-am625-sk.dtb
>   dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-nonwifi-dahlia.dtb
> @@ -81,6 +87,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-am69-sk.dtb
>   dtb-$(CONFIG_ARCH_K3) += k3-j784s4-evm.dtb
>   
>   # Enable support for device-tree overlays
> +DTC_FLAGS_k3-am625-beagleplay += -@

Having any DTBO applied to the base during build will add symbols to the
base for you, no need to add this line.
(Please check that this is true for the OF_ALL_DTBS case above, I've not
checked yet, we should fix if not).

I plan to remove the same below in later patches so folks will stop adding
more of these lines.

Andrew

>   DTC_FLAGS_k3-am625-sk += -@
>   DTC_FLAGS_k3-am62-lp-sk += -@
>   DTC_FLAGS_k3-am6548-iot2050-advanced-m2 += -@
> diff --git a/arch/arm64/boot/dts/ti/k3-am625-beagleplay-csi2-ov5640.dtso b/arch/arm64/boot/dts/ti/k3-am625-beagleplay-csi2-ov5640.dtso
> new file mode 100644
> index 000000000000..5e80ca7033ba
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-am625-beagleplay-csi2-ov5640.dtso
> @@ -0,0 +1,77 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * ALINX AN5641 & Digilent PCam 5C - OV5640 camera module
> + * Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
> + */
> +
> +/dts-v1/;
> +/plugin/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +
> +&{/} {
> +	clk_ov5640_fixed: ov5640-xclk {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <12000000>;
> +	};
> +};
> +
> +&main_gpio0 {
> +	p11-hog {
> +		/* P11 - CSI2_CAMERA_GPIO1 */
> +		gpio-hog;
> +		gpios = <11 GPIO_ACTIVE_HIGH>;
> +		output-high;
> +		line-name = "CSI2_CAMERA_GPIO1";
> +	};
> +};
> +
> +&wkup_i2c0 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	status = "okay";
> +
> +	ov5640: camera@3c {
> +		compatible = "ovti,ov5640";
> +		reg = <0x3c>;
> +
> +		clocks = <&clk_ov5640_fixed>;
> +		clock-names = "xclk";
> +
> +		port {
> +			csi2_cam0: endpoint {
> +				remote-endpoint = <&csi2rx0_in_sensor>;
> +				clock-lanes = <0>;
> +				data-lanes = <1 2>;
> +			};
> +		};
> +	};
> +};
> +
> +&cdns_csi2rx0 {
> +	ports {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		csi0_port0: port@0 {
> +			reg = <0>;
> +			status = "okay";
> +
> +			csi2rx0_in_sensor: endpoint {
> +				remote-endpoint = <&csi2_cam0>;
> +				bus-type = <4>; /* CSI2 DPHY. */
> +				clock-lanes = <0>;
> +				data-lanes = <1 2>;
> +			};
> +		};
> +	};
> +};
> +
> +&dphy0 {
> +	status = "okay";
> +};
> +
> +&ti_csi2rx0 {
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/ti/k3-am625-beagleplay-csi2-tevi-ov5640.dtso b/arch/arm64/boot/dts/ti/k3-am625-beagleplay-csi2-tevi-ov5640.dtso
> new file mode 100644
> index 000000000000..5e1cbbc27c8f
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-am625-beagleplay-csi2-tevi-ov5640.dtso
> @@ -0,0 +1,77 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Technexion TEVI-OV5640-*-RPI - OV5640 camera module
> + * Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
> + */
> +
> +/dts-v1/;
> +/plugin/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +
> +&{/} {
> +	clk_ov5640_fixed: ov5640-xclk {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <24000000>;
> +	};
> +};
> +
> +&main_gpio0 {
> +	p11-hog {
> +		/* P11 - CSI2_CAMERA_GPIO1 */
> +		gpio-hog;
> +		gpios = <11 GPIO_ACTIVE_HIGH>;
> +		output-high;
> +		line-name = "CSI2_CAMERA_GPIO1";
> +	};
> +};
> +
> +&wkup_i2c0 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	status = "okay";
> +
> +	ov5640: camera@3c {
> +		compatible = "ovti,ov5640";
> +		reg = <0x3c>;
> +
> +		clocks = <&clk_ov5640_fixed>;
> +		clock-names = "xclk";
> +
> +		port {
> +			csi2_cam0: endpoint {
> +				remote-endpoint = <&csi2rx0_in_sensor>;
> +				clock-lanes = <0>;
> +				data-lanes = <1 2>;
> +			};
> +		};
> +	};
> +};
> +
> +&cdns_csi2rx0 {
> +	ports {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		csi0_port0: port@0 {
> +			reg = <0>;
> +			status = "okay";
> +
> +			csi2rx0_in_sensor: endpoint {
> +				remote-endpoint = <&csi2_cam0>;
> +				bus-type = <4>; /* CSI2 DPHY. */
> +				clock-lanes = <0>;
> +				data-lanes = <1 2>;
> +			};
> +		};
> +	};
> +};
> +
> +&dphy0 {
> +	status = "okay";
> +};
> +
> +&ti_csi2rx0 {
> +	status = "okay";
> +};
> 
