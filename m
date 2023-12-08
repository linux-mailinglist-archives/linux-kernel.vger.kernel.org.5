Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C496180A4F4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 15:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573892AbjLHOAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 09:00:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573875AbjLHOAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 09:00:32 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C10A9
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 06:00:37 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 1FA8E5C016A;
        Fri,  8 Dec 2023 09:00:37 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 08 Dec 2023 09:00:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm1; t=1702044037; x=1702130437; bh=I5hSfWoT/zaxbWvskG0G8aAPc
        /U4gJg60vnp4mri/nE=; b=KUc4SUJ9icXpk+IlCuT/vSRBaKPPkA0TzzMUW2h2Z
        782gmfl9UyWRskGM/OXhK9pE3bNh6kx/9jusvwwsIFZk+LgxV6er3aoMtzF76/Fi
        t2q55yFmSHRWyVnmoiRGvCrg2Azrd3GTzkhJjIgMGsnr5/nYjRrizmyo/m9EDVPC
        mYrFbLRkk5hLoh5/kS7cJx+lH6iQSOza1g6WsrKaeJyR4FxmozB6aw0rNa8p6mCr
        Z0DwDEy4pH/xmLCPr6nMIUAE4b+Bs5tTxxy1hzAmDDPR98Qq3IzpLvFAggeLlDNa
        VpcAPsdJaQENSlRHBEUydUGaSTndh5bRjSIWG3Pm5yR2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1702044037; x=1702130437; bh=I5hSfWoT/zaxbWvskG0G8aAPc/U4gJg60vn
        p4mri/nE=; b=28pTMl+8m6bhj8Qile4f1RfTnE0j8XrMz/m3yeTh9aIkQ7tAmgN
        LIz193w37P520oAufG74yb0yL22Cdfypdd0SDoBwxvwc1oIcGE+uL4cl88t0e3vc
        QNp69Nt2Ejjh5BD1qUEz58gjUZtd0XD2+2g/yvW9VoJm28AbwNnM+uDN3EZGQn3W
        DDf1To3Ev4/JFjGqvjQ524FiQknq+adclK9xBaDlyVqmmWcgXViSJXTjqWh/UETC
        nY0+Z34AjqPzGJBwrIMuLNVzpf28XcNQMVsNW+1A6fIwgoZ5jtPxbrydNMZZZfeY
        hzFxHKXpDPB2EGGtGducGkRnZ/minQjQtQg==
X-ME-Sender: <xms:hCFzZRguWSPoVVuXRHDE0aO3o_EDGXM2sXlomj_cC8Uz7WES1XlWJg>
    <xme:hCFzZWBMeMIRlJ18_YU0lAgB6aOI1rAv1PZ03QHo5PBGD38LndYtZZIs6rxy_8iGK
    BLWq9OerifTYGbXl38>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudekiedgiedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkfffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepleetleeghfdvjeeugfeiteekheetvefgvdekieffudejgfehudegfeejuedtgfeg
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghdplhhinhgrrhhordhorhhgpdhgihhthh
    husgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:hCFzZREdt4EG8M5-nY6eLjKdFdUwsZ75qzueUOl1HS4TBPWwPI6Qzg>
    <xmx:hCFzZWQSpI14_4YBpQgBsLJfrKax_wq1rwwcHfA-L0Cn5U01hM5uxw>
    <xmx:hCFzZexw1Z-ChCIjTqO2xkiPaBjnMxuVvYV6wxkUFxgZobAC1WEUsQ>
    <xmx:hSFzZYvPZIfWwtKV5rrSbar4yLzvQ-okd4ty-EfHVJcKn9a_cYosyQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 7AB3FB6008D; Fri,  8 Dec 2023 09:00:36 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1178-geeaf0069a7-fm-20231114.001-geeaf0069
