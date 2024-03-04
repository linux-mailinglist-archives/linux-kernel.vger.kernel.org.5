Return-Path: <linux-kernel+bounces-91022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C564287088B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2030CB25F2C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4A261669;
	Mon,  4 Mar 2024 17:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LrT+mKUl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EB2612F6
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 17:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709574470; cv=none; b=Ipe7swvLsAw+qnvwaXz2eeNX8+RUjHe6l8BMYZPDM+YBcc8cXzFdrWFfkSJ+8m0d/4Oe4fbyLCPMd8GELq8HoDZ/WGjT3SeNQlyziHK4w70b9Kh2zBbE/mWWUpNT7Op7u5kY1gv0zIWslInLiTf3S5Wlk95BiHbIISLwVTImrv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709574470; c=relaxed/simple;
	bh=2Ua8nygoCYe9R7ieEeyk8j5xe7GBMxuXNLVcBXyeTg4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=acRy/STjXygENTWbVo48eXhMibbaCOHKwxK89dSK+dH/jDq8ARGXZBuKA3GAticpcfFz2p2SUU0NSHpQQJUXrldJmvGe00jylwwgglQEDAA1xkij8hBG3DyTcf2Tbb8FdxQXU7acC9PFAMSFztRumX2HC7g+ohR/Smkk2mDrxEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LrT+mKUl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBF17C433C7;
	Mon,  4 Mar 2024 17:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709574469;
	bh=2Ua8nygoCYe9R7ieEeyk8j5xe7GBMxuXNLVcBXyeTg4=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=LrT+mKUlJHwKipbRQEjxM8C7pmfW+ZFo6smghrow224D2hULUzXwCATD5JTlhQg81
	 4zJ6fTJJ5t4sCX7MSdzzIJc9ZCH6wtbmwdS6ldZrN1sG4wgiM2MKUyzcMvhoojVNNn
	 BNo2ZCKkwhnWtLDZ5DaTCppSxkiFdhAD89fiGG4CdFggUjoQ+k51i01IZ41trM+QyT
	 tZAUFThWE3/2tTdLmrjngyr2WwkJyCw27HylZl9T0im3Bm2qu4Mn3ffyF+QnvksfdW
	 isQIC1p5+tlN1CpR3BAtVOFLvdc/u2n8Adqp1IDDxtmBZo4IRoMA+t6x5Fbiw9AfLh
	 zakFEad7LD25w==
Date: Mon, 4 Mar 2024 09:47:48 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 3/5] f2fs: print zone status in string and some log
Message-ID: <ZeYJRG3DBJlL3004@google.com>
References: <20240223205535.307307-1-jaegeuk@kernel.org>
 <20240223205535.307307-3-jaegeuk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223205535.307307-3-jaegeuk@kernel.org>

On 02/23, Jaegeuk Kim wrote:
> No functional change, but add some more logs.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/segment.c | 34 ++++++++++++++++++++++++----------
>  fs/f2fs/super.c   |  1 +
>  2 files changed, 25 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index d4f228e6f771..6d586ae8b55f 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -4912,6 +4912,16 @@ static int sanity_check_curseg(struct f2fs_sb_info *sbi)
>  }
>  
>  #ifdef CONFIG_BLK_DEV_ZONED
> +const char *f2fs_zone_status[BLK_ZONE_COND_OFFLINE + 1] = {

Added static.

> +	[BLK_ZONE_COND_NOT_WP]		= "NOT_WP",
> +	[BLK_ZONE_COND_EMPTY]		= "EMPTY",
> +	[BLK_ZONE_COND_IMP_OPEN]	= "IMPLICITE_OPEN",
> +	[BLK_ZONE_COND_EXP_OPEN]	= "EXPLICITE_OPEN",
> +	[BLK_ZONE_COND_CLOSED]		= "CLOSED",
> +	[BLK_ZONE_COND_READONLY]	= "READONLY",
> +	[BLK_ZONE_COND_FULL]		= "FULL",
> +	[BLK_ZONE_COND_OFFLINE]		= "OFFLINE",
> +};
>  
>  static int check_zone_write_pointer(struct f2fs_sb_info *sbi,
>  				    struct f2fs_dev_info *fdev,
> @@ -4928,18 +4938,22 @@ static int check_zone_write_pointer(struct f2fs_sb_info *sbi,
>  	zone_block = fdev->start_blk + (zone->start >> log_sectors_per_block);
>  	zone_segno = GET_SEGNO(sbi, zone_block);
>  
> +	/*
> +	 * Get # of valid block of the zone.
> +	 */
> +	valid_block_cnt = get_valid_blocks(sbi, zone_segno, true);
> +
>  	/*
>  	 * Skip check of zones cursegs point to, since
>  	 * fix_curseg_write_pointer() checks them.
>  	 */
>  	if (zone_segno >= MAIN_SEGS(sbi) ||
> -	    IS_CURSEC(sbi, GET_SEC_FROM_SEG(sbi, zone_segno)))
> +	    IS_CURSEC(sbi, GET_SEC_FROM_SEG(sbi, zone_segno))) {
> +		f2fs_notice(sbi, "Open zones: valid block[0x%x,0x%x] cond[%s]",
> +				zone_segno, valid_block_cnt,
> +				f2fs_zone_status[zone->cond]);
>  		return 0;
> -
> -	/*
> -	 * Get # of valid block of the zone.
> -	 */
> -	valid_block_cnt = get_valid_blocks(sbi, zone_segno, true);
> +	}
>  
>  	if ((!valid_block_cnt && zone->cond == BLK_ZONE_COND_EMPTY) ||
>  	    (valid_block_cnt && zone->cond == BLK_ZONE_COND_FULL))
> @@ -4947,8 +4961,8 @@ static int check_zone_write_pointer(struct f2fs_sb_info *sbi,
>  
>  	if (!valid_block_cnt) {
>  		f2fs_notice(sbi, "Zone without valid block has non-zero write "
> -			    "pointer. Reset the write pointer: cond[0x%x]",
> -			    zone->cond);
> +			    "pointer. Reset the write pointer: cond[%s]",
> +			    f2fs_zone_status[zone->cond]);
>  		ret = __f2fs_issue_discard_zone(sbi, fdev->bdev, zone_block,
>  					zone->len >> log_sectors_per_block);
>  		if (ret)
> @@ -4965,8 +4979,8 @@ static int check_zone_write_pointer(struct f2fs_sb_info *sbi,
>  	 * selected for write operation until it get discarded.
>  	 */
>  	f2fs_notice(sbi, "Valid blocks are not aligned with write "
> -		    "pointer: valid block[0x%x,0x%x] cond[0x%x]",
> -		    zone_segno, valid_block_cnt, zone->cond);
> +		    "pointer: valid block[0x%x,0x%x] cond[%s]",
> +		    zone_segno, valid_block_cnt, f2fs_zone_status[zone->cond]);
>  
>  	ret = blkdev_zone_mgmt(fdev->bdev, REQ_OP_ZONE_FINISH,
>  				zone->start, zone->len, GFP_NOFS);
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 4d03ce1109ad..fc7f1a9fbbda 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -4674,6 +4674,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>  	 * check zoned block devices' write pointer consistency.
>  	 */
>  	if (!f2fs_readonly(sb) && f2fs_sb_has_blkzoned(sbi)) {
> +		f2fs_notice(sbi, "Checking entire write pointers");
>  		err = f2fs_check_write_pointer(sbi);
>  		if (err)
>  			goto free_meta;
> -- 
> 2.44.0.rc0.258.g7320e95886-goog

