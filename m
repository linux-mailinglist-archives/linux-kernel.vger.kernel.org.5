Return-Path: <linux-kernel+bounces-58201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A8B84E2A7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 588E7B276F5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B7377626;
	Thu,  8 Feb 2024 13:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ScdAkdkP"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F10B763FC
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 13:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707400634; cv=none; b=L/wf7oved0NhXluzD/P+l10+rvEQxMEmFbHA+AQ6Hx8zPDImU5jyZ08QFDtrlaYbgCkOd74zMj7s4/z7RDuPFwzd7aYNCnP3df63VMLyZNG10UFf4YdAiKosklKJSFaw4WvU8MnM/5TODrcVCseqgHnUd6EBbyWBqVOPuLsMlMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707400634; c=relaxed/simple;
	bh=/FyVXFLXM46GcFAYu2W70Hbhstrqi8Tu8o4uVbRiDAg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gi1ITM5EPhGctgkndFc2Z7LfVjLR41LsPW1JAZrYd40bcsRDFCKXjH5kAtztyCTmSyHmh9KrYccnElR/fhhae//oh56uMdbkiXCRdFaX+43cjhVTv+gaRT5M5NFw+fZ7IXUmsEKNeq4e+ajVahbucg/qQL4HopcHSp2uEWArp5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ScdAkdkP; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5114b2b3b73so2317630e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 05:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707400629; x=1708005429; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+/hAwBT47MJRRxh8alPQwYNx6sh+Hi8aT47CmZgK+yI=;
        b=ScdAkdkPvZCGYHRvh44gkPG7iv1KpPb8sijwjixSZePQNXvOD8+Qqc00XxiVDpgU1X
         TIKJ8vhzx4jGyohmOHTz+/MO/wqZyUQobwfDjd16lqMyph2KUFGvwA6cs1v7mqaGwP+z
         V3c2xtxPjSkCpYX65MUN1c5/1OJ1KpWaV59xXcZqQArgAu4NL5qbiGEQtEG7NWI15TZL
         LKwrTbRgiCg3I/aytaR8+32YH9uP/TyHUQKkpK3aKDQzLwuR1fICvRN0OATDtspWxt16
         zTg+2O/+aT+Y7GqvhTqto8gkDOklByMBgXuCJZzRFqx2i7ceoy4rzyfz8Yj5qbXXcH0d
         opgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707400629; x=1708005429;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+/hAwBT47MJRRxh8alPQwYNx6sh+Hi8aT47CmZgK+yI=;
        b=WbKhsAgmJJ2qyvx7whRFL2DsAP1ib1RjJBJsT4Rzu4MXeeGjgx/t47YNQSu4XXZMtl
         e6e+KnSFg5AgdnsmJsXlZ+HcxmzCq18Qjk+ECJlMmRWrCqjDt/dC70nWt/CPmfPrzLns
         jLIBrqTBYXDEqi8BlO50CuRephBTuQmZREbwo3q5oBMyAGtFRcntNM05jNXvnfAnWElg
         zNLZrflz3FvsyVIS8IxKzg4dLRwj4rk40afWGPiVm5yM4RnRUhCniU86Oal6DKKqT6+a
         J7KEMU3LiIVyqFWlL/HCRlbYE5NvYquLFh8cDeDQeDi59A6jQGTfJrXz7Cb4aPvs3/1e
         /RJw==
X-Forwarded-Encrypted: i=1; AJvYcCWcGyasjp/gy2JhzdZMTeCpuLODwdmY9Azmp8DTIcPcbPKKBj+pkIDRaxc1evDtohcs3Np7isEUc7vQZOaTWZs6EFPKLSVTgFv7lr8D
X-Gm-Message-State: AOJu0YwZ0YzzZ9zZJY6ZAvX8UJH+C82Sq7E02rS5RcEok21XxNt7B5CH
	W5oRza3FwoyQx1bv3eclywursXJ9rVQZ/gliapySqeFqtwTvg/wb
X-Google-Smtp-Source: AGHT+IHjLb4jfqTrLqYuTbhBCjWANTP+gaLcCURf8aXIVTCkPV1j7zNN86Uc5xLsLXcUGT5Qz1ekgw==
X-Received: by 2002:ac2:59c1:0:b0:511:5537:fb26 with SMTP id x1-20020ac259c1000000b005115537fb26mr7359213lfn.39.1707400629233;
        Thu, 08 Feb 2024 05:57:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWVATMuk3Idv+QnmvbT0ZEO29k05njN8wNzUl02jAYclIB1fcsOpUpe3kJvWF9R3LI7IlamaqseXdQF4Un6lCi5DjbUtMp065NaRE8xxRCUOeHLG6A7QgWzIRmfEN8zKuUxCTYdWWY/sE3IvQ42TOhRKZw18WKcZMcZpAox/S+s41YowJu9Vx/0RpCgRQ2x1oc6kS4vYROZx2EpRR6WY9rCdBcCUgFAsRK6WJnccjjQe72IcAjzn76bNJynw0XuHAARVI21DOVYwNacjxSiorbwZ1YPNA3Lun6bkTz32WZzl5FGdtbjIM0LGFOE/4/uc2LY/2HqT4vFsLmFkA64mU2F7XE7ivns07NQ+nZRqDC4jhUetAZ8AWE9qqK146xByXRJHwt9hg6wIgF1VtcFuTg=
