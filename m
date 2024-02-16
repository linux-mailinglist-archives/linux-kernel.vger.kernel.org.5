Return-Path: <linux-kernel+bounces-69516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5167E858A6B
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 01:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75E081C21EF8
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 00:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE61714C594;
	Fri, 16 Feb 2024 23:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2xD/XWI8"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D00153BF3
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 23:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708127735; cv=none; b=XDf5R/HGlJhcw1mYEpmAD0uWQs535DIzjIqXDAVJm1ANV4VRU8UF2dtLe5+oUdp5g1xMiFLloVrMEv0yl0+dFWxwfbqu5K2au1yMTXwX4hlwOnHUH96tFDqxzvsP5hxm5IE6h47C8Deu6uVeMGJ85bKH3owUjaqx7bAEhsC0rqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708127735; c=relaxed/simple;
	bh=SV8Q2XP3AEzUCdEScST86iV7qnjMAWaIiYJHWAwVraA=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=ICBmG7OzFM41ihTDNIPr5vIIdqFugbHv8HSkIQtdkZ9NZbwXWr4e+bZFUj1novtfXXzUSqzO+at3nOO6lmgMTja/NNzThwU66qn8ju/qtwcsO0b9jbNP+NBnWKaTQE8TX8Mfvyd9h50nd86ytwl7NCQVaU8o2aV/21nh79zbpNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2xD/XWI8; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-607d0180d2fso44625647b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 15:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708127731; x=1708732531; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=46NbERsw+rX6VfHxglAqwzl8LfYw4J5J2BPeonbB4cQ=;
        b=2xD/XWI8RWCfnnKUbC38A//aRCb+RsD1YE8l7g1oiyqkreszbQPb5/4ufZ4GiCsyV9
         u+WthsJqknGcI7IYxeM61+ddnm1GY1MuSAfgmdfta4ieml94fvIKpv0l599MpcbW0JIt
         lddrokNFfGW+feWLmcuTmjRsjEQQaxRlRA1cfPhVNXWj3P7aa+yZLWXwaTglv3khOjS7
         bsKXGvBMvdOKGl1zvJLG+KOymwnLd+V4+uj6LhMggok0B4nWewG/g4UoPdgTVH/bY3RS
         xp5i92yyD4biAVqBMsneNL+dIYAJP+kDWuLIdVqGO9c9t7D4VZlBk3lYfwqHMYs413Fu
         pgyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708127731; x=1708732531;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=46NbERsw+rX6VfHxglAqwzl8LfYw4J5J2BPeonbB4cQ=;
        b=Bi1b29Q47W2j5u0NF9GbaReYjqZ9sE9hbebnaN5rA+KDK+ksJQa3BFO2OLOFjSyrUE
         y/qTw6dW1tWFXzDHggcllKs54FDupR64YldNJAEDDV9ElenJ3c5K/TWGL0N7heeRrbfu
         y/lvcgM582DLStz8Vhc6YB85FjSIy41scdnUU5V0Q3V/mHEjnMAIldeBpxFIAQgpEFjM
         wZ2X6aWylsheo1AHAUL+yab6hTqjFdSu1TIsGIrq9frUCLVG1er7OQebfBXztrCKoHph
         UBdfswyVbae8Kd6D0uOGWZAAJL3Yu8GdREBK6x/F7FgTWC2n7/vwEASVROX/bkE8AG9v
         fQVw==
X-Forwarded-Encrypted: i=1; AJvYcCVgE5I0y3+w/ttktb6B7nVGzkqdQvDzikUpOc8o4dW21gSx6t0H2ghpPdf9SdbPw/2BXKBUI8vncX9/xecZwVmyWy+HiHYbuwxuZakb
X-Gm-Message-State: AOJu0YzBnCZPMY9Nuwy1Q5zSjQy60pXg4u6WzY2sWaSfTHXZwzsRR8Y+
	fPfmwUohh96aEtB/QssQj0rstxEwD5WctVqK9waET60yaMwZw8xIvJJCZaF4Z8yWDGV5RE4H/25
	WgbknGA==
