Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44DA779C1D5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 03:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233102AbjILBpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 21:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232880AbjILBpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 21:45:14 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B9AA0A60;
        Mon, 11 Sep 2023 18:21:17 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Rl50914Cbz4f3jYQ;
        Tue, 12 Sep 2023 09:02:17 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgCHHt6buP9kMlr7AA--.14108S3;
        Tue, 12 Sep 2023 09:02:21 +0800 (CST)
Subject: Re: [PATCH -next] md: simplify md_seq_ops
To:     Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>,
        Yu Kuai <yukuai1@huaweicloud.com>
Cc:     song@kernel.org, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20230911065010.3530461-1-yukuai1@huaweicloud.com>
 <20230911160540.0000060e@linux.intel.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <b2754d8e-dfe7-ffff-66ac-052f366530e4@huaweicloud.com>
Date:   Tue, 12 Sep 2023 09:02:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20230911160540.0000060e@linux.intel.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCHHt6buP9kMlr7AA--.14108S3
X-Coremail-Antispam: 1UD129KBjvJXoWxKF1UKF4DWr43XF1rZr18Krg_yoW7Gw1xpF
        ZIqFW5Ar4rXFWrXr1DXa1kuFyFqwn7Grn2gr9xGa95Cr1qqrn3AF1Sgw4fu3sI9ayxGrnY
        vw4DKa47Wr18G37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
        IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_
        Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUoOJ5UU
        UUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

