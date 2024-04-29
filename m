Return-Path: <linux-kernel+bounces-161741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C22698B5080
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 07:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E60E41C21BF0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 05:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3123FD518;
	Mon, 29 Apr 2024 05:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D4M9Bo93"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89513372
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 05:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714367327; cv=none; b=Vv7hV2YMeo/e9NNncFLB0viySAiid9HTZ8Dy/x6mOO5TzDn/7oWOCy21W+nzPbm2dCBVGEZUQNJgF6B8AYZdDF7aEHNZqJ2j4NGkHn3V7nNNE0cbg2XfqnPNkY6WKpNDSdxwF4fHf36yH1FLvQHbp4lurRYpimDbZ3vnKWytmLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714367327; c=relaxed/simple;
	bh=mxVSpiVc3CFUOue6xPqdNIQrLke23NOIAqrrjzMXkAs=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CIV0n1tyWy/AkScIGNqCxS1oD5XchMgiWtpo+b8wjmvUFdzPq6rqdI4acxnU8l9s5TwzX34oLZr1ZmdFsvpBKGJExukqxUFHar3S5vbVlmUe1rVLRCsphMRhJkWt2YhBkT8xbkv2APbx0UiLZmwnpsbMMpLQK58jSLZQO7W8U6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D4M9Bo93; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714367325; x=1745903325;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mxVSpiVc3CFUOue6xPqdNIQrLke23NOIAqrrjzMXkAs=;
  b=D4M9Bo93kRtN3dPEHi0OyuOEg8Bw4QJZAXhog8AXzXBn/bDwCwQFc0+/
   i4NajLl9Ql4WDgtWS6rE2WqmT2jEh3sgmKiU0W5vf21HGBxPmcjQXTXYn
   lbLk3MZMfnMkd25dYRjE8AT85LumPsd7pew+yIB3R9/shKmcwZ2fa8EJ/
   1joq0oT13BucEx3+M2OJBj0nfj5bFT3D5DbxdBwSZQ2r8IXOVeOy0H9nm
   owz+Ds9TZunF98liw2oMY/GHUTKhVmyTtIvlX3yGuSr03pCtXprQvwzY7
   +Y6tJkZCVhb6gfxCN9EwnspKCCPA+4ERLZ4qt5rvhkEKpfquQ0eE6U7Tj
   w==;
X-CSE-ConnectionGUID: oQUMRHsfQsupX+hsiWwuBw==
X-CSE-MsgGUID: WhIPc9yJTWyBYWPpo7sfUQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="10231760"
X-IronPort-AV: E=Sophos;i="6.07,238,1708416000"; 
   d="scan'208";a="10231760"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2024 22:08:44 -0700
X-CSE-ConnectionGUID: mvNirE5RSEyXwSzpR9HIbw==
X-CSE-MsgGUID: lTA8GHIvRQ+tyNNKpDF9ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,238,1708416000"; 
   d="scan'208";a="26630786"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa008.jf.intel.com with ESMTP; 28 Apr 2024 22:08:42 -0700
Message-ID: <001d6fa8-d2f5-4011-988d-d2bc4f43a1aa@linux.intel.com>
Date: Mon, 29 Apr 2024 13:07:14 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Joel Granados <j.granados@samsung.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/9] iommu: Replace sva_iommu with iommu_attach_handle
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>
References: <20240403011519.78512-1-baolu.lu@linux.intel.com>
 <20240403011519.78512-3-baolu.lu@linux.intel.com>
 <20240403115913.GC1363414@ziepe.ca>
 <e3f526e3-6474-49ff-b8d6-995aaf1c1830@linux.intel.com>
 <20240408141946.GB223006@ziepe.ca>
 <86e723e7-c3be-41b1-95d8-dbdf86bbdab5@linux.intel.com>
 <20240409234800.GD223006@ziepe.ca>
 <5871aaec-b81a-4ad4-8eb1-656a04d04bda@linux.intel.com>
 <BN9PR11MB5276F89C1C21BD03207A044F8C1B2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276F89C1C21BD03207A044F8C1B2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/29/24 10:39 AM, Tian, Kevin wrote:
