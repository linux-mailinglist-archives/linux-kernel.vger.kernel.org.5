Return-Path: <linux-kernel+bounces-49057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A34C484655D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 02:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3112B28C111
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 01:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF25863B2;
	Fri,  2 Feb 2024 01:20:53 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79E68BE2;
	Fri,  2 Feb 2024 01:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706836853; cv=none; b=fUKDvJyovYkLctKnuuuiR8bynHUK37lOyflMhSg4l3UwngJBM885fA+DsrmZyeR1QwYQU73/FN5nVzLhLgK5WegqaV2N0UdIHUmlxzEKk+Qmqu3intlictM/jyC0eELFFhjlCUayVzNbSyuUkiTStx1Nx3ryuKUVyhTM0RY7Pqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706836853; c=relaxed/simple;
	bh=QHUPsnuqBdOga40R1E9C83JycIvaihZqq5TWfhZ+908=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=U5fFIWcQm6ZoNciPRLqcQOE20pM86QmmVApHPIMCGw6/lA0DHgYOPNBIfrQlTZMTPYEILJQ1O7QUJ4fiIKmAXAh0K2wdKL2RRz5aVywhzyxhhxRRFD3tfivg0W4i18G1/dRd7rfzYo8B868JK9cYhLib7MR5aG+/nkKSqzkqXWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TQydN6Hnbz4f3lDd;
	Fri,  2 Feb 2024 09:20:40 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 6D2571A0172;
	Fri,  2 Feb 2024 09:20:47 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgCXaBFuQ7xlnBjOCg--.18202S3;
	Fri, 02 Feb 2024 09:20:47 +0800 (CST)
Subject: Re: [PATCH v5 3/8] md: clean up invalid BUG_ON in md_ioctl
To: linan666@huaweicloud.com, song@kernel.org, neilb@suse.com,
 mariusz.tkaczyk@linux.intel.com, shli@fb.com
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, houtao1@huawei.com, yangerkun@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20240201063404.772797-1-linan666@huaweicloud.com>
 <20240201063404.772797-4-linan666@huaweicloud.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <5bff1d65-ebdc-9a5d-01e9-a8b5a0f0848b@huaweicloud.com>
Date: Fri, 2 Feb 2024 09:20:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240201063404.772797-4-linan666@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCXaBFuQ7xlnBjOCg--.18202S3
X-Coremail-Antispam: 1UD129KBjvdXoWrKryxJr1xWr1UKFyDGw17Wrg_yoWfKFc_C3
	yFvr9rWr1xZF1Ik3W3tw1fZFyrKF1DWrs7u3W29r1rZa47X348KFZakw15Ka1rWFWxurWq
	yrsIyrsYyFsrKjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3kFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Zr0_Wr1U
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUp6wZUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

ÔÚ 2024/02/01 14:33, linan666@huaweicloud.com Ð´µÀ:
> From: Li Nan <linan122@huawei.com>
> 
> 'disk->private_data' is set to mddev in md_alloc() and never set to NULL,
> and users need to open mddev before submitting ioctl. So mddev must not
> have been freed during ioctl, and there is no need to check mddev here.
> Clean up it.
> 
> Signed-off-by: Li Nan <linan122@huawei.com>
> ---
>   drivers/md/md.c | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 3b4e0ef49675..656080086052 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -7647,11 +7647,6 @@ static int md_ioctl(struct block_device *bdev, blk_mode_t mode,
>   
>   	mddev = bdev->bd_disk->private_data;
>   
> -	if (!mddev) {
> -		BUG();

Given that this BUG() never triggered before.

Reviewed-by: Yu Kuai <yukuai3@huawei.com>

> -		goto out;
> -	}
> -
>   	/* Some actions do not requires the mutex */
>   	switch (cmd) {
>   	case GET_ARRAY_INFO:
> 


