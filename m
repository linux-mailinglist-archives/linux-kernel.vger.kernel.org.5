Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63B5E784176
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 15:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235953AbjHVNB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 09:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233441AbjHVNB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 09:01:57 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32544CD1;
        Tue, 22 Aug 2023 06:01:54 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-99cce6f7de2so606464066b.3;
        Tue, 22 Aug 2023 06:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692709312; x=1693314112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y7uRU2yw0+QtivPyEBeooJ4wrCrosqZ6/dwHcBFdBSs=;
        b=SxYBFdhM+FN23Ke1aROld8E/mnXIfOwf5+fRpRypDygmsbtwQNFtsig/wbuvh9sjUN
         L2G5i+mPvvugxVV35FJxdLwOCJR/qhzoSUIMkAVoyX1+oMvJFBQdjIWKvbnu4pmKtljj
         v5rOTduUITSQa2eqYwHNgEKPmaClMxMhjfeJDe5pfHHJGbBKuIYmhzHh/f86RBq5U9vD
         HRqZQyJJVFsD7WkBt1gHW8mGmq1ciGbhS89jfS3df1aBJglggcDOTXdobDvJTfE2DgWu
         OYLiuL2+P/sSIP0zWYfJ27SksOKF037+poDkPRE+JLJezZijHS2CFstFD8fWsV2ssv7A
         ag+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692709312; x=1693314112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y7uRU2yw0+QtivPyEBeooJ4wrCrosqZ6/dwHcBFdBSs=;
        b=VesILEd0lBpdZijdzPdz8aZUorKn81jNgScZjLfs7MXd71kzeJbCavV9dgYofcywng
         cJeq4c0o5+kMwxk62OVJEI93a1RUiz5jqaCgNFqHt1r5eyg6zTBvGkRShNaihSVNkeLh
         EypnBujMdMd/WxDMQ3BnSzTqPYiSw7/pFuGoLtNbEbLsRq2Psw69QL9dhVFhxi4g+bZ6
         vBqaunXdd3CZ8Ju8NAyjRGW1kYZgxFLz9d1rs7YoCqnIfdpAMGvlfdRYdgKqgOuURy7+
         pGivjuw9jM9xONZ5SkAC80AUYMQQaysWcgRWMGnu48y4hd6qlneCxFXwg+Sjd9UzN9IM
         WcWQ==
X-Gm-Message-State: AOJu0Yxnao/m4YXYd0B5PjidydHqXh348XumPU5erdTPxEeqm8l1zcO7
        C2FfGM/8kf24SLskHcdYVvk=
X-Google-Smtp-Source: AGHT+IFmuCYEzWICY1O6jlC2x150UebiypigGJwRb0YaxYsFDA+/ZkpjfqzxgUL6KbUmgjyqPmqpzQ==
X-Received: by 2002:a17:906:51cb:b0:99c:6bc8:e84b with SMTP id v11-20020a17090651cb00b0099c6bc8e84bmr8155533ejk.58.1692709312343;
        Tue, 22 Aug 2023 06:01:52 -0700 (PDT)
Received: from [192.168.178.25] ([185.254.126.155])
        by smtp.gmail.com with ESMTPSA id v18-20020a170906b01200b0098e78ff1a87sm8221693ejy.120.2023.08.22.06.01.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Aug 2023 06:01:51 -0700 (PDT)
Message-ID: <a05e0c2e-fd62-4a8e-9fa4-dffaf86f7730@gmail.com>
Date:   Tue, 22 Aug 2023 15:01:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [Linaro-mm-sig] [PATCH v2] dma-buf/sw_sync: Avoid recursive lock
 during fence signal
Content-Language: en-US
To:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
Cc:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Rob Clark <robdclark@chromium.org>,
        Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        "open list:SYNC FILE FRAMEWORK" <linux-media@vger.kernel.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230818145939.39697-1-robdclark@gmail.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230818145939.39697-1-robdclark@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 18.08.23 um 16:59 schrieb Rob Clark:
> From: Rob Clark <robdclark@chromium.org>
>
> If a signal callback releases the sw_sync fence, that will trigger a
> deadlock as the timeline_fence_release recurses onto the fence->lock
> (used both for signaling and the the timeline tree).
>
> To avoid that, temporarily hold an extra reference to the signalled
> fences until after we drop the lock.
>
> (This is an alternative implementation of https://patchwork.kernel.org/patch/11664717/
> which avoids some potential UAF issues with the original patch.)
>
> v2: Remove now obsolete comment, use list_move_tail() and
>      list_del_init()
>
> Reported-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
> Fixes: d3c6dd1fb30d ("dma-buf/sw_sync: Synchronize signal vs syncpt free")
> Signed-off-by: Rob Clark <robdclark@chromium.org>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/dma-buf/sw_sync.c | 18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/dma-buf/sw_sync.c b/drivers/dma-buf/sw_sync.c
> index 63f0aeb66db6..f0a35277fd84 100644
> --- a/drivers/dma-buf/sw_sync.c
> +++ b/drivers/dma-buf/sw_sync.c
> @@ -191,6 +191,7 @@ static const struct dma_fence_ops timeline_fence_ops = {
>    */
>   static void sync_timeline_signal(struct sync_timeline *obj, unsigned int inc)
>   {
> +	LIST_HEAD(signalled);
>   	struct sync_pt *pt, *next;
>   
>   	trace_sync_timeline(obj);
> @@ -203,21 +204,20 @@ static void sync_timeline_signal(struct sync_timeline *obj, unsigned int inc)
>   		if (!timeline_fence_signaled(&pt->base))
>   			break;
>   
> -		list_del_init(&pt->link);
> +		dma_fence_get(&pt->base);
> +
> +		list_move_tail(&pt->link, &signalled);
>   		rb_erase(&pt->node, &obj->pt_tree);
>   
> -		/*
> -		 * A signal callback may release the last reference to this
> -		 * fence, causing it to be freed. That operation has to be
> -		 * last to avoid a use after free inside this loop, and must
> -		 * be after we remove the fence from the timeline in order to
> -		 * prevent deadlocking on timeline->lock inside
> -		 * timeline_fence_release().
> -		 */
>   		dma_fence_signal_locked(&pt->base);
>   	}
>   
>   	spin_unlock_irq(&obj->lock);
> +
> +	list_for_each_entry_safe(pt, next, &signalled, link) {
> +		list_del_init(&pt->link);
> +		dma_fence_put(&pt->base);
> +	}
>   }
>   
>   /**

