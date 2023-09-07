Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21967796EC8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 04:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243060AbjIGCEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 22:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbjIGCEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 22:04:43 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4AA719A0;
        Wed,  6 Sep 2023 19:04:16 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Rh2bw1n4Lz4f3pFc;
        Thu,  7 Sep 2023 10:04:12 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgAXp6mbL_lkF5I2Cg--.12332S3;
        Thu, 07 Sep 2023 10:04:13 +0800 (CST)
Subject: Re: Infiniate systemd loop when power off the machine with multiple
 MD RAIDs
To:     Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>,
        AceLan Kao <acelan@gmail.com>
Cc:     Yu Kuai <yukuai1@huaweicloud.com>, Song Liu <song@kernel.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux RAID <linux-raid@vger.kernel.org>,
        "yukuai (C)" <yukuai3@huawei.com>,
        "yangerkun@huawei.com" <yangerkun@huawei.com>
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
 <03b79ab0-0bb0-ac29-4a70-37d902f9a05b@huaweicloud.com>
 <20230831085057.00001795@linux.intel.com>
 <CAMz9Wg8bhCG=qSLia943dwr=LV7Kum=bZPq2s_2coV6a_bmDeA@mail.gmail.com>
 <20230906122751.00001e5b@linux.intel.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <43b0b2f4-17c0-61d2-9c41-0595fb6f2efc@huaweicloud.com>
Date:   Thu, 7 Sep 2023 10:04:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20230906122751.00001e5b@linux.intel.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAXp6mbL_lkF5I2Cg--.12332S3
X-Coremail-Antispam: 1UD129KBjvJXoWxGF45Gw18XFy7ZrWruFWkXrb_yoW5tr4xpF
        Z5XF1YkrnrWw17AayUXry8X3Z3Kasaya98Kry3K39Iy34fJryxGw13Wr45WFZxWF4Skr42
        vw1DtF4jvwnYga7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
        c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
        AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
        17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
        IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3
        Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
        sGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

ÔÚ 2023/09/06 18:27, Mariusz Tkaczyk Ð´µÀ:
> On Wed, 6 Sep 2023 14:26:30 +0800
> AceLan Kao <acelan@gmail.com> wrote:
> 
>>  From previous testing, I don't think it's an issue in systemd, so I
>> did a simple test and found the issue is gone.
>> You only need to add a small delay in md_release(), then the issue
>> can't be reproduced.
>>
>> diff --git a/drivers/md/md.c b/drivers/md/md.c
>> index 78be7811a89f..ef47e34c1af5 100644
>> --- a/drivers/md/md.c
>> +++ b/drivers/md/md.c
>> @@ -7805,6 +7805,7 @@ static void md_release(struct gendisk *disk)
>> {
>>         struct mddev *mddev = disk->private_data;
>>
>> +       msleep(10);
>>         BUG_ON(!mddev);
>>         atomic_dec(&mddev->openers);
>>         mddev_put(mddev);
> 
> I have repro and I tested it on my setup. It is not working for me.
> My setup could be more "advanced" to maximalize chance of reproduction:
> 
> # cat /proc/mdstat
> Personalities : [raid1] [raid6] [raid5] [raid4] [raid10] [raid0]
> md121 : active raid0 nvme2n1[1] nvme5n1[0]
>        7126394880 blocks super external:/md127/0 128k chunks
> 
> md122 : active raid10 nvme6n1[3] nvme4n1[2] nvme1n1[1] nvme7n1[0]
>        104857600 blocks super external:/md126/0 64K chunks 2 near-copies [4/4]
> [UUUU]
> 
> md123 : active raid5 nvme6n1[3] nvme4n1[2] nvme1n1[1] nvme7n1[0]
>        2655765504 blocks super external:/md126/1 level 5, 32k chunk, algorithm 0
> [4/4] [UUUU]
> 
> md124 : active raid1 nvme0n1[1] nvme3n1[0]
>        99614720 blocks super external:/md125/0 [2/2] [UU]
> 
> md125 : inactive nvme3n1[1](S) nvme0n1[0](S)
>        10402 blocks super external:imsm
> 
> md126 : inactive nvme7n1[3](S) nvme1n1[2](S) nvme6n1[1](S) nvme4n1[0](S)
>        20043 blocks super external:imsm
> 
> md127 : inactive nvme2n1[1](S) nvme5n1[0](S)
>        10402 blocks super external:imsm
> 
> I have almost 99% repro ratio, slowly moving forward..
> 
> It is endless loop because systemd-shutdown sends ioctl "stop_array" which is
> successful but array is not stopped. For that reason it sets "changed = true".

How does systemd-shutdown judge if array is stopped? cat /proc/mdstat or
ls /dev/md* or other way?
> 
> Systemd-shutdown see the change and retries to check if there is something else
> which can be stopped now, and again, again...
> 
> I will check what is returned first, it could be 0 or it could be positive
> errno (nit?) because systemd cares "if(r < 0)".

I do noticed that there are lots of log about md123 stopped:

[ 1371.834034] md122:systemd-shutdow bd_prepare_to_claim return -16
[ 1371.840294] md122:systemd-shutdow blkdev_get_by_dev return -16
[ 1371.846845] md: md123 stopped.
[ 1371.850155] md122:systemd-shutdow bd_prepare_to_claim return -16
[ 1371.856411] md122:systemd-shutdow blkdev_get_by_dev return -16
[ 1371.862941] md: md123 stopped.

And md_ioctl->do_md_stop doesn't have error path after printing this
log, hence 0 will be returned to user.

The normal case is that:

open md123
ioctl STOP_ARRAY -> all rdev should be removed from array
close md123 -> mddev will finally be freed by:
	md_release
	 mddev_put
	  set_bit(MD_DELETED, &mddev->flags) -> user shound not see this mddev
	  queue_work(md_misc_wq, &mddev->del_work)

	mddev_delayed_delete
	 kobject_put(&mddev->kobj)

	md_kobj_release
	 del_gendisk
	  md_free_disk
	   mddev_free

Now that you can reporduce this problem 99%, can you dig deeper and find
out what is wrong?

Thanks,
Kuai

> 
> Thanks,
> Mariusz
> 
> .
> 

