Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24ED780547
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 07:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357935AbjHRFB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 01:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357929AbjHRFBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 01:01:00 -0400
Received: from wnew4-smtp.messagingengine.com (wnew4-smtp.messagingengine.com [64.147.123.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113A03A8B
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 22:00:58 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailnew.west.internal (Postfix) with ESMTP id A18292B0015F;
        Fri, 18 Aug 2023 01:00:56 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 18 Aug 2023 01:00:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1692334856; x=1692342056; bh=WfCGHYhjMYO9OhsC8TKCx9NDF
        7CMouHMtFCiOF41gzM=; b=MSiOoWWNEcjMkDKlnxREOu0lcp65cAsWZHsztlHs7
        U5GVS+lU/rbGhpor2XZvnbsmZwyiOdldAT0qW8vkJcgkydhgVVKtTRX8kKthxL90
        7FCZbh/gn481WqDjixdaLrHWNi+2MPZB2jE0nFNaAd+umtOfIakLcaHU6Qz5MyHA
        OMAzAZ7FXHk3u1lxU4EhBJroKdDVb98H+VKFoKLeyLX+y3W/dIpwGsvKmeeDrvDi
        C2i6Qj1R+LwVqPEEdJKZWpQFKoFmX6Q4xsx6E4jvp6mS9pKXzQdZHWtn5TasUwXt
        5hdpS3UZvi9JfWnsBXRmTahGjwzvsoEy7ZZnlBlf9ZDPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1692334856; x=1692342056; bh=WfCGHYhjMYO9OhsC8TKCx9NDF7CMouHMtFC
        iOF41gzM=; b=xazKmlZFB267EiyfNSjq56Lm9ssxxPhOW5LAed0ds7p9GMoJbbN
        iybR6rw8M0ADiL97RSTyUDdia5fSr7feitoRwwBPqz6zuNtolRNF1QPXZ+bb0Ju/
        b/W0hH4YL9iY2VFvi9FzfT45eLiI1P17iXqiwdOQu9kZN0NKEkHzjTEw4G7Vdi5W
        A48GwnnzZnxYlGVXIIEw7Q0vUrItsMyrOnzptnsmNVamZvesYknnb+m06PUSjF3c
        tO/2nFamfeLWQpzs+YGtuWBRwckc2z08vYBZcYMfk2oimFjE/pHpTsQFmfT9MXXC
        HycoPhm4/P2cRH71byKMs2VgG0K+2qhF5ig==
X-ME-Sender: <xms:B_veZBz9VDLTLRtW4yt26vo3l597W0xbDvwnprgEhxGTgk0Yz83l-g>
    <xme:B_veZBQJXa-MVMhtK2p3usOh9SRuvp-r88zezGETZOZO1B6ASsenweNIkUTxgXk9A
    fZrN6k2Rn9hThSQMfc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudduvddgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkfffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepvdeifedukedugeetfeejuefhhfdvudfflefhjefhhfektdeiiefggeeggeekgfeh
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpghhithhhuhgsrdgtohhmnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhn
    uggsrdguvg
X-ME-Proxy: <xmx:B_veZLUtle7esxrDbbPdcrt3iL2AReOyqQoXc_-21t8tI4nAwgv5yQ>
    <xmx:B_veZDiAVPoEeBfWJhRkFrhHGBNjGih-y-YnLN56ulRrCuv1cN82wg>
    <xmx:B_veZDCsEIGs0bd_ml6vbKuMj5eC0tMkfq-EwiIjyIZ2TukH_mGPfA>
    <xmx:CPveZF3hq00rpQXpnN3F-kzjf23xsUXzSuKCBbN4SpR5LKL28TbMhyaH7eY>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 74AEBB60089; Fri, 18 Aug 2023 01:00:55 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-624-g7714e4406d-fm-20230801.001-g7714e440
Mime-Version: 1.0
Message-Id: <fecdd924-b04a-4f49-8de8-fdfb2dbc6c21@app.fastmail.com>
Date:   Fri, 18 Aug 2023 07:00:55 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        soc@kernel.org, "Tony Lindgren" <tony@atomide.com>,
        "Krzysztof Kozlowski" <krzk@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        "Heiko Stuebner" <heiko@sntech.de>,
        "Shawn Guo" <shawnguo@kernel.org>
Subject: [GIT PULL] ARM: SoC fixes for 6.5, part 3
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

The following changes since commit 52a93d39b17dc7eb98b6aa3edb93943248e03b2f:

  Linux 6.5-rc5 (2023-08-06 15:07:51 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-fixes-6.5-3

for you to fetch changes up to 3c78dbf251350fdf3a9dab3b9c3391fb89df208d:

  Merge tag 'qcom-arm64-fixes-for-6.5' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into arm/fixes (2023-08-17 14:39:47 +0200)

----------------------------------------------------------------
ARM: SoC fixes for 6.5, part 3

As usual, mostly DT fixes for the major Arm platforms from Qualcomm and
NXP, plus a bit for Rockchips and others:

The qualcomm fixes mainly deal with their higher-end arm64 devices trees,
fixing issues in L3 interconnect, crypto, thermal, UFS and a regression
for the DSI phy.

NXP i.MX has two correctness fixes for the 64-bit chips, dealing with
the imx93 "anatop" module and the CSI interface. On the 32-bit side,
there are functional fixes for RTC, display and SD card intefaces.

Rockchip fixes are for wifi support on certain boards, a eMMC stability
and DT build warnings.

On TI OMAP, a regulator is described in DT to avoid problems with the
ethernet phy initialization.

The code changes include a missing MMIO serialization on OMAP, plus a
few minor fixes on ASpeed and AMD/Zynq chips.

----------------------------------------------------------------
Alexander Stein (1):
      arm64: dts: imx93: Fix anatop node size

Andrej Picej (1):
      ARM: dts: imx6: phytec: fix RTC interrupt level

Arnd Bergmann (5):
      Merge tag 'imx-fixes-6.5-2' of git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into arm/fixes
      Merge tag 'zynq-soc-for-6.6' of https://github.com/Xilinx/linux-xlnx into arm/fixes
      Merge tag 'v6.5-rockchip-dtsfixes1' of git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip into arm/fixes
      Merge tag 'omap-for-v6.5/fixes-signed' of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap into arm/fixes
      Merge tag 'qcom-arm64-fixes-for-6.5' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into arm/fixes

Christopher Obbard (2):
      arm64: dts: rockchip: Disable HS400 for eMMC on ROCK Pi 4
      arm64: dts: rockchip: Disable HS400 for eMMC on ROCK 4C+

Cristian Ciocaltea (1):
      arm64: dts: rockchip: Drop invalid regulator-init-microvolt property

Dmitry Baryshkov (1):
      arm64: dts: qcom: qrb5165-rb5: fix thermal zone conflict

Fabio Estevam (2):
      ARM: dts: imx6sx: Remove LDB endpoint
      arm64: dts: imx8mm: Drop CSI1 PHY reference clock configuration

Jiasheng Jiang (1):
      soc: aspeed: socinfo: Add kfree for kstrdup

Konrad Dybcio (1):
      arm64: dts: qcom: sc7180: Fix DSI0_PHY reg-names

Krzysztof Kozlowski (9):
      arm64: dts: qcom: sm8150: Fix OSM L3 interconnect cells
      arm64: dts: qcom: sm8250: Fix EPSS L3 interconnect cells
      arm64: dts: qcom: sc8180x: Fix OSM L3 compatible
      arm64: dts: qcom: sm8350: fix BAM DMA crash and reboot
      arm64: dts: rockchip: correct wifi interrupt flag in eaidk-610
      arm64: dts: rockchip: correct wifi interrupt flag in Rock Pi 4B
      arm64: dts: rockchip: correct wifi interrupt flag in Box Demo
      arm64: dts: rockchip: add missing space before { on indiedroid nova
      arm64: dts: rockchip: minor whitespace cleanup around '='

Lin Yujun (1):
      ARM: dts: integrator: fix PCI bus dtc warnings

Marek Vasut (1):
      arm64: dts: imx8mn: Drop CSI1 PHY reference clock configuration

Naveen Kumar Goud Arepalli (1):
      arm64: dts: qcom: sa8775p-ride: Update L4C parameters

Rob Herring (1):
      ARM: zynq: Explicitly include correct DT includes

Shengyu Qu (2):
      ARM: dts: am335x-bone-common: Add GPIO PHY reset on revision C3 board
      ARM: dts: am335x-bone-common: Add vcc-supply for on-board eeprom

Tony Lindgren (2):
      bus: ti-sysc: Flush posted write on enable before reset
      Merge branch 'omap-for-v6.5/ti-sysc' into omap-for-v6.5/fixes

Xiaolei Wang (2):
      ARM: dts: imx: Set default tuning step for imx7d usdhc
      ARM: dts: imx: Set default tuning step for imx6sx usdhc

Yogesh Hegde (1):
      arm64: dts: rockchip: Fix Wifi/Bluetooth on ROCK Pi 4 boards

Zev Weiss (1):
      soc: aspeed: uart-routing: Use __sysfs_match_string

 arch/arm/boot/dts/arm/integratorap.dts                 |  2 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-phytec-mira.dtsi     |  2 +-
 arch/arm/boot/dts/nxp/imx/imx6sx.dtsi                  | 14 ++++++++------
 arch/arm/boot/dts/nxp/imx/imx7s.dtsi                   |  6 ++++++
 arch/arm/boot/dts/ti/omap/am335x-bone-common.dtsi      |  9 +++++++++
 arch/arm/mach-zynq/pm.c                                |  2 +-
 arch/arm64/boot/dts/freescale/imx8mm.dtsi              |  7 +++----
 arch/arm64/boot/dts/freescale/imx8mn.dtsi              |  6 ++----
 arch/arm64/boot/dts/freescale/imx93.dtsi               |  2 +-
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts               |  2 +-
 arch/arm64/boot/dts/qcom/sa8775p-ride.dts              |  4 ++--
 arch/arm64/boot/dts/qcom/sc7180.dtsi                   |  4 ++--
 arch/arm64/boot/dts/qcom/sc8180x.dtsi                  |  2 +-
 arch/arm64/boot/dts/qcom/sm8150.dtsi                   | 18 +++++++++---------
 arch/arm64/boot/dts/qcom/sm8250.dtsi                   | 18 +++++++++---------
 arch/arm64/boot/dts/qcom/sm8350.dtsi                   |  4 ++++
 arch/arm64/boot/dts/rockchip/px30.dtsi                 | 16 ++++++++--------
 arch/arm64/boot/dts/rockchip/rk3308-roc-cc.dts         |  1 -
 arch/arm64/boot/dts/rockchip/rk3308-rock-pi-s.dts      |  1 -
 arch/arm64/boot/dts/rockchip/rk3399-eaidk-610.dts      |  2 +-
 arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi       |  1 -
 arch/arm64/boot/dts/rockchip/rk3399-rock-4c-plus.dts   |  3 +--
 arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi     |  6 +++---
 .../arm64/boot/dts/rockchip/rk3399-rock-pi-4b-plus.dts |  2 +-
 .../arm64/boot/dts/rockchip/rk3566-anbernic-rgxx3.dtsi |  3 ---
 arch/arm64/boot/dts/rockchip/rk3566-box-demo.dts       |  4 ++--
 arch/arm64/boot/dts/rockchip/rk3566-lubancat-1.dts     |  3 ---
 arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi      |  2 --
 arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts     |  2 --
 arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts     |  2 --
 arch/arm64/boot/dts/rockchip/rk3566-radxa-cm3-io.dts   |  4 ++--
 arch/arm64/boot/dts/rockchip/rk3566-roc-pc.dts         |  2 --
 arch/arm64/boot/dts/rockchip/rk3566-soquartz.dtsi      |  3 ---
 arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts     |  3 ---
 arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts       |  3 ---
 .../arm64/boot/dts/rockchip/rk3568-fastrhino-r66s.dtsi |  4 ----
 arch/arm64/boot/dts/rockchip/rk3568-lubancat-2.dts     |  3 ---
 arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dtsi    |  3 ---
 arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts      |  3 ---
 arch/arm64/boot/dts/rockchip/rk3568-radxa-cm3i.dtsi    |  3 ---
 arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts        |  3 ---
 arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts        |  1 -
 .../boot/dts/rockchip/rk3588s-indiedroid-nova.dts      |  8 ++++----
 drivers/bus/ti-sysc.c                                  |  2 ++
 drivers/soc/aspeed/aspeed-socinfo.c                    |  1 +
 drivers/soc/aspeed/aspeed-uart-routing.c               |  2 +-
 46 files changed, 86 insertions(+), 112 deletions(-)
