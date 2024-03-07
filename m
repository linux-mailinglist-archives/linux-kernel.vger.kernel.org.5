Return-Path: <linux-kernel+bounces-95617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5144F87503B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F13171F22A0D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62DE412D745;
	Thu,  7 Mar 2024 13:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZURRjwF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EB9128806;
	Thu,  7 Mar 2024 13:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709818733; cv=none; b=sRx+8GPwSVXFZ8l2aEfpIm0e2qs3UEO/rFTbNHkms6hANP406xWuURNy6IFvWjwfP0kPShHmb+M207Swpe70Mf06DsPeY9BGkercOoCIvxG2Jr8m2MW+3I39Xky39wwQgBHcJLxa8MfhZMipEiVYtyFFkDtg8gFahqePQ6pKKZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709818733; c=relaxed/simple;
	bh=jdziFFhymjkKWVH2L66KHJLIKy2BknU2Y6GQbKeQUN0=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=eTvBP5V6APsXRDmkuImSFMEjbN1vnJzQyApF/fYIyqjfdSwVddiwef/m7AF5p3mHHwgEbM6iJVP/T2WuPoGWTyAYy7zqbc3d4Q3nMiky8pwbnNVtZO1oeFYxxPbS2DPC+o1S8RtogCKwKFNsVeMZI8Rz9A2Se/MMnYHfnfu8bX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZURRjwF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9A13C433C7;
	Thu,  7 Mar 2024 13:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709818733;
	bh=jdziFFhymjkKWVH2L66KHJLIKy2BknU2Y6GQbKeQUN0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=EZURRjwFB6Gt7MazyGetYAEDZL/lr9tOV8UGUjY3V/0VSV11g+uGlqg+v7EiLtZV/
	 BtjbRK0Iwoqh58ZgA3CdcQX84x2D6BX+RnLJ05UX63NrG/KOZzSbhfSzhPDd6Mi4Be
	 FakJCatHxob98B+VZRFUls/7L1xD69bs07V+zYQR5bRlVwbsuCI3iVzd1+2ZtpPDG2
	 eib4cAZTIz9b2oGNI1tpvWBW/mH/5gsTchrX16H2JhihpXGPU0i55WbQF8sdPb+Ig2
	 XwBfFY+d1IWdJiUy4exyAQpwoHlBRI8wziWhbPzN43d11PHd/bCyou8/D+g/s0bAjD
	 yTECBlR97r0Bw==
Date: Thu, 07 Mar 2024 07:38:51 -0600
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
Cc: linux-arm-kernel@lists.infradead.org, shane.chien@mediatek.com, 
 nicolas.ferre@microchip.com, perex@perex.cz, allen-kh.cheng@mediatek.com, 
 linux-sound@vger.kernel.org, dianders@chromium.org, 
 krzysztof.kozlowski+dt@linaro.org, kernel@collabora.com, 
 matthias.bgg@gmail.com, alpernebiyasak@gmail.com, conor+dt@kernel.org, 
 linux-kernel@vger.kernel.org, tiwai@suse.com, eugen.hristev@collabora.com, 
 nfraprado@collabora.com, arnd@arndb.de, linux-mediatek@lists.infradead.org, 
 amergnat@baylibre.com, claudiu.beznea@tuxon.dev, frank.li@vivo.com, 
 zhourui@huaqin.corp-partner.google.com, wenst@chromium.org, 
 kuninori.morimoto.gx@renesas.com, 
 xiazhengqiao@huaqin.corp-partner.google.com, trevor.wu@mediatek.com, 
 devicetree@vger.kernel.org, jarkko.nikula@bitmer.com, 
 ckeepax@opensource.cirrus.com, lgirdwood@gmail.com, shraash@google.com, 
 alsa-devel@alsa-project.org, u.kleine-koenig@pengutronix.de, 
 jiaxin.yu@mediatek.com, broonie@kernel.org, maso.huang@mediatek.com
In-Reply-To: <20240307114445.196981-20-angelogioacchino.delregno@collabora.com>
References: <20240307114445.196981-1-angelogioacchino.delregno@collabora.com>
 <20240307114445.196981-20-angelogioacchino.delregno@collabora.com>
Message-Id: <170981873007.2495472.10889414408252370603.robh@kernel.org>
Subject: Re: [PATCH v2 19/22] ASoC: dt-bindings: mt8192: Document
 audio-routing and dai-link subnode


On Thu, 07 Mar 2024 12:44:42 +0100, AngeloGioacchino Del Regno wrote:
> Document the dai-link subnodes and the audio-routing property, allowing
> to describe machine specific audio hardware and links in device tree.
> 
> While at it, also deprecate the old properties which were previously
> used with the driver's partially hardcoded configuration.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../sound/mt8192-mt6359-rt1015-rt5682.yaml    | 124 ++++++++++++++++--
>  1 file changed, 115 insertions(+), 9 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/mt8192-mt6359-rt1015-rt5682.example.dtb: mt8192-sound: 'model' does not match any of the regexes: '.*-dai-link$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/sound/mt8192-mt6359-rt1015-rt5682.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240307114445.196981-20-angelogioacchino.delregno@collabora.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


