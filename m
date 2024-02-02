Return-Path: <linux-kernel+bounces-49060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D23B4846566
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 02:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 031221C24DA6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 01:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48378814;
	Fri,  2 Feb 2024 01:24:57 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9676C5689;
	Fri,  2 Feb 2024 01:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706837097; cv=none; b=jBIVPgwgSTnizcEcq6M/uWrTHWIlOltL5Hr+DLq67t6MpEGqX0lnhB7/Qg+KBpFG5K+QaL5XL930Pm+R+Xuu1dhQGEjpWdopB1NFrtPg2KZU88kOHCEZDro/GGjuuvqnfk4peKtKUI+4v/SU6IUyDGuKL5ox50KsOxfUA3iu/C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706837097; c=relaxed/simple;
	bh=wytPMTXKd3u7gslBQV4dJp4sfISDVrMB88TNl9Xj00Y=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=O94MKIo4jTtPe6ZLBN19aKOV4Tn3OSd2cqGx/Me9kLQRmE7hA9o1MJ7JFsz/Xt/4AHG4/1SXGlq78t2vV4zF56w5SMtG0odzLx4xXMAujp3HMJLzrAu5PHGUngXX2gGY9g7HxDeR87tVx+9UeHsmCPrv8gZrM+lhdpAIVjveZUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TQyk85V2Yz4f3jq6;
	Fri,  2 Feb 2024 09:24:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 5E9EB1A027B;
	Fri,  2 Feb 2024 09:24:51 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgAn+RFiRLxl4GHOCg--.52664S3;
	Fri, 02 Feb 2024 09:24:51 +0800 (CST)
Subject: Re: [PATCH v5 4/8] md: return directly before setting
 did_set_md_closing
To: linan666@huaweicloud.com, song@kernel.org, neilb@suse.com,
 mariusz.tkaczyk@linux.intel.com, shli@fb.com
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, houtao1@huawei.com, yangerkun@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20240201063404.772797-1-linan666@huaweicloud.com>
 <20240201063404.772797-5-linan666@huaweicloud.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <029ed81c-aa85-ed1b-73e4-a1d0c86064ce@huaweicloud.com>
Date: Fri, 2 Feb 2024 09:24:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240201063404.772797-5-linan666@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAn+RFiRLxl4GHOCg--.52664S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tF13WrykZFW3uw4kKFW3KFg_yoW8tF4kpF
	W2qas0kryUJrWUKr1vqa4DZa4Yvw1akFWvkryxGa4UZr9rArsxWryFgw4Yvry09a4kAw4Y
	qF429FW3ua4xGFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6Fyj6rWU
	JwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUouWlDUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2024/02/01 14:34, linan666@huaweicloud.com Ð´µÀ:
> From: Li Nan <linan122@huawei.com>
> 
> There is nothing to do at 'out' before setting 'did_set_md_closing'
> in md_ioctl(). Return directly, and it will help us to remove
> 'did_set_md_closing' later.
> 
> Signed-off-by: Li Nan <linan122@huawei.com>
> ---
>   drivers/md/md.c | 23 ++++++++---------------
>   1 file changed, 8 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 656080086052..5442e8e3c161 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -7636,10 +7636,8 @@ static int md_ioctl(struct block_device *bdev, blk_mode_t mode,
>   	 * Commands dealing with the RAID driver but not any
>   	 * particular array:
>   	 */
> -	if (cmd == RAID_VERSION) {
> -		err = get_version(argp);
> -		goto out;
> -	}
> +	if (cmd == RAID_VERSION)
> +		return get_version(argp);
Please merge this into patch 2.

>   
>   	/*
>   	 * Commands creating/starting a new array:
> @@ -7654,23 +7652,20 @@ static int md_ioctl(struct block_device *bdev, blk_mode_t mode,
>   			err = -ENODEV;
>   		else
>   			err = get_array_info(mddev, argp);

You can also remove 'err' here:

if (...)
	return -ENODEV;
return get_array_info(mddev, argp);

> -		goto out;
> +		return err;
>   
>   	case GET_DISK_INFO:
>   		if (!mddev->raid_disks && !mddev->external)
>   			err = -ENODEV;
>   		else
>   			err = get_disk_info(mddev, argp);

Same here.

Thanks,
Kuai

> -		goto out;
> +		return err;
>   
>   	case SET_DISK_FAULTY:
> -		err = set_disk_faulty(mddev, new_decode_dev(arg));
> -		goto out;
> +		return set_disk_faulty(mddev, new_decode_dev(arg));
>   
>   	case GET_BITMAP_FILE:
> -		err = get_bitmap_file(mddev, argp);
> -		goto out;
> -
> +		return get_bitmap_file(mddev, argp);
>   	}
>   
>   	if (cmd == HOT_REMOVE_DISK)
> @@ -7686,13 +7681,11 @@ static int md_ioctl(struct block_device *bdev, blk_mode_t mode,
>   		mutex_lock(&mddev->open_mutex);
>   		if (mddev->pers && atomic_read(&mddev->openers) > 1) {
>   			mutex_unlock(&mddev->open_mutex);
> -			err = -EBUSY;
> -			goto out;
> +			return -EBUSY;
>   		}
>   		if (test_and_set_bit(MD_CLOSING, &mddev->flags)) {
>   			mutex_unlock(&mddev->open_mutex);
> -			err = -EBUSY;
> -			goto out;
> +			return -EBUSY;
>   		}
>   		did_set_md_closing = true;
>   		mutex_unlock(&mddev->open_mutex);
> 


