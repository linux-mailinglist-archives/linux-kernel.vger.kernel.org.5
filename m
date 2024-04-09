Return-Path: <linux-kernel+bounces-137372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 695CC89E122
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EAAE286332
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5DF1155745;
	Tue,  9 Apr 2024 17:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="QgSMa2ET"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505FD15539E
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 17:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712682662; cv=none; b=ebLsg1flhsOVitfnpRhFX85tiiSDpCyCjH3iWseBCyt3MtQmbnve3MijzslV6q5ntntblfDFUNDAdx0DEM9wdgKpFGLPKJ+pm0ik5ntSqsKho2kYC6OeIrmF1DhE8ms0iZRHnMEJg+b+yzDaAyec7244g1usQcjvfvGjUQXBamM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712682662; c=relaxed/simple;
	bh=+L5mMTbyT/KDdPID/fymprOGJF3DPX/04xbi7clNdlE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BZz6wJCzuvSygwtcRgLo9BCNkLTDqDTIyWv+YZFZY1tLUSXxBMfI82Bza+mEdtCSqwGyniRo53jd1IGWb3xpukdFcyhYbF5/Vaxs0haSQYQAP5s5P4W1Q402PzwG4xt4WZKAdBDyopwU5h3A0Z4umM88uBmXHCYQTmq+CRfneeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=QgSMa2ET; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1712682646; x=1715274646;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+L5mMTbyT/KDdPID/fymprOGJF3DPX/04xbi7clNdlE=;
	b=QgSMa2ETPOlv8UFcmsJSfLN/GwueYUAnJvUD9LBtSVhMxu4lAyA0bNiRieyFjfb2
	h/wwY4nhJLkjQ/m8OtVDFD6/t0q0G4He7MduhHAnULU6zmBSct94v4pDaBjBxnxD
	FyPm6R0inIFKDFTrIiLC3+IOeVERrFONdiwfUi+7f9w=;
