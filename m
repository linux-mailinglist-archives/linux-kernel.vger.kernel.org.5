Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2ED17904C6
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 04:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351488AbjIBCsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 22:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIBCsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 22:48:36 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E053E56
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 19:48:32 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-34df0f0a5beso70075ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 19:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693622912; x=1694227712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i+PVC4TdwVkm8AP4e8BXKrAf47SO8JyU0sMgMGE0Dyw=;
        b=iz40QPgf/fRu4B0QdJcSpImBokjTj850LBPESUwDDmDE8cujw++gJsyCwFB5D/lf5m
         N3g8o5Pcic38C2hJfhhfLikXklgIQ+Mi/I7CdkWBEzP1Vm99NGXPQehQbEOi6BVohwqZ
         /zckbOoVYuhekJff41P7iaDK/F5VQ5xHV37Y7jlxD7vs1bq7NIwLHQzeoqjG4ascWOyk
         eWZ5giL0R/JW2Aw0q+b11RqHsCcXuAiWCDnUwx8GhxWDyVSLH/O/AhzxlhyhMT5J9nt7
         NOQS17Cc1IKDCxkxIK6hnya/GrzbEd2NsRBl4RmDu6u7as5GkehgDkvpW2hZW47Nn/2G
         V13g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693622912; x=1694227712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i+PVC4TdwVkm8AP4e8BXKrAf47SO8JyU0sMgMGE0Dyw=;
        b=NctkN65tgD1sdGcW7MJ3sB/++qRw6iT4w3bNUgY8LItWRpLZuKYqAY/8VsePTE2YOr
         IsF+VWUz0jGf1UCK8st9uJEG6ZKeofcfz01KbP+vYWgtuA/Wrv6gmGy3a/qNk6BfYv8i
         80Mu04ITrNLiIFDmH9nF1GWGqOJtk1cy3oaIt4KTOSGhnDFpi9Dvnbzn0E3D37zf2Mri
         7+onAjrPidLvOeOK4wZOV3p2HLruo4fkdKcn1ymKMQeIOZ7mjz6zbX410gMbCdAo/ed5
         sZ3EZp4zFY6MgD2LonPicHj2IJ+Swm1LD56CrWpq1pXamBEjcnhc2ZrGcQMwaROXnKCj
         Jbpw==
X-Gm-Message-State: AOJu0YxO5b6g2rCufrHwxI2L9BM6Ri9xkuRlYHnhm7K64FRyTazSdyYN
        tzRantC6OWrGs35p8umFgwIe6X9CsBynbcqzXancCw==
X-Google-Smtp-Source: AGHT+IGJHA+cZwK3IAkvT9gBDKcTMZCAyNaL2eE8iJBA4QIGsP+riy1NLUxxIziotpT66j5xxCFwfpjgqLUNB57DYZc=
X-Received: by 2002:a05:6e02:1846:b0:34c:cc37:3060 with SMTP id
 b6-20020a056e02184600b0034ccc373060mr86229ilv.18.1693622911606; Fri, 01 Sep
 2023 19:48:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230831151632.124985-1-james.clark@arm.com> <20230831151632.124985-4-james.clark@arm.com>
In-Reply-To: <20230831151632.124985-4-james.clark@arm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 1 Sep 2023 19:48:18 -0700
Message-ID: <CAP-5=fULssmTy+=TPOHPtRu9iX4Da8S6QYtSbn=gP+3LCOxS3Q@mail.gmail.com>
Subject: Re: [PATCH 3/7] perf util: Add a function for replacing characters in
 a string
