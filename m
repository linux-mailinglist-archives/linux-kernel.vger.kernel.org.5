Return-Path: <linux-kernel+bounces-141812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47AD58A23CA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 04:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D46231F22EC9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 02:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE791094E;
	Fri, 12 Apr 2024 02:31:22 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E92E205E34;
	Fri, 12 Apr 2024 02:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712889082; cv=none; b=QpOMhPHyJQBFaXSTO7LHaSAgcoqGGlDa/LFWYAoBvNGcFFhcJQupdQdZ2wIkWk6s8V3FUCW7B6QG+C3W0ZS7w6ajSlPW6MQxOUyZKy0e7Z4fvMlQby9jYqCnQQWGn1F8xhgWPrtBEIuSnkNkn2lNxcNgoKNg4OQOU+xCyuflagI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712889082; c=relaxed/simple;
	bh=GYv3jLCzBzSLGkmeYDpAlmFWCL32zZ6LZ0+zXlJPS18=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=pB7NKRkGnQPjtARWQu9X6DOKMrSYz6rCjKPre7GtEjw5BJ+RXXPxETgC5WY1eG5mz0/T4+EC9DUmoe8ivs+ZjZro1Ru/mgd+kBW4Z7YSWEZjtn/R06FJQ3w7vipI/yPT+Eol0PTHyBSkYeNJ1rbrJBt/UyhbeCUnO8OV311SLlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4VG0qD4MWyz2CcD9;
	Fri, 12 Apr 2024 10:28:24 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id F36701A0172;
	Fri, 12 Apr 2024 10:31:17 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Apr 2024 10:31:17 +0800
Message-ID: <fa1e422c-17bd-4dff-abbd-660e15d87256@huawei.com>
Date: Fri, 12 Apr 2024 10:31:17 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] bcachefs: chardev: make bch_chardev_class constant
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
To: "Ricardo B. Marliere" <ricardo@marliere.net>, Kent Overstreet
	<kent.overstreet@linux.dev>, Brian Foster <bfoster@redhat.com>
CC: <linux-bcachefs@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20240308-bcachefs-v2-1-3e84c845055e@marliere.net>
 <4ddd2362-2383-434a-b4b0-2075072572d6@huawei.com>
In-Reply-To: <4ddd2362-2383-434a-b4b0-2075072572d6@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500022.china.huawei.com (7.185.36.66)

On 2024/3/11 9:41, Hongbo Li wrote:
> It's fine for me.
> 
> On 2024/3/8 20:12, Ricardo B. Marliere wrote:
>> Since commit 43a7206b0963 ("driver core: class: make class_register() 
>> take
>> a const *"), the driver core allows for struct class to be in read-only
>> memory, so move the bch_chardev_class structure to be declared at build
>> time placing it into read-only memory, instead of having to be 
>> dynamically
>> allocated at boot time. Also, correctly clean up after failing paths in
>> bch2_chardev_init().
>>
>> Cc: Hongbo Li <lihongbo22@huawei.com>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
>> ---
>> Changes in v2:
>> - Used "free the last thing" pattern in bch2_chardev_init().
>> - Link to v1: 
>> https://lore.kernel.org/r/20240305-bcachefs-v1-1-436196e25729@marliere.net
>> ---
>>   fs/bcachefs/chardev.c | 35 ++++++++++++++++++++++-------------
>>   1 file changed, 22 insertions(+), 13 deletions(-)
>>
>> diff --git a/fs/bcachefs/chardev.c b/fs/bcachefs/chardev.c
>> index 226b39c17667..dc09f547dae6 100644
>> --- a/fs/bcachefs/chardev.c
>> +++ b/fs/bcachefs/chardev.c
>> @@ -940,7 +940,9 @@ static const struct file_operations 
>> bch_chardev_fops = {
>>   };
>>   static int bch_chardev_major;
>> -static struct class *bch_chardev_class;
>> +static const struct class bch_chardev_class = {
>> +    .name = "bcachefs",
>> +};
>>   static struct device *bch_chardev;
>>   void bch2_fs_chardev_exit(struct bch_fs *c)
>> @@ -957,7 +959,7 @@ int bch2_fs_chardev_init(struct bch_fs *c)
>>       if (c->minor < 0)
>>           return c->minor;
>> -    c->chardev = device_create(bch_chardev_class, NULL,
>> +    c->chardev = device_create(&bch_chardev_class, NULL,
>>                      MKDEV(bch_chardev_major, c->minor), c,
>>                      "bcachefs%u-ctl", c->minor);
>>       if (IS_ERR(c->chardev))
>> @@ -968,32 +970,39 @@ int bch2_fs_chardev_init(struct bch_fs *c)
>>   void bch2_chardev_exit(void)
>>   {
>> -    if (!IS_ERR_OR_NULL(bch_chardev_class))
>> -        device_destroy(bch_chardev_class,
>> -                   MKDEV(bch_chardev_major, U8_MAX));
>> -    if (!IS_ERR_OR_NULL(bch_chardev_class))
>> -        class_destroy(bch_chardev_class);
>> +    device_destroy(&bch_chardev_class, MKDEV(bch_chardev_major, 
>> U8_MAX));
>> +    class_unregister(&bch_chardev_class);
>>       if (bch_chardev_major > 0)
>>           unregister_chrdev(bch_chardev_major, "bcachefs");
>>   }
>>   int __init bch2_chardev_init(void)
>>   {
>> +    int ret;
>> +
>>       bch_chardev_major = register_chrdev(0, "bcachefs-ctl", 
>> &bch_chardev_fops);
>>       if (bch_chardev_major < 0)
>>           return bch_chardev_major;
>> -    bch_chardev_class = class_create("bcachefs");
>> -    if (IS_ERR(bch_chardev_class))
>> -        return PTR_ERR(bch_chardev_class);
>> +    ret = class_register(&bch_chardev_class);
>> +    if (ret)
>> +        goto major_out;
>> -    bch_chardev = device_create(bch_chardev_class, NULL,
>> +    bch_chardev = device_create(&bch_chardev_class, NULL,
>>                       MKDEV(bch_chardev_major, U8_MAX),
>>                       NULL, "bcachefs-ctl");
>> -    if (IS_ERR(bch_chardev))
>> -        return PTR_ERR(bch_chardev);
>> +    if (IS_ERR(bch_chardev)) {
>> +        ret = PTR_ERR(bch_chardev);
>> +        goto class_out;
>> +    }
>>       return 0;
>> +
>> +class_out:
>> +    class_unregister(&bch_chardev_class);
>> +major_out:
>> +    unregister_chrdev(bch_chardev_major, "bcachefs-ctl");
>> +    return ret;
>>   }
>>   #endif /* NO_BCACHEFS_CHARDEV */
>>
>> ---
>> base-commit: 90d35da658da8cff0d4ecbb5113f5fac9d00eb72
>> change-id: 20240305-bcachefs-27a4bb8b9f4f
>>
>> Best regards,
> 

This is a useful patch, and also works on latest code. Maybe we almost 
forgot it.

Reviewed-by: Hongbo Li <lihongbo22@huawei.com>

