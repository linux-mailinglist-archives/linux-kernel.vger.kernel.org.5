Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC5E6765EEE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 00:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbjG0WIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 18:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjG0WIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 18:08:12 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112A42727
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 15:08:11 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d1c988afebfso1361275276.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 15:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690495690; x=1691100490;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+2IjmivRCtMcrXslDZzF29Xyje6HiUV9PZE6DYj4MOo=;
        b=Ddqs+tEIFAQmWVgSpA2HO3JhjyPBrXmx7P1l3G5yhqPIMAPS+HCploEk4tcywGOlRy
         wuki/er+3CGUVIVAbx7jGuHAVnTgZVOb+wwaXTnJ1L3x4CuyEpm6Kbo8fDjQTWFLQ+mc
         rGaEje8CHlpREzXqqRifE0190bCEslzyBKrgMW5J027DvFvgic2nQ7cIykmu743yqAvx
         ASJIWm0LW/TYOhoOUZ2HwDRVNtPWO6GZCbAhAHOwiu4adzptkFfFAasw4tHotjyZw+Hy
         O/qe8FBnbgGWWd184VtsPxnsXq1lRJHjK+ZifNRBbDjUJ+hkght6QTPmEDcdAmLBLoYL
         Og2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690495690; x=1691100490;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+2IjmivRCtMcrXslDZzF29Xyje6HiUV9PZE6DYj4MOo=;
        b=N/RBM7AQVbZ8M5Qz0j0aovlhwTOQE2+UZnxkTwmFbwrrL5HpGTpBf3r0a/I7pnKntV
         uWayzGpGkpJfFHtRETz2WLpqs7lpAzgcalgP8NOixbBjH0d/Bm+U92n0FuRT9QR1HLa3
         nKyCjqWk6KhN3zkAFJ6E2Ir9s8YNKovwOyQxPagGOBIJ9xIIbgX7wWq7RhkWHEpRSftM
         tIHs7S8c+RJ32OwpwJewD2cJ71vz/I7vw6Yt0GC1pQSyuaZqhpdKpdrYZDa6TIqj6P5r
         GsMZGo3ofQBE/6GCFNRgt8eJWHK+tk/qG/8f5hxSIYkyWdBrnZ6k6X28+87RfJPWj+Wh
         4c5Q==
X-Gm-Message-State: ABy/qLYM8mMsKeMbzoVe4dgridjdV9WfTwVOps/rCVBIlwfejaJ4PMu6
        uiuwesd4T++jy1XudCbHAGT6XYeEfjT1sobn3nLe4A==
X-Google-Smtp-Source: APBJJlHBIIMAJ/ccI1kOpZr6XWoU3xgPN3WOGa37WESD3rOsm3Xd5njhAWAX6+cWBM02TW1GnKNEVDRVqpaJGYQFGpg=
X-Received: by 2002:a25:d1d3:0:b0:ce7:ee46:debd with SMTP id
 i202-20020a25d1d3000000b00ce7ee46debdmr629930ybg.16.1690495690152; Thu, 27
 Jul 2023 15:08:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230727212208.102501-1-robdclark@gmail.com> <20230727212208.102501-3-robdclark@gmail.com>
