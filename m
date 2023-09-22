Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF6EC7AAF91
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 12:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233342AbjIVKd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 06:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233348AbjIVKd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 06:33:27 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F66199
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 03:33:20 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-31c5cac3ae2so1896933f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 03:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695378799; x=1695983599; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=NqM3UWnNR92tA2xJ54iUgrMFLepAy8JSXy2+gIPd6VI=;
        b=ip78ikRrowwaxJJ+IM35GICMgsXNZPBYOI5/RDg/tsDSO1gDyvUNrQIY1DXYyVnpxC
         svX9waMrdMSm7/O6wP3kJ1J4iRRQJ6/GV0k1qh6et7uQoJaT05gdZ+KedP1uzHgkYNyx
         E/WlMX2l1EXDdfT8/9/5eeOQ24MwxUrvwhwbtZ8DXRtkpN4hDamQHg3kog0ShCDBcDSY
         VStTMnPG+tn0NUGWRzXR1rI6MbPWPZXG0aRJm3nw8Jcwg3i5Thh2yNmndXhoMstVxKEf
         jeGWSCy4SpU5HXUHaaLEIWIYF5QV+JP4mwUULCVbUIEz/g9ahrCUuTbf4lG9dDy6/UkE
         1OOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695378799; x=1695983599;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NqM3UWnNR92tA2xJ54iUgrMFLepAy8JSXy2+gIPd6VI=;
        b=gJap9dTxvDaMZM7lT2WeFUbOu7Imxfx4tiBI0tgmm/kYXaAsbfqeLQWqeEUVTfC+DN
         hh6JLjNp1PuL4kWxvIa0VSADrdahc8L3CZNKqw0PguqjYDN+a+HI7f1kutFuuoWKfKUv
         qMT/sXM7l5XdHvQl7vulhzi8dfpp+zNslnm1uoWR4tBdQpWjOGFPOCl5tGF7c8wpHaot
         x5RySq9g2Ac0zPmRVVe23FVTwbLgoWfi22cS8q2ILkB/uhYwaM8NYUNj1yBEOtEmIlj7
         7Fh/YIHmxzyUso7V4WmBeRPxp0BslPmJhNs1AzFJEjtwf++L5UTZBDcnamuYMUqZcFou
         F32g==
X-Gm-Message-State: AOJu0YwNG++esC0i/aPJsQgR0lHCucLtGSUIsEY3mLdUzJ3t4w7yeax7
        aqMdUZmLq/P/b8ZALi064OA=
X-Google-Smtp-Source: AGHT+IGzDnL5tVBo4wcxnkuamAGEmBYWKRdTq19Gs3Vx3LGf6ljaPZZpKwUX+bB1aI4U1IS/XvXCjQ==
X-Received: by 2002:adf:f08a:0:b0:31f:f43e:4f3c with SMTP id n10-20020adff08a000000b0031ff43e4f3cmr7957780wro.8.1695378798659;
        Fri, 22 Sep 2023 03:33:18 -0700 (PDT)
Received: from gmail.com (1F2EF49C.nat.pool.telekom.hu. [31.46.244.156])
        by smtp.gmail.com with ESMTPSA id d4-20020adffd84000000b0031f34a395e7sm4055547wrr.45.2023.09.22.03.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 03:33:18 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Fri, 22 Sep 2023 12:33:16 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: [GIT PULL] x86 fixes
Message-ID: <ZQ1tbDIt+a6viYFc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2023-09-22

   # HEAD: 509ff51ee652c41a277c2b439aea01a8f56a27b9 x86/shstk: Add warning for shadow stack double unmap

Misc x86 fixes:

 - Fix a kexec bug,
 - Fix an UML build bug,
 - Fix a handful of SRSO related bugs,
 - Fix a shadow stacks handling bug & robustify related code.

 Thanks,

	Ingo

------------------>
Josh Poimboeuf (4):
      x86/srso: Fix srso_show_state() side effect
      x86/srso: Set CPUID feature bits independently of bug or mitigation status
      x86/srso: Don't probe microcode in a guest
      x86/srso: Fix SBPB enablement for spec_rstack_overflow=off

Rick Edgecombe (3):
      x86/shstk: Handle vfork clone failure correctly
      x86/shstk: Remove useless clone error handling
      x86/shstk: Add warning for shadow stack double unmap

