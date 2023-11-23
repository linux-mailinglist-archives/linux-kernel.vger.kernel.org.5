Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE3FF7F6292
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 16:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346040AbjKWPTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 10:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346027AbjKWPTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 10:19:09 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B3CD64
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 07:19:11 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40b367a0a12so45345e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 07:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700752750; x=1701357550; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W8EER9QnJqkumjnFgzfIvSmla3jT9/1jSEcUC70mpfk=;
        b=LqcjHl8pWD95aGcFW3rtx0O1Jdx8glvUEATkQTvlmIG3ph3fSi1d8dJbfbie9i8ClR
         TDxp+60oCQRFaZtMZzhRAk/LmtokbgCfv4Y0OY6821mk6vc514vOuQX3ApwaXYBt1cOv
         OZhmZMRZIK/mIhyvP+nKT/HKG7pPPYzmpCxXZj2nDCHgGeqR3D301Prw1wnHL/SM5NYr
         EGlepV+qaJoprW4n5H/9o7DihtI3uqlk2E/togDhUn5HzgaJOlokxC+y86XT+SrI8XGK
         fwqPN1d9Oi5W3wANomy9wzf592PpUUB9TF4F3PFXs+z5IjRiHhUoQswYqLb92GjN6/YI
         QbRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700752750; x=1701357550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W8EER9QnJqkumjnFgzfIvSmla3jT9/1jSEcUC70mpfk=;
        b=ozOks6PRK8izocXR6BD53H41Zsle2xQkiFqoFFI7DEYGQCtaGoT8sbwuC74/pi6UKp
         n9Sc0OHNNv/CS1VocnaPsHiPrF/Y/QUJ4W1pBsNKkxRMsMan8wwuCueoFGnOBOtX1HTC
         PPMxNHGaK5mcUfphU7Dn/Oj/+tNpy7oJY4mux1jIenI25rjKvyW01XSY2kYcjTmAnAe+
         WgjG0PXdElArBpbMwrmBcb0uNTlJjocDcYnDlvuVkK0mN796aNHbh2aPFlebyjlZfPsl
         m5d7GiJerBjjqyprgXp4el/EHNB8tbJirneyR0MHLS0NSdJQwcVs0jhXileIEiVigxDU
         YmFg==
X-Gm-Message-State: AOJu0YxJKNRkBTg42BUFTwwcYTbIpWLpHfwLYDJ9zhA6kHhWjdkAuGmA
        O208RAtXOgA7n7C63A5CPzXwdckcmLLwzeM3/xTotw==
X-Google-Smtp-Source: AGHT+IE22+wIunmt4ME8/EXH+rLKnhwCJ5wJJx0Qv7IkMA9iPqNyqgDVx/c303tAq4pgZXqiRdxMlGS3BtabQxclRQk=
X-Received: by 2002:a05:600c:3b89:b0:3f7:3e85:36a with SMTP id
 n9-20020a05600c3b8900b003f73e85036amr244322wms.7.1700752749772; Thu, 23 Nov
 2023 07:19:09 -0800 (PST)
MIME-Version: 1.0
References: <20231123042922.834425-1-irogers@google.com> <ZV9jq1C0TUh8MbeU@FVFF77S0Q05N.cambridge.arm.com>
In-Reply-To: <ZV9jq1C0TUh8MbeU@FVFF77S0Q05N.cambridge.arm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 23 Nov 2023 07:18:57 -0800
Message-ID: <CAP-5=fV3_UamHcGusUVyo23OW6tRnmSc_tohuDf1KTf4F_os1g@mail.gmail.com>
Subject: Re: [RFC PATCH v1] perf parse-events: Make legacy events lower
 priority than sysfs/json
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Marc Zyngier <maz@kernel.org>, Hector Martin <marcan@marcan.st>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Thu, Nov 23, 2023 at 6:37=E2=80=AFAM Mark Rutland <mark.rutland@arm.com>=
 wrote:
