Return-Path: <linux-kernel+bounces-164002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2CC58B7704
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D463B1C21E92
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39A9172BA4;
	Tue, 30 Apr 2024 13:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ONy14zTW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g9ohQM66"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2859A17167F;
	Tue, 30 Apr 2024 13:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714483725; cv=none; b=dx6QfW9Xzj7NBd6pgVB0WQp5s1tMs3UxZugqrcIM8q63RsT1+CMS6VCs0kO3SRySZFi5lkI+zYHCovl+U2eOu4RMJCkHK0ySRfMFv5iGloz+6r1f9txSJkbOiWBbnDtnG60p/fWt4qEcoeAvJulIUNGmzyfIKEf1H0yhZAZpCqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714483725; c=relaxed/simple;
	bh=U0kw+bDWnKUXD6t9rapJ+9DZBUZ1o31KmIJHuBJPYgc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Yc4mOiz2507g+X8ZBnzxhGWHSd/nLdbyVI6BwXrtPdB6fWLSuRSRDsElas8QrklhyulIuW3JildC2z2un3AH5Ykn5FRXQKuY11eR9G22h33WZSgZ6X/me8IFjnByqlKWf7darEp5Ds1yIqr0K5IB5n9CeUjDJU8UfZ62qwLMIQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ONy14zTW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=g9ohQM66; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Apr 2024 13:28:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714483721;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QrFIOgY+GZUDp9KsfEiEGCFKsujxnO8x3fnZETKQryU=;
	b=ONy14zTWDjzfAINbeHbIArk1h5ItDqsTZwMlL9JAnLnutJ3Ssg2K/NL7qNvG99FY7deHyj
	wSjnZT2w4lEh2J/TRsA3INmn0fSH0XE4u0JTtxBC1T6j4mSuLZnQaNd536BXM4FZgAjQcc
	7ruil/GUCKgnNP1uuhbacLNtYS/JE0uJKR2QrpcIGhkkx6PUGNg3cY4zvmDMu8l38QJI85
	7z7eHL9SfkH7yN6L+FR4mUjuw5rre8cLu4GXzqcx80Hgb7KeJfm7X9yxrNvQ+8DTKqhcdv
	DHLqIzxTm2IhbQCL2EVNN/3WzEKSYhkqKyGjt+JolnwoIYjmtNHqaBFzDt+/kg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714483721;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QrFIOgY+GZUDp9KsfEiEGCFKsujxnO8x3fnZETKQryU=;
	b=g9ohQM66tuaPSXb+HBzFBM4NAJQoh7A29qxy407fwtTINzt0zmuppcOdcRkw+cDsImar7C
	2rCTfpX2xO3c47CQ==
From: "tip-bot2 for Jacob Pan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/irq] x86/irq: Extend checks for pending vectors to posted
 interrupts
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240423174114.526704-11-jacob.jun.pan@linux.intel.com>
References: <20240423174114.526704-11-jacob.jun.pan@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171448372125.10875.6481211426117989791.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/irq branch of tip:

Commit-ID:     ce0a92871179f8ca58ae8e3cf50e726a163bf831
Gitweb:        https://git.kernel.org/tip/ce0a92871179f8ca58ae8e3cf50e726a163bf831
Author:        Jacob Pan <jacob.jun.pan@linux.intel.com>
AuthorDate:    Tue, 23 Apr 2024 10:41:12 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 30 Apr 2024 00:54:43 +02:00

x86/irq: Extend checks for pending vectors to posted interrupts

During interrupt affinity change, it is possible to have interrupts delivered
to the old CPU after the affinity has changed to the new one. To prevent lost
interrupts, local APIC IRR is checked on the old CPU. Similar checks must be
done for posted MSIs given the same reason.

Consider the following scenario:
	Device		system agent		iommu		memory 		CPU/LAPIC
1	FEEX_XXXX
2			Interrupt request
3						Fetch IRTE	->
4						->Atomic Swap PID.PIR(vec)
						Push to Global Observable(GO)
5						if (ON*)
							done;*
						else
6							send a notification ->

* ON: outstanding notification, 1 will suppress new notifications

If the affinity change happens between 3 and 5 in the IOMMU, the old CPU's
posted interrupt request (PIR) could have the pending bit set for the
vector being moved.

Add a helper function to check individual vector status. Then use the
helper to check for pending interrupts on the source CPU's PID.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240423174114.526704-11-jacob.jun.pan@linux.intel.com
---
 arch/x86/include/asm/apic.h        |  3 ++-
 arch/x86/include/asm/posted_intr.h | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 50f9781..5644c39 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -14,6 +14,7 @@
 #include <asm/msr.h>
 #include <asm/hardirq.h>
 #include <asm/io.h>
+#include <asm/posted_intr.h>
 
 #define ARCH_APICTIMER_STOPS_ON_C3	1
 
@@ -508,7 +509,7 @@ static inline bool is_vector_pending(unsigned int vector)
 	if (irr  & (1 << (vector % 32)))
 		return true;
 
-	return false;
+	return pi_pending_this_cpu(vector);
 }
 
 /*
diff --git a/arch/x86/include/asm/posted_intr.h b/arch/x86/include/asm/posted_intr.h
index 6f84f67..de788b4 100644
--- a/arch/x86/include/asm/posted_intr.h
+++ b/arch/x86/include/asm/posted_intr.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef _X86_POSTED_INTR_H
 #define _X86_POSTED_INTR_H
+#include <asm/irq_vectors.h>
 
 #define POSTED_INTR_ON  0
 #define POSTED_INTR_SN  1
@@ -92,8 +93,25 @@ static inline void __pi_clear_sn(struct pi_desc *pi_desc)
 }
 
 #ifdef CONFIG_X86_POSTED_MSI
+/*
+ * Not all external vectors are subject to interrupt remapping, e.g. IOMMU's
+ * own interrupts. Here we do not distinguish them since those vector bits in
+ * PIR will always be zero.
+ */
+static inline bool pi_pending_this_cpu(unsigned int vector)
+{
+	struct pi_desc *pid = this_cpu_ptr(&posted_msi_pi_desc);
+
+	if (WARN_ON_ONCE(vector > NR_VECTORS || vector < FIRST_EXTERNAL_VECTOR))
+		return false;
+
+	return test_bit(vector, (unsigned long *)pid->pir);
+}
+
 extern void intel_posted_msi_init(void);
 #else
+static inline bool pi_pending_this_cpu(unsigned int vector) { return false; }
+
 static inline void intel_posted_msi_init(void) {};
 #endif /* X86_POSTED_MSI */
 

