Return-Path: <linux-kernel+bounces-163999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A633C8B76FF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 150611F22636
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0084171E64;
	Tue, 30 Apr 2024 13:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="21FiEKPs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hDx+F4P/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F17171E49;
	Tue, 30 Apr 2024 13:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714483724; cv=none; b=S4zVEvgb3FWBrl+ryvS/T6knlCvCZu90PfBz1/dTBYu3n1sfzE7+VE1R7WpIdsS+IUdw/QOoNZfYXmFH2HXUQ6/Z/1Tnhv4XXFHI2REaFm1zeO27qfFreoo7LR7RYBVa9742iGfSBlXlwfoUs9IspbvtfKulapEG9m9mZOcEWzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714483724; c=relaxed/simple;
	bh=htYB9Po1AVLCw4Jh6B2CAoEV3kz532qWQEyUEtUfCYU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=B2bVvbYOH9zvtSH+qle4mCTWv9fZoh78jVG8XnffFpCmJhe/CZ9JFlUaVxJYyMB3JkVdYZPhN2t/13t+rm+PbPQlOIKlullbvdcMvIYE1UjQ6+ESwlb6BPBdsjegz5YhKtMtckpneNt++CF7KVM+khpsQRpBUeJmQXy4kDSdq8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=21FiEKPs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hDx+F4P/; arc=none smtp.client-ip=193.142.43.55
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
	bh=VZtTmOK9NzEwgaw9REzfC1I3oQmDy6NDfONWezZRQ2w=;
	b=21FiEKPsKasYGAutIgDdYjbl16GGLb60QNjQrLpDm/NijzbTPFaT/yvzNhArM7xEMiM2xo
	N+3ZuzVXNIRlBb41DnmLKA3J7jb2ihiMKVVmubLAqmBdMcV2679JjLDgr0AQ64YVnoPmP+
	T2eGXIhj4BCkkwA/T5x/veKRZ9XMOSNxF+qzkBVb0rN/S7vY2FiiGVD9YzRq+1pJkGL1hM
	7FuNIZQY3+hEn52K0tOJ1H5xeJKiWxr+Ou7eTdFc0tmPC7+trhSe/86frX2Gm90bK6s2hn
	ZkkPnJq7VaQV6c44PbxVtykKO6o4adz1CbFo421aaz/whoMrGZsjeYWm3cH/cA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714483721;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VZtTmOK9NzEwgaw9REzfC1I3oQmDy6NDfONWezZRQ2w=;
	b=hDx+F4P/YBdfsZO3oNUKMJamLKRESPrx8e0vleeMTj7TBp4XCC6zB28UQTZl9Qe5qhlx24
	somgB0fP43M21+CQ==
From: "tip-bot2 for Jacob Pan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/irq] x86/irq: Factor out common code for checking pending
 interrupts
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240423174114.526704-10-jacob.jun.pan@linux.intel.com>
References: <20240423174114.526704-10-jacob.jun.pan@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171448372145.10875.6906928487300074547.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/irq branch of tip:

Commit-ID:     fef05a078b6fa1e9047e0486f1f6daf70664fd12
Gitweb:        https://git.kernel.org/tip/fef05a078b6fa1e9047e0486f1f6daf70664fd12
Author:        Jacob Pan <jacob.jun.pan@linux.intel.com>
AuthorDate:    Tue, 23 Apr 2024 10:41:11 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 30 Apr 2024 00:54:43 +02:00

x86/irq: Factor out common code for checking pending interrupts

Use a common function for checking pending interrupt vector in APIC IRR
instead of duplicated open coding them.

Additional checks for posted MSI vectors can then be contained in this
function.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240423174114.526704-10-jacob.jun.pan@linux.intel.com

---
 arch/x86/include/asm/apic.h   | 11 +++++++++++
 arch/x86/kernel/apic/vector.c |  5 ++---
 arch/x86/kernel/irq.c         |  5 ++---
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index e6ab0cf..50f9781 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -500,6 +500,17 @@ static inline bool lapic_vector_set_in_irr(unsigned int vector)
 	return !!(irr & (1U << (vector % 32)));
 }
 
+static inline bool is_vector_pending(unsigned int vector)
+{
+	unsigned int irr;
+
+	irr = apic_read(APIC_IRR + (vector / 32 * 0x10));
+	if (irr  & (1 << (vector % 32)))
+		return true;
+
+	return false;
+}
+
 /*
  * Warm reset vector position:
  */
diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index 185738c..9eec529 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -965,7 +965,7 @@ static void __vector_cleanup(struct vector_cleanup *cl, bool check_irr)
 	lockdep_assert_held(&vector_lock);
 
 	hlist_for_each_entry_safe(apicd, tmp, &cl->head, clist) {
-		unsigned int irr, vector = apicd->prev_vector;
+		unsigned int vector = apicd->prev_vector;
 
 		/*
 		 * Paranoia: Check if the vector that needs to be cleaned
@@ -979,8 +979,7 @@ static void __vector_cleanup(struct vector_cleanup *cl, bool check_irr)
 		 * fixup_irqs() was just called to scan IRR for set bits and
 		 * forward them to new destination CPUs via IPIs.
 		 */
-		irr = check_irr ? apic_read(APIC_IRR + (vector / 32 * 0x10)) : 0;
-		if (irr & (1U << (vector % 32))) {
+		if (check_irr && is_vector_pending(vector)) {
 			pr_warn_once("Moved interrupt pending in old target APIC %u\n", apicd->irq);
 			rearm = true;
 			continue;
diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index 578e4f6..385e3a5 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -484,7 +484,7 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_posted_msi_notification)
 /* A cpu has been removed from cpu_online_mask.  Reset irq affinities. */
 void fixup_irqs(void)
 {
-	unsigned int irr, vector;
+	unsigned int vector;
 	struct irq_desc *desc;
 	struct irq_data *data;
 	struct irq_chip *chip;
@@ -511,8 +511,7 @@ void fixup_irqs(void)
 		if (IS_ERR_OR_NULL(__this_cpu_read(vector_irq[vector])))
 			continue;
 
-		irr = apic_read(APIC_IRR + (vector / 32 * 0x10));
-		if (irr  & (1 << (vector % 32))) {
+		if (is_vector_pending(vector)) {
 			desc = __this_cpu_read(vector_irq[vector]);
 
 			raw_spin_lock(&desc->lock);

