Return-Path: <linux-kernel+bounces-8018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDD581B0AB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E33D81C2308E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 08:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DABB1219E7;
	Thu, 21 Dec 2023 08:49:27 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEC320DC6;
	Thu, 21 Dec 2023 08:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Swkcv3MNKz4f3jqc;
	Thu, 21 Dec 2023 16:49:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id D69EF1A0B5A;
	Thu, 21 Dec 2023 16:49:20 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgD3RQwO_INlQ2LuEA--.33218S3;
	Thu, 21 Dec 2023 16:49:20 +0800 (CST)
Subject: Re: [PATCH 2/2] md: create symlink with disk holder after mddev
 resume
To: linan666@huaweicloud.com, song@kernel.org
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, houtao1@huawei.com, yangerkun@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20231221071109.1562530-1-linan666@huaweicloud.com>
 <20231221071109.1562530-3-linan666@huaweicloud.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <3b240652-580e-73d5-a318-612984902aad@huaweicloud.com>
Date: Thu, 21 Dec 2023 16:49:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231221071109.1562530-3-linan666@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgD3RQwO_INlQ2LuEA--.33218S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCFyrAF13ZryDuw1rJw1DZFb_yoWrZFyrpa
	yfWFy5GrWUXr9xZrWUXasxGF15Xw18Krs7try3u34IgasxArsIkr1rury5Xry8t3sxZF4D
	X3W5Xw4DuF1IgFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
	wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
	k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
	1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2023/12/21 15:11, linan666@huaweicloud.com Ð´µÀ:
> From: Li Nan <linan122@huawei.com>
> 
> There is a risk of deadlock when a process gets disk->open_mutex after
> suspending mddev, because other processes may hold open_mutex while
> submitting io. For example:
> 
>    T1				T2
>    blkdev_open
>     bdev_open_by_dev
>      mutex_lock(&disk->open_mutex)
>    				md_ioctl
>    				 mddev_suspend_and_lock
>    				  mddev_suspend
>    				 md_add_new_disk
>    				  bind_rdev_to_array
>    				   bd_link_disk_holder
>    				    //wait open_mutex
>      blkdev_get_whole
>       bdev_disk_changed
>        efi_partition
>         read_lba
>          ...
>           md_submit_bio
>            md_handle_request
>             //wait resume
> 

Nice catch! This patch looks good except that the new flag
'SymlinkCreated' doesn't look accurate, perhaps 'HolderLinked'
will make more sense.

Thanks,
Kuai

> Fix it by getting disk->open_mutex after mddev resume, iterating each
> mddev->disk to create symlink for rdev which has not been created yet.
> and moving bd_unlink_disk_holder() to mddev_unlock(), rdev has been
> deleted from mddev->disks here, which can avoid concurrent bind and unbind,
> 
> Fixes: 1b0a2d950ee2 ("md: use new apis to suspend array for ioctls involed array reconfiguration")
> Signed-off-by: Li Nan <linan122@huawei.com>
> ---
>   drivers/md/md.c | 39 +++++++++++++++++++++++++++++----------
>   1 file changed, 29 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index d6612b922c76..c128570f2a5d 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -521,6 +521,20 @@ void mddev_resume(struct mddev *mddev)
>   }
>   EXPORT_SYMBOL_GPL(mddev_resume);
>   
> +static void md_link_disk_holder(struct mddev *mddev)
> +{
> +	struct md_rdev *rdev;
> +
> +	rcu_read_lock();
> +	rdev_for_each_rcu(rdev, mddev) {
> +		if (test_bit(SymlinkCreated, &rdev->flags))
> +			continue;
> +		if (!bd_link_disk_holder(rdev->bdev, mddev->gendisk))
> +			set_bit(SymlinkCreated, &rdev->flags);
> +	}
> +	rcu_read_unlock();
> +}
> +
>   /*
>    * Generic flush handling for md
>    */
> @@ -902,6 +916,11 @@ void mddev_unlock(struct mddev *mddev)
>   
>   	list_for_each_entry_safe(rdev, tmp, &delete, same_set) {
>   		list_del_init(&rdev->same_set);
> +		if (test_bit(SymlinkCreated, &rdev->flags)) {
> +			bd_unlink_disk_holder(rdev->bdev, rdev->mddev->gendisk);
> +			clear_bit(SymlinkCreated, &rdev->flags);
> +		}
> +		rdev->mddev = NULL;
>   		kobject_del(&rdev->kobj);
>   		export_rdev(rdev, mddev);
>   	}
> @@ -2526,8 +2545,6 @@ static int bind_rdev_to_array(struct md_rdev *rdev, struct mddev *mddev)
>   		sysfs_get_dirent_safe(rdev->kobj.sd, "bad_blocks");
>   
>   	list_add_rcu(&rdev->same_set, &mddev->disks);
> -	if (!bd_link_disk_holder(rdev->bdev, mddev->gendisk))
> -		set_bit(SymlinkCreated, &rdev->flags);
>   
>   	/* May as well allow recovery to be retried once */
>   	mddev->recovery_disabled++;
> @@ -2562,14 +2579,9 @@ static void md_kick_rdev_from_array(struct md_rdev *rdev)
>   {
>   	struct mddev *mddev = rdev->mddev;
>   
> -	if (test_bit(SymlinkCreated, &rdev->flags)) {
> -		bd_unlink_disk_holder(rdev->bdev, rdev->mddev->gendisk);
> -		clear_bit(SymlinkCreated, &rdev->flags);
> -	}
>   	list_del_rcu(&rdev->same_set);
>   	pr_debug("md: unbind<%pg>\n", rdev->bdev);
>   	mddev_destroy_serial_pool(rdev->mddev, rdev);
> -	rdev->mddev = NULL;
>   	sysfs_remove_link(&rdev->kobj, "block");
>   	sysfs_put(rdev->sysfs_state);
>   	sysfs_put(rdev->sysfs_unack_badblocks);
> @@ -4667,8 +4679,10 @@ new_dev_store(struct mddev *mddev, const char *buf, size_t len)
>   	if (err)
>   		export_rdev(rdev, mddev);
>   	mddev_unlock_and_resume(mddev);
> -	if (!err)
> +	if (!err) {
> +		md_link_disk_holder(mddev);
>   		md_new_event();
> +	}
>   	return err ? err : len;
>   }
>   
> @@ -6606,6 +6620,7 @@ static void autorun_devices(int part)
>   			}
>   			autorun_array(mddev);
>   			mddev_unlock_and_resume(mddev);
> +			md_link_disk_holder(mddev);
>   		}
>   		/* on success, candidates will be empty, on error
>   		 * it won't...
> @@ -7832,8 +7847,12 @@ static int md_ioctl(struct block_device *bdev, blk_mode_t mode,
>   	    err != -EINVAL)
>   		mddev->hold_active = 0;
>   
> -	md_ioctl_need_suspend(cmd) ? mddev_unlock_and_resume(mddev) :
> -				     mddev_unlock(mddev);
> +	if (md_ioctl_need_suspend(cmd)) {
> +		mddev_unlock_and_resume(mddev);
> +		md_link_disk_holder(mddev);
> +	} else {
> +		mddev_unlock(mddev);
> +	}
>   
>   out:
>   	if(did_set_md_closing)
> 


