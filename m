Return-Path: <linux-kernel+bounces-152460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 658B08ABECE
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 10:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E2A4B20B65
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 08:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306C5DDD4;
	Sun, 21 Apr 2024 08:47:35 +0000 (UTC)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F62133D5
	for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 08:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713689254; cv=none; b=bIRFxtBSPO1K2U2wWROkTPMvmgA6Sz2c01STOIfQBF/Wflrcph91JlzmXCzsrqF9gm1F4aESQ09pAUuvZ2Dne1ZzirabF9WcTzq9fWFG37XqbNLMK6KI63O+Tesw9HM4V3BOaYhEOdqUZiuFceINE9O7obPrbynKtHLxgqzBXHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713689254; c=relaxed/simple;
	bh=KFf5YGAYYd6QVE91AjOLkfUno3RVYNkU9vqnyq78ghU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mDNLWQLdCWGfm3IRcfoYzvyGuQrf0w33U0ykCO4O/Ok6lfa/S+H/GbKNQ/tbX/5rgQwSbH1oN/9pTcpZAR0aI2porpvrBgzGsFFPxVEdoBqdyC+ntQj+pDDzziMjJ/O3ezgk7TcYMW/UzIUl9CLNXnXiSjPwXv2tGl6WR0lQesE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 009C240E016C;
	Sun, 21 Apr 2024 08:47:30 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 5kY_lu6u7Dug; Sun, 21 Apr 2024 08:47:27 +0000 (UTC)
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CCA9940E00B2;
	Sun, 21 Apr 2024 08:47:23 +0000 (UTC)
Date: Sun, 21 Apr 2024 10:47:22 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/urgent for v6.9-rc5
Message-ID: <20240421084149.GAZiTRTSIBCq70LBEN@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull a bunch of x86/urgent fixes for v6.9-rc5.

Thx.

---

The following changes since commit 7211274fe0ee352332255e41ab5e628b86e83994:

  x86/cpu/amd: Move TOPOEXT enablement into the topology parser (2024-04-12 12:05:54 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_urgent_for_v6.9_rc5

for you to fetch changes up to 9543f6e26634537997b6e909c20911b7bf4876de:

  x86/cpufeatures: Fix dependencies for GFNI, VAES, and VPCLMULQDQ (2024-04-18 17:27:52 +0200)

----------------------------------------------------------------
- Fix CPU feature dependencies of GFNI, VAES, and VPCLMULQDQ

- Print the correct error code when FRED reports a bad event type

- Add a FRED-specific INT80 handler without the special dances that need
  to happen in the current one

- Enable the using-the-default-return-thunk-but-you-should-not warning
  only on configs which actually enable those special return thunks

- Check the proper feature flags when selecting BHI retpoline mitigation

----------------------------------------------------------------
Borislav Petkov (AMD) (1):
      x86/retpolines: Enable the default thunk warning only on relevant configs

Eric Biggers (1):
      x86/cpufeatures: Fix dependencies for GFNI, VAES, and VPCLMULQDQ

Hou Wenlong (1):
      x86/fred: Fix incorrect error code printout in fred_bad_type()

Josh Poimboeuf (1):
      x86/bugs: Fix BHI retpoline check

Xin Li (Intel) (1):
      x86/fred: Fix INT80 emulation for FRED

 arch/x86/entry/common.c          | 65 ++++++++++++++++++++++++++++++++++++++++
 arch/x86/entry/entry_fred.c      | 10 +++----
 arch/x86/kernel/cpu/bugs.c       | 11 ++++---
 arch/x86/kernel/cpu/cpuid-deps.c |  6 ++--
 arch/x86/lib/retpoline.S         |  7 +++++
 5 files changed, 87 insertions(+), 12 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

