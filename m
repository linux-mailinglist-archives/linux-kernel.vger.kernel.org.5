Return-Path: <linux-kernel+bounces-137280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1904189DFD8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C7F71C22F7D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09CC813B592;
	Tue,  9 Apr 2024 15:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gumYCrGZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OXbo9ztv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5250C137C38;
	Tue,  9 Apr 2024 15:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712678252; cv=none; b=GG8YfFVDqsgWr6Dpil6Ugw5G6g3O6rLiRqNmGBVUX5IXECvlpCqAC7plQ2xyZc0ciXF+hKSf8Z3TFGEXH/dSrEKhqyP/ZbplVj0KVSUehKbVN8LniURNZzlhAIcMOjWWDtP8dzp73EMcppw0R9kuv1RcM90LYBSHr6CBTvShSCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712678252; c=relaxed/simple;
	bh=nGdkm8ZX4z/AV1w6yFyf/tm5JkeLWh7tg1I0cte293c=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=iMGLtGP79BvaYHL8CgE+0d1mtvth+N8TZsuxda/JnOrcb0ND8BnnykF6c4aa+aKjB7kQQCXoCMO7eHfFX97p0ulOsX3frPtbE4h9DuiELd1HnwNt8P4i2rIS8FMb21ppgUrXwG9kM/6rkM5QNbwhGmT0okG+PAt6kJ/d5yLllHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gumYCrGZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OXbo9ztv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 09 Apr 2024 15:57:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712678248;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pHgUpaTE5n0wA7FXpOhHeQ+2JSRW2R7fPYG9slnV4vA=;
	b=gumYCrGZ22WZIXJ2pvsvJrelM/q02veIb9eL9h4Z8Nx6cMpycIY2l+bwGNTTeTQJSm+lt7
	aXE0G0IJUe0askQUlJqcnhfr4IBMlaZWy0m3LLzEVNAxLMwngbbtql+gGeoaqxtLnzcfOM
	GbaB4HwslJIZ36tyTpXsLK5jV7H/HjhnGq0Ji9Wa3gyOu9TPMiaCH2L07fuQ3HSRoD/lJ7
	crS68eyLjVq8rzge16rLlchNVylAW+dewKWlYyhD2GAMOU18Kf6GeULvxEdXtF2kHJqzsd
	i8l439/N98M1oywFByhn2H0AiW8bnYNLlvVeoiAJbL65N2sI3pQD8aZ98lgOeA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712678248;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pHgUpaTE5n0wA7FXpOhHeQ+2JSRW2R7fPYG9slnV4vA=;
	b=OXbo9ztvfOQ4t0Nxt4jfYuljG1dM3a0V4oaAt80KJH4XUdVisJ+1OaTzBRVirVW+QqPqgK
	FuUvNlAGE6ffjwAg==
From: "tip-bot2 for Oleg Nesterov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] selftests/timers/posix_timers: Reimplement
 check_timer_distribution()
Cc: Oleg Nesterov <oleg@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240409133802.GD29396@redhat.com>
References: <20240409133802.GD29396@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171267824770.10875.2500427706798722059.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     6d029c25b71f2de2838a6f093ce0fa0e69336154
Gitweb:        https://git.kernel.org/tip/6d029c25b71f2de2838a6f093ce0fa0e69336154
Author:        Oleg Nesterov <oleg@redhat.com>
AuthorDate:    Tue, 09 Apr 2024 15:38:03 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 09 Apr 2024 17:48:19 +02:00

selftests/timers/posix_timers: Reimplement check_timer_distribution()

check_timer_distribution() runs ten threads in a busy loop and tries to
test that the kernel distributes a process posix CPU timer signal to every
thread over time.

There is not guarantee that this is true even after commit bcb7ee79029d
("posix-timers: Prefer delivery of signals to the current thread") because
that commit only avoids waking up the sleeping process leader thread, but
that has nothing to do with the actual signal delivery.

As the signal is process wide the first thread which observes sigpending
and wins the race to lock sighand will deliver the signal. Testing shows
that this hangs on a regular base because some threads never win the race.

The comment "This primarily tests that the kernel does not favour any one."
is wrong. The kernel does favour a thread which hits the timer interrupt
when CLOCK_PROCESS_CPUTIME_ID expires.

Rewrite the test so it only checks that the group leader sleeping in join()
never receives SIGALRM and the thread which burns CPU cycles receives all
signals.

In older kernels which do not have commit bcb7ee79029d ("posix-timers:
Prefer delivery of signals to the current thread") the test-case fails
immediately, the very 1st tick wakes the leader up. Otherwise it quickly
succeeds after 100 ticks.

CI testing wants to use newer selftest versions on stable kernels. In this
case the test is guaranteed to fail.

So check in the failure case whether the kernel version is less than v6.3
and skip the test result in that case.

[ tglx: Massaged change log, renamed the version check helper ]

Fixes: e797203fb3ba ("selftests/timers/posix_timers: Test delivery of signals across threads")
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240409133802.GD29396@redhat.com
---
 tools/testing/selftests/kselftest.h           |  13 ++-
 tools/testing/selftests/timers/posix_timers.c | 103 +++++++----------
 2 files changed, 60 insertions(+), 56 deletions(-)

diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index 541bf19..973b18e 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -51,6 +51,7 @@
 #include <stdarg.h>
 #include <string.h>
 #include <stdio.h>
+#include <sys/utsname.h>
 #endif
 
 #ifndef ARRAY_SIZE
@@ -388,4 +389,16 @@ static inline __printf(1, 2) int ksft_exit_skip(const char *msg, ...)
 	exit(KSFT_SKIP);
 }
 
