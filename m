Return-Path: <linux-kernel+bounces-141295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C858A1C3C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 926542856D6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4643015B560;
	Thu, 11 Apr 2024 16:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OF74/pDH"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235571514C7
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 16:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712852004; cv=none; b=qCDwvvqW3DQZoNnzHNcafwORaFoDqcwetGHqnlg0pwVBT+dSOmJWEDxUFzyzz4NPXBFp4zhTpYeJLtdlSBYM1fn8UtFdkocSEaK0A9QSJFT7crRXBTZVs8HT+XutXdnsIcXRrRGjxmWddQZBK7QMPqqj9PowGjtxks4qYQmxvl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712852004; c=relaxed/simple;
	bh=tCCBcJnRbz3n4CBXmbeZiDjsy06LWfoWVjBmcrN/U7A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ri2C2lm/+uNWWOiqCP8nsBNHZSpEHBTjo9UEIC+bivv1WSOjwb/wI0wezkpiNc8vCCGbcww0dKT1jl1+pnqX2aFivh+TGoax3b9bhEJFAlrqmeli+XsUxgJadiReMRk8dhNaQFKkycFYYpS+I1smayHRprMcnagmfjGeGworVWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OF74/pDH; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712852003; x=1744388003;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tCCBcJnRbz3n4CBXmbeZiDjsy06LWfoWVjBmcrN/U7A=;
  b=OF74/pDH0aFmGTWnSXcLkMEm4dYxIPYfUtG3xHcmwwTYsdHtO4qlJA+C
   iOiWcISOH+p5b4q7i4TxuQh1KBOo7O0dfq49Md9CuWtoPJ4w/b3sG5D64
   Kgqewzt1mrguQmUIbXqcSFt2Sm7Y7RDGjXbHNpvpKvUVXX+DUSAw6pjDh
   D774ain/d715tSeuqQmRJZ+VWwKgcfu8de3FS6rXHifj7IpJLYbD5Rdx8
   q5oFwHVi0rMJ2tifdSla9KEPynJXicSN38vYMqSl10gpZFftThyZSd+x8
   nLV8ZxhPmiFz7QAFfoqph7wWuIOKlBsFiSxSS+3o/XVa0d/u06vkBwSSI
   w==;
X-CSE-ConnectionGUID: Ypri3OcVSZWMbBK5MDtoHg==
X-CSE-MsgGUID: m2Tq9zuIRg6MB/22ruhyPw==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="8405198"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="8405198"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 09:13:19 -0700
X-CSE-ConnectionGUID: wmsppSE+T3KmTbVvEwIwYw==
X-CSE-MsgGUID: 78q6r7BoSc6CYStYktSTHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="58364178"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.54.39.125])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 09:13:19 -0700
Date: Thu, 11 Apr 2024 09:17:49 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, "Liu, Yi L" <yi.l.liu@intel.com>, Joerg Roedel
 <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
 <robin.murphy@arm.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH 2/2] iommu/vt-d: Remove caching mode check before devtlb
 flush
Message-ID: <20240411091749.20afae6b@jacob-builder>
In-Reply-To: <BN9PR11MB5276DDE04A315B1F870872468C062@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240407144232.190355-1-baolu.lu@linux.intel.com>
	<20240407144232.190355-2-baolu.lu@linux.intel.com>
	<20240408140329.6290377f@jacob-builder>
	<aff42b8f-b757-4422-9ebe-741a4b894b6c@linux.intel.com>
	<20240409103146.0d155e45@jacob-builder>
	<BN9PR11MB52763F42ED6719E6D03D0D308C062@BN9PR11MB5276.namprd11.prod.outlook.com>
	<20240410091955.5c00e411@jacob-builder>
	<BN9PR11MB5276DDE04A315B1F870872468C062@BN9PR11MB5276.namprd11.prod.outlook.com>
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

On Wed, 10 Apr 2024 23:23:57 +0000, "Tian, Kevin" <kevin.tian@intel.com>
wrote:

> > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Sent: Thursday, April 11, 2024 12:20 AM
> > 
> > Hi Kevin,
> > 
> > On Wed, 10 Apr 2024 00:32:06 +0000, "Tian, Kevin" <kevin.tian@intel.com>
> > wrote:
> >   
> > > > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > > Sent: Wednesday, April 10, 2024 1:32 AM
> > > >
> > > > If the guest uses SL page tables in vIOMMU, we don;t expose ATS to
> > > > the guest. So ATS is not relevant here, does't matter map or unmap.
> > > >  
> > >
> > > ATS is orthogonal to SL vs. FL. Where is this restriction coming
> > > from?  
> > For practical purposes, what would be the usage to have SL in the guest
> > and ATS enabled. i.e. shadowing SL but directly expose ATS?
> >   
> 
> ATS is about the protocol between device and iommu to look up
> translations. Why does it care about internal paging layout in
> iommu?
> 
Maybe the original intent was missed, I was suggesting the devTLB flush
should be based on ATS cap (as you said here) not map/unmap.
 
-       /*
-        * In caching mode, changes of pages from non-present to present require
-        * flush. However, device IOTLB doesn't need to be flushed in this case.
-        */
-       if (!cap_caching_mode(iommu->cap) || !map)
-               iommu_flush_dev_iotlb(domain, addr, mask);
+       iommu_flush_dev_iotlb(domain, addr, mask);


Thanks,

Jacob

