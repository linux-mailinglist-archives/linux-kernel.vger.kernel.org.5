Return-Path: <linux-kernel+bounces-150398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 884FE8A9E83
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CE87283B3E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0720816D322;
	Thu, 18 Apr 2024 15:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FB+qG7eR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B66B3B18D;
	Thu, 18 Apr 2024 15:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713454517; cv=none; b=KwoM3cD/EqOwrx9wp9mzh3l7N1M51xbm2fdeKYix67zOkdVETvpS4Q/HNAR2kHWZ/FO91VEr5MrbjF85ye6PXnzvmJfkvM24KvnyE/khFwutTK6jN+Ut/Qu+f68I3RNKV9L9FP7KB/8xkZGkc6nt6OLItFxk9NbvEa+dIP62WMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713454517; c=relaxed/simple;
	bh=OXoMHYERL63GkJ/oIQoh4RY1yeo5XbdvZz9GQ/ui6CM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=N4mvV1e4UNOPm9aLKxh+Tdj2o7V3EOznL/sbxK/pgvWWVkcMDgWFVLzYtqUFFT29sNDGmdPH3fCoNwy4FM8xAj8IztYRVvAOwVYHGpxIKv+7RytCHHYsUSri+epObam3x/FLWsuwq6PWMg+anyH0QbZOn+OLechnDHdINRnZTOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FB+qG7eR; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713454514; x=1744990514;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=OXoMHYERL63GkJ/oIQoh4RY1yeo5XbdvZz9GQ/ui6CM=;
  b=FB+qG7eRwTSwAAA2rPKZGuTny+eCN/fswyIXKyIcgyE1V2scA9KrQI+B
   yDrmwjfIU5R9/beH/GElZPNDSD65rx1f8YE70aslj5E1YWIQfrtmwafTM
   s1KS5pJNkz4EN1iye2V7JC/bwUr2/mt9B2f/EEV8ASCOzpxTljLoFNdg9
   U7w0mdUccZ4I3dJTGl+BunSeHd74JQBEwZms8qYP/xJYzF+Mk0TkLHKo5
   aRzOKGu935YYDVr26O/zouEER8q5sVnZ70AxD9iQdYfPO3J52yEfs83uG
   pXS5YKHCyKbY473UHEgheBua3sWDtJBFSSgdFtpmQaRgq6LVoMAN1aXvv
   g==;
X-CSE-ConnectionGUID: A/zIIgX4RtKRD4VUwENocw==
X-CSE-MsgGUID: HisK9yvzQtWNYU0g9ZuICw==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="8874990"
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="8874990"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 08:35:14 -0700
X-CSE-ConnectionGUID: lRs5YyPKQ/S0K/pEzpp3yQ==
X-CSE-MsgGUID: cM21zVMpSWurulbX493h9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="54207050"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 08:35:14 -0700
Received: from [10.213.167.231] (kliang2-mobl1.ccr.corp.intel.com [10.213.167.231])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id D2871206DFDC;
	Thu, 18 Apr 2024 08:35:12 -0700 (PDT)
Message-ID: <550e5ca5-f28c-48e1-b86e-9de3458a5737@linux.intel.com>
Date: Thu, 18 Apr 2024 11:35:11 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1] perf pmu: Assume sysfs events are always lowercase
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 James Clark <james.clark@arm.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240413040812.4042051-1-irogers@google.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240413040812.4042051-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-04-13 12:08 a.m., Ian Rogers wrote:
> Perf event names aren't case sensitive. For sysfs events the entire
> directory of events is read then iterated comparing names in a case
> insensitive way, most often to see if an event is present.
> 
> Consider:
> $ perf stat -e inst_retired.any true
> 
> The event inst_retired.any may be present in any PMU, so every PMU's
> sysfs events are loaded and then searched with strcasecmp to see if
> any match. This event is only present on the cpu PMU as a json event
> so a lot of events were loaded from sysfs unnecessarily just to prove
> an event didn't exist there.
> 
> This change avoids loading all the events by assuming sysfs event
> names are always lowercase. 

From what I searched in the kernel, it looks like all the sysfs event
names (from different ARCHs and devices) are lowercase. It should not
break the existing usages.
I don't see a reason why a event name must be uppercase.
However, I think we need to add something to guarantee the assumption.

Could you please update the doc to describe the assumption?
Documentation/ABI/testing/sysfs-bus-event_source-devices-events
So everybody can follow the rule.

I think a perf test is required as well.
Maybe we can extend the test__pmu_events() to do the name check.

Thanks,
Kan

> It then uses file exists and only loads
> the events when the desired event is present.
> 
> For the example above, the number of openat calls measured by perf
> trace on a tigerlake laptop goes from 325 down to 255. The reduction
> will be larger for machines with many PMUs, particularly replicated
> uncore PMUs.
> 
> Make pmu_aliases_parse early return when aliases are loaded, ensure
> the function is called before all uses of the aliases list.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/pmu.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index ab30f22eaf10..ce72c99e4f61 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -425,9 +425,16 @@ static struct perf_pmu_alias *perf_pmu__find_alias(struct perf_pmu *pmu,
>  {
>  	struct perf_pmu_alias *alias;
>  
> -	if (load && !pmu->sysfs_aliases_loaded)
> -		pmu_aliases_parse(pmu);
> +	if (load && !pmu->sysfs_aliases_loaded) {
> +		char event_file_name[FILENAME_MAX + 8];
>  
> +		scnprintf(event_file_name, sizeof(event_file_name), "events/%s", name);
> +		for (size_t i = 7, n = 7 + strlen(name); i < n; i++)
> +			event_file_name[i] = tolower(event_file_name[i]);
> +
> +		if (perf_pmu__file_exists(pmu, event_file_name))
> +			pmu_aliases_parse(pmu);
> +	}
>  	list_for_each_entry(alias, &pmu->aliases, list) {
>  		if (!strcasecmp(alias->name, name))
>  			return alias;
> @@ -605,6 +612,9 @@ static int pmu_aliases_parse(struct perf_pmu *pmu)
>  	size_t len;
>  	int fd, dir_fd;
>  
> +	if (pmu->sysfs_aliases_loaded)
> +		return 0;
> +
>  	len = perf_pmu__event_source_devices_scnprintf(path, sizeof(path));
>  	if (!len)
>  		return 0;
> @@ -1689,9 +1699,7 @@ size_t perf_pmu__num_events(struct perf_pmu *pmu)
>  {
>  	size_t nr;
>  
> -	if (!pmu->sysfs_aliases_loaded)
> -		pmu_aliases_parse(pmu);
> -
> +	pmu_aliases_parse(pmu);
>  	nr = pmu->sysfs_aliases;
>  
>  	if (pmu->cpu_aliases_added)
> @@ -1750,6 +1758,7 @@ int perf_pmu__for_each_event(struct perf_pmu *pmu, bool skip_duplicate_pmus,
>  	struct strbuf sb;
>  
>  	strbuf_init(&sb, /*hint=*/ 0);
> +	pmu_aliases_parse(pmu);
>  	pmu_add_cpu_aliases(pmu);
>  	list_for_each_entry(event, &pmu->aliases, list) {
>  		size_t buf_used;
> @@ -2154,6 +2163,7 @@ const char *perf_pmu__name_from_config(struct perf_pmu *pmu, u64 config)
>  	if (!pmu)
>  		return NULL;
>  
> +	pmu_aliases_parse(pmu);
>  	pmu_add_cpu_aliases(pmu);
>  	list_for_each_entry(event, &pmu->aliases, list) {
>  		struct perf_event_attr attr = {.config = 0,};

