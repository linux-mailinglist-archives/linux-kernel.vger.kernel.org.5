Return-Path: <linux-kernel+bounces-44941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C6E842943
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B774285F19
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553EF1386A3;
	Tue, 30 Jan 2024 16:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t98YS5KW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rAbIqHAj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F8412F58B;
	Tue, 30 Jan 2024 16:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706631975; cv=none; b=iXKIYdaHH6CQU2GbOn6x5q8xHVHhnjE3cL0lhnpgKA+1wStEw0k5GpXg0f9kPk+6SaJrKzk5z4cMs3WxLbwGOpmeJxB31Z9t6Q5TilVDGBr1U07+Dd5VmkP8CEKvFqBP8mJdQi/H1eWu7JtxXnYauVW4AC6eCZn1TPPRY2Sg6eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706631975; c=relaxed/simple;
	bh=cUuqvnzPPxw/F12MtVIIFn2+TWCYnfQCdvc75QmtQDQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=mnOSVuSeQZpCLQkrf5TmtrOdozJ/IX7hXvxNNS2G0QukWgwfREEBLEmG85kzV+5ARRiFtdZTEHtcNWkQbvylMWKetOZbk2+TF8ub/nQtRmgfo3/hXhNYFZDN/Ul61qO895UI6KJHDLrKn4GECn5Sgfn16BOC70kIeh3LdC/gWac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t98YS5KW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rAbIqHAj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Jan 2024 16:26:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706631971;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=idLqXTe/wwQB/igBLCGOH5+FLkHEWGOuPGcVMQiKXFA=;
	b=t98YS5KWKJV3qCOy0LT/J8IrYzh3qByi14Oo6OzpKf4uuTSTIBfNUuKiUiyuYeiN7Y1BhU
	uZEmJlL+51k++wtJZ18EdPTtkGbS1m7OQ0xbzog0WvrCvkJaMVNo1hCAWnsyvqpAO69bMZ
	xb8uDKY1x/p03NW8kz2LJt7kR+BSW8Nibcc52trwZMiK5+NPTmQ1fZ6JAeTliEgiiz2Et+
	T29aafNVVEKAoOZHZUi78HVQIbICxMvOySHe3qJexY1MJTD8DXgI7joJ58Yr8tWBoCC+Xb
	LrrEq/00zAg1Pmk55qvT2TrDPWelJMMMF8oGsxLBUDtaj75tWnE7tmot7zn8Uw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706631971;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=idLqXTe/wwQB/igBLCGOH5+FLkHEWGOuPGcVMQiKXFA=;
	b=rAbIqHAjkdxGpiP/dpP/CSwiQPjQP1nJFtnxoYHYr2VMdHj/L0spr4nAhz0RReFHFujMDI
	XfRib1vmF9FjQZBw==
From: "tip-bot2 for Brijesh Singh" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/sev: Add SEV-SNP host initialization support
Cc: Brijesh Singh <brijesh.singh@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Michael Roth <michael.roth@amd.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240126041126.1927228-5-michael.roth@amd.com>
References: <20240126041126.1927228-5-michael.roth@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170663197063.398.16703424700997276557.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     216d106c7ff7b3dcabacf2b5dc6c9c40eba7495c
Gitweb:        https://git.kernel.org/tip/216d106c7ff7b3dcabacf2b5dc6c9c40eba7495c
Author:        Brijesh Singh <brijesh.singh@amd.com>
AuthorDate:    Thu, 25 Jan 2024 22:11:04 -06:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 29 Jan 2024 17:20:23 +01:00

x86/sev: Add SEV-SNP host initialization support

The memory integrity guarantees of SEV-SNP are enforced through a new
structure called the Reverse Map Table (RMP). The RMP is a single data
structure shared across the system that contains one entry for every 4K
page of DRAM that may be used by SEV-SNP VMs. The APM Volume 2 section
on Secure Nested Paging (SEV-SNP) details a number of steps needed to
detect/enable SEV-SNP and RMP table support on the host:

 - Detect SEV-SNP support based on CPUID bit
 - Initialize the RMP table memory reported by the RMP base/end MSR
   registers and configure IOMMU to be compatible with RMP access
   restrictions
 - Set the MtrrFixDramModEn bit in SYSCFG MSR
 - Set the SecureNestedPagingEn and VMPLEn bits in the SYSCFG MSR
 - Configure IOMMU

