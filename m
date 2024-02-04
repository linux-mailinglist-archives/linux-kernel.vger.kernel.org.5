Return-Path: <linux-kernel+bounces-51946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8510B8491B7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 00:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D5DD1C203B3
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 23:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF34C8E0;
	Sun,  4 Feb 2024 23:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="FRw0G62Y"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AC3BE5A
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 23:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707089693; cv=none; b=dXn8VbJJz8v4NiDer2IMGmOiqvVAnSzA0r4fb2X3BihzUaNIX8gKF4fFLH+qDqWHDXGPuPCt0w/BKH0cMu+BY2qUCpEru36cDf5tFI5C/jYNKteZOESns9n/h1mkUpoKeUdrDlkKvPw5DCXtlSSSpZF211lIcnbleVhbgAJdJlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707089693; c=relaxed/simple;
	bh=mzpbX0JLJdVzO2c/5EYUqV4nIisyNX0uSPxWZjygZhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S1tBpwdGQJrTDHD4wB20JAKC8M8CSFUEAgK0ukv4CWTvFH1AgWMV8iUEKQwSM6eOcVQwAtgG1vWTFephheiao7ArjMpgn0jqPFAk09MXYBNaWZxTWwHLD61hy8Ioa4J8zU/JUupxSIOl43QMnSzG4pnMIL/JKndBdud6YDv+X24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=FRw0G62Y; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e040c83556so270106b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 15:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1707089691; x=1707694491; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p2TnSnFYEsDimdpS3N17Ru85rGMnUNIuGwXCS2vJfQo=;
        b=FRw0G62YRIRSd1l36tnMa358x2HiQDU2XiJb0Bc+TvQdyY61zgdkXPjpH3cdkpVKlK
         su/AVYrxGlwbd40jb99DJZvrAX/7vO6urSQzSNPrqkBKacpwsTvayKNF/ukiIrkni5VG
         nS9mKNFydm9PuVls1VWaLRsgKfrm3DRM8VgVxs5SKot1z+NYxwMw2Hwidob58qAWmYmz
         nqgEqKBOZrS2Zrn85Z66b8odKfk48F+CgrbXRgvlWM+lw0qWXPbSj5zSaKhlALXrYLnD
         3nucyzhKs/bmJA/aZa6NXTK4hVbSFiIdqaQmWSloEqxDR9rMqbi6ZMLO4gMuoojjXvsF
         uFFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707089691; x=1707694491;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p2TnSnFYEsDimdpS3N17Ru85rGMnUNIuGwXCS2vJfQo=;
        b=c3WOUbaDLDosoMA7Sucz2FPDsocqH0xeheLUL8X/gXf8IMIJ4SFsonnB9YvEq1zYXh
         BmbvUqoW/ilgOwujE79UJSXxi3QhVqLIfepGo5ViwH+uNjhHAoiFfDVgZTZRFdYq7Hrq
         3l6To7IM6dIGABSKtvyGJHtW+Ipr9lokbXIuDNvQHU7us5hwEGeV/SmVR67J+/FKNgKU
         cTynkWp0jvbqgN0sBWAgpcaoLqSJEMjYXtu2UbUyBSGP/ivlwRMk+hTtj1c5waD27bpC
         z1/3hQOVIJTMbwdJF51Q2z6+tZ44AeVdZJzE7IAKW3hHDtVT5fgphEPdXTLc+dQKpF6t
         ymOQ==
X-Gm-Message-State: AOJu0YzOTJPwTj+uFmESjuHMufqlmBR3vBYPVBm87TUDXsx8iwVNhkoT
	7+rkTzj843Q9vuR7hBoaq7OPzPYbBUdSnN0kzndchp5Lokj6dk44TlgQ7noaUbw=
