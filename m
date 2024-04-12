Return-Path: <linux-kernel+bounces-142142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FBC8A2803
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDEAF1F23840
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC8C4B5CD;
	Fri, 12 Apr 2024 07:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KnRGj1vW"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9580F2C683
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 07:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712907015; cv=none; b=LP6Pj8pJHEACegATqDUxPbdRg0dZHiCI4hrkV99aWrsPWHFqZRSXblXwddnnt8zR+6hLOKY73+j0kiFpq9XA4YPdLF+KirkEQ0xD4VO4H6KiwZBKqX9ClEeb7NPlIaUtgvGBsqoOw5OUpovE/PKVRsaiMzSV8eDtKwTxrlZgBj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712907015; c=relaxed/simple;
	bh=5IO2NWCfpwWUyQ+ol8AQkFUqjjfRfj2qsguHSgUuUXs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dGKH0c54r5qlfyh+yQUrc3Soh9Z1FT43lRBA7u6Cx7KZHm04uCdCHTRouh/qyvjXZu9kMu6QSDMIiVxO3PXmO77MttOAM4m6ANdWeJWTecgl+HmR2yfjPNLatynZznZk9lJgXS6Buee2xfBwn9nrl8WVdDuvGXswXLABHUhoGd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KnRGj1vW; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712907014; x=1744443014;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=5IO2NWCfpwWUyQ+ol8AQkFUqjjfRfj2qsguHSgUuUXs=;
  b=KnRGj1vWhBkoVbopT071pnOb3xuqC5OLqMncpGYE03VaOrB/wPpPz1gz
   VcQ6e+hu64T14GrE4xJfVsYOmwnM3eaPeiI/14zFdxOzyUbpXP13OPuXm
   5ZJ4wFFMdFx2ZWduYBHfaFfLhCAABU9vND22+QoFflHw2jQxMNX2VrdKP
   EdFmsBPMXej+BnxexJZOaEWjm0yBh+Xi//LcPQKxRCEgOOBOyLF7zxDpk
   EYW3I6jhcdXkUODD22l0H6FPBDwHQH8snuWgZ5ca0Lp3cBQpEwxQSCIRb
   4AzdDx+fbpKfHo+GHmvteDgdVU289nGmry9Rbxa+0JBflLGvC/xk9hko5
   g==;
X-CSE-ConnectionGUID: 4zOPTKPRTxiISEwScTkk4g==
X-CSE-MsgGUID: vQmIGvzCQVeF4Tex1ARv0A==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="33748861"
X-IronPort-AV: E=Sophos;i="6.07,195,1708416000"; 
   d="scan'208";a="33748861"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 00:30:13 -0700
X-CSE-ConnectionGUID: 1qZw1JxBROSAf6QteJnCEw==
X-CSE-MsgGUID: oSajzwv7R5GU1hSfdxDTNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,195,1708416000"; 
   d="scan'208";a="52123263"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 00:30:10 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Bharata B Rao <bharata@amd.com>
Cc: <linux-mm@kvack.org>,  <linux-kernel@vger.kernel.org>,
  <akpm@linux-foundation.org>,  <mingo@redhat.com>,
  <peterz@infradead.org>,  <mgorman@techsingularity.net>,
  <raghavendra.kt@amd.com>,  <dave.hansen@linux.intel.com>,
  <hannes@cmpxchg.org>
Subject: Re: [RFC PATCH 0/2] Hot page promotion optimization for large
 address space
In-Reply-To: <8692d514-d1c8-4fbf-84d7-1ad609480070@amd.com> (Bharata B. Rao's
	message of "Fri, 12 Apr 2024 09:30:45 +0530")
