Return-Path: <linux-kernel+bounces-27581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B10582F277
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 17:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F4751C21618
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 16:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4AC01CA81;
	Tue, 16 Jan 2024 16:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D1Jk8Xch"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F135E1C6BC
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 16:37:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A45B1C433F1;
	Tue, 16 Jan 2024 16:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705423033;
	bh=6dB1AqwPJtX0pwz5lDQm9Gych2HwxUEWjNxLzzaaPr8=;
	h=Date:From:To:Cc:Subject:From;
	b=D1Jk8Xchnt1Qh/DENRshXH8pqNOuFA3OkPUvt2zLBhgidjirOx5d96Q+jK4wos2FK
	 TrQPynUbV5AAdC1ECMctmqlIZYOeZxkPLmrAb39Rh3RqzXubon01RHQwv/bIA/cHLZ
	 G711GIOfNmLTLw4XYLHXciD6CHNiowSmoUK9YJN7qdwryhBv5vNFclAHjwhBm+FGHA
	 TYPVrwj/GjofNk5/6JIvwG/jD7dGSqLmckcNCgvbyI/lJb4kTlScIz3B+V9x4c8trt
	 BxXhD2EWYI/lsFxcklkPbTh5bqkBEQ7GDt5dcwWFmpdZoSgp5azLvrfwcyBFDGsOkV
	 M1NyhKTlcAeHA==
Date: Tue, 16 Jan 2024 16:37:09 +0000
From: Lee Jones <lee@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Lee Jones <lee@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] MFD for v6.8
Message-ID: <20240116163709.GJ1920897@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Good afternoon Linus,

The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git mfd-next-6.8

for you to fetch changes up to 284d16c456e5d4b143f375b8ccc4038ab3f4ee0f:

  mfd: ti_am335x_tscadc: Fix TI SoC dependencies (2024-01-10 11:26:10 +0000)

----------------------------------------------------------------
 - New Device Support
   - Add support for Qualcomm PM8937 PMIC to QCOM SPMI PMIC

 - Fix-ups
   - Use/convert to new/better APIs/helpers/MACROs instead of hand-rolling implementations
   - Device Tree binding adaptions/conversions/creation
   - Improve error handling; return proper error values, simplify, avoid duplicates, etc
   - Continue work to remove superfluous platform .remove() call-backs
   - Move some exported symbols into private namespaces
   - Clean-up and staticify PM related operations
   - Trivial; spelling, whitespace, clean-ups, etc
   - Fix include lists; alphabetise, remove unused, explicitly add used

 - Bug Fixes
   - Use PLATFORM_DEVID_AUTO to ensure multiple duplicate devices can co-exist
   - Ensure debugfs register view is correctly presented
   - Fix ordering and value issues in current use of clk_register_fractional_divider()
   - Repair Kconfig based dependency lists

----------------------------------------------------------------
Amit Kumar Mahapatra (1):
      mfd: tps6594: Use spi_get_chipselect() API to access spi->chip_select

Andre Werner (1):
      mfd: tps65086: Enable register view in debugfs

Andy Shevchenko (8):
      mfd: intel-lpss: Use PCI APIs instead of dereferencing
      mfd: intel-lpss: Revert "Add missing check for platform_get_resource"
      mfd: intel-lpss: Use device_get_match_data()
      mfd: intel-lpss: Adjust header inclusions
      mfd: intel-lpss: Move exported symbols to INTEL_LPSS namespace
      mfd: intel-lpss: Provide Intel LPSS PM ops structure
      mfd: intel-lpss: Don't fail probe on success of pci_alloc_irq_vectors()
      mfd: intel-lpss: Fix the fractional clock divider flags

Biju Das (1):
      mfd: da9062: Simplify obtaining I2C match data

Charles Keepax (2):
      mfd: cs42l43: Correct SoundWire port list
      mfd: cs42l43: Correct order of include files to be alphabetical

Chen Ni (1):
      mfd: intel-lpss: Return error code received from the IRQ API

Christophe JAILLET (1):
      mfd: intel-lpss: Remove usage of the deprecated ida_simple_xx() API

Chunyan Zhang (1):
      dt-bindings: mfd: sprd: Add support for UMS9620

Dang Huynh (2):
      mfd: qcom-spmi-pmic: Add support for PM8937
      dt-bindings: mfd: qcom-spmi-pmic: Document PM8937 PMIC

Geert Uytterhoeven (1):
      dt-bindings: mfd: ams,as3711: Convert to json-schema

Johan Hovold (4):
      dt-bindings: mfd: hisilicon,hi6421-spmi-pmic: Fix up binding reference
      dt-bindings: mfd: hisilicon,hi6421-spmi-pmic: Fix regulator binding
      dt-bindings: mfd: hisilicon,hi6421-spmi-pmic: Clean up example
      dt-bindings: mfd: pm8008: Clean up example node names

Kaihua Zhong (1):
      mfd: Fix a few spelling mistakes in PMIC header file comments

Kunwu Chan (2):
      mfd: syscon: Fix null pointer dereference in of_syscon_register()
      mfd: tps6594: Add null pointer check to tps6594_device_init()

Linus Walleij (1):
      mfd: ab8500-sysctrl: Drop ancient charger

