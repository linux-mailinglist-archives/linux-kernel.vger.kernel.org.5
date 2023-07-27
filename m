Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A333765FEE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 00:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbjG0Wuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 18:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233039AbjG0Wua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 18:50:30 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7691FC9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 15:50:29 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-584388ec441so16734317b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 15:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690498228; x=1691103028;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IacxlEjz7I0pKANVMIoEfAvY9SNWx/TOEgfD76ScziE=;
        b=hTRIUAovwyusBAov6dP/PzlxQdpp53Dx8/9qF1r/Nbocte5YooJVA/yXssgaa6Zspx
         IqydTk2G8nj9CaIe0nWup+8mBFa/2Ge33I4TT4By4DikcwdpsHDVkevS1HqN3XPFdDvh
         Bz+SQU86HD3QMd4Gm5T0x7iUHfh4S2RzKdYlCzQAsEcGWr8e4alopWWZNZXqsWjxw4L7
         QjaBynrimhUKZHjGA46gfCgoZTIUevARZRpoa4qfMdLUWX/3WEIFqybipguKOlARnCy1
         oqO0IxeLf05qB/ZsThWkC42mPTV61TJVJVNg78D6Xb0RBJYiQC+PtC3cT3Xu2gM4GFAn
         coxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690498228; x=1691103028;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IacxlEjz7I0pKANVMIoEfAvY9SNWx/TOEgfD76ScziE=;
        b=TybmqXsqHrMKBSrD4te6xKs79lRu984GJBA6J0dRWgsqrw/UWe6zWJBIoD2H3HPo6/
         Lvo/hLtmb2h2Eree2kwX1UB4fpaJFzi2gvsVnhYWMKprdNcBj8JNg2mx3oD2+RHO0/0p
         x3l3o+0EMD9bU5Wxjs/nhqfeF/ImvxtRzWfuW876EUSMN4ohE5/F86Ob/KWhaM9ubPis
         5nuFngkP+h5+gmcQYnTW6i7XwP79DHaVa7xXQbh8mLwH48HVZN3PCb2yXhGlpcCkZH9K
         HZ+ISbej/z/FvSmjXqslawcY9mrAKb5LRYuGtZH3BC6vz24BAOCrLbbSdCiWyj3JVeHy
         J8VQ==
X-Gm-Message-State: ABy/qLZc2foUk22iP3n2UQ6gcXYt75Znx/keHXfRO/+MgySog8N4IJSv
        YkwqUW5hSxNt2xjY3JW5eObahm5SU/ZWhZumpWCLYA==
X-Google-Smtp-Source: APBJJlEiSr802YZ16rdHuXKHxTCkHUN85vRlxaGAzoACRRi7R+TLr1ZB+C5cOeKBxtuibFykQpiiqrAIl567cV846CM=
X-Received: by 2002:a0d:e647:0:b0:576:91e0:b8c5 with SMTP id
 p68-20020a0de647000000b0057691e0b8c5mr45212ywe.0.1690498228308; Thu, 27 Jul
 2023 15:50:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230727212208.102501-1-robdclark@gmail.com> <20230727212208.102501-12-robdclark@gmail.com>
In-Reply-To: <20230727212208.102501-12-robdclark@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 28 Jul 2023 01:50:17 +0300
Message-ID: <CAA8EJpoECsKVgat85LFyWaibOZ+O9t8GFBwxsFhOFf7GTf6DzQ@mail.gmail.com>
Subject: Re: [PATCH v2 11/13] drm/msm/adreno: Move adreno info to config
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
        Douglas Anderson <dianders@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Rob Herring <robh@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=no
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
> Let's just stash it in adreno_platform_config rather than looking it up
> in N different places.

This leaves me with the feeling that we are abusing the
dev->platform_data, but we were doing it anyway even before the patch.
So:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

