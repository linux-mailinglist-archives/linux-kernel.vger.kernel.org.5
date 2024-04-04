Return-Path: <linux-kernel+bounces-131153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB358983CA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8D3F1C23433
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 09:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C4074BFE;
	Thu,  4 Apr 2024 09:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yYCaMPyO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qlulG60G"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9DF1E86F;
	Thu,  4 Apr 2024 09:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712221880; cv=none; b=THLHOp4+T1wZOTofPiVOriv94bLbepPwD84Cc7tDtVp6UQREqH+1FZafI3gDuOKkNPJiqDX5PL43td4v8GxlR31I2cA4zhCMfPr1hj3XZqLrcHYTMQ5YR7yPsZdl7AX1PBMaNFIOuORFD/DwwidOSOGne/ZHwchw5RM0370DH+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712221880; c=relaxed/simple;
	bh=rp4Sif1zZ6vH5WmQft9eZ+WjU0jvt6p6GDS0S4wx6gM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=C4jmEWEXLvL4WFnhJMaOad1WFTpDM1XEpXwxtz9asDWFMU5jHANcYm8crBH0YEOJlT+e8TyMiGDCed9JDcV0Obk+LJEWn86AXcLdwewDKX/5XVpPu8Z9kZVWkNUYHk62B+b7Ihg2eHnlvmplkAmT1e5LQa8+D1yNLDJM5FpspjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yYCaMPyO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qlulG60G; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 04 Apr 2024 09:11:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712221875;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UTjOneyw9ICdNfMU/OuehX0z+uIkl5iql4xkhAQ2nZI=;
	b=yYCaMPyOmxr6nnl3ucGMMogNAskmSQpME5XRoYQ2N52MieKogt6GNyNAuEXN5hUBvSmLWY
	X7FR52kIUuS6rk4LSWyhtmOKF8lF5oPpDg7YTQx4aqcgffWQ90Vj8DaPZxbyIRveh9Uz4A
	3l+OBVxh2OJXZbMnWxuSPuycHeFc1tzLzoqPS8tOwt8PkOoXQbLrrZWXvWBB5vBQ0Efzky
	DvZM3gaiR1cNyhzeW3CeOt3vK/ZnPTlMv/5Pf3o54wZdVHKvOw3xFWiooo0Cx9v8zK5ypc
	BT+WDSPtbMIohgus6jrQWRByVI+NNw8q6CW7PoPwT9jOyPohXaJVdT2yOnc/tQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712221875;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UTjOneyw9ICdNfMU/OuehX0z+uIkl5iql4xkhAQ2nZI=;
	b=qlulG60GcGVyFnUaVIgqLNzae2ZwLQz2bPR51IWBsRytplEJ94QyCNIT431DYcOnVZCCPh
	C4u7CP3bFtFbmYCw==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/urgent] x86/CPU/AMD: Track SNP host status with cc_platform_*()
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>,
 Tom Lendacky <thomas.lendacky@amd.com>, Srikanth Aithal <sraithal@amd.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240327154317.29909-6-bp@alien8.de>
References: <20240327154317.29909-6-bp@alien8.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171222187434.10875.5343618940901502172.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     0ecaefb303de69929dc0036d5021d01cec7ea052
Gitweb:        https://git.kernel.org/tip/0ecaefb303de69929dc0036d5021d01cec7ea052
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Wed, 27 Mar 2024 16:43:17 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 04 Apr 2024 10:40:30 +02:00

x86/CPU/AMD: Track SNP host status with cc_platform_*()

The host SNP worthiness can determined later, after alternatives have
been patched, in snp_rmptable_init() depending on cmdline options like
iommu=pt which is incompatible with SNP, for example.

Which means that one cannot use X86_FEATURE_SEV_SNP and will need to
have a special flag for that control.

Use that newly added CC_ATTR_HOST_SEV_SNP in the appropriate places.

Move kdump_sev_callback() to its rightful place, while at it.

