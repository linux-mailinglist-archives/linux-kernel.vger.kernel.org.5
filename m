Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9789978DE53
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 21:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240079AbjH3TBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245297AbjH3PFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 11:05:05 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3355D1A2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 08:05:02 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-40a47e8e38dso274261cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 08:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693407901; x=1694012701; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bRYvKIT+NMm0FQkbMRIkQEoaTCJBt0v+TWNADtS115I=;
        b=CuMW3U9uDGqgMd12hkbR7XnCLQiiRfeKCpNzK7Dg5nx7DLfduvXu9fcRh8j7FTohc0
         UF/eP8RgXUchi4Eoj8sprPEUQVT1lZ6OgIVi2jg/vFugZz6MIbWdm7AtJLl5CQ91izng
         AOGshDhfEvzTwPYwFZO1G8bnxzEkbKzw6uTP5u4T37ELlZxwqj8v/rf1nMSPFhem7A/d
         vS+/TIQK8GJ3HBMHYw7hYHqnklLQfRNnFcOYv3UTCAh05PlDVvWfCuiBRG2E/Az12wOA
         K0WTNPlCRp+wTRiHR/0ugyyhZRSV5MnKb4pXmglb6kCC3HinugUHXJu5UlWPSNTEtwSY
         Ce/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693407901; x=1694012701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bRYvKIT+NMm0FQkbMRIkQEoaTCJBt0v+TWNADtS115I=;
        b=Ft9V/aWPpKP2acZgoyfthSy5HlFZTiGfNnbOLYPeeBBu7xu2wkmK7V4QeQkCA5PoEp
         5IBgPudsIjiyePPdhlAMOHZaIHN9qyGTfKAHp9gF0IPMnAnGakGVYsNjw55+UouSLzLZ
         WkFkHDLO2z8sEEmtzpRkBUsxsPG75DvJ3DaENI26FjcrHG4RHN+4KkXEbKfoQnFKU+Mq
         Q/nOUe/dK2EzW6qRBqAYBM91P4tFQAypEJqLRAkEe5npoZ6bia8WP48IJJPxkChmwQUF
         Z7nO+WaIT8HTI3iYQwXe3AWi4RpECclDGxlDrk3oRlTfVQ1fS3A/aJFWtkTjz9/OR//V
         CGwg==
X-Gm-Message-State: AOJu0YyqloQ8Ne/+SDm+EK3FE/fPHSyZaCJyrFjwhx4HEMLKsasWch3Y
        vBNtcwtBDi84jr2Lx/GojmJGaQAbDE/2tb6Q6tR/FA==
X-Google-Smtp-Source: AGHT+IFKr/8eHU7nx4nhII4SQkmep3KQK2kJ+b6SDkbwn6j19R4ATJMpxOy7XE9WeoP+c7gd9Bg5NWh4eKbEeUQYsY8=
X-Received: by 2002:ac8:4e4c:0:b0:40e:332b:ba30 with SMTP id
 e12-20020ac84e4c000000b0040e332bba30mr493825qtw.23.1693407901070; Wed, 30 Aug
 2023 08:05:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230830070753.1821629-1-irogers@google.com> <20230830070753.1821629-2-irogers@google.com>
 <4de84370-29f3-75ed-9c91-330636cdd790@linux.intel.com> <CAP-5=fXMgeER2FkAF2jZOAP0c=sxqhU8scxew6jXQrEYjN_S=Q@mail.gmail.com>
