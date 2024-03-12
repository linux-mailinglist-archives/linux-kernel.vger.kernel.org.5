Return-Path: <linux-kernel+bounces-99738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E37C878C67
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 02:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 043E52836E5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 01:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21108749C;
	Tue, 12 Mar 2024 01:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IqyLkDuT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE086FB2
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 01:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710207761; cv=none; b=fryYTYh6hZTncL4Gc7qhiUVT+ixT7tFOIwIj8r72Y9xT+MxzvehNtwGxgOVHRernbX9QXOOxBZBeKKPZ9ewUvJTe/GImbzvKJk9a9gIpmxo4Jl0GDkwtt+F0FIKtpM1C5Npxx+PHUZ6iqpH5b1XOONSJt5ZdccZlJQEgx43M7AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710207761; c=relaxed/simple;
	bh=ioCglCiuFytXfIPfWrP5a+ai20J7qUrjXL07BC91CnE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o3SN9tY0gaNAOod/d2aLRt4nJ560h0YLHwdvzJUzYEUM5JINhz9y6kHaCDWEtV6aAIhuMgH8KNxupU7eiDh1cPILVHXnem5nR/19dGnjZcQ6JkkbJbq8019n+yvpOnJ/6PCBgsuBIOH6fKWhVJfj7vom06Bd6XnmJh+UXNLJgXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IqyLkDuT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2961C433F1;
	Tue, 12 Mar 2024 01:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710207760;
	bh=ioCglCiuFytXfIPfWrP5a+ai20J7qUrjXL07BC91CnE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IqyLkDuT4UQHkI1VNrl7vmcMiMTwQPqZ7GdYQ2vFZotLCiDImiI1EMvCPgIu50F6u
	 vcvrVnNTeVoD1z+lXm1+ywBLGU5W4bDxzaKhyho2yIuKbGIGxcIjo7mC40WWCDszWr
	 WkuqQ/NfVB5kuKv2EhMXHgSvkQpxhsUJYDqWS66PgX28s7ZXV9771/uUd9FL4g8zlq
	 /nLe6I50ZVLBdHKrbSYFWja5AzLw52kOPpvzRmhIvJcSIndBRx8OG8TBy106hevy07
	 3pFcmjhO6z5LFqu+logi37OQ2A3RU5gKEHk+eSLCkOeUXGNDAeyuJUkbJbZPcMI9QG
	 hoCF8HR55TZkw==
Message-ID: <63ece9a0-ccd1-43f7-ab51-cf5adc49be71@kernel.org>
Date: Tue, 12 Mar 2024 09:42:39 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] f2fs: support .shutdown in f2fs_sops
Content-Language: en-US
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20240229143838.45149-1-chao@kernel.org>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240229143838.45149-1-chao@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Ping,