>
>
> Hi Ian,
>
> Thanks for this!
>
> On Wed, Nov 22, 2023 at 08:29:22PM -0800, Ian Rogers wrote:
> > The perf tool has previously made legacy events the priority so with
> > or without a PMU the legacy event would be opened:
> >
> > ```
> > $ perf stat -e cpu-cycles,cpu/cpu-cycles/ true
> > Using CPUID GenuineIntel-6-8D-1
> > intel_pt default config: tsc,mtc,mtc_period=3D3,psb_period=3D3,pt,branc=
h
> > Attempting to add event pmu 'cpu' with 'cpu-cycles,' that may result in=
 non-fatal errors
> > After aliases, add event pmu 'cpu' with 'cpu-cycles,' that may result i=
n non-fatal errors
> > Control descriptor is not initialized
> > ------------------------------------------------------------
> > perf_event_attr:
> >   type                             0 (PERF_TYPE_HARDWARE)
> >   size                             136
> >   config                           0 (PERF_COUNT_HW_CPU_CYCLES)
> >   sample_type                      IDENTIFIER
> >   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNIN=
G
> >   disabled                         1
> >   inherit                          1
> >   enable_on_exec                   1
> >   exclude_guest                    1
> > ------------------------------------------------------------
> > sys_perf_event_open: pid 833967  cpu -1  group_fd -1  flags 0x8 =3D 3
> > ------------------------------------------------------------
> > perf_event_attr:
> >   type                             0 (PERF_TYPE_HARDWARE)
> >   size                             136
> >   config                           0 (PERF_COUNT_HW_CPU_CYCLES)
> >   sample_type                      IDENTIFIER
> >   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNIN=
G
> >   disabled                         1
> >   inherit                          1
> >   enable_on_exec                   1
> >   exclude_guest                    1
> > ------------------------------------------------------------
> > ...
> > ```
> >
> > Fixes to make hybrid/BIG.little PMUs behave correctly, ie as core PMUs
> > capable of opening legacy events on each, removing hard coded
> > "cpu_core" and "cpu_atom" Intel PMU names, etc. caused a behavioral
> > difference on Apple/ARM due to latent issues in the PMU driver
> > reported in:
> > https://lore.kernel.org/lkml/08f1f185-e259-4014-9ca4-6411d5c1bc65@marca=
n.st/
> >
> > As part of that report Mark Rutland <mark.rutland@arm.com> requested
> > that legacy events not be higher in priority when a PMU is specified
> > reversing what has until this change been perf's default
> > behavior. With this change the above becomes:
> >
> > ```
> > $ perf stat -e cpu-cycles,cpu/cpu-cycles/ true
> > Using CPUID GenuineIntel-6-8D-1
> > Attempt to add: cpu/cpu-cycles=3D0/
> > ..after resolving event: cpu/event=3D0x3c/
> > Control descriptor is not initialized
> > ------------------------------------------------------------
> > perf_event_attr:
> >   type                             0 (PERF_TYPE_HARDWARE)
> >   size                             136
> >   config                           0 (PERF_COUNT_HW_CPU_CYCLES)
> >   sample_type                      IDENTIFIER
> >   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNIN=
G
> >   disabled                         1
> >   inherit                          1
> >   enable_on_exec                   1
> >   exclude_guest                    1
> > ------------------------------------------------------------
> > sys_perf_event_open: pid 827628  cpu -1  group_fd -1  flags 0x8 =3D 3
> > ------------------------------------------------------------
> > perf_event_attr:
> >   type                             4 (PERF_TYPE_RAW)
> >   size                             136
> >   config                           0x3c
> >   sample_type                      IDENTIFIER
> >   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNIN=
G
> >   disabled                         1
> >   inherit                          1
> >   enable_on_exec                   1
> >   exclude_guest                    1
> > ------------------------------------------------------------
> > ...
> > ```
> >
> > So the second event has become a raw event as
> > /sys/devices/cpu/events/cpu-cycles exists.
> >
> > A fix was necessary to config_term_pmu in parse-events.c as
> > check_alias expansion needs to happen after config_term_pmu, and
> > config_term_pmu may need calling a second time because of this.
> >
> > config_term_pmu is updated to not use the legacy event when the PMU
> > has such a named event (either from json or sysfs).
> >
> > The bulk of this change is updating all of the parse-events test
> > expectations so that if a sysfs/json event exists for a PMU the test
> > doesn't fail - a further sign, if it were needed, that the legacy
> > event priority was a known and tested behavior of the perf tool.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
>
> Regardless of my comments below, for this patch as-is:
>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
>
> > ---
> > This is a large behavioral change:
> > 1) the scope of the change means it should bake on linux-next and I
> > don't believe should be a 6.7-rc fix.
>
> I'm happy for this to bake, but I do think it needs to be backported for =
the
> sake of users, especially given that it *restores* the old behaviour.

It is going to change the behavior for a far larger set of users. I'm
also concerned that:

```
$ perf list
...
  cpu-cycles OR cpu/cpu-cycles/                      [Kernel PMU event]
...
```

implies that cpu/cpu-cycles/ is a synonym for cpu-cycles, which is no
longer true (or pick another event from sysfs whose name is the same
as a legacy event). I'm not sure what a fix in perf list for this
would look like.

Thanks,
Ian

> > 2) a fixes tag and stable backport I don't think are appropriate.
>
> For the sake of users I think a fixes tag and stable backport are necssar=
y. In
> practice distributions ship the perf tool associated with their stable ke=
rnel,
> so (for better or worse) a stable backport is certainly necessary for dis=
tros
> that'll use the v6.6 stable kernel.
>
> > The real reported issue is with the PMU driver.
>
> Having trawled through the driver and core perf code, I don't believe the=
 PMU
> driver is at fault. Please see my analysis at:
>
>   https://lore.kernel.org/lkml/ZV9gThJ52slPHqlV@FVFF77S0Q05N.cambridge.ar=
m.com/
>
> ... where it looks like the perf tool is dropping the extended type ID in=
 some
> cases.
>
> If you know of a specific bug in the PMU driver or perf core code, please=
 let
> me know and I will investigate. As it stands we have no evidence of a bug=
 in
