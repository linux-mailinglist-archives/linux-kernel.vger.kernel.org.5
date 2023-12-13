Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB3C8120A3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 22:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbjLMVUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 16:20:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjLMVUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 16:20:24 -0500
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701CACF
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 13:20:30 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5d3758fdd2eso73259947b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 13:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702502429; x=1703107229; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FqXQr8abf4Sh2kGebNrfb5oJyMJpF6xCUKnEE12XH/Q=;
        b=X2euGlk2KYiKPYXeuHgb4Jak78J6YJBeCek0ZLpQRNXxVlDzaaTdjp8eXSFcltE5BO
         IG69q0FP7SySyPxgPoWj2pb/bQFz7c9tyG/rDTmKTMsWgUIFHzFU4VNhkKwIB0W1UJxG
         SMlMjYqYZ2P6b7gLdrcyvriSSuJZHDkR6B0gxqIiXGocLdFpSGqiWWzA2FQ0l106eDv3
         0/XE+Y99J9Ag61NdOE0yju0fFUFYs1b10hnNULVPFMW4BwjE5g5bonRfPF2c5NAoXgZC
         ockDEQmjFFSk770VtZ7I0Ov3eCYCzFAOixHwBw6BPD6Cnpdkvn/Z1h0q/SgG0Im7iyWR
         Ugxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702502429; x=1703107229;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FqXQr8abf4Sh2kGebNrfb5oJyMJpF6xCUKnEE12XH/Q=;
        b=AjQhv9TccHJ/dbypbwwFeoo0HYn6L+AgR1qhFtq5zDdOJ+iMU4bveZOunHdUsg0eOU
         nCp49NqKg24JTFG0+AflFS5AsyFjf6fU9Z+AKQ9p2+D8MfmwbFPeYjpbfPYtnuXlmjh6
         s5rImpB2UZWS80nc3AFUeGh6d0Jrj5vRdKp0wvW+d4CSpehVNTe7AVN4A5HOkPD9LmMi
         JaRuEFylm3Iekuw+PZX04OeBFGA/mgkFcmy8L3LULF82i8iLFHVYxigkrKE6qfxgT+fr
         aj+8dx60kGcSxmR+1dfQc4ZRMlsqJ9GkzcYHC17QS6IiNYg838iG1YPQ8YatHt/4+jB4
         iT6w==
X-Gm-Message-State: AOJu0YyP9lAYCOkDp7WgvptukGuwAO2Q3g6WzdgBU7z2CHU3Y89ViQe6
        gX0ljo/zJd1a/1YeN1mQb+trY3M4ZBvNG6ZKBqOBfQ==
X-Google-Smtp-Source: AGHT+IHeo1UY1ULCcNk0KgK5peeMfa7CxbPjWoOoAA82PaXMtiZ9blILD4Z6ZOVhguzGfUKhUFB2iVcj8GUGo2GD07g=
X-Received: by 2002:a81:6582:0:b0:5d3:cd07:4c05 with SMTP id
 z124-20020a816582000000b005d3cd074c05mr6091652ywb.0.1702502429619; Wed, 13
 Dec 2023 13:20:29 -0800 (PST)
