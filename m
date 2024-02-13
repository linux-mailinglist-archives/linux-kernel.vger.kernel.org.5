Return-Path: <linux-kernel+bounces-64275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66071853CC2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 230722854FE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9454D626DA;
	Tue, 13 Feb 2024 21:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uZsom5YM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8sUBr5ij"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE5071B4C
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 21:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707858313; cv=none; b=RfoTEcSdwaH/poJ56qLLHN2uhZ24eCtyYTyBgPR4ZD1jckxDodhS0HErYvgtZTq1nb8MLc53OM0a704GRKJsbO8juoWuj5i61YuB4SGKapHGslfd9G+QSY2yFdkUMw1Fh2EfLSKzlKMU7e9N9Ut+HcsZ/PihhfKq28xeBsJAYgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707858313; c=relaxed/simple;
	bh=8UoXimlIZEV2eh9uv+zpNtLrnTWnYvwIjEWGdn2Rb2E=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=AvBCQrpEuLEm4TtYZmBM8NAKigf+t136sSTune5iirh5EFWZnF7mnh8XausQ7StzpTxNbIjlulFx+AcjLbbOaHVh12BczxeIsQ9YHD4i95nTysHblB1c9qI2kqX/9lAw0ge5XhP5iT8DuDTPk7EAvcupnCpfwVF4YrGJQPtKn9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uZsom5YM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8sUBr5ij; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240212154639.683073662@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707858311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=21XnL3/KpVSRQX9fQR+Ss73/rrljxkqQNbU70H6SdFY=;
	b=uZsom5YMvj6oRMdhpTRQuI761wmJ08YSXX2TwzbaHmTl/NG46b8mHHbCV8KFBJZfGKl5cq
	mIEHZj41WdB+mJjaE49aenH4Annddphpw0LT1PJ12iBl/WCzCugu2EBPMIqaQkJJQ/rioh
	fpkmb0QogNEMesRf1RiS3xDkYnzNmn01cQ9vMnSPDpwYz8GlO3L4VJin7QoSyWnmuuMY0R
	zcj1KjosHA3wX6fc5E5WjlHKt0AeXtEwBG5p8w9XOD8kCQGoi4RK1xdQhZdwuZzyOAyzvJ
	2pMio1KrvGLVii1XZglfLVq6jz8ler6+jMfMUwvVITzziyetLr1xmNwMEfsIhQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707858311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=21XnL3/KpVSRQX9fQR+Ss73/rrljxkqQNbU70H6SdFY=;
	b=8sUBr5ijnUZGU/qNF8O472/7fPvXyDyD+2jquxP6o45wrPLxNMuYZR6Waak3WGb0d+689b
	ex0HGRggY3Pds1DQ==
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
Subject: [patch V3 14/22] x86/jailhouse: Prepare for separate mpparse
 callbacks
References: <20240212154529.402604963@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 Feb 2024 22:05:10 +0100 (CET)

From: Thomas Gleixner <tglx@linutronix.de>

Provide a wrapper around the existing function and fill the new callbacks
in.

No functional change as the new callbacks are not yet operational.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>


---
 arch/x86/kernel/jailhouse.c |   34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)
---

--- a/arch/x86/kernel/jailhouse.c
+++ b/arch/x86/kernel/jailhouse.c
@@ -118,6 +118,11 @@ static void __init jailhouse_get_smp_con
 	}
 }
 
+static void __init jailhouse_parse_smp_config(void)
+{
+	jailhouse_get_smp_config(false);
+}
+
 static void jailhouse_no_restart(void)
 {
 	pr_notice("Jailhouse: Restart not supported, halting\n");
@@ -201,21 +206,24 @@ static void __init jailhouse_init_platfo
 	struct setup_data header;
 	void *mapping;
 
-	x86_init.irqs.pre_vector_init	= x86_init_noop;
-	x86_init.timers.timer_init	= jailhouse_timer_init;
-	x86_init.mpparse.get_smp_config	= jailhouse_get_smp_config;
-	x86_init.pci.arch_init		= jailhouse_pci_arch_init;
-
-	x86_platform.calibrate_cpu	= jailhouse_get_tsc;
-	x86_platform.calibrate_tsc	= jailhouse_get_tsc;
-	x86_platform.get_wallclock	= jailhouse_get_wallclock;
-	x86_platform.legacy.rtc		= 0;
-	x86_platform.legacy.warm_reset	= 0;
-	x86_platform.legacy.i8042	= X86_LEGACY_I8042_PLATFORM_ABSENT;
+	x86_init.irqs.pre_vector_init		= x86_init_noop;
+	x86_init.timers.timer_init		= jailhouse_timer_init;
+	x86_init.mpparse.find_mptable		= x86_init_noop;
+	x86_init.mpparse.early_parse_smp_cfg	= x86_init_noop;
+	x86_init.mpparse.parse_smp_cfg		= jailhouse_parse_smp_config;
+	x86_init.mpparse.get_smp_config		= jailhouse_get_smp_config;
+	x86_init.pci.arch_init			= jailhouse_pci_arch_init;
+
+	x86_platform.calibrate_cpu		= jailhouse_get_tsc;
+	x86_platform.calibrate_tsc		= jailhouse_get_tsc;
+	x86_platform.get_wallclock		= jailhouse_get_wallclock;
+	x86_platform.legacy.rtc			= 0;
+	x86_platform.legacy.warm_reset		= 0;
+	x86_platform.legacy.i8042		= X86_LEGACY_I8042_PLATFORM_ABSENT;
 
-	legacy_pic			= &null_legacy_pic;
+	legacy_pic				= &null_legacy_pic;
 
-	machine_ops.emergency_restart	= jailhouse_no_restart;
+	machine_ops.emergency_restart		= jailhouse_no_restart;
 
 	while (pa_data) {
 		mapping = early_memremap(pa_data, sizeof(header));



