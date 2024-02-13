Return-Path: <linux-kernel+bounces-64309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0A2853CEC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 906511C26B4E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B1A85651;
	Tue, 13 Feb 2024 21:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oPx1XJxS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hmRhfhej"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E82D8527D
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 21:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707858369; cv=none; b=eF5Nm7Kj3oIvvyr4ifqLlsUuSLkkldcSduHWLtddrCb/LUb0T8KSFEWlkXF7Wj4ki/pIcyhndikW7C1JtnlPtaYmxFrQJYnE+RSc9t6BOmjuZD33flFtefn5DJKRhpMezhyvyUROeOg+CLcCEZWdIWkwXKGHohR87fv8wvJGrTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707858369; c=relaxed/simple;
	bh=GELcpW9HVBoRzmyXJvaQUEiRKMX+NhRhw6z94yRJV98=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=ZJoXhSBxUa33Rx6G1hKbJc5fRdFMSzuO5Vh83ZKddrtbRqflvMH0DTA/3dEpwHZKDUikG0rrccSUu9AqPpP1+z1kYFHOnyckSJJC26ksol7BFSgfu2rX/ONEVHl5Yb5R0TwNTqCbU1jUU4/77POZKtfOkGetYqQ+EdTGdhCxeac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oPx1XJxS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hmRhfhej; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240213210252.791176581@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707858366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=h5Fk2rHdvsa9daqL+lfmpiGhGHrHMczyPypdwtxy44M=;
	b=oPx1XJxS1VsEi9t/HVHvfVMWijw/db3doezwnh5CP26KnNRz4mcL+nH+zhg7LlksM40fDM
	Nf8nOn8W5hdxTf0BGzqCof/j6aa5m3z9lv7kpPQS01RAbHUBMhuY5ai1Iy9OXmUk/2PsrQ
	o7s7cHIOv85SM2wY6TDOuaG+4+OT4JjcZFpj5+PKHgsiC1ih1dsie+6mk3gRgYUjmSlHEs
	TcFnSITavX9Ip/wwxAaY2NhkPqR1JxfTrSL+RSiff81gIQ5gP4rW0IuvMR79za2j8bGfLS
	fWAMn3N1fxJZ5m+2fgTpfh/NFZlq6NJ2BmCXVThNn2MK3uKqVey45h89I24TjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707858366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=h5Fk2rHdvsa9daqL+lfmpiGhGHrHMczyPypdwtxy44M=;
	b=hmRhfhejWNIOcYm5dSBmxst5vZzsUvoD3B4sy5hx/yqg361s9+Yuwi8/9NHytueP6Lt2z0
	fM/5cYIra2odj2AQ==
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
Subject: [patch 23/30] x86/cpu/topology: Simplify cpu_mark_primary_thread()
References: <20240213205415.307029033@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 Feb 2024 22:06:06 +0100 (CET)

From: Thomas Gleixner <tglx@linutronix.de>

No point in creating a mask via fls(). smp_num_siblings is guaranteed to be
a power of 2. So just using (smp_num_siblings - 1) has the same effect.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>




---
 arch/x86/kernel/cpu/topology.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)
---

--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -76,10 +76,7 @@ bool arch_match_cpu_phys_id(int cpu, u64
 #ifdef CONFIG_SMP
 static void cpu_mark_primary_thread(unsigned int cpu, unsigned int apicid)
 {
-	/* Isolate the SMT bit(s) in the APICID and check for 0 */
-	u32 mask = (1U << (fls(smp_num_siblings) - 1)) - 1;
-
-	if (smp_num_siblings == 1 || !(apicid & mask))
+	if (!(apicid & (smp_num_siblings - 1)))
 		cpumask_set_cpu(cpu, &__cpu_primary_thread_mask);
 }
 #else




