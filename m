Return-Path: <linux-kernel+bounces-119910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 394FA88CEE5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1998326929
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E5B13DDDE;
	Tue, 26 Mar 2024 20:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="k++KNz+4"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E3713DDD3;
	Tue, 26 Mar 2024 20:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711484781; cv=none; b=mLoEZDf3JWEO22A4F84R8EvuLyQXveDiC5VNk7vqU6s+bvyR3aDXL8ailAsmm0CxoaMSf+D14vcPREsfxq+bXxEURbiVpfqibLdOXYG+ZIcfJMzTC2yO83cCvAm8AvJm3+t3z3M0sBztxEmghk+7fgJxXDbAg7A7urNzNrRPz1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711484781; c=relaxed/simple;
	bh=F+L/h3rZ3z5tOVvFOUDDEOBQKST3mb9eXYvpmYWj7AY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XhbMnSW8B04q41RibjolLSRt8MuCzDTgaGjk181lTvIO3W6i8WapHFsCJrZl1VHYyz4TsTgKT2o8rEt9EeiU/EtJVP3rREtXDsrsJNwQKtGfQjtiQvfzuTnuscpBRQZzrFfJCkVIgn9XxUqWDdBxwnRNcdBhTKnEjflWzes8Weo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=k++KNz+4; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D606540E02A2;
	Tue, 26 Mar 2024 20:26:15 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ipJStxiHWz6w; Tue, 26 Mar 2024 20:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1711484769; bh=3SbmZZlB5wb5VIeyhkLEZvwoIUAa+ndZFBbsOshMQUA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k++KNz+4aL1QetjecZlkBF1D+hdfT+nfPt5X/AJmyq84BC8fSu58u1L8HlEKFDkwP
	 5jScY1uLerHph5o93L69N1eeePmDwze2ODL3H0GunKiK+qIzXq3tG/BEzaEewI/jca
	 nImyCtwaUifuU0tau7FwTRLgVzG3ASoVpFjCh0yUvTnlwkDob1NTz7lnLne4pw8qM9
	 xZxROET8zJLpWM7z+MBaktZW57xljgtsCM8BlfMxg3qfUBuJ9QiHnQs6Ay8bZLwzdP
	 QJYO3MskddagiQz47m5MkHWifonjz+ttAZlr+9n27TJo4G0NvyirXCsS3rovdVi5mo
	 Q82BgEZO1CVjPTkPTiCVLexnT1Eu+YrkV0dLWJu6lc2q7uSGbt/dkGgpfCrUoos53Q
	 g55gYhqLnjmDPm0fblT2ta34ErkABpx4l0vnfyP1cqAc+Qy1Hvtg2RTLdEIiUvw8OB
	 2JptRxdxh4OmecSdK02L7TPQTiUObgMSxN27wXSV9CVoTLJ2+U/Jr2oLV0k0XmjP8R
	 Pqq+DBjh5T8k0+TXCnIL6w06Uttf2wsJq6jlhavYYE/XiCOMuwTqjNNOpAsOvxPpRv
	 djCf6eItqe/thU7znQJwu+VmcEaW2nM9/M3ecwb4nGSWt5sfJKAi2NMiwSGBRnC3dd
	 IEGlNwfkq10dmfoeeCj/2O4U=