ÔÚ 2023/09/11 22:05, Mariusz Tkaczyk Ð´µÀ:
> On Mon, 11 Sep 2023 14:50:10 +0800
> Yu Kuai <yukuai1@huaweicloud.com> wrote:
> 
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> Use seq_list_start/next/stop() directly. Move printing "Personalities"
>> to md_sep_start() and "unsed devices" to md_seq_stop().
>>
>> Cc: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   drivers/md/md.c | 124 ++++++++++++------------------------------------
>>   1 file changed, 31 insertions(+), 93 deletions(-)
>>
>> diff --git a/drivers/md/md.c b/drivers/md/md.c
>> index 0fe7ab6e8ab9..9c1155042335 100644
>> --- a/drivers/md/md.c
>> +++ b/drivers/md/md.c
>> @@ -8192,105 +8192,14 @@ static int status_resync(struct seq_file *seq,
>> struct mddev *mddev) return 1;
>>   }
>>   
>> -static void *md_seq_start(struct seq_file *seq, loff_t *pos)
>> -{
>> -	struct list_head *tmp;
>> -	loff_t l = *pos;
>> -	struct mddev *mddev;
>> -
>> -	if (l == 0x10000) {
>> -		++*pos;
>> -		return (void *)2;
>> -	}
>> -	if (l > 0x10000)
>> -		return NULL;
>> -	if (!l--)
>> -		/* header */
>> -		return (void*)1;
>> -
>> -	spin_lock(&all_mddevs_lock);
>> -	list_for_each(tmp,&all_mddevs)
>> -		if (!l--) {
>> -			mddev = list_entry(tmp, struct mddev, all_mddevs);
>> -			if (!mddev_get(mddev))
>> -				continue;
>> -			spin_unlock(&all_mddevs_lock);
>> -			return mddev;
>> -		}
>> -	spin_unlock(&all_mddevs_lock);
>> -	if (!l--)
>> -		return (void*)2;/* tail */
>> -	return NULL;
>> -}
>> -
>> -static void *md_seq_next(struct seq_file *seq, void *v, loff_t *pos)
>> -{
>> -	struct list_head *tmp;
>> -	struct mddev *next_mddev, *mddev = v;
>> -	struct mddev *to_put = NULL;
>> -
>> -	++*pos;
>> -	if (v == (void*)2)
>> -		return NULL;
>> -
>> -	spin_lock(&all_mddevs_lock);
>> -	if (v == (void*)1) {
>> -		tmp = all_mddevs.next;
>> -	} else {
>> -		to_put = mddev;
>> -		tmp = mddev->all_mddevs.next;
>> -	}
>> -
>> -	for (;;) {
>> -		if (tmp == &all_mddevs) {
>> -			next_mddev = (void*)2;
>> -			*pos = 0x10000;
>> -			break;
>> -		}
>> -		next_mddev = list_entry(tmp, struct mddev, all_mddevs);
>> -		if (mddev_get(next_mddev))
>> -			break;
>> -		mddev = next_mddev;
>> -		tmp = mddev->all_mddevs.next;
>> -	}
>> -	spin_unlock(&all_mddevs_lock);
>> -
>> -	if (to_put)
>> -		mddev_put(mddev);
>> -	return next_mddev;
>> -
>> -}
>> -
>> -static void md_seq_stop(struct seq_file *seq, void *v)
>> -{
>> -	struct mddev *mddev = v;
>> -
>> -	if (mddev && v != (void*)1 && v != (void*)2)
>> -		mddev_put(mddev);
>> -}
>> -
>>   static int md_seq_show(struct seq_file *seq, void *v)
>>   {
>> -	struct mddev *mddev = v;
>> +	struct mddev *mddev = list_entry(v, struct mddev, all_mddevs);
>>   	sector_t sectors;
>>   	struct md_rdev *rdev;
>>   
>> -	if (v == (void*)1) {
>> -		struct md_personality *pers;
>> -		seq_printf(seq, "Personalities : ");
>> -		spin_lock(&pers_lock);
>> -		list_for_each_entry(pers, &pers_list, list)
>> -			seq_printf(seq, "[%s] ", pers->name);
>> -
>> -		spin_unlock(&pers_lock);
>> -		seq_printf(seq, "\n");
>> -		seq->poll_event = atomic_read(&md_event_count);
>> -		return 0;
>> -	}
>> -	if (v == (void*)2) {
>> -		status_unused(seq);
>> +	if (test_bit(MD_DELETED, &mddev->flags))
>>   		return 0;
>> -	}
>>   
>>   	spin_lock(&mddev->lock);
>>   	if (mddev->pers || mddev->raid_disks || !list_empty(&mddev->disks)) {
>> @@ -8366,6 +8275,35 @@ static int md_seq_show(struct seq_file *seq, void *v)
>>   	return 0;
>>   }
>>   
>> +static void *md_seq_start(struct seq_file *seq, loff_t *pos)
>> +{
>> +	struct md_personality *pers;
>> +
>> +	seq_puts(seq, "Personalities : ");
>> +	spin_lock(&pers_lock);
>> +	list_for_each_entry(pers, &pers_list, list)
>> +		seq_printf(seq, "[%s] ", pers->name);
>> +
>> +	spin_unlock(&pers_lock);
>> +	seq_puts(seq, "\n");
>> +	seq->poll_event = atomic_read(&md_event_count);
>> +
>> +	spin_lock(&all_mddevs_lock);
> 
> I would prefer to increase "active" instead holding lock when enumerating over
> the devices. the main reason is that parsing mdstat is implemented in mdadm, so
> it could kind of blocker action- for example mdmon follows mdstat so it is read
> frequently. The time of getting other actions done can highly increase because
> every open or sysfs_read/write requires this lock.
> 
>> +
>> +	return seq_list_start(&all_mddevs, *pos);
>> +}
>> +
>> +static void *md_seq_next(struct seq_file *seq, void *v, loff_t *pos)
>> +{
>> +	return seq_list_next(v, &all_mddevs, pos);
>> +}
> Can it be so simple? Why previous versions takes care of holding "(void)*1" and
> "(void)*2" then? Could you elaborate?

"1" means printing "Personalities", which is now moved to md_seq_start,
and "2" means printing "unsed devices" which is now moved to
md_seq_stop. And now md_seq_next is only used to iterate the mddev list.

Thanks,
Kuai

> 
>> +
>> +static void md_seq_stop(struct seq_file *seq, void *v)
>> +{
>> +	status_unused(seq);
>> +	spin_unlock(&all_mddevs_lock);
>> +}
>> +
>>   static const struct seq_operations md_seq_ops = {
>>   	.start  = md_seq_start,
>>   	.next   = md_seq_next,
> 
> Thanks,
> Mariusz
> 
> .
> 

