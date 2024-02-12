Return-Path: <linux-kernel+bounces-62246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D408A851D7D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 20:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AC28286E81
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 19:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1324CB54;
	Mon, 12 Feb 2024 18:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ylR/MUEQ"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2304C619
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 18:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707764367; cv=none; b=XEG6HLgkx5r67ki7Tn/pgkezOWhByBDbRLQQvH4jTu4BpQD17RiPG+cVx3+uhTnPLdUOIb4vbFeFA4NMnV/GlAU0A070sQYWKyigqLq/MDDy/26oh9lGWLs649GvZjYd3kxg/w+DhOkOktPI4Ea17ZtjIy4kjr2Pe6oofIHCeSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707764367; c=relaxed/simple;
	bh=e3Zo3j0Y+lDByuniGWZetsyjr0YP2URaOB3bhuKdkPg=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=l68pb11i03BhlyxbsyZxx+lCfAeAaJQlWKLS9/jqMaabKRVz1+8Q5Y1FzIWLhBZ0mCxhRWi5M9FcKwOC54OrjIPfyX61nC4KqyCN2qC8lw6ZfhMEtrnFT5bZA9l2wFXwcXAztpUJEiVmYsmAVBT52Zsrx6pioeScn/rDCxRCy4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ylR/MUEQ; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcc4563611cso91399276.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 10:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707764364; x=1708369164; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pKUjhtJivPO8JCDFJHJoi47s/FDcERs+KA6j2+NQ9Pw=;
        b=ylR/MUEQRNmZgmOMFzBEmUWxXFXgr8EGMDjGS4KxyOYH6OrU1BWo1NNqz+tALsYPvc
         cSGN7wk+G2B1nnGKufpp3NXCHIcxjyc+4Zfb1+rmXQya6N2L9/8xX9F4NpNlBKMnbb1W
         sH0SD50PWxGdLkgU25wfbvbymsTw8qTgg6zZcJJE8R0zWz1JmlAChFQVgGjBrSQ4x863
         SFTnEH1cDOSSP0sVFi3BHNiH0DA/3jMvF8qB6tuLy+ElIOAXJ84ohfOwUFl6oGm23KUX
         qgV2OuQFdJKALpwBW89KrROimcb3vF8JOT7XD56CqkHxA9zdDsZ2Vw/RVbnswnvkIjBD
         IVAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707764364; x=1708369164;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pKUjhtJivPO8JCDFJHJoi47s/FDcERs+KA6j2+NQ9Pw=;
        b=DriOBD2fEqeizq+o5N5iWIIPeroJ7N9hvhN8OIvkG09zAcinrpXecU4GCPWQm3gD4P
         7FmdlwlGz3tHRuOdmDuX4w/XzbLVlviqcCdpv2VSjv0MW6RqSJhlnY8MgLYVoRPSNCLn
         P9C/MsNYTxFNs83GxVFo8yaAxjSrpjObmaA+3pxzFZrmJjoJq0A8b9wo+mES0afogk2j
         +48oaQZOzGX7k6j7caX+KMlK/sQLdG58nCQawegfLfiJTAqFbTavH/twjrK+M5wY0OGv
         lBDHd/vL+MtFbyvdVyloreMzUPx3W8STyFypHY9dLgn0UBQXcRAUva0jCLAgYsuSZGT6
         YOig==
X-Forwarded-Encrypted: i=1; AJvYcCUdIfjvZWul/L+dL/bcXL7Hn2W+ovjRsUN/HwK32ZW1EJIY+3ZFfCV7gRpnEaD9p2I9GM+cFQYEa9TkDJKFK+ebwwNX5Zdc+sfgyuyc
X-Gm-Message-State: AOJu0Yzt1D1B0RBZpvA9GjhaPGj1TTNpF7PmEVtJ4kg8afFcGOAfvLat
	V0tNSwnehkm2XFIvJ0d3ELF+VTiTGZL86AVwiss0teRsiHtCuCdIeDOBPwx/Nvmppn9ayt5FM/b
	Enm3PIA==
