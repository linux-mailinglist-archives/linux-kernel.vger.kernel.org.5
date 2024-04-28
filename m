Return-Path: <linux-kernel+bounces-161406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECDFE8B4B9B
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 14:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3C9B1C20A74
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 12:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B85169DF5;
	Sun, 28 Apr 2024 12:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qUHwloOm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6D167C43;
	Sun, 28 Apr 2024 12:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714305708; cv=none; b=OD9zK1rHaInCV6MQbuXjhPjCfDw0m2SYnylq/ZEeI4WkitU7NjbBBzfYjRsu/1lmAYBcA8si9KhXtRN5j51nmeb1tGURWp5qzjO+5E+lUKcJ7YEs/R6ZiSpdHv1vi2Gui0zi19r7S+um0LFJH9jywE8w/A7jByPD5sNBaPoiM8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714305708; c=relaxed/simple;
	bh=xQA0aeIVCOl9cvhNh35c+pjMwnZaLPISTQQzeLHDgxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N9ZC1Q5OPWO+JerkaZ6VqQlxTHfKirm55A5aSm0IvI+TrdryGBCeqUYMG6ZmWn5ww53ejrGq4v6Y8FXnK/UdC/WRLXH2scchOSxMzefu2724ZQHRiGfSQY9XZWOyz9WtewN6vA19Cd+AnD3dfAUItOp8kEeiNE/4F/r8+CIulEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qUHwloOm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB6FEC113CC;
	Sun, 28 Apr 2024 12:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714305708;
	bh=xQA0aeIVCOl9cvhNh35c+pjMwnZaLPISTQQzeLHDgxU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qUHwloOmhu/Cl4Rnk3U4Kiqr72C27OEJ51SLFwtFAOCmcMKqCfGoXgbJkb4zMmXiP
	 DuSGUed+qZj/L3OiFbnseekaGbVmZqvIqnyKyi9BBePeMlxZr3z4eH3UI+THbKGiAt
	 A+NkqPjThCvwdQ1jv+7/MC93b/MUTRke0bJQvZU5mmXiiehIaO+6TFHi6WqegQE4kt
	 kpd9KeGEqNpv19ohU+81Q0V0oYbOJDqDEq+UrXCXneiw7A2hQgvt4PbigECnneuXoo
	 sq+I43d+FUmaGsVlNBC5OG5/RtyMnTUIsKIV/MHsyOnxFIqqA1LC1QqwoYXLBbEKaM
	 2M1WYZssXOzOQ==
Date: Sun, 28 Apr 2024 15:00:26 +0300
From: Mike Rapoport <rppt@kernel.org>
To: DaeRo Lee <skseofh@gmail.com>
Cc: robh@kernel.org, saravanak@google.com, akpm@linux-foundation.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Daero Lee <daero_le.lee@samsung.com>
Subject: Re: [PATCH v2] memblock: add no-map alloc functions
Message-ID: <Zi46Wri1mPTiEArU@kernel.org>
References: <20240416120635.361838-2-skseofh@gmail.com>
 <Zh9l_LpThq9aFUR7@kernel.org>
 <CAATEi5kywwC2yUaYjgs+Gm=4HM5o=KHTqH1ALKJijWE_gge0=g@mail.gmail.com>
 <ZiFgYWydIwvnpIIY@kernel.org>
 <CAATEi5kFt8iUeWSkrj_bVTyPO_tfQzG77D719P5dLsr2j6Zkzw@mail.gmail.com>
 <CAATEi5ksY-v7-LEqNZWFV5hsHiegNEtrh4LpMWOQ=vT7hC0Rng@mail.gmail.com>
 <Ziy8AsAGZyKCyXX_@kernel.org>
 <CAATEi5=Z0qirM-fyGJL_UPcr7-iyCFtOW9d3XsdN50Tkhpm0iA@mail.gmail.com>
 <Zi3twYLGvhtJa9Yh@kernel.org>
 <CAATEi5nOQE7xi5ztV0BFO6MRqSGwUPT4V9dqpMT+p4r7iZQwRQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAATEi5nOQE7xi5ztV0BFO6MRqSGwUPT4V9dqpMT+p4r7iZQwRQ@mail.gmail.com>

On Sun, Apr 28, 2024 at 07:36:40PM +0900, DaeRo Lee wrote:
> 2024년 4월 28일 (일) 오후 3:35, Mike Rapoport <rppt@kernel.org>님이 작성:
> >
> > On Sat, Apr 27, 2024 at 07:24:23PM +0900, DaeRo Lee wrote:
> > > 2024년 4월 27일 (토) 오후 5:50, Mike Rapoport <rppt@kernel.org>님이 작성:
> > > > > >
> > > > > > So, here is what I think:
> > > > > > - reserved-memory w/ nomap region -> mark only to memblock.memory
> > > > > > - reserved-memory w/o nomap region -> add to the memblock.reserved
> > > >
> > > > NOMAP and memblock.reserved are semantically different, and at makes sense
> > > > to have a "reserved nomap" node in fdt recorded in both memblock.memory and
> > > > memblock.reserved.
> > > >
> > > > memblock.reserved represents the memory that is used by firmware or early
> > > > kernel allocation, so reserved memory in fdt should be reserved in memblock
> > > > as well. I believe it's an oversight that early_init_dt_reserve_memory()
> > > > does not call memblock_reserve() for nomap memory.
> > > >
> > > > NOMAP is a property of a memory region that says that that region should
> > > > not be mapped in the linear map, it's not necessarily in use.
> > >
> > > I agree that the NOMAP region should be added to memblock.reserved.
> > >
> > > So, I think we need to clean-up memmap_init_reserved_pages, because in
> > > this function we call reserve_bootmem_region for memblock.reserved and
> > > memblock.memory with nomap. We don't need to call
> > > reserve_bootmem_region for nomap.
> >
> > Read the comment about memblock_mark_nomap()
> I read the comment about memblock_mark_nomap() and understood that
> regions with nomap flags should be treated as PageReserved.
> But, if we add this nomap region to memblock.reserved, the region with
> nomap flag will be processed in the first for-loop in
> memmap_init_reserved_pages.

memblock still must make sure that pages in nomap regions get PG_Reserved
to be robust against potential errors and bugs in firmware parsing.
 
> Am I thinking wrong?
> 
> Regards,
> DaeRo Lee

-- 
Sincerely yours,
Mike.

