Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FAB7759C1E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 19:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbjGSRM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 13:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbjGSRMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 13:12:24 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 533B1B7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 10:12:21 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-4036bd4fff1so13561cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 10:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689786740; x=1692378740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kq4j2u46wil1ke52/+CnH14UkMUz/ytY53Ok+bsM5GU=;
        b=g0G8X70teAAyZAkWLbF+vMVfO9L+y6n6bG9NPwGSQjxwF9XQotP1lv3E+QtiNY5MA2
         c0Dl0ngaWR1XjW/zN/6b7vkG3crrJchcrY9kW4CIV6g1DlbIoCGiTdupuhzopptu8UP6
         Sr2i5TE0/KdV4Vo1dldATPTOwaLneY0OEylRQ3C2yTmbuiWW9hbXj78yDp0OdDS8xSPO
         aJP82uERjhVWq51Izw9hIcQLt2St+GQrvU4uFLJTU0QSSINcWNV3FDxOmeunD/rmJBR0
         fAsofRX99qObnVIGeCF7UMOHUPB3xpfydRd8YiCAVLWd265F/vcs5O4eaFcwanaeGxeG
         oXmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689786740; x=1692378740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kq4j2u46wil1ke52/+CnH14UkMUz/ytY53Ok+bsM5GU=;
        b=hCyAeAD3TkrzHFroGm7aLKERYd9h6F7JPDAn+sRkjoZc+XE0gY/tuss/BATwwyGxpU
         O+45rxW4E06nhfMPmJrBw2wpk+Pyp851SL7cAekVU76+1siiCvHaGdFAx9P5AFHqdsjP
         00C4EH2yhr7+ozmzLvTJhJmHk4HLH5p/kYq/poSG/i/qlys8t6DCJjGmtw+l9WwAlaPJ
         tPb87xATyMRyDIVrONTw8P97oPp5gfGNcoX44sCTvZV27MA+IZ915VJJf5oF/aVXUlMM
         U9y/7BdycnB8W1b+WZUp/tH3BHz8jAZBImO+Ynh+hrEySMoieai+opSHTuRNHOiG/9+1
         EzzQ==
X-Gm-Message-State: ABy/qLY1RLNrQTpTnAkbRxVV1jY1uJ4PYI+4qBPwsLDcg1Iz4dbTASMg
        RxyFPcFRN8AHqW/c5ERHaX2TAjYjEWffiDA6NwQdlg==
X-Google-Smtp-Source: APBJJlHpQOYSzqxXGuzVcbYnlfuvIArb0O9nLkJXBcX5vlTL4it/Or3f2kwpGFNjpS52wab4u61zvzTR0OpGHXS145U=
X-Received: by 2002:ac8:7fca:0:b0:403:b242:3e30 with SMTP id
 b10-20020ac87fca000000b00403b2423e30mr623248qtk.1.1689786740368; Wed, 19 Jul
 2023 10:12:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230715032915.97146-1-yangjihong1@huawei.com>
 <20230715032915.97146-3-yangjihong1@huawei.com> <CAP-5=fVysKhUn1YsUr0NBU2kVBDgkoczO861XwK5VCtkeYSRJA@mail.gmail.com>
 <085942cc-f6e7-a81b-243f-a739c91ecd72@intel.com>
In-Reply-To: <085942cc-f6e7-a81b-243f-a739c91ecd72@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 19 Jul 2023 10:12:09 -0700
Message-ID: <CAP-5=fVmKmgsABpnsngT9L1QeaWaUxakHc1078LahGFqK4-riA@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] perf evlist: Add evlist__findnew_tracking_event() helper
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Yang Jihong <yangjihong1@huawei.com>, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, kan.liang@linux.intel.com,
        james.clark@arm.com, tmricht@linux.ibm.com, ak@linux.intel.com,
        anshuman.khandual@arm.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 9:59=E2=80=AFAM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> On 19/07/23 19:44, Ian Rogers wrote:
> > On Fri, Jul 14, 2023 at 8:31=E2=80=AFPM Yang Jihong <yangjihong1@huawei=
.com> wrote:
> >>
> >> Currently, intel-bts, intel-pt, and arm-spe may add a dummy event for
> >> tracking to the evlist. We may need to search for the dummy event for
> >> some settings. Therefore, add evlist__findnew_tracking_event() helper.
> >>
> >> evlist__findnew_tracking_event() also deal with system_wide maps if
> >> system_wide is true.
> >
> > I'm wondering if we can simplify the naming in the API, we have "dummy
> > event" which makes sense as we literally call the event "dummy",
> > "sideband" which refers to the kind of samples/events the dummy event
> > will record but "tracking" I think tends to get used as a verb rather
> > than a noun. So I think evlist__findnew_tracking_event should be
> > evlist__findnew_dummy_event.
>
> Except the tracking event has "tracking" set but there can be other dummy
> events that do not.

