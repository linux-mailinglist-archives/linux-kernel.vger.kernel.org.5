Return-Path: <linux-kernel+bounces-125727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83231892B3B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 13:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AFEFB22250
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 12:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4861EA74;
	Sat, 30 Mar 2024 12:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7Nwg4/V"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F64A1C0DE0
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 12:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711803336; cv=none; b=elZIta0E0jgw1th5FeN7l9mG0e1CkbUkuMzHb5iAjVuI6rJJZa1fIiYmttPgLzV+TuWrwvNSoHKZE5KK1o0H+DzIjhrTUmNFMaK05xtIYkJaeNe+yWmsUDKHNrnordjDIxrENFbVyCWexMlN6URV76R+supcrfF9IzBCOSB11GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711803336; c=relaxed/simple;
	bh=aiF/VX3qlCKtwHY7oEY5LhxYA4GvGZv/XClb3Er5KkI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bVVtswlsZluZfTFBfg5RPVXpIEQC8s4hhTKcXJMnSQoi2CDbpMaLHDpS6vY52bZqEtsBCwlvKdv633phtrdvmqYPcAznc7yoNBmp8fMRJx3V3NnB8jm2ZAt1RUGOf3ZAqrKuBr1fZZWZBbqQOU4Vi/ZXoVQAXDm06jydeBvlo8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R7Nwg4/V; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d6c220a377so31978231fa.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 05:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711803332; x=1712408132; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1m9ovnxUmO4jM14h7Q0jSZVXsOuJTF/qtN6BxjeYGvU=;
        b=R7Nwg4/V6na2fLngz2S5rB97oYaaz8xKxHJO+wKXn3kmyP5A9EqQEjoaCaPRsO2/dY
         b2E4I9AM6q9w65w8Jq1EhqpavJsJvICr/Xn3G/x7oCNgyoJzlRFsPicQb1lAWcWujpON
         Npfv2Nf41tJnHb2a9EWG/hICHxlun0Xck/fBQeXDtkZlQLfLh+GVi5CU2QpUCQdcSMzI
         l3lXGQnCZt1Wr7V6vdCjMhUSwsiezCo7cJM76G+tmal9LQf9FwUt7tM5WOiXW08qfhZB
         zCfU/CNr1bKpgIdSxiTWhXC4qHZbBintPULVI3eOROoWgn3cl1+8znnGEyA3VraK7teX
         Egqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711803332; x=1712408132;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1m9ovnxUmO4jM14h7Q0jSZVXsOuJTF/qtN6BxjeYGvU=;
        b=t1IHWVYlJSod24HWP8K1OLk5X+mvhXB3hd48uRKQF8EqGFJ7CQ4kDwOYzVPmusyCj+
         PeJgDO2ieBUr7UIkWgg0Q4PCByr66RcgRNnT96FxNzEOrlmS1TinRpY3TKH+A4BEKmzT
         ear7Yna+RFDuD4BKGxdbBjOSK+vmDz0FvfmfFBzJty7+xHVgMYhs6Vj6ew3lSdj1hJ1r
         rfnVeRfi8mk7e4uiVYNw11sEKfsEmKdrnqjI+uyYrKkmB1+1nenrFdOygM9oiqRgsxIk
         iNPup+qSZV4ipFeAnKqaDFvmJ/tkfVeMlUM5pEDPENYZIkf2Q0kXqGcJ+WUq+c+/G6Wk
         jlng==
X-Forwarded-Encrypted: i=1; AJvYcCVY2do8bAVkrC1JNAUln1Vl8z/ceZvKYMqX97CsWZqcm6T8DXrzrQ5GRbkOHzgB455jRleEO9sWCcJRUNMRFMIR7pR0UWBnYeZe2LIy
X-Gm-Message-State: AOJu0YzwFCPdIGx2vJcrN9dLavu5iA8A5rjaeCvfRNsWOvFMukxejA7j
	J+eUUrFpb2kICStY3S9P9sqpADstbksf9l1anhsN+k7lZS05jHQA
X-Google-Smtp-Source: AGHT+IElPPMcrF0eTA1Tziki8z1EtpiGvO6Hr2cCipUkj2rBlXzYWXvrEVMBrleMs8fkd3kc/SfWnA==
X-Received: by 2002:a2e:a176:0:b0:2d4:78ba:fa45 with SMTP id u22-20020a2ea176000000b002d478bafa45mr3423019ljl.2.1711803331820;
        Sat, 30 Mar 2024 05:55:31 -0700 (PDT)
