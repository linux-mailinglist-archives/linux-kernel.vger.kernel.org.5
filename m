Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2CE811B70
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 18:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbjLMRm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 12:42:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233416AbjLMRmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 12:42:52 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13518118
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 09:42:53 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-54c77d011acso119a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 09:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702489371; x=1703094171; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8c1vfO/xiQwL2KaPxAY2duOQ0VAaarCuPQeeypzuUqU=;
        b=LFmT1avq7ovak0O+8q+vYPHDKH/H1sfe694dhfNTWQcIoAwhHhu6jJNsoSDEPOYLjK
         uZ/7LPm3IN49T8zW5++ely471Bf9pqRSNbp/bVgswatol+ORorH3bmFfpesHb1AQISvI
         s4KfbQDmsyIZiSOqItnPF71jDohae0iexUUnz42A36ZK6GflXDFlbBrAklR1Xb2Gjr/X
         I9NwQBEqwbqv2ONve/zHHzZuljKtPUAUa4+snAt07oGqaS0ezIKSVvhkZrOffLi3xJsw
         PA22YXZzt5EPu9cZ2x4heJU82R00ZlTXyeCqiupYdVgtyF2ObXfXQVaGVwfdllRjehit
         3+Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702489371; x=1703094171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8c1vfO/xiQwL2KaPxAY2duOQ0VAaarCuPQeeypzuUqU=;
        b=RnaGxvLkLNS4q8UjzSHgPEuzLydhdHZxzlg+GE1XcKI7CLmp0PACX0jqU/OpY6giV0
         tHsttcI3yZgbylJUsiurDmxL3Hjwd/NXyC62bdmGW1xbMR//Sw8FmmA+64274CaGjkc+
         LDHDC0rhxptm8vFzYz23kaKTq4nrrVNQntmDYV6xzq5e+jhxcaRBeW/PXmi0QcDCkezX
         myq3aJHc8WfQQqFC8Hjf8YsIHLhcb7byiFsw4jW7y384um4A9twe6vmAuR1/Vgjv2eIX
         hdI6UxiWGt/g60dVAUKPWI+ovyqkB+FFjJ40KF3Z1wUDKs1+dXeNYM4URXdURY3wIAVz
         mwjA==
X-Gm-Message-State: AOJu0YzcV/3+4Rp3VpKcGbKGiPy/SKrcdiVckqooa8flOnYpEvUQ1Nrb
        Z1l6/YvHQZ0gSN9VGtdhqSU5wPh7DANZzbUL/beZfg==
X-Google-Smtp-Source: AGHT+IEkooHYz6uTYfPKHTIZNMmFByCMi4JYabmYLfQyKyG5iUWbUNYGfzwzd5BekQa2oXCTyUaMnLVEDwkj+U8w5sg=
X-Received: by 2002:a50:c192:0:b0:54c:f4fd:3427 with SMTP id
 m18-20020a50c192000000b0054cf4fd3427mr530375edf.7.1702489371342; Wed, 13 Dec
 2023 09:42:51 -0800 (PST)
MIME-Version: 1.0
References: <20231212193833.415110-1-kan.liang@linux.intel.com>
 <CAP-5=fWCgjCC-DHHx+HJCuYk6vNn9Lf9EKcnBBZQ+xmnyYnmPg@mail.gmail.com>
 <996ec30b-2bcf-4739-bec0-728c7f7af2ac@linux.intel.com> <CAP-5=fVnH0eTEvvNbKLF9xYye5Pu8hvDL4ruoxh5xG76+B8WFQ@mail.gmail.com>
 <CAM9d7chQ4NbbcmumQSMRaGm987nxxh6_QbbJr7+GYgL_WAmaNw@mail.gmail.com> <43e57041-fe13-452a-af6e-db2ed451f93a@linux.intel.com>
In-Reply-To: <43e57041-fe13-452a-af6e-db2ed451f93a@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 13 Dec 2023 09:42:39 -0800
Message-ID: <CAP-5=fXHadLYuRkY2Z=kymWJkB63dBWfCibQJnwgt0wkSuVVsg@mail.gmail.com>
Subject: Re: [PATCH V2] perf top: Use evsel's cpus to replace user_requested_cpus
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, acme@kernel.org,
        mark.rutland@arm.com, maz@kernel.org, marcan@marcan.st,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
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

On Wed, Dec 13, 2023 at 7:45=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
>
>
>
> On 2023-12-12 8:06 p.m., Namhyung Kim wrote:
> > On Tue, Dec 12, 2023 at 2:12=E2=80=AFPM Ian Rogers <irogers@google.com>=
 wrote:
> >>
> >> On Tue, Dec 12, 2023 at 1:25=E2=80=AFPM Liang, Kan <kan.liang@linux.in=
tel.com> wrote:
> >>>
> >>>
> >>>
> >>> On 2023-12-12 3:37 p.m., Ian Rogers wrote:
> >>>> On Tue, Dec 12, 2023 at 11:39=E2=80=AFAM <kan.liang@linux.intel.com>=
 wrote:
