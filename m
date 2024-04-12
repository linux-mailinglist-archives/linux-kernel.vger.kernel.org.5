Return-Path: <linux-kernel+bounces-142632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6468A2E11
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 14:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87BCA1C214F7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4485788F;
	Fri, 12 Apr 2024 12:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nFd8zqZI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C5wyw06/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A0E57316;
	Fri, 12 Apr 2024 12:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712924132; cv=none; b=WGqB4z3khs644cVaOhMdncRhgVBzdnkahvge5pP7Ls8uKj84J5i5aVq0e3IUha3nAaE8H5ryG+GgJBJCWF3lQBE5oYzXJPJCcP8d9ekiduxbOke+WC8L+4KblUsC/f7aN4sk15hUEJxyhXbFfBY67mdJKokr7BSdaHOTS6pV9Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712924132; c=relaxed/simple;
	bh=tyFiffxY/vet+IFlugomPjdklXQa65KER1XttZ/9rjg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ttDguIgiuX5fzbAnTcoT6bceQMFSbioVA+qR7bFY3weRMxUVnmx6ivtScfMI7V0VynEjc28gGkV59BCy+rtecYC30ZK34y5vTf70fkhb3nUXmezVxiMGLrmcUQ7N3aXEvWQ3Nku3HNNSMt1iZGQ6rlzwysyzStOv2sxAv/e8ZHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nFd8zqZI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C5wyw06/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 12 Apr 2024 12:15:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712924129;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GDzP+0j92+K46F+JY2Y4MtHBCz+/zX2aWbAppAH9bUc=;
	b=nFd8zqZIRdXf0bJOnzcdqwNd5t2yiUzGAXJcxLv4epAnLGO7XmWsn2Y4iHdqZP0Yt7n62Y
	8SSIsYDJu1eHmNOOPcHKroqcmB3n63wAGiNnjae5aciP/FTc17HPR57dXtlTHw54sewWoH
	leUJwjmNAY+v8A/k5JKEcNRYN9jMDEt9xmy0+a30snx0OBZhiRNwBuGhx4k6gPzRUpMyJB
	275J1g1pNsgnjcgF96g/cig240Nm/seSoDEy8A7DE48LDVps7f4bUcGvpw8Dmo36AbROEx
	ccU/6HpJMWZhJb52rkZldBht/XxPBST8r7fd3UkgBszxm3CAfkzD0YMnpD8nyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712924129;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GDzP+0j92+K46F+JY2Y4MtHBCz+/zX2aWbAppAH9bUc=;
	b=C5wyw06/+jw5LoeCCBJXiCV462SJLPLozMHfTbcjJR+L19e5s55wWld7x6Ptimrs3VL8qJ
	HwIt47Xezm19QfCQ==
From: "tip-bot2 for Nathan Chancellor" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] selftests: kselftest: Mark functions that
 unconditionally call exit() as __noreturn
Cc: John Stultz <jstultz@google.com>, Nathan Chancellor <nathan@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Shuah Khan <skhan@linuxfoundation.org>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To:
 <20240411-mark-kselftest-exit-funcs-noreturn-v1-1-b027c948f586@kernel.org>
References:
 <20240411-mark-kselftest-exit-funcs-noreturn-v1-1-b027c948f586@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171292412841.10875.4477211342989271785.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     f7d5bcd35d427daac7e206b1073ca14f5db85c27
Gitweb:        https://git.kernel.org/tip/f7d5bcd35d427daac7e206b1073ca14f5db85c27
Author:        Nathan Chancellor <nathan@kernel.org>
AuthorDate:    Thu, 11 Apr 2024 11:45:40 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 12 Apr 2024 14:11:15 +02:00

selftests: kselftest: Mark functions that unconditionally call exit() as __noreturn

