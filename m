Return-Path: <linux-kernel+bounces-122312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 778F688F4FE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 02:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 158E71F2D94D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 01:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320212263A;
	Thu, 28 Mar 2024 01:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R2PCkL1R"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC588465
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 01:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711591102; cv=none; b=qc4u8aJXyrh/QqA1dI5FYErWa4iMYD4ScKLi/FPblEnlC9Jz3swOVteVNICI9+rL5UKL4sTF1+MXLc54i5ZwjA7OBjx2bRsBM6ZyryFx5WsuSguyHGB6d7Is6rEyWCGb2gqk8ppYwMC/5rZKzrMoCTt29e2njNiAZJj4bPJ3CtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711591102; c=relaxed/simple;
	bh=5MbqHnqaARWljlVlxclPNn7WRcRf2Q/HvQgsbE3BT4M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hLrTR2yrZu8BsRuFcd4yidHiVUrKhGxTGpY4ekzkuz3krYAUeWKERNeEjBZvRVJeHLj9duB2cRG4KKDYH3iAmyeBRxzlnGZdy93c8mx7GUhJupFanDjX+GZEPM+TKOS2J5uIIabQKNgFT7zGhivyQ5YB3+CltUASgn9BAUkZHZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R2PCkL1R; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711591102; x=1743127102;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=5MbqHnqaARWljlVlxclPNn7WRcRf2Q/HvQgsbE3BT4M=;
  b=R2PCkL1R6+ZG+1wohgrP9Jb0H8yddJJWMcRw0YB58KGUEIQOrd6NIFSF
   up/Z0cq+nj0w0XLVZE5l1wZOKSpJyKYLKjPF3300Of9LongkHNaLEbtBi
   gBtFu9xDIl/y9uxijwnOxcADJuEy2q7lCYfYODsVhWo0q0HYNyvDKgPxM
   yDHSsE7Bs+deK15DuHozZNZq14k1dY7/X4Kdx1p1Fuwu0YlVF5Upf/zUe
   G+s+8oGlPgJr7CW0o73elLV3r8eb97Z2etzDcAZ632KanTccaMLq8G2TB
   6riNEJ3lcShoCCDwjrADzAcwh6tTY8nz5EwNfiQ1EoATDLYw6ZKNEoGgm
   w==;
X-CSE-ConnectionGUID: zIY5qAEWSruTcHAWo7yQBg==
X-CSE-MsgGUID: w4qhIX98QB+lSRQ5/0sDNg==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="10517383"
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="10517383"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 18:58:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="47476595"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 18:58:17 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Bharata B Rao <bharata@amd.com>
Cc: <linux-mm@kvack.org>,  <linux-kernel@vger.kernel.org>,
  <akpm@linux-foundation.org>,  <mingo@redhat.com>,
  <peterz@infradead.org>,  <mgorman@techsingularity.net>,
  <raghavendra.kt@amd.com>,  <dave.hansen@linux.intel.com>,
  <hannes@cmpxchg.org>
Subject: Re: [RFC PATCH 1/2] sched/numa: Fault count based NUMA hint fault
 latency
In-Reply-To: <20240327160237.2355-2-bharata@amd.com> (Bharata B. Rao's message
	of "Wed, 27 Mar 2024 21:32:36 +0530")
References: <20240327160237.2355-1-bharata@amd.com>
	<20240327160237.2355-2-bharata@amd.com>
Date: Thu, 28 Mar 2024 09:56:24 +0800
Message-ID: <87r0fvktkn.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Bharata B Rao <bharata@amd.com> writes:

[snip]

> @@ -1750,25 +1753,20 @@ static bool pgdat_free_space_enough(struct pglist_data *pgdat)
>  }
>  
>  /*
> - * For memory tiering mode, when page tables are scanned, the scan
> - * time will be recorded in struct page in addition to make page
> - * PROT_NONE for slow memory page.  So when the page is accessed, in
> - * hint page fault handler, the hint page fault latency is calculated
> - * via,
> + * For memory tiering mode, when page tables are scanned, the current
> + * hint fault count will be recorded in struct page in addition to
> + * make page PROT_NONE for slow memory page.  So when the page is
> + * accessed, in hint page fault handler, the hint page fault latency is
> + * calculated via,
>   *
> - *	hint page fault latency = hint page fault time - scan time
> + * hint page fault latency = current hint fault count - fault count at scan time
>   *
>   * The smaller the hint page fault latency, the higher the possibility
>   * for the page to be hot.
>   */
> -static int numa_hint_fault_latency(struct folio *folio)
> +static inline int numa_hint_fault_latency(struct folio *folio, int count)
>  {
> -	int last_time, time;
> -
> -	time = jiffies_to_msecs(jiffies);
> -	last_time = folio_xchg_access_time(folio, time);
> -
> -	return (time - last_time) & PAGE_ACCESS_TIME_MASK;
> +	return count - folio_xchg_fault_count(folio, count);
>  }

I found count is task->mm->hint_faults.  That is a process wide
counting.  How do you connect the hotness of a folio with the count of
hint page fault in the process?  How do you compare the hotness of
folios among different processes?

>  /*
> @@ -1794,35 +1792,6 @@ static bool numa_promotion_rate_limit(struct pglist_data *pgdat,
>  	return false;
>  }
>

--
Best Regards,
Huang, Ying

