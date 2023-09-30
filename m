Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEEE47B43EE
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 23:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234046AbjI3V1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 17:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233997AbjI3V1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 17:27:36 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81385DD
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 14:27:31 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id BA0655C0328;
        Sat, 30 Sep 2023 17:27:27 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Sat, 30 Sep 2023 17:27:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:message-id:mime-version:reply-to
        :sender:subject:subject:to:to; s=fm1; t=1696109247; x=
        1696195647; bh=dtw0Eyy0R17VRbDGyjwG9+ncVoMk4C4upzNIEMsL+vs=; b=G
        NUo+YHhJVvkn+71q5hspf5TdF09u56WjWYmTVi8OqeYNgV5Wze2QSH2jgmKMxDTm
        0Z7k+/3TpZAnllgc0yDo66udItX8LFX5+zdHHcFTWrCdKRTjRdBDVhtu+0F8lnhd
        nYE06N5lJri8wpMVCsBsXR1CL9OTD+J7zRzIPp+aSlp4/5cWR5eYNtlvfVue57X6
        +u5wspp51DWk4TNw0xZPcRIwDdPZ177C3V6lnH79BYzjNlB3sWL6IBiA4ixopxjz
        KGluLmh6l8LlwN/iPp3MaSXBE3F3L0tLvE390nmjrz39IecfiFZmX1uJEdOwhfSt
        ipprRuNc0GF8tSFqPYrrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1696109247; x=1696195647; bh=d
        tw0Eyy0R17VRbDGyjwG9+ncVoMk4C4upzNIEMsL+vs=; b=o21p83bAe8Luf3TVf
        WD/gVzWzBdt88dVZuekyzXpVjB7NQig1U+r0S2m2JA21C38tGhvzryOuPhx1Wpjr
        dybbjOskxV+cTAttZccthb47d3ipenJDLXD3KYU+WMedTBsC9fOx7agqpovh6QMN
        aOlpEJBjQZyRdAMlYhcrIcC/B/P5c6RdKwNuyNvQkeqTDBJjju56j+KQhD/VcTDD
        jQfKLLkm8gyQMB97G8+f+J0knY8RJ/HdQHf0/9pI2IST17LeuX1gycK2l+ACR9FS
        FmMNocoh4vlhRNLgiTTfEOUlLbcic50s0Fj56X/CKosSatn5FQc1uCRuc+WsLWvR
        9Wt2Q==
X-ME-Sender: <xms:v5IYZSC24DojVQ3qHBJx6yfvoPqp_F6nZO86pOzcU_Tfutd5yRGd7w>
    <xme:v5IYZchnxOIWMCji1Wi9p3zCmXSl3GH5obKQppY20DJ0s1gvBVtoGn5ywZHkkDt2v
    PFBXq0vopsWJD-UjPE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudefgdefhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepleekveevheekffdtiedthfeiffeugfdtgfetffffteejtdfgfeevheegtedvveeg
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghdplhhinhgrrhhordhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhn
    uggsrdguvg
X-ME-Proxy: <xmx:v5IYZVk4nhYXBbPch0B3OeWgkG_xqEbQJIvvEYs5QAVYoAaRtPUYzg>
    <xmx:v5IYZQxg7Szy9Z-EF_MrR39CtfB3KPhJorEZyj8OKIxfkHhBDE_fDw>
    <xmx:v5IYZXRxsJTH0-JSlzPH7GsnvD38KzlwOnqdRagEfmk_6yjaVWUSiA>
    <xmx:v5IYZeLgU6oe4X0vrdAynJLn2eGnWITOqxpdKd9XTBcN6ADOnzq-FA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 3BECAB6008F; Sat, 30 Sep 2023 17:27:27 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-958-g1b1b911df8-fm-20230927.002-g1b1b911d
MIME-Version: 1.0
Message-Id: <6425892a-8503-4f70-be45-e545cda59854@app.fastmail.com>
Date:   Sat, 30 Sep 2023 17:26:59 -0400
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] ARM: SoC fixes for 6.6
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917=
d1d:

  Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-f=
ixes-6.6

for you to fetch changes up to b0b88a585c27834223d2daf47faa57ca06dd9414:

  MAINTAINERS: Fix Florian Fainelli's email address (2023-09-29 17:49:18=
 -0400)