> the PMU driver, and pretty clear evidence (as linked above) there there i=
s
> *some* issue in userspace. In the absence of such evidence, please don't =
assert
> that there must be a kernel bug.
>
> > A backport would bring the
> > risk that later fixes, due to the large behavior change, wouldn't be
> > backported and past releases get regressed in scenarios like
> > hybrid. Backports for the perf tool are also less necessary than say a
> > buggy PMU driver, as distributions should be updating to the latest
> > perf tool regardless of what Linux kernel is being run (the perf tool
> > is backward compatible).
>
> As above I believe that a backport is necessary.
>
> Thanks,
> Mark.
>
> > ---
> >  tools/perf/tests/parse-events.c | 256 +++++++++++++++++++++++---------
> >  tools/perf/util/parse-events.c  |  52 +++++--
> >  tools/perf/util/pmu.c           |   8 +-
> >  tools/perf/util/pmu.h           |   3 +-
> >  4 files changed, 231 insertions(+), 88 deletions(-)
> >
> > diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-e=
vents.c
> > index e52f45c7c3d1..fbdf710d5eea 100644
> > --- a/tools/perf/tests/parse-events.c
> > +++ b/tools/perf/tests/parse-events.c
> > @@ -162,6 +162,22 @@ static int test__checkevent_numeric(struct evlist =
*evlist)
> >       return TEST_OK;
> >  }
> >
> > +
> > +static int assert_hw(struct perf_evsel *evsel, enum perf_hw_id id, con=
st char *name)
> > +{
> > +     struct perf_pmu *pmu;
> > +
> > +     if (evsel->attr.type =3D=3D PERF_TYPE_HARDWARE) {
> > +             TEST_ASSERT_VAL("wrong config", test_perf_config(evsel, i=
d));
> > +             return 0;
> > +     }
> > +     pmu =3D perf_pmus__find_by_type(evsel->attr.type);
> > +
> > +     TEST_ASSERT_VAL("unexpected PMU type", pmu);
> > +     TEST_ASSERT_VAL("PMU missing event", perf_pmu__have_event(pmu, na=
me));
> > +     return 0;
> > +}
> > +
> >  static int test__checkevent_symbolic_name(struct evlist *evlist)
> >  {
> >       struct perf_evsel *evsel;
> > @@ -169,10 +185,12 @@ static int test__checkevent_symbolic_name(struct =
evlist *evlist)
> >       TEST_ASSERT_VAL("wrong number of entries", 0 !=3D evlist->core.nr=
_entries);
> >
> >       perf_evlist__for_each_evsel(&evlist->core, evsel) {
> > -             TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE =3D=3D e=
vsel->attr.type);
> > -             TEST_ASSERT_VAL("wrong config",
> > -                             test_perf_config(evsel, PERF_COUNT_HW_INS=
TRUCTIONS));
> > +             int ret =3D assert_hw(evsel, PERF_COUNT_HW_INSTRUCTIONS, =
"instructions");
> > +
> > +             if (ret)
> > +                     return ret;
> >       }
> > +
> >       return TEST_OK;
> >  }
> >
> > @@ -183,8 +201,10 @@ static int test__checkevent_symbolic_name_config(s=
truct evlist *evlist)
> >       TEST_ASSERT_VAL("wrong number of entries", 0 !=3D evlist->core.nr=
_entries);
> >
> >       perf_evlist__for_each_evsel(&evlist->core, evsel) {
> > -             TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE =3D=3D e=
vsel->attr.type);
> > -             TEST_ASSERT_VAL("wrong config", test_perf_config(evsel, P=
ERF_COUNT_HW_CPU_CYCLES));
> > +             int ret =3D assert_hw(evsel, PERF_COUNT_HW_CPU_CYCLES, "c=
ycles");
> > +
> > +             if (ret)
> > +                     return ret;
> >               /*
> >                * The period value gets configured within evlist__config=
,
> >                * while this test executes only parse events method.
> > @@ -861,10 +881,14 @@ static int test__group1(struct evlist *evlist)
> >                       evlist__nr_groups(evlist) =3D=3D num_core_entries=
());
> >
> >       for (int i =3D 0; i < num_core_entries(); i++) {
> > +             int ret;
> > +
> >               /* instructions:k */
> >               evsel =3D leader =3D (i =3D=3D 0 ? evlist__first(evlist) =
: evsel__next(evsel));
> > -             TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE =3D=3D e=
vsel->core.attr.type);
> > -             TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_C=
OUNT_HW_INSTRUCTIONS));
> > +             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_INSTRUCTION=
S, "instructions");
> > +             if (ret)
> > +                     return ret;
> > +
> >               TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.ex=
clude_user);
> >               TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr=
.exclude_kernel);
> >               TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.excl=
ude_hv);
> > @@ -878,8 +902,10 @@ static int test__group1(struct evlist *evlist)
> >
> >               /* cycles:upp */
> >               evsel =3D evsel__next(evsel);
> > -             TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE =3D=3D e=
vsel->core.attr.type);
> > -             TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_C=
OUNT_HW_CPU_CYCLES));
> > +             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES,=
 "cycles");
> > +             if (ret)
> > +                     return ret;
> > +
> >               TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.e=
xclude_user);
> >               TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.=
exclude_kernel);
> >               TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.excl=
ude_hv);
> > @@ -907,6 +933,8 @@ static int test__group2(struct evlist *evlist)
> >       TEST_ASSERT_VAL("wrong number of groups", 1 =3D=3D evlist__nr_gro=
ups(evlist));
> >
> >       evlist__for_each_entry(evlist, evsel) {
> > +             int ret;
> > +
> >               if (evsel->core.attr.type =3D=3D PERF_TYPE_SOFTWARE) {
> >                       /* faults + :ku modifier */
> >                       leader =3D evsel;
> > @@ -939,8 +967,10 @@ static int test__group2(struct evlist *evlist)
> >                       continue;
> >               }
> >               /* cycles:k */
> > -             TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE =3D=3D e=
vsel->core.attr.type);
> > -             TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_C=
OUNT_HW_CPU_CYCLES));
> > +             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES,=
 "cycles");
> > +             if (ret)
> > +                     return ret;
> > +
> >               TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.ex=
clude_user);
> >               TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr=
.exclude_kernel);
> >               TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.excl=
ude_hv);
> > @@ -957,6 +987,7 @@ static int test__group2(struct evlist *evlist)
> >  static int test__group3(struct evlist *evlist __maybe_unused)
> >  {
> >       struct evsel *evsel, *group1_leader =3D NULL, *group2_leader =3D =
NULL;
> > +     int ret;
> >
> >       TEST_ASSERT_VAL("wrong number of entries",
> >                       evlist->core.nr_entries =3D=3D (3 * perf_pmus__nu=
m_core_pmus() + 2));
> > @@ -1045,8 +1076,10 @@ static int test__group3(struct evlist *evlist __=
maybe_unused)
> >                       continue;
> >               }
> >               /* instructions:u */
> > -             TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE =3D=3D e=
vsel->core.attr.type);
> > -             TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_C=
OUNT_HW_INSTRUCTIONS));
> > +             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_INSTRUCTION=
S, "instructions");
> > +             if (ret)
> > +                     return ret;
> > +
> >               TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.e=
xclude_user);
> >               TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.=
exclude_kernel);
> >               TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.excl=
ude_hv);
> > @@ -1070,10 +1103,14 @@ static int test__group4(struct evlist *evlist _=
_maybe_unused)
> >                       num_core_entries() =3D=3D evlist__nr_groups(evlis=
t));
> >
> >       for (int i =3D 0; i < num_core_entries(); i++) {
> > +             int ret;
> > +
> >               /* cycles:u + p */
> >               evsel =3D leader =3D (i =3D=3D 0 ? evlist__first(evlist) =
: evsel__next(evsel));
> > -             TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE =3D=3D e=
vsel->core.attr.type);
> > -             TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_C=
OUNT_HW_CPU_CYCLES));
> > +             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES,=
 "cycles");
