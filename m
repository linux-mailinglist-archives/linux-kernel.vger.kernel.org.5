Return-Path: <linux-kernel+bounces-105661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF3387E238
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 03:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F5211C21026
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 02:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05471DFC7;
	Mon, 18 Mar 2024 02:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XGPD4UwM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BCF1E864;
	Mon, 18 Mar 2024 02:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710729810; cv=none; b=HOWRZwGsCmR6jVBT9KLX1Jkm+Za9HMsGCnz4FLEWg//Jg6ldFONBop+rlpoDFWKTboIkzrlWwE4Er5I2FepAOqpCYjeSb1WefzIGkD9P5115Cyhs8HOKpEZ1dled9jO6jZBB6lbqD7FYaMP7hxsKaauO+q6RQ/+ExC5lRZbmxoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710729810; c=relaxed/simple;
	bh=xuHFwmysitBPRtnk/N2gUnHljyju/ctC2IDtugOQZ/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IPh6t1AdqXUvcpR44d6P8AKJM1fpeH0xNtJI2bt2Ceu1SjDVFYGQs65em0zX7anzxCZ5CiMJonnWn2/QY5NAOa+38Fc+lxT15toQWfn+/agQdKJtL+TrRLitVAIOnywreNQR9PB/ciTh3euFmNpvO+A/R1xjcbNUfCE8VvIwzBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XGPD4UwM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1351AC433C7;
	Mon, 18 Mar 2024 02:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710729809;
	bh=xuHFwmysitBPRtnk/N2gUnHljyju/ctC2IDtugOQZ/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XGPD4UwMiwPDNsVIniys+T0NTKxPpNIlhguRaLSthnvfyLi3vqpUFLyW/1/8uRzIM
	 XYlJNVP50V9QmHk1dUzGYbLzkCGWk8V+Hz8/ahUZUtw9RhiCwpTt5IK9T0geD/pI2r
	 5pTOV5PfbMs9/T2H+BOT3GAoiG8ZkXboA/HtHwRjo8qtCXjr6ONgD+B37/YkzKsW4Q
	 3injwpcLD4ez3WGV4pxUNynitKgahTQk6zjLHCX4zKkLZ/B7vfuuy5XUujOGgFOwhU
	 OVjm/+tzqqvgpJFAKhkn1OJhA9nViwKq7BjjhxTu0BJ4zH4BbOVpROq23hFFMfPZfn
	 oMQ6vNRB3DRhw==
Date: Sun, 17 Mar 2024 21:43:27 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Anton Bambura <jenneron@postmarketos.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/6] arm64: dts: qcom: sc8180x-lenovo-flex-5g: enable
 touchscreen
Message-ID: <2tq6m75m3skcu5wlvrwpwnn53kay3pzo2aeecofxpfnll7mwqn@whtnrabrrivw>
References: <20240203191200.99185-1-jenneron@postmarketos.org>
 <20240203191200.99185-5-jenneron@postmarketos.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240203191200.99185-5-jenneron@postmarketos.org>

On Sat, Feb 03, 2024 at 09:11:58PM +0200, Anton Bambura wrote:
> Set regulators, reset gpio and delays according to ACPI tables.
> 
> Signed-off-by: Anton Bambura <jenneron@postmarketos.org>
> ---
>  .../boot/dts/qcom/sc8180x-lenovo-flex-5g.dts  | 30 ++++++++++++++++++-
>  1 file changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts b/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts
> index 6ae6cb030b70..5bf6285f905f 100644
> --- a/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts
> +++ b/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts
> @@ -271,6 +271,12 @@ vreg_l3c_1p2: ldo3 {
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
> +		vreg_l4c_3p3: ldo4 {
> +			regulator-min-microvolt = <3296000>;
> +			regulator-max-microvolt = <3304000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
>  		vreg_l10c_3p3: ldo10 {
>  			regulator-min-microvolt = <3000000>;
>  			regulator-max-microvolt = <3312000>;
> @@ -337,6 +343,12 @@ vreg_l10e_2p9: ldo10 {
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
> +		vreg_l12e_1p8: ldo12 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
>  		vreg_l16e_3p0: ldo16 {
>  			regulator-min-microvolt = <3072000>;
>  			regulator-max-microvolt = <3072000>;
> @@ -365,11 +377,19 @@ &i2c1 {
>  	touchscreen@10 {
>  		compatible = "hid-over-i2c";
>  		reg = <0x10>;
> +
>  		hid-descr-addr = <0x1>;
> +		reset-gpios = <&tlmm 54 GPIO_ACTIVE_LOW>;
> +
> +		vdd-supply = <&vreg_l4c_3p3>;
> +		vddl-supply = <&vreg_l12e_1p8>;
> +
> +		post-power-on-delay-ms = <3>;
> +		post-reset-deassert-delay-ms = <200>;

As I ran into with the X13s, post-reset-deassert-delay-ms is not an
accepted property for hid-over-i2c. I think the desired path forward is
to extend elan,ekth6915.yaml and i2c-hid-of-elan.c and hard code these
values there instead.

But I suspect you, like me, are unaware of the actual name of the
device? Perhaps it's acceptable to make something up based on the
reported product id?

Regards,
Bjorn

>  
>  		interrupts-extended = <&tlmm 122 IRQ_TYPE_LEVEL_LOW>;
>  
> -		pinctrl-0 = <&ts_int_default>;
> +		pinctrl-0 = <&ts_int_default>, <&ts_reset_default>;
>  		pinctrl-names = "default";
>  	};
>  };
> @@ -735,6 +755,14 @@ ts_int_default: ts-int-default-state {
>  		drive-strength = <2>;
>  	};
>  
> +	ts_reset_default: ts-reset-default-state {
> +		pins = "gpio54";
> +		function = "gpio";
> +
> +		bias-disable;
> +		drive-strength = <16>;
> +	};
> +
>  	usbprim_sbu_default: usbprim-sbu-state {
>  		oe-n-pins {
>  			pins = "gpio152";
> -- 
> 2.42.0
> 

