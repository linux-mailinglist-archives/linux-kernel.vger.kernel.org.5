Return-Path: <linux-kernel+bounces-133183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D5689A00D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEB3228639E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD0E16F83C;
	Fri,  5 Apr 2024 14:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jve8rFce"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73A816F29E;
	Fri,  5 Apr 2024 14:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712328261; cv=none; b=kM/Jg+wFmsMDSQs+HTvF45zLUfvLjIe5xx7J0CmmdJFAt6XZUJwkfyVoZMAUUUhtoGFDYAlES1fUwcduO/MTXBGeZsREAaHU5z7Z6I4+cl5nKdvQV8em6Oz3qTTINwE+N8s8RkXa2QIRKRQc2zdz0zNGVDnXXPmif2G9COGMfk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712328261; c=relaxed/simple;
	bh=CAyHlUs2ev3tUcrdo88yULEMEOcnykuyEUdGLYSM6cI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oG58cdHw2zbjgnKro6kmJzn8wGMQRPiMGCHS8kqjuLKw59qg51XtnUSAcU3QyoD6unK/d+p/H8UwjxyYVRDXwTEAo7VRnSySkkVZSfzX9iPcdlXXCI6W2SIz7+qs8Gx8v3s0tiRiHR+mL8+FUJ1DNE6Dl2BcM3aAnL6YfkyWvbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jve8rFce; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712328260; x=1743864260;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CAyHlUs2ev3tUcrdo88yULEMEOcnykuyEUdGLYSM6cI=;
  b=jve8rFce6upbqPJ2glbygq6vYRF2d8IsGzn76eaRS4m7xZlx7y60QlDE
   kOddr9ZpW8u2xRh6VJjSmeolxPmQV3rwlPswtV5DLoGBzSNCwBVMRk4vQ
   UKMOcdl4S6GhnNV8/j+ziVc/tF7/1rm2UO6hkHL0fPpwcZItUI6tquKNN
   zfVu6QzWvzPwDE88QDKsC6a6AJVu3cmNyUJd1Qt37ijBkKEDIxzJDkCGx
   2Wsko906mxSuZ1LgwxIFIcyWVmiX7iOqyYdjmH1IDmb4mUjPp3a+MdGWr
   y4lfkqE3M1XxlZSj9VoCd61ZVR6TNW2zfuyUSQHmUEbc/eXcNe6UM/PSF
   g==;
X-CSE-ConnectionGUID: EXBJp9aQQkCo1VL09yFtbA==
X-CSE-MsgGUID: C56rm5NzQCu6S389hU1XxA==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="11435402"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="11435402"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 07:44:19 -0700
X-CSE-ConnectionGUID: EzPOniCoTqu9sKJVyurs2Q==
X-CSE-MsgGUID: gB8upR5uRm2zboAN/BlNSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="19628576"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 07:44:19 -0700
Received: from [10.213.182.74] (kliang2-mobl1.ccr.corp.intel.com [10.213.182.74])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 0963420C0655;
	Fri,  5 Apr 2024 07:44:16 -0700 (PDT)
Message-ID: <54fff9e6-3e88-438a-a944-8668149e5157@linux.intel.com>
Date: Fri, 5 Apr 2024 10:44:12 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf metrics: Remove the "No_group" metric group
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andi Kleen <ak@linux.intel.com>
References: <20240403164636.3429091-1-irogers@google.com>
 <dcb0121f-611d-4104-80b9-941d535c5fd2@linux.intel.com>
 <CAP-5=fUgiafmLEKEUJ5r5_tK+jqv30P0TGFCMvR8DkW7J4qYsQ@mail.gmail.com>
 <b9868e97-e353-45e0-83b7-aa28bc35dd67@linux.intel.com>
 <CAP-5=fX+YuEgD4pF-2YRcqgD2cwLw_7Z4ak+wszctvagPS+Xbw@mail.gmail.com>
 <ceca5922-6b83-464f-9e64-e8999068f734@linux.intel.com>
 <CAP-5=fUA_SZVHtO82pUgL+MT0XQFVyuLw=Sd_s10W-XvcNqaDQ@mail.gmail.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fUA_SZVHtO82pUgL+MT0XQFVyuLw=Sd_s10W-XvcNqaDQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024-04-04 9:16 p.m., Ian Rogers wrote:
> On Thu, Apr 4, 2024 at 1:29 PM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>
>>
>>
>> On 2024-04-03 4:26 p.m., Ian Rogers wrote:
>>> On Wed, Apr 3, 2024 at 11:57 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>>>
>>>>
>>>>
>>>> On 2024-04-03 2:31 p.m., Ian Rogers wrote:
>>>>> On Wed, Apr 3, 2024 at 10:59 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 2024-04-03 12:46 p.m., Ian Rogers wrote:
>>>>>>> Rather than place metrics without a metric group in "No_group" place
>>>>>>> them in a a metric group that is their name. Still allow such metrics
>>>>>>> to be selected if "No_group" is passed, this change just impacts perf
>>>>>>> list.
>>>>>>
>>>>>> So it looks like the "No_group" is not completely removed.
>>>>>> They are just not seen in the perf list, but users can still use it via
>>>>>> perf stat -M No_group, right?
>>>>>>
>>>>>> If so, why we want to remove it from perf list? Where can the end user
>>>>>> know which metrics are included in the No_group?
>>>>>>
>>>>>> If the No_group is useless, why not completely remove it?
>>>>>
>>>>> Agreed. For command line argument deprecation we usually keep the
>>>>> option but hide it from help with PARSE_OPT_HIDDEN, so I was trying to
>>>>> follow that pattern albeit that a metric group isn't a command line
>>>>> option it's an option to an option.
>>>>>
>>>>
>>>> Perf list has a deprecated option to show the deprecated events.
>>>> The "No_group" should be a deprecated metrics group.
>>>>
>>>> If so, to follow the same pattern, I think perf list should still
>>>> display the "No_group" with the --deprecated option at least.
>>>
>>> Such metrics would be shown twice, once under No_group and once under
>>> a metric group of their name.
>> You mean with the --deprecated option?
>> Yes, that's because the old/deprecated metrics group (No_group) is not
>> complete removed. So both the new name and old/deprecated name are shown
>> with the --deprecated option. The metrics which belong to both groups
>> will be shown twice.
>>
>> Without the --deprecated option, only the new group and its members are
>> shown.
>>
>>> With deprecated events this isn't the
>>> case, you can only see them with --deprecated. Given we can see the
>>> metric without the No_group grouping, what is being added by having a
>>> No_group grouping? It feels entirely redundant and something we don't
>>> need to advertise.
>>
>> I just want to have a generic pattern for deprecating a metrics/metrics
>> group that everybody can follow.
> 
> Currently there is no concept of a metric group in the json except for
> descriptions. Metrics and events share the same encoding, and the
> deprecated flag belongs to the event.
> 
>> I treat the "No_group" as a normal metrics group name. So this patch is
>> to introduce a new name, and hide the old name. Both new and old names
>> can still be used.
> 
> Why are you using No_group? I stand firm that it has no real use.
> 
>> If it's for a deprecated event, the expectation is to only see the new
>> name by default, and see both new name and old name with the
>> --deprecated option.
>>
>> Now, if it's a generic deprecated metrics group, what's the expected
>> behavior? I prefer to follow the same pattern as a deprecated event.
>> If we do so, yes, there will be some redundancy with the --deprecated
>> option, since some members may belong to both old and new groups.
>> But I don't think it's an issue. It's normal that metrics belong to
>> different groups.
> 
> What you are requesting here isn't something that is unreasonable, it
> is just something unconnected with this change and requires a
> reorganization of the json to facilitate. As such I consider it to be
> something for follow up work.
> 
> I think if we're going to restructure metric groups it would be nice
> to add a more tree-like structure which could be used to visualize
> metrics better. For example here:
> https://lore.kernel.org/lkml/20240314055919.1979781-11-irogers@google.com/
> the metrics could be shown under a tree like:
> ldst
>  - ldst_total
>    - ldst_total_loads
>  - ldst_prcnt
>    - ldst_prcnt_loads
>    - ldst_prcnt_stores
>  - ldst_ret_lds
>    - ldst_ret_lds_1
>    - ldst_ret_lds_2
>    - ldst_ret_lds_3
>  - ldst_ret_sts
>    - ldst_ret_sts_1
>    - ldst_ret_sts_2
>    - ldst_ret_sts_3
>  - ldst_ld_hit_swpf
>  - ldst_atomic_lds
>

Yes, a tree-like output looks much better.


> but again it is follow up work to do this. In this change I just
> wanted a way to list all sensibly grouped metrics or metrics in a
> group just on their own which doesn't require some kind of analysis of
> metric groups. No_group has no use so let's just get rid of it.
> 

I agree that there should be no one to use the No_group. Just hide it
should be fine. Maybe we can have further discussion when someday we try
to deprecate a meaningful metrics/metrics group.

Thanks,
Kan

