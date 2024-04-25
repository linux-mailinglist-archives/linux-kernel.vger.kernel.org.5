Return-Path: <linux-kernel+bounces-158920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F213F8B26B9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB843281DC8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F2814D2B4;
	Thu, 25 Apr 2024 16:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uEeUAUfZ"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26B012C7FB
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 16:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714063373; cv=none; b=GIf70ZclM6Nn5u2Zpk30h/MceyEv6MCdAeM1VEmomUdpQemE7d6rwQF/34P5o/YtqXm8Ca497FLlAd9ru+sF7N1TcHVFiifQjd16I20CoN7VMxwKU9dIOVJmTjmEnHp2hd0WjtZZVIds8cTh7HU7yE/MgQKO2/nAc90VgQuunMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714063373; c=relaxed/simple;
	bh=IzhS+r5VX2Jh6DdP0gmuixDbgKhhwtq6sckzGQUK6Zk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YNbyWvpafEpvdeNjD6UKXBN7TIMn1rZ/na3RXNnqF+PZL3e2BhG/E4Se1T+AYpvyjS50F/11Glyy9jnRqERDbFq3UqbS3JcFiU+Yb9N0DLTEjmHv/J2PIG5SYqYFB4uBSuMNJMvIBHzfxXYWf6hgmeb6Y0xI1LThG10i4SYSDc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uEeUAUfZ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4155819f710so9116085e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 09:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714063370; x=1714668170; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pd9muZXAE1QeC2Q0jSj7EXZonh/pvXQTuPC6IhHyTRM=;
        b=uEeUAUfZOUYb0iHX6vZeOuoC+GW9/lDUVaNLkfpfX4FwfqAsoq+ZDOYzjM0ZFxkRM0
         HNm0siJWLwZuiPIALJlRuYEeT1IVqSvFucU+o9p/YObgIuV68jN2hU+KnQ7+u7bDTwPb
         jNsNndoc5sLVxG7uEiAzRAfduVnY+epmCdm9Cm+w8zwczGne/BownBMdZS4SuvfIEvq7
         V5roA5hwlxHXB8HxJVg/TMa1F7rmuKd+5O3KCprB+z0quFAEemr2fCsbv46XDiThrpog
         79f56WqgyeFKFMr/gdGguS6UX6rfzzjt73RRzL86ha0oJNet2t/bVoVrYs81L6M0yrKu
         1usw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714063370; x=1714668170;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pd9muZXAE1QeC2Q0jSj7EXZonh/pvXQTuPC6IhHyTRM=;
        b=FZZwcZ+cZRNqxbCMNdJ9Ue4Tuaobx40a+AoskByQGwd13DsE6YAzsMHQKnOfK8VKDt
         mEzPR1bHCIMtr1p/+uY0YZsPFxyqj8M5RCdESaCqqbJDT+3txrdCBr7zDXaI6uOf4xMa
         Qt0KteGCzp8v16dhAkvS4YMuPaqZ24LJWm8OMBq8Mzd6gqT/ylBgZUHufOL18EFvvKkd
         k1Jf1EhljqmF47mL7t4cGkwpc+MP/rV05ry9HLLhVAnB1N0IhjRCaHjIYGxaQfObRxYM
         89FTAqRlmLGdb8/+O9Q/NTHy8Em43nq9nhgpD6xd6VleseAU0TNjnK4+ITptpaNvHwTt
         QjIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRQVRr878n7arZNWrIKSYz3xsjXKs0zZCRsPPewxnTwIc4pniFvbpN3hU9jbAj6/dvvDFOnvHkxTwjPaCg+ElOUW+hCmN6a572Yzsl
X-Gm-Message-State: AOJu0Yyd6U17der1tV/VAZ5v7mYratkvQSy1mPuie2+QRK/irQrvekh4
	Go+hjM3uhr62U4EwyHIfb39R3L0UMwRm02Pxp/eh/68rzJCYiO3sotRDmHkOfA==
