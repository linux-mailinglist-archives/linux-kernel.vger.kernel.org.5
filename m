Return-Path: <linux-kernel+bounces-104715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D3787D2AD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 18:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CCE01F24B4D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 17:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E64482E2;
	Fri, 15 Mar 2024 17:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJpLyYGI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885DA50A60;
	Fri, 15 Mar 2024 17:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710523347; cv=none; b=hIl9SMXFPPct2L3zWrNZjapQdgZNutLddDlwJjt/G9nsWd04Ilyi13GLb+q927pn0OnN5MUWO5Zyl8xcMlYVpFnBnTW4lzht1ag/X4X04Rmykb5TrzkqfqWFPG63swvPHeZLlmyml50zSyc5eljkuNlU+o/B2WIAn/OikZQZJvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710523347; c=relaxed/simple;
	bh=7GDKhw2QtnkDvhwA9/3K1ZC3h7d4J8wzBkO5Ddpp0oI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cmSTRjPqJIo7ZBz9I5ZIowbB2h7IjvhcX8w72PQ7SjxYWt6aH/GOMST5Ph0ec1qZYJ8H6ZXXIIOneVk63nI5TrZSje5t945I+NTaoBV9YrbtC+HkO1WFBNzQcJcMIASt+vtZgSDgbMFsuRWtrqtD6SZKH95ARg6kSHb+tNikjvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IJpLyYGI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4C5DC433C7;
	Fri, 15 Mar 2024 17:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710523347;
	bh=7GDKhw2QtnkDvhwA9/3K1ZC3h7d4J8wzBkO5Ddpp0oI=;
	h=Date:From:To:Cc:Subject:From;
	b=IJpLyYGIK98T/y1ZfxIj2qR6Wa2eKDOVi/09/RnE7eB83C28WJpGqH3Wqi3kzNuNu
	 MtF+2XflGkwSfOMvlA7n8sFnMFnqPrpuOYBpNjoJcWy69r0EzFqFXwDdHQTXKo/Jzp
	 +oZrC89hrI3HM1Y4E/W5CiM9mDEdD/QyO1SZTdpeeF5u7VQxY0q5hoCpPik7xYOrQZ
	 kaA+kbYqLPTGlDM+N9PfVkX4Nnckd45D//dlXFOYaiCerdBFBXEPA4/ROmb6Y9kc5H
	 AKp5YEcJpiivgSGy9AafFcHVDzDl6YsPh5ZvmpQXNQwiYZiHqUVoKhR5Nm7kt6hl3F
	 Rd0HuwQ4tDQDQ==
Date: Fri, 15 Mar 2024 11:22:24 -0600
From: Rob Herring <robh@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Saravana Kannan <saravanak@google.com>,
	Frank Rowand <frowand.list@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [GIT PULL] Devicetree updates for v6.9
Message-ID: <20240315172224.GA1479929-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Linus,

Please pull DT updates for v6.9.

Rob


The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-6.9

for you to fetch changes up to 7e98fe49f8896cc60c2a88c60bc535aa3e0e2564:

  dt-bindings: soc: imx: fsl,imx-anatop: add imx6q regulators (2024-03-15 10:57:36 -0600)

----------------------------------------------------------------
Devicetree updates for v6.9:

DT core:

- Add cleanup.h based auto release of struct device_node pointers via
  __free marking and new for_each_child_of_node_scoped() iterator to use
  it.

- Always create a base skeleton DT when CONFIG_OF is enabled. This
  supports several usecases of adding DT data on non-DT booted systems.

- Move around some /reserved-memory code in preparation for further
  improvements

- Add a stub for_each_property_of_node() for !OF

- Adjust the printk levels on some messages

- Fix __be32 sparse warning

- Drop RESERVEDMEM_OF_DECLARE usage from Freescale qbman driver
  (currently orphaned)

- Add Saravana Kannan and drop Frank Rowand as DT maintainers

DT bindings:

- Convert Mediatek timer, Mediatek sysirq, fsl,imx6ul-tsc,
  fsl,imx6ul-pinctrl, Atmel AIC, Atmel HLCDC, FPGA region, and
  xlnx,sd-fec to DT schemas

