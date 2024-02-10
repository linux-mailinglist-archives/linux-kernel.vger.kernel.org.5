Return-Path: <linux-kernel+bounces-60281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2AF85028E
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 05:41:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CF1F1C213A3
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 04:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF65163B3;
	Sat, 10 Feb 2024 04:41:34 +0000 (UTC)
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2F963BF;
	Sat, 10 Feb 2024 04:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707540094; cv=none; b=NRfneaW9b1OGOOyrb6oijJ85BuP6t1X1vIXKGQ/NQocnNQ+2i5zGPyTqWgFobeSH/2GmsBG4wXDTsvurB7vDPSmO8x4p8yAJ08sxC7oMe806yqsGYQy+QMHanS3ipJWMMIyILr3UJDlCK62I2wHi1FFLky7TIIuu1YYdqPbGc7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707540094; c=relaxed/simple;
	bh=GLQwUlX1cKgBApD4HUJVZHNadnNaDHDG9a2gI8aV+xA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rz1+YC+22XkXgtr5bK2ghnOCxwJ8x9fUCEv4w7x5CLT6vGEuAlCKiQvKhU7+pVN5F4kqQfCd8UiggPT8f2UDEzVZwYNTAE4NZQxNWh2OX8ZZZL/7vzJtf1g1bAP9qnDrCKcYPGQDMcuKmYaukWIszGles0FqlaqZuRc8FnjjeJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3bbbc6b4ed1so1118596b6e.2;
        Fri, 09 Feb 2024 20:41:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707540090; x=1708144890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vJJDnKIJ7vJ3mZ+52T9UkXxtz4pK3YLV5wI4fOwsJcA=;
        b=XpjgKUtFSBqD+tP+QsS1uk0PxdvA21fgJ9YPPp3xTsNJ2FfJtglNBs6Yvql/ck5R+h
         n0Zi/UcC+X+OWQAKq7DLK/KYv8nxYpBtNwySHEG5ZHtsRORqcWlSPmZ8cEq9RFvSzcRM
         +v3bix5QMW+LUL5h/ia1NjnZmfxoCiKNvgbOsKh7K/ykYWihNXBS+8zGIBG8aGdDDvMA
         z1MOWZ4zrnmnk5U/feVva3Ah7o+lW1cDdWJhD9IyqkH3b1OTrp+PBttzSdwSGK8QNGYq
         BGjgpipKxEBcj5mMnpNT+qIvJFZmd6/JACNpk8YdKk+AG9iW+JQfkBFaUtmUeOoy2lO8
         3gPw==
X-Gm-Message-State: AOJu0Yy71ZwdMVBGHHLBF+R8ME2m+f7kx4UVjs8ADKdzGGxmjz1KKRYg
	sXrw221OyI63AxGXWcrmRH12W5QSajmOXMOAgFq/ekXwXffEm05dZHlxC1OzBBpx7gAzgpYC+3A
	d8JfYBMueYcy9xpmg9Ku/gVDAWdc=
X-Google-Smtp-Source: AGHT+IEJP8QGOItM850E27tydwcMalB9hMJh/OS9t6heAh1WhVncI0cOhtCRYxqcTUeU80RSoRnypf3a1D3RfzbRd0g=
X-Received: by 2002:a05:6808:1209:b0:3bf:db98:8674 with SMTP id
 a9-20020a056808120900b003bfdb988674mr1232360oil.27.1707540090010; Fri, 09 Feb
 2024 20:41:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201001504.1348511-1-irogers@google.com> <20240201001504.1348511-7-irogers@google.com>
