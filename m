Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15B647878FD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 21:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243367AbjHXT5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 15:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243349AbjHXT47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 15:56:59 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489E21BE6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 12:56:56 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-40a47e8e38dso3501cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 12:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692907015; x=1693511815; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4s2OowvVGdrU7RBS0YF/4JET4VS0tbaMFNblJjYRR70=;
        b=mAoILHMR1rDhSe6YWykgOqI4/Nl4mMH/GuOWUaIqwbpK90yIqYlIKjYmA7ZaZC71Rk
         2vD5L/SP39W0qh3MCpxb0NIdDzgdm1LzgBSGDfIZh7AT5W3Ja5D8onJzuKpzHdL4ChvP
         gjDGP5QArgu4NKtV5y9uca9MGxq+METWouDIlxgAMot6PhQLP0xJ5Ou/Dv16vcuUbKBW
         mIu92ZgtKlM/ntMB8kwWfLPA+JDZ15koDR9miodTNN1F7jCON1YZtOrGEYcKTGd9QYrI
         aXmOJ2PLbGnH5IAHbg6IP9rodii3f3GDKss/XYXYv4CFsZNSmyqvQWKZJXOcW7Ezak8m
         6q+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692907015; x=1693511815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4s2OowvVGdrU7RBS0YF/4JET4VS0tbaMFNblJjYRR70=;
        b=AUGPUXSAyPaiGnFXS9kaPVf1gkWgXq6BdI0DS0q0IJRmyycPSIs9t9O9Wo5Rn9mi/n
         yUa7CZM+nvf5gC9Gs4ejCsJKoqJATYWUYc6NWzOnIVghbUWt4/YMvd0YLcyDttWRoFbE
         yn55L+1wnFno60XUSWe1dwfnJhz8cWBgoYPgnUJnHwsz8mG7QLYb6gK2heGLRIx6Nlz7
         L4ioVo6srd5IPPS15TxQKFpt8QlTBCakHJfs94yjvaFAgAvlSlGJfb2VFX24q1/tfcXd
         FE6vBYGOyGmRv7U9ks8rWVQ88+sZ3V8RlPaJVGczRd+hlEBWCSVXiKaN/SC9Cq1zolxT
         zqpg==
X-Gm-Message-State: AOJu0YzQvUWW5NSxH/U6fyP3PsdfkvdaVCPeqAEbmr3ypaXVH/0SXPup
        7OSxzkn8PcF9DUs390JuJBeS8bXJca4b5MyfpuXdkg==
X-Google-Smtp-Source: AGHT+IHgcXRrKd3y5NCYPbD1ji+7rA5Yzh25xDGCkSbSzoDjXWhjuVMRXGblcCnyeZzBurHOtYE6sb+RTgt+dcT4Gyc=
X-Received: by 2002:ac8:7c51:0:b0:410:88dc:21b with SMTP id
 o17-20020ac87c51000000b0041088dc021bmr78996qtv.26.1692907015329; Thu, 24 Aug
 2023 12:56:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230814163757.3077138-1-irogers@google.com> <20230814163757.3077138-3-irogers@google.com>
 <6913f6d8-7f01-f132-5375-e82b8aa2e0b9@linux.intel.com> <CAP-5=fX3_dpxGU1qp2kisHQ13i1+tEO9B2KGi1Z7z3+nqigfRw@mail.gmail.com>
 <6e3eae74-c89f-53a7-f954-bf36c7763316@linux.intel.com>
In-Reply-To: <6e3eae74-c89f-53a7-f954-bf36c7763316@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 24 Aug 2023 12:56:43 -0700
Message-ID: <CAP-5=fVLSWQQz6Q1usk9iWBcSYoi5wBWLCwLUG+7_DGfii7Caw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] perf pmus: Add scan that ignores duplicates, use
 for perf list
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
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