> > +             if (ret)
> > +                     return ret;
> > +
> >               TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.e=
xclude_user);
> >               TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.=
exclude_kernel);
> >               TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.excl=
ude_hv);
> > @@ -1089,8 +1126,10 @@ static int test__group4(struct evlist *evlist __=
maybe_unused)
> >
> >               /* instructions:kp + p */
> >               evsel =3D evsel__next(evsel);
> > -             TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE =3D=3D e=
vsel->core.attr.type);
> > -             TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_C=
OUNT_HW_INSTRUCTIONS));
> > +             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_INSTRUCTION=
S, "instructions");
> > +             if (ret)
> > +                     return ret;
> > +
> >               TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.ex=
clude_user);
> >               TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr=
.exclude_kernel);
> >               TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.excl=
ude_hv);
> > @@ -1108,6 +1147,7 @@ static int test__group4(struct evlist *evlist __m=
aybe_unused)
> >  static int test__group5(struct evlist *evlist __maybe_unused)
> >  {
> >       struct evsel *evsel =3D NULL, *leader;
> > +     int ret;
> >
> >       TEST_ASSERT_VAL("wrong number of entries",
> >                       evlist->core.nr_entries =3D=3D (5 * num_core_entr=
ies()));
> > @@ -1117,8 +1157,10 @@ static int test__group5(struct evlist *evlist __=
maybe_unused)
> >       for (int i =3D 0; i < num_core_entries(); i++) {
> >               /* cycles + G */
> >               evsel =3D leader =3D (i =3D=3D 0 ? evlist__first(evlist) =
: evsel__next(evsel));
> > -             TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE =3D=3D e=
vsel->core.attr.type);
> > -             TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_C=
OUNT_HW_CPU_CYCLES));
> > +             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES,=
 "cycles");
> > +             if (ret)
> > +                     return ret;
> > +
> >               TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.e=
xclude_user);
> >               TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr=
.exclude_kernel);
> >               TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exc=
lude_hv);
> > @@ -1133,8 +1175,10 @@ static int test__group5(struct evlist *evlist __=
maybe_unused)
> >
> >               /* instructions + G */
> >               evsel =3D evsel__next(evsel);
> > -             TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE =3D=3D e=
vsel->core.attr.type);
> > -             TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_C=
OUNT_HW_INSTRUCTIONS));
> > +             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_INSTRUCTION=
S, "instructions");
> > +             if (ret)
> > +                     return ret;
> > +
> >               TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.e=
xclude_user);
> >               TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr=
.exclude_kernel);
> >               TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exc=
lude_hv);
> > @@ -1148,8 +1192,10 @@ static int test__group5(struct evlist *evlist __=
maybe_unused)
> >       for (int i =3D 0; i < num_core_entries(); i++) {
> >               /* cycles:G */
> >               evsel =3D leader =3D evsel__next(evsel);
> > -             TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE =3D=3D e=
vsel->core.attr.type);
> > -             TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_C=
OUNT_HW_CPU_CYCLES));
> > +             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES,=
 "cycles");
> > +             if (ret)
> > +                     return ret;
> > +
> >               TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.e=
xclude_user);
> >               TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr=
.exclude_kernel);
> >               TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exc=
lude_hv);
> > @@ -1164,8 +1210,10 @@ static int test__group5(struct evlist *evlist __=
maybe_unused)
> >
> >               /* instructions:G */
> >               evsel =3D evsel__next(evsel);
> > -             TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE =3D=3D e=
vsel->core.attr.type);
> > -             TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_C=
OUNT_HW_INSTRUCTIONS));
> > +             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_INSTRUCTION=
S, "instructions");
> > +             if (ret)
> > +                     return ret;
> > +
> >               TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.e=
xclude_user);
> >               TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr=
.exclude_kernel);
> >               TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exc=
lude_hv);
> > @@ -1178,8 +1226,10 @@ static int test__group5(struct evlist *evlist __=
maybe_unused)
> >       for (int i =3D 0; i < num_core_entries(); i++) {
> >               /* cycles */
> >               evsel =3D evsel__next(evsel);
> > -             TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE =3D=3D e=
vsel->core.attr.type);
> > -             TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_C=
OUNT_HW_CPU_CYCLES));
> > +             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES,=
 "cycles");
> > +             if (ret)
> > +                     return ret;
> > +
> >               TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.e=
xclude_user);
> >               TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr=
.exclude_kernel);
> >               TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exc=
lude_hv);
> > @@ -1201,10 +1251,14 @@ static int test__group_gh1(struct evlist *evlis=
t)
> >                       evlist__nr_groups(evlist) =3D=3D num_core_entries=
());
> >
> >       for (int i =3D 0; i < num_core_entries(); i++) {
> > +             int ret;
> > +
> >               /* cycles + :H group modifier */
> >               evsel =3D leader =3D (i =3D=3D 0 ? evlist__first(evlist) =
: evsel__next(evsel));
> > -             TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE =3D=3D e=
vsel->core.attr.type);
> > -             TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_C=
OUNT_HW_CPU_CYCLES));
> > +             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES,=
 "cycles");
