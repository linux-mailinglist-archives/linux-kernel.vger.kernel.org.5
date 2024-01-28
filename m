Return-Path: <linux-kernel+bounces-41582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D3283F4E8
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 11:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBED7283451
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 10:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E0E1EB36;
	Sun, 28 Jan 2024 10:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="en7EVd3y"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2034D1DFF0
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 10:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706436434; cv=none; b=DB+F9AJemO8GU/MYDLZs7bcJRJM8hD8Beo2m3nsG/Qs7tyu1YMy/e34Xj890SsLIiq8+ZsgBY3xUiqzvptGr9S2aD+ny+o8X/TMWQt3zEuRko91d1Br62aFwQIosDImqtaPwR7HAF+MU/2WQ6Sp7TMU16oU/LzwbsgSsUy9jX9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706436434; c=relaxed/simple;
	bh=bwa27LPghA/Z+iovmHgsGsmYAnt5TQVFVn/A8ynBvi0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kcBQeqTWFM8vG6R3425ahVmKf40Xx4FNeSUELB1zlVhJrPte0tj/mB7FI+FUL6nj7WmACR59iIbzQrGtTndbYETDqW8ggqFAsZm4CgmsOlMWVuR0y6Ta6Yrw0R7KKQTZbGL6Jc8y/ZryzKrSFHOnwsJSj0oBI+AI9XgucqGT8sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=en7EVd3y; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5823940E01A9;
	Sun, 28 Jan 2024 10:07:08 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id vJJpScOhn7WP; Sun, 28 Jan 2024 10:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1706436426; bh=Kyc7Zz/obRuHwnlaWBciafecRh8ISWDpy/VEawheWyQ=;
	h=Date:From:To:Cc:Subject:From;
	b=en7EVd3yy3xau2ZBvK5u2TtjSPHGW33k9SuWSSvysMwuRg3Fcc8M6Cr2rvGfHVwyD
	 7ek0lABCPYY2Zi3MlxikN/WjZFR5pNUzpNoVOgROefijW8ntkUUey4hSPEUrR0QeJj
	 yF9M3prEa5TWy9/K9VWNzRV2gT9uJHAZV+ehtG8kgi2WVj5BwBM6YLn9U3LS9xumhg
	 cbRxwG34ygR24+5z57JjIdPOqDd1BlRbS0H+LdmbjiOupoEUuyI967KCCKXXAmJUWx
	 g40wsBicBSnGjl+5i9/gT2Q34axeaWflWL3irgY0LCC6qwcS1YMuMq1GNsSeOST52B
	 a0XXUanvQeHirWzEH6s6pzNd1ur+yiV4+8YCNssc5gtnBcKKWWtTVvnyPxVA3f1+UO
	 a+BA/zMIPaz3Be78t96XVVdnGNb7lRMAshQegvUdpCg7y402icNd4QfkSdyXlU4Voj
	 +bEmOu5ivgx4Xj5CIMAeuQzEljtyqzvrnPX26kMTf+TOBKyY26EsWC9ApZ9GkQvCBy
	 YakkdQ5NNvFdOd0A8YSygbB9gqkRRJFgP+bdHBX+KdkfE/kENZlIcSEIG1D6eipRPY
	 mu6qOobgubbcvuVcMwSlhxEzcwBkr98SFmPUPX/4D4WJs/urrxkm90HXh8vOR8AE5T
	 DefWUSDyDBcJuFShEZgcgbnQ=
Received: from zn.tnic (pd953033e.dip0.t-ipconnect.de [217.83.3.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2612C40E0196;
	Sun, 28 Jan 2024 10:07:03 +0000 (UTC)
Date: Sun, 28 Jan 2024 11:06:57 +0100
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/urgent for v6.8-rc2
Message-ID: <20240128100657.GAZbYnQVcyLF9Vm5KR@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull a couple of urgent x86 fixes for v6.8-rc2.

Thx.

---

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v6.8_rc2

for you to fetch changes up to b9328fd636bd50da89e792e135b234ba8e6fe59f:

  x86/CPU/AMD: Add more models to X86_FEATURE_ZEN5 (2024-01-25 12:26:21 +0100)

----------------------------------------------------------------
- Make sure 32-bit syscall registers are properly sign-extended

- Add detection for AMD's Zen5 generation CPUs and Intel's Clearwater
  Forest CPU model number

- Make a stub function export non-GPL because it is part of the
  paravirt alternatives and that can be used by non-GPL code

----------------------------------------------------------------
Borislav Petkov (AMD) (1):
      x86/CPU/AMD: Add X86_FEATURE_ZEN5

Juergen Gross (1):
      x86/paravirt: Make BUG_func() usable by non-GPL modules

Mario Limonciello (1):
      x86/CPU/AMD: Add more models to X86_FEATURE_ZEN5

Richard Palethorpe (1):
      x86/entry/ia32: Ensure s32 is sign extended to s64

Tony Luck (1):
      x86/cpu: Add model number for Intel Clearwater Forest processor

 arch/x86/include/asm/cpufeatures.h     |  4 +---
 arch/x86/include/asm/intel-family.h    |  2 ++
 arch/x86/include/asm/syscall_wrapper.h | 25 +++++++++++++++++++++----
 arch/x86/kernel/alternative.c          |  2 +-
 arch/x86/kernel/cpu/amd.c              | 28 ++++++++++++++++++++++++----
 include/linux/syscalls.h               |  1 +
 6 files changed, 50 insertions(+), 12 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