On 2024/2/29 22:38, Chao Yu wrote:
> Support .shutdown callback in f2fs_sops, then, it can be called to
> shut down the file system when underlying block device is marked dead.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>   fs/f2fs/f2fs.h  |  2 ++
>   fs/f2fs/file.c  | 70 ++++++++++++++++++++++++++++++-------------------
>   fs/f2fs/super.c |  6 +++++
>   3 files changed, 51 insertions(+), 27 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 85eb9a8a5ed3..80789255bf68 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -3506,6 +3506,8 @@ int f2fs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
>   		 struct iattr *attr);
>   int f2fs_truncate_hole(struct inode *inode, pgoff_t pg_start, pgoff_t pg_end);
>   void f2fs_truncate_data_blocks_range(struct dnode_of_data *dn, int count);
> +int f2fs_do_shutdown(struct f2fs_sb_info *sbi, unsigned int flag,
> +							bool readonly);
>   int f2fs_precache_extents(struct inode *inode);
>   int f2fs_fileattr_get(struct dentry *dentry, struct fileattr *fa);
>   int f2fs_fileattr_set(struct mnt_idmap *idmap,
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 4ca6c693b33a..d223175b3d5c 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -2226,34 +2226,13 @@ static int f2fs_ioc_abort_atomic_write(struct file *filp)
>   	return ret;
>   }
>   
> -static int f2fs_ioc_shutdown(struct file *filp, unsigned long arg)
> +int f2fs_do_shutdown(struct f2fs_sb_info *sbi, unsigned int flag,
> +							bool readonly)
>   {
> -	struct inode *inode = file_inode(filp);
> -	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>   	struct super_block *sb = sbi->sb;
> -	__u32 in;
>   	int ret = 0;
>   
> -	if (!capable(CAP_SYS_ADMIN))
> -		return -EPERM;
> -
> -	if (get_user(in, (__u32 __user *)arg))
> -		return -EFAULT;
> -
> -	if (in != F2FS_GOING_DOWN_FULLSYNC) {
> -		ret = mnt_want_write_file(filp);
> -		if (ret) {
> -			if (ret == -EROFS) {
> -				ret = 0;
> -				f2fs_stop_checkpoint(sbi, false,
> -						STOP_CP_REASON_SHUTDOWN);
> -				trace_f2fs_shutdown(sbi, in, ret);
> -			}
> -			return ret;
> -		}
> -	}
> -
> -	switch (in) {
> +	switch (flag) {
>   	case F2FS_GOING_DOWN_FULLSYNC:
>   		ret = bdev_freeze(sb->s_bdev);
>   		if (ret)
> @@ -2292,6 +2271,9 @@ static int f2fs_ioc_shutdown(struct file *filp, unsigned long arg)
>   		goto out;
>   	}
>   
> +	if (readonly)
> +		goto out;
> +
>   	f2fs_stop_gc_thread(sbi);
>   	f2fs_stop_discard_thread(sbi);
>   
> @@ -2300,10 +2282,44 @@ static int f2fs_ioc_shutdown(struct file *filp, unsigned long arg)
>   
>   	f2fs_update_time(sbi, REQ_TIME);
>   out:
> -	if (in != F2FS_GOING_DOWN_FULLSYNC)
> -		mnt_drop_write_file(filp);
>   
> -	trace_f2fs_shutdown(sbi, in, ret);
> +	trace_f2fs_shutdown(sbi, flag, ret);
> +
> +	return ret;
> +}
> +
> +static int f2fs_ioc_shutdown(struct file *filp, unsigned long arg)
> +{
> +	struct inode *inode = file_inode(filp);
> +	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> +	__u32 in;
> +	int ret;
> +	bool need_drop = false, readonly = false;
> +
> +	if (!capable(CAP_SYS_ADMIN))
> +		return -EPERM;
> +
> +	if (get_user(in, (__u32 __user *)arg))
> +		return -EFAULT;
> +
> +	if (in != F2FS_GOING_DOWN_FULLSYNC) {
> +		ret = mnt_want_write_file(filp);
> +		if (ret) {
> +			if (ret != -EROFS)
> +				return ret;
> +
> +			/* fallback to nosync shutdown for readonly fs */
> +			in = F2FS_GOING_DOWN_NOSYNC;
> +			readonly = true;
> +		} else {
> +			need_drop = true;
> +		}
> +	}
> +
> +	ret = f2fs_do_shutdown(sbi, in, readonly);
> +
> +	if (need_drop)
> +		mnt_drop_write_file(filp);
>   
>   	return ret;
>   }
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 78a76583a4aa..0676c2dcbbf7 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -2547,6 +2547,11 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
>   	return err;
>   }
>   
> +static void f2fs_shutdown(struct super_block *sb)
> +{
> +	f2fs_do_shutdown(F2FS_SB(sb), F2FS_GOING_DOWN_NOSYNC, false);
> +}
> +
>   #ifdef CONFIG_QUOTA
>   static bool f2fs_need_recovery(struct f2fs_sb_info *sbi)
>   {
> @@ -3146,6 +3151,7 @@ static const struct super_operations f2fs_sops = {
>   	.unfreeze_fs	= f2fs_unfreeze,
>   	.statfs		= f2fs_statfs,
>   	.remount_fs	= f2fs_remount,
> +	.shutdown	= f2fs_shutdown,
>   };
>   
>   #ifdef CONFIG_FS_ENCRYPTION

