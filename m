Return-Path: <linux-kernel+bounces-44938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E75284293C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 370B9286A93
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2217C12FF73;
	Tue, 30 Jan 2024 16:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JvgwR4Vd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="59+OYcQx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E353012DD84;
	Tue, 30 Jan 2024 16:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706631974; cv=none; b=TmvEKXLEj47YDN13K/RDM4eMDX2ULrsVmHIpnbN+5xnwtYIawCiGxKaKEOcQ0O68YEip2wtwR2Rz1EOiBx5mp9ARAEV0JQ1VWy8QmjLLbGFZi9kX1L4fLaFZaai8XxJ1fqAMQadhAyX6QjpwtPX0/slPwaZNeuj7KMftUBO0z2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706631974; c=relaxed/simple;
	bh=sHlK62MJQdqGfr6C7ce5gjIIwvEc5ioROSf0RK4n9dI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=EAji+WHZF3iMC/MltCkJkTbYxVwKBwvz+dIfB59cSv6/cBIHnc1kz0XUFD8aOHXcV1f5J/eQpkdbvC8ungRQJWE4ZiAWzVL4noqWqG2WE0uG74mNOMzVemSfesTh7ONZv7B6p849aIXamgcCoSdUQUPhLY2YXnnKacAJiwV0VMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JvgwR4Vd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=59+OYcQx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Jan 2024 16:26:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706631970;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mN/9mMrC8aS8RksSSZxiGIgbyqilv7flgUmnop5VOPI=;
	b=JvgwR4VdgODmXyfB0V/sD/OxQecPdRVRK2gFil7htP0CIyCPj3QyDCCVLMJktKbScec23P
	rq+RPc0VXRWp8Xxm+uAEbPJzllRxeaFOsIBfWfk71ZLxuny9V32zw5VhObg5AkKQ1cM5/H
	kfY0MgeL4wWNdEVKDnMVG9MxE2KfECdpE4EgydWLc5NksAwic6sxrUBWIvE8NRYzH7yjoA
	I8zUM4ugdRoIBn/KDRLS52vuyNaLb5T3b38cYRHGbALqHn8CMrJxekajAEfUZVSTm6fBaD
	JFajAtkHMrS+77mMhgqPM0DgI+7S1dEIOTouQ5Z0t1HuK0qekZHF9S/nxEf/oA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706631970;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mN/9mMrC8aS8RksSSZxiGIgbyqilv7flgUmnop5VOPI=;
	b=59+OYcQx9iuWjQ/d+RWCQskccGOO5ZLa4DLMtZaRihVsD0MiBYVLrF8WlzAu4CTVGQ98Mh
	ftoHG68S0RNTD1AA==
From: "tip-bot2 for Brijesh Singh" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/sev: Add RMP entry lookup helpers
Cc: Brijesh Singh <brijesh.singh@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
 Michael Roth <michael.roth@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240126041126.1927228-7-michael.roth@amd.com>
References: <20240126041126.1927228-7-michael.roth@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170663196942.398.1001821466269981082.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     94b36bc244bb134ec616dd3f2d37343cd8c1be54
Gitweb:        https://git.kernel.org/tip/94b36bc244bb134ec616dd3f2d37343cd8c1be54
Author:        Brijesh Singh <brijesh.singh@amd.com>
AuthorDate:    Thu, 25 Jan 2024 22:11:06 -06:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 29 Jan 2024 17:25:55 +01:00

x86/sev: Add RMP entry lookup helpers

Add a helper that can be used to access information contained in the RMP
entry corresponding to a particular PFN. This will be needed to make
decisions on how to handle setting up mappings in the NPT in response to
guest page-faults and handling things like cleaning up pages and setting
them back to the default hypervisor-owned state when they are no longer
being used for private data.

  [ mdr: separate 'assigned' indicator from return code, and simplify
    function signatures for various helpers. ]

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Co-developed-by: Ashish Kalra <ashish.kalra@amd.com>
Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240126041126.1927228-7-michael.roth@amd.com
---
 arch/x86/include/asm/sev.h |  3 ++-
 arch/x86/virt/svm/sev.c    | 49 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 52 insertions(+)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 1f59d8b..01ce61b 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -90,6 +90,7 @@ extern bool handle_vc_boot_ghcb(struct pt_regs *regs);
 /* RMP page size */
 #define RMP_PG_SIZE_4K			0
 #define RMP_PG_SIZE_2M			1
+#define RMP_TO_PG_LEVEL(level)		(((level) == RMP_PG_SIZE_4K) ? PG_LEVEL_4K : PG_LEVEL_2M)
 
 #define RMPADJUST_VMSA_PAGE_BIT		BIT(16)
 
@@ -245,8 +246,10 @@ static inline u64 sev_get_status(void) { return 0; }
 
 #ifdef CONFIG_KVM_AMD_SEV
 bool snp_probe_rmptable_info(void);
+int snp_lookup_rmpentry(u64 pfn, bool *assigned, int *level);
 #else
 static inline bool snp_probe_rmptable_info(void) { return false; }
+static inline int snp_lookup_rmpentry(u64 pfn, bool *assigned, int *level) { return -ENODEV; }
 #endif
 
 #endif
diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
index 575a9ff..7669b2f 100644
--- a/arch/x86/virt/svm/sev.c
+++ b/arch/x86/virt/svm/sev.c
@@ -53,6 +53,9 @@ struct rmpentry {
  */
 #define RMPTABLE_CPU_BOOKKEEPING_SZ	0x4000
 
+/* Mask to apply to a PFN to get the first PFN of a 2MB page */
+#define PFN_PMD_MASK	GENMASK_ULL(63, PMD_SHIFT - PAGE_SHIFT)
+
 static u64 probed_rmp_base, probed_rmp_size;
 static struct rmpentry *rmptable __ro_after_init;
 static u64 rmptable_max_pfn __ro_after_init;
@@ -214,3 +217,49 @@ nosnp:
  * This must be called after the IOMMU has been initialized.
  */
 device_initcall(snp_rmptable_init);
+
+static struct rmpentry *get_rmpentry(u64 pfn)
+{
+	if (WARN_ON_ONCE(pfn > rmptable_max_pfn))
+		return ERR_PTR(-EFAULT);
+
+	return &rmptable[pfn];
+}
+
+static struct rmpentry *__snp_lookup_rmpentry(u64 pfn, int *level)
+{
+	struct rmpentry *large_entry, *entry;
+
+	if (!cpu_feature_enabled(X86_FEATURE_SEV_SNP))
+		return ERR_PTR(-ENODEV);
+
+	entry = get_rmpentry(pfn);
+	if (IS_ERR(entry))
+		return entry;
+
+	/*
+	 * Find the authoritative RMP entry for a PFN. This can be either a 4K
+	 * RMP entry or a special large RMP entry that is authoritative for a
+	 * whole 2M area.
+	 */
+	large_entry = get_rmpentry(pfn & PFN_PMD_MASK);
+	if (IS_ERR(large_entry))
+		return large_entry;
+
+	*level = RMP_TO_PG_LEVEL(large_entry->pagesize);
+
+	return entry;
+}
+
+int snp_lookup_rmpentry(u64 pfn, bool *assigned, int *level)
+{
+	struct rmpentry *e;
+
+	e = __snp_lookup_rmpentry(pfn, level);
+	if (IS_ERR(e))
+		return PTR_ERR(e);
+
+	*assigned = !!e->assigned;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snp_lookup_rmpentry);

