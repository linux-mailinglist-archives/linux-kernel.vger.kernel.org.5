Return-Path: <linux-kernel+bounces-159825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBED58B34C1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 12:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 712231F213CD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 10:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942A21422B9;
	Fri, 26 Apr 2024 10:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="lSQEAS0C"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC7E140E5B
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 10:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714125612; cv=none; b=ZhqZ9slRkP27F46xBIjf8OhcGCDQlplTSxdHzB/GgbOnNcDTipURQiuZeBgLX0bkv5vjbVu0U5rKcsN3JVl7bz/v/KsqAxUjqLLF75XePs93m3wIVL9JrAi17mFcXeWfwldHgZY++2kJEopObN3raYJoM50OvcW7PHsgeIAk4s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714125612; c=relaxed/simple;
	bh=r6GUCjPgtji6vDOtOiNTWM0Y3FXYkj6BW+6RBQeNV+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DRnLqyxPL5J345K/OReiBSVWgSqn9MEftn//5CgUoe7TNHODpVzaxeCHtM30mqm9LATWk+tW0L2bifti8PUijkRKUzVzTRv3QAJG9RtL2p1ZkJO6k3mNTs7Krac6xPLMVhRyYLnnD14XfsARWnBAPQAl+UMlq13OWOrIIyEquZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=lSQEAS0C; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe0bdf.dip0.t-ipconnect.de [79.254.11.223])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 6A0961C7883;
	Fri, 26 Apr 2024 12:00:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1714125604;
	bh=r6GUCjPgtji6vDOtOiNTWM0Y3FXYkj6BW+6RBQeNV+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lSQEAS0Cg9WchmNta5ScF/4toH88jFoavnFIXxk0YlozO6MQZ2TT2hllXjizgkJEG
	 A89lTwEatA232UzUtiHqWxetZXglQ81a3e4vkn07x4mJDqdW8ZULzgg3XOTwUajYv1
	 CpBMeEYV3XHx+Hp+xSe5V14/v/EjJjJGZ20Xtxlz/wJtwkBzrKN1RamlDsN/WCkhhC
	 CxaUAakUf7YzgSNrQNYUsnstmZJhLjghgPeKOkI4HzMv9NaIRb6+xLTrJ3nQDDCJT8
	 zagyC1X9q8Qro7Pux2D8CohsPVfzkHc099l+DA4ofJKLBA+7Z7/aiwKM88t0n20YUW
	 CoSCJwfQpbQ1w==
Date: Fri, 26 Apr 2024 12:00:02 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Jingqi Liu <Jingqi.liu@intel.com>,
	Dimitri Sivanich <sivanich@hpe.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	Colin Ian King <colin.i.king@gmail.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/18] [PULL REQUEST] Intel IOMMU updates for v6.10
Message-ID: <Zit7IrYn0dkXps8w@8bytes.org>
References: <20240424071644.178250-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424071644.178250-1-baolu.lu@linux.intel.com>

On Wed, Apr 24, 2024 at 03:16:26PM +0800, Lu Baolu wrote:
> Colin Ian King (1):
>   iommu/vt-d: Remove redundant assignment to variable err
> 
> Dimitri Sivanich (1):
>   iommu/vt-d: Allocate DMAR fault interrupts locally
> 
> Jason Gunthorpe (1):
>   iommu: Add ops->domain_alloc_sva()
> 
> Jingqi Liu (2):
>   iommu/vt-d: Remove debugfs use of private data field
>   iommu/vt-d: Remove private data use in fault message
> 
> Lu Baolu (12):
>   iommu/vt-d: Remove caching mode check before device TLB flush
>   iommu/vt-d: Add cache tag assignment interface
>   iommu/vt-d: Add cache tag invalidation helpers
>   iommu/vt-d: Add trace events for cache tag interface
>   iommu/vt-d: Use cache_tag_flush_all() in flush_iotlb_all
>   iommu/vt-d: Use cache_tag_flush_range() in tlb_sync
>   iommu/vt-d: Use cache_tag_flush_range_np() in iotlb_sync_map
>   iommu/vt-d: Cleanup use of iommu_flush_iotlb_psi()
>   iommu/vt-d: Use cache_tag_flush_range() in cache_invalidate_user
>   iommu/vt-d: Use cache helpers in arch_invalidate_secondary_tlbs
>   iommu/vt-d: Remove intel_svm_dev
>   iommu/vt-d: Remove struct intel_svm
> 
> Uros Bizjak (1):
>   iommu/vt-d: Use try_cmpxchg64{,_local}() in iommu.c

Pulled, thanks Baolu. Let's see how the conflict resolution goes on my
side.

