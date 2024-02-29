Return-Path: <linux-kernel+bounces-87412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4D286D416
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7A631F2670B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10CFD142904;
	Thu, 29 Feb 2024 20:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="QwTBXXpR"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617E013F421;
	Thu, 29 Feb 2024 20:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709238084; cv=none; b=gYZDS8CvTEwQmbLArSQKLtX8Rw6lxALxhU/gm/PQYEdD1JXhkaxSN3DxciGxv2/FHR7pFQBEPJAKHToUVx78Tdi4Q7Op+cXoE9MPmM8iuhjK2RzyqYeHD3rmBicexX+iJ9NweUDaGStbUbCEXyNycgnpyx2ZsOuYnV79KkUcRe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709238084; c=relaxed/simple;
	bh=ad4Xo9MJm9yoe1wbYjQOF5M7qJ37N+/8WlIJLoRbc6g=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=KgazmqWCsVljprdq2z1gbqdK24/n12c2uY8A/V6VRKVkMEG1V8yF6ySMomz2PH4+sTywnzoZHI9Nvc0V8U08RnPQLgxkdDqYA3DEpyVM6Gho7P4P9V5m5H1hYhib3zrprp4tBEJUZiCS9cNTbxRawhySx9OAfXgObZsHDEDAOO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=QwTBXXpR; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1709238079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lOoVMoAXB3VZ489hYgxOdkLWZ9rTABRB51In2ZkNqYI=;
	b=QwTBXXpR4t3xKdeNS3I1I0E5JeFrRVHhhUEy90UooX7q5QilqPpWr7+jJae9QFd+b6nY++
	nng9MSThBIhQ9Ta8mYVVmTC3dhm0fA59M+SSv2lXGCFM0NyTA1/15IAM648lg4un3rBdzt
	YME7FUvGQSijypNBPy10ss9Ih2cCIXRqf7v7lluT/nVBKc1EaY+b4TkV3EH8fbEJfTlEK+
	jxqAo2qkuHBKNXEdtROL952KgK0MsQ+u0MLsuREzeNvBPVtmmoxg/xIRz3k3mjhNMgdWUh
	YzXw22YV0dziqKyg1O0DLNhOvjLGhebI9dzkxXEgRiNrfdr9eigzjNlRGo4Qhw==
Date: Thu, 29 Feb 2024 21:21:18 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Alexey Charkov <alchark@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>, Daniel Lezcano
 <daniel.lezcano@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Chen-Yu
 Tsai <wens@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/5] arm64: dts: rockchip: enable built-in thermal
 monitoring on RK3588
In-Reply-To: <20240229-rk-dts-additions-v3-1-6afe8473a631@gmail.com>
References: <20240229-rk-dts-additions-v3-0-6afe8473a631@gmail.com>
 <20240229-rk-dts-additions-v3-1-6afe8473a631@gmail.com>
Message-ID: <a370efd768021ce1afd6ea5ce841acbb@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Alexey,

On 2024-02-29 20:26, Alexey Charkov wrote:
> Include thermal zones information in device tree for RK3588 variants.
> 
> This also enables the TSADC controller unconditionally on all boards
> to ensure that thermal protections are in place via throttling and
> emergency reset, once OPPs are added to enable CPU DVFS.
> 
> The default settings (using CRU as the emergency reset mechanism)
> should work on all boards regardless of their wiring, as CRU resets
> do not depend on any external components. Boards that have the TSHUT
> signal wired to the reset line of the PMIC may opt to switch to GPIO
> tshut mode instead (rockchip,hw-tshut-mode = <1>;)

Quite frankly, I'm still not sure that enabling this on the SoC level
is the way to go.  As I already described in detail, [4] according to
the RK3588 Hardware Design Guide v1.0 and the Rock 5B schematic, we
should actually use GPIO-based handling for the thermal runaways on
the Rock 5B.  Other boards should also be investigated individually,
and the TSADC should be enabled on a board-to-board basis.

[4] 
https://lore.kernel.org/linux-rockchip/4e7c2b5a938bd7c919b852699c951701@manjaro.org/