X-Google-Smtp-Source: AGHT+IGp0Tsh7Pkj0Vy343kMXSz7NO54KJv8lgbh53tJQw9m113ZOWAhaXvei7ITu3tfs9FrEXppNbX4CDUw
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:125c:bcda:4fe2:b6e6])
 (user=irogers job=sendgmr) by 2002:a25:6910:0:b0:dc2:398d:a671 with SMTP id
 e16-20020a256910000000b00dc2398da671mr1960328ybc.10.1707764364421; Mon, 12
 Feb 2024 10:59:24 -0800 (PST)
Date: Mon, 12 Feb 2024 10:58:57 -0800
In-Reply-To: <20240212185858.68189-1-irogers@google.com>
Message-Id: <20240212185858.68189-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240212185858.68189-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Subject: [PATCH v3 7/8] perf tests: Run time generate shell test suites
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	James Clark <james.clark@arm.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Yang Jihong <yangjihong1@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Rather than special shell test logic, do a single pass to create an
array of test suites. Hold the shell test file name in the test suite
priv field. This makes the special shell test logic in builtin-test.c
redundant so remove it.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c  |  91 +---------------------
 tools/perf/tests/tests-scripts.c | 130 ++++++++++++++++++-------------
 tools/perf/tests/tests-scripts.h |  10 +--
 3 files changed, 81 insertions(+), 150 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 6d5001daaf63..c42cb40fc242 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -130,6 +130,7 @@ static struct test_suite *generic_tests[] = {
 static struct test_suite **tests[] = {
 	generic_tests,
 	arch_tests,
+	NULL, /* shell tests created at runtime. */
 };
 
 static struct test_workload *workloads[] = {
@@ -299,74 +300,12 @@ static int test_and_print(struct test_suite *t, int subtest)
 	return err;
 }
 
-struct shell_test {
-	const char *file;
-};
-
-static int shell_test__run(struct test_suite *test, int subdir __maybe_unused)
-{
-	int err;
-	struct shell_test *st = test->priv;
-	char *cmd;
-
-	asprintf(&cmd, "%s%s", st->file, verbose ? " -v" : "");
-	if (!cmd)
-		return TEST_FAIL;
-	err = system(cmd);
-	free(cmd);
-	if (!err)
-		return TEST_OK;
-
-	return WEXITSTATUS(err) == 2 ? TEST_SKIP : TEST_FAIL;
-}
-
-static int run_shell_tests(int argc, const char *argv[], int i, int width,
-				struct intlist *skiplist)
-{
-	struct shell_test st;
-	const struct script_file *files, *file;
-
-	files = list_script_files();
-	if (!files)
-		return 0;
-	for (file = files; file->file; file++) {
-		int curr = i++;
-		struct test_case test_cases[] = {
-			{
-				.desc = file->desc,
-				.run_case = shell_test__run,
-			},
-			{ .name = NULL, }
-		};
-		struct test_suite test_suite = {
-			.desc = test_cases[0].desc,
-			.test_cases = test_cases,
-			.priv = &st,
-		};
-		st.file = file->file;
-
-		if (test_suite.desc == NULL ||
-		    !perf_test__matches(test_suite.desc, curr, argc, argv))
-			continue;
-
-		pr_info("%3d: %-*s:", i, width, test_suite.desc);
-
-		if (intlist__find(skiplist, i)) {
-			color_fprintf(stderr, PERF_COLOR_YELLOW, " Skip (user override)\n");
-			continue;
-		}
-
-		test_and_print(&test_suite, 0);
-	}
-	return 0;
-}
-
 static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
 {
 	struct test_suite *t;
 	unsigned int j, k;
 	int i = 0;
-	int width = list_script_max_width();
+	int width = 0;
 
 	for_each_test(j, k, t) {
 		int len = strlen(test_description(t, -1));
@@ -441,28 +380,6 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
 			}
 		}
 	}
-
-	return run_shell_tests(argc, argv, i, width, skiplist);
-}
-
-static int perf_test__list_shell(int argc, const char **argv, int i)
-{
-	const struct script_file *files, *file;
-
-	files = list_script_files();
-	if (!files)
-		return 0;
-	for (file = files; file->file; file++) {
-		int curr = i++;
-		struct test_suite t = {
-			.desc = file->desc
-		};
-
-		if (!perf_test__matches(t.desc, curr, argc, argv))
-			continue;
-
-		pr_info("%3d: %s\n", i, t.desc);
-	}
 	return 0;
 }
 
