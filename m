Return-Path: <linux-kernel+bounces-70954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A62859EAA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A132A1F21A4E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 08:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B423822F1E;
	Mon, 19 Feb 2024 08:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xh5Wz8xp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lMifWcvF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E60221A19;
	Mon, 19 Feb 2024 08:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708332338; cv=none; b=H3ixzQhlrDIvE8pG3prXF7bZynLIatSWwJIZFvabzEIYRRMBcYqLkqSuOjF8Gg5f9QYPOsJxStjo/fAbfWROj7IRxXmArH5bA85QzDv7p8GY6ZWqNCKLqP3og8kiiBiew/vGvYFIv3haFy5YwfFJ1ZV61/SsR5DmA/pDoN9hskE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708332338; c=relaxed/simple;
	bh=dmzOTB6f156z4RFEWfYQvp1a3geU/pH8BC718iwJcvw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=btYXk9MXP4O0aaeaURBIbGrVnI2ZtDCzYQyg+mESz8i7Pq3qqpCilnzbZqt3K5G95md11srAwtEq9jmbUW0LP0uEsjRxW11XpBTHtMAK7Rx3OcWeS2Y6EADUyLautVn+Lac5bb4ATRnv4h+JelrbJafBO2TYLdckI23JrN8/cBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xh5Wz8xp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lMifWcvF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 19 Feb 2024 08:45:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708332335;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vp9FsdQZWj5mHPz6UeSAfVzwer8wwEB1a/Z98kYKpk8=;
	b=xh5Wz8xp5wkOnU0i/ORG/Ft9bg7dHFLfK9ZmFw1/fGrutj5bqXBbomWsqPmSqFtoRn+7SX
	LSBkutUC5kPUgpzqqzjiot2rTnLu5MYsWESbUEwPlujBIDi4d5hcMf1nnia9HBEAlVFcwB
	EINKAxe934oWo2Eyp3+J66zuwlMyvGjvnaeMAfJINtRIBzwaA4CF7pPeptNBcd9X8tqQLb
	LNImrACj5yfGjEkf0yNrdST4VKBN2PSctT3uI3WbyV1Gsi/GHW/+u9dfedoryqnHOWJzb7
	531PzXONW9p/i9dFRxgyFJyMD/S2jFzmBKOcw4WTjGmk6LNPO8xz0RIOFG8nRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708332335;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vp9FsdQZWj5mHPz6UeSAfVzwer8wwEB1a/Z98kYKpk8=;
	b=lMifWcvFkPNNdQnp70+/7WC9mYt8U4eH/7ZFgBAvsO0slDeBqM6h7XR+oBP0EBvLiaZhkA
	YQZCaEalUEIQweCQ==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] hrtimers: Update formatting of documentation
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240123164702.55612-3-anna-maria@linutronix.de>
References: <20240123164702.55612-3-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170833233427.398.8658313899755655344.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     ca2768bbf5c48d8c048877dfbceafcebc3f06fa6
Gitweb:        https://git.kernel.org/tip/ca2768bbf5c48d8c048877dfbceafcebc3f06fa6
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Tue, 23 Jan 2024 17:46:56 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 19 Feb 2024 09:37:59 +01:00

hrtimers: Update formatting of documentation

Documentation of functions lacks the annotations which are used by
kernel-doc and *.rst to make appearance in rendered documents more
user-friendly.

Use those annotations to improve user-friendliness. While at it prevent
duplication of comments and use a reference instead.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240123164702.55612-3-anna-maria@linutronix.de

---
 include/linux/hrtimer.h | 14 +++-----------
 kernel/time/hrtimer.c   | 18 ++++++++++--------
 2 files changed, 13 insertions(+), 19 deletions(-)

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 792a0ac..aa1e65c 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -342,20 +342,12 @@ extern u64
 hrtimer_forward(struct hrtimer *timer, ktime_t now, ktime_t interval);
 
 /**
- * hrtimer_forward_now - forward the timer expiry so it expires after now
+ * hrtimer_forward_now() - forward the timer expiry so it expires after now
  * @timer:	hrtimer to forward
  * @interval:	the interval to forward
  *
- * Forward the timer expiry so it will expire after the current time
- * of the hrtimer clock base. Returns the number of overruns.
- *
- * Can be safely called from the callback function of @timer. If
- * called from other contexts @timer must neither be enqueued nor
- * running the callback and the caller needs to take care of
- * serialization.
- *
- * Note: This only updates the timer expiry value and does not requeue
- * the timer.
+ * It is a variant of hrtimer_forward(). The timer will expire after the current
+ * time of the hrtimer clock base. See hrtimer_forward() for details.
  */
 static inline u64 hrtimer_forward_now(struct hrtimer *timer,
 				      ktime_t interval)
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 7607939..4c8dd63 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1021,21 +1021,23 @@ void unlock_hrtimer_base(const struct hrtimer *timer, unsigned long *flags)
 }
 
 /**
- * hrtimer_forward - forward the timer expiry
+ * hrtimer_forward() - forward the timer expiry
  * @timer:	hrtimer to forward
  * @now:	forward past this time
  * @interval:	the interval to forward
  *
  * Forward the timer expiry so it will expire in the future.
- * Returns the number of overruns.
  *
- * Can be safely called from the callback function of @timer. If
- * called from other contexts @timer must neither be enqueued nor
- * running the callback and the caller needs to take care of
- * serialization.
+ * .. note::
+ *  This only updates the timer expiry value and does not requeue the timer.
  *
- * Note: This only updates the timer expiry value and does not requeue
- * the timer.
+ * There is also a variant of the function hrtimer_forward_now().
+ *
+ * Context: Can be safely called from the callback function of @timer. If called
+ *          from other contexts @timer must neither be enqueued nor running the
+ *          callback and the caller needs to take care of serialization.
+ *
+ * Return: The number of overruns are returned.
  */
 u64 hrtimer_forward(struct hrtimer *timer, ktime_t now, ktime_t interval)
 {

