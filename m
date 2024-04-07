Return-Path: <linux-kernel+bounces-134162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A893289AE75
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 06:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A542281CC8
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 04:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3C7EDC;
	Sun,  7 Apr 2024 04:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bmsVQ4VO"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3E57460
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 04:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712464572; cv=none; b=GsT3RYfqv6Lu4ZR/UtxhfRowDBXwO5MF3ikgWO7RkOB3tclbogWfN9Lh3ZuAeiI5+E/kmNIdk5cOnXapch0GLA3SWv3SvISln8En6fqV7p5muCCNpP10QgHEVVRyGh8EBsPiWE9gvKA8RK2+vY7mA1i0Q8yit/D6RXoRoHt7pf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712464572; c=relaxed/simple;
	bh=7LtA2O4jNW0QEKqaE7GEt/9iEp+LnlPXIzfTbvAjKeM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MoJL9b9i6zSgMdv/bxTOx1jubiAjqqqzQgBNx+uwcQa0DyBOEt+0K1nEVga0lKH8CHVRmkNBNSLYz6dsA+kQ9WSDU02zHZHFGsmPeEJHsD4YaGinqySOaPU55YbhjplTt81v2PAx/Q4WDiiQq6jWIrwT6+VSm6Hp83QtF4hHhgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bmsVQ4VO; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712464570; x=1744000570;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7LtA2O4jNW0QEKqaE7GEt/9iEp+LnlPXIzfTbvAjKeM=;
  b=bmsVQ4VO/xH80+jFvfFj4rI5lxF5Sxq21wLybie7XP6P+VffMoFByDwn
   MN+okvR9s/0+YDP0NHyUvS9cIYQKmx8QrTwl9quO4U4ddgnjxLJdzD2xf
   dDDh1yjacH64gpczzmZzlfAAzziPYhR0fFNd3gsudwX5FoQgB1z9T9GAi
   qSj5ebuaxTZF/Dk4qQZ/qsXnmGBDKT1/HTjzq8H5MmupavUmzfIUaYyd0
   yQ/uxjz3z5An/WcViabTBKG6aKRLlfHJdaeEmIYXo6dgDOSrWF95uJtcQ
   2ePQCDzwHPpCTtWRzoblFpx3XLAjJOnbesl+HU5W18ZLa504UZSLpkCtS
   g==;
X-CSE-ConnectionGUID: ltLHnwpHQ5KIdUpp/FY4sw==
X-CSE-MsgGUID: VYOeFyWNTJOuRlY4dsPs3A==
X-IronPort-AV: E=McAfee;i="6600,9927,11036"; a="7987594"
X-IronPort-AV: E=Sophos;i="6.07,184,1708416000"; 
   d="scan'208";a="7987594"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2024 21:36:09 -0700
X-CSE-ConnectionGUID: NmBd8fijQGa2dgnngkSc1A==
X-CSE-MsgGUID: 6hc9UWefTuKuY3t3i2iRag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,184,1708416000"; 
   d="scan'208";a="24305028"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa005.jf.intel.com with ESMTP; 06 Apr 2024 21:36:07 -0700
Message-ID: <ae40a717-5a16-4872-a4fd-69c792905a0e@linux.intel.com>
Date: Sun, 7 Apr 2024 12:35:01 +0800
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
Subject: Re: [PATCH 01/12] iommu/vt-d: Add cache tag assignment interface
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>
References: <20240325021705.249769-1-baolu.lu@linux.intel.com>
 <20240325021705.249769-2-baolu.lu@linux.intel.com>
 <BN9PR11MB5276A6DDE82623A32FF80F4F8C3B2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <bc76bb64-8304-4fdf-ae16-03f3e545fd67@linux.intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <bc76bb64-8304-4fdf-ae16-03f3e545fd67@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/6/24 8:55 PM, Baolu Lu wrote:
>>
>>> @@ -4607,10 +4623,11 @@ static void
>>> intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
>>>        */
>>>       if (domain->type == IOMMU_DOMAIN_SVA) {
>>>           intel_svm_remove_dev_pasid(dev, pasid);
>>> +        cache_tag_unassign_domain(dmar_domain,
>>> +                      FLPT_DEFAULT_DID, dev, pasid);
>>
>> is it correct to destroy the tag before teardown completes, e.g. iotlb 
>> still
>> needs to be flushed in intel_pasid_tear_down_entry()?
> 
> You are right. iotlb still needs to be there until the teardown
> completes. I will investigate this more later.

I reviewed this again. Cache tags are designed specifically for mapping
and unmapping paths. Therefore, there is no required order for attaching
and detaching paths.

Best regards,
baolu

