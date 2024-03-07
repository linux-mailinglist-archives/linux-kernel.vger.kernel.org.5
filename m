Return-Path: <linux-kernel+bounces-95618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02555875046
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACE541F22DB8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C415E12DDAF;
	Thu,  7 Mar 2024 13:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QYe5b9I6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A1E12D216;
	Thu,  7 Mar 2024 13:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709818736; cv=none; b=THqa9H8zwI6CnSL0SAPgGku53MceDoRanHMYE7YQES/acmT+h9Te6tY25QQE37or1iQEVEfIJ/SxM91ezloqjbMs44A4FYDb6Kdlrsb2PRcGJ2bslMTUHtnOdipyrkbbvAcee4Bat6KuDp3bGT1wsDSVsIWdZem7gNATyF1URlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709818736; c=relaxed/simple;
	bh=QOIq153Hh97YArqMO6ndMKTIDS/Bu4Z0Gow+bUdmicI=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=Ai682nHZEQAe8XUqoL1mrcG/cQaRg4ToqyYRRA6u7KjyEhCvVF6CMU+sXiFtbCZ/q1N0jCVtcqR7azfkzmAQxY0wVe7phZGg0c1HL9CNoiZlOPTChyA6Wmapvtq3cxiAGSt+/+4jW8L8XxTsqwRCKnBMPRJrILettP8aWf5xTXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QYe5b9I6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51378C433F1;
	Thu,  7 Mar 2024 13:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709818735;
	bh=QOIq153Hh97YArqMO6ndMKTIDS/Bu4Z0Gow+bUdmicI=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=QYe5b9I6O512SuBx+pMc36xCatZ7plD9jkJUTPdM4VE2w1M5NU5HSNzEqZaTjYzNz
	 e77JAePu4bGHeX3o00+lpqMwKsETLSKjothuTlX8EYemEkd4s+Pi7OTGwUU43XxaBv
	 I4PYhg2Ppz++WdTcqIofwVVpk0SU4aH32+ogjWV9suVuXfpHnCxGhoufySCTk2asG8
	 3cQFB7M06hoBzi/85bLoyh+TkHQPbfWIj9m2ZN/ESAZ9VRBF7JagoNwr+JKst21m5H
	 CrTr/cJtN3qzS9hMsWEF7hLz4ovLJM3lxu6bn/uE2oZBffBRy/wPBwy3W8JyxubY6r
	 QMsif1rAmhqgQ==
Date: Thu, 07 Mar 2024 07:38:54 -0600
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
Cc: matthias.bgg@gmail.com, eugen.hristev@collabora.com, 
 devicetree@vger.kernel.org, nfraprado@collabora.com, 
 claudiu.beznea@tuxon.dev, zhourui@huaqin.corp-partner.google.com, 
 broonie@kernel.org, wenst@chromium.org, dianders@chromium.org, 
 shane.chien@mediatek.com, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, 
 allen-kh.cheng@mediatek.com, shraash@google.com, frank.li@vivo.com, 
 maso.huang@mediatek.com, perex@perex.cz, jiaxin.yu@mediatek.com, 
 linux-mediatek@lists.infradead.org, u.kleine-koenig@pengutronix.de, 
 alsa-devel@alsa-project.org, trevor.wu@mediatek.com, 
 nicolas.ferre@microchip.com, linux-sound@vger.kernel.org, 
 amergnat@baylibre.com, kernel@collabora.com, tiwai@suse.com, 
 jarkko.nikula@bitmer.com, linux-arm-kernel@lists.infradead.org, 
 kuninori.morimoto.gx@renesas.com, 
 xiazhengqiao@huaqin.corp-partner.google.com, ckeepax@opensource.cirrus.com, 
 alpernebiyasak@gmail.com, arnd@arndb.de, krzysztof.kozlowski+dt@linaro.org, 
 conor+dt@kernel.org
In-Reply-To: <20240307114445.196981-21-angelogioacchino.delregno@collabora.com>
References: <20240307114445.196981-1-angelogioacchino.delregno@collabora.com>
 <20240307114445.196981-21-angelogioacchino.delregno@collabora.com>
Message-Id: <170981873072.2495513.10220063572625307394.robh@kernel.org>
Subject: Re: [PATCH v2 20/22] ASoC: dt-bindings: mt8186: Document
 audio-routing and dai-link subnode


On Thu, 07 Mar 2024 12:44:43 +0100, AngeloGioacchino Del Regno wrote:
> Document the dai-link subnodes and the audio-routing property, allowing
> to describe machine specific audio hardware and links in device tree.
> 
> While at it, also deprecate the old properties which were previously
> used with the driver's partially hardcoded configuration.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../sound/mt8186-mt6366-da7219-max98357.yaml  | 112 ++++++++++++++++--
>  .../sound/mt8186-mt6366-rt1019-rt5682s.yaml   | 102 ++++++++++++++--
>  2 files changed, 199 insertions(+), 15 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/mt8186-mt6366-rt1019-rt5682s.example.dtb: mt8186-sound: 'model' does not match any of the regexes: '.*-dai-link$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/sound/mt8186-mt6366-rt1019-rt5682s.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240307114445.196981-21-angelogioacchino.delregno@collabora.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


