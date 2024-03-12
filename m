Return-Path: <linux-kernel+bounces-100531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A65F8879937
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 17:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04C12283094
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C557E581;
	Tue, 12 Mar 2024 16:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="pw4VfhuJ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SXdOan7A"
Received: from wfhigh4-smtp.messagingengine.com (wfhigh4-smtp.messagingengine.com [64.147.123.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5858115BF
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 16:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710261849; cv=none; b=i7gzhc6qDoagQFMlOwSIPkAaAAJ+7IhitM+zICTJFUI9WTDg1NE62X6qVaflJ42FQ5+jIf9LRlnYE9JHy6SjbSl8qIe45LwCxhqwNFH9t1ZnDXzJiLyg8LY/N/9THdlvrkLVBEQy27F3mT2YysodA0VBPLpO+5xaGFoqyXXIA98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710261849; c=relaxed/simple;
	bh=hgDgfLrJSLXb9O0l3kbhPWZ8W+Ox5CWNbzuj0+l//GE=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=JnBG9KeTXC2+0Ixt4NbtKJqDSeM93kalcxzDyAIvwZ2ksZPk6Zixidcf2klaHGXcMl/U/BczkYdxIpKe5182i2CMY5B7CMdRk9JYluvJxAgx052RKQxnkm9nZ1InDy8J4zeto/L9zioE4p/PNxzcR5rRjSD2Z2SMOrdSvhm/Erc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=pw4VfhuJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SXdOan7A; arc=none smtp.client-ip=64.147.123.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 23E191800092;
	Tue, 12 Mar 2024 12:44:04 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 12 Mar 2024 12:44:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1710261843;
	 x=1710348243; bh=ycbFDceeNZM36J4pT8OOJoXP5VHvGQsXHvsPkGXn+Z4=; b=
	pw4VfhuJYo0ip194CWUDi2tN7d59M68vOjO8HcVRAy7rgoL9SaG6CjX5oql9JSQX
	FSQ25bh8H4zla76z7XLGlya7jwJEoN0EcQjCsuecUKZRcfYjl2h+EUaT76nBKSyb
	M03jXMhBd0AplhMn8ddYbBt0gpWczBgaZq93TE/l7u9tuPXquWhSmLOxSXRXWc1n
	C6RZUbryu4tEJ0x+0OKqP28zYQA5l0K5BG4j4URRO25YJL/6M4AFpiJZyUZeZqIM
	q1siEGWgGSI0v5ikdf7bZA+e0bspTmuqt/KgsGeIeJ8UOjUuhC0cIlJo62jVc9xn
	B0b3+ATfkPHiIczGGOY1YQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1710261843; x=
	1710348243; bh=ycbFDceeNZM36J4pT8OOJoXP5VHvGQsXHvsPkGXn+Z4=; b=S
	XdOan7Afuh6APfkoXt6lq8V9a7c2A+8TXOLEDgcrqap+oBKVJVbvR5Y/rpF19P8/
	hKAs6o+HWdAwQLDbu6XGyq7CecNCoIWH/TTGWX3LRT9HH0IdnU24KOjyYR4f1Pcp
	LFJHrkpz3XzYQ+qu3cSDHLxHcsILHpZErF620QaRaN7Y1/2aGN0rEVbkO78kkVk1
	lCRinY0+EY9qgJMfGvUkP6ZIQNNtQEz8xfy70yKxbXM9rUJG9qSfI2gok86Xqq+J
	uu6LP9rcKIY4fKW9vQNl62+bKaVb/fnUBYBqBP5RoebGP9vBO6ZOu6qIRJxQ5g+u
	qRWIt3sBGWUR2uSCkFVXg==
X-ME-Sender: <xms:U4bwZYdDrskGmRwWCEIq3zFjm3TDuJeND_TAVg6iajB3P_qe7KyfBw>
    <xme:U4bwZaMmSApYiVohS6zaddlTa88fYuXmvjyreGAixxq7HXScbMzjIVNcUIu_aLrz3
    TWHaHuItu17YF3TMYw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjeefgdelvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculddujedmnecujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredt
    reerjeenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnh
    gusgdruggvqeenucggtffrrghtthgvrhhnpefgkefhheetvdethfejkeeigfehtdffieev
    feefteffteejffehlefhtdeuveejueenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpd
    hgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:U4bwZZg9EyORA8ZrD_acl5VLE19Edtn5Ktl0B0few-ALtCSv23KRaw>
    <xmx:U4bwZd81ixVu8TZvqOv4--oocCwCu52E6gegwCtrL-ndmwixO9zZjg>
    <xmx:U4bwZUsOhIYTq2rY1sNNp2ZuwLqPtvUIbm854LOPJG6SBWOW8E7JYg>
    <xmx:U4bwZUEUHKOMG8boE2IiFDTx8aRW4fnAPYb2NnnMNQpnaRjV9LuLTg>
    <xmx:U4bwZWK5_Om8M7wyUgvQSPTTDHzcIueHiasi40RqAKS6QL_tpXnjvrQs6_0>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 65B71B6008D; Tue, 12 Mar 2024 12:44:03 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-251-g8332da0bf6-fm-20240305.001-g8332da0b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5a628e85-33b5-4fac-b650-3ff9e1833df5@app.fastmail.com>
In-Reply-To: <89d0bb77-a608-4ae0-b9d9-e17fdf5f12da@app.fastmail.com>
References: <89d0bb77-a608-4ae0-b9d9-e17fdf5f12da@app.fastmail.com>
Date: Tue, 12 Mar 2024 17:43:43 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: soc@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: [GIT PULL 1/4] ARM: SoC DT changes for 6.9
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

The following changes since commit d206a76d7d2726f3b096037f2079ce0bd3ba3=
29b:

  Linux 6.8-rc6 (2024-02-25 15:46:06 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-d=
t-6.9

for you to fetch changes up to 59f33701fd1c5970b875ca5ce4bf1db6e4740d6b:

  Merge tag 'riscv-dt-fixes-for-v6.8-final' of https://git.kernel.org/pu=
b/scm/linux/kernel/git/conor/linux into soc/dt (2024-03-11 07:59:36 +010=
0)

----------------------------------------------------------------
SoC: device tree updates for 6.9

There is very little going on with new SoC support this time, all the
new chips are variations of others that we already support, and they
are all based on ARMv8 cores:

 - Mediatek MT7981B (Filogic 820) and MT7988A (Filogic 880) are
   networking SoCs designed to be used in wireless routers, similar
   to the already supported MT7986A (Filogic 830).

 - NXP i.MX8DXP is a variant of i.MX8QXP, with two CPU cores less.
   These are used in many embedded and industrial applications.

 - Renesas R8A779G2 (R-Car V4H ES2.0) and R8A779H0 (R-Car V4M)
   are automotive SoCs.

 - TI J722S is another automotive variant of its K3 family,
   related to the AM62 series.

There are a total of 7 new arm32 machines and 45 arm64 ones, including

 - Two Android phones based on the old Tegra30 chip

 - Two machines using Cortex-A53 SoCs from Allwinner, a mini PC and
   a SoM development board

 - A set-top box using Amlogic Meson G12A S905X2

 - Eight embedded board using NXP i.MX6/8/9

 - Three machines using Mediatek network router chips

 - Ten Chromebooks, all based on Mediatek MT8186

 - One development board based on Mediatek MT8395 (Genio 1200)

 - Seven tablets and phones based on Qualcomm SoCs, most of them
   from Samsung.

 - A third development board for Qualcomm SM8550 (Snapdragon 8 Gen 2)

 - Three variants of the "White Hawk" board for Renesas
   automotive SoCs

 - Ten Rockchips RK35xx based machines, including NAS, Tablet,
   Game console and industrial form factors.

 - Three evaluation boards for TI K3 based SoCs

The other changes are mainly the usual feature additions for existing ha=
rdware,
cleanups, and dtc compile time fixes. One notable change is the inclusion
of PowerVR SGX GPU nodes on TI SoCs.

----------------------------------------------------------------
(shortlog slightly trimmed and diffstat replaced with dirstat for brevit=
y)

Abel Vesa (11):
      dt-bindings: clock: Drop the SM8650 DISPCC dedicated schema
      dt-bindings: clock: qcom: Document the X1E80100 TCSR Clock Control=
ler
      arm64: dts: qcom: x1e80100: Add TCSR node
      arm64: dts: qcom: x1e80100: Add USB nodes
      arm64: dts: qcom: x1e80100: Add PCIe nodes
      arm64: dts: qcom: x1e80100: Add display nodes
      arm64: dts: qcom: x1e80100-crd: Enable more support
      arm64: dts: qcom: x1e80100-qcp: Enable more support
      arm64: dts: qcom: x1e80100-qcp: Fix supplies for LDOs 3E and 2J
      arm64: dts: qcom: sm8550: Fix SPMI channels size
      arm64: dts: qcom: sm8650: Fix SPMI channels size

Adam Ford (4):
      arm64: dts: imx8mp-beacon: Enable Bluetooth
      arm64: dts: imx8mp-beacon: Configure multiple queues on eqos
      arm64: dts: imx8mn: Slow default video_pll clock rate
      arm64: dts: imx8mn-beacon: Remove unnecessary clock configuration

Alex Bee (3):
      ARM: dts: rockchip: Add display subsystem for RK3128
      ARM: dts: rockchip: Add HDMI node for RK3128
      ARM: dts: rockchip: Enable HDMI output for XPI-3128

Alex Leibovich (1):
      arm64: dts: armada-ap807: update thermal compatible

Alexander Stein (42):
      arm64: dts: imx: add imx8dxp support
      dt-bindings: arm: add TQMa8Xx boards
      arm64: dts: freescale: add initial device tree for TQMa8Xx
      arm64: dts: imx8qxp: Add ACM input clock gates
      arm64: dts: imx8qxp: Add audio clock mux node
      arm64: dts: imx8qxp: Add audio SAI nodes
      arm64: dts: imx8qxp: Add mclkout clock gates
      arm64: dts: imx8qxp: mba8xx: Add analog audio output on MBa8Xx
      arm64: dts: imx8qxp: add GPU nodes
      ARM: dts: imx7-tqma7/mba7: convert fsl,pins to uint32-matrix
      ARM: dts: imx7[d]-mba7: Move ethernet PHY reset into PHY node
..

Alexey Charkov (1):
      arm64: dts: rockchip: add rfkill node for M.2 Key E WiFi on rock-5b

Alexey Romanov (1):
      arch: arm64: dts: meson: a1: add assigned-clocks for usb node

Allen-KH Cheng (1):
      arm64: dts: mediatek: mt8186: Add jpgenc node

Alvin =C5=A0ipraga (1):
      ARM: dts: marvell: dove-cubox: fix si5351 node names

Andre Przywara (5):
      dt-bindings: vendor-prefixes: add Jide
      dt-bindings: arm: sunxi: document Remix Mini PC name
      arm64: dts: allwinner: Add Jide Remix Mini PC support
      arm64: dts: allwinner: h616: Add 32K fanout pin
      arm64: dts: allwinner: Transpeed 8K618-T: add WiFi nodes

Andreas Kemnade (3):
      ARM: dts: imx6sl-tolino-shine2hd: fix touchscreen rotation
      ARM: dts: omap-embt2ws: system-power-controller for bt200
      ARM: dts: omap4-panda-common: Enable powering off the device

Andrejs Cainikovs (2):
      arm64: dts: ti: verdin-am62: add support for Verdin USB1 interface
      arm64: dts: ti: k3-am62-main: disable usb lpm

Andrew Davis (35):
      dt-bindings: gpu: Rename img,powervr to img,powervr-rogue
      dt-bindings: gpu: Add PowerVR Series5 SGX GPUs
      ARM: dts: omap3: Add device tree entry for SGX GPU
      ARM: dts: omap4: Add device tree entry for SGX GPU
      ARM: dts: omap5: Add device tree entry for SGX GPU
      ARM: dts: AM33xx: Add device tree entry for SGX GPU
      ARM: dts: AM437x: Add device tree entry for SGX GPU
      ARM: dts: DRA7xx: Add device tree entry for SGX GPU
      arm64: dts: ti: k3-am654-main: Add device tree entry for SGX GPU
      arm64: dts: ti: k3-am642-evm: Do not split single items
      arm64: dts: ti: k3-am642-sk: Do not split single items
..

Andr=C3=A9 Draszik (7):
      arm64: dts: exynos: gs101: sysreg_peric0 needs a clock
      arm64: dts: exynos: gs101: use correct clocks for usi8
      arm64: dts: exynos: gs101: use correct clocks for usi_uart
      dt-bindings: clock: google,gs101-clock: add PERIC1 clock managemen=
t unit
      arm64: dts: exynos: gs101: enable cmu-peric1 clock controller
      arm64: dts: exynos: gs101: define USI12 with I2C configuration
      arm64: dts: exynos: gs101: enable i2c bus 12 on gs101-oriole

AngeloGioacchino Del Regno (3):
      arm64: dts: mediatek: mt8195: Add MTU3 nodes and correctly describ=
e USB
      dt-bindings: arm64: mediatek: Add MT8395 Radxa NIO 12L board compa=
tible
      arm64: dts: mediatek: Introduce the MT8395 Radxa NIO 12L board

Ankit Sharma (1):
      arm64: dts: qcom: sc7280: Add capacity and DPC properties

Apurva Nandan (1):
      arm64: dts: ti: Add phase tags for memory node on J784S4 EVM and A=
M69 SK

Aradhya Bhatia (3):
      arm64: dts: ti: k3-am62a-main: Add node for Display SubSystem (DSS)
      arm64: dts: ti: k3-am62a7-sk: Add HDMI support
      arm64: dts: ti: Makefile: Add HDMI audio check for AM62A7-SK

Arnd Bergmann (41):
      Merge tag 'renesas-dt-bindings-for-v6.9-tag1' of git://git.kernel.=
org/pub/scm/linux/kernel/git/geert/renesas-devel into soc/dt
      Merge tag 'renesas-dts-for-v6.9-tag1' of git://git.kernel.org/pub/=
scm/linux/kernel/git/geert/renesas-devel into soc/dt
      Merge tag 'samsung-dt64-6.9' of https://git.kernel.org/pub/scm/lin=
ux/kernel/git/krzk/linux into soc/dt
      Merge tag 'samsung-dt-6.9' of https://git.kernel.org/pub/scm/linux=
/kernel/git/krzk/linux into soc/dt
      Merge tag 'dt-cleanup-6.9' of https://git.kernel.org/pub/scm/linux=
/kernel/git/krzk/linux-dt into soc/dt
      Merge tag 'mtk-dts64-for-v6.9' of https://git.kernel.org/pub/scm/l=
inux/kernel/git/mediatek/linux into soc/dt
      Merge tag 'gemini-dts-v6.9' of git://git.kernel.org/pub/scm/linux/=
kernel/git/linusw/linux-integrator into soc/dt
      Merge tag 'versatile-dts-v6.9' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/linusw/linux-integrator into soc/dt
      Merge tag 'v6.9-rockchip-dts64-1' of git://git.kernel.org/pub/scm/=
linux/kernel/git/mmind/linux-rockchip into soc/dt
      Merge tag 'v6.9-rockchip-dts32-1' of git://git.kernel.org/pub/scm/=
linux/kernel/git/mmind/linux-rockchip into soc/dt
      Merge tag 'renesas-dt-bindings-for-v6.9-tag2' of git://git.kernel.=
org/pub/scm/linux/kernel/git/geert/renesas-devel into soc/dt
      Merge tag 'renesas-dts-for-v6.9-tag2' of git://git.kernel.org/pub/=
scm/linux/kernel/git/geert/renesas-devel into soc/dt
      Merge tag 'tegra-for-6.9-dt-bindings' of git://git.kernel.org/pub/=
scm/linux/kernel/git/tegra/linux into soc/dt
      Merge tag 'tegra-for-6.9-arm-dt' of git://git.kernel.org/pub/scm/l=
inux/kernel/git/tegra/linux into soc/dt
      Merge tag 'tegra-for-6.9-arm64-dt' of git://git.kernel.org/pub/scm=
/linux/kernel/git/tegra/linux into soc/dt
      Merge tag 'sunxi-dt-for-6.9-1' of https://git.kernel.org/pub/scm/l=
inux/kernel/git/sunxi/linux into soc/dt
      Merge tag 'qcom-arm64-for-6.9' of https://git.kernel.org/pub/scm/l=
inux/kernel/git/qcom/linux into soc/dt
      Merge tag 'socfpga_dts_updates_for_v6.9' of git://git.kernel.org/p=
ub/scm/linux/kernel/git/dinguyen/linux into soc/dt
      Merge tag 'imx-bindings-6.9' of git://git.kernel.org/pub/scm/linux=
/kernel/git/shawnguo/linux into soc/dt
      Merge tag 'imx-dt-6.9' of git://git.kernel.org/pub/scm/linux/kerne=
l/git/shawnguo/linux into soc/dt
      Merge tag 'imx-dt64-6.9' of git://git.kernel.org/pub/scm/linux/ker=
nel/git/shawnguo/linux into soc/dt
      Merge tag 'sgx-for-v6.9-signed' of git://git.kernel.org/pub/scm/li=
nux/kernel/git/tmlind/linux-omap into soc/dt
      Merge tag 'zynqmp-dt-for-6.9' of https://github.com/Xilinx/linux-x=
lnx into soc/dt
      Merge tag 'at91-dt-6.9' of https://git.kernel.org/pub/scm/linux/ke=
rnel/git/at91/linux into soc/dt
      Merge tag 'ti-k3-dt-for-v6.9' of https://git.kernel.org/pub/scm/li=
nux/kernel/git/ti/linux into soc/dt
      Merge tag 'omap-for-v6.9/dt-signed' of git://git.kernel.org/pub/sc=
m/linux/kernel/git/tmlind/linux-omap into soc/dt
      Merge tag 'amlogic-arm-dt-for-v6.9' of https://git.kernel.org/pub/=
scm/linux/kernel/git/amlogic/linux into soc/dt
      Merge tag 'amlogic-arm64-dt-for-v6.9' of https://git.kernel.org/pu=
b/scm/linux/kernel/git/amlogic/linux into soc/dt
      Merge tag 'stm32-dt-for-v6.9-1' of git://git.kernel.org/pub/scm/li=
nux/kernel/git/atorgue/stm32 into soc/dt
      Merge tag 'renesas-dt-bindings-for-v6.9-tag3' of git://git.kernel.=
org/pub/scm/linux/kernel/git/geert/renesas-devel into soc/dt
      Merge tag 'mvebu-dt-6.9-1' of git://git.kernel.org/pub/scm/linux/k=
ernel/git/gclement/mvebu into soc/dt
      Merge tag 'mvebu-dt64-6.9-1' of git://git.kernel.org/pub/scm/linux=
/kernel/git/gclement/mvebu into soc/dt
      Merge tag 'riscv-sophgo-dt-for-v6.9' of https://github.com/sophgo/=
linux into soc/dt
      Merge tag 'v6.9-rockchip-dts64-2' of git://git.kernel.org/pub/scm/=
linux/kernel/git/mmind/linux-rockchip into soc/dt
      Merge tag 'v6.9-rockchip-dts32-2' of git://git.kernel.org/pub/scm/=
linux/kernel/git/mmind/linux-rockchip into soc/dt
      Merge tag 'qcom-arm32-for-6.9' of https://git.kernel.org/pub/scm/l=
inux/kernel/git/qcom/linux into soc/dt
      Merge tag 'ti-keystone-dt-for-v6.9' of https://git.kernel.org/pub/=
scm/linux/kernel/git/ti/linux into soc/dt
      Merge tag 'vexpress-update-6.9' of git://git.kernel.org/pub/scm/li=
nux/kernel/git/sudeep.holla/linux into soc/dt
      Merge tag 'v6.9-rockchip-drivers1' of git://git.kernel.org/pub/scm=
/linux/kernel/git/mmind/linux-rockchip into soc/dt
      Merge tag 'qcom-arm64-for-6.9-2' of https://git.kernel.org/pub/scm=
/linux/kernel/git/qcom/linux into soc/dt
      Merge tag 'riscv-dt-fixes-for-v6.8-final' of https://git.kernel.or=
g/pub/scm/linux/kernel/git/conor/linux into soc/dt

Artur Weber (1):
      ARM: dts: samsung: exynos4412: decrease memory to account for unus=
able region

Ar=C4=B1n=C3=A7 =C3=9CNAL (2):
      arm64: dts: mt7622: add port@5 as CPU port
      arm64: dts: mt7986: add port@5 as CPU port

Balakrishnan Sambath (1):
      ARM: dts: microchip: sama7g5: add sama7g5 compatible

Baocheng Su (2):
      arm64: dts: ti: iot2050: Disable R5 lockstep for all PG2 boards
      arm64: dts: ti: iot2050: Support IOT2050-SM variant

Bhavya Kapoor (7):
      arm64: dts: ti: k3-j7200: Add support for CAN nodes
      arm64: dts: ti: k3-j7200-som-p0: Add support for CAN instance 0 in=
 main domain
      arm64: dts: ti: k3-j7200: Add support for multiple CAN instances
      arm64: dts: ti: k3-j7200-common-proc-board: Modify Pinmux for wkup=
_uart0 and mcu_uart0
      arm64: dts: ti: k3-j7200-common-proc-board: Remove clock-frequency=
 from mcu_uart0
      arm64: dts: ti: k3-j721s2-common-proc-board: Remove Pinmux for CTS=
 and RTS in wkup_uart0
      arm64: dts: ti: k3-j784s4-evm: Remove Pinmux for CTS and RTS in wk=
up_uart0

Biju Das (5):
      arm64: dts: renesas: r9a07g043u: Add CSI and CRU nodes
      arm64: dts: renesas: rzg2ul-smarc: Enable CRU, CSI support
      arm64: dts: renesas: r9a07g044: Add DU node
      arm64: dts: renesas: r9a07g054: Add DU node
      arm64: dts: renesas: rzg2l-smarc: Enable DU and link with DSI

Bjorn Andersson (10):
      arm64: dts: qcom: sa8540p: Drop gfx.lvl as power-domain for gpucc
      arm64: dts: qcom: sa8295p-adp: add max20411
      arm64: dts: qcom: sa8295p-adp: Enable GPU
      Merge branch '20240202-x1e80100-clock-controllers-v4-5-7fb08c861c7=
c@linaro.org' into arm64-for-6.9
      Merge branch '20240125-msm8953-mdss-reset-v2-1-fd7824559426@z3ntu.=
xyz' into arm64-for-6.9
      Merge branch '20240131-ufs-phy-clock-v3-3-58a49d2f4605@linaro.org'=
 into HEAD
      arm64: dts: qcom: sc8280xp: Introduce additional tsens instances
      arm64: dts: qcom: sc8280xp-crd: Add PMIC die-temp vadc channels
      arm64: dts: qcom: sc8280xp-pmics: Define adc for temp-alarms
      arm64: dts: qcom: qcs6490-rb3gen2: Declare GCC clocks protected

Brandon Brnich (2):
      arm64: dts: ti: k3-j784s4: Add Wave5 Video Encoder/Decoder Node
      arm64: dts: ti: k3-am62p: Add Wave5 Video Encoder/Decoder Node

Bryan O'Donoghue (2):
      arm64: dts: qcom: sc8280xp: camss: Add CCI definitions
      arm64: dts: qcom: sc8280xp: camss: Add CAMSS block definition

Chen Wang (2):
      riscv: dts: add reset generator for Sophgo SG2042 SoC
      riscv: dts: add resets property for uart node

Chen-Yu Tsai (12):
      dt-bindings: arm: mediatek: Sort entries by SoC then board compati=
bles
      dt-bindings: arm: mediatek: Add MT8186 Tentacruel / Tentacool Chro=
mebooks
      dt-bindings: arm: mediatek: Add MT8186 Steelix Chromebook
      dt-bindings: arm: mediatek: Add MT8186 Rusty Chromebook
      dt-bindings: arm: mediatek: Add MT8186 Magneton Chromebooks
      arm64: dts: mediatek: Add MT8186 Krabby platform based Tentacruel =
/ Tentacool
      arm64: dts: mediatek: Introduce MT8186 Steelix
      arm64: dts: mediatek: Add MT8186 Steelix platform based Rusty
      arm64: dts: mediatek: Add MT8186 Magneton Chromebooks
      arm64: dts: allwinner: h6: Add RX DMA channel for SPDIF
      arm64: dts: allwinner: h616: Add DMA controller and DMA channels
      arm64: dts: allwinner: h616: Add SPDIF device node

Chintan Vankar (1):
      arm64: dts: ti: k3-j784s4-main: Fix mux-reg-masks in serdes_ln_ctrl

Chris Morgan (8):
      arm64: dts: rockchip: Move device specific properties
      dt-bindings: arm: rockchip: Add Anbernic RG-Arc
      arm64: dts: rockchip: add Anbernic RG-ARC S and RG-ARC D
      arm64: dts: rockchip: Add Touch to Anbernic RG-ARC D
      arm64: dts: rockchip: Update powkiddy rk2023 dtsi for RGB10MAX3
      dt-bindings: arm: rockchip: Add Powkiddy RGB10MAX3
      arm64: dts: rockchip: Add Powkiddy RGB10MAX3
      arm64: dts: rockchip: Add USB3.0 to Indiedroid Nova

Christian Marangi (1):
      arm64: dts: qcom: ipq8074: add clock-frequency to MDIO node

Christoph Niedermaier (2):
      ARM: dts: imx6ull-dhcor: Remove 900MHz operating point
      ARM: dts: imx6ull-dhcom: Remove /omit-if-no-ref/ from node usdhc1-=
pwrseq

Claudiu Beznea (7):
      arm64: dts: renesas: rzg3s-smarc: Add gpio keys
      arm64: dts: renesas: r9a08g045: Add watchdog node
      arm64: dts: renesas: rzg3s-smarc-som: Enable the watchdog interface
      arm64: dts: renesas: rzg3s-smarc-som: Guard Ethernet IRQ GPIO hogs
      arm64: dts: renesas: r9a08g045: Add PSCI support
      ARM: dts: microchip: sama7g5: align dmas to the opening '<'
      ARM: dts: microchip: sam9x60: align dmas to the opening '<'

Cong Dang (5):
      arm64: dts: renesas: r8a779h0: Add GPIO nodes
      arm64: dts: renesas: r8a779h0: Add SD/MMC node
      arm64: dts: renesas: gray-hawk-single: Add eMMC support
      arm64: dts: renesas: r8a779h0: Add RPC node
      arm64: dts: renesas: gray-hawk-single: Add QSPI FLASH support

Craig Tatlor (1):
      ARM: dts: qcom: msm8974: correct qfprom node size

Cristian Ciocaltea (2):
      dt-bindings: soc: rockchip: Add rk3588 hdptxphy syscon
      arm64: dts: rockchip: Add HDMI0 PHY to rk3588

Dario Binacchi (6):
      dt-bindings: nt35510: document 'port' property
      dt-bindings: mfd: stm32f7: Add binding definition for DSI
      ARM: dts: stm32: add DSI support on stm32f769
      ARM: dts: stm32: rename mmc_vcard to vcc-3v3 on stm32f769-disco
      ARM: dts: stm32: add display support on stm32f769-disco
      ARM: dts: add stm32f769-disco-mb1166-reva09

Darren Etheridge (1):
      arm64: dts: ti: k3-j721s2-main: Add Wave5 Video Encoder/Decoder No=
de

Dasnavis Sabiya (2):
      arm64: dts: ti: k3-am69-sk: Enable CAN interfaces for AM69 SK board
      arm64: dts: ti: k3-am69-sk: Add support for OSPI flash

David Heidelberg (2):
      ARM: dts: qcom: msm8960: drop 2nd clock frequency from timer
      arm64: dts: qcom: sdm845-oneplus-common: improve DAI node naming

David Lechner (1):
      ARM: dts: da850: add MMD SDIO interrupts

David Wronek (3):
      dt-bindings: arm: qcom: Add Xiaomi Redmi Note 9S
      arm64: dts: qcom: sc7180: Add UFS nodes
      arm64: dts: qcom: sm7125-xiaomi-common: Add UFS nodes

Devarsh Thakkar (3):
      arm64: dts: ti: Add common1 register space for AM65x SoC
      arm64: dts: ti: Add common1 register space for AM62x SoC
      arm64: dts: ti: Add common1 register space for AM62A SoC

Dmitry Baryshkov (33):
      arm64: dts: qcom: rename PM2250 to PM4125
      arm64: dts: qcom: sdm630: add USB QMP PHY support
      arm64: dts: qcom: sda660-ifc6560: enable USB 3.0 PHY
      iommu/msm-iommu: don't limit the driver too much
      ARM: qcom: drop most of 32-bit ARCH_QCOM subtypes
      ARM: qcom: merge remaining subplatforms into sensible Kconfig entry
      dt-bindings: arm: qcom: drop the superfluous device compatibility =
schema
      arm64: dts: qcom: msm8998: declare VLS CLAMP register for USB3 PHY
      arm64: dts: qcom: qcm2290: declare VLS CLAMP register for USB3 PHY
      arm64: dts: qcom: sm6115: declare VLS CLAMP register for USB3 PHY
..

Dmitry Rokosov (2):
      arm64: dts: amlogic: axg: move cpu cooling-cells to common dtsi
      arm64: dts: amlogic: axg: initialize default SoC capacitance

Dominik Haller (1):
      arm64: dts: imx8mp-phyboard-pollux: Disable pull-up for CD GPIO

Dragan Simic (1):
      arm64: dts: rockchip: Add cache information to the SoC dtsi for RK=
3399

Duje Mihanovi=C4=87 (1):
      arm: dts: marvell: Fix maxium->maxim typo in brownstone dts

Duy Nguyen (8):
      dt-bindings: power: renesas,rcar-sysc: Document R-Car V4M support
      dt-bindings: power: Add r8a779h0 SYSC power domain definitions
      dt-bindings: clock: Add R8A779H0 V4M CPG Core Clock Definitions
      arm64: dts: renesas: r8a779h0: Add L3 cache controller
      arm64: dts: renesas: r8a779h0: Add secondary CA76 CPU cores
      arm64: dts: renesas: r8a779h0: Add CPUIdle support
      arm64: dts: renesas: r8a779h0: Add CPU core clocks
      arm64: dts: renesas: r8a779h0: Add CA76 operating points

Elad Nachman (1):
      arm64: dts: ac5: add mmc node and clock

Elon Zhang (2):
      arm64: dts: rockchip: Add devicetree support for TB-RK3588X board
      dt-bindings: arm: rockchip: Add Toybrick TB-RK3588X

Eugen Hristev (5):
      dt-bindings: media: mtk-vcodec-encoder: fix non-vp8 clock name
      arm64: dts: mediatek: mt8192: fix vencoder clock name
      dt-bindings: media: mtk-vcodec-encoder: add compatible for mt8186
      arm64: dts: mediatek: mt8186: fix VENC power domain clocks
      dt-bindings: media: mediatek-jpeg-encoder: change max iommus count

Ezra Buehler (2):
      ARM: dts: microchip: at91sam9x5ek: Use DMA for DBGU serial port
      ARM: dts: microchip: gardena-smart-gateway: Use DMA for USART3

Fabio Estevam (6):
      arm64: dts: ls1046a: Remove big-endian from thermal
      arm64: dts: imx93-var-som: Remove phy-supply from eqos
      ARM: dts: imx28-evk: Use 'eeprom' as the node name
      ARM: dts: imx1-apf9328: Fix Ethernet node name
      arm64: dts: imx8-apalis-v1.1: Remove reset-names from ethernet-phy
      arm64: dts: imx8mm-kontron-bl-osm-s: Fix Ethernet PHY compatible

Farouk Bouabid (2):
      arm64: dts: rockchip: add rs485 support on uart2 of rk3399-puma-ha=
ikou
      arm64: dts: rockchip: add rs485 support on uart5 of px30-ringneck-=
haikou

Fenglin Wu (2):
      arm64: dts: qcom: sm8650-mtp: add PM8010 regulators
      arm64: dts: qcom: sm8650-qrd: add PM8010 regulators

Francesco Dolcini (2):
      arm64: dts: ti: verdin-am62: mallow: add TPM device
      arm64: dts: ti: verdin-am62: Set VDD CORE minimum voltage to 0.75V

Frank Li (11):
      arm64: dts: imx8qm: Align edma3 power-domains resources indentation
      arm64: dts: imx8qm: Correct edma3 power-domains and interrupt numb=
ers
      arm64: dts: imx8dxl: update flexcan[1-3] interrupt number
      arm64: dts: imx8dxl-evk: add i2c3 and its children nodes
      arm64: dts: imx8dxl-evk: add flexcan2 and flecan3
      arm64: dts: imx8qm: add smmu node
      arm64: dts: imx8qm: add smmu stream id information
      arm64: dts: imx8dxl: add fsl-dma.h dt-binding header file
      arm64: dts: imx8dxl update edma0 information
      arm64: dts: imx8qm: add i2c4 and i2c4_lpcg node
      arm64: dts: imx8qm: add i2c1 for imx8qm-mek board

Frieder Schrempf (14):
      arm64: dts: imx8mm-kontron: Disable pullups for I2C signals on OSM=
-S i.MX8MM
      arm64: dts: imx8mm-kontron: Disable pullups for I2C signals on SL/=
BL i.MX8MM
      arm64: dts: imx8mm-kontron: Disable pullups for onboard UART signa=
ls on BL OSM-S board
      arm64: dts: imx8mm-kontron: Disable pullups for onboard UART signa=
ls on BL board
      arm64: dts: imx8mm-kontron: Disable pull resistors for SD card sig=
nals on BL OSM-S board
      arm64: dts: imx8mm-kontron: Disable pull resistors for SD card sig=
nals on BL board
      arm64: dts: imx8mm-kontron: Fix interrupt for RTC on OSM-S i.MX8MM=
 module
      arm64: dts: imx8mm-kontron: Fix OSM-S devicetrees to match latest =
hardware
      arm64: dts: imx8mm-kontron: Disable uneffective PUE bit in SDIO IO=
MUX
      arm64: dts: imx8mm-kontron: Remove useless trickle-diode-disable f=
rom RTC node
      arm64: dts: imx8mm-kontron: Add I2C EEPROM on OSM-S Kontron i.MX8MM
      arm64: dts: imx8mm-kontron: Refactor devicetree for OSM-S module a=
nd board
      dt-bindings: arm: fsl: Add Sielaff i.MX6 Solo board
      ARM: dts: imx6dl: Add support for Sielaff i.MX6 Solo board

Fuyao Kashizuku (1):
      ARM: dts: sun8i: Open FETA40i-C regulator aldo1

Geert Uytterhoeven (29):
      ARM: dts: renesas: r8a73a4: Fix external clocks and clock rate
      ARM: dts: renesas: r8a73a4: Add cp clock
      ARM: dts: renesas: r8a73a4: Fix thermal parent clock
      arm64: dts: renesas: r8a779g0: Restore sort order
      dt-bindings: soc: renesas: Document R-Car V4H White Hawk Single
      arm64: dts: renesas: r8a779g0: Add standalone White Hawk CPU suppo=
rt
      arm64: dts: renesas: white-hawk-cpu: Restore sort order
      arm64: dts: renesas: white-hawk: Drop SoC parts from sub boards
      arm64: dts: renesas: white-hawk: Add SoC name to top-level comment
      arm64: dts: renesas: white-hawk-cpu: Factor out common parts
      arm64: dts: renesas: white-hawk: Factor out common parts
      arm64: dts: renesas: Add Renesas R8A779G2 SoC support
      arm64: dts: renesas: r8a779g2: Add White Hawk Single support
      dt-bindings: clock: renesas,cpg-mssr: Document R-Car V4M support
..

Hai Pham (3):
      arm64: dts: renesas: Add Renesas R8A779H0 SoC support
      arm64: dts: renesas: r8a779h0: Add pinctrl device node
      arm64: dts: renesas: r8a779h0: Add I2C nodes

Heiko Stuebner (8):
      Merge branch 'v6.9-shared/clkids' into v6.9-armsoc/dts64
      arm64: dts: rockchip: add clock to vo1-grf syscon on rk3588
      arm64: dts: rockchip: add missing interrupt-names for rk356x vdpu
      arm64: dts: rockchip: fix reset-names for rk356x i2s2 controller
      arm64: dts: rockchip: drop rockchip,trcm-sync-tx-only from rk3588 =
i2s
      dt-bindings: arm: rockchip: Add Theobroma-Systems RK3588 Q7 with b=
aseboard
      arm64: dts: rockchip: add RK3588-Q7 (Tiger) SoM
      arm64: dts: rockchip: add Haikou baseboard with RK3588-Q7 SoM

Heinz Wrobel (1):
      arm64: dts: lx2160a: Fix DTS for full PL011 UART

Henrik Grimler (2):
      ARM: dts: samsung: exynos5420-galaxy-tab: decrease available memory
      ARM: dts: samsung: exynos5420-galaxy-tab-common: add wifi node

Hiago De Franco (2):
      dt-bindings: arm: fsl: Add toradex,apalis_imx6q-eval-v1.2 board
      ARM: dts: imx: Add support for Apalis Evaluation Board v1.2

Hou Zhiqiang (1):
      arm64: dts: ls1012a: add big-endian property for PCIe nodes

Hsin-Te Yuan (1):
      arm64: dts: mt8195-cherry-tomato: change watchdog reset boot flow

Hugh Cole-Baker (1):
      arm64: dts: rockchip: enable NanoPC-T6 MiniPCIe power

Hugo Villeneuve (2):
      dt-bindings: arm: fsl: remove redundant company name
      arm64: dts: imx8mn-rve-gateway: remove redundant company name

Hugues Fruchet (2):
      arm64: dts: st: add video decoder support to stm32mp255
      arm64: dts: st: add video encoder support to stm32mp255

Hui Liu (1):
      arm64: dts: qcom: qcm6490-idp: Add definition for three LEDs

Ilias Apalodimas (1):
      arm64: zynqmp: Add an OP-TEE node to the device tree

Inochi Amaoto (1):
      MAINTAINERS: Setup proper info for SOPHGO vendor support

Isaev Ruslan (1):
      arm64: dts: qcom: ipq6018: add QUP5 I2C node

Iskander Amara (1):
      arm64: dts: rockchip: add missing definition of pmu io domains 1 a=
nd 2 on ringneck

Ivaylo Ivanov (1):
      ARM: dts: qcom: msm8226: Add CPU and SAW/ACC nodes

Jagan Teki (10):
      arm64: dts: rockchip: Drop edgeble-neu6b dcdc-reg4 regulator-init-=
microvolt
      arm64: dts: rockchip: Add edgeble-neu6a-common DT
      arm64: dts: rockchip: Add common DT for edgeble-neu6b-io
      arm64: dts: rockchip: Add Edgeble NCM6A WiFi6 Overlay
      arm64: dts: rockchip: Add vdd_cpu_big reg to rk3588-edgeble-ncm6
      arm64: dts: rockchip: Add Edgeble NCM6A-IO 2.5G ETH
      arm64: dts: rockchip: Add Edgeble NCM6A-IO M.2 M-Key
      arm64: dts: rockchip: Add Edgeble NCM6A-IO M.2 B-Key, E-Key
      arm64: dts: rockchip: Add Edgeble NCM6A-IO USB2
      arm64: dts: rockchip: Add LED_GREEN for edgeble-neu6a

Jai Luthra (4):
      arm64: dts: ti: k3-am62p: Fix memory ranges for DMSS
      arm64: dts: ti: k3-am62p: Add DMASS1 for CSI
      arm64: dts: ti: k3-am62p: Add nodes for CSI-RX
      arm64: dts: ti: Enable overlays for SK-AM62P

Jan Kiszka (4):
      arm64: dts: ti: iot2050: Factor out arduino connector bits
      arm64: dts: ti: iot2050: Factor out enabling of USB3 support
      arm64: dts: ti: iot2050: Factor out DP related bits
      arm64: dts: ti: iot2050: Annotate LED nodes

Jay Buddhabhatti (1):
      dt-bindings: firmware: versal: add versal-net compatible string

Jayesh Choudhary (1):
      arm64: dts: ti: k3-am69-sk: remove assigned-clock-parents for unus=
ed VP

Jernej Skrabec (1):
      arm64: dts: allwinner: h616: Add Orange Pi Zero 2W to Makefile

Jianhua Lu (1):
      arm64: dts: qcom: sm8250-xiaomi-elish: set rotation

Jisheng Zhang (2):
      dt-bindings: arm: sunxi: Add Sipeed Longan Module 3H and Longan Pi=
 3H
      arm64: dts: allwinner: h616: Add Sipeed Longan SoM 3H and Pi 3H bo=
ard support

Joao Paulo Goncalves (2):
      dt-bindings: arm: fsl: add imx8qm apalis eval v1.2 carrier board
      arm64: dts: freescale: imx8qm: add apalis eval v1.2 carrier board

Joe Mason (2):
      arm64: dts: qcom: Add support for Xiaomi Redmi Note 9S
      arm64: dts: qcom: msm8916-samsung-fortuna/rossa: Add fuel gauge

Johan Jonker (4):
      ARM: dts: rockchip: fix rk3288 hdmi ports node
      ARM: dts: rockchip: fix rk322x hdmi ports node
      arm64: dts: rockchip: fix rk3328 hdmi ports node
      arm64: dts: rockchip: fix rk3399 hdmi ports node

John Clark (2):
      arm64: dts: rockchip: add sdmmc card detect to the nanopc-t6
      arm64: dts: rockchip: fix nanopc-t6 sdmmc regulator

Jon Hunter (3):
      arm64: tegra: Add current monitors for Jetson Xavier
      arm64: tegra: Add USB device support for Jetson AGX Xavier
      arm64: tegra: Add USB Type-C controller for Jetson AGX Xavier

Josua Mayer (14):
      ARM: dts: imx6qdl-hummingboard: Add rtc0 and rtc1 aliases to fix h=
ctosys
      dt-bindings: arm: ti: Add bindings for SolidRun AM642 HummingBoard=
-T
      arm64: dts: add description for solidrun am642 som and evaluation =
board
      arm64: dts: ti: hummingboard-t: add overlays for m.2 pci-e and usb=
-3
      dt-bindings: marvell: a38x: convert soc compatibles to yaml
      dt-bindings: marvell: a38x: add solidrun armada 388 clearfog boards
      dt-bindings: marvell: a38x: add kobol helios-4 board
      dt-bindings: marvell: a38x: add solidrun armada 385 clearfog gtr b=
oards
      arm: dts: marvell: clearfog: add pro variant compatible in legacy =
dts
      arm: dts: marvell: clearfog-gtr: add board-specific compatible str=
ings
      arm: dts: marvell: clearfog-gtr: sort pinctrl nodes alphabetically
      arm: dts: marvell: clearfog-gtr: add missing pinctrl for all used =
gpios
      arm: dts: marvell: clearfog-gtr-l8: add support for second sfp con=
nector
      arm: dts: marvell: clearfog-gtr-l8: align port numbers with enclos=
ure

Judith Mendez (7):
      arm64: dts: ti: k3-am62a-main: Add sdhci2 instance
      arm64: dts: ti: k3-am64-main: Fix ITAP/OTAP values for MMC
      arm64: dts: ti: k3-am62p: Add ITAP/OTAP values for MMC
      arm64: dts: ti: k3-am6*: Remove DLL properties for soft PHYs
      arm64: dts: ti: k3-am6*: Fix ti,clkbuf-sel property in MMC nodes
      arm64: dts: ti: k3-am6*: Fix bus-width property in MMC nodes
      arm64: dts: ti: k3-am6*: Add bootph-all property in MMC node

Kever Yang (1):
      arm64: dts: rockchip: remove redundant cd-gpios from rk3588 sdmmc =
nodes

Kishon Vijay Abraham I (1):
      arm64: dts: ti: Add DT overlay for PCIe + USB3.0 SERDES personalit=
y card

Komal Bajaj (2):
      arm64: dts: qcom: qcm6490-idp: Correct the voltage setting for vph=
_pwr
      arm64: dts: qcom: qcs6490-rb3gen2: Correct the voltage setting for=
 vph_pwr

Konrad Dybcio (27):
      dt-bindings: clock: gcc-sc8180x: Add the missing CX power domain
      arm64: dts: qcom: sc8180x: Hook up VDD_CX as GCC parent domain
      arm64: dts: qcom: sc8180x: Fix up big CPU idle state entry latency
      arm64: dts: qcom: sc8180x: Add missing CPU off state
      arm64: dts: qcom: sc8180x: Fix eDP PHY power-domains
      arm64: dts: qcom: sc8180x: Don't hold MDP core clock at FMAX
      arm64: dts: qcom: sc8180x: Add RPMh sleep stats
      arm64: dts: qcom: x1e80100: Add missing system-wide PSCI power dom=
ain
      arm64: dts: qcom: x1e80100: Flush RSC sleep & wake votes
      arm64: dts: qcom: msm8916: Hook up GPU cooling device
..

Krishna Kurapati (4):
      arm64: dts: qcom: Fix hs_phy_irq for QUSB2 targets
      arm64: dts: qcom: Fix hs_phy_irq for non-QUSB2 targets
      arm64: dts: qcom: Fix hs_phy_irq for SDM670/SDM845/SM6350
      arm64: dts: qcom: Add missing interrupts for qcs404/ipq5332

Krishna chaitanya chundru (1):
      arm64: dts: qcom: sc7280: Add additional MSI interrupts

Krzysztof Kozlowski (51):
      arm64: dts: qcom: x1e80100: drop qcom,drv-count
      ARM: dts: qcom: ipq8064: drop unused reset-names from DWC3 node
      ARM: dts: qcom: sdx65: correct clock order in DWC3 node
      ARM: dts: qcom: ipq4019: correct clock order in DWC3 node
      ARM: dts: qcom: use defines for interrupts
      ARM: dts: sti: minor whitespace cleanup around '=3D'
      arm64: dts: qcom: sm8150: add necessary ref clock to PCIe
      arm64: dts: qcom: sm8450-hdk: correct AMIC4 and AMIC5 microphones
      arm64: dts: qcom: sm8150: describe all PCI MSI interrupts
      arm64: dts: qcom: sm8250: describe all PCI MSI interrupts
      arm64: dts: qcom: sm8350: describe all PCI MSI interrupts
      arm64: dts: qcom: sm8450: describe all PCI MSI interrupts
..

Kuninori Morimoto (1):
      ARM: dts: renesas: r8a7778: Add missing reg-names to sound node

Kyrie Wu (1):
      arm64: dts: mediatek: mt8186: Add venc node

Lad Prabhakar (4):
      dt-bindings: soc: renesas: Preserve the order of SoCs based on the=
ir part numbers
      arm64: dts: renesas: rzg2l: Add missing interrupts to IRQC nodes
      arm64: dts: renesas: r9a08g045: Add missing interrupts to IRQC node
      dt-bindings: soc: renesas: renesas-soc: Add pattern for gray-hawk

Leonard G=C3=B6hrs (2):
      ARM: dts: stm32: lxa-tac: drive powerboard lines as open-drain
      ARM: dts: stm32: lxa-tac: reduce RGMII interface drive strength

Li Hua Qian (1):
      arm64: dts: ti: Add reserved memory for watchdog

Li Yang (3):
      arm64: dts: ls1012a: correct the size of dcfg block
      arm64: dts: ls1012a: add gpio for i2c bus recovery
      ARM: dts: ls1021a: Enable usb3-lpm-capable for usb3 node

Ling Xu (2):
      arm64: dts: qcom: sm8550: Add dma-coherent property
      arm64: dts: qcom: sm8650: Add dma-coherent property

Linus Walleij (6):
      ARM: dts: gemini: Fix switch node names in the DIR-685
      ARM: dts: gemini: Fix wiligear compatible strings
      ARM: dts: gemini: Map reset keys to KEY_RESTART
      ARM: dts: gemini: Fix switch node names on Vitesse switches
      ARM: dts: versatile: Fix up VGA connector
      ARM: dts: integrator: Fix up VGA connector

Lionel Debieve (2):
      ARM: dts: stm32: add CRC on stm32mp131
      ARM: dts: stm32: enable CRC on stm32mp135f-dk

Liu Ying (1):
      arm64: dts: imx8mp-evk: Fix hdmi@3d node

Luca Weiss (13):
      arm64: dts: qcom: sc7280: Move video-firmware to chrome-common
      arm64: dts: qcom: qcm6490-fairphone-fp5: Enable venus node
      ARM: dts: qcom: msm8926-htc-memul: Add rmtfs memory node
      arm64: dts: qcom: sc7280: Add static properties to cryptobam
      arm64: dts: qcom: qcm6490-fairphone-fp5: Add missing reserved-memo=
ry
      arm64: dts: qcom: qcm6490-fairphone-fp5: Add PMIC GLINK
      arm64: dts: qcom: sm7225-fairphone-fp4: Switch firmware ext to .mbn
      ARM: dts: qcom: apq8026-lg-lenok: Add vibrator support
      arm64: dts: qcom: sm6350: Add tsens thermal zones
      arm64: dts: qcom: sm6350: Add interconnect for MDSS
      arm64: dts: qcom: sm6350: Remove "disabled" state of GMU
      arm64: dts: qcom: sm7225-fairphone-fp4: Enable display and GPU
      arm64: dts: qcom: pmi632: Add PBS client and use in LPG node

Lucas Karpinski (1):
      arm64: dts: qcom: sa8540p-ride: disable pcie2a node

MD Danish Anwar (2):
      arm64: dts: ti: k3-am642-evm: add ICSSG1 Ethernet support
      arm64: dts: ti: k3-am642-evm: add overlay for ICSSG1 2nd port

Manivannan Sadhasivam (15):
      dt-bindings: clock: qcom: Add missing UFS QREF clocks
      arm64: dts: qcom: msm8996: Fix UFS PHY clocks
      arm64: dts: qcom: msm8998: Fix UFS PHY clocks
      arm64: dts: qcom: sdm845: Fix UFS PHY clocks
      arm64: dts: qcom: sm6115: Fix UFS PHY clocks
      arm64: dts: qcom: sm6125: Fix UFS PHY clocks
      arm64: dts: qcom: sm6350: Fix UFS PHY clocks
      arm64: dts: qcom: sm8150: Fix UFS PHY clocks
      arm64: dts: qcom: sm8250: Fix UFS PHY clocks
      arm64: dts: qcom: sc8180x: Fix UFS PHY clocks
      arm64: dts: qcom: sc8280xp: Fix UFS PHY clocks
      arm64: dts: qcom: sm8350: Fix UFS PHY clocks
      arm64: dts: qcom: sm8550: Fix UFS PHY clocks
      arm64: dts: qcom: sm8650: Fix UFS PHY clocks
      arm64: dts: sm8650: Add msi-map-mask for PCIe nodes

Manorit Chawdhry (2):
      arm64: dts: ti: k3-j721s2: Fix power domain for VTM node
      arm64: dts: ti: k3-j784s4: Fix power domain for VTM node

Mantas Pucka (2):
      arm64: dts: qcom: ipq6018: add tsens node
      arm64: dts: qcom: ipq6018: add thermal zones

Manuel Traut (3):
      dt-bindings: arm64: rockchip: Add Pine64 PineTab2
      arm64: dts: rockchip: Add devicetree for Pine64 PineTab2
      ARM: dts: imx6ul: Set macaddress location in ocotp

Marc Gonzalez (2):
      dt-bindings: vendor-prefixes: add freebox
      dt-bindings: arm: amlogic: add fbx8am binding

Marek Vasut (3):
      arm64: dts: imx8mp: Enable PCIe to Data Modul i.MX8M Plus eDM SBC
      arm64: dts: imx8mp: Enable SAI audio on Data Modul i.MX8M Plus eDM=
 SBC
      arm64: dts: imx8mp: Set SPI NOR to max 40 MHz on Data Modul i.MX8M=
 Plus eDM SBC

Marijn Suijten (1):
      arm64: dts: qcom: sdm630-nile: Enable and configure PM660L WLED

Mark Hasemeyer (11):
      ARM: dts: samsung: exynos5420-peach: Enable cros-ec-spi as wake so=
urce
      ARM: dts: samsung: exynos5800-peach: Enable cros-ec-spi as wake so=
urce
      arm64: dts: mediatek: mt8173: Enable cros-ec-spi as wake source
      arm64: dts: mediatek: mt8183: Enable cros-ec-spi as wake source
      arm64: dts: mediatek: mt8192: Enable cros-ec-spi as wake source
      arm64: dts: mediatek: mt8195: Enable cros-ec-spi as wake source
      arm64: dts: qcom: sc7180: Enable cros-ec-spi as wake source
      arm64: dts: qcom: sc7280: Enable cros-ec-spi as wake source
      arm64: dts: qcom: sdm845: Enable cros-ec-spi as wake source
      ARM: tegra: Enable cros-ec-spi as wake source
      arm64: tegra: Enable cros-ec-spi as wake source

Martin Blumenstingl (3):
      ARM: dts: meson: fix bus node names
      ARM: dts: meson8: fix &hwrng node compatible string
      ARM: dts: meson8b: fix &hwrng node compatible string

Martin Botka (1):
      arm64: dts: allwinner: h616: Add thermal sensor and zones

Martin J=C3=BCcker (1):
      ARM: dts: samsung: exynos4412-p4note: add accelerometer and gyro t=
o p4note

Mateusz Majewski (1):
      ARM: dts: samsung: exynos5422-odroidxu3: disable thermal polling

Mathieu Othacehe (4):
      dt-bindings: arm: fsl: Add VAR-SOM-MX93 with Symphony
      arm64: dts: imx93-var-som: Add Variscite VAR-SOM-MX93
      dt-bindings: arm: fsl: Add phyBOARD-Segin-i.MX93
      arm64: dts: imx93: Add phyBOARD-Segin-i.MX93 support

Matti Lehtim=C3=A4ki (3):
      ARM: dts: qcom: apq8026-samsung-matissewifi: Configure touch keys
      ARM: dts: qcom: msm8226: Sort and clean up nodes
      ARM: dts: qcom: msm8226: Add watchdog node

Maulik Shah (1):
      arm64: dts: qcom: sc7280: Update domain-idle-states for cluster sl=
eep

Maxim Schwalm (1):
      dt-bindings: arm: tegra: Add LG Optimus Vu P895 and Optimus 4X P880

Michal Simek (15):
      dt-bindings: firmware: xilinx: Fix versal-fpga node name
      dt-bindings: firmware: xilinx: Describe missing child nodes
      dt-bindings: firmware: xilinx: Sort node names (clock-controller)
      arm64: zynqmp: Rename zynqmp-power node to power-management
      arm64: zynqmp: Setup default si570 frequency to 156.25MHz
      arm64: zynqmp: Describe assigned-clocks for uarts
      arm64: zynqmp: Fix comment to be aligned with board name.
      arm64: zynqmp: Introduce u-boot options node with bootscr-address
      arm64: zynqmp: Remove incorrect comment from kv260s
      arm64: zynqmp: Rename i2c?-gpio to i2c?-gpio-grp
      arm64: zynqmp: Comment all smmu entries
      arm64: zynqmp: Align usb clock nodes with binding
      dt-bindings: soc: xilinx: Add support for K26 rev2 SOMs
      dt-bindings: soc: xilinx: Add support for KV260 CC
      dt-bindings: firmware: xilinx: Describe soc-nvmem subnode

Michal Vok=C3=A1=C4=8D (2):
      ARM: dts: imx6dl-yapp4: Fix typo in the QCA switch register address
      ARM: dts: imx6dl-yapp4: Move the internal switch PHYs under the sw=
itch node

Mihai Sain (3):
      dt-bindings: ARM: at91: Document Microchip SAMA7G54 Curiosity
      ARM: dts: microchip: sama7g5: Add flexcom 10 node
      ARM: dts: microchip: sama7g54_curiosity: Add initial device tree o=
f the board

Minh Le (1):
      arm64: dts: renesas: r8a779h0: Add RWDT node

Muhammed Efe Cetin (3):
      dt-bindings: arm: rockchip: Add NanoPi R6 series boards
      arm64: dts: rockchip: Add support for NanoPi R6S
      arm64: dts: rockchip: Add support for NanoPi R6C

Nathan Morrisson (3):
      arm64: dts: ti: Disable clock output of the ethernet PHY
      arm64: dts: ti: phycore-am64: Add ADC
      arm64: dts: ti: am62-phyboard-lyra: Add overlay to enable a GPIO f=
an

Neal Frager (1):
      arm64: zynqmp: Add output-enable pins to SOMs

Neil Armstrong (10):
      dt-bindings: arm: qcom: Document the HDK8550 board
      arm64: dts: qcom: sm8550: add support for the SM8550-HDK board
      arm64: dts: qcom: sm8550-qrd: enable Touchscreen
      arm64: dts: qcom: sm8650-qrd: add USB-C Altmode Support
      arm64: dts: qcom: sm8650: Use GIC-ITS for PCIe0 and PCIe1
      arm64: dts: qcom: sm8650: add missing qlink_logging reserved memor=
y for mpss
      arm64: dts: qcom: sm8650-qrd: add Audio nodes
      arm64: dts: qcom: sm8650-mtp: add Audio sound card node
      arm64: dts: qcom: sm8550-hdk: correct WCD9385 route and port mappi=
ng
      arm64: dts: qcom: sm8550: Use GIC-ITS for PCIe0 and PCIe1

Niklas S=C3=B6derlund (1):
      dt-bindings: renesas: Document preferred compatible naming

Ninad Naik (1):
      arm64: dts: qcom: sa8775p: Add new memory map updates to SA8775P

Nishanth Menon (18):
      ARM: dts: keystone: Replace http urls with https
      arm64: dts: ti: Use https for urls
      arm64: dts: ti: k3-am62a7: Add MIT license along with GPL-2.0
      arm64: dts: ti: k3-am625: Add MIT license along with GPL-2.0
      arm64: dts: ti: k3-am62p: Add MIT license along with GPL-2.0
      arm64: dts: ti: k3-am64: Add MIT license along with GPL-2.0
      ARM: dts: omap: Switch over to https:// url
..

Nitin Yadav (2):
      arm64: dts: ti: k3-am62a-main: Add sdhci0 instance
      arm64: dts: ti: k3-am62a7-sk: Enable eMMC support

N=C3=ADcolas F. R. A. Prado (4):
      arm64: dts: mt8183: Move CrosEC base detection node to kukui-based=
 DTs
      arm64: dts: mediatek: mt8192-asurada: Remove CrosEC base detection=
 node
      arm64: dts: mediatek: mt8186: Add missing clocks to ssusb power do=
mains
      arm64: dts: mediatek: mt8186: Add missing xhci clock to usb contro=
llers

Ole P. Orhagen (1):
      ARM: dts: vexpress: Set stdout-path to serial0 in the chosen node

Oleksij Rempel (1):
      ARM: dts: imx6: skov: add aliases for all ethernet nodes

Peter Griffin (1):
      arm64: dts: exynos: gs101: define Multi Core Timer (MCT) node

Petlozu Pravareshwar (1):
      dt-bindings: tegra: pmc: Update scratch as an optional aperture

Philippe Schenker (1):
      arm64: dts: imx8mp-verdin: Label ldo5 and link to usdhc2

Pierre-Hugues Husson (2):
      arm64: dts: amlogic: add fbx8am board
      arm64: dts: amlogic: add fbx8am DT overlays

Quentin Schulz (2):
      arm64: dts: rockchip: add spi controller aliases on rk3399
      arm64: dts: rockchip: remove duplicate SPI aliases for helios64

Rafa=C5=82 Mi=C5=82ecki (18):
      arm64: dts: mediatek: mt7986: fix reference to PWM in fan node
      arm64: dts: mediatek: mt7986: drop crypto's unneeded/invalid clock=
 name
      arm64: dts: mediatek: mt7986: fix SPI bus width properties
      arm64: dts: mediatek: mt7986: fix SPI nodename
      arm64: dts: mediatek: mt7986: drop "#clock-cells" from PWM
      arm64: dts: mediatek: mt7986: add "#reset-cells" to infracfg
      dt-bindings: arm64: mediatek: Add MT7981B and Xiaomi AX3000T
      arm64: dts: mediatek: Add initial MT7981B and Xiaomi AX3000T
      dt-bindings: arm64: mediatek: Add MT7988A and BPI-R4
..

Rajendra Nayak (3):
      dt-bindings: clock: qcom: Document the X1E80100 Display Clock Cont=
roller
      dt-bindings: clock: qcom: Document the X1E80100 GPU Clock Controll=
er
      dt-bindings: clock: qcom: Document the X1E80100 Camera Clock Contr=
oller

Ran Wang (1):
      arm64: dts: ls1012a: fix DWC3 USB VBUS glitch issue

Raphael Gallais-Pou (1):
      ARM: dts: stm32: fix DSI peripheral clock on stm32mp15 boards

Ravi Gunasekaran (1):
      arm64: dts: ti: k3-am62p5-sk: Enable CPSW MDIO node

Raymond Hackley (1):
      dt-bindings: qcom: Document new msm8916-samsung devices

Rob Herring (1):
      dtc: Enable dtc interrupt_provider check

Robert Eckelmann (1):
      ARM: tegra: nexus7: Add missing clock binding into sound node

Robert Marko (2):
      ARM: dts: qcom: ipq4019-ap.dk01.1: use existing labels for nodes
      ARM: dts: qcom: ipq4019-ap.dk01.1: align flash node with bindings

Roger Quadros (2):
      arm64: dts: ti: am65x: Fix dtbs_install for Rocktech OLDI overlay
      arm64: dts: ti: Add DT overlay for PCIe + USB2.0 SERDES personalit=
y card

Romain Naour (5):
      arm64: dts: ti: k3-am69-sk: fix PMIC interrupt number
      arm64: dts: ti: k3-j721e-sk: fix PMIC interrupt number
      ARM: dts: ti: omap: add missing phy_gmii_sel unit address for dra7=
 SoC
      ARM: dts: ti: omap: add missing sys_32k_ck unit address for dra7 S=
oC
      ARM: dts: ti: omap: add missing abb_{mpu,ivahd,dspeve,gpu} unit ad=
dresses for dra7 SoC

Rudraksha Gupta (3):
      ARM: dts: qcom: msm8960: expressatt: Add gpio-keys
      ARM: dts: qcom: msm8960: Add gsbi3 node
      ARM: dts: qcom: msm8960: expressatt: Add mXT224S touchscreen

Sam Protsenko (3):
      dt-bindings: clock: exynos850: Add PDMA clocks
      arm64: dts: exynos: Add PDMA node for Exynos850
      arm64: dts: exynos: Add SPI nodes for Exynos850

Sebastian Reichel (12):
      dt-bindings: soc: rockchip: add clock to RK3588 VO grf
      dt-bindings: soc: rockchip: add rk3588 USB3 syscon
      dt-bindings: vendor-prefixes: add UNI-T
      dt-bindings: arm: add UNI-T UTi260B
      ARM: dts: imx6ull: fix pinctrl node name
      ARM: dts: imx6ul: Remove fsl,anatop from usbotg1
      ARM: dts: nxp: imx6ul: xnur-gpio -> xnur-gpios
      ARM: dts: nxp: imx6ul: fix touchscreen node name
..

Shengjiu Wang (3):
      arm64: dts: imx8mm-evk: Add PDM micphone sound card support
      arm64: dts: imx8mn-evk: Add PDM micphone sound card support
      arm64: dts: imx8mm-evk: Add spdif sound card support

Sibi Sankar (4):
      arm64: dts: qcom: x1e80100: Add IPCC node
      arm64: dts: qcom: x1e80100: Add SMP2P nodes
      arm64: dts: qcom: x1e80100: Add QMP AOSS node
      arm64: dts: qcom: x1e80100: Add ADSP/CDSP remoteproc nodes

Siddharth Vadapalli (1):
      arm64: dts: ti: k3-j722s-evm: Enable CPSW3G RGMII1

Sjoerd Simons (3):
      arm64: dts: ti: k3-am625-sk: Add boot phase tags for USB0
      arm64: dts: ti: k3-am625-beagleplay: Add boot phase tags for USB0
      arm64: dts: ti: k3-am625-beagleplay: Use the builtin mdio bus

Srinivas Neeli (1):
      arm64: zynqmp: Add resets property for CAN nodes

Stefan Hansson (4):
      dt-bindings: arm: qcom: Add Samsung Galaxy Tab 4 10.1 LTE
      ARM: dts: qcom: samsung-matisse-common: Add initial common device =
tree
      ARM: dts: qcom: Add support for Samsung Galaxy Tab 4 10.1 LTE (SM-=
T535)
      ARM: dts: qcom: samsung-matisse-common: Add UART

Stefan Nagy (1):
      arm64: dts: rockchip: Increase maximum frequency of SPI flash for =
ROCK Pi 4A/B/C

Stephan Gerhold (1):
      arm64: dts: qcom: apq8016-sbc-d3-camera: Use more generic node nam=
es

Su Bao Cheng (1):
      dt-bindings: arm: ti: Add binding for Siemens IOT2050 SM variant

Suman Anna (1):
      arm64: dts: ti: k3-am64-main: Add ICSSG IEP nodes

Suraj Jaiswal (1):
      arm64: dts: qcom: sa8775p: enable safety IRQ

Svyatoslav Ryhel (2):
      ARM: tegra: Add device-tree for LG Optimus Vu (P895)
      ARM: tegra: Add device-tree for LG Optimus 4X HD (P880)

Tamseel Shams (1):
      arm64: dts: fsd: Add fifosize for UART in Device Tree

Tejas Bhumkar (1):
      arm64: zynqmp: Disable Tri-state for MIO38 Pin

Teresa Remmet (1):
      arm64: dts: imx8mp-phyboard-pollux: Reduce drive strength for eqos=
 tx lines

Thanh Quan (2):
      arm64: dts: renesas: r8a779h0: Add Ethernet-AVB support
      arm64: dts: renesas: gray-hawk-single: Add Ethernet support

Thierry Reding (2):
      arm64: tegra: Use consistent SD/MMC aliases on Tegra234
      arm64: tegra: Add AXI configuration for Tegra234 MGBE

Thippeswamy Havalige (1):
      arm64: zynqmp: Update ECAM size to discover up to 256 buses

Thomas Bourgoin (1):
      ARM: dts: stm32: enable crypto accelerator on stm32mp135f-dk

Thomas Richard (1):
      arm64: dts: ti: k3-j7200: use ti,j7200-padconf compatible

Tim Harvey (5):
      arm64: dts: imx8mm-venice-gw7901: add digital I/O direction contro=
l GPIO's
      arm64: dts: imx8mm-venice-gw7901: add TPM device
      arm64: dts: imx8mm-venice-gw71xx: fix USB OTG VBUS
      arm64: dts: imx8mm-venice-gw71xx: add TPM device
      arm64: dts: imx8mp-venice-gw71xx: add TPM device

Tim Lunn (6):
      dt-bindings: arm: rockchip: Correct vendor for Orange Pi RK3399 bo=
ard
      dt-bindings: arm: rockchip: Correct vendor for Banana Pi R2 Pro
      arm64: dts: rockchip: adjust vendor on Banana Pi R2 Pro board
      arm64: dts: rockchip: adjust vendor on orangepi rk3399 board
      ARM: dts: rockchip: mmc aliases for Sonoff iHost
      ARM: dts: rockchip: Wifi improvements for Sonoff iHost

Tomeu Vizoso (1):
      arm64: dts: amlogic: meson-g12-common: Set the rates of the clocks=
 for the NPU

Tony Lindgren (1):
      arm64: dts: ti: k3-am62-wakeup: Configure ti-sysc for wkup_uart0

Trevor Woerner (1):
      arm64: dts: rockchip: adjust phy-handle name on rock-pi-e

Tudor Ambarus (6):
      dt-bindings: clock: google,gs101-clock: add PERIC0 clock managemen=
t unit
      arm64: dts: exynos: gs101: remove reg-io-width from serial
      arm64: dts: exynos: gs101: enable cmu-peric0 clock controller
      arm64: dts: exynos: gs101: update USI UART to use peric0 clocks
      arm64: dts: exynos: gs101: define USI8 with I2C configuration
      arm64: dts: exynos: gs101: enable eeprom on gs101-oriole

Umang Chheda (1):
      arm64: dts: qcom: qcm6490-idp: Include PM7250B

Uwe Kleine-K=C3=B6nig (3):
      dt-bindings: arm: rockchip: Add QNAP TS-433
      arm64: dts: rockchip: Add basic support for QNAP TS-433
      arm64: dts: rockchip: Fix name for UART pin header on qnap-ts433

Vaishnav Achath (14):
      arm64: dts: ti: k3-am62p-mcu/wakeup: Disable MCU and wakeup R5FSS =
nodes
      dt-bindings: arm: ti: Add bindings for J722S SoCs
      arm64: dts: ti: Introduce J722S family of SoCs
      arm64: dts: ti: Add support for TI J722S Evaluation Module
      arm64: dts: ti: k3-j721s2-common-proc-board: Enable camera periphe=
rals
      arm64: dts: ti: k3-j784s4-evm: Enable camera peripherals
      arm64: dts: ti: k3-am68-sk-base-board: Enable camera peripherals
      arm64: dts: ti: k3-am69-sk: Enable camera peripherals
      arm64: dts: ti: k3-j721e-sk: Model CSI2RX connector mux
      arm64: dts: ti: k3-j721e-main: Add CSI2RX capture nodes
      arm64: dts: ti: k3-j721s2-main: Add CSI2RX capture nodes
      arm64: dts: ti: k3-j784s4-main: Add CSI2RX capture nodes
      arm64: dts: ti: k3-j721e-sk: Add overlay for IMX219
      arm64: dts: ti: k3-j722s-evm: Enable OSPI NOR support

Vignesh Viswanathan (1):
      arm64: dts: qcom: ipq9574: Enable Inline Crypto Engine for MMC

Viken Dadhaniya (1):
      arm64: dts: qcom: sc7280: add slimbus DT node

Vladimir Lypak (4):
      dt-bindings: clock: gcc-msm8953: add more resets
      arm64: dts: qcom: msm8953: add reset for display subsystem
      arm64: dts: qcom: msm8953: Add GPU IOMMU
      arm64: dts: qcom: msm8953: Add GPU

Vladimir Zapolskiy (1):
      arm64: dts: qcom: sm6115: drop pipe clock selection

Wadim Egorov (1):
      arm64: dts: ti: k3-am642-phyboard-electra: Add TPM support

Walter Broemeling (1):
      arm64: dts: qcom: msm8916-samsung-fortuna/rossa: Add initial devic=
e trees

William-tw Lin (1):
      arm64: dts: mediatek: Add socinfo efuses to MT8173/83/96/92/95 SoCs

Wolfram Sang (5):
      arm64: dts: renesas: ulcb-kf: Drop duplicate 3.3v regulators
      arm64: dts: renesas: ulcb-kf: Add node for GNSS
      arm64: dts: renesas: ulcb-kf: Add regulators for PCIe ch1
      arm64: dts: renesas: ulcb-kf: Adapt 1.8V HDMI regulator to schemat=
ics
      arm64: dts: renesas: ulcb-kf: Adapt sound 5v regulator to schemati=
cs

Xiaowei Bao (1):
      arm64: dts: ls1088a: Add the PME interrupt for PCIe EP node

Yangyu Chen (1):
      riscv: dts: Move BUILTIN_DTB_SOURCE to common Kconfig

Yannic Moog (2):
      arm64: dts: imx8mp-phyboard-pollux-rdk: add etml panel support
      arm64: dts: imx8mp-phyboard-pollux: Set debug uart muxing to 0x140

Yashwanth Varakala (1):
      arm64: dts: imx8mp-phyboard-pollux: Add and update rtc devicetree =
node

Yassine Oudjana (1):
      arm64: dts: qcom: msm8996: Define UFS UniPro clock limits

Yunfei Dong (1):
      arm64: dts: mediatek: mt8186: Add video decoder device nodes

Zelong Dong (1):
      arm64: dts: amlogic: add reset controller for Amlogic C3 SoC

sheetal (4):
      arm64: tegra: Move AHUB ports to SoC DTSI
      arm64: tegra: Define missing IO ports
      arm64: tegra: Add audio support for Jetson Orin NX and Jetson Orin=
 Nano
      arm64: tegra: Remove Jetson Orin NX and Jetson Orin Nano DTSI

   0.2% Documentation/devicetree/bindings/arm/marvell/
   0.0% Documentation/devicetree/bindings/arm/tegra/
   0.0% Documentation/devicetree/bindings/arm/ti/
   0.8% Documentation/devicetree/bindings/arm/
   0.3% Documentation/devicetree/bindings/clock/
   0.0% Documentation/devicetree/bindings/display/panel/
   0.2% Documentation/devicetree/bindings/firmware/xilinx/
   0.0% Documentation/devicetree/bindings/fpga/
   0.2% Documentation/devicetree/bindings/gpu/
   0.0% Documentation/devicetree/bindings/media/
   0.0% Documentation/devicetree/bindings/power/
   0.0% Documentation/devicetree/bindings/reset/
   0.2% Documentation/devicetree/bindings/soc/renesas/
   0.0% Documentation/devicetree/bindings/soc/rockchip/
   0.1% Documentation/devicetree/bindings/soc/xilinx/
   0.0% Documentation/devicetree/bindings/sram/
   0.0% Documentation/devicetree/bindings/
   0.0% arch/arm/boot/dts/allwinner/
   0.0% arch/arm/boot/dts/amlogic/
   0.0% arch/arm/boot/dts/arm/
   0.1% arch/arm/boot/dts/gemini/
   0.1% arch/arm/boot/dts/marvell/
   1.1% arch/arm/boot/dts/microchip/
   6.9% arch/arm/boot/dts/nvidia/
   3.6% arch/arm/boot/dts/nxp/imx/
   0.0% arch/arm/boot/dts/nxp/ls/
   0.0% arch/arm/boot/dts/nxp/mxs/
   3.2% arch/arm/boot/dts/qcom/
   0.1% arch/arm/boot/dts/renesas/
   0.2% arch/arm/boot/dts/rockchip/
   0.2% arch/arm/boot/dts/samsung/
   0.2% arch/arm/boot/dts/st/
   0.0% arch/arm/boot/dts/ti/davinci/
   0.0% arch/arm/boot/dts/ti/keystone/
   0.5% arch/arm/boot/dts/ti/omap/
   0.0% arch/arm/mach-qcom/
   0.0% arch/arm/
   1.3% arch/arm64/boot/dts/allwinner/
   1.8% arch/arm64/boot/dts/amlogic/
   0.4% arch/arm64/boot/dts/exynos/google/
   0.1% arch/arm64/boot/dts/exynos/
   9.5% arch/arm64/boot/dts/freescale/
   0.0% arch/arm64/boot/dts/intel/
   0.1% arch/arm64/boot/dts/marvell/
   7.9% arch/arm64/boot/dts/mediatek/
   6.4% arch/arm64/boot/dts/nvidia/
  17.4% arch/arm64/boot/dts/qcom/
   5.3% arch/arm64/boot/dts/renesas/
  10.4% arch/arm64/boot/dts/rockchip/
   0.0% arch/arm64/boot/dts/st/
   0.0% arch/arm64/boot/dts/tesla/
  16.3% arch/arm64/boot/dts/ti/
   0.4% arch/arm64/boot/dts/xilinx/
   0.0% arch/riscv/boot/dts/canaan/
   0.0% arch/riscv/boot/dts/microchip/
   0.0% arch/riscv/boot/dts/sifive/
   0.0% arch/riscv/boot/dts/sophgo/
   0.0% arch/riscv/boot/dts/starfive/
   0.0% arch/riscv/boot/dts/
   0.0% arch/riscv/configs/
   0.1% arch/riscv/
   0.0% drivers/clk/rockchip/
   0.0% drivers/iommu/
   1.6% include/dt-bindings/clock/
   0.0% include/dt-bindings/mfd/
   0.1% include/dt-bindings/power/
   0.0% include/dt-bindings/reset/
   0.0% scripts/

