Return-Path: <linux-kernel+bounces-134223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D54F89AF39
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 09:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF59BB2120D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 07:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9A88F72;
	Sun,  7 Apr 2024 07:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SWYtJxKr"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0928D10A23
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 07:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712474972; cv=none; b=Liocx5fYOkq9Ghbm9J2z/xmVMMpW1Uh3N7hED/7sI+ywNA03ZERkm2XUqAvM0zN5yCUmZRUdWD3u4DsS57E1WLTgaIcw9kl2VP41cogsbKTbruHDw06xWUG4AOSj5HdUM3KjfQThtjJOyIm86Osuzuev312oWRm4B1Qzlm/AGHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712474972; c=relaxed/simple;
	bh=oegOZxAKMmIs+FUbmGggNTdmhPzqyGI38fezqk9NBoQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JILvyw/Ad5s5U/tbP4LeJKxkeC1RSkwv0EAhoUQoo4xvxzVy9eJaQJHqKj0VvoFhGfso5uALkkz3hgTsvdzHRMzUgsXzU5bg0qEHzFy0ET/aIR2vSZolbbJKI6lrtMSPjTRD50uB0hTIDNqVJIvWR68Wdrsyta3x73xX0nAjPco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SWYtJxKr; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712474971; x=1744010971;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oegOZxAKMmIs+FUbmGggNTdmhPzqyGI38fezqk9NBoQ=;
  b=SWYtJxKrEgIaylhP+keJqtxaAou8dciwnpBXmYUSNnC9c6olmWElkfzc
   Re+TiWBnPjbpYJMrH7u8pwD+PKumR82vzGv/f+gdryGoXYdNEWpFzCLsO
   uLv3kJHCt82dD5e5QeOygKpw6Cy1rAszt668T/CD2LUr+aLbM01XAhHr+
   57v8WnE+qSKUr6qieLDTaN9U+QQfx+mxjk6y2clSbRwkWchVNajOgSgfo
   3WHnp1LYNv7FvknKwny8/9MCp2CM1jB6yZUpoYYteV9FiXwTV9R6s6CBP
   WJN3NpyUrNh5/jCuzsaj4lh9lcd5Yvx8M0G6tkrnC5egVjiUrVlh/zasl
   w==;
X-CSE-ConnectionGUID: H9q20hjGS1+ccafG9BUnWw==
X-CSE-MsgGUID: 2ni9JRriRRWhK8FgeYcvLQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11036"; a="33162970"
X-IronPort-AV: E=Sophos;i="6.07,184,1708416000"; 
   d="scan'208";a="33162970"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2024 00:29:29 -0700
X-CSE-ConnectionGUID: PHFVHD3kS7mePUJRP+UoNw==
X-CSE-MsgGUID: yX/4fWnLQS2NZdh97lhW1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,184,1708416000"; 
   d="scan'208";a="50544993"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa002.jf.intel.com with ESMTP; 07 Apr 2024 00:29:25 -0700
Message-ID: <2256b869-d0c2-49b4-b6cc-89e59d40386f@linux.intel.com>
Date: Sun, 7 Apr 2024 15:28:19 +0800
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
Subject: Re: [PATCH 00/12] Consolidate domain cache invalidation
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>
References: <20240325021705.249769-1-baolu.lu@linux.intel.com>
 <BN9PR11MB5276088E9D595A903E9255E48C3B2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276088E9D595A903E9255E48C3B2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/28/24 3:59 PM, Tian, Kevin wrote:
>> From: Lu Baolu<baolu.lu@linux.intel.com>
>> Sent: Monday, March 25, 2024 10:17 AM
>>
>> The IOMMU hardware cache needs to be invalidated whenever the
>> mappings
>> in the domain are changed. Currently, domain cache invalidation is
>> scattered across different places, causing several issues:
>>
>> - IOMMU IOTLB Invalidation: This is done by iterating through the domain
>>    IDs of each domain using the following code:
>>
>>          xa_for_each(&dmar_domain->iommu_array, i, info)
>>                  iommu_flush_iotlb_psi(info->iommu, dmar_domain,
>>                                        start_pfn, nrpages,
>>                                        list_empty(&gather->freelist), 0);
>>
>>    This code could theoretically cause a use-after-free problem because
>>    there's no lock to protect the "info" pointer within the loop.
>>
>> - Inconsistent Invalidation Methods: Different domain types implement
>>    their own cache invalidation methods, making the code difficult to
>>    maintain. For example, the DMA domain, SVA domain, and nested domain
>>    have similar cache invalidation code scattered across different files.
>>
>> - SVA Domain Inconsistency: The SVA domain implementation uses a
>>    completely different data structure to track attached devices compared
>>    to other domains. This creates unnecessary differences and, even
>>    worse, leads to duplicate IOTLB invalidation when an SVA domain is
>>    attached to devices belonging to different IOMMU domains.
> can you elaborate how duplicated invalidations are caused?

Yes, sure.

Current Intel SVA implementation keeps the bond between mm and a PASID
of a device in a list of intel_svm_dev. In the mm notifier callback, it
iterates all intel_svam_dev in the list and invalidates the IOTLB and
device TLB sequentially.

If multiple devices belong to a single IOMMU, the IOTLB will be flushed
multiple times. However, since these devices share the same domain ID
and PASID, a single IOTLB cache invalidation is sufficient. The
additional flushes are redundant and negatively impact performance.

Best regards,
baolu

