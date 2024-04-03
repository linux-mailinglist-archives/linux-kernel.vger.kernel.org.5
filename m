Return-Path: <linux-kernel+bounces-130249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA408975EB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C87101F22E51
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A90152519;
	Wed,  3 Apr 2024 17:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="aph64/0W"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8BA6E60F
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 17:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712163960; cv=none; b=H6SUGxgmXKomsvi/yImB7aiOuAN328JW5EK5vFN5cAT+REjUW5H0YSBcptBkPDGhlyTe/a4YlJD4L8zVjPBM8BX4pd4LxFW3IBzObi9sFrDQJ/xHzvBNW8wUAgyS513qBoMqV5cIqYIDVmeRM8RVllre7oK0VVU23cKpVvVu+wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712163960; c=relaxed/simple;
	bh=Jd4BHvRPKqhFeMu5ITAzv/jcjy5QPHwQQaC48cYJc6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lP3YRgSUkzQw0AimYE4+kfKQlh835sb940o64xI1jQA9GEHKw6Ty/2ZAtnZe+1+BbHgXX97nJvCk0W3jSgMOhVjrIZmUbK42+YUosfDmqW2D3EJSTUZT/BFImHdIxcHWhMJvFTZ5XdaAoMa3QaqFJ8j8weXbCDCuVS9X7kCmMho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=aph64/0W; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2CA2640E019B;
	Wed,  3 Apr 2024 17:05:55 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id biapfoup9x9x; Wed,  3 Apr 2024 17:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1712163949; bh=nlDEmjDrb0uwgRIcCGqAC2jcGn2X53+a7hDmicU3V9M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aph64/0WckPYA9dnAiDvGu4Ppewp4aHpRUx7BpG06f9IKeXGf9UrYAtDw2EF549dg
	 7ywIBR9m8qVelAZZwT+PNkmsR5eW1GQxgjvbnJKJdboegZ+Hc8PtFXKrb5mFjQjnlp
	 /ABfhIcpSLbMtjCj0qUHSAqU9pChCoLZzvxiQ9Um4pNb1uJNJ7ucOt4kQRjU/3snto
	 CTmiv4Zkm/vN8zPaT8mDi4tpsyXx2z0H8KglF1T6NTPUzHGPj0v0M5eKyA3XQY65Bd
	 sJqUC56n5ju0bDa97QfjfVspgilcHOXpcoGaqY/18oQHoZJvZRYzxEe/CxOgXm0ua9
	 L6ZHy6SnrhIMM5XdZIgRV0T/UO8kPqmVPH90DvYUjLZYQbV2bTfjxydfl/wGN2X9UH
	 l30TFsjfGki/0m8bF0FV9bqL00q5gVV80IQUXPYUEuRwipIM5R5Th5sPOjst/QEOl/
	 MVEUSTI+kh2bXD6JybN5Tst8VDPxbPabnSDJhEqtQo0p3R9tsNxj4dLHeO+FNrxFuu
	 zvbHcao4zz6K5lGu3ZD0vJWLD19d3h7WEC5UbpKGLVc8KpX6AHtIR0JWDSE8kQN/Qt
	 Cj2pvbqd3CjUh4tSByuTYUNTl9HsKMMPyJJXt9uGDtupCdtNKKlMZ/pz9mb8QM4rWz
	 h6pWA+QIKkkwgahByGhGp8A4=
Received: from zn.tnic (p5de8ecf7.dip0.t-ipconnect.de [93.232.236.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7011240E00F4;
	Wed,  3 Apr 2024 17:05:43 +0000 (UTC)
Date: Wed, 3 Apr 2024 19:05:34 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] x86/retpoline: Fix a missing return thunk warning (was:
 Re: [linus:master] [x86/bugs] 4535e1a417:
 WARNING:at_arch/x86/kernel/alternative.c:#apply_returns)
Message-ID: <20240403170534.GHZg2MXmwFRv-x8usY@fat_crate.local>
References: <202404020901.da75a60f-oliver.sang@intel.com>
 <20240403122350.GEZg1KVvsyc-Z3bwro@fat_crate.local>
 <CAHk-=wj+Q_LXV0Y5+kBvv-5sTxT3Y7E=8wJ2sX4vzWksd3LWzA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wj+Q_LXV0Y5+kBvv-5sTxT3Y7E=8wJ2sX4vzWksd3LWzA@mail.gmail.com>

On Wed, Apr 03, 2024 at 09:45:25AM -0700, Linus Torvalds wrote:
> On Wed, 3 Apr 2024 at 05:24, Borislav Petkov <bp@alien8.de> wrote:
> >
> > Subject: [PATCH] x86/retpoline: Fix a missing return thunk warning
> 
> Thanks, applied directly,

Can you pls replace it with the below one?

There's more breakage:

https://bugzilla.kernel.org/show_bug.cgi?id=218679

and I think it needs an __EXPORT_THUNK too.

Yeah, I know. Damn ifdeffery. :-\

I've changed it:

https://bugzilla.kernel.org/attachment.cgi?id=306084&action=diff

and this should be the correct fix(tm). Famous last words.

Thx.

---
From ca5b34498f997cba9c24d450f7ccab4b37377560 Mon Sep 17 00:00:00 2001
From: "Borislav Petkov (AMD)" <bp@alien8.de>
Date: Tue, 2 Apr 2024 16:05:49 +0200
Subject: [PATCH] x86/retpoline: Do the necessary fixup to the Zen3/4 srso
 return thunk for !SRSO

The srso_alias_untrain_ret() dummy thunk in the !CONFIG_MITIGATION_SRSO
case is there only for the altenative in CALL_UNTRAIN_RET to have
a symbol to resolve.

However, testing with kernels which don't have CONFIG_MITIGATION_SRSO
enabled, leads to the warning in patch_return() to fire:

  missing return thunk: srso_alias_untrain_ret+0x0/0x10-0x0: eb 0e 66 66 2e
  WARNING: CPU: 0 PID: 0 at arch/x86/kernel/alternative.c:826 apply_returns (arch/x86/kernel/alternative.c:826

Put in a plain "ret" there so that gcc doesn't put a return thunk in
in its place which special and gets checked.

In addition:

  ERROR: modpost: "srso_alias_untrain_ret" [arch/x86/kvm/kvm-amd.ko] undefined!
  make[2]: *** [scripts/Makefile.modpost:145: Module.symvers] Chyba 1
  make[1]: *** [/usr/src/linux-6.8.3/Makefile:1873: modpost] Chyba 2
  make: *** [Makefile:240: __sub-make] Chyba 2

since !SRSO builds would use the dummy return thunk as reported by
petr.pisar@atlas.cz, https://bugzilla.kernel.org/show_bug.cgi?id=218679.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202404020901.da75a60f-oliver.sang@intel.com
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/all/202404020901.da75a60f-oliver.sang@intel.com/
---
 arch/x86/lib/retpoline.S | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index 02cde194a99e..0795b3464058 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -228,8 +228,11 @@ SYM_CODE_END(srso_return_thunk)
 #else /* !CONFIG_MITIGATION_SRSO */
 /* Dummy for the alternative in CALL_UNTRAIN_RET. */
 SYM_CODE_START(srso_alias_untrain_ret)
-	RET
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
 SYM_FUNC_END(srso_alias_untrain_ret)
+__EXPORT_THUNK(srso_alias_untrain_ret)
 #define JMP_SRSO_UNTRAIN_RET "ud2"
 #endif /* CONFIG_MITIGATION_SRSO */
 
-- 
2.43.0


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

