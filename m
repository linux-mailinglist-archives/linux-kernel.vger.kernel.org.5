Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55BBF7AEF7D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 17:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbjIZPTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 11:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjIZPTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 11:19:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78AA810A;
        Tue, 26 Sep 2023 08:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695741544; x=1727277544;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=u7xItCAFktBTCZ+ZX96seTx2TlThUvaUZ0G6ebc0fqg=;
  b=eENn9te/KPR4zr5DEpu7vq1pwpbKFQPd0mQSoXeWQM1wNZTZPJX6BW8A
   PvPkB/u8D9XZ/oRRzpWf6J5cPzjDQ4LvXXFmxv+0F2/X/kI06UMk7IEZ7
   innFkgVewFuItKRjd37bsH5EhDn/D1/ZeQSCduOPlnpCWuqQmZ2yyuvck
   Eu7cdVES+zJ8+iiyFmNgViaY3JcP1gf8dhl/+jQVcU/jDtI+iG+2RomaP
   VZOlt5x1t3sQwSbbXBRZdf90Y2A9qgqh6XX6IxzzMy9hUUin3FsKny7pF
   IyVqShNck3Zpgs+fmAQKThH18RkfvacGCqyq+q8duWVPp3Lvpj5q9B7dL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="360968669"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="360968669"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 08:17:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="188842"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 08:17:11 -0700
Received: from [10.209.130.196] (kliang2-mobl1.ccr.corp.intel.com [10.209.130.196])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 7BB18580BBE;
        Tue, 26 Sep 2023 08:17:08 -0700 (PDT)
Message-ID: <9756d1cd-096f-d1d9-af6f-0c3e38e251f2@linux.intel.com>
Date:   Tue, 26 Sep 2023 11:17:07 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH 03/25] perf pmu-events: Add functions in jevent.py
Content-Language: en-US
To:     weilin.wang@intel.com, Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Mark Rutland <mark.rutland@arm.com>
References: <20230925061824.3818631-1-weilin.wang@intel.com>
 <20230925061824.3818631-4-weilin.wang@intel.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230925061824.3818631-4-weilin.wang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


"perf pmu-events: Add functions in jevent.py"

It's better to have a meaningful title. Most of titles in the patch
series are "Add functions to ...", which doesn't provide any useful
information.

Try something like, Support counter information in jevent.py

