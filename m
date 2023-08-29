Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14CB678C8AB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 17:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237283AbjH2Pew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 11:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235650AbjH2Pem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 11:34:42 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F37193
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 08:34:38 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-40a47e8e38dso269781cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 08:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693323277; x=1693928077; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ydosaxpy/546JIWWVIFRuk2/5CSF+ZnTc8c0znvkP88=;
        b=m4EZ997PgdCyWXHrLy4cDivLR+k8T5MvkPF+Zwfi5u+fKW1bDi0Znf1E1tLTMnoHmf
         W/3z7gFc6zOR+fDe8Y32Rx05tiZGoP7P5hIcmPw4iI3Z3crDelJC/xUdlScRrfQtolZH
         LUEtiWzPvFXON8hs0Em/rlh3FiBcZt1eC53FmgcQ0TBuL4aJSH7XyF3m7zLXUMjzKnI6
         ZgPtTl2xCTHnLsqA7B16aTa+QswrXMq9qy0vHxCzi2H4MBVtr6zevIR00OTPVY3nSyrC
         xSJ03OmzZxAbT2nLvhheM1tPsjoKdllmbWCFWM0X0MKSHa1CtFiOcgBEbfjBhLPL1UV1
         wnNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693323277; x=1693928077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ydosaxpy/546JIWWVIFRuk2/5CSF+ZnTc8c0znvkP88=;
        b=SMTY9TWh+GyaaIF1Cs/0d5wRbKF46p9Cfrgb0gCeCKNL7Rk1oaFbhA/jVmULnVEzJT
         TU6kk/FRmph+7YD/lsGRJ2EI5FsjLE2c7IZILkKRl2i6fPpzDvxfUGbmacA4x+03nth2
         E/IJupdXNQgQmjz+oEeW5MTu8d1Gi3GiTVudfR1rSPP2AJGs3PYqEdjkIsI/TKw3dmkb
         tNK8+zHXhbHf+xt/UcNOJGQ4Kc2V/9Eob7ZWjGeoT1xXI91V1DkpDsc8cmmHoRtr1hJ6
         df2OeAqrgazkKsGRzPo5oQENXZ/yQrONsebtN3b/Hqu+l8uB6EpRGK6ehCgA+D5F20PG
         L+XQ==
X-Gm-Message-State: AOJu0YzkvY7OewKbknGiQsZt32YlqkBUpxdkJORst6qTSM3uNdMjhjiA
        3MRZ16N5y+jQRC8h8UTS1Y52ovzrVULaXI/y2y2/Pw==
X-Google-Smtp-Source: AGHT+IG1w9E5Ms6Kj1TGkwMrv8dMnKOx33KUUkXtzK6fzh5hXsMm2zHsD6x5zTBpO2x57jKdgcOm1AbkukEat/FG7q4=
X-Received: by 2002:a05:622a:308:b0:410:8cbf:61de with SMTP id
 q8-20020a05622a030800b004108cbf61demr178957qtw.13.1693323277494; Tue, 29 Aug
 2023 08:34:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230824041330.266337-1-irogers@google.com> <20230824041330.266337-5-irogers@google.com>
 <b14b1ab3-3f07-e2c3-c41c-84304d46190a@arm.com>
In-Reply-To: <b14b1ab3-3f07-e2c3-c41c-84304d46190a@arm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 29 Aug 2023 08:34:25 -0700
Message-ID: <CAP-5=fXTJzUO0z6+B9U7L=NrmR-rWTSRW86cMcQaK=YfiZNhUQ@mail.gmail.com>
Subject: Re: [PATCH v2 04/18] perf jevents: Group events by PMU
To:     James Clark <james.clark@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
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
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 8:28=E2=80=AFAM James Clark <james.clark@arm.com> w=
rote:
>
>
>
> On 24/08/2023 05:13, Ian Rogers wrote:
> > Prior to this change a cpuid would map to a list of events where the
> > PMU would be encoded alongside the event information. This change
> > breaks apart each group of events so that there is a group per PMU. A
> > new table is added with the PMU's name and the list of events, the
> > original table now holding an array of these per PMU tables.
> >
> > These changes are to make it easier to get per PMU information about
> > events, rather than the current approach of scanning all events. The
> > perf binary size with BPF skeletons on x86 is reduced by about 1%. The
> > unidentified PMU is now always expanded to "cpu".
> >
>
> Hi Ian,
>
> I noticed that after this commit in perf-tools-next, events and
> descriptions aren't printed by perf list anymore (on Arm). Only the
> metrics and builtin kernel events are printed.
>
> I'm not sure if this is something that's related to test failure that
> Arnaldo mentioned on the cover letter, or something else.
>
> I didn't look into the root cause yet, just thought I would mention it
> first.


