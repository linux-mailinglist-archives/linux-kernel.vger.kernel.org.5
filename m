Return-Path: <linux-kernel+bounces-90049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 983F786F957
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 05:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0774D1F21AD2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 04:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726FE6138;
	Mon,  4 Mar 2024 04:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W2xsz+we"
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267A017F3
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 04:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709527949; cv=none; b=Xr+uHXrfpnNdxyAs1y3fjXnQUPV9xsAgYWEqQPHLEVt6U/EZeLxga8SeH4+Dwh5jxd+0UqrvYHgvAfxbVZz06kCSvMKsZkzY6RHtx//5WVHGb+o6D3rvIB1ooM90q9thGFdDiXurczPTB6kr8QUIrjuvJ1ZOHHUF4aGPQg5F/BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709527949; c=relaxed/simple;
	bh=aYek/a1+9LkLdnbs8Y0Z3LjiLjI7rIUGqbXOPTkKvT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p9p4Mb2hJkkcHxdKisMLCzYHHoWIqM0IUfoUBrjKu8rdzRFB/mUp5BCe4RdgY74OrTFXuDLSOb8TqIYdnV/DYaFHvZIB88bMaXe+icHL/Oqiv/CCfdt7iBtIXLgBuENpEe36SDttSkZiDAn9WeEfup065MZLmjl79QYdwTpKHwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W2xsz+we; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-4d342e854cbso820013e0c.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2024 20:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709527947; x=1710132747; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AkFFEU+0+DW/z+oRCHXNccKfQu4nUdTuR16h3ZobfTg=;
        b=W2xsz+weE8eHvb/TlC3oaQIWmHJZyZytUQ5t4dEBsF1kwX/cb3FO/dWtAzQaYDsEpi
         2Xt8ZPPbxdxbcB2inIYA20/xBAxYMC7es/SCMjaq39C1RlUWL8Z3WXD1/y2Lt3ilK4Oj
         OjWhW2m9zWKZ6YMJd60gckGgWeNDNg7DJAXaXZxsGtptyGSKLqNMwobqScxUFJ4y59wD
         pYfQCVs6hiUZ1ptnLZovm42q2A6uF8NNic8fRSfY8Kw020SBULidBztpocH+PmL1DBkA
         zKAs33Qp0Qlx4JfhgphF1LsHj3MBAjxeS4UjhFoUEBb/TZuXE7l+HGnQ0ENEA3DNXYtr
         GQaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709527947; x=1710132747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AkFFEU+0+DW/z+oRCHXNccKfQu4nUdTuR16h3ZobfTg=;
        b=rz3FifSIMzufK7thTAnRS0TGjgDCnCnonUqUEZaavwBIwMlYYBtjA/z3jSJIa4uy7d
         8bllnRn6Nc8UwvnhXKjmKiTLodcQEqGvYFE3TD4x744nDXK7c7rNbLjxzzWVE1CYu/0v
         FKgfv7DUy5+g8QpIalaKfGcSYnIFcoKmEWtJmoVcwBr0V1BUBo/fSV5acB4G2LdcMUOm
         +jIub6JnfFmsY9gCOHGi4ZClJyFsaz/bFYe36jcSw58JL0MWBqDJls+DUZ4qCFEV4J9i
         76YIIkBfZ9gstDr1cNxX4SKTO8vgqXy1kb9vTveWxpHVkR6NKZcNmsC5XrDaxeKZHVx1
         XA+g==
X-Forwarded-Encrypted: i=1; AJvYcCWZADx6VVpkzaOLybvvB4g17HrSMRyDZ/VmKUqxXic6ouKN92V6GXDskh/SxviBovWwRywQi3owkblEtn6ZkkXx+OOfPN7PH7c1FWi2
X-Gm-Message-State: AOJu0Yz+P6d7PPUVuHD/uVfFg16reOgv9kpKijtV7u2kddYw31IVwt6N
	rXQk9XQ/36gy4GhAp5IT0rEigmsofctjhwnAuuKLFQ7KA6kNRqqmOXhjJTQoZVTVIBsYfwmEgHd
	U57doMHjjHOUaB3+WVdZfKgNCbjQ=
X-Google-Smtp-Source: AGHT+IF5jsyTk3HvZc/020+awQxvPMQ6Wqx7+kXDFnVeuDm+ms6f3qJz8dmtgHtoYC+wtmep4RpI73MYauaIhytdsfk=
X-Received: by 2002:a05:6122:1825:b0:4d3:373b:4db1 with SMTP id
 ay37-20020a056122182500b004d3373b4db1mr5205933vkb.6.1709527947073; Sun, 03
 Mar 2024 20:52:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d108bd79-086b-4564-838b-d41afa055137@redhat.com>
 <6541e29b-f25a-48b8-a553-fd8febe85e5a@redhat.com> <ee760679-7e3c-4a35-ad53-ca98b598ead5@arm.com>
 <ba9101ae-a618-4afc-9515-a61f25376390@arm.com> <2934125a-f2e2-417c-a9f9-3cb1e074a44f@redhat.com>
 <049818ca-e656-44e4-b336-934992c16028@arm.com> <d2fbfdd0-ad61-4fe2-a976-4dac7427bfc9@redhat.com>
 <4a73b16e-9317-477a-ac23-8033004b0637@arm.com> <1195531c-d985-47e2-b7a2-8895fbb49129@redhat.com>
 <5ebac77a-5c61-481f-8ac1-03bc4f4e2b1d@arm.com> <ZeIC0Bn7N0JlP4TY@casper.infradead.org>
 <e56fbf5e-8051-4285-875b-1de529dc6809@arm.com> <af2b5141-7651-4805-8de9-c79a5c52ce74@arm.com>
