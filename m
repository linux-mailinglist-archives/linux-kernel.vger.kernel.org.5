Return-Path: <linux-kernel+bounces-164839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 699148B83D4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 02:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 973381C22842
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 00:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBFF74C83;
	Wed,  1 May 2024 00:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="BnqI8ZTp"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0C74C66
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 00:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714524815; cv=none; b=DkhOgRjzkpJWFnbByP+PQGDE7KFx1RpRMAb+MlkYxAoaB+bK7D+WYdVG8HXhIo8HZZiKjL+0NyvlOZ1ppLo/OiCTbkY3JrPspoJn5eVyEYgo4TE+ePrMt8DqE/J382OPMbAh9O/r4QqhZ0ZYqgQf6PXHWdiT/Q3bf5Jvo7qqVsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714524815; c=relaxed/simple;
	bh=MDzDjSaA1/WpmCCAzCXM2+Luq9xOpdvAzwI6pGAgE+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uh+3gym2AbDe1Tz5vXl9lqIm62wdR++nvePaFhni8evvDlO8GUJbA6k4my63AdCaOpXymrsA4tKtdnXt0Jfmp4CaDXBudqgPvS4K0nkJJEEaqNR/l3US359quQJi4eEu7w7HQCV0LwbLY+I5Ky81p77NJrczoP86lRVILNpfU9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=BnqI8ZTp; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1ec69e3dbcfso7924715ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 17:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1714524812; x=1715129612; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AGLi6nbOQ03oujc7OG5PvbXaIns/xPkQnLtcmi6hQCc=;
        b=BnqI8ZTpdx3iE5LE27Q1tLaqSLSfLaIWQqPhPPY5PBvWzsmnHIYUJw7fQGOzeXYXQq
         0tgxCRbd07dIqunH3uWGcewSy9SkrpgFbLpHzk1LsDDo/NvGKcwK09hP/ZeTq6fQ4DnH
         8SCpnyK0tFSypLGv+5eR5wdwnF7iPHYRRwx2R6dRnBhdHuoFFjiW5b9jxM8Sn2UINqSo
         GmmzOqAzhQ0IojHNQz1O7H1j6WStlUwv22CZWo639AGngX3feK1LpPixMmChLvtgF9XZ
         E4uuQr+WUlxj6/lEvvRqlCx47vgtIUsHYCRFTGEl1MdTDjK39Gq3N+rKK5gpEv1ziRVa
         k+Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714524812; x=1715129612;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AGLi6nbOQ03oujc7OG5PvbXaIns/xPkQnLtcmi6hQCc=;
        b=CH6pY7eyUEthBIRIOI2PoYC/KpgyHHMCwUhfW1UTvMnOFZ1gcs3vPJ8b4ChafT27Z8
         wwiqDvFwM5Tarpkg8MBEkProbkuQqAzX9Fs+KOmZ79DNa7kR0oCqk2Vug4pHf+g+OkUP
         zkENMiV14f16kkmdOqqXCdpm3AHjvuWC5slzNjyl4UNDbTFeUs/W0ijjKSbNRd1lpM47
         AubaBRkCEykYH4KD0xYdD/etGRR1LlJOUnFHbY4aOaD15/rB/udStL71i9K3vWudce3u
         BdmMwwX0gqyOgITrh1AuttFXxFN20ccvYiYH+YXQuqrLQVHs0MEXaWY0TAQrDjOg855w
         36wA==
X-Forwarded-Encrypted: i=1; AJvYcCVq8wGK+zPxNfm3m2QsgV4AaK+RSU8M10DMV1xtPr2Cw2UXH11ze2ebRjCogpKREjekrRTD7Efebm0Q1SqBHDYzb+Ct1Czv+6erX0Ge
X-Gm-Message-State: AOJu0YzJqeb6ImiXvhrl1bfh0nTsCHJw+xrTqxqYdcZ8q778cHwPvWP/
	kS3vxYom8GcLpi4HBJWN5Ddug24nmEKaAxASlEP9wvY9+216kQU+dxSDYTYknOs=
X-Google-Smtp-Source: AGHT+IEcjKeGPxGhskLd8MVp4LvWIcfr6LSxhM+g0y29FpuVsAo7RcPCoihhteq0i/ufZpW41gNqOg==
X-Received: by 2002:a17:902:da8e:b0:1e4:3b58:7720 with SMTP id j14-20020a170902da8e00b001e43b587720mr1157220plx.2.1714524812077;
        Tue, 30 Apr 2024 17:53:32 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id c6-20020a170902d48600b001eb4a71cb58sm7345268plg.114.2024.04.30.17.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 17:53:31 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1s1yDw-00GnPV-2z;
	Wed, 01 May 2024 10:53:28 +1000
