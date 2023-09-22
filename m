Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDB4F7AB443
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 16:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbjIVO65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 10:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbjIVO6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 10:58:55 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C5BCE
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 07:58:49 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-414ba610766so392601cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 07:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695394728; x=1695999528; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zgDKgKLNOq5UPjSMrvVQpqlAFLCGyJRKW8sSQYfce5A=;
        b=KW1foPL4LoxlqJ4kP58yEZ52r9JbHSW+br9xWL0P8bA3pyaY6C24K54rDUa4hN0kQ1
         ifS3cPIxFkufgO4KP3Y9qj7Dzsy1DQl1JLeu3skymEQY35VW49riqe2mpxQmqmcm/yTg
         UWZe/29O6v1OO8NsnSA+YPpxG+qIObk1Q2SNhUVNmUpFThrUVippYPqmpfC1rJjtRF+a
         nzL21JcnODfpBreHCInR6BYywqOmcs5dJ5tFCL2lX1nNiL/WfGhkIY/gB/MdZ1u7ytIG
         6BYU8+DRHNP/f1vFdA1lT+y7LK4uuilQOg+5PrIvWCLk2W0f9+lHiNP+mjQnw4x8RKs6
         XN1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695394728; x=1695999528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zgDKgKLNOq5UPjSMrvVQpqlAFLCGyJRKW8sSQYfce5A=;
        b=F5yI55/uTjaNyVEfqJdrlYaNBRXDJDdfKsI/4MPh/OFXQLraRY69vm7aj8xJL4u7DR
         hcsMSfLowC0q+cl19mPAdwD6vewA1kgbM4nxlNfpSpNZODBZKbHyQwuogL7p+DgWw2I2
         ZbX01MCz1tDUgFM9qAHIS0EvuRIHVEwFzvYUSGDfCHarpRxh4UlmuKRLwtPIlFwMInA0
         4EqvdBzy99t1SJ7pyA6QdW+uDpB1fUSpxbc5eTl8VNShjD/EDaUz/Xx/gK3UR9VKXywR
         N8gSZ4jO3RX8M2a5Ha0zgCiTWtBw8jh3Hh3WW4KdRHtIJzbdVPZ64H7fjJIhrRtKQ5vS
         YVPQ==
X-Gm-Message-State: AOJu0Yx9KBW95y1uSWLMu0Xy8oEIaIsu6nTH6l7Q0TYs9FTga7ziqlnq
        VN/Fxg7WeenrnAhmybF5xvfcHTWjNDZh8ggxpjyv7A==
X-Google-Smtp-Source: AGHT+IESNWFRg+y2TuWvd89RoJ6GBBUMt3OgVqWMs842fYNtOygOfCHPUJtJDdiPRplbsgSlGB6en+tQOrS+AeANsys=
X-Received: by 2002:a05:622a:1191:b0:403:eeb9:a76 with SMTP id
 m17-20020a05622a119100b00403eeb90a76mr181867qtk.17.1695394728023; Fri, 22 Sep
 2023 07:58:48 -0700 (PDT)
MIME-Version: 1.0
References: <1695037955-107983-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1695037955-107983-2-git-send-email-renyu.zj@linux.alibaba.com>
 <CAP-5=fUxfJT-gxKB+Ls3drUeQ0sy55uydi8Y36gumUnaFSYeqA@mail.gmail.com> <0f5bbe93-1875-ff9b-a1d8-8518a8cf3e84@linux.alibaba.com>
In-Reply-To: <0f5bbe93-1875-ff9b-a1d8-8518a8cf3e84@linux.alibaba.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 22 Sep 2023 07:58:35 -0700
Message-ID: <CAP-5=fW8HSuQ2kZDrMeyhpZbiqagANs=_W+RWNJw21u-UhixrQ@mail.gmail.com>
Subject: Re: [PATCH v9 1/7] perf pmu: "Compat" supports regular expression
 matching identifiers
To:     Jing Zhang <renyu.zj@linux.alibaba.com>
Cc:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
        Zhuo Song <zhuo.song@linux.alibaba.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 1:19=E2=80=AFAM Jing Zhang <renyu.zj@linux.alibaba.=
