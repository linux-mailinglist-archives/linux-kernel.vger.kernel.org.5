Return-Path: <linux-kernel+bounces-140486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2798A1556
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A35012825F1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BAB714C597;
	Thu, 11 Apr 2024 13:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XrTQIeY3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEE128FD
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 13:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712841204; cv=none; b=d+j+dxIJRHBfLt3vzBzDTbhh2pD8lm1Ir0HmulCNQw8h0Fn1HxOr4brdk4vWwDwPtcZQWcCAeKmaVvCQLVwXxR0OQBwIraCno1AoH9XPrc7l49005wb0Xn2ShJjY/na2P8LQT3bw6bBsJMQ62tPW+Q0UZGToSxVMYuQYacikHNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712841204; c=relaxed/simple;
	bh=Qc0t+cqqeoMdgUIn/T47SwdSm2G2cSbQh1SlaJhaCXc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=R2QEYG+YfEzijbuVx+S7gOGXns85XaX8p+R1cFike+diu10DC9uvsyVZXITXEXZmu7lzb5Re0aHjOYFp66nzRJhFBUxwpG4fVdUTpeRwpPP4AsJU2zKd+lJ7c2pBb8atE7HeAmIQgXTEpCQ5Kx65nPQDYrxfryQMwhLhT4cu7Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XrTQIeY3; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712841203; x=1744377203;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Qc0t+cqqeoMdgUIn/T47SwdSm2G2cSbQh1SlaJhaCXc=;
  b=XrTQIeY3R949q19BxD60BtD/fNpTSiHoTWTfJ5/RXjXw+FHeA9Ev/YvA
   VCNenCufrRG2xsNrYBwzGQiUt+3HvK/6NzkRDgYf9Jab8LdvFqkkNST3D
   s1/R8RgZ+kFupKXPlgeuBeJ3kb3pDWH5gPbTxCMF2Nev2eblMbGWmTByT
   Kl/zdwWFMV9kvGgTszREoUBvPgujT0Qi9AHez17LIxT8SMYYkeuGj5fkd
   u2aFyQh67fZGjE/VnskWQmbrDuIEOU5LyFzR4G+iYUYDD029v0S9hZJ+9
   ilEVKtkdhiPkfDGe+B4t3oRoltKB4VOS7V7DR5WgYMriQOfKJUcpdME5k
   w==;
X-CSE-ConnectionGUID: HcUKcSMTTu+qi5kz634NgQ==
X-CSE-MsgGUID: 8Y9oBlNYRu6ytz4BMVZZgA==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="8808910"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="8808910"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 06:13:22 -0700
X-CSE-ConnectionGUID: BS9oqWvmRAGAwxMO9xlh1w==
X-CSE-MsgGUID: tJcYxFp1SZKyrviBDzrgMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="20857588"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.237.86]) ([10.124.237.86])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 06:13:20 -0700
Message-ID: <83c02530-230a-4ae0-8853-5da95c0ee814@linux.intel.com>
Date: Thu, 11 Apr 2024 21:13:17 +0800
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
Subject: Re: [PATCH v2 12/12] iommu/vt-d: Retire struct intel_svm
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20240410020844.253535-1-baolu.lu@linux.intel.com>
 <20240410020844.253535-13-baolu.lu@linux.intel.com>
 <20240410154951.GH223006@ziepe.ca>
 <b24f3380-1ac3-41c4-9163-56c1dcff6297@linux.intel.com>
 <20240411130759.GJ223006@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240411130759.GJ223006@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/4/11 21:07, Jason Gunthorpe wrote:
>> +static void intel_mm_free_notifier(struct mmu_notifier *mn)
>> +{
>> +       kfree(container_of(mn, struct dmar_domain, notifier));
>> +}
>> +
>>   static const struct mmu_notifier_ops intel_mmuops = {
>>          .release = intel_mm_release,
>>          .arch_invalidate_secondary_tlbs =
>> intel_arch_invalidate_secondary_tlbs,
>> +       .free_notifier = intel_mm_free_notifier,
>>   };
>>
>>   static int intel_svm_set_dev_pasid(struct iommu_domain *domain,
>> @@ -598,10 +604,8 @@ static void intel_svm_domain_free(struct iommu_domain
>> *domain)
>>   {
>>          struct dmar_domain *dmar_domain = to_dmar_domain(domain);
>>
>> -       if (dmar_domain->notifier.ops)
>> -               mmu_notifier_unregister(&dmar_domain->notifier, domain->mm);
>> -
>> -       kfree(dmar_domain);
>> +       /* dmar_domain free is defered to the mmu free_notifier callback. */
>> +       mmu_notifier_put(&dmar_domain->notifier);
>>   }
> Yeah, that is better.
> 
> Also you need to have mmu notifier call on module unload when using
> this scheme.

The Intel IOMMU driver doesn't support being a module. It's always
built-in.

Best regards,
baolu

