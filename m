Return-Path: <linux-kernel+bounces-99079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFEA878338
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7877B22AB4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FA25E07E;
	Mon, 11 Mar 2024 15:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TAjywje2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153AE5D734;
	Mon, 11 Mar 2024 15:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710170004; cv=none; b=bcmnW9qziTKZvnhtPkyeUWotrcZmWE9pc9eSc6GohcghNPnNPgJSIl+wO1u1maYc/C12L1UYfw61A2IigEr3FSdrgIudl/wW3QvF0Hwa+OJHeIJZghSNY6vkah4BWmNapoqae3cElJKLIUuOJTQairei+TW+zkf9vveNB9UADbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710170004; c=relaxed/simple;
	bh=PEKLAPa4vXj/7kPyR3FI47jJEauup8AlEcxeu0zNjK0=;
	h=From:To:Cc:Subject:Date:Message-Id; b=ffKU8g86HqJI39aYKYEo4S4pkgrUYhBo/ib9FtLT/LeB+aV/IGUzVhz2vbgF41wIC3MA4HxglE+ovgZKopwX9rlricxfHbjYoUBC2E38rzeIzom+4sJfPLMMc3g/hZy4+K3D0dufMe/yCdbECb5g+2ALA3Kh2zQeM6Ed8wEtXao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TAjywje2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88DE3C43390;
	Mon, 11 Mar 2024 15:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710170003;
	bh=PEKLAPa4vXj/7kPyR3FI47jJEauup8AlEcxeu0zNjK0=;
	h=From:To:Cc:Subject:Date:From;
	b=TAjywje2Uh//LwlqHn2Wh1/KGsRGGv8f0jjDmFItXAfrEFa4rPJAZOlulLQoiQ+Ww
	 XbcTB+JRw1HLF+2NL3n1IJu51dVEYjNWZXFEN9hcuF4cWeSf3eOSAwJFQ8PWqZqm7G
	 u/dMrvZU9JExUAK4ZVkEO4fPal7yjXbrbpg2sW40+liteJ+s42wj3X3+aGANXlfk5g
	 qhdUUp8CvJZMxko5qu51HGNpPQlSw4DcUZE/4GZ9LwVflv7JT+TkHEm8L7GO5lI4KV
	 wwnUeYDzg+WXUnxnwzIPB+0Gxrs6pQ1dLXMTt8T7yiIPMa52EEI5hFLqHQkf6YrBdq
	 j3/raoUHZa3VA==
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI updates for v6.9
Date: Mon, 11 Mar 2024 15:13:14 +0000
Message-Id: <20240311151323.88DE3C43390@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The following changes since commit 54be6c6c5ae8e0d93a6c4641cb7528eb0b6ba478:

  Linux 6.8-rc3 (2024-02-04 12:20:36 +0000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v6.9

for you to fetch changes up to be84be4a35fa99cca7e81e6dd21516a324cca413:

  spi: Introduce SPI_INVALID_CS and is_valid_cs() (2024-03-07 15:07:11 +0000)

----------------------------------------------------------------
spi: Updates for v6.9

This release sees some exciting changes from David Lechner which
implements some optimisations that have been talked about for a long
time which allows client drivers to pre-prepare SPI messages for
repeated or low latency use.  This lets us move work out of latency
sensitive paths and avoid repeating work for frequently performed
operations.  As well as being useful in itself this will also be used in
future to allow controllers to directly trigger SPI operations (eg, from
interrupts).

Otherwise this release has mostly been focused on cleanups, plus a
couple of new devices:

 - Support for pre-optimising messages.
 - A big set of updates from Uwe Kleine-König moving drivers to use APIs
   with more modern terminology for controllers.
 - Major overhaul of the s3c64xx driver.
 - Support for Google GS101 and Samsung Exynos850.

----------------------------------------------------------------
Ahelenia Ziemiańska (1):
      spi: Kconfig: cap[c]ability

Alexander Stein (1):
      spi: nxp-fspi: Adjust LUT debug output alignment

Andy Shevchenko (8):
      spi: gpio: Follow renaming of SPI "master" to "controller"
      spi: pic32: Replace of_gpio.h by proper one
      spi: stm32-qspi: Replace of_gpio.h by proper one
      spi: Exctract spi_set_all_cs_unused() helper
      spi: Exctract spi_dev_check_cs() helper
      spi: Consistently use BIT for cs_index_mask
      spi: Fix types of the last chip select storage variables
      spi: Introduce SPI_INVALID_CS and is_valid_cs()

Charles Keepax (2):
      spi: cs42l43: Handle error from devm_pm_runtime_enable()
      spi: cs42l43: Clean up of firmware node

Colin Ian King (1):
      spi: dw: remove redundant assignment to variable len

Dan Carpenter (1):
      spi: mchp-pci1xxxx: release resources on error in probe()

David Lechner (16):
      spi: consolidate setting message->spi
      spi: avoid double validation in __spi_sync()
      spi: reorder spi_message struct member doc comments
      spi: move split xfers for CS_WORD emulation
      spi: bcm2835: implement ctlr->max_transfer_size
      spi: axi-spi-engine: use common AXI macros
      spi: drop gpf arg from __spi_split_transfer_maxsize()
      spi: axi-spi-engine: remove use of ida for sync id
      spi: axi-spi-engine: move msg finalization out of irq handler
      spi: add spi_optimize_message() APIs
      spi: move splitting transfers to spi_optimize_message()
      spi: stm32: move splitting transfers to optimize_message
      spi: axi-spi-engine: move message compile to optimize_message
      spi: axi-spi-engine: remove p from struct spi_engine_message_state
      spi: axi-spi-engine: use __counted_by() attribute
      spi: axi-spi-engine: use struct_size() macro

Dhruva Gole (1):
      spi: Update the "master/slave" terminology in documentation

Greg Kroah-Hartman (1):
      spi: make spi_bus_type const

Krzysztof Kozlowski (3):
      spi: pl022: Use typedef for dma_filter_fn
      spi: pl022: Add missing dma_filter field kerneldoc
      spi: pxa2xx: Use typedef for dma_filter_fn

Luis de Arquer (2):
      spi: spi-rockchip: Fix out of bounds array access
      spi: spi-rockchip: Fix max_native_cs

Mark Brown (7):
      arm64: exynos: Enable SPI for Exynos850
      spi: fsl-dspi: A couple of error handling
      spi: s3c64xx: add support for google,gs101-spi
      spi: get rid of some legacy macros
      spi: s3c64xx: straightforward cleanup
      spi: add support for pre-cooking messages
      spi: axi-spi-engine: small cleanups

Mika Westerberg (2):
      spi: intel: Add default partition and name to the second chip
      spi: intel: Keep the BIOS partition inside the first chip

Peng Fan (2):
      dt-bindings: spi: fsl-lpspi: support i.MX95 LPSPI
      dt-bindings: spi: nxp-fspi: support i.MX93 and i.MX95

Randy Dunlap (1):
      spi: spi-summary.rst: fix underline length

Ruihai Zhou (1):
      spi: spi-mt65xx: Support sleep pin control

Sam Protsenko (3):
      spi: s3c64xx: Extract FIFO depth calculation to a dedicated macro
      spi: s3c64xx: Add Exynos850 support
      spi: dt-bindings: samsung: Add Exynos850 SPI

Thangaraj Samynathan (2):
      spi: mchp-pci1xxxx: Add support for DMA in SPI
      spi: mchp-pci1xxxx: DMA support for copying data to and from SPI Buf

Théo Lebrun (4):
      spi: cadence-qspi: assert each subnode flash CS is valid
      spi: cadence-qspi: set maximum chip-select to 4
      spi: cadence-qspi: report correct number of chip-select
      spi: spi-mem: add statistics support to ->exec_op() calls

Tudor Ambarus (34):
      spi: s3c64xx: sort headers alphabetically
      spi: s3c64xx: explicitly include <linux/io.h>
      spi: s3c64xx: explicitly include <linux/bits.h>
      spi: s3c64xx: explicitly include <linux/types.h>
      spi: s3c64xx: avoid possible negative array index
      spi: s3c64xx: fix typo, s/configuartion/configuration
      spi: s3c64xx: remove unneeded (void *) casts in of_match_table
      spi: s3c64xx: remove else after return
      spi: s3c64xx: move common code outside if else
      spi: s3c64xx: check return code of dmaengine_slave_config()
      spi: s3c64xx: propagate the dma_submit_error() error code
      spi: s3c64xx: rename prepare_dma() to s3c64xx_prepare_dma()
      spi: s3c64xx: return ETIMEDOUT for wait_for_completion_timeout()
      spi: s3c64xx: drop blank line between declarations
      spi: s3c64xx: downgrade dev_warn to dev_dbg for optional dt props
      spi: s3c64xx: remove duplicated definition
      spi: s3c64xx: drop a superfluous bitwise NOT operation
      spi: dt-bindings: samsung: add google,gs101-spi compatible
      spi: s3c64xx: prepare for a different flavor of iowrite rep
      spi: s3c64xx: add s3c64xx_iowrite{8,16}_32_rep accessors
      spi: s3c64xx: add support for google,gs101-spi
      spi: dt-bindings: samsung: make dma properties not required
      spi: dt-bindings: introduce FIFO depth properties
      spi: s3c64xx: define a magic value
      spi: s3c64xx: allow full FIFO masks
      spi: s3c64xx: determine the fifo depth only once
      spi: s3c64xx: retrieve the FIFO depth from the device tree
      spi: s3c64xx: allow FIFO depth to be determined from the compatible
      spi: s3c64xx: let the SPI core determine the bus number
      spi: s3c64xx: introduce s3c64xx_spi_set_port_id()
      spi: s3c64xx: get rid of the OF alias ID dependency
      spi: s3c64xx: deprecate fifo_lvl_mask, rx_lvl_offset and port_id
      spi: s3c64xx: switch gs101 to new port config data
      spi: s3c64xx: switch exynos850 to new port config data

Uwe Kleine-König (33):
      fpga: ice40-spi: Follow renaming of SPI "master" to "controller"
      ieee802154: ca8210: Follow renaming of SPI "master" to "controller"
      iio: adc: ad_sigma_delta: Follow renaming of SPI "master" to "controller"
      Input: pxspad - follow renaming of SPI "master" to "controller"
      Input: synaptics-rmi4 - follow renaming of SPI "master" to "controller"
      media: mgb4: Follow renaming of SPI "master" to "controller"
      media: netup_unidvb: Follow renaming of SPI "master" to "controller"
      media: usb/msi2500: Follow renaming of SPI "master" to "controller"
      media: v4l2-subdev: Follow renaming of SPI "master" to "controller"
      misc: gehc-achc: Follow renaming of SPI "master" to "controller"
      mmc: mmc_spi: Follow renaming of SPI "master" to "controller"
      mtd: dataflash: Follow renaming of SPI "master" to "controller"
      net: ks8851: Follow renaming of SPI "master" to "controller"
      net: vertexcom: mse102x: Follow renaming of SPI "master" to "controller"
      platform/chrome: cros_ec_spi: Follow renaming of SPI "master" to "controller"
      spi: bitbang: Follow renaming of SPI "master" to "controller"
      spi: cadence-quadspi: Don't emit error message on allocation error
      spi: cadence-quadspi: Follow renaming of SPI "master" to "controller"
      spi: cavium: Follow renaming of SPI "master" to "controller"
      spi: geni-qcom: Follow renaming of SPI "master" to "controller"
      spi: loopback-test: Follow renaming of SPI "master" to "controller"
      spi: slave-mt27xx: Follow renaming of SPI "master" to "controller"
      spi: spidev: Follow renaming of SPI "master" to "controller"
      staging: fbtft: Follow renaming of SPI "master" to "controller"
      staging: greybus: spi: Follow renaming of SPI "master" to "controller"
      tpm_tis_spi: Follow renaming of SPI "master" to "controller"
      usb: gadget: max3420_udc: Follow renaming of SPI "master" to "controller"
      video: fbdev: mmp: Follow renaming of SPI "master" to "controller"
      wifi: libertas: Follow renaming of SPI "master" to "controller"
      spi: fsl-lib: Follow renaming of SPI "master" to "controller"
      spi: Drop compat layer from renaming "master" to "controller"
      Documentation: spi: Update documentation for renaming "master" to "controller"
      spi: ppc4xx: Fix fallout from rename in struct spi_bitbang

Varshini Rajendran (1):
      spi: dt-bindings: atmel,at91rm9200-spi: remove 9x60 compatible from list

andy.shevchenko@gmail.com (2):
      spi: fsl-dspi: Preserve error code returned by dmaengine_slave_config()
      spi: fsl-dspi: Unify error messaging in dspi_request_dma()

 .../bindings/spi/atmel,at91rm9200-spi.yaml         |   1 -
 .../devicetree/bindings/spi/samsung,spi.yaml       |   4 +-
 .../devicetree/bindings/spi/spi-controller.yaml    |  27 ++
 .../devicetree/bindings/spi/spi-fsl-lpspi.yaml     |   1 +
 .../devicetree/bindings/spi/spi-nxp-fspi.yaml      |  18 +-
 Documentation/driver-api/driver-model/devres.rst   |   2 +-
 Documentation/spi/spi-summary.rst                  | 114 ++---
 drivers/char/tpm/tpm_tis_spi_main.c                |   4 +-
 drivers/fpga/ice40-spi.c                           |   4 +-
 drivers/iio/adc/ad_sigma_delta.c                   |  14 +-
 drivers/input/joystick/psxpad-spi.c                |   4 +-
 drivers/input/rmi4/rmi_spi.c                       |   2 +-
 drivers/media/pci/mgb4/mgb4_core.c                 |  14 +-
 drivers/media/pci/netup_unidvb/netup_unidvb_spi.c  |  48 +-
 drivers/media/usb/msi2500/msi2500.c                |  38 +-
 drivers/media/v4l2-core/v4l2-spi.c                 |   4 +-
 drivers/misc/gehc-achc.c                           |   8 +-
 drivers/mmc/host/mmc_spi.c                         |   6 +-
 drivers/mtd/devices/mtd_dataflash.c                |   2 +-
 drivers/net/ethernet/micrel/ks8851_spi.c           |   4 +-
 drivers/net/ethernet/vertexcom/mse102x.c           |   2 +-
 drivers/net/ieee802154/ca8210.c                    |   2 +-
 drivers/net/wireless/marvell/libertas/if_spi.c     |   2 +-
 drivers/platform/chrome/cros_ec_spi.c              |   8 +-
 drivers/spi/Kconfig                                |   2 +-
 drivers/spi/spi-ath79.c                            |   4 +-
 drivers/spi/spi-au1550.c                           |   2 +-
 drivers/spi/spi-axi-spi-engine.c                   | 138 ++----
 drivers/spi/spi-bcm2835.c                          |  27 +-
 drivers/spi/spi-bitbang.c                          |  64 +--
 drivers/spi/spi-butterfly.c                        |   6 +-
 drivers/spi/spi-cadence-quadspi.c                  |  21 +-
 drivers/spi/spi-cavium.c                           |   6 +-
 drivers/spi/spi-cavium.h                           |   2 +-
 drivers/spi/spi-cs42l43.c                          |  22 +-
 drivers/spi/spi-davinci.c                          |   6 +-
 drivers/spi/spi-dw-dma.c                           |   2 +-
 drivers/spi/spi-fsl-dspi.c                         |  15 +-
 drivers/spi/spi-fsl-lib.c                          |  14 +-
 drivers/spi/spi-geni-qcom.c                        |   2 +-
 drivers/spi/spi-gpio.c                             |   2 +-
 drivers/spi/spi-intel.c                            |  34 +-
 drivers/spi/spi-lm70llp.c                          |   6 +-
 drivers/spi/spi-loopback-test.c                    |   4 +-
 drivers/spi/spi-mem.c                              |  49 +-
 drivers/spi/spi-mt65xx.c                           |   5 +
 drivers/spi/spi-nxp-fspi.c                         |   2 +-
 drivers/spi/spi-oc-tiny.c                          |   6 +-
 drivers/spi/spi-omap-uwire.c                       |   4 +-
 drivers/spi/spi-pci1xxxx.c                         | 510 ++++++++++++++++++--
 drivers/spi/spi-pic32.c                            |   2 +-
 drivers/spi/spi-ppc4xx.c                           |  14 +-
 drivers/spi/spi-rockchip.c                         |  13 +-
 drivers/spi/spi-s3c64xx.c                          | 301 +++++++++---
 drivers/spi/spi-sh-sci.c                           |  10 +-
 drivers/spi/spi-slave-mt27xx.c                     |   2 +-
 drivers/spi/spi-stm32-qspi.c                       |   2 +-
 drivers/spi/spi-stm32.c                            |  30 +-
 drivers/spi/spi-xilinx.c                           |   4 +-
 drivers/spi/spi-xtensa-xtfpga.c                    |   2 +-
 drivers/spi/spi.c                                  | 520 ++++++++++++---------
 drivers/spi/spidev.c                               |   2 +-
 drivers/staging/fbtft/fbtft-core.c                 |   4 +-
 drivers/staging/greybus/spilib.c                   |  66 +--
 drivers/usb/gadget/udc/max3420_udc.c               |   2 +-
 drivers/video/fbdev/mmp/hw/mmp_spi.c               |  26 +-
 include/linux/amba/pl022.h                         |   4 +-
 include/linux/spi/pxa2xx_spi.h                     |   3 +-
 include/linux/spi/spi.h                            |  64 +--
 include/linux/spi/spi_bitbang.h                    |   2 +-
 include/linux/spi/spi_gpio.h                       |   4 +-
 include/media/v4l2-common.h                        |   6 +-
 72 files changed, 1569 insertions(+), 802 deletions(-)

