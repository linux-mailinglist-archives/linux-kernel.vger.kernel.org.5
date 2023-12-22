Return-Path: <linux-kernel+bounces-9498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA46181C692
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 09:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60019286708
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 08:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336E718631;
	Fri, 22 Dec 2023 08:27:31 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27558182C1;
	Fri, 22 Dec 2023 08:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SxL514k0Sz4f3k68;
	Fri, 22 Dec 2023 16:27:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 1542B1A0B11;
	Fri, 22 Dec 2023 16:27:19 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgCn9QtkSIVlB1VIEQ--.51555S3;
	Fri, 22 Dec 2023 16:27:18 +0800 (CST)
Subject: Re: [PATCH] scsi: sd: unregister device if device_add_disk() failed
 in sd_probe()
To: Luis Chamberlain <mcgrof@kernel.org>, linan666@huaweicloud.com
Cc: jejb@linux.ibm.com, martin.petersen@oracle.com,
 linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linan122@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com,
 yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20231208082335.1754205-1-linan666@huaweicloud.com>
 <ZYUxZc/my2v6UfFJ@bombadil.infradead.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <78fb6d82-c50a-8fea-ae6d-551fd35656bf@huaweicloud.com>
Date: Fri, 22 Dec 2023 16:27:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZYUxZc/my2v6UfFJ@bombadil.infradead.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCn9QtkSIVlB1VIEQ--.51555S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCrWxArW8uw4rXFW5tw1DWrg_yoW5GF4xpF
	s8Xas0yrWUWrn8Cw1kZF47Za4UG3WIy3s3Xr45G34Yg3s3X34rKay3KFW5Xa4xArZrCF4U
	JrW5JFyvgF18Jr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
	GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU1zuWJUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2023/12/22 14:49, Luis Chamberlain Ð´µÀ:
> On Fri, Dec 08, 2023 at 04:23:35PM +0800, linan666@huaweicloud.com wrote:
>> From: Li Nan <linan122@huawei.com>
>>
>> "if device_add() succeeds, you should call device_del() when you want to
>> get rid of it."
>>
>> In sd_probe(), device_add_disk() fails when device_add() has already
>> succeeded, so change put_device() to device_unregister() to ensure device
>> resources are released.
>>
>> Fixes: 2a7a891f4c40 ("scsi: sd: Add error handling support for add_disk()")
>> Signed-off-by: Li Nan <linan122@huawei.com>
> 
> Nacked-by: Luis Chamberlain <mcgrof@kernel.org>
> 
>> ---
>>   drivers/scsi/sd.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
>> index 542a4bbb21bc..d81cbeee06eb 100644
>> --- a/drivers/scsi/sd.c
>> +++ b/drivers/scsi/sd.c
>> @@ -3736,7 +3736,7 @@ static int sd_probe(struct device *dev)
>>   
>>   	error = device_add_disk(dev, gd, NULL);
>>   	if (error) {
>> -		put_device(&sdkp->disk_dev);
>> +		device_unregister(&sdkp->disk_dev);
>>   		put_disk(gd);
>>   		goto out;
>>   	}
> 
> This is incorrect, device_unregister() calls:
> 
> void device_unregister(struct device *dev)
> {
> 	pr_debug("device: '%s': %s\n", dev_name(dev), __func__);
> 	device_del(dev);
> 	put_device(dev);
> }
> 
> So you're adding what you believe to be a correct missing device_del().
> But what you missed is that if device_add_disk() fails then device_add()
> did not succeed because the new code we have in the kernel *today* unwinds
> this for us now.

I'm confused here, there are two device here, one is 'sdkp->disk_dev',
one is gendisk->part0->bd_device, and the order in which they
initialize:

sd_probe
device_add(&sdkp->disk_dev) -> succeed
device_add_disk -> failed, and device_add(bd_device) did not succeed
put_device(&sdkp->disk_dev) -> device_del is missed

I don't see that if device_add_disk() fail, device_del() for
'sdkp->disk_dev'is called from anywhere. Do I missing anything?

Thanks,
Kuai

> 
> What you missed is that in today's code inside device_add_disk(), if
> device_add() succeeeds we now unwind and call device_del() for the
> device for you. And so, quoting the next sentence you took from
> device_add():
> 
> "If device_add() has *not* succeeded, use *only* put_device() to drop the
>   reference count."
> 
> Please do reference in the future a crash dump / or explain how you
> reached your conclusions if you do not have a crash dump to prove an
> issue. Specially if you are suggesting it Fixes a commit.
> 
>    Luis
> 
> .
> 


