Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B87387900DC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 18:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347325AbjIAQmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 12:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240775AbjIAQmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 12:42:46 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3D5173A
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 09:42:17 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id CC166FF803;
        Fri,  1 Sep 2023 16:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1693586536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=dxDNHuXE0XrLFfpqSdgspcXkP1rkwHL8cDd0+piWLXc=;
        b=iFy6/cJVQezVzo9d1cB4OB+qZ7kDZOxl1j0Sb5N+qBtVlkXMaGLzDQX/oMJIdBGM05fySM
        QoIx+gLIxdQL1Gq2kwj2VjFPxtesppjeCTtcvKHgItSVOeX1zekA474ii9z8Bpw5Y2hDxS
        GPwdAWaHnlzR5EBTPNz5umIR+FwKYaJw29cqqQRnTD1UtNDmSkj23HYt/L4NyDJAS6lWA+
        vHK+lQn7HDAPYMctNRS7LAPls6FDnJWQB4BM8JUzcEkGw433TQNM6yUr0vd3gSS8ubWDwV
        lIGK4zaTAcsKQshlRb5vNi+8xdaTrqSl5HpUfnE+Wh8DwuvM65qkpbnwvn1K5w==
Date:   Fri, 1 Sep 2023 18:42:11 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@linaro.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <pratyush@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] mtd: Changes for v6.6-rc1
Message-ID: <20230901184136.73b2833e@xps-13>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

This is the MTD PR for the current merge window preparing the v6.6
cycles.

Thanks,
Miqu=C3=A8l

The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/for-=
6.6

for you to fetch changes up to 54a3f6e89fbbf12e1e3539a4f977a7536029d780:

  Merge tag 'nand/for-6.6' into mtd/next (2023-08-28 16:37:38 +0200)

----------------------------------------------------------------
Core MTD changes:
* Use refcount to prevent corruption
* Call external _get and _put in right order
* Fix use-after-free in mtd release
* Explicitly include correct DT includes
* Clean refcounting with MTD_PARTITIONED_MASTER
* mtdblock: make warning messages ratelimited
* dt-bindings: Add SEAMA partition bindings

MTD device driver changes:
* spear_smi: Use helper function devm_clk_get_enabled()
* maps: fix -Wvoid-pointer-to-enum-cast warning
* docg3: Remove unnecessary (void*) conversions
* physmap-core, spear_smi, st_spi_fsm, lpddr2_nvm, lantiq-flash, plat-ram:
  - Use devm_platform_get_and_ioremap_resource()

Raw NAND core changes:
* Fix -Wvoid-pointer-to-enum-cast warning
* Export 'nand_exit_status_op()'
* dt-bindings: Fix nand-controller.yaml license

Raw NAND controller driver changes:
* Omap, Omap2, Samsung, Atmel, fsl_upm, lpc32xx_slc, lpc32xx_mlc, STM32_FMC=
2,
  sh_ftlctl, MXC, Sunxi:
  - Use devm_platform_get_and_ioremap_resource()
* Orion, vf610_nfc, Sunxi, STM32_FMC2, MTK, mpc5121, lpc32xx_slc, Intel,
  FSMC, Arasan:
  - Use helper function devm_clk_get_optional_enabled()
* Brcmnand:
  - Use devm_platform_ioremap_resource_byname()
  - Propagate init error -EPROBE_DEFER up
  - Propagate error and simplify ternary operators
  - Fix mtd oobsize
  - Fix potential out-of-bounds access in oob write
  - Fix crash during the panic_write
  - Fix potential false time out warning
  - Fix ECC level field setting for v7.2 controller
* fsmc: Handle clk prepare error in fsmc_nand_resume()
* Marvell: Add support for AC5 SoC
* Meson:
  - Support for 512B ECC step size
  - Fix build error
  - Use NAND core API to check status
  - dt-bindings:
    * Make ECC properties dependent
    * Support for 512B ECC step size
    * Drop unneeded quotes
* Oxnas: Remove driver and bindings
* Qcom:
  - Conversion to ->exec_op()
  - Removal of the legacy interface
  - Two full series of improvements/misc fixes
    * Use the BIT() macro
    * Use u8 instead of uint8_t
    * Fix alignment with open parenthesis
    * Fix the spacing
    * Fix wrong indentation
    * Fix a typo
    * Early structure initialization
    * Fix address parsing within ->exec_op()
    * Remove superfluous initialization of "ret"
    * Rename variables in qcom_op_cmd_mapping()
    * Handle unsupported opcode in qcom_op_cmd_mapping()
    * Fix the opcode check in qcom_check_op()
    * Use EOPNOTSUPP instead of ENOTSUPP
    * Wrap qcom_nand_exec_op() to 80 columns
    * Unmap sg_list and free desc within submic_descs()
    * Simplify the call to nand_prog_page_end_op()
    * Do not override the error no of submit_descs()
    * Sort includes alphabetically
    * Clear buf_count and buf_start in raw read
    * Add read/read_start ops in exec_op path
