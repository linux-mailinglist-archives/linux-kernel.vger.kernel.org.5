Return-Path: <linux-kernel+bounces-35704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE6A83955B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 622B01C212EB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04D182D75;
	Tue, 23 Jan 2024 16:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ypNAgJ5o";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C9fOdwLQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3494081AD7;
	Tue, 23 Jan 2024 16:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706028441; cv=none; b=qQ7m7gGKBsJjXSdlCR3NnhwhIo8unH1eZ+nnIxmiN1fDwc6LAPlYKOSF0q+PtESdVFXFuLTwjhMjlobz/yE3/PhNRr/bQc8zzNP1ypS0bpIbVPLt5M+bW0Lj4YdON75t8epEXkkH6pdjhUPQQ52vkKepf56bc0WYkiIodvUO180=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706028441; c=relaxed/simple;
	bh=o5OrShZSySnx9z4Dc96d9/mMYCWz28Tvaz3npFr+rh4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FkwwzN8oBrTIKX95iITPdvFskZ/tNG4QNL0fX+oUBiJDo38OYZ6IiRk/+VTs/x53YIPmX82ZpU/fQw5b9VKwNHxWj7FpqipuXnlxlu4en+Ms/nvor1yaTsQ/C/7FYkOaYUJuL9MoCAu2l6QGCstRGZB+0OKEOoXqJavu8DbSYyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ypNAgJ5o; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C9fOdwLQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706028436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JGyehJjSy1LmtgI6x+CLT4pSFNpa6twwbsgiLtZc8lY=;
	b=ypNAgJ5o2E2HrqlcasGti3LkSQNxdrXdZpK9JPzmPiIh+nieeotJtuQlam2QQUyW2FwdgK
	PTXD2VHGz/jsq5tyUvhb32brf7YVn8pAGjm3pFP23paDbqsC3zHyC5vEyb0dzfn20332oV
	An79ByquwbNn8fY1tIgq0ek90xdP5NmQVAqIJQcsVym2dtf4NY+MxC7X9kJGGLJRdmctMI
	RbW9wNm2ODt45AXRey4okBAxfJ4gm9i5puw5zidlTQdff1Cug1S/X3JyyWNH869ovgYHoC
	MGC9rcRrGreFKf8vfLaEEj3A+0EMyIHt4RNU5oUUpIozb4moQPfpwYvCiUY0aA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706028436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JGyehJjSy1LmtgI6x+CLT4pSFNpa6twwbsgiLtZc8lY=;
	b=C9fOdwLQ6ND8D7qlZS9r8hvXNfAPDcBSNny1G4lDDZmmjGLKyyOosAMtTuLln5/CCnRo5r
	hvBfT3Tyrd9KZoBg==
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	John Stultz <jstultz@google.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Clemens Ladisch <clemens@ladisch.de>,
	linux-doc@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [PATCH 2/8] hrtimers: Update formatting of documentation
Date: Tue, 23 Jan 2024 17:46:56 +0100
Message-Id: <20240123164702.55612-3-anna-maria@linutronix.de>
In-Reply-To: <20240123164702.55612-1-anna-maria@linutronix.de>
References: <20240123164702.55612-1-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Documentation of functions lacks the annotations which are used by
kernel-doc and *.rst to make appearance in rendered documents more
user-friendly.

Use those annotations to improve user-friendliness. While at it prevent
duplication of comments and use a reference instead.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 include/linux/hrtimer.h | 14 +++-----------
 kernel/time/hrtimer.c   | 18 ++++++++++--------
 2 files changed, 13 insertions(+), 19 deletions(-)

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 792a0ac75378..aa1e65ccb615 100644
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
index 760793998cdd..4c8dd633ab4a 100644
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
-- 
2.39.2


