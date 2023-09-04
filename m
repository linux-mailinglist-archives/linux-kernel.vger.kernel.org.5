Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5644A79195C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 16:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243823AbjIDOFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 10:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238186AbjIDOFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 10:05:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54AECFE
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 07:04:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5882A6178B
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 14:04:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB15DC433C8;
        Mon,  4 Sep 2023 14:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693836288;
        bh=zHIZ8iT5gBjL3M6HSZxAVEUVbGdz5olcOpWEaxEJKAs=;
        h=Date:From:To:Cc:Subject:From;
        b=NDFHL7b8Pn7A6S9kt8QP0FnPqP1lMUdL1HLMWGLzUW6HwfLPF7jOUvUv2cu4nC0NP
         2QIasfRMGrnp3pFTp6+YZpibZPUecYeCuEfOVqTCNbzTd1v+Uoz0+iiQ5TejjdTAso
         kDFOUoEZeIFzCsrz8mIqe09godEl1swY2b8uJM9gnuF9xtdZFjCiMeawHcfR0ZvXN6
         FohM/xpTNU/U0ln2MZqaQek2vqPwqftMevGmwgbCI25s0f96sB0H3llDcMc2MmOfyS
         yC4Z7HyUIQb49lL/fSZAjaNdVkKLZmhxW9AjJNnxs6b49vTKVHDuQGGVorTCCFvNKN
         iyH8KVdA1JYVg==
Date:   Mon, 4 Sep 2023 15:04:44 +0100
From:   Lee Jones <lee@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Lee Jones <lee@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] MFD for v6.6
Message-ID: <20230904140444.GA13143@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good afternoon Linus,

The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/mfd-next-6.6

for you to fetch changes up to 9aab92bc3a8922d4b2e24d10271dfe3034cbf5c2:

  mfd: mc13xxx: Simplify device data fetching in probe() (2023-08-22 08:07:52 +0100)

----------------------------------------------------------------
 - New Drivers
   - Add support for the Cirrus Logic CS42L43 Audio CODEC

 - Fix-ups
   - Make use of specific printk() format tags for various optimisations
   - Kconfig / module modifications / tweaking
   - Simplify obtaining resources (memory, device data) using unified API helpers
   - Bunch of Device Tree additions, conversions and adaptions
   - Convert a bunch of Regmap configurations to use the Maple Tree cache
   - Ensure correct includes are present and remove some that are not required
   - Remove superfluous code
   - Reduce amount of cycles spent in critical sections
   - Omit the use of redundant casts and if relevant replace with better ones
   - Swap out raw_spin_{un}lock_irq{save,restore}() for spin_{un}lock_irq{save,restore}()

 - Bug Fixes
   - Repair theoretical deadlock situation
   - Fix some link-time dependencies
   - Use more appropriate datatype when casting

----------------------------------------------------------------
Alexander Stein (1):
      MAINTAINERS: Add entry for TQ-Systems device trees and drivers

Andre Werner (1):
      mfd: tps65086: Read DEVICE ID register 1 from device

Andy Shevchenko (1):
      mfd: ipaq-micro: Use %*ph for printing hexdump of a small buffer

Arnd Bergmann (1):
      mfd: rz-mtu3: Link time dependencies

Biju Das (5):
      mfd: Add module build support for RZ/G2L MTU3a
      mfd: rz-mtu3: Fix COMPILE_TEST build error
      mfd: rz-mtu3: Reduce critical sections
      mfd: rz-mtu3: Replace raw_spin_lock->spin_lock()
      mfd: mc13xxx: Simplify device data fetching in probe()

Charles Keepax (3):
      dt-bindings: mfd: cirrus,cs42l43: Add initial DT binding
      mfd: cs42l43: Add support for cs42l43 core driver
      pinctrl: cs42l43: Add support for the cs42l43

Chengfeng Ye (1):
      mfd: qcom-pm8xxx: Fix potential deadlock on &chip->pm_irq_lock

