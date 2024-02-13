Return-Path: <linux-kernel+bounces-64295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BF7853CDB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D38B11F22F92
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14837E597;
	Tue, 13 Feb 2024 21:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rUnMeu+f";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ScfTmaep"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66507E101
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 21:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707858351; cv=none; b=s+ezc/zYk4LUrC8x0MlvcR4jJGoEkLzXhXYkA3hMFxyBejOg7qqVzeIlAm5UioP1P8/s9EZZeCBg23g4rCrAG8s02rnXZBoeIhLm31R9Y3H2QrpG9RSr8KYEpX2nGK6dNr+Uc4CBBvuHOG2KVOLKb2gTPt0iIUxoM8c5WBJyDO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707858351; c=relaxed/simple;
	bh=5IeBHR+hi4fg1vQf0hDj/BBesg9OuajUyfYPsFjXYFU=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=u8ifL88kM6CN6ldMq2rR3PvCN9zq20mzmkrVlfpqNVme1vsth65WRkU5W+BOr4d/MFCFjrpiOXCv7brh0b+ZjZ8agIOFqnlixgi241Gtq9KxdAM6148zZkxLCpv0bOdHm+cKv4Ky4eDoTq5LzJ0akovaMEQlQaEEhCNYt0ukdNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rUnMeu+f; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ScfTmaep; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240213210252.050264369@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707858348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=jUfwyP6RwJ+NG2QZotkyjvNHejpXh2HAb8201sP7et4=;
	b=rUnMeu+fJoD6WHPEtzIoDbT+Q7+upy4kbBH0WbmnooP6GGci5od+qh8+N2D7aGHo4cCa++
	b5XRpRdDyciTqqHgVnahQb0DPY7L/7oCbrQ/+nQLglT3kG7H7utX10+hE2uMoT9pIiJLnA
	2E7tLevqaaTZLN3nZ2rV1YxdlQmCgVAtrGRvv7yq5cObWv+xL0L8nXSX9lh49ajWMP80No
	nyKihM0crHv3Qu4Sj4jKFzCjrmfE8FJjMF02naREN4towBXXzf732/h1gVAssdKr6GF26/
	uflasigfWdwyDmtQn2lsXZiEBCo2OGexAy0Yq4HnCqxdIE5aeG3wJt/etIwdeA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707858348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=jUfwyP6RwJ+NG2QZotkyjvNHejpXh2HAb8201sP7et4=;
	b=ScfTmaepVt/4T1ejBLyvwXVZ/G3LTfMnyRBYEAz1MwLutCpveJtl/dbZkJVaqOMS6djW4W
	ZsjpJa97acQ2ITCA==
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
Subject: [patch 10/30] x86/cpu/topology: Simplify APIC registration
References: <20240213205415.307029033@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 Feb 2024 22:05:47 +0100 (CET)

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




