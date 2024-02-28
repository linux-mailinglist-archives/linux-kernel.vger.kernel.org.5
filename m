Return-Path: <linux-kernel+bounces-85785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF9A86BAB5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 23:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 680F31C245EC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 22:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB997003E;
	Wed, 28 Feb 2024 22:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="HOvcpvfA"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEB11361C7
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 22:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709159136; cv=none; b=eGdmtKgRR61+rlV74K2k92I11IIWKPSSJQMuxYFgRr65kxeaNSi36/wi9GoxIjpXbGkWSgl7TMcOelvhTBufQ4GyQVORCN83GZrALsfBtjK5RSabC/WLPR3Wn6kcJvOHzzz681MO0lB/EJYD+htjosCyJsgAWOsoDVVg2AFJd7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709159136; c=relaxed/simple;
	bh=GzzBfFXq8DsJKZ7yjt15gkiOV0b4KSzd+/jDzZL3JbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BACuJYC/dBMsrF3L3fEduUzG/CTNeur89WU9W5WgBzgXBcZd7Vs5GufI+eTVyX/jaRFY3FGiFtby2vufC47b4UysWTeUJn4cTuByxrdRlcDVum+IO0OiEDEjP+BHjOZ/AOknReaksvODi59mq9XNYC8otMx8oQTWbt/wpczLKew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=HOvcpvfA; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1dc139ed11fso12345925ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 14:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1709159132; x=1709763932; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oOujcwe/BF6OoLMFzWGriAndnvAMZ6SmsxufNb6baEU=;
        b=HOvcpvfAg0JfZ40738JRt+uDtxFKIX/+fgWZuxe5S7giBoCXZLui18G4muwveQoMcT
         BMDbOm3FH2UJsxGYmlSNPEqyzqCaigW/gxg/T/JSw2tv0kotM83aUFeFtzvUiT4rotmO
         Y/vSAKm3t+oxfr97bEwZSo3uXea3luDDwGgEV/QtfFIVwErLtksYZlTPLDwjTnRE5MYE
         Uh86Aai/FPoH+nq6ESgJTsjfkK3qwBYN0K+VWk86/uMyOV39fNlElIKjG+VQIgzwokM5
         JCzMrUxTQ/fsP0/SkO3JJko3n9Cap5g/WmsNAnJsQSsv8SrEsB6JZiinxRep0ui5IGD/
         iloA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709159132; x=1709763932;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oOujcwe/BF6OoLMFzWGriAndnvAMZ6SmsxufNb6baEU=;
        b=ipRk8Etv8MqIwdIeHblgHlJLQBNQ2KqzdbMS93QX7u55bf/gC7NTuCWCVG73jXg2jc
         hK0uIFxDtX7W8OMP9gIyC6bQ2RkHW+PbZN6gWCvrXOVT9do5ufx4X1uYkij4B8wO2Zmc
         bCCbhpxviMs64sWa0jDgGO/v4gVRk1o5LYYAnQ4oN5j7u4KyMd4EUIGwVXGnDOMInrln
         mDLXRlvfF93M7wBdBVrukqeh1wCFzNGKt0T0cNLd0dE/Y0wErENQht5ElqwJxTXJ+59/
         /2SGOusVP2U0FiTXm6EVORWbHK0ulEC68PIhrG1sAiAOuhApQKv0njZsyCI+GN+qULOd
         ZwIQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+4hssS37NIaMsv4yZLcFqF4mWhcirMkw9jBTEYP3UFphkpuqFRyU3N6ZiyhKBeULKdkomWnKKqGFRERYkN7PcRqQqlZQi6w3yKr4A
X-Gm-Message-State: AOJu0YyESRDUqXvKBLNmEwFd8fzOuFV/hmQ/UAqyIGTwENZ+DSVSboEc
	GkDJSiEVly6qfWEhTG676upi5feAhWU75eqmmGLc1DapL7vkLnQZKika/WicylA=
X-Google-Smtp-Source: AGHT+IHqQy0+vejFYNP5aALqSGIqnuDR7yU2CVlkZ7BMVbeUnEFC6Oq62NF/rLHwF+0GS7yyR0VfVQ==
X-Received: by 2002:a17:902:c403:b0:1dc:6b26:d1cd with SMTP id k3-20020a170902c40300b001dc6b26d1cdmr153477plk.2.1709159132460;
        Wed, 28 Feb 2024 14:25:32 -0800 (PST)
Received: from dread.disaster.area (pa49-181-247-196.pa.nsw.optusnet.com.au. [49.181.247.196])
        by smtp.gmail.com with ESMTPSA id jy13-20020a17090342cd00b001dc11f90512sm3765505plb.126.2024.02.28.14.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 14:25:31 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rfSMj-00CqUC-0S;
	Thu, 29 Feb 2024 09:25:29 +1100
