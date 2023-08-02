Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4357B76D9E8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 23:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjHBVqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 17:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233825AbjHBVq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 17:46:27 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B59F3C16
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 14:45:48 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id E580D320094B;
        Wed,  2 Aug 2023 17:45:21 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 02 Aug 2023 17:45:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1691012721; x=1691099121; bh=nrDUul9s+Xc2ezrXax9eJBefw
        xjtR0hydvEijJvR3e4=; b=pKYI0pvXWxmj6VgvWII084B1sMHkPCcvn79n3a77w
        GVhQlqR5Ag/ErsOdcH4up57xzMDMcRxGw1DgocP0KcxJN9tg2R0mdXmeXTQSnU+C
        Hy5DYxwsYjf0nIRMXpDKOGTpBrwWzuMUFAJISOy68l7Fo9sKiQQdsEz4eMcNdyWO
        plA/22RXX2cWYbY/QwCTMMuApabQbldsp1s+duAdGoV/OfMq6ET73wIQtLPSdNGm
        XO+FV/YQl5MRaOKka0EtmNOUfvpOi2ECsHqQr50g1TvDpnjtDyfvPVGIPZUw0BVg
        swWIBi0Hgd4qAx5vYMOVL2gUbdXFitoIQ/JlVNo8Mqn/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1691012721; x=1691099121; bh=nrDUul9s+Xc2ezrXax9eJBefwxjtR0hydvE
        ijJvR3e4=; b=JjStG0Gu9DPLoCjFP5yrFql+Ny939LVKDJcsXCvtSYUoq0t3/pI
        nUUM0CSKIsAuCSjqdu9Hd3q+UvunMPvfIgDlYfhB9WMdJQBKD51luiCz8rBQInod
        GgTN9TOlBC2CV+VGEK8USwZPaYFEdHkol4d7/TZZYz32056xLEY/AmEESy4zhnFW
        KmIuS4wB+e/hdRlsGa1Ob6acetya2q6omOjTntJI4AKB3jKFRXtezL9XV4FXSB4h
        JO/yZgEo1tVtFqFaZ0wbp/uwlmrDI9d+dzSLibifoSL4ATBdOKAFnikJ0b1SifX6
        DDULJ3f8JV/XuJNH0mKjlsvJ55+PYjvSVEQ==
X-ME-Sender: <xms:cM7KZNZmkwaGO3hi5AAoAgxRAQ4MYy9BpUDG36fhLfAh5K_XcuyQ_Q>
    <xme:cM7KZEYpZeTbyiPjS-qr0iB8rRIseyEpjtYibrX5s1ONbE7v7NNE9Q21Vr6k-2ubs
    sFRYOv7YMykl6a3QYg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrkedugddtudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpeeffeeuhfekjeevtddvtdelledttddtjeegvdfhtdduvdfhueekudeihfejtefgieen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:cM7KZP_OD9ooC6SgVvG3w94YpiY9SBv67Ywxns2ouomHiMP1sNX-Cw>
    <xmx:cM7KZLqoq0aqsGMvgDBv0QfvwselpNbqRqKbJJ9enAfZegOWpAc1EA>
    <xmx:cM7KZIq3aWRlBK6ujvjqBvF8COBHcNLbUuS6Bwu0VQvTk7gE0wbrVw>
    <xmx:cc7KZFBRJb6Q1lKcay_DQcpfUUnJEr6mASkJiNZ7TIdNsx_fxmlv5w>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 69EB3B60089; Wed,  2 Aug 2023 17:45:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-624-g7714e4406d-fm-20230801.001-g7714e440
