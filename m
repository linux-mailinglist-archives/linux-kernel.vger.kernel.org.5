Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37E1A759C37
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 19:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbjGSRQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 13:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjGSRQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 13:16:39 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55623C0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 10:16:38 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fbc59de0e2so66927005e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 10:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689786997; x=1692378997;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ybISWav3uKy7VIWk3iKq8VXBblL6KWqHlRrTQ84GjYo=;
        b=weVjkaAafKj8iW1xUVn8B6rfoXSkQNb/lZVViQdZ/exK1lVgqfp5WU5eZLADlShPY5
         TQvwqS1jFWRIQyp46Cz7WV6V4Dw8NTEsJKecQPDchXs0oiXJahcavLfChGKyCf5Ck1Cm
         Ak3EYtUy591o5GjPYV7+l/ZeBQ3SzmBXrWViZi9J/mlH5SITPpyg/ivujwraPMCtc9J5
         upBMB3BEU2FNip4+Iib3fKAud0gv7D436k8VNnnPG5APKfzpPZCNgydUIBQavYhbswCi
         DEbGJobjAC9ZXDpfG9ZBdyXiOrm86VjmaHXwjZ5HwNIwxOtKgG7N8Nq5li+p+EedBiym
         6HpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689786997; x=1692378997;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ybISWav3uKy7VIWk3iKq8VXBblL6KWqHlRrTQ84GjYo=;
        b=NRddBClD2rKBUHHSbMWznPL9r2H0rNxaIebtq7XZRAuQcMuABJawrqFBeWUHOiCjcW
         02GkhREpNdPk1LzyMqByE1nkLhYJKggHy74ZkFaz05s0NiWDfeEZLGyMNsxhI3GzaWS/
         TspEtJASoPCmhMb3wEO0JOedMw6L9YURdkDQBNNO5sN8diBgDxuOfVGDCa1Lsr7zJEf0
         8GiyE4vW0JwpInPaK2aUcdO4LejkgbcwM76r25Mvq8W04yNImmmUMu74I+4Ii4IoVCGU
         +CFEmoA/nQILkW2mXYDmaR3OXXuCJVqV5tJ1FmWBxNrDkJBiwoCzzdqyi+Wu6cXV81Cw
         7NAg==
X-Gm-Message-State: ABy/qLZ/53jV8z7oCnuWDqDU2XCW05M7ow04mrMP4BZJGK37VxxVQ2Ry
        DWZA8Vf7O4CJvY9RfoZ0mOoxOQ==
X-Google-Smtp-Source: APBJJlGR2HgZowurHQl1hsV9N9y4VLevgnkAp270asZF+AiazYJ2AaXGGZD4EVG2X4IvDQ5DjHmc8A==
X-Received: by 2002:a05:600c:2285:b0:3fb:b8a6:33f9 with SMTP id 5-20020a05600c228500b003fbb8a633f9mr4717360wmf.0.1689786996700;
        Wed, 19 Jul 2023 10:16:36 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id i12-20020adffdcc000000b003142e438e8csm5805570wrs.26.2023.07.19.10.16.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 10:16:36 -0700 (PDT)
Message-ID: <03748443-0459-c925-ce76-33ec134a303d@linaro.org>
Date:   Wed, 19 Jul 2023 19:16:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] ARM: dts: imx6qdl: Add Variscite VAR-SOM-MX6 SoM
 support
Content-Language: en-US
To:     James Hilliard <james.hilliard1@gmail.com>,
        devicetree@vger.kernel.org
