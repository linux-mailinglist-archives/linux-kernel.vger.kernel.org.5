Return-Path: <linux-kernel+bounces-18999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F63E82664C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 23:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEC3628193D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 22:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752D511C92;
	Sun,  7 Jan 2024 22:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="T+bQRlu8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA65B11C80
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jan 2024 22:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 78CB340E016C;
	Sun,  7 Jan 2024 22:08:38 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id nR2reh-y4pd7; Sun,  7 Jan 2024 22:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1704665312; bh=yrKA2wiVqmAgfrUvkvMXLpeRfcN16MHaApnHyJsIuEA=;
	h=Date:From:To:Cc:Subject:From;
	b=T+bQRlu8BZYGGoR2AFJbtX98WpvtzfA7iSoTyRosuKitBS9TiNvNMr8pi4LcAXXgg
	 x/tQk2lS0u+Vd+yBsoLndZzb4fVfHcoA0i1hLNAVnpY8ZR8XMoTFzDG9W04Qpz9clw
	 cb1GLpPmNAaiWH3Ee04B2SzRiJPjOx/onmUUw+Esnvnr8j6SNsbigyHwsCLrcdTn/E
	 VCSgRzF2FqT7CJ7IImJIH9JIVBsb8cCGw7HqvSmj7S+bjF68HiXCu0Xk/uLE0C2kuI
	 WF4fB8TLGmfdHBuhmroLaQSJz6vy/ISe44iDFmorUAMFk36+hZTgZSmLccI9nZ7XWL
	 m7rCj0OzBDnFdam/zvnz8VSXJSf50eE2LAjKKDshwCPMwdFnhFmBxaxUs+YLeTi2wu
	 MqSeSdh2JTZUulhBDWpoBTpsrNzxulbQ4NLuV7CMpGsrmRAs5P97wc16XWBm3wrcox
	 c9sBASAAVfPjkzy4vjmJRHv/G8fl8hBrcAS5f2xPdcb5VngEtiv4/1GK28ryd543QV
	 b/RFJugOBCCKtze0Xocfw5dX95pe6TPRxjAgvTTzST5wxPdLnYZPGdPdS5DsQ/CWyr
	 +8XXArPodCVKgPiHLH+GJyXS9OFMEyJ+Fj19vdgaGij8c8KAZqD87QR1r7U4WHp1di
	 4UWiuD2X9r/neYQjEqmN5nFg=
Received: from zn.tnic (pd9530f8c.dip0.t-ipconnect.de [217.83.15.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 441B140E00C5;
	Sun,  7 Jan 2024 22:08:29 +0000 (UTC)
Date: Sun, 7 Jan 2024 23:08:23 +0100
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/paravirt for v6.8
Message-ID: <20240107220823.GAZZsg18/8q1JNRksh@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull the x86/paravirt pile of changes for v6.8.

Thx.

---

The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_paravirt_for_v6.8

for you to fetch changes up to 7991ed43587d1106315208cc289c851d6915d4a3:

  x86/alternative: Correct feature bit debug output (2023-12-30 12:25:55 +0100)

----------------------------------------------------------------
- Replace the paravirt patching functionality using the alternatives
  infrastructure and remove the former

- Misc other improvements

----------------------------------------------------------------
Borislav Petkov (AMD) (1):
      x86/alternative: Correct feature bit debug output

Hou Wenlong (2):
      x86/paravirt: Use relative reference for the original instruction offset
      x86/paravirt: Make the struct paravirt_patch_site packed

Juergen Gross (5):
      x86/paravirt: Introduce ALT_NOT_XEN
      x86/paravirt: Move some functions and defines to alternative.c
      x86/alternative: Add indirect call patching
      x86/paravirt: Switch mixed paravirt/alternative calls to alternatives
      x86/paravirt: Remove no longer needed paravirt patching code

 arch/x86/include/asm/alternative.h        |  30 ++++++-
 arch/x86/include/asm/paravirt.h           |  79 +++++-------------
 arch/x86/include/asm/paravirt_types.h     |  87 ++++++-------------
 arch/x86/include/asm/qspinlock_paravirt.h |   4 +-
 arch/x86/include/asm/text-patching.h      |  12 ---
 arch/x86/kernel/alternative.c             | 134 +++++++++++++++---------------
 arch/x86/kernel/callthunks.c              |  17 ++--
 arch/x86/kernel/kvm.c                     |   4 +-
 arch/x86/kernel/module.c                  |  20 ++---
 arch/x86/kernel/paravirt.c                |  54 ++----------
 arch/x86/kernel/vmlinux.lds.S             |  13 ---
 arch/x86/tools/relocs.c                   |   2 +-
 arch/x86/xen/irq.c                        |   2 +-
 13 files changed, 169 insertions(+), 289 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

