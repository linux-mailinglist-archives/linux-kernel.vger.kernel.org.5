Return-Path: <linux-kernel+bounces-45692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC7C843439
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 03:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59E151F251ED
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 02:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C66FBE1;
	Wed, 31 Jan 2024 02:51:48 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0117DFBE7;
	Wed, 31 Jan 2024 02:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706669508; cv=none; b=E6HxHcpiGg11wuba1b8PtPJvZgvyP3541yrFNACNAt7PvScJH3a3kyAFmxYEWvVl2R35NrO2L/2F3gp29y7Y1WgNf6BHgbp8kKvGHxVp9gAGypS8doWN33DltdJ6x7387MEPyQaCehlIMns7mc2cODgHmdJreR8BNgGoa5+ZTcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706669508; c=relaxed/simple;
	bh=LBJRaF3RGO3hVoNKd7CGkHEMK0mtNVjA3dEhYrl/3WU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=iUD3b2fQpJrGCcritTzW2KE3aulaMzQaFqyxFjvwGT8nAgXQsG7pjdtCkfxseCZCaNDNqB7TrCPQvExEaXSa+rUZoK8Aer1YK8wuK1cEnfNGpZt9C2HzZIoDaYJsuVLdJVN4qhz5MFZA9r1c6OXS6gQRNBpFN8zkez5UJJbMMe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TPmlB5Qqgz4f3lWJ;
	Wed, 31 Jan 2024 10:51:34 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 40D2D1A0232;
	Wed, 31 Jan 2024 10:51:41 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgBnOBG7tbllMKkHCg--.3626S3;
	Wed, 31 Jan 2024 10:51:40 +0800 (CST)
Subject: Re: [PATCH v4 RFC 14/14] dm-raid: remove mddev_suspend/resume()
To: Yu Kuai <yukuai1@huaweicloud.com>, mpatocka@redhat.com,
 heinzm@redhat.com, xni@redhat.com, agk@redhat.com, snitzer@kernel.org,
 dm-devel@lists.linux.dev, song@kernel.org, jbrassow@f14.redhat.com,
 neilb@suse.de, shli@fb.com, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20240130021843.3608859-1-yukuai1@huaweicloud.com>
 <20240130021843.3608859-15-yukuai1@huaweicloud.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <57ec6c2d-f5bb-10fc-39e8-097704daa96c@huaweicloud.com>
Date: Wed, 31 Jan 2024 10:51:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240130021843.3608859-15-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBnOBG7tbllMKkHCg--.3626S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJFW3KF4DZF4kurW3Ww13CFg_yoW5Xr1rp3
	y0qFWakw1UJrZrZwnFy3Z29FyYqwn5KrWqkr93GayxX3W3Grn5Wr18GayUXFWkKFWxCF1q
	y3WYy398ur9FgrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9214x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWr
	Zr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x0JUAxhLUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2024/01/30 10:18, Yu Kuai Ð´µÀ:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> dm_suspend() already make sure that no new IO can be issued and will
> wait for all dispatched IO to be done. There is no need to call
> mddev_suspend() to make sure that again.
> 

I'm about to send the final version(I hope), please let me know if
anyone thinks this patch should not be included.

Thanks,
Kuai
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>   drivers/md/dm-raid.c |  8 +++-----
>   drivers/md/md.c      | 11 +++++++++++
>   2 files changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
> index 5f78cc19d6f3..ed8c28952b14 100644
> --- a/drivers/md/dm-raid.c
> +++ b/drivers/md/dm-raid.c
> @@ -3241,7 +3241,7 @@ static int raid_ctr(struct dm_target *ti, unsigned int argc, char **argv)
>   	rs->md.in_sync = 1;
>   
>   	/* Has to be held on running the array */
> -	mddev_suspend_and_lock_nointr(&rs->md);
> +	mddev_lock_nointr(&rs->md);
>   
>   	/* Keep array frozen until resume. */
>   	md_frozen_sync_thread(&rs->md);
> @@ -3829,11 +3829,9 @@ static void raid_postsuspend(struct dm_target *ti)
>   {
>   	struct raid_set *rs = ti->private;
>   
> -	if (!test_and_set_bit(RT_FLAG_RS_SUSPENDED, &rs->runtime_flags)) {
> +	if (!test_and_set_bit(RT_FLAG_RS_SUSPENDED, &rs->runtime_flags))
>   		/* Writes have to be stopped before suspending to avoid deadlocks. */
>   		md_stop_writes(&rs->md);
> -		mddev_suspend(&rs->md, false);
> -	}
>   }
>   
>   static void attempt_restore_of_faulty_devices(struct raid_set *rs)
> @@ -4091,7 +4089,7 @@ static void raid_resume(struct dm_target *ti)
>   		mddev->ro = 0;
>   		mddev->in_sync = 0;
>   		md_unfrozen_sync_thread(mddev);
> -		mddev_unlock_and_resume(mddev);
> +		mddev_unlock(mddev);
>   	}
>   }
>   
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 093abf3ce27b..e3a56a958b47 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -437,6 +437,10 @@ int mddev_suspend(struct mddev *mddev, bool interruptible)
>   {
>   	int err = 0;
>   
> +	/* Array is supended from dm_suspend() for dm-raid. */
> +	if (!mddev->gendisk)
> +		return 0;
> +
>   	/*
>   	 * hold reconfig_mutex to wait for normal io will deadlock, because
>   	 * other context can't update super_block, and normal io can rely on
> @@ -488,6 +492,13 @@ EXPORT_SYMBOL_GPL(mddev_suspend);
>   
>   static void __mddev_resume(struct mddev *mddev, bool recovery_needed)
>   {
> +	/*
> +	 * Array is supended from dm_suspend() and resumed from dm_resume() for
> +	 * dm-raid.
> +	 */
> +	if (!mddev->gendisk)
> +		return;
> +
>   	lockdep_assert_not_held(&mddev->reconfig_mutex);
>   
>   	mutex_lock(&mddev->suspend_mutex);
> 


