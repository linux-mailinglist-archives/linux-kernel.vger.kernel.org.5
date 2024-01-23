Return-Path: <linux-kernel+bounces-35561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DAE83934A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98AE61F21004
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102B9657A0;
	Tue, 23 Jan 2024 15:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b="L9NshSxm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l3X4O2pq"
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8186604AB;
	Tue, 23 Jan 2024 15:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706024112; cv=none; b=uvAPXVDSsoPrNxFLIBvtksV4wD/+PLUB7Ynr/wKZ6VD8qiFWPfzLKDk3xRy/ftbejwTIHJpIlJBDfZJV3H2tcNOE9Frl+4AevlJxbeE8VVvVKR55o9cadqvLTkP2exTCzceYiu9nbsitYlIM057UngBdiRkG1Jd0A230bWxbiI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706024112; c=relaxed/simple;
	bh=+lIPS6RzRodmvLYw4TzWh3eMC+7u1tq4p2/L67zBeus=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KLERQuCA26PMIRBY6PA1AU8Iw4GcOJYxfFqyJDLpyq+VXI3bJiNx0asDRbyDaQ77loRxUIoSaawoAibHccjmfHrxc9Xxi78V2w/75GNzCeAo/xw5MSx5dqt5zCqiTYAnMdRBl6Ua/PYOq2gRECURabHNX9V1KYI0I+xjTg9rc0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza; spf=pass smtp.mailfrom=tycho.pizza; dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b=L9NshSxm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l3X4O2pq; arc=none smtp.client-ip=66.111.4.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tycho.pizza
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id DB7F55C0206;
	Tue, 23 Jan 2024 10:35:08 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Tue, 23 Jan 2024 10:35:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1706024108; x=
	1706110508; bh=y0dCuJmsBWMkvx90Fc88sNZXPF3qBCbDZbPHGZtR/Vs=; b=L
	9NshSxmcBzn62iqxvMUpMM4YAynwSlTcOJf9i7IO2YQjW0/VVoxeOdy0RWorlhRK
	69GKED7WbHlQC5P8r1E4TNOPiZbRV6XGQpJcr3qZltdGl5/28K/k9nD2JkZ9DmkG
	W4viJidf8zdUq+dQ9v+Ab5s0CW4yJ9Vk9VHQOXZoqmRWSeHb/zgkvEx0YLfWUSSW
	AuM5NY13+WpHhVVos2yoHba3qJJaufZztRgJXsBusoF1aypVvhwNxKOK5o20CwTw
	hQZgYWnoF8njqMdwloW4wH244K4Ye2M9+josbofBHlXKXaXRNgI5keZrMPW7br2a
	liv9TgSz3BTdR6QRY6W/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1706024108; x=
	1706110508; bh=y0dCuJmsBWMkvx90Fc88sNZXPF3qBCbDZbPHGZtR/Vs=; b=l
	3X4O2pqOQ2eVtrecnUMe2Xk8vKmurOCfgGV97XEMkPNg5ICC3P23v0GetJr5yyuL
	u+3IWhSC90cpLID7pfW0b3TC9G5rNTkDz8Zi2dBVNu11k5talrmyHzN9gIOGJ77c
	cUoA6UtsEMK2oya1K0DS6ARYNdzCKaTkDvK5vBiKfKT8mPaxpwLbhEfe2TSAEC9U
	oja0/bTSCfd9oUBKRADyyQyswt8+1dso65cAO1ytyf+AKPUSq9ze+hC9Phw3kjgO
	gn06br0vdf+EihRyoecP42GL9dyQqg1oBCLhY/SLlMdimWDJGHy0ogQlf/+ya5RA
	+yPq4bZ0ZWLbunbbv1T4w==
