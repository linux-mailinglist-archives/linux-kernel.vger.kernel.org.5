Return-Path: <linux-kernel+bounces-62916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D53AC8527CE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 04:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B45EB250A5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 03:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A48AD24;
	Tue, 13 Feb 2024 03:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rzLqbW6R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4B4A929;
	Tue, 13 Feb 2024 03:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707795502; cv=none; b=gxD8MPDNFvsDmBI2/GD2CxB4rkPH+OoYbpSul38bsgVIAmYbdvO5PXIhFV+1iLDqcp2HW5IgUd4qCBni6ByktpiajfgWpF7YbK6qCysoNJ4dXv/yM3LvHZPO9bPetxsbmPMyQeCUQPJCJ6Mu4rPo3ZwKmDl4hDq1kAgBojI4V9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707795502; c=relaxed/simple;
	bh=kwHg/8yeDZh54hwz8uAm2M9HXikrnVyKxYeaYuDaks8=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=Q8rRmt3DUIjzMqxeMy4aNdVTQpFwdNe8dlv4N0YdGNKiCC13Y96Nzo//jFqQExE6tWqiGr6WbOGmuwn0xHiZlBcC4AXJRODOtJwIs6HtTDsxjDGtW1nGwn8BAlytZVvQ2lnLDsKzvanTTONr2qWuwUyQcZ/T7gV+xHIQ2mpSGWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rzLqbW6R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E887DC433F1;
	Tue, 13 Feb 2024 03:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707795502;
	bh=kwHg/8yeDZh54hwz8uAm2M9HXikrnVyKxYeaYuDaks8=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=rzLqbW6R5Hmi6zNkXMZjPbZbCym+9Q/jGRNYl8bQuDqEbNbi3JcEuyx99bWAuVXa/
	 cDlR5/fdrVOJkdJOZBddXvKF+7QE9ahDycPrzH870c7B80/ffWazcqkjDBnorx3Nyy
	 xkKmwizKe23xCn2UPZNQX7SBg3JQ4rjRpTjmGxvNDssdHehhgJue3EmpLcBod3losk
	 PUETEcWgl3Q225G0zU+ypS+cZliaFo2HADSVQPBVTExlQ0bQ+shPS0niW4ZLM7pEfB
	 ZRSoIjXrj/BB+KCD7EkaH6aFyKhCIx88GMaAnQwA4VOkAQTNipL+lOlLtcbaY6Hq0t
	 eqtfm2fIC5A1Q==
Date: Mon, 12 Feb 2024 21:38:20 -0600
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
Cc: linux-kernel@vger.kernel.org, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 NXP Linux Team <linux-imx@nxp.com>, Fabio Estevam <festevam@gmail.com>, 
 devicetree@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Shawn Guo <shawnguo@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 Conor Dooley <conor+dt@kernel.org>, Dong Aisheng <aisheng.dong@nxp.com>
In-Reply-To: <20240213010347.1075251-3-sre@kernel.org>
References: <20240213010347.1075251-1-sre@kernel.org>
 <20240213010347.1075251-3-sre@kernel.org>
Message-Id: <170779549979.3767632.14798050917184496330.robh@kernel.org>
Subject: Re: [PATCH v2 02/17] dt-bindings: bus: imx-weim: convert to YAML


