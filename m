Return-Path: <linux-kernel+bounces-6686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 526A6819C16
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:06:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0FB1B22060
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C78D22307;
	Wed, 20 Dec 2023 10:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1xe6fugL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="98BhiORo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38B920DE9;
	Wed, 20 Dec 2023 10:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 20 Dec 2023 10:04:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1703066641;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7l+kI/MaX2pTjXsS7WAPRTstvdU7wkT2C6vNs/zP6Eg=;
	b=1xe6fugLmLhkekhWOqPTlKw3XMtuQtxJOaMVRhz7qW2tNxLmNSHZ1B5icTu7dhsG4WO05B
	PukCo4oyWuNyN6/k/kiBplnSLyF11A+Gm5YyvSkBWrxnBaCK2/Dr7jKXPxv6Vw0ez4vVXg
	0WfzfSNSYZElZuDXauTh/8MiLuF6nesNMTXR1RgQyfEkJBkybW5cPpes84jV1e+k9OAQ8O
	osCK1Gh8r6OKyKUk9qBHN3nySoeuDj5ctMHeLad3h7d1ZuaidfdQocE5P41s6HXibKIT8z
	0jQVU9yxs/OIZxMyaobzJ7ZDTue3078YVPw2dIlMGu4l78sI2wcNjF/rbmw/fw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1703066641;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7l+kI/MaX2pTjXsS7WAPRTstvdU7wkT2C6vNs/zP6Eg=;
	b=98BhiORoBbVpikVFu/rPHuw3m4y/eNWafzuzncckxQ226TXqNFcdEGsDwohuveI+C6RWvl
	r8oyDAHyFeEHmSDQ==
From: "tip-bot2 for Vegard Nossum" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/asm: Replace magic numbers in GDT descriptors,
 script-generated change
Cc: Vegard Nossum <vegard.nossum@oracle.com>, Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20231219151200.2878271-4-vegard.nossum@oracle.com>
References: <20231219151200.2878271-4-vegard.nossum@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170306664104.398.11166745636415902530.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     1445f6e15f7ddd80311307475191e34c0b2312e8
Gitweb:        https://git.kernel.org/tip/1445f6e15f7ddd80311307475191e34c0b2312e8
Author:        Vegard Nossum <vegard.nossum@oracle.com>
AuthorDate:    Tue, 19 Dec 2023 16:11:58 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 20 Dec 2023 10:57:38 +01:00

x86/asm: Replace magic numbers in GDT descriptors, script-generated change

Actually replace the numeric values by the new symbolic values.

I used this to find all the existing users of the GDT_ENTRY*() macros:

  $ git grep -P 'GDT_ENTRY(_INIT)?\('

Some of the lines will exceed 80 characters, but some of them will be
shorter again in the next couple of patches.

Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20231219151200.2878271-4-vegard.nossum@oracle.com
---
 arch/x86/boot/pm.c                      |  6 ++--
 arch/x86/kernel/apm_32.c                |  2 +-
 arch/x86/kernel/cpu/common.c            | 40 ++++++++++++------------
 arch/x86/kernel/head64.c                |  6 ++--
 arch/x86/kernel/setup_percpu.c          |  4 +-
 arch/x86/platform/pvh/head.S            |  6 ++--
 arch/x86/realmode/rm/reboot.S           |  2 +-
 drivers/firmware/efi/libstub/x86-5lvl.c |  4 +-
 drivers/pnp/pnpbios/bioscalls.c         |  2 +-
 9 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/arch/x86/boot/pm.c b/arch/x86/boot/pm.c
index 0361b53..ab35b52 100644
--- a/arch/x86/boot/pm.c
+++ b/arch/x86/boot/pm.c
@@ -68,13 +68,13 @@ static void setup_gdt(void)
 	   being 8-byte unaligned.  Intel recommends 16 byte alignment. */
 	static const u64 boot_gdt[] __attribute__((aligned(16))) = {
 		/* CS: code, read/execute, 4 GB, base 0 */
-		[GDT_ENTRY_BOOT_CS] = GDT_ENTRY(0xc09b, 0, 0xfffff),
+		[GDT_ENTRY_BOOT_CS] = GDT_ENTRY(DESC_CODE32 | _DESC_ACCESSED, 0, 0xfffff),
 		/* DS: data, read/write, 4 GB, base 0 */
-		[GDT_ENTRY_BOOT_DS] = GDT_ENTRY(0xc093, 0, 0xfffff),
+		[GDT_ENTRY_BOOT_DS] = GDT_ENTRY(DESC_DATA32 | _DESC_ACCESSED, 0, 0xfffff),
 		/* TSS: 32-bit tss, 104 bytes, base 4096 */
 		/* We only have a TSS here to keep Intel VT happy;
 		   we don't actually use it for anything. */
-		[GDT_ENTRY_BOOT_TSS] = GDT_ENTRY(0x0089, 4096, 103),
+		[GDT_ENTRY_BOOT_TSS] = GDT_ENTRY(DESC_TSS32, 4096, 103),
 	};
 	/* Xen HVM incorrectly stores a pointer to the gdt_ptr, instead
 	   of the gdt_ptr contents.  Thus, make it static so it will
diff --git a/arch/x86/kernel/apm_32.c b/arch/x86/kernel/apm_32.c
index 5934ee5..76a5ced 100644
--- a/arch/x86/kernel/apm_32.c
+++ b/arch/x86/kernel/apm_32.c
@@ -420,7 +420,7 @@ static DEFINE_MUTEX(apm_mutex);
  * This is for buggy BIOS's that refer to (real mode) segment 0x40
  * even though they are called in protected mode.
  */
