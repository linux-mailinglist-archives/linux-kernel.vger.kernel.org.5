Return-Path: <linux-kernel+bounces-153291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D01E8ACC11
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3300D1F2252E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 11:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D384A1465B7;
	Mon, 22 Apr 2024 11:32:00 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D498C1465A8
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 11:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713785520; cv=none; b=NZW0rxm3nX0mcXy3Nc5uHiD+eIA9U5CvO7RTgCLvbgGbw5TzgF+3ffLngtrLHWQJsWT3hNUHEqv/uOGUMdX3R2n4yze6/Claf9QR0ZsolE91C3s9RZLXDA47wpNy7udfFXCMQXqt2wL/Wa/8YE4zLpzKtEiXqfr19XrTP/Fob5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713785520; c=relaxed/simple;
	bh=w3c2+u/vab98P6eyQA0WaxMSkXQUA8JtKNQ43t22moY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HxN/E3hwPzD8sTHDcs3eh+mJ1K8+/uPdjAXvNcJcWQQfCFYrDUkR3uxc2BUxHHI4z49IJcbvdxfsNzMmZ6N1WtheIRck7s6pi2A/Q6saZyZXMSZxWsEQuieBIhrQu5NBqsoxyyKIwhOVDrfmIzFP9r+RaUW3ZkocXrZXN1wTfIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4VNNNS6w6Tz1HBkv;
	Mon, 22 Apr 2024 19:30:48 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id 34B421403D1;
	Mon, 22 Apr 2024 19:31:48 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Apr 2024 19:31:47 +0800
Message-ID: <4e8dd4f5-29dc-9459-6ba2-f399258952dc@huawei.com>
Date: Mon, 22 Apr 2024 19:31:47 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH -next v3 1/2] erofs: get rid of erofs_fs_context
Content-Language: en-US
To: Jingbo Xu <jefflexu@linux.alibaba.com>, <linux-erofs@lists.ozlabs.org>
CC: <xiang@kernel.org>, <chao@kernel.org>, <huyue2@coolpad.com>,
	<viro@zeniv.linux.org.uk>, <brauner@kernel.org>,
	<linux-kernel@vger.kernel.org>, <yangerkun@huawei.com>, <houtao1@huawei.com>,
	Baokun Li <libaokun1@huawei.com>
References: <20240419123611.947084-1-libaokun1@huawei.com>
 <20240419123611.947084-2-libaokun1@huawei.com>
 <8d751a33-af11-4aa8-8fad-cc24e825bde7@linux.alibaba.com>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <8d751a33-af11-4aa8-8fad-cc24e825bde7@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500021.china.huawei.com (7.185.36.21)

Hi Jingbo,

On 2024/4/22 18:25, Jingbo Xu wrote:
>
> On 4/19/24 8:36 PM, Baokun Li wrote:
>
>> @@ -761,12 +747,15 @@ static void erofs_free_dev_context(struct erofs_dev_context *devs)
>>   
>>   static void erofs_fc_free(struct fs_context *fc)
>>   {
>> -	struct erofs_fs_context *ctx = fc->fs_private;
>> +	struct erofs_sb_info *sbi = fc->s_fs_info;
>> +
>> +	if (!sbi)
>> +		return;
>
> This is the only difference comparing to the original code literally.
> Is there any chance that fc->s_fs_info can be NULL when erofs_fc_free()
> is called?
>
> Otherwise looks good to me.
>
When sget_fc() executes successfully, fc->s_fs_info is set to NULL,
so the following NULL pointer dereference may occur:

do_new_mount
   vfs_get_tree
     erofs_fc_get_tree
       get_tree_bdev
         sget_dev
           sget_fc
             s = alloc_super
             s->s_fs_info = fc->s_fs_info;
             fc->s_fs_info = NULL;
         fill_super
         // return error
         deactivate_locked_super
           kfree(sbi);
   put_fs_context
     sbi = fc->s_fs_info
     kfree(sbi->fsid)

Thank you very much for the review!
-- 
With Best Regards,
Baokun Li