- Add existing, but undocumented fsl,imx-anatop binding

- Add bunch of undocumented vendor prefixes used in compatible strings

- Drop obsolete brcm,bcm2835-pm-wdt binding

- Drop obsolete i2c.txt which as been replaced with schema in dtschema

- Add DPS310 device and sort trivial-devices.yaml

- Enable undocumented compatible checks on DT binding examples

- More QCom maintainer fixes/updates

- Updates to writing-schema.rst and DT submitting-patches.rst to cover
  some frequent review comments

- Clean-up SPDX tags to use 'OR' rather than 'or'

----------------------------------------------------------------
Alexander Stein (2):
      of: property: Make 'no port node found' output a debug message
      dt-bindings: soc: imx: fsl,imx-anatop: add imx6q regulators

AngeloGioacchino Del Regno (1):
      dt-bindings: timer: mediatek: Convert to json-schema

Bartosz Golaszewski (1):
      of: make for_each_property_of_node() available to to !OF

Dawei Li (1):
      of: Make explicit cpu_to_be32 conversion to mute sparse warning

Dharma Balasubiramani (2):
      dt-bindings: display: convert Atmel's HLCDC to DT schema
      dt-bindings: interrupt-controller: Convert Atmel AIC to json-schema

Dragan Cvetic (1):
      dt-bindings: misc: xlnx,sd-fec: convert bindings to yaml

Frank Li (1):
      dt-bindings: interrupt-controller: fsl,intmux: Include power-domains support

Frank Rowand (2):
      of: Create of_root if no dtb provided by firmware
      of: unittest: treat missing of_root as error instead of fixing up

Jeffrey Hugo (2):
      dt-bindings: watchdog: qcom-wdt: Update maintainer to Rajendra Nayak
      dt-bindings: net: bluetooth: qualcomm: Fix bouncing @codeaurora

Jonathan Cameron (3):
      of: Add cleanup.h based auto release via __free(device_node) markings
      of: Introduce for_each_*_child_of_node_scoped() to automate of_node_put() handling
      of: unittest: Use for_each_child_of_node_scoped()

Krzysztof Kozlowski (10):
      docs: dt: submitting-patches: drop outdated points to TXT format
      docs: dt: submitting-patches: add commit subject prefix in reversed format
      dt-bindings: mux: restrict node name suffixes
      dt-bindings: trivial-devices: sort entries alphanumerically
      dt-bindings: misc: qcom,fastrpc: Compute callbacks can be DMA coherent
      dt-bindings: use capital "OR" for multiple licenses in SPDX
      docs: dt: writing-schema: clarify that schema should describe hardware
      docs: dt: writing-schema: explain additional/unevaluatedProperties
      docs: dt: writing-schema: document expectations on example DTS
      dt-bindings: arm: syna: remove unstable remark

Kuninori Morimoto (2):
      of: property: add missing kerneldoc for of_graph_get_endpoint_count()
      of: property: use unsigned int return on of_graph_get_endpoint_count()

Lad Prabhakar (1):
      dt-bindings: interrupt-controller: renesas,rzg2l-irqc: Update interrupts

Michal Simek (1):
      dt-bindings: fpga: Convert fpga-region binding to yaml

Ninad Palsule (1):
      dt-bindings: Add DPS310 as trivial device

Peng Fan (1):
      dt-bindings: can: fsl,flexcan: add i.MX95 compatible string

Rafał Miłecki (2):
      dt-bindings: interrupt-controller: convert MediaTek sysirq to the json-schema
      dt-bindings: vendor-prefixes: add smartrg

Rob Herring (9):
      dt-bindings: Turn on undocumented compatible checks
      MAINTAINERS: Drop Frank Rowand from DT maintainership
      MAINTAINERS: Drop my "+dt" sub-address
      dt-bindings: i2c: mux: i2c-demux-pinctrl: Drop i2c-mux.yaml reference
      dt-bindings: i2c: mux: i2c-demux-pinctrl: Define "i2c-parent" constraints
      dt-bindings: vendor-prefixes: Add missing prefixes used in compatibles
      dt-bindings: i2c: Remove obsolete i2c.txt
      soc: fsl: qbman: Remove RESERVEDMEM_OF_DECLARE usage
      of: Move all FDT reserved-memory handling into of_reserved_mem.c

