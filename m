Return-Path: <linux-kernel+bounces-45902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6278F8437B0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27451287ADA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 07:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070BD6A030;
	Wed, 31 Jan 2024 07:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G+pVQ/yj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ptWjD1QE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC6B62A1C;
	Wed, 31 Jan 2024 07:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706685680; cv=none; b=Nf30V/x0fbFDma8c4HCSI5zsbk5ESG6bsPE88PibZlflh3b3x9iAZTaW1htgobFwtwqEDvNoiaAs2fkILkVq4voelFnSbzhgASrbqPgc3OIhR/7deQsV1uJxIBXuQGh/YV6I7ZjJAT5KM4h6yDdet1cfC41Ac70hi2wYhcgTZKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706685680; c=relaxed/simple;
	bh=Ibzm9A6Vo/fpJ0Cw65TRWGGNPYr5vvOVrTK94yy9KLU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=GzXbVUI6cVd150AMOuYZbtaz/ZDtvsFRDq1rU3559GBYSG4JPcS1ctK1LfySX50bKxSAAE1aiJQ7ltjCmsURboFfUL0x4fYtLGCTdd5J4GrbhCXqeRiP5q4VCmGnGKvzkWap4pb2FqHRtr2phhsFoJcqNeRnaD1OYNLV6CxjWRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G+pVQ/yj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ptWjD1QE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 31 Jan 2024 07:21:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706685676;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3CfPTlfHIkEq7MOGkWYQv3Zd8bsG/aJzTq+fFuJ/wgY=;
	b=G+pVQ/yj0dD4H/tbEoNKLkjIzXLB9z5ve/3KDoOUbwb7G6p9eQb3RqHcgTJMowMo1kQyih
	w1OcluLsLB+YfVU9ZOfjqz44Je1EPOJVI9CnxmPXwDNdnN0wnHNbnG7YJEz6LS0IMDVrY3
	rBiXUM2pSRsz3sPhvg5fX4rC5NHmVrsIG5ApaC9PCfRoZBevqNln3QgntXdAEdu65gv89d
	ycvMlPT4qSq6N1KwOCz8W7icqpItgDJP23u+Vw63ERCQQf6VpLSQrHIWKOd1dSri4EK8hN
	TG9CinDbsQvde3FBU2N2SbtThLfAeGK+7NlOJ6PIugDDro5VO3Gj173ejMk4TQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706685676;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3CfPTlfHIkEq7MOGkWYQv3Zd8bsG/aJzTq+fFuJ/wgY=;
	b=ptWjD1QEuSx8mX86CUXpIimoj+P4q3qFypCXfPSwjCyuDtAR1cDqVrUQro5qypJNR3bBpc
	40C/HD//8DQz74Cg==
From: "tip-bot2 for H. Peter Anvin (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fred] x86/fred: Add a NMI entry stub for FRED
Cc: "H. Peter Anvin (Intel)" <hpa@zytor.com>, Xin Li <xin3.li@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Shan Kang <shan.kang@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231216063139.25567-1-xin3.li@intel.com>
References: <20231216063139.25567-1-xin3.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170668567578.398.4135088693779687694.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fred branch of tip:

Commit-ID:     3e91abaa567300fd48a0fac4c9aaedd30fa2f3f9
Gitweb:        https://git.kernel.org/tip/3e91abaa567300fd48a0fac4c9aaedd30fa2f3f9
Author:        H. Peter Anvin (Intel) <hpa@zytor.com>
AuthorDate:    Fri, 15 Dec 2023 22:31:39 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 30 Jan 2024 18:20:35 +01:00

x86/fred: Add a NMI entry stub for FRED

On a FRED system, NMIs nest both with themselves and faults, transient
information is saved into the stack frame, and NMI unblocking only
happens when the stack frame indicates that so should happen.

Thus, the NMI entry stub for FRED is really quite small...

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
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

