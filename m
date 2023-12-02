Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADB048019F4
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 03:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442007AbjLBCI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 21:08:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLBCIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 21:08:24 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9AC910E5
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 18:08:26 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-50bc9893f32so1154e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 18:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701482905; x=1702087705; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ws1DAoL1kilzg1iLjYgWmaH8tZkC0cVm6J50fChhA5Q=;
        b=bd4aYHswuGrt4j/pWtlzrXP0GTfYtJ/9VDS/QOz/768dGquAHF4zid1Yldn1cz581r
         MrE2gZl4yIxMOfz0SK+X9+uX9qKU8vhPs8tE5wsf42CjQwv2cJ8nQfLpBRY8YCJIC2ax
         dQ4yY3/vtYmBwvonBa57Yh0RfVr3CiL5yDBd8h8DraLXHkpZF2Ir1iVzxu9h0dI2nLW6
         XZUNbsi2Q3rk/dmg2pxYFFQnA3xIGsFhu9I2aRiiH9ebr8CCdHPku0+Hl9hzp6FoPq4L
         KSmzq1XbspyK7dhHyRayF6lSrPIdbUKmMNSQZIcZiO5deljN93GMT82DfZ5Pf/+QHUSG
         RwKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701482905; x=1702087705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ws1DAoL1kilzg1iLjYgWmaH8tZkC0cVm6J50fChhA5Q=;
        b=Y2iFM9qGjVzaPU0c4S4dUIwaUh09+e5/Di6Sc12sTbpvYZ++k7gzPtjhYYE27GmmO/
         Qyirs9U5ckyjF9mJgOVo7sol4mBeHJLoED7r3kQDlyftw97WKRkp/zm5MK3Zr6T1rzEE
         0+r+mAeb6vuAcHXRiJUxM8EJtyri1Ca1/qGQWcd15pIf+7T/fgLwO4zE1lRCPpLyat3U
         nBaAmz6EFzdkNwHjedTsyq1uxQVhxd4zCDxBulxJqr7sxr9Md1OESM3yxeMMUiaD9nE1
         3i4KJGkBDZ3v1bIoNxVUqIMXuHOSY1cCOpkLKGM6TrE2ieJ4r21jwsPzU6LJLbtjA4VE
         D7Ag==
X-Gm-Message-State: AOJu0YzvbCpm4aVPvLuY6qzjvsvXIyoPRn9zQx7gOKaj4/94yXfXs2gR
        GVoEVn5KMCzMACs7FIzKhFWBmY7E3uRG/cFiRMEfjJiVw79LL7GqHjTUag==
X-Google-Smtp-Source: AGHT+IHulk/HBrcE7uedPmWU066+YEFacy4IjrB7qfmiMZgjs1ThmOTyZhEgUifB8tvnf/lycgevSCnJzFHUmdB0WOc=
X-Received: by 2002:a05:6512:1153:b0:504:7b50:ec9a with SMTP id
 m19-20020a056512115300b005047b50ec9amr197875lfg.1.1701482904598; Fri, 01 Dec
 2023 18:08:24 -0800 (PST)
MIME-Version: 1.0
References: <20231128203940.3964287-1-kan.liang@linux.intel.com>
 <CAP-5=fUdEgnwk_FNHb-Ju3wCYE2PLLrPHqwZoyBGyURXQhBeSA@mail.gmail.com>
 <083bfe11-6f6e-487f-ac28-aec22e6b6b06@linux.intel.com> <CAP-5=fXTYX6_QdR4RCBu9yh+k1VwhsTjabKdseVP9Cvi6PE=sA@mail.gmail.com>
 <f5112f5e-c77c-4a9a-ac3b-66772adba471@linux.intel.com> <CAP-5=fU6EXenN9uU1DZ3X=L+k6Y-4a-XESfY9gL9ZCowhSazWA@mail.gmail.com>
 <afefab15-cffc-4345-9cf4-c6a4128d4d9c@linux.intel.com>
In-Reply-To: <afefab15-cffc-4345-9cf4-c6a4128d4d9c@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 1 Dec 2023 18:08:13 -0800
Message-ID: <CAP-5=fW=b7KmiJKgFOxWd4ayG9A+f4E6QuTKCV0bZmf=SWSQ4Q@mail.gmail.com>
Subject: Re: [PATCH] perf mem: Fix perf mem error on hybrid
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     acme@kernel.org, mingo@redhat.com, peterz@infradead.org,
        mark.rutland@arm.com, namhyung@kernel.org, jolsa@kernel.org,
        adrian.hunter@intel.com, ravi.bangoria@amd.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Ammy Yi <ammy.yi@intel.com>
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

