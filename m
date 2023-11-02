Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 309FA7DF506
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 15:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbjKBO3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 10:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232133AbjKBO3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 10:29:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2E61AE
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 07:29:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92562C433C8;
        Thu,  2 Nov 2023 14:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698935362;
        bh=QMaJSu/BMTUre5ifZyGQ+X9NpbefLAydRbpY4h3WQCI=;
        h=Date:From:To:Cc:Subject:From;
        b=ZasBQeWQ3uWwKRXYtor/O/uYKNy4plNxahW4zeLRDEvIRIv938HPi3Am0lLVCeTvc
         zvecFgHHRMi9BHVsKItyNcYVNGD5WJNUMA4VzdJoftn/nOGtQ+KNV495jhw9xUpB2n
         Y1uSYpnvxEgzPTkpaeTZBFAWUWM8z+ufExJAuaqCbPUzFTI8e/gJt0Hz3S2DCzsu+R
         neFynvQvU+elky+2KWhnT1ngovCN1brZR5B9vKL7alwTW8hDX7VM0vsaVTCZrwzcCG
         P0kF3VYir1X1YrMjnxiZoCOSAxdlbNQx7P1A0CUb+0t3J0pLsNlXuKptJ5j/A1ALg+
         V9JMX4P6O0i4w==
Date:   Thu, 2 Nov 2023 14:29:18 +0000
From:   Lee Jones <lee@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Lee Jones <lee@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] MFD for v6.7
Message-ID: <20231102142918.GX8909@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good afternoon Linus,

The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

  Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/mfd-next-6.7

for you to fetch changes up to 2b481822446e30943fb7c02744a7b49ebec0e696:

  mfd: lpc_ich: Mark *_gpio_offsets data with const (2023-11-01 10:02:18 +0000)

----------------------------------------------------------------
 - Core Frameworks
   - Allow all MFD Cell properties to be filled in dynamically at runtime
   - Skip disabled device nodes and continue to look for subsequent devices

 - New Device Support
   - Add support for Lunar Lake-M PCI to Intel LPSS PCI
   - Add support for Denverton to Intel ICH LPC

 - New Functionality
   - Add support for Clocks to Texas Instruments TWL* Core
   - Add support for Interrupts to STMicroelectronics STM32 Timers

 - Fix-ups
   - Convert to new devm-* (managed) power-off API
   - Remove superfluous code
   - Bunch of Device Tree additions, conversions and adaptions
   - Simplify obtaining resources (memory, device data) using unified API helpers
   - Trivial coding-style / spelling type clean-ups
   - Constify / staticify changes
   - Expand or edit on existing documentation
   - Convert some Regmap configurations to use the Maple Tree cache
   - Apply new __counted_by() annotation to several data structures containing flexible arrays
   - Replace strncpy() with strscpy()

 - Bug Fixes
   - Remove double put creating reference imbalances
   - Ensure headphone/lineout detection sets set when booting with ACPI

----------------------------------------------------------------
Alex Bee (1):
      dt-bindings: mfd: syscon: Add rockchip,rk3128-qos compatible

Andre Przywara (2):
      mfd: axp20x: Generalise handling without interrupt
      dt-bindings: mfd: x-powers,axp152: Make interrupt optional for more chips

Andreas Kemnade (3):
      dt-bindings: mfd: Convert twl-family.txt to json-schema
      dt-bindings: mfd: ti,twl: Add clock provider properties
      mfd: twl-core: Add a clock subdevice for the TWL6032

Andrew Davis (1):
      dt-bindings: mfd: syscon: Add ti,am654-dss-oldi-io-ctrl compatible

Andy Shevchenko (5):
      mfd: lpc_ich: Make struct lpc_ich_priv use enum for chipset member
      mfd: lpc_ich: Convert gpio_version to be enum
      mfd: lpc_ich: Move APL GPIO resources to a custom structure
      mfd: lpc_ich: Add a platform device for pinctrl Denverton
      mfd: lpc_ich: Mark *_gpio_offsets data with const

