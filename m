Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3F157BCB6A
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 03:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344199AbjJHBOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 21:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjJHBOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 21:14:46 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23DEF8F;
        Sat,  7 Oct 2023 18:14:45 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4S342N4jWzz4f3jrv;
        Sun,  8 Oct 2023 09:14:36 +0800 (CST)
Received: from [10.174.179.155] (unknown [10.174.179.155])
        by APP4 (Coremail) with SMTP id gCh0CgCHHt6AAiJlf9ueCQ--.50581S3;
        Sun, 08 Oct 2023 09:14:41 +0800 (CST)
Message-ID: <d568537c-b0eb-bd97-9930-ee0eff8088d9@huaweicloud.com>
Date:   Sun, 8 Oct 2023 09:14:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:104.0) Gecko/20100101
 Thunderbird/104.0
Subject: Re: [PATCH -next] block: don't allow a disk link holder to its
 ancestor
To:     hch@lst.de, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai1@huaweicloud.com, houtao1@huawei.com, yi.zhang@huawei.com,
        lilingfeng3@huawei.com, yangerkun <yangerkun@huawei.com>
References: <20230425075558.3450970-1-lilingfeng@huaweicloud.com>
From:   Li Lingfeng <lilingfeng@huaweicloud.com>
In-Reply-To: <20230425075558.3450970-1-lilingfeng@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCHHt6AAiJlf9ueCQ--.50581S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Ar4ftr1DZr47Gr4UJry3XFb_yoW7KF18pF
        WYgF9Yyry8Xr47Wr42qw47uF43Wa18WF4xWF97KryIv39rJF4DCr1xGFyDWF1ftryIkr47
        JFWUGr43uFs2krJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: polox0xjih0w46kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Friendly ping ...

Thanks

