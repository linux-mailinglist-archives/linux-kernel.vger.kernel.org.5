Return-Path: <linux-kernel+bounces-137967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB8C89EA7C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39AEB1C22387
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 06:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA95210E9;
	Wed, 10 Apr 2024 06:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZZSCgZ86"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29761CAA9
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 06:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712729618; cv=none; b=qxTzyIGNTI+9kSfoSnogG+HJvxFWttZWmTn5z5/v33LXYdAsRwXb+DUk1iomVF5MzUTeurtyp3ty7b+klK017T2+GFkK4luoVVHmpjLXXBTYopzAagxk4scvkirbJ2bfFhB0PwpA+8tzxrBChpm+HPqkDr0y3X/NRNqFQW8eRkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712729618; c=relaxed/simple;
	bh=W2gn7RhUJ3uLUCLohYqWt9SWWd8i3R/AyaTViZgpI/8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rVMu2yENPAEZ528qBQr3jJJ+l9OIASHJ9ka9rNf7kSXnZyqR1bfnU/cbrQnCOjcFHs64WLMJdzR7yKvv9JHtSY+/fQhZYJJkQx05WitVEB5lJ72dWkL1DRgJTCvKfm2ZN/64CsvWhRGWZvdbVtSEjPg6+93EJB3/U1+yDDDfvMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZZSCgZ86; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712729617; x=1744265617;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=W2gn7RhUJ3uLUCLohYqWt9SWWd8i3R/AyaTViZgpI/8=;
  b=ZZSCgZ86GDjCTdxOyHblX2ai2LnC8zPytsxC25h8qIGO+tncr/ZcdMGL
   CY1KpLPlo3IDaap8ZhPj4BMjKfXp6JasPfSutFyrwEhfB4oDoY9bo6zhJ
   UU9J9yETlZwVJAE+Be6JN+IxltBve+N35L8vA7wK6XizU3zEKGh2L3F33
   WV0PqEx+IpPm3vkCxN3n7cxvNI0fupNUZBKspnzT8NMTYohbUqV3ROva0
   RwuGj5flrSDuJ51S4NkdSa/ekL1p4SzIR1CxNFtpFYECffyYrR3x4KpGS
   ZZBLr3a40ZAIvhCcVi7yA8ks0lUUK7KWNuXNZU/qkOLeY6FJSxxNBS4XN
   w==;
X-CSE-ConnectionGUID: zUt3VR+eRvaiPRG6JEXTlQ==
X-CSE-MsgGUID: H2Hnqnm5RPKcHkHbimtbGQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="11863517"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="11863517"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 23:13:36 -0700
X-CSE-ConnectionGUID: Wh9iTWoiSv2pFWIGC0bm3Q==
X-CSE-MsgGUID: v9D6xfsIRuOWKxPZB4NFHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="25207459"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa004.jf.intel.com with ESMTP; 09 Apr 2024 23:13:33 -0700
Message-ID: <69e7bf80-13e3-4775-baff-cccbcd91bfc2@linux.intel.com>
Date: Wed, 10 Apr 2024 14:12:22 +0800
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
Subject: Re: [PATCH v4 2/9] iommu: Replace sva_iommu with iommu_attach_handle
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20240403011519.78512-1-baolu.lu@linux.intel.com>
 <20240403011519.78512-3-baolu.lu@linux.intel.com>
 <20240403115913.GC1363414@ziepe.ca>
 <e3f526e3-6474-49ff-b8d6-995aaf1c1830@linux.intel.com>
 <20240408141946.GB223006@ziepe.ca>
 <86e723e7-c3be-41b1-95d8-dbdf86bbdab5@linux.intel.com>
 <20240409234800.GD223006@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240409234800.GD223006@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/10/24 7:48 AM, Jason Gunthorpe wrote:
> On Tue, Apr 09, 2024 at 10:11:28AM +0800, Baolu Lu wrote:
>> On 4/8/24 10:19 PM, Jason Gunthorpe wrote:
>>> On Sat, Apr 06, 2024 at 02:09:34PM +0800, Baolu Lu wrote:
>>>> On 4/3/24 7:59 PM, Jason Gunthorpe wrote:
>>>>> On Wed, Apr 03, 2024 at 09:15:12AM +0800, Lu Baolu wrote:
>>>>>> +	/* A bond already exists, just take a reference`. */
>>>>>> +	handle = iommu_attach_handle_get(group, iommu_mm->pasid);
>>>>>> +	if (handle) {
>>>>>> +		mutex_unlock(&iommu_sva_lock);
>>>>>> +		return handle;
>>>>>>     	}
>>>>> At least in this context this is not enough we need to ensure that the
>>>>> domain on the PASID is actually an SVA domain and it was installed by
>>>>> this mechanism, not an iommufd domain for instance.
>>>>>
>>>>> ie you probably need a type field in the iommu_attach_handle to tell
>>>>> what the priv is.
>>>>>
>>>>> Otherwise this seems like a great idea!
>>>> Yes, you are right. For the SVA case, I will add the following changes.
>>>> The IOMMUFD path will also need such enhancement. I will update it in
>>>> the next version.
>>> The only use for this is the PRI callbacks right? Maybe instead of
>>> adding a handle type let's just check domain->iopf_handler  ?
>>>
>>> Ie SVA will pass &ommu_sva_iopf_handler as its "type"
>> Sorry that I don't fully understand the proposal here.
> I was talking specifically about the type field you suggested adding
> to the handle struct.
> 
> Instead of adding a type field check the domain->iopf_handler to
> determine the domain and thus handle type.
> 
>> The problem is that the context code (SVA, IOMMUFD, etc.) needs to make
>> sure that the attach handle is really what it has installed during
>> domain attachment. The context code needs some mechanism to include some
>> kind of "owner cookie" in the attach handle, so that it could check
>> against it later for valid use.
> Right, you have a derived struct for each user and you need a way to
> check if casting from the general handle struct to the derived struct
> is OK.
> 
> I'm suggesting using domain->iopf_handle as the type key.

Oh, I see. It works. Thanks!

Best regards,
baolu

