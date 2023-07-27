Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDE9765EFF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 00:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232574AbjG0WMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 18:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjG0WMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 18:12:16 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8CC32723
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 15:12:14 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-c5ffb6cda23so1441553276.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 15:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690495934; x=1691100734;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nyxlgbjWQI1FZk1odjU2qQ7ZGnhrJ/VcGeGlZKp3H0I=;
        b=Swl9iYEGSVZamrk5OReiH1RxqPdckbGLPIO15Ypr/QKEBugavTEhJ6CaOGCrem+xs3
         ooNpMkr5P1fPdRcP8A0cbG2C+9IlcgRIKqDT+gG+PYDOFZusZxj91isKXu9lLz0SBbE+
         TQQrt9HjT8RQC6m3tDScfy4Io8zFctswGd2w8JbDtfIgt4a7lbW2+jjxTBljl4UkmDmJ
         460HTUuovd9Z39qUt5n+7ZYGqp4oPAm6D6oVbqOMt6Jzvs3NY1uY+kVGLnWaIx/n6bVR
         E/vzS7zmqvP9EmnWsXoA+iwsRtG4hbw5XdNoJMZapDICLmIQeOucq5q3O+elxDp8zgOB
         IU6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690495934; x=1691100734;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nyxlgbjWQI1FZk1odjU2qQ7ZGnhrJ/VcGeGlZKp3H0I=;
        b=HPol9fuH3+04GkX0xEyPsGO+VJTKuMJx/zO0Qjdg6B7RjGf5MlDJcZI3WQirDOUyGv
         AKgHiCDdwdas0qsmXNM9droFgaesdqbmSJWjnyPOrrQr6XNiDpt4zimlwcnwJLOGHzbd
         5F0052u6/ZA4BULlOv3kFReGHC1yn3RFHhrasv9gvgS2gpZK+CTQ14dxz3sMQSfQWHxq
         zw2e/T7oNhWLejqH6uSqm0IFQZn4FymM7Q0utcLNRRSzzQN2y7CxlVby25Chk7gQHfi9
         AUxP3FsQmlFx81vR7MmzGKAZoUHLy5O/zZqYwXOEHLZ4Ah4FlqMaCpiQe93zGfy2aA2f
         +K8Q==
X-Gm-Message-State: ABy/qLbsKCugvMgB4tDBuuNXE3nD57xADaOI6RXu5M2xQ30q7RjlodB0
        t2vrjnlC1A66gwTcQ3oNAGsRJ6Yn3Yhmr7u0GEHQcg==
X-Google-Smtp-Source: APBJJlFJHyxgfqGptThS/aAKO4OBdDuZHzhrrj5yHfxOg5ECYPOGLOrvCrl8Vh6oiMCYOSLs8WffJdIN9Fe3sbxSCcM=
X-Received: by 2002:a25:5c8:0:b0:d15:d97f:89f8 with SMTP id
 191-20020a2505c8000000b00d15d97f89f8mr635148ybf.62.1690495933853; Thu, 27 Jul
 2023 15:12:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230727212208.102501-1-robdclark@gmail.com> <20230727212208.102501-7-robdclark@gmail.com>
In-Reply-To: <20230727212208.102501-7-robdclark@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 28 Jul 2023 01:12:02 +0300
Message-ID: <CAA8EJposUxVoqApJwx0g5D_6Zw0DOs=OVmYwoUNXWYue7w2PQg@mail.gmail.com>
Subject: Re: [PATCH v2 06/13] drm/msm/adreno: Allow SoC specific gpu device
 table entries
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
        Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jul 2023 at 00:23, Rob Clark <robdclark@gmail.com> wrote:
