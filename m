Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB2578E4BD
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 04:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245404AbjHaC3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 22:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244653AbjHaC27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 22:28:59 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225EB1BF;
        Wed, 30 Aug 2023 19:28:54 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RblTY4DX8z4f3pHV;
        Thu, 31 Aug 2023 10:28:49 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgAXp6nd+u9k19T3Bw--.8997S3;
        Thu, 31 Aug 2023 10:28:46 +0800 (CST)
Subject: Re: Infiniate systemd loop when power off the machine with multiple
 MD RAIDs
To:     Yu Kuai <yukuai1@huaweicloud.com>, Song Liu <song@kernel.org>,
        AceLan Kao <acelan@gmail.com>
Cc:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux RAID <linux-raid@vger.kernel.org>,
        "yukuai (C)" <yukuai3@huawei.com>
References: <028a21df-4397-80aa-c2a5-7c754560f595@gmail.com>
 <20230818101630.000027f4@linux.intel.com>
 <b0488ff7-10c8-4b4e-28b8-01809133c297@linux.dev>
 <CAPhsuW6cSLqwRVO_EpFyimvc7hgi1rb3T8-NA+stHdwrqrScBA@mail.gmail.com>
 <20230822083923.00007fb6@linux.intel.com>
 <CAMz9Wg8KE1rDkSaQnUTJ5ikzH7YGGYbkLM3AcrVue3=JgK+14w@mail.gmail.com>
 <35130b3f-c0fd-e2d6-e849-a5ceb6a2895f@linux.dev>
 <CAMz9Wg_zKSJ2vL=r2zAtLBOv4GSMT63+ZQGXfYTjVJsE+DLQGA@mail.gmail.com>
 <CAPhsuW6W0XgFjH1zNC+EFYjujd4smEiWs+-nYCWQ+KaFmbuvkg@mail.gmail.com>
 <CAMz9Wg9y52iuxJRSQFC2N5Katt72v-o=JvEjegJt-MwORmw9tQ@mail.gmail.com>
 <CAPhsuW7XEy4q3XR389F7CUvXvJ=0JR0QkMOr4LU03avT0erAfg@mail.gmail.com>
 <354004ce-ad4e-5ad5-8fe6-303216647e0c@huaweicloud.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <03b79ab0-0bb0-ac29-4a70-37d902f9a05b@huaweicloud.com>
Date:   Thu, 31 Aug 2023 10:28:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <354004ce-ad4e-5ad5-8fe6-303216647e0c@huaweicloud.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAXp6nd+u9k19T3Bw--.8997S3
X-Coremail-Antispam: 1UD129KBjvJXoWxtryDZr4kGFyrXFWfXFWDurg_yoWDJF4kpr
        WkJFyUGryUJr18Jr1Utr1UXFyUtr1UJw1UJr1UJFyUJr17Jr1jqr1UXr1jgr1UJr48Jr1U
        tr1UJr17Zr1UJr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
        0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
        kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
        67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
        CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E
        3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
        sGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Acelan,

