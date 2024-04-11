Return-Path: <linux-kernel+bounces-140054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8C08A0ADE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A008B1F269B5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17EC13FD6C;
	Thu, 11 Apr 2024 08:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MJb95FKo"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EAE664DD
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712823023; cv=none; b=q4+CW+u9IkSGbb/2nYrmKRjajSvBgAj8YyTT3uV26f2Ty3lxOn4QmAN6JRHgO9QPYYKzvEjR3ifljWSBIwgCXICb6wFCF/o9irxUZPoe7Y4EIMgWcZYViLI1/JH1IxDcGFQK0lUiBD+yiCqztPc//078X1sstC0I/8MgauokCVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712823023; c=relaxed/simple;
	bh=7cA/1qEogMEFNb22PO4vzxBgKD/wKOqdtHkJI14HFC4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TlyTIBaOnJtxViIOdWYNc5yGctf8TWGOYmCImmu380SS9BCckJY4gUSHnAfhSg2sjmCiMwWxvQ1eUTvss9aaj07dqPpR7rYQ/CsR3iesegkvxoGcEF9xIFdm5cK/ZC7lK/UqHbLqRn29htbKNTez3yuEC+yLHpeQLhMEg97QyOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MJb95FKo; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712823022; x=1744359022;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7cA/1qEogMEFNb22PO4vzxBgKD/wKOqdtHkJI14HFC4=;
  b=MJb95FKoACfi55slv1AA9tNAMNhQtJKieXKif9IdGJji3ijky9zEP8KP
   6bhWY/dKknWXFUll+CkZli/X+ARXzLHcjJ6BFsl8m/xSSxcwRcxIa6elF
   dsrQfbs+Nza8v9f1gOuELHS46QjdbWnWzUK9cquOFBSyOesKWnr1zdWra
   P26sHSs6FmuqyY7WfnQZg9UAuEBfRX0c507Ofvl8H/oAiUKqxVICFwr01
   LM68++P7C5Las/vAMvhdj9VN9ibOd5I93FxQD8bjV5AmV7ZDg7oFNiRFj
   +p1eBt3zojkDcsZPVAsFlZwI4TRZYxelZvBCCa74qgY+SHPUEBW6fseuU
   g==;
X-CSE-ConnectionGUID: SSuQpba3QE+fUthOXpJxWA==
X-CSE-MsgGUID: WFd6rzKtSyC68Dhw6yWaYw==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="25732095"
X-IronPort-AV: E=Sophos;i="6.07,192,1708416000"; 
   d="scan'208";a="25732095"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 01:10:21 -0700
X-CSE-ConnectionGUID: 53dMudwFSbmejBobPYGINQ==
X-CSE-MsgGUID: neryvS5nR9mHxDpxaEKXMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,192,1708416000"; 
   d="scan'208";a="20731757"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.237.86]) ([10.124.237.86])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 01:10:19 -0700
Message-ID: <a3070cd9-84d4-4a1b-a5c8-a37d9c3dae3e@linux.intel.com>
Date: Thu, 11 Apr 2024 16:10:15 +0800
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
Subject: Re: [PATCH v2 09/12] iommu/vt-d: Use cache helpers in
 arch_invalidate_secondary_tlbs
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20240410020844.253535-1-baolu.lu@linux.intel.com>
 <20240410020844.253535-10-baolu.lu@linux.intel.com>
 <20240410155535.GI223006@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240410155535.GI223006@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/4/10 23:55, Jason Gunthorpe wrote:
> On Wed, Apr 10, 2024 at 10:08:41AM +0800, Lu Baolu wrote:
>>   /* Pages have been freed at this point */
>>   static void intel_arch_invalidate_secondary_tlbs(struct mmu_notifier *mn,
>>   					struct mm_struct *mm,
>>   					unsigned long start, unsigned long end)
>>   {
>>   	struct intel_svm *svm = container_of(mn, struct intel_svm, notifier);
>> +	struct dmar_domain *domain = svm->domain;
>>   
>>   	if (start == 0 && end == -1UL) {
> 
> ULONG_MAX ideally.

Done.

> 
>> -		intel_flush_svm_all(svm);
>> +		cache_tag_flush_all(domain);
>>   		return;
>>   	}
>>   
>> -	intel_flush_svm_range(svm, start,
>> -			      (end - start + PAGE_SIZE - 1) >> VTD_PAGE_SHIFT, 0);
>> +	cache_tag_flush_range(domain, start, end, 0);
> 
> Be mindful of the note from the ARM driver:
> 
>          /*
>           * The mm_types defines vm_end as the first byte after the end address,
>           * different from IOMMU subsystem using the last address of an address
>           * range. So do a simple translation here by calculating size correctly.
>           */
>          size = end - start;

I didn't find any documentation about the @end in this callback, but in
mm subsystem, it does like this,

flush_tlb_mm_range(mm, va, va + nr_pages * PAGE_SIZE, PAGE_SHIFT, false);

So, yes, the @end in arch_invalidate_secondary_tlbs callback is
different from the iommu gather.

I was not aware of this. Thanks for pointing this out.

> 
> Given that the cache_tag_flush_range's are all tied directly to the
> iommu gather API, this is probably missing a -1 though perhaps it does
> not cause a functional problem here.

I will change it like below,

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 858a64fbdaab..15dcd1b30df1 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -146,7 +146,12 @@ static void 
intel_arch_invalidate_secondary_tlbs(struct mmu_notifier *mn,
                 return;
         }

-       cache_tag_flush_range(domain, start, end, 0);
+       /*
+        * The mm_types defines vm_end as the first byte after the end 
address,
+        * different from IOMMU subsystem using the last address of an 
address
+        * range.
+        */
+       cache_tag_flush_range(domain, start, end - 1, 0);
  }

  static void intel_mm_release(struct mmu_notifier *mn, struct mm_struct 
*mm)

Best regards,
baolu