X-ME-Sender: <xms:rNyvZf3n-cGstH8B6UWzESW5Sh_L-7K8Gygef2TxCECbLeKRgzXZ7g>
    <xme:rNyvZeEwB6m7i5z7h1P0XaOiahA8mSByQ7B-8RkTUz2YYVh_YTNdYQhr4gUgyRraV
    AhkssQ0v3DjJTs6Cmc>
X-ME-Received: <xmr:rNyvZf5NxpIi2DMFA181DRoMYFAkJ_UfNag61tKUdV_FbqBd5AZ22m3gvwpnKdVdmuKcRQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdekkedgjeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfihtghh
    ohcutehnuggvrhhsvghnuceothihtghhohesthihtghhohdrphhiiiiirgeqnecuggftrf
    grthhtvghrnhephfevhfdvvdffueffgfffjeehlefffeefffeuheegvedvgefgueefkedu
    ieekgfelnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehthigthhhosehthigthhhordhpihii
    iigr
X-ME-Proxy: <xmx:rNyvZU3VjBek-4oT4Ux9mTHmrF2oxRZSII4RwDzZ-D13L68U1OibVg>
    <xmx:rNyvZSHE2TPj-USbGqGc4UWlKJmMARRg8iQnVHlzDOmLL8hF-SM56g>
    <xmx:rNyvZV_EQKe01nulUNGABBLSZPIzYU_TiTnfLj-HI4UnddrVrRV2Zw>
    <xmx:rNyvZfPUsmm1I1m5UhrS9MIqB7l-7AswqEXUJGtX_JPULDvTtmntyw>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Jan 2024 10:35:07 -0500 (EST)
From: Tycho Andersen <tycho@tycho.pizza>
To: Christian Brauner <brauner@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	Tycho Andersen <tycho@tycho.pizza>,
	Tycho Andersen <tandersen@netflix.com>
Subject: [PATCH v3 2/3] selftests/pidfd: add non-thread-group leader tests
Date: Tue, 23 Jan 2024 08:34:51 -0700
Message-Id: <20240123153452.170866-3-tycho@tycho.pizza>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240123153452.170866-1-tycho@tycho.pizza>
References: <20240123153452.170866-1-tycho@tycho.pizza>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tycho Andersen <tandersen@netflix.com>

This adds a family of tests for various behaviors for pidfds of
non-thread-group leaders.

Signed-off-by: Tycho Andersen <tandersen@netflix.com>
---
v2: unchanged
v3: add some tests for the situation that Christian described in one of the
    previous threads, see the comments for a link + details.
---
 tools/testing/selftests/pidfd/.gitignore      |   1 +
 tools/testing/selftests/pidfd/Makefile        |   3 +-
 .../selftests/pidfd/pidfd_non_tgl_test.c      | 583 ++++++++++++++++++
 3 files changed, 586 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/pidfd/.gitignore b/tools/testing/selftests/pidfd/.gitignore
index 973198a3ec3d..e7532e84a34a 100644
--- a/tools/testing/selftests/pidfd/.gitignore
+++ b/tools/testing/selftests/pidfd/.gitignore
@@ -6,3 +6,4 @@ pidfd_wait
 pidfd_fdinfo_test
 pidfd_getfd_test
 pidfd_setns_test
+pidfd_non_tgl_test
diff --git a/tools/testing/selftests/pidfd/Makefile b/tools/testing/selftests/pidfd/Makefile
index d731e3e76d5b..50e3aa9de05a 100644
--- a/tools/testing/selftests/pidfd/Makefile
+++ b/tools/testing/selftests/pidfd/Makefile
@@ -2,7 +2,8 @@
 CFLAGS += -g $(KHDR_INCLUDES) -pthread -Wall
 
 TEST_GEN_PROGS := pidfd_test pidfd_fdinfo_test pidfd_open_test \
-	pidfd_poll_test pidfd_wait pidfd_getfd_test pidfd_setns_test
+	pidfd_poll_test pidfd_wait pidfd_getfd_test pidfd_setns_test \
+	pidfd_non_tgl_test
 
 include ../lib.mk
 
