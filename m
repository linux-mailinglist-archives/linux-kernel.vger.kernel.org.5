Return-Path: <linux-kernel+bounces-136977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E4889DA9A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 440231C211CA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF92130E21;
	Tue,  9 Apr 2024 13:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UTpuM9dC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB148130ACA;
	Tue,  9 Apr 2024 13:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712669924; cv=none; b=swP5P8ppLrxNzLVOi/Vs1I2hhj6xvO9029C04pje7+0YtDYCACErTgSKLaNNUCqTd4xUT7aDah6w2UKnhHshZuJb2qb54tyD61O7MDLidP3oWVQK2Ef3/W4WVCWIdN4aYnb8WS5u+uXmGfEBzqEL7R008yHoZ+LcEY6ZrwV68LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712669924; c=relaxed/simple;
	bh=rGTjS6fKVe64ed/94W5C9D5dL3PiTHP7iW0VeRjWj10=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=t4MKZZ8PO2I9jh52FvrpPoPYbj3iSEO+7k6zbnO4ULZGxgSKlNNI6tTrRQAdcKLJ5opu1+ZSff0CaSiQ+X6F/6KMV0qM7fHcyHDhQKrbqYHU0DkQAz3ROT8+GUrxcHLiY6qipqelbWo+6+DPQASgzFENZCSPhGP9ZDVOooABAyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UTpuM9dC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45FACC433C7;
	Tue,  9 Apr 2024 13:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712669923;
	bh=rGTjS6fKVe64ed/94W5C9D5dL3PiTHP7iW0VeRjWj10=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=UTpuM9dC94ZT5ORRqYWvfHPGL8iTb5ySc2zDiXORekj2atIZCmEXkPfO5LunA+Gvb
	 vgQy0sUR+nA90iqeSJ4Z9SzzCr5TZGvoPDLITiW4CQ1w9ws3FmkMxEF4wxFv0sA5j+
	 b/8lDCUqTS64rbd1vXc/ZMGv6Glx7xYtdNIRxYRhUQf5plac02xFl9ZSIEmWYHWka0
	 GxRUdmR8cys2NPNcLbCqC+arHuId428Mol6qgjJZI4IiyHMGmApGO3V8mcgb31V5DY
	 qrEuFUIsMLHokTDuCBMYWBwYDgSpt7n874SlpVNtwFyaSJg/+utqRUvT5O0JVlZwhN
	 4krtMoDINtyQQ==
Date: Tue, 09 Apr 2024 08:38:42 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Nikita Travkin <nikita@trvn.ru>
Cc: linux-arm-msm@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Bjorn Andersson <andersson@kernel.org>, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Ruby Iris Juric <ruby@srxl.me>, 
 =?utf-8?q?Val=C3=A9rie_Roux?= <undev@unixgirl.xyz>, 
 =?utf-8?q?Wiktor_Strz=C4=99ba=C5=82a?= <wiktorek140@gmail.com>, 
 Martijn Braam <martijn@brixit.nl>, Conor Dooley <conor+dt@kernel.org>
In-Reply-To: <20240405-msm8916-moto-init-v1-0-502b58176d34@trvn.ru>
References: <20240405-msm8916-moto-init-v1-0-502b58176d34@trvn.ru>
Message-Id: <171266958312.1032455.15219823451196031640.robh@kernel.org>
Subject: Re: [PATCH 0/4] Introduce msm8916 based Motorola devices


On Fri, 05 Apr 2024 19:06:09 +0500, Nikita Travkin wrote:
> This series introduces a set of msm8916 bsed Motorola devices:
> 
> - Moto G4 Play (harpia)
> - Moto G 2015 (osprey)
> - Moto E 2015 LTE (surnia)
> 
> The submission brings up the following features:
> 
> - eMMC and SD;
> - Buttons;
> - Touchscreen;
> - USB;
> - Fuel Gauge;
> - Sound;
> - Accelerometer (harpia only).
> 
> Since the devices share a lot of similarities, the common parts of the
> DT are separated out into a dedicated dtsi, introduced with the first
> device.
> 
> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> ---
> Martijn Braam (1):
>       arm64: dts: qcom: Add Motorola Moto G 2015 (osprey)
> 
> Nikita Travkin (1):
>       dt-bindings: arm: qcom: Add msm8916 based Motorola devices
> 
> Ruby Iris Juric (1):
>       arm64: dts: qcom: Add device tree for Motorola Moto G4 Play (harpia)
> 
> Wiktor Strzębała (1):
>       arm64: dts: qcom: Add Motorola Moto E 2015 LTE (surnia)
> 
>  Documentation/devicetree/bindings/arm/qcom.yaml    |   3 +
>  arch/arm64/boot/dts/qcom/Makefile                  |   3 +
>  .../boot/dts/qcom/msm8916-motorola-common.dtsi     | 161 +++++++++++++++++++++
>  .../boot/dts/qcom/msm8916-motorola-harpia.dts      | 147 +++++++++++++++++++
>  .../boot/dts/qcom/msm8916-motorola-osprey.dts      | 105 ++++++++++++++
>  .../boot/dts/qcom/msm8916-motorola-surnia.dts      |  83 +++++++++++
>  6 files changed, 502 insertions(+)
> ---
> base-commit: 29493ca7d6b1d3fdc224467c422ac9bdf6d7a252
> change-id: 20240405-msm8916-moto-init-640862b8f57c
> 
> Best regards,
> --
> Nikita Travkin <nikita@trvn.ru>
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


