Return-Path: <linux-kernel+bounces-119770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF9C88CCD1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9A7D328777
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4AA481A3;
	Tue, 26 Mar 2024 19:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qy0V3mfP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D886913CAA0;
	Tue, 26 Mar 2024 19:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711480325; cv=none; b=JBZzguvOCDPmWGp428T7gI9CfsZ0y0f+oVUk8j6xzjWSzT5ViQD0UvF5CBjdqXpiOtGLJoSHpuSJ7InHEkcEMLc/I2DcHbAz0Z+HA/axjJz+wHLeNjxrul5+cUhyMNGi9JomA+jr37Fd8LNGbCtoxNVMyTmiHSy5wQ9VKWHfcuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711480325; c=relaxed/simple;
	bh=r7A8UhBAZMQRKdSkLqXqxInqIJpvVLlrAu8hcUy+4xs=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=JhsqnSu6V9Dct4R+OrUGIq2oM3FqV3IUQvBK34xQrKBjsA2J10r4DvT5ditcALxYonwbJsJ595tP4VEQZ3MMp8Mw5vjmZelC6mOWB/1ZQs8aQhfocxpoAHIqUfU0RkP/gqm/BnGCpYMhl9iCi0qvtvcrw0zLJFAkcSlgOk8NJIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qy0V3mfP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4567AC433A6;
	Tue, 26 Mar 2024 19:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711480324;
	bh=r7A8UhBAZMQRKdSkLqXqxInqIJpvVLlrAu8hcUy+4xs=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=Qy0V3mfPZguVh4nEhAJTVFMlkuVJcnui/QskwNfYjzLDBFZp0EXqgCKtoYxAM+d9u
	 7N9EHTkDrKnYFM92g7s5ZGaxIeG+GCa8IiF/5ZBnYmuKgVCl9JP2QyF0NPk+u/EjU5
	 X2bgcr9dXP7nASYJ4UYLaOluIXDvoitohDkZHdGqeZ6sU0mwxcsLHtChq3ov7DnXud
	 jymKDy427V3mUwrUbPkGdA3HDZw3torUDn/3OVZykCYorZiKGJ0hjalLZsbWlXo62b
	 jE7oMzSoUUtXF0S2lAaknipnbjwLt3YG7j7GjKOkQDeDwWpfOQyRBMyaenKV9BtnA+
	 uteNxATNQjSgQ==
Date: Tue, 26 Mar 2024 14:12:03 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Gabor Juhos <j4g8y7@gmail.com>
Cc: devicetree@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Conor Dooley <conor.dooley@microchip.com>, linux-arm-msm@vger.kernel.org, 
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>
In-Reply-To: <20240326-archer-ax55-v1-v4-0-dc5b54a4bb00@gmail.com>
References: <20240326-archer-ax55-v1-v4-0-dc5b54a4bb00@gmail.com>
Message-Id: <171148006675.3222706.1993091559957014299.robh@kernel.org>
Subject: Re: [PATCH v4 0/2] arm64: add minimal boot support for TP-Link
 Archer AX55 v1


On Tue, 26 Mar 2024 15:52:26 +0100, Gabor Juhos wrote:
> The purpose of this series to add minimal boot support for the
> TP-Link Archer AX55 v1 dual-band wireless router.
> 
> There are two patches:
>   - the first one adds the compatible for the board into the dt-bindings
>     documentation,
>   - the second patch introduces a minimal device tree source which can be
>     used for booting initramfs images
> 
> ---
> Changes in v4:
>   - change patch 2/2 to use new LED_FUNCTION_* definitions introduced
>     in v6.9-rc1
>   - rebase on top of v6.9-rc1
>   - Link to v3: https://lore.kernel.org/r/20240313-archer-ax55-v1-v3-0-cd9402efab59@gmail.com
> 
> Changes in v3:
>   - change pin configuration to use "gpio20" and "gpio21" for UART pins
>     in patch 2/2
>   - rebase on top of v6.8
>   - Link to v2: https://lore.kernel.org/r/20240226-archer-ax55-v1-v2-0-3776eb61f432@gmail.com
> 
> Changes in v2:
>   - reorder pin configuration properties in patch 2/2
>   - add 'Acked-by' tag to patch 1/2
>   - Link to v1: https://lore.kernel.org/r/20240223-archer-ax55-v1-v1-0-99f8fa2c3858@gmail.com
> 
> ---
> Gabor Juhos (2):
>       dt-bindings: arm: qcom: add TP-Link Archer AX55 v1
>       arm64: dts: qcom: add TP-Link Archer AX55 v1
> 
>  Documentation/devicetree/bindings/arm/qcom.yaml    |   1 +
>  arch/arm64/boot/dts/qcom/Makefile                  |   1 +
>  .../dts/qcom/ipq5018-tplink-archer-ax55-v1.dts     | 128 +++++++++++++++++++++
>  3 files changed, 130 insertions(+)
> ---
> base-commit: b55a22fa35e9d4e07d3ee6ab2557a41c2711433b
> change-id: 20240221-archer-ax55-v1-73ed91a97c6e
> 
> Best regards,
> --
> Gabor Juhos <j4g8y7@gmail.com>
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


New warnings running 'make CHECK_DTBS=y qcom/ipq5018-tplink-archer-ax55-v1.dtb' for 20240326-archer-ax55-v1-v4-0-dc5b54a4bb00@gmail.com:

arch/arm64/boot/dts/qcom/ipq5018-tplink-archer-ax55-v1.dtb: usb@8af8800: interrupts: [[0, 62, 4]] is too short
	from schema $id: http://devicetree.org/schemas/usb/qcom,dwc3.yaml#
arch/arm64/boot/dts/qcom/ipq5018-tplink-archer-ax55-v1.dtb: usb@8af8800: interrupt-names: ['hs_phy_irq'] is too short
	from schema $id: http://devicetree.org/schemas/usb/qcom,dwc3.yaml#
arch/arm64/boot/dts/qcom/ipq5018-tplink-archer-ax55-v1.dtb: usb@8af8800: interrupts: [[0, 62, 4]] is too short
	from schema $id: http://devicetree.org/schemas/usb/qcom,dwc3.yaml#
arch/arm64/boot/dts/qcom/ipq5018-tplink-archer-ax55-v1.dtb: usb@8af8800: interrupt-names:0: 'pwr_event' was expected
	from schema $id: http://devicetree.org/schemas/usb/qcom,dwc3.yaml#
arch/arm64/boot/dts/qcom/ipq5018-tplink-archer-ax55-v1.dtb: usb@8af8800: interrupt-names: ['hs_phy_irq'] is too short
	from schema $id: http://devicetree.org/schemas/usb/qcom,dwc3.yaml#