In-Reply-To: <20240201001504.1348511-7-irogers@google.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Fri, 9 Feb 2024 20:41:18 -0800
Message-ID: <CAM9d7ciaKQadAZJt1431iqZsvAvk9HrCgLp1mLpNwabQ4=_8tg@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] perf tests: Run time generate shell test suites
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, James Clark <james.clark@arm.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 4:15=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> Rather than special shell test logic, do a single pass to create an
> array of test suites. Hold the shell test file name in the test suite
> priv field. This makes the special shell test logic in builtin-test.c
> redundant so remove it.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/builtin-test.c  |  91 +----------------------
>  tools/perf/tests/tests-scripts.c | 120 ++++++++++++++++++-------------
>  tools/perf/tests/tests-scripts.h |  10 +--
>  3 files changed, 74 insertions(+), 147 deletions(-)
>
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-t=
est.c
> index 6d5001daaf63..c42cb40fc242 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -130,6 +130,7 @@ static struct test_suite *generic_tests[] =3D {
>  static struct test_suite **tests[] =3D {
>         generic_tests,
>         arch_tests,
> +       NULL, /* shell tests created at runtime. */
>  };
>
>  static struct test_workload *workloads[] =3D {
> @@ -299,74 +300,12 @@ static int test_and_print(struct test_suite *t, int=
 subtest)
>         return err;
>  }
>
> -struct shell_test {
> -       const char *file;
> -};
> -
> -static int shell_test__run(struct test_suite *test, int subdir __maybe_u=
nused)
> -{
> -       int err;
> -       struct shell_test *st =3D test->priv;
> -       char *cmd;
> -
> -       asprintf(&cmd, "%s%s", st->file, verbose ? " -v" : "");
> -       if (!cmd)
> -               return TEST_FAIL;
> -       err =3D system(cmd);
> -       free(cmd);
> -       if (!err)
> -               return TEST_OK;
> -
> -       return WEXITSTATUS(err) =3D=3D 2 ? TEST_SKIP : TEST_FAIL;
> -}
> -
> -static int run_shell_tests(int argc, const char *argv[], int i, int widt=
h,
> -                               struct intlist *skiplist)
> -{
> -       struct shell_test st;
> -       const struct script_file *files, *file;
> -
> -       files =3D list_script_files();
> -       if (!files)
> -               return 0;
> -       for (file =3D files; file->file; file++) {
> -               int curr =3D i++;
> -               struct test_case test_cases[] =3D {
> -                       {
> -                               .desc =3D file->desc,
> -                               .run_case =3D shell_test__run,
> -                       },
> -                       { .name =3D NULL, }
> -               };
> -               struct test_suite test_suite =3D {
> -                       .desc =3D test_cases[0].desc,
> -                       .test_cases =3D test_cases,
> -                       .priv =3D &st,
> -               };
> -               st.file =3D file->file;
> -
> -               if (test_suite.desc =3D=3D NULL ||
> -                   !perf_test__matches(test_suite.desc, curr, argc, argv=
))
> -                       continue;
> -
> -               pr_info("%3d: %-*s:", i, width, test_suite.desc);
> -
> -               if (intlist__find(skiplist, i)) {
> -                       color_fprintf(stderr, PERF_COLOR_YELLOW, " Skip (=
user override)\n");
> -                       continue;
> -               }
> -
> -               test_and_print(&test_suite, 0);
> -       }
> -       return 0;
> -}
> -
>  static int __cmd_test(int argc, const char *argv[], struct intlist *skip=
list)
>  {
>         struct test_suite *t;
>         unsigned int j, k;
>         int i =3D 0;
> -       int width =3D list_script_max_width();
> +       int width =3D 0;
>
>         for_each_test(j, k, t) {
>                 int len =3D strlen(test_description(t, -1));
> @@ -441,28 +380,6 @@ static int __cmd_test(int argc, const char *argv[], =
struct intlist *skiplist)
>                         }
>                 }
>         }
> -
> -       return run_shell_tests(argc, argv, i, width, skiplist);
> -}
> -
> -static int perf_test__list_shell(int argc, const char **argv, int i)
> -{
> -       const struct script_file *files, *file;
> -
> -       files =3D list_script_files();
> -       if (!files)
> -               return 0;
> -       for (file =3D files; file->file; file++) {
> -               int curr =3D i++;
> -               struct test_suite t =3D {
> -                       .desc =3D file->desc
> -               };
> -
> -               if (!perf_test__matches(t.desc, curr, argc, argv))
> -                       continue;
> -
> -               pr_info("%3d: %s\n", i, t.desc);
> -       }
>         return 0;
>  }
>
> @@ -489,9 +406,6 @@ static int perf_test__list(int argc, const char **arg=
v)
>                                         test_description(t, subi));
>                 }
>         }
> -
> -       perf_test__list_shell(argc, argv, i);
> -
>         return 0;
>  }
>
> @@ -551,6 +465,7 @@ int cmd_test(int argc, const char **argv)
>         /* Unbuffered output */
>         setvbuf(stdout, NULL, _IONBF, 0);
>
> +       tests[2] =3D create_script_test_suites();