New warnings running 'make CHECK_DTBS=y qcom/msm8916-motorola-harpia.dtb qcom/msm8916-motorola-osprey.dtb qcom/msm8916-motorola-surnia.dtb' for 20240405-msm8916-moto-init-v1-0-502b58176d34@trvn.ru:

arch/arm64/boot/dts/qcom/msm8916-motorola-surnia.dtb: /soc@0/audio-codec@771c000: failed to match any schema with compatible: ['qcom,msm8916-wcd-digital-codec']
arch/arm64/boot/dts/qcom/msm8916-motorola-harpia.dtb: /soc@0/audio-codec@771c000: failed to match any schema with compatible: ['qcom,msm8916-wcd-digital-codec']
arch/arm64/boot/dts/qcom/msm8916-motorola-osprey.dtb: /soc@0/audio-codec@771c000: failed to match any schema with compatible: ['qcom,msm8916-wcd-digital-codec']
arch/arm64/boot/dts/qcom/msm8916-motorola-surnia.dtb: /soc@0/power-manager@b088000: failed to match any schema with compatible: ['qcom,msm8916-acc']
arch/arm64/boot/dts/qcom/msm8916-motorola-harpia.dtb: /soc@0/power-manager@b088000: failed to match any schema with compatible: ['qcom,msm8916-acc']
arch/arm64/boot/dts/qcom/msm8916-motorola-surnia.dtb: /soc@0/power-manager@b098000: failed to match any schema with compatible: ['qcom,msm8916-acc']
arch/arm64/boot/dts/qcom/msm8916-motorola-harpia.dtb: /soc@0/power-manager@b098000: failed to match any schema with compatible: ['qcom,msm8916-acc']
arch/arm64/boot/dts/qcom/msm8916-motorola-surnia.dtb: /soc@0/power-manager@b0a8000: failed to match any schema with compatible: ['qcom,msm8916-acc']
arch/arm64/boot/dts/qcom/msm8916-motorola-harpia.dtb: /soc@0/power-manager@b0a8000: failed to match any schema with compatible: ['qcom,msm8916-acc']
arch/arm64/boot/dts/qcom/msm8916-motorola-surnia.dtb: /soc@0/power-manager@b0b8000: failed to match any schema with compatible: ['qcom,msm8916-acc']
arch/arm64/boot/dts/qcom/msm8916-motorola-harpia.dtb: /soc@0/power-manager@b0b8000: failed to match any schema with compatible: ['qcom,msm8916-acc']
arch/arm64/boot/dts/qcom/msm8916-motorola-osprey.dtb: /soc@0/power-manager@b088000: failed to match any schema with compatible: ['qcom,msm8916-acc']
arch/arm64/boot/dts/qcom/msm8916-motorola-osprey.dtb: /soc@0/power-manager@b098000: failed to match any schema with compatible: ['qcom,msm8916-acc']
arch/arm64/boot/dts/qcom/msm8916-motorola-osprey.dtb: /soc@0/power-manager@b0a8000: failed to match any schema with compatible: ['qcom,msm8916-acc']
arch/arm64/boot/dts/qcom/msm8916-motorola-osprey.dtb: /soc@0/power-manager@b0b8000: failed to match any schema with compatible: ['qcom,msm8916-acc']
arch/arm64/boot/dts/qcom/msm8916-motorola-surnia.dtb: /usb-id: failed to match any schema with compatible: ['linux,extcon-usb-gpio']
arch/arm64/boot/dts/qcom/msm8916-motorola-harpia.dtb: /usb-id: failed to match any schema with compatible: ['linux,extcon-usb-gpio']
arch/arm64/boot/dts/qcom/msm8916-motorola-osprey.dtb: /usb-id: failed to match any schema with compatible: ['linux,extcon-usb-gpio']