在 2023/08/28 21:50, Yu Kuai 写道:
> Hi,
> 
> 在 2023/08/28 13:20, Song Liu 写道:
>> Hi AceLan,
>>
>> Thanks for running the experiments.
>>
>> On Fri, Aug 25, 2023 at 9:32 PM AceLan Kao <acelan@gmail.com> wrote:
>> [...]
>>>>
>>>> Could you please run the follow two experiments?
>>>>
>>>> 1. Confirm 12a6caf273240a triggers this. Specifically:
>>>>     git checkout 12a6caf273240a => repros
>>>>     git checkout 12a6caf273240a~1 => cannot repro
>>> Yes, I'm pretty sure about this, that's my bisect result and I just
>>> confirmed it again.
>>> I also tried reverting 12a6caf273240a and the issue is gone.
>>
>> The log doesn't match my guess. Specifically:
>>
>> [  420.068142] systemd-shutdown[1]: Stopping MD /dev/md123 (9:123).
>> [  420.074718] md_open:md123 openers++ = 1 by systemd-shutdow
>> [  420.080787] systemd-shutdown[1]: Failed to sync MD block device
>> /dev/md123, ignoring: Input/output error
>> [  420.090831] md: md123 stopped.
>> [  420.094465] systemd-shutdown[1]: Stopping MD /dev/md122 (9:122).
>> [  420.101045] systemd-shutdown[1]: Could not stop MD /dev/md122:
>> Device or resource busy
> 
> I see that:
> 
> systemd-shutdown[1]: Couldn't finalize remaining  MD devices, trying again.
> 
> Can we make sure is this why power off hang?
> 
> Because in my VM, power off is not hang and I got:
> 
> systemd-shutdown[1]: Could not stop MD /dev/md1: Device or resource busy
> systemd-shutdown[1]: Failed to finalize MD devices, ignoring.
>>
>> For a successful stop on md123, we reach the pr_info() in md_open().
>> For a failed stop on md122, the kernel returns -EBUSY before that
>> pr_info() in md_open(). There are some changes in md_open() in
>> the past few release, so I am not quite sure we are looking at the
>> same code.
> 
> By the way, based on code review, looks like md_open never return
> -EBUSY, and I think following is the only place can return -EBUSY before
> md_open() is called:
> 
> blkdev_open
>   blkdev_get_by_dev
>    bd_prepare_to_claim
>     bd_may_claim     -> -EBUSY
> 
> Acelan, can you add following debug patch on the top of Song's patch
> and reporduce it again? Hope it'll confirm why stop array failed with
> -EBUSY.
> 

I saw your reply:

https://lore.kernel.org/all/CAMz9Wg9VXJzZkKWCosm0_=Rz6gG9r3pCMrhvBZQVCQb8i0kd-w@mail.gmail.com/

But I didn't recieve you emails, please reply to me through this email
address: yukuai3@huawei.com. yukuai1@huaweicloud.com is just used for
sending, and I always missing emails from huaweicloud.com, my apologize
for this inconvenience, I have to do it this way due to my company
policy.

There is something interesting on test result:

At first, md122 is the root device, I guess this is why I can't repoduce
this problem in my local VM.
[   14.478619] systemd-gpt-auto-generator[585]: md122p3: Root device 
/dev/md122.
[   14.481823] block md122: the capability attribute has been deprecated.

Then, before trying to stop md122, following log shows that md122 is
still mounted:
[ 1368.369926] [3462]: Remounting '/' read-only with options 
'errors=remount-ro,stripe=128'.
[ 1368.396287] EXT4-fs (md122p3): re-mounted 
6d53dc8e-3f45-4efa-bc0e-4af477fac217 ro. Quota mode: none.

And since then, there is no log aboug md_open(), which means no one
ever open md122 since this remount.

At last, there are lots of log shows that md122 can't be opened
exclusively:
[ 1368.812952] md122:systemd-shutdow bd_prepare_to_claim return -16
[ 1368.819189] md122:systemd-shutdow blkdev_get_by_dev return -16

Which indicate that md122 is still mounted, and systemd-shutdow can't
stop this array. This behaviour looks correct to me, because rootfs
can't be umounted while systemd-shutdown is still running.

However, there are some questions I don't have answers for now, I'm not
familiar with how systemd works:

1) In the normal case that raid is root device, how can systemd-shutdown
make progress and how is rootfs unmounted?
2) How does this scenario related to commit 12a6caf273240a.

I must read systemd source code to get answers, and it'll be appreciated
if someone has answers.

Thanks,
Kuai

