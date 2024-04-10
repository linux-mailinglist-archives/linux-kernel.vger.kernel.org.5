Return-Path: <linux-kernel+bounces-137809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4414089E7ED
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 03:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3229B219AF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 01:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5EF31FAA;
	Wed, 10 Apr 2024 01:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ldmlgJj+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9151F10F9
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 01:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712713659; cv=none; b=THBnBikq8BtolqOo0npf/Qn+mT3o+4RITdl8Gs3rcsbODLL/9ESkgc2zNL95mxSDm3+XRrQa5k/9o5m+afQ6ZJDYaHaPD+IMc2Ll4rDX1FfTo3uv82IS9pnsDxocWU6ABqRuP/lc9xh99Q1S2kCMAQvAyuxORFITvjYhe0yXoRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712713659; c=relaxed/simple;
	bh=31Y67G+Aev410Mx8rxxPpS/JtoU8Ta4nueJJC6BOPXA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aA9eWs1Ks7YjxdyYH2Goz2O9oPg3yNlJfVap2BLDMFW5ypeHNCLj0RyVdYkdgjlp9zy8mFkbtysdx/8cS0jp3SlzJrCnlj8jW5fef7POiUWBgMDgbwRAiFJDIjoiqngS02BQDvEb5kf5DIJJI/4SuGvmctpGledBKNYiALQ8tPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ldmlgJj+; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712713657; x=1744249657;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=31Y67G+Aev410Mx8rxxPpS/JtoU8Ta4nueJJC6BOPXA=;
  b=ldmlgJj+dW9O6cCI3LxG6oqLtxX8wnrOPMdTi+4EdCUEbmVXxRR1tsXv
   pxbXQyNj0NvU8WojRB2I0jMlBKP9B1mPhh2rFDjC/nodE/ndsQKmzWwyh
   0XzimyLwm+Gc9ndQ9pgmOmyPDKOliH7twt6XgyOZH5nhptBAuHFR21vfC
   zIJxeHZ6FhS81+ze48EG4tS0+f0zc1tg9BBU3+tRwhtzbbp1iCpOcZxNe
   SsEQiJztxYjgM5vCYIbWqCuFa5BICVspjkLI+5zLs6JyJQtqdfYgEHU+K
   J7j7zYsweAM5SpeRr5k8dSVGg4xIlpnxrVCBzpsUag+R1bM5V3ShpV5nT
   w==;
X-CSE-ConnectionGUID: YCHkgP9ETTO53BBF4m56nw==
X-CSE-MsgGUID: PCRwMFVARSu/R6UGx3ZGtA==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="25501081"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="25501081"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 18:47:37 -0700
X-CSE-ConnectionGUID: HfRY5yEVQFuIRxe1gVqu9Q==
X-CSE-MsgGUID: ZuSZB7FQSQyQKsmP6gNtRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="25197540"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 18:47:34 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Zhaoyu Liu <liuzhaoyu.zackary@bytedance.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,  ryncsn@gmail.com,
  nphamcs@gmail.com,  songmuchun@bytedance.com,  david@redhat.com,
  chrisl@kernel.org,  guo.ziliang@zte.com.cn,  yosryahmed@google.com,
  linux-kernel@vger.kernel.org,  linux-mm@kvack.org
Subject: Re: [PATCH v2] mm: swap: prejudgement swap_has_cache to avoid page
 allocation
In-Reply-To: <20240409145740.GA543696@bytedance> (Zhaoyu Liu's message of
	"Tue, 9 Apr 2024 22:57:40 +0800")
References: <20240408121439.GA252652@bytedance>
	<20240408132704.f966adc8d3928df4d3b8c0a9@linux-foundation.org>
	<87edbf8hta.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<20240409145740.GA543696@bytedance>
Date: Wed, 10 Apr 2024 09:45:41 +0800
Message-ID: <877ch66ldm.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Zhaoyu Liu <liuzhaoyu.zackary@bytedance.com> writes:

> On Tue, Apr 09, 2024 at 09:07:29AM +0800, Huang, Ying wrote:
>> Andrew Morton <akpm@linux-foundation.org> writes:
>> 
>> > On Mon, 8 Apr 2024 20:14:39 +0800 Zhaoyu Liu <liuzhaoyu.zackary@bytedance.com> wrote:
>> >
>> >> Based on qemu arm64 - latest kernel + 100M memory + 1024M swapfile.
>> >> Create 1G anon mmap and set it to shared, and has two processes
>> >> randomly access the shared memory. When they are racing on swap cache,
>> >> on average, each "alloc_pages_mpol + swapcache_prepare + folio_put"
>> >> took about 1475 us.
>> >
>> > And what effect does this patch have upon the measured time?  ANd upon
>> > overall runtime?
>> 
>> And the patch will cause increased lock contention, please test with
>> more processes and perhaps HDD swap device too.
>
> Hi Ying,
>
> Thank you for your suggestion.
> It may indeed cause some lock contention, as mentioned by Kairui before.
>
> If so, is it recommended?
> ---
>   unsigned char swap_map, mapcount, hascache;
>   ...
>   /* Return raw data of the si->swap_map[offset] */
>   swap_map = __swap_map(si, entry);
>   mapcount = swap_map & ~SWAP_HAS_CACHE;
>   if (!mapcount && swap_slot_cache_enabled)
>   ...
>   hascache = swap_map & SWAP_HAS_CACHE;
>   /* Could judge that it's being added to swap cache with high probability */
>   if (mapcount && hascache)
>     goto skip_alloc;
>   ...
> ---
> In doing so, there is no additional use of locks.

Yes.  This can remove the lock-contention.  But, you need to prove that
it's necessary in the first place.

--
Best Regards,
Huang, Ying

>> >> So skip page allocation if SWAP_HAS_CACHE was set, just
>> >> schedule_timeout_uninterruptible and continue to acquire page
>> >> via filemap_get_folio() from swap cache, to speedup
>> >> __read_swap_cache_async.

