Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 903E378CEFE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 23:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235477AbjH2VyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 17:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238307AbjH2Vxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 17:53:55 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031F5CC0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 14:53:51 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 358D13200392;
        Tue, 29 Aug 2023 17:53:50 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 29 Aug 2023 17:53:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1693346029; x=1693432429; bh=Xy
        tUMNO6Nx0J9oyRHVnHwj7arOSWVb+wB9num03DTDc=; b=vnI9QVitcS3IIGJ1xd
        1GkbJO5hMTtaIO/cqAvevvqoMQkd90F6fMuktZXHEcfd4wxsCVkl+wgNagzNn/h8
        konQiaNBek/Wuoi1dhFL+CczIxZvkAg36dWB8QTcMKDbZFHBWLa4yHIL5Cg1YvV0
        GsygGuU4OqZgEeGW7dLtqlPnGPZCgLxjHm/ny0b7ZqZzpjTqgQL+Vx1HvsG6GBzy
        mOHrADHyW1kfSA5hpAZluKCBmRD331fPmS4IohEg6R9r0eWNs3jGJZb8sTJbZg7a
        Z3boWTyS3sCcu9+xjhMcRNINmtkrEsHfVCTdzH5Pq7aXCHl9+cNOKtCuLf0p6YsU
        Xpjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1693346029; x=1693432429; bh=XytUMNO6Nx0J9
        oyRHVnHwj7arOSWVb+wB9num03DTDc=; b=ce9v8sQJfau9HqCwDHCaDc1wKSheo
        X0/DnGVo6ByvQsoP1kiKeLVqQvsnElOQeI98bcZPmS1JUd+B6An2/5zNWeO9lALv
        NpEOVZfd1jkf6ESAxkDeB0MKxDxfxlOGWLZEUy7kI6CxTujE1qmgDTH35CAitnpa
        O33IrrlIhmSP2Sf+0tXXkuidTXhY7U4wl7tn77I0HQwmaCJ9XyEiV1WQCPCT4Ojb
        fhfcN94CmKoXHsrMxlU9krTDLLvu1zvsmOMjWWO+nPy6xtcWxBDaOl3BYUKLLJnw
        Zo2pq38oOr2jcOi9UggccY1wKtf1l4cfIURvMNaIJZSUYKJVAA2yJYzkQ==
X-ME-Sender: <xms:7WjuZOG-BIWRalWdH4U6kk1jpnpxXMJKxQhML5jhRROGZgOI5VeOhg>
    <xme:7WjuZPWH5UOJJNLm9zqP3USzI-sHFlHpuKlT1agD0-U4huAYRCvDJSQWoWxj-_Qno
    uY13qenb9qAzcOqDM4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudefjedgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepieeguedvkeehveduieetgedugfejheeugffhtedtvdetueetkefhheduhfet
    gfdvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpghhithhhuhgsrdgtohhmnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegr
    rhhnuggsrdguvg
X-ME-Proxy: <xmx:7WjuZIJZHeRRCmt0E1fvaTo_R4f6PyzgRpRP1cIc8HFdh38syoh9Rw>
    <xmx:7WjuZIFUpQMU1_akLPcM8yTNkcwq55iIMVfv-wsbZRNXkRKfkJ3qCQ>
    <xmx:7WjuZEWlgBi0-4b_Up3ZCPC7exKoz99Xp6AssrFwrjTqDgO33cHFKw>
    <xmx:7WjuZPcOyJiIKFHVXJ2LnzXnP8AFbArzkfRUBL5Id9OEiJ_P_n-UAA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 79169B60089; Tue, 29 Aug 2023 17:53:49 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-701-g9b2f44d3ee-fm-20230823.001-g9b2f44d3
