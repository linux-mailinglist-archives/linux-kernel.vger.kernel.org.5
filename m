Return-Path: <linux-kernel+bounces-76935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F26285FEDB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D7981C2276A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464E1155A5D;
	Thu, 22 Feb 2024 17:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s4eQYMgX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="99YW06g8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34101552E7;
	Thu, 22 Feb 2024 17:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708621931; cv=none; b=bZN4VHvlOxf1mfRgtXtbZkISBzoH5RJU1nD6J9UOMu+oOZcQOBQXRiUWod9utcCDoJ1YuSgRceskzZrtawy5Doxq3J4umG7wtmHCi59HyP48qaSemi518MqS9sOrlbUy691hYqid+AS78s0Ydjer4lbaLDivTw+X5Rlo9BSmbyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708621931; c=relaxed/simple;
	bh=85Za/XRwJbGoco/mpMKTJgU7f9nR6YT3vmk3FqqR8T8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=cJEN/HkwXmU3Ar/q1dwxy+eS+XqMLa3mnMxfPyE/P7O8TLye5KZmydZCiqDUG9ZUw81HrWV9N45y5jn9v0gOEAc6KIu7uchaA+6XJMIJQsC+7f9XOQAwngw2MFic3PoUarg+Zgua0kqFTordy23uic9mF1pzVpnY9KigAKgPXxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s4eQYMgX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=99YW06g8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 22 Feb 2024 17:12:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708621928;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y0VekA1LeP6+r0oR7f6bRGXegQ8bvVyk9FWZ6lTy+kE=;
	b=s4eQYMgX31VL5yJoePmyI6RlW9Xt8KqJVxIw5KqELZHMZVfRYcyPgFpBkctzEYDWlTdi6t
	2w/GR2Zl3oz6/GHKwsjod+yHyhtyXk+PiEcqjmhEqVtiVFIFABhsEWkyCJ1DOBGFD3m9//
	r7/jwzb6aQhoHrviY3rEenBUVvGgkzt02VCv3XEScZm1udsU4jF6+8uy6QWf4EhObcvupK
	WT7PdZUBeUkYSMinht/aHpw8EMy0QIejDgm9P4CrEtwTAdSmNdvTchunScnX6dlKoieltz
	Wer3qFchEqEsyEUTAomBGJkDzeHAYpdGXlgswWKefnwj/ZYyJsgCH3TOJdtV7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708621928;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y0VekA1LeP6+r0oR7f6bRGXegQ8bvVyk9FWZ6lTy+kE=;
	b=99YW06g85I69+UY3kh3ztNClNbMZaUU8dBY8QdbaOI1+P2miuw+DDO33u3v4Sp3GlZxk6T
	7Zno27Z6R3FNbzCA==
From:
 "tip-bot2 for Richard Cochran (linutronix GmbH)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] tick/sched: Split out jiffies update helper function
Cc: "Richard Cochran (linutronix GmbH)" <richardcochran@gmail.com>,
 "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240221090548.36600-17-anna-maria@linutronix.de>
References: <20240221090548.36600-17-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170862192736.398.7443527640272199216.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     4c532939aa2e9345ee346bc69d3d12d56d5aa9aa
Gitweb:        https://git.kernel.org/tip/4c532939aa2e9345ee346bc69d3d12d56d5aa9aa
Author:        Richard Cochran (linutronix GmbH) <richardcochran@gmail.com>
AuthorDate:    Wed, 21 Feb 2024 10:05:44 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 22 Feb 2024 17:52:32 +01:00

tick/sched: Split out jiffies update helper function

The logic to get the time of the last jiffies update will be needed by
the timer pull model as well.

Move the code into a global function in anticipation of the new caller.

No functional change.

Signed-off-by: Richard Cochran (linutronix GmbH) <richardcochran@gmail.com>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20240221090548.36600-17-anna-maria@linutronix.de

---
 kernel/time/tick-internal.h |  1 +
 kernel/time/tick-sched.c    | 26 +++++++++++++++++++-------
 2 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/kernel/time/tick-internal.h b/kernel/time/tick-internal.h
index 8b0c28e..ccf39be 100644
--- a/kernel/time/tick-internal.h
+++ b/kernel/time/tick-internal.h
@@ -157,6 +157,7 @@ static inline void tick_nohz_init(void) { }
 #ifdef CONFIG_NO_HZ_COMMON
 extern unsigned long tick_nohz_active;
 extern void timers_update_nohz(void);
+extern u64 get_jiffies_update(unsigned long *basej);
 # ifdef CONFIG_SMP
 extern struct static_key_false timers_migration_enabled;
 extern void fetch_next_timer_interrupt_remote(unsigned long basej, u64 basem,
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index f6b6133..417bb7f 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -799,6 +799,24 @@ static inline bool local_timer_softirq_pending(void)
 	return local_softirq_pending() & BIT(TIMER_SOFTIRQ);
 }
 
+/*
+ * Read jiffies and the time when jiffies were updated last
+ */
+u64 get_jiffies_update(unsigned long *basej)
+{
+	unsigned long basejiff;
+	unsigned int seq;
+	u64 basemono;
+
+	do {
+		seq = read_seqcount_begin(&jiffies_seq);
+		basemono = last_jiffies_update;
+		basejiff = jiffies;
+	} while (read_seqcount_retry(&jiffies_seq, seq));
+	*basej = basejiff;
+	return basemono;
+}
+
 /**
  * tick_nohz_next_event() - return the clock monotonic based next event
  * @ts:		pointer to tick_sched struct
@@ -813,14 +831,8 @@ static ktime_t tick_nohz_next_event(struct tick_sched *ts, int cpu)
 {
 	u64 basemono, next_tick, delta, expires;
 	unsigned long basejiff;
-	unsigned int seq;
 
-	/* Read jiffies and the time when jiffies were updated last */
-	do {
-		seq = read_seqcount_begin(&jiffies_seq);
-		basemono = last_jiffies_update;
-		basejiff = jiffies;
-	} while (read_seqcount_retry(&jiffies_seq, seq));
+	basemono = get_jiffies_update(&basejiff);
 	ts->last_jiffies = basejiff;
 	ts->timer_expires_base = basemono;
 

