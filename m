Return-Path: <linux-kernel+bounces-107526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABCF87FDAF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 13:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 147071F2377C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 12:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8E958206;
	Tue, 19 Mar 2024 12:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r7QeFPdw"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C4B18EAB
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 12:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710852067; cv=none; b=WThcoSJKx4g6hBVDcWEFvhpvBJQPS2lrZaSHYEe6LX4BoOS6Ft7MWWWNmWQCdqgVfcYbUNvpyVvN87p4D+t1augDPMl6/KesHrlv6t8f+M0W0Ai6NXIDsfhd+zYJeBah45yyjvGs+9zXdxKPRkJQj75Boi38zz2Ph7DgxzrrD1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710852067; c=relaxed/simple;
	bh=WkOk8giop+8VWt64Cm2hJuHGbWjATQz+Bza7RRp6Pzg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H/e2t3LlinFqz2bnK4U6FGFwYgLkVdVNMm0fIxOxRzm59uoqESOU2kFrwWA97DDvN4IIqYzShWnoMN0UkKg4EtVtJHJytLzk3Y/O6gpMpi/hYHJZGDm20LTLwBKq+WuK85NvRM6VmpsQpps8uoDWKIcJtvpuyfvA/qBD3n16S90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r7QeFPdw; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d28051376eso90222931fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 05:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710852062; x=1711456862; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WRBSPouyZNepIb9OSrcHdTHsgsddW1COazPCcrBFhTo=;
        b=r7QeFPdwNqsdyOX0OvlT0GYgR/GObAz++q4PFTCUKI3r/KAVEmSiuu7rcg9aS3vEGq
         l2ASwHATlsDu7rb3FZ4ii4+9Q0qNFgIrom/9uCFiXDQoYFQ3vDuKoafO8yyjl2iHFcoZ
         dk/zdi5VlVxLgyWhi5ViwoDrm96Vg5Phf7Zw44JXZxfA6v84bClxY6L9WgbXIfX4fEyH
         E3Ipb9qa0L6YEbjRlC4/tYMcZWwocTvT+sFw1OFL+lAc8uxvptdP/NIwGz0Ks0olIQQL
         gmd5VWsswlzEtU5IJsOY6c85Wbb/8YxBc2UVSitQIAvMRwdffhd7leDLTg020VVyVyoS
         kxIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710852062; x=1711456862;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WRBSPouyZNepIb9OSrcHdTHsgsddW1COazPCcrBFhTo=;
        b=M52z30HNrT60sH55Iln1TiJFsI9kWDr0uKX8gURlX5CiVfnN4acJEEtofDPkn4TDHr
         tOmFFDxsuwgpqtx+TqsrkM4W2bMADG2wgDfGTQDF2Iuke5a+un5/1dW17BKW7uXrtt0e
         Q5bTBwcEfBEeXn2yyqlBUKZjHdulv0YEfRxzfXxSrOi1/DNOyD8zM6pxOKdl7eQ+qEhP
         RdVkeDMNa/lRRhTEhrpDO8oqXeT60rbFVHm9JIKbBVvZ/RTljAeXFoHyZ9GWEzpGpE7r
         RlP1xfRUBBkdNDKcl9KWy4KaeMuAxuAlQzIvqBjGTGs/ZteCZlxvdEQbfWZm6yEU9EID
         sy8g==
X-Forwarded-Encrypted: i=1; AJvYcCWrlJZjcXN3CIn61H4b12PMz+HT5G2FREinYMC4zh4tCHrUamgDZDftREvEfM/9l/llSaLzmxxZXYsiatsFEDbVFh1sRotynvtvmJes
X-Gm-Message-State: AOJu0YxI4aKWsmy9NwSaJaiYvIN9rt1CwseKLI1edJOHbTXviprmUCmj
	KnbniE4MRQ9y6CX3NmgeJKiPwaHqRxpAP0X27TBrFDXl9nrJtnUsQZeiML0aQNs=
