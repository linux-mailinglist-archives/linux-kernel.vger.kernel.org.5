Return-Path: <linux-kernel+bounces-56200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C54B84C743
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A09FD1C20FF8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658CB2232E;
	Wed,  7 Feb 2024 09:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lW83CmHE"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4467208C0
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 09:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707297907; cv=none; b=JmZAQfyPzWW2aHXHBTNu41vae2AD70xeZez387y6IZLi6gkdoRfLUEfOirueYv7arUX3dTxvfRxiZTHxyirUV9Age4SmGYsQCcXymIK+pTgYPN6d8yStF57VWb2A38diNbCdoKjW9rcCLjORjAGcedN7M93BO2u8lJrjJmh+WEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707297907; c=relaxed/simple;
	bh=Fw8Frb7+U9DGe5Skv7BA3WzQhx+B+3AcY4TLmDweILs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qlKV4P5IrcSWRhPkqTWfNGzfHZZTA2gKOc0cmK9SaEysimGMtVlQxfjT+uKUll4KR3Q7Laj4UxljVE+BVXQPajohR1Ktk5vs9kD0j+jSMub0uYmBQ3XXQVi3R0flCnmSutD8EpmPE1jr31SrcJ4YHhCEqUkqClnZPj8Mv5kEkAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lW83CmHE; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-51124e08565so587805e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 01:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707297904; x=1707902704; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yF3gre0TO7JfQnBIzArzEHplr6VLfvwUebv5ae+w5FA=;
        b=lW83CmHEMP5wed0Otpgt005UGhpWPLSjKMrCU/wZ/EtqvqqmqvC0upir2/YUX5xp0d
         Gmaa6dPUhlVBvcV1+H0N8owqSRcExgHoGyVZ7hsUHXLE13sYnfQY/upbFxt2jR5JwzPU
         yLSvCg9odY4cYLzULyeGyXIOQnXik4XCrZ+FDk4AoZaUK+263MarWa652fbu7sAsdY7c
         2Gh8jsGevshsllJ+HBjjKgDHmAWFtANK6KggdL19gjYmS8ixwkdd12iFBWA2io4Xv3KG
         MloKGCJf3SBrYR4vxfYJV5J1yfsjMpnJ3kjagNYbT/8k1+047MakMhZwkg1tvm+aJxyD
         C1Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707297904; x=1707902704;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yF3gre0TO7JfQnBIzArzEHplr6VLfvwUebv5ae+w5FA=;
        b=QJPug9pSQzDwbkKQHSj5o5X7rMsjSmEWe31v5kiwlMQmOm+V5BsZA8X4HpgsthCXQ5
         E3HDKF3MK0sY19NY18WENiaMOQGUlvuIL08JK9DZre1Cbg9lDI5XUW30drdihSinLnFk
         enYDsk8+gK6zBG98Cs3Uy3eYShvagxgL3d33xwPA4t1cIdPCcNhjSlVUfe4OLvQQXV8z
         S1ESDMNmxc16+wbWYvBw9wRYZzX73aOtmpsZrIpDq1O4KDJO6MLejgWroUPrg/nU0IxJ
         gPU78PPxJbDWkAby3kpGbBOUpOIZrO8NrdvgMrX96UFYlNB+gZDdUV9I7ZlqtyFDO8vz
         3YMA==
X-Forwarded-Encrypted: i=1; AJvYcCVV4oLcHL1RSeW2hOO99DHCHbD/UsxzTw6/Vq1Bv4AVHHDw6kQ3hxygsOWl7elTVGqMcNbmLYKcsn11PUp/RZS7AtQ5lq3SC8Yzka8c
X-Gm-Message-State: AOJu0Yzd5RC9I2LJO8XsrNKw0LdFoFamGNFBUBUfVLFwMH1lXlzbULhO
	MLFpYd6QAp9+IIj00tfLRfpIw0BM744T71Dl4GIjXD+K/ezeykGs
X-Google-Smtp-Source: AGHT+IETe2MT6aV7GlxmGa61KUBpsJJwTVyDPwgfxDI0q97DvvmY0jd3JR8xqGMzVNltAs4DYoW38Q==
X-Received: by 2002:a05:6512:32ab:b0:511:627e:36cd with SMTP id q11-20020a05651232ab00b00511627e36cdmr2301780lfe.24.1707297903277;
        Wed, 07 Feb 2024 01:25:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUO2/ik0M9x1I1dXAPi4GJLZX067x6AmN5+jfeNW8mb93T9FLwBavnsC4SuICQ7FxP2v8u5ber/z2+y+NxgSGmuUVKtorRXmnZp+zWXPiCBvlAmhL33m5E5i2bg7tTHr/exMC1btoVz0z3ZQ6NP7eBEQovE9cTjuq8C6FvNoVTj0FWmh+C7YTP16vC0eQKyq0YMmLKCAZhEAgaYkW3sFR+hd66REcbfTRO0DrT0/KrLFuaeqzt5U1rXIHxbA5D95bOjzdnc4AwIlQr6i/U34tTT9y9jn7FsX7Hj/C9e