* vf610_nfc: Do not check 0 for platform_get_irq()

SPI NAND manufacturer driver changes:
* gigadevice: Add support for GD5F1GQ{4,5}RExxH
* esmt: Add support for F50D2G41KA
* toshiba: Add support for T{C,H}58NYG{0,2}S3HBAI4 and TH58NYG3S0HBAI6

SPI NOR core changes:
* fix assumption on enabling quad mode in
  spi_nor_write_16bit_sr_and_check()
* avoid setting SRWD bit in SR if WP# signal not connected as it will
  configure the SR permanently as read only. Add "no-wp" dt property.
* clarify the need for spi-nor compatibles in dt-bindings

SPI NOR manufacturer driver changes:
* Spansion:
  - Add support for S28HS02GT
  - Switch methods to use vreg_offset from SFDP instead of hardcoding
    the register value
* Microchip/SST:
  - Add support for sst26vf032b flash
* Winbond:
  - Correct flags for Winbond w25q128
* NXP spifi:
  - Use helper function devm_clk_get_enabled()

----------------------------------------------------------------
Alexander Usyskin (2):
      mtd: call external _get and _put in right order
      mtd: fix use-after-free in mtd release

Amit Kumar Mahapatra (2):
      dt-bindings: mtd: jedec, spi-nor: Add DT property to avoid setting SR=
WD bit in status register
      mtd: spi-nor: Avoid setting SRWD bit in SR if WP# signal not connected

Arseniy Krasnov (6):
      mtd: rawnand: export 'nand_exit_status_op()'
      mtd: rawnand: meson: use NAND core API to check status
      dt-bindings: nand: meson: support for 512B ECC step size
      dt-bindings: nand: meson: make ECC properties dependent
      mtd: rawnand: meson: support for 512B ECC step size
      mtd: rawnand: meson: fix build error

Chris Packham (2):
      dt-bindings: mtd: Add AC5 specific binding
      mtd: rawnand: marvell: add support for AC5 SoC

Colin Ian King (1):
      mtdblock: make warning messages ratelimited

Hsin-Yi Wang (1):
      mtd: spi-nor: Check bus width while setting QE bit

Justin Stitt (2):
      mtd: rawnand: fix -Wvoid-pointer-to-enum-cast warning
      mtd: maps: fix -Wvoid-pointer-to-enum-cast warning

Krzysztof Kozlowski (1):
      dt-bindings: mtd: amlogic,meson-nand: drop unneeded quotes

Li Zetao (13):
      mtd: rawnand: brcmnand: Use devm_platform_ioremap_resource_byname()
      mtd: spi-nor: nxp-spifi: Use helper function devm_clk_get_enabled()
      mtd: rawnand: arasan: Use helper function devm_clk_get_enabled()
      mtd: rawnand: fsmc: Use helper function devm_clk_get_enabled()
      mtd: rawnand: intel: Use helper function devm_clk_get_enabled()
      mtd: rawnand: lpc32xx_slc: Use helper function devm_clk_get_enabled()
      mtd: rawnand: mpc5121: Use helper function devm_clk_get_enabled()
      mtd: rawnand: mtk: Use helper function devm_clk_get_enabled()
      mtd: rawnand: stm32_fmc2: Use helper function devm_clk_get_enabled()
      mtd: rawnand: sunxi: Use helper function devm_clk_get_enabled()
      mtd: rawnand: vf610_nfc: Use helper function devm_clk_get_enabled()
      mtd: rawnand: orion: Use helper function devm_clk_get_optional_enable=
d()
      mtd: spear_smi: Use helper function devm_clk_get_enabled()

Linus Walleij (2):
      dt-bindings: mtd: Add SEAMA partition bindings
      mtd: spi-nor: Correct flags for Winbond w25q128