-static struct desc_struct bad_bios_desc = GDT_ENTRY_INIT(0x4092,
+static struct desc_struct bad_bios_desc = GDT_ENTRY_INIT(DESC_DATA32_BIOS,
 			(unsigned long)__va(0x400UL), PAGE_SIZE - 0x400 - 1);
 
 static const char driver_version[] = "1.16ac";	/* no spaces */
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index ceb6e4b..32934a0 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -188,37 +188,37 @@ DEFINE_PER_CPU_PAGE_ALIGNED(struct gdt_page, gdt_page) = { .gdt = {
 	 * TLS descriptors are currently at a different place compared to i386.
 	 * Hopefully nobody expects them at a fixed place (Wine?)
 	 */
-	[GDT_ENTRY_KERNEL32_CS]		= GDT_ENTRY_INIT(0xc09b, 0, 0xfffff),
-	[GDT_ENTRY_KERNEL_CS]		= GDT_ENTRY_INIT(0xa09b, 0, 0xfffff),
-	[GDT_ENTRY_KERNEL_DS]		= GDT_ENTRY_INIT(0xc093, 0, 0xfffff),
-	[GDT_ENTRY_DEFAULT_USER32_CS]	= GDT_ENTRY_INIT(0xc0fb, 0, 0xfffff),
-	[GDT_ENTRY_DEFAULT_USER_DS]	= GDT_ENTRY_INIT(0xc0f3, 0, 0xfffff),
-	[GDT_ENTRY_DEFAULT_USER_CS]	= GDT_ENTRY_INIT(0xa0fb, 0, 0xfffff),
+	[GDT_ENTRY_KERNEL32_CS]		= GDT_ENTRY_INIT(DESC_CODE32 | _DESC_ACCESSED, 0, 0xfffff),
+	[GDT_ENTRY_KERNEL_CS]		= GDT_ENTRY_INIT(DESC_CODE64 | _DESC_ACCESSED, 0, 0xfffff),
+	[GDT_ENTRY_KERNEL_DS]		= GDT_ENTRY_INIT(DESC_DATA64 | _DESC_ACCESSED, 0, 0xfffff),
+	[GDT_ENTRY_DEFAULT_USER32_CS]	= GDT_ENTRY_INIT(DESC_CODE32 | DESC_USER | _DESC_ACCESSED, 0, 0xfffff),
+	[GDT_ENTRY_DEFAULT_USER_DS]	= GDT_ENTRY_INIT(DESC_DATA64 | DESC_USER | _DESC_ACCESSED, 0, 0xfffff),
+	[GDT_ENTRY_DEFAULT_USER_CS]	= GDT_ENTRY_INIT(DESC_CODE64 | DESC_USER | _DESC_ACCESSED, 0, 0xfffff),
 #else
-	[GDT_ENTRY_KERNEL_CS]		= GDT_ENTRY_INIT(0xc09a, 0, 0xfffff),
-	[GDT_ENTRY_KERNEL_DS]		= GDT_ENTRY_INIT(0xc092, 0, 0xfffff),
-	[GDT_ENTRY_DEFAULT_USER_CS]	= GDT_ENTRY_INIT(0xc0fa, 0, 0xfffff),
-	[GDT_ENTRY_DEFAULT_USER_DS]	= GDT_ENTRY_INIT(0xc0f2, 0, 0xfffff),
+	[GDT_ENTRY_KERNEL_CS]		= GDT_ENTRY_INIT(DESC_CODE32, 0, 0xfffff),
+	[GDT_ENTRY_KERNEL_DS]		= GDT_ENTRY_INIT(DESC_DATA32, 0, 0xfffff),
+	[GDT_ENTRY_DEFAULT_USER_CS]	= GDT_ENTRY_INIT(DESC_CODE32 | DESC_USER, 0, 0xfffff),
+	[GDT_ENTRY_DEFAULT_USER_DS]	= GDT_ENTRY_INIT(DESC_DATA32 | DESC_USER, 0, 0xfffff),
 	/*
 	 * Segments used for calling PnP BIOS have byte granularity.
 	 * They code segments and data segments have fixed 64k limits,
 	 * the transfer segment sizes are set at run time.
 	 */
-	[GDT_ENTRY_PNPBIOS_CS32]	= GDT_ENTRY_INIT(0x409a, 0, 0xffff),
-	[GDT_ENTRY_PNPBIOS_CS16]	= GDT_ENTRY_INIT(0x009a, 0, 0xffff),
-	[GDT_ENTRY_PNPBIOS_DS]		= GDT_ENTRY_INIT(0x0092, 0, 0xffff),
-	[GDT_ENTRY_PNPBIOS_TS1]		= GDT_ENTRY_INIT(0x0092, 0, 0),
-	[GDT_ENTRY_PNPBIOS_TS2]		= GDT_ENTRY_INIT(0x0092, 0, 0),
+	[GDT_ENTRY_PNPBIOS_CS32]	= GDT_ENTRY_INIT(DESC_CODE32_BIOS, 0, 0xffff),
+	[GDT_ENTRY_PNPBIOS_CS16]	= GDT_ENTRY_INIT(DESC_CODE16, 0, 0xffff),
+	[GDT_ENTRY_PNPBIOS_DS]		= GDT_ENTRY_INIT(DESC_DATA16, 0, 0xffff),
+	[GDT_ENTRY_PNPBIOS_TS1]		= GDT_ENTRY_INIT(DESC_DATA16, 0, 0),
+	[GDT_ENTRY_PNPBIOS_TS2]		= GDT_ENTRY_INIT(DESC_DATA16, 0, 0),
 	/*
 	 * The APM segments have byte granularity and their bases
 	 * are set at run time.  All have 64k limits.
 	 */
-	[GDT_ENTRY_APMBIOS_BASE]	= GDT_ENTRY_INIT(0x409a, 0, 0xffff),
-	[GDT_ENTRY_APMBIOS_BASE+1]	= GDT_ENTRY_INIT(0x009a, 0, 0xffff),
-	[GDT_ENTRY_APMBIOS_BASE+2]	= GDT_ENTRY_INIT(0x4092, 0, 0xffff),
+	[GDT_ENTRY_APMBIOS_BASE]	= GDT_ENTRY_INIT(DESC_CODE32_BIOS, 0, 0xffff),
+	[GDT_ENTRY_APMBIOS_BASE+1]	= GDT_ENTRY_INIT(DESC_CODE16, 0, 0xffff),
+	[GDT_ENTRY_APMBIOS_BASE+2]	= GDT_ENTRY_INIT(DESC_DATA32_BIOS, 0, 0xffff),
 
-	[GDT_ENTRY_ESPFIX_SS]		= GDT_ENTRY_INIT(0xc092, 0, 0xfffff),
-	[GDT_ENTRY_PERCPU]		= GDT_ENTRY_INIT(0xc092, 0, 0xfffff),
+	[GDT_ENTRY_ESPFIX_SS]		= GDT_ENTRY_INIT(DESC_DATA32, 0, 0xfffff),
+	[GDT_ENTRY_PERCPU]		= GDT_ENTRY_INIT(DESC_DATA32, 0, 0xfffff),
 #endif
 } };
 EXPORT_PER_CPU_SYMBOL_GPL(gdt_page);
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 05a110c..00dbddf 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -71,9 +71,9 @@ EXPORT_SYMBOL(vmemmap_base);
  * GDT used on the boot CPU before switching to virtual addresses.
  */
 static struct desc_struct startup_gdt[GDT_ENTRIES] __initdata = {
-	[GDT_ENTRY_KERNEL32_CS]         = GDT_ENTRY_INIT(0xc09b, 0, 0xfffff),
-	[GDT_ENTRY_KERNEL_CS]           = GDT_ENTRY_INIT(0xa09b, 0, 0xfffff),
-	[GDT_ENTRY_KERNEL_DS]           = GDT_ENTRY_INIT(0xc093, 0, 0xfffff),
+	[GDT_ENTRY_KERNEL32_CS]         = GDT_ENTRY_INIT(DESC_CODE32 | _DESC_ACCESSED, 0, 0xfffff),
+	[GDT_ENTRY_KERNEL_CS]           = GDT_ENTRY_INIT(DESC_CODE64 | _DESC_ACCESSED, 0, 0xfffff),
+	[GDT_ENTRY_KERNEL_DS]           = GDT_ENTRY_INIT(DESC_DATA64 | _DESC_ACCESSED, 0, 0xfffff),
 };
 
 /*
diff --git a/arch/x86/kernel/setup_percpu.c b/arch/x86/kernel/setup_percpu.c
index 2c97bf7..f2583de 100644
--- a/arch/x86/kernel/setup_percpu.c
+++ b/arch/x86/kernel/setup_percpu.c
@@ -106,8 +106,8 @@ void __init pcpu_populate_pte(unsigned long addr)
 static inline void setup_percpu_segment(int cpu)
 {
 #ifdef CONFIG_X86_32
-	struct desc_struct d = GDT_ENTRY_INIT(0x8092, per_cpu_offset(cpu),
-					      0xFFFFF);
+	struct desc_struct d = GDT_ENTRY_INIT(DESC_DATA32 & ~_DESC_DB,
+					      per_cpu_offset(cpu), 0xFFFFF);
 
 	write_gdt_entry(get_cpu_gdt_rw(cpu), GDT_ENTRY_PERCPU, &d, DESCTYPE_S);
 #endif
diff --git a/arch/x86/platform/pvh/head.S b/arch/x86/platform/pvh/head.S
index 9bcafdd..7c6a108 100644
--- a/arch/x86/platform/pvh/head.S
+++ b/arch/x86/platform/pvh/head.S
@@ -149,11 +149,11 @@ SYM_DATA_END(gdt)
 SYM_DATA_START_LOCAL(gdt_start)
 	.quad 0x0000000000000000            /* NULL descriptor */
 #ifdef CONFIG_X86_64
-	.quad GDT_ENTRY(0xa09a, 0, 0xfffff) /* PVH_CS_SEL */
+	.quad GDT_ENTRY(DESC_CODE64, 0, 0xfffff) /* PVH_CS_SEL */
 #else
-	.quad GDT_ENTRY(0xc09a, 0, 0xfffff) /* PVH_CS_SEL */
+	.quad GDT_ENTRY(DESC_CODE32, 0, 0xfffff) /* PVH_CS_SEL */
 #endif
-	.quad GDT_ENTRY(0xc092, 0, 0xfffff) /* PVH_DS_SEL */
+	.quad GDT_ENTRY(DESC_DATA32, 0, 0xfffff) /* PVH_DS_SEL */
 SYM_DATA_END_LABEL(gdt_start, SYM_L_LOCAL, gdt_end)
 
 	.balign 16
diff --git a/arch/x86/realmode/rm/reboot.S b/arch/x86/realmode/rm/reboot.S
index 4476418..5bc068b 100644
--- a/arch/x86/realmode/rm/reboot.S
+++ b/arch/x86/realmode/rm/reboot.S
@@ -154,5 +154,5 @@ SYM_DATA_START(machine_real_restart_gdt)
 	 * base value 0x100; since this is consistent with real mode
 	 * semantics we don't have to reload the segments once CR0.PE = 0.
 	 */
-	.quad	GDT_ENTRY(0x0093, 0x100, 0xffff)
+	.quad	GDT_ENTRY(DESC_DATA16 | _DESC_ACCESSED, 0x100, 0xffff)
 SYM_DATA_END(machine_real_restart_gdt)
diff --git a/drivers/firmware/efi/libstub/x86-5lvl.c b/drivers/firmware/efi/libstub/x86-5lvl.c
index 479dd44..005dd9b 100644
--- a/drivers/firmware/efi/libstub/x86-5lvl.c
+++ b/drivers/firmware/efi/libstub/x86-5lvl.c
@@ -13,8 +13,8 @@ bool efi_no5lvl;
 static void (*la57_toggle)(void *cr3);
 
 static const struct desc_struct gdt[] = {
-	[GDT_ENTRY_KERNEL32_CS] = GDT_ENTRY_INIT(0xc09b, 0, 0xfffff),
-	[GDT_ENTRY_KERNEL_CS]   = GDT_ENTRY_INIT(0xa09b, 0, 0xfffff),
+	[GDT_ENTRY_KERNEL32_CS] = GDT_ENTRY_INIT(DESC_CODE32 | _DESC_ACCESSED, 0, 0xfffff),
+	[GDT_ENTRY_KERNEL_CS]   = GDT_ENTRY_INIT(DESC_CODE64 | _DESC_ACCESSED, 0, 0xfffff),
 };
 
 /*
diff --git a/drivers/pnp/pnpbios/bioscalls.c b/drivers/pnp/pnpbios/bioscalls.c
index ddc6f21..1f31dce 100644
--- a/drivers/pnp/pnpbios/bioscalls.c
+++ b/drivers/pnp/pnpbios/bioscalls.c
@@ -60,7 +60,7 @@ do { \
 	set_desc_limit(&gdt[(selname) >> 3], (size) - 1); \
 } while(0)
 
-static struct desc_struct bad_bios_desc = GDT_ENTRY_INIT(0x4092,
+static struct desc_struct bad_bios_desc = GDT_ENTRY_INIT(DESC_DATA32_BIOS,
 			(unsigned long)__va(0x400UL), PAGE_SIZE - 0x400 - 1);
 
 /*

