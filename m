Return-Path: <linux-kernel+bounces-136062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B4B89CF9F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 03:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1240A1C2237B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 01:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319C6A94A;
	Tue,  9 Apr 2024 01:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UVZlvsS/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFC8A934
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 01:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712624969; cv=none; b=RVKVmT4bg8QnOqufutwv2LVpA0XJKHGc9carj77l3KWrpGqhz6ibE2EFG4r91X/W03nb5FoIubsuDg8Nr8zfsTHul0RZ5nha8HfcGwetKfXbPjuxCxjbnx/xpCQbvcUDvseAfI99bLn049IpsdgKVelIomhTdiDL415aD0BICjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712624969; c=relaxed/simple;
	bh=/8XqYJs3NAILkmaX8AcFbqEoJRh52nEXesKZfZMQ6UM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=r4M7wGCJfzJ1IumieI5hrHnN8fhPmk/Ceov4DlKZd2/UUCC0ZSfQhjbnVibiDU5c0vfVgV5PFYt2xsUDy5DlcCR98jhII6RhtXVeDUT4ZWjPoXAELWunZIUJCid7UN91pyw3A/WehSh3DeEsyId2MF8TWQSusQca1mKbk5HkC0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UVZlvsS/; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712624967; x=1744160967;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=/8XqYJs3NAILkmaX8AcFbqEoJRh52nEXesKZfZMQ6UM=;
  b=UVZlvsS/bcebWlR5iYIgsi8RYzcHtonNA1MsBEcpTvZAughMNu495MCc
   uIXStIu0ag3i1G5Ozo7QRYz2FmuhvyCtSqYogl3higumr6MRzooHcisnv
   7TdAN5r0KbHLychd2uNtoya8hIdJeTUSbnnNrYQAmcXYUdD4a4TGLbilR
   iXQp1X1AXGq0VjRnZaIO/LDgzaCkS/avHCTENl0Ycra+5oaBNziip9A92
   kXH8w0RVBccE3SBBFJEMIRYAI5BevGEpnbUMTeablW0iLyDAzOoThFkQw
   Fg1H7BgEhmn5mzagaFNpzaQgtwVlN/FCETDFPKFNoVd0e0UrvzfQrLjze
   g==;
X-CSE-ConnectionGUID: WBXNJelTQlKohpUL+OFinQ==
X-CSE-MsgGUID: vrTfeOuSRCauyQUgJhsMyQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="18536397"
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="18536397"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 18:09:25 -0700
X-CSE-ConnectionGUID: KMGnh2sQRMaZ4G8v/STDlw==
X-CSE-MsgGUID: /DfFWl6KRmy60VIzxSDSGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="20500770"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 18:09:23 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Zhaoyu Liu <liuzhaoyu.zackary@bytedance.com>,  ryncsn@gmail.com,
  nphamcs@gmail.com,  songmuchun@bytedance.com,  david@redhat.com,
  chrisl@kernel.org,  guo.ziliang@zte.com.cn,  yosryahmed@google.com,
  linux-kernel@vger.kernel.org,  linux-mm@kvack.org
Subject: Re: [PATCH v2] mm: swap: prejudgement swap_has_cache to avoid page
 allocation
In-Reply-To: <20240408132704.f966adc8d3928df4d3b8c0a9@linux-foundation.org>
	(Andrew Morton's message of "Mon, 8 Apr 2024 13:27:04 -0700")
References: <20240408121439.GA252652@bytedance>
	<20240408132704.f966adc8d3928df4d3b8c0a9@linux-foundation.org>
Date: Tue, 09 Apr 2024 09:07:29 +0800
Message-ID: <87edbf8hta.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Andrew Morton <akpm@linux-foundation.org> writes:

> On Mon, 8 Apr 2024 20:14:39 +0800 Zhaoyu Liu <liuzhaoyu.zackary@bytedance.com> wrote:
>
>> Based on qemu arm64 - latest kernel + 100M memory + 1024M swapfile.
>> Create 1G anon mmap and set it to shared, and has two processes
>> randomly access the shared memory. When they are racing on swap cache,
>> on average, each "alloc_pages_mpol + swapcache_prepare + folio_put"
>> took about 1475 us.
>
> And what effect does this patch have upon the measured time?  ANd upon
> overall runtime?

And the patch will cause increased lock contention, please test with
more processes and perhaps HDD swap device too.

>> So skip page allocation if SWAP_HAS_CACHE was set, just
>> schedule_timeout_uninterruptible and continue to acquire page
>> via filemap_get_folio() from swap cache, to speedup
>> __read_swap_cache_async.

--
Best Regards,
Huang, Ying