On Tue, 13 Feb 2024 02:00:51 +0100, Sebastian Reichel wrote:
> Convert the i.MX  Wireless External Interface Module binding to YAML.
> 
> Signed-off-by: Sebastian Reichel <sre@kernel.org>
> ---
>  .../devicetree/bindings/bus/imx-weim.txt      | 117 ----------
>  .../fsl/fsl,imx-weim-peripherals.yaml         |  36 ++++
>  .../memory-controllers/fsl/fsl,imx-weim.yaml  | 201 ++++++++++++++++++
>  .../mc-peripheral-props.yaml                  |   1 +
>  .../fieldbus/arcx,anybus-controller.txt       |   2 +-
>  5 files changed, 239 insertions(+), 118 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/bus/imx-weim.txt
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/fsl/fsl,imx-weim-peripherals.yaml
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/fsl/fsl,imx-weim.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/bus/socionext,uniphier-system-bus.example.dtb: serial@5,200000: 'fsl,weim-cs-timing' is a required property
	from schema $id: http://devicetree.org/schemas/serial/8250.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/memory-controllers/intel,ixp4xx-expansion-bus-controller.example.dtb: flash@0,0: 'fsl,weim-cs-timing' is a required property
	from schema $id: http://devicetree.org/schemas/mtd/mtd-physmap.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/memory-controllers/intel,ixp4xx-expansion-bus-controller.example.dtb: serial@1,0: 'fsl,weim-cs-timing' is a required property
	from schema $id: http://devicetree.org/schemas/serial/8250.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/memory-controllers/intel,ixp4xx-expansion-bus-controller.example.dtb: serial@1,0: Unevaluated properties are not allowed ('intel,ixp4xx-eb-byte-access', 'intel,ixp4xx-eb-cycle-type', 'intel,ixp4xx-eb-t3', 'intel,ixp4xx-eb-write-enable' were unexpected)
	from schema $id: http://devicetree.org/schemas/serial/8250.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/memory-controllers/fsl/fsl,ifc.example.dtb: flash@0,0: 'fsl,weim-cs-timing' is a required property
	from schema $id: http://devicetree.org/schemas/mtd/mtd-physmap.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/memory-controllers/ingenic,nemc.example.dtb: memory-controller@13410000: ethernet@6: 'fsl,weim-cs-timing' is a required property
	from schema $id: http://devicetree.org/schemas/memory-controllers/ingenic,nemc.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/memory-controllers/ingenic,nemc.example.dtb: ethernet@6: 'fsl,weim-cs-timing' is a required property
	from schema $id: http://devicetree.org/schemas/net/davicom,dm9000.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/memory-controllers/ingenic,nemc.example.dtb: ethernet@6: Unevaluated properties are not allowed ('ingenic,nemc-tAH', 'ingenic,nemc-tAS', 'ingenic,nemc-tAW', 'ingenic,nemc-tBP', 'ingenic,nemc-tSTRV' were unexpected)
	from schema $id: http://devicetree.org/schemas/net/davicom,dm9000.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/memory-controllers/st,stm32-fmc2-ebi.example.dtb: memory-controller@58002000: psram@0,0: 'fsl,weim-cs-timing' is a required property
	from schema $id: http://devicetree.org/schemas/memory-controllers/st,stm32-fmc2-ebi.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/memory-controllers/st,stm32-fmc2-ebi.example.dtb: memory-controller@58002000: nand-controller@4,0: 'fsl,weim-cs-timing' is a required property
	from schema $id: http://devicetree.org/schemas/memory-controllers/st,stm32-fmc2-ebi.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/memory-controllers/st,stm32-fmc2-ebi.example.dtb: psram@0,0: 'fsl,weim-cs-timing' is a required property
	from schema $id: http://devicetree.org/schemas/mtd/mtd-physmap.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/watchdog/maxim,max63xx.example.dtb: watchdog@50000000: 'fsl,weim-cs-timing' is a required property
	from schema $id: http://devicetree.org/schemas/watchdog/maxim,max63xx.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/serial/serial.example.dtb: serial@1234: 'fsl,weim-cs-timing' is a required property
	from schema $id: http://devicetree.org/schemas/serial/8250.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/serial/8250.example.dtb: serial@80230000: 'fsl,weim-cs-timing' is a required property
	from schema $id: http://devicetree.org/schemas/serial/8250.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/serial/8250.example.dtb: serial@49042000: 'fsl,weim-cs-timing' is a required property
	from schema $id: http://devicetree.org/schemas/serial/8250.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/serial/8250.example.dtb: serial@1e787000: 'fsl,weim-cs-timing' is a required property
	from schema $id: http://devicetree.org/schemas/serial/8250.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/davicom,dm9000.example.dtb: ethernet@a8000000: 'fsl,weim-cs-timing' is a required property
	from schema $id: http://devicetree.org/schemas/net/davicom,dm9000.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/micrel,ks8851.example.dtb: ethernet@1,0: 'fsl,weim-cs-timing' is a required property
	from schema $id: http://devicetree.org/schemas/net/micrel,ks8851.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mtd/ti,am654-hbmc.example.dtb: memory-controller@47034000: flash@0,0: 'fsl,weim-cs-timing' is a required property
	from schema $id: http://devicetree.org/schemas/mtd/ti,am654-hbmc.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mtd/ti,am654-hbmc.example.dtb: flash@0,0: 'fsl,weim-cs-timing' is a required property
	from schema $id: http://devicetree.org/schemas/mtd/mtd-physmap.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mtd/mtd-physmap.example.dtb: flash@ff000000: 'fsl,weim-cs-timing' is a required property
	from schema $id: http://devicetree.org/schemas/mtd/mtd-physmap.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mtd/mtd-physmap.example.dtb: flash@0: 'fsl,weim-cs-timing' is a required property
	from schema $id: http://devicetree.org/schemas/mtd/mtd-physmap.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mtd/mtd-physmap.example.dtb: sram@2,0: 'fsl,weim-cs-timing' is a required property
	from schema $id: http://devicetree.org/schemas/mtd/mtd-physmap.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mtd/mtd-physmap.example.dtb: flash@20000000: 'fsl,weim-cs-timing' is a required property
	from schema $id: http://devicetree.org/schemas/mtd/mtd-physmap.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mtd/ingenic,nand.example.dtb: memory-controller@13410000: nand-controller@1: 'fsl,weim-cs-timing' is a required property
	from schema $id: http://devicetree.org/schemas/memory-controllers/ingenic,nemc.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240213010347.1075251-3-sre@kernel.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


