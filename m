Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18A397F44C5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 12:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343565AbjKVLRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 06:17:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjKVLRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 06:17:41 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E290FB9;
        Wed, 22 Nov 2023 03:17:36 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SZzHH0B0tz4f3k64;
        Wed, 22 Nov 2023 19:17:31 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
        by mail.maildlp.com (Postfix) with ESMTP id B3BC81A0756;
        Wed, 22 Nov 2023 19:17:33 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP1 (Coremail) with SMTP id cCh0CgDnNw5M411lMaJ9Bg--.63722S3;
        Wed, 22 Nov 2023 19:17:33 +0800 (CST)
Subject: Re: [PATCH v3 1/3] block: move .bd_inode into 1st cacheline of
 block_device
To:     Yu Kuai <yukuai1@huaweicloud.com>, ming.lei@redhat.com,
        axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20231122103103.1104589-1-yukuai1@huaweicloud.com>
 <20231122103103.1104589-2-yukuai1@huaweicloud.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <d899b7bc-5942-3359-b37f-4ffd15981abb@huaweicloud.com>
Date:   Wed, 22 Nov 2023 19:17:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20231122103103.1104589-2-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgDnNw5M411lMaJ9Bg--.63722S3
X-Coremail-Antispam: 1UD129KBjvJXoW7trWUury5Aw4fuFyfAry8AFb_yoW8Ww1fpF
        ZFkF4UCr4kWrWUurn7K3WfZrySgaykCr47Xry3Kr1FkryaqF1vgF1vyr13ZFy8Crsayrsx
        tF129rWru34UGrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vI
        Y487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
        0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
        0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
        WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8
        JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUoOJ5UU
        UUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

ÔÚ 2023/11/22 18:31, Yu Kuai Ð´µÀ:
> From: Ming Lei <ming.lei@redhat.com>
> 
> The .bd_inode field of block_device is used in IO fast path of
> blkdev_write_iter() and blkdev_llseek(), so it is more efficient to keep
> it into the 1st cacheline.
> 
> .bd_openers is only touched in open()/close(), and .bd_size_lock is only
> for updating bdev capacity, which is in slow path too.
> 
> So swap .bd_inode layout with .bd_openers & .bd_size_lock to move
> .bd_inode into the 1st cache line.
> 
> Cc: Yu Kuai <yukuai3@huawei.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>   include/linux/blk_types.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index d5c5e59ddbd2..f7d40692dd94 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -49,9 +49,10 @@ struct block_device {
>   	bool			bd_write_holder;
>   	bool			bd_has_submit_bio;
>   	dev_t			bd_dev;
> +	struct inode		*bd_inode;	/* will die */

Now that we're here, and bdev->bd_inode is always point to the
field inode of struct bdev_inode, which is next to the field bdev,
and the comment "will die" have been exist for a long time.

Maybe I can try to replace all the reference of bdev->bd_inode with
a helper, and then remove this field, then it'll be acceptable to add
a new field "unsigned long bd_flags".

Thanks,
Kuai


> +
>   	atomic_t		bd_openers;
>   	spinlock_t		bd_size_lock; /* for bd_inode->i_size updates */
> -	struct inode *		bd_inode;	/* will die */
>   	void *			bd_claiming;
>   	void *			bd_holder;
>   	const struct blk_holder_ops *bd_holder_ops;
> 

