Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF8B788CDD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 17:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238859AbjHYP5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 11:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237331AbjHYP47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 11:56:59 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A11E02134
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 08:56:56 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-40c72caec5cso317531cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 08:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692979016; x=1693583816; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f1dAiH5GroxRPQDayYuzzRlNNflrHbuT0xIRa5ImgrI=;
        b=qC0rhWTNcr4ynYhixWygcQrUaKtsa7NwY5OpCerbuyD5vAoBeLTl6K+65SpD3VleVL
         cW8MZK9mtkrXZBHAy3yL4voFmH92nA1sO6hQWtrTT2zFE5V2V1a5bd7H3pWzwQr2EiOB
         qVvuPOvdO7P2giv6RpcFwlBB4sTHkqQ5tsj0inOcL9Dqd89egmIKgc/vLNwQ/EF4Zb/l
         ImIHVYdRP9WMvkFbwZit17ry3r4SxI9kyICDOxLJZi/6ItvJdBA8k3obZ9onQv5WY12u
         VNhTJbN8LyJTqv4RRFeRFD1MDcEnHXiq1QLP/q9UiyQCyICNfXoU+xQ8WZoGxQEQDRkV
         NBkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692979016; x=1693583816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f1dAiH5GroxRPQDayYuzzRlNNflrHbuT0xIRa5ImgrI=;
        b=BWUIi4vc8EcCLnRkNEklI+QnTh30qiYyv/rtEqcmr8eloJwM067LqIc4of1dEa24l8
         mzSxkkYpbmLMR5vUVMv0GR7rwULPPfvV6ljTkWv4GTkIr+61R3Kc0nypHRnOgcML4gy6
         mTJNJwp74aGdrRsFaL/LBBcPxfdj9+mDwTcyi54ZitmWaJBnLB7NPS3PsWjsxbC51Otx
         Gy9Vrl3cUMHtWfykZ/S4L1rTUtMcgwXNvBs+hauAQzK5NHRmMvLAlnohoiv3x5HlFaTn
         j0aD54XiaBqZGl1ZesmchovtqmXAlQHPm7yW3eRZ0DcTAG19Q9d9lfWA7aC9BIjWhHcB
         TNCw==
X-Gm-Message-State: AOJu0Yw4l8Tv+iWGpVs2hQNAbRqqFVHZsUQcEhuZhkYoL9dAj+75ESw3
        neZrueAHcPozf2bm1T54G9iFOxkrTFAVjK7tHVjSrQ==
X-Google-Smtp-Source: AGHT+IEqk0e4YMZ4a3MugEUIM7w9AotH/4rn0Djx7VAVkDRgfUmxfQRvFpNhz+EtdM0QXfuIIQstxhjB6U3Y+2pki4w=
X-Received: by 2002:a05:622a:1705:b0:410:9855:acd with SMTP id
 h5-20020a05622a170500b0041098550acdmr295456qtk.14.1692979015582; Fri, 25 Aug
 2023 08:56:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230825135237.921058-1-irogers@google.com> <20230825135237.921058-2-irogers@google.com>
 <ZOi/KDRRrnkvJmkB@kernel.org> <ZOjABa9ZfQgra/UX@kernel.org>
In-Reply-To: <ZOjABa9ZfQgra/UX@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 25 Aug 2023 08:56:44 -0700
Message-ID: <CAP-5=fVw3heenOh8+JhjNy6Z__p16mv6Z_RiaqYOgjqSrfRKuQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] perf pmus: Sort pmus by name then suffix
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.g.garry@oracle.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Fri, Aug 25, 2023 at 7:51=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Fri, Aug 25, 2023 at 11:48:08AM -0300, Arnaldo Carvalho de Melo escrev=
eu:
> > Em Fri, Aug 25, 2023 at 06:52:36AM -0700, Ian Rogers escreveu:
> > > Sort PMUs by name. If two PMUs have the same name but differ by
> > > suffix, sort the suffixes numerically. For example, "breakpoint" come=
s
> > > before "cpu", "uncore_imc_free_running_0" comes before
> > > "uncore_imc_free_running_1". Suffixes need to be treated specially as
> > > otherwise they will be ordered like 0, 1, 10, 11, .., 2, 20, 21, ..,
> > > etc. Only PMUs starting 'uncore_' are considered to have a potential
> > > suffix.
> > >
> > > Sorting of PMUs is done so that later patches can skip duplicate
> > > uncore PMUs that differ only by there suffix.
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/perf/util/pmus.c | 48 ++++++++++++++++++++++++++++++++++++++++=
++
> > >  1 file changed, 48 insertions(+)
> > >
> > > diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
> > > index 4dd5912617ff..b1f6a64693fe 100644
> > > --- a/tools/perf/util/pmus.c
> > > +++ b/tools/perf/util/pmus.c
> > > @@ -1,8 +1,10 @@
> > >  // SPDX-License-Identifier: GPL-2.0
> > >  #include <linux/list.h>
> > > +#include <linux/list_sort.h>
> > >  #include <linux/zalloc.h>
> > >  #include <subcmd/pager.h>
> > >  #include <sys/types.h>
> > > +#include <ctype.h>
> > >  #include <dirent.h>
> > >  #include <pthread.h>
> > >  #include <string.h>
> > > @@ -33,6 +35,31 @@ static LIST_HEAD(other_pmus);
> > >  static bool read_sysfs_core_pmus;
> > >  static bool read_sysfs_all_pmus;
> > >
> > > +static int pmu_name_len_no_suffix(const char *str, unsigned long *nu=
m)
> > > +{
> > > +   int orig_len, len;
> > > +
> > > +   orig_len =3D len =3D strlen(str);
> > > +
> > > +   /* Non-uncore PMUs have their full length, for example, i915. */
> > > +   if (strncmp(str, "uncore_", 7))
> > > +           return len;
> >
> > I applied the patch, but we have strstarts() for this case, to avoid
> > having to count the size of the prefix in tools/include/linux/string.h,
> > that we copied from the kernel sources:
> >
> > /**
> >  * strstarts - does @str start with @prefix?
> >  * @str: string to examine
> >  * @prefix: prefix to look for.
> >  */
> > static inline bool strstarts(const char *str, const char *prefix)
> > {
> >         return strncmp(str, prefix, strlen(prefix)) =3D=3D 0;
> > }
> >
> > I'll change it, ok?

Makes sense to me. We also do this same strncmp here:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/parse-events.y?h=3Dperf-tools-next#n315
So perhaps do a follow up patch cleaning up all instances of the not
use of strstarts.

Thanks,
Ian

> This:
>
> diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
> index b1f6a64693fe0d49..bbf84ccc3aba7d5c 100644
> --- a/tools/perf/util/pmus.c
> +++ b/tools/perf/util/pmus.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <linux/list.h>
>  #include <linux/list_sort.h>
> +#include <linux/string.h>
>  #include <linux/zalloc.h>
>  #include <subcmd/pager.h>
>  #include <sys/types.h>
> @@ -42,7 +43,7 @@ static int pmu_name_len_no_suffix(const char *str, unsi=
gned long *num)
>         orig_len =3D len =3D strlen(str);
>
>         /* Non-uncore PMUs have their full length, for example, i915. */
> -       if (strncmp(str, "uncore_", 7))
> +       if (!strstarts(str, "uncore_"))
>                 return len;
>
>         /*