>
> From: Rob Clark <robdclark@chromium.org>
>
> There are cases where there are differences due to SoC integration.
> Such as cache-coherency support, and (in the next patch) e-fuse to
> speedbin mappings.
>
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/gpu/drm/msm/adreno/adreno_device.c | 34 +++++++++++++++++++---
>  drivers/gpu/drm/msm/adreno/adreno_gpu.h    |  1 +
>  2 files changed, 31 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
> index 3c531da417b9..e62bc895a31f 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_device.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
> @@ -258,6 +258,32 @@ static const struct adreno_info gpulist[] = {
>                 .inactive_period = DRM_MSM_INACTIVE_PERIOD,
>                 .quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT,
>                 .init = a6xx_gpu_init,
> +       }, {
> +               .machine = "qcom,sm4350",
> +               .rev = ADRENO_REV(6, 1, 9, ANY_ID),
> +               .revn = 619,
> +               .fw = {
> +                       [ADRENO_FW_SQE] = "a630_sqe.fw",
> +                       [ADRENO_FW_GMU] = "a619_gmu.bin",

If those are GMU-less platforms, do we need the ADRENO_FW_GMU firmware?

Other than that:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> +               },
> +               .gmem = SZ_512K,
> +               .inactive_period = DRM_MSM_INACTIVE_PERIOD,
> +               .init = a6xx_gpu_init,
> +               .zapfw = "a615_zap.mdt",
> +               .hwcg = a615_hwcg,
> +       }, {
> +               .machine = "qcom,sm6375",
> +               .rev = ADRENO_REV(6, 1, 9, ANY_ID),
> +               .revn = 619,
> +               .fw = {
> +                       [ADRENO_FW_SQE] = "a630_sqe.fw",
> +                       [ADRENO_FW_GMU] = "a619_gmu.bin",
> +               },
> +               .gmem = SZ_512K,
> +               .inactive_period = DRM_MSM_INACTIVE_PERIOD,
> +               .init = a6xx_gpu_init,
> +               .zapfw = "a615_zap.mdt",
> +               .hwcg = a615_hwcg,
>         }, {
>                 .rev = ADRENO_REV(6, 1, 9, ANY_ID),
>                 .revn = 619,
> @@ -409,6 +435,8 @@ const struct adreno_info *adreno_info(struct adreno_rev rev)
>         /* identify gpu: */
>         for (i = 0; i < ARRAY_SIZE(gpulist); i++) {
>                 const struct adreno_info *info = &gpulist[i];
> +               if (info->machine && !of_machine_is_compatible(info->machine))
> +                       continue;
>                 if (adreno_cmp_rev(info->rev, rev))
>                         return info;
>         }
> @@ -563,6 +591,8 @@ static int adreno_bind(struct device *dev, struct device *master, void *data)
>                 config.rev.minor, config.rev.patchid);
>
>         priv->is_a2xx = config.rev.core == 2;
> +       priv->has_cached_coherent =
> +               !!(info->quirks & ADRENO_QUIRK_HAS_CACHED_COHERENT);
>
>         gpu = info->init(drm);
>         if (IS_ERR(gpu)) {
> @@ -574,10 +604,6 @@ static int adreno_bind(struct device *dev, struct device *master, void *data)
>         if (ret)
>                 return ret;
>
> -       priv->has_cached_coherent =
> -               !!(info->quirks & ADRENO_QUIRK_HAS_CACHED_COHERENT) &&
> -               !adreno_has_gmu_wrapper(to_adreno_gpu(gpu));
> -
>         return 0;
>  }
>
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> index e08d41337169..d5335b99c64c 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> @@ -61,6 +61,7 @@ extern const struct adreno_reglist a612_hwcg[], a615_hwcg[], a630_hwcg[], a640_h
>  extern const struct adreno_reglist a660_hwcg[], a690_hwcg[];
>
>  struct adreno_info {
> +       const char *machine;
>         struct adreno_rev rev;
>         uint32_t revn;
>         const char *fw[ADRENO_FW_MAX];
> --
> 2.41.0
>


-- 
With best wishes
Dmitry
