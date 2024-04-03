Return-Path: <linux-kernel+bounces-129195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A46478966CF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 345A01F28BD6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 07:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E5B6D1B0;
	Wed,  3 Apr 2024 07:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="20+Svkn7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qFG17CRo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1525C613;
	Wed,  3 Apr 2024 07:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712130031; cv=none; b=ZWA4EKDDhryZxkWJ9+hYcn6GHe+PSyIjsH4dJr4DSr/ZMjx952LZDt2HamiJIFSYgIGA3LsAtK9gKZkGdJAfPrdQk/NbdJT8q/HbyWlWgaoh8dC8wvXcNw4T0fEOy+MXGnaRtsAzsPzWG378eLa+upYkBgtOAJIDcGGUwVHaeNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712130031; c=relaxed/simple;
	bh=X1Ejj6pQJl1otP73Gxep9A9q56/8R1KtH0bE/VUXWl4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Bbg2C2pH+B9D8AXHIenQ32KxhypCW7eXI3/MrJvRbRa/rAU/ZmoY2wnm1MJtrL94g2D6KrSxS3ldinnTaUtOc4jI1wcPIRB19p9L6UhSSEXyOTieN+fiT5Glnam9gqC05cyAPpqwRCKXKgvhx8IApcfoRt4U242hptPHnYMPrTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=20+Svkn7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qFG17CRo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 03 Apr 2024 07:40:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712130027;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RXfTsJkJhFz951NjPLL+YHabyjaUSV9iQsd0QP0c098=;
	b=20+Svkn7qRqgmkcUOoqz4TVOUxqn37kLsSMLl0OvRJF2n8sJ7KL6/j3RFlyTvcRCaRzoOj
	c5jSBdkLP70BYmK0k4g/lnm22CqlyKgJP75YwGAsvYBvWqOrdhvUQVFBBDbxloRpFv4YK7
	4jArJFlhx7oxKBAb2ufdshzCWf7OFytNcBA/VJDad6l32Im7BwTe+JYRudQIfPdXN7SDhN
	uLqmmSwXfQmGgFP6zpRggojIYoZnVtsUxRFH55a6Eouw6J3/FEK3V7SAEkmXSmlycMZzWZ
	6Aoc9JmQMma8My/DB2JDAZGAjJdAtdTS1VmKSkll2PbyfbbUtm7l0mkgcqY19g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712130027;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RXfTsJkJhFz951NjPLL+YHabyjaUSV9iQsd0QP0c098=;
	b=qFG17CRo/4RRwltJdhImGZRPvKY0qJJazQpz4YBPGCOKIvKQm9dqZ/OG/k/LKea8d7EnVN
	mcMQ0K8K3bWRBnAQ==
From: "tip-bot2 for Andrii Nakryiko" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] perf/x86/amd: Support capturing LBR from software events
Cc: Andrii Nakryiko <andrii@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Sandipan Das <sandipan.das@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240402022118.1046049-4-andrii@kernel.org>
References: <20240402022118.1046049-4-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171213002683.10875.11023062509695704537.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     a4d18112e5317c120bcadeb486fbe950f749bb5e
Gitweb:        https://git.kernel.org/tip/a4d18112e5317c120bcadeb486fbe950f749bb5e
Author:        Andrii Nakryiko <andrii@kernel.org>
AuthorDate:    Mon, 01 Apr 2024 19:21:17 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 03 Apr 2024 09:14:26 +02:00

perf/x86/amd: Support capturing LBR from software events

Upstream commit c22ac2a3d4bd ("perf: Enable branch record for software
events") added ability to capture LBR (Last Branch Records) on Intel CPUs
from inside BPF program at pretty much any arbitrary point. This is
extremely useful capability that allows to figure out otherwise
hard to debug problems, because LBR is now available based on some
application-defined conditions, not just hardware-supported events.

'retsnoop' is one such tool that takes a huge advantage of this
functionality and has proved to be an extremely useful tool in
practice:

  https://github.com/anakryiko/retsnoop

Now, AMD Zen4 CPUs got support for similar LBR functionality, but
necessary wiring inside the kernel is not yet setup. This patch seeks to
rectify this and follows a similar approach to the original patch
for Intel CPUs. We implement an AMD-specific callback set to be called
through perf_snapshot_branch_stack static call.

Previous preparatory patches ensured that amd_pmu_core_disable_all() and
__amd_pmu_lbr_disable() will be completely inlined and will have no
branches, so LBR snapshot contamination will be minimized.

This was tested on AMD Bergamo CPU and worked well when utilized from
the aforementioned retsnoop tool.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Sandipan Das <sandipan.das@amd.com>
Link: https://lore.kernel.org/r/20240402022118.1046049-4-andrii@kernel.org
---
 arch/x86/events/amd/core.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 9b15afd..1fc4ce4 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -907,6 +907,37 @@ static int amd_pmu_handle_irq(struct pt_regs *regs)
 	return amd_pmu_adjust_nmi_window(handled);
 }
 
+/*
+ * AMD-specific callback invoked through perf_snapshot_branch_stack static
+ * call, defined in include/linux/perf_event.h. See its definition for API
+ * details. It's up to caller to provide enough space in *entries* to fit all
+ * LBR records, otherwise returned result will be truncated to *cnt* entries.
+ */
+static int amd_pmu_v2_snapshot_branch_stack(struct perf_branch_entry *entries, unsigned int cnt)
+{
+	struct cpu_hw_events *cpuc;
+	unsigned long flags;
+
+	/*
+	 * The sequence of steps to freeze LBR should be completely inlined
+	 * and contain no branches to minimize contamination of LBR snapshot
+	 */
+	local_irq_save(flags);
+	amd_pmu_core_disable_all();
+	__amd_pmu_lbr_disable();
+
+	cpuc = this_cpu_ptr(&cpu_hw_events);
+
+	amd_pmu_lbr_read();
+	cnt = min(cnt, x86_pmu.lbr_nr);
+	memcpy(entries, cpuc->lbr_entries, sizeof(struct perf_branch_entry) * cnt);
+
+	amd_pmu_v2_enable_all(0);
+	local_irq_restore(flags);
+
+	return cnt;
+}
+
 static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
@@ -1443,6 +1474,10 @@ static int __init amd_core_pmu_init(void)
 		static_call_update(amd_pmu_branch_reset, amd_pmu_lbr_reset);
 		static_call_update(amd_pmu_branch_add, amd_pmu_lbr_add);
 		static_call_update(amd_pmu_branch_del, amd_pmu_lbr_del);
+
+		/* Only support branch_stack snapshot on perfmon v2 */
+		if (x86_pmu.handle_irq == amd_pmu_v2_handle_irq)
+			static_call_update(perf_snapshot_branch_stack, amd_pmu_v2_snapshot_branch_stack);
 	} else if (!amd_brs_init()) {
 		/*
 		 * BRS requires special event constraints and flushing on ctxsw.

