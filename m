Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 919A57A8BEF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 20:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjITShP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 14:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjITShO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 14:37:14 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A17CC
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 11:37:07 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-41513d2cca7so65791cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 11:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695235027; x=1695839827; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0O+D8ee7zVjlDA63SdSMbPU/xhmCnjuF2y/9Wte3IZU=;
        b=NQJOdJ8WxdL54Ou233drNw7O9zKHOOoHyyW6zSoT/ZS08d2yM70cmDN+pncETN+dwe
         b4wWDGIaPwHx2Dh5p/m9z7mQmHxRZ6nsLELHK7+R2NozymYYfX74airpiEkj9xc/afvr
         SXwtqySL/KV1AsMsxSJ6FT9gOr9Tr9eL1kglQL8uI9BtAKxP57f/7/bjLZZ7qUPwyovw
         IUzQrn+YCrlSrPIeLMraAPUuakiOTyhPLjXoeVJ5srGkYJllT2ed8ZUom/RZ9YP8o2cT
         uQNjJAb9UjZqkEaVDJCdZR9fBiRzGoR2EBmfmyeXdSZtEr/Zq0Z7KYPc0oc4O/sWklo5
         8bHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695235027; x=1695839827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0O+D8ee7zVjlDA63SdSMbPU/xhmCnjuF2y/9Wte3IZU=;
        b=Hh89Nkk/HCT0U33HdXbH7MiifWTvWSs9R/ubcpu0+FXgLPV5wHYz5PXFEw+8/q4tHV
         GakpOEkfoiQ8G90pX8D6ehpqho9iO7TTTpznY7yZh3aUBZI59fGHoCHs1N/rr7wS777n
         7FWS5IBEtFhaLsPt+GTCreOtVJniVSxuBX0QSWFw7V1DkyTrevd8XymeStclMqWsfENl
         vkqTrJIQehF9rm+lwRu5yxwj/T7KdjTuXWfmzMEzlxHYpS2PX8Gt10VAULEHctQ6HrOf
         OP7N304u/lqYAb0v/5R3UrnDmHzauIGEFmXnYgpDox9Q+g1OguW2vlnUFb2/Vn+7vk4L
         RMIw==
X-Gm-Message-State: AOJu0Yze2ImJItbuGcOkDAaoMviC7ZX35tKzX36KtyAPWbYt4OEltOPN
        EBmq8e8ybNeAJQRNTzoBEc8HN8638Elco6KDEfMIUA==
X-Google-Smtp-Source: AGHT+IHH8trGn6FixfU9iGVDAVjtavlrf27fE86uW31DiR0c3+ziEee+4De0deb9fORimQ1w5hztZnp/3gkgd72l680=
X-Received: by 2002:ac8:4e4a:0:b0:416:ea40:6e8c with SMTP id
 e10-20020ac84e4a000000b00416ea406e8cmr21592qtw.6.1695235026683; Wed, 20 Sep
 2023 11:37:06 -0700 (PDT)
MIME-Version: 1.0
References: <1695037955-107983-1-git-send-email-renyu.zj@linux.alibaba.com> <1695037955-107983-2-git-send-email-renyu.zj@linux.alibaba.com>
In-Reply-To: <1695037955-107983-2-git-send-email-renyu.zj@linux.alibaba.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 20 Sep 2023 11:36:55 -0700
Message-ID: <CAP-5=fUxfJT-gxKB+Ls3drUeQ0sy55uydi8Y36gumUnaFSYeqA@mail.gmail.com>
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
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 4:52=E2=80=AFAM Jing Zhang <renyu.zj@linux.alibaba.=
com> wrote:
>
> The jevent "Compat" is used for uncore PMU alias or metric definitions.
>
> The same PMU driver has different PMU identifiers due to different
> hardware versions and types, but they may have some common PMU event.
> Since a Compat value can only match one identifier, when adding the
> same event alias to PMUs with different identifiers, each identifier
> needs to be defined once, which is not streamlined enough.
>
> So let "Compat" support using regular expression to match identifiers
> for uncore PMU alias. For example, if the "Compat" value is set to
> "43401|43c01", it would be able to match PMU identifiers such as "43401"
> or "43c01", which correspond to CMN600_r0p0 or CMN700_r0p0.
>
> Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
> ---
>  tools/perf/util/pmu.c | 23 +++++++++++++++++++++--
>  tools/perf/util/pmu.h |  1 +
>  2 files changed, 22 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index e215985..7e2242f 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -28,6 +28,7 @@
>  #include "strbuf.h"
>  #include "fncache.h"
>  #include "util/evsel_config.h"
> +#include <regex.h>
>
>  struct perf_pmu perf_pmu__fake =3D {
>         .name =3D "fake",
> @@ -875,6 +876,24 @@ static bool pmu_uncore_alias_match(const char *pmu_n=
ame, const char *name)
>         return res;
>  }
>
> +bool pmu_uncore_identifier_match(const char *compat, const char *id)
> +{
> +       regex_t re;
> +       regmatch_t pmatch[1];
> +       int match;
> +
> +       if (regcomp(&re, compat, REG_EXTENDED) !=3D 0) {
> +               /* Warn unable to generate match particular string. */
> +               pr_info("Invalid regular expression %s\n", compat);
> +               return false;
> +       }
> +
> +       match =3D !regexec(&re, id, 1, pmatch, 0);

I wonder if we can make the regular expressions like
"^(434|436|43c|43a)" more like "(434|436|43c|43a).*", so that we fully
match the id string, by here doing:

if (match) {
  /* Ensure a full match. */
  match =3D pmatch[0].rm_so =3D=3D 0 && pmatch[0].rm_eo =3D=3D strlen(id);
}

I think longer term we can use jevents.py to generate a pmu-events.l,
which would have a contents something like:

(434|436|43c|43a).*  { return PMU_....;}

That should make the matching faster but may add some restrictions
onto the regular expression.

Thanks,
Ian

> +       regfree(&re);
> +
> +       return match;
> +}
> +
>  static int pmu_add_cpu_aliases_map_callback(const struct pmu_event *pe,
>                                         const struct pmu_events_table *ta=
ble __maybe_unused,
>                                         void *vdata)
> @@ -915,8 +934,8 @@ static int pmu_add_sys_aliases_iter_fn(const struct p=
mu_event *pe,
>         if (!pe->compat || !pe->pmu)
>                 return 0;
>
> -       if (!strcmp(pmu->id, pe->compat) &&
> -           pmu_uncore_alias_match(pe->pmu, pmu->name)) {
> +       if (pmu_uncore_alias_match(pe->pmu, pmu->name) &&
> +                       pmu_uncore_identifier_match(pe->compat, pmu->id))=
 {
>                 perf_pmu__new_alias(pmu,
>                                 pe->name,
>                                 pe->desc,
> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> index bd5d804..fc155ce 100644
> --- a/tools/perf/util/pmu.h
> +++ b/tools/perf/util/pmu.h
> @@ -240,6 +240,7 @@ void pmu_add_cpu_aliases_table(struct perf_pmu *pmu,
>  char *perf_pmu__getcpuid(struct perf_pmu *pmu);
>  const struct pmu_events_table *pmu_events_table__find(void);
>  const struct pmu_metrics_table *pmu_metrics_table__find(void);
> +bool pmu_uncore_identifier_match(const char *compat, const char *id);
>
>  int perf_pmu__convert_scale(const char *scale, char **end, double *sval)=
;
>
> --
> 1.8.3.1
>