MIME-Version: 1.0
References: <20231213-encoder-fixup-v2-0-b11a4ad35e5e@quicinc.com> <20231213-encoder-fixup-v2-1-b11a4ad35e5e@quicinc.com>
In-Reply-To: <20231213-encoder-fixup-v2-1-b11a4ad35e5e@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 13 Dec 2023 23:20:18 +0200
Message-ID: <CAA8EJpqr0akUZoDYR1Q2+WBC4vvAgp_xfjBSq2ZTuoS4HLxnUQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drm/msm/dpu: Set input_sel bit for INTF
To:     Jessica Zhang <quic_jesszhan@quicinc.com>
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, quic_abhinavk@quicinc.com,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Dec 2023 at 22:51, Jessica Zhang <quic_jesszhan@quicinc.com> wrote:
>
> Set the input_sel bit for encoders as it was missed in the initial
> implementation.
>
> Reported-by: Rob Clark <robdclark@gmail.com>
> Closes: https://gitlab.freedesktop.org/drm/msm/-/issues/39
> Fixes: 91143873a05d ("drm/msm/dpu: Add MISR register support for interface")
> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c |  2 +-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c   |  2 +-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.c | 10 ++++++++--
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.h |  3 ++-
>  4 files changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
> index 0b6a0a7dcc39..226133af7840 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
> @@ -322,7 +322,7 @@ static u32 dpu_hw_intf_get_line_count(struct dpu_hw_intf *intf)
>
>  static void dpu_hw_intf_setup_misr(struct dpu_hw_intf *intf, bool enable, u32 frame_count)
>  {
> -       dpu_hw_setup_misr(&intf->hw, INTF_MISR_CTRL, enable, frame_count);
> +       dpu_hw_setup_misr(&intf->hw, INTF_MISR_CTRL, enable, frame_count, 0x1);
>  }
>
>  static int dpu_hw_intf_collect_misr(struct dpu_hw_intf *intf, u32 *misr_value)
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c
> index 25af52ab602f..bbc9756ecde9 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c
> @@ -85,7 +85,7 @@ static void dpu_hw_lm_setup_border_color(struct dpu_hw_mixer *ctx,
>
>  static void dpu_hw_lm_setup_misr(struct dpu_hw_mixer *ctx, bool enable, u32 frame_count)
>  {
> -       dpu_hw_setup_misr(&ctx->hw, LM_MISR_CTRL, enable, frame_count);
> +       dpu_hw_setup_misr(&ctx->hw, LM_MISR_CTRL, enable, frame_count, 0x0);
>  }
>
>  static int dpu_hw_lm_collect_misr(struct dpu_hw_mixer *ctx, u32 *misr_value)
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.c
> index 0b05061e3e62..87716a60332e 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.c
> @@ -477,7 +477,8 @@ void _dpu_hw_setup_qos_lut(struct dpu_hw_blk_reg_map *c, u32 offset,
>
>  void dpu_hw_setup_misr(struct dpu_hw_blk_reg_map *c,
>                 u32 misr_ctrl_offset,
> -               bool enable, u32 frame_count)
> +               bool enable, u32 frame_count,
> +               u32 input_sel)
>  {
>         u32 config = 0;
>
> @@ -487,8 +488,13 @@ void dpu_hw_setup_misr(struct dpu_hw_blk_reg_map *c,
>         wmb();
>
>         if (enable) {
> +               /*
> +                * note: Aside from encoders, input_sel should be
> +                * set to 0x0 by default
> +                */

Even if it is not a proper kernedoc, please move this comment before
the function.

>                 config = (frame_count & MISR_FRAME_COUNT_MASK) |
> -                       MISR_CTRL_ENABLE | MISR_CTRL_FREE_RUN_MASK;
> +                       MISR_CTRL_ENABLE | MISR_CTRL_FREE_RUN_MASK |
> +                       ((input_sel & 0xF) << 24);
>
>                 DPU_REG_WRITE(c, misr_ctrl_offset, config);
>         } else {
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.h
> index fe083b2e5696..761056be272b 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.h
> @@ -357,7 +357,8 @@ void _dpu_hw_setup_qos_lut(struct dpu_hw_blk_reg_map *c, u32 offset,
>  void dpu_hw_setup_misr(struct dpu_hw_blk_reg_map *c,
>                 u32 misr_ctrl_offset,
>                 bool enable,
> -               u32 frame_count);
> +               u32 frame_count,
> +               u32 input_sel);
>
>  int dpu_hw_collect_misr(struct dpu_hw_blk_reg_map *c,
>                 u32 misr_ctrl_offset,
>
> --
> 2.43.0
>


-- 
With best wishes
Dmitry