@@ -489,9 +406,6 @@ static int perf_test__list(int argc, const char **argv)
 					test_description(t, subi));
 		}
 	}
-
-	perf_test__list_shell(argc, argv, i);
-
 	return 0;
 }
 
@@ -551,6 +465,7 @@ int cmd_test(int argc, const char **argv)
 	/* Unbuffered output */
 	setvbuf(stdout, NULL, _IONBF, 0);
 
+	tests[2] = create_script_test_suites();
 	argc = parse_options_subcommand(argc, argv, test_options, test_subcommands, test_usage, 0);
 	if (argc >= 1 && !strcmp(argv[0], "list"))
 		return perf_test__list(argc - 1, argv + 1);
diff --git a/tools/perf/tests/tests-scripts.c b/tools/perf/tests/tests-scripts.c
index 9b3b66dd5508..e60867b1e5ce 100644
--- a/tools/perf/tests/tests-scripts.c
+++ b/tools/perf/tests/tests-scripts.c
@@ -26,16 +26,6 @@
 #include "tests.h"
 #include "util/rlimit.h"
 
-
-/*
- * As this is a singleton built once for the run of the process, there is
- * no value in trying to free it and just let it stay around until process
- * exits when it's cleaned up.
- */
-static size_t files_num = 0;
-static struct script_file *files = NULL;
-static int files_max_width = 0;
-
 static int shell_tests__dir_fd(void)
 {
 	char path[PATH_MAX], *exec_path;
@@ -131,12 +121,31 @@ static char *strdup_check(const char *str)
 	return newstr;
 }
 
-static void append_script(int dir_fd, const char *name, char *desc)
+static int shell_test__run(struct test_suite *test, int subtest __maybe_unused)
+{
+	const char *file = test->priv;
+	int err;
+	char *cmd;
+
+	asprintf(&cmd, "%s%s", file, verbose ? " -v" : "");
+	if (!cmd)
+		return TEST_FAIL;
+	err = system(cmd);
+	free(cmd);
+	if (!err)
+		return TEST_OK;
+
+	return WEXITSTATUS(err) == 2 ? TEST_SKIP : TEST_FAIL;
+}
+
+static void append_script(int dir_fd, const char *name, char *desc,
+			  struct test_suite ***result,
+			  size_t *result_sz)
 {
 	char filename[PATH_MAX], link[128];
-	struct script_file *files_tmp;
-	size_t files_num_tmp, len;
-	int width;
+	struct test_suite *test_suite, **result_tmp;
+	struct test_case *tests;
+	size_t len;
 
 	snprintf(link, sizeof(link), "/proc/%d/fd/%d", getpid(), dir_fd);
 	len = readlink(link, filename, sizeof(filename));
@@ -146,33 +155,43 @@ static void append_script(int dir_fd, const char *name, char *desc)
 	}
 	filename[len++] = '/';
 	strcpy(&filename[len], name);
