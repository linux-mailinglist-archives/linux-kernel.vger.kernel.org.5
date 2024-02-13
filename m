Return-Path: <linux-kernel+bounces-64409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2FB853E4B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8629B29480
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6FBE62147;
	Tue, 13 Feb 2024 22:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="FFqanNFY"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F25C61677
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 22:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707861653; cv=none; b=Lvlic6b+qFpbOGmJOcxifYZ4UGjmHdQuKbsBRrz8n6vA7/6pc1hOE6PGc4s9IvelFzG3UWa9C2XYfcvH80t1X3D1k6+9qCacJ6km8n+NW1NbAVphBOYl45wDTkbPYbwcjxQYYLyV9TUm+5+qfEuBshbUdEwvRjpkGz/jTb4EtFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707861653; c=relaxed/simple;
	bh=htdyldrmjLYOtAtg7kK58a5VCDLf1xw13b6zCaXg+yQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o7tZMJcUYeHdCVEIlmcEJYPiUcywYYqV72xgewRtaxQxMofQfmcHNrOd0UKdWtFMkAAows67VEplTeRwsrt2Ux/l4Y+LzKI7/rLjwQ2BBRYOilUfhJ1egTwBWwiC9CKqP3MIlXAFTnT/q2eqCLTQnXsepWedZ8+NDVw6e72I8aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=FFqanNFY; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-296dc0cab6aso137013a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 14:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1707861651; x=1708466451; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LOy62y/l+hy+VpeNSTBfz65Ny067CD40d0fpxQdxrHs=;
        b=FFqanNFYJUgVDQ2vLy1HCOB9xwZ8ayyf7xxWsxRTjQYdIN5ospK8N42cAe6gQB4niJ
         nX6Oo44sju8bEyQCFM3GbgGfKtILLt1wTFJjr5RaVhFwP03pjRZWZlV8fbwzlsM2C+s6
         4xyarqKzbsBmQUmRG9kuA2bc2Wp3w9aykDcB1LoUvEsuWjBG2Js6+MGwfLqyy8jWxnpM
         d/sFeN+C6PBYajUtkKG3HJFXQA8dUWqyE1D5KOocLLpwrT7V2m7KnN9Q6ul0uglrRDGd
         JC82pNn8e30Cx6T87CNi0BWFv+1sAhTRUlz9npdGxJHJ07B3bRTBH7XzOxNkuWi8daAX
         DbrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707861651; x=1708466451;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LOy62y/l+hy+VpeNSTBfz65Ny067CD40d0fpxQdxrHs=;
        b=YeAKak3xhojFVtSmw1cO+ovy+WeARM5YyXaKUXNAldbnXj8WXptGeEXMuZlkmxcH64
         wpzOkpO0XzrOBRspkOv502e5EgyxZBdZcQLplY/rLRe7PUJUDeu7t/KHm6ShX9w7vDTB
         UCR7VsmbjHgcpWSRC1epk7Rq3LOwNn38n0S+1cUMOSD4dJ9YAaeSWhoou6eNTalQkk+H
         /ejJANeX0vSgstQtSygFh2lug7i5nd2oDHO5DZvXou32SjpNLd4W4wluwKITBHZwBxCI
         DzE9JKUfGgn5GsnqWmnmsMODbgWr+JXnXVwmt2ZZ621Bc99o9P1BnTqjAp+j55L/TWPv
         7tSg==
X-Forwarded-Encrypted: i=1; AJvYcCUXd9+WfTGQg1/ON/gS4ut+j1mUvXi0ta2muD+qfha7vCQHfREHQGddPMs3LwVYqlLw+WPlcq4sWC2xdle5mabhdxd2X9e/Yz37YrMs
X-Gm-Message-State: AOJu0YyPn8eBpU8KPd6ikXF7dtb9ckJzYSh9/h1ZPb5A2xwaUHiRchA2
	lspRE7X8wGN75djAGbQ+e2XVkmFj2b1HkJpxCCVf/+vAZiFFbLu6hpWVgd1OCY8=
X-Google-Smtp-Source: AGHT+IEtluv1IQyCMYzRb3zjY+gIW+P+JFmQv935YBRoN3MfD9rTNtYsSqa2/eF8gVJtVjYzpvhrEA==
X-Received: by 2002:a17:90b:2292:b0:298:b516:f4c0 with SMTP id kx18-20020a17090b229200b00298b516f4c0mr166636pjb.16.1707861651023;
        Tue, 13 Feb 2024 14:00:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXfkPc0mfLFBFQbVip2kMaoGS9fy5JaOs+tUSLZKTLsVHHCDzKzQ9r0GdJISe81SJmdpRjFMiuEx5tvIwJ01XJfzivCakjGwarRmGoaWDq6qiPSwQEEY5+gYW2PVZGBdWOf6hYwGZsBg8QRrqB3fgkBu+/L+Uy57LUPCEYN+NUYJqX7Yt1rvujWEvDpgf46cdVp8HGTIWgy43XGmW12kjY+Kje5f04uNn0/Yz3ASGWVHJBRynAl4ojk97J/6+/L4nibEqSpYPOPq736rXzeNnVaoe/pJkbmizq5jmhy0L+WQBD71oR593t5ECOxI7rgGIj+hmu1Lu6AcAP7LfWBdlFA+LLvXUwcyUFUQXFo2N+l9OM5gxYfgNaSN5VKl66rNlfVFkaqJTTMUyB8UU6anWMjNJtwDkJuIHsWX1E=