> > +             if (ret)
> > +                     return ret;
> > +
> >               TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.e=
xclude_user);
> >               TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr=
.exclude_kernel);
> >               TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exc=
lude_hv);
> > @@ -1218,8 +1272,10 @@ static int test__group_gh1(struct evlist *evlist=
)
> >
> >               /* cache-misses:G + :H group modifier */
> >               evsel =3D evsel__next(evsel);
> > -             TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE =3D=3D e=
vsel->core.attr.type);
> > -             TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_C=
OUNT_HW_CACHE_MISSES));
> > +             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CACHE_MISSE=
S, "cache-misses");
> > +             if (ret)
> > +                     return ret;
> > +
> >               TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.e=
xclude_user);
> >               TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr=
.exclude_kernel);
> >               TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exc=
lude_hv);
> > @@ -1242,10 +1298,14 @@ static int test__group_gh2(struct evlist *evlis=
t)
> >                       evlist__nr_groups(evlist) =3D=3D num_core_entries=
());
> >
> >       for (int i =3D 0; i < num_core_entries(); i++) {
> > +             int ret;
> > +
> >               /* cycles + :G group modifier */
> >               evsel =3D leader =3D (i =3D=3D 0 ? evlist__first(evlist) =
: evsel__next(evsel));
> > -             TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE =3D=3D e=
vsel->core.attr.type);
> > -             TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_C=
OUNT_HW_CPU_CYCLES));
> > +             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES,=
 "cycles");
> > +             if (ret)
> > +                     return ret;
> > +
> >               TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.e=
xclude_user);
> >               TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr=
.exclude_kernel);
> >               TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exc=
lude_hv);
> > @@ -1259,8 +1319,10 @@ static int test__group_gh2(struct evlist *evlist=
)
> >
> >               /* cache-misses:H + :G group modifier */
> >               evsel =3D evsel__next(evsel);
> > -             TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE =3D=3D e=
vsel->core.attr.type);
> > -             TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_C=
OUNT_HW_CACHE_MISSES));
> > +             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CACHE_MISSE=
S, "cache-misses");
> > +             if (ret)
> > +                     return ret;
> > +
> >               TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.e=
xclude_user);
> >               TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr=
.exclude_kernel);
> >               TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exc=
lude_hv);
> > @@ -1283,10 +1345,14 @@ static int test__group_gh3(struct evlist *evlis=
t)
> >                       evlist__nr_groups(evlist) =3D=3D num_core_entries=
());
> >
> >       for (int i =3D 0; i < num_core_entries(); i++) {
> > +             int ret;
> > +
> >               /* cycles:G + :u group modifier */
> >               evsel =3D leader =3D (i =3D=3D 0 ? evlist__first(evlist) =
: evsel__next(evsel));
> > -             TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE =3D=3D e=
vsel->core.attr.type);
> > -             TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_C=
OUNT_HW_CPU_CYCLES));
> > +             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES,=
 "cycles");
> > +             if (ret)
> > +                     return ret;
> > +
> >               TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.e=
xclude_user);
> >               TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.=
exclude_kernel);
> >               TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.excl=
ude_hv);
> > @@ -1300,8 +1366,10 @@ static int test__group_gh3(struct evlist *evlist=
)
> >
> >               /* cache-misses:H + :u group modifier */
> >               evsel =3D evsel__next(evsel);
> > -             TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE =3D=3D e=
vsel->core.attr.type);
> > -             TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_C=
OUNT_HW_CACHE_MISSES));
> > +             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CACHE_MISSE=
S, "cache-misses");
> > +             if (ret)
> > +                     return ret;
> > +
> >               TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.e=
xclude_user);
> >               TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.=
exclude_kernel);
> >               TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.excl=
ude_hv);
> > @@ -1324,10 +1392,14 @@ static int test__group_gh4(struct evlist *evlis=
t)
> >                       evlist__nr_groups(evlist) =3D=3D num_core_entries=
());
> >
> >       for (int i =3D 0; i < num_core_entries(); i++) {
> > +             int ret;
> > +
> >               /* cycles:G + :uG group modifier */
> >               evsel =3D leader =3D (i =3D=3D 0 ? evlist__first(evlist) =
: evsel__next(evsel));
> > -             TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE =3D=3D e=
vsel->core.attr.type);
> > -             TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_C=
OUNT_HW_CPU_CYCLES));
> > +             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES,=
 "cycles");
> > +             if (ret)
> > +                     return ret;
> > +
> >               TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.e=
xclude_user);
> >               TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.=
exclude_kernel);
> >               TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.excl=
ude_hv);
> > @@ -1341,8 +1413,10 @@ static int test__group_gh4(struct evlist *evlist=
)
> >
> >               /* cache-misses:H + :uG group modifier */
> >               evsel =3D evsel__next(evsel);
> > -             TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE =3D=3D e=
vsel->core.attr.type);
> > -             TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_C=
OUNT_HW_CACHE_MISSES));
> > +             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CACHE_MISSE=
S, "cache-misses");
> > +             if (ret)
> > +                     return ret;
> > +
> >               TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.e=
xclude_user);
> >               TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.=
exclude_kernel);
> >               TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.excl=
ude_hv);
> > @@ -1363,10 +1437,14 @@ static int test__leader_sample1(struct evlist *=
evlist)
> >                       evlist->core.nr_entries =3D=3D (3 * num_core_entr=
ies()));
> >
> >       for (int i =3D 0; i < num_core_entries(); i++) {
> > +             int ret;
> > +
> >               /* cycles - sampling group leader */
> >               evsel =3D leader =3D (i =3D=3D 0 ? evlist__first(evlist) =
: evsel__next(evsel));
> > -             TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE =3D=3D e=
vsel->core.attr.type);
> > -             TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_C=
OUNT_HW_CPU_CYCLES));
> > +             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES,=
 "cycles");
