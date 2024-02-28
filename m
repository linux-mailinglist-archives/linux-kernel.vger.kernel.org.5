Return-Path: <linux-kernel+bounces-84815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59EC786ABEE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15C5B28C7B9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 10:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F0F3770C;
	Wed, 28 Feb 2024 10:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="K/Uz8Rwr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t6X1lfYr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AF8376EC;
	Wed, 28 Feb 2024 10:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709115091; cv=none; b=KMRRBqQ2cmU9nZ/uhq95UiE/iA8wo9/4jTaST/V2eoJvi7F66rswAZSBEKxnkPqAXy+AJ7eDnL9b+72U7yQmmFZ+ktZF4xqa54twRb7WTygqBq5gbM/QVCMM97ZK3sHavdRCWpsilLf8+jwjcUFx0wKTGXuonmo97VQdf2ha6V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709115091; c=relaxed/simple;
	bh=d0/GW9Hlrkhgj4xitNTIzREyL/IrPHq2WBsSG7+jrKw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=uKNktQoTHCB+x9GQtA5t+H4bqeJdI9dfbvDZjHKfLPRJQqtgA9+jZrtIEXJt3gJo46NOLw76n3Z0pZVQUvQTTSj8TApVhSkqr/ZY5I2rprqN5YEcGD1ESjqbCTnl8wk0dpdq5KsM7WyqNFSELEDGvosGhiyNiFxDkTTvHoV8VbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=K/Uz8Rwr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t6X1lfYr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 28 Feb 2024 10:11:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709115087;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LrnkpejSqhcF9JYa98EHYfWHPhb164YL0Ul7jes8SbM=;
	b=K/Uz8Rwr/Esb6voUMNiHQ6suEIiffe4TiDxZLjHEKaqA0q7cDLFg9acVB2U74aBI7c3uLi
	W7b2qgqUOBb92MVJUJnqo9MbuVmZJOX5cYw7rf3L19vI+aqJSzK9QpjBu4KMo///DKvLF0
	UnKWBK4v83qaeeHe1AskZSIKhUp/DzGTgFeRgRFGF47Mw4YCEewCPddtb57nZlubAEn3et
	JEx5PCWwgw4yR2T3Mfu6J7LJYK32p6VrkOK5/oU22ktYXP/pLisctL79vwc5SGeH75/ZuY
	qK6oNgL+t/DPTqHAEuilocT8N0G6c2DQRjvNkF1T9krS+ypdNoyoArkoQzbonQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709115087;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LrnkpejSqhcF9JYa98EHYfWHPhb164YL0Ul7jes8SbM=;
	b=t6X1lfYr1CyDvUik5ZfFl2tSAkXtSxPtNC3mD1vxl9OfSnVZ+BwtGiItI87WhXTzz8iC0p
	spcMcMqnNU4FbVCg==
From: "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot/64: Load the final kernel GDT during early
 boot directly, remove startup_gdt[]
Cc: Brian Gerst <brgerst@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>, Kees Cook <keescook@chromium.org>,
 Andy Lutomirski <luto@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Josh Poimboeuf <jpoimboe@redhat.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240226220544.70769-1-brgerst@gmail.com>
References: <20240226220544.70769-1-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170911508625.398.12452118843438429976.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     11e36b0f7c2150a6453872b79555767b43c846d0
Gitweb:        https://git.kernel.org/tip/11e36b0f7c2150a6453872b79555767b43c846d0
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Mon, 26 Feb 2024 17:05:44 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 28 Feb 2024 11:02:16 +01:00

x86/boot/64: Load the final kernel GDT during early boot directly, remove startup_gdt[]

Instead of loading a duplicate GDT just for early boot, load the kernel
GDT from its physical address.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20240226220544.70769-1-brgerst@gmail.com
---
 arch/x86/include/asm/desc.h |  1 +
 arch/x86/kernel/head64.c    | 13 ++-----------
 2 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/desc.h b/arch/x86/include/asm/desc.h
index ab97b22..52c0150 100644
--- a/arch/x86/include/asm/desc.h
+++ b/arch/x86/include/asm/desc.h
@@ -46,6 +46,7 @@ struct gdt_page {
 } __attribute__((aligned(PAGE_SIZE)));
 
 DECLARE_PER_CPU_PAGE_ALIGNED(struct gdt_page, gdt_page);
+DECLARE_INIT_PER_CPU(gdt_page);
 
 /* Provide the original GDT */
 static inline struct desc_struct *get_cpu_gdt_rw(unsigned int cpu)
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 72351c3..fd77a26 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -68,15 +68,6 @@ unsigned long vmemmap_base __ro_after_init = __VMEMMAP_BASE_L4;
 EXPORT_SYMBOL(vmemmap_base);
 #endif
 
-/*
- * GDT used on the boot CPU before switching to virtual addresses.
- */
-static struct desc_struct startup_gdt[GDT_ENTRIES] __initdata = {
-	[GDT_ENTRY_KERNEL32_CS]         = GDT_ENTRY_INIT(DESC_CODE32, 0, 0xfffff),
-	[GDT_ENTRY_KERNEL_CS]           = GDT_ENTRY_INIT(DESC_CODE64, 0, 0xfffff),
-	[GDT_ENTRY_KERNEL_DS]           = GDT_ENTRY_INIT(DESC_DATA64, 0, 0xfffff),
-};
-
 #ifdef CONFIG_X86_5LEVEL
 static void __head *fixup_pointer(void *ptr, unsigned long physaddr)
 {
@@ -589,8 +580,8 @@ void __head startup_64_setup_gdt_idt(void)
 	void *handler = NULL;
 
 	struct desc_ptr startup_gdt_descr = {
-		.address = (unsigned long)&RIP_REL_REF(startup_gdt),
-		.size    = sizeof(startup_gdt) - 1,
+		.address = (unsigned long)&RIP_REL_REF(init_per_cpu_var(gdt_page.gdt)),
+		.size    = GDT_SIZE - 1,
 	};
 
 	/* Load GDT */

