Return-Path: <linux-kernel+bounces-122264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5939B88F467
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 02:11:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC99C1F263BE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 01:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25281CD13;
	Thu, 28 Mar 2024 01:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HUA/yOuH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3491BC49
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 01:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711588305; cv=none; b=HhIHWim3m0enMSSSllua5VM3ToonhqaPY8i3xsrBo1F/ZLKfgyyLdtR//FppYgmiIv64996H50mlEnqP1DfD1alPr7yNwZoOvDnUyV6ZUlA02YR3ohjn1i/nujLcgF/t5M8RdT5TNApbnqLUF6FbqEVNruKXwcbOK40vYQNvFCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711588305; c=relaxed/simple;
	bh=Jry9g/dJ8ZW6iFxkM5spwjAOPWz0jtQCXuPGBGOxKBg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ubekM6YS1FC3KQnHPg+L2vUL+laiURyXh2QvNzVUfyvJnJ0wnaQ79/FZuYYhIRB7/RXoEDHLIIc1D3nUpejGyljPJ1DH0wuf/ZqFJKH2hbxe7SpEMS/MZKk6LV8FM+VeRx5EEJTAeYnchfH9mS8V8OZpWAbLH4qamMHVxmNmrJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HUA/yOuH; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711588303; x=1743124303;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=Jry9g/dJ8ZW6iFxkM5spwjAOPWz0jtQCXuPGBGOxKBg=;
  b=HUA/yOuHPPVVBo29S0g5p1mzXEWOBpuC5/bPHDiigrX84BczYu2IWoce
   Bn7SJA1S4PM9jZE0XI2Ls0tknAnm2dOERViIoAl8HysOPW5+BcwNwAewB
   2vnUNu9U5WOjX3w2JAWbTSYZVFTXX0Rt4u5oBSkaTcBrrQo70OAOwdiFu
   HfEsS/8wXImaOYw2rV7qmLEfjB91AwCG3MHqQx5HERvq5D5h7K6h8Vj9o
   tOqgid9lXI6RkmbL+6ZrKqdTJAipt+7Pl0logXpyJ2q2XrYG/JV/1xIdL
   oKHlzM4x1whSCfyT9MSv9sZOMtYT1G+f7oHKTrHsAQTMsmU3QQ8tpI65T
   A==;
X-CSE-ConnectionGUID: mlv/7UMWSa6juU2WW3+KjQ==
X-CSE-MsgGUID: gqCOunPMTtGZJwb/9Mg1rw==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="6584739"
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="6584739"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 18:11:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="16878153"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 18:11:40 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: David Hildenbrand <david@redhat.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>,  akpm@linux-foundation.org,
  mgorman@techsingularity.net,  wangkefeng.wang@huawei.com,
  jhubbard@nvidia.com,  21cnbao@gmail.com,  ryan.roberts@arm.com,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm: support multi-size THP numa balancing
In-Reply-To: <6248d6fb-b982-4ebd-93a9-7750cc4a5039@redhat.com> (David
	Hildenbrand's message of "Wed, 27 Mar 2024 09:47:24 +0100")
References: <cover.1711453317.git.baolin.wang@linux.alibaba.com>
	<dee4268f1797f31c6bb6bdab30f8ad3df9053d3d.1711453317.git.baolin.wang@linux.alibaba.com>
	<87cyrgo2ez.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<bc671388-f398-4776-af15-c144f2c39d78@linux.alibaba.com>
	<87edbwm6fh.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<6248d6fb-b982-4ebd-93a9-7750cc4a5039@redhat.com>
Date: Thu, 28 Mar 2024 09:09:46 +0800
Message-ID: <8734sbmaat.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

David Hildenbrand <david@redhat.com> writes:

> On 27.03.24 09:21, Huang, Ying wrote:
>> Baolin Wang <baolin.wang@linux.alibaba.com> writes:
>> 
>>> On 2024/3/27 10:04, Huang, Ying wrote:
>>>> Baolin Wang <baolin.wang@linux.alibaba.com> writes:
>>>>
>>>>> Now the anonymous page allocation already supports multi-size THP (mTHP),
>>>>> but the numa balancing still prohibits mTHP migration even though it is an
>>>>> exclusive mapping, which is unreasonable.
>>>>>
>>>>> Allow scanning mTHP:
>>>>> Commit 859d4adc3415 ("mm: numa: do not trap faults on shared data section
>>>>> pages") skips shared CoW pages' NUMA page migration to avoid shared data
>>>>> segment migration. In addition, commit 80d47f5de5e3 ("mm: don't try to
>>>>> NUMA-migrate COW pages that have other uses") change to use page_count()
>>>>> to avoid GUP pages migration, that will also skip the mTHP numa scaning.
>>>>> Theoretically, we can use folio_maybe_dma_pinned() to detect the GUP
>>>>> issue, although there is still a GUP race, the issue seems to have been
>>>>> resolved by commit 80d47f5de5e3. Meanwhile, use the folio_likely_mapped_shared()
>>>>> to skip shared CoW pages though this is not a precise sharers count. To
>>>>> check if the folio is shared, ideally we want to make sure every page is
>>>>> mapped to the same process, but doing that seems expensive and using
>>>>> the estimated mapcount seems can work when running autonuma benchmark.
>>>> Because now we can deal with shared mTHP, it appears even possible
>>>> to
>>>> remove folio_likely_mapped_shared() check?
>>>
>>> IMO, the issue solved by commit 859d4adc3415 is about shared CoW
>>> mapping, and I prefer to measure it in another patch:)
>> I mean we can deal with shared mTHP (by multiple threads or multiple
>> processes) with this patch.  Right?
>
> It's independent of the folio order. We don't want to mess with shared COW pages, see
>
> commit 859d4adc3415a64ccb8b0c50dc4e3a888dcb5805
> Author: Henry Willard <henry.willard@oracle.com>
> Date:   Wed Jan 31 16:21:07 2018 -0800
>
>     mm: numa: do not trap faults on shared data section pages.
>          Workloads consisting of a large number of processes running
>         the same
>     program with a very large shared data segment may experience performance
>     problems when numa balancing attempts to migrate the shared cow pages.
>     This manifests itself with many processes or tasks in
>     TASK_UNINTERRUPTIBLE state waiting for the shared pages to be migrated.
> ...
>
> that introduced this handling.

Sorry, I misunderstood your words.

--
Best Regards,
Huang, Ying

