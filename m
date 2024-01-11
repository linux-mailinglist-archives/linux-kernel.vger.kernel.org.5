Return-Path: <linux-kernel+bounces-23856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA14282B2D7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 17:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 360E82883BD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40A84F8B0;
	Thu, 11 Jan 2024 16:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="ocgZq7HE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="8D4yvBBp"
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3468C5577D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 16:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 0F8FC3200AD3;
	Thu, 11 Jan 2024 11:21:07 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 11 Jan 2024 11:21:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1704990067;
	 x=1705076467; bh=iQZXzF0S7PZ+vUSbjwlFgbYhOjm1NnMrYmTCfLKKnSc=; b=
	ocgZq7HEKXBhxn9ydUeI72E0XPHA9ArO7Rubdkpg/gZ2bBFyxWRAr8Qw39zVIdtN
	blySdB1wYRnEEv/r6aEg6LO1z8mLOjdewS83LTZhkBY8grtqhOn70CYsm2fyfkft
	JFBhv+9XdraaUwbA+0Y7flGIPum7/0FiwDsoFkPtL6TDoo1wCY1Oed7he243Ux+6
	wRY+fDtO4/TskgkgKVcgvfORQyB8zIwm3+2YFFprFWPEq3pSBw1zI4I6KUDtZ+HT
	csyoZY5QYLOX+GlndbthpVhirZmeXJQ9XM3EYstqcp2Kal5lHFwUw7vwbefErmAu
	alAWgD4RTpzbM9QZdVyinw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1704990067; x=
	1705076467; bh=iQZXzF0S7PZ+vUSbjwlFgbYhOjm1NnMrYmTCfLKKnSc=; b=8
	D4yvBBpeVZAqivhxgzEMj/+VHwQcExiV2NBF+RgPIEDjLUqkkx3LBWRDnbUEUm9l
	HntqDsZSNCL0Qpw+Zmwny4HRv0ec7fufsybivnKAJUTW0y1IeR4w3+nVJ9UFywsA
	9aGG6H25KmSTGYyn6NG/OlRDKnAP34tt8pL/nqJLrxkR65iu1yqQEsHYspwp3FCD
	E2Vg2HT1rxdqhmIHwzz2dQkM9LLNo0HGsnYt/olEhbEByQi7mbQe1qqX7B2pg5YE
	AQm9v3/xfr8J+Ij/MuRUod/CeyEPyovHSxKAIF/LvPn+j80HcL8cWAZx5tHBzNvz
	tlNAwqgQ3XASFoIr93x9w==
X-ME-Sender: <xms:cxWgZUeVqBGQ1Y1Ls0y5R3S3j85xCOFF-0ughwGrO9aadqGwR5PBEg>
    <xme:cxWgZWN1T3KBqDkgDuGn6MLMRFTtgu4s1NtW5pM4c0e3XOPiMVYknvaERO19RN6Wf
    wbz19zRTFxBg36mQ28>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeifedgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpefgkeeuleegieeghfduudeltdekfeffjeeuleehleefudettddtgfevueef
    feeigeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    epudenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:cxWgZVhF8BeguGqhjuKwF3jqCrg3x95sHqj3JmFks_o4J29FZn_O7w>
    <xmx:cxWgZZ8CnpGUbLmowNa_iyQP5HN7PKZmQy8tqBJvUEUeQR-MihZVyg>
    <xmx:cxWgZQu8eX8addXN4fhsh51HlNBP6onQ3acVjsBZ2BUNMh5Qy5a3DA>
    <xmx:cxWgZdUiUSb3Ln0QL423h0K_ua0S2ZC7Ee9HRzDDny_xj4EdxdUWCA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 3D312B6008F; Thu, 11 Jan 2024 11:21:07 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1374-gc37f3abe3d-fm-20240102.001-gc37f3abe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3c697540-fa12-45e3-9662-521688f8d14e@app.fastmail.com>