After commit 6d029c25b71f ("selftests/timers/posix_timers: Reimplement
check_timer_distribution()"), clang warns:

  tools/testing/selftests/timers/../kselftest.h:398:6: warning: variable 'major' is used uninitialized whenever '||' condition is true [-Wsometimes-uninitialized]
    398 |         if (uname(&info) || sscanf(info.release, "%u.%u.", &major, &minor) != 2)
        |             ^~~~~~~~~~~~
  tools/testing/selftests/timers/../kselftest.h:401:9: note: uninitialized use occurs here
    401 |         return major > min_major || (major == min_major && minor >= min_minor);
        |                ^~~~~
  tools/testing/selftests/timers/../kselftest.h:398:6: note: remove the '||' if its condition is always false
    398 |         if (uname(&info) || sscanf(info.release, "%u.%u.", &major, &minor) != 2)
        |             ^~~~~~~~~~~~~~~
  tools/testing/selftests/timers/../kselftest.h:395:20: note: initialize the variable 'major' to silence this warning
    395 |         unsigned int major, minor;
        |                           ^
        |                            = 0

This is a false positive because if uname() fails, ksft_exit_fail_msg()
will be called, which unconditionally calls exit(), a noreturn function.
However, clang does not know that ksft_exit_fail_msg() will call exit() at
the point in the pipeline that the warning is emitted because inlining has
not occurred, so it assumes control flow will resume normally after
ksft_exit_fail_msg() is called.

Make it clear to clang that all of the functions that call exit()
unconditionally in kselftest.h are noreturn transitively by marking them
explicitly with '__attribute__((__noreturn__))', which clears up the
warning above and any future warnings that may appear for the same reason.

Fixes: 6d029c25b71f ("selftests/timers/posix_timers: Reimplement check_timer_distribution()")
Reported-by: John Stultz <jstultz@google.com>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240411-mark-kselftest-exit-funcs-noreturn-v1-1-b027c948f586@kernel.org
Closes: https://lore.kernel.org/all/20240410232637.4135564-2-jstultz@google.com/
---
 tools/testing/selftests/kselftest.h | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index 973b18e..0591974 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -80,6 +80,9 @@
 #define KSFT_XPASS 3
 #define KSFT_SKIP  4
 
+#ifndef __noreturn
+#define __noreturn       __attribute__((__noreturn__))
+#endif
 #define __printf(a, b)   __attribute__((format(printf, a, b)))
 
 /* counters */
@@ -300,13 +303,13 @@ void ksft_test_result_code(int exit_code, const char *test_name,
 	va_end(args);
 }
 
-static inline int ksft_exit_pass(void)
+static inline __noreturn int ksft_exit_pass(void)
 {
 	ksft_print_cnts();
 	exit(KSFT_PASS);
 }
 
-static inline int ksft_exit_fail(void)
+static inline __noreturn int ksft_exit_fail(void)
 {
 	ksft_print_cnts();
 	exit(KSFT_FAIL);
@@ -333,7 +336,7 @@ static inline int ksft_exit_fail(void)
 		  ksft_cnt.ksft_xfail +	\
 		  ksft_cnt.ksft_xskip)
 
-static inline __printf(1, 2) int ksft_exit_fail_msg(const char *msg, ...)
+static inline __noreturn __printf(1, 2) int ksft_exit_fail_msg(const char *msg, ...)
 {
 	int saved_errno = errno;
 	va_list args;
@@ -348,19 +351,19 @@ static inline __printf(1, 2) int ksft_exit_fail_msg(const char *msg, ...)
 	exit(KSFT_FAIL);
 }
 
-static inline int ksft_exit_xfail(void)
+static inline __noreturn int ksft_exit_xfail(void)
 {
 	ksft_print_cnts();
 	exit(KSFT_XFAIL);
 }
 
-static inline int ksft_exit_xpass(void)
+static inline __noreturn int ksft_exit_xpass(void)
 {
 	ksft_print_cnts();
 	exit(KSFT_XPASS);
 }
 
-static inline __printf(1, 2) int ksft_exit_skip(const char *msg, ...)
+static inline __noreturn __printf(1, 2) int ksft_exit_skip(const char *msg, ...)
 {
 	int saved_errno = errno;
 	va_list args;