Fabio Estevam (1):
      dt-bindings: mfd: bd71847-pmic: Remove unneeded LED header

Geert Uytterhoeven (1):
      mfd: rk808: Make MFD_RK8XX tristate

Konrad Dybcio (1):
      dt-bindings: mfd: qcom,spmi-pmic: Reference pm8916 wcd analog codec schema

Krzysztof Kozlowski (15):
      dt-bindings: mfd: brcm: Drop unneeded quotes and use absolute /schemas path
      dt-bindings: mfd: qcom,spmi-pmic: Document PMC8180 and PMC8180C
      dt-bindings: mfd: maxim,max77693: Add USB connector
      dt-bindings: mfd: maxim,max77693: Add USB connector
      dt-bindings: mfd: st,stpmic1: Merge patterns for nodes
      dt-bindings: mfd: stericsson,db8500-prcmu: Add missing unevaluatedProperties for each regulator
      mfd: stmpe: Fix Wvoid-pointer-to-enum-cast warning
      mfd: max14577: Fix Wvoid-pointer-to-enum-cast warning
      mfd: max77541: Fix Wvoid-pointer-to-enum-cast warning
      mfd: hi6421-pmic: Fix Wvoid-pointer-to-enum-cast warning
      mfd: lp87565: Fix Wvoid-pointer-to-enum-cast warning
      mfd: tc3589: Fix Wvoid-pointer-to-enum-cast warning
      mfd: wm8994: Fix Wvoid-pointer-to-enum-cast warning
      mfd: wm31x: Fix Wvoid-pointer-to-enum-cast warning
      mfd: mxs-lradc: Fix Wvoid-pointer-to-enum-cast warning

Lee Jones (1):
      Merge tags 'ib-mfd-pinctrl-soundwire-v6.6' and 'ib-mfd-regulator-v6.6' into ibs-for-mfd-merged

Li Zetao (1):
      mfd: ipaq-micro: Remove unused variable i in micro_rx_msg()

Linus Walleij (1):
      dt-bindings: mfd: Convert STMPE to YAML schema

Lucas Tanure (1):
      soundwire: bus: Allow SoundWire peripherals to register IRQ handlers

Manikandan Muralidharan (1):
      dt-bindings: mfd: Add bindings for SAM9X75 LCD controller

Mark Brown (12):
      mfd: axp20x: Update to use maple tree register cache
      mfd: cs47l15: Update to use maple tree register cache
      mfd: cs47l24: Update to use maple tree register cache
      mfd: cs47l35: Update to use maple tree register cache
      mfd: cs47l85: Update to use maple tree register cache
      mfd: cs47l90: Update to use maple tree register cache
      mfd: cs47l92: Update to use maple tree register cache
      mfd: wm5102: Update to use maple tree register cache
      mfd: wm5110: Update to use maple tree register cache
      mfd: wm8994: Update to use maple tree register cache
      mfd: wm8997: Update to use maple tree register cache
      mfd: wm8998: Update to use maple tree register cache

Rob Herring (2):
      mfd: Explicitly include correct DT includes
      dt-bindings: mfd: allwinner: prcm: Simplify conditional schemas

Rohit Agarwal (2):
      dt-bindings: mfd: Add compatible for pm7550ba
      dt-bindings: mfd: Add compatible for pmx75

Ruan Jinjie (1):
      mfd: tc3589x: Remove redundant of_match_ptr()

Varshini Rajendran (4):
      dt-bindings: mfd: at91: Add SAM9X7 compatible string
      dt-bindings: mfd: atmel-gpbr: Add microchip,sam9x7-gpbr
      dt-bindings: mfd: atmel-matrix: Add microchip,sam9x7-matrix
      dt-bindings: mfd: atmel-smc: Add microchip,sam9x7-smc

Yang Li (1):
      mfd: rz-mtu3: Remove duplicated include module.h