On Thu, Aug 24, 2023 at 12:44=E2=80=AFPM Liang, Kan <kan.liang@linux.intel.=
com> wrote:
>
>
>
> On 2023-08-24 1:30 p.m., Ian Rogers wrote:
> > On Thu, Aug 24, 2023 at 7:01=E2=80=AFAM Liang, Kan <kan.liang@linux.int=
el.com> wrote:
> >>
> >>
> >>
> >> On 2023-08-14 12:37 p.m., Ian Rogers wrote:
> >>> When there are multiple PMUs that differ only by suffix, by default
> >>> just list the first one and skip all others. As the PMUs are sorted,
> >>> the scan routine checks that the PMU names match and the numbers are
> >>> consecutive.
> >>
> >> The suffix number may not be consecutive, especially for SPR and later
> >> platforms. Because the IDs are from the discovery table now, which is
> >> assigned by the HW. The physic IDs are not guaranteed to be consecutiv=
e.
> >>
> >> I don't think there is a plan to change it to logical IDs. Because
> >> sometimes people want to know the physic IDs. So they can locate the
> >> specific unit quickly.
> >
> > Thanks Kan,
> >
> > I think this could lead to perf list merging some PMUs into one name
> > and not doing this for others. We could keep the existing behavior by
> > checking the numbers are consecutive but it'd come with some
> > complexity and runtime cost. We could just ignore the consecutive
> > property. We could just not try to solve the problem. What do you
> > think is the right strategy?
>
> I like the idea of merging the duplicate PMUs. My only concern is that
> the assumption of the consecutive may not work for all the uncore cases.
> If the IDs are 0,2,4,6, they cannot be merged successfully, right?
>
> Can we just ignore the consecutive check?
> Is there a problem if we just simply remove the "(last_pmu_num + 1 =3D=3D
> pmu_num) &&", and only compare the no_suffix name?

Sgtm. I'll update the patch to do this in v4.

Thanks,
Ian