Received: from dread.disaster.area (pa49-181-38-249.pa.nsw.optusnet.com.au. [49.181.38.249])
        by smtp.gmail.com with ESMTPSA id o14-20020a17090aac0e00b0029718f72ad3sm2258pjq.44.2024.02.13.14.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 14:00:50 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1ra0pa-0067aF-2H;
	Wed, 14 Feb 2024 09:00:46 +1100
Date: Wed, 14 Feb 2024 09:00:46 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	mcgrof@kernel.org, gost.dev@samsung.com, akpm@linux-foundation.org,
	kbusch@kernel.org, djwong@kernel.org, chandan.babu@oracle.com,
	p.raghav@samsung.com, linux-kernel@vger.kernel.org, hare@suse.de,
	willy@infradead.org, linux-mm@kvack.org
Subject: Re: [RFC v2 02/14] filemap: align the index to mapping_min_order in
 the page cache
Message-ID: <ZcvmjthSu0TNkf8z@dread.disaster.area>
References: <20240213093713.1753368-1-kernel@pankajraghav.com>
 <20240213093713.1753368-3-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213093713.1753368-3-kernel@pankajraghav.com>

On Tue, Feb 13, 2024 at 10:37:01AM +0100, Pankaj Raghav (Samsung) wrote:
> From: Luis Chamberlain <mcgrof@kernel.org>
> 
> Supporting mapping_min_order implies that we guarantee each folio in the
> page cache has at least an order of mapping_min_order. So when adding new
> folios to the page cache we must ensure the index used is aligned to the
> mapping_min_order as the page cache requires the index to be aligned to
> the order of the folio.
> 
> A higher order folio than min_order by definition is a multiple of the
> min_order. If an index is aligned to an order higher than a min_order, it
> will also be aligned to the min order.
> 
> This effectively introduces no new functional changes when min order is
> not set other than a few rounding computations that should result in the
> same value.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  mm/filemap.c | 34 ++++++++++++++++++++++++++--------
>  1 file changed, 26 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 750e779c23db..323a8e169581 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2479,14 +2479,16 @@ static int filemap_get_pages(struct kiocb *iocb, size_t count,
>  {
>  	struct file *filp = iocb->ki_filp;
>  	struct address_space *mapping = filp->f_mapping;
> +	unsigned int min_nrpages = mapping_min_folio_nrpages(mapping);
>  	struct file_ra_state *ra = &filp->f_ra;
> -	pgoff_t index = iocb->ki_pos >> PAGE_SHIFT;
> +	pgoff_t index = round_down(iocb->ki_pos >> PAGE_SHIFT, min_nrpages);

This is pretty magic - this patch adds a bunch of what appear to be
random rounding operations for some undocumented reason.

>  	pgoff_t last_index;
>  	struct folio *folio;
>  	int err = 0;
>  
>  	/* "last_index" is the index of the page beyond the end of the read */
>  	last_index = DIV_ROUND_UP(iocb->ki_pos + count, PAGE_SIZE);
> +	last_index = round_up(last_index, min_nrpages);

Same here - this is pretty nasty - we round up twice, but no obvious
reason as to why the second round up exists or why it can't be done
by the DIV_ROUND_UP() call. Just looking at the code it's impossible
to reason why this is being done, let alone determine if it has been
implemented correctly.

>  retry:
>  	if (fatal_signal_pending(current))
>  		return -EINTR;
> @@ -2502,8 +2504,7 @@ static int filemap_get_pages(struct kiocb *iocb, size_t count,
>  	if (!folio_batch_count(fbatch)) {
>  		if (iocb->ki_flags & (IOCB_NOWAIT | IOCB_WAITQ))
>  			return -EAGAIN;
> -		err = filemap_create_folio(filp, mapping,
> -				iocb->ki_pos >> PAGE_SHIFT, fbatch);
> +		err = filemap_create_folio(filp, mapping, index, fbatch);
>  		if (err == AOP_TRUNCATED_PAGE)
>  			goto retry;
>  		return err;
> @@ -3095,7 +3096,10 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
>  	struct file *file = vmf->vma->vm_file;
>  	struct file_ra_state *ra = &file->f_ra;
>  	struct address_space *mapping = file->f_mapping;
> -	DEFINE_READAHEAD(ractl, file, ra, mapping, vmf->pgoff);
> +	unsigned int min_order = mapping_min_folio_order(mapping);
> +	unsigned int min_nrpages = mapping_min_folio_nrpages(file->f_mapping);

Why use file->f_mapping here and not mapping? And why not just

	unsigned int min_nrpages = 1U < min_order;

So it's obvious how the index alignment is related to the folio
order?

> +	pgoff_t index = round_down(vmf->pgoff, min_nrpages);
> +	DEFINE_READAHEAD(ractl, file, ra, mapping, index);
>  	struct file *fpin = NULL;
>  	unsigned long vm_flags = vmf->vma->vm_flags;
>  	unsigned int mmap_miss;
> @@ -3147,10 +3151,11 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
>  	 */
>  	fpin = maybe_unlock_mmap_for_io(vmf, fpin);
>  	ra->start = max_t(long, 0, vmf->pgoff - ra->ra_pages / 2);
> +	ra->start = round_down(ra->start, min_nrpages);

Again, another random rounding operation....

>  	ra->size = ra->ra_pages;
>  	ra->async_size = ra->ra_pages / 4;
>  	ractl._index = ra->start;
> -	page_cache_ra_order(&ractl, ra, 0);
> +	page_cache_ra_order(&ractl, ra, min_order);
>  	return fpin;
>  }
>  
> @@ -3164,7 +3169,9 @@ static struct file *do_async_mmap_readahead(struct vm_fault *vmf,
>  {
>  	struct file *file = vmf->vma->vm_file;
>  	struct file_ra_state *ra = &file->f_ra;
> -	DEFINE_READAHEAD(ractl, file, ra, file->f_mapping, vmf->pgoff);
> +	unsigned int min_nrpages = mapping_min_folio_nrpages(file->f_mapping);
> +	pgoff_t index = round_down(vmf->pgoff, min_nrpages);
> +	DEFINE_READAHEAD(ractl, file, ra, file->f_mapping, index);

Ok, this is begging for a new DEFINE_READAHEAD_ALIGNED() macro which
internally grabs the mapping_min_folio_nrpages() from the mapping
passed to the macro.

>  	struct file *fpin = NULL;
>  	unsigned int mmap_miss;
>  
> @@ -3212,13 +3219,17 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
>  	struct file *file = vmf->vma->vm_file;
>  	struct file *fpin = NULL;
>  	struct address_space *mapping = file->f_mapping;
> +	unsigned int min_order = mapping_min_folio_order(mapping);
> +	unsigned int nrpages = 1UL << min_order;

You didn't use mapping_min_folio_nrpages() for this.

At least initialise all the variables the same way in the same
patch!

>  	struct inode *inode = mapping->host;
> -	pgoff_t max_idx, index = vmf->pgoff;
> +	pgoff_t max_idx, index = round_down(vmf->pgoff, nrpages);

Yup, I can't help but think that with how many times this is being
repeated in this patchset that a helper or two is in order:

	index = mapping_align_start_index(mapping, vmf->pgoff);

And then most of the calls to mapping_min_folio_order() and
mapping_min_folio_nrpages() can be removed from this code, too.


>  	struct folio *folio;
>  	vm_fault_t ret = 0;
>  	bool mapping_locked = false;
>  
>  	max_idx = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
> +	max_idx = round_up(max_idx, nrpages);

	max_index = mapping_align_end_index(mapping,
			DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE));

>  	if (unlikely(index >= max_idx))
>  		return VM_FAULT_SIGBUS;
>  
> @@ -3317,13 +3328,17 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
>  	 * We must recheck i_size under page lock.
>  	 */
>  	max_idx = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
> +	max_idx = round_up(max_idx, nrpages);

Same again:

	max_index = mapping_align_end_index(mapping,
			DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE));
> +
>  	if (unlikely(index >= max_idx)) {
>  		folio_unlock(folio);
>  		folio_put(folio);
>  		return VM_FAULT_SIGBUS;
>  	}
>  
> -	vmf->page = folio_file_page(folio, index);
> +	VM_BUG_ON_FOLIO(folio_order(folio) < min_order, folio);
> +
> +	vmf->page = folio_file_page(folio, vmf->pgoff);
>  	return ret | VM_FAULT_LOCKED;
>  
>  page_not_uptodate:
> @@ -3658,6 +3673,9 @@ static struct folio *do_read_cache_folio(struct address_space *mapping,
>  {
>  	struct folio *folio;
>  	int err;
> +	unsigned int min_nrpages = mapping_min_folio_nrpages(mapping);
> +
> +	index = round_down(index, min_nrpages);

And more magic rounding.

	index = mapping_align_start_index(mapping, index);

-Dave.
-- 
Dave Chinner
david@fromorbit.com

