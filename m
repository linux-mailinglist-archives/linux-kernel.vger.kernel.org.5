Return-Path: <linux-kernel+bounces-104598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FF387D0B1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 16:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E809A1F24110
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 15:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EBB74CE1B;
	Fri, 15 Mar 2024 15:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y78+5BAi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E854CB28;
	Fri, 15 Mar 2024 15:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710517849; cv=none; b=c/flcEJqfnYFc/cSj5TyHF+/zVCVPP/MyH+qdL3A1KEaK37CwA8yleB/B3vtpw3owkwf4I+WHM3OHTfgkq6UXxnYuEu2Gnv17xyJpGDJ9VLUhyctm/aW5RyveE48ZKl+pDPKUxBQKNfUKrOF33hUWlAAH6cbHkNoUbyDlBBQGKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710517849; c=relaxed/simple;
	bh=5vC/kvCpA1Nhw+acrnEBDIJ2Ao2icl642LalVRfo+yI=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=O9HiejstZFGhLV3ZOxfzPDRcBLYb7qbJhuP+gM+hi+BJ5GFoxO37sJ9gMGZaaWSwhKq7XA8VPHlmTryL4HMydbsBaeXPoaAv4sv933m1kLu5F9RmfM5D6bgpKsRnspLbiYevALcgVbpLIKem5O86qALJnSWWy8lWn+04CfFOZQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y78+5BAi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E842C433C7;
	Fri, 15 Mar 2024 15:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710517849;
	bh=5vC/kvCpA1Nhw+acrnEBDIJ2Ao2icl642LalVRfo+yI=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=Y78+5BAiLGZxR2No77opChV/R77eO+L8SB+1Kn3gxIhBKLm2BAsM5t8XHVOUDWd22
	 LiNaTCzyo9+gyeKJENGRffoTcrf+LBsHkpi1KDmvofuLN3P+qvUAUuEPs6fyilxmKS
	 oOwoThSiHw6hgXVzhR6Hsd4Yakay45kvApwn1X482+EWf+PK9BGZTybeh1ucvK8x9T
	 coUb79T3cZdhBWY3J3plIz81ozo1F4/T7X7bLuJIPYzFLipF02wsZz8GVx4gdeKkwO
	 t3aQ41Ui7kya+Hh8l5Dwyk18Xm9yh7ekEPhXTrnkjDg18pE8JHBXBWaE5DmSZFbRSE
	 KQ85oKBeyuBhw==
Date: Fri, 15 Mar 2024 09:50:48 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: pascal.eberhard@se.com, jimmy.lalande@se.com, 
 linux-kernel@vger.kernel.org, abdou.saker@se.com, conor+dt@kernel.org, 
 laetitia.mariottini@se.com, stephan@gerhold.net, robh+dt@kernel.org, 
 neil.armstrong@linaro.org, devicetree@vger.kernel.org, andersson@kernel.org, 
 daniel.thompson@linaro.org, caleb.connolly@linaro.org, 
 linux-arm-msm@vger.kernel.org, konrad.dybcio@linaro.org, 
 benjamin.missey@non.se.com, dmitry.baryshkov@linaro.org, 
 krzysztof.kozlowski+dt@linaro.org
In-Reply-To: <20240315060707.471248-1-sumit.garg@linaro.org>
References: <20240315060707.471248-1-sumit.garg@linaro.org>
Message-Id: <171051664299.1380117.15860712289809679173.robh@kernel.org>
Subject: Re: [PATCH v3 0/3] arm64: dts: qcom: apq8016: Add Schneider HMIBSC
 board DTS


On Fri, 15 Mar 2024 11:37:04 +0530, Sumit Garg wrote:
> Add Schneider Electric HMIBSC board DTS. The HMIBSC board is an IIoT Edge
> Box Core board based on the Qualcomm APQ8016E SoC. For more information
> refer to the product page [1].
> 
> One of the major difference from db410c is serial port where HMIBSC board
> uses UART1 as the debug console with a default RS232 mode (UART1 mode mux
> configured via gpio99 and gpio100).
> 
> Support for Schneider Electric HMIBSC. Features:
> - Qualcomm Snapdragon 410C SoC - APQ8016 (4xCortex A53, Adreno 306)
> - 1GiB RAM
> - 8GiB eMMC, SD slot
> - WiFi and Bluetooth
> - 2x Host, 1x Device USB port
> - HDMI
> - Discrete TPM2 chip over SPI
> - USB ethernet adaptors (soldered)
> 
> This series is a v2 since v1 of this DTS file has been reviewed on the
> U-Boot mailing list [2].
> 
> Changes in v3:
> - Picked up tags.
> - Fixed further DT schema warnings.
> - Configure resin/power button interrupt as falling edge.
> - Incorporate DTS coding style comments from Krzysztof and Konrad.
> 
> Changes in v2:
> - Fix DT schema warnings.
> - Incorporate suggestions from Stephan.
> - Document UART1 mode GPIOs based mux.
> 
> [1] https://www.se.com/us/en/product/HMIBSCEA53D1L0T/iiot-edge-box-core-harmony-ipc-emmc-dc-linux-tpm/
> [2] https://patchwork.ozlabs.org/project/uboot/patch/20240311111027.44577-6-sumit.garg@linaro.org/
> 
> Sumit Garg (3):
>   dt-bindings: vendor-prefixes: Add Schneider Electric
>   dt-bindings: arm: qcom: Add Schneider Electric HMIBSC board
>   arm64: dts: qcom: apq8016: Add Schneider HMIBSC board DTS
> 
>  .../devicetree/bindings/arm/qcom.yaml         |   1 +
>  .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
>  arch/arm64/boot/dts/qcom/Makefile             |   1 +
>  .../dts/qcom/apq8016-schneider-hmibsc.dts     | 510 ++++++++++++++++++
>  4 files changed, 514 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dts
> 
> --
> 2.34.1
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


New warnings running 'make CHECK_DTBS=y qcom/apq8016-schneider-hmibsc.dtb' for 20240315060707.471248-1-sumit.garg@linaro.org:

arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dtb: /soc@0/audio-codec@771c000: failed to match any schema with compatible: ['qcom,msm8916-wcd-digital-codec']
arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dtb: /soc@0/power-manager@b088000: failed to match any schema with compatible: ['qcom,msm8916-acc']
arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dtb: /soc@0/power-manager@b098000: failed to match any schema with compatible: ['qcom,msm8916-acc']
arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dtb: /soc@0/power-manager@b0a8000: failed to match any schema with compatible: ['qcom,msm8916-acc']
arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dtb: /soc@0/power-manager@b0b8000: failed to match any schema with compatible: ['qcom,msm8916-acc']
arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dtb: /usb-id: failed to match any schema with compatible: ['linux,extcon-usb-gpio']






