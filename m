Return-Path: <linux-kernel+bounces-6688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 172FF819C1A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 713ACB255B5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1487E225DA;
	Wed, 20 Dec 2023 10:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="x40x382o";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3FH2bF+u"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C9E21345;
	Wed, 20 Dec 2023 10:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 20 Dec 2023 10:04:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1703066643;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7VzmfdKzmIIeJFMa69SW3KqMV+93FR+A/BnSieEDQi0=;
	b=x40x382oJBs9+zQVwzgza+EDnpln+NIRqnKB9ifTcds5JUsLSQiFGldG9NswlnNrYzYwpn
	0nkw5fGaRPidULY/k+2bgh0jySA/0yGING08lMY7Vi3rs6adRz3Tz93jpsXs9VGPokgiry
	jelgVD6fecUV7WnOKidnSBndKbgUV4EI1bVVe4GDkac+0OflvP+QG4Z2M+SJacLj2xeDAY
	cVFT1RiQ4rR/PiFbAzRqhNGWibFGaJCFIF0CBEb5JDTfiyRMyDm3ls/kDu6/xs2w0aOZ5m
	mT5b4jhqziHGurvTzHVxFzHJkpCWizLxekGGEgkhorByYlibfyyQSCHk0ILt8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1703066643;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7VzmfdKzmIIeJFMa69SW3KqMV+93FR+A/BnSieEDQi0=;
	b=3FH2bF+u9haJFGEb6UIlLvv3pDEGhchpZURoP/5D0vzJfu+nmxPFjI7AeSuhu2+Y7DGtqu
	OPhsKkBHkRFw4DBg==
From: "tip-bot2 for Vegard Nossum" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/asm] x86/asm: Provide new infrastructure for GDT descriptors
Cc: Vegard Nossum <vegard.nossum@oracle.com>, Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20231219151200.2878271-2-vegard.nossum@oracle.com>
References: <20231219151200.2878271-2-vegard.nossum@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170306664229.398.6552245814527928380.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     016919c1f2e5b7ea3436abe6db0b73dbabd36682
Gitweb:        https://git.kernel.org/tip/016919c1f2e5b7ea3436abe6db0b73dbabd36682
Author:        Vegard Nossum <vegard.nossum@oracle.com>
AuthorDate:    Tue, 19 Dec 2023 16:11:56 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 20 Dec 2023 10:56:04 +01:00

x86/asm: Provide new infrastructure for GDT descriptors

Linus suggested replacing the magic numbers in the GDT descriptors
using preprocessor macros. Designing the interface properly is actually
pretty hard -- there are several constraints:

- you want the final expressions to be readable at a glance; something
  like GDT_ENTRY_FLAGS(5, 1, 0, 1, 0, 1, 1, 0) isn't because you need
  to visit the definition to understand what each parameter represents
  and then match up parameters in the user and the definition (which is
  hard when there are so many of them)

- you want the final expressions to be fairly short/information-dense;
  something like GDT_ENTRY_PRESENT | GDT_ENTRY_DATA_WRITABLE |
  GDT_ENTRY_SYSTEM | GDT_ENTRY_DB | GDT_ENTRY_GRANULARITY_4K is a bit
  too verbose to write out every time and is actually hard to read as
  well because of all the repetition

- you may want to assume defaults for some things (e.g. entries are
  DPL-0 a.k.a. kernel segments by default) and allow the user to
  override the default -- but this works best if you can OR in the
  override; if you want DPL-3 by default and override with DPL-0 you
  would need to start masking off bits instead of OR-ing them in and
  that just becomes harder to read

- you may want to parameterize some things (e.g. CODE vs. DATA or
  KERNEL vs. USER) since both values are used and you don't really
  want prefer either one by default -- or DPL, which is always some
  value that is always specified

This patch tries to balance these requirements and has two layers of
definitions -- low-level and high-level:

- the low-level defines are the mapping between human-readable names
  and the actual bit numbers

- the high-level defines are the mapping from high-level intent to
  combinations of low-level flags, representing roughly a tuple
  (data/code/tss, 64/32/16-bits) plus an override for DPL-3 (= USER),
  since that's relatively rare but still very important to mark
  properly for those segments.

- we have *_BIOS variants for 32-bit code and data segments that don't
  have the G flag set and give the limit in terms of bytes instead of
  pages

[ mingo: Improved readability bit more. ]

Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20231219151200.2878271-2-vegard.nossum@oracle.com
---
 arch/x86/include/asm/desc_defs.h | 76 +++++++++++++++++++++++++------
 1 file changed, 63 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/desc_defs.h b/arch/x86/include/asm/desc_defs.h
