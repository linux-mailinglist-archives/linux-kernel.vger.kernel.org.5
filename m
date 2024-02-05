Return-Path: <linux-kernel+bounces-53087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B64E84A080
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F39621F20DD3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC92A481B5;
	Mon,  5 Feb 2024 17:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3tJEZ1J"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BC640BF4
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 17:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707153654; cv=none; b=fuaXSAOoCcv2VPRUheNDzCHMK8mPWRU3aHrXS7ehkWYKFXEIrDAbGwwTtwe1HdBZlx2PENGwfY7WxAnrIK0XPWRX5Q/yMAQns/6oMPMJDrMyfPshIrWJXJTc42Hmz8hObw0b1jBlwKN30XRyduDSD3j5L4+FrKjh1ibTNwio0vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707153654; c=relaxed/simple;
	bh=xhPLxXIzC51auq7hQp+cgbgYYKK067ZfNuJFRMEPjiI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dNu731UAwL3ghvNKPri3q/BJvDARscb4weoe5rDregjLQAMr74OHMS8ZILj+FejfhPL27GfEx4Lc2+8lY2rBRDmrvKT1MtYodt1ECeZrgJRYsNnsdeE3Av5HFToQjmtH5CVj2Z14XSzTRR9gNTTkCaScIohMt0aDFsqR3BTrffE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D3tJEZ1J; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-51109060d6aso6573163e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 09:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707153644; x=1707758444; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aG4tUT3lHaMLFEjxeD8AYZy4cfDkV2X5VzQR/NYYshw=;
        b=D3tJEZ1JY38tmBhLiwUqrF4gKuXbDx3956SzcX95zx10adnkEwzg8oZoWdEn6W3qd/
         Mkn7hUdbRI5JCr+JMyxhGLUPUaHTth1Ap8NQxq9gtI1gIuBK6g08Jk0dCdW/qRwCMLDB
         Asxzi2U0vAkyBGFWhIkOd7zQHNLcw5EQrJ5AFqqeWQqMvzdlWmEvJkJw6RylkPcggD+O
         TiPVjoo7O7wBnE3Wsr86dUifjVTekMhKaKVqOWzFKHX23U3O0J3cefU5JprlgwWzzMW0
         tDf5YGOwPAODF6b82p8+/72DRwJAE0DkVML5rRdg1+Ssuiji4rpPBuRA0abN6PXen3d3
         7sAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707153644; x=1707758444;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aG4tUT3lHaMLFEjxeD8AYZy4cfDkV2X5VzQR/NYYshw=;
        b=llZA4c+no8M/6TAvKbPnc9DgoDA9FTpHtO4LxxsWOCTgoWNCPWV6ObvupOM6mEj+9P
         z3r97CeVCcSKLU0ox2XnERZ9E1fERSP5zMYUwd0+6ersjiVWzP9W2DrtBYI8IfsqXos7
         6s2hC8tFBvUg9m29kZ+7BzM840e04LEnd52hsUXEs9jFttx7+uNfsGUtH796WOsSGdDW
         kP2Hf2+cztMhUhaj+dctLu6HgyrspIp8H6dVU9eBdmmROP1LGxsvrH9RvPq8koayGMrU
         h9PNp/ea/RIAvQgFnYd9fWHI2o4awUscZcLCuPgypGbJmaz9NBdxXsihFulArYZN253N
         1Eog==
X-Gm-Message-State: AOJu0Yz5gjbloAqSwQn3rSS3fYogKqmFhQHMW8LacX5QH3/rpGvEGiIk
	LT1N1bTu1wPXzwjJS3LK+RzZCgXzOul2qhe5DjXioCHU8xl/ckQL
X-Google-Smtp-Source: AGHT+IHBfuTpMKunVkbNFq+t0Jlc+3UenKYMKydVkNh0nKnDorXd0XPWQrbcuKoVCBcbIveTCL2fNA==
X-Received: by 2002:a05:6512:32a9:b0:511:4f00:45b2 with SMTP id q9-20020a05651232a900b005114f0045b2mr177437lfe.25.1707153644019;
        Mon, 05 Feb 2024 09:20:44 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUCTBkSmuKMbc/++9kbkskzZcICPaSQR3u3/T/Z8Z4ztlu33Rrd7Z1XYXEj4Zw7DBkp5kOt0yiWQCtENFkEVBFpu8clhvYD2ZFB3MFO02232yoQ+x0PRRygI1J+pK72nv1K6vwn17rJSbVVakq2KEmN9fYjrX/kIp2OsSsJEeXVsJeCd1BmHQP4jV824KTi8BwwO3nEwhVBYGfVgKVab5LpIWcdPs7JznvV2mcxXYnynPbRI+QnoWK+DhTJy+8VCB9TLFziR+C3PYwVNLoAmIQ48L8Zh2kMryIfhaulo0Ig2NjepA4hNA==
Received: from pc636 (host-90-233-221-0.mobileonline.telia.com. [90.233.221.0])
        by smtp.gmail.com with ESMTPSA id b10-20020ac2410a000000b0051157349af3sm13348lfi.47.2024.02.05.09.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 09:20:43 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Mon, 5 Feb 2024 18:20:41 +0100
To: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
	Christoph Hellwig <hch@infradead.org>,
	Matthew Wilcox <willy@infradead.org>,
	Dave Chinner <david@fromorbit.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 1/1] mm: vmalloc: Add a scan area of VA only once
Message-ID: <ZcEY6b86OijLi9Cz@pc636>
References: <20240202190628.47806-1-urezki@gmail.com>
 <dd3ce359-1caf-4eaf-8464-ec17284487a3@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd3ce359-1caf-4eaf-8464-ec17284487a3@lucifer.local>

On Sun, Feb 04, 2024 at 07:44:55PM +0000, Lorenzo Stoakes wrote:
> On Fri, Feb 02, 2024 at 08:06:28PM +0100, Uladzislau Rezki (Sony) wrote:
> > Invoke a kmemleak_scan_area() function only for newly allocated
> > objects to add a scan area within that object. There is no reason
> > to add a same scan area(pointer to beginning or inside the object)
> > several times. If a VA is obtained from the cache its scan area
> > has already been associated.
> >
> > Fixes: 7db166b4aa0d ("mm: vmalloc: offload free_vmap_area_lock lock")
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > ---
> >  mm/vmalloc.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index 449f45b0e474..25a8df497255 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -1882,13 +1882,13 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
> >  		va = kmem_cache_alloc_node(vmap_area_cachep, gfp_mask, node);
> >  		if (unlikely(!va))
> >  			return ERR_PTR(-ENOMEM);
> > -	}
> >
> > -	/*
> > -	 * Only scan the relevant parts containing pointers to other objects
> > -	 * to avoid false negatives.
> > -	 */
> > -	kmemleak_scan_area(&va->rb_node, SIZE_MAX, gfp_mask);
> > +		/*
> > +		 * Only scan the relevant parts containing pointers to other objects
> > +		 * to avoid false negatives.
> > +		 */
> > +		kmemleak_scan_area(&va->rb_node, SIZE_MAX, gfp_mask);
> > +	}
> >
> >  retry:
> >  	if (addr == vend) {
> > --
> > 2.39.2
> >
> 
> Looks good to me, feel free to add:
> 
> Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
>
Appreciate for review!

--
Uladzislau Rezki

