Return-Path: <linux-kernel+bounces-30305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A558831CDF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B0201F21EE7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FEF2C195;
	Thu, 18 Jan 2024 15:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QKXVFgRN"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF4025571;
	Thu, 18 Jan 2024 15:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705593193; cv=none; b=CAG0pKF2brwT0PKDGqx7m6Wb8p36+zFeyLMcPc7W42XQj35vUc8SaBbxgbVDpZKEqqFheS5B0xur+0BY7K5C64seMq0mEHXM5JDGZ3mAAZ1NfTZmtwU0ijnbOMMnfO9aUZdtySRMSSnk6JTJq0xG0v0iXY1CB/UrUKXpEQsHq0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705593193; c=relaxed/simple;
	bh=OUlUCT/kGsDR7HFe2x2iVWtjISKJ294rNuAkLy4HFl0=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-GND-Sasl; b=GeM5IltuJ0w18hq4bsfiWpyjVdx3mFL2QfThntRapgN+hUKax32Rlzg9cQNgl/NaJa/O0wahul0LLtG5rcMQAztYXw10AH7MeM4BYGpyG1H3xcPPZ3/UOy2xXSeyxnk9gAY8QivufDxr0E1jR2ReO9HqWgKdVnt/MV4ueol+4bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QKXVFgRN; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D93B01BF207;
	Thu, 18 Jan 2024 15:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1705593188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L9FhHosUT371iMjw9Xs3Tj8tq8si8nd8C8MXoIw+WeM=;
	b=QKXVFgRNhPGMUnwqLVVqxLXReYfZvBTTSAvU3bHjtGOGwCEhlQSNRMAGZrMUKtLdHMbCrf
	wfDCXqTDCd5437XSgPEe2QC5/9+BQu9x4q8dtb6fZt0gLNE8sROzBUfwunEAu3sh8lFRrD
	r/3aAU2YZj89Kfg+zlanj5r6IQ7+aGNAL1I5DpeyJ8zSgCaA1ahqikwnLbl0ZlfuRQLxMa
	GnYjDKy98DG5FG84WAC0i9vGvK9uTvgfMGJU7MGI3GKZ6PKfIzj13fH6iAV+8FNNYSgt+I
	b1z2OSk6polUgLOPVWTY7jz9rAu1D8OhHCBtvUshgdXbXOaKVJpaQ67+P4I02g==
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Paul Burton <paulburton@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@vger.kernel.org,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Vladimir  Kondratiev <vladimir.kondratiev@mobileye.com>,
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	=?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: [PATCH v6 03/15] MIPS: Allows relocation exception vectors everywhere
Date: Thu, 18 Jan 2024 16:52:32 +0100
Message-ID: <20240118155252.397947-4-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118155252.397947-1-gregory.clement@bootlin.com>
References: <20240118155252.397947-1-gregory.clement@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: gregory.clement@bootlin.com

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

Now the exception vector for CPS systems are allocated on-fly
with memblock as well.

It will try to allocate from KSEG1 first, and then try to allocate
in low 4G if possible.

The main reset vector is now generated by uasm, to avoid tons
of patches to the code. Other vectors are copied to the location
later.

gc: use the new macro CKSEG[0A1]DDR_OR_64BIT()
    move 64bits fix in an other patch
    fix cache issue with mips_cps_core_entry
    rewrite the patch to reduce the diff stat
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 arch/mips/include/asm/mips-cm.h |   1 +
 arch/mips/include/asm/smp-cps.h |   4 +-
 arch/mips/kernel/cps-vec.S      |  48 ++-------
 arch/mips/kernel/smp-cps.c      | 171 +++++++++++++++++++++++++++-----
 4 files changed, 157 insertions(+), 67 deletions(-)

diff --git a/arch/mips/include/asm/mips-cm.h b/arch/mips/include/asm/mips-cm.h
index 23c67c0871b17..15d8d69de4550 100644
--- a/arch/mips/include/asm/mips-cm.h
+++ b/arch/mips/include/asm/mips-cm.h
@@ -311,6 +311,7 @@ GCR_CX_ACCESSOR_RW(32, 0x018, other)
 /* GCR_Cx_RESET_BASE - Configure where powered up cores will fetch from */
 GCR_CX_ACCESSOR_RW(32, 0x020, reset_base)
 #define CM_GCR_Cx_RESET_BASE_BEVEXCBASE		GENMASK(31, 12)