RMP table entry format is non-architectural and it can vary by
processor. It is defined by the PPR document for each respective CPU
family. Restrict SNP support to CPU models/families which are compatible
with the current RMP table entry format to guard against any undefined
behavior when running on other system types. Future models/support will
handle this through an architectural mechanism to allow for broader
compatibility.

SNP host code depends on CONFIG_KVM_AMD_SEV config flag which may be
enabled even when CONFIG_AMD_MEM_ENCRYPT isn't set, so update the
SNP-specific IOMMU helpers used here to rely on CONFIG_KVM_AMD_SEV
instead of CONFIG_AMD_MEM_ENCRYPT.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Co-developed-by: Ashish Kalra <ashish.kalra@amd.com>
Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
Co-developed-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Co-developed-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Co-developed-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
Link: https://lore.kernel.org/r/20240126041126.1927228-5-michael.roth@amd.com
---
 arch/x86/Kbuild                  |   2 +-
 arch/x86/include/asm/msr-index.h |  11 +-
 arch/x86/include/asm/sev.h       |   6 +-
 arch/x86/kernel/cpu/amd.c        |  16 ++-
 arch/x86/virt/svm/Makefile       |   3 +-
 arch/x86/virt/svm/sev.c          | 216 ++++++++++++++++++++++++++++++-
 6 files changed, 253 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/virt/svm/Makefile
 create mode 100644 arch/x86/virt/svm/sev.c

diff --git a/arch/x86/Kbuild b/arch/x86/Kbuild
index 5a83da7..6a1f36d 100644
--- a/arch/x86/Kbuild
+++ b/arch/x86/Kbuild
@@ -28,5 +28,7 @@ obj-y += net/
 
 obj-$(CONFIG_KEXEC_FILE) += purgatory/
 
+obj-y += virt/svm/
+
 # for cleaning
 subdir- += boot tools
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index f1bd7b9..f482bc6 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -599,6 +599,8 @@
 #define MSR_AMD64_SEV_ENABLED		BIT_ULL(MSR_AMD64_SEV_ENABLED_BIT)
 #define MSR_AMD64_SEV_ES_ENABLED	BIT_ULL(MSR_AMD64_SEV_ES_ENABLED_BIT)
 #define MSR_AMD64_SEV_SNP_ENABLED	BIT_ULL(MSR_AMD64_SEV_SNP_ENABLED_BIT)
+#define MSR_AMD64_RMP_BASE		0xc0010132
+#define MSR_AMD64_RMP_END		0xc0010133
 
 /* SNP feature bits enabled by the hypervisor */
 #define MSR_AMD64_SNP_VTOM			BIT_ULL(3)
@@ -708,8 +710,15 @@
 #define MSR_K8_TOP_MEM1			0xc001001a
 #define MSR_K8_TOP_MEM2			0xc001001d
 #define MSR_AMD64_SYSCFG		0xc0010010
-#define MSR_AMD64_SYSCFG_MEM_ENCRYPT_BIT	23
+#define MSR_AMD64_SYSCFG_MEM_ENCRYPT_BIT 23
 #define MSR_AMD64_SYSCFG_MEM_ENCRYPT	BIT_ULL(MSR_AMD64_SYSCFG_MEM_ENCRYPT_BIT)
+#define MSR_AMD64_SYSCFG_SNP_EN_BIT	24
+#define MSR_AMD64_SYSCFG_SNP_EN		BIT_ULL(MSR_AMD64_SYSCFG_SNP_EN_BIT)
+#define MSR_AMD64_SYSCFG_SNP_VMPL_EN_BIT 25
+#define MSR_AMD64_SYSCFG_SNP_VMPL_EN	BIT_ULL(MSR_AMD64_SYSCFG_SNP_VMPL_EN_BIT)
+#define MSR_AMD64_SYSCFG_MFDM_BIT	19
+#define MSR_AMD64_SYSCFG_MFDM		BIT_ULL(MSR_AMD64_SYSCFG_MFDM_BIT)
+
 #define MSR_K8_INT_PENDING_MSG		0xc0010055
 /* C1E active bits in int pending message */
 #define K8_INTP_C1E_ACTIVE_MASK		0x18000000
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 5b4a1ce..1f59d8b 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -243,4 +243,10 @@ static inline u64 snp_get_unsupported_features(u64 status) { return 0; }
 static inline u64 sev_get_status(void) { return 0; }
 #endif
 
+#ifdef CONFIG_KVM_AMD_SEV
+bool snp_probe_rmptable_info(void);
+#else
+static inline bool snp_probe_rmptable_info(void) { return false; }
+#endif
+
 #endif
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 4baba69..ce89281 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -20,6 +20,7 @@
 #include <asm/delay.h>
 #include <asm/debugreg.h>
 #include <asm/resctrl.h>
