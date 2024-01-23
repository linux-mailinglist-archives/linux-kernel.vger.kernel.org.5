Return-Path: <linux-kernel+bounces-35332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F3C838F87
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 506B91F2B444
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A8F605CA;
	Tue, 23 Jan 2024 13:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nicLpavX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+MhYYeAq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD1A605A7
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 13:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706015428; cv=none; b=Tm0BNQknCvVCcegOaGt6W4XpnCQ8oSrs1WuRJ9vCFVXGuZxUFVEOO04LoBRa1az5jnYY98snaDuvjPcWOgQp2GEwSaxPXGZToIGOIAF6or959bg2hABHuIp5/1qXfr0yb6wBZ2/plPSF1oLQsT8DLnj1R3QoZo5e0JDvddouXts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706015428; c=relaxed/simple;
	bh=4SzEPAjNVqgbi1oVUk4ULEOFi5PUd5ExYotlrwczmes=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=ajkhnU8RO/H/DGgxiz3GQBI8MNNVaupGe8e6D+fEYHRQIZgpcCP3JPmGsvA2U34P/yrINSVDeanzbmjft36M1yoUtTLnlu4YdVJMPgE1FjcGq88lgdwWWOyKv+SBE+Wk9FPF50Gwnxhr5DhR7RlChe/v4pNPCb8l9DYCcajIvOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nicLpavX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+MhYYeAq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240117124903.184595817@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706015424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=FBlT5X6p8mU5KNqg94BoSVbLftsUff31uiC3bWBKvBA=;
	b=nicLpavXn2FDQYRA26mYIyPKZBtTqUd+3wg1F5GWJiA+GcdsiYpUYFYo+R+g3cXoh0tqQC
	NU7Rnj5IzihLureVRYbwTiY9syBGg+v9eSonfzuBsWQgOjrwC/dh2rNu5xiFj9eABYjLjU
	cYoR2IW7RwZWWCXUG4s9S5xtNgBuDmHfJIAG+n4c0IBL7KBVuq9oBmfV2vKIpwH1Cpb72B
	6ftNoOOSSgl7fGig8hJW1+4tKUxoCs1snF/qkSPIFq9vxTSvlOn2dnW8VlV4Ni+7IVoMLk
	FyJCbesXE7yIRYk/CypiiGjlPHJKv9wwJ64CUT9erlYV113VTgQbZMXW0g9UbQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706015424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=FBlT5X6p8mU5KNqg94BoSVbLftsUff31uiC3bWBKvBA=;
	b=+MhYYeAqQi8+uBgqQvusfNfyUm5R/f9r2+lFrqu+BbfjWqfn5380Opm2cXrjwFgruqZw3O
	7jttVWCTL1z5w0Bg==
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
Subject: [patch V2 13/22] x86/platform/intel-mid: Prepare for separate mpparse
 callbacks
References: <20240117124704.044462658@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jan 2024 14:10:23 +0100 (CET)

From: Thomas Gleixner <tglx@linutronix.de>

Initialize the split SMP configuration callbacks with NOOPs as MID is
strictly ACPI only.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>

---
 arch/x86/platform/intel-mid/intel-mid.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)
---
--- a/arch/x86/platform/intel-mid/intel-mid.c
+++ b/arch/x86/platform/intel-mid/intel-mid.c
@@ -118,7 +118,9 @@ void __init x86_intel_mid_early_setup(vo
 	machine_ops.emergency_restart  = intel_mid_reboot;
 
 	/* Avoid searching for BIOS MP tables */
-	x86_init.mpparse.find_mptable = x86_init_noop;
-	x86_init.mpparse.get_smp_config = x86_init_uint_noop;
+	x86_init.mpparse.find_mptable		= x86_init_noop;
+	x86_init.mpparse.early_parse_smp_cfg	= x86_init_noop;
+	x86_init.mpparse.parse_smp_cfg		= x86_init_noop;
+	x86_init.mpparse.get_smp_config		= x86_init_uint_noop;
 	set_bit(MP_BUS_ISA, mp_bus_not_pci);
 }


