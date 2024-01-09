Return-Path: <linux-kernel+bounces-21393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67112828E8A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 21:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83D271C240FB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 20:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3C93D97C;
	Tue,  9 Jan 2024 20:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KFpX4G7K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7012BD0A;
	Tue,  9 Jan 2024 20:35:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34A43C433C7;
	Tue,  9 Jan 2024 20:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704832531;
	bh=WWum26QKMFh6vGvEJyJ4MOL9e+MqfFaHurfUS5t9l5M=;
	h=From:To:Cc:Subject:Date:From;
	b=KFpX4G7KtoXpXwi2h60jBAtMA+jWNdiGvfTfVYgP0xHuKT4FjbZzx53X0KEfztEjC
	 LRaDENxfYF7dvON5pQwNOaWPcdyxP9Y+wdlCEyim9l0N3Bue/9sYd4MlCb01X3pEBA
	 1N9IOFptghlzzInxIXccmzOx0GnN3KzgwC6zysA3so3WoQIilwrrxKY2gcEbtRAVX4
	 5Y/KoE+af5chvd48sKmSazGyer2ZlG5ynsnFbk8zsiFERHrxI6xfJzS+q9SM3CtxVG
	 y3d51BK67U1tvtHplYGsB6dndV26gLNXRr9PHYfMvgT+FqrrSlCcT4H3N5aaCjHWA7
	 APoExHWz+KSZA==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	David Howells <dhowells@redhat.com>,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	keyrings@vger.kernel.org
Subject: [GIT PULL] tpmdd changes for v6.8
Date: Tue,  9 Jan 2024 22:35:14 +0200
Message-Id: <20240109203514.1511503-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

  Merge tag 'cgroup-for-6.8' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup (2024-01-08 20:04:02 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-v6.8

for you to fetch changes up to 2b6fad7a900d2a378b475e5c196c146fb71856be:

  tpm: cr50: fix kernel-doc warning and spelling (2024-01-09 11:12:27 +0200)

----------------------------------------------------------------
Hi,

Just a couple fixes and no new features. I've been reviewing and testing
TPM patches for encrypted and integrity protected commuinications [1] but
they did not made yet to this release.

This was also first release I tested with my still heavily in-development
test suite for linux integrity [2]. I'm refining this at the moment
to run keyutils test suite, which could be potentially also run by a Gitlab
runner for keyutis repository.

[1] https://lore.kernel.org/linux-integrity/20240102170408.21969-1-James.Bottomley@HansenPartnership.com/T/#t
[2] https://github.com/jarkkojs/tpmdd-buildroot-external

BR, Jarkkaso

----------------------------------------------------------------
Randy Dunlap (1):
      tpm: cr50: fix kernel-doc warning and spelling

Rob Herring (1):
      tpm: nuvoton: Use i2c_get_match_data()

 drivers/char/tpm/tpm_i2c_nuvoton.c  | 15 ++++-----------
 drivers/char/tpm/tpm_tis_i2c_cr50.c |  3 +--
 2 files changed, 5 insertions(+), 13 deletions(-)

