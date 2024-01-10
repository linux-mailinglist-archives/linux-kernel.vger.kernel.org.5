Return-Path: <linux-kernel+bounces-22146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C6F8299F5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 110CAB242BA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E15482C5;
	Wed, 10 Jan 2024 11:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NbSGwV4Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562D4481BC;
	Wed, 10 Jan 2024 11:57:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5538C433F1;
	Wed, 10 Jan 2024 11:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704887875;
	bh=GKca1HsX6awgTvyvYloYbP0iiufJSLHo67+h3IFogD0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=NbSGwV4QHrYZtRcQUhUadF8s/kTlJjjW2jEmUW2irTffjvNE70LySk8rWiJdZ+yl7
	 2GsZ0xUSMWvsWOpGCCBr5oacMXr1qfxDMoNGnQhtncFxDf8zItEODikEnmrDXZtso1
	 fapQw7vW8L5eQxp+zd5gq/P878Simawt2KjubhHk+xcI2uFFjXJD5CiVlteU8Yv2hv
	 xa/FCE+T2ijWY0xCyOnCKsa8DDhipM1FGNGlENHvsjurdwxbiK0lIx8lMhC8PugFpA
	 gRLoNRNzRdh4Iq6P+R/9IetTpzB+qkXmS7qO4fb+zwd2BYJIfBRSAgiP6wcRcntWED
	 aWWM8ift3m0rQ==
Received: (nullmailer pid 942200 invoked by uid 1000);
	Wed, 10 Jan 2024 11:57:49 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Dharma Balasubiramani <dharma.b@microchip.com>
Cc: linux-kernel@vger.kernel.org, tzimmermann@suse.de, conor+dt@kernel.org, daniel@ffwll.ch, dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org, claudiu.beznea@tuxon.dev, nicolas.ferre@microchip.com, lee@kernel.org, airlied@gmail.com, sam@ravnborg.org, thierry.reding@gmail.com, bbrezillon@kernel.org, u.kleine-koenig@pengutronix.de, maarten.lankhorst@linux.intel.com, alexandre.belloni@bootlin.com, mripard@kernel.org, linux-pwm@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org
In-Reply-To: <20240110102535.246177-3-dharma.b@microchip.com>
References: <20240110102535.246177-1-dharma.b@microchip.com>
 <20240110102535.246177-3-dharma.b@microchip.com>
Message-Id: <170488786949.942181.15403969242765460725.robh@kernel.org>
Subject: Re: [PATCH 2/3] dt-bindings: mfd: atmel,hlcdc: Convert to DT
 schema format
Date: Wed, 10 Jan 2024 05:57:49 -0600


On Wed, 10 Jan 2024 15:55:34 +0530, Dharma Balasubiramani wrote:
> Convert the atmel,hlcdc binding to DT schema format.
> 
> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
> ---
>  .../devicetree/bindings/mfd/atmel,hlcdc.yaml  | 106 ++++++++++++++++++
>  .../devicetree/bindings/mfd/atmel-hlcdc.txt   |  56 ---------
>  2 files changed, 106 insertions(+), 56 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/atmel,hlcdc.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/atmel,hlcdc.yaml:
Error in referenced schema matching $id: http://devicetree.org/schemas/pwm/atmel,hlcdc-pwm.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/atmel/atmel,hlcdc-dc.example.dtb: hlcdc@f0030000: hlcdc-pwm: False schema does not allow {'compatible': ['atmel,hlcdc-pwm'], 'pinctrl-names': ['default'], 'pinctrl-0': [[4294967295]], '#pwm-cells': [[3]]}
	from schema $id: http://devicetree.org/schemas/mfd/atmel,hlcdc.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/atmel,hlcdc.example.dtb: hlcdc@f0030000: hlcdc-pwm: False schema does not allow {'compatible': ['atmel,hlcdc-pwm'], 'pinctrl-names': ['default'], 'pinctrl-0': [[4294967295]], '#pwm-cells': [[3]]}
	from schema $id: http://devicetree.org/schemas/mfd/atmel,hlcdc.yaml#
Documentation/devicetree/bindings/mfd/atmel,hlcdc.example.dtb: /example-0/hlcdc@f0030000/hlcdc-pwm: failed to match any schema with compatible: ['atmel,hlcdc-pwm']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240110102535.246177-3-dharma.b@microchip.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


