Return-Path: <linux-kernel+bounces-10461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B82BE81D4A8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 15:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F729B20EC6
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 14:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DDA2DDB7;
	Sat, 23 Dec 2023 14:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K7NYeIhb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8779DDF4D
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 14:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-552d39ac3ccso6724971a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 06:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703342348; x=1703947148; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zCFoTy8y9ZvynGpG2Rm82yYymV07j6rSfFwhnk7b108=;
        b=K7NYeIhbS/kMAj0XH9nk3TlJsoX3iDWf4Hqd2RRsT8MO8zPLzPUms1pQXBuizga7I0
         PW+o90QVdbbD+8kFwOe99OWjOfGQklBxMKmQ1iQHH4cDOtbjQ53YpKA80d727vf/6Ve+
         znvJSEfcTIbNAIagxLilpLsZPyOXWrlKNCIDS0pwBw5kxDqOKUb1lLQzKzZ34kVIrA5Z
         ejRhSgwXBpgikEwHoM3zIR6Te1Lq0Dblo2dtE2HuneoDSqdv37Jt4MJP4mE6M1lzrWAR
         /jKqy/cTJdvbHFi5CwCAL9E2LmMXcNKtntwKUX5ME32Bmu5Wl5e52SvNl8PfTscFDt7Z
         l8DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703342348; x=1703947148;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zCFoTy8y9ZvynGpG2Rm82yYymV07j6rSfFwhnk7b108=;
        b=PVgCisw23U7N0gP1moipcSR0wu5okrOrlpi/LI/iG9MUgQS2HuhSxkofUAC0PpTKwu
         OLwEjRPEfDM8S9IMnG+zcJyn0OSd7gbfUCRp9tGJXKwBVQiguWNwtfTthInRP2kgsF51
         1FzDLWWV71iT/Moi7axIiFlq6ewUHTxj9FPwFM5klqNjhV13e3F4sX+dc02fZdc6nWlL
         kmucfDfzM97kSpBfcznKhccZlhoMvWCiEpHv5/f2h04v2xNqxCfVCaA9o7APoOjSTVK1
         hjWUbO9+xGPDAMUAY/Fa3uGxsNG2ewLo0+CiJTFThJl4dHz17+Zru7Ho3n8yFX1MheTi
         ekmg==
X-Gm-Message-State: AOJu0YwVnchnngePOJsyxbm46WXoPRuEE3Iu6YcFGV2DQ2h0/kN92t4D
	yuZUqp9F7Ml2R2uZkm4KRpBak9GaWQ3Tkw==
X-Google-Smtp-Source: AGHT+IHCOJVGXwGzw8ftpJlaNeBCBVPMx+yETQcRsrpdo1Nh8jmbEo1joQpcHbN3VM3nUMG0AuuKUQ==
X-Received: by 2002:a17:906:d5:b0:a26:bdae:c594 with SMTP id 21-20020a17090600d500b00a26bdaec594mr2221091eji.37.1703342347704;
        Sat, 23 Dec 2023 06:39:07 -0800 (PST)
Received: from [192.168.0.22] ([78.10.206.178])
        by smtp.gmail.com with ESMTPSA id ex19-20020a170907955300b00a268002274csm3127217ejc.52.2023.12.23.06.39.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Dec 2023 06:39:07 -0800 (PST)