X-Google-Smtp-Source: AGHT+IE4bQY/CB1B0/WXTdaQyv1n3CcOnSyLya3adYFdC1HymqVRSC47qHyQNvHyN98hRvzQahTLeIlhVmlk
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:4b5c:352:4272:e34e])
 (user=irogers job=sendgmr) by 2002:a25:a4c9:0:b0:dcd:25be:aefb with SMTP id
 g67-20020a25a4c9000000b00dcd25beaefbmr1583424ybi.13.1708127731233; Fri, 16
 Feb 2024 15:55:31 -0800 (PST)
Date: Fri, 16 Feb 2024 15:52:02 -0800
In-Reply-To: <20240216235203.229256-1-irogers@google.com>
Message-Id: <20240216235203.229256-9-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240216235203.229256-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Subject: [PATCH v5 8/8] perf tests: Add option to run tests in parallel
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>, James Clark <james.clark@arm.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Yang Jihong <yangjihong1@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

By default tests are forked, add an option (-p or --parallel) so that
the forked tests are all started in parallel and then their output
gathered serially. This is opt-in as running in parallel can cause
test flakes.

Rather than fork within the code, the start_command/finish_command
from libsubcmd are used. This changes how stderr and stdout are
handled. The child stderr and stdout are always read to avoid the
child blocking. If verbose is 1 (-v) then if the test fails the child
stdout and stderr are displayed. If the verbose is >1 (e.g. -vv) then
the stdout and stderr from the child are immediately displayed.

An unscientific test on my laptop shows the wall clock time for perf
test without parallel being 5 minutes 21 seconds and with parallel
(-p) being 1 minute 50 seconds.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c | 314 ++++++++++++++++++++++----------
 1 file changed, 215 insertions(+), 99 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index c42cb40fc242..d13ee7683d9d 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -6,6 +6,7 @@
  */
 #include <fcntl.h>
 #include <errno.h>
+#include <poll.h>
 #include <unistd.h>
 #include <string.h>
 #include <stdlib.h>
@@ -21,9 +22,11 @@
 #include "debug.h"
 #include "color.h"
 #include <subcmd/parse-options.h>
+#include <subcmd/run-command.h>
 #include "string2.h"
 #include "symbol.h"
 #include "util/rlimit.h"
+#include "util/strbuf.h"
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <subcmd/exec-cmd.h>
@@ -31,7 +34,13 @@
 
 #include "tests-scripts.h"
 
+/*
+ * Command line option to not fork the test running in the same process and
+ * making them easier to debug.
+ */
 static bool dont_fork;
+/* Fork the tests in parallel and then wait for their completion. */
+static bool parallel;
 const char *dso_to_test;
 const char *test_objdump_path = "objdump";
 
@@ -209,76 +218,36 @@ static bool perf_test__matches(const char *desc, int curr, int argc, const char
 	return false;
 }
 
