Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBC778DF2B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344409AbjH3T1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245181AbjH3OlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 10:41:08 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB31193
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 07:41:04 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-4036bd4fff1so323271cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 07:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693406463; x=1694011263; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AbkEybAV1u5mPMGd18lt5Os7CJlxulZrRjPM+MRH/yE=;
        b=ibFE7otd+u0Pt+j3LGvCZvGlZSpkETVsaZtEph7Gz33AhCXLNM6G3Q6f+5jU1LbGwy
         m9SPeEjxPpSonNz1a3Pqarx9nlf38y6s16DvP6WRUbbVIGS+r6pYhriJXXEwmAPvrZYy
         Gb/72JuszPH3cAuPupa+N7hVpn4NHnDWjTggVy2hb7iZN0zIK5J2e9u8E2BjXTk56xaB
         2a+aP+qQ93MHWGNs1ZKkb+E3qiNM+cl95eQCvCPypy2uEWLpfbPEVeMKuYcxCl58gDkj
         hJQ5cAY6TgefjuPbynDxxEzIDaKoJqBYfrm9vLr2DY3Q1bt89g+z4N4/OAqsEuZFbrMR
         +SQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693406463; x=1694011263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AbkEybAV1u5mPMGd18lt5Os7CJlxulZrRjPM+MRH/yE=;
        b=Nt3jJoskxs7k1EvBHA8zVtQg2q6L5yt/CCUZJOXqbeVhnVO7gD0CdNRzZZVYOp15dZ
         4vv+xTBLYws4DUdK8HokhxtOFXQmLUFUXPiE86XE0xC0ORQOEQL4xMDQg4DSa3vXIN7I
         KFxSp4IWaQDSS9ePKgxaoCzqfbLD36hYRMw3Z913bwRn9ten7d/K4DnTAJwTTIY36DTr
         bkW8kY1VqN7BAVec6se5+jipCEj2LDRu3U1vVmcT1ncXMmW+CrSsJsBmHmDpHEbvH/S7
         Ziny2yyPR6T/zNfpM17uXhaaATwzonSkw7hpB7IQ0tDFKRuLnQO/ycgxWBeelj/d5Ej1
         SkRQ==
X-Gm-Message-State: AOJu0YwsShnUsgcfLtfHdzLZrxKkFi/mMitlaWV87tujsQRzbFO5UzVZ
        zUn640LSFWx7xGUd7/Wlx1ROHzI3iwGUyczhBjAuKA==
X-Google-Smtp-Source: AGHT+IFhtvXiehAKSCkB4Sr4PkwmxAxxPAEj2KAjPfa0l1wQm3+hgXxb88L3KxbvC0s1dWyLPPwQcC6FGQSgQahRtrA=
X-Received: by 2002:a05:622a:1a23:b0:3ef:5f97:258f with SMTP id
 f35-20020a05622a1a2300b003ef5f97258fmr543139qtb.16.1693406463437; Wed, 30 Aug
 2023 07:41:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230830070753.1821629-1-irogers@google.com> <20230830070753.1821629-2-irogers@google.com>
 <4de84370-29f3-75ed-9c91-330636cdd790@linux.intel.com>
In-Reply-To: <4de84370-29f3-75ed-9c91-330636cdd790@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 30 Aug 2023 07:40:50 -0700
Message-ID: <CAP-5=fXMgeER2FkAF2jZOAP0c=sxqhU8scxew6jXQrEYjN_S=Q@mail.gmail.com>
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

