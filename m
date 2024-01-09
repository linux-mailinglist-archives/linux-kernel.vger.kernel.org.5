Return-Path: <linux-kernel+bounces-20258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37EF0827C85
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 02:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4C13B23062
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 01:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D301873;
	Tue,  9 Jan 2024 01:21:20 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71D1186E;
	Tue,  9 Jan 2024 01:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4T8Cn42k2Yz4f3jpk;
	Tue,  9 Jan 2024 09:21:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 414671A01E3;
	Tue,  9 Jan 2024 09:21:14 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgCXaBGIn5xlFvAaAQ--.9179S3;
	Tue, 09 Jan 2024 09:21:14 +0800 (CST)
Subject: Re: [PATCH v3 2/2] md: simplify md_seq_ops
To: Song Liu <song@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: mariusz.tkaczyk@linux.intel.com, xni@redhat.com,
 linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20230927061241.1552837-1-yukuai1@huaweicloud.com>
 <20230927061241.1552837-3-yukuai1@huaweicloud.com>
 <CAPhsuW6sdnJYtE+iy+x=C2qVKzeN18zibx+qQBF4Y=KRsAmTTg@mail.gmail.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <b6a79bb8-e0fc-09b4-90e7-8112100a3fd0@huaweicloud.com>
Date: Tue, 9 Jan 2024 09:21:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAPhsuW6sdnJYtE+iy+x=C2qVKzeN18zibx+qQBF4Y=KRsAmTTg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCXaBGIn5xlFvAaAQ--.9179S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tw47GF1kCw1DGw17WF1UAwb_yoW8Cw1Dpa
	sxAFs5Gr4kuFZ2krn3WF4DW340vF4kXr15KrnIy3srGryxtF1F934IqrWFgF98WFyUX3Z0
	q3yjkFZ5W345WaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Hi,

在 2024/01/09 7:38, Song Liu 写道:
> On Tue, Sep 26, 2023 at 11:19 PM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> Before this patch, the implementation is hacky and hard to understand:
>>
>> 1) md_seq_start set pos to 1;
>> 2) md_seq_show found pos is 1, then print Personalities;
>> 3) md_seq_next found pos is 1, then it update pos to the first mddev;
>> 4) md_seq_show found pos is not 1 or 2, show mddev;
>> 5) md_seq_next found pos is not 1 or 2, update pos to next mddev;
>> 6) loop 4-5 until the last mddev, then md_seq_next update pos to 2;
>> 7) md_seq_show found pos is 2, then print unused devices;
>> 8) md_seq_next found pos is 2, stop;
>>
>> This patch remove the magic value and use seq_list_start/next/stop()
>> directly, and move printing "Personalities" to md_seq_start(),
>> "unsed devices" to md_seq_stop():
>>
>> 1) md_seq_start print Personalities, and then set pos to first mddev;
>> 2) md_seq_show show mddev;
>> 3) md_seq_next update pos to next mddev;
>> 4) loop 2-3 until the last mddev;
>> 5) md_seq_stop print unsed devices;
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> 
> Just realized this introduced a behavior change:
> 
> When there is not md devices, before this patch, we have
> 
> [root@eth50-1 ~]# cat /proc/mdstat
> Personalities : [raid0] [raid1] [raid10] [raid6] [raid5] [raid4]
> unused devices: <none>
> 
> After this patch, "cat /proc/mdstat" returns nothing. This causes
> some confusion for users who want to read "Personalities" line,
> for example, the mdadm test suite reads it.
> 
> I haven't figured out the best fix yet.

Yes, that's a problem. And after reviewing seq_read_iter() in detail, I
realize that I also can't use seq_printf() in m->op->start() directly,
because if seq buffer overflowed, md_seq_start() can be called more than
once.

I'll fix these problems soon.

Thanks,
Kuai

> 
> Thanks,
> Song
> 
> .
> 


