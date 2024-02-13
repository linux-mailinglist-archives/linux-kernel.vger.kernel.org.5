Return-Path: <linux-kernel+bounces-64266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F591853CB6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FFA6B265CC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8FE69D1B;
	Tue, 13 Feb 2024 21:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EpQWCPDU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zwzJmjOR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA40692E1
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 21:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707858301; cv=none; b=c2rmRQFHB53EyTBXTuGdd5hA1XRH7hJzy+ndS9/eZ1OzA9wltzKoIu1B9KMA+kArKZGG7KMj3xI9W6u/ro0c8ak99ocfDPQchAZezyzbE0PxWkNJTyN30YQW09tunAcmLpY7z19qF8tuLS0ODbjY2DSSSfLGFoy00eMvEN6O6mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707858301; c=relaxed/simple;
	bh=3S7tYc3YVI4mPW2sr3ZiAQ0I85cBTTIGxfAhE8dJpE8=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=tg+kE6yckUXfUO/8/NhKjQLJocLeyYsSHgBa1c+xEVHtqms+rrHnLHRNqCb/7cz0Kj+DiDndPb62uUkYrcgvSSqAs8bv4W39aB+VXoltOwRwwsbrQGSjD5HDnxvq2RktI5BaMePw6lLRz49KHzsBLqXxUhtfo99/ayfqFSa4W2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EpQWCPDU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zwzJmjOR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240212154639.119261725@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707858298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=haICUt9LrjF7nxtQU8l5bRkX2rhfO5LbZBYhZ3D/9T8=;
	b=EpQWCPDUlnOt3UhzvowTPViGVcLxcaB+M91EqvxnUv/Aov4gY9rAh2INHsPuDl6DoYXMlW
	qW7S2vZd8SZ8RMu7t1IdHmaEL7NtgJJ/F8VIvZA64OAiCJTamtD5gjRdtibYpfSmBJf0B8
	4VwCx1xv/NR38h6SpdhAzmoYNriHUuWA0y77vqUIUPnDFG85n/juENgC0Ew2J2vKNpq7St
	Z/QKG/LEqRKFIHRBjVCodVassOK6pNdfG4t3vrYDz9zozAP6ZP4j4S7v+B377qGWAlJu64
	pUhKPmpoLwq2HXionKVmo3j+Us5wd/bMSldZa6m+lFh/r8kOMLTW1ySI5+Jm3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707858298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=haICUt9LrjF7nxtQU8l5bRkX2rhfO5LbZBYhZ3D/9T8=;
	b=zwzJmjORZVhOZBlMY/12GPGom7oXdqNWjLjs9RNHf/1Tz+Wr8sJl5MJdU+NzUPyMgM+V8I
	MWJ6nzgfbd8gI9AA==
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
Subject: [patch V3 05/22] x86/ioapic: Make io_apic_get_unique_id() simpler
References: <20240212154529.402604963@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 Feb 2024 22:04:57 +0100 (CET)

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
 