+#define CM_GCR_Cx_RESET_BASE_MODE		BIT(1)
 
 /* GCR_Cx_ID - Identify the current core */
 GCR_CX_ACCESSOR_RO(32, 0x028, id)
diff --git a/arch/mips/include/asm/smp-cps.h b/arch/mips/include/asm/smp-cps.h
index 22a572b70fe31..39a602e5fecc4 100644
--- a/arch/mips/include/asm/smp-cps.h
+++ b/arch/mips/include/asm/smp-cps.h
@@ -24,7 +24,7 @@ struct core_boot_config {
 
 extern struct core_boot_config *mips_cps_core_bootcfg;
 
-extern void mips_cps_core_entry(void);
+extern void mips_cps_core_boot(int cca, void __iomem *gcr_base);
 extern void mips_cps_core_init(void);
 
 extern void mips_cps_boot_vpes(struct core_boot_config *cfg, unsigned vpe);
@@ -32,8 +32,6 @@ extern void mips_cps_boot_vpes(struct core_boot_config *cfg, unsigned vpe);
 extern void mips_cps_pm_save(void);
 extern void mips_cps_pm_restore(void);
 
-extern void *mips_cps_core_entry_patch_end;
-
 #ifdef CONFIG_MIPS_CPS
 
 extern bool mips_cps_smp_in_use(void);
diff --git a/arch/mips/kernel/cps-vec.S b/arch/mips/kernel/cps-vec.S
index 64ecfdac6580b..df610c006b443 100644
--- a/arch/mips/kernel/cps-vec.S
+++ b/arch/mips/kernel/cps-vec.S
@@ -4,6 +4,7 @@
  * Author: Paul Burton <paul.burton@mips.com>
  */
 
+#include <linux/init.h>
 #include <asm/addrspace.h>
 #include <asm/asm.h>
 #include <asm/asm-offsets.h>
@@ -82,39 +83,10 @@
 	.endm
 
 
-.balign 0x1000
-
-LEAF(mips_cps_core_entry)
-	/*
-	 * These first several instructions will be patched by cps_smp_setup to load the
-	 * CCA to use into register s0 and GCR base address to register s1.
-	 */
-	.rept   CPS_ENTRY_PATCH_INSNS
-	nop
-	.endr
-
-	.global mips_cps_core_entry_patch_end
-mips_cps_core_entry_patch_end:
-
-	/* Check whether we're here due to an NMI */
-	mfc0	k0, CP0_STATUS
-	and	k0, k0, ST0_NMI
-	beqz	k0, not_nmi
-	 nop
-
-	/* This is an NMI */
-	PTR_LA	k0, nmi_handler
-	jr	k0
-	 nop
-
-not_nmi:
-	/* Setup Cause */
-	li	t0, CAUSEF_IV
-	mtc0	t0, CP0_CAUSE
-
-	/* Setup Status */
-	li	t0, ST0_CU1 | ST0_CU0 | ST0_BEV | STATUS_BITDEPS
-	mtc0	t0, CP0_STATUS
+LEAF(mips_cps_core_boot)
+	/* Save  CCA and GCR base */
+	move   s0, a0
+	move   s1, a1
 
 	/* We don't know how to do coherence setup on earlier ISA */
 #if MIPS_ISA_REV > 0
@@ -178,49 +150,45 @@ not_nmi:
 	PTR_L	sp, VPEBOOTCFG_SP(v1)
 	jr	t1
 	 nop
-	END(mips_cps_core_entry)
+	END(mips_cps_core_boot)
 
-.org 0x200
+	__INIT
 LEAF(excep_tlbfill)
 	DUMP_EXCEP("TLB Fill")
 	b	.
 	 nop
 	END(excep_tlbfill)
 
-.org 0x280
 LEAF(excep_xtlbfill)
 	DUMP_EXCEP("XTLB Fill")
 	b	.
 	 nop
 	END(excep_xtlbfill)
 
-.org 0x300
 LEAF(excep_cache)
 	DUMP_EXCEP("Cache")
 	b	.
 	 nop
 	END(excep_cache)
 
-.org 0x380
 LEAF(excep_genex)
 	DUMP_EXCEP("General")
 	b	.
 	 nop
 	END(excep_genex)
 
-.org 0x400
 LEAF(excep_intex)
 	DUMP_EXCEP("Interrupt")
 	b	.
 	 nop
 	END(excep_intex)
 
-.org 0x480
 LEAF(excep_ejtag)
 	PTR_LA	k0, ejtag_debug_handler
 	jr	k0
 	 nop
 	END(excep_ejtag)
+	__FINIT
 
 LEAF(mips_cps_core_init)
 #ifdef CONFIG_MIPS_MT_SMP
diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
index dd55d59b88db3..f4cdd50177e0b 100644
--- a/arch/mips/kernel/smp-cps.c
+++ b/arch/mips/kernel/smp-cps.c
@@ -7,6 +7,7 @@
 #include <linux/cpu.h>
 #include <linux/delay.h>
 #include <linux/io.h>
+#include <linux/memblock.h>
 #include <linux/sched/task_stack.h>
 #include <linux/sched/hotplug.h>
 #include <linux/slab.h>
@@ -25,7 +26,34 @@
 #include <asm/time.h>
 #include <asm/uasm.h>
 
+#define BEV_VEC_SIZE	0x500
+#define BEV_VEC_ALIGN	0x1000
+
+#define A0		4
+#define A1		5
+#define T9		25
+#define K0		26
+#define K1		27
+
+#define C0_STATUS	12, 0
+#define C0_CAUSE	13, 0
+
+#define ST0_NMI_BIT	19
+#ifdef CONFIG_64BIT
+#define ST0_KX_IF_64	ST0_KX
+#else
+#define ST0_KX_IF_64	0
+#endif
+
+enum label_id {
+	label_not_nmi = 1,
+};
+
+UASM_L_LA(_not_nmi)
+
 static DECLARE_BITMAP(core_power, NR_CPUS);
+static uint32_t core_entry_reg;
+static phys_addr_t cps_vec_pa;
 
 struct core_boot_config *mips_cps_core_bootcfg;
 
@@ -34,10 +62,115 @@ static unsigned __init core_vpe_count(unsigned int cluster, unsigned core)
 	return min(smp_max_threads, mips_cps_numvps(cluster, core));
 }
 
