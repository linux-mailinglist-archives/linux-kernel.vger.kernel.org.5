Return-Path: <linux-kernel+bounces-39092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E985A83CAD5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A32C82844A0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73E11350CF;
	Thu, 25 Jan 2024 18:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rVh6kEfl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2EC/AIlv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90524133994;
	Thu, 25 Jan 2024 18:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706206894; cv=none; b=kxe4jUpvBOPapgy4Yjni6XB5sNLDLQft1RWhTAu1skIxY5SHywYMapAgMrP7eXosVrbx6n0UbCdG3XzkaacrjjJ63vo9zYyeJRt2dD07mfP4NMZJewfzoSKUCTauBqkLVP0r9O5YgGH2j+fG5b454TB0EI0oyCwz2u7cGMHFF9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706206894; c=relaxed/simple;
	bh=hlKPIQWs+nqz5n/JkEUGsWDTrg6fotPLGd5Uav6GkOs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=pecoeMAjeQsRZ4Vo5gUCmmrsZxG3sV2Gx1uIXTIyMdMwyjHL3FSJoAq+obKSSI3H1p2mkWMngZUXBmq9JJ8mDsQm03nr3ZYgx/EZHD/lMn70NblWlRZA+cj00emzCVjrvZJ5HqW/pEsskKM/obN5hV7qsFDcwYLOXworsUx+04o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rVh6kEfl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2EC/AIlv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Jan 2024 18:21:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706206883;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zsxTmJZoA59sY8kUufCOH3e/7llLXUJeKT/WAF1bOjs=;
	b=rVh6kEflRVGuo1UfLXHnSXXAxpm5GY6iFaDhWgLsCX02gdf/uDdake0LGRB/ViLHnycpLd
	UT/pJ7LM/oSdG44baau1PcO2mK5R91kbbtBY/VjY2a8zuWMZEK4E9YYLNjmBuP3byC5r6x
	tph6bEeuRNV6L8zFQMD1DBiIeyf7lWJbcMz2z0Dv/8VomqkzaNA7Gr2CTzs9/Ws9ub7dcD
	eNDv2112Src4pj/Mnd+U4iYio9KLHqUFF9NR4t7JtuJpQ8Gs1h8f8YswNYVtpcLslLxtIZ
	5gU+Xs8xnIgj1vJn3Wmyp2BOsPkJ/CNAF1a/xM7ksL4Tz4HTLUbn7jF8aXKcjA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706206883;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zsxTmJZoA59sY8kUufCOH3e/7llLXUJeKT/WAF1bOjs=;
	b=2EC/AIlvlcI/FVhanLXfgLX036xiaXP9n5WWovyN5oNjY3dM6Rgz5HPFeYayJO8eD7yKgy
	Gg/6XqBEZ24N/2Ag==
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
Message-ID: <170620688304.398.9423671583132761035.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fred branch of tip:

Commit-ID:     994f75798425ca0865b54dcc7bbe13bba5e4cfe4
Gitweb:        https://git.kernel.org/tip/994f75798425ca0865b54dcc7bbe13bba5e4cfe4
Author:        H. Peter Anvin (Intel) <hpa@zytor.com>
AuthorDate:    Fri, 15 Dec 2023 22:31:39 -08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 25 Jan 2024 19:10:32 +01:00

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