Mime-Version: 1.0
Message-Id: <b547178f-fe00-4270-bcc8-98131fc5e0b6@app.fastmail.com>
Date:   Wed, 02 Aug 2023 23:44:58 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     soc@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] ARM: SoC fixes for 6.5, part 2
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit fdf0eaf11452d72945af31804e2a1048ee1b574c:

  Linux 6.5-rc2 (2023-07-16 15:10:37 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-fixes-6.5-2

for you to fetch changes up to d21afb098c510739a2f5dd27aed5d3198816d8dc:

  Merge tag 'socfpga_dts_fix_for_v6.5' of git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux into arm/fixes (2023-07-27 15:44:03 +0200)

----------------------------------------------------------------
ARM: SoC fixes for 6.5, part 2

A couple of platforms get a lone dts fix each:

 - SoCFPGA: Fix incorrect I2C property for SCL signal

 - Renesas: Fix interrupt names for MTU3 channels on RZ/G2L and RZ/V2L.

 - Juno/Vexpress: remove a dangling symlink

 - at91: sam9x60 SoC detection compatible strings

 - nspire: Fix arm primecell compatible string

On the NXP i.MX platform, there multiple issues that get addressed:

 - A couple of ARM DTS fixes for i.MX6SLL usbphy and supported CPU
   frequency of sk-imx53 board

 - Add missing pull-up for imx8mn-var-som onboard PHY reset pinmux

 - A couple of imx8mm-venice fixes from Tim Harvey to diable disp_blk_ctrl

 - A couple of phycore-imx8mm fixes from Yashwanth Varakala to correct
   VPU label and gpio-line-names

 - Fix imx8mp-blk-ctrl driver to register HSIO PLL clock as bus_power_dev
   child, so that runtime PM can translate into the necessary GPC power
   domain action

On the driver side, there are two fixes for tegra memory controller
drivers addressing regressions from the merge window, a couple of
minor correctness fixes for SCMI and SMCCC firmware, as well as
a build fix for an lcd backlight driver.

----------------------------------------------------------------
Arnd Bergmann (7):
      Merge tag 'juno-fix-6.5' of git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into arm/fixes
      Merge tag 'scmi-smccc-fixes-6.5' of git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into arm/fixes
      backlight: corgi_lcd: fix missing prototype
      Merge tag 'imx-fixes-6.5' of git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into arm/fixes
      Merge tag 'memory-controller-drv-fixes-6.5' of https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl into arm/fixes
      Merge tag 'renesas-fixes-for-v6.5-tag1' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel into arm/fixes
      Merge tag 'socfpga_dts_fix_for_v6.5' of git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux into arm/fixes

Benjamin Gaignard (1):
      arm64: dts: freescale: Fix VPU G2 clock

Biju Das (1):
      arm64: dts: renesas: rzg2l: Update overfow/underflow IRQ names for MTU3 channels

Cristian Marussi (1):
      firmware: arm_scmi: Fix chan_free cleanup on SMC

Dinh Nguyen (1):
      arm64: dts: stratix10: fix incorrect I2C property for SCL signal

Dmitry Baryshkov (1):
      ARM: dts: nxp/imx: limit sk-imx53 supported frequencies

Durai Manickam KR (2):
      ARM: dts: at91: sam9x60: fix the SOC detection
      dt-bindings: serial: atmel,at91-usart: update compatible for sam9x60

Hugo Villeneuve (1):
      arm64: dts: imx8mn-var-som: add missing pull-up for onboard PHY reset pinmux

Krzysztof Kozlowski (1):
      firmware: arm_scmi: Drop OF node reference in the transport channel setup

Lucas Stach (1):
      soc: imx: imx8mp-blk-ctrl: register HSIO PLL clock as bus_power_dev child

Punit Agrawal (1):
      firmware: smccc: Fix use of uninitialised results structure

Sudeep Holla (2):
      arm64: dts: arm: Remove the dangling vexpress-v2m-rs1.dtsi symlink
      ARM: dts: nspire: Fix arm primecell compatible string

Sukrut Bellary (1):
      firmware: arm_scmi: Fix signed error return values handling

Sumit Gupta (1):
      memory: tegra: make icc_set_bw return zero if BWMGR not supported

Thierry Reding (1):
      memory: tegra: Add dummy implementation on Tegra194

Tim Harvey (2):
      arm64: dts: imx8mm-venice-gw7903: disable disp_blk_ctrl
      arm64: dts: imx8mm-venice-gw7904: disable disp_blk_ctrl

Xu Yang (1):
      ARM: dts: nxp/imx6sll: fix wrong property name in usbphy node

Yashwanth Varakala (2):
      arm64: dts: phycore-imx8mm: Label typo-fix of VPU
      arm64: dts: phycore-imx8mm: Correction in gpio-line-names

 .../bindings/serial/atmel,at91-usart.yaml          |  4 ++-
 arch/arm/boot/dts/microchip/sam9x60.dtsi           | 26 +++++++--------
 arch/arm/boot/dts/nspire/nspire.dtsi               |  2 +-
 arch/arm/boot/dts/nxp/imx/imx53-sk-imx53.dts       | 10 ++++++
 arch/arm/boot/dts/nxp/imx/imx6sll.dtsi             |  2 +-
 arch/arm/mach-pxa/sharpsl_pm.h                     |  1 -
 arch/arm/mach-pxa/spitz_pm.c                       |  1 +
 .../boot/dts/altera/socfpga_stratix10_socdk.dts    |  2 +-
 .../dts/altera/socfpga_stratix10_socdk_nand.dts    |  2 +-
 arch/arm64/boot/dts/arm/vexpress-v2m-rs1.dtsi      |  1 -
 .../dts/freescale/imx8mm-phyboard-polis-rdk.dts    |  2 +-
 .../boot/dts/freescale/imx8mm-phycore-som.dtsi     |  4 +--
 .../boot/dts/freescale/imx8mm-venice-gw7903.dts    |  4 +++
 .../boot/dts/freescale/imx8mm-venice-gw7904.dts    |  4 +++
 arch/arm64/boot/dts/freescale/imx8mn-var-som.dtsi  |  2 +-
 arch/arm64/boot/dts/freescale/imx8mq.dtsi          |  2 +-
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi         | 16 +++++-----
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi         | 16 +++++-----
 drivers/firmware/arm_scmi/mailbox.c                |  4 ++-
 drivers/firmware/arm_scmi/raw_mode.c               |  5 ++-
 drivers/firmware/arm_scmi/smc.c                    | 21 ++++++++----
 drivers/firmware/smccc/soc_id.c                    |  5 ++-
 drivers/memory/tegra/mc.c                          | 37 ++++++++++++++++++++++
 drivers/memory/tegra/tegra194.c                    |  1 +
 drivers/memory/tegra/tegra234.c                    | 27 ++--------------
 drivers/soc/imx/imx8mp-blk-ctrl.c                  |  2 +-
 include/linux/spi/corgi_lcd.h                      |  2 ++
 include/soc/tegra/mc.h                             |  3 ++
 28 files changed, 130 insertions(+), 78 deletions(-)
 delete mode 120000 arch/arm64/boot/dts/arm/vexpress-v2m-rs1.dtsi
