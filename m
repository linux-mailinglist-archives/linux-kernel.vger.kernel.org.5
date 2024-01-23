Return-Path: <linux-kernel+bounces-35323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B39838F78
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D08B1C2828B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D42A5FB9F;
	Tue, 23 Jan 2024 13:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jDM/Xo1l";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BiObWCwT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF545F879
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 13:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706015414; cv=none; b=rnwGXVPUMHeS6u79ZpFV7hEM/vgUzU71HtWrqE4uYDuDqCZ+3iB3OUDuSc62McXOWADsC0mA5Vh9uFOplCC0PpSUx7JTLudAs1rNswmz1Tl5oSEy/6SpDs75+SdbgmocvK/hEUhBr/fR7OFlqw5de2B8AvK3qmwUnc5AG5OZnOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706015414; c=relaxed/simple;
	bh=6iYrV5kE0W8IWuX9D1t1C6ivrwc/Qq1iJDp6nfI+7yI=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=CYchlKqBZJzD4yVVNaf0LGil5AHeMDnfP/D8TieB+HAwun034ooPVMeqrp8ARFxnyXqYp3MUu6vu2GLGfPferHvYWlBGvN/rogVOm8oED23wZB31YRJZwuUNtwrx/k1BzNx4kWGlDhF6rGWgyLTYv+2b6nF31G6Eajp0KJ5drAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jDM/Xo1l; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BiObWCwT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240117124902.666403054@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706015411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=B4fO+Avr/2cezLBi0ltchXH11xyDMUsd7pqC2XoBFvg=;
	b=jDM/Xo1l7mx6ry1Lk6PjfxMwJSHgqeLkoDP9z78Olt7zfPtPCezieYOL4nIQfLSRxSf7lQ
	Va2dXhXOfXf2xMWn6J8ZzpdyeNj3WDsa67jbkGEQv6yLSub7wQ0xswfmAhzO0ccVhY6VgD
	f9pTFAawBlwly9dsJJMh7YTcSG9OLm79RC/KTbHra/ZD2uo94nP0DrJ7+pukgrxS8pfz17
	5HJFymH2Pb7Bv7ouA62n4d7Zitr91Q64Bui8mUUzZ40CdxVeMWn9fdd0Y5xq5OnqKL1clM
	x/zUlsttXkQlcVRBdy1Mci01RUT5jk/nDD079ngc5Gbk4YXHbFwWyWJehsGlgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706015411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=B4fO+Avr/2cezLBi0ltchXH11xyDMUsd7pqC2XoBFvg=;
	b=BiObWCwTx5eb7VJX0ChRdhfre5315b+uwou8IRFItl/wfQ2Pn0AwBB1EavLY69i4fzoha5
	S8ao39gbI4KAj/Ag==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 Arjan van de Ven <arjan@linux.intel.com>,
 Huang Rui <ray.huang@amd.com>,
 Juergen Gross <jgross@suse.com>,
 Dimitri Sivanich <dimitri.sivanich@hpe.com>,
 Sohil Mehta <sohil.mehta@intel.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Kan Liang <kan.liang@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Feng Tang <feng.tang@intel.com>,
 Andy Shevchenko <andy@infradead.org>,
 Michael Kelley <mhklinux@outlook.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 Wei Liu <wei.liu@kernel.org>
Subject: [patch V2 05/22] x86/ioapic: Make io_apic_get_unique_id() simpler
References: <20240117124704.044462658@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jan 2024 14:10:10 +0100 (CET)

From: Thomas Gleixner <tglx@linutronix.de>

No need to go through APIC callbacks. It's already established that this is
an ancient APIC. So just copy the present mask and use the direct physid*
functions all over the place.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/x86/kernel/apic/io_apic.c |   22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)
---
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -2498,17 +2498,9 @@ static int io_apic_get_unique_id(int ioa
 	unsigned long flags;
 	int i = 0;
 
-	/*
-	 * The P4 platform supports up to 256 APIC IDs on two separate APIC
-	 * buses (one for LAPICs, one for IOAPICs), where predecessors only
-	 * supports up to 16 on one shared APIC bus.
-	 *
-	 * TBD: Expand LAPIC/IOAPIC support on P4-class systems to take full
-	 *      advantage of new APIC bus architecture.
-	 */
-
+	/* Initialize the ID map */
 	if (physids_empty(apic_id_map))
-		apic->ioapic_phys_id_map(&phys_cpu_present_map, &apic_id_map);
+		apic_id_map = phys_cpu_present_map;
 
 	raw_spin_lock_irqsave(&ioapic_lock, flags);
 	reg_00.raw = io_apic_read(ioapic, 0);
@@ -2520,14 +2512,10 @@ static int io_apic_get_unique_id(int ioa
 		apic_id = reg_00.bits.ID;
 	}
 
-	/*
-	 * Every APIC in a system must have a unique ID or we get lots of nice
-	 * 'stuck on smp_invalidate_needed IPI wait' messages.
-	 */
-	if (apic->check_apicid_used(&apic_id_map, apic_id)) {
-
+	/* Every APIC in a system must have a unique ID */
+	if (physid_isset(apic_id, apic_id_map)) {
 		for (i = 0; i < broadcast_id; i++) {
-			if (!apic->check_apicid_used(&apic_id_map, i))
+			if (!physid_isset(i, apic_id_map))
 				break;
 		}
 


