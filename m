Return-Path: <linux-kernel+bounces-69426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6DD8588E6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 23:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04BC51F21DC0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 22:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D792814A0B6;
	Fri, 16 Feb 2024 22:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ceGIhwRt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1DD14831E;
	Fri, 16 Feb 2024 22:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708123020; cv=none; b=AJOAKTZDnBOJ1/RA2FcgBGwL6MneRDAQcK24Mes+2BZAzRhGffDSDjucwxkkfUOjxzp1KRxoIpP0oIyx2deSJOR0/g+ii7w+nXJeByMeIpQEnUo4wkZlKbV7bXinruU6wDgA3aMCh7hxkV0xicX8EWAfKXLcTjqEIXuQzxwPxaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708123020; c=relaxed/simple;
	bh=eJIaDZ7rjnMFktwjotvFLcESURdj1UH+fKntueNKal8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T/J6uQBJVG/+9z/5xQIZyz/YCVthOV2ieHVBUxU3CD14zX0/YVuYKbuUPScym7VrU6F1v/Y1zGYVhF+Rk8qMrOxvkxkPOT5BIIbAGF3Tm15X1mhDFVV7ng/5CZAtGURVtPJiJ3f/RDvpe9JcFBNZOccgkvRKO3J6fSra5c7m3IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ceGIhwRt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EF0DC43390;
	Fri, 16 Feb 2024 22:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708123019;
	bh=eJIaDZ7rjnMFktwjotvFLcESURdj1UH+fKntueNKal8=;
	h=From:To:Cc:Subject:Date:From;
	b=ceGIhwRtCOjKE6/hp2iveWbcgQxDHInN0jP5U8DEPYIirqzCCKfx0/OSbieNF3NgV
	 HVny9G3RyBYZry2mSh6uBbkk9f+fZm1L7kkCWSAEFpmmRf6BBeZm4mMgc1n1Hlu7cg
	 Z2MX1sdkHnKw/y63QFZNxSupxOtAxCAjS0xd3dWTVfPRV+XWxJ1TrW4F4EtkNOWCBa
	 7eJTCEuDqtFjnMFuydsP1jBq5FVkw45wfw+n9oUjQXxJg/SL51YfuRXTqBta21xzHT
	 UsYkE630OnwHIGYvMHVXA0Typ3HqIqkiE2b/whKNCib4Tn4jZ7NHbNFpgodYcfhCDw
	 XFNQUY5I3M/oQ==
Received: by mercury (Postfix, from userid 1000)
	id 890981061C38; Fri, 16 Feb 2024 23:36:56 +0100 (CET)
From: Sebastian Reichel <sre@kernel.org>
To: Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	NXP Linux Team <linux-imx@nxp.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v3 00/16] UNI-T UTi260B support
Date: Fri, 16 Feb 2024 23:34:19 +0100
Message-ID: <20240216223654.1312880-1-sre@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sebastian Reichel <sebastian.reichel@collabora.com>

Hi,

This adds adds support for the UNI-T UTi260B thermal camera, which is based
on i.MX6ULL. Patches 1-14 clean up all warnings reported by CHECK_DTBS for
i.MX6ULL (i.e. for an empty board). They are not specific to the UTi260B and
in fact that machine has most of the IP handled by these patches marked as
disabled. Then patches 15+16 introduce the vendor and board compatible DT
bindings. Finally the last patches adds support for the thermal camera itself.

The DT is based on reverse engineered information. More information about
the device can be found in this presentation from Embedded Recipes 2023:

 * https://embedded-recipes.org/2023/wp-content/uploads/2023/10/Running-FOSS-on-a-Thermal-Camera-Sebastian-Reichel-compressed.pdf
 * https://www.youtube.com/watch?v=uvObsCG-Cqo

I also prepared a branch with these patches (and a minimal kernel config)
and published it here:

https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-misc.git/log/?h=uti260b-v3

Changes since PATCHv2:
 * https://lore.kernel.org/all/20240213010347.1075251-1-sre@kernel.org/
  - drop fsl,imx-asrc YAML binding conversion (merged)
  - collect a bunch of Reviewed-by/Acked-by tags
  - weim DT binding: fix issue with requirements
  - xnur-gpio -> xnur-gpios change: Improve patch long description

Changes since PATCHv1:
 * https://lore.kernel.org/all/20240210012114.489102-1-sre@kernel.org/
  - uni-t,imx6ull-uti260b -> uni-t,uti260b
  - add Acked-by for uni-t vendor prefix
  - add Acked-by for HDMI audio index fix
  - add Acked-by for LCDIF power-domain requirement drop
  - anatop DT binding: Fixed indentation in example
  - anatop DT binding: Described IRQs
  - touchscreen DT binding: change tsc@ to touchscreen@ in example
  - touchscreen DT binding: change xnur-gpio to xnur-gpios
  - weim DT binding: drop acme,whatever example
  - weim DT binding: use flash@ instead of nor@
  - weim DT binding: update weim.txt reference in arcx,anybus-controller.txt
  - weim DT binding: switch to memory-controller binding
  - fsl,imx-asrc DT binding: fix ASoC patch subject prefix
  - fsl,imx-asrc DT binding: add constraints
  - add new patch fixing xnur-gpio(s) in all i.MX6UL board DT files
  - add new patch fixing touchscreen nodename in i.MX6UL SoC DT file
  - add new patch fixing weim nodename in all i.MX SoC DT files
  - device DTS: use color/functions for the led
  - device DTS: increase SPI speed
  - device DTS: add comment for SD / eMMC node

