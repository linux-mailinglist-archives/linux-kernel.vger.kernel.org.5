Return-Path: <linux-kernel+bounces-95962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D0587555D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:41:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFD581C24B4F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42E7130E24;
	Thu,  7 Mar 2024 17:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="J2DiKUDM"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3F7130E29
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 17:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709833235; cv=none; b=Tlp0l6qbfE63yU4rGpNK2dpMDRiw2qksT7zZU2Q5p27Awa70Qo+Z2EshxfbM49ji1nK4ygeziHf5+nMPw1GVJF5602km70FEt6VEpuq95hF2t2zHGyFsQN3ysRMtcVPbwlD/U5u+kC9rRxbf1SykmcQhuIXBs+JZUMerp2Ix9rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709833235; c=relaxed/simple;
	bh=rmbRKlb2vBzSHZMNaT8weYEcJ5jh/TsECzXwG5zHVJI=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=H5dOXY6px99aF55PzHAiYSkzSqNrPphhtOmhY0M2/9de21M5HM49RxWrkpur3MCnGWSX/J9AJ3LLVvhYNIv0booBarMvCmdZOa54EdjYDyjj6nuG2DQAnVqNOJGkpcYlZ9NsjukwtdxssRiOzMtMhhbfu+nM6YsPlPOXFb8jGsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J2DiKUDM; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-608e88ca078so17127787b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 09:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709833232; x=1710438032; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6mfNvkJfntBmtMbV7xiy0gPZgImuCiMELZ3US+yokug=;
        b=J2DiKUDMJA0XOx1rPCEwBZS8+fZkmfpdETjgMzF5N32YGNy0k1fK4a/1p2Q1/bEWQ7
         GMc3NJG84cS9cRIPcouOZwsWgX5vMOnbMQfiLY/QSyICC4vqzi6psnGvUS++ANfTVaSO
         guCM+dCvzrlvBcioV6/j7sgltMfXeUANPBGHnc5J16afYNMkL1z70+DztWlJV801ZNb7
         Q5IQdU+xcd9o50geC7zdUWT4MF5xM9F+RIrhw0fVT1f9hRBr4Q8HDwIPyFXdlsoTjSp5
         9G91z8/9SBDCI+AD/5kQ7skpFbQyvylEEMT1Bd6OE//imyPfbxGD6rzz0EpGpViIU+DA
         41wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709833232; x=1710438032;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6mfNvkJfntBmtMbV7xiy0gPZgImuCiMELZ3US+yokug=;
        b=GxmiOSr74Z+W4gIzLhNF9PnuC7IKro2PvqrwNyeC9Ui5Uq5YyHHhH+PAZeqveNEKjq
         EAc4a9MhyFsnoayIyv7YJzSAL2WU5Uv4l5WiGo16mq5ihMOyORw0vF8IC/dlmBYJ93GA
         8rBd1azYbowWo3MmlDbxyYifGQ51VlaXFspmUYjR1oUlWzMX/2YWuZZ3E15Chm1Dn3oC
         DBSqpBwOwyqu5x1wJAvmHCa6stCwDQ9gqO5v1YMPkdIp37toZSlwgJ5MKhq5pPwiZFHP
         /emCM5nCiUtjrl8cxL5YH9bXB2RKPLo+gCpMFd6gygJBkPIfzp58GobooKH8nPMxSJ9Z
         feQA==
X-Forwarded-Encrypted: i=1; AJvYcCVZhhzhbS20ahjMfQWaKXrFi72mQVTVc2thtwUj6bXp20qwLA4FXeO1fmyil6cU/SHXMCCbMYSCAMojIwnsXVtyThAzNRWlNQNyzWQ/
X-Gm-Message-State: AOJu0YwDNwgauduQmJMRcDkWoB5T1Dj8OVI750K3pSOQneqmf6cqBY1+
	dFAsLmWry1pjufMEwCrqC7MXbTazBFxpVFX+jkyEZiS4myOUyc0LhXNm24Y2GA5BdpIXR0n4Ked
	zqEi2vg==
X-Google-Smtp-Source: AGHT+IH+HUty856X+wVJVrTL391Sb5bgQdEGw9tBYaH1uOQNAMTxZFmlE7btZ9mf2QftqdzZxCDuFG5jXKtg
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:47d6:1de1:237a:6728])
 (user=irogers job=sendgmr) by 2002:a05:6902:1004:b0:dc2:3441:897f with SMTP
 id w4-20020a056902100400b00dc23441897fmr4537167ybt.6.1709833232428; Thu, 07
 Mar 2024 09:40:32 -0800 (PST)
