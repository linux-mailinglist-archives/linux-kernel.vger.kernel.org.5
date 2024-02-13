Return-Path: <linux-kernel+bounces-64258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B22FE853CAD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AAF8B21CCA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5CC6313D;
	Tue, 13 Feb 2024 21:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t58RiYNC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DoF4S/jW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9023E61670
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 21:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707858268; cv=none; b=BFoS4fLtyC6DVQmYQqFt7qI/8D/5UL0fKA9DCVnNlDgo0okI2qvvHy2LyoVYkaOXsMTQGAOuL/Hd/B5gQBjyOmENF0SD9JG1GAutI6T2pU742xICfMiA47gWtIlysVEoUtDZWCwXBSKVndkiZuFW9Pyt7MtesC5JlXWZvyyWbGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707858268; c=relaxed/simple;
	bh=MHLos4OO38TSQH8/H8GP70yEERl2ShArQvc3qykWjEA=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=O6u0xMN9RncxI4RTwHwu7rVJz38QNgE/i9VVhoewqa0aTkru3MYKPXnjS8gYUCafUpb7ynbdLu0FrO8++PFBFdGk85t3dBJzah+3YXi4bUQmlhlX1z5Y1PimWl+bHqyk8qJos4b/nDDQyoaSj9g5r+ibTCqn7JzAz+lFUSvkJoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t58RiYNC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DoF4S/jW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240212153625.576579177@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707858264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=FbuD1O+gIHkW4aafTltcw6F2nn7P77ab8V2DhyeRBhw=;
	b=t58RiYNCtr79SM5idTWisW0tlivueEu2dGa40kVyJkZNm1sMMQxmii1a1Feb1tf62n5hVW
	dDfG9g+NEbc+yhN6Uf4uoDtR7E6dCtseeFEjeNODLpwHLryvwBWINN3CwqBh+J3gx9cRUF
	DVSK/SzWiheQqb0W13ei28cWDQBPIMlpiNvrAR5tANsI78wSXa0XOAgjzZKi01VPmbs8PV
	k7YvW+du8lyIegPZwgLoZEBagSyp+yTZKJKwwygjdUMMEIcwh4MU0wPXkgCVo6kD5z1a1P
	XeMQm4VMg2CQAXj4IbbCQs755Sp00aUTEmB+HZgQwGkJkJ7gdfxi2LY35B6Y1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707858264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=FbuD1O+gIHkW4aafTltcw6F2nn7P77ab8V2DhyeRBhw=;
	b=DoF4S/jW5iwZpkJntMYAQvjj3okcQ4bl5EQ+92ACtXamNVd6hFTrMy27+RqlQUhcHTA7uz
	iWGY9XZmDvnWH5Dg==
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
 Wang Wendy <wendy.wang@intel.com>
Subject: [patch V6 18/19] x86/xen/smp_pv: Remove cpudata fiddling
References: <20240212153109.330805450@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 Feb 2024 22:04:24 +0100 (CET)

From: Thomas Gleixner <tglx@linutronix.de>

The new topology CPUID parser installs already fake topology for XEN/PV,
which ends up with cpuinfo::max_cores = 1.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juergen Gross <jgross@suse.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Wang Wendy <wendy.wang@intel.com>



---
 arch/x86/xen/smp_pv.c |    3 ---
 1 file changed, 3 deletions(-)
---

--- a/arch/x86/xen/smp_pv.c
+++ b/arch/x86/xen/smp_pv.c
@@ -73,7 +73,6 @@ static void cpu_bringup(void)
 	}
 	cpu = smp_processor_id();
 	smp_store_cpu_info(cpu);
-	cpu_data(cpu).x86_max_cores = 1;
 	set_cpu_sibling_map(cpu);
 
 	speculative_store_bypass_ht_init();
@@ -224,8 +223,6 @@ static void __init xen_pv_smp_prepare_cp
 
 	smp_prepare_cpus_common();
 
-	cpu_data(0).x86_max_cores = 1;
-
 	speculative_store_bypass_ht_init();
 
 	xen_pmu_init(0);




