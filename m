Return-Path: <linux-kernel+bounces-42699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6414840541
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 439DB1F22AC3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 12:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D49612FC;
	Mon, 29 Jan 2024 12:45:41 +0000 (UTC)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE8E612CD
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 12:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706532340; cv=none; b=GgHqvnAT3R0bQpXZ/FBD3odaHezcylhYpb0Z4ZWRgMmuLpjJwwIBZ3Y2cncrtO9BtI63T5MffdaTnuVme43XpYa2VM/dVMpqHEuEC3/0JXuKM1s0AMJisZWYiale1pU1lV2YgU/YitU17TeRItbmJphqXq7G7wswJFLdMuoxxVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706532340; c=relaxed/simple;
	bh=CHT/UvYOHji0r/mcFEVYGzN2pmHuEOKTabVerwfiNOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YsYPAdp0ZC08DQBJ9qVFLHVYd8BQ39XngLWyfznSnZj5MdqNeq6xqU20f2ExXlFqV79w85J0WiJv61rR13isUBrcmf6VwcpzP0ntb8LxdOzE0DzmpFsLw+f8h1Te14owalENBAF7yv38GGvjcN5oKrL9mnVhE5IzHhey2EyoZ04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-55f03ede12cso949582a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 04:45:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706532337; x=1707137137;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/XBG9kFEaRnAAH7vBNHAabPo0iBDwnoKijQp+k7kbBw=;
        b=GCurvUB6Xfx+XbbLIoKQokWfTYIfA4bmb1kGCTGivqGl87rOqT2jvggY9slgh+vaKp
         KbeckaALbZx0El7oUnIJbiEmNrKrysE8u2cjDYLKjWJlD0dQxwiSY4ZctFh/5q5vFHS3
         OUVn/PKbyds0IaGbbshoj9wYmGWJFLrFU28u1017x98KdqlXxaCrCc90Sh09/BkoMN5O
         ZXHVpeC+Jmhoa8E4b95rPZZpqpBNe7UCPkzB3z/yETyul9uzmUL+73DaD4oLwD49fOwD
         kyEsZQqfpntXhyhmGj2BfhcLCofOidudgNDmyYhMMdIUTkAz1C07YRzs0V/bBUxnx8LF
         qekA==
X-Gm-Message-State: AOJu0Yx2bgXbY1FaOBXFrbL0GcPG3d8sQUC1xFHZqH2hf1a/H5CgyI/i
	zhUx96qCd8UcGGJCeNuFdRVB2oIi4koM1fI62m34KheAwlZo9uZzCpSVduwi/xLT0g==
X-Google-Smtp-Source: AGHT+IFWCfE0GI5vHIVPrNSMYwLdUjsx2uLON4IZW8QzhSo44niCSgeugPXbLnsIcOeVK17JCtnuuA==
X-Received: by 2002:aa7:d8d0:0:b0:55e:faef:b1fd with SMTP id k16-20020aa7d8d0000000b0055efaefb1fdmr1731568eds.2.1706532336550;
        Mon, 29 Jan 2024 04:45:36 -0800 (PST)
Received: from gmail.com (fwdproxy-cln-011.fbsv.net. [2a03:2880:31ff:b::face:b00c])
        by smtp.gmail.com with ESMTPSA id a20-20020aa7d754000000b0055efeee7722sm1005959eds.79.2024.01.29.04.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 04:45:36 -0800 (PST)
Date: Mon, 29 Jan 2024 04:45:34 -0800
From: Breno Leitao <leitao@debian.org>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, lstoakes@gmail.com,
	willy@infradead.org, mike.kravetz@oracle.com,
	Rik van Riel <riel@surriel.com>,
	"open list:HUGETLB SUBSYSTEM" <linux-mm@kvack.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] mm/hugetlb: Restore the reservation if needed
Message-ID: <Zbed7hlo38WHbQaf@gmail.com>
References: <20240117171058.2192286-1-leitao@debian.org>
 <7a0d92a9-f28c-4f3c-b956-1157e614dcbe@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a0d92a9-f28c-4f3c-b956-1157e614dcbe@arm.com>

On Wed, Jan 24, 2024 at 09:22:03AM +0000, Ryan Roberts wrote:
> On 17/01/2024 17:10, Breno Leitao wrote:
> > Currently there is a bug that a huge page could be stolen, and when the
> > original owner tries to fault in it, it causes a page fault.
> > 
> > You can achieve that by:
> >   1) Creating a single page
> > 	echo 1 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages
> > 
> >   2) mmap() the page above with MAP_HUGETLB into (void *ptr1).
> > 	* This will mark the page as reserved
> >   3) touch the page, which causes a page fault and allocates the page
> > 	* This will move the page out of the free list.
> > 	* It will also unreserved the page, since there is no more free
> > 	  page
> >   4) madvise(MADV_DONTNEED) the page
> > 	* This will free the page, but not mark it as reserved.
> >   5) Allocate a secondary page with mmap(MAP_HUGETLB) into (void *ptr2).
> > 	* it should fail, but, since there is no more available page.
> > 	* But, since the page above is not reserved, this mmap() succeed.
> >   6) Faulting at ptr1 will cause a SIGBUS
> > 	* it will try to allocate a huge page, but there is none
> > 	  available
> > 
> > A full reproducer is in selftest. See
> > https://lore.kernel.org/all/20240105155419.1939484-1-leitao@debian.org/
> > 
> > Fix this by restoring the reserved page if necessary. If the page being
> > unmapped has HPAGE_RESV_OWNER set, and needs a reservation, set the
> > restore_reserve flag, which will move the page from free to reserved.
> > 
> > Suggested-by: Rik van Riel <riel@surriel.com>
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> >  mm/hugetlb.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index ed1581b670d4..fa2c17767e44 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -5677,6 +5677,16 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
> >  		hugetlb_count_sub(pages_per_huge_page(h), mm);
> >  		hugetlb_remove_rmap(page_folio(page));
> >  
> > +		if (is_vma_resv_set(vma, HPAGE_RESV_OWNER) &&
> > +		    vma_needs_reservation(h, vma, start)) {
> > +			/*
> > +			 * Restore the reservation if needed, otherwise the
> > +			 * backing page could be stolen by someone.
> > +			 */
> > +			folio_set_hugetlb_restore_reserve(page_folio(page));
> > +			vma_add_reservation(h, vma, address);
> > +		}
> > +
> >  		spin_unlock(ptl);
> >  		tlb_remove_page_size(tlb, page, huge_page_size(h));
> >  		/*
> 
> Hi Breno,
> 
> I'm seeing a kernel bug fire when running the "map_hugetlb" mm selftest against latest mm-unstable. Bisect tells me this patch is culprit. I'm running on arm64 with defconfig plus the following:

Hello Ryan,

Thanks for the heads-up. I was able to reproduce the problem, and I am
working on a solution.

Thanks,

