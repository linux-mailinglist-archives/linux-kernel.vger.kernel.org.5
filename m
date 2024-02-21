Return-Path: <linux-kernel+bounces-74310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D724F85D2A0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CB51B24490
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DCCB3C680;
	Wed, 21 Feb 2024 08:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b1lO8TOY"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CCC374EC
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 08:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708504611; cv=none; b=iDM3/A+4oMjFPQlqw8pAoDzJb3vseQJXJs9dd4rvAUzgDV/cO2d51DnsTyw+i64V6e+sXcS9zpOfXgGWf8rFMUTYy97M9MUJi0WVZRhrE/sw1B4p5iYTCpzpBK0bacjjCNJnsKP/0AvsTPOOj4mZuugQB4dSCCRS3hJFjZX4Qd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708504611; c=relaxed/simple;
	bh=MZLGTfQ+llptQeYvonTf8ZRtdnPTzIjFv7pFXV4ly2o=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tIHrCRhAwRJ5Cuv4XGJ3s85WUEb0HDsrHnndVM7GcecBCrFj2WlJTCUcs6OGH9xtoXOJkOosJvMEpHno3XWkT5Oe9VPbnphw2sDMjDferNA3qxybuLqGTdNmsftmDuguozEvzRXFoolQjNwc9MXpz+8ROQVCV8uIkzRteFt0HxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b1lO8TOY; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-512aafb3ca8so3488066e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 00:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708504608; x=1709109408; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OOEkN5zzS8AdBwHRBxEL83E6EfiU4pKbnsarrgPrKNo=;
        b=b1lO8TOYqkkWpePvnVP1wXZ5uT2J6dxJuPLD0+TBXfD9ym7la/zdknV5UFR+0TtZt0
         3l32pWE2z8m1vpIefS7UyPn+jgO0v2E9zPuvDQ66XCf9LsFeeMabFXvZgZOw8CQ5F7S2
         RHixeVzE4e+LgmdxFAeSy7QlUJYJn0LQ+DOp11LSzY9dMFwh3taR9rwprO8myeFVKAXQ
         GmKNLl8Uv/kldCEY5Z3Na/ssA0bM/tmIi1dzA87nb3ejvReRDIhpgyyyzyZVCmq9zF6R
         hTj3uvxlchJ4wywJGPiXIqT7YRLrI2U4IbImTPjN8lJKdsbtyixf50LDU5SlguebG6vq
         P94w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708504608; x=1709109408;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OOEkN5zzS8AdBwHRBxEL83E6EfiU4pKbnsarrgPrKNo=;
        b=b/jsfaGuOsVTW3d/dT+nJqZr74VzcOL7sIjTOMphZNC6INbPxRoQ7pyB+QCVgD4l4E
         qUAfPKfpV/8lPvvHDQoLPF1zUNX/9sPrblWYAbVCRb1PZD+Is1Zlw+clTT/rAKzqBg8d
         9IhBXBo3V9CVzuGMfk4NSFacC/dV4I4k+2n9YTsNFQXcNkixfqklTtGgZVeVwPpW69lN
         jMVYW9UkdiiVOf7hJdB/LC7yAqu2JHGOyxeCZO1StJdajDw9nhzxfJ9YJtJhj4d75BpQ
         ohAildRN3YxKSuQBMkHsD+t7D9CNgJVfs96KHvXohGoRDOXZhAxymnBrO5n718VsQVLz
         dX8w==
X-Forwarded-Encrypted: i=1; AJvYcCVVvHtGlCHrXreIHzanGcmT/afsQzyCUmBbGnNlXoj1wEsrzh/kbdJCaVS320qVQZ4vAmF10xW3r1P1RAUoy5H2Ws7jeYx5R3BWQO3g
X-Gm-Message-State: AOJu0YyfHKsfyMJxiayPUwym3bRe42vbmMvCc6jg6Z+bIYobrT4B8TcQ
	/ylzmy9Bz58VbXarLpn9s2GEBFsZWmr7QuOq7s2QLNvJ5OWUUj+d
