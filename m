Return-Path: <linux-kernel+bounces-50722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA9C847D4A
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 00:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 563F8B22B7E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 23:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BCF12C80A;
	Fri,  2 Feb 2024 23:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4w0kFDQh"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800CF130AD0
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 23:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706917281; cv=none; b=ujS+kMvM66pKUbMRrdXLu1COCGa+2RQcSTG/z5rra5QwpitrQ159IZveX68zobm+FBH+4duR+3KsoxmPsp+VRRkuziMsIIrPfgRZ618IfSBZPhpmZQHLpnGWJKn2whjFNMIinau7UWzElbT9Is2BwWMkgIDgfhqcVY9UW0zQV9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706917281; c=relaxed/simple;
	bh=vrKD5r788IsBMcWd7p/Y0rFlE9n9DwipYIJHOz74tOw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=F39gbAn2DDa6VQGl7Ogphkov2BlVzW9Hznv8e0EgWvXjfpNDtW6iIEipmk5q3nunwBg9MjCnhYQYS3rQnOXSVkcSmDpwBdGPQIR+ELtsw0TLAAPh44XgpbPILZBvl90W5MmshmSXhNLQZ70GA1z199vCmAlZYN1ZdDZuMcCvtHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4w0kFDQh; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5ee22efe5eeso45173697b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 15:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706917278; x=1707522078; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wr65K6vWppDQ/+c7LXR1fsKtLh163OjTy8d5391wuIk=;
        b=4w0kFDQhOhQz0WvuFPLIj+zyJzPgZ2QMlZ8lOM2cYWh6Z4Ij6FGdLBiXomLeP0p71c
         DA/VgJmxdEYjbM45a1wHLR1NS3uNSD1HcXFzNRby4Z5vUmGTVEwz3bkjCY3wUSEr8rQU
         w+UZk3cT0KO9U80IG7izxhul43cDXV94QRsCXmCZvr8cseO4t7p5445D+s2YJji64eWt
         cueuLaf1fo3+B/IlixcdhaF2bLIT88OWgL+1Y3HCIQHgPOGZBeO/sEo+ShO/n91sV0DQ
         EqCSpaIRpEloNRKb8nYA/9DdeiGhuv/gTENpBB+eKYcqnQ7+QmQSUAHTAm+B5zVmzasB
         MLUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706917278; x=1707522078;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wr65K6vWppDQ/+c7LXR1fsKtLh163OjTy8d5391wuIk=;
        b=Ks2U58cGoNxbM7CzV0tRV44pEeVYHIf9BcZeNOwXNAi1kXyCoqfWTg8K7NtEWxhmPH
         KQTKVgd3uq5nPk0cOW6aQRFaa2N65x6U/OJfuOo3G80cIxglrcDuN3+wTWG8ZUI6sk4m
         D/nlOyaWk7Wf5iLpYKtWsQXoh2ed2l4Indn4+Zcj47y4QOeIrzW97uL0nrXCBLjW+cjF
         lFJvgv9gbiBo/+ZUravHB8nc7e081ykBBbvWKop/7k0x20mBnrbbrvOZvRIcOCfqeZWI
         F9pnm6zo/HFw88QOzi41NVqVMTTiWie/Bih8+yQzSE500ZuMd+YOrPjKHRGkUbo6K67M
         kzzA==
X-Gm-Message-State: AOJu0Yxy7tJ8R+VTo9PjPOB7jxl/Fj0YCm3aQ4kQQqBCCGPb40IGofzJ
	MhnrbJD9IH84ys2Y/6Lgy7VsYeo2MrVWAwbbAqQVr8wHiuczy93UYw2gPP/z0pvK9k8NwPV1mYZ
	tPG968A==
X-Google-Smtp-Source: AGHT+IGiumDXxsvYIccaz3gyylhqySyEc2Gp6C4lsSrfI9fwfZwbahfbAwRGdXwWOlR7Ts4vtw193bh3ieUX
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7732:d863:503:f53d])
 (user=irogers job=sendgmr) by 2002:a05:690c:f8d:b0:5ff:b07b:fb83 with SMTP id
 df13-20020a05690c0f8d00b005ffb07bfb83mr1162438ywb.4.1706917278493; Fri, 02
 Feb 2024 15:41:18 -0800 (PST)
Date: Fri,  2 Feb 2024 15:40:53 -0800
In-Reply-To: <20240202234057.2085863-1-irogers@google.com>
Message-Id: <20240202234057.2085863-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240202234057.2085863-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Subject: [PATCH v3 4/8] perf intel-pt/intel-bts: Switch perf_cpu_map__has_any_cpu_or_is_empty
 use
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@arm.com>, 
	Leo Yan <leo.yan@linaro.org>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, 
	"=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>, Kan Liang <kan.liang@linux.intel.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Atish Patra <atishp@rivosinc.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, Changbin Du <changbin.du@huawei.com>, 
	Sandipan Das <sandipan.das@amd.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Paran Lee <p4ranlee@gmail.com>, Nick Desaulniers <ndesaulniers@google.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Yanteng Si <siyanteng@loongson.cn>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Switch perf_cpu_map__has_any_cpu_or_is_empty to