Unadressed feedback from PATCHv1:
  - anatop phandle vs parent: technically it makes sense to just use the
    parent, but this driver is only used by i.MX6. The current code makes
	use of the phandle, so we cannot drop it because of backwards
	compatibility. So I don't see a point in deprecating this property.
  - touchscreen binding: I kept measure-delay-time and pre-charge-time
    values in hex, since that is being used everywhere and the unit
	is unknown. The values are directly written into HW registers and
	the i.MX6UL TRM does not provide any hints about the unit. I do not
	have an i.MX6UL device with a touchsreen, so I cannot test either.
  - regulator name in DT: I did not rename the regulators to just
    "regulator", since the nodename must be unique.

Greetings,

-- Sebastian

Sebastian Reichel (16):
  dt-bindings: pinctrl: fsl,imx6ul-pinctrl: convert to YAML
  dt-bindings: bus: imx-weim: convert to YAML
  dt-bindings: input: touchscreen: fsl,imx6ul-tsc convert to YAML
  dt-bindings: soc: imx: fsl,imx-anatop: add binding
  dt-bindings: soc: imx: fsl,imx-iomuxc-gpr: add imx6
  dt-bindings: lcdif: Do not require power-domains for i.MX6ULL
  dt-bindings: fsl-imx-sdma: fix HDMI audio index
  ARM: dts: imx6ull: fix pinctrl node name
  ARM: dts: imx6ul: Remove fsl,anatop from usbotg1
  ARM: dts: imx6ul: add missing #thermal-sensor-cells
  ARM: dts: nxp: imx6ul: xnur-gpio -> xnur-gpios
  ARM: dts: nxp: imx6ul: fix touchscreen node name
  ARM: dts: nxp: imx: fix weim node name
  dt-bindings: vendor-prefixes: add UNI-T
  dt-bindings: arm: add UNI-T UTi260B
  ARM: dts: imx6ull-uti260b: Add board

 .../devicetree/bindings/arm/fsl.yaml          |   1 +
 .../devicetree/bindings/bus/imx-weim.txt      | 117 ----
 .../bindings/display/fsl,lcdif.yaml           |   8 +-
 .../devicetree/bindings/dma/fsl,imx-sdma.yaml |   3 +-
 .../input/touchscreen/fsl,imx6ul-tsc.yaml     |  97 +++
 .../bindings/input/touchscreen/imx6ul_tsc.txt |  38 --
 .../fsl/fsl,imx-weim-peripherals.yaml         |  31 +
 .../memory-controllers/fsl/fsl,imx-weim.yaml  | 203 +++++++
 .../mc-peripheral-props.yaml                  |   1 +
 .../bindings/pinctrl/fsl,imx6ul-pinctrl.txt   |  37 --
 .../bindings/pinctrl/fsl,imx6ul-pinctrl.yaml  | 116 ++++
 .../bindings/soc/imx/fsl,imx-anatop.yaml      | 128 ++++
 .../bindings/soc/imx/fsl,imx-iomuxc-gpr.yaml  |  18 +-
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm/boot/dts/nxp/imx/Makefile            |   1 +
 arch/arm/boot/dts/nxp/imx/imx1.dtsi           |   2 +-
 arch/arm/boot/dts/nxp/imx/imx27.dtsi          |   2 +-
 arch/arm/boot/dts/nxp/imx/imx31.dtsi          |   2 +-
 arch/arm/boot/dts/nxp/imx/imx35.dtsi          |   2 +-
 arch/arm/boot/dts/nxp/imx/imx51.dtsi          |   2 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi        |   2 +-
 arch/arm/boot/dts/nxp/imx/imx6sl.dtsi         |   2 +-
 arch/arm/boot/dts/nxp/imx/imx6sx.dtsi         |   2 +-
 .../boot/dts/nxp/imx/imx6ul-14x14-evk.dtsi    |   2 +-
 arch/arm/boot/dts/nxp/imx/imx6ul-geam.dts     |   2 +-
 .../nxp/imx/imx6ul-imx6ull-opos6uldev.dtsi    |   2 +-
 arch/arm/boot/dts/nxp/imx/imx6ul.dtsi         |   6 +-
 .../boot/dts/nxp/imx/imx6ull-dhcom-som.dtsi   |   2 +-
 arch/arm/boot/dts/nxp/imx/imx6ull-uti260b.dts | 572 ++++++++++++++++++
 arch/arm/boot/dts/nxp/imx/imx6ull.dtsi        |   2 +-
 .../fieldbus/arcx,anybus-controller.txt       |   2 +-
 31 files changed, 1195 insertions(+), 212 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/bus/imx-weim.txt
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/fsl,imx6ul-tsc.yaml
 delete mode 100644 Documentation/devicetree/bindings/input/touchscreen/imx6ul_tsc.txt
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/fsl/fsl,imx-weim-peripherals.yaml
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/fsl/fsl,imx-weim.yaml
 delete mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,imx6ul-pinctrl.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,imx6ul-pinctrl.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx-anatop.yaml
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ull-uti260b.dts

-- 
2.43.0