Fixes: 216d106c7ff7 ("x86/sev: Add SEV-SNP host initialization support")
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Tested-by: Srikanth Aithal <sraithal@amd.com>
Link: https://lore.kernel.org/r/20240327154317.29909-6-bp@alien8.de
---
 arch/x86/include/asm/sev.h         |  4 +--
 arch/x86/kernel/cpu/amd.c          | 38 +++++++++++++++++------------
 arch/x86/kernel/cpu/mtrr/generic.c |  2 +-
 arch/x86/kernel/sev.c              | 10 +--------
 arch/x86/kvm/svm/sev.c             |  2 +-
 arch/x86/virt/svm/sev.c            | 26 +++++++++++++-------
 drivers/crypto/ccp/sev-dev.c       |  2 +-
 drivers/iommu/amd/init.c           |  4 ++-
 8 files changed, 49 insertions(+), 39 deletions(-)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 07e125f..7f57382 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -228,7 +228,6 @@ int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, struct sn
 void snp_accept_memory(phys_addr_t start, phys_addr_t end);
 u64 snp_get_unsupported_features(u64 status);
 u64 sev_get_status(void);
-void kdump_sev_callback(void);
 void sev_show_status(void);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
@@ -258,7 +257,6 @@ static inline int snp_issue_guest_request(u64 exit_code, struct snp_req_data *in
 static inline void snp_accept_memory(phys_addr_t start, phys_addr_t end) { }
 static inline u64 snp_get_unsupported_features(u64 status) { return 0; }
 static inline u64 sev_get_status(void) { return 0; }
-static inline void kdump_sev_callback(void) { }
 static inline void sev_show_status(void) { }
 #endif
 
@@ -270,6 +268,7 @@ int psmash(u64 pfn);
 int rmp_make_private(u64 pfn, u64 gpa, enum pg_level level, u32 asid, bool immutable);
 int rmp_make_shared(u64 pfn, enum pg_level level);
 void snp_leak_pages(u64 pfn, unsigned int npages);
+void kdump_sev_callback(void);
 #else
 static inline bool snp_probe_rmptable_info(void) { return false; }
 static inline int snp_lookup_rmpentry(u64 pfn, bool *assigned, int *level) { return -ENODEV; }
@@ -282,6 +281,7 @@ static inline int rmp_make_private(u64 pfn, u64 gpa, enum pg_level level, u32 as
 }
 static inline int rmp_make_shared(u64 pfn, enum pg_level level) { return -ENODEV; }
 static inline void snp_leak_pages(u64 pfn, unsigned int npages) {}
+static inline void kdump_sev_callback(void) { }
 #endif
 
 #endif
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 6d8677e..9bf17c9 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -345,6 +345,28 @@ static void srat_detect_node(struct cpuinfo_x86 *c)
 #endif
 }
 
