Return-Path: <linux-kernel+bounces-104594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBFD87D0A3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 16:51:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FFDD1C222DA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 15:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D69B210E8;
	Fri, 15 Mar 2024 15:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Giu/+s4C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8868140BEE;
	Fri, 15 Mar 2024 15:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710517840; cv=none; b=XtYBvnTE/Jg4ZOKRolfajutlW+weqIgVvRtiQ6pFQzqcMR/t3SjDMDCB3NiCFAOiwvLQueQ9vppZy+kBYs18VnkMv17uulHLaB5/04DAc6ZnOwWA4pMy7XCJxnARrunRvIK5ntnvdz5n5lbRumHveM0MB4NBiOqTISPhMigxrrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710517840; c=relaxed/simple;
	bh=VneOSFVdQziyWAhbdyL3fxXJcxjyiVrgBzmL3u+gdSI=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=AKF4f+XcmH+QBIV7h1lyL8jp5ISANG3j7dlzPTCm4m2+0zqqrRgRRcTf0GhUEAjk2KGpA1aLj2l1NR2TNsfTZoswWBECAYKQ2SiMQoZ4SkcUI0MjIosKpTnozjvzTV3nG6owOBY9NodJ4LWqmF9rCQhvdiWdda+7MLU1dNvaeDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Giu/+s4C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C22D0C433C7;
	Fri, 15 Mar 2024 15:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710517839;
	bh=VneOSFVdQziyWAhbdyL3fxXJcxjyiVrgBzmL3u+gdSI=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=Giu/+s4CmKiLWHWQI3fpo3uE2TfV/UgAklMSqIXdpF1yrZR4zB+7aJ03hvGMuxr5U
	 6WR6B9y1w5knlPvvUXlAWkMmwQI1VBCMywDVqbLUXKe9J3v5QKjxiWBYigFpP7DajV
	 IE5y+YiKq/oW3i/8fHSVpxhW9d0OETBJSzh7O7TmDCqyCI41tHIhljNQtIWvHXcsJW
	 egRhJ+KG1R5FP0j4lMsHTGA5YqPlcyuzbXlqfwz9VWFmPzV84cF1TwF8O3kbijULvR
	 0Y1wIcMU+nxvZ/qgPlHq67hrVw4A1ufzEwh3DKMjMy0yfjCQL4KH3dR5a3gTCM5ict
	 oYM2HkqP53MBw==
Date: Fri, 15 Mar 2024 09:50:38 -0600
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
Cc: Bjorn Andersson <andersson@kernel.org>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, 
 Rob Herring <robh+dt@kernel.org>
In-Reply-To: <20240313-archer-ax55-v1-v3-0-cd9402efab59@gmail.com>
References: <20240313-archer-ax55-v1-v3-0-cd9402efab59@gmail.com>
Message-Id: <171051663258.1379880.507954244428830454.robh@kernel.org>
Subject: Re: [PATCH v3 0/2] arm64: add minimal boot support for TP-Link
 Archer AX55 v1


On Wed, 13 Mar 2024 19:25:38 +0100, Gabor Juhos wrote:
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
>  .../dts/qcom/ipq5018-tplink-archer-ax55-v1.dts     | 132 +++++++++++++++++++++
>  3 files changed, 134 insertions(+)
> ---
> base-commit: 0becfaedccee979a5f270647e573b52668669a4a
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


New warnings running 'make CHECK_DTBS=y qcom/ipq5018-tplink-archer-ax55-v1.dtb' for 20240313-archer-ax55-v1-v3-0-cd9402efab59@gmail.com:

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






