Return-Path: <linux-kernel+bounces-146089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6FA08A606B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 03:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 646B7281C52
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 01:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675F56AC0;
	Tue, 16 Apr 2024 01:36:22 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D09181F
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 01:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713231382; cv=none; b=fpI7BdLGahS9jGWKVFvmZkK+AbCeKOeC2MJ4X2/ZDFv2LSf+OMuGrRQr6SOewc4zPSAhgdLR5mDihTZg8aNmJnrhXofggKd5X45y9ckdE8dLDUG44odLWYQQSgxXMwWm0kJwhrBUwrOHIyhS+docxmrsjDtiGmbey1CZQ73a6K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713231382; c=relaxed/simple;
	bh=3amiQ03RMCoxyggznK91Girfddi3N1TZToJluc7rGRw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:CC:
	 In-Reply-To:Content-Type; b=K8LLhJT8G6HCVckAfytYABtoxpfjqat5o9ttdwIAx7cdHGij3LuLE3ybMw/mXFJxxy49dAP9H/ZdEkwhpl90Dew9bRxHH1TRlLe1qdPHWEuXSi/dOAX3YWXfWzqCnaK1h/gEbI8ExUYAAM3RVjGmyLxG0gmVBHQ1F7dKFqMdYB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4VJRPk1fCXz1hwbS;
	Tue, 16 Apr 2024 09:33:14 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id E03631403D1;
	Tue, 16 Apr 2024 09:36:10 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 16 Apr 2024 09:36:10 +0800
Message-ID: <e70a28b4-074e-c48a-b717-3e17f1aae61d@huawei.com>
Date: Tue, 16 Apr 2024 09:36:10 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] erofs: set SB_NODEV sb_flags when mounting with fsid
Content-Language: en-US
To: Christian Brauner <brauner@kernel.org>, <xiang@kernel.org>
References: <20240415121746.1207242-1-libaokun1@huawei.com>
 <20240415-betagten-querlatte-feb727ed56c1@brauner>
 <15ab9875-5123-7bc2-bb25-fc683129ad9e@huawei.com> <Zh3NAgWvNASTZSea@debian>
From: Baokun Li <libaokun1@huawei.com>
CC: <linux-erofs@lists.ozlabs.org>, <chao@kernel.org>, <huyue2@coolpad.com>,
	<jefflexu@linux.alibaba.com>, <viro@zeniv.linux.org.uk>,
	<linux-kernel@vger.kernel.org>, <yangerkun@huawei.com>, <houtao1@huawei.com>,
	Baokun Li <libaokun1@huawei.com>
In-Reply-To: <Zh3NAgWvNASTZSea@debian>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500021.china.huawei.com (7.185.36.21)

On 2024/4/16 8:57, Gao Xiang wrote:
> Hi Christian, Baokun,
>
> On Mon, Apr 15, 2024 at 11:23:58PM +0800, Baokun Li wrote:
>> On 2024/4/15 21:38, Christian Brauner wrote:
>>> On Mon, Apr 15, 2024 at 08:17:46PM +0800, Baokun Li wrote:
>>>> When erofs_kill_sb() is called in block dev based mode, s_bdev may not have
>>>> been initialised yet, and if CONFIG_EROFS_FS_ONDEMAND is enabled, it will
>>>> be mistaken for fscache mode, and then attempt to free an anon_dev that has
>>>> never been allocated, triggering the following warning:
>>>>
>>>> ============================================
>>>> ida_free called for id=0 which is not allocated.
>>>> WARNING: CPU: 14 PID: 926 at lib/idr.c:525 ida_free+0x134/0x140
>>>> Modules linked in:
>>>> CPU: 14 PID: 926 Comm: mount Not tainted 6.9.0-rc3-dirty #630
>>>> RIP: 0010:ida_free+0x134/0x140
>>>> Call Trace:
>>>>    <TASK>
>>>>    erofs_kill_sb+0x81/0x90
>>>>    deactivate_locked_super+0x35/0x80
>>>>    get_tree_bdev+0x136/0x1e0
>>>>    vfs_get_tree+0x2c/0xf0
>>>>    do_new_mount+0x190/0x2f0
>>>>    [...]
>>>> ============================================
>>>>
>>>> To avoid this problem, add SB_NODEV to fc->sb_flags after successfully
>>>> parsing the fsid, and then the superblock inherits this flag when it is
>>>> allocated, so that the sb_flags can be used to distinguish whether it is
>>>> in block dev based mode when calling erofs_kill_sb().
>>>>
>>>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>>>> ---
>>>>    fs/erofs/super.c | 7 +++----
>>>>    1 file changed, 3 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
>>>> index b21bd8f78dc1..7539ce7d64bc 100644
>>>> --- a/fs/erofs/super.c
>>>> +++ b/fs/erofs/super.c
>>>> @@ -520,6 +520,7 @@ static int erofs_fc_parse_param(struct fs_context *fc,
>>>>    		ctx->fsid = kstrdup(param->string, GFP_KERNEL);
>>>>    		if (!ctx->fsid)
>>>>    			return -ENOMEM;
>>>> +		fc->sb_flags |= SB_NODEV;
>>> Hm, I wouldn't do it this way. That's an abuse of that flag imho.
>>> Record the information in the erofs_fs_context if you need to.
>> The stack diagram that triggers the problem is as follows, the call to
>> erofs_kill_sb() fails before fill_super() has been executed, and we can
>> only use super_block to determine whether it is currently in nodev
>> fscahe mode or block device based mode. So if it is recorded in
>> erofs_fs_context (aka fc->fs_private), we can't access the recorded data
>> unless we pass fc into erofs_kill_sb() as well.
>>
> If I understand correctly, from the discussion above, I think
> there exists a gap between alloc_super() and sb->s_bdev is set.
> But .kill_sb() can be called between them and fc is not passed
> into .kill_sb().
>
> I'm not sure how to resolve it in EROFS itself, anyway...
>
> Thanks,
> Gao Xiang
Yes, exactly!

There is no fill_super between alloc_super() and kill_sb(), so erofs has
no way to set a flag for the superblock directly. The only way I can
think of now is to modify fc->sb_flags in erofs_fc_parse_param()
to indirectly set a flag for the superblock.

Cheers,
Baokun