+static void bsp_determine_snp(struct cpuinfo_x86 *c)
+{
+#ifdef CONFIG_ARCH_HAS_CC_PLATFORM
+	cc_vendor = CC_VENDOR_AMD;
+
+	if (cpu_has(c, X86_FEATURE_SEV_SNP)) {
+		/*
+		 * RMP table entry format is not architectural and is defined by the
+		 * per-processor PPR. Restrict SNP support on the known CPU models
+		 * for which the RMP table entry format is currently defined for.
+		 */
+		if (!cpu_has(c, X86_FEATURE_HYPERVISOR) &&
+		    c->x86 >= 0x19 && snp_probe_rmptable_info()) {
+			cc_platform_set(CC_ATTR_HOST_SEV_SNP);
+		} else {
+			setup_clear_cpu_cap(X86_FEATURE_SEV_SNP);
+			cc_platform_clear(CC_ATTR_HOST_SEV_SNP);
+		}
+	}
+#endif
+}
+
 static void bsp_init_amd(struct cpuinfo_x86 *c)
 {
 	if (cpu_has(c, X86_FEATURE_CONSTANT_TSC)) {
@@ -452,21 +474,7 @@ static void bsp_init_amd(struct cpuinfo_x86 *c)
 		break;
 	}
 
-	if (cpu_has(c, X86_FEATURE_SEV_SNP)) {
-		/*
-		 * RMP table entry format is not architectural and it can vary by processor
-		 * and is defined by the per-processor PPR. Restrict SNP support on the
-		 * known CPU model and family for which the RMP table entry format is
-		 * currently defined for.
-		 */
-		if (!boot_cpu_has(X86_FEATURE_ZEN3) &&
-		    !boot_cpu_has(X86_FEATURE_ZEN4) &&
-		    !boot_cpu_has(X86_FEATURE_ZEN5))
-			setup_clear_cpu_cap(X86_FEATURE_SEV_SNP);
-		else if (!snp_probe_rmptable_info())
-			setup_clear_cpu_cap(X86_FEATURE_SEV_SNP);
-	}
-
+	bsp_determine_snp(c);
 	return;
 
 warn:
diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
index 422a4dd..7b29ebd 100644
--- a/arch/x86/kernel/cpu/mtrr/generic.c
+++ b/arch/x86/kernel/cpu/mtrr/generic.c
@@ -108,7 +108,7 @@ static inline void k8_check_syscfg_dram_mod_en(void)
 	      (boot_cpu_data.x86 >= 0x0f)))
 		return;
 
-	if (cpu_feature_enabled(X86_FEATURE_SEV_SNP))
+	if (cc_platform_has(CC_ATTR_HOST_SEV_SNP))
 		return;
 
 	rdmsr(MSR_AMD64_SYSCFG, lo, hi);
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 7e1e63c..38ad066 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -2284,16 +2284,6 @@ static int __init snp_init_platform_device(void)
 }
 device_initcall(snp_init_platform_device);
 
