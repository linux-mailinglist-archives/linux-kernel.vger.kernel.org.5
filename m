Return-Path: <linux-kernel+bounces-140409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0BC8A1407
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3620282BD6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F0914B065;
	Thu, 11 Apr 2024 12:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cVEJNBqN"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E2814AD35
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 12:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712837460; cv=none; b=bc+dZcKtuIyYSaq59w9HARLh2Sy+nW08XLIkixc94OgZlpJcxYo1i7dGbTj3zZ7niSNLn2TFvIhoAxMNkNw8gcf+x4TL0tb4j4wTyuetwbRhsDTHFopE5ZNS5GWcXkSybx5cBSLvzT+pKE0TgR8cOsfCSia8+hWZPu+CgC2vZr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712837460; c=relaxed/simple;
	bh=bX6OSCLUI+vJ1fK3gTL9hSh9PUm6yiHfWc9V9WQwdlg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WQSRRvV6h/vUH++Lsgg6M6V+pqmaGoNqCIwdj7A8XdLz2XIa0PeZnnRsegyXiDmJ+O8icFgnccrkLiTeOEVqUtjmEHmwixcYSx805lSlhoA2mGMkCVXooYuaYN3xQ6AXm04GOVrdn80JmE2NF0pjypgXK2ZeaiMri9l1zCS+wns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cVEJNBqN; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712837457; x=1744373457;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bX6OSCLUI+vJ1fK3gTL9hSh9PUm6yiHfWc9V9WQwdlg=;
  b=cVEJNBqNOWTmWZggyh+0LX1xvRijra0KGF3Kq6cod87tiZhYxMWrvKOI
   9hwFMia+HwqjBXXHLmekRivXH2J3VLYLryVtoyvE7W6Rx/vmkQaWknJOL
   ZkhT7yoQwoFM0frDA8z8mxNw8KKhOdsY9OER605EeBkx13/Cc9i9sCT4u
   Lg7YUWmYZ9Tu1HBrN2j1emB7jfjhKcIWFGFhaidzVr4DBtoPM5dxksiua
   mt+cNCBjkB002hK5/jr/lCpEO3SeA4MNnTdpF0j3eTnKYf3bGUqXMzKk/
   m+wKN1e5bny9wh39MxYVhYAPb8HG6WpqdidO6sZUhHWkl2wXk1PLc+ngX
   A==;
X-CSE-ConnectionGUID: 8Y0qhunBRUuhUrSl3NEW5A==
X-CSE-MsgGUID: mDKRNDp8TamLjuCKu2vGrg==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8105888"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="8105888"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 05:10:57 -0700
X-CSE-ConnectionGUID: hVb94zt2SliXovopBz0bqg==
X-CSE-MsgGUID: UhvH6d5OTSOwaO9rbRqT6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="51849819"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.237.86]) ([10.124.237.86])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 05:10:55 -0700
Message-ID: <4449fe72-78c9-4c39-aa4c-29829de1a545@linux.intel.com>
Date: Thu, 11 Apr 2024 20:10:52 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>, Tina Zhang <tina.zhang@intel.com>,
 Yi Liu <yi.l.liu@intel.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/12] iommu/vt-d: Add cache tag assignment interface
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20240325021705.249769-1-baolu.lu@linux.intel.com>
 <20240325021705.249769-2-baolu.lu@linux.intel.com>
 <20240410154134.GG223006@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240410154134.GG223006@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/4/10 23:41, Jason Gunthorpe wrote:
> On Mon, Mar 25, 2024 at 10:16:54AM +0800, Lu Baolu wrote:
>> Caching tag is a combination of tags used by the hardware to cache various
>> translations. Whenever a mapping in a domain is changed, the IOMMU driver
>> should invalidate the caches with the caching tags. The VT-d specification
>> describes caching tags in section 6.2.1, Tagging of Cached Translations.
>>
>> Add interface to assign caching tags to an IOMMU domain when attached to a
>> RID or PASID, and unassign caching tags when a domain is detached from a
>> RID or PASID. All caching tags are listed in the per-domain tag list and
>> are protected by a dedicated lock.
>>
>> In addition to the basic IOTLB and devTLB caching tag types, PARENT_IOTLB
>> and PARENT_DEVTLB tag types are also introduced. These tags are used for
>> caches that store translations for DMA accesses through a nested user
>> domain. They are affected by changes to mappings in the parent domain.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/intel/iommu.h  |  25 +++++
>>   drivers/iommu/intel/cache.c  | 192 +++++++++++++++++++++++++++++++++++
>>   drivers/iommu/intel/iommu.c  |  31 +++++-
>>   drivers/iommu/intel/nested.c |  21 +++-
>>   drivers/iommu/intel/svm.c    |  12 ++-
>>   drivers/iommu/intel/Makefile |   2 +-
>>   6 files changed, 274 insertions(+), 9 deletions(-)
>>   create mode 100644 drivers/iommu/intel/cache.c
>>
>> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
>> index 404d2476a877..e3723b7a0b31 100644
>> --- a/drivers/iommu/intel/iommu.h
>> +++ b/drivers/iommu/intel/iommu.h
>> @@ -607,6 +607,9 @@ struct dmar_domain {
>>   	struct list_head devices;	/* all devices' list */
>>   	struct list_head dev_pasids;	/* all attached pasids */
>>   
>> +	spinlock_t cache_lock;		/* Protect the cache tag list */
>> +	struct list_head cache_tags;	/* Cache tag list */
> 
> That is quite a neat trick - though building a dedicated invalidation
> list duplicates data stored in the attached devices list?

Yes. The device and dev_pasid lists appear to be duplicate. I am about
to remove these two lists later.

> You didn't try to make it RCU safe for invalidation?

The queued invalidation interface is a bit complicated, especially when
it comes to device TLB invalidation. Device TLB invalidation might
result in a timeout, which requires special treatment.

>> +struct cache_tag {
>> +	struct list_head node;
>> +	enum cache_tag_type type;
>> +	struct intel_iommu *iommu;
>> +	struct device *dev;
> 
> iommu and dev probably don't both need to be stored together. We have
> iommu_get_iommu_dev() now.. I suppose this is probably a union of the
> two pointers depending on tag. DEVTLB needs the dev and IOTLB needs
> the iommu.
> 
>> +	u16 domain_id;
>> +	ioasid_t pasid;
>> +	int users;
> 
> unsigned int

Sure.

> 
>> +static int __cache_tag_assign_parent_domain(struct dmar_domain *domain, u16 did,
>> +					    struct device *dev, ioasid_t pasid)
>> +{
>> +	struct device_domain_info *info = dev_iommu_priv_get(dev);
>> +	int ret;
>> +
>> +	ret = cache_tag_assign(domain, did, dev, pasid, CACHE_TAG_TYPE_PARENT_IOTLB);
>> +	if (ret || !info->ats_enabled)
>> +		return ret;
> 
> I'm not sure I understood the point of PARENT_IOTLB? I didn't see any
> different implementation?
> 
> Isn't this backwards though? Each domain should have a list of things
> to invalidate if the domain itself changes.
> 
> So the nesting parent should have a list of CHILD_DEVTLB's that need
> cleaning. That list is changed when the nesting domains are attached
> to something.
> 
> And a list of CHILD_IOTLBs, but the HW doesn't seem to need that?

This is a partial replacement of below series.

https://lore.kernel.org/all/20240208082307.15759-1-yi.l.liu@intel.com/

Best regards,
baolu


