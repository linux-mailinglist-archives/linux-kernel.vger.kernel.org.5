Return-Path: <linux-kernel+bounces-81340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 225D8867481
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 891401F2599C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092B1604A5;
	Mon, 26 Feb 2024 12:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a4tGqcC2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UlGKnC9D"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5536027A;
	Mon, 26 Feb 2024 12:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708949568; cv=none; b=BSGvDF3lh+2GaFhroouGCZqeNJTNVQdacWp6HtBXR8knGqbXqBUfpAW2Qq9zd+jcmcH/O1oXJydZzMxzdlXWObry/4VRcxHZPwkgDUw83L58BneZ208gCp8EIyyjs/w21Sh3zHK/V8E3KvCeSGy7p1SPqKg+WZRHye0Cb493WTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708949568; c=relaxed/simple;
	bh=4ZKMwYphcWz971VinC9q87Wl7cds6VXuBagZvOlWPLA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=sNyCcRq7a0LSgKjsNz6pULEfXKwIwT8PXqZ6Vy1xrodTqOOb/nxXe1HPITBZ1W+pmsRQ83TuFzB3r3K81M5eWAEBjvS+cYOU2Iw8cOnYPDqXxA3Dy5chUSoiALq3JBpcIcaLbhXQRlpG7p00z7c2JK3Pxjxd30XhLuQYZ4jx5Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a4tGqcC2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UlGKnC9D; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 26 Feb 2024 12:12:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708949564;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Iq+ogLh8TX0YQAgI5lDBWJMTtu+UflACEgVMn43qzrU=;
	b=a4tGqcC2ge15/pvzlBRUhMYIKHfjbUGx6j98klTqQ9pqJZokOmLTWRNaDpbhy3a7DzaXNX
	uT6YQUnboFH4H/Y0BSvvM93ESsNUpaXOD0RtbaI6rr1VvT1Aw57P6n8bwpFkX43fUQdW6C
	XAbcmT7TDEpoXNghO1PEhi8jwewxpsDtdIOv6PpjzTurLVx0bYfjH6YMeO1UwVs36EGB5P
	DrIwD48xDfepA+bwPiM3gjYrW6Tv6TIb/USUDombmH+0ZoKK098qF/TubgkTthFwKnXCVj
	0phIfM4rMk2kAgsvJcV67TgOu5yPsncmjIRvGZ9xEyL/4Pd19K3gcVlM6XsfpQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708949564;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Iq+ogLh8TX0YQAgI5lDBWJMTtu+UflACEgVMn43qzrU=;
	b=UlGKnC9DlXbio+4mC+BFPTPvLXIFa9W6l+DX6s/jBxUUczEx3aEXNQZx7s0AisKsTepWZL
	PmVXszPSZuhPH8CA==
From: "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/boot] x86/boot/64: Use RIP_REL_REF() to access early_top_pgt[]
Cc: Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240221113506.2565718-24-ardb+git@google.com>
References: <20240221113506.2565718-24-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170894956346.398.13084602429251023088.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     533568e06b157b175912a960efe5ebce8710b4f9
Gitweb:        https://git.kernel.org/tip/533568e06b157b175912a960efe5ebce8710b4f9
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Wed, 21 Feb 2024 12:35:13 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 26 Feb 2024 12:58:35 +01:00

x86/boot/64: Use RIP_REL_REF() to access early_top_pgt[]

early_top_pgt[] is assigned from code that executes from a 1:1 mapping
so it cannot use a plain access from C. Replace the use of
fixup_pointer() with RIP_REL_REF(), which is better and simpler.

For legibility and to align with the code that populates the lower page
table levels, statically initialize the root level page table with an
entry pointing to level3_kernel_pgt[], and overwrite it when needed to
enable 5-level paging.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20240221113506.2565718-24-ardb+git@google.com
---
 arch/x86/kernel/head64.c  | 21 +++++++++------------
 arch/x86/kernel/head_64.S |  3 ++-
 2 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 7e2c9b5..72351c3 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -77,6 +77,7 @@ static struct desc_struct startup_gdt[GDT_ENTRIES] __initdata = {
 	[GDT_ENTRY_KERNEL_DS]           = GDT_ENTRY_INIT(DESC_DATA64, 0, 0xfffff),
 };
 
+#ifdef CONFIG_X86_5LEVEL
 static void __head *fixup_pointer(void *ptr, unsigned long physaddr)
 {
 	return ptr - (void *)_text + (void *)physaddr;
@@ -87,7 +88,6 @@ static unsigned long __head *fixup_long(void *ptr, unsigned long physaddr)
 	return fixup_pointer(ptr, physaddr);
 }
 
-#ifdef CONFIG_X86_5LEVEL
 static unsigned int __head *fixup_int(void *ptr, unsigned long physaddr)
 {
 	return fixup_pointer(ptr, physaddr);
@@ -165,14 +165,14 @@ static unsigned long __head sme_postprocess_startup(struct boot_params *bp, pmdv
  * doesn't have to generate PC-relative relocations when accessing globals from
  * that function. Clang actually does not generate them, which leads to
  * boot-time crashes. To work around this problem, every global pointer must
- * be adjusted using fixup_pointer().
+ * be accessed using RIP_REL_REF().
  */
 unsigned long __head __startup_64(unsigned long physaddr,
 				  struct boot_params *bp)
 {
 	pmd_t (*early_pgts)[PTRS_PER_PMD] = RIP_REL_REF(early_dynamic_pgts);
-	unsigned long load_delta, *p;
 	unsigned long pgtable_flags;
+	unsigned long load_delta;
 	pgdval_t *pgd;
 	p4dval_t *p4d;
 	pudval_t *pud;
@@ -202,17 +202,14 @@ unsigned long __head __startup_64(unsigned long physaddr,
 
 	/* Fixup the physical addresses in the page table */
 
-	pgd = fixup_pointer(early_top_pgt, physaddr);
-	p = pgd + pgd_index(__START_KERNEL_map);
-	if (la57)
-		*p = (unsigned long)level4_kernel_pgt;
-	else
-		*p = (unsigned long)level3_kernel_pgt;
-	*p += _PAGE_TABLE_NOENC - __START_KERNEL_map + load_delta;
+	pgd = &RIP_REL_REF(early_top_pgt)->pgd;
+	pgd[pgd_index(__START_KERNEL_map)] += load_delta;
 
 	if (la57) {
-		p4d = fixup_pointer(level4_kernel_pgt, physaddr);
-		p4d[511] += load_delta;
+		p4d = (p4dval_t *)&RIP_REL_REF(level4_kernel_pgt);
+		p4d[MAX_PTRS_PER_P4D - 1] += load_delta;
+
+		pgd[pgd_index(__START_KERNEL_map)] = (pgdval_t)p4d | _PAGE_TABLE_NOENC;
 	}
 
 	RIP_REL_REF(level3_kernel_pgt)[PTRS_PER_PUD - 2].pud += load_delta;
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index e09cf0b..d295bf6 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -624,7 +624,8 @@ SYM_CODE_END(vc_no_ghcb)
 	.balign 4
 
 SYM_DATA_START_PTI_ALIGNED(early_top_pgt)
-	.fill	512,8,0
+	.fill	511,8,0
+	.quad	level3_kernel_pgt - __START_KERNEL_map + _PAGE_TABLE_NOENC
 	.fill	PTI_USER_PGD_FILL,8,0
 SYM_DATA_END(early_top_pgt)
 

