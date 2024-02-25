Return-Path: <linux-kernel+bounces-80038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C360C862A05
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 11:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 783AF281DF7
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 10:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46476FC15;
	Sun, 25 Feb 2024 10:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="IWQ3P+Pd"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A139445
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 10:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708858411; cv=none; b=RSyV8LuCM3YxsSt0r3oGcMmeAwaDKsIFVN8MQYVeLBYoYmwrLW9K9f+DuAIEjvUZPzxHf78xSEHj3I+m7U/Hu7S3qoEIE6WUpNrIc5H6TZnp5eVZ5deGdw2FkLEVZz0PCGOMwENt4R2q/XyI7l8ARW5tiiLgXF2Dfclyn22OYJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708858411; c=relaxed/simple;
	bh=FDViOf7yySsA0lA+J0nHOdO54+k5g9sHwCPBqiFyg3E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PGv8WXxVnpPfvgTysbl0jtedZiblIsr4UfSSHJHohXlEVUDJdZpnGTbt2uGVwQC9mE+UYTVkUyzV6lpm7Hcf+8CEevAJJvolIY/PkaNuVnAj0Wc0dhRxZ3v0l0ohyl4NNA2kaQxahjvEcm5R8HDJPIMl5kRFEg3g9PT6XRuBl9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=IWQ3P+Pd; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6307240E0192;
	Sun, 25 Feb 2024 10:53:27 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id mNyxTFXOPTfI; Sun, 25 Feb 2024 10:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1708858404; bh=VzhZtmJDxXcu6WUzL2Z6aDKOD8My4jQtElr8IuGtEag=;
	h=Date:From:To:Cc:Subject:From;
	b=IWQ3P+PdvTLgm4YIvxBYJk4zmHlmW/svoml2NP7mDTvS+sw7OqVRWQ7ffo9lgMGn0
	 NmlMQLaP2edoViaFqBGHiewcV1X74xwl5ZvELKKFEt1fzksAGJgCSP37/z/Q5qL7kE
	 FY/4lczP3DeTKuo2GdLfuQzEK6g4ln53dSWN2hafKfGWduPaIqfS8v/jJK6NjSzooc
	 J0l3OsDpTDIOH6xvzrME9OvALr8Fi3ys8/ZTCXR0wKu7JJhfw2UF/kqyVn8ndlsPOg
	 N0qsjsOex7aN1YmlQ2bXLVkvwoKRQLXYMLkTsqk0muGLwh7qv7wjHN1bDaXLLVA5OO
	 ezDzUqt7Gsm1CwkuTadWEpe1z8OtmvoHuhezV4RFKCl1wDXWxq9H9KL5+xk9fptmTs
	 RmjAM4XWHc9DFBjLPUlK/R04RjyYrn9ozA7Fx/JqzJAEk40hEjW/xEJI1ON9Z68DPR
	 nYd6cs4Q5fMRtrPUpWV8LldwtVzBXzfMDMtS8xsZSyV7d+XzuZiM38hlM0GEDldCUK
	 3dGEScO3X8J2bEQWKLQ2Y0+Gv65G9zidZet6McFKq2YLF7VSg/KuSeeulWqq+0D8lg
	 gihl7gV8No38PD0WpkjdcKGqWZ6hRXESrUwO07Rpd2UegBk/nUGQiGEQH3Ozznxg3F
	 ZY+U6RmhoaEZzI2f4FU3Z/Lc=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4914C40E00B2;
	Sun, 25 Feb 2024 10:53:21 +0000 (UTC)
Date: Sun, 25 Feb 2024 11:53:20 +0100
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/urgent for v6.8-rc6
Message-ID: <20240225105320.GAZdscIJ3wxkU8_6At@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull a bunch of urgent x86 fixes for v6.8-rc6.

Thx.

---

The following changes since commit b401b621758e46812da61fa58a67c3fd8d91de0d:

  Linux 6.8-rc5 (2024-02-18 12:56:25 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v6.8_rc6

for you to fetch changes up to 43fb862de8f628c5db5e96831c915b9aebf62d33:

  KVM/VMX: Move VERW closer to VMentry for MDS mitigation (2024-02-19 16:31:59 -0800)

----------------------------------------------------------------
- Make sure clearing CPU buffers using VERW happens at the latest possible
  point in the return-to-userspace path, otherwise memory accesses after
  the VERW execution could cause data to land in CPU buffers again

----------------------------------------------------------------
Pawan Gupta (5):
      x86/bugs: Add asm helpers for executing VERW
      x86/entry_64: Add VERW just before userspace transition
      x86/entry_32: Add VERW just before userspace transition
      x86/bugs: Use ALTERNATIVE() instead of mds_user_clear static key
      KVM/VMX: Move VERW closer to VMentry for MDS mitigation

Sean Christopherson (1):
      KVM/VMX: Use BT+JNC, i.e. EFLAGS.CF to select VMRESUME vs. VMLAUNCH

 Documentation/arch/x86/mds.rst       | 38 +++++++++++++++++++++++++-----------
 arch/x86/entry/entry.S               | 23 ++++++++++++++++++++++
 arch/x86/entry/entry_32.S            |  3 +++
 arch/x86/entry/entry_64.S            | 11 +++++++++++
 arch/x86/entry/entry_64_compat.S     |  1 +
 arch/x86/include/asm/cpufeatures.h   |  2 +-
 arch/x86/include/asm/entry-common.h  |  1 -
 arch/x86/include/asm/nospec-branch.h | 25 ++++++++++++------------
 arch/x86/kernel/cpu/bugs.c           | 15 ++++++--------
 arch/x86/kernel/nmi.c                |  3 ---
 arch/x86/kvm/vmx/run_flags.h         |  7 +++++--
 arch/x86/kvm/vmx/vmenter.S           |  9 ++++++---
 arch/x86/kvm/vmx/vmx.c               | 20 +++++++++++++++----
 13 files changed, 112 insertions(+), 46 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

