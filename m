Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0CE77F3DFB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 07:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234752AbjKVGPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 01:15:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234742AbjKVGPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 01:15:46 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE8CED47;
        Tue, 21 Nov 2023 22:15:41 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SZrZs6wVpz4f3lfG;
        Wed, 22 Nov 2023 14:15:33 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
        by mail.maildlp.com (Postfix) with ESMTP id 380AE1A01EA;
        Wed, 22 Nov 2023 14:15:38 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP1 (Coremail) with SMTP id cCh0CgDX2hCInF1lPDVqBg--.43558S3;
        Wed, 22 Nov 2023 14:15:38 +0800 (CST)
Subject: Re: [PATCH v3 2/3] block: introduce new field bd_flags in
 block_device
To:     Ming Lei <ming.lei@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20231122103103.1104589-1-yukuai1@huaweicloud.com>
 <20231122103103.1104589-3-yukuai1@huaweicloud.com> <ZV11zTuF7AX9eIIE@fedora>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <c651426b-86ca-a646-87f7-0ced6cad19fe@huaweicloud.com>
Date:   Wed, 22 Nov 2023 14:15:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <ZV11zTuF7AX9eIIE@fedora>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgDX2hCInF1lPDVqBg--.43558S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Gw43Zw1xGF47WFy3Zr45Awb_yoW3Zw4rpF
        WkJFWYyrWUGr1fWa1Iqa13JFnagw40yr18C3y3C34jyrZ0yrn7WF1kJr1j9a929rW8CFWx
        ZF1DuFW3Cryjka7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
        IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_
        Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbU
        UUUUU==
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

ÔÚ 2023/11/22 11:30, Ming Lei Ð´µÀ:
> On Wed, Nov 22, 2023 at 06:31:02PM +0800, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> There are multiple switches in struct block_device, use separate bool
>> fields for them is not gracefully. Add a new field bd_flags and replace
>> swithes to a bit, there are no functional changes, and prepare to add
>> a new switch in the next patch. In order to keep bd_flags in the first
>> cacheline and prevent layout to be affected, define it as u16.
>>
>> Also add new helpers to set/clear/test each bit like 'bio->bi_flags'.
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
>> index e4cfb7adb645..10f524a7416c 100644
>> --- a/block/bdev.c
>> +++ b/block/bdev.c
>> @@ -402,10 +402,10 @@ struct block_device *bdev_alloc(struct gendisk *disk, u8 partno)
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
>> @@ -606,7 +606,7 @@ static void bd_end_claim(struct block_device *bdev, void *holder)
>>   		bdev->bd_holder = NULL;
>>   		bdev->bd_holder_ops = NULL;
>>   		mutex_unlock(&bdev->bd_holder_lock);
>> -		if (bdev->bd_write_holder)
>> +		if (bdev_flagged(bdev, BD_FLAG_WRITE_HOLDER))
>>   			unblock = true;
>>   	}
>>   	if (!whole->bd_holders)
>> @@ -619,7 +619,7 @@ static void bd_end_claim(struct block_device *bdev, void *holder)
>>   	 */
>>   	if (unblock) {
>>   		disk_unblock_events(bdev->bd_disk);
>> -		bdev->bd_write_holder = false;
>> +		bdev_clear_flag(bdev, BD_FLAG_WRITE_HOLDER);
>>   	}
>>   }
>>   
>> @@ -805,9 +805,10 @@ struct block_device *blkdev_get_by_dev(dev_t dev, blk_mode_t mode, void *holder,
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
>> index f7d40692dd94..de652045111b 100644
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
>> +	unsigned short		bd_flags;
>>   	u8			bd_partno;
>> -	bool			bd_write_holder;
>> -	bool			bd_has_submit_bio;
>>   	dev_t			bd_dev;
>>   	struct inode		*bd_inode;	/* will die */
>>   
>> @@ -67,9 +70,6 @@ struct block_device {
>>   	struct super_block	*bd_fsfreeze_sb;
>>   
>>   	struct partition_meta_info *bd_meta_info;
>> -#ifdef CONFIG_FAIL_MAKE_REQUEST
>> -	bool			bd_make_it_fail;
>> -#endif
>>   	/*
>>   	 * keep this out-of-line as it's both big and not needed in the fast
>>   	 * path
>> @@ -86,6 +86,21 @@ struct block_device {
>>   #define bdev_kobj(_bdev) \
>>   	(&((_bdev)->bd_device.kobj))
>>   
>> +static inline bool bdev_flagged(struct block_device *bdev, unsigned int bit)
>> +{
>> +	return bdev->bd_flags & (1U << bit);
>> +}
>> +
>> +static inline void bdev_set_flag(struct block_device *bdev, unsigned int bit)
>> +{
>> +	bdev->bd_flags |= (1U << bit);
>> +}
>> +
>> +static inline void bdev_clear_flag(struct block_device *bdev, unsigned int bit)
>> +{
>> +	bdev->bd_flags &= ~(1U << bit);
>> +}
> 
> 'U' becomes incorrect after .bd_flags is changed to 'unsigned short'.

Currently, bi_flags is unsigned short, and this is the same as
bio_set/clear_flag(), will this behaviour cause any problems?

Thanks,
Kuai

> 
> 
> Thanks,
> Ming
> 
> .
> 

