Return-Path: <linux-kernel+bounces-147967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 518B48A7BF1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 07:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2E44284B10
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 05:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A3B53389;
	Wed, 17 Apr 2024 05:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="QDl3W4nf"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DEE4EB5F
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 05:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713332586; cv=none; b=Rie9n7xAfqhRbDFBKgWyNN6GhqI2uihcLIbEzImOeJakZHcFRIiQp97GL9D9k2tEVwEyW0HLszYZIUq+UpQIBtMus6/72tff9Bc+4F/Q8faIZ7ezk1MercFxI+EBcJPPGKjEXzjBEMp4pZTfUqoIQ90TTI+smIGJyCIdV8dvu5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713332586; c=relaxed/simple;
	bh=6Lhu7wjiBmAiZqtnnjsUR4+xVL75g9RuJ5+qz7eaRuQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fW5jb6RakucZAN7grHuoHs6c2whXLRD+q+F3o/oyWjgSEEKvq+tZ3CCUkuYlgBpZgkucIyPP4TcZYoIBhkFUpIc1SbU8FTroD5/dp6v6dfchvT+Smx4UHtllNwTQyPXWEN9VW8FXptzfkxswSTZ3s/6s31sdxiCBNXnx6F6SE2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QDl3W4nf; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1e6628d76d6so93335ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 22:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713332583; x=1713937383; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qUI945gt6DJrcpXklKnKsuU9uP6BdRWOzsG1OPcpwMM=;
        b=QDl3W4nfIidtB76yoqwP16GQRGqF1+FHfQYpNAFU5m0PIBqXiocSPFAdcuh69HOu2z
         6w3+GR3/tc0O3yQjVYjx6RnkoKTIuR+84PKxv2JI+nVgJskWhsSCHQA6CRdfGwpWHc9+
         1t1dufnH21280ApCV7eYlLp1A1X43idSvFiQZ8gmXE3Khpyv1TF+KigXRAVamgWI83F9
         Mz8t3g1ACMyO2UenxkO1xdfQ1S9bEQgJ17lUesQ36qCW/U7jAqzlAkkurXKrWbFm/ueb
         YkxL1o0hgbFcNhBeD201v18VrdFJCLZdBfh/EDagB1Xwmdrvoq4aGJC9Gc0QLUaU/y5b
         GvzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713332583; x=1713937383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qUI945gt6DJrcpXklKnKsuU9uP6BdRWOzsG1OPcpwMM=;
        b=X73P5q5A+mGEpQwB0bCb7xUEpZx/t1rvZUrf4p2MmV9jMjhppXk+3gjBGWwbQCjc0p
         Vau/hCzx/ekyRXpzUVGg0rKBUdMt+RyHtbbJsBldJXfv5w0Ga4fAGD9A+cCO+fjJGums
         rbYiVsMzK3YN22WkC3xCeKQZlIEmLA4jkvi4OePxKMw8LMvmm22h9QOoWMGBybc2JIbr
         fnPQafaNzfMag8C6J7YUSbk4Uinui99GEMrK47D/yTaFIj1JzcIqxKRz0L4KhWGNO5NY
         BKa8PWx12hpWFyCTZW38/+Bf/2qa0MQKfNdWYu/xiJcVIqQuCmsxSiWZjhtKsR9nWhlA
         jTdA==
X-Forwarded-Encrypted: i=1; AJvYcCW9WX+NC4fJrvqRgqYSW/Hf6jv2sRb1rvweVpdlGBuVsGjp+T92UAluijR3MM9MwIp3RmKvFhhrwb3hlDCO6aLhCHMPCl+C5mHLpTzP
X-Gm-Message-State: AOJu0Yyco9Y8dxz/65FWn27uy+ajuhQMW58un7kIt4ivMLHWUoP1rOGQ
	LVuXX45ddfCDYciSj4ZEA+0HplG4qOa/9gyZ8iR7QMHa8YcpcpVSitLny8bPXn/VvUFx5QAVNfJ
	8nean+TdF3HJGxb36sQKgHG442NvHCuytp25q
