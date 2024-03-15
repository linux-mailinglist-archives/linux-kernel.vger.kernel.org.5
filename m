Return-Path: <linux-kernel+bounces-104560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B76E087CFE2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 16:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9ED81C2294D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 15:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96DBF3D542;
	Fri, 15 Mar 2024 15:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="LkCHgcom";
	dkim=permerror (0-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="7GsN1JIl"
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCCC2E636;
	Fri, 15 Mar 2024 15:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710515581; cv=pass; b=INhSi4dOGdKn9vObR+s5tVs3qa8T3gBLy5zFSALJT4eyiPfzIszJ98vKlIlJpJv1ZX64isED5yw7zDWk3zVmXT+6ZnL/2Lw3eCkIYunR08CEAyi243KSVz+4o6Cnd3BE0uN6/xHXyXDcwatMwi38o4H6NHprXC/02xJW5bEm3YA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710515581; c=relaxed/simple;
	bh=2xtZ3oMXL8llzaxfsyXPK/GV2OQAmJn0lubCdZbXCo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AwMcpZf4PsPwlWrS3IuuhPxsYIqk532xTcAnFxsKmtftR3FBCTRBNjl689iMOryveGz3FJNPGhPXLCm+1zNcd5LDU361KzW3b2KqXgM/bUCZh4CJc5myWd5gc5nJ8wO+nPEURhrTCLJSN2jnCBhyXsb2hYTVXZyn3bkgINvOSbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gerhold.net; spf=none smtp.mailfrom=gerhold.net; dkim=pass (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b=LkCHgcom; dkim=permerror (0-bit key) header.d=gerhold.net header.i=@gerhold.net header.b=7GsN1JIl; arc=pass smtp.client-ip=85.215.255.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gerhold.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=gerhold.net
ARC-Seal: i=1; a=rsa-sha256; t=1710515556; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=rAuubJ24iJBms6GJzjRj9bHwEy4uPmMH/0WCdxSZ1xcUH1DrwzQcyvYyrb+oIQdIEi
    EWVxAuUAucLxDj/wqBk8Zk5pFlcETMSyCcfWjVmyAt1v6DEDLdIfm5DlRisUGakfDi+b
    qaFnczq2F+5r7a900/UOWLhX48TuzGvINwaJprnqyutY3VPB58WNaqEhM9s+q/QH5G+M
    QWREpkM6EWxXyTgqrClc05kDkGOIe9fWvzujt+yuZcuXNrcb/W+eYpaZfivKguQ4w/UZ
    CU2avNxyhMCikNVV1PCnLRsCm7ckjsobwnccNxgV1ixTy1hFmaHxIOu74s29XIjRKEc6
    jslA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1710515556;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=7gG9RbVl8+ZysWkWe9Vj985mTW/JVnLCmf5MU9LIuso=;
    b=g+CdvsQNCb8SV3QY57C0L8SLs6Zk7qA2ND+T+uztxcwOjOjCfISsGN4LuuNUz5f/lG
    bvuvfeXTQPfm5dsTbWawechvA5FTE2bWCCj9F3IcdzGNZgZYyA8r8b2yid4Du3ZOMPd1
    reVTTdSsdD8oyZciM6iyjQWtFau8F5YXbz6bgMgenW/SHkLL9z1ctJl+MX5YgSYeBJzx
    HB2Wc+C/eqPGUKnhScUiXJIDY3qQuymNQPaWIzorDYX/Z7WrzFFjlSkd0bOOXGiiQheG
    roHnjjqdGAUJCJ3GfDEG8v6mV/93rNktFm2cdxQCw8JzdbNMQdkwK46iZJnNflFGkgBx
    ItBQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1710515556;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=7gG9RbVl8+ZysWkWe9Vj985mTW/JVnLCmf5MU9LIuso=;
    b=LkCHgcomTfvwAKDhnWIt2aaSYGL/L2KA2LslkAp25oc9EBFXztHvkGfJx2wVVcKLou
    XhUth5MKm1mRVPd/sex6mRRnVRQdHL+Iqlu4nS8HvKNoenB5yLYJf8ITOKgyAPvRY4oz
    aMRbNj149cRkR2xurC4JIeh3hUNgHr7dCRx9Tcji5al2hHbqOF+LgL7/oCZdm62+Dikn
    88Oyqecfbyw396fubgyWMGNeYWpt7TQNFFoSjhy6BcuKmR4zzjjo1RgfRbmkjMmMcUXt
    BbWZm37XHJCIhAN1AsXtCuSo5gk72MIxTPk5kr2JoGlIsa/Bj7TswSBWiA3Pv57m+fKS
    hV9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1710515556;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=7gG9RbVl8+ZysWkWe9Vj985mTW/JVnLCmf5MU9LIuso=;
    b=7GsN1JIlunGNtt3xVzt0qEBgY6KgepvyyiAB3vM2s3CoHJmHdPRneNISXu0MLyfJSv
    NCqFGmknpzM6rBxXhrDg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4peA95vh"
Received: from gerhold.net
    by smtp.strato.de (RZmta 50.2.2 SBL|AUTH)
    with ESMTPSA id Raa09e02FFCa3Kc
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 15 Mar 2024 16:12:36 +0100 (CET)
Date: Fri, 15 Mar 2024 16:12:34 +0100
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
Subject: Re: [PATCH v3 3/3] arm64: dts: qcom: apq8016: Add Schneider HMIBSC
 board DTS
Message-ID: <ZfRlYnEQUKvwGQ65@gerhold.net>
References: <20240315060707.471248-1-sumit.garg@linaro.org>
 <20240315060707.471248-4-sumit.garg@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240315060707.471248-4-sumit.garg@linaro.org>
Content-Transfer-Encoding: 7bit

On Fri, Mar 15, 2024 at 11:37:07AM +0530, Sumit Garg wrote:
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
> ---
>  arch/arm64/boot/dts/qcom/Makefile             |   1 +
>  .../dts/qcom/apq8016-schneider-hmibsc.dts     | 510 ++++++++++++++++++
>  2 files changed, 511 insertions(+)
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
> index 000000000000..9c79a31a04db
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dts
> @@ -0,0 +1,510 @@
> [...]
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

Nitpick: The &cti0 is in the correct alphabetically ordered place, but
&replicator, &stm and &tpiu are not.

I know you changed this based on the review comments but I personally
think it was clearer having this separated as condensed block towards
the end of the file (where it was before).

The other option would be to put each element individually at the
correctly ordered position in the file. However, having a single "Enable
CoreSight" comment for the entire block would then not work anymore
since all the lines would be interspersed throughout the file.

> [...]
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
> +
> +		input-disable;
> +		output-high;
> +	};
> +
> +	usb_hub_reset_pm_device: usb-hub-reset-pm-device-state {
> +		pins = "gpio1";
> +		function = PMIC_GPIO_FUNC_NORMAL;
> +
> +		output-low;
> +	};
> +
> +	usb_sw_sel_pm: usb-sw-sel-pm-state {
> +		pins = "gpio2";
> +		function = PMIC_GPIO_FUNC_NORMAL;
> +
> +		power-source = <PM8916_GPIO_VPH>;
> +		input-disable;
> +		output-high;
> +	};
> +
> +	usb_sw_sel_pm_device: usb-sw-sel-pm-device-state {
> +		pins = "gpio2";
> +		function = PMIC_GPIO_FUNC_NORMAL;
> +
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
> +
> +		output-low;
> +	};
> +};
> +
> +&pm8916_resin {
> +	interrupts = <0x0 0x8 1 IRQ_TYPE_EDGE_FALLING>;

What is the goal of overriding the interrupt here? It looks like you are
changing the interrupt type from IRQ_TYPE_EDGE_BOTH to FALLING. This
sounds a bit like you want the driver to receive just button release
events (or just press events, not sure about the polarity). I'm not sure
if the driver will handle this correctly.

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
> +
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
> +
> +		drive-strength = <16>;
> +		bias-disable;
> +	};
> +
> +	adv7533_int_suspend: adv7533-int-suspend-state {
> +		pins = "gpio31";
> +		function = "gpio";
> +
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +
> +	adv7533_switch_active: adv7533-switch-active-state {
> +		pins = "gpio32";
> +		function = "gpio";
> +
> +		drive-strength = <16>;
> +		bias-disable;
> +	};
> +
> +	adv7533_switch_suspend: adv7533-switch-suspend-state {
> +		pins = "gpio32";
> +		function = "gpio";
> +
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +
> +	msm_key_volp_n_default: msm-key-volp-n-default-state {
> +		pins = "gpio107";
> +		function = "gpio";
> +
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

Nitpick: It would look a bit cleaner to have the empty lines consistent
in all pinctrl nodes, i.e. either always having an empty line between
function and drive-strength or never. I think Konrad prefers the more
compact version without empty line (sadly I'm not sure if this is
clearly documented anywhere). Same for &pm8916_gpios and mpps.

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

:D

Thanks a lot for making this clear using the table. And also for all the
other cleanup changes!

Stephan

