Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9927DE90D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 00:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347257AbjKAXhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 19:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345420AbjKAXhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 19:37:04 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1159DC2
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 16:36:57 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 7B6625C01A3;
        Wed,  1 Nov 2023 19:36:56 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 01 Nov 2023 19:36:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1698881816; x=1698968216; bh=kHeMzE0Mys+MLEvvsgXfL2dbLYyUTkuayMR
        FxpP5YGY=; b=E12fpSXhyN4JY3QDCUHlP1YCEt6jN3EbdznZbNVEhcYSKnVZiDv
        P2m6Et7JJJFckBZeIMBya2oP42opNCK7h/carpgPVG7KJmV3wAkr2V8QeXTb4Oh5
        vZqRgu1+DvJjouViizuIc+Gg2S53uImqdyVzFozlqHC8JQs3nBEMJo606+L3QO6a
        bcyLRUHwi32X1PzVprQ/Z4msiVnjAiyKtowBrtyESt6Zmx9WDwgwVq7qlHvgUbD3
        ynaaJh9UZuI8BTxrOphEdhdR2nP4lQB2wU2z0ZApLlBTH/zRd2VpUULVv1EstcGW
        4bQUWRKGNXy36bRrIc4FONjGt8XnjjhMS+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1698881816; x=1698968216; bh=kHeMzE0Mys+MLEvvsgXfL2dbLYyUTkuayMR
        FxpP5YGY=; b=WpaDrjxACyVSFDrK/SRZyrkotPRcufcM3i+gFifL4+XWPQswrns
        qdh29/RRJt/rAh/3RwxESrwUFwnW3vFKdo5hDG0xrugnsX9QqoMEafaYRyu/2NEJ
        E5SdrqJy3Lr7mjVoIW0LApL8taG0H1uo8duNQVPODrhkoMyrUGoXOkVb81/NNZAY
        acasRJtAR4CGR15a/hmRKBjU5e6MftYr40i/bxHpMk2u4Gr6L3dcw4GCm+HsoW/A
        6ma2wdmI79jTDZmrss9jPwVeouPmmCJyeI+VDVEKbtWmrhPmmR1VDE7uP9cWwzjK
        xgcw8YyXQdSFZCa41kgmyw9Ocsv71+L7EXA==
X-ME-Sender: <xms:F-FCZbF5qxLMO9WrY2mop61qf-6VgzNoia3f6EM2YBDZUWMwDtdHhg>
    <xme:F-FCZYXyefdPZ4K9FVuycPu_C6FC0CBvl1vVv67WpMPYbBbrAmtRTdbHUxa3TX_rx
    w5Dv3LTJpbgqpwKNf8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddthedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpefgkefhheetvdethfejkeeigfehtdffieevfeefteffteejffehlefhtdeu
    veejueenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgihhthhhusgdrtghomhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnuges
    rghrnhgusgdruggv
X-ME-Proxy: <xmx:GOFCZdIYzM5yEUkFzQhdg8tbJs4sFQxwxYBBLk2vqf_RgDGm2dtkaA>
    <xmx:GOFCZZGprq2xfy6qeq4NqpKOV8xqBvsUQK9RAYoUUI2mlBS9Jy7E2g>
    <xmx:GOFCZRU9piuNDkfUdcHxBuV7KNq26U0i_6yz_B10zmePgwXkdJcAng>
    <xmx:GOFCZQf2IIsaEyRYmY0ntkmwzzv9vy-0GIMYkVWbA-pycCdX0EjUbw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id E3BD3B60089; Wed,  1 Nov 2023 19:36:55 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1108-g3a29173c6d-fm-20231031.005-g3a29173c