On Fri, Dec 1, 2023 at 1:43=E2=80=AFPM Liang, Kan <kan.liang@linux.intel.co=
m> wrote:
>
>
>
> On 2023-11-30 3:36 p.m., Ian Rogers wrote:
> > On Wed, Nov 29, 2023 at 1:15=E2=80=AFPM Liang, Kan <kan.liang@linux.int=
el.com> wrote:
> >>
> >>
> >>
> >> On 2023-11-29 11:17 a.m., Ian Rogers wrote:
> >>> On Wed, Nov 29, 2023 at 5:52=E2=80=AFAM Liang, Kan <kan.liang@linux.i=
ntel.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 2023-11-29 1:24 a.m., Ian Rogers wrote:
> >>>>> On Tue, Nov 28, 2023 at 12:39=E2=80=AFPM <kan.liang@linux.intel.com=
> wrote:
> >>>>>>
> >>>>>> From: Kan Liang <kan.liang@linux.intel.com>
> >>>>>>
> >>>>>> The below error can be triggered on a hybrid machine.
> >>>>>>
> >>>>>>  $ perf mem record -t load sleep 1
> >>>>>>  event syntax error: 'breakpoint/mem-loads,ldlat=3D30/P'
> >>>>>>                                 \___ Bad event or PMU
> >>>>>>
> >>>>>>  Unable to find PMU or event on a PMU of 'breakpoint'
> >>>>>>
> >>>>>> In the perf_mem_events__record_args(), the current perf never chec=
ks the
> >>>>>> availability of a mem event on a given PMU. All the PMUs will be a=
dded
> >>>>>> to the perf mem event list. Perf errors out for the unsupported PM=
U.
> >>>>>>
> >>>>>> Extend perf_mem_event__supported() and take a PMU into account. Ch=
eck
> >>>>>> the mem event for each PMU before adding it to the perf mem event =
list.
> >>>>>>
> >>>>>> Optimize the perf_mem_events__init() a little bit. The function is=
 to
> >>>>>> check whether the mem events are supported in the system. It doesn=
't
> >>>>>> need to scan all PMUs. Just return with the first supported PMU is=
 good
