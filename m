Return-Path: <linux-kernel+bounces-112576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB43887B9F
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 05:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A479B214B1
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 04:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63559D529;
	Sun, 24 Mar 2024 04:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VmG0gHY/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WbfZey8f"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F46DCA64;
	Sun, 24 Mar 2024 04:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711253145; cv=none; b=WZmudFLkxBF6V/4sRRzqduArrquw01ukTfRcN8W3XLgNLi5QAwdZjR1Igc1DtFfqajIVQwMknMr8zjouP0y0nSe/daon8hpLDU2Mv6AW8oDplJoJh32aUZXHQ8NAIdzTCITWBlXtjQ2RzKUzgIDHgLNPQya7Wv13CkYnEZ3bCXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711253145; c=relaxed/simple;
	bh=19WVM7p9d80zG/AlQMtsc9lvV5V3bhcDGDATJ6nPvlo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gptwnqUd5AIpslax9rjT2HmOou6cwmz1c1/RQMnXFnNNDdqJlF68LKxPDC5Z65iopJxC9s3Pv0iegfajXJlXFKtv9GT7kopgErmwDDSQ/o1trdnRdqeKEPOH/y9eDqEPp/vf+uzz3lsPZ6HB7azedjJvCe3TPlZBB0clqpPAqTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VmG0gHY/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WbfZey8f; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 24 Mar 2024 04:05:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711253141;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JUz36q8gtZbBtBDKU6NROEkaNl63XsflXYuh24ZYpdo=;
	b=VmG0gHY/02exuPj6y/cFuQ0NjLPuxa0v0GzZFjSQ1uXcFQOXgNwmCzaXhwGlLMC6O0gMC7
	qVXoexJAgBDXGtODH9I3uHI9Xm7K0cGxaMZOkBt5R4Kpfu2cLMZrBDcnTy7ZjqsukA6l57
	n3HqW80UkY6GAagUzQxpIQ9JPOyY4r5lkaQgqDry2lUjtRP5Yb1kXEj+oliySABDj5+rFa
	9dE8me+MEOt4T7V1P0WZw4gPb6CgCjgOeUI4HvB9Ato4qeXhZ4vHKqYQfiT3thyh0I3E+G
	onHC2tMT5LFVk9Sqj56l809OJEUVhwSgVnvE1ESMiuaFyDPuQypXMWsjape02Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711253141;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JUz36q8gtZbBtBDKU6NROEkaNl63XsflXYuh24ZYpdo=;
	b=WbfZey8ferf9EVA/3U3ii71pN1zV5l/KcGCCjFhzVI4wkhEqEZArf8xqlpmAhMlIyebtYv
	nIgzG7LnM8p+60CQ==
From: "tip-bot2 for Tom Lendacky" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/boot/64: Move 5-level paging global variable
 assignments back
Cc: Tom Lendacky <thomas.lendacky@amd.com>, Ingo Molnar <mingo@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C2ca419f4d0de719926fd82353f6751f717590a86=2E17111?=
 =?utf-8?q?22067=2Egit=2Ethomas=2Elendacky=40amd=2Ecom=3E?=
References: =?utf-8?q?=3C2ca419f4d0de719926fd82353f6751f717590a86=2E171112?=
 =?utf-8?q?2067=2Egit=2Ethomas=2Elendacky=40amd=2Ecom=3E?=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171125314044.10875.2422716562716045294.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     9843231c97267d72be38a0409f5097987bc2cfa4
Gitweb:        https://git.kernel.org/tip/9843231c97267d72be38a0409f5097987bc2cfa4
Author:        Tom Lendacky <thomas.lendacky@amd.com>
AuthorDate:    Fri, 22 Mar 2024 10:41:07 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 24 Mar 2024 05:00:36 +01:00

x86/boot/64: Move 5-level paging global variable assignments back

Commit 63bed9660420 ("x86/startup_64: Defer assignment of 5-level paging
global variables") moved assignment of 5-level global variables to later
in the boot in order to avoid having to use RIP relative addressing in
order to set them. However, when running with 5-level paging and SME
active (mem_encrypt=on), the variables are needed as part of the page
table setup needed to encrypt the kernel (using pgd_none(), p4d_offset(),
etc.). Since the variables haven't been set, the page table manipulation
is done as if 4-level paging is active, causing the system to crash on
boot.

While only a subset of the assignments that were moved need to be set
early, move all of the assignments back into check_la57_support() so that
these assignments aren't spread between two locations. Instead of just
reverting the fix, this uses the new RIP_REL_REF() macro when assigning
the variables.

Fixes: 63bed9660420 ("x86/startup_64: Defer assignment of 5-level paging global variables")
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Link: https://lore.kernel.org/r/2ca419f4d0de719926fd82353f6751f717590a86.1711122067.git.thomas.lendacky@amd.com
---
 arch/x86/kernel/head64.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 7d2eb03..a817ed0 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -81,6 +81,13 @@ static inline bool check_la57_support(void)
 	if (!(native_read_cr4() & X86_CR4_LA57))
 		return false;
 
+	RIP_REL_REF(__pgtable_l5_enabled)	= 1;
+	RIP_REL_REF(pgdir_shift)		= 48;
+	RIP_REL_REF(ptrs_per_p4d)		= 512;
+	RIP_REL_REF(page_offset_base)		= __PAGE_OFFSET_BASE_L5;
+	RIP_REL_REF(vmalloc_base)		= __VMALLOC_BASE_L5;
+	RIP_REL_REF(vmemmap_base)		= __VMEMMAP_BASE_L5;
+
 	return true;
 }
 
@@ -431,15 +438,6 @@ asmlinkage __visible void __init __noreturn x86_64_start_kernel(char * real_mode
 				(__START_KERNEL & PGDIR_MASK)));
 	BUILD_BUG_ON(__fix_to_virt(__end_of_fixed_addresses) <= MODULES_END);
 
-	if (check_la57_support()) {
-		__pgtable_l5_enabled	= 1;
-		pgdir_shift		= 48;
-		ptrs_per_p4d		= 512;
-		page_offset_base	= __PAGE_OFFSET_BASE_L5;
-		vmalloc_base		= __VMALLOC_BASE_L5;
-		vmemmap_base		= __VMEMMAP_BASE_L5;
-	}
-
 	cr4_init_shadow();
 
 	/* Kill off the identity-map trampoline */

