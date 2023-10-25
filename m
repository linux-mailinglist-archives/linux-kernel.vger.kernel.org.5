Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9397D6470
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 10:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234235AbjJYIEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 04:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234308AbjJYIEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 04:04:09 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68154184
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 01:04:06 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-778a20df8c3so367598385a.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 01:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698221045; x=1698825845; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3fwMcGLJ7nYe8SSHVZ+HO50S7Dp0i12qC/S3ZP8EfBY=;
        b=CDiM+9dXsbvNBq3WCDpmCfSt+wkCcMLRtqFNSex86M/v+poUyKiI5q6TNrS6dvKTcT
         CyPwr0+xE4NuSNm3WRnYdP/qib1fR77KaPezmaefiWfr9Ne1KD3Sxn61glEMI64ItfZu
         J/ikwQ4jbJgC82LZnX4zm38sYUUIn3J2AveNg35ctYJ1pn5pJoVmhd9cMJbWV7lxKMum
         dJAYcijmJfCvzKOQZygsdwqbcTsJrpVTVR4bhrBPZeVX7T92dthEZSzOnK7GPptMHWu9
         TeN8C2N5IVpg99dmDvPAV4QWbTVRrO396IHP8tnuKkFFTJtO8CCGF0MCCsLxSlt9TeuN
         mFoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698221045; x=1698825845;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3fwMcGLJ7nYe8SSHVZ+HO50S7Dp0i12qC/S3ZP8EfBY=;
        b=E+Q9uPyDVtHtE+4fRTZIByr33zd8Mjj9EIB3U84UTz/d756cL9b9M90RYQk8Wso9XZ
         ExF9QAs46IWdTKwXY74XQAWmcdJuYribp9HuH/WIbgYZoycn1xoUXf8GSmUMNZUlyJpH
         bbFdAj12LbvL+agFOBY4c3g2prsz2ujcBlYJfbgVPhJ6rgp8N0Dw7FHUWo0apmfkBBHC
         /E/eUpfM3+pASAt2KRtaWefhKt9x3MK5uFsmPnAYLZw1XYWvCMPUxtB+vzUw0OuZEG3F
         OpsxYgfBZ3WPS04cTNu+d7KnJwnCzKh+xUXx0dgvHGBP6j4A3hR6fm6XcDqliW5soLNP
         Sqwg==
X-Gm-Message-State: AOJu0Yw+6q0jfmHN1NJsRmslLI6THM3Ocp6LA8CjeH0jo1bK5KEIZuA4
        Fsvvzm+G+1cFfjhoI+OnJ/RrSCxzZF6vUOjmmtcv5A==
X-Google-Smtp-Source: AGHT+IHGl11EIegvL/m7wJAmFPHRjo9ndjP1xqa+xYpJHUe09/aZADzdf21iKb/J6OYzZwnVFQxLUhc6iEzbpmkMiPM=
X-Received: by 2002:a05:620a:164a:b0:778:96eb:e7d9 with SMTP id
 c10-20020a05620a164a00b0077896ebe7d9mr14770645qko.19.1698221045386; Wed, 25
 Oct 2023 01:04:05 -0700 (PDT)