> > +             if (ret)
> > +                     return ret;
> > +
> >               TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.e=
xclude_user);
> >               TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr=
.exclude_kernel);
> >               TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exc=
lude_hv);
> > @@ -1379,8 +1457,10 @@ static int test__leader_sample1(struct evlist *e=
vlist)
> >
> >               /* cache-misses - not sampling */
> >               evsel =3D evsel__next(evsel);
> > -             TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE =3D=3D e=
vsel->core.attr.type);
> > -             TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_C=
OUNT_HW_CACHE_MISSES));
> > +             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CACHE_MISSE=
S, "cache-misses");
> > +             if (ret)
> > +                     return ret;
> > +
> >               TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.e=
xclude_user);
> >               TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr=
.exclude_kernel);
> >               TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exc=
lude_hv);
> > @@ -1392,8 +1472,10 @@ static int test__leader_sample1(struct evlist *e=
vlist)
> >
> >               /* branch-misses - not sampling */
> >               evsel =3D evsel__next(evsel);
> > -             TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE =3D=3D e=
vsel->core.attr.type);
> > -             TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_C=
OUNT_HW_BRANCH_MISSES));
> > +             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_BRANCH_MISS=
ES, "branch-misses");
> > +             if (ret)
> > +                     return ret;
> > +
> >               TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.e=
xclude_user);
> >               TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr=
.exclude_kernel);
> >               TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exc=
lude_hv);
> > @@ -1415,10 +1497,14 @@ static int test__leader_sample2(struct evlist *=
evlist __maybe_unused)
> >                       evlist->core.nr_entries =3D=3D (2 * num_core_entr=
ies()));
> >
> >       for (int i =3D 0; i < num_core_entries(); i++) {
> > +             int ret;
> > +
> >               /* instructions - sampling group leader */
> >               evsel =3D leader =3D (i =3D=3D 0 ? evlist__first(evlist) =
: evsel__next(evsel));
> > -             TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE =3D=3D e=
vsel->core.attr.type);
> > -             TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_C=
OUNT_HW_INSTRUCTIONS));
> > +             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_INSTRUCTION=
S, "instructions");
> > +             if (ret)
> > +                     return ret;
> > +
> >               TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.e=
xclude_user);
> >               TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.=
exclude_kernel);
> >               TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.excl=
ude_hv);
> > @@ -1431,8 +1517,10 @@ static int test__leader_sample2(struct evlist *e=
vlist __maybe_unused)
> >
> >               /* branch-misses - not sampling */
> >               evsel =3D evsel__next(evsel);
> > -             TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE =3D=3D e=
vsel->core.attr.type);
> > -             TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_C=
OUNT_HW_BRANCH_MISSES));
> > +             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_BRANCH_MISS=
ES, "branch-misses");
> > +             if (ret)
> > +                     return ret;
> > +
> >               TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.e=
xclude_user);
> >               TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.=
exclude_kernel);
> >               TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.excl=
ude_hv);
> > @@ -1472,10 +1560,14 @@ static int test__pinned_group(struct evlist *ev=
list)
> >                       evlist->core.nr_entries =3D=3D (3 * num_core_entr=
ies()));
> >
> >       for (int i =3D 0; i < num_core_entries(); i++) {
> > +             int ret;
> > +
> >               /* cycles - group leader */
> >               evsel =3D leader =3D (i =3D=3D 0 ? evlist__first(evlist) =
: evsel__next(evsel));
> > -             TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE =3D=3D e=
vsel->core.attr.type);
> > -             TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_C=
OUNT_HW_CPU_CYCLES));
> > +             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES,=
 "cycles");
> > +             if (ret)
> > +                     return ret;
> > +
> >               TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
> >               TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, =
leader));
> >               /* TODO: The group modifier is not copied to the split gr=
oup leader. */
> > @@ -1484,13 +1576,18 @@ static int test__pinned_group(struct evlist *ev=
list)
> >
> >               /* cache-misses - can not be pinned, but will go on with =
the leader */
> >               evsel =3D evsel__next(evsel);
> > -             TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE =3D=3D e=
vsel->core.attr.type);
> > -             TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_C=
OUNT_HW_CACHE_MISSES));
> > +             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CACHE_MISSE=
S, "cache-misses");
> > +             if (ret)
> > +                     return ret;
> > +
> >               TEST_ASSERT_VAL("wrong pinned", !evsel->core.attr.pinned)=
;
> >
> >               /* branch-misses - ditto */
> >               evsel =3D evsel__next(evsel);
> > -             TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_C=
OUNT_HW_BRANCH_MISSES));
> > +             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_BRANCH_MISS=
ES, "branch-misses");
> > +             if (ret)
> > +                     return ret;
> > +
> >               TEST_ASSERT_VAL("wrong pinned", !evsel->core.attr.pinned)=
;
> >       }
> >       return TEST_OK;
> > @@ -1517,10 +1614,14 @@ static int test__exclusive_group(struct evlist =
*evlist)
> >                       evlist->core.nr_entries =3D=3D 3 * num_core_entri=
es());
> >
> >       for (int i =3D 0; i < num_core_entries(); i++) {
> > +             int ret;
> > +
> >               /* cycles - group leader */
> >               evsel =3D leader =3D (i =3D=3D 0 ? evlist__first(evlist) =
: evsel__next(evsel));
> > -             TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE =3D=3D e=
vsel->core.attr.type);
> > -             TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_C=
OUNT_HW_CPU_CYCLES));
> > +             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES,=
 "cycles");