-	files_num_tmp = files_num + 1;
-	if (files_num_tmp >= SIZE_MAX) {
-		pr_err("Too many script files\n");
-		abort();
+
+	tests = calloc(2, sizeof(*tests));
+	if (!tests) {
+		pr_err("Out of memory while building script test suite list\n");
+		return;
 	}
+	tests[0].name = strdup_check(name);
+	tests[0].desc = strdup_check(desc);
+	tests[0].run_case = shell_test__run;
+
+	test_suite = zalloc(sizeof(*test_suite));
+	if (!test_suite) {
+		pr_err("Out of memory while building script test suite list\n");
+		free(tests);
+		return;
+	}
+	test_suite->desc = desc;
+	test_suite->test_cases = tests;
+	test_suite->priv = strdup_check(filename);
 	/* Realloc is good enough, though we could realloc by chunks, not that
 	 * anyone will ever measure performance here */
-	files_tmp = realloc(files,
-			    (files_num_tmp + 1) * sizeof(struct script_file));
-	if (files_tmp == NULL) {
-		pr_err("Out of memory while building test list\n");
-		abort();
+	result_tmp = realloc(*result, (*result_sz + 1) * sizeof(*result_tmp));
+	if (result_tmp == NULL) {
+		pr_err("Out of memory while building script test suite list\n");
+		free(tests);
+		free(test_suite);
+		return;
 	}
 	/* Add file to end and NULL terminate the struct array */
-	files = files_tmp;
-	files_num = files_num_tmp;
-	files[files_num - 1].file = strdup_check(filename);
-	files[files_num - 1].desc = desc;
-	files[files_num].file = NULL;
-	files[files_num].desc = NULL;
-
-	width = strlen(desc); /* Track max width of desc */
-	if (width > files_max_width)
-		files_max_width = width;
+	*result = result_tmp;
+	(*result)[*result_sz] = test_suite;
+	(*result_sz)++;
 }
 
-static void append_scripts_in_dir(int dir_fd)
+static void append_scripts_in_dir(int dir_fd,
+				  struct test_suite ***result,
+				  size_t *result_sz)
 {
 	struct dirent **entlist;
 	struct dirent *ent;
@@ -191,7 +210,7 @@ static void append_scripts_in_dir(int dir_fd)
 			char *desc = shell_test__description(dir_fd, ent->d_name);
 
 			if (desc) /* It has a desc line - valid script */
-				append_script(dir_fd, ent->d_name, desc);
+				append_script(dir_fd, ent->d_name, desc, result, result_sz);
 			continue;
 		}
 		if (ent->d_type != DT_DIR) {
@@ -204,32 +223,35 @@ static void append_scripts_in_dir(int dir_fd)
 				continue;
 		}
 		fd = openat(dir_fd, ent->d_name, O_PATH);
-		append_scripts_in_dir(fd);
+		append_scripts_in_dir(fd, result, result_sz);
 	}
 	for (i = 0; i < n_dirs; i++) /* Clean up */
 		zfree(&entlist[i]);
 	free(entlist);
 }
 
-const struct script_file *list_script_files(void)
+struct test_suite **create_script_test_suites(void)
 {
-	int dir_fd;
-
-	if (files)
-		return files; /* Singleton - we already know our list */
-
-	dir_fd = shell_tests__dir_fd(); /* Walk  dir */
-	if (dir_fd < 0)
-		return NULL;
+	struct test_suite **result = NULL, **result_tmp;
+	size_t result_sz = 0;
+	int dir_fd = shell_tests__dir_fd(); /* Walk  dir */
 
-	append_scripts_in_dir(dir_fd);
-	close(dir_fd);
+	/*
+	 * Append scripts if fd is good, otherwise return a NULL terminated zero
+	 * length array.
+	 */
+	if (dir_fd >= 0)
+		append_scripts_in_dir(dir_fd, &result, &result_sz);
 
-	return files;
-}
-
-int list_script_max_width(void)
-{
-	list_script_files(); /* Ensure we have scanned all scripts */
-	return files_max_width;
+	result_tmp = realloc(result, (result_sz + 1) * sizeof(*result_tmp));
+	if (result_tmp == NULL) {
+		pr_err("Out of memory while building script test suite list\n");
+		abort();
+	}
+	/* NULL terminate the test suite array. */
+	result = result_tmp;
+	result[result_sz] = NULL;
+	if (dir_fd >= 0)
+		close(dir_fd);
+	return result;
 }
diff --git a/tools/perf/tests/tests-scripts.h b/tools/perf/tests/tests-scripts.h
index 3508a293aaf9..b553ad26ea17 100644
--- a/tools/perf/tests/tests-scripts.h
+++ b/tools/perf/tests/tests-scripts.h
@@ -2,14 +2,8 @@
 #ifndef TESTS_SCRIPTS_H
 #define TESTS_SCRIPTS_H
 
-struct script_file {
-	char *file;
-	char *desc;
-};
+#include "tests.h"
 
-/* List available script tests to run - singleton - never freed */
-const struct script_file *list_script_files(void);
-/* Get maximum width of description string */
-int list_script_max_width(void);
+struct test_suite **create_script_test_suites(void);
 
 #endif /* TESTS_SCRIPTS_H */
-- 
2.43.0.687.g38aa6559b0-goog


