Return-Path: <linux-kernel+bounces-89285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8968186EDBC
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 02:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49228288191
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 01:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3D517C7B;
	Sat,  2 Mar 2024 01:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4P4ohSiZ"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483EC17BAA
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 01:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709341227; cv=none; b=CSx3sjNfgqaSQVuhGRcPvnWdALQfvrMVmaiOadLU49t1tVpNlyVtI/cnpWfJGoiXzt3MytWmz3Qd7TyA32iSpa3Dk2s7SKyInhcd/OzR2LC1pJCy+HdPAiHWi4WN+0u7sTE0W+hqNdAZR1dGkI45K/+6WwGsEYcjq3O5+A9lTsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709341227; c=relaxed/simple;
	bh=CHrAJbvJO9BTJsj3EUS8jinTu8Wtt+S0RfDD6NVmeDM=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=M1L12piGCbZHfTgUkeuuOKKTp/q2hXvRcSXvXQoT9Gzt1ZatM9QcfwYdxgjo5q9QZJ/mHG30rIk5ccv+xgxsP4mHsvcqr20fg2s8Gf/tNOTJ8z+RkWeXTRsO+PJgljEpshjrGbV6M5HqUlNC4hMr/R/VB4lvHrZP0GOL1fodHhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4P4ohSiZ; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcdc3db67f0so4352407276.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 17:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709341224; x=1709946024; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nx4MlmIt8t3TyA1tk4UL1nVGkD2g6IUGJuLnswRehIc=;
        b=4P4ohSiZimBTWzpbIdDWLq1maUG/UOijRiCSLUJr1ha3rZATtkU2ZuRxQampCAsZVn
         adPk28HLACiImZ+juf2WN9IzJesDiZW2b6NBwIRRRn6b2L5yCRhle23j6eML8kw4zujJ
         bWtXE/ihEv1tZFLIGKuaNQ+ygwHyCeM0XefxQfugGIbILke3YIKhD8Lib1UW/3M6DOzY
         TtW96waX4wehE8woZUknml++lC9TbvwQ1edoWdOcV5kcCKq3GYjgpMCjMrSHhIrOMNnX
         1Qxc44sMusxiEAev6v9+cFv9LOLpq+CfID1zy+bpdhORAAgub49Cqj+AT9Y/iaG73314
         pjWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709341224; x=1709946024;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nx4MlmIt8t3TyA1tk4UL1nVGkD2g6IUGJuLnswRehIc=;
        b=WqY2HGYGOkT9boFqhsM1vxutN/sR8B2SEiM5dBVouork27E9+CwmMuzh/mAJVwOBxv
         OflsF/c7B7/II62eDr+LY8213KfEwvBVHMCxBAsbu5kP8RD9RA+44MWzqwa9Fna+YZX3
         0DNCrMWoWwfNOjx3qp4C1FBi1gcmi3TpO0YMSqv5kNpUCzIMeLl+D3NGain96zcuJ69Q
         ZbnFqgWyF+CKqLB/KQsSHZh/lns1X87x6LafAc1y3rgNKrO/+9ASRrJ6V1FqIjcpOIMe
         PnQRJ/Ffyg0FwRwnfjwsiHuHT8j8KByiwrAsUPBeTeVwqGXaO08JFj7tyErOV2BJ+6ae
         HrHg==
X-Forwarded-Encrypted: i=1; AJvYcCVebtiO6/hPsmEg40xiABff8BV2prV1OksVfHidoCn94jNOk7g1YgmOOQJ5NUDsbfs/f8miXdg3Q19Dhjt8RN615sfvsJv7gZMPxNE3
X-Gm-Message-State: AOJu0YzoY5nRnDx9UbNXcj9FWLBlZZr0CQp0ogq2pMVT9QQtjD38R1lq
	6GcQJ+CxCjuAZP0BV8tmm2E/SmmamDz+A1pP54ryEsUCttW5mj2NSn4bqjVl9/Dy8ikScFyV9Q+
	IboHT/Q==
X-Google-Smtp-Source: AGHT+IGKzVKbJGMV6uPl8/41W9RffBLlSlItlMsxNZlUpl/IJHPaYWqoPAWdBRsBzp/KjczbXd1bKkKmS93I
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:aba7:66c5:3365:7114])
 (user=irogers job=sendgmr) by 2002:a5b:b4d:0:b0:dcc:2267:796e with SMTP id
 b13-20020a5b0b4d000000b00dcc2267796emr1216113ybr.2.1709341224564; Fri, 01 Mar
 2024 17:00:24 -0800 (PST)
