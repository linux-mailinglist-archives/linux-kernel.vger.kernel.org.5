Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42A157D85EA
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 17:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345380AbjJZPX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 11:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345446AbjJZPX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 11:23:56 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826CAAC
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 08:23:53 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id E30335C0164;
        Thu, 26 Oct 2023 11:23:50 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 26 Oct 2023 11:23:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1698333830; x=1698420230; bh=MwTU3yFRy33qVtT9Hv1gPn7tD
        VTVfIm0orJbw5AeHJU=; b=aDDmN3XW5clNQmCv4GZW5g9HBc2vGBxuj6UDiHk/Y
        Z7Hf9obqIgSfUJzQmD4MSNpGmuk/ldG7O4NDen3aN9euP0FFMqG2AqdCdZX2FLtm
        FOAR/vQ1MRod6eqytmCvTeRIWSyW1jLqQtHb2yqhlNYwqk8LpK87ikH6LcUuLeYx
        rtvSpJp5li2TN6t7x2aM3JvoZvUvEBwFaa1pfjHFp0c9HktNqcZsA1F78inSqvSE
        55t7VdSdPuw7C+AVmdBLELdGQ9b5+6DsANov8qWWIAZUpMgwTaNDsZtq8EshglyA
        LVVyDDkB5F6YYs4f9rzklm3kdWkj3/TVpAi7A5b1tvftA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1698333830; x=1698420230; bh=MwTU3yFRy33qVtT9Hv1gPn7tDVTVfIm0orJ
        bw5AeHJU=; b=rGan47d44qQnya2IZ7/4r8zXuxnIa7NiG875uuORzatZGoXoT2o
        tWn1jSK1IOxKC+7zTfzfot4A/kDb65lARWOQuPPxjF3LUNX0YvyOUV+GwHKLkjoD
        /m8U/joKXn+RsIjNBesCaARGX5lV32LBJ+yXB8paHN6RYB4sKsBGFSmrpTcBi+s5
        mqYF4MEdX25Kq1EnsJEF+dTWjeYIrfMcEGBBw57qkWBG1td58tvpSNdVCEt1W/U+
        h0EcCGk7JGypKVbj+2xfW0izaXOMxsU5CDgjLR8ATZfafPa/hrtQTVadYY+teKpv
        8pvh96czTsRy1iqq7zPr1CIOvMFUqrtt6ow==
X-ME-Sender: <xms:hoQ6ZTHXly_h_P-7DYcjjpwULZGexPy29_dC8vRwpdA90yp1TJX4ow>
    <xme:hoQ6ZQXCHtayTzct0QIeOtRoP0_2Q8X_BSiRUPpgqBLYDWHtqORGg3nhTgcNqHRIG
    kjXcCNBeYPlubflV98>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrledvgdekkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpeeffeeuhfekjeevtddvtdelledttddtjeegvdfhtdduvdfhueekudeihfejtefgieen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:hoQ6ZVJyZfd6t_Efa03HDDI9oRWl6MRGVRaQE5vyvC64lS96_vlnSQ>
    <xmx:hoQ6ZRHFYj-AqzvhTKmEgdlWYCnNMFVF78lnrk76OWFwc005XhwuJw>
    <xmx:hoQ6ZZXyCmAnWMbLLjCx2goUwyiiI2c-K0Xjiy178HTKToG5Jc0aaQ>
    <xmx:hoQ6ZWjdZ4XSIz68WqepedHcsD02pCPji3EGOmnUN4ontyZjN0y4FA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B7248B6008D; Thu, 26 Oct 2023 11:23:50 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1048-g9229b632c5-fm-20231019.001-g9229b632
