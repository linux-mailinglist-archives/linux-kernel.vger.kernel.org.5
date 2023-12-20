Return-Path: <linux-kernel+bounces-6687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EDF2819C18
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDAD9B228EF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781F82231C;
	Wed, 20 Dec 2023 10:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Hizdu3wr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O3Dc/amU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174D920DEF;
	Wed, 20 Dec 2023 10:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 20 Dec 2023 10:04:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1703066642;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yYfBJlxTG3aKsBJQ89DaFh+wXp49c/rVSIv+pRMLbPY=;
	b=Hizdu3wrqHDrJ7Ob1tVJp9w3NJcLMHleWjrCzvzmnbzR7ZIAYsvUllBdrf9wE4rPDUxY7u
	O5Slukfn+NyFXCSVTmeq+US+PEpD53b/UudJo2KyvqJuRsBJZbnIvpxVD6/fE4WA0z2MBM
	a3ebd3J69pidNvz+CC5vi8Q6y234VOcsVhaX9siQZby6n1ZQ+d57jIOjQVbVUjyXD7wJHz
	dKAD2zirBY0NGn6FV5GvjjRgD0Tn4WZDH1a43CI+kIEGuGKQza4mtdQv8M3c/oAuFMJBby
	Yd6XmxQlnwg8QGjQoqqRbzF6yqMhUW4EfHJZkSAEPUmh4NPP6+++Oe8M/0BsWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1703066642;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yYfBJlxTG3aKsBJQ89DaFh+wXp49c/rVSIv+pRMLbPY=;
	b=O3Dc/amU7ofRTkR2F8zJF/gJx6aE909qcMh/l6EIuATsBHgc06vRRZ8WbJ8XvZOJ64MTCW
	v+AmKNMDh9QSDZDw==
From: "tip-bot2 for Vegard Nossum" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/asm: Replace magic numbers in GDT descriptors,
 preparations
Cc: Vegard Nossum <vegard.nossum@oracle.com>, Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20231219151200.2878271-3-vegard.nossum@oracle.com>
References: <20231219151200.2878271-3-vegard.nossum@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170306664164.398.4293804017901105347.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     41ef75c848e33beb1f7b981866b62b0066f744c7
Gitweb:        https://git.kernel.org/tip/41ef75c848e33beb1f7b981866b62b0066f744c7
Author:        Vegard Nossum <vegard.nossum@oracle.com>
AuthorDate:    Tue, 19 Dec 2023 16:11:57 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 20 Dec 2023 10:57:20 +01:00

x86/asm: Replace magic numbers in GDT descriptors, preparations

We'd like to replace all the magic numbers in various GDT descriptors
with new, semantically meaningful, symbolic values.

In order to be able to verify that the change doesn't cause any actual
changes to the compiled binary code, I've split the change into two
patches:

 - Part 1 (this commit): everything _but_ actually replacing the numbers
 - Part 2 (the following commit): _only_ replacing the numbers

The reason we need this split for verification is that including new
headers causes some spurious changes to the object files, mostly line
number changes in the debug info but occasionally other subtle codegen
changes.

Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20231219151200.2878271-3-vegard.nossum@oracle.com
---
 arch/x86/boot/pm.c               | 1 +
 arch/x86/include/asm/desc_defs.h | 2 ++
 arch/x86/kernel/cpu/common.c     | 8 --------
 arch/x86/platform/pvh/head.S     | 1 +
 arch/x86/realmode/rm/reboot.S    | 1 +
 5 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/x86/boot/pm.c b/arch/x86/boot/pm.c
index 40031a6..0361b53 100644
--- a/arch/x86/boot/pm.c
+++ b/arch/x86/boot/pm.c
@@ -11,6 +11,7 @@
  */
 
 #include "boot.h"
+#include <asm/desc_defs.h>
 #include <asm/segment.h>
 
 /*
diff --git a/arch/x86/include/asm/desc_defs.h b/arch/x86/include/asm/desc_defs.h
index 7c08cbf..33d229e 100644
--- a/arch/x86/include/asm/desc_defs.h
+++ b/arch/x86/include/asm/desc_defs.h
@@ -144,6 +144,7 @@ struct gate_struct {
 
 typedef struct gate_struct gate_desc;
 
+#ifndef _SETUP
 static inline unsigned long gate_offset(const gate_desc *g)
 {
 #ifdef CONFIG_X86_64
@@ -158,6 +159,7 @@ static inline unsigned long gate_segment(const gate_desc *g)
 {
 	return g->segment;
 }
+#endif
 
 struct desc_ptr {
 	unsigned short size;
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index b14fc8c..ceb6e4b 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -204,25 +204,17 @@ DEFINE_PER_CPU_PAGE_ALIGNED(struct gdt_page, gdt_page) = { .gdt = {
 	 * They code segments and data segments have fixed 64k limits,
 	 * the transfer segment sizes are set at run time.
 	 */
-	/* 32-bit code */
 	[GDT_ENTRY_PNPBIOS_CS32]	= GDT_ENTRY_INIT(0x409a, 0, 0xffff),
-	/* 16-bit code */
 	[GDT_ENTRY_PNPBIOS_CS16]	= GDT_ENTRY_INIT(0x009a, 0, 0xffff),
-	/* 16-bit data */
 	[GDT_ENTRY_PNPBIOS_DS]		= GDT_ENTRY_INIT(0x0092, 0, 0xffff),
-	/* 16-bit data */
 	[GDT_ENTRY_PNPBIOS_TS1]		= GDT_ENTRY_INIT(0x0092, 0, 0),
-	/* 16-bit data */
 	[GDT_ENTRY_PNPBIOS_TS2]		= GDT_ENTRY_INIT(0x0092, 0, 0),
 	/*
 	 * The APM segments have byte granularity and their bases
 	 * are set at run time.  All have 64k limits.
 	 */
-	/* 32-bit code */
 	[GDT_ENTRY_APMBIOS_BASE]	= GDT_ENTRY_INIT(0x409a, 0, 0xffff),
-	/* 16-bit code */
 	[GDT_ENTRY_APMBIOS_BASE+1]	= GDT_ENTRY_INIT(0x009a, 0, 0xffff),
-	/* data */
 	[GDT_ENTRY_APMBIOS_BASE+2]	= GDT_ENTRY_INIT(0x4092, 0, 0xffff),
 
 	[GDT_ENTRY_ESPFIX_SS]		= GDT_ENTRY_INIT(0xc092, 0, 0xfffff),
diff --git a/arch/x86/platform/pvh/head.S b/arch/x86/platform/pvh/head.S
index c4365a0..9bcafdd 100644
--- a/arch/x86/platform/pvh/head.S
+++ b/arch/x86/platform/pvh/head.S
@@ -11,6 +11,7 @@
 #include <linux/elfnote.h>
 #include <linux/init.h>
 #include <linux/linkage.h>
+#include <asm/desc_defs.h>
 #include <asm/segment.h>
 #include <asm/asm.h>
 #include <asm/boot.h>
diff --git a/arch/x86/realmode/rm/reboot.S b/arch/x86/realmode/rm/reboot.S
index f10515b..4476418 100644
--- a/arch/x86/realmode/rm/reboot.S
+++ b/arch/x86/realmode/rm/reboot.S
@@ -1,5 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #include <linux/linkage.h>
+#include <asm/desc_defs.h>
 #include <asm/segment.h>
 #include <asm/page_types.h>
 #include <asm/processor-flags.h>

