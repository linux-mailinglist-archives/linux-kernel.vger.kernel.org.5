Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4E5078CF06
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 23:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238412AbjH2V6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 17:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238122AbjH2V6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 17:58:30 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96A6122
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 14:58:24 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 02F363200951;
        Tue, 29 Aug 2023 17:58:23 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 29 Aug 2023 17:58:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1693346303; x=1693432703; bh=5ujhMux6R+CLghpJpHQGYJawxk4SpcHFx1+
        NuFAykNg=; b=wRoJswW2x84P9oQqO5xXgiviPw8h1oHFFNBspVT7TduW5vFlP7s
        d4/vuJd0kjnDC0cdFY3hjlNzF7bccMWm/b2PAC6yoexQD+Gw+IWnGRkT08MQuOBm
        /VWMtZVJ0fSr/3gvWcylE4JPAjQwB2sWUz57N5eUH83dtn831Cm3al+ozF62Zded
        xsRbuCoYo7lW8xoUZykOZ8dB0aM+DWkAxVQNsBlX+/Cdoqax3T4WQtGtdiPbJk2v
        5MqAxYLw3xo/++GYzLk/bXP7KdrqAFHYYSMNmLVvoXLvo63r/epCPLQEvpdBacMY
        q58r9Ucm8BIb1eGTJ9J+O4sI22vZRU+3zBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1693346303; x=1693432703; bh=5ujhMux6R+CLghpJpHQGYJawxk4SpcHFx1+
        NuFAykNg=; b=hh3VJZoLDwCpjvU8Nkws1DR5yBLxFDe1inSPnigpALvQ2DnXlkJ
        PyLEe062fz2Uy8WO6PrEBWZD721Tb9uDbRK+616BNwcgrKQYQ/HDa0+T3vVL1UQy
        /GjFG03KEVXDn6o1mYd3Rrn8kiNDfKbtDIE+3cvuld3g8UZDG7ZZQQrssbrdWMqU
        l2GkFtt9W5ijRHZyvgoiyLaj17s6O1TA9C5g2wHhKfWkcJaS8bhSBn7oAtR0G1wQ
        +kImGAmhhbWvZp6y1UH2kpUkDBOdgPyCsceS5KvvNavG+uW7iI//ARbefowLP+A2
        CXc6wU33aNOjc1+RRhvXZc0vvfeMO5JE26Q==
X-ME-Sender: <xms:_2nuZKuRg969-IWRZsgZNRQU-nkr7ZQekKqClyl1ig6biDwE3JWhEg>
    <xme:_2nuZPfDfs4fc65f8DFuuTgTzvp_ARxkVxtUpBg6zMWXdtah5Gv0LtSQXFGvKS8eY
    vIQMkInG4llwKz1ldo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudefjedgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpefgkefhheetvdethfejkeeigfehtdffieevfeefteffteejffehlefhtdeu
    veejueenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgihhthhhusgdrtghomhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnuges
    rghrnhgusgdruggv
X-ME-Proxy: <xmx:_2nuZFyyHaGKEMr7VlS4fTvYbiTvv9wsFwhntd0KDXIrcs1JKsPp0g>
    <xmx:_2nuZFMFl8GFV7Ou4FFqhGqe_yDqwsjstQaV1-dbEblzKSHimjgsYw>
    <xmx:_2nuZK-a3TpW79_sIb6j384EBMBCnahBXUcpHF4o1zRbTBSd5VgH-Q>
    <xmx:_2nuZAlIHC68WdKsANJyJ9v33mLOLqu_yWYGBlT7KSiii3GWuD9epA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 39CC2B60089; Tue, 29 Aug 2023 17:58:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-701-g9b2f44d3ee-fm-20230823.001-g9b2f44d3
