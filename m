Return-Path: <linux-kernel+bounces-139454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A4C8A038C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 00:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDE501C223F4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146D7383A5;
	Wed, 10 Apr 2024 22:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S7FUrk4+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cz9bDsaP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87ED917BDA
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 22:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712789179; cv=none; b=jQZ3EShm8OxHgKAbDRE0MHRyLVprZ5SkY/vUwn7W7SC9DVr3gbn3X10hfBOuy3cgthEODHd2jazU8J62JiZzEe6GLpOEBwUOnGn6t5GjQYRomdiDj6aYM01chqrTkZOw3nf6ljTU9BrtuFbMW9KIlyFx43OoZl1ung+t8w3nAbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712789179; c=relaxed/simple;
	bh=AEwG/M/Bkml3zMl7Ux1PQtqNKrZozpL+XEzsujpu//A=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=Ri9Uap6l2Kecpm/DWWYvcMYujw94Tdin72BmLxp3+euz8EjqHIjC/PCN2cyse07sV2UxCdarERGqfLKianb+ESd48OlZZi78C8/l1K6eR8NRim4PrOKcIsBPDMgnjqdhFgYneLOEVIGWgeaiPZx3r0W1vcBYQbTj6UBiaKkbcgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S7FUrk4+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cz9bDsaP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240410165551.064545113@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712789176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=mG203+TomORLX85Hq8lXp4OYnptpdQupAxvOnDDHeaY=;
	b=S7FUrk4+0vWk2KjFmsDrCYHLe8TA8ncVHslxY5KvXhMwdkB7ZFyKj+euD8jqOKotXLiN6N
	bX3KOCHuK2WJ1XZG9np49x+3GYT0MzTShtRmQOprdmpMG7U2sWf86zEfE5w4DlafNA5u7G
	9rkGXvXVHeq4JUrkGKKCjYEyqobiLpSjs+3BMxAppv6oMytzWUWHSJmLwQvXOsm40b0nNE
	c3BkkbbHmp9Fqow1b8XwVwi5L1otz2oB/5PcevtTjXDAqwgIR8SmskCyL0A9k/3VefmQoZ
	w97mTd1t86WiVmrYauqiQc6CF3Z0L6ORArXoWMVQpfiYLPDLFQTxBUgnuzXOWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712789176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=mG203+TomORLX85Hq8lXp4OYnptpdQupAxvOnDDHeaY=;
	b=cz9bDsaPLYrDUcW5slz0gitAkYpYc3DqtlmBN6LfHkfHwlp+J30yJtrDNc9dCZ+p/+E5AY
	ssTnA6e86n18HvDg==
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
Subject: [patch V2 02/50] selftests/timers/posix_timers: Add SIG_IGN test
References: <20240410164558.316665885@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Apr 2024 00:46:15 +0200 (CEST)

Add a test case to validate correct behaviour vs. SIG_IGN.

The posix specification states:

  "Setting a signal action to SIG_IGN for a signal that is pending shall
   cause the pending signal to be discarded, whether or not it is blocked."

The kernel implements this in the signal handling code, but due to the way
how posix timers are handling SIG_IGN for periodic timers, the behaviour
after installing a real handler again is inconsistent and suprising.

The following sequence is expected to deliver a signal:

  install_handler(SIG);
  block_signal(SIG);
  timer_create(...);	 <- Should send SIG
  timer_settime(value=100ms, interval=100ms);
  sleep(1);		 <- Timer expires and queues signal, timer is not rearmed
  			    as that should happen in the signal delivery path
  ignore_signal(SIG);	 <- Discards queued signal
  install_handler(SIG);  <- Restore handler, should rearm but does not
  sleep(1);
  unblock_signal(SIG);	 <- Should deliver one signal with overrun count
  			    set in siginfo

This fails because nothing rearms the timer when the signal handler is
restored. Add a test for this case which fails until the signal and posix
timer code is fixed.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 tools/testing/selftests/timers/posix_timers.c |  127 +++++++++++++++++++++++++-
 1 file changed, 125 insertions(+), 2 deletions(-)

--- a/tools/testing/selftests/timers/posix_timers.c
+++ b/tools/testing/selftests/timers/posix_timers.c
@@ -6,8 +6,9 @@
  *
  * Kernel loop code stolen from Steven Rostedt <srostedt@redhat.com>
  */
-
+#define _GNU_SOURCE
 #include <sys/time.h>
+#include <sys/types.h>
 #include <stdio.h>
 #include <signal.h>
 #include <string.h>
@@ -214,10 +215,129 @@ static void check_timer_distribution(voi
 		ksft_test_result_skip("check signal distribution (old kernel)\n");
 }
 