perf_cpu_map__is_any_cpu_or_is_empty as a CPU map may contain CPUs as
well as the dummy event and perf_cpu_map__is_any_cpu_or_is_empty is a
more correct alternative.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/util/intel-bts.c |  4 ++--
 tools/perf/arch/x86/util/intel-pt.c  | 10 +++++-----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/perf/arch/x86/util/intel-bts.c b/tools/perf/arch/x86/util/intel-bts.c
index af8ae4647585..34696f3d3d5d 100644
--- a/tools/perf/arch/x86/util/intel-bts.c
+++ b/tools/perf/arch/x86/util/intel-bts.c
@@ -143,7 +143,7 @@ static int intel_bts_recording_options(struct auxtrace_record *itr,
 	if (!opts->full_auxtrace)
 		return 0;
 
-	if (opts->full_auxtrace && !perf_cpu_map__has_any_cpu_or_is_empty(cpus)) {
+	if (opts->full_auxtrace && !perf_cpu_map__is_any_cpu_or_is_empty(cpus)) {
 		pr_err(INTEL_BTS_PMU_NAME " does not support per-cpu recording\n");
 		return -EINVAL;
 	}
@@ -224,7 +224,7 @@ static int intel_bts_recording_options(struct auxtrace_record *itr,
 		 * In the case of per-cpu mmaps, we need the CPU on the
 		 * AUX event.
 		 */
-		if (!perf_cpu_map__has_any_cpu_or_is_empty(cpus))
+		if (!perf_cpu_map__is_any_cpu_or_is_empty(cpus))
 			evsel__set_sample_bit(intel_bts_evsel, CPU);
 	}
 
diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index d199619df3ab..6de7e2d21075 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -369,7 +369,7 @@ static int intel_pt_info_fill(struct auxtrace_record *itr,
 			ui__warning("Intel Processor Trace: TSC not available\n");
 	}
 
-	per_cpu_mmaps = !perf_cpu_map__has_any_cpu_or_is_empty(session->evlist->core.user_requested_cpus);
+	per_cpu_mmaps = !perf_cpu_map__is_any_cpu_or_is_empty(session->evlist->core.user_requested_cpus);
 
 	auxtrace_info->type = PERF_AUXTRACE_INTEL_PT;
 	auxtrace_info->priv[INTEL_PT_PMU_TYPE] = intel_pt_pmu->type;
@@ -774,7 +774,7 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
 	 * Per-cpu recording needs sched_switch events to distinguish different
 	 * threads.
 	 */
-	if (have_timing_info && !perf_cpu_map__has_any_cpu_or_is_empty(cpus) &&
+	if (have_timing_info && !perf_cpu_map__is_any_cpu_or_is_empty(cpus) &&
 	    !record_opts__no_switch_events(opts)) {
 		if (perf_can_record_switch_events()) {
 			bool cpu_wide = !target__none(&opts->target) &&
@@ -832,7 +832,7 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
 		 * In the case of per-cpu mmaps, we need the CPU on the
 		 * AUX event.
 		 */
-		if (!perf_cpu_map__has_any_cpu_or_is_empty(cpus))
+		if (!perf_cpu_map__is_any_cpu_or_is_empty(cpus))
 			evsel__set_sample_bit(intel_pt_evsel, CPU);
 	}
 
@@ -858,7 +858,7 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
 			tracking_evsel->immediate = true;
 
 		/* In per-cpu case, always need the time of mmap events etc */
-		if (!perf_cpu_map__has_any_cpu_or_is_empty(cpus)) {
+		if (!perf_cpu_map__is_any_cpu_or_is_empty(cpus)) {
 			evsel__set_sample_bit(tracking_evsel, TIME);
 			/* And the CPU for switch events */
 			evsel__set_sample_bit(tracking_evsel, CPU);
@@ -870,7 +870,7 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
 	 * Warn the user when we do not have enough information to decode i.e.
 	 * per-cpu with no sched_switch (except workload-only).
 	 */
-	if (!ptr->have_sched_switch && !perf_cpu_map__has_any_cpu_or_is_empty(cpus) &&
+	if (!ptr->have_sched_switch && !perf_cpu_map__is_any_cpu_or_is_empty(cpus) &&
 	    !target__none(&opts->target) &&
 	    !intel_pt_evsel->core.attr.exclude_user)
 		ui__warning("Intel Processor Trace decoding will not be possible except for kernel tracing!\n");
-- 
2.43.0.594.gd9cf4e227d-goog


