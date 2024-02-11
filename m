Return-Path: <linux-kernel+bounces-60667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E21850835
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 09:43:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68D141C20C97
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 08:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA1B5B5A2;
	Sun, 11 Feb 2024 08:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="piFXpzCs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tYtsvsDW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C838659B44;
	Sun, 11 Feb 2024 08:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707640896; cv=none; b=Z0/kxmjkKTGOOCBO9VsljtsrHL1YaiC8NXtnshh1FcVTZ4lUrPkfL5F8HeZhcejLPCmif8H4Jgq8hDZgfETeDtoNTno6y9bVmcNqoliLSltuXaTDbdOQB/k42nE9a4Uflgv7Zw/XK+8LKkE8SOEHmSicQY6q79odWpDaAxaMsTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707640896; c=relaxed/simple;
	bh=WQx7Vdx5IwUhl3RWg4ikwVMFEltt+PS84PyWIpi6zio=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QL4fs8smnJZv5xTNcDF/uvOWLAkpQZ2jV4AoR6v5FLhxaYgkAvDUUf/k+6jKUxu7imJ6Z4MSUimD+LObhEtY08eiBrek9fjj1mWtK5cjk5xO54tBeav7O3zw9NHaYuW6sNklrTOoEjsyT2ys5R3WkYJtSSrWmFyr9mz2A4JOX9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=piFXpzCs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tYtsvsDW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 11 Feb 2024 08:41:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707640893;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pfYKuNJ2k2rEVjyXsA+Ng/D6gF5mjpBVqeC5cnxpBjc=;
	b=piFXpzCsbQwCA5UPf5k7lqOW/ZirlzSMFcRsFkE+IK+BUTnm70wQVLjm6msbzpsEA+Jbp0
	qw25oroE2tlDXfLUfBrfejLcVqpmzqKl8FXzYSZUMEBnf5n6xRTewhB/wFI/yFr50czzn7
	19Od86Uzx1mgGvTuXDdhJ901dNzZtJ8HL4dUBnGZN2kuJ9E2TceFit7N709PHJwqm0HE5/
	34YHpKrgowUAaR/ewdDBvmUlbrZ0WwCZNLk9NZsh7zmEBHGKsmiSx+1YOcvgVcOYcYZS4H
	ZpWfo5QvJLW7RS60YMMm5DjnAzKunCGMDV/9r9Z4Wqsc+vXacwbvALsLx4hpaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707640893;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pfYKuNJ2k2rEVjyXsA+Ng/D6gF5mjpBVqeC5cnxpBjc=;
	b=tYtsvsDWabaVV1Fk9xEluHfUigowSf2LZK8E8RzTH1uAEl9OwcmkIB0/ijwyEJpqWLUzEu
	aih7bGBr5WZHpPAA==
From: "tip-bot2 for Randy Dunlap" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/ptp] x86/tsc: Correct kernel-doc notation
Cc: Randy Dunlap <rdunlap@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231221033620.32379-1-rdunlap@infradead.org>
References: <20231221033620.32379-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170764089235.398.13750256669903185637.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/ptp branch of tip:

Commit-ID:     c55cbfcea6087cca1f7891a8d1ca52dcae946be5
Gitweb:        https://git.kernel.org/tip/c55cbfcea6087cca1f7891a8d1ca52dcae946be5
Author:        Randy Dunlap <rdunlap@infradead.org>
AuthorDate:    Wed, 20 Dec 2023 19:36:20 -08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 Feb 2024 17:05:21 +01:00

x86/tsc: Correct kernel-doc notation

Add or modify function descriptions to remove kernel-doc warnings:

tsc.c:655: warning: missing initial short description on line:
 * native_calibrate_tsc
tsc.c:1339: warning: Excess function parameter 'cycles' description in 'convert_art_ns_to_tsc'
tsc.c:1339: warning: Excess function parameter 'cs' description in 'convert_art_ns_to_tsc'
tsc.c:1373: warning: Function parameter or member 'work' not described in 'tsc_refine_calibration_work'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20231221033620.32379-1-rdunlap@infradead.org

---
 arch/x86/kernel/tsc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 15f97c0..7978f31 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -652,7 +652,7 @@ success:
 }
 
 /**
- * native_calibrate_tsc
+ * native_calibrate_tsc - determine TSC frequency
  * Determine TSC frequency via CPUID, else return 0.
  */
 unsigned long native_calibrate_tsc(void)
@@ -1328,9 +1328,9 @@ EXPORT_SYMBOL(convert_art_to_tsc);
  *
  * Return:
  * struct system_counterval_t - system counter value with the pointer to the
- *	corresponding clocksource
- *	@cycles:	System counter value
- *	@cs:		Clocksource corresponding to system counter value. Used
+ *	corresponding clocksource:
+ *	cycles:		System counter value
+ *	cs:		Clocksource corresponding to system counter value. Used
  *			by timekeeping code to verify comparability of two cycle
  *			values.
  */
@@ -1357,7 +1357,7 @@ static void tsc_refine_calibration_work(struct work_struct *work);
 static DECLARE_DELAYED_WORK(tsc_irqwork, tsc_refine_calibration_work);
 /**
  * tsc_refine_calibration_work - Further refine tsc freq calibration
- * @work - ignored.
+ * @work: ignored.
  *
  * This functions uses delayed work over a period of a
  * second to further refine the TSC freq value. Since this is

