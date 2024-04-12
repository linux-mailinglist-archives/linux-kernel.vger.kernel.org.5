Return-Path: <linux-kernel+bounces-143357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6348A3791
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 23:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 342DE2867BD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 21:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D10152510;
	Fri, 12 Apr 2024 21:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kcmUgQsM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBC514F9EE;
	Fri, 12 Apr 2024 21:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712956094; cv=none; b=Jsa0azSx3nPSIS8mToowpT+n+aDMOe1ZVAfVjC2LsvZijY7o2dXjrh8XLAf9j2ca4ikXrZRsHHqwezqkz8EHNFEVPPT3tM6nFFSZvkZgES17t6m92i/UYvEckutdXoQew3jB6vDeStuqxrhIpJuN9Vs93yrwO96PmYFQmsuLhbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712956094; c=relaxed/simple;
	bh=RSQACh79WPB7eGVa8CzwZnGcQp0J/Vc8zTGf+lXaQ3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fLVjc6Ry6Tcu15GVGVPPdgr4BCOfOZcMk3aoohh7Hm51ARwasc2BF9ddiWmi74IXZbiX41a9A9yOTtc8SbJbMduLGWeZvUfq5DWxyDXsKeBofTPu+T0vd7kI5y7wTwYQ+BwFNZSJsgjg3sdNjLWpBxNYSvLa2YlrfT+VQ0wZ8jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kcmUgQsM; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712956092; x=1744492092;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RSQACh79WPB7eGVa8CzwZnGcQp0J/Vc8zTGf+lXaQ3o=;
  b=kcmUgQsMmwS8VbPKPbjfZytKVcdo/w6ueKBiwVgJD+qOaIXPQnfkWNM2
   LG2KoNSKeZoRYhewQ5aQzZS09yYcGWcfQbhkAPjn7TLzum19bl5pHGgjc
   aO153K8PnmXJkcT77Nv38JDPU4rInbab+SHG40zJ/mmpnpU39w2fTXAYT
   7t/4r39JfsIcNO8UvFgy+Vt6nDim3jwS6PVZyp7UjSAbynnSQs4TZT4By
   LlvATyq0ytJwBbQms5Co/KPyCOw4plXo0zvhXCreZuG9Agx5zcrXdFvWK
   wn3yJo1FNvZplHD8B6MxVrF35hCzDYf1Q8Tu+fDoM+crZ8YskeCEC/K2I
   g==;
X-CSE-ConnectionGUID: 42CKc83jQvK1zm6cHO8xvA==
X-CSE-MsgGUID: AcdJxMAVTsS2z25f4vBhXA==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="19575441"
X-IronPort-AV: E=Sophos;i="6.07,197,1708416000"; 
   d="scan'208";a="19575441"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 14:08:10 -0700
X-CSE-ConnectionGUID: rS1OwYZ3SbGpqae4OkNUAg==
X-CSE-MsgGUID: WitCjcZLRXm3EfeB75cOqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,197,1708416000"; 
   d="scan'208";a="21772078"
Received: from b49691a74b80.jf.intel.com ([10.165.54.183])
  by orviesa006.jf.intel.com with ESMTP; 12 Apr 2024 14:08:09 -0700
From: weilin.wang@intel.com
To: weilin.wang@intel.com,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Perry Taylor <perry.taylor@intel.com>,
	Samantha Alt <samantha.alt@intel.com>,
	Caleb Biggers <caleb.biggers@intel.com>
Subject: [RFC PATCH v5 03/16] perf pmu-events: Add functions in jevent.py to parse counter and event info for hardware aware grouping
Date: Fri, 12 Apr 2024 14:07:43 -0700
Message-ID: <20240412210756.309828-4-weilin.wang@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240412210756.309828-1-weilin.wang@intel.com>
References: <20240412210756.309828-1-weilin.wang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weilin Wang <weilin.wang@intel.com>

These functions are added to parse event counter restrictions and counter
availability info from json files so that the metric grouping method could
do grouping based on the counter restriction of events and the counters
that are available on the system.

