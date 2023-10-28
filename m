Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7377DA624
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 11:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbjJ1JUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 05:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjJ1JUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 05:20:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA28F0;
        Sat, 28 Oct 2023 02:20:15 -0700 (PDT)
Date:   Sat, 28 Oct 2023 09:20:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698484813;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gKoxtUXOk+vc7o5XDD2Ngg10fmdWqZmKpllpOAUbRKk=;
        b=0vviCYjX6rAG2r8LWR/6+aaHxkO1tP3KsPJZlh5biFiZHJHC9pOhvjva+ej8+2Vd+7i/bv
        YdWScgg54NVruM5IsDWOt0/QhHrFBxvz2as+DHubqmKvovQqY3++s1KEBV+XcdiJKf5J1Q
        erLR+poVH8URDvzaHQJo+oSt8FHb+fSwt+q6ybChBlmmsTLvbHgOyB6k1l3Ibl3nAtkr34
        VbYj53bl2sp3iRem+tMEq3ntZUFBHLlMPDWyzWmHm9FojCuAAahD5rJ3M2adNuOrYlULX6
        lk5vL+E8WeuRjaDPbc+TrGE1+OvVcFz0mWM4ooWjC7nwypR7crajj4VEfrPwWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698484813;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gKoxtUXOk+vc7o5XDD2Ngg10fmdWqZmKpllpOAUbRKk=;
        b=PvxmkOZ8GeMaPMDuWc9pawc8wDENY0fYJh6ZhZ6/kMx4a45wryc2OKHUKewXtE5HTt7laB
        YAv/Nk3bwJ6kbVCA==
From:   "tip-bot2 for Masahiro Yamada" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/headers] x86/headers: Replace #include <asm/export.h> with
 #include <linux/export.h>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230806145958.380314-2-masahiroy@kernel.org>
References: <20230806145958.380314-2-masahiroy@kernel.org>
MIME-Version: 1.0
Message-ID: <169848481245.3135.12923197367541395563.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/headers branch of tip:

Commit-ID:     94ea9c05219518ef7ec90b7ef2cb108476df764b
Gitweb:        https://git.kernel.org/tip/94ea9c05219518ef7ec90b7ef2cb108476df764b
Author:        Masahiro Yamada <masahiroy@kernel.org>
AuthorDate:    Sun, 06 Aug 2023 23:59:56 +09:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 03 Oct 2023 10:38:07 +02:00

x86/headers: Replace #include <asm/export.h> with #include <linux/export.h>

The following commit:

  ddb5cdbafaaa ("kbuild: generate KSYMTAB entries by modpost")

deprecated <asm/export.h>, which is now a wrapper of <linux/export.h>.

Use <linux/export.h> in *.S as well as in *.c files.

After all the <asm/export.h> lines are replaced, <asm/export.h> and
<asm-generic/export.h> will be removed.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230806145958.380314-2-masahiroy@kernel.org
---
 arch/x86/entry/entry.S               | 2 +-
 arch/x86/entry/entry_64.S            | 2 +-
 arch/x86/entry/thunk_32.S            | 2 +-
 arch/x86/entry/thunk_64.S            | 2 +-
 arch/x86/kernel/ftrace_32.S          | 2 +-
 arch/x86/kernel/ftrace_64.S          | 2 +-
 arch/x86/kernel/head_32.S            | 2 +-
 arch/x86/kernel/head_64.S            | 3 +--
 arch/x86/kernel/irqflags.S           | 2 +-
 arch/x86/lib/checksum_32.S           | 2 +-
 arch/x86/lib/clear_page_64.S         | 2 +-
 arch/x86/lib/cmpxchg8b_emu.S         | 2 +-
 arch/x86/lib/copy_page_64.S          | 2 +-
 arch/x86/lib/copy_user_64.S          | 2 +-
 arch/x86/lib/copy_user_uncached_64.S | 2 +-
 arch/x86/lib/getuser.S               | 2 +-
 arch/x86/lib/hweight.S               | 2 +-
 arch/x86/lib/memcpy_64.S             | 2 +-
 arch/x86/lib/memmove_32.S            | 2 +-
 arch/x86/lib/memmove_64.S            | 2 +-
 arch/x86/lib/memset_64.S             | 2 +-
 arch/x86/lib/putuser.S               | 3 +--
 arch/x86/lib/retpoline.S             | 2 +-
 23 files changed, 23 insertions(+), 25 deletions(-)

