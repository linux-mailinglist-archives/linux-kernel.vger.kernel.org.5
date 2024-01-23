Return-Path: <linux-kernel+bounces-35283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24834838EFA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADF3B28CD7E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 12:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8DC6089E;
	Tue, 23 Jan 2024 12:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C5n09rJ6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YUY3vMse"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD4660882
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 12:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706014443; cv=none; b=BpVnSskYjCOijg/tLJ7JTGQPpwnJn0st7HOUMzY/p5Q157VcI9LOduWgi3cRwWGiWesrdA5yVTya7T8rDB8dw0hjqtJpHOv/PJKwRFd7fvwwajQxEybHxRPTMuYgJgkOoCM44DU1NGxG1VezNXGTJGOs8rbfzYmgVk6WJiRvAL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706014443; c=relaxed/simple;
	bh=hNdvmf+GcuI6Qqrr7dcRGCr10KX039mF7IbsepcDHes=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=bDhKw8m+tSTvCRPg9v/gcJbmOnE3OZTZ5ylTo3W/bGk5xfckAR12z1R1daZCVPJiO6bOncUgkrcso4dDN+o1YbqJJ3eeMEXomqNkcGcaGXVSvuQeh2xe4DJHwm70j9BVqN+Ch+PJ9ysjDN++MozYcgj9G1cu4bRW+K3WkbGe1+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C5n09rJ6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YUY3vMse; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240117115909.467809167@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706014439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=XBJ9whjiLYJSa7ZVPKMljupzMZu9OX7b/3pvXVcku2Q=;
	b=C5n09rJ6TShguJq64ARFuRgYtLsXNMI/HVK8w1uK+Med+S7lGFPBraObsnzKSR5tBDjXwR
	Ix2reEM7SLB1Z1pzL72NGheje+n3PnqGxg4AIPpdM5CPbpdysr98hcZg0n/anpSCXm1IgR
	rx8gQ03aSr2x96Z8211Gaty8S5hgeQRQBKGfGodas79jHIDJECIf/RQNfVkc5lQPpDZWT+
	K7IB7QCQ3aLEENPvBANZRZ9/oPuPk9cBH/KK2JTXh0GfMgLPIFK3YrfB0ZZGR/N0BGRSwS
	I5hzVMmXzI+6mrkXL1a/rvF0/vo7v3MVO8Tt7Tk12bQAw8MlGZzvE+j6us5z8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706014439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=XBJ9whjiLYJSa7ZVPKMljupzMZu9OX7b/3pvXVcku2Q=;
	b=YUY3vMseFJsvX0EoWf52T960x8+5L5Kgr2LDt9dHOVpR3uYaxqsiu6cqe3WGKfE2Rivqg2
	ocro2TAnS8FtZsAA==
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
Subject: [patch v5 18/19] x86/xen/smp_pv: Remove cpudata fiddling
References: <20240117115752.863482697@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jan 2024 13:53:58 +0100 (CET)

From: Thomas Gleixner <tglx@linutronix.de>

The new topology CPUID parser installs already fake topology for XEN/PV,
which ends up with cpuinfo::max_cores = 1.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juergen Gross <jgross@suse.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>


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


