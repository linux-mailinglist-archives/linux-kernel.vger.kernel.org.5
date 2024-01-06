Return-Path: <linux-kernel+bounces-18736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8907A826202
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 23:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1403A1F21F08
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 22:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B547E101F0;
	Sat,  6 Jan 2024 22:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="bMlpjIHz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F199101C8;
	Sat,  6 Jan 2024 22:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1704581680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bi/9uuw0QbO+5ghXCWyrtwMbNZZbLyDpZzMphz145b0=;
	b=bMlpjIHzUH1cktNyniTdaMiRZJPB3lejcN6ljBuaiqQuwv8Dx/9UEHB/eReAwqGAZx6hpU
	waHvxdQ8f8h0AvVHSWKFBYnD3uuI+L6RPBP1+eEuhHgAx0c5nQMX5cy2ox8DrElCfb+vL+
	0R07a7U87KzwnVs+JISf6zmEdVGgo54RpKXwKF6l/4Owc972S/j0F2133C1g4IYiySCmYs
	i12ErAy9jVgP2dz8cBavQrXUY+fNiHT58esk+PFtL48WUus9RWij9g4bfJObSil8j0tYZw
	W05YdxK3PgBEWjrmwwFIYQ9Cp0Q25dcJ1MHCGqH2YDU8ozHaYuNupzSzu7wgnQ==
Date: Sat, 06 Jan 2024 23:54:39 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Alexey Charkov <alchark@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>, Sebastian Reichel
 <sebastian.reichel@collabora.com>, Cristian Ciocaltea
 <cristian.ciocaltea@collabora.com>, Christopher Obbard
 <chris.obbard@collabora.com>, =?UTF-8?Q?Tam=C3=A1s_Sz=C5=B1cs?=
 <szucst@iit.uni-miskolc.hu>, Shreeya Patel <shreeya.patel@collabora.com>,
 Kever Yang <kever.yang@rock-chips.com>, Chris Morgan
 <macromorgan@hotmail.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: enable built-in thermal monitoring
 on rk3588
In-Reply-To: <20240106222357.23835-1-alchark@gmail.com>
References: <20240106222357.23835-1-alchark@gmail.com>
Message-ID: <e0302da12345e5539583b2c96d747592@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Alexey,

Please see my comments below.

On 2024-01-06 23:23, Alexey Charkov wrote:
> Include thermal zones information in device tree for rk3588 variants
> and enable the built-in thermal sensing ADC on RADXA Rock 5B
> 
> Signed-off-by: Alexey Charkov <alchark@gmail.com>
> ---
>  .../boot/dts/rockchip/rk3588-rock-5b.dts      |   4 +
>  arch/arm64/boot/dts/rockchip/rk3588s.dtsi     | 143 ++++++++++++++++++
>  2 files changed, 147 insertions(+)
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
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> index 8aa0499f9b03..8235991e3112 100644
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
> @@ -2112,6 +2113,148 @@ tsadc: tsadc@fec00000 {
>  		status = "disabled";
>  	};
> 
> +	thermal_zones: thermal-zones {
> +		soc_thermal: soc-thermal {

It should be better to name it cpu_thermal instead.  In the end, that's 
what it is.

> +			polling-delay-passive = <20>; /* milliseconds */
> +			polling-delay = <1000>; /* milliseconds */
> +			sustainable-power = <2100>; /* milliwatts */

These three comments above are pretty much redundant.

> +
> +			thermal-sensors = <&tsadc 0>;

An empty line should be added here.

> +			trips {
> +				threshold: trip-point-0 {

It should be better to name it cpu_alert0 instead, because that's what 
other newer dtsi files already use.

> +					temperature = <75000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +				target: trip-point-1 {

It should be better to name it cpu_alert1 instead, because that's what 
other newer dtsi files already use.

> +					temperature = <85000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +				soc_crit: soc-crit {

It should be better to name it cpu_crit instead, because that's what 
other newer dtsi files already use.

> +					/* millicelsius */
> +					temperature = <115000>;
> +					/* millicelsius */

These two comments above are pretty much redundant.  It also applies to 
all other similar comments below.

> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
> +			cooling-maps {
> +				map0 {
> +					trip = <&target>;

Shouldn't &threshold (i.e. &cpu_alert0) be referenced here instead?

> +					cooling-device = <&cpu_l0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;

Shouldn't all big CPU cores be listed here instead?

> +					contribution = <1024>;
> +				};
> +				map1 {
> +					trip = <&target>;

Shouldn't &target (i.e. &cpu_alert1) be referenced here instead?

> +					cooling-device = <&cpu_b0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;

Shouldn't all little and big CPU cores be listed here instead?

> +					contribution = <1024>;
> +				};
> +				map2 {
> +					trip = <&target>;
> +					cooling-device = <&cpu_b2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +					contribution = <1024>;
> +				};

Isn't this cooling map redundant?

> +			};
> +		};
> +
> +		bigcore0_thermal: bigcore0-thermal {
> +			polling-delay-passive = <20>; /* milliseconds */
> +			polling-delay = <1000>; /* milliseconds */
> +			thermal-sensors = <&tsadc 1>;
> +
> +			trips {
> +				big0_crit: big0-crit {
> +					/* millicelsius */
> +					temperature = <115000>;
> +					/* millicelsius */
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		bigcore1_thermal: bigcore1-thermal {
> +			polling-delay-passive = <20>; /* milliseconds */
> +			polling-delay = <1000>; /* milliseconds */
> +			thermal-sensors = <&tsadc 2>;
> +
> +			trips {
> +				big1_crit: big1-crit {
> +					/* millicelsius */
> +					temperature = <115000>;
> +					/* millicelsius */
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		little_core_thermal: littlecore-thermal {
> +			polling-delay-passive = <20>; /* milliseconds */
> +			polling-delay = <1000>; /* milliseconds */
> +			thermal-sensors = <&tsadc 3>;
> +
> +			trips {
> +				little_crit: little-crit {
> +					/* millicelsius */
> +					temperature = <115000>;
> +					/* millicelsius */
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		center_thermal: center-thermal {
> +			polling-delay-passive = <20>; /* milliseconds */
> +			polling-delay = <1000>; /* milliseconds */
> +			thermal-sensors = <&tsadc 4>;
> +
> +			trips {
> +				center_crit: center-crit {
> +					/* millicelsius */
> +					temperature = <115000>;
> +					/* millicelsius */
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		gpu_thermal: gpu-thermal {
> +			polling-delay-passive = <20>; /* milliseconds */
> +			polling-delay = <1000>; /* milliseconds */
> +			thermal-sensors = <&tsadc 5>;
> +
> +			trips {
> +				gpu_crit: gpu-crit {
> +					/* millicelsius */
> +					temperature = <115000>;
> +					/* millicelsius */
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		npu_thermal: npu-thermal {
> +			polling-delay-passive = <20>; /* milliseconds */
> +			polling-delay = <1000>; /* milliseconds */
> +			thermal-sensors = <&tsadc 6>;
> +
> +			trips {
> +				npu_crit: npu-crit {
> +					/* millicelsius */
> +					temperature = <115000>;
> +					/* millicelsius */
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