Received: from pc636 (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id x20-20020a2ea994000000b002d435cdf2adsm879682ljq.111.2024.03.30.05.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Mar 2024 05:55:31 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Sat, 30 Mar 2024 13:55:29 +0100
To: Baoquan He <bhe@redhat.com>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Matthew Wilcox <willy@infradead.org>,
	Dave Chinner <david@fromorbit.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	Jens Axboe <axboe@kernel.dk>, Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH 1/1] mm: vmalloc: Fix lockdep warning
Message-ID: <ZggLwbnaeK0AsRwQ@pc636>
References: <20240328140330.4747-1-urezki@gmail.com>
 <ZgZxaOg6/qZAfUUA@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgZxaOg6/qZAfUUA@MiWiFi-R3L-srv>

On Fri, Mar 29, 2024 at 03:44:40PM +0800, Baoquan He wrote:
> On 03/28/24 at 03:03pm, Uladzislau Rezki (Sony) wrote:
> > A lockdep reports a possible deadlock in the find_vmap_area_exceed_addr_lock()
> > function:
> > 
> > ============================================
> > WARNING: possible recursive locking detected
> > 6.9.0-rc1-00060-ged3ccc57b108-dirty #6140 Not tainted
> > --------------------------------------------
> > drgn/455 is trying to acquire lock:
> > ffff0000c00131d0 (&vn->busy.lock/1){+.+.}-{2:2}, at: find_vmap_area_exceed_addr_lock+0x64/0x124
> > 
> > but task is already holding lock:
> > ffff0000c0011878 (&vn->busy.lock/1){+.+.}-{2:2}, at: find_vmap_area_exceed_addr_lock+0x64/0x124
> > 
> > other info that might help us debug this:
> >  Possible unsafe locking scenario:
> > 
> >        CPU0
> >        ----
> >   lock(&vn->busy.lock/1);
> >   lock(&vn->busy.lock/1);
> > 
> >  *** DEADLOCK ***
> > 
> > indeed it can happen if the find_vmap_area_exceed_addr_lock()
> > gets called concurrently because it tries to acquire two nodes
> > locks. It was done to prevent removing a lowest VA found on a
> > previous step.
> > 
> > To address this a lowest VA is found first without holding a
> > node lock where it resides. As a last step we check if a VA
> > still there because it can go away, if removed, proceed with
> > next lowest.
> > 
> > Fixes: 53becf32aec1 ("mm: vmalloc: support multiple nodes in vread_iter")
> > Tested-by: Jens Axboe <axboe@kernel.dk>
> > Tested-by: Omar Sandoval <osandov@fb.com>
> > Reported-by: Jens Axboe <axboe@kernel.dk>
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > ---
> >  mm/vmalloc.c | 74 +++++++++++++++++++++++++++++++---------------------
> >  1 file changed, 44 insertions(+), 30 deletions(-)
> > 
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index e94ce4562805..a5a5dfc3843e 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -989,6 +989,27 @@ unsigned long vmalloc_nr_pages(void)
> >  	return atomic_long_read(&nr_vmalloc_pages);
> >  }
> >  
> > +static struct vmap_area *__find_vmap_area(unsigned long addr, struct rb_root *root)
> > +{
> > +	struct rb_node *n = root->rb_node;
> > +
> > +	addr = (unsigned long)kasan_reset_tag((void *)addr);
> > +
> > +	while (n) {
> > +		struct vmap_area *va;
> > +
> > +		va = rb_entry(n, struct vmap_area, rb_node);
> > +		if (addr < va->va_start)
> > +			n = n->rb_left;
> > +		else if (addr >= va->va_end)
> > +			n = n->rb_right;
> > +		else
> > +			return va;
> > +	}
> > +
> > +	return NULL;
> > +}
> > +
> >  /* Look up the first VA which satisfies addr < va_end, NULL if none. */
> >  static struct vmap_area *
> >  __find_vmap_area_exceed_addr(unsigned long addr, struct rb_root *root)
> > @@ -1025,47 +1046,40 @@ __find_vmap_area_exceed_addr(unsigned long addr, struct rb_root *root)
> >  static struct vmap_node *
> >  find_vmap_area_exceed_addr_lock(unsigned long addr, struct vmap_area **va)
> >  {
> > -	struct vmap_node *vn, *va_node = NULL;
> > -	struct vmap_area *va_lowest;
> > +	unsigned long va_start_lowest;
> > +	struct vmap_node *vn;
> >  	int i;
> >  
> > -	for (i = 0; i < nr_vmap_nodes; i++) {
> > +repeat:
> > +	for (i = 0, va_start_lowest = 0; i < nr_vmap_nodes; i++) {
> >  		vn = &vmap_nodes[i];
> >  
> >  		spin_lock(&vn->busy.lock);
> > -		va_lowest = __find_vmap_area_exceed_addr(addr, &vn->busy.root);
> > -		if (va_lowest) {
> > -			if (!va_node || va_lowest->va_start < (*va)->va_start) {
> > -				if (va_node)
> > -					spin_unlock(&va_node->busy.lock);
> > -
> > -				*va = va_lowest;
> > -				va_node = vn;
> > -				continue;
> > -			}
> > -		}
> > +		*va = __find_vmap_area_exceed_addr(addr, &vn->busy.root);
> > +
> > +		if (*va)
> > +			if (!va_start_lowest || (*va)->va_start < va_start_lowest)
> > +				va_start_lowest = (*va)->va_start;
> 
> How about below change about va_start_lowest? Personal preference, not
> strong opinion.
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 9b1a41e12d70..bd6a66c54ad2 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -1046,19 +1046,19 @@ __find_vmap_area_exceed_addr(unsigned long addr, struct rb_root *root)
>  static struct vmap_node *
>  find_vmap_area_exceed_addr_lock(unsigned long addr, struct vmap_area **va)
>  {
> -	unsigned long va_start_lowest;
> +	unsigned long va_start_lowest = ULONG_MAX;
>  	struct vmap_node *vn;
>  	int i;
>  
>  repeat:
> -	for (i = 0, va_start_lowest = 0; i < nr_vmap_nodes; i++) {
> +	for (i = 0; i < nr_vmap_nodes; i++) {
>  		vn = &vmap_nodes[i];
>  
>  		spin_lock(&vn->busy.lock);
>  		*va = __find_vmap_area_exceed_addr(addr, &vn->busy.root);
>  
>  		if (*va)
> -			if (!va_start_lowest || (*va)->va_start < va_start_lowest)
> +			if ((*va)->va_start < va_start_lowest)
>  				va_start_lowest = (*va)->va_start;
>  		spin_unlock(&vn->busy.lock);
>  	}
> @@ -1069,7 +1069,7 @@ find_vmap_area_exceed_addr_lock(unsigned long addr, struct vmap_area **va)
>  	 * been removed concurrently thus we need to proceed
>  	 * with next one what is a rare case.
>  	 */
> -	if (va_start_lowest) {
> +	if (va_start_lowest != ULONG_MAX) {
>  		vn = addr_to_node(va_start_lowest);
>  
>  		spin_lock(&vn->busy.lock);
> 
> 
To me it looks as incomplete. The "va_start_lowest" should be initialized
when repeat. Otherwise we can end up with an infinite repeating because
va_start_lowest != ULONG_MAX.

> >  	}
> >  
> > -	return va_node;
> > -}
> > -
> > -static struct vmap_area *__find_vmap_area(unsigned long addr, struct rb_root *root)
> > -{
> > -	struct rb_node *n = root->rb_node;
> > +	/*
> > +	 * Check if found VA exists, it might it is gone away.
>                                         ~~~~ grammer mistake?
> > +	 * In this case we repeat the search because a VA has
> > +	 * been removed concurrently thus we need to proceed
> > +	 * with next one what is a rare case.
>                          ~~~~ typo, which?
> > +	 */
> > +	if (va_start_lowest) {
> > +		vn = addr_to_node(va_start_lowest);
> >  
> > -	addr = (unsigned long)kasan_reset_tag((void *)addr);
> > +		spin_lock(&vn->busy.lock);
> > +		*va = __find_vmap_area(va_start_lowest, &vn->busy.root);
> >  
> > -	while (n) {
> > -		struct vmap_area *va;
> > +		if (*va)
> > +			return vn;
> >  
> > -		va = rb_entry(n, struct vmap_area, rb_node);
> > -		if (addr < va->va_start)
> > -			n = n->rb_left;
> > -		else if (addr >= va->va_end)
> > -			n = n->rb_right;
> > -		else
> > -			return va;
> > +		spin_unlock(&vn->busy.lock);
> > +		goto repeat;
> >  	}
> 
> Other than above nickpick concerns, this looks good to me.
> 
> Reviewed-by: Baoquan He <bhe@redhat.com>
> 
Thank you!

--
Uladzislau Rezki

