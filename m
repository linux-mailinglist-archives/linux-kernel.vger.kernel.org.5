Return-Path: <linux-kernel+bounces-16106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F1782390B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 00:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DBA71C24873
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 23:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FEEA1F61F;
	Wed,  3 Jan 2024 23:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u1Diy9Lf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FFE1F5F6;
	Wed,  3 Jan 2024 23:16:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0818EC433CA;
	Wed,  3 Jan 2024 23:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704323776;
	bh=orZ1bseJA+BJdq6+JvZpsefRknCFOn3ppL34G3tw8jA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u1Diy9Lf25juTZCr+AFzbSHEYW/FqtNpJPNp3g0d5XyCN4DuY3vrlgW4iUGgQhGS2
	 BW1uKiEjsIEZdMW4MsQysjcjOU/CSm7KgTB3ZimIKo//CBscUPSdeOrnDpv94ea1J3
	 YYj9GqdrKGQWbcvCnxPFHzH1yB3FBzZXzRPo6W+jnVNd8exmYOyeZuoNkUe1o0Z/jH
	 79WD4z5JWDfBpDLuQz29y1ZCIWujc10aenjfvQu+dd7YBOcXJq8TYr31uszB/de7z0
	 wswD4tdyd3BVpK7Di6egoqqABkxTtbyn1lBTn0Rxps4mTQs+1wIkfMwQBwC3WuX52c
	 F87p0g9CrhfCg==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Randy Dunlap <rdunlap@infradead.org>,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>,
	linux-alpha@vger.kernel.org
Subject: [PATCH 1/8] alpha: Fix typos
Date: Wed,  3 Jan 2024 17:15:58 -0600
Message-Id: <20240103231605.1801364-2-helgaas@kernel.org>
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

Fix typos, most reported by "codespell arch/alpha".  Only touches comments,
no code changes.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: linux-alpha@vger.kernel.org
---
 arch/alpha/boot/bootpz.c             | 4 ++--
 arch/alpha/include/asm/core_marvel.h | 2 +-
 arch/alpha/include/asm/fpu.h         | 2 +-
 arch/alpha/include/asm/sfp-machine.h | 2 +-
 arch/alpha/include/asm/thread_info.h | 2 +-
 arch/alpha/include/asm/wrperfmon.h   | 2 +-
 arch/alpha/include/uapi/asm/mman.h   | 2 +-
 arch/alpha/kernel/err_impl.h         | 2 +-
 arch/alpha/kernel/irq_i8259.c        | 2 +-
 arch/alpha/kernel/osf_sys.c          | 2 +-
 arch/alpha/kernel/pci_iommu.c        | 4 ++--
 arch/alpha/kernel/sys_eiger.c        | 4 ++--
 arch/alpha/kernel/sys_marvel.c       | 2 +-
 arch/alpha/kernel/sys_miata.c        | 2 +-
 arch/alpha/kernel/sys_takara.c       | 2 +-
 arch/alpha/lib/ev6-memcpy.S          | 2 +-
 arch/alpha/lib/ev6-stxcpy.S          | 2 +-
 arch/alpha/lib/ev67-strrchr.S        | 2 +-
 arch/alpha/lib/strrchr.S             | 2 +-
 arch/alpha/lib/stxcpy.S              | 2 +-
 20 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/arch/alpha/boot/bootpz.c b/arch/alpha/boot/bootpz.c
index c6079308eab3..64680c10db79 100644
--- a/arch/alpha/boot/bootpz.c
+++ b/arch/alpha/boot/bootpz.c
@@ -326,7 +326,7 @@ start_kernel(void)
 	 * 0x20000000, we have to ensure that the physical memory
 	 * pages occupied by that image do NOT overlap the physical
 	 * address range where the kernel wants to be run.  This