X-Google-Smtp-Source: AGHT+IF/iScD9UiPoru51YxiL2oZG6kkO9dOS0pdBYHBb4GuksLfFUGdQXzGHfeNI7h4UsP0jyX3xA==
X-Received: by 2002:a05:6a00:2192:b0:6e0:25db:65b2 with SMTP id h18-20020a056a00219200b006e025db65b2mr5694366pfi.14.1707089691057;
        Sun, 04 Feb 2024 15:34:51 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUSoMhjFgbz6wgPYjJeWh0oBQcp6MJNa57h3rXjMk90rQX9EVmU21co4Vy13pQ78HfAK+dGBm51kXWCv8XPb7jMIPFd0Zg/FJOlcH/ShnF2EIeOLQY8LC2IRQIzg8ZOH6QBwJl9Die3twPbKyjCq158cXpUeT5L+wzpnvjJRWM1n4riTNHqBuOwCfGyDski6jpqfGIbMzRmo0z03NXa8O44yHf3NBsY+Ry8rtnnLptRU+M/jFT2un02cNaZBfEAbtTiQrB+oceSPYqkImMz1GtPC0COLQJ58gmUFrQEyh/gZcktQV3fs3APTofh01rGo3KBYsD+eV6vS5eqA8jjjyrLYpcxFYMqwwykAAqHa6O7
Received: from dread.disaster.area (pa49-181-38-249.pa.nsw.optusnet.com.au. [49.181.38.249])
        by smtp.gmail.com with ESMTPSA id x2-20020aa79a42000000b006da2aad58adsm1422234pfj.176.2024.02.04.15.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 15:34:50 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rWm0d-00293b-35;
	Mon, 05 Feb 2024 10:34:47 +1100
Date: Mon, 5 Feb 2024 10:34:47 +1100
From: Dave Chinner <david@fromorbit.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Don Dutile <ddutile@redhat.com>, Rafael Aquini <raquini@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>
Subject: Re: [PATCH] mm/madvise: set ra_pages as device max request size
 during ADV_POPULATE_READ
Message-ID: <ZcAfF18OM2kqKsBe@dread.disaster.area>
References: <20240202022029.1903629-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202022029.1903629-1-ming.lei@redhat.com>

On Fri, Feb 02, 2024 at 10:20:29AM +0800, Ming Lei wrote:
> madvise(MADV_POPULATE_READ) tries to populate all page tables in the
> specific range, so it is usually sequential IO if VMA is backed by
> file.
> 
> Set ra_pages as device max request size for the involved readahead in
> the ADV_POPULATE_READ, this way reduces latency of madvise(MADV_POPULATE_READ)
> to 1/10 when running madvise(MADV_POPULATE_READ) over one 1GB file with
> usual(default) 128KB of read_ahead_kb.
> 
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Don Dutile <ddutile@redhat.com>
> Cc: Rafael Aquini <raquini@redhat.com>
> Cc: Dave Chinner <david@fromorbit.com>
> Cc: Mike Snitzer <snitzer@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  mm/madvise.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 51 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 912155a94ed5..db5452c8abdd 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -900,6 +900,37 @@ static long madvise_dontneed_free(struct vm_area_struct *vma,
>  		return -EINVAL;
>  }
>  
> +static void madvise_restore_ra_win(struct file **file, unsigned int ra_pages)
> +{
> +	if (*file) {
> +		struct file *f = *file;
> +
> +		f->f_ra.ra_pages = ra_pages;
> +		fput(f);
> +		*file = NULL;
> +	}
> +}
> +
> +static struct file *madvise_override_ra_win(struct file *f,
> +		unsigned long start, unsigned long end,
> +		unsigned int *old_ra_pages)
> +{
> +	unsigned int io_pages;
> +
> +	if (!f || !f->f_mapping || !f->f_mapping->host)
> +		return NULL;
> +
> +	io_pages = inode_to_bdi(f->f_mapping->host)->io_pages;
> +	if (((end - start) >> PAGE_SHIFT) < io_pages)
> +		return NULL;
> +
> +	f = get_file(f);
> +	*old_ra_pages = f->f_ra.ra_pages;
> +	f->f_ra.ra_pages = io_pages;
> +
> +	return f;
> +}

This won't do what you think if the file has been marked
FMODE_RANDOM before this populate call.

IOWs, I don't think madvise should be digging in the struct file
readahead stuff here. It should call vfs_fadvise(FADV_SEQUENTIAL) to
do the set the readahead mode, rather that try to duplicate
FADV_SEQUENTIAL (badly).  We already do this for WILLNEED to make it
do the right thing, we should be doing the same thing here.

Also, AFAICT, there is no need for get_file()/fput() here - the vma
already has a reference to the struct file, and the vma should not
be going away whilst the madvise() operation is in progress.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

