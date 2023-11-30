Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE66A7FFCB1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 21:36:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376409AbjK3Uga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 15:36:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235194AbjK3Ug1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 15:36:27 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BEC8171F
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 12:36:32 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-50bbf7a6029so422e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 12:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701376590; x=1701981390; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j8bY3oTO7Qz0RyadKs7ko8nqkJKt+6qCzIYdcSLQsM0=;
        b=1llZdystjwPLS5iVxCtiLEe3dZ9m6/GXqobNRyCBO37zAep2cQFKexsbZ0eQ4cZf9n
         RJaJixUz/A1hb5eglg77CPwl+v65niEWHVz88fOcCWjKgR6UWWT/0diZhQUhHCElV+Y0
         CcH40G7DhN+coIarwuN9vS/dVqwePrg+P28+zB5X9pyvvdvfSttoDV/SGKiguR915GBF
         3zbCLcjxmW/5rE1fRkUo6151i9KFzSG8FUxGZXJBhSxEinFyfQFRObtP468fH3sAlGTF
         U4uGXqbBt35CRZsntyTfDbKq0YGFTD5J7lGJ8mb/PU5mu0awcO78MXuvQMESUD+HIFZT
         NXAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701376590; x=1701981390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j8bY3oTO7Qz0RyadKs7ko8nqkJKt+6qCzIYdcSLQsM0=;
        b=dXJjMuCOL2Bd119PqSoJ26mjc8SkVOPdhuWq85M3eKXJJphMQGNUeg7kco86LiTnD+
         XB1Fi/GobeConQvQKyWkB0PYJAXc7rGMZBCDc7WIZ2ijk0Nq9xBKQLVhXfD8tI5LyIuq
         B+nYmxoSKRDjhicdkUv1/N6vwkTTHUb1Gfj0fNGbbHqEohKl1BUJxPwaqUlbAyLsBSV8
         KE0Ch2rxaa/vK9jfEvXicfkTdy2sHB4CYTzU9Y/mbSYMM+pptBm5kwwiMISZxfICop9A
         CXY0S50xUmS63r3ap35sXZTgUNOvxcY38PyaJfpL5oEQ5QlJ/Cnb/fz9juD4AVdl4Fv6
         bUZA==
X-Gm-Message-State: AOJu0YwCVtwNZ+td34uJaaHrOHi9+ntb/PpP6wqMogxH7f7FGbvkzY4I
        SI+/VYHqleegPjhGzK08E+b6suiHbav/ntWC6zZ9zA==
X-Google-Smtp-Source: AGHT+IHtspDoySrYyYgaJz669NoazKcF50K2HGwPpxb6rTfM6COGtHo83jmHJlXwu81al7ODZtZai5sMlZUPhrLSYyg=
X-Received: by 2002:ac2:4a99:0:b0:4fe:ffbc:ac98 with SMTP id
 l25-20020ac24a99000000b004feffbcac98mr7249lfp.4.1701376589967; Thu, 30 Nov
 2023 12:36:29 -0800 (PST)
MIME-Version: 1.0
References: <20231128203940.3964287-1-kan.liang@linux.intel.com>
 <CAP-5=fUdEgnwk_FNHb-Ju3wCYE2PLLrPHqwZoyBGyURXQhBeSA@mail.gmail.com>
 <083bfe11-6f6e-487f-ac28-aec22e6b6b06@linux.intel.com> <CAP-5=fXTYX6_QdR4RCBu9yh+k1VwhsTjabKdseVP9Cvi6PE=sA@mail.gmail.com>
 <f5112f5e-c77c-4a9a-ac3b-66772adba471@linux.intel.com>
