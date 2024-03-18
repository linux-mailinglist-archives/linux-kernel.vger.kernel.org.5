Return-Path: <linux-kernel+bounces-106239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7483A87EB40
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14A691F22832
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 14:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728B94EB39;
	Mon, 18 Mar 2024 14:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gF3tuGBm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75974F1E1;
	Mon, 18 Mar 2024 14:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710772987; cv=none; b=BdSOwzjmUT48YGaBv1ZfTMJN71np8Jnw1CjwvcAFzHYY3w1CH+tDbMq/RveZQTUWRg69Zkl7UpoAiWQmoQDsGQ2MmHPWhvac/ATWwZrDO/tAaQ0X1ylZ1faif1FZzjT5+FXioHxx65qtZjwmZJ5Jv+AQi1DqVDv0ZnZrTjagzAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710772987; c=relaxed/simple;
	bh=JaCgkAhfVM6lfR8kq5vHbnsRg8gQkcqTrlaPQUCs6fw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vDjBb6ABZhgwhrQ3rzwN4RSdb6ME0FxmSr6Yn71uo7kVflymRz87befVYuEizUpVsf1YJWKK2QCqloYnDKGONOhx3YtqyNOAvyf47Kk64BGx10YGyXs+6Ja4YcevTRUvg154SSudbgJo5SIYhN52pA/vkTzSwF0Yieh+BVRQwJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gF3tuGBm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88C84C433B1;
	Mon, 18 Mar 2024 14:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710772987;
	bh=JaCgkAhfVM6lfR8kq5vHbnsRg8gQkcqTrlaPQUCs6fw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gF3tuGBmesgRB+vDq5krbDQTV+zVO2YudfNVxMELx26sPEG1G5QrYdCple4zG1gRa
	 dG/Lx+L1bwKLVd390nCEWpF7BOTo6Pv56AdXGZVvwm8DQHKLh5Hf9j7DimkPPI9XsI
	 Rb12YC0POiAoX2vlx+nz5j8k+EfkuwUf52jGPN5uFQIwj+werkUdveMQE4ieTGzmZI
	 PrXzjg25sWC5iw4koCFkfo9v9mQKrCq2XVWXttAby/OEzuewmp2cgJ2GR9S3lC7Bei
	 JTJT3JxnEtU91TofPCc+H0AtSWWoBd859Ohdat7aMGppwsmclyUfXeoHfLs3ui1a45
	 5ni4wWe2E9JMQ==
Date: Mon, 18 Mar 2024 09:43:04 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Subject: Re: [PATCH v2 2/3] arm64: dts: qcom: sm8650: add support for the
 SM8650-HDK board
Message-ID: <aylnxuyqkf2ikotqwqylpvuojiwkkxgnjrjx3d2ocoo6vqngih@bfpkmov5cdg6>
References: <20240318-topic-sm8650-upstream-hdk-v2-0-b63a5d45a784@linaro.org>
 <20240318-topic-sm8650-upstream-hdk-v2-2-b63a5d45a784@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318-topic-sm8650-upstream-hdk-v2-2-b63a5d45a784@linaro.org>

On Mon, Mar 18, 2024 at 10:51:54AM +0100, Neil Armstrong wrote:
[..]
> diff --git a/arch/arm64/boot/dts/qcom/sm8650-hdk.dts b/arch/arm64/boot/dts/qcom/sm8650-hdk.dts
[..]
> +	vph_pwr: vph-pwr-regulator {
> +		compatible = "regulator-fixed";
> +
> +		regulator-name = "vph_pwr";
> +		regulator-min-microvolt = <3700000>;
> +		regulator-max-microvolt = <3700000>;
> +
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
> +	vreg_bob_3v3: regulator-vreg-bob-3v3 {

It would be nice if these nodes where sorted alphabetically.

> +		compatible = "regulator-fixed";
> +
> +		regulator-name = "VREG_BOB_3P3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +
> +		vin-supply = <&vph_pwr>;
> +	};
> +
> +	wcd939x: audio-codec {
> +		compatible = "qcom,wcd9395-codec", "qcom,wcd9390-codec";
> +
> +		pinctrl-0 = <&wcd_default>;
> +		pinctrl-names = "default";
> +
> +		qcom,micbias1-microvolt = <1800000>;
> +		qcom,micbias2-microvolt = <1800000>;
> +		qcom,micbias3-microvolt = <1800000>;
> +		qcom,micbias4-microvolt = <1800000>;
> +		qcom,mbhc-buttons-vthreshold-microvolt = <75000 150000 237000 500000 500000 500000 500000 500000>;
> +		qcom,mbhc-headset-vthreshold-microvolt = <1700000>;
> +		qcom,mbhc-headphone-vthreshold-microvolt = <50000>;
> +		qcom,rx-device = <&wcd_rx>;
> +		qcom,tx-device = <&wcd_tx>;
> +
> +		reset-gpios = <&tlmm 107 GPIO_ACTIVE_LOW>;
> +
> +		vdd-buck-supply = <&vreg_l15b_1p8>;
> +		vdd-rxtx-supply = <&vreg_l15b_1p8>;
> +		vdd-io-supply = <&vreg_l15b_1p8>;
> +		vdd-mic-bias-supply = <&vreg_bob1>;
> +
> +		#sound-dai-cells = <1>;
> +	};
> +};
[..]
> +&mdss_mdp {
> +	status = "okay";

On other platforms we left status = okay on the mdp child node, as it's
pretty rare that you want mdss okay, but mdp disabled...

> +};
> +
> +&pcie0 {
> +	wake-gpios = <&tlmm 96 GPIO_ACTIVE_HIGH>;
> +	perst-gpios = <&tlmm 94 GPIO_ACTIVE_LOW>;
> +
> +	pinctrl-0 = <&pcie0_default_state>;
> +	pinctrl-names = "default";
> +
> +	status = "okay";
> +};
> +
> +&pcie0_phy {
> +	vdda-phy-supply = <&vreg_l1i_0p88>;
> +	vdda-pll-supply = <&vreg_l3i_1p2>;
> +
> +	status = "okay";
> +};
> +
> +&pcie1 {
> +	wake-gpios = <&tlmm 99 GPIO_ACTIVE_HIGH>;
> +	perst-gpios = <&tlmm 97 GPIO_ACTIVE_LOW>;
> +
> +	pinctrl-0 = <&pcie1_default_state>;
> +	pinctrl-names = "default";
> +
> +	status = "okay";
> +};
> +
> +&pcie1_phy {
> +	vdda-phy-supply = <&vreg_l3e_0p9>;
> +	vdda-pll-supply = <&vreg_l3i_1p2>;
> +	vdda-qref-supply = <&vreg_l1i_0p88>;
> +
> +	status = "okay";
> +};
> +
> +&pcie_1_phy_aux_clk {
> +	clock-frequency = <1000>;

Is that so?

> +};
> +

Regards,
Bjorn

