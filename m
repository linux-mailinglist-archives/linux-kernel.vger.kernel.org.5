Return-Path: <linux-kernel+bounces-64277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3F1853CC4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 340281F252AE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15FF77651;
	Tue, 13 Feb 2024 21:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EsT9Z0Vh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="10oVLj5h"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C127691C
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 21:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707858317; cv=none; b=UcxGSl6nt/S65vddD4SVC3OYTvdHawd36xuu60qE6kGxaQJljhsU6fw0lvbH3jJ3jj6kMVEa8CuMo2i6EAjBT54Lst0jcAwlihPDI2GPsBic7Zs93lKcsg6jwyyNXc9Z4SZKo+5aX3bOn9SLRplpM9U4plo02wJVAwgDyJSDcgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707858317; c=relaxed/simple;
	bh=5HSRVk5h3AkWg+lqq7ttEcP7WRyiUHD3Vc0ApyeScBI=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=rQF/WZYn0RIiY0VsjsHYzNNX5B81XnuJSpYwrWNjF0mCYwZ4jE9AJgEbIOY9sg4Yskjy0vBXV8ByNG9WWGZyF9XaNEUPiNL3Fk926WqXVoR6J22rIRbNT5F+J7j0/WgXCkzibTuEu76XicWDhl9ZTAZr59sqqModM5ZgW0LJR/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EsT9Z0Vh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=10oVLj5h; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240212154639.808238769@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707858313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=K89CMORbjEKKY+pUQ0RBLv6Of1M8KhQqpEbF+zotYIo=;
	b=EsT9Z0VhoZ3THyVDW0T0Y3lkX0VOqMuemxxsh94Dxmvh4g0uJKRDAPiAxnmjKOuRJUhpCq
	qNTx/2D7c/GvHQhvXUqdSQ8uf6fdvZBga3AYJ8D0O+Mpj++tM6/2Tdc8D3u5qSS2uCGzIs
	yNUi73/WclEz+/HTinO3du7RnrKmhqVyFeXuI0SSoy04Oi7UKQpdgMFMTOp63gY0Lraqel
	mQ1FD39ws/bAoL0aouLh5MOSr6ps6zZgvD1RLzfdzlDLW8j7oew4FtNub9vhDhvJiFmxOh
	RlBbUZn1nvNVN8jVWsyDi/zJ/Bs8FIiWgYYM8gSfh8sU+A7DdnnBPR1hy+NiZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707858313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=K89CMORbjEKKY+pUQ0RBLv6Of1M8KhQqpEbF+zotYIo=;
	b=10oVLj5hbkN04pOJL2gORds0hxnjAfGlivSFGH1R4tVEvLJ59QLQ/rjiiDqRSr2Whmy22W
	m1WoKYPemjF5JIAA==
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
Subject: [patch V3 16/22] x86/hyperv/vtl: Prepare for separate mpparse
 callbacks
References: <20240212154529.402604963@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 Feb 2024 22:05:13 +0100 (CET)

Initialize the new callbacks in preparation for switching the core code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
V5: New patch
---
 arch/x86/hyperv/hv_vtl.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/arch/x86/hyperv/hv_vtl.c
+++ b/arch/x86/hyperv/hv_vtl.c
@@ -26,7 +26,9 @@ void __init hv_vtl_init_platform(void)
 	x86_init.timers.timer_init = x86_init_noop;
 
 	/* Avoid searching for BIOS MP tables */
-	x86_init.mpparse.find_smp_config = x86_init_noop;
+	x86_init.mpparse.find_mptable = x86_init_noop;
+	x86_init.mpparse.early_parse_smp_cfg = x86_init_noop;
+	x86_init.mpparse.parse_smp_cfg = x86_init_noop;
 	x86_init.mpparse.get_smp_config = x86_init_uint_noop;
 
 	x86_platform.get_wallclock = get_rtc_noop;



