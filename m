Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B60808E5D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 18:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443174AbjLGRJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 12:09:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233045AbjLGRJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 12:09:55 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645E610EB;
        Thu,  7 Dec 2023 09:10:01 -0800 (PST)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
        by mailout.west.internal (Postfix) with ESMTP id 546973200AC9;
        Thu,  7 Dec 2023 12:10:00 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Thu, 07 Dec 2023 12:10:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1701968999; x=
        1702055399; bh=WrVPqtASwJJxG2xCWlOFsHZ6qIqzH0f1AOqfJ5algyU=; b=j
        ZjmcEtoOj30kW1cqgiWAq21aP7CzqXaAzw2w8Lv5/HvgH/Rbr6YTK4mdCx/iEwS/
        l31AsQRxRIB9+7dPhTilQzthaPEo5ao1BP8bs6QvmeLuMoA6zGls3S9Dx88lm99u
        kEi9PCX3H0CT07vFkFvj3Gq21MzzprOMbuk3X2MwPdKrbjWpDF3UooTeMfTdBh63
        yH9IDdZXij/8Gzq64evGu2RlpqGVh2EbE1vziUfE9DuUlnBtm8c5v44tbHHFvJtx
        0IG5SpsPgj9LE+VrTta/7wFSoPhcl6px4Ec1l2RHUIV6ZZqPkp0su3Is6tLhB8E0
        XOT6InfVS+Nhe8cDT8ZFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1701968999; x=
        1702055399; bh=WrVPqtASwJJxG2xCWlOFsHZ6qIqzH0f1AOqfJ5algyU=; b=j
        0jrPhiCID6orXxkMLXx1GjprPqIrBs+uorNXbuvzfn9z9b6yo2C5i32Ghn78wppM
        CdjwlrNZaEU/fm4QOYg7f3ikJORsbQwX2P0nYTcfBQaWjQtnuxJGh4B5rQYCXk2C
        K4DVwOBudeM0ePyOYDf1h79olALYsosH00ZIrEoPC9ApCg3yL6pQdQ7nDIyFMkKG
        AaaKUOwEi3XZc5mMJFLvbSCQt1mutiuWvJHBUtsTjDG/x7FBUaR8wD+hlcWgRcZu
        kjcsraNS/PgszdQoiMhCd9bqzdXo53mjq7SktOzBiB0haqIzmlGXWnB2ssQw5gZb
        3sA2Pwfoj7SiVBBFcv5yA==
X-ME-Sender: <xms:Z_xxZa4ka8JuadYM82QvG6fs6pQxQmrWwwoFL6jpFrAO0I3Uh9sBng>
    <xme:Z_xxZT4O8Qad7hUVIFSRUsq8PzNABiIavdy70Bs3IAxI3P2OazBeJMIcWz8gRSjzy
    jLw4rnrJhqSXkDVatc>
X-ME-Received: <xmr:Z_xxZZcc92NjXWDLM2VgAEgiKUeTQb1sbTSIs7kzvNYWa6_OGTwDb_dX8yL1r7n9oxp00g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudekfedgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfihtghh
    ohcutehnuggvrhhsvghnuceothihtghhohesthihtghhohdrphhiiiiirgeqnecuggftrf
    grthhtvghrnhepvdegffehledvleejvdethffgieefveevhfeigefffffgheeguedtieek
    tdeigeeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epthihtghhohesthihtghhohdrphhiiiiirg
X-ME-Proxy: <xmx:Z_xxZXJC_iWgtJfc-5Y1jk4-Ojk8R8qHcIurBL7Q-exfJy12GgNsYQ>
    <xmx:Z_xxZeJ6UPaDsVVA_KkZJO-KUveXjpH4CICKBovZ-G12o7p3AOyC9A>
    <xmx:Z_xxZYz66fO1COIwMpq0T1RupSf086S0476BzeOx4vdLPHZm2pNBoQ>
    <xmx:Z_xxZQjJLk64fyN5WDHAR5iznzh7_0AIQND0GhzAcvasCTuaEOB-QQ>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Dec 2023 12:09:58 -0500 (EST)
From:   Tycho Andersen <tycho@tycho.pizza>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Tycho Andersen <tycho@tycho.pizza>,
        Tycho Andersen <tandersen@netflix.com>
Subject: [PATCH v2 2/3] selftests/pidfd: add non-thread-group leader tests
Date:   Thu,  7 Dec 2023 10:09:45 -0700
Message-Id: <20231207170946.130823-2-tycho@tycho.pizza>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231207170946.130823-1-tycho@tycho.pizza>
References: <20231207170946.130823-1-tycho@tycho.pizza>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tycho Andersen <tandersen@netflix.com>

This adds a family of tests for various behaviors for pidfds of
non-thread-group leaders.

Signed-off-by: Tycho Andersen <tandersen@netflix.com>
---
 tools/testing/selftests/pidfd/.gitignore      |   1 +
 tools/testing/selftests/pidfd/Makefile        |   3 +-
 .../selftests/pidfd/pidfd_non_tgl_test.c      | 339 ++++++++++++++++++
 3 files changed, 342 insertions(+), 1 deletion(-)

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
index 000000000000..e3992f2d88cf
--- /dev/null
+++ b/tools/testing/selftests/pidfd/pidfd_non_tgl_test.c
@@ -0,0 +1,339 @@
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
+static int test_non_tgl_exit(void)
+{
+	pid_t tgl, thread;
+	int sk_pair[2], status;
+	int tgl_pidfd = -1, thread_pidfd = -1;
+	int ret = KSFT_FAIL, ready;
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
+	close(thread_pidfd);
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
+	ret = KSFT_PASS;
+
+cleanup:
+	kill(tgl, SIGKILL);
+	if (waitpid(tgl, &status, 0) != tgl) {
+		perror("waitpid");
+		return KSFT_FAIL;
+	}
+
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
+	T(test_non_tgl_exit),
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

