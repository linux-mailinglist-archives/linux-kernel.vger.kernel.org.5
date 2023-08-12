Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF4F77A0FA
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 18:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjHLQQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 12:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjHLQP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 12:15:59 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382B510DE
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 09:16:01 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-5230a22cfd1so3843690a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 09:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691856960; x=1692461760;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lNiYszoad1By9bywuMbzy6eH+wl6dwjgsokF6RKZdPM=;
        b=Ev7hb5H9/zb5XZfjGAQlfq+iOvJvHt0CUTXZOO2YXWyisQriiIfE84IpLM3kUkFQX9
         AFY+hw9jjajo9uHLkFZIVAW3ZXGxG90W+tAkm1jYf44CRdDWLvEIIhbyAPdNNRwub4hK
         TYV4/KyBYu4f4IboHN5AFYLPK+94c6zg4+ITEfvFMy9vjoAFxfjYhFo9VrbGxrlla7cf
         iwS4IyvDu+RiPDjm0IxBFLKVTBs3gWAPetUu4BppF5+Pl2KVA7XsqtKkGRcWxNs1z1dr
         UoU/4NqRnggasIbkNM37coAg0SJQbZ/AbFEEO7n7I1ilb0PkEhLOYCpE1Ym9e1GVeM1n
         hk3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691856960; x=1692461760;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lNiYszoad1By9bywuMbzy6eH+wl6dwjgsokF6RKZdPM=;
        b=fAaCUSKhM1zukKdWic14aKBQeZcg0zAkflxP62Bev622zHQAemMHT+R6YA3hje0iYg
         qXoYZYOTRv6UOFaBXDOduIXWa3RJSva6DgaawMcNQV7Rd7m33CpXbKbK5UJv/Z3SowD8
         Dr+kcJEZMeyRFCU/BQJ2FPPbL3VBeJaQNDh5e4T0zxqSsiAnVkNsT2agHi3VGiRZf9lU
         Wd+HdKlruEScNrxA9RQEwroMCJDBkxwHW1CU240jh77HlJu+tvjMy9QfTkzrREbSEepQ
         8rm0sMrbXSMhyYhJqwls99mNLg0DGq1C9cKPO2s7NE86Kh3ky11XSFa9Xp1bTrOjPWlJ
         tfvA==
X-Gm-Message-State: AOJu0Yz4t79prrRRygVj+gSvyc5j/6k43jMOmnLBgSeC9n5WqkBqgRYq
        eVtSgTR2V7JZJ2WmW+aUhQRcI5huB/c=
X-Google-Smtp-Source: AGHT+IFpGF34grH7PxJJRby0Y+RwKNnpxqNEQ/kAwkSpW2E3AzCAVoXd4H0ixw4+UMiW66RmD4VY0Q==
X-Received: by 2002:a05:6402:141:b0:522:b112:6254 with SMTP id s1-20020a056402014100b00522b1126254mr3652048edu.4.1691856959428;
        Sat, 12 Aug 2023 09:15:59 -0700 (PDT)
Received: from f.. (cst-prg-75-195.cust.vodafone.cz. [46.135.75.195])
        by smtp.gmail.com with ESMTPSA id k19-20020aa7d8d3000000b0051df67eaf62sm3430860eds.42.2023.08.12.09.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Aug 2023 09:15:58 -0700 (PDT)
From:   Mateusz Guzik <mjguzik@gmail.com>
To:     torvalds@linux-foundation.org
Cc:     brauner@kernel.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] locking: remove spin_lock_prefetch
Date:   Sat, 12 Aug 2023 18:15:54 +0200
Message-Id: <20230812161554.1676652-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only remaining consumer is new_inode, where it showed up in 2001 in
the following commit in a historical repo [1]:

commit c37fa164f793735b32aa3f53154ff1a7659e6442
Author: linus1 <torvalds@athlon.transmeta.com>
Date:   Thu Aug 16 11:00:00 2001 -0800

    v2.4.9.9 -> v2.4.9.10

with a changelog which does not mention it.

Since then the line got only touched up to keep compiling.

While it may have been of benefit back in the day, it is guaranteed to
at best not get in the way in the multicore setting -- as the code
performs *a lot* of work between the prefetch and actual lock acquire,
any contention means the cacheline is already invalid by the time the
routine calls spin_lock(). It adds spurious traffic, for short.

On top of it prefetch is notoriously tricky to use for single-threaded
purposes, making it questionable from the get go.

As such, remove it.