Mime-Version: 1.0
Message-Id: <d9c11cf5-24df-4c01-9f41-5ddc39830aca@app.fastmail.com>
In-Reply-To: <4f60d13e-f060-491a-88c7-6f25323a48f8@app.fastmail.com>
References: <4f60d13e-f060-491a-88c7-6f25323a48f8@app.fastmail.com>
Date:   Tue, 29 Aug 2023 17:58:01 -0400
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        soc@kernel.org
Subject: [GIT PULL 4/4] ARM: devicetree updates for 6.6
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit fdf0eaf11452d72945af31804e2a1048ee1b5=
74c:

  Linux 6.5-rc2 (2023-07-16 15:10:37 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-d=
t-6.6

for you to fetch changes up to 05c618f39089d977b0c3dc1105cb6cd5fc53cd01:

  arm64: dts: use capital "OR" for multiple licenses in SPDX (2023-08-29=
 16:02:35 -0400)

----------------------------------------------------------------
ARM: devicetree updates for 6.6

These are the devicetree updates for Arm and RISC-V based SoCs,
mainly from Qualcomm, NXP/Freescale, Aspeed, TI, Rockchips,
Samsung, ST and Starfive.

Only a few new SoC got added:

 - TI AM62P5, a variant of the existing Sitara AM62x family

 - Intel Agilex5, an FPGFA platform that includes an
   Cortex-A76/A55 SoC.

 - Qualcomm ipq5018 is used in wireless access points

 - Qualcomm SM4450 (Snapdragon 4 Gen 2) is a new low-end mobile
   phone platform.

In total, 29 machines get added, which is low because of the summer
break. These cover SoCs from Aspeed, Broadcom, NXP, Samsung, ST,
Allwinner, Amlogic, Intel, Qualcomm, Rockchip, TI and T-Head.  Most of
these are development and reference boards.

Despite not adding a lot of new machines, there are over 700 patches in
total, most of which are cleanups and minor fixes.

----------------------------------------------------------------
(lightly trimmed the shortlog)

Abel Vesa (1):
      arm64: dts: qcom: sm8550-mtp: Add missing supply for L1B regulator

Adam Ford (3):
      arm64: dts: imx8mn-beacon: Add HDMI video with sound
      arm64: dts: imx8mm-beacon: Change camera I2C address
      arm64: dts: imx8mm-beacon: Add HDMI video with sound

Aleksey Nasibulin (1):
      ARM: dts: BCM5301X: Extend RAM to full 256MB for Linksys EA6500 V2

Alexander Stein (16):
      arm64: dts: freescale: add initial device tree for MBa93xxLA SBC b=
oard
      ARM: dts: imx6qdl-mba6: Add missing supply regulator for lm75 and =
at24
      arm64: dts: qcom: Replace deprecated extcon-usb-gpio id-gpio/vbus-=
gpio properties
      arm64: dts: imx8mq: Add coresight trace components
      ARM: dts: imx6qdl-tqma6x: Add missing vs-supply for lm75
      arm64: dts: imx8qm: Fix VPU core alias name
      arm64: dts: imx8qm: Fix VPU core alias name
      arm64: dts: imx8: conn: Fix reg order for USB3 controller
      ...

Alif Zakuan Yuslaimi (1):
      arm64: dts: agilex/stratix10: Updated QSPI Flash layout for UBIFS

Amit Pundir (1):
      arm64: dts: qcom: sdm845-db845c: Mark cont splash memory region as=
 reserved

Andre Przywara (3):
      arm64: dts: allwinner: h616: Split Orange Pi Zero 2 DT
      dt-bindings: arm: sunxi: document Orange Pi Zero 3 board name
      arm64: dts: allwinner: h616: Add OrangePi Zero 3 board support

Andrej Picej (2):
      ARM: dts: imx6: pfla02: Rely on PMIC reboot/reset handler
      ARM: dts: imx6: phycore: Rely on PMIC reboot/reset handler

Andrew Davis (27):
      dt-bindings: omap: Partially convert omap.txt to yaml
      arm64: dts: ti: k3-am62a: Remove syscon compatible from epwm_tbclk
      arm64: dts: ti: k3-am64: Merge the two main_conf nodes
      arm64: dts: ti: k3: Fix epwm_tbclk node name to generic name
      arm64: dts: ti: k3-j721e: Enable SDHCI nodes at the board level
      arm64: dts: ti: k3-j7200: Enable SDHCI nodes at the board level
      arm64: dts: ti: k3-j721s2: Enable SDHCI nodes at the board level
      ...

AngeloGioacchino Del Regno (1):
      arm64: dts: qcom: msm8998: Add DPU1 nodes

Apelete Seketeli (1):
      arm64: dts: ti: k3-j784s4: Fix interrupt ranges for wkup & main gp=
io

Apurva Nandan (3):
      arm64: dts: ti: k3-j784s4: Add phase tags marking
      arm64: dts: ti: k3-j784s4-evm: Add phase tags marking
      arm64: dts: ti: k3-am69-sk: Add phase tags marking

Aradhya Bhatia (3):
      arm64: dts: ti: k3-am62x-sk-common: Update main-i2c1 frequency
      arm64: dts: ti: k3-am62-main: Add node for DSS
      arm64: dts: ti: k3-am62x-sk-common: Add HDMI support

Arnd Bergmann (35):
      Merge tag 'tegra-for-6.6-dt-bindings' of git://git.kernel.org/pub/=
scm/linux/kernel/git/tegra/linux into soc/dt
      Merge tag 'tegra-for-6.6-arm-dt' of git://git.kernel.org/pub/scm/l=
inux/kernel/git/tegra/linux into soc/dt
      Merge tag 'tegra-for-6.6-arm64-dt' of git://git.kernel.org/pub/scm=
/linux/kernel/git/tegra/linux into soc/dt
      Merge tag 'renesas-dts-for-v6.6-tag1' of git://git.kernel.org/pub/=
scm/linux/kernel/git/geert/renesas-devel into soc/dt
      Merge tag 'at91-dt-6.6' of https://git.kernel.org/pub/scm/linux/ke=
rnel/git/at91/linux into soc/dt
      Merge tag 'microchip-dt64-6.6' of https://git.kernel.org/pub/scm/l=
inux/kernel/git/at91/linux into soc/dt
      Merge tag 'hisi-arm64-dt-for-6.6' of https://github.com/hisilicon/=
linux-hisi into soc/dt
      Merge tag 'hisi-arm32-dt-for-6.6' of https://github.com/hisilicon/=
linux-hisi into soc/dt
      Merge tag 'zynqmp-dt-for-6.6' of https://github.com/Xilinx/linux-x=
lnx into soc/dt
      Merge tag 'juno-update-6.6' of git://git.kernel.org/pub/scm/linux/=
kernel/git/sudeep.holla/linux into soc/dt
      Merge tag 'amlogic-arm64-dt-for-v6.6' of https://git.kernel.org/pu=
b/scm/linux/kernel/git/amlogic/linux into soc/dt
      Merge tag 'sunxi-dt-for-6.6-1' of https://git.kernel.org/pub/scm/l=
inux/kernel/git/sunxi/linux into soc/dt
      Merge tag 'omap-for-v6.6/dt-bindings-signed' of git://git.kernel.o=
rg/pub/scm/linux/kernel/git/tmlind/linux-omap into soc/dt
      Merge tag 'omap-for-v6.6/dt-take2-signed' of git://git.kernel.org/=
pub/scm/linux/kernel/git/tmlind/linux-omap into soc/dt
      Merge tag 'aspeed-6.6-devicetree-2' of git://git.kernel.org/pub/sc=
m/linux/kernel/git/joel/bmc into soc/dt
      Merge tag 'samsung-dt64-6.6' of https://git.kernel.org/pub/scm/lin=
ux/kernel/git/krzk/linux into soc/dt
      Merge tag 'samsung-dt-6.6' of https://git.kernel.org/pub/scm/linux=
/kernel/git/krzk/linux into soc/dt
      Merge tag 'mvebu-dt64-6.6-1' of git://git.kernel.org/pub/scm/linux=
/kernel/git/gclement/mvebu into soc/dt
      Merge tag 'mvebu-dt-6.6-1' of git://git.kernel.org/pub/scm/linux/k=
ernel/git/gclement/mvebu into soc/dt
      Merge tag 'riscv-dt-for-v6.6' of https://git.kernel.org/pub/scm/li=
nux/kernel/git/conor/linux into soc/dt
      Merge tag 'sunxi-dt-for-6.6-2' of https://git.kernel.org/pub/scm/l=
inux/kernel/git/sunxi/linux into soc/dt
      Merge tag 'imx-bindings-6.6' of git://git.kernel.org/pub/scm/linux=
/kernel/git/shawnguo/linux into soc/dt
      Merge tag 'imx-dt-6.6' of git://git.kernel.org/pub/scm/linux/kerne=
l/git/shawnguo/linux into soc/dt
      Merge tag 'imx-dt64-6.6' of git://git.kernel.org/pub/scm/linux/ker=
nel/git/shawnguo/linux into soc/dt
      Merge tag 'ti-k3-dt-for-v6.6' of https://git.kernel.org/pub/scm/li=
nux/kernel/git/ti/linux into soc/dt
      Merge tag 'dt64-cleanup-6.6' of https://git.kernel.org/pub/scm/lin=
ux/kernel/git/krzk/linux-dt into soc/dt
      Merge tag 'stm32-dt-for-v6.6-1' of git://git.kernel.org/pub/scm/li=
nux/kernel/git/atorgue/stm32 into soc/dt
      Merge tag 'v6.6-rockchip-dts64-1' of git://git.kernel.org/pub/scm/=
linux/kernel/git/mmind/linux-rockchip into soc/dt
      Merge tag 'v6.6-rockchip-dts32-1' of git://git.kernel.org/pub/scm/=
linux/kernel/git/mmind/linux-rockchip into soc/dt
      Merge tag 'qcom-dts-for-6.6' of https://git.kernel.org/pub/scm/lin=
ux/kernel/git/qcom/linux into soc/dt
      Merge tag 'qcom-arm64-for-6.6' of https://git.kernel.org/pub/scm/l=
inux/kernel/git/qcom/linux into soc/dt
      Merge tag 'riscv-dt-for-v6.6-pt2' of https://git.kernel.org/pub/sc=
m/linux/kernel/git/conor/linux into soc/dt
      Merge tag 'socfpga_dts_updates_for_v6.6' of git://git.kernel.org/p=
ub/scm/linux/kernel/git/dinguyen/linux into soc/dt
      Merge tag 'arm-soc/for-6.6/devicetree' of https://github.com/Broad=
com/stblinux into soc/dt
      Merge tag 'arm-soc/for-6.6/devicetree-arm64' of https://github.com=
/Broadcom/stblinux into soc/dt

Artur Weber (2):
      ARM: dts: exynos: Add Samsung Galaxy Tab 3 8.0 boards
      arm64: tegra: Adapt to LP855X bindings changes

Ar=C4=B1n=C3=A7 =C3=9CNAL (2):
      dt-bindings: arm: bcm: add bindings for ASUS RT-AC3100
      ARM: dts: BCM5301X: Add DT for ASUS RT-AC3100

Bartosz Golaszewski (14):
      arm64: dts: qcom: sa8775p: add the SGMII PHY node
      arm64: dts: qcom: sa8775p: add the first 1Gb ethernet interface
      arm64: dts: qcom: sa8775p-ride: enable the SerDes PHY
      arm64: dts: qcom: sa8775p-ride: add pin functions for ethernet0
      arm64: dts: qcom: sa8775p-ride: enable ethernet0
      arm64: dts: qcom: sa8775p: add a node for the second serdes PHY
      arm64: dts: qcom: sa8775p: add a node for EMAC1
      arm64: dts: qcom: sa8775p-ride: enable the second SerDes PHY
      arm64: dts: qcom: sa8775p-ride: move the reset-gpios property of t=
he PHY
      arm64: dts: qcom: sa8775p-ride: index the first SGMII PHY
      arm64: dts: qcom: sa8775p-ride: add the second SGMII PHY
      arm64: dts: qcom: sa8775p-ride: sort aliases alphabetically
      arm64: dts: qcom: sa8775p-ride: add an alias for ethernet0
      arm64: dts: qcom: sa8775p-ride: enable EMAC1

Bhavya Kapoor (1):
      arm64: dts: ti: k3-j721s2: Add support for CAN instances 3 and 5 i=
n main domain

Biju Das (8):
      arm64: dts: renesas: rzg2l: Update overfow/underflow IRQ names for=
 MTU3 channels
      arm64: dts: renesas: rzg2l-smarc-som: Enable PMIC and built-in RTC
      arm64: dts: renesas: rzg2l-smarc: Add support for enabling MTU3
      arm64: dts: renesas: rzg2lc-smarc: Add support for enabling MTU3
      arm64: dts: renesas: rzg2lc-smarc-som: Add PHY interrupt support f=
or ETH0
      arm64: dts: renesas: rzg2lc-smarc-som: Enable PMIC and built-in RTC
      arm64: dts: renesas: r9a07g043: Add MTU3a node
      arm64: dts: renesas: rzg2ul-smarc: Add support for enabling MTU3

Bjorn Andersson (12):
      arm64: dts: qcom: Drop undocumented "svid" property
      Merge branch 'd1c5aa4a8535c645fdb06df62a562918516ba0c6.1686289721.=
git.quic_varada@quicinc.com' into HEAD
      arm64: dts: qcom: sc8280xp-crd: Correct vreg_misc_3p3 GPIO
      arm64: dts: qcom: sc8280xp-crd: Fix naming of regulators
      Merge branch '20230620-topic-sc8280_gccgdsc-v2-2-562c1428c10d@lina=
ro.org' into arm64-for-6.6
      Merge branch '1689744162-9421-2-git-send-email-quic_rohiagar@quici=
nc.com' into arm64-for-6.6
      arm64: dts: qcom: sc8180x: Add USB Type-C of_graph anchors
      arm64: dts: qcom: sc8180x-primus: Wire up USB Type-C
      arm64: dts: qcom: sc8180x-flex5g: Wire up USB Type-C
      arm64: dts: qcom: sc8180x: Fix LLCC reg property
      Merge branch '1690533192-22220-2-git-send-email-quic_srichara@quic=
inc.com' into arm64-for-6.6
      Merge branch '20230622-topic-8998clk-v2-1-6222fbc2916b@linaro.org'=
 into arm64-for-6.6

Bryan Brattlof (3):
      dt-bindings: arm: ti: Add bindings for AM62P5 SoCs
      arm64: dts: ti: Introduce AM62P5 family of SoCs
      arm64: dts: ti: Add support for the AM62P5 Starter Kit

Bryan O'Donoghue (8):
      arm64: dts: qcom: sdm845: Enable CAMSS on the bare rb3 board
      arm64: dts: qcom: msm8916: Define CAMSS ports in core dtsi
      arm64: dts: qcom: apq8016-sbc: Fix ov5640 regulator supply names
      arm64: dts: qcom: apq8016-sbc: Fix ov5640 data-lanes declaration
      arm64: dts: qcom: apq8016-sbc: Set ov5640 assigned-clock
      arm64: dts: qcom: apq8016-sbc: Rename ov5640 enable-gpios to power=
down-gpios
      arm64: dts: qcom: apq8016-sbc-d3-camera-mezzanine: Move default ov=
5640 to a standalone dts
      arm64: dts: qcom: apq8016-sbc: Enable camss for non-mezzanine cases

Caleb Connolly (3):
      arm64: dts: qcom: c630: add panel bridge 1p2 regulator
      arm64: dts: qcom: c630: add debug uart
      arm64: dts: qcom: sdm850-*: fix uart6 aliases

Cem Tenruh (1):
      arm64: dts: imx8mm-phyboard-polis: Add i2c4 sda-/scl-gpios

Chanh Nguyen (3):
      ARM: dts: aspeed: mtmitchell: Enable the BMC UART8 and UART9
      ARM: dts: aspeed: mtmitchell: Update ADC sensors for Mt.Mitchell D=
VT systems
      ARM: dts: aspeed: mtmitchell: Add MCTP

Chen PJ (2):
      dt-bindings: arm: aspeed: add Inventec starscream-bmc
      ARM: dts: aspeed: Adding Inventec Starscream BMC

Chris Packham (1):
      arm64: dts: marvell: Add NAND flash controller to AC5

Chris Paterson (1):
      arm64: dts: renesas: rzg2l: Fix txdv-skew-psec typos

Christian Hemp (1):
      arm64: dts: imx8mp-phycore-som: Remove eth phy interrupt

Christopher Obbard (3):
      arm64: dts: rockchip: Move OPP table from ROCK Pi 4 dtsi
      dt-bindings: arm: rockchip: Add Radxa ROCK 4SE
      arm64: dts: rockchip: Add Radxa ROCK 4SE

Claudiu Beznea (1):
      ARM: dts: at91: remove duplicated entries

Conor Dooley (3):
      Merge tag 'clk-starfive-bindings' into riscv-dt-for-next
      riscv: dts: renesas: Clean up dtbs_check W=3D1 warning due to empt=
y phy node
      riscv: dts: starfive: fix jh7110 qspi sort order

Cristian Ciocaltea (1):
      arm64: dts: rockchip: Update sound card label on rk3588-rock-5b

Dan Haab (1):
      ARM: dts: BCM5301X: Add Wi-Fi regulatory mappings for Luxul devices

Dario Binacchi (7):
      ARM: dts: stm32: re-add CAN support on stm32f746
      ARM: dts: stm32: add pin map for i2c3 controller on stm32f7
      ARM: dts: stm32: add touchscreen on stm32f746-disco board
      ARM: dts: stm32: add ltdc support on stm32f746 MCU
      ARM: dts: stm32: add pin map for LTDC on stm32f7
      ARM: dts: stm32: rename mmc_vcard to vcc-3v3 on stm32f746-disco
      ARM: dts: stm32: support display on stm32f746-disco board

David Heidelberg (1):
      ARM: dts: qcom: apq8064: add support to gsbi4 uart

David Wronek (1):
      arm64: dts: qcom: msm8996: Fix dsi1 interrupts

David Yang (1):
      arm64: dts: hi3798cv200: Fix clocks order of sd0

Delphine CC Chiu (2):
      dt-bindings: arm: aspeed: add Facebook Yosemite 4 board
      ARM: dts: aspeed: yosemite4: add Facebook Yosemite 4 BMC

Devi Priya (1):
      arm64: dts: qcom: ipq9574: Use assigned-clock-rates for QUP I2C co=
re clks

Dhruva Gole (1):
      arm64: dts: ti: k3-*: fix fss node dtbs check warnings

Dinh Nguyen (6):
      arm64: dts: socfpga: agilex/stratix10: fix dtbs_check warnings for=
 sram
      arm64: dts: socfpga: stratix10: fix dtbs_check warning for usbphy
      arm64: dts: stratix10/agilex/n5x: fix dtbs_check warning for memor=
y node
      arm64: dts: agilex/stratix10/n5x: fix dtbs_check for rstmgr
      arm64: dts: socfpga: n5x/stratix10: fix dtbs_check warning for par=
titions
      arm64: dts: socfpga: change the reset-name of "stmmaceth-ocp" to "=
ahb"

Diogo Ivo (1):
      arm64: tegra: Fix HSUART for Smaug

Dmitry Baryshkov (16):
      arm64: dts: qcom: sm8150: use proper DSI PHY compatible
      Revert "arm64: dts: qcom: msm8996: rename labels for HDMI nodes"
      arm64: dts: qcom: msm8996: rename labels for HDMI nodes
      arm64: dts: qcom: pm8350: fix thermal zone name
      arm64: dts: qcom: pm8350b: fix thermal zone name
      arm64: dts: qcom: pmr735b: fix thermal zone name
      arm64: dts: qcom: pmk8350: fix ADC-TM compatible string
      arm64: dts: qcom: sm8450-hdk: remove pmr735b PMIC inclusion
      ....

Drew Fustini (3):
      dt-bindings: riscv: Add BeagleV Ahead board compatibles
      riscv: dts: thead: add BeagleV Ahead board device tree
      riscv: dts: change TH1520 files to dual license

Dylan Hung (1):
      ARM: dts: aspeed: Add AST2600 I3C control pins

Eddie James (3):
      ARM: dts: aspeed: bonnell: Add DIMM SPD
      ARM: dts: aspeed: Add P10 FSI descriptions
      ARM: dts: aspeed: everest: Reorganise FSI description

Eric Chanudet (1):
      arm64: dts: qcom: sa8540p-ride: enable rtc

Etienne Carriere (4):
      ARM: dts: stm32: leverage OP-TEE ASync notif on STM32MP13x Soc fam=
ily
      dt-bindings: rcc: stm32: add STM32MP13 SCMI regulators IDs
      ARM: dts: stm32: STM32MP13x SoC exposes SCMI regulators
      ARM: dts: stm32: add SCMI PMIC regulators on stm32mp135f-dk board

FUKAUMI Naoki (1):
      arm64: dts: rockchip: fix/update sdmmc properties for rock-5a and =
-5b

Fabio Estevam (29):
      arm64: dts: imx8mq-librem5: Use 'vqmmc-supply'
      arm64: dts: imx8mn-evk: Pass GPIO_OPEN_DRAIN flag
      arm64: dts: imx8mm-evk: Add camera support
      arm64: dts: imx8mn-evk: Add HDMI support
      arm64: dts: imx8mn-evk: Add camera support
      ARM: dts: imx: Remove regulators from simple-bus
      ARM: dts: imx7d-sdb: Pass the Ethernet aliases
      ARM: dts: imx6sx: Describe the default LCDIF1 parent
      ARM: dts: imx53-qsb: Improve the parallel display description
      arm64: dts: imx8dxl-evk: Remove 'fsl,spi-num-chipselects'
      arm64: dts: imx8mm-phyboard-polis-rdk: Remove 'fsl,spi-num-chipsel=
ects'
      ARM: dts: imx6ul-geam: Remove invalid sgtl5000 property
      ...

Fabrizio Castro (1):
      arm64: dts: renesas: r9a09g011: Add CSI nodes

Felix Moessbauer (2):
      riscv: dts: Enable device-tree overlay support for starfive devices
      arm: dts: Enable device-tree overlay support for sun8i-h3 pi devic=
es

Francesco Dolcini (6):
      arm64: dts: freescale: verdin-imx8mp: dahlia: add sound card
      arm64: dts: freescale: verdin-imx8mp: dev: add sound card
      arm64: dts: ti: verdin-am62: Set I2S_1 MCLK rate
      arm64: dts: ti: verdin-am62: dev: add sound card
      arm64: dts: ti: verdin-am62: dahlia: add sound card
      arm64: dts: ti: verdin-am62: Add DSI display support

Frank Li (4):
      arm64: dts: imx8mp: remove arm,primecell-periphid at etm nodes
      arm64: dts: imx8qm: add cpu frequency table
      arm64: dts: imx8qm: add thermal zone and cooling map
      arm64: dts: imx8qm-mek: delete A72 thermal zone

Furkan Kardame (2):
      dt-bindings: arm: rockchip: Add Firefly Station P2
      arm64: dts: rockchip: add dts for Firefly Station P2 aka rk3568-ro=
c-pc

Gautham Srinivasan (3):
      arm64: tegra: Add UARTE device tree node on Tegra234
      arm64: tegra: Enable UARTA and UARTE for Orin Nano
      arm64: tegra: Add SPI device tree nodes for Tegra234

Geert Uytterhoeven (4):
      arm64: dts: renesas: r8a779f0: Add INTC-EX node
      arm64: dts: renesas: spider-cpu: Add GP LEDs
      ARM: dts: aspeed: Fix pca954x i2c-mux node names
      ARM: dts: nuvoton: Fix pca954x i2c-mux node names

Guido G=C3=BCnther (2):
      arm64: dts: imx8mq-librem5-devkit: Mark buck2 as always on
      arm64: dts: imx8mq-librem5-devkit: Drop power-supply

Haibo Chen (3):
      arm64: dts: imx8ulp: add flexspi node
      arm64: dts: imx8ulp-evk: add 100MHz/200MHz pinctrl setting for eMMC
      arm64: dts: imx8ulp-evk: enable lpi2c7 bus

Hal Feng (2):
      riscv: dts: starfive: jh7100: Add temperature sensor node and ther=
mal-zones
      riscv: dts: starfive: jh7110: Add temperature sensor node and ther=
mal-zones

Han Xu (1):
      arm64: dts: imx8ulp-evk: add spi-nor device support

Harini Katakam (1):
      arm64: zynqmp: Assign TSU clock frequency for GEMs

Hiago De Franco (1):
      arm64: dts: ti: k3-am625-verdin: enable CAN_2

Hugo Villeneuve (1):
      arm64: dts: imx8mn-var-som-symphony: update USB OTG for new board =
versions

Hui Wang (1):
      arm64: dts: ls1028a: add l1 and l2 cache info

Huqiang Qin (1):
      arm64: dts: Add gpio_intc node and pinctrl node for Amlogic C3 SoCs

Jaewon Kim (2):
      dt-bindings: pwm: samsung: add exynosautov9 compatible
      arm64: dts: exynos: add pwm node for exynosautov9-sadk

Jagan Teki (16):
      arm64: dts: rockchip: Drop unchanged max-frequency from rk3588 boa=
rds
      arm64: dts: rockchip: Add PMIC for edgeble-neu6b
      ARM: dts: rockchip: Add SFC node to rv1126
      ARM: dts: rockchip: Add rv1126 FSPI pins
      ARM: dts: rockchip: Add rv1126 uart5m2_xfer pins
      ...

Jai Luthra (2):
      arm64: dts: ti: k3-am62: Enable AUDIO_REFCLKx
      arm64: dts: ti: am62x-sk: Add overlay for HDMI audio

Jakob Hauser (1):
      arm64: dts: qcom: msm8916-samsung-serranove: Add RT5033 PMIC with =
charger

Jayesh Choudhary (4):
      arm64: dts: ti: Use local header for SERDES MUX idle-state values
      dt-bindings: ti-serdes-mux: Deprecate header with constants
      arm64: dts: ti: k3-j721s2-main: Add DSS node
      arm64: dts: ti: k3-am68-sk-base-board: Add HDMI support

Jia Jie Ho (2):
      riscv: dts: starfive - Add crypto and DMA node for JH7110
      riscv: dts: starfive - Add hwrng node for JH7110 SoC

Joel Stanley (4):
      ARM: dts: aspeed: Add AST2600 VUARTs
      ARM: dts: aspeed: bonnell: Reorganise FSI description
      ARM: dts: aspeed: rainier: Reorganise FSI description
      ARM: dts: aspeed: everest: Move common devices up

Johan Hovold (1):
      arm64: dts: qcom: sc8280xp-pmics: add explicit rtc interrupt parent

John Clark (1):
      arm64: dts: rockchip: Add NanoPC T6 PCIe Ethernet support

John Watts (1):
      riscv: dts: allwinner: d1: Add CAN controller nodes

Jon Hunter (2):
      arm64: tegra: Add missing alias for NVIDIA IGX Orin
      arm64: tegra: Fix HSUART for Jetson AGX Orin

Jonas Karlman (2):
      arm64: dts: rockchip: Fix PCIe regulators on Radxa E25
      arm64: dts: rockchip: Enable SATA on Radxa E25

Jonas Kuenstler (1):
      arm64: dts: imx8mp-phyboard-pollux: Add missing usdhc clocks assig=
nment

Judith Mendez (2):
      arm64: dts: ti: k3-am62: Add MCU MCAN nodes
      arm64: dts: ti: k3-am62a7: Add MCU MCAN nodes

Kamlesh Gurudasani (2):
      dt-bindings: crypto: ti,sa2ul: make power-domains conditional
      arm64: dts: ti: k3-am62-main: Remove power-domains from crypto node

Kishon Vijay Abraham I (2):
      arm64: dts: ti: k3-j721s2-main: Add main CPSW2G devicetree node
      arm64: dts: ti: k3-j721s2: Add overlay to enable main CPSW2G with =
GESI

Komal Bajaj (4):
      arm64: dts: qcom: qdu1000-idp: Add reserved gpio list
      arm64: dts: qcom: qru1000-idp: Add reserved gpio list
      arm64: dts: qcom: qdu1000-idp: Update reserved memory region
      arm64: dts: qcom: qru1000-idp: Update reserved memory region

Konrad Dybcio (56):
      arm64: dts: qcom: qcm2290: Add USB3 PHY
      arm64: dts: qcom: sm6350: Add GPUCC node
      arm64: dts: qcom: sm6350: Add QFPROM node
      arm64: dts: qcom: sm6350: Add GPU nodes
      arm64: dts: qcom: sm6350: Fix ZAP region
      arm64: dts: qcom: sm6350: Add DPU1 nodes
      arm64: dts: qcom: sc7180: Hook up BWMONs
      ...

Krzysztof Kozlowski (114):
      ARM: dts: qcom: ipq4019: use generic node names for USB
      ARM: dts: qcom: sdx55: use generic node names for USB
      ARM: dts: qcom: ipq8064: drop spi-max-frequency from controller
      ARM: dts: qcom: msm8960: drop spi-max-frequency from controller
      arm64: dts: qcom: sm8450: correct crypto unit address
      arm64: dts: qcom: apq8039-t2: remove superfluous "input-enable"
      arm64: dts: qcom: sc8180x-flex-5g: remove superfluous "input-enabl=
e"
      arm64: dts: qcom: msm8916-gt5: drop incorrect accelerometer interr=
upt-names
      arm64: dts: qcom: msm8916-l8150: correct light sensor VDDIO supply
      ...

Lakshmi Yadlapati (1):
      ARM: dts: aspeed: rainier: Remove TPM device

Leonard G=C3=B6hrs (5):
      dt-bindings: can: m_can: change from additional- to unevaluatedPro=
perties
      dt-bindings: net: dsa: microchip: add interrupts property for ksz =
switches
      ARM: dts: stm32: Add pinmux groups for Linux Automation GmbH TAC
      dt-bindings: arm: stm32: Add compatible string for Linux Automatio=
n LXA TAC
      ARM: dts: stm32: lxa-tac: add Linux Automation GmbH TAC

Lin, Meng-Bo (5):
      arm64: dts: qcom: msm8916-samsung-e2015: Add accelerometer
      arm64: dts: qcom: msm8916-samsung-j5-common: Add touchscreen
      dt-bindings: qcom: Document msm8939,a7
      arm64: dts: qcom: msm8939-samsung-a7: Add initial dts
      arm64: dts: qcom: msm8916-samsung-e5: Add touchscreen

Linus Walleij (1):
      ARM: dts: bcm5301x: Add SEAMA compatibles

Luca Weiss (4):
      ARM: dts: qcom: msm8226: Add mdss nodes
      ARM: dts: qcom: msm8226: Add ocmem
      arm64: dts: qcom: pm8953: Add thermal zone
      arm64: dts: qcom: sm8450: Use standalone ICE node for UFS

Lucas Tanure (3):
      arm64: dts: rockchip: add SD card support to rock-5a
      dt-bindings: arm: amlogic: add Amlogic A311D2 bindings
      arm64: dts: amlogic-t7-a311d2-khadas-vim4: add initial device-tree

Lukasz Majewski (2):
      ARM: dts: at91: ksz9477_evb: Add missing timer nodes
      ARM: dts: at91: ksz9477_evb: Add tx-internal-delay-ps property for=
 port5

Maksim Kiselev (1):
      riscv: dts: allwinner: d1: Add GPADC node

Manikanta Guntupalli (1):
      arm64: zynqmp: Fix open drain warning on ZynqMP

Manivannan Sadhasivam (4):
      arm64: dts: qcom: sdm845: Add missing RPMh power domain to GCC
      arm64: dts: qcom: sdm845: Fix the min frequency of "ice_core_clk"
      arm64: dts: qcom: sdm845: Add interconnect paths to UFSHC
      arm64: dts: qcom: sm8250: Add interconnect paths to UFSHC

Marco Felsch (4):
      arm64: dts: imx8mp-debix: remove unused fec pinctrl node
      arm64: dts: freescale: Add DEBIX SOM A and SOM A I/O Board support
      dt-bindings: arm: fsl: fix DEBIX binding
      dt-bindings: arm: Add Polyhex DEBIX SOM A based boards

Marek Vasut (5):
      ARM: dts: stm32: Deduplicate DSI node on stm32mp15
      ARM: dts: stm32: Add missing detach mailbox for emtrion emSBC-Argon
      ARM: dts: stm32: Add missing detach mailbox for Odyssey SoM
      ARM: dts: stm32: Add missing detach mailbox for DHCOM SoM
      ARM: dts: stm32: Add missing detach mailbox for DHCOR SoM

Marijn Suijten (2):
      arm64: dts: qcom: Use labels with generic node names for ADC chann=
els
      ARM: dts: qcom: Use labels with generic node names for ADC channels

Markus Niebel (1):
      dt-bindings: arm: add TQMa93xxLA SOM

Martin Kepplinger (1):
      arm64: dts: imx8mq-librem5: set audio-1v8 always-on

Matthias Schiffer (4):
      dt-bindings: arm: ti: Add compatible for AM642-based TQMaX4XxL SOM=
 family and carrier board
      arm64: dts: ti: Add TQ-Systems TQMa64XxL SoM and MBaX4XxL carrier =
board Device Trees
      arm64: dts: ti: k3-am64-tqma64xxl-mbax4xxl: add SD-card and WLAN o=
verlays
      dt-bindings: arm: fsl: add TQ-Systems LS1021A board

Michael Walle (1):
      arm64: dts: ls1028a: sl28: get MAC addresses from VPD

Michal Simek (2):
      arm64: zynqmp: Fix dwc3 usb interrupt description
      arm64: zynqmp: Describe interrupts by using macros

Minda Chen (2):
      riscv: dts: starfive: Add USB and PCIe PHY nodes for JH7110
      riscv: dts: starfive: Add USB dts node for JH7110

Mohan Kumar (1):
      arm64: tegra: Add audio support for IGX Orin

Mrinmay Sarkar (2):
      arm64: dts: qcom: sa8775p: Add pcie0 and pcie1 nodes
      arm64: dts: qcom: sa8775p-ride: enable pcie nodes

Neil Armstrong (11):
      arm64: dts: qcom: sm8[1235]50-mtp: add chassis-type property
      arm64: dts: qcom: sm8[45]50-qrd: add chassis-type property
      arm64: dts: qcom: sm8[1234]50-hdk: add chassis-type property
      arm64: dts: qcom: msm89xx-mtp: add chassis-type property
      arm64: dts: qcom: sdm845-mtp: add chassis-type property
      arm64: dts: amlogic: meson-g12b-odroid-n2: fix usb hub hog name
      arm64: dts: amlogic: meson-g12-common: change aobus-pinctrl node n=
ame
      arm64: dts: amlogic: drop cooling-[min|max]-state from pwm-fan
      arm64: dts: qcom: sm8550: add ports subnodes in usb/dp qmpphy node
      arm64: dts: qcom: sm8550-mtp: add pmic glink port/endpoints
      arm64: dts: qcom: sm8550-qrd: add pmic glink port/endpoints

Nikita Travkin (1):
      arm64: dts: qcom: sc7180: Split up TF-A related PSCI configuration

Niravkumar L Rabara (4):
      dt-bindings: intel: Add Intel Agilex5 compatible
      dt-bindings: reset: add reset IDs for Agilex5
      dt-bindings: clock: add Intel Agilex5 clock manager
      arm64: dts: agilex5: add initial support for Intel Agilex5 SoCFPGA

Nishanth Menon (7):
      arm64: dts: ti: Fix compatible of ti,*-ehrpwm-tbclk
      arm: dts: ti: omap: omap36xx: Rename opp_supply nodename
      arm: dts: ti: omap: am5729-beagleboneai: Drop the OPP
      arm: dts: ti: omap: Fix OPP table node names
      arm64: dts: ti: k3-pinctrl: Introduce debounce select mux macros
      arm64: dts: ti: k3: Fixup remaining pin group node names for make =
dtbs checks
      arm64: dts: ti: k3-am625-beagleplay: Add HDMI support

Oleksij Rempel (1):
      ARM: dts: stm32: prtt1c: Add PoDL PSE regulator nodes

Pascal Paillet (1):
      ARM: dts: stm32: fix dts check warnings on stm32mp15-scmi

Patrice Chotard (2):
      ARM: dts: st: Add gpio-ranges for stm32f746-pinctrl
      ARM: dts: st: Add gpio-ranges for stm32f769-pinctrl

Patrick Delaunay (2):
      ARM: dts: stm32: remove shmem for scmi-optee on stm32mp15
      ARM: dts: stm32: remove shmem for scmi-optee on stm32mp13

Paul Cercueil (1):
      ARM: dts: samsung: exynos4210-i9100: Fix LCD screen's physical size

Peng Fan (10):
      arm64: dts: imx93: add thermal support
      arm64: dts: imx93: add cma area for i.MX93 11x11 EVK
      arm64: dts: imx93: add cm33 node
      arm64: dts: imx93: enable CM33 for 11x11 EVK
      arm64: dts: imx8ulp: add cm33 node
      arm64: dts: imx8ulp: set default clock for SDHC
      arm64: dts: imx8ulp: add thermal node
      arm64: dts: imx8ulp: add cpuidle node
      arm64: dts: imx8ulp-evk: add reserved memory for cma
      arm64: dts: imx8ulp-evk: enable CM33 node

Peter De Schrijver (2):
      dt-bindings: reserved-memory: Add support for DRAM MRQ GSCs
      dt-bindings: firmware: Add support for tegra186-bpmp DRAM MRQ GSCs

Praveenkumar I (1):
      arm64: dts: qcom: ipq9574: Add cpu cooling maps

Radhey Shyam Pandey (1):
      arm64: zynqmp: Add L2 cache nodes

Rafa=C5=82 Mi=C5=82ecki (12):
      ARM: dts: BCM5301X: Add Ethernet interfaces links
      ARM: dts: BCM53573: Drop nonexistent "default-off" LED trigger
      ARM: dts: BCM53573: Drop nonexistent #usb-cells
      ARM: dts: BCM53573: Add cells sizes to PCIe node
      ARM: dts: BCM53573: Use updated "spi-gpio" binding properties
      dt-bindings: arm: bcm: add BCM53573 SoCs family binding
      ARM: dts: BCM53573: Fix Ethernet info for Luxul devices
      ARM: dts: BCM53573: Fix Tenda AC9 switch CPU port
      ARM: dts: BCM53573: Describe BCM53125 switch ports in the main DTS
      ARM: dts: BCM53573: Add BCM53125 switch port 5
      ARM: dts: BCM53573: Add Ethernet interfaces links
      ARM: dts: BCM53573: Disable second Ethernet on Luxul devices

Ravi Gunasekaran (1):
      arm64: dts: ti: k3-am62a7-sk: Enable dual role support for Type-C =
port

Raymond Hackley (1):
      arm64: dts: qcom: msm8939-sony-xperia-kanuti-tulip: Add missing 'c=
hassis-type'

Richard Acayan (3):
      arm64: dts: qcom: sdm670: add osm l3
      arm64: dts: qcom: sdm670: add cpu frequency scaling
      arm64: dts: qcom: sdm670: add frequency profile

Rick Wertenbroek (1):
      arm64: dts: rockchip: Add dtsi entry for RK3399 PCIe endpoint core

Rob Herring (4):
      arm64: dts: qcom: Fix "status" value
      ARM: dts: hisilicon: Fix "status" values
      ARM: dts: at91-vinco: Fix "status" values
      arm64: dts: mediatek: Fix "status" values

Robert Marko (1):
      ARM: dts: qcom: ipq4019: correct SDHCI XO clock

Rohit Agarwal (13):
      dt-bindings: power: qcom,rpmhpd: Add Generic RPMh PD indexes
      arm64: dts: qcom: sm8250: Update the RPMHPD bindings entry
      arm64: dts: qcom: sm8350: Update the RPMHPD bindings entry
      arm64: dts: qcom: sm8450: Update the RPMHPD bindings entry
      arm64: dts: qcom: sm8550: Update the RPMHPD bindings entry
      arm64: dts: qcom: sdx75: Add spmi node
      arm64: dts: qcom: Add pinctrl gpio support for pm7250b
      arm64: dts: qcom: Add pm7550ba PMIC dtsi
      arm64: dts: qcom: Add pmx75 PMIC dtsi
      arm64: dts: qcom: sdx75-idp: Add pmics supported in SDX75
      ARM: dts: qcom: sdx65-mtp: Update the pmic used in sdx65
      arm64: dts: qcom: sdx75: Add rpmhpd node
      arm64: dts: qcom: sdx75-idp: Add regulator nodes

Sameer Pujar (1):
      arm64: tegra: Update AHUB clock parent and rate

Samin Guo (3):
      riscv: dts: starfive: jh7110: Add ethernet device nodes
      riscv: dts: starfive: visionfive 2: Add configuration of gmac and =
phy
      riscv: dts: starfive: jh7110: Fix GMAC configuration

Sebastian Krzyszkowiak (3):
      arm64: dts: imx8mq-librem5-r4: Bump up proximity sensor's near lev=
el
      arm64: dts: imx8mq-librem5: Mark tps65982 as wakeup source
      arm64: dts: imx8mq-librem5: Reduce usdhc2's post-power-on-delay-ms=
 to 20ms

Sebastian Reichel (21):
      dt-bindings: vendor-prefixes: Add prefix for belling
      dt-bindings: eeprom: at24: add Belling BL24C16A
      arm64: dts: rockchip: add PMIC to rock-5a
      arm64: dts: rockchip: add vdd_cpu_big regulators to rock-5a
      arm64: dts: rockchip: add 5V regulator to rock-5a
      arm64: dts: rockchip: add status LED to rock-5a
      arm64: dts: rockchip: add analog audio to rock-5a
      arm64: dts: rockchip: add I2C EEPROM to rock-5a
      arm64: dts: rockchip: add vdd_npu_s0 regulator to rock-5a
      ...

Sharath Kumar Dasari (1):
      arm64: zynqmp: Add memory reserved node for k26 Kria SOM board

Sheetal (1):
      arm64: tegra: Update AHUB clock parent and rate on Tegra234

Sherry Sun (2):
      arm64: dts: imx8dxl: remove "fsl,imx7ulp-lpuart" compatible for im=
x8dxl
      arm64: dts: imx93: add "fsl,imx8ulp-lpuart" compatible for imx93

Shubhi Garg (1):
      arm64: tegra: Add PCIe and DP 3.3V supplies

Siddharth Vadapalli (1):
      arm64: dts: ti: k3-j721e: Add overlay to enable CPSW9G ports with =
GESI

Sinthu Raja (1):
      arm64: dts: ti: k3-j721s2-main: Add dts nodes for EHRPWMs

Sricharan Ramabadhran (3):
      dt-bindings: clock: Add IPQ5018 clock and reset
      dt-bindings: qcom: Add ipq5018 bindings
      arm64: dts: Add ipq5018 SoC and rdp432-c2 board support

Sridharan S N (2):
      arm64: dts: qcom: ipq5332: Add common RDP dtsi file
      arm64: dts: qcom: ipq5332: enable GPIO based LEDs and Buttons

Stanislav Jakubek (1):
      ARM: dts: bcm28155-ap: use node labels

Stefan Nagy (1):
      arm64: dts: rockchip: Enable internal SPI flash for ROCK Pi 4A/B/C

Stefan Wahren (3):
      ARM: dts: bcm283x: Fix pinctrl groups
      ARM: dts: bcm2835: adjust DMA node names
      ARM: dts: bcm283x: Increase pwm-cells

Stephan Gerhold (5):
      arm64: dts: qcom: Add rpm-proc node for SMD platforms
      arm64: dts: qcom: Add rpm-proc node for GLINK gplatforms
      ARM: dts: qcom: Add rpm-proc node for SMD platforms
      ARM: dts: qcom: apq8064: Drop redundant /smd node
      arm64: dts: qcom: msm8939-samsung-a7: Drop internal pull for SD CD

Stephen Chen (1):
      ARM: dts: rockchip: Enable SFC for edgeble-neu2

Sumit Gupta (1):
      arm64: tegra: Update CPU OPP tables

Tao Ren (3):
      ARM: dts: aspeed: Update spi alias in Facebook AST2500 Common dtsi
      ARM: dts: aspeed: wedge400: Enable more ADC channels
      ARM: dts: aspeed: wedge400: Set eMMC max frequency

Tengfei Fan (3):
      dt-bindings: arm: qcom: Document SM4450 SoC and boards
      arm64: dts: qcom: Adds base SM4450 DTSI
      arm64: dts: qcom: Add base SM4450 QRD DTS

Teresa Remmet (5):
      arm64: dts: imx8mp-phycore-som: Order properties alphabetically
      arm64: dts: imx8mp-phycore-som: Correct pad settings
      arm64: dts: imx8mp-phycore-som: Remove LDO2 and LDO4 pmic nodes
      arm64: dts: imx8mp-phycore-som: Add regulator names
      arm64: dts: imx8mp-phycore-som: Update regulator output voltages

Thierry Reding (22):
      dt-bindings: arm: tegra: flowctrl: Convert to json-schema
      dt-bindings: arm: tegra: ahb: Convert to json-schema
      dt-bindings: serial: tegra-hsuart: Convert to json-schema
      ARM: tegra: Remove dmas and dma-names for debug UART
      ARM: tegra: Remove reset-names for UART devices
      ARM: tegra: Add missing reset-names for Tegra HS UART
      dt-bindings: cpu: Document NVIDIA Tegra186 CCPLEX cluster
      dt-bindings: clock: tegra: Document Tegra132 compatible
      dt-bindings: arm: tegra: nvec: Convert to json-schema
      dt-bindings: thermal: tegra: Convert to json-schema
      arm64: tegra: Sort PCI nodes correctly on Orin
      ...

Thomas McKahan (2):
      dt-bindings: arm: rockchip: Add NanoPC T6
      arm64: dts: rockchip: Add NanoPC T6

Tim Harvey (17):
      arm64: dts: imx8mm-venice-gw7901: add cpu-supply node for cpufreq
      arm64: dts: imx8mm-venice-gw7901: add SDR50/SDR104 SDIO support fo=
r wifi
      arm64: dts: imx8m{m,n}-venice-gw7902: add SDR50/SDR104 SDIO suppor=
t for wifi
      arm64: dts: imx8mm-venice-gw7904: enable UART1 hardware flow contr=
ol
      arm64: dts: imx8mp-venice-gw74xx: update to revB PCB
      arm64: dts: freescale: fix imx8mm-venice-gw72xx-0x-imx219 overlay
      arm64: dts: imx8mm: add imx8mm-venice-gw73xx-0x-rpidsi overlay for=
 display
      arm64: dts: imx8mm: add imx8mm-venice-gw72xx-0x-rpidsi overlay for=
 display
      arm64: dts: imx8mp: add imx8mp-venice-gw74xx-rpidsi overlay for di=
splay
      dt-bindings: arm: Add Gateworks i.MX8M Mini GW7905-0x board
      dt-bindings: arm: Add Gateworks i.MX8M Plus gw71xx-2x board
      ...

Tony Lindgren (1):
      ARM: dts: Unify pinctrl-single pin group nodes for davinci

Udit Kumar (6):
      arm64: dts: ti: k3-j721e-som-p0: Remove Duplicated wkup_i2c0 node
      arm64: dts: ti: k3-j784s4-main: Add DT node for UFS
      arm64: dts: ti: k3-j784s4-evm: Add Support for UFS peripheral
      arm64: dts: ti: k3-j784s4-evm: Correct Pin mux offset for ospi
      arm64: dts: ti: k3-j721s2: correct pinmux offset for ospi
      arm64: dts: ti: k3-j784s4-evm: Correct Pin mux offset for ADC

Uwe Kleine-K=C3=B6nig (1):
      ARM: dts: imx25/karo-tx25: Replace NO_PAD_CTL by explicit pad conf=
iguration

Varadarajan Narayanan (4):
      dt-bindings: clock: Add USB related clocks for IPQ9574
      arm64: dts: qcom: ipq9574: Add USB related nodes
      arm64: dts: qcom: ipq9574: Add LDO regulator node
      arm64: dts: qcom: ipq9574: Enable USB

Varalaxmi Bingi (1):
      arm64: zynqmp: Setting default i2c clock frequency to 400kHz

Vignesh Raghavendra (2):
      dt-bindings: soc: ti: k3-ringacc: Describe cfg reg region
      arm64: dts: ti: k3: Add cfg reg region to ringacc node

Vincent Guittot (1):
      arm64: dts: qcom: sm8250: correct dynamic power coefficients

Walker Chen (2):
      riscv: dts: starfive: jh7110: add dma controller node
      riscv: dts: starfive: jh7110: add the node and pins configuration =
for tdm

William Qiu (6):
      dt-bindings: soc: starfive: Add StarFive syscon module
      riscv: dts: starfive: jh7110: Add syscon nodes
      riscv: dts: starfive: Add spi node and pins configuration
      riscv: dts: starfive: Add QSPI controller node for StarFive JH7110=
 SoC
      riscv: dts: starfive: enable DCDC1&ALDO4 node in axp15060
      riscv: dts: starfive: Add mmc nodes on VisionFive 2 board

Xianwei Zhao (3):
      dt-bindings: arm: amlogic: add board AN400
      arm64: dts: add board AN400
      arm64: dts: add support for C3 power domain controller

Xingyu Wu (8):
      dt-bindings: clock: Add StarFive JH7110 PLL clock generator
      dt-bindings: clock: jh7110-syscrg: Add PLL clock inputs
      dt-bindings: clock: Add StarFive JH7110 System-Top-Group clock and=
 reset generator
      dt-bindings: clock: Add StarFive JH7110 Image-Signal-Process clock=
 and reset generator
      dt-bindings: clock: Add StarFive JH7110 Video-Output clock and res=
et generator
      riscv: dts: starfive: jh7110: Add DVP and HDMI TX pixel external c=
locks
      riscv: dts: starfive: jh7110: Add STGCRG/ISPCRG/VOUTCRG nodes
      riscv: dts: starfive: jh7110: Add PLL clocks source in SYSCRG node

Yannic Moog (2):
      arm64: dts: phycore-imx8mm: fix nor mtd partitions
      arm64: dts: imx8mm-phyboard-polis: Set debug uart muxing to 0x140

Yashwanth Varakala (2):
      arm64: dts: freescale: imx8mm-phyboard-polis: Add TPM node
      arm64: dts: imx8mp-phyboard-pollux-rdk: Fix led sub-node names

Zeyan Li (1):
      arm64: dts: qcom: sm8150: Fix the I2C7 interrupt

Dirstat for brevity:
   0.0% Documentation/devicetree/bindings/arm/aspeed/
   0.0% Documentation/devicetree/bindings/arm/bcm/
   0.3% Documentation/devicetree/bindings/arm/omap/
   0.0% Documentation/devicetree/bindings/arm/stm32/
   0.1% Documentation/devicetree/bindings/arm/tegra/
   0.5% Documentation/devicetree/bindings/arm/ti/
   0.3% Documentation/devicetree/bindings/arm/
   0.9% Documentation/devicetree/bindings/clock/
   0.0% Documentation/devicetree/bindings/cpu/
   0.0% Documentation/devicetree/bindings/crypto/
   0.0% Documentation/devicetree/bindings/eeprom/
   0.1% Documentation/devicetree/bindings/firmware/
   0.0% Documentation/devicetree/bindings/net/can/
   0.0% Documentation/devicetree/bindings/net/dsa/
   0.0% Documentation/devicetree/bindings/pwm/
   0.1% Documentation/devicetree/bindings/reserved-memory/
   0.0% Documentation/devicetree/bindings/riscv/
   0.6% Documentation/devicetree/bindings/serial/
   0.1% Documentation/devicetree/bindings/soc/starfive/
   0.3% Documentation/devicetree/bindings/soc/tegra/
   0.0% Documentation/devicetree/bindings/soc/ti/
   1.9% Documentation/devicetree/bindings/thermal/
   0.0% Documentation/devicetree/bindings/
   0.0% arch/arm/boot/dts/allwinner/
   9.3% arch/arm/boot/dts/aspeed/
   1.1% arch/arm/boot/dts/broadcom/
   0.0% arch/arm/boot/dts/hisilicon/
   0.0% arch/arm/boot/dts/intel/socfpga/
   1.2% arch/arm/boot/dts/marvell/
   0.3% arch/arm/boot/dts/microchip/
   0.7% arch/arm/boot/dts/nspire/
   0.0% arch/arm/boot/dts/nuvoton/
   0.3% arch/arm/boot/dts/nvidia/
   4.1% arch/arm/boot/dts/nxp/imx/
   0.9% arch/arm/boot/dts/nxp/ls/
   1.1% arch/arm/boot/dts/nxp/mxs/
   0.0% arch/arm/boot/dts/nxp/vf/
   0.7% arch/arm/boot/dts/qcom/
   0.0% arch/arm/boot/dts/renesas/
   0.3% arch/arm/boot/dts/rockchip/
   3.1% arch/arm/boot/dts/samsung/
   3.1% arch/arm/boot/dts/st/
   0.2% arch/arm/boot/dts/ti/davinci/
   0.0% arch/arm/boot/dts/ti/keystone/
   0.3% arch/arm/boot/dts/ti/omap/
   0.7% arch/arm64/boot/dts/allwinner/
   0.0% arch/arm64/boot/dts/altera/
   0.6% arch/arm64/boot/dts/amlogic/
   0.1% arch/arm64/boot/dts/arm/
   0.0% arch/arm64/boot/dts/broadcom/bcmbca/
   0.0% arch/arm64/boot/dts/broadcom/northstar2/
   0.0% arch/arm64/boot/dts/broadcom/stingray/
   0.0% arch/arm64/boot/dts/exynos/
  11.0% arch/arm64/boot/dts/freescale/
   0.1% arch/arm64/boot/dts/hisilicon/
   1.1% arch/arm64/boot/dts/intel/
   0.0% arch/arm64/boot/dts/lg/
   0.0% arch/arm64/boot/dts/marvell/
   0.0% arch/arm64/boot/dts/mediatek/
   0.0% arch/arm64/boot/dts/microchip/
   0.0% arch/arm64/boot/dts/nuvoton/
   7.6% arch/arm64/boot/dts/nvidia/
  21.5% arch/arm64/boot/dts/qcom/
   1.1% arch/arm64/boot/dts/renesas/
   7.0% arch/arm64/boot/dts/rockchip/
   0.0% arch/arm64/boot/dts/tesla/
   9.4% arch/arm64/boot/dts/ti/
   1.0% arch/arm64/boot/dts/xilinx/
   0.0% arch/riscv/boot/dts/allwinner/
   0.0% arch/riscv/boot/dts/renesas/
   2.0% arch/riscv/boot/dts/starfive/
   0.1% arch/riscv/boot/dts/thead/
   1.1% include/dt-bindings/clock/
   0.0% include/dt-bindings/mux/
   0.0% include/dt-bindings/power/
   0.1% include/dt-bindings/regulator/
   0.5% include/dt-bindings/reset/
 926 files changed, 38580 insertions(+), 10330 deletions(-)
