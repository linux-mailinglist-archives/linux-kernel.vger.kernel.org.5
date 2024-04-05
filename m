Return-Path: <linux-kernel+bounces-132528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED887899644
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6578A1F2835B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 07:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4212E83C;
	Fri,  5 Apr 2024 07:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nogE8Ygh"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1A22C691
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 07:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712300988; cv=none; b=BAIEPVItTgYN+5UFG1Bh3e0du1/8Z3l/E2ruEbYMwN044JcjmUjjbNk98FWw+XXg7fUF8BCesdhuWx5bG05oE2G8s/3pwm2kcTLEK1QdDFQQqwucKAnPXvlNq99iv5TeV5XTA2/l+yR5aKqZIdTUkGLVq2nElpiNft9bsG6Y00w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712300988; c=relaxed/simple;
	bh=VQdVOjuFNCXOa8vkszw3kZMD2q0Y4KMc33Opfqtl/As=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=NQOwNq7QvKgfvmvgONgqkvwZYtKNYPYW8ToVcXc2LZnJbE7oIikldS3i4vtMMhSIBXG7+g4StkQmp4Ufjs78ianL6JTBLlco0mWeROD3FaEG1X8R+WLFpfW2aktgaWd3I70ziXc4WX1UYluozcB8rC3rY+aupINmBwQ8HtLkxL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nogE8Ygh; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-610b96c8ca2so30903327b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 00:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712300986; x=1712905786; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AT9Egetdt6A++F2BYy2vD+NdRNiosWU6soZGtG4+BZw=;
        b=nogE8Ygh7A5HMW+f914ydS5RxObgEVskc/e/CStLuN4NQ4I1mkXxKIGYbuY+GQoT3M
         v5c0eomMAiJV1/+iKMaXv/AvaIL6CnV3zLeRhmgJDZ2A90E1hvcPNtE8QB1ggLOrgK4i
         ktwtX2nYkWZxO2EinJLyXcXHQ5vv0dNn95iQ7tK4/oBfDPfAUb65C3HzV8IdoguGU8an
         PXZdKwy8JzM4T5vgTHYeLz43xEPBGtqZz8MAol+bOeKQbCoamqQmHrCZSWQ/z9STm7we
         tQluKPp/hMtJNDIsJvOKJDcGmEXFKc62ZG31uXRtCijNG9oCY34fio/94Y4yddeoe90b
         cA/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712300986; x=1712905786;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AT9Egetdt6A++F2BYy2vD+NdRNiosWU6soZGtG4+BZw=;
        b=vgwqpblYx0bIsabf8MCYIxb1xGLyLpCixU9In25UpXGFwDgxMkQIyD6WmAx9jgbBwH
         pJuFTpc+Yu7Ek6e5PSfn4eD7cdQmESOLIzo2Yxuvr57lIiUxO57iqPhdPOLXjqcvOpxY
         FG1UDLcsiptbLwta1BqJjMJ2j41PRFfOFbrF3Qyjcq++i/4Mnp5nGmWu9iZ5AUJWkfEN
         E74RyuTYVHscxuMFfo76v1ckNK0tyXqegy0MZhkwk5HjHI6jtNc5KMlkLIFuGNeic3q9
         zVgUpY870J2CLeghfx5rynLag7zXAY8XOuogb2CeDcqeqEaZRYvrCtby6P4Kl3pcKjO5
         YuVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVA6nfXGkDHDeq8feld3ChFkh+Y2gw9emKqf/YUjfk75YN4hWKNbrluODSkRE9CigSTILC5SNzVeThF6vfeoU7R1LN5kbTcGQzYDS1
X-Gm-Message-State: AOJu0YykcMYp++E1on9y9bJTYVzN4FSS9i+a+5prcJg91WMI1GrNmkjB
	wVLStanrNgPiCZ9Vx+LfOUenOLFqtMlzme2YNZRHv5m2OIc8wHBilHp5T5nK5afQyRbi5DhvNg0
	aE3+d1g==
