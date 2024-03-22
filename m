Return-Path: <linux-kernel+bounces-111884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E64887229
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AD1B1C22CB8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6CF605CF;
	Fri, 22 Mar 2024 17:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="CIWEdOc/"
Received: from bee.tesarici.cz (bee.tesarici.cz [37.205.15.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E280605C8
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 17:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.15.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711129903; cv=none; b=AmgkzNom9zfVYYEkN1+oNULhfkMnUpwLe1chaIe+wKi8klJObA/dGUM8z1evxGDOCmJJQyfyt8w7GzmFpnKjaOpTBNVHi6Ws/Lfilu5oo0pA+3vf/TkjryZ2ErTBCLAFmKYIv+Yg9pG0VKfbFqATTRH+o/tpSL0dwgU9Gph4CXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711129903; c=relaxed/simple;
	bh=Xy6fuGyBECIuY3ohH/7MY26gAGWyuhCMWaGAqdMGGpI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CaJYPLASWC3wGfPJ8Br8jAywupZNS9ha+X5br33TSWXEp4xL8ZueXWMEnC14J+77mLicgyuYu6mgZrRye9t2rSWShI628pLuiHBEK3dfDSNXWsMQqBpX28PfC6Gt7AgsLuc18hFax8ewPP7J2AsLVnMfH22UnMyO/bo7cdzwcg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=CIWEdOc/; arc=none smtp.client-ip=37.205.15.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-b985-910f-39e1-703f.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:b985:910f:39e1:703f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id C1B5F1AB84A;
	Fri, 22 Mar 2024 18:51:39 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1711129900; bh=sCQm32WrW4hxeQOlo4+CbAT/ApEBh72zUZUhSQ2FlmU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CIWEdOc/zZZOq3Ugq1EiC64RPQBV1sLQ2pjEBrhs3AXf9pxLWNPAPFapLHzEiRjpN
	 PPb1mJLNvqMLoPONcnTd2HhDQYQH8QdMXabERrfl4fTn51uy7THsY+Z14WkuZfWXKM
	 Vl+vBWlDxL2V4dDrypYmn0cz+a4lEpF+8RiZ4SEW4WU5RiRSoxnHsyW5GS5LdjUWo/
	 fiNEQeSRvP0cUGmu/dJUxftJz9le+ZR6mrOI0I+v4/D6HjsHDAANceeEbuNtcpA8Si
	 wMQmrT5zH0hBbUbkAeYTivIOM3bGCQA6Ecq8x9xnYr4RXnhr9zWngSAt7+qVRUtFna
	 8omHoOUpjRsqw==
Date: Fri, 22 Mar 2024 18:51:38 +0100
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Will Deacon <will@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Marek Szyprowski
 <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Petr
 Tesarik <petr.tesarik1@huawei-partners.com>, Michael Kelley
 <mhklinux@outlook.com>, open list <linux-kernel@vger.kernel.org>, "open
 list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>, Roberto Sassu
 <roberto.sassu@huaweicloud.com>
Subject: Re: [PATCH v3 0/2] swiotlb: allocate padding slots if necessary
Message-ID: <20240322185138.1af83c61@meshulam.tesarici.cz>
In-Reply-To: <20240322150941.GA5634@willie-the-truck>
References: <20240321171902.85-1-petrtesarik@huaweicloud.com>
	<20240322150941.GA5634@willie-the-truck>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Mar 2024 15:09:41 +0000
Will Deacon <will@kernel.org> wrote:

> Hi Petr,
> 
> On Thu, Mar 21, 2024 at 06:19:00PM +0100, Petr Tesarik wrote:
> > From: Petr Tesarik <petr.tesarik1@huawei-partners.com>
> > 
> > If the allocation alignment is bigger than IO_TLB_SIZE and min_align_mask
> > covers some bits in the original address between IO_TLB_SIZE and
> > alloc_align_mask, preserve these bits by allocating additional padding
> > slots before the actual swiotlb buffer.  
> 
> Thanks for fixing this! I was out at a conference last week, so I didn't
> get very far with it myself, but I ended up in a pickle trying to avoid
> extending 'struct io_tlb_slot'. Your solution is much better than the
> crazy avenue I started going down...
> 
> With your changes, can we now simplify swiotlb_align_offset() to ignore
> dma_get_min_align_mask() altogether and just:
> 
> 	return addr & (IO_TLB_SIZE - 1);

I have also thought about this but I don't think it's right. If we
removed dma_get_min_align_mask() from swiotlb_align_offset(), we would
always ask to preserve the lowest IO_TLB_SHIFT bits. This may cause
less efficient use of the SWIOTLB.

For example, if a device does not specify any min_align_mask, it is
presumably happy with any buffer alignment, so SWIOTLB may allocate at
the beginning of a slot, like here:

orig_addr   |      ++|++      |
tlb_addr    |++++    |        |

Without dma_get_min_align_mask() in swiotlb_align_offset(), it would
have to allocate two mostly-empty slots:

tlb_addr    |      ++|++      |

where:
  | mark a multiple of IO_TLB_SIZE (in physical address space)
  + used memory
    free memory

Petr T

