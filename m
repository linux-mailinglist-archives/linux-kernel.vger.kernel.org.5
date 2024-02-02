Return-Path: <linux-kernel+bounces-49062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5096284656A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 02:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E5C028C802
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 01:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E184563B7;
	Fri,  2 Feb 2024 01:26:36 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574F65666;
	Fri,  2 Feb 2024 01:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706837196; cv=none; b=D8Fwnd6i+Hl+uEeoj7ntTh9NE+rd6yJDTsRe/Z/oAS9YxQ8We1pgANC7bVfqZy99c3H3AuOdKtex9cYn3huMCfYsi0wCn/uyGH/2qtcWUnxRVazZQAJZ4ShTMTBuq1AP0CQPbhERWZyRccnlUlm+FmycHcB4k319lW0B5aG0PnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706837196; c=relaxed/simple;
	bh=DvYXBDf4sN5DWZ90nPNkb85I8Wchwj0FHfdLWKicX4I=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=UAdg4IeseOhitEAJKgZcOAyrdqb/Ecc//8Vcab9Bil4TTqQ37Y3sfR7E31gewa/+i2WO7sT4NVR5zIqn5xRi1fRpD8EGMXVJee2W97ayJ0uXCopW6nxXbKEP67co5zoiF0m41ZcvbT6qXAv7kz9xzWAozm1l41PM+C+MPZHZlx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TQym26Q7jz4f3jR6;
	Fri,  2 Feb 2024 09:26:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 23C961A0232;
	Fri,  2 Feb 2024 09:26:31 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgAX5g7GRLxlDYDOCg--.8923S3;
	Fri, 02 Feb 2024 09:26:30 +0800 (CST)
Subject: Re: [PATCH v5 5/8] md: Don't clear MD_CLOSING when the raid is about
 to stop
To: linan666@huaweicloud.com, song@kernel.org, neilb@suse.com,
 mariusz.tkaczyk@linux.intel.com, shli@fb.com
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, houtao1@huawei.com, yangerkun@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20240201063404.772797-1-linan666@huaweicloud.com>
 <20240201063404.772797-6-linan666@huaweicloud.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <c97337c6-4234-68d5-3352-bd61d5c00459@huaweicloud.com>
Date: Fri, 2 Feb 2024 09:26:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240201063404.772797-6-linan666@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX5g7GRLxlDYDOCg--.8923S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tF1xCw13Jw4xCF4DuFy3Jwb_yoW8urWUpa
	1xKFy5KrWUJ3sxuw47tw1Dua4Fv34SqrWqyry2va4rXa4DAr9rGrZa93yDWF1kGrWrAFs0
	q3W7Wa1Uuw1Ig3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVW3JVWr
	Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7VUbKsjUUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

ÔÚ 2024/02/01 14:34, linan666@huaweicloud.com Ð´µÀ:
> From: Li Nan <linan122@huawei.com>
> 
> The raid should not be opened anymore when it is about to be stopped.
> However, other processes can open it again if the flag MD_CLOSING is
> cleared before exiting. From now on, this flag will not be cleared when
> the raid will be stopped.
> 
> Fixes: 065e519e71b2 ("md: MD_CLOSING needs to be cleared after called md_set_readonly or do_md_stop")
> Signed-off-by: Li Nan <linan122@huawei.com>

LGTM
Reviewed-by: Yu Kuai <yukuai3@huawei.com>

> ---
>   drivers/md/md.c | 14 ++++++++++----
>   1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 5442e8e3c161..deee004b8f22 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -6247,7 +6247,15 @@ static void md_clean(struct mddev *mddev)
>   	mddev->persistent = 0;
>   	mddev->level = LEVEL_NONE;
>   	mddev->clevel[0] = 0;
> -	mddev->flags = 0;
> +	/*
> +	 * Don't clear MD_CLOSING, or mddev can be opened again.
> +	 * 'hold_active != 0' means mddev is still in the creation
> +	 * process and will be used later.
> +	 */
> +	if (mddev->hold_active)
> +		mddev->flags = 0;
> +	else
> +		mddev->flags &= BIT_ULL_MASK(MD_CLOSING);
>   	mddev->sb_flags = 0;
>   	mddev->ro = MD_RDWR;
>   	mddev->metadata_type[0] = 0;
> @@ -7626,7 +7634,6 @@ static int md_ioctl(struct block_device *bdev, blk_mode_t mode,
>   	int err = 0;
>   	void __user *argp = (void __user *)arg;
>   	struct mddev *mddev = NULL;
> -	bool did_set_md_closing = false;
>   
>   	err = md_ioctl_valid(cmd);
>   	if (err)
> @@ -7687,7 +7694,6 @@ static int md_ioctl(struct block_device *bdev, blk_mode_t mode,
>   			mutex_unlock(&mddev->open_mutex);
>   			return -EBUSY;
>   		}
> -		did_set_md_closing = true;
>   		mutex_unlock(&mddev->open_mutex);
>   		sync_blockdev(bdev);
>   	}
> @@ -7829,7 +7835,7 @@ static int md_ioctl(struct block_device *bdev, blk_mode_t mode,
>   				     mddev_unlock(mddev);
>   
>   out:
> -	if(did_set_md_closing)
> +	if (cmd == STOP_ARRAY_RO || (err && cmd == STOP_ARRAY))
>   		clear_bit(MD_CLOSING, &mddev->flags);
>   	return err;
>   }
> 


