Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 828B880FA55
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 23:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbjLLWMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 17:12:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbjLLWMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 17:12:35 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374D3BC
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 14:12:41 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-551d5cd1c42so4485a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 14:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702419159; x=1703023959; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cks51YM0UKyckZloGW9xq/gv3l7nlcfYyHgSc2Hh0TE=;
        b=WUEXeLyI9BlooXxN2HXT4S6bSA3hhuVCeVQwIifG4XAIT6B4+L8K9gk8iHyT3+nzzo
         VZ3Gav/uV1nwNhy9a3aKByLan3AWQFKMwMleN1jTwr65NYBlqnp4pr8Ws98piRKNHu2V
         kXyr5cHjKtlQ4SjLWS7i0J+R5rziHsh+cT+j8JIyxc3M925BGwdUcItzg7YcjGcPomus
         T2XL6bQ1fA0RTEBJlL6Z5ueUwaBNvFxpMKuOA+7rYscHSdxEsGKpZPoegWZjBs+KNSJD
         5QbnoQOF5DuN1sAzCpjQKpryS4M+T5Se5w+84n1CMON70GoDarVWDhFzwar2RaNyIPAT
         C/NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702419159; x=1703023959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cks51YM0UKyckZloGW9xq/gv3l7nlcfYyHgSc2Hh0TE=;
        b=msArUGZjEPkex+hYx2mEovnqSmbWYd5/5jtLv+MR1SImGtq4k21GJ2Uj7q/srEk5yy
         rvCDZTTFaM/NICM8VY3KbsBUeDssfI51XCMd4hQv1K/GTJ4n+b+D09ERMItgzwxuWj6A
         M21aQYIEV3ihJ4DeFuf2DOo5pYgU9/xKW42b+Ow9cXrKqK0ZPTofERzOhcG0vWREe9ya
         BMmml7XNb77xj9RUJyN/w6++Xp8bbvodd5cdpp5ELyyviryoCQ4C/470vLimw8w7gzJA
         Zn6eaMiVGhZo8xifkLPT5s8ImnV00kmtIOx4k4zgTQS6v51Jkhawru+4KV+mMA2tZL+b
         6rhg==
X-Gm-Message-State: AOJu0YxgYsUMvffzoozB4t6Ec8Vi9RsT2v/MjS/V85aCce8GY2H3NBd2
        TTqZNsdFCV6NYAtHj9GeY0KMvTnoy4UJyMZu6gQk8g==
X-Google-Smtp-Source: AGHT+IF3yLnso16rdyhcMLLN9D0e3Wjogglt21LQD5Hss1z5ysbNndCPVrF7FCR53v1hYWLvdC1D9AEWOUEiGoK+COk=
X-Received: by 2002:aa7:d4d6:0:b0:551:d490:2748 with SMTP id
 t22-20020aa7d4d6000000b00551d4902748mr78706edr.5.1702419159394; Tue, 12 Dec
 2023 14:12:39 -0800 (PST)
MIME-Version: 1.0
References: <20231212193833.415110-1-kan.liang@linux.intel.com>
 <CAP-5=fWCgjCC-DHHx+HJCuYk6vNn9Lf9EKcnBBZQ+xmnyYnmPg@mail.gmail.com> <996ec30b-2bcf-4739-bec0-728c7f7af2ac@linux.intel.com>
In-Reply-To: <996ec30b-2bcf-4739-bec0-728c7f7af2ac@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 12 Dec 2023 14:12:27 -0800
Message-ID: <CAP-5=fVnH0eTEvvNbKLF9xYye5Pu8hvDL4ruoxh5xG76+B8WFQ@mail.gmail.com>
Subject: Re: [PATCH V2] perf top: Use evsel's cpus to replace user_requested_cpus
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
        maz@kernel.org, marcan@marcan.st, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 1:25=E2=80=AFPM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
>
>
>
> On 2023-12-12 3:37 p.m., Ian Rogers wrote:
> > On Tue, Dec 12, 2023 at 11:39=E2=80=AFAM <kan.liang@linux.intel.com> wr=
ote:
> >>
> >> From: Kan Liang <kan.liang@linux.intel.com>
> >>
> >> perf top errors out on a hybrid machine
> >>  $perf top
> >>
> >>  Error:
> >>  The cycles:P event is not supported.
> >>
> >> The perf top expects that the "cycles" is collected on all CPUs in the
> >> system. But for hybrid there is no single "cycles" event which can cov=
er
> >> all CPUs. Perf has to split it into two cycles events, e.g.,
> >> cpu_core/cycles/ and cpu_atom/cycles/. Each event has its own CPU mask=
.
> >> If a event is opened on the unsupported CPU. The open fails. That's th=
e
> >> reason of the above error out.
> >>
> >> Perf should only open the cycles event on the corresponding CPU. The
> >> commit ef91871c960e ("perf evlist: Propagate user CPU maps intersectin=
g
> >> core PMU maps") intersect the requested CPU map with the CPU map of th=
e
> >> PMU. Use the evsel's cpus to replace user_requested_cpus.
> >>
> >> The evlist's threads are also propagated to the evsel's threads in
> >> __perf_evlist__propagate_maps(). For a system-wide event, perf appends
> >> a dummy event and assign it to the evsel's threads. For a per-thread
> >> event, the evlist's thread_map is assigned to the evsel's threads. The
> >> same as the other tools, e.g., perf record, using the evsel's threads
> >> when opening an event.
> >>
> >> Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> >> Closes: https://lore.kernel.org/linux-perf-users/ZXNnDrGKXbEELMXV@kern=
el.org/
> >> Reviewed-by: Ian Rogers <irogers@google.com>
> >> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> >> ---
> >>
> >> Changes since V1:
> >> - Update the description
> >> - Add Reviewed-by from Ian
> >
> > Thanks Kan, quick question. Does "perf top" on hybrid ask the user to
> > select between the cycles event on cpu_atom and cpu_core?
>
> Yes, but the event doesn't include the PMU information.
> We probably need a follow up patch to append the PMU name.
>
> Available samples
> 385 cycles:P
>
> 903 cycles:P

Thanks and agreed, it isn't possible to tell which is which PMU/CPU
type at the moment. I tried the patch with perf top --stdio, there
wasn't a choice of event  and I can't tell what counter is being
displayed. When I quit I also see:
```
exiting.
corrupted double-linked list
Aborted (core dumped)
```
but I wasn't able to repro this on a debuggable binary/system.

If my memory serves there was a patch where perf top was showing >1
event. It would be nice here to do some kind of hybrid merging rather
than having to view each PMU's top separately.

Thanks,
Ian


> Thanks,
> Kan
>
> > I'm
> > wondering if there is some kind of missing "hybrid-merge"
> > functionality like we have for perf stat.
> >
> > Thanks,
> > Ian
> >
> >>  tools/perf/builtin-top.c | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> >> index ea8c7eca5eee..cce9350177e2 100644
> >> --- a/tools/perf/builtin-top.c
> >> +++ b/tools/perf/builtin-top.c
> >> @@ -1027,8 +1027,8 @@ static int perf_top__start_counters(struct perf_=
top *top)
> >>
> >>         evlist__for_each_entry(evlist, counter) {
> >>  try_again:
> >> -               if (evsel__open(counter, top->evlist->core.user_reques=
ted_cpus,
> >> -                                    top->evlist->core.threads) < 0) {
> >> +               if (evsel__open(counter, counter->core.cpus,
> >> +                               counter->core.threads) < 0) {
> >>
> >>                         /*
> >>                          * Specially handle overwrite fall back.
> >> --
> >> 2.35.1
> >>