In-Reply-To: <20230727212208.102501-3-robdclark@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 28 Jul 2023 01:07:59 +0300
Message-ID: <CAA8EJprScB_Nv_Qwt6t8WZW4a8-qNphUPqTuVX4YRXowaWdoiQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/13] drm/msm/adreno: Remove redundant gmem size param
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Adam Skladowski <a39.skl@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jul 2023 at 00:22, Rob Clark <robdclark@gmail.com> wrote:
>
> From: Rob Clark <robdclark@chromium.org>
>
> Even in the ocmem case, the allocated ocmem buffer size should match the
> requested size.
>
> v2: Move stray hunk to previous patch, make OCMEM size mismatch an error
>     condition.
>
> Signed-off-by: Rob Clark <robdclark@chromium.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>  drivers/gpu/drm/msm/adreno/a2xx_gpu.c   | 2 +-
>  drivers/gpu/drm/msm/adreno/a5xx_gpu.c   | 2 +-
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c   | 2 +-
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c | 9 +++++----
>  drivers/gpu/drm/msm/adreno/adreno_gpu.h | 1 -
>  5 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/adreno/a2xx_gpu.c b/drivers/gpu/drm/msm/adreno/a2xx_gpu.c
> index c67089a7ebc1..50ee03bc94b4 100644
> --- a/drivers/gpu/drm/msm/adreno/a2xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a2xx_gpu.c
> @@ -205,7 +205,7 @@ static int a2xx_hw_init(struct msm_gpu *gpu)
>                 A2XX_MH_INTERRUPT_MASK_MMU_PAGE_FAULT);
>
>         for (i = 3; i <= 5; i++)
> -               if ((SZ_16K << i) == adreno_gpu->gmem)
> +               if ((SZ_16K << i) == adreno_gpu->info->gmem)
>                         break;
>         gpu_write(gpu, REG_A2XX_RB_EDRAM_INFO, i);
>
> diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> index a99310b68793..f0803e94ebe5 100644
> --- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> @@ -749,7 +749,7 @@ static int a5xx_hw_init(struct msm_gpu *gpu)
>         gpu_write(gpu, REG_A5XX_UCHE_GMEM_RANGE_MIN_LO, 0x00100000);
>         gpu_write(gpu, REG_A5XX_UCHE_GMEM_RANGE_MIN_HI, 0x00000000);
>         gpu_write(gpu, REG_A5XX_UCHE_GMEM_RANGE_MAX_LO,
> -               0x00100000 + adreno_gpu->gmem - 1);
> +               0x00100000 + adreno_gpu->info->gmem - 1);
>         gpu_write(gpu, REG_A5XX_UCHE_GMEM_RANGE_MAX_HI, 0x00000000);
>
>         if (adreno_is_a506(adreno_gpu) || adreno_is_a508(adreno_gpu) ||
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> index b3ada1e7b598..edbade75020f 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -1270,7 +1270,7 @@ static int hw_init(struct msm_gpu *gpu)
>                 gpu_write64(gpu, REG_A6XX_UCHE_GMEM_RANGE_MIN, 0x00100000);
>
>                 gpu_write64(gpu, REG_A6XX_UCHE_GMEM_RANGE_MAX,
> -                       0x00100000 + adreno_gpu->gmem - 1);
> +                       0x00100000 + adreno_gpu->info->gmem - 1);
>         }
>
>         gpu_write(gpu, REG_A6XX_UCHE_FILTER_CNTL, 0x804);
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> index e3cd9ff6ff1d..ef98d51d237f 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> @@ -320,7 +320,7 @@ int adreno_get_param(struct msm_gpu *gpu, struct msm_file_private *ctx,
>                 *value = adreno_gpu->info->revn;
>                 return 0;
>         case MSM_PARAM_GMEM_SIZE:
> -               *value = adreno_gpu->gmem;
> +               *value = adreno_gpu->info->gmem;
>                 return 0;
>         case MSM_PARAM_GMEM_BASE:
>                 *value = !adreno_is_a650_family(adreno_gpu) ? 0x100000 : 0;
> @@ -1041,14 +1041,16 @@ int adreno_gpu_ocmem_init(struct device *dev, struct adreno_gpu *adreno_gpu,
>                 return PTR_ERR(ocmem);
>         }
>
> -       ocmem_hdl = ocmem_allocate(ocmem, OCMEM_GRAPHICS, adreno_gpu->gmem);
> +       ocmem_hdl = ocmem_allocate(ocmem, OCMEM_GRAPHICS, adreno_gpu->info->gmem);
>         if (IS_ERR(ocmem_hdl))
>                 return PTR_ERR(ocmem_hdl);
>
>         adreno_ocmem->ocmem = ocmem;
>         adreno_ocmem->base = ocmem_hdl->addr;
>         adreno_ocmem->hdl = ocmem_hdl;
> -       adreno_gpu->gmem = ocmem_hdl->len;
> +
> +       if (WARN_ON(ocmem_hdl->len != adreno_gpu->info->gmem))
> +               return -ENOMEM;
>
>         return 0;
>  }
> @@ -1097,7 +1099,6 @@ int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
>
>         adreno_gpu->funcs = funcs;
>         adreno_gpu->info = adreno_info(config->rev);
> -       adreno_gpu->gmem = adreno_gpu->info->gmem;
>         adreno_gpu->revn = adreno_gpu->info->revn;
>         adreno_gpu->rev = *rev;
>
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> index 6830c3776c2d..aaf09c642dc6 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> @@ -77,7 +77,6 @@ struct adreno_gpu {
>         struct msm_gpu base;
>         struct adreno_rev rev;
>         const struct adreno_info *info;
> -       uint32_t gmem;  /* actual gmem size */
>         uint32_t revn;  /* numeric revision name */
>         uint16_t speedbin;
>         const struct adreno_gpu_funcs *funcs;
> --
> 2.41.0
>


-- 
With best wishes
Dmitry
