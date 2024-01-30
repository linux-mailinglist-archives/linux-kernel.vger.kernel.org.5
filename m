Return-Path: <linux-kernel+bounces-44934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 276E0842936
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C0381C25E66
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0433712DDBC;
	Tue, 30 Jan 2024 16:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r8kfUcxk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BR3ZRU4n"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0DF12837D;
	Tue, 30 Jan 2024 16:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706631971; cv=none; b=av+fyisCugo3ECENdQc/bdmEMHBiDa+U/edI4C55PSAiPaA1xyDbgR7JYpTXMnoQjHPuM+1gHIrPxE+uU/1rK0PSOi1CXMTiifaPWGzJMdc6oRPoK5H1vENTc/07YYVwkQueaXXItGbevvFn6kVUHrpneLVfzHVF9xzbwgEnSbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706631971; c=relaxed/simple;
	bh=sLy4E6DKd8D7+rCwgkqf4oLhWPS4ATr/5WPLXv65GBs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=vCmaOe/ci5DT540zYPSPuC85T8r+D/7xtyXXA69tpSouQGSBvQaeyEjJKeTT9BvfOyz/mRLnjrqP+IKXvMPJBH83rg8d7LbbdDSRVDpluz43QZSN02kxClWEU/j9PjD6yRp0v7XZJZVLcsQSdruO2Rfs+8+lfYLLBJIIin9Hwk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r8kfUcxk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BR3ZRU4n; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Jan 2024 16:26:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706631967;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i9lKnbY6+TNZ8t5Y+8dClk+vxZwSottd+o6PRmwr4j8=;
	b=r8kfUcxkVcjdI1aHH7dUMGyYU9L+QhMDF4VfGrIip9ueIAAaNWmJwsZYs8Fw/JmyXeC6kK
	pAZSF76pSFUDAL2knGaSW0ulEVijsLnR6AoTCYuY8phYZhFwOecKhaWWMn+I4ytwmGIkI9
	yH4sFuiszcJ68tuhwJ2Qbic8UoDxKYvlkX54UN3xYqN54dCAkVtQ6F6phm3jQ117T5XV4w
	XocrUKuQSW8+QL7pW8fZKNqRuwDhmR1s1YSrg5lJ221lRhjOXrRj+9o56j37OBwA4y7s7m
	qJw8VTQjQfxzn96zTzp8bkYE/Hu+UeBbC9Rr24gyEV9C9v9ZkbQfXNf9Tk3UOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706631967;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i9lKnbY6+TNZ8t5Y+8dClk+vxZwSottd+o6PRmwr4j8=;
	b=BR3ZRU4nRMWZL9TPO0KC7I49uCBM1Lxeb0zOFj+a7mdOOYfwfg+tx4nBiZKKsjEpDV8gin
	B+WFFZYGVvdNk4Dw==
From: "tip-bot2 for Brijesh Singh" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/sev: Add helper functions for RMPUPDATE and PSMASH
 instruction
Cc: Brijesh Singh <brijesh.singh@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
 Michael Roth <michael.roth@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Liam Merwick <liam.merwick@oracle.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240126041126.1927228-11-michael.roth@amd.com>
References: <20240126041126.1927228-11-michael.roth@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170663196694.398.14714826975788265209.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     2c35819ee00b8893626914b3384cdef2afea7dbd
Gitweb:        https://git.kernel.org/tip/2c35819ee00b8893626914b3384cdef2afea7dbd
Author:        Brijesh Singh <brijesh.singh@amd.com>
AuthorDate:    Thu, 25 Jan 2024 22:11:10 -06:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 29 Jan 2024 20:30:59 +01:00

x86/sev: Add helper functions for RMPUPDATE and PSMASH instruction

The RMPUPDATE instruction updates the access restrictions for a page via
its corresponding entry in the RMP Table. The hypervisor will use the
instruction to enforce various access restrictions on pages used for
confidential guests and other specialized functionality. See APM3 for
details on the instruction operations.

The PSMASH instruction expands a 2MB RMP entry in the RMP table into a
corresponding set of contiguous 4KB RMP entries while retaining the
state of the validated bit from the original 2MB RMP entry. The
hypervisor will use this instruction in cases where it needs to re-map a
page as 4K rather than 2MB in a guest's nested page table.

Add helpers to make use of these instructions.

  [ mdr: add RMPUPDATE retry logic for transient FAIL_OVERLAP errors. ]

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
Link: https://lore.kernel.org/r/20240126041126.1927228-11-michael.roth@amd.com
---
 arch/x86/include/asm/sev.h | 23 +++++++++-
 arch/x86/virt/svm/sev.c    | 92 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 115 insertions(+)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 2c53e3d..57fd95a 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -87,10 +87,23 @@ extern bool handle_vc_boot_ghcb(struct pt_regs *regs);
 /* Software defined (when rFlags.CF = 1) */
 #define PVALIDATE_FAIL_NOUPDATE		255
 
+/* RMUPDATE detected 4K page and 2MB page overlap. */
+#define RMPUPDATE_FAIL_OVERLAP		4
+
 /* RMP page size */
 #define RMP_PG_SIZE_4K			0
 #define RMP_PG_SIZE_2M			1
 #define RMP_TO_PG_LEVEL(level)		(((level) == RMP_PG_SIZE_4K) ? PG_LEVEL_4K : PG_LEVEL_2M)
