Return-Path: <linux-kernel+bounces-70971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E05859ED2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94D001F212AC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 08:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8CFC22325;
	Mon, 19 Feb 2024 08:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R1yW0m0+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2699522092
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 08:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708332771; cv=none; b=piDKc3BtLTXmEHI8Q+AKUWO4eiEPR8b+Eo6On6OiUsG4wcalQU2VvkdEzQvuS1VEX5/u2WytG2GmWmXslqY2TPSJ+wFtccIyCVL4Pj/cKASDPYtW0xkU0tR7jpESjE/j7/aXV1/4UAoSRjvyK2dttSCAlupdn1ib08DHSsZh/i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708332771; c=relaxed/simple;
	bh=A8qPA802yUnOnRI0lcZYzdQTNt8OqoBRlHRFZy/PbDs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f6ok2EyoVO12HAAEjWu27vM/pdZm/FJycjg2aJGOrletu58sE4/gm9/Ua005dElqyhSk1RZvw5jqYeaBFXoTnGyXMJflOe5zTQg9VZWDkrF0v915cBbSv6t8eI+yRznNPqVkrmT7hnqWe+kMC1k0RSDFtJOIzVhE0W4kF1urqvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R1yW0m0+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA862C433F1;
	Mon, 19 Feb 2024 08:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708332770;
	bh=A8qPA802yUnOnRI0lcZYzdQTNt8OqoBRlHRFZy/PbDs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=R1yW0m0+Q9dkYPoVMEPpHO8HDflDJh71kyB4NwNoI0ioNc0aHOuTDflQKXFUNyGTE
	 IxdZHI86LyC2Cx0sWhNfLOJKSZxMCavnNCCnoPJhOFr+97RSoxF7zUkqWtB+KKJb4T
	 onD/EiqoqrxIMQscCtPof4VcrYPAW+m7VMLERe1mICW79Q3iqeBI2VbTGAhz3fFqUH
	 dX5QS9Fc9nxUNEKi4ZkjOEX4bQoTeXAJnnnGDX28ijYPBoTff02QmDp0LsdJbH1aPA
	 n/ZaZVas+kzIP83yYy0zB1pnhKp5t1B43GVo+54Jh37wvEk+OUATyNOxFmzZxtQi3B
	 BfllvB1aweOHQ==
Message-ID: <60e2dbf9-1ced-40a8-ae17-5b156f0effb2@kernel.org>
Date: Mon, 19 Feb 2024 16:52:46 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] f2fs: introduce get_available_block_count() for cleanup
Content-Language: en-US
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20240124144342.14612-1-chao@kernel.org>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240124144342.14612-1-chao@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Ping,

Since there is conflict while applying to last dev-test, let me
rebase the code in v2.

On 2024/1/24 22:43, Chao Yu wrote:
> There are very similar codes in inc_valid_block_count() and
> inc_valid_node_count() which is used for available user block
> count calculation.
> 
> This patch introduces a new helper get_available_block_count()
> to include those common codes, and used it to clean up codes.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>   fs/f2fs/f2fs.h | 61 +++++++++++++++++++++++++-------------------------
>   1 file changed, 31 insertions(+), 30 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 5d19643a92af..0094a8c85f4a 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -2253,6 +2253,31 @@ static inline bool __allow_reserved_blocks(struct f2fs_sb_info *sbi,
>   	return false;
>   }
>   
> +static inline unsigned int get_available_block_count(struct f2fs_sb_info *sbi,
> +						struct inode *inode, bool cap)
> +{
> +	block_t avail_user_block_count;
> +
> +	avail_user_block_count = sbi->user_block_count -
> +					sbi->current_reserved_blocks;
> +
> +	if (!__allow_reserved_blocks(sbi, inode, cap))
> +		avail_user_block_count -= F2FS_OPTION(sbi).root_reserved_blocks;
> +
> +	if (F2FS_IO_ALIGNED(sbi))
> +		avail_user_block_count -= sbi->blocks_per_seg *
> +				SM_I(sbi)->additional_reserved_segments;
> +
> +	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED))) {
> +		if (avail_user_block_count > sbi->unusable_block_count)
> +			avail_user_block_count -= sbi->unusable_block_count;
> +		else
> +			avail_user_block_count = 0;
> +	}
> +
> +	return avail_user_block_count;
> +}
> +
>   static inline void f2fs_i_blocks_write(struct inode *, block_t, bool, bool);
>   static inline int inc_valid_block_count(struct f2fs_sb_info *sbi,
>   				 struct inode *inode, blkcnt_t *count, bool partial)
> @@ -2278,22 +2303,8 @@ static inline int inc_valid_block_count(struct f2fs_sb_info *sbi,
>   
>   	spin_lock(&sbi->stat_lock);
>   	sbi->total_valid_block_count += (block_t)(*count);
> -	avail_user_block_count = sbi->user_block_count -
> -					sbi->current_reserved_blocks;
> -
> -	if (!__allow_reserved_blocks(sbi, inode, true))
> -		avail_user_block_count -= F2FS_OPTION(sbi).root_reserved_blocks;
> +	avail_user_block_count = get_available_block_count(sbi, inode, true);
>   
> -	if (F2FS_IO_ALIGNED(sbi))
> -		avail_user_block_count -= sbi->blocks_per_seg *
> -				SM_I(sbi)->additional_reserved_segments;
> -
> -	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED))) {
> -		if (avail_user_block_count > sbi->unusable_block_count)
> -			avail_user_block_count -= sbi->unusable_block_count;
> -		else
> -			avail_user_block_count = 0;
> -	}
>   	if (unlikely(sbi->total_valid_block_count > avail_user_block_count)) {
>   		if (!partial) {
>   			spin_unlock(&sbi->stat_lock);
> @@ -2609,7 +2620,8 @@ static inline int inc_valid_node_count(struct f2fs_sb_info *sbi,
>   					struct inode *inode, bool is_inode)
>   {
>   	block_t	valid_block_count;
> -	unsigned int valid_node_count, user_block_count;
> +	unsigned int valid_node_count;
> +	unsigned int avail_user_block_count;
>   	int err;
>   
>   	if (is_inode) {
> @@ -2629,21 +2641,10 @@ static inline int inc_valid_node_count(struct f2fs_sb_info *sbi,
>   
>   	spin_lock(&sbi->stat_lock);
>   
> -	valid_block_count = sbi->total_valid_block_count +
> -					sbi->current_reserved_blocks + 1;
> -
> -	if (!__allow_reserved_blocks(sbi, inode, false))
> -		valid_block_count += F2FS_OPTION(sbi).root_reserved_blocks;
> -
> -	if (F2FS_IO_ALIGNED(sbi))
> -		valid_block_count += sbi->blocks_per_seg *
> -				SM_I(sbi)->additional_reserved_segments;
> -
> -	user_block_count = sbi->user_block_count;
> -	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED)))
> -		user_block_count -= sbi->unusable_block_count;
> +	valid_block_count = sbi->total_valid_block_count + 1;
> +	avail_user_block_count = get_available_block_count(sbi, inode, false);
>   
> -	if (unlikely(valid_block_count > user_block_count)) {
> +	if (unlikely(valid_block_count > avail_user_block_count)) {
>   		spin_unlock(&sbi->stat_lock);
>   		goto enospc;
>   	}