X-Google-Smtp-Source: AGHT+IHPsKr2x23kpUt5J7PZSHeRCwMXElORiE7lYuIw03+E+HKHRgPVb2cj8DNTcJx1R9oGY2SEYw==
X-Received: by 2002:a2e:b8cb:0:b0:2d4:aa55:72db with SMTP id s11-20020a2eb8cb000000b002d4aa5572dbmr6019143ljp.19.1710852061747;
        Tue, 19 Mar 2024 05:41:01 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id dn21-20020a17090794d500b00a465ee3d2cesm5971565ejc.218.2024.03.19.05.40.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 05:41:01 -0700 (PDT)
Message-ID: <b4f4f8e3-9832-4789-b4fb-beeeeb5c859e@linaro.org>
Date: Tue, 19 Mar 2024 13:40:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] arm64: dts: iesy: add support for iesy PX30 SoM OSM-S
To: Dominik Poggel <pog@iesy.com>, robh+dt@kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Tianling Shen <cnsztl@gmail.com>, Chris Morgan <macromorgan@hotmail.com>,
 Ondrej Jirman <megi@xff.cz>, Andy Yan <andyshrk@163.com>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240319095411.4112296-1-pog@iesy.com>
 <20240319095411.4112296-2-pog@iesy.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240319095411.4112296-2-pog@iesy.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/03/2024 10:54, Dominik Poggel wrote:
