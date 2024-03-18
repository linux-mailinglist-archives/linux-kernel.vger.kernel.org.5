Return-Path: <linux-kernel+bounces-106288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B0A87EC01
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:22:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 341901C21319
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEFEB4F206;
	Mon, 18 Mar 2024 15:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O/Lx+BFJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3545C1CD3B;
	Mon, 18 Mar 2024 15:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710775343; cv=none; b=QVe++/MICt86hGC2r2EdExYZmlG6DE06i6qYxcXlTwFcfS66WLgNf3mrzEKJfmU4iV8gy56dvBgd91/6ZQEH1IkypQS7LlAgUJW6ELxdXivaqPvtcIdzBfSyOv9dkgtyLsH8Y7vEW9hN+rfwWTgoD6DgUHX84l0zPIAk/jwEcXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710775343; c=relaxed/simple;
	bh=Pm8X9+GHL3uhjeSunL8byVQe/wt5/ZgrK6SBitYJwQ8=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=jfLj6g5fRq+YrW9pJVpIHdCjXrYPlIHzHV6n2eECM4qoGt8yyQMpHlf12eAMsiICbaAL5jweExFYqrBhEQ3VHMUy8MA08imljvI9eBF36JAtP6yVmdzYLq5F4dyRS8K4bvAv3UDlxTk94HRWx+r4CH9Gut/8vHmO26qAcBR/ko4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O/Lx+BFJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE8A4C433C7;
	Mon, 18 Mar 2024 15:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710775343;
	bh=Pm8X9+GHL3uhjeSunL8byVQe/wt5/ZgrK6SBitYJwQ8=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=O/Lx+BFJiEhZA5JOLrhuwSx0lVplFQ5dOaMpZZ/39IuoxojbIYV8s1edlMtqy2uug
	 Tqm7pyBLvzcw6oh1RzAMkFsXyb95BRp4jsBpqFFQjGIQCt/cqUp1W3J9HD9XuhoTwS
	 aY6Z2/6QNJihEKh/KnGpwRwtotjCpAxqIUbsFfZTO2jYOBN/xECozY2guH1GjcdbP3
	 LaSnt+d2JVv1HkBU8ZKXv1LXlJXBqymKUB3YfBaqQPhgHzn2Ke4YVh0o+ulJQx29wO
	 i27KEUd+GSwaTRm0JAv2btMoWpJk1nCm9MBjFo6DdQFcrJIOBw3WtVKzWh/6P1Sgly
	 gf32w3EfnuhoA==
Date: Mon, 18 Mar 2024 10:22:21 -0500
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
Cc: Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, 
 Bjorn Andersson <andersson@kernel.org>, devicetree@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org
In-Reply-To: <20240318-topic-sm8650-upstream-hdk-v2-0-b63a5d45a784@linaro.org>
References: <20240318-topic-sm8650-upstream-hdk-v2-0-b63a5d45a784@linaro.org>
Message-Id: <171077500758.4030479.17208797895858042949.robh@kernel.org>
Subject: Re: [PATCH v2 0/3] arm64: qcom: sm8650: add support for the
 SM8650-HDK board


On Mon, 18 Mar 2024 10:51:52 +0100, Neil Armstrong wrote:
> The SM8650-HDK is an embedded development platforms for the
> Snapdragon 8 Gen 3 SoC aka SM8650, with the following features:
> - Qualcomm SM8650 SoC
> - 16GiB On-board LPDDR5
> - On-board WiFi 7 + Bluetooth 5.3/BLE
> - On-board UFS4.0
> - M.2 Key B+M Gen3x2 PCIe Slot
> - HDMI Output
> - USB-C Connector with DP Almode & Audio Accessory mode
> - Micro-SDCard Slot
> - Audio Jack with Playback and Microphone
> - 2 On-board Analog microphones
> - 2 On-board Speakers
> - 96Boards Compatible Low-Speed and High-Speed connectors [1]
> - For Camera, Sensors and external Display cards
> - Compatible with the Linaro Debug board [2]
> - SIM Slot for Modem
> - Debug connectors
> - 6x On-Board LEDs
> 
> An optional Display Card kit can be connected on top,
> an overlay is handled to add support for the DSI Display
> and Touch Controller.
> 
> Product Page: [3]
> 
> Dependencies: None
> 
> [1] https://www.96boards.org/specifications/
> [2] https://git.codelinaro.org/linaro/qcomlt/debugboard
> [3] https://www.lantronix.com/products/snapdragon-8-gen-3-mobile-hardware-development-kit/
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
> Changes in v2:
> - Fixed commit messages with links, and recently added product page URL
> - Swapped i2c3/i2c6 nodes
> - Moved pcie_1_phy_aux_clk under pcie1_phy
> - Removed duplicate mdp_vsync pinctrl state
> - Collected review & tested tags
> - Link to v1: https://lore.kernel.org/r/20240223-topic-sm8650-upstream-hdk-v1-0-ccca645cd901@linaro.org
> 
> ---
> Neil Armstrong (3):
>       dt-bindings: arm: qcom: Document the HDK8650 board
>       arm64: dts: qcom: sm8650: add support for the SM8650-HDK board
>       arch: arm64: dts: sm8650-hdk: add support for the Display Card overlay
> 
>  Documentation/devicetree/bindings/arm/qcom.yaml    |    1 +
>  arch/arm64/boot/dts/qcom/Makefile                  |    5 +
>  .../boot/dts/qcom/sm8650-hdk-display-card.dtso     |  144 +++
>  arch/arm64/boot/dts/qcom/sm8650-hdk.dts            | 1259 ++++++++++++++++++++
>  4 files changed, 1409 insertions(+)
> ---
> base-commit: 2e93f143ca010a5013528e1cfdc895f024fe8c21
> change-id: 20240223-topic-sm8650-upstream-hdk-e21cfd6f1de8
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


New warnings running 'make CHECK_DTBS=y qcom/sm8650-hdk.dtb' for 20240318-topic-sm8650-upstream-hdk-v2-0-b63a5d45a784@linaro.org:

arch/arm64/boot/dts/qcom/sm8650-hdk.dtb: usb@a6f8800: interrupt-names:0: 'pwr_event' was expected
	from schema $id: http://devicetree.org/schemas/usb/qcom,dwc3.yaml#
arch/arm64/boot/dts/qcom/sm8650-hdk.dtb: usb@a6f8800: interrupt-names:1: 'hs_phy_irq' was expected
	from schema $id: http://devicetree.org/schemas/usb/qcom,dwc3.yaml#
arch/arm64/boot/dts/qcom/sm8650-hdk.dtb: usb@a6f8800: interrupt-names:2: 'dp_hs_phy_irq' was expected
	from schema $id: http://devicetree.org/schemas/usb/qcom,dwc3.yaml#
arch/arm64/boot/dts/qcom/sm8650-hdk.dtb: usb@a6f8800: interrupt-names:3: 'dm_hs_phy_irq' was expected
	from schema $id: http://devicetree.org/schemas/usb/qcom,dwc3.yaml#
arch/arm64/boot/dts/qcom/sm8650-hdk.dtb: usb@a6f8800: interrupt-names: ['hs_phy_irq', 'ss_phy_irq', 'dm_hs_phy_irq', 'dp_hs_phy_irq'] is too short
	from schema $id: http://devicetree.org/schemas/usb/qcom,dwc3.yaml#






