Return-Path: <linux-kernel+bounces-134212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C84B89AF02
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 09:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B2871C224E5
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 07:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C798F72;
	Sun,  7 Apr 2024 07:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HbmNfSHj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1704747F
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 07:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712473637; cv=none; b=BqCPBkgBmXpa2QPR2xXVK4WKf3GfOR1jkQXQxmA7IkX6rgsqKMYuAOjZOzqcqt/fHn9CNo20StDZB6tKyUHzacCsRmXMYiFVIzJ1L235lPHtU+DnKMcEbDnKdWwaU9T6e8EsZDA2p+UZ3nkXupLTxsvxq7BVlJGzpaUFH6WY748=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712473637; c=relaxed/simple;
	bh=tgEywHxjn59cCDE/HA3qL/5sa4sUH3MpCD/WA25CFYw=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=g4psKIRWRMLeVgn0KLXY+NP5CFEPtgp7kk7UnYMbYq9lFdJ7HrHxGM1vgAO6kmVJOv89LbSSWj/HtW7w8VGz0dvAzFmdVvIvKEw/qR+cPcUmA6g4OOetDtyFd5tsJlPR1UK6Khec8ys4vOYmgu+NKsNUp9FSPBr4nkU/LitkKmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HbmNfSHj; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712473635; x=1744009635;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tgEywHxjn59cCDE/HA3qL/5sa4sUH3MpCD/WA25CFYw=;
  b=HbmNfSHjdxcPx+bA3/08rVm2LxDGotch9wOOYHCXZe6tges1Jxh4O6s2
   Ptyjy0UwP35MrKlUneBUXPinQV9E4hgfMwfI8Vtr5po56wkG1j16E36Ai
   una83BCCXQDbQfiSljc/DtYISqQPYclB8TYJZAZ5nBOnn3TYZNINoSoWt
   f2iRbouqpGWX+z8phM0WRXHySGoBSSjaP7x5LdoOWfHjXGh8Ua5YQmxaR
   yF8mkRpoczaDJ2zxZJqA+quRRI3Qzv/1FpWjSd5sfqwYkO56RmsZp1HqL
   a5830Hb6KB/dYdzxdQZydAD3LIIDRMen9/TSWc2szknLFrGyvXdFQHOZv
   w==;
X-CSE-ConnectionGUID: 2iM9eNZKTG6S2HX19mrb9w==
X-CSE-MsgGUID: KDqfZekZQ/ynkkCYH7A9lQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11036"; a="7887178"
X-IronPort-AV: E=Sophos;i="6.07,184,1708416000"; 
   d="scan'208";a="7887178"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2024 00:07:15 -0700
X-CSE-ConnectionGUID: bXfkXhFZSC+gJfvAkL3SuA==
X-CSE-MsgGUID: XxjV79ECRGa7TirvvMvVDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,184,1708416000"; 
   d="scan'208";a="50779181"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa001.fm.intel.com with ESMTP; 07 Apr 2024 00:07:12 -0700
Message-ID: <a0e2bde5-1ec0-4b42-aa52-5f86e9e0822e@linux.intel.com>
Date: Sun, 7 Apr 2024 15:06:07 +0800
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
Subject: Re: [PATCH 07/12] iommu/vt-d: Cleanup use of iommu_flush_iotlb_psi()
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>
References: <20240325021705.249769-1-baolu.lu@linux.intel.com>
 <20240325021705.249769-8-baolu.lu@linux.intel.com>
 <BN9PR11MB52762CD9DB4CB9DFA3C26A6C8C3B2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52762CD9DB4CB9DFA3C26A6C8C3B2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/28/24 3:50 PM, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Monday, March 25, 2024 10:17 AM
>>
>> Use cache_tag_flush_range() in switch_to_super_page() to invalidate the
>> necessary caches when switching mappings from normal to super pages. The
>> iommu_flush_iotlb_psi() call in intel_iommu_memory_notifier() is
>> unnecessary since there should be no cache invalidation for the identity
>> domain.
>>
> 
> what about a software identity domain?

Software identity domain is used to fake the hardware passthrough
capability, on early VT-d hardware which doesn't implement the
passthrough mode. It's not any kind of protection domain, hence the OS
is not required to manage the cache synchronization.

Although I hope we can remove it someday and force the DMA domain
instead, we still need to carry it nowadays. However, we need to make it
consistent with the hardware passthrough. That is, hardware passthrough
doesn't require any cache invalidation in memory hot-plug paths, the
software passthrough should not either.

Best regards,
baolu