diff --git a/tools/testing/selftests/pidfd/pidfd_non_tgl_test.c b/tools/testing/selftests/pidfd/pidfd_non_tgl_test.c
new file mode 100644
index 000000000000..c0624b127fab
--- /dev/null
+++ b/tools/testing/selftests/pidfd/pidfd_non_tgl_test.c
@@ -0,0 +1,583 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <sys/socket.h>
+#include <limits.h>
+#include <string.h>
+#include <signal.h>
+#include <syscall.h>
+#include <sched.h>
+#include <poll.h>
+
+#include "../kselftest.h"
+#include "pidfd.h"
+
+static int sys_waitid(int which, pid_t pid, siginfo_t *info, int options,
+		      struct rusage *ru)
+{
+	return syscall(__NR_waitid, which, pid, info, options, ru);
+}
+
+// glibc defaults to 8MB stacks
+#define STACK_SIZE (8 * 1024 * 1024)
+static char stack[STACK_SIZE];
+
+static int thread_sleep(void *)
+{
+	while (1)
+		sleep(100);
+	return 1;
+}
+
+static int fork_task_with_thread(int (*fn)(void *), int sk_pair[2],
+				 pid_t *tgl, pid_t *thread, int *tgl_pidfd,
+				 int *thread_pidfd)
+{
+	*tgl_pidfd = *thread_pidfd = -1;
+
+	*tgl = fork();
+	if (*tgl < 0) {
+		perror("fork");
+		return -1;
+	}
+
+	if (!*tgl) {
+		int flags = CLONE_THREAD | CLONE_VM | CLONE_SIGHAND;
+		pid_t t;
+
+		t = clone(fn, stack + STACK_SIZE, flags, sk_pair);
+		if (t < 0) {
+			perror("clone");
+			exit(1);
+		}
+
+		close(sk_pair[1]);
+
+		if (write(sk_pair[0], &t, sizeof(t)) != sizeof(t)) {
+			perror("read");
+			exit(1);
+		}
+
+		// wait to get killed for various reasons by the tests.
+		while (1)
+			sleep(100);
+	}
+
+	errno = 0;
+	if (read(sk_pair[1], thread, sizeof(*thread)) != sizeof(*thread)) {
+		perror("read");
+		goto cleanup;
+	}
+
+	*tgl_pidfd = sys_pidfd_open(*tgl, 0);
+	if (*tgl_pidfd < 0) {
+		perror("pidfd_open tgl");
+		goto cleanup;
+	}
+
+	*thread_pidfd = sys_pidfd_open(*thread, 0);
+	if (*thread_pidfd < 0) {
+		perror("pidfd");
+		goto cleanup;
+	}
+
+	return 0;
+
+cleanup:
+	kill(*tgl, SIGKILL);
+	if (*tgl_pidfd >= 0)
+		close(*tgl_pidfd);
+	if (*thread_pidfd >= 0)
+		close(*thread_pidfd);
+	return -1;
+}
+
+static int test_non_tgl_basic(void)
+{
+	pid_t tgl, thread;
+	int sk_pair[2], status;
+	int tgl_pidfd = -1, thread_pidfd = -1;
+	int ret = KSFT_FAIL;
+
+	if (socketpair(PF_LOCAL, SOCK_SEQPACKET, 0, sk_pair) < 0) {
+		ksft_print_msg("socketpair failed %s\n", strerror(errno));
+		return KSFT_FAIL;
+	}
+
+	if (fork_task_with_thread(thread_sleep, sk_pair, &tgl, &thread,
+				  &tgl_pidfd, &thread_pidfd) < 0) {
+		return KSFT_FAIL;
+	}
+
+	/*
+	 * KILL of a thread should still kill everyone
+	 */
+	if (sys_pidfd_send_signal(thread_pidfd, SIGKILL, NULL, 0)) {
+		perror("pidfd_send_signal");
+		goto cleanup;
+	}
+
+	errno = 0;
+	if (waitpid(tgl, &status, 0) != tgl) {
+		perror("waitpid tgl");
+		goto cleanup;
+	}
+
+	if (!WIFSIGNALED(status) || WTERMSIG(status) != SIGKILL) {
+		ksft_print_msg("bad exit status %x\n", status);
+		goto cleanup;
+	}
+
+	ret = KSFT_PASS;
+
+cleanup:
+	close(sk_pair[0]);
+	close(sk_pair[1]);
+	close(tgl_pidfd);
+	close(thread_pidfd);
+	return ret;
+}
+
+static int thread_exec(void *arg)
+{
+	int *sk_pair = arg;
+	pid_t thread;
+
+	if (read(sk_pair[0], &thread, sizeof(thread)) != sizeof(thread)) {
+		perror("read");
+		exit(1);
+	}
+
+	execlp("/bin/true", "/bin/true", NULL);
+	return 1;
+}
+
+static int test_non_tgl_exec(void)
+{
+	pid_t tgl, thread;
+	int sk_pair[2];
+	int tgl_pidfd = -1, thread_pidfd = -1;
+	int ret = KSFT_FAIL, ready;
+	struct pollfd pollfd;
+
+	if (socketpair(PF_LOCAL, SOCK_SEQPACKET, 0, sk_pair) < 0) {
+		ksft_print_msg("socketpair failed %s\n", strerror(errno));
+		return KSFT_FAIL;
+	}
+
+	if (fork_task_with_thread(thread_exec, sk_pair, &tgl, &thread,
+				  &tgl_pidfd, &thread_pidfd) < 0) {
+		return KSFT_FAIL;
+	}
+
+	if (write(sk_pair[1], &thread, sizeof(thread)) != sizeof(thread)) {
+		perror("read");
+		goto cleanup;
+	}
+
+	// thread will exec(), so this pidfd should eventually be dead (i.e.
+	// poll should return).
+	pollfd.fd = thread_pidfd;
+	pollfd.events = POLLIN;
+
+	ready = poll(&pollfd, 1, -1);
+	if (ready == -1) {
+		perror("poll");
+		goto cleanup;
+	}
+
+	if (ready != 1) {
+		ksft_print_msg("bad poll result %d\n", ready);
+		goto cleanup;
+	}
+
+	if (pollfd.revents != POLLIN) {
+		ksft_print_msg("bad poll revents: %x\n", pollfd.revents);
+		goto cleanup;
+	}
+
+	errno = 0;
+	if (sys_pidfd_getfd(thread_pidfd, 0, 0) > 0) {
+		ksft_print_msg("got a real fd");
+		goto cleanup;
+	}
+
+	if (errno != ESRCH) {
+		ksft_print_msg("polling invalid thread didn't give ESRCH");
+		goto cleanup;
+	}
+
+	ret = KSFT_PASS;
+
+cleanup:
+	close(sk_pair[0]);
+	close(sk_pair[1]);
+	close(tgl_pidfd);
+	close(thread_pidfd);
+	kill(tgl, SIGKILL);
+	waitpid(tgl, NULL, 0);
+	return ret;
+}
+
+int thread_wait_exit(void *arg)
+{
+	int *sk_pair = arg;
+	pid_t thread;
+
+	if (read(sk_pair[0], &thread, sizeof(thread)) != sizeof(thread)) {
+		perror("read");
+		exit(1);
+	}
+
+	return 0;
+}
+
+static int test_non_tgl_poll_exit(void)
+{
+	pid_t tgl, thread, writer;
+	int sk_pair[2], ready;
+	int tgl_pidfd = -1, thread_pidfd = -1;
+	int ret = KSFT_FAIL;
+	struct pollfd pollfd;
+
+	if (socketpair(PF_LOCAL, SOCK_SEQPACKET, 0, sk_pair) < 0) {
+		ksft_print_msg("socketpair failed %s\n", strerror(errno));
+		return KSFT_FAIL;
+	}
+
+	if (fork_task_with_thread(thread_wait_exit, sk_pair, &tgl, &thread,
+				  &tgl_pidfd, &thread_pidfd) < 0) {
+		return KSFT_FAIL;
+	}
+
+	writer = fork();
+	if (writer < 0) {
+		perror("fork");
+		return KSFT_FAIL;
+	}
+
+	if (writer == 0) {
+		sleep(3);
+		if (write(sk_pair[1], &thread, sizeof(thread)) != sizeof(thread)) {
+			perror("read");
+			exit(1);
+		}
+		exit(0);
+	}
+
+	// thread will exit, so this pidfd should eventually be dead (i.e.
+	// poll should return).
+	pollfd.fd = thread_pidfd;
+	pollfd.events = POLLIN;
+
+	ready = poll(&pollfd, 1, -1);
+	if (ready == -1) {
+		perror("poll");
+		goto cleanup;
+	}
+
+	if (ready != 1) {
+		ksft_print_msg("bad poll result %d\n", ready);
+		goto cleanup;
+	}
+
+	if (pollfd.revents != POLLIN) {
+		ksft_print_msg("bad poll revents: %x\n", pollfd.revents);
+		goto cleanup;
+	}
+
+	if (pollfd.fd != thread_pidfd) {
+		ksft_print_msg("bad poll fd: %x\n", pollfd.fd);
+		goto cleanup;
+	}
+
+	ret = KSFT_PASS;
+
+cleanup:
+	close(sk_pair[0]);
+	close(sk_pair[1]);
+	close(tgl_pidfd);
+	close(thread_pidfd);
+	kill(tgl, SIGKILL);
+	waitpid(tgl, NULL, 0);
+	waitpid(thread, NULL, 0);
+	return ret;
+}
+
+
+static int test_non_tgl_exit_poll(void)
+{
+	pid_t tgl, thread;
+	int sk_pair[2];
+	int tgl_pidfd = -1, thread_pidfd = -1;
+	int ret = KSFT_FAIL, ready;
+	struct pollfd pollfd;
+	siginfo_t siginfo;
+
+	if (socketpair(PF_LOCAL, SOCK_SEQPACKET, 0, sk_pair) < 0) {
+		ksft_print_msg("socketpair failed %s\n", strerror(errno));
+		return KSFT_FAIL;
+	}
+
+	if (fork_task_with_thread(thread_wait_exit, sk_pair, &tgl, &thread,
+				  &tgl_pidfd, &thread_pidfd) < 0) {
+		return KSFT_FAIL;
+	}
+
+	if (write(sk_pair[1], &thread, sizeof(thread)) != sizeof(thread)) {
+		perror("write");
+		goto cleanup;
+	}
+
+	// thread will exit, so this pidfd should eventually be dead (i.e.
+	// poll should return).
+	pollfd.fd = thread_pidfd;
+	pollfd.events = POLLIN;
+
+	ready = poll(&pollfd, 1, -1);
+	if (ready == -1) {
+		perror("poll");
+		goto cleanup;
+	}
+
+	if (ready != 1) {
+		ksft_print_msg("bad poll result %d\n", ready);
+		goto cleanup;
+	}
+
+	if (pollfd.revents != POLLIN) {
+		ksft_print_msg("bad poll revents: %x\n", pollfd.revents);
+		goto cleanup;
+	}
+
+	errno = 0;
+	if (sys_pidfd_getfd(thread_pidfd, 0, 0) > 0) {
+		ksft_print_msg("got a real pidfd");
+		goto cleanup;
+	}
+
+	if (errno != ESRCH) {
+		ksft_print_msg("polling invalid thread didn't give ESRCH");
+		goto cleanup;
+	}
+
+	// ok, but the thread group *leader* should still be alive
+	pollfd.fd = tgl_pidfd;
+	ready = poll(&pollfd, 1, 1);
+	if (ready == -1) {
+		perror("poll");
+		goto cleanup;
+	}
+
+	if (ready != 0) {
+		ksft_print_msg("polling leader returned something?! %x", pollfd.revents);
+		goto cleanup;
+	}
+
+	errno = 0;
+	if (sys_waitid(P_PIDFD, thread_pidfd, &siginfo, WEXITED, NULL) == 0) {
+		ksft_print_msg("got a real wait value");
+		goto cleanup;
+	}
+
+	if (errno != ECHILD) {
+		ksft_print_msg("waiting invalid thread didn't give ECHILD: %d\n", errno);
+		goto cleanup;
+	}
+
+	close(thread_pidfd);
+
+	ret = KSFT_PASS;
+
+cleanup:
+	kill(tgl, SIGKILL);
+	waitpid(tgl, NULL, 0);
+	waitpid(thread, NULL, 0);
+	return ret;
+}
+
+/*
+ * This is a test for the first half of the scenario in
+ * https://lore.kernel.org/all/20231207-avancieren-unbezahlbar-9258f45ec3ec@brauner/
+ *
+ * i.e we expect:
+ *
+ *      waitid(P_PIDFD, tg_pidfd)               waitid(P_PIDFD, t_pidfd)
+ *      tg_pid[PIDTYPE_TGID] == tsk1            t_pid[PIDTYPE_TGID] == NULL
+ *      => succeeds                             => fails
+ */
+static int test_non_tgl_waitid_exit(void)
+{
+	pid_t tgl, thread, writer;
+	int sk_pair[2], status;
+	int tgl_pidfd = -1, thread_pidfd = -1;
+	int ret = KSFT_FAIL;
+	siginfo_t siginfo;
+
+	if (socketpair(PF_LOCAL, SOCK_SEQPACKET, 0, sk_pair) < 0) {
+		ksft_print_msg("socketpair failed %s\n", strerror(errno));
+		return KSFT_FAIL;
+	}
+
+	if (fork_task_with_thread(thread_wait_exit, sk_pair, &tgl, &thread,
+				  &tgl_pidfd, &thread_pidfd) < 0) {
+		return KSFT_FAIL;
+	}
+
+	writer = fork();
+	if (writer < 0) {
+		perror("fork");
+		return KSFT_FAIL;
+	}
+
+	if (writer == 0) {
+		sleep(3);
+		if (write(sk_pair[1], &thread, sizeof(thread)) != sizeof(thread)) {
+			perror("read");
+			exit(1);
+		}
+		exit(0);
+	}
+
+	errno = 0;
+	if (sys_waitid(P_PIDFD, thread_pidfd, &siginfo, __WALL | WEXITED, NULL) == 0
+			|| errno != ECHILD) {
+		ksft_print_msg("waitid didn't give ECHILD");
+		goto cleanup;
+	}
+	close(thread_pidfd);
+
+	kill(tgl, SIGKILL);
+
+	errno = 0;
+	if (sys_waitid(P_PIDFD, tgl_pidfd, &siginfo, __WALL | WEXITED, NULL) != 0) {
+		perror("waitid");
+		ksft_print_msg("waitid failed %d\n", errno);
+		goto cleanup;
+	}
+	close(tgl_pidfd);
+
+	if (siginfo.si_code != CLD_KILLED || siginfo.si_status != SIGKILL) {
+		ksft_print_msg("bad exit code %x status %x\n", siginfo.si_code, siginfo.si_status);
+		goto cleanup;
+	}
+
+	ret = KSFT_PASS;
+
+cleanup:
+	kill(tgl, SIGKILL);
+	waitpid(tgl, &status, 0);
+	waitpid(writer, NULL, 0);
+	return ret;
+}
+
+/*
+ * This is a test for the first second half of the scenario in
+ * https://lore.kernel.org/all/20231207-avancieren-unbezahlbar-9258f45ec3ec@brauner/
+ *
+ * i.e after the exec, we expect:
+ *
+ *      waitid(P_PIDFD, tg_pidfd)		waitid(P_PIDFD, t_pid)
+ *      tg_pid[PIDTYPE_TGID] == tsk2		t_pid[PIDTYPE_TGID] == NULL
+ *      => succeeds				=> fails
+ */
+static int test_non_tgl_waitid_exec(void)
+{
+	pid_t tgl, thread, writer;
+	int sk_pair[2], status;
+	int tgl_pidfd = -1, thread_pidfd = -1;
+	int ret = KSFT_FAIL;
+	siginfo_t siginfo;
+
+	if (socketpair(PF_LOCAL, SOCK_SEQPACKET, 0, sk_pair) < 0) {
+		ksft_print_msg("socketpair failed %s\n", strerror(errno));
+		return KSFT_FAIL;
+	}
+
+	if (fork_task_with_thread(thread_exec, sk_pair, &tgl, &thread,
+				  &tgl_pidfd, &thread_pidfd) < 0) {
+		return KSFT_FAIL;
+	}
+
+	writer = fork();
+	if (writer < 0) {
+		perror("fork");
+		return KSFT_FAIL;
+	}
+
+	if (writer == 0) {
+		sleep(3);
+		if (write(sk_pair[1], &thread, sizeof(thread)) != sizeof(thread)) {
+			perror("read");
+			exit(1);
+		}
+		exit(0);
+	}
+
+	errno = 0;
+	if (sys_waitid(P_PIDFD, thread_pidfd, &siginfo, __WALL | WEXITED, NULL) == 0
+			|| errno != ECHILD) {
+		ksft_print_msg("waitid didn't give ECHILD");
+		goto cleanup;
+	}
+	close(thread_pidfd);
+
+	kill(tgl, SIGKILL);
+
+	errno = 0;
+	if (sys_waitid(P_PIDFD, tgl_pidfd, &siginfo, __WALL | WEXITED, NULL) != 0) {
+		perror("waitid");
+		ksft_print_msg("waitid failed %d\n", errno);
+		goto cleanup;
+	}
+	close(tgl_pidfd);
+
+	if (siginfo.si_code != CLD_KILLED || siginfo.si_status != SIGKILL) {
+		ksft_print_msg("bad exit code %x status %x\n", siginfo.si_code, siginfo.si_status);
+		goto cleanup;
+	}
+
+	ret = KSFT_PASS;
+cleanup:
+	kill(tgl, SIGKILL);
+	kill(thread, SIGKILL);
+	waitpid(tgl, &status, 0);
+	waitpid(thread, &status, 0);
+	waitpid(writer, &status, 0);
+	return ret;
+}
+
+#define T(x) { x, #x }
+struct pidfd_non_tgl_test {
+	int (*fn)();
+	const char *name;
+} tests[] = {
+	T(test_non_tgl_basic),
+	T(test_non_tgl_exec),
+	T(test_non_tgl_poll_exit),
+	T(test_non_tgl_exit_poll),
+	T(test_non_tgl_waitid_exit),
+	T(test_non_tgl_waitid_exec),
+};
+#undef T
+
+int main(int argc, char *argv[])
+{
+	int i, ret = EXIT_SUCCESS;
+
+	for (i = 0; i < ARRAY_SIZE(tests); i++) {
+		switch (tests[i].fn()) {
+		case KSFT_PASS:
+			ksft_test_result_pass("%s\n", tests[i].name);
+			break;
+		case KSFT_SKIP:
+			ksft_test_result_skip("%s\n", tests[i].name);
+			break;
+		default:
+			ret = EXIT_FAILURE;
+			ksft_test_result_fail("%s\n", tests[i].name);
+			break;
+		}
+	}
+
+	return ret;
+}
-- 
2.34.1


