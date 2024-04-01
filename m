Return-Path: <linux-kernel+bounces-126569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF8F8939AB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 11:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D42B1F22204
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 09:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9AE710A09;
	Mon,  1 Apr 2024 09:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A0H+RVxS"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DD610953
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 09:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711964713; cv=none; b=Xw5B39MrDunKD62YdeFmpeLni3c2yCJVflpMDhYfhUiKxxbdCVQ8P5jcZYsgnuiiv1w2x/NExSbywFcT2F0xpsYSGW+PYCDLg+Xw1rlfZcXmoe8jD8shagDU0Xng1itwKJ+LVMRom0i8pynrXXiULpIW6M22oOOEPJElkBxMKTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711964713; c=relaxed/simple;
	bh=hfIRYPByEwNm+w1/dkJ/FXHGtCJkgCwdoYJZKYVRTm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l2jkhDtUbeXLlJsw/bWm8ovpJMJACDE8IU4Ie7f4JyUolU36d0C+qqIh6Pep5Oab4qdzHDY6mcR/nMkN+0yXB7edolgEjSuGyd8OOqCCcTfpkNCyyRDLW4YXnaXXgnKgb0xwQn8ihxpLv4kPegEZSkCswX1LRvAn1wsgmpFrmEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A0H+RVxS; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4148c6132b4so26908825e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 02:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711964710; x=1712569510; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U82/zKNoj7Un9bj3VUFlAllXXEKzojenj3FXQK42VVY=;
        b=A0H+RVxSI0MmHETEfTEBHNySZ/ys8zEmF7e7WyZgeuV0lVDDI1+tF/+/bYhCg8aMeB
         rIVD1NUHTgqDpRF1EQ/toWkhobMZ4OH5+LgzqxmzZFWIi/wr/U9AgBAVwv9yZTHurbry
         8viBAX0jDBpV8dCCplv25NXGhDjmsjzSv0U7K4IrTytGmIJ5OEMmtuXp4PccHRGvD3aF
         XEnKTC/JD5LP+3x29W0RotteQISxC4Zp4dXgYWThUN2YlqCq6QacU3INydJ7+ca63nMd
         3QiiyoPtsl5LwJbTw7CqVX2g81grq+C4XKvNLz/BisjB2sKAFu6md+i3cW4SPisPkdFK
         wtKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711964710; x=1712569510;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U82/zKNoj7Un9bj3VUFlAllXXEKzojenj3FXQK42VVY=;
        b=Tu9bdfulVgDlyOQZnrnEMMfjQzZp66RdV6+lFDBYO0UNxRlRi+2ML5r24OCWtpyFK1
         C+MnKCcnS7p97hhmETpL1hby42uiOKPBOc9NYiVCF2aBbU1JGgotd2k2xYCgCJen16xc
         EfmRRy/igJXbAzz3lESaQvH3RwiCQP7gZcXp3KbXbQr18Nrsu0xmch9ttaIk299TMMC4
         kvGuOGGVvNtzJJAF/tuNuZf0+Rwrs0hu43TND/8J+b4+pwbLfS2vv3Oo8lW9FTETLblB
         QRjoROVxB0olpfcu/Wuc36bVqg8mppMvlo9hStlx+iB8OJTumCgHnPEpfM92eHldKIrQ
         ub1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWmK8JOuuR4NRJEAeC8/zKfEI6hxsgrsRloUifAbUw/HgyNeTdxoek2wIs0ouFh3I75vsTQPPUYmtM5bGlhpS9zrR/Yz4gsRK8kkkD1
X-Gm-Message-State: AOJu0YwUcmmTYRbJFr7A/bNi3aaXzFVu82CcqLHQ/hawZOcOumCsXaeM
	XM8V4VRzW9DmW4DfqGV3sTGj2Gr0ld70KtnKJhLNBEl9xEVYQLml
X-Google-Smtp-Source: AGHT+IEhC542QHRw2FssFYxmPWyaAlrYdv090z5cJ0v/jmfm7wGlSCr/ORSk0b1JZ0wN6uNB5O3RSg==
X-Received: by 2002:a05:600c:5123:b0:414:37f:2798 with SMTP id o35-20020a05600c512300b00414037f2798mr7878513wms.6.1711964710077;
        Mon, 01 Apr 2024 02:45:10 -0700 (PDT)
