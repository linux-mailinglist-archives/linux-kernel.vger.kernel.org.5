Return-Path: <linux-kernel+bounces-157916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ADCB8B188F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 03:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30EE5B23F2D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 01:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8446C101D4;
	Thu, 25 Apr 2024 01:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M14f4sGw"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C697D4C98
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 01:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714009672; cv=none; b=TsUk6FHRzjb+ijFbZ9h8lVXaqROPGSG+wQHLTUjNk+gehByLRmCvCCwxWOq/VjO3PDMeh7UP6XF0Wz/5aiwz9lwtBjmuIYjNtF3Jae4GsADY1gXAz5AGFtZNpP1SAGLthYkpkfe67zR5H3yhBxBK+xskNEtNAYXniYEB5/33X5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714009672; c=relaxed/simple;
	bh=84OBV4AVX5jU21PKxSUDJXv7xn2sKhHvHcieaawC13s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TLAAbuJ3m0m9sLSNQKt5ijIVul0oZ5tcaa4D2vitpD2hEZx828L/0gdKmuCewelgqzPkMzHOLOEYqzCgd84qE/gdWSsvrrdxkCERFIf6PJEV5UDSsWkvmvv5H7BHiniLsEcWrsrylYvmqnY2wL336pZ2pQy+pmurk+g+rcHt04g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M14f4sGw; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714009671; x=1745545671;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=84OBV4AVX5jU21PKxSUDJXv7xn2sKhHvHcieaawC13s=;
  b=M14f4sGwfVa1ZegwbV3a8wkh1TlgjcvL3W1CIgZ30ay31xbGlqnWNUk/
   F0Z+IeHRbMxIG17KHb1Snv87KvFsU1HQdWNwJWi8+VoAd/sQpHF/U66OA
   utN17TZXyWiYUA3ul0NsZn7iKakjRWHU5+AbE6l1T1aKu2RywvrM6f9gA
   HT+EW2b+rZfLj2ldyr0D2y7AYBAYXvEiBZRBCKHyDTEfOmI0loykhPeuM
   SoCUHhukzPDT5ZRBgIqfGxRRz2vdXW4xBNfGnAlfSBq7R1xLxGIXQujuE
   pMT6cYAKCtseShOaBkzgyQVJFQEV3mvSXgY2cMvgEg8JC8Ut3A9nyRuG5
   Q==;
X-CSE-ConnectionGUID: s4UbywAsTCuYX2YbpSHfzw==
X-CSE-MsgGUID: zWBzQAt2StSHMUtUTEZfhQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9499726"
X-IronPort-AV: E=Sophos;i="6.07,227,1708416000"; 
   d="scan'208";a="9499726"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 18:47:50 -0700
X-CSE-ConnectionGUID: t74vQwVwTYWHrQmRZeMvaQ==
X-CSE-MsgGUID: pryjdDcETT+potaQIaxHJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,227,1708416000"; 
   d="scan'208";a="24945132"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 18:47:45 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org,  Hugh Dickins <hughd@google.com>,  Alistair
 Popple <apopple@nvidia.com>,  Anshuman Khandual
 <anshuman.khandual@arm.com>,  Mel Gorman <mgorman@techsingularity.net>,
  Miaohe Lin <linmiaohe@huawei.com>,  Minchan Kim <minchan@kernel.org>,
  Ryan Roberts <ryan.roberts@arm.com>,  Yang Shi <shy828301@gmail.com>,  Yu
 Zhao <yuzhao@google.com>,  Kairui Song <kasong@tencent.com>,  Barry Song
 <v-songbaohua@oppo.com>,  Chris Li <chrisl@kernel.org>,  Yosry Ahmed
 <yosryahmed@google.com>
Subject: Re: [PATCH] mm,swap: cleanup VMA based swap readahead window
 calculation
In-Reply-To: <49d85e19-feac-417b-9640-ff8059bc8b0b@redhat.com> (David
	Hildenbrand's message of "Wed, 24 Apr 2024 11:23:10 +0200")
References: <20240424063042.665018-1-ying.huang@intel.com>
	<49d85e19-feac-417b-9640-ff8059bc8b0b@redhat.com>
Date: Thu, 25 Apr 2024 09:45:53 +0800
Message-ID: <877cgmrz8u.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

David Hildenbrand <david@redhat.com> writes:

> On 24.04.24 08:30, Huang Ying wrote:
>> When VMA based swap readahead is introduced in commit
>> ec560175c0b6 ("mm, swap: VMA based swap readahead"), "struct
>> vma_swap_readahead" is defined to describe the readahead window.
>> Because we wanted to save the PTE entries in the struct at that time.
>> But after commit 4f8fcf4ced0b ("mm/swap: swap_vma_readahead() do the
>> pte_offset_map()"), we no longer save PTE entries in the struct.  The
>> size of the struct becomes so small, that it's better to use the
>> fields of the struct directly.  This can simplify the code to improve
>> the code readability.  The line number of source code reduces too.
>> No functionality change is expected in this patch.
>
> From a quick scan, you perform quite some unrelated changes that make
> the code harder to review than it should be. Consider separating any
> cleanups from the core change of removing the struct.

Sure.  Will separate it.

--
Best Regards,
Huang, Ying

