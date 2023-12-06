Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 543E1807A09
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 22:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379623AbjLFVEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 16:04:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379614AbjLFVEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 16:04:36 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5DA10DD
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 13:04:27 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40b35199f94so17585e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 13:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701896666; x=1702501466; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8UzsZWdtrX0NWnGdOYBSwf+kyM0YO7lv0sJZrqDk76w=;
        b=Ami/w2/sWcQPhvaMRBzChG4x3qvFPSAUzXQRQdmJZNjnnWz3UH4tMt0eM4l4w5AVc+
         5sUonTOiX1UvU9RvqwJdpiTIRfjw7/xLkiJLkz9LXFlaHuI1x7hULH5pBxGP0bEhAXel
         Ur29tM6sSkFD8X8XdYiF5UbdmYxAwOomwielebnbjGO/kBoZ9nEp9q3304p5B2U0xc9k
         Lc5eWl3uxfWESpLof0XO3DuFU4Ww7MWLeoYEN1xeuwPoLf/fvD6gPXMoe0XQK9c31kdS
         nivv5DoZPV0oxbaFFrr0TLVmKvrqjmuT30YGnh5jZ/2oF3jYQTkIInp9BS15Gl7IltT6
         G/Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701896666; x=1702501466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8UzsZWdtrX0NWnGdOYBSwf+kyM0YO7lv0sJZrqDk76w=;
        b=qhdidye3iAk7y+K2bTN2RrJq4v3lxNKwn4a+g7sCU4+JH3SM7hX3j0JlJMHhY2ARdR
         Q7BtnTJi8LzlZ33NS8Bz480qGzo+btgUjaHvyDlPzvXTEg8z6tpoS3qZ+xD4svHEEmDZ
         bTeB8BL3+ViMkE3FLXQwW+uw3zC8uRIXQ+8V3TsW5egTr2ljrW3PX/2zmvKI5Yaw4Oew
         GT2lApQ+HIbSmxX+A9EeXw4FTB9OQcVnBFlfXs8yxnFGk4kGAbzcUWF6zzEYxgtatQs4
         KxRONac5zDdSsNQ5OUgnrB7+m6KgUG4latalC6uUm5T7tKoTrKLnopSaMZaFoExg2IrD
         hmpw==
X-Gm-Message-State: AOJu0Yw88Vfu0zmsC7uKjm+nH3w712LknfL5u/BcV8wix2hWnIvr4iDS
        E/l/uJpPXv2u2+Pd1Fw99p62Rr6E70FeXIA37wV+Zg==
X-Google-Smtp-Source: AGHT+IEM46JZJZAstllweS7vpM4GjJTv3nBCEjxdepZ7VvhoglG0AFHfAtFzzB8j49pVUwxQh+3fgE6/sPVvtBmWL2k=
X-Received: by 2002:a7b:c40e:0:b0:40c:1e46:508e with SMTP id
 k14-20020a7bc40e000000b0040c1e46508emr86453wmi.0.1701896665362; Wed, 06 Dec
 2023 13:04:25 -0800 (PST)
MIME-Version: 1.0
References: <20231206201324.184059-1-kan.liang@linux.intel.com> <20231206201324.184059-3-kan.liang@linux.intel.com>
In-Reply-To: <20231206201324.184059-3-kan.liang@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 6 Dec 2023 13:04:14 -0800
Message-ID: <CAP-5=fUhaOgMZuhhsmjkTL6QqEQzcjq9GjJyteLG5RTWuBQ0gg@mail.gmail.com>
Subject: Re: [PATCH 2/6] perf mem: Clean up perf_mem_events__ptr()
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        namhyung@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        john.g.garry@oracle.com, will@kernel.org, james.clark@arm.com,
        mike.leach@linaro.org, leo.yan@linaro.org,
        yuhaixin.yhx@linux.alibaba.com, renyu.zj@linux.alibaba.com,
        tmricht@linux.ibm.com, ravi.bangoria@amd.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 6, 2023 at 12:13=E2=80=AFPM <kan.liang@linux.intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> The mem_events can be retrieved from the struct perf_pmu now. An ARCH