在 2023/4/25 15:55, Li Lingfeng 写道:
> From: Li Lingfeng <lilingfeng3@huawei.com>
>
> Previously commit 077a4033541f ("block: don't allow a disk link holder
> to itself") prevent user from reloading dm with itself. However, user
> can reload dm with its ancestor which will trigger dead loop and result
> in oom.
>
> Test procedures:
> 1) dmsetup create test --table "0 20971520 linear /dev/sdd 0"
> 2) dmsetup create test1 --table "0 20971520 linear /dev/sdd 20971520"
> 3) dmsetup suspend test
> 4) dmsetup reload test --table "0 2048 linear /dev/mapper/test1 0"
> 5) dmsetup resume test
> 6) dmsetup suspend test1
> 7) dmsetup reload test1 --table "0 2048 linear /dev/mapper/test 0"
> 8) dmsetup resume test1
>
> Dead loop:
> [  229.681231] Call Trace:
> [  229.681232]  dm_dax_supported+0x5b/0xa0
> [  229.681233]  dax_supported+0x28/0x50
> [  229.681234]  device_not_dax_capable+0x45/0x70
> [  229.681235]  ? realloc_argv+0xa0/0xa0
> [  229.681236]  linear_iterate_devices+0x25/0x30
> [  229.681237]  dm_table_supports_dax+0x42/0xd0
> [  229.681238]  dm_dax_supported+0x5b/0xa0
> [  229.681238]  dax_supported+0x28/0x50
> [  229.681239]  device_not_dax_capable+0x45/0x70
>                  ......(a lot of same lines)
> [  229.681423]  ? realloc_argv+0xa0/0xa0
> [  229.681424]  linear_iterate_devices+0x25/0x30
> [  229.681425]  dm_table_supports_dax+0x42/0xd0
> [  229.681426]  dm
> [  229.681428] Lost 437 message(s)!
> [  229.825588] ---[ end trace 0f2a9db839ed5b56 ]---
>
> OOM:
> [  189.270011] Call Trace:
> [  189.270274]  <TASK>
> [  189.270511]  dump_stack_lvl+0xc1/0x170
> [  189.270899]  dump_stack+0x14/0x20
> [  189.271222]  dump_header+0x5a/0x710
> [  189.271590]  oom_kill_process+0x16b/0x500
> [  189.272018]  out_of_memory+0x333/0xad0
> [  189.272453]  __alloc_pages_slowpath.constprop.0+0x18b4/0x1c40
> [  189.273130]  ? find_held_lock+0x33/0xf0
> [  189.273637]  __alloc_pages+0x598/0x660
> [  189.274106]  alloc_pages+0x95/0x240
> [  189.274482]  folio_alloc+0x1f/0x60
> [  189.274835]  filemap_alloc_folio+0x223/0x350
> [  189.275348]  __filemap_get_folio+0x21e/0x770
> [  189.275916]  filemap_fault+0x72d/0xdc0
> [  189.276454]  __do_fault+0x41/0x360
> [  189.276820]  do_fault+0x263/0x8f0
> [  189.277175]  __handle_mm_fault+0x9af/0x1b20
> [  189.277810]  handle_mm_fault+0x128/0x570
> [  189.278243]  do_user_addr_fault+0x2af/0xea0
> [  189.278733]  exc_page_fault+0x73/0x340
> [  189.279133]  asm_exc_page_fault+0x22/0x30
> [  189.279523] RIP: 0033:0x561e82ac67f0
>
> Forbidding a disk to create link to its ancestor can solve the problem.
> What's more, limit device depth to prevent recursive overflow.
>
> Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
> ---
>   block/holder.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 42 insertions(+)
>
> diff --git a/block/holder.c b/block/holder.c
> index 37d18c13d958..6a8571b7d9c5 100644
> --- a/block/holder.c
> +++ b/block/holder.c
> @@ -2,9 +2,13 @@
>   #include <linux/blkdev.h>
>   #include <linux/slab.h>
>   
> +#define DEVICE_DEPTH 5
> +static DEFINE_MUTEX(slave_bdevs_lock);
> +
>   struct bd_holder_disk {
>   	struct list_head	list;
>   	struct kobject		*holder_dir;
> +	struct gendisk		*slave_disk;
>   	int			refcnt;
>   };
>   
> @@ -29,6 +33,32 @@ static void del_symlink(struct kobject *from, struct kobject *to)
>   	sysfs_remove_link(from, kobject_name(to));
>   }
>   
> +static struct gendisk *iterate_slave_disk(struct gendisk *disk,
> +					   struct gendisk *target, int depth)
> +{
> +	struct bd_holder_disk *holder;
> +	struct gendisk *iter_slave;
> +
> +	if (!depth)
> +		return target;
> +
> +	if (list_empty_careful(&disk->slave_bdevs))
> +		return NULL;
> +
> +	depth--;
> +	list_for_each_entry(holder, &disk->slave_bdevs, list) {
> +		if (holder->slave_disk == target)
> +			return target;
> +
> +		iter_slave = iterate_slave_disk(holder->slave_disk, target, depth);
> +		if (iter_slave)
> +			return iter_slave;
> +
> +		cond_resched();
> +	}
> +	return NULL;
> +}
> +
>   /**
>    * bd_link_disk_holder - create symlinks between holding disk and slave bdev
>    * @bdev: the claimed slave bdev
> @@ -62,6 +92,13 @@ int bd_link_disk_holder(struct block_device *bdev, struct gendisk *disk)
>   	struct bd_holder_disk *holder;
>   	int ret = 0;
>   
> +	mutex_lock(&slave_bdevs_lock);
> +	if (iterate_slave_disk(bdev->bd_disk, disk, DEVICE_DEPTH)) {
> +		mutex_unlock(&slave_bdevs_lock);
> +		return -EINVAL;
> +	}
> +	mutex_unlock(&slave_bdevs_lock);
> +
>   	if (WARN_ON_ONCE(!disk->slave_dir))
>   		return -EINVAL;
>   
> @@ -81,6 +118,7 @@ int bd_link_disk_holder(struct block_device *bdev, struct gendisk *disk)
>   	mutex_unlock(&bdev->bd_disk->open_mutex);
>   
>   	mutex_lock(&disk->open_mutex);
> +	mutex_lock(&slave_bdevs_lock);
>   	WARN_ON_ONCE(!bdev->bd_holder);
>   
>   	holder = bd_find_holder_disk(bdev, disk);
> @@ -106,8 +144,10 @@ int bd_link_disk_holder(struct block_device *bdev, struct gendisk *disk)
>   	ret = add_symlink(bdev->bd_holder_dir, &disk_to_dev(disk)->kobj);
>   	if (ret)
>   		goto out_del_symlink;
> +	holder->slave_disk = bdev->bd_disk;
>   	list_add(&holder->list, &disk->slave_bdevs);
>   
> +	mutex_unlock(&slave_bdevs_lock);
>   	mutex_unlock(&disk->open_mutex);
>   	return 0;
>   
> @@ -141,6 +181,7 @@ void bd_unlink_disk_holder(struct block_device *bdev, struct gendisk *disk)
>   		return;
>   
>   	mutex_lock(&disk->open_mutex);
> +	mutex_lock(&slave_bdevs_lock);
>   	holder = bd_find_holder_disk(bdev, disk);
>   	if (!WARN_ON_ONCE(holder == NULL) && !--holder->refcnt) {
>   		del_symlink(disk->slave_dir, bdev_kobj(bdev));
> @@ -149,6 +190,7 @@ void bd_unlink_disk_holder(struct block_device *bdev, struct gendisk *disk)
>   		list_del_init(&holder->list);
>   		kfree(holder);
>   	}
> +	mutex_unlock(&slave_bdevs_lock);
>   	mutex_unlock(&disk->open_mutex);
>   }
>   EXPORT_SYMBOL_GPL(bd_unlink_disk_holder);

