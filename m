Return-Path: <linux-kernel+bounces-102810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0D487B778
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 06:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39DFE282263
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 05:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11493182A3;
	Thu, 14 Mar 2024 05:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1vN7Aj8E"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF41917C96
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 05:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710395503; cv=none; b=nQ+giL51rimk6o+/nSNcse4tEjJ8Uo5T6zHT8r6iDO/YoNzNdexA8Zq69PDHb/KOEl/sW1WVKBSRDukSb5Snem/46NxHJcla2bY3Y/SSbk9sZdAiDE5NGizrIv1HoGqZL47IgPrxpYfEu5XzzzvuLU2gqz3woVydpF1DwYiSc2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710395503; c=relaxed/simple;
	bh=/Cph8E3z3J/cdOk1NiaEQQjTF6m8QI5lIuIA5AhbRQQ=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=LWKp9zLbUOqSTOdX8rnN4jeG4S2q91ToSbVnjyrSbcuoLkAWS9S4WTlxfr64e9FdLnA8D0eTMAFfZHS38mQmSFGXBhGmGxhSBLmjy17GvxE2rMLZ1HmpsVlT6+qUcZ1+OUxJJZKQq4h9Afsy7MOx0vsMEoXDyflJlHLi1omqhkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1vN7Aj8E; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60a0815e3f9so10204327b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 22:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710395501; x=1711000301; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vAFc0IFKb4+x3EKZ+3bUKGnX340NAknB9DybGiGSjMk=;
        b=1vN7Aj8EI/3enjYZvAJZhtEFiYjcbkb7ctTazjSMcDupX162Vsd6FGSvTk6u0VwWat
         8rxTet7ysll7nvrlNcjaV2mD3ph7qsaOtPkaEr9Ymj/4fae3fv49bLwR2+9hp1c1RfEO
         NQSGIkAe0ldDYwHYxhqRDJJMzWUxXOkX8E80ZD0hsC/y+wsoeX4qpZyvgqVUqDXkHdrp
         NXYXr1UWO7uSF5N1su8d24AjzNpIXfAj3bf+0Gmq9u8eN7f9TQm5tu+RdT/TQAWfSo+F
         0MsrNkuYkPLNNTWes+z+MbSXaiHreryizCPeGFuzkyArJTxQSyFLyd0T91YkJw2mNIU1
         WYTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710395501; x=1711000301;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vAFc0IFKb4+x3EKZ+3bUKGnX340NAknB9DybGiGSjMk=;
        b=olV/lbgcMmRbZwBhhW0jJu+rq/cj8QO4ODJAIwp0QYvTLS7qLOFkt80sA03ciK0Qu4
         7O8fOg7j6L3UL3KmCd330isX7UHL22gfTIlZRoPj+G9Kr8JiZONGSMPzzVXlknoY//av
         R4AMeL2t0vEtteeok5AtP03Vd6PqBI2pk1nIJRjH5MqeIbeJrBNUokAOltPYxA02ST5r
         2MK+nEGhp6LdoTDUeJ5raLK4QZ2yA0hDTXqZsYqpil1/FMvg9EtP424Go+v4Zym8JSNd
         YByiI38pR+0/PAUaYNNrbkg5M+pR4BcO2nqHUplaOY4yNXAt4DsX1oLzql2sDvlmrFE7
         uLtw==
X-Forwarded-Encrypted: i=1; AJvYcCW3cUElGoIcrpHcY+ogBaNpH7PaB2vL3gUynBI1704Z02IXIt2/Uwb1Y1ha3SyJfcNpcpm6KgbiJn/0ApABN+wQlRixWho1Giu25msb
X-Gm-Message-State: AOJu0Yy7bGYa/nOYaqnbK48YUOTieUS+RPWy7gzgV/LA1ZGSOZJckHP4
	ZhNLlRuqBa5Jl3xpXE2s9eTQt06h8xw+KAuTQveTYqyHg4E5sNyc6D+/TaaTyzHwnnHOgc6EsG6
	Tlgypvw==
X-Google-Smtp-Source: AGHT+IGIiBwDYY+8rdkzzfcp2/1WS7POaDVFLe8ewB8yZ03OVoV+sARl0McwBl7JE0u7SSGwhYVAN9BUGfcU
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:449f:3bde:a4cd:806a])
 (user=irogers job=sendgmr) by 2002:a0d:ca57:0:b0:60a:253d:a54c with SMTP id
 m84-20020a0dca57000000b0060a253da54cmr152472ywd.3.1710395500973; Wed, 13 Mar
 2024 22:51:40 -0700 (PDT)
