Return-Path: <linux-kernel+bounces-130114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0769B89743B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 387AC1C2403A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B4A14A4C0;
	Wed,  3 Apr 2024 15:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4qTC3Ku6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oAQntXhr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791451E871;
	Wed,  3 Apr 2024 15:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712158989; cv=none; b=V3+WCkz9zyzyau20+Gc1FYFY1tYPtUczCjMDVgH0acpAduAIFT7uIsOlsr/J9m9A6z0x1eoxTJeDdwmbjQVq1NFp87KghxmA3MLLgcnXAou5OZBRLSXQFVwsJAapf+H2TyiDfIhYzGVh0ZNez4YXS86FD9VU0xjLHKAtuMGszcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712158989; c=relaxed/simple;
	bh=E9L0AoozWcOpFf5FTLLdItjWDLarNOox26qfWtRNpNE=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=XzzLsjjMmiN/sWkaeYjGTkra0TDQo9FlVyGlcfq/D0z1Oh+oc2wKFM0JmwLqg4e7ANVNLIym26z0WnUf6VBWu9MEMRQAUiRK5uUW8j0ueZcI/oBRjpKmnNfqrYZugLswwlQU1qzhdKpsM1sXzQcIUoC09fFQSQLvoHJPqKHxcT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4qTC3Ku6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oAQntXhr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 03 Apr 2024 15:43:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712158985;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=s1qXV5ip/IVtxlVDhMWAguiXYThThoOZa2tt7bqgZpw=;
	b=4qTC3Ku6qVMlPjOlgTsO7gciWCLArdsf+gZt+zNZlkuHvijn9qYaAobGMytRIt/jzIC321
	0eKKLaFCmQixcXAYr8vRjdSsrdQCZEDRKsq+nuDvXI2xwG0LvlvMmHmJZKQk05PVRl2P+P
	Svgc6A6kfb6qzklPdGfkz2n/O+YBiBuzGh4UhDcJOFugi7ZBjh2dx/4DliETo0httgilk7
	CkIiOFWofa9XVQhlpKdSxeoYUU9licMbmaWYOxEui3Xz/ZWI+6gncyi3aTA5mLIoI/eNJ3
	yB5XMHpX8rmpRAi3T7eIwC0eAJa2yKUFZfWIW6zpHW4LcciQAnk3RPlcQbgsKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712158985;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=s1qXV5ip/IVtxlVDhMWAguiXYThThoOZa2tt7bqgZpw=;
	b=oAQntXhr3w8EvVZg31nU8H6IPBlSQiXuGQW3l2PIvlKnQtU2A26rP2/oU65X+KcryMSc+7
	n1FDCzRoBdeyMdBQ==
From: "tip-bot2 for Thorsten Blum" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/apic] x86/apic: Improve data types to fix Coccinelle warnings
Cc: Thorsten Blum <thorsten.blum@toblux.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171215898459.10875.11580343663413103011.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     0049f04c7dfe977a0f8f6935071db3416e641837
Gitweb:        https://git.kernel.org/tip/0049f04c7dfe977a0f8f6935071db3416e641837
Author:        Thorsten Blum <thorsten.blum@toblux.com>
AuthorDate:    Mon, 18 Mar 2024 11:47:23 +01:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 03 Apr 2024 08:32:04 -07:00

x86/apic: Improve data types to fix Coccinelle warnings

Given that acpi_pm_read_early() returns a u32 (masked to 24 bits), several
variables that store its return value are improved by adjusting their data
types from unsigned long to u32. Specifically, change deltapm's type from
long to u32 because its value fits into 32 bits and it cannot be negative.

These data type improvements resolve the following two Coccinelle/
coccicheck warnings reported by do_div.cocci:

arch/x86/kernel/apic/apic.c:734:1-7: WARNING: do_div() does a 64-by-32
division, please consider using div64_long instead.

arch/x86/kernel/apic/apic.c:742:2-8: WARNING: do_div() does a 64-by-32
division, please consider using div64_long instead.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20240318104721.117741-3-thorsten.blum%40toblux.com
---
 arch/x86/kernel/apic/apic.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index a42d8a6..e5c9cad 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -631,7 +631,7 @@ void lapic_update_tsc_freq(void)
 static __initdata int lapic_cal_loops = -1;
 static __initdata long lapic_cal_t1, lapic_cal_t2;
 static __initdata unsigned long long lapic_cal_tsc1, lapic_cal_tsc2;
-static __initdata unsigned long lapic_cal_pm1, lapic_cal_pm2;
+static __initdata u32 lapic_cal_pm1, lapic_cal_pm2;
 static __initdata unsigned long lapic_cal_j1, lapic_cal_j2;
 
 /*
@@ -641,7 +641,7 @@ static void __init lapic_cal_handler(struct clock_event_device *dev)
 {
 	unsigned long long tsc = 0;
 	long tapic = apic_read(APIC_TMCCT);
-	unsigned long pm = acpi_pm_read_early();
+	u32 pm = acpi_pm_read_early();
 
 	if (boot_cpu_has(X86_FEATURE_TSC))
 		tsc = rdtsc();
@@ -666,7 +666,7 @@ static void __init lapic_cal_handler(struct clock_event_device *dev)
 }
 
 static int __init
-calibrate_by_pmtimer(long deltapm, long *delta, long *deltatsc)
+calibrate_by_pmtimer(u32 deltapm, long *delta, long *deltatsc)
 {
 	const long pm_100ms = PMTMR_TICKS_PER_SEC / 10;
 	const long pm_thresh = pm_100ms / 100;
@@ -677,7 +677,7 @@ calibrate_by_pmtimer(long deltapm, long *delta, long *deltatsc)
 	return -1;
 #endif
 
-	apic_printk(APIC_VERBOSE, "... PM-Timer delta = %ld\n", deltapm);
+	apic_printk(APIC_VERBOSE, "... PM-Timer delta = %u\n", deltapm);
 
 	/* Check, if the PM timer is available */
 	if (!deltapm)

