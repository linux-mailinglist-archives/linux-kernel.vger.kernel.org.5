Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81F33785B05
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 16:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236643AbjHWOqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 10:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236633AbjHWOqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 10:46:53 -0400
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53297E69;
        Wed, 23 Aug 2023 07:46:51 -0700 (PDT)
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1bbff6b2679so37489485ad.1;
        Wed, 23 Aug 2023 07:46:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692802011; x=1693406811;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1YQZjOVkXN8ph5cdFMiXilx5U9+wMwToRGy9Icv6gHg=;
        b=U3N9mK1PWyafU+Gp1IXgoCHP1MG+5cys7uDYpesyHnP8AGTTans0pVpodI5xyqBmpK
         Aob9GGjmJNoegrj3x7ebouIDqHjCzjU0F7LvziSZrcRVTALpUhSiAwfkzJsE0Z4GQp5s
         rVtdbuwWgDyhK9qiN4g1hpZj5iYvU9iKb6YVhLtoW0kvEB3Vgb5Rb5CN2T1TK3jsNkeZ
         L9NdWypuCG3dM6y4sj0twxCi4whZYT7wooBWqU+44dt9vpjkEdw3/OX4vWTSFB4Y1G5v
         KK9s01bGom8+CEIpQ50m77DCQXL8OuqZgNC/vkTpOYJd/QNB1q8kUPOqL0DIU5/UH59a
         9DLw==
X-Gm-Message-State: AOJu0YwesKd8TnPdaV1dxVgB9jVBsajwUH8ODP8sDlZe4RYmF3cDQ8t5
        xWyHYDT3DKa6RLGOloVF6+w=
X-Google-Smtp-Source: AGHT+IHmiZy5GLZ3Bx+/KPiuB18uuHpZk2WDeV816iPtUH/KuhJmNN//MMuwO+KEvwJlGFhCpaqKIA==
X-Received: by 2002:a17:902:a98a:b0:1bc:50f9:8f20 with SMTP id bh10-20020a170902a98a00b001bc50f98f20mr9634415plb.23.1692802010672;
        Wed, 23 Aug 2023 07:46:50 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:ecb6:e8b9:f433:b4b4? ([2620:15c:211:201:ecb6:e8b9:f433:b4b4])
        by smtp.gmail.com with ESMTPSA id jf15-20020a170903268f00b001bdb8f757besm11063784plb.23.2023.08.23.07.46.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Aug 2023 07:46:49 -0700 (PDT)
Message-ID: <42b7123c-2688-48cb-6f8a-96996338f963@acm.org>
Date:   Wed, 23 Aug 2023 07:46:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH v2 6/6] blk-mq-tag: fix blk_mq_queue_tag_busy_iter()
 documentation
Content-Language: en-US
To:     chengming.zhou@linux.dev, axboe@kernel.dk, ming.lei@redhat.com,
        hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
References: <20230823090441.3986631-1-chengming.zhou@linux.dev>
 <20230823090441.3986631-7-chengming.zhou@linux.dev>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230823090441.3986631-7-chengming.zhou@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/23/23 02:04, chengming.zhou@linux.dev wrote:
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index 087ea6b232f6..69b156750559 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -312,6 +312,7 @@ static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
>    *		tags, false to stop.
>    * @data:	Will be passed as second argument to @fn.
>    * @flags:	BT_TAG_ITER_*
> + * @q:		Only iterate over requests of this queue.
>    */

Please integrate this change in patch 2/6 since the argument 'q' is added by that
patch.

> @@ -432,8 +433,7 @@ EXPORT_SYMBOL(blk_mq_tagset_wait_completed_request);
>    * @priv:	Will be passed as second argument to @fn.
>    *
>    * Note: if @q->tag_set is shared with other request queues then @fn will be
> - * called for all requests on all queues that share that tag set and not only
> - * for requests associated with @q.
> + * called only for requests associated with @q.
>    */
>   void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_tag_iter_fn *fn,
>   		void *priv)

Please consider adding the following to this change:

Fixes: c7b1bf5cca76 ("blk-mq: Document the functions that iterate over requests")

