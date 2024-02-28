Return-Path: <linux-kernel+bounces-85074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A477186B00B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:12:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 307EE1F27904
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF9C14AD34;
	Wed, 28 Feb 2024 13:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uNlkpiAI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xHukRKPx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315C3145351;
	Wed, 28 Feb 2024 13:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709125920; cv=none; b=M6OuWyQaYoYqLRA4iiWD1ypeXTXYZ/Niu1b951/x6S6tSib2jiO2nqmNUQy8u6Go14QlZ3G5ILkSoeS1l5wIM/XT1qM2bl0U/Ycodx0opxxk6RBQo1qwx5RsTmzRyzf/qTC7LSYByyCdnNtydkiGmhgjsD5+c4qk4irb+WrALf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709125920; c=relaxed/simple;
	bh=JzVreiVX2TEg4kRuW356/uIRTaZnjr46I2pv8PX8aM4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=vGWTY41fCWVc74gDuWBCo3FspvTRpmmye4Q63VlrDf6uffr7kf6HpyfNnxkc8v2Q7LEhJyC2ABZ0Ubx4pglScZOtDPh2/Y9GGC/C6jXUX4pYu7DzXK0QgBPjUBinz0vcApc0lpWNMTmoJX9+JCX+iZSg9fjh6c7OvJwTpTsOSlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uNlkpiAI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xHukRKPx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 28 Feb 2024 13:11:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709125916;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i+6a91jMpvDMQLu1paibLQ+7oobBpoWoNB/4/FSI1XE=;
	b=uNlkpiAItVEkszY7CRRJ8C9Z9FXJJMc+3QcozpPdBxCEnCdnoSEzN2oPBr8fZ5FfyaxrSN
	r8F2XrIybaYMOJYafiDJh3IY7oLqyfZ5zSFhGTHLd3g9YVkgvHOVyArQDHN4muVzbOVNJ7
	L2fDDUwhruoOro1FwIH3HmosnMCTyBKecOTEkUzl94qcA64Yj8cZMtZJJHYt6DCu7UeiXN
	Fl3D47o+PnZ92jrkLmxbpeT4E+DhInvoTY5FruJMKqe38/cWjOToW47+ScliwHpqxXD8wo
	4nwjhiSZFaKlfJbI8PLvLldpw0MVrsiOnYAg0tsIltiuI1LFXCGt1TcRlVv/BA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709125916;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i+6a91jMpvDMQLu1paibLQ+7oobBpoWoNB/4/FSI1XE=;
	b=xHukRKPxNA5hMo6Q4A4QFCj0eVDqDrJ4HB5ToVecB81uF8/zW4g27SiAjRfWsXHCMxSuK5
	pTB/gXkxYcor3hCw==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/sev: Dump SEV_STATUS
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>, Nikunj A Dadhania <nikunj@amd.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240219094216.GAZdMieDHKiI8aaP3n@fat_crate.local>
References: <20240219094216.GAZdMieDHKiI8aaP3n@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170912591511.398.7824811566252696747.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     d7b69b590bc9a5d299c82d3b27772cece0238d38
Gitweb:        https://git.kernel.org/tip/d7b69b590bc9a5d299c82d3b27772cece0238d38
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Mon, 19 Feb 2024 10:42:16 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 28 Feb 2024 13:39:37 +01:00

x86/sev: Dump SEV_STATUS

It is, and will be even more useful in the future, to dump the SEV
features enabled according to SEV_STATUS. Do so:

  [    0.542753] Memory Encryption Features active: AMD SEV SEV-ES SEV-SNP
  [    0.544425] SEV: Status: SEV SEV-ES SEV-SNP DebugSwap

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>
Link: https://lore.kernel.org/r/20240219094216.GAZdMieDHKiI8aaP3n@fat_crate.local
---
 arch/x86/boot/compressed/sev.c   |  2 +-
 arch/x86/include/asm/msr-index.h | 59 ++++++++++++++++++-------------
 arch/x86/include/asm/sev.h       |  2 +-
 arch/x86/kernel/sev.c            | 35 ++++++++++++++++++-
 arch/x86/mm/mem_encrypt.c        |  5 +++-
 5 files changed, 78 insertions(+), 25 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 0732918..9db6302 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -369,7 +369,7 @@ static void enforce_vmpl0(void)
 				 MSR_AMD64_SNP_VMPL_SSS |		\
 				 MSR_AMD64_SNP_SECURE_TSC |		\
 				 MSR_AMD64_SNP_VMGEXIT_PARAM |		\
-				 MSR_AMD64_SNP_VMSA_REG_PROTECTION |	\
+				 MSR_AMD64_SNP_VMSA_REG_PROT |		\
 				 MSR_AMD64_SNP_RESERVED_BIT13 |		\
 				 MSR_AMD64_SNP_RESERVED_BIT15 |		\
 				 MSR_AMD64_SNP_RESERVED_MASK)
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index f482bc6..f8c73a5 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -594,36 +594,47 @@
 #define MSR_AMD64_SEV_ES_GHCB		0xc0010130
 #define MSR_AMD64_SEV			0xc0010131
 #define MSR_AMD64_SEV_ENABLED_BIT	0
-#define MSR_AMD64_SEV_ES_ENABLED_BIT	1
-#define MSR_AMD64_SEV_SNP_ENABLED_BIT	2
 #define MSR_AMD64_SEV_ENABLED		BIT_ULL(MSR_AMD64_SEV_ENABLED_BIT)
+#define MSR_AMD64_SEV_ES_ENABLED_BIT	1
 #define MSR_AMD64_SEV_ES_ENABLED	BIT_ULL(MSR_AMD64_SEV_ES_ENABLED_BIT)
+#define MSR_AMD64_SEV_SNP_ENABLED_BIT	2
 #define MSR_AMD64_SEV_SNP_ENABLED	BIT_ULL(MSR_AMD64_SEV_SNP_ENABLED_BIT)
