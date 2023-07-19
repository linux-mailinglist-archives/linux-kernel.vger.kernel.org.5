Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85C0B758AA4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 03:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjGSBJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 21:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGSBJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 21:09:50 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B43B1722;
        Tue, 18 Jul 2023 18:09:48 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4R5Hm646R7z4f3npn;
        Wed, 19 Jul 2023 09:09:42 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgCHLaHVN7dkCTwuOQ--.44983S3;
        Wed, 19 Jul 2023 09:09:42 +0800 (CST)
Subject: Re: [PATCH] scsi/sg: fix checking return value of blk_get_queue()
To:     Yu Kuai <yukuai1@huaweicloud.com>, mhartmay@linux.ibm.com,
        bblock@linux.ibm.com, bvanassche@acm.org, hch@lst.de,
        axboe@kernel.dk
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230705024001.177585-1-yukuai1@huaweicloud.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <d112d30e-d144-4c76-db98-5de4767f5945@huaweicloud.com>
Date:   Wed, 19 Jul 2023 09:09:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20230705024001.177585-1-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCHLaHVN7dkCTwuOQ--.44983S3
X-Coremail-Antispam: 1UD129KBjvJXoW7KF45JryUKF43Ar1UArWxXrb_yoW8GF17pF
        Z3Can0krW8trW7C3WIqr4UZF93Ka4xt3ySkay3t3s8ur43Ary09rWxG3WUWFn5ArWkGa15
        KF4qqayDW3WUJaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
        IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_
        Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUoOJ5UU
        UUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jens

ÔÚ 2023/07/05 10:40, Yu Kuai Ð´µÀ:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Commit fcaa174a9c99 ("scsi/sg: don't grab scsi host module reference")
> make a mess how blk_get_queue() is called, blk_get_queue() returns true
> on success while the caller expects it returns 0 on success.
> 
> Fix this problem and also add a corresponding error message on failure.
> 
> Fixes: fcaa174a9c99 ("scsi/sg: don't grab scsi host module reference")
> Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
> Closes: https://lore.kernel.org/all/87lefv622n.fsf@linux.ibm.com/
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Sorry about the trouble... Can you apply this patch? I notice that the
original patch is applied to stable.

Thanks,
Kuai

> ---
>   drivers/scsi/sg.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
> index 89fa046c7158..0d8afffd1683 100644
> --- a/drivers/scsi/sg.c
> +++ b/drivers/scsi/sg.c
> @@ -1497,9 +1497,10 @@ sg_add_device(struct device *cl_dev)
>   	int error;
>   	unsigned long iflags;
>   
> -	error = blk_get_queue(scsidp->request_queue);
> -	if (error)
> -		return error;
> +	if (!blk_get_queue(scsidp->request_queue)) {
> +		pr_warn("%s: get scsi_device queue failed\n", __func__);
> +		return -ENODEV;
> +	}
>   
>   	error = -ENOMEM;
>   	cdev = cdev_alloc();
> 

