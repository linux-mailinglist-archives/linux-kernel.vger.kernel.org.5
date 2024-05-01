Return-Path: <linux-kernel+bounces-164850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8F48B83F5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 03:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE98E1C21E44
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 01:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1567522A;
	Wed,  1 May 2024 01:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="1+OV8jIb"
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5B946BA
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 01:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714527126; cv=none; b=eRfjwfVr4Wz13T64uGxcYo3v0rbzQej7vs2PZdHQj42lbnchmkhLFqLx2ICIbbUcZJHCEiAJ5bcK7pDjno4wjvoa9U23CHjUfFnpc2tTSmb4EwpDA0f9r99ivMqcC3ohRMUlix4hvdR8p+gYZivaGHHcC2ZWNF8PM9cGqTGHEoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714527126; c=relaxed/simple;
	bh=nNA/+5lUlX8TZ8Hrv3FoOYIRmlTOzjp/ZOYWxKwxduc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dB+kgIZXQua8Ng/GpztL6UFXusqxfrU38CsvGTYk/d5/+vRV4TI0+Z85+7MdNuweYshz+oeRr7FHVcebe0YNLUxvxmtTT7baWzPTChNDqHglelTVeeZL8QtwpiYp0hvnSIEiUc232ZqhVX12AUYSOBkg1sf49rxk6uvYVilKujo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=1+OV8jIb; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5aa400b917dso4121565eaf.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 18:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1714527124; x=1715131924; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KM7Hd5zki3USqEbBfz9TXSdoSf1EQG0WzU/UqVvexrQ=;
        b=1+OV8jIbYG66pZUK2m8IEQwBn5oVX6u5ZhY8tP/EIrnrCsEkWop/7yOIkM/+5SFJ/S
         N7mJCaNT5/m/VZDZG4VS54WhLNRVYlivJPx0Z9BwmpS+AAOJ1COCJT754NtxTsXJnQ7O
         8UDilEVIa1VsvMJQvc2Jc71llQj05GbEoq88v3BUjPcLB0Q0q/NfTb7cx+0tqHo0vMKl
         LZrmUCAi4JnpYnDoRUEKI9x9eEPu0KYY9lOXQA4lq4Y7dXN2xndg+X2BP8YE281XEZ9K
         BSFbrJbZfweqbjTZKiXc7ZTbqb6kC3kgAW7cygSErGHV0QXj4VDJrhtFNEbZrZNawan/
         g6HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714527124; x=1715131924;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KM7Hd5zki3USqEbBfz9TXSdoSf1EQG0WzU/UqVvexrQ=;
        b=MgZfBCwuS63SK1Fpm4932WV9kHcFzGrA4NSGmkFWiKecVXUk071TZSGYyAtBtdMgJS
         XTdql/Tz9mQa44zQvZ1lYbCef8K0Rs+ioIbzH6LCaWXbQKzYxar8AiTyM75clXbHn7oR
         UVaaQcGf360LkAmF7m9XXG3O42FaJebTaSEyAgKa/2PeGUKqhVQmHcQ7+bDWxa5j1y1G
         O6aupzhx8sfae5bj7EssXexh4oKzduqZz9H3OlQzmO1IuAn1992QxO6Kl/1OO+HWt7ax
         jwejWBwqn++0Yk1X8nJYRdchQdn++cj7gLMq5a5E7TFS82GsAx138RWOplBAsan38LdI
         H5tA==
X-Forwarded-Encrypted: i=1; AJvYcCURaCPDuS7Vv/KCI6b+HtE4mmQChGTrweAK5sX0sL+6UKn8jdWFYO2GF2GF0u9AQMXUjFxRsDkm+/roPJ6OgSSAsNl1WJcr5q4N+0IX
X-Gm-Message-State: AOJu0YzCcHE01NzBpk5NDZQipvteuRbt54VYuUqbsi6r63wSRFKSvpJz
	DLwDya9VsYb7I2N5kwq4VLs9tbgAP2xN/ps1v0mkws4eLmtwr6L1Jc6MOm6Ly4E=
