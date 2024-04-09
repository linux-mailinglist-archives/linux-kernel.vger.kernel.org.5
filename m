Return-Path: <linux-kernel+bounces-136088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B7789CFDE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 03:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65D431F22A95
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 01:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495158C15;
	Tue,  9 Apr 2024 01:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jIOqBAui"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26B68BE8
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 01:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712626527; cv=none; b=dVCOupORR8WzM3FnAQB0e8DdxEYNver4jzTXmJBIRBymBJwQV598yoFxWNJbrbsKkPCjX5p4+pt4uKgRqTi1EZ131/m5xxUjcrvi4QgNvagWzeHpgm2gZtw1cZxGT23RfkZ41QxQRf8hISEn14xJ5hQGbygzqUWP5SvvojQebKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712626527; c=relaxed/simple;
	bh=IhuMnUPP6sRdUkY89cClHaimdn+5/NV34NjQx6c1MCI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MdhBGLknIGgbnuRLWWz36J++U9P80LdPKNK38mUO+ctj6yzK4zOnDXvhFQP1c9x0vskfRW65xoGEttFybgo1KUJbD0d8FQRAI/TI+1KYG9r3ZVrtm2hosufA5aOemoZPnXNfBOnpkXPmUWo3cA2mBth2EIfblgR4qZl6QRiERYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jIOqBAui; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712626525; x=1744162525;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IhuMnUPP6sRdUkY89cClHaimdn+5/NV34NjQx6c1MCI=;
  b=jIOqBAuieiLTcy4mk2/bLN+78ALXVFl+y40An/Qp3ip0MmQhPogYcIcI
   EeP+HgPWs7vsz6UySa3XU/3iojuvQSwMlZCy0lUDlH3XPWY4GYGzOLerp
   sxUh/hQd4EYxee7/8GhAJkt8/oS0rrz2RU91CgHVbzcm4NdNqyhgldYVx
   h/6dQxvPjhOFZZCQw2VYzANiDEJe7hO+yjV3D7em4rpJ4/MTLzfCbBVCm
   QxKQTWMTAeRtcdH4Xc30URoGLMeMdvPQUh0k7jrU5+tVmo6V8J1YYiYh2
   MnAf+3OuWkVhlConqfdykl4fdaNMbQMgDD97gNaS2Z96MlGZBrG7K4XMD
   Q==;
X-CSE-ConnectionGUID: 7dkPELL/R5GXbWOkyUUazw==
X-CSE-MsgGUID: /PKqpJOcRXSf9MnAMCvx3A==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="19361584"
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="19361584"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 18:35:25 -0700
X-CSE-ConnectionGUID: 3zTA48w7Ql2n7NUmoEcYDg==
X-CSE-MsgGUID: wn/ezkeaRKeE/7Q/ssGKEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="24706304"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa004.fm.intel.com with ESMTP; 08 Apr 2024 18:35:20 -0700
Message-ID: <ff7ed901-fb4d-4bb1-adf1-8c83409b7a80@linux.intel.com>
Date: Tue, 9 Apr 2024 09:34:12 +0800
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
> On Sat, Apr 06, 2024 at 12:34:14PM +0800, Baolu Lu wrote:
>> On 4/3/24 7:58 PM, Jason Gunthorpe wrote:
>>> On Wed, Apr 03, 2024 at 09:15:11AM +0800, Lu Baolu wrote:
>>>> Currently, when attaching a domain to a device or its PASID, domain is
>>>> stored within the iommu group. It could be retrieved for use during the
>>>> window between attachment and detachment.
>>>>
>>>> With new features introduced, there's a need to store more information
>>>> than just a domain pointer. This information essentially represents the
>>>> association between a domain and a device. For example, the SVA code
>>>> already has a custom struct iommu_sva which represents a bond between
>>>> sva domain and a PASID of a device. Looking forward, the IOMMUFD needs
>>>> a place to store the iommufd_device pointer in the core, so that the
>>>> device object ID could be quickly retrieved in the critical fault handling
>>>> path.
>>>>
>>>> Introduce domain attachment handle that explicitly represents the
>>>> attachment relationship between a domain and a device or its PASID.
>>>> A caller-specific data field can be used by the caller to store additional
>>>> information beyond a domain pointer, depending on its specific use case.
>>>>
>>>> Co-developed-by: Jason Gunthorpe<jgg@nvidia.com>
>>>> Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>
>>>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>>>> ---
>>>>    drivers/iommu/iommu-priv.h |   9 +++
>>>>    drivers/iommu/iommu.c      | 158 +++++++++++++++++++++++++++++++++----
>>>>    2 files changed, 153 insertions(+), 14 deletions(-)
>>>>
>>>> diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
>>>> index 5f731d994803..08c0667cef54 100644
>>>> --- a/drivers/iommu/iommu-priv.h
>>>> +++ b/drivers/iommu/iommu-priv.h
>>>> @@ -28,4 +28,13 @@ void iommu_device_unregister_bus(struct iommu_device *iommu,
>>>>    				 const struct bus_type *bus,
>>>>    				 struct notifier_block *nb);
>>>> +struct iommu_attach_handle {
>>>> +	struct iommu_domain		*domain;
>>>> +	refcount_t			users;
>>> I don't understand how the refcounting can be generally useful. There
>>> is no way to free this:
>>>
>>>> +	void				*priv;
>>> When the refcount goes to zero.
>> This field is set by the caller, so the caller ensures that the pointer
>> can only be freed after iommu domain detachment. For iopf, the caller
>> should automatically respond to all outstanding iopf's in the domain
>> detach path.
>>
>> In the sva case, which uses the workqueue to handle iopf,
>> flush_workqueue() is called in the domain detach path to ensure that all
>> outstanding iopf's are completed before detach completion.
> Which is back to what is the point of the refcount at all?

Yeah, refcount is not generally useful. It's context-specific, so it
needs to move out of the core.

The SVA code needs refcount because it allows multiple attachments
between a SVA domain and a PASID. This is not a common case.

> 
>> +static void iommufd_auto_response_handle(struct iommufd_fault *fault,
>> +                                        struct iommu_attach_handle *handle)
>> +{
>> +       struct iommufd_device *idev = handle->priv;
> The caller already has the iommufd_device, don't need the handler.

Yes.

Best regards,
baolu

