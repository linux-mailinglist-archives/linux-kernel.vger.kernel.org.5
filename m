Return-Path: <linux-kernel+bounces-23852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56DAA82B2CD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 17:22:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E63F1C20A69
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F5350266;
	Thu, 11 Jan 2024 16:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="ZMmkUfov";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ENiLZzhg"
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265805025A
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 16:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 036A33200AFF;
	Thu, 11 Jan 2024 11:20:11 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 11 Jan 2024 11:20:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1704990011;
	 x=1705076411; bh=gNBm75P/BzEJKB3blSTo2jlzNOpKk99lOVmMsOox8Jk=; b=
	ZMmkUfov0oGo2MFjyTwe15A6QQ/dc+1hqJb8hkPx3hnyDsh7Jx7ZhHejcOwMzm8O
	O9w4yGBujWIy7TMvPIFoRNu83HytFQ8RnYWb6jukZIJUePEF8kkOw+vBlfT0ADJu
	fVyKdx7UOEcORuCSNRZs9QxUZXGmHbVWJXiyZpFT+NgDuAN9+Oy+RDQjnqX8lbsT
	Hk9K8aXralQlI9AD4qkRRN55yD6tO0KReXbn734GC8D2AdrVCYpDpOUv3zmyTUGF
	V5pJTKd6FevdOCCdhhyNnuQrTRhqNrb5ofYs0TymJLBQo7CzhG6od3GxudOqvZD2
	6UTZh2om0BHhljne+5oZZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1704990011; x=
	1705076411; bh=gNBm75P/BzEJKB3blSTo2jlzNOpKk99lOVmMsOox8Jk=; b=E
	NiLZzhg6m8FJzY2EgXWNsSDqcyvBqppRrdbjIqmaKvUaVgvU4dW9c3eGIZP+y/sw
	5J6dv+XdkIk75HBd++eap641aK9e5Zk7K4VBCbuoC+xsy21h0UffbCq0AdNJK+l5
	t4p6Yy8BKAPzoyxWembytqlmMXZVGkFJb7/WTH0M//LlRD8hyN3i5aDGBiGfJpLJ
	RYO7FOyLMKwYeUHbVs9r8pB2jsZF+TTzwQL1TQ+wcYCSlDGnCBHbygq4IdTai0FU
	8azDpOgEGMupywBko5Ex82vKCfNllaeMmkGvIOdHtEFSc7j7L4Rauvc2R1I3qOUS
	uNH5a+FTMTpCb5InJywog==
X-ME-Sender: <xms:OxWgZWzNd76rW8cMgQs5i6emFAj2dMUCukzzFG-y1NOQNXUqJtbiGA>
    <xme:OxWgZSSbFwu6wYu2ZYeZyM-W3b6LkqP4s2vdQJDzVRMHn0VRRHM9lWtgJLFRvQDUQ
    Y4wvyglvjF0L6vZqcs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeifedgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpefgkeeuleegieeghfduudeltdekfeffjeeuleehleefudettddtgfevueef
    feeigeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:OxWgZYW-_yIIZy7HNFv3jj8bsY3UUZ0-MmO08j1MRTeo7mJzGG0n1g>
    <xmx:OxWgZcgIj-k_351DNLDCsdXayeqqKCfEl6yORigTxsssd6IJHaFo4Q>
    <xmx:OxWgZYAxbrjURJaJpuaQ_1Oh702sZyFvqOlrOnEpJHAXHLbgAwf97A>
    <xmx:OxWgZR5lI4p1ecNRdqlaCItCjfjXJDxF3D8DpYFQE7D-Psq_tcQIsQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 31988B6008D; Thu, 11 Jan 2024 11:20:11 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1374-gc37f3abe3d-fm-20240102.001-gc37f3abe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ab382a86-641b-477d-b6da-7398c600395b@app.fastmail.com>
In-Reply-To: <1c120ba6-3c94-4d94-8497-afb6c5063d3c@app.fastmail.com>
References: <1c120ba6-3c94-4d94-8497-afb6c5063d3c@app.fastmail.com>
Date: Thu, 11 Jan 2024 17:19:50 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: soc@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject:  [GIT PULL 3/4] ARM: SoC code changes for 6.8
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

