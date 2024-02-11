Return-Path: <linux-kernel+bounces-60662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0557585082B
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 09:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37FE21C20B04
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 08:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C1859B41;
	Sun, 11 Feb 2024 08:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oHn2cLOv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t9aMmjTO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734BC58AB6;
	Sun, 11 Feb 2024 08:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707640894; cv=none; b=qE10VcPD1xgh/XtN40zaNbmxAaSjHQM8b1IuhuKOXqXEFEshYSKqEbwTsWYvEic9rI3w0gTFX5m6ecpNOqLnDVAK4xiSu9h2jOcIqgBDGq0BEsL9DlseXwSNe3ASPbCiezMOOMLb8kB+BGQaxj85SvwDYsyxeZCBoTDPTpoquzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707640894; c=relaxed/simple;
	bh=eQrEQwdcV2jCF31eWgwV5ZmXQRMWQcIOfoZbOM88Fi0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=R9FawJZSB2NyTNSFRUfFqZHQCSI6RqaEhesmogMEBNibTSyJ28X33+4+C8lg9lBEbWCLlTiTVL8iwAQiyzpTLxlQx5UgLV97eQvAVl/5AncDvRTI2tVRQcrnyHyZYMP6MMeiRLXq5OVn4hhxXUekCbVbBuoFJLydsIWKy1qzAOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oHn2cLOv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t9aMmjTO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 11 Feb 2024 08:41:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707640890;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ePxOaAvGz0Sgteknc0uzMhxWCumwMD+XW9dqKXQ/BHg=;
	b=oHn2cLOvXVX6h6AISVYgf7XVvhDXcnhChy7ERb/mVnhlq29BcZsy/LbZ2QyvXbKc0MTIRe
	XDThrX6Mjnn64SCs4f4Sgq6Yn6j4Nv3IWuC4WwHkCgx5Se/1YSnXe69DvlZ6ToHZUreVxx
	Cwtae66NHUEfgqDOrlwKWmmYJJfV9lPYQxNkGPuZfwt0LJdICZOGOHlw8N65Rj0Pe+kfzq
	5SfnGwV43qX2gVpqTHB2wOn5cGGUKIPMaQ9IPjaywhLmR7Z2NAN5aL1m7MwXUTpQ2bgew5
	kVxBIgMwLcdvJKCij6pJPE8EJG7HKCalv/7zLnFQEXNJfUNocFJkDCPh2ETwOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707640890;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ePxOaAvGz0Sgteknc0uzMhxWCumwMD+XW9dqKXQ/BHg=;
	b=t9aMmjTOjaqsW/ZAutnPVbjlGAUVXwdpCvIeoJgvVEpR+1M/ftz9MaSl764/rlQ9FRSmYY
	efcVJcaezP+J/6AA==
From: "tip-bot2 for Peter Hilber" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/ptp] timekeeping: Evaluate system_counterval_t.cs_id
 instead of .cs
Cc: Peter Hilber <peter.hilber@opensynergy.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240201010453.2212371-7-peter.hilber@opensynergy.com>
References: <20240201010453.2212371-7-peter.hilber@opensynergy.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170764088938.398.12709802708724247162.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/ptp branch of tip:

Commit-ID:     4b7f521229ef4eee06848427d865954e6e0e3675
Gitweb:        https://git.kernel.org/tip/4b7f521229ef4eee06848427d865954e6e0e3675
Author:        Peter Hilber <peter.hilber@opensynergy.com>
AuthorDate:    Thu, 01 Feb 2024 02:04:51 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 Feb 2024 17:05:21 +01:00

timekeeping: Evaluate system_counterval_t.cs_id instead of .cs

Clocksource pointers can be problematic to obtain for drivers which are not
clocksource drivers themselves. In particular, the RFC virtio_rtc driver
[1] would require a new helper function to obtain a pointer to the ARM
Generic Timer clocksource. The ptp_kvm driver also required a similar
workaround.

Address this by evaluating the clocksource ID, rather than the clocksource
pointer, of struct system_counterval_t. By this, setting the clocksource
pointer becomes unneeded, and get_device_system_crosststamp() callers will
no longer need to supply clocksource pointers.

All relevant clocksource drivers provide the ID, so this change is not
changing the behaviour.

[1] https://lore.kernel.org/lkml/20231218073849.35294-1-peter.hilber@opensynergy.com/

Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240201010453.2212371-7-peter.hilber@opensynergy.com
---
 include/linux/timekeeping.h | 10 +++++-----
 kernel/time/timekeeping.c   |  9 +++++----
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index ca234fa..3538c5b 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -268,13 +268,13 @@ struct system_device_crosststamp {
 };
 
 /**
- * struct system_counterval_t - system counter value with the pointer to the
+ * struct system_counterval_t - system counter value with the ID of the
  *				corresponding clocksource
  * @cycles:	System counter value
- * @cs:		Clocksource corresponding to system counter value. Used by
- *		timekeeping code to verify comparibility of two cycle values
- * @cs_id:	Clocksource ID corresponding to system counter value. To be
- *		used instead of cs in the future.
+ * @cs:		Clocksource corresponding to system counter value. Timekeeping
+ *		code now evaluates cs_id instead.
+ * @cs_id:	Clocksource ID corresponding to system counter value. Used by
+ *		timekeeping code to verify comparability of two cycle values.
  *		The default ID, CSID_GENERIC, does not identify a specific
  *		clocksource.
  */
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 266d028..0ff065c 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1232,11 +1232,12 @@ int get_device_system_crosststamp(int (*get_time_fn)
 			return ret;
 
 		/*
-		 * Verify that the clocksource associated with the captured
-		 * system counter value is the same as the currently installed
-		 * timekeeper clocksource
+		 * Verify that the clocksource ID associated with the captured
+		 * system counter value is the same as for the currently
+		 * installed timekeeper clocksource
 		 */
-		if (tk->tkr_mono.clock != system_counterval.cs)
+		if (system_counterval.cs_id == CSID_GENERIC ||
+		    tk->tkr_mono.clock->id != system_counterval.cs_id)
 			return -ENODEV;
 		cycles = system_counterval.cycles;
 

