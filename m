Return-Path: <linux-kernel+bounces-22144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A858299EE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C67341F25281
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F8347F6D;
	Wed, 10 Jan 2024 11:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jUCbxb4X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D2247F46;
	Wed, 10 Jan 2024 11:57:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6BBBC433C7;
	Wed, 10 Jan 2024 11:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704887872;
	bh=xkRqDJzY2Q7rGDUHLUsK/Nq5FNNZRpdRRWdvHBixc1E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=jUCbxb4XB/DTgM7vbr5mn5hfM+aBIOvS4ofINM9xiKN8GIFZbwxMqWV+zAczbOOxX
	 i3zbWLVtfVl4kJVFomY8e+brEDlhBiwDuFLsnJ6J3K7ydJAJpQpPa3IJkSsUTlK6GP
	 ISW7cwitlrhBg7NjuRswd2dd1jcWM8PK8msuxqOTzAVRHQkZHd4is1EYJMRJxyogOR
	 5BwkB9C3LW3g5IX36BW7lDOukp9vYy0Gr24c050QKiefpdPnchmRtD1z/fiG5zQn8w
	 4K75jujwSv0nGpIbKr2k8p7i1arfBzLZq0qY8Bc8do17EbFAEq57BYWFPyOTp3wmoP
	 +Mnri9S9aK17A==
Received: (nullmailer pid 942197 invoked by uid 1000);
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
Cc: lee@kernel.org, robh+dt@kernel.org, nicolas.ferre@microchip.com, u.kleine-koenig@pengutronix.de, maarten.lankhorst@linux.intel.com, linux-arm-kernel@lists.infradead.org, tzimmermann@suse.de, airlied@gmail.com, krzysztof.kozlowski+dt@linaro.org, bbrezillon@kernel.org, daniel@ffwll.ch, devicetree@vger.kernel.org, conor+dt@kernel.org, dri-devel@lists.freedesktop.org, claudiu.beznea@tuxon.dev, linux-pwm@vger.kernel.org, sam@ravnborg.org, mripard@kernel.org, alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org, thierry.reding@gmail.com
In-Reply-To: <20240110102535.246177-2-dharma.b@microchip.com>
References: <20240110102535.246177-1-dharma.b@microchip.com>
 <20240110102535.246177-2-dharma.b@microchip.com>
Message-Id: <170488786892.942140.9840992468910708150.robh@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: display: convert Atmel's HLCDC to DT
 schema
Date: Wed, 10 Jan 2024 05:57:49 -0600


On Wed, 10 Jan 2024 15:55:33 +0530, Dharma Balasubiramani wrote:
> Convert the existing DT binding to DT schema of the Atmel's HLCDC display
> controller.
> 
> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
> ---
>  .../display/atmel/atmel,hlcdc-dc.yaml         | 133 ++++++++++++++++++
>  .../bindings/display/atmel/hlcdc-dc.txt       |  75 ----------
>  2 files changed, 133 insertions(+), 75 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/display/atmel/atmel,hlcdc-dc.yaml
>  delete mode 100644 Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/display/atmel/atmel,hlcdc-dc.example.dtb: /example-0/hlcdc@f0030000: failed to match any schema with compatible: ['atmel,sama5d3-hlcdc']
Documentation/devicetree/bindings/display/atmel/atmel,hlcdc-dc.example.dtb: /example-0/hlcdc@f0030000/hlcdc-pwm: failed to match any schema with compatible: ['atmel,hlcdc-pwm']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240110102535.246177-2-dharma.b@microchip.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


