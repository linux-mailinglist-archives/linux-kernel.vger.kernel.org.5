Return-Path: <linux-kernel+bounces-51859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C313E849025
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 20:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FBD428424A
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 19:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35DAE25568;
	Sun,  4 Feb 2024 19:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HqRbpNgg"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB3A2555B
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 19:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707076033; cv=none; b=VcU9Iw96UODfh3CKOtyM2wgWtTVZui8qyMYHR8PBeJJQxWrVIDvUIlSFb3NffpmcRfZyuwOCPYRgOMjMRstGHYi5KZ/Yk6ooUi1aDVRd13xwQLLlBOQUhzyD8xeqG9KVqajwoXhn6fdFTrH0eUxFRZ9QX2qJyV5Hy0J9D/Qz6yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707076033; c=relaxed/simple;
	bh=dh5aUZbxgC6lmdPp6g0ZVDbzAffH5qeyfeOaJ86xRak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uy3yohkrbYmGHoz7GQIzJQoj+hrm/Tg9wUFY4XqglMe7Rt+0/YPhtUriZ5wuw1UjNR0+D/RAiDnYzV9eme6bOGCxIjRG472RcSmyrORnsYeomcpgUC8VBYsQEZhNaMcrmsv6oFsuZKpuvpB0wcotqmYAxnxxNC12ZsPjSRSb5ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HqRbpNgg; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40fd72f721dso5524755e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 11:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707076030; x=1707680830; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5xfuEOvNkpMrvgeaTj0gZfx3Z6HaCNzQxxz5WJ1g3Tk=;
        b=HqRbpNggDQMqf9g5C8RnkDXNCuFKYLaYLqZ1KohrLT8vURFRgFt4rm3IXxAGemz7Rl
         NVZG3/oOQM35m3YgBaV8F1xN0+DJiN0BGA1bkBwNn8FXEQpIWKBTMmU2We86Ww80tnVV
         09UmtR7BFdpGSIDeVBo6n5Is9IacfIXTyQ37air2R6O3iOK7uHW0ArwUGgb/UsvsuzfW
         SmbScYgXtdhW1X8FeF9W3c2ga08jl2ayFZXVcHRQripqTdRPmx1JTWgjgXWX5UX/qIPG
         +aSAmTCi/gaVzaB9EpcPrKX3liYudvAiOUGwpZ32DizPwxzoo1w5/pCR3km742YZbfWc
         +T8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707076030; x=1707680830;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5xfuEOvNkpMrvgeaTj0gZfx3Z6HaCNzQxxz5WJ1g3Tk=;
        b=KBiybln18ZBSq97eU28rPwgtHPaaZPX5zuNA2ZSPH45HyJdNRgMUWhstgMcAKTtn1N
         HjBUi6v1/52SytMdp9Av5l2YUTJDB58r+0rL/hSTW1DiUfwNtG3+nS830XrqSgQnJd0P
         9oPwgv8FmPxKsQcDDQ47s/yVwZuC5xoBRZg6E376yKSHn442GT0dKpWcb6ODh2wLz1AA
         brB39KVyIu31OXSYJR1XxYnkyT43aJw+BI9AcZJ7nOa9o0MT6pV7uzHnGeY1Kej5qW1v
         66yPTHZYztmL0fs8bYOwy3nwjueBwk9ft+zTMLVM6GR5r8MsLIn0KTjEiSgJrsHt8nxe
         kGNQ==
X-Gm-Message-State: AOJu0YwhzwT/VqfWf1x1pCaATIJHDvsQuDngd9HGD5+SvyiEK9NIfs6F
	hraeaZgiLRvwl0FAY3lB9pC6l9hwN9JefCjn9AEd7zVi3x/vEmG6
X-Google-Smtp-Source: AGHT+IFJwMO115l0nbWMfn/jjOsvAs7jH6l/wfBwF/C6Y258tA8EmwObt6q49PLWRe6Gr0jvGe2hxA==
X-Received: by 2002:a05:600c:3585:b0:40f:c234:1fcc with SMTP id p5-20020a05600c358500b0040fc2341fccmr3034205wmq.29.1707076029788;
        Sun, 04 Feb 2024 11:47:09 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVWx8pZheC091wJB9SwKMVSGQhcbLv+vOnxpwSAwPWFBeOVfqwpVU5CORd/n6wfIYic/owsO/n4VC6E9yk2TkQyRXATn4YnveOM0auQskKUl+tZkijwTZCnMhUj0aGncXc5LcTzHRu8CHSupeux5MmX2TuOYypRQmTujGjCHkkdJ5VjO2zDcY3OiXZqdBDT6M8s8qEWsdPPq31DQsXRgclFohb7oMKRSfNwuVAaNmc+SxSu0RIUmZDvCUrdaaKZNHMPwCek81t3u7e7+Gx0k9+sL6w=
Received: from localhost (host109-150-53-182.range109-150.btcentralplus.com. [109.150.53.182])
        by smtp.gmail.com with ESMTPSA id p13-20020a05600c1d8d00b0040fb30f17e8sm6631270wms.38.2024.02.04.11.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 11:47:08 -0800 (PST)
Date: Sun, 4 Feb 2024 19:44:55 +0000
From: Lorenzo Stoakes <lstoakes@gmail.com>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
	Christoph Hellwig <hch@infradead.org>,
	Matthew Wilcox <willy@infradead.org>,
	Dave Chinner <david@fromorbit.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 1/1] mm: vmalloc: Add a scan area of VA only once
Message-ID: <dd3ce359-1caf-4eaf-8464-ec17284487a3@lucifer.local>
References: <20240202190628.47806-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202190628.47806-1-urezki@gmail.com>

On Fri, Feb 02, 2024 at 08:06:28PM +0100, Uladzislau Rezki (Sony) wrote:
> Invoke a kmemleak_scan_area() function only for newly allocated
> objects to add a scan area within that object. There is no reason
> to add a same scan area(pointer to beginning or inside the object)
> several times. If a VA is obtained from the cache its scan area
> has already been associated.
>
> Fixes: 7db166b4aa0d ("mm: vmalloc: offload free_vmap_area_lock lock")
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  mm/vmalloc.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 449f45b0e474..25a8df497255 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -1882,13 +1882,13 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
>  		va = kmem_cache_alloc_node(vmap_area_cachep, gfp_mask, node);
>  		if (unlikely(!va))
>  			return ERR_PTR(-ENOMEM);
> -	}
>
> -	/*
> -	 * Only scan the relevant parts containing pointers to other objects
> -	 * to avoid false negatives.
> -	 */
> -	kmemleak_scan_area(&va->rb_node, SIZE_MAX, gfp_mask);
> +		/*
> +		 * Only scan the relevant parts containing pointers to other objects
> +		 * to avoid false negatives.
> +		 */
> +		kmemleak_scan_area(&va->rb_node, SIZE_MAX, gfp_mask);
> +	}
>
>  retry:
>  	if (addr == vend) {
> --
> 2.39.2
>

Looks good to me, feel free to add:

Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>

