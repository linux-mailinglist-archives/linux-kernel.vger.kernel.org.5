Return-Path: <linux-kernel+bounces-118679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C05788BDEF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4C04304D18
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC8D535CF;
	Tue, 26 Mar 2024 09:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dD6JKrhM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MBeym/TH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A764CE09;
	Tue, 26 Mar 2024 09:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711444871; cv=none; b=olfzJ3F3qVVBO1kwMGsNx+bWLGEQHG/SRuJyGrjXG51ZvJLViWxv/sVKkCt7SmWCtys7eboEdTfqvzfk/F/UCA2pEsg3XCxcK5b8yAG7ZOFh3JWlW9uww/ZbAojVrKgeJxL/M5jGHx1J62KIYq2v2uXs84D6WpRbCeDMbMiqX4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711444871; c=relaxed/simple;
	bh=L1aGiArlPsZ+bQny3tvbhbXelHlaXT2szGwtPU5OQGw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=CJWuUcGlFKj4UXEJGmTmfNfzjMnZS3QRRgoHrqj73E41wyjCAQfe2KOxe2cieUxQBNZpoFgw4iu3WPiHNzgDqm+9gnQIWUAqEaHicVBbtVGrggQA3CI4uYQ8K8IDwSnziTxCilC+avQAtaffQAYkWxLSVh96UBNt0bkmY8x8PDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dD6JKrhM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MBeym/TH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 26 Mar 2024 09:21:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711444867;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2A00E/c8uqCaQHkVCU/Oq9rDbHV2kx2Rs5KES71fn6M=;
	b=dD6JKrhM0zqXW3Lj06bAHUVyZ2AEztZI0Sk+OGTO2FkU3hzg0D0mucLMIIh3u31gNTN4Au
	SRDmrem2P9HyUqrsIx9TnIMQgzH6ysAi9a18NfHTxqkdA0oG5GAgXqGtPOb+tTQK7OcUE8
	bnLBTmr1z8eKC6zoCrzhEjZ3z+A1gaXEmtiTzgrdvyrRROmpTqZ3JSeX0ZWCQXeS+FTax0
	RQN89f5jQz3BcwJQdhBSOfWBWIceTZ5fNmSk+bSQviJ7hQ3j3A7+kkqhDj4xuzSkvfvJDe
	OckA+oo/F2/XWtkR4+K0SjckDQ1OUmK87+a2UljfTCsHe7GMqOaTA1vWRK63dQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711444867;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2A00E/c8uqCaQHkVCU/Oq9rDbHV2kx2Rs5KES71fn6M=;
	b=MBeym/THDeLwvWMPZ9s6Mc0J8IRF6UhqjjlxIr6ZdbxyHPNCDyP31o1V6uWpnXG/kd82XY
	JEIRgm3zFgY0S/Cg==
From: "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/urgent] x86/nmi: Upgrade NMI backtrace stall checks & messages
Cc: Breno Leitao <leitao@debian.org>, "Paul E. McKenney" <paulmck@kernel.org>,
 Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <ab4d70c8-c874-42dc-b206-643018922393@paulmck-laptop>
References: <ab4d70c8-c874-42dc-b206-643018922393@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171144486643.10875.13891742949847997035.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     3186b61812c007179f1852d8e63a0f0f7dd7c783
Gitweb:        https://git.kernel.org/tip/3186b61812c007179f1852d8e63a0f0f7dd7c783
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 07 Mar 2024 17:32:15 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 26 Mar 2024 10:07:59 +01:00

x86/nmi: Upgrade NMI backtrace stall checks & messages

The commit to improve NMI stall debuggability:

  344da544f177 ("x86/nmi: Print reasons why backtrace NMIs are ignored")

.. has shown value, but widespread use has also identified a few
opportunities for improvement.

The systems have (as usual) shown far more creativity than that commit's
author, demonstrating yet again that failing CPUs can do whatever they want.

In addition, the current message format is less friendly than one might
like to those attempting to use these messages to identify failing CPUs.

Therefore, separately flag CPUs that, during the full time that the
stack-backtrace request was waiting, were always in an NMI handler,
were never in an NMI handler, or exited one NMI handler.

Also, split the message identifying the CPU and the time since that CPU's
last NMI-related activity so that a single line identifies the CPU without
any other variable information, greatly reducing the processing overhead
required to identify repeat-offender CPUs.

Co-developed-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/ab4d70c8-c874-42dc-b206-643018922393@paulmck-laptop
---
 arch/x86/kernel/nmi.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index 9a5b372..ed163c8 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -580,7 +580,7 @@ EXPORT_SYMBOL_GPL(asm_exc_nmi_kvm_vmx);
 
 static char *nmi_check_stall_msg[] = {
 /*									*/
-/* +--------- nsp->idt_seq_snap & 0x1: CPU is in NMI handler.		*/
+/* +--------- nmi_seq & 0x1: CPU is currently in NMI handler.		*/
 /* | +------ cpu_is_offline(cpu)					*/
 /* | | +--- nsp->idt_calls_snap != atomic_long_read(&nsp->idt_calls):	*/
 /* | | |	NMI handler has been invoked.				*/
@@ -628,22 +628,26 @@ void nmi_backtrace_stall_check(const struct cpumask *btp)
 		nmi_seq = READ_ONCE(nsp->idt_nmi_seq);
 		if (nsp->idt_nmi_seq_snap + 1 == nmi_seq && (nmi_seq & 0x1)) {
 			msgp = "CPU entered NMI handler function, but has not exited";
-		} else if ((nsp->idt_nmi_seq_snap & 0x1) != (nmi_seq & 0x1)) {
-			msgp = "CPU is handling NMIs";
-		} else {
-			idx = ((nsp->idt_seq_snap & 0x1) << 2) |
+		} else if (nsp->idt_nmi_seq_snap == nmi_seq ||
+			   nsp->idt_nmi_seq_snap + 1 == nmi_seq) {
+			idx = ((nmi_seq & 0x1) << 2) |
 			      (cpu_is_offline(cpu) << 1) |
 			      (nsp->idt_calls_snap != atomic_long_read(&nsp->idt_calls));
 			msgp = nmi_check_stall_msg[idx];
 			if (nsp->idt_ignored_snap != READ_ONCE(nsp->idt_ignored) && (idx & 0x1))
 				modp = ", but OK because ignore_nmis was set";
-			if (nmi_seq & 0x1)
-				msghp = " (CPU currently in NMI handler function)";
-			else if (nsp->idt_nmi_seq_snap + 1 == nmi_seq)
+			if (nsp->idt_nmi_seq_snap + 1 == nmi_seq)
 				msghp = " (CPU exited one NMI handler function)";
+			else if (nmi_seq & 0x1)
+				msghp = " (CPU currently in NMI handler function)";
+			else
+				msghp = " (CPU was never in an NMI handler function)";
+		} else {
+			msgp = "CPU is handling NMIs";
 		}
-		pr_alert("%s: CPU %d: %s%s%s, last activity: %lu jiffies ago.\n",
-			 __func__, cpu, msgp, modp, msghp, j - READ_ONCE(nsp->recv_jiffies));
+		pr_alert("%s: CPU %d: %s%s%s\n", __func__, cpu, msgp, modp, msghp);
+		pr_alert("%s: last activity: %lu jiffies ago.\n",
+			 __func__, j - READ_ONCE(nsp->recv_jiffies));
 	}
 }
 

