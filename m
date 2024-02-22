Return-Path: <linux-kernel+bounces-76944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB03F85FEEF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D91A61C24AC6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298BC158D89;
	Thu, 22 Feb 2024 17:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UxMXRSXq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mUTCeVe7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E915E15699C;
	Thu, 22 Feb 2024 17:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708621937; cv=none; b=J6PGGnJt9A948owK0ay93feBJZj53nX9gf2EK3jRuuf1oQsFnuJeoFkphU5EcFpv2rQtMW1PWvxAHdsK1iPihuZHbtex6zwP/zdv42ETkWGjrOl62w0LEYTX4HmmKp53jc3cziW4qgWCDdVgYb7vgtcVBqGG9NejSSH7uw8TGLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708621937; c=relaxed/simple;
	bh=b1z7GnbyN0ldCazql5PdxJp6VHx/42d4ksZWdGGvzv0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=i8lHnGq6f0rtEO7zlwwyj1ZH0y2zF5qOHpMbN8sFEwbzZvWYF8Lsn1Ekt6muv7gMSs7r8wsPOjZu0x6217Zw8pMAz2gwHGZRSfXjwqXTwAbAvjJCDNTeZTK2+yT67u2ntKrUTXXieG6pf9cgvN+uhTdXULtR9V6+/WWVUeK2hD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UxMXRSXq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mUTCeVe7; arc=none smtp.client-ip=193.142.43.55
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
	bh=PMFwc9ziy4sgLMBbGIwj9WsZIPLBHFSNRCf3gvy0meY=;
	b=UxMXRSXq/ZSWXOUHsry8zX0Z/ThKhJirnIk+zXOrKmwoOb3syb9b3lkJATmxrOpUIDXhDi
	BxcsT+12Y/RI/rNP+wXl9MPiGH+8XKa/cauDKuATe2qqW3vULtI5EZc0L9LgxVLv97VR4M
	FQV5BgMtM4saBedTnDdNQ3qLdF9JndBwACMhA6R1EuC9Qq2Mm9LRv1/qh7VywSALk5M1tf
	vEvfH5DtuL/mVeaGS5qcwd0KDFEa8e+htUoKQfZIAOnEkt46NVca95bsED2DiEsHHp7Omh
	ggTpRZIX2oiw4OmTmtZysia/Jb/xohxNcfoNmlEvQwsBW/zBCVA/I7rhai26Ow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708621932;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PMFwc9ziy4sgLMBbGIwj9WsZIPLBHFSNRCf3gvy0meY=;
	b=mUTCeVe70IciEoS112SJ2GgRZuUigT/s5bBv4d4HjacNjE7xys0PExa/nzQPFzJd6kDjnG
	1+YnSc3eCNTXdUCQ==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] timers: Keep the pinned timers separate from the others
Cc: "Richard Cochran (linutronix GmbH)" <richardcochran@gmail.com>,
 "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240221090548.36600-11-anna-maria@linutronix.de>
References: <20240221090548.36600-11-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170862193130.398.10776047076792800491.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     83a665dc99a7b0721fa1e02fb60d2a1789ccd371
Gitweb:        https://git.kernel.org/tip/83a665dc99a7b0721fa1e02fb60d2a1789ccd371
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Wed, 21 Feb 2024 10:05:38 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 22 Feb 2024 17:52:31 +01:00

timers: Keep the pinned timers separate from the others

Separate the storage space for pinned timers. Deferrable timers (doesn't
matter if pinned or non pinned) are still enqueued into their own base.

This is preparatory work for changing the NOHZ timer placement from a push
at enqueue time to a pull at expiry time model.

Originally-by: Richard Cochran (linutronix GmbH) <richardcochran@gmail.com>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20240221090548.36600-11-anna-maria@linutronix.de