On Wed, Aug 30, 2023 at 7:15=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
>
>
>
> On 2023-08-30 3:07 a.m., Ian Rogers wrote:
> > A term list is turned into a string for debug output and for the str
> > value in the alias. Add a helper to do this based on existing code,
> > but then fix for situations like events being identified. Use strbuf
> > to manage the dynamic memory allocation and remove the 256 byte
> > limit. Use in various places the string of the term list is required.
> >
> > Before:
> > ```
> > $ sudo perf stat -vv -e inst_retired.any true
> > Using CPUID GenuineIntel-6-8D-1
> > intel_pt default config: tsc,mtc,mtc_period=3D3,psb_period=3D3,pt,branc=
h
> > Attempting to add event pmu 'cpu' with 'inst_retired.any,' that may res=
ult in non-fatal errors
> > After aliases, add event pmu 'cpu' with 'event,period,' that may result=
 in non-fatal errors
> > inst_retired.any -> cpu/inst_retired.any/
> > ...
> > ```
> >
> > After:
> > ```
> > $ sudo perf stat -vv -e inst_retired.any true
> > Using CPUID GenuineIntel-6-8D-1
> > intel_pt default config: tsc,mtc,mtc_period=3D3,psb_period=3D3,pt,branc=
h
> > Attempt to add: cpu/inst_retired.any/
> > ..after resolving event: cpu/event=3D0xc0,period=3D0x1e8483/
> > inst_retired.any -> cpu/event=3D0xc0,period=3D0x1e8483/
> > ...
> > ```
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/parse-events.c | 101 ++++++++++++++++++++++++---------
> >  tools/perf/util/parse-events.h |   2 +
> >  tools/perf/util/pmu.c          |  19 ++-----
> >  3 files changed, 81 insertions(+), 41 deletions(-)
>
> Which branch should I use to apply the patch?
> I tried the perf-tools-next branch, but there is some conflict.
> I'd like to do some tests on a hybrid machine.

I was working on tmp.perf-tools-next but it is the same as
perf-tools-next currently [1]. I had this 2 line patch in place:
https://lore.kernel.org/lkml/20230830000545.1638964-1-irogers@google.com/
so that may be the conflict.

Thanks,
Ian

[1] https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/log/?h=3Dtmp.perf-tools-next