I admit upfront I did not see value in benchmarking this change, but I
can do it if that is deemed appropriate.

Removal from new_inode and of the entire thing are in the same patch as
requested by Linus, so whatever weird looks can be directed at that guy.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/commit/fs/inode.c?id=c37fa164f793735b32aa3f53154ff1a7659e6442

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 arch/alpha/include/asm/processor.h                  | 13 -------------
 arch/arm64/include/asm/processor.h                  |  8 --------
 arch/ia64/include/asm/processor.h                   |  3 ---
 .../asm/mach-cavium-octeon/cpu-feature-overrides.h  |  2 --
 arch/powerpc/include/asm/processor.h                |  3 ---
 arch/sparc/include/asm/processor_64.h               |  3 ---
 arch/x86/include/asm/processor.h                    |  6 ------
 fs/inode.c                                          |  3 ---
 include/linux/prefetch.h                            |  7 +------
 9 files changed, 1 insertion(+), 47 deletions(-)

diff --git a/arch/alpha/include/asm/processor.h b/arch/alpha/include/asm/processor.h
index 714abe494e5f..55bb1c09fd39 100644
--- a/arch/alpha/include/asm/processor.h
+++ b/arch/alpha/include/asm/processor.h
@@ -47,12 +47,6 @@ unsigned long __get_wchan(struct task_struct *p);
 
 #define ARCH_HAS_PREFETCH
 #define ARCH_HAS_PREFETCHW
-#define ARCH_HAS_SPINLOCK_PREFETCH
-
-#ifndef CONFIG_SMP
-/* Nothing to prefetch. */
-#define spin_lock_prefetch(lock)  	do { } while (0)
-#endif
 
 extern inline void prefetch(const void *ptr)  
 { 
@@ -64,11 +58,4 @@ extern inline void prefetchw(const void *ptr)
 	__builtin_prefetch(ptr, 1, 3);
 }
 
-#ifdef CONFIG_SMP
-extern inline void spin_lock_prefetch(const void *ptr)  
-{
-	__builtin_prefetch(ptr, 1, 3);
-}
-#endif
-
 #endif /* __ASM_ALPHA_PROCESSOR_H */
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 3918f2a67970..e5bc54522e71 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -359,14 +359,6 @@ static inline void prefetchw(const void *ptr)
 	asm volatile("prfm pstl1keep, %a0\n" : : "p" (ptr));
 }
 
-#define ARCH_HAS_SPINLOCK_PREFETCH
-static inline void spin_lock_prefetch(const void *ptr)
-{
-	asm volatile(ARM64_LSE_ATOMIC_INSN(
-		     "prfm pstl1strm, %a0",
-		     "nop") : : "p" (ptr));
-}
-
 extern unsigned long __ro_after_init signal_minsigstksz; /* sigframe size */
 extern void __init minsigstksz_setup(void);
 
diff --git a/arch/ia64/include/asm/processor.h b/arch/ia64/include/asm/processor.h
index d1978e004054..47e3801b526a 100644
--- a/arch/ia64/include/asm/processor.h
+++ b/arch/ia64/include/asm/processor.h
@@ -634,7 +634,6 @@ ia64_imva (void *addr)
 
 #define ARCH_HAS_PREFETCH
 #define ARCH_HAS_PREFETCHW
-#define ARCH_HAS_SPINLOCK_PREFETCH
 #define PREFETCH_STRIDE			L1_CACHE_BYTES
 
 static inline void
@@ -649,8 +648,6 @@ prefetchw (const void *x)
 	ia64_lfetch_excl(ia64_lfhint_none, x);
 }
 
