Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4F77E3FCF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 14:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235163AbjKGNLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 08:11:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235153AbjKGNKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 08:10:37 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F773269
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 05:06:34 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5a86b6391e9so68163777b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 05:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699362393; x=1699967193; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VpeyORNuSizmDrRB2g688RvYszoR2DBekJuTr7PcuM0=;
        b=WicRZ38KN4WL2EXIyBMvBMMQpKHEOVKsQ9gs+hXrf7CQuyHgNkzzw3VIHInmtTsfb6
         DwFnsocoaDHE0W5qtQyPQ3Wt0X2ClPuLiW4wGZdHI0gra4Wh5mSStVPT/QNQ1hN7hPFg
         KrwYLhaBrYQSVVr6lJxggaJbzSo81r5VGeBSXFAfLdfSgJdSItgHft4RTaE35j1fuLAw
         JOA0ndjdjsfjfwVKJf0jbwQTm90LyIJzwhAYTbNHVeGZ6mmlHy2pmMdiY0WaENKSS4Ft
         zmaLvQ+fnmw5LEyUg/fi0Fz2U+Tnie4ftU+i+eSHi4WeShY46T0dUgpgeZ9Hdf7a7Oo1
         3+BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699362393; x=1699967193;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VpeyORNuSizmDrRB2g688RvYszoR2DBekJuTr7PcuM0=;
        b=Z0RVht/MLueRdty82fp1ezoqPu8M5XX0u0zamA8tMx52WIml9gt1gwZ9/MczcHnkB+
         lrfz5X7JOge5NzkEL+mB69TzhOLqxEF1WvUoOiDw3dr1+YZrOIK/J1dDR3IAxX/YtESj
         vgnDPr9Kbn1sn9iRN5rv3UZ/Cr1a8cHb3Yc+4KVqPcASasekbEmERnsNOuyPvatM7F4/
         QHbs4bPSlS3RTk3VqLiPKyYNZ080AzNZXcCzS/8STaS5UOmrzhmQsJTMfYuK86BOU4Tr
         nZWah7srpeaUVXQTObaFiq+Ab8bWJ9VjAzagAXe9rG3fsY1XjxQjuwQBehb6sY3UaPz0
         Xztw==
X-Gm-Message-State: AOJu0Yxqfy3Tg1vj9ADemx13Crn28u+7kT+pbPZt7duaEE62Cw3EtsNw
        jOGJU8nruMzE2nuLQwPbtLgfg/U3IPteCkLZf4jhCw==
X-Google-Smtp-Source: AGHT+IEw64WfuhV/VAJ5h7y4+mgyq9+AiOgzXcHht2Xl+7ufPjUsXCd8tsAlA2DXiG8eMlgYKartctcAFgD5/T8Z61M=
X-Received: by 2002:a81:52d5:0:b0:5a8:435d:8ca9 with SMTP id
 g204-20020a8152d5000000b005a8435d8ca9mr13532798ywb.25.1699362393389; Tue, 07
 Nov 2023 05:06:33 -0800 (PST)
MIME-Version: 1.0
References: <20231107-refclk_always_on-v2-0-de23962fc4b3@quicinc.com> <20231107-refclk_always_on-v2-2-de23962fc4b3@quicinc.com>
In-Reply-To: <20231107-refclk_always_on-v2-2-de23962fc4b3@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 7 Nov 2023 15:06:22 +0200
Message-ID: <CAA8EJpr8Y+k2FJqFfZVagWxfgsUEnZ1010-xaaUg=c6tqu8Hsw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] phy: qcom-qmp-pcie: Add endpoint refclk control
 register offset
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_ramkri@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_vpernami@quicinc.com, quic_parass@quicinc.com
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