> Thanks,
> Kan
>
> >
> > On other architectures they encode these numbers in different places
> > but generally with no underscore, so this change has no impact for
> > them. I'm keen to solve this problem as we're seeing large numbers of
> > PMUs that cause perf list to be spammy and the all PMU events test to
> > run for too long.>
> > Thanks,
> > Ian
> >
> >> Thanks,
> >> Kan
> >>
> >>> If "-v" is passed to "perf list" then list all PMUs.
> >>>
> >>> Signed-off-by: Ian Rogers <irogers@google.com>
> >>> ---
> >>>  tools/perf/builtin-list.c      |  8 +++++
> >>>  tools/perf/util/pmus.c         | 54 ++++++++++++++++++++++++++++++++=
--
> >>>  tools/perf/util/print-events.h |  1 +
> >>>  3 files changed, 61 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
> >>> index 7fec2cca759f..8fe4ddf02c14 100644
> >>> --- a/tools/perf/builtin-list.c
> >>> +++ b/tools/perf/builtin-list.c
> >>> @@ -423,6 +423,13 @@ static void json_print_metric(void *ps __maybe_u=
nused, const char *group,
> >>>       strbuf_release(&buf);
> >>>  }
> >>>
> >>> +static bool default_skip_duplicate_pmus(void *ps)
> >>> +{
> >>> +     struct print_state *print_state =3D ps;
> >>> +
> >>> +     return !print_state->long_desc;
> >>> +}
> >>> +
> >>>  int cmd_list(int argc, const char **argv)
> >>>  {
> >>>       int i, ret =3D 0;
> >>> @@ -434,6 +441,7 @@ int cmd_list(int argc, const char **argv)
> >>>               .print_end =3D default_print_end,
> >>>               .print_event =3D default_print_event,
> >>>               .print_metric =3D default_print_metric,
> >>> +             .skip_duplicate_pmus =3D default_skip_duplicate_pmus,
> >>>       };
> >>>       const char *cputype =3D NULL;
> >>>       const char *unit_name =3D NULL;
> >>> diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
> >>> index 3581710667b0..5073843aca19 100644
> >>> --- a/tools/perf/util/pmus.c
> >>> +++ b/tools/perf/util/pmus.c
> >>> @@ -275,6 +275,50 @@ struct perf_pmu *perf_pmus__scan_core(struct per=
f_pmu *pmu)
> >>>       return NULL;
> >>>  }
> >>>
> >>> +static struct perf_pmu *perf_pmus__scan_skip_duplicates(struct perf_=
pmu *pmu)
> >>> +{
> >>> +     bool use_core_pmus =3D !pmu || pmu->is_core;
> >>> +     int last_pmu_name_len =3D 0;
> >>> +     unsigned long last_pmu_num =3D 0;
> >>> +     const char *last_pmu_name =3D (pmu && pmu->name) ? pmu->name : =
"";
> >>> +
> >>> +     if (!pmu) {
> >>> +             pmu_read_sysfs(/*core_only=3D*/false);
> >>> +             pmu =3D list_prepare_entry(pmu, &core_pmus, list);
> >>> +     } else
> >>> +             last_pmu_name_len =3D pmu_name_len_no_suffix(pmu->name =
?: "", &last_pmu_num);
> >>> +
> >>> +     if (use_core_pmus) {
> >>> +             list_for_each_entry_continue(pmu, &core_pmus, list) {
> >>> +                     unsigned long pmu_num =3D 0;
> >>> +                     int pmu_name_len =3D pmu_name_len_no_suffix(pmu=
->name ?: "", &pmu_num);
> >>> +
> >>> +                     if (last_pmu_name_len =3D=3D pmu_name_len &&
> >>> +                         (last_pmu_num + 1 =3D=3D pmu_num) &&
> >>> +                         !strncmp(last_pmu_name, pmu->name ?: "", pm=
u_name_len)) {
> >>> +                             last_pmu_num++;
> >>> +                             continue;
> >>> +                     }
> >>> +                     return pmu;
> >>> +             }
> >>> +             pmu =3D NULL;
> >>> +             pmu =3D list_prepare_entry(pmu, &other_pmus, list);
> >>> +     }
> >>> +     list_for_each_entry_continue(pmu, &other_pmus, list) {
> >>> +             unsigned long pmu_num =3D 0;
> >>> +             int pmu_name_len =3D pmu_name_len_no_suffix(pmu->name ?=
: "", &pmu_num);
> >>> +
> >>> +             if (last_pmu_name_len =3D=3D pmu_name_len &&
> >>> +                 (last_pmu_num + 1 =3D=3D pmu_num) &&
> >>> +                 !strncmp(last_pmu_name, pmu->name ?: "", pmu_name_l=
en)) {
> >>> +                     last_pmu_num++;
> >>> +                     continue;
> >>> +             }
> >>> +             return pmu;
> >>> +     }
> >>> +     return NULL;
> >>> +}
> >>> +
> >>>  const struct perf_pmu *perf_pmus__pmu_for_pmu_filter(const char *str=
)
> >>>  {
> >>>       struct perf_pmu *pmu =3D NULL;
> >>> @@ -429,10 +473,16 @@ void perf_pmus__print_pmu_events(const struct p=
rint_callbacks *print_cb, void *p
> >>>       int printed =3D 0;
> >>>       int len, j;
> >>>       struct sevent *aliases;
> >>> +     struct perf_pmu *(*scan_fn)(struct perf_pmu *);
> >>> +
> >>> +     if (print_cb->skip_duplicate_pmus(print_state))
> >>> +             scan_fn =3D perf_pmus__scan_skip_duplicates;
> >>> +     else
> >>> +             scan_fn =3D perf_pmus__scan;
> >>>
> >>>       pmu =3D NULL;
> >>>       len =3D 0;
> >>> -     while ((pmu =3D perf_pmus__scan(pmu)) !=3D NULL) {
> >>> +     while ((pmu =3D scan_fn(pmu)) !=3D NULL) {
> >>>               list_for_each_entry(event, &pmu->aliases, list)
> >>>                       len++;
> >>>               if (pmu->selectable)
> >>> @@ -445,7 +495,7 @@ void perf_pmus__print_pmu_events(const struct pri=
nt_callbacks *print_cb, void *p
> >>>       }
> >>>       pmu =3D NULL;
> >>>       j =3D 0;
> >>> -     while ((pmu =3D perf_pmus__scan(pmu)) !=3D NULL) {
> >>> +     while ((pmu =3D scan_fn(pmu)) !=3D NULL) {
> >>>               bool is_cpu =3D pmu->is_core;
> >>>
> >>>               list_for_each_entry(event, &pmu->aliases, list) {
> >>> diff --git a/tools/perf/util/print-events.h b/tools/perf/util/print-e=
vents.h
> >>> index d7fab411e75c..bf4290bef0cd 100644
> >>> --- a/tools/perf/util/print-events.h
> >>> +++ b/tools/perf/util/print-events.h
> >>> @@ -26,6 +26,7 @@ struct print_callbacks {
> >>>                       const char *expr,
> >>>                       const char *threshold,
> >>>                       const char *unit);
> >>> +     bool (*skip_duplicate_pmus)(void *print_state);
> >>>  };
> >>>
> >>>  /** Print all events, the default when no options are specified. */