Date: Thu, 29 Feb 2024 09:25:29 +1100
From: Dave Chinner <david@fromorbit.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: Christoph Hellwig <hch@infradead.org>, djwong@kernel.org,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
	jack@suse.cz, ritesh.list@gmail.com, willy@infradead.org,
	zokeefe@google.com, yi.zhang@huawei.com, chengzhihao1@huawei.com,
	yukuai3@huawei.com, wangkefeng.wang@huawei.com
Subject: Re: [RFC PATCH v3 07/26] iomap: don't increase i_size if it's not a
 write operation
Message-ID: <Zd+y2VP8HpbkDu41@dread.disaster.area>
References: <20240127015825.1608160-1-yi.zhang@huaweicloud.com>
 <20240127015825.1608160-8-yi.zhang@huaweicloud.com>
 <ZcsCP4h-ExNOcdD6@infradead.org>
 <9b0040ef-3d9d-6246-4bdd-82b9a8f55fa2@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9b0040ef-3d9d-6246-4bdd-82b9a8f55fa2@huaweicloud.com>

On Wed, Feb 28, 2024 at 04:53:32PM +0800, Zhang Yi wrote:
> On 2024/2/13 13:46, Christoph Hellwig wrote:
> > Wouldn't it make more sense to just move the size manipulation to the
> > write-only code?  An untested version of that is below.  With this
> > the naming of the status variable becomes even more confusing than
> > it already is, maybe we need to do a cleanup of the *_write_end
> > calling conventions as it always returns the passed in copied value
> > or 0.
> > 
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > index 3dab060aed6d7b..8401a9ca702fc0 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -876,34 +876,13 @@ static size_t iomap_write_end(struct iomap_iter *iter, loff_t pos, size_t len,
> >  		size_t copied, struct folio *folio)
> >  {
> >  	const struct iomap *srcmap = iomap_iter_srcmap(iter);
> > -	loff_t old_size = iter->inode->i_size;
> > -	size_t ret;
> > -
> > -	if (srcmap->type == IOMAP_INLINE) {
> > -		ret = iomap_write_end_inline(iter, folio, pos, copied);
> > -	} else if (srcmap->flags & IOMAP_F_BUFFER_HEAD) {
> > -		ret = block_write_end(NULL, iter->inode->i_mapping, pos, len,
> > -				copied, &folio->page, NULL);
> > -	} else {
> > -		ret = __iomap_write_end(iter->inode, pos, len, copied, folio);
> > -	}
> > -
> > -	/*
> > -	 * Update the in-memory inode size after copying the data into the page
> > -	 * cache.  It's up to the file system to write the updated size to disk,
> > -	 * preferably after I/O completion so that no stale data is exposed.
> > -	 */
> > -	if (pos + ret > old_size) {
> > -		i_size_write(iter->inode, pos + ret);
> > -		iter->iomap.flags |= IOMAP_F_SIZE_CHANGED;
> > -	}
> 
> I've recently discovered that if we don't increase i_size in
> iomap_zero_iter(), it would break fstests generic/476 on xfs. xfs
> depends on iomap_zero_iter() to increase i_size in some cases.
> 
>  generic/476 75s ... _check_xfs_filesystem: filesystem on /dev/pmem2 is inconsistent (r)
>  (see /home/zhangyi/xfstests-dev/results//xfs/generic/476.full for details)
> 
>  _check_xfs_filesystem: filesystem on /dev/pmem2 is inconsistent (r)
>  *** xfs_repair -n output ***
>  Phase 1 - find and verify superblock...
>  Phase 2 - using internal log
>          - zero log...
>          - scan filesystem freespace and inode maps...
>  sb_fdblocks 10916, counted 10923
>          - found root inode chunk
>  ...
> 
> After debugging and analysis, I found the root cause of the problem is
> related to the pre-allocations of xfs. xfs pre-allocates some blocks to
> reduce fragmentation during buffer append writing, then if we write new
> data or do file copy(reflink) after the end of the pre-allocating range,
> xfs would zero-out and write back the pre-allocate space(e.g.
> xfs_file_write_checks() -> xfs_zero_range()), so we have to update
> i_size before writing back in iomap_zero_iter(), otherwise, it will
> result in stale delayed extent.

Ok, so this is long because the example is lacking in clear details
so to try to understand it I've laid it out in detail to make sure
I've understood it correctly.

> 
> For more details, let's think about this case,
> 1. Buffered write from range [A, B) of an empty file foo, and
>    xfs_buffered_write_iomap_begin() prealloc blocks for it, then create
>    a delayed extent from [A, D).

So we have a delayed allocation extent  and the file size is now B
like so:

	A                      B                    D
	+DDDDDDDDDDDDDDDDDDDDDD+dddddddddddddddddddd+
	                      EOF
			  (in memory)

where 'd' is a delalloc block with no data and 'D' is a delalloc
block with dirty folios over it.

> 2. Write back process map blocks but only convert above delayed extent
>    from [A, C) since the lack of a contiguous physical blocks, now we
>    have a left over delayed extent from [C, D), and the file size is B.

So this produces:

	A          C           B                    D
	+wwwwwwwwww+DDDDDDDDDDD+dddddddddddddddddddd+
	          EOF         EOF
               (on disk)  (in memory)

where 'w' contains allocated written data blocks.

> 3. Copy range from another file to range [E, F), then
>    xfs_reflink_zero_posteof() would zero-out post eof range [B, E), it
>    writes zero, dirty and write back [C, E).

I'm going to assume that [E,F) is located like this because you
are talking about post-eof zeroing from B to E:

	A          C           B     E       F      D
	+wwwwwwwwww+DDDDDDDDDDD+ddddd+rrrrrrr+dddddd+
	          EOF         EOF
               (on disk)  (in memory)

where 'r' is the clone destination over dellaloc blocks.

Did I get that right?

And so reflink wants to zero [B,E] before it updates the file size,
just like a truncate(E) would. iomap_zero_iter() will see a delalloc
extent (IOMAP_DELALLOC) for [B,E], so it will write zeros into cache
for it. We then have:

	A          C           B     E       F      D
	+wwwwwwwwww+DDDDDDDDDDD+ZZZZZ+rrrrrrr+dddddd+
	          EOF         EOF
               (on disk)  (in memory)

where 'Z' is delalloc blocks with zeroes in cache.

Because the destination is post EOF, xfs_reflink_remap_prep() then
does:

        /*
         * If pos_out > EOF, we may have dirtied blocks between EOF and
         * pos_out. In that case, we need to extend the flush and unmap to cover
         * from EOF to the end of the copy length.
         */
        if (pos_out > XFS_ISIZE(dest)) {
                loff_t  flen = *len + (pos_out - XFS_ISIZE(dest));
                ret = xfs_flush_unmap_range(dest, XFS_ISIZE(dest), flen);
	} ....

Which attempts to flush from the current in memory EOF up to the end
of the clone destination range. This should result in:

	A          C           B     E       F      D
	+wwwwwwwwww+DDDDDDDDDDD+zzzzz+rrrrrrr+dddddd+
	          EOF         EOF
               (on disk)  (in memory)

Where 'z' is zeroes on disk.

Have I understood this correctly?

However, if this did actually write zeroes to disk, this would end
up with:

	A          C           B     E       F      D
	+wwwwwwwwww+DDDDDDDDDDD+zzzzz+rrrrrrr+dddddd+
	                      EOF   EOF
                      (in memory)   (on disk)

Which is wrong - the file extension and zeros should not get exposed
to the user until the entire reflink completes. This would expose
zeros at the EOF and a file size that the user never asked for after
a crash. Experience tells me that they would report this as
"filesystem corrupting data on crash".

If we move where i_size gets updated by iomap_zero_iter(), we get:

	A          C           B     E       F      D
	+wwwwwwwwww+DDDDDDDDDDD+zzzzz+rrrrrrr+dddddd+
	                            EOF
                                (in memory)
		                 (on disk)

Which is also wrong, because now the user can see the size change
and read zeros in the middle of the clone operation, which is also
wrong.

IOWs, we do not want to move the in-memory or on-disk EOF as a
result of zeroing delalloc extents beyond EOF as it opens up
transient, non-atomic on-disk states in the event of a crash.

So, catch-22: we need to move the in-memory EOF to write back zeroes
beyond EOF, but that would move the on-disk EOF to E before the
clone operation starts. i.e. it makes clone non-atomic.

What should acutally result from the iomap_zero_range() call from
xfs_reflink_remap_prep() is a state like this:

	A          C           B     E       F      D
	+wwwwwwwwww+DDDDDDDDDDD+uuuuu+rrrrrrr+dddddd+
	          EOF         EOF
               (on disk)  (in memory)

where 'u' are unwritten extent blocks.

i.e. instead of writing zeroes through the page cache for
IOMAP_DELALLOC ranges beyond EOF, we should be converting those
ranges to unwritten and invalidating any cached data over that range
beyond EOF.

IOWs, it looks to me like the problem is that
xfs_buffered_write_iomap_begin() is doing the wrong thing for
IOMAP_ZERO operations for post-EOF regions spanned by speculative
delalloc. It should be converting the region to unwritten so it has
zeroes on disk, not relying on the page cache to be able to do
writeback beyond the current EOF....

> 4. Since we don't update i_size in iomap_zero_iter()，the writeback
>    doesn't write anything back, also doesn't convert the delayed extent.
>    After copy range, the file size will update to F.

Yup, this is all, individually, correct behaviour. But when put
together, the wrong thing happens. I suspect xfs_zero_range() needs
to provide a custom set of iomap_begin/end callbacks rather than
overloading the normal buffered write mechanisms.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