Date: Wed, 1 May 2024 10:53:28 +1000
From: Dave Chinner <david@fromorbit.com>
To: John Garry <john.g.garry@oracle.com>
Cc: djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, chandan.babu@oracle.com,
	willy@infradead.org, axboe@kernel.dk, martin.petersen@oracle.com,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	tytso@mit.edu, jbongio@google.com, ojaswin@linux.ibm.com,
	ritesh.list@gmail.com, mcgrof@kernel.org, p.raghav@samsung.com,
	linux-xfs@vger.kernel.org, catherine.hoang@oracle.com
Subject: Re: [PATCH RFC v3 12/21] xfs: Only free full extents for forcealign
Message-ID: <ZjGSiOt21g5JCOhf@dread.disaster.area>
References: <20240429174746.2132161-1-john.g.garry@oracle.com>
 <20240429174746.2132161-13-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429174746.2132161-13-john.g.garry@oracle.com>

On Mon, Apr 29, 2024 at 05:47:37PM +0000, John Garry wrote:
> Like we already do for rtvol, only free full extents for forcealign in
> xfs_free_file_space().
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  fs/xfs/xfs_bmap_util.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
> index f26d1570b9bd..1dd45dfb2811 100644
> --- a/fs/xfs/xfs_bmap_util.c
> +++ b/fs/xfs/xfs_bmap_util.c
> @@ -847,8 +847,11 @@ xfs_free_file_space(
>  	startoffset_fsb = XFS_B_TO_FSB(mp, offset);
>  	endoffset_fsb = XFS_B_TO_FSBT(mp, offset + len);
>  
> -	/* We can only free complete realtime extents. */
> -	if (XFS_IS_REALTIME_INODE(ip) && mp->m_sb.sb_rextsize > 1) {
> +	/* Free only complete extents. */
> +	if (xfs_inode_has_forcealign(ip) && ip->i_extsize > 1) {
> +		startoffset_fsb = roundup_64(startoffset_fsb, ip->i_extsize);
> +		endoffset_fsb = rounddown_64(endoffset_fsb, ip->i_extsize);
> +	} else if (XFS_IS_REALTIME_INODE(ip) && mp->m_sb.sb_rextsize > 1) {
>  		startoffset_fsb = xfs_rtb_roundup_rtx(mp, startoffset_fsb);
>  		endoffset_fsb = xfs_rtb_rounddown_rtx(mp, endoffset_fsb);
>  	}

When you look at xfs_rtb_roundup_rtx() you'll find it's just a one
line wrapper around roundup_64().

So lets get rid of the obfuscation that the one line RT wrapper
introduces, and it turns into this:

	rounding = 1;
	if (xfs_inode_has_forcealign(ip)
		rounding = ip->i_extsize;
	else if (XFS_IS_REALTIME_INODE(ip))
		rounding = mp->m_sb.sb_rextsize;

	if (rounding > 1) {
		startoffset_fsb = roundup_64(startoffset_fsb, rounding);
		endoffset_fsb = rounddown_64(endoffset_fsb, rounding);
	}

What this points out is that the prep steps for fallocate operations
also need to handle both forced alignment and rtextsize rounding,
and it does neither right now.  xfs_flush_unmap_range() is the main
offender here, but xfs_prepare_shift() also needs fixing.

Hence:

static inline xfs_extlen_t
xfs_extent_alignment(
	struct xfs_inode	*ip)
{
	if (xfs_inode_has_forcealign(ip))
		return ip->i_extsize;
	if (XFS_IS_REALTIME_INODE(ip))
		return mp->m_sb.sb_rextsize;
	return 1;
}


In xfs_flush_unmap_range():

	/*
	 * Make sure we extend the flush out to extent alignment
	 * boundaries so any extent range overlapping the start/end
	 * of the modification we are about to do is clean and idle.
	 */
	rounding = XFS_FSB_TO_B(mp, xfs_extent_alignment(ip));
	rounding = max(rounding, PAGE_SIZE);
	...

in xfs_free_file_space()

	/*
	 * Round the range we are going to free inwards to extent
	 * alignment boundaries so we don't free blocks outside the
	 * range requested.
	 */
	rounding = xfs_extent_alignment(ip);
	if (rounding > 1 ) {
		startoffset_fsb = roundup_64(startoffset_fsb, rounding);
		endoffset_fsb = rounddown_64(endoffset_fsb, rounding);
	}

and in xfs_prepare_shift()

	/*
	 * Shift operations must stabilize the start block offset boundary along
	 * with the full range of the operation. If we don't, a COW writeback
	 * completion could race with an insert, front merge with the start
	 * extent (after split) during the shift and corrupt the file. Start
	 * with the aligned block just prior to the start to stabilize the boundary.
	 */
	rounding = XFS_FSB_TO_B(mp, xfs_extent_alignment(ip));
	offset = round_down(offset, rounding);
	if (offset)
		offset -= rounding;

Also, I think that the changes I suggested earlier to 
xfs_is_falloc_aligned() could use this xfs_extent_alignment()
helper...

Overall this makes the code a whole lot easier to read and it also
allows forced alignment to work correctly on RT devices...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

