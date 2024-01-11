Return-Path: <linux-kernel+bounces-23838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C89C882B297
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 17:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 372262872DE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D844A4F8AA;
	Thu, 11 Jan 2024 16:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="pa2EkzVz";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZqT5Kul5"
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72CA4CB3C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 16:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 552ED3200B18;
	Thu, 11 Jan 2024 11:16:50 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 11 Jan 2024 11:16:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1704989809;
	 x=1705076209; bh=CcbBQOkh5S3PcEvhTXXWeSl7ysYQiWp4Vja+Sy40FJw=; b=
	pa2EkzVzovgmzTtdMJUd4L1sPm2TthFPYP1PrIrMQsAlPuaXdcd0CR/lSAxaOoTL
	6PIgIWLhjytD3Zx+4l+AChIn3IiJ2arM3eJ/PeGlzT45BVBS66eZ3jGMhEjgfH99
	5pNJnZUJdT7WGQCBjgKkcfSrlId2ypg9Z54ZPE6m2a8PrhPeLDOv0zLc8/b50ubR
	KIPE1GToW1wgbo1CUmKiwO9ZCfdrjoIFodkJVR+HgvIGiBVQsnZc8zdepiTq4aM7
	NMerpayaj9OWY7O+Rrhlj8Xin/Cx+X+YSGXTMxjPffjqf/N8r28D8ggomfO/ayJ3
	QlOxsZ1YkuukMKQIpXQ0tQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1704989809; x=
	1705076209; bh=CcbBQOkh5S3PcEvhTXXWeSl7ysYQiWp4Vja+Sy40FJw=; b=Z
	qT5Kul5n4EQcbX8E+qODDTefCKZ02oHMO2S4ribk6n3sUyxmqhFhR7A2KnLz5vdY
	sJkzzm3RFPrglKfGYFalTZTa9lK2ORXTyNYvFAaPj2ib7HFIDTJPX8eoBEVb42H6
	Igs59cMz+NVa8yLaxvm1YA5m2MRhrDCY2nAF48A28kTE4N5cIiTDJ7vsbnhHXkj6
	Dk648jaLL1wyb9ax7BEK/tjKL2cehDjcyc3KMynwUdJ/EgmVt9uUOBUTTXEJEYVx
	oRaivs4W8lmdSyxeKNl7tbtjJxjHTyVrU7xZRUOW472ultLv4dYaYAukZeypVSAi
	4ZZiWqEFM6veJ5wqYoGYQ==
X-ME-Sender: <xms:cRSgZRrGUxMDmaoRgn_6fopdBNfAGoPTVeV7bOmqoHVDFxLlzs4PxA>
    <xme:cRSgZTrRlPI8QXhuxPUp4PZKCgv63HDpXJLUo7VrFIfe88qS0GYzjuN0iUMfGk7UJ
    jsRqDQqnBv8SZx6i54>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeifedgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpefgkefhheetvdethfejkeeigfehtdffieevfeefteffteejffehlefhtdeu
    veejueenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgihhthhhusgdrtghomhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnuges
    rghrnhgusgdruggv
X-ME-Proxy: <xmx:cRSgZeOJLyL5p7mV0CY0qRNDQLX8RyMC7dQObrDoEAe-aTRZNgg6nQ>
    <xmx:cRSgZc4TR4Crl7_TJAJV-7st93kxgaN__DLlRPjIakB37YCBfRFIMQ>
    <xmx:cRSgZQ5HOpzRC52lX8IvuacXyzmQnXfdPBDE9mFFCHqGRO0ZGsCAMA>
    <xmx:cRSgZeSKk5g8E8op_Ii-ksrhk9GmzOx-HXiMp0WuXa3ZKNAVE5viBA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 75DB5B6008F; Thu, 11 Jan 2024 11:16:49 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1374-gc37f3abe3d-fm-20240102.001-gc37f3abe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b1923a64-b5e6-4dac-988e-ea2a75e948d9@app.fastmail.com>
In-Reply-To: <1c120ba6-3c94-4d94-8497-afb6c5063d3c@app.fastmail.com>
References: <1c120ba6-3c94-4d94-8497-afb6c5063d3c@app.fastmail.com>
Date: Thu, 11 Jan 2024 17:16:28 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: soc@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: [GIT PULL 1/4] SoC: DT changes for 6.8
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