-#define spin_lock_prefetch(x)	prefetchw(x)
-
 extern unsigned long boot_option_idle_override;
 
 enum idle_boot_override {IDLE_NO_OVERRIDE=0, IDLE_HALT, IDLE_FORCE_MWAIT,
diff --git a/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h b/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h
index 9151dcd9d0d5..af9cea21c853 100644
--- a/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h
@@ -58,8 +58,6 @@
 
 #define cpu_has_rixi		(cpu_data[0].cputype != CPU_CAVIUM_OCTEON)
 
-#define ARCH_HAS_SPINLOCK_PREFETCH 1
-#define spin_lock_prefetch(x) prefetch(x)
 #define PREFETCH_STRIDE 128
 
 #ifdef __OCTEON__
diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index 8a6754ffdc7e..a6c7069bec5d 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -393,7 +393,6 @@ int validate_sp_size(unsigned long sp, struct task_struct *p,
  */
 #define ARCH_HAS_PREFETCH
 #define ARCH_HAS_PREFETCHW
-#define ARCH_HAS_SPINLOCK_PREFETCH
 
 static inline void prefetch(const void *x)
 {
@@ -411,8 +410,6 @@ static inline void prefetchw(const void *x)
 	__asm__ __volatile__ ("dcbtst 0,%0" : : "r" (x));
 }
 
-#define spin_lock_prefetch(x)	prefetchw(x)
-
 /* asm stubs */
 extern unsigned long isa300_idle_stop_noloss(unsigned long psscr_val);
 extern unsigned long isa300_idle_stop_mayloss(unsigned long psscr_val);
diff --git a/arch/sparc/include/asm/processor_64.h b/arch/sparc/include/asm/processor_64.h
index 2667f35d5ea5..0a0d5c3d184c 100644
--- a/arch/sparc/include/asm/processor_64.h
+++ b/arch/sparc/include/asm/processor_64.h
@@ -213,7 +213,6 @@ unsigned long __get_wchan(struct task_struct *task);
  */
 #define ARCH_HAS_PREFETCH
 #define ARCH_HAS_PREFETCHW
-#define ARCH_HAS_SPINLOCK_PREFETCH
 
 static inline void prefetch(const void *x)
 {
@@ -239,8 +238,6 @@ static inline void prefetchw(const void *x)
 			     : "r" (x));
 }
 
-#define spin_lock_prefetch(x)	prefetchw(x)
-
 #define HAVE_ARCH_PICK_MMAP_LAYOUT
 
 int do_mathemu(struct pt_regs *regs, struct fpustate *f, bool illegal_insn_trap);
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 973db0406528..5ea5b0f82564 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -586,7 +586,6 @@ extern char			ignore_fpu_irq;
 
 #define HAVE_ARCH_PICK_MMAP_LAYOUT 1
 #define ARCH_HAS_PREFETCHW
-#define ARCH_HAS_SPINLOCK_PREFETCH
 
 #ifdef CONFIG_X86_32
 # define BASE_PREFETCH		""
@@ -620,11 +619,6 @@ static __always_inline void prefetchw(const void *x)
 			  "m" (*(const char *)x));
 }
 
-static inline void spin_lock_prefetch(const void *x)
-{
-	prefetchw(x);
-}
-
 #define TOP_OF_INIT_STACK ((unsigned long)&init_stack + sizeof(init_stack) - \
 			   TOP_OF_KERNEL_STACK_PADDING)
 
diff --git a/fs/inode.c b/fs/inode.c
index 8fefb69e1f84..67611a360031 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -16,7 +16,6 @@
 #include <linux/fsnotify.h>
 #include <linux/mount.h>
 #include <linux/posix_acl.h>
-#include <linux/prefetch.h>
 #include <linux/buffer_head.h> /* for inode_has_buffers */
 #include <linux/ratelimit.h>
 #include <linux/list_lru.h>
@@ -1041,8 +1040,6 @@ struct inode *new_inode(struct super_block *sb)
 {
 	struct inode *inode;
 
-	spin_lock_prefetch(&sb->s_inode_list_lock);
-
 	inode = new_inode_pseudo(sb);
 	if (inode)
 		inode_sb_list_add(inode);
diff --git a/include/linux/prefetch.h b/include/linux/prefetch.h
index b83a3f944f28..b068e2e60939 100644
--- a/include/linux/prefetch.h
+++ b/include/linux/prefetch.h
@@ -25,11 +25,10 @@ struct page;
 	prefetch() should be defined by the architecture, if not, the 
 	#define below provides a no-op define.	
 	
-	There are 3 prefetch() macros:
+	There are 2 prefetch() macros:
 	
 	prefetch(x)  	- prefetches the cacheline at "x" for read
 	prefetchw(x)	- prefetches the cacheline at "x" for write
-	spin_lock_prefetch(x) - prefetches the spinlock *x for taking
 	
 	there is also PREFETCH_STRIDE which is the architecure-preferred 
 	"lookahead" size for prefetching streamed operations.
@@ -44,10 +43,6 @@ struct page;
 #define prefetchw(x) __builtin_prefetch(x,1)
 #endif
 
-#ifndef ARCH_HAS_SPINLOCK_PREFETCH
-#define spin_lock_prefetch(x) prefetchw(x)
-#endif
-
 #ifndef PREFETCH_STRIDE
 #define PREFETCH_STRIDE (4*L1_CACHE_BYTES)
 #endif
-- 
2.39.2

