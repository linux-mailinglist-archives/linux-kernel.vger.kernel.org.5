Return-Path: <linux-kernel+bounces-143273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D823D8A367F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 21:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60E651F25F0B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 19:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD9C14F9F5;
	Fri, 12 Apr 2024 19:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="fMfr/MuN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f6LjV1Oc"
Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B8B1509A0
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 19:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712951338; cv=none; b=JAyB16q6FOmtibSgfuxsO9qmNb7rYaQU+lbGifLmNHpoA6Kcvooz6eqmiDGm8ijTdWzMGl/Hmp/4ObKHF5w7IOXOZwKSJyX9Bkrc5C8IxTkzVB9RsYQgj1qG6xmW1NwyqISBbHVTgP+BDSvcN+oPUPZtO1bNrNUk2JRnWWIKs7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712951338; c=relaxed/simple;
	bh=H3UjF8u47f/yy1g/Ygd9Bgi0G51alamMZN1SSXXk7rk=;
	h=MIME-Version:Message-Id:Date:From:To:Cc:Subject:Content-Type; b=Shuk6hDthqNOpxVEzgS6MOqMqkSOg5aEjTHJ8N5D07dFzudqo/mWYIJ41twz9DHxTEemO0R0SJruCY90LbWaRbp9lGIw7F4q6z13yjcsSNKr02s8EE53mpX3e4Ro8Lhdr6Z/XPYzImTbq6QC7BCeI43bHzkqQhs+F4AElZbmg3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=fMfr/MuN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f6LjV1Oc; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 0C7E711400D1;
	Fri, 12 Apr 2024 15:48:55 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 12 Apr 2024 15:48:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
	 t=1712951335; x=1713037735; bh=Tm1Vv8iVtUIP+//CZh4vk18U1w5+u8zC
	yyQYlZ4gpRE=; b=fMfr/MuNp7NG9aY9FrYQFR7Kufk2zWhMpgLFT+zhLjUuevZG
	QDNVIcCHe+X+4fjorfVzXZjTpupxjDa2l8qvfiPtZeyCdAFOfMb92D6pJIp1dlL1
	RzyIqYA/K5N3Kw7rbaoQTNKd20FPqEqbn4JTm5RmokkqULB71W2kDEhrwdEnlshQ
	drdHWlH+/0YZoRjNb4WQsSxsxwIYHzW6lWxZP3RG+TS8HZ/fRtzMzYGmJcZDg0NL
	Yrfmxpt69FjGTO1kc76fOSKaezV1xzA9jQN+Qnt51m+ww2iLuPGzp6Hfrr7Xfuo4
	W+GIo3BygmFsff/QJvgUQIG5Z97hG2tTM+asiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1712951335; x=1713037735; bh=Tm1Vv8iVtUIP+//CZh4vk18U1w5+u8zCyyQ
	YlZ4gpRE=; b=f6LjV1OcP91btAf4iUhiRi4syJeNpCPj/GHIrJfD8TNsQToYqbD
	OfR2+NE+4uZadr27E/6bx+gpmlt5AjhbSHsk7vHEFPnLrmm7P49iQE/bUJyHkOg8
	rGSVxLp8ht/QFhAoZ4SDZ5bqnDHQV371TdbzDbg8PkJrsX5PpTt8VrmC3tK9Cp0Q
	bm2kaqyciym4AVhFPJ/FWUISWwipWik20l3CTGlOP9LAgYLQ0CcVdJgIsWdpUJ3f
	I5D4iaNpCtpTJQAx6dNJvVw3VUSyPF5TYvWZ9a5LSnzox7EIfuw6i1d5p5kxUJfB
	SaPUdrpZfG+qa/OynYFKJ1VcKut4UPfmbeg==
X-ME-Sender: <xms:JpAZZq5KO6dhMRuS4MXt_TpEIM7eFUTzMOP6ROj9YtFRcUEaaOMtSQ>
    <xme:JpAZZj48tX1fMCSH6WhL5FwNc3ZNzCxCsYwjhYC_wTRyQcK_XPHm_3MLTEZ8qEEwl
    YoImdQskOcOEiRzI_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeiuddgudegfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeeffeeuhfekjeevtddvtdelledttddtjeegvdfhtdduvdfhueekudeihfejtefg
    ieenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:JpAZZpey0p49ofdkihCGLXgVFLfNbul6BpzTTz-p4NFnJg4UYzxYcw>
    <xmx:JpAZZnIgQcZGxNI1a_aRW2eHc7mrMO3_8y7X2q5yKUdg7yjsoJ4ztA>
    <xmx:JpAZZuIAPe7eVBoFlIG4vUaRJ3jQdGbv6q_B_zhMCnyb12Fxj-5ZnA>
    <xmx:JpAZZowIA4yCmT5vmU97rIgbK98H4OqFK-pE4gPSfnHHGFvhofPepA>
    <xmx:J5AZZq1zlwTNoEs3CetuaO0CRGUYTcyBJWNFC_-iLMqdNIbVgQgLb3Kn>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id ACDD2B6008D; Fri, 12 Apr 2024 15:48:54 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-379-gabd37849b7-fm-20240408.001-gabd37849
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4c6039da-5362-46ad-8126-dacaf7ad1169@app.fastmail.com>
Date: Fri, 12 Apr 2024 21:48:34 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: soc@kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] SoC fixes for 6.9
Content-Type: text/plain

