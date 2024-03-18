Return-Path: <linux-kernel+bounces-106003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E31C87E757
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA25FB21DC0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39DC2DF73;
	Mon, 18 Mar 2024 10:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="24sDEon6"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634132E633;
	Mon, 18 Mar 2024 10:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710757697; cv=none; b=DjdpAjdbJA70yzNVQwqHEj7dHpyac4hVd/UkAG3I6j9mUITNp2hu0ceN7oAoJMCAiRcpVs8/tLmdTlJneVO90SPFpIWcCKCk/qHzeQ7vafRZqSAy4MI3TkL83miq3epPk3nMRp5BYgLUCzQqNlXfIJDavMW2FJmFXprmdBwepP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710757697; c=relaxed/simple;
	bh=Hlz3vIo/SAFLMtB571JA+dfQmkfGK4xIdjyWOHWeuq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nrTuMy/IpJCGdp6S0myd08oz0w2pYTC7ms8J7ZuC8spY6eifpSdVVav6hToI65B0/udrm7rQq2mtUEWPBDO2aWulfFPYD0gB6AneTHBUS1EPtp5aiyyuFU/1tRwRx44QVeCcQxE/1rS1jVlARIUkHbedU55tM40l43EfDDXWqAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=24sDEon6; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710757693;
	bh=Hlz3vIo/SAFLMtB571JA+dfQmkfGK4xIdjyWOHWeuq8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=24sDEon6VorXmZGTHRWyKcU6khdFzGNQ9Wxx/TS1W7GjC605djkugTTSNj4ZYl9Gs
	 KsQG/eKYuCDXq2cE72oHiGRwVZstqtGaXYBpRmSFrYuDZzvf/1XS9vjJBjpdUwAeLF
	 UTslBj1c+TSvDHG8IqzCFOF2ntB/evSCvYDhfofd+rGbppz5WJT4cG2hf21DgDQSLX
	 9kAJZ8t//mUo7UQiuY3cFEIDDz8vE7Asnchtl1syRJMgCKyUOyjoKbESwhytnCCNeQ
	 WXuyK8Nt6KK8lSjUxm7YlOcdXKkuFE2OmOuEw5i0w2vv/kWOajdOfTIYpXZC5rppuj
	 XOnrn5Cl6M1aw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2CF0C37813EA;
	Mon, 18 Mar 2024 10:28:12 +0000 (UTC)
Message-ID: <fb9ae93f-9531-468a-b6c8-044b91b62712@collabora.com>
Date: Mon, 18 Mar 2024 11:28:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 4/4] arm64: dts: mediatek: Add Cudy WR3000 V1
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
References: <20240317223206.22033-1-zajec5@gmail.com>
 <20240317223206.22033-5-zajec5@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240317223206.22033-5-zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 17/03/24 23:32, Rafał Miłecki ha scritto:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> Cudy WR3000 V1 is an MT7981B (AKA Filogic 820) based wireless router. It
> has 256 MiB of RAM, some LEDs & buttons and (not described yet) 4
> Ethernet ports.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
> V2: Reorder properties
>      Describe online LED
> V3: Use LED_FUNCTION_WAN_ONLINE (present in torvalds/linux.git)

I'm really happy that you managed to get that WAN_ONLINE definition in the common
leds binding, btw! :-)

> 
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
> index 000000000000..54101cc08a25
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
> +			color = <LED_COLOR_ID_BLUE>;
> +			function = LED_FUNCTION_WAN;
> +			gpios = <&pio 5 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		led-1 {
> +			color = <LED_COLOR_ID_BLUE>;
> +			function = LED_FUNCTION_WLAN_2GHZ;
> +			gpios = <&pio 6 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		led-2 {
> +			color = <LED_COLOR_ID_BLUE>;
> +			function = LED_FUNCTION_WLAN_5GHZ;
> +			gpios = <&pio 7 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		led-3 {
> +			color = <LED_COLOR_ID_BLUE>;
> +			function = LED_FUNCTION_LAN;
> +			gpios = <&pio 9 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		led-4 {
> +			color = <LED_COLOR_ID_BLUE>;
> +			function = LED_FUNCTION_STATUS;
> +			gpios = <&pio 10 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		led-5 {
> +			color = <LED_COLOR_ID_BLUE>;
> +			function = LED_FUNCTION_WAN_ONLINE;
> +			gpios = <&pio 11 GPIO_ACTIVE_LOW>;
> +		};
> +	};
> +};



