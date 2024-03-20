Return-Path: <linux-kernel+bounces-109156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C41881575
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 074701C21102
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E163E56760;
	Wed, 20 Mar 2024 16:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QM6tYwDa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3845644E;
	Wed, 20 Mar 2024 16:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710951662; cv=none; b=bE+jS8dIlmUcoWhUWf1NFfYQlEkszrpKFj01odbn5xxQyvV3TLmjQNULZfgqPmBekBs0P+gO/v3beRH4cGLJiBfT1HUvGtU/5Szq2BRQ8zvjx07VD28RzNhpUOQxoUkq3QDvLwQNlLixlNacFfxDPsLv4gWLMkvAdM3xShpHTg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710951662; c=relaxed/simple;
	bh=2voymtzNKPgSxyypqQxc/DFgDi1DnnjPRI/z96JK+Fw=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=NfujP31D0r1CQXZ0S5B5ZK6HKQOxGRV51YgsQbbspy3EBZShce8fpM8/gYskx+t5gXXXvK1HgR9X5vjVnLYTIHhd8cbttTWE3ur4+X8l9rkabJDFjn2ZTkXZDG88TBckjqMc9nynBO6UxrmX9cL1SkSfQR4Cnce8YRuYQHAqBe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QM6tYwDa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B4B7C433C7;
	Wed, 20 Mar 2024 16:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710951661;
	bh=2voymtzNKPgSxyypqQxc/DFgDi1DnnjPRI/z96JK+Fw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=QM6tYwDaQHd9Iurd/HI8yyWkLo4TSp9KaujfDvMwsMu08q6LeM+qsCajsOV098RXD
	 Ea65qVBhYfxiX8mlXxrKInXjLlSBnUg/T7QUBpsAU4D6jbVfTB6IByYQ5alXfQCvqD
	 aaSLzV3Usb8xEL+4JH+/BcsfxgIVshnpEPLC9G7j5CTnnZMaR24vsoJfdmHFrRYOFD
	 tXLU1igLOnTccV/HEm1p1CfC1O4AXhMIGYWUYyhbAv2oRsKw9HyQ4RZ9Mq5v1qh7gB
	 3vSvdkfPvQ6fX7da+GCDw4fOR/MxNVXOVulEvY52M9kfIpvgI5G5+9s2DWhPojEidH
	 yzcmLl95FJdxw==
Date: Wed, 20 Mar 2024 11:21:00 -0500
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
Cc: linux-phy@lists.infradead.org, 
 Kishon Vijay Abraham I <kishon@kernel.org>, linux-arm-msm@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, linux-kernel@vger.kernel.org, 
 Vinod Koul <vkoul@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Bjorn Andersson <andersson@kernel.org>
In-Reply-To: <20240319-topic-sm8x50-upstream-pcie-1-phy-aux-clk-v1-0-926d7a4ccd80@linaro.org>
References: <20240319-topic-sm8x50-upstream-pcie-1-phy-aux-clk-v1-0-926d7a4ccd80@linaro.org>
Message-Id: <171095148652.1943238.14315576766364498217.robh@kernel.org>
Subject: Re: [PATCH 0/7] arm64: qcom-sm8[456]50: properly describe the PCIe
 Gen4x2 PHY AUX clock


On Tue, 19 Mar 2024 11:44:26 +0100, Neil Armstrong wrote:
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
> Neil Armstrong (7):
>       dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: document PHY AUX clock on SM8[456]50 SoCs
>       phy: qcom: qmp-pcie: refactor clock register code
>       phy: qcom: qmp-pcie: register second optional PHY AUX clock
>       phy: qcom: qmp-pcie: register PHY AUX clock for SM8[456]50 4x2 PCIe PHY
>       arm64: dts: qcom: sm8450: remove pcie-1-phy-aux-clk and add pcie1_phy pcie1_phy_aux_clk
>       arm64: dts: qcom: sm8550: remove pcie-1-phy-aux-clk and add pcie1_phy pcie1_phy_aux_clk
>       arm64: dts: qcom: sm8650: remove pcie-1-phy-aux-clk and add pcie1_phy pcie1_phy_aux_clk
> 
>  .../bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml   |  27 +++++-
>  arch/arm64/boot/dts/qcom/sm8450.dtsi               |   8 +-
>  arch/arm64/boot/dts/qcom/sm8550-hdk.dts            |   4 -
>  arch/arm64/boot/dts/qcom/sm8550-mtp.dts            |   4 -
>  arch/arm64/boot/dts/qcom/sm8550-qrd.dts            |   8 --
>  arch/arm64/boot/dts/qcom/sm8550.dtsi               |  13 +--
>  arch/arm64/boot/dts/qcom/sm8650-mtp.dts            |   4 -
>  arch/arm64/boot/dts/qcom/sm8650-qrd.dts            |   4 -
>  arch/arm64/boot/dts/qcom/sm8650.dtsi               |  13 +--
>  drivers/phy/qualcomm/phy-qcom-qmp-pcie.c           | 104 ++++++++++++++++++---
>  include/dt-bindings/phy/phy-qcom-qmp.h             |   4 +
>  11 files changed, 129 insertions(+), 64 deletions(-)
> ---
> base-commit: 2e93f143ca010a5013528e1cfdc895f024fe8c21
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


New warnings running 'make CHECK_DTBS=y qcom/sm8550-hdk.dtb qcom/sm8550-mtp.dtb qcom/sm8550-qrd.dtb qcom/sm8650-mtp.dtb qcom/sm8650-qrd.dtb' for 20240319-topic-sm8x50-upstream-pcie-1-phy-aux-clk-v1-0-926d7a4ccd80@linaro.org:

arch/arm64/boot/dts/qcom/sm8550-qrd.dtb: clock-controller@100000: clocks: [[41], [42], [43], [44, 0], [45, 0], [45, 1], [45, 2], [46, 0]] is too short
	from schema $id: http://devicetree.org/schemas/clock/qcom,sm8550-gcc.yaml#
arch/arm64/boot/dts/qcom/sm8550-qrd.dtb: clock-controller@100000: Unevaluated properties are not allowed ('clocks' was unexpected)
	from schema $id: http://devicetree.org/schemas/clock/qcom,sm8550-gcc.yaml#






