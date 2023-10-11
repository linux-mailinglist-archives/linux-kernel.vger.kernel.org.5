Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 156877C543E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 14:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbjJKMqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 08:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbjJKMqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 08:46:03 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37BB693
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:46:01 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5a7dafb659cso10832887b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697028360; x=1697633160; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2o0g9qCTG3HoWvcTZG921t8fsHcZPOC6eWWcKbXQ7nM=;
        b=I7eLN/1yLClDtYMgV3IMnJAF28q/h4UQ2ko0CEjZE66zBgPXOLKH1VwCNQrlb3WQuq
         rUHImEubOm5wmtijQDOVnaHtmJGCll9qUtdcEkkaBV1OY6gDgVE8HuUzn5CmMBA+xBht
         WBp2ZteDsbSvZFAqv0DuHY23wzkegVOpzXxzrWKp7gNlIfw55ZwygQHI0kknRs15xgch
         qV9lROsSSPcSLakJcLCj3Tbjz01JXhW1TYMPbOiM1y6Zf5I7IrtTGBxzq1gZZs0XQ5tp
         9OGrJFXWjFL0Z1gcKdDJ4VvWX6c2doqTkwn3Xj83CdRf2UjJZuyXm66IzYKhUtuiI9Km
         BNbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697028360; x=1697633160;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2o0g9qCTG3HoWvcTZG921t8fsHcZPOC6eWWcKbXQ7nM=;
        b=c52c4/mvlQIdjUpoiauqckbITaOeOxQgoBSPxlp9Q0zblYk45+V3fTbZpBfCd8ydbj
         KC8QVWMr6kXlGFd6wcnfRhRGbW1f/v8+TeVxM6pnSs6uLqLVlHwcuC61AeIqAA3QZbcK
         X4NYv3bg/PhMSXx5gBFrYKvPYLhMi/qIKgzGTBtadEscFTSfXFt8TOR7WAx24C/FafY9
         A4wJyBkCrju+MbszS2Z4Ts54D3ygx2W3YopPU3uhjpPkT1S5GS+Ab9P4TjAS93ymCnjV
         gSw43/DasCo6WkiCenUQgeyuiASbh/WoRRZOdWeYBGZSP451iOEaGv//SVzJuMT1D7wW
         LxPw==
X-Gm-Message-State: AOJu0YwpZrqmgUU4YS5rg4nyQBXJVzbjY48g6OUd3vqNqxlgRzu0kf7a
        GD/VhO7brihD59M1efHnZjgPfDUJhtDtJAd/g3NzM0qfzTiMeWqr1Lk=
X-Google-Smtp-Source: AGHT+IEmXXTmgu0PhQyUMG9lH6Jifxk5C7ypx/CxRpUPv8BdpeQ/LMCyB9Nn+bNXhUXUwp+cwDQTaSf8gVrrnpFoQcQ=
X-Received: by 2002:a81:8647:0:b0:595:89b0:6b56 with SMTP id
 w68-20020a818647000000b0059589b06b56mr23473114ywf.28.1697028360290; Wed, 11
 Oct 2023 05:46:00 -0700 (PDT)
MIME-Version: 1.0
References: <20231011-topic-sm8550-graphics-sspp-split-clk-v2-0-b219c945df53@linaro.org>
 <20231011-topic-sm8550-graphics-sspp-split-clk-v2-2-b219c945df53@linaro.org>
In-Reply-To: <20231011-topic-sm8550-graphics-sspp-split-clk-v2-2-b219c945df53@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 11 Oct 2023 15:45:49 +0300
Message-ID: <CAA8EJpps7g6LWFUS87j2oGwMW6He=MDSm_GaR_zOyQPHUvGReg@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] drm/msm/dpu: add setup_clk_force_ctrl() op to sspp
 & wb
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Oct 2023 at 14:59, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> Starting from SM8550, the SSPP & WB clock controls are moved
> the SSPP and WB register range, as it's called "VBIF_CLK_SPLIT"
> downstream.
>
> Implement setup_clk_force_ctrl() only starting from major version 9
> which corresponds to SM8550 MDSS.
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

