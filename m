Return-Path: <linux-kernel+bounces-136105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7D089D00E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 03:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12B9A1C23B9F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 01:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C294EB32;
	Tue,  9 Apr 2024 01:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XdeHlM6Y"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A1A4DA0D
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 01:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712627680; cv=none; b=H0bLX2hKJvEOoFzZDTBRlyN0GSVUZII2zutbn/Lv90mkDubSkZl5H1m4EymNlqGeoq2E3OPTfVH2POXskq5cmY2wlxTxpyfM1M5LenYjCKjrBKjdMPY4okjjNphfLjXKGhNQCANd7IpKOXlEpkzScQLoNVvgQNSUdQtHluo2xUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712627680; c=relaxed/simple;
	bh=cP1SbuC4f3QZPYcto5RfNrOvo22XXm4PnBqKOlfeabw=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gUI4d0wT4onrRr8a5etcrNUT0szIQOr4+wWYKiw3HhlW+PQRupHR8nUud3JNXQOM8PmgZuBnxY87HqvRjuGDOI+D1pthqU4VOjmBYhYG5AztEh36bilStlI+djVB3YeW6BHgE/YuXKhQD5uZgs3iy7JYgGQFADaL2uKRe7vVoxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XdeHlM6Y; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712627679; x=1744163679;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cP1SbuC4f3QZPYcto5RfNrOvo22XXm4PnBqKOlfeabw=;
  b=XdeHlM6YWIL9DNa9RrH6kzl4afUKa9WDFPD8iipwx960sPIa1nGA/6iE
   lCbdJWANATZ33Qaku8walmeftlcPrTPmq5zeMeRGKy4LLKyeOHFP0q4Xm
   NZDxuk7ZqfJW2i24SmmhgYTiDu+fq9CaXXcKSP8N8UTC//nbvOhBtoyir
   SPolokqYXJU/n+063zoyVo5m5ZPE+BH/iTX7pCAPobpmjuJqshdZkYi6j
   TSp0m/YNdwtzAqdiFqejhNh1trVAjTwuVVHl4r+sw6sTGEwyRKerxZlhv
   ojkm8KUqHZEl6XqaHCCHBxUq1IsCefLcZYoQHKsjKKqlHpZZXbTJTRdQD
   A==;
X-CSE-ConnectionGUID: kNbZaJfDSxuMjk0gnMW7sQ==
X-CSE-MsgGUID: gxm7xlR/SfCLLhLfrPvj2Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="19363451"
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="19363451"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 18:54:38 -0700
X-CSE-ConnectionGUID: XDdYf3l8Q4S5Rs0iB+gAcA==
X-CSE-MsgGUID: APDLEsHJT3my+ORT1HG5+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="24814545"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa004.jf.intel.com with ESMTP; 08 Apr 2024 18:54:34 -0700
Message-ID: <4c07d54f-6c6c-47be-9e5a-3cff8162dd3b@linux.intel.com>
Date: Tue, 9 Apr 2024 09:53:26 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Kevin Tian <kevin.tian@intel.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/9] iommu: Introduce domain attachment handle
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20240403011519.78512-1-baolu.lu@linux.intel.com>
 <20240403011519.78512-2-baolu.lu@linux.intel.com>
 <20240403115851.GA1723999@nvidia.com>
 <3b740988-7fe6-4328-8ce2-d66d9a2ab497@linux.intel.com>
 <20240408140548.GO5383@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240408140548.GO5383@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/8/24 10:05 PM, Jason Gunthorpe wrote:
>> void iommufd_fault_domain_detach_dev(struct iommufd_hw_pagetable *hwpt,
>>                                       struct iommufd_device *idev)
>>   {
>> +       struct iommufd_fault *fault = hwpt->fault;
>> +       struct iommu_attach_handle *handle;
>> +
>>          if (WARN_ON(!hwpt->fault_capable))
>>                  return;
>>
>> +       handle = iommu_attach_handle_get(idev->igroup->group,
>> IOMMU_NO_PASID);
>>          iommu_detach_group(hwpt->domain, idev->igroup->group);
>>          iommufd_fault_iopf_disable(idev);
> But is this right? Couldn't there be PASID's doing PRI?

As far as I can see, there are two types of user PASID.

1. When a device is assigned to userspace, the PASID table is managed by
    the userspace.

    Userspace doesn't need PASID attach/detach/replace uAPIs in this
    scenario. All I/O page faults are directed to userspace through the
    hw pagetable attached to the RID.

    If hw pagetable is detached from the RID, or a non-iopf-capable
    hw pagetable is attached the RID, the PRI for user PASID is already
    broken.

2. When a device is assigned to userspace, the PASID table is managed by
    the host kernel. Userspace then needs PASID attach/detach/replace
    uAPIs to manage the hw page table for each PASID. Each PASID has its
    own hw page table for handling I/O page faults.

    Here, disabling PRI is only safe after all iopf-capable hw page
    tables for both the RID and all PASIDs are detached.

    The current code base doesn't yet support PASID attach/detach/replace
    uAPIs. Therefore, above code is safe and reasonable. However, we will
    need to revisit this code when those APIs become available.

Please correct me if my understanding is incorrect.

Best regards,
baolu

