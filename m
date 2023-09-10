Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2CB799C4E
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 04:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345419AbjIJCYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 22:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233350AbjIJCYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 22:24:52 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8801A5;
        Sat,  9 Sep 2023 19:24:47 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Rjtw95qwyz4f3mW7;
        Sun, 10 Sep 2023 10:24:41 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgD3jd3oKP1kixFWAA--.29639S3;
        Sun, 10 Sep 2023 10:24:42 +0800 (CST)
Subject: Re: [PATCH] md/raid1: only update stack limits with the device in use
To:     Song Liu <song@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Li Nan <linan122@huawei.com>, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        houtao1@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230906093720.1070929-1-linan122@huawei.com>
 <e67775c0-2d41-5541-a644-e5239ada3333@huaweicloud.com>
 <CAPhsuW5+Qxa4SKoaFrqZWKDmLaR0arXV7vqDX-Hy_OCEjmtA1w@mail.gmail.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <5e08c3aa-7bd5-f5dd-3d38-b93fb772ea56@huaweicloud.com>
Date:   Sun, 10 Sep 2023 10:24:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW5+Qxa4SKoaFrqZWKDmLaR0arXV7vqDX-Hy_OCEjmtA1w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3jd3oKP1kixFWAA--.29639S3
X-Coremail-Antispam: 1UD129KBjvJXoWxuF45try5XF4rAFyxWw17KFg_yoW5ZFyUp3
        yfJF1aka47XryI9r1IvryrWF1Fgw4UGFW8Kry7K342v34Dtry7Kr4xGrW5WryYqrs3Ar10
        vrn8KrZxCF1F9FJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7Mxk0xIA0c2IEe2xFo4CEbIxv
        r21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
        WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI
        7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
        1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4U
        MIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUU
        U==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/09/09 4:42, Song Liu 写道:
> On Wed, Sep 6, 2023 at 11:30 PM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>
>> Hi,
>>
>> 在 2023/09/06 17:37, Li Nan 写道:
>>> Spare device affects array stack limits is unreasonable. For example,
>>> create a raid1 with two 512 byte devices, the logical_block_size of array
>>> will be 512. But after add a 4k devcie as spare, logical_block_size of
>>> array will change as follows.
>>>
>>>     mdadm -C /dev/md0 -n 2 -l 10 /dev/sd[ab]   //sd[ab] is 512
>>>     //logical_block_size of md0: 512
>>>
>>>     mdadm --add /dev/md0 /dev/sdc                      //sdc is 4k
>>>     //logical_block_size of md0: 512
>>>
>>>     mdadm -S /dev/md0
>>>     mdadm -A /dev/md0 /dev/sd[ab]
>>>     //logical_block_size of md0: 4k
>>>
>>> This will confuse users, as nothing has been changed, why did the
>>> logical_block_size of array change?
>>>
>>> Now, only update logical_block_size of array with the device in use.
>>>
>>> Signed-off-by: Li Nan <linan122@huawei.com>
>>> ---
>>>    drivers/md/raid1.c | 19 ++++++++-----------
>>>    1 file changed, 8 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
>>> index 95504612b7e2..d75c5dd89e86 100644
>>> --- a/drivers/md/raid1.c
>>> +++ b/drivers/md/raid1.c
>>> @@ -3140,19 +3140,16 @@ static int raid1_run(struct mddev *mddev)
>>
>> I'm not sure about this behaviour, 'logical_block_size' can be
>> increased while adding new underlying disk, the key point is not when
>> to increase 'logical_block_size'. If there is a mounted fs, or
>> partition in the array, I think the array will be corrupted.
> 
> How common is such fs/partition corruption? I think some fs and partition
> table can work properly with 512=>4096 change?

For fs, that should depend on fs bs that is usually set in mkfs, if bs
is less than 4096, then such fs can't be mounted.

For partition, that is much worse, start sector and end sector will stay
the same, while sector size is changed. And 4096 -> 512 change is the
same.

Thanks,
Kuai

> 
> Thanks,
> Song
> 
>>
>> Perhaps once that array is started, logical_block_size should not be
>> changed anymore, this will require 'logical_block_size' to be metadate
>> inside raid superblock. And the array should deny any new disk with
>> bigger logical_block_size.
>>
>> Thanks,
>> Kuai
>>
>>
>>>        if (mddev->queue)
>>>                blk_queue_max_write_zeroes_sectors(mddev->queue, 0);
>>>
>>> -     rdev_for_each(rdev, mddev) {
>>> -             if (!mddev->gendisk)
>>> -                     continue;
>>> -             disk_stack_limits(mddev->gendisk, rdev->bdev,
>>> -                               rdev->data_offset << 9);
>>> -     }
>>> -
>>>        mddev->degraded = 0;
>>> -     for (i = 0; i < conf->raid_disks; i++)
>>> -             if (conf->mirrors[i].rdev == NULL ||
>>> -                 !test_bit(In_sync, &conf->mirrors[i].rdev->flags) ||
>>> -                 test_bit(Faulty, &conf->mirrors[i].rdev->flags))
>>> +     for (i = 0; i < conf->raid_disks; i++) {
>>> +             rdev = conf->mirrors[i].rdev;
>>> +             if (rdev && mddev->gendisk)
>>> +                     disk_stack_limits(mddev->gendisk, rdev->bdev,
>>> +                                       rdev->data_offset << 9);
>>> +             if (!rdev || !test_bit(In_sync, &rdev->flags) ||
>>> +                 test_bit(Faulty, &rdev->flags))
>>>                        mddev->degraded++;
>>> +     }
>>>        /*
>>>         * RAID1 needs at least one disk in active
>>>         */
>>>
>>
> .
> 

