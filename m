Return-Path: <linux-kernel+bounces-139458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2498A0390
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 00:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B8BEB24225
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC92B1E884;
	Wed, 10 Apr 2024 22:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="w07gFicp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W+hc683y"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99DF17BDA
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 22:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712789186; cv=none; b=uE467w1vz50t0Y87zdEqakc78vRe6iAz5wFZqNW9QS0sKctxMXwoniGWmwnhQI2f5WCWvDZU+dW7XBRnhkARHUDVhottVWFPLcr2Xr8epNVaMPvajSMrcOf/R+gx9+MCkwiYF2x+N26g0tnHSYql5U+NEeO3tdAhv8Uv9zKJ8/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712789186; c=relaxed/simple;
	bh=Jz7RJXZF/wpnmhSKslp2B8lopo6bOLwGJ9GuQe5xSbw=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=Y8Hx7Z5jmrOzP91AOhFHlxNvog3t4DjkJXee7Uh+g80ssdYbW1ymfq3GDCj+J/IEoShrN9VqY5BjCqbwRNKmBpT4BzVCvUAYc7K0UZE9VUZgzuxvhtuV8PMKH+/EI0a5y5rFsOuL0R6ILcYMhX1esqBJ/+vuxCQU5gxRg0DPCQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=w07gFicp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=W+hc683y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240410165551.314429637@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712789183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=oS7SrzV2Wd9Ag3yMmGtoq7FlROh6d1Si5LvLo/AXQAY=;
	b=w07gFicpR/1qi8Djk6/+jTf0DdJb59vWhGl7olnPMcNLuwbA00kMjxEv5SEHStFf6NgS9K
	s8Di41Uu+5f/e2ehWvMDsaMKWUKOF2Zn7fja5m67bNtSrfolTQLXmx7LKALLFtTqgdHYew
	VL7GxkZBjQa7vgzBRTUvIoq0e5/oZj8rJnzW5fsHP9tfAY4H5e8JNumQolGunJHd3Gw01+
	8iPUH2Ss2tDss7/4JSAzWOOdsOyHaBd5fLrIOtBCstXsEp1aVRW8tpTfBnal0rmg+RlOlC
	KWLpw/p+lPumnM2RPSE07pabsFQG+qwDmnCia8gu+B9s1EUm3pK2vZ/3H+gZWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712789183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=oS7SrzV2Wd9Ag3yMmGtoq7FlROh6d1Si5LvLo/AXQAY=;
	b=W+hc683y45YViYoAAxz/noNrfSafkVxzK32JLuNnIHY6uMGijv5KO1bND5iHfLzyr2Mc0z
	/Gt6w/cHE+JS0PAQ==
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
Subject: [patch V2 06/50] selftests/timers/posix-timers: Validate overrun
 after unblock
References: <20240410164558.316665885@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Apr 2024 00:46:22 +0200 (CEST)

When a timer signal is blocked and later unblocked then one signal should
be delivered with the correct number of overruns since the timer was queued.

Validate that behaviour.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 tools/testing/selftests/timers/posix_timers.c |   61 +++++++++++++++++++++++++-
 1 file changed, 60 insertions(+), 1 deletion(-)

--- a/tools/testing/selftests/timers/posix_timers.c
+++ b/tools/testing/selftests/timers/posix_timers.c
@@ -540,10 +540,66 @@ static void check_gettime(int which, con
 	ksft_test_result(wraps > 1, "check_gettime %s\n", name);
 }
 
+static void check_overrun(int which, const char *name)
+{
+	struct timespec start, now;
+	struct tmrsig tsig = { };
+	struct itimerspec its;
+	struct sigaction sa;
+	struct sigevent sev;
+	timer_t timerid;
+	sigset_t set;
+
+	sa.sa_flags = SA_SIGINFO;
+	sa.sa_sigaction = siginfo_handler;
+	sigemptyset(&sa.sa_mask);
+	if (sigaction(SIGUSR1, &sa, NULL))
+		fatal_error(name, "sigaction()");
+
+	/* Block the signal */
+	sigemptyset(&set);
+	sigaddset(&set, SIGUSR1);
+	if (sigprocmask(SIG_BLOCK, &set, NULL))
+		fatal_error(name, "sigprocmask(SIG_BLOCK)");
+
+	memset(&sev, 0, sizeof(sev));
+	sev.sigev_notify = SIGEV_SIGNAL;
+	sev.sigev_signo = SIGUSR1;
+	sev.sigev_value.sival_ptr = &tsig;
+	if (timer_create(which, &sev, &timerid))
+		fatal_error(name, "timer_create()");
+
+	/* Start the timer to expire in 100ms and 100ms intervals */
+	its.it_value.tv_sec = 0;
+	its.it_value.tv_nsec = 100000000;
+	its.it_interval.tv_sec = 0;
+	its.it_interval.tv_nsec = 100000000;
+	if (timer_settime(timerid, 0, &its, NULL))
+		fatal_error(name, "timer_settime()");
+
+	if (clock_gettime(which, &start))
+		fatal_error(name, "clock_gettime()");
+
+	do {
+		if (clock_gettime(which, &now))
+			fatal_error(name, "clock_gettime()");
+	} while (calcdiff_ns(now, start) < NSECS_PER_SEC);
+
+	/* Unblock it, which should deliver a signal */
+	if (sigprocmask(SIG_UNBLOCK, &set, NULL))
+		fatal_error(name, "sigprocmask(SIG_UNBLOCK)");
+
+	if (timer_delete(timerid))
+		fatal_error(name, "timer_delete()");
+
+	ksft_test_result(tsig.signals == 1 && tsig.overruns == 9,
+			 "check_overrun %s\n", name);
+}
+
 int main(int argc, char **argv)
 {
 	ksft_print_header();
-	ksft_set_plan(15);
+	ksft_set_plan(18);
 
 	ksft_print_msg("Testing posix timers. False negative may happen on CPU execution \n");
 	ksft_print_msg("based timers if other threads run on the CPU...\n");
@@ -574,6 +630,9 @@ int main(int argc, char **argv)
 	check_gettime(CLOCK_MONOTONIC, "CLOCK_MONOTONIC");
 	check_gettime(CLOCK_PROCESS_CPUTIME_ID, "CLOCK_PROCESS_CPUTIME_ID");
 	check_gettime(CLOCK_THREAD_CPUTIME_ID, "CLOCK_THREAD_CPUTIME_ID");
+	check_overrun(CLOCK_MONOTONIC, "CLOCK_MONOTONIC");
+	check_overrun(CLOCK_PROCESS_CPUTIME_ID, "CLOCK_PROCESS_CPUTIME_ID");
+	check_overrun(CLOCK_THREAD_CPUTIME_ID, "CLOCK_THREAD_CPUTIME_ID");
 
 	ksft_finished();
 }