>> From: Baolu Lu <baolu.lu@linux.intel.com>
>> Sent: Sunday, April 28, 2024 6:22 PM
>>
>> On 2024/4/10 7:48, Jason Gunthorpe wrote:
>>> On Tue, Apr 09, 2024 at 10:11:28AM +0800, Baolu Lu wrote:
>>>> On 4/8/24 10:19 PM, Jason Gunthorpe wrote:
>>>>> On Sat, Apr 06, 2024 at 02:09:34PM +0800, Baolu Lu wrote:
>>>>>> On 4/3/24 7:59 PM, Jason Gunthorpe wrote:
>>>>>>> On Wed, Apr 03, 2024 at 09:15:12AM +0800, Lu Baolu wrote:
>>>>>>>> +	/* A bond already exists, just take a reference`. */
>>>>>>>> +	handle = iommu_attach_handle_get(group, iommu_mm-
>>> pasid);
>>>>>>>> +	if (handle) {
>>>>>>>> +		mutex_unlock(&iommu_sva_lock);
>>>>>>>> +		return handle;
>>>>>>>>      	}
>>>>>>> At least in this context this is not enough we need to ensure that the
>>>>>>> domain on the PASID is actually an SVA domain and it was installed by
>>>>>>> this mechanism, not an iommufd domain for instance.
>>>>>>>
>>>>>>> ie you probably need a type field in the iommu_attach_handle to tell
>>>>>>> what the priv is.
>>>>>>>
>>>>>>> Otherwise this seems like a great idea!
>>>>>> Yes, you are right. For the SVA case, I will add the following changes.
>>>>>> The IOMMUFD path will also need such enhancement. I will update it in
>>>>>> the next version.
>>>>> The only use for this is the PRI callbacks right? Maybe instead of
>>>>> adding a handle type let's just check domain->iopf_handler  ?
>>>>>
>>>>> Ie SVA will pass &ommu_sva_iopf_handler as its "type"
>>>> Sorry that I don't fully understand the proposal here.
>>> I was talking specifically about the type field you suggested adding
>>> to the handle struct.
>>>
>>> Instead of adding a type field check the domain->iopf_handler to
>>> determine the domain and thus handle type.
>>>
>>>> The problem is that the context code (SVA, IOMMUFD, etc.) needs to
>> make
>>>> sure that the attach handle is really what it has installed during
>>>> domain attachment. The context code needs some mechanism to include
>> some
>>>> kind of "owner cookie" in the attach handle, so that it could check
>>>> against it later for valid use.
>>> Right, you have a derived struct for each user and you need a way to
>>> check if casting from the general handle struct to the derived struct
>>> is OK.
>>>
>>> I'm suggesting using domain->iopf_handle as the type key.
>>
>> After removing the refcount from the attach handle, I am trying to make
>> the code look like this,
>>
>>           /* A bond already exists, just take a reference`. */
>>           handle = iommu_attach_handle_get(group, iommu_mm->pasid);
>>           if (handle) {
>>                   if (handle->domain->iopf_handler !=
>> iommu_sva_iopf_handler) {
>>                           ret = -EBUSY;
>>                           goto out_unlock;
>>                   }
>>
>>                   refcount_inc(&handle->users);
>>                   mutex_unlock(&iommu_sva_lock);
>>                   return handle;
>>           }
>>
>> But it appears that this code is not lock safe. If the domain on the
>> PASID is not a SVA domain, the check of "handle->domain->iopf_handler !=
>> iommu_sva_iopf_handler" could result in a use-after-free issue as the
>> other thread might detach the domain in between the fetch and check
>> lines.
>>
>> Probably we still need to keep the refcount in the attach handle?
>>
> 
> What about Jason's another comment in his original replies?
> 
> "
> Though I'm not convinced the refcount should be elevated into the core
> structure. The prior patch I showed you where the caller can provide
> the memory for the handle and we don't have a priv would make it easy
> to put the refcount in a SVA dervied handle struct without more
> allocation. Then we don't need this weirdness.
> "
> 
> That sounds like we'll need a iommu_sva like structure to hold
> its own refcnt. Then we don't need this type check and refcnt
> in the core.

The problem I'm facing isn't about who allocates the handle memory.
Instead, there's no mechanism to synchronize access between two threads.
One thread might remove the handle while another fetches and reads a
member of its structure.

A similar issue exists with iommu_get_domain_for_dev_pasid(). It fetches
and returns a domain, but there's no guarantee that the domain will
*not* be freed while the caller is still using it.

One reason I introduced the reference count for attach handles is to
potentially replace iommu_get_domain_for_dev_pasid(), allowing the
domain to be accessible without any potential UAF issue.

Best regards,
baolu

