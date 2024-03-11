Return-Path: <linux-kernel+bounces-98987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF318781EE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D0B91F23259
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18BD41C79;
	Mon, 11 Mar 2024 14:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="BCV0rX+P"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAFC41766
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 14:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710168396; cv=none; b=OjU3SCEwOI3SXZ4GWwCDZ77dVQfI7IV20DX+anEuUOxxum1KpyLfuCENSkU7uVxA6IPr250hg3N0TA71G1I89kVRV9NQiiN6RxoGoDwuOREWGIJbp3hXpbu9Hnf6JYoFaoPoif43oY4u01iCRfrA5K/jjUYOzGI6MlixKDprt/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710168396; c=relaxed/simple;
	bh=JIAV+scH1xIAdYwlJnhB9yKM4ck3zmaSYphtveX+nSA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qCJBmlsEpq0g8TqgtpjqdD3uV9b92Fh+kFGk+Pb8Khi2iXfh6SIR84DszBj2ov+PCaHqF7AyC6muHERUWkcizaPcvh5adWcs2xQA6qdXVef3G9BKvcWa2s5Akj3jvWi4FlfDt+nsJk9oxaNC6lvNkAgj12PhWTfmMuPWvnP6nQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=BCV0rX+P; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B557540E0196;
	Mon, 11 Mar 2024 14:46:32 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 0rucQ9ToaQdJ; Mon, 11 Mar 2024 14:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1710168390; bh=lzYlwomu703ynixZNm0jhjDL7DwvXXmYTH7fMYIycgU=;
	h=Date:From:To:Cc:Subject:From;
	b=BCV0rX+Peteic9BMcEVCL2To9lWXIG+7KHj6kGAyRT/ceuA6MLuvNQIuSJlgXdz+R
	 cUEIm3ATzdkncPkT9uJMC1PS1AAV1qlp5RQjXR/0Ijf7JmMaUqFV19HkTNw0NhjVav
	 yYPJmQWffLEC97IC1Nlxe88SdKDbD9KfgzNyYe/W8QzcV4fzjtR/5vKo6C1z3/2bO/
	 11acF4/uU3kA5WRYh0zia/mcm4tIwVD/t7p8C9jWJke02YoBZUCptFJb100k5sp0NB
	 VrydM8XHLOeOxjRxTrafgxTebk2sf0z+9uAm0oFO8DEOD0EUiGqwjNzxei3ZEkO8Vn
	 A4emGqhGYGuzU5n8DjJpaDJxPOQsyVqDM4JF/JQStj6E0UNIoQ+rD06nwRiJxH1+tD
	 tqh7CLTh4ej1iK6v1yW/kZWUDz12j4Dc0CfWb3tGE6uEt4/5XuKpCWL00DiWfOaQap
	 tuFsxXNo0lPaog35eQ4IzR3FyNGy0/BEqxXiUW6zvUIRksqOuqEHiLnBNKsObIP/dc
	 C6O6GWyxm2VkIs3SdDHrrHgpDWCQzPw5eCSKXSQi3vqGSdgt2FN28t0TZ98TfbJf+y
	 3LgY3LzLs8TH4008YmgHqqnw/pltV5vEFjWaVs8SpMisVLObN6x5HyVGKchG9SL+Il
	 9/inbwQWW/okBxMwdUCdUYoA=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7993140E016C;
	Mon, 11 Mar 2024 14:46:27 +0000 (UTC)
Date: Mon, 11 Mar 2024 15:46:21 +0100
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/cache for v6.9-rc1
Message-ID: <20240311144621.GAZe8ZPWxhiTzw2wDP@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull a bunch of resctrl updates for for v6.9-rc1.

Thx.

---

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cache_for_v6.9_rc1

for you to fetch changes up to c0d848fcb09d80a5f48b99f85e448185125ef59f:

  x86/resctrl: Remove lockdep annotation that triggers false positive (2024-02-22 16:15:38 +0100)

----------------------------------------------------------------
- Rework different aspects of the resctrl code like adding arch-specific
  accessors and splitting the locking, in order to accomodate ARM's MPAM
  implementation of hw resource control and be able to use the same
  filesystem control interface like on x86. Work by James Morse

- Improve the memory bandwidth throttling heuristic to handle workloads
  with not too regular load levels which end up penalized unnecessarily

- Use CPUID to detect the memory bandwidth enforcement limit on AMD

- The usual set of fixes

----------------------------------------------------------------
Babu Moger (3):
      x86/resctrl: Remove hard-coded memory bandwidth limit
      x86/resctrl: Read supported bandwidth sources from CPUID
      x86/resctrl: Remove redundant variable in mbm_config_write_domain()

James Morse (25):
      tick/nohz: Move tick_nohz_full_mask declaration outside the #ifdef
      x86/resctrl: Free rmid_ptrs from resctrl_exit()
      x86/resctrl: Create helper for RMID allocation and mondata dir creation
      x86/resctrl: Move RMID allocation out of mkdir_rdt_prepare()
      x86/resctrl: Track the closid with the rmid
      x86/resctrl: Access per-rmid structures by index
      x86/resctrl: Allow RMID allocation to be scoped by CLOSID
      x86/resctrl: Track the number of dirty RMID a CLOSID has
      x86/resctrl: Use __set_bit()/__clear_bit() instead of open coding
      x86/resctrl: Allocate the cleanest CLOSID by searching closid_num_dirty_rmid
      x86/resctrl: Move CLOSID/RMID matching and setting to use helpers
      x86/resctrl: Add cpumask_any_housekeeping() for limbo/overflow
      x86/resctrl: Queue mon_event_read() instead of sending an IPI
      x86/resctrl: Allow resctrl_arch_rmid_read() to sleep
      x86/resctrl: Allow arch to allocate memory needed in resctrl_arch_rmid_read()
      x86/resctrl: Make resctrl_mounted checks explicit
      x86/resctrl: Move alloc/mon static keys into helpers
      x86/resctrl: Make rdt_enable_key the arch's decision to switch
      x86/resctrl: Add helpers for system wide mon/alloc capable
      x86/resctrl: Add CPU online callback for resctrl work
      x86/resctrl: Allow overflow/limbo handlers to be scheduled on any-but CPU
      x86/resctrl: Add CPU offline callback for resctrl work
      x86/resctrl: Move domain helper migration into resctrl_offline_cpu()
      x86/resctrl: Separate arch and fs resctrl locks
      x86/resctrl: Remove lockdep annotation that triggers false positive

Tony Luck (2):
      x86/resctrl: Fix unused variable warning in cache_alloc_hsw_probe()
      x86/resctrl: Implement new mba_MBps throttling heuristic

 arch/x86/include/asm/resctrl.h            |  90 ++++++
 arch/x86/kernel/cpu/resctrl/core.c        | 111 ++++---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  48 ++-
 arch/x86/kernel/cpu/resctrl/internal.h    |  75 ++++-
 arch/x86/kernel/cpu/resctrl/monitor.c     | 501 ++++++++++++++++++++++--------
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  15 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 388 ++++++++++++++++-------
 include/linux/resctrl.h                   |  48 ++-
 include/linux/tick.h                      |   9 +-
 9 files changed, 946 insertions(+), 339 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

