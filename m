Return-Path: <linux-kernel+bounces-16113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C84823918
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 00:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF5531C24931
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 23:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7F520B27;
	Wed,  3 Jan 2024 23:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vj3Gb/AG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF6E20B16;
	Wed,  3 Jan 2024 23:16:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4A39C433C9;
	Wed,  3 Jan 2024 23:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704323789;
	bh=jjvAGLP6PqqccTuZF29DhBvYnfWz2MlfkrSWMP8kR3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vj3Gb/AGCNe/TM1EINPafFM59yaOj5OJZQduZK6H29qEf+ER7c8LwiS/ZMpF22N6c
	 ibvCw+7zNaA05/qZDCrzHKiQtumRVENZHz1ZXbQyEpnN5zMPshperOatyNx1nvK2Ro
	 d/vV5ZlfbOXr0HtpZDTXkryaQAIeh6aUZx1PSmX/aQ6wQcBBYbBAr0yWqmtJraSJzc
	 Qk+rrvGQIQU3mt9fWvIL5xund3eF/6xUlO47pVxoVCI7kOiXhdZAZzSRPwjvzEaM8B
	 rjLrEZmKy9+791t9ZXg9DUoZ5wFnEIjOiKytapRuhIyRkFs9Vz/sz1OkEZenLgpUr4
	 dOq0xMpDQY5eQ==
From: Bjorn Helgaas <helgaas@kernel.org>
To: "David S . Miller" <davem@davemloft.net>
Cc: Randy Dunlap <rdunlap@infradead.org>,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	sparclinux@vger.kernel.org
Subject: [PATCH 8/8] sparc: Fix typos
Date: Wed,  3 Jan 2024 17:16:05 -0600
Message-Id: <20240103231605.1801364-9-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240103231605.1801364-1-helgaas@kernel.org>
References: <20240103231605.1801364-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

Fix typos, most reported by "codespell arch/sparc".  Only touches
comments, no code changes.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: sparclinux@vger.kernel.org
---
 arch/sparc/include/asm/hypervisor.h     | 6 +++---
 arch/sparc/include/asm/ldc.h            | 2 +-
 arch/sparc/include/asm/mmu_context_64.h | 4 ++--
 arch/sparc/include/asm/switch_to_64.h   | 2 +-
 arch/sparc/kernel/irq_64.c              | 2 +-
 arch/sparc/kernel/kprobes.c             | 2 +-
 arch/sparc/kernel/ldc.c                 | 2 +-
 arch/sparc/kernel/leon_pci_grpci2.c     | 2 +-
 arch/sparc/kernel/of_device_64.c        | 2 +-
 arch/sparc/kernel/pci.c                 | 2 +-
 arch/sparc/kernel/pci_impl.h            | 4 ++--
 arch/sparc/kernel/pci_schizo.c          | 4 ++--
 arch/sparc/kernel/perf_event.c          | 2 +-
 arch/sparc/kernel/prom_irqtrans.c       | 2 +-
 arch/sparc/kernel/psycho_common.c       | 2 +-
 arch/sparc/kernel/signal_32.c           | 2 +-
 arch/sparc/kernel/signal_64.c           | 2 +-
 arch/sparc/mm/srmmu.c                   | 2 +-
 arch/sparc/mm/tsb.c                     | 2 +-
 arch/sparc/net/bpf_jit_comp_32.c        | 6 +++---
 20 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/arch/sparc/include/asm/hypervisor.h b/arch/sparc/include/asm/hypervisor.h
