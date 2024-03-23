Return-Path: <linux-kernel+bounces-112150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11BB0887646
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 01:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 229071C229B4
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 00:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A349BA48;
	Sat, 23 Mar 2024 00:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="dNi6vZJw"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBA27F
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 00:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711155298; cv=none; b=qrFkMYCyS/UzD9nQVpO/7t053ocOhkwmAimCK/pOfjTBWNjto2ZUtyzulnryeP48XIrGpqRfQU+u46uLrLYepOyGxokc6UlyNQTnW8lfltW2Ldj4CbZy5VqrPlQ3lKX/JVO8+mjck7r74fTlhuohGTsCaF5q3Og+V7DZoc6uetA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711155298; c=relaxed/simple;
	bh=by+mnTSa2t2z4uApPvfsnyrCQ7PMfRU7O2P6IqMovI0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nVIwHURgpeSJDSgGBPE7kYXfw/3t/+nvZm2+zGr3wlMe/maP4msiR0uDXQiSuNBfx4B2Ssbrtn9vpRqVgtwkIcf1Ku505Tlr2j3ludNyQcXHopE87Ze1VHzBbNHLr3IofocByPZ+kHeM6dy83csomyTlMo6k/GPsezdmneOFyXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=dNi6vZJw; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1711155292;
	bh=Q1ozhTLC0i5nJma6jn4h+gT4TZHIFCymNO4pKD/VVU8=;
	h=From:To:Cc:Subject:Date:From;
	b=dNi6vZJwyDbkp/Yq+28o/8e3ySxTXuCaIAF23CBOjAuLdpYRgLxvsLpBzaDkWP4Rs
	 hp8fOw/pYwhdbLVHk+8fJqd/SyiDurShcrLWhX6OSzhYATgoTJJdG0xeSMw+007lth
	 k1MQysQalKjGNe8BInC5uh5//nat4zvp2ewODhULn/TJfuy3Kc9O0l8IoE6XXGsfjr
	 VnKLmVqLxuzKG6hgjlZG3x0DQ1mLGvMclEdBDMJXODu0QgWRQ1dApeyxtQ4HTp/amS
	 Y7qTl5bS5b3KNJG5jDiF2ovweQi6EihbheQUCRtaNL23qQM6ydiVZjPK55mEiXP+D3
	 aMpKHOBaVHwjg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4V1ghX0QzCz4wx5;
	Sat, 23 Mar 2024 11:54:51 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: bhe@redhat.com, christophe.leroy@csgroup.eu, hbathini@linux.ibm.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 kexec@lists.infradead.org
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-6.9-2 tag
Date: Sat, 23 Mar 2024 11:54:50 +1100
Message-ID: <87zfupix7p.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Linus,

Please pull some more powerpc updates for 6.9. These were posted before the
merge window but had complicated dependencies and/or conflicts with other
content that has gone into 6.9.

cheers

The following changes since commit 66a27abac311a30edbbb65fe8c41ff1b13876faa:

  Merge tag 'powerpc-6.9-1' of git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux (2024-03-15 17:53:48 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.9-2

for you to fetch changes up to 5c4233cc0920cc90787aafe950b90f6c57a35b88:

  powerpc/kdump: Split KEXEC_CORE and CRASH_DUMP dependency (2024-03-17 13:34:00 +1100)

- ------------------------------------------------------------------
powerpc updates for 6.9 #2

 - Handle errors in mark_rodata_ro() and mark_initmem_nx().

 - Make struct crash_mem available without CONFIG_CRASH_DUMP.

Thanks to: Christophe Leroy, Hari Bathini.

- ------------------------------------------------------------------
Christophe Leroy (1):
      powerpc: Handle error in mark_rodata_ro() and mark_initmem_nx()

Hari Bathini (3):
      kexec/kdump: make struct crash_mem available without CONFIG_CRASH_DUMP
      powerpc/kexec: split CONFIG_KEXEC_FILE and CONFIG_CRASH_DUMP
      powerpc/kdump: Split KEXEC_CORE and CRASH_DUMP dependency


 arch/powerpc/Kconfig                 |   9 +-
 arch/powerpc/include/asm/kexec.h     |  98 +++----
 arch/powerpc/kernel/prom.c           |   2 +-
 arch/powerpc/kernel/setup-common.c   |   2 +-
 arch/powerpc/kernel/smp.c            |   4 +-
 arch/powerpc/kexec/Makefile          |   3 +-
 arch/powerpc/kexec/core.c            |   4 +
 arch/powerpc/kexec/elf_64.c          |   4 +-
 arch/powerpc/kexec/file_load_64.c    | 269 ++++++++++----------
 arch/powerpc/mm/book3s32/mmu.c       |   7 +-
 arch/powerpc/mm/mmu_decl.h           |   8 +-
 arch/powerpc/mm/nohash/8xx.c         |  33 ++-
 arch/powerpc/mm/nohash/e500.c        |  10 +-
 arch/powerpc/mm/pgtable_32.c         |  38 ++-
 arch/powerpc/platforms/powernv/smp.c |   2 +-
 include/linux/crash_core.h           |  12 +-
 16 files changed, 274 insertions(+), 231 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJFGtCPCthwEv2Y/bUevqPMjhpYAFAmX+Jw4ACgkQUevqPMjh
pYA6WA/+PVlWRRhMWDZ0BEMFKtVMwUlGJWSZGNGqX/5ZV40lcTIsuIruw8C6VY11
Hq1J+CafM3H7LnqzYwruAYhpBYwb1Oje6IK208XiKH+eUmCzzk+hLfjGdbNbkTOx
6xBqoV3Hjj+p4H6QRXYkZQihQDHy9IfuBGNtoaTaiVuqg9NOT9PLnVNYaI11uLBP
qRS08hkORyJEOO/QRjoVXyXdP7pOwl1EbuYYg805BZ9NFlp7j105yT8XjKQ1X5w+
yF4b2eSV78/Z55dpnBM1GqJqkOSaQjq42PKS+JNSBRpgVDZiLzTdVgWBHY1Q2zho
H5XH9RHvT789vtGsXxhYqvSOSMsM+LgdZo82ZQuqHDA5djmwoMOVXcb/NkyVZ0o3
E+glLdWe6X+0B8Fhx2PH4R5j5j1r3/B2Ighf9Qz60rXNCnbUfT8ZJefyUZg6pHMg
Y/YwdftiqBRnVsK1VSvMrIW3/Sk47QHlM2d7B11R9sVw85zlVwg4FHFXlGtoVpFS
cWZityzVY10wKcblhHYt0/X0n2eeMhjyZuq9lvgls2zypr1qxJ+x/URVVM4hzbNH
P+1qvVUp9mHfSmUGqC5OWv/365BhPQy2t7vkK1NYmmfee2r2umHEY9zphu/yysUg
OQvE+v0F7fETuYg/QTWLlsusEyU0uBCoJOxeB2M6KacrNZfE64A=
=SfuI
-----END PGP SIGNATURE-----

