Return-Path: <linux-kernel+bounces-60666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A36E9850834
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 09:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E7471F22A48
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 08:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335AE5A7A0;
	Sun, 11 Feb 2024 08:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e+a1Br/u";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s9vYRLRV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774D359173;
	Sun, 11 Feb 2024 08:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707640896; cv=none; b=pFUWCfe5ELSBVfVa4F3i46zEMum6EfdzGMERzc7wGSdDmmfCl/FPDIHaxw6mYIG6M4PZQaCUgUyG58uhqUKEfCQNrsHwS0nNQNPKR371ZUGNMTougm35ZDGptgEITYa/82AWAurZOSxAU2sCWIYAP/4bmGhC0JsxJ2LpT34jyhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707640896; c=relaxed/simple;
	bh=2bBr0+qomzpEdnAc8hw70BQqKueFNNkh3RgFIgB0WHc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=AUC6BCGEY2Bskzna7OI7ruqWLjt1DnFv7WL5IVMxIRgaKmj0N2EbpttT8brQl14rKkpwS3wsp0LX5WZU1DmikINjgbtJupgN+Ra8dNrImfHNvyjw3dTwsP4LFPtg9qxH2NcZwLZqnH5ayY0BE+1ZV7iDKBrC2o97JnLwDDhyyXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e+a1Br/u; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s9vYRLRV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 11 Feb 2024 08:41:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707640892;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=21QfmUYeQ4YPKcq7TxRd5XqgWxLchGbi5oRsUkDf2P4=;
	b=e+a1Br/uQ7OZqr7ZiKEYDg0XrFasu+YUBhmqrlLTl349tuoJltu7wPUAssBymR6Ziu2iG9
	IhBNdPD9elSBaavy/pKvTsH0wg6s16clrlxiPilOALM7Yglx8Go5GIb6RVHhESC7KE18jU
	Cy7zVhmucvcdJh1ybjBZ1zM/heUGCUrU5H8UM50X/pJGiJtfjPV5RXog2euIcT2r5gLlpI
	HBvBLJxGTI1hkCoFXxJncWNZXAbWcda9M2W0laBtseSWvRd6QaZJR8SjheLWjziD3Vjuuu
	p3/OuvPTuZPesEbWxoBA+faeGS4p9xwFeoEfeGrsqjKvJgMHmhF7nw6ayzWEVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707640892;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=21QfmUYeQ4YPKcq7TxRd5XqgWxLchGbi5oRsUkDf2P4=;
	b=s9vYRLRVhTfMVtKdLXEuqjoflrgSPxEMT09J+oZuNS2/lCt9dVr9akKf+04r503Ab7KbaD
	oLkbda4JSHv1sLCg==
From: "tip-bot2 for Peter Hilber" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/ptp] x86/tsc: Add clocksource ID, set system_counterval_t.cs_id
Cc: Peter Hilber <peter.hilber@opensynergy.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240201010453.2212371-4-peter.hilber@opensynergy.com>
References: <20240201010453.2212371-4-peter.hilber@opensynergy.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170764089118.398.9281896438790489662.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/ptp branch of tip:

Commit-ID:     a2c1fe72062a5dd69de4dfe892f6436d6c0479dd
Gitweb:        https://git.kernel.org/tip/a2c1fe72062a5dd69de4dfe892f6436d6c0479dd
Author:        Peter Hilber <peter.hilber@opensynergy.com>
AuthorDate:    Thu, 01 Feb 2024 02:04:48 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 Feb 2024 17:05:21 +01:00

x86/tsc: Add clocksource ID, set system_counterval_t.cs_id

Add a clocksource ID for TSC and a distinct one for the early TSC.

Use distinct IDs for TSC and early TSC, since those also have distinct
clocksource structs. This should help to keep existing semantics when
comparing clocksources.

Also, set the recently added struct system_counterval_t member cs_id to the
TSC ID in the cases where the clocksource member is being set to the TSC
clocksource. In the future, get_device_system_crosststamp() will compare
the clocksource ID in struct system_counterval_t, rather than the
clocksource.

For the x86 ART related code, system_counterval_t.cs == NULL corresponds to
system_counterval_t.cs_id == CSID_GENERIC (0).

Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240201010453.2212371-4-peter.hilber@opensynergy.com

---
 arch/x86/kernel/tsc.c           | 28 +++++++++++++++++++++-------
 include/linux/clocksource_ids.h |  2 ++
 2 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 7978f31..fd567a0 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -54,6 +54,7 @@ static u32 art_to_tsc_numerator;
 static u32 art_to_tsc_denominator;
 static u64 art_to_tsc_offset;
 static struct clocksource *art_related_clocksource;