index 08650d503cc2..f220edcf17c7 100644
--- a/arch/sparc/include/asm/hypervisor.h
+++ b/arch/sparc/include/asm/hypervisor.h
@@ -430,7 +430,7 @@ unsigned long sun4v_cpu_mondo_send(unsigned long cpu_count,
  * ERRORS:	No errors defined.
  *
  * Return the hypervisor ID handle for the current CPU.  Use by a
- * virtual CPU to discover it's own identity.
+ * virtual CPU to discover its own identity.
  */
 #define HV_FAST_CPU_MYID		0x16
 
@@ -1221,7 +1221,7 @@ unsigned long sun4v_con_write(unsigned long buffer,
  *		EBADALIGNED	software state description is not correctly
  *				aligned
  *
- * This allows the guest to report it's soft state to the hypervisor.  There
+ * This allows the guest to report its soft state to the hypervisor.  There
  * are two primary components to this state.  The first part states whether
  * the guest software is running or not.  The second containts optional
  * details specific to the software.
@@ -1502,7 +1502,7 @@ struct hv_trap_trace_entry {
  * configuration error of some sort.
  *
  * The dump services provide an opaque buffer into which the
- * hypervisor can place it's internal state in order to assist in
+ * hypervisor can place its internal state in order to assist in
  * debugging such situations.  The contents are opaque and extremely
  * platform and hypervisor implementation specific.  The guest, during
  * a core dump, requests that the hypervisor update any information in
diff --git a/arch/sparc/include/asm/ldc.h b/arch/sparc/include/asm/ldc.h
index ca973955ca86..4294738d40be 100644
--- a/arch/sparc/include/asm/ldc.h
+++ b/arch/sparc/include/asm/ldc.h
@@ -13,7 +13,7 @@ void ldom_power_off(void);
  * or data becomes available on the receive side.
  *
  * For non-RAW links, if the LDC_EVENT_RESET event arrives the
- * driver should reset all of it's internal state and reinvoke
+ * driver should reset all of its internal state and reinvoke
  * ldc_connect() to try and bring the link up again.
  *
  * For RAW links, ldc_connect() is not used.  Instead the driver
diff --git a/arch/sparc/include/asm/mmu_context_64.h b/arch/sparc/include/asm/mmu_context_64.h
index 799e797c5cdd..08160bf9a0f4 100644
--- a/arch/sparc/include/asm/mmu_context_64.h
+++ b/arch/sparc/include/asm/mmu_context_64.h
@@ -93,7 +93,7 @@ static inline void switch_mm(struct mm_struct *old_mm, struct mm_struct *mm, str
 
 	/* We have to be extremely careful here or else we will miss
 	 * a TSB grow if we switch back and forth between a kernel
-	 * thread and an address space which has it's TSB size increased
+	 * thread and an address space which has its TSB size increased
 	 * on another processor.
 	 *
 	 * It is possible to play some games in order to optimize the
@@ -118,7 +118,7 @@ static inline void switch_mm(struct mm_struct *old_mm, struct mm_struct *mm, str
 	 *
 	 * At that point cpu0 continues to use a stale TSB, the one from
 	 * before the TSB grow performed on cpu1.  cpu1 did not cross-call
-	 * cpu0 to update it's TSB because at that point the cpu_vm_mask
+	 * cpu0 to update its TSB because at that point the cpu_vm_mask
 	 * only had cpu1 set in it.
 	 */
 	tsb_context_switch_ctx(mm, CTX_HWBITS(mm->context));
diff --git a/arch/sparc/include/asm/switch_to_64.h b/arch/sparc/include/asm/switch_to_64.h
index 14f3c49bfdbc..d93963ff7caa 100644
--- a/arch/sparc/include/asm/switch_to_64.h
+++ b/arch/sparc/include/asm/switch_to_64.h
@@ -15,7 +15,7 @@ do {						\
 	 * for l0/l1.  It will use one for 'next' and the other to hold
 	 * the output value of 'last'.  'next' is not referenced again
 	 * past the invocation of switch_to in the scheduler, so we need
-	 * not preserve it's value.  Hairy, but it lets us remove 2 loads
+	 * not preserve its value.  Hairy, but it lets us remove 2 loads
 	 * and 2 stores in this critical code path.  -DaveM
 	 */
 #define switch_to(prev, next, last)					\
diff --git a/arch/sparc/kernel/irq_64.c b/arch/sparc/kernel/irq_64.c
index 72da2e10e255..5280e325d4d6 100644
--- a/arch/sparc/kernel/irq_64.c
+++ b/arch/sparc/kernel/irq_64.c
@@ -980,7 +980,7 @@ void notrace init_irqwork_curcpu(void)
  *
  * On SMP this gets invoked from the CPU trampoline before
  * the cpu has fully taken over the trap table from OBP,
- * and it's kernel stack + %g6 thread register state is
+ * and its kernel stack + %g6 thread register state is
  * not fully cooked yet.
  *
  * Therefore you cannot make any OBP calls, not even prom_printf,
diff --git a/arch/sparc/kernel/kprobes.c b/arch/sparc/kernel/kprobes.c
index 535c7b35cb59..191bbaca9921 100644
--- a/arch/sparc/kernel/kprobes.c
+++ b/arch/sparc/kernel/kprobes.c
@@ -230,7 +230,7 @@ static unsigned long __kprobes relbranch_fixup(u32 insn, struct kprobe *p,
 	return regs->tnpc;
 }
 
-/* If INSN is an instruction which writes it's PC location
+/* If INSN is an instruction which writes its PC location
  * into a destination register, fix that up.
  */
 static void __kprobes retpc_fixup(struct pt_regs *regs, u32 insn,
diff --git a/arch/sparc/kernel/ldc.c b/arch/sparc/kernel/ldc.c
index c0fa3ef6cf01..7f3cdb6f644d 100644
--- a/arch/sparc/kernel/ldc.c
+++ b/arch/sparc/kernel/ldc.c
@@ -1854,7 +1854,7 @@ static int read_nonraw(struct ldc_channel *lp, void *buf, unsigned int size)
 			 * This seems the best behavior because this allows
 			 * a user of the LDC layer to start with a small
 			 * RX buffer for ldc_read() calls and use -EMSGSIZE
-			 * as a cue to enlarge it's read buffer.
+			 * as a cue to enlarge its read buffer.
 			 */
 			err = -EMSGSIZE;
 			break;
diff --git a/arch/sparc/kernel/leon_pci_grpci2.c b/arch/sparc/kernel/leon_pci_grpci2.c
index 60b6bdf7761f..282b49d496ea 100644
--- a/arch/sparc/kernel/leon_pci_grpci2.c
+++ b/arch/sparc/kernel/leon_pci_grpci2.c
@@ -586,7 +586,7 @@ static void grpci2_hw_init(struct grpci2_priv *priv)
 	REGSTORE(regs->io_map, REGLOAD(regs->io_map) & 0x0000ffff);
 
 	/* set 1:1 mapping between AHB -> PCI memory space, for all Masters
-	 * Each AHB master has it's own mapping registers. Max 16 AHB masters.
+	 * Each AHB master has its own mapping registers. Max 16 AHB masters.
 	 */
 	for (i = 0; i < 16; i++)
 		REGSTORE(regs->ahbmst_map[i], priv->pci_area);
diff --git a/arch/sparc/kernel/of_device_64.c b/arch/sparc/kernel/of_device_64.c
index d3842821a5a0..c350c58c7f69 100644
--- a/arch/sparc/kernel/of_device_64.c
+++ b/arch/sparc/kernel/of_device_64.c
@@ -560,7 +560,7 @@ static unsigned int __init build_one_device_irq(struct platform_device *op,
 	 *
 	 * If we hit a bus type or situation we cannot handle, we
 	 * stop and assume that the original IRQ number was in a
-	 * format which has special meaning to it's immediate parent.
+	 * format which has special meaning to its immediate parent.
 	 */
 	pp = dp->parent;
 	ip = NULL;
diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index f66005ce4cb5..50a0927a84a6 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -311,7 +311,7 @@ static struct pci_dev *of_create_pci_dev(struct pci_pbm_info *pbm,
 	/* We can't actually use the firmware value, we have
 	 * to read what is in the register right now.  One
 	 * reason is that in the case of IDE interfaces the
-	 * firmware can sample the value before the the IDE
+	 * firmware can sample the value before the IDE
 	 * interface is programmed into native mode.
 	 */
 	pci_read_config_dword(dev, PCI_CLASS_REVISION, &class);
diff --git a/arch/sparc/kernel/pci_impl.h b/arch/sparc/kernel/pci_impl.h
index f31761f51757..83718876f1d4 100644
--- a/arch/sparc/kernel/pci_impl.h
+++ b/arch/sparc/kernel/pci_impl.h
@@ -19,9 +19,9 @@
  * each with one (Sabre) or two (PSYCHO/SCHIZO) PCI bus modules
  * underneath.  Each PCI bus module uses an IOMMU (shared by both
  * PBMs of a controller, or per-PBM), and if a streaming buffer
- * is present, each PCI bus module has it's own. (ie. the IOMMU
+ * is present, each PCI bus module has its own. (ie. the IOMMU
  * might be shared between PBMs, the STC is never shared)
- * Furthermore, each PCI bus module controls it's own autonomous
+ * Furthermore, each PCI bus module controls its own autonomous
  * PCI bus.
  */
 
diff --git a/arch/sparc/kernel/pci_schizo.c b/arch/sparc/kernel/pci_schizo.c
index 23b47f7fdb1d..4104007a0256 100644
--- a/arch/sparc/kernel/pci_schizo.c
+++ b/arch/sparc/kernel/pci_schizo.c
@@ -142,7 +142,7 @@ static void __schizo_check_stc_error_pbm(struct pci_pbm_info *pbm,
 
 	/* This is __REALLY__ dangerous.  When we put the
 	 * streaming buffer into diagnostic mode to probe
-	 * it's tags and error status, we _must_ clear all
+	 * its tags and error status, we _must_ clear all
 	 * of the line tag valid bits before re-enabling
 	 * the streaming buffer.  If any dirty data lives
 	 * in the STC when we do this, we will end up
@@ -272,7 +272,7 @@ static void schizo_check_iommu_error_pbm(struct pci_pbm_info *pbm,
 		       pbm->name, type_string);
 
 		/* Put the IOMMU into diagnostic mode and probe
-		 * it's TLB for entries with error status.
+		 * its TLB for entries with error status.
 		 *
 		 * It is very possible for another DVMA to occur
 		 * while we do this probe, and corrupt the system
diff --git a/arch/sparc/kernel/perf_event.c b/arch/sparc/kernel/perf_event.c
index a58ae9c42803..f02a283a8e8f 100644
--- a/arch/sparc/kernel/perf_event.c
+++ b/arch/sparc/kernel/perf_event.c
@@ -979,7 +979,7 @@ static void calculate_single_pcr(struct cpu_hw_events *cpuc)
 
 static void sparc_pmu_start(struct perf_event *event, int flags);
 
-/* On this PMU each PIC has it's own PCR control register.  */
+/* On this PMU each PIC has its own PCR control register.  */
 static void calculate_multiple_pcrs(struct cpu_hw_events *cpuc)
 {
 	int i;
diff --git a/arch/sparc/kernel/prom_irqtrans.c b/arch/sparc/kernel/prom_irqtrans.c
index 426bd08cb2ab..5752bfd73ac0 100644
--- a/arch/sparc/kernel/prom_irqtrans.c
+++ b/arch/sparc/kernel/prom_irqtrans.c
@@ -394,7 +394,7 @@ static unsigned int schizo_irq_build(struct device_node *dp,
 	iclr = schizo_ino_to_iclr(pbm_regs, ino);
 
 	/* On Schizo, no inofixup occurs.  This is because each
-	 * INO has it's own IMAP register.  On Psycho and Sabre
+	 * INO has its own IMAP register.  On Psycho and Sabre
 	 * there is only one IMAP register for each PCI slot even
 	 * though four different INOs can be generated by each
 	 * PCI slot.
diff --git a/arch/sparc/kernel/psycho_common.c b/arch/sparc/kernel/psycho_common.c
index 5ee74b4c0cf4..4557ef18f371 100644
--- a/arch/sparc/kernel/psycho_common.c
+++ b/arch/sparc/kernel/psycho_common.c
@@ -50,7 +50,7 @@ static void psycho_check_stc_error(struct pci_pbm_info *pbm)
 	spin_lock(&stc_buf_lock);
 
 	/* This is __REALLY__ dangerous.  When we put the streaming
-	 * buffer into diagnostic mode to probe it's tags and error
+	 * buffer into diagnostic mode to probe its tags and error
 	 * status, we _must_ clear all of the line tag valid bits
 	 * before re-enabling the streaming buffer.  If any dirty data
 	 * lives in the STC when we do this, we will end up
diff --git a/arch/sparc/kernel/signal_32.c b/arch/sparc/kernel/signal_32.c
index 89b93c7136e7..478014d2e59b 100644
--- a/arch/sparc/kernel/signal_32.c
+++ b/arch/sparc/kernel/signal_32.c
@@ -473,7 +473,7 @@ static void do_signal(struct pt_regs *regs, unsigned long orig_i0)
 	 *
 	 * %g7 is used as the "thread register".   %g6 is not used in
 	 * any fixed manner.  %g6 is used as a scratch register and
-	 * a compiler temporary, but it's value is never used across
+	 * a compiler temporary, but its value is never used across
 	 * a system call.  Therefore %g6 is usable for orig_i0 storage.
 	 */
 	if (pt_regs_is_syscall(regs) && (regs->psr & PSR_C))
diff --git a/arch/sparc/kernel/signal_64.c b/arch/sparc/kernel/signal_64.c
index b4e410976e0d..2d64566a1f88 100644
--- a/arch/sparc/kernel/signal_64.c
+++ b/arch/sparc/kernel/signal_64.c
@@ -494,7 +494,7 @@ static void do_signal(struct pt_regs *regs, unsigned long orig_i0)
 	 *
 	 * %g7 is used as the "thread register".   %g6 is not used in
 	 * any fixed manner.  %g6 is used as a scratch register and
-	 * a compiler temporary, but it's value is never used across
+	 * a compiler temporary, but its value is never used across
 	 * a system call.  Therefore %g6 is usable for orig_i0 storage.
 	 */
 	if (pt_regs_is_syscall(regs) &&
diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index 8393faa3e596..852085ada368 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -1513,7 +1513,7 @@ static void __init init_viking(void)
 
 		/*
 		 * We need this to make sure old viking takes no hits
-		 * on it's cache for dma snoops to workaround the
+		 * on its cache for dma snoops to workaround the
 		 * "load from non-cacheable memory" interrupt bug.
 		 * This is only necessary because of the new way in
 		 * which we use the IOMMU.
diff --git a/arch/sparc/mm/tsb.c b/arch/sparc/mm/tsb.c
index 5e2931a18409..5351d4128e74 100644
--- a/arch/sparc/mm/tsb.c
+++ b/arch/sparc/mm/tsb.c
@@ -385,7 +385,7 @@ static unsigned long tsb_size_to_rss_limit(unsigned long new_size)
  * will not trigger any longer.
  *
  * The TSB can be anywhere from 8K to 1MB in size, in increasing powers
- * of two.  The TSB must be aligned to it's size, so f.e. a 512K TSB
+ * of two.  The TSB must be aligned to its size, so f.e. a 512K TSB
  * must be 512K aligned.  It also must be physically contiguous, so we
  * cannot use vmalloc().
  *
diff --git a/arch/sparc/net/bpf_jit_comp_32.c b/arch/sparc/net/bpf_jit_comp_32.c
index a74e5004c6c8..da2df1e84ed4 100644
--- a/arch/sparc/net/bpf_jit_comp_32.c
+++ b/arch/sparc/net/bpf_jit_comp_32.c
@@ -300,7 +300,7 @@ do {	*prog++ = BR_OPC | WDISP22(OFF);		\
  *
  * The most common case is to emit a branch at the end of such
  * a code sequence.  So this would be two instructions, the
- * branch and it's delay slot.
+ * branch and its delay slot.
  *
  * Therefore by default the branch emitters calculate the branch
  * offset field as:
@@ -309,13 +309,13 @@ do {	*prog++ = BR_OPC | WDISP22(OFF);		\
  *
  * This "addrs[i] - 8" is the address of the branch itself or
  * what "." would be in assembler notation.  The "8" part is
- * how we take into consideration the branch and it's delay
+ * how we take into consideration the branch and its delay
  * slot mentioned above.
  *
  * Sometimes we need to emit a branch earlier in the code
  * sequence.  And in these situations we adjust "destination"
  * to accommodate this difference.  For example, if we needed
- * to emit a branch (and it's delay slot) right before the
+ * to emit a branch (and its delay slot) right before the
  * final instruction emitted for a BPF opcode, we'd use
  * "destination + 4" instead of just plain "destination" above.
  *
-- 
2.34.1


