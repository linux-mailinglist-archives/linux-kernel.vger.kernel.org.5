Return-Path: <linux-kernel+bounces-70925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A66859E17
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D1951C21F8C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 08:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1DA22110F;
	Mon, 19 Feb 2024 08:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="akEZgZgR"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50ABC210F9
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 08:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708330891; cv=none; b=Cb62Wg4eKRoy8iX+TmFtz4Pl0/usSZdFNIoWGOvC/H3VNI1b5UzVT3bqtdDQdE/9YYXLmE6lOncMbB+lODaOQUYMtqAcEkOYjXDu++le5Ew6qCYe9UBRIHTYbSnrCQRktS8HcXsrm9gEgJxRMCyMWoLN0BeICi5W5JGjOhml3i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708330891; c=relaxed/simple;
	bh=8Tz2P3B/GJtmxoDmSLfQpcjCP6pzq2gDRGCeiPN/Xdc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lmN5cLjLxMDCq7N3/eP3+4VaEEr3VEV93aCMLAR2Nx/9l4xK8wk9KFv2pBXopJBUd4jXyegRFM9j/RKkwtkNZ/zqEbJ2qaoEq6lVoTnKURfxRSqxhW7qSRlZe3dCnf2BNnHvt41PlwtxDOlykjKfnJs1OBjH4kU7CDmPCmOoHPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=akEZgZgR; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4126a159fa6so657655e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 00:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708330888; x=1708935688; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PbtO8E+R+Ye0n+PHbBwI9aLX7sjuNvZeeffPcr+5Scc=;
        b=akEZgZgRTOGQ/xrNmlrgZM2jUTilhmufqhaoVB5R2bsC6MLG4zL+WSnE4Ps6J0VqMz
         NoBCwHTC4N1VqbuVjs5mvPjuPrR6TKAdJUYFp92bJp8JK748DjJZs4PijydaoXx8uWnj
         uG0RBhX4evzUZ5L7Wc37PhhSW14dY4krK3xjscPkf/wlkEt84Xw87UqsTXXWFvJAqd74
         zyPqffNvq45uTy6vHyN9KtQFBF4LkCenPNSHmmgGt6YgbggwuecgkxssLF2YlioSsNRT
         g474JD0Bqe6cXrqabr2WCNzU4OLNzcoVak1qNRWN0++uTC9MY6duC4UjGdlMsJcE6BtX
         1DJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708330888; x=1708935688;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PbtO8E+R+Ye0n+PHbBwI9aLX7sjuNvZeeffPcr+5Scc=;
        b=ure7k/FAOVIZlTlEzo3zXgZSjj90SARoLzQ+FXdb3nW9eL0B0mhfpcY8CxOAICR/hO
         xNK0wc0KMLcbLbboTPHmyhDJD1SQHkNmUgIumUr2BKEVYsx/pV+fOqcCxeqGmuqvRTTo
         uB0oiPtVTtNZOD6k6BmUjxqkWKtPMWcDerHsdywCQ1OgVOlBANb06SQ7k90r3+7j52Ie
         LK8xPLZEPoOdffFF7ZBPFKJMicGirZtVoPNhQIJ7mvJE02/8ZI8IACUzekM8DtVUe962
         zvUD15WCONrlnaUPZRRR1MmmP8BVOf6Ei3jBm6YG4ekeXkbK9S51YEYWoC8wv7dRlJhY
         GVGA==
X-Forwarded-Encrypted: i=1; AJvYcCWJ5uJdDwxS5TBRb0AwIeok1R0vzhwxdaKRoSCZMtsYwjXiUVmQxQL68iCJlUlOkWv+vU3YhHqGwHo9zR2l02uGKh1zonp7lMvCArKE
X-Gm-Message-State: AOJu0Yxn4tfZQaOzUQB+NVnioWnIQVHWEmM5LORZroBoKHmWQyDmCeGT
	5qZuC+0/Rw51mAQYvWEPfE5TxJxxLfrZ6Oy2lMoVw2E3sz9JnSOSugAnBsJ+NjE=
