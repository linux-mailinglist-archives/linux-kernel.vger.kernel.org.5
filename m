Return-Path: <linux-kernel+bounces-94455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69478874012
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 20:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C6F31C224C0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 19:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08FD613E7DB;
	Wed,  6 Mar 2024 19:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zb8jeRTH"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4355FDCC
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 19:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709751719; cv=none; b=aiK5cNWBn/09X1KG8MuVkIeaA12/01iIOvTb805w7EOeTJrqBwF93q08GvC3d14mnHMhQ99zXcqOXHgffeL9PYCtJzFa91TOuFUDVjMomnPHREaYsPqjDCVanZ9ckPCXRQZsutwAbnsPOXCsPVc/PGN2IVVTBaziY4VcDyhqZOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709751719; c=relaxed/simple;
	bh=1CvuSh3UbOC7Ywz8/5x0nZJ2sxbykZI/4NwPSsPEYI4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LxUK03XxsH+NRdCZvwDOEASU/zJSEg7y8zilQdbCYKAIvbwmp+5VvqbeFKERWvRnfGBxJQOrmilRQYxSyOq0qn//w4n6dUlCRDKLl5bSue1HzkPllNTNTGrQPprKAsjoSfDU8ASglafmNt8L4iSFpCXUpNlZzBOADbSmcmHHcz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zb8jeRTH; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5134f830488so18409e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 11:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709751715; x=1710356515; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1DzzN/+Bl7F0FgkUNIWenV+wkEKVb5/vjtwB59oUvlM=;
        b=Zb8jeRTHT52v7jZiDop+YX56lfveRyvB3C+NDSyDrbej86oze4XJt1DNdN8oKdhM++
         0hFeuNTcZ3OxxUdfTjdjDzukm3PIjl7rQTI6h0FxYIjkyJuvnxVtvc9Gw4w8wGH4HBfA
         fR30kK8/AcVsPWxUQECGL51llnnc6Klfo3zR9eTu2nsxecC9jz0nwtYl16lfkcuBtdJi
         PlzCHT8X3NhUlVPjod4ljIHZKdzT2oL0RmN7q3PyXWIOWjdS+yIDCHMbtmvRaFzWrnV3
         cbfX4ZJwv5x55YX8WCL5BB5AKfButHD1Gq9e22ZxHVcOZDfWWVo2/JSdvD4zIPNcX506
         iFIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709751715; x=1710356515;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1DzzN/+Bl7F0FgkUNIWenV+wkEKVb5/vjtwB59oUvlM=;
        b=Vau838eBytGmLLgisg+4lYGvqTsYwdePslXClaw8d3hyCpczDU0eMDsVVE0n+ozAMQ
         1baKK+GSa5M19m+UMVciFVqLDEQBrxqnv8iQDDtMbe8EumfS6hZuUfAh0/V86uKK+ptH
         lsKDfFpfhQvQ2eb1EoeTZXUrDWuQ9//XGDPBc9ZlvY+z9vdC8m4e5kEY4jSkdVRHwCrW
         NiuHobNBl6DblcIDaHPlqAhM3PimJSStJtPZ686de7dFRtsNuJwnZ7Ajk3KdhBvyI35E
         WvB22IYu9S//i5WydS4dNRQ+Pigz9xeFkLT2EgFT8sxK3NnkzgyLssCP2HNj0f0p37Ye
         AhjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFM90crx4yqYHFB0TxB0W+1cDV5I0shBhBOGvo3w6NjiEYS/sG8HQKz4w0lNzdBqQXyYiOmR+TGQ1l8CBWpnLFfJP2l1HRKPNPwzgD
X-Gm-Message-State: AOJu0YyaiodtBmSE0cw/Xu6Qo6zpt3pQd86NpKfuk379RvF12VWPUTkv
	kDfdeneAFcAgv8j1RZc2JCZNVAiREXGinDmk9OqrNjqdy2D+jqpURRwO9UcUca4=
X-Google-Smtp-Source: AGHT+IHqjfr3rLF8+moPk8plkK0aVWvITPbCAgYR3U3rANvK3Y8nSvNheIi6e/5q5c1oduqCLPaZZw==
X-Received: by 2002:a05:6512:e81:b0:513:341a:91ca with SMTP id bi1-20020a0565120e8100b00513341a91camr4280778lfb.63.1709751714464;
        Wed, 06 Mar 2024 11:01:54 -0800 (PST)
Received: from pc636 (host-90-235-19-15.mobileonline.telia.com. [90.235.19.15])
        by smtp.gmail.com with ESMTPSA id x11-20020a19e00b000000b005133b381a5csm2046730lfg.90.2024.03.06.11.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 11:01:54 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Wed, 6 Mar 2024 20:01:51 +0100
