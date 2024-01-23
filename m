Return-Path: <linux-kernel+bounces-35335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DAF4838F8A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7064A1C281AA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A445860277;
	Tue, 23 Jan 2024 13:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rzqvNDRB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xKcB1ryR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B606087D
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 13:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706015433; cv=none; b=Cc3iXNBTRlJVYplEtCwBjaXruZ1aJD0i0Ja0hyrMKiqdiVvSB65McR8TvwWDuQIcsFTeYAfncOCw3Gq3umJhMQVQX5asnMD26nTf3FEJSMv765aJ8grtHwK4JjWegrGomp4a2a/rVjvjFMREC/aRQrVNvCMesHWVudmYVqyYF+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706015433; c=relaxed/simple;
	bh=it2LjPraTJJ5CF/x0aPGOm+PhacKRRdsCsOrLlaSUSw=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=bU71hWaRKbVnj2QDSPuM8q9/Z2O0Nvsm1m7S7L35KcwPyfsTfCH7yDoK8dQEZvV0Q4gXLeo1fYirTyv3hHhDAlxXkKlXXET1lUX7l1OWMGri6B3bU1p31nQPgZf0PycSaysaZthlGgIkWAzKtAoCLFQETWC3tkA0biGSzi/i414=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rzqvNDRB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xKcB1ryR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240117124903.373706090@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706015429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=TBfNjU4bRapJI6G71fRj5qBiI9axYldkNHvzZK2EV/U=;
	b=rzqvNDRBWWYXLopz3OU3KtPugTSjpsGXti0vDXfldpsqyRHjsoyfQ4/+byJ+N0zWs2tU3w
	zqyed0rgAjSiZEOeRiuZGqmhl68wKB6lP274VHZLMbItZYbnab4l009ZhGOD2EkDaw8/eR
	fAYDrebG1iQGv1CoMXjSw0AmN66g20un2/xJ5cQQDZODPecWHML1TeJdzhEnkr7M5oR02j
	HaLKgeMxtzXK+Cg4sQ2iDchH937hqj2lgApARHsJZ5RCxS+dkcr+Y37DMwI4e9UoDRjsdr
	iCnzQPSvvddTsKYxg6Dn6Z9/Eoaz0IlxslIilnYqNX20M/5RRw0bRy6D3FUklA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706015429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=TBfNjU4bRapJI6G71fRj5qBiI9axYldkNHvzZK2EV/U=;
	b=xKcB1ryRtJyh4X+nx9Z56BonS5hnmcaVkmrgXYmvt1RDwYUEI3bW58HMNfNFBlwxAf3ofG
	zMBtqyd5uRZfzlDA==
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
 Wei Liu <wei.liu@kernel.org>,
 Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [patch V2 16/22] x86/hyperv/vtl: Prepare for separate mpparse
 callbacks
References: <20240117124704.044462658@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jan 2024 14:10:28 +0100 (CET)

Initialize the new callbacks in preparation for switching the core code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Wei Liu <wei.liu@kernel.org>
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


