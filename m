Return-Path: <linux-kernel+bounces-137284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1BA89DFE6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 18:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BD2C1C2255A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1CE813D896;
	Tue,  9 Apr 2024 16:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PNEw+AGn"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A89413D62D;
	Tue,  9 Apr 2024 16:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712678406; cv=none; b=S7PdB1U/Q/3b5tkSrLSeI9GNxA3Pg9ROCORHOBnj8WHw7OeRxFvuucFcL+KaRCzS33RqTUGbfI+KZ93gis/dUSi8f9FlFh5ZaM+Dr4TtxOT4LmQvXuoD4MrkvZyLhPR84UJoZ5kUWnCjaGzYMSoicdbPDYJklUGmrLg3hqr5FXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712678406; c=relaxed/simple;
	bh=rIWzdT2j4gehQmKiDXqvyQav5F7/1wQdzlMU+7jlznQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cQOPelajDvKGgw0hcm/SR6wL2w90CgmeG8GCt12lST3sOftC5RYatfvs5cKq121C5sIH4Ic+RbAiyvtSYmk9Dec5HHIo0ZgqjeTiXsXsGa7HsbLQaXPP6x0Pwc1plUxmdcdfn4JEqGcC6w2vdTHcOos4i21nnm0iyUwEzY8Lxh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PNEw+AGn; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712678406; x=1744214406;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rIWzdT2j4gehQmKiDXqvyQav5F7/1wQdzlMU+7jlznQ=;
  b=PNEw+AGnpFcAXoovRjxRum9zDXWtfeitS+8MxqavCSS7Vh7P7ZhahWB+
   wwsMuUb63mFPpVFFlBwkYj6YDcGBHZZJUrv0oECWz6chBHk4m/X+9WFms
   pNrrue9bQ5AmrkgxUZRbiRW6X0kl+5XjbdgeaPex2zHqhuFkbJYuEikJG
   PdkWU1/NJ9ikz2AXDj6kEy7vWO7CyDJEEV0s9IFcxmtyRxp58u2zT6B5u
   y6htl0DnFlAlxRLjE26mJRXISqjNTNp+AgNseTZqnBjOmamJzv4fuNuQD
   awkD6x1TIR5sx0FP4uKwb9IOSu7suo3vSohvf3VLQKjyGXVF1ggsHsWwD
   w==;
X-CSE-ConnectionGUID: 0wYVZehaTomYepUF19KPRA==
X-CSE-MsgGUID: 3shVNYVaQRWOakb1KEAQ0w==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="7863735"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="7863735"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 09:00:04 -0700
X-CSE-ConnectionGUID: z4eyAHqoQCe9DUtSSAZwgw==
X-CSE-MsgGUID: /o9RSYgNT8uvE5kzlekIZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="20704660"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 09:00:03 -0700
Received: from [10.213.177.168] (kliang2-mobl1.ccr.corp.intel.com [10.213.177.168])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 9DC7E20B573A;
	Tue,  9 Apr 2024 09:00:01 -0700 (PDT)
Message-ID: <cd4b5229-b938-44ef-822a-68d29c463aa7@linux.intel.com>
Date: Tue, 9 Apr 2024 12:00:00 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf stat: Remove evlist__add_default_attrs use
 strings
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 James Clark <james.clark@arm.com>, Yang Jihong <yangjihong1@huawei.com>,
 Kaige Ye <ye@kaige.org>, Yicong Yang <yangyicong@hisilicon.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240406073804.1932415-1-irogers@google.com>
 <0d498870-b235-4860-9563-befcddf0ec3e@linux.intel.com>
 <CAP-5=fU=bEvzWw+62HxL=5kOSqQxaBYeDBomv8Fdu+R+fNv5sw@mail.gmail.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fU=bEvzWw+62HxL=5kOSqQxaBYeDBomv8Fdu+R+fNv5sw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024-04-09 11:20 a.m., Ian Rogers wrote:
>>> +             ret = parse_events(evlist,
>>> +                             "context-switches,"
>>> +                             "cpu-migrations,"
>>> +                             "page-faults,"
>>> +                             "instructions,"
>>> +                             "cycles,"
>> "cycles",
>> "instructions",
>>
>> It's better to keep the original order.
> So the original order was:
> "cycles,"
> "stalled-cycles-frontend,"
> "stalled-cycles-backend,"
> "instructions"
>

Right. The stalled-* events are added between default_attrs0 and
default_attrs1.


> but many/most/all core PMUs don't provide the stalled-* events. At the
> programmer level instructions is the most fundamental thing, so having
> it last felt wrong hence moving it to be the first after the software
> events. My thought was, if we're going to reorder things then let's
> not do a half measure like:
> "cycles,"
> "instructions,"
> "stalled-cycles-frontend,"
> "stalled-cycles-backend"
> 
> let's just put things into their best order. It is obviously easy to
> change but having this way wasn't an accident. There's obviously
> subjectivity about whether cycles is more fundamental than
> instructions, my thought is that you get taught instructions first and
> that these take some number of cycles to execute, hence thinking
> instructions should have some priority in the output over cycles -
> some people may not even know what cycles means, it is hard enough
> when you do given the variety of different clocks 🙂
> 

My concern is that there may be someone who still relies on the std
output of perf stat default. So the output format/order matters for
them. Their scripts probably be broken if the order is changed.

Thanks,
Kan