----------------------------------------------------------------
ARM: SoC fixes for 6.6

These are teh latest bug fixes that have come up in the soc tree.
Most of these are fairly minor. Most notably, the majority of
changes this time are not for dts files as usual.

 - Updates to the addresses of the broadcom and aspeed entries in the
   MAINTAINERS file.

 - Defconfig updates to address a regression on samsung and a build
   warning from an unknown Kconfig symbol

 - Build fixes for the StrongARM and Uniphier platforms

 - Code fixes for SCMI and FF-A firmware drivers, both of which had
   a simple bug that resulted in invalid data, and a lesser fix for
   the optee firmware driver

 - Multiple fixes for the recently added loongson/loongarch "guts"
   soc driver

 - Devicetree fixes for RISC-V on the startfive platform, addressing
   issues with NOR flash, usb and uart.

 - Multiple fixes for NXP i.MX8/i.MX9 dts files, fixing problems
   with clock, gpio, hdmi settings and the Makefile

 - Bug fixes for i.MX firmware code and the OCOTP soc driver

 - Multiple fixes for the TI sysc bus driver

 - Minor dts updates for TI omap dts files, to address boot
   time warnings and errors

----------------------------------------------------------------
Adam Ford (3):
      bus: ti-sysc: Fix missing AM35xx SoC matching
      arm64: dts: imx8mp: Fix SDMA2/3 clocks
      arm64: dts: imx8mp-beacon-kit: Fix audio_pll2 clock

Alexander Stein (1):
      arm64: dts: freescale: tqma9352: Fix gpio hog

Andrew Jeffery (1):
      MAINTAINERS: aspeed: Update Andrew's email address

Arnd Bergmann (8):
      Merge tag 'omap-for-v6.6/fixes-signed' of git://git.kernel.org/pub=
/scm/linux/kernel/git/tmlind/linux-omap into arm/fixes
      Merge tag 'imx-fixes-6.6' of git://git.kernel.org/pub/scm/linux/ke=
rnel/git/shawnguo/linux into arm/fixes
      Merge tag 'riscv-dt-fixes-for-v6.6-rc3' of https://git.kernel.org/=
pub/scm/linux/kernel/git/conor/linux into arm/fixes
      Merge tag 'optee-for-for-v6.6' of https://git.linaro.org/people/je=
ns.wiklander/linux-tee into arm/fixes
      Merge tag 'aspeed-6.6-maintainers' of git://git.kernel.org/pub/scm=
/linux/kernel/git/joel/bmc into arm/fixes
      Merge tag 'ffa-fix-6.6' of git://git.kernel.org/pub/scm/linux/kern=
el/git/sudeep.holla/linux into arm/fixes
      Merge tag 'scmi-fix-6.6' of git://git.kernel.org/pub/scm/linux/ker=
nel/git/sudeep.holla/linux into arm/fixes
      ARM: locomo: fix locomolcd_power declaration

Aurelien Jarno (1):
      riscv: dts: starfive: fix NOR flash reserved-data partition size

Binbin Zhou (5):
      soc: loongson: loongson_pm2: Add dependency for INPUT
      dt-bindings: soc: loongson,ls2k-pmc: Use fallbacks for ls2k-pmc co=
mpatible
      soc: loongson: loongson_pm2: Drop useless of_device_id compatible
      dt-bindings: soc: loongson,ls2k-pmc: Allow syscon-reboot/syscon-po=
weroff as child
      soc: loongson: loongson_pm2: Populate children syscon nodes

Christophe JAILLET (1):
      firmware: imx-dsp: Fix an error handling path in imx_dsp_setup_cha=
nnels()

Dongliang Mu (1):
      soc: loongson: loongson2_guts: Convert to devm_platform_ioremap_re=
source()

Hal Feng (2):
      riscv: dts: starfive: visionfive 2: Enable usb0
      riscv: dts: starfive: visionfive 2: Fix uart0 pins sort order

Julien Panis (1):
      bus: ti-sysc: Use fsleep() instead of usleep_range() in sysc_reset=
()

Krzysztof Kozlowski (1):
      arm64: defconfig: enable syscon-poweroff driver

