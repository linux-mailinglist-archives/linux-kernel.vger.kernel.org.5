Return-Path: <linux-kernel+bounces-35324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EDBB838F7A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 251C11F278BE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38335FDAF;
	Tue, 23 Jan 2024 13:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2lZmAzXn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s85y0fnB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92355FBA1
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 13:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706015416; cv=none; b=gqm9ddA4xvuRtetY2dq7kuh84zX+G8z//+LFIlDn+KciqJBaPw438BfakqJNjH+2QyeFunemPqq0lxFjW/Pg2qtycHaFqA05no+xcbrK0t2O9zoT//Snt72VKs1g7NiDoMK1LO5RRQK6dqWUsZV281b6XcNJR4gmerzfIsz7M4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706015416; c=relaxed/simple;
	bh=9mpthBeL7kUUAZ6hCPKnLP++2Jl+7CeApq/qTLrJ6qA=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=axvvGlDp9Le3l5+L8fZ/28axkHjZB8HD3Dk3UPjkfYHd4UJ3f75xgeTT+hsYONfDajYROwYYeLTsIiebHley+5u5IB1H76ZfgQqEH5U8aPKaaOLhs+irDhLGjjFcj41QAc1V+90PerBn7LSBGYiY6RQlKWaZsdVsAB2/ksluMtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2lZmAzXn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s85y0fnB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240117124902.731270121@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706015412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=NQJOd3I1iF0ZpOogq0e/ZOVhSfa0r+gOFKVceHNfGXE=;
	b=2lZmAzXnBXA7Fmk2fCfFlxnzJXzYcHxnR1Jf+SssQzFy/hZe90uZzuhqqRArPF28EC5mlY
	yGxSNs5ELRv9BSDLgtmRNbZAuSi1SpjWv2FXIlcUh869DYf+G1Tt1y4FgfhGvaZhTb0i4z
	zwRa70UjqohgXjjdfNPqZ+QkmD9bWa1sORLvL0HCcxsGV2k0CiIVeMAXc1rsXFnAGatf1H
	zc5rfqkgjbLkyGess2D7HfRSsPgt/vfXszgGsCHWRDrZgJ7ixz2NlZB1iqRdoIbMTxoe2O
	VvPdR9+F+PlSy1zeyoLz0rNHwB6HaF671LwBCWEOsFQXCRYo0hfo79BH1iOZ6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706015412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=NQJOd3I1iF0ZpOogq0e/ZOVhSfa0r+gOFKVceHNfGXE=;
	b=s85y0fnBTrbfotgHadGQWMRc7DMde2fLELme1l2w/HY425E7/3uDyh02nKNlUIwMOOuq4r
	3G1kAgKlRxil7DAg==
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
Subject: [patch V2 06/22] x86/ioapic: Simplify
 setup_ioapic_ids_from_mpc_nocheck()
References: <20240117124704.044462658@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jan 2024 14:10:11 +0100 (CET)

From: Thomas Gleixner <tglx@linutronix.de>

No need to go through APIC callbacks. It's already established that this is
an ancient APIC. So just copy the present mask and use the direct physid*
functions all over the place.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/x86/kernel/apic/io_apic.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)
---
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -1471,7 +1471,7 @@ static void __init setup_ioapic_ids_from
 	 * This is broken; anything with a real cpu count has to
 	 * circumvent this idiocy regardless.
 	 */
-	apic->ioapic_phys_id_map(&phys_cpu_present_map, &phys_id_present_map);
+	phys_id_present_map = phys_cpu_present_map;
 
 	/*
 	 * Set the IOAPIC ID to the value stored in the MPC table.
@@ -1496,8 +1496,7 @@ static void __init setup_ioapic_ids_from
 		 * system must have a unique ID or we get lots of nice
 		 * 'stuck on smp_invalidate_needed IPI wait' messages.
 		 */
-		if (apic->check_apicid_used(&phys_id_present_map,
-					    mpc_ioapic_id(ioapic_idx))) {
+		if (physid_isset(mpc_ioapic_id(ioapic_idx), phys_id_present_map)) {
 			pr_err(FW_BUG "IO-APIC#%d ID %d is already used!...\n",
 				ioapic_idx, mpc_ioapic_id(ioapic_idx));
 			for (i = 0; i < broadcast_id; i++)