Cc:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230719160048.2737423-1-james.hilliard1@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230719160048.2737423-1-james.hilliard1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/07/2023 18:00, James Hilliard wrote:
> This patch adds support for the Variscite VAR_SOM-MX6 SoM with :
> - i.MX6 Quad or Dual Lite SoC
> - 256 – 4096 MB DDR3
> - 4-64 GB eMMC
> - 128 – 1024 MB SLC NAND
> - Camera Interface
> - HDMI+CEC interface
> - LVDS / DSI / Parallel RGB interfaces
> - Ethernet RGMII interface
> - On-SoM Wi-Fi/Bluetooth with WiLink wl183x SDIO Module
> - SD/MMC/SDIO interface
> - USB Host + USB OTG interface
> - I2C interfaces
> - SPI interfaces
> - PCI-Express 2.0 interface
> - on-SoM Audio Codec with HP/Line-In interfaces + DMIC interface
> - Digital Audio interface
> - S/PDIF interface
> 
> Product website : https://www.variscite.com/product/system-on-module-som/cortex-a9/var-som-mx6-cpu-freescale-imx6/
> 
> Support is handled with a SoM-centric dtsi exporting the default interfaces
> along the default pinmuxing to be enabled by the board dts file.
> 
> This file is based on the one provided by Variscite on their own
> kernel, but adapted for mainline.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
>  arch/arm/boot/dts/imx6qdl-var-som.dtsi | 547 +++++++++++++++++++++++++
>  1 file changed, 547 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx6qdl-var-som.dtsi
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-var-som.dtsi b/arch/arm/boot/dts/imx6qdl-var-som.dtsi
> new file mode 100644
> index 000000000000..e93dae59624e
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6qdl-var-som.dtsi
> @@ -0,0 +1,547 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Support for Variscite VAR-SOM-MX6 Module
> + *
> + * Copyright 2011 Linaro Ltd.
> + * Copyright 2012 Freescale Semiconductor, Inc.
> + * Copyright (C) 2014-2016 Variscite, Ltd.
> + * Author: Donio Ron <ron.d@variscite.com>
> + * Copyright 2022 Bootlin
> + */
> +
> +/dts-v1/;
> +
> +#include "imx6q.dtsi"
> +#include <dt-bindings/clock/imx6qdl-clock.h>
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/sound/fsl-imx-audmux.h>
> +
> +/ {
> +	model = "Variscite i.MX6 QUAD/DUAL VAR-SOM-MX6";
> +	compatible = "fsl,imx6q";

That's not correct compatible. It's not Imx6 soc. It's a som.

> +...
> +
> +	sound: sound {
> +		compatible = "simple-audio-card";
> +		simple-audio-card,name = "var-som-audio";
> +		simple-audio-card,format = "i2s";
> +		simple-audio-card,bitclock-master = <&sound_codec>;
> +		simple-audio-card,frame-master = <&sound_codec>;
> +		simple-audio-card,widgets = "Headphone", "Headphone Jack",
> +					    "Line", "Line In", "Microphone", "Mic Jack";
> +		simple-audio-card,routing = "Headphone Jack", "HPLOUT",
> +					    "Headphone Jack", "HPROUT",
> +					    "LINE1L", "Line In",
> +					    "LINE1R", "Line In";
> +
> +		sound_cpu: simple-audio-card,cpu {
> +			sound-dai = <&ssi2>;
> +		};
> +
> +		sound_codec: simple-audio-card,codec {
> +			sound-dai = <&tlv320aic3106>;
> +			clocks = <&clks IMX6QDL_CLK_CKO>;
> +		};
> +	};
> +
> +	wlan_bt_rfkill {

No underscores in node names.

Just "rfkill"


> +		compatible = "rfkill-gpio";
> +		name = "wlan_bt_rfkill";
> +		type = <2>;     /* bluetooth */
> +		gpios = <&gpio6 18 GPIO_ACTIVE_HIGH>;
> +	};
> +};
> +

...

> +	tlv320aic3106: codec@1b {
> +		compatible = "ti,tlv320aic3106";
> +		reg = <0x1b>;
> +		#sound-dai-cells = <0>;
> +		DRVDD-supply = <&reg_3p3v>;
> +		AVDD-supply = <&reg_3p3v>;
> +		IOVDD-supply = <&reg_3p3v>;
> +		DVDD-supply = <&reg_3p3v>;
> +		ai3x-ocmv = <0>;
> +		reset-gpios = <&gpio4 5 GPIO_ACTIVE_LOW>;
> +		ai3x-gpio-func = <
> +			0 /* AIC3X_GPIO1_FUNC_DISABLED */
> +			5 /* AIC3X_GPIO2_FUNC_DIGITAL_MIC_INPUT */
> +		>;
> +	};
> +};
> +
> +&iomuxc {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_hog>;
> +
> +	imx6qdl-var-som-mx6 {
> +		pinctrl_hog: hoggrp {
> +			fsl,pins = <
> +				/* CTW6120 IRQ */
> +				MX6QDL_PAD_EIM_DA7__GPIO3_IO07		0x80000000
> +				/* SDMMC2 CD/WP */
> +				MX6QDL_PAD_KEY_COL4__GPIO4_IO14		0x80000000
> +				MX6QDL_PAD_KEY_ROW4__GPIO4_IO15		0x80000000
> +			>;
> +		};
> +
> +		pinctrl_audmux: audmux {

It does not look like you tested the DTS against bindings. Please run
`make dtbs_check` (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
for instructions).

AFAIR, all of them end with grp


...

> +
> +&usdhc3 {
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
> +	pinctrl-0 = <&pinctrl_usdhc3>;
> +	pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
> +	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
> +	bus-width = <4>;
> +	vmmc-supply = <&reg_wl18xx_vmmc>;
> +	non-removable;
> +	wakeup-source;
> +	keep-power-in-suspend;
> +	cap-power-off-card;
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	status = "okay";
> +
> +	wlcore: wlcore@0 {

Generic node names. Is this wifi?

https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +		compatible = "ti,wl1835";
> +		reg = <2>;


Best regards,
Krzysztof