In-Reply-To: <CAP-5=fXMgeER2FkAF2jZOAP0c=sxqhU8scxew6jXQrEYjN_S=Q@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 30 Aug 2023 08:04:48 -0700
Message-ID: <CAP-5=fUXG9tfN2nahiVpBDiggkhmhFiBZYubCSN6vG4voJ_X2A@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] perf parse-events: Make common term list to strbuf helper
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 7:40=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> On Wed, Aug 30, 2023 at 7:15=E2=80=AFAM Liang, Kan <kan.liang@linux.intel=
.com> wrote:
> >
> >
> >
> > On 2023-08-30 3:07 a.m., Ian Rogers wrote:
> > > A term list is turned into a string for debug output and for the str
> > > value in the alias. Add a helper to do this based on existing code,
> > > but then fix for situations like events being identified. Use strbuf
> > > to manage the dynamic memory allocation and remove the 256 byte
> > > limit. Use in various places the string of the term list is required.
> > >
> > > Before:
> > > ```
> > > $ sudo perf stat -vv -e inst_retired.any true
> > > Using CPUID GenuineIntel-6-8D-1
> > > intel_pt default config: tsc,mtc,mtc_period=3D3,psb_period=3D3,pt,bra=
nch
> > > Attempting to add event pmu 'cpu' with 'inst_retired.any,' that may r=
esult in non-fatal errors
> > > After aliases, add event pmu 'cpu' with 'event,period,' that may resu=
lt in non-fatal errors
> > > inst_retired.any -> cpu/inst_retired.any/
> > > ...
> > > ```
> > >
> > > After:
> > > ```
> > > $ sudo perf stat -vv -e inst_retired.any true
> > > Using CPUID GenuineIntel-6-8D-1
> > > intel_pt default config: tsc,mtc,mtc_period=3D3,psb_period=3D3,pt,bra=
nch
> > > Attempt to add: cpu/inst_retired.any/
> > > ..after resolving event: cpu/event=3D0xc0,period=3D0x1e8483/
> > > inst_retired.any -> cpu/event=3D0xc0,period=3D0x1e8483/
> > > ...
> > > ```
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/perf/util/parse-events.c | 101 ++++++++++++++++++++++++-------=
--
> > >  tools/perf/util/parse-events.h |   2 +
> > >  tools/perf/util/pmu.c          |  19 ++-----
> > >  3 files changed, 81 insertions(+), 41 deletions(-)
> >
> > Which branch should I use to apply the patch?
> > I tried the perf-tools-next branch, but there is some conflict.
> > I'd like to do some tests on a hybrid machine.
>
> I was working on tmp.perf-tools-next but it is the same as
> perf-tools-next currently [1]. I had this 2 line patch in place:
> https://lore.kernel.org/lkml/20230830000545.1638964-1-irogers@google.com/
> so that may be the conflict.
>
> Thanks,
> Ian
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.=
git/log/?h=3Dtmp.perf-tools-next

Hmm.. for some reason I'm not seeing the message on LKML and so b4
fails. Anyway, applying the patches and running on an Alderlake I see:
```
$ perf stat -vv -e inst_retired.any true
Using CPUID GenuineIntel-6-97-2
Attempt to add: cpu_atom/inst_retired.any/
..after resolving event: cpu_atom/event=3D0xc0,period=3D0x1e8483/
inst_retired.any -> cpu_atom/event=3D0xc0,period=3D0x1e8483/
Attempt to add: cpu_core/inst_retired.any/
..after resolving event: cpu_core/event=3D0xc0,period=3D0x1e8483/
inst_retired.any -> cpu_core/event=3D0xc0,period=3D0x1e8483/
...
```
The previous output was like:
```
$ perf stat -vv -e inst_retired.any true
Using CPUID GenuineIntel-6-97-2
Attempting to add event pmu 'cpu_core' with 'inst_retired.any,' that
may result in non-fatal errors
After aliases, add event pmu 'cpu_core' with 'event,period,' that may
result in non-fatal errors
inst_retired.any -> cpu_core/event=3D0xc0,period=3D0x1e8483/
Attempting to add event pmu 'cpu_atom' with 'inst_retired.any,' that
may result in non-fatal errors
After aliases, add event pmu 'cpu_atom' with 'event,period,' that may
result in non-fatal errors
inst_retired.any -> cpu_atom/event=3D0xc0,period=3D0x1e8483/
...
```
Perhaps a more interesting example is:
```
$ perf stat -vv -e UOPS_RETIRED.MS true
Using CPUID GenuineIntel-6-97-2
Attempt to add: cpu_atom/UOPS_RETIRED.MS/
..after resolving event: cpu_atom/event=3D0xc2,period=3D0x1e8483,umask/
UOPS_RETIRED.MS -> cpu_atom/event=3D0xc2,period=3D0x1e8483,umask/
Attempt to add: cpu_core/UOPS_RETIRED.MS/
..after resolving event:
cpu_core/event=3D0xc2,period=3D0x1e8483,umask=3D0x4,frontend=3D0x8/
UOPS_RETIRED.MS -> cpu_core/event=3D0xc2,period=3D0x1e8483,umask=3D0x4,fron=
tend=3D0x8/
...
```
The umask not being printed for the cpu_atom is an issue. The problem
is how we encode terms of an event name, it is indistinguishable when
the of the user field is 1. I'll probably add something to fix this
later, but it only impacts debug output and perf list, so I'm not
overly worried. We could go in the other direction and instead of
printing say cpu_atom/UOPS_RETIRED.MS/ print
cpu_atom/UOPS_RETIRED.MS=3D1/, but I thought that was uglier and more
confusing.

