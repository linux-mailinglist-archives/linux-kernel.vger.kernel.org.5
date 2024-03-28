Return-Path: <linux-kernel+bounces-123234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24AEE8904DF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 480571C2F5CD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F4E131183;
	Thu, 28 Mar 2024 16:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T7fDezgi"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8200E8173C
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 16:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711642795; cv=none; b=S/8StjgI9gPmoyYJT0QHBHQsmwqesVlwmyVfcj0P7GR63tY76GAcqPpX6XwA0pKzqEGsiRMEYL9dl6nrbWBS1Pc8UbKoSMYLMURRHjJlLGbMTsW/IZ7uqzsA/kS3gqk+h9F9PujSEgQyAleHspySengfmE9/OAisqi8h/zbLTHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711642795; c=relaxed/simple;
	bh=m7myC/SYP+kTV0h8G6w/dCsON2QETfkjfB7eCc9epTM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q5wPVaMqNlWHsM0Ytc60+MCniOy1ccfUPozrGkbTuQSj6l1RPstzGzva6n4+cZ5l/4SSW1EDirnczbboHKfpqqiL6MoXRfhRrCX+oNPRMCT/JV5oRqz8Q6PYawgGIhIgNlNtnxYPEZGmP1HGB+mu4eGNcmWgR9b7nOV5R9thYBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T7fDezgi; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3416df43cabso791414f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 09:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711642792; x=1712247592; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=G2u+U9wqSirUY12k+S7Qg17vyc8DYGQIfxsE9hdd9FA=;
        b=T7fDezgitoFuD4osR2RQdP6xIDzeVLnuy0xsgefs7aWQq26/H3qNLK+ECufsxrI/jm
         dpxXzscd7XVHrncnC1Rp3gTnnSlePP5jfrzuQ9PqrZpEJfGlFrwmmbNwal72LEvPIhp2
         +3BwkA8S3Bv+IvV3qee099qWft8BmIVczfFdWA8pLTcTNygYcZuC5EQvT4CqPSODnaO0
         I6TS58FKQaU8cPku56V10AMVifZGuYPbPWWDTUqrpfRr81sL0T8wPqGq2tTudvEYqg71
         Ic1Zhi1GCIV2TtHE/Vh4TQAM07Ce4eGJ+Hd8jONRC2vQWk2RPo5DvqJoulHXRG9U9/ar
         uBuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711642792; x=1712247592;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G2u+U9wqSirUY12k+S7Qg17vyc8DYGQIfxsE9hdd9FA=;
        b=c/CqbQrRLpcZ3zlZqAceHfUTsMaxTzI/iaO3802GB55mCynd0nTp2SiLwdgYbrAsDK
         7ma9zi8hqemjCQZGOi+jEcbPh+i+bxkuXwDBtc8h6DTjQm0cbnUQzEYZBgII0BDKAqrE
         ZTCrCcOYYiPPY2GVkrcB0mOTTBOyJAk/A4HmoWeyrBjBdfPyon5VY8rmOlHdAfwu2hUK
         1ANZshzhXoF8sZpYI3bg0MLyqJfVEeDHtO3M4l8q4tYhpMbz6jq3FNsNgXuIxgBO5nvc
         NFfQ2P24pfzf/oEK2IbJvaxXHj0u0wWiWKTZaHX8lTjcfUgag128GHD65EUsNmNSVoRW
         sN+g==
X-Forwarded-Encrypted: i=1; AJvYcCUUaj3NCSA6AKPUNHGiWXTYq+/sll0xDRvr3lhPCnGPV6hnG90zKTJ2+6zBzJiF84EPNEsxOvKvxvzmAqC4hQkf42rkYbeBR7VRymZ9
X-Gm-Message-State: AOJu0YyPqYbRoLlEz8EPOc/1d099f2MI0WX+Jta2NiFMD2ok9Rns+PVd
	/R++hUH9b0iGVAeCOqND7TIrZ5fRMCfUdUJPq+1YojfzDXYz2qjEw/m1qaCFLTM=
X-Google-Smtp-Source: AGHT+IHD9UhA3UlcvW9LOFeUE/4Vo7+h90D+iwCtJmsM1IgOO4wkyxdRad3YygXO6wcUTbPpWIvKuA==
X-Received: by 2002:adf:cc87:0:b0:341:a6d9:841 with SMTP id p7-20020adfcc87000000b00341a6d90841mr2433278wrj.0.1711642791744;
        Thu, 28 Mar 2024 09:19:51 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.50])
        by smtp.gmail.com with ESMTPSA id g4-20020a5d4884000000b0033e7603987dsm2128964wrq.12.2024.03.28.09.19.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 09:19:51 -0700 (PDT)
