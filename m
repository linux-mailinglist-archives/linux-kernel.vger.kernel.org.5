Return-Path: <linux-kernel+bounces-24803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5797482C2C2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 16:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FE0B1C21ADC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 15:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B026EB67;
	Fri, 12 Jan 2024 15:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LjUwMWRM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8556EB4C;
	Fri, 12 Jan 2024 15:32:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D888EC43399;
	Fri, 12 Jan 2024 15:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705073550;
	bh=wmOL8t5NR/xPSMgkZHegKI+IyLdAz1AEkzYz2/dO+og=;
	h=Date:From:To:Cc:Subject:From;
	b=LjUwMWRMgJtMW0EV7GaNr3R5Lbzf97VZ/zEm6UVo0n7MMIM9OMudPoeXFiJknZGW9
	 jr8Hbf6+/JV0RnHaKHXavspaQEg19Op2etriTPlfEWKPsGya3xqnDXvwxs47f644QW
	 wd/Yi1omLcPSRoFU67V8c2hXEhVN7gWO7ibexijA8lB4tpWfc3tWyuAb6TtpPtXeSK
	 xwt0+L4+f2nQE5/a37qNRmz866bk8t9NyyVdTTWu00dUAS7PlGBdQZIh5cvxsdU1kP
	 SXNGu4YM18E8JlfiEtdUIC0czhJL0/wjzXVHOcYyQW8TRfmeFNXfY/RCEeuR57okb1
	 oHZftgB7BIWFQ==
Date: Fri, 12 Jan 2024 09:32:27 -0600
From: Rob Herring <robh@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Frank Rowand <frowand.list@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [GIT PULL] Devicetree updates for v6.8
Message-ID: <20240112153227.GA3368286-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Linus,

Please pull DT updates for v6.8.

Note that I have a final DT header detangling patch[1] to send as well. 
I'll be doing that once all the dependencies are merged towards the end 
of the merge window.

Rob

[1] https://lore.kernel.org/all/20231129164316.2663565-1-robh@kernel.org/


The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-6.8

for you to fetch changes up to 716089b417cf98d01f0dc1b39f9c47e1d7b4c965:

  of: unittest: Fix of_count_phandle_with_args() expected value message (2024-01-11 16:18:30 -0600)

----------------------------------------------------------------
Devicetree for v6.8:

- Convert FPGA bridge, all TPMs (finally), and Rockchip HDMI bindings to
  schemas

- Improvements in Samsung GPU schemas

- A few more cases of dropping unneeded quotes in schemas

- Merge QCom idle-states txt binding into common idle-states schema

- Add X1E80100, SM8650, SM8650, and SDX75 SoCs to QCom Power Domain
  Controller

- Add NXP i.mx8dl to SCU PD

- Add synaptics r63353 panel controller

- Clarify the wording around the use of 'wakeup-source' property

- Add a DTS coding style doc

- Add smi vendor prefix

- Fix DT_SCHEMA_FILES incorrect matching of paths outside the kernel
  tree

- Disable sysfb (e.g. EFI FB) when simple-framebuffer node is present

- Fix double free in of_parse_phandle_with_args_map()

- A couple of kerneldoc fixes

----------------------------------------------------------------
Abel Vesa (1):
      dt-bindings: qcom,pdc: Add compatible for SM8550

Alex Bee (1):
      dt-bindings: display: rockchip,inno-hdmi: Document RK3128 compatible

André Draszik (1):
      dt-bindings: ignore paths outside kernel for DT_SCHEMA_FILES

Christian A. Ehrhardt (1):
      of: Fix double free in of_parse_phandle_with_args_map

David Heidelberg (1):
      dt-bindings: arm: merge qcom,idle-state with idle-state

Fabio Estevam (1):
      dt-bindings: power: fsl,scu-pd: Document imx8dl

Geert Uytterhoeven (1):
      of: unittest: Fix of_count_phandle_with_args() expected value message

Javier Martinez Canillas (1):
      of/platform: Disable sysfb if a simple-framebuffer node is found

Johan Hovold (1):
      of: fix recursion typo in kernel doc

Johan Jonker (1):
      dt-bindings: drm: rockchip: convert inno_hdmi-rockchip.txt to yaml

Krzysztof Kozlowski (8):
      dt-bindings: correct white-spaces in examples
      docs: dt-bindings: add DTS Coding Style document
      dt-bindings: gpu: samsung-rotator: drop redundant quotes
      dt-bindings: gpu: samsung: re-order entries to match coding convention
      dt-bindings: gpu: samsung: constrain clocks in top-level properties
      dt-bindings: gpu: samsung-g2d: constrain iommus and power-domains
      dt-bindings: gpu: samsung-scaler: constrain iommus and power-domains
      dt-bindings: cache: qcom,llcc: correct QDU1000 reg entries

Luca Ceresoli (1):
      of: overlay: enable of_overlay_fdt_apply() kerneldoc

