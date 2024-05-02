Return-Path: <linux-kernel+bounces-166813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9938B9FE0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 19:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B0C61F22460
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 17:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561FB171081;
	Thu,  2 May 2024 17:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i/kZG/R/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBFE16FF44;
	Thu,  2 May 2024 17:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714672662; cv=none; b=EPMbT6Iq48duban5m0jOFgGyMzCoWQZ8MQZMVnpXix8MIC56xx4epq+DQmMb6KBBf5kGqUDW5eob4oLgWQwreylNNZIHdcWY4Xx4QNnL81gSM/MqCU/nZeOsicBWInT4ni5nDle2Wh4NMUdzp6XnJhfW9qetLYlwTe1j0ZGOFq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714672662; c=relaxed/simple;
	bh=SprQzZ+S9ZE0ocMgFX+Om3A97tqY8iIu2YvgwbQYV+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fMkSPG1Z36PihjPxITNXaH5xZDEnVjI6630dm+Xkl50YjWhA+VZYUKTIqsO/RSKKl1CJmUDZHMbc6QFcbNnvLeHPh/uIpHQOYTDs511ogwIpJBy4dONywzgoD+QVuX2q5gCSMCdbvdZzmiG+FFqEyDx5Uqdd+bD7F+uOoYah1eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i/kZG/R/; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714672661; x=1746208661;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=SprQzZ+S9ZE0ocMgFX+Om3A97tqY8iIu2YvgwbQYV+U=;
  b=i/kZG/R/M+fhBFq5OSDOXTcY1w0o6Iv/Op5wu3Kcae6i4xkuqaMR3XBQ
   3XH0tHjlpw6Tegf5OIzJP44bQb//xAcRIezrr/upqsX46p7VQOL4URHyW
   oNlc+pUWb7fddDa+H03oQOQMDX27Wc8QrTsh+uef3sW5KJss0Iya5RSC+
   ehWKYOEKuiHcNRTwDCOFhSCtZckuaX71IsX7dmaykMj8M+0W4MUb77yN6
   k8NFDvG8f0KoRV5a2ZDCNnhsMnJR8SpCP0HD4lHLsKO6lo36q3rgNQXUX
   PIOYrtZalykYbvbv+pGii6oZFWae/GMNDFR+jp4m59N0SgcqJsRkcehKD
   w==;
X-CSE-ConnectionGUID: NECZizo9TAif3hE1PRbVCg==
X-CSE-MsgGUID: XxenbgaoS6ucLTfNqkgTVQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11062"; a="21011706"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="21011706"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 10:57:40 -0700
X-CSE-ConnectionGUID: q2hgHsGtSOSZ1Vz8eTTrMQ==
X-CSE-MsgGUID: msCKMrMXSWahigYm4SqnhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="31869275"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 10:57:40 -0700
Received: from [10.213.161.211] (kliang2-mobl1.ccr.corp.intel.com [10.213.161.211])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id D841220B5739;
	Thu,  2 May 2024 10:57:37 -0700 (PDT)
Message-ID: <487907c6-3c77-410a-aabd-201273110e1a@linux.intel.com>
Date: Thu, 2 May 2024 13:57:36 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/6] perf test pmu: Add an eagerly loaded event test
To: Ian Rogers <irogers@google.com>, Thomas Richter <tmricht@linux.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>,
 Jing Zhang <renyu.zj@linux.alibaba.com>, James Clark <james.clark@arm.com>,
 Ravi Bangoria <ravi.bangoria@amd.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
References: <20240502040112.2111157-1-irogers@google.com>
 <20240502040112.2111157-5-irogers@google.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240502040112.2111157-5-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024-05-02 12:01 a.m., Ian Rogers wrote:
