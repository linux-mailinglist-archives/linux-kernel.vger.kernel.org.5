Return-Path: <linux-kernel+bounces-103270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F83E87BD41
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7686C1C20E66
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 13:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3932E5A11A;
	Thu, 14 Mar 2024 13:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aBpVYAmg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4B65914E
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 13:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710421580; cv=none; b=PSIgSfwmAL4Q7VWfCjvFaM3OxdrOQQODoClj3V+6sUqhYmRkcRJD7gn3PPixA9+5b/rYdIpZczlCiDlWeHqQDvbCwD5b84U6JGgtcyYcyzThSf5a2HiKl5ab4al1AD1aohNpbV+DpzajqMnalfIiRKRa5jcGK9vnY5K7T6PjwC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710421580; c=relaxed/simple;
	bh=MElPHl186ioKAc0FmIFa1N/21frTBw3U+yXB0xz9r5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZLmsw+gHl/Ke3qJ1k+Jcvkq91Vr6ViUeoBqRMIrR1CMRR1stWDYlGdq0rVWy5ede/xDj7k4O3yIbVtVmJukm3Eh3xxPHK/KCwzLtlUytkS+Xxsy97xgID6nML6Y5NDTFjjnFa4jOuyoJ9t6eMC42eJg3kEVpmqeTYlZ4YISZoNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aBpVYAmg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FD80C433C7;
	Thu, 14 Mar 2024 13:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710421580;
	bh=MElPHl186ioKAc0FmIFa1N/21frTBw3U+yXB0xz9r5Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aBpVYAmgsE/0H0WsN6O7VV/6lHtyT164V9jLi4xhHLVPQJZ0lG2WyEs4WOdw1AYeH
	 DO/TIknKEnHW5hDy+XyWMGkMfz6HgZ3g2Hg9eRLKDU1jtNvi08vcf3WDFjfkMoNW3j
	 hLD7Ve3qeP3jx2KxPYV7WshocToOOawZJk0Z0EGk6KYuACLEEfbF5Hc4QYa5TMMaER
	 8JZZ1F1PXo6yBGRlgiVEXdDiApVkC0GnW8FAvSy5d3R/wf0F4vmRQ1yNI4vY8nJxkp
	 ERbKMg5cKgD1DxC1EjYsWqS/Kf7ENHWpmJqbvcVlfCiy6UB0SG5eksx7ku3VOYZKv+
	 zw/F5VVR31OQg==
Message-ID: <eeefebcb-54db-4087-9319-dd5f9b63a1da@kernel.org>
Date: Thu, 14 Mar 2024 21:06:14 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] f2fs: add REQ_TIME time update for some user behaviors
Content-Language: en-US
To: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 niuzhiguo84@gmail.com, ke.wang@unisoc.com, hongyu.jin@unisoc.com
References: <1710303061-16822-1-git-send-email-zhiguo.niu@unisoc.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <1710303061-16822-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/3/13 12:11, Zhiguo Niu wrote:
> some user behaviors requested filesystem operations, which
> will cause filesystem not idle.
> Meanwhile adjust f2fs_update_time(REQ_TIME) of
> f2fs_ioc_defragment to successful case.
> 
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> ---
>   fs/f2fs/file.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 4dfe38e..dac3836 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -2784,7 +2784,6 @@ static int f2fs_ioc_defragment(struct file *filp, unsigned long arg)
>   	err = f2fs_defragment_range(sbi, filp, &range);
>   	mnt_drop_write_file(filp);
>   
> -	f2fs_update_time(sbi, REQ_TIME);

I guess we need to call f2fs_update_time() here if any data was
migrated.

if (range->len)
	f2fs_update_time(sbi, REQ_TIME);

>   	if (err < 0)
>   		return err;
>   
> @@ -2792,6 +2791,7 @@ static int f2fs_ioc_defragment(struct file *filp, unsigned long arg)
>   							sizeof(range)))
>   		return -EFAULT;
>   
> +	f2fs_update_time(sbi, REQ_TIME);
>   	return 0;
>   }
>   
> @@ -3331,6 +3331,7 @@ static int f2fs_ioc_resize_fs(struct file *filp, unsigned long arg)
>   	if (copy_from_user(&block_count, (void __user *)arg,
>   			   sizeof(block_count)))
>   		return -EFAULT;
> +	f2fs_update_time(sbi, REQ_TIME);

There will be no further IO in the end of f2fs_ioc_resize_fs(), so we don't
need to update time to delay gc/discard thread?

>   
>   	return f2fs_resize_fs(filp, block_count);
>   }
> @@ -3424,6 +3425,7 @@ static int f2fs_ioc_setfslabel(struct file *filp, unsigned long arg)
>   	f2fs_up_write(&sbi->sb_lock);
>   
>   	mnt_drop_write_file(filp);
> +	f2fs_update_time(sbi, REQ_TIME);

Ditto,

Thanks,

>   out:
>   	kfree(vbuf);
>   	return err;
> @@ -3597,6 +3599,7 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
>   
>   	filemap_invalidate_unlock(inode->i_mapping);
>   	f2fs_up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
> +	f2fs_update_time(sbi, REQ_TIME);
>   out:
>   	inode_unlock(inode);
>   
> @@ -3766,6 +3769,7 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
>   		clear_inode_flag(inode, FI_COMPRESS_RELEASED);
>   		inode_set_ctime_current(inode);
>   		f2fs_mark_inode_dirty_sync(inode, true);
> +		f2fs_update_time(sbi, REQ_TIME);
>   	}
>   unlock_inode:
>   	inode_unlock(inode);
> @@ -3964,6 +3968,7 @@ static int f2fs_sec_trim_file(struct file *filp, unsigned long arg)
>   	if (len)
>   		ret = f2fs_secure_erase(prev_bdev, inode, prev_index,
>   				prev_block, len, range.flags);
> +	f2fs_update_time(sbi, REQ_TIME);
>   out:
>   	filemap_invalidate_unlock(mapping);
>   	f2fs_up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
> @@ -4173,6 +4178,7 @@ static int f2fs_ioc_decompress_file(struct file *filp)
>   	if (ret)
>   		f2fs_warn(sbi, "%s: The file might be partially decompressed (errno=%d). Please delete the file.",
>   			  __func__, ret);
> +	f2fs_update_time(sbi, REQ_TIME);
>   out:
>   	inode_unlock(inode);
>   	file_end_write(filp);
> @@ -4252,6 +4258,7 @@ static int f2fs_ioc_compress_file(struct file *filp)
>   	if (ret)
>   		f2fs_warn(sbi, "%s: The file might be partially compressed (errno=%d). Please delete the file.",
>   			  __func__, ret);
> +	f2fs_update_time(sbi, REQ_TIME);
>   out:
>   	inode_unlock(inode);
>   	file_end_write(filp);

