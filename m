Return-Path: <linux-kernel+bounces-139487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B868A03AF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 00:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5A4E1C2101F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9BE8593D;
	Wed, 10 Apr 2024 22:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VnUu5UoH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CFtICFy1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E088B8175E
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 22:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712789235; cv=none; b=Uo7qT/60Ujd9L67JKzv3NZoCK8BHo31QAWFWVNKQmZ9KiaAogPVDlBsob9w3+o4JZOmQxDDzzlexRm/hq41fGSO2wYymr+4j7ln1lGkiSCYL55EKAHPJEKHbn6d+EvLZmLp3qa8XCt95G1AdrczMMOeqOi7sdQZXP5JnBrUHDgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712789235; c=relaxed/simple;
	bh=XsbgZtCOc5ETrVPrJ/FtKkFplUEZ2QIE7aWQKb1cCHc=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=NJIdtOJ1sLLAyBCkWtSAv3G+L6dcJxcmTtkuX7rcikNG2qhvqkjfksvIl147a9liIVUMlVUUidPQ/7jo3AP3xOqMvzK3LZvEoO/f9GiVgd4Ee22b+B6xW5UcDyT+0wcrEyRHed19Y4ZybClGWMqcGVa3hFaXuBxAJhCHsKEbuQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VnUu5UoH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CFtICFy1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240410165553.080403121@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712789232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=MQO2EYZPqj5U7pySt49QYzOaZrWaUy6rIJlwsdY8EF8=;
	b=VnUu5UoHDvK8n4kJSBRl6PdAIf/aC8599XcwM8idmqAUlEszj4tpOzu11AJToVKW+28kfu
	k64SBsgVoa4CzLclyrWPNDGgtrUl0EU2Lx4quBCLRJzPvi3YPcleI0y6CK7I9YYR0eKLnB
	ePeXHcKn+9fwfpYk3ZpyKOrV7gEV55M8Vfs8jyVuupCSHHBQy08ZaZYTb+84w8hvWInQkh
	MYZM6gySeAbSiI0+rueL8lXF+C8I+6Xi3dbaOjeygl5aEtLi0/fWE6grEnHnx4QxfjIf8t
	wISMl3sHPWMlHilU9n/R+vSSan2rKvw3QOS904d4aNKka7bowAoqNrG0jPQ0EQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712789232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=MQO2EYZPqj5U7pySt49QYzOaZrWaUy6rIJlwsdY8EF8=;
	b=CFtICFy16+rLTegzsdwBNe7ea/fcn7FE2j/lwCDicVWSMDD214U9/+KkV0B2cyqVu3HiB2
	o/YghTJnGQllkABQ==
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
Subject: [patch V2 34/50] posix-cpu-timers: Use dedicated flag for CPU timer
 nanosleep
References: <20240410164558.316665885@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Apr 2024 00:47:12 +0200 (CEST)

POSIX CPU timer nanosleep creates a k_itimer on stack and uses the sigq
pointer to detect the nanosleep case in the expiry function.

Prepare for embedding sigqueue into struct k_itimer by using a dedicated
flag for nanosleep.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/posix-timers.h   |    4 +++-
 kernel/time/posix-cpu-timers.c |    3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -42,6 +42,7 @@ static inline int clockid_to_fd(const cl
  * @pid:	Pointer to target task PID
  * @elist:	List head for the expiry list
  * @firing:	Timer is currently firing
+ * @nanosleep:	Timer is used for nanosleep and is not a regular posix-timer
  * @handling:	Pointer to the task which handles expiry
  */
 struct cpu_timer {
@@ -49,7 +50,8 @@ struct cpu_timer {
 	struct timerqueue_head		*head;
 	struct pid			*pid;
 	struct list_head		elist;
-	int				firing;
+	bool				firing;
+	bool				nanosleep;
 	struct task_struct __rcu	*handling;
 };
 
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -588,7 +588,7 @@ static void cpu_timer_fire(struct k_itim
 
 	timer->it_status = POSIX_TIMER_DISARMED;
 
-	if (unlikely(timer->sigq == NULL)) {
+	if (unlikely(ctmr->nanosleep)) {
 		/*
 		 * This a special case for clock_nanosleep,
 		 * not a normal timer from sys_timer_create.
@@ -1479,6 +1479,7 @@ static int do_cpu_nanosleep(const clocki
 	timer.it_overrun = -1;
 	error = posix_cpu_timer_create(&timer);
 	timer.it_process = current;
+	timer.it.cpu.nanosleep = true;
 
 	if (!error) {
 		static struct itimerspec64 zero_it;