Manivannan Sadhasivam (10):
      mtd: rawnand: qcom: Remove superfluous initialization of "ret"
      mtd: rawnand: qcom: Rename variables in qcom_op_cmd_mapping()
      mtd: rawnand: qcom: Handle unsupported opcode in qcom_op_cmd_mapping()
      mtd: rawnand: qcom: Fix the opcode check in qcom_check_op()
      mtd: rawnand: qcom: Use EOPNOTSUPP instead of ENOTSUPP
      mtd: rawnand: qcom: Wrap qcom_nand_exec_op() to 80 columns
      mtd: rawnand: qcom: Unmap sg_list and free desc within submic_descs()
      mtd: rawnand: qcom: Simplify the call to nand_prog_page_end_op()
      mtd: rawnand: qcom: Do not override the error no of submit_descs()
      mtd: rawnand: qcom: Sort includes alphabetically

Md Sadre Alam (3):
      mtd: rawnand: qcom: Implement exec_op()
      mtd: rawnand: qcom: Remove legacy interface
      mtd: rawnand: qcom: Clear buf_count and buf_start in raw read

Miquel Raynal (14):
      dt-bindings: mtd: spi-nor: clarify the need for spi-nor compatibles
      dt-bindings: mtd: Fix nand-controller.yaml license
      mtd: rawnand: qcom: Use the BIT() macro
      mtd: rawnand: qcom: Use u8 instead of uint8_t
      mtd: rawnand: qcom: Fix alignment with open parenthesis
      mtd: rawnand: qcom: Fix the spacing
      mtd: rawnand: qcom: Fix wrong indentation
      mtd: rawnand: qcom: Fix a typo
      mtd: rawnand: qcom: Early structure initialization
      mtd: rawnand: qcom: Fix address parsing within ->exec_op()
      mtd: Clean refcounting with MTD_PARTITIONED_MASTER
      mtd: spi-nor: Add support for sst26vf032b flash
      Merge tag 'spi-nor/for-6.6' into mtd/next
      Merge tag 'nand/for-6.6' into mtd/next

Neil Armstrong (2):
      nand: oxnas_nand: remove obsolete raw nand driver
      dt-bindings: mtd: oxnas-nand: remove obsolete bindings

Rafa=C5=82 Mi=C5=82ecki (1):
      mtd: rawnand: brcmnand: propagate init error -EPROBE_DEFER up

Rob Herring (1):
      mtd: Explicitly include correct DT includes

Ruan Jinjie (1):
      mtd: rawnand: Propagate error and simplify ternary operators for brcm=
stb_nand_wait_for_completion()

Sricharan Ramabadhran (1):
      mtd: rawnand: qcom: Add read/read_start ops in exec_op path

Sridharan S N (3):
      mtd: spinand: gigadevice: add support for GD5F1GQ{4,5}RExxH
      mtd: spinand: esmt: add support for F50D2G41KA
      mtd: spinand: toshiba: add support for T{C,H}58NYG{0,2}S3HBAI4 and TH=
58NYG3S0HBAI6

Su Hui (1):
      mtd: devices: docg3: Remove unnecessary (void*) conversions

Takahiro Kuwano (8):
      mtd: spi-nor: spansion: use CLPEF as an alternative to CLSR
      mtd: spi-nor: spansion: preserve CFR2V[7] when writing MEMLAT
      mtd: spi-nor: spansion: prepare octal dtr methods for multi chip supp=
ort
      mtd: spi-nor: spansion: switch set_octal_dtr method to use vreg_offset
      mtd: spi-nor: spansion: switch h28hx's ready() to use vreg_offset
      mtd: spi-nor: spansion: add MCP support in set_octal_dtr()
      mtd: spi-nor: spansion: add octal DTR support in RD_ANY_REG_OP
      mtd: spi-nor: spansion: add support for S28HS02GT

Tomas Winkler (1):
      mtd: use refcount to prevent corruption

Tudor Ambarus (5):
      mtd: spi-nor: rename method for enabling or disabling octal DTR
      mtd: spi-nor: spansion: return method directly
      mtd: spi-nor: spansion: let SFDP determine the flash and sector size
      mtd: spi-nor: spansion: switch s25hx_t to use vreg_offset for quad_en=
able()
      mtd: spi-nor: spansion: switch cypress_nor_get_page_size() to use vre=
g_offset

William Zhang (5):
      mtd: rawnand: brcmnand: Fix ECC level field setting for v7.2 controll=
er
      mtd: rawnand: brcmnand: Fix potential false time out warning
      mtd: rawnand: brcmnand: Fix crash during the panic_write
      mtd: rawnand: brcmnand: Fix potential out-of-bounds access in oob wri=
te
      mtd: rawnand: brcmnand: Fix mtd oobsize

Yangtao Li (17):
      mtd: rawnand: sunxi: Use devm_platform_get_and_ioremap_resource()
      mtd: rawnand: lpc32xx_slc: Use devm_platform_get_and_ioremap_resource=