X-Google-Smtp-Source: AGHT+IEAQ8njw5Xk9bQwmGDIxl6ZK6d3U3YkxZ7bTcibYCg1oYT8UUm8HvkrTms16QE9uu7PwRaMpA==
X-Received: by 2002:a05:6358:887:b0:17e:b867:cb99 with SMTP id m7-20020a056358088700b0017eb867cb99mr1868688rwj.1.1714527123767;
        Tue, 30 Apr 2024 18:32:03 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id y124-20020a636482000000b006109431806dsm6349949pgb.92.2024.04.30.18.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 18:32:03 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1s1ypE-00GpU1-0H;
	Wed, 01 May 2024 11:32:00 +1000
Date: Wed, 1 May 2024 11:32:00 +1000
From: Dave Chinner <david@fromorbit.com>
To: John Garry <john.g.garry@oracle.com>
Cc: djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, chandan.babu@oracle.com,
	willy@infradead.org, axboe@kernel.dk, martin.petersen@oracle.com,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	tytso@mit.edu, jbongio@google.com, ojaswin@linux.ibm.com,
	ritesh.list@gmail.com, mcgrof@kernel.org, p.raghav@samsung.com,
	linux-xfs@vger.kernel.org, catherine.hoang@oracle.com
Subject: Re: [PATCH v3 15/21] fs: xfs: iomap: Sub-extent zeroing
Message-ID: <ZjGbkAuGj0MhXAZ/@dread.disaster.area>
References: <20240429174746.2132161-1-john.g.garry@oracle.com>
 <20240429174746.2132161-16-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429174746.2132161-16-john.g.garry@oracle.com>

On Mon, Apr 29, 2024 at 05:47:40PM +0000, John Garry wrote:
> Set iomap->extent_size when sub-extent zeroing is required.
> 
> We treat a sub-extent write same as an unaligned write, so we can leverage
> the existing sub-FSblock unaligned write support, i.e. try a shared lock
> with IOMAP_DIO_OVERWRITE_ONLY flag, if this fails then try the exclusive
> lock.
> 
> In xfs_iomap_write_unwritten(), FSB calcs are now based on the extsize.

If forcedalign is set, should we just reject unaligned DIOs?

