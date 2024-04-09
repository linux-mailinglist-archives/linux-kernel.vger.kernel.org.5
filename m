Return-Path: <linux-kernel+bounces-137200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BFD489DFCE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19016B2F376
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB5D136E0E;
	Tue,  9 Apr 2024 15:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QbnJfos7"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1555E12FB38;
	Tue,  9 Apr 2024 15:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712675831; cv=none; b=ByaoNGiZClAXLNve6TS1tzzAt2t45yVp3PT/uM7WRA+Kwi+f3eVtaQxgh2rU9HeN9+1j76Vxq5KyMPR5GutS0vAP82pl46djRSQ3GcTRhbwqGuck8qfRsEcPoHACiYckArySCho2RqvXsEwjscxXbT/qS9mJTkeBtGcykcDrYTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712675831; c=relaxed/simple;
	bh=nO2xEz94eyySiDVDjPua/I/JlddYyIk0FLPBx5lC0yM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jw4JkFFVPe1T65DEF0aEB63njLIaRV90b8J7/Zfa7ckzAf1+K7ySRm8icBpQozvkKuvyjv31573ojhUjsl75GWw3cgUHjGV1DGpGMCrpJBTrgfvrG7O5xSmq5CM0NP1iTDwDBmvjLWZSNb/ItNROxPA3uZAz3hO/YOrzbOYzorA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QbnJfos7; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712675829; x=1744211829;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nO2xEz94eyySiDVDjPua/I/JlddYyIk0FLPBx5lC0yM=;
  b=QbnJfos7q1PN+MWms5OC4QF6lAXOTn3RjuTu9jx8RPEz1uFfeZFmIDGZ
   Pq15BwZaDez9vDKPSknARsNubdiA7zn2txNaerMOvBAj0tzmgZRMhkgWw
   f8g83EXy0d5/try9o4YrO1zhH3Gigxaqaae4/9c/iUZoEXldzC/gUrSZX
   qb6bDbLDPj2PZb77x8RXjN+RknuY85t7rv0b0E2Ld9kl8hKYVpPhZ17SB
   wETHBYoZ04mpaS33A2fPpcfshO3vcizeqaJulCQLR23pb6fzsnwDycdBe
   cQKtlr//LJDHqy6rcMRiBzMQyvyejYwURI5KJxPIdyXZdJv2kcWYjPd4h
   Q==;
X-CSE-ConnectionGUID: PhKdaFzUTsOkTl8nHkDmfw==
X-CSE-MsgGUID: Fs9IXG4tTi2v0Kyk1A70OA==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="7855182"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="7855182"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 08:17:07 -0700
X-CSE-ConnectionGUID: p8J+lNgSQryUbdPraf0rNg==
X-CSE-MsgGUID: rsbE6wuGSKKGMff5oFZSpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="20374571"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 08:17:06 -0700
Received: from [10.213.177.168] (kliang2-mobl1.ccr.corp.intel.com [10.213.177.168])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 58E5B20B573A;
	Tue,  9 Apr 2024 08:17:04 -0700 (PDT)
Message-ID: <8a415ffe-af51-415e-816f-2d15d0654f7c@linux.intel.com>
Date: Tue, 9 Apr 2024 11:17:02 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf pmus: Sort/merge/aggregate PMUs like mrvl_ddr_pmu
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 James Clark <james.clark@arm.com>, John Garry <john.g.garry@oracle.com>,
 Ravi Bangoria <ravi.bangoria@amd.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Bharat Bhushan <bbhushan2@marvell.com>,
 Bhaskara Budiredla <bbudiredla@marvell.com>, Will Deacon <will@kernel.org>