X-AuditID: ac14000a-fadff7000000290d-93-661576960105
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 7B.1C.10509.69675166; Tue,  9 Apr 2024 19:10:46 +0200 (CEST)
Received: from [172.25.39.28] (172.25.0.11) by Berlix.phytec.de (172.25.0.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 9 Apr 2024
 19:10:45 +0200
Message-ID: <264325a7-015f-4ed4-b027-fb5013e4b6e9@phytec.de>
Date: Tue, 9 Apr 2024 19:10:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: ti: k3-am625-phyboard-lyra-rdk: Add Audio
 Codec
To: Garrett Giordano <ggiordano@phytec.com>, <nm@ti.com>, <vigneshr@ti.com>,
	<kristo@kernel.org>, <robh@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <upstream@lists.phytec.de>
References: <20240404184250.3772829-1-ggiordano@phytec.com>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20240404184250.3772829-1-ggiordano@phytec.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOIsWRmVeSWpSXmKPExsWyRpKBR3damWiawbM3KhZr9p5jsph/5Byr
	xfotv9ksln+ezW7R9+Ihs8Wmx9dYLS7vmsNm8ebHWSaL/3t2sFt0v1O3+H/2A7sDt8emVZ1s
	Hneu7WHz2Lyk3qO/u4XV48/Fd6wex29sZ/L4vEkugD2KyyYlNSezLLVI3y6BK+Psh6fsBbfU
	Kx49+8/awLhVrouRk0NCwETi6ZJNbF2MXBxCAkuYJF7/Wg3l3GGU+HX7BSNIFa+AjcSMndfY
	QGwWARWJphs9TBBxQYmTM5+wgNiiAvIS92/NYO9i5OAQFgiS6FwQCzJHRGAzo8T7/bsZQRxm
	gTZGiScPDzCDFAkJWEucfZAN0sssIC5x68l8sJlsAuoSdzZ8YwWxOYH2Nq44xgJRYyGx+M1B
	dghbXmL72znMILYQkP3i0nIWiG/kJaade80MYYdKbP2ynWkCo/AsJKfOQrJuFpKxs5CMXcDI
	sopRKDczOTu1KDNbryCjsiQ1WS8ldRMjKPJEGLh2MPbN8TjEyMTBeIhRgoNZSYRXWks0TYg3
	JbGyKrUoP76oNCe1+BCjNAeLkjjv6o7gVCGB9MSS1OzU1ILUIpgsEwenVAOj25UzNYUHys9t
	YRP36amwL5ncuMikYL3MtK/8h/IlNzw/tSn3+FGJHL/qXEWHY9W3vhS/Ur6Qf2d3RJSLvHFI
	nMvzcx1qjXMDLqmlCc4613K63PB6jvaXCzlVK+I9Oz6w5/xd1PMltLCi6IjbfJldZ5seSzH8
	SKj9MiFg89/Ke/Mqt99ddnWzEktxRqKhFnNRcSIA1rttgKoCAAA=



Am 04.04.24 um 20:42 schrieb Garrett Giordano:
> The Audio Codec runs over the MCASP (Multichannel Audio Serial Port).
> 
> Add pinmux for the Audio Reference Clock and MCASP2.
> 
> Add DT nodes for Audio Codec, MCASP2, VCC 1v8 and VCC 3v3 regulators.
> 
> Additionally, create a sound node that connects our sound card and the
> MCASP2.
> 
> Signed-off-by: Garrett Giordano <ggiordano@phytec.com>


Reviewed-by: Wadim Egorov <w.egorov@phytec.de>


> ---
>   .../dts/ti/k3-am625-phyboard-lyra-rdk.dts     | 99 +++++++++++++++++++
>   1 file changed, 99 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts b/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts
> index a83a90497857..dfc78995d30a 100644
> --- a/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts
> @@ -66,6 +66,35 @@ key-menu {
>   		};
>   	};
>   
> +	sound {
> +		compatible = "simple-audio-card";
> +		simple-audio-card,name = "phyBOARD-Lyra";
> +		simple-audio-card,widgets =
> +			"Microphone",           "Mic Jack",
> +			"Headphone",            "Headphone Jack",
> +			"Speaker",              "External Speaker";
> +		simple-audio-card,routing =
> +			"MIC3R",                "Mic Jack",
> +			"Mic Jack",             "Mic Bias",
> +			"Headphone Jack",       "HPLOUT",
> +			"Headphone Jack",       "HPROUT",
> +			"External Speaker",     "SPOP",
> +			"External Speaker",     "SPOM";
> +		simple-audio-card,format = "dsp_b";
> +		simple-audio-card,bitclock-master = <&sound_master>;
> +		simple-audio-card,frame-master = <&sound_master>;
> +		simple-audio-card,bitclock-inversion;
> +
> +		simple-audio-card,cpu {
> +			sound-dai = <&mcasp2>;
> +		};
> +
> +		sound_master: simple-audio-card,codec {
> +				sound-dai = <&audio_codec>;
> +				clocks = <&audio_refclk1>;
> +		};
> +	};
> +
>   	leds {
>   		compatible = "gpio-leds";
>   		pinctrl-names = "default";
> @@ -82,6 +111,15 @@ led-2 {
>   		};
>   	};
>   
> +	vcc_1v8: regulator-vcc-1v8 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VCC_1V8";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
>   	vcc_3v3_mmc: regulator-vcc-3v3-mmc {
>   		compatible = "regulator-fixed";
>   		regulator-name = "VCC_3V3_MMC";
> @@ -90,9 +128,24 @@ vcc_3v3_mmc: regulator-vcc-3v3-mmc {
>   		regulator-always-on;
>   		regulator-boot-on;
>   	};
> +
> +	vcc_3v3_sw: regulator-vcc-3v3-sw {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VCC_3V3_SW";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
>   };
>   
>   &main_pmx0 {
> +	audio_ext_refclk1_pins_default: audio-ext-refclk1-default-pins {
> +		pinctrl-single,pins = <
> +			AM62X_IOPAD(0x0a0, PIN_OUTPUT, 1) /* (K25) GPMC0_WPn.AUDIO_EXT_REFCLK1 */
> +		>;
> +	};
> +
>   	gpio_keys_pins_default: gpio-keys-default-pins {
>   		pinctrl-single,pins = <
>   			AM62X_IOPAD(0x1d4, PIN_INPUT, 7) /* (B15) UART0_RTSn.GPIO1_23 */
> @@ -150,6 +203,15 @@ AM62X_IOPAD(0x1d8, PIN_OUTPUT, 0) /* (C15) MCAN0_TX */
>   		>;
>   	};
>   
> +	main_mcasp2_pins_default: main-mcasp2-default-pins {
> +		pinctrl-single,pins = <
> +			AM62X_IOPAD(0x070, PIN_INPUT, 3) /* (T24) GPMC0_AD13.MCASP2_ACLKX */
> +			AM62X_IOPAD(0x06c, PIN_INPUT, 3) /* (T22) GPMC0_AD12.MCASP2_AFSX */
> +			AM62X_IOPAD(0x064, PIN_OUTPUT, 3) /* (T25) GPMC0_AD10.MCASP2_AXR2 */
> +			AM62X_IOPAD(0x068, PIN_INPUT, 3) /* (R21) GPMC0_AD11.MCASP2_AXR3 */
> +		>;
> +	};
> +
>   	main_mmc1_pins_default: main-mmc1-default-pins {
>   		pinctrl-single,pins = <
>   			AM62X_IOPAD(0x23c, PIN_INPUT_PULLUP, 0) /* (A21) MMC1_CMD */
> @@ -254,6 +316,21 @@ &main_i2c1 {
>   	clock-frequency = <100000>;
>   	status = "okay";
>   
> +	audio_codec: audio-codec@18 {
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&audio_ext_refclk1_pins_default>;
> +
> +		#sound-dai-cells = <0>;
> +		compatible = "ti,tlv320aic3007";
> +		reg = <0x18>;
> +		ai3x-micbias-vg = <2>;
> +
> +		AVDD-supply = <&vcc_3v3_sw>;
> +		IOVDD-supply = <&vcc_3v3_sw>;
> +		DRVDD-supply = <&vcc_3v3_sw>;
> +		DVDD-supply = <&vcc_1v8>;
> +	};
> +
>   	gpio_exp: gpio-expander@21 {
>   		pinctrl-names = "default";
>   		pinctrl-0 = <&gpio_exp_int_pins_default>;
> @@ -329,6 +406,28 @@ &main_uart1 {
>   	status = "okay";
>   };
>   
> +&mcasp2 {
> +	status = "okay";
> +	#sound-dai-cells = <0>;
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_mcasp2_pins_default>;
> +
> +	/* MCASP_IIS_MODE */
> +	op-mode = <0>;
> +	tdm-slots = <2>;
> +
> +	/* 0: INACTIVE, 1: TX, 2: RX */
> +	serial-dir = <
> +			0 0 1 2
> +			0 0 0 0
> +			0 0 0 0
> +			0 0 0 0
> +	>;
> +	tx-num-evt = <32>;
> +	rx-num-evt = <32>;
> +};
> +
>   &sdhci1 {
>   	vmmc-supply = <&vcc_3v3_mmc>;
>   	vqmmc-supply = <&vddshv5_sdio>;

