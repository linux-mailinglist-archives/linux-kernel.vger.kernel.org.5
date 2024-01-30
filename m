Return-Path: <linux-kernel+bounces-44925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D45842920
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDAA11C25CCD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EEF6128370;
	Tue, 30 Jan 2024 16:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="09v267q4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lIVzCSx6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AF8129A8D;
	Tue, 30 Jan 2024 16:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706631964; cv=none; b=Kw/sgH2zRwF/ATHqe/25PsmkNJOi1l1mxueM51EpHxBcjgCVkRI8DRHAPNtG39MjO+pG6+Hq1vk9H2wBSDp7EFThEp48vD/7wufLeHsTOiNK+Tr1C9nT9TzSaiiSMquaIlwlXFzKQ1U0f6ZnTLxxq5X0QJ+bAqWWesdszU6WfvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706631964; c=relaxed/simple;
	bh=Os4ryinEinc50/BtViFYrMICnC5xmSK4lS7Ps0j0nrI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=kD7y9j2fXjp/mH/eZ1qRg+XMt+sV9Wl9fbCHp7eK1Kp0SLzD6f0E8pjmam2hfhg1gpV46u8ZvIP1HEl99ZtLTxS/230YZqI+MFkRaF9/MwvvObaQKYQqk/NkYQklISkxGJ509mJ4QMshlT41yBHj90a6nK0v2aM8aySiZLxco44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=09v267q4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lIVzCSx6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Jan 2024 16:26:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706631960;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HDUkZmo2Oxvbd781H9C01N70Gewtk18YVxhikUkhYXw=;
	b=09v267q4ezm6gQeW7sWSDYpIHRvUb7occuzMtRkRDXTCYDH67C3A+7KZnCAVp5lrW9ONqa
	GMkq51TqqPnEi/1A7JlToKbylNc4goBzlsIXHhRPzlAqfTYtwal9dDlcAShRykX8MtQt4d
	0V8j23v1n4P62Jm80ei5Ey8YCfFokR5ZKJ9amipe67nK8Y9jb+myGtoyCB93jkr6/eCdAT
	yT4xrTUdptxBlxQn0Zym6cnsTjvI1XRAnEBiB4QYHJGvWmtGcRI7/7iyUn/Z1ukQIalO0o
	+UajVSD6+uwoo6ijkttnkP9SBiO9+ugNX7pKsVSxbd2gHViLqciryKlz4VlefQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706631960;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HDUkZmo2Oxvbd781H9C01N70Gewtk18YVxhikUkhYXw=;
	b=lIVzCSx6SvYQbgQOL3TAzWbmJ7xtjk8lKzyKRefSrgCVhAa+PalrOMgydvHJiYDh3z164k
	PxOoz4ospHN+ZlDw==
From: "tip-bot2 for Ashish Kalra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] iommu/amd: Clean up RMP entries for IOMMU pages during
 SNP shutdown
Cc: Ashish Kalra <ashish.kalra@amd.com>, Michael Roth <michael.roth@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240126041126.1927228-20-michael.roth@amd.com>
References: <20240126041126.1927228-20-michael.roth@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170663196010.398.12784351404486075245.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     f366a8dac1b8fef28a470d4e67b9843ebb8e2a1f
Gitweb:        https://git.kernel.org/tip/f366a8dac1b8fef28a470d4e67b9843ebb8e2a1f
Author:        Ashish Kalra <ashish.kalra@amd.com>
AuthorDate:    Thu, 25 Jan 2024 22:11:19 -06:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 29 Jan 2024 20:34:18 +01:00

iommu/amd: Clean up RMP entries for IOMMU pages during SNP shutdown

Add a new IOMMU API interface amd_iommu_snp_disable() to transition
IOMMU pages to Hypervisor state from Reclaim state after SNP_SHUTDOWN_EX
command. Invoke this API from the CCP driver after SNP_SHUTDOWN_EX
command.

Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240126041126.1927228-20-michael.roth@amd.com
---
 drivers/crypto/ccp/sev-dev.c | 20 +++++++++-
 drivers/iommu/amd/init.c     | 79 +++++++++++++++++++++++++++++++++++-
 include/linux/amd-iommu.h    |  6 +++-
 3 files changed, 105 insertions(+)

diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index a70f8b1..605c6bf 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -26,6 +26,7 @@
 #include <linux/fs.h>
 #include <linux/fs_struct.h>
 #include <linux/psp.h>
+#include <linux/amd-iommu.h>
 
 #include <asm/smp.h>
 #include <asm/cacheflush.h>
@@ -1655,6 +1656,25 @@ static int __sev_snp_shutdown_locked(int *error)
 		return ret;
 	}
 
