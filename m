Return-Path: <linux-kernel+bounces-49056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D5984655B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 02:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7821EB22377
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 01:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B2B63B2;
	Fri,  2 Feb 2024 01:19:41 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA8263AD;
	Fri,  2 Feb 2024 01:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706836781; cv=none; b=j8Lfb4MqO11wZ1vGGYWwAUqzXQCzt8g1qf0c7CG/tF7vnHZ4x3cBBXH7Qywfz1lmXykBU+MzCGibfPjqN02sR15TsZ3rcTnhwTMyg/ohkNzrd2SEWXPrqMOWTyWiY6wm+IU/pwPxHrn5Rtr2e3cXpxgIskqDD/iDDYwWaQLFvkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706836781; c=relaxed/simple;
	bh=XsGK3FkVOZzqDTwrgAnRyNSSXFEIk8JfNy0QgYu9YOI=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=uXQ1pznogSthr8AWwsfFjQOrqdl8KllEMnK/ZOgG2cRPVuk4kwkqIL7DusFlkCQzgHb4pStjimOVL8YvduuWGPyUbHaajdGgCwnOBAj+/npRsykh4oN6bKAWh9aPy2+duju9mgvGv9xUiHt9Zk4w39UDI8kWp5VLX5HYm3zgZAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TQyc31qM5z4f3jrt;
	Fri,  2 Feb 2024 09:19:31 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 79F771A0232;
	Fri,  2 Feb 2024 09:19:35 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgBHZQ4lQ7xlhQLOCg--.50066S3;
	Fri, 02 Feb 2024 09:19:35 +0800 (CST)
Subject: Re: [PATCH v5 2/8] md: changed the switch of RAID_VERSION to if
To: linan666@huaweicloud.com, song@kernel.org, neilb@suse.com,
 mariusz.tkaczyk@linux.intel.com, shli@fb.com
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, houtao1@huawei.com, yangerkun@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20240201063404.772797-1-linan666@huaweicloud.com>
 <20240201063404.772797-3-linan666@huaweicloud.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <3a5628b8-ebe2-2385-b289-6a6ced8baf51@huaweicloud.com>
Date: Fri, 2 Feb 2024 09:19:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240201063404.772797-3-linan666@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHZQ4lQ7xlhQLOCg--.50066S3
X-Coremail-Antispam: 1UD129KBjvdXoWrKryxXrWfArW3Gw45uw4Durg_yoW3KFb_ur
	sIvF97Gr9rGr1IkrnYqr1SvryYyFs8Wr4fuFnrtrW5Z3W3X3W8Gw1kGr98Xws5XayUGFn8
	AFn0vryS9w4qkjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3kFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
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

Hi,

ÔÚ 2024/02/01 14:33, linan666@huaweicloud.com Ð´µÀ:
> From: Li Nan <linan122@huawei.com>
> 
> There is only one case of this 'switch'. Change it to 'if'.
> 
> Signed-off-by: Li Nan <linan122@huawei.com>
> ---
>   drivers/md/md.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 1b509fb82040..3b4e0ef49675 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -7636,11 +7636,9 @@ static int md_ioctl(struct block_device *bdev, blk_mode_t mode,
>   	 * Commands dealing with the RAID driver but not any
>   	 * particular array:
>   	 */
> -	switch (cmd) {
> -	case RAID_VERSION:
> +	if (cmd == RAID_VERSION) {
>   		err = get_version(argp);
>   		goto out;

you can just return here;

if (cmd == RAID_VERSION)
	return get_version(argp);

Thanks,
Kuai

> -	default:;
>   	}
>   
>   	/*
> 


