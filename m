Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F989752B4F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 22:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233496AbjGMUDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 16:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbjGMUDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 16:03:21 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C472D4E
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 13:03:20 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4fba03becc6so3003499e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 13:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689278598; x=1689883398;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yvt8Ku6KDe29tpizQm23o+O9+z8bar+cVRkERkmQ91w=;
        b=FIEiEaFZqrXW8g8YQ8JN5/m9jV8Rn+IH6+81QIfMP6OXn6Yx3ig8G05Rc2TzTjM92V
         QFyWvhupVc7i04q4dWNiplHx7Q54ZZ/p4Z4dTusHG2IpEOi6l1NkpfxgsTi6rwyQzD8n
         ZOC4c3xWeMOxZIeWojRjqw8OBPKWgl2fwPLd3RbgzlKjxxn5AGLn6dPVbCsBCTmJ3Rlm
         KPkU95S9zJR0wNt0nB+MgZSVuuEnUR/P3bGoZeVBJ9aeve2Juk38x177QueyngiiE4ST
         WdJInwrH3RsE3yoZvv0N4Pdg88osODnbFo9cvLG61hQfRW8CZlCBL3T4Aj9TXIDQV4Uq
         A3Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689278598; x=1689883398;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yvt8Ku6KDe29tpizQm23o+O9+z8bar+cVRkERkmQ91w=;
        b=hZ7kAN2OFfZvAgfMqjvMoa8wqk5eH6N4k2kwI/+B9cm3n68oWBy+8j8JFIdHTYLJar
         NI98SOWhemOHACr1/gBh28UWjQKQ1yG4IESycRagB0wlt48ssTppYPtT/MhzW2D9StSd
         x8mOw4X6ng6P+XDFTNHk1P78l+1b4s7EHfj3gR8O+roXh+9ohUmmPC44iqAKlA5vUxjU
         0f0G+eDNpnEdbkSdQEmQArKldsQo5GmGvCAwYrWouf5PKmtl0VNHrOzbWm2YKoQN5FEL
         JhNZEnEW1oGf+9s3WgOwhPBvMd7sliuY4FLZ2xvRtqzTxTMkX7QJVoLtgM2hNIzbe8Ee
         pXrg==
X-Gm-Message-State: ABy/qLZXByBoqZMqqjegLiXV/Fwb67JsoCB7ZOdw2Ye4so/BiFtuGAe8
        4P2/4Y7F2rm18SvT//1AXRdgQg==
X-Google-Smtp-Source: APBJJlHvFT4NkzYf8AiTu0gZdv5cunOm8vlcbun9kkFFQ7/GyRaJ58yCVi/nDi7GsigvUUQbiZlZ0g==
X-Received: by 2002:a05:6512:398a:b0:4f9:5582:a7d3 with SMTP id j10-20020a056512398a00b004f95582a7d3mr218898lfu.22.1689278598227;
        Thu, 13 Jul 2023 13:03:18 -0700 (PDT)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id x7-20020ac259c7000000b004f84b36a24fsm1227265lfn.51.2023.07.13.13.03.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 13:03:17 -0700 (PDT)
Message-ID: <a7aa6e21-6f79-0029-5034-db368239980a@linaro.org>
Date:   Thu, 13 Jul 2023 23:03:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] drm/msm: Fix hw_fence error path cleanup
Content-Language: en-GB
To:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
References: <20230712222523.7404-1-robdclark@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230712222523.7404-1-robdclark@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/07/2023 01:25, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> In an error path where the submit is free'd without the job being run,
> the hw_fence pointer is simply a kzalloc'd block of memory.  In this
> case we should just kfree() it, rather than trying to decrement it's
> reference count.  Fortunately we can tell that this is the case by
> checking for a zero refcount, since if the job was run, the submit would
> be holding a reference to the hw_fence.
> 
> Fixes: f94e6a51e17c ("drm/msm: Pre-allocate hw_fence")
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>   drivers/gpu/drm/msm/msm_fence.c      |  6 ++++++
>   drivers/gpu/drm/msm/msm_gem_submit.c | 14 +++++++++++++-
>   2 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/msm_fence.c b/drivers/gpu/drm/msm/msm_fence.c
> index 96599ec3eb78..1a5d4f1c8b42 100644
> --- a/drivers/gpu/drm/msm/msm_fence.c
> +++ b/drivers/gpu/drm/msm/msm_fence.c
> @@ -191,6 +191,12 @@ msm_fence_init(struct dma_fence *fence, struct msm_fence_context *fctx)
>   
>   	f->fctx = fctx;
>   
> +	/*
> +	 * Until this point, the fence was just some pre-allocated memory,
> +	 * no-one should have taken a reference to it yet.
> +	 */
> +	WARN_ON(kref_read(&fence->refcount));

It this really correct to return a refcounted object with 0 refcount 
(I'm looking at submit_create() / msm_fence_alloc() )? Maybe it would be 
better to move dma_fence_get() to msm_fence_alloc() ? But don't 
immediately see, which one should be moved.

> +
>   	dma_fence_init(&f->base, &msm_fence_ops, &fctx->spinlock,
>   		       fctx->context, ++fctx->last_fence);
>   }
> diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
> index 3f1aa4de3b87..9d66498cdc04 100644
> --- a/drivers/gpu/drm/msm/msm_gem_submit.c
> +++ b/drivers/gpu/drm/msm/msm_gem_submit.c
> @@ -86,7 +86,19 @@ void __msm_gem_submit_destroy(struct kref *kref)
>   	}
>   
>   	dma_fence_put(submit->user_fence);
> -	dma_fence_put(submit->hw_fence);
> +
> +	/*
> +	 * If the submit is freed before msm_job_run(), then hw_fence is
> +	 * just some pre-allocated memory, not a reference counted fence.
> +	 * Once the job runs and the hw_fence is initialized, it will
> +	 * have a refcount of at least one, since the submit holds a ref
> +	 * to the hw_fence.
> +	 */
> +	if (kref_read(&submit->hw_fence->refcount) == 0) {
> +		kfree(submit->hw_fence);
> +	} else {
> +		dma_fence_put(submit->hw_fence);
> +	}
>   
>   	put_pid(submit->pid);
>   	msm_submitqueue_put(submit->queue);

-- 
With best wishes
Dmitry

