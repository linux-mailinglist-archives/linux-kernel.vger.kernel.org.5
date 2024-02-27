Return-Path: <linux-kernel+bounces-83336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D246186937C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72E3F1F20596
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05B01448C3;
	Tue, 27 Feb 2024 13:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BpTFH5np"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B331419A9;
	Tue, 27 Feb 2024 13:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709041498; cv=none; b=jrMoNu1Hkk2kwmlLlKzdSx/Y960WsRJ5yKuwt+0C8qFaI+sGdzsRE7V+QaP8gq2esOp989r2QVhBncMyQ1vsibiGf0yGSVydZi3qIBAC4PKxGB+Bxm8/s672Fm7mfmwGIPWADXVuR7tWOD71Qm/7qkd21lM39ll28mH0VzIF3ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709041498; c=relaxed/simple;
	bh=UPZNsUJYN9E994wAoevWRJNCB5jFPFI8m0dQ1K5I25w=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=JcUqVQ5+xw98vyTlA0Dlnt/IxnR0QmE2TfOXuSdUon2hSkfCHVQ4tbAYDEhHcvWyC/H1mBbj2hk/40wi0BE1Nn6+9MZ2OA0UYq7z2o0IpjUI7hbnFepv0BPNa73eq/NFaK/ED901o+eQilIF1i5cHGA7bVujQey+x9h3gByp8vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BpTFH5np; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68985C433C7;
	Tue, 27 Feb 2024 13:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709041497;
	bh=UPZNsUJYN9E994wAoevWRJNCB5jFPFI8m0dQ1K5I25w=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=BpTFH5npiGPdjFAX15Ns3qHO7gEAmnOAd9hgv/nbaTRXgF0nTuPJCZtodcC/iZXSI
	 t+IRExFpBXrUkmHami2rp5qycpahjuucv7xKnTFoEf9V/TxrK9brJeHaw/yXDOdHoM
	 zFcbaGPPr9/HWMIHGdsnPBJWCt8Plply1uL6DPzms2EUppWenOl44GV6xnvp7n820F
	 xEBDfZJzHpVc8y0wVPDrKBNGx4Ua3y3W79RdDWuChpXDkR/ZjFz8YI8hqfAoBzpFgt
	 QoZ79mUie4NuLjaans0yKLdoxE3l04VnU/DW9nOCMqd3cjSiyio5txcGxWCHkh1Mdu
	 hmmxmxYtaQ1oQ==
Date: Tue, 27 Feb 2024 07:44:56 -0600
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
Cc: Kees Cook <keescook@chromium.org>, devicetree@vger.kernel.org, 
 Bjorn Andersson <andersson@kernel.org>, robh+dt@kernel.org, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Tony Luck <tony.luck@intel.com>, 
 linux-hardening@vger.kernel.org
In-Reply-To: <20240226195516.174737-1-raihan1999ahamed@gmail.com>
References: <20240226055615.79195-1-raihan1999ahamed@gmail.com>
 <20240226195516.174737-1-raihan1999ahamed@gmail.com>
Message-Id: <170904127267.3703741.9339449368620984308.robh@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: arm: qcom: Add Lenovo P2


On Tue, 27 Feb 2024 01:24:41 +0530, Raihan Ahamed wrote:
> Document the compatible for the MSM8953-based Lenovo P2 smartphone released in 2016.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Raihan Ahamed <raihan1999ahamed@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 


My bot found new DT warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


New warnings running 'make CHECK_DTBS=y qcom/msm8953-lenovo-kuntao.dtb' for 20240226195516.174737-1-raihan1999ahamed@gmail.com:

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