Saravana Kannan (1):
      MAINTAINERS: of: Add Saravana Kannan

Sebastian Reichel (6):
      dt-bindings: lcdif: Do not require power-domains for i.MX6ULL
      dt-bindings: pinctrl: fsl,imx6ul-pinctrl: convert to YAML
      dt-bindings: input: touchscreen: fsl,imx6ul-tsc convert to YAML
      dt-bindings: soc: imx: fsl,imx-anatop: add binding
      dt-bindings: soc: imx: fsl,imx-iomuxc-gpr: add imx6
      dt-bindings: fsl-imx-sdma: fix HDMI audio index

Stanislav Jakubek (1):
      dt-bindings: watchdog: drop obsolete brcm,bcm2835-pm-wdt bindings

Stephen Boyd (4):
      of: Always unflatten in unflatten_and_copy_device_tree()
      um: Unconditionally call unflatten_device_tree()
      x86/of: Unconditionally call unflatten_and_copy_device_tree()
      of: Add KUnit test to confirm DTB is loaded

Uwe Kleine-König (1):
      of/platform: Inform about created platform devices using pr_debug()

 Documentation/devicetree/bindings/Makefile         |   3 -
 Documentation/devicetree/bindings/arm/syna.txt     |  12 -
 .../atmel/atmel,hlcdc-display-controller.yaml      |  63 +++
 .../devicetree/bindings/display/atmel/hlcdc-dc.txt |  75 ----
 .../devicetree/bindings/display/fsl,lcdif.yaml     |   8 +-
 .../bindings/display/panel/visionox,r66451.yaml    |   2 +-
 .../devicetree/bindings/dma/fsl,imx-sdma.yaml      |   3 +-
 .../devicetree/bindings/fpga/fpga-region.txt       | 479 ---------------------
 .../devicetree/bindings/fpga/fpga-region.yaml      | 358 +++++++++++++++
 .../bindings/gpio/gateworks,pld-gpio.txt           |   3 +-
 .../devicetree/bindings/gpio/mrvl-gpio.yaml        |   2 +-
 .../devicetree/bindings/i2c/i2c-demux-pinctrl.yaml |   3 +-
 Documentation/devicetree/bindings/i2c/i2c-pxa.yaml |   2 +-
 Documentation/devicetree/bindings/i2c/i2c.txt      | 151 -------
 .../bindings/i2c/nvidia,tegra186-bpmp-i2c.yaml     |   3 +-
 Documentation/devicetree/bindings/i3c/i3c.yaml     |   2 +-
 .../bindings/input/touchscreen/fsl,imx6ul-tsc.yaml |  97 +++++
 .../bindings/input/touchscreen/imx6ul_tsc.txt      |  38 --
 .../bindings/interrupt-controller/atmel,aic.txt    |  43 --
 .../bindings/interrupt-controller/atmel,aic.yaml   |  89 ++++
 .../bindings/interrupt-controller/fsl,intmux.yaml  |   3 +
 .../mediatek,mt6577-sysirq.yaml                    |  85 ++++
 .../interrupt-controller/mediatek,sysirq.txt       |  44 --
 .../interrupt-controller/renesas,rzg2l-irqc.yaml   |  44 +-
 .../devicetree/bindings/misc/qcom,fastrpc.yaml     |   2 +
 .../devicetree/bindings/misc/xlnx,sd-fec.txt       |  58 ---
 .../devicetree/bindings/misc/xlnx,sd-fec.yaml      | 140 ++++++
 .../devicetree/bindings/mux/mux-controller.yaml    |   2 +-
 .../bindings/net/bluetooth/qualcomm-bluetooth.yaml |   4 +-
 .../devicetree/bindings/net/can/fsl,flexcan.yaml   |   3 +
 .../bindings/pinctrl/fsl,imx6ul-pinctrl.txt        |  37 --
 .../bindings/pinctrl/fsl,imx6ul-pinctrl.yaml       | 116 +++++
 .../devicetree/bindings/rtc/sa1100-rtc.yaml        |   2 +-
 .../bindings/soc/imx/fsl,imx-anatop.yaml           | 128 ++++++
 .../bindings/soc/imx/fsl,imx-iomuxc-gpr.yaml       |  18 +-
 Documentation/devicetree/bindings/sound/cs4341.txt |   2 +-
 .../devicetree/bindings/submitting-patches.rst     |  23 +-
 .../bindings/timer/mediatek,mtk-timer.txt          |  48 ---
 .../devicetree/bindings/timer/mediatek,timer.yaml  |  84 ++++
 .../devicetree/bindings/timer/mrvl,mmp-timer.yaml  |   2 +-
 .../devicetree/bindings/trivial-devices.yaml       |  75 ++--
 .../devicetree/bindings/usb/cypress,hx3.yaml       |   2 +-
 .../devicetree/bindings/vendor-prefixes.yaml       |  27 ++
 .../bindings/watchdog/brcm,bcm2835-pm-wdog.txt     |  18 -
 .../devicetree/bindings/watchdog/qcom-wdt.yaml     |   2 +-
 .../devicetree/bindings/writing-schema.rst         |  30 +-
 Documentation/misc-devices/xilinx_sdfec.rst        |   2 +-
 MAINTAINERS                                        |   9 +-
 arch/um/kernel/dtb.c                               |  16 +-
 arch/x86/kernel/devicetree.c                       |  26 +-
 drivers/of/.kunitconfig                            |   3 +
 drivers/of/Kconfig                                 |  14 +-
 drivers/of/Makefile                                |   4 +-
 drivers/of/base.c                                  |   4 +-
 drivers/of/empty_root.dts                          |   6 +
 drivers/of/fdt.c                                   | 187 +++-----
 drivers/of/of_private.h                            |   5 +-
 drivers/of/of_reserved_mem.c                       | 125 +++++-
 drivers/of/of_test.c                               |  57 +++
 drivers/of/platform.c                              |   5 +-
 drivers/of/property.c                              |  12 +-
 drivers/of/unittest.c                              |  27 +-
 drivers/soc/fsl/qbman/bman_ccsr.c                  |  27 +-
 drivers/soc/fsl/qbman/dpaa_sys.c                   |  12 +-
 drivers/soc/fsl/qbman/dpaa_sys.h                   |   4 +-
 drivers/soc/fsl/qbman/qman_ccsr.c                  |  73 +---
 include/dt-bindings/power/amlogic,c3-pwrc.h        |   2 +-
 include/linux/of.h                                 |  46 +-
 include/linux/of_graph.h                           |   4 +-
 69 files changed, 1722 insertions(+), 1383 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/atmel/atmel,hlcdc-display-controller.yaml
 delete mode 100644 Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt
 delete mode 100644 Documentation/devicetree/bindings/fpga/fpga-region.txt
 create mode 100644 Documentation/devicetree/bindings/fpga/fpga-region.yaml
 delete mode 100644 Documentation/devicetree/bindings/i2c/i2c.txt
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/fsl,imx6ul-tsc.yaml
 delete mode 100644 Documentation/devicetree/bindings/input/touchscreen/imx6ul_tsc.txt
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/atmel,aic.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/atmel,aic.yaml
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/mediatek,mt6577-sysirq.yaml
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt
 delete mode 100644 Documentation/devicetree/bindings/misc/xlnx,sd-fec.txt
 create mode 100644 Documentation/devicetree/bindings/misc/xlnx,sd-fec.yaml
 delete mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,imx6ul-pinctrl.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,imx6ul-pinctrl.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx-anatop.yaml
 delete mode 100644 Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
 create mode 100644 Documentation/devicetree/bindings/timer/mediatek,timer.yaml
 delete mode 100644 Documentation/devicetree/bindings/watchdog/brcm,bcm2835-pm-wdog.txt
 create mode 100644 drivers/of/.kunitconfig
 create mode 100644 drivers/of/empty_root.dts
 create mode 100644 drivers/of/of_test.c