> diff --git a/block/bdev.c b/block/bdev.c
> index 979e28a46b98..699739223dcb 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -789,8 +789,11 @@ struct block_device *blkdev_get_by_dev(dev_t dev, 
> blk_mode_t mode, void *holder,
>          if (holder) {
>                  mode |= BLK_OPEN_EXCL;
>                  ret = bd_prepare_to_claim(bdev, holder, hops);
> -               if (ret)
> +               if (ret) {
> +                       pr_warn("%s:%s bd_prepare_to_claim return %d\n",
> +                               disk->disk_name, current->comm, ret);
>                          goto put_blkdev;
> +               }
>          } else {
>                  if (WARN_ON_ONCE(mode & BLK_OPEN_EXCL)) {
>                          ret = -EIO;
> diff --git a/block/fops.c b/block/fops.c
> index eaa98a987213..2d69119c71f6 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -587,8 +587,11 @@ static int blkdev_open(struct inode *inode, struct 
> file *filp)
> 
>          bdev = blkdev_get_by_dev(inode->i_rdev, file_to_blk_mode(filp),
>                                   filp->private_data, NULL);
> -       if (IS_ERR(bdev))
> +       if (IS_ERR(bdev)) {
> +               pr_warn("%pD:%s blkdev_get_by_dev return %ld\n",
> +                       filp, current->comm, PTR_ERR(bdev));
>                  return PTR_ERR(bdev);
> +       }
> 
>          if (bdev_nowait(bdev))
>                  filp->f_mode |= FMODE_NOWAIT;
> 
> Thanks,
> Kuai
> 
>>
>> Therefore, could you please help clarify:
>>
>> 1. Which base kernel are you using?
>>
>>> From the log, you are using 6.5-rc7-706a74159504. However,
>> I think we cannot cleanly revert 12a6caf273240a on top of
>> 6.5-rc7-706a74159504. Did you manually fix some issue in the
>> revert? If so, could you please share the revert commit?
>>
>> 2. If you are not using 6.5-rc7-706a74159504 as base kernel, which
>> one are you using?
>>
>> Thanks,
>> Song
>>
>>>
>>>>
>>>> 2. Try with the following change (add debug messages), which hopefully
>>>>     shows which command is holding a reference on mddev->openers.
>>>>
>>>> Thanks,
>>>> Song
>>>>
>>>> diff --git i/drivers/md/md.c w/drivers/md/md.c
>>>> index 78be7811a89f..3e9b718b32c1 100644
>>>> --- i/drivers/md/md.c
>>>> +++ w/drivers/md/md.c
>>>> @@ -7574,11 +7574,15 @@ static int md_ioctl(struct block_device *bdev,
>>>> blk_mode_t mode,
>>>>                  if (mddev->pers && atomic_read(&mddev->openers) > 1) {
>>>>                          mutex_unlock(&mddev->open_mutex);
>>>>                          err = -EBUSY;
>>>> +                       pr_warn("%s return -EBUSY for %s with
>>>> mddev->openers = %d\n",
>>>> +                               __func__, mdname(mddev),
>>>> atomic_read(&mddev->openers));
>>>>                          goto out;
>>>>                  }
>>>>                  if (test_and_set_bit(MD_CLOSING, &mddev->flags)) {
>>>>                          mutex_unlock(&mddev->open_mutex);
>>>>                          err = -EBUSY;
>>>> +                       pr_warn("%s return -EBUSY for %s with
>>>> MD_CLOSING bit set\n",
>>>> +                               __func__, mdname(mddev));
>>>>                          goto out;
>>>>                  }
>>>>                  did_set_md_closing = true;
>>>> @@ -7789,6 +7793,8 @@ static int md_open(struct gendisk *disk, 
>>>> blk_mode_t mode)
>>>>                  goto out_unlock;
>>>>
>>>>          atomic_inc(&mddev->openers);
>>>> +       pr_info("%s:%s openers++ = %d by %s\n", __func__, 
>>>> mdname(mddev),
>>>> +               atomic_read(&mddev->openers), current->comm);
>>>>          mutex_unlock(&mddev->open_mutex);
>>>>
>>>>          disk_check_media_change(disk);
>>>> @@ -7807,6 +7813,8 @@ static void md_release(struct gendisk *disk)
>>>>
>>>>          BUG_ON(!mddev);
>>>>          atomic_dec(&mddev->openers);
>>>> +       pr_info("%s:%s openers-- = %d by %s\n", __func__, 
>>>> mdname(mddev),
>>>> +               atomic_read(&mddev->openers), current->comm);
>>>>          mddev_put(mddev);
>>>>   }
>>> It's pretty strange that I can't reproduce the issue after applied 
>>> the patch.
>>>
>>> I tried to figure out which part affect the issue and found when I
>>> comment out the pr_info() In md_release(), the issue could be
>>> reproduced.
>>>
>>> -- 
>>> Chia-Lin Kao(AceLan)
>>> http://blog.acelan.idv.tw/
>>> E-Mail: acelan.kaoATcanonical.com (s/AT/@/)
>> .
>>
> 
> .
> 

