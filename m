Return-Path: <linux-kernel+bounces-49196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CAE884670E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 05:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC71028A080
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 04:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91DBBF4F0;
	Fri,  2 Feb 2024 04:43:16 +0000 (UTC)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBA1171A4
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 04:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706848996; cv=none; b=Hb7721NhEN9J6lyAbh2EkjprjRrqe23RjaUSmPRbTCOgOlULiXWHVciCk94V/K5XECI4Xv6B6AZGoJD3SeM+HTD58M54FxtGrFYq/pjdeeXqidgLbFvVGnIxirpGgUEicwpvVZAMB/RZ2W8UoFauiWGj3AG1Ji2Kn4pB/v3PR1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706848996; c=relaxed/simple;
	bh=KbBjZy9iycVf4ojBY1It8CEOUxZ9lKWWvYcer608C4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MEq0HftVBez/7abc9Yw7r8T37/mfy97Yrw+V5HWMPu9mP/TgSKOZwkQ41qdKWJzY1KY8+C4coMmJlsOYKlH6rgxPGwWqnByZ4bxf8VW9OQeAfL75bmbba1DmTKx6sq9YVsQlZbRwDoY2RrQHhRFQyKWHVqcCzvWes4N32zaIUKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=redhat.com; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-68c444f9272so8208786d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 20:43:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706848993; x=1707453793;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hpbVH2T0wltjnZkqMBBaWFJ/E+D1lvYVrdtxC3+idLI=;
        b=mIBrIJH9aOagWngLeDOJV3v/uxEJL7WXdRsfVvsoO+1idkBjV66Q2YVzSrrlQ2cg0t
         Hh2T7/fu0n1WnhfJphK+IPBdO8qOwCvg+rnKLOsjcdvv9FtxfwX9QN2QGr3tiKJO+jof
         KaQV3awJu7JHjcvbhn2730OOLFdZiuh1/3Ps/Nd0pyQM3LGiikFpW6m5tWOhZQHSe69M
         ztTGgajP1s4pL/OWMMDKj3y04rOODfbx/RFCeqgy9Jcq1F+klnfXqXNEiG9zvxFpKZWN
         1nQTZmIwtdwpRn9h4CP6WRLKnIKFC6TMJnwM95jd5HIDXZokK8FcuIvv/zXXMIO7+KQf
         vX4g==
X-Gm-Message-State: AOJu0Yzg8hY5qXh0eiiL4GdLQhBOd7+7I/yRILAM+FLH+0kmMD2M5dot
	2uAPkyvw/oKoNvlQnrpALRr4XPTrOTd5PVn3YPtzUTTQEPJDBV6cNaa59kEXkw==
X-Google-Smtp-Source: AGHT+IFkfgQQl6ScAsRKVY+kYHICcKa/8Aap2tR0uxRTjTowwMAG4fOOLe8DmmPudwYqaj/ngdwZLg==
X-Received: by 2002:a0c:f108:0:b0:68c:668d:a671 with SMTP id i8-20020a0cf108000000b0068c668da671mr4471350qvl.7.1706848993232;
        Thu, 01 Feb 2024 20:43:13 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWxDF2cihEXJ7LLzKJJwE8WhiB/Szmvo9Pe1CG4D9R9oobsPLZeUSaO5F9I3teoYkkwNRR5KARS2kmo9oi0op83C2LvpaP92YiLP7SfHSJO1yjkSSlxuWtHz93m/pz2sn0fUp4R9bukGtCaTO7NoHy04nmhtq+5fAMiiXiG29p3pZwLqMoe9HqhYlefxKyUuyk3v5rbhd1IKj5Ljp7JyEkvNXKMgxfVNWfnzCfPacOkCbu5Y8VQO/LOIo2Eo8gTBbVDxi+2BIshKNIpFwMUeS1j0yb1UA1wKJLj+bd1B/1dk5LpzqLrbrxkOkJj8JLUusqbnVer9+fQNEUjPNwI8cCARRTFm1k4KqrlfosUuITU/g==
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id bm13-20020a05620a198d00b0078409ed9030sm384126qkb.124.2024.02.01.20.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 20:43:12 -0800 (PST)
Date: Thu, 1 Feb 2024 23:43:11 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Don Dutile <ddutile@redhat.com>, Rafael Aquini <raquini@redhat.com>,
	Dave Chinner <david@fromorbit.com>
Subject: Re: mm/madvise: set ra_pages as device max request size during
 ADV_POPULATE_READ
Message-ID: <Zbxy30POPE8rN_YN@redhat.com>
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

On Thu, Feb 01 2024 at  9:20P -0500,
Ming Lei <ming.lei@redhat.com> wrote:

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
> +

Does this override imply that madvise_populate resorts to calling
filemap_fault() and here you're just arming it to use the larger
->io_pages for the duration of all associated faulting?

Wouldn't it be better to avoid faulting and build up larger page
vectors that get sent down to the block layer in one go and let the
block layer split using the device's limits? (like happens with
force_page_cache_ra)

I'm concerned that madvise_populate isn't so efficient with filemap
due to excessive faulting (*BUT* I haven't traced to know, I'm just
inferring that is why twiddling f->f_ra.ra_pages helps improve
madvise_populate by having it issue larger IO. Apologies if I'm way
off base)

Mike