Cc: Stephane Eranian <eranian@google.com>
References: <20240329064803.3058900-1-irogers@google.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240329064803.3058900-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-03-29 2:48 a.m., Ian Rogers wrote:
> The mrvl_ddr_pmu is uncore and has a hexadecimal address suffix while
> the previous PMU sorting/merging code assumes uncore PMU names start
> with uncore_ and have a decimal suffix. Because of the previous
> assumption it isn't possible to wildcard the mrvl_ddr_pmu.
> 
> Modify pmu_name_len_no_suffix but also remove the suffix number out
> argument, this is because we don't know if a suffix number of say 10
> is in hexadecimal or decimal. As the only use of the suffix number is
> in comparisons, it is safe there to compare the values as hexadecimal.
> 
> Add a set of PMUs tests for pmu_name_len_no_suffix and pmu_name_cmp.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/Build          |   1 +
>  tools/perf/tests/builtin-test.c |   1 +
>  tools/perf/tests/pmus.c         | 108 ++++++++++++++++++++++++++++++++
>  tools/perf/tests/tests.h        |   2 +
>  tools/perf/util/pmu.c           |   2 +-
>  tools/perf/util/pmus.c          |  51 ++++++++-------
>  tools/perf/util/pmus.h          |   7 ++-
>  7 files changed, 146 insertions(+), 26 deletions(-)
>  create mode 100644 tools/perf/tests/pmus.c

I think it's better to split the patch into two patches. One is to
update the interface. The other is to add a new test.