X-Google-Smtp-Source: AGHT+IHs8CgWki/h4dwNO1UeNqhCR8NGomJkiR9fMcDxPqxYx1RdDdpKEDfVNf75KzXFzlt685vKyQ==
X-Received: by 2002:a05:6512:ba1:b0:512:bda4:bf47 with SMTP id b33-20020a0565120ba100b00512bda4bf47mr4905320lfv.4.1708504607648;
        Wed, 21 Feb 2024 00:36:47 -0800 (PST)
Received: from pc636 (host-90-233-206-150.mobileonline.telia.com. [90.233.206.150])
        by smtp.gmail.com with ESMTPSA id g25-20020ac25399000000b00512aa465e2dsm1364054lfh.206.2024.02.21.00.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 00:36:47 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Wed, 21 Feb 2024 09:36:44 +0100
To: rulinhuang <rulin.huang@intel.com>
Cc: akpm@linux-foundation.org, colin.king@intel.com, hch@infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	lstoakes@gmail.com, tianyou.li@intel.com, tim.c.chen@intel.com,
	urezki@gmail.com, wangyang.guo@intel.com, zhiguo.zhou@intel.com
Subject: Re: [PATCH v3] mm/vmalloc: lock contention optimization under
 multi-threading
Message-ID: <ZdW2HB-XdAJKph5s@pc636>
References: <20240207033059.1565623-1-rulin.huang@intel.com>
 <20240221032905.11392-1-rulin.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221032905.11392-1-rulin.huang@intel.com>