In-Reply-To: <af2b5141-7651-4805-8de9-c79a5c52ce74@arm.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 4 Mar 2024 17:52:15 +1300
Message-ID: <CAGsJ_4wnSJryK8Jbq+ADVJgnr18r=0M8fkPCpgb8_bOABZkGtQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] mm: swap: Remove CLUSTER_FLAG_HUGE from swap_cluster_info:flags
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Matthew Wilcox <willy@infradead.org>, David Hildenbrand <david@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Huang Ying <ying.huang@intel.com>, 
	Gao Xiang <xiang@kernel.org>, Yu Zhao <yuzhao@google.com>, Yang Shi <shy828301@gmail.com>, 
	Michal Hocko <mhocko@suse.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 2, 2024 at 6:08=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com> =
wrote:
>
> On 01/03/2024 16:44, Ryan Roberts wrote:
> > On 01/03/2024 16:31, Matthew Wilcox wrote:
> >> On Fri, Mar 01, 2024 at 04:27:32PM +0000, Ryan Roberts wrote:
> >>> I've implemented the batching as David suggested, and I'm pretty conf=
ident it's
> >>> correct. The only problem is that during testing I can't provoke the =
code to
> >>> take the path. I've been pouring through the code but struggling to f=
igure out
> >>> under what situation you would expect the swap entry passed to
> >>> free_swap_and_cache() to still have a cached folio? Does anyone have =
any idea?
> >>>
> >>> This is the original (unbatched) function, after my change, which cau=
sed David's
> >>> concern that we would end up calling __try_to_reclaim_swap() far too =
much:
> >>>
> >>> int free_swap_and_cache(swp_entry_t entry)
> >>> {
> >>>     struct swap_info_struct *p;
> >>>     unsigned char count;
> >>>
> >>>     if (non_swap_entry(entry))
> >>>             return 1;
> >>>
> >>>     p =3D _swap_info_get(entry);
> >>>     if (p) {
> >>>             count =3D __swap_entry_free(p, entry);
> >>>             if (count =3D=3D SWAP_HAS_CACHE)
> >>>                     __try_to_reclaim_swap(p, swp_offset(entry),
> >>>                                           TTRS_UNMAPPED | TTRS_FULL);
> >>>     }
> >>>     return p !=3D NULL;
> >>> }
> >>>
> >>> The trouble is, whenever its called, count is always 0, so
> >>> __try_to_reclaim_swap() never gets called.
> >>>
> >>> My test case is allocating 1G anon memory, then doing madvise(MADV_PA=
GEOUT) over
> >>> it. Then doing either a munmap() or madvise(MADV_FREE), both of which=
 cause this
> >>> function to be called for every PTE, but count is always 0 after
> >>> __swap_entry_free() so __try_to_reclaim_swap() is never called. I've =
tried for
> >>> order-0 as well as PTE- and PMD-mapped 2M THP.
> >>
> >> I think you have to page it back in again, then it will have an entry =
in
> >> the swap cache.  Maybe.  I know little about anon memory ;-)
> >
> > Ahh, I was under the impression that the original folio is put into the=
 swap
> > cache at swap out, then (I guess) its removed once the IO is complete? =
I'm sure
> > I'm miles out... what exactly is the lifecycle of a folio going through=
 swap out?
> >
> > I guess I can try forking after swap out, then fault it back in in the =
child and
> > exit. Then do the munmap in the parent. I guess that could force it? Th=
anks for
> > the tip - I'll have a play.
>
> That has sort of solved it, the only problem now is that all the folios i=
n the
> swap cache are small (because I don't have Barry's large swap-in series).=
 So
> really I need to figure out how to avoid removing the folio from the cach=
e in
> the first place...

I am quite sure we have a chance to hit a large swapcache even using zRAM -
a sync swapfile and even during swap-out.

I have a test case as below,
1. two threads to run MADV_PAGEOUT
2. two threads to read data being swapped-out

in do_swap_page, from time to time, I can get a large swapcache.

We have a short time window after add_to_swap() and before
__removing_mapping() of
vmscan,  a large folio is still in swapcache.

So Ryan, I guess you can trigger this by adding one more thread of
MADV_DONTNEED to do zap_pte_range?


>
> >
> >>
> >> If that doesn't work, perhaps use tmpfs, and use some memory pressure =
to
> >> force that to swap?
> >>
> >>> I'm guessing the swapcache was already reclaimed as part of MADV_PAGE=
OUT? I'm
> >>> using a block ram device as my backing store - I think this does sync=
hronous IO
> >>> so perhaps if I have a real block device with async IO I might have m=
ore luck?
> >>> Just a guess...
> >>>
> >>> Or perhaps this code path is a corner case? In which case, perhaps it=
s not worth
> >>> adding the batching optimization after all?
> >>>
> >>> Thanks,
> >>> Ryan
> >>>
> >

Thanks
Barry