Message-ID: <3ad14d62-df64-45b1-9be4-008d30d2b52f@linaro.org>
Date: Sat, 23 Dec 2023 15:39:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: imx93-var-som: Add Variscite VAR-SOM-MX93
Content-Language: en-US
To: Mathieu Othacehe <othacehe@gnu.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20231223142939.23735-1-othacehe@gnu.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231223142939.23735-1-othacehe@gnu.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/12/2023 15:29, Mathieu Othacehe wrote:
> Add DTSI for Variscite VAR-SOM-MX93 System on Module and DTS for Variscite
> VAR-SOM-MX93 on Symphony evaluation board.
> 
> This version comes with:
> - NXP i.MX 93 Dual, 1.7GHz, Cortex-A55 + Cortex-M33
> - 2 GB of RAM
> - 16GB eMMC
> - 802.11ax/ac/a/b/g/n WiFi with 5.3 Bluetooth
> - CAN bus
> - Audio codec
> 
> Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>
> ---
>  arch/arm64/boot/dts/freescale/Makefile        |   1 +
>  .../dts/freescale/imx93-var-som-symphony.dts  | 307 +++++++++++++++++
>  .../boot/dts/freescale/imx93-var-som.dtsi     | 312 ++++++++++++++++++
>  3 files changed, 620 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx93-var-som-symphony.dts
>  create mode 100644 arch/arm64/boot/dts/freescale/imx93-var-som.dtsi
> 
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index 2e027675d7bb..a6f1700961e3 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -203,6 +203,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8ulp-evk.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx93-11x11-evk.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxca.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxla.dtb
> +dtb-$(CONFIG_ARCH_MXC) += imx93-var-som-symphony.dtb
>  
>  imx8mm-venice-gw72xx-0x-imx219-dtbs	:= imx8mm-venice-gw72xx-0x.dtb imx8mm-venice-gw72xx-0x-imx219.dtbo
>  imx8mm-venice-gw72xx-0x-rpidsi-dtbs	:= imx8mm-venice-gw72xx-0x.dtb imx8mm-venice-gw72xx-0x-rpidsi.dtbo
> diff --git a/arch/arm64/boot/dts/freescale/imx93-var-som-symphony.dts b/arch/arm64/boot/dts/freescale/imx93-var-som-symphony.dts
> new file mode 100644
> index 000000000000..85b1355cf805
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx93-var-som-symphony.dts
> @@ -0,0 +1,307 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright 2021 NXP
> + * Copyright 2023 Variscite Ltd.
> + */
> +
> +/dts-v1/;
> +
> +#include "imx93-var-som.dtsi"
> +
> +/{
> +	model = "Variscite VAR-SOM-MX93 on Symphony evaluation board";
> +	compatible = "variscite,var-som-imx93-symphony", "variscite,var-som-mx93", "fsl,imx93";

Please run scripts/checkpatch.pl and fix reported warnings. Some
warnings can be ignored, but the code here looks like it needs a fix.
Feel free to get in touch if the warning is not clear.

Also, wrap it at 80.

> +
> +	aliases {
> +		ethernet1 = &fec;
> +	};
> +
> +	chosen {
> +		stdout-path = &lpuart1;
> +	};
> +
> +	/*
> +	 * Needed only for Symphony <= v1.5
> +	 */
> +	reg_fec_phy: regulator-fec-phy {
> +		compatible = "regulator-fixed";
> +		regulator-name = "fec-phy";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		regulator-enable-ramp-delay = <20000>;
> +		gpio = <&pca9534 7 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		regulator-always-on;
> +	};
> +
> +	reg_usdhc2_vmmc: regulator-usdhc2 {
> +		compatible = "regulator-fixed";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_reg_usdhc2_vmmc>;
> +		regulator-name = "VSD_3V3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpio = <&gpio2 18 GPIO_ACTIVE_HIGH>;
> +		off-on-delay-us = <20000>;
> +		enable-active-high;
> +	};
> +
> +	reg_vref_1v8: regulator-adc-vref {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vref_1v8";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		ethosu_mem: ethosu_region@88000000 {

No underscores in node names.

Please do not upstream downstream DTS, but fix it to match proper Linux
coding style.

...


> +	pinctrl_lpi2c1: lpi2c1grp {
> +		fsl,pins = <
> +			MX93_PAD_I2C1_SCL__LPI2C1_SCL			0x40000b9e
> +			MX93_PAD_I2C1_SDA__LPI2C1_SDA			0x40000b9e
> +		>;
> +	};
> +
> +	pinctrl_lpi2c1_gpio: lpi2c1grp-gpio {

It does not look like you tested the DTS against bindings. Please run
`make dtbs_check W=1` (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
for instructions).


...

> +
> +&lpi2c1 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	clock-frequency = <400000>;
> +	pinctrl-names = "default", "sleep", "gpio";
> +	pinctrl-0 = <&pinctrl_lpi2c1>;
> +	pinctrl-1 = <&pinctrl_lpi2c1_gpio>;
> +	pinctrl-2 = <&pinctrl_lpi2c1_gpio>;
> +	scl-gpios = <&gpio1 0 GPIO_ACTIVE_HIGH>;
> +	sda-gpios = <&gpio1 1 GPIO_ACTIVE_HIGH>;
> +	status = "okay";
> +
> +	/* DS1337 RTC module */
> +	rtc@68 {
> +		status = "okay";

Drop. It is never the first property, BTW.

> +		compatible = "dallas,ds1337";
> +		reg = <0x68>;
> +	};
> +};
> +
> +&lpi2c5 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	clock-frequency = <400000>;
> +	pinctrl-names = "default", "sleep", "gpio";
> +	pinctrl-0 = <&pinctrl_lpi2c5>;
> +	pinctrl-1 = <&pinctrl_lpi2c5_gpio>;
> +	pinctrl-2 = <&pinctrl_lpi2c5_gpio>;
> +	scl-gpios = <&gpio2 23 GPIO_ACTIVE_HIGH>;
> +	sda-gpios = <&gpio2 22 GPIO_ACTIVE_HIGH>;
> +	status = "okay";
> +
> +	pca9534: gpio@20 {
> +		status = "okay";

Drop.

> +		compatible = "nxp,pca9534";
> +		reg = <0x20>;
> +		gpio-controller;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_pca9534>;
> +		interrupt-parent = <&gpio3>;
> +		interrupts = <26 IRQ_TYPE_EDGE_FALLING>;
> +		#gpio-cells = <2>;
> +		wakeup-source;
> +	};
> +};

...

> diff --git a/arch/arm64/boot/dts/freescale/imx93-var-som.dtsi b/arch/arm64/boot/dts/freescale/imx93-var-som.dtsi
> new file mode 100644
> index 000000000000..30b969d0134d
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx93-var-som.dtsi
> @@ -0,0 +1,312 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright 2022 NXP
> + * Copyright 2023 Variscite Ltd.
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/usb/pd.h>
> +#include "imx93.dtsi"
> +
> +/{
> +	model = "Variscite VAR-SOM-MX93 module";
> +	compatible = "variscite,var-som-imx93", "fsl,imx93";

Please run scripts/checkpatch.pl and fix reported warnings. Some
warnings can be ignored, but the code here looks like it needs a fix.
Feel free to get in touch if the warning is not clear.

> +
> +	iw612_pwrseq: iw612_pwrseq {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


> +		compatible = "mmc-pwrseq-simple";
> +		post-power-on-delay-ms = <100>;
> +		power-off-delay-us = <10000>;
> +		reset-gpios = <&gpio4 14 GPIO_ACTIVE_LOW>,	/* WIFI_RESET */
> +			      <&gpio3 7 GPIO_ACTIVE_LOW>;	/* WIFI_PWR_EN */
> +		status = "okay";

Drop

....

> +	pinctrl_lpi2c3: lpi2c3grp {
> +		fsl,pins = <
> +			MX93_PAD_GPIO_IO28__LPI2C3_SDA			0x40000b9e
> +			MX93_PAD_GPIO_IO29__LPI2C3_SCL			0x40000b9e
> +		>;
> +	};
> +
> +	pinctrl_lpi2c3_gpio: lpi2c3grp-gpio {

It does not look like you tested the DTS against bindings. Please run
`make dtbs_check W=1` (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
for instructions).

...

> +
> +&lpi2c3 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	clock-frequency = <400000>;
> +	pinctrl-names = "default", "sleep", "gpio";
> +	pinctrl-0 = <&pinctrl_lpi2c3>;
> +	pinctrl-1 = <&pinctrl_lpi2c3_gpio>;
> +	pinctrl-2 = <&pinctrl_lpi2c3_gpio>;
> +	scl-gpios = <&gpio2 29 GPIO_ACTIVE_HIGH>;
> +	sda-gpios = <&gpio2 28 GPIO_ACTIVE_HIGH>;
> +	status = "okay";
> +
> +	pmic@25 {
> +		compatible = "nxp,pca9451a";

Please run scripts/checkpatch.pl and fix reported warnings. Some
warnings can be ignored, but the code here looks like it needs a fix.
Feel free to get in touch if the warning is not clear.

I don't see this compatible documented and cover letter or changelog
does not mention neither dependencies nor other series bringing it.

> +		reg = <0x25>;
> +
> +		regulators {
> +			buck1: BUCK1 {

Lowercase

> +				regulator-name = "BUCK1";
> +				regulator-min-microvolt = <650000>;
> +				regulator-max-microvolt = <2237500>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +				regulator-ramp-delay = <3125>;
> +			};
> +
> +			buck2: BUCK2 {

Lowercase, further as well

...

Best regards,
Krzysztof


