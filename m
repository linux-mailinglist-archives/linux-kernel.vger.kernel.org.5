Return-Path: <linux-kernel+bounces-44937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC0084293B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 067A2286329
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD89312FF69;
	Tue, 30 Jan 2024 16:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="A1cSkPbf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="avqzJu1O"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669B512CDB0;
	Tue, 30 Jan 2024 16:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706631973; cv=none; b=hGiu1GZv10fY8dRJUflnyHkAzfzmeoYORDWUncIpTYAQVrS+MhBC0N7gAKs6Afnff3rE3xbhXHcIuuxdXhbFWiUMbM1EydyYns7Q79XFlNOHBawwSq3PMSg5kZbGTyb4D2LmnWHKYoIjV9fm64PIep5H27Jkl2yPWMugAQpAZJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706631973; c=relaxed/simple;
	bh=vFe5JVUm77KdHRpyYdzV+lNo2hjIlqeiOjaKMoo88y0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Q9+jvnOD9dkp2L+aJO2B5o0b+e/lFSmZaRGX3dskDkYLZimXDLWvZL3PYVkmmeMEo2wZAwdqMqrXqH/SfUyc6oOuWnhsEu9rNMsloJzg382k+7rU+mUePrEHDs3RF/3IfJ9kwxFNjSGydFOw9H3g1QfYG0DEZJL3a7SqJM40qyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=A1cSkPbf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=avqzJu1O; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Jan 2024 16:26:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706631969;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SCTo04sk1wsU4KOT3MJcifNoYqtBHsWzx0mOZ/gkacU=;
	b=A1cSkPbfkdR0OhXTbVRSLxok6wvLYleR9+ODWlfpsYlaFqMxYNUus4NrGeFyUcrnQJg38o
	jr4QbttB5CrLU2OsqkgFbL9aeUqmMXCHdA0NjHF9z2sCvUwdGoJZ0V0f7Yu98W/q064ojs
	f3k02skywzcbCuCaZMwxzspMi6dI3PwS/8CVEnKABVdrayFt/9YWwtqszCrCMP+kJ/C1k0
	NYN39dbyyZjbrX1Xp2n9h6FPpBz0RSnpbjPKl4oMmylckn75DqvHBJEswBBJunWeA0PfR1
	O//nTmczadOg3c0HFzqmfDfZtU4AEDuccpgYz63td/rWamFICAxSMzfPPm4GSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706631969;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SCTo04sk1wsU4KOT3MJcifNoYqtBHsWzx0mOZ/gkacU=;
	b=avqzJu1OUDXpfksXv/gI0qjoRMDbXDvfvij+APc8ngYMDfmmvvar/g2Yg8Zf1SzchfbDZa
	RwXIYNXNLm0RuKDA==
From: "tip-bot2 for Brijesh Singh" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/fault: Add helper for dumping RMP entries
Cc: Brijesh Singh <brijesh.singh@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
 Michael Roth <michael.roth@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240126041126.1927228-8-michael.roth@amd.com>
References: <20240126041126.1927228-8-michael.roth@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170663196883.398.18077552190870723071.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     1f568d36361b4891696280b719ca4b142db872ba
Gitweb:        https://git.kernel.org/tip/1f568d36361b4891696280b719ca4b142db872ba
Author:        Brijesh Singh <brijesh.singh@amd.com>
AuthorDate:    Thu, 25 Jan 2024 22:11:07 -06:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 29 Jan 2024 17:26:30 +01:00

x86/fault: Add helper for dumping RMP entries

This information will be useful for debugging things like page faults
due to RMP access violations and RMPUPDATE failures.

  [ mdr: move helper to standalone patch, rework dump logic as suggested
    by Boris. ]

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240126041126.1927228-8-michael.roth@amd.com
---
 arch/x86/include/asm/sev.h |   2 +-
 arch/x86/virt/svm/sev.c    |  99 ++++++++++++++++++++++++++++++++----
 2 files changed, 91 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 01ce61b..2c53e3d 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -247,9 +247,11 @@ static inline u64 sev_get_status(void) { return 0; }
 #ifdef CONFIG_KVM_AMD_SEV
 bool snp_probe_rmptable_info(void);
 int snp_lookup_rmpentry(u64 pfn, bool *assigned, int *level);