Rik van Riel (1):
      x86/mm, kexec, ima: Use memblock_free_late() from ima_free_kexec_buffer()

Vincent Whitchurch (1):
      x86/asm: Fix build of UML with KASAN


 arch/x86/include/asm/linkage.h     |  7 +++++++
 arch/x86/include/asm/mmu_context.h |  3 +--
 arch/x86/include/asm/processor.h   |  2 --
 arch/x86/kernel/cpu/amd.c          | 28 +++++++++-------------------
 arch/x86/kernel/cpu/bugs.c         | 17 +++--------------
 arch/x86/kernel/process.c          |  7 -------
 arch/x86/kernel/setup.c            |  8 ++------
 arch/x86/kernel/shstk.c            | 33 +++++++++++++++++++++++++++++++--
 arch/x86/lib/memcpy_64.S           |  2 +-
 arch/x86/lib/memmove_64.S          |  2 +-
 arch/x86/lib/memset_64.S           |  2 +-
 11 files changed, 56 insertions(+), 55 deletions(-)

diff --git a/arch/x86/include/asm/linkage.h b/arch/x86/include/asm/linkage.h
index 5ff49fd67732..571fe4d2d232 100644
--- a/arch/x86/include/asm/linkage.h
+++ b/arch/x86/include/asm/linkage.h
@@ -105,6 +105,13 @@
 	CFI_POST_PADDING					\
 	SYM_FUNC_END(__cfi_##name)
 
+/* UML needs to be able to override memcpy() and friends for KASAN. */
+#ifdef CONFIG_UML
+# define SYM_FUNC_ALIAS_MEMFUNC	SYM_FUNC_ALIAS_WEAK
+#else
+# define SYM_FUNC_ALIAS_MEMFUNC	SYM_FUNC_ALIAS
+#endif
+
 /* SYM_TYPED_FUNC_START -- use for indirectly called globals, w/ CFI type */
 #define SYM_TYPED_FUNC_START(name)				\
 	SYM_TYPED_START(name, SYM_L_GLOBAL, SYM_F_ALIGN)	\
diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index 416901d406f8..8dac45a2c7fc 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -186,8 +186,7 @@ do {						\
 #else
 #define deactivate_mm(tsk, mm)			\
 do {						\
-	if (!tsk->vfork_done)			\
-		shstk_free(tsk);		\
+	shstk_free(tsk);			\
 	load_gs_index(0);			\
 	loadsegment(fs, 0);			\
 } while (0)
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 0086920cda06..a3669a7774ed 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -683,13 +683,11 @@ extern u16 get_llc_id(unsigned int cpu);
 #ifdef CONFIG_CPU_SUP_AMD
 extern u32 amd_get_nodes_per_socket(void);
 extern u32 amd_get_highest_perf(void);
-extern bool cpu_has_ibpb_brtype_microcode(void);
 extern void amd_clear_divider(void);
 extern void amd_check_microcode(void);
 #else
 static inline u32 amd_get_nodes_per_socket(void)	{ return 0; }
 static inline u32 amd_get_highest_perf(void)		{ return 0; }
-static inline bool cpu_has_ibpb_brtype_microcode(void)	{ return false; }
 static inline void amd_clear_divider(void)		{ }
 static inline void amd_check_microcode(void)		{ }
 #endif
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index dd8379d84445..03ef962a6992 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -766,6 +766,15 @@ static void early_init_amd(struct cpuinfo_x86 *c)
 
 	if (cpu_has(c, X86_FEATURE_TOPOEXT))
 		smp_num_siblings = ((cpuid_ebx(0x8000001e) >> 8) & 0xff) + 1;
+
+	if (!cpu_has(c, X86_FEATURE_HYPERVISOR) && !cpu_has(c, X86_FEATURE_IBPB_BRTYPE)) {
+		if (c->x86 == 0x17 && boot_cpu_has(X86_FEATURE_AMD_IBPB))
+			setup_force_cpu_cap(X86_FEATURE_IBPB_BRTYPE);
+		else if (c->x86 >= 0x19 && !wrmsrl_safe(MSR_IA32_PRED_CMD, PRED_CMD_SBPB)) {
+			setup_force_cpu_cap(X86_FEATURE_IBPB_BRTYPE);
+			setup_force_cpu_cap(X86_FEATURE_SBPB);
+		}
+	}
 }
 
 static void init_amd_k8(struct cpuinfo_x86 *c)
@@ -1301,25 +1310,6 @@ void amd_check_microcode(void)
 	on_each_cpu(zenbleed_check_cpu, NULL, 1);
 }
 