Received: from gmail.com (84-236-113-97.pool.digikabel.hu. [84.236.113.97])
        by smtp.gmail.com with ESMTPSA id g1-20020adfa481000000b00341e7e52802sm11250804wrb.92.2024.04.01.02.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 02:45:09 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Mon, 1 Apr 2024 11:45:07 +0200
From: Ingo Molnar <mingo@kernel.org>
To: David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, x86@kernel.org,
	Wupeng Ma <mawupeng1@huawei.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v1] x86/mm/pat: fix VM_PAT handling in COW mappings
Message-ID: <ZgqCI8ClUKM4B5xG@gmail.com>
References: <20240312181118.318701-1-david@redhat.com>
 <ZfCrkL-Aieer2EAg@casper.infradead.org>
 <5bc9de2f-c3ba-46e7-a234-3d3a46e53ba1@redhat.com>
 <ZgKIVogEUEnUMgpF@gmail.com>
 <922c5f99-1194-4118-9fe2-09b4f4a8cf04@redhat.com>
 <ZgKNIezvm7tPVuYj@gmail.com>
 <2420ca24-b475-45ba-bab9-66c11b8cf484@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2420ca24-b475-45ba-bab9-66c11b8cf484@redhat.com>


* David Hildenbrand <david@redhat.com> wrote:

> > > > try the trivial restriction approach first, and only go with your original
> > > > patch if that fails?
> > > 
> > > Which version would you prefer, I had two alternatives (excluding comment
> > > changes, white-space expected to be broken).
> > > 
> > > 
> > > 1) Disallow when we would have set VM_PAT on is_cow_mapping()
> > > 
> > > diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
> > > index 0d72183b5dd0..6979912b1a5d 100644
> > > --- a/arch/x86/mm/pat/memtype.c
> > > +++ b/arch/x86/mm/pat/memtype.c
> > > @@ -994,6 +994,9 @@ int track_pfn_remap(struct vm_area_struct *vma, pgprot_t *prot,
> > >                                  && size == (vma->vm_end - vma->vm_start))) {
> > >                  int ret;
> > > +               if (is_cow_mapping(vma->vm_flags))
> > > +                       return -EINVAL;
> > > +
> > >                  ret = reserve_pfn_range(paddr, size, prot, 0);
> > >                  if (ret == 0 && vma)
> > >                          vm_flags_set(vma, VM_PAT);
> > > 
> > > 
> > > 2) Fallback to !VM_PAT
> > > 
> > > diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
> > > index 0d72183b5dd0..8e97156c9be8 100644
> > > --- a/arch/x86/mm/pat/memtype.c
> > > +++ b/arch/x86/mm/pat/memtype.c
> > > @@ -990,8 +990,8 @@ int track_pfn_remap(struct vm_area_struct *vma, pgprot_t *prot,
> > >          enum page_cache_mode pcm;
> > >          /* reserve the whole chunk starting from paddr */
> > > -       if (!vma || (addr == vma->vm_start
> > > -                               && size == (vma->vm_end - vma->vm_start))) {
> > > +       if (!vma || (!is_cow_mapping(vma->vm_flags) && addr == vma->vm_start &&
> > > +                    size == (vma->vm_end - vma->vm_start))) {
> > >                  int ret;
> > >                  ret = reserve_pfn_range(paddr, size, prot, 0);
> > > 
> > > 
> > > 
> > > Personally, I'd go for 2).
> > 
> > So what's the advantage of #2? This is clearly something the user didn't
> > really intend or think about much. Isn't explicitly failing that mapping a
> > better option than silently downgrading it to !VM_PAT?
> > 
> > (If I'm reading it right ...)
> 
> I think a simple mmap(MAP_PRIVATE) of /dev/mem will unconditionally fail
> with 1), while it keeps on working for 2).
> 
> Note that I think we currently set VM_PAT on each and every system if
> remap_pfn_range() will cover the whole VMA, even if pat is not actually
> enabled.
> 
> It's all a bit of a mess TBH, but I got my hands dirty enough on that.
> 
> So 1) can be rather destructive ... 2) at least somehow keeps it working.
> 
> For that reason I went with the current patch, because it's hard to tell
> which use case you will end up breaking ... :/

Yeah, so I think you make valid observations, i.e. your first patch is 
probably the best one.

But since it changes mm/memory.c, I'd like to pass that over to Andrew 
and the MM folks.

The x86 bits:

  Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo

