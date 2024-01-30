Return-Path: <linux-kernel+bounces-44940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2399842940
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79AF3285537
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C128B137C41;
	Tue, 30 Jan 2024 16:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LzLH59xf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KZPU6J5C"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E05312F58E;
	Tue, 30 Jan 2024 16:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706631975; cv=none; b=QQFxyHMwgG2aR6EaEvEFzbXWUXX0rHsuDB6gkVWkf4jXDl6t+KVTnjCmX73IS/OBg2POx5vxFE1IZA1BxI9Rc6L5rBSfn1e+hprR/aEV98kB3bvtv29MmgoHoij2enmzQtnlsONBNddZQT3lVhbtHB0HPSZN6ExsHf7jpRr8yrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706631975; c=relaxed/simple;
	bh=W4X4heo67mJNuyVqtEU9pT7jzoEm3kTpVAUFFpAYxMA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jbOQUxouS37JoNgGLtGSVXK1Q+r0u/8ktapDSeR4yIf+EQvTydD5K/yQvACRAULqOld8YV8UwDCnCPacWQBV8onmuOx6hpiYNXT/hJaJrlIr5QfYPErLPfzTyxHqYCxgGpcvm3tj1rR6xe4pGjOXiXzetp6ZqDGpAhIpH5V9wsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LzLH59xf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KZPU6J5C; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Jan 2024 16:26:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706631972;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yd9kwnkTHyD8WsL8BHajy0+0cVpzHZ1ljZ5arZY+HDk=;
	b=LzLH59xfvqZngEWeV7h+N+bzt/4WHsykxS/zZHVRCrt2bs+1RP2SnTUma85ql6y3yBsy5+
	cmzkd0X5wjYdUY+iui/cI2wsOATh9gcSlJ82s7BPVykAB2kEZBTBWnocZNIbTwYi2sdvpK
	j9WLYvtGh4TxugUb8A5SMqKeRMwhfUuyKvZqIpH7lfdHPIY5oPAvxNe383t4Kk0HrTAqNl
	MXVar44ZWGd3tR04Zect6vsl8l9GVIBAxuG0gDcYVzZxdaEUfZNO5ti0aW9aDvjFWUwbql
	b8oJ6T5JtrXyy6QKQg8WhG3DJtFqI0hxDQnY+8ud0UQApYgAZI3MKMi4UeO4uA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706631972;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yd9kwnkTHyD8WsL8BHajy0+0cVpzHZ1ljZ5arZY+HDk=;
	b=KZPU6J5CNo8plkNPBF3LtLc8fvhjJpc9uhIhEfZ5EiBuXsmfmUMTNhM45NK/0SralstXa0
	oyhZ4Zi7JZNW2BBQ==
From: "tip-bot2 for Ashish Kalra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] iommu/amd: Don't rely on external callers to enable
 IOMMU SNP support
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>,
 Ashish Kalra <ashish.kalra@amd.com>, Michael Roth <michael.roth@amd.com>,
 Joerg Roedel <jroedel@suse.de>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240126041126.1927228-4-michael.roth@amd.com>
References: <20240126041126.1927228-4-michael.roth@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170663197123.398.4999236897481839603.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     04d65a9dbb33e20500005e151d720acead78c539
Gitweb:        https://git.kernel.org/tip/04d65a9dbb33e20500005e151d720acead78c539
Author:        Ashish Kalra <ashish.kalra@amd.com>
AuthorDate:    Thu, 25 Jan 2024 22:11:03 -06:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 29 Jan 2024 17:19:28 +01:00

iommu/amd: Don't rely on external callers to enable IOMMU SNP support

Currently, the expectation is that the kernel will call
amd_iommu_snp_enable() to perform various checks and set the
amd_iommu_snp_en flag that the IOMMU uses to adjust its setup routines
to account for additional requirements on hosts where SNP is enabled.

This is somewhat fragile as it relies on this call being done prior to
IOMMU setup. It is more robust to just do this automatically as part of
IOMMU initialization, so rework the code accordingly.

There is still a need to export information about whether or not the
IOMMU is configured in a manner compatible with SNP, so relocate the
existing amd_iommu_snp_en flag so it can be used to convey that
information in place of the return code that was previously provided by
calls to amd_iommu_snp_enable().

While here, also adjust the kernel messages related to IOMMU SNP
enablement for consistency/grammar/clarity.

Suggested-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
Co-developed-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Joerg Roedel <jroedel@suse.de>
Link: https://lore.kernel.org/r/20240126041126.1927228-4-michael.roth@amd.com
---
 arch/x86/include/asm/iommu.h  |  1 +-
 drivers/iommu/amd/amd_iommu.h |  1 +-
 drivers/iommu/amd/init.c      | 69 +++++++++++++++-------------------
 include/linux/amd-iommu.h     |  4 +--
 4 files changed, 32 insertions(+), 43 deletions(-)

diff --git a/arch/x86/include/asm/iommu.h b/arch/x86/include/asm/iommu.h
index 2fd52b6..3be2451 100644
--- a/arch/x86/include/asm/iommu.h
+++ b/arch/x86/include/asm/iommu.h
@@ -10,6 +10,7 @@ extern int force_iommu, no_iommu;
 extern int iommu_detected;
 extern int iommu_merge;
 extern int panic_on_overflow;
+extern bool amd_iommu_snp_en;
 
 #ifdef CONFIG_SWIOTLB
 extern bool x86_swiotlb_enable;
diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 8b3601f..c970eae 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -164,5 +164,4 @@ void amd_iommu_domain_set_pgtable(struct protection_domain *domain,
 				  u64 *root, int mode);
 struct dev_table_entry *get_dev_table(struct amd_iommu *iommu);
 
-extern bool amd_iommu_snp_en;
 #endif
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index c83bd0c..3a4eeb2 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3221,6 +3221,36 @@ out:
 	return true;
 }
 
+static void iommu_snp_enable(void)
+{
+#ifdef CONFIG_KVM_AMD_SEV
+	if (!cpu_feature_enabled(X86_FEATURE_SEV_SNP))
+		return;
+	/*
+	 * The SNP support requires that IOMMU must be enabled, and is
+	 * not configured in the passthrough mode.
+	 */
+	if (no_iommu || iommu_default_passthrough()) {
+		pr_err("SNP: IOMMU disabled or configured in passthrough mode, SNP cannot be supported.\n");
+		return;
+	}
+
+	amd_iommu_snp_en = check_feature(FEATURE_SNP);
+	if (!amd_iommu_snp_en) {
+		pr_err("SNP: IOMMU SNP feature not enabled, SNP cannot be supported.\n");
+		return;
+	}
+
+	pr_info("IOMMU SNP support enabled.\n");
+
+	/* Enforce IOMMU v1 pagetable when SNP is enabled. */
+	if (amd_iommu_pgtable != AMD_IOMMU_V1) {
+		pr_warn("Forcing use of AMD IOMMU v1 page table due to SNP.\n");
+		amd_iommu_pgtable = AMD_IOMMU_V1;
+	}
+#endif
+}
+
 /****************************************************************************
  *
  * AMD IOMMU Initialization State Machine
@@ -3256,6 +3286,7 @@ static int __init state_next(void)
 		break;
 	case IOMMU_ENABLED:
 		register_syscore_ops(&amd_iommu_syscore_ops);
+		iommu_snp_enable();
 		ret = amd_iommu_init_pci();
 		init_state = ret ? IOMMU_INIT_ERROR : IOMMU_PCI_INIT;
 		break;
@@ -3766,41 +3797,3 @@ int amd_iommu_pc_set_reg(struct amd_iommu *iommu, u8 bank, u8 cntr, u8 fxn, u64 
 
 	return iommu_pc_get_set_reg(iommu, bank, cntr, fxn, value, true);
 }
-
-#ifdef CONFIG_AMD_MEM_ENCRYPT
-int amd_iommu_snp_enable(void)
-{
-	/*
-	 * The SNP support requires that IOMMU must be enabled, and is
-	 * not configured in the passthrough mode.
-	 */
-	if (no_iommu || iommu_default_passthrough()) {
-		pr_err("SNP: IOMMU is disabled or configured in passthrough mode, SNP cannot be supported");
-		return -EINVAL;
-	}
-
-	/*
-	 * Prevent enabling SNP after IOMMU_ENABLED state because this process
-	 * affect how IOMMU driver sets up data structures and configures
-	 * IOMMU hardware.
-	 */
-	if (init_state > IOMMU_ENABLED) {
-		pr_err("SNP: Too late to enable SNP for IOMMU.\n");
-		return -EINVAL;
-	}
-
-	amd_iommu_snp_en = check_feature(FEATURE_SNP);
-	if (!amd_iommu_snp_en)
-		return -EINVAL;
-
-	pr_info("SNP enabled\n");
-
-	/* Enforce IOMMU v1 pagetable when SNP is enabled. */
-	if (amd_iommu_pgtable != AMD_IOMMU_V1) {
-		pr_warn("Force to using AMD IOMMU v1 page table due to SNP\n");
-		amd_iommu_pgtable = AMD_IOMMU_V1;
-	}
-
-	return 0;
-}
-#endif
diff --git a/include/linux/amd-iommu.h b/include/linux/amd-iommu.h
index dc7ed2f..7365be0 100644
--- a/include/linux/amd-iommu.h
+++ b/include/linux/amd-iommu.h
@@ -85,8 +85,4 @@ int amd_iommu_pc_get_reg(struct amd_iommu *iommu, u8 bank, u8 cntr, u8 fxn,
 		u64 *value);
 struct amd_iommu *get_amd_iommu(unsigned int idx);
 
-#ifdef CONFIG_AMD_MEM_ENCRYPT
-int amd_iommu_snp_enable(void);
-#endif
-
 #endif /* _ASM_X86_AMD_IOMMU_H */

