Return-Path: <linux-kernel+bounces-147895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68AEA8A7B0E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 05:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9389EB215DF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 03:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788E68821;
	Wed, 17 Apr 2024 03:26:25 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438BE748F
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 03:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713324385; cv=none; b=t7dx8g1trAnwWN2sm4s/bgZ8X0PRzZNK7KUyOfa9/UG28ifKuBHN9WKJieg5GhxzlKaMKMuzJZe9W2AMRgTTFfsZiiG7Q4m3bZCw1NXEw65f2XbZacipXfsCoDpQEUxnMAitaGFajAh+tOt+rrS/hVE5vKGzwWNsLnADkjzHP18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713324385; c=relaxed/simple;
	bh=ZpvtkNlCfStNJiGm15ETpvK4/3ZMSGK0defN46MiN2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:CC:
	 In-Reply-To:Content-Type; b=pJnYNj+TP6ElHYM6uFRbC4inbtrpYJu3JUjTm5eRSb0R0pxU/LUsI98YaF2yjcKc8Byvj0z1tsUplRUB8SfXtZKq4bEFg7s40Tuoqi0lMNN9H6DiN5biuLF/nQsdPhWxmoi5PJ3RvYh7mel2ruS2pNTRBfMYovBYTkhrrwdXQfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4VK5pJ759Sz1RDd9;
	Wed, 17 Apr 2024 11:23:20 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id 262A91A016C;
	Wed, 17 Apr 2024 11:26:19 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Apr 2024 11:26:18 +0800
Message-ID: <47247f78-eafb-cb4f-495f-e91a647c3f3c@huawei.com>
Date: Wed, 17 Apr 2024 11:26:18 +0800
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
 <e70a28b4-074e-c48a-b717-3e17f1aae61d@huawei.com>
 <20240416-blumig-dachgeschoss-bc683f4ef1bf@brauner> <Zh6QC0++kpUUL5nf@debian>
 <779ff32f-3f3b-c602-5da8-c88b361716ac@huawei.com> <Zh898uJW0AFtE0Rk@debian>
From: Baokun Li <libaokun1@huawei.com>
CC: <linux-erofs@lists.ozlabs.org>, <chao@kernel.org>, <huyue2@coolpad.com>,
	<jefflexu@linux.alibaba.com>, <viro@zeniv.linux.org.uk>,
	<linux-kernel@vger.kernel.org>, <yangerkun@huawei.com>, <houtao1@huawei.com>,
	Baokun Li <libaokun1@huawei.com>
In-Reply-To: <Zh898uJW0AFtE0Rk@debian>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500021.china.huawei.com (7.185.36.21)

On 2024/4/17 11:11, Gao Xiang wrote:
> On Wed, Apr 17, 2024 at 10:59:53AM +0800, Baokun Li wrote:
>> On 2024/4/16 22:49, Gao Xiang wrote:
>>> On Tue, Apr 16, 2024 at 02:35:08PM +0200, Christian Brauner wrote:
>>>>>> I'm not sure how to resolve it in EROFS itself, anyway...
>>>> Instead of allocating the erofs_sb_info in fill_super() allocate it
>>>> during erofs_get_tree() and then you can ensure that you always have the
>>>> info you need available during erofs_kill_sb(). See the appended
>>>> (untested) patch.
>>> Hi Christian,
>>>
>>> Yeah, that is a good way I think.  Although sbi will be allocated
>>> unconditionally instead but that is minor.
>>>
>>> I'm on OSSNA this week, will test this patch more when returning.
>>>
>>> Hi Baokun,
>>>
>>> Could you also check this on your side?
>>>
>>> Thanks,
>>> Gao Xiang
>> Hi Xiang,
>>
>> This patch does fix the initial problem.
>>
>>
>> Hi Christian,
>>
>> Thanks for the patch, this is a good idea. Just with nits below.
>> Otherwise feel free to add.
>>
>> Reviewed-and-tested-by: Baokun Li <libaokun1@huawei.com>
>>>>   From e4f586a41748b6edc05aca36d49b7b39e55def81 Mon Sep 17 00:00:00 2001
>>>> From: Christian Brauner <brauner@kernel.org>
>>>> Date: Mon, 15 Apr 2024 20:17:46 +0800
>>>> Subject: [PATCH] erofs: reliably distinguish block based and fscache mode
>>>>
>> SNIP
>>
>>>> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
>>>> index c0eb139adb07..4ed80154edf8 100644
>>>> --- a/fs/erofs/super.c
>>>> +++ b/fs/erofs/super.c
>>>> @@ -581,7 +581,7 @@ static const struct export_operations erofs_export_ops = {
>>>>    static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>>>>    {
>>>>    	struct inode *inode;
>>>> -	struct erofs_sb_info *sbi;
>>>> +	struct erofs_sb_info *sbi = EROFS_SB(sb);
>>>>    	struct erofs_fs_context *ctx = fc->fs_private;
>>>>    	int err;
>>>> @@ -590,15 +590,10 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>>>>    	sb->s_maxbytes = MAX_LFS_FILESIZE;
>>>>    	sb->s_op = &erofs_sops;
>>>> -	sbi = kzalloc(sizeof(*sbi), GFP_KERNEL);
>>>> -	if (!sbi)
>>>> -		return -ENOMEM;
>>>> -
>>>>    	sb->s_fs_info = sbi;
>> This line is no longer needed.
>>>>    	sbi->opt = ctx->opt;
>>>>    	sbi->devs = ctx->devs;
>>>>    	ctx->devs = NULL;
>>>> -	sbi->fsid = ctx->fsid;
>>>>    	ctx->fsid = NULL;
>>>>    	sbi->domain_id = ctx->domain_id;
>>>>    	ctx->domain_id = NULL;
>> Since erofs_sb_info is now allocated in erofs_fc_get_tree(), why not
>> encapsulate the above lines as erofs_ctx_to_info() helper function
>> to be called in erofs_fc_get_tree()？Then erofs_fc_fill_super() wouldn't
>> have to use erofs_fs_context and would prevent the fsid from being
>> freed twice.
> Hi Baokun,
>
> I'm not sure if Christian has enough time to polish the whole
> codebase (I'm happy if do so).  Basically, that is just a hint
> to the issue, if you have more time, I guess you could also help
> revive this patch together (also because you also have a real
> EROFS test environment).
>
> Let me also check this next week after OSSNA travelling.
>
> Thanks,
> Gao Xiang

Hi Xiang,

Ok, then I will polish the patch and send it out as a v2.

Thanks,
Baokun

