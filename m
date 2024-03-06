Return-Path: <linux-kernel+bounces-94125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18730873A4B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C7B32899A4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070A9134CF7;
	Wed,  6 Mar 2024 15:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BIgbO4A6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2AB135A72;
	Wed,  6 Mar 2024 15:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709737571; cv=none; b=B7OhO0/Kr5W7uAW//KyK14BLk0zAQOERxoCEYjMQmLoQUEBExE+3l6tfMHKk8BLU3hGNKvCmLTsF0tfeatrWDY/4gLcNIgWvxpMqVsVcaDy/I4UC4gUC4zutxnImUxG3gQnUq2FDF/rogskidrY6ZS9tmn+IFrSbnvAFnJSQs+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709737571; c=relaxed/simple;
	bh=a087j3FmyIC/ad3GDTHapSoYi9g121xdmWyDW5VE+1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GjTOmxoru/e3xD4Gb32unmTmMUlRbBlaeDPzr1pFyT7a2n2i8uBihjboE62mw8z/ahozaa+fb5IfSivBAROi2X3DDOgheNbcoOq9LutvViELlhqmQ+/LkWAJIxvE4t+6xldlX2wi3kMUpENhGGVOJturPOfsP8d7CZBeR0NItIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BIgbO4A6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8B29C433F1;
	Wed,  6 Mar 2024 15:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709737570;
	bh=a087j3FmyIC/ad3GDTHapSoYi9g121xdmWyDW5VE+1Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BIgbO4A6/kNQE0ld+7WJ9GJemvl0bPZHxdmIUh28O8F5kD8vu7oTvxCHTc5QTUgA8
	 Qr7EcWA4+NSqvMTrQT9GEcPMxNlndbVW3tUjfUiOfPlRy10eTWebEmR/0D5FKQG8bu
	 ariteqllXOyhknv/mLZE/bthGgD8R+twHeXfLA+g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.7.9
Date: Wed,  6 Mar 2024 15:06:00 +0000
Message-ID: <2024030600-comfort-thermos-a353@gregkh>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <2024030600-vineyard-divisible-6a94@gregkh>
References: <2024030600-vineyard-divisible-6a94@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/arch/x86/mds.rst b/Documentation/arch/x86/mds.rst
index e73fdff62c0a..c58c72362911 100644
--- a/Documentation/arch/x86/mds.rst
+++ b/Documentation/arch/x86/mds.rst
@@ -95,6 +95,9 @@ The kernel provides a function to invoke the buffer clearing:
 
     mds_clear_cpu_buffers()
 
+Also macro CLEAR_CPU_BUFFERS can be used in ASM late in exit-to-user path.
+Other than CFLAGS.ZF, this macro doesn't clobber any registers.
+
 The mitigation is invoked on kernel/userspace, hypervisor/guest and C-state
 (idle) transitions.
 
@@ -138,17 +141,30 @@ Mitigation points
 
    When transitioning from kernel to user space the CPU buffers are flushed
    on affected CPUs when the mitigation is not disabled on the kernel
-   command line. The migitation is enabled through the static key
-   mds_user_clear.
-
-   The mitigation is invoked in prepare_exit_to_usermode() which covers
-   all but one of the kernel to user space transitions.  The exception
-   is when we return from a Non Maskable Interrupt (NMI), which is
-   handled directly in do_nmi().
-
-   (The reason that NMI is special is that prepare_exit_to_usermode() can
-    enable IRQs.  In NMI context, NMIs are blocked, and we don't want to
-    enable IRQs with NMIs blocked.)
+   command line. The mitigation is enabled through the feature flag
+   X86_FEATURE_CLEAR_CPU_BUF.
+
+   The mitigation is invoked just before transitioning to userspace after
+   user registers are restored. This is done to minimize the window in
+   which kernel data could be accessed after VERW e.g. via an NMI after
+   VERW.
+
+   **Corner case not handled**
+   Interrupts returning to kernel don't clear CPUs buffers since the
+   exit-to-user path is expected to do that anyways. But, there could be
+   a case when an NMI is generated in kernel after the exit-to-user path
+   has cleared the buffers. This case is not handled and NMI returning to
+   kernel don't clear CPU buffers because:
+
+   1. It is rare to get an NMI after VERW, but before returning to userspace.
+   2. For an unprivileged user, there is no known way to make that NMI
+      less rare or target it.
+   3. It would take a large number of these precisely-timed NMIs to mount
+      an actual attack.  There's presumably not enough bandwidth.
+   4. The NMI in question occurs after a VERW, i.e. when user state is
+      restored and most interesting data is already scrubbed. Whats left
+      is only the data that NMI touches, and that may or may not be of
+      any interest.
 
 
 2. C-State transition
diff --git a/Makefile b/Makefile
index 6569f2255d50..f1a592b7c7bc 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 7
-SUBLEVEL = 8
+SUBLEVEL = 9
 EXTRAVERSION =
 NAME = Hurr durr I'ma ninja sloth
 
diff --git a/arch/arm64/crypto/aes-neonbs-glue.c b/arch/arm64/crypto/aes-neonbs-glue.c
index bac4cabef607..467ac2f768ac 100644
--- a/arch/arm64/crypto/aes-neonbs-glue.c
+++ b/arch/arm64/crypto/aes-neonbs-glue.c
@@ -227,8 +227,19 @@ static int ctr_encrypt(struct skcipher_request *req)
 			src += blocks * AES_BLOCK_SIZE;
 		}
 		if (nbytes && walk.nbytes == walk.total) {
+			u8 buf[AES_BLOCK_SIZE];
+			u8 *d = dst;
+
+			if (unlikely(nbytes < AES_BLOCK_SIZE))
+				src = dst = memcpy(buf + sizeof(buf) - nbytes,
+						   src, nbytes);
+
 			neon_aes_ctr_encrypt(dst, src, ctx->enc, ctx->key.rounds,
 					     nbytes, walk.iv);
+
+			if (unlikely(nbytes < AES_BLOCK_SIZE))
+				memcpy(d, dst, nbytes);
+
 			nbytes = 0;
 		}
 		kernel_neon_end();
