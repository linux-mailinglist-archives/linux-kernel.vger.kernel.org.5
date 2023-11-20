Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 713627F1456
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 14:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbjKTNYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 08:24:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232984AbjKTNYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 08:24:13 -0500
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8312131;
        Mon, 20 Nov 2023 05:24:08 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.216])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4SYpBB2lMMz4f3knr;
        Mon, 20 Nov 2023 21:24:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
        by mail.maildlp.com (Postfix) with ESMTP id EC84E1A02CA;
        Mon, 20 Nov 2023 21:24:03 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP1 (Coremail) with SMTP id cCh0CgA3iA7yXVtlJWLJBQ--.22273S3;
        Mon, 20 Nov 2023 21:24:03 +0800 (CST)
Subject: Re: [PATCH 1/2] block: introduce new field flags in block_device
To:     Hannes Reinecke <hare@suse.de>, Yu Kuai <yukuai1@huaweicloud.com>,
        axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        Ming Lei <ming.lei@redhat.com>,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20231120093847.2228127-1-yukuai1@huaweicloud.com>
 <20231120093847.2228127-2-yukuai1@huaweicloud.com>
 <f0ac497e-e599-4892-94f7-469660cb5f84@suse.de>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <1338945e-5033-3bb2-0480-7c6767bf0848@huaweicloud.com>
Date:   Mon, 20 Nov 2023 21:24:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <f0ac497e-e599-4892-94f7-469660cb5f84@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgA3iA7yXVtlJWLJBQ--.22273S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAFWxGw1xXF17Zw18CrWUtwb_yoW5Gr1Dpr
        ykJFy5WrWUGrn5Wr4xJr1UJFyrXw48t3W8Gryaya42yr4UJr1Yqr18Xry0gF17Ar4xJF47
        Xr1UJrWkZFyUGrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vI
        Y487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
        0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
        0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
        WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8
        JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUoOJ5UU
        UUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/11/20 18:45, Hannes Reinecke 写道:
> On 11/20/23 10:38, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> There are multiple switches in struct block_device, use seperate bool
>> fields for them is not gracefully. Add a new field flags and replace
>> swithes to a bit, there are no functional changes, and preapre to add
>> a new switch in the next patch.
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   block/bdev.c              | 15 ++++++++-------
>>   block/blk-core.c          |  7 ++++---
>>   block/genhd.c             |  8 +++++---
>>   block/ioctl.c             |  2 +-
>>   include/linux/blk_types.h | 12 ++++++------
>>   include/linux/blkdev.h    |  5 +++--
>>   6 files changed, 27 insertions(+), 22 deletions(-)
>>
>> diff --git a/block/bdev.c b/block/bdev.c
>> index fc8d28d77495..cb849bcf61ae 100644
>> --- a/block/bdev.c
>> +++ b/block/bdev.c
>> @@ -408,10 +408,10 @@ struct block_device *bdev_alloc(struct gendisk 
>> *disk, u8 partno)
>>       bdev->bd_partno = partno;
>>       bdev->bd_inode = inode;
>>       bdev->bd_queue = disk->queue;
>> -    if (partno)
>> -        bdev->bd_has_submit_bio = disk->part0->bd_has_submit_bio;
>> +    if (partno && test_bit(BD_FLAG_HAS_SUBMIT_BIO, &disk->part0->flags))
>> +        set_bit(BD_FLAG_HAS_SUBMIT_BIO, &bdev->flags);
>>       else
>> -        bdev->bd_has_submit_bio = false;
>> +        clear_bit(BD_FLAG_HAS_SUBMIT_BIO, &bdev->flags);
>>       bdev->bd_stats = alloc_percpu(struct disk_stats);
>>       if (!bdev->bd_stats) {
>>           iput(inode);
> 
> Couldn't you achieve the very same result by using 
> 'READ_ONCE()/WRITE_ONCE()' and keep the structure as-is?

Yes, remove this patch and add a new bool field in the next patch can
work as well, the idea here is replace multiple fields with a single
flag, and just use the flag in next patch. If people thinks add a new
bool field is better, I'll follow that.

Thanks,
Kuai

> 
> Cheers,
> 
> Hannes--
> Dr. Hannes Reinecke                   Kernel Storage Architect
> hare@suse.de                              +49 911 74053 688
> SUSE Software Solutions Germany GmbH, Frankenstr. 146, 90461 Nürnberg
> Managing Directors: I. Totev, A. McDonald, W. Knoblich
> (HRB 36809, AG Nürnberg)
> 
> .
> 

