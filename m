Return-Path: <linux-kernel+bounces-167358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7098BA86A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 217CA282F2B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 08:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECEB714F133;
	Fri,  3 May 2024 08:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DUs3vZu0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55C914F129;
	Fri,  3 May 2024 08:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714723943; cv=none; b=tIcat/1eeqbd+iTCdZ7kubonu/bTirVi3Q3Dw2j3QSiUvd1o79MuunYML4iwAXRfkc0NTu68I0OhEanrSkIgeQ6UPro48UYGknHkgy1ouEAw1DICxYC4ii9UauHvKSjIAYfRykvoP3pziz5OGO6rLTnrQQ8mIYj6kUugPQp+dRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714723943; c=relaxed/simple;
	bh=YN6K9FBT59Q5VK9x0yg00S0aWylIq7Jm1+1TRN6V8Do=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fVInfUzPu4z8WFJyzGcqkzPK8faiPsM5HufFvOlFKEG+8G9txdFQxUCoDdDRi3wEWJGRxNVHjhlbJXc0j4wwPG0s4L9ctZ0aqut68Kd9O3AykUmm9izYWryy7gSVvBcfzD5v1/n4N21kpGh4LH+qz65p9fbOYNQwCAoQmBBFX/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DUs3vZu0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 378B0C4AF18;
	Fri,  3 May 2024 08:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714723942;
	bh=YN6K9FBT59Q5VK9x0yg00S0aWylIq7Jm1+1TRN6V8Do=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DUs3vZu0/n7drgSj1856BM0I9FuwbENx/vgYEBXvVuPU0rEZAj06+9jYQggYdtq/2
	 E4HFuiQOMkTJHV63EEAFd5RTrFCrTNZ50+0n3vFgwFOUqyLOa/aCURhifn6tZig425
	 QG82OlE7Y/grrcAx0i5toEiWIxY9w/93w1u+JR3oL4C1RXgqi8za2bq9uH6CUkvs6i
	 Mqm8VrplxrPxTm1wWeyYG8TuW+zcLIzaCSdhl/j+w3Ph/8LOMsSGpqEWgrtc1tVO8i
	 njXq5mzpJxXNNzOydvkqlNnWqxy0njCeFqWmoLuowPbXRKlBW3BvbEEkY2ON0r+psN
	 Zd59OnczC9Smg==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-alpha@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Richard Henderson <richard.henderson@linaro.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Marc Zyngier <maz@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 06/14] alpha: missing includes
Date: Fri,  3 May 2024 10:11:17 +0200
Message-Id: <20240503081125.67990-7-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240503081125.67990-1-arnd@kernel.org>
References: <20240503081125.67990-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Al Viro <viro@zeniv.linux.org.uk>

.. and missing externs in proto.h

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/alpha/kernel/bugs.c          |  1 +
 arch/alpha/kernel/console.c       |  1 +
 arch/alpha/kernel/core_irongate.c |  1 -
 arch/alpha/kernel/irq.c           |  1 +
 arch/alpha/kernel/pci-noop.c      |  1 +
 arch/alpha/kernel/proto.h         | 31 +++++++++++++++++++++++++++----
 arch/alpha/kernel/smc37c669.c     |  2 ++
 arch/alpha/kernel/smc37c93x.c     |  2 ++
 arch/alpha/kernel/smp.c           |  1 +
 arch/alpha/kernel/srmcons.c       |  2 ++
 arch/alpha/kernel/sys_nautilus.c  |  2 --
 arch/alpha/lib/checksum.c         |  1 +
 arch/alpha/lib/fpreg.c            |  1 +
 arch/alpha/lib/memcpy.c           |  3 +++
 arch/alpha/math-emu/math.c        |  7 +------
 arch/alpha/mm/init.c              |  2 +-
 16 files changed, 45 insertions(+), 14 deletions(-)

diff --git a/arch/alpha/kernel/bugs.c b/arch/alpha/kernel/bugs.c
index 08cc10d7fa17..e8c51089325f 100644
--- a/arch/alpha/kernel/bugs.c
+++ b/arch/alpha/kernel/bugs.c
@@ -1,6 +1,7 @@
 
 #include <asm/hwrpb.h>
 #include <linux/device.h>