+void snp_dump_hva_rmpentry(unsigned long address);
 #else
 static inline bool snp_probe_rmptable_info(void) { return false; }
 static inline int snp_lookup_rmpentry(u64 pfn, bool *assigned, int *level) { return -ENODEV; }
+static inline void snp_dump_hva_rmpentry(unsigned long address) {}
 #endif
 
 #endif
diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
index 7669b2f..c74266e 100644
--- a/arch/x86/virt/svm/sev.c
+++ b/arch/x86/virt/svm/sev.c
@@ -35,16 +35,21 @@
  * Family 19h Model 01h, Rev B1 processor.
  */
 struct rmpentry {
-	u64	assigned	: 1,
-		pagesize	: 1,
-		immutable	: 1,
-		rsvd1		: 9,
-		gpa		: 39,
-		asid		: 10,
-		vmsa		: 1,
-		validated	: 1,
-		rsvd2		: 1;
-	u64 rsvd3;
+	union {
+		struct {
+			u64 assigned	: 1,
+			    pagesize	: 1,
+			    immutable	: 1,
+			    rsvd1	: 9,
+			    gpa		: 39,
+			    asid	: 10,
+			    vmsa	: 1,
+			    validated	: 1,
+			    rsvd2	: 1;
+		};
+		u64 lo;
+	};
+	u64 hi;
 } __packed;
 
 /*
@@ -263,3 +268,77 @@ int snp_lookup_rmpentry(u64 pfn, bool *assigned, int *level)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(snp_lookup_rmpentry);
+
+/*
+ * Dump the raw RMP entry for a particular PFN. These bits are documented in the
+ * PPR for a particular CPU model and provide useful information about how a
+ * particular PFN is being utilized by the kernel/firmware at the time certain
+ * unexpected events occur, such as RMP faults.
+ */
+static void dump_rmpentry(u64 pfn)
+{
+	u64 pfn_i, pfn_end;
+	struct rmpentry *e;
+	int level;
+
+	e = __snp_lookup_rmpentry(pfn, &level);
+	if (IS_ERR(e)) {
+		pr_err("Failed to read RMP entry for PFN 0x%llx, error %ld\n",
+		       pfn, PTR_ERR(e));
+		return;
+	}
+
+	if (e->assigned) {
+		pr_info("PFN 0x%llx, RMP entry: [0x%016llx - 0x%016llx]\n",
+			pfn, e->lo, e->hi);
+		return;
+	}
+
+	/*
+	 * If the RMP entry for a particular PFN is not in an assigned state,
+	 * then it is sometimes useful to get an idea of whether or not any RMP
+	 * entries for other PFNs within the same 2MB region are assigned, since
+	 * those too can affect the ability to access a particular PFN in
+	 * certain situations, such as when the PFN is being accessed via a 2MB
+	 * mapping in the host page table.
+	 */
+	pfn_i = ALIGN_DOWN(pfn, PTRS_PER_PMD);
+	pfn_end = pfn_i + PTRS_PER_PMD;
+
+	pr_info("PFN 0x%llx unassigned, dumping non-zero entries in 2M PFN region: [0x%llx - 0x%llx]\n",
+		pfn, pfn_i, pfn_end);
+
+	while (pfn_i < pfn_end) {
+		e = __snp_lookup_rmpentry(pfn_i, &level);
+		if (IS_ERR(e)) {
+			pr_err("Error %ld reading RMP entry for PFN 0x%llx\n",
+			       PTR_ERR(e), pfn_i);
+			pfn_i++;
+			continue;
+		}
+
+		if (e->lo || e->hi)
+			pr_info("PFN: 0x%llx, [0x%016llx - 0x%016llx]\n", pfn_i, e->lo, e->hi);
+		pfn_i++;
+	}
+}
+
+void snp_dump_hva_rmpentry(unsigned long hva)
+{
+	unsigned long paddr;
+	unsigned int level;
+	pgd_t *pgd;
+	pte_t *pte;
+
+	pgd = __va(read_cr3_pa());
+	pgd += pgd_index(hva);
+	pte = lookup_address_in_pgd(pgd, hva, &level);
+
+	if (!pte) {
+		pr_err("Can't dump RMP entry for HVA %lx: no PTE/PFN found\n", hva);
+		return;
+	}
+
+	paddr = PFN_PHYS(pte_pfn(*pte)) | (hva & ~page_level_mask(level));
+	dump_rmpentry(PHYS_PFN(paddr));
+}