Benjamin Bara (5):
      kernel/reboot: emergency_restart: Set correct system_state
      i2c: core: Run atomic i2c xfer when !preemptible
      kernel/reboot: Add device to sys_off_handler
      mfd: tps6586x: Use devm-based power off handler
      mfd: tps6586x: Register restart handler

Biju Das (9):
      mfd: max8997: Simplify obtaining I2C match data and drop max8997_i2c_get_driver_data()
      mfd: palmas: Remove trailing comma in the terminator entry
      mfd: palmas: Constify .data in OF table and {palmas,tps65917}_irq_chip
      mfd: palmas: Move OF table closer to its consumer
      mfd: palmas: Make similar OF and ID table
      mfd: arizona-i2c: Simplify obtaining I2C match data
      mfd: madera-i2c: Simplify obtaining I2C match data
      mfd: max77541: Simplify obtaining I2C match data
      mfd: max8998: Simplify obtaining I2C match data and drop max8998_i2c_get_driver_data()

Bryan O'Donoghue (1):
      dt-bindings: mfd: qcom,spmi-pmic: Add typec to SPMI device types

Chen-Yu Tsai (1):
      dt-bindings: mfd: mt6397: Split out compatible for MediaTek MT6366 PMIC

Dinghao Liu (1):
      mfd: dln2: Fix double put in dln2_probe

Dmitry Baryshkov (2):
      dt-bindings: mfd: qcom-spmi-pmic: Add pm8450 entry
      dt-bindings: mfd: qcom-pm8xxx: Add missing child nodes

Fabrice Gasnier (1):
      mfd: stm32-timers: Add support for interrupts

Geert Uytterhoeven (1):
      dt-bindings: mfd: stericsson,db8500-prcmu: Spelling s/Cortex A-/Cortex-A/

Hans de Goede (1):
      mfd: arizona-spi: Set pdata.hpdet_channel for ACPI enumerated devs

Herve Codina (1):
      mfd: core: Ensure disabled devices are skipped without aborting

Jarkko Nikula (1):
      mfd: intel-lpss: Add Intel Lunar Lake-M PCI IDs

Johan Hovold (5):
      mfd: qcom-spmi-pmic: Fix reference leaks in revid helper
      mfd: qcom-spmi-pmic: Fix revid implementation
      mfd: qcom-spmi-pmic: Switch to EXPORT_SYMBOL_GPL()
      spmi: document spmi_device_from_of() refcounting
      spmi: rename spmi device lookup helper

Justin Stitt (1):
      mfd: db8500-prcmu: Replace deprecated strncpy with strscpy

Kees Cook (1):
      mfd: iqs62x: Annotate struct iqs62x_fw_blk with __counted_by

Krzysztof Kozlowski (1):
      dt-bindings: mfd: maxim,max8998: Convert to DT schema

Lee Jones (1):
      Merge tag 'ib-mfd-i2c-reboot-v6.7' into ibs-for-mfd-merged

Luca Weiss (1):
      dt-bindings: mfd: qcom,spmi-pmic: Drop unused labels from examples

Manikandan Muralidharan (1):
      mfd: atmel-hlcdc: Add compatible for sam9x75 XLCD controller

Mark Brown (12):
      mfd: wcd934x: Update to use maple tree register cache
      mfd: tps65086: Convert to use maple tree register cache
      mfd: tps65090: Convert to use maple tree register cache
      mfd: tps65128: Convert to use maple tree register cache
      mfd: tps6586x: Convert to use maple tree register cache
      mfd: tps65910: Convert to use maple tree register cache
      mfd: tps65912: Convert to use maple tree register cache
      mfd: twl: Convert to use maple tree register cache
      mfd: rk8xx: Convert to use maple tree register cache
      mfd: max77620: Convert to use maple tree register cache
      mfd: max77686: Convert to use maple tree register cache
      mfd: max8907: Convert to use maple tree register cache

Michał Mirosław (1):
      mfd: core: Un-constify mfd_cell.of_reg