> specific perf_mem_events__ptr() is not required anymore. Remove all of
> them.
>
> The Intel hybrid has multiple mem-events-supported PMUs. But they share
> the same mem_events. Other ARCHs only support one mem-events-supported
> PMU. In the configuration, it's good enough to only configure the
> mem_events for one PMU. Add perf_mem_events_find_pmu() which returns the
> first mem-events-supported PMU.
>
> In the perf_mem_events__init(), the perf_pmus__scan() is not required
> anymore. It avoids checking the sysfs for every PMU on the system.
>
> Make the perf_mem_events__record_args() more generic. Remove the
> perf_mem_events__print_unsupport_hybrid().
>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>

Reviewed-by: Ian Rogers <irogers@google.com>

> ---
>  tools/perf/arch/arm64/util/mem-events.c |  10 +--
>  tools/perf/arch/x86/util/mem-events.c   |  18 ++---
>  tools/perf/builtin-c2c.c                |  28 +++++--
>  tools/perf/builtin-mem.c                |  28 +++++--
>  tools/perf/util/mem-events.c            | 103 ++++++++++++------------
>  tools/perf/util/mem-events.h            |   9 ++-
>  6 files changed, 104 insertions(+), 92 deletions(-)
>
> diff --git a/tools/perf/arch/arm64/util/mem-events.c b/tools/perf/arch/ar=
m64/util/mem-events.c
> index aaa4804922b4..2602e8688727 100644
> --- a/tools/perf/arch/arm64/util/mem-events.c
> +++ b/tools/perf/arch/arm64/util/mem-events.c
> @@ -12,17 +12,9 @@ struct perf_mem_event perf_mem_events_arm[PERF_MEM_EVE=
NTS__MAX] =3D {
>
>  static char mem_ev_name[100];
>
> -struct perf_mem_event *perf_mem_events__ptr(int i)
> -{
> -       if (i >=3D PERF_MEM_EVENTS__MAX)
> -               return NULL;
> -
> -       return &perf_mem_events_arm[i];
> -}
> -
>  const char *perf_mem_events__name(int i, const char *pmu_name __maybe_un=
used)
>  {
> -       struct perf_mem_event *e =3D perf_mem_events__ptr(i);
> +       struct perf_mem_event *e =3D &perf_mem_events_arm[i];
>
>         if (i >=3D PERF_MEM_EVENTS__MAX)
>                 return NULL;
> diff --git a/tools/perf/arch/x86/util/mem-events.c b/tools/perf/arch/x86/=
util/mem-events.c
> index 2b81d229982c..5fb41d50118d 100644
> --- a/tools/perf/arch/x86/util/mem-events.c
> +++ b/tools/perf/arch/x86/util/mem-events.c
> @@ -28,17 +28,6 @@ struct perf_mem_event perf_mem_events_amd[PERF_MEM_EVE=
NTS__MAX] =3D {
>         E("mem-ldst",   "ibs_op//",     "ibs_op"),
>  };
>
> -struct perf_mem_event *perf_mem_events__ptr(int i)
> -{
> -       if (i >=3D PERF_MEM_EVENTS__MAX)
> -               return NULL;
> -
> -       if (x86__is_amd_cpu())
> -               return &perf_mem_events_amd[i];
> -
> -       return &perf_mem_events_intel[i];
> -}
> -
>  bool is_mem_loads_aux_event(struct evsel *leader)
>  {
>         struct perf_pmu *pmu =3D perf_pmus__find("cpu");
> @@ -54,7 +43,12 @@ bool is_mem_loads_aux_event(struct evsel *leader)
>
>  const char *perf_mem_events__name(int i, const char *pmu_name)
>  {
> -       struct perf_mem_event *e =3D perf_mem_events__ptr(i);
> +       struct perf_mem_event *e;
> +
> +       if (x86__is_amd_cpu())
> +               e =3D &perf_mem_events_amd[i];
> +       else
> +               e =3D &perf_mem_events_intel[i];
>
>         if (!e)
>                 return NULL;
> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> index a4cf9de7a7b5..76c760be1bcf 100644
> --- a/tools/perf/builtin-c2c.c
> +++ b/tools/perf/builtin-c2c.c
> @@ -3215,12 +3215,19 @@ static int parse_record_events(const struct optio=
n *opt,
>                                const char *str, int unset __maybe_unused)
>  {
>         bool *event_set =3D (bool *) opt->value;
> +       struct perf_pmu *pmu;
> +
> +       pmu =3D perf_mem_events_find_pmu();
> +       if (!pmu) {
> +               pr_err("failed: there is no PMU that supports perf c2c\n"=
);
> +               exit(-1);
> +       }
>
>         if (!strcmp(str, "list")) {
> -               perf_mem_events__list();
> +               perf_mem_events__list(pmu);
>                 exit(0);
>         }
> -       if (perf_mem_events__parse(str))
> +       if (perf_mem_events__parse(pmu, str))
>                 exit(-1);
>
>         *event_set =3D true;
> @@ -3245,6 +3252,7 @@ static int perf_c2c__record(int argc, const char **=
argv)
>         bool all_user =3D false, all_kernel =3D false;
>         bool event_set =3D false;
>         struct perf_mem_event *e;
> +       struct perf_pmu *pmu;
>         struct option options[] =3D {
>         OPT_CALLBACK('e', "event", &event_set, "event",
>                      "event selector. Use 'perf c2c record -e list' to li=
st available events",
> @@ -3256,7 +3264,13 @@ static int perf_c2c__record(int argc, const char *=
*argv)
>         OPT_END()
>         };
>
> -       if (perf_mem_events__init()) {
> +       pmu =3D perf_mem_events_find_pmu();
> +       if (!pmu) {
> +               pr_err("failed: no PMU supports the memory events\n");
> +               return -1;
> +       }
> +
> +       if (perf_mem_events__init(pmu)) {
>                 pr_err("failed: memory events not supported\n");
>                 return -1;
>         }
> @@ -3280,7 +3294,7 @@ static int perf_c2c__record(int argc, const char **=
argv)
>         rec_argv[i++] =3D "record";
>
>         if (!event_set) {
> -               e =3D perf_mem_events__ptr(PERF_MEM_EVENTS__LOAD_STORE);
> +               e =3D perf_mem_events__ptr(pmu, PERF_MEM_EVENTS__LOAD_STO=
RE);
>                 /*
>                  * The load and store operations are required, use the ev=
ent
>                  * PERF_MEM_EVENTS__LOAD_STORE if it is supported.
> @@ -3289,15 +3303,15 @@ static int perf_c2c__record(int argc, const char =
**argv)
>                         e->record =3D true;
>                         rec_argv[i++] =3D "-W";
>                 } else {
> -                       e =3D perf_mem_events__ptr(PERF_MEM_EVENTS__LOAD)=
;
> +                       e =3D perf_mem_events__ptr(pmu, PERF_MEM_EVENTS__=
LOAD);

Fwiw, it seems strange in cases like this that the function isn't:
perf_pmu__mem_events_ptr(pmu, PERF_MEM_EVENTS__LOAD)

Thanks,
Ian

>                         e->record =3D true;
>
> -                       e =3D perf_mem_events__ptr(PERF_MEM_EVENTS__STORE=
);
> +                       e =3D perf_mem_events__ptr(pmu, PERF_MEM_EVENTS__=
STORE);
>                         e->record =3D true;
>                 }
>         }
>
> -       e =3D perf_mem_events__ptr(PERF_MEM_EVENTS__LOAD);
> +       e =3D perf_mem_events__ptr(pmu, PERF_MEM_EVENTS__LOAD);
>         if (e->record)
>                 rec_argv[i++] =3D "-W";
>
> diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
> index 51499c20da01..8218c4721101 100644
> --- a/tools/perf/builtin-mem.c
> +++ b/tools/perf/builtin-mem.c
> @@ -43,12 +43,19 @@ static int parse_record_events(const struct option *o=
pt,
>                                const char *str, int unset __maybe_unused)
>  {
>         struct perf_mem *mem =3D *(struct perf_mem **)opt->value;
> +       struct perf_pmu *pmu;
> +
> +       pmu =3D perf_mem_events_find_pmu();
> +       if (!pmu) {
> +               pr_err("failed: there is no PMU that supports perf mem\n"=
);
> +               exit(-1);
> +       }
>
>         if (!strcmp(str, "list")) {
> -               perf_mem_events__list();
> +               perf_mem_events__list(pmu);
>                 exit(0);
>         }
> -       if (perf_mem_events__parse(str))
> +       if (perf_mem_events__parse(pmu, str))
>                 exit(-1);
>
>         mem->operation =3D 0;
> @@ -72,6 +79,7 @@ static int __cmd_record(int argc, const char **argv, st=
ruct perf_mem *mem)
>         int ret;
>         bool all_user =3D false, all_kernel =3D false;
>         struct perf_mem_event *e;
> +       struct perf_pmu *pmu;
>         struct option options[] =3D {
>         OPT_CALLBACK('e', "event", &mem, "event",
>                      "event selector. use 'perf mem record -e list' to li=
st available events",
> @@ -84,7 +92,13 @@ static int __cmd_record(int argc, const char **argv, s=
truct perf_mem *mem)
>         OPT_END()
>         };
>
> -       if (perf_mem_events__init()) {
> +       pmu =3D perf_mem_events_find_pmu();
> +       if (!pmu) {
> +               pr_err("failed: no PMU supports the memory events\n");
> +               return -1;
> +       }
> +
> +       if (perf_mem_events__init(pmu)) {
>                 pr_err("failed: memory events not supported\n");
>                 return -1;
>         }
> @@ -113,7 +127,7 @@ static int __cmd_record(int argc, const char **argv, =
struct perf_mem *mem)
>
>         rec_argv[i++] =3D "record";
>
> -       e =3D perf_mem_events__ptr(PERF_MEM_EVENTS__LOAD_STORE);
> +       e =3D perf_mem_events__ptr(pmu, PERF_MEM_EVENTS__LOAD_STORE);
>
>         /*
>          * The load and store operations are required, use the event
> @@ -126,17 +140,17 @@ static int __cmd_record(int argc, const char **argv=
, struct perf_mem *mem)
>                 rec_argv[i++] =3D "-W";
>         } else {
>                 if (mem->operation & MEM_OPERATION_LOAD) {
> -                       e =3D perf_mem_events__ptr(PERF_MEM_EVENTS__LOAD)=
;
> +                       e =3D perf_mem_events__ptr(pmu, PERF_MEM_EVENTS__=
LOAD);
>                         e->record =3D true;
>                 }
>
>                 if (mem->operation & MEM_OPERATION_STORE) {
> -                       e =3D perf_mem_events__ptr(PERF_MEM_EVENTS__STORE=
);
> +                       e =3D perf_mem_events__ptr(pmu, PERF_MEM_EVENTS__=
STORE);
>                         e->record =3D true;
>                 }
>         }
>
> -       e =3D perf_mem_events__ptr(PERF_MEM_EVENTS__LOAD);
> +       e =3D perf_mem_events__ptr(pmu, PERF_MEM_EVENTS__LOAD);
>         if (e->record)
>                 rec_argv[i++] =3D "-W";
>
> diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
> index 0a8f415f5efe..887ffdcce338 100644
> --- a/tools/perf/util/mem-events.c
> +++ b/tools/perf/util/mem-events.c
> @@ -29,17 +29,42 @@ struct perf_mem_event perf_mem_events[PERF_MEM_EVENTS=
__MAX] =3D {
>  static char mem_loads_name[100];
>  static bool mem_loads_name__init;
>
> -struct perf_mem_event * __weak perf_mem_events__ptr(int i)
> +struct perf_mem_event *perf_mem_events__ptr(struct perf_pmu *pmu, int i)
>  {
> -       if (i >=3D PERF_MEM_EVENTS__MAX)
> +       if (i >=3D PERF_MEM_EVENTS__MAX || !pmu)
>                 return NULL;
>
> -       return &perf_mem_events[i];
> +       return &pmu->mem_events[i];
> +}
> +
> +static struct perf_pmu *perf_pmus__scan_mem(struct perf_pmu *pmu)
> +{
> +       while ((pmu =3D perf_pmus__scan(pmu)) !=3D NULL) {
> +               if (pmu->mem_events)
> +                       return pmu;
> +       }
> +       return NULL;
> +}
> +
> +struct perf_pmu *perf_mem_events_find_pmu(void)
> +{
> +       /*
> +        * The current perf mem doesn't support per-PMU configuration.
> +        * The exact same configuration is applied to all the
> +        * mem_events supported PMUs.
> +        * Return the first mem_events supported PMU.
> +        *
> +        * Notes: The only case which may support multiple mem_events
> +        * supported PMUs is Intel hybrid. The exact same mem_events
> +        * is shared among the PMUs. Only configure the first PMU
> +        * is good enough as well.
> +        */
> +       return perf_pmus__scan_mem(NULL);
>  }
>
>  const char * __weak perf_mem_events__name(int i, const char *pmu_name  _=
_maybe_unused)
>  {
> -       struct perf_mem_event *e =3D perf_mem_events__ptr(i);
> +       struct perf_mem_event *e =3D &perf_mem_events[i];
>
>         if (!e)
>                 return NULL;
> @@ -61,7 +86,7 @@ __weak bool is_mem_loads_aux_event(struct evsel *leader=
 __maybe_unused)
>         return false;
>  }
>
> -int perf_mem_events__parse(const char *str)
> +int perf_mem_events__parse(struct perf_pmu *pmu, const char *str)
>  {
>         char *tok, *saveptr =3D NULL;
>         bool found =3D false;
> @@ -79,7 +104,7 @@ int perf_mem_events__parse(const char *str)
>
>         while (tok) {
>                 for (j =3D 0; j < PERF_MEM_EVENTS__MAX; j++) {
> -                       struct perf_mem_event *e =3D perf_mem_events__ptr=
(j);
> +                       struct perf_mem_event *e =3D perf_mem_events__ptr=
(pmu, j);
>
>                         if (!e->tag)
>                                 continue;
> @@ -112,7 +137,7 @@ static bool perf_mem_event__supported(const char *mnt=
, struct perf_pmu *pmu,
>         return !stat(path, &st);
>  }
>
> -int perf_mem_events__init(void)
> +int perf_mem_events__init(struct perf_pmu *pmu)
>  {
>         const char *mnt =3D sysfs__mount();
>         bool found =3D false;
> @@ -122,8 +147,7 @@ int perf_mem_events__init(void)
>                 return -ENOENT;
>
>         for (j =3D 0; j < PERF_MEM_EVENTS__MAX; j++) {
> -               struct perf_mem_event *e =3D perf_mem_events__ptr(j);
> -               struct perf_pmu *pmu =3D NULL;
> +               struct perf_mem_event *e =3D perf_mem_events__ptr(pmu, j)=
;
>
>                 /*
>                  * If the event entry isn't valid, skip initialization
> @@ -132,29 +156,20 @@ int perf_mem_events__init(void)
>                 if (!e->tag)
>                         continue;
>
> -               /*
> -                * Scan all PMUs not just core ones, since perf mem/c2c o=
n
> -                * platforms like AMD uses IBS OP PMU which is independen=
t
> -                * of core PMU.
> -                */
> -               while ((pmu =3D perf_pmus__scan(pmu)) !=3D NULL) {
> -                       e->supported |=3D perf_mem_event__supported(mnt, =
pmu, e);
> -                       if (e->supported) {
> -                               found =3D true;
> -                               break;
> -                       }
> -               }
> +               e->supported |=3D perf_mem_event__supported(mnt, pmu, e);
> +               if (e->supported)
> +                       found =3D true;
>         }
>
>         return found ? 0 : -ENOENT;
>  }
>
> -void perf_mem_events__list(void)
> +void perf_mem_events__list(struct perf_pmu *pmu)
>  {
>         int j;
>
>         for (j =3D 0; j < PERF_MEM_EVENTS__MAX; j++) {
> -               struct perf_mem_event *e =3D perf_mem_events__ptr(j);
> +               struct perf_mem_event *e =3D perf_mem_events__ptr(pmu, j)=
;
>
>                 fprintf(stderr, "%-*s%-*s%s",
>                         e->tag ? 13 : 0,
> @@ -165,50 +180,32 @@ void perf_mem_events__list(void)
>         }
>  }
>
> -static void perf_mem_events__print_unsupport_hybrid(struct perf_mem_even=
t *e,
> -                                                   int idx)
> -{
> -       const char *mnt =3D sysfs__mount();
> -       struct perf_pmu *pmu =3D NULL;
> -
> -       while ((pmu =3D perf_pmus__scan(pmu)) !=3D NULL) {
> -               if (!perf_mem_event__supported(mnt, pmu, e)) {
> -                       pr_err("failed: event '%s' not supported\n",
> -                              perf_mem_events__name(idx, pmu->name));
> -               }
> -       }
> -}
> -
>  int perf_mem_events__record_args(const char **rec_argv, int *argv_nr,
>                                  char **rec_tmp, int *tmp_nr)
>  {
>         const char *mnt =3D sysfs__mount();
> +       struct perf_pmu *pmu =3D NULL;
>         int i =3D *argv_nr, k =3D 0;
>         struct perf_mem_event *e;
>
> -       for (int j =3D 0; j < PERF_MEM_EVENTS__MAX; j++) {
> -               e =3D perf_mem_events__ptr(j);
> -               if (!e->record)
> -                       continue;
>
> -               if (perf_pmus__num_mem_pmus() =3D=3D 1) {
> -                       if (!e->supported) {
> -                               pr_err("failed: event '%s' not supported\=
n",
> -                                      perf_mem_events__name(j, NULL));
> -                               return -1;
> -                       }
> +       while ((pmu =3D perf_pmus__scan_mem(pmu)) !=3D NULL) {
> +               for (int j =3D 0; j < PERF_MEM_EVENTS__MAX; j++) {
> +                       e =3D perf_mem_events__ptr(pmu, j);
>
> -                       rec_argv[i++] =3D "-e";
> -                       rec_argv[i++] =3D perf_mem_events__name(j, NULL);
> -               } else {
> -                       struct perf_pmu *pmu =3D NULL;
> +                       if (!e->record)
> +                               continue;
>
>                         if (!e->supported) {
> -                               perf_mem_events__print_unsupport_hybrid(e=
, j);
> +                               pr_err("failed: event '%s' not supported\=
n",
> +                                       perf_mem_events__name(j, pmu->nam=
e));
>                                 return -1;
>                         }
>
> -                       while ((pmu =3D perf_pmus__scan(pmu)) !=3D NULL) =
{
> +                       if (perf_pmus__num_mem_pmus() =3D=3D 1) {
> +                               rec_argv[i++] =3D "-e";
> +                               rec_argv[i++] =3D perf_mem_events__name(j=
, NULL);
> +                       } else {
>                                 const char *s =3D perf_mem_events__name(j=
, pmu->name);
>
>                                 if (!perf_mem_event__supported(mnt, pmu, =
e))
> diff --git a/tools/perf/util/mem-events.h b/tools/perf/util/mem-events.h
> index 8c5694b2d0b0..59a4303aac96 100644
> --- a/tools/perf/util/mem-events.h
> +++ b/tools/perf/util/mem-events.h
> @@ -36,14 +36,15 @@ enum {
>  extern unsigned int perf_mem_events__loads_ldlat;
>  extern struct perf_mem_event perf_mem_events[PERF_MEM_EVENTS__MAX];
>
> -int perf_mem_events__parse(const char *str);
> -int perf_mem_events__init(void);
> +int perf_mem_events__parse(struct perf_pmu *pmu, const char *str);
> +int perf_mem_events__init(struct perf_pmu *pmu);
>
>  const char *perf_mem_events__name(int i, const char *pmu_name);
> -struct perf_mem_event *perf_mem_events__ptr(int i);
> +struct perf_mem_event *perf_mem_events__ptr(struct perf_pmu *pmu, int i)=
;
> +struct perf_pmu *perf_mem_events_find_pmu(void);
>  bool is_mem_loads_aux_event(struct evsel *leader);
>
> -void perf_mem_events__list(void);
> +void perf_mem_events__list(struct perf_pmu *pmu);
>  int perf_mem_events__record_args(const char **rec_argv, int *argv_nr,
>                                  char **rec_tmp, int *tmp_nr);
>
> --
> 2.35.1
>
