Return-Path: <linux-kernel+bounces-103062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C87C587BA88
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA4F9B21F66
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 09:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E206E612;
	Thu, 14 Mar 2024 09:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WcW+0gAd"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15CF6CDB9;
	Thu, 14 Mar 2024 09:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710408860; cv=none; b=AIbMq84zrFTR96n4F3goU0peOrCcoRPUXhNBV13jzSFQ2YnUOMeB3k374auZb1yhsoOrlk+E7rSnJyVhbPHvuWl95A3AzOn0BNqZJfwZ5DI2ULMEatBN/zHAftw+hz4j3BI9REGtm7ut7vm/caG7yKyl3e3SelwapED4BO0bQNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710408860; c=relaxed/simple;
	bh=TtKloTKt+vs+msYtMieSZFtif9thqlkEzEJDwxV3fD4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EGOxhAk+9Aec4w8zUVAJW0rUORewTlAZZQGH5J/Qhb5VvcnoQMgl95pgM6U+5B37/cgQhg9Xy36ombUMykJwMr81CZlvaEVImxURL8bsmheVHzXwN9W8U1La7eDoLixLWp+KBXg5/AqO2IUfa+XJyuV4AnWaX1ll8j0JhVZE098=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WcW+0gAd; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-563bb51c36eso920942a12.2;
        Thu, 14 Mar 2024 02:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710408857; x=1711013657; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ILGaGiWtB+vOVzUENmPA1Ty/XwZ6Aazho4HgWe5ZzyU=;
        b=WcW+0gAdi8Rvzr+iBcbNs6kSqpDXzqp3FkBEEtq+iU9ySlJSK/WFSXd5W+UkGmeNY/
         8zU0OriN50s2dHUoYJV+AWym30cd5LV1Y2wYRrBCKg/LGAiBMOsMlnuPx9fjaKAIWU0p
         1zXbAmD6ZUm4vMpwOBNCYVo6c4iXSrzHWzNzh2g1JXakZFvR2jwlwwPLorcIzUtXoGZZ
         0ppbbfjxuAfwU4L1ar0XSRZooQgUcp3AK1rmRlxFJivlpL9SvBO6Q6B3bn1UWor9SOdW
         oOPw4Gv+a9KVzRJbl/1VJV+qt+AV7nBccjI86DDcNeGRwdVS640ZtGaQFlFeqhT9RpyU
         IdrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710408857; x=1711013657;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ILGaGiWtB+vOVzUENmPA1Ty/XwZ6Aazho4HgWe5ZzyU=;
        b=UuKoeCjmQ3D/pzHpmf2GkuA+JnLf/QMtZW8J0uFXRsx7CYGzGYeYL2ZmgHS56lDYR0
         DS44TmYRLoW0a8LswtJSrMI2vWFHLPcVMO4LzCNdHSMVN9IMXNGcBOgUmpWkxeoiO2qf
         YK3XU+v817vAe/D4Ao8T85mlJkokbYM9YhZy/CslcuXCQmMQD5oO+OhPvDej4NG1Pwhc
         MfAHXfqbuhrpWD1ryYzbz+L8Xg9+UHbmR6Bs5c7wOJNffj4llyviHkdr99CaiIoUOazx
         J0ZUBbpRQTq4uZ96tu1S3t+EVNtZR8RojuTm+L62dzYK2rCiy+M4j8KB9b/myvPSNSDX
         8T0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVd7rzmpUiZWPpwcQIBZtLXIYcoHT7Mf2M7xe5QjRNuSmglvgjeZp3KwyG/IpvpCuV5mnG47ryckAbjYP3xAFvRzXrGT0TtkuVf3agiGVBJ3yA3DeLH8bF/a62Exv/yGGxSBzsqd4YTp/PJhst4IcZWU8xmu0wYYrJ2S5cZ50PkDyQEbAV9Cr1incj/oIXdJc4au0SY6w==
X-Gm-Message-State: AOJu0Yxok9vGQ6ep5kh9Y2XAo3OxP6drIn/oTu9HREwx85KbJbPL8u2j
	GI2lNsRLiQh5MMj31FR7UHdWyRPqaJ9wcWuEwFDosSG2K9NAtrKW
X-Google-Smtp-Source: AGHT+IGeBKAZGfED4yLU+s/SkX31e8txpco9w0bZDKwjtjSw0/E6W4u0ke9VKjBtP2eTZfLI2egvNg==
X-Received: by 2002:a05:6402:1f13:b0:567:564f:5bd8 with SMTP id b19-20020a0564021f1300b00567564f5bd8mr633655edb.32.1710408857084;
        Thu, 14 Mar 2024 02:34:17 -0700 (PDT)
Received: from pc636 (host-87-9-234-71.retail.telecomitalia.it. [87.9.234.71])
        by smtp.gmail.com with ESMTPSA id 6-20020a0564021f4600b005682a0e915fsm521510edz.76.2024.03.14.02.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 02:34:16 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Thu, 14 Mar 2024 10:34:14 +0100
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Networking <netdev@vger.kernel.org>,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	"Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: Re: linux-next: manual merge of the bpf-next tree with the mm-stable
 tree
