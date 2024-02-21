Return-Path: <linux-kernel+bounces-74017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A43A885CEED
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 04:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7D811C22333
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 03:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3A03BB4E;
	Wed, 21 Feb 2024 03:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qFNIFl67"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5B03A8CA
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 03:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708486943; cv=none; b=Db6aW8wgoHAOBcbxD5IySZyCTpV2vE21za4ePD6uf1T1Turt8F4YBYAK/rKWbkHWlQk7Upuebh9L1svKNribJ7RT2mAetU/64J+UmsCV0ax+fWRvm1cZo5loZRtiM3IN3uqHm/4/VZsYoVgMY1BHGV+7NDy2DOYPGOp7i+TSTVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708486943; c=relaxed/simple;
	bh=53jT037aEfk5XcFmEFkxjxpT8RKj6m5/qirKoy031Rc=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=j/1uDokjK+O7enlNgsGcz2eMBenPXu+WPzA5/jn0ZjUlRjcXXUbC+x4fOGrgFsnK6u/zFl93HewZOj4KZRCuzXKfBLnn6eJFslgp3TEGMQD6N4ZW+jFCB3emttUaHL6i2CdAx7l5PhfeBTfzyxW/CVhr1Xqnfyp23A5NexX/H2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qFNIFl67; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6047a047f4cso4483147b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 19:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708486940; x=1709091740; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bs0vGCr4d3+lgKm3VULbLfJ1W710iiXQYeVwqOAeIjg=;
        b=qFNIFl67sWIGunz/LqHFOBvJ3wMYQemxA2fTt2hzhRmAfMfWk4ytAqDXrFM6v2PV5G
         NNE7iR4hAeOR/lD2lmzzC1CiQKkhRUzWVKMoguhIh2aN1+UUELT+7Ic/e3kGS390ndOk
         8T29Cz8XtLFcD8LmKWJRxocwpkbOPjsA4iCjLFiwlNKFuXjY+gi6fBZzQ+7a7vJXYwmo
         6a9vTBWKjUso6ncUWOXQJ8DePrfMZtsGWQpFxZH/AEkyHpqY/Q0pw1PwJ7CNXsvyQKnQ
         sxC5zMNGhdFDRycDsqVmjoiFyQpOHSGVV94qA408kEWnQgIT22ONlBzmG4pMH52vwmpZ
         eP+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708486940; x=1709091740;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bs0vGCr4d3+lgKm3VULbLfJ1W710iiXQYeVwqOAeIjg=;
        b=rrvT/9JfJGCbqM8fc1GB+8282PuhbLhgYKiiCUZUByMhPA3VA8Ed+IENHRiG5TW22L
         O81GQpe6faHBgZAeLqlemIKVkUaQHbto24IVCuRsVX9WMx3Otj3WaaeJEuTxky62pdCf
         TPUgpl+v64ZQMfGsPncVrVFoSNJgcqxFmAxFxdkHG/WAaIqpqofu0Once3v3+jVqzcRe
         P5ngEBPa0upcrOHtNXRhjwdfaQFq2ZAPKkvUfl9zOCwZrTE7WwAFe1zJOrm6u06wjviL
         KmXC1CeRoVCIhTkRW8GZa3IQi0DQhx+N/tD052BOA7Nk15Q0/5BNrD16B3CTm59YIcKN
         IQ2A==
X-Forwarded-Encrypted: i=1; AJvYcCXryZgwzv3BjpbpVg2s40kJN7UWnICT4DiloQn2vtTZM5tX2o8MVTe9k/bOsm7PUVyfdahSonGDS3keCosuU0pA/e5sfFpYO6MqJrpK
X-Gm-Message-State: AOJu0YyJLuWf2Y+UZwD40gz72BXpa5r9yOSy2vL0n58onouml/fYMo54
	h0A4UO3nGzzsmFXskilGtmcolfwciuaRv30Q8/8XXI8U0KnyP+Uc7QJvp4aOqCxkVv75nPqHCQ4
	butPB1A==
