Return-Path: <linux-kernel+bounces-149820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C0A8A964D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38074B21FFB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 09:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB9E15B105;
	Thu, 18 Apr 2024 09:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hsG7NUQk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3968B54BC4;
	Thu, 18 Apr 2024 09:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713433014; cv=none; b=RzxNGbor2U2O0eExuph/cCeYdLHOePnjiN9mztUGB7E7+HZjJt1pzlY9UccEF3QNkX0okovS2QnEnICYtDduKom+5Lxnj0A48Expky52tyPIUJT9S6XKn+q+KPlMi2RFRWomt2YkNZMb6FGtIq49Lty7f5URwdFxdxXOvzi/5Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713433014; c=relaxed/simple;
	bh=Qp9k4aU9c7AEiPS0ii/bSgM7Vml63g+4H5aHCfN6h24=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=sjwWFigqN1pewvffhVTX7EHsEFAGOpuDZxqnYpsG8EDp0XmlIb8jyLj7OyMyA4ShYqB6nA/IaFm8u+Rrsg/H3VyKnqjMaSkJ2sDxLBilJREYRC9u1l9ckkKvVt6wUqYIB2Mwgs1Bw2wOACcA0uvdvejxk2CuXjLEwcxyeP1hRuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hsG7NUQk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78A51C2BD11;
	Thu, 18 Apr 2024 09:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713433013;
	bh=Qp9k4aU9c7AEiPS0ii/bSgM7Vml63g+4H5aHCfN6h24=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=hsG7NUQkfXYBpr62bEa0fDE+fRS17kSekv8vqSAjQ3UjaFhJ4gSG4evawt/1hg0qh
	 QNg4xQZ+92jFrtncFCYi+GQOKQPrEpcL6ck5kJlVbUszC/TrhfVAZJVSKEQSKrPkRi
	 vWzL52Suy1MXEAZ236Q8Rs9JmG4UzInyIINctH/LkIG0GLsVmlOp+n8rWiQ5uAnCad
	 t7Gj95Om40+vVsORrLwSzny4Ri2T/8+dapC12vgGaDYs670DI2/3B4f633Z+HPmKc6
	 VIR3zN1s1YRmkGM674StxAYLVC3M47HJcYDkWNNZUBeP5WypigY2XBYGftc77nUP4B
	 oxf8SduVO56lA==
Date: Thu, 18 Apr 2024 04:36:52 -0500
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
Cc: henryc.chen@mediatek.com, krzysztof.kozlowski+dt@linaro.org, 
 wenst@chromium.org, gustavoars@kernel.org, devicetree@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com, 
 conor+dt@kernel.org, kernel@collabora.com, amergnat@baylibre.com, 
 linux-pm@vger.kernel.org, keescook@chromium.org, 
 linux-arm-kernel@lists.infradead.org, lgirdwood@gmail.com, 
 djakov@kernel.org, broonie@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240418082812.152270-4-angelogioacchino.delregno@collabora.com>
References: <20240418082812.152270-1-angelogioacchino.delregno@collabora.com>
 <20240418082812.152270-4-angelogioacchino.delregno@collabora.com>
Message-Id: <171343301130.424721.10758711321868587171.robh@kernel.org>
Subject: Re: [PATCH v3 3/7] dt-bindings: soc: mediatek: Add DVFSRC bindings
 for MT8183 and MT8195


On Thu, 18 Apr 2024 10:28:08 +0200, AngeloGioacchino Del Regno wrote:
> Add bindings for the MediaTek Dynamic Voltage and Frequency Scaling
> Resource Collector (DVFSRC), a hardware module used to collect all the
> requests from both software and the various remote processors embedded
> into the SoC and decide about a minimum operating voltage and a minimum
> DRAM frequency to fulfill those requests in an effort to provide the
> best achievable performance per watt.
> 
> This hardware IP is capable of transparently performing direct register
> R/W on all of the DVFSRC-controlled regulators and SoC bandwidth knobs.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../soc/mediatek/mediatek,mt8183-dvfsrc.yaml  | 94 +++++++++++++++++++
>  1 file changed, 94 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/mediatek/mediatek,mt8183-dvfsrc.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/mediatek/mediatek,mt8183-dvfsrc.example.dtb: system-controller@10012000: regulators@0: 'reg' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/soc/mediatek/mediatek,mt8183-dvfsrc.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/mediatek/mediatek,mt8183-dvfsrc.example.dtb: system-controller@10012000: interconnect@1: Unevaluated properties are not allowed ('reg' was unexpected)
	from schema $id: http://devicetree.org/schemas/soc/mediatek/mediatek,mt8183-dvfsrc.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/mediatek/mediatek,mt8183-dvfsrc.example.dtb: regulators@0: 'reg' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/regulator/mediatek,mt6873-dvfsrc-regulator.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/mediatek/mediatek,mt8183-dvfsrc.example.dtb: interconnect@1: Unevaluated properties are not allowed ('reg' was unexpected)
	from schema $id: http://devicetree.org/schemas/interconnect/mediatek,mt8183-emi.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240418082812.152270-4-angelogioacchino.delregno@collabora.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