+static inline int ksft_min_kernel_version(unsigned int min_major,
+					  unsigned int min_minor)
+{
+	unsigned int major, minor;
+	struct utsname info;
+
+	if (uname(&info) || sscanf(info.release, "%u.%u.", &major, &minor) != 2)
+		ksft_exit_fail_msg("Can't parse kernel version\n");
+
+	return major > min_major || (major == min_major && minor >= min_minor);
+}
+
 #endif /* __KSELFTEST_H */
diff --git a/tools/testing/selftests/timers/posix_timers.c b/tools/testing/selftests/timers/posix_timers.c
index d49dd3f..d86a0e0 100644
--- a/tools/testing/selftests/timers/posix_timers.c
+++ b/tools/testing/selftests/timers/posix_timers.c
@@ -184,80 +184,71 @@ static int check_timer_create(int which)
 	return 0;
 }
 
-int remain;
-__thread int got_signal;
+static pthread_t ctd_thread;
+static volatile int ctd_count, ctd_failed;
 
-static void *distribution_thread(void *arg)
+static void ctd_sighandler(int sig)
 {
-	while (__atomic_load_n(&remain, __ATOMIC_RELAXED));
-	return NULL;
+	if (pthread_self() != ctd_thread)
+		ctd_failed = 1;
+	ctd_count--;
 }
 
-static void distribution_handler(int nr)
+static void *ctd_thread_func(void *arg)
 {
-	if (!__atomic_exchange_n(&got_signal, 1, __ATOMIC_RELAXED))
-		__atomic_fetch_sub(&remain, 1, __ATOMIC_RELAXED);
-}
-
-/*
- * Test that all running threads _eventually_ receive CLOCK_PROCESS_CPUTIME_ID
- * timer signals. This primarily tests that the kernel does not favour any one.
- */
-static int check_timer_distribution(void)
-{
-	int err, i;
-	timer_t id;
-	const int nthreads = 10;
-	pthread_t threads[nthreads];
 	struct itimerspec val = {
 		.it_value.tv_sec = 0,
 		.it_value.tv_nsec = 1000 * 1000,
 		.it_interval.tv_sec = 0,
 		.it_interval.tv_nsec = 1000 * 1000,
 	};
+	timer_t id;
 
-	remain = nthreads + 1;  /* worker threads + this thread */
-	signal(SIGALRM, distribution_handler);
-	err = timer_create(CLOCK_PROCESS_CPUTIME_ID, NULL, &id);
-	if (err < 0) {
-		ksft_perror("Can't create timer");
-		return -1;
-	}
-	err = timer_settime(id, 0, &val, NULL);
-	if (err < 0) {
-		ksft_perror("Can't set timer");
-		return -1;
-	}
+	/* 1/10 seconds to ensure the leader sleeps */
+	usleep(10000);
 
-	for (i = 0; i < nthreads; i++) {
-		err = pthread_create(&threads[i], NULL, distribution_thread,
-				     NULL);
-		if (err) {
-			ksft_print_msg("Can't create thread: %s (%d)\n",
-				       strerror(errno), errno);
-			return -1;
-		}
-	}
+	ctd_count = 100;
+	if (timer_create(CLOCK_PROCESS_CPUTIME_ID, NULL, &id))
+		return "Can't create timer\n";
+	if (timer_settime(id, 0, &val, NULL))
+		return "Can't set timer\n";
 
-	/* Wait for all threads to receive the signal. */
-	while (__atomic_load_n(&remain, __ATOMIC_RELAXED));
+	while (ctd_count > 0 && !ctd_failed)
+		;
 
-	for (i = 0; i < nthreads; i++) {
-		err = pthread_join(threads[i], NULL);
-		if (err) {
-			ksft_print_msg("Can't join thread: %s (%d)\n",
-				       strerror(errno), errno);
-			return -1;
-		}
-	}
+	if (timer_delete(id))
+		return "Can't delete timer\n";
 
-	if (timer_delete(id)) {
-		ksft_perror("Can't delete timer");
-		return -1;
-	}
+	return NULL;
+}
+
+/*
+ * Test that only the running thread receives the timer signal.
+ */
+static int check_timer_distribution(void)
+{
+	const char *errmsg;
 
-	ksft_test_result_pass("check_timer_distribution\n");
+	signal(SIGALRM, ctd_sighandler);
+
+	errmsg = "Can't create thread\n";
+	if (pthread_create(&ctd_thread, NULL, ctd_thread_func, NULL))
+		goto err;
+
+	errmsg = "Can't join thread\n";
+	if (pthread_join(ctd_thread, (void **)&errmsg) || errmsg)
+		goto err;
+
+	if (!ctd_failed)
+		ksft_test_result_pass("check signal distribution\n");
+	else if (ksft_min_kernel_version(6, 3))
+		ksft_test_result_fail("check signal distribution\n");
+	else
+		ksft_test_result_skip("check signal distribution (old kernel)\n");
 	return 0;
+err:
+	ksft_print_msg(errmsg);
+	return -1;
 }
 
 int main(int argc, char **argv)