Date: Wed, 13 Mar 2024 22:50:50 -0700
In-Reply-To: <20240314055051.1960527-1-irogers@google.com>
Message-Id: <20240314055051.1960527-12-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240314055051.1960527-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v3 11/12] perf jevents: Build support for generating metrics
 from python
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	John Garry <john.g.garry@oracle.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Sandipan Das <sandipan.das@amd.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Perry Taylor <perry.taylor@intel.com>, 
	Samantha Alt <samantha.alt@intel.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Edward Baker <edward.baker@intel.com>, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

Generate extra-metrics.json and extra-metricgroups.json from python
architecture specific scripts. The metrics themselves will be added in
later patches.

If a build takes place in tools/perf/ then extra-metrics.json and
extra-metricgroups.json are generated in that directory and so added
to .gitignore. If there is an OUTPUT directory then the
tools/perf/pmu-events/arch files are copied to it so the generated
extra-metrics.json and extra-metricgroups.json can be added/generated
there.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/.gitignore                  |  2 +
 tools/perf/Makefile.perf               | 17 ++++++--
 tools/perf/pmu-events/Build            | 60 ++++++++++++++++++++++++--
 tools/perf/pmu-events/amd_metrics.py   | 38 ++++++++++++++++
 tools/perf/pmu-events/arm64_metrics.py | 39 +++++++++++++++++
 tools/perf/pmu-events/intel_metrics.py | 38 ++++++++++++++++
 6 files changed, 187 insertions(+), 7 deletions(-)
 create mode 100755 tools/perf/pmu-events/amd_metrics.py
 create mode 100755 tools/perf/pmu-events/arm64_metrics.py
 create mode 100755 tools/perf/pmu-events/intel_metrics.py

diff --git a/tools/perf/.gitignore b/tools/perf/.gitignore
index f5b81d439387..c9a8da5bfc56 100644
--- a/tools/perf/.gitignore
+++ b/tools/perf/.gitignore
@@ -39,6 +39,8 @@ trace/beauty/generated/
 pmu-events/pmu-events.c
 pmu-events/jevents
 pmu-events/metric_test.log