MIME-Version: 1.0
Message-Id: <96986a4b-b9d5-4fdb-bfa6-1d75ec31ade6@app.fastmail.com>
In-Reply-To: <263c2cf0-c35a-4d3c-85b3-fcb692cbfd40@app.fastmail.com>
References: <263c2cf0-c35a-4d3c-85b3-fcb692cbfd40@app.fastmail.com>
Date:   Thu, 02 Nov 2023 00:36:34 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL 1/4] SoC DT updates for v6.7
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 6465e260f48790807eef06b583b38ca9789b6=
072:

  Linux 6.6-rc3 (2023-09-24 14:31:13 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-d=
t-6.7

for you to fetch changes up to c505e1e4b10d751e93ca361d56d2270d6180a183:

  Merge tag 'v6.7-rockchip-dts64-2' of git://git.kernel.org/pub/scm/linu=
x/kernel/git/mmind/linux-rockchip into soc/dt (2023-10-25 23:11:54 +0200)

----------------------------------------------------------------
SoC DT updates for v6.7

There are a couple new SoCs that are supported for the first time:

 - AMD Pensando Elba is a data processing unit based on Cortex-A72
   CPU cores

 - Sophgo makes RISC-V based chips, and we now support the CV1800B
   chip used in the milkv-duo board and the massive sg2042 chip in the
   milkv-pioneer, a 64-core developer workstation.

 - Qualcomm Snapdragon 720G (sm7125) is a close relative of
   Snapdragon 7c and gets added with some Xiaomi phones

 - Renesas gains support for the R8A779F4 (R-Car S4-8) automotive
   SoC and the RZ/G3S (R9A08G045) embedded SoC.

There are also a bunch of newly supported machines that use
already supported chips. On the 32-bit side, we have:

 - USRobotics USR8200 is a NAS/Firewall/router based on the ancient
   Intel IXP4xx platform

 - A couple of machines based on the NXP i.MX5 and i.MX6 platforms

 - One machine each for Allwinner V3s, Aspeed AST2600, Microchip
   sama5d29 and ST STM32mp157

The other ones all use arm64 cores on chips from allwinner,
amlogic, freescale, mediatek, qualcomm and rockchip.

----------------------------------------------------------------

The branch contains a few clk driver commits that are already
merged for 6.7. For brevity, I left out the full diffstat,
here is a dirstat and slightly truncated shortlog:

   0.0% Documentation/devicetree/bindings/arm/aspeed/
   0.0% Documentation/devicetree/bindings/arm/stm32/
   1.4% Documentation/devicetree/bindings/arm/tegra/
   0.6% Documentation/devicetree/bindings/arm/
   0.0% Documentation/devicetree/bindings/clock/
   0.1% Documentation/devicetree/bindings/interrupt-controller/
   0.0% Documentation/devicetree/bindings/nvmem/
   0.0% Documentation/devicetree/bindings/power/
   0.0% Documentation/devicetree/bindings/pwm/
   0.0% Documentation/devicetree/bindings/riscv/
   0.1% Documentation/devicetree/bindings/soc/renesas/
   0.1% Documentation/devicetree/bindings/soc/sti/
   1.5% Documentation/devicetree/bindings/soc/tegra/
   0.1% Documentation/devicetree/bindings/timer/
   0.0% Documentation/devicetree/bindings/
   0.6% arch/arm/boot/dts/allwinner/
   1.3% arch/arm/boot/dts/aspeed/
   0.4% arch/arm/boot/dts/broadcom/
   0.6% arch/arm/boot/dts/intel/ixp/
   0.2% arch/arm/boot/dts/mediatek/
   1.2% arch/arm/boot/dts/microchip/
   0.0% arch/arm/boot/dts/nuvoton/
   0.0% arch/arm/boot/dts/nvidia/
   3.0% arch/arm/boot/dts/nxp/imx/
   0.1% arch/arm/boot/dts/nxp/mxs/
   0.0% arch/arm/boot/dts/nxp/vf/
   0.7% arch/arm/boot/dts/qcom/
   0.4% arch/arm/boot/dts/renesas/
   0.2% arch/arm/boot/dts/rockchip/
   0.7% arch/arm/boot/dts/samsung/
   1.5% arch/arm/boot/dts/st/
   0.5% arch/arm/boot/dts/ti/omap/
   0.4% arch/arm64/boot/dts/allwinner/
   1.2% arch/arm64/boot/dts/amd/
   4.3% arch/arm64/boot/dts/amlogic/
   0.0% arch/arm64/boot/dts/apm/
   0.0% arch/arm64/boot/dts/bitmain/
   0.0% arch/arm64/boot/dts/broadcom/northstar2/
   0.3% arch/arm64/boot/dts/exynos/
   9.1% arch/arm64/boot/dts/freescale/
   0.1% arch/arm64/boot/dts/marvell/
   4.8% arch/arm64/boot/dts/mediatek/
   0.6% arch/arm64/boot/dts/nvidia/
  15.2% arch/arm64/boot/dts/qcom/
   3.9% arch/arm64/boot/dts/renesas/
   9.0% arch/arm64/boot/dts/rockchip/
   0.0% arch/arm64/boot/dts/socionext/
   0.2% arch/arm64/boot/dts/st/
  13.4% arch/arm64/boot/dts/ti/
   0.3% arch/riscv/boot/dts/allwinner/
   0.0% arch/riscv/boot/dts/microchip/
   0.1% arch/riscv/boot/dts/renesas/
   0.1% arch/riscv/boot/dts/sifive/
   6.5% arch/riscv/boot/dts/sophgo/
   0.6% arch/riscv/boot/dts/starfive/
   0.0% arch/riscv/boot/dts/thead/
   0.0% arch/riscv/boot/dts/
   0.0% arch/riscv/configs/
   0.0% arch/riscv/
  10.3% drivers/clk/qcom/
   0.0% drivers/clk/sprd/
   0.0% drivers/clk/tegra/
   0.0% drivers/clk/
   0.0% drivers/firmware/imx/
   0.0% drivers/soc/imx/
   1.5% include/dt-bindings/clock/
   0.2% include/dt-bindings/power/

Adam Ford (14):
      arm64: dts: imx8mp: Fix SDMA2/3 clocks
      arm64: dts: imx8mp-beacon-kit: Fix audio_pll2 clock
      arm64: dts: imx8mp: Add easrc node
      arm64: dts: imx8mp: Add micfil node
      ARM: dts: am3517-evm: Fix LED3/4 pinmux
      ARM: dts: am3517-evm: Enable Ethernet PHY Interrupt
      ARM: dts: am3517: Configure ethernet alias
      arm64: dts: imx8mm: Add sound-dai-cells to micfil node
      arm64: dts: imx8mn: Add sound-dai-cells to micfil node
      arm64: dts: imx8mp-beacon: Configure 100MHz PCIe Ref Clk
      arm64: dts: imx8mm-beacon: Migrate sound card to simple-audio-card

Adam Skladowski (2):
      arm64: dts: qcom: msm8976: Split lpass region
      arm64: dts: qcom: msm8976: Fix ipc bit shifts

Alain Volmat (5):
      ARM: dts: st: correct serial alias in stih418-b2264.dts
      ARM: dts: st: move leds out of soc in stih418-b2264.dts
      ARM: dts: st: correct led level in stih418-b2264.dts
      dt-bindings: soc: sti: add STi platform syscon
      dt-bindings: arm: sti: add STi boards and remove stih415/stih416

Alex Bee (4):
      ARM: dts: rockchip: Add SRAM node for RK3128
      ARM: dts: rockchip: Add CPU resets for RK3128
      ARM: dts: rockchip: Enable SMP bring-up for RK3128
      ARM: dts: rockchip: Switch to operating-points-v2 for RK3128's CPU

Alexander Stein (10):
      arm64: dts: meson-g12: Fix clock order for amlogic,axg-tdm-iface d=
evices
      arm64: dts: meson-g12: Fix compatible for amlogic,g12a-tdmin
      arm64: dts: imx8qxp: add adma_pwm in adma
      arm64: dts: freescale: tqma9352: Fix gpio hog
      ARM: dts: imx6ul: mba6ulx: Mark gpio-buttons as wakeup-source
      ARM: dts: imx6ul: mba6ulx: Fix gpio-keys button node names
      arm64: dts: mba8mx: Add DSI-LVDS bridge nodes
      arm64: dts: imx8mm-tqma8mqml-mba8mx: Add LVDS overlay
      arm64: dts: imx8mn-tqma8mqnl-mba8mx: Add LVDS overlay
      arm64: dts: imx8mq-tqma8mq-mba8mx: Add LVDS overlay

Alexandre Mergnat (7):
      arm64: dts: mediatek: add mmsys support for mt8365 SoC
      arm64: dts: mediatek: add camsys support for mt8365 SoC
      arm64: dts: mediatek: add apu support for mt8365 SoC
      arm64: dts: mediatek: add power domain support for mt8365 SoC
      arm64: dts: mediatek: add smi support for mt8365 SoC
      arm64: dts: mediatek: add larb support for mt8365 SoC
      arm64: dts: mediatek: add iommu support for mt8365 SoC

Alexandre Torgue (2):
      arm64: dts: st: add arm-wdt node for watchdog support on stm32mp251
      arm64: dts: st: enable secure arm-wdt watchdog on stm32mp257f-ev1

Alexey Minnekhanov (1):
      arm64: dts: qcom: sdm630: Add support for modem remoteproc

Alexey Romanov (4):
      arm64: dts: meson: a1: enable efuse controller and setup its clk
      arm64: dts: meson: a1: add hw rng node
      arm64: dts: meson: a1: add ao secure node
      arm64: dts: meson-s4: add hwrng node

Andreas Kemnade (4):
      ARM: dts: omap4: embt2ws: add LED
      ARM: dts: omap: omap4-embt2ws: Let IMU driver handle Magnetometer =
internally
      ARM: dts: omap: omap4-embt2ws: Add IMU at control unit
      ARM: dts: omap3-gta04: Drop superfluous omap36xx compatible

Andrei Simion (1):
      dt-bindings: ARM: at91: Document Microchip SAMA5D29 Curiosity

Andrew Halaney (2):
      arm64: dts: qcom: sa8775p-ride: Describe sgmii_phy0 irq
      arm64: dts: qcom: sa8775p-ride: Describe sgmii_phy1 irq

Andr=C3=A9 Apitzsch (2):
      dt-bindings: arm: qcom: Add BQ Aquaris M5
      arm64: dts: qcom: msm8939-longcheer-l9100: Add initial device tree

AngeloGioacchino Del Regno (4):
      arm64: dts: mediatek: mt6795: Add support for display blocks and D=
PI/DSI
      arm64: dts: mediatek: mt6795-xperia-m5: Add display backlight supp=
ort
      arm64: dts: mediatek: mt6795-xperia-m5: Add DSI Display and its vr=
egs
      arm64: dts: mediatek: cherry: Configure eDP and internal display

Apurva Nandan (9):
      arm64: dts: ti: k3-j721s2-mcu: Add MCU R5F cluster nodes
      arm64: dts: ti: k3-j721s2-main: Add MAIN R5F remote processsor nod=
es
      arm64: dts: ti: k3-j721s2-main: Add C7x remote processsor nodes
      arm64: dts: ti: k3-j721s2-som-p0: Add DDR carveout memory nodes fo=
r R5F
      arm64: dts: ti: k3-j721s2-som-p0: Add DDR carveout memory nodes fo=
r C71x DSPs
      arm64: dts: ti: k3-am68-sk-som: Add DDR carveout memory nodes for =
R5F
      arm64: dts: ti: k3-am68-sk-som: Add DDR carveout memory nodes for =
C71x DSP
      arm64: dts: ti: k3-am69-sk: Add DDR carveout memory nodes for R5F
      arm64: dts: ti: k3-am69-sk: Add DDR carveout memory nodes for C71x=
 DSP

Aradhya Bhatia (1):
      arm64: dts: ti: Fix HDMI Audio overlay in Makefile

Arnd Bergmann (37):
      Merge tag 'ux500-dts-for-armsoc' of git://git.kernel.org/pub/scm/l=
inux/kernel/git/linusw/linux-nomadik into soc/dt
      Merge tag 'renesas-dt-bindings-for-v6.7-tag1' of git://git.kernel.=
org/pub/scm/linux/kernel/git/geert/renesas-devel into soc/dt
      Merge tag 'renesas-dts-for-v6.7-tag1' of git://git.kernel.org/pub/=
scm/linux/kernel/git/geert/renesas-devel into soc/dt
      Merge tag 'dt64-cleanup-6.7' of https://git.kernel.org/pub/scm/lin=
ux/kernel/git/krzk/linux-dt into soc/dt
      Merge tag 'dt-cleanup-6.7' of https://git.kernel.org/pub/scm/linux=
/kernel/git/krzk/linux-dt into soc/dt
      Merge tag 'samsung-dt64-6.7' of https://git.kernel.org/pub/scm/lin=
ux/kernel/git/krzk/linux into soc/dt
      Merge tag 'samsung-dt-6.7' of https://git.kernel.org/pub/scm/linux=
/kernel/git/krzk/linux into soc/dt
      Merge tag 'ixp4xx-for-soc-v6.7' of git://git.kernel.org/pub/scm/li=
nux/kernel/git/linusw/linux-nomadik into soc/dt
      Merge tag 'at91-dt-6.7' of https://git.kernel.org/pub/scm/linux/ke=
rnel/git/at91/linux into soc/dt
      Merge tag 'omap-for-v6.7/dt-signed' of git://git.kernel.org/pub/sc=
m/linux/kernel/git/tmlind/linux-omap into soc/dt
      Merge tag 'sti-dt-for-v6.7-round1' of git://git.kernel.org/pub/scm=
/linux/kernel/git/pchotard/sti into soc/dt
      Merge tag 'renesas-dt-bindings-for-v6.7-tag2' of git://git.kernel.=
org/pub/scm/linux/kernel/git/geert/renesas-devel into soc/dt
      Merge tag 'renesas-dts-for-v6.7-tag2' of git://git.kernel.org/pub/=
scm/linux/kernel/git/geert/renesas-devel into soc/dt
      Merge tag 'tegra-for-6.7-dt-bindings' of git://git.kernel.org/pub/=
scm/linux/kernel/git/tegra/linux into soc/dt
      Merge tag 'tegra-for-6.7-arm-dt' of git://git.kernel.org/pub/scm/l=
inux/kernel/git/tegra/linux into soc/dt
      Merge tag 'tegra-for-6.7-arm64-dt' of git://git.kernel.org/pub/scm=
/linux/kernel/git/tegra/linux into soc/dt
      Merge tag 'sunxi-dt-for-6.7-1' of https://git.kernel.org/pub/scm/l=
inux/kernel/git/sunxi/linux into soc/dt
      Merge tag 'riscv-dt-for-v6.6-final' of https://git.kernel.org/pub/=
scm/linux/kernel/git/conor/linux into soc/dt
      Merge tag 'imx-bindings-6.7' of git://git.kernel.org/pub/scm/linux=
/kernel/git/shawnguo/linux into soc/dt
      Merge tag 'imx-dt-6.7' of git://git.kernel.org/pub/scm/linux/kerne=
l/git/shawnguo/linux into soc/dt
      Merge tag 'imx-dt64-6.7' of git://git.kernel.org/pub/scm/linux/ker=
nel/git/shawnguo/linux into soc/dt
      Merge tag 'qcom-arm64-for-6.7' of https://git.kernel.org/pub/scm/l=
inux/kernel/git/qcom/linux into soc/dt
      Merge tag 'qcom-dts-for-6.7' of https://git.kernel.org/pub/scm/lin=
ux/kernel/git/qcom/linux into soc/dt
      Merge tag 'aspeed-6.7-devicetree' of git://git.kernel.org/pub/scm/=
linux/kernel/git/joel/bmc into soc/dt
      Merge tag 'amlogic-arm64-dt-for-v6.7' of https://git.kernel.org/pu=
b/scm/linux/kernel/git/amlogic/linux into soc/dt
      Merge tag 'stm32-dt-for-v6.7-1' of git://git.kernel.org/pub/scm/li=
nux/kernel/git/atorgue/stm32 into soc/dt
      Merge tag 'riscv-dt-for-v6.7' of https://git.kernel.org/pub/scm/li=
nux/kernel/git/conor/linux into soc/dt
      Merge tag 'v6.7-rockchip-dts64-1' of git://git.kernel.org/pub/scm/=
linux/kernel/git/mmind/linux-rockchip into soc/dt
      Merge tag 'v6.7-rockchip-dts32-1' of git://git.kernel.org/pub/scm/=
linux/kernel/git/mmind/linux-rockchip into soc/dt
      Merge tag 'v6.6-next-dts64.3' of https://git.kernel.org/pub/scm/li=
nux/kernel/git/matthias.bgg/linux into soc/dt
      Merge tag 'ti-k3-dt-for-v6.7' of https://git.kernel.org/pub/scm/li=
nux/kernel/git/ti/linux into soc/dt
      Merge tag 'mvebu-dt64-6.7-1' of git://git.kernel.org/pub/scm/linux=
/kernel/git/gclement/mvebu into soc/dt
      Merge tag 'samsung-dt64-6.7-2' of https://git.kernel.org/pub/scm/l=
inux/kernel/git/krzk/linux into soc/dt
      Merge tag 'samsung-dt-6.7-2' of https://git.kernel.org/pub/scm/lin=
ux/kernel/git/krzk/linux into soc/dt
      Merge tag 'arm-soc/for-6.7/devicetree' of https://github.com/Broad=
com/stblinux into soc/dt
      Merge tag 'ti-k3-dt-for-v6.7-part2' of https://git.kernel.org/pub/=
scm/linux/kernel/git/ti/linux into soc/dt
      Merge tag 'v6.7-rockchip-dts64-2' of git://git.kernel.org/pub/scm/=
linux/kernel/git/mmind/linux-rockchip into soc/dt

Arseniy Krasnov (1):
      arm64: dts: amlogic: meson-axg: Meson NAND node

Aurelien Jarno (1):
      riscv: dts: starfive: fix NOR flash reserved-data partition size

Bartosz Golaszewski (1):
      arm64: dts: qcom: sa8775p: enable the inline crypto engine

Ben Wolsieffer (2):
      ARM: dts: stm32: add stm32f7 SDIO sleep pins
      ARM: dts: stm32: add SDIO pinctrl sleep support on stm32f7 boards

Benjamin Gaignard (1):
      arm64: dts: rockchip: Add AV1 decoder node to rk3588s

Biju Das (5):
      dt-bindings: clock: versaclock3: Add description for #clock-cells =
property
      clk: vc3: Fix 64 by 64 division
      clk: vc3: Fix output clock mapping
      clk: vc3: Make vc3_clk_mux enum values based on vc3_clk enum values
      arm64: dts: renesas: rz-smarc: Use versa3 clk for audio mclk

Bjorn Andersson (1):
      Merge branch '20230707035744.22245-2-quic_jkona@quicinc.com' into =
arm64-for-6.7

Brad Griffis (2):
      arm64: tegra: Fix P3767 card detect polarity
      arm64: tegra: Fix P3767 QSPI speed

Brad Larson (2):
      dt-bindings: arm: add AMD Pensando boards
      arm64: dts: Add AMD Pensando Elba SoC support

Bryan O'Donoghue (6):
      arm64: dts: qcom: sm8250: Define ports for qmpphy orientation-swit=
ching
      arm64: dts: qcom: pm8150b: Add a TCPM description
      arm64: dts: qcom: qrb5165-rb5: Switch on Type-C VBUS boost
      arm64: dts: qcom: qrb5165-rb5: Switch on basic TCPM
      arm64: dts: qcom: qrb5165-rb5: Switch on TCPM usb-role-switching f=
or usb_1
      arm64: dts: qcom: qrb5165-rb5: Switch on TCPM orientation-switch f=
or usb_1_qmpphy

Cem Tenruh (2):
      arm64: dts: imx8mp-phycore-som: Add gpio-line-names
      arm64: dts: imx8mp-phyboard-pollux: Add gpio-line-names

Chanh Nguyen (6):
      ARM: dts: aspeed: mtjade, mtmitchell: Update gpio-line-names
      ARM: dts: aspeed: mtjade, mtmitchell: Add new gpio-line-names
      ARM: dts: aspeed: mtjade: Add the gpio-hog
      ARM: dts: aspeed: mtmitchell: Add inlet temperature sensor
      ARM: dts: aspeed: mtmitchell: Remove redundant ADC configurations
      ARM: dts: aspeed: mtmitchell: Add I2C NVMe alias port

Chen Wang (8):
      riscv: Add SOPHGO SOC family Kconfig support
      dt-bindings: vendor-prefixes: add milkv/sophgo
      dt-bindings: riscv: add sophgo sg2042 bindings
      dt-bindings: riscv: Add T-HEAD C920 compatibles
      dt-bindings: interrupt-controller: Add Sophgo SG2042 PLIC
      riscv: dts: add initial Sophgo SG2042 SoC device tree
      riscv: dts: sophgo: add Milk-V Pioneer board device tree
      riscv: defconfig: enable SOPHGO SoC

Chen-Yu Tsai (1):
      arm64: dts: mediatek: mt8183-kukui: Add PMIC regulator supplies

Chris Morgan (11):
      arm: dts: sun8i: V3s: Add pinctrl for pwm
      ARM: dts: sun8i: v3s: add EHCI and OHCI to v3s dts
      dt-bindings: arm: sunxi: add Anbernic RG-Nano
      ARM: dts: sunxi: add support for Anbernic RG-Nano
      arm64: dts: rockchip: add PCIe to rk3588s-indiedroid-nova
      arm64: dts: rockchip: add USB2 to rk3588s-indiedroid
      arm64: dts: rockchip: Add saradc node to Indiedroid Nova
      dt-bindings: arm64: rockchip: add Powkiddy RGB30
      arm64: dts: rockchip: add support for Powkiddy RGB30
      arm64: dts: rockchip: Update VPLL Frequency for RGB30
      arm64: dts: rockchip: Remove UART2 from RGB30

Chris Packham (1):
      ARM64: dts: marvell: cn9310: Use appropriate label for spi1 pins

Christian Hewitt (3):
      arm64: dts: meson: add audio playback to p200
      arm64: dts: meson: add audio playback to p201
      arm64: dts: meson: add audio playback to u200

Christophe JAILLET (1):
      firmware: imx-dsp: Fix an error handling path in imx_dsp_setup_cha=
nnels()

Claudiu Beznea (12):
      dt-bindings: soc: renesas: Document Renesas RZ/G3S SoC variants
      dt-bindings: soc: renesas: renesas,rzg2l-sysc: Document RZ/G3S SoC
      dt-bindings: clock: renesas,rzg2l-cpg: Document RZ/G3S SoC
      dt-bindings: soc: renesas: Document RZ/G3S SMARC SoM
      dt-bindings: soc: renesas: Document SMARC Carrier-II EVK
      arm64: dts: renesas: Add initial DTSI for RZ/G3S SoC
      arm64: dts: renesas: Add initial support for RZ/G3S SMARC SoM
      arm64: dts: renesas: Add initial device tree for RZ SMARC Carrier-=
II Board
      arm64: dts: renesas: Add initial device tree for RZ/G3S SMARC EVK =
board
      arm64: dts: renesas: r9a08g045: Add nodes for SDHI1 and SDHI2
      arm64: dts: renesas: r9a08g045: Add missing cache-level for L3 cac=
he
      arm64: dts: renesas: rzg3s-smarc-som: Spelling s/device-type/devic=
e_type/

Conor Dooley (7):
      riscv: dts: allwinner: remove address-cells from intc node
      Merge initial Sophgo patches into riscv-dt-for-next
      riscv: dts: allwinner: convert isa detection to new properties
      riscv: dts: microchip: convert isa detection to new properties
      riscv: dts: sifive: convert isa detection to new properties
      riscv: dts: starfive: convert isa detection to new properties
      riscv: dts: thead: convert isa detection to new properties

Danila Tikhonov (2):
      arm64: dts: qcom: pm8150l: Add wled node
      dt-bindings: power: qcom,rpmpd: Add SM7150

Dario Binacchi (1):
      ARM: dts: stm32: stm32f7-pinctrl: don't use multiple blank lines

Dasnavis Sabiya (1):
      arm64: dts: ti: k3-am69-sk: Add DP and HDMI support

David Heidelberg (2):
      arm64: dts: qcom: sdm845: Fix PSCI power domain names
      arm64: dts: qcom: sdm845: cheza doesn't support LMh node

David Wronek (4):
      dt-bindings: arm: qcom: Document SM7125 and xiaomi,joyeuse board
      arm64: dts: qcom: pm6150: Add resin and rtc nodes
      arm64: dts: qcom: Add SM7125 device tree
      arm64: dts: qcom: Add support for the Xiaomi SM7125 platform

Diogo Ivo (3):
      arm64: tegra: Add DSI/CSI regulator on Smaug
      arm64: tegra: Add backlight node on Smaug
      arm64: tegra: Add display panel node on Smaug

Dmitry Baryshkov (31):
      arm64: dts: qcom: sc7180: switch USB+DP QMP PHY to new style of bi=
ndings
      arm64: dts: qcom: sc7280: link usb3_phy_wrapper_gcc_usb30_pipe_clk
      arm64: dts: qcom: sc7280: switch USB+DP QMP PHY to new style of bi=
ndings
      arm64: dts: qcom: sdm845: switch USB+DP QMP PHY to new style of bi=
ndings
      arm64: dts: qcom: sm8150: switch USB+DP QMP PHY to new style of bi=
ndings
      arm64: dts: qcom: sm8250: switch USB+DP QMP PHY to new style of bi=
ndings
      arm64: dts: qcom: sc8180x: switch UFS QMP PHY to new style of bind=
ings
      arm64: dts: qcom: sm8250: Add DisplayPort device node
      arm64: dts: qcom: qrb5165-rb5: add onboard USB-C redriver
      arm64: dts: qcom: qrb5165-rb5: enable displayport controller
    ...

Dmitry Rokosov (9):
      arm64: dts: meson: a1: reorder includes to keep them sorted
      arm64: dts: meson: a1: remove extra empty line before reset node
      arm64: dts: meson: a1: remove the unnecessary 'okay' status pwrc v=
alue
      arm64: dts: meson: a1: reorder gpio_intc node definition
      arm64: dts: meson: a1: introduce PLL and Peripherals clk controlle=
rs
      arm64: dts: meson: a1: support USB controller in OTG mode
      arm64: dts: introduce Amlogic AD402 reference board based on A113L=
 SoC
      dt-bindings: arm: amlogic: add Amlogic AD402 bindings
      arm64: dts: amlogic: a1: support all i2c masters and their muxes

Douglas Anderson (3):
      arm64: dts: qcom: sc7180: Link trogdor touchscreens to the panels
      arm64: dts: qcom: sc7180: Move trogdor rt5682s bits to a fragment
      arm64: dts: qcom: sc7180: Reorganize trogdor rt5682 audio codec dts

Eddie James (1):
      ARM: dts: aspeed: bonnell: Add reserved memory for TPM event log

Fabien Parent (1):
      dt-bindings: power: Add MT8365 power domains

Fabio Estevam (67):
      arm64: dts: imx8mm-phg: Disable flexspi
      arm64: dts: imx8dxl-evk: Remove invalid SPI property
      arm64: dts: imx8mq-librem5: Fix gpio-hog property
      arm64: dts: imx8mq-pico-pi: Fix PMIC properties
      arm64: dts: imx8mq-thor96: Fix sdio-pwrseq GPIO property
      arm64: dts: imx8qm-apalis: Remove invalid FEC property
      arm64: dts: imx8mp: Move funnel outside from soc
      arm64: dts: imx8mq: Move funnel outside from soc
      arm64: dts: imx8-ss-lsio: Remove unused clock
      arm64: dts: imx8-ss-lsio: Move lsio_bus_clk outside of soc
      arm64: dts: imx8-ss-dma: Move dma_ipg_clk outside of soc
      arm64: dts: imx8-ss-conn: Move conn clocks outside of soc
      arm64: dts: imx8-ss-img: Move img_ipg_clk outside of soc
      ...

Francesco Dolcini (1):
      arm64: dts: ti: verdin-am62: disable MIPI DSI bridge

Frank Li (9):
      arm64: dts: imx93: add edma1 and edma2
      arm64: dts: imx93: add dma support for lpuart[1..8]
      arm64: dts: imx93-evk: add uart5
      arm64: dts: imx8: add edma[0..3]
      arm64: dts: imx8: add edma for uart[0..3]
      arm64: dts: imx8qm: Update edma channel for uart[0..3]
      arm64: dts: imx8: update lpuart[0..3] irq number
      arm64: dts: imx8qxp-mek: enable 8qxp lpuart2 and lpuart3
      arm64: dts: imx8qm-mek: enable 8qm lpuart2 and lpuart3

Gatien Chevallier (1):
      ARM: dts: stm32: add RNG node for STM32MP13x platforms

Gaurav Kohli (2):
      arm64: dts: qcom: msm8916: Fix iommu local address range
      arm64: dts: qcom: msm8939: Fix iommu local address range

Geert Uytterhoeven (15):
      ARM: dts: renesas: blanche: Fix typo in GP_11_2 pin name
      ARM: dts: renesas: ape6evm: Drop bogus "mtd-rom" compatible value
      ARM: dts: renesas: gr-peach: Remove unneeded probe-type property
      ARM: dts: renesas: Remove unused LBSC nodes from board DTS
      ARM: dts: renesas: r7s72100: Add BSC node
      ARM: dts: renesas: r8a7779: Add LBSC node
      ARM: dts: renesas: r8a7792: Add LBSC node
      ARM: dts: renesas: marzen: Move Ethernet node to LBSC
      ARM: dts: renesas: blanche: Move Ethernet node to LBSC
      ARM: dts: renesas: wheat: Move Ethernet node to LBSC
      ARM: dts: renesas: genmai: Add FLASH nodes
      ARM: dts: renesas: rskrza1: Add FLASH nodes
      Merge tag 'clk-fixes-for-linus' of https://git.kernel.org/pub/scm/=
linux/kernel/git/clk/linux into renesas-dts-for-v6.7
      ARM: dts: renesas: bockw: Add FLASH node
      Merge tag 'renesas-r9a08g045-dt-binding-defs-tag' into renesas-dts=
-for-v6.7

George Stark (1):
      arm64: dts: meson: a1: add saradc definition

Gregor Herburger (5):
      dt-bindings: arm: fsl: Add TQ-Systems LS1043A/LS1046A based boards
      dt-bindings: arm: fsl: Add TQ-Systems LS1088 based boards
      arm64: dts: ls1043a: remove second dspi node
      arm64: dts: freescale: add initial device tree for TQMLS1043A/TQML=
S1046A
      arm64: dts: freescale: add initial device tree for TQMLS1088A

Hal Feng (3):
      riscv: dts: starfive: visionfive 2: Enable usb0
      riscv: dts: starfive: visionfive 2: Fix uart0 pins sort order
      riscv: dts: starfive: Add JH7110 PWM-DAC support

Huqiang Qin (2):
      arm64: dts: Add watchdog node for Amlogic-T7 SoCs
      arm64: dts: Add pinctrl node for Amlogic T7 SoCs

Igor Prusov (2):
      arm64: dts: meson: a1: Add SPIFC mux pins
      arm64: dts: meson-a1-ad402: set SPIFC pins

Inochi Amaoto (3):
      riscv: dts: allwinner: d1: Add PMU event node
      dt-bindings: timer: Add Sophgo sg2042 CLINT timer
      dt-bindings: interrupt-controller: Add Sophgo sg2042 CLINT mswi

Jaewon Kim (1):
      arm64: dts: exynos: Use pinctrl macros for exynos5433-tm2

Jagadeesh Kona (5):
      dt-bindings: clock: qcom: Add SM8550 camera clock controller
      clk: qcom: clk-alpha-pll: Add support for lucid ole pll configure
      clk: qcom: camcc-sm8550: Add camera clock controller driver for SM=
8550
      clk: qcom: camcc-sm8550: Add support for qdss, sleep and xo clocks
      arm64: dts: qcom: sm8550: Add camera clock controller

Jagan Teki (6):
      dt-bindings: pwm: rockchip: Document rv1126-pwm
      ARM: dts: rockchip: Add pwm2m0 pins to rv1126
      ARM: dts: rockchip: Add pwm2 node to rv1126
      ARM: dts: rockchip: Add pwm11m0 pins to rv1126
      ARM: dts: rockchip: Add pwm11 node to rv1126
      ARM: dts: rockchip: Enable pwm fan for edgeble-neu2

Jai Luthra (4):
      arm64: dts: ti: k3-am62a-main: Add nodes for McASP
      arm64: dts: ti: k3-am62a7-sk: Split vcc_3v3 regulators
      arm64: dts: ti: k3-am62a7-sk: Drop i2c-1 to 100Khz
      arm64: dts: ti: k3-am62a7-sk: Enable audio on AM62A

James Hilliard (3):
      dt-bindings: arm: fsl: Add VAR-SOM-MX6 SoM with Custom Board
      ARM: dts: imx6qdl: Add Variscite VAR-SOM-MX6 SoM support
      ARM: dts: imx6q: Add Variscite MX6 Custom board support

Jan Dakinevich (1):
      arm64: dts: meson: a1: add eMMC controller and its pins

Jasper Korten (1):
      arm64: dts: qcom: msm8916-samsung-gt510: Add display panel

Jernej Skrabec (1):
      ARM: dts: sun8i-r40: Add interconnect to video-codec

Jerome Brunet (8):
      arm64: dts: meson: u200: fix spdif output pin
      arm64: dts: meson: u200: add missing audio clock controller
      arm64: dts: meson: u200: add spdifout b routes
      arm64: dts: meson: u200: use TDM C for HDMI
      arm64: dts: meson: u200: add onboard devices
      arm64: dts: meson: g12: name spdifout consistently
      dt-bindings: arm: amlogic: add libretech cottonwood support
      arm64: dts: amlogic: add libretech cottonwood support

Jisheng Zhang (5):
      dt-bindings: interrupt-controller: Add SOPHGO CV1800B plic
      dt-bindings: timer: Add SOPHGO CV1800B clint
      dt-bindings: riscv: Add Milk-V Duo board compatibles
      riscv: dts: sophgo: add initial CV1800B SoC device tree
      riscv: dts: sophgo: add Milk-V Duo board device tree

John Clark (1):
      arm64: dts: rockchip: Add NanoPC T6 PCIe e-key support

Jon Hunter (1):
      arm64: tegra: Add power-sensors for Tegra234 boards

Josua Mayer (3):
      dt-bindings: arm: Add SolidRun LX2162A SoM & Clearfog Board
      arm64: dts: lx2160a: describe the SerDes block #2
      arm64: dts: freescale: Add support for LX2162 SoM & Clearfog Board

Julien Panis (1):
      arm64: dts: ti: k3-am62a7-sk: Add support for TPS6593 PMIC

Keerthy (7):
      arm64: dts: ti: k3-j721s2: Add ESM instances
      arm64: dts: ti: k3-j784s4: Add ESM instances
      arm64: dts: ti: k3-j7200: Add MCU domain ESM instance
      arm64: dts: ti: k3-j784s4-main: Add the main domain watchdog insta=
nces
      arm64: dts: ti: k3-j784s4-mcu: Add the mcu domain watchdog instanc=
es
      arm64: dts: ti: k3-j721s2-main: Add the main domain watchdog insta=
nces
      arm64: dts: ti: k3-j712s2-mcu: Add the mcu domain watchdog instanc=
es

Konrad Dybcio (13):
      arm64: dts: qcom: sm8250-edo: Set UART alias and stdout-path
      arm64: dts: qcom: sm8250: Add interconnects and power-domains to Q=
UPs
      arm64: dts: qcom: sc7280: Remove qcom,adsp-bypass-mode
      arm64: dts: qcom: sc7280: Add missing LMH interrupts
      arm64: dts: qcom: qrb2210-rb1: Swap UART index
      arm64: dts: qcom: qrb2210-rb1: Fix regulators
      arm64: dts: qcom: qrb2210-rb1: Enable remote processors
      arm64: dts: qcom: qrb2210-rb1: Add GPIO LEDs
      arm64: dts: qcom: qrb2210-rb1: Hook up USB3
      arm64: dts: qcom: sdm670: Fix pdc mapping
      arm64: dts: qcom: sdm845-tama: Add GPIO line names for TLMM
      arm64: dts: qcom: sdm845-tama: Add GPIO line names for PMIC GPIOs
      arm64: dts: qcom: sdm845-tama: Add camera GPIO regulators

Krzysztof Kozlowski (58):
      arm64: dts: exynos: exynos5433-tm2: switch sound card to audio-rou=
ting
      ARM: dts: samsung: exynos4212-tab3: switch sound card to audio-rou=
ting
      ARM: dts: samsung: exynos4412-galaxy-s3: switch sound card to audi=
o-routing
      ARM: dts: samsung: exynos4412-n710x: switch sound card to audio-ro=
uting
      ARM: dts: samsung: exynos4412-odroid: switch sound card to audio-r=
outing
      ARM: dts: samsung: exynos5422-odroid: switch sound card to audio-r=
outing
      ARM: dts: samsung: s5pv210-fascinate4g: switch sound card to audio=
-routing
      ARM: dts: samsung: s5pv210-galaxys: switch sound card to audio-rou=
ting
      arm64: dts: qcom: sm8550-mtp: use correct UFS supply
      arm64: dts: qcom: sm8550-qrd: use correct UFS supply
      arm64: dts: qcom: sm8450-hdk: add UFS host controller supply
      arm64: dts: qcom: sm8450-qrd: add UFS host controller supply
      arm64: dts: qcom: sm8350-hdk: add UFS host controller supply
      arm64: dts: qcom: sm8350-mtp: add UFS host controller supply
      arm64: dts: qcom: sm8450-hdk: add other analogue microphones
      arm64: dts: qcom: msm8994: fix duplicated @6c00000 reserved memory
      arm64: dts: qcom: msm8992-libra: drop duplicated reserved memory
      arm64: dts: qcom: sc8180x: align USB DWC3 clocks with bindings
      arm64: dts: qcom: sdm630: align USB DWC3 clocks with bindings
      arm64: dts: qcom: sc7280-crd: add Bluetooth VDDIO supply
      arm64: dts: qcom: sc7280: drop incorrect EUD port on SoC side
      arm64: dts: qcom: sc8180x: drop incorrect cell-index from SPMI
      ...

Kuninori Morimoto (5):
      arm64: dts: renesas: Handle ADG bit for sound clk_i
      arm64: dts: renesas: ulcb/kf: Use multi Component sound
      dt-bindings: soc: renesas: Document R-Car S4 Starter Kit
      arm64: dts: renesas: Add Renesas R8A779F4 SoC support
      arm64: dts: renesas: Add R-Car S4 Starter Kit support

Lad Prabhakar (3):
      riscv: dts: renesas: r9a07g043f: Add L2 cache node
      riscv: dts: renesas: r9a07g043f: Add dma-noncoherent property
      riscv: dts: renesas: rzfive-smarc: Enable the blocks which were ex=
plicitly disabled

Laurentiu Tudor (1):
      arm64: dts: ls208xa: use a pseudo-bus to constrain usb dma size

Linus Walleij (6):
      dt-bindings: Add vendor prefixes
      dt-bindings: arm: List more IXP4xx devices
      ARM: dts: Use only the Linksys compatible for now
      ARM: dts: ixp4xx: Add USRobotics USR8200 device tree
      ARM: dts: ixp4xx-nslu2: Enable write on flash
      ARM: dts: ixp4xx: Use right restart keycode

Lionel Debieve (1):
      ARM: dts: stm32: add HASH on stm32mp131

Liu Ying (1):
      arm64: dts: imx8mm-evk: Fix hdmi@3d node

Luca Weiss (7):
      arm64: dts: qcom: Use QCOM_SCM_VMID defines for qcom,vmid
      arm64: dts: qcom: sc7280: Mark some nodes as 'reserved'
      arm64: dts: qcom: pm7250b: make SID configurable
      arm64: dts: qcom: pm8350c: Add flash led node
      dt-bindings: arm: qcom: Add QCM6490 Fairphone 5
      arm64: dts: qcom: qcm6490: Add device-tree for Fairphone 5
      ARM: dts: qcom: sdx65-mtp: Specify PM7250B SID to use

MD Danish Anwar (3):
      arm64: dts: ti: k3-am65-main: Add ICSSG IEP nodes
      arm64: dts: ti: k3-am654-icssg2: add ICSSG2 Ethernet support
      arm64: dts: ti: k3-am654-idk: Add ICSSG Ethernet ports

Macpaul Lin (2):
      dt-bindings: arm64: mediatek: add mt8395-evk board
      arm64: dts: mediatek: add device-tree for Genio 1200 EVK board

Marcel Ziswiler (1):
      arm64: dts: ti: verdin-am62: add iw416 based bluetooth

Marek Vasut (11):
      clk: si521xx: Use REGCACHE_FLAT instead of NONE
      clk: si521xx: Fix regmap write accessor
      arm64: dts: imx8mp: Switch PCIe to HSIO PLL on i.MX8MP DHCOM PDK2 =
and generate clock from SoC
      arm64: dts: imx8mp: Simplify USB C on DH i.MX8M Plus DHCOM PDK3
      arm64: dts: imx8mp: Describe VDD_ARM run and standby voltage for D=
ata Modul i.MX8M Plus eDM SBC
      arm64: dts: imx8mp: Describe VDD_ARM run and standby voltage for D=
H i.MX8M Plus DHCOM SoM
      arm64: dts: imx8mp: Fix property indent on DH i.MX8M Plus DHCOM PD=
K3
      arm64: dts: imx8mp: Switch WiFI enable signal to mmc-pwrseq-simple=
 on i.MX8MP DHCOM SoM
      arm64: dts: imx8mp: Add UART1 and RTC wake up source on DH i.MX8M =
Plus DHCOM SoM
      arm64: dts: imx8mp: Update i.MX8MP DHCOM SoM DT to production rev.=
200
      arm64: dts: imx8mp: Drop i.MX8MP DHCOM rev.100 PHY address workaro=
und from PDK3 DT

Marijn Suijten (6):
      arm64: dts: qcom: sm6125: Pad APPS IOMMU address to 8 characters
      arm64: dts: qcom: sm6125: Sort spmi_bus node numerically by reg
      arm64: dts: qcom: sm6125: Switch fixed xo_board clock to RPM XO cl=
ock
      arm64: dts: qcom: sm6125: Add dispcc node
      arm64: dts: qcom: sm6125: Add display hardware nodes
      arm64: dts: qcom: sm6125-seine: Configure MDSS, DSI and panel

Markuss Broks (1):
      arm64: dts: qcom: msm8916-samsung-j5-common: Add accelerometer

Martin Botka (6):
      dt-bindings: nvmem: SID: Add binding for H616 SID controller
      arm64: dts: allwinner: h616: Add SID controller node
      dt-bindings: vendor-prefixes: Add BigTreeTech
      dt-bindings: arm: sunxi: Add BigTreeTech boards
      arm64: dts: allwinner: h616: Add BigTreeTech CB1 SoM & boards supp=
ort
      arm64: dts: allwinner: h616: Add BigTreeTech Pi support

Martin Kurbanov (1):
      arm64: dts: meson: a1: introduce SPI Flash Controller

Mateusz Majewski (2):
      arm64: dts: exynos: remove unused TMU alias
      ARM: dts: samsung: exynos4210: enable polling

Matthias Brugger (1):
      Merge remote-tracking branch 'ulfh/genpd_dt' into v6.6-next/dts64.3

Matthias Schiffer (4):
      arm64: dts: ti: k3-am64-tqma64xxl: add supply regulator for I2C de=
vices
      arm64: dts: ti: k3-am64-tqma64xxl-mbax4xxl: add muxing for GPIOs o=
n pin headers
      arm64: dts: ti: k3-am64-tqma64xxl-mbax4xxl: add chassis-type
      arm64: dts: ti: k3-am64-tqma64xxl-mbax4xxl: update gpio-led config=
uration

Matti Lehtim=C3=A4ki (3):
      ARM: dts: qcom: apq8026-samsung-matisse-wifi: Fix inverted hall se=
nsor
      ARM: qcom: msm8226: Add rpm-master-stats node
      ARM: qcom: msm8974: Add rpm-master-stats node

Maulik Shah (1):
      arm64: dts: qcom: sc7280: Add power-domains for cpuidle states

Maxim Schwalm (1):
      ARM: tegra: Drop unit-address from parallel RGB output port

Mihai Sain (1):
      ARM: dts: at91: sama5d29_curiosity: Add device tree for sama5d29_c=
uriosity board

Ming Qian (1):
      arm64: dts: imx8-ss-img: Assign slot for imx jpeg encoder/decoder

Muhammed Efe Cetin (3):
      dt-bindings: arm: rockchip: Add Orange Pi 5 board
      arm64: dts: rockchip: Add sfc node to rk3588s
      arm64: dts: rockchip: Add Orange Pi 5

Nam Cao (1):
      riscv: dts: starfive: visionfive 2: correct spi's ss pin

Nathan Rossi (1):
      soc: imx8m: Enable OCOTP clock for imx8mm before reading registers

Neha Malcom Francis (1):
      arm64: dts: ti: k3-j721e-mcu-wakeup: Add MCU domain ESM instance

Neil Armstrong (5):
      Merge branch 'genpd_dt' of git://git.kernel.org/pub/scm/linux/kern=
el/git/ulfh/linux-pm into v6.7/arm64-dt
      arm64: dts: qcom: sm8550: add UART14 nodes
      arm64: dts: qcom: sm8550-qrd: add bluetooth support
      arm64: dts: qcom: split pmr735d into 2
      Revert "arm64: dts: qcom: sm8450: Add PRNG"

Nicolas Ferre (1):
      ARM: dts: at91/trivial: fix typo in crypto DT naming

Nikita Travkin (3):
      arm64: dts: qcom: msm8916-samsung-gt510: Add capacitive keys
      arm64: dts: qcom: sc7180: Add tertiary mi2s pinctrl
      arm64: dts: qcom: sc7180: Add ADSP

Nishanth Menon (6):
      arm64: dts: ti: k3-am625: Add boot phase tags marking
      arm64: dts: ti: k3-am625-beagleplay: Add boot phase tags marking
      arm64: dts: ti: k3-am625-sk: Add boot phase tags marking
      arm64: dts: ti: k3-am64: Add phase tags marking
      arm64: dts: ti: k3-am642-evm: Add boot phase tags marking
      arm64: dts: ti: k3-am642-sk: Add boot phase tags marking

N=C3=ADcolas F. R. A. Prado (5):
      dt-bindings: arm64: dts: mediatek: Add rev5-sku2 of hayato
      dt-bindings: arm64: dts: mediatek: Add rev4 of spherion
      arm64: dts: mediatek: Remove asurada-audio dtsi files
      arm64: dts: mediatek: Add hayato-rev5-sku2
      arm64: dts: mediatek: Add spherion-rev4

Oleg Lyovin (1):
      arm64: dts: meson: a1: introduce UART_AO mux definitions

Ondrej Jirman (6):
      arm64: dts: rockchip: Add I2S2 M0 pin definitions to rk3588s
      arm64: dts: rockchip: Add UART9 M0 pin definitions to rk3588s
      dt-bindings: arm: rockchip: Add Orange Pi 5 Plus
      arm64: dts: rockchip: Add board device tree for rk3588-orangepi-5-=
plus
      dt-bindings: arm: rockchip: Add Pine64 QuarzPro64
      arm64: dts: rockchip: Add QuartzPro64 SBC device tree

Peng Fan (2):
      arm64: dts: imx8ulp: update gpio node
      arm64: dts: imx93: update gpio node

Pierre Gondois (1):
      arm64: dts: Update cache properties for socionext

Rafa=C5=82 Mi=C5=82ecki (7):
      ARM: dts: BCM5301X: Set MACs for D-Link DIR-885L
      ARM: dts: BCM5301X: Set MAC address for Asus RT-AC87U
      ARM: dts: BCM5301X: Relicense Felix's code to the GPL 2.0+ / MIT
      ARM: dts: BCM5301X: Relicense Vivek's code to the GPL 2.0+ / MIT
      ARM: dts: BCM5301X: Explicitly disable unused switch CPU ports
      ARM: dts: BCM5301X: Set fixed-link for extra Netgear R8000 CPU por=
ts
      ARM: dts: BCM5301X: Set switch ports for Linksys EA9200

Rahul T R (2):
      arm64: dts: ti: k3-j784s4-main: Add DSS and DP-bridge node
      arm64: dts: ti: k3-j784s4-evm: Enable DisplayPort-0

Ravi Gunasekaran (1):
      arm64: dts: ti: k3-am654-base-board: Add I2C I/O expander

Raymond Hackley (2):
      ARM: dts: samsung: exynos4412-midas: fix key-ok event code
      ARM: dts: samsung: exynos4412-midas: use Linux event codes for inp=
ut keys

Rayyan Ansari (1):
      arm64: tegra: Enable IOMMU for host1x on Tegra132

Rob Herring (3):
      arm64: dts: imx: Add imx8mm-prt8mm.dtb to build
      arm64: dts: renesas: Apply overlays to base dtbs
      arm/arm64: dts: Removed undocumented and unused "pl022,hierarchy" =
property

Robert Marko (4):
      arm64: dts: qcom: ipq5018: add watchdog
      arm64: dts: marvell: uDPU: rename the SFP GPIO properties
      arm64: dts: marvell: eDPU: add support for version with external s=
witch
      arm64: dts: qcom: ipq5018: indicate that SDI should be disabled

Roger Quadros (1):
      arm64: dts: ti: k3-am64: Add GPIO expander on I2C0

Sam Edwards (3):
      dt-bindings: vendor-prefixes: add turing
      dt-bindings: arm: rockchip: Add Turing RK1
      arm64: dts: rockchip: Add Turing RK1 SoM support

Sam Protsenko (3):
      arm64: dts: exynos: Enable USB in Exynos850
      arm64: dts: exynos: Enable USB support on E850-96 board
      arm64: dts: exynos: Add reserved memory for pstore on E850-96

Sascha Hauer (4):
      ARM: dts: stm32: omit unused pinctrl groups from stm32mp15 dtb fil=
es
      arm64: dts: rockchip: Always enable DFI on rk3399
      arm64: dts: rockchip: Add DFI to rk356x
      arm64: dts: rockchip: Add DFI to rk3588s

Sean Nyekjaer (9):
      ARM: dts: stm32: Add alternate pinmux for i2s pins
      ARM: dts: stm32: Add alternate pinmux for ldtc pins
      ARM: dts: stm32: Add alternate pinmux for can pins
      ARM: dts: stm32: osd32: fix ldo1 not required to be always-on
      ARM: dts: stm32: osd32: fix ldo2 not required to be always-on
      ARM: dts: stm32: lxa-tac: remove v3v3_hdmi override
      ARM: dts: stm32: osd32: fix ldo6 not required to be always-on
      dt-bindings: arm: stm32: add extra SiP compatible for oct,stm32mp1=
57c-osd32-red
      ARM: dts: stm32: Add Octavo OSD32MP1-RED board

Sebastian Reichel (7):
      arm64: dts: rockchip: add PCIe network controller to rock-5b
      arm64: dts: rockchip: add PCIe for M.2 M-key to rock-5b
      arm64: dts: rockchip: add PCIe for M.2 E-Key to rock-5b
      arm64: dts: rockchip: add PCIe2 network controller to rk3588-evb1
      arm64: dts: rockchip: add PCIe3 bus to rk3588-evb1
      arm64: dts: rockchip: add ADC buttons to rk3588-evb1
      arm64: dts: rockchip: add status LED to rock-5b

Shawn Guo (1):
      Merge tag 'imx-fixes-6.6' into imx/dt64

Sheng-Liang Pan (2):
      dt-bindings: arm: qcom: add sc7180-lazor board bindings
      arm64: dts: qcom: sc7180: Add sku_id and board id for lazor/limoze=
en

Siddharth Manthan (1):
      arm64: dts: qcom: msm8916-samsung-gt58: Add display panel

Siddharth Vadapalli (3):
      arm64: dts: ti: k3-j721s2-evm-gesi: Specify base dtb for overlay f=
ile
      arm64: dts: ti: k3-j784s4-main: Add system controller and SERDES l=
ane mux
      arm64: dts: ti: k3-j784s4-main: Add WIZ and SERDES PHY nodes

Sinthu Raja (3):
      arm64: dts: ti: Add USB Type C swap defines for J721S2 SoC
      arm64: dts: ti: k3-am68-sk: Add DT node for PCIe
      arm64: dts: ti: k3-am68-sk: Add DT node for USB

Stephan Gerhold (11):
      arm64: dts: qcom: pm8916: Drop codec reg-names and mclk
      arm64: dts: qcom: msm8916: Disable venus by default
      arm64: dts: qcom: msm8916/39: Disable GPU by default
      arm64: dts: qcom: msm8916-ufi: Drop gps_mem for now
      arm64: dts: qcom: msm8916: Reserve firmware memory dynamically
      arm64: dts: qcom: msm8916: Reserve MBA memory dynamically
      arm64: dts: qcom: msm8939: Reserve firmware memory dynamically
      arm64: dts: qcom: msm8916/39: Disable unneeded firmware reservatio=
ns
      arm64: dts: qcom: msm8916/39: Move mpss_mem size to boards
      arm64: dts: qcom: msm8916/39: Fix venus memory size
      arm64: dts: qcom: apq8016-sbc: Add missing ADV7533 regulators

Tam=C3=A1s Sz=C5=B1cs (4):
      arm64: dts: rockchip: Add sdio node to rock-5b
      arm64: dts: rockchip: Remove duplicate regulator vcc3v3_wf from ro=
ck-5b
      arm64: dts: rockchip: Enable UART6 on rock-5b
      arm64: dts: rockchip: Add missing sdmmc2 SDR rates to rock-3a

Teresa Remmet (3):
      arm64: dts: imx8mp-phyboard-pollux: Add flexcan support
      arm64: dts: imx8mp-phyboard-pollux: Enable USB support
      arm64: dts: imx8mp-phyboard-pollux: Add support for RS232/RS485

Thierry Reding (13):
      arm64: tegra: Add missing current-speed for SBSA UART
      arm64: tegra: Remove duplicate nodes on Jetson Orin NX
      arm64: tegra: Use correct format for clocks property
      arm64: tegra: Add dmas and dma-names for Tegra234 UARTE
      arm64: tegra: Mark Tegra234 SPI as compatible with Tegra114
      dt-bindings: arm: tegra: pmc: Improve property descriptions
      dt-bindings: arm: tegra: pmc: Remove useless boilerplate descripti=
ons
      dt-bindings: arm: tegra: pmc: Move additionalProperties
      dt-bindings: arm: tegra: pmc: Increase maximum number of clocks pe=
r powergate
      dt-bindings: arm: tegra: pmc: Restructure pad configuration node s=
chema
      dt-bindings: arm: tegra: pmc: Reformat example
      dt-bindings: arm: tegra: pmc: Relicense and move into soc/tegra di=
rectory
      arm64: tegra: Use correct interrupts for Tegra234 TKE

Tim Harvey (6):
      arm64: dts: imx8mp: add imx8mp-venice-gw74xx-imx219 overlay for rp=
i v2 camera
      ARM: dts: imx6qdl-gw5904: add internal mdio nodes
      arm64: dts: freescale: imx8m*-venice: remove label =3D "cpu" from =
DSA dt-binding
      arm64: dts: imx8mm-venice-gw73xx: add TPM device
      arm64: dts: imx8mp-venice-gw73xx: add TPM device
      ARM: dts: imx6qdl-gw5904: add dt props for populating eth MAC addrs

Timo Alho (1):
      clk: tegra: fix error return case for recalc_rate

Tony Lindgren (2):
      ARM: dts: motorola-mapphone: Add mdm6600 sleep pins
      ARM: dts: omap4-embt2ws: Fix pinctrl single node name warning

Trevor Woerner (4):
      ARM: dts: am335x-pocketbeagle: update LED information
      ARM: dts: am335x-pocketbeagle: remove dependency cycle
      ARM: dts: am335x-pocketbeagle: enable pru
      ARM: dts: am335x-pocketbeagle: add missing GPIO mux

Tudor Ambarus (1):
      ARM: dts: at91: sam9x60_curiosity: Add mandatory dt property for R=
TT

Vaishnav Achath (2):
      arm64: dts: ti: k3-j721s2-main: Add BCDMA instance for CSI2RX
      arm64: dts: ti: k3-j784s4-main: Add BCDMA instance for CSI2RX

Varadarajan Narayanan (2):
      arm64: dts: qcom: ipq5332: Add USB related nodes
      arm64: dts: qcom: ipq5332: Enable USB

Vignesh Raghavendra (4):
      arm64: dts: ti: k3-*: Convert DMSS to simple-bus
      arm64: dts: ti: k3-*: Convert NAVSS to simple-bus
      arm64: dts: ti: k3-am62p: Add nodes for more IPs
      arm64: dts: ti: k3-am62p5-sk: Updates for SK EVM

Vignesh Raman (1):
      arm64: dts: qcom: apq8016-sbc: Add overlay for usb host mode

Vignesh Viswanathan (5):
      arm64: dts: qcom: ipq8074: Fix hwlock index for SMEM
      arm64: dts: qcom: ipq5332: Fix hwlock index for SMEM
      arm64: dts: qcom: ipq6018: Fix hwlock index for SMEM
      arm64: dts: qcom: ipq9574: Fix hwlock index for SMEM
      arm64: dts: qcom: ipq6018: Fix tcsr_mutex register size

Wadim Egorov (3):
      arm64: dts: ti: k3-am64: Fix indentation in watchdog nodes
      arm64: dts: ti: phycore-am64: Add RTC interrupt pin
      arm64: dts: ti: k3-am625-beagleplay: Fix typo in ramoops reg

William Qiu (1):
      riscv: dts: starfive: add assigned-clock* to limit frquency

Wolfram Sang (1):
      arm64: dts: renesas: ebisu: Document Ebisu-4D support

Xingyu Wu (2):
      riscv: dts: starfive: pinfunc: Fix the pins name of I2STX1
      riscv: dts: starfive: Add the nodes and pins of I2Srx/I2Stx0/I2Stx1

Yang Chen (2):
      dt-bindings: arm: aspeed: document board compatibles
      ARM: dts: aspeed: Minerva: Add Facebook Minerva CMC board

Yann Gautier (3):
      arm64: dts: st: add sdmmc1 node in stm32mp251 SoC file
      arm64: dts: st: add sdmmc1 pins for stm32mp25
      arm64: dts: st: add SD-card support on STM32MP257F-EV1 board

Yannic Moog (2):
      dt-bindings: arm: fsl: add phyGATE-Tauri-L board
      arm64: dts: freescale: add phyGATE-Tauri i.MX 8M Mini Support

Yoshihiro Shimoda (2):
      arm64: dts: renesas: r8a779f0: Add PCIe Host and Endpoint nodes
      arm64: dts: renesas: r8a779f0: spider: Enable PCIe Host ch0

Zelong Dong (1):
      arm64: dts: meson: add IR controller for Meson-S4 SoC

Zhifeng Tang (1):
      clk: sprd: Fix thm_parents incorrect configuration

xianwei.zhao (2):
      dt-bindings: power: add Amlogic T7 power domains
      arm64: dts: amlogic: t7: add power domain controller node



