Return-Path: <linux-kernel+bounces-139482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0AC48A03AA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 00:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A790B1F284CC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B542C5731B;
	Wed, 10 Apr 2024 22:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EPSlGxp8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zb94DRPm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF6057301
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 22:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712789227; cv=none; b=i5zttYu9p3a6bdfsSckoHFnwXCIxUT9Jg+ZWofv6bD1GkMqGb+MPgib54oe/yimrBa2nLDF99thJgUSokNqu/BSnI4JQGjhZkTLPFcxSPpcbkkqU+miIG+4QxlXMyN90Zh5+7hgPiWU1KIiIMQymhr6diP4DgF1GgRnSEv5TXpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712789227; c=relaxed/simple;
	bh=5k+o9FSXZnXGzFOAjEfjafxS6KdlxmAI2+L7+gmWoPY=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=WyUHX1PnXfCMjtO5C7szpB9i9zTwGeZ4CViIRkg9gDftcg7gdFRcS5JXKx4mPCDWTmM5knFnYhbLLeCp7i/cOA7w1lsv/HaKPUp8lm5LLFnnwy4pYUWUXInilGkY443lo+H8QjC8D5TzslCT5ZuzULRGbwAkXDwhtbe6c38BuNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EPSlGxp8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zb94DRPm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240410165552.772386179@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712789223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=PVNa4KLijTQ7CcOYu3CDLgD0Q8pt6GmBRvk3JFfaO1Y=;
	b=EPSlGxp8JXih8Om6h4+9QdMXVPd8lx7psYKe5X7Gu8B0B3ImRetobqK89Hommw1hGBIczx
	wWJYhjwCG+BJSP+LNlODvhYswd4fzEsPb6HJUPE1yOtlTpKjx80w3p7ubFUyE/abtH2Xpw
	4x4xZbpLdAY4rJPvjrZur/7dM0PB3Kvl5SJatuJ2YStmHVO8mE61HVOhdmm8b7MD7SHj+x
	+GQFtD+QREoUvpH+5xKbKbdOjz2pTwOwpKt6fISUtyM1PM8h425XkK46GzEI5jUxxRiDbG
	dIqIumyUmkndjun0XA7OxJzxfgK8vh9/sQ4oJINf22CvuEe/GD+f9Qa+GJw0Hg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712789223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=PVNa4KLijTQ7CcOYu3CDLgD0Q8pt6GmBRvk3JFfaO1Y=;
	b=zb94DRPmudpBTbZH4Dd+LKY50DUrgeyku8OyhgZ7LMUeHbT7W5RzyggyT/keTQ/LEjTG1R
	sXuecsE6cnDPfSDw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 John Stultz <jstultz@google.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>,
 Eric Biederman <ebiederm@xmission.com>,
 Oleg Nesterov <oleg@redhat.com>
Subject: [patch V2 29/50] posix-timers: Drop signal if timer has been deleted
 or reprogrammed
References: <20240410164558.316665885@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Apr 2024 00:47:03 +0200 (CEST)

No point in delivering a signal from the past. POSIX does not specify the
behaviour here:

 - "The effect of disarming or resetting a timer with pending expiration
    notifications is unspecified."

 - "The disposition of pending signals for the deleted timer is unspecified."

In both cases it is reasonable to expect that pending signals are
discarded. Especially in the reprogramming case it does not make sense to
account for previous overruns or to deliver a signal for a timer which has
been disarmed.

Drop the signal as that is conistent and understandable behaviour.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/posix-timers.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -250,14 +250,14 @@ static void common_hrtimer_rearm(struct
 }
 
 /*
- * This function is called from the signal delivery code if
- * info::si_sys_private is not zero, which indicates that the timer has to
- * be rearmed. Restart the timer and update info::si_overrun.
+ * This function is called from the signal delivery code. It decides
+ * whether the signal should be dropped and rearms interval timers.
  */
 bool posixtimer_deliver_signal(struct kernel_siginfo *info)
 {
 	struct k_itimer *timr;
 	unsigned long flags;
+	bool ret = false;
 
 	/*
 	 * Release siglock to ensure proper locking order versus
@@ -279,6 +279,7 @@ bool posixtimer_deliver_signal(struct ke
 
 		info->si_overrun = timer_overrun_to_int(timr, info->si_overrun);
 	}
+	ret = true;
 
 	unlock_timer(timr, flags);
 out:
@@ -286,7 +287,7 @@ bool posixtimer_deliver_signal(struct ke
 
 	/* Don't expose the si_sys_private value to userspace */
 	info->si_sys_private = 0;
-	return true;
+	return ret;
 }
 
 int posix_timer_queue_signal(struct k_itimer *timr)