Received: from pc636 (host-90-233-221-0.mobileonline.telia.com. [90.233.221.0])
        by smtp.gmail.com with ESMTPSA id j15-20020ac2550f000000b005114d74f9casm114756lfk.150.2024.02.07.01.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 01:25:02 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Wed, 7 Feb 2024 10:24:59 +0100
To: rulinhuang <rulin.huang@intel.com>
Cc: akpm@linux-foundation.org, urezki@gmail.com, hch@infradead.org,
	lstoakes@gmail.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, tim.c.chen@intel.com,
	colin.king@intel.com, zhiguo.zhou@intel.com
Subject: Re: [PATCH] mm/vmalloc: lock contention optimization under
 multi-threading
Message-ID: <ZcNMa-CFEDNWDO2J@pc636>
References: <20240207033059.1565623-1-rulin.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207033059.1565623-1-rulin.huang@intel.com>

On Tue, Feb 06, 2024 at 10:30:59PM -0500, rulinhuang wrote:
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
> Reviewed-by: "Chen, Tim C" <tim.c.chen@intel.com>
> Reviewed-by: "King, Colin" <colin.king@intel.com>
> Signed-off-by: rulinhuang <rulin.huang@intel.com>
> ---
>  mm/vmalloc.c | 31 +++++++++++++++----------------
>  1 file changed, 15 insertions(+), 16 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index d12a17fc0c171..3b1f616e8ecf0 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -1577,13 +1577,13 @@ preload_this_cpu_lock(spinlock_t *lock, gfp_t gfp_mask, int node)
>  
>  /*
>   * Allocate a region of KVA of the specified size and alignment, within the
> - * vstart and vend.
> + * vstart and vend. If vm is passed in, the two will also be bound.
>   */
>  static struct vmap_area *alloc_vmap_area(unsigned long size,
>  				unsigned long align,
>  				unsigned long vstart, unsigned long vend,
>  				int node, gfp_t gfp_mask,
> -				unsigned long va_flags)
> +				unsigned long va_flags, struct vm_struct *vm)
>  {
>  	struct vmap_area *va;
>  	unsigned long freed;
> @@ -1627,9 +1627,12 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
>  
>  	va->va_start = addr;
>  	va->va_end = addr + size;
> -	va->vm = NULL;
> +	va->vm = vm;
>  	va->flags = va_flags;
>  
> +	if (vm != NULL)
> +		vm->addr = (void *)addr;
> +
>  	spin_lock(&vmap_area_lock);
>  	insert_vmap_area(va, &vmap_area_root, &vmap_area_list);
>  	spin_unlock(&vmap_area_lock);
> @@ -2039,7 +2042,8 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
>  	va = alloc_vmap_area(VMAP_BLOCK_SIZE, VMAP_BLOCK_SIZE,
>  					VMALLOC_START, VMALLOC_END,
>  					node, gfp_mask,
> -					VMAP_RAM|VMAP_BLOCK);
> +					VMAP_RAM|VMAP_BLOCK,
> +					NULL);
>  	if (IS_ERR(va)) {
>  		kfree(vb);
>  		return ERR_CAST(va);
> @@ -2394,7 +2398,8 @@ void *vm_map_ram(struct page **pages, unsigned int count, int node)
>  		struct vmap_area *va;
>  		va = alloc_vmap_area(size, PAGE_SIZE,
>  				VMALLOC_START, VMALLOC_END,
> -				node, GFP_KERNEL, VMAP_RAM);
> +				node, GFP_KERNEL, VMAP_RAM,
> +				NULL);
>  		if (IS_ERR(va))
>  			return NULL;
>  
> @@ -2548,14 +2553,6 @@ static inline void setup_vmalloc_vm_locked(struct vm_struct *vm,
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
> @@ -2592,14 +2589,16 @@ static struct vm_struct *__get_vm_area_node(unsigned long size,
>  	if (!(flags & VM_NO_GUARD))
>  		size += PAGE_SIZE;
>  
> -	va = alloc_vmap_area(size, align, start, end, node, gfp_mask, 0);
> +	area->flags = flags;
> +	area->caller = caller;
> +	area->size = size;
> +
> +	va = alloc_vmap_area(size, align, start, end, node, gfp_mask, 0, area);
>  	if (IS_ERR(va)) {
>  		kfree(area);
>  		return NULL;
>  	}
>  
> -	setup_vmalloc_vm(area, va, flags, caller);
> -
>  	/*
>
Thank you for improving this! That was in my radar quite a long time ago :)

Some comments though. I think that such "partial" way of initializing of
"vm_struct" or "vm" is not optimal because it becomes spread between two
places.

Also, i think that we should not remove the setup_vmalloc_vm() function,
instead we can move it in a place where the VA is not inserted to the
tree, i.e. to initialize before insert.

The "locked" variant can be renamed to setup_vmalloc_vm(). 

Also, could you please post how you tested this patch and stress-ng
figures? This is really good for other people and folk to know.

Thanks!

--
Uladzislau Rezki

