Return-Path: <linux-kernel+bounces-139492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7867D8A03B4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 00:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 333DE28A5F7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05DC3FE5B;
	Wed, 10 Apr 2024 22:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IQJwS85w";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VwaX23gM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC532130AF5
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 22:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712789244; cv=none; b=LsuJ0btTvAHI20F0IDLLNT9ahq38nX4LNqra6w+pb+5A4ENHAxXpak8cAcAco4v8xL3DtQiV6YPwrHCQ9OeSPEI4DJYek0ACdyZ41Ao1gB6Sb4R630edznefOPqP7Xw0ZnGD6Cx0PQ4vvwr5iMjLfkvsStd9aSrbBIVhgoQEF9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712789244; c=relaxed/simple;
	bh=Bp/mJsKy0K7y+W6reqzXaf54OlcjiFTLH7F90/BxRvU=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=PM3AgPrRRqNS7i88h8XdvonOYvyfQzbPXenPDk2fz/UI5QFbkLX5Dtfn96edCEdmjzl4fSxJYZAVCzFBpuR8+hKtPP1fOTgSzDmIF7+c4knOjPs502MvfVf7S+QqN6BAOCWxFD4+bmZ2iQ4u5CsUYBI8MOFqkqk4+qgaCEcnBYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IQJwS85w; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VwaX23gM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240410165553.387066593@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712789241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=lbd4hY6DO5yS4CWfhpTcHrpvo9CKLyiSwH3SuNY1ueE=;
	b=IQJwS85wFDXsrKe0C6XWzpveznQFewwTyDCb6S/ynb+fO+Ap9ITuNiIhpcYWswPXOLW/Ov
	Cr1WJEL3aPShg3IazMwt1/vQygY1OmwgxbCt0O0ubNuwG7cCTCAPx1SINo6Jupgbx6kt0N
	YaKRmjz6u6QO5IIHNLXuZ8WKKlCZvveBhb0Up3CrI21o+RXS8auZdZQp2XFaIYk3ne8zY3
	xmzIimj3nXjOUFzul8p+785gel/hSyDdFh9zppUwvyKaAniRphH/F6Y2VXB/VYkDKnFhdZ
	/79LvgkydAvGJlCnoYZ1VGEJsesmMBO+8F6LE1C2Sz3XRoRVdIxbhTl49/OBkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712789241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=lbd4hY6DO5yS4CWfhpTcHrpvo9CKLyiSwH3SuNY1ueE=;
	b=VwaX23gMKC01DU1IKqG7texaZGLY/Rg1ekcZAmiKs1W3FG27Latp+P3mvI3Kc+OUWf9vQF
	EB17bB3MjtD5XaCQ==
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
Subject: [patch V2 39/50] posix-timers: Store PID type in the timer
References: <20240410164558.316665885@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Apr 2024 00:47:20 +0200 (CEST)

instead of re-evaluating the signal delivery mode everywhere.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/posix-timers.h |    2 ++
 kernel/time/posix-timers.c   |    9 ++++++---
 2 files changed, 8 insertions(+), 3 deletions(-)

--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -5,6 +5,7 @@
 #include <linux/alarmtimer.h>
 #include <linux/list.h>
 #include <linux/mutex.h>
+#include <linux/pid.h>
 #include <linux/posix-timers_types.h>
 #include <linux/rcuref.h>
 #include <linux/spinlock.h>
@@ -180,6 +181,7 @@ struct k_itimer {
 	s64			it_overrun_last;
 	unsigned int		it_signal_seq;
 	int			it_sigev_notify;
+	enum pid_type		it_pid_type;
 	ktime_t			it_interval;
 	struct signal_struct	*it_signal;
 	union {
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -298,7 +298,6 @@ bool posixtimer_deliver_signal(struct ke
 int posix_timer_queue_signal(struct k_itimer *timr)
 {
 	enum posix_timer_state state = POSIX_TIMER_DISARMED;
-	enum pid_type type;
 	int ret;
 
 	lockdep_assert_held(&timr->it_lock);
@@ -309,8 +308,7 @@ int posix_timer_queue_signal(struct k_it
 	}
 	timr->it_status = state;
 
-	type = !(timr->it_sigev_notify & SIGEV_THREAD_ID) ? PIDTYPE_TGID : PIDTYPE_PID;
-	ret = send_sigqueue(timr->sigq, timr->it_pid, type, timr->it_signal_seq);
+	ret = send_sigqueue(timr->sigq, timr->it_pid, timr->it_pid_type, timr->it_signal_seq);
 	/* If we failed to send the signal the timer stops. */
 	return ret > 0;
 }
@@ -504,6 +502,11 @@ static int do_timer_create(clockid_t whi
 		new_timer->it_pid = get_pid(task_tgid(current));
 	}
 
+	if (new_timer->it_sigev_notify & SIGEV_THREAD_ID)
+		new_timer->it_pid_type = PIDTYPE_PID;
+	else
+		new_timer->it_pid_type = PIDTYPE_TGID;
+
 	new_timer->sigq->info.si_tid   = new_timer->it_id;
 	new_timer->sigq->info.si_code  = SI_TIMER;
 	new_timer->sigq->info.si_sys_privptr  = new_timer;


