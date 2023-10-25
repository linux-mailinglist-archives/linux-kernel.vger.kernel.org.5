Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0AE7D6807
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 12:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234026AbjJYKPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 06:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234590AbjJYKPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 06:15:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350CE128;
        Wed, 25 Oct 2023 03:14:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8EE6C433C9;
        Wed, 25 Oct 2023 10:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698228897;
        bh=XovEByLfZGLTnm35dA6OG6/SO48+Hhd1FRZPLpCKOn8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GJxhrkTkW7XD3rfXAJX57RQ+UuGEVR9LiR70+7a0knE8cRHGslKdLCm0OYRr4zF+h
         os8UqyOm0nzeFFOT+lm/gwxtBfIP7w09xSdSj0eREexSf2AKMcbfP7bOtNp9Y0b5sM
         +N2+Ofz0/z1GMhHYsZXgIegGtekMcY0+VTuWEAN8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.15.137
Date:   Wed, 25 Oct 2023 12:14:45 +0200
Message-ID: <2023102545-detonate-shelter-79fe@gregkh>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <2023102545-staining-shaking-b65f@gregkh>
References: <2023102545-staining-shaking-b65f@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/admin-guide/sysctl/net.rst
index 806ecd5957a4..aad6db9c1c83 100644
--- a/Documentation/admin-guide/sysctl/net.rst
+++ b/Documentation/admin-guide/sysctl/net.rst
@@ -31,18 +31,18 @@ see only some of them, depending on your kernel's configuration.
 
 Table : Subdirectories in /proc/sys/net
 
- ========= =================== = ========== ==================
+ ========= =================== = ========== ===================
  Directory Content               Directory  Content
- ========= =================== = ========== ==================
- 802       E802 protocol         mptcp     Multipath TCP
- appletalk Appletalk protocol    netfilter Network Filter
+ ========= =================== = ========== ===================
+ 802       E802 protocol         mptcp      Multipath TCP
+ appletalk Appletalk protocol    netfilter  Network Filter
  ax25      AX25                  netrom     NET/ROM
- bridge    Bridging              rose      X.25 PLP layer
- core      General parameter     tipc      TIPC
- ethernet  Ethernet protocol     unix      Unix domain sockets
- ipv4      IP version 4          x25       X.25 protocol
+ bridge    Bridging              rose       X.25 PLP layer
+ core      General parameter     tipc       TIPC
+ ethernet  Ethernet protocol     unix       Unix domain sockets
+ ipv4      IP version 4          x25        X.25 protocol
  ipv6      IP version 6
- ========= =================== = ========== ==================
+ ========= =================== = ========== ===================
 
 1. /proc/sys/net/core - Network core options
 ============================================
diff --git a/Makefile b/Makefile
index 703a9bd4e714..6e88459f2ab1 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 15
-SUBLEVEL = 136
+SUBLEVEL = 137
 EXTRAVERSION =
 NAME = Trick or Treat
 
