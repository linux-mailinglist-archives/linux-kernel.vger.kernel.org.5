Return-Path: <linux-kernel+bounces-104328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8D387CC36
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F15B21F21335
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368DA1B297;
	Fri, 15 Mar 2024 11:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="eqWbiQoH"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80350199B0
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 11:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710501701; cv=none; b=AbvcN7J0824HQnCitnB8sbmYtHdb+hRp8w0nTb7yrAMZu724t9IOQJ/IYcJbm9O+BmevTvKJxdACIAXBK3ns9M9kXSqDGDxh8tT4pi0bzHTH72RhPvx7XJ+dLDjWZtuDsgmP2687PDN4j5Q3bESArF5nn9CBawOg71x1QejsHxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710501701; c=relaxed/simple;
	bh=zHqd9nQu1HERjNkI6/SrFdt3joTnR/2auqEriTOeqWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=gVaseUltcjlb7j1a4sxH1Pxj8HMy0ueMHwTV6yJSY0FcgaDt+DNqkIQuZSvJemlhkM8Vpr9U00As/XIhnL0tynQwc+VcwwNay539b17eIwZU74clEEK3moPw0YbwJPprX4QyC3mEEewgVLmp3r6PPYYIhwxw1TclhCcQnrbA4CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=eqWbiQoH; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7AE711BF204;
	Fri, 15 Mar 2024 11:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1710501691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NmJ4sTuuhjOkhzBsJyjZdxw4gBGBYMjlVzQZFVcZcX0=;
	b=eqWbiQoHxIpA618gf7vkALp5lLEdTmAFl7IqiKsyHFwpj19Jc1bjod1CMYb7KGgO67ixRe
	JPlsoCzR+TneKK8nfQr8N65/u28PyzaT82pO+2LTFE0SdAdVZzRSHzsAgYp3ahQrKGRGjl
	5xVtGbVZihgjVRSeeSpola0axiI4JBEk8Kxq6P8dHe65wHfzS8HNaJRZ2gx0e+W4I92Jpb
	72NYm6fBigU3IWHPkKL7Q25ygLrf0SPH1SFqqg5y7H/nxNHXNtu3AQnRN+R7Ec4QOyuWGq
	0N2/qsMYu88eDVyZm9ghZ7gK8jK9zCFASGuy25CnJDFoghEr3QImMVHzD1JsOQ==
Date: Fri, 15 Mar 2024 12:21:28 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
 Tudor Ambarus <Tudor.Ambarus@linaro.org>, Vignesh Raghavendra
 <vigneshr@ti.com>, Frieder Schrempf <frieder.schrempf@kontron.de>, Michael
 Walle <michael@walle.cc>, Pratyush Yadav <pratyush@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: [GIT PULL] mtd: Changes for 6.9-rc1
Message-ID: <20240315122128.42375f32@xps-13>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hello Linus,

This is the MTD PR for the opening v6.9-rc cycle.

Thanks,
Miqu=C3=A8l

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/for-=
6.9

for you to fetch changes up to 09888e973cc9d3615dbab5d178eecb58d8a0b7ab:

  Merge tag 'nand/for-6.9' into mtd/next (2024-03-15 12:00:45 +0100)

----------------------------------------------------------------
MTD

The Carillo Ranch driver has been removed. Top level mtd bindings have
received a couple of improvements (references, selects). The ssfdc
driver received few minor adjustments. These changes come with the usual
load of misc/small improvements and fixes.

Raw NAND

The main series brought is an update of the Broadcom support to support
all BCMBCA SoCs and their specificity (ECC, write protection,
configuration straps), plus a few misc fixes and changes in the main
driver. Device tree updates are also part of this PR, initially because
of a misunderstanding on my side.

The STM32_FMC2 controller driver is also upgraded to properly support
MP1 and MP25 SoCs.

A new compatible is added for an Atmel flavor.

Among all these feature changes, there is as well a load of continuous
read related fixes, avoiding more corner conditions and clarifying the
logic. Finally a few miscellaneous fixes are made to the core, the
lpx32xx_mlc, fsl_lbc, Meson and Atmel controller driver, as well as
final one in the Hynix vendor driver.

