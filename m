Return-Path: <linux-kernel+bounces-79765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F397486266F
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 18:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 785F2B21D65
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 17:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9314C601;
	Sat, 24 Feb 2024 17:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p8IqT6BL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413BD47F57;
	Sat, 24 Feb 2024 17:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708796547; cv=none; b=khUnOQNpe93V5npe2Ywi8LT13ETDXrZJG7q1zXAk7/WYVM63anT2kYYZGTpSCc7moPRXBCQfzBvlDo3I4FK3dq6rWipE83tI1sBvfKQ6R+/g4cLdwDGAgRZA2advRqAdlPzeYquIWOFfA20RlYQE1k0kE33NOHh4Z2hRjU3+IBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708796547; c=relaxed/simple;
	bh=X84iKnqqvDs4FSzZwltR/vjttwT6+4gDq5uRYJRa4ms=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Viv58+MWA152MBdVTr0BdXBucfHEw5dPWZ0BTD7YakfoMaM0/UBJw//0P6M8YX/MDa5QXoGC6HP732pGCaeWrx2g2oXjXARVN01KKv250c0DKtNOH+T4aGA/h9WlBzLfS4vFIQRtecjXG54ZoCZm8GA5HbHfq8jsMzQEea0Lv8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p8IqT6BL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D4E14C433F1;
	Sat, 24 Feb 2024 17:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708796546;
	bh=X84iKnqqvDs4FSzZwltR/vjttwT6+4gDq5uRYJRa4ms=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=p8IqT6BLWEIOd0D5rqmMDux9too1BdfvBU7WLo3/M6UkkhEkXp5eAHfwYZk3e5Kwn
	 T7B/7D3t828ELksyKXZk2lt/J5qFMo9coZBhvkrpCcjujZFjyPL4VroK7/NpqqWQLH
	 YGBWhZfmOohX3MwKx84PyyoVs6Rk6H38WXcdA73cN2fcf9dFePtMozsKivMAoHxOaH
	 mC7Dq0pigLSJ16glsGsgZqKhJuOAoYXWT6dHmDwutLPC2NuxGPIbIHpgO4UVtiwnNB
	 hx4Q+pqZx90Xsp1HXgxp9rox8DSiNBhzZbcuKosEDmREfhqLK29KRZC6S54hYWLyUX
	 sFHxWlGVMbOUA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0AC8C5478C;
	Sat, 24 Feb 2024 17:42:26 +0000 (UTC)
From: Sam Ravnborg via B4 Relay <devnull+sam.ravnborg.org@kernel.org>
Subject: [PATCH v2 0/7] sparc32: build fixes for all{yes,mod}config builds
Date: Sat, 24 Feb 2024 18:42:21 +0100
Message-Id:
 <20240224-sam-fix-sparc32-all-builds-v2-0-1f186603c5c4@ravnborg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH0q2mUC/42NQQ6CMBBFr0Jm7ZhhCiS68h6GRWkLTIJAptpoC
 He3cgIXf/F+ft7fIAaVEOFabKAhSZRlzsCnAtxo5yGg+MzAxBUxG4z2gb28Ma5WnWG004TdSyY
 fkSxVZHwTys5AFqwa8vKQ39vMo8Tnop/jK5W/9i9tKpGwdg31vnYXrummNs3dosM5B9p937//A
 +N+xwAAAA==
To: "Maciej W. Rozycki" <macro@orcam.me.uk>, sparclinux@vger.kernel.org, 
 Andreas Larsson <andreas@gaisler.com>, Randy Dunlap <rdunlap@infradead.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, 
 linux-parport@lists.infradead.org, "David S. Miller" <davem@davemloft.net>, 
 Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
 Sam Ravnborg <sam@ravnborg.org>, stable@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708796545; l=2881;
 i=sam@ravnborg.org; s=20230107; h=from:subject:message-id;
 bh=X84iKnqqvDs4FSzZwltR/vjttwT6+4gDq5uRYJRa4ms=; =?utf-8?q?b=3DuVUk6SNR2PRI?=
 =?utf-8?q?hhlI7FiC0xyC3ybSXRI7dcnt+LpFDLsVFh7E3Dp83/IH/+KkhGiT3yKpvCsCAEaI?=
 grgWlLGpCRKtOo9ncpF2S37R114cBwqW8wWw68lJvmM+oKHbaQHS
