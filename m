Return-Path: <linux-kernel+bounces-136846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 441AC89D8ED
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5214B251E5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF96F12E1C4;
	Tue,  9 Apr 2024 12:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lr6otbaZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1166B12D753;
	Tue,  9 Apr 2024 12:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712664649; cv=none; b=iYmqEGrouVexhiPbK8YoDVdp+CTBm1AEQTzDxGDT21OYI5DV7H9QW5bhXWO9c3oX0cj54dVAcA9inJACfc8UnOBdLI7afJhs2DgSCv8Jc/N2B3JA4h++4Naxqm1/LZY9IleEmjFOF5Zva6jI/H6gl84JVXqWenfKZcxWHvTuplA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712664649; c=relaxed/simple;
	bh=qPcpjQQA+x/Lp3zoDAguMcAnH3yp4AUeYMdHe1M4OcE=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=jRDcaNG84OAu8rLYy2L9rI60105pFASeQD8y+QSFdxCLci4UGSzwT8SN2HJv1ZxtD6RBjqgBfTvyuONVbE85Y4rUC0Df8xfJ0woTDa7cuPhb8ESAYzJslfixAP0wvdXgwkeh9mlfDxOYlUBEU6QPJEhIwiLpkgU28iMCW1/WKhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lr6otbaZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ACE4C43399;
	Tue,  9 Apr 2024 12:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712664648;
	bh=qPcpjQQA+x/Lp3zoDAguMcAnH3yp4AUeYMdHe1M4OcE=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=Lr6otbaZHkCwc8rTE3hO5aEBmzcZW1GmC9RB07B4BUlkpRRo/Dj2uW7ymS7cIqQtf
	 TI2U0yDOEl9WMMGHLaetqQHVpaud3bzGlHx/8A3G2rWc1KZvLSMiSxIrR2NQODkaNx
	 S3F/X6kQBtaW8yaX0qCwVBdU791lVnJAxFWyXEvnjr8FcFPkrdf6HjM6YoWDjtL1sA
	 /JSfcsu/7hCuCFyx4sBOlIDjyxfSf8VJqnSUS3MRT6HWxVpvdE9IcXtO1vs0ACEucf
	 io9RlHyjH0Z/JkbCJmtALKfb5HFty6qkFWsqmjkNQmx0Vd9rkRpc5aK3MNjNdTsR3u
	 Q7nZ6uDer/jzA==
Date: Tue, 09 Apr 2024 07:10:47 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Alexandre Mergnat <amergnat@baylibre.com>
Cc: Rob Herring <robh+dt@kernel.org>, 
 Sumit Semwal <sumit.semwal@linaro.org>, Flora Fu <flora.fu@mediatek.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 dri-devel@lists.freedesktop.org, Mark Brown <broonie@kernel.org>, 
 devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, linux-media@vger.kernel.org, 
 Jaroslav Kysela <perex@perex.cz>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Takashi Iwai <tiwai@suse.com>, Conor Dooley <conor+dt@kernel.org>, 
 linux-mediatek@lists.infradead.org, Lee Jones <lee@kernel.org>, 
 linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>, 
 linaro-mm-sig@lists.linaro.org, Matthias Brugger <matthias.bgg@gmail.com>, 
 linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Liam Girdwood <lgirdwood@gmail.com>
In-Reply-To: <20240226-audio-i350-v2-4-3043d483de0d@baylibre.com>
References: <20240226-audio-i350-v2-0-3043d483de0d@baylibre.com>
 <20240226-audio-i350-v2-4-3043d483de0d@baylibre.com>
Message-Id: <171266464354.692403.15935267584546388532.robh@kernel.org>
Subject: Re: [PATCH v2 04/18] ASoC: dt-bindings: mt6357: Add audio codec
 document


On Tue, 09 Apr 2024 12:13:25 +0200, Alexandre Mergnat wrote:
> Add MT8365 audio codec bindings to set required
> and optional voltage properties between the codec and the board.
> The properties are:
> - phandle of the requiered power supply.
> - Setup of microphone bias voltage.
> - Setup of the speaker pin pull-down.
> 
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>  .../devicetree/bindings/sound/mt6357.yaml          | 54 ++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/mt6357.yaml: properties:vaud28-supply: '$ref' is not one of ['description', 'deprecated']
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240226-audio-i350-v2-4-3043d483de0d@baylibre.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


