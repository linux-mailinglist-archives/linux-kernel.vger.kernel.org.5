Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D077777BDA9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 18:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbjHNQKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 12:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbjHNQJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 12:09:54 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7742CF1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 09:09:53 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-3492e05be7cso315425ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 09:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692029393; x=1692634193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PKFeMrqK94GegmeRyLBOLbKgSzgcjuc1Zy3O5gheuo4=;
        b=iV9UjdSbjzQV3L1le1SIt6bGeG09fJBGkZd1RqGK8SnnX09iGjXK75tZMsSF/khidz
         maet11zIr9VIpgyAY39FeHpcS+kwLPjx4lOi8Z7HbmGIVNv6mgA1dzz8x9QM1SrIXmbQ
         yYsxEYTZ25D9KlWoqHKKgN5zr8EKpRd6g1/0fFkl0D7o6lORnJsrQrm/ET5TF2+8ZBxF
         Y47f+LTLp7Kpvvrn0TvVVCUUvVWC9Iu5WWv5zMJDVnXwwk+x541yAqJW26HprOA1XHZk
         E0QxTcsGXGguEESFlpxQ2GhEwyVBY6lbrpQ0hLtJ9pmNs4wooIMrLq0ewW7vMlb0vNrx
         Wn6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692029393; x=1692634193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PKFeMrqK94GegmeRyLBOLbKgSzgcjuc1Zy3O5gheuo4=;
        b=Hm44EkzmbFivFRUrVbMNrLOJRw/RU8mgecj4b86IW/X8Sbhl9+UmOMZd5ZPxOtH1hV
         K7ydfQuVUb9LgB4TxMPTzBqWOMVdgxvX2zG+yrMzQs0Lz1MejFDKdxLHxThd5cLYumfj
         FUxQHLizxQldi1rg8WnfiEyHidCYgHop0U2+hzr6U3pRiVLQJM4flHUJRinsBv5GZ0hM
         TB6+LiD8/MGQi8VtyMsWQy6yDUM1XSGkvgAvYlM6CbQ4ZAuUYx8v5ck+E7saxcRNPq+a
         TnXQjerOb7r02xJZrnU/8Wqi/V7F7g13ynhHNM6+lgHCR0v5GhWlT/dov/wSO4fcP/4D
         GUsg==
X-Gm-Message-State: AOJu0YwoAdmfKNyPryqjGFEbO5xb5nGoDAzdaMmRleFZeH5BOqgdSrEa
        OJmgX4YaoqBTy9zBxW3dRqBAMm4mmMRGPS1OMbQsdg==
X-Google-Smtp-Source: AGHT+IECmRu9rbOVBUjHK1aM8KuplVK6jt8ut2k82txZOnsMvj4e6RTF9cIVsJ1tC8ALtOBHSBmrCg92JmHcdKam9wQ=
X-Received: by 2002:a05:6e02:20c6:b0:349:7663:5669 with SMTP id
 6-20020a056e0220c600b0034976635669mr744757ilq.14.1692029392765; Mon, 14 Aug
 2023 09:09:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230810214952.2934029-1-irogers@google.com> <20230810214952.2934029-3-irogers@google.com>
 <0111c4b3-174b-84cb-2749-a88342b80498@oracle.com> <CAP-5=fWPUxOkOorOEiNSWPVhSxi+ANSR=_2rEzF_7hyS=3hF0Q@mail.gmail.com>
In-Reply-To: <CAP-5=fWPUxOkOorOEiNSWPVhSxi+ANSR=_2rEzF_7hyS=3hF0Q@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 14 Aug 2023 09:09:40 -0700
Message-ID: <CAP-5=fVOp-FcRR5oLvMVvb0R3sMgd=qnORwZGwdK1BbcqOBhHA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] perf pmus: Add scan that ignores duplicates, use
 for perf list
To:     John Garry <john.g.garry@oracle.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Kajol Jain <kjain@linux.ibm.com>,
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

