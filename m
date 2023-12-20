Return-Path: <linux-kernel+bounces-6951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E23819FC1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8C601C22606
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 13:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6666D2D638;
	Wed, 20 Dec 2023 13:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="RjoYMdLa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="umNzLV4E"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1DF2D61A
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 13:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 383E95C01D3;
	Wed, 20 Dec 2023 08:22:53 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 20 Dec 2023 08:22:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1703078573; x=1703164973; bh=MVaQ59ZRKrzj8tRObv3W3R2ScHQiNojV
	AARGAGqKes8=; b=RjoYMdLaPcXxDEFtyFwAler30h4h8N4IAWUhNxmJ2Hvt6I+t
	Sd2KN1Pu30UyEVujnEAJLNEbUAqRBg8na/EXRGu0EQ54uTRHwCS4hRvV/Y9VokpP
	B7Hc+b4mLRXJywhiSmDZVg2jXIHjErd35Z+l9FfvprWxnRyD+JPxgtFXiXBFjH3B
	bCbaDo1hkPvwEF8vSkht2A+JpkXGDB7SeWATPwZA+0JiR2d/gaQGpzNrfkeMjTJw
	AQ1UW72Ql/Kq/E+FVPGvFTQWFQnbI9iCytiz+P4kWBihI0Z/pfCp2OFSv6TkR/gd
	mhAl3QcHFer82SRMyuFzIVMNrsrYBG+NYKRFmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1703078573; x=1703164973; bh=MVaQ59ZRKrzj8tRObv3W3R2ScHQiNojVAAR
	GAGqKes8=; b=umNzLV4ETbXRKkFnjjTLQhLEsnOEvKE/+PRNGxDdrHQnfRy0Wy9
	7ksTGu6IZ4CZC4h18olFS5RTpvoIJ7wY3U3eZF8rsPbQWNUfjZTbOuuKh1foIK0m
	DQ5usx14qrBs5h2dVMoOXRXYgYTsNx+wAuObjKxLOQq1MhTCMLaz0gJco8MOEosM
	y2gvwLuKdEwbPjOtoKAEUTwkL2iRyshwfu8deklZmx3Tut+tYPul/pnWB9dc1WaH
	kt+ld/7oOg/k37TrWbwB9mpVUo7UNyusWWvh/9tZZlGyr74rLwjWc62a+FYAVvea
	jWqn0FLYFF8nWUq16itUvRnlWfS5jIuCaYA==
X-ME-Sender: <xms:rOqCZY4WQIgxIGglD5iu4AS7_lZDbCc3DjO5Hn0QSoLjjZFbzmZ4sw>
    <xme:rOqCZZ5Ka86Pxu9PoB9ryctSvUtO_zF62mTPNb4jkEThSVUm7xo23awmdDt67JfZC
    3YXW-wV6xl2AaYB7LY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdduvddghedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkfffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepueeljeetffehudfftddvhfeufffhveeffffgjeduudeiieehkeehvdeghfetfeeg
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpphgvnhhguhhtrhhonhhigidruggvne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgu
    segrrhhnuggsrdguvg
X-ME-Proxy: <xmx:rOqCZXcRwQ0jIKWRb_zzs71gKVU330GN6IKh-vd6VoKvoMbBGVC73g>
    <xmx:rOqCZdLFfOFp0b8gHn7bgwsQkaVaZPAyfngmtzOYdmOza7qpOpZU7A>
    <xmx:rOqCZcKqttHncSg0XpyOD1hXN6AbYxaMdLoimRXTCDIFIqT6F-5W9Q>
    <xmx:reqCZWj5o7Am6BUseACtMTtXM9xAaBXFVfx1ZCflvPkhL-hL-Co4SQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id CEB89B6008D; Wed, 20 Dec 2023 08:22:52 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1364-ga51d5fd3b7-fm-20231219.001-ga51d5fd3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <10ff8b28-3892-4920-b4a0-4612fe814f6d@app.fastmail.com>
Date: Wed, 20 Dec 2023 13:21:17 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: soc@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: [GIT PULL] ARM: SoC fixes for 6.7, part 2
Content-Type: text/plain

The following changes since commit a39b6ac3781d46ba18193c9dbb2110f31e9bffe9:

  Linux 6.7-rc5 (2023-12-10 14:33:40 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-fixes-6.7-2

for you to fetch changes up to fa3d6c7183106a187a8d399216db3f088a6aab81:

  arm64: dts: mediatek: mt8395-genio-1200-evk: add interrupt-parent for mt6360 (2023-12-20 13:05:43 +0000)

----------------------------------------------------------------
ARM: SoC fixes for 6.7, part 2

There are only a handful of bugfixes this time, which feels almost too
small, so I hope we are not missing something important.

 - One more mediatek dts warning fix after the previous larger set,
   this should finally result in a clean defconfig build.

 - TI OMAP dts fixes for a spurious hang on am335x and invalid data on DTA7

 - One DTS fix for ethernet on Oriange Pi Zero (Allwinner H616)

 - A regression fix for ti-sysc interconnect target module driver to
   not access registers after reset if srst_udelay quirk is needed

 - Reset controller driver fixes for a crash during error handling and
   a build warning

----------------------------------------------------------------
Andrew Davis (1):
      ARM: dts: dra7: Fix DRA7 L3 NoC node register size

Arnd Bergmann (4):
      Merge tag 'sunxi-fixes-for-6.7-1' of https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux into arm/fixes
      Merge tag 'reset-fixes-for-v6.7' of git://git.pengutronix.de/pza/linux into arm/fixes
      Merge tag 'omap-for-v6.7/fixes-signed' of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap into arm/fixes
      Merge tag 'am3-usb-hang-fix-signed' of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap into arm/fixes

Chukun Pan (1):
      arm64: dts: allwinner: h616: update emac for Orange Pi Zero 3

Geert Uytterhoeven (1):
      reset: Fix crash when freeing non-existent optional resets

Krzysztof Kozlowski (1):
      reset: hisilicon: hi6220: fix Wvoid-pointer-to-enum-cast warning

Kunwu Chan (1):
      ARM: OMAP2+: Fix null pointer dereference and memory leak in omap_soc_device_init

Macpaul Lin (1):
      arm64: dts: mediatek: mt8395-genio-1200-evk: add interrupt-parent for mt6360

Tony Lindgren (2):
      bus: ti-sysc: Flush posted write only after srst_udelay
      ARM: dts: Fix occasional boot hang for am3 usb

 arch/arm/boot/dts/ti/omap/am33xx.dtsi                  |  1 +
 arch/arm/boot/dts/ti/omap/dra7.dtsi                    |  2 +-
 arch/arm/mach-omap2/id.c                               |  5 +++++
 .../boot/dts/allwinner/sun50i-h616-orangepi-zero.dtsi  |  3 ---
 .../boot/dts/allwinner/sun50i-h616-orangepi-zero2.dts  |  3 +++
 .../boot/dts/allwinner/sun50i-h618-orangepi-zero3.dts  |  2 ++
 arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts |  1 +
 drivers/bus/ti-sysc.c                                  | 18 ++++++++++++++----
 drivers/reset/core.c                                   |  8 ++++----
 drivers/reset/hisilicon/hi6220_reset.c                 |  2 +-
 10 files changed, 32 insertions(+), 13 deletions(-)