Date: Fri,  1 Mar 2024 16:59:49 -0800
In-Reply-To: <20240302005950.2847058-1-irogers@google.com>
Message-Id: <20240302005950.2847058-12-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240302005950.2847058-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v2 11/12] perf jevents: Build support for generating metrics
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
 tools/perf/pmu-events/amd_metrics.py   | 17 ++++++++
 tools/perf/pmu-events/arm64_metrics.py | 18 ++++++++
 tools/perf/pmu-events/intel_metrics.py | 17 ++++++++
 6 files changed, 124 insertions(+), 7 deletions(-)
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
index 04d89d2ed209..4fbb0a173476 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -1177,7 +1177,20 @@ endif # CONFIG_PERF_BPF_SKEL
 bpf-skel-clean:
 	$(call QUIET_CLEAN, bpf-skel) $(RM) -r $(SKEL_TMP_OUT) $(SKELETONS) $(SKEL_OUT)/vmlinux.h
 
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
@@ -1185,8 +1198,6 @@ clean:: $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBSYMBOL)-clean $(
 	$(call QUIET_CLEAN, core-gen)   $(RM)  *.spec *.pyc *.pyo */*.pyc */*.pyo $(OUTPUT)common-cmds.h TAGS tags cscope* $(OUTPUT)PERF-VERSION-FILE $(OUTPUT)FEATURE-DUMP $(OUTPUT)util/*-bison* $(OUTPUT)util/*-flex* \
 		$(OUTPUT)util/intel-pt-decoder/inat-tables.c \
 		$(OUTPUT)tests/llvm-src-{base,kbuild,prologue,relocation}.c \
-		$(OUTPUT)pmu-events/pmu-events.c \
-		$(OUTPUT)pmu-events/metric_test.log \
 		$(OUTPUT)$(fadvise_advice_array) \
 		$(OUTPUT)$(fsconfig_arrays) \
 		$(OUTPUT)$(fsmount_arrays) \
diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
index 1d18bb89402e..9af15e3498f1 100644
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
+	$(Q)$(call echo-cmd,gen)$(PYTHON) $< $(call model_name,$@) > $@
+
+$(ZEN_METRICGROUPS): pmu-events/amd_metrics.py
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,gen)$(PYTHON) $< -metricgroups $(call model_name,$@) > $@
+
+# Generate ARM Json
+ARMS = $(shell ls -d pmu-events/arch/arm64/arm/*)
+ARM_METRICS = $(foreach x,$(ARMS),$(OUTPUT)$(x)/extra-metrics.json)
+ARM_METRICGROUPS = $(foreach x,$(ARMS),$(OUTPUT)$(x)/extra-metricgroups.json)
+
+$(ARM_METRICS): pmu-events/arm64_metrics.py
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,gen)$(PYTHON) $< $(call vendor_name,$@) $(call model_name,$@) > $@
+
+$(ARM_METRICGROUPS): pmu-events/arm64_metrics.py
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,gen)$(PYTHON) $< -metricgroups $(call vendor_name,$@) $(call model_name,$@) > $@
+
+# Generate Intel Json
+INTELS = $(shell ls -d pmu-events/arch/x86/*|grep -v amdzen|grep -v mapfile.csv)
+INTEL_METRICS = $(foreach x,$(INTELS),$(OUTPUT)$(x)/extra-metrics.json)
+INTEL_METRICGROUPS = $(foreach x,$(INTELS),$(OUTPUT)$(x)/extra-metricgroups.json)
+
+$(INTEL_METRICS): pmu-events/intel_metrics.py
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,gen)$(PYTHON) $< $(call model_name,$@) > $@
+
+$(INTEL_METRICGROUPS): pmu-events/intel_metrics.py
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,gen)$(PYTHON) $< -metricgroups $(call model_name,$@) > $@
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
index 000000000000..cb850ab1ed13
--- /dev/null
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -0,0 +1,17 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+from metric import (JsonEncodeMetric, JsonEncodeMetricGroupDescriptions, MetricGroup)
+import argparse
+import json
+
+parser = argparse.ArgumentParser(description="AMD perf json generator")
+parser.add_argument("-metricgroups", help="Generate metricgroups data", action='store_true')
+parser.add_argument("model", help="e.g. amdzen[123]")
+args = parser.parse_args()
+
+all_metrics = MetricGroup("",[])
+
+if args.metricgroups:
+  print(JsonEncodeMetricGroupDescriptions(all_metrics))
+else:
+  print(JsonEncodeMetric(all_metrics))
diff --git a/tools/perf/pmu-events/arm64_metrics.py b/tools/perf/pmu-events/arm64_metrics.py
new file mode 100755
index 000000000000..a54fa8aae2fa
--- /dev/null
+++ b/tools/perf/pmu-events/arm64_metrics.py
@@ -0,0 +1,18 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+from metric import (JsonEncodeMetric, JsonEncodeMetricGroupDescriptions, MetricGroup)
+import argparse
+import json
+
+parser = argparse.ArgumentParser(description="ARM perf json generator")
+parser.add_argument("-metricgroups", help="Generate metricgroups data", action='store_true')
+parser.add_argument("vendor", help="e.g. arm")
+parser.add_argument("model", help="e.g. neoverse-n1")
+args = parser.parse_args()
+
+all_metrics = MetricGroup("",[])
+
+if args.metricgroups:
+  print(JsonEncodeMetricGroupDescriptions(all_metrics))
+else:
+  print(JsonEncodeMetric(all_metrics))
diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
new file mode 100755
index 000000000000..8b67b9613ab5
--- /dev/null
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -0,0 +1,17 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+from metric import (JsonEncodeMetric, JsonEncodeMetricGroupDescriptions, MetricGroup)
+import argparse
+import json
+
+parser = argparse.ArgumentParser(description="Intel perf json generator")
+parser.add_argument("-metricgroups", help="Generate metricgroups data", action='store_true')
+parser.add_argument("model", help="e.g. skylakex")
+args = parser.parse_args()
+
+all_metrics = MetricGroup("",[])
+
+if args.metricgroups:
+  print(JsonEncodeMetricGroupDescriptions(all_metrics))
+else:
+  print(JsonEncodeMetric(all_metrics))
-- 
2.44.0.278.ge034bb2e1d-goog


