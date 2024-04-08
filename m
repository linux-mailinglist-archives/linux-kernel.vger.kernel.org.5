Return-Path: <linux-kernel+bounces-134733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CBB89B62E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 04:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB91EB210DE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 02:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB0A1852;
	Mon,  8 Apr 2024 02:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zho8LMkK"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916E48820
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 02:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712544906; cv=none; b=AusPxUiPgYOOXIWP92wJeVAkqEJPPbehsItATuMm4ywuuQ2QkP102B0xt22/Sm5y2U39Qr52ZJW/y3ZyfkoM1fG838qAXy0rTGm1laSTzIt/npyJ4b0s7gLmiPJDZPwUDhA6q+crK/Ag0M5wuCp1EWFcpFhmX6Yvhxhul9TdeAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712544906; c=relaxed/simple;
	bh=DcRxCE1glNDbOXhv15DUtJ0l9/xA3Qq9TxDMv6ALNi8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WHA1qkTtR5eMfTbv9tf4UkQ5mLJqyg2SoBmZeaYgrDqpQyhNY25x76WtDuctt+9BOr+Exkq1K/Ust40ZuAnqoi+psBZ2xJQMlodmypgsR93RW6NArRZyK0wVfptyOv9WfeDM15h0HrkKOdH96/9iIsln483GqoB/zTDb87CTnf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zho8LMkK; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712544904; x=1744080904;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DcRxCE1glNDbOXhv15DUtJ0l9/xA3Qq9TxDMv6ALNi8=;
  b=Zho8LMkK5bA+nXfcIaJJSsnm5KBoxEWzjovdEhsLPjwVpQSXGzSBA7C/
   BUyaDtCbC7zOYIzjVcLB9f+QA4h/18k9mPHiNSfimFELGEC0na3eF80eU
   XACgAmC53mAUJ8umOkWLKp92pYW5COwD4f9HTkqWhzXS+THTq6PF0zIG9
   djZR0gkuNtyD6wu1kFjJVngHlN8/z3FbL8BWWhcLFGMsxzNGX6TVH5GhK
   2ofgCoHd1DyehQkHBF5QPddCBJ/0cyYFpMNz8jkq1ww0LRG33gSfrVi1E
   p2NZyY/CzzCr59uQd27+vF2vkWBQ2jSzeOdmgEKy6bEnYB+Vms8SMctpc
   g==;
X-CSE-ConnectionGUID: dqKox4wjQ46Sh8tJLIsXFg==
X-CSE-MsgGUID: 9BdR4J2SR2Su7PPD8AthpA==
X-IronPort-AV: E=McAfee;i="6600,9927,11037"; a="19243680"
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="19243680"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2024 19:55:04 -0700
X-CSE-ConnectionGUID: +aZc4bg9QZypUlqpY0T5dA==
X-CSE-MsgGUID: 0Ugz9VHvQla07LK84dsVpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="50714022"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa002.jf.intel.com with ESMTP; 07 Apr 2024 19:55:02 -0700
Message-ID: <7d90bb2f-ea04-4492-b1d4-1bebe54b8ca2@linux.intel.com>
Date: Mon, 8 Apr 2024 10:53:54 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, "Zhang, Tina" <tina.zhang@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 02/12] iommu/vt-d: Add cache tag invalidation helpers
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>
References: <20240325021705.249769-1-baolu.lu@linux.intel.com>
 <20240325021705.249769-3-baolu.lu@linux.intel.com>
 <BN9PR11MB52769F48D89273B0CCAA0B7C8C3B2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <9aeb7dfd-e8af-4da8-b67e-274f3227efa4@linux.intel.com>
 <BN9PR11MB52760554D81E96A9AAFD964A8C002@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52760554D81E96A9AAFD964A8C002@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/8/24 10:33 AM, Tian, Kevin wrote:
>> From: Baolu Lu<baolu.lu@linux.intel.com>
>> Sent: Sunday, April 7, 2024 1:33 PM
>>
>> On 3/28/24 3:39 PM, Tian, Kevin wrote:
>>>> From: Lu Baolu<baolu.lu@linux.intel.com>
>>>> Sent: Monday, March 25, 2024 10:17 AM
>>>>
>>>> +/*
>>>> + * Invalidate a range of IOVA when IOMMU is in caching mode and new
>>>> mappings
>>>> + * are added to the target domain.
>>>> + */
>>>> +void cache_tag_flush_cm_range(struct dmar_domain *domain, unsigned
>>>> long start,
>>>> +			      unsigned long end)
>>>> +{
>>> I'm also not sure why this is worth a separate helper. why couldn't it
>>> be managed by previous flush_range()?
>> This is only my preference. I'd like to separate things belonging to
>> different paths, so that it's easier for maintenance. For example, if,
>> in the future, we need to add or enhance something for a specific case,
>> we don't need to care about other cases.
> IMHO caching mode is an attribute in low level iommu which can be
> handled perfectly well within the helper by checking that attribute.
> 
> it sounds a bit weird for the caller to know that detail and call different
> helpers when all paths just want to request to flush a specific range.

I see. The helper name is a bit confusing.

Generally speaking, cache_tag_flush_range() and cache_tag_flush_all()
are designed to flush caches for mapping change from present to non-
present. While cache_tag_flush_cm_range() is designed to flush caches
for mapping change from non-present to present.

How about renaming these helpers to

cache_tag_flush_present_range()
cache_tag_flush_present_all()
cache_tag_flush_non_present_range()

?

In cache_tag_flush_non_present_range(),

- if IOMMU is not in caching mode, flush the write buffer if necessary,
   or it's a no-op.
- if IOMMU is in caching mode, flush the IOTLB caches.

Best regards,
baolu

