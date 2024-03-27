Return-Path: <linux-kernel+bounces-121884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3553888EEEB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 20:11:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58C8E1C3447F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3C8152162;
	Wed, 27 Mar 2024 19:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="K3oLB0LM";
	dkim=permerror (0-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="hG9trXjj"
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9612A14D28A;
	Wed, 27 Mar 2024 19:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711566682; cv=pass; b=MINZNCMkFXv4oWeSKLcj5HL2vi2gAeN/4R3pJ8ftDlEEqjQBPDb3cAvljQzVyNRXkfvVvT/oPxIdju5ppsDnpqMuUMiAbwc/t6tBCVeho+3bTif18RhdvLQuwCKEQoy9kxrWe/kKmfXlYIcAMqr3cptJjKopo8TSK9re6HY9MS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711566682; c=relaxed/simple;
	bh=LSC6FYhlWktjSeJizpbf/RXRlJUpz/tIcbgL5/mzw+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VY8Vtmv4K+C08stH2y3B4SQi+NR6oiqUZo9mP1BI8nn+wCSyqR2eRhJZC/qe4dV2L7IUmg+/C2XYXCqLCDdqd4P3hWPKSDV0By4ES0d2gUWeoodaagIGdgJAqATVu8pGcA/SqigH+Q1vrvme220VeufpFORa+qPYDo/tDcHOtVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gerhold.net; spf=none smtp.mailfrom=gerhold.net; dkim=pass (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b=K3oLB0LM; dkim=permerror (0-bit key) header.d=gerhold.net header.i=@gerhold.net header.b=hG9trXjj; arc=pass smtp.client-ip=85.215.255.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gerhold.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=gerhold.net
ARC-Seal: i=1; a=rsa-sha256; t=1711566655; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Jur3CmB7OjScP0ZzCyNs9DunpTOFyebxCJ3VmK67bvsl4k4gc1k9SgQGl7jgIBp3Ni
    PfleCVHM+NMmxZWwQA4xvw3EwtI4FB+CP4QGwKFFYXeQLDqEMtSSVTnXGf0KfSpR14nF
    tW8iUp2h58ogoGCqF58L3Sxp348eFUy0A92J8bbnpGn5T/nvZI8QXLzwU30qFDem+PaB
    59HTuk/qjMBTwwcXY0iQNlxKa+VmAAnZ5FK5rK2+b69eNi2vbT06nJZfgKZruYmTHDBH
    CXy4I9Q9p8P9xE9PoKAiY+ahMrt8jO69ZJmOD0RGTkXvGqGW85D86ncOlXriU02Brde8
    UJwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1711566655;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=UvBfW+6/owmwb22HzMgtv/It2al99PIFqL7sLCRrUw4=;
    b=glModXRI8Gr6xwR+8NjEomVj+1RyIQbMdJpPs/Fyw+sVNY9M+eitTT2A46mdlVsjTh
    gBRBVItRilSqCBieu9g8U+I7jXwIi7GGy7Ij74MxpWnM1xf6CPqYsP+5honSSxfvIfHO
    uag8CtZ7MEEeuaW5pi5fTT/T2cx/OFy95PFLs4MZb1Q0jj1aONwoWJwSzSWmPBku1nlG
    85ozFXuI+4+uC7MZCr2gOJwBZZQ/7nhulBONoNKRq/M9uH+xbF0yDwKr4VxD7EmCiQFr
    ys2dCqnuLLxN89u3uhCtftDCBiKOp37HzPZsTf0yksHegzdenb34aHknUdAKHjsCRvl/
    +HkQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1711566655;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=UvBfW+6/owmwb22HzMgtv/It2al99PIFqL7sLCRrUw4=;
    b=K3oLB0LM2MWY7rdT+4JeE4OFU50BjacMnzkbGCYoSa62AJID3sFGKlCt9CUFuCfCAc
    iZHxfHDU2vw6QgslNxGY6P2ndpMylTIJUrzh8sOPXI8t75yMUJ4hbJgCVGvFE2KfOIv3
    F7KqT6v21dR3tmmewaXBRZYdl/onEZgK3OFdMVVfXSM82qU3p3vhaxDIxSf1HkWpYwIx
    zi4s+d5prMSc2aHbVvUoCdpF5hIJEJ6SQnhvn3XiqHftG8teIEcHBEq4KzCnOJ7Ny9/9
    5fsSZnsQVI62Hf8RwYxNDlYQjpPJKgUV8NWHySnqrwTIRDe+TUQ/+zivHJks0VTkN2gy
    kixw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1711566655;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=UvBfW+6/owmwb22HzMgtv/It2al99PIFqL7sLCRrUw4=;
    b=hG9trXjjtQNuwujdi9JBvcFFO5Ww7eBuO7elTl/GJ5m9ftfg6N2VSrJISQmyHxGUIe
    +GPvtxLaKOH8vk/G6sAg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4peA8Z/h"
Received: from gerhold.net
    by smtp.strato.de (RZmta 50.3.2 DYNA|AUTH)
    with ESMTPSA id Raf12502RJAsREw
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 27 Mar 2024 20:10:54 +0100 (CET)
Date: Wed, 27 Mar 2024 20:10:47 +0100
From: Stephan Gerhold <stephan@gerhold.net>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	caleb.connolly@linaro.org, neil.armstrong@linaro.org,
	dmitry.baryshkov@linaro.org, laetitia.mariottini@se.com,
	pascal.eberhard@se.com, abdou.saker@se.com, jimmy.lalande@se.com,
	benjamin.missey@non.se.com, daniel.thompson@linaro.org,
	linux-kernel@vger.kernel.org,
	Jagdish Gediya <jagdish.gediya@linaro.org>
Subject: Re: [PATCH v4 3/3] arm64: dts: qcom: apq8016: Add Schneider HMIBSC
 board DTS
Message-ID: <ZgRvNxnms9fbz0Hk@gerhold.net>
References: <20240327063734.3236117-1-sumit.garg@linaro.org>
 <20240327063734.3236117-4-sumit.garg@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327063734.3236117-4-sumit.garg@linaro.org>
Content-Transfer-Encoding: 7bit

On Wed, Mar 27, 2024 at 12:07:34PM +0530, Sumit Garg wrote:
> Add Schneider Electric HMIBSC board DTS. The HMIBSC board is an IIoT Edge
> Box Core board based on the Qualcomm APQ8016E SoC.
> 
> Support for Schneider Electric HMIBSC. Features:
> - Qualcomm Snapdragon 410C SoC - APQ8016 (4xCortex A53, Adreno 306)
> - 1GiB RAM
> - 8GiB eMMC, SD slot
> - WiFi and Bluetooth
> - 2x Host, 1x Device USB port
> - HDMI
> - Discrete TPM2 chip over SPI
> - USB ethernet adaptors (soldered)
> 
> Co-developed-by: Jagdish Gediya <jagdish.gediya@linaro.org>
> Signed-off-by: Jagdish Gediya <jagdish.gediya@linaro.org>
> Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>

This looks good to me now. Thanks for making all the changes!

Reviewed-by: Stephan Gerhold <stephan@gerhold.net>

Please drop the tag again in case you send another version with any
larger changes. I'm happy to look at the patch again then. Not sure if
Caleb's R-b is still valid now after all the changes you made.

I found one more nitpick below, but it also exists in apq8016-sbc.dts.
Feel free to leave it as-is, I can fix it up for both sometime later.

Thanks,
Stephan

> ---
>  arch/arm64/boot/dts/qcom/Makefile             |   1 +
>  .../dts/qcom/apq8016-schneider-hmibsc.dts     | 490 ++++++++++++++++++
>  2 files changed, 491 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 39889d5f8e12..ad55e52e950b 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -5,6 +5,7 @@ apq8016-sbc-usb-host-dtbs	:= apq8016-sbc.dtb apq8016-sbc-usb-host.dtbo
>  
>  dtb-$(CONFIG_ARCH_QCOM)	+= apq8016-sbc-usb-host.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= apq8016-sbc-d3-camera-mezzanine.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= apq8016-schneider-hmibsc.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= apq8039-t2.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= apq8094-sony-xperia-kitakami-karin_windy.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-db820c.dtb
> diff --git a/arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dts b/arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dts
> new file mode 100644
> index 000000000000..62ce862ff5c0
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dts
> @@ -0,0 +1,490 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2015, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2024, Linaro Ltd.
> + */
> +
> +/dts-v1/;
> +
> +#include "msm8916-pm8916.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
> +#include <dt-bindings/pinctrl/qcom,pmic-mpp.h>
> +#include <dt-bindings/sound/apq8016-lpass.h>
> +
> +/ {
> +	model = "Schneider Electric HMIBSC Board";
> +	compatible = "schneider,apq8016-hmibsc", "qcom,apq8016";
> +
> +	aliases {
> +		i2c1 = &blsp_i2c6;
> +		i2c3 = &blsp_i2c4;
> +		i2c4 = &blsp_i2c3;
> +		mmc0 = &sdhc_1; /* eMMC */
> +		mmc1 = &sdhc_2; /* SD card */
> +		serial0 = &blsp_uart1;
> +		serial1 = &blsp_uart2;
> +		spi0 = &blsp_spi5;
> +		usid0 = &pm8916_0;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0";
> +	};
> +
> +	hdmi-out {
> +		compatible = "hdmi-connector";
> +		type = "a";
> +
> +		port {
> +			hdmi_con: endpoint {
> +				remote-endpoint = <&adv7533_out>;
> +			};
> +		};
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +		autorepeat;
> +		pinctrl-0 = <&msm_key_volp_n_default>;
> +		pinctrl-names = "default";
> +
> +		button {
> +			label = "Volume Up";
> +			linux,code = <KEY_VOLUMEUP>;
> +			gpios = <&tlmm 107 GPIO_ACTIVE_LOW>;
> +		};
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-0 = <&pm8916_mpps_leds>;
> +		pinctrl-names = "default";
> +
> +		led-1 {
> +			function = LED_FUNCTION_WLAN;
> +			color = <LED_COLOR_ID_YELLOW>;
> +			gpios = <&pm8916_mpps 2 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "phy0tx";
> +			default-state = "off";
> +		};
> +
> +		led-2 {
> +			function = LED_FUNCTION_BLUETOOTH;
> +			color = <LED_COLOR_ID_BLUE>;
> +			gpios = <&pm8916_mpps 3 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "bluetooth-power";
> +			default-state = "off";
> +		};
> +	};
> +
> +	memory@80000000 {
> +		reg = <0 0x80000000 0 0x40000000>;
> +	};
> +
> +	reserved-memory {
> +		ramoops@bff00000 {
> +			compatible = "ramoops";
> +			reg = <0x0 0xbff00000 0x0 0x100000>;
> +			record-size = <0x20000>;
> +			console-size = <0x20000>;
> +			ftrace-size = <0x20000>;
> +			ecc-size = <16>;
> +		};
> +	};
> +
> +	usb-hub {
> +		compatible = "smsc,usb3503";
> +		reset-gpios = <&pm8916_gpios 1 GPIO_ACTIVE_LOW>;
> +		initial-mode = <1>;
> +	};
> +
> +	usb_id: usb-id {
> +		compatible = "linux,extcon-usb-gpio";
> +		id-gpios = <&tlmm 110 GPIO_ACTIVE_HIGH>;
> +		pinctrl-0 = <&usb_id_default>;
> +		pinctrl-names = "default";
> +	};
> +};
> +
> +&blsp_i2c3 {
> +	status = "okay";
> +
> +	eeprom@50 {
> +		compatible = "atmel,24c32";
> +		reg = <0x50>;
> +	};
> +};
> +
> +&blsp_i2c4 {
> +	status = "okay";
> +
> +	adv_bridge: bridge@39 {
> +		compatible = "adi,adv7533";
> +		reg = <0x39>;
> +		interrupts-extended = <&tlmm 31 IRQ_TYPE_EDGE_FALLING>;
> +
> +		adi,dsi-lanes = <4>;
> +		clocks = <&rpmcc RPM_SMD_BB_CLK2>;
> +		clock-names = "cec";
> +		pd-gpios = <&tlmm 32 GPIO_ACTIVE_HIGH>;
> +
> +		avdd-supply = <&pm8916_l6>;
> +		a2vdd-supply = <&pm8916_l6>;
> +		dvdd-supply = <&pm8916_l6>;
> +		pvdd-supply = <&pm8916_l6>;
> +		v1p2-supply = <&pm8916_l6>;
> +		v3p3-supply = <&pm8916_l17>;
> +
> +		pinctrl-0 = <&adv7533_int_active &adv7533_switch_active>;
> +		pinctrl-1 = <&adv7533_int_suspend &adv7533_switch_suspend>;
> +		pinctrl-names = "default","sleep";
> +		#sound-dai-cells = <0>;
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@0 {
> +				reg = <0>;
> +				adv7533_in: endpoint {
> +					remote-endpoint = <&mdss_dsi0_out>;
> +				};
> +			};
> +
> +			port@1 {
> +				reg = <1>;
> +				adv7533_out: endpoint {
> +					remote-endpoint = <&hdmi_con>;
> +				};
> +			};
> +		};
> +	};
> +};
> +
> +&blsp_i2c6 {
> +	status = "okay";
> +
> +	rtc@30 {
> +		compatible = "sii,s35390a";
> +		reg = <0x30>;
> +	};
> +
> +	eeprom@50 {
> +		compatible = "atmel,24c256";
> +		reg = <0x50>;
> +	};
> +};
> +
> +&blsp_spi5 {
> +	cs-gpios = <&tlmm 18 GPIO_ACTIVE_LOW>;
> +	status = "okay";
> +
> +	tpm@0 {
> +		compatible = "infineon,slb9670", "tcg,tpm_tis-spi";
> +		reg = <0>;
> +		spi-max-frequency = <500000>;
> +	};
> +};
> +
> +&blsp_uart1 {
> +	label = "UART0";
> +	status = "okay";
> +};
> +
> +&blsp_uart2 {
> +	label = "UART1";
> +	status = "okay";
> +};
> +
> +&lpass {
> +	status = "okay";
> +};
> +
> +&mdss {
> +	status = "okay";
> +};
> +
> +&mdss_dsi0_out {
> +	data-lanes = <0 1 2 3>;
> +	remote-endpoint = <&adv7533_in>;
> +};
> +
> +&pm8916_codec {
> +	qcom,mbhc-vthreshold-low = <75 150 237 450 500>;
> +	qcom,mbhc-vthreshold-high = <75 150 237 450 500>;
> +	status = "okay";
> +};
> +
> +&pm8916_gpios {
> +	gpio-line-names =
> +		"USB_HUB_RESET_N_PM",
> +		"USB_SW_SEL_PM",
> +		"NC",
> +		"NC";
> +
> +	usb_hub_reset_pm: usb-hub-reset-pm-state {
> +		pins = "gpio1";
> +		function = PMIC_GPIO_FUNC_NORMAL;
> +		input-disable;
> +		output-high;
> +	};
> +
> +	usb_hub_reset_pm_device: usb-hub-reset-pm-device-state {
> +		pins = "gpio1";
> +		function = PMIC_GPIO_FUNC_NORMAL;
> +		output-low;
> +	};
> +

Nitpick: &usb_hub_reset_pm has input-disable (and the two others below),
but this one doesn't.

> +	usb_sw_sel_pm: usb-sw-sel-pm-state {
> +		pins = "gpio2";
> +		function = PMIC_GPIO_FUNC_NORMAL;
> +		power-source = <PM8916_GPIO_VPH>;
> +		input-disable;
> +		output-high;
> +	};
> +
> +	usb_sw_sel_pm_device: usb-sw-sel-pm-device-state {
> +		pins = "gpio2";
> +		function = PMIC_GPIO_FUNC_NORMAL;
> +		power-source = <PM8916_GPIO_VPH>;
> +		input-disable;
> +		output-low;
> +	};
> +};
> +
> +&pm8916_mpps {
> +	gpio-line-names =
> +		"NC",
> +		"WLAN_LED_CTRL",
> +		"BT_LED_CTRL",
> +		"NC";
> +
> +	pm8916_mpps_leds: pm8916-mpps-state {
> +		pins = "mpp2", "mpp3";
> +		function = "digital";
> +		output-low;
> +	};
> +};
> +
> +&pm8916_resin {
> +	linux,code = <KEY_POWER>;
> +	status = "okay";
> +};
> +
> +&pm8916_rpm_regulators {
> +	pm8916_l17: l17 {
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +	};
> +};
> +
> +&sdhc_1 {
> +	status = "okay";
> +};
> +
> +&sdhc_2 {
> +	pinctrl-0 = <&sdc2_default &sdc2_cd_default>;
> +	pinctrl-1 = <&sdc2_sleep &sdc2_cd_default>;
> +	pinctrl-names = "default", "sleep";
> +	cd-gpios = <&tlmm 38 GPIO_ACTIVE_LOW>;
> +	status = "okay";
> +};
> +
> +&sound {
> +	pinctrl-0 = <&cdc_pdm_default &sec_mi2s_default>;
> +	pinctrl-1 = <&cdc_pdm_sleep &sec_mi2s_sleep>;
> +	pinctrl-names = "default", "sleep";
> +	model = "HMIBSC";
> +	audio-routing =
> +		"AMIC2", "MIC BIAS Internal2",
> +		"AMIC3", "MIC BIAS External1";
> +	status = "okay";
> +
> +	quaternary-dai-link {
> +		link-name = "ADV7533";
> +		cpu {
> +			sound-dai = <&lpass MI2S_QUATERNARY>;
> +		};
> +		codec {
> +			sound-dai = <&adv_bridge 0>;
> +		};
> +	};
> +
> +	primary-dai-link {
> +		link-name = "WCD";
> +		cpu {
> +			sound-dai = <&lpass MI2S_PRIMARY>;
> +		};
> +		codec {
> +			sound-dai = <&lpass_codec 0>, <&pm8916_codec 0>;
> +		};
> +	};
> +
> +	tertiary-dai-link {
> +		link-name = "WCD-Capture";
> +		cpu {
> +			sound-dai = <&lpass MI2S_TERTIARY>;
> +		};
> +		codec {
> +			sound-dai = <&lpass_codec 1>, <&pm8916_codec 1>;
> +		};
> +	};
> +};
> +
> +&tlmm {
> +	pinctrl-0 = <&uart1_mux0_rs232_high &uart1_mux1_rs232_low>;
> +	pinctrl-names = "default";
> +
> +	adv7533_int_active: adv533-int-active-state {
> +		pins = "gpio31";
> +		function = "gpio";
> +		drive-strength = <16>;
> +		bias-disable;
> +	};
> +
> +	adv7533_int_suspend: adv7533-int-suspend-state {
> +		pins = "gpio31";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +
> +	adv7533_switch_active: adv7533-switch-active-state {
> +		pins = "gpio32";
> +		function = "gpio";
> +		drive-strength = <16>;
> +		bias-disable;
> +	};
> +
> +	adv7533_switch_suspend: adv7533-switch-suspend-state {
> +		pins = "gpio32";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +
> +	msm_key_volp_n_default: msm-key-volp-n-default-state {
> +		pins = "gpio107";
> +		function = "gpio";
> +		drive-strength = <8>;
> +		bias-pull-up;
> +	};
> +
> +	sdc2_cd_default: sdc2-cd-default-state {
> +		pins = "gpio38";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +
> +	/*
> +	 * UART1 being the debug console supports various modes of
> +	 * operation (RS-232/485/422) controlled via GPIOs configured
> +	 * mux as follows:
> +	 *
> +	 *   gpio100    gpio99    UART mode
> +	 *   0          0         loopback
> +	 *   0          1         RS-232
> +	 *   1          0         RS-485
> +	 *   1          1         RS-422
> +	 *
> +	 * The default mode configured here is RS-232 mode.
> +	 */
> +	uart1_mux0_rs232_high: uart1-mux0-rs232-state {
> +		bootph-all;
> +		pins = "gpio99";
> +		function = "gpio";
> +		drive-strength = <16>;
> +		bias-disable;
> +		output-high;
> +	};
> +
> +	uart1_mux1_rs232_low: uart1-mux1-rs232-state {
> +		bootph-all;
> +		pins = "gpio100";
> +		function = "gpio";
> +		drive-strength = <16>;
> +		bias-disable;
> +		output-low;
> +	};
> +
> +	usb_id_default: usb-id-default-state {
> +		pins = "gpio110";
> +		function = "gpio";
> +		drive-strength = <8>;
> +		bias-pull-up;
> +	};
> +};
> +
> +&usb {
> +	extcon = <&usb_id>, <&usb_id>;
> +	pinctrl-0 = <&usb_sw_sel_pm &usb_hub_reset_pm>;
> +	pinctrl-1 = <&usb_sw_sel_pm_device &usb_hub_reset_pm_device>;
> +	pinctrl-names = "default", "device";
> +	status = "okay";
> +};
> +
> +&usb_hs_phy {
> +	extcon = <&usb_id>;
> +};
> +
> +&wcnss {
> +	firmware-name = "qcom/apq8016/wcnss.mbn";
> +	status = "okay";
> +};
> +
> +&wcnss_ctrl {
> +	firmware-name = "qcom/apq8016/WCNSS_qcom_wlan_nv_sbc.bin";
> +};
> +
> +&wcnss_iris {
> +	compatible = "qcom,wcn3620";
> +};
> +
> +&wcnss_mem {
> +	status = "okay";
> +};
> +
> +/* PINCTRL - additions to nodes defined in msm8916.dtsi */
> +
> +/*
> + * 2mA drive strength is not enough when connecting multiple
> + * I2C devices with different pull up resistors.
> + */
> +&blsp_i2c4_default {
> +	drive-strength = <16>;
> +};
> +
> +&blsp_i2c6_default {
> +	drive-strength = <16>;
> +};
> +
> +&blsp_uart1_default {
> +	bootph-all;
> +};
> +
> +/* Enable CoreSight */
> +&cti0 { status = "okay"; };
> +&cti1 { status = "okay"; };
> +&cti12 { status = "okay"; };
> +&cti13 { status = "okay"; };
> +&cti14 { status = "okay"; };
> +&cti15 { status = "okay"; };
> +&debug0 { status = "okay"; };
> +&debug1 { status = "okay"; };
> +&debug2 { status = "okay"; };
> +&debug3 { status = "okay"; };
> +&etf { status = "okay"; };
> +&etm0 { status = "okay"; };
> +&etm1 { status = "okay"; };
> +&etm2 { status = "okay"; };
> +&etm3 { status = "okay"; };
> +&etr { status = "okay"; };
> +&funnel0 { status = "okay"; };
> +&funnel1 { status = "okay"; };
> +&replicator { status = "okay"; };
> +&stm { status = "okay"; };
> +&tpiu { status = "okay"; };
> -- 
> 2.34.1
> 

