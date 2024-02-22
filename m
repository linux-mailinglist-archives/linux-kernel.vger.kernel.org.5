Return-Path: <linux-kernel+bounces-76942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDA685FEE9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 071711F297E5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956C81586F1;
	Thu, 22 Feb 2024 17:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R+6jPuIe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L+egk84S"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7E3157E66;
	Thu, 22 Feb 2024 17:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708621936; cv=none; b=SgC264zp9mh9CbL5+xOfvXSRkLO6Zi8/iUdO9ByRSR1eazbhDj8BS5gGfuaihu06whL2zIzfzYSTbreNYeuQw5v8D5yZSim3IonbDfoaXzRN9P3LmMCF75Us2lFAXesNv/kvRPdpHOgtDDxqmFK4QnbYgLpN5ey6Elciy/caEUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708621936; c=relaxed/simple;
	bh=ywyKU2i+iIGKnVYxExQHGgbYNFBNoBGEoymVEtbF69E=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=dlviTPZVornhswU3UAfpa667v5dLqCe2maby+Fi9Zdydt8szAe+zu/2QnCbT6wsdeD3ahK5coHrWk+V5+/qmGK9QvRkaPY0+h078VI6BnQBImptxjSJiPivxeaHJD6sqmP01SrOM9DgYCIQdxSigMJjM7wUxOQFwjcSvKJ8dhtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R+6jPuIe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L+egk84S; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 22 Feb 2024 17:12:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708621932;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gxu6BvrUkKydEe7CgoO8F5VBZOS7beatE9R6vgMaZZg=;
	b=R+6jPuIe2QUokAGPZIKVMvGz6XVQeDd9EpDNW11l7hJelaHiwps3yNRUrym8cFShpAt0P2
	ERCFgdE0NCsV2+VxmPbyRYJ1W8mIqJpmGTk1qkCyxRMUAB2PlDY+ckM6+Y3cDFTqb2GEYu
	aOopgRAKvDVJ8usqR/7pSx77nkAm/elY4yGgL9xmVKT9+isOl+SUvPNahGiyqXe6We2WfY
	HCFFzMgZ/ucryK0XOedaBaVRscNIUuYlA1dAxZZn44i35c8PSvfMP6mmuQv0pYcNmrkIiE
	1FJj2LChrj+X3eGwBnD5aOuV9JN8grI/Hpr3fQ3fDH8GmI1iGgAAEaQx7GAVqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708621932;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gxu6BvrUkKydEe7CgoO8F5VBZOS7beatE9R6vgMaZZg=;
	b=L+egk84S5Xai24ptoWB2pC38UwwLlzT31Rpo70tyofCId+MQgTEDO7utqiWYMfF6ZiAP09
	tHELDETPI5l9mpAQ==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timers: Split next timer interrupt logic
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240221090548.36600-10-anna-maria@linutronix.de>
References: <20240221090548.36600-10-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170862193196.398.1092617001269334520.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     9f6a3c602c235c3cccbe673fb7e1cca30ca4be0d
Gitweb:        https://git.kernel.org/tip/9f6a3c602c235c3cccbe673fb7e1cca30ca4be0d
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Wed, 21 Feb 2024 10:05:37 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 22 Feb 2024 17:52:31 +01:00

timers: Split next timer interrupt logic

Split the logic for getting next timer interrupt (no matter of recalculated
or already stored in base->next_expiry) into a separate function named
next_timer_interrupt(). Make it available to local call sites only.

No functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20240221090548.36600-10-anna-maria@linutronix.de

---
 kernel/time/timer.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 9c8443d..748f4b7 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1996,12 +1996,29 @@ static u64 cmp_next_hrtimer_event(u64 basem, u64 expires)
 	return DIV_ROUND_UP_ULL(nextevt, TICK_NSEC) * TICK_NSEC;
 }
 
+static unsigned long next_timer_interrupt(struct timer_base *base,
+					  unsigned long basej)
+{
+	if (base->next_expiry_recalc)
+		next_expiry_recalc(base);
+
+	/*
+	 * Move next_expiry for the empty base into the future to prevent an
+	 * unnecessary raise of the timer softirq when the next_expiry value
+	 * will be reached even if there is no timer pending.
+	 */
+	if (!base->timers_pending)
+		base->next_expiry = basej + NEXT_TIMER_MAX_DELTA;
+
+	return base->next_expiry;
+}
+
 static inline u64 __get_next_timer_interrupt(unsigned long basej, u64 basem,
 					     bool *idle)
 {
 	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_STD]);
-	unsigned long nextevt = basej + NEXT_TIMER_MAX_DELTA;
 	u64 expires = KTIME_MAX;
+	unsigned long nextevt;
 
 	/*
 	 * Pretend that there is no timer pending if the cpu is offline.
@@ -2014,24 +2031,13 @@ static inline u64 __get_next_timer_interrupt(unsigned long basej, u64 basem,
 	}
 
 	raw_spin_lock(&base->lock);
-	if (base->next_expiry_recalc)
-		next_expiry_recalc(base);
+	nextevt = next_timer_interrupt(base, basej);
 
 	if (base->timers_pending) {
-		nextevt = base->next_expiry;
-
 		/* If we missed a tick already, force 0 delta */
 		if (time_before(nextevt, basej))
 			nextevt = basej;
 		expires = basem + (u64)(nextevt - basej) * TICK_NSEC;
-	} else {
-		/*
-		 * Move next_expiry for the empty base into the future to
-		 * prevent a unnecessary raise of the timer softirq when the
-		 * next_expiry value will be reached even if there is no timer
-		 * pending.
-		 */
-		base->next_expiry = nextevt;
 	}
 
 	/*