The following changes since commit 39cd87c4eb2b893354f3b850f916353f2658ae6f:

  Linux 6.9-rc2 (2024-03-31 14:32:39 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-fixes-6.9-1

for you to fetch changes up to 011d79ef1cfad701c2d8e7e80d8c77523af9c771:

  MAINTAINERS: Change Krzysztof Kozlowski's email address (2024-04-09 17:06:51 +0200)

----------------------------------------------------------------
SoC fixes for 6.9

The device tree changes this time are all for NXP i.MX platforms, addressing
issues with clocks and regulators on i.MX7 and i.MX8.

The old OMAP2 based Nokia N8x0 tablet get a couple of code fixes for
regressions that came in.

The ARM SCMI and FF-A firmware interfaces get a couple of minor
bug fixes.

A regression fix for RISC-V cache management addresses a problem with
probe order on Sifive cores.

----------------------------------------------------------------
Aaro Koskinen (6):
      ARM: OMAP2+: fix bogus MMC GPIO labels on Nokia N8x0
      ARM: OMAP2+: fix N810 MMC gpiod table
      mmc: omap: fix broken slot switch lookup
      mmc: omap: fix deferred probe
      mmc: omap: restore original power up/down steps
      ARM: OMAP2+: fix USB regression on Nokia N8x0

Arnd Bergmann (5):
      Merge tag 'omap-for-v6.9/n8x0-fixes-signed' of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap into arm/fixes
      Merge tag 'imx-fixes-6.9' of git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into arm/fixes
      Merge tag 'scmi-fixes-6.9' of git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into arm/fixes
      Merge tag 'ffa-fix-6.9' of git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into arm/fixes
      Merge tag 'riscv-soc-fixes-for-v6.9-rc3' of https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux into arm/fixes

Cristian Marussi (1):
      firmware: arm_scmi: Make raw debugfs entries non-seekable

Fabio Estevam (2):
      ARM: dts: imx7-mba7: Use 'no-mmc' property
      ARM: dts: imx7s-warp: Pass OV2680 link-frequencies

Frank Li (8):
      arm64: dts: imx8-ss-conn: fix usdhc wrong lpcg clock order
      arm64: dts: imx8-ss-lsio: fix pwm lpcg indices
      arm64: dts: imx8-ss-conn: fix usb lpcg indices
      arm64: dts: imx8-ss-dma: fix spi lpcg indices
      arm64: dts: imx8-ss-dma: fix pwm lpcg indices
      arm64: dts: imx8-ss-dma: fix adc lpcg indices
      arm64: dts: imx8-ss-dma: fix can lpcg indices
      arm64: dts: imx8qm-ss-dma: fix can lpcg indices

Jens Wiklander (1):
      firmware: arm_ffa: Fix the partition ID check in ffa_notification_info_get()

Krzysztof Kozlowski (1):
      MAINTAINERS: Change Krzysztof Kozlowski's email address

Pierre Gondois (1):
      firmware: arm_scmi: Fix wrong fastchannel initialization

Samuel Holland (1):
      cache: sifive_ccache: Partially convert to a platform driver

Tim Harvey (2):
      arm64: dts: freescale: imx8mp-venice-gw72xx-2x: fix USB vbus regulator
      arm64: dts: freescale: imx8mp-venice-gw73xx-2x: fix USB vbus regulator

 MAINTAINERS                                        | 38 ++++++------
 arch/arm/boot/dts/nxp/imx/imx7-mba7.dtsi           |  2 +-
 arch/arm/boot/dts/nxp/imx/imx7s-warp.dts           |  1 +
 arch/arm/mach-omap2/board-n8x0.c                   | 23 +++----
 arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi    | 16 ++---
 arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi     | 40 ++++++------
 arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi    | 16 ++---
 .../boot/dts/freescale/imx8mp-venice-gw72xx.dtsi   |  2 +-
 .../boot/dts/freescale/imx8mp-venice-gw73xx.dtsi   |  2 +-
 arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi   |  8 +--
 drivers/cache/sifive_ccache.c                      | 72 ++++++++++++++--------
 drivers/firmware/arm_ffa/driver.c                  |  2 +-
 drivers/firmware/arm_scmi/powercap.c               |  2 +-
 drivers/firmware/arm_scmi/raw_mode.c               |  7 ++-
 drivers/mmc/host/omap.c                            | 48 ++++++++++-----
 15 files changed, 158 insertions(+), 121 deletions(-)

