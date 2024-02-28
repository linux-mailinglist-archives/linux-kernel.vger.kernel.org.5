Return-Path: <linux-kernel+bounces-85498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 383CD86B6A3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6563C1C211BA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78FD879B76;
	Wed, 28 Feb 2024 18:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uHnM1vlF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B897F79B63;
	Wed, 28 Feb 2024 18:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709143389; cv=none; b=AZS2y2xG89f5rBdM7vkr9B2IRtH6cv0UZk5uB2QTnnI8HKYK9ycMgVlNZpu4L448PNCXZJ92cHQjms/icbOgUWfITWJ9EEbovCjGRoiRgktjNZBQNynQKRGX/TZTYX0W+tbr64sshsfSGbp7yoYH5N8HIhv36exaoFWVH6DpmJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709143389; c=relaxed/simple;
	bh=l4xqm/bsVCldGSK7eRXlZxodJtg7wUgcVPSpUwuqX1g=;
	h=From:To:Cc:Subject:Date:Message-Id; b=ZBEMbbgpavuty7oPJ5AZ3lA6RR3oCQLu12gWSTreWnMy8T9FavGY725enXlfzqqJ6bdpvJ/nkWTrtcjwUsOfDdHc3ZitWlYLr7wxsQgu8Dh5509qix+YnH42dJwO6KuMymBES7pUXk2GdwUqu0GJtfQpNtSYZYRtkAguiyu7DNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uHnM1vlF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C6DAC43390;
	Wed, 28 Feb 2024 18:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709143389;
	bh=l4xqm/bsVCldGSK7eRXlZxodJtg7wUgcVPSpUwuqX1g=;
	h=From:To:Cc:Subject:Date:From;
	b=uHnM1vlFMb5qmzc1EK53Cn/rAQS7ClsaZxZiA7X01sjc2jx4qH3ABU0aeEzHp7Uso
	 P+EOjfbuRuKDFYsJ7eDkxMGC7feYNcSkIk3K2eaVegP9+ZuC3OkYi4eG69YLi6a6mY
	 qEdBD+97f0iT/TlBD8Q6swbgPCSMPrUNnWzaCaHhqW7q3Fh7p2F8oF2K5bu4Iu/oIG
	 G61p1rquCLtN14Vryi861Zy+gqh6SCMwWcJuMMInIHz0CC4XNB3U+aue5JtjvbVLSp
	 itkvXQbGnmPLud2VfmVMGLK01vHZCitjHSFMOV7V0xXWHEoa22nvyZM/uqh1S6sQ9y
	 u69QslH2mPBbQ==
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v6.8-rc5
Date: Wed, 28 Feb 2024 18:02:58 +0000
Message-Id: <20240228180309.1C6DAC43390@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The following changes since commit 269e31aecdd0b70f53a05def79480f15cbcc0fd6:

  spi-mxs: Fix chipselect glitch (2024-02-13 15:48:22 +0000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.8-rc5

for you to fetch changes up to 6415c7fe7cf420fa469095a34d9153f991391116:

  spi: Drop mismerged fix (2024-02-27 12:52:51 +0000)

----------------------------------------------------------------
spi: Fixes for v6.8

There's two things here - the big one is a batch of fixes for the power
management in the Cadence QuadSPI driver which had some serious issues
with runtime PM and there's also a revert of one of the last batch of
fixes for ppc4xx which has a dependency on -next but was in between two
mainline fixes so the -next dependency got missed.

The ppc4xx driver is not currently included in any defconfig and has
dependencies that exclude it from allmodconfigs so none of the CI
systems catch issues with it, hence the need for the earlier fixes
series.  There's some updates to the PowerPC configs to address this.

----------------------------------------------------------------
Mark Brown (1):
      spi: Drop mismerged fix

Théo Lebrun (4):
      spi: cadence-qspi: fix pointer reference in runtime PM hooks
      spi: cadence-qspi: remove system-wide suspend helper calls from runtime PM hooks
      spi: cadence-qspi: put runtime in runtime PM hooks names
      spi: cadence-qspi: add system-wide suspend and resume callbacks

 drivers/spi/spi-cadence-quadspi.c | 33 +++++++++++++++++++++------------
 drivers/spi/spi-ppc4xx.c          | 14 +++++++-------
 2 files changed, 28 insertions(+), 19 deletions(-)