X-Google-Smtp-Source: AGHT+IGhGx96fxbkEMZrzw8bqd79Y1y+1w5eH772l6o7gnSy1Ymlw+0QtvD3GcsuT0krXWaIobPvtTej3oAc
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6765:20d3:72cb:f573])
 (user=irogers job=sendgmr) by 2002:a05:690c:6382:b0:615:df:f4bc with SMTP id
 hp2-20020a05690c638200b0061500dff4bcmr160786ywb.4.1712300986068; Fri, 05 Apr
 2024 00:09:46 -0700 (PDT)
Date: Fri,  5 Apr 2024 00:09:31 -0700
In-Reply-To: <20240405070931.1231245-1-irogers@google.com>
Message-Id: <20240405070931.1231245-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240405070931.1231245-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Subject: [PATCH v1 2/2] perf test: Display number of remaining tests
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@arm.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Before polling or sleeping to wait for a test to complete, print out
": Running (<num> remaining)" where the number of remaining tests is
determined by iterating over the remaining tests and seeing which
return true for check_if_command_finished. After the delay, erase the
line and either update it with the new number of remaining tests, or
print the test's result. This allows a user to know a test is running
and in parallel mode (default) how many of the tests are waiting to
complete. If color mode is disabled then avoid displaying the
"Running" message.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c | 77 ++++++++++++++++++++++-----------
 tools/perf/util/color.h         |  1 +
 2 files changed, 53 insertions(+), 25 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 73f53b02f733..15b8e8e32749 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -238,7 +238,10 @@ static int run_test_child(struct child_process *process)
 	return -err;
 }
 