> >>>>>> enough.
> >>>>>>
> >>>>>> Fixes: 5752c20f3787 ("perf mem: Scan all PMUs instead of just core=
 ones")
> >>>>>> Reported-by: Ammy Yi <ammy.yi@intel.com>
> >>>>>> Tested-by: Ammy Yi <ammy.yi@intel.com>
> >>>>>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> >>>>>> ---
> >>>>>>  tools/perf/util/mem-events.c | 25 ++++++++++++++-----------
> >>>>>>  1 file changed, 14 insertions(+), 11 deletions(-)
> >>>>>>
> >>>>>> diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-ev=
ents.c
> >>>>>> index 954b235e12e5..3a2e3687878c 100644
> >>>>>> --- a/tools/perf/util/mem-events.c
> >>>>>> +++ b/tools/perf/util/mem-events.c
> >>>>>> @@ -100,11 +100,14 @@ int perf_mem_events__parse(const char *str)
> >>>>>>         return -1;
> >>>>>>  }
> >>>>>>
> >>>>>> -static bool perf_mem_event__supported(const char *mnt, char *sysf=
s_name)
> >>>>>> +static bool perf_mem_event__supported(const char *mnt, struct per=
f_pmu *pmu,
> >>>>>> +                                     struct perf_mem_event *e)
> >>>>>>  {
> >>>>>> +       char sysfs_name[100];
> >>>>>>         char path[PATH_MAX];
> >>>>>>         struct stat st;
> >>>>>>
> >>>>>> +       scnprintf(sysfs_name, sizeof(sysfs_name), e->sysfs_name, p=
mu->name);
> >>>>>
> >>>>> Not sure if this is right. Looking at sysfs_name values:
> >>>>> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-nex=
t.git/tree/tools/perf/util/mem-events.c?h=3Dperf-tools-next#n23
> >>>>> "cpu/events/mem-loads" and "cpu/events/mem-stores", so won't pmu->n=
ame
> >>>>> never be used?
> >>>>> Is there a missed change to change the cpu to %s?
> >>>>
> >>>> There is a X86 specific perf_mem_events__ptr(), which uses the
> >>>> "%s/mem-loads,ldlat=3D%u/P" and "%s/events/mem-loads" for Intel plat=
forms.
> >>>> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next=
.git/tree/tools/perf/arch/x86/util/mem-events.c?h=3Dperf-tools-next#n20
> >>>> The pmu->name is used especially for the hybrid platforms.
> >>>
> >>> Right, that seems wrong. For one thing we're losing the compiler's
> >>> format string argument checking, but hardcoding PMU names just seems
> >>> to be something that will keep needing maintenance. This patch set
> >>> looks to fix an Intel issue but in general it is increasing tech debt
> >>> (or at least churning it) that will need cleaning up to do something
> >>> with better error checking and more generic. perf_mem_event looks lik=
e
> >>> a bad abstraction and then there are the integers whose special value=
s
> >>> hold meaning. Could this fix come with some cleanup? It wouldn't seem
> >>> wrong to me to add notions of memory events to the PMU abstraction. A=
s
> >>> it stands this scnprintf looks wrong in non-Intel cases.
> >>>
> >>
> >> The problem is that different ARCHs check different things. Arm and AM=
D
> >> checks the PMU name, while Intel and Power checks the specific events.
> >> It's hard to have a unified scnprintf.
> >>
> >> But we can abstract them into two cases, PMU name and event name. We u=
se
> >> a different scnprintf to handle them.
> >> How about something as below?
> >>
> >> diff --git a/tools/perf/arch/x86/util/mem-events.c
> >> b/tools/perf/arch/x86/util/mem-events.c
> >> index 191b372f9a2d..4ef70fb9132b 100644
> >> --- a/tools/perf/arch/x86/util/mem-events.c
> >> +++ b/tools/perf/arch/x86/util/mem-events.c
> >> @@ -17,8 +17,8 @@ static char mem_stores_name[100];
> >>  #define E(t, n, s) { .tag =3D t, .name =3D n, .sysfs_name =3D s }
> >>
> >>  static struct perf_mem_event
> >> perf_mem_events_intel[PERF_MEM_EVENTS__MAX] =3D {
> >> -       E("ldlat-loads",        "%s/mem-loads,ldlat=3D%u/P",      "%s/=
events/mem-loads"),
> >> -       E("ldlat-stores",       "%s/mem-stores/P",              "%s/ev=
ents/mem-stores"),
> >> +       E("ldlat-loads",        "%s/mem-loads,ldlat=3D%u/P",      "eve=
nts/mem-loads"),
> >> +       E("ldlat-stores",       "%s/mem-stores/P",              "event=
s/mem-stores"),
> >>         E(NULL,                 NULL,                           NULL),
> >>  };
> >>
> >> diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events=
.c
> >> index 3a2e3687878c..ba88cb3d804f 100644
> >> --- a/tools/perf/util/mem-events.c
> >> +++ b/tools/perf/util/mem-events.c
> >> @@ -8,6 +8,7 @@
> >>  #include <unistd.h>
> >>  #include <api/fs/fs.h>
> >>  #include <linux/kernel.h>
> >> +#include <linux/string.h>
> >>  #include "map_symbol.h"
> >>  #include "mem-events.h"
> >>  #include "debug.h"
> >> @@ -20,8 +21,8 @@ unsigned int perf_mem_events__loads_ldlat =3D 30;
> >>  #define E(t, n, s) { .tag =3D t, .name =3D n, .sysfs_name =3D s }
> >>
> >>  static struct perf_mem_event perf_mem_events[PERF_MEM_EVENTS__MAX] =
=3D {
> >> -       E("ldlat-loads",        "cpu/mem-loads,ldlat=3D%u/P",     "cpu=
/events/mem-loads"),
> >> -       E("ldlat-stores",       "cpu/mem-stores/P",             "cpu/e=
vents/mem-stores"),
> >> +       E("ldlat-loads",        "cpu/mem-loads,ldlat=3D%u/P",     "eve=
nts/mem-loads"),
> >> +       E("ldlat-stores",       "cpu/mem-stores/P",             "event=
s/mem-stores"),
> >>         E(NULL,                 NULL,                           NULL),
> >>  };
> >>  #undef E
> >> @@ -103,12 +104,14 @@ int perf_mem_events__parse(const char *str)
> >>  static bool perf_mem_event__supported(const char *mnt, struct perf_pm=
u
> >> *pmu,
> >>                                       struct perf_mem_event *e)
> >>  {
> >> -       char sysfs_name[100];
> >>         char path[PATH_MAX];
> >>         struct stat st;
> >>
> >> -       scnprintf(sysfs_name, sizeof(sysfs_name), e->sysfs_name, pmu->=
name);
> >> -       scnprintf(path, PATH_MAX, "%s/devices/%s", mnt, sysfs_name);
> >> +       if (strstarts(e->sysfs_name, "event/"))
> >> +               scnprintf(path, PATH_MAX, "%s/devices/%s/%s", mnt, pmu=
->name,
> >> e->sysfs_name);
> >> +       else
> >> +               scnprintf(path, PATH_MAX, "%s/devices/%s", mnt, e->sys=
fs_name);
> >> +
> >>         return !stat(path, &st);
> >>  }
> >
> > Thanks Kan, how about we move forward with the patch as is. I'm just
> > moaning as I think there is a longer term tech debt issue we should be
> > cleaning up. What I'm imagining in some crude hacking for just the
> > mem-events list case is:
> >
> > ```
> > --- a/tools/perf/util/mem-events.c
> > +++ b/tools/perf/util/mem-events.c
> > @@ -149,17 +149,19 @@ int perf_mem_events__init(void)
> >
> > void perf_mem_events__list(void)
> > {
> > -       int j;
> > -
> > -       for (j =3D 0; j < PERF_MEM_EVENTS__MAX; j++) {
> > -               struct perf_mem_event *e =3D perf_mem_events__ptr(j);
> > +       static const char *mem_event_names[PERF_MEM_EVENTS__MAX] =3D {
> > +               [PERF_MEM_EVENTS__LOAD] =3D "...load...",
> > +               [PERF_MEM_EVENTS__STORE] =3D "...store...",
> > +               [PERF_MEM_EVENTS__ACCESS] =3D "...access...",
> > +       };
> > +       while ((pmu =3D perf_pmus__scan(pmu)) !=3D NULL) {
> > +               if (!perf_pmu__mem_events_supported(pmu))
> > +                       continue;
> >
> > -               fprintf(stderr, "%-*s%-*s%s",
> > -                       e->tag ? 13 : 0,
> > -                       e->tag ? : "",
> > -                       e->tag && verbose > 0 ? 25 : 0,
> > -                       e->tag && verbose > 0 ?
> > perf_mem_events__name(j, NULL) : "",
> > -                       e->supported ? ": available\n" : "");
> > +               for (int i =3D 0; i < PERF_MEM_EVENTS__MAX; i++) {
> > +                       if (perf_pmu__mem_event_supported(pmu, i))
> > +                               printf("%s\n", mem_event_names[i]);
> > +               }
> >        }
> > }
> >
>
> This will be a user visiable change. We may don't want to chage it in a
> cleanup patch. I'm not sure if anyone relies on the output.
>
> $ sudo perf mem record -e list
> ldlat-loads  : available
> ldlat-stores : available
>
>
>
> > diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> > index 3c9609944a2f..e7f4f7d3d082 100644
> > --- a/tools/perf/util/pmu.c
> > +++ b/tools/perf/util/pmu.c
> > @@ -1578,6 +1578,34 @@ int perf_pmu__find_event(struct perf_pmu *pmu,
> > const char *event, void *state, p
> >                                        &args, find_event_callback);
> > }
> >
> > +bool perf_pmu__mem_events_supported(const struct perf_pmu *pmu)
> > +{
> > +       if (pmu->is_core && is_intel()) {
> > +               return true;
> > +       }
> > +       if (strcmp(pmu->name, "ibs_op")) {
> > +               return true;
> > +       }
> > +       if (ARM...) {
> > +       }
> > +       return false;
> > +}
> > +
> > +bool perf_pmu__mem_event_supported(const struct perf_pmu *pmu, enum
> > mem_event_type type)
> > +{
> > +       if (pmu->is_core && is_intel()) {
> > +               switch (type) {
> > +               case PERF_MEM_EVENTS__LOAD:
> > +                       return perf_pmu__have_event(pmu, "mem-loads");
> > +               case PERF_MEM_EVENTS__STORES:
> > +                       return perf_pmu__have_event(pmu, "mem-stores");
> > +               default:
> > +                       return false;
> > +               }
> > +       }
> > +       ...
> > +}
>
> I think we'd better keep the ARCH details in the arch specific files.
>
> > +
> > static void perf_pmu__del_formats(struct list_head *formats)
> > {
> >        struct perf_pmu_format *fmt, *tmp;
> > diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> > index 424c3fee0949..414f0fbd77a8 100644
> > --- a/tools/perf/util/pmu.h
> > +++ b/tools/perf/util/pmu.h
> > @@ -26,6 +26,13 @@ enum {
> > #define PERF_PMU_FORMAT_BITS 64
> > #define MAX_PMU_NAME_LEN 128
> >
> > +enum mem_event_type {
> > +       PERF_MEM_EVENTS__LOAD,
> > +       PERF_MEM_EVENTS__STORE,
> > +       PERF_MEM_EVENTS__ACCESS,
> > +       PERF_MEM_EVENTS__MAX,
> > +};
> > +
> > struct perf_event_attr;
> >
> > struct perf_pmu_caps {
> > @@ -204,6 +211,8 @@ int perf_pmu__check_alias(struct perf_pmu *pmu,
> > struct parse_events_terms *head_
> >                          struct perf_pmu_info *info, bool *rewrote_term=
s,
> >                          struct parse_events_error *err);
> > int perf_pmu__find_event(struct perf_pmu *pmu, const char *event, void
> > *state, pmu_event_callback cb);
> > +bool perf_pmu__mem_events_supported(const struct perf_pmu *pmu);
> > +bool perf_pmu__mem_event_supported(const struct perf_pmu *pmu, enum
> > mem_event_types type);
> >
> > int perf_pmu__format_parse(struct perf_pmu *pmu, int dirfd, bool eager_=
load);
> > void perf_pmu_format__set_value(void *format, int config, unsigned long=
 *bits);
> > ```
> >
> > or maybe we can have some state in struct pmu and have the
> > perf_pmu__arch_init set that up. Like a bitmask of supported mem
> > events.
> >
> > I'd kind of like the arch init perf pmu code to be as little as
> > possible. So if you did user space emulation of ARM on Intel (Intel
> > does this with houdini), then you could still read memory bandwidth
> > numbers from the Intel PMU as the logic isn't hidden and is generic.
> > Of course "cpu" is something of a special case PMU.
>
> I'm thinking to add the perf_mem_events struct into the perf_pmu. For
> example,
>
> diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pm=
u.c
> index 469555ae9b3c..c7d476218793 100644
> --- a/tools/perf/arch/x86/util/pmu.c
> +++ b/tools/perf/arch/x86/util/pmu.c
> @@ -30,6 +30,11 @@ void perf_pmu__arch_init(struct perf_pmu *pmu
> __maybe_unused)
>                 pmu->selectable =3D true;
>         }
>  #endif
> +       if (x86__is_amd_cpu()) {
> +               if (strcmp(pmu->name, "ibs_op"))
> +                       pmu->mem_event =3D perf_mem_events_amd;
> +       } else if (pmu->is_core)
> +               pmu->mem_event =3D perf_mem_events_intel;
>  }
>
>  int perf_pmus__num_mem_pmus(void)
> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> index d2895d415f08..6acad509f44a 100644
> --- a/tools/perf/util/pmu.h
> +++ b/tools/perf/util/pmu.h
> @@ -162,6 +162,8 @@ struct perf_pmu {
>                  */
>                 bool exclude_guest;
>         } missing_features;
> +
> +       struct perf_mem_event   *mem_event;
>  };
>
>
> It should not be hard to add a perf_pmus__scan_mem() to replace the
> current logic of searching the mem_event supported PMU.
>
> The perf_mem_events__ptr() should be simply replaced by pmu->mem_event.
>
> The perf_mem_events__name() can also be replaced similarly, but have to
> specially handle the mem-loads-aux. Maybe we can create a
> perf_mem_events_intel_aux[], and use it in the perf_pmu__arch_init()
> when perf_pmus__have_event(pmu, "mem-loads-aux").
>
> I will implement some codes and see how it goes.
>
> >
> > Anyway, if you don't feel like the refactor we can move forward with
> > this or a v2, let me know.
>
> I think the refactor is doable. I will work on it next week.
> But I think it should be on top of this fix.
> If you are OK with the fix, I think it's better to have it merged first.
> So everything would work properly. The validation work will not be blocke=
d.
> Then I can send a patch set to cleanup the perf mem events separately.

Thanks Kan.

Acked-by: Ian Rogers <irogers@google.com>

Ian

> Thanks,
> Kan
> >
> > Thanks,
> > Ian
> >
> >> Thanks,
> >> Kan
> >>
> >>> Thanks,
> >>> Ian
> >>>
> >>>> Thanks,
> >>>> Kan
> >>>>>
> >>>>> Thanks,
> >>>>> Ian
> >>>>>
> >>>>>>         scnprintf(path, PATH_MAX, "%s/devices/%s", mnt, sysfs_name=
);
> >>>>>>         return !stat(path, &st);
> >>>>>>  }
> >>>>>> @@ -120,7 +123,6 @@ int perf_mem_events__init(void)
> >>>>>>
> >>>>>>         for (j =3D 0; j < PERF_MEM_EVENTS__MAX; j++) {
> >>>>>>                 struct perf_mem_event *e =3D perf_mem_events__ptr(=
j);
> >>>>>> -               char sysfs_name[100];
> >>>>>>                 struct perf_pmu *pmu =3D NULL;
> >>>>>>
> >>>>>>                 /*
> >>>>>> @@ -136,12 +138,12 @@ int perf_mem_events__init(void)
> >>>>>>                  * of core PMU.
> >>>>>>                  */
> >>>>>>                 while ((pmu =3D perf_pmus__scan(pmu)) !=3D NULL) {
> >>>>>> -                       scnprintf(sysfs_name, sizeof(sysfs_name), =
e->sysfs_name, pmu->name);
> >>>>>> -                       e->supported |=3D perf_mem_event__supporte=
d(mnt, sysfs_name);
> >>>>>> +                       e->supported |=3D perf_mem_event__supporte=
d(mnt, pmu, e);
> >>>>>> +                       if (e->supported) {
> >>>>>> +                               found =3D true;
> >>>>>> +                               break;
> >>>>>> +                       }
> >>>>>>                 }
> >>>>>> -
> >>>>>> -               if (e->supported)
> >>>>>> -                       found =3D true;
> >>>>>>         }
> >>>>>>
> >>>>>>         return found ? 0 : -ENOENT;
> >>>>>> @@ -167,13 +169,10 @@ static void perf_mem_events__print_unsupport=
_hybrid(struct perf_mem_event *e,
> >>>>>>                                                     int idx)
> >>>>>>  {
> >>>>>>         const char *mnt =3D sysfs__mount();
> >>>>>> -       char sysfs_name[100];
> >>>>>>         struct perf_pmu *pmu =3D NULL;
> >>>>>>
> >>>>>>         while ((pmu =3D perf_pmus__scan(pmu)) !=3D NULL) {
> >>>>>> -               scnprintf(sysfs_name, sizeof(sysfs_name), e->sysfs=
_name,
> >>>>>> -                         pmu->name);
> >>>>>> -               if (!perf_mem_event__supported(mnt, sysfs_name)) {
> >>>>>> +               if (!perf_mem_event__supported(mnt, pmu, e)) {
> >>>>>>                         pr_err("failed: event '%s' not supported\n=
",
> >>>>>>                                perf_mem_events__name(idx, pmu->nam=
e));
> >>>>>>                 }
> >>>>>> @@ -183,6 +182,7 @@ static void perf_mem_events__print_unsupport_h=
ybrid(struct perf_mem_event *e,
> >>>>>>  int perf_mem_events__record_args(const char **rec_argv, int *argv=
_nr,
> >>>>>>                                  char **rec_tmp, int *tmp_nr)
> >>>>>>  {
> >>>>>> +       const char *mnt =3D sysfs__mount();
> >>>>>>         int i =3D *argv_nr, k =3D 0;
> >>>>>>         struct perf_mem_event *e;
> >>>>>>
> >>>>>> @@ -211,6 +211,9 @@ int perf_mem_events__record_args(const char **=
rec_argv, int *argv_nr,
> >>>>>>                         while ((pmu =3D perf_pmus__scan(pmu)) !=3D=
 NULL) {
> >>>>>>                                 const char *s =3D perf_mem_events_=
_name(j, pmu->name);
> >>>>>>
> >>>>>> +                               if (!perf_mem_event__supported(mnt=
, pmu, e))
> >>>>>> +                                       continue;
> >>>>>> +
> >>>>>>                                 rec_argv[i++] =3D "-e";
> >>>>>>                                 if (s) {
> >>>>>>                                         char *copy =3D strdup(s);
> >>>>>> --
> >>>>>> 2.35.1
> >>>>>>
> >>>