Message-ID: <3c4e63af-1b03-460f-8dc1-24d80b39f054@linaro.org>
Date: Thu, 28 Mar 2024 17:19:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: Add support for Samsung Galaxy Z Fold5
To: serdeliuk@yahoo.com, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240328-arm64-dts-add-support-for-samsung-galaxy-zfold5-v1-1-9434150d0465@yahoo.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240328-arm64-dts-add-support-for-samsung-galaxy-zfold5-v1-1-9434150d0465@yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/03/2024 15:57, Alexandru Marc Serdeliuc via B4 Relay wrote:
> From: Alexandru Marc Serdeliuc <serdeliuk@yahoo.com>
> 
> Add support for Samsung Galaxy Z Fold5 (q5q) foldable phone
> 
> Currently working features:
> - Framebuffer
> - UFS
> - i2c
> - Buttons
> 
> Signed-off-by: Alexandru Marc Serdeliuc <serdeliuk@yahoo.com>
> ---
>  arch/arm64/boot/dts/qcom/Makefile               |   1 +
>  arch/arm64/boot/dts/qcom/sm8550-samsung-q5q.dts | 616 ++++++++++++++++++++++++
>  2 files changed, 617 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 7d40ec5e7d21..a7503fd35b6c 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -241,6 +241,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sm8450-sony-xperia-nagara-pdx224.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm8550-hdk.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm8550-mtp.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm8550-qrd.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= sm8550-samsung-q5q.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm8650-mtp.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm8650-qrd.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= x1e80100-crd.dtb
> diff --git a/arch/arm64/boot/dts/qcom/sm8550-samsung-q5q.dts b/arch/arm64/boot/dts/qcom/sm8550-samsung-q5q.dts
> new file mode 100644
> index 000000000000..ac8392022a7f
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sm8550-samsung-q5q.dts
> @@ -0,0 +1,616 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2024, Alexandru Marc Serdeliuc <serdeliuk@yahoo.com>
> + * Copyright (c) 2024, David Wronek <david@mainlining.org>
> + * Copyright (c) 2022, Linaro Limited
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> +#include "sm8550.dtsi"
> +#include "pm8550.dtsi"
> +#include "pm8550vs.dtsi"
> +#include "pmk8550.dtsi"
> +
> +/ {
> +	model = "Samsung Galaxy Z Fold5";
> +	compatible = "samsung,q5q", "qcom,sm8550";
> +	#address-cells = <0x02>;
> +	#size-cells = <0x02>;
> +	chassis-type = "handset";
> +
> +	aliases {
> +		serial0 = &uart7;
> +	};
> +
> +	chosen {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		bootargs = "console=tty0 clk_ignore_unused pd_ignore_unused";

Console should be chosed via stdout. The "unused" are not parts of
hardware description, so drop entire bootargs.

> +
> +		framebuffer: framebuffer@b8000000 {
> +			compatible = "simple-framebuffer";
> +			reg = <0x0 0xb8000000 0x0 0x2b00000>;
> +			width = <2176>;
> +			height = <1812>;
> +			stride = <(2176 * 4)>;
> +			format = "a8r8g8b8";
> +		};
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +		pinctrl-0 = <&volume_up_n>;
> +		pinctrl-names = "default";
> +
> +		key-volume-up {
> +			label = "Volume Up";
> +			linux,code = <KEY_VOLUMEUP>;
> +			gpios = <&pm8550_gpios 6 GPIO_ACTIVE_LOW>;
> +			debounce-interval = <15>;
> +			linux,can-disable;
> +			wakeup-source;
> +		};
> +	};
> +
> +	vph_pwr: vph-pwr-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vph_pwr";
> +		regulator-min-microvolt = <3700000>;
> +		regulator-max-microvolt = <3700000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
> +	reserved-memory {
> +		chipinfo_region@81cf4000 {

Underscores are not allowed, use hyphens.

It does not look like you tested the DTS against bindings. Please run
`make dtbs_check W=1` (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
for instructions).

> +			reg = <0x0 0x81cf4000 0x0 0x1000>;
> +			no-map;
> +		};
> +
> +		kaslr_region@b01ff000 {
> +			reg = <0x0 0xb01ff000 0x0 0x1000>;
> +			no-map;
> +		};
> +
> +		uh_guest_region {

It does not look like you tested the DTS against bindings. Please run
`make dtbs_check W=1` (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
for instructions).

> +			reg = <0x0 0xb1000000 0x0 0x3000000>;
> +			no-map;
> +		};
> +
> +		uh_heap_region {
> +			reg = <0x0 0xb0200000 0x0 0x40000>;
> +			no-map;
> +		};
> +
> +/*
> + * The bootloader will only keep display hardware enabled
> + * if this memory region is named exactly 'splash_region'
> + */

Missing indentation

> +		splash_region {
> +			reg = <0x0 0xb8000000 0x0 0x2b00000>;
> +			no-map;
> +		};
> +	}; // end reserved-memory

Drop such comments. There is no such code in any mainline DTS. Please
use mainline DTS as your starting point.

You now duplicated a lot of issues which we solved already. That's not
how you upstream your board.


..

> +	}; // end regulators-0

