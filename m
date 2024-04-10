Return-Path: <linux-kernel+bounces-137807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B60089E7E8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 03:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54506B227D0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 01:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9880C8BE7;
	Wed, 10 Apr 2024 01:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VGYQNmAm"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C711748E
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 01:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712713517; cv=none; b=YbJ6QJL2XdCOLMUiD7DeXRfsEH7Wsv2EM50/oLEAMhy1CbzGYEJVGsje8vn/JhArTV8uQyz1tv618Zab5DJXdV1moohwf7IwBdn3aogZze94eUwmY1xmLTv0N4ZCzgHPIunNmwWa0KATO7N/di/RahV1Rg/txAZKp3we8VhH46A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712713517; c=relaxed/simple;
	bh=osvrbCNuDRWKD92JOCAWlIMjnGqLdxkwqulOcDIj/R0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IOuHXklU/u48O/RlA4dNt5ux9c1jQk7r6SDm3SaWGVKOQ27Gw6+1L881zNgemc7AIezoYBISw/VP+gaARKoSSddlkXqSRBH3F7rHbj9XPq+yaXXOtPtpgPDU5Qn+W4Nnng1J11MZsbRAZmeQeFA25k78gVVixAQvgVoPieRvqI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VGYQNmAm; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712713516; x=1744249516;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=osvrbCNuDRWKD92JOCAWlIMjnGqLdxkwqulOcDIj/R0=;
  b=VGYQNmAmXbvZ+oxhIyajNuZkgoRVJZgdOlu+bZdYJoAvbGFC6jhnZ+xc
   5FXMgIEclNNUWY5qcKkiuCFzSbd42a2xw1kKMIUsG/G8OjlP70LtIhR/d
   tVILEIQDEiJ1TrTzt9AYb4u1P+czGGdynGUzJXRysp7kNoHB2EOiQE/TB
   nC1yPLs8sY2IJOEkKzjTpBp3765j+Gp8HpI49ZKA/9kJ+70tEt8cegnmW
   KM/s5nxAqlAklLfqxWdThPL1rLHjzCDiRdJl1G73CVTeRmUGbfBI62Y8q
   CTaRh5EvGssnz3ONBEafdCFScOMCyf3gkgd0aTepTy2AJ2fV+hYjVjKC0
   A==;
X-CSE-ConnectionGUID: iGGTpbYtT/O+xYghYrgDkQ==
X-CSE-MsgGUID: z9nz2hL2RMqT1QX4wuL5DQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8234897"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="8234897"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 18:45:15 -0700
X-CSE-ConnectionGUID: 4NFpHTcJR3SFnN2FWJfyIg==
X-CSE-MsgGUID: He8+PYJaRxyFN6rRRn0/Hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="25012068"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 18:45:12 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Zhaoyu Liu <liuzhaoyu.zackary@bytedance.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,  ryncsn@gmail.com,
  nphamcs@gmail.com,  songmuchun@bytedance.com,  david@redhat.com,
  chrisl@kernel.org,  guo.ziliang@zte.com.cn,  yosryahmed@google.com,
  linux-kernel@vger.kernel.org,  linux-mm@kvack.org
Subject: Re: [PATCH v2] mm: swap: prejudgement swap_has_cache to avoid page
 allocation
In-Reply-To: <20240409144132.GA542987@bytedance> (Zhaoyu Liu's message of
	"Tue, 9 Apr 2024 22:41:32 +0800")
References: <20240408121439.GA252652@bytedance>
	<20240408132704.f966adc8d3928df4d3b8c0a9@linux-foundation.org>
	<20240409144132.GA542987@bytedance>
Date: Wed, 10 Apr 2024 09:43:19 +0800
Message-ID: <87bk6i6lhk.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Zhaoyu Liu <liuzhaoyu.zackary@bytedance.com> writes:

> On Mon, Apr 08, 2024 at 01:27:04PM -0700, Andrew Morton wrote:
>> On Mon, 8 Apr 2024 20:14:39 +0800 Zhaoyu Liu <liuzhaoyu.zackary@bytedance.com> wrote:
>> 
>> > Based on qemu arm64 - latest kernel + 100M memory + 1024M swapfile.
>> > Create 1G anon mmap and set it to shared, and has two processes
>> > randomly access the shared memory. When they are racing on swap cache,
>> > on average, each "alloc_pages_mpol + swapcache_prepare + folio_put"
>> > took about 1475 us.
>> 
>> And what effect does this patch have upon the measured time?  ANd upon
>> overall runtime?
>
> Hi Andrew,
>
> When share memory between two or more processes has swapped and pagefault now,
> it would readahead swap and call __read_swap_cache_async().
> If one of the processes calls swapcache_prepare() and finds that the cache 
> has been EXIST(another process added), it will folio_put on the basis of the 
> alloc_pages_mpol() that has been called, and then try filemap_get_folio() again.
>
> I think the page alloc in this process is wasteful.
> when the memory pressure is large, alloc_pages_mpol() will be time-consuming, 
> so the purpose of my patch is to judge whether the page has cache before page alloc, 
> then skip page alloc and retry filemap_get_folio() to save the time of the function.

Please prove your theory with data, better with benchmark score.

--
Best Regards,
Huang, Ying

>> 
>> > So skip page allocation if SWAP_HAS_CACHE was set, just
>> > schedule_timeout_uninterruptible and continue to acquire page
>> > via filemap_get_folio() from swap cache, to speedup
>> > __read_swap_cache_async.