> Thanks,
> Kan
> >
> > diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-eve=
nts.c
> > index 4c812fbe0cf9..0b941b58bdc0 100644
> > --- a/tools/perf/util/parse-events.c
> > +++ b/tools/perf/util/parse-events.c
> > @@ -13,7 +13,7 @@
> >  #include <subcmd/parse-options.h>
> >  #include "parse-events.h"
> >  #include "string2.h"
> > -#include "strlist.h"
> > +#include "strbuf.h"
> >  #include "debug.h"
> >  #include <api/fs/tracing_path.h>
> >  #include <perf/cpumap.h>
> > @@ -1303,19 +1303,6 @@ int parse_events_add_pmu(struct parse_events_sta=
te *parse_state,
> >
> >       pmu =3D parse_state->fake_pmu ?: perf_pmus__find(name);
> >
> > -     if (verbose > 1 && !(pmu && pmu->selectable)) {
> > -             fprintf(stderr, "Attempting to add event pmu '%s' with '"=
,
> > -                     name);
> > -             if (head_config) {
> > -                     struct parse_events_term *term;
> > -
> > -                     list_for_each_entry(term, head_config, list) {
> > -                             fprintf(stderr, "%s,", term->config);
> > -                     }
> > -             }
> > -             fprintf(stderr, "' that may result in non-fatal errors\n"=
);
> > -     }
> > -
> >       if (!pmu) {
> >               char *err_str;
> >
> > @@ -1325,6 +1312,21 @@ int parse_events_add_pmu(struct parse_events_sta=
te *parse_state,
> >                       parse_events_error__handle(err, loc->first_column=
, err_str, NULL);
> >               return -EINVAL;
> >       }
> > +
> > +     if (verbose > 1) {
> > +             struct strbuf sb;
> > +
> > +             strbuf_init(&sb, /*hint=3D*/ 0);
> > +             if (pmu->selectable && !head_config) {
> > +                     strbuf_addf(&sb, "%s//", name);
> > +             } else {
> > +                     strbuf_addf(&sb, "%s/", name);
> > +                     parse_events_term__to_strbuf(head_config, &sb);
> > +                     strbuf_addch(&sb, '/');
> > +             }
> > +             fprintf(stderr, "Attempt to add: %s\n", sb.buf);
> > +             strbuf_release(&sb);
> > +     }
> >       if (head_config)
> >               fix_raw(head_config, pmu);
> >
> > @@ -1349,16 +1351,12 @@ int parse_events_add_pmu(struct parse_events_st=
ate *parse_state,
> >               return -EINVAL;
> >
> >       if (verbose > 1) {
> > -             fprintf(stderr, "After aliases, add event pmu '%s' with '=
",
> > -                     name);
> > -             if (head_config) {
> > -                     struct parse_events_term *term;
> > +             struct strbuf sb;
> >
> > -                     list_for_each_entry(term, head_config, list) {
> > -                             fprintf(stderr, "%s,", term->config);
> > -                     }
> > -             }
> > -             fprintf(stderr, "' that may result in non-fatal errors\n"=
);
> > +             strbuf_init(&sb, /*hint=3D*/ 0);
> > +             parse_events_term__to_strbuf(head_config, &sb);
> > +             fprintf(stderr, "..after resolving event: %s/%s/\n", name=
, sb.buf);
> > +             strbuf_release(&sb);
> >       }
> >
> >       /*
> > @@ -1460,7 +1458,12 @@ int parse_events_multi_pmu_add(struct parse_even=
ts_state *parse_state,
> >               parse_events_copy_term_list(head, &orig_head);
> >               if (!parse_events_add_pmu(parse_state, list, pmu->name,
> >                                         orig_head, auto_merge_stats, lo=
c)) {
> > -                     pr_debug("%s -> %s/%s/\n", str, pmu->name, str);
> > +                     struct strbuf sb;
> > +
> > +                     strbuf_init(&sb, /*hint=3D*/ 0);
> > +                     parse_events_term__to_strbuf(orig_head, &sb);
> > +                     pr_debug("%s -> %s/%s/\n", str, pmu->name, sb.buf=
);
> > +                     strbuf_release(&sb);
> >                       ok++;
> >               }
> >               parse_events_terms__delete(orig_head);
> > @@ -1469,7 +1472,12 @@ int parse_events_multi_pmu_add(struct parse_even=
ts_state *parse_state,
> >       if (parse_state->fake_pmu) {
> >               if (!parse_events_add_pmu(parse_state, list, str, head,
> >                                         /*auto_merge_stats=3D*/true, lo=
c)) {
> > -                     pr_debug("%s -> %s/%s/\n", str, "fake_pmu", str);
> > +                     struct strbuf sb;
> > +
> > +                     strbuf_init(&sb, /*hint=3D*/ 0);
> > +                     parse_events_term__to_strbuf(head, &sb);
> > +                     pr_debug("%s -> %s/%s/\n", str, "fake_pmu", sb.bu=
f);
> > +                     strbuf_release(&sb);
> >                       ok++;
> >               }
> >       }
> > @@ -2085,7 +2093,7 @@ void parse_events_error__handle(struct parse_even=
ts_error *err, int idx,
> >               break;
> >       default:
> >               pr_debug("Multiple errors dropping message: %s (%s)\n",
> > -                     err->str, err->help);
> > +                     err->str, err->help ?: "<no help>");
> >               free(err->str);
> >               err->str =3D str;
> >               free(err->help);
> > @@ -2502,6 +2510,47 @@ void parse_events_terms__delete(struct list_head=
 *terms)
> >       free(terms);
> >  }
> >
> > +int parse_events_term__to_strbuf(struct list_head *term_list, struct s=
trbuf *sb)
> > +{
> > +     struct parse_events_term *term;
> > +     bool first =3D true;
> > +
> > +     if (!term_list)
> > +             return 0;
> > +
> > +     list_for_each_entry(term, term_list, list) {
> > +             int ret;
> > +
> > +             if (!first) {
> > +                     ret =3D strbuf_addch(sb, ',');
> > +                     if (ret < 0)
> > +                             return ret;
> > +             }
> > +             first =3D false;
> > +
> > +             if (term->type_val =3D=3D PARSE_EVENTS__TERM_TYPE_NUM)
> > +                     if (term->type_term =3D=3D PARSE_EVENTS__TERM_TYP=
E_USER && term->val.num =3D=3D 1)
> > +                             ret =3D strbuf_addf(sb, "%s", term->confi=
g);
> > +                     else
> > +                             ret =3D strbuf_addf(sb, "%s=3D%#"PRIx64, =
term->config, term->val.num);
> > +             else if (term->type_val =3D=3D PARSE_EVENTS__TERM_TYPE_ST=
R) {
> > +                     if (term->config) {
> > +                             ret =3D strbuf_addf(sb, "%s=3D", term->co=
nfig);
> > +                             if (ret < 0)
> > +                                     return ret;
> > +                     } else if (term->type_term < __PARSE_EVENTS__TERM=
_TYPE_NR) {
> > +                             ret =3D strbuf_addf(sb, "%s=3D", config_t=
erm_names[term->type_term]);
> > +                             if (ret < 0)
> > +                                     return ret;
> > +                     }
> > +                     ret =3D strbuf_addf(sb, "%s", term->val.str);
> > +             }
> > +             if (ret < 0)
> > +                     return ret;
> > +     }
> > +     return 0;
> > +}
> > +
> >  void parse_events_evlist_error(struct parse_events_state *parse_state,
> >                              int idx, const char *str)
> >  {
> > diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-eve=
nts.h
> > index 6d75d853ce00..20bdc35d6112 100644
> > --- a/tools/perf/util/parse-events.h
> > +++ b/tools/perf/util/parse-events.h
> > @@ -18,6 +18,7 @@ struct parse_events_error;
> >
> >  struct option;
> >  struct perf_pmu;
> > +struct strbuf;
> >
> >  const char *event_type(int type);
> >
> > @@ -152,6 +153,7 @@ int parse_events_term__clone(struct parse_events_te=
rm **new,
> >  void parse_events_term__delete(struct parse_events_term *term);
> >  void parse_events_terms__delete(struct list_head *terms);
> >  void parse_events_terms__purge(struct list_head *terms);
> > +int parse_events_term__to_strbuf(struct list_head *term_list, struct s=
trbuf *sb);
> >  int parse_events__modifier_event(struct list_head *list, char *str, bo=
ol add);
> >  int parse_events__modifier_group(struct list_head *list, char *event_m=
od);
> >  int parse_events_name(struct list_head *list, const char *name);
> > diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> > index b3f8f3f1e900..8dbb7008877e 100644
> > --- a/tools/perf/util/pmu.c
> > +++ b/tools/perf/util/pmu.c
> > @@ -507,12 +507,11 @@ static int perf_pmu__new_alias(struct perf_pmu *p=
mu, const char *name,
> >                               const char *desc, const char *val, FILE *=
val_fd,
> >                               const struct pmu_event *pe)
> >  {
> > -     struct parse_events_term *term;
> >       struct perf_pmu_alias *alias;
> >       int ret;
> > -     char newval[256];
> >       const char *long_desc =3D NULL, *topic =3D NULL, *unit =3D NULL, =
*pmu_name =3D NULL;
> >       bool deprecated =3D false, perpkg =3D false;
> > +     struct strbuf sb;
> >
> >       if (perf_pmu__find_alias(pmu, name, /*load=3D*/ false)) {
> >               /* Alias was already created/loaded. */
> > @@ -582,20 +581,10 @@ static int perf_pmu__new_alias(struct perf_pmu *p=
mu, const char *name,
> >        *
> >        * Rebuild string to make alias->str member comparable.
> >        */
> > -     ret =3D 0;
> > -     list_for_each_entry(term, &alias->terms, list) {
> > -             if (ret)
> > -                     ret +=3D scnprintf(newval + ret, sizeof(newval) -=
 ret,
> > -                                      ",");
> > -             if (term->type_val =3D=3D PARSE_EVENTS__TERM_TYPE_NUM)
> > -                     ret +=3D scnprintf(newval + ret, sizeof(newval) -=
 ret,
> > -                                      "%s=3D%#x", term->config, term->=
val.num);
> > -             else if (term->type_val =3D=3D PARSE_EVENTS__TERM_TYPE_ST=
R)
> > -                     ret +=3D scnprintf(newval + ret, sizeof(newval) -=
 ret,
> > -                                      "%s=3D%s", term->config, term->v=
al.str);
> > -     }
> >       zfree(&alias->str);
> > -     alias->str =3D strdup(newval);
> > +     strbuf_init(&sb, /*hint=3D*/ 0);
> > +     parse_events_term__to_strbuf(&alias->terms, &sb);
> > +     alias->str =3D strbuf_detach(&sb, /*sz=3D*/ NULL);
> >       if (!pe)
> >               pmu->sysfs_aliases++;
> >       else