---
 kernel/time/timer.c | 85 ++++++++++++++++++++++++++++----------------
 1 file changed, 56 insertions(+), 29 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 748f4b7..aabd136 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -187,12 +187,18 @@ EXPORT_SYMBOL(jiffies_64);
 #define WHEEL_SIZE	(LVL_SIZE * LVL_DEPTH)
 
 #ifdef CONFIG_NO_HZ_COMMON
-# define NR_BASES	2
-# define BASE_STD	0
-# define BASE_DEF	1
+/*
+ * If multiple bases need to be locked, use the base ordering for lock
+ * nesting, i.e. lowest number first.
+ */
+# define NR_BASES	3
+# define BASE_LOCAL	0
+# define BASE_GLOBAL	1
+# define BASE_DEF	2
 #else
 # define NR_BASES	1
-# define BASE_STD	0
+# define BASE_LOCAL	0
+# define BASE_GLOBAL	0
 # define BASE_DEF	0
 #endif
 
@@ -944,7 +950,10 @@ static int detach_if_pending(struct timer_list *timer, struct timer_base *base,
 
 static inline struct timer_base *get_timer_cpu_base(u32 tflags, u32 cpu)
 {
-	struct timer_base *base = per_cpu_ptr(&timer_bases[BASE_STD], cpu);
+	int index = tflags & TIMER_PINNED ? BASE_LOCAL : BASE_GLOBAL;
+	struct timer_base *base;
+
+	base = per_cpu_ptr(&timer_bases[index], cpu);
 
 	/*
 	 * If the timer is deferrable and NO_HZ_COMMON is set then we need
@@ -957,7 +966,10 @@ static inline struct timer_base *get_timer_cpu_base(u32 tflags, u32 cpu)
 
 static inline struct timer_base *get_timer_this_cpu_base(u32 tflags)
 {
-	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_STD]);
+	int index = tflags & TIMER_PINNED ? BASE_LOCAL : BASE_GLOBAL;
+	struct timer_base *base;
+
+	base = this_cpu_ptr(&timer_bases[index]);
 
 	/*
 	 * If the timer is deferrable and NO_HZ_COMMON is set then we need
@@ -2006,6 +2018,9 @@ static unsigned long next_timer_interrupt(struct timer_base *base,
 	 * Move next_expiry for the empty base into the future to prevent an
 	 * unnecessary raise of the timer softirq when the next_expiry value
 	 * will be reached even if there is no timer pending.
+	 *
+	 * This update is also required to make timer_base::next_expiry values
+	 * easy comparable to find out which base holds the first pending timer.
 	 */
 	if (!base->timers_pending)
 		base->next_expiry = basej + NEXT_TIMER_MAX_DELTA;
@@ -2016,9 +2031,10 @@ static unsigned long next_timer_interrupt(struct timer_base *base,
 static inline u64 __get_next_timer_interrupt(unsigned long basej, u64 basem,
 					     bool *idle)
 {
-	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_STD]);
+	unsigned long nextevt, nextevt_local, nextevt_global;
+	struct timer_base *base_local, *base_global;
 	u64 expires = KTIME_MAX;
-	unsigned long nextevt;
+	bool local_first;
 
 	/*
 	 * Pretend that there is no timer pending if the cpu is offline.
@@ -2030,10 +2046,20 @@ static inline u64 __get_next_timer_interrupt(unsigned long basej, u64 basem,
 		return expires;
 	}
 
-	raw_spin_lock(&base->lock);
-	nextevt = next_timer_interrupt(base, basej);
+	base_local = this_cpu_ptr(&timer_bases[BASE_LOCAL]);
+	base_global = this_cpu_ptr(&timer_bases[BASE_GLOBAL]);
 
-	if (base->timers_pending) {
+	raw_spin_lock(&base_local->lock);
+	raw_spin_lock_nested(&base_global->lock, SINGLE_DEPTH_NESTING);
+
+	nextevt_local = next_timer_interrupt(base_local, basej);
+	nextevt_global = next_timer_interrupt(base_global, basej);
+
+	local_first = time_before_eq(nextevt_local, nextevt_global);
+
+	nextevt = local_first ? nextevt_local : nextevt_global;
+
+	if (base_local->timers_pending || base_global->timers_pending) {
 		/* If we missed a tick already, force 0 delta */
 		if (time_before(nextevt, basej))
 			nextevt = basej;
@@ -2044,31 +2070,31 @@ static inline u64 __get_next_timer_interrupt(unsigned long basej, u64 basem,
 	 * We have a fresh next event. Check whether we can forward the
 	 * base.
 	 */
-	__forward_timer_base(base, basej);
+	__forward_timer_base(base_local, basej);
+	__forward_timer_base(base_global, basej);
 
 	/*
 	 * Set base->is_idle only when caller is timer_base_try_to_set_idle()
 	 */
 	if (idle) {
 		/*
-		 * Base is idle if the next event is more than a tick away.
+		 * Bases are idle if the next event is more than a tick away.
 		 *
 		 * If the base is marked idle then any timer add operation must
 		 * forward the base clk itself to keep granularity small. This
-		 * idle logic is only maintained for the BASE_STD base,
-		 * deferrable timers may still see large granularity skew (by
-		 * design).
+		 * idle logic is only maintained for the BASE_LOCAL and
+		 * BASE_GLOBAL base, deferrable timers may still see large
+		 * granularity skew (by design).
 		 */
-		if (!base->is_idle) {
-			if (time_after(nextevt, basej + 1)) {
-				base->is_idle = true;
-				trace_timer_base_idle(true, base->cpu);
-			}
+		if (!base_local->is_idle && time_after(nextevt, basej + 1)) {
+			base_local->is_idle = base_global->is_idle = true;
+			trace_timer_base_idle(true, base_local->cpu);
 		}
-		*idle = base->is_idle;
+		*idle = base_local->is_idle;
 	}
 
-	raw_spin_unlock(&base->lock);
+	raw_spin_unlock(&base_global->lock);
+	raw_spin_unlock(&base_local->lock);
 
 	return cmp_next_hrtimer_event(basem, expires);
 }
@@ -2112,15 +2138,14 @@ u64 timer_base_try_to_set_idle(unsigned long basej, u64 basem, bool *idle)
  */
 void timer_clear_idle(void)
 {
-	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_STD]);
-
 	/*
 	 * We do this unlocked. The worst outcome is a remote enqueue sending
 	 * a pointless IPI, but taking the lock would just make the window for
 	 * sending the IPI a few instructions smaller for the cost of taking
 	 * the lock in the exit from idle path.
 	 */
-	base->is_idle = false;
+	__this_cpu_write(timer_bases[BASE_LOCAL].is_idle, false);
+	__this_cpu_write(timer_bases[BASE_GLOBAL].is_idle, false);
 	trace_timer_base_idle(false, smp_processor_id());
 }
 #endif
@@ -2171,11 +2196,13 @@ static inline void __run_timers(struct timer_base *base)
  */
 static __latent_entropy void run_timer_softirq(struct softirq_action *h)
 {
-	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_STD]);
+	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_LOCAL]);
 
 	__run_timers(base);
-	if (IS_ENABLED(CONFIG_NO_HZ_COMMON))
+	if (IS_ENABLED(CONFIG_NO_HZ_COMMON)) {
+		__run_timers(this_cpu_ptr(&timer_bases[BASE_GLOBAL]));
 		__run_timers(this_cpu_ptr(&timer_bases[BASE_DEF]));
+	}
 }
 
 /*
@@ -2183,7 +2210,7 @@ static __latent_entropy void run_timer_softirq(struct softirq_action *h)
  */
 static void run_local_timers(void)
 {
-	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_STD]);
+	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_LOCAL]);
 
 	hrtimer_run_queues();
 

