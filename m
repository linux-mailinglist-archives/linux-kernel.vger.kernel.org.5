Return-Path: <linux-kernel+bounces-14078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C698217A7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 07:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE0FBB216F2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 06:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F381856;
	Tue,  2 Jan 2024 06:16:47 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C4C468C;
	Tue,  2 Jan 2024 06:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4T42g44pR7z4f3kkb;
	Tue,  2 Jan 2024 14:16:32 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 62E731A017D;
	Tue,  2 Jan 2024 14:16:34 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgDHFg1AqpNlQD4wFQ--.57217S3;
	Tue, 02 Jan 2024 14:16:34 +0800 (CST)
Subject: Re: [PATCH] md: get rdev->mddev with READ_ONCE()
To: Li Lingfeng <lilingfeng@huaweicloud.com>, song@kernel.org
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
 linan122@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com,
 lilingfeng3@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20231229070500.3602712-1-lilingfeng@huaweicloud.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <a5d9a13b-6b95-b2ba-203a-f8bb8dfb4936@huaweicloud.com>
Date: Tue, 2 Jan 2024 14:16:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231229070500.3602712-1-lilingfeng@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDHFg1AqpNlQD4wFQ--.57217S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww1Uuw43uF1xCrW7Ww4fAFb_yoW8Jw4xp3
	yrXFy5Wr1Yv3y5Cw4UZFWkuasYqwn3KrZFyrW3u34rZa4jqwnxKF1UW3yDXFyrZanrur4x
	XF47Wa1DX3sIgrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
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
	Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbU
	UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

ÔÚ 2023/12/29 15:05, Li Lingfeng Ð´µÀ:
> From: Li Lingfeng <lilingfeng3@huawei.com>
> 
> Users may get rdev->mddev by sysfs while rdev is releasing.
> So use both READ_ONCE() and WRITE_ONCE() to prevent load/store tearing
> and to read/write mddev atomically.

LGTM
Reviewed-by: Yu Kuai <yukuai3@huawei.com>
> 
> Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
> ---
>   drivers/md/md.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 9bdd57324c37..3b38a565bffa 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -2562,7 +2562,7 @@ static void md_kick_rdev_from_array(struct md_rdev *rdev)
>   	list_del_rcu(&rdev->same_set);
>   	pr_debug("md: unbind<%pg>\n", rdev->bdev);
>   	mddev_destroy_serial_pool(rdev->mddev, rdev);
> -	rdev->mddev = NULL;
> +	WRITE_ONCE(rdev->mddev, NULL);
>   	sysfs_remove_link(&rdev->kobj, "block");
>   	sysfs_put(rdev->sysfs_state);
>   	sysfs_put(rdev->sysfs_unack_badblocks);
> @@ -3646,7 +3646,7 @@ rdev_attr_store(struct kobject *kobj, struct attribute *attr,
>   	struct kernfs_node *kn = NULL;
>   	bool suspend = false;
>   	ssize_t rv;
> -	struct mddev *mddev = rdev->mddev;
> +	struct mddev *mddev = READ_ONCE(rdev->mddev);
>   
>   	if (!entry->store)
>   		return -EIO;
> 