With two minor issues below fixed:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c | 21 ++++++++++++++++++---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h | 12 +++++++++++-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.c   | 20 +++++++++++++++++---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.h   |  7 ++++++-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c      |  4 ++--
>  5 files changed, 54 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c
> index f2192de93713..5fd213ed6491 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c
> @@ -69,6 +69,7 @@
>  #define SSPP_EXCL_REC_XY_REC1              0x188
>  #define SSPP_EXCL_REC_SIZE                 0x1B4
>  #define SSPP_EXCL_REC_XY                   0x1B8
> +#define SSPP_CLK_CTRL                      0x330
>
>  /* SSPP_SRC_OP_MODE & OP_MODE_REC1 */
>  #define MDSS_MDP_OP_DEINTERLACE            BIT(22)
> @@ -581,8 +582,18 @@ static void dpu_hw_sspp_setup_cdp(struct dpu_sw_pipe *pipe,
>         dpu_setup_cdp(&ctx->hw, cdp_cntl_offset, fmt, enable);
>  }
>
> +static bool dpu_hw_sspp_setup_clk_force_ctrl(struct dpu_hw_sspp *ctx, bool enable)
> +{
> +       struct dpu_clk_ctrl_reg sspp_clk_ctrl = {

Nit: static const?

> +               .reg_off = SSPP_CLK_CTRL,
> +               .bit_off = 0
> +       };
> +
> +       return dpu_hw_clk_force_ctrl(&ctx->hw, &sspp_clk_ctrl, enable);
> +}
> +
>  static void _setup_layer_ops(struct dpu_hw_sspp *c,
> -               unsigned long features)
> +               unsigned long features, const struct dpu_mdss_version *mdss_rev)
>  {
>         c->ops.setup_format = dpu_hw_sspp_setup_format;
>         c->ops.setup_rects = dpu_hw_sspp_setup_rects;
> @@ -612,6 +623,9 @@ static void _setup_layer_ops(struct dpu_hw_sspp *c,
>
>         if (test_bit(DPU_SSPP_CDP, &features))
>                 c->ops.setup_cdp = dpu_hw_sspp_setup_cdp;
> +
> +       if (mdss_rev->core_major_ver >= 9)
> +               c->ops.setup_clk_force_ctrl = dpu_hw_sspp_setup_clk_force_ctrl;
>  }
>
>  #ifdef CONFIG_DEBUG_FS
> @@ -672,7 +686,8 @@ int _dpu_hw_sspp_init_debugfs(struct dpu_hw_sspp *hw_pipe, struct dpu_kms *kms,
>  #endif
>
>  struct dpu_hw_sspp *dpu_hw_sspp_init(const struct dpu_sspp_cfg *cfg,
> -               void __iomem *addr, const struct msm_mdss_data *mdss_data)
> +               void __iomem *addr, const struct msm_mdss_data *mdss_data,
> +               const struct dpu_mdss_version *mdss_rev)
>  {
>         struct dpu_hw_sspp *hw_pipe;
>
> @@ -690,7 +705,7 @@ struct dpu_hw_sspp *dpu_hw_sspp_init(const struct dpu_sspp_cfg *cfg,
>         hw_pipe->ubwc = mdss_data;
>         hw_pipe->idx = cfg->id;
>         hw_pipe->cap = cfg;
> -       _setup_layer_ops(hw_pipe, hw_pipe->cap->features);
> +       _setup_layer_ops(hw_pipe, hw_pipe->cap->features, mdss_rev);
>
>         return hw_pipe;
>  }
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h
> index cbf4f95ff0fd..f93969fddb22 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h
> @@ -271,6 +271,14 @@ struct dpu_hw_sspp_ops {
>         void (*setup_qos_ctrl)(struct dpu_hw_sspp *ctx,
>                                bool danger_safe_en);
>
> +       /**
> +        * setup_clk_force_ctrl - setup clock force control
> +        * @ctx: Pointer to pipe context
> +        * @enable: enable clock force if true
> +        */
> +       bool (*setup_clk_force_ctrl)(struct dpu_hw_sspp *ctx,
> +                                    bool enable);
> +
>         /**
>          * setup_histogram - setup histograms
>          * @ctx: Pointer to pipe context
> @@ -334,9 +342,11 @@ struct dpu_kms;
>   * @cfg:  Pipe catalog entry for which driver object is required
>   * @addr: Mapped register io address of MDP
>   * @mdss_data: UBWC / MDSS configuration data
> + * @mdss_rev: dpu core's major and minor versions
>   */
>  struct dpu_hw_sspp *dpu_hw_sspp_init(const struct dpu_sspp_cfg *cfg,
> -               void __iomem *addr, const struct msm_mdss_data *mdss_data);
> +               void __iomem *addr, const struct msm_mdss_data *mdss_data,
> +               const struct dpu_mdss_version *mdss_rev);
>
>  /**
>   * dpu_hw_sspp_destroy(): Destroys SSPP driver context
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.c
> index ebc416400382..374c2c64c9e4 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.c
> @@ -43,6 +43,7 @@
>  #define WB_MUX                                0x150
>  #define WB_CROP_CTRL                          0x154
>  #define WB_CROP_OFFSET                        0x158
> +#define WB_CLK_CTRL                           0x178
>  #define WB_CSC_BASE                           0x260
>  #define WB_DST_ADDR_SW_STATUS                 0x2B0
>  #define WB_CDP_CNTL                           0x2B4
> @@ -175,8 +176,18 @@ static void dpu_hw_wb_bind_pingpong_blk(
>         DPU_REG_WRITE(c, WB_MUX, mux_cfg);
>  }
>
> +static bool dpu_hw_wb_setup_clk_force_ctrl(struct dpu_hw_wb *ctx, bool enable)
> +{
> +       struct dpu_clk_ctrl_reg wb_clk_ctrl = {

And here too, static const. We can even move them away from the function.

> +               .reg_off = WB_CLK_CTRL,
> +               .bit_off = 0
> +       };
> +
> +       return dpu_hw_clk_force_ctrl(&ctx->hw, &wb_clk_ctrl, enable);
> +}
> +
>  static void _setup_wb_ops(struct dpu_hw_wb_ops *ops,
> -               unsigned long features)
> +               unsigned long features, const struct dpu_mdss_version *mdss_rev)
>  {
>         ops->setup_outaddress = dpu_hw_wb_setup_outaddress;
>         ops->setup_outformat = dpu_hw_wb_setup_format;
> @@ -192,10 +203,13 @@ static void _setup_wb_ops(struct dpu_hw_wb_ops *ops,
>
>         if (test_bit(DPU_WB_INPUT_CTRL, &features))
>                 ops->bind_pingpong_blk = dpu_hw_wb_bind_pingpong_blk;
> +
> +       if (mdss_rev->core_major_ver >= 9)
> +               ops->setup_clk_force_ctrl = dpu_hw_wb_setup_clk_force_ctrl;
>  }
>
>  struct dpu_hw_wb *dpu_hw_wb_init(const struct dpu_wb_cfg *cfg,
> -               void __iomem *addr)
> +               void __iomem *addr, const struct dpu_mdss_version *mdss_rev)
>  {
>         struct dpu_hw_wb *c;
>
> @@ -212,7 +226,7 @@ struct dpu_hw_wb *dpu_hw_wb_init(const struct dpu_wb_cfg *cfg,
>         /* Assign ops */
>         c->idx = cfg->id;
>         c->caps = cfg;
> -       _setup_wb_ops(&c->ops, c->caps->features);
> +       _setup_wb_ops(&c->ops, c->caps->features, mdss_rev);
>
>         return c;
>  }
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.h
> index 2d7db2efa3d0..88792f450a92 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.h
> @@ -29,6 +29,7 @@ struct dpu_hw_wb_cfg {
>   *  @setup_outformat: setup output format of writeback block from writeback job
>   *  @setup_qos_lut:   setup qos LUT for writeback block based on input
>   *  @setup_cdp:       setup chroma down prefetch block for writeback block
> + *  @setup_clk_force_ctrl: setup clock force control
>   *  @bind_pingpong_blk: enable/disable the connection with ping-pong block
>   */
>  struct dpu_hw_wb_ops {
> @@ -48,6 +49,9 @@ struct dpu_hw_wb_ops {
>                           const struct dpu_format *fmt,
>                           bool enable);
>
> +       bool (*setup_clk_force_ctrl)(struct dpu_hw_wb *ctx,
> +                                    bool enable);
> +
>         void (*bind_pingpong_blk)(struct dpu_hw_wb *ctx,
>                                   const enum dpu_pingpong pp);
>  };
> @@ -74,10 +78,11 @@ struct dpu_hw_wb {
>   * dpu_hw_wb_init() - Initializes the writeback hw driver object.
>   * @cfg:  wb_path catalog entry for which driver object is required
>   * @addr: mapped register io address of MDP
> + * @mdss_rev: dpu core's major and minor versions
>   * Return: Error code or allocated dpu_hw_wb context
>   */
>  struct dpu_hw_wb *dpu_hw_wb_init(const struct dpu_wb_cfg *cfg,
> -               void __iomem *addr);
> +               void __iomem *addr, const struct dpu_mdss_version *mdss_rev);
>
>  /**
>   * dpu_hw_wb_destroy(): Destroy writeback hw driver object.
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
> index f9215643c71a..f363bcfdfd70 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
> @@ -175,7 +175,7 @@ int dpu_rm_init(struct dpu_rm *rm,
>                 struct dpu_hw_wb *hw;
>                 const struct dpu_wb_cfg *wb = &cat->wb[i];
>
> -               hw = dpu_hw_wb_init(wb, mmio);
> +               hw = dpu_hw_wb_init(wb, mmio, cat->mdss_ver);
>                 if (IS_ERR(hw)) {
>                         rc = PTR_ERR(hw);
>                         DPU_ERROR("failed wb object creation: err %d\n", rc);
> @@ -231,7 +231,7 @@ int dpu_rm_init(struct dpu_rm *rm,
>                 struct dpu_hw_sspp *hw;
>                 const struct dpu_sspp_cfg *sspp = &cat->sspp[i];
>
> -               hw = dpu_hw_sspp_init(sspp, mmio, mdss_data);
> +               hw = dpu_hw_sspp_init(sspp, mmio, mdss_data, cat->mdss_ver);
>                 if (IS_ERR(hw)) {
>                         rc = PTR_ERR(hw);
>                         DPU_ERROR("failed sspp object creation: err %d\n", rc);
>
> --
> 2.34.1
>


-- 
With best wishes
Dmitry
