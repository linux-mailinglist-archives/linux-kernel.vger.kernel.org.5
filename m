Return-Path: <linux-kernel+bounces-164859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF0C8B840D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 03:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D5E61C2256A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 01:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9056F846F;
	Wed,  1 May 2024 01:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="Egtkymk9"
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240705C99
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 01:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714528066; cv=none; b=Rx7o1Uw+JByZjBfKKFh2v85U+znoj2x0qDMcnRzW6p2xqPAmPSttT/KynN1+msLdXgCgdiamX8wHQYGI2zp9LNbTQj2CfrS7LCaOnly07u7mnBWwY4mLG+wXBgejkcIeap5+H0Irz0jkEaKJUR+pqr4YykCiE0JY3qY76yLFt/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714528066; c=relaxed/simple;
	bh=1BevPDrC06ybAYlvpZi7vW1hZEysUlTpN+aYC4MLwG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sp4BrctUoBD7oidtpju6BUQ4uiOVbsDbNYOCwMI6U5ftKv1raCt64KLjiorYZlbd2C6Fvj7Ar7AOxx4akyNVxLrVgQAUPgp+URKnKEaRNax1ccV2sAPgBr1FPRmvyQV9YRQKm1GecakZUFWnc0Z0sQjfDq8ceLvf+P/vQT+SerU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=Egtkymk9; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-23d41245bd9so448493fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 18:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1714528063; x=1715132863; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X2lTibDiFI0ZoiOE7Og2GQjpallD6n8zJfYR3muw4DE=;
        b=Egtkymk99E8HdIFt7CFI80d1oLSo/+q0ExuR+ZmXm6FjAh1KoWY5xXmrKdaZH8JX0S
         lss1PXc6PE2l+fG8yob+pZZV3VdDPuu9R0xUWRNSnIGfnLc+ikTID02PKGqgFL76BhGZ
         4TxbDicveQ2bPgAxk/x/jTNcPBx/6IUiS4qVbhr1t1ajg6oPaGkXcUDWt9/fFf6Q4Q3R
         ISxo1xktJScvePyFsyhVwWVtpwAElt8xmMUuGTL1LWrc1n6d0Uu8paQsnVuGSV3G0V4H
         vqnXE770Q/n9LYMNfRRbmwxdB3xAclqWRM+8RRIvp0N6BzgmTKtJ67dsdf5IVSR7FmXt
         QGlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714528063; x=1715132863;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X2lTibDiFI0ZoiOE7Og2GQjpallD6n8zJfYR3muw4DE=;
        b=r45XhEosJnShQ0pAVM+oomjarsxazlceTIdZFEcuxU/ivkqUnbOxe5nBMQ1/arW+Pc
         NeIJi22WP9ghJhkZdzUL8ljhReO6+lRHBv7z86LZkK3G/j0hTh8ip2fW0yDCk3cT2j8O
         O3iuAFlCkkeiXd7bzFajaUkAaP9kksyqsd2f9MYzH2euXHn1s6ZNQJMnhmRo8fVD0bCn
         8Mhf8RlUbwm7i2HJDoBFKd1Vho6LneiKxNHO+QnSYOwTHu8uKD66tGZQdhe3c5cCctMY
         v7qcBi7ZZEaDSNRVqeHjuepe+GL0ju4wMaUtT0LeFm55f8tmWA/4an9fTIHPSiVnxOuF
         EK1g==
X-Forwarded-Encrypted: i=1; AJvYcCW6U8XUNDguabZgVs3hCFK8ZbIb9NqCP4sYuMjeDUpPlNTyYPbXZWCq5YoZ//TW/Pc0Norx7EyrHgVBn9TdeyFfjSCmNVzhbV6hN524
X-Gm-Message-State: AOJu0Yx0NE4NC0BmTIkCFm4Bc9q7q33QnGwxl8Dw0LxaweJXjlOzzt1E
	roZFxS29cFdhbKnT7eLvzmh9Zn9yYkHlQD4i1gU7XuyeyGKyLLzpuh4FRBNwjs4=