Mukesh Ojha (1):
      dt-bindings: mfd: qcom,tcsr: Add compatible for sm8250/sm8350

Neil Armstrong (1):
      mfd: rk8xx: fixup devices registration with PLATFORM_DEVID_AUTO

Nikita Travkin (1):
      dt-bindings: mfd: qcom,spmi-pmic: Add pm8916 vm-bms and lbc

Peter Robinson (1):
      mfd: ti_am335x_tscadc: Fix TI SoC dependencies

Peter Ujfalusi (1):
      mfd: twl6030-irq: Revert to use of_match_device()

Santhosh Kumar K (1):
      dt-bindings: mfd: ti,am3359-tscadc: Allow dmas property to be optional

Uwe Kleine-König (18):
      mfd: ab8500-sysctrl: Convert to platform remove callback returning void
      mfd: cros_ec_dev: Convert to platform remove callback returning void
      mfd: exynos-lpass: Convert to platform remove callback returning void
      mfd: fsl-imx25-tsadc: Convert to platform remove callback returning void
      mfd: hi655x-pmic: Convert to platform remove callback returning void
      mfd: intel-lpss-acpi: Convert to platform remove callback returning void
      mfd: kempld-core: Convert to platform remove callback returning void
      mfd: mcp-sa11x0: Convert to platform remove callback returning void
      mfd: mxs-lradc: Convert to platform remove callback returning void
      mfd: omap-usb-host: Convert to platform remove callback returning void
      mfd: omap-usb-tll: Convert to platform remove callback returning void
      mfd: pcf50633-adc: Convert to platform remove callback returning void
      mfd: qcom-pm8xxx: Convert to platform remove callback returning void
      mfd: sm501: Convert to platform remove callback returning void
      mfd: stm32-timers: Convert to platform remove callback returning void
      mfd: ti_am335x_tscadc: Convert to platform remove callback returning void
      mfd: tps65911-comparator: Convert to platform remove callback returning void
      mfd: twl4030-audio: Convert to platform remove callback returning void

 .../devicetree/bindings/mfd/ams,as3711.yaml        | 223 +++++++++++++++++++++
 Documentation/devicetree/bindings/mfd/as3711.txt   |  73 -------
 .../bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml   | 140 +++++++------
 .../devicetree/bindings/mfd/qcom,pm8008.yaml       |   6 +-
 .../devicetree/bindings/mfd/qcom,spmi-pmic.yaml    |   7 +
 .../devicetree/bindings/mfd/qcom,tcsr.yaml         |   2 +
 .../bindings/mfd/sprd,ums512-glbreg.yaml           |   4 +-
 .../devicetree/bindings/mfd/ti,am3359-tscadc.yaml  |   2 -
 drivers/mfd/Kconfig                                |   1 +
 drivers/mfd/ab8500-sysctrl.c                       |   8 +-
 drivers/mfd/cros_ec_dev.c                          |   5 +-
 drivers/mfd/cs42l43-sdw.c                          |  76 +++----
 drivers/mfd/da9062-core.c                          |  22 +-
 drivers/mfd/exynos-lpass.c                         |   6 +-
 drivers/mfd/fsl-imx25-tsadc.c                      |   6 +-
 drivers/mfd/hi655x-pmic.c                          |   5 +-
 drivers/mfd/intel-lpss-acpi.c                      |  33 ++-
 drivers/mfd/intel-lpss-pci.c                       |  27 ++-
 drivers/mfd/intel-lpss.c                           |  52 +++--
 drivers/mfd/intel-lpss.h                           |  28 +--
 drivers/mfd/kempld-core.c                          |   6 +-
 drivers/mfd/mcp-sa11x0.c                           |   6 +-
 drivers/mfd/mxs-lradc.c                            |   6 +-
 drivers/mfd/omap-usb-host.c                        |   5 +-
 drivers/mfd/omap-usb-tll.c                         |   5 +-
 drivers/mfd/pcf50633-adc.c                         |   6 +-
 drivers/mfd/qcom-pm8xxx.c                          |   6 +-
 drivers/mfd/qcom-spmi-pmic.c                       |   1 +
 drivers/mfd/rk8xx-core.c                           |  34 ++--
 drivers/mfd/sm501.c                                |   6 +-
 drivers/mfd/stm32-timers.c                         |   6 +-
 drivers/mfd/syscon.c                               |   4 +
 drivers/mfd/ti_am335x_tscadc.c                     |   6 +-
 drivers/mfd/tps65086.c                             |   1 +
 drivers/mfd/tps65911-comparator.c                  |   6 +-
 drivers/mfd/tps6594-core.c                         |   3 +
 drivers/mfd/tps6594-spi.c                          |   2 +-
 drivers/mfd/twl4030-audio.c                        |   6 +-
 drivers/mfd/twl6030-irq.c                          |  10 +-
 include/linux/mfd/max77693-private.h               |   2 +-
 include/linux/mfd/max77843-private.h               |   2 +-
 include/linux/mfd/si476x-platform.h                |   2 +-
 include/linux/mfd/tps65910.h                       |   2 +-
 include/soc/qcom/qcom-spmi-pmic.h                  |   1 +
 44 files changed, 481 insertions(+), 379 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/ams,as3711.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/as3711.txt

-- 
Lee Jones [李琼斯]

