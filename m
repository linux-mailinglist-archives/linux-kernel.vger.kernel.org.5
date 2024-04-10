Return-Path: <linux-kernel+bounces-137788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E90989E7A3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 03:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32CBC284157
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 01:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4EA524C;
	Wed, 10 Apr 2024 01:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HPmLMzBb"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4DCA5F
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 01:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712711632; cv=none; b=sRCu5muiHRiFT1v1jHwC0Ok7p2Dwijm/IzINc7ECsRbl1aYyVmD/ynxI7SOomQELbJXW2ctbTl3UMAhlN8LkOIIQmQhOZimMSmZ+Sxo2eWC50S4UM3cVm5JhPhPw1bm5LNFFhedLSKPzPQlDtyFpKHegmmEH3myzN15MlDx/F+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712711632; c=relaxed/simple;
	bh=3gZCR/oI52h5oQWn/HwEs5tiS4Zkp/wa/QiF4W4R/qM=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=lDLCDht3M4fLg+AQPjp7qRFigcJc8XX3Eoge+oyg9ZwWi4Gf60xrwt03dj+BCMKeykPom6jwlWZn3ZQNTMpwo7jUxgUIs2yx7L4EQze06r/TAK0s/QBoW6+ZTjR63BjVkfW5trtL8K9mvff9mvi2id+7w1WrU3MwoXD8X/UcX4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HPmLMzBb; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dced704f17cso10808131276.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 18:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712711629; x=1713316429; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1cn09GYr5ta/Z+upjf7mxVRyOt2fkI4BgGzEZQrJxdg=;
        b=HPmLMzBbITQdJqBLtK3zeM5Ut90LU8zVllLcZ+7QJUOUFBLiEWUzGcS7a2vUpcJhh2
         dZdMnwU3Y4OLo2kB+R9q5w0pCv0DLOrqmy4TxnXJa4EQExK+6kPAgSXTONnXkAGjmcvU
         kAItwzSW4YR6y0r77d67a92jyIcvGPpUTq3phFJoL1LsAK3VZWBHki8iYcfalQxmjS3t
         HKTaeYL0sNnTU8z6f15E6C99MjST3GT1DxVOUlpGeJpb53wNHDblLEXi/hg6O+/8CvL5
         KnTrQdYlrIp5xY41f/1Htpk+GZRjExSjVdRUpbDtGo2w8Sbe1vxFlxd8Keo243tRZTIY
         xAzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712711629; x=1713316429;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1cn09GYr5ta/Z+upjf7mxVRyOt2fkI4BgGzEZQrJxdg=;
        b=WF7lrFB1xNGU+QlEVmmyCHxk1vKhQ5JUVF/dQhbmIArpgz4S8Mo1zmkJB7PFKaYRAF
         FW7LrVOXqTFUSE+6GjwH3H4pGbkDeNCcIt0OhiH/eTDSTklSjMSkjsBeCaxcmS1HaFU7
         sCbZa81D8MQiwZH+/m+hHwXoDEzbSaKbUaoe16nD8v0rivz/6GTNb/osmiWSeeYfd9m3
         qRE/Fmzz3iM2YkOQ/4cL6BpgQY0vGVYBP6dnfIIN5Utz+Jxgpo9jddWOT5dOOpp/b92h
         9r9/MGKEMLc0a7IzAR/JT+IK7NCSfUh48xb3jXXlP7yneb88DdC/b8cq8EbfiDO+Soe+
         616A==
X-Forwarded-Encrypted: i=1; AJvYcCXpR7OQ80cSOATEmZIIz25G90i4MaxXLMFmt2AKzWvvHOkZBjXXZVQS23135SBac0j/S+HBEoXBIyR0VYuuceM0KLqrRKzu+nPeWe75
X-Gm-Message-State: AOJu0YzpjlRKuxTzXBXlrSS6qUXTBce9tlm4DoEOOBqy0huWHaFV5lk5
	c5OYJtgNgStXgcolkgv3KpXtb9Lkkk5euRv3+mowUuqUO88/YaywzGWNSqtAykYD3tblsUnQu2d
	nBU66fQ==
