Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3BF07E66FE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 10:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbjKIJpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 04:45:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjKIJpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 04:45:15 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3619C271F
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 01:45:13 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-da2b9234a9fso719630276.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 01:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699523112; x=1700127912; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m3j1z3JdsTrjV1Ga7OJY3GeweZCLOf9hKt+iEco6J78=;
        b=JkRCM3GMerYL5k7sGGMOfzzUuiAIGO4PdZi3yYSwYcXQtkwrdJTDKdTo+7hBbPtsYg
         rAmp1+gc9Ox1AHEt9BYFw/GFVsAksHiUQmRcHs9MMKatMfEXz/b/Ln7E1aHx7N9WfcwC
         e1l+LRv6GFgCdb5eqrChrkaEP9l01Begh5tFa04Pvl/trchP3f5KPjlwmLvc//IgVNxw
         7pYtgOpLpEc3xN6F4uoqI9S8t8pxMui/Y7jFvbSYGLJ2nn6f+P818e+8jzsuPTyUGkZk
         P6ub0qK5CrmsCuP1zKp6VqnkTtBoJUkkQPUt2v+6p3ZmLgo/8zm2j/iqrhd2yjF7h2ga
         UXGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699523112; x=1700127912;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m3j1z3JdsTrjV1Ga7OJY3GeweZCLOf9hKt+iEco6J78=;
        b=moTE93DMpyWDCZUP0hrSjXN320idG9ukZcj8UjTL/jTM7BbEpwnQtcbEaLYtVUu79L
         MmQ6CXJ15nzpZfOqsSv2Hp0RbtULfes6KWYDysruE/tjPXR1ffT/fFhamAr0OG0ngcGD
         RPB+Rih7equQ1e/6wKPuQoANfFjNlLMWZnLuvIBktN8HPjLttS8T4setC9/5cUee1PvK
         uoJzrC5YZaZF9o1AneakKqY/RgVaFiS5egHpOewN7bopc84hTGLI7H8WO2DV2Xl9+C7c
         NDgg0imE/nY1EzqDipJVhBmHoRyAbFYfDRiDCgXRqWCFsa2Oi/vloPRqEC507tzrsGG8
         r9HA==
X-Gm-Message-State: AOJu0YzM3V/zFKM+eNiksUe1e3yPVD4y6/OK4qe08hnY+NhSsDxkFj5b
        +wNT3c5jPyaWKND0oKDdXleGLOSmQSxgtLuWGOhjWg==
X-Google-Smtp-Source: AGHT+IHsxENxFKAe6hQ6iaJ1WQ/sXmmaQU8ry7Cn4q0Z5XlzXmgqzaQ8cqMSayf6tlAVYKaoDwiwsSz7RpEzRHnY8kE=
X-Received: by 2002:a25:d110:0:b0:da0:6cf3:c629 with SMTP id
 i16-20020a25d110000000b00da06cf3c629mr4322026ybg.41.1699523112296; Thu, 09
 Nov 2023 01:45:12 -0800 (PST)
MIME-Version: 1.0
References: <20231107-refclk_always_on-v2-0-de23962fc4b3@quicinc.com>
 <20231107-refclk_always_on-v2-2-de23962fc4b3@quicinc.com> <CAA8EJpr8Y+k2FJqFfZVagWxfgsUEnZ1010-xaaUg=c6tqu8Hsw@mail.gmail.com>
 <d2556aad-24cc-c0d1-d71d-bf43bc832036@quicinc.com>
In-Reply-To: <d2556aad-24cc-c0d1-d71d-bf43bc832036@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 9 Nov 2023 11:45:00 +0200
Message-ID: <CAA8EJppeUpmGsoqueRoq_jo1FnyP6uO8P8egmYpysNcD8A8KAA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] phy: qcom-qmp-pcie: Add endpoint refclk control
 register offset
