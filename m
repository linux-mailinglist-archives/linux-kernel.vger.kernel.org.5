Return-Path: <linux-kernel+bounces-93937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 300E9873735
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45ABCB2132C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 13:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD59130AC3;
	Wed,  6 Mar 2024 13:02:06 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD0F7FBAF;
	Wed,  6 Mar 2024 13:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709730125; cv=none; b=toodEE6TsuvMVLmhkZjvh1ZbMJprPbOsHXruww5XFWg2lkgvbAVHoawXgJIgp6BT5bA24gC67jfhRTUPVrRvU44n56dvSe3VPI7VvnMx+ztyD21P0DL0W8baeCZyfqqgjD71PB4zDXyaTTA252ng5dOCladJFCgrM+olUggGnaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709730125; c=relaxed/simple;
	bh=sLNJRztVhA8TtYhb/exdQXUkIVIKU+BQJpgybmhd68U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bfu3gAIAJcMJnBTIxmmZmfwTwoaEnFKVi/k2l5ku1hnfNcNU4AlqG6TiiatW6rpPvS+Q+tnRPef/w31dLMrOSl8tf65cOsenimqZ0doFHaU38KVouFuoqMVaknL20+arrAuv0FEUCiQ7f+b39Y3OGNBQMpkr0J9tJTIhXwX/SnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TqXZf5hkTz2Bdtb;
	Wed,  6 Mar 2024 20:59:38 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 0A4451A016E;
	Wed,  6 Mar 2024 21:02:00 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 6 Mar 2024 21:01:59 +0800
Message-ID: <df64802a-02fd-4f72-b9ec-7812e2779df3@huawei.com>
Date: Wed, 6 Mar 2024 21:01:59 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bcachefs: chardev: make bch_chardev_class constant
Content-Language: en-US
To: "Ricardo B. Marliere" <ricardo@marliere.net>
CC: Kent Overstreet <kent.overstreet@linux.dev>, Brian Foster
	<bfoster@redhat.com>, <linux-bcachefs@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
References: <20240305-bcachefs-v1-1-436196e25729@marliere.net>
 <d1209aa3-b8d4-4509-9689-4882bc079ffd@huawei.com>
 <sky4no6qxoytrkd3azcf5hokmhxrrpluao5ilhbqvprqxwuj4r@ozwmbbulfbrt>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <sky4no6qxoytrkd3azcf5hokmhxrrpluao5ilhbqvprqxwuj4r@ozwmbbulfbrt>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500022.china.huawei.com (7.185.36.66)



On 2024/3/6 19:50, Ricardo B. Marliere wrote:
> On  6 Mar 09:23, Hongbo Li wrote:
>> On 2024/3/6 4:21, Ricardo B. Marliere wrote:
>>> Since commit 43a7206b0963 ("driver core: class: make class_register() take
>>> a const *"), the driver core allows for struct class to be in read-only
>>> memory, so move the bch_chardev_class structure to be declared at build
>>> time placing it into read-only memory, instead of having to be dynamically
>>> allocated at boot time.
>>>
>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
>>> ---
>>>    fs/bcachefs/chardev.c | 23 ++++++++++++-----------
>>>    1 file changed, 12 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/fs/bcachefs/chardev.c b/fs/bcachefs/chardev.c
>>> index 226b39c17667..af587453fd3d 100644
>>> --- a/fs/bcachefs/chardev.c
>>> +++ b/fs/bcachefs/chardev.c
>>> @@ -940,7 +940,9 @@ static const struct file_operations bch_chardev_fops = {
>>>    };
>>>    
>>>    static int bch_chardev_major;
>>> -static struct class *bch_chardev_class;
>>> +static const struct class bch_chardev_class = {
>>> +	.name = "bcachefs",
>>> +};
>>>    static struct device *bch_chardev;
>>>    
>>>    void bch2_fs_chardev_exit(struct bch_fs *c)
>>> @@ -957,7 +959,7 @@ int bch2_fs_chardev_init(struct bch_fs *c)
>>>    	if (c->minor < 0)
>>>    		return c->minor;
>>>    
>>> -	c->chardev = device_create(bch_chardev_class, NULL,
>>> +	c->chardev = device_create(&bch_chardev_class, NULL,
>>>    				   MKDEV(bch_chardev_major, c->minor), c,
>>>    				   "bcachefs%u-ctl", c->minor);
>>>    	if (IS_ERR(c->chardev))
>>> @@ -968,26 +970,25 @@ int bch2_fs_chardev_init(struct bch_fs *c)
>>>    
>>>    void bch2_chardev_exit(void)
>>>    {
>>> -	if (!IS_ERR_OR_NULL(bch_chardev_class))
>>> -		device_destroy(bch_chardev_class,
>>> -			       MKDEV(bch_chardev_major, U8_MAX));
>>> -	if (!IS_ERR_OR_NULL(bch_chardev_class))
>>> -		class_destroy(bch_chardev_class);
>>> +	device_destroy(&bch_chardev_class, MKDEV(bch_chardev_major, U8_MAX));
>>> +	class_unregister(&bch_chardev_class);
>>>    	if (bch_chardev_major > 0)
>>>    		unregister_chrdev(bch_chardev_major, "bcachefs");
>>>    }
>>>    
>>>    int __init bch2_chardev_init(void)
>>>    {
>>> +	int ret;
>>> +
>>>    	bch_chardev_major = register_chrdev(0, "bcachefs-ctl", &bch_chardev_fops);
>>>    	if (bch_chardev_major < 0)
>>>    		return bch_chardev_major;
>>>    
>>> -	bch_chardev_class = class_create("bcachefs");
>>> -	if (IS_ERR(bch_chardev_class))
>>> -		return PTR_ERR(bch_chardev_class);
>>> +	ret = class_register(&bch_chardev_class);
>>> +	if (ret)
>> Here, I think you should call class_unregister to relase resource which
>> allocated before. And the same thing shoud be done in other exception exit.
> 
> Hi Hongbo,
> 
> Thank you for the feedback. Did you mean that bch_chardev_major should
> be unregistered if the class_register() call fails? Because if it does,
> there is no need to call class_unregister().
> 
>>> +		return ret;
>>>    
>>> -	bch_chardev = device_create(bch_chardev_class, NULL,
>>> +	bch_chardev = device_create(&bch_chardev_class, NULL,
>>>    				    MKDEV(bch_chardev_major, U8_MAX),
>>>    				    NULL, "bcachefs-ctl");
>>>    	if (IS_ERR(bch_chardev))
>> like here..
> 
> Can you please elaborate?
> 
Yes, this I mean. The example like this:

```c
    major = register_chrdev(0, xx, xx);
    class = class_create("bcachefs");
    if (IS_ERR(class))
         goto out_chrdev:

    ...
out_class:
     class_unregister(xxx);
out_chrdev:
     unregister_chrdev(xx, xx);
     ...
```

Although this was not part of your original intention, it is indeed a flaw.


> Best regards,
> -	Ricardo.
> 
> 
>>>
>>> ---
>>> base-commit: 90d35da658da8cff0d4ecbb5113f5fac9d00eb72
>>> change-id: 20240305-bcachefs-27a4bb8b9f4f
>>>
>>> Best regards,
> 