-bool cpu_has_ibpb_brtype_microcode(void)
-{
-	switch (boot_cpu_data.x86) {
-	/* Zen1/2 IBPB flushes branch type predictions too. */
-	case 0x17:
-		return boot_cpu_has(X86_FEATURE_AMD_IBPB);
-	case 0x19:
-		/* Poke the MSR bit on Zen3/4 to check its presence. */
-		if (!wrmsrl_safe(MSR_IA32_PRED_CMD, PRED_CMD_SBPB)) {
-			setup_force_cpu_cap(X86_FEATURE_SBPB);
-			return true;
-		} else {
-			return false;
-		}
-	default:
-		return false;
-	}
-}
-
 /*
  * Issue a DIV 0/1 insn to clear any division data from previous DIV
  * operations.
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index f081d26616ac..10499bcd4e39 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2404,26 +2404,15 @@ early_param("spec_rstack_overflow", srso_parse_cmdline);
 
 static void __init srso_select_mitigation(void)
 {
-	bool has_microcode;
+	bool has_microcode = boot_cpu_has(X86_FEATURE_IBPB_BRTYPE);
 
 	if (!boot_cpu_has_bug(X86_BUG_SRSO) || cpu_mitigations_off())
 		goto pred_cmd;
 
-	/*
-	 * The first check is for the kernel running as a guest in order
-	 * for guests to verify whether IBPB is a viable mitigation.
-	 */
-	has_microcode = boot_cpu_has(X86_FEATURE_IBPB_BRTYPE) || cpu_has_ibpb_brtype_microcode();
 	if (!has_microcode) {
 		pr_warn("IBPB-extending microcode not applied!\n");
 		pr_warn(SRSO_NOTICE);
 	} else {
-		/*
-		 * Enable the synthetic (even if in a real CPUID leaf)
-		 * flags for guests.
-		 */
-		setup_force_cpu_cap(X86_FEATURE_IBPB_BRTYPE);
-
 		/*
 		 * Zen1/2 with SMT off aren't vulnerable after the right
 		 * IBPB microcode has been applied.
@@ -2444,7 +2433,7 @@ static void __init srso_select_mitigation(void)
 
 	switch (srso_cmd) {
 	case SRSO_CMD_OFF:
-		return;
+		goto pred_cmd;
 
 	case SRSO_CMD_MICROCODE:
 		if (has_microcode) {
@@ -2717,7 +2706,7 @@ static ssize_t srso_show_state(char *buf)
 
 	return sysfs_emit(buf, "%s%s\n",
 			  srso_strings[srso_mitigation],
-			  (cpu_has_ibpb_brtype_microcode() ? "" : ", no microcode"));
+			  boot_cpu_has(X86_FEATURE_IBPB_BRTYPE) ? "" : ", no microcode");
 }
 
 static ssize_t gds_show_state(char *buf)
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 9f0909142a0a..b6f4e8399fca 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -257,13 +257,6 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 	if (!ret && unlikely(test_tsk_thread_flag(current, TIF_IO_BITMAP)))
 		io_bitmap_share(p);
 
-	/*
-	 * If copy_thread() if failing, don't leak the shadow stack possibly
-	 * allocated in shstk_alloc_thread_stack() above.
-	 */
-	if (ret)
-		shstk_free(p);
-
 	return ret;
 }
 
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index b9145a63da77..b098b1fa2470 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -358,15 +358,11 @@ static void __init add_early_ima_buffer(u64 phys_addr)
 #if defined(CONFIG_HAVE_IMA_KEXEC) && !defined(CONFIG_OF_FLATTREE)
 int __init ima_free_kexec_buffer(void)
 {
-	int rc;
-
 	if (!ima_kexec_buffer_size)
 		return -ENOENT;
 
-	rc = memblock_phys_free(ima_kexec_buffer_phys,
-				ima_kexec_buffer_size);
-	if (rc)
-		return rc;
+	memblock_free_late(ima_kexec_buffer_phys,
+			   ima_kexec_buffer_size);
 
 	ima_kexec_buffer_phys = 0;
 	ima_kexec_buffer_size = 0;
diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
index fd689921a1db..59e15dd8d0f8 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -205,10 +205,21 @@ unsigned long shstk_alloc_thread_stack(struct task_struct *tsk, unsigned long cl
 		return 0;
 
 	/*
-	 * For CLONE_VM, except vfork, the child needs a separate shadow
+	 * For CLONE_VFORK the child will share the parents shadow stack.
+	 * Make sure to clear the internal tracking of the thread shadow
+	 * stack so the freeing logic run for child knows to leave it alone.
+	 */
+	if (clone_flags & CLONE_VFORK) {
+		shstk->base = 0;
+		shstk->size = 0;
+		return 0;
+	}
+
+	/*
+	 * For !CLONE_VM the child will use a copy of the parents shadow
 	 * stack.
 	 */
-	if ((clone_flags & (CLONE_VFORK | CLONE_VM)) != CLONE_VM)
+	if (!(clone_flags & CLONE_VM))
 		return 0;
 
 	size = adjust_shstk_size(stack_size);
@@ -408,7 +419,25 @@ void shstk_free(struct task_struct *tsk)
 	if (!tsk->mm || tsk->mm != current->mm)
 		return;
 
+	/*
+	 * If shstk->base is NULL, then this task is not managing its
+	 * own shadow stack (CLONE_VFORK). So skip freeing it.
+	 */
+	if (!shstk->base)
+		return;
+
+	/*
+	 * shstk->base is NULL for CLONE_VFORK child tasks, and so is
+	 * normal. But size = 0 on a shstk->base is not normal and
+	 * indicated an attempt to free the thread shadow stack twice.
+	 * Warn about it.
+	 */
+	if (WARN_ON(!shstk->size))
+		return;
+
 	unmap_shadow_stack(shstk->base, shstk->size);
+
+	shstk->size = 0;
 }
 
 static int wrss_control(bool enable)
diff --git a/arch/x86/lib/memcpy_64.S b/arch/x86/lib/memcpy_64.S
index 8f95fb267caa..76697df8dfd5 100644
--- a/arch/x86/lib/memcpy_64.S
+++ b/arch/x86/lib/memcpy_64.S
@@ -40,7 +40,7 @@ SYM_TYPED_FUNC_START(__memcpy)
 SYM_FUNC_END(__memcpy)
 EXPORT_SYMBOL(__memcpy)
 
-SYM_FUNC_ALIAS(memcpy, __memcpy)
+SYM_FUNC_ALIAS_MEMFUNC(memcpy, __memcpy)
 EXPORT_SYMBOL(memcpy)
 
 SYM_FUNC_START_LOCAL(memcpy_orig)
diff --git a/arch/x86/lib/memmove_64.S b/arch/x86/lib/memmove_64.S
index 0559b206fb11..ccdf3a597045 100644
--- a/arch/x86/lib/memmove_64.S
+++ b/arch/x86/lib/memmove_64.S
@@ -212,5 +212,5 @@ SYM_FUNC_START(__memmove)
 SYM_FUNC_END(__memmove)
 EXPORT_SYMBOL(__memmove)
 
-SYM_FUNC_ALIAS(memmove, __memmove)
+SYM_FUNC_ALIAS_MEMFUNC(memmove, __memmove)
 EXPORT_SYMBOL(memmove)
diff --git a/arch/x86/lib/memset_64.S b/arch/x86/lib/memset_64.S
index 7c59a704c458..3d818b849ec6 100644
--- a/arch/x86/lib/memset_64.S
+++ b/arch/x86/lib/memset_64.S
@@ -40,7 +40,7 @@ SYM_FUNC_START(__memset)
 SYM_FUNC_END(__memset)
 EXPORT_SYMBOL(__memset)
 
-SYM_FUNC_ALIAS(memset, __memset)
+SYM_FUNC_ALIAS_MEMFUNC(memset, __memset)
 EXPORT_SYMBOL(memset)
 
 SYM_FUNC_START_LOCAL(memset_orig)
