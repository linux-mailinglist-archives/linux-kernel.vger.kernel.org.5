Return-Path: <linux-kernel+bounces-20586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 893C98281E5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 09:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11FE31F274C6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 08:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B0236AF1;
	Tue,  9 Jan 2024 08:28:42 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC781360BA;
	Tue,  9 Jan 2024 08:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4T8PG65gZdz4f3jXY;
	Tue,  9 Jan 2024 16:28:30 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 458251A01CA;
	Tue,  9 Jan 2024 16:28:34 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgDHlxCwA51lgSE5AQ--.33820S3;
	Tue, 09 Jan 2024 16:28:34 +0800 (CST)
Subject: Re: [PATCH v3 2/2] md: simplify md_seq_ops
To: Song Liu <song@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: mariusz.tkaczyk@linux.intel.com, xni@redhat.com,
 linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20230927061241.1552837-1-yukuai1@huaweicloud.com>
 <20230927061241.1552837-3-yukuai1@huaweicloud.com>
 <CAPhsuW6sdnJYtE+iy+x=C2qVKzeN18zibx+qQBF4Y=KRsAmTTg@mail.gmail.com>
 <b6a79bb8-e0fc-09b4-90e7-8112100a3fd0@huaweicloud.com>
 <753615cc-16d6-3c58-99ee-b5e1f0aa0cde@huaweicloud.com>
 <CAPhsuW6Ekxu9kaxvi673MCr=nBCS78D613zuH6Kcg5Y4Hs=jDw@mail.gmail.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <0f3c2220-f929-5b57-0c4d-3e487d3d1415@huaweicloud.com>
Date: Tue, 9 Jan 2024 16:28:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAPhsuW6Ekxu9kaxvi673MCr=nBCS78D613zuH6Kcg5Y4Hs=jDw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDHlxCwA51lgSE5AQ--.33820S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Ww1UXw43ZF47Jr1UWF4xtFb_yoW7Xw4xpF
	s8ZFW3Ar4UXFWFqw1DAa1kuFyFv3ZrKr9Fgr97Gas8Cr1qqr93A3W3Wa13Zrn8uay8Grn8
	Za1UKF9xury8J37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

