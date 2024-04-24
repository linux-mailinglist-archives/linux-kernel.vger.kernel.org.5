Return-Path: <linux-kernel+bounces-157686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68FF68B1499
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 22:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D8862874AD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EBE214C588;
	Wed, 24 Apr 2024 20:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vYv5SZQr"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBC614C594
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 20:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713990696; cv=none; b=TBVVUyKbRAzmWlGqKTk7rukCLYsolFyGR3c4dm51Ee3sbUna/noKcXpDic5N4nnPpTV39cPY96fHgCb95krV55dU3eRMbnM0xdCfslgP+pycBMTMLOQ79bk2/0KH8D6v7gYcOl7rBrtqfDHrXMewkXSVS7IDP6AyR38SqX2OJ74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713990696; c=relaxed/simple;
	bh=CtKCUQB4Kql7tmaWP27sTCH5+nmqkV3XR81u4Dirqt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HJOrI7geH68gYNdd4TygrxHT8Ggfp6ntymtMV70nBkl9+6MUkKr4qItzyOwYz435/HQmCC5Juxp0FDA5Da0z2A1465kwo6jLJDIFRAftnwq3XirVat1TxP9cKbQ78OnkK6RJob7shAzhHhbHk/HbiArZN7Cua/y2pOYbhS9u82o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vYv5SZQr; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-34b1e35155aso208543f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 13:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713990693; x=1714595493; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z+e+2WTr+55fMN46zgpBMyY5FEksh29xdSRSoFD8QA8=;
        b=vYv5SZQr4ZmBL4R7NDR/iUpjAIoLvukjMu3HB/xnTTdJcAftLO9uEraM8nj9Eki8XI
         jvmQownnfIx0EsPiElD5QXKC2jx+8bm/+nugeY/9ZPno6EoysJL+GGcQL5Fai5h0z5Bt
         5J8uImkvpqXVhrcvXNEysMb8tlLinyJcr+CirU7vflV8/gB0R6q3UtShTSJKjjdav8uF
         D6ADHWhIIIbO3Q+FruvDgALEmdGJeDWBzIgc49JlbUN/zSAK+mMS7eG88qHB0wAtOzkx
         Ml6rTYSkunFa4ke52Fqn78iPR7AZpmQbmWQq5XLmNYKPyxIqrwITyLkdJMewQH3+MAUk
         +oGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713990693; x=1714595493;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z+e+2WTr+55fMN46zgpBMyY5FEksh29xdSRSoFD8QA8=;
        b=Aa/Jg26K81QKA3zC9p+Qi4m567DZQ6w0+8z4MBICFyx+28OQnhakA6n4e4H4DewNxP
         UdM72mxAzCl7PHc6a+RX08XEBImk7mNzLK/cE5GDz2VYAAHZ4BwfpELSZynrjw+5sHtW
         G6TBlb3OVKdjp+DuXNyZv2G2Xp20ygzdWMccTWoi4bOpUkLTb+Jl8TODlPXyHdJAbBvg
         7zLlnS62suw8ZNiBK7g0ApCd/ekieIBp77gzKsMHyYSSFoUaWCU8o6nJ7t3BRINRMqLu
         nz2aphIf5zFkQXGrzIj9QuwfchUE9+LaZUMwV+mD15PP078tyxmkNt7Uir+TZL255st/
         iaWA==
X-Forwarded-Encrypted: i=1; AJvYcCW/wOmy/UCd+uMbI+McFDyhapg1lgEMICra6FNf9tfhy6X+Mmp9OjfGTPAVKHqIUjhrZLy04y/mdDZn0aUQJYrtH8/2ijv7pDYnf0ya
X-Gm-Message-State: AOJu0Yz5X0Ojcu3AOuqHnca+Jei+Sij6bQvV8GAtWQqh19hSLS0Nj/aP
	tdLpRzK2yof1ElsGLmV4ZE3OFDLSMoYXTd6VQS9dZ3cg3TcgtGUwgDgrb70t0g==
X-Google-Smtp-Source: AGHT+IEGKcbjUU7gQUoARxLVWBP0bJ54qDWMxcamBa/BNEqC2QN8trrUllxOuvopFvTPyhfU9aNJYA==
X-Received: by 2002:a05:600c:3b26:b0:418:a706:3209 with SMTP id m38-20020a05600c3b2600b00418a7063209mr3509802wms.31.1713990693060;
        Wed, 24 Apr 2024 13:31:33 -0700 (PDT)
Received: from google.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id v18-20020a5d43d2000000b0034a25339e47sm17107793wrr.69.2024.04.24.13.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 13:31:32 -0700 (PDT)
Date: Wed, 24 Apr 2024 21:31:28 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: David Hildenbrand <david@redhat.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
	kernel-team@android.com, rdunlap@infradead.org, rppt@kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v21 2/5] ring-buffer: Introducing ring-buffer mapping
 functions
Message-ID: <ZilsIJYbJ-JN4elq@google.com>
References: <20240423232728.1492340-1-vdonnefort@google.com>
 <20240423232728.1492340-3-vdonnefort@google.com>
 <f972ce5a-0351-450c-98a2-38188eae5001@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f972ce5a-0351-450c-98a2-38188eae5001@redhat.com>

Hi David,

Thanks for your quick response.