....
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  fs/xfs/xfs_file.c  | 35 ++++++++++++++++++++++-------------
>  fs/xfs/xfs_iomap.c | 13 +++++++++++--
>  2 files changed, 33 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index e81e01e6b22b..ee4f94cf6f4e 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -620,18 +620,19 @@ xfs_file_dio_write_aligned(
>   * Handle block unaligned direct I/O writes

 * Handle unaligned direct IO writes.

>   *
>   * In most cases direct I/O writes will be done holding IOLOCK_SHARED, allowing
> - * them to be done in parallel with reads and other direct I/O writes.  However,
> - * if the I/O is not aligned to filesystem blocks, the direct I/O layer may need
> - * to do sub-block zeroing and that requires serialisation against other direct
> - * I/O to the same block.  In this case we need to serialise the submission of
> - * the unaligned I/O so that we don't get racing block zeroing in the dio layer.
> - * In the case where sub-block zeroing is not required, we can do concurrent
> - * sub-block dios to the same block successfully.
> + * them to be done in parallel with reads and other direct I/O writes.
> + * However if the I/O is not aligned to filesystem blocks/extent, the direct
> + * I/O layer may need to do sub-block/extent zeroing and that requires
> + * serialisation against other direct I/O to the same block/extent.  In this
> + * case we need to serialise the submission of the unaligned I/O so that we
> + * don't get racing block/extent zeroing in the dio layer.
> + * In the case where sub-block/extent zeroing is not required, we can do
> + * concurrent sub-block/extent dios to the same block/extent successfully.
>   *
>   * Optimistically submit the I/O using the shared lock first, but use the
>   * IOMAP_DIO_OVERWRITE_ONLY flag to tell the lower layers to return -EAGAIN
> - * if block allocation or partial block zeroing would be required.  In that case
> - * we try again with the exclusive lock.
> + * if block/extent allocation or partial block/extent zeroing would be
> + * required.  In that case we try again with the exclusive lock.

Rather than changing every "block" to "block/extent", leave the bulk
of the comment unchanged and add another paragraph to it that says
something like:

 * If forced extent alignment is turned on, then serialisation
 * constraints are extended from filesystem block alignment
 * to extent alignment boundaries. In this case, we treat any
 * non-extent-aligned DIO the same as a sub-block DIO.

>   */
>  static noinline ssize_t
>  xfs_file_dio_write_unaligned(
> @@ -646,9 +647,9 @@ xfs_file_dio_write_unaligned(
>  	ssize_t			ret;
>  
>  	/*
> -	 * Extending writes need exclusivity because of the sub-block zeroing
> -	 * that the DIO code always does for partial tail blocks beyond EOF, so
> -	 * don't even bother trying the fast path in this case.
> +	 * Extending writes need exclusivity because of the sub-block/extent
> +	 * zeroing that the DIO code always does for partial tail blocks
> +	 * beyond EOF, so don't even bother trying the fast path in this case.
>  	 */
>  	if (iocb->ki_pos > isize || iocb->ki_pos + count >= isize) {
>  		if (iocb->ki_flags & IOCB_NOWAIT)
> @@ -714,11 +715,19 @@ xfs_file_dio_write(
>  	struct xfs_inode	*ip = XFS_I(file_inode(iocb->ki_filp));
>  	struct xfs_buftarg      *target = xfs_inode_buftarg(ip);
>  	size_t			count = iov_iter_count(from);
> +	struct xfs_mount	*mp = ip->i_mount;
> +	unsigned int		blockmask;
>  
>  	/* direct I/O must be aligned to device logical sector size */
>  	if ((iocb->ki_pos | count) & target->bt_logical_sectormask)
>  		return -EINVAL;
> -	if ((iocb->ki_pos | count) & ip->i_mount->m_blockmask)
> +
> +	if (xfs_inode_has_forcealign(ip) && ip->i_extsize > 1)
> +		blockmask = XFS_FSB_TO_B(mp, ip->i_extsize) - 1;
> +	else
> +		blockmask = mp->m_blockmask;

	alignmask = XFS_FSB_TO_B(mp, xfs_inode_alignment(ip)) - 1;

Note that this would consider sub rt_extsize IO as unaligned, which
may be undesirable. In that case, we should define a second helper
such as xfs_inode_io_alignment() that doesn't take into account RT
extent sizes because we can still do filesystem block sized
unwritten extent conversion on those devices. The same IO-specific
wrapper would be used for the other cases in this patch, too.

> +
> +	if ((iocb->ki_pos | count) & blockmask)
>  		return xfs_file_dio_write_unaligned(ip, iocb, from);
>  	return xfs_file_dio_write_aligned(ip, iocb, from);
>  }
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index 4087af7f3c9f..1a3692bbc84d 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -138,6 +138,8 @@ xfs_bmbt_to_iomap(
>  
>  	iomap->validity_cookie = sequence_cookie;
>  	iomap->folio_ops = &xfs_iomap_folio_ops;
> +	if (xfs_inode_has_forcealign(ip) && ip->i_extsize > 1)
> +		iomap->extent_size = XFS_FSB_TO_B(mp, ip->i_extsize);

	iomap->io_block_size = XFS_FSB_TO_B(mp, xfs_inode_alignment(ip));

>  	return 0;
>  }
>  
> @@ -570,8 +572,15 @@ xfs_iomap_write_unwritten(
>  
>  	trace_xfs_unwritten_convert(ip, offset, count);
>  
> -	offset_fsb = XFS_B_TO_FSBT(mp, offset);
> -	count_fsb = XFS_B_TO_FSB(mp, (xfs_ufsize_t)offset + count);
> +	if (xfs_inode_has_forcealign(ip) && ip->i_extsize > 1) {
> +		xfs_extlen_t extsize_bytes = mp->m_sb.sb_blocksize * ip->i_extsize;
> +
> +		offset_fsb = XFS_B_TO_FSBT(mp, round_down(offset, extsize_bytes));
> +		count_fsb = XFS_B_TO_FSB(mp, round_up(offset + count, extsize_bytes));
> +	} else {
> +		offset_fsb = XFS_B_TO_FSBT(mp, offset);
> +		count_fsb = XFS_B_TO_FSB(mp, (xfs_ufsize_t)offset + count);
> +	}

More places we can use a xfs_inode_alignment() helper.

	offset_fsb = XFS_B_TO_FSBT(mp, offset);
	count_fsb = XFS_B_TO_FSB(mp, (xfs_ufsize_t)offset + count);
	rounding = XFS_FSB_TO_B(mp, xfs_inode_alignment(ip));
	if (rounding > 1) {
		 offset_fsb = rounddown_64(offset_fsb, rounding);
		 count_fsb = roundup_64(count_fsb, rounding);
	}

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