X-Google-Smtp-Source: AGHT+IF3vVs0WTI0FKPFI7X5BHCZFvn1C4F3fCW2CxNBg+rtZ0F7OpXEraenZ1kq02SwwGiFkVUbeIiRvbvR
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:18c5:d9c6:d1d6:a3ec])
 (user=irogers job=sendgmr) by 2002:a05:6902:10c3:b0:de1:21b4:76a5 with SMTP
 id w3-20020a05690210c300b00de121b476a5mr116447ybu.13.1712711629664; Tue, 09
 Apr 2024 18:13:49 -0700 (PDT)
Date: Tue,  9 Apr 2024 18:13:13 -0700
In-Reply-To: <20240410011313.2556848-1-irogers@google.com>
Message-Id: <20240410011313.2556848-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240410011313.2556848-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Subject: [PATCH v2 2/2] perf tests: Add a pmus core functionality test suite
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>, James Clark <james.clark@arm.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Bharat Bhushan <bbhushan2@marvell.com>, Bhaskara Budiredla <bbudiredla@marvell.com>, 
	Will Deacon <will@kernel.org>, Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

Test behavior of PMU names and comparisons wrt suffixes using Intel
uncore_cha and marvell mrvl_ddr_pmu as examples.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/Build          |   1 +
 tools/perf/tests/builtin-test.c |   1 +
 tools/perf/tests/pmus.c         | 108 ++++++++++++++++++++++++++++++++
 tools/perf/tests/tests.h        |   2 +
 4 files changed, 112 insertions(+)
 create mode 100644 tools/perf/tests/pmus.c

diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index c7f9d9676095..a7bab6e9300f 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -14,6 +14,7 @@ perf-y += perf-record.o
 perf-y += evsel-roundtrip-name.o
 perf-$(CONFIG_LIBTRACEEVENT) += evsel-tp-sched.o
 perf-y += fdarray.o