Message-ID: <ZfLElrAT3RMLuWdB@pc636>
References: <20240307123619.159f1c4c@canb.auug.org.au>
 <20240313105117.699dc720@canb.auug.org.au>
 <20240314093012.3dba692a@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314093012.3dba692a@canb.auug.org.au>

> Hi all,
> 
> On Wed, 13 Mar 2024 10:51:17 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > On Thu, 7 Mar 2024 12:36:19 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > > 
> > > Today's linux-next merge of the bpf-next tree got a conflict in:
> > > 
> > >   mm/vmalloc.c
> > > 
> > > between commit:
> > > 
> > >   8e1d743f2c26 ("mm: vmalloc: support multiple nodes in vmallocinfo")
> > > 
> > > from the mm-stable tree and commit:
> > > 
> > >   e6f798225a31 ("mm: Introduce VM_SPARSE kind and vm_area_[un]map_pages().")
> > > 
> > > from the bpf-next tree.
> > > 
> > > I fixed it up (I think - see below) and can carry the fix as necessary.
> > > This is now fixed as far as linux-next is concerned, but any non trivial
> > > conflicts should be mentioned to your upstream maintainer when your tree
> > > is submitted for merging.  You may also want to consider cooperating
> > > with the maintainer of the conflicting tree to minimise any particularly
> > > complex conflicts.
> > > 
> > > 
> > > diff --cc mm/vmalloc.c
> > > index 25a8df497255,e5b8c70950bc..000000000000
> > > --- a/mm/vmalloc.c
> > > +++ b/mm/vmalloc.c
> > > @@@ -4755,81 -4423,70 +4820,84 @@@ static void show_numa_info(struct seq_f
> > >   
> > >   static void show_purge_info(struct seq_file *m)
> > >   {
> > >  +	struct vmap_node *vn;
> > >   	struct vmap_area *va;
> > >  +	int i;
> > >   
> > >  -	spin_lock(&purge_vmap_area_lock);
> > >  -	list_for_each_entry(va, &purge_vmap_area_list, list) {
> > >  -		seq_printf(m, "0x%pK-0x%pK %7ld unpurged vm_area\n",
> > >  -			(void *)va->va_start, (void *)va->va_end,
> > >  -			va->va_end - va->va_start);
> > >  -	}
> > >  -	spin_unlock(&purge_vmap_area_lock);
> > >  -}
> > >  +	for (i = 0; i < nr_vmap_nodes; i++) {
> > >  +		vn = &vmap_nodes[i];
> > >   
> > >  -static int s_show(struct seq_file *m, void *p)
> > >  -{
> > >  -	struct vmap_area *va;
> > >  -	struct vm_struct *v;
> > >  -
> > >  -	va = list_entry(p, struct vmap_area, list);
> > >  -
> > >  -	if (!va->vm) {
> > >  -		if (va->flags & VMAP_RAM)
> > >  -			seq_printf(m, "0x%pK-0x%pK %7ld vm_map_ram\n",
> > >  +		spin_lock(&vn->lazy.lock);
> > >  +		list_for_each_entry(va, &vn->lazy.head, list) {
> > >  +			seq_printf(m, "0x%pK-0x%pK %7ld unpurged vm_area\n",
> > >   				(void *)va->va_start, (void *)va->va_end,
> > >   				va->va_end - va->va_start);
> > >  -
> > >  -		goto final;
> > >  +		}
> > >  +		spin_unlock(&vn->lazy.lock);
> > >   	}
> > >  +}
> > >   
> > >  -	v = va->vm;
> > >  +static int vmalloc_info_show(struct seq_file *m, void *p)
> > >  +{
> > >  +	struct vmap_node *vn;
> > >  +	struct vmap_area *va;
> > >  +	struct vm_struct *v;
> > >  +	int i;
> > >   
> > >  -	seq_printf(m, "0x%pK-0x%pK %7ld",
> > >  -		v->addr, v->addr + v->size, v->size);
> > >  +	for (i = 0; i < nr_vmap_nodes; i++) {
> > >  +		vn = &vmap_nodes[i];
> > >   
> > >  -	if (v->caller)
> > >  -		seq_printf(m, " %pS", v->caller);
> > >  +		spin_lock(&vn->busy.lock);
> > >  +		list_for_each_entry(va, &vn->busy.head, list) {
> > >  +			if (!va->vm) {
> > >  +				if (va->flags & VMAP_RAM)
> > >  +					seq_printf(m, "0x%pK-0x%pK %7ld vm_map_ram\n",
> > >  +						(void *)va->va_start, (void *)va->va_end,
> > >  +						va->va_end - va->va_start);
> > >   
> > >  -	if (v->nr_pages)
> > >  -		seq_printf(m, " pages=%d", v->nr_pages);
> > >  +				continue;
> > >  +			}
> > >   
> > >  -	if (v->phys_addr)
> > >  -		seq_printf(m, " phys=%pa", &v->phys_addr);
> > >  +			v = va->vm;
> > >   
> > >  -	if (v->flags & VM_IOREMAP)
> > >  -		seq_puts(m, " ioremap");
> > >  +			seq_printf(m, "0x%pK-0x%pK %7ld",
> > >  +				v->addr, v->addr + v->size, v->size);
> > >   
> > >  -	if (v->flags & VM_SPARSE)
> > >  -		seq_puts(m, " sparse");
> > >  +			if (v->caller)
> > >  +				seq_printf(m, " %pS", v->caller);
> > >   
> > >  -	if (v->flags & VM_ALLOC)
> > >  -		seq_puts(m, " vmalloc");
> > >  +			if (v->nr_pages)
> > >  +				seq_printf(m, " pages=%d", v->nr_pages);
> > >   
> > >  -	if (v->flags & VM_MAP)
> > >  -		seq_puts(m, " vmap");
> > >  +			if (v->phys_addr)
> > >  +				seq_printf(m, " phys=%pa", &v->phys_addr);
> > >   
> > >  -	if (v->flags & VM_USERMAP)
> > >  -		seq_puts(m, " user");
> > >  +			if (v->flags & VM_IOREMAP)
> > >  +				seq_puts(m, " ioremap");
> > >   
> > >  -	if (v->flags & VM_DMA_COHERENT)
> > >  -		seq_puts(m, " dma-coherent");
> > > ++			if (v->flags & VM_SPARSE)
> > > ++				seq_puts(m, " sparse");
> > > + 
> > >  -	if (is_vmalloc_addr(v->pages))
> > >  -		seq_puts(m, " vpages");
> > >  +			if (v->flags & VM_ALLOC)
> > >  +				seq_puts(m, " vmalloc");
> > >   
> > >  -	show_numa_info(m, v);
> > >  -	seq_putc(m, '\n');
> > >  +			if (v->flags & VM_MAP)
> > >  +				seq_puts(m, " vmap");
> > >  +
> > >  +			if (v->flags & VM_USERMAP)
> > >  +				seq_puts(m, " user");
> > >  +
> > >  +			if (v->flags & VM_DMA_COHERENT)
> > >  +				seq_puts(m, " dma-coherent");
> > >  +
> > >  +			if (is_vmalloc_addr(v->pages))
> > >  +				seq_puts(m, " vpages");
> > >  +
> > >  +			show_numa_info(m, v);
> > >  +			seq_putc(m, '\n');
> > >  +		}
> > >  +		spin_unlock(&vn->busy.lock);
> > >  +	}
> > >   
> > >   	/*
> > >   	 * As a final step, dump "unpurged" areas.  
> > 
> > This is now a conflict between the net-next tree and the mm-stable tree.
> 
>  ... and now a conflict between te mm-stable tree and Linus' tree.
>
If you need some help with resolving conflicts i can help. The problem
to me looks like:

<snip>
commit d7bca9199a27b8690ae1c71dc11f825154af7234
Author: Alexei Starovoitov <ast@kernel.org>
Date:   Fri Mar 8 09:12:54 2024 -0800

    mm: Introduce vmap_page_range() to map pages in PCI address space

commit e6f798225a31485e47a6e4f6aa07ee9fdf80c2cb
Author: Alexei Starovoitov <ast@kernel.org>
Date:   Mon Mar 4 19:05:16 2024 -0800

    mm: Introduce VM_SPARSE kind and vm_area_[un]map_pages().

commit 3e49a866c9dcbd8173e4f3e491293619a9e81fa4
Author: Alexei Starovoitov <ast@kernel.org>
Date:   Mon Mar 4 19:05:15 2024 -0800

    mm: Enforce VM_IOREMAP flag and range in ioremap_page_range.
<snip>

those three patches were not based on linux-next and are currently
in the Linus tree(bypassing mm-tree?). Whereas below work:

mm: vmalloc: refactor vmalloc_dump_obj() function
mm: vmalloc: improve description of vmap node layer
mm: vmalloc: add a shrinker to drain vmap pools
mm: vmalloc: set nr_nodes based on CPUs in a system
mm: vmalloc: support multiple nodes in vmallocinfo
mm: vmalloc: support multiple nodes in vread_iter
mm: vmalloc: add a scan area of VA only once
mm: vmalloc: offload free_vmap_area_lock lock
mm: vmalloc: remove global purge_vmap_area_root rb-tree
mm/vmalloc: remove vmap_area_list
mm: vmalloc: remove global vmap_area_root rb-tree
mm: vmalloc: move vmap_init_free_space() down in vmalloc.c
mm: vmalloc: rename adjust_va_to_fit_type() function
mm: vmalloc: add va_alloc() helper

now should be based on Alexei Starovoitov base in order to resolve
a small conflict.

But you better know how to proceed. Just in case, if you need some
support please let me know i can help with conflict resolving.

--
Uladzislau Rezki

