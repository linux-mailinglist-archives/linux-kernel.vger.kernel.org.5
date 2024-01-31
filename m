Return-Path: <linux-kernel+bounces-47128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C98A8449A7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:17:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCDBE286EF8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3071B3B1AB;
	Wed, 31 Jan 2024 21:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oLI1MhjK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PtxBZSbR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534993A1D7;
	Wed, 31 Jan 2024 21:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706735690; cv=none; b=gbFNxgYLoLFol9vXXI6zY3xpilLls1Xs5KnZxicj7HEKifoKYvNvWD44KnVYr+clilN7jlyUY2jBX2XsewlX5kcOwCu4kX6yaKZ9B+AMhV2816Vckm1/kCs0dnbB/SmlEjloQMbBhvqfJkLsCs0Z+nRw7Yvx2stzpHSK5Jers5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706735690; c=relaxed/simple;
	bh=2nIhboN/0E/QCdEFtm3CG47Jl41VbX3+rhAyQI6MXf0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jXc0T21BMTvkeb5EWX2gXjz3SWFll6ojCf7lizIw5QehmwKyTxtuWv7KJj1nen+vRdhmp2YrJjcGzOrOjAVBjhi16IeyMsmxTLFxJt52rLMZPgTTot4fvxIcePYODKHA5z+F9eY/b1V6s4i9eutlq5WW/B8MgvNxWOL1ZuuGpnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oLI1MhjK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PtxBZSbR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 31 Jan 2024 21:14:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706735686;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y7O5OUrV7mSdkzKL5SPYfAZTux7Bp7RTvXcJRUg1L4U=;
	b=oLI1MhjKRNgnSiSzEWncnBBhjwKLhkwViPo9Jlff+VZuXxCp0+LR5y/Go1QRnU3cMO4wWg
	halk68ul4ZCVg2Ou3lbLWVFPqQddssMDGUYU36wSN58gyKZ9Rp5b33mRseZx0UnaXAr6QO
	RsOABv3TyAKPLhyfYyEpvcYGpecUVWitfNK2s7XzJKJ9t+zUF2dQXY1cwvc2jilPwypvvu
	eo3iZYpp1q9e9sEVaoD2th6UFvzNjEc9ys0HwbmO7v91WpDgkJdOAr8i9JgeNL49qHpZ6F
	edYR1QLWIfcC/ad9RSUZMS8iSQgBO2UiEPnpG0BqKAsl6mNkIYosD3MDkKIEKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706735686;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y7O5OUrV7mSdkzKL5SPYfAZTux7Bp7RTvXcJRUg1L4U=;
	b=PtxBZSbRDOzO8XDtluiC1kFjlMgW/zl32arF//vtKpQLJ2RMxtogk+FT6Q7TNHPX6Co+9/
	YOHSQC3O1jQCDFDw==
From: "tip-bot2 for H. Peter Anvin (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fred] x86/fred: Add a NMI entry stub for FRED
Cc: "H. Peter Anvin (Intel)" <hpa@zytor.com>, Xin Li <xin3.li@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Shan Kang <shan.kang@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231216063139.25567-1-xin3.li@intel.com>
References: <20231216063139.25567-1-xin3.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170673568564.398.16843749348991010106.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fred branch of tip:

Commit-ID:     f8b8ee45f82b681606d288bcec89c9071b4079fc
Gitweb:        https://git.kernel.org/tip/f8b8ee45f82b681606d288bcec89c9071b4079fc
Author:        H. Peter Anvin (Intel) <hpa@zytor.com>
AuthorDate:    Fri, 15 Dec 2023 22:31:39 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 31 Jan 2024 22:02:20 +01:00

x86/fred: Add a NMI entry stub for FRED

On a FRED system, NMIs nest both with themselves and faults, transient
information is saved into the stack frame, and NMI unblocking only
happens when the stack frame indicates that so should happen.

Thus, the NMI entry stub for FRED is really quite small...

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Shan Kang <shan.kang@intel.com>
Link: https://lore.kernel.org/r/20231216063139.25567-1-xin3.li@intel.com
---
 arch/x86/kernel/nmi.c | 42 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+)

diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index 17e955a..3130a66 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -35,6 +35,7 @@
 #include <asm/nospec-branch.h>
 #include <asm/microcode.h>
 #include <asm/sev.h>
+#include <asm/fred.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/nmi.h>
@@ -651,6 +652,47 @@ void nmi_backtrace_stall_check(const struct cpumask *btp)
 
 #endif
 
+#ifdef CONFIG_X86_FRED
+/*
+ * With FRED, CR2/DR6 is pushed to #PF/#DB stack frame during FRED
+ * event delivery, i.e., there is no problem of transient states.
+ * And NMI unblocking only happens when the stack frame indicates
+ * that so should happen.
+ *
+ * Thus, the NMI entry stub for FRED is really straightforward and
+ * as simple as most exception handlers. As such, #DB is allowed
+ * during NMI handling.
+ */
+DEFINE_FREDENTRY_NMI(exc_nmi)
+{
+	irqentry_state_t irq_state;
+
+	if (arch_cpu_is_offline(smp_processor_id())) {
+		if (microcode_nmi_handler_enabled())
+			microcode_offline_nmi_handler();
+		return;
+	}
+
+	/*
+	 * Save CR2 for eventual restore to cover the case where the NMI
+	 * hits the VMENTER/VMEXIT region where guest CR2 is life. This
+	 * prevents guest state corruption in case that the NMI handler
+	 * takes a page fault.
+	 */
+	this_cpu_write(nmi_cr2, read_cr2());
+
+	irq_state = irqentry_nmi_enter(regs);
+
+	inc_irq_stat(__nmi_count);
+	default_do_nmi(regs);
+
+	irqentry_nmi_exit(regs, irq_state);
+
+	if (unlikely(this_cpu_read(nmi_cr2) != read_cr2()))
+		write_cr2(this_cpu_read(nmi_cr2));
+}
+#endif
+
 void stop_nmi(void)
 {
 	ignore_nmis++;