+#define PG_LEVEL_TO_RMP(level)		(((level) == PG_LEVEL_4K) ? RMP_PG_SIZE_4K : RMP_PG_SIZE_2M)
+
+struct rmp_state {
+	u64 gpa;
+	u8 assigned;
+	u8 pagesize;
+	u8 immutable;
+	u8 rsvd;
+	u32 asid;
+} __packed;
 
 #define RMPADJUST_VMSA_PAGE_BIT		BIT(16)
 
@@ -248,10 +261,20 @@ static inline u64 sev_get_status(void) { return 0; }
 bool snp_probe_rmptable_info(void);
 int snp_lookup_rmpentry(u64 pfn, bool *assigned, int *level);
 void snp_dump_hva_rmpentry(unsigned long address);
+int psmash(u64 pfn);
+int rmp_make_private(u64 pfn, u64 gpa, enum pg_level level, u32 asid, bool immutable);
+int rmp_make_shared(u64 pfn, enum pg_level level);
 #else
 static inline bool snp_probe_rmptable_info(void) { return false; }
 static inline int snp_lookup_rmpentry(u64 pfn, bool *assigned, int *level) { return -ENODEV; }
 static inline void snp_dump_hva_rmpentry(unsigned long address) {}
+static inline int psmash(u64 pfn) { return -ENODEV; }
+static inline int rmp_make_private(u64 pfn, u64 gpa, enum pg_level level, u32 asid,
+				   bool immutable)
+{
+	return -ENODEV;
+}
+static inline int rmp_make_shared(u64 pfn, enum pg_level level) { return -ENODEV; }
 #endif
 
 #endif
diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
index c74266e..dc18335 100644
--- a/arch/x86/virt/svm/sev.c
+++ b/arch/x86/virt/svm/sev.c
@@ -342,3 +342,95 @@ void snp_dump_hva_rmpentry(unsigned long hva)
 	paddr = PFN_PHYS(pte_pfn(*pte)) | (hva & ~page_level_mask(level));
 	dump_rmpentry(PHYS_PFN(paddr));
 }
+
+/*
+ * PSMASH a 2MB aligned page into 4K pages in the RMP table while preserving the
+ * Validated bit.
+ */
+int psmash(u64 pfn)
+{
+	unsigned long paddr = pfn << PAGE_SHIFT;
+	int ret;
+
+	if (!cpu_feature_enabled(X86_FEATURE_SEV_SNP))
+		return -ENODEV;
+
+	if (!pfn_valid(pfn))
+		return -EINVAL;
+
+	/* Binutils version 2.36 supports the PSMASH mnemonic. */
+	asm volatile(".byte 0xF3, 0x0F, 0x01, 0xFF"
+		      : "=a" (ret)
+		      : "a" (paddr)
+		      : "memory", "cc");
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(psmash);
+
+/*
+ * It is expected that those operations are seldom enough so that no mutual
+ * exclusion of updaters is needed and thus the overlap error condition below
+ * should happen very rarely and would get resolved relatively quickly by
+ * the firmware.
+ *
+ * If not, one could consider introducing a mutex or so here to sync concurrent
+ * RMP updates and thus diminish the amount of cases where firmware needs to
+ * lock 2M ranges to protect against concurrent updates.
+ *
+ * The optimal solution would be range locking to avoid locking disjoint
+ * regions unnecessarily but there's no support for that yet.
+ */
+static int rmpupdate(u64 pfn, struct rmp_state *state)
+{
+	unsigned long paddr = pfn << PAGE_SHIFT;
+	int ret;
+
+	if (!cpu_feature_enabled(X86_FEATURE_SEV_SNP))
+		return -ENODEV;
+
+	do {
+		/* Binutils version 2.36 supports the RMPUPDATE mnemonic. */
+		asm volatile(".byte 0xF2, 0x0F, 0x01, 0xFE"
+			     : "=a" (ret)
+			     : "a" (paddr), "c" ((unsigned long)state)
+			     : "memory", "cc");
+	} while (ret == RMPUPDATE_FAIL_OVERLAP);
+
+	if (ret) {
+		pr_err("RMPUPDATE failed for PFN %llx, ret: %d\n", pfn, ret);
+		dump_rmpentry(pfn);
+		dump_stack();
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+/* Transition a page to guest-owned/private state in the RMP table. */
+int rmp_make_private(u64 pfn, u64 gpa, enum pg_level level, u32 asid, bool immutable)
+{
+	struct rmp_state state;
+
+	memset(&state, 0, sizeof(state));
+	state.assigned = 1;
+	state.asid = asid;
+	state.immutable = immutable;
+	state.gpa = gpa;
+	state.pagesize = PG_LEVEL_TO_RMP(level);
+
+	return rmpupdate(pfn, &state);
+}
+EXPORT_SYMBOL_GPL(rmp_make_private);
+
+/* Transition a page to hypervisor-owned/shared state in the RMP table. */
+int rmp_make_shared(u64 pfn, enum pg_level level)
+{
+	struct rmp_state state;
+
+	memset(&state, 0, sizeof(state));
+	state.pagesize = PG_LEVEL_TO_RMP(level);
+
+	return rmpupdate(pfn, &state);
+}
+EXPORT_SYMBOL_GPL(rmp_make_shared);

