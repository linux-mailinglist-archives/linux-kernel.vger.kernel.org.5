Return-Path: <linux-kernel+bounces-18853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A16C826404
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 13:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 297351F21985
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 12:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F3812E76;
	Sun,  7 Jan 2024 12:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="RevGInoA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5251012E4A
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jan 2024 12:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 921D240E01B2;
	Sun,  7 Jan 2024 12:15:40 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id LFjwTw7XEB3A; Sun,  7 Jan 2024 12:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1704629738; bh=UK9PlhwRB1r9QbRSHp+R0+WnUPfSxgkpm2vt+Z/Ek3U=;
	h=Date:From:To:Cc:Subject:From;
	b=RevGInoAOcJMq8e11uD19FCsJ5+qgO8D0OXkmeYg0A6VI65X6+GHXBsAqqjFA3CP5
	 etm1NbO03Hz5yxdgJB0Ub+TxaPUIioPGlWJaVJQp4k0sgANaP2zjA+VFoqcQ6MOXuO
	 6HL5A+MErd+Oo4DXBd6fDaeSbjqIlyXIhE49mx2dNcczozaUH0XZmzYKBTPNL5/qkc
	 FqAO9+DZdjIO86Cioktse7JbD7zniB9xzkyGFtkr54bm1a7iUX4xiiS+F2+QlcMmyE
	 yjJVrkL/Xt6HwmHddbQ88GjBpva5XAgD2bOZuHEe79tjVjJzrcUOL5IttZL2xIFYS3
	 G2P5oGSdrfB+68pdUuAVKDA+T3C+mfNBWBa1twHPbHDGUxoxs27UHbK38NnzJpj6Xp
	 OcqktCUSccsZXqssp9ysXQU0x+XowzTRSIw8zNH/KzsLUefaQUbY8Od/i581jZWtN9
	 yoV6gnX/onXnKyrailsykWN3iO1LSBnY2XcbZmpEsCp7p7n8pvU1bMp7TnS75dzJjr
	 wVU/EYm7JwL129CBZgqRAYHL/IgOMcRJ5mnBkhs8Kk8Y7pV7hV51/uI2e73dIMPx9l
	 0TBN3AKkjUykz6Y0cec0C7Ch5eTiCv002uUwzoFrK5Yx36oah3FrPp42dJZ59FgL87
	 rVPfs5+2OPj98F/p6tpn5vw4=
Received: from zn.tnic (pd9530f8c.dip0.t-ipconnect.de [217.83.15.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 578D440E00C5;
	Sun,  7 Jan 2024 12:15:35 +0000 (UTC)
Date: Sun, 7 Jan 2024 13:15:28 +0100
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/cpu for v6.8
Message-ID: <20240107121528.GAZZqV4GF086iQw1zw@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull the pile of x86/cpu changes for v6.8.

Thx.

---

The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cpu_for_v6.8

for you to fetch changes up to 232afb557835d6f6859c73bf610bad308c96b131:

  x86/CPU/AMD: Add X86_FEATURE_ZEN1 (2023-12-12 11:17:37 +0100)

----------------------------------------------------------------
- Add synthetic X86_FEATURE flags for the different AMD Zen generations
  and use them everywhere instead of ad-hoc family/model checks. Drop an
  ancient AMD errata checking facility as a result

- Fix a fragile initcall ordering in intel_epb

- Do not issue the MFENCE+LFENCE barrier for the TSC deadline and X2APIC
  MSRs on AMD as it is not needed there

----------------------------------------------------------------
Borislav Petkov (AMD) (15):
      x86/barrier: Do not serialize MSR accesses on AMD
      x86/CPU/AMD: Add ZenX generations flags
      x86/CPU/AMD: Carve out the erratum 1386 fix
      x86/CPU/AMD: Move the Zen3 BTC_NO detection to the Zen3 init function
      x86/CPU/AMD: Move erratum 1076 fix into the Zen1 init function
      x86/CPU/AMD: Call the spectral chicken in the Zen2 init function
      x86/CPU/AMD: Rename init_amd_zn() to init_amd_zen_common()
      x86/CPU/AMD: Move Zenbleed check to the Zen2 init function
      x86/CPU/AMD: Move the DIV0 bug detection to the Zen1 init function
      x86/CPU/AMD: Get rid of amd_erratum_1054[]
      x86/CPU/AMD: Get rid of amd_erratum_383[]
      x86/CPU/AMD: Get rid of amd_erratum_400[]
      x86/CPU/AMD: Get rid of amd_erratum_1485[]
      x86/CPU/AMD: Drop now unused CPU erratum checking function
      x86/CPU/AMD: Add X86_FEATURE_ZEN1

James Morse (1):
      x86/cpu/intel_epb: Don't rely on link order

 arch/x86/include/asm/barrier.h           |  18 ---
 arch/x86/include/asm/cpufeatures.h       |   8 +-
 arch/x86/include/asm/processor.h         |  18 +++
 arch/x86/kernel/cpu/amd.c                | 268 +++++++++++++++----------------
 arch/x86/kernel/cpu/common.c             |   7 +
 arch/x86/kernel/cpu/hygon.c              |   3 +
 arch/x86/kernel/cpu/intel_epb.c          |   2 +-
 tools/arch/x86/include/asm/cpufeatures.h |   2 +-
 8 files changed, 170 insertions(+), 156 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