X-Google-Smtp-Source: AGHT+IEmewIJwY7Yi1W0lOvUPHQD+aXLDxZ98fdhOHrZpRU1dqWfUjvKTaI2jboHvumLvPnDmIO3YQ==
X-Received: by 2002:a05:6870:4414:b0:23c:bc3a:6ccb with SMTP id u20-20020a056870441400b0023cbc3a6ccbmr1237203oah.19.1714528062942;
        Tue, 30 Apr 2024 18:47:42 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id i11-20020a056a00004b00b006e4432027d1sm5918046pfk.142.2024.04.30.18.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 18:47:42 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1s1z4N-00Gq9H-2k;
	Wed, 01 May 2024 11:47:39 +1000
Date: Wed, 1 May 2024 11:47:39 +1000
From: Dave Chinner <david@fromorbit.com>
To: John Garry <john.g.garry@oracle.com>
Cc: djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, chandan.babu@oracle.com,
	willy@infradead.org, axboe@kernel.dk, martin.petersen@oracle.com,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	tytso@mit.edu, jbongio@google.com, ojaswin@linux.ibm.com,
	ritesh.list@gmail.com, mcgrof@kernel.org, p.raghav@samsung.com,
	linux-xfs@vger.kernel.org, catherine.hoang@oracle.com
Subject: Re: [PATCH v3 17/21] iomap: Atomic write support
Message-ID: <ZjGfOyJl5y3D49fC@dread.disaster.area>
References: <20240429174746.2132161-1-john.g.garry@oracle.com>
 <20240429174746.2132161-18-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429174746.2132161-18-john.g.garry@oracle.com>

On Mon, Apr 29, 2024 at 05:47:42PM +0000, John Garry wrote:
> Support atomic writes by producing a single BIO with REQ_ATOMIC flag set.
> 
> We rely on the FS to guarantee extent alignment, such that an atomic write
> should never straddle two or more extents. The FS should also check for
> validity of an atomic write length/alignment.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  fs/iomap/direct-io.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index a3ed7cfa95bc..d7bdeb675068 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -275,6 +275,7 @@ static inline blk_opf_t iomap_dio_bio_opflags(struct iomap_dio *dio,
>  static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>  		struct iomap_dio *dio)
>  {
> +	bool is_atomic = dio->iocb->ki_flags & IOCB_ATOMIC;
>  	const struct iomap *iomap = &iter->iomap;
>  	struct inode *inode = iter->inode;
>  	unsigned int zeroing_size, pad;
> @@ -387,6 +388,9 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>  		bio->bi_iter.bi_sector = iomap_sector(iomap, pos);
>  		bio->bi_write_hint = inode->i_write_hint;
>  		bio->bi_ioprio = dio->iocb->ki_ioprio;
> +		if (is_atomic)
> +			bio->bi_opf |= REQ_ATOMIC;

REQ_ATOMIC is only valid for write IO, isn't it?

This should be added in iomap_dio_bio_opflags() after it is
determined we are doing a write operation.  Regardless, it should be
added in iomap_dio_bio_opflags(), not here. That also allows us to
get rid of the is_atomic variable.

> +
>  		bio->bi_private = dio;
>  		bio->bi_end_io = iomap_dio_bio_end_io;
>  
> @@ -403,6 +407,12 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>  		}
>  
>  		n = bio->bi_iter.bi_size;
> +		if (is_atomic && n != orig_count) {
> +			/* This bio should have covered the complete length */
> +			ret = -EINVAL;
> +			bio_put(bio);
> +			goto out;
> +		}

What happens now if we've done zeroing IO before this? I suspect we
might expose stale data if the partial block zeroing converts the
unwritten extent in full...

>  		if (dio->flags & IOMAP_DIO_WRITE) {
>  			task_io_account_write(n);
>  		} else {

Ignoring the error handling issues, this code might be better as:

		if (dio->flags & IOMAP_DIO_WRITE) {
			if ((opflags & REQ_ATOMIC) && n != orig_count) {
				/* atomic writes are all or nothing */
				ret = -EIO
				bio_put(bio);
				goto out;
			}
		}

so that we are not putting atomic write error checks in the read IO
submission path.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

