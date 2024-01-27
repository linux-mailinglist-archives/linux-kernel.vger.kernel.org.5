Return-Path: <linux-kernel+bounces-41117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1EDE83EC13
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 09:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 368AB2860E2
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 08:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467481DFF8;
	Sat, 27 Jan 2024 08:38:12 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00691EB20;
	Sat, 27 Jan 2024 08:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706344691; cv=none; b=GZdsUf+tb/XUeBzL9PURGVGNtltgU+Su30EuHgmuz+s7rlVQRx0aKJkFuJrTvJv9lYTSrkXuKGmjIkWFQ0lzQ0tt1jbmruo8V6rS5+BKUB8AaRWpGTo+iU3hgOIxoC9eTfRo0uGGP2tMzBCiTSD2Y3wyNFm0pqExignXmDendcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706344691; c=relaxed/simple;
	bh=qQ51tKe9u6UE2HUV1Tzanspswu0oiylus1k/IQy+iOA=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=mq1y77My6yJsXshbA18zIiAjlGFit7pobAtHPBG2OG2Er+NdsUCMlGVOjzGQnTS/A98gSV8unSes9ARqdYEn6MxN1TY6MdvBU1NT3VilxgNSGrgjLMR4UN5EEurbveOo33YdJrKpB9WSGeMd3cGiJ3IDYas0DpJ/xdhzNAwHpgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TMScn101Kz4f3kFr;
	Sat, 27 Jan 2024 16:38:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 25DF21A016E;
	Sat, 27 Jan 2024 16:38:05 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgAX5g7rwLRlLY2DCA--.30010S3;
	Sat, 27 Jan 2024 16:38:04 +0800 (CST)
Subject: Re: [PATCH v4 1/4] md: Don't clear MD_CLOSING when the raid is about
 to stop
To: linan666@huaweicloud.com, song@kernel.org, neilb@suse.com, shli@fb.com,
 mariusz.tkaczyk@linux.intel.com
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, houtao1@huawei.com, yangerkun@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20240126092254.1314908-1-linan666@huaweicloud.com>
 <20240126092254.1314908-2-linan666@huaweicloud.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <51145653-9f9b-e6d5-1b3a-2b25ed3e95f1@huaweicloud.com>
Date: Sat, 27 Jan 2024 16:38:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240126092254.1314908-2-linan666@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX5g7rwLRlLY2DCA--.30010S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCFWkZF4DuF17GrWxXw1xuFg_yoW5XrWUpF
	4xWF1YyrWUJr9ruwsxXw1kJF1Fgw1ftrWqyryayas5Xa4DZr9rWrWFgrZ8ArykKrZ5JFs0
	q3W2qF4DW3Z2gFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
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
	Jr1lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYx
	BIdaVFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2024/01/26 17:22, linan666@huaweicloud.com Ð´µÀ:
> From: Li Nan <linan122@huawei.com>
> 
> The raid should not be opened anymore when it is about to be stopped.
> However, other processes can open it again if the flag MD_CLOSING is
> cleared before exiting. From now on, this flag will not be cleared when
> the raid will be stopped.

This patch looks good, just one nit below:
> 
> Fixes: 065e519e71b2 ("md: MD_CLOSING needs to be cleared after called md_set_readonly or do_md_stop")
> Signed-off-by: Li Nan <linan122@huawei.com>
> Acked-by: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
> ---
>   drivers/md/md.c | 22 ++++++++++++++++++----
>   1 file changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 9bdd57324c37..06550fe34aa1 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -6254,7 +6254,15 @@ static void md_clean(struct mddev *mddev)
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
> @@ -7600,7 +7608,7 @@ static int md_ioctl(struct block_device *bdev, blk_mode_t mode,
>   	int err = 0;
>   	void __user *argp = (void __user *)arg;
>   	struct mddev *mddev = NULL;
> -	bool did_set_md_closing = false;
> +	bool clear_md_closing = false;
>   
>   	if (!md_ioctl_valid(cmd))
>   		return -ENOTTY;
> @@ -7684,7 +7692,7 @@ static int md_ioctl(struct block_device *bdev, blk_mode_t mode,
>   			err = -EBUSY;
>   			goto out;
>   		}
> -		did_set_md_closing = true;
> +		clear_md_closing = true;
>   		mutex_unlock(&mddev->open_mutex);
>   		sync_blockdev(bdev);
>   	}
> @@ -7728,6 +7736,12 @@ static int md_ioctl(struct block_device *bdev, blk_mode_t mode,
>   
>   	case STOP_ARRAY:
>   		err = do_md_stop(mddev, 0, bdev);
> +		if (!err)
> +			/*
> +			 * mddev has been stopped, keep the flag
> +			 * MD_CLOSING to prevent reuse.
> +			 */
> +			clear_md_closing = false;
>   		goto unlock;
>   
>   	case STOP_ARRAY_RO:
> @@ -7826,7 +7840,7 @@ static int md_ioctl(struct block_device *bdev, blk_mode_t mode,
>   				     mddev_unlock(mddev);
>   
>   out:
> -	if(did_set_md_closing)
> +	if (clear_md_closing)

I think code will be simplier if we just remove this local variable, and
replace this with:
if (test_bit(MD_CLOSING, &mddev->flags) && (err || cmd == STOP_ARRAY_RO))

And the same for patch 3.

Thanks,
Kuai

>   		clear_bit(MD_CLOSING, &mddev->flags);
>   	return err;
>   }
> 