-#define MSR_AMD64_RMP_BASE		0xc0010132
-#define MSR_AMD64_RMP_END		0xc0010133
-
-/* SNP feature bits enabled by the hypervisor */
-#define MSR_AMD64_SNP_VTOM			BIT_ULL(3)
-#define MSR_AMD64_SNP_REFLECT_VC		BIT_ULL(4)
-#define MSR_AMD64_SNP_RESTRICTED_INJ		BIT_ULL(5)
-#define MSR_AMD64_SNP_ALT_INJ			BIT_ULL(6)
-#define MSR_AMD64_SNP_DEBUG_SWAP		BIT_ULL(7)
-#define MSR_AMD64_SNP_PREVENT_HOST_IBS		BIT_ULL(8)
-#define MSR_AMD64_SNP_BTB_ISOLATION		BIT_ULL(9)
-#define MSR_AMD64_SNP_VMPL_SSS			BIT_ULL(10)
-#define MSR_AMD64_SNP_SECURE_TSC		BIT_ULL(11)
-#define MSR_AMD64_SNP_VMGEXIT_PARAM		BIT_ULL(12)
-#define MSR_AMD64_SNP_IBS_VIRT			BIT_ULL(14)
-#define MSR_AMD64_SNP_VMSA_REG_PROTECTION	BIT_ULL(16)
-#define MSR_AMD64_SNP_SMT_PROTECTION		BIT_ULL(17)
-
-/* SNP feature bits reserved for future use. */
-#define MSR_AMD64_SNP_RESERVED_BIT13		BIT_ULL(13)
-#define MSR_AMD64_SNP_RESERVED_BIT15		BIT_ULL(15)
-#define MSR_AMD64_SNP_RESERVED_MASK		GENMASK_ULL(63, 18)
+#define MSR_AMD64_SNP_VTOM_BIT		3
+#define MSR_AMD64_SNP_VTOM		BIT_ULL(MSR_AMD64_SNP_VTOM_BIT)
+#define MSR_AMD64_SNP_REFLECT_VC_BIT	4
+#define MSR_AMD64_SNP_REFLECT_VC	BIT_ULL(MSR_AMD64_SNP_REFLECT_VC_BIT)
+#define MSR_AMD64_SNP_RESTRICTED_INJ_BIT 5
+#define MSR_AMD64_SNP_RESTRICTED_INJ	BIT_ULL(MSR_AMD64_SNP_RESTRICTED_INJ_BIT)
+#define MSR_AMD64_SNP_ALT_INJ_BIT	6
+#define MSR_AMD64_SNP_ALT_INJ		BIT_ULL(MSR_AMD64_SNP_ALT_INJ_BIT)
+#define MSR_AMD64_SNP_DEBUG_SWAP_BIT	7
+#define MSR_AMD64_SNP_DEBUG_SWAP	BIT_ULL(MSR_AMD64_SNP_DEBUG_SWAP_BIT)
+#define MSR_AMD64_SNP_PREVENT_HOST_IBS_BIT 8
+#define MSR_AMD64_SNP_PREVENT_HOST_IBS	BIT_ULL(MSR_AMD64_SNP_PREVENT_HOST_IBS_BIT)
+#define MSR_AMD64_SNP_BTB_ISOLATION_BIT	9
+#define MSR_AMD64_SNP_BTB_ISOLATION	BIT_ULL(MSR_AMD64_SNP_BTB_ISOLATION_BIT)
+#define MSR_AMD64_SNP_VMPL_SSS_BIT	10
+#define MSR_AMD64_SNP_VMPL_SSS		BIT_ULL(MSR_AMD64_SNP_VMPL_SSS_BIT)
+#define MSR_AMD64_SNP_SECURE_TSC_BIT	11
+#define MSR_AMD64_SNP_SECURE_TSC	BIT_ULL(MSR_AMD64_SNP_SECURE_TSC_BIT)
+#define MSR_AMD64_SNP_VMGEXIT_PARAM_BIT	12
+#define MSR_AMD64_SNP_VMGEXIT_PARAM	BIT_ULL(MSR_AMD64_SNP_VMGEXIT_PARAM_BIT)
+#define MSR_AMD64_SNP_RESERVED_BIT13	BIT_ULL(13)
+#define MSR_AMD64_SNP_IBS_VIRT_BIT	14
+#define MSR_AMD64_SNP_IBS_VIRT		BIT_ULL(MSR_AMD64_SNP_IBS_VIRT_BIT)
+#define MSR_AMD64_SNP_RESERVED_BIT15	BIT_ULL(15)
+#define MSR_AMD64_SNP_VMSA_REG_PROT_BIT	16
+#define MSR_AMD64_SNP_VMSA_REG_PROT	BIT_ULL(MSR_AMD64_SNP_VMSA_REG_PROT_BIT)
+#define MSR_AMD64_SNP_SMT_PROT_BIT	17
+#define MSR_AMD64_SNP_SMT_PROT		BIT_ULL(MSR_AMD64_SNP_SMT_PROT_BIT)
+#define MSR_AMD64_SNP_RESV_BIT		18
+#define MSR_AMD64_SNP_RESERVED_MASK	GENMASK_ULL(63, MSR_AMD64_SNP_RESV_BIT)
 
 #define MSR_AMD64_VIRT_SPEC_CTRL	0xc001011f
 
+#define MSR_AMD64_RMP_BASE		0xc0010132
+#define MSR_AMD64_RMP_END		0xc0010133
+
 /* AMD Collaborative Processor Performance Control MSRs */
 #define MSR_AMD_CPPC_CAP1		0xc00102b0
 #define MSR_AMD_CPPC_ENABLE		0xc00102b1
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index bed95e1..f000635 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -228,6 +228,7 @@ void snp_accept_memory(phys_addr_t start, phys_addr_t end);
 u64 snp_get_unsupported_features(u64 status);
 u64 sev_get_status(void);
 void kdump_sev_callback(void);