Received: from zn.tnic (p5de8ecf7.dip0.t-ipconnect.de [93.232.236.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9C07A40E024C;
	Tue, 26 Mar 2024 20:25:53 +0000 (UTC)
Date: Tue, 26 Mar 2024 21:25:48 +0100
From: Borislav Petkov <bp@alien8.de>
To: Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>, linux-kbuild@vger.kernel.org
Cc: Marco Elver <elver@google.com>, Nikolay Borisov <nik.borisov@suse.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	LKML <linux-kernel@vger.kernel.org>, kasan-dev@googlegroups.com,
	David Kaplan <David.Kaplan@amd.com>
Subject: [PATCH] kbuild: Disable KCSAN for autogenerated *.mod.c
 intermediaries
Message-ID: <20240326202548.GLZgMvTGpPfQcs2cQ_@fat_crate.local>
References: <0851a207-7143-417e-be31-8bf2b3afb57d@molgen.mpg.de>
 <47e032a0-c9a0-4639-867b-cb3d67076eaf@suse.com>
 <20240326155247.GJZgLvT_AZi3XPPpBM@fat_crate.local>
 <80582244-8c1c-4eb4-8881-db68a1428817@suse.com>
 <20240326191211.GKZgMeC21uxi7H16o_@fat_crate.local>
 <CANpmjNOcKzEvLHoGGeL-boWDHJobwfwyVxUqMq2kWeka3N4tXA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANpmjNOcKzEvLHoGGeL-boWDHJobwfwyVxUqMq2kWeka3N4tXA@mail.gmail.com>

On Tue, Mar 26, 2024 at 08:33:31PM +0100, Marco Elver wrote:
> I think just removing instrumentation from the mod.c files is very reasonable.

Thanks!

@Masahiro: pls send this to Linus now as the commit which adds the
warning is in 6.9 so we should make sure we release it with all issues
fixed.

Thx.

---
From: "Borislav Petkov (AMD)" <bp@alien8.de>
Date: Tue, 26 Mar 2024 21:11:01 +0100

When KCSAN and CONSTRUCTORS are enabled, one can trigger the

  "Unpatched return thunk in use. This should not happen!"

catch-all warning.

Usually, when objtool runs on the .o objects, it does generate a section
return_sites which contains all offsets in the objects to the return
thunks of the functions present there. Those return thunks then get
patched at runtime by the alternatives.

KCSAN and CONSTRUCTORS add this to the the object file's .text.startup
section:

  -------------------
  Disassembly of section .text.startup:

  ...

  0000000000000010 <_sub_I_00099_0>:
    10:   f3 0f 1e fa             endbr64
    14:   e8 00 00 00 00          call   19 <_sub_I_00099_0+0x9>
                          15: R_X86_64_PLT32      __tsan_init-0x4
    19:   e9 00 00 00 00          jmp    1e <__UNIQUE_ID___addressable_cryptd_alloc_aead349+0x6>
                          1a: R_X86_64_PLT32      __x86_return_thunk-0x4
  -------------------

which, if it is built as a module goes through the intermediary stage of
creating a <module>.mod.c file which, when translated, receives a second
constructor:

  -------------------
  Disassembly of section .text.startup:

  0000000000000010 <_sub_I_00099_0>:
    10:   f3 0f 1e fa             endbr64
    14:   e8 00 00 00 00          call   19 <_sub_I_00099_0+0x9>
                          15: R_X86_64_PLT32      __tsan_init-0x4
    19:   e9 00 00 00 00          jmp    1e <_sub_I_00099_0+0xe>
                          1a: R_X86_64_PLT32      __x86_return_thunk-0x4

  ...

  0000000000000030 <_sub_I_00099_0>:
    30:   f3 0f 1e fa             endbr64
    34:   e8 00 00 00 00          call   39 <_sub_I_00099_0+0x9>
                          35: R_X86_64_PLT32      __tsan_init-0x4
    39:   e9 00 00 00 00          jmp    3e <__ksymtab_cryptd_alloc_ahash+0x2>
                          3a: R_X86_64_PLT32      __x86_return_thunk-0x4
  -------------------

in the .ko file.

Objtool has run already so that second constructor's return thunk cannot
be added to the .return_sites section and thus the return thunk remains
unpatched and the warning rightfully fires.

Drop KCSAN flags from the mod.c generation stage as those constructors
do not contain data races one would be interested about.

Debugged together with David Kaplan <David.Kaplan@amd.com> and Nikolay
Borisov <nik.borisov@suse.com>.

Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/0851a207-7143-417e-be31-8bf2b3afb57d@molgen.mpg.de
---
 scripts/Makefile.modfinal | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
index 8568d256d6fb..79fcf2731686 100644
--- a/scripts/Makefile.modfinal
+++ b/scripts/Makefile.modfinal
@@ -23,7 +23,7 @@ modname = $(notdir $(@:.mod.o=))
 part-of-module = y
 
 quiet_cmd_cc_o_c = CC [M]  $@
-      cmd_cc_o_c = $(CC) $(filter-out $(CC_FLAGS_CFI) $(CFLAGS_GCOV), $(c_flags)) -c -o $@ $<
+      cmd_cc_o_c = $(CC) $(filter-out $(CC_FLAGS_CFI) $(CFLAGS_GCOV) $(CFLAGS_KCSAN), $(c_flags)) -c -o $@ $<
 
 %.mod.o: %.mod.c FORCE
 	$(call if_changed_dep,cc_o_c)
-- 
2.43.0



-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