diff --git a/arch/powerpc/include/asm/rtas.h b/arch/powerpc/include/asm/rtas.h
index c697c3c74694..33024a2874a6 100644
--- a/arch/powerpc/include/asm/rtas.h
+++ b/arch/powerpc/include/asm/rtas.h
@@ -68,7 +68,7 @@ enum rtas_function_index {
 	RTAS_FNIDX__IBM_READ_SLOT_RESET_STATE,
 	RTAS_FNIDX__IBM_READ_SLOT_RESET_STATE2,
 	RTAS_FNIDX__IBM_REMOVE_PE_DMA_WINDOW,
-	RTAS_FNIDX__IBM_RESET_PE_DMA_WINDOWS,
+	RTAS_FNIDX__IBM_RESET_PE_DMA_WINDOW,
 	RTAS_FNIDX__IBM_SCAN_LOG_DUMP,
 	RTAS_FNIDX__IBM_SET_DYNAMIC_INDICATOR,
 	RTAS_FNIDX__IBM_SET_EEH_OPTION,
@@ -163,7 +163,7 @@ typedef struct {
 #define RTAS_FN_IBM_READ_SLOT_RESET_STATE         rtas_fn_handle(RTAS_FNIDX__IBM_READ_SLOT_RESET_STATE)
 #define RTAS_FN_IBM_READ_SLOT_RESET_STATE2        rtas_fn_handle(RTAS_FNIDX__IBM_READ_SLOT_RESET_STATE2)
 #define RTAS_FN_IBM_REMOVE_PE_DMA_WINDOW          rtas_fn_handle(RTAS_FNIDX__IBM_REMOVE_PE_DMA_WINDOW)
-#define RTAS_FN_IBM_RESET_PE_DMA_WINDOWS          rtas_fn_handle(RTAS_FNIDX__IBM_RESET_PE_DMA_WINDOWS)
+#define RTAS_FN_IBM_RESET_PE_DMA_WINDOW           rtas_fn_handle(RTAS_FNIDX__IBM_RESET_PE_DMA_WINDOW)
 #define RTAS_FN_IBM_SCAN_LOG_DUMP                 rtas_fn_handle(RTAS_FNIDX__IBM_SCAN_LOG_DUMP)
 #define RTAS_FN_IBM_SET_DYNAMIC_INDICATOR         rtas_fn_handle(RTAS_FNIDX__IBM_SET_DYNAMIC_INDICATOR)
 #define RTAS_FN_IBM_SET_EEH_OPTION                rtas_fn_handle(RTAS_FNIDX__IBM_SET_EEH_OPTION)
diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
index 87d65bdd3eca..46b9476d7582 100644
--- a/arch/powerpc/kernel/rtas.c
+++ b/arch/powerpc/kernel/rtas.c
@@ -310,8 +310,13 @@ static struct rtas_function rtas_function_table[] __ro_after_init = {
 	[RTAS_FNIDX__IBM_REMOVE_PE_DMA_WINDOW] = {
 		.name = "ibm,remove-pe-dma-window",
 	},
-	[RTAS_FNIDX__IBM_RESET_PE_DMA_WINDOWS] = {
-		.name = "ibm,reset-pe-dma-windows",
+	[RTAS_FNIDX__IBM_RESET_PE_DMA_WINDOW] = {
+		/*
+		 * Note: PAPR+ v2.13 7.3.31.4.1 spells this as
+		 * "ibm,reset-pe-dma-windows" (plural), but RTAS
+		 * implementations use the singular form in practice.
+		 */
+		.name = "ibm,reset-pe-dma-window",
 	},
 	[RTAS_FNIDX__IBM_SCAN_LOG_DUMP] = {
 		.name = "ibm,scan-log-dump",
diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 496e16c588aa..e8c4129697b1 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -574,29 +574,6 @@ static void iommu_table_setparms(struct pci_controller *phb,
 
 struct iommu_table_ops iommu_table_lpar_multi_ops;
 
-/*
- * iommu_table_setparms_lpar
- *
- * Function: On pSeries LPAR systems, return TCE table info, given a pci bus.
- */
-static void iommu_table_setparms_lpar(struct pci_controller *phb,
-				      struct device_node *dn,
-				      struct iommu_table *tbl,
-				      struct iommu_table_group *table_group,
-				      const __be32 *dma_window)
-{
-	unsigned long offset, size, liobn;
-
-	of_parse_dma_window(dn, dma_window, &liobn, &offset, &size);
-
-	iommu_table_setparms_common(tbl, phb->bus->number, liobn, offset, size, IOMMU_PAGE_SHIFT_4K, NULL,
-				    &iommu_table_lpar_multi_ops);
-
-
-	table_group->tce32_start = offset;
-	table_group->tce32_size = size;
-}
-
 struct iommu_table_ops iommu_table_pseries_ops = {
 	.set = tce_build_pSeries,
 	.clear = tce_free_pSeries,
@@ -724,26 +701,71 @@ struct iommu_table_ops iommu_table_lpar_multi_ops = {
  * dynamic 64bit DMA window, walking up the device tree.
  */
 static struct device_node *pci_dma_find(struct device_node *dn,
-					const __be32 **dma_window)
+					struct dynamic_dma_window_prop *prop)
 {
-	const __be32 *dw = NULL;
+	const __be32 *default_prop = NULL;
+	const __be32 *ddw_prop = NULL;
+	struct device_node *rdn = NULL;
+	bool default_win = false, ddw_win = false;
 
 	for ( ; dn && PCI_DN(dn); dn = dn->parent) {
-		dw = of_get_property(dn, "ibm,dma-window", NULL);
-		if (dw) {
-			if (dma_window)
-				*dma_window = dw;
-			return dn;
+		default_prop = of_get_property(dn, "ibm,dma-window", NULL);
+		if (default_prop) {
+			rdn = dn;
+			default_win = true;
+		}
+		ddw_prop = of_get_property(dn, DIRECT64_PROPNAME, NULL);
+		if (ddw_prop) {
+			rdn = dn;
+			ddw_win = true;
+			break;
+		}
+		ddw_prop = of_get_property(dn, DMA64_PROPNAME, NULL);
+		if (ddw_prop) {
+			rdn = dn;
+			ddw_win = true;
+			break;
 		}
-		dw = of_get_property(dn, DIRECT64_PROPNAME, NULL);
-		if (dw)
-			return dn;
-		dw = of_get_property(dn, DMA64_PROPNAME, NULL);
-		if (dw)
-			return dn;
+
+		/* At least found default window, which is the case for normal boot */
+		if (default_win)
+			break;
 	}
 
-	return NULL;
+	/* For PCI devices there will always be a DMA window, either on the device
+	 * or parent bus
+	 */
+	WARN_ON(!(default_win | ddw_win));
+
+	/* caller doesn't want to get DMA window property */
+	if (!prop)
+		return rdn;
+
+	/* parse DMA window property. During normal system boot, only default
+	 * DMA window is passed in OF. But, for kdump, a dedicated adapter might
+	 * have both default and DDW in FDT. In this scenario, DDW takes precedence
+	 * over default window.
+	 */
+	if (ddw_win) {
+		struct dynamic_dma_window_prop *p;
+
+		p = (struct dynamic_dma_window_prop *)ddw_prop;
+		prop->liobn = p->liobn;
+		prop->dma_base = p->dma_base;
+		prop->tce_shift = p->tce_shift;
+		prop->window_shift = p->window_shift;
+	} else if (default_win) {
+		unsigned long offset, size, liobn;
+
+		of_parse_dma_window(rdn, default_prop, &liobn, &offset, &size);
+
+		prop->liobn = cpu_to_be32((u32)liobn);
+		prop->dma_base = cpu_to_be64(offset);
+		prop->tce_shift = cpu_to_be32(IOMMU_PAGE_SHIFT_4K);
+		prop->window_shift = cpu_to_be32(order_base_2(size));
+	}
+
+	return rdn;
 }
 
 static void pci_dma_bus_setup_pSeriesLP(struct pci_bus *bus)
@@ -751,17 +773,20 @@ static void pci_dma_bus_setup_pSeriesLP(struct pci_bus *bus)
 	struct iommu_table *tbl;
 	struct device_node *dn, *pdn;
 	struct pci_dn *ppci;
-	const __be32 *dma_window = NULL;
+	struct dynamic_dma_window_prop prop;
 
 	dn = pci_bus_to_OF_node(bus);
 
 	pr_debug("pci_dma_bus_setup_pSeriesLP: setting up bus %pOF\n",
 		 dn);
 
-	pdn = pci_dma_find(dn, &dma_window);
+	pdn = pci_dma_find(dn, &prop);
 
-	if (dma_window == NULL)
-		pr_debug("  no ibm,dma-window property !\n");
+	/* In PPC architecture, there will always be DMA window on bus or one of the
+	 * parent bus. During reboot, there will be ibm,dma-window property to
+	 * define DMA window. For kdump, there will at least be default window or DDW
+	 * or both.
+	 */
 
 	ppci = PCI_DN(pdn);
 
@@ -771,13 +796,24 @@ static void pci_dma_bus_setup_pSeriesLP(struct pci_bus *bus)
 	if (!ppci->table_group) {
 		ppci->table_group = iommu_pseries_alloc_group(ppci->phb->node);
 		tbl = ppci->table_group->tables[0];
-		if (dma_window) {
-			iommu_table_setparms_lpar(ppci->phb, pdn, tbl,
-						  ppci->table_group, dma_window);
 
-			if (!iommu_init_table(tbl, ppci->phb->node, 0, 0))
-				panic("Failed to initialize iommu table");
-		}
+		iommu_table_setparms_common(tbl, ppci->phb->bus->number,
+				be32_to_cpu(prop.liobn),
+				be64_to_cpu(prop.dma_base),
+				1ULL << be32_to_cpu(prop.window_shift),
+				be32_to_cpu(prop.tce_shift), NULL,
+				&iommu_table_lpar_multi_ops);
+
+		/* Only for normal boot with default window. Doesn't matter even
+		 * if we set these with DDW which is 64bit during kdump, since
+		 * these will not be used during kdump.
+		 */
+		ppci->table_group->tce32_start = be64_to_cpu(prop.dma_base);
+		ppci->table_group->tce32_size = 1 << be32_to_cpu(prop.window_shift);
+
+		if (!iommu_init_table(tbl, ppci->phb->node, 0, 0))
+			panic("Failed to initialize iommu table");
+
 		iommu_register_group(ppci->table_group,
 				pci_domain_nr(bus), 0);
 		pr_debug("  created table: %p\n", ppci->table_group);
@@ -968,6 +1004,12 @@ static void find_existing_ddw_windows_named(const char *name)
 			continue;
 		}
 
+		/* If at the time of system initialization, there are DDWs in OF,
+		 * it means this is during kexec. DDW could be direct or dynamic.
+		 * We will just mark DDWs as "dynamic" since this is kdump path,
+		 * no need to worry about perforance. ddw_list_new_entry() will
+		 * set window->direct = false.
+		 */
 		window = ddw_list_new_entry(pdn, dma64);
 		if (!window) {
 			of_node_put(pdn);
@@ -1524,8 +1566,8 @@ static void pci_dma_dev_setup_pSeriesLP(struct pci_dev *dev)
 {
 	struct device_node *pdn, *dn;
 	struct iommu_table *tbl;
-	const __be32 *dma_window = NULL;
 	struct pci_dn *pci;
+	struct dynamic_dma_window_prop prop;
 
 	pr_debug("pci_dma_dev_setup_pSeriesLP: %s\n", pci_name(dev));
 
@@ -1538,7 +1580,7 @@ static void pci_dma_dev_setup_pSeriesLP(struct pci_dev *dev)
 	dn = pci_device_to_OF_node(dev);
 	pr_debug("  node is %pOF\n", dn);
 
-	pdn = pci_dma_find(dn, &dma_window);
+	pdn = pci_dma_find(dn, &prop);
 	if (!pdn || !PCI_DN(pdn)) {
 		printk(KERN_WARNING "pci_dma_dev_setup_pSeriesLP: "
 		       "no DMA window found for pci dev=%s dn=%pOF\n",
@@ -1551,8 +1593,20 @@ static void pci_dma_dev_setup_pSeriesLP(struct pci_dev *dev)
 	if (!pci->table_group) {
 		pci->table_group = iommu_pseries_alloc_group(pci->phb->node);
 		tbl = pci->table_group->tables[0];
-		iommu_table_setparms_lpar(pci->phb, pdn, tbl,
-				pci->table_group, dma_window);
+
+		iommu_table_setparms_common(tbl, pci->phb->bus->number,
+				be32_to_cpu(prop.liobn),
+				be64_to_cpu(prop.dma_base),
+				1ULL << be32_to_cpu(prop.window_shift),
+				be32_to_cpu(prop.tce_shift), NULL,
+				&iommu_table_lpar_multi_ops);
+
+		/* Only for normal boot with default window. Doesn't matter even
+		 * if we set these with DDW which is 64bit during kdump, since
+		 * these will not be used during kdump.
+		 */
+		pci->table_group->tce32_start = be64_to_cpu(prop.dma_base);
+		pci->table_group->tce32_size = 1 << be32_to_cpu(prop.window_shift);
 
 		iommu_init_table(tbl, pci->phb->node, 0, 0);
 		iommu_register_group(pci->table_group,
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index cd4c9a204d08..f6df30e8d18e 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -294,7 +294,6 @@ config AS_HAS_OPTION_ARCH
 	# https://reviews.llvm.org/D123515
 	def_bool y
 	depends on $(as-instr, .option arch$(comma) +m)
-	depends on !$(as-instr, .option arch$(comma) -i)
 
 source "arch/riscv/Kconfig.socs"
 source "arch/riscv/Kconfig.errata"
diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 306a19a5509c..0f2e68f4e813 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -415,6 +415,7 @@
 # define CSR_STATUS	CSR_MSTATUS
 # define CSR_IE		CSR_MIE
 # define CSR_TVEC	CSR_MTVEC
+# define CSR_ENVCFG	CSR_MENVCFG
 # define CSR_SCRATCH	CSR_MSCRATCH
 # define CSR_EPC	CSR_MEPC
 # define CSR_CAUSE	CSR_MCAUSE
@@ -439,6 +440,7 @@
 # define CSR_STATUS	CSR_SSTATUS
 # define CSR_IE		CSR_SIE
 # define CSR_TVEC	CSR_STVEC
+# define CSR_ENVCFG	CSR_SENVCFG
 # define CSR_SCRATCH	CSR_SSCRATCH
 # define CSR_EPC	CSR_SEPC
 # define CSR_CAUSE	CSR_SCAUSE
diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ftrace.h
index 2b2f5df7ef2c..42777f91a9c5 100644
--- a/arch/riscv/include/asm/ftrace.h
+++ b/arch/riscv/include/asm/ftrace.h
@@ -25,6 +25,11 @@
 
 #define ARCH_SUPPORTS_FTRACE_OPS 1
 #ifndef __ASSEMBLY__
+
+extern void *return_address(unsigned int level);
+
+#define ftrace_return_address(n) return_address(n)
+
 void MCOUNT_NAME(void);
 static inline unsigned long ftrace_call_adjust(unsigned long addr)
 {
diff --git a/arch/riscv/include/asm/hugetlb.h b/arch/riscv/include/asm/hugetlb.h
index 20f9c3ba2341..22deb7a2a6ec 100644
--- a/arch/riscv/include/asm/hugetlb.h
+++ b/arch/riscv/include/asm/hugetlb.h
@@ -11,8 +11,10 @@ static inline void arch_clear_hugepage_flags(struct page *page)
 }
 #define arch_clear_hugepage_flags arch_clear_hugepage_flags
 
+#ifdef CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION
 bool arch_hugetlb_migration_supported(struct hstate *h);
 #define arch_hugetlb_migration_supported arch_hugetlb_migration_supported
+#endif
 
 #ifdef CONFIG_RISCV_ISA_SVNAPOT
 #define __HAVE_ARCH_HUGE_PTE_CLEAR
diff --git a/arch/riscv/include/asm/pgalloc.h b/arch/riscv/include/asm/pgalloc.h
index d169a4f41a2e..c80bb9990d32 100644
--- a/arch/riscv/include/asm/pgalloc.h
+++ b/arch/riscv/include/asm/pgalloc.h
@@ -95,7 +95,13 @@ static inline void pud_free(struct mm_struct *mm, pud_t *pud)
 		__pud_free(mm, pud);
 }
 
-#define __pud_free_tlb(tlb, pud, addr)  pud_free((tlb)->mm, pud)
+#define __pud_free_tlb(tlb, pud, addr)					\
+do {									\
+	if (pgtable_l4_enabled) {					\
+		pagetable_pud_dtor(virt_to_ptdesc(pud));		\
+		tlb_remove_page_ptdesc((tlb), virt_to_ptdesc(pud));	\
+	}								\
+} while (0)
 
 #define p4d_alloc_one p4d_alloc_one
 static inline p4d_t *p4d_alloc_one(struct mm_struct *mm, unsigned long addr)
@@ -124,7 +130,11 @@ static inline void p4d_free(struct mm_struct *mm, p4d_t *p4d)
 		__p4d_free(mm, p4d);
 }
 
-#define __p4d_free_tlb(tlb, p4d, addr)  p4d_free((tlb)->mm, p4d)
+#define __p4d_free_tlb(tlb, p4d, addr)					\
+do {									\
+	if (pgtable_l5_enabled)						\
+		tlb_remove_page_ptdesc((tlb), virt_to_ptdesc(p4d));	\
+} while (0)
 #endif /* __PAGETABLE_PMD_FOLDED */
 
 static inline void sync_kernel_mappings(pgd_t *pgd)
@@ -149,7 +159,11 @@ static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 
 #ifndef __PAGETABLE_PMD_FOLDED
 
-#define __pmd_free_tlb(tlb, pmd, addr)  pmd_free((tlb)->mm, pmd)
+#define __pmd_free_tlb(tlb, pmd, addr)				\
+do {								\
+	pagetable_pmd_dtor(virt_to_ptdesc(pmd));		\
+	tlb_remove_page_ptdesc((tlb), virt_to_ptdesc(pmd));	\
+} while (0)
 
 #endif /* __PAGETABLE_PMD_FOLDED */
 
diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/pgtable-64.h
index 9a2c780a11e9..783837bbd878 100644
--- a/arch/riscv/include/asm/pgtable-64.h
+++ b/arch/riscv/include/asm/pgtable-64.h
@@ -136,7 +136,7 @@ enum napot_cont_order {
  * 10010 - IO   Strongly-ordered, Non-cacheable, Non-bufferable, Shareable, Non-trustable
  */
 #define _PAGE_PMA_THEAD		((1UL << 62) | (1UL << 61) | (1UL << 60))
-#define _PAGE_NOCACHE_THEAD	((1UL < 61) | (1UL << 60))
+#define _PAGE_NOCACHE_THEAD	((1UL << 61) | (1UL << 60))
 #define _PAGE_IO_THEAD		((1UL << 63) | (1UL << 60))
 #define _PAGE_MTMASK_THEAD	(_PAGE_PMA_THEAD | _PAGE_IO_THEAD | (1UL << 59))
 
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 74ffb2178f54..76b131e7bbca 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -84,7 +84,7 @@
  * Define vmemmap for pfn_to_page & page_to_pfn calls. Needed if kernel
  * is configured with CONFIG_SPARSEMEM_VMEMMAP enabled.
  */
-#define vmemmap		((struct page *)VMEMMAP_START)
+#define vmemmap		((struct page *)VMEMMAP_START - (phys_ram_base >> PAGE_SHIFT))
 
 #define PCI_IO_SIZE      SZ_16M
 #define PCI_IO_END       VMEMMAP_START
@@ -439,6 +439,10 @@ static inline pte_t pte_mkhuge(pte_t pte)
 	return pte;
 }
 
+#define pte_leaf_size(pte)	(pte_napot(pte) ?				\
+					napot_cont_size(napot_cont_order(pte)) :\
+					PAGE_SIZE)
+
 #ifdef CONFIG_NUMA_BALANCING
 /*
  * See the comment in include/asm-generic/pgtable.h
diff --git a/arch/riscv/include/asm/vmalloc.h b/arch/riscv/include/asm/vmalloc.h
index 924d01b56c9a..51f6dfe19745 100644
--- a/arch/riscv/include/asm/vmalloc.h
+++ b/arch/riscv/include/asm/vmalloc.h
@@ -19,65 +19,6 @@ static inline bool arch_vmap_pmd_supported(pgprot_t prot)
 	return true;
 }
 
-#ifdef CONFIG_RISCV_ISA_SVNAPOT
-#include <linux/pgtable.h>
+#endif
 
-#define arch_vmap_pte_range_map_size arch_vmap_pte_range_map_size
-static inline unsigned long arch_vmap_pte_range_map_size(unsigned long addr, unsigned long end,
-							 u64 pfn, unsigned int max_page_shift)
-{
-	unsigned long map_size = PAGE_SIZE;
-	unsigned long size, order;
-
-	if (!has_svnapot())
-		return map_size;
-
-	for_each_napot_order_rev(order) {
-		if (napot_cont_shift(order) > max_page_shift)
-			continue;
-
-		size = napot_cont_size(order);
-		if (end - addr < size)
-			continue;
-
-		if (!IS_ALIGNED(addr, size))
-			continue;
-
-		if (!IS_ALIGNED(PFN_PHYS(pfn), size))
-			continue;
-
-		map_size = size;
-		break;
-	}
-
-	return map_size;
-}
-
-#define arch_vmap_pte_supported_shift arch_vmap_pte_supported_shift
-static inline int arch_vmap_pte_supported_shift(unsigned long size)
-{
-	int shift = PAGE_SHIFT;
-	unsigned long order;
-
-	if (!has_svnapot())
-		return shift;
-
-	WARN_ON_ONCE(size >= PMD_SIZE);
-
-	for_each_napot_order_rev(order) {
-		if (napot_cont_size(order) > size)
-			continue;
-
-		if (!IS_ALIGNED(size, napot_cont_size(order)))
-			continue;
-
-		shift = napot_cont_shift(order);
-		break;
-	}
-
-	return shift;
-}
-
-#endif /* CONFIG_RISCV_ISA_SVNAPOT */
-#endif /* CONFIG_HAVE_ARCH_HUGE_VMAP */
 #endif /* _ASM_RISCV_VMALLOC_H */
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index fee22a3d1b53..40d054939ae2 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -7,6 +7,7 @@ ifdef CONFIG_FTRACE
 CFLAGS_REMOVE_ftrace.o	= $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_patch.o	= $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_sbi.o	= $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_return_address.o	= $(CC_FLAGS_FTRACE)
 endif
 CFLAGS_syscall_table.o	+= $(call cc-option,-Wno-override-init,)
 CFLAGS_compat_syscall_table.o += $(call cc-option,-Wno-override-init,)
@@ -46,6 +47,7 @@ obj-y	+= irq.o
 obj-y	+= process.o
 obj-y	+= ptrace.o
 obj-y	+= reset.o
+obj-y	+= return_address.o
 obj-y	+= setup.o
 obj-y	+= signal.o
 obj-y	+= syscall_table.o
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index b3785ffc1570..867778813353 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -22,6 +22,7 @@
 #include <asm/hwprobe.h>
 #include <asm/patch.h>
 #include <asm/processor.h>
+#include <asm/sbi.h>
 #include <asm/vector.h>
 
 #include "copy-unaligned.h"
@@ -401,6 +402,20 @@ static void __init riscv_fill_hwcap_from_isa_string(unsigned long *isa2hwcap)
 			set_bit(RISCV_ISA_EXT_ZIHPM, isainfo->isa);
 		}
 
+		/*
+		 * "V" in ISA strings is ambiguous in practice: it should mean
+		 * just the standard V-1.0 but vendors aren't well behaved.
+		 * Many vendors with T-Head CPU cores which implement the 0.7.1
+		 * version of the vector specification put "v" into their DTs.
+		 * CPU cores with the ratified spec will contain non-zero
+		 * marchid.
+		 */
+		if (acpi_disabled && riscv_cached_mvendorid(cpu) == THEAD_VENDOR_ID &&
+		    riscv_cached_marchid(cpu) == 0x0) {
+			this_hwcap &= ~isa2hwcap[RISCV_ISA_EXT_v];
+			clear_bit(RISCV_ISA_EXT_v, isainfo->isa);
+		}
+
 		/*
 		 * All "okay" hart should have same isa. Set HWCAP based on
 		 * common capabilities of every "okay" hart, in case they don't
@@ -725,7 +740,7 @@ arch_initcall(check_unaligned_access_all_cpus);
 void riscv_user_isa_enable(void)
 {
 	if (riscv_cpu_has_extension_unlikely(smp_processor_id(), RISCV_ISA_EXT_ZICBOZ))
-		csr_set(CSR_SENVCFG, ENVCFG_CBZE);
+		csr_set(CSR_ENVCFG, ENVCFG_CBZE);
 }
 
 #ifdef CONFIG_RISCV_ALTERNATIVE
diff --git a/arch/riscv/kernel/return_address.c b/arch/riscv/kernel/return_address.c
new file mode 100644
index 000000000000..c8115ec8fb30
--- /dev/null
+++ b/arch/riscv/kernel/return_address.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * This code come from arch/arm64/kernel/return_address.c
+ *
+ * Copyright (C) 2023 SiFive.
+ */
+
+#include <linux/export.h>
+#include <linux/kprobes.h>
+#include <linux/stacktrace.h>
+
+struct return_address_data {
+	unsigned int level;
+	void *addr;
+};
+
+static bool save_return_addr(void *d, unsigned long pc)
+{
+	struct return_address_data *data = d;
+
+	if (!data->level) {
+		data->addr = (void *)pc;
+		return false;
+	}
+
+	--data->level;
+
+	return true;
+}
+NOKPROBE_SYMBOL(save_return_addr);
+
+noinline void *return_address(unsigned int level)
+{
+	struct return_address_data data;
+
+	data.level = level + 3;
+	data.addr = NULL;
+
+	arch_stack_walk(save_return_addr, &data, current, NULL);
+
+	if (!data.level)
+		return data.addr;
+	else
+		return NULL;
+
+}
+EXPORT_SYMBOL_GPL(return_address);
+NOKPROBE_SYMBOL(return_address);
diff --git a/arch/riscv/mm/hugetlbpage.c b/arch/riscv/mm/hugetlbpage.c
index e7b69281875b..fbe918801667 100644
--- a/arch/riscv/mm/hugetlbpage.c
+++ b/arch/riscv/mm/hugetlbpage.c
@@ -426,10 +426,12 @@ bool __init arch_hugetlb_valid_size(unsigned long size)
 	return __hugetlb_valid_size(size);
 }
 
+#ifdef CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION
 bool arch_hugetlb_migration_supported(struct hstate *h)
 {
 	return __hugetlb_valid_size(huge_page_size(h));
 }
+#endif
 
 #ifdef CONFIG_CONTIG_ALLOC
 static __init int gigantic_pages_init(void)
diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index c73047bf9f4b..fba427646805 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -885,6 +885,7 @@ SYM_FUNC_START(entry_SYSENTER_32)
 	BUG_IF_WRONG_CR3 no_user_check=1
 	popfl
 	popl	%eax
+	CLEAR_CPU_BUFFERS
 
 	/*
 	 * Return back to the vDSO, which will pop ecx and edx.
@@ -954,6 +955,7 @@ restore_all_switch_stack:
 
 	/* Restore user state */
 	RESTORE_REGS pop=4			# skip orig_eax/error_code
+	CLEAR_CPU_BUFFERS
 .Lirq_return:
 	/*
 	 * ARCH_HAS_MEMBARRIER_SYNC_CORE rely on IRET core serialization
@@ -1146,6 +1148,7 @@ SYM_CODE_START(asm_exc_nmi)
 
 	/* Not on SYSENTER stack. */
 	call	exc_nmi
+	CLEAR_CPU_BUFFERS
 	jmp	.Lnmi_return
 
 .Lnmi_from_sysenter_stack:
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index de6469dffe3a..bdb17fad5d04 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -161,6 +161,7 @@ syscall_return_via_sysret:
 SYM_INNER_LABEL(entry_SYSRETQ_unsafe_stack, SYM_L_GLOBAL)
 	ANNOTATE_NOENDBR
 	swapgs
+	CLEAR_CPU_BUFFERS
 	sysretq
 SYM_INNER_LABEL(entry_SYSRETQ_end, SYM_L_GLOBAL)
 	ANNOTATE_NOENDBR
@@ -601,6 +602,7 @@ SYM_INNER_LABEL(swapgs_restore_regs_and_return_to_usermode, SYM_L_GLOBAL)
 	/* Restore RDI. */
 	popq	%rdi
 	swapgs
+	CLEAR_CPU_BUFFERS
 	jmp	.Lnative_iret
 
 
@@ -712,6 +714,8 @@ native_irq_return_ldt:
 	 */
 	popq	%rax				/* Restore user RAX */
 
+	CLEAR_CPU_BUFFERS
+
 	/*
 	 * RSP now points to an ordinary IRET frame, except that the page
 	 * is read-only and RSP[31:16] are preloaded with the userspace
@@ -1438,6 +1442,12 @@ nmi_restore:
 	std
 	movq	$0, 5*8(%rsp)		/* clear "NMI executing" */
 
+	/*
+	 * Skip CLEAR_CPU_BUFFERS here, since it only helps in rare cases like
+	 * NMI in kernel after user state is restored. For an unprivileged user
+	 * these conditions are hard to meet.
+	 */
+
 	/*
 	 * iretq reads the "iret" frame and exits the NMI stack in a
 	 * single instruction.  We are returning to kernel mode, so this
@@ -1455,6 +1465,7 @@ SYM_CODE_START(entry_SYSCALL32_ignore)
 	UNWIND_HINT_END_OF_STACK
 	ENDBR
 	mov	$-ENOSYS, %eax
+	CLEAR_CPU_BUFFERS
 	sysretl
 SYM_CODE_END(entry_SYSCALL32_ignore)
 
diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index de94e2e84ecc..eabf48c4d4b4 100644
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -270,6 +270,7 @@ SYM_INNER_LABEL(entry_SYSRETL_compat_unsafe_stack, SYM_L_GLOBAL)
 	xorl	%r9d, %r9d
 	xorl	%r10d, %r10d
 	swapgs
+	CLEAR_CPU_BUFFERS
 	sysretl
 SYM_INNER_LABEL(entry_SYSRETL_compat_end, SYM_L_GLOBAL)
 	ANNOTATE_NOENDBR
diff --git a/arch/x86/include/asm/entry-common.h b/arch/x86/include/asm/entry-common.h
index ce8f50192ae3..7e523bb3d2d3 100644
--- a/arch/x86/include/asm/entry-common.h
+++ b/arch/x86/include/asm/entry-common.h
@@ -91,7 +91,6 @@ static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
 
 static __always_inline void arch_exit_to_user_mode(void)
 {
-	mds_user_clear_cpu_buffers();
 	amd_clear_divider();
 }
 #define arch_exit_to_user_mode arch_exit_to_user_mode
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 2519615936e9..d15b35815eba 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -540,7 +540,6 @@ DECLARE_STATIC_KEY_FALSE(switch_to_cond_stibp);
 DECLARE_STATIC_KEY_FALSE(switch_mm_cond_ibpb);
 DECLARE_STATIC_KEY_FALSE(switch_mm_always_ibpb);
 
-DECLARE_STATIC_KEY_FALSE(mds_user_clear);
 DECLARE_STATIC_KEY_FALSE(mds_idle_clear);
 
 DECLARE_STATIC_KEY_FALSE(switch_mm_cond_l1d_flush);
@@ -574,17 +573,6 @@ static __always_inline void mds_clear_cpu_buffers(void)
 	asm volatile("verw %[ds]" : : [ds] "m" (ds) : "cc");
 }
 
-/**
- * mds_user_clear_cpu_buffers - Mitigation for MDS and TAA vulnerability
- *
- * Clear CPU buffers if the corresponding static key is enabled
- */
-static __always_inline void mds_user_clear_cpu_buffers(void)
-{
-	if (static_branch_likely(&mds_user_clear))
-		mds_clear_cpu_buffers();
-}
-
 /**
  * mds_idle_clear_cpu_buffers - Mitigation for MDS vulnerability
  *
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index bb0ab8466b91..48d049cd74e7 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -111,9 +111,6 @@ DEFINE_STATIC_KEY_FALSE(switch_mm_cond_ibpb);
 /* Control unconditional IBPB in switch_mm() */
 DEFINE_STATIC_KEY_FALSE(switch_mm_always_ibpb);
 
-/* Control MDS CPU buffer clear before returning to user space */
-DEFINE_STATIC_KEY_FALSE(mds_user_clear);
-EXPORT_SYMBOL_GPL(mds_user_clear);
 /* Control MDS CPU buffer clear before idling (halt, mwait) */
 DEFINE_STATIC_KEY_FALSE(mds_idle_clear);
 EXPORT_SYMBOL_GPL(mds_idle_clear);
@@ -252,7 +249,7 @@ static void __init mds_select_mitigation(void)
 		if (!boot_cpu_has(X86_FEATURE_MD_CLEAR))
 			mds_mitigation = MDS_MITIGATION_VMWERV;
 
-		static_branch_enable(&mds_user_clear);
+		setup_force_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF);
 
 		if (!boot_cpu_has(X86_BUG_MSBDS_ONLY) &&
 		    (mds_nosmt || cpu_mitigations_auto_nosmt()))
@@ -356,7 +353,7 @@ static void __init taa_select_mitigation(void)
 	 * For guests that can't determine whether the correct microcode is
 	 * present on host, enable the mitigation for UCODE_NEEDED as well.
 	 */
-	static_branch_enable(&mds_user_clear);
+	setup_force_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF);
 
 	if (taa_nosmt || cpu_mitigations_auto_nosmt())
 		cpu_smt_disable(false);
@@ -424,7 +421,7 @@ static void __init mmio_select_mitigation(void)
 	 */
 	if (boot_cpu_has_bug(X86_BUG_MDS) || (boot_cpu_has_bug(X86_BUG_TAA) &&
 					      boot_cpu_has(X86_FEATURE_RTM)))
-		static_branch_enable(&mds_user_clear);
+		setup_force_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF);
 	else
 		static_branch_enable(&mmio_stale_data_clear);
 
@@ -484,12 +481,12 @@ static void __init md_clear_update_mitigation(void)
 	if (cpu_mitigations_off())
 		return;
 
-	if (!static_key_enabled(&mds_user_clear))
+	if (!boot_cpu_has(X86_FEATURE_CLEAR_CPU_BUF))
 		goto out;
 
 	/*
-	 * mds_user_clear is now enabled. Update MDS, TAA and MMIO Stale Data
-	 * mitigation, if necessary.
+	 * X86_FEATURE_CLEAR_CPU_BUF is now enabled. Update MDS, TAA and MMIO
+	 * Stale Data mitigation, if necessary.
 	 */
 	if (mds_mitigation == MDS_MITIGATION_OFF &&
 	    boot_cpu_has_bug(X86_BUG_MDS)) {
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 98f7ea6b931c..34cac9ea1917 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1596,6 +1596,7 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
 		get_cpu_vendor(c);
 		get_cpu_cap(c);
 		setup_force_cpu_cap(X86_FEATURE_CPUID);
+		get_cpu_address_sizes(c);
 		cpu_parse_early_param();
 
 		if (this_cpu->c_early_init)
@@ -1608,10 +1609,9 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
 			this_cpu->c_bsp_init(c);
 	} else {
 		setup_clear_cpu_cap(X86_FEATURE_CPUID);
+		get_cpu_address_sizes(c);
 	}
 
-	get_cpu_address_sizes(c);
-
 	setup_force_cpu_cap(X86_FEATURE_ALWAYS);
 
 	cpu_set_bug_bits(c);
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index a927a8fc9624..40dec9b56f87 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -184,6 +184,90 @@ static bool bad_spectre_microcode(struct cpuinfo_x86 *c)
 	return false;
 }
 
+#define MSR_IA32_TME_ACTIVATE		0x982
+
+/* Helpers to access TME_ACTIVATE MSR */
+#define TME_ACTIVATE_LOCKED(x)		(x & 0x1)
+#define TME_ACTIVATE_ENABLED(x)		(x & 0x2)
+
+#define TME_ACTIVATE_POLICY(x)		((x >> 4) & 0xf)	/* Bits 7:4 */
+#define TME_ACTIVATE_POLICY_AES_XTS_128	0
+
+#define TME_ACTIVATE_KEYID_BITS(x)	((x >> 32) & 0xf)	/* Bits 35:32 */
+
+#define TME_ACTIVATE_CRYPTO_ALGS(x)	((x >> 48) & 0xffff)	/* Bits 63:48 */
+#define TME_ACTIVATE_CRYPTO_AES_XTS_128	1
+
+/* Values for mktme_status (SW only construct) */
+#define MKTME_ENABLED			0
+#define MKTME_DISABLED			1
+#define MKTME_UNINITIALIZED		2
+static int mktme_status = MKTME_UNINITIALIZED;
+
+static void detect_tme_early(struct cpuinfo_x86 *c)
+{
+	u64 tme_activate, tme_policy, tme_crypto_algs;
+	int keyid_bits = 0, nr_keyids = 0;
+	static u64 tme_activate_cpu0 = 0;
+
+	rdmsrl(MSR_IA32_TME_ACTIVATE, tme_activate);
+
+	if (mktme_status != MKTME_UNINITIALIZED) {
+		if (tme_activate != tme_activate_cpu0) {
+			/* Broken BIOS? */
+			pr_err_once("x86/tme: configuration is inconsistent between CPUs\n");
+			pr_err_once("x86/tme: MKTME is not usable\n");
+			mktme_status = MKTME_DISABLED;
+
+			/* Proceed. We may need to exclude bits from x86_phys_bits. */
+		}
+	} else {
+		tme_activate_cpu0 = tme_activate;
+	}
+
+	if (!TME_ACTIVATE_LOCKED(tme_activate) || !TME_ACTIVATE_ENABLED(tme_activate)) {
+		pr_info_once("x86/tme: not enabled by BIOS\n");
+		mktme_status = MKTME_DISABLED;
+		return;
+	}
+
+	if (mktme_status != MKTME_UNINITIALIZED)
+		goto detect_keyid_bits;
+
+	pr_info("x86/tme: enabled by BIOS\n");
+
+	tme_policy = TME_ACTIVATE_POLICY(tme_activate);
+	if (tme_policy != TME_ACTIVATE_POLICY_AES_XTS_128)
+		pr_warn("x86/tme: Unknown policy is active: %#llx\n", tme_policy);
+
+	tme_crypto_algs = TME_ACTIVATE_CRYPTO_ALGS(tme_activate);
+	if (!(tme_crypto_algs & TME_ACTIVATE_CRYPTO_AES_XTS_128)) {
+		pr_err("x86/mktme: No known encryption algorithm is supported: %#llx\n",
+				tme_crypto_algs);
+		mktme_status = MKTME_DISABLED;
+	}
+detect_keyid_bits:
+	keyid_bits = TME_ACTIVATE_KEYID_BITS(tme_activate);
+	nr_keyids = (1UL << keyid_bits) - 1;
+	if (nr_keyids) {
+		pr_info_once("x86/mktme: enabled by BIOS\n");
+		pr_info_once("x86/mktme: %d KeyIDs available\n", nr_keyids);
+	} else {
+		pr_info_once("x86/mktme: disabled by BIOS\n");
+	}
+
+	if (mktme_status == MKTME_UNINITIALIZED) {
+		/* MKTME is usable */
+		mktme_status = MKTME_ENABLED;
+	}
+
+	/*
+	 * KeyID bits effectively lower the number of physical address
+	 * bits.  Update cpuinfo_x86::x86_phys_bits accordingly.
+	 */
+	c->x86_phys_bits -= keyid_bits;
+}
+
 static void early_init_intel(struct cpuinfo_x86 *c)
 {
 	u64 misc_enable;
@@ -322,6 +406,13 @@ static void early_init_intel(struct cpuinfo_x86 *c)
 	 */
 	if (detect_extended_topology_early(c) < 0)
 		detect_ht_early(c);
+
+	/*
+	 * Adjust the number of physical bits early because it affects the
+	 * valid bits of the MTRR mask registers.
+	 */
+	if (cpu_has(c, X86_FEATURE_TME))
+		detect_tme_early(c);
 }
 
 static void bsp_init_intel(struct cpuinfo_x86 *c)
@@ -482,90 +573,6 @@ static void srat_detect_node(struct cpuinfo_x86 *c)
 #endif
 }
 
-#define MSR_IA32_TME_ACTIVATE		0x982
-
-/* Helpers to access TME_ACTIVATE MSR */
-#define TME_ACTIVATE_LOCKED(x)		(x & 0x1)
-#define TME_ACTIVATE_ENABLED(x)		(x & 0x2)
-
-#define TME_ACTIVATE_POLICY(x)		((x >> 4) & 0xf)	/* Bits 7:4 */
-#define TME_ACTIVATE_POLICY_AES_XTS_128	0
-
-#define TME_ACTIVATE_KEYID_BITS(x)	((x >> 32) & 0xf)	/* Bits 35:32 */
-
-#define TME_ACTIVATE_CRYPTO_ALGS(x)	((x >> 48) & 0xffff)	/* Bits 63:48 */
-#define TME_ACTIVATE_CRYPTO_AES_XTS_128	1
-
-/* Values for mktme_status (SW only construct) */
-#define MKTME_ENABLED			0
-#define MKTME_DISABLED			1
-#define MKTME_UNINITIALIZED		2
-static int mktme_status = MKTME_UNINITIALIZED;
-
-static void detect_tme(struct cpuinfo_x86 *c)
-{
-	u64 tme_activate, tme_policy, tme_crypto_algs;
-	int keyid_bits = 0, nr_keyids = 0;
-	static u64 tme_activate_cpu0 = 0;
-
-	rdmsrl(MSR_IA32_TME_ACTIVATE, tme_activate);
-
-	if (mktme_status != MKTME_UNINITIALIZED) {
-		if (tme_activate != tme_activate_cpu0) {
-			/* Broken BIOS? */
-			pr_err_once("x86/tme: configuration is inconsistent between CPUs\n");
-			pr_err_once("x86/tme: MKTME is not usable\n");
-			mktme_status = MKTME_DISABLED;
-
-			/* Proceed. We may need to exclude bits from x86_phys_bits. */
-		}
-	} else {
-		tme_activate_cpu0 = tme_activate;
-	}
-
-	if (!TME_ACTIVATE_LOCKED(tme_activate) || !TME_ACTIVATE_ENABLED(tme_activate)) {
-		pr_info_once("x86/tme: not enabled by BIOS\n");
-		mktme_status = MKTME_DISABLED;
-		return;
-	}
-
-	if (mktme_status != MKTME_UNINITIALIZED)
-		goto detect_keyid_bits;
-
-	pr_info("x86/tme: enabled by BIOS\n");
-
-	tme_policy = TME_ACTIVATE_POLICY(tme_activate);
-	if (tme_policy != TME_ACTIVATE_POLICY_AES_XTS_128)
-		pr_warn("x86/tme: Unknown policy is active: %#llx\n", tme_policy);
-
-	tme_crypto_algs = TME_ACTIVATE_CRYPTO_ALGS(tme_activate);
-	if (!(tme_crypto_algs & TME_ACTIVATE_CRYPTO_AES_XTS_128)) {
-		pr_err("x86/mktme: No known encryption algorithm is supported: %#llx\n",
-				tme_crypto_algs);
-		mktme_status = MKTME_DISABLED;
-	}
-detect_keyid_bits:
-	keyid_bits = TME_ACTIVATE_KEYID_BITS(tme_activate);
-	nr_keyids = (1UL << keyid_bits) - 1;
-	if (nr_keyids) {
-		pr_info_once("x86/mktme: enabled by BIOS\n");
-		pr_info_once("x86/mktme: %d KeyIDs available\n", nr_keyids);
-	} else {
-		pr_info_once("x86/mktme: disabled by BIOS\n");
-	}
-
-	if (mktme_status == MKTME_UNINITIALIZED) {
-		/* MKTME is usable */
-		mktme_status = MKTME_ENABLED;
-	}
-
-	/*
-	 * KeyID bits effectively lower the number of physical address
-	 * bits.  Update cpuinfo_x86::x86_phys_bits accordingly.
-	 */
-	c->x86_phys_bits -= keyid_bits;
-}
-
 static void init_cpuid_fault(struct cpuinfo_x86 *c)
 {
 	u64 msr;
@@ -702,9 +709,6 @@ static void init_intel(struct cpuinfo_x86 *c)
 
 	init_ia32_feat_ctl(c);
 
-	if (cpu_has(c, X86_FEATURE_TME))
-		detect_tme(c);
-
 	init_intel_misc_features(c);
 
 	split_lock_init();
diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index fb8cf953380d..b66f540de054 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -1017,10 +1017,12 @@ void __init e820__reserve_setup_data(void)
 		e820__range_update(pa_data, sizeof(*data)+data->len, E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
 
 		/*
-		 * SETUP_EFI and SETUP_IMA are supplied by kexec and do not need
-		 * to be reserved.
+		 * SETUP_EFI, SETUP_IMA and SETUP_RNG_SEED are supplied by
+		 * kexec and do not need to be reserved.
 		 */
-		if (data->type != SETUP_EFI && data->type != SETUP_IMA)
+		if (data->type != SETUP_EFI &&
+		    data->type != SETUP_IMA &&
+		    data->type != SETUP_RNG_SEED)
 			e820__range_update_kexec(pa_data,
 						 sizeof(*data) + data->len,
 						 E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index 17e955ab69fe..3082cf24b69e 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -563,9 +563,6 @@ DEFINE_IDTENTRY_RAW(exc_nmi)
 	}
 	if (this_cpu_dec_return(nmi_state))
 		goto nmi_restart;
-
-	if (user_mode(regs))
-		mds_user_clear_cpu_buffers();
 }
 
 #if IS_ENABLED(CONFIG_KVM_INTEL)
diff --git a/arch/x86/kvm/vmx/run_flags.h b/arch/x86/kvm/vmx/run_flags.h
index edc3f16cc189..6a9bfdfbb6e5 100644
--- a/arch/x86/kvm/vmx/run_flags.h
+++ b/arch/x86/kvm/vmx/run_flags.h
@@ -2,7 +2,10 @@
 #ifndef __KVM_X86_VMX_RUN_FLAGS_H
 #define __KVM_X86_VMX_RUN_FLAGS_H
 
-#define VMX_RUN_VMRESUME	(1 << 0)
-#define VMX_RUN_SAVE_SPEC_CTRL	(1 << 1)
+#define VMX_RUN_VMRESUME_SHIFT		0
+#define VMX_RUN_SAVE_SPEC_CTRL_SHIFT	1
+
+#define VMX_RUN_VMRESUME		BIT(VMX_RUN_VMRESUME_SHIFT)
+#define VMX_RUN_SAVE_SPEC_CTRL		BIT(VMX_RUN_SAVE_SPEC_CTRL_SHIFT)
 
 #endif /* __KVM_X86_VMX_RUN_FLAGS_H */
diff --git a/arch/x86/kvm/vmx/vmenter.S b/arch/x86/kvm/vmx/vmenter.S
index be275a0410a8..139960deb736 100644
--- a/arch/x86/kvm/vmx/vmenter.S
+++ b/arch/x86/kvm/vmx/vmenter.S
@@ -139,7 +139,7 @@ SYM_FUNC_START(__vmx_vcpu_run)
 	mov (%_ASM_SP), %_ASM_AX
 
 	/* Check if vmlaunch or vmresume is needed */
-	test $VMX_RUN_VMRESUME, %ebx
+	bt   $VMX_RUN_VMRESUME_SHIFT, %ebx
 
 	/* Load guest registers.  Don't clobber flags. */
 	mov VCPU_RCX(%_ASM_AX), %_ASM_CX
@@ -161,8 +161,11 @@ SYM_FUNC_START(__vmx_vcpu_run)
 	/* Load guest RAX.  This kills the @regs pointer! */
 	mov VCPU_RAX(%_ASM_AX), %_ASM_AX
 
-	/* Check EFLAGS.ZF from 'test VMX_RUN_VMRESUME' above */
-	jz .Lvmlaunch
+	/* Clobbers EFLAGS.ZF */
+	CLEAR_CPU_BUFFERS
+
+	/* Check EFLAGS.CF from the VMX_RUN_VMRESUME bit test above. */
+	jnc .Lvmlaunch
 
 	/*
 	 * After a successful VMRESUME/VMLAUNCH, control flow "magically"
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 94082169bbbc..856eef56b3a8 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -387,7 +387,16 @@ static __always_inline void vmx_enable_fb_clear(struct vcpu_vmx *vmx)
 
 static void vmx_update_fb_clear_dis(struct kvm_vcpu *vcpu, struct vcpu_vmx *vmx)
 {
-	vmx->disable_fb_clear = (host_arch_capabilities & ARCH_CAP_FB_CLEAR_CTRL) &&
+	/*
+	 * Disable VERW's behavior of clearing CPU buffers for the guest if the
+	 * CPU isn't affected by MDS/TAA, and the host hasn't forcefully enabled
+	 * the mitigation. Disabling the clearing behavior provides a
+	 * performance boost for guests that aren't aware that manually clearing
+	 * CPU buffers is unnecessary, at the cost of MSR accesses on VM-Entry
+	 * and VM-Exit.
+	 */
+	vmx->disable_fb_clear = !cpu_feature_enabled(X86_FEATURE_CLEAR_CPU_BUF) &&
+				(host_arch_capabilities & ARCH_CAP_FB_CLEAR_CTRL) &&
 				!boot_cpu_has_bug(X86_BUG_MDS) &&
 				!boot_cpu_has_bug(X86_BUG_TAA);
 
@@ -7226,11 +7235,14 @@ static noinstr void vmx_vcpu_enter_exit(struct kvm_vcpu *vcpu,
 
 	guest_state_enter_irqoff();
 
-	/* L1D Flush includes CPU buffer clear to mitigate MDS */
+	/*
+	 * L1D Flush includes CPU buffer clear to mitigate MDS, but VERW
+	 * mitigation for MDS is done late in VMentry and is still
+	 * executed in spite of L1D Flush. This is because an extra VERW
+	 * should not matter much after the big hammer L1D Flush.
+	 */
 	if (static_branch_unlikely(&vmx_l1d_should_flush))
 		vmx_l1d_flush(vcpu);
-	else if (static_branch_unlikely(&mds_user_clear))
-		mds_clear_cpu_buffers();
 	else if (static_branch_unlikely(&mmio_stale_data_clear) &&
 		 kvm_arch_has_assigned_device(vcpu->kvm))
 		mds_clear_cpu_buffers();
diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index fdb0fae88d1c..b40b32fa7f1c 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -152,7 +152,7 @@ static int qca_send_patch_config_cmd(struct hci_dev *hdev)
 	bt_dev_dbg(hdev, "QCA Patch config");
 
 	skb = __hci_cmd_sync_ev(hdev, EDL_PATCH_CMD_OPCODE, sizeof(cmd),
-				cmd, HCI_EV_VENDOR, HCI_INIT_TIMEOUT);
+				cmd, 0, HCI_INIT_TIMEOUT);
 	if (IS_ERR(skb)) {
 		err = PTR_ERR(skb);
 		bt_dev_err(hdev, "Sending QCA Patch config failed (%d)", err);
diff --git a/drivers/bluetooth/hci_bcm4377.c b/drivers/bluetooth/hci_bcm4377.c
index a61757835695..9a7243d5db71 100644
--- a/drivers/bluetooth/hci_bcm4377.c
+++ b/drivers/bluetooth/hci_bcm4377.c
@@ -1417,7 +1417,7 @@ static int bcm4377_check_bdaddr(struct bcm4377_data *bcm4377)
 
 	bda = (struct hci_rp_read_bd_addr *)skb->data;
 	if (!bcm4377_is_valid_bdaddr(bcm4377, &bda->bdaddr))
-		set_bit(HCI_QUIRK_INVALID_BDADDR, &bcm4377->hdev->quirks);
+		set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &bcm4377->hdev->quirks);
 
 	kfree_skb(skb);
 	return 0;
@@ -2368,7 +2368,6 @@ static int bcm4377_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	hdev->set_bdaddr = bcm4377_hci_set_bdaddr;
 	hdev->setup = bcm4377_hci_setup;
 
-	set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
 	if (bcm4377->hw->broken_mws_transport_config)
 		set_bit(HCI_QUIRK_BROKEN_MWS_TRANSPORT_CONFIG, &hdev->quirks);
 	if (bcm4377->hw->broken_ext_scan)
diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 35f74f209d1f..a65de7309da4 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -7,6 +7,7 @@
  *
  *  Copyright (C) 2007 Texas Instruments, Inc.
  *  Copyright (c) 2010, 2012, 2018 The Linux Foundation. All rights reserved.
+ *  Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
  *
  *  Acknowledgements:
  *  This file is based on hci_ll.c, which was...
@@ -1806,13 +1807,12 @@ static int qca_power_on(struct hci_dev *hdev)
 
 static void hci_coredump_qca(struct hci_dev *hdev)
 {
+	int err;
 	static const u8 param[] = { 0x26 };
-	struct sk_buff *skb;
 
-	skb = __hci_cmd_sync(hdev, 0xfc0c, 1, param, HCI_CMD_TIMEOUT);
-	if (IS_ERR(skb))
-		bt_dev_err(hdev, "%s: trigger crash failed (%ld)", __func__, PTR_ERR(skb));
-	kfree_skb(skb);
+	err = __hci_cmd_send(hdev, 0xfc0c, 1, param);
+	if (err < 0)
+		bt_dev_err(hdev, "%s: trigger crash failed (%d)", __func__, err);
 }
 
 static int qca_setup(struct hci_uart *hu)
@@ -1886,7 +1886,17 @@ static int qca_setup(struct hci_uart *hu)
 	case QCA_WCN6750:
 	case QCA_WCN6855:
 	case QCA_WCN7850:
-		set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
+
+		/* Set BDA quirk bit for reading BDA value from fwnode property
+		 * only if that property exist in DT.
+		 */
+		if (fwnode_property_present(dev_fwnode(hdev->dev.parent), "local-bd-address")) {
+			set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
+			bt_dev_info(hdev, "setting quirk bit to read BDA from fwnode later");
+		} else {
+			bt_dev_dbg(hdev, "local-bd-address` is not present in the devicetree so not setting quirk bit for BDA");
+		}
+
 		hci_set_aosp_capable(hdev);
 
 		ret = qca_read_soc_version(hdev, &ver, soc_type);
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index f5c69fa230d9..357e01a27274 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2983,6 +2983,9 @@ static void intel_cpufreq_adjust_perf(unsigned int cpunum,
 	if (min_pstate < cpu->min_perf_ratio)
 		min_pstate = cpu->min_perf_ratio;
 
+	if (min_pstate > cpu->max_perf_ratio)
+		min_pstate = cpu->max_perf_ratio;
+
 	max_pstate = min(cap_pstate, cpu->max_perf_ratio);
 	if (max_pstate < min_pstate)
 		max_pstate = min_pstate;
diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index b38786f0ad79..b75fdaffad9a 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -346,6 +346,20 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 	dw_edma_v0_write_ll_link(chunk, i, control, chunk->ll_region.paddr);
 }
 
+static void dw_edma_v0_sync_ll_data(struct dw_edma_chunk *chunk)
+{
+	/*
+	 * In case of remote eDMA engine setup, the DW PCIe RP/EP internal
+	 * configuration registers and application memory are normally accessed
+	 * over different buses. Ensure LL-data reaches the memory before the
+	 * doorbell register is toggled by issuing the dummy-read from the remote
+	 * LL memory in a hope that the MRd TLP will return only after the
+	 * last MWr TLP is completed
+	 */
+	if (!(chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
+		readl(chunk->ll_region.vaddr.io);
+}
+
 static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 {
 	struct dw_edma_chan *chan = chunk->chan;
@@ -412,6 +426,9 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 		SET_CH_32(dw, chan->dir, chan->id, llp.msb,
 			  upper_32_bits(chunk->ll_region.paddr));
 	}
+
+	dw_edma_v0_sync_ll_data(chunk);
+
 	/* Doorbell */
 	SET_RW_32(dw, chan->dir, doorbell,
 		  FIELD_PREP(EDMA_V0_DOORBELL_CH_MASK, chan->id));
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index 00b735a0202a..10e8f0715114 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -65,18 +65,12 @@ static void dw_hdma_v0_core_off(struct dw_edma *dw)
 
 static u16 dw_hdma_v0_core_ch_count(struct dw_edma *dw, enum dw_edma_dir dir)
 {
-	u32 num_ch = 0;
-	int id;
-
-	for (id = 0; id < HDMA_V0_MAX_NR_CH; id++) {
-		if (GET_CH_32(dw, id, dir, ch_en) & BIT(0))
-			num_ch++;
-	}
-
-	if (num_ch > HDMA_V0_MAX_NR_CH)
-		num_ch = HDMA_V0_MAX_NR_CH;
-
-	return (u16)num_ch;
+	/*
+	 * The HDMA IP have no way to know the number of hardware channels
+	 * available, we set it to maximum channels and let the platform
+	 * set the right number of channels.
+	 */
+	return HDMA_V0_MAX_NR_CH;
 }
 
 static enum dma_status dw_hdma_v0_core_ch_status(struct dw_edma_chan *chan)
@@ -228,6 +222,20 @@ static void dw_hdma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 	dw_hdma_v0_write_ll_link(chunk, i, control, chunk->ll_region.paddr);
 }
 
+static void dw_hdma_v0_sync_ll_data(struct dw_edma_chunk *chunk)
+{
+	/*
+	 * In case of remote HDMA engine setup, the DW PCIe RP/EP internal
+	 * configuration registers and application memory are normally accessed
+	 * over different buses. Ensure LL-data reaches the memory before the
+	 * doorbell register is toggled by issuing the dummy-read from the remote
+	 * LL memory in a hope that the MRd TLP will return only after the
+	 * last MWr TLP is completed
+	 */
+	if (!(chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
+		readl(chunk->ll_region.vaddr.io);
+}
+
 static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 {
 	struct dw_edma_chan *chan = chunk->chan;
@@ -242,7 +250,9 @@ static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 		/* Interrupt enable&unmask - done, abort */
 		tmp = GET_CH_32(dw, chan->dir, chan->id, int_setup) |
 		      HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK |
-		      HDMA_V0_LOCAL_STOP_INT_EN | HDMA_V0_LOCAL_STOP_INT_EN;
+		      HDMA_V0_LOCAL_STOP_INT_EN | HDMA_V0_LOCAL_ABORT_INT_EN;
+		if (!(dw->chip->flags & DW_EDMA_CHIP_LOCAL))
+			tmp |= HDMA_V0_REMOTE_STOP_INT_EN | HDMA_V0_REMOTE_ABORT_INT_EN;
 		SET_CH_32(dw, chan->dir, chan->id, int_setup, tmp);
 		/* Channel control */
 		SET_CH_32(dw, chan->dir, chan->id, control1, HDMA_V0_LINKLIST_EN);
@@ -256,6 +266,9 @@ static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 	/* Set consumer cycle */
 	SET_CH_32(dw, chan->dir, chan->id, cycle_sync,
 		  HDMA_V0_CONSUMER_CYCLE_STAT | HDMA_V0_CONSUMER_CYCLE_BIT);
+
+	dw_hdma_v0_sync_ll_data(chunk);
+
 	/* Doorbell */
 	SET_CH_32(dw, chan->dir, chan->id, doorbell, HDMA_V0_DOORBELL_START);
 }
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-regs.h b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
index a974abdf8aaf..eab5fd7177e5 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-regs.h
+++ b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
@@ -15,7 +15,7 @@
 #define HDMA_V0_LOCAL_ABORT_INT_EN		BIT(6)
 #define HDMA_V0_REMOTE_ABORT_INT_EN		BIT(5)
 #define HDMA_V0_LOCAL_STOP_INT_EN		BIT(4)
-#define HDMA_V0_REMOTEL_STOP_INT_EN		BIT(3)
+#define HDMA_V0_REMOTE_STOP_INT_EN		BIT(3)
 #define HDMA_V0_ABORT_INT_MASK			BIT(2)
 #define HDMA_V0_STOP_INT_MASK			BIT(0)
 #define HDMA_V0_LINKLIST_EN			BIT(0)
diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index b53f46245c37..793f1a7ad5e3 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -503,7 +503,7 @@ void fsl_edma_fill_tcd(struct fsl_edma_chan *fsl_chan,
 	if (fsl_chan->is_multi_fifo) {
 		/* set mloff to support multiple fifo */
 		burst = cfg->direction == DMA_DEV_TO_MEM ?
-				cfg->src_addr_width : cfg->dst_addr_width;
+				cfg->src_maxburst : cfg->dst_maxburst;
 		nbytes |= EDMA_V3_TCD_NBYTES_MLOFF(-(burst * 4));
 		/* enable DMLOE/SMLOE */
 		if (cfg->direction == DMA_MEM_TO_DEV) {
diff --git a/drivers/dma/fsl-qdma.c b/drivers/dma/fsl-qdma.c
index 9b141369bea5..7a24279318e6 100644
--- a/drivers/dma/fsl-qdma.c
+++ b/drivers/dma/fsl-qdma.c
@@ -109,6 +109,7 @@
 #define FSL_QDMA_CMD_WTHROTL_OFFSET	20
 #define FSL_QDMA_CMD_DSEN_OFFSET	19
 #define FSL_QDMA_CMD_LWC_OFFSET		16
+#define FSL_QDMA_CMD_PF			BIT(17)
 
 /* Field definition for Descriptor status */
 #define QDMA_CCDF_STATUS_RTE		BIT(5)
@@ -384,7 +385,8 @@ static void fsl_qdma_comp_fill_memcpy(struct fsl_qdma_comp *fsl_comp,
 	qdma_csgf_set_f(csgf_dest, len);
 	/* Descriptor Buffer */
 	cmd = cpu_to_le32(FSL_QDMA_CMD_RWTTYPE <<
-			  FSL_QDMA_CMD_RWTTYPE_OFFSET);
+			  FSL_QDMA_CMD_RWTTYPE_OFFSET) |
+			  FSL_QDMA_CMD_PF;
 	sdf->data = QDMA_SDDF_CMD(cmd);
 
 	cmd = cpu_to_le32(FSL_QDMA_CMD_RWTTYPE <<
@@ -1197,10 +1199,6 @@ static int fsl_qdma_probe(struct platform_device *pdev)
 	if (!fsl_qdma->queue)
 		return -ENOMEM;
 
-	ret = fsl_qdma_irq_init(pdev, fsl_qdma);
-	if (ret)
-		return ret;
-
 	fsl_qdma->irq_base = platform_get_irq_byname(pdev, "qdma-queue0");
 	if (fsl_qdma->irq_base < 0)
 		return fsl_qdma->irq_base;
@@ -1239,16 +1237,19 @@ static int fsl_qdma_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, fsl_qdma);
 
-	ret = dma_async_device_register(&fsl_qdma->dma_dev);
+	ret = fsl_qdma_reg_init(fsl_qdma);
 	if (ret) {
-		dev_err(&pdev->dev,
-			"Can't register NXP Layerscape qDMA engine.\n");
+		dev_err(&pdev->dev, "Can't Initialize the qDMA engine.\n");
 		return ret;
 	}
 
-	ret = fsl_qdma_reg_init(fsl_qdma);
+	ret = fsl_qdma_irq_init(pdev, fsl_qdma);
+	if (ret)
+		return ret;
+
+	ret = dma_async_device_register(&fsl_qdma->dma_dev);
 	if (ret) {
-		dev_err(&pdev->dev, "Can't Initialize the qDMA engine.\n");
+		dev_err(&pdev->dev, "Can't register NXP Layerscape qDMA engine.\n");
 		return ret;
 	}
 
diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
index 0423655f5a88..3dd25a9a04f1 100644
--- a/drivers/dma/idxd/cdev.c
+++ b/drivers/dma/idxd/cdev.c
@@ -345,7 +345,7 @@ static void idxd_cdev_evl_drain_pasid(struct idxd_wq *wq, u32 pasid)
 	spin_lock(&evl->lock);
 	status.bits = ioread64(idxd->reg_base + IDXD_EVLSTATUS_OFFSET);
 	t = status.tail;
-	h = evl->head;
+	h = status.head;
 	size = evl->size;
 
 	while (h != t) {
diff --git a/drivers/dma/idxd/debugfs.c b/drivers/dma/idxd/debugfs.c
index 9cfbd9b14c4c..f3f25ee676f3 100644
--- a/drivers/dma/idxd/debugfs.c
+++ b/drivers/dma/idxd/debugfs.c
@@ -68,9 +68,9 @@ static int debugfs_evl_show(struct seq_file *s, void *d)
 
 	spin_lock(&evl->lock);
 
-	h = evl->head;
 	evl_status.bits = ioread64(idxd->reg_base + IDXD_EVLSTATUS_OFFSET);
 	t = evl_status.tail;
+	h = evl_status.head;
 	evl_size = evl->size;
 
 	seq_printf(s, "Event Log head %u tail %u interrupt pending %u\n\n",
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 1e89c80a07fc..96062ae39f9a 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -290,7 +290,6 @@ struct idxd_evl {
 	unsigned int log_size;
 	/* The number of entries in the event log. */
 	u16 size;
-	u16 head;
 	unsigned long *bmap;
 	bool batch_fail[IDXD_MAX_BATCH_IDENT];
 };
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 0eb1c827a215..d09a8553ea71 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -342,7 +342,9 @@ static void idxd_cleanup_internals(struct idxd_device *idxd)
 static int idxd_init_evl(struct idxd_device *idxd)
 {
 	struct device *dev = &idxd->pdev->dev;
+	unsigned int evl_cache_size;
 	struct idxd_evl *evl;
+	const char *idxd_name;
 
 	if (idxd->hw.gen_cap.evl_support == 0)
 		return 0;
@@ -354,9 +356,16 @@ static int idxd_init_evl(struct idxd_device *idxd)
 	spin_lock_init(&evl->lock);
 	evl->size = IDXD_EVL_SIZE_MIN;
 
-	idxd->evl_cache = kmem_cache_create(dev_name(idxd_confdev(idxd)),
-					    sizeof(struct idxd_evl_fault) + evl_ent_size(idxd),
-					    0, 0, NULL);
+	idxd_name = dev_name(idxd_confdev(idxd));
+	evl_cache_size = sizeof(struct idxd_evl_fault) + evl_ent_size(idxd);
+	/*
+	 * Since completion record in evl_cache will be copied to user
+	 * when handling completion record page fault, need to create
+	 * the cache suitable for user copy.
+	 */
+	idxd->evl_cache = kmem_cache_create_usercopy(idxd_name, evl_cache_size,
+						     0, 0, 0, evl_cache_size,
+						     NULL);
 	if (!idxd->evl_cache) {
 		kfree(evl);
 		return -ENOMEM;
diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
index 2183d7f9cdbd..3bdfc1797f62 100644
--- a/drivers/dma/idxd/irq.c
+++ b/drivers/dma/idxd/irq.c
@@ -367,9 +367,9 @@ static void process_evl_entries(struct idxd_device *idxd)
 	/* Clear interrupt pending bit */
 	iowrite32(evl_status.bits_upper32,
 		  idxd->reg_base + IDXD_EVLSTATUS_OFFSET + sizeof(u32));
-	h = evl->head;
 	evl_status.bits = ioread64(idxd->reg_base + IDXD_EVLSTATUS_OFFSET);
 	t = evl_status.tail;
+	h = evl_status.head;
 	size = idxd->evl->size;
 
 	while (h != t) {
@@ -378,7 +378,6 @@ static void process_evl_entries(struct idxd_device *idxd)
 		h = (h + 1) % size;
 	}
 
-	evl->head = h;
 	evl_status.head = h;
 	iowrite32(evl_status.bits_lower32, idxd->reg_base + IDXD_EVLSTATUS_OFFSET);
 	spin_unlock(&evl->lock);
diff --git a/drivers/dma/ptdma/ptdma-dmaengine.c b/drivers/dma/ptdma/ptdma-dmaengine.c
index 1aa65e5de0f3..f79240734807 100644
--- a/drivers/dma/ptdma/ptdma-dmaengine.c
+++ b/drivers/dma/ptdma/ptdma-dmaengine.c
@@ -385,8 +385,6 @@ int pt_dmaengine_register(struct pt_device *pt)
 	chan->vc.desc_free = pt_do_cleanup;
 	vchan_init(&chan->vc, dma_dev);
 
-	dma_set_mask_and_coherent(pt->dev, DMA_BIT_MASK(64));
-
 	ret = dma_async_device_register(dma_dev);
 	if (ret)
 		goto err_reg;
diff --git a/drivers/firmware/efi/capsule-loader.c b/drivers/firmware/efi/capsule-loader.c
index 3e8d4b51a814..97bafb5f7038 100644
--- a/drivers/firmware/efi/capsule-loader.c
+++ b/drivers/firmware/efi/capsule-loader.c
@@ -292,7 +292,7 @@ static int efi_capsule_open(struct inode *inode, struct file *file)
 		return -ENOMEM;
 	}
 
-	cap_info->phys = kzalloc(sizeof(void *), GFP_KERNEL);
+	cap_info->phys = kzalloc(sizeof(phys_addr_t), GFP_KERNEL);
 	if (!cap_info->phys) {
 		kfree(cap_info->pages);
 		kfree(cap_info);
diff --git a/drivers/gpio/gpio-74x164.c b/drivers/gpio/gpio-74x164.c
index e00c33310517..753e7be039e4 100644
--- a/drivers/gpio/gpio-74x164.c
+++ b/drivers/gpio/gpio-74x164.c
@@ -127,8 +127,6 @@ static int gen_74x164_probe(struct spi_device *spi)
 	if (IS_ERR(chip->gpiod_oe))
 		return PTR_ERR(chip->gpiod_oe);
 
-	gpiod_set_value_cansleep(chip->gpiod_oe, 1);
-
 	spi_set_drvdata(spi, chip);
 
 	chip->gpio_chip.label = spi->modalias;
@@ -153,6 +151,8 @@ static int gen_74x164_probe(struct spi_device *spi)
 		goto exit_destroy;
 	}
 
+	gpiod_set_value_cansleep(chip->gpiod_oe, 1);
+
 	ret = gpiochip_add_data(&chip->gpio_chip, chip);
 	if (!ret)
 		return 0;
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 15de124d5b40..1d033106cf39 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -972,11 +972,11 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 
 	ret = gpiochip_irqchip_init_valid_mask(gc);
 	if (ret)
-		goto err_remove_acpi_chip;
+		goto err_free_hogs;
 
 	ret = gpiochip_irqchip_init_hw(gc);
 	if (ret)
-		goto err_remove_acpi_chip;
+		goto err_remove_irqchip_mask;
 
 	ret = gpiochip_add_irqchip(gc, lock_key, request_key);
 	if (ret)
@@ -1001,13 +1001,13 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 	gpiochip_irqchip_remove(gc);
 err_remove_irqchip_mask:
 	gpiochip_irqchip_free_valid_mask(gc);
-err_remove_acpi_chip:
+err_free_hogs:
+	gpiochip_free_hogs(gc);
 	acpi_gpiochip_remove(gc);
+	gpiochip_remove_pin_ranges(gc);
 err_remove_of_chip:
-	gpiochip_free_hogs(gc);
 	of_gpiochip_remove(gc);
 err_free_gpiochip_mask:
-	gpiochip_remove_pin_ranges(gc);
 	gpiochip_free_valid_mask(gc);
 	if (gdev->dev.release) {
 		/* release() has been registered by gpiochip_setup_dev() */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 4fad9c478c8a..7a09a72e182f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -66,6 +66,8 @@ static void apply_edid_quirks(struct edid *edid, struct dc_edid_caps *edid_caps)
 	/* Workaround for some monitors that do not clear DPCD 0x317 if FreeSync is unsupported */
 	case drm_edid_encode_panel_id('A', 'U', 'O', 0xA7AB):
 	case drm_edid_encode_panel_id('A', 'U', 'O', 0xE69B):
+	case drm_edid_encode_panel_id('B', 'O', 'E', 0x092A):
+	case drm_edid_encode_panel_id('L', 'G', 'D', 0x06D1):
 		DRM_DEBUG_DRIVER("Clearing DPCD 0x317 on monitor with panel id %X\n", panel_id);
 		edid_caps->panel_patch.remove_sink_ext_caps = true;
 		break;
@@ -119,6 +121,8 @@ enum dc_edid_status dm_helpers_parse_edid_caps(
 
 	edid_caps->edid_hdmi = connector->display_info.is_hdmi;
 
+	apply_edid_quirks(edid_buf, edid_caps);
+
 	sad_count = drm_edid_to_sad((struct edid *) edid->raw_edid, &sads);
 	if (sad_count <= 0)
 		return result;
@@ -145,8 +149,6 @@ enum dc_edid_status dm_helpers_parse_edid_caps(
 	else
 		edid_caps->speaker_flags = DEFAULT_SPEAKER_LOCATION;
 
-	apply_edid_quirks(edid_buf, edid_caps);
-
 	kfree(sads);
 	kfree(sadb);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
index 8f231418870f..c62b61ac45d2 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
@@ -76,6 +76,11 @@ static void map_hw_resources(struct dml2_context *dml2,
 			in_out_display_cfg->hw.DLGRefClkFreqMHz = 50;
 		}
 		for (j = 0; j < mode_support_info->DPPPerSurface[i]; j++) {
+			if (i >= __DML2_WRAPPER_MAX_STREAMS_PLANES__) {
+				dml_print("DML::%s: Index out of bounds: i=%d, __DML2_WRAPPER_MAX_STREAMS_PLANES__=%d\n",
+					  __func__, i, __DML2_WRAPPER_MAX_STREAMS_PLANES__);
+				break;
+			}
 			dml2->v20.scratch.dml_to_dc_pipe_mapping.dml_pipe_idx_to_stream_id[num_pipes] = dml2->v20.scratch.dml_to_dc_pipe_mapping.disp_cfg_to_stream_id[i];
 			dml2->v20.scratch.dml_to_dc_pipe_mapping.dml_pipe_idx_to_stream_id_valid[num_pipes] = true;
 			dml2->v20.scratch.dml_to_dc_pipe_mapping.dml_pipe_idx_to_plane_id[num_pipes] = dml2->v20.scratch.dml_to_dc_pipe_mapping.disp_cfg_to_plane_id[i];
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
index df4f20293c16..eb4da3666e05 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -6925,6 +6925,23 @@ static int si_dpm_enable(struct amdgpu_device *adev)
 	return 0;
 }
 
+static int si_set_temperature_range(struct amdgpu_device *adev)
+{
+	int ret;
+
+	ret = si_thermal_enable_alert(adev, false);
+	if (ret)
+		return ret;
+	ret = si_thermal_set_temperature_range(adev, R600_TEMP_RANGE_MIN, R600_TEMP_RANGE_MAX);
+	if (ret)
+		return ret;
+	ret = si_thermal_enable_alert(adev, true);
+	if (ret)
+		return ret;
+
+	return ret;
+}
+
 static void si_dpm_disable(struct amdgpu_device *adev)
 {
 	struct rv7xx_power_info *pi = rv770_get_pi(adev);
@@ -7608,6 +7625,18 @@ static int si_dpm_process_interrupt(struct amdgpu_device *adev,
 
 static int si_dpm_late_init(void *handle)
 {
+	int ret;
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	if (!adev->pm.dpm_enabled)
+		return 0;
+
+	ret = si_set_temperature_range(adev);
+	if (ret)
+		return ret;
+#if 0 //TODO ?
+	si_dpm_powergate_uvd(adev, true);
+#endif
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 2cb6b68222ba..b9c5398cb986 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1303,13 +1303,12 @@ static int arcturus_get_power_limit(struct smu_context *smu,
 	if (default_power_limit)
 		*default_power_limit = power_limit;
 
-	if (smu->od_enabled) {
+	if (smu->od_enabled)
 		od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
-		od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
-	} else {
+	else
 		od_percent_upper = 0;
-		od_percent_lower = 100;
-	}
+
+	od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
 
 	dev_dbg(smu->adev->dev, "od percent upper:%d, od percent lower:%d (default power: %d)\n",
 							od_percent_upper, od_percent_lower, power_limit);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index a38233cc5b7f..aefe72c8abd2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2357,13 +2357,12 @@ static int navi10_get_power_limit(struct smu_context *smu,
 		*default_power_limit = power_limit;
 
 	if (smu->od_enabled &&
-		    navi10_od_feature_is_supported(od_settings, SMU_11_0_ODCAP_POWER_LIMIT)) {
+		    navi10_od_feature_is_supported(od_settings, SMU_11_0_ODCAP_POWER_LIMIT))
 		od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
-		od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
-	} else {
+	else
 		od_percent_upper = 0;
-		od_percent_lower = 100;
-	}
+
+	od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
 
 	dev_dbg(smu->adev->dev, "od percent upper:%d, od percent lower:%d (default power: %d)\n",
 					od_percent_upper, od_percent_lower, power_limit);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 1de9f8b5cc5f..fa953d444548 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -640,13 +640,12 @@ static int sienna_cichlid_get_power_limit(struct smu_context *smu,
 	if (default_power_limit)
 		*default_power_limit = power_limit;
 
-	if (smu->od_enabled) {
+	if (smu->od_enabled)
 		od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_7_ODSETTING_POWERPERCENTAGE]);
-		od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_11_0_7_ODSETTING_POWERPERCENTAGE]);
-	} else {
+	else
 		od_percent_upper = 0;
-		od_percent_lower = 100;
-	}
+
+	od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_11_0_7_ODSETTING_POWERPERCENTAGE]);
 
 	dev_dbg(smu->adev->dev, "od percent upper:%d, od percent lower:%d (default power: %d)\n",
 					od_percent_upper, od_percent_lower, power_limit);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 5625a6e5702a..ac3c9e0966ed 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2364,13 +2364,12 @@ static int smu_v13_0_0_get_power_limit(struct smu_context *smu,
 	if (default_power_limit)
 		*default_power_limit = power_limit;
 
-	if (smu->od_enabled) {
+	if (smu->od_enabled)
 		od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_13_0_0_ODSETTING_POWERPERCENTAGE]);
-		od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_13_0_0_ODSETTING_POWERPERCENTAGE]);
-	} else {
+	else
 		od_percent_upper = 0;
-		od_percent_lower = 100;
-	}
+
+	od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_13_0_0_ODSETTING_POWERPERCENTAGE]);
 
 	dev_dbg(smu->adev->dev, "od percent upper:%d, od percent lower:%d (default power: %d)\n",
 					od_percent_upper, od_percent_lower, power_limit);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index bc5891c3f648..b296c5f9d98d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -2328,13 +2328,12 @@ static int smu_v13_0_7_get_power_limit(struct smu_context *smu,
 	if (default_power_limit)
 		*default_power_limit = power_limit;
 
-	if (smu->od_enabled) {
+	if (smu->od_enabled)
 		od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_13_0_7_ODSETTING_POWERPERCENTAGE]);
-		od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_13_0_7_ODSETTING_POWERPERCENTAGE]);
-	} else {
+	else
 		od_percent_upper = 0;
-		od_percent_lower = 100;
-	}
+
+	od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_13_0_7_ODSETTING_POWERPERCENTAGE]);
 
 	dev_dbg(smu->adev->dev, "od percent upper:%d, od percent lower:%d (default power: %d)\n",
 					od_percent_upper, od_percent_lower, power_limit);
diff --git a/drivers/gpu/drm/drm_buddy.c b/drivers/gpu/drm/drm_buddy.c
index c4222b886db7..f3a6ac908f81 100644
--- a/drivers/gpu/drm/drm_buddy.c
+++ b/drivers/gpu/drm/drm_buddy.c
@@ -332,6 +332,7 @@ alloc_range_bias(struct drm_buddy *mm,
 		 u64 start, u64 end,
 		 unsigned int order)
 {
+	u64 req_size = mm->chunk_size << order;
 	struct drm_buddy_block *block;
 	struct drm_buddy_block *buddy;
 	LIST_HEAD(dfs);
@@ -367,6 +368,15 @@ alloc_range_bias(struct drm_buddy *mm,
 		if (drm_buddy_block_is_allocated(block))
 			continue;
 
+		if (block_start < start || block_end > end) {
+			u64 adjusted_start = max(block_start, start);
+			u64 adjusted_end = min(block_end, end);
+
+			if (round_down(adjusted_end + 1, req_size) <=
+			    round_up(adjusted_start, req_size))
+				continue;
+		}
+
 		if (contains(start, end, block_start, block_end) &&
 		    order == drm_buddy_block_order(block)) {
 			/*
diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index 50589f982d1a..75545da9d1e9 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -708,10 +708,11 @@ nouveau_drm_device_fini(struct drm_device *dev)
 	}
 	mutex_unlock(&drm->clients_lock);
 
-	nouveau_sched_fini(drm);
-
 	nouveau_cli_fini(&drm->client);
 	nouveau_cli_fini(&drm->master);
+
+	nouveau_sched_fini(drm);
+
 	nvif_parent_dtor(&drm->parent);
 	mutex_destroy(&drm->clients_lock);
 	kfree(drm);
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c
index a41735ab6068..d66fc3570642 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c
@@ -1054,8 +1054,6 @@ r535_gsp_postinit(struct nvkm_gsp *gsp)
 	/* Release the DMA buffers that were needed only for boot and init */
 	nvkm_gsp_mem_dtor(gsp, &gsp->boot.fw);
 	nvkm_gsp_mem_dtor(gsp, &gsp->libos);
-	nvkm_gsp_mem_dtor(gsp, &gsp->rmargs);
-	nvkm_gsp_mem_dtor(gsp, &gsp->wpr_meta);
 
 	return ret;
 }
@@ -2163,6 +2161,8 @@ r535_gsp_dtor(struct nvkm_gsp *gsp)
 
 	r535_gsp_dtor_fws(gsp);
 
+	nvkm_gsp_mem_dtor(gsp, &gsp->rmargs);
+	nvkm_gsp_mem_dtor(gsp, &gsp->wpr_meta);
 	nvkm_gsp_mem_dtor(gsp, &gsp->shm.mem);
 	nvkm_gsp_mem_dtor(gsp, &gsp->loginit);
 	nvkm_gsp_mem_dtor(gsp, &gsp->logintr);
diff --git a/drivers/gpu/drm/tegra/drm.c b/drivers/gpu/drm/tegra/drm.c
index ff36171c8fb7..373bcd79257e 100644
--- a/drivers/gpu/drm/tegra/drm.c
+++ b/drivers/gpu/drm/tegra/drm.c
@@ -1242,9 +1242,26 @@ static int host1x_drm_probe(struct host1x_device *dev)
 
 	drm_mode_config_reset(drm);
 
-	err = drm_aperture_remove_framebuffers(&tegra_drm_driver);
-	if (err < 0)
-		goto hub;
+	/*
+	 * Only take over from a potential firmware framebuffer if any CRTCs
+	 * have been registered. This must not be a fatal error because there
+	 * are other accelerators that are exposed via this driver.
+	 *
+	 * Another case where this happens is on Tegra234 where the display
+	 * hardware is no longer part of the host1x complex, so this driver
+	 * will not expose any modesetting features.
+	 */
+	if (drm->mode_config.num_crtc > 0) {
+		err = drm_aperture_remove_framebuffers(&tegra_drm_driver);
+		if (err < 0)
+			goto hub;
+	} else {
+		/*
+		 * Indicate to userspace that this doesn't expose any display
+		 * capabilities.
+		 */
+		drm->driver_features &= ~(DRIVER_MODESET | DRIVER_ATOMIC);
+	}
 
 	err = drm_dev_register(drm, 0);
 	if (err < 0)
diff --git a/drivers/gpu/host1x/dev.c b/drivers/gpu/host1x/dev.c
index 42fd504abbcd..89983d7d73ca 100644
--- a/drivers/gpu/host1x/dev.c
+++ b/drivers/gpu/host1x/dev.c
@@ -169,6 +169,7 @@ static const struct host1x_info host1x06_info = {
 	.num_sid_entries = ARRAY_SIZE(tegra186_sid_table),
 	.sid_table = tegra186_sid_table,
 	.reserve_vblank_syncpts = false,
+	.skip_reset_assert = true,
 };
 
 static const struct host1x_sid_entry tegra194_sid_table[] = {
@@ -680,13 +681,15 @@ static int __maybe_unused host1x_runtime_suspend(struct device *dev)
 	host1x_intr_stop(host);
 	host1x_syncpt_save(host);
 
-	err = reset_control_bulk_assert(host->nresets, host->resets);
-	if (err) {
-		dev_err(dev, "failed to assert reset: %d\n", err);
-		goto resume_host1x;
-	}
+	if (!host->info->skip_reset_assert) {
+		err = reset_control_bulk_assert(host->nresets, host->resets);
+		if (err) {
+			dev_err(dev, "failed to assert reset: %d\n", err);
+			goto resume_host1x;
+		}
 
-	usleep_range(1000, 2000);
+		usleep_range(1000, 2000);
+	}
 
 	clk_disable_unprepare(host->clk);
 	reset_control_bulk_release(host->nresets, host->resets);
diff --git a/drivers/gpu/host1x/dev.h b/drivers/gpu/host1x/dev.h
index c8e302de7625..925a118db23f 100644
--- a/drivers/gpu/host1x/dev.h
+++ b/drivers/gpu/host1x/dev.h
@@ -116,6 +116,12 @@ struct host1x_info {
 	 * the display driver disables VBLANK increments.
 	 */
 	bool reserve_vblank_syncpts;
+	/*
+	 * On Tegra186, secure world applications may require access to
+	 * host1x during suspend/resume. To allow this, we need to leave
+	 * host1x not in reset.
+	 */
+	bool skip_reset_assert;
 };
 
 struct host1x {
diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
index 504ac1b01b2d..05fd9d3abf1b 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -1330,20 +1330,23 @@ int iopt_disable_large_pages(struct io_pagetable *iopt)
 
 int iopt_add_access(struct io_pagetable *iopt, struct iommufd_access *access)
 {
+	u32 new_id;
 	int rc;
 
 	down_write(&iopt->domains_rwsem);
 	down_write(&iopt->iova_rwsem);
-	rc = xa_alloc(&iopt->access_list, &access->iopt_access_list_id, access,
-		      xa_limit_16b, GFP_KERNEL_ACCOUNT);
+	rc = xa_alloc(&iopt->access_list, &new_id, access, xa_limit_16b,
+		      GFP_KERNEL_ACCOUNT);
+
 	if (rc)
 		goto out_unlock;
 
 	rc = iopt_calculate_iova_alignment(iopt);
 	if (rc) {
-		xa_erase(&iopt->access_list, access->iopt_access_list_id);
+		xa_erase(&iopt->access_list, new_id);
 		goto out_unlock;
 	}
+	access->iopt_access_list_id = new_id;
 
 out_unlock:
 	up_write(&iopt->iova_rwsem);
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 022ef8f55088..d437ffb715e3 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -48,8 +48,8 @@ enum {
  * In syzkaller mode the 64 bit IOVA is converted into an nth area and offset
  * value. This has a much smaller randomization space and syzkaller can hit it.
  */
-static unsigned long iommufd_test_syz_conv_iova(struct io_pagetable *iopt,
-						u64 *iova)
+static unsigned long __iommufd_test_syz_conv_iova(struct io_pagetable *iopt,
+						  u64 *iova)
 {
 	struct syz_layout {
 		__u32 nth_area;
@@ -73,6 +73,21 @@ static unsigned long iommufd_test_syz_conv_iova(struct io_pagetable *iopt,
 	return 0;
 }
 
+static unsigned long iommufd_test_syz_conv_iova(struct iommufd_access *access,
+						u64 *iova)
+{
+	unsigned long ret;
+
+	mutex_lock(&access->ioas_lock);
+	if (!access->ioas) {
+		mutex_unlock(&access->ioas_lock);
+		return 0;
+	}
+	ret = __iommufd_test_syz_conv_iova(&access->ioas->iopt, iova);
+	mutex_unlock(&access->ioas_lock);
+	return ret;
+}
+
 void iommufd_test_syz_conv_iova_id(struct iommufd_ucmd *ucmd,
 				   unsigned int ioas_id, u64 *iova, u32 *flags)
 {
@@ -85,7 +100,7 @@ void iommufd_test_syz_conv_iova_id(struct iommufd_ucmd *ucmd,
 	ioas = iommufd_get_ioas(ucmd->ictx, ioas_id);
 	if (IS_ERR(ioas))
 		return;
-	*iova = iommufd_test_syz_conv_iova(&ioas->iopt, iova);
+	*iova = __iommufd_test_syz_conv_iova(&ioas->iopt, iova);
 	iommufd_put_object(ucmd->ictx, &ioas->obj);
 }
 
@@ -1045,7 +1060,7 @@ static int iommufd_test_access_pages(struct iommufd_ucmd *ucmd,
 	}
 
 	if (flags & MOCK_FLAGS_ACCESS_SYZ)
-		iova = iommufd_test_syz_conv_iova(&staccess->access->ioas->iopt,
+		iova = iommufd_test_syz_conv_iova(staccess->access,
 					&cmd->access_pages.iova);
 
 	npages = (ALIGN(iova + length, PAGE_SIZE) -
@@ -1147,8 +1162,8 @@ static int iommufd_test_access_rw(struct iommufd_ucmd *ucmd,
 	}
 
 	if (flags & MOCK_FLAGS_ACCESS_SYZ)
-		iova = iommufd_test_syz_conv_iova(&staccess->access->ioas->iopt,
-					&cmd->access_rw.iova);
+		iova = iommufd_test_syz_conv_iova(staccess->access,
+				&cmd->access_rw.iova);
 
 	rc = iommufd_access_rw(staccess->access, iova, tmp, length, flags);
 	if (rc)
diff --git a/drivers/mfd/twl6030-irq.c b/drivers/mfd/twl6030-irq.c
index f9fce8408c2c..3c03681c124c 100644
--- a/drivers/mfd/twl6030-irq.c
+++ b/drivers/mfd/twl6030-irq.c
@@ -24,10 +24,10 @@
 #include <linux/kthread.h>
 #include <linux/mfd/twl.h>
 #include <linux/platform_device.h>
-#include <linux/property.h>
 #include <linux/suspend.h>
 #include <linux/of.h>
 #include <linux/irqdomain.h>
+#include <linux/of_device.h>
 
 #include "twl-core.h"
 
@@ -368,10 +368,10 @@ int twl6030_init_irq(struct device *dev, int irq_num)
 	int			nr_irqs;
 	int			status;
 	u8			mask[3];
-	const int		*irq_tbl;
+	const struct of_device_id *of_id;
 
-	irq_tbl = device_get_match_data(dev);
-	if (!irq_tbl) {
+	of_id = of_match_device(twl6030_of_match, dev);
+	if (!of_id || !of_id->data) {
 		dev_err(dev, "Unknown TWL device model\n");
 		return -EINVAL;
 	}
@@ -409,7 +409,7 @@ int twl6030_init_irq(struct device *dev, int irq_num)
 
 	twl6030_irq->pm_nb.notifier_call = twl6030_irq_pm_notifier;
 	atomic_set(&twl6030_irq->wakeirqs, 0);
-	twl6030_irq->irq_mapping_tbl = irq_tbl;
+	twl6030_irq->irq_mapping_tbl = of_id->data;
 
 	twl6030_irq->irq_domain =
 		irq_domain_add_linear(node, nr_irqs,
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 705942edacc6..8479cf3df974 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1006,10 +1006,12 @@ static int mmc_select_bus_width(struct mmc_card *card)
 	static unsigned ext_csd_bits[] = {
 		EXT_CSD_BUS_WIDTH_8,
 		EXT_CSD_BUS_WIDTH_4,
+		EXT_CSD_BUS_WIDTH_1,
 	};
 	static unsigned bus_widths[] = {
 		MMC_BUS_WIDTH_8,
 		MMC_BUS_WIDTH_4,
+		MMC_BUS_WIDTH_1,
 	};
 	struct mmc_host *host = card->host;
 	unsigned idx, bus_width = 0;
diff --git a/drivers/mmc/host/mmci_stm32_sdmmc.c b/drivers/mmc/host/mmci_stm32_sdmmc.c
index 35067e1e6cd8..f5da7f9baa52 100644
--- a/drivers/mmc/host/mmci_stm32_sdmmc.c
+++ b/drivers/mmc/host/mmci_stm32_sdmmc.c
@@ -225,6 +225,8 @@ static int sdmmc_idma_start(struct mmci_host *host, unsigned int *datactrl)
 	struct scatterlist *sg;
 	int i;
 
+	host->dma_in_progress = true;
+
 	if (!host->variant->dma_lli || data->sg_len == 1 ||
 	    idma->use_bounce_buffer) {
 		u32 dma_addr;
@@ -263,9 +265,30 @@ static int sdmmc_idma_start(struct mmci_host *host, unsigned int *datactrl)
 	return 0;
 }
 
+static void sdmmc_idma_error(struct mmci_host *host)
+{
+	struct mmc_data *data = host->data;
+	struct sdmmc_idma *idma = host->dma_priv;
+
+	if (!dma_inprogress(host))
+		return;
+
+	writel_relaxed(0, host->base + MMCI_STM32_IDMACTRLR);
+	host->dma_in_progress = false;
+	data->host_cookie = 0;
+
+	if (!idma->use_bounce_buffer)
+		dma_unmap_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
+			     mmc_get_dma_dir(data));
+}
+
 static void sdmmc_idma_finalize(struct mmci_host *host, struct mmc_data *data)
 {
+	if (!dma_inprogress(host))
+		return;
+
 	writel_relaxed(0, host->base + MMCI_STM32_IDMACTRLR);
+	host->dma_in_progress = false;
 
 	if (!data->host_cookie)
 		sdmmc_idma_unprep_data(host, data, 0);
@@ -676,6 +699,7 @@ static struct mmci_host_ops sdmmc_variant_ops = {
 	.dma_setup = sdmmc_idma_setup,
 	.dma_start = sdmmc_idma_start,
 	.dma_finalize = sdmmc_idma_finalize,
+	.dma_error = sdmmc_idma_error,
 	.set_clkreg = mmci_sdmmc_set_clkreg,
 	.set_pwrreg = mmci_sdmmc_set_pwrreg,
 	.busy_complete = sdmmc_busy_complete,
diff --git a/drivers/mmc/host/sdhci-xenon-phy.c b/drivers/mmc/host/sdhci-xenon-phy.c
index 8cf3a375de65..cc9d28b75eb9 100644
--- a/drivers/mmc/host/sdhci-xenon-phy.c
+++ b/drivers/mmc/host/sdhci-xenon-phy.c
@@ -11,6 +11,7 @@
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/ktime.h>
+#include <linux/iopoll.h>
 #include <linux/of_address.h>
 
 #include "sdhci-pltfm.h"
@@ -109,6 +110,8 @@
 #define XENON_EMMC_PHY_LOGIC_TIMING_ADJUST	(XENON_EMMC_PHY_REG_BASE + 0x18)
 #define XENON_LOGIC_TIMING_VALUE		0x00AA8977
 
+#define XENON_MAX_PHY_TIMEOUT_LOOPS		100
+
 /*
  * List offset of PHY registers and some special register values
  * in eMMC PHY 5.0 or eMMC PHY 5.1
@@ -216,6 +219,19 @@ static int xenon_alloc_emmc_phy(struct sdhci_host *host)
 	return 0;
 }
 
+static int xenon_check_stability_internal_clk(struct sdhci_host *host)
+{
+	u32 reg;
+	int err;
+
+	err = read_poll_timeout(sdhci_readw, reg, reg & SDHCI_CLOCK_INT_STABLE,
+				1100, 20000, false, host, SDHCI_CLOCK_CONTROL);
+	if (err)
+		dev_err(mmc_dev(host->mmc), "phy_init: Internal clock never stabilized.\n");
+
+	return err;
+}
+
 /*
  * eMMC 5.0/5.1 PHY init/re-init.
  * eMMC PHY init should be executed after:
@@ -232,6 +248,11 @@ static int xenon_emmc_phy_init(struct sdhci_host *host)
 	struct xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
 	struct xenon_emmc_phy_regs *phy_regs = priv->emmc_phy_regs;
 
+	int ret = xenon_check_stability_internal_clk(host);
+
+	if (ret)
+		return ret;
+
 	reg = sdhci_readl(host, phy_regs->timing_adj);
 	reg |= XENON_PHY_INITIALIZAION;
 	sdhci_writel(host, reg, phy_regs->timing_adj);
@@ -259,18 +280,27 @@ static int xenon_emmc_phy_init(struct sdhci_host *host)
 	/* get the wait time */
 	wait /= clock;
 	wait++;
-	/* wait for host eMMC PHY init completes */
-	udelay(wait);
 
-	reg = sdhci_readl(host, phy_regs->timing_adj);
-	reg &= XENON_PHY_INITIALIZAION;
-	if (reg) {
+	/*
+	 * AC5X spec says bit must be polled until zero.
+	 * We see cases in which timeout can take longer
+	 * than the standard calculation on AC5X, which is
+	 * expected following the spec comment above.
+	 * According to the spec, we must wait as long as
+	 * it takes for that bit to toggle on AC5X.
+	 * Cap that with 100 delay loops so we won't get
+	 * stuck here forever:
+	 */
+
+	ret = read_poll_timeout(sdhci_readl, reg,
+				!(reg & XENON_PHY_INITIALIZAION),
+				wait, XENON_MAX_PHY_TIMEOUT_LOOPS * wait,
+				false, host, phy_regs->timing_adj);
+	if (ret)
 		dev_err(mmc_dev(host->mmc), "eMMC PHY init cannot complete after %d us\n",
-			wait);
-		return -ETIMEDOUT;
-	}
+			wait * XENON_MAX_PHY_TIMEOUT_LOOPS);
 
-	return 0;
+	return ret;
 }
 
 #define ARMADA_3700_SOC_PAD_1_8V	0x1
diff --git a/drivers/mtd/nand/raw/marvell_nand.c b/drivers/mtd/nand/raw/marvell_nand.c
index a46698744850..5b0f5a9cef81 100644
--- a/drivers/mtd/nand/raw/marvell_nand.c
+++ b/drivers/mtd/nand/raw/marvell_nand.c
@@ -290,16 +290,13 @@ static const struct marvell_hw_ecc_layout marvell_nfc_layouts[] = {
 	MARVELL_LAYOUT( 2048,   512,  4,  1,  1, 2048, 32, 30,  0,  0,  0),
 	MARVELL_LAYOUT( 2048,   512,  8,  2,  1, 1024,  0, 30,1024,32, 30),
 	MARVELL_LAYOUT( 2048,   512,  8,  2,  1, 1024,  0, 30,1024,64, 30),
-	MARVELL_LAYOUT( 2048,   512,  12, 3,  2, 704,   0, 30,640,  0, 30),
-	MARVELL_LAYOUT( 2048,   512,  16, 5,  4, 512,   0, 30,  0, 32, 30),
+	MARVELL_LAYOUT( 2048,   512,  16, 4,  4, 512,   0, 30,  0, 32, 30),
 	MARVELL_LAYOUT( 4096,   512,  4,  2,  2, 2048, 32, 30,  0,  0,  0),
-	MARVELL_LAYOUT( 4096,   512,  8,  5,  4, 1024,  0, 30,  0, 64, 30),
-	MARVELL_LAYOUT( 4096,   512,  12, 6,  5, 704,   0, 30,576, 32, 30),
-	MARVELL_LAYOUT( 4096,   512,  16, 9,  8, 512,   0, 30,  0, 32, 30),
+	MARVELL_LAYOUT( 4096,   512,  8,  4,  4, 1024,  0, 30,  0, 64, 30),
+	MARVELL_LAYOUT( 4096,   512,  16, 8,  8, 512,   0, 30,  0, 32, 30),
 	MARVELL_LAYOUT( 8192,   512,  4,  4,  4, 2048,  0, 30,  0,  0,  0),
-	MARVELL_LAYOUT( 8192,   512,  8,  9,  8, 1024,  0, 30,  0, 160, 30),
-	MARVELL_LAYOUT( 8192,   512,  12, 12, 11, 704,  0, 30,448,  64, 30),
-	MARVELL_LAYOUT( 8192,   512,  16, 17, 16, 512,  0, 30,  0,  32, 30),
+	MARVELL_LAYOUT( 8192,   512,  8,  8,  8, 1024,  0, 30,  0, 160, 30),
+	MARVELL_LAYOUT( 8192,   512,  16, 16, 16, 512,  0, 30,  0,  32, 30),
 };
 
 /**
diff --git a/drivers/mtd/nand/spi/gigadevice.c b/drivers/mtd/nand/spi/gigadevice.c
index 987710e09441..6023cba748bb 100644
--- a/drivers/mtd/nand/spi/gigadevice.c
+++ b/drivers/mtd/nand/spi/gigadevice.c
@@ -186,7 +186,7 @@ static int gd5fxgq4uexxg_ecc_get_status(struct spinand_device *spinand,
 {
 	u8 status2;
 	struct spi_mem_op op = SPINAND_GET_FEATURE_OP(GD5FXGQXXEXXG_REG_STATUS2,
-						      &status2);
+						      spinand->scratchbuf);
 	int ret;
 
 	switch (status & STATUS_ECC_MASK) {
@@ -207,6 +207,7 @@ static int gd5fxgq4uexxg_ecc_get_status(struct spinand_device *spinand,
 		 * report the maximum of 4 in this case
 		 */
 		/* bits sorted this way (3...0): ECCS1,ECCS0,ECCSE1,ECCSE0 */
+		status2 = *(spinand->scratchbuf);
 		return ((status & STATUS_ECC_MASK) >> 2) |
 			((status2 & STATUS_ECC_MASK) >> 4);
 
@@ -228,7 +229,7 @@ static int gd5fxgq5xexxg_ecc_get_status(struct spinand_device *spinand,
 {
 	u8 status2;
 	struct spi_mem_op op = SPINAND_GET_FEATURE_OP(GD5FXGQXXEXXG_REG_STATUS2,
-						      &status2);
+						      spinand->scratchbuf);
 	int ret;
 
 	switch (status & STATUS_ECC_MASK) {
@@ -248,6 +249,7 @@ static int gd5fxgq5xexxg_ecc_get_status(struct spinand_device *spinand,
 		 * 1 ... 4 bits are flipped (and corrected)
 		 */
 		/* bits sorted this way (1...0): ECCSE1, ECCSE0 */
+		status2 = *(spinand->scratchbuf);
 		return ((status2 & STATUS_ECC_MASK) >> 4) + 1;
 
 	case STATUS_ECC_UNCOR_ERROR:
diff --git a/drivers/net/ethernet/freescale/fman/fman_memac.c b/drivers/net/ethernet/freescale/fman/fman_memac.c
index 9ba15d3183d7..758535adc9ff 100644
--- a/drivers/net/ethernet/freescale/fman/fman_memac.c
+++ b/drivers/net/ethernet/freescale/fman/fman_memac.c
@@ -1073,6 +1073,14 @@ int memac_initialization(struct mac_device *mac_dev,
 	unsigned long		 capabilities;
 	unsigned long		*supported;
 
+	/* The internal connection to the serdes is XGMII, but this isn't
+	 * really correct for the phy mode (which is the external connection).
+	 * However, this is how all older device trees say that they want
+	 * 10GBASE-R (aka XFI), so just convert it for them.
+	 */
+	if (mac_dev->phy_if == PHY_INTERFACE_MODE_XGMII)
+		mac_dev->phy_if = PHY_INTERFACE_MODE_10GBASER;
+
 	mac_dev->phylink_ops		= &memac_mac_ops;
 	mac_dev->set_promisc		= memac_set_promiscuous;
 	mac_dev->change_addr		= memac_modify_mac_address;
@@ -1139,7 +1147,7 @@ int memac_initialization(struct mac_device *mac_dev,
 	 * (and therefore that xfi_pcs cannot be set). If we are defaulting to
 	 * XGMII, assume this is for XFI. Otherwise, assume it is for SGMII.
 	 */
-	if (err && mac_dev->phy_if == PHY_INTERFACE_MODE_XGMII)
+	if (err && mac_dev->phy_if == PHY_INTERFACE_MODE_10GBASER)
 		memac->xfi_pcs = pcs;
 	else
 		memac->sgmii_pcs = pcs;
@@ -1153,14 +1161,6 @@ int memac_initialization(struct mac_device *mac_dev,
 		goto _return_fm_mac_free;
 	}
 
-	/* The internal connection to the serdes is XGMII, but this isn't
-	 * really correct for the phy mode (which is the external connection).
-	 * However, this is how all older device trees say that they want
-	 * 10GBASE-R (aka XFI), so just convert it for them.
-	 */
-	if (mac_dev->phy_if == PHY_INTERFACE_MODE_XGMII)
-		mac_dev->phy_if = PHY_INTERFACE_MODE_10GBASER;
-
 	/* TODO: The following interface modes are supported by (some) hardware
 	 * but not by this driver:
 	 * - 1000BASE-KX
diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index 86b180cb32a0..2b657d43c769 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -30,6 +30,26 @@ static const char * const pin_type_name[] = {
 	[ICE_DPLL_PIN_TYPE_RCLK_INPUT] = "rclk-input",
 };
 
+/**
+ * ice_dpll_is_reset - check if reset is in progress
+ * @pf: private board structure
+ * @extack: error reporting
+ *
+ * If reset is in progress, fill extack with error.
+ *
+ * Return:
+ * * false - no reset in progress
+ * * true - reset in progress
+ */
+static bool ice_dpll_is_reset(struct ice_pf *pf, struct netlink_ext_ack *extack)
+{
+	if (ice_is_reset_in_progress(pf->state)) {
+		NL_SET_ERR_MSG(extack, "PF reset in progress");
+		return true;
+	}
+	return false;
+}
+
 /**
  * ice_dpll_pin_freq_set - set pin's frequency
  * @pf: private board structure
@@ -109,6 +129,9 @@ ice_dpll_frequency_set(const struct dpll_pin *pin, void *pin_priv,
 	struct ice_pf *pf = d->pf;
 	int ret;
 
+	if (ice_dpll_is_reset(pf, extack))
+		return -EBUSY;
+
 	mutex_lock(&pf->dplls.lock);
 	ret = ice_dpll_pin_freq_set(pf, p, pin_type, frequency, extack);
 	mutex_unlock(&pf->dplls.lock);
@@ -254,6 +277,7 @@ ice_dpll_output_frequency_get(const struct dpll_pin *pin, void *pin_priv,
  * ice_dpll_pin_enable - enable a pin on dplls
  * @hw: board private hw structure
  * @pin: pointer to a pin
+ * @dpll_idx: dpll index to connect to output pin
  * @pin_type: type of pin being enabled
  * @extack: error reporting
  *
@@ -266,7 +290,7 @@ ice_dpll_output_frequency_get(const struct dpll_pin *pin, void *pin_priv,
  */
 static int
 ice_dpll_pin_enable(struct ice_hw *hw, struct ice_dpll_pin *pin,
-		    enum ice_dpll_pin_type pin_type,
+		    u8 dpll_idx, enum ice_dpll_pin_type pin_type,
 		    struct netlink_ext_ack *extack)
 {
 	u8 flags = 0;
@@ -280,10 +304,12 @@ ice_dpll_pin_enable(struct ice_hw *hw, struct ice_dpll_pin *pin,
 		ret = ice_aq_set_input_pin_cfg(hw, pin->idx, 0, flags, 0, 0);
 		break;
 	case ICE_DPLL_PIN_TYPE_OUTPUT:
+		flags = ICE_AQC_SET_CGU_OUT_CFG_UPDATE_SRC_SEL;
 		if (pin->flags[0] & ICE_AQC_GET_CGU_OUT_CFG_ESYNC_EN)
 			flags |= ICE_AQC_SET_CGU_OUT_CFG_ESYNC_EN;
 		flags |= ICE_AQC_SET_CGU_OUT_CFG_OUT_EN;
-		ret = ice_aq_set_output_pin_cfg(hw, pin->idx, flags, 0, 0, 0);
+		ret = ice_aq_set_output_pin_cfg(hw, pin->idx, flags, dpll_idx,
+						0, 0);
 		break;
 	default:
 		return -EINVAL;
@@ -370,7 +396,7 @@ ice_dpll_pin_state_update(struct ice_pf *pf, struct ice_dpll_pin *pin,
 	case ICE_DPLL_PIN_TYPE_INPUT:
 		ret = ice_aq_get_input_pin_cfg(&pf->hw, pin->idx, NULL, NULL,
 					       NULL, &pin->flags[0],
-					       &pin->freq, NULL);
+					       &pin->freq, &pin->phase_adjust);
 		if (ret)
 			goto err;
 		if (ICE_AQC_GET_CGU_IN_CFG_FLG2_INPUT_EN & pin->flags[0]) {
@@ -398,14 +424,27 @@ ice_dpll_pin_state_update(struct ice_pf *pf, struct ice_dpll_pin *pin,
 		break;
 	case ICE_DPLL_PIN_TYPE_OUTPUT:
 		ret = ice_aq_get_output_pin_cfg(&pf->hw, pin->idx,
-						&pin->flags[0], NULL,
+						&pin->flags[0], &parent,
 						&pin->freq, NULL);
 		if (ret)
 			goto err;
-		if (ICE_AQC_SET_CGU_OUT_CFG_OUT_EN & pin->flags[0])
-			pin->state[0] = DPLL_PIN_STATE_CONNECTED;
-		else
-			pin->state[0] = DPLL_PIN_STATE_DISCONNECTED;
+
+		parent &= ICE_AQC_GET_CGU_OUT_CFG_DPLL_SRC_SEL;
+		if (ICE_AQC_SET_CGU_OUT_CFG_OUT_EN & pin->flags[0]) {
+			pin->state[pf->dplls.eec.dpll_idx] =
+				parent == pf->dplls.eec.dpll_idx ?
+				DPLL_PIN_STATE_CONNECTED :
+				DPLL_PIN_STATE_DISCONNECTED;
+			pin->state[pf->dplls.pps.dpll_idx] =
+				parent == pf->dplls.pps.dpll_idx ?
+				DPLL_PIN_STATE_CONNECTED :
+				DPLL_PIN_STATE_DISCONNECTED;
+		} else {
+			pin->state[pf->dplls.eec.dpll_idx] =
+				DPLL_PIN_STATE_DISCONNECTED;
+			pin->state[pf->dplls.pps.dpll_idx] =
+				DPLL_PIN_STATE_DISCONNECTED;
+		}
 		break;
 	case ICE_DPLL_PIN_TYPE_RCLK_INPUT:
 		for (parent = 0; parent < pf->dplls.rclk.num_parents;
@@ -593,9 +632,13 @@ ice_dpll_pin_state_set(const struct dpll_pin *pin, void *pin_priv,
 	struct ice_pf *pf = d->pf;
 	int ret;
 
+	if (ice_dpll_is_reset(pf, extack))
+		return -EBUSY;
+
 	mutex_lock(&pf->dplls.lock);
 	if (enable)
-		ret = ice_dpll_pin_enable(&pf->hw, p, pin_type, extack);
+		ret = ice_dpll_pin_enable(&pf->hw, p, d->dpll_idx, pin_type,
+					  extack);
 	else
 		ret = ice_dpll_pin_disable(&pf->hw, p, pin_type, extack);
 	if (!ret)
@@ -628,6 +671,11 @@ ice_dpll_output_state_set(const struct dpll_pin *pin, void *pin_priv,
 			  struct netlink_ext_ack *extack)
 {
 	bool enable = state == DPLL_PIN_STATE_CONNECTED;
+	struct ice_dpll_pin *p = pin_priv;
+	struct ice_dpll *d = dpll_priv;
+
+	if (!enable && p->state[d->dpll_idx] == DPLL_PIN_STATE_DISCONNECTED)
+		return 0;
 
 	return ice_dpll_pin_state_set(pin, pin_priv, dpll, dpll_priv, enable,
 				      extack, ICE_DPLL_PIN_TYPE_OUTPUT);
@@ -690,14 +738,16 @@ ice_dpll_pin_state_get(const struct dpll_pin *pin, void *pin_priv,
 	struct ice_pf *pf = d->pf;
 	int ret;
 
+	if (ice_dpll_is_reset(pf, extack))
+		return -EBUSY;
+
 	mutex_lock(&pf->dplls.lock);
 	ret = ice_dpll_pin_state_update(pf, p, pin_type, extack);
 	if (ret)
 		goto unlock;
-	if (pin_type == ICE_DPLL_PIN_TYPE_INPUT)
+	if (pin_type == ICE_DPLL_PIN_TYPE_INPUT ||
+	    pin_type == ICE_DPLL_PIN_TYPE_OUTPUT)
 		*state = p->state[d->dpll_idx];
-	else if (pin_type == ICE_DPLL_PIN_TYPE_OUTPUT)
-		*state = p->state[0];
 	ret = 0;
 unlock:
 	mutex_unlock(&pf->dplls.lock);
@@ -815,6 +865,9 @@ ice_dpll_input_prio_set(const struct dpll_pin *pin, void *pin_priv,
 	struct ice_pf *pf = d->pf;
 	int ret;
 
+	if (ice_dpll_is_reset(pf, extack))
+		return -EBUSY;
+
 	mutex_lock(&pf->dplls.lock);
 	ret = ice_dpll_hw_input_prio_set(pf, d, p, prio, extack);
 	mutex_unlock(&pf->dplls.lock);
@@ -935,6 +988,9 @@ ice_dpll_pin_phase_adjust_set(const struct dpll_pin *pin, void *pin_priv,
 	u8 flag, flags_en = 0;
 	int ret;
 
+	if (ice_dpll_is_reset(pf, extack))
+		return -EBUSY;
+
 	mutex_lock(&pf->dplls.lock);
 	switch (type) {
 	case ICE_DPLL_PIN_TYPE_INPUT:
@@ -1094,6 +1150,9 @@ ice_dpll_rclk_state_on_pin_set(const struct dpll_pin *pin, void *pin_priv,
 	int ret = -EINVAL;
 	u32 hw_idx;
 
+	if (ice_dpll_is_reset(pf, extack))
+		return -EBUSY;
+
 	mutex_lock(&pf->dplls.lock);
 	hw_idx = parent->idx - pf->dplls.base_rclk_idx;
 	if (hw_idx >= pf->dplls.num_inputs)
@@ -1148,6 +1207,9 @@ ice_dpll_rclk_state_on_pin_get(const struct dpll_pin *pin, void *pin_priv,
 	int ret = -EINVAL;
 	u32 hw_idx;
 
+	if (ice_dpll_is_reset(pf, extack))
+		return -EBUSY;
+
 	mutex_lock(&pf->dplls.lock);
 	hw_idx = parent->idx - pf->dplls.base_rclk_idx;
 	if (hw_idx >= pf->dplls.num_inputs)
@@ -1331,8 +1393,10 @@ static void ice_dpll_periodic_work(struct kthread_work *work)
 	struct ice_pf *pf = container_of(d, struct ice_pf, dplls);
 	struct ice_dpll *de = &pf->dplls.eec;
 	struct ice_dpll *dp = &pf->dplls.pps;
-	int ret;
+	int ret = 0;
 
+	if (ice_is_reset_in_progress(pf->state))
+		goto resched;
 	mutex_lock(&pf->dplls.lock);
 	ret = ice_dpll_update_state(pf, de, false);
 	if (!ret)
@@ -1352,6 +1416,7 @@ static void ice_dpll_periodic_work(struct kthread_work *work)
 	ice_dpll_notify_changes(de);
 	ice_dpll_notify_changes(dp);
 
+resched:
 	/* Run twice a second or reschedule if update failed */
 	kthread_queue_delayed_work(d->kworker, &d->work,
 				   ret ? msecs_to_jiffies(10) :
diff --git a/drivers/net/ethernet/intel/igb/igb_ptp.c b/drivers/net/ethernet/intel/igb/igb_ptp.c
index 319c544b9f04..f94570556120 100644
--- a/drivers/net/ethernet/intel/igb/igb_ptp.c
+++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
@@ -957,7 +957,7 @@ static void igb_ptp_tx_hwtstamp(struct igb_adapter *adapter)
 
 	igb_ptp_systim_to_hwtstamp(adapter, &shhwtstamps, regval);
 	/* adjust timestamp for the TX latency based on link speed */
-	if (adapter->hw.mac.type == e1000_i210) {
+	if (hw->mac.type == e1000_i210 || hw->mac.type == e1000_i211) {
 		switch (adapter->link_speed) {
 		case SPEED_10:
 			adjust = IGB_I210_TX_LATENCY_10;
@@ -1003,6 +1003,7 @@ int igb_ptp_rx_pktstamp(struct igb_q_vector *q_vector, void *va,
 			ktime_t *timestamp)
 {
 	struct igb_adapter *adapter = q_vector->adapter;
+	struct e1000_hw *hw = &adapter->hw;
 	struct skb_shared_hwtstamps ts;
 	__le64 *regval = (__le64 *)va;
 	int adjust = 0;
@@ -1022,7 +1023,7 @@ int igb_ptp_rx_pktstamp(struct igb_q_vector *q_vector, void *va,
 	igb_ptp_systim_to_hwtstamp(adapter, &ts, le64_to_cpu(regval[1]));
 
 	/* adjust timestamp for the RX latency based on link speed */
-	if (adapter->hw.mac.type == e1000_i210) {
+	if (hw->mac.type == e1000_i210 || hw->mac.type == e1000_i211) {
 		switch (adapter->link_speed) {
 		case SPEED_10:
 			adjust = IGB_I210_RX_LATENCY_10;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index e9a1b60ebb50..de4d76919517 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3942,8 +3942,10 @@ static void stmmac_fpe_stop_wq(struct stmmac_priv *priv)
 {
 	set_bit(__FPE_REMOVING, &priv->fpe_task_state);
 
-	if (priv->fpe_wq)
+	if (priv->fpe_wq) {
 		destroy_workqueue(priv->fpe_wq);
+		priv->fpe_wq = NULL;
+	}
 
 	netdev_info(priv->dev, "FPE workqueue stop");
 }
diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 2129ae42c703..2b5357d94ff5 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -1903,26 +1903,26 @@ static int __init gtp_init(void)
 
 	get_random_bytes(&gtp_h_initval, sizeof(gtp_h_initval));
 
-	err = rtnl_link_register(&gtp_link_ops);
+	err = register_pernet_subsys(&gtp_net_ops);
 	if (err < 0)
 		goto error_out;
 
-	err = register_pernet_subsys(&gtp_net_ops);
+	err = rtnl_link_register(&gtp_link_ops);
 	if (err < 0)
-		goto unreg_rtnl_link;
+		goto unreg_pernet_subsys;
 
 	err = genl_register_family(&gtp_genl_family);
 	if (err < 0)
-		goto unreg_pernet_subsys;
+		goto unreg_rtnl_link;
 
 	pr_info("GTP module loaded (pdp ctx size %zd bytes)\n",
 		sizeof(struct pdp_ctx));
 	return 0;
 
-unreg_pernet_subsys:
-	unregister_pernet_subsys(&gtp_net_ops);
 unreg_rtnl_link:
 	rtnl_link_unregister(&gtp_link_ops);
+unreg_pernet_subsys:
+	unregister_pernet_subsys(&gtp_net_ops);
 error_out:
 	pr_err("error loading GTP module loaded\n");
 	return err;
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 4a4f8c8e79fa..8f95a562b8d0 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -653,6 +653,7 @@ static void __tun_detach(struct tun_file *tfile, bool clean)
 				   tun->tfiles[tun->numqueues - 1]);
 		ntfile = rtnl_dereference(tun->tfiles[index]);
 		ntfile->queue_index = index;
+		ntfile->xdp_rxq.queue_index = index;
 		rcu_assign_pointer(tun->tfiles[tun->numqueues - 1],
 				   NULL);
 
diff --git a/drivers/net/usb/dm9601.c b/drivers/net/usb/dm9601.c
index 99ec1d4a972d..8b6d6a1b3c2e 100644
--- a/drivers/net/usb/dm9601.c
+++ b/drivers/net/usb/dm9601.c
@@ -232,7 +232,7 @@ static int dm9601_mdio_read(struct net_device *netdev, int phy_id, int loc)
 	err = dm_read_shared_word(dev, 1, loc, &res);
 	if (err < 0) {
 		netdev_err(dev->net, "MDIO read error: %d\n", err);
-		return err;
+		return 0;
 	}
 
 	netdev_dbg(dev->net,
diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 5add4145d9fc..a2dde84499fd 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -1501,7 +1501,9 @@ static int lan78xx_link_reset(struct lan78xx_net *dev)
 
 		lan78xx_rx_urb_submit_all(dev);
 
+		local_bh_disable();
 		napi_schedule(&dev->napi);
+		local_bh_enable();
 	}
 
 	return 0;
@@ -3035,7 +3037,8 @@ static int lan78xx_reset(struct lan78xx_net *dev)
 	if (dev->chipid == ID_REV_CHIP_ID_7801_)
 		buf &= ~MAC_CR_GMII_EN_;
 
-	if (dev->chipid == ID_REV_CHIP_ID_7800_) {
+	if (dev->chipid == ID_REV_CHIP_ID_7800_ ||
+	    dev->chipid == ID_REV_CHIP_ID_7850_) {
 		ret = lan78xx_read_raw_eeprom(dev, 0, 1, &sig);
 		if (!ret && sig != EEPROM_INDICATOR) {
 			/* Implies there is no external eeprom. Set mac speed */
diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 977861c46b1f..a2e80278eb2f 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1208,14 +1208,6 @@ static int veth_enable_xdp(struct net_device *dev)
 				veth_disable_xdp_range(dev, 0, dev->real_num_rx_queues, true);
 				return err;
 			}
-
-			if (!veth_gro_requested(dev)) {
-				/* user-space did not require GRO, but adding XDP
-				 * is supposed to get GRO working
-				 */
-				dev->features |= NETIF_F_GRO;
-				netdev_features_change(dev);
-			}
 		}
 	}
 
@@ -1235,18 +1227,9 @@ static void veth_disable_xdp(struct net_device *dev)
 	for (i = 0; i < dev->real_num_rx_queues; i++)
 		rcu_assign_pointer(priv->rq[i].xdp_prog, NULL);
 
-	if (!netif_running(dev) || !veth_gro_requested(dev)) {
+	if (!netif_running(dev) || !veth_gro_requested(dev))
 		veth_napi_del(dev);
 
-		/* if user-space did not require GRO, since adding XDP
-		 * enabled it, clear it now
-		 */
-		if (!veth_gro_requested(dev) && netif_running(dev)) {
-			dev->features &= ~NETIF_F_GRO;
-			netdev_features_change(dev);
-		}
-	}
-
 	veth_disable_xdp_range(dev, 0, dev->real_num_rx_queues, false);
 }
 
@@ -1478,7 +1461,8 @@ static int veth_alloc_queues(struct net_device *dev)
 	struct veth_priv *priv = netdev_priv(dev);
 	int i;
 
-	priv->rq = kcalloc(dev->num_rx_queues, sizeof(*priv->rq), GFP_KERNEL_ACCOUNT);
+	priv->rq = kvcalloc(dev->num_rx_queues, sizeof(*priv->rq),
+			    GFP_KERNEL_ACCOUNT | __GFP_RETRY_MAYFAIL);
 	if (!priv->rq)
 		return -ENOMEM;
 
@@ -1494,7 +1478,7 @@ static void veth_free_queues(struct net_device *dev)
 {
 	struct veth_priv *priv = netdev_priv(dev);
 
-	kfree(priv->rq);
+	kvfree(priv->rq);
 }
 
 static int veth_dev_init(struct net_device *dev)
@@ -1654,6 +1638,14 @@ static int veth_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 		}
 
 		if (!old_prog) {
+			if (!veth_gro_requested(dev)) {
+				/* user-space did not require GRO, but adding
+				 * XDP is supposed to get GRO working
+				 */
+				dev->features |= NETIF_F_GRO;
+				netdev_features_change(dev);
+			}
+
 			peer->hw_features &= ~NETIF_F_GSO_SOFTWARE;
 			peer->max_mtu = max_mtu;
 		}
@@ -1669,6 +1661,14 @@ static int veth_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 			if (dev->flags & IFF_UP)
 				veth_disable_xdp(dev);
 
+			/* if user-space did not require GRO, since adding XDP
+			 * enabled it, clear it now
+			 */
+			if (!veth_gro_requested(dev)) {
+				dev->features &= ~NETIF_F_GRO;
+				netdev_features_change(dev);
+			}
+
 			if (peer) {
 				peer->hw_features |= NETIF_F_GSO_SOFTWARE;
 				peer->max_mtu = ETH_MAX_MTU;
diff --git a/drivers/of/property.c b/drivers/of/property.c
index 885ee040ee2b..15d115684325 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1303,7 +1303,7 @@ static struct device_node *parse_remote_endpoint(struct device_node *np,
 						 int index)
 {
 	/* Return NULL for index > 0 to signify end of remote-endpoints. */
-	if (!index || strcmp(prop_name, "remote-endpoint"))
+	if (index > 0 || strcmp(prop_name, "remote-endpoint"))
 		return NULL;
 
 	return of_graph_get_remote_port_parent(np);
diff --git a/drivers/perf/riscv_pmu.c b/drivers/perf/riscv_pmu.c
index 0dda70e1ef90..c78a6fd6c57f 100644
--- a/drivers/perf/riscv_pmu.c
+++ b/drivers/perf/riscv_pmu.c
@@ -150,19 +150,11 @@ u64 riscv_pmu_ctr_get_width_mask(struct perf_event *event)
 	struct riscv_pmu *rvpmu = to_riscv_pmu(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
 
-	if (!rvpmu->ctr_get_width)
-	/**
-	 * If the pmu driver doesn't support counter width, set it to default
-	 * maximum allowed by the specification.
-	 */
-		cwidth = 63;
-	else {
-		if (hwc->idx == -1)
-			/* Handle init case where idx is not initialized yet */
-			cwidth = rvpmu->ctr_get_width(0);
-		else
-			cwidth = rvpmu->ctr_get_width(hwc->idx);
-	}
+	if (hwc->idx == -1)
+		/* Handle init case where idx is not initialized yet */
+		cwidth = rvpmu->ctr_get_width(0);
+	else
+		cwidth = rvpmu->ctr_get_width(hwc->idx);
 
 	return GENMASK_ULL(cwidth, 0);
 }
diff --git a/drivers/perf/riscv_pmu_legacy.c b/drivers/perf/riscv_pmu_legacy.c
index 79fdd667922e..fa0bccf4edf2 100644
--- a/drivers/perf/riscv_pmu_legacy.c
+++ b/drivers/perf/riscv_pmu_legacy.c
@@ -37,6 +37,12 @@ static int pmu_legacy_event_map(struct perf_event *event, u64 *config)
 	return pmu_legacy_ctr_get_idx(event);
 }
 
+/* cycle & instret are always 64 bit, one bit less according to SBI spec */
+static int pmu_legacy_ctr_get_width(int idx)
+{
+	return 63;
+}
+
 static u64 pmu_legacy_read_ctr(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
@@ -111,12 +117,14 @@ static void pmu_legacy_init(struct riscv_pmu *pmu)
 	pmu->ctr_stop = NULL;
 	pmu->event_map = pmu_legacy_event_map;
 	pmu->ctr_get_idx = pmu_legacy_ctr_get_idx;
-	pmu->ctr_get_width = NULL;
+	pmu->ctr_get_width = pmu_legacy_ctr_get_width;
 	pmu->ctr_clear_idx = NULL;
 	pmu->ctr_read = pmu_legacy_read_ctr;
 	pmu->event_mapped = pmu_legacy_event_mapped;
 	pmu->event_unmapped = pmu_legacy_event_unmapped;
 	pmu->csr_index = pmu_legacy_csr_index;
+	pmu->pmu.capabilities |= PERF_PMU_CAP_NO_INTERRUPT;
+	pmu->pmu.capabilities |= PERF_PMU_CAP_NO_EXCLUDE;
 
 	perf_pmu_register(&pmu->pmu, "cpu", PERF_TYPE_RAW);
 }
diff --git a/drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c b/drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c
index e625b32889bf..0928a526e2ab 100644
--- a/drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c
+++ b/drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c
@@ -706,7 +706,7 @@ static int mixel_dphy_probe(struct platform_device *pdev)
 			return ret;
 		}
 
-		priv->id = of_alias_get_id(np, "mipi_dphy");
+		priv->id = of_alias_get_id(np, "mipi-dphy");
 		if (priv->id < 0) {
 			dev_err(dev, "Failed to get phy node alias id: %d\n",
 				priv->id);
diff --git a/drivers/phy/qualcomm/phy-qcom-m31.c b/drivers/phy/qualcomm/phy-qcom-m31.c
index c2590579190a..03fb0d4b75d7 100644
--- a/drivers/phy/qualcomm/phy-qcom-m31.c
+++ b/drivers/phy/qualcomm/phy-qcom-m31.c
@@ -299,7 +299,7 @@ static int m31usb_phy_probe(struct platform_device *pdev)
 
 	qphy->vreg = devm_regulator_get(dev, "vdda-phy");
 	if (IS_ERR(qphy->vreg))
-		return dev_err_probe(dev, PTR_ERR(qphy->phy),
+		return dev_err_probe(dev, PTR_ERR(qphy->vreg),
 				     "failed to get vreg\n");
 
 	phy_set_drvdata(qphy->phy, qphy);
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
index a3719719e2e0..365f5d85847b 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
@@ -1276,7 +1276,7 @@ static const char * const qmp_phy_vreg_l[] = {
 	"vdda-phy", "vdda-pll",
 };
 
-static const struct qmp_usb_offsets qmp_usb_offsets_ipq8074 = {
+static const struct qmp_usb_offsets qmp_usb_offsets_v3 = {
 	.serdes		= 0,
 	.pcs		= 0x800,
 	.pcs_misc	= 0x600,
@@ -1292,7 +1292,7 @@ static const struct qmp_usb_offsets qmp_usb_offsets_ipq9574 = {
 	.rx		= 0x400,
 };
 
-static const struct qmp_usb_offsets qmp_usb_offsets_v3 = {
+static const struct qmp_usb_offsets qmp_usb_offsets_v3_msm8996 = {
 	.serdes		= 0,
 	.pcs		= 0x600,
 	.tx		= 0x200,
@@ -1328,7 +1328,7 @@ static const struct qmp_usb_offsets qmp_usb_offsets_v5 = {
 static const struct qmp_phy_cfg ipq6018_usb3phy_cfg = {
 	.lanes			= 1,
 
-	.offsets		= &qmp_usb_offsets_ipq8074,
+	.offsets		= &qmp_usb_offsets_v3,
 
 	.serdes_tbl		= ipq9574_usb3_serdes_tbl,
 	.serdes_tbl_num		= ARRAY_SIZE(ipq9574_usb3_serdes_tbl),
@@ -1346,7 +1346,7 @@ static const struct qmp_phy_cfg ipq6018_usb3phy_cfg = {
 static const struct qmp_phy_cfg ipq8074_usb3phy_cfg = {
 	.lanes			= 1,
 
-	.offsets		= &qmp_usb_offsets_ipq8074,
+	.offsets		= &qmp_usb_offsets_v3,
 
 	.serdes_tbl		= ipq8074_usb3_serdes_tbl,
 	.serdes_tbl_num		= ARRAY_SIZE(ipq8074_usb3_serdes_tbl),
@@ -1382,7 +1382,7 @@ static const struct qmp_phy_cfg ipq9574_usb3phy_cfg = {
 static const struct qmp_phy_cfg msm8996_usb3phy_cfg = {
 	.lanes			= 1,
 
-	.offsets		= &qmp_usb_offsets_v3,
+	.offsets		= &qmp_usb_offsets_v3_msm8996,
 
 	.serdes_tbl		= msm8996_usb3_serdes_tbl,
 	.serdes_tbl_num		= ARRAY_SIZE(msm8996_usb3_serdes_tbl),
diff --git a/drivers/pmdomain/arm/scmi_perf_domain.c b/drivers/pmdomain/arm/scmi_perf_domain.c
index 709bbc448fad..d7ef46ccd9b8 100644
--- a/drivers/pmdomain/arm/scmi_perf_domain.c
+++ b/drivers/pmdomain/arm/scmi_perf_domain.c
@@ -159,6 +159,9 @@ static void scmi_perf_domain_remove(struct scmi_device *sdev)
 	struct genpd_onecell_data *scmi_pd_data = dev_get_drvdata(dev);
 	int i;
 
+	if (!scmi_pd_data)
+		return;
+
 	of_genpd_del_provider(dev->of_node);
 
 	for (i = 0; i < scmi_pd_data->num_domains; i++)
diff --git a/drivers/pmdomain/qcom/rpmhpd.c b/drivers/pmdomain/qcom/rpmhpd.c
index f2e64324deb8..0f0943e3efe5 100644
--- a/drivers/pmdomain/qcom/rpmhpd.c
+++ b/drivers/pmdomain/qcom/rpmhpd.c
@@ -692,6 +692,7 @@ static int rpmhpd_aggregate_corner(struct rpmhpd *pd, unsigned int corner)
 	unsigned int active_corner, sleep_corner;
 	unsigned int this_active_corner = 0, this_sleep_corner = 0;
 	unsigned int peer_active_corner = 0, peer_sleep_corner = 0;
+	unsigned int peer_enabled_corner;
 
 	if (pd->state_synced) {
 		to_active_sleep(pd, corner, &this_active_corner, &this_sleep_corner);
@@ -701,9 +702,11 @@ static int rpmhpd_aggregate_corner(struct rpmhpd *pd, unsigned int corner)
 		this_sleep_corner = pd->level_count - 1;
 	}
 
-	if (peer && peer->enabled)
-		to_active_sleep(peer, peer->corner, &peer_active_corner,
+	if (peer && peer->enabled) {
+		peer_enabled_corner = max(peer->corner, peer->enable_corner);
+		to_active_sleep(peer, peer_enabled_corner, &peer_active_corner,
 				&peer_sleep_corner);
+	}
 
 	active_corner = max(this_active_corner, peer_active_corner);
 
diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index f21cb05815ec..3e31375491d5 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -978,6 +978,7 @@ config CHARGER_QCOM_SMB2
 config FUEL_GAUGE_MM8013
 	tristate "Mitsumi MM8013 fuel gauge driver"
 	depends on I2C
+	select REGMAP_I2C
 	help
 	  Say Y here to enable the Mitsumi MM8013 fuel gauge driver.
 	  It enables the monitoring of many battery parameters, including
diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/supply/bq27xxx_battery_i2c.c
index 9b5475590518..886e0a8e2abd 100644
--- a/drivers/power/supply/bq27xxx_battery_i2c.c
+++ b/drivers/power/supply/bq27xxx_battery_i2c.c
@@ -209,7 +209,9 @@ static void bq27xxx_battery_i2c_remove(struct i2c_client *client)
 {
 	struct bq27xxx_device_info *di = i2c_get_clientdata(client);
 
-	free_irq(client->irq, di);
+	if (client->irq)
+		free_irq(client->irq, di);
+
 	bq27xxx_battery_teardown(di);
 
 	mutex_lock(&battery_mutex);
diff --git a/drivers/soc/qcom/pmic_glink.c b/drivers/soc/qcom/pmic_glink.c
index 914057331afd..d05e15f107e3 100644
--- a/drivers/soc/qcom/pmic_glink.c
+++ b/drivers/soc/qcom/pmic_glink.c
@@ -268,10 +268,17 @@ static int pmic_glink_probe(struct platform_device *pdev)
 	else
 		pg->client_mask = PMIC_GLINK_CLIENT_DEFAULT;
 
+	pg->pdr = pdr_handle_alloc(pmic_glink_pdr_callback, pg);
+	if (IS_ERR(pg->pdr)) {
+		ret = dev_err_probe(&pdev->dev, PTR_ERR(pg->pdr),
+				    "failed to initialize pdr\n");
+		return ret;
+	}
+
 	if (pg->client_mask & BIT(PMIC_GLINK_CLIENT_UCSI)) {
 		ret = pmic_glink_add_aux_device(pg, &pg->ucsi_aux, "ucsi");
 		if (ret)
-			return ret;
+			goto out_release_pdr_handle;
 	}
 	if (pg->client_mask & BIT(PMIC_GLINK_CLIENT_ALTMODE)) {
 		ret = pmic_glink_add_aux_device(pg, &pg->altmode_aux, "altmode");
@@ -284,17 +291,11 @@ static int pmic_glink_probe(struct platform_device *pdev)
 			goto out_release_altmode_aux;
 	}
 
-	pg->pdr = pdr_handle_alloc(pmic_glink_pdr_callback, pg);
-	if (IS_ERR(pg->pdr)) {
-		ret = dev_err_probe(&pdev->dev, PTR_ERR(pg->pdr), "failed to initialize pdr\n");
-		goto out_release_aux_devices;
-	}
-
 	service = pdr_add_lookup(pg->pdr, "tms/servreg", "msm/adsp/charger_pd");
 	if (IS_ERR(service)) {
 		ret = dev_err_probe(&pdev->dev, PTR_ERR(service),
 				    "failed adding pdr lookup for charger_pd\n");
-		goto out_release_pdr_handle;
+		goto out_release_aux_devices;
 	}
 
 	mutex_lock(&__pmic_glink_lock);
@@ -303,8 +304,6 @@ static int pmic_glink_probe(struct platform_device *pdev)
 
 	return 0;
 
-out_release_pdr_handle:
-	pdr_handle_release(pg->pdr);
 out_release_aux_devices:
 	if (pg->client_mask & BIT(PMIC_GLINK_CLIENT_BATT))
 		pmic_glink_del_aux_device(pg, &pg->ps_aux);
@@ -314,6 +313,8 @@ static int pmic_glink_probe(struct platform_device *pdev)
 out_release_ucsi_aux:
 	if (pg->client_mask & BIT(PMIC_GLINK_CLIENT_UCSI))
 		pmic_glink_del_aux_device(pg, &pg->ucsi_aux);
+out_release_pdr_handle:
+	pdr_handle_release(pg->pdr);
 
 	return ret;
 }
diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index f94e0d370d46..731775d34d39 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1930,21 +1930,15 @@ static void cqspi_remove(struct platform_device *pdev)
 static int cqspi_suspend(struct device *dev)
 {
 	struct cqspi_st *cqspi = dev_get_drvdata(dev);
-	struct spi_controller *host = dev_get_drvdata(dev);
-	int ret;
 
-	ret = spi_controller_suspend(host);
 	cqspi_controller_enable(cqspi, 0);
-
 	clk_disable_unprepare(cqspi->clk);
-
-	return ret;
+	return 0;
 }
 
 static int cqspi_resume(struct device *dev)
 {
 	struct cqspi_st *cqspi = dev_get_drvdata(dev);
-	struct spi_controller *host = dev_get_drvdata(dev);
 
 	clk_prepare_enable(cqspi->clk);
 	cqspi_wait_idle(cqspi);
@@ -1952,8 +1946,7 @@ static int cqspi_resume(struct device *dev)
 
 	cqspi->current_cs = -1;
 	cqspi->sclk = 0;
-
-	return spi_controller_resume(host);
+	return 0;
 }
 
 static DEFINE_RUNTIME_DEV_PM_OPS(cqspi_dev_pm_ops, cqspi_suspend,
diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 63af6ab034b5..e6c45d585482 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2400,11 +2400,9 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
 	struct fbcon_ops *ops = info->fbcon_par;
 	struct fbcon_display *p = &fb_display[vc->vc_num];
 	int resize, ret, old_userfont, old_width, old_height, old_charcount;
-	char *old_data = NULL;
+	u8 *old_data = vc->vc_font.data;
 
 	resize = (w != vc->vc_font.width) || (h != vc->vc_font.height);
-	if (p->userfont)
-		old_data = vc->vc_font.data;
 	vc->vc_font.data = (void *)(p->fontdata = data);
 	old_userfont = p->userfont;
 	if ((p->userfont = userfont))
@@ -2438,13 +2436,13 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
 		update_screen(vc);
 	}
 
-	if (old_data && (--REFCOUNT(old_data) == 0))
+	if (old_userfont && (--REFCOUNT(old_data) == 0))
 		kfree(old_data - FONT_EXTRA_WORDS * sizeof(int));
 	return 0;
 
 err_out:
 	p->fontdata = old_data;
-	vc->vc_font.data = (void *)old_data;
+	vc->vc_font.data = old_data;
 
 	if (userfont) {
 		p->userfont = old_userfont;
diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 9140780be5a4..c097da6e9c5b 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -479,8 +479,10 @@ static int afs_dir_iterate_block(struct afs_vnode *dvnode,
 		    dire->u.name[0] == '.' &&
 		    ctx->actor != afs_lookup_filldir &&
 		    ctx->actor != afs_lookup_one_filldir &&
-		    memcmp(dire->u.name, ".__afs", 6) == 0)
+		    memcmp(dire->u.name, ".__afs", 6) == 0) {
+			ctx->pos = blkoff + next * sizeof(union afs_xdr_dirent);
 			continue;
+		}
 
 		/* found the next entry */
 		if (!dir_emit(ctx, dire->u.name, nlen,
diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index f9544fda38e9..f4928da96499 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -727,6 +727,23 @@ static int btrfs_dev_replace_start(struct btrfs_fs_info *fs_info,
 	return ret;
 }
 
+static int btrfs_check_replace_dev_names(struct btrfs_ioctl_dev_replace_args *args)
+{
+	if (args->start.srcdevid == 0) {
+		if (memchr(args->start.srcdev_name, 0,
+			   sizeof(args->start.srcdev_name)) == NULL)
+			return -ENAMETOOLONG;
+	} else {
+		args->start.srcdev_name[0] = 0;
+	}
+
+	if (memchr(args->start.tgtdev_name, 0,
+		   sizeof(args->start.tgtdev_name)) == NULL)
+	    return -ENAMETOOLONG;
+
+	return 0;
+}
+
 int btrfs_dev_replace_by_ioctl(struct btrfs_fs_info *fs_info,
 			    struct btrfs_ioctl_dev_replace_args *args)
 {
@@ -739,10 +756,9 @@ int btrfs_dev_replace_by_ioctl(struct btrfs_fs_info *fs_info,
 	default:
 		return -EINVAL;
 	}
-
-	if ((args->start.srcdevid == 0 && args->start.srcdev_name[0] == '\0') ||
-	    args->start.tgtdev_name[0] == '\0')
-		return -EINVAL;
+	ret = btrfs_check_replace_dev_names(args);
+	if (ret < 0)
+		return ret;
 
 	ret = btrfs_dev_replace_start(fs_info, args->start.tgtdev_name,
 					args->start.srcdevid,
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index c03091793aaa..233912c07f1c 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1286,12 +1286,12 @@ void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
  *
  * @objectid:	root id
  * @anon_dev:	preallocated anonymous block device number for new roots,
- * 		pass 0 for new allocation.
+ *		pass NULL for a new allocation.
  * @check_ref:	whether to check root item references, If true, return -ENOENT
  *		for orphan roots
  */
 static struct btrfs_root *btrfs_get_root_ref(struct btrfs_fs_info *fs_info,
-					     u64 objectid, dev_t anon_dev,
+					     u64 objectid, dev_t *anon_dev,
 					     bool check_ref)
 {
 	struct btrfs_root *root;
@@ -1321,9 +1321,9 @@ static struct btrfs_root *btrfs_get_root_ref(struct btrfs_fs_info *fs_info,
 		 * that common but still possible.  In that case, we just need
 		 * to free the anon_dev.
 		 */
-		if (unlikely(anon_dev)) {
-			free_anon_bdev(anon_dev);
-			anon_dev = 0;
+		if (unlikely(anon_dev && *anon_dev)) {
+			free_anon_bdev(*anon_dev);
+			*anon_dev = 0;
 		}
 
 		if (check_ref && btrfs_root_refs(&root->root_item) == 0) {
@@ -1345,7 +1345,7 @@ static struct btrfs_root *btrfs_get_root_ref(struct btrfs_fs_info *fs_info,
 		goto fail;
 	}
 
-	ret = btrfs_init_fs_root(root, anon_dev);
+	ret = btrfs_init_fs_root(root, anon_dev ? *anon_dev : 0);
 	if (ret)
 		goto fail;
 
@@ -1381,7 +1381,7 @@ static struct btrfs_root *btrfs_get_root_ref(struct btrfs_fs_info *fs_info,
 	 * root's anon_dev to 0 to avoid a double free, once by btrfs_put_root()
 	 * and once again by our caller.
 	 */
-	if (anon_dev)
+	if (anon_dev && *anon_dev)
 		root->anon_dev = 0;
 	btrfs_put_root(root);
 	return ERR_PTR(ret);
@@ -1397,7 +1397,7 @@ static struct btrfs_root *btrfs_get_root_ref(struct btrfs_fs_info *fs_info,
 struct btrfs_root *btrfs_get_fs_root(struct btrfs_fs_info *fs_info,
 				     u64 objectid, bool check_ref)
 {
-	return btrfs_get_root_ref(fs_info, objectid, 0, check_ref);
+	return btrfs_get_root_ref(fs_info, objectid, NULL, check_ref);
 }
 
 /*
@@ -1405,11 +1405,11 @@ struct btrfs_root *btrfs_get_fs_root(struct btrfs_fs_info *fs_info,
  * the anonymous block device id
  *
  * @objectid:	tree objectid
- * @anon_dev:	if zero, allocate a new anonymous block device or use the
- *		parameter value
+ * @anon_dev:	if NULL, allocate a new anonymous block device or use the
+ *		parameter value if not NULL
  */
 struct btrfs_root *btrfs_get_new_fs_root(struct btrfs_fs_info *fs_info,
-					 u64 objectid, dev_t anon_dev)
+					 u64 objectid, dev_t *anon_dev)
 {
 	return btrfs_get_root_ref(fs_info, objectid, anon_dev, true);
 }
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 50dab8f639dc..fca52385830c 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -64,7 +64,7 @@ void btrfs_free_fs_roots(struct btrfs_fs_info *fs_info);
 struct btrfs_root *btrfs_get_fs_root(struct btrfs_fs_info *fs_info,
 				     u64 objectid, bool check_ref);
 struct btrfs_root *btrfs_get_new_fs_root(struct btrfs_fs_info *fs_info,
-					 u64 objectid, dev_t anon_dev);
+					 u64 objectid, dev_t *anon_dev);
 struct btrfs_root *btrfs_get_fs_root_commit_root(struct btrfs_fs_info *fs_info,
 						 struct btrfs_path *path,
 						 u64 objectid);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 8f724c54fc8e..eade0432bd9c 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2436,6 +2436,7 @@ static int emit_fiemap_extent(struct fiemap_extent_info *fieinfo,
 				struct fiemap_cache *cache,
 				u64 offset, u64 phys, u64 len, u32 flags)
 {
+	u64 cache_end;
 	int ret = 0;
 
 	/* Set at the end of extent_fiemap(). */
@@ -2445,15 +2446,102 @@ static int emit_fiemap_extent(struct fiemap_extent_info *fieinfo,
 		goto assign;
 
 	/*
-	 * Sanity check, extent_fiemap() should have ensured that new
-	 * fiemap extent won't overlap with cached one.
-	 * Not recoverable.
+	 * When iterating the extents of the inode, at extent_fiemap(), we may
+	 * find an extent that starts at an offset behind the end offset of the
+	 * previous extent we processed. This happens if fiemap is called
+	 * without FIEMAP_FLAG_SYNC and there are ordered extents completing
+	 * while we call btrfs_next_leaf() (through fiemap_next_leaf_item()).
 	 *
-	 * NOTE: Physical address can overlap, due to compression
+	 * For example we are in leaf X processing its last item, which is the
+	 * file extent item for file range [512K, 1M[, and after
+	 * btrfs_next_leaf() releases the path, there's an ordered extent that
+	 * completes for the file range [768K, 2M[, and that results in trimming
+	 * the file extent item so that it now corresponds to the file range
+	 * [512K, 768K[ and a new file extent item is inserted for the file
+	 * range [768K, 2M[, which may end up as the last item of leaf X or as
+	 * the first item of the next leaf - in either case btrfs_next_leaf()
+	 * will leave us with a path pointing to the new extent item, for the
+	 * file range [768K, 2M[, since that's the first key that follows the
+	 * last one we processed. So in order not to report overlapping extents
+	 * to user space, we trim the length of the previously cached extent and
+	 * emit it.
+	 *
+	 * Upon calling btrfs_next_leaf() we may also find an extent with an
+	 * offset smaller than or equals to cache->offset, and this happens
+	 * when we had a hole or prealloc extent with several delalloc ranges in
+	 * it, but after btrfs_next_leaf() released the path, delalloc was
+	 * flushed and the resulting ordered extents were completed, so we can
+	 * now have found a file extent item for an offset that is smaller than
+	 * or equals to what we have in cache->offset. We deal with this as
+	 * described below.
 	 */
-	if (cache->offset + cache->len > offset) {
-		WARN_ON(1);
-		return -EINVAL;
+	cache_end = cache->offset + cache->len;
+	if (cache_end > offset) {
+		if (offset == cache->offset) {
+			/*
+			 * We cached a dealloc range (found in the io tree) for
+			 * a hole or prealloc extent and we have now found a
+			 * file extent item for the same offset. What we have
+			 * now is more recent and up to date, so discard what
+			 * we had in the cache and use what we have just found.
+			 */
+			goto assign;
+		} else if (offset > cache->offset) {
+			/*
+			 * The extent range we previously found ends after the
+			 * offset of the file extent item we found and that
+			 * offset falls somewhere in the middle of that previous
+			 * extent range. So adjust the range we previously found
+			 * to end at the offset of the file extent item we have
+			 * just found, since this extent is more up to date.
+			 * Emit that adjusted range and cache the file extent
+			 * item we have just found. This corresponds to the case
+			 * where a previously found file extent item was split
+			 * due to an ordered extent completing.
+			 */
+			cache->len = offset - cache->offset;
+			goto emit;
+		} else {
+			const u64 range_end = offset + len;
+
+			/*
+			 * The offset of the file extent item we have just found
+			 * is behind the cached offset. This means we were
+			 * processing a hole or prealloc extent for which we
+			 * have found delalloc ranges (in the io tree), so what
+			 * we have in the cache is the last delalloc range we
+			 * found while the file extent item we found can be
+			 * either for a whole delalloc range we previously
+			 * emmitted or only a part of that range.
+			 *
+			 * We have two cases here:
+			 *
+			 * 1) The file extent item's range ends at or behind the
+			 *    cached extent's end. In this case just ignore the
+			 *    current file extent item because we don't want to
+			 *    overlap with previous ranges that may have been
+			 *    emmitted already;
+			 *
+			 * 2) The file extent item starts behind the currently
+			 *    cached extent but its end offset goes beyond the
+			 *    end offset of the cached extent. We don't want to
+			 *    overlap with a previous range that may have been
+			 *    emmitted already, so we emit the currently cached
+			 *    extent and then partially store the current file
+			 *    extent item's range in the cache, for the subrange
+			 *    going the cached extent's end to the end of the
+			 *    file extent item.
+			 */
+			if (range_end <= cache_end)
+				return 0;
+
+			if (!(flags & (FIEMAP_EXTENT_ENCODED | FIEMAP_EXTENT_DELALLOC)))
+				phys += cache_end - offset;
+
+			offset = cache_end;
+			len = range_end - cache_end;
+			goto emit;
+		}
 	}
 
 	/*
@@ -2473,6 +2561,7 @@ static int emit_fiemap_extent(struct fiemap_extent_info *fieinfo,
 		return 0;
 	}
 
+emit:
 	/* Not mergeable, need to submit cached one */
 	ret = fiemap_fill_next_extent(fieinfo, cache->offset, cache->phys,
 				      cache->len, cache->flags);
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 0bd43b863c43..40d141d6894b 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -721,7 +721,7 @@ static noinline int create_subvol(struct mnt_idmap *idmap,
 	free_extent_buffer(leaf);
 	leaf = NULL;
 
-	new_root = btrfs_get_new_fs_root(fs_info, objectid, anon_dev);
+	new_root = btrfs_get_new_fs_root(fs_info, objectid, &anon_dev);
 	if (IS_ERR(new_root)) {
 		ret = PTR_ERR(new_root);
 		btrfs_abort_transaction(trans, ret);
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 77b182225809..4d165479dfc9 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -6705,11 +6705,20 @@ static int finish_inode_if_needed(struct send_ctx *sctx, int at_end)
 				if (ret)
 					goto out;
 			}
-			if (sctx->cur_inode_last_extent <
-			    sctx->cur_inode_size) {
-				ret = send_hole(sctx, sctx->cur_inode_size);
-				if (ret)
+			if (sctx->cur_inode_last_extent < sctx->cur_inode_size) {
+				ret = range_is_hole_in_parent(sctx,
+						      sctx->cur_inode_last_extent,
+						      sctx->cur_inode_size);
+				if (ret < 0) {
 					goto out;
+				} else if (ret == 0) {
+					ret = send_hole(sctx, sctx->cur_inode_size);
+					if (ret < 0)
+						goto out;
+				} else {
+					/* Range is already a hole, skip. */
+					ret = 0;
+				}
 			}
 		}
 		if (need_truncate) {
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index c52807d97efa..bf8e64c766b6 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1834,7 +1834,7 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 	}
 
 	key.offset = (u64)-1;
-	pending->snap = btrfs_get_new_fs_root(fs_info, objectid, pending->anon_dev);
+	pending->snap = btrfs_get_new_fs_root(fs_info, objectid, &pending->anon_dev);
 	if (IS_ERR(pending->snap)) {
 		ret = PTR_ERR(pending->snap);
 		pending->snap = NULL;
diff --git a/fs/ceph/mdsmap.c b/fs/ceph/mdsmap.c
index fae97c25ce58..8109aba66e02 100644
--- a/fs/ceph/mdsmap.c
+++ b/fs/ceph/mdsmap.c
@@ -380,10 +380,11 @@ struct ceph_mdsmap *ceph_mdsmap_decode(struct ceph_mds_client *mdsc, void **p,
 		ceph_decode_skip_8(p, end, bad_ext);
 		/* required_client_features */
 		ceph_decode_skip_set(p, end, 64, bad_ext);
+		/* bal_rank_mask */
+		ceph_decode_skip_string(p, end, bad_ext);
+	}
+	if (mdsmap_ev >= 18) {
 		ceph_decode_64_safe(p, end, m->m_max_xattr_size, bad_ext);
-	} else {
-		/* This forces the usage of the (sync) SETXATTR Op */
-		m->m_max_xattr_size = 0;
 	}
 bad_ext:
 	doutc(cl, "m_enabled: %d, m_damaged: %d, m_num_laggy: %d\n",
diff --git a/fs/ceph/mdsmap.h b/fs/ceph/mdsmap.h
index 89f1931f1ba6..1f2171dd01bf 100644
--- a/fs/ceph/mdsmap.h
+++ b/fs/ceph/mdsmap.h
@@ -27,7 +27,11 @@ struct ceph_mdsmap {
 	u32 m_session_timeout;          /* seconds */
 	u32 m_session_autoclose;        /* seconds */
 	u64 m_max_file_size;
-	u64 m_max_xattr_size;		/* maximum size for xattrs blob */
+	/*
+	 * maximum size for xattrs blob.
+	 * Zeroed by default to force the usage of the (sync) SETXATTR Op.
+	 */
+	u64 m_max_xattr_size;
 	u32 m_max_mds;			/* expected up:active mds number */
 	u32 m_num_active_mds;		/* actual up:active mds number */
 	u32 possible_max_rank;		/* possible max rank index */
diff --git a/fs/efivarfs/vars.c b/fs/efivarfs/vars.c
index 9e4f47808bd5..13bc60698955 100644
--- a/fs/efivarfs/vars.c
+++ b/fs/efivarfs/vars.c
@@ -372,7 +372,7 @@ static void dup_variable_bug(efi_char16_t *str16, efi_guid_t *vendor_guid,
 int efivar_init(int (*func)(efi_char16_t *, efi_guid_t, unsigned long, void *),
 		void *data, bool duplicates, struct list_head *head)
 {
-	unsigned long variable_name_size = 1024;
+	unsigned long variable_name_size = 512;
 	efi_char16_t *variable_name;
 	efi_status_t status;
 	efi_guid_t vendor_guid;
@@ -389,12 +389,13 @@ int efivar_init(int (*func)(efi_char16_t *, efi_guid_t, unsigned long, void *),
 		goto free;
 
 	/*
-	 * Per EFI spec, the maximum storage allocated for both
-	 * the variable name and variable data is 1024 bytes.
+	 * A small set of old UEFI implementations reject sizes
+	 * above a certain threshold, the lowest seen in the wild
+	 * is 512.
 	 */
 
 	do {
-		variable_name_size = 1024;
+		variable_name_size = 512;
 
 		status = efivar_get_next_variable(&variable_name_size,
 						  variable_name,
@@ -431,9 +432,13 @@ int efivar_init(int (*func)(efi_char16_t *, efi_guid_t, unsigned long, void *),
 			break;
 		case EFI_NOT_FOUND:
 			break;
+		case EFI_BUFFER_TOO_SMALL:
+			pr_warn("efivars: Variable name size exceeds maximum (%lu > 512)\n",
+				variable_name_size);
+			status = EFI_NOT_FOUND;
+			break;
 		default:
-			printk(KERN_WARNING "efivars: get_next_variable: status=%lx\n",
-				status);
+			pr_warn("efivars: get_next_variable: status=%lx\n", status);
 			status = EFI_NOT_FOUND;
 			break;
 		}
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index b664caea8b4e..9e345d3c305a 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -668,8 +668,10 @@ static int nfs_writepage_locked(struct folio *folio,
 	int err;
 
 	if (wbc->sync_mode == WB_SYNC_NONE &&
-	    NFS_SERVER(inode)->write_congested)
+	    NFS_SERVER(inode)->write_congested) {
+		folio_redirty_for_writepage(wbc, folio);
 		return AOP_WRITEPAGE_ACTIVATE;
+	}
 
 	nfs_inc_stats(inode, NFSIOS_VFSWRITEPAGE);
 	nfs_pageio_init_write(&pgio, inode, 0, false,
diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index 555aae5448ae..bd1e361b351c 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -83,7 +83,7 @@ struct bvec_iter {
 
 	unsigned int            bi_bvec_done;	/* number of bytes completed in
 						   current bvec */
-} __packed;
+} __packed __aligned(4);
 
 struct bvec_iter_all {
 	struct bio_vec	bv;
diff --git a/include/linux/netfilter.h b/include/linux/netfilter.h
index 80900d910992..ce660d51549b 100644
--- a/include/linux/netfilter.h
+++ b/include/linux/netfilter.h
@@ -474,6 +474,7 @@ struct nf_ct_hook {
 			      const struct sk_buff *);
 	void (*attach)(struct sk_buff *nskb, const struct sk_buff *skb);
 	void (*set_closing)(struct nf_conntrack *nfct);
+	int (*confirm)(struct sk_buff *skb);
 };
 extern const struct nf_ct_hook __rcu *nf_ct_hook;
 
diff --git a/include/net/mctp.h b/include/net/mctp.h
index da86e106c91d..2bff5f47ce82 100644
--- a/include/net/mctp.h
+++ b/include/net/mctp.h
@@ -249,6 +249,7 @@ struct mctp_route {
 struct mctp_route *mctp_route_lookup(struct net *net, unsigned int dnet,
 				     mctp_eid_t daddr);
 
+/* always takes ownership of skb */
 int mctp_local_output(struct sock *sk, struct mctp_route *rt,
 		      struct sk_buff *skb, mctp_eid_t daddr, u8 req_tag);
 
diff --git a/include/sound/soc-card.h b/include/sound/soc-card.h
index ecc02e955279..1f4c39922d82 100644
--- a/include/sound/soc-card.h
+++ b/include/sound/soc-card.h
@@ -30,6 +30,8 @@ static inline void snd_soc_card_mutex_unlock(struct snd_soc_card *card)
 
 struct snd_kcontrol *snd_soc_card_get_kcontrol(struct snd_soc_card *soc_card,
 					       const char *name);
+struct snd_kcontrol *snd_soc_card_get_kcontrol_locked(struct snd_soc_card *soc_card,
+						      const char *name);
 int snd_soc_card_jack_new(struct snd_soc_card *card, const char *id, int type,
 			  struct snd_soc_jack *jack);
 int snd_soc_card_jack_new_pins(struct snd_soc_card *card, const char *id,
diff --git a/include/uapi/linux/in6.h b/include/uapi/linux/in6.h
index c4c53a9ab959..ff8d21f9e95b 100644
--- a/include/uapi/linux/in6.h
+++ b/include/uapi/linux/in6.h
@@ -145,7 +145,7 @@ struct in6_flowlabel_req {
 #define IPV6_TLV_PADN		1
 #define IPV6_TLV_ROUTERALERT	5
 #define IPV6_TLV_CALIPSO	7	/* RFC 5570 */
-#define IPV6_TLV_IOAM		49	/* TEMPORARY IANA allocation for IOAM */
+#define IPV6_TLV_IOAM		49	/* RFC 9486 */
 #define IPV6_TLV_JUMBO		194
 #define IPV6_TLV_HAO		201	/* home address option */
 
diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index 6cd2a4e3afb8..9ff018245840 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -189,9 +189,6 @@ static int fprobe_init_rethook(struct fprobe *fp, int num)
 {
 	int size;
 
-	if (num <= 0)
-		return -EINVAL;
-
 	if (!fp->exit_handler) {
 		fp->rethook = NULL;
 		return 0;
@@ -199,15 +196,16 @@ static int fprobe_init_rethook(struct fprobe *fp, int num)
 
 	/* Initialize rethook if needed */
 	if (fp->nr_maxactive)
-		size = fp->nr_maxactive;
+		num = fp->nr_maxactive;
 	else
-		size = num * num_possible_cpus() * 2;
-	if (size <= 0)
+		num *= num_possible_cpus() * 2;
+	if (num <= 0)
 		return -EINVAL;
 
+	size = sizeof(struct fprobe_rethook_node) + fp->entry_data_size;
+
 	/* Initialize rethook */
-	fp->rethook = rethook_alloc((void *)fp, fprobe_exit_handler,
-				sizeof(struct fprobe_rethook_node), size);
+	fp->rethook = rethook_alloc((void *)fp, fprobe_exit_handler, size, num);
 	if (IS_ERR(fp->rethook))
 		return PTR_ERR(fp->rethook);
 
diff --git a/lib/nlattr.c b/lib/nlattr.c
index dc15e7888fc1..0319e811bb10 100644
--- a/lib/nlattr.c
+++ b/lib/nlattr.c
@@ -30,6 +30,8 @@ static const u8 nla_attr_len[NLA_TYPE_MAX+1] = {
 	[NLA_S16]	= sizeof(s16),
 	[NLA_S32]	= sizeof(s32),
 	[NLA_S64]	= sizeof(s64),
+	[NLA_BE16]	= sizeof(__be16),
+	[NLA_BE32]	= sizeof(__be32),
 };
 
 static const u8 nla_attr_minlen[NLA_TYPE_MAX+1] = {
@@ -43,6 +45,8 @@ static const u8 nla_attr_minlen[NLA_TYPE_MAX+1] = {
 	[NLA_S16]	= sizeof(s16),
 	[NLA_S32]	= sizeof(s32),
 	[NLA_S64]	= sizeof(s64),
+	[NLA_BE16]	= sizeof(__be16),
+	[NLA_BE32]	= sizeof(__be32),
 };
 
 /*
diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index e651500e597a..5c4dc7a0c50d 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -362,6 +362,12 @@ static void __init pud_advanced_tests(struct pgtable_debug_args *args)
 	vaddr &= HPAGE_PUD_MASK;
 
 	pud = pfn_pud(args->pud_pfn, args->page_prot);
+	/*
+	 * Some architectures have debug checks to make sure
+	 * huge pud mapping are only found with devmap entries
+	 * For now test with only devmap entries.
+	 */
+	pud = pud_mkdevmap(pud);
 	set_pud_at(args->mm, vaddr, args->pudp, pud);
 	flush_dcache_page(page);
 	pudp_set_wrprotect(args->mm, vaddr, args->pudp);
@@ -374,6 +380,7 @@ static void __init pud_advanced_tests(struct pgtable_debug_args *args)
 	WARN_ON(!pud_none(pud));
 #endif /* __PAGETABLE_PMD_FOLDED */
 	pud = pfn_pud(args->pud_pfn, args->page_prot);
+	pud = pud_mkdevmap(pud);
 	pud = pud_wrprotect(pud);
 	pud = pud_mkclean(pud);
 	set_pud_at(args->mm, vaddr, args->pudp, pud);
@@ -391,6 +398,7 @@ static void __init pud_advanced_tests(struct pgtable_debug_args *args)
 #endif /* __PAGETABLE_PMD_FOLDED */
 
 	pud = pfn_pud(args->pud_pfn, args->page_prot);
+	pud = pud_mkdevmap(pud);
 	pud = pud_mkyoung(pud);
 	set_pud_at(args->mm, vaddr, args->pudp, pud);
 	flush_dcache_page(page);
diff --git a/mm/filemap.c b/mm/filemap.c
index ad5b4aa049a3..5be7887957c7 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -4108,28 +4108,40 @@ static void filemap_cachestat(struct address_space *mapping,
 
 	rcu_read_lock();
 	xas_for_each(&xas, folio, last_index) {
+		int order;
 		unsigned long nr_pages;
 		pgoff_t folio_first_index, folio_last_index;
 
+		/*
+		 * Don't deref the folio. It is not pinned, and might
+		 * get freed (and reused) underneath us.
+		 *
+		 * We *could* pin it, but that would be expensive for
+		 * what should be a fast and lightweight syscall.
+		 *
+		 * Instead, derive all information of interest from
+		 * the rcu-protected xarray.
+		 */
+
 		if (xas_retry(&xas, folio))
 			continue;
 
+		order = xa_get_order(xas.xa, xas.xa_index);
+		nr_pages = 1 << order;
+		folio_first_index = round_down(xas.xa_index, 1 << order);
+		folio_last_index = folio_first_index + nr_pages - 1;
+
+		/* Folios might straddle the range boundaries, only count covered pages */
+		if (folio_first_index < first_index)
+			nr_pages -= first_index - folio_first_index;
+
+		if (folio_last_index > last_index)
+			nr_pages -= folio_last_index - last_index;
+
 		if (xa_is_value(folio)) {
 			/* page is evicted */
 			void *shadow = (void *)folio;
 			bool workingset; /* not used */
-			int order = xa_get_order(xas.xa, xas.xa_index);
-
-			nr_pages = 1 << order;
-			folio_first_index = round_down(xas.xa_index, 1 << order);
-			folio_last_index = folio_first_index + nr_pages - 1;
-
-			/* Folios might straddle the range boundaries, only count covered pages */
-			if (folio_first_index < first_index)
-				nr_pages -= first_index - folio_first_index;
-
-			if (folio_last_index > last_index)
-				nr_pages -= folio_last_index - last_index;
 
 			cs->nr_evicted += nr_pages;
 
@@ -4147,24 +4159,13 @@ static void filemap_cachestat(struct address_space *mapping,
 			goto resched;
 		}
 
-		nr_pages = folio_nr_pages(folio);
-		folio_first_index = folio_pgoff(folio);
-		folio_last_index = folio_first_index + nr_pages - 1;
-
-		/* Folios might straddle the range boundaries, only count covered pages */
-		if (folio_first_index < first_index)
-			nr_pages -= first_index - folio_first_index;
-
-		if (folio_last_index > last_index)
-			nr_pages -= folio_last_index - last_index;
-
 		/* page is in cache */
 		cs->nr_cache += nr_pages;
 
-		if (folio_test_dirty(folio))
+		if (xas_get_mark(&xas, PAGECACHE_TAG_DIRTY))
 			cs->nr_dirty += nr_pages;
 
-		if (folio_test_writeback(folio))
+		if (xas_get_mark(&xas, PAGECACHE_TAG_WRITEBACK))
 			cs->nr_writeback += nr_pages;
 
 resched:
diff --git a/mm/migrate.c b/mm/migrate.c
index bad3039d165e..a6999ce57e23 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2517,6 +2517,14 @@ static int numamigrate_isolate_folio(pg_data_t *pgdat, struct folio *folio)
 			if (managed_zone(pgdat->node_zones + z))
 				break;
 		}
+
+		/*
+		 * If there are no managed zones, it should not proceed
+		 * further.
+		 */
+		if (z < 0)
+			return 0;
+
 		wakeup_kswapd(pgdat->node_zones + z, 0,
 			      folio_order(folio), ZONE_MOVABLE);
 		return 0;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 65601aa52e0d..2821a42cefdc 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1049,6 +1049,7 @@ static void hci_error_reset(struct work_struct *work)
 {
 	struct hci_dev *hdev = container_of(work, struct hci_dev, error_reset);
 
+	hci_dev_hold(hdev);
 	BT_DBG("%s", hdev->name);
 
 	if (hdev->hw_error)
@@ -1056,10 +1057,10 @@ static void hci_error_reset(struct work_struct *work)
 	else
 		bt_dev_err(hdev, "hardware error 0x%2.2x", hdev->hw_error_code);
 
-	if (hci_dev_do_close(hdev))
-		return;
+	if (!hci_dev_do_close(hdev))
+		hci_dev_do_open(hdev);
 
-	hci_dev_do_open(hdev);
+	hci_dev_put(hdev);
 }
 
 void hci_uuids_clear(struct hci_dev *hdev)
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index ef8c3bed7361..2a5f5a7d2412 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5329,9 +5329,12 @@ static void hci_io_capa_request_evt(struct hci_dev *hdev, void *data,
 	hci_dev_lock(hdev);
 
 	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &ev->bdaddr);
-	if (!conn || !hci_conn_ssp_enabled(conn))
+	if (!conn || !hci_dev_test_flag(hdev, HCI_SSP_ENABLED))
 		goto unlock;
 
+	/* Assume remote supports SSP since it has triggered this event */
+	set_bit(HCI_CONN_SSP_ENABLED, &conn->flags);
+
 	hci_conn_hold(conn);
 
 	if (!hci_dev_test_flag(hdev, HCI_MGMT))
@@ -6794,6 +6797,10 @@ static void hci_le_remote_conn_param_req_evt(struct hci_dev *hdev, void *data,
 		return send_conn_param_neg_reply(hdev, handle,
 						 HCI_ERROR_UNKNOWN_CONN_ID);
 
+	if (max > hcon->le_conn_max_interval)
+		return send_conn_param_neg_reply(hdev, handle,
+						 HCI_ERROR_INVALID_LL_PARAMS);
+
 	if (hci_check_conn_params(min, max, latency, timeout))
 		return send_conn_param_neg_reply(hdev, handle,
 						 HCI_ERROR_INVALID_LL_PARAMS);
@@ -7420,10 +7427,10 @@ static void hci_store_wake_reason(struct hci_dev *hdev, u8 event,
 	 * keep track of the bdaddr of the connection event that woke us up.
 	 */
 	if (event == HCI_EV_CONN_REQUEST) {
-		bacpy(&hdev->wake_addr, &conn_complete->bdaddr);
+		bacpy(&hdev->wake_addr, &conn_request->bdaddr);
 		hdev->wake_addr_type = BDADDR_BREDR;
 	} else if (event == HCI_EV_CONN_COMPLETE) {
-		bacpy(&hdev->wake_addr, &conn_request->bdaddr);
+		bacpy(&hdev->wake_addr, &conn_complete->bdaddr);
 		hdev->wake_addr_type = BDADDR_BREDR;
 	} else if (event == HCI_EV_LE_META) {
 		struct hci_ev_le_meta *le_ev = (void *)skb->data;
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 97284d9b2a2e..b90ee68bba1d 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -2274,8 +2274,11 @@ static int hci_le_add_accept_list_sync(struct hci_dev *hdev,
 
 	/* During suspend, only wakeable devices can be in acceptlist */
 	if (hdev->suspended &&
-	    !(params->flags & HCI_CONN_FLAG_REMOTE_WAKEUP))
+	    !(params->flags & HCI_CONN_FLAG_REMOTE_WAKEUP)) {
+		hci_le_del_accept_list_sync(hdev, &params->addr,
+					    params->addr_type);
 		return 0;
+	}
 
 	/* Select filter policy to accept all advertising */
 	if (*num_entries >= hdev->le_accept_list_size)
@@ -5629,7 +5632,7 @@ static int hci_inquiry_sync(struct hci_dev *hdev, u8 length)
 
 	bt_dev_dbg(hdev, "");
 
-	if (hci_dev_test_flag(hdev, HCI_INQUIRY))
+	if (test_bit(HCI_INQUIRY, &hdev->flags))
 		return 0;
 
 	hci_dev_lock(hdev);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 60298975d5c4..656f49b299d2 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5613,7 +5613,13 @@ static inline int l2cap_conn_param_update_req(struct l2cap_conn *conn,
 
 	memset(&rsp, 0, sizeof(rsp));
 
-	err = hci_check_conn_params(min, max, latency, to_multiplier);
+	if (max > hcon->le_conn_max_interval) {
+		BT_DBG("requested connection interval exceeds current bounds.");
+		err = -EINVAL;
+	} else {
+		err = hci_check_conn_params(min, max, latency, to_multiplier);
+	}
+
 	if (err)
 		rsp.result = cpu_to_le16(L2CAP_CONN_PARAM_REJECTED);
 	else
diff --git a/net/bridge/br_netfilter_hooks.c b/net/bridge/br_netfilter_hooks.c
index ed1720890757..35e10c5a766d 100644
--- a/net/bridge/br_netfilter_hooks.c
+++ b/net/bridge/br_netfilter_hooks.c
@@ -43,6 +43,10 @@
 #include <linux/sysctl.h>
 #endif
 
+#if IS_ENABLED(CONFIG_NF_CONNTRACK)
+#include <net/netfilter/nf_conntrack_core.h>
+#endif
+
 static unsigned int brnf_net_id __read_mostly;
 
 struct brnf_net {
@@ -553,6 +557,90 @@ static unsigned int br_nf_pre_routing(void *priv,
 	return NF_STOLEN;
 }
 
+#if IS_ENABLED(CONFIG_NF_CONNTRACK)
+/* conntracks' nf_confirm logic cannot handle cloned skbs referencing
+ * the same nf_conn entry, which will happen for multicast (broadcast)
+ * Frames on bridges.
+ *
+ * Example:
+ *      macvlan0
+ *      br0
+ *  ethX  ethY
+ *
+ * ethX (or Y) receives multicast or broadcast packet containing
+ * an IP packet, not yet in conntrack table.
+ *
+ * 1. skb passes through bridge and fake-ip (br_netfilter)Prerouting.
+ *    -> skb->_nfct now references a unconfirmed entry
+ * 2. skb is broad/mcast packet. bridge now passes clones out on each bridge
+ *    interface.
+ * 3. skb gets passed up the stack.
+ * 4. In macvlan case, macvlan driver retains clone(s) of the mcast skb
+ *    and schedules a work queue to send them out on the lower devices.
+ *
+ *    The clone skb->_nfct is not a copy, it is the same entry as the
+ *    original skb.  The macvlan rx handler then returns RX_HANDLER_PASS.
+ * 5. Normal conntrack hooks (in NF_INET_LOCAL_IN) confirm the orig skb.
+ *
+ * The Macvlan broadcast worker and normal confirm path will race.
+ *
+ * This race will not happen if step 2 already confirmed a clone. In that
+ * case later steps perform skb_clone() with skb->_nfct already confirmed (in
+ * hash table).  This works fine.
+ *
+ * But such confirmation won't happen when eb/ip/nftables rules dropped the
+ * packets before they reached the nf_confirm step in postrouting.
+ *
+ * Work around this problem by explicit confirmation of the entry at
+ * LOCAL_IN time, before upper layer has a chance to clone the unconfirmed
+ * entry.
+ *
+ */
+static unsigned int br_nf_local_in(void *priv,
+				   struct sk_buff *skb,
+				   const struct nf_hook_state *state)
+{
+	struct nf_conntrack *nfct = skb_nfct(skb);
+	const struct nf_ct_hook *ct_hook;
+	struct nf_conn *ct;
+	int ret;
+
+	if (!nfct || skb->pkt_type == PACKET_HOST)
+		return NF_ACCEPT;
+
+	ct = container_of(nfct, struct nf_conn, ct_general);
+	if (likely(nf_ct_is_confirmed(ct)))
+		return NF_ACCEPT;
+
+	WARN_ON_ONCE(skb_shared(skb));
+	WARN_ON_ONCE(refcount_read(&nfct->use) != 1);
+
+	/* We can't call nf_confirm here, it would create a dependency
+	 * on nf_conntrack module.
+	 */
+	ct_hook = rcu_dereference(nf_ct_hook);
+	if (!ct_hook) {
+		skb->_nfct = 0ul;
+		nf_conntrack_put(nfct);
+		return NF_ACCEPT;
+	}
+
+	nf_bridge_pull_encap_header(skb);
+	ret = ct_hook->confirm(skb);
+	switch (ret & NF_VERDICT_MASK) {
+	case NF_STOLEN:
+		return NF_STOLEN;
+	default:
+		nf_bridge_push_encap_header(skb);
+		break;
+	}
+
+	ct = container_of(nfct, struct nf_conn, ct_general);
+	WARN_ON_ONCE(!nf_ct_is_confirmed(ct));
+
+	return ret;
+}
+#endif
 
 /* PF_BRIDGE/FORWARD *************************************************/
 static int br_nf_forward_finish(struct net *net, struct sock *sk, struct sk_buff *skb)
@@ -964,6 +1052,14 @@ static const struct nf_hook_ops br_nf_ops[] = {
 		.hooknum = NF_BR_PRE_ROUTING,
 		.priority = NF_BR_PRI_BRNF,
 	},
+#if IS_ENABLED(CONFIG_NF_CONNTRACK)
+	{
+		.hook = br_nf_local_in,
+		.pf = NFPROTO_BRIDGE,
+		.hooknum = NF_BR_LOCAL_IN,
+		.priority = NF_BR_PRI_LAST,
+	},
+#endif
 	{
 		.hook = br_nf_forward,
 		.pf = NFPROTO_BRIDGE,
diff --git a/net/bridge/netfilter/nf_conntrack_bridge.c b/net/bridge/netfilter/nf_conntrack_bridge.c
index abb090f94ed2..6f877e31709b 100644
--- a/net/bridge/netfilter/nf_conntrack_bridge.c
+++ b/net/bridge/netfilter/nf_conntrack_bridge.c
@@ -291,6 +291,30 @@ static unsigned int nf_ct_bridge_pre(void *priv, struct sk_buff *skb,
 	return nf_conntrack_in(skb, &bridge_state);
 }
 
+static unsigned int nf_ct_bridge_in(void *priv, struct sk_buff *skb,
+				    const struct nf_hook_state *state)
+{
+	enum ip_conntrack_info ctinfo;
+	struct nf_conn *ct;
+
+	if (skb->pkt_type == PACKET_HOST)
+		return NF_ACCEPT;
+
+	/* nf_conntrack_confirm() cannot handle concurrent clones,
+	 * this happens for broad/multicast frames with e.g. macvlan on top
+	 * of the bridge device.
+	 */
+	ct = nf_ct_get(skb, &ctinfo);
+	if (!ct || nf_ct_is_confirmed(ct) || nf_ct_is_template(ct))
+		return NF_ACCEPT;
+
+	/* let inet prerouting call conntrack again */
+	skb->_nfct = 0;
+	nf_ct_put(ct);
+
+	return NF_ACCEPT;
+}
+
 static void nf_ct_bridge_frag_save(struct sk_buff *skb,
 				   struct nf_bridge_frag_data *data)
 {
@@ -385,6 +409,12 @@ static struct nf_hook_ops nf_ct_bridge_hook_ops[] __read_mostly = {
 		.hooknum	= NF_BR_PRE_ROUTING,
 		.priority	= NF_IP_PRI_CONNTRACK,
 	},
+	{
+		.hook		= nf_ct_bridge_in,
+		.pf		= NFPROTO_BRIDGE,
+		.hooknum	= NF_BR_LOCAL_IN,
+		.priority	= NF_IP_PRI_CONNTRACK_CONFIRM,
+	},
 	{
 		.hook		= nf_ct_bridge_post,
 		.pf		= NFPROTO_BRIDGE,
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index bf4c3f65ad99..8f9cd6b7926e 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -5164,10 +5164,9 @@ static int rtnl_bridge_setlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	struct net *net = sock_net(skb->sk);
 	struct ifinfomsg *ifm;
 	struct net_device *dev;
-	struct nlattr *br_spec, *attr = NULL;
+	struct nlattr *br_spec, *attr, *br_flags_attr = NULL;
 	int rem, err = -EOPNOTSUPP;
 	u16 flags = 0;
-	bool have_flags = false;
 
 	if (nlmsg_len(nlh) < sizeof(*ifm))
 		return -EINVAL;
@@ -5185,11 +5184,11 @@ static int rtnl_bridge_setlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	br_spec = nlmsg_find_attr(nlh, sizeof(struct ifinfomsg), IFLA_AF_SPEC);
 	if (br_spec) {
 		nla_for_each_nested(attr, br_spec, rem) {
-			if (nla_type(attr) == IFLA_BRIDGE_FLAGS && !have_flags) {
+			if (nla_type(attr) == IFLA_BRIDGE_FLAGS && !br_flags_attr) {
 				if (nla_len(attr) < sizeof(flags))
 					return -EINVAL;
 
-				have_flags = true;
+				br_flags_attr = attr;
 				flags = nla_get_u16(attr);
 			}
 
@@ -5233,8 +5232,8 @@ static int rtnl_bridge_setlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 		}
 	}
 
-	if (have_flags)
-		memcpy(nla_data(attr), &flags, sizeof(flags));
+	if (br_flags_attr)
+		memcpy(nla_data(br_flags_attr), &flags, sizeof(flags));
 out:
 	return err;
 }
diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
index 80cdc6f6b34c..0323ab5023c6 100644
--- a/net/hsr/hsr_forward.c
+++ b/net/hsr/hsr_forward.c
@@ -83,7 +83,7 @@ static bool is_supervision_frame(struct hsr_priv *hsr, struct sk_buff *skb)
 		return false;
 
 	/* Get next tlv */
-	total_length += sizeof(struct hsr_sup_tlv) + hsr_sup_tag->tlv.HSR_TLV_length;
+	total_length += hsr_sup_tag->tlv.HSR_TLV_length;
 	if (!pskb_may_pull(skb, total_length))
 		return false;
 	skb_pull(skb, total_length);
diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index beeae624c412..2d29fce7c560 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -554,6 +554,20 @@ static int tnl_update_pmtu(struct net_device *dev, struct sk_buff *skb,
 	return 0;
 }
 
+static void ip_tunnel_adj_headroom(struct net_device *dev, unsigned int headroom)
+{
+	/* we must cap headroom to some upperlimit, else pskb_expand_head
+	 * will overflow header offsets in skb_headers_offset_update().
+	 */
+	static const unsigned int max_allowed = 512;
+
+	if (headroom > max_allowed)
+		headroom = max_allowed;
+
+	if (headroom > READ_ONCE(dev->needed_headroom))
+		WRITE_ONCE(dev->needed_headroom, headroom);
+}
+
 void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 		       u8 proto, int tunnel_hlen)
 {
@@ -632,13 +646,13 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 	}
 
 	headroom += LL_RESERVED_SPACE(rt->dst.dev) + rt->dst.header_len;
-	if (headroom > READ_ONCE(dev->needed_headroom))
-		WRITE_ONCE(dev->needed_headroom, headroom);
-
-	if (skb_cow_head(skb, READ_ONCE(dev->needed_headroom))) {
+	if (skb_cow_head(skb, headroom)) {
 		ip_rt_put(rt);
 		goto tx_dropped;
 	}
+
+	ip_tunnel_adj_headroom(dev, headroom);
+
 	iptunnel_xmit(NULL, rt, skb, fl4.saddr, fl4.daddr, proto, tos, ttl,
 		      df, !net_eq(tunnel->net, dev_net(dev)));
 	return;
@@ -818,16 +832,16 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 
 	max_headroom = LL_RESERVED_SPACE(rt->dst.dev) + sizeof(struct iphdr)
 			+ rt->dst.header_len + ip_encap_hlen(&tunnel->encap);
-	if (max_headroom > READ_ONCE(dev->needed_headroom))
-		WRITE_ONCE(dev->needed_headroom, max_headroom);
 
-	if (skb_cow_head(skb, READ_ONCE(dev->needed_headroom))) {
+	if (skb_cow_head(skb, max_headroom)) {
 		ip_rt_put(rt);
 		DEV_STATS_INC(dev, tx_dropped);
 		kfree_skb(skb);
 		return;
 	}
 
+	ip_tunnel_adj_headroom(dev, max_headroom);
+
 	iptunnel_xmit(NULL, rt, skb, fl4.saddr, fl4.daddr, protocol, tos, ttl,
 		      df, !net_eq(tunnel->net, dev_net(dev)));
 	return;
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 5a839c5fb1a5..055230b669cf 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -5509,9 +5509,10 @@ static int inet6_rtm_getaddr(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 	}
 
 	addr = extract_addr(tb[IFA_ADDRESS], tb[IFA_LOCAL], &peer);
-	if (!addr)
-		return -EINVAL;
-
+	if (!addr) {
+		err = -EINVAL;
+		goto errout;
+	}
 	ifm = nlmsg_data(nlh);
 	if (ifm->ifa_index)
 		dev = dev_get_by_index(tgt_net, ifm->ifa_index);
diff --git a/net/mctp/route.c b/net/mctp/route.c
index 6218dcd07e18..ceee44ea09d9 100644
--- a/net/mctp/route.c
+++ b/net/mctp/route.c
@@ -888,7 +888,7 @@ int mctp_local_output(struct sock *sk, struct mctp_route *rt,
 		dev = dev_get_by_index_rcu(sock_net(sk), cb->ifindex);
 		if (!dev) {
 			rcu_read_unlock();
-			return rc;
+			goto out_free;
 		}
 		rt->dev = __mctp_dev_get(dev);
 		rcu_read_unlock();
@@ -903,7 +903,8 @@ int mctp_local_output(struct sock *sk, struct mctp_route *rt,
 		rt->mtu = 0;
 
 	} else {
-		return -EINVAL;
+		rc = -EINVAL;
+		goto out_free;
 	}
 
 	spin_lock_irqsave(&rt->dev->addrs_lock, flags);
@@ -966,12 +967,17 @@ int mctp_local_output(struct sock *sk, struct mctp_route *rt,
 		rc = mctp_do_fragment_route(rt, skb, mtu, tag);
 	}
 
+	/* route output functions consume the skb, even on error */
+	skb = NULL;
+
 out_release:
 	if (!ext_rt)
 		mctp_route_release(rt);
 
 	mctp_dev_put(tmp_rt.dev);
 
+out_free:
+	kfree_skb(skb);
 	return rc;
 }
 
diff --git a/net/mptcp/diag.c b/net/mptcp/diag.c
index 6ff6f14674aa..7017dd60659d 100644
--- a/net/mptcp/diag.c
+++ b/net/mptcp/diag.c
@@ -21,6 +21,9 @@ static int subflow_get_info(struct sock *sk, struct sk_buff *skb)
 	bool slow;
 	int err;
 
+	if (inet_sk_state_load(sk) == TCP_LISTEN)
+		return 0;
+
 	start = nla_nest_start_noflag(skb, INET_ULP_INFO_MPTCP);
 	if (!start)
 		return -EMSGSIZE;
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index e3e96a49f922..63fc0758c22d 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -981,10 +981,10 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
 	if (mp_opt->deny_join_id0)
 		WRITE_ONCE(msk->pm.remote_deny_join_id0, true);
 
-set_fully_established:
 	if (unlikely(!READ_ONCE(msk->pm.server_side)))
 		pr_warn_once("bogus mpc option on established client sk");
 
+set_fully_established:
 	mptcp_data_lock((struct sock *)msk);
 	__mptcp_subflow_fully_established(msk, subflow, mp_opt);
 	mptcp_data_unlock((struct sock *)msk);
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 01b3a8f2f0e9..6eabd1d79f08 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -495,6 +495,16 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 		goto destroy_err;
 	}
 
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+	if (addr_l.family == AF_INET && ipv6_addr_v4mapped(&addr_r.addr6)) {
+		ipv6_addr_set_v4mapped(addr_l.addr.s_addr, &addr_l.addr6);
+		addr_l.family = AF_INET6;
+	}
+	if (addr_r.family == AF_INET && ipv6_addr_v4mapped(&addr_l.addr6)) {
+		ipv6_addr_set_v4mapped(addr_r.addr.s_addr, &addr_r.addr6);
+		addr_r.family = AF_INET6;
+	}
+#endif
 	if (addr_l.family != addr_r.family) {
 		GENL_SET_ERR_MSG(info, "address families do not match");
 		err = -EINVAL;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 5305f2ff0fd2..046ab95bc0b1 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1274,6 +1274,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 		mpext = mptcp_get_ext(skb);
 		if (!mptcp_skb_can_collapse_to(data_seq, skb, mpext)) {
 			TCP_SKB_CB(skb)->eor = 1;
+			tcp_mark_push(tcp_sk(ssk), skb);
 			goto alloc_skb;
 		}
 
@@ -3191,8 +3192,50 @@ static struct ipv6_pinfo *mptcp_inet6_sk(const struct sock *sk)
 
 	return (struct ipv6_pinfo *)(((u8 *)sk) + offset);
 }
+
+static void mptcp_copy_ip6_options(struct sock *newsk, const struct sock *sk)
+{
+	const struct ipv6_pinfo *np = inet6_sk(sk);
+	struct ipv6_txoptions *opt;
+	struct ipv6_pinfo *newnp;
+
+	newnp = inet6_sk(newsk);
+
+	rcu_read_lock();
+	opt = rcu_dereference(np->opt);
+	if (opt) {
+		opt = ipv6_dup_options(newsk, opt);
+		if (!opt)
+			net_warn_ratelimited("%s: Failed to copy ip6 options\n", __func__);
+	}
+	RCU_INIT_POINTER(newnp->opt, opt);
+	rcu_read_unlock();
+}
 #endif
 
+static void mptcp_copy_ip_options(struct sock *newsk, const struct sock *sk)
+{
+	struct ip_options_rcu *inet_opt, *newopt = NULL;
+	const struct inet_sock *inet = inet_sk(sk);
+	struct inet_sock *newinet;
+
+	newinet = inet_sk(newsk);
+
+	rcu_read_lock();
+	inet_opt = rcu_dereference(inet->inet_opt);
+	if (inet_opt) {
+		newopt = sock_kmalloc(newsk, sizeof(*inet_opt) +
+				      inet_opt->opt.optlen, GFP_ATOMIC);
+		if (newopt)
+			memcpy(newopt, inet_opt, sizeof(*inet_opt) +
+			       inet_opt->opt.optlen);
+		else
+			net_warn_ratelimited("%s: Failed to copy ip options\n", __func__);
+	}
+	RCU_INIT_POINTER(newinet->inet_opt, newopt);
+	rcu_read_unlock();
+}
+
 struct sock *mptcp_sk_clone_init(const struct sock *sk,
 				 const struct mptcp_options_received *mp_opt,
 				 struct sock *ssk,
@@ -3213,6 +3256,13 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 
 	__mptcp_init_sock(nsk);
 
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+	if (nsk->sk_family == AF_INET6)
+		mptcp_copy_ip6_options(nsk, sk);
+	else
+#endif
+		mptcp_copy_ip_options(nsk, sk);
+
 	msk = mptcp_sk(nsk);
 	msk->local_key = subflow_req->local_key;
 	msk->token = subflow_req->token;
@@ -3224,7 +3274,7 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 	msk->write_seq = subflow_req->idsn + 1;
 	msk->snd_nxt = msk->write_seq;
 	msk->snd_una = msk->write_seq;
-	msk->wnd_end = msk->snd_nxt + req->rsk_rcv_wnd;
+	msk->wnd_end = msk->snd_nxt + tcp_sk(ssk)->snd_wnd;
 	msk->setsockopt_seq = mptcp_sk(sk)->setsockopt_seq;
 	mptcp_init_sched(msk, mptcp_sk(sk)->sched);
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 3e50baba1b2a..7384613ea244 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -790,6 +790,16 @@ static inline bool mptcp_data_fin_enabled(const struct mptcp_sock *msk)
 	       READ_ONCE(msk->write_seq) == READ_ONCE(msk->snd_nxt);
 }
 
+static inline void mptcp_write_space(struct sock *sk)
+{
+	if (sk_stream_is_writeable(sk)) {
+		/* pairs with memory barrier in mptcp_poll */
+		smp_mb();
+		if (test_and_clear_bit(MPTCP_NOSPACE, &mptcp_sk(sk)->flags))
+			sk_stream_write_space(sk);
+	}
+}
+
 static inline void __mptcp_sync_sndbuf(struct sock *sk)
 {
 	struct mptcp_subflow_context *subflow;
@@ -808,6 +818,7 @@ static inline void __mptcp_sync_sndbuf(struct sock *sk)
 
 	/* the msk max wmem limit is <nr_subflows> * tcp wmem[2] */
 	WRITE_ONCE(sk->sk_sndbuf, new_sndbuf);
+	mptcp_write_space(sk);
 }
 
 /* The called held both the msk socket and the subflow socket locks,
@@ -838,16 +849,6 @@ static inline void mptcp_propagate_sndbuf(struct sock *sk, struct sock *ssk)
 	local_bh_enable();
 }
 
-static inline void mptcp_write_space(struct sock *sk)
-{
-	if (sk_stream_is_writeable(sk)) {
-		/* pairs with memory barrier in mptcp_poll */
-		smp_mb();
-		if (test_and_clear_bit(MPTCP_NOSPACE, &mptcp_sk(sk)->flags))
-			sk_stream_write_space(sk);
-	}
-}
-
 void mptcp_destroy_common(struct mptcp_sock *msk, unsigned int flags);
 
 #define MPTCP_TOKEN_MAX_RETRIES	4
diff --git a/net/netfilter/nf_conntrack_core.c b/net/netfilter/nf_conntrack_core.c
index 2e5f3864d353..5b876fa7f9af 100644
--- a/net/netfilter/nf_conntrack_core.c
+++ b/net/netfilter/nf_conntrack_core.c
@@ -2756,6 +2756,7 @@ static const struct nf_ct_hook nf_conntrack_hook = {
 	.get_tuple_skb  = nf_conntrack_get_tuple_skb,
 	.attach		= nf_conntrack_attach,
 	.set_closing	= nf_conntrack_set_closing,
+	.confirm	= __nf_conntrack_confirm,
 };
 
 void nf_conntrack_init_end(void)
diff --git a/net/netfilter/nft_compat.c b/net/netfilter/nft_compat.c
index 1f9474fefe84..d3d11dede545 100644
--- a/net/netfilter/nft_compat.c
+++ b/net/netfilter/nft_compat.c
@@ -359,10 +359,20 @@ static int nft_target_validate(const struct nft_ctx *ctx,
 
 	if (ctx->family != NFPROTO_IPV4 &&
 	    ctx->family != NFPROTO_IPV6 &&
+	    ctx->family != NFPROTO_INET &&
 	    ctx->family != NFPROTO_BRIDGE &&
 	    ctx->family != NFPROTO_ARP)
 		return -EOPNOTSUPP;
 
+	ret = nft_chain_validate_hooks(ctx->chain,
+				       (1 << NF_INET_PRE_ROUTING) |
+				       (1 << NF_INET_LOCAL_IN) |
+				       (1 << NF_INET_FORWARD) |
+				       (1 << NF_INET_LOCAL_OUT) |
+				       (1 << NF_INET_POST_ROUTING));
+	if (ret)
+		return ret;
+
 	if (nft_is_base_chain(ctx->chain)) {
 		const struct nft_base_chain *basechain =
 						nft_base_chain(ctx->chain);
@@ -610,10 +620,20 @@ static int nft_match_validate(const struct nft_ctx *ctx,
 
 	if (ctx->family != NFPROTO_IPV4 &&
 	    ctx->family != NFPROTO_IPV6 &&
+	    ctx->family != NFPROTO_INET &&
 	    ctx->family != NFPROTO_BRIDGE &&
 	    ctx->family != NFPROTO_ARP)
 		return -EOPNOTSUPP;
 
+	ret = nft_chain_validate_hooks(ctx->chain,
+				       (1 << NF_INET_PRE_ROUTING) |
+				       (1 << NF_INET_LOCAL_IN) |
+				       (1 << NF_INET_FORWARD) |
+				       (1 << NF_INET_LOCAL_OUT) |
+				       (1 << NF_INET_POST_ROUTING));
+	if (ret)
+		return ret;
+
 	if (nft_is_base_chain(ctx->chain)) {
 		const struct nft_base_chain *basechain =
 						nft_base_chain(ctx->chain);
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index d9107b545d36..6ae782efb1ee 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -167,7 +167,7 @@ static inline u32 netlink_group_mask(u32 group)
 static struct sk_buff *netlink_to_full_skb(const struct sk_buff *skb,
 					   gfp_t gfp_mask)
 {
-	unsigned int len = skb_end_offset(skb);
+	unsigned int len = skb->len;
 	struct sk_buff *new;
 
 	new = alloc_skb(len, gfp_mask);
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index de96959336c4..211f57164cb6 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -52,6 +52,7 @@ struct tls_decrypt_arg {
 	struct_group(inargs,
 	bool zc;
 	bool async;
+	bool async_done;
 	u8 tail;
 	);
 
@@ -274,22 +275,30 @@ static int tls_do_decryption(struct sock *sk,
 		DEBUG_NET_WARN_ON_ONCE(atomic_read(&ctx->decrypt_pending) < 1);
 		atomic_inc(&ctx->decrypt_pending);
 	} else {
+		DECLARE_CRYPTO_WAIT(wait);
+
 		aead_request_set_callback(aead_req,
 					  CRYPTO_TFM_REQ_MAY_BACKLOG,
-					  crypto_req_done, &ctx->async_wait);
+					  crypto_req_done, &wait);
+		ret = crypto_aead_decrypt(aead_req);
+		if (ret == -EINPROGRESS || ret == -EBUSY)
+			ret = crypto_wait_req(ret, &wait);
+		return ret;
 	}
 
 	ret = crypto_aead_decrypt(aead_req);
+	if (ret == -EINPROGRESS)
+		return 0;
+
 	if (ret == -EBUSY) {
 		ret = tls_decrypt_async_wait(ctx);
-		ret = ret ?: -EINPROGRESS;
+		darg->async_done = true;
+		/* all completions have run, we're not doing async anymore */
+		darg->async = false;
+		return ret;
 	}
-	if (ret == -EINPROGRESS) {
-		if (darg->async)
-			return 0;
 
-		ret = crypto_wait_req(ret, &ctx->async_wait);
-	}
+	atomic_dec(&ctx->decrypt_pending);
 	darg->async = false;
 
 	return ret;
@@ -1588,8 +1597,11 @@ static int tls_decrypt_sg(struct sock *sk, struct iov_iter *out_iov,
 	/* Prepare and submit AEAD request */
 	err = tls_do_decryption(sk, sgin, sgout, dctx->iv,
 				data_len + prot->tail_size, aead_req, darg);
-	if (err)
+	if (err) {
+		if (darg->async_done)
+			goto exit_free_skb;
 		goto exit_free_pages;
+	}
 
 	darg->skb = clear_skb ?: tls_strp_msg(ctx);
 	clear_skb = NULL;
@@ -1601,6 +1613,9 @@ static int tls_decrypt_sg(struct sock *sk, struct iov_iter *out_iov,
 		return err;
 	}
 
+	if (unlikely(darg->async_done))
+		return 0;
+
 	if (prot->tail_size)
 		darg->tail = dctx->tail;
 
@@ -1948,6 +1963,7 @@ int tls_sw_recvmsg(struct sock *sk,
 	struct strp_msg *rxm;
 	struct tls_msg *tlm;
 	ssize_t copied = 0;
+	ssize_t peeked = 0;
 	bool async = false;
 	int target, err;
 	bool is_kvec = iov_iter_is_kvec(&msg->msg_iter);
@@ -2095,8 +2111,10 @@ int tls_sw_recvmsg(struct sock *sk,
 			if (err < 0)
 				goto put_on_rx_list_err;
 
-			if (is_peek)
+			if (is_peek) {
+				peeked += chunk;
 				goto put_on_rx_list;
+			}
 
 			if (partially_consumed) {
 				rxm->offset += chunk;
@@ -2135,8 +2153,8 @@ int tls_sw_recvmsg(struct sock *sk,
 
 		/* Drain records from the rx_list & copy if required */
 		if (is_peek || is_kvec)
-			err = process_rx_list(ctx, msg, &control, copied,
-					      decrypted, is_peek, NULL);
+			err = process_rx_list(ctx, msg, &control, copied + peeked,
+					      decrypted - peeked, is_peek, NULL);
 		else
 			err = process_rx_list(ctx, msg, &control, 0,
 					      async_copy_bytes, is_peek, NULL);
diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 8f63f0b4bf01..2a81880dac7b 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -284,9 +284,17 @@ void unix_gc(void)
 	 * which are creating the cycle(s).
 	 */
 	skb_queue_head_init(&hitlist);
-	list_for_each_entry(u, &gc_candidates, link)
+	list_for_each_entry(u, &gc_candidates, link) {
 		scan_children(&u->sk, inc_inflight, &hitlist);
 
+#if IS_ENABLED(CONFIG_AF_UNIX_OOB)
+		if (u->oob_skb) {
+			kfree_skb(u->oob_skb);
+			u->oob_skb = NULL;
+		}
+#endif
+	}
+
 	/* not_cycle_list contains those sockets which do not make up a
 	 * cycle.  Restore these to the inflight list.
 	 */
@@ -314,17 +322,6 @@ void unix_gc(void)
 	/* Here we are. Hitlist is filled. Die. */
 	__skb_queue_purge(&hitlist);
 
-#if IS_ENABLED(CONFIG_AF_UNIX_OOB)
-	list_for_each_entry_safe(u, next, &gc_candidates, link) {
-		struct sk_buff *skb = u->oob_skb;
-
-		if (skb) {
-			u->oob_skb = NULL;
-			kfree_skb(skb);
-		}
-	}
-#endif
-
 	spin_lock(&unix_gc_lock);
 
 	/* There could be io_uring registered files, just push them back to
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index fbf95b7ff6b4..f853b54415d5 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -4185,6 +4185,8 @@ static int nl80211_set_interface(struct sk_buff *skb, struct genl_info *info)
 
 		if (ntype != NL80211_IFTYPE_MESH_POINT)
 			return -EINVAL;
+		if (otype != NL80211_IFTYPE_MESH_POINT)
+			return -EINVAL;
 		if (netif_running(dev))
 			return -EBUSY;
 
diff --git a/scripts/Kconfig.include b/scripts/Kconfig.include
index 5a84b6443875..3ee8ecfb8c04 100644
--- a/scripts/Kconfig.include
+++ b/scripts/Kconfig.include
@@ -33,7 +33,7 @@ ld-option = $(success,$(LD) -v $(1))
 
 # $(as-instr,<instr>)
 # Return y if the assembler supports <instr>, n otherwise
-as-instr = $(success,printf "%b\n" "$(1)" | $(CC) $(CLANG_FLAGS) -c -x assembler-with-cpp -o /dev/null -)
+as-instr = $(success,printf "%b\n" "$(1)" | $(CC) $(CLANG_FLAGS) -Wa$(comma)--fatal-warnings -c -x assembler-with-cpp -o /dev/null -)
 
 # check if $(CC) and $(LD) exist
 $(error-if,$(failure,command -v $(CC)),C compiler '$(CC)' not found)
diff --git a/scripts/Makefile.compiler b/scripts/Makefile.compiler
index 8fcb427405a6..92be0c9a13ee 100644
--- a/scripts/Makefile.compiler
+++ b/scripts/Makefile.compiler
@@ -38,7 +38,7 @@ as-option = $(call try-run,\
 # Usage: aflags-y += $(call as-instr,instr,option1,option2)
 
 as-instr = $(call try-run,\
-	printf "%b\n" "$(1)" | $(CC) -Werror $(CLANG_FLAGS) $(KBUILD_AFLAGS) -c -x assembler-with-cpp -o "$$TMP" -,$(2),$(3))
+	printf "%b\n" "$(1)" | $(CC) -Werror $(CLANG_FLAGS) $(KBUILD_AFLAGS) -Wa$(comma)--fatal-warnings -c -x assembler-with-cpp -o "$$TMP" -,$(2),$(3))
 
 # __cc-option
 # Usage: MY_CFLAGS += $(call __cc-option,$(CC),$(MY_CFLAGS),-march=winchip-c6,-march=i586)
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index bc7c126deea2..6ea260cf89f0 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -737,8 +737,8 @@ static int current_check_refer_path(struct dentry *const old_dentry,
 	bool allow_parent1, allow_parent2;
 	access_mask_t access_request_parent1, access_request_parent2;
 	struct path mnt_dir;
-	layer_mask_t layer_masks_parent1[LANDLOCK_NUM_ACCESS_FS],
-		layer_masks_parent2[LANDLOCK_NUM_ACCESS_FS];
+	layer_mask_t layer_masks_parent1[LANDLOCK_NUM_ACCESS_FS] = {},
+		     layer_masks_parent2[LANDLOCK_NUM_ACCESS_FS] = {};
 
 	if (!dom)
 		return 0;
diff --git a/security/tomoyo/common.c b/security/tomoyo/common.c
index 57ee70ae50f2..ea3140d510ec 100644
--- a/security/tomoyo/common.c
+++ b/security/tomoyo/common.c
@@ -2649,13 +2649,14 @@ ssize_t tomoyo_write_control(struct tomoyo_io_buffer *head,
 {
 	int error = buffer_len;
 	size_t avail_len = buffer_len;
-	char *cp0 = head->write_buf;
+	char *cp0;
 	int idx;
 
 	if (!head->write)
 		return -EINVAL;
 	if (mutex_lock_interruptible(&head->io_sem))
 		return -EINTR;
+	cp0 = head->write_buf;
 	head->read_user_buf_avail = 0;
 	idx = tomoyo_read_lock();
 	/* Read a line and dispatch it to the policy handler. */
diff --git a/sound/core/Makefile b/sound/core/Makefile
index a6b444ee2832..f6526b337137 100644
--- a/sound/core/Makefile
+++ b/sound/core/Makefile
@@ -32,7 +32,6 @@ snd-ump-objs      := ump.o
 snd-ump-$(CONFIG_SND_UMP_LEGACY_RAWMIDI) += ump_convert.o
 snd-timer-objs    := timer.o
 snd-hrtimer-objs  := hrtimer.o
-snd-rtctimer-objs := rtctimer.o
 snd-hwdep-objs    := hwdep.o
 snd-seq-device-objs := seq_device.o
 
diff --git a/sound/core/ump.c b/sound/core/ump.c
index 3bef1944e955..fe7911498cc4 100644
--- a/sound/core/ump.c
+++ b/sound/core/ump.c
@@ -985,7 +985,7 @@ static int snd_ump_legacy_open(struct snd_rawmidi_substream *substream)
 	struct snd_ump_endpoint *ump = substream->rmidi->private_data;
 	int dir = substream->stream;
 	int group = ump->legacy_mapping[substream->number];
-	int err;
+	int err = 0;
 
 	mutex_lock(&ump->open_mutex);
 	if (ump->legacy_substreams[dir][group]) {
@@ -1009,7 +1009,7 @@ static int snd_ump_legacy_open(struct snd_rawmidi_substream *substream)
 	spin_unlock_irq(&ump->legacy_locks[dir]);
  unlock:
 	mutex_unlock(&ump->open_mutex);
-	return 0;
+	return err;
 }
 
 static int snd_ump_legacy_close(struct snd_rawmidi_substream *substream)
diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index a13c0b408aad..7be17bca257f 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -951,7 +951,7 @@ static int generate_tx_packet_descs(struct amdtp_stream *s, struct pkt_desc *des
 				// to the reason.
 				unsigned int safe_cycle = increment_ohci_cycle_count(next_cycle,
 								IR_JUMBO_PAYLOAD_MAX_SKIP_CYCLES);
-				lost = (compare_ohci_cycle_count(safe_cycle, cycle) > 0);
+				lost = (compare_ohci_cycle_count(safe_cycle, cycle) < 0);
 			}
 			if (lost) {
 				dev_err(&s->unit->device, "Detect discontinuity of cycle: %d %d\n",
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index e3096572881d..eb45e5c3db8c 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7438,6 +7438,7 @@ enum {
 	ALC287_FIXUP_LEGION_15IMHG05_AUTOMUTE,
 	ALC287_FIXUP_YOGA7_14ITL_SPEAKERS,
 	ALC298_FIXUP_LENOVO_C940_DUET7,
+	ALC287_FIXUP_LENOVO_14IRP8_DUETITL,
 	ALC287_FIXUP_13S_GEN2_SPEAKERS,
 	ALC256_FIXUP_SET_COEF_DEFAULTS,
 	ALC256_FIXUP_SYSTEM76_MIC_NO_PRESENCE,
@@ -7488,6 +7489,26 @@ static void alc298_fixup_lenovo_c940_duet7(struct hda_codec *codec,
 	__snd_hda_apply_fixup(codec, id, action, 0);
 }
 
+/* A special fixup for Lenovo Slim/Yoga Pro 9 14IRP8 and Yoga DuetITL 2021;
+ * 14IRP8 PCI SSID will mistakenly be matched with the DuetITL codec SSID,
+ * so we need to apply a different fixup in this case. The only DuetITL codec
+ * SSID reported so far is the 17aa:3802 while the 14IRP8 has the 17aa:38be
+ * and 17aa:38bf. If it weren't for the PCI SSID, the 14IRP8 models would
+ * have matched correctly by their codecs.
+ */
+static void alc287_fixup_lenovo_14irp8_duetitl(struct hda_codec *codec,
+					      const struct hda_fixup *fix,
+					      int action)
+{
+	int id;
+
+	if (codec->core.subsystem_id == 0x17aa3802)
+		id = ALC287_FIXUP_YOGA7_14ITL_SPEAKERS; /* DuetITL */
+	else
+		id = ALC287_FIXUP_TAS2781_I2C; /* 14IRP8 */
+	__snd_hda_apply_fixup(codec, id, action, 0);
+}
+
 static const struct hda_fixup alc269_fixups[] = {
 	[ALC269_FIXUP_GPIO2] = {
 		.type = HDA_FIXUP_FUNC,
@@ -9372,6 +9393,10 @@ static const struct hda_fixup alc269_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc298_fixup_lenovo_c940_duet7,
 	},
+	[ALC287_FIXUP_LENOVO_14IRP8_DUETITL] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc287_fixup_lenovo_14irp8_duetitl,
+	},
 	[ALC287_FIXUP_13S_GEN2_SPEAKERS] = {
 		.type = HDA_FIXUP_VERBS,
 		.v.verbs = (const struct hda_verb[]) {
@@ -9578,7 +9603,7 @@ static const struct hda_fixup alc269_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = tas2781_fixup_i2c,
 		.chained = true,
-		.chain_id = ALC269_FIXUP_THINKPAD_ACPI,
+		.chain_id = ALC285_FIXUP_THINKPAD_HEADSET_JACK,
 	},
 	[ALC245_FIXUP_HP_MUTE_LED_COEFBIT] = {
 		.type = HDA_FIXUP_FUNC,
@@ -9733,6 +9758,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1028, 0x0c1c, "Dell Precision 3540", ALC236_FIXUP_DELL_DUAL_CODECS),
 	SND_PCI_QUIRK(0x1028, 0x0c1d, "Dell Precision 3440", ALC236_FIXUP_DELL_DUAL_CODECS),
 	SND_PCI_QUIRK(0x1028, 0x0c1e, "Dell Precision 3540", ALC236_FIXUP_DELL_DUAL_CODECS),
+	SND_PCI_QUIRK(0x1028, 0x0c28, "Dell Inspiron 16 Plus 7630", ALC295_FIXUP_DELL_INSPIRON_TOP_SPEAKERS),
 	SND_PCI_QUIRK(0x1028, 0x0c4d, "Dell", ALC287_FIXUP_CS35L41_I2C_4),
 	SND_PCI_QUIRK(0x1028, 0x0cbd, "Dell Oasis 13 CS MTL-U", ALC289_FIXUP_DELL_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1028, 0x0cbe, "Dell Oasis 13 2-IN-1 MTL-U", ALC289_FIXUP_DELL_CS35L41_SPI_2),
@@ -9889,6 +9915,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8973, "HP EliteBook 860 G9", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8974, "HP EliteBook 840 Aero G9", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8975, "HP EliteBook x360 840 Aero G9", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x897d, "HP mt440 Mobile Thin Client U74", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8981, "HP Elite Dragonfly G3", ALC245_FIXUP_CS35L41_SPI_4),
 	SND_PCI_QUIRK(0x103c, 0x898e, "HP EliteBook 835 G9", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x898f, "HP EliteBook 835 G9", ALC287_FIXUP_CS35L41_I2C_2),
@@ -9914,11 +9941,13 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8aa3, "HP ProBook 450 G9 (MB 8AA1)", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8aa8, "HP EliteBook 640 G9 (MB 8AA6)", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8aab, "HP EliteBook 650 G9 (MB 8AA9)", ALC236_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8ab9, "HP EliteBook 840 G8 (MB 8AB8)", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8abb, "HP ZBook Firefly 14 G9", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8ad1, "HP EliteBook 840 14 inch G9 Notebook PC", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8ad2, "HP EliteBook 860 16 inch G9 Notebook PC", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8b0f, "HP Elite mt645 G7 Mobile Thin Client U81", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x103c, 0x8b2f, "HP 255 15.6 inch G10 Notebook PC", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
+	SND_PCI_QUIRK(0x103c, 0x8b3f, "HP mt440 Mobile Thin Client U91", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8b42, "HP", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8b43, "HP", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8b44, "HP", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
@@ -10235,7 +10264,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x31af, "ThinkCentre Station", ALC623_FIXUP_LENOVO_THINKSTATION_P340),
 	SND_PCI_QUIRK(0x17aa, 0x334b, "Lenovo ThinkCentre M70 Gen5", ALC283_FIXUP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x17aa, 0x3801, "Lenovo Yoga9 14IAP7", ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN),
-	SND_PCI_QUIRK(0x17aa, 0x3802, "Lenovo Yoga DuetITL 2021", ALC287_FIXUP_YOGA7_14ITL_SPEAKERS),
+	SND_PCI_QUIRK(0x17aa, 0x3802, "Lenovo Yoga Pro 9 14IRP8 / DuetITL 2021", ALC287_FIXUP_LENOVO_14IRP8_DUETITL),
 	SND_PCI_QUIRK(0x17aa, 0x3813, "Legion 7i 15IMHG05", ALC287_FIXUP_LEGION_15IMHG05_SPEAKERS),
 	SND_PCI_QUIRK(0x17aa, 0x3818, "Lenovo C940 / Yoga Duet 7", ALC298_FIXUP_LENOVO_C940_DUET7),
 	SND_PCI_QUIRK(0x17aa, 0x3819, "Lenovo 13s Gen2 ITL", ALC287_FIXUP_13S_GEN2_SPEAKERS),
diff --git a/sound/soc/codecs/cs35l45.c b/sound/soc/codecs/cs35l45.c
index 44c221745c3b..2392c6effed8 100644
--- a/sound/soc/codecs/cs35l45.c
+++ b/sound/soc/codecs/cs35l45.c
@@ -184,7 +184,7 @@ static int cs35l45_activate_ctl(struct snd_soc_component *component,
 	else
 		snprintf(name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN, "%s", ctl_name);
 
-	kcontrol = snd_soc_card_get_kcontrol(component->card, name);
+	kcontrol = snd_soc_card_get_kcontrol_locked(component->card, name);
 	if (!kcontrol) {
 		dev_err(component->dev, "Can't find kcontrol %s\n", name);
 		return -EINVAL;
diff --git a/sound/soc/codecs/cs35l56-shared.c b/sound/soc/codecs/cs35l56-shared.c
index 953ba066bab1..2eb397724b4b 100644
--- a/sound/soc/codecs/cs35l56-shared.c
+++ b/sound/soc/codecs/cs35l56-shared.c
@@ -34,10 +34,9 @@ static const struct reg_default cs35l56_reg_defaults[] = {
 	{ CS35L56_ASP1_FRAME_CONTROL5,		0x00020100 },
 	{ CS35L56_ASP1_DATA_CONTROL1,		0x00000018 },
 	{ CS35L56_ASP1_DATA_CONTROL5,		0x00000018 },
-	{ CS35L56_ASP1TX1_INPUT,		0x00000018 },
-	{ CS35L56_ASP1TX2_INPUT,		0x00000019 },
-	{ CS35L56_ASP1TX3_INPUT,		0x00000020 },
-	{ CS35L56_ASP1TX4_INPUT,		0x00000028 },
+
+	/* no defaults for ASP1TX mixer */
+
 	{ CS35L56_SWIRE_DP3_CH1_INPUT,		0x00000018 },
 	{ CS35L56_SWIRE_DP3_CH2_INPUT,		0x00000019 },
 	{ CS35L56_SWIRE_DP3_CH3_INPUT,		0x00000029 },
@@ -286,6 +285,7 @@ void cs35l56_wait_min_reset_pulse(void)
 EXPORT_SYMBOL_NS_GPL(cs35l56_wait_min_reset_pulse, SND_SOC_CS35L56_SHARED);
 
 static const struct reg_sequence cs35l56_system_reset_seq[] = {
+	REG_SEQ0(CS35L56_DSP1_HALO_STATE, 0),
 	REG_SEQ0(CS35L56_DSP_VIRTUAL1_MBOX_1, CS35L56_MBOX_CMD_SYSTEM_RESET),
 };
 
diff --git a/sound/soc/codecs/cs35l56.c b/sound/soc/codecs/cs35l56.c
index 45b4de3eff94..319347be0524 100644
--- a/sound/soc/codecs/cs35l56.c
+++ b/sound/soc/codecs/cs35l56.c
@@ -59,6 +59,131 @@ static int cs35l56_dspwait_put_volsw(struct snd_kcontrol *kcontrol,
 	return snd_soc_put_volsw(kcontrol, ucontrol);
 }
 
+static const unsigned short cs35l56_asp1_mixer_regs[] = {
+	CS35L56_ASP1TX1_INPUT, CS35L56_ASP1TX2_INPUT,
+	CS35L56_ASP1TX3_INPUT, CS35L56_ASP1TX4_INPUT,
+};
+
+static const char * const cs35l56_asp1_mux_control_names[] = {
+	"ASP1 TX1 Source", "ASP1 TX2 Source", "ASP1 TX3 Source", "ASP1 TX4 Source"
+};
+
+static int cs35l56_sync_asp1_mixer_widgets_with_firmware(struct cs35l56_private *cs35l56)
+{
+	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(cs35l56->component);
+	const char *prefix = cs35l56->component->name_prefix;
+	char full_name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
+	const char *name;
+	struct snd_kcontrol *kcontrol;
+	struct soc_enum *e;
+	unsigned int val[4];
+	int i, item, ret;
+
+	if (cs35l56->asp1_mixer_widgets_initialized)
+		return 0;
+
+	/*
+	 * Resume so we can read the registers from silicon if the regmap
+	 * cache has not yet been populated.
+	 */
+	ret = pm_runtime_resume_and_get(cs35l56->base.dev);
+	if (ret < 0)
+		return ret;
+
+	/* Wait for firmware download and reboot */
+	cs35l56_wait_dsp_ready(cs35l56);
+
+	ret = regmap_bulk_read(cs35l56->base.regmap, CS35L56_ASP1TX1_INPUT,
+			       val, ARRAY_SIZE(val));
+
+	pm_runtime_mark_last_busy(cs35l56->base.dev);
+	pm_runtime_put_autosuspend(cs35l56->base.dev);
+
+	if (ret) {
+		dev_err(cs35l56->base.dev, "Failed to read ASP1 mixer regs: %d\n", ret);
+		return ret;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(cs35l56_asp1_mux_control_names); ++i) {
+		name = cs35l56_asp1_mux_control_names[i];
+
+		if (prefix) {
+			snprintf(full_name, sizeof(full_name), "%s %s", prefix, name);
+			name = full_name;
+		}
+
+		kcontrol = snd_soc_card_get_kcontrol_locked(dapm->card, name);
+		if (!kcontrol) {
+			dev_warn(cs35l56->base.dev, "Could not find control %s\n", name);
+			continue;
+		}
+
+		e = (struct soc_enum *)kcontrol->private_value;
+		item = snd_soc_enum_val_to_item(e, val[i] & CS35L56_ASP_TXn_SRC_MASK);
+		snd_soc_dapm_mux_update_power(dapm, kcontrol, item, e, NULL);
+	}
+
+	cs35l56->asp1_mixer_widgets_initialized = true;
+
+	return 0;
+}
+
+static int cs35l56_dspwait_asp1tx_get(struct snd_kcontrol *kcontrol,
+				      struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_dapm_kcontrol_component(kcontrol);
+	struct cs35l56_private *cs35l56 = snd_soc_component_get_drvdata(component);
+	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
+	int index = e->shift_l;
+	unsigned int addr, val;
+	int ret;
+
+	ret = cs35l56_sync_asp1_mixer_widgets_with_firmware(cs35l56);
+	if (ret)
+		return ret;
+
+	addr = cs35l56_asp1_mixer_regs[index];
+	ret = regmap_read(cs35l56->base.regmap, addr, &val);
+	if (ret)
+		return ret;
+
+	val &= CS35L56_ASP_TXn_SRC_MASK;
+	ucontrol->value.enumerated.item[0] = snd_soc_enum_val_to_item(e, val);
+
+	return 0;
+}
+
+static int cs35l56_dspwait_asp1tx_put(struct snd_kcontrol *kcontrol,
+				      struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_dapm_kcontrol_component(kcontrol);
+	struct snd_soc_dapm_context *dapm = snd_soc_dapm_kcontrol_dapm(kcontrol);
+	struct cs35l56_private *cs35l56 = snd_soc_component_get_drvdata(component);
+	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
+	int item = ucontrol->value.enumerated.item[0];
+	int index = e->shift_l;
+	unsigned int addr, val;
+	bool changed;
+	int ret;
+
+	ret = cs35l56_sync_asp1_mixer_widgets_with_firmware(cs35l56);
+	if (ret)
+		return ret;
+
+	addr = cs35l56_asp1_mixer_regs[index];
+	val = snd_soc_enum_item_to_val(e, item);
+
+	ret = regmap_update_bits_check(cs35l56->base.regmap, addr,
+				       CS35L56_ASP_TXn_SRC_MASK, val, &changed);
+	if (ret)
+		return ret;
+
+	if (changed)
+		snd_soc_dapm_mux_update_power(dapm, kcontrol, item, e, NULL);
+
+	return changed;
+}
+
 static DECLARE_TLV_DB_SCALE(vol_tlv, -10000, 25, 0);
 
 static const struct snd_kcontrol_new cs35l56_controls[] = {
@@ -77,40 +202,44 @@ static const struct snd_kcontrol_new cs35l56_controls[] = {
 };
 
 static SOC_VALUE_ENUM_SINGLE_DECL(cs35l56_asp1tx1_enum,
-				  CS35L56_ASP1TX1_INPUT,
-				  0, CS35L56_ASP_TXn_SRC_MASK,
+				  SND_SOC_NOPM,
+				  0, 0,
 				  cs35l56_tx_input_texts,
 				  cs35l56_tx_input_values);
 
 static const struct snd_kcontrol_new asp1_tx1_mux =
-	SOC_DAPM_ENUM("ASP1TX1 SRC", cs35l56_asp1tx1_enum);
+	SOC_DAPM_ENUM_EXT("ASP1TX1 SRC", cs35l56_asp1tx1_enum,
+			  cs35l56_dspwait_asp1tx_get, cs35l56_dspwait_asp1tx_put);
 
 static SOC_VALUE_ENUM_SINGLE_DECL(cs35l56_asp1tx2_enum,
-				  CS35L56_ASP1TX2_INPUT,
-				  0, CS35L56_ASP_TXn_SRC_MASK,
+				  SND_SOC_NOPM,
+				  1, 0,
 				  cs35l56_tx_input_texts,
 				  cs35l56_tx_input_values);
 
 static const struct snd_kcontrol_new asp1_tx2_mux =
-	SOC_DAPM_ENUM("ASP1TX2 SRC", cs35l56_asp1tx2_enum);
+	SOC_DAPM_ENUM_EXT("ASP1TX2 SRC", cs35l56_asp1tx2_enum,
+			  cs35l56_dspwait_asp1tx_get, cs35l56_dspwait_asp1tx_put);
 
 static SOC_VALUE_ENUM_SINGLE_DECL(cs35l56_asp1tx3_enum,
-				  CS35L56_ASP1TX3_INPUT,
-				  0, CS35L56_ASP_TXn_SRC_MASK,
+				  SND_SOC_NOPM,
+				  2, 0,
 				  cs35l56_tx_input_texts,
 				  cs35l56_tx_input_values);
 
 static const struct snd_kcontrol_new asp1_tx3_mux =
-	SOC_DAPM_ENUM("ASP1TX3 SRC", cs35l56_asp1tx3_enum);
+	SOC_DAPM_ENUM_EXT("ASP1TX3 SRC", cs35l56_asp1tx3_enum,
+			  cs35l56_dspwait_asp1tx_get, cs35l56_dspwait_asp1tx_put);
 
 static SOC_VALUE_ENUM_SINGLE_DECL(cs35l56_asp1tx4_enum,
-				  CS35L56_ASP1TX4_INPUT,
-				  0, CS35L56_ASP_TXn_SRC_MASK,
+				  SND_SOC_NOPM,
+				  3, 0,
 				  cs35l56_tx_input_texts,
 				  cs35l56_tx_input_values);
 
 static const struct snd_kcontrol_new asp1_tx4_mux =
-	SOC_DAPM_ENUM("ASP1TX4 SRC", cs35l56_asp1tx4_enum);
+	SOC_DAPM_ENUM_EXT("ASP1TX4 SRC", cs35l56_asp1tx4_enum,
+			  cs35l56_dspwait_asp1tx_get, cs35l56_dspwait_asp1tx_put);
 
 static SOC_VALUE_ENUM_SINGLE_DECL(cs35l56_sdw1tx1_enum,
 				CS35L56_SWIRE_DP3_CH1_INPUT,
@@ -753,6 +882,18 @@ static void cs35l56_dsp_work(struct work_struct *work)
 
 	pm_runtime_get_sync(cs35l56->base.dev);
 
+	/* Populate fw file qualifier with the revision and security state */
+	if (!cs35l56->dsp.fwf_name) {
+		cs35l56->dsp.fwf_name = kasprintf(GFP_KERNEL, "%02x%s-dsp1",
+						  cs35l56->base.rev,
+						  cs35l56->base.secured ? "-s" : "");
+		if (!cs35l56->dsp.fwf_name)
+			goto err;
+	}
+
+	dev_dbg(cs35l56->base.dev, "DSP fwf name: '%s' system name: '%s'\n",
+		cs35l56->dsp.fwf_name, cs35l56->dsp.system_name);
+
 	/*
 	 * When the device is running in secure mode the firmware files can
 	 * only contain insecure tunings and therefore we do not need to
@@ -764,6 +905,7 @@ static void cs35l56_dsp_work(struct work_struct *work)
 	else
 		cs35l56_patch(cs35l56);
 
+err:
 	pm_runtime_mark_last_busy(cs35l56->base.dev);
 	pm_runtime_put_autosuspend(cs35l56->base.dev);
 }
@@ -799,6 +941,13 @@ static int cs35l56_component_probe(struct snd_soc_component *component)
 	debugfs_create_bool("can_hibernate", 0444, debugfs_root, &cs35l56->base.can_hibernate);
 	debugfs_create_bool("fw_patched", 0444, debugfs_root, &cs35l56->base.fw_patched);
 
+	/*
+	 * The widgets for the ASP1TX mixer can't be initialized
+	 * until the firmware has been downloaded and rebooted.
+	 */
+	regcache_drop_region(cs35l56->base.regmap, CS35L56_ASP1TX1_INPUT, CS35L56_ASP1TX4_INPUT);
+	cs35l56->asp1_mixer_widgets_initialized = false;
+
 	queue_work(cs35l56->dsp_wq, &cs35l56->dsp_work);
 
 	return 0;
@@ -809,6 +958,16 @@ static void cs35l56_component_remove(struct snd_soc_component *component)
 	struct cs35l56_private *cs35l56 = snd_soc_component_get_drvdata(component);
 
 	cancel_work_sync(&cs35l56->dsp_work);
+
+	if (cs35l56->dsp.cs_dsp.booted)
+		wm_adsp_power_down(&cs35l56->dsp);
+
+	wm_adsp2_component_remove(&cs35l56->dsp, component);
+
+	kfree(cs35l56->dsp.fwf_name);
+	cs35l56->dsp.fwf_name = NULL;
+
+	cs35l56->component = NULL;
 }
 
 static int cs35l56_set_bias_level(struct snd_soc_component *component,
@@ -1152,11 +1311,9 @@ int cs35l56_init(struct cs35l56_private *cs35l56)
 	if (ret < 0)
 		return ret;
 
-	/* Populate the DSP information with the revision and security state */
-	cs35l56->dsp.part = devm_kasprintf(cs35l56->base.dev, GFP_KERNEL, "cs35l56%s-%02x",
-					   cs35l56->base.secured ? "s" : "", cs35l56->base.rev);
-	if (!cs35l56->dsp.part)
-		return -ENOMEM;
+	ret = cs35l56_set_patch(&cs35l56->base);
+	if (ret)
+		return ret;
 
 	if (!cs35l56->base.reset_gpio) {
 		dev_dbg(cs35l56->base.dev, "No reset gpio: using soft reset\n");
@@ -1190,10 +1347,6 @@ int cs35l56_init(struct cs35l56_private *cs35l56)
 	if (ret)
 		return ret;
 
-	ret = cs35l56_set_patch(&cs35l56->base);
-	if (ret)
-		return ret;
-
 	/* Registers could be dirty after soft reset or SoundWire enumeration */
 	regcache_sync(cs35l56->base.regmap);
 
diff --git a/sound/soc/codecs/cs35l56.h b/sound/soc/codecs/cs35l56.h
index 8159c3e217d9..d9fbf568a195 100644
--- a/sound/soc/codecs/cs35l56.h
+++ b/sound/soc/codecs/cs35l56.h
@@ -50,6 +50,7 @@ struct cs35l56_private {
 	u8 asp_slot_count;
 	bool tdm_mode;
 	bool sysclk_set;
+	bool asp1_mixer_widgets_initialized;
 	u8 old_sdw_clock_scale;
 };
 
diff --git a/sound/soc/fsl/fsl_xcvr.c b/sound/soc/fsl/fsl_xcvr.c
index f0fb33d719c2..c46f64557a7f 100644
--- a/sound/soc/fsl/fsl_xcvr.c
+++ b/sound/soc/fsl/fsl_xcvr.c
@@ -174,7 +174,9 @@ static int fsl_xcvr_activate_ctl(struct snd_soc_dai *dai, const char *name,
 	struct snd_kcontrol *kctl;
 	bool enabled;
 
-	kctl = snd_soc_card_get_kcontrol(card, name);
+	lockdep_assert_held(&card->snd_card->controls_rwsem);
+
+	kctl = snd_soc_card_get_kcontrol_locked(card, name);
 	if (kctl == NULL)
 		return -ENOENT;
 
@@ -576,10 +578,14 @@ static int fsl_xcvr_startup(struct snd_pcm_substream *substream,
 	xcvr->streams |= BIT(substream->stream);
 
 	if (!xcvr->soc_data->spdif_only) {
+		struct snd_soc_card *card = dai->component->card;
+
 		/* Disable XCVR controls if there is stream started */
+		down_read(&card->snd_card->controls_rwsem);
 		fsl_xcvr_activate_ctl(dai, fsl_xcvr_mode_kctl.name, false);
 		fsl_xcvr_activate_ctl(dai, fsl_xcvr_arc_mode_kctl.name, false);
 		fsl_xcvr_activate_ctl(dai, fsl_xcvr_earc_capds_kctl.name, false);
+		up_read(&card->snd_card->controls_rwsem);
 	}
 
 	return 0;
@@ -598,11 +604,15 @@ static void fsl_xcvr_shutdown(struct snd_pcm_substream *substream,
 	/* Enable XCVR controls if there is no stream started */
 	if (!xcvr->streams) {
 		if (!xcvr->soc_data->spdif_only) {
+			struct snd_soc_card *card = dai->component->card;
+
+			down_read(&card->snd_card->controls_rwsem);
 			fsl_xcvr_activate_ctl(dai, fsl_xcvr_mode_kctl.name, true);
 			fsl_xcvr_activate_ctl(dai, fsl_xcvr_arc_mode_kctl.name,
 						(xcvr->mode == FSL_XCVR_MODE_ARC));
 			fsl_xcvr_activate_ctl(dai, fsl_xcvr_earc_capds_kctl.name,
 						(xcvr->mode == FSL_XCVR_MODE_EARC));
+			up_read(&card->snd_card->controls_rwsem);
 		}
 		ret = regmap_update_bits(xcvr->regmap, FSL_XCVR_EXT_IER0,
 					 FSL_XCVR_IRQ_EARC_ALL, 0);
diff --git a/sound/soc/qcom/lpass-cdc-dma.c b/sound/soc/qcom/lpass-cdc-dma.c
index 48b03e60e3a3..8106c586f68a 100644
--- a/sound/soc/qcom/lpass-cdc-dma.c
+++ b/sound/soc/qcom/lpass-cdc-dma.c
@@ -259,7 +259,7 @@ static int lpass_cdc_dma_daiops_trigger(struct snd_pcm_substream *substream,
 				    int cmd, struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *soc_runtime = snd_soc_substream_to_rtd(substream);
-	struct lpaif_dmactl *dmactl;
+	struct lpaif_dmactl *dmactl = NULL;
 	int ret = 0, id;
 
 	switch (cmd) {
diff --git a/sound/soc/soc-card.c b/sound/soc/soc-card.c
index 285ab4c9c716..8a2f163da6bc 100644
--- a/sound/soc/soc-card.c
+++ b/sound/soc/soc-card.c
@@ -5,6 +5,9 @@
 // Copyright (C) 2019 Renesas Electronics Corp.
 // Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
 //
+
+#include <linux/lockdep.h>
+#include <linux/rwsem.h>
 #include <sound/soc.h>
 #include <sound/jack.h>
 
@@ -26,12 +29,15 @@ static inline int _soc_card_ret(struct snd_soc_card *card,
 	return ret;
 }
 
-struct snd_kcontrol *snd_soc_card_get_kcontrol(struct snd_soc_card *soc_card,
-					       const char *name)
+struct snd_kcontrol *snd_soc_card_get_kcontrol_locked(struct snd_soc_card *soc_card,
+						      const char *name)
 {
 	struct snd_card *card = soc_card->snd_card;
 	struct snd_kcontrol *kctl;
 
+	/* must be held read or write */
+	lockdep_assert_held(&card->controls_rwsem);
+
 	if (unlikely(!name))
 		return NULL;
 
@@ -40,6 +46,20 @@ struct snd_kcontrol *snd_soc_card_get_kcontrol(struct snd_soc_card *soc_card,
 			return kctl;
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(snd_soc_card_get_kcontrol_locked);
+
+struct snd_kcontrol *snd_soc_card_get_kcontrol(struct snd_soc_card *soc_card,
+					       const char *name)
+{
+	struct snd_card *card = soc_card->snd_card;
+	struct snd_kcontrol *kctl;
+
+	down_read(&card->controls_rwsem);
+	kctl = snd_soc_card_get_kcontrol_locked(soc_card, name);
+	up_read(&card->controls_rwsem);
+
+	return kctl;
+}
 EXPORT_SYMBOL_GPL(snd_soc_card_get_kcontrol);
 
 static int jack_new(struct snd_soc_card *card, const char *id, int type,
diff --git a/tools/net/ynl/lib/ynl.c b/tools/net/ynl/lib/ynl.c
index 591f5f50ddaa..2aa19004fa0c 100644
--- a/tools/net/ynl/lib/ynl.c
+++ b/tools/net/ynl/lib/ynl.c
@@ -519,6 +519,7 @@ ynl_get_family_info_mcast(struct ynl_sock *ys, const struct nlattr *mcasts)
 				ys->mcast_groups[i].name[GENL_NAMSIZ - 1] = 0;
 			}
 		}
+		i++;
 	}
 
 	return 0;
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 10cd322e05c4..3b971d1617d8 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -310,12 +310,6 @@ check_mptcp_disabled()
 	return 0
 }
 
-# $1: IP address
-is_v6()
-{
-	[ -z "${1##*:*}" ]
-}
-
 do_ping()
 {
 	local listener_ns="$1"
@@ -324,7 +318,7 @@ do_ping()
 	local ping_args="-q -c 1"
 	local rc=0
 
-	if is_v6 "${connect_addr}"; then
+	if mptcp_lib_is_v6 "${connect_addr}"; then
 		$ipv6 || return 0
 		ping_args="${ping_args} -6"
 	fi
@@ -620,12 +614,12 @@ run_tests_lo()
 	fi
 
 	# skip if we don't want v6
-	if ! $ipv6 && is_v6 "${connect_addr}"; then
+	if ! $ipv6 && mptcp_lib_is_v6 "${connect_addr}"; then
 		return 0
 	fi
 
 	local local_addr
-	if is_v6 "${connect_addr}"; then
+	if mptcp_lib_is_v6 "${connect_addr}"; then
 		local_addr="::"
 	else
 		local_addr="0.0.0.0"
@@ -693,7 +687,7 @@ run_test_transparent()
 	TEST_GROUP="${msg}"
 
 	# skip if we don't want v6
-	if ! $ipv6 && is_v6 "${connect_addr}"; then
+	if ! $ipv6 && mptcp_lib_is_v6 "${connect_addr}"; then
 		return 0
 	fi
 
@@ -726,7 +720,7 @@ EOF
 	fi
 
 	local local_addr
-	if is_v6 "${connect_addr}"; then
+	if mptcp_lib_is_v6 "${connect_addr}"; then
 		local_addr="::"
 		r6flag="-6"
 	else
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index be10b971e912..e6b778a9a937 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -159,6 +159,11 @@ check_tools()
 		exit $ksft_skip
 	fi
 
+	if ! ss -h | grep -q MPTCP; then
+		echo "SKIP: ss tool does not support MPTCP"
+		exit $ksft_skip
+	fi
+
 	# Use the legacy version if available to support old kernel versions
 	if iptables-legacy -V &> /dev/null; then
 		iptables="iptables-legacy"
@@ -587,12 +592,6 @@ link_failure()
 	done
 }
 
-# $1: IP address
-is_v6()
-{
-	[ -z "${1##*:*}" ]
-}
-
 # $1: ns, $2: port
 wait_local_port_listen()
 {
@@ -872,7 +871,7 @@ pm_nl_set_endpoint()
 		local id=10
 		while [ $add_nr_ns1 -gt 0 ]; do
 			local addr
-			if is_v6 "${connect_addr}"; then
+			if mptcp_lib_is_v6 "${connect_addr}"; then
 				addr="dead:beef:$counter::1"
 			else
 				addr="10.0.$counter.1"
@@ -924,7 +923,7 @@ pm_nl_set_endpoint()
 		local id=20
 		while [ $add_nr_ns2 -gt 0 ]; do
 			local addr
-			if is_v6 "${connect_addr}"; then
+			if mptcp_lib_is_v6 "${connect_addr}"; then
 				addr="dead:beef:$counter::2"
 			else
 				addr="10.0.$counter.2"
@@ -966,7 +965,7 @@ pm_nl_set_endpoint()
 			pm_nl_flush_endpoint ${connector_ns}
 		elif [ $rm_nr_ns2 -eq 9 ]; then
 			local addr
-			if is_v6 "${connect_addr}"; then
+			if mptcp_lib_is_v6 "${connect_addr}"; then
 				addr="dead:beef:1::2"
 			else
 				addr="10.0.1.2"
@@ -1838,12 +1837,10 @@ chk_mptcp_info()
 	local cnt2
 	local dump_stats
 
-	print_check "mptcp_info ${info1:0:8}=$exp1:$exp2"
+	print_check "mptcp_info ${info1:0:15}=$exp1:$exp2"
 
-	cnt1=$(ss -N $ns1 -inmHM | grep "$info1:" |
-	       sed -n 's/.*\('"$info1"':\)\([[:digit:]]*\).*$/\2/p;q')
-	cnt2=$(ss -N $ns2 -inmHM | grep "$info2:" |
-	       sed -n 's/.*\('"$info2"':\)\([[:digit:]]*\).*$/\2/p;q')
+	cnt1=$(ss -N $ns1 -inmHM | mptcp_lib_get_info_value "$info1" "$info1")
+	cnt2=$(ss -N $ns2 -inmHM | mptcp_lib_get_info_value "$info2" "$info2")
 	# 'ss' only display active connections and counters that are not 0.
 	[ -z "$cnt1" ] && cnt1=0
 	[ -z "$cnt2" ] && cnt2=0
@@ -1861,6 +1858,42 @@ chk_mptcp_info()
 	fi
 }
 
+# $1: subflows in ns1 ; $2: subflows in ns2
+# number of all subflows, including the initial subflow.
+chk_subflows_total()
+{
+	local cnt1
+	local cnt2
+	local info="subflows_total"
+	local dump_stats
+
+	# if subflows_total counter is supported, use it:
+	if [ -n "$(ss -N $ns1 -inmHM | mptcp_lib_get_info_value $info $info)" ]; then
+		chk_mptcp_info $info $1 $info $2
+		return
+	fi
+
+	print_check "$info $1:$2"
+
+	# if not, count the TCP connections that are in fact MPTCP subflows
+	cnt1=$(ss -N $ns1 -ti state established state syn-sent state syn-recv |
+	       grep -c tcp-ulp-mptcp)
+	cnt2=$(ss -N $ns2 -ti state established state syn-sent state syn-recv |
+	       grep -c tcp-ulp-mptcp)
+
+	if [ "$1" != "$cnt1" ] || [ "$2" != "$cnt2" ]; then
+		fail_test "got subflows $cnt1:$cnt2 expected $1:$2"
+		dump_stats=1
+	else
+		print_ok
+	fi
+
+	if [ "$dump_stats" = 1 ]; then
+		ss -N $ns1 -ti
+		ss -N $ns2 -ti
+	fi
+}
+
 chk_link_usage()
 {
 	local ns=$1
@@ -2785,6 +2818,7 @@ backup_tests()
 	fi
 }
 
+SUB_ESTABLISHED=10 # MPTCP_EVENT_SUB_ESTABLISHED
 LISTENER_CREATED=15 #MPTCP_EVENT_LISTENER_CREATED
 LISTENER_CLOSED=16  #MPTCP_EVENT_LISTENER_CLOSED
 
@@ -2819,13 +2853,13 @@ verify_listener_events()
 		return
 	fi
 
-	type=$(grep "type:$e_type," $evt | sed -n 's/.*\(type:\)\([[:digit:]]*\).*$/\2/p;q')
-	family=$(grep "type:$e_type," $evt | sed -n 's/.*\(family:\)\([[:digit:]]*\).*$/\2/p;q')
-	sport=$(grep "type:$e_type," $evt | sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
+	type=$(mptcp_lib_evts_get_info type "$evt" "$e_type")
+	family=$(mptcp_lib_evts_get_info family "$evt" "$e_type")
+	sport=$(mptcp_lib_evts_get_info sport "$evt" "$e_type")
 	if [ $family ] && [ $family = $AF_INET6 ]; then
-		saddr=$(grep "type:$e_type," $evt | sed -n 's/.*\(saddr6:\)\([0-9a-f:.]*\).*$/\2/p;q')
+		saddr=$(mptcp_lib_evts_get_info saddr6 "$evt" "$e_type")
 	else
-		saddr=$(grep "type:$e_type," $evt | sed -n 's/.*\(saddr4:\)\([0-9.]*\).*$/\2/p;q')
+		saddr=$(mptcp_lib_evts_get_info saddr4 "$evt" "$e_type")
 	fi
 
 	if [ $type ] && [ $type = $e_type ] &&
@@ -3220,8 +3254,7 @@ fastclose_tests()
 pedit_action_pkts()
 {
 	tc -n $ns2 -j -s action show action pedit index 100 | \
-		grep "packets" | \
-		sed 's/.*"packets":\([0-9]\+\),.*/\1/'
+		mptcp_lib_get_info_value \"packets\" packets
 }
 
 fail_tests()
@@ -3246,75 +3279,71 @@ fail_tests()
 	fi
 }
 
+# $1: ns ; $2: addr ; $3: id
 userspace_pm_add_addr()
 {
-	local addr=$1
-	local id=$2
+	local evts=$evts_ns1
 	local tk
 
-	tk=$(grep "type:1," "$evts_ns1" |
-	     sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q')
-	ip netns exec $ns1 ./pm_nl_ctl ann $addr token $tk id $id
+	[ "$1" == "$ns2" ] && evts=$evts_ns2
+	tk=$(mptcp_lib_evts_get_info token "$evts")
+
+	ip netns exec $1 ./pm_nl_ctl ann $2 token $tk id $3
 	sleep 1
 }
 
-userspace_pm_rm_sf_addr_ns1()
+# $1: ns ; $2: id
+userspace_pm_rm_addr()
 {
-	local addr=$1
-	local id=$2
-	local tk sp da dp
-	local cnt_addr cnt_sf
-
-	tk=$(grep "type:1," "$evts_ns1" |
-	     sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q')
-	sp=$(grep "type:10" "$evts_ns1" |
-	     sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
-	da=$(grep "type:10" "$evts_ns1" |
-	     sed -n 's/.*\(daddr6:\)\([0-9a-f:.]*\).*$/\2/p;q')
-	dp=$(grep "type:10" "$evts_ns1" |
-	     sed -n 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q')
-	cnt_addr=$(rm_addr_count ${ns1})
-	cnt_sf=$(rm_sf_count ${ns1})
-	ip netns exec $ns1 ./pm_nl_ctl rem token $tk id $id
-	ip netns exec $ns1 ./pm_nl_ctl dsf lip "::ffff:$addr" \
-				lport $sp rip $da rport $dp token $tk
-	wait_rm_addr $ns1 "${cnt_addr}"
-	wait_rm_sf $ns1 "${cnt_sf}"
+	local evts=$evts_ns1
+	local tk
+	local cnt
+
+	[ "$1" == "$ns2" ] && evts=$evts_ns2
+	tk=$(mptcp_lib_evts_get_info token "$evts")
+
+	cnt=$(rm_addr_count ${1})
+	ip netns exec $1 ./pm_nl_ctl rem token $tk id $2
+	wait_rm_addr $1 "${cnt}"
 }
 
+# $1: ns ; $2: addr ; $3: id
 userspace_pm_add_sf()
 {
-	local addr=$1
-	local id=$2
+	local evts=$evts_ns1
 	local tk da dp
 
-	tk=$(sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns2")
-	da=$(sed -n 's/.*\(daddr4:\)\([0-9.]*\).*$/\2/p;q' "$evts_ns2")
-	dp=$(sed -n 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns2")
-	ip netns exec $ns2 ./pm_nl_ctl csf lip $addr lid $id \
+	[ "$1" == "$ns2" ] && evts=$evts_ns2
+	tk=$(mptcp_lib_evts_get_info token "$evts")
+	da=$(mptcp_lib_evts_get_info daddr4 "$evts")
+	dp=$(mptcp_lib_evts_get_info dport "$evts")
+
+	ip netns exec $1 ./pm_nl_ctl csf lip $2 lid $3 \
 				rip $da rport $dp token $tk
 	sleep 1
 }
 
-userspace_pm_rm_sf_addr_ns2()
+# $1: ns ; $2: addr $3: event type
+userspace_pm_rm_sf()
 {
-	local addr=$1
-	local id=$2
+	local evts=$evts_ns1
+	local t=${3:-1}
+	local ip
 	local tk da dp sp
-	local cnt_addr cnt_sf
-
-	tk=$(sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns2")
-	da=$(sed -n 's/.*\(daddr4:\)\([0-9.]*\).*$/\2/p;q' "$evts_ns2")
-	dp=$(sed -n 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns2")
-	sp=$(grep "type:10" "$evts_ns2" |
-	     sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
-	cnt_addr=$(rm_addr_count ${ns2})
-	cnt_sf=$(rm_sf_count ${ns2})
-	ip netns exec $ns2 ./pm_nl_ctl rem token $tk id $id
-	ip netns exec $ns2 ./pm_nl_ctl dsf lip $addr lport $sp \
+	local cnt
+
+	[ "$1" == "$ns2" ] && evts=$evts_ns2
+	[ -n "$(mptcp_lib_evts_get_info "saddr4" "$evts" $t)" ] && ip=4
+	[ -n "$(mptcp_lib_evts_get_info "saddr6" "$evts" $t)" ] && ip=6
+	tk=$(mptcp_lib_evts_get_info token "$evts")
+	da=$(mptcp_lib_evts_get_info "daddr$ip" "$evts" $t $2)
+	dp=$(mptcp_lib_evts_get_info dport "$evts" $t $2)
+	sp=$(mptcp_lib_evts_get_info sport "$evts" $t $2)
+
+	cnt=$(rm_sf_count ${1})
+	ip netns exec $1 ./pm_nl_ctl dsf lip $2 lport $sp \
 				rip $da rport $dp token $tk
-	wait_rm_addr $ns2 "${cnt_addr}"
-	wait_rm_sf $ns2 "${cnt_sf}"
+	wait_rm_sf $1 "${cnt}"
 }
 
 userspace_tests()
@@ -3396,19 +3425,25 @@ userspace_tests()
 	if reset_with_events "userspace pm add & remove address" &&
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns1
-		pm_nl_set_limits $ns2 1 1
+		pm_nl_set_limits $ns2 2 2
 		speed=5 \
 			run_tests $ns1 $ns2 10.0.1.1 &
 		local tests_pid=$!
 		wait_mpj $ns1
-		userspace_pm_add_addr 10.0.2.1 10
-		chk_join_nr 1 1 1
-		chk_add_nr 1 1
-		chk_mptcp_info subflows 1 subflows 1
-		chk_mptcp_info add_addr_signal 1 add_addr_accepted 1
-		userspace_pm_rm_sf_addr_ns1 10.0.2.1 10
-		chk_rm_nr 1 1 invert
+		userspace_pm_add_addr $ns1 10.0.2.1 10
+		userspace_pm_add_addr $ns1 10.0.3.1 20
+		chk_join_nr 2 2 2
+		chk_add_nr 2 2
+		chk_mptcp_info subflows 2 subflows 2
+		chk_subflows_total 3 3
+		chk_mptcp_info add_addr_signal 2 add_addr_accepted 2
+		userspace_pm_rm_addr $ns1 10
+		userspace_pm_rm_sf $ns1 "::ffff:10.0.2.1" $SUB_ESTABLISHED
+		userspace_pm_rm_addr $ns1 20
+		userspace_pm_rm_sf $ns1 10.0.3.1 $SUB_ESTABLISHED
+		chk_rm_nr 2 2 invert
 		chk_mptcp_info subflows 0 subflows 0
+		chk_subflows_total 1 1
 		kill_events_pids
 		mptcp_lib_kill_wait $tests_pid
 	fi
@@ -3422,12 +3457,15 @@ userspace_tests()
 			run_tests $ns1 $ns2 10.0.1.1 &
 		local tests_pid=$!
 		wait_mpj $ns2
-		userspace_pm_add_sf 10.0.3.2 20
+		userspace_pm_add_sf $ns2 10.0.3.2 20
 		chk_join_nr 1 1 1
 		chk_mptcp_info subflows 1 subflows 1
-		userspace_pm_rm_sf_addr_ns2 10.0.3.2 20
+		chk_subflows_total 2 2
+		userspace_pm_rm_addr $ns2 20
+		userspace_pm_rm_sf $ns2 10.0.3.2 $SUB_ESTABLISHED
 		chk_rm_nr 1 1
 		chk_mptcp_info subflows 0 subflows 0
+		chk_subflows_total 1 1
 		kill_events_pids
 		mptcp_lib_kill_wait $tests_pid
 	fi
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 2b10f200de40..8939d5c135a0 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -208,6 +208,16 @@ mptcp_lib_result_print_all_tap() {
 	done
 }
 
+# get the value of keyword $1 in the line marked by keyword $2
+mptcp_lib_get_info_value() {
+	grep "${2}" | sed -n 's/.*\('"${1}"':\)\([0-9a-f:.]*\).*$/\2/p;q'
+}
+
+# $1: info name ; $2: evts_ns ; [$3: event type; [$4: addr]]
+mptcp_lib_evts_get_info() {
+	grep "${4:-}" "${2}" | mptcp_lib_get_info_value "${1}" "^type:${3:-1},"
+}
+
 # $1: PID
 mptcp_lib_kill_wait() {
 	[ "${1}" -eq 0 ] && return 0
@@ -217,6 +227,11 @@ mptcp_lib_kill_wait() {
 	wait "${1}" 2>/dev/null
 }
 
+# $1: IP address
+mptcp_lib_is_v6() {
+	[ -z "${1##*:*}" ]
+}
+
 # $1: ns, $2: MIB counter
 mptcp_lib_get_counter() {
 	local ns="${1}"
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index a817af6616ec..bfa744e350ef 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -161,12 +161,6 @@ check_transfer()
 	return 0
 }
 
-# $1: IP address
-is_v6()
-{
-	[ -z "${1##*:*}" ]
-}
-
 do_transfer()
 {
 	local listener_ns="$1"
@@ -183,7 +177,7 @@ do_transfer()
 	local mptcp_connect="./mptcp_connect -r 20"
 
 	local local_addr ip
-	if is_v6 "${connect_addr}"; then
+	if mptcp_lib_is_v6 "${connect_addr}"; then
 		local_addr="::"
 		ip=ipv6
 	else
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 0e748068ee95..4c62114de063 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -238,14 +238,11 @@ make_connection()
 	local server_token
 	local server_serverside
 
-	client_token=$(sed --unbuffered -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q' "$client_evts")
-	client_port=$(sed --unbuffered -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q' "$client_evts")
-	client_serverside=$(sed --unbuffered -n 's/.*\(server_side:\)\([[:digit:]]*\).*$/\2/p;q'\
-				      "$client_evts")
-	server_token=$(grep "type:1," "$server_evts" |
-		       sed --unbuffered -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q')
-	server_serverside=$(grep "type:1," "$server_evts" |
-			    sed --unbuffered -n 's/.*\(server_side:\)\([[:digit:]]*\).*$/\2/p;q')
+	client_token=$(mptcp_lib_evts_get_info token "$client_evts")
+	client_port=$(mptcp_lib_evts_get_info sport "$client_evts")
+	client_serverside=$(mptcp_lib_evts_get_info server_side "$client_evts")
+	server_token=$(mptcp_lib_evts_get_info token "$server_evts")
+	server_serverside=$(mptcp_lib_evts_get_info server_side "$server_evts")
 
 	print_test "Established IP${is_v6} MPTCP Connection ns2 => ns1"
 	if [ "$client_token" != "" ] && [ "$server_token" != "" ] && [ "$client_serverside" = 0 ] &&
@@ -331,16 +328,16 @@ verify_announce_event()
 	local dport
 	local id
 
-	type=$(sed --unbuffered -n 's/.*\(type:\)\([[:digit:]]*\).*$/\2/p;q' "$evt")
-	token=$(sed --unbuffered -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q' "$evt")
+	type=$(mptcp_lib_evts_get_info type "$evt" $e_type)
+	token=$(mptcp_lib_evts_get_info token "$evt" $e_type)
 	if [ "$e_af" = "v6" ]
 	then
-		addr=$(sed --unbuffered -n 's/.*\(daddr6:\)\([0-9a-f:.]*\).*$/\2/p;q' "$evt")
+		addr=$(mptcp_lib_evts_get_info daddr6 "$evt" $e_type)
 	else
-		addr=$(sed --unbuffered -n 's/.*\(daddr4:\)\([0-9.]*\).*$/\2/p;q' "$evt")
+		addr=$(mptcp_lib_evts_get_info daddr4 "$evt" $e_type)
 	fi
-	dport=$(sed --unbuffered -n 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q' "$evt")
-	id=$(sed --unbuffered -n 's/.*\(rem_id:\)\([[:digit:]]*\).*$/\2/p;q' "$evt")
+	dport=$(mptcp_lib_evts_get_info dport "$evt" $e_type)
+	id=$(mptcp_lib_evts_get_info rem_id "$evt" $e_type)
 
 	check_expected "type" "token" "addr" "dport" "id"
 }
@@ -358,7 +355,7 @@ test_announce()
 	   $client_addr_id dev ns2eth1 > /dev/null 2>&1
 
 	local type
-	type=$(sed --unbuffered -n 's/.*\(type:\)\([[:digit:]]*\).*$/\2/p;q' "$server_evts")
+	type=$(mptcp_lib_evts_get_info type "$server_evts")
 	print_test "ADD_ADDR 10.0.2.2 (ns2) => ns1, invalid token"
 	if [ "$type" = "" ]
 	then
@@ -437,9 +434,9 @@ verify_remove_event()
 	local token
 	local id
 
-	type=$(sed --unbuffered -n 's/.*\(type:\)\([[:digit:]]*\).*$/\2/p;q' "$evt")
-	token=$(sed --unbuffered -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q' "$evt")
-	id=$(sed --unbuffered -n 's/.*\(rem_id:\)\([[:digit:]]*\).*$/\2/p;q' "$evt")
+	type=$(mptcp_lib_evts_get_info type "$evt" $e_type)
+	token=$(mptcp_lib_evts_get_info token "$evt" $e_type)
+	id=$(mptcp_lib_evts_get_info rem_id "$evt" $e_type)
 
 	check_expected "type" "token" "id"
 }
@@ -457,7 +454,7 @@ test_remove()
 	   $client_addr_id > /dev/null 2>&1
 	print_test "RM_ADDR id:${client_addr_id} ns2 => ns1, invalid token"
 	local type
-	type=$(sed --unbuffered -n 's/.*\(type:\)\([[:digit:]]*\).*$/\2/p;q' "$server_evts")
+	type=$(mptcp_lib_evts_get_info type "$server_evts")
 	if [ "$type" = "" ]
 	then
 		test_pass
@@ -470,7 +467,7 @@ test_remove()
 	ip netns exec "$ns2" ./pm_nl_ctl rem token "$client4_token" id\
 	   $invalid_id > /dev/null 2>&1
 	print_test "RM_ADDR id:${invalid_id} ns2 => ns1, invalid id"
-	type=$(sed --unbuffered -n 's/.*\(type:\)\([[:digit:]]*\).*$/\2/p;q' "$server_evts")
+	type=$(mptcp_lib_evts_get_info type "$server_evts")
 	if [ "$type" = "" ]
 	then
 		test_pass
@@ -574,19 +571,19 @@ verify_subflow_events()
 		fi
 	fi
 
-	type=$(sed --unbuffered -n 's/.*\(type:\)\([[:digit:]]*\).*$/\2/p;q' "$evt")
-	token=$(sed --unbuffered -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q' "$evt")
-	family=$(sed --unbuffered -n 's/.*\(family:\)\([[:digit:]]*\).*$/\2/p;q' "$evt")
-	dport=$(sed --unbuffered -n 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q' "$evt")
-	locid=$(sed --unbuffered -n 's/.*\(loc_id:\)\([[:digit:]]*\).*$/\2/p;q' "$evt")
-	remid=$(sed --unbuffered -n 's/.*\(rem_id:\)\([[:digit:]]*\).*$/\2/p;q' "$evt")
+	type=$(mptcp_lib_evts_get_info type "$evt" $e_type)
+	token=$(mptcp_lib_evts_get_info token "$evt" $e_type)
+	family=$(mptcp_lib_evts_get_info family "$evt" $e_type)
+	dport=$(mptcp_lib_evts_get_info dport "$evt" $e_type)
+	locid=$(mptcp_lib_evts_get_info loc_id "$evt" $e_type)
+	remid=$(mptcp_lib_evts_get_info rem_id "$evt" $e_type)
 	if [ "$family" = "$AF_INET6" ]
 	then
-		saddr=$(sed --unbuffered -n 's/.*\(saddr6:\)\([0-9a-f:.]*\).*$/\2/p;q' "$evt")
-		daddr=$(sed --unbuffered -n 's/.*\(daddr6:\)\([0-9a-f:.]*\).*$/\2/p;q' "$evt")
+		saddr=$(mptcp_lib_evts_get_info saddr6 "$evt" $e_type)
+		daddr=$(mptcp_lib_evts_get_info daddr6 "$evt" $e_type)
 	else
-		saddr=$(sed --unbuffered -n 's/.*\(saddr4:\)\([0-9.]*\).*$/\2/p;q' "$evt")
-		daddr=$(sed --unbuffered -n 's/.*\(daddr4:\)\([0-9.]*\).*$/\2/p;q' "$evt")
+		saddr=$(mptcp_lib_evts_get_info saddr4 "$evt" $e_type)
+		daddr=$(mptcp_lib_evts_get_info daddr4 "$evt" $e_type)
 	fi
 
 	check_expected "type" "token" "daddr" "dport" "family" "saddr" "locid" "remid"
@@ -621,7 +618,7 @@ test_subflows()
 	mptcp_lib_kill_wait $listener_pid
 
 	local sport
-	sport=$(sed --unbuffered -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q' "$server_evts")
+	sport=$(mptcp_lib_evts_get_info sport "$server_evts" $SUB_ESTABLISHED)
 
 	# DESTROY_SUBFLOW from server to client machine
 	:>"$server_evts"
@@ -659,7 +656,7 @@ test_subflows()
 	# Delete the listener from the client ns, if one was created
 	mptcp_lib_kill_wait $listener_pid
 
-	sport=$(sed --unbuffered -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q' "$server_evts")
+	sport=$(mptcp_lib_evts_get_info sport "$server_evts" $SUB_ESTABLISHED)
 
 	# DESTROY_SUBFLOW6 from server to client machine
 	:>"$server_evts"
@@ -698,7 +695,7 @@ test_subflows()
 	# Delete the listener from the client ns, if one was created
 	mptcp_lib_kill_wait $listener_pid
 
-	sport=$(sed --unbuffered -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q' "$server_evts")
+	sport=$(mptcp_lib_evts_get_info sport "$server_evts" $SUB_ESTABLISHED)
 
 	# DESTROY_SUBFLOW from server to client machine
 	:>"$server_evts"
@@ -736,7 +733,7 @@ test_subflows()
 	# Delete the listener from the server ns, if one was created
 	mptcp_lib_kill_wait $listener_pid
 
-	sport=$(sed --unbuffered -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q' "$client_evts")
+	sport=$(mptcp_lib_evts_get_info sport "$client_evts" $SUB_ESTABLISHED)
 
 	# DESTROY_SUBFLOW from client to server machine
 	:>"$client_evts"
@@ -775,7 +772,7 @@ test_subflows()
 	# Delete the listener from the server ns, if one was created
 	mptcp_lib_kill_wait $listener_pid
 
-	sport=$(sed --unbuffered -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q' "$client_evts")
+	sport=$(mptcp_lib_evts_get_info sport "$client_evts" $SUB_ESTABLISHED)
 
 	# DESTROY_SUBFLOW6 from client to server machine
 	:>"$client_evts"
@@ -812,7 +809,7 @@ test_subflows()
 	# Delete the listener from the server ns, if one was created
 	mptcp_lib_kill_wait $listener_pid
 
-	sport=$(sed --unbuffered -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q' "$client_evts")
+	sport=$(mptcp_lib_evts_get_info sport "$client_evts" $SUB_ESTABLISHED)
 
 	# DESTROY_SUBFLOW from client to server machine
 	:>"$client_evts"
@@ -858,7 +855,7 @@ test_subflows_v4_v6_mix()
 	# Delete the listener from the server ns, if one was created
 	mptcp_lib_kill_wait $listener_pid
 
-	sport=$(sed --unbuffered -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q' "$client_evts")
+	sport=$(mptcp_lib_evts_get_info sport "$client_evts" $SUB_ESTABLISHED)
 
 	# DESTROY_SUBFLOW from client to server machine
 	:>"$client_evts"
@@ -926,18 +923,13 @@ verify_listener_events()
 		print_test "CLOSE_LISTENER $e_saddr:$e_sport"
 	fi
 
-	type=$(grep "type:$e_type," $evt |
-	       sed --unbuffered -n 's/.*\(type:\)\([[:digit:]]*\).*$/\2/p;q')
-	family=$(grep "type:$e_type," $evt |
-		 sed --unbuffered -n 's/.*\(family:\)\([[:digit:]]*\).*$/\2/p;q')
-	sport=$(grep "type:$e_type," $evt |
-		sed --unbuffered -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
+	type=$(mptcp_lib_evts_get_info type $evt $e_type)
+	family=$(mptcp_lib_evts_get_info family $evt $e_type)
+	sport=$(mptcp_lib_evts_get_info sport $evt $e_type)
 	if [ $family ] && [ $family = $AF_INET6 ]; then
-		saddr=$(grep "type:$e_type," $evt |
-			sed --unbuffered -n 's/.*\(saddr6:\)\([0-9a-f:.]*\).*$/\2/p;q')
+		saddr=$(mptcp_lib_evts_get_info saddr6 $evt $e_type)
 	else
-		saddr=$(grep "type:$e_type," $evt |
-			sed --unbuffered -n 's/.*\(saddr4:\)\([0-9.]*\).*$/\2/p;q')
+		saddr=$(mptcp_lib_evts_get_info saddr4 $evt $e_type)
 	fi
 
 	check_expected "type" "family" "saddr" "sport"

