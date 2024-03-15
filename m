Return-Path: <linux-kernel+bounces-104007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2687A87C7D7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 04:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B164B21780
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 03:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC99BD27E;
	Fri, 15 Mar 2024 03:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XMoUWt5K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05245C8CE
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 03:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710472043; cv=none; b=npd4oG5C2tlcSftKLlceu22EUbr7Xt0hGtxaF418q785nBBB8SlPp1jlm7FEihix6001FFC+o4616BMplR1J3MvDTOFt3hg4LbeyAduHk7A/KP8vQ+e9kx/NbxODnKzt+trHN0qkQgi6u8jfcNbcDrrxg2IeIqrBftd0iFmHSyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710472043; c=relaxed/simple;
	bh=6lYTqdfGaED9bBcx3A78bnPc1ZpdAyPHBX3yhSNiIrU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o/K2LjMcrnwvmU4Dq+MaFuDzjPoiPPPRVTuwePrq769aClNYqhPjrhsIwRQQijdxYcBu4jQZxrKHFevN/PbPWMDitsazGMaJhvuiocuq3EX5cAJqSjmWFKaI6o/8OlotsmN+IO6F8XXr6g54w0OkQtMyfhqdr53Pfliw6mJntoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XMoUWt5K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58CB4C433F1;
	Fri, 15 Mar 2024 03:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710472042;
	bh=6lYTqdfGaED9bBcx3A78bnPc1ZpdAyPHBX3yhSNiIrU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XMoUWt5KRwLZSFLag7ec3RndzrJ5btvQkotqROm9fyslkgiC0wp7mapJ2U25h5FrJ
	 wkaXLuT2kHnxPyJGQ6n7RtqjCw0Pyu9VJN9M2DwFxx3m0db/SfgFkvdCAUWkzGUOyR
	 uviSwVLlWjrsjBcmNQaO3QxC7vMUmaoDi8sGT654WuAIMVxN0jFSXKpsQxTXDatctA
	 FL57VKc/i3172jp3jias8LI7r8lB7qpuyX4Uq2v7JYv+h2lkx7mVopQQulTbEBRWHO
	 5lEIHTDCHfeDqq7ZbrrYcCdz/ItI6O5GZBoEc2MHzeN331pd/80VrZx7MZNotDUnY9
	 kZ6MnQJumcytQ==
Message-ID: <2f52570e-da77-40f3-a886-2ee76059fc6b@kernel.org>
Date: Fri, 15 Mar 2024 11:07:17 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] f2fs: add REQ_TIME time update for some user behaviors
Content-Language: en-US
To: Zhiguo Niu <niuzhiguo84@gmail.com>
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 ke.wang@unisoc.com, hongyu.jin@unisoc.com
References: <1710303061-16822-1-git-send-email-zhiguo.niu@unisoc.com>
 <eeefebcb-54db-4087-9319-dd5f9b63a1da@kernel.org>
 <CAHJ8P3+mo+yT8wfv2Xd3Rb7sFtXufmOgh_6CLzZxM5CjtYWC2Q@mail.gmail.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <CAHJ8P3+mo+yT8wfv2Xd3Rb7sFtXufmOgh_6CLzZxM5CjtYWC2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/3/15 9:46, Zhiguo Niu wrote:
> On Thu, Mar 14, 2024 at 9:06 PM Chao Yu <chao@kernel.org> wrote:
>>
>> On 2024/3/13 12:11, Zhiguo Niu wrote:
>>> some user behaviors requested filesystem operations, which
>>> will cause filesystem not idle.
>>> Meanwhile adjust f2fs_update_time(REQ_TIME) of
>>> f2fs_ioc_defragment to successful case.
>>>
>>> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
>>> ---
>>>    fs/f2fs/file.c | 9 ++++++++-
>>>    1 file changed, 8 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>>> index 4dfe38e..dac3836 100644
>>> --- a/fs/f2fs/file.c
>>> +++ b/fs/f2fs/file.c
>>> @@ -2784,7 +2784,6 @@ static int f2fs_ioc_defragment(struct file *filp, unsigned long arg)
>>>        err = f2fs_defragment_range(sbi, filp, &range);
>>>        mnt_drop_write_file(filp);
>>>
>>> -     f2fs_update_time(sbi, REQ_TIME);
>>
>> I guess we need to call f2fs_update_time() here if any data was
>> migrated.
> OK!
>>
>> if (range->len)
>>          f2fs_update_time(sbi, REQ_TIME);
>>
>>>        if (err < 0)
>>>                return err;
>>>
>>> @@ -2792,6 +2791,7 @@ static int f2fs_ioc_defragment(struct file *filp, unsigned long arg)
>>>                                                        sizeof(range)))
>>>                return -EFAULT;
>>>
>>> +     f2fs_update_time(sbi, REQ_TIME);
>>>        return 0;
>>>    }
>>>
>>> @@ -3331,6 +3331,7 @@ static int f2fs_ioc_resize_fs(struct file *filp, unsigned long arg)
>>>        if (copy_from_user(&block_count, (void __user *)arg,
>>>                           sizeof(block_count)))
>>>                return -EFAULT;
>>> +     f2fs_update_time(sbi, REQ_TIME);
>>
>> There will be no further IO in the end of f2fs_ioc_resize_fs(), so we don't
>> need to update time to delay gc/discard thread?
>>
>>>
>>>        return f2fs_resize_fs(filp, block_count);
>>>    }
>>> @@ -3424,6 +3425,7 @@ static int f2fs_ioc_setfslabel(struct file *filp, unsigned long arg)
>>>        f2fs_up_write(&sbi->sb_lock);
>>>
>>>        mnt_drop_write_file(filp);
>>> +     f2fs_update_time(sbi, REQ_TIME);
>>
>> Ditto,
> Dear Chao,
> 
> The two parts you proposed should be similar to the below scenario?
> ---------------------------------------------------------
> static int f2fs_ioc_set_encryption_policy(struct file *filp, unsigned long arg)
> {
> struct inode *inode = file_inode(filp);
> 
> if (!f2fs_sb_has_encrypt(F2FS_I_SB(inode)))
> return -EOPNOTSUPP;
> 
> f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
> 
> return fscrypt_ioctl_set_policy(filp, (const void __user *)arg);

fscrypt_ioctl_set_policy() will dirty inode, so we need to keep
f2fs_update_time(), but it's better to update time after
fscrypt_ioctl_set_policy()?

Thanks,

> }
> -----------------------------------------------------------
> thanks!
> 
> 
>>
>> Thanks,
>>
>>>    out:
>>>        kfree(vbuf);
>>>        return err;
>>> @@ -3597,6 +3599,7 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
>>>
>>>        filemap_invalidate_unlock(inode->i_mapping);
>>>        f2fs_up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
>>> +     f2fs_update_time(sbi, REQ_TIME);
>>>    out:
>>>        inode_unlock(inode);
>>>
>>> @@ -3766,6 +3769,7 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
>>>                clear_inode_flag(inode, FI_COMPRESS_RELEASED);
>>>                inode_set_ctime_current(inode);
>>>                f2fs_mark_inode_dirty_sync(inode, true);
>>> +             f2fs_update_time(sbi, REQ_TIME);
>>>        }
>>>    unlock_inode:
>>>        inode_unlock(inode);
>>> @@ -3964,6 +3968,7 @@ static int f2fs_sec_trim_file(struct file *filp, unsigned long arg)
>>>        if (len)
>>>                ret = f2fs_secure_erase(prev_bdev, inode, prev_index,
>>>                                prev_block, len, range.flags);
>>> +     f2fs_update_time(sbi, REQ_TIME);
>>>    out:
>>>        filemap_invalidate_unlock(mapping);
>>>        f2fs_up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
>>> @@ -4173,6 +4178,7 @@ static int f2fs_ioc_decompress_file(struct file *filp)
>>>        if (ret)
>>>                f2fs_warn(sbi, "%s: The file might be partially decompressed (errno=%d). Please delete the file.",
>>>                          __func__, ret);
>>> +     f2fs_update_time(sbi, REQ_TIME);
>>>    out:
>>>        inode_unlock(inode);
>>>        file_end_write(filp);
>>> @@ -4252,6 +4258,7 @@ static int f2fs_ioc_compress_file(struct file *filp)
>>>        if (ret)
>>>                f2fs_warn(sbi, "%s: The file might be partially compressed (errno=%d). Please delete the file.",
>>>                          __func__, ret);
>>> +     f2fs_update_time(sbi, REQ_TIME);
>>>    out:
>>>        inode_unlock(inode);
>>>        file_end_write(filp);

