Return-Path: <linux-kernel+bounces-66998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9749F856499
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53C3E283F5A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA81D130E2D;
	Thu, 15 Feb 2024 13:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AF2Kzer2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088A7130AC3;
	Thu, 15 Feb 2024 13:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708004358; cv=none; b=UE614iS0tOv0zzV1h6xyLcyQkyq1mQRIwJiCpRNTpsQFyeX4AxWzxV5vI36qwqd9J+5kg4vkZPDeDokg+/vLnKEEQoY5uurtVejSsi7DaQ6qXW90UwJQ7LWjJjUekjgUk9qBQ+9DxR3j9agP5Ttj1c15ipH/2kkFCI/ENgE3FAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708004358; c=relaxed/simple;
	bh=FcRG8ev21EOxMxAb92p52J+RhFrS35dg4haLx5CuABk=;
	h=From:To:Cc:Subject:Date:Message-Id; b=K7ZtgOOQC3hbPzODKpnCqzmmOzxPnPBjCGrbIgQ+wsl+nbCrGDN9GO9DOWv3XDcoE+aL7zL5Bw7EGsKJYiSrTclcywgMPX2vzVwyI8QZ3Je+NXtyT3CWuZQE7ewJm9/ETuu6qu5NpfIuQWmGGHpWC+bv318RtVraWjDifXX8wP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AF2Kzer2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0534C433C7;
	Thu, 15 Feb 2024 13:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708004357;
	bh=FcRG8ev21EOxMxAb92p52J+RhFrS35dg4haLx5CuABk=;
	h=From:To:Cc:Subject:Date:From;
	b=AF2Kzer2CZD8yJ93eilVvcUOCbybsIX+b7/LEw2ue5S0cHJw605Sb6RTQWwCvyJzy
	 Vy+/5vAbr0AX8wbE1rEcc343ej7fyuc1FuunEyL5+2JmyTEBN3B4KW8+10nbjW8PSV
	 CeC2kR3lwm9VKdBgtBt1oHYiTZSGpPrpqYWlM4/Azi7jnne4npAVOUQEcqXWqxiLSz
	 aNB1/iE9ZaNuLagrMmh30A42LNuWQx0icszGOUDpWHOiIjNiajrzFX2zopSB2P7lar
	 V3fteKBL1JLI5bbS3jNJrA7L2ho4a4zE/jsvXvocW5J425xfCSI2f2KtTq7OgyiHju
	 7xU72mhGo08rg==
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v6.8-rc4
Date: Thu, 15 Feb 2024 13:39:06 +0000
Message-Id: <20240215133916.F0534C433C7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The following changes since commit 6500ad28fd5d67d5ca0fee9da73c463090842440:

  spi: sh-msiof: avoid integer overflow in constants (2024-01-30 15:27:21 +0000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.8-rc4

for you to fetch changes up to 269e31aecdd0b70f53a05def79480f15cbcc0fd6:

  spi-mxs: Fix chipselect glitch (2024-02-13 15:48:22 +0000)

----------------------------------------------------------------
spi: Fixes for v6.8

A smallish collection of fixes for SPI, all driver specific, plus one
device ID addition for a new Intel part.  The ppc4xx isn't routinely
covered by most of the automated testing so there were some errors that
were missed in some of the recent API conversions, otherwise there's
nothing super remarkable here.

----------------------------------------------------------------
Carlos Song (1):
      spi: imx: fix the burst length at DMA mode and CPU mode

Christian Lamparter (1):
      spi: spi-ppc4xx: include missing platform_device.h

Mika Westerberg (1):
      spi: intel-pci: Add support for Lunar Lake-M SPI serial flash

Ralf Schlatterbeck (1):
      spi-mxs: Fix chipselect glitch

Uwe Kleine-König (3):
      spi: ppc4xx: Fix fallout from include cleanup
      spi: ppc4xx: Fix fallout from rename in struct spi_bitbang
      spi: ppc4xx: Drop write-only variable

Vaishnav Achath (1):
      spi: omap2-mcspi: Revert FIFO support without DMA

 drivers/spi/spi-imx.c         |   9 +--
 drivers/spi/spi-intel-pci.c   |   1 +
 drivers/spi/spi-mxs.c         |   3 +-
 drivers/spi/spi-omap2-mcspi.c | 137 +++---------------------------------------
 drivers/spi/spi-ppc4xx.c      |  21 +++----
 5 files changed, 25 insertions(+), 146 deletions(-)

