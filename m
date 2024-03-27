Return-Path: <linux-kernel+bounces-121547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B18388E998
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C2561C31040
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAED3131E27;
	Wed, 27 Mar 2024 15:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cj5/o/+b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07037130E53;
	Wed, 27 Mar 2024 15:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711554073; cv=none; b=D/u6M53GnkzxzTcGvftbzvJU2qxSDIbfFBkcCCMQ/6r7HVoIZFrxW5l9bU7HA2lWan8jjx7A7p/h5kw6L+8WCso3l79iVndTMcRpERfJRu0qFebzXqAEuiPKSH5GdDuDIxLV2QJJi54WHo72vHAUIi7hgRMXoPVRabglcfa2SWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711554073; c=relaxed/simple;
	bh=adYfPRPaAgnaF9zHKCuXMObwFPX0P5v8n8aSuJcpmQQ=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=PBfCQ78LaeEMHDcU49/CScIW0XOyDBXQjOjGcrPnMQXQpXztb3OWlJgDyd0WUscrQIHTpo2le6v9AyBteSt1B7XONwc3tX5LTnYW0VuLreWQ512fXTj3JrclJ5Wayp5DNdugN7bFfuv7JMsR1sQRtwiSxO39bfRcF9H/421NjzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cj5/o/+b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 654E1C433F1;
	Wed, 27 Mar 2024 15:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711554072;
	bh=adYfPRPaAgnaF9zHKCuXMObwFPX0P5v8n8aSuJcpmQQ=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=Cj5/o/+bnOXnQrLBgaU6cUkrj6Y1099utNdVKiwpcHSgZCbqgdtZA4VrSqbwhkh59
	 rjPirSP2fx9l+24onWBSR/DkhEzKOnBkHl0zT0+rdULWOOkDkmWQ2xWytbnZyKBH6R
	 e/vsDjagnUBBtF130I0myqCApuJ1B06snWduwskBu1RPJvAZX4sBfuVKmzOBr2o+JX
	 NayP4V4EzgdISd1O61FCfjtUfVXWS/8Q1Ae/75yL4CEuyjIdbTD9elaG7mqZ1f99kA
	 PUHLEoH8lpRMNyjgEAPlNejKWgqdEAPidSsAqhRp9M5MzWf3WG7092zxeYApGCRkp/
	 wocW8SoBMRo+w==
Date: Wed, 27 Mar 2024 10:41:11 -0500
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
Cc: krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org, 
 benjamin.missey@non.se.com, konrad.dybcio@linaro.org, 
 dmitry.baryshkov@linaro.org, neil.armstrong@linaro.org, 
 pascal.eberhard@se.com, devicetree@vger.kernel.org, andersson@kernel.org, 
 daniel.thompson@linaro.org, jimmy.lalande@se.com, conor+dt@kernel.org, 
 stephan@gerhold.net, linux-arm-msm@vger.kernel.org, 
 caleb.connolly@linaro.org, abdou.saker@se.com, linux-kernel@vger.kernel.org, 
 laetitia.mariottini@se.com
In-Reply-To: <20240327063734.3236117-1-sumit.garg@linaro.org>
References: <20240327063734.3236117-1-sumit.garg@linaro.org>
Message-Id: <171155390164.3454213.14779164019451021567.robh@kernel.org>
Subject: Re: [PATCH v4 0/3] arm64: dts: qcom: apq8016: Add Schneider HMIBSC
 board DTS


On Wed, 27 Mar 2024 12:07:31 +0530, Sumit Garg wrote:
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
> Changes in v4:
> - Dropped IRQ_TYPE_EDGE_FALLING for pm8916_resin given the expectations
>   of Linux kernel driver. Instead depend on systemd workaround suggested
>   by Caleb to get expected HMIBSC reset behaviour.
> - Incorporated further DT coding style comments from Stephen.
> - Warnings reported by Rob's DT check bot aren't related to HMIBSC
>   board DTS but rather they are due to msm8916.dtsi or extcon-usb-gpio.txt
>   still not converted to YAML format.
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
>  .../dts/qcom/apq8016-schneider-hmibsc.dts     | 490 ++++++++++++++++++
>  4 files changed, 494 insertions(+)
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


New warnings running 'make CHECK_DTBS=y qcom/apq8016-schneider-hmibsc.dtb' for 20240327063734.3236117-1-sumit.garg@linaro.org:

arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dtb: /soc@0/audio-codec@771c000: failed to match any schema with compatible: ['qcom,msm8916-wcd-digital-codec']
arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dtb: /soc@0/power-manager@b088000: failed to match any schema with compatible: ['qcom,msm8916-acc']
arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dtb: /soc@0/power-manager@b098000: failed to match any schema with compatible: ['qcom,msm8916-acc']
arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dtb: /soc@0/power-manager@b0a8000: failed to match any schema with compatible: ['qcom,msm8916-acc']
arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dtb: /soc@0/power-manager@b0b8000: failed to match any schema with compatible: ['qcom,msm8916-acc']
arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dtb: /usb-id: failed to match any schema with compatible: ['linux,extcon-usb-gpio']






