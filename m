Return-Path: <linux-kernel+bounces-6685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE5B819C13
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F320B1F21903
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4125821370;
	Wed, 20 Dec 2023 10:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Df/ktfVZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qAE9+yGC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0DB20B1D;
	Wed, 20 Dec 2023 10:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 20 Dec 2023 10:04:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1703066641;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1NQst+VHifrVkSDrISNwkDvKh+Nr0RWNByBHjKD+YH4=;
	b=Df/ktfVZ+8jmmpkt0QKbp24GM2H1bSsCgLNeO3CCAArjkKmXlAq4XvDzn3ehUIjmBni3fO
	fcnXO5BWrd5LYgxP2TaG9nfqMUeL95qQXvpzjMG/Mgc1JZFrIHvNtJMUVZPtqBXVi4ogTl
	Rfikg6WHrpS/oeNk46z1Ma5Cc0uPQ1q4FVIJgm3QTpW1xbRV0zWjUQEL4Mo/p5eyZdDpWU
	mg8r4b7UpqVfMSEjkquO57MTgz0s3588N7q+YaoI3FCWLgUyyK26TRCs+dy2eJh7vmnM85
	GF2FeH2umw/+4oNlpGzeBmEZr7bn8uq22Od1y/QuzVyjB11tlv78CFv0LuTuXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1703066641;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1NQst+VHifrVkSDrISNwkDvKh+Nr0RWNByBHjKD+YH4=;
	b=qAE9+yGCyQFuv3vmBsOT3RSxtLOqYh+ON6I9r+VgMqfHpYNYvNLIV+owe1OhL5FQJVFMOr
	5dq7LDHD6tbSRPAg==
From: "tip-bot2 for Vegard Nossum" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/asm] x86/asm: Always set A (accessed) flag in GDT descriptors
Cc: Vegard Nossum <vegard.nossum@oracle.com>, Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20231219151200.2878271-5-vegard.nossum@oracle.com>
References: <20231219151200.2878271-5-vegard.nossum@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170306664044.398.8301222392360848816.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     3b184b71dfcb156e08246f8fbe0cd088c6a6efed
Gitweb:        https://git.kernel.org/tip/3b184b71dfcb156e08246f8fbe0cd088c6a6efed
Author:        Vegard Nossum <vegard.nossum@oracle.com>
AuthorDate:    Tue, 19 Dec 2023 16:11:59 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 20 Dec 2023 10:57:51 +01:00

x86/asm: Always set A (accessed) flag in GDT descriptors

We have no known use for having the CPU track whether GDT descriptors
have been accessed or not.

Simplify the code by adding the flag to the common flags and removing
it everywhere else.

Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20231219151200.2878271-5-vegard.nossum@oracle.com
---
 arch/x86/boot/pm.c                      |  4 ++--
 arch/x86/include/asm/desc_defs.h        |  4 ++--
 arch/x86/kernel/cpu/common.c            | 12 ++++++------
 arch/x86/kernel/head64.c                |  6 +++---
 arch/x86/realmode/rm/reboot.S           |  2 +-
 drivers/firmware/efi/libstub/x86-5lvl.c |  4 ++--
 6 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/x86/boot/pm.c b/arch/x86/boot/pm.c
index ab35b52..5941f93 100644
--- a/arch/x86/boot/pm.c
+++ b/arch/x86/boot/pm.c
@@ -68,9 +68,9 @@ static void setup_gdt(void)
 	   being 8-byte unaligned.  Intel recommends 16 byte alignment. */
 	static const u64 boot_gdt[] __attribute__((aligned(16))) = {
 		/* CS: code, read/execute, 4 GB, base 0 */
-		[GDT_ENTRY_BOOT_CS] = GDT_ENTRY(DESC_CODE32 | _DESC_ACCESSED, 0, 0xfffff),
+		[GDT_ENTRY_BOOT_CS] = GDT_ENTRY(DESC_CODE32, 0, 0xfffff),
 		/* DS: data, read/write, 4 GB, base 0 */
-		[GDT_ENTRY_BOOT_DS] = GDT_ENTRY(DESC_DATA32 | _DESC_ACCESSED, 0, 0xfffff),
+		[GDT_ENTRY_BOOT_DS] = GDT_ENTRY(DESC_DATA32, 0, 0xfffff),
 		/* TSS: 32-bit tss, 104 bytes, base 4096 */
 		/* We only have a TSS here to keep Intel VT happy;
 		   we don't actually use it for anything. */
diff --git a/arch/x86/include/asm/desc_defs.h b/arch/x86/include/asm/desc_defs.h
index 33d229e..d440a65 100644
--- a/arch/x86/include/asm/desc_defs.h
+++ b/arch/x86/include/asm/desc_defs.h
@@ -37,9 +37,9 @@
  * of flags
  */
 
-#define _DESC_DATA		(_DESC_S | _DESC_PRESENT | \
+#define _DESC_DATA		(_DESC_S | _DESC_PRESENT | _DESC_ACCESSED | \
 				 _DESC_DATA_WRITABLE)
