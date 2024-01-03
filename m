Return-Path: <linux-kernel+bounces-15351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C9B0822A88
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 10:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A17E41C231CB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 09:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B687C18AE1;
	Wed,  3 Jan 2024 09:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="MvEj7DVr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446A01862F;
	Wed,  3 Jan 2024 09:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704275360;
	bh=Ni5rBHAlIMtWk86HY1gN61XLWmUkTFatgPLd6DcQjh4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MvEj7DVr1QdjE61VfLIAjrd5GFOxeL9mtEQfW1EUFcJyHR4DIpKtj67ELKDBlPggH
	 oK1XDtD6i7PY00t8f0D+lFrQ/3dlle9uYHXBE0g5pycK+xKbAXDDL3sU3buYTTOWF/
	 hOpg1knT19+YG1ToGMIkJqPraicB52TzXgVZVvTlgKTzDBTVl9+++fiO+xfJoL9u/3
	 Rtk571GdIwnHH2x/5PfXzs06qtvPi0ep76JrGYZLJaG6cGJkMixRmCKe9SKfz2scIZ
	 Mt7Wgir5EOcfGlbVivxLzZc1xcII0VvR3TX1r6SJmo4jJuyapSe3UR+nzsEAVY/81e
	 8V5UoB1Rn74EQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0EEF83780629;
	Wed,  3 Jan 2024 09:49:19 +0000 (UTC)
Message-ID: <04dbf010-5e0a-42f9-8a13-d02f97347c23@collabora.com>
Date: Wed, 3 Jan 2024 10:49:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: mediatek: Add initial MT7988A and BPI-R4
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Daniel Golle <daniel@makrotopia.org>, Hsin-Yi Wang <hsinyi@chromium.org>,
 =?UTF-8?Q?N=C3=ADcolas_F_=2E_R_=2E_A_=2E_Prado?= <nfraprado@collabora.com>,
 jason-ch chen <Jason-ch.Chen@mediatek.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>,
 =?UTF-8?Q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>,
 Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <rafal@milecki.pl>
References: <20240102205941.29654-1-zajec5@gmail.com>
 <20240102205941.29654-2-zajec5@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240102205941.29654-2-zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 02/01/24 21:59, Rafał Miłecki ha scritto:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> MT7988A (AKA MediaTek Filogic 880) is a quad-core ARM Cortex-A73
