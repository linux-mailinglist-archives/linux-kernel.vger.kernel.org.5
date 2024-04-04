Return-Path: <linux-kernel+bounces-130984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 023FD89818E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 08:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ADA8288352
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 06:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF8734CD8;
	Thu,  4 Apr 2024 06:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="tYWMP3Yq"
Received: from bee.tesarici.cz (bee.tesarici.cz [37.205.15.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CD12C870
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 06:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.15.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712212735; cv=none; b=b6BLpm4NafJLDaj/XFlgcZSBpfWqaUon5AguMFjjN9c3nz8rrvchjG9fYJx1cfAAowarecLXX7L+75arhMlzcaa3e3XS4ns1rEi/Lgo9RtS12zHZKMwafuGYu/MastivpA+eKHR1vv0GqGrArlW27cygZpj1LaGhKpU8Fw4OrSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712212735; c=relaxed/simple;
	bh=vo/qn+RJxE0LKD3av00uetf+HCmfDCBD1kCp6tStYBs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uDKd82uxMK9LO2KvP0R0lE/ej9IJmkYQowSCVAgoTEiciHxuyxRlw4I8O1Y9p+8cuqBp4E8B6IE2tKjXEm9A3xMi1BK7r0gE4XoCoGPnHE6yd9Fs2LlqL3AocctRRvu9JkuFlItw6RofPMj1fSBOvW7IkMhiYLr42TPbj2MhCX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=tYWMP3Yq; arc=none smtp.client-ip=37.205.15.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 786AE1BC8AE;
	Thu,  4 Apr 2024 08:38:43 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1712212723; bh=5J1yAm3XMf1K/lYCV+NCGbwEJx1vP3lfRy2pskB7aq0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tYWMP3Yq1Y8qcRJzO/5gngHOsA3paTTdycxUHGqy3j8vQPMajUCniDjrztB5S1uqe
	 fz38aH1JqWBZAznOrwK4z55W9gSCgOURZuveQGdxOFQj/Eyl7qBK2451XtgQXVse3x
	 e77yHwsH9egSp8/3Q6RgJDbQITgO8PjWXtYCcVBhmZ/PI2QyRIMp1GzCcCOkdYUyPA
	 JDRzrY+JIXbkouiErHz08b722Y6O0Dy980qFKRs0e+uJNBLFO2QkV5zm2E9bwIBA8U
	 +4Wdds5KxNBfsLIbzPSCLBWcaVk60xfq9vVUvacmlgiKEn044ZnTxUBeES50iOYD9j
	 TYwrvRgxT/jVw==
Date: Thu, 4 Apr 2024 08:38:42 +0200
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Linu Cherian <lcherian@marvell.com>, Petr Tesarik
 <petrtesarik@huaweicloud.com>, Christoph Hellwig <hch@lst.de>, Marek
 Szyprowski <m.szyprowski@samsung.com>, open list
 <linux-kernel@vger.kernel.org>, "open list:DMA MAPPING HELPERS"
 <iommu@lists.linux.dev>, Will Deacon <will@kernel.org>, Michael Kelley
 <mhklinux@outlook.com>, Roberto Sassu <roberto.sassu@huaweicloud.com>
Subject: Re: [EXTERNAL] Re: [PATCH 1/1] swiotlb: add a KUnit test suite
Message-ID: <20240404083842.3bc15c2e@meshulam.tesarici.cz>
In-Reply-To: <69d3bcc5-5b5b-4b52-93fe-4a095e7ccdc6@arm.com>
References: <20240313092740.192-1-petrtesarik@huaweicloud.com>
	<20240326030851.GA64024@hyd1403.caveonetworks.com>
	<20240326130635.64fb3a98@meshulam.tesarici.cz>
	<PH0PR18MB50024739F4DCF8FCEB6F0CADCE3D2@PH0PR18MB5002.namprd18.prod.outlook.com>
	<69d3bcc5-5b5b-4b52-93fe-4a095e7ccdc6@arm.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 3 Apr 2024 17:58:47 +0100
Robin Murphy <robin.murphy@arm.com> wrote:

> On 2024-04-03 3:19 pm, Linu Cherian wrote:
> [...]
> >>> Should we not try this on a buffer that is mapped with DMA_FROM_DEVICE ?  
> >>
> >> I'm afraid I don't follow.
> >>
> >> AFAICT the direction is a property of the sync operation. In fact,
> >> swiotlb_tbl_map_single() does not even use its direction parameter at all.
> >> Removing that parameter is already on my TODO list of cleanups.
> >>  
> > 
> > Okay. Got it.
> >   
> >> swiotlb_map() uses its direction parameter only to perform the initial arch
> >> sync if DMA is non-coherent.
> >>
> >> OTOH I may be missing some high-level logical concepts which do not
> >> correspond to any actual code in the swiotlb implementation, so my use is still
> >> wrong.
> >>  
> > 
> > Just thought that the keeping the DMA direction consistent for the map and sync would be more aligned to typical use case.
> > For example, a buffer used for transmit in case of networking. OTOH, since the API by itself doesn't have such constraints on the direction parameter, may be it makes sense to test those scenarios.  
> 
> Right, SWIOTLB exists to serve the DMA API, so it makes more sense to me 
> to test it in the context of valid DMA API usage than to make up 
> scenarios that aren't representative of real-world usage. The direction 
> is a property of the whole DMA mapping itself, and thus must be passed 
> consistently for every operation on a given mapping.
> 
> Yes, there is some internal trickery once we get down to the level of 
> calling swiotlb_bounce() itself, but if we're driving the tests through 
> the higher-level public interface then I'd prefer to see that used as 
> expected. Given the whole partial-write-transparency business, the most 
> significant effect of direction should just be that of DMA_TO_DEVICE 
> skipping the copy-out for unmap and sync_for_cpu, so for the sake of 
> coverage you may as well just use DMA_BIDIRECTIONAL everywhere.

Thank you for the explanation. Got it now.

I'm now going to take all comments into account for a v2 series, plus I
want to add a test for partial sync to cover Michael's fix.

Stay tuned,
Petr T