On 2023-09-25 2:18 a.m., weilin.wang@intel.com wrote:
> From: Weilin Wang <weilin.wang@intel.com>
> 
> These functions are added to parse event counter restrictions and counter
> availability info from json files so that the metric grouping method could
> do grouping based on the counter restriction of events and the counters
> that are available on the system.
> 
> Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> ---
>  tools/perf/pmu-events/jevents.py   | 174 ++++++++++++++++++++++++++++-
>  tools/perf/pmu-events/pmu-events.h |  25 ++++-
>  2 files changed, 191 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
> index a7e883322..2809f68d2 100755
> --- a/tools/perf/pmu-events/jevents.py
> +++ b/tools/perf/pmu-events/jevents.py
> @@ -23,6 +23,8 @@ _metric_tables = []
>  _sys_metric_tables = []
>  # Mapping between sys event table names and sys metric table names.
>  _sys_event_table_to_metric_table_mapping = {}
> +# List of regular PMU counter layout tables.
> +_pmu_layouts_tables = []
>  # Map from an event name to an architecture standard
>  # JsonEvent. Architecture standard events are in json files in the top
>  # f'{_args.starting_dir}/{_args.arch}' directory.
> @@ -31,6 +33,9 @@ _arch_std_events = {}
>  _pending_events = []
>  # Name of events table to be written out
>  _pending_events_tblname = None
> +# PMU counter layout to write out when the table is closed
> +_pending_pmu_counts = [] # Name of PMU counter layout table to be written out
> +_pending_pmu_counts_tblname = None
>  # Metrics to write out when the table is closed
>  _pending_metrics = []
>  # Name of metrics table to be written out
> @@ -47,10 +52,17 @@ _json_event_attributes = [
>      'event',
>      # Short things in alphabetical order.
>      'compat', 'deprecated', 'perpkg', 'unit',
> +    # Counter this event could use
> +    'counter',
>      # Longer things (the last won't be iterated over during decompress).
>      'long_desc'
>  ]
>  
> +# Attributes that are in pmu_unit_layout.
> +_json_layout_attributes = [
> +    'pmu', 'desc', 'size', 'fixed_size'
> +]
> +
>  # Attributes that are in pmu_metric rather than pmu_event.
>  _json_metric_attributes = [
>      'metric_name', 'metric_group', 'metric_expr', 'metric_threshold',
> @@ -58,7 +70,9 @@ _json_metric_attributes = [
>      'default_metricgroup_name', 'aggr_mode', 'event_grouping'
>  ]
>  # Attributes that are bools or enum int values, encoded as '0', '1',...
> -_json_enum_attributes = ['aggr_mode', 'deprecated', 'event_grouping', 'perpkg']
> +_json_enum_attributes = ['aggr_mode', 'deprecated', 'event_grouping', 'perpkg',
> +    'size', 'fixed_size'
> +]
>  
>  def removesuffix(s: str, suffix: str) -> str:
>    """Remove the suffix from a string
> @@ -289,6 +303,7 @@ class JsonEvent:
>            'cpu_core': 'cpu_core',
>            'cpu_atom': 'cpu_atom',
>            'ali_drw': 'ali_drw',
> +          'Core': 'core',
>        }
>        return table[unit] if unit in table else f'uncore_{unit.lower()}'
>  
> @@ -314,6 +329,9 @@ class JsonEvent:
>      if 'Errata' in jd:
>        extra_desc += '  Spec update: ' + jd['Errata']
>      self.pmu = unit_to_pmu(jd.get('Unit'))
> +    self.counter = jd.get('Counter')
> +    self.size = jd.get('Size')
> +    self.fixed_size = jd.get('FixedSize')
>      filter = jd.get('Filter')
>      self.unit = jd.get('ScaleUnit')
>      self.perpkg = jd.get('PerPkg')
> @@ -377,8 +395,16 @@ class JsonEvent:
>          s += f'\t{attr} = {value},\n'
>      return s + '}'
>  
> -  def build_c_string(self, metric: bool) -> str:
> +  def build_c_string(self, metric: bool, layout: bool = False) -> str:
>      s = ''
> +    if layout:
> +      for attr in _json_layout_attributes:
> +        x = getattr(self, attr)
> +        if attr in _json_enum_attributes:
> +          s += x if x else '0'
> +        else:
> +          s += f'{x}\\000' if x else '\\000'
> +      return s
>      for attr in _json_metric_attributes if metric else _json_event_attributes:
>        x = getattr(self, attr)
>        if metric and x and attr == 'metric_expr':
> @@ -393,10 +419,10 @@ class JsonEvent:
>          s += f'{x}\\000' if x else '\\000'
>      return s
>  
> -  def to_c_string(self, metric: bool) -> str:
> +  def to_c_string(self, metric: bool, layout: bool = False) -> str:
>      """Representation of the event as a C struct initializer."""
>  
> -    s = self.build_c_string(metric)
> +    s = self.build_c_string(metric, layout)
>      return f'{{ { _bcs.offsets[s] } }}, /* {s} */\n'
>  
>  
> @@ -413,6 +439,8 @@ def read_json_events(path: str, topic: str) -> Sequence[JsonEvent]:
>      event.topic = topic
>      if event.metric_name and '-' not in event.metric_name:
>        metrics.append((event.pmu, event.metric_name, event.metric_expr))
> +    elif event.size:
> +      print(f"Unit: {event.pmu}, Size: {event.size}, FixedSize: {event.fixed_size}")
>    updates = metric.RewriteMetricsInTermsOfOthers(metrics)
>    if updates:
>      for event in events:
> @@ -433,6 +461,8 @@ def preprocess_arch_std_files(archpath: str) -> None:
>            _arch_std_events[event.name.lower()] = event
>          if event.metric_name:
>            _arch_std_events[event.metric_name.lower()] = event
> +        if event.size:
> +          _arch_std_events[event.pmu.lower()] = event
>  
>  
>  def add_events_table_entries(item: os.DirEntry, topic: str) -> None:
> @@ -442,6 +472,8 @@ def add_events_table_entries(item: os.DirEntry, topic: str) -> None:
>        _pending_events.append(e)
>      if e.metric_name:
>        _pending_metrics.append(e)
> +    if e.size:
> +      _pending_pmu_counts.append(e)
>  
>  
>  def print_pending_events() -> None:
> @@ -555,6 +587,33 @@ const struct pmu_table_entry {_pending_metrics_tblname}[] = {{
>  """)
>    _args.output_file.write('};\n\n')
>  
> +def print_pending_pmu_counts() -> None:
> +
> +  def pmu_counts_cmp_key(j: JsonEvent) -> Tuple[bool, str, str]:
> +    def fix_none(s: Optional[str]) -> str:
> +      if s is None:
> +        return ''
> +      return s
> +
> +    return (j.desc is not None, fix_none(j.pmu), fix_none(j.size))
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
> +      f'static const struct compact_pmu_event {_pending_pmu_counts_tblname}[] = {{\n')
> +
> +  for pmu_layout in sorted(_pending_pmu_counts, key=pmu_counts_cmp_key):
> +    _args.output_file.write(pmu_layout.to_c_string(metric=False, layout=True))
> +    _pending_pmu_counts = []
> +
> +  _args.output_file.write('};\n\n')
> +
>  def get_topic(topic: str) -> str:
>    if topic.endswith('metrics.json'):
>      return 'metrics'
> @@ -595,6 +654,8 @@ def preprocess_one_file(parents: Sequence[str], item: os.DirEntry) -> None:
>      if event.metric_name:
>        _bcs.add(pmu_name, metric=True)
>        _bcs.add(event.build_c_string(metric=True), metric=True)
> +    if event.size:
> +      _bcs.add(event.build_c_string(metric=False, layout=True))
>  
>  def process_one_file(parents: Sequence[str], item: os.DirEntry) -> None:
>    """Process a JSON file during the main walk."""
> @@ -608,11 +669,14 @@ def process_one_file(parents: Sequence[str], item: os.DirEntry) -> None:
>    if item.is_dir() and is_leaf_dir(item.path):
>      print_pending_events()
>      print_pending_metrics()
> +    print_pending_pmu_counts()
>  
>      global _pending_events_tblname
>      _pending_events_tblname = file_name_to_table_name('pmu_events_', parents, item.name)
>      global _pending_metrics_tblname
>      _pending_metrics_tblname = file_name_to_table_name('pmu_metrics_', parents, item.name)
> +    global _pending_pmu_counts_tblname
> +    _pending_pmu_counts_tblname = file_name_to_table_name('pmu_layouts_', parents, item.name)
>  
>      if item.name == 'sys':
>        _sys_event_table_to_metric_table_mapping[_pending_events_tblname] = _pending_metrics_tblname
> @@ -646,6 +710,12 @@ struct pmu_metrics_table {
>          uint32_t num_pmus;
>  };
>  
> +/* Struct used to make the PMU counter layout table implementation opaque to callers. */
> +struct pmu_layouts_table {
> +        const struct compact_pmu_event *entries;
> +        size_t length;
> +};
> +
>  /*
>   * Map a CPU to its table of PMU events. The CPU is identified by the
>   * cpuid field, which is an arch-specific identifier for the CPU.
> @@ -659,6 +729,7 @@ struct pmu_events_map {
>          const char *cpuid;
>          struct pmu_events_table event_table;
>          struct pmu_metrics_table metric_table;
> +        struct pmu_layouts_table layout_table;
>  };
>  
>  /*
> @@ -703,6 +774,12 @@ const struct pmu_events_map pmu_events_map[] = {
>                metric_size = '0'
>              if event_size == '0' and metric_size == '0':
>                continue
> +            layout_tblname = file_name_to_table_name('pmu_layouts_', [], row[2].replace('/', '_'))
> +            if layout_tblname in _pmu_layouts_tables:
> +              layout_size = f'ARRAY_SIZE({layout_tblname})'
> +            else:
> +              layout_tblname = 'NULL'
> +              layout_size = '0'
>              cpuid = row[0].replace('\\', '\\\\')
>              _args.output_file.write(f"""{{
>  \t.arch = "{arch}",
> @@ -714,6 +791,10 @@ const struct pmu_events_map pmu_events_map[] = {
>  \t.metric_table = {{
>  \t\t.pmus = {metric_tblname},
>  \t\t.num_pmus = {metric_size}
> +\t}},
> +\t.layout_table = {{
> +\t\t.entries = {layout_tblname},
> +\t\t.length = {layout_size}
>  \t}}
>  }},
>  """)
> @@ -724,6 +805,7 @@ const struct pmu_events_map pmu_events_map[] = {
>  \t.cpuid = 0,
>  \t.event_table = { 0, 0 },
>  \t.metric_table = { 0, 0 },
> +\t.layout_table = { 0, 0 },
>  }
>  };
>  """)
> @@ -812,6 +894,24 @@ static void decompress_metric(int offset, struct pmu_metric *pm)
>        _args.output_file.write('\twhile (*p++);')
>    _args.output_file.write("""}
>  
> +static void decompress_layout(int offset, struct pmu_layout *pm)
> +{
> +\tconst char *p = &big_c_string[offset];
> +""")
> +  for attr in _json_layout_attributes:
> +    _args.output_file.write(f'\n\tpm->{attr} = ')
> +    if attr in _json_enum_attributes:
> +      _args.output_file.write("*p - '0';\n")
> +    else:
> +      _args.output_file.write("(*p == '\\0' ? NULL : p);\n")
> +    if attr == _json_layout_attributes[-1]:
> +      continue
> +    if attr in _json_enum_attributes:
> +      _args.output_file.write('\tp++;')
> +    else:
> +      _args.output_file.write('\twhile (*p++);')
> +  _args.output_file.write("""}
> +
>  static int pmu_events_table__for_each_event_pmu(const struct pmu_events_table *table,
>                                                  const struct pmu_table_entry *pmu,
>                                                  pmu_event_iter_fn fn,
> @@ -967,6 +1067,21 @@ int pmu_metrics_table__for_each_metric(const struct pmu_metrics_table *table,
>          return 0;
>  }
>  
> +int pmu_layouts_table__for_each_layout(const struct pmu_layouts_table *table,
> +                                     pmu_layout_iter_fn fn,
> +                                     void *data) {
> +        for (size_t i = 0; i < table->length; i++) {
> +                struct pmu_layout pm;
> +                int ret;
> +
> +                decompress_layout(table->entries[i].offset, &pm);
> +                ret = fn(&pm, data);
> +                if (ret)
> +                        return ret;
> +        }
> +        return 0;
> +}
> +
>  const struct pmu_events_table *perf_pmu__find_events_table(struct perf_pmu *pmu)
>  {
>          const struct pmu_events_table *table = NULL;
> @@ -1031,6 +1146,33 @@ const struct pmu_metrics_table *perf_pmu__find_metrics_table(struct perf_pmu *pm
>          return table;
>  }
>  
> +const struct pmu_layouts_table *perf_pmu__find_layouts_table(struct perf_pmu *pmu)
> +{
> +        const struct pmu_layouts_table *table = NULL;
> +        char *cpuid = perf_pmu__getcpuid(pmu);
> +        int i;
> +
> +        /* on some platforms which uses cpus map, cpuid can be NULL for
> +         * PMUs other than CORE PMUs.
> +         */
> +        if (!cpuid)
> +                return NULL;
> +
> +        i = 0;
> +        for (;;) {
> +                const struct pmu_events_map *map = &pmu_events_map[i++];
> +                if (!map->arch)
> +                        break;
> +
> +                if (!strcmp_cpuid_str(map->cpuid, cpuid)) {
> +                        table = &map->layout_table;
> +                        break;
> +                }
> +        }
> +        free(cpuid);
> +        return table;
> +}
> +
>  const struct pmu_events_table *find_core_events_table(const char *arch, const char *cpuid)
>  {
>          for (const struct pmu_events_map *tables = &pmu_events_map[0];
> @@ -1052,6 +1194,16 @@ const struct pmu_metrics_table *find_core_metrics_table(const char *arch, const
>          }
>          return NULL;
>  }
> +const struct pmu_layouts_table *find_core_layouts_table(const char *arch, const char *cpuid)
> +{
> +        for (const struct pmu_events_map *tables = &pmu_events_map[0];
> +             tables->arch;
> +             tables++) {
> +                if (!strcmp(tables->arch, arch) && !strcmp_cpuid_str(tables->cpuid, cpuid))
> +                        return &tables->layout_table;
> +        }
> +        return NULL;
> +}
>  
>  int pmu_for_each_core_event(pmu_event_iter_fn fn, void *data)
>  {
> @@ -1080,6 +1232,19 @@ int pmu_for_each_core_metric(pmu_metric_iter_fn fn, void *data)
>          return 0;
>  }
>  
> +int pmu_for_each_core_layout(pmu_layout_iter_fn fn, void *data)
> +{
> +        for (const struct pmu_events_map *tables = &pmu_events_map[0];
> +             tables->arch;
> +             tables++) {
> +                int ret = pmu_layouts_table__for_each_layout(&tables->layout_table, fn, data);
> +
> +                if (ret)
> +                        return ret;
> +        }
> +        return 0;
> +}
> +
>  const struct pmu_events_table *find_sys_events_table(const char *name)
>  {
>          for (const struct pmu_sys_events *tables = &pmu_sys_event_tables[0];
> @@ -1236,6 +1401,7 @@ struct pmu_table_entry {
>      ftw(arch_path, [], process_one_file)
>      print_pending_events()
>      print_pending_metrics()
> +    print_pending_pmu_counts()
>  
>    print_mapping_table(archs)
>    print_system_mapping_table()
> diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
> index f5aa96f16..65e0c5dd8 100644
> --- a/tools/perf/pmu-events/pmu-events.h
> +++ b/tools/perf/pmu-events/pmu-events.h
> @@ -45,6 +45,7 @@ struct pmu_event {
>  	const char *desc;
>  	const char *topic;
>  	const char *long_desc;
> +	const char *counter;
>  	const char *pmu;
>  	const char *unit;
>  	bool perpkg;
> @@ -67,8 +68,16 @@ struct pmu_metric {
>  	enum metric_event_groups event_grouping;
>  };
>  
> +struct pmu_layout {
> +	const char *pmu;
> +	const char *desc;
> +	int size;
> +	int fixed_size;
> +};

What's the size and fixed_size for?

Can you please add some comments?

Thanks,
Kan

> +
>  struct pmu_events_table;
>  struct pmu_metrics_table;
> +struct pmu_layouts_table;
>  
>  typedef int (*pmu_event_iter_fn)(const struct pmu_event *pe,
>  				 const struct pmu_events_table *table,
> @@ -78,15 +87,20 @@ typedef int (*pmu_metric_iter_fn)(const struct pmu_metric *pm,
>  				  const struct pmu_metrics_table *table,
>  				  void *data);
>  
> +typedef int (*pmu_layout_iter_fn)(const struct pmu_layout *pm,
> +				  void *data);
> +
>  int pmu_events_table__for_each_event(const struct pmu_events_table *table,
>  				    struct perf_pmu *pmu,
>  				    pmu_event_iter_fn fn,
>  				    void *data);
>  int pmu_events_table__find_event(const struct pmu_events_table *table,
> -                                 struct perf_pmu *pmu,
> -                                 const char *name,
> -                                 pmu_event_iter_fn fn,
> -				 void *data);
> +				struct perf_pmu *pmu,
> +				const char *name,
> +				pmu_event_iter_fn fn,
> +				void *data);
> +int pmu_layouts_table__for_each_layout(const struct pmu_layouts_table *table, pmu_layout_iter_fn fn,
> +				     void *data);
>  size_t pmu_events_table__num_events(const struct pmu_events_table *table,
>  				    struct perf_pmu *pmu);
>  
> @@ -95,10 +109,13 @@ int pmu_metrics_table__for_each_metric(const struct pmu_metrics_table *table, pm
>  
>  const struct pmu_events_table *perf_pmu__find_events_table(struct perf_pmu *pmu);
>  const struct pmu_metrics_table *perf_pmu__find_metrics_table(struct perf_pmu *pmu);
> +const struct pmu_layouts_table *perf_pmu__find_layouts_table(struct perf_pmu *pmu);
>  const struct pmu_events_table *find_core_events_table(const char *arch, const char *cpuid);
>  const struct pmu_metrics_table *find_core_metrics_table(const char *arch, const char *cpuid);
> +const struct pmu_layouts_table *find_core_layouts_table(const char *arch, const char *cpuid);
>  int pmu_for_each_core_event(pmu_event_iter_fn fn, void *data);
>  int pmu_for_each_core_metric(pmu_metric_iter_fn fn, void *data);
> +int pmu_for_each_core_layout(pmu_layout_iter_fn fn, void *data);
>  
>  const struct pmu_events_table *find_sys_events_table(const char *name);
>  const struct pmu_metrics_table *find_sys_metrics_table(const char *name);
