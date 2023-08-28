Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F051478AA09
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 12:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbjH1KSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 06:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbjH1KSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 06:18:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF96410C
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 03:18:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 38F3C637A9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 10:18:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06765C433C9;
        Mon, 28 Aug 2023 10:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693217883;
        bh=dVvlCsuqHs/FDM2YCp8Nbi6/Uaf43IJDOMx3x11Otys=;
        h=From:To:Cc:Subject:Date:From;
        b=HWHyJfvTX4AN3/AcZOx+pxmdFvGag2ewwN4XjtjKnG//SRpHps6Jy1IitUB7XsBDg
         LXIX0SuPxSkdJHH7N0ELPnb8Qr0X0hy5kdThMt08xKZ2N9eV9IFG1bAxDB0ebbTBRp
         Wy51+J4e1NGv/NY3YeEhqSVSMw8qZ4/bgDLd6zbAiwXpSBzmqbjEZXJE4Nila9BIL7
         nGW/H1Rh8YuW+ne7uzkMHMhNN402UdyloGk9e0C3ka5jTb1U4bjV3bB1/1o1Tarnyz
         nNFgLCgvMozD0RnhBZBpKMcQ7yFy8Ak5Gt3tIbTw2ExZufA2fnjIPQ4kRP+K9F+9Ov
         IQrOJXg6deTZw==