+static void __init *mips_cps_build_core_entry(void *addr)
+{
+	extern void (*nmi_handler)(void);
+	u32 *p = addr;
+	u32 val;
+	struct uasm_label labels[2];
+	struct uasm_reloc relocs[2];
+	struct uasm_label *l = labels;
+	struct uasm_reloc *r = relocs;
+
+	memset(labels, 0, sizeof(labels));
+	memset(relocs, 0, sizeof(relocs));
+
+	uasm_i_mfc0(&p, K0, C0_STATUS);
+	if (cpu_has_mips_r2_r6)
+		uasm_i_ext(&p, K0, K0, ST0_NMI_BIT, 1);
+	else {
+		uasm_i_srl(&p, K0, K0, ST0_NMI_BIT);
+		uasm_i_andi(&p, K0, K0, 0x1);
+	}
+
+	uasm_il_bnez(&p, &r, K0, label_not_nmi);
+	uasm_i_nop(&p);
+	UASM_i_LA(&p, K0, (long)&nmi_handler);
+
+	uasm_l_not_nmi(&l, p);
+
+	val = CAUSEF_IV;
+	uasm_i_lui(&p, K0, val >> 16);
+	uasm_i_ori(&p, K0, K0, val & 0xffff);
+	uasm_i_mtc0(&p, K0, C0_CAUSE);
+	val = ST0_CU1 | ST0_CU0 | ST0_BEV | ST0_KX_IF_64;
+	uasm_i_lui(&p, K0, val >> 16);
+	uasm_i_ori(&p, K0, K0, val & 0xffff);
+	uasm_i_mtc0(&p, K0, C0_STATUS);
+	uasm_i_ehb(&p);
+	uasm_i_ori(&p, A0, 0, read_c0_config() & CONF_CM_CMASK);
+	UASM_i_LA(&p, A1, (long)mips_gcr_base);
+#if defined(KBUILD_64BIT_SYM32) || defined(CONFIG_32BIT)
+	UASM_i_LA(&p, T9, CKSEG1ADDR(__pa_symbol(mips_cps_core_boot)));
+#else
+	UASM_i_LA(&p, T9, TO_UNCAC(__pa_symbol(mips_cps_core_boot)));
+#endif
+	uasm_i_jr(&p, T9);
+	uasm_i_nop(&p);
+
+	uasm_resolve_relocs(relocs, labels);
+
+	return p;
+}
+
+static int __init allocate_cps_vecs(void)
+{
+	/* Try to allocate in KSEG1 first */
+	cps_vec_pa = memblock_phys_alloc_range(BEV_VEC_SIZE, BEV_VEC_ALIGN,
+						0x0, KSEGX_SIZE - 1);
+
+	if (cps_vec_pa)
+		core_entry_reg = CKSEG1ADDR(cps_vec_pa) &
+					CM_GCR_Cx_RESET_BASE_BEVEXCBASE;
+
+	if (!cps_vec_pa && mips_cm_is64) {
+		cps_vec_pa = memblock_phys_alloc_range(BEV_VEC_SIZE, BEV_VEC_ALIGN,
+							0x0, SZ_4G - 1);
+		if (cps_vec_pa)
+			core_entry_reg = (cps_vec_pa & CM_GCR_Cx_RESET_BASE_BEVEXCBASE) |
+					CM_GCR_Cx_RESET_BASE_MODE;
+	}
+
+	if (!cps_vec_pa)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void __init setup_cps_vecs(void)
+{
+	extern void excep_tlbfill(void);
+	extern void excep_xtlbfill(void);
+	extern void excep_cache(void);
+	extern void excep_genex(void);
+	extern void excep_intex(void);
+	extern void excep_ejtag(void);
+	void *cps_vec;
+
+	/* We want to ensure cache is clean before writing uncached mem */
+	blast_dcache_range(CKSEG0ADDR_OR_64BIT(cps_vec_pa), CKSEG0ADDR_OR_64BIT(cps_vec_pa) + BEV_VEC_SIZE);
+	bc_wback_inv(CKSEG0ADDR_OR_64BIT(cps_vec_pa), BEV_VEC_SIZE);
+	__sync();
+
+	cps_vec = (void *)CKSEG1ADDR_OR_64BIT(cps_vec_pa);
+	mips_cps_build_core_entry(cps_vec);
+
+	memcpy(cps_vec + 0x200, &excep_tlbfill, 0x80);
+	memcpy(cps_vec + 0x280, &excep_xtlbfill, 0x80);
+	memcpy(cps_vec + 0x300, &excep_cache, 0x80);
+	memcpy(cps_vec + 0x380, &excep_genex, 0x80);
+	memcpy(cps_vec + 0x400, &excep_intex, 0x80);
+	memcpy(cps_vec + 0x480, &excep_ejtag, 0x80);
+
+	/* Make sure no prefetched data in cache */
+	blast_inv_dcache_range(CKSEG0ADDR_OR_64BIT(cps_vec_pa), CKSEG0ADDR_OR_64BIT(cps_vec_pa) + BEV_VEC_SIZE);
+	bc_inv(CKSEG0ADDR_OR_64BIT(cps_vec_pa), BEV_VEC_SIZE);
+	__sync();
+}
+
 static void __init cps_smp_setup(void)
 {
 	unsigned int nclusters, ncores, nvpes, core_vpes;
-	unsigned long core_entry;
 	int cl, c, v;
 
 	/* Detect & record VPE topology */
@@ -94,10 +227,11 @@ static void __init cps_smp_setup(void)
 	/* Make core 0 coherent with everything */
 	write_gcr_cl_coherence(0xff);
 
-	if (mips_cm_revision() >= CM_REV_CM3) {
-		core_entry = CKSEG1ADDR((unsigned long)mips_cps_core_entry);
-		write_gcr_bev_base(core_entry);
-	}
+	if (allocate_cps_vecs())
+		pr_err("Failed to allocate CPS vectors\n");
+
+	if (core_entry_reg && mips_cm_revision() >= CM_REV_CM3)
+		write_gcr_bev_base(core_entry_reg);
 
 #ifdef CONFIG_MIPS_MT_FPAFF
 	/* If we have an FPU, enroll ourselves in the FPU-full mask */
@@ -110,10 +244,14 @@ static void __init cps_prepare_cpus(unsigned int max_cpus)
 {
 	unsigned ncores, core_vpes, c, cca;
 	bool cca_unsuitable, cores_limited;
-	u32 *entry_code;
 
 	mips_mt_set_cpuoptions();
 
+	if (!core_entry_reg) {
+		pr_err("core_entry address unsuitable, disabling smp-cps\n");
+		goto err_out;
+	}
+
 	/* Detect whether the CCA is unsuited to multi-core SMP */
 	cca = read_c0_config() & CONF_CM_CMASK;
 	switch (cca) {
@@ -145,20 +283,7 @@ static void __init cps_prepare_cpus(unsigned int max_cpus)
 			(cca_unsuitable && cpu_has_dc_aliases) ? " & " : "",
 			cpu_has_dc_aliases ? "dcache aliasing" : "");
 
-	/*
-	 * Patch the start of mips_cps_core_entry to provide:
-	 *
-	 * s0 = kseg0 CCA
-	 */
-	entry_code = (u32 *)&mips_cps_core_entry;
-	uasm_i_addiu(&entry_code, 16, 0, cca);
-	UASM_i_LA(&entry_code, 17, (long)mips_gcr_base);
-	BUG_ON((void *)entry_code > (void *)&mips_cps_core_entry_patch_end);
-	blast_dcache_range((unsigned long)&mips_cps_core_entry,
-			   (unsigned long)entry_code);
-	bc_wback_inv((unsigned long)&mips_cps_core_entry,
-		     (void *)entry_code - (void *)&mips_cps_core_entry);
-	__sync();
+	setup_cps_vecs();
 
 	/* Allocate core boot configuration structs */
 	ncores = mips_cps_numcores(0);
@@ -213,7 +338,7 @@ static void boot_core(unsigned int core, unsigned int vpe_id)
 	mips_cm_lock_other(0, core, 0, CM_GCR_Cx_OTHER_BLOCK_LOCAL);
 
 	/* Set its reset vector */
-	write_gcr_co_reset_base(CKSEG1ADDR((unsigned long)mips_cps_core_entry));
+	write_gcr_co_reset_base(core_entry_reg);
 
 	/* Ensure its coherency is disabled */
 	write_gcr_co_coherence(0);
@@ -290,7 +415,6 @@ static int cps_boot_secondary(int cpu, struct task_struct *idle)
 	unsigned vpe_id = cpu_vpe_id(&cpu_data[cpu]);
 	struct core_boot_config *core_cfg = &mips_cps_core_bootcfg[core];
 	struct vpe_boot_config *vpe_cfg = &core_cfg->vpe_config[vpe_id];
-	unsigned long core_entry;
 	unsigned int remote;
 	int err;
 
@@ -314,8 +438,7 @@ static int cps_boot_secondary(int cpu, struct task_struct *idle)
 
 	if (cpu_has_vp) {
 		mips_cm_lock_other(0, core, vpe_id, CM_GCR_Cx_OTHER_BLOCK_LOCAL);
-		core_entry = CKSEG1ADDR((unsigned long)mips_cps_core_entry);
-		write_gcr_co_reset_base(core_entry);
+		write_gcr_co_reset_base(core_entry_reg);
 		mips_cm_unlock_other();
 	}
 
-- 
2.43.0


