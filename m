Return-Path: <linux-kernel+bounces-139455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D46E8A038D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 00:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A1AF1F234A3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2917C3D970;
	Wed, 10 Apr 2024 22:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0iUKFiyd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="caTf1ZIl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0A92EB0B
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 22:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712789181; cv=none; b=DnqDcs2yHbqXy7/acHXjop1UZ69UgRozWfJCxHq66WJ0kcXazAYDgpPmLk2PnlhAd/hTlMGz5QE9RFJQO2xhqVgkIqsciDfWzsoFDQ2k4o+QbDlZb9/S8HRruNDQR+9eWntbw6NPdHNtUs0k31Xb0NHIXbSp62n5+7v6ylCHzig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712789181; c=relaxed/simple;
	bh=0dOor7S/Yn3rDNsac02RvT1qNgsnOubhGwF303qU4IE=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=VZW3tpm7Qsx+IUESWWyWpBrUsfigEOoQc8/67iWZAcQpP08rtNLaNXBrDjycELPcX2fzaaafsBz9bWrKDI2z7Lkot+meaJMsvkf2uLcJ7KufdsIbDUBX10g0iKIHe1p/GUveDcP+JtNi/YMiUadWeenXuomCHhfsc4pG9XJkOxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0iUKFiyd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=caTf1ZIl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240410165551.126670434@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712789177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=53aZ8Z0KAYc29a8/TyvmKDTswskAp7PFmRVpcJga0I0=;
	b=0iUKFiydvpLT6lDDnkTvpYZ1jRsvCtCCN6Oj9PD15+qkwNlGXlnmI2O2JVyJQ6zvBE66Lp
	6Pa2eYkcVYTUwlNQ55J6TeXreWxxUFBsxetPJc3UccyQ4Yct4EDeaZo8vtsk2i+SleQQOV
	z/byf4uzVi9vJ+XteToDqjpMObS83/+tofht2VKAk6/J52nj3qQaXmdusdw0dbJBSp/BoE
	/s1i54fbWDoqxOeKTFzjgQ6urmDtkLaYPp8A7tBUtuGe0z7bKIp7InDALjY/t7M8iBHOqy
	Q/4/DufK2umItwcOTL4sK3YlgNV+M/3lLWHghjBjEZEdxDrxDywezgdFXwe4cg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712789177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=53aZ8Z0KAYc29a8/TyvmKDTswskAp7PFmRVpcJga0I0=;
	b=caTf1ZIlVoP0PVlm5Onw13uKDfieYjX3oY13CdhGRrZfWZW+jIxWwL/dUSsc7JC/4e1Gn5
	CEvBmI8uW7wGOlBw==
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
Subject: [patch V2 03/50] selftests/timers/posix_timers: Validate signal rules
References: <20240410164558.316665885@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Apr 2024 00:46:17 +0200 (CEST)

Add a test case to validate correct behaviour vs. timer reprogramming and
deletion.

The handling of queued signals in case of timer reprogramming or deletion
is inconsistent at best.

POSIX does not really specify the behaviour for that:

 - "The effect of disarming or resetting a timer with pending expiration
   notifications is unspecified."

 - "The disposition of pending signals for the deleted timer is
    unspecified."

In both cases it is reasonable to expect that pending signals are
discarded. Especially in the reprogramming case it does not make sense to
account for previous overruns or to deliver a signal for a timer which
has been disarmed.

Add tests to validate that no unexpected signals are delivered. They fail
for now until the signal and posix timer code is updated.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 tools/testing/selftests/timers/posix_timers.c |  108 +++++++++++++++++++++++++-
 1 file changed, 107 insertions(+), 1 deletion(-)

--- a/tools/testing/selftests/timers/posix_timers.c
+++ b/tools/testing/selftests/timers/posix_timers.c
@@ -334,10 +334,114 @@ static void check_sig_ign(int thread)
 	}
 }
 
+static void check_rearm(void)
+{
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
+	if (timer_create(CLOCK_MONOTONIC, &sev, &timerid))
+		fatal_error(NULL, "timer_create()");
+
+	/* Start the timer to expire in 100ms and 100ms intervals */
+	its.it_value.tv_sec = 0;
+	its.it_value.tv_nsec = 100000000;
+	its.it_interval.tv_sec = 0;
+	its.it_interval.tv_nsec = 100000000;
+	if (timer_settime(timerid, 0, &its, NULL))
+		fatal_error(NULL, "timer_settime()");
+
+	sleep(1);
+
+	/* Reprogram the timer to single shot */
+	its.it_value.tv_sec = 10;
+	its.it_value.tv_nsec = 0;
+	its.it_interval.tv_sec = 0;
+	its.it_interval.tv_nsec = 0;
+	if (timer_settime(timerid, 0, &its, NULL))
+		fatal_error(NULL, "timer_settime()");
+
+	/* Unblock it, which should not deliver a signal */
+	if (sigprocmask(SIG_UNBLOCK, &set, NULL))
+		fatal_error(NULL, "sigprocmask(SIG_UNBLOCK)");
+
+	if (timer_delete(timerid))
+		fatal_error(NULL, "timer_delete()");
+
+	ksft_test_result(!tsig.signals, "check_rearm\n");
+}
+
+static void check_delete(void)
+{
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
+	if (timer_create(CLOCK_MONOTONIC, &sev, &timerid))
+		fatal_error(NULL, "timer_create()");
+
+	/* Start the timer to expire in 100ms and 100ms intervals */
+	its.it_value.tv_sec = 0;
+	its.it_value.tv_nsec = 100000000;
+	its.it_interval.tv_sec = 0;
+	its.it_interval.tv_nsec = 100000000;
+	if (timer_settime(timerid, 0, &its, NULL))
+		fatal_error(NULL, "timer_settime()");
+
+	sleep(1);
+
+	if (timer_delete(timerid))
+		fatal_error(NULL, "timer_delete()");
+
+	/* Unblock it, which should not deliver a signal */
+	if (sigprocmask(SIG_UNBLOCK, &set, NULL))
+		fatal_error(NULL, "sigprocmask(SIG_UNBLOCK)");
+
+	ksft_test_result(!tsig.signals, "check_delete\n");
+}
+
 int main(int argc, char **argv)
 {
 	ksft_print_header();
-	ksft_set_plan(8);
+	ksft_set_plan(10);
 
 	ksft_print_msg("Testing posix timers. False negative may happen on CPU execution \n");
 	ksft_print_msg("based timers if other threads run on the CPU...\n");
@@ -361,6 +465,8 @@ int main(int argc, char **argv)
 
 	check_sig_ign(0);
 	check_sig_ign(1);
+	check_rearm();
+	check_delete();
 
 	ksft_finished();
 }