> > +             if (ret)
> > +                     return ret;
> > +
> >               TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
> >               TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, =
leader));
> >               /* TODO: The group modifier is not copied to the split gr=
oup leader. */
> > @@ -1529,13 +1630,18 @@ static int test__exclusive_group(struct evlist =
*evlist)
> >
> >               /* cache-misses - can not be pinned, but will go on with =
the leader */
> >               evsel =3D evsel__next(evsel);
> > -             TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE =3D=3D e=
vsel->core.attr.type);
> > -             TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_C=
OUNT_HW_CACHE_MISSES));
> > +             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CACHE_MISSE=
S, "cache-misses");
> > +             if (ret)
> > +                     return ret;
> > +
> >               TEST_ASSERT_VAL("wrong exclusive", !evsel->core.attr.excl=
usive);
> >
> >               /* branch-misses - ditto */
> >               evsel =3D evsel__next(evsel);
> > -             TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_C=
OUNT_HW_BRANCH_MISSES));
> > +             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_BRANCH_MISS=
ES, "branch-misses");
> > +             if (ret)
> > +                     return ret;
> > +
> >               TEST_ASSERT_VAL("wrong exclusive", !evsel->core.attr.excl=
usive);
> >       }
> >       return TEST_OK;
> > @@ -1677,9 +1783,11 @@ static int test__checkevent_raw_pmu(struct evlis=
t *evlist)
> >  static int test__sym_event_slash(struct evlist *evlist)
> >  {
> >       struct evsel *evsel =3D evlist__first(evlist);
> > +     int ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, "cy=
cles");
> > +
> > +     if (ret)
> > +             return ret;
> >
> > -     TEST_ASSERT_VAL("wrong type", evsel->core.attr.type =3D=3D PERF_T=
YPE_HARDWARE);
> > -     TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_=
CPU_CYCLES));
> >       TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_=
kernel);
> >       return TEST_OK;
> >  }
> > @@ -1687,9 +1795,11 @@ static int test__sym_event_slash(struct evlist *=
evlist)
> >  static int test__sym_event_dc(struct evlist *evlist)
> >  {
> >       struct evsel *evsel =3D evlist__first(evlist);
> > +     int ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, "cy=
cles");
> > +
> > +     if (ret)
> > +             return ret;
> >
> > -     TEST_ASSERT_VAL("wrong type", evsel->core.attr.type =3D=3D PERF_T=
YPE_HARDWARE);
> > -     TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_=
CPU_CYCLES));
> >       TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_us=
er);
> >       return TEST_OK;
> >  }
> > @@ -1697,9 +1807,11 @@ static int test__sym_event_dc(struct evlist *evl=
ist)
> >  static int test__term_equal_term(struct evlist *evlist)
> >  {
> >       struct evsel *evsel =3D evlist__first(evlist);
> > +     int ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, "cy=
cles");
> > +
> > +     if (ret)
> > +             return ret;
> >
> > -     TEST_ASSERT_VAL("wrong type", evsel->core.attr.type =3D=3D PERF_T=
YPE_HARDWARE);
> > -     TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_=
CPU_CYCLES));
> >       TEST_ASSERT_VAL("wrong name setting", strcmp(evsel->name, "name")=
 =3D=3D 0);
