Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 800417904C9
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 04:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351495AbjIBCxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 22:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIBCxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 22:53:31 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACCB310FE
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 19:53:23 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-4036bd4fff1so158751cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 19:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693623203; x=1694228003; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NzkOnQtKNGiM1YTWs4J/M9/KYVJbjv//nRJ8yNZOh/k=;
        b=yFsV5OgSVT8r41ixeyIYPoB3qxi5t3E+mIQfQp+wZDtIgxJ0VHnhg+3mKsofJkSviU
         GxhG+llIMQsy4m2eHlfeveycHZcCUrpzV3ATywvXmePsVPyS4gaf1dJ6rZoW6kdnT8PO
         iHW9L4kVtJ06Eeb7flFfnHpH8BqNmZB+jQB0xc86wGNGncxKzuZyqXurZFKQzfXamvA5
         zbmin6Kwth8P4EqwH6EKO/kys7mcO8EAPYRuMdkkzf4HkNoKH6AVunF1Zq+3d80OzMLY
         7oLvVQR4j2NH6/fIZD5DMFkLf0KKmmPg7QvuuYNurH1O3S68RWdkBbeO/QGgu6uEhckw
         dOGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693623203; x=1694228003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NzkOnQtKNGiM1YTWs4J/M9/KYVJbjv//nRJ8yNZOh/k=;
        b=CdkdOHr0xVk8TDnR4L9QOgEj9Pk3WvGioy6g4RgsA6aer9cpGzpiXkzR3u5kfI4xul
         6Pt8V/88O0IthMv5CROriIgBN6FgrmtwUyfseEGxw1Z176v7Aqm4jnd9YpRDqMYh4UYb
         jvAMBNz3luCYwOjOWgj2SEoX1ZPHfoKofa8boXy8ECyVPAV75LTwmExdEO4vQcbZRzxs
         TZEAnymM6jj6wyS9dqDYj3Jg650A8zniSVvLFMjiwbs6KOMnh7Yy+IK251E434hk2kgv
         OR/GvST7rkobVjAhk4NqFyMNbhN2hcNQjc1rQNOnvX3khPspMJ82XuVAcuAPcBf6Ddtj
         u3IQ==
X-Gm-Message-State: AOJu0Yz/6/Zl/tYu1NsK+m5eYCHaptY5MI85ahudLkxswCshksGeBU1T
        72kWddpbE2Gb2CWhqiqxcoIkgN1PkDCY+4DoO6hhqg==
X-Google-Smtp-Source: AGHT+IGDve+ej3TXXzQ0XpRkzxdbaZeG1kLo8i8+uBgAiipGByMizS26AACkgSjE9MWkAgtylHLhBK9OAjb2L/IUrkk=
X-Received: by 2002:ac8:5bc5:0:b0:3ef:5f97:258f with SMTP id
 b5-20020ac85bc5000000b003ef5f97258fmr116238qtb.16.1693623202605; Fri, 01 Sep
 2023 19:53:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230831151632.124985-1-james.clark@arm.com>
In-Reply-To: <20230831151632.124985-1-james.clark@arm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 1 Sep 2023 19:53:10 -0700
Message-ID: <CAP-5=fVrF34FYUZ=vKHPVUbkTiCTBnmQuZVyeS2JWGBjS_eerw@mail.gmail.com>
Subject: Re: [PATCH 0/7] perf: strcmp_cpuid_str() expression fixups
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
        Haixin Yu <yuhaixin.yhx@linux.alibaba.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 8:16=E2=80=AFAM James Clark <james.clark@arm.com> w=
rote:
>
> Set of fixes related to the comments here [1]. Mainly cleanups,
> additional tests and refactoring since adding the new strcmp_cpuid_str()
> metric expression.
>
> I added the string replace function to the perf utils
> rather than tools/lib/string.c because it didn't seem
> easy to add tests for tools/lib.
>
> [1]: https://lore.kernel.org/linux-arm-kernel/CAP-5=3DfVnUx0BnJC7X1rrm42O=
D7Bk=3DZsHWNwAZMBYyB7yWhBfhQ@mail.gmail.com/
>
> James Clark (7):
>   perf test: Check result of has_event(cycles) test
>   perf jevents: Remove unused keyword
>   perf util: Add a function for replacing characters in a string
>   perf test: Add a test for strcmp_cpuid_str() expression
>   perf pmu: Move pmu__find_core_pmu() to pmus.c
>   perf pmus: Simplify perf_pmus__find_core_pmu()
>   perf pmu: Remove unused function

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

>  tools/perf/arch/arm64/util/pmu.c | 20 ++++++-------
>  tools/perf/pmu-events/metric.py  |  3 +-
>  tools/perf/tests/Build           |  1 +
>  tools/perf/tests/builtin-test.c  |  1 +
>  tools/perf/tests/expr.c          | 33 ++++++++++++++++++----
>  tools/perf/tests/tests.h         |  1 +
>  tools/perf/tests/util.c          | 30 ++++++++++++++++++++
>  tools/perf/util/expr.c           |  2 +-
>  tools/perf/util/pmu.c            | 22 ---------------
>  tools/perf/util/pmu.h            |  3 +-
>  tools/perf/util/pmus.c           |  6 ++++
>  tools/perf/util/string.c         | 48 ++++++++++++++++++++++++++++++++
>  tools/perf/util/string2.h        |  1 +
>  13 files changed, 127 insertions(+), 44 deletions(-)
>  create mode 100644 tools/perf/tests/util.c
>
> --
> 2.34.1
>