com> wrote:
>
>
>
> =E5=9C=A8 2023/9/21 =E4=B8=8A=E5=8D=882:36, Ian Rogers =E5=86=99=E9=81=93=
:
> > On Mon, Sep 18, 2023 at 4:52=E2=80=AFAM Jing Zhang <renyu.zj@linux.alib=
aba.com> wrote:
> >>
> >> The jevent "Compat" is used for uncore PMU alias or metric definitions=
.
> >>
> >> The same PMU driver has different PMU identifiers due to different
> >> hardware versions and types, but they may have some common PMU event.
> >> Since a Compat value can only match one identifier, when adding the
> >> same event alias to PMUs with different identifiers, each identifier
> >> needs to be defined once, which is not streamlined enough.
> >>
> >> So let "Compat" support using regular expression to match identifiers
> >> for uncore PMU alias. For example, if the "Compat" value is set to
> >> "43401|43c01", it would be able to match PMU identifiers such as "4340=
1"
> >> or "43c01", which correspond to CMN600_r0p0 or CMN700_r0p0.
> >>
> >> Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
> >> ---
> >>  tools/perf/util/pmu.c | 23 +++++++++++++++++++++--
> >>  tools/perf/util/pmu.h |  1 +
> >>  2 files changed, 22 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> >> index e215985..7e2242f 100644
> >> --- a/tools/perf/util/pmu.c
> >> +++ b/tools/perf/util/pmu.c
> >> @@ -28,6 +28,7 @@
> >>  #include "strbuf.h"
> >>  #include "fncache.h"
> >>  #include "util/evsel_config.h"
> >> +#include <regex.h>
> >>
> >>  struct perf_pmu perf_pmu__fake =3D {
> >>         .name =3D "fake",
> >> @@ -875,6 +876,24 @@ static bool pmu_uncore_alias_match(const char *pm=
u_name, const char *name)
> >>         return res;
> >>  }
> >>
> >> +bool pmu_uncore_identifier_match(const char *compat, const char *id)
> >> +{
> >> +       regex_t re;
> >> +       regmatch_t pmatch[1];
> >> +       int match;
> >> +
> >> +       if (regcomp(&re, compat, REG_EXTENDED) !=3D 0) {
> >> +               /* Warn unable to generate match particular string. */
> >> +               pr_info("Invalid regular expression %s\n", compat);
> >> +               return false;
> >> +       }
> >> +
> >> +       match =3D !regexec(&re, id, 1, pmatch, 0);
> >
> > I wonder if we can make the regular expressions like
> > "^(434|436|43c|43a)" more like "(434|436|43c|43a).*", so that we fully
> > match the id string, by here doing:
> >
> > if (match) {
> >   /* Ensure a full match. */
> >   match =3D pmatch[0].rm_so =3D=3D 0 && pmatch[0].rm_eo =3D=3D strlen(i=
d);
> > }
> >
>
> Ok, will do.
>
>
> > I think longer term we can use jevents.py to generate a pmu-events.l,
> > which would have a contents something like:
> >
> > (434|436|43c|43a).*  { return PMU_....;}
> >
> > That should make the matching faster but may add some restrictions
> > onto the regular expression.
>
> Could you please describe the function of pmu-event.l in more detail? I m=
ay not fully understand it.

So for now there's no need for a pmu-event.l, I'm fine with the code
as-is. The issue for using regular expressions is that we need to
compile (regcomp) then use them (regexec), and in this new code the
result of the parsing is discarded - perhaps we can save on some
compiling with a 1 element cache, let's wait to see performance data
saying it is an issue. If we were to compile the regular expressions
at build time with flex then the runtime cost, any caching, etc. is
unnecessary.

Hope this makes sense. Thanks,
Ian

> Thanks,
> Jing
>
> >
> > Thanks,
> > Ian
> >
> >> +       regfree(&re);
> >> +
> >> +       return match;
> >> +}
> >> +
> >>  static int pmu_add_cpu_aliases_map_callback(const struct pmu_event *p=
e,
> >>                                         const struct pmu_events_table =
*table __maybe_unused,
> >>                                         void *vdata)
> >> @@ -915,8 +934,8 @@ static int pmu_add_sys_aliases_iter_fn(const struc=
t pmu_event *pe,
> >>         if (!pe->compat || !pe->pmu)
> >>                 return 0;
> >>
> >> -       if (!strcmp(pmu->id, pe->compat) &&
> >> -           pmu_uncore_alias_match(pe->pmu, pmu->name)) {
> >> +       if (pmu_uncore_alias_match(pe->pmu, pmu->name) &&
> >> +                       pmu_uncore_identifier_match(pe->compat, pmu->i=
d)) {
> >>                 perf_pmu__new_alias(pmu,
> >>                                 pe->name,
> >>                                 pe->desc,
> >> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> >> index bd5d804..fc155ce 100644
> >> --- a/tools/perf/util/pmu.h
> >> +++ b/tools/perf/util/pmu.h
> >> @@ -240,6 +240,7 @@ void pmu_add_cpu_aliases_table(struct perf_pmu *pm=
u,
> >>  char *perf_pmu__getcpuid(struct perf_pmu *pmu);
> >>  const struct pmu_events_table *pmu_events_table__find(void);
> >>  const struct pmu_metrics_table *pmu_metrics_table__find(void);
> >> +bool pmu_uncore_identifier_match(const char *compat, const char *id);
> >>
> >>  int perf_pmu__convert_scale(const char *scale, char **end, double *sv=
al);
> >>
> >> --
> >> 1.8.3.1
> >>