Liu Ying (1):
      arm64: dts: imx8mm-evk: Fix hdmi@3d node

Mikko Rapeli (1):
      arm64: defconfig: remove CONFIG_COMMON_CLK_NPCM8XX=3Dy

Mingtong Bao (1):
      soc: loongson: loongson2_guts: Remove unneeded semicolon

Nathan Rossi (1):
      soc: imx8m: Enable OCOTP clock for imx8mm before reading registers

Randy Dunlap (1):
      ARM: uniphier: fix cache kernel-doc warnings

Rob Herring (2):
      arm64: dts: mediatek: Fix "mediatek,merge-mute" and "mediatek,merg=
e-fifo-en" types
      arm64: dts: imx: Add imx8mm-prt8mm.dtb to build

Sibi Sankar (1):
      firmware: arm_scmi: Fixup perf power-cost/microwatt support

Sudeep Holla (1):
      firmware: arm_ffa: Don't set the memory region attributes for MEM_=
LEND

Tony Lindgren (6):
      ARM: dts: ti: omap: Fix bandgap thermal cells addressing for omap3=
/4
      ARM: dts: ti: omap: motorola-mapphone: Fix abe_clkctrl warning on =
boot
      ARM: dts: ti: omap: Fix noisy serial with overrun-throttle-ms for =
mapphone
      ARM: omap2+: Downgrade u-boot version warnings to debug statements
      bus: ti-sysc: Fix SYSC_QUIRK_SWSUP_SIDLE_ACT handling for uart wak=
e-up
      Merge branches 'fixes-mapphone' and 'fixes-ti-sysc' into fixes

Uwe Kleine-K=C3=B6nig (1):
      MAINTAINERS: Fix Florian Fainelli's email address

Yue Haibing (1):
      tee: Remove unused declarations

Zev Weiss (1):
      MAINTAINERS: aspeed: Update git tree URL

 .../bindings/soc/loongson/loongson,ls2k-pmc.yaml   | 43 +++++++++++++++=
---
 MAINTAINERS                                        | 10 ++---
 .../boot/dts/ti/omap/motorola-mapphone-common.dtsi |  5 ++-
 arch/arm/boot/dts/ti/omap/omap3-cpu-thermal.dtsi   |  3 +-
 arch/arm/boot/dts/ti/omap/omap4-cpu-thermal.dtsi   |  5 ++-
 arch/arm/boot/dts/ti/omap/omap443x.dtsi            |  1 +
 arch/arm/boot/dts/ti/omap/omap4460.dtsi            |  1 +
 arch/arm/include/asm/hardware/locomo.h             |  2 +-
 arch/arm/mach-omap2/pm44xx.c                       |  4 +-
 arch/arm/mach-sa1100/include/mach/collie.h         |  2 -
 arch/arm/mm/cache-uniphier.c                       |  4 +-
 arch/arm64/boot/dts/freescale/Makefile             |  1 +
 arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi      | 32 +++++++++-----
 .../arm64/boot/dts/freescale/imx8mp-beacon-kit.dts |  5 ++-
 arch/arm64/boot/dts/freescale/imx8mp.dtsi          |  6 +++
 arch/arm64/boot/dts/freescale/imx93-tqma9352.dtsi  |  2 +-
 arch/arm64/boot/dts/mediatek/mt8195.dtsi           | 10 ++---
 arch/arm64/configs/defconfig                       |  2 +-
 .../dts/starfive/jh7110-starfive-visionfive-2.dtsi | 51 +++++++++++----=
-------
 drivers/bus/ti-sysc.c                              | 31 +++++++++----
 drivers/firmware/arm_ffa/driver.c                  | 16 ++++++-
 drivers/firmware/arm_scmi/perf.c                   |  4 +-
 drivers/firmware/imx/imx-dsp.c                     |  1 +
 drivers/soc/imx/soc-imx8m.c                        | 10 +++++
 drivers/soc/loongson/Kconfig                       |  1 +
 drivers/soc/loongson/loongson2_guts.c              |  6 +--
 drivers/soc/loongson/loongson2_pm.c                |  7 ++-
 drivers/tee/optee/optee_private.h                  |  2 -
 drivers/tee/tee_private.h                          |  2 -
 29 files changed, 179 insertions(+), 90 deletions(-)
