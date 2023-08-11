Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 941F27784CB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 03:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbjHKBO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 21:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjHKBO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 21:14:56 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209DE9F;
        Thu, 10 Aug 2023 18:14:54 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RMQnM6N6yz4f3mJJ;
        Fri, 11 Aug 2023 09:14:47 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgA3x6mJi9VkbmyxAQ--.10709S3;
        Fri, 11 Aug 2023 09:14:50 +0800 (CST)
Subject: Re: [PATCH 1/3] md raid1: allow writebehind to work on any leg device
 set WriteMostly
To:     heinzm@redhat.com, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org
Cc:     ncroxon@redhat.com, xni@redhat.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <cover.1691592775.git.heinzm@redhat.com>
 <31b94de1196389c8d5e7a29d01ec1e7d20735d4e.1691592775.git.heinzm@redhat.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <1b42c6ba-168d-4764-1eba-3f7050883e69@huaweicloud.com>
Date:   Fri, 11 Aug 2023 09:14:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <31b94de1196389c8d5e7a29d01ec1e7d20735d4e.1691592775.git.heinzm@redhat.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgA3x6mJi9VkbmyxAQ--.10709S3
X-Coremail-Antispam: 1UD129KBjvdXoW7Gr13JFWxJrW8Gr45uFWUCFg_yoWDAFg_Kr
        n093s2gr1rJrySv3W5ur13ur43Kwn5u3W7XFWft3WrXFn8XF9Y93sY9rW8Jw13Jay8JrW3
        Wr4qq3WFyrZ8ZjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbzxYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267
        AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80
        ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4
        AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vI
        r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
        xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
        cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
        AvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7Cj
        xVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

ÔÚ 2023/08/10 20:11, heinzm@redhat.com Ð´µÀ:
> From: heinzm <heinzm@redhat.com>
> 
> As the WriteMostly flag can be set on any component device of a RAID1 array,
> remove the constraint that it only works if set on the first one.
> 
> Signed-off-by: heinzm <heinzm@redhat.com>
> ---
>   drivers/md/raid1.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> index dd25832eb045..913cd46b786b 100644
> --- a/drivers/md/raid1.c
> +++ b/drivers/md/raid1.c
> @@ -1519,7 +1519,7 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
>   			 * allocate memory, or a reader on WriteMostly
>   			 * is waiting for behind writes to flush */
>   			if (bitmap &&
> -			    test_bit(WriteMostly, &rdev->flags) &&
> +			    write_behind &&

No need for a new line now.

Reviewed-by: Yu Kuai <yukuai3@huawei.com>

Thanks
>   			    (atomic_read(&bitmap->behind_writes)
>   			     < mddev->bitmap_info.max_write_behind) &&
>   			    !waitqueue_active(&bitmap->behind_wait)) {
> 