+	/*
+	 * SNP_SHUTDOWN_EX with IOMMU_SNP_SHUTDOWN set to 1 disables SNP
+	 * enforcement by the IOMMU and also transitions all pages
+	 * associated with the IOMMU to the Reclaim state.
+	 * Firmware was transitioning the IOMMU pages to Hypervisor state
+	 * before version 1.53. But, accounting for the number of assigned
+	 * 4kB pages in a 2M page was done incorrectly by not transitioning
+	 * to the Reclaim state. This resulted in RMP #PF when later accessing
+	 * the 2M page containing those pages during kexec boot. Hence, the
+	 * firmware now transitions these pages to Reclaim state and hypervisor
+	 * needs to transition these pages to shared state. SNP Firmware
+	 * version 1.53 and above are needed for kexec boot.
+	 */
+	ret = amd_iommu_snp_disable();
+	if (ret) {
+		dev_err(sev->dev, "SNP IOMMU shutdown failed\n");
+		return ret;
+	}
+
 	sev->snp_initialized = false;
 	dev_dbg(sev->dev, "SEV-SNP firmware shutdown\n");
 
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 3a4eeb2..88bb08a 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -30,6 +30,7 @@
 #include <asm/io_apic.h>
 #include <asm/irq_remapping.h>
 #include <asm/set_memory.h>
+#include <asm/sev.h>
 
 #include <linux/crash_dump.h>
 
@@ -3797,3 +3798,81 @@ int amd_iommu_pc_set_reg(struct amd_iommu *iommu, u8 bank, u8 cntr, u8 fxn, u64 
 
 	return iommu_pc_get_set_reg(iommu, bank, cntr, fxn, value, true);
 }
+
+#ifdef CONFIG_KVM_AMD_SEV
+static int iommu_page_make_shared(void *page)
+{
+	unsigned long paddr, pfn;
+
+	paddr = iommu_virt_to_phys(page);
+	/* Cbit maybe set in the paddr */
+	pfn = __sme_clr(paddr) >> PAGE_SHIFT;
+
+	if (!(pfn % PTRS_PER_PMD)) {
+		int ret, level;
+		bool assigned;
+
+		ret = snp_lookup_rmpentry(pfn, &assigned, &level);
+		if (ret)
+			pr_warn("IOMMU PFN %lx RMP lookup failed, ret %d\n",
+				pfn, ret);
+
+		if (!assigned)
+			pr_warn("IOMMU PFN %lx not assigned in RMP table\n",
+				pfn);
+
+		if (level > PG_LEVEL_4K) {
+			ret = psmash(pfn);
+			if (ret) {
+				pr_warn("IOMMU PFN %lx had a huge RMP entry, but attempted psmash failed, ret: %d, level: %d\n",
+					pfn, ret, level);
+			}
+		}
+	}
+
+	return rmp_make_shared(pfn, PG_LEVEL_4K);
+}
+
+static int iommu_make_shared(void *va, size_t size)
+{
+	void *page;
+	int ret;
+
+	if (!va)
+		return 0;
+
+	for (page = va; page < (va + size); page += PAGE_SIZE) {
+		ret = iommu_page_make_shared(page);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+int amd_iommu_snp_disable(void)
+{
+	struct amd_iommu *iommu;
+	int ret;
+
+	if (!amd_iommu_snp_en)
+		return 0;
+
+	for_each_iommu(iommu) {
+		ret = iommu_make_shared(iommu->evt_buf, EVT_BUFFER_SIZE);
+		if (ret)
+			return ret;
+
+		ret = iommu_make_shared(iommu->ppr_log, PPR_LOG_SIZE);
+		if (ret)
+			return ret;
+
+		ret = iommu_make_shared((void *)iommu->cmd_sem, PAGE_SIZE);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(amd_iommu_snp_disable);
+#endif
diff --git a/include/linux/amd-iommu.h b/include/linux/amd-iommu.h
index 7365be0..2b90c48 100644
--- a/include/linux/amd-iommu.h
+++ b/include/linux/amd-iommu.h
@@ -85,4 +85,10 @@ int amd_iommu_pc_get_reg(struct amd_iommu *iommu, u8 bank, u8 cntr, u8 fxn,
 		u64 *value);
 struct amd_iommu *get_amd_iommu(unsigned int idx);
 
+#ifdef CONFIG_KVM_AMD_SEV
+int amd_iommu_snp_disable(void);
+#else
+static inline int amd_iommu_snp_disable(void) { return 0; }
+#endif
+
 #endif /* _ASM_X86_AMD_IOMMU_H */