Really, drop the comment.

..

> +
> +&pcie0 {
> +	status = "okay";

Status is the last property.

> +	wake-gpios = <&tlmm 96 GPIO_ACTIVE_HIGH>;
> +	perst-gpios = <&tlmm 94 GPIO_ACTIVE_LOW>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pcie0_default_state>;

Reverse these two.

> +};
> +
> +&pcie0_phy {
> +	status = "okay";
> +	vdda-phy-supply = <&vreg_l1e_0p88>;
> +	vdda-pll-supply = <&vreg_l3e_1p2>;
> +};
> +
> +&pcie1 {
> +	status = "okay";
> +	wake-gpios = <&tlmm 99 GPIO_ACTIVE_HIGH>;
> +	perst-gpios = <&tlmm 97 GPIO_ACTIVE_LOW>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pcie1_default_state>;
> +};
> +
> +&pcie1_phy {
> +	vdda-phy-supply = <&vreg_l3c_0p91>;
> +	vdda-pll-supply = <&vreg_l3e_1p2>;
> +	vdda-qref-supply = <&vreg_l1e_0p88>;
> +	status = "okay";
> +};
> +
> +&pm8550_gpios {
> +	volume_up_n: volume-up-n-state {
> +		pins = "gpio6";
> +		function = "normal";
> +		power-source = <1>;
> +		bias-pull-up;
> +		input-enable;
> +	};
> +};
> +
> +&qupv3_id_0 {
> +	status = "okay";
> +};
> +
> +&remoteproc_adsp {
> +	status = "okay";
> +	firmware-name = "qcom/sm8550/adsp.mbn",
> +			"qcom/sm8550/adsp_dtb.mbn";
> +};
> +
> +&remoteproc_cdsp {
> +	status = "okay";
> +	firmware-name = "qcom/sm8550/cdsp.mbn",
> +			"qcom/sm8550/cdsp_dtb.mbn";
> +};
> +
> +&remoteproc_mpss {
> +	status = "okay";
> +	firmware-name = "qcom/sm8550/modem.mbn",
> +			"qcom/sm8550/modem_dtb.mbn";
> +};
> +
> +&sleep_clk {
> +	clock-frequency = <32000>;
> +};
> +
> +&tlmm {
> +	gpio-reserved-ranges = <36 4>, <50 2>;
> +};
> +
> +&ufs_mem_hc {
> +	status = "okay";
> +	reset-gpios = <&tlmm 210 GPIO_ACTIVE_LOW>;
> +	vcc-supply = <&vreg_l17b_2p5>;
> +	vcc-max-microamp = <1300000>;
> +	vccq-supply = <&vreg_l1g_1p2>;
> +	vccq-max-microamp = <1200000>;
> +	vdd-hba-supply = <&vreg_l3g_1p2>;
> +};
> +
> +&ufs_mem_phy {
> +	status = "okay";
> +	vdda-phy-supply = <&vreg_l1d_0p88>;
> +	vdda-pll-supply = <&vreg_l3e_1p2>;
> +};
> +
> +&xo_board {
> +	clock-frequency = <76800000>;
> +};
> +
> +&dispcc {
> +	status = "disabled";
> +};
> +
> +&pon_pwrkey {

Does not look ordered by name. Keep alphanetical order of node
overrides. Just like all other DTS does, which you should take as
starting point.

Best regards,
Krzysztof