X-Developer-Key: i=sam@ravnborg.org; a=ed25519;
 pk=R0+pqV7BRYOAeOIGkyOrSNke7arx5y3LkEuNi37YEyU=
X-Endpoint-Received: by B4 Relay for sam@ravnborg.org/20230107 with auth_id=22
X-Original-From: Sam Ravnborg <sam@ravnborg.org>
Reply-To: <sam@ravnborg.org>

This is a small set of patches that address build breakage with
allyesconfig / allmodconfig.

This solves some, but not all, build breakage.
The parport fix depends on the previous patch, the rest are independent
fixes.

With v2 there is a extra patch that drops ZONE_DMA support.
It does not fix any build failure, but a nice cleanup.

Cc: Miquel Raynal <miquel.raynal@bootlin.com>
To: Maciej W. Rozycki <macro@orcam.me.uk>
To:  <sparclinux@vger.kernel.org>
Cc:  <linux-parport@lists.infradead.org>
Cc: David S. Miller <davem@davemloft.net>
To: Andreas Larsson <andreas@gaisler.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc:  <linux-kernel@vger.kernel.org>

Changes in v2:
- Added r-b/tested by (thanks to Randy and Maciej)
- Dropped patch for uhci-grlib.c as it is already upstream (Randy)
- Added a few Fixes (Maciej)
- Fixed commit message when dropping GENERIC_ISA_DMA (Maciej)
- Added new patch that drop ZONE_DMA (Maciej)
- Added new patch to fix section mismatch error

In an allmodconfig build I see a lot of:

    modpost: "__udelay" [module] has no CRC!

Similar for a handful of other symbols.
Any hint how to get rid of them would be nice.
I have tried to add the prototype to asm-prototypes.h with no luck.

On top of this the link fails, but I assume this the kernel that grows
too big which is no surprise.

- Link to v1: https://lore.kernel.org/r/20240223-sam-fix-sparc32-all-builds-v1-0-5c60fd5c9250@ravnborg.org

---
Sam Ravnborg (7):
      sparc32: Use generic cmpdi2/ucmpdi2 variants
      sparc32: Fix build with trapbase
      mtd: maps: sun_uflash: Declare uflash_devinit static
      sparc32: Do not select ZONE_DMA
      sparc32: Do not select GENERIC_ISA_DMA
      sparc32: Fix parport build with sparc32
      sparc32: Fix section mismatch in leon_pci_grpci

 arch/sparc/Kconfig                  |   7 +-
 arch/sparc/include/asm/parport.h    | 259 +-----------------------------------
 arch/sparc/include/asm/parport_64.h | 256 +++++++++++++++++++++++++++++++++++
 arch/sparc/kernel/irq_32.c          |   6 +-
 arch/sparc/kernel/kernel.h          |   8 +-
 arch/sparc/kernel/kgdb_32.c         |   4 +-
 arch/sparc/kernel/leon_pci_grpci1.c |   2 +-
 arch/sparc/kernel/leon_pci_grpci2.c |   2 +-
 arch/sparc/kernel/leon_smp.c        |   6 +-
 arch/sparc/kernel/setup_32.c        |   4 +-
 arch/sparc/lib/Makefile             |   4 +-
 arch/sparc/lib/cmpdi2.c             |  28 ----
 arch/sparc/lib/ucmpdi2.c            |  20 ---
 arch/sparc/mm/srmmu.c               |   1 -
 drivers/mtd/maps/sun_uflash.c       |   2 +-
 15 files changed, 284 insertions(+), 325 deletions(-)
---
base-commit: 626db6ee8ee1edac206610db407114aa83b53fd3
change-id: 20240223-sam-fix-sparc32-all-builds-0a0403d6e1b3

Best regards,
-- 
Sam Ravnborg <sam@ravnborg.org>