SPI-NAND

The ESMT support has been extended to match 5 bytes ID to avoid
collisions. Winbond support on its side receives support for W25N04KV
chips.

SPI NOR

SPI NOR gets the non uniform erase code cleaned. We stopped using
bitmasks for erase types and flags, and instead introduced dedicated
members. We then passed the SPI NOR erase map to MTD. Users can now
determine the erase regions and make informed decisions on partitions
size.

An optional interrupt property is now described in the bindings.

----------------------------------------------------------------
Alexander Dahl (1):
      mtd: nand: raw: atmel: Fix comment in timings preparation

Arnd Bergmann (1):
      mtd: rawnand: lpc32xx_mlc: fix irq handler prototype

Arseniy Krasnov (1):
      mtd: rawnand: meson: fix scrambling mode value in command macro

Baruch Siach (1):
      mtd: maps: physmap-core: fix flash size larger than 32-bit

Christophe Kerello (3):
      dt-bindings: mtd: st,stm32: add MP25 support
      mtd: rawnand: stm32_fmc2: use dma_get_slave_caps to get DMA max burst
      mtd: rawnand: stm32_fmc2: add MP25 support

Colin Ian King (2):
      mtd: chips: remove redundant assignment to variable timeo
      mtd: rawnand: remove redundant assignment to variable bbtblocks

David Regan (2):
      mtd: rawnand: brcmnand: exec_op helper functions return type fixes
      mtd: rawnand: brcmnand: update log level messages

Erick Archer (1):
      mtd: rawnand: Prefer struct_size over open coded arithmetic

Ezra Buehler (2):
      mtd: spinand: Add support for 5-byte IDs
      mtd: spinand: esmt: Extend IDs to 5 bytes

Josua Mayer (1):
      dt-bindings: mtd: spi-nor: add optional interrupts property

Krzysztof Kozlowski (1):
      mtd: lpc32xx: use typedef for dma_filter_fn

Marcel Hamer (1):
      mtd: fix minor comment typo for struct mtd_master

Markus Elfring (3):
      mtd: ssfdc: One function call less in ssfdcr_add_mtd() after error de=
tection
      mtd: ssfdc: Fix indentation in ssfdcr_add_mtd()
      mtd: ssfdc: Improve a size determination in ssfdcr_add_mtd()

Matthew Wilcox (Oracle) (1):
      mtd: Remove support for Carillo Ranch driver

Miquel Raynal (7):
      Merge tag 'spi-nor/for-6.9' into mtd/next
      mtd: rawnand: Fix and simplify again the continuous read derivations
      mtd: rawnand: Add a helper for calculating a page index
      mtd: rawnand: Ensure all continuous terms are always in sync
      mtd: rawnand: Constrain even more when continuous reads are enabled
      mtd: rawnand: Ensure continuous reads are well disabled
      Merge tag 'nand/for-6.9' into mtd/next

Muhammad Usama Anjum (1):
      mtd: spi-nor: core: correct type of i

Nayab Sayed (1):
      dt-bindings: mtd: update references from partition.txt to mtd.yaml

Randy Dunlap (1):
      mtd: rawnand: hynix: remove @nand_technology kernel-doc description

Takahiro Kuwano (4):
      mtd: spi-nor: core: rework struct spi_nor_erase_region
      mtd: spi-nor: core: get rid of SNOR_LAST_REGION flag
      mtd: spi-nor: core: get rid of SNOR_OVERLAID_REGION flag
      mtd: spi-nor: core: set mtd->eraseregions for non-uniform erase map

Tudor Ambarus (1):
      mtd: flashchip: explicitly include <linux/wait.h>

Uwe Kleine-K=C3=B6nig (1):
      mtd: rawnand: fsl_elbc: Let .probe retry if local bus is missing

Varshini Rajendran (1):
      dt-bindings: atmel-nand: add microchip,sam9x7-pmecc

