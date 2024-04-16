Return-Path: <linux-kernel+bounces-147265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDFA8A71B6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72EFE1F21BEC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074FB12BE89;
	Tue, 16 Apr 2024 16:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NjTFfF5Z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFA41F956
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 16:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713286413; cv=none; b=TT8IiV/QEP0RwHl0WuqK8z66+MvDH2GCV1ezBQw/URLlFO8paGl9FW4pBNCCdh7ERGP3d6zZFo2HMUSe01gPxoUg9NvYe+A0dpkpjDKmaLeqiztf5W4L1qEm93bgql1UgIy85z/rKyZZGggzHxUU3DaxdZGItKfmDVBHEfznJZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713286413; c=relaxed/simple;
	bh=ezmFLIFNn/ZZBBwAdVS+xgDslQU7nT4nfmH+rCWjzn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NoqdmRQaZqOlQ/LVptARu1n2a01eNUyc/L7RktncQkFHvgLZ1xuP9+Rtr245gzYv3AnxO5pU2V4FVUF6HBWFG0Pdo4dIQDRxCvTVSwrFx/p9+Kt6AR1JB8LkAfdsUEDFJCUTiQZ2eg1i18IjEetsNRJbOcw3STiyNFaUkqKhi/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NjTFfF5Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9681DC113CE;
	Tue, 16 Apr 2024 16:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713286412;
	bh=ezmFLIFNn/ZZBBwAdVS+xgDslQU7nT4nfmH+rCWjzn4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NjTFfF5ZRQPjgO7avZxPkAG7vsZZEREB0wcobTxKIQIgMTu8WSMxQHbjNkP+nfGsA
	 UZWpeiLm3oVsdp8XG1ojM2puTFljifv5y5WjpVvVtnMk/lyA5ErYtYWdmN2DeyA5Ti
	 aQhwv/NKo88jNt6Lyy20xFIadXpLcyxAPTmGk039Tjjhl0RVVoR1ZQ9dTjcMcDUhwJ
	 Hl3Fei7ScL6iMcl8H2ou/CoGvKAOeheASItF9frPuUq6YLQ1OCgKPNPtUQyeZ7n7Mb
	 nKtaBH2cbdD1BG+TCk/AcdWGhNBciLZuBwrhsYrnJ9L20oxk/J4x25ZHJxs5WvKziF
	 nE6Q29xRRDJKA==
Date: Tue, 16 Apr 2024 16:53:31 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Liao Yuanhong <liaoyuanhong@vivo.com>
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: Re: [f2fs-dev] [PATCH] f2fs:add zone device priority option to the
 mount options
Message-ID: <Zh6tC-fTZZlP5Dk2@google.com>
References: <20240415091650.27825-1-liaoyuanhong@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415091650.27825-1-liaoyuanhong@vivo.com>

I don't see any point why we need this.

On 04/15, Liao Yuanhong wrote:
> Add a zone device priority option in the mount options. When enabled, the 
> file system will prioritize using zone devices free space instead of 
> conventional devices when writing to the end of the storage space.
> 
> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
> ---
>  fs/f2fs/f2fs.h    |  1 +
>  fs/f2fs/segment.c | 13 ++++++++++++-
>  fs/f2fs/super.c   | 20 ++++++++++++++++++++
>  3 files changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index fced2b7652f4..e2438f7d2e13 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -116,6 +116,7 @@ extern const char *f2fs_fault_name[FAULT_MAX];
>  #define	F2FS_MOUNT_GC_MERGE		0x02000000
>  #define F2FS_MOUNT_COMPRESS_CACHE	0x04000000
>  #define F2FS_MOUNT_AGE_EXTENT_CACHE	0x08000000
> +#define F2FS_MOUNT_PRIORITY_ZONED	0x10000000
>  
>  #define F2FS_OPTION(sbi)	((sbi)->mount_opt)
>  #define clear_opt(sbi, option)	(F2FS_OPTION(sbi).opt &= ~F2FS_MOUNT_##option)
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 4fd76e867e0a..adbe68a11fa5 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -2697,7 +2697,18 @@ static int get_new_segment(struct f2fs_sb_info *sbi,
>  find_other_zone:
>  	secno = find_next_zero_bit(free_i->free_secmap, MAIN_SECS(sbi), hint);
>  	if (secno >= MAIN_SECS(sbi)) {
> -		secno = find_first_zero_bit(free_i->free_secmap,
> +		/* set hint to get section from zone device first */
> +		if (test_opt(sbi, PRIORITY_ZONED)) {
> +			hint = GET_SEC_FROM_SEG(sbi, first_zoned_segno(sbi));
> +			secno = find_next_zero_bit(free_i->free_secmap,
> +						MAIN_SECS(sbi), hint);
> +
> +			/* get section from clu if exceeding the size limit */
> +			if (secno >= MAIN_SECS(sbi))
> +				secno = find_first_zero_bit(free_i->free_secmap,
> +							MAIN_SECS(sbi));
> +		} else
> +			secno = find_first_zero_bit(free_i->free_secmap,
>  							MAIN_SECS(sbi));
>  		if (secno >= MAIN_SECS(sbi)) {
>  			ret = -ENOSPC;
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index a4bc26dfdb1a..2742978a100a 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -126,6 +126,8 @@ enum {
>  	Opt_inline_data,
>  	Opt_inline_dentry,
>  	Opt_noinline_dentry,
> +	Opt_priority_zoned,
> +	Opt_nopriority_zoned,
>  	Opt_flush_merge,
>  	Opt_noflush_merge,
>  	Opt_barrier,
> @@ -204,6 +206,8 @@ static match_table_t f2fs_tokens = {
>  	{Opt_inline_data, "inline_data"},
>  	{Opt_inline_dentry, "inline_dentry"},
>  	{Opt_noinline_dentry, "noinline_dentry"},
> +	{Opt_priority_zoned, "priority_zoned"},
> +	{Opt_nopriority_zoned, "nopriority_zoned"},
>  	{Opt_flush_merge, "flush_merge"},
>  	{Opt_noflush_merge, "noflush_merge"},
>  	{Opt_barrier, "barrier"},
> @@ -805,6 +809,16 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
>  		case Opt_noinline_dentry:
>  			clear_opt(sbi, INLINE_DENTRY);
>  			break;
> +#ifdef CONFIG_BLK_DEV_ZONED
> +		case Opt_priority_zoned:
> +			if (f2fs_sb_has_blkzoned(sbi))
> +				set_opt(sbi, PRIORITY_ZONED);
> +			break;
> +		case Opt_nopriority_zoned:
> +			if (f2fs_sb_has_blkzoned(sbi))
> +				clear_opt(sbi, PRIORITY_ZONED);
> +			break;
> +#endif
>  		case Opt_flush_merge:
>  			set_opt(sbi, FLUSH_MERGE);
>  			break;
> @@ -1990,6 +2004,12 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
>  		seq_puts(seq, ",inline_dentry");
>  	else
>  		seq_puts(seq, ",noinline_dentry");
> +#ifdef CONFIG_BLK_DEV_ZONED
> +	if (test_opt(sbi, PRIORITY_ZONED))
> +		seq_puts(seq, ",priority_zoned");
> +	else
> +		seq_puts(seq, ",nopriority_zoned");
> +#endif
>  	if (test_opt(sbi, FLUSH_MERGE))
>  		seq_puts(seq, ",flush_merge");
>  	else
> -- 
> 2.25.1

