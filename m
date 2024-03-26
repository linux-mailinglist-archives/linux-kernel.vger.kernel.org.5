Return-Path: <linux-kernel+bounces-118582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1689A88BCDD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45D19B20BBF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF70487B5;
	Tue, 26 Mar 2024 08:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mo30qM+p"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32831481BA
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 08:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711443240; cv=none; b=gPFYxBVYdS76wVZwzuEvZsn5yapOlF4wTPF2MOHkNMjnsLqu1vyhlt52s7aHvPuA5pzKrrIDXDGInUt5sihrgIX10C0od4U6V1G8zkP+6H5xmf6rm6sP6K5ETcv2dQ37W62QoR0GcgQLUYJaxsqe87nlBL7mFRsMv9U4jyUn5YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711443240; c=relaxed/simple;
	bh=6+VbqWhziCm/uJ/OVJ0LJCgvlaqy4X2E0gEdsdLrgEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BgCc//IHuvOlU8fPOKRhCK5eKu/Rl0EBBLVLv6c/5F4SLsmXVNBa5eXBuURI0jFAJflaubklWnz6y7wrGPOp0DImy1vcHjuIYltKI55pBEdsmluIIEvlFvdRe80B0+WrCXz/skwiTqqy5P8BgLxCTUh2VJXrBCRF8rE6IZYzMis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mo30qM+p; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4148bc73069so11628145e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 01:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711443236; x=1712048036; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JmVyOPF8Rfshy9JqDqqOaE4ZcsXWwPS/pUZtM8O+dYM=;
        b=mo30qM+p+L4BJhK6HxcD/OYsnP0SyFkZGjg+z3UnMoUdz50Lwam0lS8n2PFRLcFRFY
         hL15o2HA5tEx6bRxlPg1BRe851+aXfcF3CtJqytc+1No11a2lzyeyPgPo3c0ykaKSddC
         mzEGU/xNMuKYZ0ikjoBZ/rFAmY0VsYLGX5K11Q9/UqmpBaZblmlhJznIqLx7FI3GDy5V
         7dSM54fCYDTWSGtaUBFXNTQIhY+MM/Z/icKxRGvoN/DevcMcgyoSpUREWeDiCHnqenNf
         Ug1GMq2yFu5JPS2iVDxqayJR0nOsgBSl8e4I66ky/sIdBdBU0oskiXIXmvw+Mijff/l3
         Y+Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711443236; x=1712048036;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JmVyOPF8Rfshy9JqDqqOaE4ZcsXWwPS/pUZtM8O+dYM=;
        b=uWm6Z6gyXZkrQ2z1qhJx6xihO2QF4agL+pTN+QnCp4rQ/eZgxlhL+47zvgUFv9/EIW
         6PTvXhH+0sQKVqFD38f+blVrqfOLkKc5z2eG7kdWUFgdno4vlBSNDi9Ck8ktMjRe0+Yy
         /plz/lXOGorU5/Ez3dsWK635i9qaLdNBwTqMi2YKfowpsPiG3Ub5CdZoEWOjuW7uTE38
         rL9tIj8wb8gorx3VR6PGBJ+RI3a+3Hy3LZUMnN/xExPZv0AP9kTd7ym1JikINhVuR8AQ
         lmooH+Y42z6vfqI3UkkZC7GdKMfwkOyyyMyaF3CnQbBfssPA4+jVVwD1QFaG/ibiWwbS
         +EkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNp4b3+Auy53Rf3NK4QrhuFHxcNNXL/N3WjZLutLOxFD4JK0IP5x28I5y4/ep6VfUS7Q8Mlpmre+/eLl2rv2UVVGDua4ZtVnAWRJG0
X-Gm-Message-State: AOJu0YyMzytq3j2SKv2TQriZrnwKWJieGeb9st/Ww2iTOUqik8yJ+YQE
	D0MMKq5W7lOVqQoItTLpv0nDuEdHs43wGlPCi0fK1s7TJjp0hEMy
X-Google-Smtp-Source: AGHT+IH0vpA64BXtppF/HSC1865zGAW8kJTw87mVjFaXnWih1sSIO/+nxu0B6FvyejhimqbRzUoQXA==
X-Received: by 2002:a05:600c:4445:b0:413:feed:b309 with SMTP id v5-20020a05600c444500b00413feedb309mr7893850wmn.6.1711443236136;
        Tue, 26 Mar 2024 01:53:56 -0700 (PDT)
Received: from gmail.com (1F2EF63C.nat.pool.telekom.hu. [31.46.246.60])
        by smtp.gmail.com with ESMTPSA id iv16-20020a05600c549000b0041409cabb39sm10829623wmb.18.2024.03.26.01.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 01:53:55 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Tue, 26 Mar 2024 09:53:53 +0100