On Tue, Feb 20, 2024 at 10:29:05PM -0500, rulinhuang wrote:
> When allocating a new memory area where the mapping address range is
> known, it is observed that the vmap_area lock is acquired twice.
> The first acquisition occurs in the alloc_vmap_area() function when
> inserting the vm area into the vm mapping red-black tree. The second
> acquisition occurs in the setup_vmalloc_vm() function when updating the
> properties of the vm, such as flags and address, etc.
> Combine these two operations together in alloc_vmap_area(), which
> improves scalability when the vmap_area lock is contended. By doing so,
> the need to acquire the lock twice can also be eliminated.
> With the above change, tested on intel icelake platform(160 vcpu, kernel
> v6.7), a 6% performance improvement and a 7% reduction in overall
> spinlock hotspot are gained on
> stress-ng/pthread(https://github.com/ColinIanKing/stress-ng), which is
> the stress test of thread creations.
> 
> Reviewed-by: Chen Tim C <tim.c.chen@intel.com>
> Reviewed-by: King Colin <colin.king@intel.com>
> Signed-off-by: rulinhuang <rulin.huang@intel.com>
> ---
> V1 -> V2: Avoided the partial initialization issue of vm and 
> separated insert_vmap_area() from alloc_vmap_area()
> V2 -> V3: Rebased on 6.8-rc5
> ---
>  mm/vmalloc.c | 36 +++++++++++++++++++++---------------
>  1 file changed, 21 insertions(+), 15 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index d12a17fc0c17..768e45f2ed94 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -1630,17 +1630,18 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
>  	va->vm = NULL;
>  	va->flags = va_flags;
>  
> -	spin_lock(&vmap_area_lock);
> -	insert_vmap_area(va, &vmap_area_root, &vmap_area_list);
> -	spin_unlock(&vmap_area_lock);
> -
>  	BUG_ON(!IS_ALIGNED(va->va_start, align));
>  	BUG_ON(va->va_start < vstart);
>  	BUG_ON(va->va_end > vend);
>  
>  	ret = kasan_populate_vmalloc(addr, size);
>  	if (ret) {
> -		free_vmap_area(va);
> +		/*
> +		 * Insert/Merge it back to the free tree/list.
> +		 */
> +		spin_lock(&free_vmap_area_lock);
> +		merge_or_add_vmap_area_augment(va, &free_vmap_area_root, &free_vmap_area_list);
> +		spin_unlock(&free_vmap_area_lock);
>  		return ERR_PTR(ret);
>  	}
>  
> @@ -1669,6 +1670,13 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
>  	return ERR_PTR(-EBUSY);
>  }
>  
> +static inline void insert_vmap_area_with_lock(struct vmap_area *va)
> +{
> +	spin_lock(&vmap_area_lock);
> +	insert_vmap_area(va, &vmap_area_root, &vmap_area_list);
> +	spin_unlock(&vmap_area_lock);
> +}
> +
>  int register_vmap_purge_notifier(struct notifier_block *nb)
>  {
>  	return blocking_notifier_chain_register(&vmap_notify_list, nb);
> @@ -2045,6 +2053,8 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
>  		return ERR_CAST(va);
>  	}
>  
> +	insert_vmap_area_with_lock(va);
> +
>  	vaddr = vmap_block_vaddr(va->va_start, 0);
>  	spin_lock_init(&vb->lock);
>  	vb->va = va;
> @@ -2398,6 +2408,8 @@ void *vm_map_ram(struct page **pages, unsigned int count, int node)
>  		if (IS_ERR(va))
>  			return NULL;
>  
> +		insert_vmap_area_with_lock(va);
> +
>  		addr = va->va_start;
>  		mem = (void *)addr;
>  	}
> @@ -2538,7 +2550,7 @@ static void vmap_init_free_space(void)
>  	}
>  }
>  
> -static inline void setup_vmalloc_vm_locked(struct vm_struct *vm,
> +static inline void setup_vmalloc_vm(struct vm_struct *vm,
>  	struct vmap_area *va, unsigned long flags, const void *caller)
>  {
>  	vm->flags = flags;
> @@ -2548,14 +2560,6 @@ static inline void setup_vmalloc_vm_locked(struct vm_struct *vm,
>  	va->vm = vm;
>  }
>  
> -static void setup_vmalloc_vm(struct vm_struct *vm, struct vmap_area *va,
> -			      unsigned long flags, const void *caller)
> -{
> -	spin_lock(&vmap_area_lock);
> -	setup_vmalloc_vm_locked(vm, va, flags, caller);
> -	spin_unlock(&vmap_area_lock);
> -}
> -
>  static void clear_vm_uninitialized_flag(struct vm_struct *vm)
>  {
>  	/*
> @@ -2600,6 +2604,8 @@ static struct vm_struct *__get_vm_area_node(unsigned long size,
>  
>  	setup_vmalloc_vm(area, va, flags, caller);
>  
> +	insert_vmap_area_with_lock(va);
> +
>
>  	/*
>  	 * Mark pages for non-VM_ALLOC mappings as accessible. Do it now as a
>  	 * best-effort approach, as they can be mapped outside of vmalloc code.
> @@ -4166,7 +4172,7 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
>  	for (area = 0; area < nr_vms; area++) {
>  		insert_vmap_area(vas[area], &vmap_area_root, &vmap_area_list);
>  
> -		setup_vmalloc_vm_locked(vms[area], vas[area], VM_ALLOC,
> +		setup_vmalloc_vm(vms[area], vas[area], VM_ALLOC,
>  				 pcpu_get_vm_areas);
>  	}
>  	spin_unlock(&vmap_area_lock);
> 
> base-commit: b401b621758e46812da61fa58a67c3fd8d91de0d
> -- 
> 2.43.0
> 
Spreading the insert_vmap_area_lock() across several callers, like:
__get_vm_area_node(), new_vmap_block(), vm_map_ram(), etc is not good
approach, simply because it changes the behaviour and people might
miss this point.

Could you please re-spin it on the mm-unstable, because the vmalloc
code was changes a lot? From my side i can check and help you how to
fix it in a better way. Because the v3 should be improved anyaway.

Apparently i have not seen you messages for some reason, i do not
understand why. I started to get emails with below topic:

"Bounce probe for linux-kernel@vger.kernel.org (no action required)"

--
Uladzislau Rezki

