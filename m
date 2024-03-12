Return-Path: <linux-kernel+bounces-100304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2FFB879559
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 14:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 530C01F24376
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 13:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45447AE59;
	Tue, 12 Mar 2024 13:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="txqGyP7I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A597A737;
	Tue, 12 Mar 2024 13:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710251350; cv=none; b=QnQNysmF9zAKSTCL+/f6zn42bUHfLyuVdwU3N6zkPXcfTmOPLdQqpGpWFgS+Xwu7/wYnJTy615l1oogQYAYgqRTFkD4OnnKJAqIGKn1K7mZBRBg++aHcYAfvY2QPjvxmHqs476XzpfnWp3ydl4CMU0JS8COvRenauf8MZg2iL7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710251350; c=relaxed/simple;
	bh=gQOndgtic22jBUvA6JtP0OZkfHWdF7w1Uwcr114J8+E=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=llUUFt4d7uN23gf3VXVUww/MN6fIqi6SYVFszr8nY5EHPQlL/KHGg04OAWIVdDgjxB62NmrnLVuBcxQ8e+FXQ1E8GzFhhGCO/SV8f49GLj1BodbliHTByd/YiliuULioOg9tQCp/t6GaD5DGgAYCQQj2b8Yhn7JU/tOO+b+Cffo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=txqGyP7I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47DD5C43390;
	Tue, 12 Mar 2024 13:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710251349;
	bh=gQOndgtic22jBUvA6JtP0OZkfHWdF7w1Uwcr114J8+E=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=txqGyP7INBJyRGU+aRYSqv1aNw001UvRkMWVoxb5QWnhK2Rv7mvVAVVXuhCfZwjAv
	 mdLlq2EjEEkchwYFVOxeVzc15RTPXs/703VmeNZmywulSJ8dwCB/MSQasCbHgeQaCm
	 KqAk6gUvzBMtd1RQq3B/2xdMF2gy0toBQewwFY7SXH5pHgYjJop4RaZ8H5JF+tlJr/
	 syoDKPub+ddnIWI6wJu2tXaS2UO61sSDsUwqJC861DOOX55Cv32e7qurOpCFilWXkY
	 GMg1PV+R0sA/bBrkQNHs2TXG2fbGqL2afl1fpCTu81Z2B7uMXL/DPAAR1PTdq0wLrF
	 jg3UXa20Ks1MQ==
Date: Tue, 12 Mar 2024 07:49:08 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, David Airlie <airlied@gmail.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mark Brown <broonie@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Rob Herring <robh+dt@kernel.org>, Takashi Iwai <tiwai@suse.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 =?utf-8?q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>, 
 Michal Simek <michal.simek@amd.com>, Maxime Ripard <mripard@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 linux-sound@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Jaroslav Kysela <perex@perex.cz>, devicetree@vger.kernel.org, 
 Daniel Vetter <daniel@ffwll.ch>, 
 Anatoliy Klymenko <anatoliy.klymenko@amd.com>, 
 Vishal Sagar <vishal.sagar@amd.com>
In-Reply-To: <20240312-xilinx-dp-audio-v1-2-696c79facbb9@ideasonboard.com>
References: <20240312-xilinx-dp-audio-v1-0-696c79facbb9@ideasonboard.com>
 <20240312-xilinx-dp-audio-v1-2-696c79facbb9@ideasonboard.com>
Message-Id: <171025134476.2083292.14206241408846166502.robh@kernel.org>
Subject: Re: [PATCH 2/4] dt-bindings: display/xlnx/zynqmp-dpsub: Add audio
 DMAs


On Tue, 12 Mar 2024 11:41:03 +0200, Tomi Valkeinen wrote:
> The DP subsystem for ZynqMP support audio via two channels, and the DP
> DMA has dma-engines for those channels. For some reason the DT binding
> has not specified those channels, even if the picture included in
> xlnx,zynqmp-dpsub.yaml shows "2 x aud" DMAs.
> 
> Add the two audio DMAs to the binding.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---
>  .../devicetree/bindings/display/xlnx/xlnx,zynqmp-dpsub.yaml    | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/display/xlnx/xlnx,zynqmp-dpsub.example.dts:54.26-27 syntax error
FATAL ERROR: Unable to parse input tree
make[2]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/display/xlnx/xlnx,zynqmp-dpsub.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1428: dt_binding_check] Error 2
make: *** [Makefile:240: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240312-xilinx-dp-audio-v1-2-696c79facbb9@ideasonboard.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


