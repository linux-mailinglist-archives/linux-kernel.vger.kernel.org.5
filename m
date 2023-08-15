Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9669577C4DC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 03:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233831AbjHOBFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 21:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233876AbjHOBFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 21:05:01 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F0B10C1;
        Mon, 14 Aug 2023 18:04:59 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RPtN80GBxz4f3pBr;
        Tue, 15 Aug 2023 09:04:56 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgA3x6k2z9pknmDwAg--.14153S3;
        Tue, 15 Aug 2023 09:04:56 +0800 (CST)
Subject: Re: [PATCH -next 01/13] md: remove rdev flag 'RemoveSynchronized'
To:     NeilBrown <neil@brown.name>, Song Liu <song@kernel.org>
Cc:     Yu Kuai <yukuai1@huaweicloud.com>, xni@redhat.com,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230803132426.2688608-1-yukuai1@huaweicloud.com>
 <169204900650.11073.14374074900186832485@noble.neil.brown.name>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <b69baaa5-ca00-fb70-4e65-06ba601d864e@huaweicloud.com>
Date:   Tue, 15 Aug 2023 09:04:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <169204900650.11073.14374074900186832485@noble.neil.brown.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgA3x6k2z9pknmDwAg--.14153S3
X-Coremail-Antispam: 1UD129KBjvJXoW3WF47uFy7Wry5tFyfCr45Wrg_yoW3uw13p3
        yfJFy3CF4UXryUCw4qqw45Ka4Fgw17KrW8Cr9xA34Sv3savryDXry8JFWUur95ZFZ3Xw40
        vF1UGws3CF10vFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
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
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/08/15 5:36, NeilBrown 写道:
> On Mon, 14 Aug 2023, Song Liu wrote:
>> + Neil
>>
>> RemoveSynchronized was added by Neil not too long ago. I wonder whether
>> we still need it in some cases (large raid10 losing a large set of disks).
> 
> We have customers with thousands of members in a raid10.  They do
> sometimes need to remove half of them.  Dropping RemoveSynchronized
> would significantly increase the time it takes to do that.
> 
> Removing an rdev is not often a hot path.  But sometimes it can be.
> 

Thanks for the explanation, and soory that I didn't mention that in this
commit message, the way that rdev is protected through rcu is not safe,
and refer to the implementation of 'q_usage_counter' in block layer, I'm
planing to refactor the way that rdev is protected and rcu is not needed
anymore:

1. refactor mddev_suspend(), and make sure it's called by all the caller
of remove_and_add_spares().
2. factor out a helper md_array_enter() from md_handle_request, this
helper will grab 'active_io' and wait for mddev_suspend() to be done.
3. in the fastpath, before accessing rdev, make sure md_array_enter() is
called.

Thanks,
Kuai

