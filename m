Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16D50765F24
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 00:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbjG0WPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 18:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232802AbjG0WPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 18:15:51 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7DB187
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 15:15:50 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-d05a63946e0so1381316276.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 15:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690496149; x=1691100949;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wOD8KgEEEOPljbiXkTM7e1vfVTCZeMVuNm+H/5ZnzWI=;
        b=GF4vQe9Q2QXiQ5WqN59LH2CNoeRi202CwB4ya41H6AykiczHuvb3xG7B9i0XkWfSfu
         Q373vkJ0dfBCgTbdj2Ah4chkhSclTnE9x/rRp6Nw0C51Wg23bAfqRJl5nMDYR/TgyfCw
         8ei61KySxvKUxN8R/Mvg48HyG2oHfvYRGHRfXVsXl6O1HFcJbkPpLFVUP3ZkEEtpGFQC
         35dCp96KyFPyZ3wVBzADGxTnXGR7/J7j6duhBE7cT04CsstMEbrEihLsYTKQPxe/7ceI
         Wu1Fs2DXxGwUGe9W6MBfBuoDYMkANMrNUHoh0KHRSEbofSezXX6mX/rC0Vilgz4OPWpy
         0M3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690496149; x=1691100949;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wOD8KgEEEOPljbiXkTM7e1vfVTCZeMVuNm+H/5ZnzWI=;
        b=Q58Qz0PkoO3kiOJEcL5JmrvhGj8PDjcy4d39saOR1GSFvFscXN8JmOmdVIOz4Xp+ZB
         hmOelT5UCcaRJUhuOesNl17TnBotjEbI0by2OTMXWvdG7tb1vb9hro27U1p7xfLrPPVZ
         GH9UkKWNl1o6gdRZL299lc6e9c+TIijosDd3yDIaFJd5CXLXuE51lPU22h3kyp7we5f9
         atYl0EpHWhXvDRHvBoETcEwJWiwype/4/GVIjUMbqXB4rWe6lLPQlSEk3KxyQR6VJyHc
         3z3uUpjirHtWrZD7lj7g0sUyVNAF02kfqOTw0kdXMi7Pjzy2eAiuev9zLAPEqOOSyau+
         xQMA==
X-Gm-Message-State: ABy/qLYE2STlBWmB1Zt2ykK5XlzgjwWxltrYEAw0/r8wVU+tCbw9o8VS
        lU3KIs1fv/38FdafM0X7ag0hjAFoNpXULbJ6ZCyS5Q==
X-Google-Smtp-Source: APBJJlFzvXJKovMYoMWH82NS6t0YgsjfzUuSbj76qs0bG32xlSJYCovy3Xv5KwXJHF2gt393R3/Esr0VFOB/cKbMMZM=
X-Received: by 2002:a25:c78b:0:b0:d12:25d:fd5c with SMTP id
 w133-20020a25c78b000000b00d12025dfd5cmr698418ybe.13.1690496149389; Thu, 27
 Jul 2023 15:15:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230727212208.102501-1-robdclark@gmail.com> <20230727212208.102501-10-robdclark@gmail.com>
In-Reply-To: <20230727212208.102501-10-robdclark@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 28 Jul 2023 01:15:38 +0300
Message-ID: <CAA8EJpo4hGkB=DMyCM+gU11Mfiqd2S9J660P+GtVUZSuDBCCNA@mail.gmail.com>
Subject: Re: [PATCH v2 09/13] drm/msm/adreno: Add adreno family
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
        Elliot Berman <quic_eberman@quicinc.com>,
        Rob Herring <robh@kernel.org>,
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

On Fri, 28 Jul 2023 at 00:23, Rob Clark <robdclark@gmail.com> wrote:
>
> From: Rob Clark <robdclark@chromium.org>
>
> Sometimes it is useful to know the sub-generation (or "family").  And in
> any case, this helps us get away from infering the generation from the

Nit: inferring

> numerical chip-id.
>
> v2: Fix is_a2xx() typo
>
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/gpu/drm/msm/adreno/adreno_device.c | 31 ++++++++++++++-
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c    | 11 +++---
>  drivers/gpu/drm/msm/adreno/adreno_gpu.h    | 46 ++++++++++++++++------
>  3 files changed, 70 insertions(+), 18 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

>

[skipped]


> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> index fe7afac5b059..14af16080bd0 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> @@ -29,6 +29,25 @@ enum {
>         ADRENO_FW_MAX,
>  };
>
> +/**
> + * @enum adreno_family: identify generation and possibly sub-generation
> + *
> + * In some cases there are distinct sub-generations within a major revision
> + * so it helps to be able to group the GPU devices by generation and if
> + * necessary sub-generation.
> + */
> +enum adreno_family {
> +       ADRENO_2XX_GEN1,  /* a20x */
> +       ADRENO_2XX_GEN2,  /* a22x */
> +       ADRENO_3XX,
> +       ADRENO_4XX,
> +       ADRENO_5XX,

reserves himself a right to glance at splitting 3xx and 5xx later on.

> +       ADRENO_6XX_GEN1,  /* a630 family */
> +       ADRENO_6XX_GEN2,  /* a640 family */
> +       ADRENO_6XX_GEN3,  /* a650 family */
> +       ADRENO_6XX_GEN4,  /* a660 family */
> +};
> +
>  #define ADRENO_QUIRK_TWO_PASS_USE_WFI          BIT(0)
>  #define ADRENO_QUIRK_FAULT_DETECT_MASK         BIT(1)
>  #define ADRENO_QUIRK_LMLOADKILL_DISABLE                BIT(2)
> @@ -68,6 +87,7 @@ struct adreno_speedbin {
>  struct adreno_info {
>         const char *machine;
>         struct adreno_rev rev;
> +       enum adreno_family family;
>         uint32_t revn;
>         const char *fw[ADRENO_FW_MAX];
>         uint32_t gmem;
> @@ -193,14 +213,14 @@ static inline bool adreno_is_a2xx(const struct adreno_gpu *gpu)
>  {
>         if (WARN_ON_ONCE(!gpu->info))
>                 return false;
> -       return (gpu->info->revn < 300);
> +       return gpu->info->family <= ADRENO_2XX_GEN2;
>  }
>
>  static inline bool adreno_is_a20x(const struct adreno_gpu *gpu)
>  {
>         if (WARN_ON_ONCE(!gpu->info))
>                 return false;
> -       return (gpu->info->revn < 210);
> +       return gpu->info->family == ADRENO_2XX_GEN1;
>  }
>
>  static inline bool adreno_is_a225(const struct adreno_gpu *gpu)
> @@ -343,29 +363,31 @@ static inline int adreno_is_a690(const struct adreno_gpu *gpu)
>  /* check for a615, a616, a618, a619 or any a630 derivatives */
>  static inline int adreno_is_a630_family(const struct adreno_gpu *gpu)
>  {
> -       return adreno_is_revn(gpu, 630) ||
> -               adreno_is_revn(gpu, 615) ||
> -               adreno_is_revn(gpu, 616) ||
> -               adreno_is_revn(gpu, 618) ||
> -               adreno_is_revn(gpu, 619);
> +       if (WARN_ON_ONCE(!gpu->info))
> +               return false;
> +       return gpu->info->family == ADRENO_6XX_GEN1;
>  }
>
>  static inline int adreno_is_a660_family(const struct adreno_gpu *gpu)
>  {
> -       return adreno_is_a660(gpu) || adreno_is_a690(gpu) || adreno_is_7c3(gpu);
> +       if (WARN_ON_ONCE(!gpu->info))
> +               return false;
> +       return gpu->info->family == ADRENO_6XX_GEN4;
>  }
>
>  /* check for a650, a660, or any derivatives */
>  static inline int adreno_is_a650_family(const struct adreno_gpu *gpu)
>  {
> -       return adreno_is_revn(gpu, 650) ||
> -               adreno_is_revn(gpu, 620) ||
> -               adreno_is_a660_family(gpu);
> +       if (WARN_ON_ONCE(!gpu->info))
> +               return false;
> +       return gpu->info->family >= ADRENO_6XX_GEN3;
>  }
>
>  static inline int adreno_is_a640_family(const struct adreno_gpu *gpu)
>  {
> -       return adreno_is_a640(gpu) || adreno_is_a680(gpu);
> +       if (WARN_ON_ONCE(!gpu->info))
> +               return false;
> +       return gpu->info->family == ADRENO_6XX_GEN2;
>  }
>
>  u64 adreno_private_address_space_size(struct msm_gpu *gpu);
> --
> 2.41.0
>


-- 
With best wishes
Dmitry
