Return-Path: <linux-kernel+bounces-137211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2775789DEF7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5FD4289F93
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E858135A79;
	Tue,  9 Apr 2024 15:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uvEJm3Ox"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95DD12FF93;
	Tue,  9 Apr 2024 15:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712676281; cv=none; b=fqGw562XNTeDFST35Gmu/PEs1+iuPv6FiGAekszsJjbMz+aFBGPeEJzX/zSjTWNXR0tcfJfs8GiNwutZGVjMrOSiGK1Oo9d0PFILtleaOuz4pjuRVJXDyGfST0epInKj/jikp/cqq2J9Q6ouLgnREQDr5VLEsDlbxTS6BSoo5fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712676281; c=relaxed/simple;
	bh=GYhUMYcuopyTTsXZocs09eC4l4ecRuEg28Z8oo3DJDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lIcjrvtsl6nrkenheP/gY7sTHb6kUL22JzhCSfFrr+NkbEiOlPh252AOWMCyubDXRQWCx1S9CXrRCc97bCfpiwA9nzZXBiZHe1DQF4eZInSyamikzt1ebcP5T38BgLfT6O1o42oNDcu90w9DzKX2fxxI5eH9d094BqiMracZqw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uvEJm3Ox; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61C5AC43390;
	Tue,  9 Apr 2024 15:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712676281;
	bh=GYhUMYcuopyTTsXZocs09eC4l4ecRuEg28Z8oo3DJDg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uvEJm3OxeJsz20Wg45vymQiE31AfCrNGbzGYu9fxvx7v25A8to4o8663gLuEQP6kc
	 D1LbChA9runpUpskT9BeY/BXUrAoHLKy/HCpG8Uw7p5/wlzYhzHbYBWg21NreDrNZ+
	 2wwxB4tTkhbuEfN4ZZRT4CSLD1d0BnrNPNDdtoW4YH1vMSqYLuYJwWdvaMCtSA11r9
	 x4WRy3D4wovEURW33pEzwp4xsbB9ZzE4BGvWDcplalEkx0L8wX7bcO2zPM9rsfOucm
	 p3zWHN0040b1J2xkM4/+gQzY++sxkv2dNdugqzT5i1YTm6BLGoMiM+4kGLNkqZWY3Q
	 4ebj7HWojvSnw==
Date: Tue, 9 Apr 2024 10:24:38 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Adam Skladowski <a39.skl@gmail.com>
Cc: phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
	Andy Gross <agross@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] arm64: dts: qcom: msm8976: Add MDSS nodes
Message-ID: <463qtzv2z4hbazjmis6xf5p7j44eafeqtpw4qb22sddeolig3i@eujjyfwqxycs>
References: <20240401172153.9231-1-a39.skl@gmail.com>
 <20240401172153.9231-3-a39.skl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240401172153.9231-3-a39.skl@gmail.com>

On Mon, Apr 01, 2024 at 07:21:51PM +0200, Adam Skladowski wrote:
> diff --git a/arch/arm64/boot/dts/qcom/msm8976.dtsi b/arch/arm64/boot/dts/qcom/msm8976.dtsi
[..]
> +		mdss: display-subsystem@1a00000 {
[..]
> +			mdss_dsi0: dsi@1a94000 {
> +				compatible = "qcom,msm8976-dsi-ctrl", "qcom,mdss-dsi-ctrl";
> +				reg = <0x01a94000 0x25c>;
> +				reg-names = "dsi_ctrl";
> +
> +				interrupt-parent = <&mdss>;
> +				interrupts = <4>;
> +
> +				clocks = <&gcc GCC_MDSS_MDP_CLK>,
> +					 <&gcc GCC_MDSS_AHB_CLK>,
> +					 <&gcc GCC_MDSS_AXI_CLK>,
> +					 <&gcc GCC_MDSS_BYTE0_CLK>,
> +					 <&gcc GCC_MDSS_PCLK0_CLK>,
> +					 <&gcc GCC_MDSS_ESC0_CLK>;
> +				clock-names = "mdp_core",
> +					      "iface",
> +					      "bus",
> +					      "byte",
> +					      "pixel",
> +					      "core";
> +
> +				assigned-clocks = <&gcc GCC_MDSS_BYTE0_CLK_SRC>,
> +						  <&gcc GCC_MDSS_PCLK0_CLK_SRC>;
> +				assigned-clock-parents = <&mdss_dsi0_phy 0>,
> +							 <&mdss_dsi0_phy 1>;
> +
> +				phys = <&mdss_dsi0_phy>;
> +
> +				operating-points-v2 = <&dsi0_opp_table>;
> +				power-domains = <&gcc MDSS_GDSC>;
> +
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +

Seems reasonable to keep this disabled as well. Further more &mdss_dsi0
depends on &mdss_dsi0_phy which is disabled.

> +				ports {
[..]
> +			mdss_dsi0_phy: phy@1a94a00 {
> +				compatible = "qcom,dsi-phy-28nm-hpm-fam-b";
> +				reg = <0x01a94a00 0xd4>,
> +				      <0x01a94400 0x280>,
> +				      <0x01a94b80 0x30>;
> +				reg-names = "dsi_pll",
> +					    "dsi_phy",
> +					    "dsi_phy_regulator";
> +
> +				#clock-cells = <1>;
> +				#phy-cells = <0>;
> +
> +				clocks = <&gcc GCC_MDSS_AHB_CLK>,
> +					 <&rpmcc RPM_SMD_XO_CLK_SRC>;
> +				clock-names = "iface", "ref";
> +
> +				status = "disabled";
> +			};

PS. Leave &mdss_mdp enabled...

Regards,
Bjorn

