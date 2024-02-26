Return-Path: <linux-kernel+bounces-81343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78818867485
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E01F1F25D42
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36308605CE;
	Mon, 26 Feb 2024 12:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g4zDpWCB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HRYiRWH0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE565604BB;
	Mon, 26 Feb 2024 12:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708949570; cv=none; b=UqstpXDSJdad9oz3yi2RCuvTR4Ud/KrvNkvpi7MIga9y3JdsDa5DYLgKhq3BxG97ORnAlA+mpmk3Ek7oPQZ+4Xh/NBThYQK0+YulDr+/sI/uKJg6UvqWPbvJikjSLfc6XkBpgaHfCXwRwOK1dpufhyWSa9pf/XzCGJSbR6hhivo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708949570; c=relaxed/simple;
	bh=fPKA2huygjKpPaXhIEytXpwpJrP0HZn0qRmhERmXfuw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=U8vKbJh5CpGtE3uAjzCkFoddBgQVcFAcEE2mLwBmFdW7/A5Lbt9abVv8h2Y9IfZMn4pDl0H66THlYMQwzGQHwYcucLayuNHj5IG5AyJeBHG5iXF7cFyQYiLcW01WKdHHkJi+dyA0huv2lIbm/hMu+TXZP5t07NwHZMO++ZRzMNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=g4zDpWCB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HRYiRWH0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 26 Feb 2024 12:12:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708949567;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+OBg9ZV/wuOo69DqfiRmpGlAZHe81AT1vWBq75vGgNc=;
	b=g4zDpWCBoymyvLxaofeI7ZNT2fpja/ZdJaYACD3LEi1yYIDewga9gGk4Rtj2zPOhmZrmyS
	SMI8htmchPpY1C0nNuE/0UxOZx4PhcdrsUITkVJ52l8q05gGadt7aZ7abx1a1oXCO7IX7u
	cSkw0vZ4kZlok8UwGj0+AsHtrOj8EmFcglvQ/GukguKgwbX13FaoYmZtdTAVHt6BiJvKDo
	usTrTW8R/PKgrCT1OdGoA5u6b47JP0En4BsK9prL5jt2xM3Lguac/JTayd5QB7MGQvOyVv
	kBaez9vQ2nFw4pK06YgDhLttBpcJvs4IhOAZ73gxDLK4RzF58kmyjAEkZA5sZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708949567;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+OBg9ZV/wuOo69DqfiRmpGlAZHe81AT1vWBq75vGgNc=;
	b=HRYiRWH0cY506RmvDyTSzGJ6hMp9NMv4NNj+PwU547vuOASwTOaXwHF61Vod7QKVXVxXDK
	iC/4bTqRNhXzT/AQ==
From: "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/boot] x86/boot/64: Use RIP_REL_REF() to access early_dynamic_pgts[]
Cc: Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240221113506.2565718-21-ardb+git@google.com>
References: <20240221113506.2565718-21-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170894956625.398.12847281794218073539.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     b0fe5fb6095be0f68b570c4cf4cd86b7e70c2e38
Gitweb:        https://git.kernel.org/tip/b0fe5fb6095be0f68b570c4cf4cd86b7e70c2e38
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Wed, 21 Feb 2024 12:35:10 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 26 Feb 2024 12:58:35 +01:00

x86/boot/64: Use RIP_REL_REF() to access early_dynamic_pgts[]

early_dynamic_pgts[] and next_early_pgt are accessed from code that
executes from a 1:1 mapping so it cannot use a plain access from C.
Replace the use of fixup_pointer() with RIP_REL_REF(), which is better
and simpler.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20240221113506.2565718-21-ardb+git@google.com
---
 arch/x86/kernel/head64.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index f98f5b6..2ac9041 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -170,6 +170,7 @@ static unsigned long __head sme_postprocess_startup(struct boot_params *bp, pmdv
 unsigned long __head __startup_64(unsigned long physaddr,
 				  struct boot_params *bp)
 {
+	pmd_t (*early_pgts)[PTRS_PER_PMD] = RIP_REL_REF(early_dynamic_pgts);
 	unsigned long load_delta, *p;
 	unsigned long pgtable_flags;
 	pgdval_t *pgd;
@@ -179,7 +180,6 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	pteval_t *mask_ptr;
 	bool la57;
 	int i;
-	unsigned int *next_pgt_ptr;
 
 	la57 = check_la57_support(physaddr);
 
@@ -231,15 +231,14 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	 * it avoids problems around wraparound.
 	 */
 
-	next_pgt_ptr = fixup_pointer(&next_early_pgt, physaddr);
-	pud = fixup_pointer(early_dynamic_pgts[(*next_pgt_ptr)++], physaddr);
-	pmd = fixup_pointer(early_dynamic_pgts[(*next_pgt_ptr)++], physaddr);
+	pud = &early_pgts[0]->pmd;
+	pmd = &early_pgts[1]->pmd;
+	RIP_REL_REF(next_early_pgt) = 2;
 
 	pgtable_flags = _KERNPG_TABLE_NOENC + sme_get_me_mask();
 
 	if (la57) {
-		p4d = fixup_pointer(early_dynamic_pgts[(*next_pgt_ptr)++],
-				    physaddr);
+		p4d = &early_pgts[RIP_REL_REF(next_early_pgt)++]->pmd;
 
 		i = (physaddr >> PGDIR_SHIFT) % PTRS_PER_PGD;
 		pgd[i + 0] = (pgdval_t)p4d + pgtable_flags;

