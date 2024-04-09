Return-Path: <linux-kernel+bounces-136845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FBEF89D8E8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E83581F21AB9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69DD312D1E7;
	Tue,  9 Apr 2024 12:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eF1TAvKh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923D480043;
	Tue,  9 Apr 2024 12:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712664646; cv=none; b=e8ZURlThN4CeA6hWSq95agK1KOKXa2pcTZO/anP2oU261RuUrG8MUvDTq02fChkgsYHPq8h+IFKBrunECJng9vZtWZAnrS4u0X125BZyKOzBAh/NCwVeXE2Jml6i5WIcAWv3Skyu2Nec6yEIpelWQLd24QcEBOgElBsh6rvJMKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712664646; c=relaxed/simple;
	bh=Kqt0iwwTPC3AOYTlEZgew0NErAZ3Ys/2OHVWI4y3Xd4=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=LQ0WoMPU8CS1F7E70d4cU36mpWufgg6egh/zCKAoDNNfRjV76STlh1oRnGhc/e2LAO0e0Dw3VqSDTzOuxyxVJp7mXRXdolvxk/EutmjB2hSSXhuwU/wnA8elBc8Mnm3vt9hoceJQrX0GTAMKOxp3qObJiMF0wPJv7pQx+2wEL50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eF1TAvKh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BED3EC433C7;
	Tue,  9 Apr 2024 12:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712664646;
	bh=Kqt0iwwTPC3AOYTlEZgew0NErAZ3Ys/2OHVWI4y3Xd4=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=eF1TAvKhRb0ECUTHSgTfdE50JOT/NZ1JcNC1PvF4Q/IQymUhXQ0OKu7tcU6E2gt1Y
	 JBfBEJEiL7kboOpY9vf5D5sQyRNv7jVstOpNjWGTKb74Fso+biJHlXXyQxcD8DniMX
	 3sMQRksrPADdIEwwz1rRpULXWQCBv4tdIQQZYvmGTFVchOQRU4lvxn6U99BgjSBtbr
	 //vjZWzhQcwOwONnIzsnnTm2lZnwb/OlSXc4z9NsZCQAr2wMelgrNtbuN6S5van+GB
	 MZg7hF5JXU7tJreJXYtnvzCOeAympCSPPG7cBsJSor/mL82KsJPKkvTCCqUsVhkWtC
	 IlagK8/TsStug==
Date: Tue, 09 Apr 2024 07:10:44 -0500
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
Cc: dri-devel@lists.freedesktop.org, linux-sound@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org, Rob Herring <robh+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 linux-media@vger.kernel.org, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Flora Fu <flora.fu@mediatek.com>, Mark Brown <broonie@kernel.org>, 
 Lee Jones <lee@kernel.org>, Takashi Iwai <tiwai@suse.com>, 
 Will Deacon <will@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
 linux-mediatek@lists.infradead.org, Liam Girdwood <lgirdwood@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>, 
 Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <20240226-audio-i350-v2-3-3043d483de0d@baylibre.com>
References: <20240226-audio-i350-v2-0-3043d483de0d@baylibre.com>
 <20240226-audio-i350-v2-3-3043d483de0d@baylibre.com>
Message-Id: <171266464251.692374.12025555863069807976.robh@kernel.org>
Subject: Re: [PATCH v2 03/18] dt-bindings: mfd: mediatek: Add codec
 property for MT6357 PMIC


On Tue, 09 Apr 2024 12:13:24 +0200, Alexandre Mergnat wrote:
> Add the audio codec sub-device. This sub-device is used to set required
> and optional voltage properties between the codec and the board.
> 
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>  Documentation/devicetree/bindings/mfd/mediatek,mt6357.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/mediatek,mt6357.yaml:
Error in referenced schema matching $id: http://devicetree.org/schemas/sound/mt6357.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240226-audio-i350-v2-3-3043d483de0d@baylibre.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