Mime-Version: 1.0
Message-Id: <de2a0d53-a35f-490d-82a7-864493af6687@app.fastmail.com>
In-Reply-To: <4f60d13e-f060-491a-88c7-6f25323a48f8@app.fastmail.com>
References: <4f60d13e-f060-491a-88c7-6f25323a48f8@app.fastmail.com>
Date:   Tue, 29 Aug 2023 17:53:21 -0400
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        soc@kernel.org
Subject: [GIT PULL 3/4] ARM: SoC cleanups for 6.6
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit fdf0eaf11452d72945af31804e2a1048ee1b574c:

  Linux 6.5-rc2 (2023-07-16 15:10:37 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-arm-6.6

for you to fetch changes up to 6e73bd23a1cdcf1416ebd57ff673b5f601963ed2:

  ARM: davinci: Drop unused includes (2023-08-29 16:01:32 -0400)

----------------------------------------------------------------
ARM: SoC cleanups for 6.6

These are all minor cleanups for platform specific code in arch/arm/
and some of the associated drivers. The majority of these are work
done by Rob Herring to improve the way devicetreee header files
are handled.

----------------------------------------------------------------
Andreas Kemnade (1):
      MAINTAINERS: add board bindings list to OMAP2+ files

Andrew Davis (4):
      ARM: keystone: Merge memory.h into the only file that uses it
      ARM: keystone: Merge PM function into main support file
      ARM: nspire: Use syscon-reboot to handle restart
      ARM: nspire: Remove unused header file mmio.h

Arnd Bergmann (11):
      Merge tag 'at91-soc-6.6' of https://git.kernel.org/pub/scm/linux/kernel/git/at91/linux into soc/arm
      Merge tag 'amlogic-arm-mach-for-v6.6' of https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux into soc/arm
      Merge tag 'omap-for-v6.6/soc-signed' of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap into soc/arm
      Merge tag 'renesas-arm-soc-for-v6.6-tag1' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel into soc/arm
      Merge tag 'hisi-arm-soc-for-6.6' of https://github.com/hisilicon/linux-hisi into soc/arm
      Merge tag 'omap-for-v6.6/maintainers-signed' of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap into soc/arm
      Merge tag 'mvebu-arm-6.6-1' of git://git.kernel.org/pub/scm/linux/kernel/git/gclement/mvebu into soc/arm
      Merge tag 'imx-soc-6.6' of git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into soc/arm
      Merge tag 'ti-keystone-soc-for-v6.6' of https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux into soc/arm
      Merge tag 'arm-soc/for-6.6/soc' of https://github.com/Broadcom/stblinux into soc/arm
      Merge tag 'socfpga_update_for_v6.6' of git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux into soc/arm

Gustavo A. R. Silva (1):
      ARM: OMAP2+: Fix -Warray-bounds warning in _pwrdm_state_switch()

Krzysztof Kozlowski (4):
      MAINTAINERS: soc: reference maintainer profile
      Documentation/process: maintainer-soc: add clean platforms profile
      MAINTAINER: samsung: document dtbs_check requirement for Samsung
      Documentation/process: maintainer-soc: document dtbs_check requirement for Samsung

Rob Herring (38):
      ARM: omap2: Use of_range_to_resource() for "ranges" parsing
      ARM: hisi: Drop unused includes
      ARM: imx: Drop unused includes
      ARM: socfpga: Explicitly include correct DT includes
      ARM: bcm: Drop unused includes
      ARM: shmobile: rcar-gen2: Drop unused OF includes
      ARM: keystone: Drop unused includes
      soc: microchip: Explicitly include correct DT includes
      ARM: at91: Explicitly include correct DT includes
      ARM: omap2: Explicitly include correct DT includes
      ARM: meson: Drop unused includes
      ARM: l2x0: Add explicit includes for init and types
      ARM: sti: Drop unused includes
      ARM: alpine: Drop unused includes
      ARM: berlin: Drop unused includes
      ARM: dove: Drop unused includes
      ARM: hpe: Drop unused includes
      ARM: mmp: Drop unused includes
      ARM: nomadik: Drop unused includes
      ARM: npcm: Drop unused includes
      ARM: nspire: Drop unused includes
      ARM: pxa: Drop unused includes
      ARM: rockchip: Drop unused includes
      ARM: versatile: Drop unused includes
      ARM: mvebu: Explicitly include correct DT includes
      ARM: spear: Explicitly include correct DT includes
      bus: Explicitly include correct DT includes
      firmware: Explicitly include correct DT includes
      soc: aspeed: Explicitly include correct DT includes
      soc: mediatek: Explicitly include correct DT includes
      soc: rockchip: Explicitly include correct DT includes
      soc: sunxi: Explicitly include correct DT includes
      soc: xilinx: Explicitly include correct DT includes
      soc: fsl: Explicitly include correct DT includes
      ARM: mvebu: Explicitly include correct DT includes
      ARM: dove: Drop unused includes
      ARM: s5pv210: Explicitly include correct DT includes
      ARM: davinci: Drop unused includes

Tony Lindgren (1):
      Merge branch 'omap-for-v6.5/cleanup' into omap-for-v6.6/soc

YueHaibing (1):
      ARM: at91: Remove unused extern declarations

 Documentation/process/maintainer-handbooks.rst     |  1 +
 Documentation/process/maintainer-soc-clean-dts.rst | 25 +++++++++++
 Documentation/process/maintainer-soc.rst           |  4 +-
 MAINTAINERS                                        |  5 ++-
 arch/arm/include/asm/hardware/cache-l2x0.h         |  2 +
 arch/arm/mach-alpine/alpine_machine.c              |  2 -
 arch/arm/mach-at91/pm.c                            |  1 +
 arch/arm/mach-at91/samv7.c                         |  7 ---
 arch/arm/mach-bcm/bcm_5301x.c                      |  2 -
 arch/arm/mach-bcm/board_bcm23550.c                 |  2 -
 arch/arm/mach-bcm/brcmstb.c                        |  1 -
 arch/arm/mach-bcm/platsmp-brcmstb.c                |  2 +-
 arch/arm/mach-berlin/berlin.c                      |  5 ---
 arch/arm/mach-davinci/pdata-quirks.c               |  2 +-
 arch/arm/mach-dove/common.c                        |  2 -
 arch/arm/mach-hisi/hotplug.c                       |  1 -
 arch/arm/mach-hpe/gxp.c                            |  1 -
 arch/arm/mach-imx/mach-imx1.c                      |  4 --
 arch/arm/mach-imx/mach-imx25.c                     |  5 ---
 arch/arm/mach-imx/mach-imx27.c                     |  6 ---
 arch/arm/mach-imx/mach-imx35.c                     |  8 ----
 arch/arm/mach-imx/mach-imx50.c                     |  1 -
 arch/arm/mach-imx/mach-imx51.c                     |  5 +--
 arch/arm/mach-imx/mach-imx53.c                     |  8 ----
 arch/arm/mach-imx/mach-imx6sx.c                    |  2 -
 arch/arm/mach-imx/mach-imx6ul.c                    |  4 --
 arch/arm/mach-imx/mach-imx7d.c                     |  2 +-
 arch/arm/mach-imx/pm-imx5.c                        |  1 +
 arch/arm/mach-imx/pm-imx6.c                        |  1 +
 arch/arm/mach-keystone/Makefile                    |  3 --
 arch/arm/mach-keystone/keystone.c                  | 50 +++++++++++++++++++---
 arch/arm/mach-keystone/keystone.h                  | 16 -------
 arch/arm/mach-keystone/memory.h                    | 18 --------
 arch/arm/mach-keystone/pm_domain.c                 | 50 ----------------------
 arch/arm/mach-meson/meson.c                        |  1 -
 arch/arm/mach-mmp/mmp-dt.c                         |  3 --
 arch/arm/mach-mmp/mmp2-dt.c                        |  4 --
 arch/arm/mach-mmp/mmp3.c                           |  4 --
 arch/arm/mach-mvebu/kirkwood.c                     |  1 +
 arch/arm/mach-mvebu/pmsu.c                         |  2 +-
 arch/arm/mach-nomadik/cpu-8815.c                   | 13 ------
 arch/arm/mach-npcm/platsmp.c                       |  3 --
 arch/arm/mach-nspire/Kconfig                       |  2 +
 arch/arm/mach-nspire/mmio.h                        | 16 -------
 arch/arm/mach-nspire/nspire.c                      | 24 -----------
 arch/arm/mach-omap2/board-generic.c                |  3 +-
 arch/arm/mach-omap2/omap4-common.c                 |  3 +-
 arch/arm/mach-omap2/omap_hwmod.c                   | 45 +++----------------
 arch/arm/mach-omap2/powerdomain.c                  |  2 +-
 arch/arm/mach-pxa/pxa-dt.c                         |  6 ---
 arch/arm/mach-rockchip/rockchip.c                  |  6 +--
 arch/arm/mach-s5pv210/s5pv210.c                    |  2 +-
 arch/arm/mach-shmobile/setup-rcar-gen2.c           |  1 -
 arch/arm/mach-socfpga/l2_cache.c                   |  2 +-
 arch/arm/mach-socfpga/ocram.c                      |  4 +-
 arch/arm/mach-socfpga/pm.c                         |  2 +
 arch/arm/mach-socfpga/socfpga.c                    |  4 +-
 arch/arm/mach-spear/spear1340.c                    |  2 +-
 arch/arm/mach-sti/board-dt.c                       |  2 -
 arch/arm/mach-versatile/realview.c                 |  2 -
 drivers/bus/fsl-mc/fsl-mc-bus.c                    |  1 +
 drivers/bus/fsl-mc/fsl-mc-msi.c                    |  2 -
 drivers/bus/hisi_lpc.c                             |  2 +-
 drivers/bus/omap_l3_smx.c                          |  1 -
 drivers/bus/simple-pm-bus.c                        |  2 +
 drivers/bus/sunxi-rsb.c                            |  2 +-
 drivers/bus/ti-pwmss.c                             |  2 +-
 drivers/firmware/arm_scmi/driver.c                 |  4 +-
 drivers/firmware/imx/imx-dsp.c                     |  1 -
 drivers/firmware/imx/imx-scu-irq.c                 |  1 +
 drivers/firmware/imx/imx-scu.c                     |  1 +
 drivers/firmware/mtk-adsp-ipc.c                    |  1 -
 drivers/firmware/raspberrypi.c                     |  1 +
 drivers/firmware/scpi_pm_domain.c                  |  3 +-
 drivers/firmware/stratix10-rsu.c                   |  1 -
 drivers/firmware/tegra/bpmp.c                      |  3 +-
 drivers/firmware/xilinx/zynqmp.c                   |  1 +
 drivers/soc/aspeed/aspeed-lpc-snoop.c              |  1 -
 drivers/soc/aspeed/aspeed-p2a-ctrl.c               |  2 +-
 drivers/soc/aspeed/aspeed-uart-routing.c           |  3 +-
 drivers/soc/atmel/sfr.c                            |  1 -
 drivers/soc/fsl/dpaa2-console.c                    |  3 +-
 drivers/soc/fsl/qe/qe.c                            |  3 +-
 drivers/soc/fsl/qe/qe_common.c                     |  1 -
 drivers/soc/fsl/qe/qe_tdm.c                        |  4 +-
 drivers/soc/mediatek/mtk-cmdq-helper.c             |  1 +
 drivers/soc/mediatek/mtk-devapc.c                  |  2 +-
 drivers/soc/mediatek/mtk-mmsys.c                   |  2 +-
 drivers/soc/mediatek/mtk-mutex.c                   |  3 +-
 drivers/soc/mediatek/mtk-pmic-wrap.c               |  3 +-
 drivers/soc/microchip/mpfs-sys-controller.c        |  2 +-
 drivers/soc/rockchip/grf.c                         |  2 +-
 drivers/soc/sunxi/sunxi_sram.c                     |  2 +-
 drivers/soc/xilinx/zynqmp_power.c                  |  1 +
 include/soc/at91/atmel_tcb.h                       |  3 --
 95 files changed, 139 insertions(+), 337 deletions(-)
 create mode 100644 Documentation/process/maintainer-soc-clean-dts.rst
 delete mode 100644 arch/arm/mach-keystone/keystone.h
 delete mode 100644 arch/arm/mach-keystone/memory.h
 delete mode 100644 arch/arm/mach-keystone/pm_domain.c
 delete mode 100644 arch/arm/mach-nspire/mmio.h