+#include <asm/sev.h>
 
 #ifdef CONFIG_X86_64
 # include <asm/mmconfig.h>
@@ -587,6 +588,21 @@ static void bsp_init_amd(struct cpuinfo_x86 *c)
 		break;
 	}
 
+	if (cpu_has(c, X86_FEATURE_SEV_SNP)) {
+		/*
+		 * RMP table entry format is not architectural and it can vary by processor
+		 * and is defined by the per-processor PPR. Restrict SNP support on the
+		 * known CPU model and family for which the RMP table entry format is
+		 * currently defined for.
+		 */
+		if (!boot_cpu_has(X86_FEATURE_ZEN3) &&
+		    !boot_cpu_has(X86_FEATURE_ZEN4) &&
+		    !boot_cpu_has(X86_FEATURE_ZEN5))
+			setup_clear_cpu_cap(X86_FEATURE_SEV_SNP);
+		else if (!snp_probe_rmptable_info())
+			setup_clear_cpu_cap(X86_FEATURE_SEV_SNP);
+	}
+
 	return;
 
 warn:
diff --git a/arch/x86/virt/svm/Makefile b/arch/x86/virt/svm/Makefile
new file mode 100644
index 0000000..ef2a31b
--- /dev/null
+++ b/arch/x86/virt/svm/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_KVM_AMD_SEV) += sev.o
diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
new file mode 100644
index 0000000..575a9ff
--- /dev/null
+++ b/arch/x86/virt/svm/sev.c
@@ -0,0 +1,216 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * AMD SVM-SEV Host Support.
+ *
+ * Copyright (C) 2023 Advanced Micro Devices, Inc.
+ *
+ * Author: Ashish Kalra <ashish.kalra@amd.com>
+ *
+ */
+
+#include <linux/cc_platform.h>
+#include <linux/printk.h>
+#include <linux/mm_types.h>
+#include <linux/set_memory.h>
+#include <linux/memblock.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/cpumask.h>
+#include <linux/iommu.h>
+#include <linux/amd-iommu.h>
+
+#include <asm/sev.h>
+#include <asm/processor.h>
+#include <asm/setup.h>
+#include <asm/svm.h>
+#include <asm/smp.h>
+#include <asm/cpu.h>
+#include <asm/apic.h>
+#include <asm/cpuid.h>
+#include <asm/cmdline.h>
+#include <asm/iommu.h>
+
+/*
+ * The RMP entry format is not architectural. The format is defined in PPR
+ * Family 19h Model 01h, Rev B1 processor.
+ */
+struct rmpentry {
+	u64	assigned	: 1,
+		pagesize	: 1,
+		immutable	: 1,
+		rsvd1		: 9,
+		gpa		: 39,
+		asid		: 10,
+		vmsa		: 1,
+		validated	: 1,
+		rsvd2		: 1;
+	u64 rsvd3;
+} __packed;
+
+/*
+ * The first 16KB from the RMP_BASE is used by the processor for the
+ * bookkeeping, the range needs to be added during the RMP entry lookup.
+ */
+#define RMPTABLE_CPU_BOOKKEEPING_SZ	0x4000
+
+static u64 probed_rmp_base, probed_rmp_size;
+static struct rmpentry *rmptable __ro_after_init;
+static u64 rmptable_max_pfn __ro_after_init;
+
+#undef pr_fmt
+#define pr_fmt(fmt)	"SEV-SNP: " fmt
+
+static int __mfd_enable(unsigned int cpu)
+{
+	u64 val;
+
+	if (!cpu_feature_enabled(X86_FEATURE_SEV_SNP))
+		return 0;
+
+	rdmsrl(MSR_AMD64_SYSCFG, val);
+
+	val |= MSR_AMD64_SYSCFG_MFDM;
+
+	wrmsrl(MSR_AMD64_SYSCFG, val);
+
+	return 0;
+}
+
+static __init void mfd_enable(void *arg)
+{
+	__mfd_enable(smp_processor_id());
+}
+
+static int __snp_enable(unsigned int cpu)
+{
+	u64 val;
+
+	if (!cpu_feature_enabled(X86_FEATURE_SEV_SNP))
+		return 0;
+
+	rdmsrl(MSR_AMD64_SYSCFG, val);
+
+	val |= MSR_AMD64_SYSCFG_SNP_EN;
+	val |= MSR_AMD64_SYSCFG_SNP_VMPL_EN;
+
+	wrmsrl(MSR_AMD64_SYSCFG, val);
+
+	return 0;
+}
+
+static __init void snp_enable(void *arg)
+{
+	__snp_enable(smp_processor_id());
+}
+
+#define RMP_ADDR_MASK GENMASK_ULL(51, 13)
+
+bool snp_probe_rmptable_info(void)
+{
+	u64 max_rmp_pfn, calc_rmp_sz, rmp_sz, rmp_base, rmp_end;
+
+	rdmsrl(MSR_AMD64_RMP_BASE, rmp_base);
+	rdmsrl(MSR_AMD64_RMP_END, rmp_end);
+
+	if (!(rmp_base & RMP_ADDR_MASK) || !(rmp_end & RMP_ADDR_MASK)) {
+		pr_err("Memory for the RMP table has not been reserved by BIOS\n");
+		return false;
+	}
+
+	if (rmp_base > rmp_end) {
+		pr_err("RMP configuration not valid: base=%#llx, end=%#llx\n", rmp_base, rmp_end);
+		return false;
+	}
+
+	rmp_sz = rmp_end - rmp_base + 1;
+
+	/*
+	 * Calculate the amount the memory that must be reserved by the BIOS to
+	 * address the whole RAM, including the bookkeeping area. The RMP itself
+	 * must also be covered.
+	 */
+	max_rmp_pfn = max_pfn;
+	if (PHYS_PFN(rmp_end) > max_pfn)
+		max_rmp_pfn = PHYS_PFN(rmp_end);
+
+	calc_rmp_sz = (max_rmp_pfn << 4) + RMPTABLE_CPU_BOOKKEEPING_SZ;
+
+	if (calc_rmp_sz > rmp_sz) {
+		pr_err("Memory reserved for the RMP table does not cover full system RAM (expected 0x%llx got 0x%llx)\n",
+		       calc_rmp_sz, rmp_sz);
+		return false;
+	}
+
+	probed_rmp_base = rmp_base;
+	probed_rmp_size = rmp_sz;
+
+	pr_info("RMP table physical range [0x%016llx - 0x%016llx]\n",
+		probed_rmp_base, probed_rmp_base + probed_rmp_size - 1);
+
+	return true;
+}
+
+/*
+ * Do the necessary preparations which are verified by the firmware as
+ * described in the SNP_INIT_EX firmware command description in the SNP
+ * firmware ABI spec.
+ */
+static int __init snp_rmptable_init(void)
+{
+	void *rmptable_start;
+	u64 rmptable_size;
+	u64 val;
+
+	if (!cpu_feature_enabled(X86_FEATURE_SEV_SNP))
+		return 0;
+
+	if (!amd_iommu_snp_en)
+		return 0;
+
+	if (!probed_rmp_size)
+		goto nosnp;
+
+	rmptable_start = memremap(probed_rmp_base, probed_rmp_size, MEMREMAP_WB);
+	if (!rmptable_start) {
+		pr_err("Failed to map RMP table\n");
+		return 1;
+	}
+
+	/*
+	 * Check if SEV-SNP is already enabled, this can happen in case of
+	 * kexec boot.
+	 */
+	rdmsrl(MSR_AMD64_SYSCFG, val);
+	if (val & MSR_AMD64_SYSCFG_SNP_EN)
+		goto skip_enable;
+
+	memset(rmptable_start, 0, probed_rmp_size);
+
+	/* Flush the caches to ensure that data is written before SNP is enabled. */
+	wbinvd_on_all_cpus();
+
+	/* MtrrFixDramModEn must be enabled on all the CPUs prior to enabling SNP. */
+	on_each_cpu(mfd_enable, NULL, 1);
+
+	on_each_cpu(snp_enable, NULL, 1);
+
+skip_enable:
+	rmptable_start += RMPTABLE_CPU_BOOKKEEPING_SZ;
+	rmptable_size = probed_rmp_size - RMPTABLE_CPU_BOOKKEEPING_SZ;
+
+	rmptable = (struct rmpentry *)rmptable_start;
+	rmptable_max_pfn = rmptable_size / sizeof(struct rmpentry) - 1;
+
+	cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "x86/rmptable_init:online", __snp_enable, NULL);
+
+	return 0;
+
+nosnp:
+	setup_clear_cpu_cap(X86_FEATURE_SEV_SNP);
+	return -ENOSYS;
+}
+
+/*
+ * This must be called after the IOMMU has been initialized.
+ */
+device_initcall(snp_rmptable_init);

