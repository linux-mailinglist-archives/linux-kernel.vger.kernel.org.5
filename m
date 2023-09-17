Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6BA7A36ED
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 19:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236970AbjIQRom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 13:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236836AbjIQRo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 13:44:29 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44480119
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 10:44:23 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-401187f8071so24548625e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 10:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694972662; x=1695577462; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=lxPPJTSGswUacESXRcV/1i8fQ6Ig93A/MlI2vuhW3G8=;
        b=PkXDslRZwQM2OyHfen0PxCbn/WAJ0QfgRLEPHJb1dl0NRkp/NLXZs6eyxWtgcwAtws
         iG3ZtwfjzDpp+mhi/p6b3Izzn3NMLkFsweAzO0JfWTne+h7GPWnHgllWSS+yzXapjOt1
         QkOvP4dbeVPRZ48JTBlcWW1/8DHHwoL0reQm/bnyfvBeQOw29Wt69eJ8+pUkFEkMsF64
         o6MOLCqCLqoCjJJ8ScxDVHB8ceyYjjfOFvwT5tH76NhhjicLfOd3cGka8X2PhmF5fPa0
         Lp9eyqA0TtAiN1WNwyej/1i0IJAacctbII4A8Mn5jEmahVjp4TJSSBy828x0Eg854cXG
         rT7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694972662; x=1695577462;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lxPPJTSGswUacESXRcV/1i8fQ6Ig93A/MlI2vuhW3G8=;
        b=pON1WueapYuUnXdheZm1PMCinmvtISb3v7Oqdl1xkTedYRMGeCCFn8n10Dljq6iVB7
         vl87N+tTp5SPJrlzmOlgdeTi42BRhqj4l7Yu+Q3vmE/wySaMR51ODOPYsZiqZmzyT0wi
         GFDDxbI87BtrgLV5UbqE6kWJK4K+Nh5MAVbJmUr7LCA2Hs5eB78KHqQFZtxH4k66dJoj
         qN7NJKH/N2Bd6LNz4J6xnUkwWDbdsFyMpMkBo1Sx4sBwHZ3xgljTiVcED4ysamjub6cU
         DJbN6vENPSnJKVwew6oipVhCpO6TtNJaX98NTQRhePly5JX3/pJKfcHrMXVoOxcYlNAG
         CZ5A==
X-Gm-Message-State: AOJu0YwE1w9NG9LfSL7ByvdczCdxxtRslkYwQtnhKLadzkE3dtoNt9R/
        nr20UnYkGpBKt2eYaHQBOTk=
X-Google-Smtp-Source: AGHT+IHGgeXxFaz+dAylrmQm0Zifyjev3/cHyZucrFF3pWXM/Q6XXNp1Nqc+wMnpwNMCO2pc1CIX2g==
X-Received: by 2002:a7b:cd0d:0:b0:3ff:516b:5c4c with SMTP id f13-20020a7bcd0d000000b003ff516b5c4cmr5562813wmj.18.1694972661561;
        Sun, 17 Sep 2023 10:44:21 -0700 (PDT)
Received: from gmail.com (1F2EF265.nat.pool.telekom.hu. [31.46.242.101])
        by smtp.gmail.com with ESMTPSA id v13-20020a05600c214d00b003fc16ee2864sm10197541wml.48.2023.09.17.10.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Sep 2023 10:44:18 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sun, 17 Sep 2023 19:44:16 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: [GIT PULL] x86 fixes
Message-ID: <ZQc68JA/nusWELFK@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2023-09-17

   # HEAD: 75b2f7e4c9e0fd750a5a27ca9736d1daa7a3762a x86/purgatory: Remove LTO flags

Misc fixes:

- Fix an UV boot crash,
- Skip spurious ENDBR generation on _THIS_IP_,
- Fix ENDBR use in putuser() asm methods,
- Fix corner case boot crashes on 5-level paging,
- and fix a false positive WARNING on LTO kernels.

 Thanks,

	Ingo

------------------>
Kirill A. Shutemov (1):
      x86/boot/compressed: Reserve more memory for page tables

Peter Zijlstra (2):
      x86/ibt: Suppress spurious ENDBR
      x86/ibt: Avoid duplicate ENDBR in __put_user_nocheck*()

Song Liu (1):
      x86/purgatory: Remove LTO flags

Steve Wahl (1):
      x86/platform/uv: Use alternate source for socket to node data


 arch/x86/boot/compressed/ident_map_64.c |  8 ++++++
 arch/x86/include/asm/boot.h             | 47 ++++++++++++++++++++++-----------
 arch/x86/include/asm/linkage.h          |  8 ++++++
 arch/x86/kernel/apic/x2apic_uv_x.c      | 11 ++++----
 arch/x86/lib/putuser.S                  |  4 ---
 arch/x86/purgatory/Makefile             |  4 +++
 include/linux/instruction_pointer.h     |  5 ++++
 7 files changed, 62 insertions(+), 25 deletions(-)

diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
index bcc956c17872..08f93b0401bb 100644
--- a/arch/x86/boot/compressed/ident_map_64.c
+++ b/arch/x86/boot/compressed/ident_map_64.c
@@ -59,6 +59,14 @@ static void *alloc_pgt_page(void *context)
 		return NULL;
 	}
 
+	/* Consumed more tables than expected? */
+	if (pages->pgt_buf_offset == BOOT_PGT_SIZE_WARN) {
+		debug_putstr("pgt_buf running low in " __FILE__ "\n");
+		debug_putstr("Need to raise BOOT_PGT_SIZE?\n");
+		debug_putaddr(pages->pgt_buf_offset);
+		debug_putaddr(pages->pgt_buf_size);
+	}
+
 	entry = pages->pgt_buf + pages->pgt_buf_offset;
 	pages->pgt_buf_offset += PAGE_SIZE;
 
diff --git a/arch/x86/include/asm/boot.h b/arch/x86/include/asm/boot.h
index 4ae14339cb8c..b3a7cfb0d99e 100644
--- a/arch/x86/include/asm/boot.h
+++ b/arch/x86/include/asm/boot.h
@@ -40,23 +40,40 @@
 #ifdef CONFIG_X86_64
 # define BOOT_STACK_SIZE	0x4000
 
-# define BOOT_INIT_PGT_SIZE	(6*4096)
-# ifdef CONFIG_RANDOMIZE_BASE
 /*
- * Assuming all cross the 512GB boundary:
- * 1 page for level4
- * (2+2)*4 pages for kernel, param, cmd_line, and randomized kernel
- * 2 pages for first 2M (video RAM: CONFIG_X86_VERBOSE_BOOTUP).
- * Total is 19 pages.
+ * Used by decompressor's startup_32() to allocate page tables for identity
+ * mapping of the 4G of RAM in 4-level paging mode:
+ * - 1 level4 table;
+ * - 1 level3 table;
+ * - 4 level2 table that maps everything with 2M pages;
+ *
+ * The additional level5 table needed for 5-level paging is allocated from
+ * trampoline_32bit memory.
  */
-#  ifdef CONFIG_X86_VERBOSE_BOOTUP
-#   define BOOT_PGT_SIZE	(19*4096)
-#  else /* !CONFIG_X86_VERBOSE_BOOTUP */
-#   define BOOT_PGT_SIZE	(17*4096)
-#  endif
-# else /* !CONFIG_RANDOMIZE_BASE */
-#  define BOOT_PGT_SIZE		BOOT_INIT_PGT_SIZE
-# endif
+# define BOOT_INIT_PGT_SIZE	(6*4096)
+
+/*
+ * Total number of page tables kernel_add_identity_map() can allocate,
+ * including page tables consumed by startup_32().
+ *
+ * Worst-case scenario:
+ *  - 5-level paging needs 1 level5 table;
+ *  - KASLR needs to map kernel, boot_params, cmdline and randomized kernel,
+ *    assuming all of them cross 256T boundary:
+ *    + 4*2 level4 table;
+ *    + 4*2 level3 table;
+ *    + 4*2 level2 table;
+ *  - X86_VERBOSE_BOOTUP needs to map the first 2M (video RAM):
+ *    + 1 level4 table;
+ *    + 1 level3 table;
+ *    + 1 level2 table;
+ * Total: 28 tables
+ *
+ * Add 4 spare table in case decompressor touches anything beyond what is
+ * accounted above. Warn if it happens.
+ */
+# define BOOT_PGT_SIZE_WARN	(28*4096)
+# define BOOT_PGT_SIZE		(32*4096)
 
 #else /* !CONFIG_X86_64 */
 # define BOOT_STACK_SIZE	0x1000
diff --git a/arch/x86/include/asm/linkage.h b/arch/x86/include/asm/linkage.h
index 97a3de7892d3..5ff49fd67732 100644
--- a/arch/x86/include/asm/linkage.h
+++ b/arch/x86/include/asm/linkage.h
@@ -8,6 +8,14 @@
 #undef notrace
 #define notrace __attribute__((no_instrument_function))
 
+#ifdef CONFIG_64BIT
+/*
+ * The generic version tends to create spurious ENDBR instructions under
+ * certain conditions.
+ */
+#define _THIS_IP_ ({ unsigned long __here; asm ("lea 0(%%rip), %0" : "=r" (__here)); __here; })
+#endif
+
 #ifdef CONFIG_X86_32
 #define asmlinkage CPP_ASMLINKAGE __attribute__((regparm(0)))
 #endif /* CONFIG_X86_32 */
diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index d9f5d7492f83..205cee567629 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -1533,7 +1533,7 @@ static void __init build_socket_tables(void)
 {
 	struct uv_gam_range_entry *gre = uv_gre_table;
 	int nums, numn, nump;
-	int cpu, i, lnid;
+	int i, lnid, apicid;
 	int minsock = _min_socket;
 	int maxsock = _max_socket;
 	int minpnode = _min_pnode;
@@ -1584,15 +1584,14 @@ static void __init build_socket_tables(void)
 
 	/* Set socket -> node values: */
 	lnid = NUMA_NO_NODE;
-	for_each_possible_cpu(cpu) {
-		int nid = cpu_to_node(cpu);
-		int apicid, sockid;
+	for (apicid = 0; apicid < ARRAY_SIZE(__apicid_to_node); apicid++) {
+		int nid = __apicid_to_node[apicid];
+		int sockid;
 
-		if (lnid == nid)
+		if ((nid == NUMA_NO_NODE) || (lnid == nid))
 			continue;
 		lnid = nid;
 
-		apicid = per_cpu(x86_cpu_to_apicid, cpu);
 		sockid = apicid >> uv_cpuid.socketid_shift;
 
 		if (_socket_to_node[sockid - minsock] == SOCK_EMPTY)
diff --git a/arch/x86/lib/putuser.S b/arch/x86/lib/putuser.S
index 1451e0c4ae22..235bbda6fc82 100644
--- a/arch/x86/lib/putuser.S
+++ b/arch/x86/lib/putuser.S
@@ -56,7 +56,6 @@ SYM_FUNC_END(__put_user_1)
 EXPORT_SYMBOL(__put_user_1)
 
 SYM_FUNC_START(__put_user_nocheck_1)
-	ENDBR
 	ASM_STAC
 2:	movb %al,(%_ASM_CX)
 	xor %ecx,%ecx
@@ -76,7 +75,6 @@ SYM_FUNC_END(__put_user_2)
 EXPORT_SYMBOL(__put_user_2)
 
 SYM_FUNC_START(__put_user_nocheck_2)
-	ENDBR
 	ASM_STAC
 4:	movw %ax,(%_ASM_CX)
 	xor %ecx,%ecx
@@ -96,7 +94,6 @@ SYM_FUNC_END(__put_user_4)
 EXPORT_SYMBOL(__put_user_4)
 
 SYM_FUNC_START(__put_user_nocheck_4)
-	ENDBR
 	ASM_STAC
 6:	movl %eax,(%_ASM_CX)
 	xor %ecx,%ecx
@@ -119,7 +116,6 @@ SYM_FUNC_END(__put_user_8)
 EXPORT_SYMBOL(__put_user_8)
 
 SYM_FUNC_START(__put_user_nocheck_8)
-	ENDBR
 	ASM_STAC
 9:	mov %_ASM_AX,(%_ASM_CX)
 #ifdef CONFIG_X86_32
diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index c2a29be35c01..08aa0f25f12a 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -19,6 +19,10 @@ CFLAGS_sha256.o := -D__DISABLE_EXPORTS -D__NO_FORTIFY
 # optimization flags.
 KBUILD_CFLAGS := $(filter-out -fprofile-sample-use=% -fprofile-use=%,$(KBUILD_CFLAGS))
 
+# When LTO is enabled, llvm emits many text sections, which is not supported
+# by kexec. Remove -flto=* flags.
+KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_LTO),$(KBUILD_CFLAGS))
+
 # When linking purgatory.ro with -r unresolved symbols are not checked,
 # also link a purgatory.chk binary without -r to check for unresolved symbols.
 PURGATORY_LDFLAGS := -e purgatory_start -z nodefaultlib
diff --git a/include/linux/instruction_pointer.h b/include/linux/instruction_pointer.h
index cda1f706eaeb..aa0b3ffea935 100644
--- a/include/linux/instruction_pointer.h
+++ b/include/linux/instruction_pointer.h
@@ -2,7 +2,12 @@
 #ifndef _LINUX_INSTRUCTION_POINTER_H
 #define _LINUX_INSTRUCTION_POINTER_H
 
+#include <asm/linkage.h>
+
 #define _RET_IP_		(unsigned long)__builtin_return_address(0)
+
+#ifndef _THIS_IP_
 #define _THIS_IP_  ({ __label__ __here; __here: (unsigned long)&&__here; })
+#endif
 
 #endif /* _LINUX_INSTRUCTION_POINTER_H */
