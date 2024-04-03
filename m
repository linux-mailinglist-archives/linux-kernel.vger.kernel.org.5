Return-Path: <linux-kernel+bounces-129929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A7F897226
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFB2B1F2AF8A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63C1149C67;
	Wed,  3 Apr 2024 14:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dFoE512m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECC51494DF;
	Wed,  3 Apr 2024 14:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712153753; cv=none; b=EHUtmiQ3mgfhhwQHitbu7FMavk7innk3eBEypBn4173SziggITUfJnOKzdP3JNOJ0n0c+LjTt0aTmfBCdyRsiwVx4wzioahwn8SIUmbJpZ5zOEszBhx/AzBDO0a4iu3hrp0gi0QZNHkUyWiFkmnbkGc/XIQrb2IVtr1S0DrgMjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712153753; c=relaxed/simple;
	bh=AGm142b/yVCmNmu6A99sSruEUQ1gyoAnLozRBsZbhnw=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=UZjKrhNavZVJpEeJs77du2jI2lXU+u0QMROVP/7NYObFy8KwbKLhGow1tJtEVNGMrmN2SB1TX3TgaLfHb0B/H2MZJpuapqYPozEbeVT4AmbYpQEV2OL269Qd5eSnZY6BqzXkSGzjVbv0ODK2MAHpy9PJ/S9oNKAihxKOcp1GNpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dFoE512m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4419C433C7;
	Wed,  3 Apr 2024 14:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712153752;
	bh=AGm142b/yVCmNmu6A99sSruEUQ1gyoAnLozRBsZbhnw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=dFoE512mf4xSyfoyl8WsEY8iL2nSNb9RnbGkAVd/SYvwSGSQ25QRISABTzRig6yeG
	 WHYmd77C2jCKU2sHmTkmANozc/xmzFPjFIpaxyRiGljVrX23UWfDV/gE31BqzQ+tac
	 zhjBJv/KLPP2FUR1rsje5yFVi6FQfWbChL8D1wbw9hQIk3pRx1ZeBcXSniJ0KaKN4A
	 EN71CQ05sai+593SdIAZqbsUaeUvE+DvwtOQWf2cmK3NBa9ju21J8U7RvVdiyAvqMk
	 f/OJGON/m1mP0SBG/No5EAV8NxX8n/p3gXQDjmdjFiizs82DDTeL1fVhdM7Bt2zRX3
	 ZNpHDs6qV84HA==
Date: Wed, 03 Apr 2024 09:15:51 -0500
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
Cc: devicetree@vger.kernel.org, neil.armstrong@linaro.org, 
 caleb.connolly@linaro.org, conor+dt@kernel.org, pascal.eberhard@se.com, 
 krzysztof.kozlowski+dt@linaro.org, stephan@gerhold.net, 
 linux-kernel@vger.kernel.org, benjamin.missey@non.se.com, 
 daniel.thompson@linaro.org, linux-arm-msm@vger.kernel.org, 
 andersson@kernel.org, dmitry.baryshkov@linaro.org, jimmy.lalande@se.com, 
 konrad.dybcio@linaro.org, robh+dt@kernel.org, laetitia.mariottini@se.com, 
 abdou.saker@se.com
In-Reply-To: <20240403043416.3800259-1-sumit.garg@linaro.org>
References: <20240403043416.3800259-1-sumit.garg@linaro.org>
Message-Id: <171215356255.3499051.5100972545068729440.robh@kernel.org>
Subject: Re: [PATCH v5 0/3] arm64: dts: qcom: apq8016: Add Schneider HMIBSC
 board DTS


On Wed, 03 Apr 2024 10:04:13 +0530, Sumit Garg wrote:
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
> Changes in v5:
> - Addressed another nitpick from Stephen.
> - Collected Stephen's review tag.
> - Warnings reported by Rob's DT check bot aren't related to HMIBSC
>   board DTS but rather they are due to msm8916.dtsi or extcon-usb-gpio.txt
>   still not converted to YAML format.
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
>  .../dts/qcom/apq8016-schneider-hmibsc.dts     | 491 ++++++++++++++++++
>  4 files changed, 495 insertions(+)
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


New warnings running 'make CHECK_DTBS=y qcom/apq8016-schneider-hmibsc.dtb' for 20240403043416.3800259-1-sumit.garg@linaro.org:

arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dtb: pmic@0: gpio@c000:gpio-line-names: ['USB_HUB_RESET_N_PM', 'USB_SW_SEL_PM', 'NC', 'NC'] is too short
	from schema $id: http://devicetree.org/schemas/mfd/qcom,spmi-pmic.yaml#
arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dtb: gpio@c000: gpio-line-names: ['USB_HUB_RESET_N_PM', 'USB_SW_SEL_PM', 'NC', 'NC'] is too short
	from schema $id: http://devicetree.org/schemas/pinctrl/qcom,pmic-gpio.yaml#
arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dtb: /soc@0/audio-codec@771c000: failed to match any schema with compatible: ['qcom,msm8916-wcd-digital-codec']
arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dtb: /soc@0/power-manager@b088000: failed to match any schema with compatible: ['qcom,msm8916-acc']
arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dtb: /soc@0/power-manager@b098000: failed to match any schema with compatible: ['qcom,msm8916-acc']
arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dtb: /soc@0/power-manager@b0a8000: failed to match any schema with compatible: ['qcom,msm8916-acc']
arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dtb: /soc@0/power-manager@b0b8000: failed to match any schema with compatible: ['qcom,msm8916-acc']
arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dtb: /usb-id: failed to match any schema with compatible: ['linux,extcon-usb-gpio']






