Return-Path: <linux-kernel+bounces-131164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 851DF8983F0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC72AB21B06
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 09:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C82745CB;
	Thu,  4 Apr 2024 09:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ccof+V0e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECD21E86F;
	Thu,  4 Apr 2024 09:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712222770; cv=none; b=nvrwElLh27Sz/aXhmpsOMjKb/rSPxDFirLDwOtpwqG84F0o/QEebxiITbBDVrWLLlQ/EdZw6nKitSZwmI4SJMVLyVbEylcMLODD+3nJeRNwR/jeFc9vy4UmrByrWAJgOYVpVqSf7NY2cH/BO8fcSxLIFU6OiB7a/ZtQax/HUaz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712222770; c=relaxed/simple;
	bh=LQHPeCxsTClRiQFklZkM7OeAADhg7xB3paGeP09fuNI=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=ofwvREz9iNWlfQsNSe8mzdEOAsT46YTjJkT7fAY+EGGCVuKbXkte1RJZsEuvGZC1mG78hQDopr8YsXcqdkA6YX9dgzN2lugcfBhfDcxYOrKE03cB8umtYbIwmGcFe1iGFM0qZpkDPv9TbxRdxyb2ucykKPHYLSdRxQ15b2rGVik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ccof+V0e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 799A2C433C7;
	Thu,  4 Apr 2024 09:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712222768;
	bh=LQHPeCxsTClRiQFklZkM7OeAADhg7xB3paGeP09fuNI=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=ccof+V0eEDquGLB7ROWgkSuWRHrYjTBY/0h345S8VTXnPbHvM/M0douzbdfJSnRPk
	 qHCwLS5haZtliW6qAVMI3aNB5nz/DPmhoOAvnd2wgmhUX2vkFo4JTuMg2URnq58CsC
	 VA+RZyLMGk3NUeYB8b8wqjgEG28bi1INAaazGIZ6FvmFcjYpeENlOP+u+R6ikKMFY+
	 aVwkX3SVcwmuE6JCd3dNSQDEV4tqjJQv/KZTxZBfLj/nzuqAcFNwLzxJjzPHOxlOMb
	 JQfjiZMJTpp/tY/Q2GdV3HJQMg8Zyl3tKaWDk4uYaynFUXI43i33hzOsM60SdjKJhN
	 i/uwGLI+moLyA==
Date: Thu, 04 Apr 2024 04:26:07 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: shawn.sung@mediatek.com, ck.hu@mediatek.com, 
 linux-arm-kernel@lists.infradead.org, krzysztof.kozlowski+dt@linaro.org, 
 chunkuang.hu@kernel.org, daniel@ffwll.ch, p.zabel@pengutronix.de, 
 wenst@chromium.org, matthias.bgg@gmail.com, airlied@gmail.com, 
 tzimmermann@suse.de, kernel@collabora.com, 
 maarten.lankhorst@linux.intel.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, yu-chang.lee@mediatek.com, 
 jitao.shi@mediatek.com, conor+dt@kernel.org, 
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
 mripard@kernel.org
In-Reply-To: <20240404081635.91412-3-angelogioacchino.delregno@collabora.com>
References: <20240404081635.91412-1-angelogioacchino.delregno@collabora.com>
 <20240404081635.91412-3-angelogioacchino.delregno@collabora.com>
Message-Id: <171222276632.1805081.13595219837975408757.robh@kernel.org>
Subject: Re: [PATCH v1 2/3] dt-bindings: arm: mediatek: mmsys: Add OF graph
 support for board path


On Thu, 04 Apr 2024 10:16:34 +0200, AngeloGioacchino Del Regno wrote:
> Document OF graph on MMSYS/VDOSYS: this supports up to three DDP paths
> per HW instance (so potentially up to six displays for multi-vdo SoCs).
> 
> The MMSYS or VDOSYS is always the first component in the DDP pipeline,
> so it only supports an output port with multiple endpoints - where each
> endpoint defines the starting point for one of the (currently three)
> possible hardware paths.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../bindings/arm/mediatek/mediatek,mmsys.yaml | 23 +++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml: properties:port:properties:required: ['endpoint@0'] is not of type 'object', 'boolean'
	from schema $id: http://json-schema.org/draft-07/schema#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml: properties:port:properties: 'required' should not be valid under {'$ref': '#/definitions/json-schema-prop-names'}
	hint: A json-schema keyword was found instead of a DT property name.
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml: properties:port:properties:required: ['endpoint@0'] is not of type 'object', 'boolean'
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml: ignoring, error in schema: properties: port: properties: required
Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.example.dtb: /example-0/syscon@14000000: failed to match any schema with compatible: ['mediatek,mt8173-mmsys', 'syscon']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240404081635.91412-3-angelogioacchino.delregno@collabora.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