Thanks,
Ian

> > Thanks,
> > Kan
> > >
> > > diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-e=
vents.c
> > > index 4c812fbe0cf9..0b941b58bdc0 100644
> > > --- a/tools/perf/util/parse-events.c
> > > +++ b/tools/perf/util/parse-events.c
> > > @@ -13,7 +13,7 @@
> > >  #include <subcmd/parse-options.h>
> > >  #include "parse-events.h"
> > >  #include "string2.h"
> > > -#include "strlist.h"
> > > +#include "strbuf.h"
> > >  #include "debug.h"
> > >  #include <api/fs/tracing_path.h>
> > >  #include <perf/cpumap.h>
> > > @@ -1303,19 +1303,6 @@ int parse_events_add_pmu(struct parse_events_s=
tate *parse_state,
> > >
> > >       pmu =3D parse_state->fake_pmu ?: perf_pmus__find(name);
> > >
> > > -     if (verbose > 1 && !(pmu && pmu->selectable)) {
> > > -             fprintf(stderr, "Attempting to add event pmu '%s' with =
'",
> > > -                     name);
> > > -             if (head_config) {
> > > -                     struct parse_events_term *term;
> > > -
> > > -                     list_for_each_entry(term, head_config, list) {
> > > -                             fprintf(stderr, "%s,", term->config);
> > > -                     }
> > > -             }
> > > -             fprintf(stderr, "' that may result in non-fatal errors\=
n");
> > > -     }
> > > -
> > >       if (!pmu) {
> > >               char *err_str;
> > >
> > > @@ -1325,6 +1312,21 @@ int parse_events_add_pmu(struct parse_events_s=
tate *parse_state,
> > >                       parse_events_error__handle(err, loc->first_colu=
mn, err_str, NULL);
> > >               return -EINVAL;
> > >       }
> > > +
> > > +     if (verbose > 1) {
> > > +             struct strbuf sb;
> > > +
> > > +             strbuf_init(&sb, /*hint=3D*/ 0);
> > > +             if (pmu->selectable && !head_config) {
> > > +                     strbuf_addf(&sb, "%s//", name);
> > > +             } else {
> > > +                     strbuf_addf(&sb, "%s/", name);
> > > +                     parse_events_term__to_strbuf(head_config, &sb);
> > > +                     strbuf_addch(&sb, '/');
> > > +             }
> > > +             fprintf(stderr, "Attempt to add: %s\n", sb.buf);
> > > +             strbuf_release(&sb);
> > > +     }
> > >       if (head_config)
> > >               fix_raw(head_config, pmu);
> > >
> > > @@ -1349,16 +1351,12 @@ int parse_events_add_pmu(struct parse_events_=
state *parse_state,
> > >               return -EINVAL;
> > >
> > >       if (verbose > 1) {
> > > -             fprintf(stderr, "After aliases, add event pmu '%s' with=
 '",
> > > -                     name);
> > > -             if (head_config) {
> > > -                     struct parse_events_term *term;
> > > +             struct strbuf sb;
> > >
> > > -                     list_for_each_entry(term, head_config, list) {
> > > -                             fprintf(stderr, "%s,", term->config);
> > > -                     }
> > > -             }
> > > -             fprintf(stderr, "' that may result in non-fatal errors\=
n");
> > > +             strbuf_init(&sb, /*hint=3D*/ 0);
> > > +             parse_events_term__to_strbuf(head_config, &sb);
> > > +             fprintf(stderr, "..after resolving event: %s/%s/\n", na=
me, sb.buf);
> > > +             strbuf_release(&sb);
> > >       }
> > >
> > >       /*
> > > @@ -1460,7 +1458,12 @@ int parse_events_multi_pmu_add(struct parse_ev=
ents_state *parse_state,
> > >               parse_events_copy_term_list(head, &orig_head);
> > >               if (!parse_events_add_pmu(parse_state, list, pmu->name,
> > >                                         orig_head, auto_merge_stats, =
loc)) {
> > > -                     pr_debug("%s -> %s/%s/\n", str, pmu->name, str)=
;
> > > +                     struct strbuf sb;
> > > +
> > > +                     strbuf_init(&sb, /*hint=3D*/ 0);
> > > +                     parse_events_term__to_strbuf(orig_head, &sb);
> > > +                     pr_debug("%s -> %s/%s/\n", str, pmu->name, sb.b=
uf);
> > > +                     strbuf_release(&sb);
> > >                       ok++;
> > >               }
> > >               parse_events_terms__delete(orig_head);
> > > @@ -1469,7 +1472,12 @@ int parse_events_multi_pmu_add(struct parse_ev=
ents_state *parse_state,
> > >       if (parse_state->fake_pmu) {
> > >               if (!parse_events_add_pmu(parse_state, list, str, head,
> > >                                         /*auto_merge_stats=3D*/true, =
loc)) {
> > > -                     pr_debug("%s -> %s/%s/\n", str, "fake_pmu", str=
);
> > > +                     struct strbuf sb;
> > > +
> > > +                     strbuf_init(&sb, /*hint=3D*/ 0);
> > > +                     parse_events_term__to_strbuf(head, &sb);
> > > +                     pr_debug("%s -> %s/%s/\n", str, "fake_pmu", sb.=
buf);
> > > +                     strbuf_release(&sb);
> > >                       ok++;
> > >               }
> > >       }
> > > @@ -2085,7 +2093,7 @@ void parse_events_error__handle(struct parse_ev=
ents_error *err, int idx,
> > >               break;
> > >       default:
> > >               pr_debug("Multiple errors dropping message: %s (%s)\n",
> > > -                     err->str, err->help);
> > > +                     err->str, err->help ?: "<no help>");
> > >               free(err->str);
> > >               err->str =3D str;
> > >               free(err->help);
> > > @@ -2502,6 +2510,47 @@ void parse_events_terms__delete(struct list_he=
ad *terms)
> > >       free(terms);
> > >  }
> > >
> > > +int parse_events_term__to_strbuf(struct list_head *term_list, struct=
 strbuf *sb)
> > > +{
> > > +     struct parse_events_term *term;
> > > +     bool first =3D true;
> > > +
> > > +     if (!term_list)
> > > +             return 0;
> > > +
> > > +     list_for_each_entry(term, term_list, list) {
> > > +             int ret;
> > > +
> > > +             if (!first) {
> > > +                     ret =3D strbuf_addch(sb, ',');
> > > +                     if (ret < 0)
> > > +                             return ret;
> > > +             }
> > > +             first =3D false;
> > > +
> > > +             if (term->type_val =3D=3D PARSE_EVENTS__TERM_TYPE_NUM)
> > > +                     if (term->type_term =3D=3D PARSE_EVENTS__TERM_T=
YPE_USER && term->val.num =3D=3D 1)
> > > +                             ret =3D strbuf_addf(sb, "%s", term->con=
fig);
> > > +                     else
> > > +                             ret =3D strbuf_addf(sb, "%s=3D%#"PRIx64=
, term->config, term->val.num);
> > > +             else if (term->type_val =3D=3D PARSE_EVENTS__TERM_TYPE_=
STR) {
> > > +                     if (term->config) {
> > > +                             ret =3D strbuf_addf(sb, "%s=3D", term->=
config);
> > > +                             if (ret < 0)
> > > +                                     return ret;
> > > +                     } else if (term->type_term < __PARSE_EVENTS__TE=
RM_TYPE_NR) {
> > > +                             ret =3D strbuf_addf(sb, "%s=3D", config=
_term_names[term->type_term]);
> > > +                             if (ret < 0)
> > > +                                     return ret;
> > > +                     }
> > > +                     ret =3D strbuf_addf(sb, "%s", term->val.str);
> > > +             }
> > > +             if (ret < 0)
> > > +                     return ret;
> > > +     }
> > > +     return 0;
> > > +}
> > > +
> > >  void parse_events_evlist_error(struct parse_events_state *parse_stat=
e,
> > >                              int idx, const char *str)
> > >  {
> > > diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-e=
vents.h
> > > index 6d75d853ce00..20bdc35d6112 100644
> > > --- a/tools/perf/util/parse-events.h
> > > +++ b/tools/perf/util/parse-events.h
> > > @@ -18,6 +18,7 @@ struct parse_events_error;
> > >
> > >  struct option;
> > >  struct perf_pmu;
> > > +struct strbuf;
> > >
> > >  const char *event_type(int type);
> > >
> > > @@ -152,6 +153,7 @@ int parse_events_term__clone(struct parse_events_=
term **new,
> > >  void parse_events_term__delete(struct parse_events_term *term);
> > >  void parse_events_terms__delete(struct list_head *terms);
> > >  void parse_events_terms__purge(struct list_head *terms);
> > > +int parse_events_term__to_strbuf(struct list_head *term_list, struct=
 strbuf *sb);
> > >  int parse_events__modifier_event(struct list_head *list, char *str, =
bool add);
> > >  int parse_events__modifier_group(struct list_head *list, char *event=
_mod);
> > >  int parse_events_name(struct list_head *list, const char *name);
> > > diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> > > index b3f8f3f1e900..8dbb7008877e 100644
> > > --- a/tools/perf/util/pmu.c
> > > +++ b/tools/perf/util/pmu.c
> > > @@ -507,12 +507,11 @@ static int perf_pmu__new_alias(struct perf_pmu =
*pmu, const char *name,
> > >                               const char *desc, const char *val, FILE=
 *val_fd,
> > >                               const struct pmu_event *pe)
> > >  {
> > > -     struct parse_events_term *term;
> > >       struct perf_pmu_alias *alias;
> > >       int ret;
> > > -     char newval[256];
> > >       const char *long_desc =3D NULL, *topic =3D NULL, *unit =3D NULL=
, *pmu_name =3D NULL;
> > >       bool deprecated =3D false, perpkg =3D false;
> > > +     struct strbuf sb;
> > >
> > >       if (perf_pmu__find_alias(pmu, name, /*load=3D*/ false)) {
> > >               /* Alias was already created/loaded. */
> > > @@ -582,20 +581,10 @@ static int perf_pmu__new_alias(struct perf_pmu =
*pmu, const char *name,
> > >        *
> > >        * Rebuild string to make alias->str member comparable.
> > >        */
> > > -     ret =3D 0;
> > > -     list_for_each_entry(term, &alias->terms, list) {
> > > -             if (ret)
> > > -                     ret +=3D scnprintf(newval + ret, sizeof(newval)=
 - ret,
> > > -                                      ",");
> > > -             if (term->type_val =3D=3D PARSE_EVENTS__TERM_TYPE_NUM)
> > > -                     ret +=3D scnprintf(newval + ret, sizeof(newval)=
 - ret,
> > > -                                      "%s=3D%#x", term->config, term=
->val.num);
> > > -             else if (term->type_val =3D=3D PARSE_EVENTS__TERM_TYPE_=
STR)
> > > -                     ret +=3D scnprintf(newval + ret, sizeof(newval)=
 - ret,
> > > -                                      "%s=3D%s", term->config, term-=
>val.str);
> > > -     }
> > >       zfree(&alias->str);
> > > -     alias->str =3D strdup(newval);
> > > +     strbuf_init(&sb, /*hint=3D*/ 0);
> > > +     parse_events_term__to_strbuf(&alias->terms, &sb);
> > > +     alias->str =3D strbuf_detach(&sb, /*sz=3D*/ NULL);
> > >       if (!pe)
> > >               pmu->sysfs_aliases++;
> > >       else