Message-ID: <19ec033cd2489b6d03dc83c30de493e9.broonie@kernel.org>
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator updates for v6.6
Date:   Mon, 28 Aug 2023 11:17:45 +0100
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        PP_MIME_FAKE_ASCII_TEXT,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 2ccdd1b13c591d306f0401d98dedc4bdcd02b421:

  Linux 6.5-rc6 (2023-08-13 11:29:55 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v6.6

for you to fetch changes up to b96c22476ff4bc3459933f87ba52cbb7910ffc6b:

  regulator: userspace-consumer: Drop event support for this cycle (2023-08-24 23:58:34 +0100)

----------------------------------------------------------------
regulator: Updates for v6.6

Other tha new device support and some minor fixes this has been a really
quiet release, the only notable things are the new drivers.  There's a
couple of MFDs among the new devices so the generic parts are pulled in:

 - Support for Analog Devices MAX77831/57/59, Awinc AW37503, Qualcom
   PMX75 and RFGEN, RealTek RT5733, RichTek RTQ2208 and Texas
   Instruments TPS65086.

----------------------------------------------------------------
Alec Li (2):
      regulator: aw37503: add regulator driver for Awinic AW37503
      regulator: dt-bindings: Add Awinic AW37503

Alina Yu (2):
      regulator: dt-bindings: rtq2208: Add Richtek RTQ2208 SubPMIC
      regulator: rtq2208: Add Richtek RTQ2208 SubPMIC driver

Andre Werner (2):
      mfd: tps65086: Read DEVICE ID register 1 from device
      regulator: tps65086: Select dedicated regulator config for chip variant

Arnd Bergmann (1):
      regulator: max77857: mark more functions static

Biju Das (6):
      regulator: raa215300: Change the scope of the variables {clkin_name, xin_name}
      regulator: raa215300: Fix resource leak in case of error
      regulator: raa215300: Add const definition
      regulator: raa215300: Change rate from 32000->32768
      regulator: raa215300: Add missing blank space
      regulator: raa215300: Update help description

Chen Jiahao (7):
      regulator: da9121-regulator: Remove redundant of_match_ptr() macros
      regulator: lp87565: Remove redundant of_match_ptr() macros
      regulator: hi6421: Remove redundant of_match_ptr() macros
      regulator: mcp16502: Remove redundant of_match_ptr() macros
      regulator: mpq7920: Remove redundant of_match_ptr() macro
      regulator: pfuze100-regulator: Remove redundant of_match_ptr() macro
      regulator: tps6286x-regulator: Remove redundant of_match_ptr() macros

Chen-Yu Tsai (1):
      regulator: Use bitfield values for range selectors

ChiYuan Huang (2):
      regulator: dt-bindings: rt5739: Add compatible for rt5733
      regulator: rt5739: Add DID check and compatible for rt5733

Christoph Niedermaier (1):
      regulator: da9062: Make the use of IRQ optional

Geert Uytterhoeven (1):
      regulator: REGULATOR_QCOM_REFGEN should depend on ARCH_QCOM

Konrad Dybcio (2):
      dt-bindings: regulator: Describe Qualcomm REFGEN regulator
      regulator: Introduce Qualcomm REFGEN regulator driver

Krzysztof Kozlowski (10):
      regulator: dt-bindings: mps,mpq7920: drop incorrect ref to regulator.yaml
      regulator: dt-bindings: dlg,da9121: add buck2 constraints
      regulator: dt-bindings: dlg,da9121: allow different names
      regulator: dt-bindings: active-semi,act8846: correct supplies
      regulator: dt-bindings: qcom,rpm: fix pattern for children
      regulator: dt-bindings: add missing unevaluatedProperties for each regulator
      regulator: dt-bindings: dlg,slg51000: Convert to DT schema
      regulator: ltc3589: Fix Wvoid-pointer-to-enum-cast warning
      regulator: max77857: Fix Wvoid-pointer-to-enum-cast warning
      regulator: lp872x: Fix Wvoid-pointer-to-enum-cast warning

Li Zetao (1):
      regulator: qcom_rpm-regulator: Use devm_kmemdup to replace devm_kmalloc + memcpy

Linus Walleij (10):
      regulator: tps65910: Drop useless header
      regulator: s2mpa01: Drop useless header
      regulator: rpi-panel-attiny: Drop useless header
      regulator: rc5t583: Drop useless header
      regulator: mt6311: Drop useless header
      regulator: mcp16502: Drop useless header
      regulator: max20086: Drop useless header
      regulator: lp8755: Drop useless header
      regulator: bd71828: Drop useless header
      regulator: bd71815: Drop useless header

Mark Brown (11):
      Qualcomm REFGEN regulator
      Add compatible support for RT5733
      Add regulators support for PMX75
      regulator: Merge up fixes from mainline
      regulator: Merge up fixes from Linus' tree
      Add Richtek RTQ2208 SubPMIC support
      regulator: Get Synquacer testing working
      trivial fixes for raa215300 driver
      regulator: Merge dependency for tps65086
      regulator: aw37503: add regulator driver for Awinic
      regulator: userspace-consumer: Drop event support for this cycle

Naresh Solanki (2):
      regulator: userspace-consumer: Add regulator event support
      regulator: max5970: Rename driver and remove wildcard

Neil Armstrong (1):
      dt-bindings: regulator: qcom,rpmh-regulator: allow i, j, l, m & n as RPMh resource name suffix

Okan Sahin (2):
      regulator: max77857: Add ADI MAX77857/59/MAX77831 Regulator Support
      regulator: max77857: Add ADI MAX77857/59/MAX77831 Regulator bindings

Rob Herring (1):
      regulator: Explicitly include correct DT includes

Rohit Agarwal (3):
      regulator: dt-bindings: qcom,rpmh: Update PMX65 entry
      regulator: dt-bindings: qcom,rpmh: Add PMX75 compatible
      regulator: qcom-rpmh: Add regulators support for PMX75

Ruan Jinjie (1):
      regulator: rpi-panel-attiny-regulator: Remove redundant of_match_ptr()

Uwe Kleine-König (5):
      regulator: raa215300: Switch back to use struct i2c_driver::probe
      regulator: max77857: Switch back to use struct i2c_driver's .probe()
      regulator: max8893: Drop "_new" from probe callback
      regulator: rtq2208: Switch back to use struct i2c_driver's .probe()
      regulator: aw37503: Switch back to use struct i2c_driver's .probe()

Yang Li (1):
      regulator: Remove duplicated include in mt6359-regulator.c

Yang Yingliang (2):
      regulator: max77857: change some variables to static
      regulator: max77857: fix build error in max77857-regulator.c

Yue Haibing (1):
      regulator: db8500-prcmu: Remove unused declaration power_state_active_is_enabled()

 .../bindings/regulator/active-semi,act8846.yaml    |  74 +--
 .../bindings/regulator/adi,max77857.yaml           |  86 +++
 .../bindings/regulator/awinic,aw37503.yaml         |  78 +++
 .../devicetree/bindings/regulator/dlg,da9121.yaml  |  22 +-
 .../bindings/regulator/dlg,slg51000.yaml           | 132 +++++
 .../devicetree/bindings/regulator/mps,mp5416.yaml  |   2 +
 .../devicetree/bindings/regulator/mps,mpq7920.yaml |   3 +-
 .../devicetree/bindings/regulator/pfuze100.yaml    |   4 +
 .../bindings/regulator/qcom,rpm-regulator.yaml     |   2 +-
 .../bindings/regulator/qcom,rpmh-regulator.yaml    |  26 +-
 .../regulator/qcom,sdm845-refgen-regulator.yaml    |  57 ++
 .../bindings/regulator/qcom,smd-rpm-regulator.yaml |   1 +
 .../regulator/richtek,rt4831-regulator.yaml        |   1 +
 .../bindings/regulator/richtek,rt5739.yaml         |   1 +
 .../regulator/richtek,rtmv20-regulator.yaml        |   1 +
 .../bindings/regulator/richtek,rtq2208.yaml        | 197 +++++++
 .../regulator/richtek,rtq6752-regulator.yaml       |   1 +
 .../devicetree/bindings/regulator/slg51000.txt     |  88 ----
 .../bindings/regulator/st,stm32mp1-pwr-reg.yaml    |   2 +-
 .../devicetree/bindings/regulator/wlf,arizona.yaml |   2 +
 MAINTAINERS                                        |   2 +-
 drivers/mfd/tps65086.c                             |  17 +-
 drivers/regulator/Kconfig                          |  53 +-
 drivers/regulator/Makefile                         |   6 +-
 drivers/regulator/act8945a-regulator.c             |   2 +-
 drivers/regulator/atc260x-regulator.c              |   7 +-
 drivers/regulator/aw37503-regulator.c              | 240 +++++++++
 drivers/regulator/axp20x-regulator.c               |   1 -
 drivers/regulator/bd71815-regulator.c              |   1 -
 drivers/regulator/bd71828-regulator.c              |   1 -
 drivers/regulator/bd718x7-regulator.c              |  22 +-
 drivers/regulator/cpcap-regulator.c                |   2 +-
 drivers/regulator/da9062-regulator.c               |  11 +-
 drivers/regulator/da9121-regulator.c               |  18 +-
 drivers/regulator/fan53555.c                       |   2 +-
 drivers/regulator/fixed.c                          |   1 -
 drivers/regulator/helpers.c                        |  15 +-
 drivers/regulator/hi6421-regulator.c               |  20 +-
 drivers/regulator/lp872x.c                         |   2 +-
 drivers/regulator/lp8755.c                         |   1 -
 drivers/regulator/lp87565-regulator.c              |   4 +-
 drivers/regulator/ltc3589.c                        |   4 +-
 drivers/regulator/max20086-regulator.c             |   1 -
 .../{max597x-regulator.c => max5970-regulator.c}   |  28 +-
 drivers/regulator/max77541-regulator.c             |   6 +-
 drivers/regulator/max77650-regulator.c             |   2 +-
 drivers/regulator/max77826-regulator.c             |   1 -
 drivers/regulator/max77857-regulator.c             | 461 ++++++++++++++++
 drivers/regulator/max8893.c                        |   4 +-
 drivers/regulator/mcp16502.c                       |   7 +-
 drivers/regulator/mp5416.c                         |   2 +-
 drivers/regulator/mp886x.c                         |   2 +-
 drivers/regulator/mpq7920.c                        |   3 +-
 drivers/regulator/mt6311-regulator.c               |   1 -
 drivers/regulator/mt6315-regulator.c               |   2 +-
 drivers/regulator/mt6359-regulator.c               |   2 +-
 drivers/regulator/mtk-dvfsrc-regulator.c           |   3 +-
 drivers/regulator/pbias-regulator.c                |   1 -
 drivers/regulator/pca9450-regulator.c              |   1 -
 drivers/regulator/pfuze100-regulator.c             |   3 +-
 drivers/regulator/pwm-regulator.c                  |   2 +-
 drivers/regulator/qcom-refgen-regulator.c          | 154 ++++++
 drivers/regulator/qcom-rpmh-regulator.c            |  39 +-
 drivers/regulator/qcom_rpm-regulator.c             |   3 +-
 drivers/regulator/qcom_smd-regulator.c             |   1 -
 drivers/regulator/qcom_usb_vbus-regulator.c        |   1 -
 drivers/regulator/raa215300.c                      |  38 +-
 drivers/regulator/rc5t583-regulator.c              |   1 -
 drivers/regulator/rk808-regulator.c                |   3 +-
 drivers/regulator/rohm-regulator.c                 |   2 +-
 drivers/regulator/rpi-panel-attiny-regulator.c     |   3 +-
 drivers/regulator/rt5739.c                         |  36 +-
 drivers/regulator/rt5759-regulator.c               |   2 +-
 drivers/regulator/rtq2208-regulator.c              | 583 +++++++++++++++++++++
 drivers/regulator/s2mpa01.c                        |   1 -
 drivers/regulator/stm32-pwr.c                      |   3 +-
 drivers/regulator/stm32-vrefbuf.c                  |   2 +-
 drivers/regulator/sy8824x.c                        |   2 +-
 drivers/regulator/sy8827n.c                        |   2 +-
 drivers/regulator/tps6286x-regulator.c             |   8 +-
 drivers/regulator/tps6287x-regulator.c             |   6 +-
 drivers/regulator/tps65086-regulator.c             | 188 ++++++-
 drivers/regulator/tps65218-regulator.c             |   2 +-
 drivers/regulator/tps65219-regulator.c             |   2 +-
 drivers/regulator/tps65910-regulator.c             |   1 -
 drivers/regulator/tps6594-regulator.c              |   2 +-
 drivers/regulator/twl-regulator.c                  |   1 -
 drivers/regulator/twl6030-regulator.c              |   1 -
 drivers/regulator/uniphier-regulator.c             |   2 +-
 drivers/regulator/vctrl-regulator.c                |   2 +-
 drivers/regulator/vexpress-regulator.c             |   3 +-
 include/linux/mfd/tps65086.h                       |  23 +-
 include/linux/regulator/db8500-prcmu.h             |   6 -
 include/linux/regulator/driver.h                   |  11 +-
 94 files changed, 2531 insertions(+), 347 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/adi,max77857.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/awinic,aw37503.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/dlg,slg51000.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/qcom,sdm845-refgen-regulator.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/richtek,rtq2208.yaml
 delete mode 100644 Documentation/devicetree/bindings/regulator/slg51000.txt
 create mode 100644 drivers/regulator/aw37503-regulator.c
 rename drivers/regulator/{max597x-regulator.c => max5970-regulator.c} (94%)
 create mode 100644 drivers/regulator/max77857-regulator.c
 create mode 100644 drivers/regulator/qcom-refgen-regulator.c
 create mode 100644 drivers/regulator/rtq2208-regulator.c
