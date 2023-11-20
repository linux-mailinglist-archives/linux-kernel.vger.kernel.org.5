Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 891147F0D19
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 09:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbjKTIBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 03:01:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjKTIBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 03:01:14 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D245EB4;
        Mon, 20 Nov 2023 00:01:08 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SYg1V6YqSz4f3kpL;
        Mon, 20 Nov 2023 16:01:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
        by mail.maildlp.com (Postfix) with ESMTP id 8CC4F1A01A1;
        Mon, 20 Nov 2023 16:01:05 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP1 (Coremail) with SMTP id cCh0CgDX2xE_EltlRKK0BQ--.24819S3;
        Mon, 20 Nov 2023 16:01:05 +0800 (CST)
Subject: Re: [PATCH 1/2] block: introduce new field flags in block_device
To:     Ming Lei <ming.lei@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20231120093847.2228127-1-yukuai1@huaweicloud.com>
 <20231120093847.2228127-2-yukuai1@huaweicloud.com> <ZVrLvcIhlnQl7xAb@fedora>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <c34b325e-d45b-c0e5-f495-7429e24a9d6b@huaweicloud.com>
Date:   Mon, 20 Nov 2023 16:01:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <ZVrLvcIhlnQl7xAb@fedora>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgDX2xE_EltlRKK0BQ--.24819S3
X-Coremail-Antispam: 1UD129KBjvJXoW3GFyUWF4fXw4UGw17ZF15CFg_yoW3ZFWUpF
        WkKa4YkayUWr4xWan7K3W3XF40qw40kr1xG3y3C34IyFZ8trn3WF1kGryYya97ArW8CFW7
        XF1DuFZ8Ary2ga7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
        IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j
        6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHU
        DUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

