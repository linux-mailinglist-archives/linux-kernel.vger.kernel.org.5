Return-Path: <linux-kernel+bounces-126534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5902F89392C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 10:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1588F281994
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 08:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D86134C8;
	Mon,  1 Apr 2024 08:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ThjDbkjS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e/LpfFgN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88F7FBE9;
	Mon,  1 Apr 2024 08:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711961260; cv=none; b=hXHjvz5V8VGDlP0/biyGC0UaD43sk28VFJ7z0Bi9IGd9dbNHQBGYlHZgb5jkYEd3SeknAnIdi+Kw/z0go4w4Dgn+T00Zrts64AgYxeI2hHbYGZXMAV8pCJ5DKxK4lii5xSvdb3AS4WLREEUwUSurOA9Uzoe9Alt2LBz/GAxfRKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711961260; c=relaxed/simple;
	bh=KbICzgljB7ACLdZ5wKi9SqnmBz6H7yenJrVKn7kAIq0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JAI4Qc8De1E8Y5fQBFTRhO2kcZIHprvtFgXp6gRXeR2TQ2T6q1CPh4rbTzhTY5AyeP+08ZkPlQp0cIsdMelT6P9UnMs/qP8BYmRhFOlTpnwimASvjU3aucNgMKGWj9zza7F/wHAmicniOduuH4fZ970pPCBWczTbslHeiTHkfTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ThjDbkjS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e/LpfFgN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 01 Apr 2024 08:47:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711961251;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3nzj11H7LrsCH4joX4/FtsyxIS6CeGswBl9Obe2Iex0=;
	b=ThjDbkjSyNLcDrrhmcxWTcK7qGL+kDsIqVbpC/tjaRhWQleLZWekfBNjfE9asGLjkGYB4o
	IRYXMln+q22/OnDsYgNQDXbMsHHLPdIfduBsf7A8XWpJtxvMSjGLkWN6TQSfJj/rgOuPKg
	pFiHXchQbB4Nb6EBJ8wP6P6hPtOPUBt6ZLasi1NZbgFmhZslW4nO2U9GVFxCNwR8gjiUym
	Bpoo5cf952KMr+IOv6ZCj+PtTjD7KBWbf4dyLHwC4ZxMSJ+K6OW9i7o7w96eAUEG+G0PQl
	PPDeaVjRZmegLYWWXrOdD96bosjfBWfUfZ1mJShzMmy36RI9wXbc8JhYwxRRTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711961251;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3nzj11H7LrsCH4joX4/FtsyxIS6CeGswBl9Obe2Iex0=;
	b=e/LpfFgNuHCOxwkc4ZMXwqXLW3FejLzd2gPmuVWww9DHDnLcIuBkeIFaljA9yv1YAHZwwL
	LgZzvx0oLqPeDUBw==
From: "tip-bot2 for Randy Dunlap" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] time/timecounter: Fix inline documentation
Cc: Randy Dunlap <rdunlap@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240331172652.14086-2-rdunlap@infradead.org>
References: <20240331172652.14086-2-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171196125025.10875.6672650842976422044.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     aa7cbefe65e455178c33eca308349e687d262ea7
Gitweb:        https://git.kernel.org/tip/aa7cbefe65e455178c33eca308349e687d262ea7
Author:        Randy Dunlap <rdunlap@infradead.org>
AuthorDate:    Sun, 31 Mar 2024 10:26:47 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 01 Apr 2024 10:36:34 +02:00

time/timecounter: Fix inline documentation

Fix kernel-doc warnings, text punctuation, and a kernel-doc marker
(change '%' to '&' to indicate a struct):

  timecounter.h:72: warning: No description found for return value of 'cyclecounter_cyc2ns'
  timecounter.h:85: warning: Function parameter or member 'tc' not described in 'timecounter_adjtime'
  timecounter.h:111: warning: No description found for return value of 'timecounter_read'
  timecounter.h:128: warning: No description found for return value of 'timecounter_cyc2time'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20240331172652.14086-2-rdunlap@infradead.org
---
 include/linux/timecounter.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/timecounter.h b/include/linux/timecounter.h
index c6540ce..0982d1d 100644
--- a/include/linux/timecounter.h
+++ b/include/linux/timecounter.h
@@ -22,7 +22,7 @@
  *
  * @read:		returns the current cycle value
  * @mask:		bitmask for two's complement
- *			subtraction of non 64 bit counters,
+ *			subtraction of non-64-bit counters,
  *			see CYCLECOUNTER_MASK() helper macro
  * @mult:		cycle to nanosecond multiplier
  * @shift:		cycle to nanosecond divisor (power of two)
@@ -35,7 +35,7 @@ struct cyclecounter {
 };
 
 /**
- * struct timecounter - layer above a %struct cyclecounter which counts nanoseconds
+ * struct timecounter - layer above a &struct cyclecounter which counts nanoseconds
  *	Contains the state needed by timecounter_read() to detect
  *	cycle counter wrap around. Initialize with
  *	timecounter_init(). Also used to convert cycle counts into the
@@ -66,6 +66,8 @@ struct timecounter {
  * @cycles:	Cycles
  * @mask:	bit mask for maintaining the 'frac' field
  * @frac:	pointer to storage for the fractional nanoseconds.
+ *
+ * Returns: cycle counter cycles converted to nanoseconds
  */
 static inline u64 cyclecounter_cyc2ns(const struct cyclecounter *cc,
 				      u64 cycles, u64 mask, u64 *frac)
@@ -79,6 +81,7 @@ static inline u64 cyclecounter_cyc2ns(const struct cyclecounter *cc,
 
 /**
  * timecounter_adjtime - Shifts the time of the clock.
+ * @tc:		The &struct timecounter to adjust
  * @delta:	Desired change in nanoseconds.
  */
 static inline void timecounter_adjtime(struct timecounter *tc, s64 delta)
@@ -107,6 +110,8 @@ extern void timecounter_init(struct timecounter *tc,
  *
  * In other words, keeps track of time since the same epoch as
  * the function which generated the initial time stamp.
+ *
+ * Returns: nanoseconds since the initial time stamp
  */
 extern u64 timecounter_read(struct timecounter *tc);
 
@@ -123,6 +128,8 @@ extern u64 timecounter_read(struct timecounter *tc);
  *
  * This allows conversion of cycle counter values which were generated
  * in the past.
+ *
+ * Returns: cycle counter converted to nanoseconds since the initial time stamp
  */
 extern u64 timecounter_cyc2time(const struct timecounter *tc,
 				u64 cycle_tstamp);

