Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3D5080C710
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 11:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234447AbjLKKrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 05:47:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234452AbjLKKrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 05:47:05 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7FBA9;
        Mon, 11 Dec 2023 02:47:11 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-336210c34ebso852256f8f.1;
        Mon, 11 Dec 2023 02:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702291630; x=1702896430; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ce0zbxA04eGm5L5oadZ3wbq0BpUtWOBHwT553G24fMY=;
        b=m0MgJvP/1MFI7x77buBlfctY0/RzYMLilDEMElwG+4B5cvBnJ0jet+pjpRwGuv+kIO
         L6u//eZ7VwXUphq+f5RU/i4DYHAks0E49jbkK2UlpWiZCCBlJYvRzIsgax7kZIaMnbDg
         ccLErGVG2n6VsuINibBxBWzK7kQvbeegCOywzR37/ffQLzDoQ8TE37hMssFc3WnVLGdd
         4A7gIkGIo/p8C7nApEDIQfn8bK76imvOLlmuMzQvtC++/x5uWmO0UmykV9Ilhu6dulUr
         8sEkheAzwtcrUKsRxKU1+1eF0R4EKNN5EEvxTGdfmrTri5O5XnRcwKbj57qBT+3a8z+b
         yzYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702291630; x=1702896430;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ce0zbxA04eGm5L5oadZ3wbq0BpUtWOBHwT553G24fMY=;
        b=cbP2QW8C2nRhI5/x4AK+F4mRnMj8TDMu0eSBXc5LRM4P5uvLUPBlHbEn4QJwqNdIn5
         cvf0sPrdmEVUq8qAdy/06KwTmsXtURvhWqjmXdU4j3j5cDpTp2kRMuMsxQKrsVpefR6E
         WeBt3F1hOQ9KBIIN8BGHvJfXkj7Vgrv0PK+pfnaGK/WWe7FLeghxR/dGzZYWyG6HQTs4
         c8we1ul2OMHQsOahS0ucGPD0E6Ss8XmmYQ277tVV8jEK2Jnlv/Y+hqEfbzS/rwdTLHmA
         bgZ9R4SfYXM16s/fpyvynAsfSWzCwsA+VzhDicTDwTkHe6xB0X6YInPudiibyYCWrwSk
         22CA==
X-Gm-Message-State: AOJu0YwXt0GmYW72BXuhKgNAvK2K9FXvQd3zoIorIbxawZVlUrmqmRN0
        jaTk+zFuMEurmBMOT0jpi+c=
X-Google-Smtp-Source: AGHT+IFDLSWtwRz+Mep0P2wHU03mEf8uT1tA4CK01mVy2soy6G7lwo395lYfptDQ0/ItbXxPbv0GHA==
X-Received: by 2002:a05:600c:4195:b0:40c:243f:c36a with SMTP id p21-20020a05600c419500b0040c243fc36amr1555228wmh.206.1702291629926;
        Mon, 11 Dec 2023 02:47:09 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
        by smtp.gmail.com with ESMTPSA id q14-20020a05600c46ce00b0040c4c9c52a3sm888618wmo.12.2023.12.11.02.47.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Dec 2023 02:47:09 -0800 (PST)
Message-ID: <9637309c-af25-4117-be4f-b8cbdc087d60@gmail.com>
Date:   Mon, 11 Dec 2023 11:47:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Linaro-mm-sig] [PATCH] drm/scheduler: Unwrap job dependencies
Content-Language: en-US
To:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Rob Clark <robdclark@chromium.org>,
        Luben Tuikov <ltuikov89@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK:Keyword:bdma_?:buf|fence|resvb" 
        <linux-media@vger.kernel.org>,
        "moderated list:DMA BUFFER SHARING
        FRAMEWORK:Keyword:bdma_?:buf|fence|resvb" 
        <linaro-mm-sig@lists.linaro.org>
References: <20231205190234.371322-1-robdclark@gmail.com>
From:   =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20231205190234.371322-1-robdclark@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 05.12.23 um 20:02 schrieb Rob Clark:
> From: Rob Clark <robdclark@chromium.org>
>
> Container fences have burner contexts, which makes the trick to store at
> most one fence per context somewhat useless if we don't unwrap array or
> chain fences.
>
> Signed-off-by: Rob Clark <robdclark@chromium.org>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/scheduler/sched_main.c | 47 ++++++++++++++++++--------
>   1 file changed, 32 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
> index 9762464e3f99..16b550949c57 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -52,6 +52,7 @@
>   #include <linux/wait.h>
>   #include <linux/sched.h>
>   #include <linux/completion.h>
> +#include <linux/dma-fence-unwrap.h>
>   #include <linux/dma-resv.h>
>   #include <uapi/linux/sched/types.h>
>   
> @@ -684,27 +685,14 @@ void drm_sched_job_arm(struct drm_sched_job *job)
>   }
>   EXPORT_SYMBOL(drm_sched_job_arm);
>   
> -/**
> - * drm_sched_job_add_dependency - adds the fence as a job dependency
> - * @job: scheduler job to add the dependencies to
> - * @fence: the dma_fence to add to the list of dependencies.
> - *
> - * Note that @fence is consumed in both the success and error cases.
> - *
> - * Returns:
> - * 0 on success, or an error on failing to expand the array.
> - */
> -int drm_sched_job_add_dependency(struct drm_sched_job *job,
> -				 struct dma_fence *fence)
> +static int drm_sched_job_add_single_dependency(struct drm_sched_job *job,
> +					       struct dma_fence *fence)
>   {
>   	struct dma_fence *entry;
>   	unsigned long index;
>   	u32 id = 0;
>   	int ret;
>   
> -	if (!fence)
> -		return 0;
> -
>   	/* Deduplicate if we already depend on a fence from the same context.
>   	 * This lets the size of the array of deps scale with the number of
>   	 * engines involved, rather than the number of BOs.
> @@ -728,6 +716,35 @@ int drm_sched_job_add_dependency(struct drm_sched_job *job,
>   
>   	return ret;
>   }
> +
> +/**
> + * drm_sched_job_add_dependency - adds the fence as a job dependency
> + * @job: scheduler job to add the dependencies to
> + * @fence: the dma_fence to add to the list of dependencies.
> + *
> + * Note that @fence is consumed in both the success and error cases.
> + *
> + * Returns:
> + * 0 on success, or an error on failing to expand the array.
> + */
> +int drm_sched_job_add_dependency(struct drm_sched_job *job,
> +				 struct dma_fence *fence)
> +{
> +	struct dma_fence_unwrap iter;
> +	struct dma_fence *f;
> +	int ret = 0;
> +
> +	dma_fence_unwrap_for_each (f, &iter, fence) {
> +		dma_fence_get(f);
> +		ret = drm_sched_job_add_single_dependency(job, f);
> +		if (ret)
> +			break;
> +	}
> +
> +	dma_fence_put(fence);
> +
> +	return ret;
> +}
>   EXPORT_SYMBOL(drm_sched_job_add_dependency);
>   
>   /**