+pmu-events/arch/**/extra-metrics.json
+pmu-events/arch/**/extra-metricgroups.json
 tests/shell/*.shellcheck_log
 tests/shell/coresight/*.shellcheck_log
 tests/shell/lib/*.shellcheck_log
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index f8774a9b1377..e8e70d02ee92 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -1169,7 +1169,20 @@ endif # CONFIG_PERF_BPF_SKEL
 bpf-skel-clean:
 	$(call QUIET_CLEAN, bpf-skel) $(RM) -r $(SKEL_TMP_OUT) $(SKELETONS)
 
-clean:: $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBSYMBOL)-clean $(LIBPERF)-clean arm64-sysreg-defs-clean fixdep-clean python-clean bpf-skel-clean tests-coresight-targets-clean
+pmu-events-clean:
+ifeq ($(OUTPUT),)
+	$(call QUIET_CLEAN, pmu-events) $(RM) \
+		pmu-events/pmu-events.c \
+		pmu-events/metric_test.log
+	$(Q)find pmu-events/arch -name 'extra-metrics.json' -delete -o \
+		-name 'extra-metricgroups.json' -delete
+else
+	$(call QUIET_CLEAN, pmu-events) $(RM) -r $(OUTPUT)pmu-events/arch \
+		$(OUTPUT)pmu-events/pmu-events.c \
+		$(OUTPUT)pmu-events/metric_test.log
+endif
+
+clean:: $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBSYMBOL)-clean $(LIBPERF)-clean arm64-sysreg-defs-clean fixdep-clean python-clean bpf-skel-clean tests-coresight-targets-clean pmu-events-clean
 	$(call QUIET_CLEAN, core-objs)  $(RM) $(LIBPERF_A) $(OUTPUT)perf-archive $(OUTPUT)perf-iostat $(LANG_BINDINGS)
 	$(Q)find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '\.*.cmd' -delete -o -name '\.*.d' -delete -o -name '*.shellcheck_log' -delete
 	$(Q)$(RM) $(OUTPUT).config-detected
@@ -1177,8 +1190,6 @@ clean:: $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBSYMBOL)-clean $(
 	$(call QUIET_CLEAN, core-gen)   $(RM)  *.spec *.pyc *.pyo */*.pyc */*.pyo $(OUTPUT)common-cmds.h TAGS tags cscope* $(OUTPUT)PERF-VERSION-FILE $(OUTPUT)FEATURE-DUMP $(OUTPUT)util/*-bison* $(OUTPUT)util/*-flex* \
 		$(OUTPUT)util/intel-pt-decoder/inat-tables.c \
 		$(OUTPUT)tests/llvm-src-{base,kbuild,prologue,relocation}.c \
-		$(OUTPUT)pmu-events/pmu-events.c \
-		$(OUTPUT)pmu-events/metric_test.log \
 		$(OUTPUT)$(fadvise_advice_array) \
 		$(OUTPUT)$(fsconfig_arrays) \
 		$(OUTPUT)$(fsmount_arrays) \
diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
index 1d18bb89402e..e2db33577707 100644
--- a/tools/perf/pmu-events/Build
+++ b/tools/perf/pmu-events/Build
@@ -1,7 +1,6 @@
 pmu-events-y	+= pmu-events.o
 JDIR		=  pmu-events/arch/$(SRCARCH)
-JSON		=  $(shell [ -d $(JDIR) ] &&				\
-			find $(JDIR) -name '*.json' -o -name 'mapfile.csv')
+JSON		=  $(shell find pmu-events/arch -name *.json -o -name *.csv)
 JDIR_TEST	=  pmu-events/arch/test
 JSON_TEST	=  $(shell [ -d $(JDIR_TEST) ] &&			\
 			find $(JDIR_TEST) -name '*.json')
@@ -27,13 +26,66 @@ $(PMU_EVENTS_C): $(EMPTY_PMU_EVENTS_C)
 	$(call rule_mkdir)
 	$(Q)$(call echo-cmd,gen)cp $< $@
 else
+# Extract the model from a extra-metrics.json or extra-metricgroups.json path
+model_name = $(shell echo $(1)|sed -e 's@.\+/\(.*\)/extra-metric.*\.json@\1@')
+vendor_name = $(shell echo $(1)|sed -e 's@.\+/\(.*\)/[^/]*/extra-metric.*\.json@\1@')
+
+# Copy checked-in json for generation.
+$(OUTPUT)pmu-events/arch/%: pmu-events/arch/%
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,gen)cp $< $@
+
+# Generate AMD Json
+ZENS = $(shell ls -d pmu-events/arch/x86/amdzen*)
+ZEN_METRICS = $(foreach x,$(ZENS),$(OUTPUT)$(x)/extra-metrics.json)
+ZEN_METRICGROUPS = $(foreach x,$(ZENS),$(OUTPUT)$(x)/extra-metricgroups.json)
+
+$(ZEN_METRICS): pmu-events/amd_metrics.py
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,gen)$(PYTHON) $< $(call model_name,$@) arch > $@
+
+$(ZEN_METRICGROUPS): pmu-events/amd_metrics.py
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,gen)$(PYTHON) $< -metricgroups $(call model_name,$@) arch > $@
+
+# Generate ARM Json
+ARMS = $(shell ls -d pmu-events/arch/arm64/arm/*)
+ARM_METRICS = $(foreach x,$(ARMS),$(OUTPUT)$(x)/extra-metrics.json)
+ARM_METRICGROUPS = $(foreach x,$(ARMS),$(OUTPUT)$(x)/extra-metricgroups.json)
+
+$(ARM_METRICS): pmu-events/arm64_metrics.py
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,gen)$(PYTHON) $< $(call vendor_name,$@) $(call model_name,$@) arch > $@
+
+$(ARM_METRICGROUPS): pmu-events/arm64_metrics.py
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,gen)$(PYTHON) $< -metricgroups $(call vendor_name,$@) $(call model_name,$@) arch > $@
+
+# Generate Intel Json
+INTELS = $(shell ls -d pmu-events/arch/x86/*|grep -v amdzen|grep -v mapfile.csv)
+INTEL_METRICS = $(foreach x,$(INTELS),$(OUTPUT)$(x)/extra-metrics.json)
+INTEL_METRICGROUPS = $(foreach x,$(INTELS),$(OUTPUT)$(x)/extra-metricgroups.json)
+
+$(INTEL_METRICS): pmu-events/intel_metrics.py
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,gen)$(PYTHON) $< $(call model_name,$@) arch > $@
+
+$(INTEL_METRICGROUPS): pmu-events/intel_metrics.py
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,gen)$(PYTHON) $< -metricgroups $(call model_name,$@) arch > $@
+
+GEN_JSON = $(patsubst %,$(OUTPUT)%,$(JSON)) \
+            $(ZEN_METRICS) $(ZEN_METRICGROUPS) \
+            $(ARM_METRICS) $(ARM_METRICGROUPS) \
+            $(INTEL_METRICS) $(INTEL_METRICGROUPS)
+
 $(METRIC_TEST_LOG): $(METRIC_TEST_PY) $(METRIC_PY)
 	$(call rule_mkdir)
 	$(Q)$(call echo-cmd,test)$(PYTHON) $< 2> $@ || (cat $@ && false)
 
-$(PMU_EVENTS_C): $(JSON) $(JSON_TEST) $(JEVENTS_PY) $(METRIC_PY) $(METRIC_TEST_LOG)
+$(PMU_EVENTS_C): $(GEN_JSON) $(JSON_TEST) $(JEVENTS_PY) $(METRIC_PY) $(METRIC_TEST_LOG)
 	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) $(JEVENTS_ARCH) $(JEVENTS_MODEL) pmu-events/arch $@
+	$(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) $(JEVENTS_ARCH) $(JEVENTS_MODEL) $(OUTPUT)pmu-events/arch $@
 endif
 
 # pmu-events.c file is generated in the OUTPUT directory so it needs a
diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
new file mode 100755
index 000000000000..7ab2ee4fdb17
--- /dev/null
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -0,0 +1,38 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+from metric import (JsonEncodeMetric, JsonEncodeMetricGroupDescriptions, MetricGroup)
+import argparse
+import json
+import os
+
+# Global command line arguments.
+_args = None
+
+def main() -> None:
+  global _args
+
+  def dir_path(path: str) -> str:
+    """Validate path is a directory for argparse."""
+    if os.path.isdir(path):
+      return path
+    raise argparse.ArgumentTypeError(f'\'{path}\' is not a valid directory')
+
+  parser = argparse.ArgumentParser(description="AMD perf json generator")
+  parser.add_argument("-metricgroups", help="Generate metricgroups data", action='store_true')
+  parser.add_argument("model", help="e.g. amdzen[123]")
+  parser.add_argument(
+      'events_path',
+      type=dir_path,
+      help='Root of tree containing architecture directories containing json files'
+  )
+  _args = parser.parse_args()
+
+  all_metrics = MetricGroup("",[])
+
+  if _args.metricgroups:
+    print(JsonEncodeMetricGroupDescriptions(all_metrics))
+  else:
+    print(JsonEncodeMetric(all_metrics))
+
+if __name__ == '__main__':
+  main()
diff --git a/tools/perf/pmu-events/arm64_metrics.py b/tools/perf/pmu-events/arm64_metrics.py
new file mode 100755
index 000000000000..a9f0e6bc751b
--- /dev/null
+++ b/tools/perf/pmu-events/arm64_metrics.py
@@ -0,0 +1,39 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+from metric import (JsonEncodeMetric, JsonEncodeMetricGroupDescriptions, MetricGroup)
+import argparse
+import json
+import os
+
+# Global command line arguments.
+_args = None
+
+def main() -> None:
+  global _args
+
+  def dir_path(path: str) -> str:
+    """Validate path is a directory for argparse."""
+    if os.path.isdir(path):
+      return path
+    raise argparse.ArgumentTypeError(f'\'{path}\' is not a valid directory')
+
+  parser = argparse.ArgumentParser(description="ARM perf json generator")
+  parser.add_argument("-metricgroups", help="Generate metricgroups data", action='store_true')
+  parser.add_argument("vendor", help="e.g. arm")
+  parser.add_argument("model", help="e.g. neoverse-n1")
+  parser.add_argument(
+      'events_path',
+      type=dir_path,
+      help='Root of tree containing architecture directories containing json files'
+  )
+  _args = parser.parse_args()
+
+  all_metrics = MetricGroup("",[])
+
+  if _args.metricgroups:
+    print(JsonEncodeMetricGroupDescriptions(all_metrics))
+  else:
+    print(JsonEncodeMetric(all_metrics))
+
+if __name__ == '__main__':
+  main()
diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
new file mode 100755
index 000000000000..f004c27640d2
--- /dev/null
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -0,0 +1,38 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+from metric import (JsonEncodeMetric, JsonEncodeMetricGroupDescriptions, MetricGroup)
+import argparse
+import json
+import os
+
+# Global command line arguments.
+_args = None
+
+def main() -> None:
+  global _args
+
+  def dir_path(path: str) -> str:
+    """Validate path is a directory for argparse."""
+    if os.path.isdir(path):
+      return path
+    raise argparse.ArgumentTypeError(f'\'{path}\' is not a valid directory')
+
+  parser = argparse.ArgumentParser(description="Intel perf json generator")
+  parser.add_argument("-metricgroups", help="Generate metricgroups data", action='store_true')
+  parser.add_argument("model", help="e.g. skylakex")
+  parser.add_argument(
+      'events_path',
+      type=dir_path,
+      help='Root of tree containing architecture directories containing json files'
+  )
+  _args = parser.parse_args()
+
+  all_metrics = MetricGroup("",[])
+
+  if _args.metricgroups:
+    print(JsonEncodeMetricGroupDescriptions(all_metrics))
+  else:
+    print(JsonEncodeMetric(all_metrics))
+
+if __name__ == '__main__':
+  main()
-- 
2.44.0.278.ge034bb2e1d-goog


