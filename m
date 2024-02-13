Return-Path: <linux-kernel+bounces-64255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C210853CA9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E6381C2334E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABFD64CCE;
	Tue, 13 Feb 2024 21:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4mQghn4F";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+pFd1e9u"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E76F63503
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 21:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707858265; cv=none; b=irff4kWAn9iTLf6lNcDdIJqc8bB8db3izggwyLe/rPPcA9ixOleaTpYKjKPU9jB6/QIKx02TbH9cJ/5Sf8bHIE8Fq1N4rJRcGWJL7iclUVFh1gFEEIR+LDQ2Ddv7W8bKIEHrVBxRIDQDNXLsz4+wGUwB42muvLLHrERkaovqMco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707858265; c=relaxed/simple;
	bh=KeVaRxrd+1VnlrIKPqjQTf5GNEbOYdlOBK+vVw3i4oM=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=IS3QTSKwKv267zOaF1wO2garSou9qsgOSI8bjBbRyPsQcE0FSHAQ7YW3C+l9iRCCoy485iVFFglkHMSDH6X9Oy3+G3Pmw5rt3/cP+YLZF3SnwgnszhC4DaEbhtRiMK3EGlUt0FZ8p+PBy2y7fE4cDtXjoQHkegMn2RpKZrF0+z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4mQghn4F; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+pFd1e9u; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240212153625.455839743@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707858262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=gjIik2cmSvIgUfGoJ8nG4wzMs+KedY4PscV07KbyxDs=;
	b=4mQghn4FLpTS6UiY6UD4mggsm5EumrF6tL0XgmzumsL55RL5BmHGVgTRQa2savYJ5PDkUs
	l40NWJqqjnn+5IzuzEVN0FqkF/TrFnOVf3QfxdYstG1INU14PL7ey65Cp22Dyl3TzQRO9L
	3W86j9FwN/qvKTGpojI6ml3NqKRwR3sgSz//dEpTWfl6Ky7SFZxmkePipk7/Q8xvgxCHa5
	LwkGNJLOY4gy4E3kqRv7EW3k42PosesU0c5LoZ4izegZDm23swUAKOBPqDV66KMg4gSQyJ
	skN6KfoTU1+2cq2HtKp5m071Na0UeBfODdtxJ72ZyUuE2Y+tynMU0iwt847Wmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707858262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=gjIik2cmSvIgUfGoJ8nG4wzMs+KedY4PscV07KbyxDs=;
	b=+pFd1e9u40ja63l9U730C6vSm3t2KWyZg8P9lA627fv7hCIeiC2uZIiERY/hhBGkyWYCfF
	E2gZzgt+xUmbs1DQ==
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
Subject: [patch V6 16/19] x86/cpu: Remove x86_coreid_bits
References: <20240212153109.330805450@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 Feb 2024 22:04:21 +0100 (CET)

From: Thomas Gleixner <tglx@linutronix.de>

No more users.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juergen Gross <jgross@suse.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Wang Wendy <wendy.wang@intel.com>



---
 arch/x86/include/asm/processor.h |    2 --
 arch/x86/kernel/cpu/common.c     |    1 -
 2 files changed, 3 deletions(-)
---

--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -122,8 +122,6 @@ struct cpuinfo_x86 {
 #endif
 	__u8			x86_virt_bits;
 	__u8			x86_phys_bits;
-	/* CPUID returned core id bits: */
-	__u8			x86_coreid_bits;
 	/* Max extended CPUID function supported: */
 	__u32			extended_cpuid_level;
 	/* Maximum supported CPUID level, -1=no CPUID: */
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1752,7 +1752,6 @@ static void identify_cpu(struct cpuinfo_
 	c->x86_vendor_id[0] = '\0'; /* Unset */
 	c->x86_model_id[0] = '\0';  /* Unset */
 	c->x86_max_cores = 1;
-	c->x86_coreid_bits = 0;
 #ifdef CONFIG_X86_64
 	c->x86_clflush_size = 64;
 	c->x86_phys_bits = 36;




