Return-Path: <linux-kernel+bounces-164843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4D58B83E0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 03:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCE8C1C22931
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 01:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C484C6F;
	Wed,  1 May 2024 01:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="TkKY8Wo2"
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F90E2114
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 01:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714525629; cv=none; b=Zv2KpXYlPRePt1QXD9XQhE/sKa5TpAURXmnS/Co6/zTvH8FdyEezRAIVftB7lNmrI4f5Nic0akTM4GbeGuf03Vgua8IzY8zYvYZ218JUH94tlR2DIKOTlSB7YqCUSgmuOfXuouFuNRaK0XwtqjHxiGvZ4flypsWLsv9e65eCyh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714525629; c=relaxed/simple;
	bh=s8yb6mm99nB/I+qJD9yDN/PojsAN74q0ITjiDm/lylM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QKgOJsFe2SPJie8TV6VmwX7NlSM+cQoiAkBka55/xxKLV2NQ+/xumb4e/HsdqSU2jf63200Nj/6cm5FppWi7XqIFnKWubySUy2SrjcBxS5Y96Y5vwJiaN4uPooZxEg48dvC0l8XLGEP7Ik4H43EI1UFfUaCzMWXf2RInLEyL6mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=TkKY8Wo2; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-23d3afdcd71so422189fac.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 18:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1714525627; x=1715130427; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tcU+VfO6+AogG0/U+MYarZlskKDbnGOCqAcYXoTi7JQ=;
        b=TkKY8Wo2TR2vslPgLrfDiqv55QHRRtYCI23YZ7jzU5ouHd3zruC1mGDUp4VECowxyW
         WJwZmnNtqBOFuZGWJ/AbfxFJomVJ7vpIHxnpQ6aXiNwDeRlXrwlwWiQeMNz7yADR6AW4
         9+exFoOuOw6UHbWmljgVQBgbWtJbTLX9lPp5vnb1mW9KAKv/gaOxGlX2dFntbL2GgwEa
         XQTcEqHDh4oCVgorvdfsYZt5VHLIn0fq6LCgdiE8ej9somWlQ232QfeZ6yeUPQEjq2JN
         +fGQBoGEVvV7RfEHrUKDIBwIWqfp1ZVBXmh1bf0G05MaIks4x7MG8pBWZbkLIJoj/HgV
         BEFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714525627; x=1715130427;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tcU+VfO6+AogG0/U+MYarZlskKDbnGOCqAcYXoTi7JQ=;
        b=recOpl7h3elnh06A6OLcDrefkAUWZeLC+W+t0Us/DpiTscU6x8cdnD8LRpRCrP47ys
         lzpl78cwMAI5FaXVOgZ2Br/Mm5590NVBZVhJ+1hY1D4Shy8GPqgEAbeEdHn7tyvKyK1t
         +xz6jOiA5inJUITD76oaiiyZZ3CtJV6w2XZTcov2EHJYpZ7iGlmlJcPUTucDMgs8o3fV
         xduoVBSs5rXACFhnDtF5L0snnSSxw8nIDcPSoS0/aZgreBoIYSGV7njr1HhinGbxPeVV
         HvO6LQi+gxb/bqSLzDfAMRPpJypzp6xx6a+lnnVKFo7u/7UU/0et1vl6npb0+9ZktscY
         3mXA==
X-Forwarded-Encrypted: i=1; AJvYcCVLK8MIax51TXL8PKz4S0fTAD+Wb5mn9wggWvxkA2FDbue7VGx33jEPyldgh8+8etViv9RBHi+9ruJAjeerL5ZzsnP5ToVdcze0TCvy
X-Gm-Message-State: AOJu0Yw95GojSl94+08afJXyrCQ9g0L2imMrap+hMl/lSATMKK3+Pnsq
	uu/t4IDAoNQokx0Slt6zTetqht04A6r9D/2YxT93N6EAcKNffFxx8CzB9HcnFC8=
X-Google-Smtp-Source: AGHT+IG+zvA4w+KYmpOX/7bUCcOFPwX+LbaXgQxA20J4mF2ze0xds2HUmHwN6mEx8t4+KEIGrk0X8A==
X-Received: by 2002:a05:6870:1611:b0:22e:f3cd:b69e with SMTP id b17-20020a056870161100b0022ef3cdb69emr1259961oae.54.1714525626803;
        Tue, 30 Apr 2024 18:07:06 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id i6-20020a62c106000000b006ed0199bd57sm23320664pfg.177.2024.04.30.18.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 18:07:06 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1s1yR6-00GoDH-0h;
	Wed, 01 May 2024 11:07:04 +1000
