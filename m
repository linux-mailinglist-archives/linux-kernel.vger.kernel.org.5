Return-Path: <linux-kernel+bounces-111619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D42A0886EA0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39FECB20E5B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE6B47F7A;
	Fri, 22 Mar 2024 14:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="csPNjMSX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1A53FE46;
	Fri, 22 Mar 2024 14:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711117931; cv=none; b=Dl2ilq215Mvp40JooRaTS9lzdQ14Q/cSc21Wy4tCFxqZ/3OjjbtS9imW6FFm5xO3zbogqwaJuySKf1f3Gxy367ph6yrAui6QXRsk3ruBwrjgS7JAYH6oONg0hP5C632S6rtr+7qmGtEdEE0NHp2fPZg2yM9mGc6y7Vg1BLP4Tf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711117931; c=relaxed/simple;
	bh=HcR/KfHtr497K/J36yGxFPywFOL3JXOh2RoVycr/rM8=;
	h=From:To:Cc:Subject:Date:Message-Id; b=HBlpddg65pGHUjSJEwLwVAzA5haXL4v2oGif4N6Pw58bI5ga4TY8wdv0GaHLaWbvO7pC/srO1M/1M8K2KeVRP60GCI+biv9/l0S+TrZV66gC5rhR4mCAPwMjcDFD9hoouKlJFV0UfX3Z/3CXWSIBbKbAlT3SS6VLYC1cMt5Touc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=csPNjMSX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 054E6C433F1;
	Fri, 22 Mar 2024 14:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711117930;
	bh=HcR/KfHtr497K/J36yGxFPywFOL3JXOh2RoVycr/rM8=;
	h=From:To:Cc:Subject:Date:From;
	b=csPNjMSXByd8QmwnUmnR13XX4SSBkaPf8QyVjn5G+r0FRqOUs15nADom2bFfHPRrN
	 JkkGcRkQgbH1TqS36JGbkcLc9ZgGPDL6+MXWd4UeWuHu/MJKmFb8+f2/1NpI/oUHL8
	 /W8pGlaFHW5/Ml0/CIO2qhmjCU2olXd7JfIxcl6l0TJKa/PxHO1G30BdAGTvLfIMYl
	 CnrkpxZWqA/oo/utbTqbU2ySNmRTU5Y/jHVFXJuN3inN9/asjTbUs/3QhvA80478uq
	 wZbYY5I+ZucJBeEYakTM5+x/LjSyE00yGOe7W77X5QTks9/4tlpVeRzTyvMbmkqSaw
	 00mDaeaSXZOKg==
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v6.9-merge-window
Date: Fri, 22 Mar 2024 14:32:02 +0000
Message-Id: <20240322143210.054E6C433F1@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The following changes since commit e8f897f4afef0031fe618a8e94127a0934896aba:

  Linux 6.8 (2024-03-10 13:38:09 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.9-merge-window

for you to fetch changes up to a20ad45008a7c82f1184dc6dee280096009ece55:

  spi: spi-mt65xx: Fix NULL pointer access in interrupt handler (2024-03-21 11:28:21 +0000)

----------------------------------------------------------------
spi: Fixes for v6.9

A small collection of fixes that came in since the merge window.  Most
of it is relatively minor driver specific fixes, there's also fixes for
error handling with SPI flash devices and a fix restoring delay control
functionality for non-GPIO chip selects managed by the core.

----------------------------------------------------------------
Adam Butcher (1):
      spi: spi-imx: fix off-by-one in mx51 CPU mode burst length

Alexander Sverdlin (1):
      spi: lpspi: Avoid potential use-after-free in probe()

David Lechner (1):
      spi: docs: spidev: fix echo command format

Fei Shao (1):
      spi: spi-mt65xx: Fix NULL pointer access in interrupt handler

Florian Fainelli (1):
      spi: Fix error code checking in spi_mem_exec_op()

Janne Grunau (1):
      spi: Restore delays for non-GPIO chip select

Kousik Sanagavarapu (1):
      spi: lm70llp: fix links in doc and comments

Mark Brown (1):
      spi: Merge up v6.8 release

 .../bindings/spi/atmel,at91rm9200-spi.yaml         |   1 -
 .../devicetree/bindings/spi/samsung,spi.yaml       |   4 +-
 .../devicetree/bindings/spi/spi-controller.yaml    |  27 +
 .../devicetree/bindings/spi/spi-fsl-lpspi.yaml     |   1 +
 .../devicetree/bindings/spi/spi-nxp-fspi.yaml      |  18 +-
 Documentation/driver-api/driver-model/devres.rst   |   2 +-
 Documentation/spi/spi-lm70llp.rst                  |   4 +-
 Documentation/spi/spi-summary.rst                  | 114 ++---
 Documentation/spi/spidev.rst                       |   2 +-
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
 drivers/spi/spi-fsl-lpspi.c                        |   8 +-
 drivers/spi/spi-geni-qcom.c                        |   2 +-
 drivers/spi/spi-gpio.c                             |   2 +-
 drivers/spi/spi-imx.c                              |   4 +-
 drivers/spi/spi-intel.c                            |  34 +-
 drivers/spi/spi-lm70llp.c                          |  10 +-
 drivers/spi/spi-loopback-test.c                    |   4 +-
 drivers/spi/spi-mem.c                              |  49 +-
 drivers/spi/spi-mt65xx.c                           |  27 +-
 drivers/spi/spi-nxp-fspi.c                         |   2 +-
 drivers/spi/spi-oc-tiny.c                          |   6 +-
 drivers/spi/spi-omap-uwire.c                       |   4 +-
 drivers/spi/spi-pci1xxxx.c                         | 510 ++++++++++++++++++-
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
 drivers/spi/spi.c                                  | 544 ++++++++++++---------
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
 76 files changed, 1606 insertions(+), 833 deletions(-)