> Allow events/aliases to be eagerly loaded for a PMU. Factor out the
> pmu_aliases_parse to allow this. Parse a test event and check it
> configures the attribute as expected. There is overlap with the
> parse-events tests, but this test is done with a PMU created in a temp
> directory and doesn't rely on PMUs in sysfs.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/pmu.c | 77 ++++++++++++++++++++++++++++++++++++++++++
>  tools/perf/util/pmu.c  | 69 +++++++++++++++++++++++++------------
>  2 files changed, 125 insertions(+), 21 deletions(-)
> 
> diff --git a/tools/perf/tests/pmu.c b/tools/perf/tests/pmu.c
> index 424ebdb0f09d..6e18a4c447ce 100644
> --- a/tools/perf/tests/pmu.c
> +++ b/tools/perf/tests/pmu.c
> @@ -1,4 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
> +#include "evlist.h"
> +#include "evsel.h"
>  #include "parse-events.h"
>  #include "pmu.h"
>  #include "tests.h"
> @@ -54,6 +56,9 @@ static struct perf_pmu *test_pmu_get(char *dir, size_t sz)
>  		{ "krava22", "config2:8,18,48,58\n", },
>  		{ "krava23", "config2:28-29,38\n", },
>  	};
> +	const char *test_event = "krava01=15,krava02=170,krava03=1,krava11=27,krava12=1,"
> +		"krava13=2,krava21=119,krava22=11,krava23=2\n";
> +
>  	char name[PATH_MAX];
>  	int dirfd, file;
>  	struct perf_pmu *pmu = NULL;
> @@ -116,6 +121,24 @@ static struct perf_pmu *test_pmu_get(char *dir, size_t sz)
>  		close(file);
>  	}
>  
> +	/* Create test event. */
> +	if (mkdirat(dirfd, "perf-pmu-test/events", 0755) < 0) {
> +		pr_err("Failed to mkdir PMU events directory\n");
> +		goto err_out;
> +	}
> +	file = openat(dirfd, "perf-pmu-test/events/test-event", O_WRONLY | O_CREAT, 0600);
> +	if (!file) {
> +		pr_err("Failed to open for writing file \"type\"\n");
> +		goto err_out;
> +	}
> +	len = strlen(test_event);
> +	if (write(file, test_event, len) < len) {
> +		close(file);
> +		pr_err("Failed to write to 'test-event' file\n");
> +		goto err_out;
> +	}
> +	close(file);
> +
>  	/* Make the PMU reading the files created above. */
>  	pmu = perf_pmus__add_test_pmu(dirfd, "perf-pmu-test");
>  	if (!pmu)
> @@ -176,8 +199,62 @@ static int test__pmu_format(struct test_suite *test __maybe_unused, int subtest
>  	return ret;
>  }
>  
> +static int test__pmu_events(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
> +{
> +	char dir[PATH_MAX];
> +	struct parse_events_error err;
> +	struct evlist *evlist;
> +	struct evsel *evsel;
> +	struct perf_event_attr *attr;
> +	int ret;
> +	struct perf_pmu *pmu = test_pmu_get(dir, sizeof(dir));
> +	const char *event = "perf-pmu-test/test-event/";
> +
> +
> +	if (!pmu)
> +		return TEST_FAIL;
> +
> +	evlist = evlist__new();
> +	if (evlist == NULL) {
> +		pr_err("Failed allocation");
> +		goto err_out;
> +	}
> +	parse_events_error__init(&err);
> +	ret = parse_events(evlist, event, &err);
> +	if (ret) {
> +		pr_debug("failed to parse event '%s', err %d\n", event, ret);
> +		parse_events_error__print(&err, event);
> +		ret = TEST_FAIL;
> +		if (parse_events_error__contains(&err, "can't access trace events"))
> +			ret = TEST_SKIP;
> +		goto err_out;
> +	}
> +	evsel = evlist__first(evlist);
> +	attr = &evsel->core.attr;
> +	if (attr->config  != 0xc00000000002a823) {
> +		pr_err("Unexpected config value %llx\n", attr->config);
> +		goto err_out;
> +	}
> +	if (attr->config1 != 0x8000400000000145) {
> +		pr_err("Unexpected config1 value %llx\n", attr->config1);
> +		goto err_out;
> +	}
> +	if (attr->config2 != 0x0400000020041d07) {
> +		pr_err("Unexpected config2 value %llx\n", attr->config2);
> +		goto err_out;
> +	}
> +
> +	ret = TEST_OK;
> +err_out:
> +	parse_events_error__exit(&err);
> +	evlist__delete(evlist);
> +	test_pmu_put(dir, pmu);
> +	return ret;

Got a warning when I compile the patch.

tests/pmu.c: In function ‘test__pmu_events’:
tests/pmu.c:257:16: error: ‘ret’ may be used uninitialized in this
function [-Werror=maybe-uninitialized]
  257 |         return ret;
      |                ^~~

Thanks,
Kan

> +}
> +
>  static struct test_case tests__pmu[] = {
>  	TEST_CASE("Parsing with PMU format directory", pmu_format),
> +	TEST_CASE("Parsing with PMU event", pmu_events),
>  	{	.name = NULL, }
>  };
>  
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index fbbc535ed93f..7849be4bfea1 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -597,33 +597,18 @@ static inline bool pmu_alias_info_file(const char *name)
>   * Reading the pmu event aliases definition, which should be located at:
>   * /sys/bus/event_source/devices/<dev>/events as sysfs group attributes.
>   */
> -static int pmu_aliases_parse(struct perf_pmu *pmu)
> +static int __pmu_aliases_parse(struct perf_pmu *pmu, int events_dir_fd)
>  {
> -	char path[PATH_MAX];
>  	struct dirent *evt_ent;
>  	DIR *event_dir;
> -	size_t len;
> -	int fd, dir_fd;
>  
> -	len = perf_pmu__event_source_devices_scnprintf(path, sizeof(path));
> -	if (!len)
> -		return 0;
> -	scnprintf(path + len, sizeof(path) - len, "%s/events", pmu->name);
> -
> -	dir_fd = open(path, O_DIRECTORY);
> -	if (dir_fd == -1) {
> -		pmu->sysfs_aliases_loaded = true;
> -		return 0;
> -	}
> -
> -	event_dir = fdopendir(dir_fd);
> -	if (!event_dir){
> -		close (dir_fd);
> +	event_dir = fdopendir(events_dir_fd);
> +	if (!event_dir)
>  		return -EINVAL;
> -	}
>  
>  	while ((evt_ent = readdir(event_dir))) {
>  		char *name = evt_ent->d_name;
> +		int fd;
>  		FILE *file;
>  
>  		if (!strcmp(name, ".") || !strcmp(name, ".."))
> @@ -635,7 +620,7 @@ static int pmu_aliases_parse(struct perf_pmu *pmu)
>  		if (pmu_alias_info_file(name))
>  			continue;
>  
> -		fd = openat(dir_fd, name, O_RDONLY);
> +		fd = openat(events_dir_fd, name, O_RDONLY);
>  		if (fd == -1) {
>  			pr_debug("Cannot open %s\n", name);
>  			continue;
> @@ -653,11 +638,50 @@ static int pmu_aliases_parse(struct perf_pmu *pmu)
>  	}
>  
>  	closedir(event_dir);
> -	close (dir_fd);
>  	pmu->sysfs_aliases_loaded = true;
>  	return 0;
>  }
>  
> +static int pmu_aliases_parse(struct perf_pmu *pmu)
> +{
> +	char path[PATH_MAX];
> +	size_t len;
> +	int events_dir_fd, ret;
> +
> +	if (pmu->sysfs_aliases_loaded)
> +		return 0;
> +
> +	len = perf_pmu__event_source_devices_scnprintf(path, sizeof(path));
> +	if (!len)
> +		return 0;
> +	scnprintf(path + len, sizeof(path) - len, "%s/events", pmu->name);
> +
> +	events_dir_fd = open(path, O_DIRECTORY);
> +	if (events_dir_fd == -1) {
> +		pmu->sysfs_aliases_loaded = true;
> +		return 0;
> +	}
> +	ret = __pmu_aliases_parse(pmu, events_dir_fd);
> +	close(events_dir_fd);
> +	return ret;
> +}
> +
> +static int pmu_aliases_parse_eager(struct perf_pmu *pmu, int sysfs_fd)
> +{
> +	char path[FILENAME_MAX + 7];
> +	int ret, events_dir_fd;
> +
> +	scnprintf(path, sizeof(path), "%s/events", pmu->name);
> +	events_dir_fd = openat(sysfs_fd, path, O_DIRECTORY, 0);
> +	if (events_dir_fd == -1) {
> +		pmu->sysfs_aliases_loaded = true;
> +		return 0;
> +	}
> +	ret = __pmu_aliases_parse(pmu, events_dir_fd);
> +	close(events_dir_fd);
> +	return ret;
> +}
> +
>  static int pmu_alias_terms(struct perf_pmu_alias *alias, int err_loc, struct list_head *terms)
>  {
>  	struct parse_events_term *term, *cloned;
> @@ -1042,6 +1066,9 @@ struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char
>  
>  	perf_pmu__arch_init(pmu);
>  
> +	if (eager_load)
> +		pmu_aliases_parse_eager(pmu, dirfd);
> +
>  	return pmu;
>  err:
>  	zfree(&pmu->name);

