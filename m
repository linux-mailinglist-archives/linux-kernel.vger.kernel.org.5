Return-Path: <linux-kernel+bounces-144853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1598A4BCF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A077283A4B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5810B446CF;
	Mon, 15 Apr 2024 09:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Syr37wLU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908053FBB0;
	Mon, 15 Apr 2024 09:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713174440; cv=none; b=I+G0v2ztJzt7nEThaqNsFJIs9biOLfwpO9znTmjVZ59vW4LobVXDRk8yfes7RwRoCTDLEZMh90S6d5tZ3ZD0pcwhbyQBcxPwlbjMnCm2mYVhmV5+QXM/ozEMCGaxWEJT4JagqUXGXhtgZ8MC1qOGfuIkq8ihd22gLLOXXMvG8QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713174440; c=relaxed/simple;
	bh=1/IM4SD6RQjMA7f0keRrx2D+uJepsW1+KqOkX5Hx4qM=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=LvnrBd5dFTpOK1rQOt9/qodLa6B/XvpztMzT1Mv38rwKUSWplGw0bF3nFZr8/EsZrLvrD8X7nXst/vbzL+FV/OFv9ldXcn3qdXzGLTFRESnWBWZGSHKuQG1QXtC0UWJBQKNOgnuSKkGOpiUMO66lstx7AwuVnbV16pJNB8hp2PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Syr37wLU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8B9EC113CC;
	Mon, 15 Apr 2024 09:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713174440;
	bh=1/IM4SD6RQjMA7f0keRrx2D+uJepsW1+KqOkX5Hx4qM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=Syr37wLU2whncM8An2JhKAUTx3aGf/KU3btiPMYO3UcFq6l1XJm+Uk39ezKCvLhwh
	 xKn9BN/BrJ5+o9DbpMnOm0xsKz9F6mRJEqf3hL6kkYp2fFfKVblDQCbyNcxD9RjebT
	 +PORt+an85D9ovE0k0axBBF4M/B+u1e8B7bnMCcDhwfmhVjFBQsXWNbMbmW8LPaUIl
	 dQYAzphX91g2OHw/LSvgWsXdCM5e6lmW1LzOATB9iFd/AcYnpgfNzn3XG+kIYUNk6V
	 audGB83kKKy+MNtFvIHmVx+EohA2o/P4CepycjnxDJku6RKmo2937w8HAWP3O7FOmH
	 pK1wF1lUnt+Fw==
Date: Mon, 15 Apr 2024 04:47:18 -0500
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
Cc: broonie@kernel.org, alim.akhtar@samsung.com, 
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
 peter.wang@mediatek.com, conor+dt@kernel.org, avri.altman@wdc.com, 
 matthias.bgg@gmail.com, stanley.chu@mediatek.com, 
 linux-arm-kernel@lists.infradead.org, linux-scsi@vger.kernel.org, 
 bvanassche@acm.org, martin.petersen@oracle.com, lgirdwood@gmail.com, 
 chu.stanley@gmail.com, devicetree@vger.kernel.org, jejb@linux.ibm.com, 
 krzysztof.kozlowski+dt@linaro.org
In-Reply-To: <20240415075406.47543-6-angelogioacchino.delregno@collabora.com>
References: <20240415075406.47543-1-angelogioacchino.delregno@collabora.com>
 <20240415075406.47543-6-angelogioacchino.delregno@collabora.com>
Message-Id: <171317443702.1944933.10779110163028215758.robh@kernel.org>
Subject: Re: [PATCH v3 5/8] dt-bindings: ufs: mediatek,ufs: Document MT8192
 compatible with MT8183


On Mon, 15 Apr 2024 09:54:03 +0200, AngeloGioacchino Del Regno wrote:
> The MT8192 UFS controller is compatible with the MT8183 one:
> document this by allowing to assign both compatible strings
> "mediatek,mt8192-ufshci", "mediatek,mt8183-ufshci" to the UFSHCI node.
> 
> Moreover, since no MT8192 devicetree ever declared any UFSHCI node,
> disallow specifying only the MT8192 compatible.
> 
> In preparation for adding MT8195 to the mix, the MT8192 compatible
> was added as enum instead of const.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  Documentation/devicetree/bindings/ufs/mediatek,ufs.yaml | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/ufs/mediatek,ufs.example.dtb: ufs@ff3c0000: compatible:0: 'mediatek,mt8183-ufshci' is not one of ['mediatek,mt8192-ufshci']
	from schema $id: http://devicetree.org/schemas/ufs/mediatek,ufs.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/ufs/mediatek,ufs.example.dtb: ufs@ff3c0000: compatible: ['mediatek,mt8183-ufshci'] is too short
	from schema $id: http://devicetree.org/schemas/ufs/mediatek,ufs.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/ufs/mediatek,ufs.example.dtb: ufs@ff3c0000: Unevaluated properties are not allowed ('compatible' was unexpected)
	from schema $id: http://devicetree.org/schemas/ufs/mediatek,ufs.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240415075406.47543-6-angelogioacchino.delregno@collabora.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


