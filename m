Return-Path: <linux-kernel+bounces-19005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0285826660
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 23:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 791F2281B07
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 22:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DAC3125CE;
	Sun,  7 Jan 2024 22:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gPESZYZ1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DAD13AEC
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jan 2024 22:37:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 885ECC433C8;
	Sun,  7 Jan 2024 22:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704667068;
	bh=BQuiCt+Va7wJemRh6yNjbSCD1JfT2Ywei0LK1/5bk+A=;
	h=From:To:Cc:Subject:Date:From;
	b=gPESZYZ1EuebKGul1n2G1AePeBmnjr61fJ7lTSHmHTd0gbDjRQOLwVNscpZxDCOAr
	 zHmuM5wztEu1mbK4iYiW0qzXJUhFXyw2p2M90KEEnu1W0QlMS++DcxERY5pPc/UVhg
	 eWJatur7lpNZBsXGVZ+jSWRGSB+L/NtVPevJRla0SBfQP1FB9TZ8507/I93J3UdVie
	 9O3y4qCM+iRejHTBx+RuYuIYIbGwv8IlTSZaMQnKMRusx3tVDR9cZEBPWj3zb4dN5z
	 wD4daBen4mnclunAtf95EP2dWjYHGdQexJEehRSZhYbkGWv+tb7uYLSrh4NmEMbK7Y
	 WvLSr9x2GRyAg==
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regmap updates for v6.8
Date: Sun, 07 Jan 2024 22:37:36 +0000
Message-Id: <20240107223748.885ECC433C8@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v6.8

for you to fetch changes up to 3b201c9af7c0cad2e8311d96c0c1b399606c70fa:

  regmap: fix kcalloc() arguments order (2023-12-20 18:11:38 +0000)

----------------------------------------------------------------
regmap: Updates for v6.8

This was a very quiet release for regmap, we added kunit test coverage
for a noinc fix that was merged during v6.7 and a couple of other
trivial cleanups.

----------------------------------------------------------------
Ben Wolsieffer (2):
      regmap: ram: support noinc semantics
      regmap: kunit: add noinc write test

Dmitry Antipov (1):
      regmap: fix kcalloc() arguments order

Hugo Villeneuve (1):
      regmap: fix regmap_noinc_write() description

 drivers/base/regmap/internal.h       |  1 +
 drivers/base/regmap/regmap-kunit.c   | 60 ++++++++++++++++++++++++++++++++++++
 drivers/base/regmap/regmap-ram.c     |  4 +--
 drivers/base/regmap/regmap-raw-ram.c | 31 +++++++++++++------
 drivers/base/regmap/regmap.c         |  2 +-
 5 files changed, 85 insertions(+), 13 deletions(-)

