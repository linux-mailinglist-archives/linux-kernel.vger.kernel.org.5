Return-Path: <linux-kernel+bounces-35333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1888838F88
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F16F1C27BFC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C2D605CF;
	Tue, 23 Jan 2024 13:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aHMiHWbj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cMq/2BDM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79294605AF
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 13:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706015428; cv=none; b=O1vGOArmxcUUzGiu+NkRlc4MBsm+alZrvNvGF8tV4zKTGaHJmP8qRr1glGPbdTb9Qtl/tPvuYxNsuM75f6HbizMNr8STOr32rJ+MJ8zf2eELy3x8bq6uxBt9piEssYOj/OkGP9bIS88EvHdf6BP3RFLt/WYNkKVDhUvmxRKb34o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706015428; c=relaxed/simple;
	bh=1N4hY2vpYAYJeEUjhjye5q1jYOoL8JwBGpoBUbQpBHA=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=r/FVkFD36DvZNsrNGijTXu1uL3Vx7LonZFSTLI74VfdN73VPiGoGmrS5HVtj03B89ElTsa98H6HA0E21AxffQ0FBhLftRS15V5KfctoWlT0Wc9LCKQ99xb867Sp5STH0fqEomCzSwV9tqoOKZNLKIgdxyvHiJZmuHSn+K/wgmfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aHMiHWbj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cMq/2BDM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240117124903.248192631@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706015425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=PeMUWjlDczajo0chFTqV15pfVSAyJ1kzj+vNxCDZ7Pw=;
	b=aHMiHWbj7F6qUytPuz9WOKEx0aSl5oHx4hvFtJn1deSmnHjcMrptmWwGyGcNb9ZfVf+Iqw
	Wsi37YAKG4n6IvFvQ0kab3n3acMCBT355jysaO2gKjlbpASThLcsTV6Tkl84wg6flBhuUh
	ItqRuOu8pKZSLGs+OO8vsfTW1LncCpHPkOJfCVGfRv8LE7n8XTi5WVwjOg1ZTXFXJ1Vh7W
	PUEFC8vNIxySqN7jMfN85rY9onRlCF+74oG3vvclFF6qiYaa8JT29m5w+fYj1QxldCgnA/
	ir/zGHnOua6Ysbq7bcXf6kf7WpHrSjIOZRDk86FK3f+wpwV+WKrzLkKtTub6nw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706015425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=PeMUWjlDczajo0chFTqV15pfVSAyJ1kzj+vNxCDZ7Pw=;
	b=cMq/2BDM9JSFn1C9Tbj/suz9CALET+ux1O35B5HXHUXY6Vc9xFGZ1VAJRXJClMN2NevNDd
	BdtgBPpcy8KHQ6Cg==
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
Subject: [patch V2 14/22] x86/jailhouse: Prepare for separate mpparse
 callbacks
References: <20240117124704.044462658@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jan 2024 14:10:24 +0100 (CET)

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


