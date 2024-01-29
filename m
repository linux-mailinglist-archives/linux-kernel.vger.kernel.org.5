Return-Path: <linux-kernel+bounces-42292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D93E883FF31
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 08:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A7CB1F23D8C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 07:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292614EB47;
	Mon, 29 Jan 2024 07:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="396NALZi"
Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE3F4EB23
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 07:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.93.223.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706514213; cv=none; b=V5PaKoyibRvS+fCpEf/cHB2lLFZh/ZDU7H5lRRyul4OA9+FWw0e8vtZW4oInRI7iyKwUeF5PBpWqI22iYlJCa1iCE80A9xhCGpeA/toXf1rx40NUVMTiZiP3hAqB8Ueq8WV6GWYNyGwYU8g3mM1uShVREKu5bNExKe4zh4ICGJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706514213; c=relaxed/simple;
	bh=PfhvtgDD3AmzalLTRpYnRygPfaJzOhGOT0f1zwC+1+4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nH2kA6U99bwAoSKAs9Z/1lplzA65DaoPFVGbND+6vvPP+uJXcnislX/Lv7Esty1CByZ9nqbp0VxIHE02FrSiMoMH0Gb8br42K+Y8NMdXuxz/echFZYjht14TviUIs7dDufYUL9uzGW9OXFLfw6GJbldsfm1equGQnaDUQySOpSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=396NALZi; arc=none smtp.client-ip=77.93.223.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 3D0DF198C58;
	Mon, 29 Jan 2024 08:43:28 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
	t=1706514208; bh=PfhvtgDD3AmzalLTRpYnRygPfaJzOhGOT0f1zwC+1+4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=396NALZi9bz0Hc3HaCVtYWxpKsv86czZ2xXWoAOID5ZJIJZQRwyRZ3zTl0zDRv5WS
	 Q8U4X0w4p739RKhe4B7YW4Et80YDlgYMJ3j4qEgawYI0mEA8m8pbN0vLR8hCyf5SHe
	 xwbz8xnpuce/8Eax6iJFQCXMwVEkr9ATHNz3+GYeb4MV0DsijTUIUpZzFnxchYigsH
	 SW4LVvP8CX2gaDw8m2Wc2P98H77hsRT5rmznZDlHED2HbgfZVq93q9ibl0UpymFNDV
	 bfLTcucxEZ27l9nn5B6OPcSHwM8cU7obOm7Chd9SP0WMjo6z8cwSK3iIZBXRnlmuzY
	 bSZF9Gm6w27zg==
Date: Mon, 29 Jan 2024 08:43:26 +0100
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 kernel-team@android.com, iommu@lists.linux.dev, Marek Szyprowski
 <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Petr
 Tesarik <petr.tesarik1@huawei-partners.com>, Dexuan Cui
 <decui@microsoft.com>
Subject: Re: [PATCH 2/2] swiotlb: Enforce page alignment in swiotlb_alloc()
Message-ID: <20240129084326.4667af6a@meshulam.tesarici.cz>
In-Reply-To: <20240129060853.GB19258@lst.de>
References: <20240126151956.10014-1-will@kernel.org>
	<20240126151956.10014-3-will@kernel.org>
	<20240129060853.GB19258@lst.de>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Jan 2024 07:08:53 +0100
Christoph Hellwig <hch@lst.de> wrote:

> On Fri, Jan 26, 2024 at 03:19:56PM +0000, Will Deacon wrote:
> > diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> > index 25febb9e670c..92433ea9f2d2 100644
> > --- a/kernel/dma/swiotlb.c
> > +++ b/kernel/dma/swiotlb.c
> > @@ -1647,6 +1647,12 @@ struct page *swiotlb_alloc(struct device *dev, size_t size)
> >  		return NULL;
> >  
> >  	tlb_addr = slot_addr(pool->start, index);
> > +	if (!PAGE_ALIGNED(tlb_addr)) {
> > +		dev_WARN_ONCE(dev, 1, "Cannot return 'struct page *' for non page-aligned swiotlb addr 0x%pa.\n",
> > +			      &tlb_addr);
> > +		swiotlb_release_slots(dev, tlb_addr);
> > +		return NULL;
> > +	}
> >  
> >  	return pfn_to_page(PFN_DOWN(tlb_addr));  
> 
> So PFN_DOWN aligns the address and thus per se converting the unaligned
> address isn't a problem.  That being said swiotlb obviously should never
> allocate unaligned addresses, but the placement of this check feels
> odd to me.  Also because it only catches swiotlb_alloc and not the
> map side.

We may have to rethink how alignment constraints are interpreted. See
also my reply to PATCH 1/2.

> Maybe just throw a WARN_ON_ONCE into slot_addr() ?

Yes.

Or, what if I write a KUnit test suite for swiotlb to combat this
constant stream of various regressions?

Petr T