Signed-off-by: Weilin Wang <weilin.wang@intel.com>
---
 tools/perf/pmu-events/jevents.py   | 204 +++++++++++++++++++++++++++--
 tools/perf/pmu-events/pmu-events.h |  32 ++++-
 2 files changed, 224 insertions(+), 12 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index e42efc16723e..7cfd86d77fea 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -23,6 +23,8 @@ _metric_tables = []
 _sys_metric_tables = []
 # Mapping between sys event table names and sys metric table names.
 _sys_event_table_to_metric_table_mapping = {}
+# List of regular PMU counter layout tables.
+_pmu_layouts_tables = []
 # Map from an event name to an architecture standard
 # JsonEvent. Architecture standard events are in json files in the top
 # f'{_args.starting_dir}/{_args.arch}' directory.
@@ -31,6 +33,10 @@ _arch_std_events = {}
 _pending_events = []
 # Name of events table to be written out
 _pending_events_tblname = None
+# PMU counter layout to write out when the layout table is closed
+_pending_pmu_counts = []
+# Name of PMU counter layout table to be written out
+_pending_pmu_counts_tblname = None
 # Metrics to write out when the table is closed
 _pending_metrics = []
 # Name of metrics table to be written out
@@ -51,6 +57,11 @@ _json_event_attributes = [
     'long_desc'
 ]
 