> 
> diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
> index c7f9d9676095..a7bab6e9300f 100644
> --- a/tools/perf/tests/Build
> +++ b/tools/perf/tests/Build
> @@ -14,6 +14,7 @@ perf-y += perf-record.o
>  perf-y += evsel-roundtrip-name.o
>  perf-$(CONFIG_LIBTRACEEVENT) += evsel-tp-sched.o
>  perf-y += fdarray.o
> +perf-y += pmus.o
>  perf-y += pmu.o
>  perf-y += pmu-events.o
>  perf-y += hists_common.o
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> index d13ee7683d9d..c90f270a469a 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -68,6 +68,7 @@ static struct test_suite *generic_tests[] = {
>  	&suite__parse_events,
>  	&suite__expr,
>  	&suite__PERF_RECORD,
> +	&suite__pmus,
>  	&suite__pmu,
>  	&suite__pmu_events,
>  	&suite__dso_data,
> diff --git a/tools/perf/tests/pmus.c b/tools/perf/tests/pmus.c
> new file mode 100644
> index 000000000000..6279c925e689
> --- /dev/null
> +++ b/tools/perf/tests/pmus.c
> @@ -0,0 +1,108 @@
> +// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> +#include "pmus.h"
> +#include "tests.h"
> +#include <string.h>
> +#include <linux/kernel.h>
> +
> +static const char * const uncore_chas[] = {
> +	"uncore_cha_0",
> +	"uncore_cha_1",
> +	"uncore_cha_2",
> +	"uncore_cha_3",
> +	"uncore_cha_4",
> +	"uncore_cha_5",
> +	"uncore_cha_6",
> +	"uncore_cha_7",
> +	"uncore_cha_8",
> +	"uncore_cha_9",
> +	"uncore_cha_10",
> +	"uncore_cha_11",
> +	"uncore_cha_12",
> +	"uncore_cha_13",
> +	"uncore_cha_14",
> +	"uncore_cha_15",
> +	"uncore_cha_16",
> +	"uncore_cha_17",
> +	"uncore_cha_18",
> +	"uncore_cha_19",
> +	"uncore_cha_20",
> +	"uncore_cha_21",
> +	"uncore_cha_22",
> +	"uncore_cha_23",
> +	"uncore_cha_24",
> +	"uncore_cha_25",
> +	"uncore_cha_26",
> +	"uncore_cha_27",
> +	"uncore_cha_28",
> +	"uncore_cha_29",
> +	"uncore_cha_30",
> +	"uncore_cha_31",
> +};
> +
> +static const char * const mrvl_ddrs[] = {
> +	"mrvl_ddr_pmu_87e1b0000000",
> +	"mrvl_ddr_pmu_87e1b1000000",
> +	"mrvl_ddr_pmu_87e1b2000000",
> +	"mrvl_ddr_pmu_87e1b3000000",
> +	"mrvl_ddr_pmu_87e1b4000000",
> +	"mrvl_ddr_pmu_87e1b5000000",
> +	"mrvl_ddr_pmu_87e1b6000000",
> +	"mrvl_ddr_pmu_87e1b7000000",
> +	"mrvl_ddr_pmu_87e1b8000000",
> +	"mrvl_ddr_pmu_87e1b9000000",
> +	"mrvl_ddr_pmu_87e1ba000000",
> +	"mrvl_ddr_pmu_87e1bb000000",
> +	"mrvl_ddr_pmu_87e1bc000000",
> +	"mrvl_ddr_pmu_87e1bd000000",
> +	"mrvl_ddr_pmu_87e1be000000",
> +	"mrvl_ddr_pmu_87e1bf000000",
> +};
> +
> +static int test__name_len(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
> +{
> +	TEST_ASSERT_EQUAL("cpu", pmu_name_len_no_suffix("cpu"), (int)strlen("cpu"));
> +	TEST_ASSERT_EQUAL("i915", pmu_name_len_no_suffix("i915"), (int)strlen("i915"));
> +	for (size_t i = 0; i < ARRAY_SIZE(uncore_chas); i++) {
> +		TEST_ASSERT_EQUAL("Strips uncore_cha suffix",
> +				pmu_name_len_no_suffix(uncore_chas[i]),
> +				(int)strlen("uncore_cha"));
> +	}
> +	for (size_t i = 0; i < ARRAY_SIZE(mrvl_ddrs); i++) {
> +		TEST_ASSERT_EQUAL("Strips mrvl_ddr_pmu suffix",
> +				pmu_name_len_no_suffix(mrvl_ddrs[i]),
> +				(int)strlen("mrvl_ddr_pmu"));
> +	}
> +	return TEST_OK;
> +}
> +
> +static int test__name_cmp(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
> +{
> +	TEST_ASSERT_EQUAL("cpu", pmu_name_cmp("cpu", "cpu"), 0);
> +	TEST_ASSERT_EQUAL("i915", pmu_name_cmp("i915", "i915"), 0);
> +	TEST_ASSERT_VAL("i915", pmu_name_cmp("cpu", "i915") < 0);
> +	TEST_ASSERT_VAL("i915", pmu_name_cmp("i915", "cpu") > 0);
> +	for (size_t i = 1; i < ARRAY_SIZE(uncore_chas); i++) {
> +		TEST_ASSERT_VAL("uncore_cha suffixes ordered lt",
> +				pmu_name_cmp(uncore_chas[i-1], uncore_chas[i]) < 0);
> +		TEST_ASSERT_VAL("uncore_cha suffixes ordered gt",
> +				pmu_name_cmp(uncore_chas[i], uncore_chas[i-1]) > 0);
> +	}
> +	for (size_t i = 1; i < ARRAY_SIZE(mrvl_ddrs); i++) {
> +		TEST_ASSERT_VAL("mrvl_ddr_pmu suffixes ordered lt",
> +				pmu_name_cmp(mrvl_ddrs[i-1], mrvl_ddrs[i]) < 0);
> +		TEST_ASSERT_VAL("mrvl_ddr_pmu suffixes ordered gt",
> +				pmu_name_cmp(mrvl_ddrs[i], mrvl_ddrs[i-1]) > 0);
> +	}
> +	return TEST_OK;
> +}
> +
> +static struct test_case tests__pmus[] = {
> +	TEST_CASE("PMU name combining", name_len),
> +	TEST_CASE("PMU name comparison", name_cmp),
> +	{	.name = NULL, }
> +};
> +
> +struct test_suite suite__pmus = {
> +	.desc = "PMUs test",
> +	.test_cases = tests__pmus,
> +};
> diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
> index 3aa7701ee0e9..03278f0f7698 100644
> --- a/tools/perf/tests/tests.h
> +++ b/tools/perf/tests/tests.h
> @@ -3,6 +3,7 @@
>  #define TESTS_H
>  
>  #include <stdbool.h>
> +#include <debug.h>
>  
>  enum {
>  	TEST_OK   =  0,
> @@ -81,6 +82,7 @@ DECLARE_SUITE(PERF_RECORD);
>  DECLARE_SUITE(perf_evsel__roundtrip_name_test);
>  DECLARE_SUITE(perf_evsel__tp_sched_test);
>  DECLARE_SUITE(syscall_openat_tp_fields);
> +DECLARE_SUITE(pmus);
>  DECLARE_SUITE(pmu);
>  DECLARE_SUITE(pmu_events);
>  DECLARE_SUITE(attr);
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index f39cbbc1a7ec..b0cca5841f90 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -1657,7 +1657,7 @@ static char *format_alias(char *buf, int len, const struct perf_pmu *pmu,
>  {
>  	struct parse_events_term *term;
>  	int pmu_name_len = skip_duplicate_pmus
> -		? pmu_name_len_no_suffix(pmu->name, /*num=*/NULL)
> +		? pmu_name_len_no_suffix(pmu->name)
>  		: (int)strlen(pmu->name);
>  	int used = snprintf(buf, len, "%.*s/%s", pmu_name_len, pmu->name, alias->name);
>  
> diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
> index 16505071d362..b4ddcd0ade26 100644
> --- a/tools/perf/util/pmus.c
> +++ b/tools/perf/util/pmus.c
> @@ -39,31 +39,44 @@ static bool read_sysfs_all_pmus;
>  
>  static void pmu_read_sysfs(bool core_only);
>  
> -int pmu_name_len_no_suffix(const char *str, unsigned long *num)
> +int pmu_name_len_no_suffix(const char *str)
>  {
>  	int orig_len, len;
>  
>  	orig_len = len = strlen(str);
>  
> -	/* Non-uncore PMUs have their full length, for example, i915. */
> -	if (!strstarts(str, "uncore_"))
> -		return len;
> -
>  	/*
>  	 * Count trailing digits and '_', if '_{num}' suffix isn't present use
>  	 * the full length.
>  	 */
> -	while (len > 0 && isdigit(str[len - 1]))
> +	while (len > 0 && isxdigit(str[len - 1]))
>  		len--;

The letter in the hex may be part of a PMU name.

Searched the kernel code and got this PMU name of s390.

	rc = perf_pmu_register(&cpumf_pmu, "cpum_cf", -1);

Such kinds of PMUs may have issues.

Thanks,
Kan
>  
> -	if (len > 0 && len != orig_len && str[len - 1] == '_') {
> -		if (num)
> -			*num = strtoul(&str[len], NULL, 10);
> +	if (len > 0 && len != orig_len && str[len - 1] == '_')
>  		return len - 1;
> -	}
> +
>  	return orig_len;
>  }
>  
> +int pmu_name_cmp(const char *lhs_pmu_name, const char *rhs_pmu_name)
> +{
> +	unsigned long lhs_num = 0, rhs_num = 0;
> +	int lhs_pmu_name_len = pmu_name_len_no_suffix(lhs_pmu_name);
> +	int rhs_pmu_name_len = pmu_name_len_no_suffix(rhs_pmu_name);
> +	int ret = strncmp(lhs_pmu_name, rhs_pmu_name,
> +			lhs_pmu_name_len < rhs_pmu_name_len ? lhs_pmu_name_len : rhs_pmu_name_len);
> +
> +	if (lhs_pmu_name_len != rhs_pmu_name_len || ret != 0 || lhs_pmu_name_len == 0)
> +		return ret;
> +
> +	if (lhs_pmu_name_len + 1 < (int)strlen(lhs_pmu_name))
> +		lhs_num = strtoul(&lhs_pmu_name[lhs_pmu_name_len + 1], NULL, 16);
> +	if (rhs_pmu_name_len + 1 < (int)strlen(rhs_pmu_name))
> +		rhs_num = strtoul(&rhs_pmu_name[rhs_pmu_name_len + 1], NULL, 16);
> +
> +	return lhs_num < rhs_num ? -1 : (lhs_num > rhs_num ? 1 : 0);
> +}
> +
>  void perf_pmus__destroy(void)
>  {
>  	struct perf_pmu *pmu, *tmp;
> @@ -164,20 +177,10 @@ static struct perf_pmu *perf_pmu__find2(int dirfd, const char *name)
>  static int pmus_cmp(void *priv __maybe_unused,
>  		    const struct list_head *lhs, const struct list_head *rhs)
>  {
> -	unsigned long lhs_num = 0, rhs_num = 0;
>  	struct perf_pmu *lhs_pmu = container_of(lhs, struct perf_pmu, list);
>  	struct perf_pmu *rhs_pmu = container_of(rhs, struct perf_pmu, list);
> -	const char *lhs_pmu_name = lhs_pmu->name ?: "";
> -	const char *rhs_pmu_name = rhs_pmu->name ?: "";
> -	int lhs_pmu_name_len = pmu_name_len_no_suffix(lhs_pmu_name, &lhs_num);
> -	int rhs_pmu_name_len = pmu_name_len_no_suffix(rhs_pmu_name, &rhs_num);
> -	int ret = strncmp(lhs_pmu_name, rhs_pmu_name,
> -			lhs_pmu_name_len < rhs_pmu_name_len ? lhs_pmu_name_len : rhs_pmu_name_len);
>  
> -	if (lhs_pmu_name_len != rhs_pmu_name_len || ret != 0 || lhs_pmu_name_len == 0)
> -		return ret;
> -
> -	return lhs_num < rhs_num ? -1 : (lhs_num > rhs_num ? 1 : 0);
> +	return pmu_name_cmp(lhs_pmu->name ?: "", rhs_pmu->name ?: "");
>  }
>  
>  /* Add all pmus in sysfs to pmu list: */
> @@ -297,11 +300,11 @@ static struct perf_pmu *perf_pmus__scan_skip_duplicates(struct perf_pmu *pmu)
>  		pmu_read_sysfs(/*core_only=*/false);
>  		pmu = list_prepare_entry(pmu, &core_pmus, list);
>  	} else
> -		last_pmu_name_len = pmu_name_len_no_suffix(pmu->name ?: "", NULL);
> +		last_pmu_name_len = pmu_name_len_no_suffix(pmu->name ?: "");
>  
>  	if (use_core_pmus) {
>  		list_for_each_entry_continue(pmu, &core_pmus, list) {
> -			int pmu_name_len = pmu_name_len_no_suffix(pmu->name ?: "", /*num=*/NULL);
> +			int pmu_name_len = pmu_name_len_no_suffix(pmu->name ?: "");
>  
>  			if (last_pmu_name_len == pmu_name_len &&
>  			    !strncmp(last_pmu_name, pmu->name ?: "", pmu_name_len))
> @@ -313,7 +316,7 @@ static struct perf_pmu *perf_pmus__scan_skip_duplicates(struct perf_pmu *pmu)
>  		pmu = list_prepare_entry(pmu, &other_pmus, list);
>  	}
>  	list_for_each_entry_continue(pmu, &other_pmus, list) {
> -		int pmu_name_len = pmu_name_len_no_suffix(pmu->name ?: "", /*num=*/NULL);
> +		int pmu_name_len = pmu_name_len_no_suffix(pmu->name ?: "");
>  
>  		if (last_pmu_name_len == pmu_name_len &&
>  		    !strncmp(last_pmu_name, pmu->name ?: "", pmu_name_len))
> diff --git a/tools/perf/util/pmus.h b/tools/perf/util/pmus.h
> index 94d2a08d894b..624c2d53fc30 100644
> --- a/tools/perf/util/pmus.h
> +++ b/tools/perf/util/pmus.h
> @@ -2,10 +2,15 @@
>  #ifndef __PMUS_H
>  #define __PMUS_H
>  
> +#include <stdbool.h>
> +#include <linux/list.h>
> +
>  struct perf_pmu;
>  struct print_callbacks;
>  
> -int pmu_name_len_no_suffix(const char *str, unsigned long *num);
> +int pmu_name_len_no_suffix(const char *str);
> +/* Exposed for testing only. */
> +int pmu_name_cmp(const char *lhs_pmu_name, const char *rhs_pmu_name);
>  
>  void perf_pmus__destroy(void);
>  

