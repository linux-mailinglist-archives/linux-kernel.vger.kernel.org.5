Return-Path: <linux-kernel+bounces-87579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A038C86D61E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C95E28B93D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3547D16FF43;
	Thu, 29 Feb 2024 21:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="d89LOaNK"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3486E16FF2B;
	Thu, 29 Feb 2024 21:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709241915; cv=none; b=Ja4q1vrHpfcFbFLCnkdh/DR8G00DvYKKkmDo1LPikDplABU3pbMLI98xjuJ1e1s2nt0hJWRMwMX4cQsC9vNS293pohZYyyu2fzpoekQd/8jjZjucWNo/FgX0FAlbCZYKPZIFrxCHnMFKVwrNTRJywrqUf1neKBd3EC5gk0xStzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709241915; c=relaxed/simple;
	bh=C0iUknyALwb8yx7/aULdmmyNhZJP7DOze6qzJbWn+m4=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=dgcGrZdyhdaempyqCoJnSMHJgpT9VizeUEQxpW5YMh1puIGTVIaj4yLLmwiUFaswxghQokr0n34cvaj+O1iJWajVeOQCs8sT2rCIgoJ/ycvSw4zgtsILasPbvKz654xXGlOc0MdDVTXdHlzX+FNXIAfeGIA41QGVhNCZ/e7Sgp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=d89LOaNK; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1709241911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j/jsIYQWtNjGo8V67lba+C9XsvoM+JnwriF6mpcDVn8=;
	b=d89LOaNKrX6cixjeJ68nSXNhPFchDZiqiqCu6ykaBlnJJBLl1Th/424XtWLWAYz6rkib1F
	QoVJsAfsErJ8lUaTUXUQm0/8qT21TJJ/Dsdd2bhxOYSaESaExHAg3NWj1DhdvylS0BQNVr
	M4DM9bLV3qvr6IKJ9SRsdC3Xa8rOJuosByahQbhVVLdfuVXeIdNP9pQ2J3HE0VRsWqkddO
	xeHSjmUshU1OTIkrArv7E2Hvs3G3n7GOQyx4IlKmKdoZXJSh0lyHHJ145ccFJqR+8MmqxK
	YHha/ZO91aJJ7QDn8RV+VIxajr2HymxMxxsHpMZQUzfG2cTJPmaY5GFoBN3urA==
Date: Thu, 29 Feb 2024 22:25:10 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Alexey Charkov <alchark@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>, Daniel Lezcano
 <daniel.lezcano@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Chen-Yu
 Tsai <wens@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/5] arm64: dts: rockchip: enable automatic active
 cooling on Rock 5B
In-Reply-To: <20240229-rk-dts-additions-v3-2-6afe8473a631@gmail.com>
References: <20240229-rk-dts-additions-v3-0-6afe8473a631@gmail.com>
 <20240229-rk-dts-additions-v3-2-6afe8473a631@gmail.com>
Message-ID: <823379825559bb76088c31f44f998dd3@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Alexey,

On 2024-02-29 20:26, Alexey Charkov wrote:
> This links the PWM fan on Radxa Rock 5B as an active cooling device
> managed automatically by the thermal subsystem, with a target SoC
> temperature of 65C and a minimum-spin interval from 55C to 65C to
> ensure airflow when the system gets warm

I'd suggest that you replace "automatic active cooling" with "active
cooling" in the patch subject.  I know, it may seem like more of the
unnecessary nitpicking, :) but I hope you'll agree that "automatic"
is actually redundant there.  It would also make the patch subject
a bit shorter.

Another option would be to replace "automatic active cooling" with
"automatic fan control", which may actually be a better choice.
I'd be happy with whichever one you prefer. :)

Otherwise, please feel free to add:

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

> Signed-off-by: Alexey Charkov <alchark@gmail.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts | 30 
> ++++++++++++++++++++++++-
>  1 file changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> index a0e303c3a1dc..3f7fb055c4dc 100644
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
> +		map1 {
> +			trip = <&package_fan0>;
> +			cooling-device = <&fan THERMAL_NO_LIMIT 1>;
> +		};
> +		map2 {
> +			trip = <&package_fan1>;
> +			cooling-device = <&fan 2 THERMAL_NO_LIMIT>;
> +		};
> +	};
> +};
> +
>  &i2c0 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&i2c0m2_xfer>;