> >       return TEST_OK;
> >  }
> > @@ -1707,9 +1819,11 @@ static int test__term_equal_term(struct evlist *=
evlist)
> >  static int test__term_equal_legacy(struct evlist *evlist)
> >  {
> >       struct evsel *evsel =3D evlist__first(evlist);
> > +     int ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, "cy=
cles");
> > +
> > +     if (ret)
> > +             return ret;
> >
> > -     TEST_ASSERT_VAL("wrong type", evsel->core.attr.type =3D=3D PERF_T=
YPE_HARDWARE);
> > -     TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_=
CPU_CYCLES));
> >       TEST_ASSERT_VAL("wrong name setting", strcmp(evsel->name, "l1d") =
=3D=3D 0);
> >       return TEST_OK;
> >  }
> > diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-eve=
nts.c
> > index aa2f5c6fc7fc..767aa718faa5 100644
> > --- a/tools/perf/util/parse-events.c
> > +++ b/tools/perf/util/parse-events.c
> > @@ -976,7 +976,7 @@ static int config_term_pmu(struct perf_event_attr *=
attr,
> >                          struct parse_events_error *err)
> >  {
> >       if (term->type_term =3D=3D PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE) =
{
> > -             const struct perf_pmu *pmu =3D perf_pmus__find_by_type(at=
tr->type);
> > +             struct perf_pmu *pmu =3D perf_pmus__find_by_type(attr->ty=
pe);
> >
> >               if (!pmu) {
> >                       char *err_str;
> > @@ -986,15 +986,23 @@ static int config_term_pmu(struct perf_event_attr=
 *attr,
> >                                                          err_str, /*hel=
p=3D*/NULL);
> >                       return -EINVAL;
> >               }
> > -             if (perf_pmu__supports_legacy_cache(pmu)) {
> > +             /*
> > +              * Rewrite the PMU event to a legacy cache one unless the=
 PMU
> > +              * doesn't support legacy cache events or the event is pr=
esent
> > +              * within the PMU.
> > +              */
> > +             if (perf_pmu__supports_legacy_cache(pmu) &&
> > +                 !perf_pmu__have_event(pmu, term->config)) {
> >                       attr->type =3D PERF_TYPE_HW_CACHE;
> >                       return parse_events__decode_legacy_cache(term->co=
nfig, pmu->type,
> >                                                                &attr->c=
onfig);
> > -             } else
> > +             } else {
> >                       term->type_term =3D PARSE_EVENTS__TERM_TYPE_USER;
> > +                     term->no_value =3D true;
> > +             }
> >       }
> >       if (term->type_term =3D=3D PARSE_EVENTS__TERM_TYPE_HARDWARE) {
> > -             const struct perf_pmu *pmu =3D perf_pmus__find_by_type(at=
tr->type);
> > +             struct perf_pmu *pmu =3D perf_pmus__find_by_type(attr->ty=
pe);
> >
> >               if (!pmu) {
> >                       char *err_str;
> > @@ -1004,10 +1012,19 @@ static int config_term_pmu(struct perf_event_at=
tr *attr,
> >                                                          err_str, /*hel=
p=3D*/NULL);
> >                       return -EINVAL;
> >               }
> > -             attr->type =3D PERF_TYPE_HARDWARE;
> > -             attr->config =3D term->val.num;
> > -             if (perf_pmus__supports_extended_type())
> > -                     attr->config |=3D (__u64)pmu->type << PERF_PMU_TY=
PE_SHIFT;
> > +             /*
> > +              * If the PMU has a sysfs or json event prefer it over
> > +              * legacy. ARM requires this.
> > +              */
> > +             if (perf_pmu__have_event(pmu, term->config)) {
> > +                     term->type_term =3D PARSE_EVENTS__TERM_TYPE_USER;
> > +                     term->no_value =3D true;
> > +             } else {
> > +                     attr->type =3D PERF_TYPE_HARDWARE;
> > +                     attr->config =3D term->val.num;
> > +                     if (perf_pmus__supports_extended_type())
> > +                             attr->config |=3D (__u64)pmu->type << PER=
F_PMU_TYPE_SHIFT;
> > +             }
> >               return 0;
> >       }
> >       if (term->type_term =3D=3D PARSE_EVENTS__TERM_TYPE_USER ||
> > @@ -1381,6 +1398,7 @@ int parse_events_add_pmu(struct parse_events_stat=
e *parse_state,
> >       YYLTYPE *loc =3D loc_;
> >       LIST_HEAD(config_terms);
> >       struct parse_events_terms parsed_terms;
> > +     bool alias_rewrote_terms;
> >
> >       pmu =3D parse_state->fake_pmu ?: perf_pmus__find(name);
> >
> > @@ -1433,7 +1451,15 @@ int parse_events_add_pmu(struct parse_events_sta=
te *parse_state,
> >               return evsel ? 0 : -ENOMEM;
> >       }
> >
> > -     if (!parse_state->fake_pmu && perf_pmu__check_alias(pmu, &parsed_=
terms, &info, err)) {
> > +     /* Configure attr/terms with a known PMU, this will set hardcoded=
 terms. */
> > +     if (config_attr(&attr, &parsed_terms, parse_state->error, config_=
term_pmu)) {
> > +             parse_events_terms__exit(&parsed_terms);
> > +             return -EINVAL;
> > +     }
> > +
> > +     /* Look for event names in the terms and rewrite into format base=
d terms. */
> > +     if (!parse_state->fake_pmu && perf_pmu__check_alias(pmu, &parsed_=
terms,
> > +                                                         &info, &alias=
_rewrote_terms, err)) {
> >               parse_events_terms__exit(&parsed_terms);
> >               return -EINVAL;
> >       }
> > @@ -1447,11 +1473,9 @@ int parse_events_add_pmu(struct parse_events_sta=
te *parse_state,
> >               strbuf_release(&sb);
> >       }
> >
> > -     /*
> > -      * Configure hardcoded terms first, no need to check
> > -      * return value when called with fail =3D=3D 0 ;)
> > -      */
> > -     if (config_attr(&attr, &parsed_terms, parse_state->error, config_=
term_pmu)) {
> > +     /* Configure attr/terms again if an alias was expanded. */
> > +     if (alias_rewrote_terms &&
> > +         config_attr(&attr, &parsed_terms, parse_state->error, config_=
term_pmu)) {
> >               parse_events_terms__exit(&parsed_terms);
> >               return -EINVAL;
> >       }
> > diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> > index d3c9aa4326be..3c9609944a2f 100644
> > --- a/tools/perf/util/pmu.c
> > +++ b/tools/perf/util/pmu.c
> > @@ -1494,12 +1494,14 @@ static int check_info_data(struct perf_pmu *pmu=
,
> >   * defined for the alias
> >   */
> >  int perf_pmu__check_alias(struct perf_pmu *pmu, struct parse_events_te=
rms *head_terms,
> > -                       struct perf_pmu_info *info, struct parse_events=
_error *err)
> > +                       struct perf_pmu_info *info, bool *rewrote_terms=
,
> > +                       struct parse_events_error *err)
> >  {
> >       struct parse_events_term *term, *h;
> >       struct perf_pmu_alias *alias;
> >       int ret;
> >
> > +     *rewrote_terms =3D false;
> >       info->per_pkg =3D false;
> >
> >       /*
> > @@ -1521,7 +1523,7 @@ int perf_pmu__check_alias(struct perf_pmu *pmu, s=
truct parse_events_terms *head_
> >                                               NULL);
> >                       return ret;
> >               }
> > -
> > +             *rewrote_terms =3D true;
> >               ret =3D check_info_data(pmu, alias, info, err, term->err_=
term);
> >               if (ret)
> >                       return ret;
> > @@ -1615,6 +1617,8 @@ bool perf_pmu__auto_merge_stats(const struct perf=
_pmu *pmu)
> >
> >  bool perf_pmu__have_event(struct perf_pmu *pmu, const char *name)
> >  {
> > +     if (!name)
> > +             return false;
> >       if (perf_pmu__find_alias(pmu, name, /*load=3D*/ true) !=3D NULL)
> >               return true;
> >       if (pmu->cpu_aliases_added || !pmu->events_table)
> > diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> > index d2895d415f08..424c3fee0949 100644
> > --- a/tools/perf/util/pmu.h
> > +++ b/tools/perf/util/pmu.h
> > @@ -201,7 +201,8 @@ int perf_pmu__config_terms(const struct perf_pmu *p=
mu,
> >  __u64 perf_pmu__format_bits(struct perf_pmu *pmu, const char *name);
> >  int perf_pmu__format_type(struct perf_pmu *pmu, const char *name);
> >  int perf_pmu__check_alias(struct perf_pmu *pmu, struct parse_events_te=
rms *head_terms,
> > -                       struct perf_pmu_info *info, struct parse_events=
_error *err);
> > +                       struct perf_pmu_info *info, bool *rewrote_terms=
,
> > +                       struct parse_events_error *err);
> >  int perf_pmu__find_event(struct perf_pmu *pmu, const char *event, void=
 *state, pmu_event_callback cb);
> >
> >  int perf_pmu__format_parse(struct perf_pmu *pmu, int dirfd, bool eager=
_load);
> > --
> > 2.43.0.rc1.413.gea7ed67945-goog
> >
