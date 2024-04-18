Return-Path: <linux-kernel+bounces-150609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 523B58AA1BD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 20:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E21122843AA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 18:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CEA178CF2;
	Thu, 18 Apr 2024 18:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vhz9MLtW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0B7177983;
	Thu, 18 Apr 2024 18:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713463463; cv=none; b=tZ3HcfizcaLtqk8SkuR0kMJ/sTQxrBqjtDhJRAV3qhE6kSTvM5bDb3JFnS/7dVuTpbveeFun6OeBEYfY9Vof0BHsSoIKq9QhyMeznib3Y8zEtLoWoWT0Pr6EwhRqDTpkoPI1OweFXm5J3ZZUvmuiheORzqsC31CsdwNn5pgW2TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713463463; c=relaxed/simple;
	bh=lLVjAlxxr1hI4YSIYnF75PDevgYd6I1NnS5Ce2xKYes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BTczuUjxwNhBF08oDh+ngh26D9EaD5gCAoPnr+ChLxJp2eKgncvJhnGtsuMSpwfswOncwWUIWtEPJ80BB+d7rnUAXBSNJWG5zotDGlfX469PDOxgWPysIunOdOn1y/i6oSsp0+YfOzh082SjYnttDS2mwb0EsNrnpOh61/lNaHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vhz9MLtW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E349CC116B1;
	Thu, 18 Apr 2024 18:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713463462;
	bh=lLVjAlxxr1hI4YSIYnF75PDevgYd6I1NnS5Ce2xKYes=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vhz9MLtWWmXiJyfJszBrF18JGNnetf7ZJj0t4W6UqAPasYEGuGGb1NPN4GCrtPTkU
	 CD9VK/B27CWo34P8LE7C1z7citVmlQ/6bnZ21c/+i9isgm1MEDJNID4bFFuu9BqDgt
	 9mau9Yu+u9jF8BZhNbYsX6AUS7HR6A7YPlEKGKMQlcL1uIZTXnwbJEpW3O9g2tOs0N
	 s9NFsrNx7ObhjcXPghnotyVevIp9XnlJULFAYVa4LmAK1ESsPJUBhBb1UC6pGqBWea
	 7iniKU7Dr0kzIlv5EIx3PsjrMuHNb2lc2t5jS8ocYzbL5idf4UrK9bIJErvamLFxN1
	 0Yk5Zf1hBBKMw==
Date: Thu, 18 Apr 2024 21:03:13 +0300
From: Mike Rapoport <rppt@kernel.org>
To: DaeRo Lee <skseofh@gmail.com>
Cc: robh@kernel.org, saravanak@google.com, akpm@linux-foundation.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Daero Lee <daero_le.lee@samsung.com>
Subject: Re: [PATCH v2] memblock: add no-map alloc functions
Message-ID: <ZiFgYWydIwvnpIIY@kernel.org>
References: <linux-mm@kvack.org>
 <20240416120635.361838-1-skseofh@gmail.com>
 <20240416120635.361838-2-skseofh@gmail.com>
 <Zh9l_LpThq9aFUR7@kernel.org>
 <CAATEi5kywwC2yUaYjgs+Gm=4HM5o=KHTqH1ALKJijWE_gge0=g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAATEi5kywwC2yUaYjgs+Gm=4HM5o=KHTqH1ALKJijWE_gge0=g@mail.gmail.com>

On Thu, Apr 18, 2024 at 11:54:15PM +0900, DaeRo Lee wrote:
> 2024년 4월 17일 (수) 오후 3:03, Mike Rapoport <rppt@kernel.org>님이 작성:
> >
> > On Tue, Apr 16, 2024 at 09:06:35PM +0900, skseofh@gmail.com wrote:
> > > From: Daero Lee <daero_le.lee@samsung.com>
> > >
> > > Like reserved-memory with the 'no-map' property and only 'size' property
> > > (w/o 'reg' property), there are memory regions need to be allocated in
> > > memblock.memory marked with the MEMBLOCK_NOMAP flag, but should not be
> > > allocated in memblock.reserved.
> >
> > This still does not explain why you need such regions.
> >
> > As Wei Yang explained, memblock does not allocate memory from
> > memblock.reserved. The memblock.reserved array represents memory that is in
> > use by firmware or by early kernel allocations and cannot be freed to page
> > allocator.
> Thank you for your comments. I used the wrong word.
> When I use 'allocate', I mean that the region 'adds' to the memblock.reserved.
> 
> >
> > If you have a region that's _NOMAP in memblock.memory and is absent in
> > memblock.reserved it will not be mapped by the kernel page tables, but it
> > will be considered as free memory by the core mm.
> >
> > Is this really what you want?
> If my understanding is right, before freeing (memory && !reserved)
> area, we marked the memblock.reserved regions and memblock.memory
> regions with no-map flag. And when we free (memory && !reserved) area,
> we skip the memblock.memory regions with no-map(see
> should_skip_region). So, I think that the memory regions with no-map
> flag will not be considered as free memory.

You are right here.

But I still don't understand *why* do you want to change the way
early_init_dt_alloc_reserved_memory_arch() works.
 
> Regards,
> DaeRo Lee

-- 
Sincerely yours,
Mike.