-#define _DESC_CODE		(_DESC_S | _DESC_PRESENT | \
+#define _DESC_CODE		(_DESC_S | _DESC_PRESENT | _DESC_ACCESSED | \
 				 _DESC_CODE_READABLE | _DESC_CODE_EXECUTABLE)
 
 #define DESC_DATA16		(_DESC_DATA)
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 32934a0..6184488 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -188,12 +188,12 @@ DEFINE_PER_CPU_PAGE_ALIGNED(struct gdt_page, gdt_page) = { .gdt = {
 	 * TLS descriptors are currently at a different place compared to i386.
 	 * Hopefully nobody expects them at a fixed place (Wine?)
 	 */
-	[GDT_ENTRY_KERNEL32_CS]		= GDT_ENTRY_INIT(DESC_CODE32 | _DESC_ACCESSED, 0, 0xfffff),
-	[GDT_ENTRY_KERNEL_CS]		= GDT_ENTRY_INIT(DESC_CODE64 | _DESC_ACCESSED, 0, 0xfffff),
-	[GDT_ENTRY_KERNEL_DS]		= GDT_ENTRY_INIT(DESC_DATA64 | _DESC_ACCESSED, 0, 0xfffff),
-	[GDT_ENTRY_DEFAULT_USER32_CS]	= GDT_ENTRY_INIT(DESC_CODE32 | DESC_USER | _DESC_ACCESSED, 0, 0xfffff),
-	[GDT_ENTRY_DEFAULT_USER_DS]	= GDT_ENTRY_INIT(DESC_DATA64 | DESC_USER | _DESC_ACCESSED, 0, 0xfffff),
-	[GDT_ENTRY_DEFAULT_USER_CS]	= GDT_ENTRY_INIT(DESC_CODE64 | DESC_USER | _DESC_ACCESSED, 0, 0xfffff),
+	[GDT_ENTRY_KERNEL32_CS]		= GDT_ENTRY_INIT(DESC_CODE32, 0, 0xfffff),
+	[GDT_ENTRY_KERNEL_CS]		= GDT_ENTRY_INIT(DESC_CODE64, 0, 0xfffff),
+	[GDT_ENTRY_KERNEL_DS]		= GDT_ENTRY_INIT(DESC_DATA64, 0, 0xfffff),
+	[GDT_ENTRY_DEFAULT_USER32_CS]	= GDT_ENTRY_INIT(DESC_CODE32 | DESC_USER, 0, 0xfffff),
+	[GDT_ENTRY_DEFAULT_USER_DS]	= GDT_ENTRY_INIT(DESC_DATA64 | DESC_USER, 0, 0xfffff),
+	[GDT_ENTRY_DEFAULT_USER_CS]	= GDT_ENTRY_INIT(DESC_CODE64 | DESC_USER, 0, 0xfffff),
 #else
 	[GDT_ENTRY_KERNEL_CS]		= GDT_ENTRY_INIT(DESC_CODE32, 0, 0xfffff),
 	[GDT_ENTRY_KERNEL_DS]		= GDT_ENTRY_INIT(DESC_DATA32, 0, 0xfffff),
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 00dbddf..dc09560 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -71,9 +71,9 @@ EXPORT_SYMBOL(vmemmap_base);
  * GDT used on the boot CPU before switching to virtual addresses.
  */
 static struct desc_struct startup_gdt[GDT_ENTRIES] __initdata = {
-	[GDT_ENTRY_KERNEL32_CS]         = GDT_ENTRY_INIT(DESC_CODE32 | _DESC_ACCESSED, 0, 0xfffff),
-	[GDT_ENTRY_KERNEL_CS]           = GDT_ENTRY_INIT(DESC_CODE64 | _DESC_ACCESSED, 0, 0xfffff),
-	[GDT_ENTRY_KERNEL_DS]           = GDT_ENTRY_INIT(DESC_DATA64 | _DESC_ACCESSED, 0, 0xfffff),
+	[GDT_ENTRY_KERNEL32_CS]         = GDT_ENTRY_INIT(DESC_CODE32, 0, 0xfffff),
+	[GDT_ENTRY_KERNEL_CS]           = GDT_ENTRY_INIT(DESC_CODE64, 0, 0xfffff),
+	[GDT_ENTRY_KERNEL_DS]           = GDT_ENTRY_INIT(DESC_DATA64, 0, 0xfffff),
 };
 
 /*
diff --git a/arch/x86/realmode/rm/reboot.S b/arch/x86/realmode/rm/reboot.S
index 5bc068b..e714b46 100644
--- a/arch/x86/realmode/rm/reboot.S
+++ b/arch/x86/realmode/rm/reboot.S
@@ -154,5 +154,5 @@ SYM_DATA_START(machine_real_restart_gdt)
 	 * base value 0x100; since this is consistent with real mode
 	 * semantics we don't have to reload the segments once CR0.PE = 0.
 	 */
-	.quad	GDT_ENTRY(DESC_DATA16 | _DESC_ACCESSED, 0x100, 0xffff)
+	.quad	GDT_ENTRY(DESC_DATA16, 0x100, 0xffff)
 SYM_DATA_END(machine_real_restart_gdt)
diff --git a/drivers/firmware/efi/libstub/x86-5lvl.c b/drivers/firmware/efi/libstub/x86-5lvl.c
index 005dd9b..77359e8 100644
--- a/drivers/firmware/efi/libstub/x86-5lvl.c
+++ b/drivers/firmware/efi/libstub/x86-5lvl.c
@@ -13,8 +13,8 @@ bool efi_no5lvl;
 static void (*la57_toggle)(void *cr3);
 
 static const struct desc_struct gdt[] = {
-	[GDT_ENTRY_KERNEL32_CS] = GDT_ENTRY_INIT(DESC_CODE32 | _DESC_ACCESSED, 0, 0xfffff),
-	[GDT_ENTRY_KERNEL_CS]   = GDT_ENTRY_INIT(DESC_CODE64 | _DESC_ACCESSED, 0, 0xfffff),
+	[GDT_ENTRY_KERNEL32_CS] = GDT_ENTRY_INIT(DESC_CODE32, 0, 0xfffff),
+	[GDT_ENTRY_KERNEL_CS]   = GDT_ENTRY_INIT(DESC_CODE64, 0, 0xfffff),
 };
 
 /*

