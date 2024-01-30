Return-Path: <linux-kernel+bounces-44933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3D5842930
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FB7B1C25D6F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D9612DD86;
	Tue, 30 Jan 2024 16:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dOgEIkRy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1TGlXe0Z"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B771E12C523;
	Tue, 30 Jan 2024 16:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706631970; cv=none; b=TIIkHNlfYFUps5tmzt0GdO7d8cffegXdzGRnSlVE1i+FxvxdHijsUSXpvTdZ3BoCEEGoaPxjaCGpgd9utUuC45jF/omUup2O7Wth16+unQWCFgthwfmOktWJkweCEKdqcQNIzprLXzjRw0jKn0v3GnDVG3bIZ6f2+61GBEbnxi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706631970; c=relaxed/simple;
	bh=7HkTS7ijHuI2zcj4sXdGdOSowZ6MyOtZb8vJTmoGWoE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=uQYZS2rBweefFHZ2vmV8a4hG/0WTa2awBxCwXQOAa7flNTw607OI5vAmEAsfe0CqhKYr3LG3WRdEW6xYjDwZ7eNUEZV7Hch8sZ1TLXq72F0z0pOmO+8NNlwsEO1S6LJm0nVONV6pGGnUeGXsScn3q3qWDprTosh/calQbc8Dpfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dOgEIkRy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1TGlXe0Z; arc=none smtp.client-ip=193.142.43.55
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
	bh=pGxHlSXstFc19ImKtgH0AbzdI1XQF4C510NZnN7LI5o=;
	b=dOgEIkRyhwDw3zrNYsNMlZ1OjnRm5Ap2TuehmCHRo5d6i8IV81WbbpxHvttKN/ju8/Bqtj
	tgMr0qk2aZ+CjDPd85WndGpNxaFy3e5PYRDD+jv+/ULmhWZJqDeSeEYYfQmFDd9Rhtu7X6
	glKGvVx/+K06A6q55FufZKlE5RfbfaXLZQtDGXPDIC4KEWmhocqiWDGBFv2UEpDuWdnj1D
	W0AhLulvvzlZVWHZ08Ho9ytPX75bZ+SUXhS4kwhv8j3aCfTDL0HYum73pBZjxjsJiy246d
	iG5I7LaUrIrzC8I8FUe0PQpGW8PDJAvWeXEw61/I8Vwx1xyuGRQesBuNBvoyqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706631967;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pGxHlSXstFc19ImKtgH0AbzdI1XQF4C510NZnN7LI5o=;
	b=1TGlXe0ZGxGZSkLkpd4nMw0SS9x6QGcv074oSn2z8Jktm+6OlmxQWVuLR1UO9+8JELAlfF
	T9I8EBqR4IPbZMCg==
From: "tip-bot2 for Michael Roth" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/sev] x86/sev: Adjust the directmap to avoid inadvertent RMP faults
Cc: Michael Roth <michael.roth@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Vlastimil Babka <vbabka@suse.cz>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240126041126.1927228-12-michael.roth@amd.com>
References: <20240126041126.1927228-12-michael.roth@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170663196627.398.8684786725959588137.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     661b1c6169e2b260753b850823d583d9f2c01be4
Gitweb:        https://git.kernel.org/tip/661b1c6169e2b260753b850823d583d9f2c01be4
Author:        Michael Roth <michael.roth@amd.com>
AuthorDate:    Thu, 25 Jan 2024 22:11:11 -06:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 29 Jan 2024 20:34:18 +01:00

x86/sev: Adjust the directmap to avoid inadvertent RMP faults

If the kernel uses a 2MB or larger directmap mapping to write to an
address, and that mapping contains any 4KB pages that are set to private
in the RMP table, an RMP #PF will trigger and cause a host crash.

SNP-aware code that owns the private PFNs will never attempt such
a write, but other kernel tasks writing to other PFNs in the range may
trigger these checks inadvertently due to writing to those other PFNs
via a large directmap mapping that happens to also map a private PFN.

Prevent this by splitting any 2MB+ mappings that might end up containing
a mix of private/shared PFNs as a result of a subsequent RMPUPDATE for
the PFN/rmp_level passed in.

Another way to handle this would be to limit the directmap to 4K
mappings in the case of hosts that support SNP, but there is potential
risk for performance regressions of certain host workloads.

Handling it as-needed results in the directmap being slowly split over
time, which lessens the risk of a performance regression since the more
the directmap gets split as a result of running SNP guests, the more
likely the host is being used primarily to run SNP guests, where
a mostly-split directmap is actually beneficial since there is less
chance of TLB flushing and cpa_lock contention being needed to perform
these splits.

Cases where a host knows in advance it wants to primarily run SNP guests
and wishes to pre-split the directmap can be handled by adding
a tuneable in the future, but preliminary testing has shown this to not
provide a signficant benefit in the common case of guests that are
backed primarily by 2MB THPs, so it does not seem to be warranted
currently and can be added later if a need arises in the future.

Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Link: https://lore.kernel.org/r/20240126041126.1927228-12-michael.roth@amd.com
---
 arch/x86/virt/svm/sev.c | 85 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 83 insertions(+), 2 deletions(-)

diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
index dc18335..5566fb0 100644
--- a/arch/x86/virt/svm/sev.c
+++ b/arch/x86/virt/svm/sev.c
@@ -369,6 +369,81 @@ int psmash(u64 pfn)
 EXPORT_SYMBOL_GPL(psmash);
 
 /*
+ * If the kernel uses a 2MB or larger directmap mapping to write to an address,
+ * and that mapping contains any 4KB pages that are set to private in the RMP
+ * table, an RMP #PF will trigger and cause a host crash. Hypervisor code that
+ * owns the PFNs being transitioned will never attempt such a write, but other
+ * kernel tasks writing to other PFNs in the range may trigger these checks
+ * inadvertently due a large directmap mapping that happens to overlap such a
+ * PFN.
+ *
+ * Prevent this by splitting any 2MB+ mappings that might end up containing a
+ * mix of private/shared PFNs as a result of a subsequent RMPUPDATE for the
+ * PFN/rmp_level passed in.
+ *
+ * Note that there is no attempt here to scan all the RMP entries for the 2MB
+ * physical range, since it would only be worthwhile in determining if a
+ * subsequent RMPUPDATE for a 4KB PFN would result in all the entries being of
+ * the same shared/private state, thus avoiding the need to split the mapping.
+ * But that would mean the entries are currently in a mixed state, and so the
+ * mapping would have already been split as a result of prior transitions.
+ * And since the 4K split is only done if the mapping is 2MB+, and there isn't
+ * currently a mechanism in place to restore 2MB+ mappings, such a check would
+ * not provide any usable benefit.
+ *
+ * More specifics on how these checks are carried out can be found in APM
+ * Volume 2, "RMP and VMPL Access Checks".
+ */
+static int adjust_direct_map(u64 pfn, int rmp_level)
+{
+	unsigned long vaddr;
+	unsigned int level;
+	int npages, ret;
+	pte_t *pte;
+
+	/*
+	 * pfn_to_kaddr() will return a vaddr only within the direct
+	 * map range.
+	 */
+	vaddr = (unsigned long)pfn_to_kaddr(pfn);
+
+	/* Only 4KB/2MB RMP entries are supported by current hardware. */
+	if (WARN_ON_ONCE(rmp_level > PG_LEVEL_2M))
+		return -EINVAL;
+
+	if (!pfn_valid(pfn))
+		return -EINVAL;
+
+	if (rmp_level == PG_LEVEL_2M &&
+	    (!IS_ALIGNED(pfn, PTRS_PER_PMD) || !pfn_valid(pfn + PTRS_PER_PMD - 1)))
+		return -EINVAL;
+
+	/*
+	 * If an entire 2MB physical range is being transitioned, then there is
+	 * no risk of RMP #PFs due to write accesses from overlapping mappings,
+	 * since even accesses from 1GB mappings will be treated as 2MB accesses
+	 * as far as RMP table checks are concerned.
+	 */
+	if (rmp_level == PG_LEVEL_2M)
+		return 0;
+
+	pte = lookup_address(vaddr, &level);
+	if (!pte || pte_none(*pte))
+		return 0;
+
+	if (level == PG_LEVEL_4K)
+		return 0;
+
+	npages = page_level_size(rmp_level) / PAGE_SIZE;
+	ret = set_memory_4k(vaddr, npages);
+	if (ret)
+		pr_warn("Failed to split direct map for PFN 0x%llx, ret: %d\n",
+			pfn, ret);
+
+	return ret;
+}
+
+/*
  * It is expected that those operations are seldom enough so that no mutual
  * exclusion of updaters is needed and thus the overlap error condition below
  * should happen very rarely and would get resolved relatively quickly by
@@ -384,11 +459,16 @@ EXPORT_SYMBOL_GPL(psmash);
 static int rmpupdate(u64 pfn, struct rmp_state *state)
 {
 	unsigned long paddr = pfn << PAGE_SHIFT;
-	int ret;
+	int ret, level;
 
 	if (!cpu_feature_enabled(X86_FEATURE_SEV_SNP))
 		return -ENODEV;
 
+	level = RMP_TO_PG_LEVEL(state->pagesize);
+
+	if (adjust_direct_map(pfn, level))
+		return -EFAULT;
+
 	do {
 		/* Binutils version 2.36 supports the RMPUPDATE mnemonic. */
 		asm volatile(".byte 0xF2, 0x0F, 0x01, 0xFE"
@@ -398,7 +478,8 @@ static int rmpupdate(u64 pfn, struct rmp_state *state)
 	} while (ret == RMPUPDATE_FAIL_OVERLAP);
 
 	if (ret) {
-		pr_err("RMPUPDATE failed for PFN %llx, ret: %d\n", pfn, ret);
+		pr_err("RMPUPDATE failed for PFN %llx, pg_level: %d, ret: %d\n",
+		       pfn, level, ret);
 		dump_rmpentry(pfn);
 		dump_stack();
 		return -EFAULT;