On Mon, Aug 14, 2023 at 8:57=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> On Fri, Aug 11, 2023 at 8:51=E2=80=AFAM John Garry <john.g.garry@oracle.c=
om> wrote:
> >
> > On 10/08/2023 22:49, Ian Rogers wrote:
> > > When there are multiple PMUs that differ only by suffix, by default
> > > just list the first one and skip all others. As the PMUs are sorted,
> > > the scan routine checks that the PMU names match and the numbers are
> > > consecutive. If "-v" is passed to "perf list" then list all PMUs.
> >
> > I really think that this should be merged with the next change. I don't
> > like the intermediate step of by default only printing the first PMU.
>
> Ack. I'll leave it as 3 patches and then leave it to Arnaldo squash as
> quite often he wants more patches.
>
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >   tools/perf/builtin-list.c      |  8 +++++
> > >   tools/perf/util/pmus.c         | 54 +++++++++++++++++++++++++++++++=
+--
> > >   tools/perf/util/print-events.h |  1 +
> > >   3 files changed, 61 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
> > > index 7fec2cca759f..8fe4ddf02c14 100644
> > > --- a/tools/perf/builtin-list.c
> > > +++ b/tools/perf/builtin-list.c
> > > @@ -423,6 +423,13 @@ static void json_print_metric(void *ps __maybe_u=
nused, const char *group,
> > >       strbuf_release(&buf);
> > >   }
> > >
> > > +static bool default_skip_duplicate_pmus(void *ps)
> > > +{
> > > +     struct print_state *print_state =3D ps;
> > > +
> > > +     return !print_state->long_desc;
> > > +}
> > > +
> > >   int cmd_list(int argc, const char **argv)
> > >   {
> > >       int i, ret =3D 0;
> > > @@ -434,6 +441,7 @@ int cmd_list(int argc, const char **argv)
> > >               .print_end =3D default_print_end,
> > >               .print_event =3D default_print_event,
> > >               .print_metric =3D default_print_metric,
> > > +             .skip_duplicate_pmus =3D default_skip_duplicate_pmus,
> > >       };
> > >       const char *cputype =3D NULL;
> > >       const char *unit_name =3D NULL;
> > > diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
> > > index 3581710667b0..5073843aca19 100644
> > > --- a/tools/perf/util/pmus.c
> > > +++ b/tools/perf/util/pmus.c
> > > @@ -275,6 +275,50 @@ struct perf_pmu *perf_pmus__scan_core(struct per=
f_pmu *pmu)
> > >       return NULL;
> > >   }
> > >
> > > +static struct perf_pmu *perf_pmus__scan_skip_duplicates(struct perf_=
pmu *pmu)
> > > +{
> > > +     bool use_core_pmus =3D !pmu || pmu->is_core;
> > > +     int last_pmu_name_len =3D 0;
> > > +     unsigned long last_pmu_num =3D 0;
> > > +     const char *last_pmu_name =3D (pmu && pmu->name) ? pmu->name : =
"";
> > > +
> > > +     if (!pmu) {
> > > +             pmu_read_sysfs(/*core_only=3D*/false);
> > > +             pmu =3D list_prepare_entry(pmu, &core_pmus, list);
> > > +     } else
> > > +             last_pmu_name_len =3D pmu_name_len_no_suffix(pmu->name =
?: "", &last_pmu_num);
> > > +
> > > +     if (use_core_pmus) {
> > > +             list_for_each_entry_continue(pmu, &core_pmus, list) {
> > > +                     unsigned long pmu_num =3D 0;
> > > +                     int pmu_name_len =3D pmu_name_len_no_suffix(pmu=
->name ?: "", &pmu_num);
> > > +
> > > +                     if (last_pmu_name_len =3D=3D pmu_name_len &&
> > > +                         (last_pmu_num + 1 =3D=3D pmu_num) &&
> > > +                         !strncmp(last_pmu_name, pmu->name ?: "", pm=
u_name_len)) {
> > > +                             last_pmu_num++;
> > > +                             continue;
> > > +                     }
> > > +                     return pmu;
> > > +             }
> > > +             pmu =3D NULL;
> >
> > you assign pmu NULL
> >
> > > +             pmu =3D list_prepare_entry(pmu, &other_pmus, list);
> >
> > and then re-assign it. If list_prepare_entry() needs first arg =3D NULL=
,
> > then can just use NULL explicitly?
>
> Done.

So because of the macro magic in list_prepare_entry you can't
explicitly pass NULL here as doing so yields:
tools/include/linux/kernel.h:36:33: error: request for member =E2=80=98list=
=E2=80=99
in something not a structure or union
  36 |         const typeof(((type *)0)->member) * __mptr =3D (ptr);     \
      |                                 ^~

Thanks,
Ian

> > > +     }
> > > +     list_for_each_entry_continue(pmu, &other_pmus, list) {
> > > +             unsigned long pmu_num =3D 0;
> > > +             int pmu_name_len =3D pmu_name_len_no_suffix(pmu->name ?=
: "", &pmu_num);
> > > +
> > > +             if (last_pmu_name_len =3D=3D pmu_name_len &&
> > > +                 (last_pmu_num + 1 =3D=3D pmu_num) &&
> > > +                 !strncmp(last_pmu_name, pmu->name ?: "", pmu_name_l=
en)) {
> > > +                     last_pmu_num++;
> > > +                     continue;
> >
> > Can some of this code be factored out from the previous patch? It's
> > doing something similar, right?
>
> The previous patch implemented list sorting and a list comparator
> whilst this patch is skipping PMUs if they follow the pattern:
> uncore_xyz_0
> uncore_xyz_1 <- skip
> uncore_xyz_2 <- skip
> The pmu_name_len_no_suffix is factored out and shared between both
> routines. The comparator doesn't maintain state whilst this code does.
> So I don't see a way to refactor things further.
>
> Thanks,
> Ian
>
> > > +             }
> > > +             return pmu;
> > > +     }
> > > +     return NULL;
> > > +}
> > > +
> > >   const struct perf_pmu *perf_pmus__pmu_for_pmu_filter(const char *st=
r)
> > >   {
> > >       struct perf_pmu *pmu =3D NULL;
> > > @@ -429,10 +473,16 @@ void perf_pmus__print_pmu_events(const struct p=
rint_callbacks *print_cb, void *p
> > >       int printed =3D 0;
> > >       int len, j;
> > >       struct sevent *aliases;
> > > +     struct perf_pmu *(*scan_fn)(struct perf_pmu *);
> > > +
> > > +     if (print_cb->skip_duplicate_pmus(print_state))
> > > +             scan_fn =3D perf_pmus__scan_skip_duplicates;
> > > +     else
> > > +             scan_fn =3D perf_pmus__scan;
> > >
> > >       pmu =3D NULL;
> > >       len =3D 0;
> > > -     while ((pmu =3D perf_pmus__scan(pmu)) !=3D NULL) {
> > > +     while ((pmu =3D scan_fn(pmu)) !=3D NULL) {
> > >               list_for_each_entry(event, &pmu->aliases, list)
> > >                       len++;
> > >               if (pmu->selectable)
> > > @@ -445,7 +495,7 @@ void perf_pmus__print_pmu_events(const struct pri=
nt_callbacks *print_cb, void *p
> > >       }
> > >       pmu =3D NULL;
> > >       j =3D 0;
> > > -     while ((pmu =3D perf_pmus__scan(pmu)) !=3D NULL) {
> > > +     while ((pmu =3D scan_fn(pmu)) !=3D NULL) {
> > >               bool is_cpu =3D pmu->is_core;
> > >
> > >               list_for_each_entry(event, &pmu->aliases, list) {
> > > diff --git a/tools/perf/util/print-events.h b/tools/perf/util/print-e=
vents.h
> > > index d7fab411e75c..bf4290bef0cd 100644
> > > --- a/tools/perf/util/print-events.h
> > > +++ b/tools/perf/util/print-events.h
> > > @@ -26,6 +26,7 @@ struct print_callbacks {
> > >                       const char *expr,
> > >                       const char *threshold,
> > >                       const char *unit);
> > > +     bool (*skip_duplicate_pmus)(void *print_state);
> > >   };
> > >
> > >   /** Print all events, the default when no options are specified. */
> >