On Tue, 7 Nov 2023 at 14:26, Krishna chaitanya chundru
<quic_krichai@quicinc.com> wrote:
>
> Some platforms needs to keep endpoint refclk always on, for this
> purpose add this offset for all the applicable phy versions.
>
> And also add reg layout for few controllers as we are adding
> endpoint refclk control register which changes based upon phy version.
>
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-pcie.c           | 26 +++++++++++++++++++---
>  drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5.h    |  1 +
>  drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5_20.h |  1 +
>  drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6_20.h |  1 +
>  4 files changed, 26 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> index a63ca7424974..74d03d217ff2 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> @@ -77,6 +77,7 @@ enum qphy_reg_layout {
>         QPHY_START_CTRL,
>         QPHY_PCS_STATUS,
>         QPHY_PCS_POWER_DOWN_CONTROL,
> +       QPHY_PCS_ENDPOINT_REFCLK_CNTRL,
>         /* Keep last to ensure regs_layout arrays are properly initialized */
>         QPHY_LAYOUT_SIZE
>  };
> @@ -93,6 +94,7 @@ static const unsigned int pciephy_v3_regs_layout[QPHY_LAYOUT_SIZE] = {
>         [QPHY_START_CTRL]               = QPHY_V3_PCS_START_CONTROL,
>         [QPHY_PCS_STATUS]               = QPHY_V3_PCS_PCS_STATUS,
>         [QPHY_PCS_POWER_DOWN_CONTROL]   = QPHY_V3_PCS_POWER_DOWN_CONTROL,
> +       [QPHY_PCS_ENDPOINT_REFCLK_CNTRL]        = QPHY_V3_PCS_ENDPOINT_REFCLK_CNTRL,
>  };
>
>  static const unsigned int sdm845_qhp_pciephy_regs_layout[QPHY_LAYOUT_SIZE] = {
> @@ -107,6 +109,7 @@ static const unsigned int pciephy_v4_regs_layout[QPHY_LAYOUT_SIZE] = {
>         [QPHY_START_CTRL]               = QPHY_V4_PCS_START_CONTROL,
>         [QPHY_PCS_STATUS]               = QPHY_V4_PCS_PCS_STATUS1,
>         [QPHY_PCS_POWER_DOWN_CONTROL]   = QPHY_V4_PCS_POWER_DOWN_CONTROL,
> +       [QPHY_PCS_ENDPOINT_REFCLK_CNTRL]        = QPHY_V4_PCS_PCIE_ENDPOINT_REFCLK_CNTRL,
>  };
>
>  static const unsigned int pciephy_v5_regs_layout[QPHY_LAYOUT_SIZE] = {
> @@ -114,6 +117,23 @@ static const unsigned int pciephy_v5_regs_layout[QPHY_LAYOUT_SIZE] = {
>         [QPHY_START_CTRL]               = QPHY_V5_PCS_START_CONTROL,
>         [QPHY_PCS_STATUS]               = QPHY_V5_PCS_PCS_STATUS1,
>         [QPHY_PCS_POWER_DOWN_CONTROL]   = QPHY_V5_PCS_POWER_DOWN_CONTROL,
> +       [QPHY_PCS_ENDPOINT_REFCLK_CNTRL]        = QPHY_V5_PCS_PCIE_ENDPOINT_REFCLK_CNTRL,
> +};
> +
> +static const unsigned int pciephy_v5_20_regs_layout[QPHY_LAYOUT_SIZE] = {
> +       [QPHY_SW_RESET]                 = QPHY_V5_PCS_SW_RESET,
> +       [QPHY_START_CTRL]               = QPHY_V5_PCS_START_CONTROL,
> +       [QPHY_PCS_STATUS]               = QPHY_V5_PCS_PCS_STATUS1,
> +       [QPHY_PCS_POWER_DOWN_CONTROL]   = QPHY_V5_PCS_POWER_DOWN_CONTROL,

Nit: we should probably define V5_20 and v6_20 versions of these registers

If you were to send v3 for any reason, could you please add them?

> +       [QPHY_PCS_ENDPOINT_REFCLK_CNTRL]        = QPHY_V5_20_PCS_PCIE_ENDPOINT_REFCLK_CNTRL,
> +};
> +
> +static const unsigned int pciephy_v6_20_regs_layout[QPHY_LAYOUT_SIZE] = {
> +       [QPHY_SW_RESET]                 = QPHY_V5_PCS_SW_RESET,
> +       [QPHY_START_CTRL]               = QPHY_V5_PCS_START_CONTROL,
> +       [QPHY_PCS_STATUS]               = QPHY_V5_PCS_PCS_STATUS1,
> +       [QPHY_PCS_POWER_DOWN_CONTROL]   = QPHY_V5_PCS_POWER_DOWN_CONTROL,
> +       [QPHY_PCS_ENDPOINT_REFCLK_CNTRL]        = QPHY_PCIE_V6_20_PCS_ENDPOINT_REFCLK_CNTRL,
>  };
>
>  static const struct qmp_phy_init_tbl msm8998_pcie_serdes_tbl[] = {
> @@ -2956,7 +2976,7 @@ static const struct qmp_phy_cfg sm8450_qmp_gen4x2_pciephy_cfg = {
>         .num_resets             = ARRAY_SIZE(sdm845_pciephy_reset_l),
>         .vreg_list              = qmp_phy_vreg_l,
>         .num_vregs              = ARRAY_SIZE(qmp_phy_vreg_l),
> -       .regs                   = pciephy_v5_regs_layout,
> +       .regs                   = pciephy_v5_20_regs_layout,
>
>         .pwrdn_ctrl             = SW_PWRDN | REFCLK_DRV_DSBL,
>         .phy_status             = PHYSTATUS_4_20,
> @@ -3012,7 +3032,7 @@ static const struct qmp_phy_cfg sm8550_qmp_gen4x2_pciephy_cfg = {
>         .num_resets             = ARRAY_SIZE(sdm845_pciephy_reset_l),
>         .vreg_list              = sm8550_qmp_phy_vreg_l,
>         .num_vregs              = ARRAY_SIZE(sm8550_qmp_phy_vreg_l),
> -       .regs                   = pciephy_v5_regs_layout,
> +       .regs                   = pciephy_v6_20_regs_layout,
>
>         .pwrdn_ctrl             = SW_PWRDN | REFCLK_DRV_DSBL,
>         .phy_status             = PHYSTATUS_4_20,
> @@ -3047,7 +3067,7 @@ static const struct qmp_phy_cfg sa8775p_qmp_gen4x2_pciephy_cfg = {
>         .num_resets             = ARRAY_SIZE(sdm845_pciephy_reset_l),
>         .vreg_list              = qmp_phy_vreg_l,
>         .num_vregs              = ARRAY_SIZE(qmp_phy_vreg_l),
> -       .regs                   = pciephy_v5_regs_layout,
> +       .regs                   = pciephy_v5_20_regs_layout,
>
>         .pwrdn_ctrl             = SW_PWRDN | REFCLK_DRV_DSBL,
>         .phy_status             = PHYSTATUS_4_20,
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5.h b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5.h
> index a469ae2a10a1..9b166286afda 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5.h
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5.h
> @@ -11,6 +11,7 @@
>  #define QPHY_V5_PCS_PCIE_POWER_STATE_CONFIG2           0x0c
>  #define QPHY_V5_PCS_PCIE_POWER_STATE_CONFIG4           0x14
>  #define QPHY_V5_PCS_PCIE_ENDPOINT_REFCLK_DRIVE         0x20
> +#define QPHY_V5_PCS_PCIE_ENDPOINT_REFCLK_CNTRL         0x24
>  #define QPHY_V5_PCS_PCIE_INT_AUX_CLK_CONFIG1           0x54
>  #define QPHY_V5_PCS_PCIE_OSC_DTCT_ACTIONS              0x94
>  #define QPHY_V5_PCS_PCIE_EQ_CONFIG2                    0xa8
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5_20.h b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5_20.h
> index cdf8c04ea078..8b114e538a07 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5_20.h
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5_20.h
> @@ -9,6 +9,7 @@
>  /* Only for QMP V5_20 PHY - PCIe PCS registers */
>  #define QPHY_V5_20_PCS_PCIE_POWER_STATE_CONFIG2                0x00c
>  #define QPHY_V5_20_PCS_PCIE_ENDPOINT_REFCLK_DRIVE      0x01c
> +#define QPHY_V5_20_PCS_PCIE_ENDPOINT_REFCLK_CNTRL      0x020
>  #define QPHY_V5_20_PCS_PCIE_OSC_DTCT_MODE2_CONFIG5     0x084
>  #define QPHY_V5_20_PCS_PCIE_OSC_DTCT_ACTIONS           0x090
>  #define QPHY_V5_20_PCS_PCIE_EQ_CONFIG1                 0x0a0
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6_20.h b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6_20.h
> index e3eb08776339..f7abe95c49ad 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6_20.h
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6_20.h
> @@ -10,6 +10,7 @@
>  #define QPHY_PCIE_V6_20_PCS_POWER_STATE_CONFIG2                0x00c
>  #define QPHY_PCIE_V6_20_PCS_TX_RX_CONFIG               0x018
>  #define QPHY_PCIE_V6_20_PCS_ENDPOINT_REFCLK_DRIVE      0x01c
> +#define QPHY_PCIE_V6_20_PCS_ENDPOINT_REFCLK_CNTRL      0x020
>  #define QPHY_PCIE_V6_20_PCS_OSC_DTCT_ATCIONS           0x090
>  #define QPHY_PCIE_V6_20_PCS_EQ_CONFIG1                 0x0a0
>  #define QPHY_PCIE_V6_20_PCS_EQ_CONFIG5                 0x108
>
> --
> 2.42.0
>
>


-- 
With best wishes
Dmitry