William Zhang (12):
      mtd: rawnand: brcmnand: fix style issues
      dt-bindings: mtd: brcmnand: Updates for bcmbca SoCs
      dt-bindings: mtd: brcmnand: Add WP pin connection property
      dt-bindings: mtd: brcmnand: Add ecc strap property
      ARM: dts: broadcom: bcmbca: Add NAND controller node
      arm64: dts: broadcom: bcmbca: Add NAND controller node
      arm64: dts: broadcom: bcmbca: Update router boards
      mtd: rawnand: brcmnand: Rename bcm63138 nand driver
      mtd: rawnand: brcmnand: Add BCMBCA read data bus interface
      mtd: rawnand: brcmnand: Support write protection setting from dts
      mtd: rawnand: brcmnand: fix sparse warnings
      mtd: rawnand: brcmnand: Add support for getting ecc setting from strap

Zhenhua Huang (1):
      dt-bindings: mtd: avoid automatically select from mtd.yaml

Zhi-Jun You (1):
      mtd: spinand: winbond: add support for W25N04KV

 Documentation/devicetree/bindings/mtd/atmel-nand.txt        |   1 +
 Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml    |  44 ++++-
 Documentation/devicetree/bindings/mtd/davinci-nand.txt      |   2 +-
 Documentation/devicetree/bindings/mtd/flctl-nand.txt        |   2 +-
 Documentation/devicetree/bindings/mtd/fsl-upm-nand.txt      |   2 +-
 Documentation/devicetree/bindings/mtd/gpio-control-nand.txt |   2 +-
 Documentation/devicetree/bindings/mtd/gpmi-nand.yaml        |   2 +-
 Documentation/devicetree/bindings/mtd/hisi504-nand.txt      |   2 +-
 Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml    |   3 +
 Documentation/devicetree/bindings/mtd/mtd.yaml              |   2 +
 .../devicetree/bindings/mtd/nvidia-tegra20-nand.txt         |   2 +-
 Documentation/devicetree/bindings/mtd/orion-nand.txt        |   2 +-
 Documentation/devicetree/bindings/mtd/samsung-s3c2410.txt   |   2 +-
 .../devicetree/bindings/mtd/st,stm32-fmc2-nand.yaml         |  25 ++-
 arch/arm/boot/dts/broadcom/bcm47622.dtsi                    |  14 ++
 arch/arm/boot/dts/broadcom/bcm63138.dtsi                    |   7 +-
 arch/arm/boot/dts/broadcom/bcm63148.dtsi                    |  14 ++
 arch/arm/boot/dts/broadcom/bcm63178.dtsi                    |  14 ++
 arch/arm/boot/dts/broadcom/bcm6756.dtsi                     |  14 ++
 arch/arm/boot/dts/broadcom/bcm6846.dtsi                     |  14 ++
 arch/arm/boot/dts/broadcom/bcm6855.dtsi                     |  14 ++
 arch/arm/boot/dts/broadcom/bcm6878.dtsi                     |  14 ++
 arch/arm/boot/dts/broadcom/bcm947622.dts                    |  10 +
 arch/arm/boot/dts/broadcom/bcm963138.dts                    |  10 +
 arch/arm/boot/dts/broadcom/bcm963138dvt.dts                 |  14 +-
 arch/arm/boot/dts/broadcom/bcm963148.dts                    |  10 +
 arch/arm/boot/dts/broadcom/bcm963178.dts                    |  10 +
 arch/arm/boot/dts/broadcom/bcm96756.dts                     |  10 +
 arch/arm/boot/dts/broadcom/bcm96846.dts                     |  10 +
 arch/arm/boot/dts/broadcom/bcm96855.dts                     |  10 +
 arch/arm/boot/dts/broadcom/bcm96878.dts                     |  10 +
 .../boot/dts/broadcom/bcmbca/bcm4906-netgear-r8000p.dts     |   5 +
 .../dts/broadcom/bcmbca/bcm4906-tplink-archer-c2300-v1.dts  |   5 +
 .../boot/dts/broadcom/bcmbca/bcm4908-asus-gt-ac5300.dts     |   6 +-
 arch/arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi            |   4 +-
 arch/arm64/boot/dts/broadcom/bcmbca/bcm4912.dtsi            |  14 ++
 arch/arm64/boot/dts/broadcom/bcmbca/bcm63146.dtsi           |  14 ++
 arch/arm64/boot/dts/broadcom/bcmbca/bcm63158.dtsi           |  14 ++
 arch/arm64/boot/dts/broadcom/bcmbca/bcm6813.dtsi            |  14 ++
 arch/arm64/boot/dts/broadcom/bcmbca/bcm6856.dtsi            |  14 ++
 arch/arm64/boot/dts/broadcom/bcmbca/bcm6858.dtsi            |  14 ++
 arch/arm64/boot/dts/broadcom/bcmbca/bcm94908.dts            |  10 +
 arch/arm64/boot/dts/broadcom/bcmbca/bcm94912.dts            |  10 +
 arch/arm64/boot/dts/broadcom/bcmbca/bcm963146.dts           |  10 +
 arch/arm64/boot/dts/broadcom/bcmbca/bcm963158.dts           |  10 +
 arch/arm64/boot/dts/broadcom/bcmbca/bcm96813.dts            |  10 +
 arch/arm64/boot/dts/broadcom/bcmbca/bcm96856.dts            |  10 +
 arch/arm64/boot/dts/broadcom/bcmbca/bcm96858.dts            |  10 +
 drivers/mtd/chips/cfi_cmdset_0002.c                         |   4 +-
 drivers/mtd/maps/Kconfig                                    |   7 -
 drivers/mtd/maps/Makefile                                   |   1 -
 drivers/mtd/maps/intel_vr_nor.c                             | 265 --------=
