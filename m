Return-Path: <linux-kernel+bounces-41307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A48583EE9B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 17:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA06F1F261E4
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 16:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036162C1AC;
	Sat, 27 Jan 2024 16:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B8DDCw1J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471941EF1F;
	Sat, 27 Jan 2024 16:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706372905; cv=none; b=e3GhjydAij1J6lkqx+ql9Sxege5zxyJ2IPUBk7/1nVpNfZcPf7DCz9wbFYVwIlmOvtApavw1Jr2v5D1WqpulYTSvXUXlXkQvV4PK14EO/AjOqiTHg9d+oOOpBHEgNRydqY7ZgOXv7ud0Ck8PVR3gRjbMGLKy9pkkBEPF043WyHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706372905; c=relaxed/simple;
	bh=SIsFgkfEIry3mn75jIrd3xxoyIlXqfXCtitggYePuF0=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=NNagCymWfiWSZS2nUwu8SLEk5/SWKv2Jlxg4ts6j60HjndoE5rGNw+UhOgrU19tI/JknNPvoiTQV0HtFvG3snwQ3YQcf2m6XGCgj0NJhFI2wHACHxqFJeCJuJnJRe9QMUHYbd4S1N4dpejCeieG1VFP2Ajgt/C2qIw5qSU9U+Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B8DDCw1J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67076C433F1;
	Sat, 27 Jan 2024 16:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706372904;
	bh=SIsFgkfEIry3mn75jIrd3xxoyIlXqfXCtitggYePuF0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=B8DDCw1JNLS+bpMz0I4/2w1PkfISe5Itd5hKJQKPdB2fXa7ymg4AgUHJsGrUlbhHr
	 Yr46b+0VmuRX7rDLSNi8efgXcYN7YcjDA1pnpKANLX8Qth40tXUHV5h/Fq6pMsCAn3
	 q+Q4QY20QglJPtQpHyTUylSsvc9DqFIVWDEbne4hgAOicEkT+0ibfiQ9T4DolAp2Q7
	 vI0rLu4TkZseVX+w/QrzNcPKDjM6qzm0QntfoAzmZzzCYf99uCVLrkErzoO7FJj+5h
	 oVCqABvy+WYdo5HItWkWOiV/bZm5m6xF9CWEck1A/52JcRDhx8vrXmyvQ1Zi67Aq4/
	 d37tICFoD6orw==
Date: Sat, 27 Jan 2024 10:28:22 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, 
 David Airlie <airlied@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Daniel Vetter <daniel@ffwll.ch>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 dri-devel@lists.freedesktop.org, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>, 
 devicetree@vger.kernel.org, Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Conor Dooley <conor+dt@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Sam Ravnborg <sam@ravnborg.org>
In-Reply-To: <20240127152821.65744-1-dario.binacchi@amarulasolutions.com>
References: <20240127152821.65744-1-dario.binacchi@amarulasolutions.com>
Message-Id: <170637290174.2797231.1548285445759438647.robh@kernel.org>
Subject: Re: [drm-drm-misc:drm-misc-next] dt-bindings: nt35510: document
 'port' property


On Sat, 27 Jan 2024 16:28:08 +0100, Dario Binacchi wrote:
> Allow 'port' property (coming from panel-common.yaml) to be used in DTS:
> 
>   st/stm32f769-disco-mb1166-reva09.dtb: panel@0: 'port' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
> 
> ---
> 
>  .../display/panel/novatek,nt35510.yaml        | 34 +++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/panel/novatek,nt35510.example.dtb: panel@0: compatible:0: 'hydis,hva40wv1' was expected
	from schema $id: http://devicetree.org/schemas/display/panel/novatek,nt35510.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240127152821.65744-1-dario.binacchi@amarulasolutions.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