References: <20240327160237.2355-1-bharata@amd.com>
	<87il16lxzl.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<dd2bc563-7654-4d83-896e-49a7291dd1aa@amd.com>
	<87edbulwom.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<929b22ca-bb51-4307-855f-9b4ae0a102e3@amd.com>
	<875xx5lu05.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<7e373c71-b2dc-4ae4-9746-c840f2a513a5@amd.com>
	<87o7asfrm1.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<9ec3b04b-bde8-42ce-be1b-34f7d8e6762d@amd.com>
	<87il0yet4z.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<8692d514-d1c8-4fbf-84d7-1ad609480070@amd.com>
Date: Fri, 12 Apr 2024 15:28:16 +0800
Message-ID: <87cyqv59bj.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Bharata B Rao <bharata@amd.com> writes:

> On 03-Apr-24 2:10 PM, Huang, Ying wrote:
>> Bharata B Rao <bharata@amd.com> writes:
>> 
>>> On 02-Apr-24 7:33 AM, Huang, Ying wrote:
>>>> Bharata B Rao <bharata@amd.com> writes:
>>>>
>>>>> On 29-Mar-24 6:44 AM, Huang, Ying wrote:
>>>>>> Bharata B Rao <bharata@amd.com> writes:
>>>>> <snip>
>>>>>>> I don't think the pages are cold but rather the existing mechanism fails
>>>>>>> to categorize them as hot. This is because the pages were scanned way
>>>>>>> before the accesses start happening. When repeated accesses are made to
>>>>>>> a chunk of memory that has been scanned a while back, none of those
>>>>>>> accesses get classified as hot because the scan time is way behind
>>>>>>> the current access time. That's the reason we are seeing the value
>>>>>>> of latency ranging from 20s to 630s as shown above.
>>>>>>
>>>>>> If repeated accesses continue, the page will be identified as hot when
>>>>>> it is scanned next time even if we don't expand the threshold range.  If
>>>>>> the repeated accesses only last very short time, it makes little sense
>>>>>> to identify the pages as hot.  Right?
>>>>>
>>>>> The total allocated memory here is 192G and the chunk size is 1G. Each
>>>>> time one such 1G chunk is taken up randomly for generating memory accesses.
>>>>> Within that 1G, 262144 random accesses are performed and 262144 such
>>>>> accesses are repeated for 512 times. I thought that should be enough
>>>>> to classify that chunk of memory as hot.
>>>>
>>>> IIUC, some pages are accessed in very short time (maybe within 1ms).
>>>> This isn't repeated access in a long period.  I think that pages
>>>> accessed repeatedly in a long period are good candidates for promoting.
>>>> But pages accessed frequently in only very short time aren't.
>>>
>>> Here are the numbers for the 192nd chunk:
>>>
>>> Each iteration of 262144 random accesses takes around ~10ms
>>> 512 such iterations are taking ~5s
>>> numa_scan_seq is 16 when this chunk is accessed.
>>> And no page promotions were done from this chunk. All the
>>> time should_numa_migrate_memory() found the NUMA hint fault
>>> latency to be higher than threshold.
>>>
>>> Are these time periods considered too short for the pages
>>> to be detected as hot and promoted?
>> 
>> Yes.  I think so.  This is burst accessing, not repeated accessing.
>> IIUC, NUMA balancing based promotion only works for repeated accessing
>> for long time, for example, >100s.
>
> Hmm... When a page is accessed 512 times over a period of 5s and it is
> still not detected as hot. This is understandable if fresh scanning couldn't
> be done as the accesses were bursty and hence they couldn't be captured via
> NUMA hint faults. But here the access captured via hint fault is being rejected
> as not hot because the scanning was done a while back. But I do see the challenge
> here since we depend on scanning time to obtain the frequency-of-access metric.

Consider some pages that will be accessed once every 1 hour, should we
consider it hot or not?  Will your proposed method deal with that
correctly?

> BTW, for the above same scenario with numa_balancing_mode=1, the remote
> accesses get detected and migration to source node is tried. It is a different
> matter that eventually pages can't be migrated in this specific scenario as
> the src node is already full.

--
Best Regards,
Huang, Ying

