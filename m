Return-Path: <linux-kernel+bounces-133822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9120689A94B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 08:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2FED1C211E0
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 06:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE76E2231F;
	Sat,  6 Apr 2024 06:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f99RlXL9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592A01EB40
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 06:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712383844; cv=none; b=ql2ai4Vn28YlJOP91JyCDaXoJO1WmQ5dt1F76Bzzr2eDCzK8+lTxguoAQuhIpiYpU4zHRct4ZFkJYFKujxib64SPlmrMSIICg+wmCtfeCwqurd2mwAog31ZGrAmBfcOREPLpRz+AuA+NDVp8yM0ydRbaHlGnmzOrQkHMkrNpchg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712383844; c=relaxed/simple;
	bh=oW5lJbl5v3kR/8gLXMDQPaUPUS+d2GARjElgdEIrEZI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=h1qBNxskJXM5GjZe/kc5TySJPWIiL+B7eFHhvat3zFWfe8FdO0W2LCrtPfo/HQQv5tztXHYuiF4vdW2z53TmQ2mWrzU419e7zsE1U05OgZjldDZKGET5rMOmjuX6PjoUKmASWVVIlMJN8YHps4m+6s8FaqE8O1i56yCYS8wu2qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f99RlXL9; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712383842; x=1743919842;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oW5lJbl5v3kR/8gLXMDQPaUPUS+d2GARjElgdEIrEZI=;
  b=f99RlXL9aaPLIBmFGsIc16cs66eIwuY+D5ZVdIVdzt9IynVmvImaDn4f
   /xGdeM+yogF+Oo6g1Acxco0TLAj7+r9CWH0ao/Htpd/aZzWovFxvFL2Gi
   eVCamp6yb6hvFENXaUQtuQ7HZsBdLtdCUiF2e+liqP6VMg9npqiURHN+M
   bBk7UQvOv3qk/dxyVjwaHWR0LX9XrHeYloufX1B5Z0SXvH4qeX3dcsOov
   WpNjsnP5pJ3VvAWw5hwDM+nnmC7mxo7W3yQ5CBnOswU7mWMNPUHmMJASf
   tii+hE3eNhooiR6nM3NhtYlCHR9hTzXrCzO+66mF4KDpVm1J2jM7AYkWB
   g==;
X-CSE-ConnectionGUID: 2uqHRE42SfyHbU9DBE6x5w==
X-CSE-MsgGUID: 39/RC1tfRI+APJRtosmX6g==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="10695207"
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="10695207"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 23:10:41 -0700
X-CSE-ConnectionGUID: 4IAu7IDhRMaelDhzLtb65w==
X-CSE-MsgGUID: +ETBezDHT6uZW0kFO/rxxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="24097072"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa004.jf.intel.com with ESMTP; 05 Apr 2024 23:10:38 -0700
Message-ID: <e3f526e3-6474-49ff-b8d6-995aaf1c1830@linux.intel.com>
Date: Sat, 6 Apr 2024 14:09:34 +0800
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
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240403115913.GC1363414@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/3/24 7:59 PM, Jason Gunthorpe wrote:
> On Wed, Apr 03, 2024 at 09:15:12AM +0800, Lu Baolu wrote:
>> +	/* A bond already exists, just take a reference`. */
>> +	handle = iommu_attach_handle_get(group, iommu_mm->pasid);
>> +	if (handle) {
>> +		mutex_unlock(&iommu_sva_lock);
>> +		return handle;
>>   	}
> At least in this context this is not enough we need to ensure that the
> domain on the PASID is actually an SVA domain and it was installed by
> this mechanism, not an iommufd domain for instance.
> 
> ie you probably need a type field in the iommu_attach_handle to tell
> what the priv is.
> 
> Otherwise this seems like a great idea!

Yes, you are right. For the SVA case, I will add the following changes.
The IOMMUFD path will also need such enhancement. I will update it in
the next version.

diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
index 08c0667cef54..9aee70f87a21 100644
--- a/drivers/iommu/iommu-priv.h
+++ b/drivers/iommu/iommu-priv.h
@@ -28,9 +28,22 @@ void iommu_device_unregister_bus(struct iommu_device 
*iommu,
  				 const struct bus_type *bus,
  				 struct notifier_block *nb);

+enum attach_handle_type {
+	ATTACH_HANDLE_TYPE_DEFAULT = 0,
+	ATTACH_HANDLE_TYPE_SVA,
+	ATTACH_HANDLE_TYPE_IOMMUFD,
+};
+
  struct iommu_attach_handle {
  	struct iommu_domain		*domain;
  	refcount_t			users;
+
+	/*
+	 * Set by the attach interface callers. The type field could be used
+	 * by the caller to identify whether the priv field was installed by
+	 * them.
+	 */
+	enum attach_handle_type		type;
  	void				*priv;
  };

diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index c66cf26137bf..3eb664cc3f3a 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -90,7 +90,11 @@ struct iommu_attach_handle 
*iommu_sva_bind_device(struct device *dev, struct mm_
  	handle = iommu_attach_handle_get(group, iommu_mm->pasid);
  	if (handle) {
  		mutex_unlock(&iommu_sva_lock);
-		return handle;
+		if (handle->type == ATTACH_HANDLE_TYPE_SVA)
+			return handle;
+
+		iommu_attach_handle_put(handle);
+		return ERR_PTR(-EBUSY);
  	}

  	/* Search for an existing domain. */
@@ -118,6 +122,7 @@ struct iommu_attach_handle 
*iommu_sva_bind_device(struct device *dev, struct mm_
  out:
  	handle = iommu_attach_handle_get(group, iommu_mm->pasid);
  	mutex_unlock(&iommu_sva_lock);
+	handle->type = ATTACH_HANDLE_TYPE_SVA;
  	handle->priv = dev;

  	return handle;

Best regards,
baolu

