Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB94478771C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 19:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242852AbjHXRcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 13:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235786AbjHXRbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 13:31:53 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C5B19BA
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 10:31:50 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-40c72caec5cso29551cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 10:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692898309; x=1693503109; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C5NYspLPatoaGHxnDOw5o1c2qcpc2OSQyPvAfJjpWsY=;
        b=q9R1lQKaeJYJSYiReqCHI0EjkndXWMEFuz2mre4y7dwU8sfWLYmKuyduwiPAn+1RYT
         QJ5tAms0hyMdUc7IgtWmIYqT6umYuEEDMzvnZgKZOY9HKN0QP80aQB9YIWWbylms7YHY
         rKXEJfUc+fvmhRLSyzXdyccYqEeYaGol5jpp94pKSvE8vvN1GtlRWokRzORMTqUqRNSk
         VKkrj9NlwKsabktJpnutqI4SxiMhG7MLQ7cT+TXnx+gy1+4Se+OKkG4EV7I8f1+5KMkO
         N9jB7NDq49OeuMAGAi3VR0XqgwlvEgBtxK+vYuKL/qGcgEqC0Nc92fftkqJgJlVew26H
         0seQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692898309; x=1693503109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C5NYspLPatoaGHxnDOw5o1c2qcpc2OSQyPvAfJjpWsY=;
        b=G6AzNY860qONXX2HzcbkypIf/1VIVyg/ck+idHdifnqiuE2Sudw5GTO1JfvMVjGwq8
         6FmEuRDOtjuMyuSvs5XcgP1O7wZnJdbxH09tC68nVn6Uv7aOWad6ulsRcgT4RNLZH5ms
         /QMKcxtG4LoEv7H4bgqYxKhTbFOPRGXFvsbbOaPDL7uNwBRcCy9MB0yEB1mm7UrVh7EE
         OKl8zWEKfcZQm6hD9srct59fKs2I5sVuTvq49yBv44MtrYqZPgVMSVYR+kQYT1cm5n1i
         4AHkZy8qq8oPKweMnrAHO42RCP8NJuL0DTEANVOsXkRDz00cQvSMXZQSM/oCTbudoFqX
         v8Vw==
X-Gm-Message-State: AOJu0YyqJZfU9RigDrlM62HkGjG39zNP7fFnlEoBY+oaqtKZMWvPhufv
        vUxUkqmXyenzFMhHPqq3dxFqPS4HCZ4di1HglGIdcg==
X-Google-Smtp-Source: AGHT+IEjg75CKZcLLJGcqGqw1dzVXkcrlwxKEuNCTdQ7rOkDY2ROvgciZoQYzsKm7PvlmUhjMLYr5BwGycobXZUMbnU=
X-Received: by 2002:ac8:7fc4:0:b0:412:9cd:473b with SMTP id
 b4-20020ac87fc4000000b0041209cd473bmr22689qtk.4.1692898309180; Thu, 24 Aug
 2023 10:31:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230824041330.266337-1-irogers@google.com> <20230824041330.266337-7-irogers@google.com>
 <ZOdiX4eJHFfFbQhi@kernel.org>
In-Reply-To: <ZOdiX4eJHFfFbQhi@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 24 Aug 2023 10:31:37 -0700
Message-ID: <CAP-5=fU3PVCFjyy_R2w9xWbjBWktsuz9+crKhZNGqUR2jdKMrw@mail.gmail.com>
Subject: Re: [PATCH v2 06/18] perf s390 s390_cpumcfdg_dump: Don't scan all PMUs
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Rob Herring <robh@kernel.org>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 7:00=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Wed, Aug 23, 2023 at 09:13:18PM -0700, Ian Rogers escreveu:
> > Rather than scanning all PMUs for a counter name, scan the PMU
> > associated with the evsel of the sample. This is done to remove a
> > dependence on pmu-events.h.
>
> I'm applying this one, and CCing the S/390 developers so that they can
> try this and maybe provide an Acked-by/Tested-by,

Thanks Arnaldo! You're right that I wasn't able to test this s390
change on an s390.

Ian