To:     Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
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
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Nov 2023 at 11:36, Krishna Chaitanya Chundru
<quic_krichai@quicinc.com> wrote:
>
>
> On 11/7/2023 6:36 PM, Dmitry Baryshkov wrote:
> > On Tue, 7 Nov 2023 at 14:26, Krishna chaitanya chundru
> > <quic_krichai@quicinc.com> wrote:
> >> Some platforms needs to keep endpoint refclk always on, for this
> >> purpose add this offset for all the applicable phy versions.
> >>
> >> And also add reg layout for few controllers as we are adding
> >> endpoint refclk control register which changes based upon phy version.
> >>
> >> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >
> >> ---
> >>   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c           | 26 +++++++++++++++++++---
> >>   drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5.h    |  1 +
> >>   drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5_20.h |  1 +
> >>   drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6_20.h |  1 +
> >>   4 files changed, 26 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> >> index a63ca7424974..74d03d217ff2 100644
> >> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> >> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> >> @@ -77,6 +77,7 @@ enum qphy_reg_layout {
> >>          QPHY_START_CTRL,
> >>          QPHY_PCS_STATUS,
> >>          QPHY_PCS_POWER_DOWN_CONTROL,
> >> +       QPHY_PCS_ENDPOINT_REFCLK_CNTRL,
> >>          /* Keep last to ensure regs_layout arrays are properly initialized */
> >>          QPHY_LAYOUT_SIZE
> >>   };
> >> @@ -93,6 +94,7 @@ static const unsigned int pciephy_v3_regs_layout[QPHY_LAYOUT_SIZE] = {
> >>          [QPHY_START_CTRL]               = QPHY_V3_PCS_START_CONTROL,
> >>          [QPHY_PCS_STATUS]               = QPHY_V3_PCS_PCS_STATUS,
> >>          [QPHY_PCS_POWER_DOWN_CONTROL]   = QPHY_V3_PCS_POWER_DOWN_CONTROL,
> >> +       [QPHY_PCS_ENDPOINT_REFCLK_CNTRL]        = QPHY_V3_PCS_ENDPOINT_REFCLK_CNTRL,
> >>   };
> >>
> >>   static const unsigned int sdm845_qhp_pciephy_regs_layout[QPHY_LAYOUT_SIZE] = {
> >> @@ -107,6 +109,7 @@ static const unsigned int pciephy_v4_regs_layout[QPHY_LAYOUT_SIZE] = {
> >>          [QPHY_START_CTRL]               = QPHY_V4_PCS_START_CONTROL,
> >>          [QPHY_PCS_STATUS]               = QPHY_V4_PCS_PCS_STATUS1,
> >>          [QPHY_PCS_POWER_DOWN_CONTROL]   = QPHY_V4_PCS_POWER_DOWN_CONTROL,
> >> +       [QPHY_PCS_ENDPOINT_REFCLK_CNTRL]        = QPHY_V4_PCS_PCIE_ENDPOINT_REFCLK_CNTRL,
> >>   };
> >>
> >>   static const unsigned int pciephy_v5_regs_layout[QPHY_LAYOUT_SIZE] = {
> >> @@ -114,6 +117,23 @@ static const unsigned int pciephy_v5_regs_layout[QPHY_LAYOUT_SIZE] = {
> >>          [QPHY_START_CTRL]               = QPHY_V5_PCS_START_CONTROL,
> >>          [QPHY_PCS_STATUS]               = QPHY_V5_PCS_PCS_STATUS1,
> >>          [QPHY_PCS_POWER_DOWN_CONTROL]   = QPHY_V5_PCS_POWER_DOWN_CONTROL,
> >> +       [QPHY_PCS_ENDPOINT_REFCLK_CNTRL]        = QPHY_V5_PCS_PCIE_ENDPOINT_REFCLK_CNTRL,
> >> +};
> >> +
> >> +static const unsigned int pciephy_v5_20_regs_layout[QPHY_LAYOUT_SIZE] = {
> >> +       [QPHY_SW_RESET]                 = QPHY_V5_PCS_SW_RESET,
> >> +       [QPHY_START_CTRL]               = QPHY_V5_PCS_START_CONTROL,
> >> +       [QPHY_PCS_STATUS]               = QPHY_V5_PCS_PCS_STATUS1,
> >> +       [QPHY_PCS_POWER_DOWN_CONTROL]   = QPHY_V5_PCS_POWER_DOWN_CONTROL,
> > Nit: we should probably define V5_20 and v6_20 versions of these registers
>
> We don't have separate defines for v5_20 and v6_20 for these registers,
> that is why we are using these.
>
> And the offsets are same for those version. That is why I tried to use
> macros.

Mixing versions in a single table can quickly lead to a disaster.

>
> - Krishna Chaitanya.
>
> > If you were to send v3 for any reason, could you please add them?
> >
> >> +       [QPHY_PCS_ENDPOINT_REFCLK_CNTRL]        = QPHY_V5_20_PCS_PCIE_ENDPOINT_REFCLK_CNTRL,
> >> +};
> >> +
> >> +static const unsigned int pciephy_v6_20_regs_layout[QPHY_LAYOUT_SIZE] = {
> >> +       [QPHY_SW_RESET]                 = QPHY_V5_PCS_SW_RESET,
> >> +       [QPHY_START_CTRL]               = QPHY_V5_PCS_START_CONTROL,
> >> +       [QPHY_PCS_STATUS]               = QPHY_V5_PCS_PCS_STATUS1,
> >> +       [QPHY_PCS_POWER_DOWN_CONTROL]   = QPHY_V5_PCS_POWER_DOWN_CONTROL,
> >> +       [QPHY_PCS_ENDPOINT_REFCLK_CNTRL]        = QPHY_PCIE_V6_20_PCS_ENDPOINT_REFCLK_CNTRL,
> >>   };
> >>
> >>   static const struct qmp_phy_init_tbl msm8998_pcie_serdes_tbl[] = {
> >> @@ -2956,7 +2976,7 @@ static const struct qmp_phy_cfg sm8450_qmp_gen4x2_pciephy_cfg = {
> >>          .num_resets             = ARRAY_SIZE(sdm845_pciephy_reset_l),
> >>          .vreg_list              = qmp_phy_vreg_l,
> >>          .num_vregs              = ARRAY_SIZE(qmp_phy_vreg_l),
> >> -       .regs                   = pciephy_v5_regs_layout,
> >> +       .regs                   = pciephy_v5_20_regs_layout,
> >>
> >>          .pwrdn_ctrl             = SW_PWRDN | REFCLK_DRV_DSBL,
> >>          .phy_status             = PHYSTATUS_4_20,
> >> @@ -3012,7 +3032,7 @@ static const struct qmp_phy_cfg sm8550_qmp_gen4x2_pciephy_cfg = {
> >>          .num_resets             = ARRAY_SIZE(sdm845_pciephy_reset_l),
> >>          .vreg_list              = sm8550_qmp_phy_vreg_l,
> >>          .num_vregs              = ARRAY_SIZE(sm8550_qmp_phy_vreg_l),
> >> -       .regs                   = pciephy_v5_regs_layout,
> >> +       .regs                   = pciephy_v6_20_regs_layout,
> >>
> >>          .pwrdn_ctrl             = SW_PWRDN | REFCLK_DRV_DSBL,
> >>          .phy_status             = PHYSTATUS_4_20,
> >> @@ -3047,7 +3067,7 @@ static const struct qmp_phy_cfg sa8775p_qmp_gen4x2_pciephy_cfg = {
> >>          .num_resets             = ARRAY_SIZE(sdm845_pciephy_reset_l),
> >>          .vreg_list              = qmp_phy_vreg_l,
> >>          .num_vregs              = ARRAY_SIZE(qmp_phy_vreg_l),
> >> -       .regs                   = pciephy_v5_regs_layout,
> >> +       .regs                   = pciephy_v5_20_regs_layout,
> >>
> >>          .pwrdn_ctrl             = SW_PWRDN | REFCLK_DRV_DSBL,
> >>          .phy_status             = PHYSTATUS_4_20,
> >> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5.h b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5.h
> >> index a469ae2a10a1..9b166286afda 100644
> >> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5.h
> >> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5.h
> >> @@ -11,6 +11,7 @@
> >>   #define QPHY_V5_PCS_PCIE_POWER_STATE_CONFIG2           0x0c
> >>   #define QPHY_V5_PCS_PCIE_POWER_STATE_CONFIG4           0x14
> >>   #define QPHY_V5_PCS_PCIE_ENDPOINT_REFCLK_DRIVE         0x20
> >> +#define QPHY_V5_PCS_PCIE_ENDPOINT_REFCLK_CNTRL         0x24
> >>   #define QPHY_V5_PCS_PCIE_INT_AUX_CLK_CONFIG1           0x54
> >>   #define QPHY_V5_PCS_PCIE_OSC_DTCT_ACTIONS              0x94
> >>   #define QPHY_V5_PCS_PCIE_EQ_CONFIG2                    0xa8
> >> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5_20.h b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5_20.h
> >> index cdf8c04ea078..8b114e538a07 100644
> >> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5_20.h
> >> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5_20.h
> >> @@ -9,6 +9,7 @@
> >>   /* Only for QMP V5_20 PHY - PCIe PCS registers */
> >>   #define QPHY_V5_20_PCS_PCIE_POWER_STATE_CONFIG2                0x00c
> >>   #define QPHY_V5_20_PCS_PCIE_ENDPOINT_REFCLK_DRIVE      0x01c
> >> +#define QPHY_V5_20_PCS_PCIE_ENDPOINT_REFCLK_CNTRL      0x020
> >>   #define QPHY_V5_20_PCS_PCIE_OSC_DTCT_MODE2_CONFIG5     0x084
> >>   #define QPHY_V5_20_PCS_PCIE_OSC_DTCT_ACTIONS           0x090
> >>   #define QPHY_V5_20_PCS_PCIE_EQ_CONFIG1                 0x0a0
> >> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6_20.h b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6_20.h
> >> index e3eb08776339..f7abe95c49ad 100644
> >> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6_20.h
> >> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6_20.h
> >> @@ -10,6 +10,7 @@
> >>   #define QPHY_PCIE_V6_20_PCS_POWER_STATE_CONFIG2                0x00c
> >>   #define QPHY_PCIE_V6_20_PCS_TX_RX_CONFIG               0x018
> >>   #define QPHY_PCIE_V6_20_PCS_ENDPOINT_REFCLK_DRIVE      0x01c
> >> +#define QPHY_PCIE_V6_20_PCS_ENDPOINT_REFCLK_CNTRL      0x020
> >>   #define QPHY_PCIE_V6_20_PCS_OSC_DTCT_ATCIONS           0x090
> >>   #define QPHY_PCIE_V6_20_PCS_EQ_CONFIG1                 0x0a0
> >>   #define QPHY_PCIE_V6_20_PCS_EQ_CONFIG5                 0x108
> >>
> >> --
> >> 2.42.0
> >>
> >>
> >



-- 
With best wishes
Dmitry