在 2024/01/09 16:12, Song Liu 写道:
> On Mon, Jan 8, 2024 at 11:48 PM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>
>> Hi,
>>
>> 在 2024/01/09 9:21, Yu Kuai 写道:
>>> Hi,
>>>
>>> 在 2024/01/09 7:38, Song Liu 写道:
>>>> On Tue, Sep 26, 2023 at 11:19 PM Yu Kuai <yukuai1@huaweicloud.com> wrote:
> [...]
>> diff --git a/drivers/md/md.c b/drivers/md/md.c
>> index e351e6c51cc7..289d3d89e73d 100644
>> --- a/drivers/md/md.c
>> +++ b/drivers/md/md.c
>> @@ -8135,6 +8135,19 @@ static void status_unused(struct seq_file *seq)
>>           seq_printf(seq, "\n");
>>    }
>>
>> +static void status_personalities(struct seq_file *seq)
>> +{
>> +       struct md_personality *pers;
>> +
>> +       seq_puts(seq, "Personalities : ");
>> +       spin_lock(&pers_lock);
>> +       list_for_each_entry(pers, &pers_list, list)
>> +               seq_printf(seq, "[%s] ", pers->name);
>> +
>> +       spin_unlock(&pers_lock);
>> +       seq_puts(seq, "\n");
>> +}
>> +
>>    static int status_resync(struct seq_file *seq, struct mddev *mddev)
>>    {
>>           sector_t max_sectors, resync, res;
>> @@ -8273,43 +8286,53 @@ static int status_resync(struct seq_file *seq,
>> struct mddev *mddev)
>>           return 1;
>>    }
>>
>> +#define MDDEV_NONE (void *)1
>> +
>>    static void *md_seq_start(struct seq_file *seq, loff_t *pos)
>>           __acquires(&all_mddevs_lock)
>>    {
>> -       struct md_personality *pers;
>> -
>> -       seq_puts(seq, "Personalities : ");
>> -       spin_lock(&pers_lock);
>> -       list_for_each_entry(pers, &pers_list, list)
>> -               seq_printf(seq, "[%s] ", pers->name);
>> -
>> -       spin_unlock(&pers_lock);
>> -       seq_puts(seq, "\n");
>>           seq->poll_event = atomic_read(&md_event_count);
>> -
>>           spin_lock(&all_mddevs_lock);
>>
>> -       return seq_list_start(&all_mddevs, *pos);
>> +       if (!list_empty(&all_mddevs))
>> +               return seq_list_start(&all_mddevs, *pos);
>> +       else if (*pos == 0)
>> +               return MDDEV_NONE;
>> +       else
>> +               return NULL;
>>    }
>>
>>    static void *md_seq_next(struct seq_file *seq, void *v, loff_t *pos)
>>    {
>> +       if (v == MDDEV_NONE) {
>> +               ++*pos;
>> +               return NULL;
>> +       }
>> +
>>           return seq_list_next(v, &all_mddevs, pos);
>>    }
>>
>>    static void md_seq_stop(struct seq_file *seq, void *v)
>>           __releases(&all_mddevs_lock)
>>    {
>> -       status_unused(seq);
>>           spin_unlock(&all_mddevs_lock);
>>    }
>>    static int md_seq_show(struct seq_file *seq, void *v)
>>    {
>> -       struct mddev *mddev = list_entry(v, struct mddev, all_mddevs);
>> +       struct mddev *mddev;
>>           sector_t sectors;
>>           struct md_rdev *rdev;
>>
>> +       if (v == MDDEV_NONE) {
>> +               status_personalities(seq);
>> +               status_unused(seq);
>> +               return 0;
>> +       }
>> +
>> +       mddev = list_entry(v, struct mddev, all_mddevs);
>> +       if (mddev == list_first_entry(&all_mddevs, struct mddev,
>> all_mddevs))
>> +               status_personalities(seq);
>>           if (!mddev_get(mddev))
>>                   return 0;
>>
>> @@ -8385,6 +8408,10 @@ static int md_seq_show(struct seq_file *seq, void *v)
>>           }
>>           spin_unlock(&mddev->lock);
>>           spin_lock(&all_mddevs_lock);
>> +
>> +       if (mddev == list_last_entry(&all_mddevs, struct mddev, all_mddevs))
>> +               status_unused(seq);
>> +
>>           if (atomic_dec_and_test(&mddev->active))
>>                   __mddev_put(mddev);
>>
> 
> I think something like the following is the right way to do this.
> 
> Thanks,
> Song
> 
> diff --git i/drivers/md/md.c w/drivers/md/md.c
> index 38a6767c65b1..14044febe009 100644
> --- i/drivers/md/md.c
> +++ w/drivers/md/md.c
> @@ -8215,20 +8215,8 @@ static int status_resync(struct seq_file *seq,
> struct mddev *mddev)
>   static void *md_seq_start(struct seq_file *seq, loff_t *pos)
>          __acquires(&all_mddevs_lock)
>   {
> -       struct md_personality *pers;
> -
> -       seq_puts(seq, "Personalities : ");
> -       spin_lock(&pers_lock);
> -       list_for_each_entry(pers, &pers_list, list)
> -               seq_printf(seq, "[%s] ", pers->name);
> -
> -       spin_unlock(&pers_lock);
> -       seq_puts(seq, "\n");
> -       seq->poll_event = atomic_read(&md_event_count);
> -
>          spin_lock(&all_mddevs_lock);
> -
> -       return seq_list_start(&all_mddevs, *pos);
> +       return seq_list_start_head(&all_mddevs, *pos);

Yes, this is good. I didn't notice the api seq_list_start_head().
>   }
> 
>   static void *md_seq_next(struct seq_file *seq, void *v, loff_t *pos)
> @@ -8243,12 +8231,31 @@ static void md_seq_stop(struct seq_file *seq, void *v)
>          spin_unlock(&all_mddevs_lock);
>   }
> 
> +static void md_seq_print_header(struct seq_file *seq)
> +{
> +       struct md_personality *pers;
> +
> +       seq_puts(seq, "Personalities : ");
> +       spin_lock(&pers_lock);
> +       list_for_each_entry(pers, &pers_list, list)
> +               seq_printf(seq, "[%s] ", pers->name);
> +
> +       spin_unlock(&pers_lock);
> +       seq_puts(seq, "\n");
> +       seq->poll_event = atomic_read(&md_event_count);
> +}
> +
>   static int md_seq_show(struct seq_file *seq, void *v)
>   {
>          struct mddev *mddev = list_entry(v, struct mddev, all_mddevs);
>          sector_t sectors;
>          struct md_rdev *rdev;
> 
> +       if (v == &all_mddevs) {
> +               md_seq_print_header(seq);

And I will still move status_unused() to md_seq_show(), because 
seq_read_iter() only handle the case that seq_printf() overflowed from
md_seq_show(), not md_seq_start/stop().

Thanks,
Kuai

> +               return 0;
> +       }
> +
>          if (!mddev_get(mddev))
>                  return 0;
> 
> .
> 