In-Reply-To: <1c120ba6-3c94-4d94-8497-afb6c5063d3c@app.fastmail.com>
References: <1c120ba6-3c94-4d94-8497-afb6c5063d3c@app.fastmail.com>
Date: Thu, 11 Jan 2024 17:20:36 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: soc@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: [GIT PULL 4/4] ARM: SoC defconfig updates for 6.8
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

The following changes since commit 2cc14f52aeb78ce3f29677c2de1f06c0e9147=
1ab:

  Linux 6.7-rc3 (2023-11-26 19:59:33 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-d=
efconfig-6.8

for you to fetch changes up to c2dba4d19f6542e52e59873a596cce0388d0df64:

  ARM: defconfig: remove dead platform options (2024-01-11 09:55:12 +010=
0)

----------------------------------------------------------------
ARM: SoC defconfig updates for 6.8

As usual, the arm32 and arm64 defconfig files get changed to account
for added device drivers that can now be used.

The files are also refreshed to reflect the more recent Kconfig changes
that are going into v6.8.

----------------------------------------------------------------
Andreas Kemnade (1):
      ARM: omap2plus_defconfig: enable I2C devcies of bt200

Andrew Davis (1):
      ARM: multi_v7_defconfig: Enable RPMSG CHAR and CTRL

Aradhya Bhatia (1):
      arm64: defconfig: Enable Toshiba TC358767 bridge

Arnd Bergmann (12):
      Merge tag 'renesas-arm-defconfig-for-v6.8-tag1' of git://git.kerne=
l.org/pub/scm/linux/kernel/git/geert/renesas-devel into soc/defconfig
      Merge tag 'omap-for-v6.8/defconfig-signed' of git://git.kernel.org=
/pub/scm/linux/kernel/git/tmlind/linux-omap into soc/defconfig
      Merge tag 'mtk-defconfig-for-v6.8' of https://git.kernel.org/pub/s=
cm/linux/kernel/git/mediatek/linux into soc/defconfig
      Merge tag 'ti-k3-config-for-v6.8' of https://git.kernel.org/pub/sc=
m/linux/kernel/git/ti/linux into soc/defconfig
      Merge tag 'qcom-arm64-defconfig-for-6.8' of https://git.kernel.org=
/pub/scm/linux/kernel/git/qcom/linux into soc/defconfig
      Merge tag 'qcom-arm64-defconfig-for-6.8-2' of https://git.kernel.o=
rg/pub/scm/linux/kernel/git/qcom/linux into soc/defconfig
      arm64: defconfig reorder config lines
      ARM: defconfig: reorder config lines
      ARM: defconfig: remove sysfs-deprecated entries
      ARM: defconfig: remove CONFIG_NET_ETHERNET references
      ARM: defconfig: remove CONFIG_SLUB references
      ARM: defconfig: remove dead platform options

Biju Das (1):
      arm64: defconfig: Enable Renesas VersaClock 3 clock generator conf=
ig

Bjorn Andersson (1):
      arm64: defconfig: Enable Qualcomm SC8280XP camera clock controller

Claudiu Beznea (1):
      ARM: multi_v7_defconfig: Enable CONFIG_RAVB

Donald Robson (1):
      arm64: defconfig: Enable DRM_POWERVR

Etienne Carriere (1):
      ARM: multi_v7_defconfig: Add SCMI reset support

Francesco Dolcini (1):
      arm64: defconfig: Increase SERIAL_8250_NR_UARTS

Geert Uytterhoeven (1):
      ARM: shmobile: defconfig: Refresh for v6.7-rc1

Hugues Fruchet (1):
      ARM: multi_v7_defconfig: enable STM32 DCMIPP media support

Jai Luthra (1):
      arm64: defconfig: Enable J721E CSI2RX

Johan Hovold (2):
      arm64: defconfig: enable Qualcomm sc8280xp sound drivers
      arm64: defconfig: enable Qualcomm UEFI Secure App driver

Krzysztof Kozlowski (1):
      arm64: defconfig: enable Qualcomm WSA884x driver

MD Danish Anwar (1):
      arm64: defconfig: Enable TI_ICSSG_PRUETH

Mark Brown (1):
      ARM: multi_v7_defconfig: Enable STM32 IPCC mailbox driver

Neil Armstrong (2):
      arm64: deconfig: enable Qualcomm SM8650 SoC drivers
      arm64: defconfig: enable GPU clock controller for SM8[45]50

N=C3=ADcolas F. R. A. Prado (1):
      arm64: defconfig: Enable configs for MT8195-Cherry-Tomato Chromebo=
ok

Rajendra Nayak (1):
      arm64: defconfig: Enable X1E80100 SoC base configs

Rohit Agarwal (1):
      arm64: defconfig: Enable GCC, pinctrl and interconnect for SDX75

Tengfei Fan (1):
      arm64: defconfig: enable clock controller and pinctrl

Vignesh Raman (1):
      arm64: defconfig: Enable DA9211 regulator

 arch/arm/configs/am200epdkit_defconfig |   2 -
 arch/arm/configs/aspeed_g4_defconfig   |   4 +-
 arch/arm/configs/aspeed_g5_defconfig   |   4 +-
 arch/arm/configs/assabet_defconfig     |   1 -
 arch/arm/configs/at91_dt_defconfig     |   4 +-
 arch/arm/configs/bcm2835_defconfig     |   4 +-
 arch/arm/configs/clps711x_defconfig    |   7 --
 arch/arm/configs/collie_defconfig      |   3 +-
 arch/arm/configs/davinci_all_defconfig |   2 +-
 arch/arm/configs/dove_defconfig        |   2 -
 arch/arm/configs/ep93xx_defconfig      |   2 +-
 arch/arm/configs/footbridge_defconfig  |   1 -
 arch/arm/configs/gemini_defconfig      |   2 +-
 arch/arm/configs/imx_v4_v5_defconfig   |   5 --
 arch/arm/configs/jornada720_defconfig  |   2 -
 arch/arm/configs/lpc32xx_defconfig     |   2 -
 arch/arm/configs/mmp2_defconfig        |   2 -
 arch/arm/configs/moxart_defconfig      |   4 +-
 arch/arm/configs/multi_v4t_defconfig   |   3 +-
 arch/arm/configs/multi_v5_defconfig    |   2 +-
 arch/arm/configs/multi_v7_defconfig    |  30 ++++---
 arch/arm/configs/mv78xx0_defconfig     |   2 -
 arch/arm/configs/neponset_defconfig    |   1 -
 arch/arm/configs/netwinder_defconfig   |   1 -
 arch/arm/configs/omap1_defconfig       |   6 +-
 arch/arm/configs/omap2plus_defconfig   |   5 ++
 arch/arm/configs/pxa168_defconfig      |   2 -
 arch/arm/configs/pxa3xx_defconfig      |   2 -
 arch/arm/configs/pxa910_defconfig      |   2 -
 arch/arm/configs/pxa_defconfig         |   9 +-
 arch/arm/configs/qcom_defconfig        |  10 +--
 arch/arm/configs/realview_defconfig    |   6 +-
 arch/arm/configs/rpc_defconfig         |   5 +-
 arch/arm/configs/s3c6400_defconfig     |   2 -
 arch/arm/configs/s5pv210_defconfig     |   2 -
 arch/arm/configs/sama5_defconfig       |   2 +-
 arch/arm/configs/sama7_defconfig       |   4 +-
 arch/arm/configs/shmobile_defconfig    |   1 +
 arch/arm/configs/spitz_defconfig       |   2 -
 arch/arm/configs/stm32_defconfig       |   2 +-
 arch/arm/configs/tegra_defconfig       |   4 +-
 arch/arm/configs/vf610m4_defconfig     |   2 +-
 arch/arm64/configs/defconfig           | 155 +++++++++++++++++++++-----=
-------
 43 files changed, 160 insertions(+), 155 deletions(-)

