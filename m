Return-Path: <linux-kernel+bounces-161288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC20F8B4A24
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 08:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12FA9B2159E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 06:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C3D4F8B1;
	Sun, 28 Apr 2024 06:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NFnNagcm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCB84F896;
	Sun, 28 Apr 2024 06:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714286101; cv=none; b=g8cS6UV9bhU9XWWHAx/gFOG4GXbR8+ieu1+zhUFI3JsO6FRbKnQTh5ESzao2lmgCdLVgW0aJ1xUQWaJ8+hZ+mbrqZckxvLyUsh+hXNVEpGaWjtpZH7Srr0C3rzhGPRu47falJlISxzfOeoDMIDuOcc/Npku8ht3Bdy2Ar0IyYQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714286101; c=relaxed/simple;
	bh=gGXNhBbfImPeZnJs87jnNoO7ISenhcnpz02YU249uJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s+zV0Xqof0yQ0g5d0oTY3GjQ4ctmDruxcaMl7ESuJeCyzYQqSpDnUs0bhF6Fau9MYqyUCK+J69RIHzMoDMj/IcFm49jG0vE6UbzhME5faQqsvrdAAQ+7CdaX3Pu66fKOtWBBtmoR4/Gwj+iIUTjYd2uN4WxZ8R4Of3f5JO3dasU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NFnNagcm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F36BC113CC;
	Sun, 28 Apr 2024 06:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714286101;
	bh=gGXNhBbfImPeZnJs87jnNoO7ISenhcnpz02YU249uJI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NFnNagcm6mwvKrWAK4nCHAx6kZP7OMn+eXbymaE2qzgfL4Eu8FRe2T3I2o5JdVegP
	 SD+p0sqUzMfMlmdlyCUiRSvlu7sziirtS90CNFYqI9+290U7IwdUayxgDEtu20Je35
	 chLVzrmtTYJDuVqj7n1woEfj5ao7LxKO4Gv+qscR8QMxoNHRqfaXbQbA9gPM9nhNfd
	 758bwHgWD1/eAXRXc144oEDdiES61AhWwPyOjVIATkyyE+ykbmb6s5SlfLmUS4O4I5
	 joKnhpTwp9ZbJtaGD8z95Zn3hZoTpsnU3RlxEFrUmq0kxoTqSko/jbRL8uaElRsbXY
	 7DWpWP27KBt/g==
Date: Sun, 28 Apr 2024 09:33:37 +0300
From: Mike Rapoport <rppt@kernel.org>
To: DaeRo Lee <skseofh@gmail.com>
Cc: robh@kernel.org, saravanak@google.com, akpm@linux-foundation.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Daero Lee <daero_le.lee@samsung.com>
Subject: Re: [PATCH v2] memblock: add no-map alloc functions
Message-ID: <Zi3twYLGvhtJa9Yh@kernel.org>
References: <linux-mm@kvack.org>
 <20240416120635.361838-1-skseofh@gmail.com>
 <20240416120635.361838-2-skseofh@gmail.com>
 <Zh9l_LpThq9aFUR7@kernel.org>
 <CAATEi5kywwC2yUaYjgs+Gm=4HM5o=KHTqH1ALKJijWE_gge0=g@mail.gmail.com>
 <ZiFgYWydIwvnpIIY@kernel.org>
 <CAATEi5kFt8iUeWSkrj_bVTyPO_tfQzG77D719P5dLsr2j6Zkzw@mail.gmail.com>
 <CAATEi5ksY-v7-LEqNZWFV5hsHiegNEtrh4LpMWOQ=vT7hC0Rng@mail.gmail.com>
 <Ziy8AsAGZyKCyXX_@kernel.org>
 <CAATEi5=Z0qirM-fyGJL_UPcr7-iyCFtOW9d3XsdN50Tkhpm0iA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAATEi5=Z0qirM-fyGJL_UPcr7-iyCFtOW9d3XsdN50Tkhpm0iA@mail.gmail.com>

On Sat, Apr 27, 2024 at 07:24:23PM +0900, DaeRo Lee wrote:
> 2024년 4월 27일 (토) 오후 5:50, Mike Rapoport <rppt@kernel.org>님이 작성:
> >
> > On Fri, Apr 19, 2024 at 10:59:52AM +0900, DaeRo Lee wrote:
> > > 2024년 4월 19일 (금) 오전 10:46, DaeRo Lee <skseofh@gmail.com>님이 작성:
> > > >
> > > > In memmap_init_reserved_pages, we mark memblock.reserved as
> > > > PageReserved first and mark the memblock.reserved with nomap flag
> > > > also.
> > > Sorry. This is my mistake. 'memblock.memory with nomap flag' is right.
> > >
> > > > -> Isn't this duplicated work? (If we add no-map region to
> > > > memblock.reserved 'and' mark in memblock.memory..)
> > > > So, I think that for the no-map region, we don't need to add to the
> > > > memblock.reserved.
> > > > This is what we do now in early_init_dt_reserve_memory. the nomap
> > > > region is not added to the memblock.reserved.
> > > >
> > > > In early_init_dt_alloc_reserved_memory_arch, if 'nomap' is true, we
> > > > mark the memblock.memory region as _NOMAP. And if the return value
> > > > 'err' is not zero(which is '-ENOMEM' from memblock_isolate_range), we
> > > > free the region.
> > > > - 'nomap' is true -> memblock_mark_nomap : success -> not free the region
> > > >
> > > > : fail -> free the region
> > > > And it can be said that we add the region to the memblock.reserved
> > > > using memblock_phys_alloc_range and if the region is nomap, then we
> > > > can free the region from memblock.reserved. But is it necessary to add
> > > > it to memblock.reserved? We just need the region in memblock.memory to
> > > > mark nomap.
> > > >
> > > > So, here is what I think:
> > > > - reserved-memory w/ nomap region -> mark only to memblock.memory
> > > > - reserved-memory w/o nomap region -> add to the memblock.reserved
> >
> > NOMAP and memblock.reserved are semantically different, and at makes sense
> > to have a "reserved nomap" node in fdt recorded in both memblock.memory and
> > memblock.reserved.
> >
> > memblock.reserved represents the memory that is used by firmware or early
> > kernel allocation, so reserved memory in fdt should be reserved in memblock
> > as well. I believe it's an oversight that early_init_dt_reserve_memory()
> > does not call memblock_reserve() for nomap memory.
> >
> > NOMAP is a property of a memory region that says that that region should
> > not be mapped in the linear map, it's not necessarily in use.
> 
> I agree that the NOMAP region should be added to memblock.reserved.
> 
> So, I think we need to clean-up memmap_init_reserved_pages, because in
> this function we call reserve_bootmem_region for memblock.reserved and
> memblock.memory with nomap. We don't need to call
> reserve_bootmem_region for nomap.

Read the comment about memblock_mark_nomap()

> Regards,.
> DaeRo Lee

-- 
Sincerely yours,
Mike.