()
      mtd: rawnand: mxc: Convert to devm_platform_ioremap_resource()
      mtd: rawnand: sh_flctl: Use devm_platform_get_and_ioremap_resource()
      mtd: rawnand: omap2: Use devm_platform_get_and_ioremap_resource()
      mtd: rawnand: stm32_fmc2: Use devm_platform_get_and_ioremap_resource()
      mtd: rawnand: lpc32xx_mlc: Use devm_platform_get_and_ioremap_resource=
()
      mtd: rawnand: fsl_upm: Use devm_platform_get_and_ioremap_resource()
      mtd: rawnand: atmel: Use devm_platform_get_and_ioremap_resource()
      mtd: nand: samsung: Convert to devm_platform_ioremap_resource() and d=
evm_platform_get_and_ioremap_resource()
      mtd: plat-ram: Use devm_platform_get_and_ioremap_resource()
      mtd: lantiq-flash: Use devm_platform_get_and_ioremap_resource()
      mtd: lpddr2_nvm: Convert to devm_platform_ioremap_resource()
      mtd: st_spi_fsm: Convert to devm_platform_ioremap_resource()
      mtd: spear_smi: Convert to devm_platform_ioremap_resource()
      mtd: physmap-core: Use devm_platform_get_and_ioremap_resource()
      mtd: nand: omap: Use devm_platform_get_and_ioremap_resource()

Yi Yang (1):
      mtd: rawnand: fsmc: handle clk prepare error in fsmc_nand_resume()

Zhu Wang (1):
      mtd: rawnand: vf610_nfc: Do not check 0 for platform_get_irq()

 Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml      |    6 =
+-
 Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml           |   21 =
++-
 Documentation/devicetree/bindings/mtd/marvell,nand-controller.yaml |    1 +
 Documentation/devicetree/bindings/mtd/nand-controller.yaml         |    2 =
+-
 Documentation/devicetree/bindings/mtd/oxnas-nand.txt               |   41 =
-----
 Documentation/devicetree/bindings/mtd/partitions/seama.yaml        |   44 =
+++++
 drivers/mtd/devices/docg3.c                                        |    8 =
+-
 drivers/mtd/devices/mchp23k256.c                                   |    2 =
+-
 drivers/mtd/devices/mchp48l640.c                                   |    2 =
+-
 drivers/mtd/devices/mtd_dataflash.c                                |    1 -
 drivers/mtd/devices/spear_smi.c                                    |   20 =
+-
 drivers/mtd/devices/st_spi_fsm.c                                   |   14 =
+-
 drivers/mtd/lpddr/lpddr2_nvm.c                                     |    4 =
+-
 drivers/mtd/maps/lantiq-flash.c                                    |   11 =
+-
 drivers/mtd/maps/physmap-bt1-rom.c                                 |    1 -
 drivers/mtd/maps/physmap-core.c                                    |    3 =
+-
 drivers/mtd/maps/physmap-gemini.c                                  |    2 =
+-
 drivers/mtd/maps/physmap-ixp4xx.c                                  |    2 =
+-
 drivers/mtd/maps/physmap-ixp4xx.h                                  |    1 +
 drivers/mtd/maps/physmap-versatile.c                               |    4 =
+-
 drivers/mtd/maps/plat-ram.c                                        |    3 =
+-
 drivers/mtd/maps/sun_uflash.c                                      |    2 =
+-
 drivers/mtd/mtdblock.c                                             |    2 =
+-
 drivers/mtd/mtdblock_ro.c                                          |    2 =
+-
 drivers/mtd/mtdcore.c                                              |   97 =
+++++-----
 drivers/mtd/mtdcore.h                                              |    1 +
 drivers/mtd/mtdpart.c                                              |   14 =
+-
 drivers/mtd/nand/ecc-mxic.c                                        |    2 =
+-
 drivers/mtd/nand/ecc.c                                             |    2 =
+-
 drivers/mtd/nand/onenand/onenand_omap2.c                           |   12 =
+-
 drivers/mtd/nand/onenand/onenand_samsung.c                         |    9 =
+-
 drivers/mtd/nand/raw/Kconfig                                       |    9 =
+-
 drivers/mtd/nand/raw/Makefile                                      |    1 -
 drivers/mtd/nand/raw/ams-delta.c                                   |    2 =
+-
 drivers/mtd/nand/raw/arasan-nand-controller.c                      |   29 =
+--
 drivers/mtd/nand/raw/atmel/nand-controller.c                       |    3 =
+-
 drivers/mtd/nand/raw/brcmnand/bcm63138_nand.c                      |    4 =
