Return-Path: <linux-kernel+bounces-156232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0151D8AFFFC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 05:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 959D01F247BC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 03:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958C113E8AF;
	Wed, 24 Apr 2024 03:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M4y0Hhn1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D3713C82F
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 03:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713930298; cv=none; b=miIPz4Qgag+kBrrwioNP3gcFRN9xyxVhmPHPWeNrLWFHVUSqpbFFXMjzNCn259FWw2FE9Z5hdNlOSicakjuBdX+FY7ltQUYgnGfjfLD8oe+rdkfjCymWXW/2UGej7t44r6LJFxyLW7EdDtv+aH9LuvdyNsk7aGT//lhf4qhpN7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713930298; c=relaxed/simple;
	bh=k4ri3X4W0eb+g0rZLGMhcbWzg5Ntju/ygoN7+pfEGfs=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=V0VScXnO5l++/3Sdmhg5wcnvbd6K/j4zVfZD3na/bCQganxKXaXFEgFRS7rWY4NQa3DPJcPuVkySeQHJ0KZ2Pvi0abdiDlSB2HDq3NrlEin7eK2dw1rIZpVVC1QjMo57+3h/oKxxI+qHTq3P10byO5Yocs+Ut7aYK5lt3pCtRyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M4y0Hhn1; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713930298; x=1745466298;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=k4ri3X4W0eb+g0rZLGMhcbWzg5Ntju/ygoN7+pfEGfs=;
  b=M4y0Hhn196gqutn8OMt0vrgdgTBtmolBnCbqAZC8Y5pKzyY33gb9uEj0
   2Tiu3thPPCKfXuadbetk93ByXcCNBX3//vPxAaTblFRxF1TCJCe8El+7m
   0uzaxhUpY/MnAcsMppZFQKS/r+EOtfqtdKPPpDBm8exLyEef9ipIlYFiP
   tb0pYyLklALUEsH3sHjezdYQ1Lsm2QVFuP2MD24L6YunwrVo0xtp9Owbf
   CovAj1w/v5JtQ4zHT7HgSUV50Fd2tuKrLNaIHUcJuNOn90L2r/ZMbjCw0
   lXvIaDKRGJo2r8Y17DWF8h25k7Jxc1S48v0OZvligjWRtWlyv0JjVYC7X
   Q==;
X-CSE-ConnectionGUID: CojGh8JjQfmxEYfS5I3JOA==
X-CSE-MsgGUID: y5OAN/NwSbmxupCp4/LoBA==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="9660465"
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="9660465"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 20:44:57 -0700
X-CSE-ConnectionGUID: 5SXu89jTSqSNgLuYHCHifA==
X-CSE-MsgGUID: IaOA1sGfRMG+oMf7Fm/4xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="29365322"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa005.jf.intel.com with ESMTP; 23 Apr 2024 20:44:54 -0700
Message-ID: <a2d1c44d-6450-4641-843e-8981bdb4d533@linux.intel.com>
Date: Wed, 24 Apr 2024 11:43:30 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, linux-kernel@vger.kernel.org,
 Steve Wahl <steve.wahl@hpe.com>, Russ Anderson <russ.anderson@hpe.com>
Subject: Re: [PATCH v2] iommu/vt-d: Allocate DMAR fault interrupts locally
To: Dimitri Sivanich <sivanich@hpe.com>, Thomas Gleixner
 <tglx@linutronix.de>, Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 David Woodhouse <dwmw2@infradead.org>, Mark Rutland <mark.rutland@arm.com>,
 Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>,
 YueHaibing <yuehaibing@huawei.com>, iommu@lists.linux.dev
References: <Zfydpp2Hm+as16TY@hpe.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <Zfydpp2Hm+as16TY@hpe.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/22/24 4:50 AM, Dimitri Sivanich wrote:
> The Intel IOMMU code currently tries to allocate all DMAR fault interrupt
> vectors on the boot cpu.  On large systems with high DMAR counts this
> results in vector exhaustion, and most of the vectors are not initially
> allocated socket local.
> 
> Instead, have a cpu on each node do the vector allocation for the DMARs on
> that node.  The boot cpu still does the allocation for its node during its
> boot sequence.
> 
> Signed-off-by: Dimitri Sivanich<sivanich@hpe.com>
> ---
> 
> v2: per Thomas Gleixner, implement this from a DYN CPU hotplug state, though
>      this implementation runs in CPUHP_AP_ONLINE_DYN space rather than
>      CPUHP_BP_PREPARE_DYN space.

Patch has been queued for iommu/vt-d.

Best regards,
baolu