X-Google-Smtp-Source: AGHT+IEbPCnu3DaCM3JQZsOVesuW6Fi7JmQXjyedp1MVEZvi/s2+N6+QIuGrOTry5Ipyffu7bNmpQYaRbhwddamL690=
X-Received: by 2002:a17:902:d512:b0:1e7:b704:3e62 with SMTP id
 b18-20020a170902d51200b001e7b7043e62mr159280plg.4.1713332582305; Tue, 16 Apr
 2024 22:43:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412210756.309828-1-weilin.wang@intel.com> <20240412210756.309828-4-weilin.wang@intel.com>
In-Reply-To: <20240412210756.309828-4-weilin.wang@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 16 Apr 2024 22:42:46 -0700
Message-ID: <CAP-5=fVio_jv-ix8rm2=2SEWmgni_iCoVEHTPK43GFp9NZxQCw@mail.gmail.com>
Subject: Re: [RFC PATCH v5 03/16] perf pmu-events: Add functions in jevent.py
 to parse counter and event info for hardware aware grouping
To: weilin.wang@intel.com
Cc: Kan Liang <kan.liang@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Perry Taylor <perry.taylor@intel.com>, 
	Samantha Alt <samantha.alt@intel.com>, Caleb Biggers <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 2:08=E2=80=AFPM <weilin.wang@intel.com> wrote:
