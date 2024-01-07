Return-Path: <linux-kernel+bounces-18862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0942782641A
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 13:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54C96282336
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 12:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F726134AD;
	Sun,  7 Jan 2024 12:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="YHnRe3YC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23681134A0
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jan 2024 12:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 09F2340E01F9;
	Sun,  7 Jan 2024 12:57:04 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id cNWX0paTR2NN; Sun,  7 Jan 2024 12:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1704632222; bh=wY32Z7/3lgoSyXYC+87XpGQX8RmNGRz5d5SrIr3DRyQ=;
	h=Date:From:To:Cc:Subject:From;
	b=YHnRe3YCbfIZ+3DjKAZlSJ+4/9zevCG3t3dhxiVHLZ/PviOK9xtrTrc/FTi6/rz9j
	 7/EZyvmYLPDhwatCQXTm9dXITg5R9p6YqUnB2+F+hdgL12CIx2JWIBRVdlwfIIMbQa
	 dtlwh1R904c11MHiGDevdZS0lsTOubVOzaobwIcg4J62yKJoT1buR05LO1/bIE0G5N
	 ZJHr884dwbd9i93zY7xF7vtjE6pjqCwYuTpP7IgLOQ+a+txAejkqVDNzipSuhXxpCB
	 BAj9WDBRqM+VShBW7yeMtl9Hv4sUuiKtvGbd4MYXOzFUk8jt1qT8TaOXI/x0ioKmn5
	 H1At2U23v2D+Ddf3IwCRQf3OVsOQDpJPniLJ+zZwCYl88jIMFyTQaJLOB6kjIXMqin
	 DSBl1cpA7tIpdSIpxGWUoeMJh1o2TdbwuZ2G87C8BsiAiIxcj4iFzWB5FAQJt8/mLw
	 9eYmyZ3B0vFgv1ZLtSqCw/jEON9CtNlBAm6tO8UaVNYeOPxXRhAqTTQkMpcQHjXlLV
	 uI3+WQceG0iyLnEjvfeBHkGlq0msNFp6WbDcJIOubdNaKHncVcrbQDmTWUR9EfTh/c
	 YDaplh4yUKxSkTHvswOMfq/DEjMa35hnVevoSJKNjU1MDVn5RzwD27ASY37SsjOxnK
	 86j6z4uBhcGJPUKROYMCS8tE=
Received: from zn.tnic (pd9530f8c.dip0.t-ipconnect.de [217.83.15.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E73E440E016C;
	Sun,  7 Jan 2024 12:56:58 +0000 (UTC)
Date: Sun, 7 Jan 2024 13:56:53 +0100
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] ras/core for v6.8
Message-ID: <20240107125653.GAZZqflcax9rVtvbcj@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull a bunch of RAS changes for v6.8.

Thx.

---

The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/ras_core_for_v6.8

for you to fetch changes up to 1f68ce2a027250aeeb1756391110cdc4dc97c797:

  x86/mce: Handle Intel threshold interrupt storms (2023-12-15 14:53:42 +0100)

----------------------------------------------------------------
- Convert the hw error storm handling into a finer-grained, per-bank
  solution which allows for more timely detection and reporting of
  errors

- Start a documentation section which will hold down relevant
  RAS features description and how they should be used

- Add new AMD error bank types

- Slim down and remove error type descriptions from the kernel side of
  error decoding to rasdaemon which can be used from now on to decode
  hw errors on AMD

- Mark pages containing uncorrectable errors as poison so that kdump can
  avoid them and thus not cause another panic

- The usual cleanups and fixlets

----------------------------------------------------------------
Borislav Petkov (AMD) (1):
      Documentation: Begin a RAS section

Muralidhara M K (2):
      EDAC/mce_amd: Remove SMCA Extended Error code descriptions
      x86/MCE/AMD: Add new MA_LLC, USR_DP, and USR_CP bank types

Nikolay Borisov (1):
      x86/mce: Remove redundant check from mce_device_create()

Tony Luck (3):
      x86/mce: Remove old CMCI storm mitigation code
      x86/mce: Add per-bank CMCI storm mitigation
      x86/mce: Handle Intel threshold interrupt storms

Yazen Ghannam (2):
      x86/mce/inject: Clear test status value
      x86/mce/amd, EDAC/mce_amd: Move long names to decoder module

Zhiquan Li (1):
      x86/mce: Mark fatal MCE's page as poison to avoid panic in the kdump kernel

 Documentation/RAS/ras.rst           |  26 ++
 Documentation/index.rst             |   1 +
 arch/x86/include/asm/mce.h          |   4 +-
 arch/x86/kernel/cpu/mce/amd.c       |  80 +++---
 arch/x86/kernel/cpu/mce/core.c      |  72 +++--
 arch/x86/kernel/cpu/mce/inject.c    |   1 +
 arch/x86/kernel/cpu/mce/intel.c     | 304 +++++++++------------
 arch/x86/kernel/cpu/mce/internal.h  |  66 ++++-
 arch/x86/kernel/cpu/mce/threshold.c | 115 ++++++++
 drivers/edac/mce_amd.c              | 526 +++---------------------------------
 10 files changed, 457 insertions(+), 738 deletions(-)
 create mode 100644 Documentation/RAS/ras.rst


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