diff --git a/arch/arm/boot/dts/motorola-mapphone-common.dtsi b/arch/arm/boot/dts/motorola-mapphone-common.dtsi
index 67c68c61ae02..2ac1ed8ad819 100644
--- a/arch/arm/boot/dts/motorola-mapphone-common.dtsi
+++ b/arch/arm/boot/dts/motorola-mapphone-common.dtsi
@@ -640,6 +640,7 @@ &uart1 {
 &uart3 {
 	interrupts-extended = <&wakeupgen GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH
 			       &omap4_pmx_core 0x17c>;
+	overrun-throttle-ms = <500>;
 };
 
 &uart4 {
diff --git a/arch/powerpc/include/asm/book3s/32/kup.h b/arch/powerpc/include/asm/book3s/32/kup.h
index 9f38040f0641..e3db5ed4b255 100644
--- a/arch/powerpc/include/asm/book3s/32/kup.h
+++ b/arch/powerpc/include/asm/book3s/32/kup.h
@@ -12,7 +12,6 @@
 #include <linux/jump_label.h>
 
 extern struct static_key_false disable_kuap_key;
-extern struct static_key_false disable_kuep_key;
 
 static __always_inline bool kuap_is_disabled(void)
 {
@@ -21,41 +20,7 @@ static __always_inline bool kuap_is_disabled(void)
 
 static __always_inline bool kuep_is_disabled(void)
 {
-	return !IS_ENABLED(CONFIG_PPC_KUEP) || static_branch_unlikely(&disable_kuep_key);
-}
-
-static inline void kuep_lock(void)
-{
-	if (kuep_is_disabled())
-		return;
-
-	update_user_segments(mfsr(0) | SR_NX);
-	/*
-	 * This isync() shouldn't be necessary as the kernel is not excepted to
-	 * run any instruction in userspace soon after the update of segments,
-	 * but hash based cores (at least G3) seem to exhibit a random
-	 * behaviour when the 'isync' is not there. 603 cores don't have this
-	 * behaviour so don't do the 'isync' as it saves several CPU cycles.
-	 */
-	if (mmu_has_feature(MMU_FTR_HPTE_TABLE))
-		isync();	/* Context sync required after mtsr() */
-}
-
-static inline void kuep_unlock(void)
-{
-	if (kuep_is_disabled())
-		return;
-
-	update_user_segments(mfsr(0) & ~SR_NX);
-	/*
-	 * This isync() shouldn't be necessary as a 'rfi' will soon be executed
-	 * to return to userspace, but hash based cores (at least G3) seem to
-	 * exhibit a random behaviour when the 'isync' is not there. 603 cores
-	 * don't have this behaviour so don't do the 'isync' as it saves several
-	 * CPU cycles.
-	 */
-	if (mmu_has_feature(MMU_FTR_HPTE_TABLE))
-		isync();	/* Context sync required after mtsr() */
+	return !IS_ENABLED(CONFIG_PPC_KUEP);
 }
 
 #ifdef CONFIG_PPC_KUAP
diff --git a/arch/powerpc/include/asm/book3s/32/mmu-hash.h b/arch/powerpc/include/asm/book3s/32/mmu-hash.h
index 94ad7acfd056..d4bf2a67396b 100644
--- a/arch/powerpc/include/asm/book3s/32/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/32/mmu-hash.h
@@ -64,7 +64,82 @@ struct ppc_bat {
 #define SR_KP	0x20000000	/* User key */
 #define SR_KS	0x40000000	/* Supervisor key */
 
-#ifndef __ASSEMBLY__
+#ifdef __ASSEMBLY__
+
+#include <asm/asm-offsets.h>
+
+.macro uus_addi sr reg1 reg2 imm
+	.if NUM_USER_SEGMENTS > \sr
+	addi	\reg1,\reg2,\imm
+	.endif
+.endm
+
+.macro uus_mtsr sr reg1
+	.if NUM_USER_SEGMENTS > \sr
+	mtsr	\sr, \reg1
+	.endif
+.endm
+
+/*
+ * This isync() shouldn't be necessary as the kernel is not excepted to run
+ * any instruction in userspace soon after the update of segments and 'rfi'
+ * instruction is used to return to userspace, but hash based cores
+ * (at least G3) seem to exhibit a random behaviour when the 'isync' is not
+ * there. 603 cores don't have this behaviour so don't do the 'isync' as it
+ * saves several CPU cycles.
+ */
+.macro uus_isync
+#ifdef CONFIG_PPC_BOOK3S_604
+BEGIN_MMU_FTR_SECTION
+	isync
+END_MMU_FTR_SECTION_IFSET(MMU_FTR_HPTE_TABLE)
+#endif
+.endm
+
+.macro update_user_segments_by_4 tmp1 tmp2 tmp3 tmp4
+	uus_addi	1, \tmp2, \tmp1, 0x111
+	uus_addi	2, \tmp3, \tmp1, 0x222
+	uus_addi	3, \tmp4, \tmp1, 0x333
+
+	uus_mtsr	0, \tmp1
+	uus_mtsr	1, \tmp2
+	uus_mtsr	2, \tmp3
+	uus_mtsr	3, \tmp4
+
+	uus_addi	4, \tmp1, \tmp1, 0x444
+	uus_addi	5, \tmp2, \tmp2, 0x444
+	uus_addi	6, \tmp3, \tmp3, 0x444
+	uus_addi	7, \tmp4, \tmp4, 0x444
+
+	uus_mtsr	4, \tmp1
+	uus_mtsr	5, \tmp2
+	uus_mtsr	6, \tmp3
+	uus_mtsr	7, \tmp4
+
+	uus_addi	8, \tmp1, \tmp1, 0x444
+	uus_addi	9, \tmp2, \tmp2, 0x444
+	uus_addi	10, \tmp3, \tmp3, 0x444
+	uus_addi	11, \tmp4, \tmp4, 0x444
+
+	uus_mtsr	8, \tmp1
+	uus_mtsr	9, \tmp2
+	uus_mtsr	10, \tmp3
+	uus_mtsr	11, \tmp4
+
+	uus_addi	12, \tmp1, \tmp1, 0x444
+	uus_addi	13, \tmp2, \tmp2, 0x444
+	uus_addi	14, \tmp3, \tmp3, 0x444
+	uus_addi	15, \tmp4, \tmp4, 0x444
+
+	uus_mtsr	12, \tmp1
+	uus_mtsr	13, \tmp2
+	uus_mtsr	14, \tmp3
+	uus_mtsr	15, \tmp4
+
+	uus_isync
+.endm
+
+#else
 
 /*
  * This macro defines the mapping from contexts to VSIDs (virtual
diff --git a/arch/powerpc/include/asm/interrupt.h b/arch/powerpc/include/asm/interrupt.h
index a07960066b5f..e592e65e7665 100644
--- a/arch/powerpc/include/asm/interrupt.h
+++ b/arch/powerpc/include/asm/interrupt.h
@@ -139,12 +139,10 @@ static inline void interrupt_enter_prepare(struct pt_regs *regs, struct interrup
 	if (!arch_irq_disabled_regs(regs))
 		trace_hardirqs_off();
 
-	if (user_mode(regs)) {
-		kuep_lock();
+	if (user_mode(regs))
 		account_cpu_user_entry();
-	} else {
+	else
 		kuap_save_and_lock(regs);
-	}
 #endif
 
 #ifdef CONFIG_PPC64
diff --git a/arch/powerpc/include/asm/kup.h b/arch/powerpc/include/asm/kup.h
index 1df763002726..34ff86e3686e 100644
--- a/arch/powerpc/include/asm/kup.h
+++ b/arch/powerpc/include/asm/kup.h
@@ -38,11 +38,6 @@ void setup_kuep(bool disabled);
 static inline void setup_kuep(bool disabled) { }
 #endif /* CONFIG_PPC_KUEP */
 
-#ifndef CONFIG_PPC_BOOK3S_32
-static inline void kuep_lock(void) { }
-static inline void kuep_unlock(void) { }
-#endif
-
 #ifdef CONFIG_PPC_KUAP
 void setup_kuap(bool disabled);
 #else
diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index c62dd9815965..3eb3c74e402b 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -73,6 +73,34 @@ prepare_transfer_to_handler:
 _ASM_NOKPROBE_SYMBOL(prepare_transfer_to_handler)
 #endif /* CONFIG_PPC_BOOK3S_32 || CONFIG_E500 */
 
+#if defined(CONFIG_PPC_KUEP) && defined(CONFIG_PPC_BOOK3S_32)
+	.globl	__kuep_lock
+__kuep_lock:
+	mfsr    r9,0
+	rlwinm  r9,r9,0,8,3
+	oris    r9,r9,SR_NX@h
+	update_user_segments_by_4 r9, r10, r11, r12
+	blr
+
+__kuep_unlock:
+	mfsr    r9,0
+	rlwinm  r9,r9,0,8,2
+	update_user_segments_by_4 r9, r10, r11, r12
+	blr
+
+.macro	kuep_lock
+	bl	__kuep_lock
+.endm
+.macro	kuep_unlock
+	bl	__kuep_unlock
+.endm
+#else
+.macro	kuep_lock
+.endm
+.macro	kuep_unlock
+.endm
+#endif
+
 	.globl	transfer_to_syscall
 transfer_to_syscall:
 	stw	r11, GPR1(r1)
@@ -93,6 +121,7 @@ transfer_to_syscall:
 	SAVE_GPRS(3, 8, r1)
 	addi	r2,r10,-THREAD
 	SAVE_NVGPRS(r1)
+	kuep_lock
 
 	/* Calling convention has r9 = orig r0, r10 = regs */
 	addi	r10,r1,STACK_FRAME_OVERHEAD
@@ -107,8 +136,10 @@ ret_from_syscall:
 	lis	r4,icache_44x_need_flush@ha
 	lwz	r5,icache_44x_need_flush@l(r4)
 	cmplwi	cr0,r5,0
-	bne-	2f
+	bne-	.L44x_icache_flush
 #endif /* CONFIG_PPC_47x */
+.L44x_icache_flush_return:
+	kuep_unlock
 	lwz	r4,_LINK(r1)
 	lwz	r5,_CCR(r1)
 	mtlr	r4
@@ -143,10 +174,11 @@ syscall_exit_finish:
 	b	1b
 
 #ifdef CONFIG_44x
-2:	li	r7,0
+.L44x_icache_flush:
+	li	r7,0
 	iccci	r0,r0
 	stw	r7,icache_44x_need_flush@l(r4)
-	b	1b
+	b	.L44x_icache_flush_return
 #endif  /* CONFIG_44x */
 
 	.globl	ret_from_fork
@@ -272,6 +304,7 @@ interrupt_return:
 	beq	.Lkernel_interrupt_return
 	bl	interrupt_exit_user_prepare
 	cmpwi	r3,0
+	kuep_unlock
 	bne-	.Lrestore_nvgprs
 
 .Lfast_user_interrupt_return:
diff --git a/arch/powerpc/kernel/head_32.h b/arch/powerpc/kernel/head_32.h
index 261c79bdbe53..c3286260a7d1 100644
--- a/arch/powerpc/kernel/head_32.h
+++ b/arch/powerpc/kernel/head_32.h
@@ -135,6 +135,12 @@ _ASM_NOKPROBE_SYMBOL(\name\()_virt)
 	andi.	r12,r9,MSR_PR
 	bne	777f
 	bl	prepare_transfer_to_handler
+#ifdef CONFIG_PPC_KUEP
+	b	778f
+777:
+	bl	__kuep_lock
+778:
+#endif
 777:
 #endif
 .endm
diff --git a/arch/powerpc/kernel/head_book3s_32.S b/arch/powerpc/kernel/head_book3s_32.S
index 68e5c0a7e99d..fa84744d6b24 100644
--- a/arch/powerpc/kernel/head_book3s_32.S
+++ b/arch/powerpc/kernel/head_book3s_32.S
@@ -931,7 +931,11 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_USE_HIGH_BATS)
 _GLOBAL(load_segment_registers)
 	li	r0, NUM_USER_SEGMENTS /* load up user segment register values */
 	mtctr	r0		/* for context 0 */
+#ifdef CONFIG_PPC_KUEP
+	lis	r3, SR_NX@h	/* Kp = 0, Ks = 0, VSID = 0 */
+#else
 	li	r3, 0		/* Kp = 0, Ks = 0, VSID = 0 */
+#endif
 	li	r4, 0
 3:	mtsrin	r3, r4
 	addi	r3, r3, 0x111	/* increment VSID */
diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
index e93f67c3af76..c53725a598e5 100644
--- a/arch/powerpc/kernel/interrupt.c
+++ b/arch/powerpc/kernel/interrupt.c
@@ -83,8 +83,6 @@ notrace long system_call_exception(long r3, long r4, long r5,
 {
 	syscall_fn f;
 
-	kuep_lock();
-
 	regs->orig_gpr3 = r3;
 
 	if (IS_ENABLED(CONFIG_PPC_IRQ_SOFT_MASK_DEBUG))
@@ -408,7 +406,6 @@ interrupt_exit_user_prepare_main(unsigned long ret, struct pt_regs *regs)
 
 	/* Restore user access locks last */
 	kuap_user_restore(regs);
-	kuep_unlock();
 
 	return ret;
 }
diff --git a/arch/powerpc/mm/book3s32/kuep.c b/arch/powerpc/mm/book3s32/kuep.c
index c20733d6e02c..bac1420d028b 100644
--- a/arch/powerpc/mm/book3s32/kuep.c
+++ b/arch/powerpc/mm/book3s32/kuep.c
@@ -3,18 +3,10 @@
 #include <asm/kup.h>
 #include <asm/smp.h>
 
-struct static_key_false disable_kuep_key;
-
 void setup_kuep(bool disabled)
 {
-	if (!disabled)
-		kuep_lock();
-
 	if (smp_processor_id() != boot_cpuid)
 		return;
 
-	if (disabled)
-		static_branch_enable(&disable_kuep_key);
-	else
-		pr_info("Activating Kernel Userspace Execution Prevention\n");
+	pr_info("Activating Kernel Userspace Execution Prevention\n");
 }
diff --git a/arch/s390/pci/pci_dma.c b/arch/s390/pci/pci_dma.c
index 93223bd110c3..bbe0b66a56e2 100644
--- a/arch/s390/pci/pci_dma.c
+++ b/arch/s390/pci/pci_dma.c
@@ -542,6 +542,17 @@ static void s390_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
 		s->dma_length = 0;
 	}
 }
+
+static unsigned long *bitmap_vzalloc(size_t bits, gfp_t flags)
+{
+	size_t n = BITS_TO_LONGS(bits);
+	size_t bytes;
+
+	if (unlikely(check_mul_overflow(n, sizeof(unsigned long), &bytes)))
+		return NULL;
+
+	return vzalloc(bytes);
+}
 	
 int zpci_dma_init_device(struct zpci_dev *zdev)
 {
@@ -578,13 +589,13 @@ int zpci_dma_init_device(struct zpci_dev *zdev)
 				zdev->end_dma - zdev->start_dma + 1);
 	zdev->end_dma = zdev->start_dma + zdev->iommu_size - 1;
 	zdev->iommu_pages = zdev->iommu_size >> PAGE_SHIFT;
-	zdev->iommu_bitmap = vzalloc(zdev->iommu_pages / 8);
+	zdev->iommu_bitmap = bitmap_vzalloc(zdev->iommu_pages, GFP_KERNEL);
 	if (!zdev->iommu_bitmap) {
 		rc = -ENOMEM;
 		goto free_dma_table;
 	}
 	if (!s390_iommu_strict) {
-		zdev->lazy_bitmap = vzalloc(zdev->iommu_pages / 8);
+		zdev->lazy_bitmap = bitmap_vzalloc(zdev->iommu_pages, GFP_KERNEL);
 		if (!zdev->lazy_bitmap) {
 			rc = -ENOMEM;
 			goto free_bitmap;
diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 670e998fe930..6728e56bf8b9 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -105,6 +105,16 @@ static enum es_result vc_read_mem(struct es_em_ctxt *ctxt,
 	return ES_OK;
 }
 
+static enum es_result vc_ioio_check(struct es_em_ctxt *ctxt, u16 port, size_t size)
+{
+	return ES_OK;
+}
+
+static bool fault_in_kernel_space(unsigned long address)
+{
+	return false;
+}
+
 #undef __init
 #undef __pa
 #define __init
diff --git a/arch/x86/events/Makefile b/arch/x86/events/Makefile
index 9933c0e8e97a..86a76efa8bb6 100644
--- a/arch/x86/events/Makefile
+++ b/arch/x86/events/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-y					+= core.o probe.o
+obj-y					+= core.o probe.o utils.o
 obj-$(CONFIG_PERF_EVENTS_INTEL_RAPL)	+= rapl.o
 obj-y					+= amd/
 obj-$(CONFIG_X86_LOCAL_APIC)            += msr.o
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index b3f92255cbd2..e8c6575cf65e 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -4,7 +4,6 @@
 
 #include <asm/perf_event.h>
 #include <asm/msr.h>
-#include <asm/insn.h>
 
 #include "../perf_event.h"
 
@@ -73,65 +72,6 @@ static const enum {
 
 #define LBR_FROM_SIGNEXT_2MSB	(BIT_ULL(60) | BIT_ULL(59))
 
-/*
- * x86control flow change classification
- * x86control flow changes include branches, interrupts, traps, faults
- */
-enum {
-	X86_BR_NONE		= 0,      /* unknown */
-
-	X86_BR_USER		= 1 << 0, /* branch target is user */
-	X86_BR_KERNEL		= 1 << 1, /* branch target is kernel */
-
-	X86_BR_CALL		= 1 << 2, /* call */
-	X86_BR_RET		= 1 << 3, /* return */
-	X86_BR_SYSCALL		= 1 << 4, /* syscall */
-	X86_BR_SYSRET		= 1 << 5, /* syscall return */
-	X86_BR_INT		= 1 << 6, /* sw interrupt */
-	X86_BR_IRET		= 1 << 7, /* return from interrupt */
-	X86_BR_JCC		= 1 << 8, /* conditional */
-	X86_BR_JMP		= 1 << 9, /* jump */
-	X86_BR_IRQ		= 1 << 10,/* hw interrupt or trap or fault */
-	X86_BR_IND_CALL		= 1 << 11,/* indirect calls */
-	X86_BR_ABORT		= 1 << 12,/* transaction abort */
-	X86_BR_IN_TX		= 1 << 13,/* in transaction */
-	X86_BR_NO_TX		= 1 << 14,/* not in transaction */
-	X86_BR_ZERO_CALL	= 1 << 15,/* zero length call */
-	X86_BR_CALL_STACK	= 1 << 16,/* call stack */
-	X86_BR_IND_JMP		= 1 << 17,/* indirect jump */
-
-	X86_BR_TYPE_SAVE	= 1 << 18,/* indicate to save branch type */
-
-};
-
-#define X86_BR_PLM (X86_BR_USER | X86_BR_KERNEL)
-#define X86_BR_ANYTX (X86_BR_NO_TX | X86_BR_IN_TX)
-
-#define X86_BR_ANY       \
-	(X86_BR_CALL    |\
-	 X86_BR_RET     |\
-	 X86_BR_SYSCALL |\
-	 X86_BR_SYSRET  |\
-	 X86_BR_INT     |\
-	 X86_BR_IRET    |\
-	 X86_BR_JCC     |\
-	 X86_BR_JMP	 |\
-	 X86_BR_IRQ	 |\
-	 X86_BR_ABORT	 |\
-	 X86_BR_IND_CALL |\
-	 X86_BR_IND_JMP  |\
-	 X86_BR_ZERO_CALL)
-
-#define X86_BR_ALL (X86_BR_PLM | X86_BR_ANY)
-
-#define X86_BR_ANY_CALL		 \
-	(X86_BR_CALL		|\
-	 X86_BR_IND_CALL	|\
-	 X86_BR_ZERO_CALL	|\
-	 X86_BR_SYSCALL		|\
-	 X86_BR_IRQ		|\
-	 X86_BR_INT)
-
 /*
  * Intel LBR_CTL bits
  *
@@ -1168,219 +1108,6 @@ int intel_pmu_setup_lbr_filter(struct perf_event *event)
 	return ret;
 }
 
-/*
- * return the type of control flow change at address "from"
- * instruction is not necessarily a branch (in case of interrupt).
- *
- * The branch type returned also includes the priv level of the
- * target of the control flow change (X86_BR_USER, X86_BR_KERNEL).
- *
- * If a branch type is unknown OR the instruction cannot be
- * decoded (e.g., text page not present), then X86_BR_NONE is
- * returned.
- */
-static int branch_type(unsigned long from, unsigned long to, int abort)
-{
-	struct insn insn;
-	void *addr;
-	int bytes_read, bytes_left;
-	int ret = X86_BR_NONE;
-	int ext, to_plm, from_plm;
-	u8 buf[MAX_INSN_SIZE];
-	int is64 = 0;
-
-	to_plm = kernel_ip(to) ? X86_BR_KERNEL : X86_BR_USER;
-	from_plm = kernel_ip(from) ? X86_BR_KERNEL : X86_BR_USER;
-
-	/*
-	 * maybe zero if lbr did not fill up after a reset by the time
-	 * we get a PMU interrupt
-	 */
-	if (from == 0 || to == 0)
-		return X86_BR_NONE;
-
-	if (abort)
-		return X86_BR_ABORT | to_plm;
-
-	if (from_plm == X86_BR_USER) {
-		/*
-		 * can happen if measuring at the user level only
-		 * and we interrupt in a kernel thread, e.g., idle.
-		 */
-		if (!current->mm)
-			return X86_BR_NONE;
-
-		/* may fail if text not present */
-		bytes_left = copy_from_user_nmi(buf, (void __user *)from,
-						MAX_INSN_SIZE);
-		bytes_read = MAX_INSN_SIZE - bytes_left;
-		if (!bytes_read)
-			return X86_BR_NONE;
-
-		addr = buf;
-	} else {
-		/*
-		 * The LBR logs any address in the IP, even if the IP just
-		 * faulted. This means userspace can control the from address.
-		 * Ensure we don't blindly read any address by validating it is
-		 * a known text address.
-		 */
-		if (kernel_text_address(from)) {
-			addr = (void *)from;
-			/*
-			 * Assume we can get the maximum possible size
-			 * when grabbing kernel data.  This is not
-			 * _strictly_ true since we could possibly be
-			 * executing up next to a memory hole, but
-			 * it is very unlikely to be a problem.
-			 */
-			bytes_read = MAX_INSN_SIZE;
-		} else {
-			return X86_BR_NONE;
-		}
-	}
-
-	/*
-	 * decoder needs to know the ABI especially
-	 * on 64-bit systems running 32-bit apps
-	 */
-#ifdef CONFIG_X86_64
-	is64 = kernel_ip((unsigned long)addr) || any_64bit_mode(current_pt_regs());
-#endif
-	insn_init(&insn, addr, bytes_read, is64);
-	if (insn_get_opcode(&insn))
-		return X86_BR_ABORT;
-
-	switch (insn.opcode.bytes[0]) {
-	case 0xf:
-		switch (insn.opcode.bytes[1]) {
-		case 0x05: /* syscall */
-		case 0x34: /* sysenter */
-			ret = X86_BR_SYSCALL;
-			break;
-		case 0x07: /* sysret */
-		case 0x35: /* sysexit */
-			ret = X86_BR_SYSRET;
-			break;
-		case 0x80 ... 0x8f: /* conditional */
-			ret = X86_BR_JCC;
-			break;
-		default:
-			ret = X86_BR_NONE;
-		}
-		break;
-	case 0x70 ... 0x7f: /* conditional */
-		ret = X86_BR_JCC;
-		break;
-	case 0xc2: /* near ret */
-	case 0xc3: /* near ret */
-	case 0xca: /* far ret */
-	case 0xcb: /* far ret */
-		ret = X86_BR_RET;
-		break;
-	case 0xcf: /* iret */
-		ret = X86_BR_IRET;
-		break;
-	case 0xcc ... 0xce: /* int */
-		ret = X86_BR_INT;
-		break;
-	case 0xe8: /* call near rel */
-		if (insn_get_immediate(&insn) || insn.immediate1.value == 0) {
-			/* zero length call */
-			ret = X86_BR_ZERO_CALL;
-			break;
-		}
-		fallthrough;
-	case 0x9a: /* call far absolute */
-		ret = X86_BR_CALL;
-		break;
-	case 0xe0 ... 0xe3: /* loop jmp */
-		ret = X86_BR_JCC;
-		break;
-	case 0xe9 ... 0xeb: /* jmp */
-		ret = X86_BR_JMP;
-		break;
-	case 0xff: /* call near absolute, call far absolute ind */
-		if (insn_get_modrm(&insn))
-			return X86_BR_ABORT;
-
-		ext = (insn.modrm.bytes[0] >> 3) & 0x7;
-		switch (ext) {
-		case 2: /* near ind call */
-		case 3: /* far ind call */
-			ret = X86_BR_IND_CALL;
-			break;
-		case 4:
-		case 5:
-			ret = X86_BR_IND_JMP;
-			break;
-		}
-		break;
-	default:
-		ret = X86_BR_NONE;
-	}
-	/*
-	 * interrupts, traps, faults (and thus ring transition) may
-	 * occur on any instructions. Thus, to classify them correctly,
-	 * we need to first look at the from and to priv levels. If they
-	 * are different and to is in the kernel, then it indicates
-	 * a ring transition. If the from instruction is not a ring
-	 * transition instr (syscall, systenter, int), then it means
-	 * it was a irq, trap or fault.
-	 *
-	 * we have no way of detecting kernel to kernel faults.
-	 */
-	if (from_plm == X86_BR_USER && to_plm == X86_BR_KERNEL
-	    && ret != X86_BR_SYSCALL && ret != X86_BR_INT)
-		ret = X86_BR_IRQ;
-
-	/*
-	 * branch priv level determined by target as
-	 * is done by HW when LBR_SELECT is implemented
-	 */
-	if (ret != X86_BR_NONE)
-		ret |= to_plm;
-
-	return ret;
-}
-
-#define X86_BR_TYPE_MAP_MAX	16
-
-static int branch_map[X86_BR_TYPE_MAP_MAX] = {
-	PERF_BR_CALL,		/* X86_BR_CALL */
-	PERF_BR_RET,		/* X86_BR_RET */
-	PERF_BR_SYSCALL,	/* X86_BR_SYSCALL */
-	PERF_BR_SYSRET,		/* X86_BR_SYSRET */
-	PERF_BR_UNKNOWN,	/* X86_BR_INT */
-	PERF_BR_UNKNOWN,	/* X86_BR_IRET */
-	PERF_BR_COND,		/* X86_BR_JCC */
-	PERF_BR_UNCOND,		/* X86_BR_JMP */
-	PERF_BR_UNKNOWN,	/* X86_BR_IRQ */
-	PERF_BR_IND_CALL,	/* X86_BR_IND_CALL */
-	PERF_BR_UNKNOWN,	/* X86_BR_ABORT */
-	PERF_BR_UNKNOWN,	/* X86_BR_IN_TX */
-	PERF_BR_UNKNOWN,	/* X86_BR_NO_TX */
-	PERF_BR_CALL,		/* X86_BR_ZERO_CALL */
-	PERF_BR_UNKNOWN,	/* X86_BR_CALL_STACK */
-	PERF_BR_IND,		/* X86_BR_IND_JMP */
-};
-
-static int
-common_branch_type(int type)
-{
-	int i;
-
-	type >>= 2; /* skip X86_BR_USER and X86_BR_KERNEL */
-
-	if (type) {
-		i = __ffs(type);
-		if (i < X86_BR_TYPE_MAP_MAX)
-			return branch_map[i];
-	}
-
-	return PERF_BR_UNKNOWN;
-}
-
 enum {
 	ARCH_LBR_BR_TYPE_JCC			= 0,
 	ARCH_LBR_BR_TYPE_NEAR_IND_JMP		= 1,
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index e3ac05c97b5e..9b4d51c0e0ad 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1181,6 +1181,68 @@ static inline void set_linear_ip(struct pt_regs *regs, unsigned long ip)
 	regs->ip = ip;
 }
 
+/*
+ * x86control flow change classification
+ * x86control flow changes include branches, interrupts, traps, faults
+ */
+enum {
+	X86_BR_NONE		= 0,      /* unknown */
+
+	X86_BR_USER		= 1 << 0, /* branch target is user */
+	X86_BR_KERNEL		= 1 << 1, /* branch target is kernel */
+
+	X86_BR_CALL		= 1 << 2, /* call */
+	X86_BR_RET		= 1 << 3, /* return */
+	X86_BR_SYSCALL		= 1 << 4, /* syscall */
+	X86_BR_SYSRET		= 1 << 5, /* syscall return */
+	X86_BR_INT		= 1 << 6, /* sw interrupt */
+	X86_BR_IRET		= 1 << 7, /* return from interrupt */
+	X86_BR_JCC		= 1 << 8, /* conditional */
+	X86_BR_JMP		= 1 << 9, /* jump */
+	X86_BR_IRQ		= 1 << 10,/* hw interrupt or trap or fault */
+	X86_BR_IND_CALL		= 1 << 11,/* indirect calls */
+	X86_BR_ABORT		= 1 << 12,/* transaction abort */
+	X86_BR_IN_TX		= 1 << 13,/* in transaction */
+	X86_BR_NO_TX		= 1 << 14,/* not in transaction */
+	X86_BR_ZERO_CALL	= 1 << 15,/* zero length call */
+	X86_BR_CALL_STACK	= 1 << 16,/* call stack */
+	X86_BR_IND_JMP		= 1 << 17,/* indirect jump */
+
+	X86_BR_TYPE_SAVE	= 1 << 18,/* indicate to save branch type */
+
+};
+
+#define X86_BR_PLM (X86_BR_USER | X86_BR_KERNEL)
+#define X86_BR_ANYTX (X86_BR_NO_TX | X86_BR_IN_TX)
+
+#define X86_BR_ANY       \
+	(X86_BR_CALL    |\
+	 X86_BR_RET     |\
+	 X86_BR_SYSCALL |\
+	 X86_BR_SYSRET  |\
+	 X86_BR_INT     |\
+	 X86_BR_IRET    |\
+	 X86_BR_JCC     |\
+	 X86_BR_JMP	 |\
+	 X86_BR_IRQ	 |\
+	 X86_BR_ABORT	 |\
+	 X86_BR_IND_CALL |\
+	 X86_BR_IND_JMP  |\
+	 X86_BR_ZERO_CALL)
+
+#define X86_BR_ALL (X86_BR_PLM | X86_BR_ANY)
+
+#define X86_BR_ANY_CALL		 \
+	(X86_BR_CALL		|\
+	 X86_BR_IND_CALL	|\
+	 X86_BR_ZERO_CALL	|\
+	 X86_BR_SYSCALL		|\
+	 X86_BR_IRQ		|\
+	 X86_BR_INT)
+
+int common_branch_type(int type);
+int branch_type(unsigned long from, unsigned long to, int abort);
+
 ssize_t x86_event_sysfs_show(char *page, u64 config, u64 event);
 ssize_t intel_event_sysfs_show(char *page, u64 config);
 
diff --git a/arch/x86/events/utils.c b/arch/x86/events/utils.c
new file mode 100644
index 000000000000..b30508b88bf2
--- /dev/null
+++ b/arch/x86/events/utils.c
@@ -0,0 +1,217 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <asm/insn.h>
+#include <linux/mm.h>
+
+#include "perf_event.h"
+
+/*
+ * return the type of control flow change at address "from"
+ * instruction is not necessarily a branch (in case of interrupt).
+ *
+ * The branch type returned also includes the priv level of the
+ * target of the control flow change (X86_BR_USER, X86_BR_KERNEL).
+ *
+ * If a branch type is unknown OR the instruction cannot be
+ * decoded (e.g., text page not present), then X86_BR_NONE is
+ * returned.
+ */
+int branch_type(unsigned long from, unsigned long to, int abort)
+{
+	struct insn insn;
+	void *addr;
+	int bytes_read, bytes_left;
+	int ret = X86_BR_NONE;
+	int ext, to_plm, from_plm;
+	u8 buf[MAX_INSN_SIZE];
+	int is64 = 0;
+
+	to_plm = kernel_ip(to) ? X86_BR_KERNEL : X86_BR_USER;
+	from_plm = kernel_ip(from) ? X86_BR_KERNEL : X86_BR_USER;
+
+	/*
+	 * maybe zero if lbr did not fill up after a reset by the time
+	 * we get a PMU interrupt
+	 */
+	if (from == 0 || to == 0)
+		return X86_BR_NONE;
+
+	if (abort)
+		return X86_BR_ABORT | to_plm;
+
+	if (from_plm == X86_BR_USER) {
+		/*
+		 * can happen if measuring at the user level only
+		 * and we interrupt in a kernel thread, e.g., idle.
+		 */
+		if (!current->mm)
+			return X86_BR_NONE;
+
+		/* may fail if text not present */
+		bytes_left = copy_from_user_nmi(buf, (void __user *)from,
+						MAX_INSN_SIZE);
+		bytes_read = MAX_INSN_SIZE - bytes_left;
+		if (!bytes_read)
+			return X86_BR_NONE;
+
+		addr = buf;
+	} else {
+		/*
+		 * The LBR logs any address in the IP, even if the IP just
+		 * faulted. This means userspace can control the from address.
+		 * Ensure we don't blindly read any address by validating it is
+		 * a known text address and not a vsyscall address.
+		 */
+		if (kernel_text_address(from) && !in_gate_area_no_mm(from)) {
+			addr = (void *)from;
+			/*
+			 * Assume we can get the maximum possible size
+			 * when grabbing kernel data.  This is not
+			 * _strictly_ true since we could possibly be
+			 * executing up next to a memory hole, but
+			 * it is very unlikely to be a problem.
+			 */
+			bytes_read = MAX_INSN_SIZE;
+		} else {
+			return X86_BR_NONE;
+		}
+	}
+
+	/*
+	 * decoder needs to know the ABI especially
+	 * on 64-bit systems running 32-bit apps
+	 */
+#ifdef CONFIG_X86_64
+	is64 = kernel_ip((unsigned long)addr) || any_64bit_mode(current_pt_regs());
+#endif
+	insn_init(&insn, addr, bytes_read, is64);
+	if (insn_get_opcode(&insn))
+		return X86_BR_ABORT;
+
+	switch (insn.opcode.bytes[0]) {
+	case 0xf:
+		switch (insn.opcode.bytes[1]) {
+		case 0x05: /* syscall */
+		case 0x34: /* sysenter */
+			ret = X86_BR_SYSCALL;
+			break;
+		case 0x07: /* sysret */
+		case 0x35: /* sysexit */
+			ret = X86_BR_SYSRET;
+			break;
+		case 0x80 ... 0x8f: /* conditional */
+			ret = X86_BR_JCC;
+			break;
+		default:
+			ret = X86_BR_NONE;
+		}
+		break;
+	case 0x70 ... 0x7f: /* conditional */
+		ret = X86_BR_JCC;
+		break;
+	case 0xc2: /* near ret */
+	case 0xc3: /* near ret */
+	case 0xca: /* far ret */
+	case 0xcb: /* far ret */
+		ret = X86_BR_RET;
+		break;
+	case 0xcf: /* iret */
+		ret = X86_BR_IRET;
+		break;
+	case 0xcc ... 0xce: /* int */
+		ret = X86_BR_INT;
+		break;
+	case 0xe8: /* call near rel */
+		if (insn_get_immediate(&insn) || insn.immediate1.value == 0) {
+			/* zero length call */
+			ret = X86_BR_ZERO_CALL;
+			break;
+		}
+		fallthrough;
+	case 0x9a: /* call far absolute */
+		ret = X86_BR_CALL;
+		break;
+	case 0xe0 ... 0xe3: /* loop jmp */
+		ret = X86_BR_JCC;
+		break;
+	case 0xe9 ... 0xeb: /* jmp */
+		ret = X86_BR_JMP;
+		break;
+	case 0xff: /* call near absolute, call far absolute ind */
+		if (insn_get_modrm(&insn))
+			return X86_BR_ABORT;
+
+		ext = (insn.modrm.bytes[0] >> 3) & 0x7;
+		switch (ext) {
+		case 2: /* near ind call */
+		case 3: /* far ind call */
+			ret = X86_BR_IND_CALL;
+			break;
+		case 4:
+		case 5:
+			ret = X86_BR_IND_JMP;
+			break;
+		}
+		break;
+	default:
+		ret = X86_BR_NONE;
+	}
+	/*
+	 * interrupts, traps, faults (and thus ring transition) may
+	 * occur on any instructions. Thus, to classify them correctly,
+	 * we need to first look at the from and to priv levels. If they
+	 * are different and to is in the kernel, then it indicates
+	 * a ring transition. If the from instruction is not a ring
+	 * transition instr (syscall, systenter, int), then it means
+	 * it was a irq, trap or fault.
+	 *
+	 * we have no way of detecting kernel to kernel faults.
+	 */
+	if (from_plm == X86_BR_USER && to_plm == X86_BR_KERNEL
+	    && ret != X86_BR_SYSCALL && ret != X86_BR_INT)
+		ret = X86_BR_IRQ;
+
+	/*
+	 * branch priv level determined by target as
+	 * is done by HW when LBR_SELECT is implemented
+	 */
+	if (ret != X86_BR_NONE)
+		ret |= to_plm;
+
+	return ret;
+}
+
+#define X86_BR_TYPE_MAP_MAX	16
+
+static int branch_map[X86_BR_TYPE_MAP_MAX] = {
+	PERF_BR_CALL,		/* X86_BR_CALL */
+	PERF_BR_RET,		/* X86_BR_RET */
+	PERF_BR_SYSCALL,	/* X86_BR_SYSCALL */
+	PERF_BR_SYSRET,		/* X86_BR_SYSRET */
+	PERF_BR_UNKNOWN,	/* X86_BR_INT */
+	PERF_BR_ERET,		/* X86_BR_IRET */
+	PERF_BR_COND,		/* X86_BR_JCC */
+	PERF_BR_UNCOND,		/* X86_BR_JMP */
+	PERF_BR_IRQ,		/* X86_BR_IRQ */
+	PERF_BR_IND_CALL,	/* X86_BR_IND_CALL */
+	PERF_BR_UNKNOWN,	/* X86_BR_ABORT */
+	PERF_BR_UNKNOWN,	/* X86_BR_IN_TX */
+	PERF_BR_UNKNOWN,	/* X86_BR_NO_TX */
+	PERF_BR_CALL,		/* X86_BR_ZERO_CALL */
+	PERF_BR_UNKNOWN,	/* X86_BR_CALL_STACK */
+	PERF_BR_IND,		/* X86_BR_IND_JMP */
+};
+
+int common_branch_type(int type)
+{
+	int i;
+
+	type >>= 2; /* skip X86_BR_USER and X86_BR_KERNEL */
+
+	if (type) {
+		i = __ffs(type);
+		if (i < X86_BR_TYPE_MAP_MAX)
+			return branch_map[i];
+	}
+
+	return PERF_BR_UNKNOWN;
+}
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index bf1033a62e48..05707b7b0b44 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -213,6 +213,23 @@ void __init do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
 	sev_es_terminate(GHCB_SEV_ES_REASON_GENERAL_REQUEST);
 }
 
+static enum es_result vc_insn_string_check(struct es_em_ctxt *ctxt,
+					   unsigned long address,
+					   bool write)
+{
+	if (user_mode(ctxt->regs) && fault_in_kernel_space(address)) {
+		ctxt->fi.vector     = X86_TRAP_PF;
+		ctxt->fi.error_code = X86_PF_USER;
+		ctxt->fi.cr2        = address;
+		if (write)
+			ctxt->fi.error_code |= X86_PF_WRITE;
+
+		return ES_EXCEPTION;
+	}
+
+	return ES_OK;
+}
+
 static enum es_result vc_insn_string_read(struct es_em_ctxt *ctxt,
 					  void *src, char *buf,
 					  unsigned int data_size,
@@ -220,7 +237,12 @@ static enum es_result vc_insn_string_read(struct es_em_ctxt *ctxt,
 					  bool backwards)
 {
 	int i, b = backwards ? -1 : 1;
-	enum es_result ret = ES_OK;
+	unsigned long address = (unsigned long)src;
+	enum es_result ret;
+
+	ret = vc_insn_string_check(ctxt, address, false);
+	if (ret != ES_OK)
+		return ret;
 
 	for (i = 0; i < count; i++) {
 		void *s = src + (i * data_size * b);
@@ -241,7 +263,12 @@ static enum es_result vc_insn_string_write(struct es_em_ctxt *ctxt,
 					   bool backwards)
 {
 	int i, s = backwards ? -1 : 1;
-	enum es_result ret = ES_OK;
+	unsigned long address = (unsigned long)dst;
+	enum es_result ret;
+
+	ret = vc_insn_string_check(ctxt, address, true);
+	if (ret != ES_OK)
+		return ret;
 
 	for (i = 0; i < count; i++) {
 		void *d = dst + (i * data_size * s);
@@ -277,6 +304,9 @@ static enum es_result vc_insn_string_write(struct es_em_ctxt *ctxt,
 static enum es_result vc_ioio_exitinfo(struct es_em_ctxt *ctxt, u64 *exitinfo)
 {
 	struct insn *insn = &ctxt->insn;
+	size_t size;
+	u64 port;
+
 	*exitinfo = 0;
 
 	switch (insn->opcode.bytes[0]) {
@@ -285,7 +315,7 @@ static enum es_result vc_ioio_exitinfo(struct es_em_ctxt *ctxt, u64 *exitinfo)
 	case 0x6d:
 		*exitinfo |= IOIO_TYPE_INS;
 		*exitinfo |= IOIO_SEG_ES;
-		*exitinfo |= (ctxt->regs->dx & 0xffff) << 16;
+		port	   = ctxt->regs->dx & 0xffff;
 		break;
 
 	/* OUTS opcodes */
@@ -293,41 +323,43 @@ static enum es_result vc_ioio_exitinfo(struct es_em_ctxt *ctxt, u64 *exitinfo)
 	case 0x6f:
 		*exitinfo |= IOIO_TYPE_OUTS;
 		*exitinfo |= IOIO_SEG_DS;
-		*exitinfo |= (ctxt->regs->dx & 0xffff) << 16;
+		port	   = ctxt->regs->dx & 0xffff;
 		break;
 
 	/* IN immediate opcodes */
 	case 0xe4:
 	case 0xe5:
 		*exitinfo |= IOIO_TYPE_IN;
-		*exitinfo |= (u8)insn->immediate.value << 16;
+		port	   = (u8)insn->immediate.value & 0xffff;
 		break;
 
 	/* OUT immediate opcodes */
 	case 0xe6:
 	case 0xe7:
 		*exitinfo |= IOIO_TYPE_OUT;
-		*exitinfo |= (u8)insn->immediate.value << 16;
+		port	   = (u8)insn->immediate.value & 0xffff;
 		break;
 
 	/* IN register opcodes */
 	case 0xec:
 	case 0xed:
 		*exitinfo |= IOIO_TYPE_IN;
-		*exitinfo |= (ctxt->regs->dx & 0xffff) << 16;
+		port	   = ctxt->regs->dx & 0xffff;
 		break;
 
 	/* OUT register opcodes */
 	case 0xee:
 	case 0xef:
 		*exitinfo |= IOIO_TYPE_OUT;
-		*exitinfo |= (ctxt->regs->dx & 0xffff) << 16;
+		port	   = ctxt->regs->dx & 0xffff;
 		break;
 
 	default:
 		return ES_DECODE_FAILED;
 	}
 
+	*exitinfo |= port << 16;
+
 	switch (insn->opcode.bytes[0]) {
 	case 0x6c:
 	case 0x6e:
@@ -337,12 +369,15 @@ static enum es_result vc_ioio_exitinfo(struct es_em_ctxt *ctxt, u64 *exitinfo)
 	case 0xee:
 		/* Single byte opcodes */
 		*exitinfo |= IOIO_DATA_8;
+		size       = 1;
 		break;
 	default:
 		/* Length determined by instruction parsing */
 		*exitinfo |= (insn->opnd_bytes == 2) ? IOIO_DATA_16
 						     : IOIO_DATA_32;
+		size       = (insn->opnd_bytes == 2) ? 2 : 4;
 	}
+
 	switch (insn->addr_bytes) {
 	case 2:
 		*exitinfo |= IOIO_ADDR_16;
@@ -358,7 +393,7 @@ static enum es_result vc_ioio_exitinfo(struct es_em_ctxt *ctxt, u64 *exitinfo)
 	if (insn_has_rep_prefix(insn))
 		*exitinfo |= IOIO_REP;
 
-	return ES_OK;
+	return vc_ioio_check(ctxt, (u16)port, size);
 }
 
 static enum es_result vc_handle_ioio(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index a0064cf77e56..6161b14d8a7c 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -482,6 +482,33 @@ static enum es_result vc_slow_virt_to_phys(struct ghcb *ghcb, struct es_em_ctxt
 	return ES_OK;
 }
 
+static enum es_result vc_ioio_check(struct es_em_ctxt *ctxt, u16 port, size_t size)
+{
+	BUG_ON(size > 4);
+
+	if (user_mode(ctxt->regs)) {
+		struct thread_struct *t = &current->thread;
+		struct io_bitmap *iobm = t->io_bitmap;
+		size_t idx;
+
+		if (!iobm)
+			goto fault;
+
+		for (idx = port; idx < port + size; ++idx) {
+			if (test_bit(idx, iobm->bitmap))
+				goto fault;
+		}
+	}
+
+	return ES_OK;
+
+fault:
+	ctxt->fi.vector = X86_TRAP_GP;
+	ctxt->fi.error_code = 0;
+
+	return ES_EXCEPTION;
+}
+
 /* Include code shared with pre-decompression boot stage */
 #include "sev-shared.c"
 
@@ -1004,6 +1031,9 @@ static enum es_result vc_handle_mmio(struct ghcb *ghcb,
 	enum es_result ret;
 	long *reg_data;
 
+	if (user_mode(ctxt->regs))
+		return ES_UNSUPPORTED;
+
 	switch (insn->opcode.bytes[0]) {
 	/* MMIO Write */
 	case 0x88:
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 40fc1879a697..b5b20078a413 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -2411,13 +2411,17 @@ int kvm_apic_local_deliver(struct kvm_lapic *apic, int lvt_type)
 {
 	u32 reg = kvm_lapic_get_reg(apic, lvt_type);
 	int vector, mode, trig_mode;
+	int r;
 
 	if (kvm_apic_hw_enabled(apic) && !(reg & APIC_LVT_MASKED)) {
 		vector = reg & APIC_VECTOR_MASK;
 		mode = reg & APIC_MODE_MASK;
 		trig_mode = reg & APIC_LVT_LEVEL_TRIGGER;
-		return __apic_accept_irq(apic, mode, vector, 1, trig_mode,
-					NULL);
+
+		r = __apic_accept_irq(apic, mode, vector, 1, trig_mode, NULL);
+		if (r && lvt_type == APIC_LVTPC)
+			kvm_lapic_set_reg(apic, APIC_LVTPC, reg | APIC_LVT_MASKED);
+		return r;
 	}
 	return 0;
 }
diff --git a/drivers/acpi/irq.c b/drivers/acpi/irq.c
index c68e694fca26..12812319996f 100644
--- a/drivers/acpi/irq.c
+++ b/drivers/acpi/irq.c
@@ -52,6 +52,7 @@ int acpi_register_gsi(struct device *dev, u32 gsi, int trigger,
 		      int polarity)
 {
 	struct irq_fwspec fwspec;
+	unsigned int irq;
 
 	if (WARN_ON(!acpi_gsi_domain_id)) {
 		pr_warn("GSI: No registered irqchip, giving up\n");
@@ -63,7 +64,11 @@ int acpi_register_gsi(struct device *dev, u32 gsi, int trigger,
 	fwspec.param[1] = acpi_dev_get_irq_type(trigger, polarity);
 	fwspec.param_count = 2;
 
-	return irq_create_fwspec_mapping(&fwspec);
+	irq = irq_create_fwspec_mapping(&fwspec);
+	if (!irq)
+		return -EINVAL;
+
+	return irq;
 }
 EXPORT_SYMBOL_GPL(acpi_register_gsi);
 
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 96786d6fcf37..383398af836c 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2382,7 +2382,7 @@ static int ata_dev_config_lba(struct ata_device *dev)
 	struct ata_port *ap = dev->link->ap;
 	const u16 *id = dev->id;
 	const char *lba_desc;
-	char ncq_desc[24];
+	char ncq_desc[32];
 	int ret;
 
 	dev->flags |= ATA_DFLAG_LBA;
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 844483200870..10742d72f44f 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2223,7 +2223,7 @@ static void ata_eh_link_report(struct ata_link *link)
 	struct ata_eh_context *ehc = &link->eh_context;
 	struct ata_queued_cmd *qc;
 	const char *frozen, *desc;
-	char tries_buf[6] = "";
+	char tries_buf[16] = "";
 	int tag, nr_failed = 0;
 
 	if (ehc->i.flags & ATA_EHI_QUIET)
diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index f7811641ed5a..617d51a27849 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1551,7 +1551,7 @@ static int dev_get_regmap_match(struct device *dev, void *res, void *data)
 
 	/* If the user didn't specify a name match any */
 	if (data)
-		return !strcmp((*r)->name, data);
+		return (*r)->name && !strcmp((*r)->name, data);
 	else
 		return 1;
 }
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 84a42348b3bc..c01d02f41bcb 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3949,6 +3949,7 @@ static int btusb_probe(struct usb_interface *intf,
 
 	if (id->driver_info & BTUSB_QCA_ROME) {
 		data->setup_on_usb = btusb_setup_qca;
+		hdev->shutdown = btusb_shutdown_qca;
 		hdev->set_bdaddr = btusb_set_bdaddr_ath3012;
 		hdev->cmd_timeout = btusb_qca_cmd_timeout;
 		set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
index 8469f9876dd2..31d70bad83d2 100644
--- a/drivers/bluetooth/hci_vhci.c
+++ b/drivers/bluetooth/hci_vhci.c
@@ -67,7 +67,10 @@ static int vhci_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 	struct vhci_data *data = hci_get_drvdata(hdev);
 
 	memcpy(skb_push(skb, 1), &hci_skb_pkt_type(skb), 1);
+
+	mutex_lock(&data->open_mutex);
 	skb_queue_tail(&data->readq, skb);
+	mutex_unlock(&data->open_mutex);
 
 	wake_up_interruptible(&data->read_wait);
 	return 0;
diff --git a/drivers/gpio/gpio-timberdale.c b/drivers/gpio/gpio-timberdale.c
index de14949a3fe5..92c1f2baa4bf 100644
--- a/drivers/gpio/gpio-timberdale.c
+++ b/drivers/gpio/gpio-timberdale.c
@@ -43,9 +43,10 @@ static int timbgpio_update_bit(struct gpio_chip *gpio, unsigned index,
 	unsigned offset, bool enabled)
 {
 	struct timbgpio *tgpio = gpiochip_get_data(gpio);
+	unsigned long flags;
 	u32 reg;
 
-	spin_lock(&tgpio->lock);
+	spin_lock_irqsave(&tgpio->lock, flags);
 	reg = ioread32(tgpio->membase + offset);
 
 	if (enabled)
@@ -54,7 +55,7 @@ static int timbgpio_update_bit(struct gpio_chip *gpio, unsigned index,
 		reg &= ~(1 << index);
 
 	iowrite32(reg, tgpio->membase + offset);
-	spin_unlock(&tgpio->lock);
+	spin_unlock_irqrestore(&tgpio->lock, flags);
 
 	return 0;
 }
diff --git a/drivers/gpio/gpio-vf610.c b/drivers/gpio/gpio-vf610.c
index edb28af7ba3b..c3014f5f0faa 100644
--- a/drivers/gpio/gpio-vf610.c
+++ b/drivers/gpio/gpio-vf610.c
@@ -127,14 +127,14 @@ static int vf610_gpio_direction_output(struct gpio_chip *chip, unsigned gpio,
 	unsigned long mask = BIT(gpio);
 	u32 val;
 
+	vf610_gpio_set(chip, gpio, value);
+
 	if (port->sdata && port->sdata->have_paddr) {
 		val = vf610_gpio_readl(port->gpio_base + GPIO_PDDR);
 		val |= mask;
 		vf610_gpio_writel(val, port->gpio_base + GPIO_PDDR);
 	}
 
-	vf610_gpio_set(chip, gpio, value);
-
 	return pinctrl_gpio_direction_output(chip->base + gpio);
 }
 
diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 5ba316391381..2c3883d79f53 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -285,7 +285,8 @@ static int
 update_connector_routing(struct drm_atomic_state *state,
 			 struct drm_connector *connector,
 			 struct drm_connector_state *old_connector_state,
-			 struct drm_connector_state *new_connector_state)
+			 struct drm_connector_state *new_connector_state,
+			 bool added_by_user)
 {
 	const struct drm_connector_helper_funcs *funcs;
 	struct drm_encoder *new_encoder;
@@ -336,9 +337,13 @@ update_connector_routing(struct drm_atomic_state *state,
 	 * there's a chance the connector may have been destroyed during the
 	 * process, but it's better to ignore that then cause
 	 * drm_atomic_helper_resume() to fail.
+	 *
+	 * Last, we want to ignore connector registration when the connector
+	 * was not pulled in the atomic state by user-space (ie, was pulled
+	 * in by the driver, e.g. when updating a DP-MST stream).
 	 */
 	if (!state->duplicated && drm_connector_is_unregistered(connector) &&
-	    crtc_state->active) {
+	    added_by_user && crtc_state->active) {
 		DRM_DEBUG_ATOMIC("[CONNECTOR:%d:%s] is not registered\n",
 				 connector->base.id, connector->name);
 		return -EINVAL;
@@ -610,7 +615,10 @@ drm_atomic_helper_check_modeset(struct drm_device *dev,
 	struct drm_connector *connector;
 	struct drm_connector_state *old_connector_state, *new_connector_state;
 	int i, ret;
-	unsigned int connectors_mask = 0;
+	unsigned int connectors_mask = 0, user_connectors_mask = 0;
+
+	for_each_oldnew_connector_in_state(state, connector, old_connector_state, new_connector_state, i)
+		user_connectors_mask |= BIT(i);
 
 	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state, new_crtc_state, i) {
 		bool has_connectors =
@@ -675,7 +683,8 @@ drm_atomic_helper_check_modeset(struct drm_device *dev,
 		 */
 		ret = update_connector_routing(state, connector,
 					       old_connector_state,
-					       new_connector_state);
+					       new_connector_state,
+					       BIT(i) & user_connectors_mask);
 		if (ret)
 			return ret;
 		if (old_connector_state->crtc) {
diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index 6106fa7c4302..43de9dfcba19 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -44,6 +44,14 @@ static const struct drm_dmi_panel_orientation_data gpd_micropc = {
 	.orientation = DRM_MODE_PANEL_ORIENTATION_RIGHT_UP,
 };
 
+static const struct drm_dmi_panel_orientation_data gpd_onemix2s = {
+	.width = 1200,
+	.height = 1920,
+	.bios_dates = (const char * const []){ "05/21/2018", "10/26/2018",
+		"03/04/2019", NULL },
+	.orientation = DRM_MODE_PANEL_ORIENTATION_RIGHT_UP,
+};
+
 static const struct drm_dmi_panel_orientation_data gpd_pocket = {
 	.width = 1200,
 	.height = 1920,
@@ -329,6 +337,14 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "LTH17"),
 		},
 		.driver_data = (void *)&lcd800x1280_rightside_up,
+	}, {	/* One Mix 2S (generic strings, also match on bios date) */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Default string"),
+		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Default string"),
+		  DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "Default string"),
+		  DMI_EXACT_MATCH(DMI_BOARD_NAME, "Default string"),
+		},
+		.driver_data = (void *)&gpd_onemix2s,
 	},
 	{}
 };
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_mman.c b/drivers/gpu/drm/i915/gem/i915_gem_mman.c
index 28e07040cf47..5c6362a55cfa 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_mman.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_mman.c
@@ -231,6 +231,7 @@ static vm_fault_t i915_error_to_vmf_fault(int err)
 	case 0:
 	case -EAGAIN:
 	case -ENOSPC: /* transient failure to evict? */
+	case -ENOBUFS: /* temporarily out of fences? */
 	case -ERESTARTSYS:
 	case -EINTR:
 	case -EBUSY:
diff --git a/drivers/hid/hid-holtek-kbd.c b/drivers/hid/hid-holtek-kbd.c
index 403506b9697e..b346d68a06f5 100644
--- a/drivers/hid/hid-holtek-kbd.c
+++ b/drivers/hid/hid-holtek-kbd.c
@@ -130,6 +130,10 @@ static int holtek_kbd_input_event(struct input_dev *dev, unsigned int type,
 		return -ENODEV;
 
 	boot_hid = usb_get_intfdata(boot_interface);
+	if (list_empty(&boot_hid->inputs)) {
+		hid_err(hid, "no inputs found\n");
+		return -ENODEV;
+	}
 	boot_hid_input = list_first_entry(&boot_hid->inputs,
 		struct hid_input, list);
 
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index a5bc11750bdc..4ec8ca06a0bd 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -2142,6 +2142,10 @@ static const struct hid_device_id mt_devices[] = {
 			USB_DEVICE_ID_MTP_STM)},
 
 	/* Synaptics devices */
+	{ .driver_data = MT_CLS_WIN_8_FORCE_MULTI_INPUT,
+		HID_DEVICE(BUS_I2C, HID_GROUP_MULTITOUCH_WIN_8,
+			USB_VENDOR_ID_SYNAPTICS, 0xcd7e) },
+
 	{ .driver_data = MT_CLS_WIN_8_FORCE_MULTI_INPUT,
 		HID_DEVICE(BUS_I2C, HID_GROUP_MULTITOUCH_WIN_8,
 			USB_VENDOR_ID_SYNAPTICS, 0xce08) },
diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
index 774507b54b57..c90cec8d9656 100644
--- a/drivers/i2c/i2c-mux.c
+++ b/drivers/i2c/i2c-mux.c
@@ -340,7 +340,7 @@ int i2c_mux_add_adapter(struct i2c_mux_core *muxc,
 		priv->adap.lock_ops = &i2c_parent_lock_ops;
 
 	/* Sanity check on class */
-	if (i2c_mux_parent_classes(parent) & class)
+	if (i2c_mux_parent_classes(parent) & class & ~I2C_CLASS_DEPRECATED)
 		dev_err(&parent->dev,
 			"Segment %d behind mux can't share classes with ancestors\n",
 			chan_id);
diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 3af763b4a973..9eabc4d1dd0f 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -1525,7 +1525,7 @@ static int bmc150_accel_buffer_postenable(struct iio_dev *indio_dev)
 	struct bmc150_accel_data *data = iio_priv(indio_dev);
 	int ret = 0;
 
-	if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED)
+	if (iio_device_get_current_mode(indio_dev) == INDIO_BUFFER_TRIGGERED)
 		return 0;
 
 	mutex_lock(&data->mutex);
@@ -1557,7 +1557,7 @@ static int bmc150_accel_buffer_predisable(struct iio_dev *indio_dev)
 {
 	struct bmc150_accel_data *data = iio_priv(indio_dev);
 
-	if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED)
+	if (iio_device_get_current_mode(indio_dev) == INDIO_BUFFER_TRIGGERED)
 		return 0;
 
 	mutex_lock(&data->mutex);
diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 6df435e3c421..31461d46c594 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -177,6 +177,7 @@ struct ad7192_state {
 	const struct ad7192_chip_info	*chip_info;
 	struct regulator		*avdd;
 	struct regulator		*dvdd;
+	struct regulator		*vref;
 	struct clk			*mclk;
 	u16				int_vref_mv;
 	u32				fclk;
@@ -962,10 +963,30 @@ static int ad7192_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	ret = regulator_get_voltage(st->avdd);
-	if (ret < 0) {
-		dev_err(&spi->dev, "Device tree error, reference voltage undefined\n");
-		return ret;
+	st->vref = devm_regulator_get_optional(&spi->dev, "vref");
+	if (IS_ERR(st->vref)) {
+		if (PTR_ERR(st->vref) != -ENODEV)
+			return PTR_ERR(st->vref);
+
+		ret = regulator_get_voltage(st->avdd);
+		if (ret < 0)
+			return dev_err_probe(&spi->dev, ret,
+					     "Device tree error, AVdd voltage undefined\n");
+	} else {
+		ret = regulator_enable(st->vref);
+		if (ret) {
+			dev_err(&spi->dev, "Failed to enable specified Vref supply\n");
+			return ret;
+		}
+
+		ret = devm_add_action_or_reset(&spi->dev, ad7192_reg_disable, st->vref);
+		if (ret)
+			return ret;
+
+		ret = regulator_get_voltage(st->vref);
+		if (ret < 0)
+			return dev_err_probe(&spi->dev, ret,
+					     "Device tree error, Vref voltage undefined\n");
 	}
 	st->int_vref_mv = ret / 1000;
 
diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index ecb49bc452ae..806fdcd79e64 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -894,7 +894,7 @@ static int at91_adc_buffer_prepare(struct iio_dev *indio_dev)
 		return at91_adc_configure_touch(st, true);
 
 	/* if we are not in triggered mode, we cannot enable the buffer. */
-	if (!(indio_dev->currentmode & INDIO_ALL_TRIGGERED_MODES))
+	if (!(iio_device_get_current_mode(indio_dev) & INDIO_ALL_TRIGGERED_MODES))
 		return -EINVAL;
 
 	/* we continue with the triggered buffer */
@@ -947,7 +947,7 @@ static int at91_adc_buffer_postdisable(struct iio_dev *indio_dev)
 		return at91_adc_configure_touch(st, false);
 
 	/* if we are not in triggered mode, nothing to do here */
-	if (!(indio_dev->currentmode & INDIO_ALL_TRIGGERED_MODES))
+	if (!(iio_device_get_current_mode(indio_dev) & INDIO_ALL_TRIGGERED_MODES))
 		return -EINVAL;
 
 	/*
diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index f529c01ac66b..a600ad9ed869 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -196,8 +196,11 @@ int cros_ec_sensors_push_data(struct iio_dev *indio_dev,
 	/*
 	 * Ignore samples if the buffer is not set: it is needed if the ODR is
 	 * set but the buffer is not enabled yet.
+	 *
+	 * Note: iio_device_claim_buffer_mode() returns -EBUSY if the buffer
+	 * is not enabled.
 	 */
-	if (!iio_buffer_enabled(indio_dev))
+	if (iio_device_claim_buffer_mode(indio_dev) < 0)
 		return 0;
 
 	out = (s16 *)st->samples;
@@ -216,6 +219,7 @@ int cros_ec_sensors_push_data(struct iio_dev *indio_dev,
 	iio_push_to_buffers_with_timestamp(indio_dev, st->samples,
 					   timestamp + delta);
 
+	iio_device_release_buffer_mode(indio_dev);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(cros_ec_sensors_push_data);
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index a7f5d432c95d..78c780d1ab89 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -184,6 +184,18 @@ int iio_device_id(struct iio_dev *indio_dev)
 }
 EXPORT_SYMBOL_GPL(iio_device_id);
 
+/**
+ * iio_buffer_enabled() - helper function to test if the buffer is enabled
+ * @indio_dev:		IIO device structure for device
+ */
+bool iio_buffer_enabled(struct iio_dev *indio_dev)
+{
+	return indio_dev->currentmode
+		& (INDIO_BUFFER_TRIGGERED | INDIO_BUFFER_HARDWARE |
+		   INDIO_BUFFER_SOFTWARE);
+}
+EXPORT_SYMBOL_GPL(iio_buffer_enabled);
+
 /**
  * iio_sysfs_match_string_with_gaps - matches given string in an array with gaps
  * @array: array of strings
@@ -2072,6 +2084,55 @@ void iio_device_release_direct_mode(struct iio_dev *indio_dev)
 }
 EXPORT_SYMBOL_GPL(iio_device_release_direct_mode);
 
+/**
+ * iio_device_claim_buffer_mode - Keep device in buffer mode
+ * @indio_dev:	the iio_dev associated with the device
+ *
+ * If the device is in buffer mode it is guaranteed to stay
+ * that way until iio_device_release_buffer_mode() is called.
+ *
+ * Use with iio_device_release_buffer_mode().
+ *
+ * Returns: 0 on success, -EBUSY on failure.
+ */
+int iio_device_claim_buffer_mode(struct iio_dev *indio_dev)
+{
+	mutex_lock(&indio_dev->mlock);
+
+	if (iio_buffer_enabled(indio_dev))
+		return 0;
+
+	mutex_unlock(&indio_dev->mlock);
+	return -EBUSY;
+}
+EXPORT_SYMBOL_GPL(iio_device_claim_buffer_mode);
+
+/**
+ * iio_device_release_buffer_mode - releases claim on buffer mode
+ * @indio_dev:	the iio_dev associated with the device
+ *
+ * Release the claim. Device is no longer guaranteed to stay
+ * in buffer mode.
+ *
+ * Use with iio_device_claim_buffer_mode().
+ */
+void iio_device_release_buffer_mode(struct iio_dev *indio_dev)
+{
+	mutex_unlock(&indio_dev->mlock);
+}
+EXPORT_SYMBOL_GPL(iio_device_release_buffer_mode);
+
+/**
+ * iio_device_get_current_mode() - helper function providing read-only access to
+ *				   the @currentmode variable
+ * @indio_dev:			   IIO device structure for device
+ */
+int iio_device_get_current_mode(struct iio_dev *indio_dev)
+{
+	return indio_dev->currentmode;
+}
+EXPORT_SYMBOL_GPL(iio_device_get_current_mode);
+
 subsys_initcall(iio_init);
 module_exit(iio_exit);
 
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index d805f8450719..5074b3ce38ea 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -96,7 +96,7 @@ static int mmc_decode_cid(struct mmc_card *card)
 	case 3: /* MMC v3.1 - v3.3 */
 	case 4: /* MMC v4 */
 		card->cid.manfid	= UNSTUFF_BITS(resp, 120, 8);
-		card->cid.oemid		= UNSTUFF_BITS(resp, 104, 16);
+		card->cid.oemid		= UNSTUFF_BITS(resp, 104, 8);
 		card->cid.prod_name[0]	= UNSTUFF_BITS(resp, 96, 8);
 		card->cid.prod_name[1]	= UNSTUFF_BITS(resp, 88, 8);
 		card->cid.prod_name[2]	= UNSTUFF_BITS(resp, 80, 8);
diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 5447c47157aa..eda2dbd96539 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -1073,8 +1073,14 @@ static int mmc_sdio_resume(struct mmc_host *host)
 		}
 		err = mmc_sdio_reinit_card(host);
 	} else if (mmc_card_wake_sdio_irq(host)) {
-		/* We may have switched to 1-bit mode during suspend */
+		/*
+		 * We may have switched to 1-bit mode during suspend,
+		 * need to hold retuning, because tuning only supprt
+		 * 4-bit mode or 8 bit mode.
+		 */
+		mmc_retune_hold_now(host);
 		err = sdio_enable_4bit_bus(host->card);
+		mmc_retune_release(host);
 	}
 
 	if (err)
diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 6d0fc247bddb..12ab7417937e 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -628,11 +628,11 @@ static void msdc_reset_hw(struct msdc_host *host)
 	u32 val;
 
 	sdr_set_bits(host->base + MSDC_CFG, MSDC_CFG_RST);
-	readl_poll_timeout(host->base + MSDC_CFG, val, !(val & MSDC_CFG_RST), 0, 0);
+	readl_poll_timeout_atomic(host->base + MSDC_CFG, val, !(val & MSDC_CFG_RST), 0, 0);
 
 	sdr_set_bits(host->base + MSDC_FIFOCS, MSDC_FIFOCS_CLR);
-	readl_poll_timeout(host->base + MSDC_FIFOCS, val,
-			   !(val & MSDC_FIFOCS_CLR), 0, 0);
+	readl_poll_timeout_atomic(host->base + MSDC_FIFOCS, val,
+				  !(val & MSDC_FIFOCS_CLR), 0, 0);
 
 	val = readl(host->base + MSDC_INT);
 	writel(val, host->base + MSDC_INT);
diff --git a/drivers/mtd/maps/physmap-core.c b/drivers/mtd/maps/physmap-core.c
index 4f63b8430c71..9ab795f03c54 100644
--- a/drivers/mtd/maps/physmap-core.c
+++ b/drivers/mtd/maps/physmap-core.c
@@ -556,6 +556,17 @@ static int physmap_flash_probe(struct platform_device *dev)
 		if (info->probe_type) {
 			info->mtds[i] = do_map_probe(info->probe_type,
 						     &info->maps[i]);
+
+			/* Fall back to mapping region as ROM */
+			if (!info->mtds[i] && IS_ENABLED(CONFIG_MTD_ROM) &&
+			    strcmp(info->probe_type, "map_rom")) {
+				dev_warn(&dev->dev,
+					 "map_probe() failed for type %s\n",
+					 info->probe_type);
+
+				info->mtds[i] = do_map_probe("map_rom",
+							     &info->maps[i]);
+			}
 		} else {
 			int j;
 
diff --git a/drivers/mtd/nand/raw/arasan-nand-controller.c b/drivers/mtd/nand/raw/arasan-nand-controller.c
index 296fb16c8dc3..1b4ebceee1e0 100644
--- a/drivers/mtd/nand/raw/arasan-nand-controller.c
+++ b/drivers/mtd/nand/raw/arasan-nand-controller.c
@@ -515,6 +515,7 @@ static int anfc_write_page_hw_ecc(struct nand_chip *chip, const u8 *buf,
 	struct mtd_info *mtd = nand_to_mtd(chip);
 	unsigned int len = mtd->writesize + (oob_required ? mtd->oobsize : 0);
 	dma_addr_t dma_addr;
+	u8 status;
 	int ret;
 	struct anfc_op nfc_op = {
 		.pkt_reg =
@@ -561,10 +562,21 @@ static int anfc_write_page_hw_ecc(struct nand_chip *chip, const u8 *buf,
 	}
 
 	/* Spare data is not protected */
-	if (oob_required)
+	if (oob_required) {
 		ret = nand_write_oob_std(chip, page);
+		if (ret)
+			return ret;
+	}
 
-	return ret;
+	/* Check write status on the chip side */
+	ret = nand_status_op(chip, &status);
+	if (ret)
+		return ret;
+
+	if (status & NAND_STATUS_FAIL)
+		return -EIO;
+
+	return 0;
 }
 
 static int anfc_sel_write_page_hw_ecc(struct nand_chip *chip, const u8 *buf,
diff --git a/drivers/mtd/nand/raw/marvell_nand.c b/drivers/mtd/nand/raw/marvell_nand.c
index 9f662d5cf7fa..15a2a09c7ae2 100644
--- a/drivers/mtd/nand/raw/marvell_nand.c
+++ b/drivers/mtd/nand/raw/marvell_nand.c
@@ -1148,6 +1148,7 @@ static int marvell_nfc_hw_ecc_hmg_do_write_page(struct nand_chip *chip,
 		.ndcb[2] = NDCB2_ADDR5_PAGE(page),
 	};
 	unsigned int oob_bytes = lt->spare_bytes + (raw ? lt->ecc_bytes : 0);
+	u8 status;
 	int ret;
 
 	/* NFCv2 needs more information about the operation being executed */
@@ -1181,7 +1182,18 @@ static int marvell_nfc_hw_ecc_hmg_do_write_page(struct nand_chip *chip,
 
 	ret = marvell_nfc_wait_op(chip,
 				  PSEC_TO_MSEC(sdr->tPROG_max));
-	return ret;
+	if (ret)
+		return ret;
+
+	/* Check write status on the chip side */
+	ret = nand_status_op(chip, &status);
+	if (ret)
+		return ret;
+
+	if (status & NAND_STATUS_FAIL)
+		return -EIO;
+
+	return 0;
 }
 
 static int marvell_nfc_hw_ecc_hmg_write_page_raw(struct nand_chip *chip,
@@ -1610,6 +1622,7 @@ static int marvell_nfc_hw_ecc_bch_write_page(struct nand_chip *chip,
 	int data_len = lt->data_bytes;
 	int spare_len = lt->spare_bytes;
 	int chunk, ret;
+	u8 status;
 
 	marvell_nfc_select_target(chip, chip->cur_cs);
 
@@ -1646,6 +1659,14 @@ static int marvell_nfc_hw_ecc_bch_write_page(struct nand_chip *chip,
 	if (ret)
 		return ret;
 
+	/* Check write status on the chip side */
+	ret = nand_status_op(chip, &status);
+	if (ret)
+		return ret;
+
+	if (status & NAND_STATUS_FAIL)
+		return -EIO;
+
 	return 0;
 }
 
diff --git a/drivers/mtd/nand/raw/pl35x-nand-controller.c b/drivers/mtd/nand/raw/pl35x-nand-controller.c
index 3c6f6aff649f..7bcece135715 100644
--- a/drivers/mtd/nand/raw/pl35x-nand-controller.c
+++ b/drivers/mtd/nand/raw/pl35x-nand-controller.c
@@ -513,6 +513,7 @@ static int pl35x_nand_write_page_hwecc(struct nand_chip *chip,
 	u32 addr1 = 0, addr2 = 0, row;
 	u32 cmd_addr;
 	int i, ret;
+	u8 status;
 
 	ret = pl35x_smc_set_ecc_mode(nfc, chip, PL35X_SMC_ECC_CFG_MODE_APB);
 	if (ret)
@@ -565,6 +566,14 @@ static int pl35x_nand_write_page_hwecc(struct nand_chip *chip,
 	if (ret)
 		goto disable_ecc_engine;
 
+	/* Check write status on the chip side */
+	ret = nand_status_op(chip, &status);
+	if (ret)
+		goto disable_ecc_engine;
+
+	if (status & NAND_STATUS_FAIL)
+		ret = -EIO;
+
 disable_ecc_engine:
 	pl35x_smc_set_ecc_mode(nfc, chip, PL35X_SMC_ECC_CFG_MODE_BYPASS);
 
diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index e972bee60e7c..a171df54de85 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -3093,7 +3093,7 @@ static int qcom_nandc_probe(struct platform_device *pdev)
 err_aon_clk:
 	clk_disable_unprepare(nandc->core_clk);
 err_core_clk:
-	dma_unmap_resource(dev, res->start, resource_size(res),
+	dma_unmap_resource(dev, nandc->base_dma, resource_size(res),
 			   DMA_BIDIRECTIONAL, 0);
 	return ret;
 }
diff --git a/drivers/mtd/nand/spi/micron.c b/drivers/mtd/nand/spi/micron.c
index 50b7295bc922..12601bc4227a 100644
--- a/drivers/mtd/nand/spi/micron.c
+++ b/drivers/mtd/nand/spi/micron.c
@@ -12,7 +12,7 @@
 
 #define SPINAND_MFR_MICRON		0x2c
 
-#define MICRON_STATUS_ECC_MASK		GENMASK(7, 4)
+#define MICRON_STATUS_ECC_MASK		GENMASK(6, 4)
 #define MICRON_STATUS_ECC_NO_BITFLIPS	(0 << 4)
 #define MICRON_STATUS_ECC_1TO3_BITFLIPS	(1 << 4)
 #define MICRON_STATUS_ECC_4TO6_BITFLIPS	(3 << 4)
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index e64c652b78f0..80e42852ffef 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -3722,7 +3722,7 @@ static inline const void *bond_pull_data(struct sk_buff *skb,
 	if (likely(n <= hlen))
 		return data;
 	else if (skb && likely(pskb_may_pull(skb, n)))
-		return skb->head;
+		return skb->data;
 
 	return NULL;
 }
diff --git a/drivers/net/dsa/bcm_sf2.c b/drivers/net/dsa/bcm_sf2.c
index 773d751ef169..1fa392aee52d 100644
--- a/drivers/net/dsa/bcm_sf2.c
+++ b/drivers/net/dsa/bcm_sf2.c
@@ -577,17 +577,16 @@ static int bcm_sf2_mdio_register(struct dsa_switch *ds)
 	dn = of_find_compatible_node(NULL, NULL, "brcm,unimac-mdio");
 	priv->master_mii_bus = of_mdio_find_bus(dn);
 	if (!priv->master_mii_bus) {
-		of_node_put(dn);
-		return -EPROBE_DEFER;
+		err = -EPROBE_DEFER;
+		goto err_of_node_put;
 	}
 
-	get_device(&priv->master_mii_bus->dev);
 	priv->master_mii_dn = dn;
 
 	priv->slave_mii_bus = mdiobus_alloc();
 	if (!priv->slave_mii_bus) {
-		of_node_put(dn);
-		return -ENOMEM;
+		err = -ENOMEM;
+		goto err_put_master_mii_bus_dev;
 	}
 
 	priv->slave_mii_bus->priv = priv;
@@ -644,11 +643,17 @@ static int bcm_sf2_mdio_register(struct dsa_switch *ds)
 	}
 
 	err = mdiobus_register(priv->slave_mii_bus);
-	if (err && dn) {
-		mdiobus_free(priv->slave_mii_bus);
-		of_node_put(dn);
-	}
+	if (err && dn)
+		goto err_free_slave_mii_bus;
 
+	return 0;
+
+err_free_slave_mii_bus:
+	mdiobus_free(priv->slave_mii_bus);
+err_put_master_mii_bus_dev:
+	put_device(&priv->master_mii_bus->dev);
+err_of_node_put:
+	of_node_put(dn);
 	return err;
 }
 
@@ -656,6 +661,7 @@ static void bcm_sf2_mdio_unregister(struct bcm_sf2_priv *priv)
 {
 	mdiobus_unregister(priv->slave_mii_bus);
 	mdiobus_free(priv->slave_mii_bus);
+	put_device(&priv->master_mii_bus->dev);
 	of_node_put(priv->master_mii_dn);
 }
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index 7f91e04d75b8..99dd8187476b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -1080,7 +1080,7 @@ void i40e_clear_hw(struct i40e_hw *hw)
 		     I40E_PFLAN_QALLOC_FIRSTQ_SHIFT;
 	j = (val & I40E_PFLAN_QALLOC_LASTQ_MASK) >>
 	    I40E_PFLAN_QALLOC_LASTQ_SHIFT;
-	if (val & I40E_PFLAN_QALLOC_VALID_MASK)
+	if (val & I40E_PFLAN_QALLOC_VALID_MASK && j >= base_queue)
 		num_queues = (j - base_queue) + 1;
 	else
 		num_queues = 0;
@@ -1090,7 +1090,7 @@ void i40e_clear_hw(struct i40e_hw *hw)
 	    I40E_PF_VT_PFALLOC_FIRSTVF_SHIFT;
 	j = (val & I40E_PF_VT_PFALLOC_LASTVF_MASK) >>
 	    I40E_PF_VT_PFALLOC_LASTVF_SHIFT;
-	if (val & I40E_PF_VT_PFALLOC_VALID_MASK)
+	if (val & I40E_PF_VT_PFALLOC_VALID_MASK && j >= i)
 		num_vfs = (j - i) + 1;
 	else
 		num_vfs = 0;
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 4417238b0e64..8c0ee9a8ff86 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -954,8 +954,7 @@ static void ice_set_rss_vsi_ctx(struct ice_vsi_ctx *ctxt, struct ice_vsi *vsi)
 
 	ctxt->info.q_opt_rss = ((lut_type << ICE_AQ_VSI_Q_OPT_RSS_LUT_S) &
 				ICE_AQ_VSI_Q_OPT_RSS_LUT_M) |
-				((hash_type << ICE_AQ_VSI_Q_OPT_RSS_HASH_S) &
-				 ICE_AQ_VSI_Q_OPT_RSS_HASH_M);
+				(hash_type & ICE_AQ_VSI_Q_OPT_RSS_HASH_M);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index deba18cdc5ef..d4c29e2562a1 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -6,6 +6,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <generated/utsrelease.h>
+#include <linux/crash_dump.h>
 #include "ice.h"
 #include "ice_base.h"
 #include "ice_lib.h"
@@ -4255,6 +4256,20 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
 		return -EINVAL;
 	}
 
+	/* when under a kdump kernel initiate a reset before enabling the
+	 * device in order to clear out any pending DMA transactions. These
+	 * transactions can cause some systems to machine check when doing
+	 * the pcim_enable_device() below.
+	 */
+	if (is_kdump_kernel()) {
+		pci_save_state(pdev);
+		pci_clear_master(pdev);
+		err = pcie_flr(pdev);
+		if (err)
+			return err;
+		pci_restore_state(pdev);
+	}
+
 	/* this driver uses devres, see
 	 * Documentation/driver-api/driver-model/devres.rst
 	 */
diff --git a/drivers/net/ethernet/marvell/sky2.h b/drivers/net/ethernet/marvell/sky2.h
index ddec1627f1a7..8d0bacf4e49c 100644
--- a/drivers/net/ethernet/marvell/sky2.h
+++ b/drivers/net/ethernet/marvell/sky2.h
@@ -2195,7 +2195,7 @@ struct rx_ring_info {
 	struct sk_buff	*skb;
 	dma_addr_t	data_addr;
 	DEFINE_DMA_UNMAP_LEN(data_size);
-	dma_addr_t	frag_addr[ETH_JUMBO_MTU >> PAGE_SHIFT];
+	dma_addr_t	frag_addr[ETH_JUMBO_MTU >> PAGE_SHIFT ?: 1];
 };
 
 enum flow_control {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c b/drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c
index 958cdb975559..b69ab30ecf03 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c
@@ -821,7 +821,7 @@ static void mlx5_fw_tracer_ownership_change(struct work_struct *work)
 
 	mlx5_core_dbg(tracer->dev, "FWTracer: ownership changed, current=(%d)\n", tracer->owner);
 	if (tracer->owner) {
-		tracer->owner = false;
+		mlx5_fw_tracer_ownership_acquire(tracer);
 		return;
 	}
 
diff --git a/drivers/net/ethernet/netronome/nfp/flower/cmsg.c b/drivers/net/ethernet/netronome/nfp/flower/cmsg.c
index f21cf1f40f98..153533cd8f08 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/cmsg.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/cmsg.c
@@ -210,6 +210,7 @@ nfp_flower_cmsg_merge_hint_rx(struct nfp_app *app, struct sk_buff *skb)
 	unsigned int msg_len = nfp_flower_cmsg_get_data_len(skb);
 	struct nfp_flower_cmsg_merge_hint *msg;
 	struct nfp_fl_payload *sub_flows[2];
+	struct nfp_flower_priv *priv;
 	int err, i, flow_cnt;
 
 	msg = nfp_flower_cmsg_get_data(skb);
@@ -228,14 +229,15 @@ nfp_flower_cmsg_merge_hint_rx(struct nfp_app *app, struct sk_buff *skb)
 		return;
 	}
 
-	rtnl_lock();
+	priv = app->priv;
+	mutex_lock(&priv->nfp_fl_lock);
 	for (i = 0; i < flow_cnt; i++) {
 		u32 ctx = be32_to_cpu(msg->flow[i].host_ctx);
 
 		sub_flows[i] = nfp_flower_get_fl_payload_from_ctx(app, ctx);
 		if (!sub_flows[i]) {
 			nfp_flower_cmsg_warn(app, "Invalid flow in merge hint\n");
-			goto err_rtnl_unlock;
+			goto err_mutex_unlock;
 		}
 	}
 
@@ -244,8 +246,8 @@ nfp_flower_cmsg_merge_hint_rx(struct nfp_app *app, struct sk_buff *skb)
 	if (err == -ENOMEM)
 		nfp_flower_cmsg_warn(app, "Flow merge memory fail.\n");
 
-err_rtnl_unlock:
-	rtnl_unlock();
+err_mutex_unlock:
+	mutex_unlock(&priv->nfp_fl_lock);
 }
 
 static void
diff --git a/drivers/net/ethernet/netronome/nfp/flower/conntrack.c b/drivers/net/ethernet/netronome/nfp/flower/conntrack.c
index 7e9fcc16286e..fc17e9b11d19 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/conntrack.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/conntrack.c
@@ -1665,8 +1665,6 @@ nfp_fl_ct_offload_nft_flow(struct nfp_fl_ct_zone_entry *zt, struct flow_cls_offl
 	struct nfp_fl_ct_flow_entry *ct_entry;
 	struct netlink_ext_ack *extack = NULL;
 
-	ASSERT_RTNL();
-
 	extack = flow->common.extack;
 	switch (flow->command) {
 	case FLOW_CLS_REPLACE:
@@ -1709,9 +1707,13 @@ int nfp_fl_ct_handle_nft_flow(enum tc_setup_type type, void *type_data, void *cb
 
 	switch (type) {
 	case TC_SETUP_CLSFLOWER:
-		rtnl_lock();
+		while (!mutex_trylock(&zt->priv->nfp_fl_lock)) {
+			if (!zt->nft) /* avoid deadlock */
+				return err;
+			msleep(20);
+		}
 		err = nfp_fl_ct_offload_nft_flow(zt, flow);
-		rtnl_unlock();
+		mutex_unlock(&zt->priv->nfp_fl_lock);
 		break;
 	default:
 		return -EOPNOTSUPP;
@@ -1739,6 +1741,7 @@ int nfp_fl_ct_del_flow(struct nfp_fl_ct_map_entry *ct_map_ent)
 	struct nfp_fl_ct_flow_entry *ct_entry;
 	struct nfp_fl_ct_zone_entry *zt;
 	struct rhashtable *m_table;
+	struct nf_flowtable *nft;
 
 	if (!ct_map_ent)
 		return -ENOENT;
@@ -1755,8 +1758,12 @@ int nfp_fl_ct_del_flow(struct nfp_fl_ct_map_entry *ct_map_ent)
 		nfp_fl_ct_clean_flow_entry(ct_entry);
 		kfree(ct_map_ent);
 
-		if (!zt->pre_ct_count) {
-			zt->nft = NULL;
+		if (!zt->pre_ct_count && zt->nft) {
+			nft = zt->nft;
+			zt->nft = NULL; /* avoid deadlock */
+			nf_flow_table_offload_del_cb(nft,
+						     nfp_fl_ct_handle_nft_flow,
+						     zt);
 			nfp_fl_ct_clean_nft_entries(zt);
 		}
 		break;
diff --git a/drivers/net/ethernet/netronome/nfp/flower/main.h b/drivers/net/ethernet/netronome/nfp/flower/main.h
index 917c450a7aad..f5222e3c8ce5 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/main.h
+++ b/drivers/net/ethernet/netronome/nfp/flower/main.h
@@ -196,6 +196,7 @@ struct nfp_fl_internal_ports {
  * @ct_zone_table:	Hash table used to store the different zones
  * @ct_zone_wc:		Special zone entry for wildcarded zone matches
  * @ct_map_table:	Hash table used to referennce ct flows
+ * @nfp_fl_lock:	Lock to protect the flow offload operation
  */
 struct nfp_flower_priv {
 	struct nfp_app *app;
@@ -233,6 +234,7 @@ struct nfp_flower_priv {
 	struct rhashtable ct_zone_table;
 	struct nfp_fl_ct_zone_entry *ct_zone_wc;
 	struct rhashtable ct_map_table;
+	struct mutex nfp_fl_lock; /* Protect the flow operation */
 };
 
 /**
diff --git a/drivers/net/ethernet/netronome/nfp/flower/metadata.c b/drivers/net/ethernet/netronome/nfp/flower/metadata.c
index 2af9faee96c5..a515bd89defe 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/metadata.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/metadata.c
@@ -530,6 +530,8 @@ int nfp_flower_metadata_init(struct nfp_app *app, u64 host_ctx_count,
 	if (err)
 		goto err_free_stats_ctx_table;
 
+	mutex_init(&priv->nfp_fl_lock);
+
 	err = rhashtable_init(&priv->ct_zone_table, &nfp_zone_table_params);
 	if (err)
 		goto err_free_merge_table;
diff --git a/drivers/net/ethernet/netronome/nfp/flower/offload.c b/drivers/net/ethernet/netronome/nfp/flower/offload.c
index 64c0ef57ad42..d165098c457e 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/offload.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/offload.c
@@ -1009,8 +1009,6 @@ int nfp_flower_merge_offloaded_flows(struct nfp_app *app,
 	u64 parent_ctx = 0;
 	int err;
 
-	ASSERT_RTNL();
-
 	if (sub_flow1 == sub_flow2 ||
 	    nfp_flower_is_merge_flow(sub_flow1) ||
 	    nfp_flower_is_merge_flow(sub_flow2))
@@ -1662,19 +1660,30 @@ static int
 nfp_flower_repr_offload(struct nfp_app *app, struct net_device *netdev,
 			struct flow_cls_offload *flower)
 {
+	struct nfp_flower_priv *priv = app->priv;
+	int ret;
+
 	if (!eth_proto_is_802_3(flower->common.protocol))
 		return -EOPNOTSUPP;
 
+	mutex_lock(&priv->nfp_fl_lock);
 	switch (flower->command) {
 	case FLOW_CLS_REPLACE:
-		return nfp_flower_add_offload(app, netdev, flower);
+		ret = nfp_flower_add_offload(app, netdev, flower);
+		break;
 	case FLOW_CLS_DESTROY:
-		return nfp_flower_del_offload(app, netdev, flower);
+		ret = nfp_flower_del_offload(app, netdev, flower);
+		break;
 	case FLOW_CLS_STATS:
-		return nfp_flower_get_stats(app, netdev, flower);
+		ret = nfp_flower_get_stats(app, netdev, flower);
+		break;
 	default:
-		return -EOPNOTSUPP;
+		ret = -EOPNOTSUPP;
+		break;
 	}
+	mutex_unlock(&priv->nfp_fl_lock);
+
+	return ret;
 }
 
 static int nfp_flower_setup_tc_block_cb(enum tc_setup_type type,
@@ -1713,6 +1722,7 @@ static int nfp_flower_setup_tc_block(struct net_device *netdev,
 	repr_priv = repr->app_priv;
 	repr_priv->block_shared = f->block_shared;
 	f->driver_block_list = &nfp_block_cb_list;
+	f->unlocked_driver_cb = true;
 
 	switch (f->command) {
 	case FLOW_BLOCK_BIND:
@@ -1811,6 +1821,8 @@ nfp_flower_setup_indr_tc_block(struct net_device *netdev, struct Qdisc *sch, str
 	     nfp_flower_internal_port_can_offload(app, netdev)))
 		return -EOPNOTSUPP;
 
+	f->unlocked_driver_cb = true;
+
 	switch (f->command) {
 	case FLOW_BLOCK_BIND:
 		cb_priv = nfp_flower_indr_block_cb_priv_lookup(app, netdev);
diff --git a/drivers/net/ethernet/netronome/nfp/flower/qos_conf.c b/drivers/net/ethernet/netronome/nfp/flower/qos_conf.c
index 784c6dbf8bc4..577a7a534b47 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/qos_conf.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/qos_conf.c
@@ -421,23 +421,29 @@ int nfp_flower_setup_qos_offload(struct nfp_app *app, struct net_device *netdev,
 {
 	struct netlink_ext_ack *extack = flow->common.extack;
 	struct nfp_flower_priv *fl_priv = app->priv;
+	int ret;
 
 	if (!(fl_priv->flower_ext_feats & NFP_FL_FEATS_VF_RLIM)) {
 		NL_SET_ERR_MSG_MOD(extack, "unsupported offload: loaded firmware does not support qos rate limit offload");
 		return -EOPNOTSUPP;
 	}
 
+	mutex_lock(&fl_priv->nfp_fl_lock);
 	switch (flow->command) {
 	case TC_CLSMATCHALL_REPLACE:
-		return nfp_flower_install_rate_limiter(app, netdev, flow,
-						       extack);
+		ret = nfp_flower_install_rate_limiter(app, netdev, flow, extack);
+		break;
 	case TC_CLSMATCHALL_DESTROY:
-		return nfp_flower_remove_rate_limiter(app, netdev, flow,
-						      extack);
+		ret = nfp_flower_remove_rate_limiter(app, netdev, flow, extack);
+		break;
 	case TC_CLSMATCHALL_STATS:
-		return nfp_flower_stats_rate_limiter(app, netdev, flow,
-						     extack);
+		ret = nfp_flower_stats_rate_limiter(app, netdev, flow, extack);
+		break;
 	default:
-		return -EOPNOTSUPP;
+		ret = -EOPNOTSUPP;
+		break;
 	}
+	mutex_unlock(&fl_priv->nfp_fl_lock);
+
+	return ret;
 }
diff --git a/drivers/net/ethernet/qlogic/qed/qed_ll2.c b/drivers/net/ethernet/qlogic/qed/qed_ll2.c
index c46a7f756ed5..08710ba9db74 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_ll2.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_ll2.c
@@ -87,7 +87,10 @@ static void qed_ll2b_complete_tx_packet(void *cxt,
 static int qed_ll2_alloc_buffer(struct qed_dev *cdev,
 				u8 **data, dma_addr_t *phys_addr)
 {
-	*data = kmalloc(cdev->ll2->rx_size, GFP_ATOMIC);
+	size_t size = cdev->ll2->rx_size + NET_SKB_PAD +
+		      SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
+
+	*data = kmalloc(size, GFP_ATOMIC);
 	if (!(*data)) {
 		DP_INFO(cdev, "Failed to allocate LL2 buffer data\n");
 		return -ENOMEM;
@@ -2548,7 +2551,7 @@ static int qed_ll2_start(struct qed_dev *cdev, struct qed_ll2_params *params)
 	INIT_LIST_HEAD(&cdev->ll2->list);
 	spin_lock_init(&cdev->ll2->lock);
 
-	cdev->ll2->rx_size = NET_SKB_PAD + ETH_HLEN +
+	cdev->ll2->rx_size = PRM_DMA_PAD_BYTES_NUM + ETH_HLEN +
 			     L1_CACHE_BYTES + params->mtu;
 
 	/* Allocate memory for LL2.
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index e685c84ebe3a..603530e6cd7b 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -3010,10 +3010,11 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 	struct net *net = sock_net(&tfile->sk);
 	struct tun_struct *tun;
 	void __user* argp = (void __user*)arg;
-	unsigned int ifindex, carrier;
+	unsigned int carrier;
 	struct ifreq ifr;
 	kuid_t owner;
 	kgid_t group;
+	int ifindex;
 	int sndbuf;
 	int vnet_hdr_sz;
 	int le;
@@ -3069,7 +3070,9 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 		ret = -EFAULT;
 		if (copy_from_user(&ifindex, argp, sizeof(ifindex)))
 			goto unlock;
-
+		ret = -EINVAL;
+		if (ifindex < 0)
+			goto unlock;
 		ret = 0;
 		tfile->ifindex = ifindex;
 		goto unlock;
diff --git a/drivers/net/usb/smsc95xx.c b/drivers/net/usb/smsc95xx.c
index 649d9f9af6e6..16a6cdf02515 100644
--- a/drivers/net/usb/smsc95xx.c
+++ b/drivers/net/usb/smsc95xx.c
@@ -860,7 +860,7 @@ static int smsc95xx_reset(struct usbnet *dev)
 
 	if (timeout >= 100) {
 		netdev_warn(dev->net, "timeout waiting for completion of Lite Reset\n");
-		return ret;
+		return -ETIMEDOUT;
 	}
 
 	ret = smsc95xx_write_reg(dev, PM_CTRL, PM_CTL_PHY_RST_);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index e354918c2480..b127e0b527ce 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -1445,6 +1445,7 @@ static void iwl_mvm_rx_tx_cmd_single(struct iwl_mvm *mvm,
 		iwl_trans_free_tx_cmd(mvm->trans, info->driver_data[1]);
 
 		memset(&info->status, 0, sizeof(info->status));
+		info->flags &= ~(IEEE80211_TX_STAT_ACK | IEEE80211_TX_STAT_TX_FILTERED);
 
 		/* inform mac80211 about what happened with the frame */
 		switch (status & TX_STATUS_MSK) {
@@ -1790,6 +1791,8 @@ static void iwl_mvm_tx_reclaim(struct iwl_mvm *mvm, int sta_id, int tid,
 		 */
 		if (!is_flush)
 			info->flags |= IEEE80211_TX_STAT_ACK;
+		else
+			info->flags &= ~IEEE80211_TX_STAT_ACK;
 	}
 
 	/*
diff --git a/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c b/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
index cbe4a200e4ea..e5f34805c92c 100644
--- a/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
+++ b/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
@@ -933,6 +933,14 @@ void mwifiex_11n_rxba_sync_event(struct mwifiex_private *priv,
 	while (tlv_buf_left >= sizeof(*tlv_rxba)) {
 		tlv_type = le16_to_cpu(tlv_rxba->header.type);
 		tlv_len  = le16_to_cpu(tlv_rxba->header.len);
+		if (size_add(sizeof(tlv_rxba->header), tlv_len) > tlv_buf_left) {
+			mwifiex_dbg(priv->adapter, WARN,
+				    "TLV size (%zu) overflows event_buf buf_left=%d\n",
+				    size_add(sizeof(tlv_rxba->header), tlv_len),
+				    tlv_buf_left);
+			return;
+		}
+
 		if (tlv_type != TLV_TYPE_RXBA_SYNC) {
 			mwifiex_dbg(priv->adapter, ERROR,
 				    "Wrong TLV id=0x%x\n", tlv_type);
@@ -941,6 +949,14 @@ void mwifiex_11n_rxba_sync_event(struct mwifiex_private *priv,
 
 		tlv_seq_num = le16_to_cpu(tlv_rxba->seq_num);
 		tlv_bitmap_len = le16_to_cpu(tlv_rxba->bitmap_len);
+		if (size_add(sizeof(*tlv_rxba), tlv_bitmap_len) > tlv_buf_left) {
+			mwifiex_dbg(priv->adapter, WARN,
+				    "TLV size (%zu) overflows event_buf buf_left=%d\n",
+				    size_add(sizeof(*tlv_rxba), tlv_bitmap_len),
+				    tlv_buf_left);
+			return;
+		}
+
 		mwifiex_dbg(priv->adapter, INFO,
 			    "%pM tid=%d seq_num=%d bitmap_len=%d\n",
 			    tlv_rxba->mac, tlv_rxba->tid, tlv_seq_num,
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 65172a654a19..19a61cddb56d 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3307,7 +3307,8 @@ static const struct pci_device_id nvme_id_table[] = {
 	{ PCI_VDEVICE(INTEL, 0x0a54),	/* Intel P4500/P4600 */
 		.driver_data = NVME_QUIRK_STRIPE_SIZE |
 				NVME_QUIRK_DEALLOCATE_ZEROES |
-				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
+				NVME_QUIRK_IGNORE_DEV_SUBNQN |
+				NVME_QUIRK_BOGUS_NID, },
 	{ PCI_VDEVICE(INTEL, 0x0a55),	/* Dell Express Flash P4600 */
 		.driver_data = NVME_QUIRK_STRIPE_SIZE |
 				NVME_QUIRK_DEALLOCATE_ZEROES, },
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index b76e1d4adcc7..6e92bdf459fe 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -645,6 +645,9 @@ static void __nvme_rdma_stop_queue(struct nvme_rdma_queue *queue)
 
 static void nvme_rdma_stop_queue(struct nvme_rdma_queue *queue)
 {
+	if (!test_bit(NVME_RDMA_Q_ALLOCATED, &queue->flags))
+		return;
+
 	mutex_lock(&queue->queue_lock);
 	if (test_and_clear_bit(NVME_RDMA_Q_LIVE, &queue->flags))
 		__nvme_rdma_stop_queue(queue);
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 2add26637c87..6a57cf885db1 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -348,6 +348,7 @@ static void nvmet_tcp_fatal_error(struct nvmet_tcp_queue *queue)
 
 static void nvmet_tcp_socket_error(struct nvmet_tcp_queue *queue, int status)
 {
+	queue->rcv_state = NVMET_TCP_RECV_ERR;
 	if (status == -EPIPE || status == -ECONNRESET)
 		kernel_sock_shutdown(queue->sock, SHUT_RDWR);
 	else
@@ -894,15 +895,11 @@ static int nvmet_tcp_handle_icreq(struct nvmet_tcp_queue *queue)
 	iov.iov_len = sizeof(*icresp);
 	ret = kernel_sendmsg(queue->sock, &msg, &iov, 1, iov.iov_len);
 	if (ret < 0)
-		goto free_crypto;
+		return ret; /* queue removal will cleanup */
 
 	queue->state = NVMET_TCP_Q_LIVE;
 	nvmet_prepare_receive_pdu(queue);
 	return 0;
-free_crypto:
-	if (queue->hdr_digest || queue->data_digest)
-		nvmet_tcp_free_crypto(queue);
-	return ret;
 }
 
 static void nvmet_tcp_handle_req_failure(struct nvmet_tcp_queue *queue,
diff --git a/drivers/phy/motorola/phy-mapphone-mdm6600.c b/drivers/phy/motorola/phy-mapphone-mdm6600.c
index 3cd4d51c247c..67802f9e40ba 100644
--- a/drivers/phy/motorola/phy-mapphone-mdm6600.c
+++ b/drivers/phy/motorola/phy-mapphone-mdm6600.c
@@ -122,16 +122,10 @@ static int phy_mdm6600_power_on(struct phy *x)
 {
 	struct phy_mdm6600 *ddata = phy_get_drvdata(x);
 	struct gpio_desc *enable_gpio = ddata->ctrl_gpios[PHY_MDM6600_ENABLE];
-	int error;
 
 	if (!ddata->enabled)
 		return -ENODEV;
 
-	error = pinctrl_pm_select_default_state(ddata->dev);
-	if (error)
-		dev_warn(ddata->dev, "%s: error with default_state: %i\n",
-			 __func__, error);
-
 	gpiod_set_value_cansleep(enable_gpio, 1);
 
 	/* Allow aggressive PM for USB, it's only needed for n_gsm port */
@@ -160,11 +154,6 @@ static int phy_mdm6600_power_off(struct phy *x)
 
 	gpiod_set_value_cansleep(enable_gpio, 0);
 
-	error = pinctrl_pm_select_sleep_state(ddata->dev);
-	if (error)
-		dev_warn(ddata->dev, "%s: error with sleep_state: %i\n",
-			 __func__, error);
-
 	return 0;
 }
 
@@ -456,6 +445,7 @@ static void phy_mdm6600_device_power_off(struct phy_mdm6600 *ddata)
 {
 	struct gpio_desc *reset_gpio =
 		ddata->ctrl_gpios[PHY_MDM6600_RESET];
+	int error;
 
 	ddata->enabled = false;
 	phy_mdm6600_cmd(ddata, PHY_MDM6600_CMD_BP_SHUTDOWN_REQ);
@@ -471,6 +461,17 @@ static void phy_mdm6600_device_power_off(struct phy_mdm6600 *ddata)
 	} else {
 		dev_err(ddata->dev, "Timed out powering down\n");
 	}
+
+	/*
+	 * Keep reset gpio high with padconf internal pull-up resistor to
+	 * prevent modem from waking up during deeper SoC idle states. The
+	 * gpio bank lines can have glitches if not in the always-on wkup
+	 * domain.
+	 */
+	error = pinctrl_pm_select_sleep_state(ddata->dev);
+	if (error)
+		dev_warn(ddata->dev, "%s: error with sleep_state: %i\n",
+			 __func__, error);
 }
 
 static void phy_mdm6600_deferred_power_on(struct work_struct *work)
@@ -571,12 +572,6 @@ static int phy_mdm6600_probe(struct platform_device *pdev)
 	ddata->dev = &pdev->dev;
 	platform_set_drvdata(pdev, ddata);
 
-	/* Active state selected in phy_mdm6600_power_on() */
-	error = pinctrl_pm_select_sleep_state(ddata->dev);
-	if (error)
-		dev_warn(ddata->dev, "%s: error with sleep_state: %i\n",
-			 __func__, error);
-
 	error = phy_mdm6600_init_lines(ddata);
 	if (error)
 		return error;
@@ -627,10 +622,12 @@ static int phy_mdm6600_probe(struct platform_device *pdev)
 	pm_runtime_put_autosuspend(ddata->dev);
 
 cleanup:
-	if (error < 0)
+	if (error < 0) {
 		phy_mdm6600_device_power_off(ddata);
-	pm_runtime_disable(ddata->dev);
-	pm_runtime_dont_use_autosuspend(ddata->dev);
+		pm_runtime_disable(ddata->dev);
+		pm_runtime_dont_use_autosuspend(ddata->dev);
+	}
+
 	return error;
 }
 
@@ -639,6 +636,7 @@ static int phy_mdm6600_remove(struct platform_device *pdev)
 	struct phy_mdm6600 *ddata = platform_get_drvdata(pdev);
 	struct gpio_desc *reset_gpio = ddata->ctrl_gpios[PHY_MDM6600_RESET];
 
+	pm_runtime_get_noresume(ddata->dev);
 	pm_runtime_dont_use_autosuspend(ddata->dev);
 	pm_runtime_put_sync(ddata->dev);
 	pm_runtime_disable(ddata->dev);
diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index 17c6931211c6..ffe39336fcac 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -1007,20 +1007,17 @@ static int add_setting(struct pinctrl *p, struct pinctrl_dev *pctldev,
 
 static struct pinctrl *find_pinctrl(struct device *dev)
 {
-	struct pinctrl *entry, *p = NULL;
+	struct pinctrl *p;
 
 	mutex_lock(&pinctrl_list_mutex);
-
-	list_for_each_entry(entry, &pinctrl_list, node) {
-		if (entry->dev == dev) {
-			p = entry;
-			kref_get(&p->users);
-			break;
+	list_for_each_entry(p, &pinctrl_list, node)
+		if (p->dev == dev) {
+			mutex_unlock(&pinctrl_list_mutex);
+			return p;
 		}
-	}
 
 	mutex_unlock(&pinctrl_list_mutex);
-	return p;
+	return NULL;
 }
 
 static void pinctrl_free(struct pinctrl *p, bool inlist);
@@ -1129,6 +1126,7 @@ struct pinctrl *pinctrl_get(struct device *dev)
 	p = find_pinctrl(dev);
 	if (p) {
 		dev_dbg(dev, "obtain a copy of previously claimed pinctrl\n");
+		kref_get(&p->users);
 		return p;
 	}
 
diff --git a/drivers/platform/surface/surface_platform_profile.c b/drivers/platform/surface/surface_platform_profile.c
index 6373d3b5eb7f..dadcf8c7d790 100644
--- a/drivers/platform/surface/surface_platform_profile.c
+++ b/drivers/platform/surface/surface_platform_profile.c
@@ -159,8 +159,7 @@ static int surface_platform_profile_probe(struct ssam_device *sdev)
 	set_bit(PLATFORM_PROFILE_BALANCED_PERFORMANCE, tpd->handler.choices);
 	set_bit(PLATFORM_PROFILE_PERFORMANCE, tpd->handler.choices);
 
-	platform_profile_register(&tpd->handler);
-	return 0;
+	return platform_profile_register(&tpd->handler);
 }
 
 static void surface_platform_profile_remove(struct ssam_device *sdev)
diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
index 2c43801a18a2..59ca3dab59e1 100644
--- a/drivers/platform/x86/asus-nb-wmi.c
+++ b/drivers/platform/x86/asus-nb-wmi.c
@@ -518,6 +518,9 @@ static void asus_nb_wmi_quirks(struct asus_wmi_driver *driver)
 static const struct key_entry asus_nb_wmi_keymap[] = {
 	{ KE_KEY, ASUS_WMI_BRN_DOWN, { KEY_BRIGHTNESSDOWN } },
 	{ KE_KEY, ASUS_WMI_BRN_UP, { KEY_BRIGHTNESSUP } },
+	{ KE_KEY, 0x2a, { KEY_SELECTIVE_SCREENSHOT } },
+	{ KE_IGNORE, 0x2b, }, /* PrintScreen (also send via PS/2) on newer models */
+	{ KE_IGNORE, 0x2c, }, /* CapsLock (also send via PS/2) on newer models */
 	{ KE_KEY, 0x30, { KEY_VOLUMEUP } },
 	{ KE_KEY, 0x31, { KEY_VOLUMEDOWN } },
 	{ KE_KEY, 0x32, { KEY_MUTE } },
diff --git a/drivers/platform/x86/asus-wmi.h b/drivers/platform/x86/asus-wmi.h
index b302415bf1d9..49f2b8f8ad3e 100644
--- a/drivers/platform/x86/asus-wmi.h
+++ b/drivers/platform/x86/asus-wmi.h
@@ -18,7 +18,7 @@
 #include <linux/i8042.h>
 
 #define ASUS_WMI_KEY_IGNORE (-1)
-#define ASUS_WMI_BRN_DOWN	0x20
+#define ASUS_WMI_BRN_DOWN	0x2e
 #define ASUS_WMI_BRN_UP		0x2f
 
 struct module;
diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/touchscreen_dmi.c
index 90aee8b87bbe..f129e29b295d 100644
--- a/drivers/platform/x86/touchscreen_dmi.c
+++ b/drivers/platform/x86/touchscreen_dmi.c
@@ -743,6 +743,21 @@ static const struct ts_dmi_data pipo_w11_data = {
 	.properties	= pipo_w11_props,
 };
 
+static const struct property_entry positivo_c4128b_props[] = {
+	PROPERTY_ENTRY_U32("touchscreen-min-x", 4),
+	PROPERTY_ENTRY_U32("touchscreen-min-y", 13),
+	PROPERTY_ENTRY_U32("touchscreen-size-x", 1915),
+	PROPERTY_ENTRY_U32("touchscreen-size-y", 1269),
+	PROPERTY_ENTRY_STRING("firmware-name", "gsl1680-positivo-c4128b.fw"),
+	PROPERTY_ENTRY_U32("silead,max-fingers", 10),
+	{ }
+};
+
+static const struct ts_dmi_data positivo_c4128b_data = {
+	.acpi_name	= "MSSL1680:00",
+	.properties	= positivo_c4128b_props,
+};
+
 static const struct property_entry pov_mobii_wintab_p800w_v20_props[] = {
 	PROPERTY_ENTRY_U32("touchscreen-min-x", 32),
 	PROPERTY_ENTRY_U32("touchscreen-min-y", 16),
@@ -1442,6 +1457,14 @@ const struct dmi_system_id touchscreen_dmi_table[] = {
 			DMI_MATCH(DMI_BIOS_VERSION, "MOMO.G.WI71C.MABMRBA02"),
 		},
 	},
+	{
+		/* Positivo C4128B */
+		.driver_data = (void *)&positivo_c4128b_data,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Positivo Tecnologia SA"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "C4128B-1"),
+		},
+	},
 	{
 		/* Point of View mobii wintab p800w (v2.0) */
 		.driver_data = (void *)&pov_mobii_wintab_p800w_v20_data,
diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index ebde10e74434..8ad50dc8fb35 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -5649,15 +5649,11 @@ regulator_register(const struct regulator_desc *regulator_desc,
 	mutex_lock(&regulator_list_mutex);
 	regulator_ena_gpio_free(rdev);
 	mutex_unlock(&regulator_list_mutex);
-	put_device(&rdev->dev);
-	rdev = NULL;
 clean:
 	if (dangling_of_gpiod)
 		gpiod_put(config->ena_gpiod);
-	if (rdev && rdev->dev.of_node)
-		of_node_put(rdev->dev.of_node);
-	kfree(rdev);
 	kfree(config);
+	put_device(&rdev->dev);
 rinse:
 	if (dangling_cfg_gpiod)
 		gpiod_put(cfg->ena_gpiod);
diff --git a/drivers/s390/cio/css.c b/drivers/s390/cio/css.c
index 2ba9e0135565..3c499136af65 100644
--- a/drivers/s390/cio/css.c
+++ b/drivers/s390/cio/css.c
@@ -233,17 +233,19 @@ struct subchannel *css_alloc_subchannel(struct subchannel_id schid,
 	 */
 	ret = dma_set_coherent_mask(&sch->dev, DMA_BIT_MASK(31));
 	if (ret)
-		goto err;
+		goto err_lock;
 	/*
 	 * But we don't have such restrictions imposed on the stuff that
 	 * is handled by the streaming API.
 	 */
 	ret = dma_set_mask(&sch->dev, DMA_BIT_MASK(64));
 	if (ret)
-		goto err;
+		goto err_lock;
 
 	return sch;
 
+err_lock:
+	kfree(sch->lock);
 err:
 	kfree(sch);
 	return ERR_PTR(ret);
diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index a6b374c026a8..f114847331fe 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -32,6 +32,7 @@
 #include "8250.h"
 
 #define DEFAULT_CLK_SPEED	48000000
+#define OMAP_UART_REGSHIFT	2
 
 #define UART_ERRATA_i202_MDR1_ACCESS	(1 << 0)
 #define OMAP_UART_WER_HAS_TX_WAKEUP	(1 << 1)
@@ -109,6 +110,7 @@
 #define UART_OMAP_RX_LVL		0x19
 
 struct omap8250_priv {
+	void __iomem *membase;
 	int line;
 	u8 habit;
 	u8 mdr1;
@@ -152,9 +154,9 @@ static void omap_8250_rx_dma_flush(struct uart_8250_port *p);
 static inline void omap_8250_rx_dma_flush(struct uart_8250_port *p) { }
 #endif
 
-static u32 uart_read(struct uart_8250_port *up, u32 reg)
+static u32 uart_read(struct omap8250_priv *priv, u32 reg)
 {
-	return readl(up->port.membase + (reg << up->port.regshift));
+	return readl(priv->membase + (reg << OMAP_UART_REGSHIFT));
 }
 
 /*
@@ -552,7 +554,7 @@ static void omap_serial_fill_features_erratas(struct uart_8250_port *up,
 	u32 mvr, scheme;
 	u16 revision, major, minor;
 
-	mvr = uart_read(up, UART_OMAP_MVER);
+	mvr = uart_read(priv, UART_OMAP_MVER);
 
 	/* Check revision register scheme */
 	scheme = mvr >> OMAP_UART_MVR_SCHEME_SHIFT;
@@ -1336,7 +1338,7 @@ static int omap8250_probe(struct platform_device *pdev)
 		UPF_HARD_FLOW;
 	up.port.private_data = priv;
 
-	up.port.regshift = 2;
+	up.port.regshift = OMAP_UART_REGSHIFT;
 	up.port.fifosize = 64;
 	up.tx_loadsz = 64;
 	up.capabilities = UART_CAP_FIFO;
@@ -1397,6 +1399,8 @@ static int omap8250_probe(struct platform_device *pdev)
 			 DEFAULT_CLK_SPEED);
 	}
 
+	priv->membase = membase;
+	priv->line = -ENODEV;
 	priv->latency = PM_QOS_CPU_LATENCY_DEFAULT_VALUE;
 	priv->calc_latency = PM_QOS_CPU_LATENCY_DEFAULT_VALUE;
 	cpu_latency_qos_add_request(&priv->pm_qos_request, priv->latency);
@@ -1404,6 +1408,8 @@ static int omap8250_probe(struct platform_device *pdev)
 
 	spin_lock_init(&priv->rx_dma_lock);
 
+	platform_set_drvdata(pdev, priv);
+
 	device_init_wakeup(&pdev->dev, true);
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_use_autosuspend(&pdev->dev);
@@ -1465,7 +1471,6 @@ static int omap8250_probe(struct platform_device *pdev)
 		goto err;
 	}
 	priv->line = ret;
-	platform_set_drvdata(pdev, priv);
 	pm_runtime_mark_last_busy(&pdev->dev);
 	pm_runtime_put_autosuspend(&pdev->dev);
 	return 0;
@@ -1487,11 +1492,12 @@ static int omap8250_remove(struct platform_device *pdev)
 	if (err)
 		return err;
 
+	serial8250_unregister_port(priv->line);
+	priv->line = -ENODEV;
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_put_sync(&pdev->dev);
 	flush_work(&priv->qos_work);
 	pm_runtime_disable(&pdev->dev);
-	serial8250_unregister_port(priv->line);
 	cpu_latency_qos_remove_request(&priv->pm_qos_request);
 	device_init_wakeup(&pdev->dev, false);
 	return 0;
@@ -1521,7 +1527,7 @@ static int omap8250_suspend(struct device *dev)
 {
 	struct omap8250_priv *priv = dev_get_drvdata(dev);
 	struct uart_8250_port *up = serial8250_get_port(priv->line);
-	int err;
+	int err = 0;
 
 	serial8250_suspend_port(priv->line);
 
@@ -1531,7 +1537,8 @@ static int omap8250_suspend(struct device *dev)
 	if (!device_may_wakeup(dev))
 		priv->wer = 0;
 	serial_out(up, UART_OMAP_WER, priv->wer);
-	err = pm_runtime_force_suspend(dev);
+	if (uart_console(&up->port) && console_suspend_enabled)
+		err = pm_runtime_force_suspend(dev);
 	flush_work(&priv->qos_work);
 
 	return err;
@@ -1540,11 +1547,15 @@ static int omap8250_suspend(struct device *dev)
 static int omap8250_resume(struct device *dev)
 {
 	struct omap8250_priv *priv = dev_get_drvdata(dev);
+	struct uart_8250_port *up = serial8250_get_port(priv->line);
 	int err;
 
-	err = pm_runtime_force_resume(dev);
-	if (err)
-		return err;
+	if (uart_console(&up->port) && console_suspend_enabled) {
+		err = pm_runtime_force_resume(dev);
+		if (err)
+			return err;
+	}
+
 	serial8250_resume_port(priv->line);
 	/* Paired with pm_runtime_resume_and_get() in omap8250_suspend() */
 	pm_runtime_mark_last_busy(dev);
@@ -1573,11 +1584,15 @@ static int omap8250_lost_context(struct uart_8250_port *up)
 	return 0;
 }
 
+static void uart_write(struct omap8250_priv *priv, u32 reg, u32 val)
+{
+	writel(val, priv->membase + (reg << OMAP_UART_REGSHIFT));
+}
+
 /* TODO: in future, this should happen via API in drivers/reset/ */
 static int omap8250_soft_reset(struct device *dev)
 {
 	struct omap8250_priv *priv = dev_get_drvdata(dev);
-	struct uart_8250_port *up = serial8250_get_port(priv->line);
 	int timeout = 100;
 	int sysc;
 	int syss;
@@ -1591,20 +1606,20 @@ static int omap8250_soft_reset(struct device *dev)
 	 * needing omap8250_soft_reset() quirk. Do it in two writes as
 	 * recommended in the comment for omap8250_update_scr().
 	 */
-	serial_out(up, UART_OMAP_SCR, OMAP_UART_SCR_DMAMODE_1);
-	serial_out(up, UART_OMAP_SCR,
+	uart_write(priv, UART_OMAP_SCR, OMAP_UART_SCR_DMAMODE_1);
+	uart_write(priv, UART_OMAP_SCR,
 		   OMAP_UART_SCR_DMAMODE_1 | OMAP_UART_SCR_DMAMODE_CTL);
 
-	sysc = serial_in(up, UART_OMAP_SYSC);
+	sysc = uart_read(priv, UART_OMAP_SYSC);
 
 	/* softreset the UART */
 	sysc |= OMAP_UART_SYSC_SOFTRESET;
-	serial_out(up, UART_OMAP_SYSC, sysc);
+	uart_write(priv, UART_OMAP_SYSC, sysc);
 
 	/* By experiments, 1us enough for reset complete on AM335x */
 	do {
 		udelay(1);
-		syss = serial_in(up, UART_OMAP_SYSS);
+		syss = uart_read(priv, UART_OMAP_SYSS);
 	} while (--timeout && !(syss & OMAP_UART_SYSS_RESETDONE));
 
 	if (!timeout) {
@@ -1618,23 +1633,10 @@ static int omap8250_soft_reset(struct device *dev)
 static int omap8250_runtime_suspend(struct device *dev)
 {
 	struct omap8250_priv *priv = dev_get_drvdata(dev);
-	struct uart_8250_port *up;
+	struct uart_8250_port *up = NULL;
 
-	/* In case runtime-pm tries this before we are setup */
-	if (!priv)
-		return 0;
-
-	up = serial8250_get_port(priv->line);
-	/*
-	 * When using 'no_console_suspend', the console UART must not be
-	 * suspended. Since driver suspend is managed by runtime suspend,
-	 * preventing runtime suspend (by returning error) will keep device
-	 * active during suspend.
-	 */
-	if (priv->is_suspending && !console_suspend_enabled) {
-		if (uart_console(&up->port))
-			return -EBUSY;
-	}
+	if (priv->line >= 0)
+		up = serial8250_get_port(priv->line);
 
 	if (priv->habit & UART_ERRATA_CLOCK_DISABLE) {
 		int ret;
@@ -1643,13 +1645,15 @@ static int omap8250_runtime_suspend(struct device *dev)
 		if (ret)
 			return ret;
 
-		/* Restore to UART mode after reset (for wakeup) */
-		omap8250_update_mdr1(up, priv);
-		/* Restore wakeup enable register */
-		serial_out(up, UART_OMAP_WER, priv->wer);
+		if (up) {
+			/* Restore to UART mode after reset (for wakeup) */
+			omap8250_update_mdr1(up, priv);
+			/* Restore wakeup enable register */
+			serial_out(up, UART_OMAP_WER, priv->wer);
+		}
 	}
 
-	if (up->dma && up->dma->rxchan)
+	if (up && up->dma && up->dma->rxchan)
 		omap_8250_rx_dma_flush(up);
 
 	priv->latency = PM_QOS_CPU_LATENCY_DEFAULT_VALUE;
@@ -1661,18 +1665,15 @@ static int omap8250_runtime_suspend(struct device *dev)
 static int omap8250_runtime_resume(struct device *dev)
 {
 	struct omap8250_priv *priv = dev_get_drvdata(dev);
-	struct uart_8250_port *up;
-
-	/* In case runtime-pm tries this before we are setup */
-	if (!priv)
-		return 0;
+	struct uart_8250_port *up = NULL;
 
-	up = serial8250_get_port(priv->line);
+	if (priv->line >= 0)
+		up = serial8250_get_port(priv->line);
 
-	if (omap8250_lost_context(up))
+	if (up && omap8250_lost_context(up))
 		omap8250_restore_regs(up);
 
-	if (up->dma && up->dma->rxchan && !(priv->habit & UART_HAS_EFR2))
+	if (up && up->dma && up->dma->rxchan && !(priv->habit & UART_HAS_EFR2))
 		omap_8250_rx_dma(up);
 
 	priv->latency = priv->calc_latency;
diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index f13930b4534c..b9dd714a3ae6 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -203,6 +203,9 @@ static void option_instat_callback(struct urb *urb);
 #define DELL_PRODUCT_5829E_ESIM			0x81e4
 #define DELL_PRODUCT_5829E			0x81e6
 
+#define DELL_PRODUCT_FM101R			0x8213
+#define DELL_PRODUCT_FM101R_ESIM		0x8215
+
 #define KYOCERA_VENDOR_ID			0x0c88
 #define KYOCERA_PRODUCT_KPC650			0x17da
 #define KYOCERA_PRODUCT_KPC680			0x180a
@@ -1108,6 +1111,8 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = RSVD(0) | RSVD(6) },
 	{ USB_DEVICE(DELL_VENDOR_ID, DELL_PRODUCT_5829E_ESIM),
 	  .driver_info = RSVD(0) | RSVD(6) },
+	{ USB_DEVICE_INTERFACE_CLASS(DELL_VENDOR_ID, DELL_PRODUCT_FM101R, 0xff) },
+	{ USB_DEVICE_INTERFACE_CLASS(DELL_VENDOR_ID, DELL_PRODUCT_FM101R_ESIM, 0xff) },
 	{ USB_DEVICE(ANYDATA_VENDOR_ID, ANYDATA_PRODUCT_ADU_E100A) },	/* ADU-E100, ADU-310 */
 	{ USB_DEVICE(ANYDATA_VENDOR_ID, ANYDATA_PRODUCT_ADU_500A) },
 	{ USB_DEVICE(ANYDATA_VENDOR_ID, ANYDATA_PRODUCT_ADU_620UW) },
@@ -1290,6 +1295,7 @@ static const struct usb_device_id option_ids[] = {
 	 .driver_info = NCTRL(0) | RSVD(3) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1033, 0xff),	/* Telit LE910C1-EUX (ECM) */
 	 .driver_info = NCTRL(0) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1035, 0xff) }, /* Telit LE910C4-WWX (ECM) */
 	{ USB_DEVICE(TELIT_VENDOR_ID, TELIT_PRODUCT_LE922_USBCFG0),
 	  .driver_info = RSVD(0) | RSVD(1) | NCTRL(2) | RSVD(3) },
 	{ USB_DEVICE(TELIT_VENDOR_ID, TELIT_PRODUCT_LE922_USBCFG1),
@@ -2262,6 +2268,7 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_INTERFACE_CLASS(0x305a, 0x1406, 0xff) },			/* GosunCn GM500 ECM/NCM */
 	{ USB_DEVICE_AND_INTERFACE_INFO(OPPO_VENDOR_ID, OPPO_PRODUCT_R11, 0xff, 0xff, 0x30) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(SIERRA_VENDOR_ID, SIERRA_PRODUCT_EM9191, 0xff, 0xff, 0x30) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(SIERRA_VENDOR_ID, SIERRA_PRODUCT_EM9191, 0xff, 0xff, 0x40) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(SIERRA_VENDOR_ID, SIERRA_PRODUCT_EM9191, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(UNISOC_VENDOR_ID, TOZED_PRODUCT_LT70C, 0xff, 0, 0) },
 	{ } /* Terminating entry */
diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index a648dff2bece..8b53313bf3b2 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -545,18 +545,30 @@ noinline int btrfs_cow_block(struct btrfs_trans_handle *trans,
 	u64 search_start;
 	int ret;
 
-	if (test_bit(BTRFS_ROOT_DELETING, &root->state))
-		btrfs_err(fs_info,
-			"COW'ing blocks on a fs root that's being dropped");
-
-	if (trans->transaction != fs_info->running_transaction)
-		WARN(1, KERN_CRIT "trans %llu running %llu\n",
-		       trans->transid,
-		       fs_info->running_transaction->transid);
+	if (unlikely(test_bit(BTRFS_ROOT_DELETING, &root->state))) {
+		btrfs_abort_transaction(trans, -EUCLEAN);
+		btrfs_crit(fs_info,
+		   "attempt to COW block %llu on root %llu that is being deleted",
+			   buf->start, btrfs_root_id(root));
+		return -EUCLEAN;
+	}
 
-	if (trans->transid != fs_info->generation)
-		WARN(1, KERN_CRIT "trans %llu running %llu\n",
-		       trans->transid, fs_info->generation);
+	/*
+	 * COWing must happen through a running transaction, which always
+	 * matches the current fs generation (it's a transaction with a state
+	 * less than TRANS_STATE_UNBLOCKED). If it doesn't, then turn the fs
+	 * into error state to prevent the commit of any transaction.
+	 */
+	if (unlikely(trans->transaction != fs_info->running_transaction ||
+		     trans->transid != fs_info->generation)) {
+		btrfs_abort_transaction(trans, -EUCLEAN);
+		btrfs_crit(fs_info,
+"unexpected transaction when attempting to COW block %llu on root %llu, transaction %llu running transaction %llu fs generation %llu",
+			   buf->start, btrfs_root_id(root), trans->transid,
+			   fs_info->running_transaction->transid,
+			   fs_info->generation);
+		return -EUCLEAN;
+	}
 
 	if (!should_cow_block(trans, root, buf)) {
 		*cow_ret = buf;
@@ -668,8 +680,22 @@ int btrfs_realloc_node(struct btrfs_trans_handle *trans,
 	int progress_passed = 0;
 	struct btrfs_disk_key disk_key;
 
-	WARN_ON(trans->transaction != fs_info->running_transaction);
-	WARN_ON(trans->transid != fs_info->generation);
+	/*
+	 * COWing must happen through a running transaction, which always
+	 * matches the current fs generation (it's a transaction with a state
+	 * less than TRANS_STATE_UNBLOCKED). If it doesn't, then turn the fs
+	 * into error state to prevent the commit of any transaction.
+	 */
+	if (unlikely(trans->transaction != fs_info->running_transaction ||
+		     trans->transid != fs_info->generation)) {
+		btrfs_abort_transaction(trans, -EUCLEAN);
+		btrfs_crit(fs_info,
+"unexpected transaction when attempting to reallocate parent %llu for root %llu, transaction %llu running transaction %llu fs generation %llu",
+			   parent->start, btrfs_root_id(root), trans->transid,
+			   fs_info->running_transaction->transid,
+			   fs_info->generation);
+		return -EUCLEAN;
+	}
 
 	parent_nritems = btrfs_header_nritems(parent);
 	blocksize = fs_info->nodesize;
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 48f2de789b75..a19bdb359740 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1674,12 +1674,12 @@ static int run_delayed_tree_ref(struct btrfs_trans_handle *trans,
 		parent = ref->parent;
 	ref_root = ref->root;
 
-	if (node->ref_mod != 1) {
+	if (unlikely(node->ref_mod != 1)) {
 		btrfs_err(trans->fs_info,
-	"btree block(%llu) has %d references rather than 1: action %d ref_root %llu parent %llu",
+	"btree block %llu has %d references rather than 1: action %d ref_root %llu parent %llu",
 			  node->bytenr, node->ref_mod, node->action, ref_root,
 			  parent);
-		return -EIO;
+		return -EUCLEAN;
 	}
 	if (node->action == BTRFS_ADD_DELAYED_REF && insert_reserved) {
 		BUG_ON(!extent_op || !extent_op->update_flags);
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 33f4557d1a68..dc9f4f80f90b 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3531,7 +3531,7 @@ static void get_block_group_info(struct list_head *groups_list,
 static long btrfs_ioctl_space_info(struct btrfs_fs_info *fs_info,
 				   void __user *arg)
 {
-	struct btrfs_ioctl_space_args space_args;
+	struct btrfs_ioctl_space_args space_args = { 0 };
 	struct btrfs_ioctl_space_info space;
 	struct btrfs_ioctl_space_info *dest;
 	struct btrfs_ioctl_space_info *dest_orig;
@@ -4867,7 +4867,7 @@ static int _btrfs_ioctl_send(struct file *file, void __user *argp, bool compat)
 
 	if (compat) {
 #if defined(CONFIG_64BIT) && defined(CONFIG_COMPAT)
-		struct btrfs_ioctl_send_args_32 args32;
+		struct btrfs_ioctl_send_args_32 args32 = { 0 };
 
 		ret = copy_from_user(&args32, argp, sizeof(args32));
 		if (ret)
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 7c0c6fc0c536..dcf0dd2093f5 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -4446,7 +4446,7 @@ static int btrfs_log_prealloc_extents(struct btrfs_trans_handle *trans,
 	struct extent_buffer *leaf;
 	int slot;
 	int ins_nr = 0;
-	int start_slot;
+	int start_slot = 0;
 	int ret;
 
 	if (!(inode->flags & BTRFS_INODE_PREALLOC))
diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index c76537a6826a..5f0abea107e4 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1557,10 +1557,15 @@ static void requeue_inode(struct inode *inode, struct bdi_writeback *wb,
 
 	if (wbc->pages_skipped) {
 		/*
-		 * writeback is not making progress due to locked
-		 * buffers. Skip this inode for now.
+		 * Writeback is not making progress due to locked buffers.
+		 * Skip this inode for now. Although having skipped pages
+		 * is odd for clean inodes, it can happen for some
+		 * filesystems so handle that gracefully.
 		 */
-		redirty_tail_locked(inode, wb);
+		if (inode->i_state & I_DIRTY_ALL)
+			redirty_tail_locked(inode, wb);
+		else
+			inode_cgwb_move_to_attached(inode, wb);
 		return;
 	}
 
diff --git a/fs/ksmbd/vfs_cache.c b/fs/ksmbd/vfs_cache.c
index 0df8467af39a..b67ce2d52cee 100644
--- a/fs/ksmbd/vfs_cache.c
+++ b/fs/ksmbd/vfs_cache.c
@@ -105,7 +105,7 @@ int ksmbd_query_inode_status(struct inode *inode)
 	ci = __ksmbd_inode_lookup(inode);
 	if (ci) {
 		ret = KSMBD_INODE_STATUS_OK;
-		if (ci->m_flags & S_DEL_PENDING)
+		if (ci->m_flags & (S_DEL_PENDING | S_DEL_ON_CLS))
 			ret = KSMBD_INODE_STATUS_PENDING_DELETE;
 		atomic_dec(&ci->m_count);
 	}
@@ -115,7 +115,7 @@ int ksmbd_query_inode_status(struct inode *inode)
 
 bool ksmbd_inode_pending_delete(struct ksmbd_file *fp)
 {
-	return (fp->f_ci->m_flags & S_DEL_PENDING);
+	return (fp->f_ci->m_flags & (S_DEL_PENDING | S_DEL_ON_CLS));
 }
 
 void ksmbd_set_inode_pending_delete(struct ksmbd_file *fp)
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 3275763b78bc..565d11a21f5e 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -8794,8 +8794,6 @@ static int _nfs4_proc_exchange_id(struct nfs_client *clp, const struct cred *cre
 	/* Save the EXCHANGE_ID verifier session trunk tests */
 	memcpy(clp->cl_confirm.data, argp->verifier.data,
 	       sizeof(clp->cl_confirm.data));
-	if (resp->flags & EXCHGID4_FLAG_USE_PNFS_DS)
-		set_bit(NFS_CS_DS, &clp->cl_flags);
 out:
 	trace_nfs4_exchange_id(clp, status);
 	rpc_put_task(task);
diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index 7217f3eeb069..9f6776c7062e 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -2629,31 +2629,44 @@ pnfs_should_return_unused_layout(struct pnfs_layout_hdr *lo,
 	return mode == 0;
 }
 
-static int
-pnfs_layout_return_unused_byserver(struct nfs_server *server, void *data)
+static int pnfs_layout_return_unused_byserver(struct nfs_server *server,
+					      void *data)
 {
 	const struct pnfs_layout_range *range = data;
+	const struct cred *cred;
 	struct pnfs_layout_hdr *lo;
 	struct inode *inode;
+	nfs4_stateid stateid;
+	enum pnfs_iomode iomode;
+
 restart:
 	rcu_read_lock();
 	list_for_each_entry_rcu(lo, &server->layouts, plh_layouts) {
-		if (!pnfs_layout_can_be_returned(lo) ||
+		inode = lo->plh_inode;
+		if (!inode || !pnfs_layout_can_be_returned(lo) ||
 		    test_bit(NFS_LAYOUT_RETURN_REQUESTED, &lo->plh_flags))
 			continue;
-		inode = lo->plh_inode;
 		spin_lock(&inode->i_lock);
-		if (!pnfs_should_return_unused_layout(lo, range)) {
+		if (!lo->plh_inode ||
+		    !pnfs_should_return_unused_layout(lo, range)) {
 			spin_unlock(&inode->i_lock);
 			continue;
 		}
+		pnfs_get_layout_hdr(lo);
+		pnfs_set_plh_return_info(lo, range->iomode, 0);
+		if (pnfs_mark_matching_lsegs_return(lo, &lo->plh_return_segs,
+						    range, 0) != 0 ||
+		    !pnfs_prepare_layoutreturn(lo, &stateid, &cred, &iomode)) {
+			spin_unlock(&inode->i_lock);
+			rcu_read_unlock();
+			pnfs_put_layout_hdr(lo);
+			cond_resched();
+			goto restart;
+		}
 		spin_unlock(&inode->i_lock);
-		inode = pnfs_grab_inode_layout_hdr(lo);
-		if (!inode)
-			continue;
 		rcu_read_unlock();
-		pnfs_mark_layout_for_return(inode, range);
-		iput(inode);
+		pnfs_send_layoutreturn(lo, &stateid, &cred, iomode, false);
+		pnfs_put_layout_hdr(lo);
 		cond_resched();
 		goto restart;
 	}
diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index 0ae70010b01d..11de2d469e9e 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -2458,10 +2458,12 @@ void mark_as_free_ex(struct ntfs_sb_info *sbi, CLST lcn, CLST len, bool trim)
 {
 	CLST end, i;
 	struct wnd_bitmap *wnd = &sbi->used.bitmap;
+	bool dirty = false;
 
 	down_write_nested(&wnd->rw_lock, BITMAP_MUTEX_CLUSTERS);
 	if (!wnd_is_used(wnd, lcn, len)) {
-		ntfs_set_state(sbi, NTFS_DIRTY_ERROR);
+		/* mark volume as dirty out of wnd->rw_lock */
+		dirty = true;
 
 		end = lcn + len;
 		len = 0;
@@ -2493,6 +2495,8 @@ void mark_as_free_ex(struct ntfs_sb_info *sbi, CLST lcn, CLST len, bool trim)
 
 out:
 	up_write(&wnd->rw_lock);
+	if (dirty)
+		ntfs_set_state(sbi, NTFS_DIRTY_ERROR);
 }
 
 /*
diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index 7705adc926b8..b49e62e2080b 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -729,6 +729,9 @@ static struct NTFS_DE *hdr_find_e(const struct ntfs_index *indx,
 	u32 total = le32_to_cpu(hdr->total);
 	u16 offs[128];
 
+	if (unlikely(!cmp))
+		return NULL;
+
 fill_table:
 	if (end > total)
 		return NULL;
diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
index aaf4bafa2c70..8e739023e305 100644
--- a/fs/ntfs3/xattr.c
+++ b/fs/ntfs3/xattr.c
@@ -209,7 +209,8 @@ static ssize_t ntfs_list_ea(struct ntfs_inode *ni, char *buffer,
 	size = le32_to_cpu(info->size);
 
 	/* Enumerate all xattrs. */
-	for (ret = 0, off = 0; off < size; off += ea_size) {
+	ret = 0;
+	for (off = 0; off + sizeof(struct EA_FULL) < size; off += ea_size) {
 		ea = Add2Ptr(ea_all, off);
 		ea_size = unpacked_ea_size(ea);
 
@@ -217,6 +218,10 @@ static ssize_t ntfs_list_ea(struct ntfs_inode *ni, char *buffer,
 			break;
 
 		if (buffer) {
+			/* Check if we can use field ea->name */
+			if (off + ea_size > size)
+				break;
+
 			if (ret + ea->name_len + 1 > bytes_per_buffer) {
 				err = -ERANGE;
 				goto out;
diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 864e821c3910..0ed70eff9cb9 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -306,7 +306,7 @@ static int ovl_set_timestamps(struct dentry *upperdentry, struct kstat *stat)
 {
 	struct iattr attr = {
 		.ia_valid =
-		     ATTR_ATIME | ATTR_MTIME | ATTR_ATIME_SET | ATTR_MTIME_SET,
+		     ATTR_ATIME | ATTR_MTIME | ATTR_ATIME_SET | ATTR_MTIME_SET | ATTR_CTIME,
 		.ia_atime = stat->atime,
 		.ia_mtime = stat->mtime,
 	};
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 1eb71275e5b0..8696d6551200 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -511,27 +511,6 @@ xfs_vn_get_link(
 	return ERR_PTR(error);
 }
 
-STATIC const char *
-xfs_vn_get_link_inline(
-	struct dentry		*dentry,
-	struct inode		*inode,
-	struct delayed_call	*done)
-{
-	struct xfs_inode	*ip = XFS_I(inode);
-	char			*link;
-
-	ASSERT(ip->i_df.if_format == XFS_DINODE_FMT_LOCAL);
-
-	/*
-	 * The VFS crashes on a NULL pointer, so return -EFSCORRUPTED if
-	 * if_data is junk.
-	 */
-	link = ip->i_df.if_u1.if_data;
-	if (XFS_IS_CORRUPT(ip->i_mount, !link))
-		return ERR_PTR(-EFSCORRUPTED);
-	return link;
-}
-
 static uint32_t
 xfs_stat_blksize(
 	struct xfs_inode	*ip)
@@ -1200,14 +1179,6 @@ static const struct inode_operations xfs_symlink_inode_operations = {
 	.update_time		= xfs_vn_update_time,
 };
 
-static const struct inode_operations xfs_inline_symlink_inode_operations = {
-	.get_link		= xfs_vn_get_link_inline,
-	.getattr		= xfs_vn_getattr,
-	.setattr		= xfs_vn_setattr,
-	.listxattr		= xfs_vn_listxattr,
-	.update_time		= xfs_vn_update_time,
-};
-
 /* Figure out if this file actually supports DAX. */
 static bool
 xfs_inode_supports_dax(
@@ -1358,10 +1329,7 @@ xfs_setup_iops(
 		inode->i_fop = &xfs_dir_file_operations;
 		break;
 	case S_IFLNK:
-		if (ip->i_df.if_format == XFS_DINODE_FMT_LOCAL)
-			inode->i_op = &xfs_inline_symlink_inode_operations;
-		else
-			inode->i_op = &xfs_symlink_inode_operations;
+		inode->i_op = &xfs_symlink_inode_operations;
 		break;
 	default:
 		inode->i_op = &xfs_inode_operations;
diff --git a/fs/xfs/xfs_symlink.c b/fs/xfs/xfs_symlink.c
index a31d2e5d0321..affbedf78160 100644
--- a/fs/xfs/xfs_symlink.c
+++ b/fs/xfs/xfs_symlink.c
@@ -22,6 +22,7 @@
 #include "xfs_trace.h"
 #include "xfs_trans.h"
 #include "xfs_ialloc.h"
+#include "xfs_error.h"
 
 /* ----- Kernel only functions below ----- */
 int
@@ -96,17 +97,15 @@ xfs_readlink_bmap_ilocked(
 
 int
 xfs_readlink(
-	struct xfs_inode *ip,
-	char		*link)
+	struct xfs_inode	*ip,
+	char			*link)
 {
-	struct xfs_mount *mp = ip->i_mount;
-	xfs_fsize_t	pathlen;
-	int		error = 0;
+	struct xfs_mount	*mp = ip->i_mount;
+	xfs_fsize_t		pathlen;
+	int			error = -EFSCORRUPTED;
 
 	trace_xfs_readlink(ip);
 
-	ASSERT(ip->i_df.if_format != XFS_DINODE_FMT_LOCAL);
-
 	if (xfs_is_shutdown(mp))
 		return -EIO;
 
@@ -121,12 +120,22 @@ xfs_readlink(
 			 __func__, (unsigned long long) ip->i_ino,
 			 (long long) pathlen);
 		ASSERT(0);
-		error = -EFSCORRUPTED;
 		goto out;
 	}
 
-
-	error = xfs_readlink_bmap_ilocked(ip, link);
+	if (ip->i_df.if_format == XFS_DINODE_FMT_LOCAL) {
+		/*
+		 * The VFS crashes on a NULL pointer, so return -EFSCORRUPTED
+		 * if if_data is junk.
+		 */
+		if (XFS_IS_CORRUPT(ip->i_mount, !ip->i_df.if_u1.if_data))
+			goto out;
+
+		memcpy(link, ip->i_df.if_u1.if_data, pathlen + 1);
+		error = 0;
+	} else {
+		error = xfs_readlink_bmap_ilocked(ip, link);
+	}
 
  out:
 	xfs_iunlock(ip, XFS_ILOCK_SHARED);
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 324561b7a5e8..9b43559e3acf 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -542,6 +542,8 @@ struct iio_dev {
 };
 
 int iio_device_id(struct iio_dev *indio_dev);
+int iio_device_get_current_mode(struct iio_dev *indio_dev);
+bool iio_buffer_enabled(struct iio_dev *indio_dev);
 
 const struct iio_chan_spec
 *iio_find_channel_from_si(struct iio_dev *indio_dev, int si);
@@ -573,6 +575,8 @@ int __devm_iio_device_register(struct device *dev, struct iio_dev *indio_dev,
 int iio_push_event(struct iio_dev *indio_dev, u64 ev_code, s64 timestamp);
 int iio_device_claim_direct_mode(struct iio_dev *indio_dev);
 void iio_device_release_direct_mode(struct iio_dev *indio_dev);
+int iio_device_claim_buffer_mode(struct iio_dev *indio_dev);
+void iio_device_release_buffer_mode(struct iio_dev *indio_dev);
 
 extern struct bus_type iio_bus_type;
 
@@ -671,16 +675,6 @@ struct iio_dev *devm_iio_device_alloc(struct device *parent, int sizeof_priv);
 __printf(2, 3)
 struct iio_trigger *devm_iio_trigger_alloc(struct device *parent,
 					   const char *fmt, ...);
-/**
- * iio_buffer_enabled() - helper function to test if the buffer is enabled
- * @indio_dev:		IIO device structure for device
- **/
-static inline bool iio_buffer_enabled(struct iio_dev *indio_dev)
-{
-	return indio_dev->currentmode
-		& (INDIO_BUFFER_TRIGGERED | INDIO_BUFFER_HARDWARE |
-		   INDIO_BUFFER_SOFTWARE);
-}
 
 /**
  * iio_get_debugfs_dentry() - helper function to get the debugfs_dentry
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index b5df2e59a51d..132f4344fee9 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2978,6 +2978,7 @@ struct net_device *__dev_get_by_flags(struct net *net, unsigned short flags,
 struct net_device *dev_get_by_name(struct net *net, const char *name);
 struct net_device *dev_get_by_name_rcu(struct net *net, const char *name);
 struct net_device *__dev_get_by_name(struct net *net, const char *name);
+bool netdev_name_in_use(struct net *net, const char *name);
 int dev_alloc_name(struct net_device *dev, const char *name);
 int dev_open(struct net_device *dev, struct netlink_ext_ack *extack);
 void dev_close(struct net_device *dev);
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 5806fc4dc7e5..dbf6ba59fbd0 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -661,6 +661,7 @@ struct perf_event {
 	/* The cumulative AND of all event_caps for events in this group. */
 	int				group_caps;
 
+	unsigned int			group_generation;
 	struct perf_event		*group_leader;
 	struct pmu			*pmu;
 	void				*pmu_private;
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 3da5cfcf84c1..1f718e91509f 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -310,7 +310,7 @@ struct hci_dev {
 	struct list_head list;
 	struct mutex	lock;
 
-	char		name[8];
+	const char	*name;
 	unsigned long	flags;
 	__u16		id;
 	__u8		bus;
diff --git a/include/net/bluetooth/hci_mon.h b/include/net/bluetooth/hci_mon.h
index 2d5fcda1bcd0..082f89531b88 100644
--- a/include/net/bluetooth/hci_mon.h
+++ b/include/net/bluetooth/hci_mon.h
@@ -56,7 +56,7 @@ struct hci_mon_new_index {
 	__u8		type;
 	__u8		bus;
 	bdaddr_t	bdaddr;
-	char		name[8];
+	char		name[8] __nonstring;
 } __packed;
 #define HCI_MON_NEW_INDEX_SIZE 16
 
diff --git a/include/net/ip_fib.h b/include/net/ip_fib.h
index c3324a1949c3..9f6e2a476dc2 100644
--- a/include/net/ip_fib.h
+++ b/include/net/ip_fib.h
@@ -151,6 +151,7 @@ struct fib_info {
 	int			fib_nhs;
 	bool			fib_nh_is_v6;
 	bool			nh_updated;
+	bool			pfsrc_removed;
 	struct nexthop		*nh;
 	struct rcu_head		rcu;
 	struct fib_nh		fib_nh[];
diff --git a/include/net/netns/xfrm.h b/include/net/netns/xfrm.h
index bd7c3be4af5d..423b52eca908 100644
--- a/include/net/netns/xfrm.h
+++ b/include/net/netns/xfrm.h
@@ -50,6 +50,7 @@ struct netns_xfrm {
 	struct list_head	policy_all;
 	struct hlist_head	*policy_byidx;
 	unsigned int		policy_idx_hmask;
+	unsigned int		idx_generator;
 	struct hlist_head	policy_inexact[XFRM_POLICY_MAX];
 	struct xfrm_policy_hash	policy_bydst[XFRM_POLICY_MAX];
 	unsigned int		policy_count[XFRM_POLICY_MAX * 2];
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 4d8c915a7bfa..e93a48edf438 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -141,6 +141,9 @@ void tcp_time_wait(struct sock *sk, int state, int timeo);
 #define TCP_RTO_MAX	((unsigned)(120*HZ))
 #define TCP_RTO_MIN	((unsigned)(HZ/5))
 #define TCP_TIMEOUT_MIN	(2U) /* Min timeout for TCP timers in jiffies */
+
+#define TCP_TIMEOUT_MIN_US (2*USEC_PER_MSEC) /* Min TCP timeout in microsecs */
+
 #define TCP_TIMEOUT_INIT ((unsigned)(1*HZ))	/* RFC6298 2.1 initial RTO value	*/
 #define TCP_TIMEOUT_FALLBACK ((unsigned)(3*HZ))	/* RFC 1122 initial RTO value, now
 						 * used as a fallback RTO for the
diff --git a/include/trace/events/neigh.h b/include/trace/events/neigh.h
index 62bb17516713..5ade62ac49b4 100644
--- a/include/trace/events/neigh.h
+++ b/include/trace/events/neigh.h
@@ -39,7 +39,6 @@ TRACE_EVENT(neigh_create,
 	),
 
 	TP_fast_assign(
-		struct in6_addr *pin6;
 		__be32 *p32;
 
 		__entry->family = tbl->family;
@@ -47,7 +46,6 @@ TRACE_EVENT(neigh_create,
 		__entry->entries = atomic_read(&tbl->gc_entries);
 		__entry->created = n != NULL;
 		__entry->gc_exempt = exempt_from_gc;
-		pin6 = (struct in6_addr *)__entry->primary_key6;
 		p32 = (__be32 *)__entry->primary_key4;
 
 		if (tbl->family == AF_INET)
@@ -57,6 +55,8 @@ TRACE_EVENT(neigh_create,
 
 #if IS_ENABLED(CONFIG_IPV6)
 		if (tbl->family == AF_INET6) {
+			struct in6_addr *pin6;
+
 			pin6 = (struct in6_addr *)__entry->primary_key6;
 			*pin6 = *(struct in6_addr *)pkey;
 		}
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index f92880a15645..a7fb8d2b7709 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -251,6 +251,8 @@ enum {
 	PERF_BR_SYSRET		= 8,	/* syscall return */
 	PERF_BR_COND_CALL	= 9,	/* conditional function call */
 	PERF_BR_COND_RET	= 10,	/* conditional function return */
+	PERF_BR_ERET		= 11,	/* exception return */
+	PERF_BR_IRQ		= 12,	/* irq */
 	PERF_BR_MAX,
 };
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index c7f13da672c9..1732f6548bc6 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2046,6 +2046,7 @@ static void perf_group_attach(struct perf_event *event)
 
 	list_add_tail(&event->sibling_list, &group_leader->sibling_list);
 	group_leader->nr_siblings++;
+	group_leader->group_generation++;
 
 	perf_event__header_size(group_leader);
 
@@ -2238,6 +2239,7 @@ static void perf_group_detach(struct perf_event *event)
 	if (leader != event) {
 		list_del_init(&event->sibling_list);
 		event->group_leader->nr_siblings--;
+		event->group_leader->group_generation++;
 		goto out;
 	}
 
@@ -5370,7 +5372,7 @@ static int __perf_read_group_add(struct perf_event *leader,
 					u64 read_format, u64 *values)
 {
 	struct perf_event_context *ctx = leader->ctx;
-	struct perf_event *sub;
+	struct perf_event *sub, *parent;
 	unsigned long flags;
 	int n = 1; /* skip @nr */
 	int ret;
@@ -5380,6 +5382,33 @@ static int __perf_read_group_add(struct perf_event *leader,
 		return ret;
 
 	raw_spin_lock_irqsave(&ctx->lock, flags);
+	/*
+	 * Verify the grouping between the parent and child (inherited)
+	 * events is still in tact.
+	 *
+	 * Specifically:
+	 *  - leader->ctx->lock pins leader->sibling_list
+	 *  - parent->child_mutex pins parent->child_list
+	 *  - parent->ctx->mutex pins parent->sibling_list
+	 *
+	 * Because parent->ctx != leader->ctx (and child_list nests inside
+	 * ctx->mutex), group destruction is not atomic between children, also
+	 * see perf_event_release_kernel(). Additionally, parent can grow the
+	 * group.
+	 *
+	 * Therefore it is possible to have parent and child groups in a
+	 * different configuration and summing over such a beast makes no sense
+	 * what so ever.
+	 *
+	 * Reject this.
+	 */
+	parent = leader->parent;
+	if (parent &&
+	    (parent->group_generation != leader->group_generation ||
+	     parent->nr_siblings != leader->nr_siblings)) {
+		ret = -ECHILD;
+		goto unlock;
+	}
 
 	/*
 	 * Since we co-schedule groups, {enabled,running} times of siblings
@@ -5409,8 +5438,9 @@ static int __perf_read_group_add(struct perf_event *leader,
 			values[n++] = primary_event_id(sub);
 	}
 
+unlock:
 	raw_spin_unlock_irqrestore(&ctx->lock, flags);
-	return 0;
+	return ret;
 }
 
 static int perf_read_group(struct perf_event *event,
@@ -5429,10 +5459,6 @@ static int perf_read_group(struct perf_event *event,
 
 	values[0] = 1 + leader->nr_siblings;
 
-	/*
-	 * By locking the child_mutex of the leader we effectively
-	 * lock the child list of all siblings.. XXX explain how.
-	 */
 	mutex_lock(&leader->child_mutex);
 
 	ret = __perf_read_group_add(leader, read_format, values);
@@ -13251,6 +13277,7 @@ static int inherit_group(struct perf_event *parent_event,
 		    !perf_get_aux_event(child_ctr, leader))
 			return -EINVAL;
 	}
+	leader->group_generation = parent_event->group_generation;
 	return 0;
 }
 
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index c626d02776a5..f8af4a15c3a8 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2753,6 +2753,7 @@ void trace_event_eval_update(struct trace_eval_map **map, int len)
 				update_event_fields(call, map[i]);
 			}
 		}
+		cond_resched();
 	}
 	up_write(&trace_event_sem);
 }
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index dbbd243c865f..64d6292cf686 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1226,13 +1226,16 @@ config DEBUG_TIMEKEEPING
 config DEBUG_PREEMPT
 	bool "Debug preemptible kernel"
 	depends on DEBUG_KERNEL && PREEMPTION && TRACE_IRQFLAGS_SUPPORT
-	default y
 	help
 	  If you say Y here then the kernel will use a debug variant of the
 	  commonly used smp_processor_id() function and will print warnings
 	  if kernel code uses it in a preemption-unsafe way. Also, the kernel
 	  will detect preemption count underflows.
 
+	  This option has potential to introduce high runtime overhead,
+	  depending on workload as it triggers debugging routines for each
+	  this_cpu operation. It should only be used for debugging purposes.
+
 menu "Lock Debugging (spinlocks, mutexes, etc...)"
 
 config LOCK_DEBUGGING_SUPPORT
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 7a7e92be1652..5f1e388c2b95 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1300,6 +1300,15 @@ struct hci_conn *hci_connect_acl(struct hci_dev *hdev, bdaddr_t *dst,
 		return ERR_PTR(-EOPNOTSUPP);
 	}
 
+	/* Reject outgoing connection to device with same BD ADDR against
+	 * CVE-2020-26555
+	 */
+	if (!bacmp(&hdev->bdaddr, dst)) {
+		bt_dev_dbg(hdev, "Reject connection with same BD_ADDR %pMR\n",
+			   dst);
+		return ERR_PTR(-ECONNREFUSED);
+	}
+
 	acl = hci_conn_hash_lookup_ba(hdev, ACL_LINK, dst);
 	if (!acl) {
 		acl = hci_conn_add(hdev, ACL_LINK, dst, HCI_ROLE_MASTER);
@@ -1477,34 +1486,41 @@ int hci_conn_security(struct hci_conn *conn, __u8 sec_level, __u8 auth_type,
 	if (!test_bit(HCI_CONN_AUTH, &conn->flags))
 		goto auth;
 
-	/* An authenticated FIPS approved combination key has sufficient
-	 * security for security level 4. */
-	if (conn->key_type == HCI_LK_AUTH_COMBINATION_P256 &&
-	    sec_level == BT_SECURITY_FIPS)
-		goto encrypt;
-
-	/* An authenticated combination key has sufficient security for
-	   security level 3. */
-	if ((conn->key_type == HCI_LK_AUTH_COMBINATION_P192 ||
-	     conn->key_type == HCI_LK_AUTH_COMBINATION_P256) &&
-	    sec_level == BT_SECURITY_HIGH)
-		goto encrypt;
-
-	/* An unauthenticated combination key has sufficient security for
-	   security level 1 and 2. */
-	if ((conn->key_type == HCI_LK_UNAUTH_COMBINATION_P192 ||
-	     conn->key_type == HCI_LK_UNAUTH_COMBINATION_P256) &&
-	    (sec_level == BT_SECURITY_MEDIUM || sec_level == BT_SECURITY_LOW))
-		goto encrypt;
-
-	/* A combination key has always sufficient security for the security
-	   levels 1 or 2. High security level requires the combination key
-	   is generated using maximum PIN code length (16).
-	   For pre 2.1 units. */
-	if (conn->key_type == HCI_LK_COMBINATION &&
-	    (sec_level == BT_SECURITY_MEDIUM || sec_level == BT_SECURITY_LOW ||
-	     conn->pin_length == 16))
-		goto encrypt;
+	switch (conn->key_type) {
+	case HCI_LK_AUTH_COMBINATION_P256:
+		/* An authenticated FIPS approved combination key has
+		 * sufficient security for security level 4 or lower.
+		 */
+		if (sec_level <= BT_SECURITY_FIPS)
+			goto encrypt;
+		break;
+	case HCI_LK_AUTH_COMBINATION_P192:
+		/* An authenticated combination key has sufficient security for
+		 * security level 3 or lower.
+		 */
+		if (sec_level <= BT_SECURITY_HIGH)
+			goto encrypt;
+		break;
+	case HCI_LK_UNAUTH_COMBINATION_P192:
+	case HCI_LK_UNAUTH_COMBINATION_P256:
+		/* An unauthenticated combination key has sufficient security
+		 * for security level 2 or lower.
+		 */
+		if (sec_level <= BT_SECURITY_MEDIUM)
+			goto encrypt;
+		break;
+	case HCI_LK_COMBINATION:
+		/* A combination key has always sufficient security for the
+		 * security levels 2 or lower. High security level requires the
+		 * combination key is generated using maximum PIN code length
+		 * (16). For pre 2.1 units.
+		 */
+		if (sec_level <= BT_SECURITY_MEDIUM || conn->pin_length == 16)
+			goto encrypt;
+		break;
+	default:
+		break;
+	}
 
 auth:
 	if (test_bit(HCI_CONN_ENCRYPT_PEND, &conn->flags))
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index e777ccf76b2b..b3b597960c56 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3920,7 +3920,11 @@ int hci_register_dev(struct hci_dev *hdev)
 	if (id < 0)
 		return id;
 
-	snprintf(hdev->name, sizeof(hdev->name), "hci%d", id);
+	error = dev_set_name(&hdev->dev, "hci%u", id);
+	if (error)
+		return error;
+
+	hdev->name = dev_name(&hdev->dev);
 	hdev->id = id;
 
 	BT_DBG("%p name %s bus %d", hdev, hdev->name, hdev->bus);
@@ -3942,8 +3946,6 @@ int hci_register_dev(struct hci_dev *hdev)
 	if (!IS_ERR_OR_NULL(bt_debugfs))
 		hdev->debugfs = debugfs_create_dir(hdev->name, bt_debugfs);
 
-	dev_set_name(&hdev->dev, "%s", hdev->name);
-
 	error = device_add(&hdev->dev);
 	if (error < 0)
 		goto err_wqueue;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 9f82fe0e6270..1dd65f13f893 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -25,6 +25,8 @@
 /* Bluetooth HCI event handling. */
 
 #include <asm/unaligned.h>
+#include <linux/crypto.h>
+#include <crypto/algapi.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -2794,6 +2796,16 @@ static void hci_conn_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	BT_DBG("%s bdaddr %pMR type 0x%x", hdev->name, &ev->bdaddr,
 	       ev->link_type);
 
+	/* Reject incoming connection from device with same BD ADDR against
+	 * CVE-2020-26555
+	 */
+	if (hdev && !bacmp(&hdev->bdaddr, &ev->bdaddr)) {
+		bt_dev_dbg(hdev, "Reject connection with same BD_ADDR %pMR\n",
+			   &ev->bdaddr);
+		hci_reject_conn(hdev, &ev->bdaddr);
+		return;
+	}
+
 	mask |= hci_proto_connect_ind(hdev, &ev->bdaddr, ev->link_type,
 				      &flags);
 
@@ -4173,6 +4185,15 @@ static void hci_link_key_notify_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	if (!conn)
 		goto unlock;
 
+	/* Ignore NULL link key against CVE-2020-26555 */
+	if (!crypto_memneq(ev->link_key, ZERO_KEY, HCI_LINK_KEY_SIZE)) {
+		bt_dev_dbg(hdev, "Ignore NULL link key (ZERO KEY) for %pMR",
+			   &ev->bdaddr);
+		hci_disconnect(conn, HCI_ERROR_AUTH_FAILURE);
+		hci_conn_drop(conn);
+		goto unlock;
+	}
+
 	hci_conn_hold(conn);
 	conn->disc_timeout = HCI_DISCONN_TIMEOUT;
 	hci_conn_drop(conn);
@@ -4677,8 +4698,8 @@ static u8 bredr_oob_data_present(struct hci_conn *conn)
 		 * available, then do not declare that OOB data is
 		 * present.
 		 */
-		if (!memcmp(data->rand256, ZERO_KEY, 16) ||
-		    !memcmp(data->hash256, ZERO_KEY, 16))
+		if (!crypto_memneq(data->rand256, ZERO_KEY, 16) ||
+		    !crypto_memneq(data->hash256, ZERO_KEY, 16))
 			return 0x00;
 
 		return 0x02;
@@ -4688,8 +4709,8 @@ static u8 bredr_oob_data_present(struct hci_conn *conn)
 	 * not supported by the hardware, then check that if
 	 * P-192 data values are present.
 	 */
-	if (!memcmp(data->rand192, ZERO_KEY, 16) ||
-	    !memcmp(data->hash192, ZERO_KEY, 16))
+	if (!crypto_memneq(data->rand192, ZERO_KEY, 16) ||
+	    !crypto_memneq(data->hash192, ZERO_KEY, 16))
 		return 0x00;
 
 	return 0x01;
@@ -4705,7 +4726,7 @@ static void hci_io_capa_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	hci_dev_lock(hdev);
 
 	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &ev->bdaddr);
-	if (!conn)
+	if (!conn || !hci_conn_ssp_enabled(conn))
 		goto unlock;
 
 	hci_conn_hold(conn);
@@ -4950,7 +4971,7 @@ static void hci_simple_pair_complete_evt(struct hci_dev *hdev,
 	hci_dev_lock(hdev);
 
 	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &ev->bdaddr);
-	if (!conn)
+	if (!conn || !hci_conn_ssp_enabled(conn))
 		goto unlock;
 
 	/* Reset the authentication requirement to unknown */
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 315f9ad3dc4d..28222c7c098e 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -438,7 +438,8 @@ static struct sk_buff *create_monitor_event(struct hci_dev *hdev, int event)
 		ni->type = hdev->dev_type;
 		ni->bus = hdev->bus;
 		bacpy(&ni->bdaddr, &hdev->bdaddr);
-		memcpy(ni->name, hdev->name, 8);
+		memcpy_and_pad(ni->name, sizeof(ni->name), hdev->name,
+			       strnlen(hdev->name, sizeof(ni->name)), '\0');
 
 		opcode = cpu_to_le16(HCI_MON_NEW_INDEX);
 		break;
diff --git a/net/core/dev.c b/net/core/dev.c
index 4d698ccf4172..8f4f355a963f 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -303,6 +303,12 @@ static struct netdev_name_node *netdev_name_node_lookup_rcu(struct net *net,
 	return NULL;
 }
 
+bool netdev_name_in_use(struct net *net, const char *name)
+{
+	return netdev_name_node_lookup(net, name);
+}
+EXPORT_SYMBOL(netdev_name_in_use);
+
 int netdev_name_node_alt_create(struct net_device *dev, const char *name)
 {
 	struct netdev_name_node *name_node;
@@ -1135,7 +1141,7 @@ static int __dev_alloc_name(struct net *net, const char *name, char *buf)
 	}
 
 	snprintf(buf, IFNAMSIZ, name, i);
-	if (!__dev_get_by_name(net, buf))
+	if (!netdev_name_in_use(net, buf))
 		return i;
 
 	/* It is possible to run out of possible slots
@@ -1145,6 +1151,26 @@ static int __dev_alloc_name(struct net *net, const char *name, char *buf)
 	return -ENFILE;
 }
 
+static int dev_prep_valid_name(struct net *net, struct net_device *dev,
+			       const char *want_name, char *out_name)
+{
+	int ret;
+
+	if (!dev_valid_name(want_name))
+		return -EINVAL;
+
+	if (strchr(want_name, '%')) {
+		ret = __dev_alloc_name(net, want_name, out_name);
+		return ret < 0 ? ret : 0;
+	} else if (netdev_name_in_use(net, want_name)) {
+		return -EEXIST;
+	} else if (out_name != want_name) {
+		strscpy(out_name, want_name, IFNAMSIZ);
+	}
+
+	return 0;
+}
+
 static int dev_alloc_name_ns(struct net *net,
 			     struct net_device *dev,
 			     const char *name)
@@ -1155,7 +1181,7 @@ static int dev_alloc_name_ns(struct net *net,
 	BUG_ON(!net);
 	ret = __dev_alloc_name(net, name, buf);
 	if (ret >= 0)
-		strlcpy(dev->name, buf, IFNAMSIZ);
+		strscpy(dev->name, buf, IFNAMSIZ);
 	return ret;
 }
 
@@ -1182,19 +1208,13 @@ EXPORT_SYMBOL(dev_alloc_name);
 static int dev_get_valid_name(struct net *net, struct net_device *dev,
 			      const char *name)
 {
-	BUG_ON(!net);
-
-	if (!dev_valid_name(name))
-		return -EINVAL;
-
-	if (strchr(name, '%'))
-		return dev_alloc_name_ns(net, dev, name);
-	else if (__dev_get_by_name(net, name))
-		return -EEXIST;
-	else if (dev->name != name)
-		strlcpy(dev->name, name, IFNAMSIZ);
+	char buf[IFNAMSIZ];
+	int ret;
 
-	return 0;
+	ret = dev_prep_valid_name(net, dev, name, buf);
+	if (ret >= 0)
+		strscpy(dev->name, buf, IFNAMSIZ);
+	return ret;
 }
 
 /**
@@ -11148,6 +11168,7 @@ int __dev_change_net_namespace(struct net_device *dev, struct net *net,
 			       const char *pat, int new_ifindex)
 {
 	struct net *net_old = dev_net(dev);
+	char new_name[IFNAMSIZ] = {};
 	int err, new_nsid;
 
 	ASSERT_RTNL();
@@ -11170,11 +11191,11 @@ int __dev_change_net_namespace(struct net_device *dev, struct net *net,
 	 * we can use it in the destination network namespace.
 	 */
 	err = -EEXIST;
-	if (__dev_get_by_name(net, dev->name)) {
+	if (netdev_name_in_use(net, dev->name)) {
 		/* We get here if we can't use the current device name */
 		if (!pat)
 			goto out;
-		err = dev_get_valid_name(net, dev, pat);
+		err = dev_prep_valid_name(net, dev, pat, new_name);
 		if (err < 0)
 			goto out;
 	}
@@ -11242,6 +11263,9 @@ int __dev_change_net_namespace(struct net_device *dev, struct net *net,
 	kobject_uevent(&dev->dev.kobj, KOBJ_ADD);
 	netdev_adjacent_add_links(dev);
 
+	if (new_name[0]) /* Rename the netdev to prepared name */
+		strscpy(dev->name, new_name, IFNAMSIZ);
+
 	/* Fixup kobjects */
 	err = device_rename(&dev->dev, dev->name);
 	WARN_ON(err);
@@ -11522,7 +11546,7 @@ static void __net_exit default_device_exit(struct net *net)
 
 		/* Push remaining network devices to init_net */
 		snprintf(fb_name, IFNAMSIZ, "dev%d", dev->ifindex);
-		if (__dev_get_by_name(&init_net, fb_name))
+		if (netdev_name_in_use(&init_net, fb_name))
 			snprintf(fb_name, IFNAMSIZ, "dev%%d");
 		err = dev_change_net_namespace(dev, &init_net, fb_name);
 		if (err) {
diff --git a/net/core/drop_monitor.c b/net/core/drop_monitor.c
index 78202141930f..22015ebc1dd5 100644
--- a/net/core/drop_monitor.c
+++ b/net/core/drop_monitor.c
@@ -473,7 +473,7 @@ net_dm_hw_trap_summary_probe(void *ignore, const struct devlink *devlink,
 		goto out;
 
 	hw_entry = &hw_entries->entries[hw_entries->num_entries];
-	strlcpy(hw_entry->trap_name, metadata->trap_name,
+	strscpy(hw_entry->trap_name, metadata->trap_name,
 		NET_DM_MAX_HW_TRAP_NAME_LEN - 1);
 	hw_entry->count = 1;
 	hw_entries->num_entries++;
diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index bd750863959f..47a86da6ab98 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -573,7 +573,7 @@ int netpoll_parse_options(struct netpoll *np, char *opt)
 		if ((delim = strchr(cur, ',')) == NULL)
 			goto parse_failed;
 		*delim = 0;
-		strlcpy(np->dev_name, cur, sizeof(np->dev_name));
+		strscpy(np->dev_name, cur, sizeof(np->dev_name));
 		cur = delim;
 	}
 	cur++;
@@ -627,7 +627,7 @@ int __netpoll_setup(struct netpoll *np, struct net_device *ndev)
 	int err;
 
 	np->dev = ndev;
-	strlcpy(np->dev_name, ndev->name, IFNAMSIZ);
+	strscpy(np->dev_name, ndev->name, IFNAMSIZ);
 
 	if (ndev->priv_flags & IFF_DISABLE_NETPOLL) {
 		np_err(np, "%s doesn't support polling, aborting\n",
diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index a3d74e2704c4..a539f26fe4be 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -668,19 +668,19 @@ static int pktgen_if_show(struct seq_file *seq, void *v)
 	seq_puts(seq, "     Flags: ");
 
 	for (i = 0; i < NR_PKT_FLAGS; i++) {
-		if (i == F_FLOW_SEQ)
+		if (i == FLOW_SEQ_SHIFT)
 			if (!pkt_dev->cflows)
 				continue;
 
-		if (pkt_dev->flags & (1 << i))
+		if (pkt_dev->flags & (1 << i)) {
 			seq_printf(seq, "%s  ", pkt_flag_names[i]);
-		else if (i == F_FLOW_SEQ)
-			seq_puts(seq, "FLOW_RND  ");
-
 #ifdef CONFIG_XFRM
-		if (i == F_IPSEC && pkt_dev->spi)
-			seq_printf(seq, "spi:%u", pkt_dev->spi);
+			if (i == IPSEC_SHIFT && pkt_dev->spi)
+				seq_printf(seq, "spi:%u  ", pkt_dev->spi);
 #endif
+		} else if (i == FLOW_SEQ_SHIFT) {
+			seq_puts(seq, "FLOW_RND  ");
+		}
 	}
 
 	seq_puts(seq, "\n");
diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index 386e9875e5b8..ca0cd94eb22d 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -739,7 +739,9 @@ static inline int esp_remove_trailer(struct sk_buff *skb)
 		skb->csum = csum_block_sub(skb->csum, csumdiff,
 					   skb->len - trimlen);
 	}
-	pskb_trim(skb, skb->len - trimlen);
+	ret = pskb_trim(skb, skb->len - trimlen);
+	if (unlikely(ret))
+		return ret;
 
 	ret = nexthdr[1];
 
diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index 799370bcc70c..735901b8c9f6 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -1344,15 +1344,18 @@ __be32 fib_info_update_nhc_saddr(struct net *net, struct fib_nh_common *nhc,
 				 unsigned char scope)
 {
 	struct fib_nh *nh;
+	__be32 saddr;
 
 	if (nhc->nhc_family != AF_INET)
 		return inet_select_addr(nhc->nhc_dev, 0, scope);
 
 	nh = container_of(nhc, struct fib_nh, nh_common);
-	nh->nh_saddr = inet_select_addr(nh->fib_nh_dev, nh->fib_nh_gw4, scope);
-	nh->nh_saddr_genid = atomic_read(&net->ipv4.dev_addr_genid);
+	saddr = inet_select_addr(nh->fib_nh_dev, nh->fib_nh_gw4, scope);
 
-	return nh->nh_saddr;
+	WRITE_ONCE(nh->nh_saddr, saddr);
+	WRITE_ONCE(nh->nh_saddr_genid, atomic_read(&net->ipv4.dev_addr_genid));
+
+	return saddr;
 }
 
 __be32 fib_result_prefsrc(struct net *net, struct fib_result *res)
@@ -1366,8 +1369,9 @@ __be32 fib_result_prefsrc(struct net *net, struct fib_result *res)
 		struct fib_nh *nh;
 
 		nh = container_of(nhc, struct fib_nh, nh_common);
-		if (nh->nh_saddr_genid == atomic_read(&net->ipv4.dev_addr_genid))
-			return nh->nh_saddr;
+		if (READ_ONCE(nh->nh_saddr_genid) ==
+		    atomic_read(&net->ipv4.dev_addr_genid))
+			return READ_ONCE(nh->nh_saddr);
 	}
 
 	return fib_info_update_nhc_saddr(net, nhc, res->fi->fib_scope);
@@ -1904,6 +1908,7 @@ int fib_sync_down_addr(struct net_device *dev, __be32 local)
 			continue;
 		if (fi->fib_prefsrc == local) {
 			fi->fib_flags |= RTNH_F_DEAD;
+			fi->pfsrc_removed = true;
 			ret++;
 		}
 	}
diff --git a/net/ipv4/fib_trie.c b/net/ipv4/fib_trie.c
index 22531aac0ccb..0b74debeecbb 100644
--- a/net/ipv4/fib_trie.c
+++ b/net/ipv4/fib_trie.c
@@ -2021,6 +2021,7 @@ void fib_table_flush_external(struct fib_table *tb)
 int fib_table_flush(struct net *net, struct fib_table *tb, bool flush_all)
 {
 	struct trie *t = (struct trie *)tb->tb_data;
+	struct nl_info info = { .nl_net = net };
 	struct key_vector *pn = t->kv;
 	unsigned long cindex = 1;
 	struct hlist_node *tmp;
@@ -2083,6 +2084,9 @@ int fib_table_flush(struct net *net, struct fib_table *tb, bool flush_all)
 
 			fib_notify_alias_delete(net, n->key, &n->leaf, fa,
 						NULL);
+			if (fi->pfsrc_removed)
+				rtmsg_fib(RTM_DELROUTE, htonl(n->key), fa,
+					  KEYLENGTH - fa->fa_slen, tb->tb_id, &info, 0);
 			hlist_del_rcu(&fa->fa_list);
 			fib_release_info(fa->fa_info);
 			alias_free_mem_rcu(fa);
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index b5cb674eca1c..f89cb184649e 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1863,6 +1863,7 @@ bool tcp_add_backlog(struct sock *sk, struct sk_buff *skb)
 #ifdef CONFIG_TLS_DEVICE
 	    tail->decrypted != skb->decrypted ||
 #endif
+	    !mptcp_skb_can_collapse(tail, skb) ||
 	    thtail->doff != th->doff ||
 	    memcmp(thtail + 1, th + 1, hdrlen - sizeof(*th)))
 		goto no_coalesce;
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 880b53bb6b64..9d5e652c9bba 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -2486,6 +2486,18 @@ static bool tcp_pacing_check(struct sock *sk)
 	return true;
 }
 
+static bool tcp_rtx_queue_empty_or_single_skb(const struct sock *sk)
+{
+	const struct rb_node *node = sk->tcp_rtx_queue.rb_node;
+
+	/* No skb in the rtx queue. */
+	if (!node)
+		return true;
+
+	/* Only one skb in rtx queue. */
+	return !node->rb_left && !node->rb_right;
+}
+
 /* TCP Small Queues :
  * Control number of packets in qdisc/devices to two packets / or ~1 ms.
  * (These limits are doubled for retransmits)
@@ -2523,12 +2535,12 @@ static bool tcp_small_queue_check(struct sock *sk, const struct sk_buff *skb,
 		limit += extra_bytes;
 	}
 	if (refcount_read(&sk->sk_wmem_alloc) > limit) {
-		/* Always send skb if rtx queue is empty.
+		/* Always send skb if rtx queue is empty or has one skb.
 		 * No need to wait for TX completion to call us back,
 		 * after softirq/tasklet schedule.
 		 * This helps when TX completions are delayed too much.
 		 */
-		if (tcp_rtx_queue_empty(sk))
+		if (tcp_rtx_queue_empty_or_single_skb(sk))
 			return false;
 
 		set_bit(TSQ_THROTTLED, &sk->sk_tsq_flags);
@@ -2731,7 +2743,7 @@ bool tcp_schedule_loss_probe(struct sock *sk, bool advancing_rto)
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
 	struct tcp_sock *tp = tcp_sk(sk);
-	u32 timeout, rto_delta_us;
+	u32 timeout, timeout_us, rto_delta_us;
 	int early_retrans;
 
 	/* Don't do any loss probe on a Fast Open connection before 3WHS
@@ -2755,11 +2767,12 @@ bool tcp_schedule_loss_probe(struct sock *sk, bool advancing_rto)
 	 * sample is available then probe after TCP_TIMEOUT_INIT.
 	 */
 	if (tp->srtt_us) {
-		timeout = usecs_to_jiffies(tp->srtt_us >> 2);
+		timeout_us = tp->srtt_us >> 2;
 		if (tp->packets_out == 1)
-			timeout += TCP_RTO_MIN;
+			timeout_us += tcp_rto_min_us(sk);
 		else
-			timeout += TCP_TIMEOUT_MIN;
+			timeout_us += TCP_TIMEOUT_MIN_US;
+		timeout = usecs_to_jiffies(timeout_us);
 	} else {
 		timeout = TCP_TIMEOUT_INIT;
 	}
diff --git a/net/ipv4/tcp_recovery.c b/net/ipv4/tcp_recovery.c
index ac14216f6204..24bc95463716 100644
--- a/net/ipv4/tcp_recovery.c
+++ b/net/ipv4/tcp_recovery.c
@@ -109,7 +109,7 @@ bool tcp_rack_mark_lost(struct sock *sk)
 	tp->rack.advanced = 0;
 	tcp_rack_detect_loss(sk, &timeout);
 	if (timeout) {
-		timeout = usecs_to_jiffies(timeout) + TCP_TIMEOUT_MIN;
+		timeout = usecs_to_jiffies(timeout + TCP_TIMEOUT_MIN_US);
 		inet_csk_reset_xmit_timer(sk, ICSK_TIME_REO_TIMEOUT,
 					  timeout, inet_csk(sk)->icsk_rto);
 	}
diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
index 6219d97cac7a..26d476494676 100644
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -776,7 +776,9 @@ static inline int esp_remove_trailer(struct sk_buff *skb)
 		skb->csum = csum_block_sub(skb->csum, csumdiff,
 					   skb->len - trimlen);
 	}
-	pskb_trim(skb, skb->len - trimlen);
+	ret = pskb_trim(skb, skb->len - trimlen);
+	if (unlikely(ret))
+		return ret;
 
 	ret = nexthdr[1];
 
diff --git a/net/ipv6/xfrm6_policy.c b/net/ipv6/xfrm6_policy.c
index 247296e3294b..4c3aa97f23fa 100644
--- a/net/ipv6/xfrm6_policy.c
+++ b/net/ipv6/xfrm6_policy.c
@@ -120,11 +120,11 @@ static void xfrm6_dst_destroy(struct dst_entry *dst)
 {
 	struct xfrm_dst *xdst = (struct xfrm_dst *)dst;
 
-	if (likely(xdst->u.rt6.rt6i_idev))
-		in6_dev_put(xdst->u.rt6.rt6i_idev);
 	dst_destroy_metrics_generic(dst);
 	if (xdst->u.rt6.rt6i_uncached_list)
 		rt6_uncached_list_del(&xdst->u.rt6);
+	if (likely(xdst->u.rt6.rt6i_idev))
+		in6_dev_put(xdst->u.rt6.rt6i_idev);
 	xfrm_dst_destroy(xdst);
 }
 
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 8f8dc2625d53..d5c89c6758f2 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -644,7 +644,8 @@ ieee80211_tx_h_select_key(struct ieee80211_tx_data *tx)
 		}
 
 		if (unlikely(tx->key && tx->key->flags & KEY_FLAG_TAINTED &&
-			     !ieee80211_is_deauth(hdr->frame_control)))
+			     !ieee80211_is_deauth(hdr->frame_control)) &&
+			     tx->skb->protocol != tx->sdata->control_port_protocol)
 			return TX_DROP;
 
 		if (!skip_hw && tx->key &&
diff --git a/net/mctp/route.c b/net/mctp/route.c
index 89e67399249b..5ef6b3b0a3d9 100644
--- a/net/mctp/route.c
+++ b/net/mctp/route.c
@@ -480,6 +480,10 @@ static int mctp_alloc_local_tag(struct mctp_sock *msk,
 	int rc = -EAGAIN;
 	u8 tagbits;
 
+	/* for NULL destination EIDs, we may get a response from any peer */
+	if (daddr == MCTP_ADDR_NULL)
+		daddr = MCTP_ADDR_ANY;
+
 	/* be optimistic, alloc now */
 	key = mctp_key_alloc(msk, saddr, daddr, 0, GFP_KERNEL);
 	if (!key)
@@ -545,6 +549,8 @@ struct mctp_route *mctp_route_lookup(struct net *net, unsigned int dnet,
 {
 	struct mctp_route *tmp, *rt = NULL;
 
+	rcu_read_lock();
+
 	list_for_each_entry_rcu(tmp, &net->mctp.routes, list) {
 		/* TODO: add metrics */
 		if (mctp_rt_match_eid(tmp, dnet, daddr)) {
@@ -555,6 +561,28 @@ struct mctp_route *mctp_route_lookup(struct net *net, unsigned int dnet,
 		}
 	}
 
+	rcu_read_unlock();
+
+	return rt;
+}
+
+static struct mctp_route *mctp_route_lookup_null(struct net *net,
+						 struct net_device *dev)
+{
+	struct mctp_route *tmp, *rt = NULL;
+
+	rcu_read_lock();
+
+	list_for_each_entry_rcu(tmp, &net->mctp.routes, list) {
+		if (tmp->dev->dev == dev && tmp->type == RTN_LOCAL &&
+		    refcount_inc_not_zero(&tmp->refs)) {
+			rt = tmp;
+			break;
+		}
+	}
+
+	rcu_read_unlock();
+
 	return rt;
 }
 
@@ -853,6 +881,11 @@ static int mctp_pkttype_receive(struct sk_buff *skb, struct net_device *dev,
 	rcu_read_unlock();
 
 	rt = mctp_route_lookup(net, cb->net, mh->dest);
+
+	/* NULL EID, but addressed to our physical address */
+	if (!rt && mh->dest == MCTP_ADDR_NULL && skb->pkt_type == PACKET_HOST)
+		rt = mctp_route_lookup_null(net, dev);
+
 	if (!rt)
 		goto err_drop;
 
diff --git a/net/netfilter/nft_payload.c b/net/netfilter/nft_payload.c
index 208a6f59281d..02327ffebc49 100644
--- a/net/netfilter/nft_payload.c
+++ b/net/netfilter/nft_payload.c
@@ -133,7 +133,7 @@ void nft_payload_eval(const struct nft_expr *expr,
 
 	switch (priv->base) {
 	case NFT_PAYLOAD_LL_HEADER:
-		if (!skb_mac_header_was_set(skb))
+		if (!skb_mac_header_was_set(skb) || skb_mac_header_len(skb) == 0)
 			goto err;
 
 		if (skb_vlan_tag_present(skb)) {
diff --git a/net/netfilter/nft_set_rbtree.c b/net/netfilter/nft_set_rbtree.c
index 2660ceab3759..e34662f4a71e 100644
--- a/net/netfilter/nft_set_rbtree.c
+++ b/net/netfilter/nft_set_rbtree.c
@@ -568,6 +568,8 @@ static void *nft_rbtree_deactivate(const struct net *net,
 				   nft_rbtree_interval_end(this)) {
 				parent = parent->rb_right;
 				continue;
+			} else if (nft_set_elem_expired(&rbe->ext)) {
+				break;
 			} else if (!nft_set_elem_active(&rbe->ext, genmask)) {
 				parent = parent->rb_left;
 				continue;
diff --git a/net/nfc/nci/spi.c b/net/nfc/nci/spi.c
index 0935527d1d12..b68150c971d0 100644
--- a/net/nfc/nci/spi.c
+++ b/net/nfc/nci/spi.c
@@ -151,6 +151,8 @@ static int send_acknowledge(struct nci_spi *nspi, u8 acknowledge)
 	int ret;
 
 	skb = nci_skb_alloc(nspi->ndev, 0, GFP_KERNEL);
+	if (!skb)
+		return -ENOMEM;
 
 	/* add the NCI SPI header to the start of the buffer */
 	hdr = skb_push(skb, NCI_SPI_HDR_LEN);
diff --git a/net/rfkill/rfkill-gpio.c b/net/rfkill/rfkill-gpio.c
index f5afc9bcdee6..2cc95c8dc4c7 100644
--- a/net/rfkill/rfkill-gpio.c
+++ b/net/rfkill/rfkill-gpio.c
@@ -98,13 +98,13 @@ static int rfkill_gpio_probe(struct platform_device *pdev)
 
 	rfkill->clk = devm_clk_get(&pdev->dev, NULL);
 
-	gpio = devm_gpiod_get_optional(&pdev->dev, "reset", GPIOD_OUT_LOW);
+	gpio = devm_gpiod_get_optional(&pdev->dev, "reset", GPIOD_ASIS);
 	if (IS_ERR(gpio))
 		return PTR_ERR(gpio);
 
 	rfkill->reset_gpio = gpio;
 
-	gpio = devm_gpiod_get_optional(&pdev->dev, "shutdown", GPIOD_OUT_LOW);
+	gpio = devm_gpiod_get_optional(&pdev->dev, "shutdown", GPIOD_ASIS);
 	if (IS_ERR(gpio))
 		return PTR_ERR(gpio);
 
diff --git a/net/sched/sch_hfsc.c b/net/sched/sch_hfsc.c
index 01126e285f94..1f0db6c85b09 100644
--- a/net/sched/sch_hfsc.c
+++ b/net/sched/sch_hfsc.c
@@ -903,6 +903,14 @@ hfsc_change_usc(struct hfsc_class *cl, struct tc_service_curve *usc,
 	cl->cl_flags |= HFSC_USC;
 }
 
+static void
+hfsc_upgrade_rt(struct hfsc_class *cl)
+{
+	cl->cl_fsc = cl->cl_rsc;
+	rtsc_init(&cl->cl_virtual, &cl->cl_fsc, cl->cl_vt, cl->cl_total);
+	cl->cl_flags |= HFSC_FSC;
+}
+
 static const struct nla_policy hfsc_policy[TCA_HFSC_MAX + 1] = {
 	[TCA_HFSC_RSC]	= { .len = sizeof(struct tc_service_curve) },
 	[TCA_HFSC_FSC]	= { .len = sizeof(struct tc_service_curve) },
@@ -1012,10 +1020,6 @@ hfsc_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
 		if (parent == NULL)
 			return -ENOENT;
 	}
-	if (!(parent->cl_flags & HFSC_FSC) && parent != &q->root) {
-		NL_SET_ERR_MSG(extack, "Invalid parent - parent class must have FSC");
-		return -EINVAL;
-	}
 
 	if (classid == 0 || TC_H_MAJ(classid ^ sch->handle) != 0)
 		return -EINVAL;
@@ -1068,6 +1072,12 @@ hfsc_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
 	cl->cf_tree = RB_ROOT;
 
 	sch_tree_lock(sch);
+	/* Check if the inner class is a misconfigured 'rt' */
+	if (!(parent->cl_flags & HFSC_FSC) && parent != &q->root) {
+		NL_SET_ERR_MSG(extack,
+			       "Forced curve change on parent 'rt' to 'sc'");
+		hfsc_upgrade_rt(parent);
+	}
 	qdisc_class_hash_insert(&q->clhash, &cl->cl_common);
 	list_add_tail(&cl->siblings, &parent->children);
 	if (parent->level == 0)
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index ed3ec7e320ce..82b93380afec 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -7664,7 +7664,7 @@ static int nl80211_update_mesh_config(struct sk_buff *skb,
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
 	struct net_device *dev = info->user_ptr[1];
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
-	struct mesh_config cfg;
+	struct mesh_config cfg = {};
 	u32 mask;
 	int err;
 
diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index c7192d7bcbd7..4decdc2c601f 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -874,6 +874,10 @@ static int cfg80211_scan_6ghz(struct cfg80211_registered_device *rdev)
 		    !cfg80211_find_ssid_match(ap, request))
 			continue;
 
+		if (!is_broadcast_ether_addr(request->bssid) &&
+		    !ether_addr_equal(request->bssid, ap->bssid))
+			continue;
+
 		if (!request->n_ssids && ap->multi_bss && !ap->transmitted_bssid)
 			continue;
 
diff --git a/net/xfrm/xfrm_interface_core.c b/net/xfrm/xfrm_interface_core.c
index ded752e33dac..9bd69887e16d 100644
--- a/net/xfrm/xfrm_interface_core.c
+++ b/net/xfrm/xfrm_interface_core.c
@@ -274,8 +274,8 @@ static int xfrmi_rcv_cb(struct sk_buff *skb, int err)
 	skb->dev = dev;
 
 	if (err) {
-		dev->stats.rx_errors++;
-		dev->stats.rx_dropped++;
+		DEV_STATS_INC(dev, rx_errors);
+		DEV_STATS_INC(dev, rx_dropped);
 
 		return 0;
 	}
@@ -309,7 +309,6 @@ static int
 xfrmi_xmit2(struct sk_buff *skb, struct net_device *dev, struct flowi *fl)
 {
 	struct xfrm_if *xi = netdev_priv(dev);
-	struct net_device_stats *stats = &xi->dev->stats;
 	struct dst_entry *dst = skb_dst(skb);
 	unsigned int length = skb->len;
 	struct net_device *tdev;
@@ -335,7 +334,7 @@ xfrmi_xmit2(struct sk_buff *skb, struct net_device *dev, struct flowi *fl)
 	tdev = dst->dev;
 
 	if (tdev == dev) {
-		stats->collisions++;
+		DEV_STATS_INC(dev, collisions);
 		net_warn_ratelimited("%s: Local routing loop detected!\n",
 				     dev->name);
 		goto tx_err_dst_release;
@@ -374,13 +373,13 @@ xfrmi_xmit2(struct sk_buff *skb, struct net_device *dev, struct flowi *fl)
 	if (net_xmit_eval(err) == 0) {
 		dev_sw_netstats_tx_add(dev, 1, length);
 	} else {
-		stats->tx_errors++;
-		stats->tx_aborted_errors++;
+		DEV_STATS_INC(dev, tx_errors);
+		DEV_STATS_INC(dev, tx_aborted_errors);
 	}
 
 	return 0;
 tx_err_link_failure:
-	stats->tx_carrier_errors++;
+	DEV_STATS_INC(dev, tx_carrier_errors);
 	dst_link_failure(skb);
 tx_err_dst_release:
 	dst_release(dst);
@@ -390,7 +389,6 @@ xfrmi_xmit2(struct sk_buff *skb, struct net_device *dev, struct flowi *fl)
 static netdev_tx_t xfrmi_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct xfrm_if *xi = netdev_priv(dev);
-	struct net_device_stats *stats = &xi->dev->stats;
 	struct dst_entry *dst = skb_dst(skb);
 	struct flowi fl;
 	int ret;
@@ -407,7 +405,7 @@ static netdev_tx_t xfrmi_xmit(struct sk_buff *skb, struct net_device *dev)
 			dst = ip6_route_output(dev_net(dev), NULL, &fl.u.ip6);
 			if (dst->error) {
 				dst_release(dst);
-				stats->tx_carrier_errors++;
+				DEV_STATS_INC(dev, tx_carrier_errors);
 				goto tx_err;
 			}
 			skb_dst_set(skb, dst);
@@ -423,7 +421,7 @@ static netdev_tx_t xfrmi_xmit(struct sk_buff *skb, struct net_device *dev)
 			fl.u.ip4.flowi4_flags |= FLOWI_FLAG_ANYSRC;
 			rt = __ip_route_output_key(dev_net(dev), &fl.u.ip4);
 			if (IS_ERR(rt)) {
-				stats->tx_carrier_errors++;
+				DEV_STATS_INC(dev, tx_carrier_errors);
 				goto tx_err;
 			}
 			skb_dst_set(skb, &rt->dst);
@@ -442,8 +440,8 @@ static netdev_tx_t xfrmi_xmit(struct sk_buff *skb, struct net_device *dev)
 	return NETDEV_TX_OK;
 
 tx_err:
-	stats->tx_errors++;
-	stats->tx_dropped++;
+	DEV_STATS_INC(dev, tx_errors);
+	DEV_STATS_INC(dev, tx_dropped);
 	kfree_skb(skb);
 	return NETDEV_TX_OK;
 }
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index b0a19cc92879..eebca0cbc61a 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -1371,8 +1371,6 @@ EXPORT_SYMBOL(xfrm_policy_hash_rebuild);
  * of an absolute inpredictability of ordering of rules. This will not pass. */
 static u32 xfrm_gen_index(struct net *net, int dir, u32 index)
 {
-	static u32 idx_generator;
-
 	for (;;) {
 		struct hlist_head *list;
 		struct xfrm_policy *p;
@@ -1380,8 +1378,8 @@ static u32 xfrm_gen_index(struct net *net, int dir, u32 index)
 		int found;
 
 		if (!index) {
-			idx = (idx_generator | dir);
-			idx_generator += 8;
+			idx = (net->xfrm.idx_generator | dir);
+			net->xfrm.idx_generator += 8;
 		} else {
 			idx = index;
 			index = 0;
diff --git a/sound/soc/codecs/wcd938x-sdw.c b/sound/soc/codecs/wcd938x-sdw.c
index 1fa05ec7459a..84a67bd98dc0 100644
--- a/sound/soc/codecs/wcd938x-sdw.c
+++ b/sound/soc/codecs/wcd938x-sdw.c
@@ -266,7 +266,31 @@ static int wcd9380_probe(struct sdw_slave *pdev,
 	pm_runtime_set_active(dev);
 	pm_runtime_enable(dev);
 
-	return component_add(dev, &wcd938x_sdw_component_ops);
+	ret = component_add(dev, &wcd938x_sdw_component_ops);
+	if (ret)
+		goto err_disable_rpm;
+
+	return 0;
+
+err_disable_rpm:
+	pm_runtime_disable(dev);
+	pm_runtime_set_suspended(dev);
+	pm_runtime_dont_use_autosuspend(dev);
+
+	return ret;
+}
+
+static int wcd9380_remove(struct sdw_slave *pdev)
+{
+	struct device *dev = &pdev->dev;
+
+	component_del(dev, &wcd938x_sdw_component_ops);
+
+	pm_runtime_disable(dev);
+	pm_runtime_set_suspended(dev);
+	pm_runtime_dont_use_autosuspend(dev);
+
+	return 0;
 }
 
 static const struct sdw_device_id wcd9380_slave_id[] = {
@@ -307,6 +331,7 @@ static const struct dev_pm_ops wcd938x_sdw_pm_ops = {
 
 static struct sdw_driver wcd9380_codec_driver = {
 	.probe	= wcd9380_probe,
+	.remove	= wcd9380_remove,
 	.ops = &wcd9380_slave_ops,
 	.id_table = wcd9380_slave_id,
 	.driver = {
diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
index 8a7c8e81cba5..1fa58e2bff3d 100644
--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -4424,10 +4424,6 @@ static int wcd938x_bind(struct device *dev)
 	wcd938x->sdw_priv[AIF1_CAP] = dev_get_drvdata(wcd938x->txdev);
 	wcd938x->sdw_priv[AIF1_CAP]->wcd938x = wcd938x;
 	wcd938x->tx_sdw_dev = dev_to_sdw_dev(wcd938x->txdev);
-	if (!wcd938x->tx_sdw_dev) {
-		dev_err(dev, "could not get txslave with matching of dev\n");
-		return -EINVAL;
-	}
 
 	/* As TX is main CSR reg interface, which should not be suspended first.
 	 * expicilty add the dependency link */
@@ -4484,10 +4480,10 @@ static void wcd938x_unbind(struct device *dev)
 {
 	struct wcd938x_priv *wcd938x = dev_get_drvdata(dev);
 
+	snd_soc_unregister_component(dev);
 	device_link_remove(dev, wcd938x->txdev);
 	device_link_remove(dev, wcd938x->rxdev);
 	device_link_remove(wcd938x->rxdev, wcd938x->txdev);
-	snd_soc_unregister_component(dev);
 	component_unbind_all(dev, wcd938x);
 }
 
diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index 7f13a35e9cc1..d6a2af293f45 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -779,7 +779,7 @@ static int pxa_ssp_probe(struct snd_soc_dai *dai)
 		if (IS_ERR(priv->extclk)) {
 			ret = PTR_ERR(priv->extclk);
 			if (ret == -EPROBE_DEFER)
-				return ret;
+				goto err_priv;
 
 			priv->extclk = NULL;
 		}
diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index f92880a15645..a7fb8d2b7709 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -251,6 +251,8 @@ enum {
 	PERF_BR_SYSRET		= 8,	/* syscall return */
 	PERF_BR_COND_CALL	= 9,	/* conditional function call */
 	PERF_BR_COND_RET	= 10,	/* conditional function return */
+	PERF_BR_ERET		= 11,	/* exception return */
+	PERF_BR_IRQ		= 12,	/* irq */
 	PERF_BR_MAX,
 };
 
diff --git a/tools/perf/util/branch.c b/tools/perf/util/branch.c
index 2285b1eb3128..a9a909db8cc7 100644
--- a/tools/perf/util/branch.c
+++ b/tools/perf/util/branch.c
@@ -49,7 +49,9 @@ const char *branch_type_name(int type)
 		"SYSCALL",
 		"SYSRET",
 		"COND_CALL",
-		"COND_RET"
+		"COND_RET",
+		"ERET",
+		"IRQ"
 	};
 
 	if (type >= 0 && type < PERF_BR_MAX)
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_non_uniq_symbol.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_non_uniq_symbol.tc
new file mode 100644
index 000000000000..bc9514428dba
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_non_uniq_symbol.tc
@@ -0,0 +1,13 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Test failure of registering kprobe on non unique symbol
+# requires: kprobe_events
+
+SYMBOL='name_show'
+
+# We skip this test on kernel where SYMBOL is unique or does not exist.
+if [ "$(grep -c -E "[[:alnum:]]+ t ${SYMBOL}" /proc/kallsyms)" -le '1' ]; then
+	exit_unsupported
+fi
+
+! echo "p:test_non_unique ${SYMBOL}" > kprobe_events
diff --git a/tools/testing/selftests/vm/charge_reserved_hugetlb.sh b/tools/testing/selftests/vm/charge_reserved_hugetlb.sh
index a5cb4b09a46c..0899019a7fcb 100644
--- a/tools/testing/selftests/vm/charge_reserved_hugetlb.sh
+++ b/tools/testing/selftests/vm/charge_reserved_hugetlb.sh
@@ -25,7 +25,7 @@ if [[ "$1" == "-cgroup-v2" ]]; then
 fi
 
 if [[ $cgroup2 ]]; then
-  cgroup_path=$(mount -t cgroup2 | head -1 | awk -e '{print $3}')
+  cgroup_path=$(mount -t cgroup2 | head -1 | awk '{print $3}')
   if [[ -z "$cgroup_path" ]]; then
     cgroup_path=/dev/cgroup/memory
     mount -t cgroup2 none $cgroup_path
@@ -33,7 +33,7 @@ if [[ $cgroup2 ]]; then
   fi
   echo "+hugetlb" >$cgroup_path/cgroup.subtree_control
 else
-  cgroup_path=$(mount -t cgroup | grep ",hugetlb" | awk -e '{print $3}')
+  cgroup_path=$(mount -t cgroup | grep ",hugetlb" | awk '{print $3}')
   if [[ -z "$cgroup_path" ]]; then
     cgroup_path=/dev/cgroup/memory
     mount -t cgroup memory,hugetlb $cgroup_path
diff --git a/tools/testing/selftests/vm/hugetlb_reparenting_test.sh b/tools/testing/selftests/vm/hugetlb_reparenting_test.sh
index bf2d2a684edf..14d26075c863 100644
--- a/tools/testing/selftests/vm/hugetlb_reparenting_test.sh
+++ b/tools/testing/selftests/vm/hugetlb_reparenting_test.sh
@@ -20,7 +20,7 @@ fi
 
 
 if [[ $cgroup2 ]]; then
-  CGROUP_ROOT=$(mount -t cgroup2 | head -1 | awk -e '{print $3}')
+  CGROUP_ROOT=$(mount -t cgroup2 | head -1 | awk '{print $3}')
   if [[ -z "$CGROUP_ROOT" ]]; then
     CGROUP_ROOT=/dev/cgroup/memory
     mount -t cgroup2 none $CGROUP_ROOT
@@ -28,7 +28,7 @@ if [[ $cgroup2 ]]; then
   fi
   echo "+hugetlb +memory" >$CGROUP_ROOT/cgroup.subtree_control
 else
-  CGROUP_ROOT=$(mount -t cgroup | grep ",hugetlb" | awk -e '{print $3}')
+  CGROUP_ROOT=$(mount -t cgroup | grep ",hugetlb" | awk '{print $3}')
   if [[ -z "$CGROUP_ROOT" ]]; then
     CGROUP_ROOT=/dev/cgroup/memory
     mount -t cgroup memory,hugetlb $CGROUP_ROOT
