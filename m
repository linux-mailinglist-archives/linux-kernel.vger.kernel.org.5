Return-Path: <linux-kernel+bounces-111998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB1E8873F4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 20:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C1FF1F23E2B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 19:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172547A724;
	Fri, 22 Mar 2024 19:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="Zllok9So"
Received: from bee.tesarici.cz (bee.tesarici.cz [37.205.15.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971417A71D
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 19:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.15.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711135897; cv=none; b=ZYGw4zsWot9cxcMojwP+BQDxavjC6dsv9gImCH9gYPoYJreQi3qkMwqOLKY3ftOw40JYYJXp+XkEG3oiMIiYg/gxyiXnLat0+YXIkbT343D8RhS0KQCrE8w+mKLOXp5P0l0R0GAs+pXuCcZLjB0+UCCharRyxYOQVzka9KvSpBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711135897; c=relaxed/simple;
	bh=wiDjAEmrChnZ9+d36sTPwtpOJeaqnxoA2oNJ20wLimk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VejsG9a8elHHJKosAiRQcoT7WihywUBoN6XUEQSQ/K790kUlc82YTAeVqEM92wouLsqe3mON7m9e7Lz6x7TPbb0VYChMxaNBQfeom9TwmdVi2AUA/KsY8vxaY22XmA2oQdPzBzYHsEy2VWs7oBH9dHBNFSmF2FHRrFw6XmCApV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=Zllok9So; arc=none smtp.client-ip=37.205.15.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-b985-910f-39e1-703f.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:b985:910f:39e1:703f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id EE3641AA9FB;
	Fri, 22 Mar 2024 20:31:31 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1711135892; bh=w74Za9hBQ3UeFMcx0KUozrt8Rr0VROAJBUkRHOKEG6w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Zllok9SoGpD9B4+u0as4vvDzaNUJRcIm0CmjV/f/OtZ7ePPMrElNZme31fgkLaF4j
	 4hk4NT2kYkIgJnfwKTrFsNsxXCbXrWPbmpK/gMBuB0HXqQZGfAb5Yiy98aXCzWYh9x
	 T2AiFU7bRm3j59z1whQycPEw+uyuy+MzdFYakYOWD7IGKi60DGaaB5doRY/4gHeRS/
	 eRSegpUIBQYvUtWqhWxte2XptwpFdycIhp+QBgQTK1Qvk47cx//HyDCZuF23xUyLkN
	 spIZqdfB0sNQ1NOh1u3t0Z/GQkuIHvVN2Utx4OnCyxYRQQVTCJzeoqMLxZ5sBnGDXF
	 Xq+nHqXKg3+aA==
Date: Fri, 22 Mar 2024 20:31:31 +0100
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Will Deacon <will@kernel.org>, Petr Tesarik
 <petrtesarik@huaweicloud.com>, Christoph Hellwig <hch@lst.de>, Marek
 Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>,
 Petr Tesarik <petr.tesarik1@huawei-partners.com>, open list
 <linux-kernel@vger.kernel.org>, "open list:DMA MAPPING HELPERS"
 <iommu@lists.linux.dev>, Roberto Sassu <roberto.sassu@huaweicloud.com>
Subject: Re: [PATCH v3 0/2] swiotlb: allocate padding slots if necessary
Message-ID: <20240322203131.207519c5@meshulam.tesarici.cz>
In-Reply-To: <SN6PR02MB41574F4837E875F3D158B329D4312@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240321171902.85-1-petrtesarik@huaweicloud.com>
	<20240322150941.GA5634@willie-the-truck>
	<SN6PR02MB41574F4837E875F3D158B329D4312@SN6PR02MB4157.namprd02.prod.outlook.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Mar 2024 18:11:50 +0000
Michael Kelley <mhklinux@outlook.com> wrote:

> From: Will Deacon <will@kernel.org> Sent: Friday, March 22, 2024 8:10 AM
> > 
> > Hi Petr,
> > 
> > On Thu, Mar 21, 2024 at 06:19:00PM +0100, Petr Tesarik wrote:  
> > > From: Petr Tesarik <petr.tesarik1@huawei-partners.com>
> > >
> > > If the allocation alignment is bigger than IO_TLB_SIZE and min_align_mask
> > > covers some bits in the original address between IO_TLB_SIZE and
> > > alloc_align_mask, preserve these bits by allocating additional padding
> > > slots before the actual swiotlb buffer.  
> > 
> > Thanks for fixing this! I was out at a conference last week, so I didn't
> > get very far with it myself, but I ended up in a pickle trying to avoid
> > extending 'struct io_tlb_slot'. Your solution is much better than the
> > crazy avenue I started going down...
> > 
> > With your changes, can we now simplify swiotlb_align_offset() to ignore
> > dma_get_min_align_mask() altogether and just:
> > 
> > 	return addr & (IO_TLB_SIZE - 1);
> > 
> > ?
> >   
> 
> I don't think such a change is correct, since we want to allow the
> DMA min_align_mask to work if it is set to 0x3FF or 0x1FF or
> something else smaller than IO_TLB_SIZE - 1.
> 
> Petr's new offset calculation in swiotlb_tbl_map_single() is this:
> 
> offset = orig_addr & dma_get_min_align_mask(dev) &
>                 (alloc_align_mask | (IO_TLB_SIZE - 1));
> 
> In the normal stream mapping case, where alloc_align_mask is
> zero, Petr's new statement is equivalent to swiotlb_align_offset().
> And I think it needs to continue to be equivalent so that
> swiotlb_search_pool_area(), swiotlb_bounce()  and
> swiotlb_release_slots() calculate the same offset as
> swiotlb_tbl_map_single() uses after it separately processes
> the padding slots.
> 
> Perhaps a better approach to maintaining the equivalence is
> to modify swiotlb_align_offset() to be Petr's new calculation,
> with alloc_align_mask passed as an argument.
> swiotlb_search_pool_area(), swiotlb_bounce(), and
> swiotlb_release_slots() would all pass 0 as the alloc_align_mask
> argument.

I like this idea.

Petr T

