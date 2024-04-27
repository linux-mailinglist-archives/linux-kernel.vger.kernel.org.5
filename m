Return-Path: <linux-kernel+bounces-160966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CBEB8B4539
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 10:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1348B21FD5
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 08:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBECE4594A;
	Sat, 27 Apr 2024 08:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rGoAfMZ5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DD064C;
	Sat, 27 Apr 2024 08:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714207829; cv=none; b=QOqwH+Hc3SY4/R9vjeyWLh3soX2DZdgDOIFGd5hDf+7tbsCOxjoBu9CxF/SRIM6DXU9PKn42Ot8mDszIFIc/g50kB64lFRolQwtJ9wzhRjAIezFGnNqb1y2SkskQ2KLveJdVdWvErazWXr6QPjCrne1UXQXC1HphN12aTGoDQZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714207829; c=relaxed/simple;
	bh=BuSVg2sIQz4rUwdjp1HPjb4SufNjrq2om93BcT+qtzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kZYYiDI+/7xic2zN3cxyjUJFyNdCQeyTaeLmmiArsnNkI22S+Viq36/FPtwBahhTofuBfGsGpIIJ9vFMCaK3QAXdxCkXbVMa1+gjtobW0hlZ8yDVqBSqCQFtpQqKs49g1Rt7Q8/8AVXa1auNacaid9vZaORrXMjXLfSfKkdW0/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rGoAfMZ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9C8FC113CE;
	Sat, 27 Apr 2024 08:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714207828;
	bh=BuSVg2sIQz4rUwdjp1HPjb4SufNjrq2om93BcT+qtzg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rGoAfMZ57VcQEZ97fpBbcG+4RpLHAML9bNmDtpwcyadHjOAb3icpzNDVkwdRy49zs
	 YXoxSKWHsqbiRYz96MbkBHuZRyXJQnu2g6GgOmFYPf1/1m8J4QywBx/uupsu7lXAo1
	 1fEeRl4PCJHjHanWu6BD7EjGWsoK8ZaVUwhh/VT12lbj1Rmd3shOkh8AmR3cqDnCry
	 wn+miUXqUubLMNPl9c5mVDUx7Swx5wfvM4XcKfe10OOrwUARzz/q35o2P2My95v0qB
	 l+brZsPmkYieLL2cBSoU7YRmRfgMKd6ZY2HIn/1WD681Gw0NlGRTsiSxUzBbsnu+ki
	 Bg58ogmNj9GzA==
Date: Sat, 27 Apr 2024 11:49:06 +0300
From: Mike Rapoport <rppt@kernel.org>
To: DaeRo Lee <skseofh@gmail.com>
Cc: robh@kernel.org, saravanak@google.com, akpm@linux-foundation.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Daero Lee <daero_le.lee@samsung.com>
Subject: Re: [PATCH v2] memblock: add no-map alloc functions
Message-ID: <Ziy8AsAGZyKCyXX_@kernel.org>
References: <linux-mm@kvack.org>
 <20240416120635.361838-1-skseofh@gmail.com>
 <20240416120635.361838-2-skseofh@gmail.com>
 <Zh9l_LpThq9aFUR7@kernel.org>
 <CAATEi5kywwC2yUaYjgs+Gm=4HM5o=KHTqH1ALKJijWE_gge0=g@mail.gmail.com>
 <ZiFgYWydIwvnpIIY@kernel.org>
 <CAATEi5kFt8iUeWSkrj_bVTyPO_tfQzG77D719P5dLsr2j6Zkzw@mail.gmail.com>
 <CAATEi5ksY-v7-LEqNZWFV5hsHiegNEtrh4LpMWOQ=vT7hC0Rng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAATEi5ksY-v7-LEqNZWFV5hsHiegNEtrh4LpMWOQ=vT7hC0Rng@mail.gmail.com>

On Fri, Apr 19, 2024 at 10:59:52AM +0900, DaeRo Lee wrote:
> 2024년 4월 19일 (금) 오전 10:46, DaeRo Lee <skseofh@gmail.com>님이 작성:
> >
> > In memmap_init_reserved_pages, we mark memblock.reserved as
> > PageReserved first and mark the memblock.reserved with nomap flag
> > also.
> Sorry. This is my mistake. 'memblock.memory with nomap flag' is right.
> 
> > -> Isn't this duplicated work? (If we add no-map region to
> > memblock.reserved 'and' mark in memblock.memory..)
> > So, I think that for the no-map region, we don't need to add to the
> > memblock.reserved.
> > This is what we do now in early_init_dt_reserve_memory. the nomap
> > region is not added to the memblock.reserved.
> >
> > In early_init_dt_alloc_reserved_memory_arch, if 'nomap' is true, we
> > mark the memblock.memory region as _NOMAP. And if the return value
> > 'err' is not zero(which is '-ENOMEM' from memblock_isolate_range), we
> > free the region.
> > - 'nomap' is true -> memblock_mark_nomap : success -> not free the region
> >
> > : fail -> free the region
> > And it can be said that we add the region to the memblock.reserved
> > using memblock_phys_alloc_range and if the region is nomap, then we
> > can free the region from memblock.reserved. But is it necessary to add
> > it to memblock.reserved? We just need the region in memblock.memory to
> > mark nomap.
> >
> > So, here is what I think:
> > - reserved-memory w/ nomap region -> mark only to memblock.memory
> > - reserved-memory w/o nomap region -> add to the memblock.reserved

NOMAP and memblock.reserved are semantically different, and at makes sense
to have a "reserved nomap" node in fdt recorded in both memblock.memory and
memblock.reserved.

memblock.reserved represents the memory that is used by firmware or early
kernel allocation, so reserved memory in fdt should be reserved in memblock
as well. I believe it's an oversight that early_init_dt_reserve_memory()
does not call memblock_reserve() for nomap memory.

NOMAP is a property of a memory region that says that that region should
not be mapped in the linear map, it's not necessarily in use.

> > Regards,
> > DaeRo Lee

-- 
Sincerely yours,
Mike.

