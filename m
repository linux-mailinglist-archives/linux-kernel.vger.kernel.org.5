Return-Path: <linux-kernel+bounces-144399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74CBF8A4573
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 22:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97AD91C20895
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 20:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302F813775C;
	Sun, 14 Apr 2024 20:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TqQ4puOy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WJxz2TuQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEB853365;
	Sun, 14 Apr 2024 20:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713127634; cv=none; b=pTkeaYEGGEidqqPJUFUTN0Z543EzmSzp4PvkOLuKpKOfrnttsIQBk20wTmoUpNNanYnze14I7T2vkAySZxJEDmRQjN7RhgTm5zC8CGcOSg6xA+VCzkSli3dcexxbD0hjZsxxvknVJRlGadOepsPly4zzrW4hUrLGbLRKauu3EGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713127634; c=relaxed/simple;
	bh=SSq63jYCy0vXvN/OQllQvfRMkNdf48Ela2wdi5HCzfA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=XbaSJHHTon8+XOlZdyM609mFdZEHb5RjT+e7ztz6z+u9LkbgjsL9H9YJcElimhBMMsTK+9zuUIakOmhkcvz547tfDAvKFq9RaXmyJoIdVBe2G15+nZlKlNsmB3tQLPXs4bNw2rdTwBPD0ug2SVlXgHauprBS6DGI2gDyw4I2MLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TqQ4puOy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WJxz2TuQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 14 Apr 2024 20:47:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713127631;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OtMr7UovHNpiBfohCCUTpX4vqrJn1Sp3nThSAOU8oXs=;
	b=TqQ4puOyuO3/jbdD64bvAKQQfz01ooB1ExB6SbDQfIqlM9vOqu3pEkH/7REjf9GzPaQ5Nq
	eEfJP4NvVXbvzrbZUJeIE52N+U8dc8I8LzOmVlZM2fAf87z8SVR/+Yb34LVRTqxXB31Mke
	UnieLMWcoeQC7BvthggiGAt2fhQ/flJIZupfiAchfpLIjUMgB5M5+c8C0cWazhCt2RI598
	9tcfQC1Put+vcMCdj6235qEPFc/YWdnrH9K+D9g30ydcqY22HGPXV2LL4b3zYEhu+1UdrU
	3ZdvCuDM+gbTDZkMUCdhijCfT9yOVXq+XUAY6KnC1vzWoyZJNtmtK9giJnTKzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713127631;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OtMr7UovHNpiBfohCCUTpX4vqrJn1Sp3nThSAOU8oXs=;
	b=WJxz2TuQB5+dIDPcySri/yZhvqYtHNbXQ1aY/Uk5hngWndaPQ2iY2ERkbDesXtW+CkLL6N
	Khx2Xz882HqDB4Ag==
From: "tip-bot2 for Kyle Huey" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] selftests/perf_events: Test FASYNC with watermark wakeups
Cc: Kyle Huey <khuey@kylehuey.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240413141618.4160-4-khuey@kylehuey.com>
References: <20240413141618.4160-4-khuey@kylehuey.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171312763030.10875.17033743361320585734.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     e224d1c1fb93f258030186b4878abe105c296ac1
Gitweb:        https://git.kernel.org/tip/e224d1c1fb93f258030186b4878abe105c296ac1
Author:        Kyle Huey <me@kylehuey.com>
AuthorDate:    Sat, 13 Apr 2024 07:16:20 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 14 Apr 2024 22:26:33 +02:00

selftests/perf_events: Test FASYNC with watermark wakeups

The test uses PERF_RECORD_SWITCH records to fill the ring buffer and
trigger the watermark wakeup, which in turn should trigger an IO
signal.

Signed-off-by: Kyle Huey <khuey@kylehuey.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20240413141618.4160-4-khuey@kylehuey.com
---
 tools/testing/selftests/perf_events/.gitignore         |   1 +-
 tools/testing/selftests/perf_events/Makefile           |   2 +-
 tools/testing/selftests/perf_events/watermark_signal.c | 146 ++++++++-
 3 files changed, 148 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/perf_events/watermark_signal.c

diff --git a/tools/testing/selftests/perf_events/.gitignore b/tools/testing/selftests/perf_events/.gitignore
index 790c470..ee93dc4 100644
--- a/tools/testing/selftests/perf_events/.gitignore
+++ b/tools/testing/selftests/perf_events/.gitignore
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 sigtrap_threads
 remove_on_exec
+watermark_signal
diff --git a/tools/testing/selftests/perf_events/Makefile b/tools/testing/selftests/perf_events/Makefile
index db93c4f..70e3ff2 100644
--- a/tools/testing/selftests/perf_events/Makefile
+++ b/tools/testing/selftests/perf_events/Makefile
@@ -2,5 +2,5 @@
 CFLAGS += -Wl,-no-as-needed -Wall $(KHDR_INCLUDES)
 LDFLAGS += -lpthread
 