> This adds support for the iesy SoM px30-iesy-osm-sf and the matching
> evalboard px30-iesy-eva-mi V2.XX.
> 
> Signed-off-by: Dominik Poggel <pog@iesy.com>
> ---
>  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>  .../boot/dts/rockchip/px30-iesy-eva-mi-v2.dts | 624 ++++++++++++++++++
>  .../boot/dts/rockchip/px30-iesy-osm-sf.dtsi   | 346 ++++++++++
>  3 files changed, 971 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/px30-iesy-eva-mi-v2.dts
>  create mode 100644 arch/arm64/boot/dts/rockchip/px30-iesy-osm-sf.dtsi
> 
> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> index f906a868b71a..a46234ccbe15 100644
> --- a/arch/arm64/boot/dts/rockchip/Makefile
> +++ b/arch/arm64/boot/dts/rockchip/Makefile
> @@ -3,6 +3,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += px30-evb.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += px30-engicam-px30-core-ctouch2.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += px30-engicam-px30-core-ctouch2-of10.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += px30-engicam-px30-core-edimm2.2.dtb
> +dtb-$(CONFIG_ARCH_ROCKCHIP) += px30-iesy-eva-mi-v2.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += px30-ringneck-haikou.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3308-evb.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3308-roc-cc.dtb
> diff --git a/arch/arm64/boot/dts/rockchip/px30-iesy-eva-mi-v2.dts b/arch/arm64/boot/dts/rockchip/px30-iesy-eva-mi-v2.dts
> new file mode 100644
> index 000000000000..be1d709bbab0
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/px30-iesy-eva-mi-v2.dts
> @@ -0,0 +1,624 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Device Tree for iesy RPX30 EVA-MI V2.xx (Eval Kit)
> + *
> + * Copyright (c) 2022 iesy GmbH
> + */
> +
> +/dts-v1/;
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/net/mscc-phy-vsc8531.h>
> +#include "px30-iesy-osm-sf.dtsi"
> +
> +/ {
> +	model = "iesy RPX30 EVA-MI V2.xx (Eval Kit)";
> +	compatible = "iesy,rpx30-eva-mi-v2", "rockchip,px30";
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_leds_bb138>;
> +
> +		/* BB138a: green user led (LD4) */
> +		led@0 {

It does not look like you tested the DTS against bindings. Please run
`make dtbs_check W=1` (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
for instructions).

> +			label = "USER_LED_00";
> +			gpios = <&gpio3 RK_PA0 GPIO_ACTIVE_LOW>;
> +			linux,default-trigger = "heartbeat";
> +		};
> +
> +		/* BB138a: yellow user led (LD9)) */
> +		led@1 {
> +			label = "USER_LED_01";
> +			gpios = <&gpio3 RK_PA1 GPIO_ACTIVE_LOW>;
> +			default-state = "off";
> +		};
> +	};
> +
> +	/* BB138a: MAX9867ETJ+ audio codec */
> +	max9867-sound {

sound {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


> +		compatible = "simple-audio-card";
> +		simple-audio-card,name = "rockchip,max9867-codec";
> +		simple-audio-card,format = "i2s";
> +
> +		simple-audio-card,widgets =
> +			"Speaker", "Jack",
> +			"Microphone", "Mic";
> +		simple-audio-card,routing =
> +			"Jack", "LOUT",
> +			"Jack", "ROUT",
> +			"Mic", "DMICL",
> +			"Mic", "DMICR";
> +
> +		simple-audio-card,frame-master = <&cpudai>;
> +		simple-audio-card,bitclock-master = <&cpudai>;
> +
> +		status = "okay";
> +
> +		cpudai: simple-audio-card,cpu {
> +			sound-dai = <&i2s1_2ch>;
> +			dai-tdm-slot-num = <1>;
> +			dai-tdm-slot-width = <16>;
> +		};
> +
> +		simple-audio-card,codec {
> +			sound-dai = <&max9867>;
> +			clocks = <&cru SCLK_I2S1_OUT>;
> +		};
> +	};
> +
> +	/* regulator for USB OTG port */
> +	usb_a_vbus_regulator: regulator@1 {

Not a bus.

It does not look like you tested the DTS against bindings. Please run
`make dtbs_check W=1` (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
for instructions).

> +		compatible = "regulator-fixed";
> +		regulator-name = "usb_a_vbus_regulator";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		gpio = <&gpio3 RK_PC0 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
> +	/* regulator for USB host port */
> +	usb_b_vbus_regulator: regulator@2 {

It does not look like you tested the DTS against bindings. Please run
`make dtbs_check W=1` (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
for instructions).

> +		compatible = "regulator-fixed";
> +		regulator-name = "usb_b_vbus_regulator";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		gpio = <&gpio3 RK_PC3 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
> +	user-buttons {
> +		compatible = "gpio-keys";
> +		#address-cells = <1>;
> +		#size-cells = <0>;

It does not look like you tested the DTS against bindings. Please run
`make dtbs_check W=1` (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
for instructions).

You are repeating the same mistakes we fixed long time ago. This means
you started work from some downstream or old DTS. Don't. It's a waste of
time, also mine to tell you that we fixed all this.

Please start from scratch from upstream DTS and test your code before
sending.

..

..

> +/ {
> +	aliases {
> +		mmc0 = &emmc;
> +		mmc1 = &sdmmc;
> +		mmc2 = &sdio;
> +	};
> +
> +	chosen {
> +		bootargs = "earlycon=uart8250,mmio32,0xff160000 console=ttyFIQ0 rw root=PARTUUID=614e0000-0000 rootwait";

That's not correct bootargs. earlyocon is debugging, so drop from
mainline code. console goes to stdout property.
root/PARTUIID is obviously not correct. My PARTUIID is different.

Drop entire chosen.

> +	};
> +
> +	fiq-debugger {
> +		compatible = "rockchip,fiq-debugger";

Undocumented. Please run scripts/checkpatch.pl and fix reported
warnings. Some warnings can be ignored, but the code here looks like it
needs a fix. Feel free to get in touch if the warning is not clear.

You MUST run checkpatch on your submissions. All of them.

> +		rockchip,serial-id = <2>;
> +		rockchip,wake-irq = <0>;
> +		/* If enable uart uses irq instead of fiq */
> +		rockchip,irq-mode-enable = <1>;
> +		rockchip,baudrate = <115200>;  /* Only 115200 and 1500000 */
> +		interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_LOW>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&uart2m1_xfer>;
> +		status = "okay";

Why? Was it disabled anywhere? Anyway, that's not even hardware.

I am not going to review the rest. Please read submitting patches and
carefully follow it. Run all standard tests on your code before sending
patches. There is no point in reviewer telling you something which
automated tools tell.

Best regards,
Krzysztof


