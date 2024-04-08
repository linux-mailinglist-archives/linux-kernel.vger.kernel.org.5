Return-Path: <linux-kernel+bounces-135688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F79189C9BD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 18:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83C641C24639
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31573142E8F;
	Mon,  8 Apr 2024 16:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GCgEgaAZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103BE142E85
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 16:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712594103; cv=none; b=VGH4lclL+AzIQnNAb3V44DBmRjZiuUSxnueZTipWGIJ7BIdU70pFzEIY7n2UyE2geWVAF43YYC8S1ALEC13zn+YBjaWZZKiTOkS0kgXPDgLlL/5J5sqqwfCV64ifVeK7sknXJxSWGFPJSes9iVaUfZYp/xrdX0DTYqXQWsKj6Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712594103; c=relaxed/simple;
	bh=MwPlIh32++bFzV6p+9AvCTR3WEciP8K3VR75lLJlj6U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GK+nE1rLM7cxF4/psDaFhFdyRNL1nWcp9scrRbQrBSwweaLgrOd8MmLJnLOmBiWvc74arkeV9VSIlXw9ktsGe7Ar72UVP27tk2WL23KPC5mhJn54MoTYWMSTKKr+MI43wPfimDJooQSiBQRQ5eanPRjCIk9DiiJzqE8wBmHfN38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GCgEgaAZ; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712594103; x=1744130103;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MwPlIh32++bFzV6p+9AvCTR3WEciP8K3VR75lLJlj6U=;
  b=GCgEgaAZIlAFM/JfLXxMN0e1qy7q3Z7zqGe3BFNn9K2c2opu5qKPIjzt
   WEUoAjmzMp64laCPoqcBkYrsH93rG7zWbJuOzirBkkSaITC+VrjPBT+XL
   79o18CsSLajfHeRPhYBjVaH1K2ev7kF1fETiNzFrLBbzBj3umA882A8m2
   BKP09XK2ZaWpSOyRiK0GQA6SpDdeGwNTPNPOfibTtiS8ZyGGTcKEVZUfM
   9cdBSWJkE6vCJaZM6lXyfHrhQsrRzdcLqP5fO7KA3vxGNOTimN2tgIBFQ
   lV6UFocQ0pG5DIcNP521heSll+PipzWDcH4OZzCx6HfZ6miTh5dgoo27x
   w==;
X-CSE-ConnectionGUID: zDuqMu2PTEGDBgAEYRVX5w==
X-CSE-MsgGUID: 1vxK5uwhRuWVfftkmYKQvQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="19315636"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="19315636"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 09:35:02 -0700
X-CSE-ConnectionGUID: 3aJmJTHiTKCgnbKS8eC6EA==
X-CSE-MsgGUID: scKAYNiSRYObcLzhJQ55sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="43113931"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.54.39.125])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 09:35:01 -0700
Date: Mon, 8 Apr 2024 09:39:30 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, Dimitri Sivanich
 <sivanich@hpe.com>, Thomas Gleixner <tglx@linutronix.de>, Joerg Roedel
 <joro@8bytes.org>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, David
 Woodhouse <dwmw2@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Peter
 Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, YueHaibing
 <yuehaibing@huawei.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Steve Wahl
 <steve.wahl@hpe.com>, "Anderson, Russ" <russ.anderson@hpe.com>,
 jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v2] iommu/vt-d: Allocate DMAR fault interrupts locally
Message-ID: <20240408093930.45422bc1@jacob-builder>
In-Reply-To: <BN9PR11MB527627689CCBBFEAFC6745568C002@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <Zfydpp2Hm+as16TY@hpe.com>
	<BN9PR11MB52765241E3261B58BE93E8A88C002@BN9PR11MB5276.namprd11.prod.outlook.com>
	<ec0ff625-855c-4dba-b19f-db050671fbfb@linux.intel.com>
	<BN9PR11MB527627689CCBBFEAFC6745568C002@BN9PR11MB5276.namprd11.prod.outlook.com>
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

Hi Kevin,

On Mon, 8 Apr 2024 09:00:05 +0000, "Tian, Kevin" <kevin.tian@intel.com>
wrote:

> > From: Baolu Lu <baolu.lu@linux.intel.com>
> > Sent: Monday, April 8, 2024 3:22 PM
> > 
> > On 2024/4/8 14:54, Tian, Kevin wrote:  
> > >> From: Dimitri Sivanich <sivanich@hpe.com>
> > >> Sent: Friday, March 22, 2024 4:51 AM
> > >>
> > >> The Intel IOMMU code currently tries to allocate all DMAR fault
> > >> interrupt vectors on the boot cpu.  On large systems with high DMAR
> > >> counts this results in vector exhaustion, and most of the vectors
> > >> are not initially allocated socket local.
> > >>
> > >> Instead, have a cpu on each node do the vector allocation for the
> > >> DMARs  
> > on  
> > >> that node.  The boot cpu still does the allocation for its node
> > >> during its boot sequence.
> > >>
> > >> Signed-off-by: Dimitri Sivanich <sivanich@hpe.com>  
> > >
> > > Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> > >  
> > 
> > Kevin,
> > 
> > Jacob has another proposal which shares the irq among all IOMMUs.
> > 
> > https://lore.kernel.org/linux-iommu/20240403234548.989061-1-
> > jacob.jun.pan@linux.intel.com/
> > 
> > How do you like this?
> >   
> 
> I'm a bit concerning about the need of looping all IOMMU's in DMAR
> irqchip mask/unmask handlers. this one sounds simpler to me.
The difference is that with this patch, we still burn a few vectors on BSP
and the leading CPU of each socket.

e.g. on sapphire rapids, we lose 8 vectors to DMAR fault IRQ on BSP.

Thanks,

Jacob