>
> From: Weilin Wang <weilin.wang@intel.com>
>
> These functions are added to parse event counter restrictions and counter
> availability info from json files so that the metric grouping method coul=
d
> do grouping based on the counter restriction of events and the counters
> that are available on the system.
>
> Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> ---
>  tools/perf/pmu-events/jevents.py   | 204 +++++++++++++++++++++++++++--
>  tools/perf/pmu-events/pmu-events.h |  32 ++++-
>  2 files changed, 224 insertions(+), 12 deletions(-)
>
> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jev=
ents.py
> index e42efc16723e..7cfd86d77fea 100755
> --- a/tools/perf/pmu-events/jevents.py
> +++ b/tools/perf/pmu-events/jevents.py
> @@ -23,6 +23,8 @@ _metric_tables =3D []
>  _sys_metric_tables =3D []
>  # Mapping between sys event table names and sys metric table names.
>  _sys_event_table_to_metric_table_mapping =3D {}
> +# List of regular PMU counter layout tables.
> +_pmu_layouts_tables =3D []
>  # Map from an event name to an architecture standard
>  # JsonEvent. Architecture standard events are in json files in the top
>  # f'{_args.starting_dir}/{_args.arch}' directory.
> @@ -31,6 +33,10 @@ _arch_std_events =3D {}
>  _pending_events =3D []
>  # Name of events table to be written out
>  _pending_events_tblname =3D None
> +# PMU counter layout to write out when the layout table is closed
> +_pending_pmu_counts =3D []
> +# Name of PMU counter layout table to be written out
> +_pending_pmu_counts_tblname =3D None
>  # Metrics to write out when the table is closed
>  _pending_metrics =3D []
>  # Name of metrics table to be written out
> @@ -51,6 +57,11 @@ _json_event_attributes =3D [
>      'long_desc'
>  ]
>
> +# Attributes that are in pmu_unit_layout.
> +_json_layout_attributes =3D [
> +    'pmu', 'desc'
> +]
> +
>  # Attributes that are in pmu_metric rather than pmu_event.
>  _json_metric_attributes =3D [
>      'metric_name', 'metric_group', 'metric_expr', 'metric_threshold',
> @@ -265,7 +276,7 @@ class JsonEvent:
>
>      def unit_to_pmu(unit: str) -> Optional[str]:
>        """Convert a JSON Unit to Linux PMU name."""
> -      if not unit:
> +      if not unit or unit =3D=3D "core":
>          return 'default_core'
>        # Comment brought over from jevents.c:
>        # it's not realistic to keep adding these, we need something more =
scalable ...
> @@ -334,6 +345,19 @@ class JsonEvent:
>      if 'Errata' in jd:
>        extra_desc +=3D '  Spec update: ' + jd['Errata']
>      self.pmu =3D unit_to_pmu(jd.get('Unit'))
> +    # The list of counter(s) the event could be collected with
> +    class Counter:
> +      gp =3D str()
> +      fixed =3D str()
> +    self.counters =3D {'list': str(), 'num': Counter()}
> +    self.counters['list'] =3D jd.get('Counter')
> +    # Number of generic counter
> +    self.counters['num'].gp =3D jd.get('CountersNumGeneric')
> +    # Number of fixed counter
> +    self.counters['num'].fixed =3D jd.get('CountersNumFixed')
> +    # If the event uses an MSR, other event uses the same MSR could not =
be
> +    # schedule to collect at the same time.
> +    self.msr =3D jd.get('MSRIndex')
>      filter =3D jd.get('Filter')
>      self.unit =3D jd.get('ScaleUnit')
>      self.perpkg =3D jd.get('PerPkg')
> @@ -409,8 +433,20 @@ class JsonEvent:
>          s +=3D f'\t{attr} =3D {value},\n'
>      return s + '}'
>
> -  def build_c_string(self, metric: bool) -> str:
> +  def build_c_string(self, metric: bool, layout: bool) -> str:
>      s =3D ''
> +    if layout:
> +      for attr in _json_layout_attributes:
> +        x =3D getattr(self, attr)
> +        if attr in _json_enum_attributes:
> +          s +=3D x if x else '0'
> +        else:
> +          s +=3D f'{x}\\000' if x else '\\000'
> +      x =3D self.counters['num'].gp
> +      s +=3D x if x else '0'
> +      x =3D self.counters['num'].fixed
> +      s +=3D x if x else '0'
> +      return s
>      for attr in _json_metric_attributes if metric else _json_event_attri=
butes:
>        x =3D getattr(self, attr)
>        if metric and x and attr =3D=3D 'metric_expr':
> @@ -423,12 +459,15 @@ class JsonEvent:
>          s +=3D x if x else '0'
>        else:
>          s +=3D f'{x}\\000' if x else '\\000'
> +    if not metric:
> +      x =3D self.counters['list']
> +      s +=3D f'{x}\\000' if x else '\\000'
>      return s
>
> -  def to_c_string(self, metric: bool) -> str:
> +  def to_c_string(self, metric: bool, layout: bool) -> str:
>      """Representation of the event as a C struct initializer."""
>
> -    s =3D self.build_c_string(metric)
> +    s =3D self.build_c_string(metric, layout)
>      return f'{{ { _bcs.offsets[s] } }}, /* {s} */\n'
>
>
> @@ -465,6 +504,8 @@ def preprocess_arch_std_files(archpath: str) -> None:
>            _arch_std_events[event.name.lower()] =3D event
>          if event.metric_name:
>            _arch_std_events[event.metric_name.lower()] =3D event
> +        if event.counters['num'].gp:
> +          _arch_std_events[event.pmu.lower()] =3D event
>
>
>  def add_events_table_entries(item: os.DirEntry, topic: str) -> None:
> @@ -474,6 +515,8 @@ def add_events_table_entries(item: os.DirEntry, topic=
: str) -> None:
>        _pending_events.append(e)
>      if e.metric_name:
>        _pending_metrics.append(e)
> +    if e.counters['num'].gp:
> +      _pending_pmu_counts.append(e)
>
>
>  def print_pending_events() -> None:
> @@ -514,7 +557,7 @@ def print_pending_events() -> None:
>        last_pmu =3D event.pmu
>        pmus.add((event.pmu, pmu_name))
>
> -    _args.output_file.write(event.to_c_string(metric=3DFalse))
> +    _args.output_file.write(event.to_c_string(metric=3DFalse, layout=3DF=
alse))
>    _pending_events =3D []
>
>    _args.output_file.write(f"""
> @@ -569,7 +612,7 @@ def print_pending_metrics() -> None:
>        last_pmu =3D metric.pmu
>        pmus.add((metric.pmu, pmu_name))
>
> -    _args.output_file.write(metric.to_c_string(metric=3DTrue))
> +    _args.output_file.write(metric.to_c_string(metric=3DTrue, layout=3DF=
alse))
>    _pending_metrics =3D []
>
>    _args.output_file.write(f"""
> @@ -587,6 +630,35 @@ const struct pmu_table_entry {_pending_metrics_tblna=
me}[] =3D {{
>  """)
>    _args.output_file.write('};\n\n')
>
> +def print_pending_pmu_counter_layout_table() -> None:
> +  '''Print counter layout data from counter.json file to counter layout =
table in
> +    c-string'''
> +
> +  def pmu_counts_cmp_key(j: JsonEvent) -> Tuple[bool, str, str]:
> +    def fix_none(s: Optional[str]) -> str:
> +      if s is None:
> +        return ''
> +      return s
> +
> +    return (j.desc is not None, fix_none(j.pmu))
> +
> +  global _pending_pmu_counts
> +  if not _pending_pmu_counts:
> +    return
> +
> +  global _pending_pmu_counts_tblname
> +  global pmu_layouts_tables
> +  _pmu_layouts_tables.append(_pending_pmu_counts_tblname)
> +
> +  _args.output_file.write(
> +      f'static const struct compact_pmu_event {_pending_pmu_counts_tblna=
me}[] =3D {{\n')
> +
> +  for pmu_layout in sorted(_pending_pmu_counts, key=3Dpmu_counts_cmp_key=
):
> +    _args.output_file.write(pmu_layout.to_c_string(metric=3DFalse, layou=
t=3DTrue))
> +    _pending_pmu_counts =3D []
> +
> +  _args.output_file.write('};\n\n')
> +
>  def get_topic(topic: str) -> str:
>    if topic.endswith('metrics.json'):
>      return 'metrics'
> @@ -623,10 +695,12 @@ def preprocess_one_file(parents: Sequence[str], ite=
m: os.DirEntry) -> None:
>      pmu_name =3D f"{event.pmu}\\000"
>      if event.name:
>        _bcs.add(pmu_name, metric=3DFalse)
> -      _bcs.add(event.build_c_string(metric=3DFalse), metric=3DFalse)
> +      _bcs.add(event.build_c_string(metric=3DFalse, layout=3DFalse), met=
ric=3DFalse)
>      if event.metric_name:
>        _bcs.add(pmu_name, metric=3DTrue)
> -      _bcs.add(event.build_c_string(metric=3DTrue), metric=3DTrue)
> +      _bcs.add(event.build_c_string(metric=3DTrue, layout=3DFalse), metr=
ic=3DTrue)
> +    if event.counters['num'].gp:
> +      _bcs.add(event.build_c_string(metric=3DFalse, layout=3DTrue), metr=
ic=3DFalse)
>
>  def process_one_file(parents: Sequence[str], item: os.DirEntry) -> None:
>    """Process a JSON file during the main walk."""
> @@ -640,11 +714,14 @@ def process_one_file(parents: Sequence[str], item: =
os.DirEntry) -> None:
>    if item.is_dir() and is_leaf_dir(item.path):
>      print_pending_events()
>      print_pending_metrics()
> +    print_pending_pmu_counter_layout_table()
>
>      global _pending_events_tblname
>      _pending_events_tblname =3D file_name_to_table_name('pmu_events_', p=
arents, item.name)
>      global _pending_metrics_tblname
>      _pending_metrics_tblname =3D file_name_to_table_name('pmu_metrics_',=
 parents, item.name)
> +    global _pending_pmu_counts_tblname
> +    _pending_pmu_counts_tblname =3D file_name_to_table_name('pmu_layouts=
_', parents, item.name)
>
>      if item.name =3D=3D 'sys':
>        _sys_event_table_to_metric_table_mapping[_pending_events_tblname] =
=3D _pending_metrics_tblname
> @@ -678,6 +755,12 @@ struct pmu_metrics_table {
>          uint32_t num_pmus;
>  };
>
> +/* Struct used to make the PMU counter layout table implementation opaqu=
e to callers. */
> +struct pmu_layouts_table {
> +        const struct compact_pmu_event *entries;
> +        size_t length;
> +};
> +
>  /*
>   * Map a CPU to its table of PMU events. The CPU is identified by the
>   * cpuid field, which is an arch-specific identifier for the CPU.
> @@ -691,6 +774,7 @@ struct pmu_events_map {
>          const char *cpuid;
>          struct pmu_events_table event_table;
>          struct pmu_metrics_table metric_table;
> +        struct pmu_layouts_table layout_table;
>  };
>
>  /*
> @@ -735,6 +819,12 @@ const struct pmu_events_map pmu_events_map[] =3D {
>                metric_size =3D '0'
>              if event_size =3D=3D '0' and metric_size =3D=3D '0':
>                continue
> +            layout_tblname =3D file_name_to_table_name('pmu_layouts_', [=
], row[2].replace('/', '_'))
> +            if layout_tblname in _pmu_layouts_tables:
> +              layout_size =3D f'ARRAY_SIZE({layout_tblname})'
> +            else:
> +              layout_tblname =3D 'NULL'
> +              layout_size =3D '0'
>              cpuid =3D row[0].replace('\\', '\\\\')
>              _args.output_file.write(f"""{{
>  \t.arch =3D "{arch}",
> @@ -746,6 +836,10 @@ const struct pmu_events_map pmu_events_map[] =3D {
>  \t.metric_table =3D {{
>  \t\t.pmus =3D {metric_tblname},
>  \t\t.num_pmus =3D {metric_size}
> +\t}},
> +\t.layout_table =3D {{
> +\t\t.entries =3D {layout_tblname},
> +\t\t.length =3D {layout_size}
>  \t}}
>  }},
>  """)
> @@ -756,6 +850,7 @@ const struct pmu_events_map pmu_events_map[] =3D {
>  \t.cpuid =3D 0,
>  \t.event_table =3D { 0, 0 },
>  \t.metric_table =3D { 0, 0 },
> +\t.layout_table =3D { 0, 0 },
>  }
>  };
>  """)
> @@ -824,6 +919,9 @@ static void decompress_event(int offset, struct pmu_e=
vent *pe)
>        _args.output_file.write('\tp++;')
>      else:
>        _args.output_file.write('\twhile (*p++);')
> +  _args.output_file.write('\twhile (*p++);')
> +  _args.output_file.write(f'\n\tpe->counters_list =3D ')
> +  _args.output_file.write("(*p =3D=3D '\\0' ? NULL : p);\n")
>    _args.output_file.write("""}
>
>  static void decompress_metric(int offset, struct pmu_metric *pm)
> @@ -844,6 +942,30 @@ static void decompress_metric(int offset, struct pmu=
_metric *pm)
>        _args.output_file.write('\twhile (*p++);')
>    _args.output_file.write("""}
>
> +static void decompress_layout(int offset, struct pmu_layout *pm)
> +{
> +\tconst char *p =3D &big_c_string[offset];
> +""")
> +  for attr in _json_layout_attributes:
> +    _args.output_file.write(f'\n\tpm->{attr} =3D ')
> +    if attr in _json_enum_attributes:
> +      _args.output_file.write("*p - '0';\n")
> +    else:
> +      _args.output_file.write("(*p =3D=3D '\\0' ? NULL : p);\n")
> +    if attr =3D=3D _json_layout_attributes[-1]:
> +      continue
> +    if attr in _json_enum_attributes:
> +      _args.output_file.write('\tp++;')
> +    else:
> +      _args.output_file.write('\twhile (*p++);')
> +  _args.output_file.write('\tp++;')
> +  _args.output_file.write(f'\n\tpm->counters_num_gp =3D ')
> +  _args.output_file.write("*p - '0';\n")
> +  _args.output_file.write('\tp++;')
> +  _args.output_file.write(f'\n\tpm->counters_num_fixed =3D ')
> +  _args.output_file.write("*p - '0';\n")
> +  _args.output_file.write("""}
> +
>  static int pmu_events_table__for_each_event_pmu(const struct pmu_events_=
table *table,
>                                                  const struct pmu_table_e=
ntry *pmu,
>                                                  pmu_event_iter_fn fn,
> @@ -999,6 +1121,21 @@ int pmu_metrics_table__for_each_metric(const struct=
 pmu_metrics_table *table,
>          return 0;
>  }
>
> +int pmu_layouts_table__for_each_layout(const struct pmu_layouts_table *t=
able,
> +                                     pmu_layout_iter_fn fn,
> +                                     void *data) {
> +        for (size_t i =3D 0; i < table->length; i++) {
> +                struct pmu_layout pm;
> +                int ret;
> +
> +                decompress_layout(table->entries[i].offset, &pm);
> +                ret =3D fn(&pm, data);
> +                if (ret)
> +                        return ret;
> +        }
> +        return 0;
> +}
> +
>  static const struct pmu_events_map *map_for_pmu(struct perf_pmu *pmu)
>  {
>          static struct {
> @@ -1094,6 +1231,33 @@ const struct pmu_metrics_table *perf_pmu__find_met=
rics_table(struct perf_pmu *pm
>          return NULL;
>  }
>
> +const struct pmu_layouts_table *perf_pmu__find_layouts_table(struct perf=
_pmu *pmu)
> +{
> +        const struct pmu_layouts_table *table =3D NULL;
> +        char *cpuid =3D perf_pmu__getcpuid(pmu);
> +        int i;
> +
> +        /* on some platforms which uses cpus map, cpuid can be NULL for
> +         * PMUs other than CORE PMUs.
> +         */
> +        if (!cpuid)
> +                return NULL;
> +
> +        i =3D 0;
> +        for (;;) {
> +                const struct pmu_events_map *map =3D &pmu_events_map[i++=
];
> +                if (!map->arch)
> +                        break;
> +
> +                if (!strcmp_cpuid_str(map->cpuid, cpuid)) {
> +                        table =3D &map->layout_table;
> +                        break;
> +                }
> +        }
> +        free(cpuid);
> +        return table;
> +}
> +
>  const struct pmu_events_table *find_core_events_table(const char *arch, =
const char *cpuid)
>  {
>          for (const struct pmu_events_map *tables =3D &pmu_events_map[0];
> @@ -1115,6 +1279,16 @@ const struct pmu_metrics_table *find_core_metrics_=
table(const char *arch, const
>          }
>          return NULL;
>  }
> +const struct pmu_layouts_table *find_core_layouts_table(const char *arch=
, const char *cpuid)
> +{
> +        for (const struct pmu_events_map *tables =3D &pmu_events_map[0];
> +             tables->arch;
> +             tables++) {
> +                if (!strcmp(tables->arch, arch) && !strcmp_cpuid_str(tab=
les->cpuid, cpuid))
> +                        return &tables->layout_table;
> +        }
> +        return NULL;
> +}
>
>  int pmu_for_each_core_event(pmu_event_iter_fn fn, void *data)
>  {
> @@ -1143,6 +1317,19 @@ int pmu_for_each_core_metric(pmu_metric_iter_fn fn=
, void *data)
>          return 0;
>  }
>
> +int pmu_for_each_core_layout(pmu_layout_iter_fn fn, void *data)
> +{
> +        for (const struct pmu_events_map *tables =3D &pmu_events_map[0];
> +             tables->arch;
> +             tables++) {
> +                int ret =3D pmu_layouts_table__for_each_layout(&tables->=
layout_table, fn, data);
> +
> +                if (ret)
> +                        return ret;
> +        }
> +        return 0;
> +}
> +
>  const struct pmu_events_table *find_sys_events_table(const char *name)
>  {
>          for (const struct pmu_sys_events *tables =3D &pmu_sys_event_tabl=
es[0];
> @@ -1299,6 +1486,7 @@ struct pmu_table_entry {
>      ftw(arch_path, [], process_one_file)
>      print_pending_events()
>      print_pending_metrics()
> +    print_pending_pmu_counter_layout_table()
>
>    print_mapping_table(archs)
>    print_system_mapping_table()
> diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/p=
mu-events.h
> index f5aa96f1685c..5b42a18693cf 100644
> --- a/tools/perf/pmu-events/pmu-events.h
> +++ b/tools/perf/pmu-events/pmu-events.h
> @@ -45,6 +45,11 @@ struct pmu_event {
>         const char *desc;
>         const char *topic;
>         const char *long_desc;
> +       /**
> +        * The list of counter(s) the event could be collected on.
> +        * eg., "0,1,2,3,4,5,6,7".
> +        */
> +       const char *counters_list;
>         const char *pmu;
>         const char *unit;
>         bool perpkg;
> @@ -67,8 +72,18 @@ struct pmu_metric {
>         enum metric_event_groups event_grouping;
>  };
>
> +struct pmu_layout {
> +       const char *pmu;
> +       const char *desc;
> +       /** Total number of generic counters*/
> +       int counters_num_gp;
> +       /** Total number of fixed counters. Set to zero if no fixed count=
er on the unit.*/
> +       int counters_num_fixed;
> +};
> +
>  struct pmu_events_table;
>  struct pmu_metrics_table;
> +struct pmu_layouts_table;
>
>  typedef int (*pmu_event_iter_fn)(const struct pmu_event *pe,
>                                  const struct pmu_events_table *table,
> @@ -78,15 +93,21 @@ typedef int (*pmu_metric_iter_fn)(const struct pmu_me=
tric *pm,
>                                   const struct pmu_metrics_table *table,
>                                   void *data);
>
> +typedef int (*pmu_layout_iter_fn)(const struct pmu_layout *pm,
> +                                 void *data);
> +
>  int pmu_events_table__for_each_event(const struct pmu_events_table *tabl=
e,
>                                     struct perf_pmu *pmu,
>                                     pmu_event_iter_fn fn,
>                                     void *data);
>  int pmu_events_table__find_event(const struct pmu_events_table *table,
> -                                 struct perf_pmu *pmu,
> -                                 const char *name,
> -                                 pmu_event_iter_fn fn,
> -                                void *data);
> +                               struct perf_pmu *pmu,
> +                               const char *name,
> +                               pmu_event_iter_fn fn,
> +                               void *data);
> +int pmu_layouts_table__for_each_layout(const struct pmu_layouts_table *t=
able,
> +                                       pmu_layout_iter_fn fn,
> +                                       void *data);
>  size_t pmu_events_table__num_events(const struct pmu_events_table *table=
,
>                                     struct perf_pmu *pmu);
>
> @@ -95,10 +116,13 @@ int pmu_metrics_table__for_each_metric(const struct =
pmu_metrics_table *table, pm
>
>  const struct pmu_events_table *perf_pmu__find_events_table(struct perf_p=
mu *pmu);
>  const struct pmu_metrics_table *perf_pmu__find_metrics_table(struct perf=
_pmu *pmu);
> +const struct pmu_layouts_table *perf_pmu__find_layouts_table(struct perf=
_pmu *pmu);
>  const struct pmu_events_table *find_core_events_table(const char *arch, =
const char *cpuid);
>  const struct pmu_metrics_table *find_core_metrics_table(const char *arch=
, const char *cpuid);
> +const struct pmu_layouts_table *find_core_layouts_table(const char *arch=
, const char *cpuid);
>  int pmu_for_each_core_event(pmu_event_iter_fn fn, void *data);
>  int pmu_for_each_core_metric(pmu_metric_iter_fn fn, void *data);
> +int pmu_for_each_core_layout(pmu_layout_iter_fn fn, void *data);

When python isn't installed a build can happen if NO_JEVENTS=3D1 is
passed to the make command. In that case we use a non-generated
pmu-events.c copied from tools/perf/pmu-events/empty-pmu-events.c:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/pmu-events/empty-pmu-events.c?h=3Dperf-tools-next

I wonder we should just generate this file, but currently it is
written manually. This change builds and links for me with
NO_JEVENTS=3D1 but I get linker error on patch "perf stat: Add functions
to get counter info":
````
$ make -C tools/perf O=3D/tmp/perf DEBUG=3D1 NO_JEVENTS=3D1
..
  LINK    /tmp/perf/perf
/usr/bin/ld: /tmp/perf/perf-in.o: in function `get_pmu_counter_layouts':
tools/perf/util/metricgroup.c:1739:(.text+0x159d99): undefined
reference to `pmu_layouts_table__for_each_layout'
/usr/bin/ld: /tmp/perf/perf-in.o: in function `hw_aware_build_grouping':
tools/perf/util/metricgroup.c:1764:(.text+0x159e2a): undefined
reference to `perf_pmu__find_layouts_table'
collect2: error: ld returned 1 exit status
```

Thanks,
Ian

>
>  const struct pmu_events_table *find_sys_events_table(const char *name);
>  const struct pmu_metrics_table *find_sys_metrics_table(const char *name)=
;
> --
> 2.42.0
>

