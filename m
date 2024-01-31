Return-Path: <linux-kernel+bounces-45755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB268435DD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 06:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AD4D284A1C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 05:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4563DBB3;
	Wed, 31 Jan 2024 05:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="GOegNALw"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32F83D550;
	Wed, 31 Jan 2024 05:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706677686; cv=none; b=kEj4d9OnP75soFeZMh4CYExMIPFBJTcUylIxUlsWluBhwF1/oN0PLLkn/sPkSTfPdDbxvZIJbrBwcwNOnt7HOxEU1Vpf6ktKTNIHvmY26K67L5lity6YjucCX4apV75mNTEdQsqueH/Hey/yTMCrOghClmW2RdJ2U1Qs8QVKcGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706677686; c=relaxed/simple;
	bh=mINAx+ldDCLQ0QVLK0x2nOlJHLu2NI/bAOmGm4d2+AQ=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=SaE4A0S7ltdK4GENcYezaboLqoKT9/8GYRzHpKA7MrgMEuYF4RnCtfzAAtNRaDHMyGC90T6Y3wCsIwe5jSeXSUBoRjzpsEklAjIfrxiFcMHSTEYm3xp47T6yMUA+LWfj8A5g1ppCSAAIX4+E6AKQBTSyvY0aZRKesrOrESKpaYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=GOegNALw; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1706677681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Us+qssCGr8QHz8vvSMbnHALHDwmXvmpX/0BFSvsEVDg=;
	b=GOegNALwbNgKp9/kXZbGM+DpeUw8qNVettMK5m0NKqrmMLdJmcOw8u6qP6+m3Mav1Qtqa6
	nqlCjEBYiXM1Rf/cihonHvm9kqNag/ROaFLPWFV+pzR58PjcsC37f6tvA79I13CYp20H0U
	1o03VNyR8BV6n+X7lHgKdn5FtC1tZ13cZKc7NHsrkTaaTShgm7/CmwNNnghdiHvpDyjapj
	c+YLFVhgfDN/ySbax+dvMJ98Dwi1DVJd8uOp6bm/GkomeJ03glPxlLqyZ/Z/AXV7gCQjnt
	LnRFdARcfKnBdaURjHFlcvFegGy+yxLKqs0wK2LTbHn+MgH5gWKklbSIgnW4hA==
Date: Wed, 31 Jan 2024 06:08:00 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Alexey Charkov <alchark@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>, Daniel Lezcano
 <daniel.lezcano@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] arm64: dts: rockchip: enable temperature driven
 fan control on Rock 5B
In-Reply-To: <20240130-rk-dts-additions-v2-2-c6222c4c78df@gmail.com>
References: <20240130-rk-dts-additions-v2-0-c6222c4c78df@gmail.com>
 <20240130-rk-dts-additions-v2-2-c6222c4c78df@gmail.com>
Message-ID: <8115ab382115f66aa01dd3d00aaae474@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Alexey,

Some notes below, please have a look.

On 2024-01-30 19:21, Alexey Charkov wrote:
> This enables thermal monitoring on Radxa Rock 5B and links the PWM
> fan as an active cooling device managed automatically by the thermal
> subsystem, with a target SoC temperature of 65C and a minimum-spin
> interval from 55C to 65C to ensure airflow when the system gets warm

I'd suggest that you replace "temperature driven fan control" with
"active cooling" in the patch subject.  More concise and reads better.

> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Alexey Charkov <alchark@gmail.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts | 34 
> ++++++++++++++++++++++++-
>  1 file changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> index a0e303c3a1dc..b485edeef876 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> @@ -52,7 +52,7 @@ led_rgb_b {
> 
>  	fan: pwm-fan {
>  		compatible = "pwm-fan";
> -		cooling-levels = <0 95 145 195 255>;
> +		cooling-levels = <0 120 150 180 210 240 255>;
>  		fan-supply = <&vcc5v0_sys>;
>  		pwms = <&pwm1 0 50000 0>;
>  		#cooling-cells = <2>;
> @@ -173,6 +173,34 @@ &cpu_l3 {
>  	cpu-supply = <&vdd_cpu_lit_s0>;
>  };
> 
> +&package_thermal {
> +	polling-delay = <1000>;
> +
> +	trips {
> +		package_fan0: package-fan0 {
> +			temperature = <55000>;
> +			hysteresis = <2000>;
> +			type = "active";
> +		};
> +		package_fan1: package-fan1 {
> +			temperature = <65000>;
> +			hysteresis = <2000>;
> +			type = "active";
> +		};
> +	};
> +
> +	cooling-maps {
> +		map0 {

Should be "map1" instead of "map0".  There's already "map0"
defined for "package_thermal" in the RK3588(s) dtsi file.

> +			trip = <&package_fan0>;
> +			cooling-device = <&fan THERMAL_NO_LIMIT 1>;
> +		};
> +		map1 {

Should be "map2" instead of "map1".

> +			trip = <&package_fan1>;
> +			cooling-device = <&fan 1 THERMAL_NO_LIMIT>;

Should be "cooling-device = <&fan 2 THERMAL_NO_LIMIT>;"
(i.e., "2 THERMAL_NO_LIMIT" instead of "1 THERMAL_NO_LIMIT").

The first fan speed is already covered by the first cooling map.
The second cooling map takes over from the second fan speed.

> +		};
> +	};
> +};
> +
>  &i2c0 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&i2c0m2_xfer>;
> @@ -731,6 +759,10 @@ regulator-state-mem {
>  	};
>  };
> 
> +&tsadc {
> +	status = "okay";
> +};
> +
>  &uart2 {
>  	pinctrl-0 = <&uart2m0_xfer>;
>  	status = "okay";

