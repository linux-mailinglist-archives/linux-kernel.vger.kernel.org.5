Return-Path: <linux-kernel+bounces-76943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5B885FEEC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4B5A1F29C51
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D0E158D76;
	Thu, 22 Feb 2024 17:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iqU4AIn6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ySaNGDEz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45220156998;
	Thu, 22 Feb 2024 17:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708621937; cv=none; b=A/2Ab8ZYUn0N4fAviSZYolTROnjtbXWTYKqYZCo/JXtOHfApMW20JWq75fFZeJqHqbz0cWqAIaYrjrtDWWfMIjUhu6EImgzY6nWBYR29rRaLu7rp3oTPN5UJ3jYy53W6fCve8tH7uvsuQN2OXK2zwb8qSVqndND43RmytfxqIQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708621937; c=relaxed/simple;
	bh=MfWuiBK/m+NRYyBOunvmpucUCdyGR+jmSrElFB303iI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=GBG6Y4W/FRhSTu6OMsPtH98+6tRKLyuQexFl1K7o+kE9dI2PrDP6PkGER/d0M8bQqTTtkEsxm4qBavHOMr1sLBz6qoaA4xMEk1th7R/2FBWzQNb0ft3OLXE4qqR9GbXRrt12tafPOMvjB0Wd15sYeyGm/fRaln+vjt/4DLGO9uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iqU4AIn6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ySaNGDEz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 22 Feb 2024 17:12:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708621933;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aPuKscbLmQCwJejxlBLH7lYZEv+GBgNpH9gNdQbiykI=;
	b=iqU4AIn6NrLUDRh/XraKAdf7e4doCPx/ac0uermHBSDG5Ik0R24oRtIszDX97NTVsaM9Mn
	Lhfr1zFX0W8uRU4yOVKe4ld0aXxlpVqJBnH/BwY+ojpTn5oR5ooT+isz/YQOHi+ednpM8G
	gKzVOln8GZpQ7GPTYRcUp3WOMku5oKcm6wob8nujiJ8hVg5czFj7q458IHtfrsZKadd3ce
	CkvesNCibWWdkINlVOjY87vsd6MZG3Ao10fHlMxeEOBtKpThkWo17TEbg0IURESoF6dsEx
	LZNa74rT/G/vxQ91ZK/q5xVRY7x/ebQnEHDjvF9VVHn2fo9mM8li5fFdRu09SA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708621933;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aPuKscbLmQCwJejxlBLH7lYZEv+GBgNpH9gNdQbiykI=;
	b=ySaNGDEzo81eZ42r64yUiksG6+9V7Kqect3ydlvByKdoKhbYUqH7ZUEgxR1iKqLo79xZCl
	JYGgEdR3HQyYbrDA==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timers: Simplify code in run_local_timers()
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240221090548.36600-9-anna-maria@linutronix.de>
References: <20240221090548.36600-9-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170862193261.398.16190156400027177660.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     af68cb3fc736e13e66fc8202ea94c3aff7299f39
Gitweb:        https://git.kernel.org/tip/af68cb3fc736e13e66fc8202ea94c3aff7299f39
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Wed, 21 Feb 2024 10:05:36 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 22 Feb 2024 17:52:31 +01:00

timers: Simplify code in run_local_timers()

The logic for raising a softirq the way it is implemented right now, is
readable for two timer bases. When increasing the number of timer bases,
code gets harder to read. With the introduction of the timer migration
hierarchy, there will be three timer bases.

Therefore restructure the code to use a loop. No functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20240221090548.36600-9-anna-maria@linutronix.de

---
 kernel/time/timer.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 121f5b9..9c8443d 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -2180,16 +2180,14 @@ static void run_local_timers(void)
 	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_STD]);
 
 	hrtimer_run_queues();
-	/* Raise the softirq only if required. */
-	if (time_before(jiffies, base->next_expiry)) {
-		if (!IS_ENABLED(CONFIG_NO_HZ_COMMON))
-			return;
-		/* CPU is awake, so check the deferrable base. */
-		base++;
-		if (time_before(jiffies, base->next_expiry))
+
+	for (int i = 0; i < NR_BASES; i++, base++) {
+		/* Raise the softirq only if required. */
+		if (time_after_eq(jiffies, base->next_expiry)) {
+			raise_softirq(TIMER_SOFTIRQ);
 			return;
+		}
 	}
-	raise_softirq(TIMER_SOFTIRQ);
 }
 
 /*

