Return-Path: <linux-kernel+bounces-155213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9C08AE6DA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8576E1F23C8F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4DB413666B;
	Tue, 23 Apr 2024 12:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="rKzDmKTG"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C30135A54
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 12:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713876384; cv=none; b=V2nkC/JnlsGWvBD4j6sbNJx74mrZbwrJYjhfxrH4s2Mne+PnGuRepfXewBbydpa0utCyEecMVFzLvqyNDcWMYbK0QYaT8n4PQ+pYrtp4fHrteeYFjUVobkLWugzlMYlIMmM5EeWQsVInZvTt1HkorqzB0XQCMv4X6dFfJvrEiNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713876384; c=relaxed/simple;
	bh=fv24otzIdbTkNmM/Iq3YiotlOhcVOcMFQNzMPnvNyKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pKyhhciWfHxdpedoDlvoBbn3dH02mAy/1zHchFx6w1r/EZlwoJ6J8YCqnnjZ7nLDjC/ahL+Bdhg+fA3jxZuWK7H6aQ3Lwj+xB1mgacAlEnHdP9aWLu39QK0/IS8DVpjv8thriIj9uigjXamYQzvbZArBQ5/8dVXBizCf7eIUX8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=rKzDmKTG; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1713876376; x=1716468376;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=fv24otzIdbTkNmM/Iq3YiotlOhcVOcMFQNzMPnvNyKE=;
	b=rKzDmKTG4XC1qz9bh8Fqkq1lpYte9+p7frI8ODwMMX+5cLxhk5ZP3L3a0XA9T5EZ
	qt6LjpNtzEFY5z/oPSm/bHMp6J/737L0XQ8n5sPHsrNNrNF7RHS7olIwFTBHMyRl
	MeUyffvBQ9VarUF3lQhh7+r8ZAwmDkftI596QpdCzTM=;
X-AuditID: ac14000a-fadff7000000290d-a8-6627ad98fd30
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 01.44.10509.89DA7266; Tue, 23 Apr 2024 14:46:16 +0200 (CEST)
Received: from [172.25.39.28] (172.25.0.11) by Berlix.phytec.de (172.25.0.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 23 Apr
 2024 14:46:14 +0200
Message-ID: <95022657-c82c-4e20-9a3d-f83acf9911d8@phytec.de>
Date: Tue, 23 Apr 2024 14:46:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: ti: am64-phyboard-electra: Add overlay to
 enable a GPIO fan
To: Nathan Morrisson <nmorrisson@phytec.com>, <nm@ti.com>, <vigneshr@ti.com>,
	<kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <upstream@lists.phytec.de>
References: <20240419193114.3090084-1-nmorrisson@phytec.com>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20240419193114.3090084-1-nmorrisson@phytec.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIIsWRmVeSWpSXmKPExsWyRpKBR3fGWvU0g92f2C3W7D3HZDH/yDlW
	i+WfZ7NbvJx1j81i0+NrrBaXd81hs3jz4yyTxYfGzWwW//fsYLfofqdu8f/sB3YHbo9NqzrZ
	PDYvqffo725h9fhz8R2rx/Eb25k8Pm+SC2CL4rJJSc3JLEst0rdL4MpYtmIDU8EvmYoN2w+x
	NjB2SHQxcnJICJhI3Lp6iaWLkYtDSGAJk8S89c9YIZy7jBL9+y6zg1TxCthIfL4xj6mLkYOD
	RUBVYuICqLCgxMmZT1hAbFEBeYn7t2aAxYUF4iTOtdxhApkjIrCUUeLxqh1gDrNAG6PEk4cH
	mEEGCQEN3bZZB6SBWUBc4taT+UwgNpuAusSdDd9YQUo4BWwlzm5RhCixkFj85iA7hC0vsf3t
	HGYQWwjIfnFpOQvEM/IS0869ZoawQyW2ftnONIFReBaSU2ch2TYLydhZSMYuYGRZxSiUm5mc
	nVqUma1XkFFZkpqsl5K6iREUbSIMXDsY++Z4HGJk4mA8xCjBwawkwvvrj0qaEG9KYmVValF+
	fFFpTmrxIUZpDhYlcd7VHcGpQgLpiSWp2ampBalFMFkmDk6pBkYV3YdrlCrseT9zu5pufBVf
	fH6PldjTWUm8e/iORNy+EbRB7/7PEscaxqcbqrxmrfjru+VGdnK7y9Ujc0LfqW9edGyR8aL7
	Vz7HXeL7pFRx232LnofEhfAi5nfzH9cuMZjB+HP3RsYlLst3XV0gdLVH3SR+4V1PdT2dv3lV
	Dnlr7k8R+jnzefJCJZbijERDLeai4kQAAx6pM6QCAAA=



Am 19.04.24 um 21:31 schrieb Nathan Morrisson:
> The phyBOARD-Electra has a GPIO fan header. This overlay enables the fan
> header and sets the fan to turn on at 65C.
> 
> Signed-off-by: Nathan Morrisson <nmorrisson@phytec.com>

Reviewed-by: Wadim Egorov <w.egorov@phytec.de>

> ---
>   arch/arm64/boot/dts/ti/Makefile               |  4 ++
>   .../k3-am642-phyboard-electra-gpio-fan.dtso   | 50 +++++++++++++++++++
>   2 files changed, 54 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-gpio-fan.dtso
> 
> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
> index 9a722c2473fb..fd91cf40af6d 100644
> --- a/arch/arm64/boot/dts/ti/Makefile
> +++ b/arch/arm64/boot/dts/ti/Makefile
> @@ -48,6 +48,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-am642-hummingboard-t.dtb
>   dtb-$(CONFIG_ARCH_K3) += k3-am642-hummingboard-t-pcie.dtb
>   dtb-$(CONFIG_ARCH_K3) += k3-am642-hummingboard-t-usb3.dtb
>   dtb-$(CONFIG_ARCH_K3) += k3-am642-phyboard-electra-rdk.dtb
> +dtb-$(CONFIG_ARCH_K3) += k3-am642-phyboard-electra-gpio-fan.dtbo
>   dtb-$(CONFIG_ARCH_K3) += k3-am642-sk.dtb
>   dtb-$(CONFIG_ARCH_K3) += k3-am642-tqma64xxl-mbax4xxl.dtb
>   dtb-$(CONFIG_ARCH_K3) += k3-am64-tqma64xxl-mbax4xxl-sdcard.dtbo
> @@ -131,6 +132,8 @@ k3-am62p5-sk-csi2-tevi-ov5640-dtbs := k3-am62p5-sk.dtb \
>   	k3-am62x-sk-csi2-tevi-ov5640.dtbo
>   k3-am642-evm-icssg1-dualemac-dtbs := \
>   	k3-am642-evm.dtb k3-am642-evm-icssg1-dualemac.dtbo
> +k3-am642-phyboard-electra-gpio-fan-dtbs := \
> +	k3-am642-phyboard-electra-rdk.dtb k3-am642-phyboard-electra-gpio-fan.dtbo
>   k3-am642-tqma64xxl-mbax4xxl-sdcard-dtbs := \
>   	k3-am642-tqma64xxl-mbax4xxl.dtb k3-am64-tqma64xxl-mbax4xxl-sdcard.dtbo
>   k3-am642-tqma64xxl-mbax4xxl-wlan-dtbs := \
> @@ -174,6 +177,7 @@ DTC_FLAGS_k3-am62-lp-sk += -@
>   DTC_FLAGS_k3-am62a7-sk += -@
>   DTC_FLAGS_k3-am62p5-sk += -@
>   DTC_FLAGS_k3-am642-evm += -@
> +DTC_FLAGS_k3-am642-phyboard-electra-rdk += -@
>   DTC_FLAGS_k3-am642-tqma64xxl-mbax4xxl += -@
>   DTC_FLAGS_k3-am6548-iot2050-advanced-m2 += -@
>   DTC_FLAGS_k3-am68-sk-base-board += -@
> diff --git a/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-gpio-fan.dtso b/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-gpio-fan.dtso
> new file mode 100644
> index 000000000000..5057658061b4
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-gpio-fan.dtso
> @@ -0,0 +1,50 @@
> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
> +/*
> + * Copyright (C) 2024 PHYTEC America LLC
> + * Author: Nathan Morrisson <nmorrisson@phytec.com>
> + */
> +
> +/dts-v1/;
> +/plugin/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/thermal/thermal.h>
> +#include "k3-pinctrl.h"
> +
> +&{/} {
> +	fan: gpio-fan {
> +		compatible = "gpio-fan";
> +		gpio-fan,speed-map = <0 0 8600 1>;
> +		gpios = <&main_gpio0 28 GPIO_ACTIVE_LOW>;
> +		#cooling-cells = <2>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&gpio_fan_pins_default>;
> +	};
> +};
> +
> +&main_pmx0 {
> +	gpio_fan_pins_default: gpio-fan-default-pins {
> +		pinctrl-single,pins = <
> +			AM64X_IOPAD(0x070, PIN_OUTPUT, 7) /* (V18) GPMC0_AD13.GPIO0_28 */
> +		>;
> +	};
> +};
> +
> +&thermal_zones {
> +	main0_thermal: main0-thermal {
> +		trips {
> +			main0_thermal_trip0: main0-thermal-trip {
> +				temperature = <65000>;  /* millicelsius */
> +				hysteresis = <2000>;    /* millicelsius */
> +				type = "active";
> +			};
> +		};
> +
> +		cooling-maps {
> +			map0 {
> +				trip = <&main0_thermal_trip0>;
> +				cooling-device = <&fan THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +			};
> +		};
> +	};
> +};

