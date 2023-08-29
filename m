Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CFD278C063
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 10:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234197AbjH2IiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 04:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234223AbjH2Ihn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 04:37:43 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A5BBC
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 01:37:41 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-401ceda85cdso12528265e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 01:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693298260; x=1693903060;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cut4aK4TgUvLV15+68ROwMjaB5Yg1rV735PWdbICfq4=;
        b=Ss9XmdjSHGSWXbfGN6XXZ2auywX8w3BBj2MEhO2DxnDgT3PrK3BomrQcupH4UDday0
         aszKP2wH3U4Ibps3u8c7Y53k/ivqNu7dqJv+HLhUn3CPzRtkHas9fxgceIvmSy2wvVA6
         uuIZeCFJkbKrgaphzxt7ChA82IVUMRgLj6lDj7CFV6Gfyrk7WubveK6ilrtLMBieVNUi
         YsVidBkbyX1ZB4fzMFWHxONFLPuLNpNKCz7SshCOb0MyLdgXjz+OOAik2E+kmHpXyKBp
         w2lMDeN+4UOZgwNgyknVpX9kwhusnFvMdMLEQy8wmgeD6aDyOrobFpxMHL5dnjFpOAD8
         JM9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693298260; x=1693903060;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cut4aK4TgUvLV15+68ROwMjaB5Yg1rV735PWdbICfq4=;
        b=ZXztzT+dFFXGYJcwwNVsLmWbQDp4/KEkUyI8hO6+e3bBFkFJq1MRwh+70H13T3EvMj
         8Pt4xDLVWYhvCTZ60usNWlv/zXv522jt+V4OuJuB9jqwBHLFFRpE61W7Y09tYnU8lZFK
         rhFUhSwnM3X12ApSdnGvS4Iu6nY5GB9rGeCpzWVtuFuO6f8C+dFAB93R+/5V3S32Rg6Q
         8mlUnHzcp0fsj3DGZFMxbgtNJ3G0qaBl2iUKzHgUKiFAlB/jX9xLJiQ/W7gTgYyc7BX2
         51DO0tqHwzJgfnFlXCEprmP84cDXQsDleFDNg8sk2q2UrrVkU51deJz78MEV4zhsgB2h
         wgnA==
X-Gm-Message-State: AOJu0Yx0HFLgu/yFUBCEVzzFuSNebh3rjLY2EqzOUkcXzVW9mew76sOv
        fRaPWldOKaJnSqcWfYRt0A4=
X-Google-Smtp-Source: AGHT+IE9Wt12V3aa7ICOVESN9tE4eauLif2gw6JJmTNt6LZ0qFECjLJxMsVWL/MtMyLc+WFrh/aDvw==
X-Received: by 2002:a05:600c:b42:b0:3fe:1871:1826 with SMTP id k2-20020a05600c0b4200b003fe18711826mr21209154wmr.27.1693298259387;
        Tue, 29 Aug 2023 01:37:39 -0700 (PDT)
Received: from [10.254.108.106] (munvpn.amd.com. [165.204.72.6])
        by smtp.gmail.com with ESMTPSA id 21-20020a05600c231500b003fc0505be19sm13180441wmo.37.2023.08.29.01.37.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 01:37:38 -0700 (PDT)
Message-ID: <0ced6c19-68fd-42cb-3709-5bb551cf8d1f@gmail.com>
Date:   Tue, 29 Aug 2023 10:37:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 5/7] drm/amdgpu: Set/Reset GPU workload profile
To:     Arvind Yadav <Arvind.Yadav@amd.com>, Christian.Koenig@amd.com,
        alexander.deucher@amd.com, shashank.sharma@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        Felix.Kuehling@amd.com, amd-gfx@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20230828122614.3815122-1-Arvind.Yadav@amd.com>
 <20230828122614.3815122-6-Arvind.Yadav@amd.com>
Content-Language: en-US
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230828122614.3815122-6-Arvind.Yadav@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 28.08.23 um 14:26 schrieb Arvind Yadav:
> This patch is to switch the GPU workload profile based
> on the submitted job. The workload profile is reset to
> default when the job is done.
>
> v3:
> - Addressed the review comment about changing the function
>    name from *_set() to *_get().

That looks like a really bad idea in general. This are the high level 
functions, but what you want to use are the low level functions for each 
ring.

Take a look at amdgpu_ring_begin_use()/_end_use() instead.

Christian.

>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Reviewed-by: Shashank Sharma <shashank.sharma@amd.com>
> Signed-off-by: Arvind Yadav <Arvind.Yadav@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index c3d9d75143f4..c5032762d497 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -176,6 +176,9 @@ void amdgpu_job_free_resources(struct amdgpu_job *job)
>   static void amdgpu_job_free_cb(struct drm_sched_job *s_job)
>   {
>   	struct amdgpu_job *job = to_amdgpu_job(s_job);
> +	struct amdgpu_ring *ring = to_amdgpu_ring(s_job->sched);
> +
> +	amdgpu_workload_profile_put(ring->adev, ring->funcs->type);
>   
>   	drm_sched_job_cleanup(s_job);
>   
> @@ -295,6 +298,8 @@ static struct dma_fence *amdgpu_job_run(struct drm_sched_job *sched_job)
>   			DRM_ERROR("Error scheduling IBs (%d)\n", r);
>   	}
>   
> +	amdgpu_workload_profile_get(adev, ring->funcs->type);
> +
>   	job->job_run_counter++;
>   	amdgpu_job_free_resources(job);
>   

