Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50A6F801B2D
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 08:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbjLBHll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 02:41:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjLBHll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 02:41:41 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC476FE;
        Fri,  1 Dec 2023 23:41:46 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.235])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Sj21f4J4Mz4f3kK0;
        Sat,  2 Dec 2023 15:41:42 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
        by mail.maildlp.com (Postfix) with ESMTP id 8DF131A0271;
        Sat,  2 Dec 2023 15:41:43 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP1 (Coremail) with SMTP id cCh0CgDn6hC132plQf0SCg--.48399S3;
        Sat, 02 Dec 2023 15:41:43 +0800 (CST)
Subject: Re: [PATCH v3 2/3] md: don't leave 'MD_RECOVERY_FROZEN' in error path
 of md_set_readonly()
To:     Song Liu <song@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     xni@redhat.com, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20231129043127.2245901-1-yukuai1@huaweicloud.com>
 <20231129043127.2245901-3-yukuai1@huaweicloud.com>
 <CAPhsuW75Qmn1QamykogAnMBDMGwMrfTKh+VeNCtxmjkyszgEag@mail.gmail.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <ad92f9cb-3d66-0ad8-aac3-b753bcadf7df@huaweicloud.com>
Date:   Sat, 2 Dec 2023 15:41:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW75Qmn1QamykogAnMBDMGwMrfTKh+VeNCtxmjkyszgEag@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgDn6hC132plQf0SCg--.48399S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZFWxGF45ZrWrWFWxGrW7urg_yoW5uw1Dp3
        ykJFZ8CrW8JFyfAr47t3WqqFyYvw12qrWqkry3C3WrJFyFyr9xGFyruw1UGrWvya4Iyw4r
        Zw4kGrWxu34xKa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vI
        Y487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
        0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
        0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
        WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_
        Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbU
        UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/12/02 4:53, Song Liu 写道:
> On Tue, Nov 28, 2023 at 8:32 PM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> If md_set_readonly() failed, the array could still be read-write, however
>> 'MD_RECOVERY_FROZEN' could still be set, which leave the array in an
>> abnormal state that sync or recovery can't continue anymore.
>> Hence make sure the flag is cleared after md_set_readonly() returns.
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> Acked-by: Xiao Ni <xni@redhat.com>
> 
> Since we are shipping this via the md-fixes branch, we need a Fixes tag.

Okay, I'll add following fix tag:

Fixes: 88724bfa68be ("md: wait for pending superblock updates before 
switching to read-only")
> 
>> ---
>>   drivers/md/md.c | 24 +++++++++++++-----------
>>   1 file changed, 13 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/md/md.c b/drivers/md/md.c
>> index 5640a948086b..2d8e45a1af23 100644
>> --- a/drivers/md/md.c
>> +++ b/drivers/md/md.c
>> @@ -6355,6 +6355,9 @@ static int md_set_readonly(struct mddev *mddev, struct block_device *bdev)
>>          int err = 0;
>>          int did_freeze = 0;
>>
>> +       if (mddev->external && test_bit(MD_SB_CHANGE_PENDING, &mddev->sb_flags))
>> +               return -EBUSY;
>> +
>>          if (!test_bit(MD_RECOVERY_FROZEN, &mddev->recovery)) {
>>                  did_freeze = 1;
>>                  set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
>> @@ -6369,8 +6372,6 @@ static int md_set_readonly(struct mddev *mddev, struct block_device *bdev)
>>           */
>>          md_wakeup_thread_directly(mddev->sync_thread);
>>
>> -       if (mddev->external && test_bit(MD_SB_CHANGE_PENDING, &mddev->sb_flags))
>> -               return -EBUSY;
>>          mddev_unlock(mddev);
>>          wait_event(resync_wait, !test_bit(MD_RECOVERY_RUNNING,
>>                                            &mddev->recovery));
>> @@ -6383,29 +6384,30 @@ static int md_set_readonly(struct mddev *mddev, struct block_device *bdev)
>>              mddev->sync_thread ||
>>              test_bit(MD_RECOVERY_RUNNING, &mddev->recovery)) {
>>                  pr_warn("md: %s still in use.\n",mdname(mddev));
>> -               if (did_freeze) {
>> -                       clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
>> -                       set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
>> -                       md_wakeup_thread(mddev->thread);
>> -               }
> 
> This change (move did_freeze, etc.) is not explained in the commit log.
> Is it just refactor?

It is refactor, but it is also part of "make sure the flag is cleared
after md_set_readonly() returns", because now that MD_RECOVERY_FROZEN
will be cleared:

if ((mddev->pers && !err) || did_freeze)

Which means,
  - If set readonly succeed, or;
  - if something is wrong and did_freeze is set, exactly what this patch
    tries to do;

Thanks,
Kuai

> 
> Thanks,
> Song
> 
> 
>>                  err = -EBUSY;
>>                  goto out;
>>          }
>> +
>>          if (mddev->pers) {
>>                  __md_stop_writes(mddev);
>>
>> -               err  = -ENXIO;
>> -               if (mddev->ro == MD_RDONLY)
>> +               if (mddev->ro == MD_RDONLY) {
>> +                       err  = -ENXIO;
>>                          goto out;
>> +               }
>> +
>>                  mddev->ro = MD_RDONLY;
>>                  set_disk_ro(mddev->gendisk, 1);
>> +       }
>> +
>> +out:
>> +       if ((mddev->pers && !err) || did_freeze) {
>>                  clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
>>                  set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
>>                  md_wakeup_thread(mddev->thread);
>>                  sysfs_notify_dirent_safe(mddev->sysfs_state);
>> -               err = 0;
>>          }
>> -out:
>> +
>>          mutex_unlock(&mddev->open_mutex);
>>          return err;
>>   }
>> --
>> 2.39.2
>>
> .
> 

