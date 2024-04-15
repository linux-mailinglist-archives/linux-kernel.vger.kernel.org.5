Return-Path: <linux-kernel+bounces-145458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F4D8A5660
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 253E41C20843
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896FD78C76;
	Mon, 15 Apr 2024 15:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ApDGQwSj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C745376046;
	Mon, 15 Apr 2024 15:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713194882; cv=none; b=JscChGA/DHzCV4KqDqNw2LrXHxU6CeYf/zS3RyknFCkc/bgrimNEWde99y3w894/jXjjZJuDcp1P1B3oxNc47ol5cjB5K5Qbpgo1ke4Kl/gnBFGlkz6yVusTu/puoWmC9omeT+j0/ks+6PPWzxjCf9iMT7MZazmOO7hF/MzOJ4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713194882; c=relaxed/simple;
	bh=nFuB/EilR2fRv26CVIwpUuMAO5By/98lEvVtc9MltxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GuJLsM5hKMdua+TTSQtM3I3OhGDNqX9fiDvaZsKE7pYN2IZQVyKCa3Eyx/XWVn/NIA8bg61PMLm2AYYMs1kBDN/nUrh3qWTVbJL3Cce3iGFgcaskf8wvUlIrZMgkOK6soIXz7+ULj5NnEawxKm5Mx4bLl/ib0vR5y8ibhn31ZTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ApDGQwSj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 005C3C113CC;
	Mon, 15 Apr 2024 15:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713194882;
	bh=nFuB/EilR2fRv26CVIwpUuMAO5By/98lEvVtc9MltxQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ApDGQwSjGww+QFx/JBUZURMz/Z1g46KopFEuqYSkG/6mW733e/JV5rw0ppa96w8k+
	 5K3DEoHy5Nh8mzFflu3oHifBaPSZuhTJ3rOP+7phlyRQ42DT+b5GanLkYcylCh8R/M
	 bgLlUeuXJUoDxotpr2xf+0v3ihJ22S8BmYO1IMP2mrQTrwQv6aO8OSmVjpKe/RPjZ9
	 eHyBwZnTw/59ZxKY4SpdSrYdQRwoj18HWH5CO/vkgPqZNDWXR0vDhnIBzNszH7OxLh
	 RYeAStgPx9oGW6OgJE1jjUHygivzNCoXPbiA8S5eDAZQaYZ25lB2BfEA6RmSuoEvLg
	 rnWOwXS8JBDAw==
Date: Mon, 15 Apr 2024 18:26:55 +0300
From: Mike Rapoport <rppt@kernel.org>
To: skseofh@gmail.com
Cc: robh@kernel.org, saravanak@google.com, akpm@linux-foundation.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Daero Lee <daero_le.lee@samsung.com>
Subject: Re: [PATCH] memblock: add no-map alloc functions
Message-ID: <Zh1HP8IWWjexAUKN@kernel.org>
References: <20240415142448.333271-1-skseofh@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415142448.333271-1-skseofh@gmail.com>

On Mon, Apr 15, 2024 at 11:24:48PM +0900, skseofh@gmail.com wrote:
> From: Daero Lee <daero_le.lee@samsung.com>
> 
> Like reserved-memory with the no-map property, there are memory regions
> need to be allocated in memblock.memory marked with the
> MEMBLOCK_NOMAP flag, but sholud not be allocated in memblock.reserved.

Can you please explain your use case?
Why do you need this functionality?
 
> So, functions were added that find the required memory area in
> memblock.memory, but do not allocate it to memblock.reserved.
> 
> The early_init_dt_alloc_reserved_memory_arch function was modified
> using the no-map alloc function.
> 
> Signed-off-by: Daero Lee <daero_le.lee@samsung.com>
> ---
>  drivers/of/of_reserved_mem.c |  9 +++--
>  mm/memblock.c                | 78 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 84 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
> index 8236ecae2953..504f2f60689c 100644
> --- a/drivers/of/of_reserved_mem.c
> +++ b/drivers/of/of_reserved_mem.c
> @@ -40,15 +40,18 @@ static int __init early_init_dt_alloc_reserved_memory_arch(phys_addr_t size,
>  
>  	end = !end ? MEMBLOCK_ALLOC_ANYWHERE : end;
>  	align = !align ? SMP_CACHE_BYTES : align;
> -	base = memblock_phys_alloc_range(size, align, start, end);
> +	if (nomap) {
> +		base = memblock_phys_alloc_range_nomap(size, align, start, end);
> +	} else {
> +		base = memblock_phys_alloc_range(size, align, start, end);
> +	}
> +	

This changes behaviour of internal function, what effect will it have on
the users?

>  	if (!base)
>  		return -ENOMEM;
>  
>  	*res_base = base;
>  	if (nomap) {
>  		err = memblock_mark_nomap(base, size);
> -		if (err)
> -			memblock_phys_free(base, size);
>  	}
>  
>  	kmemleak_ignore_phys(base);

-- 
Sincerely yours,
Mike.