> platform designed for Wi-Fi 7 devices (there is no wireless on SoC
> though). The first public MT7988A device is Banana Pi BPI-R4.
> 
> Many SoC parts remain to be added (they need their own bindings or
> depend on missing clocks). Those present block however are correct and
> having base .dtsi will help testing & working on missing stuff.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
>   arch/arm64/boot/dts/mediatek/Makefile         |   1 +
>   .../dts/mediatek/mt7988a-bananapi-bpi-r4.dts  |  11 ++
>   arch/arm64/boot/dts/mediatek/mt7988a.dtsi     | 149 ++++++++++++++++++
>   3 files changed, 161 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt7988a.dtsi
> 
> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
> index 1e6f91731e92..0a189d5d8006 100644
> --- a/arch/arm64/boot/dts/mediatek/Makefile
> +++ b/arch/arm64/boot/dts/mediatek/Makefile
> @@ -15,6 +15,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-nor.dtbo
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-sd.dtbo
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-rfb.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986b-rfb.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt7988a-bananapi-bpi-r4.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8167-pumpkin.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8173-elm.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8173-elm-hana.dtb
> diff --git a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts
> new file mode 100644
> index 000000000000..efc4ad0b08b8
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts
> @@ -0,0 +1,11 @@
> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
> +
> +/dts-v1/;
> +
> +#include "mt7988a.dtsi"
> +
> +/ {
> +	compatible = "bananapi,bpi-r4", "mediatek,mt7988a";
> +	model = "Banana Pi BPI-R4";
> +	chassis-type = "embedded";
> +};
> diff --git a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
> new file mode 100644
> index 000000000000..0f2ae9c7aef7
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
> @@ -0,0 +1,149 @@
> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +/ {
> +	compatible = "mediatek,mt7986a";

Why is the compatible describing MT798*6*A instead of MT7988A? Please fix.

> +	interrupt-parent = <&gic>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu@0 {
> +			compatible = "arm,cortex-a73";
> +			reg = <0x0>;
> +			device_type = "cpu";
> +			enable-method = "psci";
> +		};
> +
> +		cpu@1 {
> +			compatible = "arm,cortex-a73";
> +			reg = <0x1>;
> +			device_type = "cpu";
> +			enable-method = "psci";
> +		};
> +
> +		cpu@2 {
> +			compatible = "arm,cortex-a73";
> +			reg = <0x2>;
> +			device_type = "cpu";
> +			enable-method = "psci";
> +		};
> +
> +		cpu@3 {
> +			compatible = "arm,cortex-a73";
> +			reg = <0x3>;
> +			device_type = "cpu";
> +			enable-method = "psci";
> +		};
> +	};
> +
> +	oscillator-40m {
> +		compatible = "fixed-clock";
> +		clock-frequency = <40000000>;
> +		#clock-cells = <0>;
> +		clock-output-names = "clkxtal";
> +	};
> +
> +	pmu {
> +		compatible = "arm,cortex-a73-pmu";
> +		interrupt-parent = <&gic>;
> +		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
> +	};
> +
> +	psci {
> +		compatible = "arm,psci-0.2";
> +		method = "smc";
> +	};
> +
> +	reserved-memory {
> +		ranges;
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +
> +		/* 320 KiB reserved for ARM Trusted Firmware (BL31 and BL32) */
> +		secmon@43000000 {

This is board specific (actually, it is bootloader specific!), so please move it
to your board dts(i).

> +			reg = <0 0x43000000 0 0x50000>;
> +			no-map;
> +		};
> +
> +	};
> +
> +	soc {
> +		compatible = "simple-bus";
> +		ranges;
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +
> +		gic: interrupt-controller@c000000 {
> +			compatible = "arm,gic-v3";
> +			reg = <0 0x0c000000 0 0x40000>,  /* GICD */
> +			      <0 0x0c080000 0 0x200000>, /* GICR */
> +			      <0 0x0c400000 0 0x2000>,   /* GICC */
> +			      <0 0x0c410000 0 0x1000>,   /* GICH */
> +			      <0 0x0c420000 0 0x2000>;   /* GICV */
> +			interrupt-parent = <&gic>;
> +			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-controller;
> +			#interrupt-cells = <3>;
> +		};
> +
> +		watchdog@1001c000 {
> +			compatible = "mediatek,mt7988-wdt";
> +			reg = <0 0x1001c000 0 0x1000>;
> +			interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
> +			#reset-cells = <1>;
> +		};
> +	};
> +
> +	thermal-zones {
> +		cpu-thermal {
> +			polling-delay-passive = <1000>;
> +			polling-delay = <1000>;
> +

Those thermal zones will not work, as they have no thermal-sensors - as this
node is right now, it will produce a probe error and nothing else: please
either drop it entirely or add support for the thermal sensors (lvts or auxadc?)
and fix this node to use them.

> +			trips {
> +				crit {
> +					temperature = <125000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +
> +				hot {
> +					temperature = <120000>;
> +					hysteresis = <2000>;
> +					type = "hot";
> +				};
> +
> +				active-high {
> +					temperature = <115000>;
> +					hysteresis = <2000>;
> +					type = "active";

Active cooling is board specific. Keep only critical/hot trips in the SoC DT.

> +				};
> +
> +				active-med {
> +					temperature = <85000>;
> +					hysteresis = <2000>;
> +					type = "active";
> +				};
> +
> +				active-low {
> +					temperature = <40000>;
> +					hysteresis = <2000>;
> +					type = "active";
> +				};
> +			};
> +		};
> +	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupt-parent = <&gic>;
> +		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
> +	};
> +};

Regards,
Angelo