X-Google-Smtp-Source: AGHT+IENJaJSNK/41LSQpsskDVTOY3gpkXruaWXSrFda0SX5/XcQjZV3Ul1gQgxXmWvV0ISIc3Rz9A==
X-Received: by 2002:adf:fd4f:0:b0:33d:1ad9:a20c with SMTP id h15-20020adffd4f000000b0033d1ad9a20cmr4773755wrs.28.1708330887566;
        Mon, 19 Feb 2024 00:21:27 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id c5-20020adfe745000000b0033b46b1b6adsm9587734wrn.21.2024.02.19.00.21.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Feb 2024 00:21:27 -0800 (PST)
Message-ID: <da859ac9-8f87-43b1-88ba-0357fa9b7be3@linaro.org>
Date: Mon, 19 Feb 2024 09:21:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] arm64: dts: freescale: add i.MX95 basic dtsi
Content-Language: en-US
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Li Yang <leoyang.li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
References: <20240218-imx95-dts-v1-0-2959f89f2018@nxp.com>
 <20240218-imx95-dts-v1-2-2959f89f2018@nxp.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240218-imx95-dts-v1-2-2959f89f2018@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/02/2024 07:38, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> i.MX95 features 6 A55 Cores, ARM Mali GPU, ISP, ML acceleration NPU,
> and Edgelock secure enclave security. This patch is to add a minimal
> dtsi, with cpu cores, coresight, scmi, gic, uart, mu, sdhc, lpi2c added.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx95-clock.h |  187 +++++
>  arch/arm64/boot/dts/freescale/imx95-power.h |   55 ++
>  arch/arm64/boot/dts/freescale/imx95.dtsi    | 1215 +++++++++++++++++++++++++++
>  3 files changed, 1457 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx95-clock.h b/arch/arm64/boot/dts/freescale/imx95-clock.h
> new file mode 100644
> index 000000000000..939655f0414e
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx95-clock.h

What is this?


> @@ -0,0 +1,187 @@
> +/* SPDX-License-Identifier: GPL-2.0-only OR MIT */
> +/*
> + * Copyright 2024 NXP
> + */
> +
> +#ifndef __DT_BINDINGS_CLOCK_IMX95_H

NAK, bindings do not go to DTS!


> +#endif	/* __DT_BINDINGS_CLOCK_IMX95_H */
> diff --git a/arch/arm64/boot/dts/freescale/imx95-power.h b/arch/arm64/boot/dts/freescale/imx95-power.h
> new file mode 100644
> index 000000000000..17be8a4cb96b
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx95-power.h
> @@ -0,0 +1,55 @@
> +/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
> +/*
> + *  Copyright 2024 NXP
> + */
> +
> +#ifndef __DT_BINDINGS_IMX95_POWER_H__
> +#define __DT_BINDINGS_IMX95_POWER_H__

NAK, bindings do not go to DTS.

> diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
> new file mode 100644
> index 000000000000..5b5b29a9aff5
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
> @@ -0,0 +1,1215 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)

Weird license. We do not want GPL v3 or v4.