Date: Thu,  7 Mar 2024 09:39:53 -0800
In-Reply-To: <20240307173955.3982040-1-irogers@google.com>
Message-Id: <20240307173955.3982040-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240307173955.3982040-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v2 4/6] perf list: Give more details about raw event encodings
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Yang Jihong <yangjihong1@huawei.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@arm.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

List all the PMUs, not just the first core one, and list real format
specifiers with value ranges.

Before:
```
$ perf list
..
  rNNN                                               [Raw hardware event descriptor]
  cpu/t1=v1[,t2=v2,t3 ...]/modifier                  [Raw hardware event descriptor]
       [(see 'man perf-list' on how to encode it)]
  mem:<addr>[/len][:access]                          [Hardware breakpoint]
..
```

After:
```
$ perf list
..
  rNNN                                               [Raw event descriptor]
  cpu/event=0..255,pc,edge,.../modifier              [Raw event descriptor]
       [(see 'man perf-list' or 'man perf-record' on how to encode it)]
  breakpoint//modifier                               [Raw event descriptor]
  cstate_core/event=0..0xffffffffffffffff/modifier   [Raw event descriptor]
  cstate_pkg/event=0..0xffffffffffffffff/modifier    [Raw event descriptor]
  i915/i915_eventid=0..0x1fffff/modifier             [Raw event descriptor]
  intel_bts//modifier                                [Raw event descriptor]
  intel_pt/ptw,event,cyc_thresh=0..15,.../modifier   [Raw event descriptor]
  kprobe/retprobe/modifier                           [Raw event descriptor]
  msr/event=0..0xffffffffffffffff/modifier           [Raw event descriptor]
  power/event=0..255/modifier                        [Raw event descriptor]
  software//modifier                                 [Raw event descriptor]
  tracepoint//modifier                               [Raw event descriptor]
  uncore_arb/event=0..255,edge,inv,.../modifier      [Raw event descriptor]
  uncore_cbox/event=0..255,edge,inv,.../modifier     [Raw event descriptor]
  uncore_clock/event=0..255/modifier                 [Raw event descriptor]
  uncore_imc_free_running/event=0..255,umask=0..255/modifier[Raw event descriptor]
  uprobe/ref_ctr_offset=0..0xffffffff,retprobe/modifier[Raw event descriptor]
  mem:<addr>[/len][:access]                          [Hardware breakpoint]
..
```

