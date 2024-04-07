Return-Path: <linux-kernel+bounces-134214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC34089AF06
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 09:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 209EE283A01
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 07:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56080CA7A;
	Sun,  7 Apr 2024 07:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OBReMqu1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03195747F
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 07:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712474211; cv=none; b=FuPY372WoN/LdJw161NZ6Qb/QQEFVzSGjZA99u8ZSbDMOsWlh0vzqRhvX3lpA8EBcMQ2d7XAZdP00W5pm755t0uem0W5PQwSxmDyOQccx6Hpuz9cppIypte38Xo0Gyfv0ihxq+yxujrZWVAXjFr+53b4uFq5HWhuHAGyO1R0kIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712474211; c=relaxed/simple;
	bh=bwBsHXipUi5GvZ32GEuUHjanHNvSWk221rtqnfdMWi0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Q7NG2MiBQRtVNa4GV6ub4n6h7oB2SJyJzjPsXJLp8Z5hyD2e/lbeMeydN422fl2ZNVQbx/7ZgqqT8/Nwhqc+TE9qIA8BEwnQFf66XUECv6oU9ntm1kMpJoJL0mF+8QwsGvYwzKmN799NukcVs+iZw9T1fbDxB8ulTT6Dz5hV5/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OBReMqu1; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712474209; x=1744010209;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bwBsHXipUi5GvZ32GEuUHjanHNvSWk221rtqnfdMWi0=;
  b=OBReMqu1vbH+4LJu0RCdUQA1eF+u+Y/SDFEaO6qiAOO+nJpnbxIUEcUk
   ubLt4aCmGrb8ZjN4uqTI5a6cdfeqbTNzQTW+1n/8ymvaOtULCZSPMpP5y
   8zKzR382K1BouNJ7WMIug1hbaCOkzOgBFW5X8j0p1L2jB0zNqCtRUM820
   Cg1IfnbCZ+AcqffuqR9l31wRJuZKq3uvJrSzjorKWQvamX7TfHHbmBQfG
   LekJdba4f6F0bPBxktCFxqhuEkncHWE7Y0ADNOHOOqLQP293SX5YekkrN
   BRILAUdzMaR2+O2T6ds26A62uMXYmizSja/zD0AGYrLORv9R4pu9W9Igs
   w==;
X-CSE-ConnectionGUID: RJ1u70F2S0y1dBpcaRT11g==
X-CSE-MsgGUID: bcvsMSdXQNCdm18y6EK3nA==
X-IronPort-AV: E=McAfee;i="6600,9927,11036"; a="19130666"
X-IronPort-AV: E=Sophos;i="6.07,184,1708416000"; 
   d="scan'208";a="19130666"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2024 00:16:48 -0700
X-CSE-ConnectionGUID: 5hb4KSkCRn6WhlwidlcZGQ==
X-CSE-MsgGUID: GVJVWjcfQxOaaM36TE/Sqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,184,1708416000"; 
   d="scan'208";a="19689401"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa008.fm.intel.com with ESMTP; 07 Apr 2024 00:16:46 -0700
Message-ID: <d969d4b4-7583-4216-aef5-039c294a5a18@linux.intel.com>
Date: Sun, 7 Apr 2024 15:15:40 +0800
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
Subject: Re: [PATCH 08/12] iommu/vt-d: Use cache_tag_flush_range() in
 cache_invalidate_user
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>
References: <20240325021705.249769-1-baolu.lu@linux.intel.com>
 <20240325021705.249769-9-baolu.lu@linux.intel.com>
 <BN9PR11MB527607AB4F81EF2AEBD3D7868C3B2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB527607AB4F81EF2AEBD3D7868C3B2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/28/24 3:54 PM, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Monday, March 25, 2024 10:17 AM
>>
>> @@ -166,9 +122,9 @@ static int intel_nested_cache_invalidate_user(struct
>> iommu_domain *domain,
>>   			break;
>>   		}
>>
>> -		intel_nested_flush_cache(dmar_domain, inv_entry.addr,
>> -					 inv_entry.npages,
>> -					 inv_entry.flags &
>> IOMMU_VTD_INV_FLAGS_LEAF);
>> +		cache_tag_flush_range(dmar_domain, inv_entry.addr,
>> +				      inv_entry.npages,
>> +				      inv_entry.flags &
>> IOMMU_VTD_INV_FLAGS_LEAF);
> 
> the helper requires an 'end' address but 'npages' is incorrectly used here.

Oh yes! Thanks for pointing this out. I will fix it like below.

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index c139524274b9..cef997c07158 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1050,6 +1050,12 @@ static inline unsigned long 
aligned_nrpages(unsigned long host_addr, size_t size
         return PAGE_ALIGN(host_addr + size) >> VTD_PAGE_SHIFT;
  }

+/* Return a size from number of VTD pages. */
+static inline unsigned long nrpages_to_size(unsigned long npages)
+{
+       return npages << VTD_PAGE_SHIFT;
+}
+
  /* Convert value to context PASID directory size field coding. */
  #define context_pdts(pds)      (((pds) & 0x7) << 9)

diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
index e251507cfcc0..ffbd8d98a3b8 100644
--- a/drivers/iommu/intel/nested.c
+++ b/drivers/iommu/intel/nested.c
@@ -123,7 +123,7 @@ static int intel_nested_cache_invalidate_user(struct 
iommu_domain *domain,
                 }

                 cache_tag_flush_range(dmar_domain, inv_entry.addr,
-                                     inv_entry.npages,
+                                     inv_entry.addr + 
nrpages_to_size(inv_entry.npages) - 1,
                                       inv_entry.flags & 
IOMMU_VTD_INV_FLAGS_LEAF);
                 processed++;
         }

Best regards,
baolu