Lukas Wunner (4):
      dt-bindings: tpm: Consolidate TCG TIS bindings
      dt-bindings: tpm: Convert Google Cr50 bindings to DT schema
      dt-bindings: tpm: Convert IBM vTPM bindings to DT schema
      dt-bindings: tpm: Document Microsoft fTPM bindings

Mao Jinlong (1):
      dt-bindings: arm: Add remote etm dt-binding

Mark Hasemeyer (1):
      dt-bindings: power: Clarify wording for wakeup-source property

Michael Trimarchi (1):
      dt-bindings: display: panel: Add synaptics r63353 panel controller

Michal Simek (2):
      dt-bindings: fpga: Convert bridge binding to yaml
      dt-bindings: fpga: altera: Convert bridge bindings to yaml

Muzammil Ashraf (1):
      drivers: of: Fixed kernel doc warning

Neil Armstrong (1):
      dt-bindings: qcom,pdc: document the SM8650 Power Domain Controller

Rob Herring (4):
      dt-bindings: fsl,dpaa2-console: drop unneeded quotes
      dt-bindings: arm/calxeda: drop unneeded quotes
      media: dt-bindings: samsung,s5p-mfc: Fix iommu properties schemas
      dt-bindings: mmc: sdhci-pxa: Fix 'regs' typo

Rohit Agarwal (1):
      dt-bindings: interrupt-controller: Add SDX75 PDC compatible

Sibi Sankar (1):
      dt-bindings: interrupt-controller: qcom,pdc: document pdc on X1E80100