MIME-Version: 1.0
References: <20231025-topic-sm8650-upstream-mdss-v1-0-bb219b8c7a51@linaro.org> <20231025-topic-sm8650-upstream-mdss-v1-7-bb219b8c7a51@linaro.org>
In-Reply-To: <20231025-topic-sm8650-upstream-mdss-v1-7-bb219b8c7a51@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 25 Oct 2023 11:03:54 +0300
Message-ID: <CAA8EJpr+QGBFchG9aXJLxyhbMwMWZF6RjSVOpORkP_KFrV=P1A@mail.gmail.com>
Subject: Re: [PATCH 7/8] drm/msm: dsi: add support for DSI-PHY on SM8650
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Oct 2023 at 10:35, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> Add DSI PHY support for the SM8650 platform.
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/gpu/drm/msm/dsi/phy/dsi_phy.c     |  2 ++
>  drivers/gpu/drm/msm/dsi/phy/dsi_phy.h     |  1 +
>  drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c | 27 +++++++++++++++++++++++++++
>  3 files changed, 30 insertions(+)
>
> diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
> index 05621e5e7d63..7612be6c3618 100644
> --- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
> +++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
> @@ -585,6 +585,8 @@ static const struct of_device_id dsi_phy_dt_match[] = {
>           .data = &dsi_phy_5nm_8450_cfgs },
>         { .compatible = "qcom,sm8550-dsi-phy-4nm",
>           .data = &dsi_phy_4nm_8550_cfgs },
> +       { .compatible = "qcom,sm8650-dsi-phy-4nm",
> +         .data = &dsi_phy_4nm_8650_cfgs },
>  #endif
>         {}
>  };
> diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.h b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.h
> index 8b640d174785..e4275d3ad581 100644
> --- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.h
> +++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.h
> @@ -62,6 +62,7 @@ extern const struct msm_dsi_phy_cfg dsi_phy_7nm_7280_cfgs;
>  extern const struct msm_dsi_phy_cfg dsi_phy_5nm_8350_cfgs;
>  extern const struct msm_dsi_phy_cfg dsi_phy_5nm_8450_cfgs;
>  extern const struct msm_dsi_phy_cfg dsi_phy_4nm_8550_cfgs;
> +extern const struct msm_dsi_phy_cfg dsi_phy_4nm_8650_cfgs;
>
>  struct msm_dsi_dphy_timing {
>         u32 clk_zero;
> diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
> index 3b1ed02f644d..c66193f2dc0d 100644
> --- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
> +++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
> @@ -1121,6 +1121,10 @@ static const struct regulator_bulk_data dsi_phy_7nm_37750uA_regulators[] = {
>         { .supply = "vdds", .init_load_uA = 37550 },
>  };
>
> +static const struct regulator_bulk_data dsi_phy_7nm_98000uA_regulators[] = {
> +       { .supply = "vdds", .init_load_uA = 98000 },
> +};
> +
>  static const struct regulator_bulk_data dsi_phy_7nm_97800uA_regulators[] = {
>         { .supply = "vdds", .init_load_uA = 97800 },
>  };
> @@ -1281,3 +1285,26 @@ const struct msm_dsi_phy_cfg dsi_phy_4nm_8550_cfgs = {
>         .num_dsi_phy = 2,
>         .quirks = DSI_PHY_7NM_QUIRK_V5_2,
>  };
> +
> +const struct msm_dsi_phy_cfg dsi_phy_4nm_8650_cfgs = {

So, this is the same as sm8550 config, just using 400 uA less? I
wonder if it makes sense to go for setting the regulator mode instead
of setting the load.

Nevertheless (unless you'd like to reuse sm8550 config entry):

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> +       .has_phy_lane = true,
> +       .regulator_data = dsi_phy_7nm_98000uA_regulators,
> +       .num_regulators = ARRAY_SIZE(dsi_phy_7nm_98000uA_regulators),
> +       .ops = {
> +               .enable = dsi_7nm_phy_enable,
> +               .disable = dsi_7nm_phy_disable,
> +               .pll_init = dsi_pll_7nm_init,
> +               .save_pll_state = dsi_7nm_pll_save_state,
> +               .restore_pll_state = dsi_7nm_pll_restore_state,
> +               .set_continuous_clock = dsi_7nm_set_continuous_clock,
> +       },
> +       .min_pll_rate = 600000000UL,
> +#ifdef CONFIG_64BIT
> +       .max_pll_rate = 5000000000UL,
> +#else
> +       .max_pll_rate = ULONG_MAX,
> +#endif
> +       .io_start = { 0xae95000, 0xae97000 },
> +       .num_dsi_phy = 2,
> +       .quirks = DSI_PHY_7NM_QUIRK_V5_2,
> +};
>
> --
> 2.34.1
>


-- 
With best wishes
Dmitry
