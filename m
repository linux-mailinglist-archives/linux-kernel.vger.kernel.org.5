Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6BF7D6488
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 10:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234160AbjJYIGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 04:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234410AbjJYIG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 04:06:27 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9E11AA
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 01:06:24 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5a81ab75f21so52478757b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 01:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698221184; x=1698825984; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9N86T/fG3CiL6tT7DD8PpjcJ48kzS/vl5vzR+4WaF7s=;
        b=euVgzlqej9zF40s+9aOrsaeALFO6JgjShqLrbccIEY+r2UmxDAx5yyL/IKjaTDzX0L
         hKDqCy8s0oOeoVsMG+tlgEhDNV7nlJVLknopfVIY+lQgfTJ5q+6aO0R5FHTsoN8lihBb
         rwHnHGAuRFr5NN/DFtI+DWl5MwyH3zdsd72xbt5QAtLOWcYxKOIvj6RYNt+6SRViKg1D
         ZI5ZkM7hPpBe8y/5QbiYxbXQSWOQRq7jyUciPX3SvNYnHTAZiRZmKuyyspaH6rFASWgY
         6CX8iu+NYTKCWrDNrYQtvk+Y5Z8Kg5nYR5toZXkMr73nMgrC1uTPmoLBCrzbH981a041
         NiXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698221184; x=1698825984;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9N86T/fG3CiL6tT7DD8PpjcJ48kzS/vl5vzR+4WaF7s=;
        b=FcEeI4NH6xF7QIExPzAJmsAZKrYP7LmiCTfvLOw3DdMXzxHOPwmGQC8kpkk7rUrR8A
         yWeWT2v9cRV92NlBdCWx26hcNzMblIR444mwuyAiPOF3sBSqdCpWz4JmPm0xcrYTaCnQ
         SmXOGYeOWFOhrfAfLUX0cdDdmi+d/fyLikqSAxvQIZsXS/nXQdBTXbe3IE3Uv0tLt7Bn
         tVSIw6H32oavBht7o+g3alZzybZiCDlnfgvNMKJOi+lNDSHHtEcYZ7M5QKQVDkrEkmO+
         Hjq8laIOG+xXR3oU9no/wz3ogZ7YcX0qkGwf1MNrraakA/vuWNDr7PtA2SU5IAJnsHtd
         P6tQ==
X-Gm-Message-State: AOJu0YyjbJY/yarOYyIvPY+eAeUdAil2ZUqLdI4DAkp7Uhbe2x3hPBgD
        cm8AeMsuo6aqzdJ5r+Ue1fIuH6K6I4wwSRUDRGwWlQ==
X-Google-Smtp-Source: AGHT+IFOv7ktMHogTahZY8772P50C84Y6Y6IVMSF12aYBnzD0gZtk/sfInd6pg/uGamC/Q/rKxezX3XuQVgFyeYbTQ4=
X-Received: by 2002:a0d:cb10:0:b0:5a7:c4a7:21c3 with SMTP id
 n16-20020a0dcb10000000b005a7c4a721c3mr16860297ywd.38.1698221184039; Wed, 25
 Oct 2023 01:06:24 -0700 (PDT)
MIME-Version: 1.0
References: <20231025-topic-sm8650-upstream-mdss-v1-0-bb219b8c7a51@linaro.org> <20231025-topic-sm8650-upstream-mdss-v1-8-bb219b8c7a51@linaro.org>
In-Reply-To: <20231025-topic-sm8650-upstream-mdss-v1-8-bb219b8c7a51@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 25 Oct 2023 11:06:13 +0300
Message-ID: <CAA8EJpowPrNyXfyXC5wHz4OugzNFfp0E7qPo=5WS4k18U1LSqA@mail.gmail.com>
Subject: Re: [PATCH 8/8] drm/msm: dsi: add support for DSI 2.8.0
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Oct 2023 at 10:35, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> Add DSI Controller version 2.8.0 support for the SM8650 platform.
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/gpu/drm/msm/dsi/dsi_cfg.c | 17 +++++++++++++++++
>  drivers/gpu/drm/msm/dsi/dsi_cfg.h |  1 +
>  2 files changed, 18 insertions(+)
>
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_cfg.c b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
> index 1f98ff74ceb0..10ba7d153d1c 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_cfg.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
> @@ -190,6 +190,21 @@ static const struct msm_dsi_config sm8550_dsi_cfg = {
>         },
>  };
>
> +static const struct regulator_bulk_data sm8650_dsi_regulators[] = {
> +       { .supply = "vdda", .init_load_uA = 16600 },    /* 1.2 V */

Same comment regarding uA and sm8550 cfg.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> +};
> +
> +static const struct msm_dsi_config sm8650_dsi_cfg = {
> +       .io_offset = DSI_6G_REG_SHIFT,
> +       .regulator_data = sm8650_dsi_regulators,
> +       .num_regulators = ARRAY_SIZE(sm8650_dsi_regulators),
> +       .bus_clk_names = dsi_v2_4_clk_names,
> +       .num_bus_clks = ARRAY_SIZE(dsi_v2_4_clk_names),
> +       .io_start = {
> +               { 0xae94000, 0xae96000 },
> +       },
> +};
> +
>  static const struct regulator_bulk_data sc7280_dsi_regulators[] = {
>         { .supply = "vdda", .init_load_uA = 8350 },     /* 1.2 V */
>         { .supply = "refgen" },
> @@ -281,6 +296,8 @@ static const struct msm_dsi_cfg_handler dsi_cfg_handlers[] = {
>                 &sdm845_dsi_cfg, &msm_dsi_6g_v2_host_ops},
>         {MSM_DSI_VER_MAJOR_6G, MSM_DSI_6G_VER_MINOR_V2_7_0,
>                 &sm8550_dsi_cfg, &msm_dsi_6g_v2_host_ops},
> +       {MSM_DSI_VER_MAJOR_6G, MSM_DSI_6G_VER_MINOR_V2_8_0,
> +               &sm8650_dsi_cfg, &msm_dsi_6g_v2_host_ops},
>  };
>
>  const struct msm_dsi_cfg_handler *msm_dsi_cfg_get(u32 major, u32 minor)
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_cfg.h b/drivers/gpu/drm/msm/dsi/dsi_cfg.h
> index 43f0dd74edb6..4c9b4b37681b 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_cfg.h
> +++ b/drivers/gpu/drm/msm/dsi/dsi_cfg.h
> @@ -28,6 +28,7 @@
>  #define MSM_DSI_6G_VER_MINOR_V2_5_0    0x20050000
>  #define MSM_DSI_6G_VER_MINOR_V2_6_0    0x20060000
>  #define MSM_DSI_6G_VER_MINOR_V2_7_0    0x20070000
> +#define MSM_DSI_6G_VER_MINOR_V2_8_0    0x20080000
>
>  #define MSM_DSI_V2_VER_MINOR_8064      0x0
>
>
> --
> 2.34.1
>


-- 
With best wishes
Dmitry
