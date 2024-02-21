Return-Path: <linux-kernel+bounces-74505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3BD85D53C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FA6C1C22AF9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB7D3DB92;
	Wed, 21 Feb 2024 10:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Du87FHdk"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6703EA8B;
	Wed, 21 Feb 2024 10:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708510279; cv=none; b=XJdoEFD2Ti9YfSgjRFyJ3Wlz0L7i8WNzBCmrV3S6ZTrdVULlLHNTB+Fz/lDJbOUeCGMV5TK8EjAvxvVWjHlJ/LySMrmSqb6Bi2ENOcowEzO+Vf8/Rc5Fs+Y5QDpjcbZ9a7t1mCio2Zw05Zhobqh3qVHaGFIl7faLykEpjkN3ILE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708510279; c=relaxed/simple;
	bh=PQ4awJ6u0XbeOr9tOY44kUabcmxQpFzwRQS1dKIQKTE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ldekg0O+C0C58FEzqr53tLKvMjIuvsIT2ApLQ9yR7uSnZRtjJ8SdzHn/tfFAdTGn4cy66EyuR3PDwRUg4p0hrVebR3JdRZepHuTGa4TZ9cOyQS4MQm32uNPEd0lRyFxR0TteY8R6u4zHGrAnQMppDhltPqSjPGhZ1eW59qmmdOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Du87FHdk; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708510276;
	bh=PQ4awJ6u0XbeOr9tOY44kUabcmxQpFzwRQS1dKIQKTE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Du87FHdkJ/XW+3K5x6dd3zCH92Bw9hgZVorVoMzH/4EegYAWh1H67UQNi9rUtSotL
	 NPqVL6lW0d2iIHN8/OKwf9RR2fB8tIkDSHQCERSzVpxYIcn7ktN5Kw80mmkw8oTKsX
	 NxaeSqV+LWm+fslV/0TURzqVr8hwuab/Y+NObBfOqwxljwaDKIyN5bPg17Oh4XVKEc
	 vmcZPgwQ5N7Jai2SIamTtxJG7OBb2wFv8enNqwoyByFsoaU587dkvS+4bJozzhY+SG
	 u6cE4QRUurQhRTJOG0mZB3lX/r20xyHmE9oEG22E5GLnJbi3l2Ji9N80dhIOKgM/US
	 7M3mC2oINYOvQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id BB8FD378107C;
	Wed, 21 Feb 2024 10:11:14 +0000 (UTC)
Message-ID: <2fdf724e-4994-4873-971a-56c19b9fc471@collabora.com>
Date: Wed, 21 Feb 2024 11:11:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] arm64: dts: mediatek: Add Cudy WR3000 V1
Content-Language: en-US
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>, Hsin-Yi Wang <hsinyi@chromium.org>,
 =?UTF-8?Q?N=C3=ADcolas_F_=2E_R_=2E_A_=2E_Prado?= <nfraprado@collabora.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Chris Morgan <macromorgan@hotmail.com>,
 Linus Walleij <linus.walleij@linaro.org>, Sean Wang
 <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <rafal@milecki.pl>
References: <20240221073524.20947-1-zajec5@gmail.com>
 <20240221073524.20947-5-zajec5@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240221073524.20947-5-zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 21/02/24 08:35, Rafał Miłecki ha scritto:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> Cudy WR3000 V1 is an MT7981B (AKA Filogic 820) based wireless router. It
> has 256 MiB of RAM, some LEDs & buttons and (not described yet) 4
> Ethernet ports.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
>   arch/arm64/boot/dts/mediatek/Makefile         |  1 +
>   .../dts/mediatek/mt7981b-cudy-wr3000-v1.dts   | 74 +++++++++++++++++++
>   2 files changed, 75 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt7981b-cudy-wr3000-v1.dts
> 
> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
> index 37b4ca3a87c9..96da4ad640aa 100644
> --- a/arch/arm64/boot/dts/mediatek/Makefile
> +++ b/arch/arm64/boot/dts/mediatek/Makefile
> @@ -8,6 +8,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-evb.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-x20-dev.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-rfb1.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-bananapi-bpi-r64.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt7981b-cudy-wr3000-v1.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt7981b-xiaomi-ax3000t.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-acelink-ew-7886cax.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3.dtb
> diff --git a/arch/arm64/boot/dts/mediatek/mt7981b-cudy-wr3000-v1.dts b/arch/arm64/boot/dts/mediatek/mt7981b-cudy-wr3000-v1.dts
> new file mode 100644
> index 000000000000..cb36a089518a
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt7981b-cudy-wr3000-v1.dts
> @@ -0,0 +1,74 @@
> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
> +
> +/dts-v1/;
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/leds/common.h>
> +
> +#include "mt7981b.dtsi"
> +
> +/ {
> +	compatible = "cudy,wr3000-v1", "mediatek,mt7981b";
> +	model = "Cudy WR3000 V1";
> +
> +	memory@40000000 {
> +		reg = <0 0x40000000 0 0x10000000>;
> +		device_type = "memory";
> +	};
> +
> +	keys {
> +		compatible = "gpio-keys";
> +
> +		key-wps {
> +			label = "WPS";
> +			gpios = <&pio 0 GPIO_ACTIVE_LOW>;
> +			linux,code = <KEY_WPS_BUTTON>;
> +		};
> +
> +		key-reset {
> +			label = "RESET";
> +			gpios = <&pio 1 GPIO_ACTIVE_LOW>;
> +			linux,code = <KEY_RESTART>;
> +		};
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		led-0 {
> +			function = LED_FUNCTION_WAN;
> +			color = <LED_COLOR_ID_BLUE>;
> +			gpios = <&pio 5 GPIO_ACTIVE_LOW>;

Can we please order those properties alphabetically, as it doesn't impact
on human readability in any way?
Just a nitpick, anyway.

color = <LED_COLOR_ID_BLUE>;
function = LED_FUNCTION_WAN;
gpios = <&pio 5 GPIO_ACTIVE_LOW>;

> +		};
> +
> +		led-1 {
> +			function = LED_FUNCTION_WLAN_2GHZ;
> +			color = <LED_COLOR_ID_BLUE>;
> +			gpios = <&pio 6 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		led-2 {
> +			function = LED_FUNCTION_WLAN_5GHZ;
> +			color = <LED_COLOR_ID_BLUE>;
> +			gpios = <&pio 7 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		led-3 {
> +			function = LED_FUNCTION_LAN;
> +			color = <LED_COLOR_ID_BLUE>;
> +			gpios = <&pio 9 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		led-4 {
> +			function = LED_FUNCTION_STATUS;
> +			color = <LED_COLOR_ID_BLUE>;
> +			gpios = <&pio 10 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		led-5 {
> +			function = "online";

Uhm, what does "online" mean?

Are you sure that you can't use any of the LED_FUNCTION_XXX standard definitions?

Cheers,
Angelo