> - Arnaldo
>
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/s390-sample-raw.c | 50 ++++++++++++++++---------------
> >  1 file changed, 26 insertions(+), 24 deletions(-)
> >
> > diff --git a/tools/perf/util/s390-sample-raw.c b/tools/perf/util/s390-s=
ample-raw.c
> > index 91330c874170..dc1ed3e95d4d 100644
> > --- a/tools/perf/util/s390-sample-raw.c
> > +++ b/tools/perf/util/s390-sample-raw.c
> > @@ -27,7 +27,7 @@
> >  #include "color.h"
> >  #include "sample-raw.h"
> >  #include "s390-cpumcf-kernel.h"
> > -#include "pmu-events/pmu-events.h"
> > +#include "util/pmu.h"
> >  #include "util/sample.h"
> >
> >  static size_t ctrset_size(struct cf_ctrset_entry *set)
> > @@ -132,56 +132,57 @@ static int get_counterset_start(int setnr)
> >
> >  struct get_counter_name_data {
> >       int wanted;
> > -     const char *result;
> > +     char *result;
> >  };
> >
> > -static int get_counter_name_callback(const struct pmu_event *evp,
> > -                                  const struct pmu_events_table *table=
 __maybe_unused,
> > -                                  void *vdata)
> > +static int get_counter_name_callback(void *vdata, struct pmu_event_inf=
o *info)
> >  {
> >       struct get_counter_name_data *data =3D vdata;
> >       int rc, event_nr;
> > +     const char *event_str;
> >
> > -     if (evp->name =3D=3D NULL || evp->event =3D=3D NULL)
> > +     if (info->str =3D=3D NULL)
> >               return 0;
> > -     rc =3D sscanf(evp->event, "event=3D%x", &event_nr);
> > +
> > +     event_str =3D strstr(info->str, "event=3D");
> > +     if (!event_str)
> > +             return 0;
> > +
> > +     rc =3D sscanf(event_str, "event=3D%x", &event_nr);
> >       if (rc =3D=3D 1 && event_nr =3D=3D data->wanted) {
> > -             data->result =3D evp->name;
> > +             data->result =3D strdup(info->name);
> >               return 1; /* Terminate the search. */
> >       }
> >       return 0;
> >  }
> >
> > -/* Scan the PMU table and extract the logical name of a counter from t=
he
> > - * PMU events table. Input is the counter set and counter number with =
in the
> > - * set. Construct the event number and use this as key. If they match =
return
> > - * the name of this counter.
> > +/* Scan the PMU and extract the logical name of a counter from the eve=
nt. Input
> > + * is the counter set and counter number with in the set. Construct th=
e event
> > + * number and use this as key. If they match return the name of this c=
ounter.
> >   * If no match is found a NULL pointer is returned.
> >   */
> > -static const char *get_counter_name(int set, int nr, const struct pmu_=
events_table *table)
> > +static char *get_counter_name(int set, int nr, struct perf_pmu *pmu)
> >  {
> >       struct get_counter_name_data data =3D {
> >               .wanted =3D get_counterset_start(set) + nr,
> >               .result =3D NULL,
> >       };
> >
> > -     if (!table)
> > +     if (!pmu)
> >               return NULL;
> >
> > -     pmu_events_table__for_each_event(table, get_counter_name_callback=
, &data);
> > +     perf_pmu__for_each_event(pmu, &data, get_counter_name_callback);
> >       return data.result;
> >  }
> >
> > -static void s390_cpumcfdg_dump(struct perf_sample *sample)
> > +static void s390_cpumcfdg_dump(struct perf_pmu *pmu, struct perf_sampl=
e *sample)
> >  {
> >       size_t i, len =3D sample->raw_size, offset =3D 0;
> >       unsigned char *buf =3D sample->raw_data;
> >       const char *color =3D PERF_COLOR_BLUE;
> >       struct cf_ctrset_entry *cep, ce;
> > -     const struct pmu_events_table *table;
> >       u64 *p;
> >
> > -     table =3D pmu_events_table__find();
> >       while (offset < len) {
> >               cep =3D (struct cf_ctrset_entry *)(buf + offset);
> >
> > @@ -199,11 +200,12 @@ static void s390_cpumcfdg_dump(struct perf_sample=
 *sample)
> >               color_fprintf(stdout, color, "    [%#08zx] Counterset:%d"
> >                             " Counters:%d\n", offset, ce.set, ce.ctr);
> >               for (i =3D 0, p =3D (u64 *)(cep + 1); i < ce.ctr; ++i, ++=
p) {
> > -                     const char *ev_name =3D get_counter_name(ce.set, =
i, table);
> > +                     char *ev_name =3D get_counter_name(ce.set, i, pmu=
);
> >
> >                       color_fprintf(stdout, color,
> >                                     "\tCounter:%03d %s Value:%#018lx\n"=
, i,
> >                                     ev_name ?: "<unknown>", be64_to_cpu=
(*p));
> > +                     free(ev_name);
> >               }
> >               offset +=3D ctrset_size(&ce);
> >       }
> > @@ -216,14 +218,14 @@ static void s390_cpumcfdg_dump(struct perf_sample=
 *sample)
> >   */
> >  void evlist__s390_sample_raw(struct evlist *evlist, union perf_event *=
event, struct perf_sample *sample)
> >  {
> > -     struct evsel *ev_bc000;
> > +     struct evsel *evsel;
> >
> >       if (event->header.type !=3D PERF_RECORD_SAMPLE)
> >               return;
> >
> > -     ev_bc000 =3D evlist__event2evsel(evlist, event);
> > -     if (ev_bc000 =3D=3D NULL ||
> > -         ev_bc000->core.attr.config !=3D PERF_EVENT_CPUM_CF_DIAG)
> > +     evsel =3D evlist__event2evsel(evlist, event);
> > +     if (evsel =3D=3D NULL ||
> > +         evsel->core.attr.config !=3D PERF_EVENT_CPUM_CF_DIAG)
> >               return;
> >
> >       /* Display raw data on screen */
> > @@ -231,5 +233,5 @@ void evlist__s390_sample_raw(struct evlist *evlist,=
 union perf_event *event, str
> >               pr_err("Invalid counter set data encountered\n");
> >               return;
> >       }
> > -     s390_cpumcfdg_dump(sample);
> > +     s390_cpumcfdg_dump(evsel->pmu, sample);
> >  }
> > --
> > 2.42.0.rc1.204.g551eb34607-goog
> >
>
> --
>
> - Arnaldo