+struct tmrsig {
+	int	signals;
+	int	overruns;
+};
+
+static void siginfo_handler(int sig, siginfo_t *si, void *uc)
+{
+	struct tmrsig *tsig = si ? si->si_ptr : NULL;
+
+	if (tsig) {
+		tsig->signals++;
+		tsig->overruns += si->si_overrun;
+	}
+}
+
+static void *ignore_thread(void *arg)
+{
+	unsigned int *tid = arg;
+	sigset_t set;
+
+	sigemptyset(&set);
+	sigaddset(&set, SIGUSR1);
+	if (sigprocmask(SIG_BLOCK, &set, NULL))
+		fatal_error(NULL, "sigprocmask(SIG_BLOCK)");
+
+	*tid = gettid();
+	sleep(100);
+
+	if (sigprocmask(SIG_UNBLOCK, &set, NULL))
+		fatal_error(NULL, "sigprocmask(SIG_UNBLOCK)");
+	return NULL;
+}
+
+static void check_sig_ign(int thread)
+{
+	struct tmrsig tsig = { };
+	struct itimerspec its;
+	unsigned int tid = 0;
+	struct sigaction sa;
+	struct sigevent sev;
+	pthread_t pthread;
+	timer_t timerid;
+	sigset_t set;
+
+	if (thread) {
+		if (pthread_create(&pthread, NULL, ignore_thread, &tid))
+			fatal_error(NULL, "pthread_create()");
+		sleep(1);
+	}
+
+	sa.sa_flags = SA_SIGINFO;
+	sa.sa_sigaction = siginfo_handler;
+	sigemptyset(&sa.sa_mask);
+	if (sigaction(SIGUSR1, &sa, NULL))
+		fatal_error(NULL, "sigaction()");
+
+	/* Block the signal */
+	sigemptyset(&set);
+	sigaddset(&set, SIGUSR1);
+	if (sigprocmask(SIG_BLOCK, &set, NULL))
+		fatal_error(NULL, "sigprocmask(SIG_BLOCK)");
+
+	memset(&sev, 0, sizeof(sev));
+	sev.sigev_notify = SIGEV_SIGNAL;
+	sev.sigev_signo = SIGUSR1;
+	sev.sigev_value.sival_ptr = &tsig;
+	if (thread) {
+		sev.sigev_notify = SIGEV_THREAD_ID;
+		sev._sigev_un._tid = tid;
+	}
+
+	if (timer_create(CLOCK_MONOTONIC, &sev, &timerid))
+		fatal_error(NULL, "timer_create()");
+
+	/* Start the timer to expire in 100ms and 100ms intervals */
+	its.it_value.tv_sec = 0;
+	its.it_value.tv_nsec = 100000000;
+	its.it_interval.tv_sec = 0;
+	its.it_interval.tv_nsec = 100000000;
+	timer_settime(timerid, 0, &its, NULL);
+
+	sleep(1);
+
+	/* Set the signal to be ignored */
+	if (signal(SIGUSR1, SIG_IGN) == SIG_ERR)
+		fatal_error(NULL, "signal(SIG_IGN)");
+
+	sleep(1);
+
+	if (thread) {
+		/* Stop the thread first. No signal should be delivered to it */
+		if (pthread_cancel(pthread))
+			fatal_error(NULL, "pthread_cancel()");
+		if (pthread_join(pthread, NULL))
+			fatal_error(NULL, "pthread_join()");
+	}
+
+	/* Restore the handler */
+	if (sigaction(SIGUSR1, &sa, NULL))
+		fatal_error(NULL, "sigaction()");
+
+	sleep(1);
+
+	/* Unblock it, which should deliver the signal in the !thread case*/
+	if (sigprocmask(SIG_UNBLOCK, &set, NULL))
+		fatal_error(NULL, "sigprocmask(SIG_UNBLOCK)");
+
+	if (timer_delete(timerid))
+		fatal_error(NULL, "timer_delete()");
+
+	if (!thread) {
+		ksft_test_result(tsig.signals == 1 && tsig.overruns == 29,
+				 "check_sig_ign SIGEV_SIGNAL\n");
+	} else {
+		ksft_test_result(tsig.signals == 0 && tsig.overruns == 0,
+				 "check_sig_ign SIGEV_THREAD_ID\n");
+	}
+}
+
 int main(int argc, char **argv)
 {
 	ksft_print_header();
-	ksft_set_plan(6);
+	ksft_set_plan(8);
 
 	ksft_print_msg("Testing posix timers. False negative may happen on CPU execution \n");
 	ksft_print_msg("based timers if other threads run on the CPU...\n");
@@ -239,5 +359,8 @@ int main(int argc, char **argv)
 	check_timer_create(CLOCK_PROCESS_CPUTIME_ID, "CLOCK_PROCESS_CPUTIME_ID");
 	check_timer_distribution();
 
+	check_sig_ign(0);
+	check_sig_ign(1);
+
 	ksft_finished();
 }