+perf-y += pmus.o
 perf-y += pmu.o
 perf-y += pmu-events.o
 perf-y += hists_common.o
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index d13ee7683d9d..c90f270a469a 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -68,6 +68,7 @@ static struct test_suite *generic_tests[] = {
 	&suite__parse_events,
 	&suite__expr,
 	&suite__PERF_RECORD,
+	&suite__pmus,
 	&suite__pmu,
 	&suite__pmu_events,
 	&suite__dso_data,
diff --git a/tools/perf/tests/pmus.c b/tools/perf/tests/pmus.c
new file mode 100644
index 000000000000..6279c925e689
--- /dev/null
+++ b/tools/perf/tests/pmus.c
@@ -0,0 +1,108 @@
+// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+#include "pmus.h"
+#include "tests.h"
+#include <string.h>
+#include <linux/kernel.h>
+
+static const char * const uncore_chas[] = {
+	"uncore_cha_0",
+	"uncore_cha_1",
+	"uncore_cha_2",
+	"uncore_cha_3",
+	"uncore_cha_4",
+	"uncore_cha_5",
+	"uncore_cha_6",
+	"uncore_cha_7",
+	"uncore_cha_8",
+	"uncore_cha_9",
+	"uncore_cha_10",
+	"uncore_cha_11",
+	"uncore_cha_12",
+	"uncore_cha_13",
+	"uncore_cha_14",
+	"uncore_cha_15",
+	"uncore_cha_16",
+	"uncore_cha_17",
+	"uncore_cha_18",
+	"uncore_cha_19",
+	"uncore_cha_20",
+	"uncore_cha_21",
+	"uncore_cha_22",
+	"uncore_cha_23",
+	"uncore_cha_24",
+	"uncore_cha_25",
+	"uncore_cha_26",
+	"uncore_cha_27",
+	"uncore_cha_28",
+	"uncore_cha_29",
+	"uncore_cha_30",
+	"uncore_cha_31",
+};
+
+static const char * const mrvl_ddrs[] = {
+	"mrvl_ddr_pmu_87e1b0000000",
+	"mrvl_ddr_pmu_87e1b1000000",
+	"mrvl_ddr_pmu_87e1b2000000",
+	"mrvl_ddr_pmu_87e1b3000000",
+	"mrvl_ddr_pmu_87e1b4000000",
+	"mrvl_ddr_pmu_87e1b5000000",
+	"mrvl_ddr_pmu_87e1b6000000",
+	"mrvl_ddr_pmu_87e1b7000000",
+	"mrvl_ddr_pmu_87e1b8000000",
+	"mrvl_ddr_pmu_87e1b9000000",
+	"mrvl_ddr_pmu_87e1ba000000",
+	"mrvl_ddr_pmu_87e1bb000000",
+	"mrvl_ddr_pmu_87e1bc000000",
+	"mrvl_ddr_pmu_87e1bd000000",
+	"mrvl_ddr_pmu_87e1be000000",
+	"mrvl_ddr_pmu_87e1bf000000",
+};
+
+static int test__name_len(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
+{
+	TEST_ASSERT_EQUAL("cpu", pmu_name_len_no_suffix("cpu"), (int)strlen("cpu"));
+	TEST_ASSERT_EQUAL("i915", pmu_name_len_no_suffix("i915"), (int)strlen("i915"));
+	for (size_t i = 0; i < ARRAY_SIZE(uncore_chas); i++) {
+		TEST_ASSERT_EQUAL("Strips uncore_cha suffix",
+				pmu_name_len_no_suffix(uncore_chas[i]),
+				(int)strlen("uncore_cha"));
+	}
+	for (size_t i = 0; i < ARRAY_SIZE(mrvl_ddrs); i++) {
+		TEST_ASSERT_EQUAL("Strips mrvl_ddr_pmu suffix",
+				pmu_name_len_no_suffix(mrvl_ddrs[i]),
+				(int)strlen("mrvl_ddr_pmu"));
+	}
+	return TEST_OK;
+}
+
+static int test__name_cmp(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
+{
+	TEST_ASSERT_EQUAL("cpu", pmu_name_cmp("cpu", "cpu"), 0);
+	TEST_ASSERT_EQUAL("i915", pmu_name_cmp("i915", "i915"), 0);
+	TEST_ASSERT_VAL("i915", pmu_name_cmp("cpu", "i915") < 0);
+	TEST_ASSERT_VAL("i915", pmu_name_cmp("i915", "cpu") > 0);
+	for (size_t i = 1; i < ARRAY_SIZE(uncore_chas); i++) {
+		TEST_ASSERT_VAL("uncore_cha suffixes ordered lt",
+				pmu_name_cmp(uncore_chas[i-1], uncore_chas[i]) < 0);
+		TEST_ASSERT_VAL("uncore_cha suffixes ordered gt",
+				pmu_name_cmp(uncore_chas[i], uncore_chas[i-1]) > 0);
+	}
+	for (size_t i = 1; i < ARRAY_SIZE(mrvl_ddrs); i++) {
+		TEST_ASSERT_VAL("mrvl_ddr_pmu suffixes ordered lt",
+				pmu_name_cmp(mrvl_ddrs[i-1], mrvl_ddrs[i]) < 0);
+		TEST_ASSERT_VAL("mrvl_ddr_pmu suffixes ordered gt",
+				pmu_name_cmp(mrvl_ddrs[i], mrvl_ddrs[i-1]) > 0);
+	}
+	return TEST_OK;
+}
+
+static struct test_case tests__pmus[] = {
+	TEST_CASE("PMU name combining", name_len),
+	TEST_CASE("PMU name comparison", name_cmp),
+	{	.name = NULL, }
+};
+
+struct test_suite suite__pmus = {
+	.desc = "PMUs test",
+	.test_cases = tests__pmus,
+};
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 3aa7701ee0e9..03278f0f7698 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -3,6 +3,7 @@
 #define TESTS_H
 
 #include <stdbool.h>
+#include <debug.h>
 
 enum {
 	TEST_OK   =  0,
@@ -81,6 +82,7 @@ DECLARE_SUITE(PERF_RECORD);
 DECLARE_SUITE(perf_evsel__roundtrip_name_test);
 DECLARE_SUITE(perf_evsel__tp_sched_test);
 DECLARE_SUITE(syscall_openat_tp_fields);
+DECLARE_SUITE(pmus);
 DECLARE_SUITE(pmu);
 DECLARE_SUITE(pmu_events);
 DECLARE_SUITE(attr);
-- 
2.44.0.478.gd926399ef9-goog


