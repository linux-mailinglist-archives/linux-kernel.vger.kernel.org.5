Return-Path: <linux-kernel+bounces-153312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6312B8ACC54
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 128891F2420B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 11:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0259414A4CA;
	Mon, 22 Apr 2024 11:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bpEmg+5m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BCE146A9A;
	Mon, 22 Apr 2024 11:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713786628; cv=none; b=PQP8WnGsx/apw0FbyXz/pr7j1YwyWkShSq9h86M71h3/WZvNofPfCfa2Hve0qjVbsE1ECl/jxQxM42nOG2OhXfxotOcVDb3wlk0mhQZOV8xFL0a11T9bRF94AhPUCiWYIUPS6OW9Y1cxAGVWlqIcgH1GW3cnNqnK+d9xMlBcCfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713786628; c=relaxed/simple;
	bh=zIsEFBhzD+ZLEO1S9a4Cy+7IngF0zRAtRSaUbuQMgQ0=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=MPYydDTES9kHxbuKfr3f87g2h4kbnpH7plMTkrGoKtBfdSAjcdKIAJpUAdPFW7Dtxs47qqbD6j6GcG07HlWtdykpaQfwJRstAx6MIyaZqaTmDxa9puxWeEPHea2g3w4EsXePPdJCDQvpdElAJYzPjRMFdCrhtNDgUhHEl2q3c2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bpEmg+5m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74B58C32782;
	Mon, 22 Apr 2024 11:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713786627;
	bh=zIsEFBhzD+ZLEO1S9a4Cy+7IngF0zRAtRSaUbuQMgQ0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=bpEmg+5mn+onj3b66rqHoJKYf13F+mBQn6j56G+3+iyAuuian6f5TSaJcbAPMG1JX
	 h3ICYktXKg5hhzHsUobwLyzm46KYj5mn37dGf9FFoWTDdqK+lPjdhhAvKVDDOhPN4b
	 yIEc4HifqRQGw1bVR8PnS62Q7maQYpNVXDERrDhq3RmtCGKLlD4Psr7CpOe8IVeRId
	 chXylBwNAE9yPunHZywdrdU4Jabixsg0lSV58u5n0ZWZfu0RGQ3twcBvfI+6Kre1oz
	 0Nly5z40HFKG2t7ZGyopobEAg/fpFPLCxZLCZJMz0r0asFp+IwUB4vZfgCqVQB7HHe
	 Q8jhbsXjv6P4Q==
Date: Mon, 22 Apr 2024 06:50:26 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-arm-msm@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>
In-Reply-To: <20240422-topic-sm8x50-upstream-pcie-1-phy-aux-clk-v3-0-799475a27cce@linaro.org>
References: <20240422-topic-sm8x50-upstream-pcie-1-phy-aux-clk-v3-0-799475a27cce@linaro.org>
Message-Id: <171378646293.749182.6639047187760279527.robh@kernel.org>
Subject: Re: [PATCH v3 0/3] arm64: qcom-sm8[456]50: properly describe the
 PCIe Gen4x2 PHY AUX clock


On Mon, 22 Apr 2024 10:33:10 +0200, Neil Armstrong wrote:
> The PCIe Gen4x2 PHY found in the SM8[456]50 SoCs have a second clock named
> "PHY_AUX_CLK" which is an input of the Global Clock Controller (GCC) which
> is muxed & gated then returned to the PHY as an input.
> 
> Document the clock IDs to select the PIPE clock or the AUX clock,
> also enforce a second clock-output-names and a #clock-cells value of 1
> for the PCIe Gen4x2 PHY found in the SM8[456]50 SoCs.
> 
> The PHY driver needs a light refactoring to support a second clock,
> and finally the DT is changed to connect the PHY second clock to the
> corresponding GCC input then drop the dummy fixed rate clock.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
> Changes in v3:
> - Rebased on linux-next, applies now cleanly
> - Link to v2: https://lore.kernel.org/r/20240322-topic-sm8x50-upstream-pcie-1-phy-aux-clk-v2-0-3ec0a966d52f@linaro.org
> 
> Changes in v2:
> - Collected review tags
> - Switched back to of_clk_add_hw_provider/devm_add_action_or_reset to maintain compatibility
> - Tried to use generic of_clk_hw_onecell_get() but it requires to much boilerplate code
>   and would still need a local qmp_pcie_clk_hw_get() to support the current #clock-cells=0
>   when exposing 2 clocks, so it's simpler to just return the clocks in qmp_pcie_clk_hw_get()
> - Link to v1: https://lore.kernel.org/r/20240319-topic-sm8x50-upstream-pcie-1-phy-aux-clk-v1-0-926d7a4ccd80@linaro.org
> 
> ---
> Neil Armstrong (3):
>       arm64: dts: qcom: sm8450: remove pcie-1-phy-aux-clk and add pcie1_phy pcie1_phy_aux_clk
>       arm64: dts: qcom: sm8550: remove pcie-1-phy-aux-clk and add pcie1_phy pcie1_phy_aux_clk
>       arm64: dts: qcom: sm8650: remove pcie-1-phy-aux-clk and add pcie1_phy pcie1_phy_aux_clk
> 
>  arch/arm64/boot/dts/qcom/sm8450.dtsi    |  8 ++++----
>  arch/arm64/boot/dts/qcom/sm8550-hdk.dts |  4 ----
>  arch/arm64/boot/dts/qcom/sm8550-mtp.dts |  4 ----
>  arch/arm64/boot/dts/qcom/sm8550-qrd.dts |  8 --------
>  arch/arm64/boot/dts/qcom/sm8550.dtsi    | 13 ++++---------
>  arch/arm64/boot/dts/qcom/sm8650-mtp.dts |  4 ----
>  arch/arm64/boot/dts/qcom/sm8650-qrd.dts |  4 ----
>  arch/arm64/boot/dts/qcom/sm8650.dtsi    | 13 ++++---------
>  8 files changed, 12 insertions(+), 46 deletions(-)
> ---
> base-commit: f529a6d274b3b8c75899e949649d231298f30a32
> change-id: 20240319-topic-sm8x50-upstream-pcie-1-phy-aux-clk-4b35169707dd
> 
> Best regards,
> --
> Neil Armstrong <neil.armstrong@linaro.org>
> 
> 
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


New warnings running 'make CHECK_DTBS=y qcom/sm8550-hdk.dtb qcom/sm8550-mtp.dtb qcom/sm8550-qrd.dtb qcom/sm8650-mtp.dtb qcom/sm8650-qrd.dtb' for 20240422-topic-sm8x50-upstream-pcie-1-phy-aux-clk-v3-0-799475a27cce@linaro.org:

arch/arm64/boot/dts/qcom/sm8550-qrd.dtb: clock-controller@100000: clocks: [[41], [42], [43], [44, 0], [45, 0], [45, 1], [45, 2], [46, 0]] is too short
	from schema $id: http://devicetree.org/schemas/clock/qcom,sm8550-gcc.yaml#
arch/arm64/boot/dts/qcom/sm8550-qrd.dtb: clock-controller@100000: Unevaluated properties are not allowed ('clocks' was unexpected)
	from schema $id: http://devicetree.org/schemas/clock/qcom,sm8550-gcc.yaml#