From: Ingo Molnar <mingo@kernel.org>
To: David Hildenbrand <david@redhat.com>
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
Message-ID: <ZgKNIezvm7tPVuYj@gmail.com>
References: <20240312181118.318701-1-david@redhat.com>
 <ZfCrkL-Aieer2EAg@casper.infradead.org>
 <5bc9de2f-c3ba-46e7-a234-3d3a46e53ba1@redhat.com>
 <ZgKIVogEUEnUMgpF@gmail.com>
 <922c5f99-1194-4118-9fe2-09b4f4a8cf04@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <922c5f99-1194-4118-9fe2-09b4f4a8cf04@redhat.com>


* David Hildenbrand <david@redhat.com> wrote:

> On 26.03.24 09:33, Ingo Molnar wrote:
> > 
> > * David Hildenbrand <david@redhat.com> wrote:
> > 
> > > On 12.03.24 20:22, Matthew Wilcox wrote:
> > > > On Tue, Mar 12, 2024 at 07:11:18PM +0100, David Hildenbrand wrote:
> > > > > PAT handling won't do the right thing in COW mappings: the first PTE
> > > > > (or, in fact, all PTEs) can be replaced during write faults to point at
> > > > > anon folios. Reliably recovering the correct PFN and cachemode using
> > > > > follow_phys() from PTEs will not work in COW mappings.
> > > > 
> > > > I guess the first question is: Why do we want to support COW mappings
> > > > of VM_PAT areas?  What breaks if we just disallow it?
> > > 
> > > Well, that was my first approach. Then I decided to be less radical (IOW
> > > make my life easier by breaking less user space) and "fix it" with
> > > minimal effort.
> > > 
> > > Chances of breaking some weird user space is possible, although I believe
> > > for most such mappings MAP_PRIVATE doesn't make too much sense sense.
> > > 
> > > Nasty COW support for VM_PFNMAP mappings dates back forever. So does PAT
> > > support.
> > > 
> > > I can try finding digging through some possible user space users
> > > tomorrow.
> > 
> > I'd much prefer restricting VM_PAT areas than expanding support. Could we
> 
> Note that we're not expanding support, we're fixing what used to be
> possible before but mostly broke silently.

Yeah - that's de-facto expanding support. :-)

> But I agree that we should rather remove these corner cases instead of 
> fixing them.

Yeah, especially if no code is hitting it intentionally.

> > try the trivial restriction approach first, and only go with your original
> > patch if that fails?
> 
> Which version would you prefer, I had two alternatives (excluding comment
> changes, white-space expected to be broken).
> 
> 
> 1) Disallow when we would have set VM_PAT on is_cow_mapping()
> 
> diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
> index 0d72183b5dd0..6979912b1a5d 100644
> --- a/arch/x86/mm/pat/memtype.c
> +++ b/arch/x86/mm/pat/memtype.c
> @@ -994,6 +994,9 @@ int track_pfn_remap(struct vm_area_struct *vma, pgprot_t *prot,
>                                 && size == (vma->vm_end - vma->vm_start))) {
>                 int ret;
> +               if (is_cow_mapping(vma->vm_flags))
> +                       return -EINVAL;
> +
>                 ret = reserve_pfn_range(paddr, size, prot, 0);
>                 if (ret == 0 && vma)
>                         vm_flags_set(vma, VM_PAT);
> 
> 
> 2) Fallback to !VM_PAT
> 
> diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
> index 0d72183b5dd0..8e97156c9be8 100644
> --- a/arch/x86/mm/pat/memtype.c
> +++ b/arch/x86/mm/pat/memtype.c
> @@ -990,8 +990,8 @@ int track_pfn_remap(struct vm_area_struct *vma, pgprot_t *prot,
>         enum page_cache_mode pcm;
>         /* reserve the whole chunk starting from paddr */
> -       if (!vma || (addr == vma->vm_start
> -                               && size == (vma->vm_end - vma->vm_start))) {
> +       if (!vma || (!is_cow_mapping(vma->vm_flags) && addr == vma->vm_start &&
> +                    size == (vma->vm_end - vma->vm_start))) {
>                 int ret;
>                 ret = reserve_pfn_range(paddr, size, prot, 0);
>
> 
> 
> Personally, I'd go for 2).

So what's the advantage of #2? This is clearly something the user didn't 
really intend or think about much. Isn't explicitly failing that mapping a 
better option than silently downgrading it to !VM_PAT?

(If I'm reading it right ...)

Thanks,

	Ingo

