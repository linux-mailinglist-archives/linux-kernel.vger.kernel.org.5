Return-Path: <linux-kernel+bounces-64302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D721E853CE3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15ECE1C22905
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF1962A02;
	Tue, 13 Feb 2024 21:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3LmvAtsd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W/G5phlw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DF38174F
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 21:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707858361; cv=none; b=PpF+f5aftNVxRuko8ihWhOQhT9Fe5hOKcp0OOMNVwHlfn1ey/IyTDUsjvs6rHLzN3ro3BZeF1HJ7tVp0n1nuHnqv1wFRJSwb3LrXrf31xPyNIARfqzvxVl/Xx+ic3FQJjC/acEJc1eDlJB9eGDsxZnl+rGWPodcD9awomG41FPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707858361; c=relaxed/simple;
	bh=HtpJ3xliOS+lPd3a3JPFOOp0Bo2w5a0wYDFDoURbUEc=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=e/bYG5loZ5CsZnJvGcuH6jKS75OxmdCCOolWQy9ZxihXUQFwlIH2pVX/iPrSt7LIhDYLrZVVxUGfBYHw+8v2I+QYjKs2TPyNuWfRWUpU1LZTog2lS1n6V78PWD9lJTJvnsPucob6LQWwbr6uETjQIL6nj8zTE+jDkTlfPSWnK0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3LmvAtsd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=W/G5phlw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240213210252.462231229@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707858358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=5JJur1G2I1XboqcLYG+3cvwsrYIK9ClOurubWw6N59g=;
	b=3LmvAtsdVeujQdo7UnZ7n3gPd2u6LuvJ12D7j7Q/OAex3Tz20+9lnZ9WOjRmvoOKvzSdBy
	teJdnz7sBDo/GOpIRiwzPeSEa8R+28cvWZAsTxIileQnt3XXMCnrfjQzaEdBmZNmdzKFV6
	4eLEPrVkk5MTOiLmfNJOn+H8zXjsGAjK2rFOTjVT0stpD2xMK8UxecOR0ZaB3fRg/dzI1Z
	yub0+4ismEhZoBPIaWkbe8vUYhGST5vw8XwdUzpSyZy6n1vwvtwqJHoc3Fknc+Ex+y5av9
	TLIe8gh3Eqp+N9OoQqNJAroioOZdEBuMiKYudmjh9fFaNKNB2Rn02xK2BKynCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707858358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=5JJur1G2I1XboqcLYG+3cvwsrYIK9ClOurubWw6N59g=;
	b=W/G5phlwoDRR/PczSSP9ln5sld6ZNCEsiZWpdwtNQOP6KaTMl61YhqjIdobHV0NjUB+dWI
	M/Zg1y/1CmSOt1BQ==
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
Subject: [patch 17/30] x86/cpu/topology: Reject unknown APIC IDs on ACPI
 hotplug
References: <20240213205415.307029033@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 Feb 2024 22:05:57 +0100 (CET)

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
@@ -272,6 +272,10 @@ int topology_hotplug_apic(u32 apic_id, u
 	if (apic_id >= MAX_LOCAL_APIC)
 		return -EINVAL;
 
+	/* Reject if the APIC ID was not registered during enumeration. */
+	if (!test_bit(apic_id, apic_maps[TOPO_SMT_DOMAIN].map))
+		return -ENODEV;
+
 	cpu = topo_lookup_cpuid(apic_id);
 	if (cpu < 0) {
 		if (topo_info.nr_assigned_cpus >= nr_cpu_ids)