Date: Wed, 1 May 2024 11:07:04 +1000
From: Dave Chinner <david@fromorbit.com>
To: John Garry <john.g.garry@oracle.com>
Cc: djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, chandan.babu@oracle.com,
	willy@infradead.org, axboe@kernel.dk, martin.petersen@oracle.com,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	tytso@mit.edu, jbongio@google.com, ojaswin@linux.ibm.com,
	ritesh.list@gmail.com, mcgrof@kernel.org, p.raghav@samsung.com,
	linux-xfs@vger.kernel.org, catherine.hoang@oracle.com
Subject: Re: [PATCH v3 14/21] iomap: Sub-extent zeroing
Message-ID: <ZjGVuBi6XeJYo4Ca@dread.disaster.area>
References: <20240429174746.2132161-1-john.g.garry@oracle.com>
 <20240429174746.2132161-15-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429174746.2132161-15-john.g.garry@oracle.com>

On Mon, Apr 29, 2024 at 05:47:39PM +0000, John Garry wrote:
> For FS_XFLAG_FORCEALIGN support, we want to treat any sub-extent IO like
> sub-fsblock DIO, in that we will zero the sub-extent when the mapping is
> unwritten.
> 
> This will be important for atomic writes support, in that atomically
> writing over a partially written extent would mean that we would need to
> do the unwritten extent conversion write separately, and the write could
> no longer be atomic.
> 
> It is the task of the FS to set iomap.extent_size per iter to indicate
> sub-extent zeroing required.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>

Shouldn't this be done before the XFS feature is enabled in the
series?

> ---
>  fs/iomap/direct-io.c  | 17 +++++++++++------
>  include/linux/iomap.h |  1 +
>  2 files changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index f3b43d223a46..a3ed7cfa95bc 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -277,7 +277,7 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>  {
>  	const struct iomap *iomap = &iter->iomap;
>  	struct inode *inode = iter->inode;
> -	unsigned int fs_block_size = i_blocksize(inode), pad;
> +	unsigned int zeroing_size, pad;
>  	loff_t length = iomap_length(iter);
>  	loff_t pos = iter->pos;
>  	blk_opf_t bio_opf;
> @@ -288,6 +288,11 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>  	size_t copied = 0;
>  	size_t orig_count;
>  
> +	if (iomap->extent_size)
> +		zeroing_size = iomap->extent_size;
> +	else
> +		zeroing_size = i_blocksize(inode);

Oh, the dissonance!

iomap->extent_size isn't an extent size at all.

The size of the extent the iomap returns is iomap->length. This new
variable is the IO specific "block size" that should be assumed by
the dio code to determine if padding should be done.

IOWs, I think we should add an "io_block_size" field to the iomap,
and every filesystem that supports iomap should set it to the
filesystem block size (i_blocksize(inode)). Then the changes to the
iomap code end up just being:


-	unsigned int fs_block_size = i_blocksize(inode), pad;
+	unsigned int fs_block_size = iomap->io_block_size, pad;

And the patch that introduces that infrastructure change will also
change all the filesystem implementations to unconditionally set
iomap->io_block_size to i_blocksize().

Then, in a separate patch, you can add XFS support for large IO
block sizes when we have either a large rtextsize or extent size
hints set.

> +
>  	if ((pos | length) & (bdev_logical_block_size(iomap->bdev) - 1) ||
>  	    !bdev_iter_is_aligned(iomap->bdev, dio->submit.iter))
>  		return -EINVAL;
> @@ -354,8 +359,8 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>  		dio->iocb->ki_flags &= ~IOCB_HIPRI;
>  
>  	if (need_zeroout) {
> -		/* zero out from the start of the block to the write offset */
> -		pad = pos & (fs_block_size - 1);
> +		/* zero out from the start of the region to the write offset */
> +		pad = pos & (zeroing_size - 1);
>  		if (pad)
>  			iomap_dio_zero(iter, dio, pos - pad, pad);
>  	}
> @@ -428,10 +433,10 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>  zero_tail:
>  	if (need_zeroout ||
>  	    ((dio->flags & IOMAP_DIO_WRITE) && pos >= i_size_read(inode))) {
> -		/* zero out from the end of the write to the end of the block */
> -		pad = pos & (fs_block_size - 1);
> +		/* zero out from the end of the write to the end of the region */
> +		pad = pos & (zeroing_size - 1);
>  		if (pad)
> -			iomap_dio_zero(iter, dio, pos, fs_block_size - pad);
> +			iomap_dio_zero(iter, dio, pos, zeroing_size - pad);
>  	}
>  out:
>  	/* Undo iter limitation to current extent */
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 6fc1c858013d..42623b1cdc04 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -97,6 +97,7 @@ struct iomap {
>  	u64			length;	/* length of mapping, bytes */
>  	u16			type;	/* type of mapping */
>  	u16			flags;	/* flags for mapping */
> +	unsigned int		extent_size;

This needs a descriptive comment. At minimum, it should tell the
reader what units are used for the variable.  If it is bytes, then
it needs to be a u64, because XFS can have extent size hints well
beyond 2^32 bytes in length.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