index f7e7099..7c08cbf 100644
--- a/arch/x86/include/asm/desc_defs.h
+++ b/arch/x86/include/asm/desc_defs.h
@@ -8,6 +8,56 @@
  * archs.
  */
 
+/*
+ * Low-level interface mapping flags/field names to bits
+ */
+
+/* Flags for _DESC_S (non-system) descriptors */
+#define _DESC_ACCESSED		0x0001
+#define _DESC_DATA_WRITABLE	0x0002
+#define _DESC_CODE_READABLE	0x0002
+#define _DESC_DATA_EXPAND_DOWN	0x0004
+#define _DESC_CODE_CONFORMING	0x0004
+#define _DESC_CODE_EXECUTABLE	0x0008
+
+/* Common flags */
+#define _DESC_S			0x0010
+#define _DESC_DPL(dpl)		((dpl) << 5)
+#define _DESC_PRESENT		0x0080
+
+#define _DESC_LONG_CODE		0x2000
+#define _DESC_DB		0x4000
+#define _DESC_GRANULARITY_4K	0x8000
+
+/* System descriptors have a numeric "type" field instead of flags */
+#define _DESC_SYSTEM(code)	(code)
+
+/*
+ * High-level interface mapping intended usage to low-level combinations
+ * of flags
+ */
+
+#define _DESC_DATA		(_DESC_S | _DESC_PRESENT | \
+				 _DESC_DATA_WRITABLE)
+#define _DESC_CODE		(_DESC_S | _DESC_PRESENT | \
+				 _DESC_CODE_READABLE | _DESC_CODE_EXECUTABLE)
+
+#define DESC_DATA16		(_DESC_DATA)
+#define DESC_CODE16		(_DESC_CODE)
+
+#define DESC_DATA32		(_DESC_DATA | _DESC_GRANULARITY_4K | _DESC_DB)
+#define DESC_DATA32_BIOS	(_DESC_DATA | _DESC_DB)
+
+#define DESC_CODE32		(_DESC_CODE | _DESC_GRANULARITY_4K | _DESC_DB)
+#define DESC_CODE32_BIOS	(_DESC_CODE | _DESC_DB)
+
+#define DESC_TSS32		(_DESC_SYSTEM(9) | _DESC_PRESENT)
+
+#define DESC_DATA64		(_DESC_DATA | _DESC_GRANULARITY_4K | _DESC_DB)
+#define DESC_CODE64		(_DESC_CODE | _DESC_GRANULARITY_4K | _DESC_LONG_CODE)
+
+#define DESC_USER		(_DESC_DPL(3))
+
 #ifndef __ASSEMBLY__
 
 #include <linux/types.h>
@@ -22,19 +72,19 @@ struct desc_struct {
 
 #define GDT_ENTRY_INIT(flags, base, limit)			\
 	{							\
-		.limit0		= (u16) (limit),		\
-		.limit1		= ((limit) >> 16) & 0x0F,	\
-		.base0		= (u16) (base),			\
-		.base1		= ((base) >> 16) & 0xFF,	\
-		.base2		= ((base) >> 24) & 0xFF,	\
-		.type		= (flags & 0x0f),		\
-		.s		= (flags >> 4) & 0x01,		\
-		.dpl		= (flags >> 5) & 0x03,		\
-		.p		= (flags >> 7) & 0x01,		\
-		.avl		= (flags >> 12) & 0x01,		\
-		.l		= (flags >> 13) & 0x01,		\
-		.d		= (flags >> 14) & 0x01,		\
-		.g		= (flags >> 15) & 0x01,		\
+		.limit0		= ((limit) >>  0) & 0xFFFF,	\
+		.limit1		= ((limit) >> 16) & 0x000F,	\
+		.base0		= ((base)  >>  0) & 0xFFFF,	\
+		.base1		= ((base)  >> 16) & 0x00FF,	\
+		.base2		= ((base)  >> 24) & 0x00FF,	\
+		.type		= ((flags) >>  0) & 0x000F,	\
+		.s		= ((flags) >>  4) & 0x0001,	\
+		.dpl		= ((flags) >>  5) & 0x0003,	\
+		.p		= ((flags) >>  7) & 0x0001,	\
+		.avl		= ((flags) >> 12) & 0x0001,	\
+		.l		= ((flags) >> 13) & 0x0001,	\
+		.d		= ((flags) >> 14) & 0x0001,	\
+		.g		= ((flags) >> 15) & 0x0001,	\
 	}
 
 enum {