To:     James Clark <james.clark@arm.com>
Cc:     linux-perf-users@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Haixin Yu <yuhaixin.yhx@linux.alibaba.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 8:17=E2=80=AFAM James Clark <james.clark@arm.com> w=
rote:
>
> It finds all occurrences of a single character and replaces them with
> a multi character string. This will be used in a test in a following
> commit.
>
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  tools/perf/tests/Build          |  1 +
>  tools/perf/tests/builtin-test.c |  1 +
>  tools/perf/tests/tests.h        |  1 +
>  tools/perf/tests/util.c         | 30 +++++++++++++++++++++
>  tools/perf/util/string.c        | 48 +++++++++++++++++++++++++++++++++
>  tools/perf/util/string2.h       |  1 +
>  6 files changed, 82 insertions(+)
>  create mode 100644 tools/perf/tests/util.c
>
> diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
> index 63d5e6d5f165..2b45ffa462a6 100644
> --- a/tools/perf/tests/Build
> +++ b/tools/perf/tests/Build
> @@ -66,6 +66,7 @@ perf-y +=3D dlfilter-test.o
>  perf-y +=3D sigtrap.o
>  perf-y +=3D event_groups.o
>  perf-y +=3D symbols.o
> +perf-y +=3D util.o
>
>  ifeq ($(SRCARCH),$(filter $(SRCARCH),x86 arm arm64 powerpc))
>  perf-$(CONFIG_DWARF_UNWIND) +=3D dwarf-unwind.o
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-t=
est.c
> index 0ad18cf6dd22..cb6f1dd00dc4 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -123,6 +123,7 @@ static struct test_suite *generic_tests[] =3D {
>         &suite__sigtrap,
>         &suite__event_groups,
>         &suite__symbols,
> +       &suite__util,
>         NULL,
>  };
>
> diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
> index f33cfc3c19a4..b394f3ac2d66 100644
> --- a/tools/perf/tests/tests.h
> +++ b/tools/perf/tests/tests.h
> @@ -145,6 +145,7 @@ DECLARE_SUITE(dlfilter);
>  DECLARE_SUITE(sigtrap);
>  DECLARE_SUITE(event_groups);
>  DECLARE_SUITE(symbols);
> +DECLARE_SUITE(util);
>
>  /*
>   * PowerPC and S390 do not support creation of instruction breakpoints u=
sing the
> diff --git a/tools/perf/tests/util.c b/tools/perf/tests/util.c
> new file mode 100644
> index 000000000000..43e66a620b83
> --- /dev/null
> +++ b/tools/perf/tests/util.c
> @@ -0,0 +1,30 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "tests.h"
> +#include "util/debug.h"
> +
> +#include <linux/compiler.h>
> +#include <stdlib.h>
> +#include <string2.h>
> +
> +static int test_strreplace(char find, const char *s, const char *replace=
, const char *expected)
> +{
> +       char *new =3D strreplace_chars(find, s, replace);
> +       int ret =3D strcmp(new, expected);
> +
> +       free(new);
> +       return ret =3D=3D 0;
> +}
> +
> +static int test__util(struct test_suite *t __maybe_unused, int subtest _=
_maybe_unused)
> +{
> +       TEST_ASSERT_VAL("empty string", test_strreplace(' ', "", "123", "=
"));
> +       TEST_ASSERT_VAL("no match", test_strreplace('5', "123", "4", "123=
"));
> +       TEST_ASSERT_VAL("replace 1", test_strreplace('3', "123", "4", "12=
4"));
> +       TEST_ASSERT_VAL("replace 2", test_strreplace('a', "abcabc", "ef",=
 "efbcefbc"));
> +       TEST_ASSERT_VAL("replace long", test_strreplace('a', "abcabc", "l=
onglong",
> +                                                       "longlongbclonglo=
ngbc"));
> +
> +       return 0;
> +}
> +
> +DEFINE_SUITE("util", util);
> diff --git a/tools/perf/util/string.c b/tools/perf/util/string.c
> index cf05b0b56c57..6410a683183e 100644
> --- a/tools/perf/util/string.c
> +++ b/tools/perf/util/string.c
> @@ -301,3 +301,51 @@ unsigned int hex(char c)
>                 return c - 'a' + 10;
>         return c - 'A' + 10;
>  }
> +
> +
> +/*
> + * Replace all occurrences of character 'find' in string s with string '=
replace'
> + *
> + * The new string could be longer so a new string is returned which must
> + * be freed.
> + */

Fwiw, I quite like the "man strstr" parameter convention of calling
"find" as "needle" and "s" as haystack.

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> +char *strreplace_chars(char find, const char *s, const char *replace)
> +{
> +       int replace_len =3D strlen(replace);
> +       char *new_s, *to;
> +       const char *loc =3D strchr(s, find);
> +       const char *from =3D s;
> +       int num =3D 0;
> +
> +       /* Count occurrences */
> +       while (loc) {
> +               loc =3D strchr(loc + 1, find);
> +               num++;
> +       }
> +
> +       /* Allocate enough space for replacements and reset first locatio=
n */
> +       new_s =3D malloc(strlen(s) + (num * (replace_len - 1) + 1));
> +       if (!new_s)
> +               return NULL;
> +       loc =3D strchr(s, find);
> +       to =3D new_s;
> +
> +       while (loc) {
> +               /* Copy original string up to found char and update posit=
ions */
> +               memcpy(to, from, 1 + loc - from);
> +               to +=3D loc - from;
> +               from =3D loc + 1;
> +
> +               /* Copy replacement string and update positions */
> +               memcpy(to, replace, replace_len);
> +               to +=3D replace_len;
> +
> +               /* Find next occurrence or end of string */
> +               loc =3D strchr(from, find);
> +       }
> +
> +       /* Copy any remaining chars + null */
> +       strcpy(to, from);
> +
> +       return new_s;
> +}
> diff --git a/tools/perf/util/string2.h b/tools/perf/util/string2.h
> index 56c30fef9682..920488099214 100644
> --- a/tools/perf/util/string2.h
> +++ b/tools/perf/util/string2.h
> @@ -39,5 +39,6 @@ char *strpbrk_esc(char *str, const char *stopset);
>  char *strdup_esc(const char *str);
>
>  unsigned int hex(char c);
> +char *strreplace_chars(char find, const char *s, const char *replace);
>
>  #endif /* PERF_STRING_H */
> --
> 2.34.1
>