With '--details' provide more details on the formats encoding:
```
  cpu/event=0..255,pc,edge,.../modifier              [Raw event descriptor]
       [(see 'man perf-list' or 'man perf-record' on how to encode it)]
        cpu/event=0..255,pc,edge,offcore_rsp=0..0xffffffffffffffff,ldlat=0..0xffff,inv,
        umask=0..255,frontend=0..0xffffff,cmask=0..255,config=0..0xffffffffffffffff,
        config1=0..0xffffffffffffffff,config2=0..0xffffffffffffffff,config3=0..0xffffffffffffffff,
        name=string,period=number,freq=number,branch_type=(u|k|hv|any|...),time,
        call-graph=(fp|dwarf|lbr),stack-size=number,max-stack=number,nr=number,inherit,no-inherit,
        overwrite,no-overwrite,percore,aux-output,aux-sample-size=number/modifier
  breakpoint//modifier                               [Raw event descriptor]
        breakpoint//modifier
  cstate_core/event=0..0xffffffffffffffff/modifier   [Raw event descriptor]
        cstate_core/event=0..0xffffffffffffffff/modifier
  cstate_pkg/event=0..0xffffffffffffffff/modifier    [Raw event descriptor]
        cstate_pkg/event=0..0xffffffffffffffff/modifier
  i915/i915_eventid=0..0x1fffff/modifier             [Raw event descriptor]
        i915/i915_eventid=0..0x1fffff/modifier
  intel_bts//modifier                                [Raw event descriptor]
        intel_bts//modifier
  intel_pt/ptw,event,cyc_thresh=0..15,.../modifier   [Raw event descriptor]
        intel_pt/ptw,event,cyc_thresh=0..15,pt,notnt,branch,tsc,pwr_evt,fup_on_ptw,cyc,noretcomp,
        mtc,psb_period=0..15,mtc_period=0..15/modifier
  kprobe/retprobe/modifier                           [Raw event descriptor]
        kprobe/retprobe/modifier
  msr/event=0..0xffffffffffffffff/modifier           [Raw event descriptor]
        msr/event=0..0xffffffffffffffff/modifier
  power/event=0..255/modifier                        [Raw event descriptor]
        power/event=0..255/modifier
  software//modifier                                 [Raw event descriptor]
        software//modifier
  tracepoint//modifier                               [Raw event descriptor]
        tracepoint//modifier
  uncore_arb/event=0..255,edge,inv,.../modifier      [Raw event descriptor]
        uncore_arb/event=0..255,edge,inv,umask=0..255,cmask=0..31/modifier
  uncore_cbox/event=0..255,edge,inv,.../modifier     [Raw event descriptor]
        uncore_cbox/event=0..255,edge,inv,umask=0..255,cmask=0..31/modifier
  uncore_clock/event=0..255/modifier                 [Raw event descriptor]
        uncore_clock/event=0..255/modifier
  uncore_imc_free_running/event=0..255,umask=0..255/modifier[Raw event descriptor]
        uncore_imc_free_running/event=0..255,umask=0..255/modifier
  uprobe/ref_ctr_offset=0..0xffffffff,retprobe/modifier[Raw event descriptor]
        uprobe/ref_ctr_offset=0..0xffffffff,retprobe/modifier
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c          | 61 +++++++++++++++++++++-
 tools/perf/util/pmu.h          |  3 ++
 tools/perf/util/pmus.c         | 94 ++++++++++++++++++++++++++++++++++
 tools/perf/util/pmus.h         |  1 +
 tools/perf/util/print-events.c | 20 +-------
 5 files changed, 160 insertions(+), 19 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 24be587e3537..e24bc3b8f696 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1603,6 +1603,61 @@ bool perf_pmu__has_format(const struct perf_pmu *pmu, const char *name)
 	return false;
 }
 
+int perf_pmu__for_each_format(struct perf_pmu *pmu, void *state, pmu_format_callback cb)
+{
+	static const char *const terms[] = {
+		"config=0..0xffffffffffffffff",
+		"config1=0..0xffffffffffffffff",
+		"config2=0..0xffffffffffffffff",
+		"config3=0..0xffffffffffffffff",
+		"name=string",
+		"period=number",
+		"freq=number",
+		"branch_type=(u|k|hv|any|...)",
+		"time",
+		"call-graph=(fp|dwarf|lbr)",
+		"stack-size=number",
+		"max-stack=number",
+		"nr=number",
+		"inherit",
+		"no-inherit",
+		"overwrite",
+		"no-overwrite",
+		"percore",
+		"aux-output",
+		"aux-sample-size=number",
+	};
+	struct perf_pmu_format *format;
+	int ret;
+
+	/*
+	 * max-events and driver-config are missing above as are the internal
+	 * types user, metric-id, raw, legacy cache and hardware. Assert against
+	 * the enum parse_events__term_type so they are kept in sync.
+	 */
+	_Static_assert(ARRAY_SIZE(terms) == __PARSE_EVENTS__TERM_TYPE_NR - 6);
+	list_for_each_entry(format, &pmu->format, list) {
+		perf_pmu_format__load(pmu, format);
+		ret = cb(state, format->name, (int)format->value, format->bits);
+		if (ret)
+			return ret;
+	}
+	if (!pmu->is_core)
+		return 0;
+
+	for (size_t i = 0; i < ARRAY_SIZE(terms); i++) {
+		int config = PERF_PMU_FORMAT_VALUE_CONFIG;
+
+		if (i < PERF_PMU_FORMAT_VALUE_CONFIG_END)
+			config = i;
+
+		ret = cb(state, terms[i], config, /*bits=*/NULL);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
 bool is_pmu_core(const char *name)
 {
 	return !strcmp(name, "cpu") || !strcmp(name, "cpum_cf") || is_sysfs_pmu_core(name);
@@ -1697,8 +1752,12 @@ int perf_pmu__for_each_event(struct perf_pmu *pmu, bool skip_duplicate_pmus,
 	pmu_add_cpu_aliases(pmu);
 	list_for_each_entry(event, &pmu->aliases, list) {
 		size_t buf_used;
+		int pmu_name_len;
 
 		info.pmu_name = event->pmu_name ?: pmu->name;
+		pmu_name_len = skip_duplicate_pmus
+			? pmu_name_len_no_suffix(info.pmu_name, /*num=*/NULL)
+			: (int)strlen(info.pmu_name);
 		info.alias = NULL;
 		if (event->desc) {
 			info.name = event->name;
@@ -1723,7 +1782,7 @@ int perf_pmu__for_each_event(struct perf_pmu *pmu, bool skip_duplicate_pmus,
 		info.encoding_desc = buf + buf_used;
 		parse_events_terms__to_strbuf(&event->terms, &sb);
 		buf_used += snprintf(buf + buf_used, sizeof(buf) - buf_used,
-				"%s/%s/", info.pmu_name, sb.buf) + 1;
+				"%.*s/%s/", pmu_name_len, info.pmu_name, sb.buf) + 1;
 		info.topic = event->topic;
 		info.str = sb.buf;
 		info.deprecated = event->deprecated;
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index e35d985206db..9f5284b29ecf 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -196,6 +196,8 @@ struct pmu_event_info {
 };
 
 typedef int (*pmu_event_callback)(void *state, struct pmu_event_info *info);
+typedef int (*pmu_format_callback)(void *state, const char *name, int config,
+				   const unsigned long *bits);
 
 void pmu_add_sys_aliases(struct perf_pmu *pmu);
 int perf_pmu__config(struct perf_pmu *pmu, struct perf_event_attr *attr,
@@ -215,6 +217,7 @@ int perf_pmu__find_event(struct perf_pmu *pmu, const char *event, void *state, p
 int perf_pmu__format_parse(struct perf_pmu *pmu, int dirfd, bool eager_load);
 void perf_pmu_format__set_value(void *format, int config, unsigned long *bits);
 bool perf_pmu__has_format(const struct perf_pmu *pmu, const char *name);
+int perf_pmu__for_each_format(struct perf_pmu *pmu, void *state, pmu_format_callback cb);
 
 bool is_pmu_core(const char *name);
 bool perf_pmu__supports_legacy_cache(const struct perf_pmu *pmu);
diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index 16505071d362..2fd369e45832 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -16,6 +16,7 @@
 #include "pmus.h"
 #include "pmu.h"
 #include "print-events.h"
+#include "strbuf.h"
 
 /*
  * core_pmus:  A PMU belongs to core_pmus if it's name is "cpu" or it's sysfs
@@ -503,6 +504,99 @@ void perf_pmus__print_pmu_events(const struct print_callbacks *print_cb, void *p
 	zfree(&aliases);
 }
 
+struct build_format_string_args {
+	struct strbuf short_string;
+	struct strbuf long_string;
+	int num_formats;
+};
+
+static int build_format_string(void *state, const char *name, int config,
+			       const unsigned long *bits)
+{
+	struct build_format_string_args *args = state;
+	unsigned int num_bits;
+	int ret1, ret2 = 0;
+
+	(void)config;
+	args->num_formats++;
+	if (args->num_formats > 1) {
+		strbuf_addch(&args->long_string, ',');
+		if (args->num_formats < 4)
+			strbuf_addch(&args->short_string, ',');
+	}
+	num_bits = bits ? bitmap_weight(bits, PERF_PMU_FORMAT_BITS) : 0;
+	if (num_bits <= 1) {
+		ret1 = strbuf_addf(&args->long_string, "%s", name);
+		if (args->num_formats < 4)
+			ret2 = strbuf_addf(&args->short_string, "%s", name);
+	} else if (num_bits > 8) {
+		ret1 = strbuf_addf(&args->long_string, "%s=0..0x%llx", name,
+				   ULLONG_MAX >> (64 - num_bits));
+		if (args->num_formats < 4) {
+			ret2 = strbuf_addf(&args->short_string, "%s=0..0x%llx", name,
+					   ULLONG_MAX >> (64 - num_bits));
+		}
+	} else {
+		ret1 = strbuf_addf(&args->long_string, "%s=0..%llu", name,
+				  ULLONG_MAX >> (64 - num_bits));
+		if (args->num_formats < 4) {
+			ret2 = strbuf_addf(&args->short_string, "%s=0..%llu", name,
+					   ULLONG_MAX >> (64 - num_bits));
+		}
+	}
+	return ret1 < 0 ? ret1 : (ret2 < 0 ? ret2 : 0);
+}
+
+void perf_pmus__print_raw_pmu_events(const struct print_callbacks *print_cb, void *print_state)
+{
+	bool skip_duplicate_pmus = print_cb->skip_duplicate_pmus(print_state);
+	struct perf_pmu *(*scan_fn)(struct perf_pmu *);
+	struct perf_pmu *pmu = NULL;
+
+	if (skip_duplicate_pmus)
+		scan_fn = perf_pmus__scan_skip_duplicates;
+	else
+		scan_fn = perf_pmus__scan;
+
+	while ((pmu = scan_fn(pmu)) != NULL) {
+		struct build_format_string_args format_args = {
+			.short_string = STRBUF_INIT,
+			.long_string = STRBUF_INIT,
+			.num_formats = 0,
+		};
+		int len = pmu_name_len_no_suffix(pmu->name, /*num=*/NULL);
+		const char *desc = "(see 'man perf-list' or 'man perf-record' on how to encode it)";
+
+		if (!pmu->is_core)
+			desc = NULL;
+
+		strbuf_addf(&format_args.short_string, "%.*s/", len, pmu->name);
+		strbuf_addf(&format_args.long_string, "%.*s/", len, pmu->name);
+		perf_pmu__for_each_format(pmu, &format_args, build_format_string);
+
+		if (format_args.num_formats > 3)
+			strbuf_addf(&format_args.short_string, ",.../modifier");
+		else
+			strbuf_addf(&format_args.short_string, "/modifier");
+
+		strbuf_addf(&format_args.long_string, "/modifier");
+		print_cb->print_event(print_state,
+				/*topic=*/NULL,
+				/*pmu_name=*/NULL,
+				format_args.short_string.buf,
+				/*event_alias=*/NULL,
+				/*scale_unit=*/NULL,
+				/*deprecated=*/false,
+				"Raw event descriptor",
+				desc,
+				/*long_desc=*/NULL,
+				format_args.long_string.buf);
+
+		strbuf_release(&format_args.short_string);
+		strbuf_release(&format_args.long_string);
+	}
+}
+
 bool perf_pmus__have_event(const char *pname, const char *name)
 {
 	struct perf_pmu *pmu = perf_pmus__find(pname);
diff --git a/tools/perf/util/pmus.h b/tools/perf/util/pmus.h
index 94d2a08d894b..eec599d8aebd 100644
--- a/tools/perf/util/pmus.h
+++ b/tools/perf/util/pmus.h
@@ -18,6 +18,7 @@ struct perf_pmu *perf_pmus__scan_core(struct perf_pmu *pmu);
 const struct perf_pmu *perf_pmus__pmu_for_pmu_filter(const char *str);
 
 void perf_pmus__print_pmu_events(const struct print_callbacks *print_cb, void *print_state);
+void perf_pmus__print_raw_pmu_events(const struct print_callbacks *print_cb, void *print_state);
 bool perf_pmus__have_event(const char *pname, const char *name);
 int perf_pmus__num_core_pmus(void);
 bool perf_pmus__supports_extended_type(void);
diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-events.c
index e0d2b49bab66..3f38c27f0157 100644
--- a/tools/perf/util/print-events.c
+++ b/tools/perf/util/print-events.c
@@ -39,7 +39,7 @@ static const char * const event_type_descriptors[] = {
 	"Software event",
 	"Tracepoint event",
 	"Hardware cache event",
-	"Raw hardware event descriptor",
+	"Raw event descriptor",
 	"Hardware breakpoint",
 };
 
@@ -416,8 +416,6 @@ void print_symbol_events(const struct print_callbacks *print_cb, void *print_sta
  */
 void print_events(const struct print_callbacks *print_cb, void *print_state)
 {
-	char *tmp;
-
 	print_symbol_events(print_cb, print_state, PERF_TYPE_HARDWARE,
 			event_symbols_hw, PERF_COUNT_HW_MAX);
 	print_symbol_events(print_cb, print_state, PERF_TYPE_SOFTWARE,
@@ -441,21 +439,7 @@ void print_events(const struct print_callbacks *print_cb, void *print_state)
 			/*long_desc=*/NULL,
 			/*encoding_desc=*/NULL);
 
-	if (asprintf(&tmp, "%s/t1=v1[,t2=v2,t3 ...]/modifier",
-		     perf_pmus__scan_core(/*pmu=*/NULL)->name) > 0) {
-		print_cb->print_event(print_state,
-				/*topic=*/NULL,
-				/*pmu_name=*/NULL,
-				tmp,
-				/*event_alias=*/NULL,
-				/*scale_unit=*/NULL,
-				/*deprecated=*/false,
-				event_type_descriptors[PERF_TYPE_RAW],
-				"(see 'man perf-list' on how to encode it)",
-				/*long_desc=*/NULL,
-				/*encoding_desc=*/NULL);
-		free(tmp);
-	}
+	perf_pmus__print_raw_pmu_events(print_cb, print_state);
 
 	print_cb->print_event(print_state,
 			/*topic=*/NULL,
-- 
2.44.0.278.ge034bb2e1d-goog


