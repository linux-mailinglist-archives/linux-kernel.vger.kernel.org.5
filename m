Return-Path: <linux-kernel+bounces-163956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5ADA8B768D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 852221F2291D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D66171658;
	Tue, 30 Apr 2024 13:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="juNMt5sm"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7CE17164A
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 13:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714482233; cv=none; b=UUrJ8Tyi3e7zuoF863TQWAkk8xQZ2WgomXbTSrr8cF98LHfg3I0TEHcudpnH7n22gYYqOyzusGJnjseSX/Vp1RN4zqoxYmoomH8ISd8Q4KXJ25JMilOzzlHB+obcH/Qqbw/1VTy8TX9DkB9yJ5UY8mL4QA34crdYyjaWvjtnw94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714482233; c=relaxed/simple;
	bh=0DgoqzOughMpMCnHD73e64SXh2Mbhdm326Iu2jw37y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pYZMuQH2xeVzN6xSUzds4tTgApKjcDAfrgFoSV2G2jvSKKSurJZLTRopSfVL1FGql0SifsGOm+sZD3/WB6NnC8VoWpk0tjoSH85cGr0SZ2wtljMUKjQSE4Gn76o8+KgOud1W7EkNid6XzSTz9Op7jEpumwg/B9N9C82+E/Exzl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=juNMt5sm; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8E19840E00B2;
	Tue, 30 Apr 2024 13:03:48 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 4pOHEVBUvPZw; Tue, 30 Apr 2024 13:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1714482224; bh=yH6Cwq5/6RGkXtt5HQxlFR8k88T6Ia2YT89+Wjt1MZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=juNMt5sml1hzAQw8ms2D04JBZUNnRjMdVKJ8nvf2Z0jYIs50oI2ezS4569ejqpPT7
	 J3PDH5Ml4s4Utu+2BhLRka0NKCurSbPKHWPcklEssmWhuiXTcR/DXdKqAWQe3rko1o
	 MLaEgIdd06Pqyt9CVBv3WrHPBzgnVvy8NLzlcIorNXOuyqMFOMWGS3YHCaEUEdDSvr
	 l9UZK4wH5Vg9p9s4liriyMZ2wNtczIq8hSeNoTmket0pNKiQEkAT9Yb7D/osJnF9mB
	 yxIWpgTKpCVNLSSk9j3RMZeHx7SBM/lNQD9yWHr6e+yjk4piyJHJD47jB7vcMsFq8D
	 LhVNjBdOTGboN8l7nZi+DziNaF921K0LsanmK3XpzWFtWTI3a8S8BPf9kiFLse6oY9
	 ioqmSAQMvaZQwbJrxdf1UZ/hl9M7vY0xDj6pScAygVRA7JUJhOdys+KGKn9BgUpCNG
	 x8x3+r7zF50fPMKJ5GLRnVeT6LKos0PkChpiuLNxUw5fOI9OUY4zmDwYKzx7YGAX5G
	 NFbuSKxS+3N6oACe+Js9/PkTwZ+A8Go0w9OAa93debmZDYvuw8n3RpcQP6HNoGBTHb
	 CmUTw2K0MvgCnI04isvWw/cNjukt+2KZT4noNKeNID09Ycus/JPSN4wPhc+oiwmVIU
	 YC3lblHRoDgiwrqxN0qAN2wk=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 51C6D40E016B;
	Tue, 30 Apr 2024 13:03:24 +0000 (UTC)
Date: Tue, 30 Apr 2024 15:03:23 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"Kalra, Ashish" <ashish.kalra@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	"Huang, Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>,
	kexec@lists.infradead.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHv10 05/18] x86/kexec: Keep CR4.MCE set during kexec for
 TDX guest
Message-ID: <20240430130323.GAZjDsG00Xdhv5mv8W@fat_crate.local>
References: <20240409113010.465412-1-kirill.shutemov@linux.intel.com>
 <20240409113010.465412-6-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240409113010.465412-6-kirill.shutemov@linux.intel.com>

On Tue, Apr 09, 2024 at 02:29:57PM +0300, Kirill A. Shutemov wrote:
> +1:
> +	testq	$X86_CR4_MCE, %r13
> +	jz	1f
> +	ALTERNATIVE "", __stringify(orl $X86_CR4_MCE, %eax), X86_FEATURE_TDX_GUEST
>  1:

Please add the below patch to your set. Those same-number labels are
just abominable.

Thx.

---
From: "Borislav Petkov (AMD)" <bp@alien8.de>
Date: Tue, 30 Apr 2024 15:00:16 +0200
Subject: [PATCH] x86/relocate_kernel: Use named labels for less confusion

That identity_mapped() function was loving that "1" label to the point
of completely confusing its readers.

Use named labels in each place for clarity.

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/kernel/relocate_kernel_64.S | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 8e2037d78a1f..0077c9e562a7 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -152,13 +152,15 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	 */
 	movl	$X86_CR4_PAE, %eax
 	testq	$X86_CR4_LA57, %r13
-	jz	1f
+	jz	no_la57
 	orl	$X86_CR4_LA57, %eax
-1:
+no_la57:
+
 	testq	$X86_CR4_MCE, %r13
-	jz	1f
+	jz	mca_off
 	ALTERNATIVE "", __stringify(orl $X86_CR4_MCE, %eax), X86_FEATURE_TDX_GUEST
-1:
+mca_off:
+
 	movq	%rax, %cr4
 
 	jmp 1f
@@ -173,9 +175,9 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	 * used by kexec. Flush the caches before copying the kernel.
 	 */
 	testq	%r12, %r12
-	jz 1f
+	jz sme_off
 	wbinvd
-1:
+sme_off:
 
 	movq	%rcx, %r11
 	call	swap_pages
@@ -195,7 +197,7 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	 */
 
 	testq	%r11, %r11
-	jnz 1f
+	jnz relocate
 	xorl	%eax, %eax
 	xorl	%ebx, %ebx
 	xorl    %ecx, %ecx
@@ -216,7 +218,7 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	ret
 	int3
 
-1:
+relocate:
 	popq	%rdx
 	leaq	PAGE_SIZE(%r10), %rsp
 	ANNOTATE_RETPOLINE_SAFE
-- 
2.43.0

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