+static bool have_art;
 
 struct cyc2ns {
 	struct cyc2ns_data data[2];	/*  0 + 2*16 = 32 */
@@ -1168,6 +1169,7 @@ static struct clocksource clocksource_tsc_early = {
 	.mask			= CLOCKSOURCE_MASK(64),
 	.flags			= CLOCK_SOURCE_IS_CONTINUOUS |
 				  CLOCK_SOURCE_MUST_VERIFY,
+	.id			= CSID_X86_TSC_EARLY,
 	.vdso_clock_mode	= VDSO_CLOCKMODE_TSC,
 	.enable			= tsc_cs_enable,
 	.resume			= tsc_resume,
@@ -1190,6 +1192,7 @@ static struct clocksource clocksource_tsc = {
 				  CLOCK_SOURCE_VALID_FOR_HRES |
 				  CLOCK_SOURCE_MUST_VERIFY |
 				  CLOCK_SOURCE_VERIFY_PERCPU,
+	.id			= CSID_X86_TSC,
 	.vdso_clock_mode	= VDSO_CLOCKMODE_TSC,
 	.enable			= tsc_cs_enable,
 	.resume			= tsc_resume,
@@ -1309,8 +1312,11 @@ struct system_counterval_t convert_art_to_tsc(u64 art)
 	do_div(tmp, art_to_tsc_denominator);
 	res += tmp + art_to_tsc_offset;
 
-	return (struct system_counterval_t) {.cs = art_related_clocksource,
-			.cycles = res};
+	return (struct system_counterval_t) {
+		.cs	= art_related_clocksource,
+		.cs_id	= have_art ? CSID_X86_TSC : CSID_GENERIC,
+		.cycles	= res,
+	};
 }
 EXPORT_SYMBOL(convert_art_to_tsc);
 
@@ -1327,9 +1333,10 @@ EXPORT_SYMBOL(convert_art_to_tsc);
  * that this flag is set before conversion to TSC is attempted.
  *
  * Return:
- * struct system_counterval_t - system counter value with the pointer to the
+ * struct system_counterval_t - system counter value with the ID of the
  *	corresponding clocksource:
  *	cycles:		System counter value
+ *	cs_id:		The clocksource ID for validating comparability
  *	cs:		Clocksource corresponding to system counter value. Used
  *			by timekeeping code to verify comparability of two cycle
  *			values.
@@ -1347,8 +1354,11 @@ struct system_counterval_t convert_art_ns_to_tsc(u64 art_ns)
 	do_div(tmp, USEC_PER_SEC);
 	res += tmp;
 
-	return (struct system_counterval_t) { .cs = art_related_clocksource,
-					      .cycles = res};
+	return (struct system_counterval_t) {
+		.cs	= art_related_clocksource,
+		.cs_id	= have_art ? CSID_X86_TSC : CSID_GENERIC,
+		.cycles	= res,
+	};
 }
 EXPORT_SYMBOL(convert_art_ns_to_tsc);
 
@@ -1454,8 +1464,10 @@ out:
 	if (tsc_unstable)
 		goto unreg;
 
-	if (boot_cpu_has(X86_FEATURE_ART))
+	if (boot_cpu_has(X86_FEATURE_ART)) {
 		art_related_clocksource = &clocksource_tsc;
+		have_art = true;
+	}
 	clocksource_register_khz(&clocksource_tsc, tsc_khz);
 unreg:
 	clocksource_unregister(&clocksource_tsc_early);
@@ -1480,8 +1492,10 @@ static int __init init_tsc_clocksource(void)
 	 * the refined calibration and directly register it as a clocksource.
 	 */
 	if (boot_cpu_has(X86_FEATURE_TSC_KNOWN_FREQ)) {
-		if (boot_cpu_has(X86_FEATURE_ART))
+		if (boot_cpu_has(X86_FEATURE_ART)) {
 			art_related_clocksource = &clocksource_tsc;
+			have_art = true;
+		}
 		clocksource_register_khz(&clocksource_tsc, tsc_khz);
 		clocksource_unregister(&clocksource_tsc_early);
 
diff --git a/include/linux/clocksource_ids.h b/include/linux/clocksource_ids.h
index 16775d7..f846794 100644
--- a/include/linux/clocksource_ids.h
+++ b/include/linux/clocksource_ids.h
@@ -6,6 +6,8 @@
 enum clocksource_ids {
 	CSID_GENERIC		= 0,
 	CSID_ARM_ARCH_COUNTER,
+	CSID_X86_TSC_EARLY,
+	CSID_X86_TSC,
 	CSID_MAX,
 };
 

