Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E54DD7F2B70
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 12:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbjKULGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 06:06:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbjKULGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 06:06:45 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D890E83;
        Tue, 21 Nov 2023 03:06:36 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.235])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SZM513bg9z4f3mHV;
        Tue, 21 Nov 2023 19:06:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
        by mail.maildlp.com (Postfix) with ESMTP id B3D1B1A0577;
        Tue, 21 Nov 2023 19:06:33 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP1 (Coremail) with SMTP id cCh0CgDn6hA4j1xl+lIgBg--.44717S3;
        Tue, 21 Nov 2023 19:06:33 +0800 (CST)
Subject: Re: [PATCH v2 1/2] block: introduce new field flags in block_device
To:     Ming Lei <ming.lei@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20231121111927.2021846-1-yukuai1@huaweicloud.com>
 <20231121111927.2021846-2-yukuai1@huaweicloud.com> <ZVx5XE3o+D8pGPib@fedora>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <20516413-c04b-feb9-9757-84e3d83baa94@huaweicloud.com>
Date:   Tue, 21 Nov 2023 19:06:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <ZVx5XE3o+D8pGPib@fedora>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgDn6hA4j1xl+lIgBg--.44717S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Gw43CF4kJw47Jw48Jr4DXFb_yoW3XrWkpr
        WkGFWYk3yUGr1fWa1Iq3W7JF4Fgw40kr1xC3y3C342yrZIyrn7WF18JryY9as7urWxCFWx
        XFn8uFW3CryIka7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
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
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