diff --git a/arch/x86/entry/entry.S b/arch/x86/entry/entry.S
index bfb7bcb..8c8d38f 100644
--- a/arch/x86/entry/entry.S
+++ b/arch/x86/entry/entry.S
@@ -3,8 +3,8 @@
  * Common place for both 32- and 64-bit entry routines.
  */
 
+#include <linux/export.h>
 #include <linux/linkage.h>
-#include <asm/export.h>
 #include <asm/msr-index.h>
 
 .pushsection .noinstr.text, "ax"
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 43606de..be08efa 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -18,6 +18,7 @@
  * - SYM_FUNC_START/END:Define functions in the symbol table.
  * - idtentry:		Define exception entry points.
  */
+#include <linux/export.h>
 #include <linux/linkage.h>
 #include <asm/segment.h>
 #include <asm/cache.h>
@@ -34,7 +35,6 @@
 #include <asm/asm.h>
 #include <asm/smap.h>
 #include <asm/pgtable_types.h>
-#include <asm/export.h>
 #include <asm/frame.h>
 #include <asm/trapnr.h>
 #include <asm/nospec-branch.h>
diff --git a/arch/x86/entry/thunk_32.S b/arch/x86/entry/thunk_32.S
index ff6e700..0103e10 100644
--- a/arch/x86/entry/thunk_32.S
+++ b/arch/x86/entry/thunk_32.S
@@ -4,9 +4,9 @@
  * Copyright 2008 by Steven Rostedt, Red Hat, Inc
  *  (inspired by Andi Kleen's thunk_64.S)
  */
+	#include <linux/export.h>
 	#include <linux/linkage.h>
 	#include <asm/asm.h>
-	#include <asm/export.h>
 
 	/* put return address in eax (arg1) */
 	.macro THUNK name, func, put_ret_addr_in_eax=0
diff --git a/arch/x86/entry/thunk_64.S b/arch/x86/entry/thunk_64.S
index 27b5da2..416b400 100644
--- a/arch/x86/entry/thunk_64.S
+++ b/arch/x86/entry/thunk_64.S
@@ -4,10 +4,10 @@
  * disturbance of register allocation in some inline assembly constructs.
  * Copyright 2001,2002 by Andi Kleen, SuSE Labs.
  */
+#include <linux/export.h>
 #include <linux/linkage.h>
 #include "calling.h"
 #include <asm/asm.h>
-#include <asm/export.h>
 
 	/* rdi:	arg1 ... normal C conventions. rax is saved/restored. */
 	.macro THUNK name, func
diff --git a/arch/x86/kernel/ftrace_32.S b/arch/x86/kernel/ftrace_32.S
index 24c1175..58d9ed5 100644
--- a/arch/x86/kernel/ftrace_32.S
+++ b/arch/x86/kernel/ftrace_32.S
@@ -3,10 +3,10 @@
  *  Copyright (C) 2017  Steven Rostedt, VMware Inc.
  */
 
+#include <linux/export.h>
 #include <linux/linkage.h>
 #include <asm/page_types.h>
 #include <asm/segment.h>
-#include <asm/export.h>
 #include <asm/ftrace.h>
 #include <asm/nospec-branch.h>
 #include <asm/frame.h>
diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index 945cfa5..214f30e 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -3,12 +3,12 @@
  *  Copyright (C) 2014  Steven Rostedt, Red Hat Inc
  */
 
+#include <linux/export.h>
 #include <linux/cfi_types.h>
 #include <linux/linkage.h>
 #include <asm/asm-offsets.h>
 #include <asm/ptrace.h>
 #include <asm/ftrace.h>
-#include <asm/export.h>
 #include <asm/nospec-branch.h>
 #include <asm/unwind_hints.h>
 #include <asm/frame.h>
diff --git a/arch/x86/kernel/head_32.S b/arch/x86/kernel/head_32.S
index c931899..b655421 100644
--- a/arch/x86/kernel/head_32.S
+++ b/arch/x86/kernel/head_32.S
@@ -8,6 +8,7 @@
  */
 
 .text
+#include <linux/export.h>
 #include <linux/threads.h>
 #include <linux/init.h>
 #include <linux/linkage.h>
@@ -25,7 +26,6 @@
 #include <asm/nops.h>
 #include <asm/nospec-branch.h>
 #include <asm/bootparam.h>
-#include <asm/export.h>
 #include <asm/pgtable_32.h>
 
 /* Physical address */
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index ea69959..6bbbef6 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -9,7 +9,7 @@
  *  Copyright (C) 2005 Eric Biederman <ebiederm@xmission.com>
  */
 
-
+#include <linux/export.h>
 #include <linux/linkage.h>
 #include <linux/threads.h>
 #include <linux/init.h>
@@ -22,7 +22,6 @@
 #include <asm/percpu.h>
 #include <asm/nops.h>
 #include "../entry/calling.h"
-#include <asm/export.h>
 #include <asm/nospec-branch.h>
 #include <asm/apicdef.h>
 #include <asm/fixmap.h>
diff --git a/arch/x86/kernel/irqflags.S b/arch/x86/kernel/irqflags.S
index aaf9e77..7f542a7 100644
--- a/arch/x86/kernel/irqflags.S
+++ b/arch/x86/kernel/irqflags.S
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
 #include <asm/asm.h>
-#include <asm/export.h>
+#include <linux/export.h>
 #include <linux/linkage.h>
 
 /*
diff --git a/arch/x86/lib/checksum_32.S b/arch/x86/lib/checksum_32.S
index 23318c3..68f7fa3 100644
--- a/arch/x86/lib/checksum_32.S
+++ b/arch/x86/lib/checksum_32.S
@@ -21,10 +21,10 @@
  *                   converted to pure assembler
  */
 
+#include <linux/export.h>
 #include <linux/linkage.h>
 #include <asm/errno.h>
 #include <asm/asm.h>
-#include <asm/export.h>
 #include <asm/nospec-branch.h>
 
 /*
diff --git a/arch/x86/lib/clear_page_64.S b/arch/x86/lib/clear_page_64.S
index f74a3e7..2760a15 100644
--- a/arch/x86/lib/clear_page_64.S
+++ b/arch/x86/lib/clear_page_64.S
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
+#include <linux/export.h>
 #include <linux/linkage.h>
 #include <asm/asm.h>
-#include <asm/export.h>
 
 /*
  * Most CPUs support enhanced REP MOVSB/STOSB instructions. It is
diff --git a/arch/x86/lib/cmpxchg8b_emu.S b/arch/x86/lib/cmpxchg8b_emu.S
index 4980525..873e4ef 100644
--- a/arch/x86/lib/cmpxchg8b_emu.S
+++ b/arch/x86/lib/cmpxchg8b_emu.S
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 
+#include <linux/export.h>
 #include <linux/linkage.h>
-#include <asm/export.h>
 #include <asm/percpu.h>
 #include <asm/processor-flags.h>
 
diff --git a/arch/x86/lib/copy_page_64.S b/arch/x86/lib/copy_page_64.S
index 30ea644..d6ae793 100644
--- a/arch/x86/lib/copy_page_64.S
+++ b/arch/x86/lib/copy_page_64.S
@@ -1,10 +1,10 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* Written 2003 by Andi Kleen, based on a kernel by Evandro Menezes */
 
+#include <linux/export.h>
 #include <linux/linkage.h>
 #include <asm/cpufeatures.h>
 #include <asm/alternative.h>
-#include <asm/export.h>
 
 /*
  * Some CPUs run faster using the string copy instructions (sane microcode).
diff --git a/arch/x86/lib/copy_user_64.S b/arch/x86/lib/copy_user_64.S
index 0a81aaf..fc9fb5d 100644
--- a/arch/x86/lib/copy_user_64.S
+++ b/arch/x86/lib/copy_user_64.S
@@ -6,11 +6,11 @@
  * Functions to copy from and to user space.
  */
 
+#include <linux/export.h>
 #include <linux/linkage.h>
 #include <asm/cpufeatures.h>
 #include <asm/alternative.h>
 #include <asm/asm.h>
-#include <asm/export.h>
 
 /*
  * rep_movs_alternative - memory copy with exception handling.
diff --git a/arch/x86/lib/copy_user_uncached_64.S b/arch/x86/lib/copy_user_uncached_64.S
index 5c5f38d..2918e36 100644
--- a/arch/x86/lib/copy_user_uncached_64.S
+++ b/arch/x86/lib/copy_user_uncached_64.S
@@ -3,9 +3,9 @@
  * Copyright 2023 Linus Torvalds <torvalds@linux-foundation.org>
  */
 
+#include <linux/export.h>
 #include <linux/linkage.h>
 #include <asm/asm.h>
-#include <asm/export.h>
 
 /*
  * copy_user_nocache - Uncached memory copy with exception handling
diff --git a/arch/x86/lib/getuser.S b/arch/x86/lib/getuser.S
index 9c63713..20ef350 100644
--- a/arch/x86/lib/getuser.S
+++ b/arch/x86/lib/getuser.S
@@ -26,6 +26,7 @@
  * as they get called from within inline assembly.
  */
 
+#include <linux/export.h>
 #include <linux/linkage.h>
 #include <asm/page_types.h>
 #include <asm/errno.h>
@@ -33,7 +34,6 @@
 #include <asm/thread_info.h>
 #include <asm/asm.h>
 #include <asm/smap.h>
-#include <asm/export.h>
 
 #define ASM_BARRIER_NOSPEC ALTERNATIVE "", "lfence", X86_FEATURE_LFENCE_RDTSC
 
diff --git a/arch/x86/lib/hweight.S b/arch/x86/lib/hweight.S
index 12c16c6..5e5e9e3 100644
--- a/arch/x86/lib/hweight.S
+++ b/arch/x86/lib/hweight.S
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#include <linux/export.h>
 #include <linux/linkage.h>
-#include <asm/export.h>
 
 #include <asm/asm.h>
 
diff --git a/arch/x86/lib/memcpy_64.S b/arch/x86/lib/memcpy_64.S
index 76697df..0ae2e17 100644
--- a/arch/x86/lib/memcpy_64.S
+++ b/arch/x86/lib/memcpy_64.S
@@ -1,12 +1,12 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /* Copyright 2002 Andi Kleen */
 
+#include <linux/export.h>
 #include <linux/linkage.h>
 #include <linux/cfi_types.h>
 #include <asm/errno.h>
 #include <asm/cpufeatures.h>
 #include <asm/alternative.h>
-#include <asm/export.h>
 
 .section .noinstr.text, "ax"
 
diff --git a/arch/x86/lib/memmove_32.S b/arch/x86/lib/memmove_32.S
index 0588b2c..35010ba 100644
--- a/arch/x86/lib/memmove_32.S
+++ b/arch/x86/lib/memmove_32.S
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
+#include <linux/export.h>
 #include <linux/linkage.h>
-#include <asm/export.h>
 
 SYM_FUNC_START(memmove)
 /*
diff --git a/arch/x86/lib/memmove_64.S b/arch/x86/lib/memmove_64.S
index ccdf3a5..1b60ae8 100644
--- a/arch/x86/lib/memmove_64.S
+++ b/arch/x86/lib/memmove_64.S
@@ -6,10 +6,10 @@
  * This assembly file is re-written from memmove_64.c file.
  *	- Copyright 2011 Fenghua Yu <fenghua.yu@intel.com>
  */
+#include <linux/export.h>
 #include <linux/linkage.h>
 #include <asm/cpufeatures.h>
 #include <asm/alternative.h>
-#include <asm/export.h>
 
 #undef memmove
 
diff --git a/arch/x86/lib/memset_64.S b/arch/x86/lib/memset_64.S
index 3d818b8..0199d56 100644
--- a/arch/x86/lib/memset_64.S
+++ b/arch/x86/lib/memset_64.S
@@ -1,10 +1,10 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright 2002 Andi Kleen, SuSE Labs */
 
+#include <linux/export.h>
 #include <linux/linkage.h>
 #include <asm/cpufeatures.h>
 #include <asm/alternative.h>
-#include <asm/export.h>
 
 .section .noinstr.text, "ax"
 
diff --git a/arch/x86/lib/putuser.S b/arch/x86/lib/putuser.S
index 235bbda..2877f59 100644
--- a/arch/x86/lib/putuser.S
+++ b/arch/x86/lib/putuser.S
@@ -11,13 +11,12 @@
  * return an error value in addition to the "real"
  * return value.
  */
+#include <linux/export.h>
 #include <linux/linkage.h>
 #include <asm/thread_info.h>
 #include <asm/errno.h>
 #include <asm/asm.h>
 #include <asm/smap.h>
-#include <asm/export.h>
-
 
 /*
  * __put_user_X
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index cd86aeb..dca34f5 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -1,12 +1,12 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
+#include <linux/export.h>
 #include <linux/stringify.h>
 #include <linux/linkage.h>
 #include <asm/dwarf2.h>
 #include <asm/cpufeatures.h>
 #include <asm/alternative.h>
 #include <asm/asm-offsets.h>
-#include <asm/export.h>
 #include <asm/nospec-branch.h>
 #include <asm/unwind_hints.h>
 #include <asm/percpu.h>