On Wed, Apr 24, 2024 at 05:26:39PM +0200, David Hildenbrand wrote:
> 
> I gave it some more thought, and I think we are still missing something (I
> wish PFNMAP/MIXEDMAP wouldn't be that hard).
> 
> > +
> > +/*
> > + *   +--------------+  pgoff == 0
> > + *   |   meta page  |
> > + *   +--------------+  pgoff == 1
> > + *   | subbuffer 0  |
> > + *   |              |
> > + *   +--------------+  pgoff == (1 + (1 << subbuf_order))
> > + *   | subbuffer 1  |
> > + *   |              |
> > + *         ...
> > + */
> > +#ifdef CONFIG_MMU
> > +static int __rb_map_vma(struct ring_buffer_per_cpu *cpu_buffer,
> > +			struct vm_area_struct *vma)
> > +{
> > +	unsigned long nr_subbufs, nr_pages, vma_pages, pgoff = vma->vm_pgoff;
> > +	unsigned int subbuf_pages, subbuf_order;
> > +	struct page **pages;
> > +	int p = 0, s = 0;
> > +	int err;
> > +
> 
> I'd add some comments here like
> 
> /* Refuse any MAP_PRIVATE or writable mappings. */
> > +	if (vma->vm_flags & VM_WRITE || vma->vm_flags & VM_EXEC ||
> > +	    !(vma->vm_flags & VM_MAYSHARE))
> > +		return -EPERM;
> > +
> 
> /*
>  * Make sure the mapping cannot become writable later. Also, tell the VM
>  * to not touch these pages pages (VM_DONTCOPY | VM_DONTDUMP) and tell
>  * GUP to leave them alone as well (VM_IO).
>  */
> > +	vm_flags_mod(vma,
> > +		     VM_MIXEDMAP | VM_PFNMAP |
> > +		     VM_DONTCOPY | VM_DONTDUMP | VM_DONTEXPAND | VM_IO,
> > +		     VM_MAYWRITE);
> 
> I am still really unsure about VM_PFNMAP ... it's not a PFNMAP at all and,
> as stated, vm_insert_pages() even complains quite a lot when it would have
> to set VM_MIXEDMAP and VM_PFNMAP is already set, likely for a very good
> reason.
> 
> Can't we limit ourselves to VM_IO?
> 
> But then, I wonder if it really helps much regarding GUP: yes, it blocks
> ordinary GUP (see check_vma_flags()) but as insert_page_into_pte_locked()
> does *not* set pte_special(), GUP-fast (gup_fast_pte_range()) will not
> reject it.
> 
> Really, if you want GUP-fast to reject it, remap_pfn_range() and friends are
> the way to go, that will set pte_special() such that also GUP-fast will
> leave it alone, just like vm_normal_page() would.
> 
> So ... I know Linus recommended VM_PFNMAP/VM_IO to stop GUP, but it alone
> won't stop all of GUP. We really have to mark the PTE as special, which
> vm_insert_page() must not do (because it is refcounted!).

Hum, apologies, I am not sure to follow the connection here. Why do you think
the recommendation was to prevent GUP?

> 
> Which means: do we really have to stop GUP from grabbing that page?
> 
> Using vm_insert_page() only with VM_MIXEDMAP (and without VM_PFNMAP|VM_IO)
> would be better.

Under the assumption we do not want to stop all GUP, why not using VM_IO over
VM_MIXEDMAP which is I believe more restrictive?

> 
> If we want to stop all of GUP, remap_pfn_range() currently seems unavoidable
> :(
> 
> 
> > +
> > +	lockdep_assert_held(&cpu_buffer->mapping_lock);
> > +
> > +	subbuf_order = cpu_buffer->buffer->subbuf_order;
> > +	subbuf_pages = 1 << subbuf_order;
> > +
> > +	nr_subbufs = cpu_buffer->nr_pages + 1; /* + reader-subbuf */
> > +	nr_pages = ((nr_subbufs) << subbuf_order) - pgoff + 1; /* + meta-page */
> > +
> > +	vma_pages = (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
> > +	if (!vma_pages || vma_pages > nr_pages)
> > +		return -EINVAL;
> > +
> > +	nr_pages = vma_pages;
> > +
> > +	pages = kcalloc(nr_pages, sizeof(*pages), GFP_KERNEL);
> > +	if (!pages)
> > +		return -ENOMEM;
> > +
> > +	if (!pgoff) {
> > +		pages[p++] = virt_to_page(cpu_buffer->meta_page);
> > +
> > +		/*
> > +		 * TODO: Align sub-buffers on their size, once
> > +		 * vm_insert_pages() supports the zero-page.
> > +		 */
> > +	} else {
> > +		/* Skip the meta-page */
> > +		pgoff--;
> > +
> > +		if (pgoff % subbuf_pages) {
> > +			err = -EINVAL;
> > +			goto out;
> > +		}
> > +
> > +		s += pgoff / subbuf_pages;
> > +	}
> > +
> > +	while (s < nr_subbufs && p < nr_pages) {
> > +		struct page *page = virt_to_page(cpu_buffer->subbuf_ids[s]);
> > +		int off = 0;
> > +
> > +		for (; off < (1 << (subbuf_order)); off++, page++) {
> > +			if (p >= nr_pages)
> > +				break;
> > +
> > +			pages[p++] = page;
> > +		}
> > +		s++;
> > +	}
> > +
> > +	err = vm_insert_pages(vma, vma->vm_start, pages, &nr_pages);
> 
> vm_insert_pages() documents: "In case of error, we may have mapped a subset
> of the provided pages. It is the caller's responsibility to account for this
> case."
> 
> Which could for example happen, when allocating a page table fails.
> 
> Would we able to deal with that here?

As we are in the mmap path, on an error, I would expect the vma to be destroyed
and those pages whom insertion succeeded to be unmapped?

But perhaps shall we proactively zap_page_range_single()?

> 
> 
> Again, I wish it would all be easier ...
> 
> -- 
> Cheers,
> 
> David / dhildenb
> 
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
> 

