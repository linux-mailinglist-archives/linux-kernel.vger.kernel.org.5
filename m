Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B81E67F6F39
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 10:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232958AbjKXJND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 04:13:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbjKXJNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 04:13:00 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05EA3D68;
        Fri, 24 Nov 2023 01:13:07 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Sc8Qh0zm3z4f3m6w;
        Fri, 24 Nov 2023 17:13:00 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
        by mail.maildlp.com (Postfix) with ESMTP id 73ABF1A0516;
        Fri, 24 Nov 2023 17:13:04 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP1 (Coremail) with SMTP id cCh0CgA3iA4faWBl+w0vBw--.5572S3;
        Fri, 24 Nov 2023 17:13:04 +0800 (CST)
Subject: Re: [PATCH -next v2 2/6] md: remove flag RemoveSynchronized
To:     Song Liu <song@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20231021102059.3198284-1-yukuai1@huaweicloud.com>
 <20231021102059.3198284-3-yukuai1@huaweicloud.com>
 <CAPhsuW6kZ4voZQPsYQK4O9=5LtFvB8UY_oSWXkOTnek=aJPidw@mail.gmail.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <fb6a482a-a546-3e6b-0a0a-238f81b0bb23@huaweicloud.com>
Date:   Fri, 24 Nov 2023 17:13:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW6kZ4voZQPsYQK4O9=5LtFvB8UY_oSWXkOTnek=aJPidw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgA3iA4faWBl+w0vBw--.5572S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Gw1DJFy8Cr47Xry8GFyrCrg_yoWxJw45p3
        93XFy3Cr4UXr4jkr4DXrWUCFyrXw17KrW8Cr93ua4Svas2vryDW34rJFW5Wr98ZFZ3Za10
        qF1UJwsrGF1xKFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
        IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r4j6FyUMIIF0xvEx4A2jsIE14v26r1j6r4U
        MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUZa9-UUU
        UU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/11/24 16:28, Song Liu 写道:
> On Fri, Oct 20, 2023 at 7:25 PM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> rcu is not used correctly here, because synchronize_rcu() is called
>> before replacing old value, for example:
>>
>> remove_and_add_spares   // other path
>>   synchronize_rcu
>>   // called before replacing old value
>>   set_bit(RemoveSynchronized)
>>                          rcu_read_lock()
>>                          rdev = conf->mirros[].rdev
>>   pers->hot_remove_disk
>>    conf->mirros[].rdev = NULL;
>>    if (!test_bit(RemoveSynchronized))
>>     synchronize_rcu
>>     /*
>>      * won't be called, and won't wait
>>      * for concurrent readers to be done.
>>      */
>>                          // access rdev after remove_and_add_spares()
>>                          rcu_read_unlock()
>>
>> Fortunately, there is a separate rcu protection to prevent such rdev
>> to be freed:
>>
>> md_kick_rdev_from_array         //other path
>>                                  rcu_read_lock()
>>                                  rdev = conf->mirros[].rdev
>> list_del_rcu(&rdev->same_set)
>>
>>                                  rcu_read_unlock()
>>                                  /*
>>                                   * rdev can be removed from conf, but
>>                                   * rdev won't be freed.
>>                                   */
>> synchronize_rcu()
>> free rdev
>>
>> Hence remove this useless flag and prepare to remove rcu protection to
>> access rdev from 'conf'.
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> 
> RemoveSynchronized is not removed from md.h.

Yes, thanks for the notice.