ÔÚ 2023/11/20 11:00, Ming Lei Ð´µÀ:
> On Mon, Nov 20, 2023 at 05:38:46PM +0800, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> There are multiple switches in struct block_device, use seperate bool
>> fields for them is not gracefully. Add a new field flags and replace
>> swithes to a bit, there are no functional changes, and preapre to add
>> a new switch in the next patch.
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   block/bdev.c              | 15 ++++++++-------
>>   block/blk-core.c          |  7 ++++---
>>   block/genhd.c             |  8 +++++---
>>   block/ioctl.c             |  2 +-
>>   include/linux/blk_types.h | 12 ++++++------
>>   include/linux/blkdev.h    |  5 +++--
>>   6 files changed, 27 insertions(+), 22 deletions(-)
>>
>> diff --git a/block/bdev.c b/block/bdev.c
>> index fc8d28d77495..cb849bcf61ae 100644
>> --- a/block/bdev.c
>> +++ b/block/bdev.c
>> @@ -408,10 +408,10 @@ struct block_device *bdev_alloc(struct gendisk *disk, u8 partno)
>>   	bdev->bd_partno = partno;
>>   	bdev->bd_inode = inode;
>>   	bdev->bd_queue = disk->queue;
>> -	if (partno)
>> -		bdev->bd_has_submit_bio = disk->part0->bd_has_submit_bio;
>> +	if (partno && test_bit(BD_FLAG_HAS_SUBMIT_BIO, &disk->part0->flags))
>> +		set_bit(BD_FLAG_HAS_SUBMIT_BIO, &bdev->flags);
>>   	else
>> -		bdev->bd_has_submit_bio = false;
>> +		clear_bit(BD_FLAG_HAS_SUBMIT_BIO, &bdev->flags);
>>   	bdev->bd_stats = alloc_percpu(struct disk_stats);
>>   	if (!bdev->bd_stats) {
>>   		iput(inode);
>> @@ -612,7 +612,7 @@ static void bd_end_claim(struct block_device *bdev, void *holder)
>>   		bdev->bd_holder = NULL;
>>   		bdev->bd_holder_ops = NULL;
>>   		mutex_unlock(&bdev->bd_holder_lock);
>> -		if (bdev->bd_write_holder)
>> +		if (test_bit(BD_FLAG_WRITE_HOLDER, &bdev->flags))
>>   			unblock = true;
>>   	}
>>   	if (!whole->bd_holders)
>> @@ -625,7 +625,7 @@ static void bd_end_claim(struct block_device *bdev, void *holder)
>>   	 */
>>   	if (unblock) {
>>   		disk_unblock_events(bdev->bd_disk);
>> -		bdev->bd_write_holder = false;
>> +		clear_bit(BD_FLAG_WRITE_HOLDER, &bdev->flags);
>>   	}
>>   }
>>   
>> @@ -878,9 +878,10 @@ struct bdev_handle *bdev_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
>>   		 * writeable reference is too fragile given the way @mode is
>>   		 * used in blkdev_get/put().
>>   		 */
>> -		if ((mode & BLK_OPEN_WRITE) && !bdev->bd_write_holder &&
>> +		if ((mode & BLK_OPEN_WRITE) &&
>> +		    !test_bit(BD_FLAG_WRITE_HOLDER, &bdev->flags) &&
>>   		    (disk->event_flags & DISK_EVENT_FLAG_BLOCK_ON_EXCL_WRITE)) {
>> -			bdev->bd_write_holder = true;
>> +			set_bit(BD_FLAG_WRITE_HOLDER, &bdev->flags);
>>   			unblock_events = false;
>>   		}
>>   	}
>> diff --git a/block/blk-core.c b/block/blk-core.c
>> index fdf25b8d6e78..577a693165d8 100644
>> --- a/block/blk-core.c
>> +++ b/block/blk-core.c
>> @@ -482,7 +482,8 @@ __setup("fail_make_request=", setup_fail_make_request);
>>   
>>   bool should_fail_request(struct block_device *part, unsigned int bytes)
>>   {
>> -	return part->bd_make_it_fail && should_fail(&fail_make_request, bytes);
>> +	return test_bit(BD_FLAG_MAKE_IT_FAIL, &part->flags) &&
>> +		should_fail(&fail_make_request, bytes);
>>   }
>>   
>>   static int __init fail_make_request_debugfs(void)
>> @@ -595,7 +596,7 @@ static void __submit_bio(struct bio *bio)
>>   	if (unlikely(!blk_crypto_bio_prep(&bio)))
>>   		return;
>>   
>> -	if (!bio->bi_bdev->bd_has_submit_bio) {
>> +	if (!test_bit(BD_FLAG_HAS_SUBMIT_BIO, &bio->bi_bdev->flags)) {
>>   		blk_mq_submit_bio(bio);
>>   	} else if (likely(bio_queue_enter(bio) == 0)) {
>>   		struct gendisk *disk = bio->bi_bdev->bd_disk;
>> @@ -703,7 +704,7 @@ void submit_bio_noacct_nocheck(struct bio *bio)
>>   	 */
>>   	if (current->bio_list)
>>   		bio_list_add(&current->bio_list[0], bio);
>> -	else if (!bio->bi_bdev->bd_has_submit_bio)
>> +	else if (!test_bit(BD_FLAG_HAS_SUBMIT_BIO, &bio->bi_bdev->flags))
>>   		__submit_bio_noacct_mq(bio);
>>   	else
>>   		__submit_bio_noacct(bio);
>> diff --git a/block/genhd.c b/block/genhd.c
>> index c9d06f72c587..026f4c6d5b7e 100644
>> --- a/block/genhd.c
>> +++ b/block/genhd.c
>> @@ -413,7 +413,8 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
>>   	elevator_init_mq(disk->queue);
>>   
>>   	/* Mark bdev as having a submit_bio, if needed */
>> -	disk->part0->bd_has_submit_bio = disk->fops->submit_bio != NULL;
>> +	if (disk->fops->submit_bio)
>> +		set_bit(BD_FLAG_HAS_SUBMIT_BIO, &disk->part0->flags);
>>   
>>   	/*
>>   	 * If the driver provides an explicit major number it also must provide
>> @@ -1062,7 +1063,8 @@ static DEVICE_ATTR(diskseq, 0444, diskseq_show, NULL);
>>   ssize_t part_fail_show(struct device *dev,
>>   		       struct device_attribute *attr, char *buf)
>>   {
>> -	return sprintf(buf, "%d\n", dev_to_bdev(dev)->bd_make_it_fail);
>> +	return sprintf(buf, "%d\n",
>> +		       test_bit(BD_FLAG_MAKE_IT_FAIL, &dev_to_bdev(dev)->flags));
>>   }
>>   
>>   ssize_t part_fail_store(struct device *dev,
>> @@ -1072,7 +1074,7 @@ ssize_t part_fail_store(struct device *dev,
>>   	int i;
>>   
>>   	if (count > 0 && sscanf(buf, "%d", &i) > 0)
>> -		dev_to_bdev(dev)->bd_make_it_fail = i;
>> +		set_bit(BD_FLAG_MAKE_IT_FAIL, &dev_to_bdev(dev)->flags);
>>   
>>   	return count;
>>   }
>> diff --git a/block/ioctl.c b/block/ioctl.c
>> index 4160f4e6bd5b..a548c718a5fb 100644
>> --- a/block/ioctl.c
>> +++ b/block/ioctl.c
>> @@ -394,7 +394,7 @@ static int blkdev_roset(struct block_device *bdev, unsigned cmd,
>>   		if (ret)
>>   			return ret;
>>   	}
>> -	bdev->bd_read_only = n;
>> +	set_bit(BD_FLAG_READ_ONLY, &bdev->flags);
>>   	return 0;
>>   }
>>   
>> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
>> index 52e264d5a830..95bd26c62655 100644
>> --- a/include/linux/blk_types.h
>> +++ b/include/linux/blk_types.h
>> @@ -37,17 +37,20 @@ struct bio_crypt_ctx;
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
>>   	struct gendisk *	bd_disk;
>>   	struct request_queue *	bd_queue;
>>   	struct disk_stats __percpu *bd_stats;
>> +	unsigned long		flags;
>>   	unsigned long		bd_stamp;
>> -	bool			bd_read_only;	/* read-only policy */
>>   	u8			bd_partno;
>> -	bool			bd_write_holder;
>> -	bool			bd_has_submit_bio;
> 
> The idea looks good, but not necessary to add new 8 bytes, and you may
> put all these flags and `bd_partno` into single 'unsigned long', and add
> helpers to retrieve part no, since there are not many ->bd_partno
> references.

Hi, I'm not quite sure which is the best way to implement this, anyway,
I come up with following implementation, can you please take a look
before I send a new version?

diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 52e264d5a830..4e29774b14fd 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -37,6 +37,12 @@ struct bio_crypt_ctx;
  #define PAGE_SECTORS           (1 << PAGE_SECTORS_SHIFT)
  #define SECTOR_MASK            (PAGE_SECTORS - 1)

+#define BD_FLAG_READ_ONLY      0 /* read-only-policy */
+#define BD_FLAG_WRITE_HOLDER   1
+#define BD_FLAG_HAS_SUBMIT_BIO 2
+#define BD_FLAG_MAKE_IT_FAIL   3
+#define BD_FLAGS_MAX           16
+
  struct block_device {
         sector_t                bd_start_sect;
         sector_t                bd_nr_sectors;
@@ -44,10 +50,20 @@ struct block_device {
         struct request_queue *  bd_queue;
         struct disk_stats __percpu *bd_stats;
         unsigned long           bd_stamp;
-       bool                    bd_read_only;   /* read-only policy */
-       u8                      bd_partno;
-       bool                    bd_write_holder;
-       bool                    bd_has_submit_bio;
+
+       /*
+        * In order to keep both flags and bd_partno in the first cacheline,
+        * first 16 bits are used for flags.
+        */
+       union {
+               unsigned long   flags;
+               struct {
+#ifdef __LITTLE_ENDIAN
+                       u16     __flags;
+#endif
+                       u8      bd_partno;
+               };
+       };

Thanks,
Kuai

> 
> Thanks,
> Ming
> 
> 
> .
> 

