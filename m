Return-Path: <linux-kernel+bounces-8587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB2981B9CF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3FCAB214D6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C453609A;
	Thu, 21 Dec 2023 14:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/CjY5L+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E503B1D6BD;
	Thu, 21 Dec 2023 14:46:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BCFFC433C7;
	Thu, 21 Dec 2023 14:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703169962;
	bh=thWZKn3LobCE6e6aQM2Yre45Naiy5TVPR/p07htNFWs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=h/CjY5L+a5dEjJqvVIGFMZj2f59MlKhsq9pFWymGuLHkq4VT2WmdJWnHPm/D7mvgD
	 SYGt/ajHFVTDkxhUgq+0orV0jRDbHAdKrlq853JzqVVHOX86FgDMJENp2EarMFvEnV
	 T5RwD6M+XWbM+lqeNVyOSORS9+0LPaUB1Z+rUkhx4m6/BUvAoWcJCtaVw3ykP3Jh7C
	 Ea1QAE21miY5PmyynsJeuvYK6zb7KSd/ufObGbLwTWd0ztaty0I2qZ29b8+DmGIoJ8
	 vPtoSwsjmenOl4QweCo4nveV/Mo1mNb2U9+6KJOsqTaBNeHzc4mlio6SzFZe97DEiM
	 dsp0/UzakXuIw==
Received: (nullmailer pid 3869255 invoked by uid 1000);
	Thu, 21 Dec 2023 14:45:59 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>, Philippe Cornu <philippe.cornu@foss.st.com>, Sam Ravnborg <sam@ravnborg.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, Rob Herring <robh+dt@kernel.org>, Maxime Ripard <mripard@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, Philipp Zabel <p.zabel@pengutronix.de>, dri-devel@lists.freedesktop.org, Conor Dooley <conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Neil Armstrong <neil.armstrong@linaro.org>, Thomas Zimmermann <tzimmermann@suse.de>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Yannick Fertre <yannick.fertre@foss.st.com>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, David Airlie <airlied@gmail.com>
In-Reply-To: <20231221124339.420119-3-raphael.gallais-pou@foss.st.com>
References: <20231221124339.420119-1-raphael.gallais-pou@foss.st.com>
 <20231221124339.420119-3-raphael.gallais-pou@foss.st.com>
Message-Id: <170316995910.3869238.14321525013510097521.robh@kernel.org>
Subject: Re: [PATCH RESEND v1 2/8] dt-bindings: display: add dt-bindings
 for STM32 LVDS device
Date: Thu, 21 Dec 2023 08:45:59 -0600


On Thu, 21 Dec 2023 13:43:33 +0100, Raphael Gallais-Pou wrote:
> Add dt-binding file for "st,stm32-lvds" compatible.
> 
> Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
> ---
>  .../bindings/display/st,stm32-lvds.yaml       | 114 ++++++++++++++++++
>  1 file changed, 114 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/st,stm32-lvds.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/display/st,stm32-lvds.example.dts:18:18: fatal error: dt-bindings/bus/stm32mp25_sys_bus.h: No such file or directory
   18 |         #include <dt-bindings/bus/stm32mp25_sys_bus.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[2]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/display/st,stm32-lvds.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1424: dt_binding_check] Error 2
make: *** [Makefile:234: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231221124339.420119-3-raphael.gallais-pou@foss.st.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