> NeilBrown
> 
> 
>>
>> Thanks,
>> Song
>>
>>
>> On Thu, Aug 3, 2023 at 9:27 PM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>>
>>> From: Yu Kuai <yukuai3@huawei.com>
>>>
>>> When multiple rdevs are removed from array in remove_and_add_spares(),
>>> which is only possible from daemon thread(user can only remove one rdev
>>> through ioctl/sysfs at one time), the flag is used to avoid calling
>>> synchronize_rcu() multiple times for each rdev.
>>>
>>> However, remove rdev from daemon thread really is super cold path, while
>>> removing n rdevs, it doesn't matter sync rcu n times or just one time.
>>> Hence remove this flag and make code simpler.
>>>
>>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>>> ---
>>>   drivers/md/md-multipath.c | 15 +++++++--------
>>>   drivers/md/md.c           | 26 ++------------------------
>>>   drivers/md/md.h           |  5 -----
>>>   drivers/md/raid1.c        | 15 +++++++--------
>>>   drivers/md/raid10.c       | 15 +++++++--------
>>>   drivers/md/raid5.c        | 15 +++++++--------
>>>   6 files changed, 30 insertions(+), 61 deletions(-)
>>>
>>> diff --git a/drivers/md/md-multipath.c b/drivers/md/md-multipath.c
>>> index d22276870283..9e4ddd5240cd 100644
>>> --- a/drivers/md/md-multipath.c
>>> +++ b/drivers/md/md-multipath.c
>>> @@ -258,14 +258,13 @@ static int multipath_remove_disk(struct mddev *mddev, struct md_rdev *rdev)
>>>                          goto abort;
>>>                  }
>>>                  p->rdev = NULL;
>>> -               if (!test_bit(RemoveSynchronized, &rdev->flags)) {
>>> -                       synchronize_rcu();
>>> -                       if (atomic_read(&rdev->nr_pending)) {
>>> -                               /* lost the race, try later */
>>> -                               err = -EBUSY;
>>> -                               p->rdev = rdev;
>>> -                               goto abort;
>>> -                       }
>>> +
>>> +               synchronize_rcu();
>>> +               if (atomic_read(&rdev->nr_pending)) {
>>> +                       /* lost the race, try later */
>>> +                       err = -EBUSY;
>>> +                       p->rdev = rdev;
>>> +                       goto abort;
>>>                  }
>>>                  err = md_integrity_register(mddev);
>>>          }
>>> diff --git a/drivers/md/md.c b/drivers/md/md.c
>>> index a3d98273b295..cd7ac1dee3b8 100644
>>> --- a/drivers/md/md.c
>>> +++ b/drivers/md/md.c
>>> @@ -9155,7 +9155,6 @@ static int remove_and_add_spares(struct mddev *mddev,
>>>          struct md_rdev *rdev;
>>>          int spares = 0;
>>>          int removed = 0;
>>> -       bool remove_some = false;
>>>
>>>          if (this && test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))
>>>                  /* Mustn't remove devices when resync thread is running */
>>> @@ -9165,28 +9164,9 @@ static int remove_and_add_spares(struct mddev *mddev,
>>>                  if ((this == NULL || rdev == this) &&
>>>                      rdev->raid_disk >= 0 &&
>>>                      !test_bit(Blocked, &rdev->flags) &&
>>> -                   test_bit(Faulty, &rdev->flags) &&
>>> +                   !test_bit(In_sync, &rdev->flags) &&
>>> +                   !test_bit(Journal, &rdev->flags) &&
>>>                      atomic_read(&rdev->nr_pending)==0) {
>>> -                       /* Faulty non-Blocked devices with nr_pending == 0
>>> -                        * never get nr_pending incremented,
>>> -                        * never get Faulty cleared, and never get Blocked set.
>>> -                        * So we can synchronize_rcu now rather than once per device
>>> -                        */
>>> -                       remove_some = true;
>>> -                       set_bit(RemoveSynchronized, &rdev->flags);
>>> -               }
>>> -       }
>>> -
>>> -       if (remove_some)
>>> -               synchronize_rcu();
>>> -       rdev_for_each(rdev, mddev) {
>>> -               if ((this == NULL || rdev == this) &&
>>> -                   rdev->raid_disk >= 0 &&
>>> -                   !test_bit(Blocked, &rdev->flags) &&
>>> -                   ((test_bit(RemoveSynchronized, &rdev->flags) ||
>>> -                    (!test_bit(In_sync, &rdev->flags) &&
>>> -                     !test_bit(Journal, &rdev->flags))) &&
>>> -                   atomic_read(&rdev->nr_pending)==0)) {
>>>                          if (mddev->pers->hot_remove_disk(
>>>                                      mddev, rdev) == 0) {
>>>                                  sysfs_unlink_rdev(mddev, rdev);
>>> @@ -9195,8 +9175,6 @@ static int remove_and_add_spares(struct mddev *mddev,
>>>                                  removed++;
>>>                          }
>>>                  }
>>> -               if (remove_some && test_bit(RemoveSynchronized, &rdev->flags))
>>> -                       clear_bit(RemoveSynchronized, &rdev->flags);
>>>          }
>>>
>>>          if (removed && mddev->kobj.sd)
>>> diff --git a/drivers/md/md.h b/drivers/md/md.h
>>> index 8ae957480976..b25b6d061372 100644
>>> --- a/drivers/md/md.h
>>> +++ b/drivers/md/md.h
>>> @@ -189,11 +189,6 @@ enum flag_bits {
>>>                                   * than other devices in the array
>>>                                   */
>>>          ClusterRemove,
>>> -       RemoveSynchronized,     /* synchronize_rcu() was called after
>>> -                                * this device was known to be faulty,
>>> -                                * so it is safe to remove without
>>> -                                * another synchronize_rcu() call.
>>> -                                */
>>>          ExternalBbl,            /* External metadata provides bad
>>>                                   * block management for a disk
>>>                                   */
>>> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
>>> index 23d211969565..acb6d6542619 100644
>>> --- a/drivers/md/raid1.c
>>> +++ b/drivers/md/raid1.c
>>> @@ -1859,15 +1859,14 @@ static int raid1_remove_disk(struct mddev *mddev, struct md_rdev *rdev)
>>>                          goto abort;
>>>                  }
>>>                  p->rdev = NULL;
>>> -               if (!test_bit(RemoveSynchronized, &rdev->flags)) {
>>> -                       synchronize_rcu();
>>> -                       if (atomic_read(&rdev->nr_pending)) {
>>> -                               /* lost the race, try later */
>>> -                               err = -EBUSY;
>>> -                               p->rdev = rdev;
>>> -                               goto abort;
>>> -                       }
>>> +               synchronize_rcu();
>>> +               if (atomic_read(&rdev->nr_pending)) {
>>> +                       /* lost the race, try later */
>>> +                       err = -EBUSY;
>>> +                       p->rdev = rdev;
>>> +                       goto abort;
>>>                  }
>>> +
>>>                  if (conf->mirrors[conf->raid_disks + number].rdev) {
>>>                          /* We just removed a device that is being replaced.
>>>                           * Move down the replacement.  We drain all IO before
>>> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
>>> index 7704a4c7f469..64dd5cb6133e 100644
>>> --- a/drivers/md/raid10.c
>>> +++ b/drivers/md/raid10.c
>>> @@ -2247,15 +2247,14 @@ static int raid10_remove_disk(struct mddev *mddev, struct md_rdev *rdev)
>>>                  goto abort;
>>>          }
>>>          *rdevp = NULL;
>>> -       if (!test_bit(RemoveSynchronized, &rdev->flags)) {
>>> -               synchronize_rcu();
>>> -               if (atomic_read(&rdev->nr_pending)) {
>>> -                       /* lost the race, try later */
>>> -                       err = -EBUSY;
>>> -                       *rdevp = rdev;
>>> -                       goto abort;
>>> -               }
>>> +       synchronize_rcu();
>>> +       if (atomic_read(&rdev->nr_pending)) {
>>> +               /* lost the race, try later */
>>> +               err = -EBUSY;
>>> +               *rdevp = rdev;
>>> +               goto abort;
>>>          }
>>> +
>>>          if (p->replacement) {
>>>                  /* We must have just cleared 'rdev' */
>>>                  p->rdev = p->replacement;
>>> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
>>> index 4cdb35e54251..37d9865b180a 100644
>>> --- a/drivers/md/raid5.c
>>> +++ b/drivers/md/raid5.c
>>> @@ -8267,15 +8267,14 @@ static int raid5_remove_disk(struct mddev *mddev, struct md_rdev *rdev)
>>>                  goto abort;
>>>          }
>>>          *rdevp = NULL;
>>> -       if (!test_bit(RemoveSynchronized, &rdev->flags)) {
>>> -               lockdep_assert_held(&mddev->reconfig_mutex);
>>> -               synchronize_rcu();
>>> -               if (atomic_read(&rdev->nr_pending)) {
>>> -                       /* lost the race, try later */
>>> -                       err = -EBUSY;
>>> -                       rcu_assign_pointer(*rdevp, rdev);
>>> -               }
>>> +       lockdep_assert_held(&mddev->reconfig_mutex);
>>> +       synchronize_rcu();
>>> +       if (atomic_read(&rdev->nr_pending)) {
>>> +               /* lost the race, try later */
>>> +               err = -EBUSY;
>>> +               rcu_assign_pointer(*rdevp, rdev);
>>>          }
>>> +
>>>          if (!err) {
>>>                  err = log_modify(conf, rdev, false);
>>>                  if (err)
>>> --
>>> 2.39.2
>>>
>>
> 
> 
> .
> 