Hi James,

There was a glitch in this patch assuming json events with no PMU were
defaulting to CPU, something that happens a lot in the perf code. The
later patch:
https://lore.kernel.org/lkml/20230826062203.1058041-1-irogers@google.com/
is supposed to address this.

Thanks,
Ian

> Thanks
> James
>
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/pmu-events/jevents.py | 181 +++++++++++++++++++++++--------
> >  tools/perf/tests/pmu-events.c    |  30 +++--
> >  2 files changed, 154 insertions(+), 57 deletions(-)
> >
> > diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/j=
events.py
> > index aae5334099b1..1ad20140114c 100755
> > --- a/tools/perf/pmu-events/jevents.py
> > +++ b/tools/perf/pmu-events/jevents.py
> > @@ -42,7 +42,7 @@ _metricgroups =3D {}
> >  # Order specific JsonEvent attributes will be visited.
> >  _json_event_attributes =3D [
> >      # cmp_sevent related attributes.
> > -    'name', 'pmu', 'topic', 'desc',
> > +    'name', 'topic', 'desc',
> >      # Seems useful, put it early.
> >      'event',
> >      # Short things in alphabetical order.
> > @@ -53,7 +53,7 @@ _json_event_attributes =3D [
> >
> >  # Attributes that are in pmu_metric rather than pmu_event.
> >  _json_metric_attributes =3D [
> > -    'pmu', 'metric_name', 'metric_group', 'metric_expr', 'metric_thres=
hold',
> > +    'metric_name', 'metric_group', 'metric_expr', 'metric_threshold',
> >      'desc', 'long_desc', 'unit', 'compat', 'metricgroup_no_group',
> >      'default_metricgroup_name', 'aggr_mode', 'event_grouping'
> >  ]
> > @@ -252,7 +252,7 @@ class JsonEvent:
> >      def unit_to_pmu(unit: str) -> Optional[str]:
> >        """Convert a JSON Unit to Linux PMU name."""
> >        if not unit:
> > -        return None
> > +        return 'cpu'
> >        # Comment brought over from jevents.c:
> >        # it's not realistic to keep adding these, we need something mor=
e scalable ...
> >        table =3D {
> > @@ -343,10 +343,13 @@ class JsonEvent:
> >        self.desc +=3D extra_desc
> >      if self.long_desc and extra_desc:
> >        self.long_desc +=3D extra_desc
> > -    if self.pmu:
> > -      if self.desc and not self.desc.endswith('. '):
> > -        self.desc +=3D '. '
> > -      self.desc =3D (self.desc if self.desc else '') + ('Unit: ' + sel=
f.pmu + ' ')
> > +    if self.pmu and self.pmu !=3D 'cpu':
> > +      if not self.desc:
> > +        self.desc =3D 'Unit: ' + self.pmu
> > +      else:
> > +        if not self.desc.endswith('. '):
> > +          self.desc +=3D '. '
> > +      self.desc +=3D 'Unit: ' + self.pmu
> >      if arch_std:
> >        if arch_std.lower() in _arch_std_events:
> >          event =3D _arch_std_events[arch_std.lower()].event
> > @@ -437,13 +440,13 @@ def add_events_table_entries(item: os.DirEntry, t=
opic: str) -> None:
> >  def print_pending_events() -> None:
> >    """Optionally close events table."""
> >
> > -  def event_cmp_key(j: JsonEvent) -> Tuple[bool, str, str, str, str]:
> > +  def event_cmp_key(j: JsonEvent) -> Tuple[str, str, bool, str, str]:
> >      def fix_none(s: Optional[str]) -> str:
> >        if s is None:
> >          return ''
> >        return s
> >
> > -    return (j.desc is not None, fix_none(j.topic), fix_none(j.name), f=
ix_none(j.pmu),
> > +    return (fix_none(j.pmu).replace(',','_'), fix_none(j.name), j.desc=
 is not None, fix_none(j.topic),
> >              fix_none(j.metric_name))
> >
> >    global _pending_events
> > @@ -458,13 +461,36 @@ def print_pending_events() -> None:
> >      global event_tables
> >      _event_tables.append(_pending_events_tblname)
> >
> > -  _args.output_file.write(
> > -      f'static const struct compact_pmu_event {_pending_events_tblname=
}[] =3D {{\n')
> > -
> > +  first =3D True
> > +  last_pmu =3D None
> > +  pmus =3D set()
> >    for event in sorted(_pending_events, key=3Devent_cmp_key):
> > +    if event.pmu !=3D last_pmu:
> > +      if not first:
> > +        _args.output_file.write('};\n')
> > +      pmu_name =3D event.pmu.replace(',', '_')
> > +      _args.output_file.write(
> > +          f'static const struct compact_pmu_event {_pending_events_tbl=
name}_{pmu_name}[] =3D {{\n')
> > +      first =3D False
> > +      last_pmu =3D event.pmu
> > +      pmus.add((event.pmu, pmu_name))
> > +
> >      _args.output_file.write(event.to_c_string(metric=3DFalse))
> >    _pending_events =3D []
> >
> > +  _args.output_file.write(f"""
> > +}};
> > +
> > +const struct pmu_table_entry {_pending_events_tblname}[] =3D {{
> > +""")
> > +  for (pmu, tbl_pmu) in sorted(pmus):
> > +    pmu_name =3D f"{pmu}\\000"
> > +    _args.output_file.write(f"""{{
> > +     .entries =3D {_pending_events_tblname}_{tbl_pmu},
> > +     .num_entries =3D ARRAY_SIZE({_pending_events_tblname}_{tbl_pmu}),
> > +     .pmu_name =3D {{ {_bcs.offsets[pmu_name]} /* {pmu_name} */ }},
> > +}},
> > +""")
> >    _args.output_file.write('};\n\n')
> >
> >  def print_pending_metrics() -> None:
> > @@ -490,13 +516,36 @@ def print_pending_metrics() -> None:
> >      global metric_tables
> >      _metric_tables.append(_pending_metrics_tblname)
> >
> > -  _args.output_file.write(
> > -      f'static const struct compact_pmu_event {_pending_metrics_tblnam=
e}[] =3D {{\n')
> > -
> > +  first =3D True
> > +  last_pmu =3D None
> > +  pmus =3D set()
> >    for metric in sorted(_pending_metrics, key=3Dmetric_cmp_key):
> > +    if metric.pmu !=3D last_pmu:
> > +      if not first:
> > +        _args.output_file.write('};\n')
> > +      pmu_name =3D metric.pmu.replace(',', '_')
> > +      _args.output_file.write(
> > +          f'static const struct compact_pmu_event {_pending_metrics_tb=
lname}_{pmu_name}[] =3D {{\n')
> > +      first =3D False
> > +      last_pmu =3D metric.pmu
> > +      pmus.add((metric.pmu, pmu_name))
> > +
> >      _args.output_file.write(metric.to_c_string(metric=3DTrue))
> >    _pending_metrics =3D []
> >
> > +  _args.output_file.write(f"""
> > +}};
> > +
> > +const struct pmu_table_entry {_pending_metrics_tblname}[] =3D {{
> > +""")
> > +  for (pmu, tbl_pmu) in sorted(pmus):
> > +    pmu_name =3D f"{pmu}\\000"
> > +    _args.output_file.write(f"""{{
> > +     .entries =3D {_pending_metrics_tblname}_{tbl_pmu},
> > +     .num_entries =3D ARRAY_SIZE({_pending_metrics_tblname}_{tbl_pmu})=
,
> > +     .pmu_name =3D {{ {_bcs.offsets[pmu_name]} /* {pmu_name} */ }},
> > +}},
> > +""")
> >    _args.output_file.write('};\n\n')
> >
> >  def get_topic(topic: str) -> str:
> > @@ -532,6 +581,8 @@ def preprocess_one_file(parents: Sequence[str], ite=
m: os.DirEntry) -> None:
> >
> >    topic =3D get_topic(item.name)
> >    for event in read_json_events(item.path, topic):
> > +    pmu_name =3D f"{event.pmu}\\000"
> > +    _bcs.add(pmu_name)
> >      if event.name:
> >        _bcs.add(event.build_c_string(metric=3DFalse))
> >      if event.metric_name:
> > @@ -577,14 +628,14 @@ def print_mapping_table(archs: Sequence[str]) -> =
None:
> >    _args.output_file.write("""
> >  /* Struct used to make the PMU event table implementation opaque to ca=
llers. */
> >  struct pmu_events_table {
> > -        const struct compact_pmu_event *entries;
> > -        size_t length;
> > +        const struct pmu_table_entry *pmus;
> > +        uint32_t num_pmus;
> >  };
> >
> >  /* Struct used to make the PMU metric table implementation opaque to c=
allers. */
> >  struct pmu_metrics_table {
> > -        const struct compact_pmu_event *entries;
> > -        size_t length;
> > +        const struct pmu_table_entry *pmus;
> > +        uint32_t num_pmus;
> >  };
> >
> >  /*
> > @@ -614,12 +665,12 @@ const struct pmu_events_map pmu_events_map[] =3D =
{
> >  \t.arch =3D "testarch",
> >  \t.cpuid =3D "testcpu",
> >  \t.event_table =3D {
> > -\t\t.entries =3D pmu_events__test_soc_cpu,
> > -\t\t.length =3D ARRAY_SIZE(pmu_events__test_soc_cpu),
> > +\t\t.pmus =3D pmu_events__test_soc_cpu,
> > +\t\t.num_pmus =3D ARRAY_SIZE(pmu_events__test_soc_cpu),
> >  \t},
> >  \t.metric_table =3D {
> > -\t\t.entries =3D pmu_metrics__test_soc_cpu,
> > -\t\t.length =3D ARRAY_SIZE(pmu_metrics__test_soc_cpu),
> > +\t\t.pmus =3D pmu_metrics__test_soc_cpu,
> > +\t\t.num_pmus =3D ARRAY_SIZE(pmu_metrics__test_soc_cpu),
> >  \t}
> >  },
> >  """)
> > @@ -649,12 +700,12 @@ const struct pmu_events_map pmu_events_map[] =3D =
{
> >  \t.arch =3D "{arch}",
> >  \t.cpuid =3D "{cpuid}",
> >  \t.event_table =3D {{
> > -\t\t.entries =3D {event_tblname},
> > -\t\t.length =3D {event_size}
> > +\t\t.pmus =3D {event_tblname},
> > +\t\t.num_pmus =3D {event_size}
> >  \t}},
> >  \t.metric_table =3D {{
> > -\t\t.entries =3D {metric_tblname},
> > -\t\t.length =3D {metric_size}
> > +\t\t.pmus =3D {metric_tblname},
> > +\t\t.num_pmus =3D {metric_size}
> >  \t}}
> >  }},
> >  """)
> > @@ -685,15 +736,15 @@ static const struct pmu_sys_events pmu_sys_event_=
tables[] =3D {
> >    for tblname in _sys_event_tables:
> >      _args.output_file.write(f"""\t{{
> >  \t\t.event_table =3D {{
> > -\t\t\t.entries =3D {tblname},
> > -\t\t\t.length =3D ARRAY_SIZE({tblname})
> > +\t\t\t.pmus =3D {tblname},
> > +\t\t\t.num_pmus =3D ARRAY_SIZE({tblname})
> >  \t\t}},""")
> >      metric_tblname =3D _sys_event_table_to_metric_table_mapping[tblnam=
e]
> >      if metric_tblname in _sys_metric_tables:
> >        _args.output_file.write(f"""
> >  \t\t.metric_table =3D {{
> > -\t\t\t.entries =3D {metric_tblname},
> > -\t\t\t.length =3D ARRAY_SIZE({metric_tblname})
> > +\t\t\t.pmus =3D {metric_tblname},
> > +\t\t\t.num_pmus =3D ARRAY_SIZE({metric_tblname})
> >  \t\t}},""")
> >        printed_metric_tables.append(metric_tblname)
> >      _args.output_file.write(f"""
> > @@ -753,18 +804,56 @@ static void decompress_metric(int offset, struct =
pmu_metric *pm)
> >        _args.output_file.write('\twhile (*p++);')
> >    _args.output_file.write("""}
> >
> > +static int pmu_events_table__for_each_event_pmu(const struct pmu_event=
s_table *table,
> > +                                                const struct pmu_table=
_entry *pmu,
> > +                                                pmu_event_iter_fn fn,
> > +                                                void *data)
> > +{
> > +        int ret;
> > +        struct pmu_event pe =3D {
> > +                .pmu =3D &big_c_string[pmu->pmu_name.offset],
> > +        };
> > +
> > +        for (uint32_t i =3D 0; i < pmu->num_entries; i++) {
> > +                decompress_event(pmu->entries[i].offset, &pe);
> > +                if (!pe.name)
> > +                        continue;
> > +                ret =3D fn(&pe, table, data);
> > +                if (ret)
> > +                        return ret;
> > +        }
> > +        return 0;
> > + }
> > +
> >  int pmu_events_table__for_each_event(const struct pmu_events_table *ta=
ble,
> >                                      pmu_event_iter_fn fn,
> >                                      void *data)
> >  {
> > -        for (size_t i =3D 0; i < table->length; i++) {
> > -                struct pmu_event pe;
> > -                int ret;
> > +        for (size_t i =3D 0; i < table->num_pmus; i++) {
> > +                int ret =3D pmu_events_table__for_each_event_pmu(table=
, &table->pmus[i],
> > +                                                               fn, dat=
a);
> >
> > -                decompress_event(table->entries[i].offset, &pe);
> > -                if (!pe.name)
> > +                if (ret)
> > +                        return ret;
> > +        }
> > +        return 0;
> > +}
> > +
> > +static int pmu_metrics_table__for_each_metric_pmu(const struct pmu_met=
rics_table *table,
> > +                                                const struct pmu_table=
_entry *pmu,
> > +                                                pmu_metric_iter_fn fn,
> > +                                                void *data)
> > +{
> > +        int ret;
> > +        struct pmu_metric pm =3D {
> > +                .pmu =3D &big_c_string[pmu->pmu_name.offset],
> > +        };
> > +
> > +        for (uint32_t i =3D 0; i < pmu->num_entries; i++) {
> > +                decompress_metric(pmu->entries[i].offset, &pm);
> > +                if (!pm.metric_expr)
> >                          continue;
> > -                ret =3D fn(&pe, table, data);
> > +                ret =3D fn(&pm, table, data);
> >                  if (ret)
> >                          return ret;
> >          }
> > @@ -775,14 +864,10 @@ int pmu_metrics_table__for_each_metric(const stru=
ct pmu_metrics_table *table,
> >                                       pmu_metric_iter_fn fn,
> >                                       void *data)
> >  {
> > -        for (size_t i =3D 0; i < table->length; i++) {
> > -                struct pmu_metric pm;
> > -                int ret;
> > +        for (size_t i =3D 0; i < table->num_pmus; i++) {
> > +                int ret =3D pmu_metrics_table__for_each_metric_pmu(tab=
le, &table->pmus[i],
> > +                                                                 fn, d=
ata);
> >
> > -                decompress_metric(table->entries[i].offset, &pm);
> > -                if (!pm.metric_expr)
> > -                        continue;
> > -                ret =3D fn(&pm, table, data);
> >                  if (ret)
> >                          return ret;
> >          }
> > @@ -1010,7 +1095,13 @@ such as "arm/cortex-a34".''',
> >  #include <stddef.h>
> >
> >  struct compact_pmu_event {
> > -  int offset;
> > +        int offset;
> > +};
> > +
> > +struct pmu_table_entry {
> > +        const struct compact_pmu_event *entries;
> > +        uint32_t num_entries;
> > +        struct compact_pmu_event pmu_name;
> >  };
> >
> >  """)
> > diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-event=
s.c
> > index 5f541eadc088..0b6efabc3d20 100644
> > --- a/tools/perf/tests/pmu-events.c
> > +++ b/tools/perf/tests/pmu-events.c
> > @@ -44,6 +44,7 @@ struct perf_pmu_test_pmu {
> >
> >  static const struct perf_pmu_test_event bp_l1_btb_correct =3D {
> >       .event =3D {
> > +             .pmu =3D "cpu",
> >               .name =3D "bp_l1_btb_correct",
> >               .event =3D "event=3D0x8a",
> >               .desc =3D "L1 BTB Correction",
> > @@ -55,6 +56,7 @@ static const struct perf_pmu_test_event bp_l1_btb_cor=
rect =3D {
> >
> >  static const struct perf_pmu_test_event bp_l2_btb_correct =3D {
> >       .event =3D {
> > +             .pmu =3D "cpu",
> >               .name =3D "bp_l2_btb_correct",
> >               .event =3D "event=3D0x8b",
> >               .desc =3D "L2 BTB Correction",
> > @@ -66,6 +68,7 @@ static const struct perf_pmu_test_event bp_l2_btb_cor=
rect =3D {
> >
> >  static const struct perf_pmu_test_event segment_reg_loads_any =3D {
> >       .event =3D {
> > +             .pmu =3D "cpu",
> >               .name =3D "segment_reg_loads.any",
> >               .event =3D "event=3D0x6,period=3D200000,umask=3D0x80",
> >               .desc =3D "Number of segment register loads",
> > @@ -77,6 +80,7 @@ static const struct perf_pmu_test_event segment_reg_l=
oads_any =3D {
> >
> >  static const struct perf_pmu_test_event dispatch_blocked_any =3D {
> >       .event =3D {
> > +             .pmu =3D "cpu",
> >               .name =3D "dispatch_blocked.any",
> >               .event =3D "event=3D0x9,period=3D200000,umask=3D0x20",
> >               .desc =3D "Memory cluster signals to block micro-op dispa=
tch for any reason",
> > @@ -88,6 +92,7 @@ static const struct perf_pmu_test_event dispatch_bloc=
ked_any =3D {
> >
> >  static const struct perf_pmu_test_event eist_trans =3D {
> >       .event =3D {
> > +             .pmu =3D "cpu",
> >               .name =3D "eist_trans",
> >               .event =3D "event=3D0x3a,period=3D200000,umask=3D0x0",
> >               .desc =3D "Number of Enhanced Intel SpeedStep(R) Technolo=
gy (EIST) transitions",
> > @@ -99,6 +104,7 @@ static const struct perf_pmu_test_event eist_trans =
=3D {
> >
> >  static const struct perf_pmu_test_event l3_cache_rd =3D {
> >       .event =3D {
> > +             .pmu =3D "cpu",
> >               .name =3D "l3_cache_rd",
> >               .event =3D "event=3D0x40",
> >               .desc =3D "L3 cache access, read",
> > @@ -123,7 +129,7 @@ static const struct perf_pmu_test_event uncore_hisi=
_ddrc_flux_wcmd =3D {
> >       .event =3D {
> >               .name =3D "uncore_hisi_ddrc.flux_wcmd",
> >               .event =3D "event=3D0x2",
> > -             .desc =3D "DDRC write commands. Unit: hisi_sccl,ddrc ",
> > +             .desc =3D "DDRC write commands. Unit: hisi_sccl,ddrc",
> >               .topic =3D "uncore",
> >               .long_desc =3D "DDRC write commands",
> >               .pmu =3D "hisi_sccl,ddrc",
> > @@ -137,7 +143,7 @@ static const struct perf_pmu_test_event unc_cbo_xsn=
p_response_miss_eviction =3D {
> >       .event =3D {
> >               .name =3D "unc_cbo_xsnp_response.miss_eviction",
> >               .event =3D "event=3D0x22,umask=3D0x81",
> > -             .desc =3D "A cross-core snoop resulted from L3 Eviction w=
hich misses in some processor core. Unit: uncore_cbox ",
> > +             .desc =3D "A cross-core snoop resulted from L3 Eviction w=
hich misses in some processor core. Unit: uncore_cbox",
> >               .topic =3D "uncore",
> >               .long_desc =3D "A cross-core snoop resulted from L3 Evict=
ion which misses in some processor core",
> >               .pmu =3D "uncore_cbox",
> > @@ -151,7 +157,7 @@ static const struct perf_pmu_test_event uncore_hyph=
en =3D {
> >       .event =3D {
> >               .name =3D "event-hyphen",
> >               .event =3D "event=3D0xe0,umask=3D0x00",
> > -             .desc =3D "UNC_CBO_HYPHEN. Unit: uncore_cbox ",
> > +             .desc =3D "UNC_CBO_HYPHEN. Unit: uncore_cbox",
> >               .topic =3D "uncore",
> >               .long_desc =3D "UNC_CBO_HYPHEN",
> >               .pmu =3D "uncore_cbox",
> > @@ -165,7 +171,7 @@ static const struct perf_pmu_test_event uncore_two_=
hyph =3D {
> >       .event =3D {
> >               .name =3D "event-two-hyph",
> >               .event =3D "event=3D0xc0,umask=3D0x00",
> > -             .desc =3D "UNC_CBO_TWO_HYPH. Unit: uncore_cbox ",
> > +             .desc =3D "UNC_CBO_TWO_HYPH. Unit: uncore_cbox",
> >               .topic =3D "uncore",
> >               .long_desc =3D "UNC_CBO_TWO_HYPH",
> >               .pmu =3D "uncore_cbox",
> > @@ -179,7 +185,7 @@ static const struct perf_pmu_test_event uncore_hisi=
_l3c_rd_hit_cpipe =3D {
> >       .event =3D {
> >               .name =3D "uncore_hisi_l3c.rd_hit_cpipe",
> >               .event =3D "event=3D0x7",
> > -             .desc =3D "Total read hits. Unit: hisi_sccl,l3c ",
> > +             .desc =3D "Total read hits. Unit: hisi_sccl,l3c",
> >               .topic =3D "uncore",
> >               .long_desc =3D "Total read hits",
> >               .pmu =3D "hisi_sccl,l3c",
> > @@ -193,7 +199,7 @@ static const struct perf_pmu_test_event uncore_imc_=
free_running_cache_miss =3D {
> >       .event =3D {
> >               .name =3D "uncore_imc_free_running.cache_miss",
> >               .event =3D "event=3D0x12",
> > -             .desc =3D "Total cache misses. Unit: uncore_imc_free_runn=
ing ",
> > +             .desc =3D "Total cache misses. Unit: uncore_imc_free_runn=
ing",
> >               .topic =3D "uncore",
> >               .long_desc =3D "Total cache misses",
> >               .pmu =3D "uncore_imc_free_running",
> > @@ -207,7 +213,7 @@ static const struct perf_pmu_test_event uncore_imc_=
cache_hits =3D {
> >       .event =3D {
> >               .name =3D "uncore_imc.cache_hits",
> >               .event =3D "event=3D0x34",
> > -             .desc =3D "Total cache hits. Unit: uncore_imc ",
> > +             .desc =3D "Total cache hits. Unit: uncore_imc",
> >               .topic =3D "uncore",
> >               .long_desc =3D "Total cache hits",
> >               .pmu =3D "uncore_imc",
> > @@ -232,13 +238,13 @@ static const struct perf_pmu_test_event sys_ddr_p=
mu_write_cycles =3D {
> >       .event =3D {
> >               .name =3D "sys_ddr_pmu.write_cycles",
> >               .event =3D "event=3D0x2b",
> > -             .desc =3D "ddr write-cycles event. Unit: uncore_sys_ddr_p=
mu ",
> > +             .desc =3D "ddr write-cycles event. Unit: uncore_sys_ddr_p=
mu",
> >               .topic =3D "uncore",
> >               .pmu =3D "uncore_sys_ddr_pmu",
> >               .compat =3D "v8",
> >       },
> >       .alias_str =3D "event=3D0x2b",
> > -     .alias_long_desc =3D "ddr write-cycles event. Unit: uncore_sys_dd=
r_pmu ",
> > +     .alias_long_desc =3D "ddr write-cycles event. Unit: uncore_sys_dd=
r_pmu",
> >       .matching_pmu =3D "uncore_sys_ddr_pmu",
> >  };
> >
> > @@ -246,13 +252,13 @@ static const struct perf_pmu_test_event sys_ccn_p=
mu_read_cycles =3D {
> >       .event =3D {
> >               .name =3D "sys_ccn_pmu.read_cycles",
> >               .event =3D "config=3D0x2c",
> > -             .desc =3D "ccn read-cycles event. Unit: uncore_sys_ccn_pm=
u ",
> > +             .desc =3D "ccn read-cycles event. Unit: uncore_sys_ccn_pm=
u",
> >               .topic =3D "uncore",
> >               .pmu =3D "uncore_sys_ccn_pmu",
> >               .compat =3D "0x01",
> >       },
> >       .alias_str =3D "config=3D0x2c",
> > -     .alias_long_desc =3D "ccn read-cycles event. Unit: uncore_sys_ccn=
_pmu ",
> > +     .alias_long_desc =3D "ccn read-cycles event. Unit: uncore_sys_ccn=
_pmu",
> >       .matching_pmu =3D "uncore_sys_ccn_pmu",
> >  };
> >
> > @@ -403,7 +409,7 @@ static int test__pmu_event_table_core_callback(cons=
t struct pmu_event *pe,
> >       struct perf_pmu_test_event const **test_event_table;
> >       bool found =3D false;
> >
> > -     if (pe->pmu)
> > +     if (strcmp(pe->pmu, "cpu"))
> >               test_event_table =3D &uncore_events[0];
> >       else
> >               test_event_table =3D &core_events[0];
