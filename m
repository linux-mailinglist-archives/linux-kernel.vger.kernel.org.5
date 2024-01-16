Return-Path: <linux-kernel+bounces-27432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5137482EFF2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 14:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E19641F242E4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 13:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464B41BF24;
	Tue, 16 Jan 2024 13:46:30 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAE51BF23;
	Tue, 16 Jan 2024 13:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TDqzb3cbZz4f3jJ2;
	Tue, 16 Jan 2024 21:46:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 39D281A0A00;
	Tue, 16 Jan 2024 21:46:23 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgBnOBGtiKZlSqsRBA--.20499S3;
	Tue, 16 Jan 2024 21:46:23 +0800 (CST)
Subject: Re: PROBLEM: BLKPG_DEL_PARTITION with GENHD_FL_NO_PART used to return
 ENXIO, now returns EINVAL
To: Yu Kuai <yukuai1@huaweicloud.com>, Christoph Hellwig <hch@infradead.org>,
 Allison Karlitskaya <allison.karlitskaya@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, "yukuai (C)" <yukuai3@huawei.com>
References: <CAOYeF9VsmqKMcQjo1k6YkGNujwN-nzfxY17N3F-CMikE1tYp+w@mail.gmail.com>
 <ZaZesiKpbMEiiTrf@infradead.org>
 <210deda9-5439-244a-0ce2-af9dc8e5d7fe@huaweicloud.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <592625f7-36d7-02e0-2ee6-8211334aa0f9@huaweicloud.com>
Date: Tue, 16 Jan 2024 21:46:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <210deda9-5439-244a-0ce2-af9dc8e5d7fe@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBnOBGtiKZlSqsRBA--.20499S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJw13XFyDCrWkKr48CrWkXrb_yoW5trWDpr
	4vqrWUA3y5Grn3uFyUta17X34rGrnrtw18Jw18XF10vrW7ArnFqFy09ry09r4UXrZ7JFWf
	XF10vryxZ3W7ArUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
	IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHU
	DUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/01/16 21:23, Yu Kuai 写道:
> Hi, Christoph
> 
> 在 2024/01/16 18:47, Christoph Hellwig 写道:
>> Hi Allison,
>>
>> please try this minimal fix.  I need to double check if we historically
>> returned ENXIO or EINVAL for adding / resizing partitions, which would
>> make things more complicated.  Or maybe you already have data for that
>> at hand?
>>
>> diff --git a/block/ioctl.c b/block/ioctl.c
>> index 9c73a763ef8838..f2028e39767821 100644
>> --- a/block/ioctl.c
>> +++ b/block/ioctl.c
>> @@ -21,7 +21,7 @@ static int blkpg_do_ioctl(struct block_device *bdev,
>>       sector_t start, length;
>>       if (disk->flags & GENHD_FL_NO_PART)
>> -        return -EINVAL;
>> +        return -ENXIO;
> 
> I think this might not be a proper fix, the reason if that before this
> condition is added, -ENXIO is returned from bdev_del_partition(). And
> there are also some other error number like -EACCES,-EFAULT following,
> so this change will still make changes for user in other cases.

Please ignore the patch from last email. Sorry for the noise...
bdev_resize_partition() will also return -ENXIO if partition does't
exist. So the right patch should be following:

diff --git a/block/ioctl.c b/block/ioctl.c
index 4160f4e6bd5b..ba8d44fa7e02 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -20,8 +20,6 @@ static int blkpg_do_ioctl(struct block_device *bdev,
         struct blkpg_partition p;
         long long start, length;

-       if (disk->flags & GENHD_FL_NO_PART)
-               return -EINVAL;
         if (!capable(CAP_SYS_ADMIN))
                 return -EACCES;
         if (copy_from_user(&p, upart, sizeof(struct blkpg_partition)))
diff --git a/block/partitions/core.c b/block/partitions/core.c
index f47ffcfdfcec..f14602022c5e 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -447,6 +447,11 @@ int bdev_add_partition(struct gendisk *disk, int 
partno, sector_t start,
                 goto out;
         }

+       if (disk->flags & GENHD_FL_NO_PART) {
+               ret = -EINVAL;
+               goto out;
+       }
+
         if (partition_overlaps(disk, start, length, -1)) {
                 ret = -EBUSY;
                 goto out;

Thanks,
Kuai
> 
> How about following patch?
> 
> diff --git a/block/ioctl.c b/block/ioctl.c
> index 4160f4e6bd5b..ec012cf910dc 100644
> --- a/block/ioctl.c
> +++ b/block/ioctl.c
> @@ -20,8 +20,6 @@ static int blkpg_do_ioctl(struct block_device *bdev,
>          struct blkpg_partition p;
>          long long start, length;
> 
> -       if (disk->flags & GENHD_FL_NO_PART)
> -               return -EINVAL;
>          if (!capable(CAP_SYS_ADMIN))
>                  return -EACCES;
>          if (copy_from_user(&p, upart, sizeof(struct blkpg_partition)))
> @@ -38,6 +36,9 @@ static int blkpg_do_ioctl(struct block_device *bdev,
>          start = p.start >> SECTOR_SHIFT;
>          length = p.length >> SECTOR_SHIFT;
> 
> +       if (disk->flags & GENHD_FL_NO_PART)
> +               return -EINVAL;
> +
>          switch (op) {
>          case BLKPG_ADD_PARTITION:
>                  /* check if partition is aligned to blocksize */
> 
> Thanks,
> Kuai
> 
> 
>>       if (!capable(CAP_SYS_ADMIN))
>>           return -EACCES;
>>       if (copy_from_user(&p, upart, sizeof(struct blkpg_partition)))
>>
>> .
>>
> 
> .
> 