> >>>>>
> >>>>> From: Kan Liang <kan.liang@linux.intel.com>
> >>>>>
> >>>>> perf top errors out on a hybrid machine
> >>>>>  $perf top
> >>>>>
> >>>>>  Error:
> >>>>>  The cycles:P event is not supported.
> >>>>>
> >>>>> The perf top expects that the "cycles" is collected on all CPUs in =
the
> >>>>> system. But for hybrid there is no single "cycles" event which can =
cover
> >>>>> all CPUs. Perf has to split it into two cycles events, e.g.,
> >>>>> cpu_core/cycles/ and cpu_atom/cycles/. Each event has its own CPU m=
ask.
> >>>>> If a event is opened on the unsupported CPU. The open fails. That's=
 the
> >>>>> reason of the above error out.
> >>>>>
> >>>>> Perf should only open the cycles event on the corresponding CPU. Th=
e
> >>>>> commit ef91871c960e ("perf evlist: Propagate user CPU maps intersec=
ting
> >>>>> core PMU maps") intersect the requested CPU map with the CPU map of=
 the
> >>>>> PMU. Use the evsel's cpus to replace user_requested_cpus.
> >>>>>
> >>>>> The evlist's threads are also propagated to the evsel's threads in
> >>>>> __perf_evlist__propagate_maps(). For a system-wide event, perf appe=
nds
> >>>>> a dummy event and assign it to the evsel's threads. For a per-threa=
d
> >>>>> event, the evlist's thread_map is assigned to the evsel's threads. =
The
> >>>>> same as the other tools, e.g., perf record, using the evsel's threa=
ds
> >>>>> when opening an event.
> >>>>>
> >>>>> Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> >>>>> Closes: https://lore.kernel.org/linux-perf-users/ZXNnDrGKXbEELMXV@k=
ernel.org/
> >>>>> Reviewed-by: Ian Rogers <irogers@google.com>
> >>>>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> >>>>> ---
> >>>>>
> >>>>> Changes since V1:
> >>>>> - Update the description
> >>>>> - Add Reviewed-by from Ian
> >>>>
> >>>> Thanks Kan, quick question. Does "perf top" on hybrid ask the user t=
o
> >>>> select between the cycles event on cpu_atom and cpu_core?
> >>>
> >>> Yes, but the event doesn't include the PMU information.
> >>> We probably need a follow up patch to append the PMU name.
> >>>
> >>> Available samples
> >>> 385 cycles:P
> >>>
> >>> 903 cycles:P
> >>
> >> Thanks and agreed, it isn't possible to tell which is which PMU/CPU
> >> type at the moment. I tried the patch with perf top --stdio, there
> >> wasn't a choice of event
>
> The perf top --stdio uses a dedicated display function, see
> perf_top__header_snprintf() in util/top.c
>
> It only shows one event at a time. "E" is used to switch the event.
>
> >> and I can't tell what counter is being
> >> displayed.
>
> For the hybrid case, I think we may display both PMU name and event
> name. For example,
>
> Available samples
> 656 cycles:P cpu_atom
>
> 701 cycles:P cpu_core

I think there would be more uniformity if we could do:
cpu/cycles/P
I'm just reminded of the stat output where sometimes you can get things lik=
e:
cpu/cycles/
or sometimes:
cycles [cpu]
It seems the slash style approach is the most uniform given it looks
like what is written on the command line. Perhaps we need some kind of
helper function to do this as reformatting the modifier is a pain.

> diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hist=
s.c
> index f4812b226818..afc7a1d54fe4 100644
> --- a/tools/perf/ui/browsers/hists.c
> +++ b/tools/perf/ui/browsers/hists.c
> @@ -3433,8 +3433,10 @@ static void perf_evsel_menu__write(struct
> ui_browser *browser,
>         }
>
>         nr_events =3D convert_unit(nr_events, &unit);
> -       printed =3D scnprintf(bf, sizeof(bf), "%lu%c%s%s", nr_events,
> -                          unit, unit =3D=3D ' ' ? "" : " ", ev_name);
> +       printed =3D scnprintf(bf, sizeof(bf), "%lu%c%s%s %s", nr_events,
> +                          unit, unit =3D=3D ' ' ? "" : " ", ev_name,
> +                          evsel->pmu ? evsel->pmu_name : "");
> +
>         ui_browser__printf(browser, "%s", bf);
>
>         nr_events =3D evsel->evlist->stats.nr_events[PERF_RECORD_LOST];
>
>
> >> When I quit I also see:
> >> ```
> >> exiting.
> >> corrupted double-linked list
> >> Aborted (core dumped)
> >> ```
> >> but I wasn't able to repro this on a debuggable binary/system.
>
> I haven't see the issue yet.
>
> >>
> >> If my memory serves there was a patch where perf top was showing >1
> >> event. It would be nice here to do some kind of hybrid merging rather
> >> than having to view each PMU's top separately.
>
> The current perf top doesn't merge when there are >1 event.
> sudo ./perf top -e "cycles,instructions"
>
> Available samples
> 2K cycles
>
> 2K instructions
>
> For now, I think we may just append a PMU name to distinguish the hybrid
> case.
>
> We may implement the merging feature which impacts both hybrid and
> non-hybrid cases later separately.
>
> >
> > Using event groups, but I noticed you removed the --group option.
> > Maybe perf top can just use `{ ... }` notation for explicit grouping,
> > but it might be implicit like in the hybrid case.
> >
>
> Yes, if the events are from different PMUs, the perf tool will
> implicitly de-group the hybrid events. "{ ... }" may not help here.

I think grouping may have been the situation where I saw >1 event
displayed but I agree with Kan, we implicitly de-group events on
different PMUs so it won't help here.

Thanks,
Ian

> Thanks,
> Kan
