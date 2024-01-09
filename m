Return-Path: <linux-kernel+bounces-20494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77259827FC2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 08:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F7441C22B99
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 07:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BBFB671;
	Tue,  9 Jan 2024 07:48:33 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521216D6E2;
	Tue,  9 Jan 2024 07:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4T8NMp6tvqz4f3kjN;
	Tue,  9 Jan 2024 15:48:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 6EB0D1A0272;
	Tue,  9 Jan 2024 15:48:26 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgBXKBFJ+pxlGV82AQ--.34051S3;
	Tue, 09 Jan 2024 15:48:26 +0800 (CST)
Subject: Re: [PATCH v3 2/2] md: simplify md_seq_ops
To: Yu Kuai <yukuai1@huaweicloud.com>, Song Liu <song@kernel.org>
Cc: mariusz.tkaczyk@linux.intel.com, xni@redhat.com,
 linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20230927061241.1552837-1-yukuai1@huaweicloud.com>
 <20230927061241.1552837-3-yukuai1@huaweicloud.com>
 <CAPhsuW6sdnJYtE+iy+x=C2qVKzeN18zibx+qQBF4Y=KRsAmTTg@mail.gmail.com>
 <b6a79bb8-e0fc-09b4-90e7-8112100a3fd0@huaweicloud.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <753615cc-16d6-3c58-99ee-b5e1f0aa0cde@huaweicloud.com>
Date: Tue, 9 Jan 2024 15:48:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <b6a79bb8-e0fc-09b4-90e7-8112100a3fd0@huaweicloud.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBXKBFJ+pxlGV82AQ--.34051S3
X-Coremail-Antispam: 1UD129KBjvJXoWxGFyrAryDWr43AFy7Ww18AFb_yoWrtFyDpa
	9xZFWUAr4DZFWrtw4DXa1kua4Fv3ZFqryqgr9rG3s3Cr1jqr9a93W3XrWjvF98uFW8W3Z8
	Zw4UKFyUWrW8JwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Hi,

在 2024/01/09 9:21, Yu Kuai 写道:
> Hi,
> 
> 在 2024/01/09 7:38, Song Liu 写道:
>> On Tue, Sep 26, 2023 at 11:19 PM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>>
>>> From: Yu Kuai <yukuai3@huawei.com>
>>>
>>> Before this patch, the implementation is hacky and hard to understand:
>>>
>>> 1) md_seq_start set pos to 1;
>>> 2) md_seq_show found pos is 1, then print Personalities;
>>> 3) md_seq_next found pos is 1, then it update pos to the first mddev;
>>> 4) md_seq_show found pos is not 1 or 2, show mddev;
>>> 5) md_seq_next found pos is not 1 or 2, update pos to next mddev;
>>> 6) loop 4-5 until the last mddev, then md_seq_next update pos to 2;
>>> 7) md_seq_show found pos is 2, then print unused devices;
>>> 8) md_seq_next found pos is 2, stop;
>>>
>>> This patch remove the magic value and use seq_list_start/next/stop()
>>> directly, and move printing "Personalities" to md_seq_start(),
>>> "unsed devices" to md_seq_stop():
>>>
>>> 1) md_seq_start print Personalities, and then set pos to first mddev;
>>> 2) md_seq_show show mddev;
>>> 3) md_seq_next update pos to next mddev;
>>> 4) loop 2-3 until the last mddev;
>>> 5) md_seq_stop print unsed devices;
>>>
>>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>>
>> Just realized this introduced a behavior change:
>>
>> When there is not md devices, before this patch, we have
>>
>> [root@eth50-1 ~]# cat /proc/mdstat
>> Personalities : [raid0] [raid1] [raid10] [raid6] [raid5] [raid4]
>> unused devices: <none>
>>
>> After this patch, "cat /proc/mdstat" returns nothing. This causes
>> some confusion for users who want to read "Personalities" line,
>> for example, the mdadm test suite reads it.
>>
>> I haven't figured out the best fix yet.
> 
> Yes, that's a problem. And after reviewing seq_read_iter() in detail, I
> realize that I also can't use seq_printf() in m->op->start() directly,
> because if seq buffer overflowed, md_seq_start() can be called more than
> once.
> 
> I'll fix these problems soon.
How about following patch(already tested)?