Thanks! I'm wondering what a dummy event without tracking would be
used for - do you have a reference? I don't see anything in
perf_event.h calling things like mmap2/comm in perf_event_attr
tracking. I'm not a fan of dummy due to it not being intention
revealing. Perhaps if we could go back in time  we could call the
event "sideband", maybe we should migrate to this. We have other
non-obvious uses of the term dummy like in cpumap:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/lib/perf/include/perf/cpumap.h?h=3Dperf-tools-next#n24
If tracking can be on any event then does that make the functions
behavior more ambiguous if it means dummy+tracking not <any
event>+tracking?

Thanks,
Ian

> >
> > Thanks,
> > Ian
> >
> >> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> >> ---
> >>  tools/perf/builtin-record.c | 11 +++--------
> >>  tools/perf/util/evlist.c    | 18 ++++++++++++++++++
> >>  tools/perf/util/evlist.h    |  1 +
> >>  3 files changed, 22 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> >> index aec18db7ff23..ca83599cc50c 100644
> >> --- a/tools/perf/builtin-record.c
> >> +++ b/tools/perf/builtin-record.c
> >> @@ -1295,14 +1295,9 @@ static int record__open(struct record *rec)
> >>          */
> >>         if (opts->target.initial_delay || target__has_cpu(&opts->targe=
t) ||
> >>             perf_pmus__num_core_pmus() > 1) {
> >> -               pos =3D evlist__get_tracking_event(evlist);
> >> -               if (!evsel__is_dummy_event(pos)) {
> >> -                       /* Set up dummy event. */
> >> -                       if (evlist__add_dummy(evlist))
> >> -                               return -ENOMEM;
> >> -                       pos =3D evlist__last(evlist);
> >> -                       evlist__set_tracking_event(evlist, pos);
> >> -               }
> >> +               pos =3D evlist__findnew_tracking_event(evlist, false);
> >> +               if (!pos)
> >> +                       return -ENOMEM;
> >>
> >>                 /*
> >>                  * Enable the dummy event when the process is forked f=
or
> >> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> >> index 7ef43f72098e..25c3ebe2c2f5 100644
> >> --- a/tools/perf/util/evlist.c
> >> +++ b/tools/perf/util/evlist.c
> >> @@ -1694,6 +1694,24 @@ void evlist__set_tracking_event(struct evlist *=
evlist, struct evsel *tracking_ev
> >>         tracking_evsel->tracking =3D true;
> >>  }
> >>
> >> +struct evsel *evlist__findnew_tracking_event(struct evlist *evlist, b=
ool system_wide)
> >> +{
> >> +       struct evsel *evsel;
> >> +
> >> +       evsel =3D evlist__get_tracking_event(evlist);
> >> +       if (!evsel__is_dummy_event(evsel)) {
> >> +               evsel =3D evlist__add_aux_dummy(evlist, system_wide);
> >> +               if (!evsel)
> >> +                       return NULL;
> >> +
> >> +               evlist__set_tracking_event(evlist, evsel);
> >> +       } else if (system_wide) {
> >> +               perf_evlist__go_system_wide(&evlist->core, &evsel->cor=
e);
> >> +       }
> >> +
> >> +       return evsel;
> >> +}
> >> +
> >>  struct evsel *evlist__find_evsel_by_str(struct evlist *evlist, const =
char *str)
> >>  {
> >>         struct evsel *evsel;
> >> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> >> index 664c6bf7b3e0..98e7ddb2bd30 100644
> >> --- a/tools/perf/util/evlist.h
> >> +++ b/tools/perf/util/evlist.h
> >> @@ -387,6 +387,7 @@ bool evlist_cpu_iterator__end(const struct evlist_=
cpu_iterator *evlist_cpu_itr);
> >>
> >>  struct evsel *evlist__get_tracking_event(struct evlist *evlist);
> >>  void evlist__set_tracking_event(struct evlist *evlist, struct evsel *=
tracking_evsel);
> >> +struct evsel *evlist__findnew_tracking_event(struct evlist *evlist, b=
ool system_wide);
> >>
> >>  struct evsel *evlist__find_evsel_by_str(struct evlist *evlist, const =
char *str);
> >>
> >> --
> >> 2.30.GIT
> >>
>