------------------
 drivers/mtd/maps/physmap-core.c                             |   2 +-
 drivers/mtd/nand/raw/atmel/nand-controller.c                |   2 +-
 drivers/mtd/nand/raw/brcmnand/Makefile                      |   2 +-
 drivers/mtd/nand/raw/brcmnand/bcm63138_nand.c               |  99 --------=
--
 drivers/mtd/nand/raw/brcmnand/bcmbca_nand.c                 | 126 ++++++++=
++++
 drivers/mtd/nand/raw/brcmnand/brcmnand.c                    | 148 ++++++++=
+++---
 drivers/mtd/nand/raw/brcmnand/brcmnand.h                    |   2 +
 drivers/mtd/nand/raw/fsl_elbc_nand.c                        |   3 +-
 drivers/mtd/nand/raw/lpc32xx_mlc.c                          |   5 +-
 drivers/mtd/nand/raw/meson_nand.c                           |   2 +-
 drivers/mtd/nand/raw/mtk_nand.c                             |   2 +-
 drivers/mtd/nand/raw/nand_base.c                            |  92 ++++++---
 drivers/mtd/nand/raw/nand_bbt.c                             |   1 -
 drivers/mtd/nand/raw/nand_hynix.c                           |   1 -
 drivers/mtd/nand/raw/stm32_fmc2_nand.c                      |  83 ++++++--
 drivers/mtd/nand/spi/esmt.c                                 |   9 +-
 drivers/mtd/nand/spi/winbond.c                              |  12 ++
 drivers/mtd/spi-nor/core.c                                  | 187 ++++++++=
+---------
 drivers/mtd/spi-nor/core.h                                  |  30 +--
 drivers/mtd/spi-nor/debugfs.c                               |  26 ++-
 drivers/mtd/spi-nor/sfdp.c                                  |  47 ++---
 drivers/mtd/ssfdc.c                                         |   7 +-
 include/linux/mtd/flashchip.h                               |   1 +
 include/linux/mtd/lpc32xx_mlc.h                             |   2 +-
 include/linux/mtd/lpc32xx_slc.h                             |   2 +-
 include/linux/mtd/mtd.h                                     |   2 +-
 include/linux/mtd/spinand.h                                 |   2 +-
 79 files changed, 982 insertions(+), 658 deletions(-)
 delete mode 100644 drivers/mtd/maps/intel_vr_nor.c
 delete mode 100644 drivers/mtd/nand/raw/brcmnand/bcm63138_nand.c
 create mode 100644 drivers/mtd/nand/raw/brcmnand/bcmbca_nand.c

