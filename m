Return-Path: <linux-kernel+bounces-60374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E4F850429
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 12:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCA7B286BB9
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 11:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615F63D0CB;
	Sat, 10 Feb 2024 11:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jynf7gOi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9A23CF61;
	Sat, 10 Feb 2024 11:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707564590; cv=none; b=IiRG1qiKdnD34qEjwIRa4bEgEYSIbnYl2aZV+FOHbLvOYP7hkHQ7J8vXOByLMI6ScEWyfWdMlCOhnX8h3aFnBBR84BJPEfGubU9XCdBoqKpQh56ZQhnzFBkH0bozuWgxl4PuambYcPZl/JhAESY674+To+sMzW4+lN6xbTD/o7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707564590; c=relaxed/simple;
	bh=pEAynjP/rqnp+cKzSLkgoR88rIpr8nPGJhWX5svjZLM=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=dX73X1iTcgRKqvI+fEApeqYP09jDRZXs4e5wWj4lb+BKZiaDBppNkXbrHIWTo0wbVGe2n0Sku2cGKYYMFyHAd207RFClLI2tUPK+vhgmn4QKyz8cTTfpU3zGb+wbrVaOSWYbL6XCuKx4gsQeI5rE7GO1XDDhQMXJD4S71rSKo2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jynf7gOi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1D24C433C7;
	Sat, 10 Feb 2024 11:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707564590;
	bh=pEAynjP/rqnp+cKzSLkgoR88rIpr8nPGJhWX5svjZLM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=jynf7gOivBJauturrRk/6LUfG+vYsN79lb1d51N7lDVczNUm45ucqtsfWNpZw6+uR
	 VJBy2oQe3zQKVp30qXsY4q+uivbLEsOobmLhYyjEDjcazsHGVx1nmG6DTYGAb4+tPb
	 Q8A3baQiEmq2chVKxqa9o+CeIOrYt+ujavEpM/nm0oiM+1aNoz8MS1/DH2U9B+bOt7
	 NIgRoMini5LQGnuJOGJgrCESOL4b5uIKDXhtJF8KOSNlUXJjXpRjrD0ytX+Eqi1fUF
	 t3fNjJVO+9WGihYiYcoPOmxG2iQ7f2qSQPTEJn6T+UKHrdtMlUmgTWzHGYVMyzhP1L
	 ffgcf7pPFg+vw==
Date: Sat, 10 Feb 2024 11:29:48 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Sebastian Reichel <sre@kernel.org>
Cc: Fabio Estevam <festevam@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 NXP Linux Team <linux-imx@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
 linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Dong Aisheng <aisheng.dong@nxp.com>, Shawn Guo <shawnguo@kernel.org>
In-Reply-To: <20240210012114.489102-3-sre@kernel.org>
References: <20240210012114.489102-1-sre@kernel.org>
 <20240210012114.489102-3-sre@kernel.org>
Message-Id: <170756458525.4188736.15197760675687420146.robh@kernel.org>
Subject: Re: [PATCH v1 02/14] dt-bindings: bus: imx-weim: convert to YAML


On Sat, 10 Feb 2024 02:18:06 +0100, Sebastian Reichel wrote:
> Convert the i.MX  Wireless External Interface Module binding to YAML.
> 
> Signed-off-by: Sebastian Reichel <sre@kernel.org>
> ---
>  .../devicetree/bindings/bus/fsl,imx-weim.yaml | 225 ++++++++++++++++++
>  .../devicetree/bindings/bus/imx-weim.txt      | 117 ---------
>  2 files changed, 225 insertions(+), 117 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/bus/fsl,imx-weim.yaml
>  delete mode 100644 Documentation/devicetree/bindings/bus/imx-weim.txt
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/bus/fsl,imx-weim.example.dtb: nor@0,0: $nodename:0: 'nor@0,0' does not match '^(flash|.*sram|nand)(@.*)?$'
	from schema $id: http://devicetree.org/schemas/mtd/mtd-physmap.yaml#
Documentation/devicetree/bindings/bus/fsl,imx-weim.example.dtb: /example-1/weim@21b8000/acme@0,0: failed to match any schema with compatible: ['acme,whatever']

doc reference errors (make refcheckdocs):
Warning: drivers/staging/fieldbus/Documentation/devicetree/bindings/fieldbus/arcx,anybus-controller.txt references a file that doesn't exist: Documentation/devicetree/bindings/bus/imx-weim.txt
drivers/staging/fieldbus/Documentation/devicetree/bindings/fieldbus/arcx,anybus-controller.txt: Documentation/devicetree/bindings/bus/imx-weim.txt

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240210012114.489102-3-sre@kernel.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