-TEST_GEN_PROGS := sigtrap_threads remove_on_exec
+TEST_GEN_PROGS := sigtrap_threads remove_on_exec watermark_signal
 include ../lib.mk
diff --git a/tools/testing/selftests/perf_events/watermark_signal.c b/tools/testing/selftests/perf_events/watermark_signal.c
new file mode 100644
index 0000000..49dc1e8
--- /dev/null
+++ b/tools/testing/selftests/perf_events/watermark_signal.c
@@ -0,0 +1,146 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+
+#include <errno.h>
+#include <fcntl.h>
+#include <linux/perf_event.h>
+#include <stddef.h>
+#include <sched.h>
+#include <signal.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+#include <sys/syscall.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include "../kselftest_harness.h"
+
+#define __maybe_unused __attribute__((__unused__))
+
+static int sigio_count;
+
+static void handle_sigio(int signum __maybe_unused,
+			 siginfo_t *oh __maybe_unused,
+			 void *uc __maybe_unused)
+{
+	++sigio_count;
+}
+
+static void do_child(void)
+{
+	raise(SIGSTOP);
+
+	for (int i = 0; i < 20; ++i)
+		sleep(1);
+
+	raise(SIGSTOP);
+
+	exit(0);
+}
+
+TEST(watermark_signal)
+{
+	struct perf_event_attr attr;
+	struct perf_event_mmap_page *p = NULL;
+	struct sigaction previous_sigio, sigio = { 0 };
+	pid_t child = -1;
+	int child_status;
+	int fd = -1;
+	long page_size = sysconf(_SC_PAGE_SIZE);
+
+	sigio.sa_sigaction = handle_sigio;
+	EXPECT_EQ(sigaction(SIGIO, &sigio, &previous_sigio), 0);
+
+	memset(&attr, 0, sizeof(attr));
+	attr.size = sizeof(attr);
+	attr.type = PERF_TYPE_SOFTWARE;
+	attr.config = PERF_COUNT_SW_DUMMY;
+	attr.sample_period = 1;
+	attr.disabled = 1;
+	attr.watermark = 1;
+	attr.context_switch = 1;
+	attr.wakeup_watermark = 1;
+
+	child = fork();
+	EXPECT_GE(child, 0);
+	if (child == 0)
+		do_child();
+	else if (child < 0) {
+		perror("fork()");
+		goto cleanup;
+	}
+
+	if (waitpid(child, &child_status, WSTOPPED) != child ||
+	    !(WIFSTOPPED(child_status) && WSTOPSIG(child_status) == SIGSTOP)) {
+		fprintf(stderr,
+			"failed to sycnhronize with child errno=%d status=%x\n",
+			errno,
+			child_status);
+		goto cleanup;
+	}
+
+	fd = syscall(__NR_perf_event_open, &attr, child, -1, -1,
+		     PERF_FLAG_FD_CLOEXEC);
+	if (fd < 0) {
+		fprintf(stderr, "failed opening event %llx\n", attr.config);
+		goto cleanup;
+	}
+
+	if (fcntl(fd, F_SETFL, FASYNC)) {
+		perror("F_SETFL FASYNC");
+		goto cleanup;
+	}
+
+	if (fcntl(fd, F_SETOWN, getpid())) {
+		perror("F_SETOWN getpid()");
+		goto cleanup;
+	}
+
+	if (fcntl(fd, F_SETSIG, SIGIO)) {
+		perror("F_SETSIG SIGIO");
+		goto cleanup;
+	}
+
+	p = mmap(NULL, 2 * page_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
+	if (p == NULL) {
+		perror("mmap");
+		goto cleanup;
+	}
+
+	if (ioctl(fd, PERF_EVENT_IOC_ENABLE, 0)) {
+		perror("PERF_EVENT_IOC_ENABLE");
+		goto cleanup;
+	}
+
+	if (kill(child, SIGCONT) < 0) {
+		perror("SIGCONT");
+		goto cleanup;
+	}
+
+	if (waitpid(child, &child_status, WSTOPPED) != -1 || errno != EINTR)
+		fprintf(stderr,
+			"expected SIGIO to terminate wait errno=%d status=%x\n%d",
+			errno,
+			child_status,
+			sigio_count);
+
+	EXPECT_GE(sigio_count, 1);
+
+cleanup:
+	if (p != NULL)
+		munmap(p, 2 * page_size);
+
+	if (fd >= 0)
+		close(fd);
+
+	if (child > 0) {
+		kill(child, SIGKILL);
+		waitpid(child, NULL, 0);
+	}
+
+	sigaction(SIGIO, &previous_sigio, NULL);
+}
+
+TEST_HARNESS_MAIN

