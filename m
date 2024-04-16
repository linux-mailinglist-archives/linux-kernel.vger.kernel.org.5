Return-Path: <linux-kernel+bounces-147246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F698A7180
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEECA1F2245E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE8C133284;
	Tue, 16 Apr 2024 16:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pGvdWpIV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C58131BD6;
	Tue, 16 Apr 2024 16:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713285187; cv=none; b=oLGzQWnO36IbQdG83BEYiKuWKxSnsiyIaU5QNt4XqQGOPRogUInFitFPnSHzsgfG64VugoPdZovRyuDaJaBF0tBbfz+shPs9A3i6GuBciEq7pgTeOKEIu96Oqd6UQ7NzdiqcaqDfKokiHphivBscUQFxggki8N+6N8M1SBzutRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713285187; c=relaxed/simple;
	bh=10WnQNId+Y5d5f+aR4s4gUOkQlkagdBYHfATkPI0LyI=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=MiJqpBj6yIOrUHQHHo2KymK+NW7kxjskHkybbWAcxrC2tvO95Wh7WcMPq1ZwNXnOhHMAnhLxiLSmV4+9BWnsT8+sy7+asnIDmU6kjf1epGC/oMrZZxpY5kek0VcY5zPSb24CKmKRVoCVA1KNrv7wWIAhd76NabHCUpi7bEvObCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pGvdWpIV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D243C2BD10;
	Tue, 16 Apr 2024 16:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713285187;
	bh=10WnQNId+Y5d5f+aR4s4gUOkQlkagdBYHfATkPI0LyI=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=pGvdWpIVXlbCicg6uf72xABxgaKkoNZ8cfAv19WxMB6ZBawWZrDCSUfksff3Saqmm
	 ix9GTX9QME7c1kK+FHpxlQu+BJgcqhvtelEvJt5T12oiMOKDf/vyNyrsjN/sPqLCQP
	 Jt6D3yRuj3j8niO44bBrOQF/LWRlgcSGwFLdhZCqbuzthaMS7/a6uD3h4eXN17ujcg
	 WgGI1TBAwHLRT6avrhmyfgEBcUU3Bgx+mvRPn6aOVqq2+B2ns7QIVxMO/XC6g/YJQd
	 Nq8qNXdyW7+PziEFFBewiAhG9W848P2r0ejDxQXpu8RO8ouNTm1oq7EH+G2/BFPEiy
	 X8EnERjZABDfg==
Date: Tue, 16 Apr 2024 11:33:06 -0500
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
Cc: keescook@chromium.org, gustavoars@kernel.org, 
 devicetree@vger.kernel.org, djakov@kernel.org, henryc.chen@mediatek.com, 
 linux-pm@vger.kernel.org, wenst@chromium.org, 
 linux-arm-kernel@lists.infradead.org, amergnat@baylibre.com, 
 matthias.bgg@gmail.com, lgirdwood@gmail.com, 
 krzysztof.kozlowski+dt@linaro.org, linux-mediatek@lists.infradead.org, 
 kernel@collabora.com, linux-kernel@vger.kernel.org, conor+dt@kernel.org, 
 broonie@kernel.org
In-Reply-To: <20240416153805.431118-3-angelogioacchino.delregno@collabora.com>
References: <20240416153805.431118-1-angelogioacchino.delregno@collabora.com>
 <20240416153805.431118-3-angelogioacchino.delregno@collabora.com>
Message-Id: <171328518448.2610972.14839354170690825161.robh@kernel.org>
Subject: Re: [PATCH v1 2/6] dt-bindings: interconnect: Add MediaTek EMI
 Interconnect bindings


On Tue, 16 Apr 2024 17:38:01 +0200, AngeloGioacchino Del Regno wrote:
> Add bindings for the MediaTek External Memory Interface Interconnect,
> which providers support system bandwidth requirements through Dynamic
> Voltage Frequency Scaling Resource Collector (DVFSRC) hardware.
> 
> This adds bindings for MediaTek MT8183 and MT8195 SoCs.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../interconnect/mediatek,mt8183-emi.yaml     | 76 +++++++++++++++++++
>  .../interconnect/mediatek,mt8183.h            | 23 ++++++
>  .../interconnect/mediatek,mt8195.h            | 44 +++++++++++
>  3 files changed, 143 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/mediatek,mt8183-emi.yaml
>  create mode 100644 include/dt-bindings/interconnect/mediatek,mt8183.h
>  create mode 100644 include/dt-bindings/interconnect/mediatek,mt8195.h
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interconnect/mediatek,mt8183-emi.example.dtb: dvfsrc@10012000: '#address-cells', '#size-cells' do not match any of the regexes: '@[0-9a-f]+$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/soc/mediatek/mediatek,mt8183-dvfsrc.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240416153805.431118-3-angelogioacchino.delregno@collabora.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