-static int print_test_result(struct test_suite *t, int i, int subtest, int result, int width)
+#define TEST_RUNNING -3
+
+static int print_test_result(struct test_suite *t, int i, int subtest, int result, int width,
+			     int remaining)
 {
 	if (has_subtests(t)) {
 		int subw = width > 2 ? width - 2 : width;
@@ -248,6 +251,9 @@ static int print_test_result(struct test_suite *t, int i, int subtest, int resul
 		pr_info("%3d: %-*s:", i + 1, width, test_description(t, subtest));
 
 	switch (result) {
+	case TEST_RUNNING:
+		color_fprintf(stderr, PERF_COLOR_YELLOW, " Running (%d remaining)\n", remaining);
+		break;
 	case TEST_OK:
 		pr_info(" Ok\n");
 		break;
@@ -269,13 +275,15 @@ static int print_test_result(struct test_suite *t, int i, int subtest, int resul
 	return 0;
 }
 
-static int finish_test(struct child_test *child_test, int width)
+static int finish_test(struct child_test **child_tests, int running_test, int child_test_num,
+		       int width)
 {
+	struct child_test *child_test = child_tests[running_test];
 	struct test_suite *t = child_test->test;
 	int i = child_test->test_num;
 	int subi = child_test->subtest;
 	int err = child_test->process.err;
-	bool err_done = err <= 0;
+	bool err_done = false;
 	struct strbuf err_output = STRBUF_INIT;
 	int ret;
 
@@ -290,7 +298,7 @@ static int finish_test(struct child_test *child_test, int width)
 	 * Busy loop reading from the child's stdout/stderr that are set to be
 	 * non-blocking until EOF.
 	 */
-	if (!err_done)
+	if (err > 0)
 		fcntl(err, F_SETFL, O_NONBLOCK);
 	if (verbose > 1) {
 		if (has_subtests(t))
@@ -304,29 +312,48 @@ static int finish_test(struct child_test *child_test, int width)
 			  .events = POLLIN | POLLERR | POLLHUP | POLLNVAL,
 			},
 		};
-		char buf[512];
-		ssize_t len;
-
-		/* Poll to avoid excessive spinning, timeout set for 100ms. */
-		poll(pfds, ARRAY_SIZE(pfds), /*timeout=*/100);
-		if (!err_done && pfds[0].revents) {
-			errno = 0;
-			len = read(err, buf, sizeof(buf) - 1);
-
-			if (len <= 0) {
-				err_done = errno != EAGAIN;
-			} else {
-				buf[len] = '\0';
-				if (verbose > 1)
-					fprintf(stdout, "%s", buf);
-				else
+		if (perf_use_color_default) {
+			int tests_in_progress = running_test;
+
+			for (int y = running_test; y < child_test_num; y++) {
+				if (check_if_command_finished(&child_tests[y]->process))
+					tests_in_progress++;
+			}
+			print_test_result(t, i, subi, TEST_RUNNING, width,
+					  child_test_num - tests_in_progress);
+		}
+
+		err_done = true;
+		if (err <= 0) {
+			/* No child stderr to poll, sleep for 10ms for child to complete. */
+			usleep(10 * 1000);
+		} else {
+			/* Poll to avoid excessive spinning, timeout set for 100ms. */
+			poll(pfds, ARRAY_SIZE(pfds), /*timeout=*/100);
+			if (pfds[0].revents) {
+				char buf[512];
+				ssize_t len;
+
+				len = read(err, buf, sizeof(buf) - 1);
+
+				if (len > 0) {
+					err_done = false;
+					buf[len] = '\0';
 					strbuf_addstr(&err_output, buf);
+				}
 			}
 		}
+		if (err_done)
+			err_done = check_if_command_finished(&child_test->process);
+
+		if (perf_use_color_default) {
+			/* Erase "Running (.. remaining)" line printed before poll/sleep. */
+			fprintf(debug_file(), PERF_COLOR_DELETE_LINE);
+		}
 	}
 	/* Clean up child process. */
 	ret = finish_command(&child_test->process);
-	if (verbose == 1 && ret == TEST_FAIL) {
+	if (verbose > 1 || (verbose == 1 && ret == TEST_FAIL)) {
 		/* Add header for test that was skipped above. */
 		if (has_subtests(t))
 			pr_info("%3d.%1d: %s:\n", i + 1, subi + 1, test_description(t, subi));
@@ -335,7 +362,7 @@ static int finish_test(struct child_test *child_test, int width)
 		fprintf(stderr, "%s", err_output.buf);
 	}
 	strbuf_release(&err_output);
-	print_test_result(t, i, subi, ret, width);
+	print_test_result(t, i, subi, ret, width, /*remaining=*/0);
 	if (err > 0)
 		close(err);
 	return 0;
@@ -351,7 +378,7 @@ static int start_test(struct test_suite *test, int i, int subi, struct child_tes
 		pr_debug("--- start ---\n");
 		err = test_function(test, subi)(test, subi);
 		pr_debug("---- end ----\n");
-		print_test_result(test, i, subi, err, width);
+		print_test_result(test, i, subi, err, width, /*remaining=*/0);
 		return 0;
 	}
 
@@ -376,7 +403,7 @@ static int start_test(struct test_suite *test, int i, int subi, struct child_tes
 	err = start_command(&(*child)->process);
 	if (err || !sequential)
 		return  err;
-	return finish_test(*child, width);
+	return finish_test(child, /*running_test=*/0, /*child_test_num=*/1, width);
 }
 
 #define for_each_test(j, k, t)					\
@@ -461,7 +488,7 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
 	}
 	for (i = 0; i < child_test_num; i++) {
 		if (!sequential) {
-			int ret  = finish_test(child_tests[i], width);
+			int ret  = finish_test(child_tests, i, child_test_num, width);
 
 			if (ret)
 				return ret;
diff --git a/tools/perf/util/color.h b/tools/perf/util/color.h
index 01f7bed21c9b..4b9f8d5d4439 100644
--- a/tools/perf/util/color.h
+++ b/tools/perf/util/color.h
@@ -22,6 +22,7 @@
 #define MIN_GREEN	0.5
 #define MIN_RED		5.0
 
+#define PERF_COLOR_DELETE_LINE	"\033[A\33[2K\r"
 /*
  * This variable stores the value of color.ui
  */
-- 
2.44.0.478.gd926399ef9-goog