The following changes since commit 2cc14f52aeb78ce3f29677c2de1f06c0e9147=
1ab:

  Linux 6.7-rc3 (2023-11-26 19:59:33 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-d=
t-6.8

for you to fetch changes up to 18a1ee9d716d355361da2765f87dbbadcdea03bf:

  ARM: dts: usr8200: Fix phy registers (2024-01-11 16:21:02 +0100)

For the merge conflicts, see
https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git/commit/?h=3D=
test-merge&id=3D72d85957cce5

----------------------------------------------------------------
SoC: DT changes for 6.8

There is one new SoC for each 32-bit Arm and 64-bit RISC-V, but both
the Rockchips rv1109 and Sopgho CV1812H are just minor variations of
already supported chips.

The other six new SoCs are all part of existing arm64 families, but
are somewhat more interesting:

 - Samsung ExynosAutov920 is an automotive chip, and the first one
   we support based on the Cortex-A78AE core with lockstep mode.

 - Google gs101 (Tensor G1) is the chip used in a number of Pixel phones,
   and is grouped with Samsung Exynos here since it is based on the same
   SoC design, sharing most of its IP blocks with that series.

 - MediaTek MT8188 is a new chip used for mid-range tablets and Chromebo=
oks,
   using two Cortex-A78 cores where the older MT8195 had four of them.

 - Qualcomm SM8650 (Snapdragon 8 Gen 3) is their current top range
   phone SoC and the first supported chip based on Cortex-X4, Cortex-A720
   and Cortex-A520.

 - Qualcomm X1E80100 (Snapdragon X Elite) in turn is the latest
   Laptop chip using the custom Oryon cores.

 - Unisoc UMS9620 (Tanggula 7 series) is a 5G phone SoC based on
   Cortex-A76 and Cortex-A55

In terms of boards, we have

 - Five old Microsoft Lumia phones, the HTC One Mini 2, Motorola Moto
   G 4G, and Huawei Honor 5X/GR5, all based on Snapdragon SoCs.

 - Multiple Rockchips mobile gaming systems (Anbernic RG351V,
   Powkiddy RK2023, Powkiddy X55) along with the Sonoff iHost Smart
   Home Hub and a few Rockchips SBCs

 - Some ComXpress boards based on Marvell CN913x, which is the
   follow-up to Armada 7xxx/8xxx.

 - Six new industrial/embedded boards based on NXP i.MX8 and i.MX9

 - Mediatek MT8183 based Chromebooks from Lenovo, Asus and Acer.

 - Toradex Verdin AM62 Mallow carrier for TI AM62

 - Huashan Pi board based on the SophGo CV1812H RISC-V chip

 - Two boards based on Allwinner H616/H618

 - A number of reference boards for various added SoCs from Qualcomm,
   Mediatek, Google, Samsung, NXP and Spreadtrum

As usual, there are cleanups and warning fixes across all platforms as
well as added features for several of them.

----------------------------------------------------------------

Shortlog (slightly trimmed)

Aakarsh Jain (1):
      arm64: dts: fsd: Add MFC related DT enteries

Abel Vesa (3):
      arm64: dts: qcom: x1e80100: Add Compute Reference Device
      arm64: dts: qcom: x1e80100-crd: Fix supplies for some LDOs in PM85=
50
      arm64: dts: qcom: x1e80100-qcp: Fix supplies for some LDOs in PM85=
50

Adam Ford (10):
      arm64: dts: imx8mp-beacon-kit: Enable DSI to HDMI Bridge
      arm64: dts: imx8mp: Add NPU Node
      arm64: dts: imx8mm: Simplify mipi_dsi clocks
      arm64: dts: imx8mm: Remove video_pll1 clock rate from clk node
      arm64: dts: imx8mm: Slow default video_pll1 clock rate
      arm64: dts: imx8mm: Reduce GPU to nominal speed
      arm64: dts: imx8mm: Add optional overdrive DTSI
      arm64: dts: imx8mm-beacon: Enable overdrive mode
      arm64: dts: imx8mn: Enable Overdrive mode
      arm64: dts: imx8mn-beacon: Support overdrive mode

Ahmad Fatoum (2):
      dt-bindings: arm: stm32: don't mix SCMI and non-SCMI board compati=
bles
      ARM: dts: stm32: don't mix SCMI and non-SCMI board compatibles

Ajit Pandey (1):
      arm64: dts: qcom: sm4450: Add apps_rsc and cmd_db node

Alex Bee (14):
      dt-bindings: arm: rockchip: Add Geniatech XPI-3128
      ARM: dts: rockchip: Add sdmmc_det pinctrl for RK3128
      ARM: dts: rockchip: Add Geniatech XPI-3128 RK3128 board
      ARM: dts: rockchip: Add USB host clocks for RK3128
      ARM: dts: rockchip: Add dwc2 otg fifo siztes for RK3128
      ARM: dts: rockchip: Make usbphy the parent of SCLK_USB480M for RK3=
128
      ARM: dts: rockchip: Add gmac node for RK3128
      ARM: dts: rockchip: Enable gmac for XPI-3128
      ARM: dts: rockchip: Add power-controller for RK3128
      ARM: dts: rockchip: Add GPU node for RK3128
      ARM: dts: rockchip: Enable GPU for XPI-3128
      ARM: dts: rockchip: Move gpio aliases to SoC dtsi for RK3128
      ARM: dts: rockchip: Move i2c aliases to SoC dtsi for RK3128
      ARM: dts: rockchip: Move uart aliases to SoC dtsi for RK3128

Alex Elder (2):
      arm64: dts: qcom: sm8550: add IPA information
      arm64: dts: qcom: sm8550-qrd: enable IPA

Alexander Stein (17):
      arm64: dts: freescale: tqma9352-mba93xxla: add 'chassis-type' prop=
erty
      arm64: dts: freescale: add initial device tree for MBa93xxCA start=
er kit
      ARM: dts: imx7d: Fix coresight funnel ports
      ARM: dts: imx7s: Fix lcdif compatible
      ARM: dts: imx7s: Fix nand-controller #size-cells
      ARM: dts: imx7s: Add missing #thermal-sensor-cells
      arm64: dts: imx8mp: Add CCM interrupts
      arm64: dts: imx8mn: Add CCM interrupts
      arm64: dts: imx8mm: Add CCM interrupts
      ARM: dts: imx7s: Add DMA channels for CSPI peripherals
      ARM: dts: ti/omap: Replace deprecated extcon-usb-gpio id-gpio/vbus=
-gpio properties
      arm64: dts: freescale: Add dual-channel LVDS overlay for TQMa8MPxL
      arm64: dts: imx8mp: Disable dsp reserved memory by default
      arm64: dts: tqma8mpql: Remove invalid/unused property
      arm64: dts: imx8m*-tqma8m*: Add chassis-type
      arm64: dts: imx8qxp: Add VPU subsystem file
      arm64: dts: freescale: imx8qxp: Disable dsp reserved memory by def=
ault

Alexey Minnekhanov (1):
      ARM: dts: qcom: msm8974-klte: Remove unused property

Andre Przywara (5):
      dt-bindings: arm: sunxi: add Orange Pi Zero 2W
      arm64: dts: allwinner: h616: add Orange Pi Zero 2W support
      dt-bindings: vendor-prefixes: add Transpeed
      dt-bindings: arm: sunxi: document Transpeed 8K618-T board name
      arm64: dts: allwinner: h618: add Transpeed 8K618-T TV box

Andreas Kemnade (3):
      ARM: dts: omap4-embt2ws: enable 32K clock on WLAN
      ARM: dts: omap: logicpd-torpedo: do not disguise GNSS device
      ARM: dts: omap4-embt2ws: Add Bluetooth

Andrejs Cainikovs (2):
      ARM: dts: imx6q-apalis: add can power-up delay on ixora board
      arm64: dts: imx8-apalis: add can power-up delay on ixora board

Andrew Davis (11):
      arm64: dts: ti: k3-am64-main: Fix typo in epwm_tbclk node name
      arm64: dts: ti: k3-am65: Add chipid node to wkup_conf bus
      arm64: dts: ti: k3-j7200: Add chipid node to wkup_conf bus
      arm64: dts: ti: k3-j721e: Add chipid node to wkup_conf bus
      arm64: dts: ti: k3-j721s2: Add chipid node to wkup_conf bus
      arm64: dts: ti: k3-j784s4: Add chipid node to wkup_conf bus
      arm64: dts: ti: k3-am65: Add full compatible to dss-oldi-io-ctrl n=
ode
      arm64: dts: ti: k3-am65: Enable SDHCI nodes at the board level
      arm64: dts: ti: k3-am64: Enable SDHCI nodes at the board level
      arm64: dts: ti: k3-am625-beagleplay: Use UART name in pinmux name
      arm64: dts: ti: k3-am65: Add AM652 dtsi file

Andr=C3=A9 Apitzsch (5):
      arm64: dts: qcom: msm8916-longcheer-l8910: Enable RGB LED
      arm64: dts: qcom: msm8939-longcheer-l9100: Enable RGB LED
      arm64: dts: qcom: msm8939-longcheer-l9100: Add proximity-near-level
      ARM: dts: qcom: msm8926-motorola-peregrine: Add initial device tree
      dt-bindings: arm: qcom: Add Motorola Moto G 4G (2013)

Andy Yan (10):
      dt-bindings: soc: rockchip: add rk3588 vop/vo syscon
      arm64: dts: rockchip: Add vop on rk3588
      ARM: dts: rockchip: Add stdout-path for rk3036 kylin
      ARM: dts: rockchip: Remove rockchip,default-sample-phase from rk30=
36.dtsi
      dt-bindings: vendor-prefixes: Add Cool Pi
      dt-bindings: arm: rockchip: Add Cool Pi 4B
      arm64: dts: rockchip: Add support for rk3588s based board Cool Pi =
4B
      dt-bindings: arm: rockchip: Add Cool Pi CM5
      arm64: dts: rockchip: Add support for rk3588 based board Cool Pi C=
M5 EVB
      arm64: dts: rockchip: Fix led pinctrl of lubancat 1

AngeloGioacchino Del Regno (11):
      arm64: dts: mediatek: cherry: Add platform thermal configuration
      arm64: dts: mediatek: mt8183: Use interrupts-extended where possib=
le
      arm64: dts: mediatek: mt8173: Use interrupts-extended where possib=
le
      arm64: dts: mediatek: Use interrupts-extended where possible
      arm64: dts: mediatek: Move MT6358 PMIC interrupts to MT8183 boards
      arm64: dts: mediatek: mt8195-cherry: Add MFG0 domain supply
      arm64: dts: mediatek: mt8195-cherry: Assign sram supply to MFG1 pd
      media: dt-bindings: mediatek: Add phandle to mediatek,scp on MDP3 =
RDMA
      arm64: dts: mediatek: mt8183: Change iospaces for thermal and svs
      arm64: dts: mediatek: mt8195: Add SVS node and reduce LVTS_AP iosp=
ace
      arm64: dts: mediatek: mt8192: Add Smart Voltage Scaling node

Anusha Rao (2):
      arm64: dts: qcom: ipq9574: Add common RDP dtsi file
      arm64: dts: qcom: ipq9574: Enable WPS buttons

Aradhya Bhatia (1):
      arm64: dts: ti: k3-am62a7-sk: Add interrupt support for IO Expander

Arnd Bergmann (34):
      Merge tag 'renesas-dts-for-v6.8-tag1' of git://git.kernel.org/pub/=
scm/linux/kernel/git/geert/renesas-devel into soc/dt
      Merge tag 'hisi-arm64-dt-for-6.8' of https://github.com/hisilicon/=
linux-hisi into soc/dt
      Merge tag 'omap-for-v6.8/dt-signed' of git://git.kernel.org/pub/sc=
m/linux/kernel/git/tmlind/linux-omap into soc/dt
      Merge tag 'samsung-dt64-6.8' of https://git.kernel.org/pub/scm/lin=
ux/kernel/git/krzk/linux into soc/dt
      Merge tag 'samsung-dt-6.8' of https://git.kernel.org/pub/scm/linux=
/kernel/git/krzk/linux into soc/dt
      Merge tag 'mtk-dts64-for-v6.8' of https://git.kernel.org/pub/scm/l=
inux/kernel/git/mediatek/linux into soc/dt
      Merge tag 'v6.8-rockchip-dts64-1' of git://git.kernel.org/pub/scm/=
linux/kernel/git/mmind/linux-rockchip into soc/dt
      Merge tag 'v6.8-rockchip-dts32-1' of git://git.kernel.org/pub/scm/=
linux/kernel/git/mmind/linux-rockchip into soc/dt
      Merge tag 'juno-update-6.8' of git://git.kernel.org/pub/scm/linux/=
kernel/git/sudeep.holla/linux into soc/dt
      Merge tag 'at91-dt-6.8' of https://git.kernel.org/pub/scm/linux/ke=
rnel/git/at91/linux into soc/dt
      Merge tag 'sunxi-dt-for-6.8-1' of https://git.kernel.org/pub/scm/l=
inux/kernel/git/sunxi/linux into soc/dt
      Merge tag 'stm32-dt-for-v6.8-1' of git://git.kernel.org/pub/scm/li=
nux/kernel/git/atorgue/stm32 into soc/dt
      Merge tag 'renesas-dts-for-v6.8-tag2' of git://git.kernel.org/pub/=
scm/linux/kernel/git/geert/renesas-devel into soc/dt
      Merge tag 'ux500-dts-soc-for-v6.8' of git://git.kernel.org/pub/scm=
/linux/kernel/git/linusw/linux-integrator into soc/dt
      Merge tag 'imx-bindgins-6.8' of git://git.kernel.org/pub/scm/linux=
/kernel/git/shawnguo/linux into soc/dt
      Merge tag 'imx-dt-6.8' of git://git.kernel.org/pub/scm/linux/kerne=
l/git/shawnguo/linux into soc/dt
      Merge tag 'imx-dt64-6.8' of git://git.kernel.org/pub/scm/linux/ker=
nel/git/shawnguo/linux into soc/dt
      Merge tag 'zynqmp-dt-for-6.8' of https://github.com/Xilinx/linux-x=
lnx into soc/dt
      Merge tag 'ti-keystone-dt-for-v6.8' of https://git.kernel.org/pub/=
scm/linux/kernel/git/ti/linux into soc/dt
      Merge tag 'ti-k3-dt-for-v6.8' of https://git.kernel.org/pub/scm/li=
nux/kernel/git/ti/linux into soc/dt
      Merge tag 'qcom-arm32-for-6.8' of https://git.kernel.org/pub/scm/l=
inux/kernel/git/qcom/linux into soc/dt
      Merge tag 'samsung-dt64-6.8-2' of https://git.kernel.org/pub/scm/l=
inux/kernel/git/krzk/linux into soc/dt
      Merge tag 'mvebu-dt-6.8-1' of git://git.kernel.org/pub/scm/linux/k=
ernel/git/gclement/mvebu into soc/dt
      Merge tag 'mvebu-dt64-6.8-1' of git://git.kernel.org/pub/scm/linux=
/kernel/git/gclement/mvebu into soc/dt
      Merge tag 'amlogic-arm64-dt-for-v6.8' of https://git.kernel.org/pu=
b/scm/linux/kernel/git/amlogic/linux into soc/dt
      Merge tag 'riscv-dt-for-v6.8' of https://git.kernel.org/pub/scm/li=
nux/kernel/git/conor/linux into soc/dt
      Merge tag 'qcom-arm64-for-6.8' of https://git.kernel.org/pub/scm/l=
inux/kernel/git/qcom/linux into soc/dt
      Merge tag 'sprd-dt-6.8-rc1' of https://github.com/lyrazhang/linux =
into soc/dt
      Merge tag 'arm-soc/for-6.8/devicetree' of https://github.com/Broad=
com/stblinux into soc/dt
      Merge tag 'qcom-arm32-for-6.8-2' of https://git.kernel.org/pub/scm=
/linux/kernel/git/qcom/linux into soc/dt
      Merge tag 'qcom-arm64-for-6.8-2' of https://git.kernel.org/pub/scm=
/linux/kernel/git/qcom/linux into soc/dt
      Merge tag 'v6.8-rockchip-dts64-2' of git://git.kernel.org/pub/scm/=
linux/kernel/git/mmind/linux-rockchip into soc/dt
      Merge tag 'v6.8-rockchip-dts32-2' of git://git.kernel.org/pub/scm/=
linux/kernel/git/mmind/linux-rockchip into soc/dt
      Merge tag 'socfpga_dts_updates_for_v6.8' of git://git.kernel.org/p=
ub/scm/linux/kernel/git/dinguyen/linux into soc/dt

Arseniy Krasnov (1):
      arm64: dts: amlogic: meson-axg: pinctrl node for NAND

Balsam CHIHI (1):
      arm64: dts: mediatek: mt8192: Add thermal nodes and thermal zones

Bartosz Golaszewski (1):
      arm64: dts: qcom: qrb5165-rb5: add the Bluetooth node

Ben Wolsieffer (2):
      ARM: dts: stm32: add STM32F746 syscfg clock
      ARM: dts: stm32: add SPI support on STM32F746

Benedikt Niedermayr (1):
      arm64: dts: ti: iot2050: Definitions for runtime pinmuxing

Bhavya Kapoor (3):
      arm64: dts: ti: k3-j7200-main: Add Itap Delay Value For DDR52 spee=
d mode
      arm64: dts: ti: k3-j721s2-main: Add Itap Delay Value For DDR50 spe=
ed mode
      arm64: dts: ti: k3-j784s4-main: Add Itap Delay Value For DDR50 spe=
ed mode

Biju Das (2):
      arm64: dts: renesas: rzg2l-smarc-som: Enable 4-bit tx support
      arm64: dts: renesas: rzg2lc-smarc-som: Enable 4-bit tx support

Bjorn Andersson (9):
      Merge tag 'qcom-arm64-for-6.7-2' into arm64-for-6.8
      arm64: dts: qcom: sc8180x-primus: Fix HALL_INT polarity
      Merge tag 'qcom-dts-for-6.7-2' into arm32-for-6.8
      Merge branch '20231026105345.3376-3-bryan.odonoghue@linaro.org' in=
to arm64-for-6.8
      Merge branch '20231106-topic-sm8650-upstream-clocks-v3-5-761a6fadb=
4c0@linaro.org' into arm64-for-6.8
      Merge branch 'icc-sm8650' of https://git.kernel.org/pub/scm/linux/=
kernel/git/djakov/icc into arm64-for-6.8
      Merge branch '20231205061002.30759-4-quic_sibis@quicinc.com' into =
arm64-for-6.8
      Merge branch 'icc-x1e80100' of https://git.kernel.org/pub/scm/linu=
x/kernel/git/djakov/icc into arm64-for-6.8
      Merge branch 'icc-sm6115' of https://git.kernel.org/pub/scm/linux/=
kernel/git/djakov/icc into HEAD

Bryan O'Donoghue (4):
      dt-bindings: clock: Use gcc.yaml for common clock properties
      dt-bindings: clock: Add SC8280XP CAMCC
      arm64: dts: qcom: sc8280xp: Add in CAMCC for sc8280xp
      arm64: dts: qcom: sm8250: Add wakeup-source to usb_1 and usb_2

Bryant Mairs (1):
      ARM: dts: qcom: Disable pm8941 & pm8226 smbb charger by default

Caleb Connolly (3):
      arm64: dts: qcom: qrb4210-rb2: don't force usb peripheral mode
      arm64: dts: qcom: sdm845-oneplus: enable flash LED
      arm64: dts: qcom: qrb2210-rb1: use USB host mode

Chancel Liu (2):
      arm64: dts: imx93: Add audio device nodes
      arm64: dts: imx93: Configure clock rate for audio PLL

Chen-Yu Tsai (4):
      arm64: dts: mediatek: mt6358: Merge ldo_vcn33_* regulators
      arm64: dts: mt8183: kukui-jacuzzi: Drop bogus anx7625 panel_flag p=
roperty
      arm64: dts: mt6358: Drop bogus "regulator-fixed" compatible proper=
ties
      arm64: dts: mediatek: mt8186: Fix alias prefix for ovl_2l0

Chris Morgan (8):
      dt-bindings: arm: rockchip: Add Powkiddy RK2023
      arm64: dts: rockchip: Update powkiddy,rgb30 include to rk2023 DTSI
      arm64: dts: rockchip: Add Powkiddy RK2023
      dt-bindings: arm: rockchip: Add Powkiddy X55
      arm64: dts: rockchip: Add Powkiddy X55
      dt-bindings: arm: rockchip: Add Anbernic RG351V
      arm64: dts: rockchip: Split RG351M from Odroid Go Advance
      arm64: dts: rockchip: Add Anbernic RG351V

Chukun Pan (3):
      arm64: dts: qcom: ipq6018: Add remaining QUP UART node
      arm64: dts: qcom: ipq6018: Add QUP5 SPI node
      arm64: dts: qcom: ipq6018: fix clock rates for GCC_USB0_MOCK_UTMI_=
CLK

Chunyan Zhang (5):
      dt-bindings: arm: Add compatible strings for Unisoc's UMS9620
      arm64: dts: sprd: Add support for Unisoc's UMS9620
      arm64: dts: sprd: Removed unused clock references from etm nodes
      arm64: dts: sprd: Add clock reference for pll2 on UMS512
      arm64: dts: sprd: Change UMS512 idle-state nodename to match bindi=
ngs

Cixi Geng (1):
      arm64: dts: sprd: fix the cpu node for UMS512

Claudiu Beznea (6):
      arm64: dts: renesas: rzg3s-smarc-som: Enable SDHI2
      arm64: dts: renesas: rzg3s-smarc: Enable SDHI1
      arm64: dts: renesas: r9a08g045: Add IA55 interrupt controller node
      arm64: dts: renesas: r9a08g045: Add Ethernet nodes
      arm64: dts: renesas: rzg3s-smarc-som: Use switches' names to selec=
t on-board functionalities
      arm64: dts: renesas: rzg3s-smarc-som: Enable the Ethernet interfac=
es

Conor Dooley (3):
      riscv: dts: renesas: Convert isa detection to new properties
      Merge patch series "Add Huashan Pi board support"
      riscv: dts: microchip: add the mpfs' system controller qspi & asso=
ciated flash

Dario Binacchi (1):
      ARM: dts: stm32: use the same 3v3 for SD and DSI nodes on stm32f46=
9-disco

David Heidelberg (4):
      arm64: dts: imx8mq-phanbell: make dts use gpio-fan matrix instead =
of array
      arm64: dts: rockchip: make dts use gpio-fan matrix instead of array
      ARM: dts: marvell: make dts use gpio-fan matrix instead of array
      arm64: dts: freescale: fix the schema check errors for fsl,tmu-cal=
ibration

Dmitry Baryshkov (63):
      arm64: dts: qcom: sm8150: extend the size of the PDC resource
      arm64: dts: qcom: ipq6018: switch USB QMP PHY to new style of bind=
ings
      arm64: dts: qcom: ipq8074: switch USB QMP PHY to new style of bind=
ings
      arm64: dts: qcom: msm8996: switch USB QMP PHY to new style of bind=
ings
      arm64: dts: qcom: msm8998: switch USB QMP PHY to new style of bind=
ings
      arm64: dts: qcom: sdm845: switch USB QMP PHY to new style of bindi=
ngs
      arm64: dts: qcom: sm8150: switch USB QMP PHY to new style of bindi=
ngs
..

Douglas Anderson (9):
      arm64: dts: qcom: sc7180: Make watchdog bark interrupt edge trigge=
red
      arm64: dts: qcom: sc7280: Make watchdog bark interrupt edge trigge=
red
      arm64: dts: qcom: sdm845: Make watchdog bark interrupt edge trigge=
red
      arm64: dts: qcom: sm8150: Make watchdog bark interrupt edge trigge=
red
      arm64: dts: qcom: sm8250: Make watchdog bark interrupt edge trigge=
red
      arm64: dts: qcom: sa8775p: Make watchdog bark interrupt edge trigg=
ered
      arm64: dts: qcom: sc8280xp: Make watchdog bark interrupt edge trig=
gered
      arm64: dts: qcom: sm6350: Make watchdog bark interrupt edge trigge=
red
      arm64: dts: qcom: sc7180: Switch pompom to the generic edp-panel

Dragan Simic (6):
      arm64: dts: rockchip: Remove ethernet0 alias from the SoC dtsi for=
 RK3399
      arm64: dts: rockchip: Remove ethernet0 alias from the SoC dtsi for=
 RK3368
      arm64: dts: rockchip: Remove ethernetX aliases from the SoC dtsi f=
or RK3328
      arm64: dts: rockchip: Remove ethernet0 alias from the SoC dtsi for=
 PX30
      arm64: dts: rockchip: Add ethernet0 alias to the dts for RK3566 bo=
ards
      arm64: dts: rockchip: Add ethernet0 alias to the dts for RK3588(S)=
 boards

Drew Fustini (3):
      riscv: dts: thead: Add TH1520 mmc controllers and sdhci clock
      riscv: dts: thead: Enable BeagleV Ahead eMMC and microSD
      riscv: dts: thead: Enable LicheePi 4A eMMC and microSD

Elad Nachman (3):
      MAINTAINERS: add ac5 to list of maintained Marvell dts files
      dt-bindings: arm64: add Marvell COM Express boards
      arm64: dts: cn913x: add device trees for COM Express boards

Emil Renner Berthing (6):
      riscv: dts: starfive: Mark the JH7100 as having non-coherent DMAs
      riscv: dts: starfive: Add JH7100 cache controller
      riscv: dts: starfive: Add pool for coherent DMA memory on JH7100 b=
oards
      riscv: dts: starfive: Add JH7100 MMC nodes
      riscv: dts: starfive: Enable SD-card on JH7100 boards
      riscv: dts: starfive: Enable SDIO wifi on JH7100 boards

Esteban Blanc (2):
      arm64: dts: ti: k3-j7200-som-p0: Add TP6594 family PMICs
      arm64: dts: ti: k3-j721s2-som-p0: Add TP6594 family PMICs

Eugen Hristev (2):
      dt-bindings: arm: mediatek: convert audsys and mt2701-afe-pcm to y=
aml
      arm64: dts: mediatek: mt8186: fix address warning for ADSP mailbox=
es

Fabio Estevam (45):
      arm64: dts: imx8mm-venice-gw7: Fix pci sub-nodes
      arm64: dts: imx8qm-ss-dma: Pass lpuart dma-names
      arm64: dts: imx8mm-emcon-avari: Fix gpio-cells
      arm64: dts: imx8dxl-ss-conn: Fix Ethernet interrupt-names order
      arm64: dts: imx8mm-nitrogen-r2: Fix I2C mux subnode name
      arm64: dts: imx8mp-debix-model-a: Use phy-mode
      arm64: dts: imx8qxp-mek: Fix gpio-sbu-mux compatible
      arm64: dts: imx93: Remove unexistent 'shared-interrupt'
..

Fenglin Wu (2):
      arm64: dts: qcom: sm8550-mtp: Add pm8010 regulators
      arm64: dts: qcom: sm8550-qrd: add PM8010 regulators

Frank Li (1):
      arm64: dts: freescale: imx93: add i3c1 and i3c2

Garrett Giordano (4):
      arm64: dts: ti: phycore-am64: Add R5F DMA Region and Mailboxes
      arm64: dts: ti: k3-am625-phyboard-lyra-rdk: Lower I2C1 frequency
      arm64: dts: ti: k3-am625-phyboard-lyra-rdk: Add HDMI support
      arm64: dts: ti: k3-am625-phyboard-lyra-rdk: Remove HDMI Reset Line=
 Name

Geert Uytterhoeven (12):
      ARM: dts: renesas: marzen: Add FLASH node
      ARM: dts: renesas: blanche: Add FLASH node
      ARM: dts: renesas: rcar-gen2: Fix I2C bus demux node names
      ARM: dts: renesas: Add missing ADV751[13] power supply properties
      arm64: dts: renesas: Add missing ADV751[13] power supply properties
      ARM: dts: renesas: iwg22d-sodimm: Fix stmpe node names
      ARM: dts: renesas: marzen: Rename keyboard nodes
      ARM: shmobile: defconfig: Switch to DRM_SHMOBILE
      ARM: dts: renesas: r8a7740: Add LCDC nodes
      ARM: dts: renesas: armadillo800eva: Add LCD panel
      riscv: dts: starfive: Group tuples in interrupt properties
      arm64: dts: renesas: white-hawk-cpu: Fix missing serial console pi=
n control

Gianluca Boiano (1):
      arm64: dts: qcom: msm8953: add SPI interfaces

Gokul Sriram Palanisamy (1):
      arm64: dts: qcom: ipq5018: enable the CPUFreq support

Gregor Herburger (2):
      dt-bindings: arm: fsl: Add TQ-Systems LX2160A based boards
      arm64: dts: freescale: add fsl-lx2160a-mblx2160a board

Haibo Chen (3):
      arm64: dts: imx93-11x11-evk: set SION for cmd and data pad of USDHC
      arm64: dts: imx93: change tuning start to get a large scan range f=
or standard tuning
      arm64: dts: imx93-11x11-evk: add 12 ms delay to make sure the VDD_=
SD power off

Heiko Stuebner (6):
      dt-bindings: arm: rockchip: Add Theobroma-Systems Jaguar SBC
      arm64: dts: rockchip: add Theobroma Jaguar SBC
      arm64: dts: rockchip: move rk3588 serial aliases to soc dtsi
      arm64: dts: rockchip: add rk3588 i2c aliases to soc dtsi
      arm64: dts: rockchip: add rk3588 gpio aliases to soc dtsi
      arm64: dts: rockchip: add rk3588 spi aliases to soc dtsi

Hiago De Franco (3):
      ARM: dts: imx6qdl-apalis: Add usdhc aliases
      ARM: dts: imx6qdl-colibri: Add usdhc aliases
      ARM: dts: imx7d-colibri-emmc: Add usdhc aliases

Hsiao Chien Sung (6):
      dt-bindings: display: mediatek: ethdr: Add compatible for MT8188
      dt-bindings: display: mediatek: mdp-rdma: Add compatible for MT8188
      dt-bindings: display: mediatek: merge: Add compatible for MT8188
      dt-bindings: display: mediatek: padding: Add MT8188
      dt-bindings: arm: mediatek: Add compatible for MT8188
      dt-bindings: reset: mt8188: Add VDOSYS reset control bits

Hsin-Yi Wang (6):
      dt-bindings: arm64: mediatek: Add mt8183-kukui-katsu
      arm64: dts: mt8183: Add kukui katsu board
      dt-bindings: arm64: mediatek: Add mt8183-kukui-jacuzzi-makomo
      arm64: dts: mt8183: Add jacuzzi makomo board
      dt-bindings: arm64: mediatek: Add mt8183-kukui-jacuzzi-pico
      arm64: dts: mt8183: Add jacuzzi pico/pico6 board

Hugh Cole-Baker (1):
      arm64: dts: rockchip: Support poweroff on NanoPC-T6

Hugo Villeneuve (8):
      dt-bindings: vendor-prefixes: add rve
      dt-bindings: arm: fsl: add RVE gateway board
      arm64: dts: imx8mn-var-som: add fixed 3.3V regulator for EEPROM
      arm64: dts: freescale: introduce rve-gateway board
      arm64: dts: imx8mn-var-som-symphony: add vcc supply for PCA9534
      dt-bindings: vendor-prefixes: add dimonoff
      dt-bindings: arm: fsl: add Dimonoff gateway EVK board
      arm64: dts: freescale: introduce dimonoff-gateway-evk board

Hugues Fruchet (1):
      ARM: dts: stm32: add dcmipp support to stm32mp135

Huqiang Qin (2):
      arm64: dts: Add watchdog node for Amlogic C3 SoCs
      arm64: dts: Add watchdog node for Amlogic S4 SoCs

Imran Shaik (1):
      arm64: dts: qcom: qdu1000: Add ECPRI clock controller

Inochi Amaoto (7):
      dt-bindings: interrupt-controller: Add SOPHGO CV1812H plic
      dt-bindings: timer: Add SOPHGO CV1812H clint
      dt-bindings: riscv: Add SOPHGO Huashan Pi board compatibles
      riscv: dts: sophgo: Separate compatible specific for CV1800B soc
      riscv: dts: sophgo: cv18xx: Add gpio devices
      riscv: dts: sophgo: add initial CV1812H SoC device tree
      riscv: dts: sophgo: add Huashan Pi board device tree

J.R. Divya Antony (1):
      arm64: dts: qcom: msm8916-asus-z00l: Add sound and modem

Jaewon Kim (10):
      arm64: dts: exynos: add gpio-key node for exynosautov9-sadk
      dt-bindings: samsung: exynos-sysreg: add exynosautov920 sysreg
      dt-bindings: samsung: exynos-pmu: add exynosautov920 compatible
      dt-bindings: samsung: usi: add exynosautov920-usi compatible
      dt-bindings: serial: samsung: add exynosautov920-uart compatible
      dt-bindings: pwm: samsung: add exynosautov920 compatible
      dt-bindings: arm: samsung: Document exynosautov920 SADK board bind=
ing
      dt-bindings: hwinfo: samsung,exynos-chipid: add exynosautov920 com=
patible
      arm64: dts: exynos: add initial support for exynosautov920 SoC
      arm64: dts: exynos: add minimal support for exynosautov920 sadk bo=
ard

Jagan Teki (2):
      dt-bindings: arm: rockchip: Update edgeble-neu6 bindings
      arm64: dts: rockchip: Use NCM6A-IO board for edgeble-neu6b

Jai Luthra (8):
      arm64: dts: ti: k3-am62-main: Enable CSI2-RX
      arm64: dts: ti: k3-am62a-main: Enable CSI2-RX
      arm64: dts: ti: k3-am625-beagleplay: Add overlays for OV5640
      arm64: dts: ti: k3-am62x-sk: Enable camera peripherals
      arm64: dts: ti: k3-am62x: Add overlays for OV5640
      arm64: dts: ti: k3-am62a7-sk: Enable camera peripherals
      arm64: dts: ti: k3-am62x: Add overlay for IMX219
      arm64: dts: ti: Use OF_ALL_DTBS for combined blobs

Jan Kiszka (3):
      arm64: dts: ti: iot2050: Re-add aliases
      arm64: dts: ti: iot2050: Drop unused ecap0 PWM
      arm64: dts: ti: iot2050: Add icssg-prueth nodes for PG2 devices

Jasper Korten (1):
      arm64: dts: qcom: msm8916-samsung-gt5: Add sound and modem

Jerome Neanne (2):
      arm64: dts: ti: k3-j721e-som-p0: Add TP6594 family PMICs
      arm64: dts: ti: k3-j784s4-evm: Add support for TPS6594 PMIC

Jianhua Lu (2):
      arm64: dts: qcom: sm8250-xiaomi-elish: Fix typos
      arm64: dts: qcom: sm8250-xiaomi-elish: Add pm8150b type-c node and=
 enable usb otg

Jimmy Hon (2):
      arm64: dts: rockchip: add USB3 host on rk3588s-orangepi-5
      arm64: dts: rockchip: Support poweroff on Orange Pi 5

Joao Paulo Goncalves (7):
      dt-bindings: arm: fsl: add verdin imx8mm mallow board
      dt-bindings: arm: fsl: add verdin imx8mp mallow board
      arm64: dts: freescale: verdin-imx8mm: add support to mallow board
      arm64: dts: freescale: verdin-imx8mp: add support to mallow board
      arm64: dts: ti: verdin-am62: Improve spi1 chip-select pinctrl
      dt-bindings: arm: ti: Add verdin am62 mallow board
      arm64: dts: ti: Add verdin am62 mallow board

Joel Selvaraj (1):
      arm64: dts: qcom: sdm845-xiaomi-beryllium: enable flash led

Johan Hovold (26):
      arm64: dts: qcom: sc8280xp-x13s: add missing camera LED pin config
      arm64: dts: qcom: sc8280xp-crd: fix eDP phy compatible
      arm64: dts: qcom: sa8775p: fix USB wakeup interrupt types
      arm64: dts: qcom: sc7180: fix USB wakeup interrupt types
      arm64: dts: qcom: sc7280: fix usb_1 wakeup interrupt types
      arm64: dts: qcom: sc7280: fix usb_2 wakeup interrupt types
..

Johan Jonker (4):
      ARM: dts: rockchip: add gpio alias for gpio dt nodes
      ARM: dts: rockchip: fix rk3036 hdmi ports node
      ARM: dts: rockchip: add hdmi-connector node to rk3036-kylin
      arm64: dts: rockchip: add gpio alias for gpio dt nodes

John Clark (4):
      arm64: dts: rockchip: nanopc-t6 sdmmc beautification
      arm64: dts: rockchip: support poweroff on the rock-5b
      arm64: dts: rockchip: correct gpio_pwrctrl1 typo on rock-5b
      arm64: dts: rockchip: correct gpio_pwrctrl1 typo on nanopc-t6

Jonathan Albrieux (1):
      arm64: dts: qcom: msm8916-longcheer-l8910: Add sound and modem

Jo=C3=A3o Rodrigues (1):
      ARM: dts: imx: tqma7: add lm75a sensor (rev. 01xxx)

Kathiravan Thirumoorthy (7):
      arm64: dts: qcom: ipq8074: include the GPLL0 as clock provider for=
 mailbox
      arm64: dts: qcom: ipq6018: include the GPLL0 as clock provider for=
 mailbox
      arm64: dts: qcom: ipq9574: include the GPLL0 as clock provider for=
 mailbox
      arm64: dts: qcom: ipq5332: include the GPLL0 as clock provider for=
 mailbox
      arm64: dts: qcom: ipq9574: enable GPIO based LED
      arm64: dts: qcom: ipq5332: add missing properties to the GPIO LED =
node
      arm64: dts: qcom: ipq5018: add few more reserved memory regions

Kieran Bingham (2):
      arm64: dts: freescale: debix-som: Add heartbeat LED
      arm64: dts: freescale: debix-som-a-bmb-08: Add CSI Power Regulators

Komal Bajaj (3):
      dt-bindings: arm: qcom: Add QCM6490 IDP and QCS6490 RB3Gen2 board
      arm64: dts: qcom: Add base qcm6490 idp board dts
      arm64: dts: qcom: Add base qcs6490-rb3gen2 board dts

Konrad Dybcio (39):
      arm64: dts: qcom: sm6375: Add UART1
      arm64: dts: qcom: sm6375-pdx225: Enable MSS
      arm64: dts: qcom: sm6375-pdx225: Enable ATH10K WiFi
      arm64: dts: qcom: sm6375-pdx225: Add USBPHY regulators
      arm64: dts: qcom: sc8280xp-x13s: Use the correct DP PHY compatible
      arm64: dts: qcom: sm6115: Add UART3
      arm64: dts: qcom: qrb4210-rb2: Enable bluetooth
      arm64: dts: qcom: sc8280xp: Add QMP handle to RPMh stats
      arm64: dts: qcom: sc7180: Add the missing MDSS icc path
..

Krzysztof Kozlowski (98):
      dt-bindings: hwinfo: samsung,exynos-chipid: add specific compatibl=
es for existing SoC
      dt-bindings: i2c: exynos5: add specific compatibles for existing S=
oC
      dt-bindings: i2c: samsung,s3c2410-i2c: add specific compatibles fo=
r existing SoC
      dt-bindings: mmc: samsung,exynos-dw-mshc: add specific compatibles=
 for existing SoC
      dt-bindings: rtc: s3c-rtc: add specific compatibles for existing S=
oC
      dt-bindings: serial: samsung: add specific compatibles for existin=
g SoC
      dt-bindings: samsung: exynos-pmu: add specific compatibles for exi=
sting
 ...

Lech Perczak (1):
      ARM: dts: nxp: imx7d-pico: add cpu-supply nodes

Lin, Meng-Bo (2):
      arm64: dts: qcom: msm8916-samsung-j5: Add sound and modem
      arm64: dts: qcom: msm8939-samsung-a7: Add sound and modem

Linus Walleij (8):
      ARM: dts: nxp: Fix some common switch mistakes
      ARM: dts: marvell: Fix some common switch mistakes
      ARM64: dts: marvell: Fix some common switch mistakes
      ARM64: dts: Add special compatibles for the Turris Mox
      ARM: dts: ux500-href: Push AB8500 inclusion to the top
      ARM: dts: ux500-href: Push AB8500 config out
      ARM: dts: ux500-href: Switch HREF520 to AB8505
      ARM: dts: usr8200: Fix phy registers

Luca Weiss (30):
      arm64: dts: qcom: sc7280: Add ports subnodes in usb/dp qmpphy node
      arm64: dts: qcom: sc7280: Add Camera Control Interface busses
      arm64: dts: qcom: pm7250b: Use correct node name for gpios
      ARM: dts: qcom: msm8974: replace incorrect indentation in intercon=
nect
      ARM: dts: qcom: msm8974: sort nodes by reg
      ARM: dts: qcom: msm8226: provide dsi phy clocks to mmcc
      iio: adc: Add PM7325 PMIC7 ADC bindings
      arm64: dts: qcom: qcm6490-fairphone-fp5: Add PM7250B thermals
      arm64: dts: qcom: qcm6490-fairphone-fp5: Add PMK7325 thermals
      arm64: dts: qcom: qcm6490-fairphone-fp5: Add PM7325 thermals
..

Luka Panio (2):
      dt-bindings: arm: qcom: Add Xiaomi Pad 6 (xiaomi-pipa)
      arm64: dts: qcom: sm8250-xiaomi-pipa: Add initial device tree

Lukas Bulwahn (1):
      MAINTAINERS: adjust file entry in GOOGLE TENSOR SoC SUPPORT

Lukas Walter (2):
      dt-bindings: arm: qcom: Add Huawei Honor 5X / GR5 (2016)
      arm64: dts: qcom: msm8939-huawei-kiwi: Add initial device tree

Lukasz Luba (1):
      arm64: dts: rockchip: Add dynamic-power-coefficient to rk3399 GPU

Manivannan Sadhasivam (5):
      arm64: dts: qcom: sm8250: Add OPP table support to UFSHC
      ARM: dts: qcom: Use "pcie" as the node name instead of "pci"
      arm64: dts: qcom: Use "pcie" as the node name instead of "pci"
      arm64: dts: qcom: sa8775p: Add missing space between node name and=
 braces
      ARM: dts: qcom: sdx55: Fix the base address of PCIe PHY

Manorit Chawdhry (2):
      arm64: dts: ti: k3-am65: Add additional regs for DMA components
      arm64: dts: ti: k3-j7*: Add additional regs for DMA components

Mao Jinlong (3):
      arm64: dts: qcom: msm8996: Fix 'in-ports' is a required property
      arm64: dts: qcom: msm8998: Fix 'out-ports' is a required property
      arm64: dts: qcom: Fix coresight warnings in in-ports and out-ports

Marco Felsch (1):
      ARM: dts: imx7: add MIPI-DSI support

Marek Vasut (1):
      arm64: dts: imx8mp: Describe M24C32-D write-lockable page in DH i.=
MX8MP DHCOM DT

Mark Tseng (1):
      dt-bindings: soc: mediatek: add mt8186 and mt8195 svs dt-bindings

Markus Niebel (2):
      ARM: dts: imx6qdl: mba6: fix typo in comments
      ARM: dts: imx6ul: mba6ulx: fix typo in comments

Matti Lehtim=C3=A4ki (1):
      ARM: dts: qcom: msm8974: Add watchdog node

Michael Trimarchi (1):
      arm64: dts: imx8mn-bsh-smm-s2/pro: add display setup

Michael Walle (2):
      dt-bindings: display: mediatek: dsi: add compatible for MediaTek M=
T8195
      arm64: dts: mediatek: mt8195: add DSI and MIPI DPHY nodes

Michal Simek (11):
      arm64: xilinx: Do not use '_' in DT node names
      arm64: xilinx: Use lower case for partition address
      arm64: xilinx: Remove mt25qu512a compatible string from SOM
      arm64: xilinx: Put ethernet phys to mdio node
      arm64: xilinx: Remove address/size-cells from flash node
      arm64: xilinx: Remove address/size-cells from gem nodes
      dt-bindings: soc: xilinx: Move xilinx.yaml from arm to soc
      dt-bindings: soc: Add new board description for MicroBlaze V
      arm64: zynqmp: Move fixed clock to / for kv260
      arm64: zynqmp: Fix clock node name in kv260 cards
      arm64: zynqmp: Add missing destination mailbox compatible

Mihai Sain (4):
      ARM: dts: microchip: sam9x60_curiosity: Add IRQ support for ethern=
et PHY
      ARM: dts: microchip: sam9x60ek: Add IRQ support for ethernet PHY
      ARM: dts: microchip: sama5d27_wlsom1_ek: Remove mmc-ddr-3_3v prope=
rty from sdmmc0 node
      ARM: dts: microchip: sama5d27_som1_ek: Remove mmc-ddr-3_3v propert=
y from sdmmc0 node

Moudy Ho (19):
      dt-bindings: media: mediatek: mdp3: correct RDMA and WROT node wit=
h generic names
      dt-bindings: media: mediatek: mdp3: merge the indentical RDMA unde=
r display
      dt-bindings: media: mediatek: mdp3: add config for MT8195 RDMA
      dt-bindings: media: mediatek: mdp3: add compatible for MT8195 RSZ
      dt-bindings: media: mediatek: mdp3: add compatible for MT8195 WROT
      dt-bindings: media: mediatek: mdp3: add component FG for MT8195
..

Mukesh Ojha (3):
      arm64: dts: qcom: sm8250: Add TCSR halt register space
      arm64: dts: qcom: sm8350: Add TCSR halt register space
      arm64: dts: qcom: sm8550: Enable download mode register write

Neha Malcom Francis (2):
      arm64: dts: ti: k3-am69-sk: Add support for TPS6594 PMIC
      arm64: dts: ti: k3-j721e-sk: Add TPS6594 family PMICs

Neil Armstrong (23):
      arm64: dts: qcom: sm8550: add TRNG node
      arm64: dts: qcom: sm8450: add TRNG node
      dt-bindings: interconnect: document the RPMh Network-On-Chip Inter=
connect in Qualcomm SM8650 SoC
      dt-bindings: soc: amlogic,meson-gx-hhi-sysctrl: add example coveri=
ng meson-axg-hhi-sysctrl
      dt-bindings: clock: qcom: document the SM8650 TCSR Clock Controller
..

Nia Espera (4):
      dt-bindings: iio: adc: qcom: Add Qualcomm smb139x
      arm64: dts: qcom: sm8350: Fix DMA0 address
      arm64: dts: qcom: pm8350k: Remove hanging whitespace
      arm64: dts: qcom: sm8350: Fix remoteproc interrupt type

Nikita Travkin (6):
      arm64: dts: qcom: msm8916-longcheer-l8150: Add sound and modem
      arm64: dts: qcom: pm8916: Add BMS and charger
      arm64: dts: qcom: msm8916-longcheer-l8150: Add battery and charger
      arm64: dts: qcom: acer-aspire1: Enable RTC
      arm64: dts: qcom: acer-aspire1: Correct audio codec definition
      arm64: dts: qcom: acer-aspire1: Add sound

Niklas S=C3=B6derlund (4):
      arm64: dts: renesas: draak: Make HDMI the default video input
      arm64: dts: renesas: draak: Move HDMI bus properties to correct no=
de
      arm64: dts: renesas: r9a09g011: Add missing space in compatible
      ARM: dts: renesas: r9a06g032: Add missing space in compatible

Nitheesh Sekar (2):
      arm64: dts: qcom: ipq5018: Add USB related nodes
      arm64: dts: qcom: ipq5018: Enable USB

Nitin Rawat (2):
      arm64: dts: qcom: sc7280: Add UFS nodes for sc7280 soc
      arm64: dts: qcom: sc7280: Add UFS nodes for sc7280 IDP board

Nitin Yadav (1):
      arm64: dts: ti: k3-am62a-main: Fix GPIO pin count in DT nodes

N=C3=ADcolas F. R. A. Prado (1):
      arm64: dts: mediatek: mt8173: Drop VDEC_SYS reg from decoder

Oleksij Rempel (2):
      dt-bindings: arm: Add compatible for SKOV i.MX8MP RevB board
      arm64: dts: freescale: Add SKOV IMX8MP CPU revB board

Om Prakash Singh (3):
      arm64: dts: qcom: sa8775p: add TRNG node
      arm64: dts: qcom: sc7280: add TRNG node
      arm64: dts: qcom: sc7280: add QCrypto nodes

Parth Pancholi (1):
      arm64: dts: ti: k3-am625-verdin: Enable Verdin UART2

Patrick Delaunay (1):
      arm64: dts: st: add bsec support to stm32mp25

Paul Cercueil (3):
      ARM: dts: samsung: exynos4210-i9100: Unconditionally enable LDO12
      ARM: dts: samsung: exynos4210-i9100: Add node for touch keys
      ARM: dts: samsung: exynos4210-i9100: Add accelerometer node

Peng Fan (1):
      arm64: dts: imx93: update anatop node

Peter Griffin (7):
      dt-bindings: soc: samsung: exynos-pmu: Add gs101 compatible
      dt-bindings: clock: Add Google gs101 clock management unit bindings
      dt-bindings: soc: google: exynos-sysreg: add dedicated SYSREG comp=
atibles to GS101
      dt-bindings: arm: google: Add bindings for Google ARM platforms
      arm64: dts: exynos: google: Add initial Google gs101 SoC support
      arm64: dts: exynos: google: Add initial Oriole/pixel 6 board suppo=
rt
      MAINTAINERS: add entry for Google Tensor SoC

Philipp Zabel (1):
      ARM: dts: imx7s: Add on-chip memory

Priyansh Jain (1):
      arm64: dts: qcom: Enable tsens and thermal for sa8775p SoC

Rafa=C5=82 Mi=C5=82ecki (2):
      ARM: dts: broadcom: Add BCM63138's high speed UART
      dt-bindings: thermal: convert Mediatek Thermal to the json-schema

Raghavendra Kakarla (1):
      arm64: dts: qcom: sa8775p: Add RPMh sleep stats

Rajendra Nayak (6):
      dt-bindings: interconnect: Add Qualcomm X1E80100 SoC
      dt-bindings: clock: qcom: Add X1E80100 GCC clocks
      dt-bindings: clock: qcom-rpmhcc: Add RPMHCC bindings for X1E80100
      dt-bindings: arm: cpus: Add qcom,oryon compatible
      dt-bindings: arm: qcom: Document X1E80100 SoC and boards
      arm64: dts: qcom: Add base X1E80100 dtsi and the QCP dts

Raymond Hackley (1):
      arm64: dts: qcom: msm8916-acer-a1-724: Add notification LED

Rayyan Ansari (6):
      dt-bindings: arm: qcom: Document MSM8x26-based Lumia phones
      ARM: dts: qcom: add common dt for MSM8x26 Lumias along with Nokia =
Lumia 630
      ARM: dts: qcom: add device tree for Microsoft Lumia 640
      ARM: dts: qcom: add device tree for Microsoft Lumia 640 XL
      ARM: dts: qcom: add device tree for Nokia Lumia 735
      ARM: dts: qcom: add device tree for Nokia Lumia 830

Richard Acayan (2):
      arm64: dts: qcom: sdm670: add specific cpufreq compatible
      arm64: dts: qcom: sdm670: add display subsystem

Rob Herring (3):
      arm: dts: omap: Apply am57xx-idk overlays to base dtbs
      dt-bindings: hisilicon: Merge hi3620-clock into hisilicon,sysctrl =
binding
      arm64: dts: xilinx: Apply overlays to base dtbs

Robert Marko (5):
      arm64: dts: qcom: ipq5018: add QUP1 SPI controller
      dt-bindings: clocks: qcom,gcc-ipq8074: allow QMP PCI PHY PIPE cloc=
ks
      arm64: dts: qcom: ipq8074: pass QMP PCI PHY PIPE clocks to GCC
      arm64: dts: qcom: ipq6018: use CPUFreq NVMEM
      arm64: dts: qcom: ipq8074: Add QUP4 SPI node

Rohit Agarwal (3):
      arm64: dts: qcom: Add interconnect nodes for SDX75
      arm64: dts: qcom: Add USB3 and PHY support on SDX75
      arm64: dts: qcom: sdx75-idp: Enable USB3 and PHY support

Ronald Wahl (1):
      arm64: dts: ti: k3-am62-main: Add gpio-ranges properties

Sam Edwards (1):
      arm64: dts: rockchip: Fix rk3588 USB power-domain clocks

Sarah Walker (1):
      arm64: dts: ti: k3-am62-main: Add GPU device node

Sebastian Reichel (3):
      arm64: dts: rockchip: add analog audio to RK3588 EVB1
      arm64: dts: rockchip: add USB3 host to rock-5b
      arm64: dts: rockchip: add USB3 host to rock-5a

Shazad Hussain (1):
      arm64: dts: qcom: sa8775p-ride: enable pmm8654au_0_pon_resin

Sibi Sankar (1):
      dt-bindings: arm: qcom-soc: extend pattern matching for X1E80100 S=
oC

Siddharth Vadapalli (3):
      arm64: dts: ti: k3-am68-sk-base-board: Add alias for MCU CPSW2G
      arm64: dts: ti: k3-j721e-evm: Add overlay for PCIE0 Endpoint Mode
      arm64: dts: ti: k3-j721s2-evm: Add overlay for PCIE1 Endpoint Mode

Sjoerd Simons (1):
      arm64: dts: armada-3720-turris-mox: set irq type for RTC

Sridharan S N (1):
      dt-bindings: arm: qcom: drop the IPQ board types

Steev Klimaszewski (1):
      arm64: dts: qcom: sdm850-lenovo-yoga: Add wakeup-sources

Stephan Gerhold (13):
      arm64: dts: qcom: msm8916-samsung-gt5: Enable GPU
      arm64: dts: qcom: msm8939-longcheer-l9100: Enable wcnss_mem
      arm64: dts: qcom: msm8916-*: Fix alphabetic node order
      arm64: dts: qcom: msm8916: Add QDSP6
..

Stephen Boyd (1):
      dt-bindings: arm: qcom: Fix html link

Su Bao Cheng (1):
      arm64: dts: ti: iot2050: Refactor the m.2 and minipcie power pin

Tengfei Fan (4):
      arm64: dts: qcom: sm4450: Add RPMH and Global clock
      arm64: dts: qcom: sm4450: add uart console support
      arm64: dts: qcom: sm4450-qrd: add QRD4450 uart support
      arm64: dts: qcom: sm4450-qrd: mark QRD4450 reserved gpios

Tianling Shen (1):
      arm64: dts: rockchip: configure eth pad driver strength for orange=
pi r1 plus lts

Tim Harvey (3):
      arm64: dts: imx8mm-venice-gw72xx: add TPM device
      arm64: dts: imx8mp-venice-gw72xx: add TPM device
      arm64: dts: imx8mp-venice-gw74xx: remove unecessary propreties in =
tpm node

Tim Lunn (7):
      ARM: dts: rockchip: Add alternate UART pins to rv1126
      ARM: dts: rockchip: Serial aliases for rv1126
      ARM: dts: rockchip: Add i2c2 node to rv1126
      ARM: dts: rockchip: Split up rgmii1 pinctrl on rv1126
      ARM: dts: rockchip: Add rv1109 SoC
      dt-bindings: arm: rockchip: Add Sonoff iHost
      ARM: dts: rockchip: Add Sonoff iHost Smart Home Hub

Tomi Valkeinen (1):
      arm64: dts: ti: k3-am65-main: Fix DSS irq trigger type

Tony Lindgren (4):
      dt-bindings: omap: Add Motorola mapphone mz609 and mz617 tablets
      ARM: dts: motorola-mapphone: Move LCD to common file for xt875 and=
 xt894
      ARM: dts: motorola-mapphone: Move handset devices to a common file
      ARM: dts: motorola-mapphone: Add basic support for mz609 and mz617

Trevor Woerner (3):
      arm64: dts: rockchip: add gpio-line-names to rk3308-rock-pi-s
      arm64: dts: rockchip: add gpio-line-names to rk3328-rock-pi-e
      arm64: dts: rockchip: rk3308-rock-pi-s gpio-line-names cleanup

Uwe Kleine-K=C3=B6nig (1):
      ARM: dts: stm32: Consolidate usbh_[eo]hci phy properties on stm32m=
p15

Vahe Grigoryan (3):
      arm64: dts: rockchip: fix misleading comment in rk3399-puma-haikou=
dts
      arm64: dts: rockchip: expose BIOS Disable feedback pin on rk3399-p=
uma
      arm64: dts: rockchip: make use gpio-keys for buttons on puma-haikou

Varadarajan Narayanan (2):
      arm64: dts: qcom: ipq5332: populate the opp table based on the eFu=
se
      arm64: dts: qcom: ipq9574: populate the opp table based on the eFu=
se

Viacheslav Bocharov (1):
      arm64: dts: meson-axg: jethub-jxx add support for EEPROM

Vignesh Raghavendra (4):
      arm64: dts: ti: k3-am642-evm/sk: Mark mcu_gpio_intr as reserved
      arm64: dts: ti: k3-am62p5-sk: Mark mcu gpio and mcu_gpio_intr as r=
eserved
      arm64: dts: ti: k3-am62x-sk-common: Mark mcu gpio and mcu_gpio_int=
r as reserved
      arm64: dts: ti: k3-am6*: Add additional regs for DMA components

Vincent Knecht (2):
      arm64: dts: qcom: msm8939: Add BAM-DMUX WWAN
      arm64: dts: qcom: msm8916-alcatel-idol347: Add sound and modem

Xianwei Zhao (3):
      arm64: dts: amlogic: add some device nodes for S4
      arm64: dts: amlogic: enable some nodes for board AQ222
      arm64: dts: amlogic: fix format for s4 uart node

Xu Yang (1):
      arm64: dts: imx8dxl-ss-ddr: change ddr_pmu0 compatible

Yunfei Dong (1):
      arm64: dts: mediatek: mt8183: Add decoder

jason-ch chen (4):
      dt-bindings: arm: Add compatible for MediaTek MT8188
      dt-bindings: arm: mediatek: Add mt8188 pericfg compatible
      dt-bindings: soc: mediatek: pwrap: Modify compatible for MT8188
      arm64: dts: Add MediaTek MT8188 dts and evaluation board and Makef=
ile

shironeko (1):
      arm64: dts: rockchip: add missing tx/rx-fifo-depth for rk3328 gmac

yu-chang.lee (1):
      dt-bindings: arm: mediatek: mmsys: Add VPPSYS compatible for MT8188

   0.5% Documentation/devicetree/bindings/arm/mediatek/
   0.7% Documentation/devicetree/bindings/arm/
   0.8% Documentation/devicetree/bindings/clock/
   0.4% Documentation/devicetree/bindings/display/mediatek/
   0.6% Documentation/devicetree/bindings/interconnect/
   0.8% Documentation/devicetree/bindings/media/
   0.5% Documentation/devicetree/bindings/sound/
   0.3% Documentation/devicetree/bindings/thermal/
   0.5% Documentation/devicetree/bindings/
   0.5% arch/arm/boot/dts/marvell/
   0.5% arch/arm/boot/dts/nxp/imx/
   0.3% arch/arm/boot/dts/nxp/
   4.8% arch/arm/boot/dts/qcom/
   0.6% arch/arm/boot/dts/renesas/
   1.9% arch/arm/boot/dts/rockchip/
   1.3% arch/arm/boot/dts/st/
   1.3% arch/arm/boot/dts/ti/omap/
   0.3% arch/arm/boot/dts/
   0.4% arch/arm64/boot/dts/allwinner/
   0.8% arch/arm64/boot/dts/amlogic/
   3.3% arch/arm64/boot/dts/exynos/google/
   3.4% arch/arm64/boot/dts/exynos/
   7.4% arch/arm64/boot/dts/freescale/
   0.9% arch/arm64/boot/dts/marvell/
   5.3% arch/arm64/boot/dts/mediatek/
  37.8% arch/arm64/boot/dts/qcom/
   0.8% arch/arm64/boot/dts/renesas/
   8.5% arch/arm64/boot/dts/rockchip/
   0.5% arch/arm64/boot/dts/sprd/
   5.7% arch/arm64/boot/dts/ti/
   0.6% arch/arm64/boot/dts/
   0.5% arch/riscv/boot/dts/sophgo/
   0.3% arch/riscv/boot/dts/starfive/
   3.8% include/dt-bindings/clock/
   0.3% include/dt-bindings/iio/
   0.9% include/dt-bindings/interconnect/
 808 files changed, 53337 insertions(+), 5146 deletions(-)

