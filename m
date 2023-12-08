Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61C8F80A25B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 12:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573587AbjLHLge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 06:36:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233380AbjLHLgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 06:36:31 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9301810FC
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 03:36:37 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5b383b4184fso17168037b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 03:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702035396; x=1702640196; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9vphCG37O8eMkMC8HIffZ3tk8WXWBglaXiyl76vCMdg=;
        b=ubq3gEE+AgwBI6bjU06Wb2mRjd/gHe5qeF8EBkQkfKHAJ+6kN27qTGOt04lfobQEuO
         tO7nCmg1rBrA94N2fOnCIFlRTgkHysaHGEIC+8VvSxV5h1PFuSTk8PcP3OdO/w6F+JaY
         lNAeLHp4pXUB/ffJ9/kCUSFfMw0Fum/EvWibtLni3yfZmWeejc8OaTIxrvdzA3rT0aj0
         LbztLsD7wpI/lipz69Xi8uDc9doz+Q4thK1grem3RM6Pm6sQTVKIFuI3JkU9XlmIXo6Z
         hMCqedB6KsFEK3+zriPKk4ia1kCklWlsjophydx2k1i/1yRcJbu+NdfHceAkMxzmrRY8
         CCVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702035396; x=1702640196;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9vphCG37O8eMkMC8HIffZ3tk8WXWBglaXiyl76vCMdg=;
        b=LT5ExkN9C9Cik/QFwvx1NnxG5o00Se0tGZ/rVIYm7fiKNjs85ke9L+g6XZgU7tC0vO
         0AZHAs6u+1qAqzidO79nf/LYNUGf3Kx4qnaEbNg9VGHFhgHDF9+VxzuzqrotfpIw3ChM
         dubPW+AXonqL59r/yj7mJjBp0WiOYvPkPL4zXJJhIcB38OmYp5DCZIoHuR6QVokgaugm
         en80Vys3V/NAQmZpNt/ZwQvbGUYrDK1pEQ/2kvno0Vg4uIOCSG2HLIvMdC48VDIZUt3r
         VNMVfh+0VhPtQLvh1+RU0bl6j6L4d+XPUg5+KiqquYsZXAoZ2R3zVOKwCGqGGQZeepEF
         yqYg==
X-Gm-Message-State: AOJu0YwFqGpSigXj+7IgrYE1YeNO/rRIyyYgMeDmer7FurPnycNh5FHq
        hdhAakvo9BEjwOuorGv6o6n04/RweLpgXdqCz2r0qA==
X-Google-Smtp-Source: AGHT+IGNbm4h8qNGjXg60DMzqF5TvBlaPsJbNi3hCXSZ1UuSvxxiPwgPotz2EPuscLJPFJRKdrmJugMk2E/Rs8uOkp4=
X-Received: by 2002:a0d:ea0b:0:b0:5d7:1940:7d79 with SMTP id
 t11-20020a0dea0b000000b005d719407d79mr3847704ywe.80.1702035396669; Fri, 08
 Dec 2023 03:36:36 -0800 (PST)
MIME-Version: 1.0
References: <20231208050641.32582-1-quic_abhinavk@quicinc.com> <20231208050641.32582-12-quic_abhinavk@quicinc.com>
In-Reply-To: <20231208050641.32582-12-quic_abhinavk@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 8 Dec 2023 13:36:25 +0200
Message-ID: <CAA8EJpo6=5mq8zCoBvdr73TsEFH96JS-mUo3Ks9go4VjBCm8uA@mail.gmail.com>
Subject: Re: [PATCH v2 11/16] drm/msm/dpu: add support to disable CDM block
 during encoder cleanup
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, quic_jesszhan@quicinc.com,
        quic_parellan@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Fri, 8 Dec 2023 at 07:07, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
> In preparation of setting up CDM block, add the logic to disable it
> properly during encoder cleanup.
>
> changes in v2:
>         - call update_pending_flush_cdm even when bind_pingpong_blk
>           is not present
>
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c      | 10 ++++++++++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h |  2 ++
>  2 files changed, 12 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Minor nit below

>
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> index aa1a1646b322..862912727925 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> @@ -26,6 +26,7 @@
>  #include "dpu_hw_dspp.h"
>  #include "dpu_hw_dsc.h"
>  #include "dpu_hw_merge3d.h"
> +#include "dpu_hw_cdm.h"
>  #include "dpu_formats.h"
>  #include "dpu_encoder_phys.h"
>  #include "dpu_crtc.h"
> @@ -2050,6 +2051,15 @@ void dpu_encoder_helper_phys_cleanup(struct dpu_encoder_phys *phys_enc)
>                                         phys_enc->hw_pp->merge_3d->idx);
>         }
>
> +       if (phys_enc->hw_cdm) {
> +               if (phys_enc->hw_cdm->ops.bind_pingpong_blk && phys_enc->hw_pp)
> +                       phys_enc->hw_cdm->ops.bind_pingpong_blk(phys_enc->hw_cdm,
> +                                                               false, phys_enc->hw_pp->idx);

PINGPONG_NONE

> +               if (phys_enc->hw_ctl->ops.update_pending_flush_cdm)
> +                       phys_enc->hw_ctl->ops.update_pending_flush_cdm(phys_enc->hw_ctl,
> +                                                                      phys_enc->hw_cdm->idx);
> +       }
> +
>         if (dpu_enc->dsc) {
>                 dpu_encoder_unprep_dsc(dpu_enc);
>                 dpu_enc->dsc = NULL;
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h
> index b6b48e2c63ef..410f6225789c 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h
> @@ -151,6 +151,7 @@ enum dpu_intr_idx {
>   * @hw_pp:             Hardware interface to the ping pong registers
>   * @hw_intf:           Hardware interface to the intf registers
>   * @hw_wb:             Hardware interface to the wb registers
> + * @hw_cdm:            Hardware interface to the CDM registers
>   * @dpu_kms:           Pointer to the dpu_kms top level
>   * @cached_mode:       DRM mode cached at mode_set time, acted on in enable
>   * @enabled:           Whether the encoder has enabled and running a mode
> @@ -179,6 +180,7 @@ struct dpu_encoder_phys {
>         struct dpu_hw_pingpong *hw_pp;
>         struct dpu_hw_intf *hw_intf;
>         struct dpu_hw_wb *hw_wb;
> +       struct dpu_hw_cdm *hw_cdm;
>         struct dpu_kms *dpu_kms;
>         struct drm_display_mode cached_mode;
>         enum dpu_enc_split_role split_role;
> --
> 2.40.1
>


-- 
With best wishes
Dmitry
