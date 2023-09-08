Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED5D079918C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 23:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232931AbjIHVd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 17:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232415AbjIHVd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 17:33:58 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3506E46
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 14:33:54 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-415155b2796so15611cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 14:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694208833; x=1694813633; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MfevmZn91fM44hLIGV+jcd6pMniaGx21p0N0a1MPeVE=;
        b=gX6KbGLdrBPz72zZsMh0QuMXItgz2kQ3sT7OKZZ9Sn8tIc1HCZOA0lQQpWGy/LLz/y
         CxnYxWhEPQzUl+JvGi8F2u5s5K/VLIfYqNX4pEr54n3YI27UBCCxB0BW5g0SdlXXakyk
         lRxswXRim1um09G3jrR5TaWERaxmk5aHQLlsCH6vH35LRVBVv0oHBwYDV6zvYfCP1cLT
         ZuVvqWNJ9UQuUAsYY7G6dRfEpzl+QJXsw7WI9TTqskl99FGXohths96kxzabTLLo3oeN
         bpoHi94PEOzLxmhDmHVG8Ru9QZNRWRpVajflZEUgJ4j3AieFB+V2bzxUkxyjO1bq7Jq1
         Tuug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694208833; x=1694813633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MfevmZn91fM44hLIGV+jcd6pMniaGx21p0N0a1MPeVE=;
        b=eNIlls7ALrMzSQkeOvSW26dORbrT0iG6/x43bp/WO9vHqt1rn6bBCEkv0p6PLqJ7kK
         TkgRNT78tZkiM5NZ06a/ZNcMDUsLqtmIiDMG4hEKEmazuCCFwgH3K3j78rI8VUseaJlm
         7WVQt+5lc3KvIfLas3Boyv+C88P7d9x3sgsZ+HqP8v9vsfTPSiOPL2KZOsDY3xN9ENDG
         EDsVHnByg0MG9lloUtRDmMnjTWuydTBLavsf50adfzACs+XHFoZ6g0gaQcntuPW3fBYl
         0SteWkvkz2VD5K2yc74L6ptx05xEfadpB0V5N8+Bm0V1dcLcj30vd/UTsE2fOsQBHg1F
         3UqA==
X-Gm-Message-State: AOJu0YzcLdn9MRHMHRQV2jV8Ag89utQf8VCfpP0jfeRyCb+hBU8oa3kT
        8oU2VGZrmMpMiNQWX3j1v2/ZciaFPmiH6UN9Htzs8Q==
X-Google-Smtp-Source: AGHT+IEB2DSWIsThRYGIKiW5I1btJGsunl21Q8x3POOJYXKwt9gvHrhKcTHa8i4HIpqm/vkNmwHL21RVvIAD6Wwgv0E=
X-Received: by 2002:a05:622a:453:b0:3f8:5b2:aef0 with SMTP id
 o19-20020a05622a045300b003f805b2aef0mr391151qtx.24.1694208833608; Fri, 08 Sep
 2023 14:33:53 -0700 (PDT)
MIME-Version: 1.0
References: <1694087913-46144-1-git-send-email-renyu.zj@linux.alibaba.com> <1694087913-46144-2-git-send-email-renyu.zj@linux.alibaba.com>
In-Reply-To: <1694087913-46144-2-git-send-email-renyu.zj@linux.alibaba.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 8 Sep 2023 14:33:42 -0700
Message-ID: <CAP-5=fVWcQrqLeuc-k4HRNrNdb_=9CbqTSOAX=HDR7f=j8b0Hg@mail.gmail.com>
Subject: Re: [PATCH v8 1/8] perf pmu: "Compat" supports matching multiple identifiers
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 7, 2023 at 4:58=E2=80=AFAM Jing Zhang <renyu.zj@linux.alibaba.c=
om> wrote:
>
> The jevent "Compat" is used for uncore PMU alias or metric definitions.
>
> The same PMU driver has different PMU identifiers due to different
> hardware versions and types, but they may have some common PMU event.
> Since a Compat value can only match one identifier, when adding the
> same event alias to PMUs with different identifiers, each identifier
> needs to be defined once, which is not streamlined enough.
>
> So let "Compat" supports matching multiple identifiers for uncore PMU
> alias. For example, the Compat value {43401;436*} can match the PMU
> identifier "43401", that is, CMN600_r0p0, and the PMU identifier with
> the prefix "436", that is, all CMN650, where "*" is a wildcard.
> Tokens in Unit field are delimited by ';' with no spaces.
>
> Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
> Reviewed-by: John Garry <john.g.garry@oracle.com>
> ---
>  tools/perf/util/pmu.c | 28 ++++++++++++++++++++++++++--
>  tools/perf/util/pmu.h |  1 +
>  2 files changed, 27 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index e215985..c3c3818 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -875,6 +875,30 @@ static bool pmu_uncore_alias_match(const char *pmu_n=
ame, const char *name)
>         return res;
>  }
>
> +bool pmu_uncore_identifier_match(const char *id, const char *compat)
> +{
> +       char *tmp =3D NULL, *tok, *str;
> +       bool res =3D false;
> +
> +       /*
> +        * The strdup() call is necessary here because "compat" is a cons=
t str*
> +        * type and cannot be used as an argument to strtok_r().
> +        */
> +       str =3D strdup(compat);
> +       if (!str)
> +               return false;
> +
> +       tok =3D strtok_r(str, ";", &tmp);

Did the comma vs semicolon difference get explained? It seems to add
inconsistency to use a semicolon.

Thanks,
Ian

> +       for (; tok; tok =3D strtok_r(NULL, ";", &tmp)) {
> +               if (!fnmatch(tok, id, FNM_CASEFOLD)) {
> +                       res =3D true;
> +                       break;
> +               }
> +       }
> +       free(str);
> +       return res;
> +}
> +
>  static int pmu_add_cpu_aliases_map_callback(const struct pmu_event *pe,
>                                         const struct pmu_events_table *ta=
ble __maybe_unused,
>                                         void *vdata)
> @@ -915,8 +939,8 @@ static int pmu_add_sys_aliases_iter_fn(const struct p=
mu_event *pe,
>         if (!pe->compat || !pe->pmu)
>                 return 0;
>
> -       if (!strcmp(pmu->id, pe->compat) &&
> -           pmu_uncore_alias_match(pe->pmu, pmu->name)) {
> +       if (pmu_uncore_alias_match(pe->pmu, pmu->name) &&
> +                       pmu_uncore_identifier_match(pmu->id, pe->compat))=
 {
>                 perf_pmu__new_alias(pmu,
>                                 pe->name,
>                                 pe->desc,
> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> index bd5d804..1bf5cf1 100644
> --- a/tools/perf/util/pmu.h
> +++ b/tools/perf/util/pmu.h
> @@ -240,6 +240,7 @@ void pmu_add_cpu_aliases_table(struct perf_pmu *pmu,
>  char *perf_pmu__getcpuid(struct perf_pmu *pmu);
>  const struct pmu_events_table *pmu_events_table__find(void);
>  const struct pmu_metrics_table *pmu_metrics_table__find(void);
> +bool pmu_uncore_identifier_match(const char *id, const char *compat);
>
>  int perf_pmu__convert_scale(const char *scale, char **end, double *sval)=
;
>
> --
> 1.8.3.1
>