To: rulinhuang <rulin.huang@intel.com>
Cc: urezki@gmail.com, bhe@redhat.com, akpm@linux-foundation.org,
	colin.king@intel.com, hch@infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	lstoakes@gmail.com, tianyou.li@intel.com, tim.c.chen@intel.com,
	wangyang.guo@intel.com, zhiguo.zhou@intel.com
Subject: Re: [PATCH v7 1/2] mm/vmalloc: Moved macros with no functional
 change happened
Message-ID: <Zei9n-VMxtzG8z4Y@pc636>
References: <20240301155417.1852290-1-rulin.huang@intel.com>
 <20240301155417.1852290-2-rulin.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301155417.1852290-2-rulin.huang@intel.com>

On Fri, Mar 01, 2024 at 10:54:16AM -0500, rulinhuang wrote:
> Moved data structures and basic helpers related to per cpu kva allocator
> up too to along with these macros with no functional change happened.
> 
> Signed-off-by: rulinhuang <rulin.huang@intel.com>
> ---
> V6 -> V7: Adjusted the macros
> ---
>  mm/vmalloc.c | 262 +++++++++++++++++++++++++--------------------------
>  1 file changed, 131 insertions(+), 131 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 25a8df497255..fc027a61c12e 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -887,6 +887,137 @@ is_vn_id_valid(unsigned int node_id)
>  	return false;
>  }
>  
> +/*
> + * vmap space is limited especially on 32 bit architectures. Ensure there is
> + * room for at least 16 percpu vmap blocks per CPU.
> + */
> +/*
> + * If we had a constant VMALLOC_START and VMALLOC_END, we'd like to be able
> + * to #define VMALLOC_SPACE		(VMALLOC_END-VMALLOC_START). Guess
> + * instead (we just need a rough idea)
> + */
> +#if BITS_PER_LONG == 32
> +#define VMALLOC_SPACE		(128UL*1024*1024)
> +#else
> +#define VMALLOC_SPACE		(128UL*1024*1024*1024)
> +#endif
> +
> +#define VMALLOC_PAGES		(VMALLOC_SPACE / PAGE_SIZE)
> +#define VMAP_MAX_ALLOC		BITS_PER_LONG	/* 256K with 4K pages */
> +#define VMAP_BBMAP_BITS_MAX	1024	/* 4MB with 4K pages */
> +#define VMAP_BBMAP_BITS_MIN	(VMAP_MAX_ALLOC*2)
> +#define VMAP_MIN(x, y)		((x) < (y) ? (x) : (y)) /* can't use min() */
> +#define VMAP_MAX(x, y)		((x) > (y) ? (x) : (y)) /* can't use max() */
> +#define VMAP_BBMAP_BITS		\
> +		VMAP_MIN(VMAP_BBMAP_BITS_MAX,	\
> +		VMAP_MAX(VMAP_BBMAP_BITS_MIN,	\
> +			VMALLOC_PAGES / roundup_pow_of_two(NR_CPUS) / 16))
> +
> +#define VMAP_BLOCK_SIZE		(VMAP_BBMAP_BITS * PAGE_SIZE)
> +
> +/*
> + * Purge threshold to prevent overeager purging of fragmented blocks for
> + * regular operations: Purge if vb->free is less than 1/4 of the capacity.
> + */
> +#define VMAP_PURGE_THRESHOLD	(VMAP_BBMAP_BITS / 4)
> +
> +#define VMAP_RAM		0x1 /* indicates vm_map_ram area*/
> +#define VMAP_BLOCK		0x2 /* mark out the vmap_block sub-type*/
> +#define VMAP_FLAGS_MASK		0x3
> +
> +struct vmap_block_queue {
> +	spinlock_t lock;
> +	struct list_head free;
> +
> +	/*
> +	 * An xarray requires an extra memory dynamically to
> +	 * be allocated. If it is an issue, we can use rb-tree
> +	 * instead.
> +	 */
> +	struct xarray vmap_blocks;
> +};
> +
> +struct vmap_block {
> +	spinlock_t lock;
> +	struct vmap_area *va;
> +	unsigned long free, dirty;
> +	DECLARE_BITMAP(used_map, VMAP_BBMAP_BITS);
> +	unsigned long dirty_min, dirty_max; /*< dirty range */
> +	struct list_head free_list;
> +	struct rcu_head rcu_head;
> +	struct list_head purge;
> +};
> +
> +/* Queue of free and dirty vmap blocks, for allocation and flushing purposes */
> +static DEFINE_PER_CPU(struct vmap_block_queue, vmap_block_queue);
> +
> +/*
> + * In order to fast access to any "vmap_block" associated with a
> + * specific address, we use a hash.
> + *
> + * A per-cpu vmap_block_queue is used in both ways, to serialize
> + * an access to free block chains among CPUs(alloc path) and it
> + * also acts as a vmap_block hash(alloc/free paths). It means we
> + * overload it, since we already have the per-cpu array which is
> + * used as a hash table. When used as a hash a 'cpu' passed to
> + * per_cpu() is not actually a CPU but rather a hash index.
> + *
> + * A hash function is addr_to_vb_xa() which hashes any address
> + * to a specific index(in a hash) it belongs to. This then uses a
> + * per_cpu() macro to access an array with generated index.
> + *
> + * An example:
> + *
> + *  CPU_1  CPU_2  CPU_0
> + *    |      |      |
> + *    V      V      V
> + * 0     10     20     30     40     50     60
> + * |------|------|------|------|------|------|...<vmap address space>
> + *   CPU0   CPU1   CPU2   CPU0   CPU1   CPU2
> + *
> + * - CPU_1 invokes vm_unmap_ram(6), 6 belongs to CPU0 zone, thus
> + *   it access: CPU0/INDEX0 -> vmap_blocks -> xa_lock;
> + *
> + * - CPU_2 invokes vm_unmap_ram(11), 11 belongs to CPU1 zone, thus
> + *   it access: CPU1/INDEX1 -> vmap_blocks -> xa_lock;
> + *
> + * - CPU_0 invokes vm_unmap_ram(20), 20 belongs to CPU2 zone, thus
> + *   it access: CPU2/INDEX2 -> vmap_blocks -> xa_lock.
> + *
> + * This technique almost always avoids lock contention on insert/remove,
> + * however xarray spinlocks protect against any contention that remains.
> + */
> +static struct xarray *
> +addr_to_vb_xa(unsigned long addr)
> +{
> +	int index = (addr / VMAP_BLOCK_SIZE) % num_possible_cpus();
> +
> +	return &per_cpu(vmap_block_queue, index).vmap_blocks;
> +}
> +
> +/*
> + * We should probably have a fallback mechanism to allocate virtual memory
> + * out of partially filled vmap blocks. However vmap block sizing should be
> + * fairly reasonable according to the vmalloc size, so it shouldn't be a
> + * big problem.
> + */
> +
> +static unsigned long addr_to_vb_idx(unsigned long addr)
> +{
> +	addr -= VMALLOC_START & ~(VMAP_BLOCK_SIZE-1);
> +	addr /= VMAP_BLOCK_SIZE;
> +	return addr;
> +}
> +
> +static void *vmap_block_vaddr(unsigned long va_start, unsigned long pages_off)
> +{
> +	unsigned long addr;
> +
> +	addr = va_start + (pages_off << PAGE_SHIFT);
> +	BUG_ON(addr_to_vb_idx(addr) != addr_to_vb_idx(va_start));
> +	return (void *)addr;
> +}
> +
>  static __always_inline unsigned long
>  va_size(struct vmap_area *va)
>  {
> @@ -2327,137 +2458,6 @@ static struct vmap_area *find_unlink_vmap_area(unsigned long addr)
>  
>  /*** Per cpu kva allocator ***/
>  
> -/*
> - * vmap space is limited especially on 32 bit architectures. Ensure there is
> - * room for at least 16 percpu vmap blocks per CPU.
> - */
> -/*
> - * If we had a constant VMALLOC_START and VMALLOC_END, we'd like to be able
> - * to #define VMALLOC_SPACE		(VMALLOC_END-VMALLOC_START). Guess
> - * instead (we just need a rough idea)
> - */
> -#if BITS_PER_LONG == 32
> -#define VMALLOC_SPACE		(128UL*1024*1024)
> -#else
> -#define VMALLOC_SPACE		(128UL*1024*1024*1024)
> -#endif
> -
> -#define VMALLOC_PAGES		(VMALLOC_SPACE / PAGE_SIZE)
> -#define VMAP_MAX_ALLOC		BITS_PER_LONG	/* 256K with 4K pages */
> -#define VMAP_BBMAP_BITS_MAX	1024	/* 4MB with 4K pages */
> -#define VMAP_BBMAP_BITS_MIN	(VMAP_MAX_ALLOC*2)
> -#define VMAP_MIN(x, y)		((x) < (y) ? (x) : (y)) /* can't use min() */
> -#define VMAP_MAX(x, y)		((x) > (y) ? (x) : (y)) /* can't use max() */
> -#define VMAP_BBMAP_BITS		\
> -		VMAP_MIN(VMAP_BBMAP_BITS_MAX,	\
> -		VMAP_MAX(VMAP_BBMAP_BITS_MIN,	\
> -			VMALLOC_PAGES / roundup_pow_of_two(NR_CPUS) / 16))
> -
> -#define VMAP_BLOCK_SIZE		(VMAP_BBMAP_BITS * PAGE_SIZE)
> -
> -/*
> - * Purge threshold to prevent overeager purging of fragmented blocks for
> - * regular operations: Purge if vb->free is less than 1/4 of the capacity.
> - */
> -#define VMAP_PURGE_THRESHOLD	(VMAP_BBMAP_BITS / 4)
> -
> -#define VMAP_RAM		0x1 /* indicates vm_map_ram area*/
> -#define VMAP_BLOCK		0x2 /* mark out the vmap_block sub-type*/
> -#define VMAP_FLAGS_MASK		0x3
> -
> -struct vmap_block_queue {
> -	spinlock_t lock;
> -	struct list_head free;
> -
> -	/*
> -	 * An xarray requires an extra memory dynamically to
> -	 * be allocated. If it is an issue, we can use rb-tree
> -	 * instead.
> -	 */
> -	struct xarray vmap_blocks;
> -};
> -
> -struct vmap_block {
> -	spinlock_t lock;
> -	struct vmap_area *va;
> -	unsigned long free, dirty;
> -	DECLARE_BITMAP(used_map, VMAP_BBMAP_BITS);
> -	unsigned long dirty_min, dirty_max; /*< dirty range */
> -	struct list_head free_list;
> -	struct rcu_head rcu_head;
> -	struct list_head purge;
> -};
> -
> -/* Queue of free and dirty vmap blocks, for allocation and flushing purposes */
> -static DEFINE_PER_CPU(struct vmap_block_queue, vmap_block_queue);
> -
> -/*
> - * In order to fast access to any "vmap_block" associated with a
> - * specific address, we use a hash.
> - *
> - * A per-cpu vmap_block_queue is used in both ways, to serialize
> - * an access to free block chains among CPUs(alloc path) and it
> - * also acts as a vmap_block hash(alloc/free paths). It means we
> - * overload it, since we already have the per-cpu array which is
> - * used as a hash table. When used as a hash a 'cpu' passed to
> - * per_cpu() is not actually a CPU but rather a hash index.
> - *
> - * A hash function is addr_to_vb_xa() which hashes any address
> - * to a specific index(in a hash) it belongs to. This then uses a
> - * per_cpu() macro to access an array with generated index.
> - *
> - * An example:
> - *
> - *  CPU_1  CPU_2  CPU_0
> - *    |      |      |
> - *    V      V      V
> - * 0     10     20     30     40     50     60
> - * |------|------|------|------|------|------|...<vmap address space>
> - *   CPU0   CPU1   CPU2   CPU0   CPU1   CPU2
> - *
> - * - CPU_1 invokes vm_unmap_ram(6), 6 belongs to CPU0 zone, thus
> - *   it access: CPU0/INDEX0 -> vmap_blocks -> xa_lock;
> - *
> - * - CPU_2 invokes vm_unmap_ram(11), 11 belongs to CPU1 zone, thus
> - *   it access: CPU1/INDEX1 -> vmap_blocks -> xa_lock;
> - *
> - * - CPU_0 invokes vm_unmap_ram(20), 20 belongs to CPU2 zone, thus
> - *   it access: CPU2/INDEX2 -> vmap_blocks -> xa_lock.
> - *
> - * This technique almost always avoids lock contention on insert/remove,
> - * however xarray spinlocks protect against any contention that remains.
> - */
> -static struct xarray *
> -addr_to_vb_xa(unsigned long addr)
> -{
> -	int index = (addr / VMAP_BLOCK_SIZE) % num_possible_cpus();
> -
> -	return &per_cpu(vmap_block_queue, index).vmap_blocks;
> -}
> -
> -/*
> - * We should probably have a fallback mechanism to allocate virtual memory
> - * out of partially filled vmap blocks. However vmap block sizing should be
> - * fairly reasonable according to the vmalloc size, so it shouldn't be a
> - * big problem.
> - */
> -
> -static unsigned long addr_to_vb_idx(unsigned long addr)
> -{
> -	addr -= VMALLOC_START & ~(VMAP_BLOCK_SIZE-1);
> -	addr /= VMAP_BLOCK_SIZE;
> -	return addr;
> -}
> -
> -static void *vmap_block_vaddr(unsigned long va_start, unsigned long pages_off)
> -{
> -	unsigned long addr;
> -
> -	addr = va_start + (pages_off << PAGE_SHIFT);
> -	BUG_ON(addr_to_vb_idx(addr) != addr_to_vb_idx(va_start));
> -	return (void *)addr;
> -}
> -
>  /**
>   * new_vmap_block - allocates new vmap_block and occupies 2^order pages in this
>   *                  block. Of course pages number can't exceed VMAP_BBMAP_BITS
> -- 
> 2.43.0
> 

Sorry for the late answer, i also just noticed this email. It was not in
my inbox...

OK, now you move part of the per-cpu allocator on the top and leave
another part down making it split. This is just for the:

BUG_ON(va_flags & VMAP_RAM);

VMAP_RAM macro. Do we really need this BUG_ON()?

--
Uladzislau Rezki

