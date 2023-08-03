Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB07576E347
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 10:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234755AbjHCIhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 04:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234709AbjHCIg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 04:36:29 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11366173F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 01:35:20 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-99bded9d93dso17904466b.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 01:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1691051718; x=1691656518;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+nym283wLVf/ofUyIRllrpdMxMhpWulj6DQA5tLBOCs=;
        b=U1btXfNHgkSw67b9y5Ateu4cMgn1vtw7k2bxBzgT7E5JMW/kySvRli/gC4fFOoE4VC
         Vi8SFXnpnCvX2xKUxS1X/aT0Ijy1YGR7akJjwAcRrcbmDkSDi+wEtHV0ftZ8qS6MjqGA
         zvXfos5vDZDGf+RhpEj29P+Y4/lCsFQ+98jdI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691051718; x=1691656518;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+nym283wLVf/ofUyIRllrpdMxMhpWulj6DQA5tLBOCs=;
        b=NvZFpmasfxf/vrc2UfgrcB+ZPj/NSR04AjuL0zWrxqovzvXPpwuCjDfHlriK7S3TqD
         73jQfDw7Ozr8fogVqilUInpMQ/H26+s4xRd2pM2XMOFKFRcEhdqzZd4SshuZNtnC2vMh
         KRQDBmXvOQPMFXGuWAF2XilLVeswzMBy+dCJDJMtFBxPAr5RAh+GLRgCaB0beWE4+siq
         MAEp9Sq/8fq5MXI8VKubEowBdLl1r+tWP85YTME6NTHHgaMmX09uIjWXeQFfWZ4Hz9t1
         oDj7QQB7GVkk/nNsbpCnJ6wHp/qWbpIPdGWJuuy5o5uL4RRpf8QFY/i/XzpfJFTi4ltx
         7tlA==
X-Gm-Message-State: ABy/qLb7uQ2Mk77XD5RPv4IDiZGhzuc0bGdMrDevn0LsHPloSpIYxK5Y
        psYrks5+DgXUqI1CN5g7Hilphg==
X-Google-Smtp-Source: APBJJlHR5HZIx8b6Bh12zKXRTxSAfFBj8gJM1k630umLgblmMmLiGD1pmEbvvLNQvVT3Eye0kTiaOQ==
X-Received: by 2002:a17:906:5303:b0:99b:4670:aca9 with SMTP id h3-20020a170906530300b0099b4670aca9mr11386895ejo.1.1691051718456;
        Thu, 03 Aug 2023 01:35:18 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id a18-20020a1709065f9200b0099c53c44083sm1218165eju.79.2023.08.03.01.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 01:35:17 -0700 (PDT)
Date:   Thu, 3 Aug 2023 10:35:15 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] drm/msm: Disallow relocs on a6xx+
Message-ID: <ZMtmw8pzLXy/ndCw@phenom.ffwll.local>
Mail-Followup-To: Rob Clark <robdclark@gmail.com>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20230802221047.9944-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802221047.9944-1-robdclark@gmail.com>
X-Operating-System: Linux phenom 6.3.0-2-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2023 at 03:10:44PM -0700, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> Mesa stopped using these pretty early in a6xx bringup.  Take advantage
> of this to disallow some legacy UABI.
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
> So, it was late 2018 when mesa stopped using relocs.  At that point a6xx
> support was still in a pretty early state.  I guess you _could_ use such
> an old version of mesa with a6xx hw.. but you really shouldn't.

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Might be good to cite the mesa commit that removed the a6xx reloc code in
the commit message.
-Sima

> 
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c |  2 ++
>  drivers/gpu/drm/msm/msm_gem_submit.c    | 10 ++++++++++
>  drivers/gpu/drm/msm/msm_gpu.h           |  9 +++++++++
>  3 files changed, 21 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> index ba35c2a87021..695cce82d914 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> @@ -1078,6 +1078,8 @@ int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
>  	adreno_gpu->info = config->info;
>  	adreno_gpu->chip_id = config->chip_id;
>  
> +	gpu->allow_relocs = config->info->family < ADRENO_6XX_GEN1;
> +
>  	/* Only handle the core clock when GMU is not in use (or is absent). */
>  	if (adreno_has_gmu_wrapper(adreno_gpu) ||
>  	    adreno_gpu->info->family < ADRENO_6XX_GEN1) {
> diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
> index 63c96416e183..3b908f9f5493 100644
> --- a/drivers/gpu/drm/msm/msm_gem_submit.c
> +++ b/drivers/gpu/drm/msm/msm_gem_submit.c
> @@ -882,6 +882,16 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
>  		if (submit->valid)
>  			continue;
>  
> +		if (!gpu->allow_relocs) {
> +			if (submit->cmd[i].nr_relocs) {
> +				DRM_ERROR("relocs not allowed\n");
> +				ret = -EINVAL;
> +				goto out;
> +			}
> +
> +			continue;
> +		}
> +
>  		ret = submit_reloc(submit, msm_obj, submit->cmd[i].offset * 4,
>  				submit->cmd[i].nr_relocs, submit->cmd[i].relocs);
>  		if (ret)
> diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
> index 7a4fa1b8655b..4252e3839fbc 100644
> --- a/drivers/gpu/drm/msm/msm_gpu.h
> +++ b/drivers/gpu/drm/msm/msm_gpu.h
> @@ -285,6 +285,15 @@ struct msm_gpu {
>  	/* True if the hardware supports expanded apriv (a650 and newer) */
>  	bool hw_apriv;
>  
> +	/**
> +	 * @allow_relocs: allow relocs in SUBMIT ioctl
> +	 *
> +	 * Mesa won't use relocs for driver version 1.4.0 and later.  This
> +	 * switch-over happened early enough in mesa a6xx bringup that we
> +	 * can disallow relocs for a6xx and newer.
> +	 */
> +	bool allow_relocs;
> +
>  	struct thermal_cooling_device *cooling;
>  };
>  
> -- 
> 2.41.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
