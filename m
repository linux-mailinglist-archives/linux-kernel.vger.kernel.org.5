Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29790772996
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 17:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbjHGPos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 11:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjHGPop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 11:44:45 -0400
Received: from mx.skole.hr (mx1.hosting.skole.hr [161.53.165.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65674BD;
        Mon,  7 Aug 2023 08:44:43 -0700 (PDT)
Received: from mx1.hosting.skole.hr (localhost.localdomain [127.0.0.1])
        by mx.skole.hr (mx.skole.hr) with ESMTP id 12594839EF;
        Mon,  7 Aug 2023 17:44:41 +0200 (CEST)
From:   =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Subject: [PATCH v4 0/8] Initial Marvell PXA1908 support
Date:   Mon, 07 Aug 2023 17:42:34 +0200
Message-Id: <20230807-pxa1908-lkml-v4-0-cb387d73b452@skole.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAOoQ0WQC/32OyQ6CMBRFf8V0bcnrALSu/A/jgsBDKkNJqw2G8
 O8WEuOwcHluck7uTDw6g54cdjNxGIw3dogg9ztSNsVwQWqqyIQDF6BA0HEqmAZFu7bvaKYEoKo
 KmZY5icrosDbTljudIzfG36x7bPUg1vUVkt+hIChQhVLVZSFy0ProW9th0jiydgJ/uznPWcY16
 CQDwSij1f2KSW/iWxtM+SOyT5FxBiB5wlkq0n/msixPDE0ZcxoBAAA=
To:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-hardening@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        afaerber@suse.de,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5558;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=1EBQH+rSJaiRRzeOpOWQXCtK8UX9ffVXf/ZHzcbW8MI=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBk0REy+T93VQGSJh44hDsxiTGWufdoyXBh5bVhd
 a4g3NmI0NWJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZNERMgAKCRCaEZ6wQi2W
 4YubEACMf6gprC/hPRD3kdrILJlAVpCrwQnvfsytWX+M/28x/T1OccVqupKSxt2N6rt6GPUXsIk
 v2bwIzUXOjgvKOc5wUQbZB9pvX1HttNGNvWSlVwYuT7eFQnGA2kp/VuXe1YRXE2qM6qM84KXH8W
 b5+RZNUqlg6EQE+3+AtIPQBLBIx5Qp5rnA/6jnMlyMYuOQ/lRZ77p7kPOL4o9dxmPKZILkPcSTY
 0BQ3N9iaQOViPmdTUtFry3vhGUtLfFjrwHtk1Is4kuzzjRU1/PW8Ke9DeEU33uXwgzUnrAgE5Ft
 BTduYrSUl3YIp00OPH+THSxiVKaG9Fy/fx33Vw2X0sXTdTq6cH3P3YlhxnZqXcsrnhUAHCGymH2
 YWZplHog/j1lhBSbse6ITRHcUlPzebq8NlhllBh97PTQah6vIV8JuDTLOcdmCukcLleWwepApY9
 Ksc98gGsMGdaXSy91AneydycTFGtastRdGqy4SSExoVRlr5R5li2l59A7c3ixAIEgG03bSeFiZQ
 ijgyQFj7SbRLeB+tVPDe9FSGDkF4u4AwWK4BKhUka36ERs/mfMD9BYk63CRJ6Cm+wbFzH0H8N15
 A5jq20Bagl/vtam6WXcBkx5ZujKyV+eYwkSLcpQ2OzbrInE1mOCVNCUzS0P4Owjr+djqFceXqOO
 yDD/47P2v0q2IUw==
X-Developer-Key: i=duje.mihanovic@skole.hr; a=openpgp;
 fpr=53DF9D4D9C3FE110FB362D789A119EB0422D96E1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series adds initial support for the Marvell PXA1908 SoC and
"samsung,coreprimevelte", a smartphone using the SoC.

USB works and the phone can boot a rootfs from an SD card, but there are
some warnings in the dmesg:

During SMP initialization:
[    0.006519] CPU features: SANITY CHECK: Unexpected variation in SYS_CNTFRQ_EL0. Boot CPU: 0x000000018cba80, CPU1: 0x00000000000000
[    0.006542] CPU features: Unsupported CPU feature variation detected.
[    0.006589] CPU1: Booted secondary processor 0x0000000001 [0x410fd032]
[    0.010710] Detected VIPT I-cache on CPU2
[    0.010716] CPU features: SANITY CHECK: Unexpected variation in SYS_CNTFRQ_EL0. Boot CPU: 0x000000018cba80, CPU2: 0x00000000000000
[    0.010758] CPU2: Booted secondary processor 0x0000000002 [0x410fd032]
[    0.014849] Detected VIPT I-cache on CPU3
[    0.014855] CPU features: SANITY CHECK: Unexpected variation in SYS_CNTFRQ_EL0. Boot CPU: 0x000000018cba80, CPU3: 0x00000000000000
[    0.014895] CPU3: Booted secondary processor 0x0000000003 [0x410fd032]

SMMU probing fails:
[    0.101798] arm-smmu c0010000.iommu: probing hardware configuration...
[    0.101809] arm-smmu c0010000.iommu: SMMUv1 with:
[    0.101816] arm-smmu c0010000.iommu:         no translation support!

On Samsung's PXA1908 phones, the bootloader does not start the ARM
system timer, and my temporary solution (which isn't present in this
series) was to put the code for starting the timer in the clock driver.
Would this hack be accepted upstream in the form of a platform or
clocksource driver such as drivers/clocksource/timer-mediatek-cpux.c?

A 3.14 based Marvell tree is available on GitHub
acorn-marvell/brillo_pxa_kernel, and a Samsung one on GitHub
CoderCharmander/g361f-kernel.

Andreas Färber attempted to upstream support for this SoC in 2017:
https://lore.kernel.org/lkml/20170222022929.10540-1-afaerber@suse.de/

Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
---
Changes in v4:
- Address maintainer comments:
  - Relicense clock binding file to BSD-2
- Add pinctrl-names to SD card node
- Add vgic registers to GIC node
- Rebase on v6.5-rc5
- Link to v3: https://lore.kernel.org/r/20230804-pxa1908-lkml-v3-0-8e48fca37099@skole.hr

Changes in v3:
- Address maintainer comments:
  - Drop GPIO dynamic allocation patch
  - Move clock register offsets into driver (instead of bindings file)
  - Add missing Tested-by trailer to u32_fract patch
  - Move SoC binding to arm/mrvl/mrvl.yaml
- Add serial0 alias and stdout-path to board dts to enable UART
  debugging
- Rebase on v6.5-rc4
- Link to v2: https://lore.kernel.org/r/20230727162909.6031-1-duje.mihanovic@skole.hr

Changes in v2:
- Remove earlycon patch as it's been merged into tty-next
- Address maintainer comments:
  - Clarify GPIO regressions on older PXA platforms
  - Add Fixes tag to commit disabling GPIO pinctrl calls for this SoC
  - Add missing includes to clock driver
  - Clock driver uses HZ_PER_MHZ, u32_fract and GENMASK
  - Dual license clock bindings
  - Change clock IDs to decimal
  - Fix underscores in dt node names
  - Move chosen node to top of board dts
  - Clean up documentation
  - Reorder commits
  - Drop pxa,rev-id
- Rename muic-i2c to i2c-muic
- Reword some commits
- Move framebuffer node to chosen
- Add aliases for mmc nodes
- Rebase on v6.5-rc3
- Link to v1: https://lore.kernel.org/r/20230721210042.21535-1-duje.mihanovic@skole.hr

---
Andy Shevchenko (1):
      clk: mmp: Switch to use struct u32_fract instead of custom one

Duje Mihanović (7):
      gpio: pxa: disable pinctrl calls for MMP_GPIO
      dt-bindings: clock: Add Marvell PXA1908 clock bindings
      clk: mmp: Add Marvell PXA1908 clock driver
      dt-bindings: marvell: Document PXA1908 SoC
      arm64: Kconfig.platforms: Add config for Marvell PXA1908 platform
      arm64: dts: Add DTS for Marvell PXA1908 and samsung,coreprimevelte
      MAINTAINERS: add myself as Marvell PXA1908 maintainer

 .../devicetree/bindings/arm/mrvl/mrvl.yaml         |   5 +
 .../devicetree/bindings/clock/marvell,pxa1908.yaml |  48 +++
 MAINTAINERS                                        |   9 +
 arch/arm64/Kconfig.platforms                       |  11 +
 arch/arm64/boot/dts/marvell/Makefile               |   3 +
 .../dts/marvell/pxa1908-samsung-coreprimevelte.dts | 333 +++++++++++++++++++++
 arch/arm64/boot/dts/marvell/pxa1908.dtsi           | 295 ++++++++++++++++++
 drivers/clk/mmp/Makefile                           |   2 +-
 drivers/clk/mmp/clk-frac.c                         |  57 ++--
 drivers/clk/mmp/clk-mmp2.c                         |   6 +-
 drivers/clk/mmp/clk-of-mmp2.c                      |  26 +-
 drivers/clk/mmp/clk-of-pxa168.c                    |   4 +-
 drivers/clk/mmp/clk-of-pxa1908.c                   | 323 ++++++++++++++++++++
 drivers/clk/mmp/clk-of-pxa1928.c                   |   6 +-
 drivers/clk/mmp/clk-of-pxa910.c                    |   4 +-
 drivers/clk/mmp/clk-pxa168.c                       |   4 +-
 drivers/clk/mmp/clk-pxa910.c                       |   4 +-
 drivers/clk/mmp/clk.h                              |  10 +-
 drivers/gpio/gpio-pxa.c                            |   1 +
 include/dt-bindings/clock/marvell,pxa1908.h        |  92 ++++++
 20 files changed, 1179 insertions(+), 64 deletions(-)
---
base-commit: 52a93d39b17dc7eb98b6aa3edb93943248e03b2f
change-id: 20230803-pxa1908-lkml-6830e8da45c7

Best regards,
-- 
Duje Mihanović <duje.mihanovic@skole.hr>