X-Google-Smtp-Source: AGHT+IHsaeXu4R31cOaI1TWvONiQZe3Gmyq7LQ0VxmJDOkoZTHbtpY2o/zXKK9857hF89/2Wr3VBdg==
X-Received: by 2002:a05:600c:1c0f:b0:41a:c170:701f with SMTP id j15-20020a05600c1c0f00b0041ac170701fmr4799480wms.38.1714063370017;
        Thu, 25 Apr 2024 09:42:50 -0700 (PDT)
Received: from google.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id a12-20020a056000188c00b00347eb354b30sm20590173wri.84.2024.04.25.09.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 09:42:49 -0700 (PDT)
Date: Thu, 25 Apr 2024 17:42:46 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: David Hildenbrand <david@redhat.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
	kernel-team@android.com, rdunlap@infradead.org, rppt@kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v21 2/5] ring-buffer: Introducing ring-buffer mapping
 functions
Message-ID: <ZiqIBo4sX-oAgj2M@google.com>
References: <20240423232728.1492340-1-vdonnefort@google.com>
 <20240423232728.1492340-3-vdonnefort@google.com>
 <f972ce5a-0351-450c-98a2-38188eae5001@redhat.com>
 <ZilsIJYbJ-JN4elq@google.com>
 <04137a08-8918-422c-8512-beb2074a427e@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04137a08-8918-422c-8512-beb2074a427e@redhat.com>