> +/*
> + * Copyright 2024 NXP
> + */
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/thermal/thermal.h>
> +
> +#include "imx95-clock.h"
> +#include "imx95-power.h"
> +
> +/ {
> +	interrupt-parent = <&gic>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	aliases {
> +		gpio0 = &gpio1;
> +		gpio1 = &gpio2;
> +		gpio2 = &gpio3;
> +		gpio3 = &gpio4;
> +		gpio4 = &gpio5;
> +		i2c0 = &lpi2c1;
> +		i2c1 = &lpi2c2;
> +		i2c2 = &lpi2c3;
> +		i2c3 = &lpi2c4;
> +		i2c4 = &lpi2c5;
> +		i2c5 = &lpi2c6;
> +		i2c6 = &lpi2c7;
> +		i2c7 = &lpi2c8;

None of these are properties of the SoC.

> +		mmc0 = &usdhc1;
> +		mmc1 = &usdhc2;
> +		mmc2 = &usdhc3;
> +		serial0 = &lpuart1;
> +		serial1 = &lpuart2;
> +		serial2 = &lpuart3;
> +		serial3 = &lpuart4;
> +		serial4 = &lpuart5;
> +		serial5 = &lpuart6;
> +		serial6 = &lpuart7;
> +		serial7 = &lpuart8;

Neither these.

> +	};
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		idle-states {
> +			entry-method = "psci";
> +
> +			cpu_pd_wait: cpu-pd-wait {
> +				compatible = "arm,idle-state";
> +				arm,psci-suspend-param = <0x0010033>;
> +				local-timer-stop;
> +				entry-latency-us = <10000>;
> +				exit-latency-us = <7000>;
> +				min-residency-us = <27000>;
> +				wakeup-latency-us = <15000>;
> +				status = "disabled";
> +			};
> +		};
> +
> +		A55_0: cpu@0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a55";
> +			reg = <0x0>;
> +			enable-method = "psci";
> +			#cooling-cells = <2>;
> +			cpu-idle-states = <&cpu_pd_wait>;
> +			power-domains = <&scmi_devpd IMX95_PERF_A55>;
> +			power-domain-names = "perf";
> +			i-cache-size = <32768>;
> +			i-cache-line-size = <64>;
> +			i-cache-sets = <128>;
> +			d-cache-size = <32768>;
> +			d-cache-line-size = <64>;
> +			d-cache-sets = <128>;
> +			next-level-cache = <&l2_cache_l0>;
> +		};
> +
> +		A55_1: cpu@100 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a55";
> +			reg = <0x100>;
> +			enable-method = "psci";
> +			#cooling-cells = <2>;
> +			cpu-idle-states = <&cpu_pd_wait>;
> +			power-domains = <&scmi_devpd IMX95_PERF_A55>;
> +			power-domain-names = "perf";
> +			i-cache-size = <32768>;
> +			i-cache-line-size = <64>;
> +			i-cache-sets = <128>;
> +			d-cache-size = <32768>;
> +			d-cache-line-size = <64>;
> +			d-cache-sets = <128>;
> +			next-level-cache = <&l2_cache_l1>;
> +		};
> +
> +		A55_2: cpu@200 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a55";
> +			reg = <0x200>;
> +			enable-method = "psci";
> +			#cooling-cells = <2>;
> +			cpu-idle-states = <&cpu_pd_wait>;
> +			power-domains = <&scmi_devpd IMX95_PERF_A55>;
> +			power-domain-names = "perf";
> +			i-cache-size = <32768>;
> +			i-cache-line-size = <64>;
> +			i-cache-sets = <128>;
> +			d-cache-size = <32768>;
> +			d-cache-line-size = <64>;
> +			d-cache-sets = <128>;
> +			next-level-cache = <&l2_cache_l2>;
> +		};
> +
> +		A55_3: cpu@300 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a55";
> +			reg = <0x300>;
> +			enable-method = "psci";
> +			#cooling-cells = <2>;
> +			power-domains = <&scmi_devpd IMX95_PERF_A55>;
> +			power-domain-names = "perf";
> +			i-cache-size = <32768>;
> +			i-cache-line-size = <64>;
> +			i-cache-sets = <128>;
> +			d-cache-size = <32768>;
> +			d-cache-line-size = <64>;
> +			d-cache-sets = <128>;
> +			next-level-cache = <&l2_cache_l3>;
> +		};
> +
> +		A55_4: cpu@400 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a55";
> +			reg = <0x400>;
> +			power-domains = <&scmi_devpd IMX95_PERF_A55>;
> +			power-domain-names = "perf";
> +			enable-method = "psci";
> +			#cooling-cells = <2>;
> +			cpu-idle-states = <&cpu_pd_wait>;
> +			i-cache-size = <32768>;
> +			i-cache-line-size = <64>;
> +			i-cache-sets = <128>;
> +			d-cache-size = <32768>;
> +			d-cache-line-size = <64>;
> +			d-cache-sets = <128>;
> +			next-level-cache = <&l2_cache_l4>;
> +		};
> +
> +		A55_5: cpu@500 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a55";
> +			reg = <0x500>;
> +			power-domains = <&scmi_devpd IMX95_PERF_A55>;
> +			power-domain-names = "perf";
> +			enable-method = "psci";
> +			#cooling-cells = <2>;
> +			cpu-idle-states = <&cpu_pd_wait>;
> +			i-cache-size = <32768>;
> +			i-cache-line-size = <64>;
> +			i-cache-sets = <128>;
> +			d-cache-size = <32768>;
> +			d-cache-line-size = <64>;
> +			d-cache-sets = <128>;
> +			next-level-cache = <&l2_cache_l5>;
> +		};
> +
> +		l2_cache_l0: l2-cache-l0 {
> +			compatible = "cache";
> +			cache-size = <65536>;
> +			cache-line-size = <64>;
> +			cache-sets = <256>;
> +			cache-level = <2>;
> +			cache-unified;
> +			next-level-cache = <&l3_cache>;
> +		};
> +
> +		l2_cache_l1: l2-cache-l1 {
> +			compatible = "cache";
> +			cache-size = <65536>;
> +			cache-line-size = <64>;
> +			cache-sets = <256>;
> +			cache-level = <2>;
> +			cache-unified;
> +			next-level-cache = <&l3_cache>;
> +		};
> +
> +		l2_cache_l2: l2-cache-l2 {
> +			compatible = "cache";
> +			cache-size = <65536>;
> +			cache-line-size = <64>;
> +			cache-sets = <256>;
> +			cache-level = <2>;
> +			cache-unified;
> +			next-level-cache = <&l3_cache>;
> +		};
> +
> +		l2_cache_l3: l2-cache-l3 {
> +			compatible = "cache";
> +			cache-size = <65536>;
> +			cache-line-size = <64>;
> +			cache-sets = <256>;
> +			cache-level = <2>;
> +			cache-unified;
> +			next-level-cache = <&l3_cache>;
> +		};
> +
> +		l2_cache_l4: l2-cache-l4 {
> +			compatible = "cache";
> +			cache-size = <65536>;
> +			cache-line-size = <64>;
> +			cache-sets = <256>;
> +			cache-level = <2>;
> +			cache-unified;
> +			next-level-cache = <&l3_cache>;
> +		};
> +
> +		l2_cache_l5: l2-cache-l5 {
> +			compatible = "cache";
> +			cache-size = <65536>;
> +			cache-line-size = <64>;
> +			cache-sets = <256>;
> +			cache-level = <2>;
> +			cache-unified;
> +			next-level-cache = <&l3_cache>;
> +		};
> +
> +		l3_cache: l3-cache {
> +			compatible = "cache";
> +			cache-size = <524288>;
> +			cache-line-size = <64>;
> +			cache-sets = <1024>;
> +			cache-level = <3>;
> +			cache-unified;
> +		};
> +
> +		cpu-map {
> +			cluster0 {
> +				core0 {
> +					cpu = <&A55_0>;
> +				};
> +
> +				core1 {
> +					cpu = <&A55_1>;
> +				};
> +
> +				core2 {
> +					cpu = <&A55_2>;
> +				};
> +
> +				core3 {
> +					cpu = <&A55_3>;
> +				};
> +
> +				core4 {
> +					cpu = <&A55_4>;
> +				};
> +
> +				core5 {
> +					cpu = <&A55_5>;
> +				};
> +			};
> +		};
> +	};
> +
> +	clk_ext1: clock-ext1 {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <133000000>;
> +		clock-output-names = "clk_ext1";
> +	};
> +
> +	dummy: clk-dummy {

Nothing explains why do you add dummy clocks. Dummy is fake, so don't
add fake clocks to DTS.

> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <0>;
> +		clock-output-names = "dummy";
> +	};
> +
> +	sai1_mclk: sai-mclk1 {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency= <0>;
> +		clock-output-names = "sai1_mclk";
> +	};
> +
> +	sai2_mclk: sai-mclk2 {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency= <0>;
> +		clock-output-names = "sai2_mclk";
> +	};
> +
> +	sai3_mclk: sai-mclk3 {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency= <0>;
> +		clock-output-names = "sai3_mclk";
> +	};
> +
> +	sai4_mclk: sai-mclk4 {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency= <0>;
> +		clock-output-names = "sai4_mclk";
> +	};
> +
> +	sai5_mclk: sai-mclk5 {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency= <0>;
> +		clock-output-names = "sai5_mclk";
> +	};
> +
> +	osc_24m: osc-24m {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <24000000>;
> +		clock-output-names = "osc_24m";
> +	};
> +
> +	sram1: sram@20480000 {

It does not look like you tested the DTS against bindings. Please run
`make dtbs_check W=1` (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
for instructions).

> +		compatible = "mmio-sram";
> +		reg = <0x0 0x204c0000 0x0 0x18000>;
> +	};
> +
> +	firmware {
> +		scmi {
> +			compatible = "arm,scmi";
> +			mboxes = <&mu2 5 0>, <&mu2 3 0>, <&mu2 3 1>;
> +			shmem = <&scmi_buf0>, <&scmi_buf1>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			scmi_devpd: protocol@11 {
> +				reg = <0x11>;
> +				#power-domain-cells = <1>;
> +			};
> +
> +			scmi_sys_power: protocol@12 {
> +				reg = <0x12>;
> +			};
> +
> +			scmi_perf: protocol@13 {
> +				reg = <0x13>;
> +				#clock-cells = <1>;
> +				#power-domain-cells = <1>;
> +			};
> +
> +			scmi_clk: protocol@14 {
> +				reg = <0x14>;
> +				#clock-cells = <1>;
> +			};
> +
> +			scmi_sensor: protocol@15 {
> +				reg = <0x15>;
> +				#thermal-sensor-cells = <1>;
> +			};
> +		};
> +	};
> +
> +	pmu {
> +		compatible = "arm,cortex-a55-pmu";
> +		interrupts = <GIC_PPI 7 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_HIGH)>;
> +	};
> +
> +	thermal-zones {
> +		a55 {

It does not look like you tested the DTS against bindings. Please run
`make dtbs_check W=1` (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
for instructions).

> +			polling-delay-passive = <250>;
> +			polling-delay = <2000>;
> +			thermal-sensors = <&scmi_sensor 1>;
> +
> +			trips {
> +				cpu_alert0: trip0 {
> +					temperature = <85000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				cpu_crit0: trip1 {
> +					temperature = <95000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
> +
> +			cooling-maps {
> +				map0 {
> +					trip = <&cpu_alert0>;
> +					cooling-device =
> +						<&A55_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						<&A55_1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						<&A55_2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						<&A55_3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						<&A55_4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						<&A55_5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
> +		};
> +	};
> +


> +	etm0: etm@40840000 {

It does not look like you tested the DTS against bindings. Please run
`make dtbs_check W=1` (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
for instructions).

I see you did not test it at all. No need to review. First fix all the
issues found by tooling.

This applies to all your future submissions as well. You must first run
your patches through tooling before asking people to review. Otherwise
it is huge waste of our time and quite disrespectful to that time...
> +		compatible = "arm,coresight-etm4x", "arm,primecell";
> +		reg = <0x0 0x40840000 0x0 0x10000>;
> +		arm,primecell-periphid = <0xbb95d>;
> +		cpu = <&A55_0>;
> +		clocks = <&scmi_clk IMX95_CLK_A55PERIPH>;
> +		clock-names = "apb_pclk";
> +		status = "disabled";
> +

..

> +
> +		elemu5: mailbox@47570000 {
> +			compatible = "fsl,imx95-mu-ele";
> +			reg = <0x0 0x47570000 0x0 0x10000>;
> +			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
> +			#mbox-cells = <2>;
> +			status = "disabled";
> +		};
> +
> +		v2x_mu: v2x-mu@47350000 {
> +			compatible = "fsl,imx95-mu-v2x";
> +			reg = <0x0 0x47350000 0x0 0x10000>;
> +			interrupts = <GIC_SPI 255 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "tx", "rx";
> +			#mbox-cells = <2>;
> +			status = "okay";

Why? Drop. This applies everywhere.


Best regards,
Krzysztof


