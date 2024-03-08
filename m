Return-Path: <linux-kernel+bounces-97237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3930876767
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3AEE1C218DA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D9E1EB56;
	Fri,  8 Mar 2024 15:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="FMRMp4DA"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB8B15C0;
	Fri,  8 Mar 2024 15:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709911823; cv=none; b=WnN7JxATaOr8YbUtdsS9lNqunK4FE/Ag1Rg1ZMrhdVOHaJdrqr1d84Qg/2cc8/rg1J0yyVAhTjXC0W6te9yj6KpiGQcK4qelU0Ux8IgavAdKAnoql0K/iBjh+6LM3hrYi0xuBYb3Nlc1yFfyFCRKlLMUV+1Q8YLwHl2Crjc7nx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709911823; c=relaxed/simple;
	bh=1GElJX1Xw1oAZ5mV/Qo9Ld5EzCaVHoLQ4gdCY21VeAQ=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=BwcYFycRm+P4Fx4FQC0G94yZM7PGIObVjc5lXw3oF238kcRetNiRJv5epIuYeCjjsLEmzesCjQ4+MiBkL8umf5nF0Q+aBb5u3yng4UfK/W4HE7tthcmvFvhIsG+Z5pcAf6KnfmDv9d71Z2zZqxSN1rSMXDZOyGw8hjMCSSXlZvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=FMRMp4DA; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1709911811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xg1YcmdTDNEGczDED8tux3NJ6CN5mtOf9f1Wq1pu2YI=;
	b=FMRMp4DAPDc4xE88bB02SCtuoYaWHG2IANOV/F+lU4IEhdSFnF037DKFGlz63eKC4ISQlH
	U86kqpqYVrFihcEvIjVcmajELJL1gmbjdqj0aYZXvZpzaxN1iS9wWOXOKTghqLtB55GLFC
	RzGkUHg2Lr/ASWxIbPrcheZDc5raRG6UxsrtaYCygKVu6K0kTqn7HyuXv/l9xg6dmwvhVD
	eyDrjMYL83UdY47gyt87Hq0nAgBYS5W+sTpo7CCUwYG6Nap4+x/vhyi/m19yfPlzJv7PaN
	c1yRzoSEa0BmnSVaOLt0CpsCuHw9DstA+eaTwARoQgft/FEUdhi5Ylg6JD03LQ==
Date: Fri, 08 Mar 2024 16:30:10 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Quentin Schulz <foss+kernel@0leil.net>
Cc: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>, Klaus Goger
 <klaus.goger@theobroma-systems.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Quentin Schulz
 <quentin.schulz@theobroma-systems.com>
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: add regulators for PCIe on
 RK3399 Puma Haikou
In-Reply-To: <20240308-puma-diode-pu-v1-3-2b38457bcdc0@theobroma-systems.com>
References: <20240308-puma-diode-pu-v1-0-2b38457bcdc0@theobroma-systems.com>
 <20240308-puma-diode-pu-v1-3-2b38457bcdc0@theobroma-systems.com>
Message-ID: <adc58b09d99d62df2c7559657547ca29@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-03-08 13:52, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> 
> The PCIe PHY requires two regulators and are present on the SoM
> directly, while the PCIe connector also exposes 3V3 and 12V power rails
> which are available on the baseboard.
> 
> Considering that 3/4 regulators are always-on on HW level and that the
> last one depends on a regulator from the PMIC that is specified as
> always on, this commit should be purely cosmetic and no change in
> behavior is expected.
> 
> Let's add all regulators for PCIe on RK3399 Puma Haikou.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>

Looking good to me, assuming that the regulator naming follows the
labels used in the schematics.

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

> ---
>  .../arm64/boot/dts/rockchip/rk3399-puma-haikou.dts |  2 ++
>  arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi      | 26 
> ++++++++++++++++++++++
>  2 files changed, 28 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
> b/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
> index 18a98c4648eae..66ebb148bbc9a 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
> @@ -194,6 +194,8 @@ &pcie0 {
>  	num-lanes = <4>;
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pcie_clkreqn_cpm>;
> +	vpcie3v3-supply = <&vcc3v3_baseboard>;
> +	vpcie12v-supply = <&dc_12v>;
>  	status = "okay";
>  };
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
> b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
> index 2484ad2bd86fc..1113f57b09313 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
> @@ -79,6 +79,26 @@ vcc5v0_sys: vcc5v0-sys {
>  		regulator-max-microvolt = <5000000>;
>  	};
> 
> +	vcca0v9: vcca0v9-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcca0v9";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <900000>;
> +		regulator-max-microvolt = <900000>;
> +		vin-supply = <&vcc_1v8>;
> +	};
> +
> +	vcca1v8: vcca1v8-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcca1v8";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		vin-supply = <&vcc3v3_sys>;
> +	};
> +
>  	vdd_log: vdd-log {
>  		compatible = "pwm-regulator";
>  		pwms = <&pwm2 0 25000 1>;
> @@ -416,6 +436,12 @@ &io_domains {
>  	gpio1830-supply = <&vcc_1v8>;
>  };
> 
> +&pcie0 {
> +	/* PCIe PHY supplies */
> +	vpcie0v9-supply = <&vcca0v9>;
> +	vpcie1v8-supply = <&vcca1v8>;
> +};
> +
>  &pcie_clkreqn_cpm {
>  	rockchip,pins =
>  		<2 RK_PD2 RK_FUNC_GPIO &pcfg_pull_up>;