-static int run_test(struct test_suite *test, int subtest)
-{
-	int status, err = -1, child = dont_fork ? 0 : fork();
-	char sbuf[STRERR_BUFSIZE];
-
-	if (child < 0) {
-		pr_err("failed to fork test: %s\n",
-			str_error_r(errno, sbuf, sizeof(sbuf)));
-		return -1;
-	}
-
-	if (!child) {
-		if (!dont_fork) {
-			pr_debug("test child forked, pid %d\n", getpid());
-
-			if (verbose <= 0) {
-				int nullfd = open("/dev/null", O_WRONLY);
-
-				if (nullfd >= 0) {
-					close(STDERR_FILENO);
-					close(STDOUT_FILENO);
-
-					dup2(nullfd, STDOUT_FILENO);
-					dup2(STDOUT_FILENO, STDERR_FILENO);
-					close(nullfd);
-				}
-			} else {
-				signal(SIGSEGV, sighandler_dump_stack);
-				signal(SIGFPE, sighandler_dump_stack);
-			}
-		}
-
-		err = test_function(test, subtest)(test, subtest);
-		if (!dont_fork)
-			exit(err);
-	}
-
-	if (!dont_fork) {
-		wait(&status);
+struct child_test {
+	struct child_process process;
+	struct test_suite *test;
+	int test_num;
+	int subtest;
+};
 
-		if (WIFEXITED(status)) {
-			err = (signed char)WEXITSTATUS(status);
-			pr_debug("test child finished with %d\n", err);
-		} else if (WIFSIGNALED(status)) {
-			err = -1;
-			pr_debug("test child interrupted\n");
-		}
-	}
+static int run_test_child(struct child_process *process)
+{
+	struct child_test *child = container_of(process, struct child_test, process);
+	int err;
 
-	return err;
+	pr_debug("--- start ---\n");
+	pr_debug("test child forked, pid %d\n", getpid());
+	err = test_function(child->test, child->subtest)(child->test, child->subtest);
+	pr_debug("---- end(%d) ----\n", err);
+	fflush(NULL);
+	return -err;
 }
 
-#define for_each_test(j, k, t)			\
-	for (j = 0, k = 0; j < ARRAY_SIZE(tests); j++, k = 0)	\
-		while ((t = tests[j][k++]) != NULL)
-
-static int test_and_print(struct test_suite *t, int subtest)
+static int print_test_result(struct test_suite *t, int i, int subtest, int result, int width)
 {
-	int err;
+	if (has_subtests(t)) {
+		int subw = width > 2 ? width - 2 : width;
 
-	pr_debug("\n--- start ---\n");
-	err = run_test(t, subtest);
-	pr_debug("---- end ----\n");
+		pr_info("%3d.%1d: %-*s:", i + 1, subtest + 1, subw, test_description(t, subtest));
+	} else
+		pr_info("%3d: %-*s:", i + 1, width, test_description(t, subtest));
 
-	if (!has_subtests(t))
-		pr_debug("%s:", t->desc);
-	else
-		pr_debug("%s subtest %d:", t->desc, subtest + 1);
-
-	switch (err) {
+	switch (result) {
 	case TEST_OK:
 		pr_info(" Ok\n");
 		break;
@@ -297,34 +266,186 @@ static int test_and_print(struct test_suite *t, int subtest)
 		break;
 	}
 
-	return err;
+	return 0;
+}
+
+static int finish_test(struct child_test *child_test, int width)
+{
+	struct test_suite *t = child_test->test;
+	int i = child_test->test_num;
+	int subi = child_test->subtest;
+	int out = child_test->process.out;
+	int err = child_test->process.err;
+	bool out_done = out <= 0;
+	bool err_done = err <= 0;
+	struct strbuf out_output = STRBUF_INIT;
+	struct strbuf err_output = STRBUF_INIT;
+	int ret;
+
+	/*
+	 * For test suites with subtests, display the suite name ahead of the
+	 * sub test names.
+	 */
+	if (has_subtests(t) && subi == 0)
+		pr_info("%3d: %-*s:\n", i + 1, width, test_description(t, -1));
+
+	/*
+	 * Busy loop reading from the child's stdout and stderr that are set to
+	 * be non-blocking until EOF.
+	 */
+	if (!out_done)
+		fcntl(out, F_SETFL, O_NONBLOCK);
+	if (!err_done)
+		fcntl(err, F_SETFL, O_NONBLOCK);
+	if (verbose > 1) {
+		if (has_subtests(t))
+			pr_info("%3d.%1d: %s:\n", i + 1, subi + 1, test_description(t, subi));
+		else
+			pr_info("%3d: %s:\n", i + 1, test_description(t, -1));
+	}
+	while (!out_done || !err_done) {
+		struct pollfd pfds[2] = {
+			{ .fd = out,
+			  .events = POLLIN | POLLERR | POLLHUP | POLLNVAL,
+			},
+			{ .fd = err,
+			  .events = POLLIN | POLLERR | POLLHUP | POLLNVAL,
+			},
+		};
+		char buf[512];
+		ssize_t len;
+
+		/* Poll to avoid excessive spinning, timeout set for 1000ms. */
+		poll(pfds, ARRAY_SIZE(pfds), /*timeout=*/1000);
+		if (!out_done && pfds[0].revents) {
+			errno = 0;
+			len = read(out, buf, sizeof(buf) - 1);
+
+			if (len <= 0) {
+				out_done = errno != EAGAIN;
+			} else {
+				buf[len] = '\0';
+				if (verbose > 1)
+					fprintf(stdout, "%s", buf);
+				else
+					strbuf_addstr(&out_output, buf);
+			}
+		}
+		if (!err_done && pfds[1].revents) {
+			errno = 0;
+			len = read(err, buf, sizeof(buf) - 1);
+
+			if (len <= 0) {
+				err_done = errno != EAGAIN;
+			} else {
+				buf[len] = '\0';
+				if (verbose > 1)
+					fprintf(stdout, "%s", buf);
+				else
+					strbuf_addstr(&err_output, buf);
+			}
+		}
+	}
+	/* Clean up child process. */
+	ret = finish_command(&child_test->process);
+	if (verbose == 1 && ret == TEST_FAIL) {
+		/* Add header for test that was skipped above. */
+		if (has_subtests(t))
+			pr_info("%3d.%1d: %s:\n", i + 1, subi + 1, test_description(t, subi));
+		else
+			pr_info("%3d: %s:\n", i + 1, test_description(t, -1));
+		fprintf(stdout, "%s", out_output.buf);
+		fprintf(stderr, "%s", err_output.buf);
+	}
+	strbuf_release(&out_output);
+	strbuf_release(&err_output);
+	print_test_result(t, i, subi, ret, width);
+	if (out > 0)
+		close(out);
+	if (err > 0)
+		close(err);
+	return 0;
+}
+
+static int start_test(struct test_suite *test, int i, int subi, struct child_test **child,
+		      int width)
+{
+	int err;
+
+	*child = NULL;
+	if (dont_fork) {
+		pr_debug("--- start ---\n");
+		err = test_function(test, subi)(test, subi);
+		pr_debug("---- end ----\n");
+		print_test_result(test, i, subi, err, width);
+		return 0;
+	}
+
+	*child = zalloc(sizeof(**child));
+	if (!*child)
+		return -ENOMEM;
+
+	(*child)->test = test;
+	(*child)->test_num = i;
+	(*child)->subtest = subi;
+	(*child)->process.pid = -1;
+	(*child)->process.no_stdin = 1;
+	if (verbose <= 0) {
+		(*child)->process.no_stdout = 1;
+		(*child)->process.no_stderr = 1;
+	} else {
+		(*child)->process.out = -1;
+		(*child)->process.err = -1;
+	}
+	(*child)->process.no_exec_cmd = run_test_child;
+	err = start_command(&(*child)->process);
+	if (err || parallel)
+		return  err;
+	return finish_test(*child, width);
 }
 
+#define for_each_test(j, k, t)					\
+	for (j = 0, k = 0; j < ARRAY_SIZE(tests); j++, k = 0)	\
+		while ((t = tests[j][k++]) != NULL)
+
 static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
 {
 	struct test_suite *t;
 	unsigned int j, k;
 	int i = 0;
 	int width = 0;
+	size_t num_tests = 0;
+	struct child_test **child_tests;
+	int child_test_num = 0;
 
 	for_each_test(j, k, t) {
 		int len = strlen(test_description(t, -1));
 
 		if (width < len)
 			width = len;
+
+		if (has_subtests(t)) {
+			for (int subi = 0, subn = num_subtests(t); subi < subn; subi++) {
+				len = strlen(test_description(t, subi));
+				if (width < len)
+					width = len;
+				num_tests++;
+			}
+		} else {
+			num_tests++;
+		}
 	}
+	child_tests = calloc(num_tests, sizeof(*child_tests));
+	if (!child_tests)
+		return -ENOMEM;
 
 	for_each_test(j, k, t) {
 		int curr = i++;
-		int subi;
 
 		if (!perf_test__matches(test_description(t, -1), curr, argc, argv)) {
 			bool skip = true;
-			int subn;
-
-			subn = num_subtests(t);
 
-			for (subi = 0; subi < subn; subi++) {
+			for (int subi = 0, subn = num_subtests(t); subi < subn; subi++) {
 				if (perf_test__matches(test_description(t, subi),
 							curr, argc, argv))
 					skip = false;
@@ -334,52 +455,45 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
 				continue;
 		}
 
-		pr_info("%3d: %-*s:", i, width, test_description(t, -1));
-
 		if (intlist__find(skiplist, i)) {
+			pr_info("%3d: %-*s:", curr + 1, width, test_description(t, -1));
 			color_fprintf(stderr, PERF_COLOR_YELLOW, " Skip (user override)\n");
 			continue;
 		}
 
 		if (!has_subtests(t)) {
-			test_and_print(t, -1);
-		} else {
-			int subn = num_subtests(t);
-			/*
-			 * minus 2 to align with normal testcases.
-			 * For subtest we print additional '.x' in number.
-			 * for example:
-			 *
-			 * 35: Test LLVM searching and compiling                        :
-			 * 35.1: Basic BPF llvm compiling test                          : Ok
-			 */
-			int subw = width > 2 ? width - 2 : width;
-
-			if (subn <= 0) {
-				color_fprintf(stderr, PERF_COLOR_YELLOW,
-					      " Skip (not compiled in)\n");
-				continue;
-			}
-			pr_info("\n");
+			int err = start_test(t, curr, -1, &child_tests[child_test_num++], width);
 
-			for (subi = 0; subi < subn; subi++) {
-				int len = strlen(test_description(t, subi));
-
-				if (subw < len)
-					subw = len;
+			if (err) {
+				/* TODO: if parallel waitpid the already forked children. */
+				free(child_tests);
+				return err;
 			}
+		} else {
+			for (int subi = 0, subn = num_subtests(t); subi < subn; subi++) {
+				int err;
 
-			for (subi = 0; subi < subn; subi++) {
 				if (!perf_test__matches(test_description(t, subi),
 							curr, argc, argv))
 					continue;
 
-				pr_info("%3d.%1d: %-*s:", i, subi + 1, subw,
-					test_description(t, subi));
-				test_and_print(t, subi);
+				err = start_test(t, curr, subi, &child_tests[child_test_num++],
+						 width);
+				if (err)
+					return err;
 			}
 		}
 	}
+	for (i = 0; i < child_test_num; i++) {
+		if (parallel) {
+			int ret  = finish_test(child_tests[i], width);
+
+			if (ret)
+				return ret;
+		}
+		free(child_tests[i]);
+	}
+	free(child_tests);
 	return 0;
 }
 
@@ -447,6 +561,8 @@ int cmd_test(int argc, const char **argv)
 		    "be more verbose (show symbol address, etc)"),
 	OPT_BOOLEAN('F', "dont-fork", &dont_fork,
 		    "Do not fork for testcase"),
+	OPT_BOOLEAN('p', "parallel", &parallel,
+		    "Run the tests altogether in parallel"),
 	OPT_STRING('w', "workload", &workload, "work", "workload to run for testing"),
 	OPT_STRING(0, "dso", &dso_to_test, "dso", "dso to test"),
 	OPT_STRING(0, "objdump", &test_objdump_path, "path",
-- 
2.44.0.rc0.258.g7320e95886-goog


