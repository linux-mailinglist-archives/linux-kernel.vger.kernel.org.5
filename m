Return-Path: <linux-kernel+bounces-117181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7392F88A86A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:09:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 742CE3220B2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C299E13A871;
	Mon, 25 Mar 2024 13:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BCIqHz2a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7B9535C9;
	Mon, 25 Mar 2024 13:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711374937; cv=none; b=Qph0oVKIDnewviTyJSSL8kjFwcIUwKCEp2+Gxe0XhZexrFCfYrklR7+K5s2CK5lHWK29Px6oX9BzeM161fmXQbUxAxpcy9hCTPkIdzJwDrg7w8b9Lm8wmR30XaoKfPSWqJbPUXJif4DW8x+7wh2LKvLfELhofg/hwusOTdSKBdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711374937; c=relaxed/simple;
	bh=KBJrko7buamvh8iloVHARutw2KLDprcA2ANvVbJ26OU=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=aeD3Rw0UKjK9KBwVDNXVmR+y3GiDYsizbI8QUzqCUN7DKYYbvxO4guuS/YqKwZqbxE3tmssGHYBsZIPIAT11NfNLNZQH6j0SJsZNbTJUvLP7Q0TH4K+iYkJfysRf8i/KDN5SH/OHEmdcNf3x9J9NrtSskHxKXOXECGO9b+DuHpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BCIqHz2a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25F23C433F1;
	Mon, 25 Mar 2024 13:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711374936;
	bh=KBJrko7buamvh8iloVHARutw2KLDprcA2ANvVbJ26OU=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=BCIqHz2alZOEkIrki/rwIh/hIOrQaqfw/p+jhC0d7yWTnoOpPdbOUXa/5HKjpLTpf
	 XPcjZyDzYsTtEe7NisYZaqLHnWeIRLhGH4HBnsFLdSDq/wF4+QAmSUjqpkeHRS88w6
	 PkYJHHTvk4hv//5qpetmQ68wwJ2MnzvFVLu2+rttqF3kqoiQpUF1n/KfaXz9IRC/Tx
	 HflsNp2VROvbTZf8cQU1UQSJ8fN+G4CgAcEX9uDmWopJ/SK58fA5FoQalMQxCzy92M
	 X/60+v6S3PKOzAbFSAH88wfojN3THLPAVpzf8XB8ZNWB4d//4L5jeoRfdjHEhW1+xt
	 xYC+KxtL3380Q==
Date: Mon, 25 Mar 2024 08:55:35 -0500
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
Cc: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, linux-arm-msm@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 linux-kernel@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
In-Reply-To: <20240325-topic-sm8650-upstream-hdk-v3-0-4f365d7932af@linaro.org>
References: <20240325-topic-sm8650-upstream-hdk-v3-0-4f365d7932af@linaro.org>
Message-Id: <171137470639.3264818.9434918263402918385.robh@kernel.org>
Subject: Re: [PATCH v3 0/3] arm64: qcom: sm8650: add support for the
 SM8650-HDK board


On Mon, 25 Mar 2024 11:26:36 +0100, Neil Armstrong wrote:
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
> Build Dependencies: None
> 
> Functional Dependencies:
> - PCIe 1 PHY AUX Clock: https://lore.kernel.org/all/20240322-topic-sm8x50-upstream-pcie-1-phy-aux-clk-v2-0-3ec0a966d52f@linaro.org/
> - PCI-MSI Fix: https://lore.kernel.org/all/20240318-pci-bdf-sid-fix-v1-3-acca6c5d9cf1@linaro.org/
> - UCSI Fix: https://lore.kernel.org/all/20240315171836.343830-1-jthies@google.com/
> - USB IRQs DT check fix: https://lore.kernel.org/all/20240314-topic-sm8650-upstream-usb-dt-irq-fix-v1-1-ea8ab2051869@linaro.org/
> 
> [1] https://www.96boards.org/specifications/
> [2] https://git.codelinaro.org/linaro/qcomlt/debugboard
> [3] https://www.lantronix.com/products/snapdragon-8-gen-3-mobile-hardware-development-kit/
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
> Changes in v3:
> - fixed regulator node name to fix ordering
> - deleted pcie_1_phy_aux clock
> - removed undeeded mdss_mdp status okay
> - collected revied & tested tags
> - Link to v2: https://lore.kernel.org/r/20240318-topic-sm8650-upstream-hdk-v2-0-b63a5d45a784@linaro.org
> 
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
>  arch/arm64/boot/dts/qcom/sm8650-hdk.dts            | 1251 ++++++++++++++++++++
>  4 files changed, 1401 insertions(+)
> ---
> base-commit: 0cd9d04a3ce7cd228d32adaf99a56708161a6b8a
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


New warnings running 'make CHECK_DTBS=y qcom/sm8650-hdk.dtb' for 20240325-topic-sm8650-upstream-hdk-v3-0-4f365d7932af@linaro.org:

arch/arm64/boot/dts/qcom/sm8650-hdk.dtb: pcie-1-phy-aux-clk: 'clock-frequency' is a required property
	from schema $id: http://devicetree.org/schemas/clock/fixed-clock.yaml#
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