Kuai
> 
> 
>> ---
>>   drivers/md/md-multipath.c |  9 ---------
>>   drivers/md/md.c           | 37 ++++++-------------------------------
>>   drivers/md/raid1.c        |  9 ---------
>>   drivers/md/raid10.c       |  9 ---------
>>   drivers/md/raid5.c        |  9 ---------
>>   5 files changed, 6 insertions(+), 67 deletions(-)
>>
>> diff --git a/drivers/md/md-multipath.c b/drivers/md/md-multipath.c
>> index d22276870283..aa77133f3188 100644
>> --- a/drivers/md/md-multipath.c
>> +++ b/drivers/md/md-multipath.c
>> @@ -258,15 +258,6 @@ static int multipath_remove_disk(struct mddev *mddev, struct md_rdev *rdev)
>>                          goto abort;
>>                  }
>>                  p->rdev = NULL;
>> -               if (!test_bit(RemoveSynchronized, &rdev->flags)) {
>> -                       synchronize_rcu();
>> -                       if (atomic_read(&rdev->nr_pending)) {
>> -                               /* lost the race, try later */
>> -                               err = -EBUSY;
>> -                               p->rdev = rdev;
>> -                               goto abort;
>> -                       }
>> -               }
>>                  err = md_integrity_register(mddev);
>>          }
>>   abort:
>> diff --git a/drivers/md/md.c b/drivers/md/md.c
>> index 09686d8db983..68f3bb6e89cb 100644
>> --- a/drivers/md/md.c
>> +++ b/drivers/md/md.c
>> @@ -9250,44 +9250,19 @@ static int remove_and_add_spares(struct mddev *mddev,
>>          struct md_rdev *rdev;
>>          int spares = 0;
>>          int removed = 0;
>> -       bool remove_some = false;
>>
>>          if (this && test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))
>>                  /* Mustn't remove devices when resync thread is running */
>>                  return 0;
>>
>>          rdev_for_each(rdev, mddev) {
>> -               if ((this == NULL || rdev == this) &&
>> -                   rdev->raid_disk >= 0 &&
>> -                   !test_bit(Blocked, &rdev->flags) &&
>> -                   test_bit(Faulty, &rdev->flags) &&
>> -                   atomic_read(&rdev->nr_pending)==0) {
>> -                       /* Faulty non-Blocked devices with nr_pending == 0
>> -                        * never get nr_pending incremented,
>> -                        * never get Faulty cleared, and never get Blocked set.
>> -                        * So we can synchronize_rcu now rather than once per device
>> -                        */
>> -                       remove_some = true;
>> -                       set_bit(RemoveSynchronized, &rdev->flags);
>> -               }
>> -       }
>> -
>> -       if (remove_some)
>> -               synchronize_rcu();
>> -       rdev_for_each(rdev, mddev) {
>> -               if ((this == NULL || rdev == this) &&
>> -                   (test_bit(RemoveSynchronized, &rdev->flags) ||
>> -                    rdev_removeable(rdev))) {
>> -                       if (mddev->pers->hot_remove_disk(
>> -                                   mddev, rdev) == 0) {
>> -                               sysfs_unlink_rdev(mddev, rdev);
>> -                               rdev->saved_raid_disk = rdev->raid_disk;
>> -                               rdev->raid_disk = -1;
>> -                               removed++;
>> -                       }
>> +               if ((this == NULL || rdev == this) && rdev_removeable(rdev) &&
>> +                   !mddev->pers->hot_remove_disk(mddev, rdev)) {
>> +                       sysfs_unlink_rdev(mddev, rdev);
>> +                       rdev->saved_raid_disk = rdev->raid_disk;
>> +                       rdev->raid_disk = -1;
>> +                       removed++;
>>                  }
>> -               if (remove_some && test_bit(RemoveSynchronized, &rdev->flags))
>> -                       clear_bit(RemoveSynchronized, &rdev->flags);
>>          }
>>
>>          if (removed && mddev->kobj.sd)
>> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
>> index c13088eae401..4348d670439d 100644
>> --- a/drivers/md/raid1.c
>> +++ b/drivers/md/raid1.c
>> @@ -1836,15 +1836,6 @@ static int raid1_remove_disk(struct mddev *mddev, struct md_rdev *rdev)
>>                          goto abort;
>>                  }
>>                  p->rdev = NULL;
>> -               if (!test_bit(RemoveSynchronized, &rdev->flags)) {
>> -                       synchronize_rcu();
>> -                       if (atomic_read(&rdev->nr_pending)) {
>> -                               /* lost the race, try later */
>> -                               err = -EBUSY;
>> -                               p->rdev = rdev;
>> -                               goto abort;
>> -                       }
>> -               }
>>                  if (conf->mirrors[conf->raid_disks + number].rdev) {
>>                          /* We just removed a device that is being replaced.
>>                           * Move down the replacement.  We drain all IO before
>> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
>> index 4b5f34f320c8..33ab00323cae 100644
>> --- a/drivers/md/raid10.c
>> +++ b/drivers/md/raid10.c
>> @@ -2219,15 +2219,6 @@ static int raid10_remove_disk(struct mddev *mddev, struct md_rdev *rdev)
>>                  goto abort;
>>          }
>>          *rdevp = NULL;
>> -       if (!test_bit(RemoveSynchronized, &rdev->flags)) {
>> -               synchronize_rcu();
>> -               if (atomic_read(&rdev->nr_pending)) {
>> -                       /* lost the race, try later */
>> -                       err = -EBUSY;
>> -                       *rdevp = rdev;
>> -                       goto abort;
>> -               }
>> -       }
>>          if (p->replacement) {
>>                  /* We must have just cleared 'rdev' */
>>                  p->rdev = p->replacement;
>> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
>> index 27a4dce51c92..a80be51b4825 100644
>> --- a/drivers/md/raid5.c
>> +++ b/drivers/md/raid5.c
>> @@ -8202,15 +8202,6 @@ static int raid5_remove_disk(struct mddev *mddev, struct md_rdev *rdev)
>>                  goto abort;
>>          }
>>          *rdevp = NULL;
>> -       if (!test_bit(RemoveSynchronized, &rdev->flags)) {
>> -               lockdep_assert_held(&mddev->reconfig_mutex);
>> -               synchronize_rcu();
>> -               if (atomic_read(&rdev->nr_pending)) {
>> -                       /* lost the race, try later */
>> -                       err = -EBUSY;
>> -                       rcu_assign_pointer(*rdevp, rdev);
>> -               }
>> -       }
>>          if (!err) {
>>                  err = log_modify(conf, rdev, false);
>>                  if (err)
>> --
>> 2.39.2
>>
> 
> .
> 