ÔÚ 2023/11/21 17:33, Ming Lei Ð´µÀ:
> On Tue, Nov 21, 2023 at 07:19:26PM +0800, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> There are multiple switches in struct block_device, use separate bool
>> fields for them is not gracefully. Add a new field flags and replace
>> swithes to a bit, there are no functional changes, and preare to add
>> a new switch in the next patch.
>>
>> In order to keep flags in the first cacheline, define it as u32 and add
>> new helpers to set/clear/test each bit like 'bio->bi_flags'.
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   block/bdev.c              | 15 ++++++++-------
>>   block/blk-core.c          |  7 ++++---
>>   block/genhd.c             | 15 +++++++++++----
>>   block/ioctl.c             |  6 +++++-
>>   include/linux/blk_types.h | 27 +++++++++++++++++++++------
>>   include/linux/blkdev.h    |  5 +++--
>>   6 files changed, 52 insertions(+), 23 deletions(-)
>>
>> diff --git a/block/bdev.c b/block/bdev.c
>> index fc8d28d77495..6b420cbd4f3d 100644
>> --- a/block/bdev.c
>> +++ b/block/bdev.c
>> @@ -408,10 +408,10 @@ struct block_device *bdev_alloc(struct gendisk *disk, u8 partno)
>>   	bdev->bd_partno = partno;
>>   	bdev->bd_inode = inode;
>>   	bdev->bd_queue = disk->queue;
>> -	if (partno)
>> -		bdev->bd_has_submit_bio = disk->part0->bd_has_submit_bio;
>> +	if (partno && bdev_flagged(disk->part0, BD_FLAG_HAS_SUBMIT_BIO))
>> +		bdev_set_flag(bdev, BD_FLAG_HAS_SUBMIT_BIO);
>>   	else
>> -		bdev->bd_has_submit_bio = false;
>> +		bdev_clear_flag(bdev, BD_FLAG_HAS_SUBMIT_BIO);
>>   	bdev->bd_stats = alloc_percpu(struct disk_stats);
>>   	if (!bdev->bd_stats) {
>>   		iput(inode);
>> @@ -612,7 +612,7 @@ static void bd_end_claim(struct block_device *bdev, void *holder)
>>   		bdev->bd_holder = NULL;
>>   		bdev->bd_holder_ops = NULL;
>>   		mutex_unlock(&bdev->bd_holder_lock);
>> -		if (bdev->bd_write_holder)
>> +		if (bdev_flagged(bdev, BD_FLAG_WRITE_HOLDER))
>>   			unblock = true;
>>   	}
>>   	if (!whole->bd_holders)
>> @@ -625,7 +625,7 @@ static void bd_end_claim(struct block_device *bdev, void *holder)
>>   	 */
>>   	if (unblock) {
>>   		disk_unblock_events(bdev->bd_disk);
>> -		bdev->bd_write_holder = false;
>> +		bdev_clear_flag(bdev, BD_FLAG_WRITE_HOLDER);
>>   	}
>>   }
>>   
>> @@ -878,9 +878,10 @@ struct bdev_handle *bdev_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
>>   		 * writeable reference is too fragile given the way @mode is
>>   		 * used in blkdev_get/put().
>>   		 */
>> -		if ((mode & BLK_OPEN_WRITE) && !bdev->bd_write_holder &&
>> +		if ((mode & BLK_OPEN_WRITE) &&
>> +		    !bdev_flagged(bdev, BD_FLAG_WRITE_HOLDER) &&
>>   		    (disk->event_flags & DISK_EVENT_FLAG_BLOCK_ON_EXCL_WRITE)) {
>> -			bdev->bd_write_holder = true;
>> +			bdev_set_flag(bdev, BD_FLAG_WRITE_HOLDER);
>>   			unblock_events = false;
>>   		}
>>   	}
>> diff --git a/block/blk-core.c b/block/blk-core.c
>> index fdf25b8d6e78..f9f8b12ba626 100644
>> --- a/block/blk-core.c
>> +++ b/block/blk-core.c
>> @@ -482,7 +482,8 @@ __setup("fail_make_request=", setup_fail_make_request);
>>   
>>   bool should_fail_request(struct block_device *part, unsigned int bytes)
>>   {
>> -	return part->bd_make_it_fail && should_fail(&fail_make_request, bytes);
>> +	return bdev_flagged(part, BD_FLAG_MAKE_IT_FAIL) &&
>> +		should_fail(&fail_make_request, bytes);
>>   }
>>   
>>   static int __init fail_make_request_debugfs(void)
>> @@ -595,7 +596,7 @@ static void __submit_bio(struct bio *bio)
>>   	if (unlikely(!blk_crypto_bio_prep(&bio)))
>>   		return;
>>   
>> -	if (!bio->bi_bdev->bd_has_submit_bio) {
>> +	if (!bdev_flagged(bio->bi_bdev, BD_FLAG_HAS_SUBMIT_BIO)) {
>>   		blk_mq_submit_bio(bio);
>>   	} else if (likely(bio_queue_enter(bio) == 0)) {
>>   		struct gendisk *disk = bio->bi_bdev->bd_disk;
>> @@ -703,7 +704,7 @@ void submit_bio_noacct_nocheck(struct bio *bio)
>>   	 */
>>   	if (current->bio_list)
>>   		bio_list_add(&current->bio_list[0], bio);
>> -	else if (!bio->bi_bdev->bd_has_submit_bio)
>> +	else if (!bdev_flagged(bio->bi_bdev, BD_FLAG_HAS_SUBMIT_BIO))
>>   		__submit_bio_noacct_mq(bio);
>>   	else
>>   		__submit_bio_noacct(bio);
>> diff --git a/block/genhd.c b/block/genhd.c
>> index c9d06f72c587..57f96c0c8da0 100644
>> --- a/block/genhd.c
>> +++ b/block/genhd.c
>> @@ -413,7 +413,8 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
>>   	elevator_init_mq(disk->queue);
>>   
>>   	/* Mark bdev as having a submit_bio, if needed */
>> -	disk->part0->bd_has_submit_bio = disk->fops->submit_bio != NULL;
>> +	if (disk->fops->submit_bio)
>> +		bdev_set_flag(disk->part0, BD_FLAG_HAS_SUBMIT_BIO);
>>   
>>   	/*
>>   	 * If the driver provides an explicit major number it also must provide
>> @@ -1062,7 +1063,8 @@ static DEVICE_ATTR(diskseq, 0444, diskseq_show, NULL);
>>   ssize_t part_fail_show(struct device *dev,
>>   		       struct device_attribute *attr, char *buf)
>>   {
>> -	return sprintf(buf, "%d\n", dev_to_bdev(dev)->bd_make_it_fail);
>> +	return sprintf(buf, "%d\n",
>> +		       bdev_flagged(dev_to_bdev(dev), BD_FLAG_MAKE_IT_FAIL));
>>   }
>>   
>>   ssize_t part_fail_store(struct device *dev,
>> @@ -1071,8 +1073,13 @@ ssize_t part_fail_store(struct device *dev,
>>   {
>>   	int i;
>>   
>> -	if (count > 0 && sscanf(buf, "%d", &i) > 0)
>> -		dev_to_bdev(dev)->bd_make_it_fail = i;
>> +	if (count > 0 && sscanf(buf, "%d", &i) > 0) {
>> +		if (!i)
>> +			bdev_clear_flag(dev_to_bdev(dev), BD_FLAG_MAKE_IT_FAIL);
>> +		else
>> +			bdev_set_flag(dev_to_bdev(dev), BD_FLAG_MAKE_IT_FAIL);
>> +
>> +	}
>>   
>>   	return count;
>>   }
>> diff --git a/block/ioctl.c b/block/ioctl.c
>> index 4160f4e6bd5b..a64440f4c96b 100644
>> --- a/block/ioctl.c
>> +++ b/block/ioctl.c
>> @@ -394,7 +394,11 @@ static int blkdev_roset(struct block_device *bdev, unsigned cmd,
>>   		if (ret)
>>   			return ret;
>>   	}
>> -	bdev->bd_read_only = n;
>> +
>> +	if (!n)
>> +		bdev_clear_flag(bdev, BD_FLAG_READ_ONLY);
>> +	else
>> +		bdev_set_flag(bdev, BD_FLAG_READ_ONLY);
>>   	return 0;
>>   }
>>   
>> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
>> index 52e264d5a830..f7a7965eeb25 100644
>> --- a/include/linux/blk_types.h
>> +++ b/include/linux/blk_types.h
>> @@ -37,6 +37,11 @@ struct bio_crypt_ctx;
>>   #define PAGE_SECTORS		(1 << PAGE_SECTORS_SHIFT)
>>   #define SECTOR_MASK		(PAGE_SECTORS - 1)
>>   
>> +#define BD_FLAG_READ_ONLY	0 /* read-only-policy */
>> +#define BD_FLAG_WRITE_HOLDER	1
>> +#define BD_FLAG_HAS_SUBMIT_BIO	2
>> +#define BD_FLAG_MAKE_IT_FAIL	3
>> +
>>   struct block_device {
>>   	sector_t		bd_start_sect;
>>   	sector_t		bd_nr_sectors;
>> @@ -44,10 +49,8 @@ struct block_device {
>>   	struct request_queue *	bd_queue;
>>   	struct disk_stats __percpu *bd_stats;
>>   	unsigned long		bd_stamp;
>> -	bool			bd_read_only;	/* read-only policy */
>> +	unsigned int		bd_flags;
>>   	u8			bd_partno;
>> -	bool			bd_write_holder;
>> -	bool			bd_has_submit_bio;
>>    dev_t                   bd_dev;
>>    atomic_t                bd_openers;
>>    spinlock_t              bd_size_lock; /* for bd_inode->i_size updates */
> 
> As I mentioned, you can convert the above/original 4 fields into single
> 'unsigned int', otherwise one extra 'int' filed is added. Then, 'bd_size_lock'
> is moved to the 2nd cache line, which isn't big deal since the field isn't
> touched in fast path. Anyway, it can be one future cleanup, so:

Thanks for the explanation, if you don't mind, I can change bd_flags to
unsigned short to keep this behaviour in the next version.

Thanks,
Kuai
> 
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> 
> Thanks,
> Ming
> 
> 
> .
> 