In-Reply-To: <f5112f5e-c77c-4a9a-ac3b-66772adba471@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 30 Nov 2023 12:36:18 -0800
Message-ID: <CAP-5=fU6EXenN9uU1DZ3X=L+k6Y-4a-XESfY9gL9ZCowhSazWA@mail.gmail.com>
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 1:15=E2=80=AFPM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
>
>
>
> On 2023-11-29 11:17 a.m., Ian Rogers wrote:
> > On Wed, Nov 29, 2023 at 5:52=E2=80=AFAM Liang, Kan <kan.liang@linux.int=
el.com> wrote:
> >>
> >>
> >>
> >> On 2023-11-29 1:24 a.m., Ian Rogers wrote:
> >>> On Tue, Nov 28, 2023 at 12:39=E2=80=AFPM <kan.liang@linux.intel.com> =
wrote:
> >>>>
> >>>> From: Kan Liang <kan.liang@linux.intel.com>
> >>>>
> >>>> The below error can be triggered on a hybrid machine.
> >>>>
> >>>>  $ perf mem record -t load sleep 1
> >>>>  event syntax error: 'breakpoint/mem-loads,ldlat=3D30/P'
> >>>>                                 \___ Bad event or PMU
> >>>>
> >>>>  Unable to find PMU or event on a PMU of 'breakpoint'
> >>>>
> >>>> In the perf_mem_events__record_args(), the current perf never checks=
 the
