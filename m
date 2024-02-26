Return-Path: <linux-kernel+bounces-81986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB70E867DF9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49269B30921
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584F6139574;
	Mon, 26 Feb 2024 16:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PgC41Xfe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8BE1386DD;
	Mon, 26 Feb 2024 16:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708966473; cv=none; b=T0Qjw+BL3W+qV2s+XPj+8nSb3fmFrIBx4S8yS5cy3XoO78jAw7I3B3ghiFljTWAy59z2Sb8JYpbG0NmHKq/93uKb+jOUSN/Mn96rbB7OMl+QoN/2qvqPe/ripj3Y90dxKB35CXNDpry32pNb/JZb8KZ6hAvUMZF44MltnEPGTw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708966473; c=relaxed/simple;
	bh=1BbFXI8+e/uTRBZj3bHZ1/qCl2EwN2YL4ljd8lQDGyg=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=j8CTMqn/+XZ87GuvEvUT3wjVj3D8MXj0vIu36ALVgcYOYHaL7iwyUTuXAS2WUVnAd0uN/eAYKUpCCR/y4OToXAuxtkrLckWdBoUMPlpJrZlV0//2W4f+eCOy3AzASZV2RZ7GJ9smppLzr6cFE2Wf68fH5AbVu57URAgT02GykXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PgC41Xfe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2548C433C7;
	Mon, 26 Feb 2024 16:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708966473;
	bh=1BbFXI8+e/uTRBZj3bHZ1/qCl2EwN2YL4ljd8lQDGyg=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=PgC41Xfe09R4yKk237ud4IIc4cagLva74Y/ljKHEAsDgxknMsVN7nXTEiqfi62ocv
	 JVct8HUBICbIAj1Lid0RgXmoJN7MvzFDY0PquqCZCf6pLr8JgowNXf4iRZMSWTZObr
	 pccKf121CC7bXyVtowkQFS9kpiSr2H4q9IFQzQjj9C7As9+8vlT+SOam/63KnxPyMx
	 cM4EGay1siV/Fdxo/FbyUtuIYQeWZW+LP6vIKgAVT3HX6RxfbzTjPprk6cDNEGfh7B
	 GDHesODJk6EkIwZEg5YaGsK0zkX4PToSXhFNPRuge5mmcyKrTCJv6Rg2l+yZgZuyJO
	 piFF9z4P0bLGg==
Date: Mon, 26 Feb 2024 10:54:31 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Raihan Ahamed <raihan1999ahamed@gmail.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 linux-arm-msm@vger.kernel.org, Kees Cook <keescook@chromium.org>, 
 Rob Herring <robh+dt@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
 Bjorn Andersson <andersson@kernel.org>, linux-hardening@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, devicetree@vger.kernel.org
In-Reply-To: <20240226055615.79195-1-raihan1999ahamed@gmail.com>
References: <20240226055615.79195-1-raihan1999ahamed@gmail.com>
Message-Id: <170896502279.859050.12118817690939109079.robh@kernel.org>
Subject: Re: [PATCH] arm64: dts: qcom: msm8953-lenovo-kuntao: Add initial
 device tree


On Mon, 26 Feb 2024 11:25:56 +0530, Raihan Ahamed wrote:
> Lenovo P2 is a handset using the MSM8953 SoC released in 2016
> 
> Add a device tree for with initial support for:
> 
> - GPIO keys
> - SDHCI (internal and external storage)
> - USB Device Mode
> - WCNSS (WiFi/BT)
> - Regulators
> 
> Signed-off-by: Raihan Ahamed <raihan1999ahamed@gmail.com>
> ---
>  arch/arm64/boot/dts/qcom/Makefile             |   1 +
>  .../boot/dts/qcom/msm8953-lenovo-kuntao.dts   | 240 ++++++++++++++++++
>  2 files changed, 241 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/msm8953-lenovo-kuntao.dts
> 


My bot found new DT warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


New warnings running 'make CHECK_DTBS=y qcom/msm8953-lenovo-kuntao.dtb' for 20240226055615.79195-1-raihan1999ahamed@gmail.com:

arch/arm64/boot/dts/qcom/msm8953-lenovo-kuntao.dtb: gpu@1c00000: clock-names:5: 'anyOf' conditional failed, one must be fixed:
	'core' was expected
	'iface' was expected
	'mem' was expected
	'mem_iface' was expected
	'alt_mem_iface' was expected
	'gfx3d' was expected
	'rbbmtimer' was expected
	'rbcpr' was expected
	from schema $id: http://devicetree.org/schemas/display/msm/gpu.yaml#
arch/arm64/boot/dts/qcom/msm8953-lenovo-kuntao.dtb: iommu@1c48000: compatible: 'oneOf' conditional failed, one must be fixed:
	'qcom,msm8953-iommu' is not one of ['qcom,msm8976-iommu']
	'qcom,msm-iommu-v1' was expected
	from schema $id: http://devicetree.org/schemas/iommu/qcom,iommu.yaml#