Received: from pc636 (host-90-233-221-0.mobileonline.telia.com. [90.233.221.0])
        by smtp.gmail.com with ESMTPSA id k26-20020ac2457a000000b0051151b47c58sm7528lfm.97.2024.02.08.05.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 05:57:08 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Thu, 8 Feb 2024 14:57:06 +0100
To: Baoquan He <bhe@redhat.com>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Matthew Wilcox <willy@infradead.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Dave Chinner <david@fromorbit.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v3 07/11] mm: vmalloc: Offload free_vmap_area_lock lock
Message-ID: <ZcTdssE-4xpkMaPH@pc636>
References: <20240102184633.748113-1-urezki@gmail.com>
 <20240102184633.748113-8-urezki@gmail.com>
 <ZcQfc6myl5KCFk3V@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcQfc6myl5KCFk3V@MiWiFi-R3L-srv>

On Thu, Feb 08, 2024 at 08:25:23AM +0800, Baoquan He wrote:
> On 01/02/24 at 07:46pm, Uladzislau Rezki (Sony) wrote:
> ......
> > +static struct vmap_area *
> > +node_alloc(unsigned long size, unsigned long align,
> > +		unsigned long vstart, unsigned long vend,
> > +		unsigned long *addr, unsigned int *vn_id)
> > +{
> > +	struct vmap_area *va;
> > +
> > +	*vn_id = 0;
> > +	*addr = vend;
> > +
> > +	/*
> > +	 * Fallback to a global heap if not vmalloc or there
> > +	 * is only one node.
> > +	 */
> > +	if (vstart != VMALLOC_START || vend != VMALLOC_END ||
> > +			nr_vmap_nodes == 1)
> > +		return NULL;
> > +
> > +	*vn_id = raw_smp_processor_id() % nr_vmap_nodes;
> > +	va = node_pool_del_va(id_to_node(*vn_id), size, align, vstart, vend);
> > +	*vn_id = encode_vn_id(*vn_id);
> > +
> > +	if (va)
> > +		*addr = va->va_start;
> > +
> > +	return va;
> > +}
> > +
> >  /*
> >   * Allocate a region of KVA of the specified size and alignment, within the
> >   * vstart and vend.
> > @@ -1637,6 +1807,7 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
> >  	struct vmap_area *va;
> >  	unsigned long freed;
> >  	unsigned long addr;
> > +	unsigned int vn_id;
> >  	int purged = 0;
> >  	int ret;
> >  
> > @@ -1647,11 +1818,23 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
> >  		return ERR_PTR(-EBUSY);
> >  
> >  	might_sleep();
> > -	gfp_mask = gfp_mask & GFP_RECLAIM_MASK;
> >  
> > -	va = kmem_cache_alloc_node(vmap_area_cachep, gfp_mask, node);
> > -	if (unlikely(!va))
> > -		return ERR_PTR(-ENOMEM);
> > +	/*
> > +	 * If a VA is obtained from a global heap(if it fails here)
> > +	 * it is anyway marked with this "vn_id" so it is returned
> > +	 * to this pool's node later. Such way gives a possibility
> > +	 * to populate pools based on users demand.
> > +	 *
> > +	 * On success a ready to go VA is returned.
> > +	 */
> > +	va = node_alloc(size, align, vstart, vend, &addr, &vn_id);
> 
> Sorry for late checking.
> 
No problem :)

> Here, if no available va got, e.g a empty vp, still we will get an
> effective vn_id with the current cpu_id for VMALLOC region allocation
> request.
> 
> > +	if (!va) {
> > +		gfp_mask = gfp_mask & GFP_RECLAIM_MASK;
> > +
> > +		va = kmem_cache_alloc_node(vmap_area_cachep, gfp_mask, node);
> > +		if (unlikely(!va))
> > +			return ERR_PTR(-ENOMEM);
> > +	}
> >  
> >  	/*
> >  	 * Only scan the relevant parts containing pointers to other objects
> > @@ -1660,10 +1843,12 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
> >  	kmemleak_scan_area(&va->rb_node, SIZE_MAX, gfp_mask);
> >  
> >  retry:
> > -	preload_this_cpu_lock(&free_vmap_area_lock, gfp_mask, node);
> > -	addr = __alloc_vmap_area(&free_vmap_area_root, &free_vmap_area_list,
> > -		size, align, vstart, vend);
> > -	spin_unlock(&free_vmap_area_lock);
> > +	if (addr == vend) {
> > +		preload_this_cpu_lock(&free_vmap_area_lock, gfp_mask, node);
> > +		addr = __alloc_vmap_area(&free_vmap_area_root, &free_vmap_area_list,
> > +			size, align, vstart, vend);
> 
> Then, here, we will get an available va from random location, but its
> vn_id is from the current cpu.
> 
> Then in purge_vmap_node(), we will decode the vn_id stored in va->flags,
> and add the relevant va into vn->pool[] according to the vn_id. The
> worst case could be most of va in vn->pool[] are not corresponding to
> the vmap_nodes they belongs to. It doesn't matter?
> 
We do not do any "in-front" population, instead it behaves as a cache
miss when you need to access a main memmory to do a load and then keep
the data in a cache.

Same here. As a first step, for a CPU it always a miss, thus a VA is
obtained from the global heap and is marked with a current CPU that
makes an attempt to alloc. Later on that CPU/node is populated by that
marked VA. So second alloc on same CPU goes via fast path.

VAs are populated based on demand and those nodes which do allocations.

> Should we adjust the code of vn_id assigning in node_alloc(), or I missed anything?
Now it is open-coded. Some further refactoring should be done. Agree.

--
Uladzislau Rezki

