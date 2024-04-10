Return-Path: <linux-kernel+bounces-139481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 468358A03A9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 00:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CED7C1F28117
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700CF56B9C;
	Wed, 10 Apr 2024 22:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CfjuLqyF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UWn/b8x5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C68C56448
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 22:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712789224; cv=none; b=tNhEg/1weEzjeb7z0HKNfyks28QkKrNQ6H+/FnU90cEeooFpld1j1TTF34hAibBfZRoTb5AJXpsP+IsOBwfjNLIUzqgazdtau2v1L7Fo8cnbgr7TvzPBuRnNTP92IFVqytz6W4pnE1A+OR9+nrOwNet8PtQ6bzvVVo1MQ13pZL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712789224; c=relaxed/simple;
	bh=YH2GNJxCNBMbmtwU0fr39UpQz8wyT6gB/kPu6Cst2a0=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=tS7ndSpf9N0ztTc+ZXzX5azUoDFqU2gNzjOwOMRwog9d5RlNCWqlLhIWWsJSiMXv1uZhGSV1TrsO8sZOEWcrs7S+Q7m4A0XaaCwzKyfkV9XdML7UE+HPaBLv/64aY8QuSTbduMPkiJwZ9yNaTYZZX6EK6VDWYhSBg84+tS/3LS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CfjuLqyF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UWn/b8x5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240410165552.697213341@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712789221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=7CK+FAEXH0tvW3CxjLUKVaxfftLEf1lOjkxUKErNSnE=;
	b=CfjuLqyFZC+9G/0y3VW1+Tuaz6Hw3HwQNTnj/doY2nvvH5gIQ7JT9KhnOqGsZJ11kxkN42
	h8762CtIf2YnysV/4+EUlJcahi77wpGCMHC70BglasJ+pcDkRD/JjD7yKFrD2iHZ5bkHeV
	Kch01mVb4qoqtbpipRc1b7NZpCYL/W3U/DJDkDgfGBSa5kFXaB4LWsxyy/m34Ojd9d8+7t
	ViF6P08BA2KXFZAopUk/Ch8uKP1dyAhX4NeBPQsHS1ECp59NdMpaBdAFaAKthGAsYo66dG
	DpaVoeM/RyU7a4zGym42u/W9pVOr1b/fewgh2R6GxKLRlOA/+4DSVRevp2fxvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712789221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=7CK+FAEXH0tvW3CxjLUKVaxfftLEf1lOjkxUKErNSnE=;
	b=UWn/b8x5KNguxyhReCU0noKBkvAay0Y9758nFeM5K38fgXYetzIHkj2siO4kAZzg3lFlfJ
	Uf5lpG5kk3BMukBQ==
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
Subject: [patch V2 28/50] signal: Allow POSIX timer signals to be dropped
References: <20240410164558.316665885@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Apr 2024 00:47:01 +0200 (CEST)

In case that a timer was reprogrammed or deleted an already pending signal
is obsolete. Right now such signals are kept around and eventually
delivered. While POSIX is blury about this:

 - "The effect of disarming or resetting a timer with pending expiration
    notifications is unspecified."

 - "The disposition of pending signals for the deleted timer is
    unspecified."

it is reasonable in both cases to expect that pending signals are discarded
as they have no meaning anymore.

Prepare the signal code to allow dropping posix timer signals.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/posix-timers.h |    5 +++--
 kernel/signal.c              |    7 +++++--
 kernel/time/posix-timers.c   |    3 ++-
 3 files changed, 10 insertions(+), 5 deletions(-)

--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -100,8 +100,9 @@ static inline void posix_cputimers_rt_wa
 {
 	pct->bases[CPUCLOCK_SCHED].nextevt = runtime;
 }
+
 void posixtimer_rearm_itimer(struct task_struct *p);
-void posixtimer_rearm(struct kernel_siginfo *info);
+bool posixtimer_deliver_signal(struct kernel_siginfo *info);
 
 /* Init task static initializer */
 #define INIT_CPU_TIMERBASE(b) {						\
@@ -125,7 +126,7 @@ static inline void posix_cputimers_init(
 static inline void posix_cputimers_group_init(struct posix_cputimers *pct,
 					      u64 cpu_limit) { }
 static inline void posixtimer_rearm_itimer(struct task_struct *p) { }
-static inline void posixtimer_rearm(struct kernel_siginfo *info) { }
+static inline bool posixtimer_deliver_signal(struct kernel_siginfo *info) { return false; }
 #endif
 
 #ifdef CONFIG_POSIX_CPU_TIMERS_TASK_WORK
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -585,6 +585,7 @@ int dequeue_signal(sigset_t *mask, kerne
 
 	lockdep_assert_held(&tsk->sighand->siglock);
 
+again:
 	*type = PIDTYPE_PID;
 	signr = __dequeue_signal(&tsk->pending, mask, info);
 	if (!signr) {
@@ -616,8 +617,10 @@ int dequeue_signal(sigset_t *mask, kerne
 	}
 
 	if (IS_ENABLED(CONFIG_POSIX_TIMERS)) {
-		if (unlikely(info->si_code == SI_TIMER && info->si_sys_private))
-			posixtimer_rearm(info);
+		if (unlikely(info->si_code == SI_TIMER && info->si_sys_private)) {
+			if (!posixtimer_deliver_signal(info))
+				goto again;
+		}
 	}
 
 	return signr;
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -254,7 +254,7 @@ static void common_hrtimer_rearm(struct
  * info::si_sys_private is not zero, which indicates that the timer has to
  * be rearmed. Restart the timer and update info::si_overrun.
  */
-void posixtimer_rearm(struct kernel_siginfo *info)
+bool posixtimer_deliver_signal(struct kernel_siginfo *info)
 {
 	struct k_itimer *timr;
 	unsigned long flags;
@@ -286,6 +286,7 @@ void posixtimer_rearm(struct kernel_sigi
 
 	/* Don't expose the si_sys_private value to userspace */
 	info->si_sys_private = 0;
+	return true;
 }
 
 int posix_timer_queue_signal(struct k_itimer *timr)


