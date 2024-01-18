Return-Path: <linux-kernel+bounces-30504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B250831F8F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 20:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7D6A288A86
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 19:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740FF2E631;
	Thu, 18 Jan 2024 19:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="MlLRzmYX"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372842E401;
	Thu, 18 Jan 2024 19:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705605633; cv=none; b=mXSGgUOgo65qFfwvSfF8NUJSZlyHOun3zjKMmluVsyGQMQEqUn/2VTl6eQ3oIwBvZmKXDczjr78M3+uZPKHQqESc/IRIvSyXsGT2lOpF//LS91/MXfPg4WsUMAkYnKhMVAR5wz+VMSLa7Gna/YLsZ6Nnt/NcWK2aFrkG/CcRO5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705605633; c=relaxed/simple;
	bh=XFtCyJ15nJ3Ukf1vlMXMF+lDjLtMrWQZPiaWK6IfrgY=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=kqITra5ZQ6GkMFlsQggxLCzJQK/3W0hZ2JqImfqwEu+273LZpKQ2YxYYBhikybVbYOzt3dl74D2lxF8qGsKR+VF4qQcArWna3TE0vUW2mCGy2lfaf4SzaJUTYGHm2hTL550TMX5JrfehXJm/9kNO19+3UYwyP/m4/CkWrGBGgdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=MlLRzmYX; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1705605628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gbaiGyjUuFBv/B6T7BobR3rYeP5lnHdOhbgwwWsDHPQ=;
	b=MlLRzmYXJVZsDtFuEV0oioMp21CqTzeOtr/1cvAC8nwzaJo3PJBFGxKJP6V9D1X+Q6aH5C
	VPzeD+6Mq7jDIfDwMFNtVaM3YgMAZ0VtKD6Qt+HCbeeSNDtJm7nhxTHWtQEQAzXFkkKQz0
	sTyAYS6j8Mdo9oqK71Lq577F1ddUvJARIIziRqEewiFWbO0JOusMWdjYuL9U/gJt8Mjpt5
	UjDTL8FSyfFTeOAHOebs2rOlKSvOOW+pUqjbsx58e2gFyvv4OpQaenWdVCKIu4BBWu0Xic
	fYs5xvr9jblTMMK1i2HePVXKr1N7s96dKCE+u5hjCBcXqlR8+OknFHipiCO//g==
Date: Thu, 18 Jan 2024 20:20:28 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Alexey Charkov <alchark@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>, Sebastian Reichel
 <sebastian.reichel@collabora.com>, Cristian Ciocaltea
 <cristian.ciocaltea@collabora.com>, Christopher Obbard
 <chris.obbard@collabora.com>, =?UTF-8?Q?Tam=C3=A1s_Sz=C5=B1cs?=
 <szucst@iit.uni-miskolc.hu>, Shreeya Patel <shreeya.patel@collabora.com>,
 Kever Yang <kever.yang@rock-chips.com>, Jagan Teki <jagan@edgeble.ai>, Chris
 Morgan <macromorgan@hotmail.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: rockchip: enable built-in thermal
 monitoring on rk3588
In-Reply-To: <20240109192608.5981-1-alchark@gmail.com>
References: <20240106222357.23835-1-alchark@gmail.com>
 <20240109192608.5981-1-alchark@gmail.com>
