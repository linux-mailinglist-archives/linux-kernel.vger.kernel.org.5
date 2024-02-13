Return-Path: <linux-kernel+bounces-64267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 093A2853CB7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86920B25379
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9BB69D3A;
	Tue, 13 Feb 2024 21:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fWMxfEMQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="STKLtlXW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109B369D01
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 21:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707858302; cv=none; b=QTmdvf1fIHc/vdI0IVQRPYfNSFsA1zXEP2mpZo1gZPSv8PpQkt2uECpUXZ7alZMM83Y7AZ6KLa4WXbijgX22bkrPqn4vIM/Pc8c2cQuAJ29YM+8t/xCJ7PapmeYNYS3oI3MUgmM8A6dLu9vX5D0yB98luF/MOyuIZKy+ZvcQi+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707858302; c=relaxed/simple;
	bh=2/Hm6WNmDS/4OY4V9WHX1/j5wrA9UAtsOeWkPcmxqVM=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=oW0kZD/EDWIJzlory4Wieu+ktr9clBGlUL5EaLozOx//F/y0YXb/20RZvhnqcXRXudMuJGcsgbWlg+CoXyqSoUcBmeFNlGgxkb+/z61ZwiV1pINsgHobvBthdywz7M6+le1Xn1ecQbJ9WYCtZBYAEMap6X+zoyDKS7Cl5295Jy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fWMxfEMQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=STKLtlXW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240212154639.181901887@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707858299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=hMiM4L8vp+2japRxi++Ub50/ZfEK7uDmkyG5Cn3W1hU=;
	b=fWMxfEMQIB3Iq4ZGSTNhFHQZg6BCC3sJpSeEKKkYZnMTHZMfQbJAmmhokQH8DkIuvd+b4i
	hjppc7E7CpFBM0S9TY8c5H6wzlgIsAhJ2ZGntqI5W+FrsCNU+Ju/+EkLwd5FkZmelhQj0s
	RSZ1qHI4pT6yviPr3KQCiYknQWQQt5FuH0DVY84BDxTy2izbXD3abcgtHhLe3kInN+wd1H
	4kW3UIrEdwxlBJvRoh1Qdjd4A+N0i+HLpY2fc/JBxcYWmUiGZ8Mk46lIGdHDuvOdn+bO57
	0D7338GApqje6TqfK7omYPr4ZarUWiBzlrO2z8mvT5RWwzb4Y5T7lAV9Npfyug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707858299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=hMiM4L8vp+2japRxi++Ub50/ZfEK7uDmkyG5Cn3W1hU=;
	b=STKLtlXWkjx+CrERra5QBIKVBKtYeOU8jSjeuYfwIcpfW9T7MBXEHO+v9UWKS6SC5/tCRJ
	8WIjIEyCOxM3oCBg==
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
Subject: [patch V3 06/22] x86/ioapic: Simplify
 setup_ioapic_ids_from_mpc_nocheck()
References: <20240212154529.402604963@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 Feb 2024 22:04:59 +0100 (CET)

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