-void kdump_sev_callback(void)
-{
-	/*
-	 * Do wbinvd() on remote CPUs when SNP is enabled in order to
-	 * safely do SNP_SHUTDOWN on the local CPU.
-	 */
-	if (cpu_feature_enabled(X86_FEATURE_SEV_SNP))
-		wbinvd();
-}
-
 void sev_show_status(void)
 {
 	int i;
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index ae0ac12..3d310b4 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3174,7 +3174,7 @@ struct page *snp_safe_alloc_page(struct kvm_vcpu *vcpu)
 	unsigned long pfn;
 	struct page *p;
 
-	if (!cpu_feature_enabled(X86_FEATURE_SEV_SNP))
+	if (!cc_platform_has(CC_ATTR_HOST_SEV_SNP))
 		return alloc_page(GFP_KERNEL_ACCOUNT | __GFP_ZERO);
 
 	/*
diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
index cffe115..ab0e844 100644
--- a/arch/x86/virt/svm/sev.c
+++ b/arch/x86/virt/svm/sev.c
@@ -77,7 +77,7 @@ static int __mfd_enable(unsigned int cpu)
 {
 	u64 val;
 
-	if (!cpu_feature_enabled(X86_FEATURE_SEV_SNP))
+	if (!cc_platform_has(CC_ATTR_HOST_SEV_SNP))
 		return 0;
 
 	rdmsrl(MSR_AMD64_SYSCFG, val);
@@ -98,7 +98,7 @@ static int __snp_enable(unsigned int cpu)
 {
 	u64 val;
 
-	if (!cpu_feature_enabled(X86_FEATURE_SEV_SNP))
+	if (!cc_platform_has(CC_ATTR_HOST_SEV_SNP))
 		return 0;
 
 	rdmsrl(MSR_AMD64_SYSCFG, val);
@@ -174,11 +174,11 @@ static int __init snp_rmptable_init(void)
 	u64 rmptable_size;
 	u64 val;
 
-	if (!cpu_feature_enabled(X86_FEATURE_SEV_SNP))
+	if (!cc_platform_has(CC_ATTR_HOST_SEV_SNP))
 		return 0;
 
 	if (!amd_iommu_snp_en)
-		return 0;
+		goto nosnp;
 
 	if (!probed_rmp_size)
 		goto nosnp;
@@ -225,7 +225,7 @@ skip_enable:
 	return 0;
 
 nosnp:
-	setup_clear_cpu_cap(X86_FEATURE_SEV_SNP);
+	cc_platform_clear(CC_ATTR_HOST_SEV_SNP);
 	return -ENOSYS;
 }
 
@@ -246,7 +246,7 @@ static struct rmpentry *__snp_lookup_rmpentry(u64 pfn, int *level)
 {
 	struct rmpentry *large_entry, *entry;
 
-	if (!cpu_feature_enabled(X86_FEATURE_SEV_SNP))
+	if (!cc_platform_has(CC_ATTR_HOST_SEV_SNP))
 		return ERR_PTR(-ENODEV);
 
 	entry = get_rmpentry(pfn);
@@ -363,7 +363,7 @@ int psmash(u64 pfn)
 	unsigned long paddr = pfn << PAGE_SHIFT;
 	int ret;
 
-	if (!cpu_feature_enabled(X86_FEATURE_SEV_SNP))
+	if (!cc_platform_has(CC_ATTR_HOST_SEV_SNP))
 		return -ENODEV;
 
 	if (!pfn_valid(pfn))
@@ -472,7 +472,7 @@ static int rmpupdate(u64 pfn, struct rmp_state *state)
 	unsigned long paddr = pfn << PAGE_SHIFT;
 	int ret, level;
 
-	if (!cpu_feature_enabled(X86_FEATURE_SEV_SNP))
+	if (!cc_platform_has(CC_ATTR_HOST_SEV_SNP))
 		return -ENODEV;
 
 	level = RMP_TO_PG_LEVEL(state->pagesize);
@@ -558,3 +558,13 @@ void snp_leak_pages(u64 pfn, unsigned int npages)
 	spin_unlock(&snp_leaked_pages_list_lock);
 }
 EXPORT_SYMBOL_GPL(snp_leak_pages);
+
+void kdump_sev_callback(void)
+{
+	/*
+	 * Do wbinvd() on remote CPUs when SNP is enabled in order to
+	 * safely do SNP_SHUTDOWN on the local CPU.
+	 */
+	if (cc_platform_has(CC_ATTR_HOST_SEV_SNP))
+		wbinvd();
+}
diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index f44efbb..2102377 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -1090,7 +1090,7 @@ static int __sev_snp_init_locked(int *error)
 	void *arg = &data;
 	int cmd, rc = 0;
 
-	if (!cpu_feature_enabled(X86_FEATURE_SEV_SNP))
+	if (!cc_platform_has(CC_ATTR_HOST_SEV_SNP))
 		return -ENODEV;
 
 	sev = psp->sev_data;
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index e7a4492..33228c1 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3228,7 +3228,7 @@ out:
 static void iommu_snp_enable(void)
 {
 #ifdef CONFIG_KVM_AMD_SEV
-	if (!cpu_feature_enabled(X86_FEATURE_SEV_SNP))
+	if (!cc_platform_has(CC_ATTR_HOST_SEV_SNP))
 		return;
 	/*
 	 * The SNP support requires that IOMMU must be enabled, and is
@@ -3236,12 +3236,14 @@ static void iommu_snp_enable(void)
 	 */
 	if (no_iommu || iommu_default_passthrough()) {
 		pr_err("SNP: IOMMU disabled or configured in passthrough mode, SNP cannot be supported.\n");
+		cc_platform_clear(CC_ATTR_HOST_SEV_SNP);
 		return;
 	}
 
 	amd_iommu_snp_en = check_feature(FEATURE_SNP);
 	if (!amd_iommu_snp_en) {
 		pr_err("SNP: IOMMU SNP feature not enabled, SNP cannot be supported.\n");
+		cc_platform_clear(CC_ATTR_HOST_SEV_SNP);
 		return;
 	}
 

