Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 382677DA6A9
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 13:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjJ1LLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 07:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjJ1LLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 07:11:11 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01FB2F2
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 04:11:08 -0700 (PDT)
Received: from dggpemm500011.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4SHcDV4cW4zMmJW;
        Sat, 28 Oct 2023 19:06:50 +0800 (CST)
Received: from [10.174.179.155] (10.174.179.155) by
 dggpemm500011.china.huawei.com (7.185.36.110) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Sat, 28 Oct 2023 19:11:06 +0800
Message-ID: <ebb49e01-3a3b-29d9-eb92-2ca453993d5b@huawei.com>
Date:   Sat, 28 Oct 2023 19:10:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:104.0) Gecko/20100101
 Thunderbird/104.0
Subject: Re: [PATCH] dm: remove dm_set_md_type()
To:     <dm-devel@redhat.com>
CC:     <agk@redhat.com>, <snitzer@kernel.org>,
        <linux-kernel@vger.kernel.org>, <houtao1@huawei.com>,
        <yi.zhang@huawei.com>, <yangerkun@huawei.com>,
        <yukuai3@huawei.com>, <hch@lst.de>
References: <20230912122605.3487911-1-lilingfeng3@huawei.com>
From:   Li Lingfeng <lilingfeng3@huawei.com>
In-Reply-To: <20230912122605.3487911-1-lilingfeng3@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.155]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500011.china.huawei.com (7.185.36.110)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Friendly ping ...

Thanks

在 2023/9/12 20:26, Li Lingfeng 写道:
> Commit ba30585936b0 ("dm: move setting md->type into dm_setup_md_queue")
> has removed the only reference to dm_set_md_type(), so remove
> dm_set_md_type() now.
>
> Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
> ---
>   drivers/md/dm.c | 6 ------
>   drivers/md/dm.h | 1 -
>   2 files changed, 7 deletions(-)
>
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index f0f118ab20fa..6b9d04ca09d0 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -2316,12 +2316,6 @@ void dm_unlock_md_type(struct mapped_device *md)
>   	mutex_unlock(&md->type_lock);
>   }
>   
> -void dm_set_md_type(struct mapped_device *md, enum dm_queue_mode type)
> -{
> -	BUG_ON(!mutex_is_locked(&md->type_lock));
> -	md->type = type;
> -}
> -
>   enum dm_queue_mode dm_get_md_type(struct mapped_device *md)
>   {
>   	return md->type;
> diff --git a/drivers/md/dm.h b/drivers/md/dm.h
> index f682295af91f..cc55ef3441be 100644
> --- a/drivers/md/dm.h
> +++ b/drivers/md/dm.h
> @@ -76,7 +76,6 @@ bool dm_table_request_based(struct dm_table *t);
>   
>   void dm_lock_md_type(struct mapped_device *md);
>   void dm_unlock_md_type(struct mapped_device *md);
> -void dm_set_md_type(struct mapped_device *md, enum dm_queue_mode type);
>   enum dm_queue_mode dm_get_md_type(struct mapped_device *md);
>   struct target_type *dm_get_immutable_target_type(struct mapped_device *md);
>   
