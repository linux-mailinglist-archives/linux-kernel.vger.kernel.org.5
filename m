Return-Path: <linux-kernel+bounces-129355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20515896906
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFDBF2858FC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5FD6DCE8;
	Wed,  3 Apr 2024 08:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RSmqzXjb"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F3F6CDB4
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 08:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712133748; cv=none; b=b58RqXG66ljRE8N7JN+FRcPbuxVbPgKMBhT/oxAi3nm/z4+7RWpbsKCj8kI8dBWg/wi1VUdO+SadVE4hXtsIL6nq9a29zodgOyOYy1IQ/RrgiosuR2PcUgAI8pXA8qYNQooUHGyb7gSDFqh3IK099+V2dnvZW13PNN1Qza4Rf2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712133748; c=relaxed/simple;
	bh=Yc/UxVgdcmJxp/86IHuzsAxrO66im/yKibWMN4SKocA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XJB0UgJ0cepI0zclE1UzOMj2gy27p3y4u00ExFJN4pNgQm7xwwKJ3g/jE/YXUOzN18fNnMuF7tZpK5MkZy7EFaarxuOxEoB4nLfR5fvHffVhtpWCWoWtAmpXkzcJCEyL98BMWlrkzjItne29lKyJ9XWrBtRgxUV6FzwPpGyiOjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RSmqzXjb; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712133746; x=1743669746;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=Yc/UxVgdcmJxp/86IHuzsAxrO66im/yKibWMN4SKocA=;
  b=RSmqzXjbpYHo6ynOZip6VXWMzvKaIJhN+LnxPH6NjVmytn6RFE1E8NPS
   VOomkc6lEd7sf7XMKA1trBENkPmtoSTKhWTXrM3TPDLRzAXq89jCWfEj0
   b5SYNnOKBOC0Tlp0v9EErITf7s0d5+OeJoqN/HdUvH0fdwO51nXH4FuSt
   VSG4Iy5rra1SqCGlpv7THRvtMpxU0UpYxBAiyl8pTYPkFGTnBoJ2pACwF
   zg2Va0lYWjvGpkRivoq2FZw9iw366rcox6S0hsyZPUp6lXt6wtGRPj5m3
   Xzd9AA3lM3cWB1+9iZ6u8BJNdkruC9geCBC6NLUPQ2XCztrrqV9lmGi7i
   Q==;
X-CSE-ConnectionGUID: +Q/Haxz+Sk+teiGRMbNDCg==
X-CSE-MsgGUID: 5FZeYTqST86SKrB1SY825g==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="24847904"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="24847904"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 01:42:24 -0700
X-CSE-ConnectionGUID: FrRS57trSh+Ovwk9SHtEBA==
X-CSE-MsgGUID: e7BMVgx9Q9ylI9EuWF6nMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="22993868"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 01:42:22 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Bharata B Rao <bharata@amd.com>
Cc: <linux-mm@kvack.org>,  <linux-kernel@vger.kernel.org>,
  <akpm@linux-foundation.org>,  <mingo@redhat.com>,
  <peterz@infradead.org>,  <mgorman@techsingularity.net>,
  <raghavendra.kt@amd.com>,  <dave.hansen@linux.intel.com>,
  <hannes@cmpxchg.org>
Subject: Re: [RFC PATCH 0/2] Hot page promotion optimization for large
 address space
In-Reply-To: <9ec3b04b-bde8-42ce-be1b-34f7d8e6762d@amd.com> (Bharata B. Rao's
	message of "Tue, 2 Apr 2024 14:56:37 +0530")
References: <20240327160237.2355-1-bharata@amd.com>
	<87il16lxzl.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<dd2bc563-7654-4d83-896e-49a7291dd1aa@amd.com>
	<87edbulwom.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<929b22ca-bb51-4307-855f-9b4ae0a102e3@amd.com>
	<875xx5lu05.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<7e373c71-b2dc-4ae4-9746-c840f2a513a5@amd.com>
	<87o7asfrm1.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<9ec3b04b-bde8-42ce-be1b-34f7d8e6762d@amd.com>
Date: Wed, 03 Apr 2024 16:40:28 +0800
Message-ID: <87il0yet4z.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Bharata B Rao <bharata@amd.com> writes:

> On 02-Apr-24 7:33 AM, Huang, Ying wrote:
>> Bharata B Rao <bharata@amd.com> writes:
>> 
>>> On 29-Mar-24 6:44 AM, Huang, Ying wrote:
>>>> Bharata B Rao <bharata@amd.com> writes:
>>> <snip>
>>>>> I don't think the pages are cold but rather the existing mechanism fails
>>>>> to categorize them as hot. This is because the pages were scanned way
>>>>> before the accesses start happening. When repeated accesses are made to
>>>>> a chunk of memory that has been scanned a while back, none of those
>>>>> accesses get classified as hot because the scan time is way behind
>>>>> the current access time. That's the reason we are seeing the value
>>>>> of latency ranging from 20s to 630s as shown above.
>>>>
>>>> If repeated accesses continue, the page will be identified as hot when
>>>> it is scanned next time even if we don't expand the threshold range.  If
>>>> the repeated accesses only last very short time, it makes little sense
>>>> to identify the pages as hot.  Right?
>>>
>>> The total allocated memory here is 192G and the chunk size is 1G. Each
>>> time one such 1G chunk is taken up randomly for generating memory accesses.
>>> Within that 1G, 262144 random accesses are performed and 262144 such
>>> accesses are repeated for 512 times. I thought that should be enough
>>> to classify that chunk of memory as hot.
>> 
>> IIUC, some pages are accessed in very short time (maybe within 1ms).
>> This isn't repeated access in a long period.  I think that pages
>> accessed repeatedly in a long period are good candidates for promoting.
>> But pages accessed frequently in only very short time aren't.
>
> Here are the numbers for the 192nd chunk:
>
> Each iteration of 262144 random accesses takes around ~10ms
> 512 such iterations are taking ~5s
> numa_scan_seq is 16 when this chunk is accessed.
> And no page promotions were done from this chunk. All the
> time should_numa_migrate_memory() found the NUMA hint fault
> latency to be higher than threshold.
>
> Are these time periods considered too short for the pages
> to be detected as hot and promoted?

Yes.  I think so.  This is burst accessing, not repeated accessing.
IIUC, NUMA balancing based promotion only works for repeated accessing
for long time, for example, >100s.

>> 
>>> But as we see, often times
>>> the scan time is lagging the access time by a large value.
>>>
>>> Let me instrument the code further to learn more insights (if possible)
>>> about the scanning/fault time behaviors here.
>>>
>>> Leaving the fault count based threshold apart, do you think there is
>>> value in updating the scan time for skipped pages/PTEs during every
>>> scan so that the scan time remains current for all the pages?
>> 
>> No, I don't think so.  That makes hint page fault latency more
>> inaccurate.
>
> For the case that I have shown, depending on a old value of scan
> time doesn't work well when pages get accessed after a long time
> since scanning. At least with the scheme I show in patch 2/2,
> probability of detecting pages as hot increases.

Yes.  This may help your cases, but it will hurt other cases with
incorrect hint page fault latency.

To resolve your issue, we can increase the max value of the hot
threshold automatically.  We can work on that if you can find a real
workload.

--
Best Regards,
Huang, Ying