> It seems though that downstream kernels don't use that, even for
> those boards where the wiring allows for GPIO based tshut, such as
> Radxa Rock 5B [1], [2], [3]
> 
> [1] 
> https://github.com/radxa/kernel/blob/stable-5.10-rock5/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts#L540
> [2] 
> https://github.com/radxa/kernel/blob/stable-5.10-rock5/arch/arm64/boot/dts/rockchip/rk3588s.dtsi#L5433
> [3] https://dl.radxa.com/rock5/5b/docs/hw/radxa_rock_5b_v1423_sch.pdf
> page 11 (TSADC_SHUT_H)
> 
> Signed-off-by: Alexey Charkov <alchark@gmail.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 176 
> +++++++++++++++++++++++++++++-
>  1 file changed, 175 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> index 36b1b7acfe6a..9bf197358642 100644
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
> @@ -2225,7 +2226,180 @@ tsadc: tsadc@fec00000 {
>  		pinctrl-1 = <&tsadc_shut>;
>  		pinctrl-names = "gpio", "otpout";
>  		#thermal-sensor-cells = <1>;
> -		status = "disabled";
> +		status = "okay";
> +	};
> +
> +	thermal_zones: thermal-zones {
> +		/* sensor near the center of the SoC */
> +		package_thermal: package-thermal {
> +			polling-delay-passive = <0>;
> +			polling-delay = <0>;
> +			thermal-sensors = <&tsadc 0>;
> +
> +			trips {
> +				package_crit: package-crit {
> +					temperature = <115000>;
> +					hysteresis = <0>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		/* sensor between A76 cores 0 and 1 */
> +		bigcore0_thermal: bigcore0-thermal {
> +			polling-delay-passive = <100>;
> +			polling-delay = <0>;
> +			thermal-sensors = <&tsadc 1>;
> +
> +			trips {
> +				/* threshold to start collecting temperature
> +				 * statistics e.g. with the IPA governor
> +				 */
> +				bigcore0_alert0: bigcore0-alert0 {
> +					temperature = <75000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +				/* actual control temperature */
> +				bigcore0_alert1: bigcore0-alert1 {
> +					temperature = <85000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +				bigcore0_crit: bigcore0-crit {
> +					temperature = <115000>;
> +					hysteresis = <0>;
> +					type = "critical";
> +				};
> +			};
> +			cooling-maps {
> +				map0 {
> +					trip = <&bigcore0_alert1>;
> +					cooling-device =
> +						<&cpu_b0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						<&cpu_b1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
> +		};
> +
> +		/* sensor between A76 cores 2 and 3 */
> +		bigcore2_thermal: bigcore2-thermal {
> +			polling-delay-passive = <100>;
> +			polling-delay = <0>;
> +			thermal-sensors = <&tsadc 2>;
> +
> +			trips {
> +				/* threshold to start collecting temperature
> +				 * statistics e.g. with the IPA governor
> +				 */
> +				bigcore2_alert0: bigcore2-alert0 {
> +					temperature = <75000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +				/* actual control temperature */
> +				bigcore2_alert1: bigcore2-alert1 {
> +					temperature = <85000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +				bigcore2_crit: bigcore2-crit {
> +					temperature = <115000>;
> +					hysteresis = <0>;
> +					type = "critical";
> +				};
> +			};
> +			cooling-maps {
> +				map0 {
> +					trip = <&bigcore2_alert1>;
> +					cooling-device =
> +						<&cpu_b2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						<&cpu_b3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
> +		};
> +
> +		/* sensor between the four A55 cores */
> +		little_core_thermal: littlecore-thermal {
> +			polling-delay-passive = <100>;
> +			polling-delay = <0>;
> +			thermal-sensors = <&tsadc 3>;
> +
> +			trips {
> +				/* threshold to start collecting temperature
> +				 * statistics e.g. with the IPA governor
> +				 */
> +				littlecore_alert0: littlecore-alert0 {
> +					temperature = <75000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +				/* actual control temperature */
> +				littlecore_alert1: littlecore-alert1 {
> +					temperature = <85000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +				littlecore_crit: littlecore-crit {
> +					temperature = <115000>;
> +					hysteresis = <0>;
> +					type = "critical";
> +				};
> +			};
> +			cooling-maps {
> +				map0 {
> +					trip = <&littlecore_alert1>;
> +					cooling-device =
> +						<&cpu_l0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						<&cpu_l1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						<&cpu_l2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						<&cpu_l3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
> +		};
> +
> +		/* sensor near the PD_CENTER power domain */
> +		center_thermal: center-thermal {
> +			polling-delay-passive = <0>;
> +			polling-delay = <0>;
> +			thermal-sensors = <&tsadc 4>;
> +
> +			trips {
> +				center_crit: center-crit {
> +					temperature = <115000>;
> +					hysteresis = <0>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		gpu_thermal: gpu-thermal {
> +			polling-delay-passive = <0>;
> +			polling-delay = <0>;
> +			thermal-sensors = <&tsadc 5>;
> +
> +			trips {
> +				gpu_crit: gpu-crit {
> +					temperature = <115000>;
> +					hysteresis = <0>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		npu_thermal: npu-thermal {
> +			polling-delay-passive = <0>;
> +			polling-delay = <0>;
> +			thermal-sensors = <&tsadc 6>;
> +
> +			trips {
> +				npu_crit: npu-crit {
> +					temperature = <115000>;
> +					hysteresis = <0>;
> +					type = "critical";
> +				};
> +			};
> +		};
>  	};
> 
>  	saradc: adc@fec10000 {