Yangtao Li (7):
      mfd: atmel-hlcdc: Convert to devm_platform_ioremap_resource()
      mfd: omap-usb-tll: Convert to devm_platform_ioremap_resource()
      mfd: ti_am335x_tscadc: Use devm_platform_get_and_ioremap_resource()
      mfd: exynos-lpass: Convert to devm_platform_ioremap_resource()
      mfd: omap-usb-host: Convert to devm_platform_ioremap_resource()
      mfd: stm32-timers: Use devm_platform_get_and_ioremap_resource()
      mfd: hi655x-pmic: Convert to devm_platform_ioremap_resource()

Yue Haibing (3):
      mfd: max77686: Remove unused extern declarations
      mfd: ab8500: Remove unused extern declarations
      mfd: 88pm860x: Remove unused extern declarations

YueHaibing (1):
      mfd: db8500-prcmu: Remove unused inline functions

Zhu Wang (7):
      mfd: rsmu_i2c: Remove redundant of_match_ptr()
      mfd: altera-a10sr: Remove redundant of_match_ptr()
      mfd: rsmu_spi: Remove redundant of_match_ptr()
      mfd: act8945a: Remove redundant of_match_ptr()
      mfd: stpmic1: Remove redundant of_match_ptr()
      mfd: lochnagar-i2c: Remove redundant of_match_ptr()
      mfd: rn5t618: Remove redundant of_match_ptr()

 .../devicetree/bindings/input/stmpe-keypad.txt     |   41 -
 .../bindings/input/touchscreen/stmpe.txt           |  108 --
 .../bindings/mfd/allwinner,sun6i-a31-prcm.yaml     |   43 +-
 .../bindings/mfd/allwinner,sun8i-a23-prcm.yaml     |   42 -
 .../devicetree/bindings/mfd/atmel-flexcom.txt      |    1 +
 .../devicetree/bindings/mfd/atmel-gpbr.txt         |    1 +
 .../devicetree/bindings/mfd/atmel-hlcdc.txt        |    1 +
 .../devicetree/bindings/mfd/atmel-matrix.txt       |    1 +
 .../devicetree/bindings/mfd/atmel-smc.txt          |    1 +
 .../bindings/mfd/brcm,bcm6318-gpio-sysctl.yaml     |    4 +-
 .../bindings/mfd/brcm,bcm63268-gpio-sysctl.yaml    |    4 +-
 .../bindings/mfd/brcm,bcm6328-gpio-sysctl.yaml     |    4 +-
 .../bindings/mfd/brcm,bcm6358-gpio-sysctl.yaml     |    4 +-
 .../bindings/mfd/brcm,bcm6362-gpio-sysctl.yaml     |    4 +-
 .../bindings/mfd/brcm,bcm6368-gpio-sysctl.yaml     |    4 +-
 .../devicetree/bindings/mfd/maxim,max77693.yaml    |   52 +
 .../devicetree/bindings/mfd/qcom,spmi-pmic.yaml    |    6 +-
 .../devicetree/bindings/mfd/rohm,bd71847-pmic.yaml |    1 -
 .../devicetree/bindings/mfd/st,stmpe.yaml          |  297 +++++
 .../devicetree/bindings/mfd/st,stpmic1.yaml        |   12 +-
 .../bindings/mfd/stericsson,db8500-prcmu.yaml      |   20 +
 Documentation/devicetree/bindings/mfd/stmpe.txt    |   42 -
 .../devicetree/bindings/sound/cirrus,cs42l43.yaml  |  313 ++++++
 MAINTAINERS                                        |   17 +
 drivers/counter/Kconfig                            |    2 +-
 drivers/mfd/Kconfig                                |   28 +-
 drivers/mfd/Makefile                               |    3 +
 drivers/mfd/ab8500-core.c                          |    1 -
 drivers/mfd/acer-ec-a500.c                         |    2 +-
 drivers/mfd/act8945a.c                             |    4 +-
 drivers/mfd/altera-a10sr.c                         |    2 +-
 drivers/mfd/altera-sysmgr.c                        |    3 +-
 drivers/mfd/arizona-core.c                         |    1 -
 drivers/mfd/atc260x-core.c                         |    1 -
 drivers/mfd/atmel-hlcdc.c                          |    4 +-
 drivers/mfd/axp20x.c                               |   12 +-
 drivers/mfd/bcm590xx.c                             |    1 -
 drivers/mfd/cros_ec_dev.c                          |    2 +-
 drivers/mfd/cs42l43-i2c.c                          |   98 ++
 drivers/mfd/cs42l43-sdw.c                          |  239 ++++
 drivers/mfd/cs42l43.c                              | 1188 ++++++++++++++++++++
 drivers/mfd/cs42l43.h                              |   28 +
 drivers/mfd/cs47l15-tables.c                       |    8 +-
 drivers/mfd/cs47l24-tables.c                       |    2 +-
 drivers/mfd/cs47l35-tables.c                       |    8 +-
 drivers/mfd/cs47l85-tables.c                       |    8 +-
 drivers/mfd/cs47l90-tables.c                       |    8 +-
 drivers/mfd/cs47l92-tables.c                       |    8 +-
 drivers/mfd/da9052-i2c.c                           |    5 +-
 drivers/mfd/da9055-i2c.c                           |    1 -
 drivers/mfd/da9062-core.c                          |    2 +-
 drivers/mfd/exynos-lpass.c                         |    4 +-
 drivers/mfd/hi6421-pmic-core.c                     |    2 +-
 drivers/mfd/hi655x-pmic.c                          |    7 +-
 drivers/mfd/ipaq-micro.c                           |    7 +-
 drivers/mfd/iqs62x.c                               |    2 +-
 drivers/mfd/lochnagar-i2c.c                        |    2 +-
 drivers/mfd/lp873x.c                               |    2 +-
 drivers/mfd/lp87565.c                              |    2 +-
 drivers/mfd/madera-i2c.c                           |    1 -
 drivers/mfd/madera-spi.c                           |    1 -
 drivers/mfd/max14577.c                             |    3 +-
 drivers/mfd/max77541.c                             |    2 +-
 drivers/mfd/max77620.c                             |    1 -
 drivers/mfd/max77686.c                             |    1 -
 drivers/mfd/max77843.c                             |    2 +-
 drivers/mfd/max8907.c                              |    1 -
 drivers/mfd/max8925-core.c                         |    1 -
 drivers/mfd/max8997.c                              |    1 -
 drivers/mfd/max8998.c                              |    1 -
 drivers/mfd/mc13xxx-i2c.c                          |    9 +-
 drivers/mfd/mt6358-irq.c                           |    5 +-
 drivers/mfd/mt6397-core.c                          |    5 +-
 drivers/mfd/mt6397-irq.c                           |    5 +-
 drivers/mfd/mxs-lradc.c                            |    2 +-
 drivers/mfd/omap-usb-host.c                        |    4 +-
 drivers/mfd/omap-usb-tll.c                         |    4 +-
 drivers/mfd/palmas.c                               |    3 +-
 drivers/mfd/qcom-pm8008.c                          |    2 +-
 drivers/mfd/qcom-pm8xxx.c                          |   10 +-
 drivers/mfd/rave-sp.c                              |    2 +-
 drivers/mfd/rk8xx-core.c                           |    2 +-
 drivers/mfd/rn5t618.c                              |    2 +-
 drivers/mfd/rohm-bd71828.c                         |    2 +-
 drivers/mfd/rohm-bd718x7.c                         |    2 +-
 drivers/mfd/rohm-bd9576.c                          |    2 +-
 drivers/mfd/rsmu_i2c.c                             |    2 +-
 drivers/mfd/rsmu_spi.c                             |    2 +-
 drivers/mfd/rt5033.c                               |    2 +-
 drivers/mfd/rz-mtu3.c                              |   34 +-
 drivers/mfd/sec-core.c                             |    2 -
 drivers/mfd/sprd-sc27xx-spi.c                      |    2 +-
 drivers/mfd/ssbi.c                                 |    6 +-
 drivers/mfd/stm32-lptimer.c                        |    1 +
 drivers/mfd/stm32-timers.c                         |    4 +-
 drivers/mfd/stmpe-i2c.c                            |    2 +-
 drivers/mfd/stpmic1.c                              |    2 +-
 drivers/mfd/sun4i-gpadc.c                          |    4 +-
 drivers/mfd/tc3589x.c                              |    4 +-
 drivers/mfd/ti-lmu.c                               |    1 -
 drivers/mfd/ti_am335x_tscadc.c                     |    5 +-
 drivers/mfd/tps6507x.c                             |    1 -
 drivers/mfd/tps65086.c                             |   17 +-
 drivers/mfd/tps65090.c                             |    1 -
 drivers/mfd/tps65217.c                             |    1 -
 drivers/mfd/tps65218.c                             |    1 -
 drivers/mfd/tps6594-core.c                         |    2 +-
 drivers/mfd/twl6040.c                              |    2 -
 drivers/mfd/wm5102-tables.c                        |    2 +-
 drivers/mfd/wm5110-tables.c                        |    2 +-
 drivers/mfd/wm831x-core.c                          |    3 +-
 drivers/mfd/wm831x-i2c.c                           |    2 +-
 drivers/mfd/wm831x-spi.c                           |    2 +-
 drivers/mfd/wm8994-core.c                          |    2 +-
 drivers/mfd/wm8994-regmap.c                        |    6 +-
 drivers/mfd/wm8997-tables.c                        |    2 +-
 drivers/mfd/wm8998-tables.c                        |    2 +-
 drivers/mtd/chips/cfi_cmdset_0002.c                |    3 +-
 drivers/pinctrl/cirrus/Kconfig                     |   11 +
 drivers/pinctrl/cirrus/Makefile                    |    2 +
 drivers/pinctrl/cirrus/pinctrl-cs42l43.c           |  609 ++++++++++
 drivers/pwm/Kconfig                                |    2 +-
 drivers/soundwire/bus.c                            |   32 +
 drivers/soundwire/bus_type.c                       |   12 +
 include/linux/mfd/88pm860x.h                       |    6 -
 include/linux/mfd/abx500/ab8500.h                  |    4 -
 include/linux/mfd/cs42l43-regs.h                   | 1184 +++++++++++++++++++
 include/linux/mfd/cs42l43.h                        |  102 ++
 include/linux/mfd/dbx500-prcmu.h                   |   21 -
 include/linux/mfd/hi655x-pmic.h                    |    1 -
 include/linux/mfd/max77686-private.h               |    4 -
 include/linux/mfd/rz-mtu3.h                        |   66 --
 include/linux/mfd/tps65086.h                       |   20 +-
 include/linux/soundwire/sdw.h                      |    9 +
 134 files changed, 4427 insertions(+), 578 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/input/stmpe-keypad.txt
 delete mode 100644 Documentation/devicetree/bindings/input/touchscreen/stmpe.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/st,stmpe.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/stmpe.txt
 create mode 100644 Documentation/devicetree/bindings/sound/cirrus,cs42l43.yaml
 create mode 100644 drivers/mfd/cs42l43-i2c.c
 create mode 100644 drivers/mfd/cs42l43-sdw.c
 create mode 100644 drivers/mfd/cs42l43.c
 create mode 100644 drivers/mfd/cs42l43.h
 create mode 100644 drivers/pinctrl/cirrus/pinctrl-cs42l43.c
 create mode 100644 include/linux/mfd/cs42l43-regs.h
 create mode 100644 include/linux/mfd/cs42l43.h

-- 
Lee Jones [李琼斯]
