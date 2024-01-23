Return-Path: <linux-kernel+bounces-35360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 749A3838FAB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B8071F222CA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD51B651B5;
	Tue, 23 Jan 2024 13:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rMqAeOL8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QwHll0Gi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0FF64CEE
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 13:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706015481; cv=none; b=U4dBm2qc+be6Bz/1JeVe4G4IZpce1ODgZsRHaJN4njHl5sZyyrL/7FwDvnlzvEwaCDWfo3T91yS9qPF941TSdb1HrvcelzK5niKM/8eYjg/zptqwJQwxPjgULUalzIrKIziNnA6fU+SWcwQDco1s6pnN7jgo2fLI7fIOttPUHso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706015481; c=relaxed/simple;
	bh=r5AGb/XQ+lkMk/28b6KQQlUOwH5R5IM2l6YzETADWPk=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=sOvUzrBauSZM2XcqKz8xvgHYVYJ4tpp7txJBrxFVXUp4AyUM+0Oez/K6lllhPbWpscMM7hQvSc/KjCXqsIcOjxzNyp8Sj6rwCXRNVIq6KI0Q6mHNSPFTEo9QrRbe7J88RVBYC5ZBrGnK15gVPErDXrbedZLPRNX8CxrCHVqxTJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rMqAeOL8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QwHll0Gi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240118123649.513878058@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706015478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=AL6rtCpTcNHRwvmkB9lH73XsGA1kAtoRIuLTc7Fw7rE=;
	b=rMqAeOL8SfoskRhVnzzZ1cgGVKKHEy8/LjTFzaZoz/fPvYB43MMg84vcWq6nK+lgOyqL9L
	GG8IfX33+gpg2N/Hs/ZDmMe7kXAfPBsBUZiO0eVzhlpNmDeLYvGc7RfK19cGQjqGB+U4Qo
	//vhaLKF+OTuYmSpur0IcWJRGqpUwsLk9XuSHzLh3TvlibBeYWg94Vb9wF77FX4kXBSArN
	gDFmfu7707rducLbdtEdxKqVun2X9Lbu3jcmI/gNBh2/0dKCucm+H5ryLF2A8KuEHJMDgq
	8XHpv0/ueVjniKnXbLOuJHaO7tV/3nJdwqTsFf3PzyTCDpo3+dlIOCpG4s/0GA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706015478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=AL6rtCpTcNHRwvmkB9lH73XsGA1kAtoRIuLTc7Fw7rE=;
	b=QwHll0GiP2lanU8HeZcYPYuEpVbvjY7KofnkML6uapGHzV9/Wi5oW+JP41OoJnOWLPJwyw
	Vhoe8kGyemadi0Cw==
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
Subject: [patch v2 17/30] x86/cpu/topology: Reject unknown APIC IDs on ACPI
 hotplug
References: <20240118123127.055361964@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jan 2024 14:11:17 +0100 (CET)

From: Thomas Gleixner <tglx@linutronix.de>

The topology bitmaps track all possible APIC IDs which have been registered
during enumeration. As sizing and further topology information is going to
be derived from these bitmaps, reject attempts to hotplug an APIC ID which
was not registered during enumeration.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/x86/kernel/cpu/topology.c |    4 ++++
 1 file changed, 4 insertions(+)
---
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -266,6 +266,10 @@ int topology_hotplug_apic(u32 apic_id, u
 	if (apic_id >= MAX_LOCAL_APIC)
 		return -EINVAL;
 
+	/* Reject if the APIC ID was not registered during enumeration. */
+	if (!test_bit(apic_id, apic_maps[TOPO_SMT_DOMAIN].map))
+		return -ENODEV;
+
 	cpu = topo_lookup_cpuid(apic_id);
 	if (cpu < 0) {
 		if (topo_info.nr_assigned_cpus >= nr_cpu_ids)


