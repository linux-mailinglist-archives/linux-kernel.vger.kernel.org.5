Return-Path: <linux-kernel+bounces-15215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5763982286C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 07:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EED51C22FB9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 06:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC67179AC;
	Wed,  3 Jan 2024 06:35:47 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AF714F6C;
	Wed,  3 Jan 2024 06:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4T4g2X3RVvz4f3kq0;
	Wed,  3 Jan 2024 14:35:32 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 39ECE1A0216;
	Wed,  3 Jan 2024 14:35:34 +0800 (CST)
Received: from [10.174.179.247] (unknown [10.174.179.247])
	by APP2 (Coremail) with SMTP id Syh0CgA320k0AJVlkkIVFg--.59295S3;
	Wed, 03 Jan 2024 14:35:34 +0800 (CST)
Message-ID: <d766a9cc-df46-5f0c-184d-19f4b9b2a8b7@huaweicloud.com>
Date: Wed, 3 Jan 2024 14:35:32 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 2/2] md: don't account sync_io if iostats of the disk
 is disabled
To: Yu Kuai <yukuai1@huaweicloud.com>, song@kernel.org, axboe@kernel.dk
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, yi.zhang@huawei.com, houtao1@huawei.com,
 yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20231223033703.2949831-1-linan666@huaweicloud.com>
 <20231223033703.2949831-3-linan666@huaweicloud.com>
 <e2305cc4-dc3e-7693-9b61-33896c1b7a37@huaweicloud.com>
From: Li Nan <linan666@huaweicloud.com>
In-Reply-To: <e2305cc4-dc3e-7693-9b61-33896c1b7a37@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgA320k0AJVlkkIVFg--.59295S3
X-Coremail-Antispam: 1UD129KBjvJXoW7CF4rXr4kZF4rJr4rtrWkWFg_yoW8tF17pa
	ykJFySkryUZr4rWw1UXryUCFyrWw17tayDJry7Aa43XFy3JrnIgFWUWFZ0gF1DXFW8GF1U
	tw1UXFZ8Za10vrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v
	4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF
	04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
	CY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUOlksUUUUU
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/



在 2024/1/3 11:16, Yu Kuai 写道:
> 
> 
> 在 2023/12/23 11:37, linan666@huaweicloud.com 写道:
>> From: Li Nan <linan122@huawei.com>
>>
>> If iostats is disabled, disk_stats will not be updated and
>> part_stat_read_accum() only returns a constant value. In this case,
>> continuing to count sync_io and to check is_mddev_idle() is no longer
>> meaningful.
>>
>> Signed-off-by: Li Nan <linan122@huawei.com>
>> ---
>>   drivers/md/md.h | 3 ++-
>>   drivers/md/md.c | 4 ++++
>>   2 files changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/md/md.h b/drivers/md/md.h
>> index 1a4f976951c1..e2d03a7a858c 100644
>> --- a/drivers/md/md.h
>> +++ b/drivers/md/md.h
>> @@ -584,7 +584,8 @@ extern void mddev_unlock(struct mddev *mddev);
>>   static inline void md_sync_acct(struct block_device *bdev, unsigned 
>> long nr_sectors)
>>   {
>> -    atomic64_add(nr_sectors, &bdev->bd_disk->sync_io);
>> +    if (blk_queue_io_stat(bdev->bd_disk->queue))
>> +        atomic64_add(nr_sectors, &bdev->bd_disk->sync_io);
>>   }
>>   static inline void md_sync_acct_bio(struct bio *bio, unsigned long 
>> nr_sectors)
>> diff --git a/drivers/md/md.c b/drivers/md/md.c
>> index a6829ea5b560..b56614eae8dc 100644
>> --- a/drivers/md/md.c
>> +++ b/drivers/md/md.c
>> @@ -8502,6 +8502,10 @@ static int is_mddev_idle(struct mddev *mddev, 
>> int init)
>>       rcu_read_lock();
>>       rdev_for_each_rcu(rdev, mddev) {
>>           struct gendisk *disk = rdev->bdev->bd_disk;
>> +
>> +        if (!blk_queue_io_stat(disk->queue))
>> +            continue;
> 
> Consider that the queue flag can be set/cleared through sysfs, let's
> keep set rdev->last_events in the case 'init'. To prevent a false
> positive(althrough highly unlikely) if iostat is enabled during
> md_do_sync().
> 

Thanks for your review, I will add checks of 'init' in next version.

> Thanks,
> Kuai
> 
>> +
>>           curr_events =
>>               (long long)part_stat_read_accum(disk->part0, sectors) -
>>               atomic64_read(&disk->sync_io);
>>

-- 
Thanks,
Nan


