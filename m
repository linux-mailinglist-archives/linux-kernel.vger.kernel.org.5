Return-Path: <linux-kernel+bounces-138666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B9289F8D6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E74841F31D04
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9946F17557C;
	Wed, 10 Apr 2024 13:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ds2HhF/O";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pPR7e7Ap"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7668315EFA3;
	Wed, 10 Apr 2024 13:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712756514; cv=none; b=tnNaUh5CdIPE5zXnQ7BwkTcYPyaaveyjBfBW9go3YCyjyPTluKrdsS6olU5TefPyFIFaS0FVsGyOn9zIoCXgqT2iJtQCwLBn21SEjrl74Eldp4vLw98pnKrkF6aGNk/QsUzE5PppPWZ5B0SZe91eKPMrDOc1U8CblG46ih+T6P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712756514; c=relaxed/simple;
	bh=k0Qt+dqVW0I9SmbX3Vyw6aadORCMxuA/dC1LRykwEp8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=XCIQq7JFudzZyWIe0fhARNSF1BLk7bwXEMXaFb6/SlxlPsh6rw302aROuccNvyZehml4f4tbmrk/pcCT93DQq/HEPfzaizjt+zxtCZasE964ODSgE/pxnBPRNaaPVrW4WCs6pK993qIj0KWAjm7mMrGjdVa7XQd4JZELcpjYBRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ds2HhF/O; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pPR7e7Ap; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 10 Apr 2024 13:41:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712756510;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VQwlVhYmhF3SrAMIiGeLv3H4lt2MnfBP41OInraZ930=;
	b=Ds2HhF/OO/Yqk71aLerKGnbVawKZJg/J1W9ItQWas16Uog51AT8iKLc35VNQSIlWYQvU/b
	lvQa45Mqg3/JImI/t7r79AoeAN6ioTsXeQ9s4FbCrurvBL+GE1etBuy7GPO9TEgfj6nH5D
	abJAAAJoPM0s+JP4wz9Ez2GJC1r6AY1uDFfo2CWJCdZmbTZQN7FCZVtsYFkc/0fsI+zjr/
	GA4/Wsma0tHjpniY7KE0waw8eyUEQSClD0LEhGrqmcifrVsQsbrZ69G6WZlJoovmPYEPJa
	GmVQmlsxWlcarEtk8oYDF7KTjzBZclk5ZP0+kq3IOD0rJjRpC3YNRscuXQZSJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712756510;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VQwlVhYmhF3SrAMIiGeLv3H4lt2MnfBP41OInraZ930=;
	b=pPR7e7ApNu3SbI6Y/cUAy5abpk1t/H5Q9nyS++ZGoUc5iOYaFuvIHYhqjW5chBFzciIB7y
	7MjDEPtq5D+RQHDA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/topology: Don't update cpu_possible_map in
 topo_set_cpuids()
Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <87ttkc6kwx.ffs@tglx>
References: <87ttkc6kwx.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171275650994.10875.9386456375606201211.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     a9025cd1c673a8d6eefc79d911075b8b452eba8f
Gitweb:        https://git.kernel.org/tip/a9025cd1c673a8d6eefc79d911075b8b452eba8f
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 08 Apr 2024 15:22:01 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 10 Apr 2024 15:31:38 +02:00

x86/topology: Don't update cpu_possible_map in topo_set_cpuids()

topo_set_cpuids() updates cpu_present_map and cpu_possible map. It is
invoked during enumeration and "physical hotplug" operations. In the
latter case this results in a kernel crash because cpu_possible_map is
marked read only after init completes.

There is no reason to update cpu_possible_map in that function. During
enumeration cpu_possible_map is not relevant and gets fully initialized
after enumeration completed. On "physical hotplug" the bit is already set
because the kernel allows only CPUs to be plugged which have been
enumerated and associated to a CPU number during early boot.

Remove the bogus update of cpu_possible_map.

Fixes: 0e53e7b656cf ("x86/cpu/topology: Sanitize the APIC admission logic")
Reported-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/87ttkc6kwx.ffs@tglx

---
 arch/x86/kernel/cpu/topology.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index aaca8d2..d17c9b7 100644
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -123,7 +123,6 @@ static void topo_set_cpuids(unsigned int cpu, u32 apic_id, u32 acpi_id)
 	early_per_cpu(x86_cpu_to_apicid, cpu) = apic_id;
 	early_per_cpu(x86_cpu_to_acpiid, cpu) = acpi_id;
 #endif
-	set_cpu_possible(cpu, true);
 	set_cpu_present(cpu, true);
 }
 
@@ -210,7 +209,11 @@ static __init void topo_register_apic(u32 apic_id, u32 acpi_id, bool present)
 		topo_info.nr_disabled_cpus++;
 	}
 
-	/* Register present and possible CPUs in the domain maps */
+	/*
+	 * Register present and possible CPUs in the domain
+	 * maps. cpu_possible_map will be updated in
+	 * topology_init_possible_cpus() after enumeration is done.
+	 */
 	for (dom = TOPO_SMT_DOMAIN; dom < TOPO_MAX_DOMAIN; dom++)
 		set_bit(topo_apicid(apic_id, dom), apic_maps[dom].map);
 }

