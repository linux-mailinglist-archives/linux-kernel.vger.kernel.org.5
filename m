Return-Path: <linux-kernel+bounces-682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F422814472
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 10:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C978B1F2349A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 09:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB7318B1D;
	Fri, 15 Dec 2023 09:29:36 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB7618AE8;
	Fri, 15 Dec 2023 09:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Ss3p01tsmz4f3kKj;
	Fri, 15 Dec 2023 17:29:28 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 85FEF1A09B4;
	Fri, 15 Dec 2023 17:29:29 +0800 (CST)
Received: from [10.174.179.247] (unknown [10.174.179.247])
	by APP2 (Coremail) with SMTP id Syh0CgD3Tk1tHHxlWUFGDw--.9020S3;
	Fri, 15 Dec 2023 17:29:29 +0800 (CST)
Message-ID: <4234595e-f34a-5ea1-b91b-9831215f556e@huaweicloud.com>
Date: Fri, 15 Dec 2023 17:29:17 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 2/2] md: don't account sync_io if iostats of the disk
 is disabled
To: Song Liu <song@kernel.org>, linan666@huaweicloud.com
Cc: axboe@kernel.dk, linux-raid@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 yukuai3@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com,
 yangerkun@huawei.com
References: <20231215013931.3329455-1-linan666@huaweicloud.com>
 <20231215013931.3329455-3-linan666@huaweicloud.com>
 <CAPhsuW7aQoh-sHqJ1de+z7rHZLbbXVimUtxae1pBbzOQxXAB_Q@mail.gmail.com>
From: Li Nan <linan666@huaweicloud.com>
In-Reply-To: <CAPhsuW7aQoh-sHqJ1de+z7rHZLbbXVimUtxae1pBbzOQxXAB_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgD3Tk1tHHxlWUFGDw--.9020S3
X-Coremail-Antispam: 1UD129KBjvJXoW7CF4rXr4kZF4rJr4rtrWkWFg_yoW8ZryUpF
	WkGa4akryUXrWY93W2q34UCFyFgw17KrZ7Cry7A34fXF98KrnxGF1xWFWYqr1kZFyrWF42
	va1DWa909a1FyrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBI14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v
	4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF
	04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
	CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbHa0DUUUUU==
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/



在 2023/12/15 17:08, Song Liu 写道:
> On Thu, Dec 14, 2023 at 5:41 PM <linan666@huaweicloud.com> wrote:
>>
>> From: Li Nan <linan122@huawei.com>
>>
>> If iostats is disabled, disk_stats will not be updated and
>> part_stat_read_accum() only returns a constant value. In this case,
>> continuing to count sync_io and to check is_mddev_idle() is no longer
>> meaningful.
>>
>> Signed-off-by: Li Nan <linan122@huawei.com>
>> ---
>>   drivers/md/md.h | 3 ++-
>>   drivers/md/md.c | 4 ++++
>>   2 files changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/md/md.h b/drivers/md/md.h
>> index 1a4f976951c1..75f5c5d04e71 100644
>> --- a/drivers/md/md.h
>> +++ b/drivers/md/md.h
>> @@ -589,7 +589,8 @@ static inline void md_sync_acct(struct block_device *bdev, unsigned long nr_sect
>>
>>   static inline void md_sync_acct_bio(struct bio *bio, unsigned long nr_sectors)
>>   {
>> -       md_sync_acct(bio->bi_bdev, nr_sectors);
>> +       if (blk_queue_io_stat(bio->bi_bdev->bd_disk->queue))
>> +               md_sync_acct(bio->bi_bdev, nr_sectors);
> 
> Do we need the same check for md_sync_acct()?
> 
>>   }
>>
>>   struct md_personality
>> diff --git a/drivers/md/md.c b/drivers/md/md.c
>> index 1d71b2a9af03..18bbceb0ffd6 100644
>> --- a/drivers/md/md.c
>> +++ b/drivers/md/md.c
>> @@ -8502,6 +8502,10 @@ static int is_mddev_idle(struct mddev *mddev, int init)
>>          rcu_read_lock();
>>          rdev_for_each_rcu(rdev, mddev) {
>>                  struct gendisk *disk = rdev->bdev->bd_disk;
>> +
>> +               if (blk_queue_io_stat(mddev->queue))
>> +                       continue;
> 
> This looks weird. Do you mean
> 
>     if (!blk_queue_io_stat(disk->queue))
> 
> Note that I changed two things here: 1) add "!"; 2) check disk, not mddev.
> 
> Did I miss something?
> 
> Thanks,
> Song
> 

Yeah... It's my bad. I will fix it in v3.

>> +
>>                  curr_events =
>>                          (long long)part_stat_read_accum(disk->part0, sectors) -
>>                                atomic64_read(&disk->sync_io);
>> --
>> 2.39.2
>>
> 
> .

-- 
Thanks,
Nan