On Wed, Apr 24, 2024 at 10:55:54PM +0200, David Hildenbrand wrote:
> On 24.04.24 22:31, Vincent Donnefort wrote:
> > Hi David,
> > 
> > Thanks for your quick response.
> > 
> > On Wed, Apr 24, 2024 at 05:26:39PM +0200, David Hildenbrand wrote:
> > > 
> > > I gave it some more thought, and I think we are still missing something (I
> > > wish PFNMAP/MIXEDMAP wouldn't be that hard).
> > > 
> > > > +
> > > > +/*
> > > > + *   +--------------+  pgoff == 0
> > > > + *   |   meta page  |
> > > > + *   +--------------+  pgoff == 1
> > > > + *   | subbuffer 0  |
> > > > + *   |              |
> > > > + *   +--------------+  pgoff == (1 + (1 << subbuf_order))
> > > > + *   | subbuffer 1  |
> > > > + *   |              |
> > > > + *         ...
> > > > + */
> > > > +#ifdef CONFIG_MMU
> > > > +static int __rb_map_vma(struct ring_buffer_per_cpu *cpu_buffer,
> > > > +			struct vm_area_struct *vma)
> > > > +{
> > > > +	unsigned long nr_subbufs, nr_pages, vma_pages, pgoff = vma->vm_pgoff;
> > > > +	unsigned int subbuf_pages, subbuf_order;
> > > > +	struct page **pages;
> > > > +	int p = 0, s = 0;
> > > > +	int err;
> > > > +
> > > 
> > > I'd add some comments here like
> > > 
> > > /* Refuse any MAP_PRIVATE or writable mappings. */
> > > > +	if (vma->vm_flags & VM_WRITE || vma->vm_flags & VM_EXEC ||
> > > > +	    !(vma->vm_flags & VM_MAYSHARE))
> > > > +		return -EPERM;
> > > > +
> > > 
> > > /*
> > >   * Make sure the mapping cannot become writable later. Also, tell the VM
> > >   * to not touch these pages pages (VM_DONTCOPY | VM_DONTDUMP) and tell
> > >   * GUP to leave them alone as well (VM_IO).
> > >   */
> > > > +	vm_flags_mod(vma,
> > > > +		     VM_MIXEDMAP | VM_PFNMAP |
> > > > +		     VM_DONTCOPY | VM_DONTDUMP | VM_DONTEXPAND | VM_IO,
> > > > +		     VM_MAYWRITE);
> > > 
> > > I am still really unsure about VM_PFNMAP ... it's not a PFNMAP at all and,
> > > as stated, vm_insert_pages() even complains quite a lot when it would have
> > > to set VM_MIXEDMAP and VM_PFNMAP is already set, likely for a very good
> > > reason.
> > > 
> > > Can't we limit ourselves to VM_IO?
> > > 
> > > But then, I wonder if it really helps much regarding GUP: yes, it blocks
> > > ordinary GUP (see check_vma_flags()) but as insert_page_into_pte_locked()
> > > does *not* set pte_special(), GUP-fast (gup_fast_pte_range()) will not
> > > reject it.
> > > 
> > > Really, if you want GUP-fast to reject it, remap_pfn_range() and friends are
> > > the way to go, that will set pte_special() such that also GUP-fast will
> > > leave it alone, just like vm_normal_page() would.
> > > 
> > > So ... I know Linus recommended VM_PFNMAP/VM_IO to stop GUP, but it alone
> > > won't stop all of GUP. We really have to mark the PTE as special, which
> > > vm_insert_page() must not do (because it is refcounted!).
> > 
> > Hum, apologies, I am not sure to follow the connection here. Why do you think
> > the recommendation was to prevent GUP?
> 
> Ah, I'm hallucinating! :) "not let people play games with the mapping" to me
> implied "make sure nobody touches it". If GUP is acceptable that makes stuff
> a lot easier. VM_IO will block some GUP, but not all of it.
> 
> > 
> > > 
> > > Which means: do we really have to stop GUP from grabbing that page?
> > > 
> > > Using vm_insert_page() only with VM_MIXEDMAP (and without VM_PFNMAP|VM_IO)
> > > would be better.
> > 
> > Under the assumption we do not want to stop all GUP, why not using VM_IO over
> > VM_MIXEDMAP which is I believe more restrictive?
> 
> VM_MIXEDMAP will be implicitly set by vm_insert_page(). There is a lengthy comment
> for vm_normal_page() that explains all this madness. VM_MIXEDMAP is primarily
> relevant for COW mappings, which you just forbid completely.
> 
> remap_pfn_range_notrack() documents the semantics of some of the other flags:
> 
> 	 *   VM_IO tells people not to look at these pages
> 	 *	(accesses can have side effects).
> 	 *   VM_PFNMAP tells the core MM that the base pages are just
> 	 *	raw PFN mappings, and do not have a "struct page" associated
> 	 *	with them.
> 	 *   VM_DONTEXPAND
> 	 *      Disable vma merging and expanding with mremap().
> 	 *   VM_DONTDUMP
> 	 *      Omit vma from core dump, even when VM_IO turned off.
> 
> VM_PFNMAP is very likely really not what we want, unless we really perform raw
> PFN mappings ... VM_IO we can set without doing much harm.
> 
> So I would suggest dropping VM_PFNMAP when using vm_insert_pages(), using only VM_IO
> and likely just letting vm_insert_pages() set VM_MIXEDMAP for you.

Sounds good, I will do that in v22.

> 
> [...]
> 
> > > 
> > > vm_insert_pages() documents: "In case of error, we may have mapped a subset
> > > of the provided pages. It is the caller's responsibility to account for this
> > > case."
> > > 
> > > Which could for example happen, when allocating a page table fails.
> > > 
> > > Would we able to deal with that here?
> > 
> > As we are in the mmap path, on an error, I would expect the vma to be destroyed
> > and those pages whom insertion succeeded to be unmapped?
> > 
> 
> Ah, we simply fail ->mmap().
> 
> In mmap_region(), if call_mmap() failed, we "goto unmap_and_free_vma" where we have
> 
> /* Undo any partial mapping done by a device driver. */
> unmap_region(mm, &vmi.mas, vma, prev, next, vma->vm_start, vma->vm_end, vma->vm_end, true);
> 
> 
> > But perhaps shall we proactively zap_page_range_single()?
> 
> No mmap_region() should indeed be handling it correctly already!

Ok, thanks for confirming!

> 
> -- 
> Cheers,
> 
> David / dhildenb
> 

