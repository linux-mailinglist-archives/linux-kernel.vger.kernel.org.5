Return-Path: <linux-kernel+bounces-40324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2429583DE87
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BACE3B24049
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0811B5B1;
	Fri, 26 Jan 2024 16:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="L+pJ0gQW"
Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC361CF90
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 16:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.93.223.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706286069; cv=none; b=W75CxVDLKzF9u60cgTwB7uvajZ8WKJg77BaXebQeNTd/duFmGIpo4WZkiTX2n6nsbX+PHXcOfCMKVK+IpFTXeERadBRTCp9KBALojf754YoQe55SQ754oMNjco26DYWJfygXE4sdCrae+HXrcF5W0Hh/BLZx8sPUK6l6ivZh9ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706286069; c=relaxed/simple;
	bh=XbFTSyVW06Iaz2yZpMZPpFNnQ89qLLom1HMrMNtKv1M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wi4vdTZIRFe1D1HW6CzyBxoJZlrppznd6UMAwBGZ4YPVP+mWYuyoAdXVRarGIBWxpmzJJmM8QmBK5f4bPiDNzpg2AMQ2YhEbHfEfzlWv1HCxTI0FFuuzB+Tn66NiF9YJu9JpKjbj14qynNX2E9mnQdj+NqUDmZY+I3jRnQWAyhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=L+pJ0gQW; arc=none smtp.client-ip=77.93.223.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id DBF8618C8FB;
	Fri, 26 Jan 2024 17:21:00 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
	t=1706286061; bh=XbFTSyVW06Iaz2yZpMZPpFNnQ89qLLom1HMrMNtKv1M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=L+pJ0gQWzLC5yCJtUQqqH9mAvCH4/F462d1zWXlEM++WR33kntMzS6tLrRn2K8PIq
	 FI7tFkAAnLFa5HKSI9TNRkivufjpN72EYx6pa5HxKYbtzFIqVRNog1C8Lk7NE4g8H2
	 ODQe1OqjOQFWg4JldbY6TATkm8np0jzjvjJasCKW+VO+OD0IB+zs08h621FeOIIxvA
	 dnZc2VcVNtK+qEA1jNGADY78yxUOS+LdBRYW+3p3Czqxgfo4sscfMZMjMFmKfU8jh3
	 p1WboComAH7QjDtX6700UxTKqVU+cHmKW5j3fdwKC9W4f0z6s7VJjubxl22CXhuRpo
	 +uaVEZ5TicAuQ==
Date: Fri, 26 Jan 2024 17:20:59 +0100
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com,
 iommu@lists.linux.dev, Christoph Hellwig <hch@lst.de>, Marek Szyprowski
 <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Petr
 Tesarik <petr.tesarik1@huawei-partners.com>, Dexuan Cui
 <decui@microsoft.com>
Subject: Re: [PATCH 0/2] Fix double allocation in swiotlb_alloc()
Message-ID: <20240126172059.48ad7b9f@meshulam.tesarici.cz>
In-Reply-To: <20240126151956.10014-1-will@kernel.org>
References: <20240126151956.10014-1-will@kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Will,

On Fri, 26 Jan 2024 15:19:54 +0000
Will Deacon <will@kernel.org> wrote:

> Hi folks,
> 
> These two patches fix a nasty double allocation problem in swiotlb_alloc()
> and add a diagnostic to help catch any similar issues in future. This was
> a royal pain to track down and I've had to make a bit of a leap at the
> correct alignment semantics (i.e. iotlb_align_mask vs alloc_align_mask).

Welcome to the club. I believe you had to re-discover what I described here:

  https://lore.kernel.org/linux-iommu/20231108101347.77cab795@meshulam.tesarici.cz/

The relevant part would be this:

  To sum it up, there are two types of alignment:

  1. specified by a device's min_align_mask; this says how many low
     bits of a buffer's physical address must be preserved,

  2. specified by allocation size and/or the alignment parameter;
     this says how many low bits in the first IO TLB slot's physical
     address must be zero.  

Fix for that has been sitting on my TODO list for too long. :-(

Petr T

> Without these changes, we've been observing random vsock hangs when
> communicating with virtual machines in Android.
> 
> Please have a look!
> 
> Cheers,
> 
> Will
> 
> Cc: iommu@lists.linux.dev
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Petr Tesarik <petr.tesarik1@huawei-partners.com>
> Cc: Dexuan Cui <decui@microsoft.com>
> 
> --->8  
> 
> Will Deacon (2):
>   swiotlb: Fix allocation alignment requirement when searching slots
>   swiotlb: Enforce page alignment in swiotlb_alloc()
> 
>  kernel/dma/swiotlb.c | 32 ++++++++++++++++++++++----------
>  1 file changed, 22 insertions(+), 10 deletions(-)
> 