Thanks,
Kuai

diff --git a/drivers/md/md.c b/drivers/md/md.c
index e351e6c51cc7..289d3d89e73d 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -8135,6 +8135,19 @@ static void status_unused(struct seq_file *seq)
         seq_printf(seq, "\n");
  }

+static void status_personalities(struct seq_file *seq)
+{
+       struct md_personality *pers;
+
+       seq_puts(seq, "Personalities : ");
+       spin_lock(&pers_lock);
+       list_for_each_entry(pers, &pers_list, list)
+               seq_printf(seq, "[%s] ", pers->name);
+
+       spin_unlock(&pers_lock);
+       seq_puts(seq, "\n");
+}
+
  static int status_resync(struct seq_file *seq, struct mddev *mddev)
  {
         sector_t max_sectors, resync, res;
@@ -8273,43 +8286,53 @@ static int status_resync(struct seq_file *seq, 
struct mddev *mddev)
         return 1;
  }

+#define MDDEV_NONE (void *)1
+
  static void *md_seq_start(struct seq_file *seq, loff_t *pos)
         __acquires(&all_mddevs_lock)
  {
-       struct md_personality *pers;
-
-       seq_puts(seq, "Personalities : ");
-       spin_lock(&pers_lock);
-       list_for_each_entry(pers, &pers_list, list)
-               seq_printf(seq, "[%s] ", pers->name);
-
-       spin_unlock(&pers_lock);
-       seq_puts(seq, "\n");
         seq->poll_event = atomic_read(&md_event_count);
-
         spin_lock(&all_mddevs_lock);

-       return seq_list_start(&all_mddevs, *pos);
+       if (!list_empty(&all_mddevs))
+               return seq_list_start(&all_mddevs, *pos);
+       else if (*pos == 0)
+               return MDDEV_NONE;
+       else
+               return NULL;
  }

  static void *md_seq_next(struct seq_file *seq, void *v, loff_t *pos)
  {
+       if (v == MDDEV_NONE) {
+               ++*pos;
+               return NULL;
+       }
+
         return seq_list_next(v, &all_mddevs, pos);
  }

  static void md_seq_stop(struct seq_file *seq, void *v)
         __releases(&all_mddevs_lock)
  {
-       status_unused(seq);
         spin_unlock(&all_mddevs_lock);
  }
  static int md_seq_show(struct seq_file *seq, void *v)
  {
-       struct mddev *mddev = list_entry(v, struct mddev, all_mddevs);
+       struct mddev *mddev;
         sector_t sectors;
         struct md_rdev *rdev;

+       if (v == MDDEV_NONE) {
+               status_personalities(seq);
+               status_unused(seq);
+               return 0;
+       }
+
+       mddev = list_entry(v, struct mddev, all_mddevs);
+       if (mddev == list_first_entry(&all_mddevs, struct mddev, 
all_mddevs))
+               status_personalities(seq);
         if (!mddev_get(mddev))
                 return 0;

@@ -8385,6 +8408,10 @@ static int md_seq_show(struct seq_file *seq, void *v)
         }
         spin_unlock(&mddev->lock);
         spin_lock(&all_mddevs_lock);
+
+       if (mddev == list_last_entry(&all_mddevs, struct mddev, all_mddevs))
+               status_unused(seq);
+
         if (atomic_dec_and_test(&mddev->active))
                 __mddev_put(mddev);




> 
> Thanks,
> Kuai
> 
>>
>> Thanks,
>> Song
>>
>> .
>>
> 
> .
> 