> >>>> availability of a mem event on a given PMU. All the PMUs will be add=
ed
> >>>> to the perf mem event list. Perf errors out for the unsupported PMU.
> >>>>
> >>>> Extend perf_mem_event__supported() and take a PMU into account. Chec=
k
> >>>> the mem event for each PMU before adding it to the perf mem event li=
st.
> >>>>
> >>>> Optimize the perf_mem_events__init() a little bit. The function is t=
o
> >>>> check whether the mem events are supported in the system. It doesn't
> >>>> need to scan all PMUs. Just return with the first supported PMU is g=
ood
> >>>> enough.
> >>>>
> >>>> Fixes: 5752c20f3787 ("perf mem: Scan all PMUs instead of just core o=
nes")
> >>>> Reported-by: Ammy Yi <ammy.yi@intel.com>
> >>>> Tested-by: Ammy Yi <ammy.yi@intel.com>
> >>>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> >>>> ---
> >>>>  tools/perf/util/mem-events.c | 25 ++++++++++++++-----------
> >>>>  1 file changed, 14 insertions(+), 11 deletions(-)
> >>>>
> >>>> diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-even=
ts.c
> >>>> index 954b235e12e5..3a2e3687878c 100644
> >>>> --- a/tools/perf/util/mem-events.c
> >>>> +++ b/tools/perf/util/mem-events.c
> >>>> @@ -100,11 +100,14 @@ int perf_mem_events__parse(const char *str)
> >>>>         return -1;
> >>>>  }
> >>>>
> >>>> -static bool perf_mem_event__supported(const char *mnt, char *sysfs_=
name)
> >>>> +static bool perf_mem_event__supported(const char *mnt, struct perf_=
pmu *pmu,
> >>>> +                                     struct perf_mem_event *e)
> >>>>  {
> >>>> +       char sysfs_name[100];
> >>>>         char path[PATH_MAX];
> >>>>         struct stat st;
> >>>>
> >>>> +       scnprintf(sysfs_name, sizeof(sysfs_name), e->sysfs_name, pmu=
->name);
> >>>
> >>> Not sure if this is right. Looking at sysfs_name values:
> >>> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.=
git/tree/tools/perf/util/mem-events.c?h=3Dperf-tools-next#n23
> >>> "cpu/events/mem-loads" and "cpu/events/mem-stores", so won't pmu->nam=
e
> >>> never be used?
> >>> Is there a missed change to change the cpu to %s?
> >>
> >> There is a X86 specific perf_mem_events__ptr(), which uses the
> >> "%s/mem-loads,ldlat=3D%u/P" and "%s/events/mem-loads" for Intel platfo=
rms.
> >> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.g=
it/tree/tools/perf/arch/x86/util/mem-events.c?h=3Dperf-tools-next#n20
> >> The pmu->name is used especially for the hybrid platforms.
> >
> > Right, that seems wrong. For one thing we're losing the compiler's
> > format string argument checking, but hardcoding PMU names just seems
> > to be something that will keep needing maintenance. This patch set
> > looks to fix an Intel issue but in general it is increasing tech debt
> > (or at least churning it) that will need cleaning up to do something
> > with better error checking and more generic. perf_mem_event looks like
> > a bad abstraction and then there are the integers whose special values
> > hold meaning. Could this fix come with some cleanup? It wouldn't seem
> > wrong to me to add notions of memory events to the PMU abstraction. As
> > it stands this scnprintf looks wrong in non-Intel cases.
> >
>
> The problem is that different ARCHs check different things. Arm and AMD
> checks the PMU name, while Intel and Power checks the specific events.
> It's hard to have a unified scnprintf.
>
> But we can abstract them into two cases, PMU name and event name. We use
> a different scnprintf to handle them.
> How about something as below?
>
> diff --git a/tools/perf/arch/x86/util/mem-events.c
> b/tools/perf/arch/x86/util/mem-events.c
> index 191b372f9a2d..4ef70fb9132b 100644
> --- a/tools/perf/arch/x86/util/mem-events.c
> +++ b/tools/perf/arch/x86/util/mem-events.c
> @@ -17,8 +17,8 @@ static char mem_stores_name[100];
>  #define E(t, n, s) { .tag =3D t, .name =3D n, .sysfs_name =3D s }
>
>  static struct perf_mem_event
> perf_mem_events_intel[PERF_MEM_EVENTS__MAX] =3D {
> -       E("ldlat-loads",        "%s/mem-loads,ldlat=3D%u/P",      "%s/eve=
nts/mem-loads"),
> -       E("ldlat-stores",       "%s/mem-stores/P",              "%s/event=
s/mem-stores"),
> +       E("ldlat-loads",        "%s/mem-loads,ldlat=3D%u/P",      "events=
/mem-loads"),
> +       E("ldlat-stores",       "%s/mem-stores/P",              "events/m=
em-stores"),
>         E(NULL,                 NULL,                           NULL),
>  };
>
> diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
> index 3a2e3687878c..ba88cb3d804f 100644
> --- a/tools/perf/util/mem-events.c
> +++ b/tools/perf/util/mem-events.c
> @@ -8,6 +8,7 @@
>  #include <unistd.h>
>  #include <api/fs/fs.h>
>  #include <linux/kernel.h>
> +#include <linux/string.h>
>  #include "map_symbol.h"
>  #include "mem-events.h"
>  #include "debug.h"
> @@ -20,8 +21,8 @@ unsigned int perf_mem_events__loads_ldlat =3D 30;
>  #define E(t, n, s) { .tag =3D t, .name =3D n, .sysfs_name =3D s }
>
>  static struct perf_mem_event perf_mem_events[PERF_MEM_EVENTS__MAX] =3D {
> -       E("ldlat-loads",        "cpu/mem-loads,ldlat=3D%u/P",     "cpu/ev=
ents/mem-loads"),
> -       E("ldlat-stores",       "cpu/mem-stores/P",             "cpu/even=
ts/mem-stores"),
> +       E("ldlat-loads",        "cpu/mem-loads,ldlat=3D%u/P",     "events=
/mem-loads"),
> +       E("ldlat-stores",       "cpu/mem-stores/P",             "events/m=
em-stores"),
>         E(NULL,                 NULL,                           NULL),
>  };
>  #undef E
> @@ -103,12 +104,14 @@ int perf_mem_events__parse(const char *str)
>  static bool perf_mem_event__supported(const char *mnt, struct perf_pmu
> *pmu,
>                                       struct perf_mem_event *e)
>  {
> -       char sysfs_name[100];
>         char path[PATH_MAX];
>         struct stat st;
>
> -       scnprintf(sysfs_name, sizeof(sysfs_name), e->sysfs_name, pmu->nam=
e);
> -       scnprintf(path, PATH_MAX, "%s/devices/%s", mnt, sysfs_name);
> +       if (strstarts(e->sysfs_name, "event/"))
> +               scnprintf(path, PATH_MAX, "%s/devices/%s/%s", mnt, pmu->n=
ame,
> e->sysfs_name);
> +       else
> +               scnprintf(path, PATH_MAX, "%s/devices/%s", mnt, e->sysfs_=
name);
> +
>         return !stat(path, &st);
>  }

Thanks Kan, how about we move forward with the patch as is. I'm just
moaning as I think there is a longer term tech debt issue we should be
cleaning up. What I'm imagining in some crude hacking for just the
mem-events list case is:

```
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -149,17 +149,19 @@ int perf_mem_events__init(void)

void perf_mem_events__list(void)
{
-       int j;
-
-       for (j =3D 0; j < PERF_MEM_EVENTS__MAX; j++) {
-               struct perf_mem_event *e =3D perf_mem_events__ptr(j);
+       static const char *mem_event_names[PERF_MEM_EVENTS__MAX] =3D {
+               [PERF_MEM_EVENTS__LOAD] =3D "...load...",
+               [PERF_MEM_EVENTS__STORE] =3D "...store...",
+               [PERF_MEM_EVENTS__ACCESS] =3D "...access...",
+       };
+       while ((pmu =3D perf_pmus__scan(pmu)) !=3D NULL) {
+               if (!perf_pmu__mem_events_supported(pmu))
+                       continue;

-               fprintf(stderr, "%-*s%-*s%s",
-                       e->tag ? 13 : 0,
-                       e->tag ? : "",
-                       e->tag && verbose > 0 ? 25 : 0,
-                       e->tag && verbose > 0 ?
perf_mem_events__name(j, NULL) : "",
-                       e->supported ? ": available\n" : "");
+               for (int i =3D 0; i < PERF_MEM_EVENTS__MAX; i++) {
+                       if (perf_pmu__mem_event_supported(pmu, i))
+                               printf("%s\n", mem_event_names[i]);
+               }
       }
}

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 3c9609944a2f..e7f4f7d3d082 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1578,6 +1578,34 @@ int perf_pmu__find_event(struct perf_pmu *pmu,
const char *event, void *state, p
                                       &args, find_event_callback);
}

+bool perf_pmu__mem_events_supported(const struct perf_pmu *pmu)
+{
+       if (pmu->is_core && is_intel()) {
+               return true;
+       }
+       if (strcmp(pmu->name, "ibs_op")) {
+               return true;
+       }
+       if (ARM...) {
+       }
+       return false;
+}
+
+bool perf_pmu__mem_event_supported(const struct perf_pmu *pmu, enum
mem_event_type type)
+{
+       if (pmu->is_core && is_intel()) {
+               switch (type) {
+               case PERF_MEM_EVENTS__LOAD:
+                       return perf_pmu__have_event(pmu, "mem-loads");
+               case PERF_MEM_EVENTS__STORES:
+                       return perf_pmu__have_event(pmu, "mem-stores");
+               default:
+                       return false;
+               }
+       }
+       ...
+}
+
static void perf_pmu__del_formats(struct list_head *formats)
{
       struct perf_pmu_format *fmt, *tmp;
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 424c3fee0949..414f0fbd77a8 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -26,6 +26,13 @@ enum {
#define PERF_PMU_FORMAT_BITS 64
#define MAX_PMU_NAME_LEN 128

+enum mem_event_type {
+       PERF_MEM_EVENTS__LOAD,
+       PERF_MEM_EVENTS__STORE,
+       PERF_MEM_EVENTS__ACCESS,
+       PERF_MEM_EVENTS__MAX,
+};
+
struct perf_event_attr;

struct perf_pmu_caps {
@@ -204,6 +211,8 @@ int perf_pmu__check_alias(struct perf_pmu *pmu,
struct parse_events_terms *head_
                         struct perf_pmu_info *info, bool *rewrote_terms,
                         struct parse_events_error *err);
int perf_pmu__find_event(struct perf_pmu *pmu, const char *event, void
*state, pmu_event_callback cb);
+bool perf_pmu__mem_events_supported(const struct perf_pmu *pmu);
+bool perf_pmu__mem_event_supported(const struct perf_pmu *pmu, enum
mem_event_types type);

int perf_pmu__format_parse(struct perf_pmu *pmu, int dirfd, bool eager_load=
);
void perf_pmu_format__set_value(void *format, int config, unsigned long *bi=
ts);
```

or maybe we can have some state in struct pmu and have the
perf_pmu__arch_init set that up. Like a bitmask of supported mem
events.

I'd kind of like the arch init perf pmu code to be as little as
possible. So if you did user space emulation of ARM on Intel (Intel
does this with houdini), then you could still read memory bandwidth
numbers from the Intel PMU as the logic isn't hidden and is generic.
Of course "cpu" is something of a special case PMU.

Anyway, if you don't feel like the refactor we can move forward with
this or a v2, let me know.

Thanks,
Ian

> Thanks,
> Kan
>
> > Thanks,
> > Ian
> >
> >> Thanks,
> >> Kan
> >>>
> >>> Thanks,
> >>> Ian
> >>>
> >>>>         scnprintf(path, PATH_MAX, "%s/devices/%s", mnt, sysfs_name);
> >>>>         return !stat(path, &st);
> >>>>  }
> >>>> @@ -120,7 +123,6 @@ int perf_mem_events__init(void)
> >>>>
> >>>>         for (j =3D 0; j < PERF_MEM_EVENTS__MAX; j++) {
> >>>>                 struct perf_mem_event *e =3D perf_mem_events__ptr(j)=
;
> >>>> -               char sysfs_name[100];
> >>>>                 struct perf_pmu *pmu =3D NULL;
> >>>>
> >>>>                 /*
> >>>> @@ -136,12 +138,12 @@ int perf_mem_events__init(void)
> >>>>                  * of core PMU.
> >>>>                  */
> >>>>                 while ((pmu =3D perf_pmus__scan(pmu)) !=3D NULL) {
> >>>> -                       scnprintf(sysfs_name, sizeof(sysfs_name), e-=
>sysfs_name, pmu->name);
> >>>> -                       e->supported |=3D perf_mem_event__supported(=
mnt, sysfs_name);
> >>>> +                       e->supported |=3D perf_mem_event__supported(=
mnt, pmu, e);
> >>>> +                       if (e->supported) {
> >>>> +                               found =3D true;
> >>>> +                               break;
> >>>> +                       }
> >>>>                 }
> >>>> -
> >>>> -               if (e->supported)
> >>>> -                       found =3D true;
> >>>>         }
> >>>>
> >>>>         return found ? 0 : -ENOENT;
> >>>> @@ -167,13 +169,10 @@ static void perf_mem_events__print_unsupport_h=
ybrid(struct perf_mem_event *e,
> >>>>                                                     int idx)
> >>>>  {
> >>>>         const char *mnt =3D sysfs__mount();
> >>>> -       char sysfs_name[100];
> >>>>         struct perf_pmu *pmu =3D NULL;
> >>>>
> >>>>         while ((pmu =3D perf_pmus__scan(pmu)) !=3D NULL) {
> >>>> -               scnprintf(sysfs_name, sizeof(sysfs_name), e->sysfs_n=
ame,
> >>>> -                         pmu->name);
> >>>> -               if (!perf_mem_event__supported(mnt, sysfs_name)) {
> >>>> +               if (!perf_mem_event__supported(mnt, pmu, e)) {
> >>>>                         pr_err("failed: event '%s' not supported\n",
> >>>>                                perf_mem_events__name(idx, pmu->name)=
);
> >>>>                 }
> >>>> @@ -183,6 +182,7 @@ static void perf_mem_events__print_unsupport_hyb=
rid(struct perf_mem_event *e,
> >>>>  int perf_mem_events__record_args(const char **rec_argv, int *argv_n=
r,
> >>>>                                  char **rec_tmp, int *tmp_nr)
> >>>>  {
> >>>> +       const char *mnt =3D sysfs__mount();
> >>>>         int i =3D *argv_nr, k =3D 0;
> >>>>         struct perf_mem_event *e;
> >>>>
> >>>> @@ -211,6 +211,9 @@ int perf_mem_events__record_args(const char **re=
c_argv, int *argv_nr,
> >>>>                         while ((pmu =3D perf_pmus__scan(pmu)) !=3D N=
ULL) {
> >>>>                                 const char *s =3D perf_mem_events__n=
ame(j, pmu->name);
> >>>>
> >>>> +                               if (!perf_mem_event__supported(mnt, =
pmu, e))
> >>>> +                                       continue;
> >>>> +
> >>>>                                 rec_argv[i++] =3D "-e";
> >>>>                                 if (s) {
> >>>>                                         char *copy =3D strdup(s);
> >>>> --
> >>>> 2.35.1
> >>>>
> >
