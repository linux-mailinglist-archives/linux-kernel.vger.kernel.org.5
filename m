Return-Path: <linux-kernel+bounces-129713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE241896ED0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C08CD1C260AB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90456146000;
	Wed,  3 Apr 2024 12:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="eJc8oI9I"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB00A145FE9
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 12:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712147046; cv=none; b=p3eOw4jZWozocDhMMBJLJT5gT9WyOcAPTiE9oEO8B7AC82tsJkI+ZeFYo4emQAHGE0wDuvJkju29J6LHQflGQje9bQOLvF/pBJFIA0L6fhkY13sBeRL7UClHwuxB0s8nrYkBbEcuhAw081DMmAAw9VoqUSbxjuwuY3Z/7o13rp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712147046; c=relaxed/simple;
	bh=QbayxI9VUByD6j6vldQlMbmK1aQIb/J5bWvg0XtkW6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mwserOOsX4zMYKE9pTrakwdWR5PIMUNGq9oqKdlCxc4fVP0XUy1mB6QgI1or5ir6gBJiJ6ZnldB6yxlj3ec73C8iOHgWZ42hmHTWKXOWoMGYvts6W0ytsBJNZ5pi/rajJFHoznyfseFcctLtK391Q+pX0ZwtAPNKcpR/0FuuEOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=eJc8oI9I; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B5A6040E019B;
	Wed,  3 Apr 2024 12:24:02 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id iJtG7bXtJZbz; Wed,  3 Apr 2024 12:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1712147037; bh=6BfpoqG+6JI54u/oo5Jqh7AiO+q8UY4Ehl8mJ+Yxoho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eJc8oI9I6ySxWuh6eBWmEDgVX5d3r3OnFgm2wxx/1gTvxlXBXdgE4xpPNDg2+KQn5
	 OAFOqYA5l//NoQSEy/rPowLrG2ZGPiBu9/Nb4qGB9qeStKHKqrIQm8m93pBuSwTP7J
	 WtiarLg4VAzM4sbnylIELyIQ+lwBucRuRVfeyh0HB+9rwa4pSek1nwq4bS12+AoMD3
	 eoSs8PbvLd+eklEnMvixZF2P3b7W7wrm3EnhlPfhF4PArO97VLqpreWKR0zWaeSyPA
	 UJJKAEgXwJpXNriTc19xVFMIfm4NhjTZq5QLBzJrQTM2EJ/TliJpNbtnh8RoUf7ytu
	 8z+IcD58h5XlDfjz7MIvlrInajZsmmHSaNvZupJFKYg2T9JHnf2fFFYHI1Ug3+2Esw
	 Fzmcn3l90zfDyUONOkMGRua3QxYCrOKBi0cMn4phOi/cz7fkAO+OPE1dksSOMW7PA1
	 jP6Bm2hMzyJ+e5HWIRnVIc20T3N5Ts3zy2R4vK0LsFq/tBwnoHb1QzCX+xXhFN0A8Z
	 1zmvrvNx1qIk9I9+LVZ5H+TzXzmbLZ+MLJJU/a83lqezCqk9y6pydFElzFN2oFY9uW
	 7XLsdQo5ortyU3+egBw2SyylMdDjdWtkcnWSSWuexljAvVBtBaChMZxSzabVHGUvsN
	 34Zb2GcuMmMnKNL53uYLGE3Q=
Received: from zn.tnic (p5de8ecf7.dip0.t-ipconnect.de [93.232.236.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 445EA40E019C;
	Wed,  3 Apr 2024 12:23:51 +0000 (UTC)
Date: Wed, 3 Apr 2024 14:23:50 +0200
From: Borislav Petkov <bp@alien8.de>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH] x86/retpoline: Fix a missing return thunk warning (was: Re:
 [linus:master] [x86/bugs]  4535e1a417:
 WARNING:at_arch/x86/kernel/alternative.c:#apply_returns)
Message-ID: <20240403122350.GEZg1KVvsyc-Z3bwro@fat_crate.local>
References: <202404020901.da75a60f-oliver.sang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202404020901.da75a60f-oliver.sang@intel.com>

On Tue, Apr 02, 2024 at 10:14:07AM +0800, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "WARNING:at_arch/x86/kernel/alternative.c:#apply_returns" on:
> 
> commit: 4535e1a4174c4111d92c5a9a21e542d232e0fcaa ("x86/bugs: Fix the SRSO mitigation on Zen3/4")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

---
From: "Borislav Petkov (AMD)" <bp@alien8.de>
Date: Tue, 2 Apr 2024 16:05:49 +0200
Subject: [PATCH] x86/retpoline: Fix a missing return thunk warning

The srso_alias_untrain_ret() dummy thunk in the !CONFIG_MITIGATION_SRSO
case is there only for the altenative in CALL_UNTRAIN_RET to have
a symbol to resolve.

However, testing with kernels which don't have CONFIG_MITIGATION_SRSO
enabled, leads to the warning in patch_return() to fire:

  missing return thunk: srso_alias_untrain_ret+0x0/0x10-0x0: eb 0e 66 66 2e
  WARNING: CPU: 0 PID: 0 at arch/x86/kernel/alternative.c:826 apply_returns (arch/x86/kernel/alternative.c:826

Put in a plain "ret" there so that gcc doesn't put a return thunk in
in its place which special and gets checked.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202404020901.da75a60f-oliver.sang@intel.com
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/all/202404020901.da75a60f-oliver.sang@intel.com/
---
 arch/x86/lib/retpoline.S | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index 02cde194a99e..440cc58986fa 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -228,7 +228,9 @@ SYM_CODE_END(srso_return_thunk)
 #else /* !CONFIG_MITIGATION_SRSO */
 /* Dummy for the alternative in CALL_UNTRAIN_RET. */
 SYM_CODE_START(srso_alias_untrain_ret)
-	RET
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
 SYM_FUNC_END(srso_alias_untrain_ret)
 #define JMP_SRSO_UNTRAIN_RET "ud2"
 #endif /* CONFIG_MITIGATION_SRSO */
-- 
2.43.0

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

