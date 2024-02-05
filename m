Return-Path: <linux-kernel+bounces-52019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DAC8492E0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 04:54:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C015E281C77
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 03:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91BA9945A;
	Mon,  5 Feb 2024 03:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AQWmjfiX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4FD9468;
	Mon,  5 Feb 2024 03:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707105249; cv=none; b=qB55NILm6Wp+6uZub2zqvz/MmCHX9pvxy3EMW/XH1omT85jWhwS8M26WCESPK+QMRKdQx8VVqyYEh+Pb/ZdgAC6vOiqtInamCnC8CdTblv3DIGwU6T74ymgmzh5EHIcnrq9Q5gznmzuSvIWY7yqLm8qNxaHhg4uaa3v61tvzECA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707105249; c=relaxed/simple;
	bh=NDy4o5zUZsXsouBNLnngKThxIfRGRetmmftaWLSdkgE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GG3w54VbMi9PJceg3vcqp2DacQPtASq8Sk0VZo+qQFfyDXdoRBBEKJwtBH6eppmVNdLFeoyTZvRqKmd3HGLGnpsnOVweXyNCPp0HYCMnz/d6U16eOZH5wsLh1d4DQcZ0ngK1v/T0nhxsCss9ApVp+Vkbru7JHA2M7GBKZlz1Cig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AQWmjfiX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99821C433C7;
	Mon,  5 Feb 2024 03:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707105249;
	bh=NDy4o5zUZsXsouBNLnngKThxIfRGRetmmftaWLSdkgE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AQWmjfiXjHNhMQWtPaU5bT7lKzYWq+yzwwhAs+ZmVm47LMmJ4szfMwO3npvWUM/yj
	 LDBy06039vhjUMb5kOILukqV90eL4vswH4E3+ZFYz6mmDjk7HDCUBAlTooi51p5Dqi
	 vmV+ulfYDs2+z2ZfT+32MzM0pe2cRiZWkpnAsGcMAgve+OAMEVb/IlVM78NLfphTQr
	 +fFthBImmgn+5H2mxNfWqEVIxQKhIh6gYtCCrn1BCwzBmXERg7bIlY4pX7HTlyx8gg
	 DyAwKQ2z47eOBxZkkRLuNSlpuirr2PbYPm/fWP7XRIcvpHGnPwr3pgDXIjTzocd8lx
	 c6Xgm1t5Vl/eg==
Message-ID: <793fd834-fe28-4647-b2cf-0012acb95b43@kernel.org>
Date: Mon, 5 Feb 2024 11:54:04 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "f2fs: stop allocating pinned sections if EAGAIN
 happens"
Content-Language: en-US
To: Wu Bo <bo.wu@vivo.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 Wu Bo <wubo.oduw@gmail.com>, stable@vger.kernel.org
References: <20240205031415.557879-1-bo.wu@vivo.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240205031415.557879-1-bo.wu@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/2/5 11:14, Wu Bo wrote:
> This reverts commit 2e42b7f817acd6e8d78226445eb6fe44fe79c12a.
> 
> If the GC victim section has a pinned block when fallocate() trigger
> FG_GC, the section is not able to be recycled. And this will return
> -EAGAIN cause fallocate() failed, even though there are much spare space
> as user see. As the GC policy prone to chose the same victim,
> fallocate() may not successed at a long period.
> 
> This scenario has been found during Android OTA.
> 
> Link: https://lore.kernel.org/linux-f2fs-devel/20231030094024.263707-1-bo.wu@vivo.com/t/#u
> 
> CC: stable@vger.kernel.org
> Signed-off-by: Wu Bo <bo.wu@vivo.com>
> ---
>   fs/f2fs/file.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index b58ab1157b7e..19915faccee9 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -1725,7 +1725,7 @@ static int f2fs_expand_inode_data(struct inode *inode, loff_t offset,
>   			f2fs_down_write(&sbi->gc_lock);
>   			stat_inc_gc_call_count(sbi, FOREGROUND);
>   			err = f2fs_gc(sbi, &gc_control);
> -			if (err && err != -ENODATA)
> +			if (err && err != -ENODATA && err != -EAGAIN)
>   				goto out_err;
>   		}

How about calling f2fs_balance_fs() to double check and make sure there is
enough free space for following allocation.

		if (has_not_enough_free_secs(sbi, 0,
			GET_SEC_FROM_SEG(sbi, overprovision_segments(sbi)))) {
			f2fs_down_write(&sbi->gc_lock);
			stat_inc_gc_call_count(sbi, FOREGROUND);
			err = f2fs_gc(sbi, &gc_control);
			if (err == -EAGAIN)
				f2fs_balance_fs(sbi, true);
			if (err && err != -ENODATA)
				goto out_err;
		}

Thanks,

>   