Yoshinori Sato (1):
      dt-bindings: vendor-prefixes: Add smi

 Documentation/devicetree/bindings/Makefile         |   2 +-
 .../devicetree/bindings/arm/calxeda/l2ecc.yaml     |   2 +-
 .../bindings/arm/msm/qcom,idle-state.txt           |  84 ---------
 .../bindings/arm/qcom,coresight-remote-etm.yaml    |  51 ++++++
 .../bindings/auxdisplay/hit,hd44780.yaml           |   2 +-
 .../devicetree/bindings/cache/qcom,llcc.yaml       |   2 +-
 .../bindings/clock/baikal,bt1-ccu-pll.yaml         |   2 +-
 .../devicetree/bindings/cpu/idle-states.yaml       |  81 ++++++++-
 .../bindings/display/panel/synaptics,r63353.yaml   |  61 +++++++
 .../display/rockchip/inno_hdmi-rockchip.txt        |  49 ------
 .../display/rockchip/rockchip,inno-hdmi.yaml       | 139 +++++++++++++++
 .../devicetree/bindings/dts-coding-style.rst       | 196 +++++++++++++++++++++
 .../bindings/fpga/altera-fpga2sdram-bridge.txt     |  13 --
 .../bindings/fpga/altera-freeze-bridge.txt         |  20 ---
 .../bindings/fpga/altera-hps2fpga-bridge.txt       |  36 ----
 .../fpga/altr,freeze-bridge-controller.yaml        |  41 +++++
 .../fpga/altr,socfpga-fpga2sdram-bridge.yaml       |  33 ++++
 .../fpga/altr,socfpga-hps2fpga-bridge.yaml         |  49 ++++++
 .../devicetree/bindings/fpga/fpga-bridge.txt       |  13 --
 .../devicetree/bindings/fpga/fpga-bridge.yaml      |  30 ++++
 .../bindings/fpga/xlnx,pr-decoupler.yaml           |   5 +-
 .../devicetree/bindings/gpu/samsung-g2d.yaml       |  71 ++++----
 .../devicetree/bindings/gpu/samsung-rotator.yaml   |   9 +-
 .../devicetree/bindings/gpu/samsung-scaler.yaml    |  81 +++++----
 .../devicetree/bindings/iio/adc/adi,ad7780.yaml    |   6 +-
 .../bindings/iio/adc/qcom,spmi-iadc.yaml           |   2 +-
 .../bindings/iio/adc/qcom,spmi-rradc.yaml          |   2 +-
 Documentation/devicetree/bindings/index.rst        |   1 +
 .../bindings/interrupt-controller/qcom,pdc.yaml    |   4 +
 .../st,stih407-irq-syscfg.yaml                     |   4 +-
 .../devicetree/bindings/media/samsung,s5p-mfc.yaml |  33 ++--
 .../bindings/misc/fsl,dpaa2-console.yaml           |   2 +-
 .../devicetree/bindings/mmc/arm,pl18x.yaml         |   2 +-
 .../devicetree/bindings/mmc/sdhci-pxa.yaml         |   4 +-
 Documentation/devicetree/bindings/net/sff,sfp.yaml |   2 +-
 .../bindings/pci/toshiba,visconti-pcie.yaml        |   2 +-
 .../bindings/pinctrl/renesas,rzg2l-pinctrl.yaml    |   6 +-
 .../devicetree/bindings/power/fsl,scu-pd.yaml      |   1 +
 .../bindings/power/supply/richtek,rt9455.yaml      |   8 +-
 .../devicetree/bindings/power/wakeup-source.txt    |  18 +-
 .../devicetree/bindings/regulator/mps,mp5416.yaml  |   4 +-
 .../devicetree/bindings/regulator/mps,mpq7920.yaml |   4 +-
 .../bindings/remoteproc/fsl,imx-rproc.yaml         |   8 +-
 .../bindings/security/tpm/google,cr50.txt          |  19 --
 .../devicetree/bindings/security/tpm/ibmvtpm.txt   |  41 -----
 .../bindings/security/tpm/st33zp24-i2c.txt         |  34 ----
 .../bindings/security/tpm/st33zp24-spi.txt         |  32 ----
 .../devicetree/bindings/security/tpm/tpm-i2c.txt   |  26 ---
 .../bindings/security/tpm/tpm_tis_mmio.txt         |  25 ---
 .../bindings/security/tpm/tpm_tis_spi.txt          |  23 ---
 .../devicetree/bindings/tpm/google,cr50.yaml       |  65 +++++++
 .../devicetree/bindings/tpm/ibm,vtpm.yaml          | 104 +++++++++++
 .../devicetree/bindings/tpm/microsoft,ftpm.yaml    |  47 +++++
 .../devicetree/bindings/tpm/tcg,tpm-tis-i2c.yaml   |  90 ++++++++++
 .../devicetree/bindings/tpm/tcg,tpm-tis-mmio.yaml  |  49 ++++++
 .../devicetree/bindings/tpm/tcg,tpm_tis-spi.yaml   |  75 ++++++++
 .../devicetree/bindings/tpm/tpm-common.yaml        |  87 +++++++++
 .../devicetree/bindings/trivial-devices.yaml       |  16 --
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 drivers/of/base.c                                  |   1 +
 drivers/of/overlay.c                               |   2 +-
 drivers/of/platform.c                              |  22 ++-
 drivers/of/property.c                              |   7 +-
 drivers/of/unittest-data/tests-phandle.dtsi        |  10 +-
 drivers/of/unittest.c                              |  74 ++++----
 65 files changed, 1432 insertions(+), 604 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,idle-state.txt
 create mode 100644 Documentation/devicetree/bindings/arm/qcom,coresight-remote-etm.yaml
 create mode 100644 Documentation/devicetree/bindings/display/panel/synaptics,r63353.yaml
 delete mode 100644 Documentation/devicetree/bindings/display/rockchip/inno_hdmi-rockchip.txt
 create mode 100644 Documentation/devicetree/bindings/display/rockchip/rockchip,inno-hdmi.yaml
 create mode 100644 Documentation/devicetree/bindings/dts-coding-style.rst
 delete mode 100644 Documentation/devicetree/bindings/fpga/altera-fpga2sdram-bridge.txt
 delete mode 100644 Documentation/devicetree/bindings/fpga/altera-freeze-bridge.txt
 delete mode 100644 Documentation/devicetree/bindings/fpga/altera-hps2fpga-bridge.txt
 create mode 100644 Documentation/devicetree/bindings/fpga/altr,freeze-bridge-controller.yaml
 create mode 100644 Documentation/devicetree/bindings/fpga/altr,socfpga-fpga2sdram-bridge.yaml
 create mode 100644 Documentation/devicetree/bindings/fpga/altr,socfpga-hps2fpga-bridge.yaml
 delete mode 100644 Documentation/devicetree/bindings/fpga/fpga-bridge.txt
 create mode 100644 Documentation/devicetree/bindings/fpga/fpga-bridge.yaml
 delete mode 100644 Documentation/devicetree/bindings/security/tpm/google,cr50.txt
 delete mode 100644 Documentation/devicetree/bindings/security/tpm/ibmvtpm.txt
 delete mode 100644 Documentation/devicetree/bindings/security/tpm/st33zp24-i2c.txt
 delete mode 100644 Documentation/devicetree/bindings/security/tpm/st33zp24-spi.txt
 delete mode 100644 Documentation/devicetree/bindings/security/tpm/tpm-i2c.txt
 delete mode 100644 Documentation/devicetree/bindings/security/tpm/tpm_tis_mmio.txt
 delete mode 100644 Documentation/devicetree/bindings/security/tpm/tpm_tis_spi.txt
 create mode 100644 Documentation/devicetree/bindings/tpm/google,cr50.yaml
 create mode 100644 Documentation/devicetree/bindings/tpm/ibm,vtpm.yaml
 create mode 100644 Documentation/devicetree/bindings/tpm/microsoft,ftpm.yaml
 create mode 100644 Documentation/devicetree/bindings/tpm/tcg,tpm-tis-i2c.yaml
 create mode 100644 Documentation/devicetree/bindings/tpm/tcg,tpm-tis-mmio.yaml
 create mode 100644 Documentation/devicetree/bindings/tpm/tcg,tpm_tis-spi.yaml
 create mode 100644 Documentation/devicetree/bindings/tpm/tpm-common.yaml