X-Google-Smtp-Source: AGHT+IFkMkC4Wb84JVMKuT9ldEtCib5JdyOx/nCJnzKBMt6F39ZqX9PII+IJIak4m8bhYxA2ALhKqasXZb0t
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:3c02:f882:5876:b7ab])
 (user=irogers job=sendgmr) by 2002:a81:6dd0:0:b0:608:3329:2f13 with SMTP id
 i199-20020a816dd0000000b0060833292f13mr1885586ywc.8.1708486940220; Tue, 20
 Feb 2024 19:42:20 -0800 (PST)
Date: Tue, 20 Feb 2024 19:41:54 -0800
In-Reply-To: <20240221034155.1500118-1-irogers@google.com>
Message-Id: <20240221034155.1500118-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240221034155.1500118-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Subject: [PATCH v6 7/8] perf tests: Run time generate shell test suites
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

Rather than special shell test logic, do a single pass to create an
array of test suites. Hold the shell test file name in the test suite
priv field. This makes the special shell test logic in builtin-test.c
redundant so remove it.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c  |  90 +--------------------
 tools/perf/tests/tests-scripts.c | 129 ++++++++++++++++++-------------
 tools/perf/tests/tests-scripts.h |  10 +--
 3 files changed, 80 insertions(+), 149 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 162f9eb090ac..c42cb40fc242 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -130,6 +130,7 @@ static struct test_suite *generic_tests[] = {
 static struct test_suite **tests[] = {
 	generic_tests,
 	arch_tests,
+	NULL, /* shell tests created at runtime. */
 };
 
 static struct test_workload *workloads[] = {
@@ -299,73 +300,12 @@ static int test_and_print(struct test_suite *t, int subtest)
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
-	char *cmd = NULL;
-
-	if (asprintf(&cmd, "%s%s", st->file, verbose ? " -v" : "") < 0)
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
@@ -440,28 +380,6 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
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
 
@@ -488,9 +406,6 @@ static int perf_test__list(int argc, const char **argv)
 					test_description(t, subi));
 		}
 	}
-
-	perf_test__list_shell(argc, argv, i);
-
 	return 0;
 }
 
@@ -550,6 +465,7 @@ int cmd_test(int argc, const char **argv)
 	/* Unbuffered output */
 	setvbuf(stdout, NULL, _IONBF, 0);
 
+	tests[2] = create_script_test_suites();
 	argc = parse_options_subcommand(argc, argv, test_options, test_subcommands, test_usage, 0);
 	if (argc >= 1 && !strcmp(argv[0], "list"))
 		return perf_test__list(argc - 1, argv + 1);
diff --git a/tools/perf/tests/tests-scripts.c b/tools/perf/tests/tests-scripts.c
index c21f7a425da9..e2042b368269 100644
--- a/tools/perf/tests/tests-scripts.c
+++ b/tools/perf/tests/tests-scripts.c
@@ -27,16 +27,6 @@
 #include "util/rlimit.h"
 #include "util/util.h"
 
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
@@ -132,12 +122,30 @@ static char *strdup_check(const char *str)
 	return newstr;
 }
 
-static void append_script(int dir_fd, const char *name, char *desc)
+static int shell_test__run(struct test_suite *test, int subtest __maybe_unused)
+{
+	const char *file = test->priv;
+	int err;
+	char *cmd = NULL;
+
+	if (asprintf(&cmd, "%s%s", file, verbose ? " -v" : "") < 0)
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
@@ -147,33 +155,43 @@ static void append_script(int dir_fd, const char *name, char *desc)
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
@@ -192,7 +210,7 @@ static void append_scripts_in_dir(int dir_fd)
 			char *desc = shell_test__description(dir_fd, ent->d_name);
 
 			if (desc) /* It has a desc line - valid script */
-				append_script(dir_fd, ent->d_name, desc);
+				append_script(dir_fd, ent->d_name, desc, result, result_sz);
 			continue;
 		}
 		if (ent->d_type != DT_DIR) {
@@ -205,32 +223,35 @@ static void append_scripts_in_dir(int dir_fd)
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
2.44.0.rc0.258.g7320e95886-goog


