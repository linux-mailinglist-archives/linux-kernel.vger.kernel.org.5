Return-Path: <linux-kernel+bounces-81988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87520867D60
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DF8E1F2D140
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38F813A256;
	Mon, 26 Feb 2024 16:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sykW0ZKX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7A112EBC7;
	Mon, 26 Feb 2024 16:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708966478; cv=none; b=ZR1Duljn388AHOSAJ6/B3GvcRCjIGZFxM2gbVEuW5d8ADKyy4QhbbiIqx75wq+9peaKFazJqARvZfJ9Ww6OqZSI52HhFruVTHk9hH16JsCXCKTgSRjVkSejeuYWitVBM7hlpWvSZAw5/hZDOFprY6gPQy+ovUciHvu9Sk/OC61Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708966478; c=relaxed/simple;
	bh=ZSBYgop6Y8AnjOgbcpBlQvaeC2c8w7HULMDL6B3hV54=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=CEMhr84QrG61J52cr2ofPAQiNyhNCmqAHQYAnb9zhkxdl6PhMZwr0DPXp77F+7zXsGd+yiBnSd2IdgQSBlm9zeUYwOiD3Av3VvBG7+zWmfouiW2+gfybTYHi7phsH+MxA+T4j/6B95KjUpWYVgAywYNGE+QUHmdZKmx8XtC/Eps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sykW0ZKX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A191C433C7;
	Mon, 26 Feb 2024 16:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708966477;
	bh=ZSBYgop6Y8AnjOgbcpBlQvaeC2c8w7HULMDL6B3hV54=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=sykW0ZKXAnK9PJOS2CTHTF4vltW+0RmBuAOsKACXiv5DWOT/zVQ0+emhSdjc5FzXw
	 Ib/us1sqP8Id71an85z8ynV0tqJg7iDSZxN89xvCaeUEQnaYcfMDXteY++bSATyGXs
	 +GBVPAA+dFuGJ+RdKFrqEOJ7CMIsV4qR+ilu7edBPFpoDLWFzZOFv3vpM8xDGh8PVy
	 tpCptnT6s9o3iwOMg7MwdP8VjD2m6Ge6k6fWc+YBGHcnEpT+p/J2CAuMPR4ny1P6bV
	 n3nzMUxxZeJ6O5BA/fwltxmTsLxcMLR1MzK2coUCo3c3D29H+nssq02k9ffVhbMIlR
	 cKDhxpCaLcGTg==
Date: Mon, 26 Feb 2024 10:54:36 -0600
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
Cc: Kees Cook <keescook@chromium.org>, Rob Herring <robh+dt@kernel.org>, 
 linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
 Tony Luck <tony.luck@intel.com>, devicetree@vger.kernel.org, 
 linux-hardening@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org
In-Reply-To: <20240226094256.5736-1-raihan1999ahamed@gmail.com>
References: <a762f756-1a92-4d82-be38-098bacaf25dc@linaro.org>
 <20240226094256.5736-1-raihan1999ahamed@gmail.com>
Message-Id: <170896502334.859081.15812588010355406308.robh@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: qcom: Add Lenovo P2


On Mon, 26 Feb 2024 15:11:03 +0530, Raihan Ahamed wrote:
> Document the compatible for the MSM8953-based Lenovo P2
> 
> smartphone released in 2016
> 
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


New warnings running 'make CHECK_DTBS=y qcom/msm8953-lenovo-kuntao.dtb' for 20240226094256.5736-1-raihan1999ahamed@gmail.com:

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






