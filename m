Return-Path: <linux-kernel+bounces-9231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F5781C2A1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 02:17:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DB4C2881B8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 01:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1894A5E;
	Fri, 22 Dec 2023 01:17:04 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DB020FB;
	Fri, 22 Dec 2023 01:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Sx8XM4wgJz4f3l1C;
	Fri, 22 Dec 2023 09:16:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id E9DDA1A01CA;
	Fri, 22 Dec 2023 09:16:56 +0800 (CST)
Received: from [10.174.179.247] (unknown [10.174.179.247])
	by APP2 (Coremail) with SMTP id Syh0CgAHqkiH44RlAqSoEQ--.6406S3;
	Fri, 22 Dec 2023 09:16:56 +0800 (CST)
Message-ID: <d00e6729-6e13-b1ab-0991-ce79b1245cfd@huaweicloud.com>
Date: Fri, 22 Dec 2023 09:16:55 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/2] md: fix WARN_ON if create symlink fail in
 bind_rdev_to_array()
To: Song Liu <song@kernel.org>, linan666@huaweicloud.com
Cc: yukuai3@huawei.com, linux-raid@vger.kernel.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, houtao1@huawei.com,
 yangerkun@huawei.com
References: <20231221071109.1562530-1-linan666@huaweicloud.com>
 <20231221071109.1562530-2-linan666@huaweicloud.com>
 <CAPhsuW5SPiy5bsSfagYrSLa3JTn2Gw0VJKUToS2PS9h4w2=zSA@mail.gmail.com>
From: Li Nan <linan666@huaweicloud.com>
In-Reply-To: <CAPhsuW5SPiy5bsSfagYrSLa3JTn2Gw0VJKUToS2PS9h4w2=zSA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgAHqkiH44RlAqSoEQ--.6406S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJr17Gr4fArWrtF1kKw48Zwb_yoW8tr17pF
	W8GFy3Ar4UJr1Uu3Wjqay5CFyYg3W7tFW8JFy3C34Sva43Ars3Cr10gFW7XryDWrnxCF47
	X3WUG397ua9Y9F7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v
	4I1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1l
	IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWI
	evJa73UjIFyTuYvjfUOlksUUUUU
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/



在 2023/12/22 2:58, Song Liu 写道:
> Hi,
> 
> On Wed, Dec 20, 2023 at 11:13 PM <linan666@huaweicloud.com> wrote:
>>
>> From: Li Nan <linan122@huawei.com>
>>
>> Removing a device can trigger WARN_ON in bd_unlink_disk_holder() if creating
>> symlink failed while adding device.
>>
>>    WARNING: CPU: 0 PID: 742 at block/holder.c:145 bd_unlink_disk_holder+0x17b/0x1a0
>>
>> Fix it by adding the flag 'SymlinkCreated', which only be set after
>> creating symlink success.
>>
>> Signed-off-by: Li Nan <linan122@huawei.com>
>> ---
>>   drivers/md/md.h | 3 +++
>>   drivers/md/md.c | 8 ++++++--
>>   2 files changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/md/md.h b/drivers/md/md.h
>> index 8d881cc59799..427d17713a8c 100644
>> --- a/drivers/md/md.h
>> +++ b/drivers/md/md.h
>> @@ -207,6 +207,9 @@ enum flag_bits {
>>                                   * check if there is collision between raid1
>>                                   * serial bios.
>>                                   */
>> +       SymlinkCreated,         /* This device has created the symlink
>> +                                * with gendisk.
>> +                                */
> 
> In general, I would like to avoid adding flags if possible.
> 

This flag is mainly used to fix deadlock in next patch. Or should we
export bd_find_holder_disk()? Link hodler if it return NULL.
just like:

   rdev_for_each_rcu
     if (!bd_find_holder_disk)
       bd_link_disk_holder


>>   };
>>
>>   static inline int is_badblock(struct md_rdev *rdev, sector_t s, int sectors,
>> diff --git a/drivers/md/md.c b/drivers/md/md.c
>> index e05858653a41..d6612b922c76 100644
>> --- a/drivers/md/md.c
>> +++ b/drivers/md/md.c
>> @@ -2526,7 +2526,8 @@ static int bind_rdev_to_array(struct md_rdev *rdev, struct mddev *mddev)
>>                  sysfs_get_dirent_safe(rdev->kobj.sd, "bad_blocks");
>>
>>          list_add_rcu(&rdev->same_set, &mddev->disks);
>> -       bd_link_disk_holder(rdev->bdev, mddev->gendisk);
>> +       if (!bd_link_disk_holder(rdev->bdev, mddev->gendisk))
>> +               set_bit(SymlinkCreated, &rdev->flags);
> 
> Shall we just fail bind_rdev_to_array() if bd_link_disk_holder()
> returns non-zero?
> 

I keep this action because of commit 00bcb4ac7ee7 ("md: reduce
dependence on sysfs."). Fail bind_rdev_to_array is good to me.

> Thanks,
> Song
> 
> .

-- 
Thanks,
Nan