+# Attributes that are in pmu_unit_layout.
+_json_layout_attributes = [
+    'pmu', 'desc'
+]
+
 # Attributes that are in pmu_metric rather than pmu_event.
 _json_metric_attributes = [
     'metric_name', 'metric_group', 'metric_expr', 'metric_threshold',
@@ -265,7 +276,7 @@ class JsonEvent:
 
     def unit_to_pmu(unit: str) -> Optional[str]:
       """Convert a JSON Unit to Linux PMU name."""
-      if not unit:
+      if not unit or unit == "core":
         return 'default_core'
       # Comment brought over from jevents.c:
       # it's not realistic to keep adding these, we need something more scalable ...
@@ -334,6 +345,19 @@ class JsonEvent:
     if 'Errata' in jd:
       extra_desc += '  Spec update: ' + jd['Errata']
     self.pmu = unit_to_pmu(jd.get('Unit'))
+    # The list of counter(s) the event could be collected with
+    class Counter:
+      gp = str()
+      fixed = str()
+    self.counters = {'list': str(), 'num': Counter()}
+    self.counters['list'] = jd.get('Counter')
+    # Number of generic counter
+    self.counters['num'].gp = jd.get('CountersNumGeneric')
+    # Number of fixed counter
+    self.counters['num'].fixed = jd.get('CountersNumFixed')
+    # If the event uses an MSR, other event uses the same MSR could not be
+    # schedule to collect at the same time.
+    self.msr = jd.get('MSRIndex')
     filter = jd.get('Filter')
     self.unit = jd.get('ScaleUnit')
     self.perpkg = jd.get('PerPkg')
@@ -409,8 +433,20 @@ class JsonEvent:
         s += f'\t{attr} = {value},\n'
     return s + '}'
 
-  def build_c_string(self, metric: bool) -> str:
+  def build_c_string(self, metric: bool, layout: bool) -> str:
     s = ''
+    if layout:
+      for attr in _json_layout_attributes:
+        x = getattr(self, attr)
+        if attr in _json_enum_attributes:
+          s += x if x else '0'
+        else:
+          s += f'{x}\\000' if x else '\\000'
+      x = self.counters['num'].gp
+      s += x if x else '0'
+      x = self.counters['num'].fixed
+      s += x if x else '0'
+      return s
     for attr in _json_metric_attributes if metric else _json_event_attributes:
       x = getattr(self, attr)
       if metric and x and attr == 'metric_expr':
@@ -423,12 +459,15 @@ class JsonEvent:
         s += x if x else '0'
       else:
         s += f'{x}\\000' if x else '\\000'
+    if not metric:
+      x = self.counters['list']
+      s += f'{x}\\000' if x else '\\000'
     return s
 
-  def to_c_string(self, metric: bool) -> str:
+  def to_c_string(self, metric: bool, layout: bool) -> str:
     """Representation of the event as a C struct initializer."""
 
-    s = self.build_c_string(metric)
+    s = self.build_c_string(metric, layout)
     return f'{{ { _bcs.offsets[s] } }}, /* {s} */\n'
 
 
@@ -465,6 +504,8 @@ def preprocess_arch_std_files(archpath: str) -> None:
           _arch_std_events[event.name.lower()] = event
         if event.metric_name:
           _arch_std_events[event.metric_name.lower()] = event
+        if event.counters['num'].gp:
+          _arch_std_events[event.pmu.lower()] = event
 
 
 def add_events_table_entries(item: os.DirEntry, topic: str) -> None:
@@ -474,6 +515,8 @@ def add_events_table_entries(item: os.DirEntry, topic: str) -> None:
       _pending_events.append(e)
     if e.metric_name:
       _pending_metrics.append(e)
+    if e.counters['num'].gp:
+      _pending_pmu_counts.append(e)
 
 
 def print_pending_events() -> None:
@@ -514,7 +557,7 @@ def print_pending_events() -> None:
       last_pmu = event.pmu
       pmus.add((event.pmu, pmu_name))
 
-    _args.output_file.write(event.to_c_string(metric=False))
+    _args.output_file.write(event.to_c_string(metric=False, layout=False))
   _pending_events = []
 
   _args.output_file.write(f"""
@@ -569,7 +612,7 @@ def print_pending_metrics() -> None:
       last_pmu = metric.pmu
       pmus.add((metric.pmu, pmu_name))
 
-    _args.output_file.write(metric.to_c_string(metric=True))
+    _args.output_file.write(metric.to_c_string(metric=True, layout=False))
   _pending_metrics = []
 
   _args.output_file.write(f"""
@@ -587,6 +630,35 @@ const struct pmu_table_entry {_pending_metrics_tblname}[] = {{
 """)
   _args.output_file.write('};\n\n')
 
+def print_pending_pmu_counter_layout_table() -> None:
+  '''Print counter layout data from counter.json file to counter layout table in
+    c-string'''
+
+  def pmu_counts_cmp_key(j: JsonEvent) -> Tuple[bool, str, str]:
+    def fix_none(s: Optional[str]) -> str:
+      if s is None:
+        return ''
+      return s
+
+    return (j.desc is not None, fix_none(j.pmu))
+
+  global _pending_pmu_counts
+  if not _pending_pmu_counts:
+    return
+
+  global _pending_pmu_counts_tblname
+  global pmu_layouts_tables
+  _pmu_layouts_tables.append(_pending_pmu_counts_tblname)
+
+  _args.output_file.write(
+      f'static const struct compact_pmu_event {_pending_pmu_counts_tblname}[] = {{\n')
+
+  for pmu_layout in sorted(_pending_pmu_counts, key=pmu_counts_cmp_key):
+    _args.output_file.write(pmu_layout.to_c_string(metric=False, layout=True))
+    _pending_pmu_counts = []
+
+  _args.output_file.write('};\n\n')
+
 def get_topic(topic: str) -> str:
   if topic.endswith('metrics.json'):
     return 'metrics'
@@ -623,10 +695,12 @@ def preprocess_one_file(parents: Sequence[str], item: os.DirEntry) -> None:
     pmu_name = f"{event.pmu}\\000"
     if event.name:
       _bcs.add(pmu_name, metric=False)
-      _bcs.add(event.build_c_string(metric=False), metric=False)
+      _bcs.add(event.build_c_string(metric=False, layout=False), metric=False)
     if event.metric_name:
       _bcs.add(pmu_name, metric=True)
-      _bcs.add(event.build_c_string(metric=True), metric=True)
+      _bcs.add(event.build_c_string(metric=True, layout=False), metric=True)
+    if event.counters['num'].gp:
+      _bcs.add(event.build_c_string(metric=False, layout=True), metric=False)
 
 def process_one_file(parents: Sequence[str], item: os.DirEntry) -> None:
   """Process a JSON file during the main walk."""
@@ -640,11 +714,14 @@ def process_one_file(parents: Sequence[str], item: os.DirEntry) -> None:
   if item.is_dir() and is_leaf_dir(item.path):
     print_pending_events()
     print_pending_metrics()
+    print_pending_pmu_counter_layout_table()
 
     global _pending_events_tblname
     _pending_events_tblname = file_name_to_table_name('pmu_events_', parents, item.name)
     global _pending_metrics_tblname
     _pending_metrics_tblname = file_name_to_table_name('pmu_metrics_', parents, item.name)
+    global _pending_pmu_counts_tblname
+    _pending_pmu_counts_tblname = file_name_to_table_name('pmu_layouts_', parents, item.name)
 
     if item.name == 'sys':
       _sys_event_table_to_metric_table_mapping[_pending_events_tblname] = _pending_metrics_tblname
@@ -678,6 +755,12 @@ struct pmu_metrics_table {
         uint32_t num_pmus;
 };
 
+/* Struct used to make the PMU counter layout table implementation opaque to callers. */
+struct pmu_layouts_table {
+        const struct compact_pmu_event *entries;
+        size_t length;
+};
+
 /*
  * Map a CPU to its table of PMU events. The CPU is identified by the
  * cpuid field, which is an arch-specific identifier for the CPU.
@@ -691,6 +774,7 @@ struct pmu_events_map {
         const char *cpuid;
         struct pmu_events_table event_table;
         struct pmu_metrics_table metric_table;
+        struct pmu_layouts_table layout_table;
 };
 
 /*
@@ -735,6 +819,12 @@ const struct pmu_events_map pmu_events_map[] = {
               metric_size = '0'
             if event_size == '0' and metric_size == '0':
               continue
+            layout_tblname = file_name_to_table_name('pmu_layouts_', [], row[2].replace('/', '_'))
+            if layout_tblname in _pmu_layouts_tables:
+              layout_size = f'ARRAY_SIZE({layout_tblname})'
+            else:
+              layout_tblname = 'NULL'
+              layout_size = '0'
             cpuid = row[0].replace('\\', '\\\\')
             _args.output_file.write(f"""{{
 \t.arch = "{arch}",
@@ -746,6 +836,10 @@ const struct pmu_events_map pmu_events_map[] = {
 \t.metric_table = {{
 \t\t.pmus = {metric_tblname},
 \t\t.num_pmus = {metric_size}
+\t}},
+\t.layout_table = {{
+\t\t.entries = {layout_tblname},
+\t\t.length = {layout_size}
 \t}}
 }},
 """)
@@ -756,6 +850,7 @@ const struct pmu_events_map pmu_events_map[] = {
 \t.cpuid = 0,
 \t.event_table = { 0, 0 },
 \t.metric_table = { 0, 0 },
+\t.layout_table = { 0, 0 },
 }
 };
 """)
@@ -824,6 +919,9 @@ static void decompress_event(int offset, struct pmu_event *pe)
       _args.output_file.write('\tp++;')
     else:
       _args.output_file.write('\twhile (*p++);')
+  _args.output_file.write('\twhile (*p++);')
+  _args.output_file.write(f'\n\tpe->counters_list = ')
+  _args.output_file.write("(*p == '\\0' ? NULL : p);\n")
   _args.output_file.write("""}
 
 static void decompress_metric(int offset, struct pmu_metric *pm)
@@ -844,6 +942,30 @@ static void decompress_metric(int offset, struct pmu_metric *pm)
       _args.output_file.write('\twhile (*p++);')
   _args.output_file.write("""}
 
+static void decompress_layout(int offset, struct pmu_layout *pm)
+{
+\tconst char *p = &big_c_string[offset];
+""")
+  for attr in _json_layout_attributes:
+    _args.output_file.write(f'\n\tpm->{attr} = ')
+    if attr in _json_enum_attributes:
+      _args.output_file.write("*p - '0';\n")
+    else:
+      _args.output_file.write("(*p == '\\0' ? NULL : p);\n")
+    if attr == _json_layout_attributes[-1]:
+      continue
+    if attr in _json_enum_attributes:
+      _args.output_file.write('\tp++;')
+    else:
+      _args.output_file.write('\twhile (*p++);')
+  _args.output_file.write('\tp++;')
+  _args.output_file.write(f'\n\tpm->counters_num_gp = ')
+  _args.output_file.write("*p - '0';\n")
+  _args.output_file.write('\tp++;')
+  _args.output_file.write(f'\n\tpm->counters_num_fixed = ')
+  _args.output_file.write("*p - '0';\n")
+  _args.output_file.write("""}
+
 static int pmu_events_table__for_each_event_pmu(const struct pmu_events_table *table,
                                                 const struct pmu_table_entry *pmu,
                                                 pmu_event_iter_fn fn,
@@ -999,6 +1121,21 @@ int pmu_metrics_table__for_each_metric(const struct pmu_metrics_table *table,
         return 0;
 }
 
+int pmu_layouts_table__for_each_layout(const struct pmu_layouts_table *table,
+                                     pmu_layout_iter_fn fn,
+                                     void *data) {
+        for (size_t i = 0; i < table->length; i++) {
+                struct pmu_layout pm;
+                int ret;
+
+                decompress_layout(table->entries[i].offset, &pm);
+                ret = fn(&pm, data);
+                if (ret)
+                        return ret;
+        }
+        return 0;
+}
+
 static const struct pmu_events_map *map_for_pmu(struct perf_pmu *pmu)
 {
         static struct {
@@ -1094,6 +1231,33 @@ const struct pmu_metrics_table *perf_pmu__find_metrics_table(struct perf_pmu *pm
         return NULL;
 }
 
+const struct pmu_layouts_table *perf_pmu__find_layouts_table(struct perf_pmu *pmu)
+{
+        const struct pmu_layouts_table *table = NULL;
+        char *cpuid = perf_pmu__getcpuid(pmu);
+        int i;
+
+        /* on some platforms which uses cpus map, cpuid can be NULL for
+         * PMUs other than CORE PMUs.
+         */
+        if (!cpuid)
+                return NULL;
+
+        i = 0;
+        for (;;) {
+                const struct pmu_events_map *map = &pmu_events_map[i++];
+                if (!map->arch)
+                        break;
+
+                if (!strcmp_cpuid_str(map->cpuid, cpuid)) {
+                        table = &map->layout_table;
+                        break;
+                }
+        }
+        free(cpuid);
+        return table;
+}
+
 const struct pmu_events_table *find_core_events_table(const char *arch, const char *cpuid)
 {
         for (const struct pmu_events_map *tables = &pmu_events_map[0];
@@ -1115,6 +1279,16 @@ const struct pmu_metrics_table *find_core_metrics_table(const char *arch, const
         }
         return NULL;
 }
+const struct pmu_layouts_table *find_core_layouts_table(const char *arch, const char *cpuid)
+{
+        for (const struct pmu_events_map *tables = &pmu_events_map[0];
+             tables->arch;
+             tables++) {
+                if (!strcmp(tables->arch, arch) && !strcmp_cpuid_str(tables->cpuid, cpuid))
+                        return &tables->layout_table;
+        }
+        return NULL;
+}
 
 int pmu_for_each_core_event(pmu_event_iter_fn fn, void *data)
 {
@@ -1143,6 +1317,19 @@ int pmu_for_each_core_metric(pmu_metric_iter_fn fn, void *data)
         return 0;
 }
 
+int pmu_for_each_core_layout(pmu_layout_iter_fn fn, void *data)
+{
+        for (const struct pmu_events_map *tables = &pmu_events_map[0];
+             tables->arch;
+             tables++) {
+                int ret = pmu_layouts_table__for_each_layout(&tables->layout_table, fn, data);
+
+                if (ret)
+                        return ret;
+        }
+        return 0;
+}
+
 const struct pmu_events_table *find_sys_events_table(const char *name)
 {
         for (const struct pmu_sys_events *tables = &pmu_sys_event_tables[0];
@@ -1299,6 +1486,7 @@ struct pmu_table_entry {
     ftw(arch_path, [], process_one_file)
     print_pending_events()
     print_pending_metrics()
+    print_pending_pmu_counter_layout_table()
 
   print_mapping_table(archs)
   print_system_mapping_table()
diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
index f5aa96f1685c..5b42a18693cf 100644
--- a/tools/perf/pmu-events/pmu-events.h
+++ b/tools/perf/pmu-events/pmu-events.h
@@ -45,6 +45,11 @@ struct pmu_event {
 	const char *desc;
 	const char *topic;
 	const char *long_desc;
+	/**
+	 * The list of counter(s) the event could be collected on.
+	 * eg., "0,1,2,3,4,5,6,7".
+	 */
+	const char *counters_list;
 	const char *pmu;
 	const char *unit;
 	bool perpkg;
@@ -67,8 +72,18 @@ struct pmu_metric {
 	enum metric_event_groups event_grouping;
 };
 
+struct pmu_layout {
+	const char *pmu;
+	const char *desc;
+	/** Total number of generic counters*/
+	int counters_num_gp;
+	/** Total number of fixed counters. Set to zero if no fixed counter on the unit.*/
+	int counters_num_fixed;
+};
+
 struct pmu_events_table;
 struct pmu_metrics_table;
+struct pmu_layouts_table;
 
 typedef int (*pmu_event_iter_fn)(const struct pmu_event *pe,
 				 const struct pmu_events_table *table,
@@ -78,15 +93,21 @@ typedef int (*pmu_metric_iter_fn)(const struct pmu_metric *pm,
 				  const struct pmu_metrics_table *table,
 				  void *data);
 
+typedef int (*pmu_layout_iter_fn)(const struct pmu_layout *pm,
+				  void *data);
+
 int pmu_events_table__for_each_event(const struct pmu_events_table *table,
 				    struct perf_pmu *pmu,
 				    pmu_event_iter_fn fn,
 				    void *data);
 int pmu_events_table__find_event(const struct pmu_events_table *table,
-                                 struct perf_pmu *pmu,
-                                 const char *name,
-                                 pmu_event_iter_fn fn,
-				 void *data);
+				struct perf_pmu *pmu,
+				const char *name,
+				pmu_event_iter_fn fn,
+				void *data);
+int pmu_layouts_table__for_each_layout(const struct pmu_layouts_table *table,
+					pmu_layout_iter_fn fn,
+					void *data);
 size_t pmu_events_table__num_events(const struct pmu_events_table *table,
 				    struct perf_pmu *pmu);
 
@@ -95,10 +116,13 @@ int pmu_metrics_table__for_each_metric(const struct pmu_metrics_table *table, pm
 
 const struct pmu_events_table *perf_pmu__find_events_table(struct perf_pmu *pmu);
 const struct pmu_metrics_table *perf_pmu__find_metrics_table(struct perf_pmu *pmu);
+const struct pmu_layouts_table *perf_pmu__find_layouts_table(struct perf_pmu *pmu);
 const struct pmu_events_table *find_core_events_table(const char *arch, const char *cpuid);
 const struct pmu_metrics_table *find_core_metrics_table(const char *arch, const char *cpuid);
+const struct pmu_layouts_table *find_core_layouts_table(const char *arch, const char *cpuid);
 int pmu_for_each_core_event(pmu_event_iter_fn fn, void *data);
 int pmu_for_each_core_metric(pmu_metric_iter_fn fn, void *data);
+int pmu_for_each_core_layout(pmu_layout_iter_fn fn, void *data);
 
 const struct pmu_events_table *find_sys_events_table(const char *name);
 const struct pmu_metrics_table *find_sys_metrics_table(const char *name);
-- 
2.42.0


