Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD9937CF467
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 11:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345159AbjJSJtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 05:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233009AbjJSJs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 05:48:58 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A98130
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 02:48:33 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-5aed4f0e90bso3840567a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 02:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697708912; x=1698313712; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JY2RHi8J0dknAQahRfvff3wFWP0EUTol6JY9TKNymCE=;
        b=KLX4S2nd6Z00rYuszOyg9YZx0JsjZVa85f536dTdMaMbkmbNrQFvncKAk9LnH7kJt9
         nwWq0vFI+WaD/TRAEIyAZxcy2R/5VNX8rtSDTIUVI15eswLUYQt2K2/VZdfDhRTIJCAu
         m4gHupfIKXCQJzfwBgsorSGVJWgKAhVvELI0+6vIh0sfMI6Uh1lDsbtcnomEBcrtWNW4
         x3NZz0SUcFDL3u/IHujBRB/dqo+Wtlwa3rJyrtBy8PxJbQPJs5+yxvApt3gvwv2861v7
         pGYaPUmMFXBLTaKEMHBv4pXI8UZOkmpoOyeazqT6HKjRHH706E+FBqkQFqqcF5kKj9ZU
         Okdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697708912; x=1698313712;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JY2RHi8J0dknAQahRfvff3wFWP0EUTol6JY9TKNymCE=;
        b=AJ21BzZFQc6EoYShTQSAibqVZNOBXKgHA6ufiEKwz5i1iSDEtS5kq6iVNlASn9SD7a
         dQPMz9AJBXzGr8SI3uN1gssfmIzSw/0pF7dtiRv/GrNKDTP/FoZhHqeitKFBgKqgQWAg
         ZHvR84YI0SPC1dO/gPCNrGrFj0OUf3Qn5IuwZAvDsK+9cTSG7DA0XGmgYOMZhxY2bsk2
         wcFFSl7eKLXoI1wlnEJXmHvO0KFq8/r3R2e0ZxfoBBowndVa/V9j78UBe/nt3tWG6uBI
         2xKkZ6eu8KfgCJyLH7fTFfpXJwz3o+5YtHh+Mo7ujvpffkXp8i72Pi2PyjXY6ItYtiIk
         Hhhw==
X-Gm-Message-State: AOJu0YwQgFFJQA74LCsAcmqHaHnboPHQw6K+KFBDpel/kzbEngadh/zg
        zyJa3IZc9xK2mpRUbhIhDa+KqA==
X-Google-Smtp-Source: AGHT+IFM9A5zHwr54bBJYZlxUokLUP7giAPuLnQTdz9Hgfwz+qQW/yzUe6+uFHzohQT8sKMvSM6sEw==
X-Received: by 2002:a17:902:ce81:b0:1ca:3d53:2867 with SMTP id f1-20020a170902ce8100b001ca3d532867mr2054272plg.15.1697708912629;
        Thu, 19 Oct 2023 02:48:32 -0700 (PDT)
Received: from [10.3.43.196] ([61.213.176.12])
        by smtp.gmail.com with ESMTPSA id p6-20020a170902e74600b001bdd7579b5dsm1478111plf.240.2023.10.19.02.48.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 02:48:32 -0700 (PDT)
Message-ID: <dedde8ee-6edb-4950-aa8b-e89e025440b7@bytedance.com>
Date:   Thu, 19 Oct 2023 17:43:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: PING: [PATCH] virtio-blk: fix implicit overflow on
 virtio_max_dma_size
Content-Language: en-US
To:     mst@redhat.com
Cc:     jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
        virtualization@lists.linux-foundation.org, axboe@kernel.dk,
        linux-kernel@vger.kernel.org
References: <20230904061045.510460-1-pizhenwei@bytedance.com>
From:   zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <20230904061045.510460-1-pizhenwei@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

This seems to have been ignored as you suggested.

LINK: https://www.spinics.net/lists/linux-virtualization/msg63015.html

On 9/4/23 14:10, zhenwei pi wrote:
> The following codes have an implicit conversion from size_t to u32:
> (u32)max_size = (size_t)virtio_max_dma_size(vdev);
> 
> This may lead overflow, Ex (size_t)4G -> (u32)0. Once
> virtio_max_dma_size() has a larger size than U32_MAX, use U32_MAX
> instead.
> 
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>   drivers/block/virtio_blk.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 1fe011676d07..4a4b9bad551e 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -1313,6 +1313,7 @@ static int virtblk_probe(struct virtio_device *vdev)
>   	u16 min_io_size;
>   	u8 physical_block_exp, alignment_offset;
>   	unsigned int queue_depth;
> +	size_t max_dma_size;
>   
>   	if (!vdev->config->get) {
>   		dev_err(&vdev->dev, "%s failure: config access disabled\n",
> @@ -1411,7 +1412,8 @@ static int virtblk_probe(struct virtio_device *vdev)
>   	/* No real sector limit. */
>   	blk_queue_max_hw_sectors(q, UINT_MAX);
>   
> -	max_size = virtio_max_dma_size(vdev);
> +	max_dma_size = virtio_max_dma_size(vdev);
> +	max_size = max_dma_size > U32_MAX ? U32_MAX : max_dma_size;
>   
>   	/* Host can optionally specify maximum segment size and number of
>   	 * segments. */

-- 
zhenwei pi
