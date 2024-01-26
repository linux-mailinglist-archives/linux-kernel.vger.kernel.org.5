Return-Path: <linux-kernel+bounces-40444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CDAD83E073
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 160A92865B1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351972031F;
	Fri, 26 Jan 2024 17:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kWvkRS6P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799BC1E880;
	Fri, 26 Jan 2024 17:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706290702; cv=none; b=DFg/28q3cXK9fCwrKlHEnvSnDjWs0FLlVfHCE+I4REQbDN3heh5Kk5wx5IjkSESpk3NaOi40/zPJb3q1G1gZcrL3mMJ2fG6yDhI4rfRPJgkVNT6T9t1TOJcTk8SskeIz5v+Aawq7wYMB7jgUYWT+7bj8ug55QUMfFgMI6dbzTpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706290702; c=relaxed/simple;
	bh=YwqFiORHx5l8cwgQfGcJO3Tt2+4l5IFSO5b/pgRsYD8=;
	h=From:To:Cc:Subject:Date:Message-Id; b=t6ZQZ5py5Z6gs93PMgFbKSV6OoPmkaYDNX2rJKON9SIERzYFrIalIfksGN17DYuy9sDfMcwSkQIwp+4TsGlaKRVrvKaKugxD4gCSxkeNwg90M9pqYv2LCk1rFtI6La7Xji1BKnBdcDk9irBHLtTKSp+qhvT9wqBTrTFCYlZBdB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kWvkRS6P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05BA0C433C7;
	Fri, 26 Jan 2024 17:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706290701;
	bh=YwqFiORHx5l8cwgQfGcJO3Tt2+4l5IFSO5b/pgRsYD8=;
	h=From:To:Cc:Subject:Date:From;
	b=kWvkRS6PaUxLAUtiXpjrDfK8viLq885SwvRGkUCxjfNEoVxYaEYnA7Dgs6WMx/SLG
	 xEsUoHqCD2fnYfTqPFJ264XXR/BoYhScR9AzfpB6b+sV9VuEEuleF3HL7TIqmi2oU+
	 ZocybPRaBpo3IgGEJs17cAZGS/f5zB1Lj+R6u2gKkvhbKYvkp4NKq7/pW+13410bf7
	 cmBaWFiA853LHx1h5W7mgQDgJfKDmzPMao2pntgEHAO9VbHyGXD1VYd7vzKoFNeTxx
	 6IEelpsCpCjtuGSmq4XlO5dW33Mf4qF44Gxjo0RjpAQIQoIP9SqtIr5oq3DpK0hGqs
	 BRnczeV4u4Y5A==
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v6.8-rc1
Date: Fri, 26 Jan 2024 17:38:11 +0000
Message-Id: <20240126173821.05BA0C433C7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.8-rc1

for you to fetch changes up to 8c2ae772fe08e33f3d7a83849e85539320701abd:

  spi: fix finalize message on error return (2024-01-25 21:55:48 +0000)

----------------------------------------------------------------
spi: Fixes for v6.8

As well as a few device IDs and the usual scattering of driver specific
fixes this contains a couple of core things.  One is a missed case in
error handling, the other patch is a change from me raising the number
of chip selects allowed by the newly added multi chip select support
patches to resolve problems seen on several systems that exceeded the
limit.  This is not a real solution to the issue but rather just a
change to avoid disruption to users, one of the options I am considering
is just sending a revert of those changes if we can't come up with
something sensible.

----------------------------------------------------------------
Alexander Stein (1):
      spi: spi-imx: Use dev_err_probe for failed DMA channel requests

Amit Kumar Mahapatra (1):
      spi: spi-cadence: Reverse the order of interleaved write and read operations

Charles Keepax (1):
      spi: cs42l43: Handle error from devm_pm_runtime_enable

David Lechner (1):
      spi: fix finalize message on error return

Devyn Liu (1):
      spi: hisi-sfc-v3xx: Return IRQ_NONE if no interrupts were detected

Kamal Dasu (1):
      spi: bcm-qspi: fix SFDP BFPT read by usig mspi read

Mark Brown (1):
      spi: Raise limit on number of chip selects

Mika Westerberg (2):
      spi: intel-pci: Remove Meteor Lake-S SoC PCI ID from the list
      spi: intel-pci: Add support for Arrow Lake SPI serial flash

 drivers/spi/spi-bcm-qspi.c      |  4 ++--
 drivers/spi/spi-cadence.c       | 17 +++++++++--------
 drivers/spi/spi-cs42l43.c       |  5 ++++-
 drivers/spi/spi-hisi-sfc-v3xx.c |  5 +++++
 drivers/spi/spi-imx.c           |  4 ++--
 drivers/spi/spi-intel-pci.c     |  2 +-
 drivers/spi/spi.c               |  4 ++++
 include/linux/spi/spi.h         |  2 +-
 8 files changed, 28 insertions(+), 15 deletions(-)