Message-ID: <121f6c6f65efcca3ad6dbe5264563561@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-01-09 20:19, Alexey Charkov wrote:
> Include thermal zones information in device tree for rk3588 variants
> and enable the built-in thermal sensing ADC on RADXA Rock 5B
> 
> Signed-off-by: Alexey Charkov <alchark@gmail.com>
> ---
> Changes in v2:
>  - Dropped redundant comments
>  - Included all CPU cores in cooling maps
>  - Split cooling maps into more granular ones utilizing TSADC
>    channels 1-3 which measure temperature by separate CPU clusters
>    instead of channel 0 which measures the center of the SoC die
> ---
>  .../boot/dts/rockchip/rk3588-rock-5b.dts      |   4 +
>  arch/arm64/boot/dts/rockchip/rk3588s.dtsi     | 151 ++++++++++++++++++
>  2 files changed, 155 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> index a5a104131403..f9d540000de3 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> @@ -772,3 +772,7 @@ &usb_host1_ehci {
>  &usb_host1_ohci {
>  	status = "okay";
>  };
> +
> +&tsadc {
> +	status = "okay";
> +};

I keep forgetting to note that enabling it for the Rock 5B should
be performed in a separate patch.

> diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> index 8aa0499f9b03..8d54998d0ecc 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> @@ -10,6 +10,7 @@
>  #include <dt-bindings/reset/rockchip,rk3588-cru.h>
>  #include <dt-bindings/phy/phy.h>
>  #include <dt-bindings/ata/ahci.h>
> +#include <dt-bindings/thermal/thermal.h>
> 
>  / {
>  	compatible = "rockchip,rk3588";
> @@ -2112,6 +2113,156 @@ tsadc: tsadc@fec00000 {
>  		status = "disabled";
>  	};
> 
> +	thermal_zones: thermal-zones {
> +		/* sensor near the center of the whole chip */
> +		soc_thermal: soc-thermal {
> +			polling-delay-passive = <20>;
> +			polling-delay = <1000>;
> +			sustainable-power = <2100>;
> +			thermal-sensors = <&tsadc 0>;
> +
> +			trips {
> +				soc_crit: soc-crit {
> +					temperature = <115000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
> +		};

As already noted in my previous response, perhaps it whould be
better to name it package_thermal instead.  That way, it should
be more self descriptive.

> +		/* sensor between A76 cores 0 and 1 */
> +		bigcore0_thermal: bigcore0-thermal {
> +			polling-delay-passive = <20>;
> +			polling-delay = <1000>;
> +			thermal-sensors = <&tsadc 1>;
> +
> +			trips {
> +				bigcore0_alert: bigcore0-alert {
> +					temperature = <85000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +				bigcore0_crit: bigcore0-crit {
> +					temperature = <115000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};

As already noted in my previous message, perhaps another trip,
of the "hot" type, should be added here.

> +			cooling-maps {
> +				map0 {
> +					trip = <&bigcore0_alert>;
> +					cooling-device =
> +						<&cpu_b0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						<&cpu_b1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +					contribution = <1024>;
> +				};
> +			};
> +		};
> +
> +		/* sensor between A76 cores 2 and 3 */
> +		bigcore2_thermal: bigcore2-thermal {
> +			polling-delay-passive = <20>;
> +			polling-delay = <1000>;
> +			thermal-sensors = <&tsadc 2>;
> +
> +			trips {
> +				bigcore2_alert: bigcore2-alert {
> +					temperature = <85000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +				bigcore2_crit: bigcore2-crit {
> +					temperature = <115000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};

The same suggestion about one more "hot" trip applies here as well.

> +			cooling-maps {
> +				map1 {
> +					trip = <&bigcore2_alert>;
> +					cooling-device =
> +						<&cpu_b2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						<&cpu_b3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +					contribution = <1024>;
> +				};
> +			};
> +		};
> +
> +		/* sensor between the four A55 cores */
> +		little_core_thermal: littlecore-thermal {
> +			polling-delay-passive = <20>;
> +			polling-delay = <1000>;
> +			thermal-sensors = <&tsadc 3>;
> +
> +			trips {
> +				littlecore_alert: littlecore-alert {
> +					temperature = <85000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +				littlecore_crit: littlecore-crit {
> +					temperature = <115000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};

The same suggestion about one more "hot" trip applies here as well.

> +			cooling-maps {
> +				map2 {
> +					trip = <&littlecore_alert>;
> +					cooling-device =
> +						<&cpu_l0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						<&cpu_l1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						<&cpu_l2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						<&cpu_l3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +					contribution = <1024>;
> +				};
> +			};
> +		};
> +
> +		/* sensor near the PD_CENTER power domain */
> +		center_thermal: center-thermal {
> +			polling-delay-passive = <20>;
> +			polling-delay = <1000>;
> +			thermal-sensors = <&tsadc 4>;
> +
> +			trips {
> +				center_crit: center-crit {
> +					temperature = <115000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		gpu_thermal: gpu-thermal {
> +			polling-delay-passive = <20>;
> +			polling-delay = <1000>;
> +			thermal-sensors = <&tsadc 5>;
> +
> +			trips {
> +				gpu_crit: gpu-crit {
> +					temperature = <115000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		npu_thermal: npu-thermal {
> +			polling-delay-passive = <20>;
> +			polling-delay = <1000>;
> +			thermal-sensors = <&tsadc 6>;
> +
> +			trips {
> +				npu_crit: npu-crit {
> +					temperature = <115000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +	};
> +
>  	saradc: adc@fec10000 {
>  		compatible = "rockchip,rk3588-saradc";
>  		reg = <0x0 0xfec10000 0x0 0x10000>;