+#include <linux/cpu.h>
 
 
 #ifdef CONFIG_SYSFS
diff --git a/arch/alpha/kernel/console.c b/arch/alpha/kernel/console.c
index 5476279329a6..4193f76e9633 100644
--- a/arch/alpha/kernel/console.c
+++ b/arch/alpha/kernel/console.c
@@ -15,6 +15,7 @@
 #include <asm/machvec.h>
 
 #include "pci_impl.h"
+#include "proto.h"
 
 #ifdef CONFIG_VGA_HOSE
 
diff --git a/arch/alpha/kernel/core_irongate.c b/arch/alpha/kernel/core_irongate.c
index 6b8ed12936b6..05dc4c1b9074 100644
--- a/arch/alpha/kernel/core_irongate.c
+++ b/arch/alpha/kernel/core_irongate.c
@@ -226,7 +226,6 @@ albacore_init_arch(void)
 	if (memtop > pci_mem) {
 #ifdef CONFIG_BLK_DEV_INITRD
 		extern unsigned long initrd_start, initrd_end;
-		extern void *move_initrd(unsigned long);
 
 		/* Move the initrd out of the way. */
 		if (initrd_end && __pa(initrd_end) > pci_mem) {
diff --git a/arch/alpha/kernel/irq.c b/arch/alpha/kernel/irq.c
index 15f2effd6baf..c67047c5d830 100644
--- a/arch/alpha/kernel/irq.c
+++ b/arch/alpha/kernel/irq.c
@@ -28,6 +28,7 @@
 
 #include <asm/io.h>
 #include <linux/uaccess.h>
+#include "irq_impl.h"
 
 volatile unsigned long irq_err_count;
 DEFINE_PER_CPU(unsigned long, irq_pmi_count);
diff --git a/arch/alpha/kernel/pci-noop.c b/arch/alpha/kernel/pci-noop.c
index ae82061edae9..32ca59a5a704 100644
--- a/arch/alpha/kernel/pci-noop.c
+++ b/arch/alpha/kernel/pci-noop.c
@@ -17,6 +17,7 @@
 #include <linux/scatterlist.h>
 #include <linux/syscalls.h>
 
+#include "pci_impl.h"
 #include "proto.h"
 
 
diff --git a/arch/alpha/kernel/proto.h b/arch/alpha/kernel/proto.h
index 2c89c1c55712..5b1d0d71d479 100644
--- a/arch/alpha/kernel/proto.h
+++ b/arch/alpha/kernel/proto.h
@@ -15,6 +15,7 @@ struct pt_regs;
 struct task_struct;
 struct pci_dev;
 struct pci_controller;
+struct pci_bus;
 
 /* core_apecs.c */
 extern struct pci_ops apecs_pci_ops;
@@ -114,6 +115,9 @@ extern int boot_cpuid;
 #ifdef CONFIG_VERBOSE_MCHECK
 extern unsigned long alpha_verbose_mcheck;
 #endif
+#ifdef CONFIG_BLK_DEV_INITRD
+extern void * __init move_initrd(unsigned long);
+#endif
 extern struct screen_info vgacon_screen_info;
 
 /* srmcons.c */
@@ -128,6 +132,7 @@ extern void unregister_srm_console(void);
 /* smp.c */
 extern void setup_smp(void);
 extern void handle_ipi(struct pt_regs *);
+extern void __init smp_callin(void);
 
 /* bios32.c */
 /* extern void reset_for_srm(void); */
@@ -139,13 +144,13 @@ extern void common_init_rtc(void);
 extern unsigned long est_cycle_freq;
 
 /* smc37c93x.c */
-extern void SMC93x_Init(void);
+extern int __init SMC93x_Init(void);
 
 /* smc37c669.c */
-extern void SMC669_Init(int);
+extern void __init SMC669_Init(int);
 
 /* es1888.c */
-extern void es1888_init(void);
+extern void __init es1888_init(void);
 
 /* ../lib/fpreg.c */
 extern void alpha_write_fp_reg (unsigned long reg, unsigned long val);
@@ -166,19 +171,37 @@ extern void entSys(void);
 extern void entUna(void);
 extern void entDbg(void);
 
+/* pci.c */
+extern void pcibios_claim_one_bus(struct pci_bus *);
+
 /* ptrace.c */
 extern int ptrace_set_bpt (struct task_struct *child);
 extern int ptrace_cancel_bpt (struct task_struct *child);
+extern void syscall_trace_leave(void);
+extern unsigned long syscall_trace_enter(void);
+
+/* signal.c */
+struct sigcontext;
+extern void do_sigreturn(struct sigcontext __user *);
+struct rt_sigframe;
+extern void do_rt_sigreturn(struct rt_sigframe __user *);
+extern void do_work_pending(struct pt_regs *, unsigned long, unsigned long, unsigned long);
 
 /* traps.c */
 extern void dik_show_regs(struct pt_regs *regs, unsigned long *r9_15);
 extern void die_if_kernel(char *, struct pt_regs *, long, unsigned long *);
+extern void do_entInt(unsigned long, unsigned long, unsigned long, struct pt_regs *);
+extern void do_entArith(unsigned long, unsigned long, struct pt_regs *);
+extern void do_entIF(unsigned long, struct pt_regs *);
+extern void do_entDbg(struct pt_regs *);
+struct allregs;
+extern void do_entUna(void *, unsigned long, unsigned long, struct allregs *);
+extern void do_entUnaUser(void __user *, unsigned long, unsigned long, struct pt_regs *);
 
 /* sys_titan.c */
 extern void titan_dispatch_irqs(u64);
 
 /* ../mm/init.c */
-extern void switch_to_system_map(void);
 extern void srm_paging_stop(void);
 
 static inline int
diff --git a/arch/alpha/kernel/smc37c669.c b/arch/alpha/kernel/smc37c669.c
index cb8726b667da..a5a6ed97a6ce 100644
--- a/arch/alpha/kernel/smc37c669.c
+++ b/arch/alpha/kernel/smc37c669.c
@@ -11,6 +11,8 @@
 #include <asm/hwrpb.h>
 #include <asm/io.h>
 
+#include "proto.h"
+
 #if 0
 # define DBG_DEVS(args)         printk args
 #else
diff --git a/arch/alpha/kernel/smc37c93x.c b/arch/alpha/kernel/smc37c93x.c
index 71cd7aca38ce..8028273f0d16 100644
--- a/arch/alpha/kernel/smc37c93x.c
+++ b/arch/alpha/kernel/smc37c93x.c
@@ -12,6 +12,8 @@
 #include <asm/hwrpb.h>
 #include <asm/io.h>
 
+#include "proto.h"
+
 #define SMC_DEBUG 0
 
 #if SMC_DEBUG
diff --git a/arch/alpha/kernel/smp.c b/arch/alpha/kernel/smp.c
index 8e9dd63b220c..ed06367ece57 100644
--- a/arch/alpha/kernel/smp.c
+++ b/arch/alpha/kernel/smp.c
@@ -38,6 +38,7 @@
 #include <asm/irq.h>
 #include <asm/mmu_context.h>
 #include <asm/tlbflush.h>
+#include <asm/cacheflush.h>
 
 #include "proto.h"
 #include "irq_impl.h"
diff --git a/arch/alpha/kernel/srmcons.c b/arch/alpha/kernel/srmcons.c
index feaf89f6936b..3e61073f4b30 100644
--- a/arch/alpha/kernel/srmcons.c
+++ b/arch/alpha/kernel/srmcons.c
@@ -21,6 +21,8 @@
 #include <asm/console.h>
 #include <linux/uaccess.h>
 
+#include "proto.h"
+
 
 static DEFINE_SPINLOCK(srmcons_callback_lock);
 static int srm_is_registered_console = 0;
diff --git a/arch/alpha/kernel/sys_nautilus.c b/arch/alpha/kernel/sys_nautilus.c
index 4dcee81606a5..13b79960b4b9 100644
--- a/arch/alpha/kernel/sys_nautilus.c
+++ b/arch/alpha/kernel/sys_nautilus.c
@@ -184,8 +184,6 @@ nautilus_machine_check(unsigned long vector, unsigned long la_ptr)
 	mb();
 }
 
-extern void pcibios_claim_one_bus(struct pci_bus *);
-
 static struct resource irongate_mem = {
 	.name	= "Irongate PCI MEM",
 	.flags	= IORESOURCE_MEM,
diff --git a/arch/alpha/lib/checksum.c b/arch/alpha/lib/checksum.c
index 3f35c3ed6948..17fa230baeef 100644
--- a/arch/alpha/lib/checksum.c
+++ b/arch/alpha/lib/checksum.c
@@ -12,6 +12,7 @@
  
 #include <linux/module.h>
 #include <linux/string.h>
+#include <net/checksum.h>
 
 #include <asm/byteorder.h>
 
diff --git a/arch/alpha/lib/fpreg.c b/arch/alpha/lib/fpreg.c
index 7c08b225261c..eee11fb4c7f1 100644
--- a/arch/alpha/lib/fpreg.c
+++ b/arch/alpha/lib/fpreg.c
@@ -9,6 +9,7 @@
 #include <linux/export.h>
 #include <linux/preempt.h>
 #include <asm/thread_info.h>
+#include <asm/fpu.h>
 
 #if defined(CONFIG_ALPHA_EV6) || defined(CONFIG_ALPHA_EV67)
 #define STT(reg,val)  asm volatile ("ftoit $f"#reg",%0" : "=r"(val));
diff --git a/arch/alpha/lib/memcpy.c b/arch/alpha/lib/memcpy.c
index cbac3dc6d963..78b6850a9d53 100644
--- a/arch/alpha/lib/memcpy.c
+++ b/arch/alpha/lib/memcpy.c
@@ -18,6 +18,7 @@
 
 #include <linux/types.h>
 #include <linux/export.h>
+#include <linux/string.h>
 
 /*
  * This should be done in one go with ldq_u*2/mask/stq_u. Do it
@@ -150,6 +151,8 @@ static inline void __memcpy_aligned_dn (unsigned long d, unsigned long s,
 	DO_REST_ALIGNED_DN(d,s,n);
 }
 
+#undef memcpy
+
 void * memcpy(void * dest, const void *src, size_t n)
 {
 	if (!(((unsigned long) dest ^ (unsigned long) src) & 7)) {
diff --git a/arch/alpha/math-emu/math.c b/arch/alpha/math-emu/math.c
index 4212258f3cfd..68d420bfd3c0 100644
--- a/arch/alpha/math-emu/math.c
+++ b/arch/alpha/math-emu/math.c
@@ -4,6 +4,7 @@
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <asm/ptrace.h>
+#include <asm/fpu.h>
 
 #include <linux/uaccess.h>
 
@@ -45,12 +46,6 @@
 #define MISC_TRAPB	0x0000
 #define MISC_EXCB	0x0400
 
-extern unsigned long alpha_read_fp_reg (unsigned long reg);
-extern void alpha_write_fp_reg (unsigned long reg, unsigned long val);
-extern unsigned long alpha_read_fp_reg_s (unsigned long reg);
-extern void alpha_write_fp_reg_s (unsigned long reg, unsigned long val);
-
-
 #ifdef MODULE
 
 MODULE_DESCRIPTION("FP Software completion module");
diff --git a/arch/alpha/mm/init.c b/arch/alpha/mm/init.c
index a155180d7a83..4fe618446e4c 100644
--- a/arch/alpha/mm/init.c
+++ b/arch/alpha/mm/init.c
@@ -33,7 +33,7 @@
 #include <asm/setup.h>
 #include <asm/sections.h>
 
-extern void die_if_kernel(char *,struct pt_regs *,long);
+#include "../kernel/proto.h"
 
 static struct pcb_struct original_pcb;
 
-- 
2.39.2


