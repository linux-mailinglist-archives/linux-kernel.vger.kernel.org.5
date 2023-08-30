Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07FE178E2E6
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 00:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238558AbjH3W6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 18:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234246AbjH3W6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 18:58:11 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35CC212F
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 15:57:52 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-d7485d37283so62845276.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 15:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693436270; x=1694041070; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jbesLFZn89QtS3Nk/fxwNNUghSnqXExXEAIFGNCDeeM=;
        b=oezi/sv/AH3gPVFZpwOtrApzbsHjQn2nhyaVAAYA73snamqy0IvOyVmGUwEZ4b2mbV
         OLNLORB2vbxqTnfaHoBScfvP/jhi0xbXQF6N6N+hyzuaWaJtaoIsU0nCTAnh0Hruye4O
         rwZiTI8dsy+emNi6oNU8yca6Q2RtaNdwgU0lJ8FBno+qtdGjZGdBZEF046lJJQXjwAlN
         h/Im3WEmvICdmjP+p0UinndwpWlpqFJ/McVRpgmlGoK6+Y2vNZ+vYGqUNgfOTyXKKsc8
         /HbVD6YRhTjQ9/N7k6cIiCXfh/F8T7aEQRYuPjBbOHOok6jAZsEH1YaUrQqpr7BVyizK
         tfTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693436270; x=1694041070;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jbesLFZn89QtS3Nk/fxwNNUghSnqXExXEAIFGNCDeeM=;
        b=RclJpIHxMtOCo+deLEVekMeLVjFv2neEzSWFHo66iFCrUpKjeuSt/G2LByepSDHt2x
         aiIbRo9F9eSLijFstdcIKJw1NkUqTdibiySvS4OxNbmBxj3kFUEoblytLwXMTL6An+lc
         K7iUp2dHSmUS7KEGaQLvlRnpLC1y3Bq4SQltUp+WhVFH8dNq++qVoQfqVvmI9BnAs5/M
         MCU9VXcAIgxaaz+W/8ttD/ZVxPPV2GKY80qEQ+hY09PrXoZfJ3Y2w4Soqtm6MtcOEEla
         f+O5FoiyCo8lbih1fyfhvkQ057w+F0ImFIkqc2bSflp441EI2A8/Zu0ziou2iZs3P5pC
         VQAw==
X-Gm-Message-State: AOJu0YxvX4+5zrtwe6pRCgN8+Ztm6M/XDWsotvLzDtDtVJ3bTBjpNPl8
        6J/gCrMl5TtwZftm6ep/ALybTrsUGzU7eNCkmtOWyg==
X-Google-Smtp-Source: AGHT+IG3oe2ouCAeqBMeWjd+y2neQTbmLX7tFZM/1DYvgEWwNCBSvEIBngqoyJWkuhznJGDIW/5TaccccPTX2hs78ug=
X-Received: by 2002:a25:b188:0:b0:d71:c54:6821 with SMTP id
 h8-20020a25b188000000b00d710c546821mr3826853ybj.35.1693436270486; Wed, 30 Aug
 2023 15:57:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230830224910.8091-1-quic_abhinavk@quicinc.com> <20230830224910.8091-5-quic_abhinavk@quicinc.com>
In-Reply-To: <20230830224910.8091-5-quic_abhinavk@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 31 Aug 2023 01:57:39 +0300
Message-ID: <CAA8EJpoQ0L_b=KDQxuXEL4KbaP1DACq1Qpw6m_ot6m+UYsHZWg@mail.gmail.com>
Subject: Re: [PATCH 04/16] drm/msm/dpu: add cdm blocks to sc7280 dpu_hw_catalog
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, quic_jesszhan@quicinc.com,
        quic_parellan@quicinc.com, quic_khsieh@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Aug 2023 at 01:49, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
> Add CDM blocks to the sc7280 dpu_hw_catalog to support
> YUV format output from writeback block.
>
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>  .../gpu/drm/msm/disp/dpu1/catalog/dpu_7_2_sc7280.h  |  9 +++++++++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h      | 13 +++++++++++++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h         |  5 +++++
>  3 files changed, 27 insertions(+)
>
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_2_sc7280.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_2_sc7280.h
> index 3b5061c4402a..5252170f216d 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_2_sc7280.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_2_sc7280.h
> @@ -251,10 +251,19 @@ static const struct dpu_mdss_version sc7280_mdss_ver = {
>         .core_minor_ver = 2,
>  };
>
> +static const struct dpu_cdm_cfg sc7280_cdm = {
> +       .name = "cdm_0",
> +       .id = CDM_0,
> +       .len = 0x228,
> +       .base = 0x79200,
> +       .features = 0,

No need to.
Also, as the CDM block seems to be common to all existing platforms,
what about moving this definition to dpu_hw_catalog.c next to VBIF
settings?

> +};
> +
>  const struct dpu_mdss_cfg dpu_sc7280_cfg = {
>         .mdss_ver = &sc7280_mdss_ver,
>         .caps = &sc7280_dpu_caps,
>         .mdp = &sc7280_mdp,
> +       .cdm = &sc7280_cdm,
>         .ctl_count = ARRAY_SIZE(sc7280_ctl),
>         .ctl = sc7280_ctl,
>         .sspp_count = ARRAY_SIZE(sc7280_sspp),
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> index 6c9634209e9f..4ea7c3f85a95 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> @@ -693,6 +693,17 @@ struct dpu_vbif_cfg {
>         u32 memtype[MAX_XIN_COUNT];
>  };
>
> +/**
> + * struct dpu_cdm_cfg - information of chroma down blocks
> + * @name               string name for debug purposes
> + * @id                 enum identifying this block
> + * @base               register offset of this block
> + * @features           bit mask identifying sub-blocks/features
> + */
> +struct dpu_cdm_cfg {
> +       DPU_HW_BLK_INFO;
> +};
> +
>  /**
>   * Define CDP use cases
>   * @DPU_PERF_CDP_UDAGE_RT: real-time use cases
> @@ -816,6 +827,8 @@ struct dpu_mdss_cfg {
>         u32 wb_count;
>         const struct dpu_wb_cfg *wb;
>
> +       const struct dpu_cdm_cfg *cdm;
> +
>         u32 ad_count;
>
>         u32 dspp_count;
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
> index d85157acfbf8..4d6dba18caf0 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
> @@ -185,6 +185,11 @@ enum dpu_dsc {
>         DSC_MAX
>  };
>
> +enum dpu_cdm {
> +       CDM_0 = 1,
> +       CDM_MAX
> +};
> +
>  enum dpu_pingpong {
>         PINGPONG_NONE,
>         PINGPONG_0,
> --
> 2.40.1
>


-- 
With best wishes
Dmitry
