Return-Path: <linux-kernel+bounces-126532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5037893929
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 10:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C971B215C2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 08:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C70E10A08;
	Mon,  1 Apr 2024 08:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T9ezNAmh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PW1qGRVG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E491BA49;
	Mon,  1 Apr 2024 08:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711961259; cv=none; b=bgYMywQq/j3OV7SD6CJ5qzE9xDiU8uo5dXzMo6uXh232d7ef8UbdiVxpzUFlLOZo+i2+x4XEn05ttwfb5ME23qQj+BeUrEL/wbmyZZFvW3+HbbCsxv5oyarm4/3nqBaIV8ufmgsioKbb5FpV64QAHMeVWeEElBnUebqTHwr824I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711961259; c=relaxed/simple;
	bh=5ganj4KIRItzRv/8lTv1YCPCw9LIr0Gp+G/3TCp7lto=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=XDmwfLnmrTEw4Nxljk9IkYUk4js4kKdxLGkZOaii0Xl5HEDGJDXgwxKL6QZqCHVf0jhpmbhsVChgEW3556UXAd4LhHrvDGpvXNmD5HzUMcI3pDQpHCZlQRC4pv4EM/u6PtJN73r0TcsL1jaFDOCoNOVTddN0ZLZnOSg4icePzzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T9ezNAmh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PW1qGRVG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 01 Apr 2024 08:47:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711961250;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jNTZLoc34Fku5jcA2pWZIMAGfWASEwTBaRIPcHFrl9w=;
	b=T9ezNAmhGalppPr1BrgrfWOQPitSEzQ9FD/AjYRs0EJf87K+U8hsiOQA6HD+i65Tucxtcu
	wUAAy4bKJzpnFwzrAAFNcQBwXDEvmrNFZCJKm94JMheRSthgj8oLcgkdVZhW9iFzFY6U6j
	cSsq2GQnRbBrvpB3ZDf9493woMRfq9IyROQesaEOr9XvV1qX+juqL6F9cSRig5U3YhepwL
	mZ+wryhMEurpi+7zB+RXbOYfNYTq2KIqPWWWDiBjQBQnJr9IQLR6mfFbZLR6JXl6exoKTH
	ufHvlemAQYXJruByynNP65u20MiY6JeS/53atFgb2LJwJII+oX1Hn0PreflHiw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711961250;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jNTZLoc34Fku5jcA2pWZIMAGfWASEwTBaRIPcHFrl9w=;
	b=PW1qGRVGWETFGkxmdKGYicvBFIowp/GEnkgzxxbnUylV+qylMtOMauJFXntlwPw2cJrDNt
	9S59iCQ2kgJGUyBw==
From: "tip-bot2 for Randy Dunlap" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/urgent] time/timekeeping: Fix kernel-doc warnings and typos
Cc: Randy Dunlap <rdunlap@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240331172652.14086-3-rdunlap@infradead.org>
References: <20240331172652.14086-3-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171196124959.10875.13171061339410283258.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     76f788ee4a7d9f826738a034f9d2ee0bc4cd291b
Gitweb:        https://git.kernel.org/tip/76f788ee4a7d9f826738a034f9d2ee0bc4cd291b
Author:        Randy Dunlap <rdunlap@infradead.org>
AuthorDate:    Sun, 31 Mar 2024 10:26:48 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 01 Apr 2024 10:36:34 +02:00

time/timekeeping: Fix kernel-doc warnings and typos

Fix punctuation, spellos, and kernel-doc warnings:

  timekeeping.h:79: warning: No description found for return value of 'ktime_get_real'
  timekeeping.h:95: warning: No description found for return value of 'ktime_get_boottime'
  timekeeping.h:108: warning: No description found for return value of 'ktime_get_clocktai'
  timekeeping.h:149: warning: Function parameter or struct member 'mono' not described in 'ktime_mono_to_real'
  timekeeping.h:149: warning: No description found for return value of 'ktime_mono_to_real'
  timekeeping.h:255: warning: Function parameter or struct member 'cs_id' not described in 'system_time_snapshot'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20240331172652.14086-3-rdunlap@infradead.org
---
 include/linux/timekeeping.h | 49 ++++++++++++++++++++++++++++++------
 1 file changed, 42 insertions(+), 7 deletions(-)

diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index 7e50cbd..0ea7823 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -22,14 +22,14 @@ extern int do_sys_settimeofday64(const struct timespec64 *tv,
 				 const struct timezone *tz);
 
 /*
- * ktime_get() family: read the current time in a multitude of ways,
+ * ktime_get() family - read the current time in a multitude of ways.
  *
  * The default time reference is CLOCK_MONOTONIC, starting at
  * boot time but not counting the time spent in suspend.
  * For other references, use the functions with "real", "clocktai",
  * "boottime" and "raw" suffixes.
  *
- * To get the time in a different format, use the ones wit
+ * To get the time in a different format, use the ones with
  * "ns", "ts64" and "seconds" suffix.
  *
  * See Documentation/core-api/timekeeping.rst for more details.
@@ -74,6 +74,8 @@ extern u32 ktime_get_resolution_ns(void);
 
 /**
  * ktime_get_real - get the real (wall-) time in ktime_t format
+ *
+ * Returns: real (wall) time in ktime_t format
  */
 static inline ktime_t ktime_get_real(void)
 {
@@ -86,10 +88,12 @@ static inline ktime_t ktime_get_coarse_real(void)
 }
 
 /**
- * ktime_get_boottime - Returns monotonic time since boot in ktime_t format
+ * ktime_get_boottime - Get monotonic time since boot in ktime_t format
  *
  * This is similar to CLOCK_MONTONIC/ktime_get, but also includes the
  * time spent in suspend.
+ *
+ * Returns: monotonic time since boot in ktime_t format
  */
 static inline ktime_t ktime_get_boottime(void)
 {
@@ -102,7 +106,9 @@ static inline ktime_t ktime_get_coarse_boottime(void)
 }
 
 /**
- * ktime_get_clocktai - Returns the TAI time of day in ktime_t format
+ * ktime_get_clocktai - Get the TAI time of day in ktime_t format
+ *
+ * Returns: the TAI time of day in ktime_t format
  */
 static inline ktime_t ktime_get_clocktai(void)
 {
@@ -144,32 +150,60 @@ static inline u64 ktime_get_coarse_clocktai_ns(void)
 
 /**
  * ktime_mono_to_real - Convert monotonic time to clock realtime
+ * @mono: monotonic time to convert
+ *
+ * Returns: time converted to realtime clock
  */
 static inline ktime_t ktime_mono_to_real(ktime_t mono)
 {
 	return ktime_mono_to_any(mono, TK_OFFS_REAL);
 }
 
+/**
+ * ktime_get_ns - Get the current time in nanoseconds
+ *
+ * Returns: current time converted to nanoseconds
+ */
 static inline u64 ktime_get_ns(void)
 {
 	return ktime_to_ns(ktime_get());
 }
 
+/**
+ * ktime_get_real_ns - Get the current real/wall time in nanoseconds
+ *
+ * Returns: current real time converted to nanoseconds
+ */
 static inline u64 ktime_get_real_ns(void)
 {
 	return ktime_to_ns(ktime_get_real());
 }
 
+/**
+ * ktime_get_boottime_ns - Get the monotonic time since boot in nanoseconds
+ *
+ * Returns: current boottime converted to nanoseconds
+ */
 static inline u64 ktime_get_boottime_ns(void)
 {
 	return ktime_to_ns(ktime_get_boottime());
 }
 
+/**
+ * ktime_get_clocktai_ns - Get the current TAI time of day in nanoseconds
+ *
+ * Returns: current TAI time converted to nanoseconds
+ */
 static inline u64 ktime_get_clocktai_ns(void)
 {
 	return ktime_to_ns(ktime_get_clocktai());
 }
 
+/**
+ * ktime_get_raw_ns - Get the raw monotonic time in nanoseconds
+ *
+ * Returns: current raw monotonic time converted to nanoseconds
+ */
 static inline u64 ktime_get_raw_ns(void)
 {
 	return ktime_to_ns(ktime_get_raw());
@@ -224,8 +258,8 @@ extern bool timekeeping_rtc_skipresume(void);
 
 extern void timekeeping_inject_sleeptime64(const struct timespec64 *delta);
 
-/*
- * struct ktime_timestanps - Simultaneous mono/boot/real timestamps
+/**
+ * struct ktime_timestamps - Simultaneous mono/boot/real timestamps
  * @mono:	Monotonic timestamp
  * @boot:	Boottime timestamp
  * @real:	Realtime timestamp
@@ -242,7 +276,8 @@ struct ktime_timestamps {
  * @cycles:	Clocksource counter value to produce the system times
  * @real:	Realtime system time
  * @raw:	Monotonic raw system time
- * @clock_was_set_seq:	The sequence number of clock was set events
+ * @cs_id:	Clocksource ID
+ * @clock_was_set_seq:	The sequence number of clock-was-set events
  * @cs_was_changed_seq:	The sequence number of clocksource change events
  */
 struct system_time_snapshot {