I like this part! :)


>         argc =3D parse_options_subcommand(argc, argv, test_options, test_=
subcommands, test_usage, 0);
>         if (argc >=3D 1 && !strcmp(argv[0], "list"))
>                 return perf_test__list(argc - 1, argv + 1);
> diff --git a/tools/perf/tests/tests-scripts.c b/tools/perf/tests/tests-sc=
ripts.c
> index 9b3b66dd5508..b92a93c251c6 100644
> --- a/tools/perf/tests/tests-scripts.c
> +++ b/tools/perf/tests/tests-scripts.c
> @@ -26,16 +26,6 @@
>  #include "tests.h"
>  #include "util/rlimit.h"
>
> -
> -/*
> - * As this is a singleton built once for the run of the process, there i=
s
> - * no value in trying to free it and just let it stay around until proce=
ss
> - * exits when it's cleaned up.
> - */
> -static size_t files_num =3D 0;
> -static struct script_file *files =3D NULL;
> -static int files_max_width =3D 0;
> -
>  static int shell_tests__dir_fd(void)
>  {
>         char path[PATH_MAX], *exec_path;
> @@ -131,12 +121,31 @@ static char *strdup_check(const char *str)
>         return newstr;
>  }
>
> -static void append_script(int dir_fd, const char *name, char *desc)
> +static int shell_test__run(struct test_suite *test, int subtest __maybe_=
unused)
> +{
> +       const char *file =3D test->priv;
> +       int err;
> +       char *cmd;
> +
> +       asprintf(&cmd, "%s%s", file, verbose ? " -v" : "");
> +       if (!cmd)
> +               return TEST_FAIL;
> +       err =3D system(cmd);
> +       free(cmd);
> +       if (!err)
> +               return TEST_OK;
> +
> +       return WEXITSTATUS(err) =3D=3D 2 ? TEST_SKIP : TEST_FAIL;
> +}
> +
> +static void append_script(int dir_fd, const char *name, char *desc,
> +                         struct test_suite ***result,
> +                         size_t *result_sz)
>  {
>         char filename[PATH_MAX], link[128];
> -       struct script_file *files_tmp;
> -       size_t files_num_tmp, len;
> -       int width;
> +       struct test_suite *test_suite, **result_tmp;
> +       struct test_case *tests;
> +       size_t len;
>
>         snprintf(link, sizeof(link), "/proc/%d/fd/%d", getpid(), dir_fd);
>         len =3D readlink(link, filename, sizeof(filename));
> @@ -146,33 +155,43 @@ static void append_script(int dir_fd, const char *n=
ame, char *desc)
>         }
>         filename[len++] =3D '/';
>         strcpy(&filename[len], name);
> -       files_num_tmp =3D files_num + 1;
> -       if (files_num_tmp >=3D SIZE_MAX) {
> -               pr_err("Too many script files\n");
> -               abort();
> +
> +       tests =3D calloc(2, sizeof(*tests));
> +       if (!tests) {
> +               pr_err("Out of memory while building script test suite li=
st\n");
> +               return;
> +       }
> +       tests[0].name =3D strdup_check(name);
> +       tests[0].desc =3D strdup_check(desc);
> +       tests[0].run_case =3D shell_test__run;
> +
> +       test_suite =3D zalloc(sizeof(*test_suite));
> +       if (!test_suite) {
> +               pr_err("Out of memory while building script test suite li=
st\n");
> +               free(tests);
> +               return;
>         }
> +       test_suite->desc =3D desc;
> +       test_suite->test_cases =3D tests;
> +       test_suite->priv =3D strdup_check(filename);
>         /* Realloc is good enough, though we could realloc by chunks, not=
 that
>          * anyone will ever measure performance here */
> -       files_tmp =3D realloc(files,
> -                           (files_num_tmp + 1) * sizeof(struct script_fi=
le));
> -       if (files_tmp =3D=3D NULL) {
> -               pr_err("Out of memory while building test list\n");
> -               abort();
> +       result_tmp =3D realloc(*result, (*result_sz + 1) * sizeof(*result=
_tmp));
> +       if (result_tmp =3D=3D NULL) {
> +               pr_err("Out of memory while building script test suite li=
st\n");
> +               free(tests);
> +               free(test_suite);
> +               return;
>         }
>         /* Add file to end and NULL terminate the struct array */
> -       files =3D files_tmp;
> -       files_num =3D files_num_tmp;
> -       files[files_num - 1].file =3D strdup_check(filename);
> -       files[files_num - 1].desc =3D desc;
> -       files[files_num].file =3D NULL;
> -       files[files_num].desc =3D NULL;
> -
> -       width =3D strlen(desc); /* Track max width of desc */
> -       if (width > files_max_width)
> -               files_max_width =3D width;
> +       *result =3D result_tmp;
> +       (*result)[*result_sz] =3D test_suite;
> +       (*result_sz)++;
>  }
>
> -static void append_scripts_in_dir(int dir_fd)
> +static void append_scripts_in_dir(int dir_fd,
> +                                 struct test_suite ***result,
> +                                 size_t *result_sz)
>  {
>         struct dirent **entlist;
>         struct dirent *ent;
> @@ -191,7 +210,7 @@ static void append_scripts_in_dir(int dir_fd)
>                         char *desc =3D shell_test__description(dir_fd, en=
t->d_name);
>
>                         if (desc) /* It has a desc line - valid script */
> -                               append_script(dir_fd, ent->d_name, desc);
> +                               append_script(dir_fd, ent->d_name, desc, =
result, result_sz);
>                         continue;
>                 }
>                 if (ent->d_type !=3D DT_DIR) {
> @@ -204,32 +223,31 @@ static void append_scripts_in_dir(int dir_fd)
>                                 continue;
>                 }
>                 fd =3D openat(dir_fd, ent->d_name, O_PATH);
> -               append_scripts_in_dir(fd);
> +               append_scripts_in_dir(fd, result, result_sz);
>         }
>         for (i =3D 0; i < n_dirs; i++) /* Clean up */
>                 zfree(&entlist[i]);
>         free(entlist);
>  }
>
> -const struct script_file *list_script_files(void)
> +struct test_suite **create_script_test_suites(void)
>  {
> -       int dir_fd;
> -
> -       if (files)
> -               return files; /* Singleton - we already know our list */
> +       struct test_suite **result =3D NULL, **result_tmp;
> +       size_t result_sz =3D 0;
> +       int dir_fd =3D shell_tests__dir_fd(); /* Walk  dir */
>
> -       dir_fd =3D shell_tests__dir_fd(); /* Walk  dir */
>         if (dir_fd < 0)
>                 return NULL;

When can it fail?  If the test directory doesn't exist?
I'm afraid returning NULL here can crash perf test.
I think you need to return a NULL entry result.

Thanks,
Namhyung


>
> -       append_scripts_in_dir(dir_fd);
> +       append_scripts_in_dir(dir_fd, &result, &result_sz);
> +       result_tmp =3D realloc(result, (result_sz + 1) * sizeof(*result_t=
mp));
> +       if (result_tmp =3D=3D NULL) {
> +               pr_err("Out of memory while building script test suite li=
st\n");
> +               abort();
> +       }
> +       /* NULL terminate the test suite array. */
> +       result =3D result_tmp;
> +       result[result_sz] =3D NULL;
>         close(dir_fd);
> -
> -       return files;
> -}
> -
> -int list_script_max_width(void)
> -{
> -       list_script_files(); /* Ensure we have scanned all scripts */
> -       return files_max_width;
> +       return result;
>  }
> diff --git a/tools/perf/tests/tests-scripts.h b/tools/perf/tests/tests-sc=
ripts.h
> index 3508a293aaf9..b553ad26ea17 100644
> --- a/tools/perf/tests/tests-scripts.h
> +++ b/tools/perf/tests/tests-scripts.h
> @@ -2,14 +2,8 @@
>  #ifndef TESTS_SCRIPTS_H
>  #define TESTS_SCRIPTS_H
>
> -struct script_file {
> -       char *file;
> -       char *desc;
> -};
> +#include "tests.h"
>
> -/* List available script tests to run - singleton - never freed */
> -const struct script_file *list_script_files(void);
> -/* Get maximum width of description string */
> -int list_script_max_width(void);
> +struct test_suite **create_script_test_suites(void);
>
>  #endif /* TESTS_SCRIPTS_H */
> --
> 2.43.0.429.g432eaa2c6b-goog
>

