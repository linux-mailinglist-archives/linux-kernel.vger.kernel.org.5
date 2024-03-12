Return-Path: <linux-kernel+bounces-99699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A1F878BF1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 01:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14F131C206A5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 00:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D7C77E2;
	Tue, 12 Mar 2024 00:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQhc/pgq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4A9365;
	Tue, 12 Mar 2024 00:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710203349; cv=none; b=bIAKVeqSjo0V5n+ZskArIwKx8qK+lFIdVgRU3+BOAj0iWN9L7OkQrLEXtnNs2Q+86wIyo0wL4BeBzpf+UydRKbSHBImbr7lxoe7f288tXToE/JyAIDMfb7hxDEsbKrunVIj1n+XipL5kjf5jQB3UclXRIJoHih93swEnXFdrRZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710203349; c=relaxed/simple;
	bh=QqEqfyzSg7vN+OQTmwyFR+1vKvfepw0L7qwqCzMM8fU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l9XuSWMIjCqYSXriSTaJ3GGWRZw4zJcPePM9SZ8l6aUEyDXSuolJidjycigBX2l0eFReU4s84n+XXqH7ZYYKVdJXx6So2zX/pjwJImOMrwLMCxuHW75XdMxKxAWxSTpEgjOUyjIPCzP7JI3r5iOVd3rAeG+dbGKGMIvxzpe4EtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQhc/pgq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE684C433F1;
	Tue, 12 Mar 2024 00:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710203349;
	bh=QqEqfyzSg7vN+OQTmwyFR+1vKvfepw0L7qwqCzMM8fU=;
	h=From:To:Cc:Subject:Date:From;
	b=nQhc/pgqvfzW/fVaPBv2+XkG3S4+isF6GMu91gCdCoCJdoINxNlq2hYsXBhnhE69z
	 dWjYVqZc7OIb/3B5USgbpB1rItyG6FZJCIGH4pAv/swL63oYcZvNsq7lHV6IQrmVlN
	 YMij/ViGfUwjmPCltgnMGGoPotYBkM5X2amDg8c/vNVtsotsArd5hhDX8a1aWGNQMp
	 hHNvxlOxhKzisildTxm9ixEd3ZatNQn5LjP0uFpIzPmsnYel4Z2abWIJgN0ML72Wq5
	 xlLBDsYZBsiHT/hVdj+wOP1wJDRNo+MhTBvryovh+64TBGiAh+k4vJHM30eDLcV6tm
	 D6TEjaRX0kHqQ==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	David Howells <dhowells@redhat.com>,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	keyrings@vger.kernel.org
Subject: [GIT PULL] tpmdd changes for v6.9
Date: Tue, 12 Mar 2024 02:29:04 +0200
Message-Id: <20240312002904.1929283-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

  Merge tag 'cgroup-for-6.9' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup (2024-03-11 13:13:22 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-v6.9-rc1

for you to fetch changes up to 6fa6b796e037a15b1c208b1158f801f9adcb1f2b:

  tpm: tis_i2c: Add compatible string nuvoton,npct75x (2024-03-12 00:26:06 +0200)

----------------------------------------------------------------
Hi,

This is my pull request for Linux v6.9. Contains small scope bug fixes
and device tree updates. No new features.

BR, Jarkko

----------------------------------------------------------------
Lino Sanfilippo (1):
      tpm,tpm_tis: Avoid warning splat at shutdown

Lukas Wunner (4):
      dt-bindings: tpm: Add compatible string atmel,attpm20p
      tpm_tis_spi: Add compatible string atmel,attpm20p
      tpm_tis: Add compatible string atmel,at97sc3204
      tpm: tis_i2c: Add compatible string nuvoton,npct75x

Randy Dunlap (1):
      tpm/tpm_ftpm_tee: fix all kernel-doc warnings

 Documentation/devicetree/bindings/tpm/tcg,tpm_tis-spi.yaml | 1 +
 drivers/char/tpm/tpm_ftpm_tee.c                            | 6 +++---
 drivers/char/tpm/tpm_tis.c                                 | 1 +
 drivers/char/tpm/tpm_tis_core.c                            | 3 +--
 drivers/char/tpm/tpm_tis_i2c.c                             | 2 ++
 drivers/char/tpm/tpm_tis_spi_main.c                        | 1 +
 6 files changed, 9 insertions(+), 5 deletions(-)