+void sev_show_status(void);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
@@ -257,6 +258,7 @@ static inline void snp_accept_memory(phys_addr_t start, phys_addr_t end) { }
 static inline u64 snp_get_unsupported_features(u64 status) { return 0; }
 static inline u64 sev_get_status(void) { return 0; }
 static inline void kdump_sev_callback(void) { }
+static inline void sev_show_status(void) { }
 #endif
 
 #ifdef CONFIG_KVM_AMD_SEV
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 1ef7ae8..7d24289 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -59,6 +59,25 @@
 #define AP_INIT_CR0_DEFAULT		0x60000010
 #define AP_INIT_MXCSR_DEFAULT		0x1f80
 
+static const char * const sev_status_feat_names[] = {
+	[MSR_AMD64_SEV_ENABLED_BIT]		= "SEV",
+	[MSR_AMD64_SEV_ES_ENABLED_BIT]		= "SEV-ES",
+	[MSR_AMD64_SEV_SNP_ENABLED_BIT]		= "SEV-SNP",
+	[MSR_AMD64_SNP_VTOM_BIT]		= "vTom",
+	[MSR_AMD64_SNP_REFLECT_VC_BIT]		= "ReflectVC",
+	[MSR_AMD64_SNP_RESTRICTED_INJ_BIT]	= "RI",
+	[MSR_AMD64_SNP_ALT_INJ_BIT]		= "AI",
+	[MSR_AMD64_SNP_DEBUG_SWAP_BIT]		= "DebugSwap",
+	[MSR_AMD64_SNP_PREVENT_HOST_IBS_BIT]	= "NoHostIBS",
+	[MSR_AMD64_SNP_BTB_ISOLATION_BIT]	= "BTBIsol",
+	[MSR_AMD64_SNP_VMPL_SSS_BIT]		= "VmplSSS",
+	[MSR_AMD64_SNP_SECURE_TSC_BIT]		= "SecureTSC",
+	[MSR_AMD64_SNP_VMGEXIT_PARAM_BIT]	= "VMGExitParam",
+	[MSR_AMD64_SNP_IBS_VIRT_BIT]		= "IBSVirt",
+	[MSR_AMD64_SNP_VMSA_REG_PROT_BIT]	= "VMSARegProt",
+	[MSR_AMD64_SNP_SMT_PROT_BIT]		= "SMTProt",
+};
+
 /* For early boot hypervisor communication in SEV-ES enabled guests */
 static struct ghcb boot_ghcb_page __bss_decrypted __aligned(PAGE_SIZE);
 
@@ -2275,3 +2294,19 @@ void kdump_sev_callback(void)
 	if (cpu_feature_enabled(X86_FEATURE_SEV_SNP))
 		wbinvd();
 }
+
+void sev_show_status(void)
+{
+	int i;
+
+	pr_info("Status: ");
+	for (i = 0; i < MSR_AMD64_SNP_RESV_BIT; i++) {
+		if (sev_status & BIT_ULL(i)) {
+			if (!sev_status_feat_names[i])
+				continue;
+
+			pr_cont("%s ", sev_status_feat_names[i]);
+		}
+	}
+	pr_cont("\n");
+}
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index d035bce..6f3b3e0 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -14,6 +14,8 @@
 #include <linux/mem_encrypt.h>
 #include <linux/virtio_anchor.h>
 
+#include <asm/sev.h>
+
 /* Override for DMA direct allocation check - ARCH_HAS_FORCE_DMA_UNENCRYPTED */
 bool force_dma_unencrypted(struct device *dev)
 {
@@ -74,6 +76,9 @@ static void print_mem_encrypt_feature_info(void)
 			pr_cont(" SEV-SNP");
 
 		pr_cont("\n");
+
+		sev_show_status();
+
 		break;
 	default:
 		pr_cont("Unknown\n");