+-
 drivers/mtd/nand/raw/brcmnand/brcmnand.c                           |  130 =
++++++++-----
 drivers/mtd/nand/raw/brcmnand/iproc_nand.c                         |    7 =
+-
 drivers/mtd/nand/raw/davinci_nand.c                                |    1 -
 drivers/mtd/nand/raw/denali_dt.c                                   |    1 -
 drivers/mtd/nand/raw/fsl_ifc_nand.c                                |    1 +
 drivers/mtd/nand/raw/fsl_upm.c                                     |    6 =
+-
 drivers/mtd/nand/raw/fsmc_nand.c                                   |   19 =
+-
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c                         |    2 =
+-
 drivers/mtd/nand/raw/ingenic/ingenic_ecc.c                         |    1 +
 drivers/mtd/nand/raw/ingenic/ingenic_nand_drv.c                    |    1 -
 drivers/mtd/nand/raw/intel-nand-controller.c                       |   15 =
+-
 drivers/mtd/nand/raw/lpc32xx_mlc.c                                 |    3 =
+-
 drivers/mtd/nand/raw/lpc32xx_slc.c                                 |   15 =
+-
 drivers/mtd/nand/raw/marvell_nand.c                                |   19 =
+-
 drivers/mtd/nand/raw/meson_nand.c                                  |   72 =
+++++---
 drivers/mtd/nand/raw/mpc5121_nfc.c                                 |   15 =
+-
 drivers/mtd/nand/raw/mtk_nand.c                                    |   63 =
++-----
 drivers/mtd/nand/raw/mxc_nand.c                                    |   10 =
+-
 drivers/mtd/nand/raw/nand_base.c                                   |    1 +
 drivers/mtd/nand/raw/ndfc.c                                        |    3 =
+-
 drivers/mtd/nand/raw/omap2.c                                       |    5 =
+-
 drivers/mtd/nand/raw/orion_nand.c                                  |   22 =
+--
 drivers/mtd/nand/raw/oxnas_nand.c                                  |  209 =
---------------------
 drivers/mtd/nand/raw/pl35x-nand-controller.c                       |    4 =
+-
 drivers/mtd/nand/raw/qcom_nandc.c                                  | 1003 =
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------------=
-------------------------
 drivers/mtd/nand/raw/rockchip-nand-controller.c                    |    1 -
 drivers/mtd/nand/raw/s3c2410.c                                     |    1 -
 drivers/mtd/nand/raw/sh_flctl.c                                    |    4 =
+-
 drivers/mtd/nand/raw/socrates_nand.c                               |    3 =
+-
 drivers/mtd/nand/raw/stm32_fmc2_nand.c                             |   21 =
+--
 drivers/mtd/nand/raw/sunxi_nand.c                                  |   33 =
+---
 drivers/mtd/nand/raw/vf610_nfc.c                                   |   35 =
++--
 drivers/mtd/nand/raw/xway_nand.c                                   |    3 =
+-
 drivers/mtd/nand/spi/esmt.c                                        |    9 +
 drivers/mtd/nand/spi/gigadevice.c                                  |   20 =
++
 drivers/mtd/nand/spi/toshiba.c                                     |   33 =
++++
 drivers/mtd/spi-nor/atmel.c                                        |    8 =
+-
 drivers/mtd/spi-nor/controllers/nxp-spifi.c                        |   34 =
+---
 drivers/mtd/spi-nor/core.c                                         |   57 =
+++---
 drivers/mtd/spi-nor/core.h                                         |    9 =
+-
 drivers/mtd/spi-nor/debugfs.c                                      |    1 +
 drivers/mtd/spi-nor/issi.c                                         |    4 =
+-
 drivers/mtd/spi-nor/macronix.c                                     |    4 =
+-
 drivers/mtd/spi-nor/micron-st.c                                    |    8 =
+-
 drivers/mtd/spi-nor/spansion.c                                     |  318 =
++++++++++++++++++++------------
 drivers/mtd/spi-nor/sst.c                                          |   12 =
+-
 drivers/mtd/spi-nor/swp.c                                          |    9 =
+-
 drivers/mtd/spi-nor/winbond.c                                      |    9 =
+-
 drivers/mtd/spi-nor/xilinx.c                                       |    4 =
+-
 include/linux/mtd/mtd.h                                            |    2 =
+-
 include/linux/mtd/rawnand.h                                        |    1 +
 88 files changed, 1348 insertions(+), 1307 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mtd/oxnas-nand.txt
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/seama.=
yaml
 delete mode 100644 drivers/mtd/nand/raw/oxnas_nand.c