-	 * causes real problems when attempting to cdecompress the
+	 * causes real problems when attempting to decompress the
 	 * former into the latter... :-(
 	 *
 	 * So, we may have to decompress/move the kernel/INITRD image
@@ -456,7 +456,7 @@ start_kernel(void)
 #ifdef DEBUG_LAST_STEPS
 	srm_printk("Preparing INITRD info...\n");
 #endif
-	/* Finally, set the INITRD paramenters for the kernel. */
+	/* Finally, set the INITRD parameters for the kernel. */
 	((long *)(ZERO_PGE+256))[0] = initrd_image_start;
 	((long *)(ZERO_PGE+256))[1] = INITRD_IMAGE_SIZE;
 
diff --git a/arch/alpha/include/asm/core_marvel.h b/arch/alpha/include/asm/core_marvel.h
index d99f3a82e0e5..cf02c8f5c056 100644
--- a/arch/alpha/include/asm/core_marvel.h
+++ b/arch/alpha/include/asm/core_marvel.h
@@ -279,7 +279,7 @@ union IO7_IID {
 #define IO7_DAC_OFFSET		(1UL << 49)
 
 /*
- * This is needed to satisify the IO() macro used in initializing the machvec
+ * This is needed to satisfy the IO() macro used in initializing the machvec
  */
 #define MARVEL_IACK_SC 							\
         ((unsigned long)						\
diff --git a/arch/alpha/include/asm/fpu.h b/arch/alpha/include/asm/fpu.h
index 30b24135dd7a..6c1823c21782 100644
--- a/arch/alpha/include/asm/fpu.h
+++ b/arch/alpha/include/asm/fpu.h
@@ -73,7 +73,7 @@ static inline unsigned long
 swcr_update_status(unsigned long swcr, unsigned long fpcr)
 {
 	/* EV6 implements most of the bits in hardware.  Collect
-	   the acrued exception bits from the real fpcr.  */
+	   the accrued exception bits from the real fpcr.  */
 	if (implver() == IMPLVER_EV6) {
 		swcr &= ~IEEE_STATUS_MASK;
 		swcr |= (fpcr >> 35) & IEEE_STATUS_MASK;
diff --git a/arch/alpha/include/asm/sfp-machine.h b/arch/alpha/include/asm/sfp-machine.h
index 5fe63afbd474..598e5067c5d0 100644
--- a/arch/alpha/include/asm/sfp-machine.h
+++ b/arch/alpha/include/asm/sfp-machine.h
@@ -49,7 +49,7 @@
 
 #define _FP_KEEPNANFRACP 1
 
-/* Alpha Architecture Handbook, 4.7.10.4 sais that
+/* Alpha Architecture Handbook, 4.7.10.4 says that
  * we should prefer any type of NaN in Fb, then Fa.
  */
 #define _FP_CHOOSENAN(fs, wc, R, X, Y, OP)			\
diff --git a/arch/alpha/include/asm/thread_info.h b/arch/alpha/include/asm/thread_info.h
index 4a4d00b37986..4f237e560a64 100644
--- a/arch/alpha/include/asm/thread_info.h
+++ b/arch/alpha/include/asm/thread_info.h
@@ -20,7 +20,7 @@ struct thread_info {
 	unsigned int		ieee_state;	/* see fpu.h */
 
 	unsigned		cpu;		/* current CPU */
-	int			preempt_count; /* 0 => preemptable, <0 => BUG */
+	int			preempt_count; /* 0 => preemptible, <0 => BUG */
 	unsigned int		status;		/* thread-synchronous flags */
 
 	int bpt_nsaved;
diff --git a/arch/alpha/include/asm/wrperfmon.h b/arch/alpha/include/asm/wrperfmon.h
index c97b82a1f7db..b11f09cb7fe6 100644
--- a/arch/alpha/include/asm/wrperfmon.h
+++ b/arch/alpha/include/asm/wrperfmon.h
@@ -59,7 +59,7 @@
 
 
 /*
- * The Alpha Architecure Handbook, vers. 4 (1998) appears to have a misprint
+ * The Alpha Architecture Handbook, vers. 4 (1998) appears to have a misprint
  *  in Table E-23 regarding the bits that set the event PCTR 1 counts.
  *  Hopefully what we have here is correct.
  */
diff --git a/arch/alpha/include/uapi/asm/mman.h b/arch/alpha/include/uapi/asm/mman.h
index 763929e814e9..095eba603593 100644
--- a/arch/alpha/include/uapi/asm/mman.h
+++ b/arch/alpha/include/uapi/asm/mman.h
@@ -61,7 +61,7 @@
 #define MADV_HUGEPAGE	14		/* Worth backing with hugepages */
 #define MADV_NOHUGEPAGE	15		/* Not worth backing with hugepages */
 
-#define MADV_DONTDUMP   16		/* Explicity exclude from the core dump,
+#define MADV_DONTDUMP   16		/* Explicitly exclude from core dump,
 					   overrides the coredump filter bits */
 #define MADV_DODUMP	17		/* Clear the MADV_NODUMP flag */
 
diff --git a/arch/alpha/kernel/err_impl.h b/arch/alpha/kernel/err_impl.h
index 737b958a586d..e368f0f62866 100644
--- a/arch/alpha/kernel/err_impl.h
+++ b/arch/alpha/kernel/err_impl.h
@@ -32,7 +32,7 @@ struct el_subpacket_handler {
 #define SUBPACKET_HANDLER_INIT(c, h) {NULL, (c), (h)}
 
 /*
- * Manipulate a field from a register given it's name. defines
+ * Manipulate a field from a register given its name. defines
  * for the LSB (__S - shift count) and bitmask (__M) are required
  *
  * EXTRACT(u, f) - extracts the field and places it at bit position 0
diff --git a/arch/alpha/kernel/irq_i8259.c b/arch/alpha/kernel/irq_i8259.c
index 1dcf0d9038fd..657d776f15f7 100644
--- a/arch/alpha/kernel/irq_i8259.c
+++ b/arch/alpha/kernel/irq_i8259.c
@@ -147,7 +147,7 @@ isa_no_iack_sc_device_interrupt(unsigned long vector)
 	 */
 	/* 
 	 *  The first read of gives you *all* interrupting lines.
-	 *  Therefore, read the mask register and and out those lines
+	 *  Therefore, read the mask register and AND out those lines
 	 *  not enabled.  Note that some documentation has 21 and a1 
 	 *  write only.  This is not true.
 	 */
diff --git a/arch/alpha/kernel/osf_sys.c b/arch/alpha/kernel/osf_sys.c
index 5db88b627439..60273892fabb 100644
--- a/arch/alpha/kernel/osf_sys.c
+++ b/arch/alpha/kernel/osf_sys.c
@@ -826,7 +826,7 @@ SYSCALL_DEFINE5(osf_setsysinfo, unsigned long, op, void __user *, buffer,
 
 		/* 
 		 * Alpha Architecture Handbook 4.7.7.3:
-		 * To be fully IEEE compiant, we must track the current IEEE
+		 * To be fully IEEE compliant, we must track the current IEEE
 		 * exception state in software, because spurious bits can be
 		 * set in the trap shadow of a software-complete insn.
 		 */
diff --git a/arch/alpha/kernel/pci_iommu.c b/arch/alpha/kernel/pci_iommu.c
index c81183935e97..99de7bcaf24b 100644
--- a/arch/alpha/kernel/pci_iommu.c
+++ b/arch/alpha/kernel/pci_iommu.c
@@ -476,7 +476,7 @@ static void alpha_pci_free_coherent(struct device *dev, size_t size,
 	-1  : Not leader, physically adjacent to previous.
 	-2  : Not leader, virtually adjacent to previous.
    Write dma_length of each leader with the combined lengths of
-   the mergable followers.  */
+   the mergeable followers.  */
 
 #define SG_ENT_VIRT_ADDRESS(SG) (sg_virt((SG)))
 #define SG_ENT_PHYS_ADDRESS(SG) __pa(SG_ENT_VIRT_ADDRESS(SG))
@@ -495,7 +495,7 @@ sg_classify(struct device *dev, struct scatterlist *sg, struct scatterlist *end,
 	leader_length = leader->length;
 	next_paddr = SG_ENT_PHYS_ADDRESS(leader) + leader_length;
 
-	/* we will not marge sg without device. */
+	/* we will not merge sg without device. */
 	max_seg_size = dev ? dma_get_max_seg_size(dev) : 0;
 	for (++sg; sg < end; ++sg) {
 		unsigned long addr, len;
diff --git a/arch/alpha/kernel/sys_eiger.c b/arch/alpha/kernel/sys_eiger.c
index aea8a54da4bc..fbe264a30a66 100644
--- a/arch/alpha/kernel/sys_eiger.c
+++ b/arch/alpha/kernel/sys_eiger.c
@@ -98,7 +98,7 @@ eiger_device_interrupt(unsigned long vector)
 	if (intstatus) {
 		/*
 		 * This is a PCI interrupt. Check each bit and
-		 * despatch an interrupt if it's set.
+		 * dispatch an interrupt if it's set.
 		 */
 
 		if (intstatus & 8) handle_irq(16+3);
@@ -148,7 +148,7 @@ eiger_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 
 	/* The SRM console has already calculated out the IRQ value's for
 	   option cards. As this works lets just read in the value already
-	   set and change it to a useable value by Linux.
+	   set and change it to a usable value by Linux.
 
 	   All the IRQ values generated by the console are greater than 90,
 	   so we subtract 80 because it is (90 - allocated ISA IRQ's).  */
diff --git a/arch/alpha/kernel/sys_marvel.c b/arch/alpha/kernel/sys_marvel.c
index 1f99b03effc2..90a94f8816cc 100644
--- a/arch/alpha/kernel/sys_marvel.c
+++ b/arch/alpha/kernel/sys_marvel.c
@@ -258,7 +258,7 @@ init_io7_irqs(struct io7 *io7,
 	 * They really should be sent to the local CPU to avoid having to
 	 * traverse the mesh, but if it's not an SMP kernel, they have to
 	 * go to the boot CPU. Send them all to the boot CPU for now,
-	 * as each secondary starts, it can redirect it's local device 
+	 * as each secondary starts, it can redirect its local device
 	 * interrupts.
 	 */
 	printk("  Interrupts reported to CPU at PE %u\n", boot_cpuid);
diff --git a/arch/alpha/kernel/sys_miata.c b/arch/alpha/kernel/sys_miata.c
index 33b2798de8fc..3bde9c01a9ab 100644
--- a/arch/alpha/kernel/sys_miata.c
+++ b/arch/alpha/kernel/sys_miata.c
@@ -179,7 +179,7 @@ miata_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
         };
 	const long min_idsel = 3, max_idsel = 20, irqs_per_slot = 5;
 	
-	/* the USB function of the 82c693 has it's interrupt connected to 
+	/* the USB function of the 82c693 has its interrupt connected to
            the 2nd 8259 controller. So we have to check for it first. */
 
 	if((slot == 7) && (PCI_FUNC(dev->devfn) == 3)) {
diff --git a/arch/alpha/kernel/sys_takara.c b/arch/alpha/kernel/sys_takara.c
index 9e2adb69bc74..aa65a7fb8fc6 100644
--- a/arch/alpha/kernel/sys_takara.c
+++ b/arch/alpha/kernel/sys_takara.c
@@ -93,7 +93,7 @@ takara_device_interrupt(unsigned long vector)
 	if (intstatus) {
 		/*
 		 * This is a PCI interrupt. Check each bit and
-		 * despatch an interrupt if it's set.
+		 * dispatch an interrupt if it's set.
 		 */
 
 		if (intstatus & 8) handle_irq(16+3);
diff --git a/arch/alpha/lib/ev6-memcpy.S b/arch/alpha/lib/ev6-memcpy.S
index 3ef43c26c8af..12b94117f394 100644
--- a/arch/alpha/lib/ev6-memcpy.S
+++ b/arch/alpha/lib/ev6-memcpy.S
@@ -181,7 +181,7 @@ $tail_bytes:
 $misaligned:
 	mov	$0, $4			# E : dest temp
 	and	$0, 7, $1		# E : dest alignment mod8
-	beq	$1, $dest_0mod8		# U : life doesnt totally suck
+	beq	$1, $dest_0mod8		# U : life doesn't totally suck
 	nop
 
 $aligndest:
diff --git a/arch/alpha/lib/ev6-stxcpy.S b/arch/alpha/lib/ev6-stxcpy.S
index 65f5f7310d80..331eef1b90c5 100644
--- a/arch/alpha/lib/ev6-stxcpy.S
+++ b/arch/alpha/lib/ev6-stxcpy.S
@@ -129,7 +129,7 @@ __stxcpy:
 	ldq_u	t1, 0(a1)		# L : load first src word
 	and	a0, 7, t0		# E : take care not to load a word ...
 	addq	a1, 8, a1		# E :
-	beq	t0, stxcpy_aligned	# U : ... if we wont need it (stall)
+	beq	t0, stxcpy_aligned	# U : ... if we won't need it (stall)
 
 	ldq_u	t0, 0(a0)	# L :
 	br	stxcpy_aligned	# L0 : Latency=3
diff --git a/arch/alpha/lib/ev67-strrchr.S b/arch/alpha/lib/ev67-strrchr.S
index ae7355f9ec56..b1903395dea3 100644
--- a/arch/alpha/lib/ev67-strrchr.S
+++ b/arch/alpha/lib/ev67-strrchr.S
@@ -76,7 +76,7 @@ $loop:
 
 	cmpbge	zero, t0, t1	# E : bits set iff byte == zero
 	cmpbge	zero, t2, t3	# E : bits set iff byte == c
-	beq	t1, $loop	# U : if we havnt seen a null, loop
+	beq	t1, $loop	# U : if we haven't seen a null, loop
 	nop
 
 	/* Mask out character matches after terminator */
diff --git a/arch/alpha/lib/strrchr.S b/arch/alpha/lib/strrchr.S
index dd8e073b6cf2..f12045badb63 100644
--- a/arch/alpha/lib/strrchr.S
+++ b/arch/alpha/lib/strrchr.S
@@ -49,7 +49,7 @@ $loop:
 	xor	t0, a1, t2	# e0    :
 	cmpbge	zero, t0, t1	# .. e1 : bits set iff byte == zero
 	cmpbge	zero, t2, t3	# e0    : bits set iff byte == c
-	beq	t1, $loop	# .. e1 : if we havnt seen a null, loop
+	beq	t1, $loop	# .. e1 : if we haven't seen a null, loop
 
 	/* Mask out character matches after terminator */
 $eos:
diff --git a/arch/alpha/lib/stxcpy.S b/arch/alpha/lib/stxcpy.S
index 58723b0a36d4..967be2eaeaf0 100644
--- a/arch/alpha/lib/stxcpy.S
+++ b/arch/alpha/lib/stxcpy.S
@@ -109,7 +109,7 @@ __stxcpy:
 	ldq_u	t1, 0(a1)	# e0    : load first src word
 	and	a0, 7, t0	# .. e1 : take care not to load a word ...
 	addq	a1, 8, a1		# e0    :
-	beq	t0, stxcpy_aligned	# .. e1 : ... if we wont need it
+	beq	t0, stxcpy_aligned	# .. e1 : ... if we won't need it
 	ldq_u	t0, 0(a0)	# e0    :
 	br	stxcpy_aligned	# .. e1 :
 
-- 
2.34.1


