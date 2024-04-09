Return-Path: <linux-kernel+bounces-137401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B0889E184
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0FE1284473
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FB6156248;
	Tue,  9 Apr 2024 17:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BkOvB/vq"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCF0155A3D
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 17:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712683639; cv=none; b=gYOSKBWlTyXnHgBzbZCLjCy68UKdpfX78tPhs3fEGfIvL4oE/0NyMSwoPx83WvDw3dEZoIRWdjSk5jIUOWFl4ai/SEireJwntjSiLb77f/+gePcFfCchQWrePphjEiSvRWIai35HNFHoj0xWR6vOhz5oVwqwJ/WA2g2ErAnLmEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712683639; c=relaxed/simple;
	bh=ov5V6UUHjBzKmLOJ3+BcZdJeRQ2EaCxb3pY7asEm1lI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t0b475ec5KiRcnSHdLResF45gTMSTyNN7x2FlMed2l5s9z9Dyd+7xfEAEj9XnMSKWcLsFyT8lES+Lt+JF5X2SHtGGtywOyuoS3MhkXaAUOfzyWvHDMl+/kkmB7snTufBFyHipKJJlMp/gkJdrjiU+2T5kjWsXny7ZIyLDsWHx7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BkOvB/vq; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712683638; x=1744219638;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ov5V6UUHjBzKmLOJ3+BcZdJeRQ2EaCxb3pY7asEm1lI=;
  b=BkOvB/vqEnBxQLlUYl28ge2RS3WytKChJu3UaZziNSv0fk8tCG9ZDPze
   ibyI4m26/CpFKmKzSpcyFfqHbQMus8NhAvtX8NCWS9jltWfvcpq6+89wF
   SEJ2ASFA4cN5ocd7FQBsEUx8yVoqL/9djFst6LnT6uBZ1suSXIGoaRH5X
   JpoBndpYQlQz+zItrY6d84gZdkl7Gi91k5q5RLuTSo1PcrjgF1w2gegGM
   1Orn4qMSIQ0lR3asYRNIPej1zIqPuiL3E4Y8Me6enbGmcKKjkp4G6Ee+d
   kI+ZzAI3daK/+uP9D9dKYXB8s93a1YbBE318xAY1WvC5LNw8HU1CQofM2
   g==;
X-CSE-ConnectionGUID: DGSGcf1USR2On2FFZoCsNQ==
X-CSE-MsgGUID: BRl67DZpTU2GlkNItQX8Xw==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="33418083"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="33418083"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 10:27:17 -0700
X-CSE-ConnectionGUID: 77NcuDNEQ+SbvlNSD97f4g==
X-CSE-MsgGUID: G4EZT2SVQZC/uu10CKOQJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="24964206"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.54.39.125])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 10:27:17 -0700
Date: Tue, 9 Apr 2024 10:31:46 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>, Yi Liu
 <yi.l.liu@intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon
 <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 linux-kernel@vger.kernel.org, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH 2/2] iommu/vt-d: Remove caching mode check before devtlb
 flush
Message-ID: <20240409103146.0d155e45@jacob-builder>
In-Reply-To: <aff42b8f-b757-4422-9ebe-741a4b894b6c@linux.intel.com>
References: <20240407144232.190355-1-baolu.lu@linux.intel.com>
	<20240407144232.190355-2-baolu.lu@linux.intel.com>
	<20240408140329.6290377f@jacob-builder>
	<aff42b8f-b757-4422-9ebe-741a4b894b6c@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Baolu,

On Tue, 9 Apr 2024 11:12:20 +0800, Baolu Lu <baolu.lu@linux.intel.com>
wrote:

> On 4/9/24 5:03 AM, Jacob Pan wrote:
> > Hi Lu,  
> 
> Hi Jacob,
> 
> > 
> > On Sun,  7 Apr 2024 22:42:32 +0800, Lu Baolu<baolu.lu@linux.intel.com>
> > wrote:
> >   
> >> The Caching Mode (CM) of the Intel IOMMU indicates if the hardware
> >> implementation caches not-present or erroneous translation-structure
> >> entries except the first-stage translation. The caching mode is
> >> unrelated to the device TLB , therefore there is no need to check
> >> it before a device TLB invalidation operation.
> >>
> >> Before the scalable mode is introduced, caching mode is treated as
> >> an indication that the driver is running in a VM guest. This is just
> >> a software contract as shadow page table is the only way to implement
> >> a virtual IOMMU. But the VT-d spec doesn't state this anywhere. After
> >> the scalable mode is introduced, this doesn't stand for anymore, as
> >> caching mode is not relevant for the first-stage translation. A virtual
> >> IOMMU implementation is free to support first-stage translation only
> >> with caching mode cleared.
> >>
> >> Remove the caching mode check before device TLB invalidation to ensure
> >> compatibility with the scalable mode use cases.
> >>  
> > I agree with the changes below, what about this CM check:
> > 
> > /* Notification for newly created mappings */
> > static void __mapping_notify_one(struct intel_iommu *iommu, struct
> > dmar_domain *domain, unsigned long pfn, unsigned int pages)
> > {
> > 	/*
> > 	 * It's a non-present to present mapping. Only flush if caching
> > mode
> > 	 * and second level.
> > 	 */
> > 	if (cap_caching_mode(iommu->cap) && !domain->use_first_level)
> > 		iommu_flush_iotlb_psi(iommu, domain, pfn, pages, 0, 1);
> > 
> > We are still tying devTLB flush to CM=1, no?  
> 
> __mapping_notify_one() is called in the path where some PTEs are changed
> from non-present to present.
> 
> In this scenario,
> 
> - if CM is set and first-stage translation is not used, the IOTLB caches
>    are required to be explicitly flushed.
> - else if hardware requires write buffer flushing, do it.
> - Otherwise, no op.
> - devtlb invalidation is irrelevant to this path.
> 
> The code after the fix appears to do the right thing. devTLB is not
> invalidated in iommu_flush_iotlb_psi() since it's a map (map == 1).
> 
> Or perhaps I overlooked anything?
My confusion is that, on one side, this patch is saying devTLB flush has
nothing to do with CM. But here, if CMD==1, we don't flush devTLB since
map==1.

If the guest uses SL page tables in vIOMMU, we don;t expose ATS to the
guest. So ATS is not relevant here, does't matter map or unmap.

Can we remove the map argument in iommu_flush_iotlb_psi(iommu, domain,pfn,
pages, 0, 1)?

Then devTLB flush will naturally be skipped in the guest (CM=1, SL) since
ATS is not enabled.
iommu_flush_dev_iotlb(domain, addr, mask);

i.e.

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 50eb9aed47cc..ee3e5a1af0c5 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1483,7 +1483,7 @@ static void __iommu_flush_iotlb_psi(struct intel_iommu *iommu, u16 did,
 static void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
                                  struct dmar_domain *domain,
                                  unsigned long pfn, unsigned int pages,
-                                 int ih, int map)
+                                 int ih)
 {
        unsigned int aligned_pages = __roundup_pow_of_two(pages);
        unsigned int mask = ilog2(aligned_pages);
@@ -1501,12 +1501,7 @@ static void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
        else
                __iommu_flush_iotlb_psi(iommu, did, pfn, pages, ih);
 
-       /*
-        * In caching mode, changes of pages from non-present to present require
-        * flush. However, device IOTLB doesn't need to be flushed in this case.
-        */
-       if (!cap_caching_mode(iommu->cap) || !map)
-               iommu_flush_dev_iotlb(domain, addr, mask);
+       iommu_flush_dev_iotlb(domain, addr, mask);
 }
 
 /* Notification for newly created mappings */
@@ -1518,7 +1513,7 @@ static void __mapping_notify_one(struct intel_iommu *iommu, struct dmar_domain *
         * and second level.
         */
        if (cap_caching_mode(iommu->cap) && !domain->use_first_level)
-               iommu_flush_iotlb_psi(iommu, domain, pfn, pages, 0, 1);
+               iommu_flush_iotlb_psi(iommu, domain, pfn, pages, 0);
        else
                iommu_flush_write_buffer(iommu);
 }



> > 
> > If we are running in the guest with second level page table (shadowed),
> > can we decide if devTLB flush is needed based on ATS enable just as the
> > rest of the cases?  
> 
> I think the ATS check should be consistent. It's generic no matter how
> the IOMMU is implemented (in hardware or emulated in software).
> 
> Best regards,
> baolu


Thanks,

Jacob

