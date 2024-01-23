Return-Path: <linux-kernel+bounces-35353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F36838FA4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA0D5290474
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD9D634E6;
	Tue, 23 Jan 2024 13:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MszRmXb2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IQQ0pc+Q"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944CC63401
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 13:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706015470; cv=none; b=PwDNvZTqVKjbvxJlwEK8cvvGSECUOE8uStrX5HdYAEDmShvCrZPJ1ktssKb+gbnm4/kdmYG5yo1ABQ66hN7GLtHxnlVvogntabvEtE3/YAV2LJLDe2n70Gvs/GGu4QeUr6GeY4y3H3OegP+gr1KJcYRYbsn8qshtrPgXRScW0So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706015470; c=relaxed/simple;
	bh=phOYHJ76E4I6vwQrTIgrpWe8GD2hxqhRgGaMg8x5m2E=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=K7F6/7M5Le8u4+vA2YHUw1Mw0ZyQm8VOEVBJvPi/bb0taoNEuw8jaPkBOt+MQDGVQvbUNPIWbbsz7i20drY/dUuFOq4Ys0wtjh4VcBtOiU5+7Hmgnxp1MLhlwHRHp4sOOg6Zcnm52qXSadddMH9mDCU/7HUyxwsAPu3swZ8FULI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MszRmXb2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IQQ0pc+Q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240118123649.118318548@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706015467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=qx32kyDtRKstD9WHlYmov4Q45bwh6UDL0oPjSY28LYw=;
	b=MszRmXb2yTQVziYuG8JrgerlYF09g2fVHQl0X/7OGYsjdT3eK8qh8oLxl91oNJgndOx16J
	slBH1q/Z4YaUR4GpNoXmheORA2tKxxFRhwTxbH4zc3dNo1d+72R/i27k6gkSjUdrPW8vrV
	R70tTywAwgAXvAOmXfhRffAuehIaZUU+6dqQ2opt0Ey7nweYlvJPxjKxTmbYMbSCHF7lZ2
	YC2gSpfajVhnUb7BTBMo9eBjX0/e1fUIJmXqWifTYceiYkRhujv0qUXNQQz2fv3JrijfrD
	KYuJXiRUa6ydO8n4w2OzUqbIJnlZiJ3c5+arNvS9KxWsYn3pH59TE/uzopFvfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706015467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=qx32kyDtRKstD9WHlYmov4Q45bwh6UDL0oPjSY28LYw=;
	b=IQQ0pc+Qie5mK9Dtosi7LQmXLIblUEKS8N2BtexgzhEnCpYrBvzfscrGWbaRJfyOwcs+et
	mwo5XspV5ATNU7Cg==
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
 "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [patch v2 10/30] x86/cpu/topology: Simplify APIC registration
References: <20240118123127.055361964@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jan 2024 14:11:06 +0100 (CET)

From: Thomas Gleixner <tglx@linutronix.de>

Having the same check whether the number of assigned CPUs has reached the
nr_cpu_ids limit twice in the same code path is pointless. Repeating the
information that CPUs are ignored over and over is also pointless noise.

Remove the redundant check and reduce the noise by using a pr_warn_once().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/x86/kernel/cpu/topology.c |   23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)
---
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -107,14 +107,6 @@ static int allocate_logical_cpuid(u32 ap
 	if (cpu >= 0)
 		return cpu;
 
-	/* Allocate a new cpuid. */
-	if (nr_logical_cpuids >= nr_cpu_ids) {
-		WARN_ONCE(1, "APIC: NR_CPUS/possible_cpus limit of %u reached. "
-			     "Processor %d/0x%x and the rest are ignored.\n",
-			     nr_cpu_ids, nr_logical_cpuids, apic_id);
-		return -EINVAL;
-	}
-
 	cpuid_to_apicid[nr_logical_cpuids] = apic_id;
 	return nr_logical_cpuids++;
 }
@@ -135,7 +127,7 @@ static void cpu_update_apic(int cpu, u32
 
 static int generic_processor_info(int apicid)
 {
-	int cpu, max = nr_cpu_ids;
+	int cpu;
 
 	/* The boot CPU must be set before MADT/MPTABLE parsing happens */
 	if (cpuid_to_apicid[0] == BAD_APICID)
@@ -155,21 +147,12 @@ static int generic_processor_info(int ap
 	}
 
 	if (num_processors >= nr_cpu_ids) {
-		int thiscpu = max + disabled_cpus;
-
-		pr_warn("APIC: NR_CPUS/possible_cpus limit of %i reached. "
-			"Processor %d/0x%x ignored.\n", max, thiscpu, apicid);
-
+		pr_warn_once("APIC: CPU limit of %d reached. Ignoring further CPUs\n", nr_cpu_ids);
 		disabled_cpus++;
-		return -EINVAL;
+		return -ENOSPC;
 	}
 
 	cpu = allocate_logical_cpuid(apicid);
-	if (cpu < 0) {
-		disabled_cpus++;
-		return -EINVAL;
-	}
-
 	cpu_update_apic(cpu, apicid);
 	return cpu;
 }