>
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c      | 15 +++------------
>  drivers/gpu/drm/msm/adreno/adreno_device.c |  5 +++--
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c    |  2 +-
>  drivers/gpu/drm/msm/adreno/adreno_gpu.h    |  3 +--
>  4 files changed, 8 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> index a81a6459c656..9be3260c8033 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -2316,7 +2316,6 @@ struct msm_gpu *a6xx_gpu_init(struct drm_device *dev)
>         struct msm_drm_private *priv = dev->dev_private;
>         struct platform_device *pdev = priv->gpu_pdev;
>         struct adreno_platform_config *config = pdev->dev.platform_data;
> -       const struct adreno_info *info;
>         struct device_node *node;
>         struct a6xx_gpu *a6xx_gpu;
>         struct adreno_gpu *adreno_gpu;
> @@ -2341,20 +2340,12 @@ struct msm_gpu *a6xx_gpu_init(struct drm_device *dev)
>
>         adreno_gpu->gmu_is_wrapper = of_device_is_compatible(node, "qcom,adreno-gmu-wrapper");
>
> -       /*
> -        * We need to know the platform type before calling into adreno_gpu_init
> -        * so that the hw_apriv flag can be correctly set. Snoop into the info
> -        * and grab the revision number
> -        */
> -       info = adreno_info(config->rev);
> -       if (!info)
> -               return ERR_PTR(-EINVAL);
> -
> -       adreno_gpu->base.hw_apriv = !!(info->quirks & ADRENO_QUIRK_HAS_HW_APRIV);
> +       adreno_gpu->base.hw_apriv =
> +               !!(config->info->quirks & ADRENO_QUIRK_HAS_HW_APRIV);
>
>         a6xx_llc_slices_init(pdev, a6xx_gpu);
>
> -       ret = a6xx_set_supported_hw(&pdev->dev, info);
> +       ret = a6xx_set_supported_hw(&pdev->dev, config->info);
>         if (ret) {
>                 a6xx_destroy(&(a6xx_gpu->base.base));
>                 return ERR_PTR(ret);
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
> index 7448f299b77c..332cb804a45d 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_device.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
> @@ -508,7 +508,7 @@ bool adreno_cmp_rev(struct adreno_rev rev1, struct adreno_rev rev2)
>                 _rev_match(rev1.patchid, rev2.patchid);
>  }
>
> -const struct adreno_info *adreno_info(struct adreno_rev rev)
> +static const struct adreno_info *adreno_info(struct adreno_rev rev)
>  {
>         int i;
>
> @@ -659,13 +659,14 @@ static int adreno_bind(struct device *dev, struct device *master, void *data)
>         priv->gpu_pdev = to_platform_device(dev);
>
>         info = adreno_info(config.rev);
> -
>         if (!info) {
>                 dev_warn(drm->dev, "Unknown GPU revision: %"ADRENO_CHIPID_FMT"\n",
>                         ADRENO_CHIPID_ARGS(config.rev));
>                 return -ENXIO;
>         }
>
> +       config.info = info;
> +
>         DBG("Found GPU: %"ADRENO_CHIPID_FMT, ADRENO_CHIPID_ARGS(config.rev));
>
>         priv->is_a2xx = info->family < ADRENO_3XX;
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> index a775b4d82735..865ff4c1eaf6 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> @@ -1079,7 +1079,7 @@ int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
>         int ret;
>
>         adreno_gpu->funcs = funcs;
> -       adreno_gpu->info = adreno_info(config->rev);
> +       adreno_gpu->info = config->info;
>         adreno_gpu->rev = *rev;
>
>         /* Only handle the core clock when GMU is not in use (or is absent). */
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> index c6fd6f9016d3..81a1396e124d 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> @@ -130,8 +130,6 @@ struct adreno_info {
>   */
>  #define ADRENO_SPEEDBINS(tbl...) (struct adreno_speedbin[]) { tbl {SHRT_MAX, 0} }
>
> -const struct adreno_info *adreno_info(struct adreno_rev rev);
> -
>  struct adreno_gpu {
>         struct msm_gpu base;
>         struct adreno_rev rev;
> @@ -185,6 +183,7 @@ struct adreno_ocmem {
>  /* platform config data (ie. from DT, or pdata) */
>  struct adreno_platform_config {
>         struct adreno_rev rev;
> +       const struct adreno_info *info;
>  };
>
>  #define ADRENO_IDLE_TIMEOUT msecs_to_jiffies(1000)
> --
> 2.41.0
>


-- 
With best wishes
Dmitry