MIME-Version: 1.0
Message-Id: <ecd2fc55-8135-4b70-be85-24dbc773fb70@app.fastmail.com>
Date:   Thu, 26 Oct 2023 17:23:30 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, soc@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] ARM: SoC fixes for 6.7, part 3
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 58720809f52779dc0f08e53e54b014209d13eebb:

  Linux 6.6-rc6 (2023-10-15 13:34:39 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-fixes-6.7-3

for you to fetch changes up to 736a4aad8a9fdcf577ffa33b33df240c67557af8:

  Merge tag 'renesas-fixes-for-v6.6-tag3' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel into arm/fixes (2023-10-26 17:06:42 +0200)

----------------------------------------------------------------
ARM: SoC fixes for 6.7, part 3

A couple of platforms have some last-minute fixes for 6.7, in particular

 - riscv gets some fixes for noncoherent DMA on the renesas and thead
   platforms and dts fix for SPI on the visionfive 2 board

 - Qualcomm Snapdragon gets three dts fixes to address board specific
   regressions on the pmic and gpio nodes

 - Rockchip platforms get multiple dts fixes to address issues on
   the recent rk3399 platform as well as the older rk3128 platform
   that apparently regressed a while ago.

 - TI OMAP gets some trivial code and dts fixes and a regression fix
   for the omap1 ams-delta modem

 - NXP i.MX firmware has one fix for a use-after-free but in its
   error handling.

----------------------------------------------------------------
Alex Bee (4):
      ARM: dts: rockchip: Fix i2c0 register address for RK3128
      ARM: dts: rockchip: Add missing arm timer interrupt for RK3128
      ARM: dts: rockchip: Add missing quirk for RK3128's dma engine
      ARM: dts: rockchip: Fix timer clocks for RK3128

Arnd Bergmann (8):
      Merge tag 'renesas-fixes-for-v6.6-tag2' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel into arm/fixes
      Merge tag 'imx-fixes-6.6-2' of git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into arm/fixes
      Merge tag 'qcom-arm64-fixes-for-6.6' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into arm/fixes
      Merge tag 'riscv-dt-for-v6.6-final' of https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux into arm/fixes
      Merge tag 'v6.6-rockchip-dtsfixes1' of git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip into arm/fixes
      Merge tag 'omap-fixes-audio-clock-and-modem-signed' of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap into arm/fixes
      Merge tag 'mvebu-fixes-6.6-1' of git://git.kernel.org/pub/scm/linux/kernel/git/gclement/mvebu into arm/fixes
      Merge tag 'renesas-fixes-for-v6.6-tag3' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel into arm/fixes

Christoph Hellwig (3):
      riscv: RISCV_NONSTANDARD_CACHE_OPS shouldn't depend on RISCV_DMA_NONCOHERENT
      riscv: only select DMA_DIRECT_REMAP from RISCV_ISA_ZICBOM and ERRATA_THEAD_PBMT
      soc: renesas: ARCH_R9A07G043 depends on !RISCV_ISA_ZICBOM

Christopher Obbard (2):
      arm64: dts: rockchip: Add i2s0-2ch-bus-bclk-off pins to RK3399
      arm64: dts: rockchip: Fix i2s0 pin conflict on ROCK Pi 4 boards

Conor Dooley (1):
      soc: renesas: Make ARCH_R9A07G043 depend on required options

Dan Carpenter (1):
      ARM: omap2: fix a debug printk

Ermin Sunj (1):
      arm64: dts: rockchip: use codec as clock master on px30-ringneck-haikou

Hao Ge (1):
      firmware/imx-dsp: Fix use_after_free in imx_dsp_setup_channels()

Jakob Unterwurzacher (1):
      arm64: dts: rockchip: set codec system-clock-fixed on px30-ringneck-haikou

Janusz Krzysztofik (1):
      ARM: OMAP1: ams-delta: Fix MODEM initialization failure

Jisheng Zhang (1):
      riscv: dts: thead: set dma-noncoherent to soc bus

Krzysztof Kozlowski (3):
      arm64: dts: qcom: sa8775p: correct PMIC GPIO label in gpio-ranges
      arm64: dts: qcom: apq8096-db820c: fix missing clock populate
      arm64: dts: qcom: msm8996-xiaomi: fix missing clock populate

Nam Cao (1):
      riscv: dts: starfive: visionfive 2: correct spi's ss pin

Randy Dunlap (1):
      ARM: OMAP: timer32K: fix all kernel-doc warnings

Robert Marko (2):
      MAINTAINERS: uDPU: make myself maintainer of it
      MAINTAINERS: uDPU: add remaining Methode boards

Tony Lindgren (2):
      clk: ti: Fix missing omap4 mcbsp functional clock and aliases
      clk: ti: Fix missing omap5 mcbsp functional clock and aliases

 MAINTAINERS                                        |  5 +-
 arch/arm/boot/dts/rockchip/rk3128.dtsi             | 18 ++++---
 arch/arm/boot/dts/ti/omap/omap4-l4-abe.dtsi        |  6 +++
 arch/arm/boot/dts/ti/omap/omap4-l4.dtsi            |  2 +
 arch/arm/boot/dts/ti/omap/omap5-l4-abe.dtsi        |  6 +++
 arch/arm/mach-omap1/board-ams-delta.c              | 60 ++++++----------------
 arch/arm/mach-omap1/timer32k.c                     | 14 ++---
 arch/arm/mach-omap2/omap_hwmod.c                   |  2 +-
 arch/arm64/boot/dts/qcom/apq8096-db820c.dts        | 32 ++++++------
 .../arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi | 32 ++++++------
 arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts | 18 +++----
 arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi        |  2 +-
 .../boot/dts/rockchip/px30-ringneck-haikou.dts     | 10 ++--
 arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi |  1 +
 arch/arm64/boot/dts/rockchip/rk3399.dtsi           | 10 ++++
 arch/riscv/Kconfig                                 |  3 +-
 arch/riscv/Kconfig.errata                          |  1 +
 .../dts/starfive/jh7110-starfive-visionfive-2.dtsi |  2 +-
 arch/riscv/boot/dts/thead/th1520.dtsi              |  1 +
 drivers/cache/Kconfig                              |  2 +-
 drivers/clk/ti/clk-44xx.c                          |  5 ++
 drivers/clk/ti/clk-54xx.c                          |  4 ++
 drivers/firmware/imx/imx-dsp.c                     |  2 +-
 drivers/soc/renesas/Kconfig                        | 10 ++--
 24 files changed, 128 insertions(+), 120 deletions(-)