The following changes since commit 2cc14f52aeb78ce3f29677c2de1f06c0e9147=
1ab:

  Linux 6.7-rc3 (2023-11-26 19:59:33 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-a=
rm-6.8

for you to fetch changes up to 40974ee421b4d1fc74ac733d86899ce1b83d8f65:

  ARM: davinci: always select CONFIG_CPU_ARM926T (2024-01-09 08:25:47 +0=
100)

----------------------------------------------------------------
ARM: SoC code changes for 6.8

There are two notable changes this time:

- Andrew Davis adds a arch/arm/Kconfig.platforms file to simplify
  the platforms that have no code except their Kconfig file

- Linux Walleij removes support for the ARM11MPCore CPU in
  the versatile/realview platform. Since this is the last
  remaining one after removing ox820, some core code can go
  as well.

The other changes are minor cleanups and bugfixes.

----------------------------------------------------------------
Andrew Davis (8):
      ARM: Kconfig: move platform selection into its own Kconfig file
      ARM: mach-asm9260: Move ASM9260 support into Kconfig.platforms
      ARM: mach-rda: Move RDA Micro support into Kconfig.platforms
      ARM: mach-uniphier: Move Socionext UniPhier support into Kconfig.p=
latforms
      ARM: mach-moxart: Move MOXA ART support into Kconfig.platforms
      ARM: mach-airoha: Rework support and directory structure
      ARM: mach-sunplus: Rework support and directory structure
      ARM: mach-nspire: Rework support and directory structure

Arnd Bergmann (5):
      Merge tag 'omap-for-v6.8/maintainers-signed' of git://git.kernel.o=
rg/pub/scm/linux/kernel/git/tmlind/linux-omap into soc/arm
      Merge tag 'at91-soc-6.8' of https://git.kernel.org/pub/scm/linux/k=
ernel/git/at91/linux into soc/arm
      Merge tag 'imx-soc-6.8' of git://git.kernel.org/pub/scm/linux/kern=
el/git/shawnguo/linux into soc/arm
      Merge tag 'mvebu-arm-6.8-1' of git://git.kernel.org/pub/scm/linux/=
kernel/git/gclement/mvebu into soc/arm
      ARM: davinci: always select CONFIG_CPU_ARM926T

Duje Mihanovi=C4=87 (1):
      soc: pxa: ssp: fix casts

Fabio Estevam (1):
      ARM: mxs: Do not search for "fsl,clkctrl"

Krzysztof Kozlowski (1):
      ARM: MAINTAINERS: drop empty entries for removed boards

Linus Walleij (2):
      ARM: Delete ARM11MPCore (ARM11 ARMv6K SMP) support
      ARM: Delete ARM11MPCore perf leftovers

Lukas Bulwahn (2):
      MAINTAINERS: add omap bus drivers to OMAP2+ SUPPORT
      MAINTAINERS: add Marvell MBus driver to Marvell EBU SoCs support

Martin Kaiser (1):
      ARM: debug: fix DEBUG_UNCOMPRESS help for !MULTIPLATFORM

Rob Herring (1):
      ARM: imx: Use device_get_match_data()

Thomas Perrot (1):
      ARM: at91: pm: set soc_pm.data.mode in at91_pm_secure_init()

 MAINTAINERS                                |  24 +---
 arch/arm/Kconfig                           |  90 +-------------
 arch/arm/Kconfig.debug                     |  11 +-
 arch/arm/Kconfig.platforms                 | 183 ++++++++++++++++++++++=
+++++++
 arch/arm/Makefile                          |   4 -
 arch/arm/kernel/perf_event_v6.c            | 128 --------------------
 arch/arm/mach-airoha/Makefile              |   2 -
 arch/arm/mach-airoha/airoha.c              |  16 ---
 arch/arm/mach-asm9260/Kconfig              |   9 --
 arch/arm/mach-at91/pm.c                    |   3 +
 arch/arm/mach-davinci/Kconfig              |   1 +
 arch/arm/mach-imx/mmdc.c                   |   9 +-
 arch/arm/mach-moxart/Kconfig               |  28 -----
 arch/arm/mach-moxart/Makefile              |   4 -
 arch/arm/mach-moxart/moxart.c              |   6 -
 arch/arm/mach-mxs/mach-mxs.c               |   4 +-
 arch/arm/mach-nspire/Kconfig               |  15 ---
 arch/arm/mach-nspire/Makefile              |   2 -
 arch/arm/mach-nspire/nspire.c              |  18 ---
 arch/arm/mach-rda/Kconfig                  |   8 --
 arch/arm/mach-sunplus/Kconfig              |  27 -----
 arch/arm/mach-sunplus/Makefile             |   8 --
 arch/arm/mach-sunplus/sp7021.c             |  16 ---
 arch/arm/mach-uniphier/Kconfig             |  15 ---
 arch/arm/mach-versatile/Kconfig            |  17 ---
 arch/arm/mach-versatile/platsmp-realview.c |   6 +-
 arch/arm/mach-versatile/realview.c         |   1 -
 arch/arm/mm/Kconfig                        |  18 ---
 arch/arm/mm/cache-v6.S                     |  31 -----
 drivers/soc/pxa/ssp.c                      |   4 +-
 30 files changed, 206 insertions(+), 502 deletions(-)
 create mode 100644 arch/arm/Kconfig.platforms
 delete mode 100644 arch/arm/mach-airoha/Makefile
 delete mode 100644 arch/arm/mach-airoha/airoha.c
 delete mode 100644 arch/arm/mach-asm9260/Kconfig
 delete mode 100644 arch/arm/mach-moxart/Kconfig
 delete mode 100644 arch/arm/mach-moxart/Makefile
 delete mode 100644 arch/arm/mach-moxart/moxart.c
 delete mode 100644 arch/arm/mach-nspire/Kconfig
 delete mode 100644 arch/arm/mach-nspire/Makefile
 delete mode 100644 arch/arm/mach-nspire/nspire.c
 delete mode 100644 arch/arm/mach-rda/Kconfig
 delete mode 100644 arch/arm/mach-sunplus/Kconfig
 delete mode 100644 arch/arm/mach-sunplus/Makefile
 delete mode 100644 arch/arm/mach-sunplus/sp7021.c
 delete mode 100644 arch/arm/mach-uniphier/Kconfig