Ondrej Jirman (4):
      dt-bindings: mfd: rk8xx: Deprecate rockchip,system-power-controller
      dt-bindings: mfd: rk806: Allow system-power-controller property
      mfd: rk8xx: Add support for standard system-power-controller property
      mfd: rk8xx: Add support for RK806 power off

Rob Herring (6):
      dt-bindings: mfd: Add missing unevaluatedProperties on child node schemas
      mfd: motorola-cpcap: Drop unnecessary of_match_device() call
      mfd: mc13xxx-spi/wm831x-spi: Use spi_get_device_match_data()
      mfd: Use device_get_match_data() in a bunch of drivers
      mfd: Use i2c_get_match_data() in a selection of drivers
      dt-bindings: mfd: armltd: Move Arm board syscon's to separate schema

Russ Weight (1):
      mfd: intel-m10-bmc: Change contact for ABI docs

Sebastian Reichel (1):
      dt-bindings: mfd: max8925: Convert to DT schema format

Tengfei Fan (1):
      dt-bindings: mfd: qcom,tcsr: Add compatible for sm4450

Ying Sun (1):
      mfd: ab8500: Remove non-existent configuration "#ifdef CONFIG_AB8500_DEBUG"

 .../ABI/testing/sysfs-driver-intel-m10-bmc         |   4 +-
 .../devicetree/bindings/arm/arm,integrator.yaml    |  39 ---
 .../devicetree/bindings/arm/arm,realview.yaml      |  37 ---
 .../devicetree/bindings/arm/arm,versatile.yaml     |  40 +--
 .../bindings/input/twl4030-pwrbutton.txt           |   2 +-
 .../bindings/leds/backlight/max8925-backlight.txt  |  10 -
 .../devicetree/bindings/leds/register-bit-led.yaml |   2 +-
 .../bindings/mfd/arm,dev-platforms-syscon.yaml     |  67 +++++
 Documentation/devicetree/bindings/mfd/max8925.txt  |  64 ----
 Documentation/devicetree/bindings/mfd/max8998.txt  | 125 --------
 .../devicetree/bindings/mfd/maxim,max5970.yaml     |   5 +
 .../devicetree/bindings/mfd/maxim,max8925.yaml     | 145 +++++++++
 .../devicetree/bindings/mfd/maxim,max8998.yaml     | 324 +++++++++++++++++++++
 .../devicetree/bindings/mfd/mediatek,mt6357.yaml   |   2 +
 Documentation/devicetree/bindings/mfd/mt6397.txt   |   4 +-
 .../devicetree/bindings/mfd/qcom,spmi-pmic.yaml    |  11 +-
 .../devicetree/bindings/mfd/qcom,tcsr.yaml         |   1 +
 .../devicetree/bindings/mfd/qcom-pm8xxx.yaml       |  26 +-
 .../devicetree/bindings/mfd/rockchip,rk805.yaml    |   4 +
 .../devicetree/bindings/mfd/rockchip,rk806.yaml    |   2 +
 .../devicetree/bindings/mfd/rockchip,rk808.yaml    |   4 +
 .../devicetree/bindings/mfd/rockchip,rk809.yaml    |   6 +-
 .../devicetree/bindings/mfd/rockchip,rk817.yaml    |   3 +
 .../devicetree/bindings/mfd/rockchip,rk818.yaml    |   4 +
 .../bindings/mfd/stericsson,db8500-prcmu.yaml      |   2 +-
 Documentation/devicetree/bindings/mfd/syscon.yaml  |   2 +
 .../devicetree/bindings/mfd/ti,lp87524-q1.yaml     |   1 +
 .../devicetree/bindings/mfd/ti,lp87561-q1.yaml     |   1 +
 .../devicetree/bindings/mfd/ti,lp87565-q1.yaml     |   1 +
 Documentation/devicetree/bindings/mfd/ti,twl.yaml  |  67 +++++
 .../devicetree/bindings/mfd/twl-family.txt         |  46 ---
 .../devicetree/bindings/mfd/x-powers,axp152.yaml   |   5 +-
 .../bindings/power/supply/max8925_battery.txt      |  18 --
 drivers/i2c/i2c-core.h                             |   2 +-
 drivers/mfd/arizona-i2c.c                          |  11 +-
 drivers/mfd/arizona-spi.c                          |   3 +
 drivers/mfd/atmel-hlcdc.c                          |   1 +
 drivers/mfd/axp20x.c                               |  66 ++---
 drivers/mfd/db8500-prcmu.c                         |   4 +-
 drivers/mfd/dln2.c                                 |   1 -
 drivers/mfd/hi6421-pmic-core.c                     |   9 +-
 drivers/mfd/intel-lpss-pci.c                       |  13 +
 drivers/mfd/iqs62x.c                               |   2 +-
 drivers/mfd/lochnagar-i2c.c                        |   9 +-
 drivers/mfd/lp87565.c                              |   9 +-
 drivers/mfd/lpc_ich.c                              | 127 ++++++--
 drivers/mfd/madera-i2c.c                           |   9 +-
 drivers/mfd/max14577.c                             |  14 +-
 drivers/mfd/max77541.c                             |   6 +-
 drivers/mfd/max77620.c                             |   6 +-
 drivers/mfd/max77686.c                             |   2 +-
 drivers/mfd/max8907.c                              |   4 +-
 drivers/mfd/max8997.c                              |  12 +-
 drivers/mfd/max8998.c                              |  12 +-
 drivers/mfd/mc13xxx-spi.c                          |  14 +-
 drivers/mfd/mfd-core.c                             |  17 +-
 drivers/mfd/motorola-cpcap.c                       |   7 +-
 drivers/mfd/mxs-lradc.c                            |   9 +-
 drivers/mfd/palmas.c                               |  60 ++--
 drivers/mfd/qcom-spmi-pmic.c                       | 109 +++++--
 drivers/mfd/qcom_rpm.c                             |   8 +-
 drivers/mfd/rk8xx-core.c                           |   7 +-
 drivers/mfd/rk8xx-i2c.c                            |   6 +-
 drivers/mfd/rn5t618.c                              |  11 +-
 drivers/mfd/stm32-timers.c                         |  46 +++
 drivers/mfd/tps65086.c                             |   2 +-
 drivers/mfd/tps65090.c                             |   2 +-
 drivers/mfd/tps65218.c                             |   2 +-
 drivers/mfd/tps6586x.c                             |  52 +++-
 drivers/mfd/tps65910.c                             |  13 +-
 drivers/mfd/tps65912-core.c                        |   2 +-
 drivers/mfd/twl-core.c                             |  18 +-
 drivers/mfd/twl4030-power.c                        |   9 +-
 drivers/mfd/twl6030-irq.c                          |  10 +-
 drivers/mfd/wcd934x.c                              |   2 +-
 drivers/mfd/wm831x-i2c.c                           |  16 +-
 drivers/mfd/wm831x-spi.c                           |  16 +-
 drivers/mfd/wm8994-core.c                          |  11 +-
 drivers/spmi/spmi.c                                |   9 +-
 include/linux/mfd/abx500/ab8500.h                  |   6 -
 include/linux/mfd/core.h                           |   2 +-
 include/linux/mfd/lpc_ich.h                        |   7 +-
 include/linux/mfd/stm32-timers.h                   |  11 +
 include/linux/reboot.h                             |   3 +
 include/linux/spmi.h                               |   2 +-
 kernel/reboot.c                                    |   4 +
 86 files changed, 1159 insertions(+), 730 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/leds/backlight/max8925-backlight.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/arm,dev-platforms-syscon.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/max8925.txt
 delete mode 100644 Documentation/devicetree/bindings/mfd/max8998.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/maxim,max8925.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/maxim,max8998.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/ti,twl.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/twl-family.txt
 delete mode 100644 Documentation/devicetree/bindings/power/supply/max8925_battery.txt

-- 
Lee Jones [李琼斯]
