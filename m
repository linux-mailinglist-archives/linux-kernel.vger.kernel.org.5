Return-Path: <linux-kernel+bounces-147248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC668A7185
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F9EA1C21AD3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A17134411;
	Tue, 16 Apr 2024 16:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rQyW1gQ2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B74133983;
	Tue, 16 Apr 2024 16:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713285190; cv=none; b=RC+zcGYkRfppWGC7dtns7vhZB0e+eevXZ9b6C55H+Z+H8tQEcIJo/OtVSBGd9VylMZkgFAW1Dyc3yN5GrZ5ka1WZRAiPDOyeYxT8GK9hsQSC8W34wbQW0YYp3g3osDuEhTr4ltt/T3EqXxaIFKmkGBQHnZJ3eX+sYNK98fRcuoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713285190; c=relaxed/simple;
	bh=csn7plls86qJ8MjwV9+WAk2lo/ZQ8CZ8NeCgBsin5as=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=ShNJcgK/DbsdmgGjEs4Te+82DmjC1q7yYFaYCdsc2bQYRizy8MrOmSsOIni5ilH7AMJGu6Jp2n0G9aUNnr5qEfTpXJIqK+YUZRh0hKo4/nEXLukaiOnvaIvsyxfKYtoe3WUhVIv2CI5EqvXqg9qe9xkHkaErISyvO5Q6keXZPgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rQyW1gQ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CCFFC4AF07;
	Tue, 16 Apr 2024 16:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713285189;
	bh=csn7plls86qJ8MjwV9+WAk2lo/ZQ8CZ8NeCgBsin5as=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=rQyW1gQ2aTwQ7NA6zNzj3giMhcljJKR2udqs3R+6U1Y9gwNOi/Q+0MpydxT1cAKlf
	 nCsXhvblkJWA1eyEG2mi71RSPas1rDhw/uxo3djlYSPy/PMp24Yc2o+iFXM5UhtO4C
	 6O7bNVJF8pNPBeHWz1qTI/Q0W8gVUj9lldcz+7YpBCL93cC3s88HjS9EU2KqUXXml4
	 AWT9nFQ2G389P91LjRAEwEicsExFOwrxLDVP5C6WA1ildYRX/FxkBEepWt1rpXZQmZ
	 D2Dhs0aa8uR2qfqzWrNYYm8joFv5+omdUh3NnLk3elEeVl7BdutrzkFZAgoG+ks2gg
	 JahbvMbvfN9eg==
Date: Tue, 16 Apr 2024 11:33:08 -0500
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
Cc: amergnat@baylibre.com, keescook@chromium.org, broonie@kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, linux-arm-kernel@lists.infradead.org, 
 lgirdwood@gmail.com, conor+dt@kernel.org, linux-pm@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, kernel@collabora.com, 
 henryc.chen@mediatek.com, gustavoars@kernel.org, wenst@chromium.org, 
 djakov@kernel.org, matthias.bgg@gmail.com
In-Reply-To: <20240416153805.431118-4-angelogioacchino.delregno@collabora.com>
References: <20240416153805.431118-1-angelogioacchino.delregno@collabora.com>
 <20240416153805.431118-4-angelogioacchino.delregno@collabora.com>
Message-Id: <171328518502.2611010.15541241533158451489.robh@kernel.org>
Subject: Re: [PATCH v1 3/6] dt-bindings: regulator: Add bindings for
 MediaTek DVFSRC Regulators


On Tue, 16 Apr 2024 17:38:02 +0200, AngeloGioacchino Del Regno wrote:
> The Dynamic Voltage and Frequency Scaling Resource Collector Regulators
> are controlled with votes to the DVFSRC hardware.
> 
> This adds support for the regulators found in MT6873, MT8183, MT8192
> and MT8195 SoCs.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../mediatek,mt6873-dvfsrc-regulator.yaml     | 71 +++++++++++++++++++
>  1 file changed, 71 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/mediatek,mt6873-dvfsrc-regulator.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
/Documentation/devicetree/bindings/regulator/mediatek,mt6873-dvfsrc-regulator.yaml:5:10: [error] string value is redundantly quoted with any quotes (quoted-strings)

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/regulator/mediatek,mt6873-dvfsrc-regulator.yaml: $id: Cannot determine base path from $id, relative path/filename doesn't match actual path or filename
 	 $id: http://devicetree.org/schemas/soc/mediatek/mediatek,mt6873-dvfsrc-regulator.yaml
 	file: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/regulator/mediatek,mt6873-dvfsrc-regulator.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/regulator/mediatek,mt6873-dvfsrc-regulator.example.dtb: dvfsrc@10012000: '#address-cells', '#size-cells' do not match any of the regexes: '@[0-9a-f]+$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/soc/mediatek/mediatek,mt8183-dvfsrc.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/regulator/mediatek,mt6873-dvfsrc-regulator.example.dtb: regulators@0: dvfsrc-vcore: False schema does not allow {'regulator-name': ['dvfsrc-vcore'], 'regulator-min-microvolt': [[550000]], 'regulator-max-microvolt': [[750000]], 'regulator-always-on': True}
	from schema $id: http://devicetree.org/schemas/soc/mediatek/mediatek,mt6873-dvfsrc-regulator.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/regulator/mediatek,mt6873-dvfsrc-regulator.example.dtb: regulators@0: dvfsrc-vscp: False schema does not allow {'regulator-name': ['dvfsrc-vscp'], 'regulator-min-microvolt': [[550000]], 'regulator-max-microvolt': [[750000]], 'regulator-always-on': True}
	from schema $id: http://devicetree.org/schemas/soc/mediatek/mediatek,mt6873-dvfsrc-regulator.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240416153805.431118-4-angelogioacchino.delregno@collabora.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


