Return-Path: <linux-kernel+bounces-160459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 683AF8B3DC1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 19:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA80EB2164D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2743315D5A2;
	Fri, 26 Apr 2024 17:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nNtTyUIq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D392614535A;
	Fri, 26 Apr 2024 17:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714152131; cv=none; b=hIp0DUqyhcSluTS6n2p1OqPmAq+w1mA4Yj5CgGIf0KqlVtaQSfLZooCUT/1KddZAWBxrWlsIsD1wYdJePMwebL7t0RuA7N7Trpo2PXySnvo5lSWdtGoKEvJ4i3fJqKsUA0QX+LGcO82oN1hkbQ13lk9z2CxBaLyEH0j6XEoutJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714152131; c=relaxed/simple;
	bh=BWsnsw0Y2vYzWBVbJSlDfqZkcVg9U/T28RLM6RdsjlY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qs6JNZrFMa26QO3RPJSvo/6xkG9E7OruTpA0xoJAbt9NCDifCHB1ouctxS7IW66KUiRUTKBHd6fhCCzs4GLVaqf94rngr0HodFuBFoYoAcksqJO+2mZ3jHUZlkqtmHXhFFyGr2FwfSUSjlgk0yJEnu5r+XFBCmSGzqpuH9S51Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nNtTyUIq; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714152129; x=1745688129;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=BWsnsw0Y2vYzWBVbJSlDfqZkcVg9U/T28RLM6RdsjlY=;
  b=nNtTyUIqdWc618KxTKR81PwAp4o6PfYHG++3t+yApoxhdouPvfbRYDsj
   YM4astVr8iVPC5GrZ9Bg1afRDeXTKaxce+TdzzexhrY0bm1OW/UM6KH0e
   pkJxRvZga/Pe2uwTqfWA+wWUnOLKTnQ93wsuplSJgparnps7abi2tg5gu
   GRaoXwl7ZwoeA7RjONA2ZvJZBglEWU3AClEkPx7j/FXPWb38bqaOrF8/o
   d0+wdIJPQoC9NYjQcz+A/uGXh3b7VXJItXpDyzRJ5w5niOgMnJQ8dEGpi
   ZEOYG8whHJJEz7GYZY6PP+jGK+xk4GdvAfSV23rpjYShMTuMaMvObbU2o
   A==;
X-CSE-ConnectionGUID: zsqce/8RRpO4jMFd1kl2oA==
X-CSE-MsgGUID: vM2x273GT5SxvXPVHE9d+Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11056"; a="10059704"
X-IronPort-AV: E=Sophos;i="6.07,233,1708416000"; 
   d="scan'208";a="10059704"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 10:22:09 -0700
X-CSE-ConnectionGUID: BuvLi/vnQwqoMfUUeqh/IA==
X-CSE-MsgGUID: vIP5Ay7jTamKPKcYco2Sog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,233,1708416000"; 
   d="scan'208";a="25983330"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 10:22:09 -0700
Received: from [10.212.113.23] (kliang2-mobl1.ccr.corp.intel.com [10.212.113.23])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id E0F9F20B5739;
	Fri, 26 Apr 2024 10:22:06 -0700 (PDT)
Message-ID: <53dfaeae-b4eb-479e-938f-d0022c4f2416@linux.intel.com>
Date: Fri, 26 Apr 2024 13:22:05 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 0/3] Retirement latency perf stat support
To: Ian Rogers <irogers@google.com>, weilin.wang@intel.com,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Ze Gao <zegao2021@gmail.com>, Leo Yan <leo.yan@linux.dev>,
 Ravi Bangoria <ravi.bangoria@amd.com>, Dmitrii Dolgov
 <9erthalion6@gmail.com>, Song Liu <song@kernel.org>,
 James Clark <james.clark@arm.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240425223406.471120-1-irogers@google.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240425223406.471120-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-04-25 6:34 p.m., Ian Rogers wrote:
> Support 'R' as a retirement latency modifier on events. When present
> the evsel will fork perf record and perf report commands, parsing the
> perf report output as the count value. The intent is to do something
> similar to Weilin's series:
> https://lore.kernel.org/lkml/20240402214436.1409476-1-weilin.wang@intel.com/
> 
> While the 'R' and the retirement latency are Intel specific, in the
> future I can imagine more evsel like commands that require child
> processes. We can make the logic more generic at that point.
>

I think in generic what we want is the weight/latency information of the
event. 'W' is already occupied by the weak group. Maybe 'L' is a more
generic name than 'R'. With the event modifier, perf collects and report
the weight/latency information of the event in a perf stat command.

Not just changing the evsel, I think a proper output is still required.
It's possible that an end user can use it without metrics. E.g.,
perf stat -e cycles,instructions:L
A possible generic output maybe

1,931,099,931	cycles
  801,826,458	instructions	# Avg Weight1 1000
				# Avg Weight2 800
				# Avg Weight3 500

Thanks,
Kan

> The code is untested on hardware that supports retirement latency, and
> with metrics with retirement latency in them. The record is also of
> sleep and various things need tweaking but I think v1 is good enough
> for people to give input.
> 
> The first patch stops opening a dummy event for tool events. I came
> across this while looking into the issue and we can likely just pick
> it first. I kept it in the series for cleanliness sake.
> 
> The code has benefitted greatly from Weilin's work and Namhyung's
> great review input.
> 
> Ian Rogers (3):
>   perf evsel: Don't open tool events
>   perf parse-events: Add a retirement latency modifier
>   perf evsel: Add retirement latency event support
> 
>  tools/perf/util/evsel.c        | 186 ++++++++++++++++++++++++++++++++-
>  tools/perf/util/evsel.h        |   4 +
>  tools/perf/util/parse-events.c |   2 +
>  tools/perf/util/parse-events.h |   1 +
>  tools/perf/util/parse-events.l |   3 +-
>  5 files changed, 192 insertions(+), 4 deletions(-)
> 