MIME-Version: 1.0
Message-Id: <90aa3b5f-a0d4-4609-85c2-e3d4cc944102@app.fastmail.com>
Date:   Fri, 08 Dec 2023 14:59:56 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     soc@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, imx@lists.linux.dev,
        linux-rockchip@lists.infradead.org
Subject: [GIT PULL] ARM: SoC fixes for v6.7
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 2cc14f52aeb78ce3f29677c2de1f06c0e91471ab:

  Linux 6.7-rc3 (2023-11-26 19:59:33 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-fixes-6.7-1

for you to fetch changes up to fd1e5745f87a9e06974d2f42d22b3e1682c99105:

  Merge tag 'v6.7-rockchip-dtsfixes1' of git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip into arm/fixes (2023-12-08 08:36:25 +0100)

----------------------------------------------------------------
ARM: SoC fixes for v6.7

Most of the changes are devicetree fixes for NXP, Mediatek, Rockchips
Arm machines as well as Microchip RISC-V, and most of these address
build-time warnings for spec violations and other minor issues. One of
the Mediatek warnings was enabled by default and prevented a clean build.
The ones that address serious runtime issues are all on the i.MX platform:

 - a boot time panic on imx8qm
 - USB hanging under load on imx8
 - regressions on the imx93 ethernet phy

Code fixes include a minor error handling for the i.MX PMU driver, and
a number of firmware driver fixes:

 - OP-TEE fix for supplicant based device enumeration, and a new
   sysfs attribute to needed to fix a race against userspace

 - Arm SCMI fix for possible truncation/overflow in the frequency
   computations

 - Multiple FF-A fixes for the newly added notification support.

----------------------------------------------------------------
Ahmad Fatoum (1):
      MAINTAINERS: reinstate freescale ARM64 DT directory in i.MX entry

Alex Bee (2):
      arm64: dts: rockchip: Expand reg size of vdec node for RK3399
      ARM: dts: rockchip: Fix sdmmc_pwren's pinmux setting for RK3128

Alexander Stein (4):
      arm64: dt: imx93: tqma9352-mba93xxla: Fix LPUART2 pad config
      dt-bindings: pwm: imx-pwm: Unify #pwm-cells for all compatibles
      arm64: dts: freescale: imx8-ss-lsio: Fix #pwm-cells
      arm64: dts: freescale: imx8-ss-dma: Fix #pwm-cells

AngeloGioacchino Del Regno (7):
      arm64: dts: mediatek: mt8195: Fix PM suspend/resume with venc clocks
      arm64: dts: mediatek: mt8183: Fix unit address for scp reserved memory
      arm64: dts: mediatek: mt8183-evb: Fix unit_address_vs_reg warning on ntc
      arm64: dts: mediatek: mt8173-evb: Fix regulator-fixed node names
      arm64: dts: mediatek: mt8183: Move thermal-zones to the root node
      arm64: dts: mediatek: mt8186: Change gpu speedbin nvmem cell name
      arm64: dts: mediatek: cherry: Fix interrupt cells for MT6360 on I2C7

Arnd Bergmann (8):
      Merge tag 'optee-supplicant-fix-for-v6.7' of git://git.linaro.org:/people/jens.wiklander/linux-tee into arm/fixes
      Merge tag 'mtk-dts64-fixes-for-6.7' of git://git.kernel.org/pub/scm/linux/kernel/git/mediatek/linux into arm/fixes
      Merge tag 'riscv-dt-fixes-for-v6.7-rc4' of https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux into arm/fixes
      Merge tag 'scmi-fixes-6.7' of git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into arm/fixes
      Merge tag 'arm-soc/for-6.7/devicetree-fixes' of https://github.com/Broadcom/stblinux into arm/fixes
      Merge tag 'ffa-fixes-6.7' of git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into arm/fixes
      Merge tag 'imx-fixes-6.7' of git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into arm/fixes
      Merge tag 'v6.7-rockchip-dtsfixes1' of git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip into arm/fixes

Chester Lin (1):
      MAINTAINERS: change the S32G2 maintainer's email address.

Conor Dooley (2):
      riscv: dts: sophgo: remove address-cells from intc node
      riscv: dts: microchip: move timebase-frequency to mpfs.dtsi

Eric Woudstra (1):
      arm64: dts: mt7986: fix emmc hs400 mode without uboot initialization

Eugen Hristev (3):
      arm64: dts: mediatek: mt8186: fix clock names for power domains
      arm64: dts: mediatek: mt7622: fix memory node warning check
      arm64: dts: mediatek: mt8183-kukui-jacuzzi: fix dsi unnecessary cells properties

Fabio Estevam (2):
      ARM: dts: imx6ul-pico: Describe the Ethernet PHY clock
      ARM: dts: imx28-xea: Pass the 'model' property

Frank Wunderlich (2):
      arm64: dts: mt7986: define 3W max power to both SFP on BPI-R3
      arm64: dts: mt7986: change cooling trips

Haibo Chen (2):
      arm64: dts: imx93: update gpio node name to align with register address
      arm64: dts: imx8ulp: update gpio node name to align with register address

Heiko Stuebner (2):
      arm64: dts: rockchip: fix rk356x pcie msg interrupt name
      arm64: dts: rockchip: drop interrupt-names property from rk3588s dfi

Hsin-Yi Wang (1):
      arm64: dts: mt8183: kukui: Fix underscores in node names

Jonas Karlman (1):
      arm64: dts: rockchip: Expand reg size of vdec node for RK3328

Krzysztof Kozlowski (2):
      ARM: dts: rockchip: minor whitespace cleanup around '='
      arm64: dts: rockchip: minor whitespace cleanup around '='

Kunwu Chan (1):
      ARM: imx: Check return value of devm_kasprintf in imx_mmdc_perf_init

Lorenzo Pieralisi (1):
      firmware: arm_ffa: Fix ffa_notification_info_get() IDs handling

Nathan Rossi (1):
      arm64: dts: imx8mp: imx8mq: Add parkmode-disable-ss-quirk on DWC3

Peng Fan (1):
      arm64: dts: imx93: correct mediamix power

Philipp Zabel (1):
      ARM: dts: imx7: Declare timers compatible with fsl,imx6dl-gpt

Rob Herring (1):
      arm64: dts: rockchip: Fix PCI node addresses on rk3399-gru

Sam Edwards (2):
      arm64: dts: rockchip: Fix Turing RK1 interrupt pinctrls
      arm64: dts: rockchip: Fix eMMC Data Strobe PD on rk3588

Sascha Hauer (1):
      dt-bindings: soc: rockchip: grf: add rockchip,rk3588-pmugrf

Stefan Eichenberger (1):
      arm64: dts: imx8-apalis: set wifi regulator to always-on

Stefan Kerkmann (1):
      ARM: dts: imx6q: skov: fix ethernet clock regression

Stefan Wahren (1):
      ARM: dts: bcm2711-rpi-400: Fix delete-node of led_act

Sudeep Holla (8):
      firmware: arm_ffa: Declare ffa_bus_type structure in the header
      firmware: arm_ffa: Allow FF-A initialisation even when notification fails
      firmware: arm_ffa: Setup the partitions after the notification initialisation
      firmware: arm_ffa: Add checks for the notification enabled state
      firmware: arm_ffa: Fix FFA notifications cleanup path
      firmware: arm_ffa: Fix the size of the allocation in ffa_partitions_cleanup()
      firmware: arm_scmi: Fix frequency truncation by promoting multiplier type
      firmware: arm_scmi: Fix possible frequency truncation when using level indexing mode

Sumit Garg (1):
      tee: optee: Fix supplicant based device enumeration

Xiaolei Wang (1):
      arm64: dts: imx8qm: Add imx8qm's own pm to avoid panic during startup

 Documentation/ABI/testing/sysfs-bus-optee-devices  |   9 +
 Documentation/devicetree/bindings/pwm/imx-pwm.yaml |  10 +-
 .../devicetree/bindings/soc/rockchip/grf.yaml      |   1 +
 MAINTAINERS                                        |   3 +-
 arch/arm/boot/dts/broadcom/bcm2711-rpi-400.dts     |   4 +-
 .../dts/nxp/imx/imx6q-skov-reve-mi1010ait-1cp1.dts |   4 +-
 arch/arm/boot/dts/nxp/imx/imx6ul-pico.dtsi         |   2 +
 arch/arm/boot/dts/nxp/imx/imx7s.dtsi               |   8 +-
 arch/arm/boot/dts/nxp/mxs/imx28-xea.dts            |   1 +
 arch/arm/boot/dts/rockchip/rk3128.dtsi             |   2 +-
 arch/arm/boot/dts/rockchip/rk322x.dtsi             |   6 +-
 arch/arm/mach-imx/mmdc.c                           |   7 +-
 .../arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi |   5 +-
 arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi     |   2 +-
 arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi    |   8 +-
 arch/arm64/boot/dts/freescale/imx8mp.dtsi          |   2 +
 arch/arm64/boot/dts/freescale/imx8mq.dtsi          |   2 +
 arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi   |  11 +
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi         |   6 +-
 .../dts/freescale/imx93-tqma9352-mba93xxla.dts     |   2 +-
 arch/arm64/boot/dts/freescale/imx93.dtsi           |  10 +-
 .../boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts  |   2 +-
 arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts       |   2 +-
 .../boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts  |  12 +-
 arch/arm64/boot/dts/mediatek/mt7986a.dtsi          |  24 +-
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts        |   4 +-
 arch/arm64/boot/dts/mediatek/mt8183-evb.dts        |   4 +-
 .../boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi    |   8 +-
 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi     |  96 ++++----
 arch/arm64/boot/dts/mediatek/mt8183.dtsi           | 242 ++++++++++-----------
 arch/arm64/boot/dts/mediatek/mt8186.dtsi           |  44 ++--
 arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi    |   2 +-
 arch/arm64/boot/dts/mediatek/mt8195.dtsi           |   6 +-
 .../boot/dts/rockchip/px30-ringneck-haikou.dts     |   2 +-
 arch/arm64/boot/dts/rockchip/rk3328.dtsi           |   2 +-
 .../boot/dts/rockchip/rk3399-gru-chromebook.dtsi   |   3 +-
 .../boot/dts/rockchip/rk3399-gru-scarlet-dumo.dts  |   4 +-
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi       |   1 +
 arch/arm64/boot/dts/rockchip/rk3399.dtsi           |   6 +-
 arch/arm64/boot/dts/rockchip/rk356x.dtsi           |   2 +-
 .../arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi |   4 +-
 .../arm64/boot/dts/rockchip/rk3588s-orangepi-5.dts |   2 +-
 arch/arm64/boot/dts/rockchip/rk3588s-pinctrl.dtsi  |   2 +-
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi          |   1 -
 arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts  |   7 -
 arch/riscv/boot/dts/microchip/mpfs-m100pfsevp.dts  |   7 -
 arch/riscv/boot/dts/microchip/mpfs-polarberry.dts  |   7 -
 arch/riscv/boot/dts/microchip/mpfs-sev-kit.dts     |   7 -
 arch/riscv/boot/dts/microchip/mpfs-tysom-m.dts     |   7 -
 arch/riscv/boot/dts/microchip/mpfs.dtsi            |   1 +
 arch/riscv/boot/dts/sophgo/cv1800b.dtsi            |   1 -
 drivers/firmware/arm_ffa/driver.c                  |  70 ++++--
 drivers/firmware/arm_scmi/perf.c                   |  18 +-
 drivers/tee/optee/device.c                         |  17 +-
 include/linux/arm_ffa.h                            |   2 +
 55 files changed, 396 insertions(+), 328 deletions(-)
