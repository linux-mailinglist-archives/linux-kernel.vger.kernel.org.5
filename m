Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82854751CE7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 11:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234028AbjGMJMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 05:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233794AbjGMJLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 05:11:54 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FFD830D7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 02:11:32 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-cae0ad435b6so450467276.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 02:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689239492; x=1689844292;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9ebla1Hy2cfGq8vBoYZqdjQXwj7cKAKTYal988VWPzM=;
        b=o1qQqyPeAixcFeHFoVgUcWEu21CrnhSTS3XGWj6hGv8wp900A1+cdhvNr9B+pKSBbj
         2sgsFjySkFolgZ/VtCJ4wW5wretUtE0TtimgUf+YyV3Q7Gkh7PDxI/F4cyOMEc4C0s7I
         kzSDy0ZOmjhq16bwiuUyJwjKC/ncUDmEzSzrzoZEuFnGakREoH/49vWhiDDeIWZWq/Ds
         wmusqePPguHMvtoEO9SGFy33EuDA84kxyzae+I3YLauOIt09cc3i/O7fej1piHa2hejE
         R9CQELoN6x+UpDxBOnk7JWFw7pNVXCg3x41RDhwrN5HC3SW/G+GvQT1Yxv66rtft5BlV
         IfLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689239492; x=1689844292;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9ebla1Hy2cfGq8vBoYZqdjQXwj7cKAKTYal988VWPzM=;
        b=GFrilAIxqZv4Ro7M2M9R2GQSgQAlqu7BLys9bqXRNYXMVIah6597cne9yUWJleNQGo
         fULHHZpTYPT1Nv2Za2Wybgl1D7jwVsHrTjrygbssEEEAGe/X7FrpgBq3tHrHQwF5vkBK
         HoDYJQilWrI5AaYbNU51cH0/9a+E+gh7Rlu/GNxyTJISEntN7Bl8yMarhWSzhq0RwEUf
         icHS1X1lLqo4lHeufbaH3oNQe7dl6t0aq8VcMQY2eQ8bl/vMHtDzXiAUDjQzWj0EecBH
         F4D7c7jjPfZXqTC6j235MM9sQp3ZNhkQFifwBTj6jHw8iukFj5xZO6W/YSo+2CXqHYuO
         3S6w==
X-Gm-Message-State: ABy/qLan8cFchZmxoZfjvRBkQI2L6Bin3cGIRZUIljLkqubJ56O55oJ3
        JDniJkm3I0459e5s/oCVDWqlDIcodQ0mCcmDeG0XMQ==
X-Google-Smtp-Source: APBJJlGAyAkCugH9TyNKtRDca5N7O+C4PLJaAN3Ta0e1DEo79+fYr76EkIKplnW2mQcArMb33w1AebH7W9ODcNXvW+Y=
X-Received: by 2002:a25:dc87:0:b0:cac:e20:90e3 with SMTP id
 y129-20020a25dc87000000b00cac0e2090e3mr701107ybe.63.1689239491789; Thu, 13
 Jul 2023 02:11:31 -0700 (PDT)
MIME-Version: 1.0
References: <1688545032-17748-1-git-send-email-quic_msarkar@quicinc.com>
 <1688545032-17748-5-git-send-email-quic_msarkar@quicinc.com>
 <868f3cbb-31fd-112a-9448-fdb686f812f0@linaro.org> <8fa24cec-ee14-651c-5f28-dcddac4de4c1@quicinc.com>
In-Reply-To: <8fa24cec-ee14-651c-5f28-dcddac4de4c1@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 13 Jul 2023 12:11:20 +0300
Message-ID: <CAA8EJpoZMWm0-hJo7NqJ1vBGom_vGa0Udf2CzT6AfbpVmmN-Tw@mail.gmail.com>
Subject: Re: [PATCH v1 4/6] phy: qcom-qmp-pcie: add support for sa8775p
To:     Mrinmay Sarkar <quic_msarkar@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        konrad.dybcio@linaro.org, mani@kernel.org,
        quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
        quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jul 2023 at 10:00, Mrinmay Sarkar <quic_msarkar@quicinc.com> wrote:
>
>
> On 7/6/2023 8:23 PM, Dmitry Baryshkov wrote:
> > On 05/07/2023 11:17, Mrinmay Sarkar wrote:
> >> Add support for dual and four lane PHY found on sa8755p platform.
> >>
> >> Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
> >> ---
> >>   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c      | 328 ++++++++++++++++++
> >>   .../qualcomm/phy-qcom-qmp-pcs-pcie-v5_20.h    |   1 +
> >>   .../phy-qcom-qmp-qserdes-txrx-v5_20.h         |   2 +
> >>   3 files changed, 331 insertions(+)
> >>
> >> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> >> b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> >> index df505279edfd..0d72e2f4dcfb 100644
> >> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> >> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> >> @@ -1910,6 +1910,244 @@ static const struct qmp_phy_init_tbl
> >> sm8550_qmp_gen4x2_pcie_pcs_misc_tbl[] = {
> >>       QMP_PHY_INIT_CFG(QPHY_PCIE_V6_20_PCS_G4_FOM_EQ_CONFIG5, 0xf2),
> >>   };
> >>   +static const struct qmp_phy_init_tbl
> >> sa8775p_qmp_gen4x2_pcie_serdes_alt_tbl[] = {
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_COM_BIAS_EN_CLKBUFLR_EN, 0x14),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_COM_PLL_IVCO, 0x0f),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_COM_LOCK_CMP_EN, 0x46),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_COM_LOCK_CMP_CFG, 0x04),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_COM_VCO_TUNE_MAP, 0x02),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_COM_HSCLK_SEL, 0x12),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_COM_HSCLK_HS_SWITCH_SEL, 0x00),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_COM_CORECLK_DIV_MODE0, 0x0a),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_COM_CORECLK_DIV_MODE1, 0x04),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_COM_CMN_MISC1, 0x88),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_COM_CORE_CLK_EN, 0x60),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_COM_CMN_CONFIG, 0x06),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_COM_CMN_MODE, 0x14),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_COM_VCO_DC_LEVEL_CTRL, 0x0f),
> >> +};
> >> +
> >> +static const struct qmp_phy_init_tbl
> >> sa8775p_qmp_gen4x2_pcie_rc_serdes_alt_tbl[] = {
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_COM_SSC_EN_CENTER, 0x00),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_COM_SSC_PER1, 0x31),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_COM_SSC_PER2, 0x01),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_COM_SSC_STEP_SIZE1_MODE0, 0xde),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_COM_SSC_STEP_SIZE2_MODE0, 0x07),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_COM_SSC_STEP_SIZE1_MODE1, 0x97),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_COM_SSC_STEP_SIZE2_MODE1, 0x0c),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_COM_CLK_ENABLE1, 0x90),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_COM_CP_CTRL_MODE0, 0x06),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_COM_CP_CTRL_MODE1, 0x06),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_COM_PLL_RCTRL_MODE0, 0x16),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_COM_PLL_RCTRL_MODE1, 0x16),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_COM_PLL_CCTRL_MODE0, 0x36),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_COM_PLL_CCTRL_MODE1, 0x36),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_COM_SYSCLK_EN_SEL, 0x08),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_COM_LOCK_CMP1_MODE0, 0x0a),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_COM_LOCK_CMP2_MODE0, 0x1a),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_COM_LOCK_CMP1_MODE1, 0x14),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_COM_LOCK_CMP2_MODE1, 0x34),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_COM_DEC_START_MODE0, 0x82),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_COM_DEC_START_MODE1, 0xd0),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_COM_DIV_FRAC_START1_MODE0, 0x55),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_COM_DIV_FRAC_START2_MODE0, 0x55),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_COM_DIV_FRAC_START3_MODE0, 0x03),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_COM_DIV_FRAC_START1_MODE1, 0x55),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_COM_DIV_FRAC_START2_MODE1, 0x55),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_COM_DIV_FRAC_START3_MODE1, 0x05),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_COM_CLK_SELECT, 0x34),
> >> +};
> >> +
> >> +static const struct qmp_phy_init_tbl
> >> sa8775p_qmp_gen4x2_pcie_rx_alt_tbl[] = {
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_UCDR_PI_CONTROLS, 0x16),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_DFE_CTLE_POST_CAL_OFFSET, 0x38),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MODE_RATE_0_1_B0, 0x9a),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MODE_RATE_0_1_B1, 0xb0),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MODE_RATE_0_1_B2, 0x92),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MODE_RATE_0_1_B3, 0xf0),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MODE_RATE_0_1_B4, 0x42),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MODE_RATE_0_1_B5, 0x99),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MODE_RATE_0_1_B6, 0x29),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MODE_RATE2_B0, 0x9a),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MODE_RATE2_B1, 0xfb),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MODE_RATE2_B2, 0x92),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MODE_RATE2_B3, 0xec),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MODE_RATE2_B4, 0x43),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MODE_RATE2_B5, 0xdd),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MODE_RATE2_B6, 0x0d),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MODE_RATE3_B0, 0xf3),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MODE_RATE3_B1, 0xf8),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MODE_RATE3_B2, 0xec),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MODE_RATE3_B3, 0xd6),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MODE_RATE3_B4, 0x83),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MODE_RATE3_B5, 0xf5),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MODE_RATE3_B6, 0x5e),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_PHPRE_CTRL, 0x20),
> >> + QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_AUX_DATA_THRESH_BIN_RATE_0_1, 0x3f),
> >> + QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_AUX_DATA_THRESH_BIN_RATE_2_3, 0x37),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_DFE_3, 0x00),
> >> + QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MARG_COARSE_THRESH1_RATE3, 0x1f),
> >> + QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MARG_COARSE_THRESH2_RATE3, 0x1f),
> >> + QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MARG_COARSE_THRESH3_RATE3, 0x1f),
> >> + QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MARG_COARSE_THRESH4_RATE3, 0x1f),
> >> + QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MARG_COARSE_THRESH5_RATE3, 0x1f),
> >> + QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MARG_COARSE_THRESH6_RATE3, 0x1f),
> >> + QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MARG_COARSE_THRESH1_RATE210,
> >> 0x1f),
> >> + QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MARG_COARSE_THRESH2_RATE210,
> >> 0x1f),
> >> + QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MARG_COARSE_THRESH3_RATE210,
> >> 0x1f),
> >> + QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_Q_PI_INTRINSIC_BIAS_RATE32, 0x09),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_UCDR_FO_GAIN_RATE2, 0x0c),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_UCDR_FO_GAIN_RATE3, 0x08),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_UCDR_SO_GAIN_RATE3, 0x04),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_VGA_CAL_CNTRL1, 0x04),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_VGA_CAL_MAN_VAL, 0x08),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_EQU_ADAPTOR_CNTRL4, 0x0b),
> >> + QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_EQ_OFFSET_ADAPTOR_CNTRL1, 0x7c),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_IDAC_SAOFFSET, 0x10),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_DFE_DAC_ENABLE1, 0x00),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_GM_CAL, 0x05),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_TX_ADAPT_POST_THRESH1, 0x00),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_TX_ADAPT_POST_THRESH2, 0x1f),
> >> +};
> >> +
> >> +static const struct qmp_phy_init_tbl sa8775p_qmp_gen4_pcie_tx_tbl[] = {
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_20_TX_RES_CODE_LANE_OFFSET_TX, 0x1f),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_20_TX_RES_CODE_LANE_OFFSET_RX, 0x07),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_20_TX_LANE_MODE_1, 0x05),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_20_TX_LANE_MODE_2, 0xf6),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_20_TX_LANE_MODE_3, 0x0f),
> >> +};
> >> +
> >> +static const struct qmp_phy_init_tbl
> >> sa8775p_qmp_gen4_pcie_pcs_misc_tbl[] = {
> >> +    QMP_PHY_INIT_CFG(QPHY_V5_20_PCS_PCIE_EQ_CONFIG1, 0x16),
> >> +    QMP_PHY_INIT_CFG(QPHY_V5_20_PCS_PCIE_G4_EQ_CONFIG5, 0x02),
> >> +    QMP_PHY_INIT_CFG(QPHY_V5_20_PCS_PCIE_G4_PRE_GAIN, 0x2e),
> >> +    QMP_PHY_INIT_CFG(QPHY_V5_20_PCS_PCIE_RX_MARGINING_CONFIG3, 0x28),
> >> +};
> >> +
> >> +static const struct qmp_phy_init_tbl
> >> sa8775p_qmp_gen4_pcie_rc_pcs_misc_tbl[] = {
> >> +    QMP_PHY_INIT_CFG(QPHY_V5_20_PCS_PCIE_POWER_STATE_CONFIG2, 0x1d),
> >> +    QMP_PHY_INIT_CFG(QPHY_V5_20_PCS_PCIE_ENDPOINT_REFCLK_DRIVE, 0xc1),
> >> +    QMP_PHY_INIT_CFG(QPHY_V5_20_PCS_PCIE_OSC_DTCT_ACTIONS, 0x00),
> >> +};
> >> +
> >> +static const struct qmp_phy_init_tbl
> >> sa8775p_qmp_gen4x2_pcie_pcs_alt_tbl[] = {
> >> +    QMP_PHY_INIT_CFG(QPHY_V5_20_PCS_EQ_CONFIG4, 0x16),
> >> +    QMP_PHY_INIT_CFG(QPHY_V5_20_PCS_EQ_CONFIG5, 0x22),
> >> +    QMP_PHY_INIT_CFG(QPHY_V5_20_PCS_LANE1_INSIG_SW_CTRL2, 0x00),
> >> +    QMP_PHY_INIT_CFG(QPHY_V5_20_PCS_LANE1_INSIG_MX_CTRL2, 0x00),
> >> +    QMP_PHY_INIT_CFG(QPHY_V5_20_PCS_G3S2_PRE_GAIN, 0x2e),
> >> +    QMP_PHY_INIT_CFG(QPHY_V5_20_PCS_RX_SIGDET_LVL, 0x66),
> >> +};
> >> +
> >> +static const struct qmp_phy_init_tbl
> >> sa8775p_qmp_gen4x4_pcie_rx_alt_tbl[] = {
> >> + QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_AUX_DATA_THRESH_BIN_RATE_0_1, 0x3f),
> >> + QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_AUX_DATA_THRESH_BIN_RATE_2_3, 0x37),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_DFE_3, 0x00),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_DFE_CTLE_POST_CAL_OFFSET, 0x38),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_DFE_DAC_ENABLE1, 0x00),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_GM_CAL, 0x05),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_PHPRE_CTRL, 0x20),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_EQU_ADAPTOR_CNTRL4, 0x0b),
> >> + QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_EQ_OFFSET_ADAPTOR_CNTRL1, 0x7c),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_IDAC_SAOFFSET, 0x10),
> >> + QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MARG_COARSE_THRESH1_RATE210,
> >> 0x1f),
> >> + QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MARG_COARSE_THRESH1_RATE3, 0x1f),
> >> + QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MARG_COARSE_THRESH2_RATE210,
> >> 0x1f),
> >> + QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MARG_COARSE_THRESH2_RATE3, 0x1f),
> >> + QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MARG_COARSE_THRESH3_RATE210,
> >> 0x1f),
> >> + QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MARG_COARSE_THRESH3_RATE3, 0x1f),
> >> + QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MARG_COARSE_THRESH4_RATE3, 0x1f),
> >> + QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MARG_COARSE_THRESH5_RATE3, 0x1f),
> >> + QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MARG_COARSE_THRESH6_RATE3, 0x1f),
> >> + QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_Q_PI_INTRINSIC_BIAS_RATE32, 0x09),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MODE_RATE_0_1_B0, 0x99),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MODE_RATE_0_1_B1, 0xb0),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MODE_RATE_0_1_B2, 0x92),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MODE_RATE_0_1_B3, 0xf0),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MODE_RATE_0_1_B4, 0x42),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MODE_RATE_0_1_B5, 0x00),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MODE_RATE_0_1_B6, 0x20),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MODE_RATE2_B0, 0x9a),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MODE_RATE2_B1, 0xb6),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MODE_RATE2_B2, 0x92),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MODE_RATE2_B3, 0xf0),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MODE_RATE2_B4, 0x43),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MODE_RATE2_B5, 0xdd),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MODE_RATE2_B6, 0x0d),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MODE_RATE3_B0, 0xf3),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MODE_RATE3_B1, 0xf6),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MODE_RATE3_B2, 0xee),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MODE_RATE3_B3, 0xd2),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MODE_RATE3_B4, 0x83),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MODE_RATE3_B5, 0xf9),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_RX_MODE_RATE3_B6, 0x3d),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_TX_ADAPT_POST_THRESH1, 0x00),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_TX_ADAPT_POST_THRESH2, 0x1f),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_UCDR_FO_GAIN_RATE2, 0x0c),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_UCDR_FO_GAIN_RATE3, 0x08),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_UCDR_SO_GAIN_RATE3, 0x04),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_UCDR_PI_CONTROLS, 0x16),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_VGA_CAL_CNTRL1, 0x04),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_20_RX_VGA_CAL_MAN_VAL, 0x08),
> >> +};
> >> +
> >> +static const struct qmp_phy_init_tbl
> >> sa8775p_qmp_gen4x4_pcie_pcs_alt_tbl[] = {
> >> +    QMP_PHY_INIT_CFG(QPHY_V5_20_PCS_EQ_CONFIG4, 0x16),
> >> +    QMP_PHY_INIT_CFG(QPHY_V5_20_PCS_EQ_CONFIG5, 0x22),
> >> +    QMP_PHY_INIT_CFG(QPHY_V5_20_PCS_G3S2_PRE_GAIN, 0x2e),
> >> +    QMP_PHY_INIT_CFG(QPHY_V5_20_PCS_RX_SIGDET_LVL, 0x66),
> >> +};
> >> +
> >> +static const struct qmp_phy_init_tbl
> >> sa8775p_qmp_gen4x4_pcie_serdes_alt_tbl[] = {
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_COM_PLL_IVCO, 0x0f),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_COM_PLL_CCTRL_MODE0, 0x36),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_COM_PLL_CCTRL_MODE1, 0x36),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_COM_LOCK_CMP_EN, 0x46),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_COM_LOCK_CMP_CFG, 0x04),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_COM_VCO_TUNE_MAP, 0x02),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_COM_HSCLK_SEL, 0x12),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_COM_HSCLK_HS_SWITCH_SEL, 0x00),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_COM_CORECLK_DIV_MODE0, 0x0a),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_COM_CORECLK_DIV_MODE1, 0x04),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_COM_CMN_MISC1, 0x88),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_COM_CORE_CLK_EN, 0x60),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_COM_CMN_CONFIG, 0x06),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_COM_CMN_MODE, 0x14),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_COM_VCO_DC_LEVEL_CTRL, 0x0f),
> >> +};
> >> +
> >> +
> >> +static const struct qmp_phy_init_tbl
> >> sa8775p_qmp_gen4x4_pcie_rc_serdes_alt_tbl[] = {
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_COM_SSC_EN_CENTER, 0x00),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_COM_SSC_PER1, 0x31),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_COM_SSC_PER2, 0x01),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_COM_SSC_STEP_SIZE1_MODE0, 0xde),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_COM_SSC_STEP_SIZE2_MODE0, 0x07),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_COM_SSC_STEP_SIZE1_MODE1, 0x97),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_COM_SSC_STEP_SIZE2_MODE1, 0x0c),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_COM_BIAS_EN_CLKBUFLR_EN, 0x1c),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_COM_CLK_ENABLE1, 0x90),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_COM_CP_CTRL_MODE0, 0x06),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_COM_CP_CTRL_MODE1, 0x06),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_COM_PLL_RCTRL_MODE0, 0x16),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_COM_PLL_RCTRL_MODE1, 0x16),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_COM_SYSCLK_EN_SEL, 0x08),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_COM_LOCK_CMP1_MODE0, 0x0a),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_COM_LOCK_CMP2_MODE0, 0x1a),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_COM_LOCK_CMP1_MODE1, 0x14),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_COM_LOCK_CMP2_MODE1, 0x34),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_COM_DEC_START_MODE0, 0x82),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_COM_DEC_START_MODE1, 0xd0),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_COM_DIV_FRAC_START1_MODE0, 0x55),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_COM_DIV_FRAC_START2_MODE0, 0x55),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_COM_DIV_FRAC_START3_MODE0, 0x03),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_COM_DIV_FRAC_START1_MODE1, 0x55),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_COM_DIV_FRAC_START2_MODE1, 0x55),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_COM_DIV_FRAC_START3_MODE1, 0x05),
> >> +    QMP_PHY_INIT_CFG(QSERDES_V5_COM_CLK_SELECT, 0x34),
> >> +};
> >> +
> >>   struct qmp_pcie_offsets {
> >>       u16 serdes;
> >>       u16 pcs;
> >> @@ -2054,6 +2292,10 @@ static const char * const
> >> sdm845_pciephy_clk_l[] = {
> >>       "aux", "cfg_ahb", "ref", "refgen",
> >>   };
> >>   +static const char * const sa8775p_pciephy_clk_l[] = {
> >> +    "aux", "cfg_ahb", "ref", "rchng", "phy_aux",
> >> +};
> >> +
> >>   /* list of regulators */
> >>   static const char * const qmp_phy_vreg_l[] = {
> >>       "vdda-phy", "vdda-pll",
> >> @@ -2093,6 +2335,14 @@ static const struct qmp_pcie_offsets
> >> qmp_pcie_offsets_v6_20 = {
> >>       .ln_shrd    = 0x0e00,
> >>   };
> >>   +static const struct qmp_pcie_offsets qmp_pcie_offsets_v6 = {
> >> +    .serdes        = 0x2000,
> >> +    .pcs        = 0x2200,
> >> +    .pcs_misc    = 0x2400,
> >> +    .tx        = 0x3800,
> >> +    .rx        = 0x3a00,
> >
> > This does not seem correct to me. What ocuppies the offset 0x0?
> offset 0x0 occupies TX0_QSERDES_TX0_PCIE4(tx0) register but as per
> PHY sequence to support gen4X4 we need to use
> TXZ_QSERDES_TXZ_PCIE4_4L_QMP_TXZ for tx.

ok.

Don't you need to provide .tx2 / .rx2 then? qmp_pcie_init_registers()
writes tx2/rx2 regions if (lanes >= 2).

> >> +};
> >> +
> >>   static const struct qmp_phy_cfg ipq8074_pciephy_cfg = {
> >>       .lanes            = 1,
> >>   @@ -2743,6 +2993,78 @@ static const struct qmp_phy_cfg
> >> sm8550_qmp_gen4x2_pciephy_cfg = {
> >>       .has_nocsr_reset    = true,
> >>   };
> >>   +static const struct qmp_phy_cfg sa8775p_qmp_gen4x2_pciephy_cfg = {
> >> +    .lanes            = 2,
> >> +    .offsets        = &qmp_pcie_offsets_v6_20,
> >
> > Please split out a separate v5_20 offsets entry. We might merge them
> > later, but for now it seems cleaner to have separate per-version entries.
>
> Here we are using already existing qmp_pcie_offsets_v6_20 offset that
> matches exactly same offsets as sa8775p for gen4x2 . so we are reusing it.
> rather creating separate entry.

Please either rename v6_20 to v5_20 or add a separate instance (my
preference would be for the latter). We have some duplication around
registers defs and offsets to catch version mismatches.

>
> >
> >> +
> >> +    .tbls = {
> >> +        .serdes        = sa8775p_qmp_gen4x2_pcie_serdes_alt_tbl,
> >> +        .serdes_num        =
> >> ARRAY_SIZE(sa8775p_qmp_gen4x2_pcie_serdes_alt_tbl),
> >> +        .tx        = sa8775p_qmp_gen4_pcie_tx_tbl,
> >> +        .tx_num        = ARRAY_SIZE(sa8775p_qmp_gen4_pcie_tx_tbl),
> >> +        .rx        = sa8775p_qmp_gen4x2_pcie_rx_alt_tbl,
> >> +        .rx_num        =
> >> ARRAY_SIZE(sa8775p_qmp_gen4x2_pcie_rx_alt_tbl),
> >> +        .pcs        = sa8775p_qmp_gen4x2_pcie_pcs_alt_tbl,
> >> +        .pcs_num        =
> >> ARRAY_SIZE(sa8775p_qmp_gen4x2_pcie_pcs_alt_tbl),
> >> +        .pcs_misc        = sa8775p_qmp_gen4_pcie_pcs_misc_tbl,
> >> +        .pcs_misc_num    =
> >> ARRAY_SIZE(sa8775p_qmp_gen4_pcie_pcs_misc_tbl),
> >> +    },
> >> +
> >> +    .tbls_rc = &(const struct qmp_phy_cfg_tbls) {
> >> +        .serdes        = sa8775p_qmp_gen4x2_pcie_rc_serdes_alt_tbl,
> >> +        .serdes_num    =
> >> ARRAY_SIZE(sa8775p_qmp_gen4x2_pcie_rc_serdes_alt_tbl),
> >> +        .pcs_misc    = sa8775p_qmp_gen4_pcie_rc_pcs_misc_tbl,
> >> +        .pcs_misc_num    =
> >> ARRAY_SIZE(sa8775p_qmp_gen4_pcie_rc_pcs_misc_tbl),
> >> +    },
> >> +
> >> +    .clk_list        = sa8775p_pciephy_clk_l,
> >> +    .num_clks        = ARRAY_SIZE(sa8775p_pciephy_clk_l),
> >> +    .reset_list        = sdm845_pciephy_reset_l,
> >> +    .num_resets        = ARRAY_SIZE(sdm845_pciephy_reset_l),
> >> +    .vreg_list        = qmp_phy_vreg_l,
> >> +    .num_vregs        = ARRAY_SIZE(qmp_phy_vreg_l),
> >> +    .regs            = pciephy_v5_regs_layout,
> >> +
> >> +    .pwrdn_ctrl        = SW_PWRDN | REFCLK_DRV_DSBL,
> >> +    .phy_status        = PHYSTATUS_4_20,
> >> +};
> >> +
> >> +static const struct qmp_phy_cfg sa8775p_qmp_gen4x4_pciephy_cfg = {
> >> +    .lanes = 4,
> >> +    .offsets        = &qmp_pcie_offsets_v6,
> >> +
> >> +    .tbls = {
> >> +        .serdes        = sa8775p_qmp_gen4x4_pcie_serdes_alt_tbl,
> >> +        .serdes_num        =
> >> ARRAY_SIZE(sa8775p_qmp_gen4x4_pcie_serdes_alt_tbl),
> >> +        .tx        = sa8775p_qmp_gen4_pcie_tx_tbl,
> >> +        .tx_num        = ARRAY_SIZE(sa8775p_qmp_gen4_pcie_tx_tbl),
> >> +        .rx            = sa8775p_qmp_gen4x4_pcie_rx_alt_tbl,
> >> +        .rx_num        =
> >> ARRAY_SIZE(sa8775p_qmp_gen4x4_pcie_rx_alt_tbl),
> >> +        .pcs        = sa8775p_qmp_gen4x4_pcie_pcs_alt_tbl,
> >> +        .pcs_num        =
> >> ARRAY_SIZE(sa8775p_qmp_gen4x4_pcie_pcs_alt_tbl),
> >> +        .pcs_misc        = sa8775p_qmp_gen4_pcie_pcs_misc_tbl,
> >> +        .pcs_misc_num    =
> >> ARRAY_SIZE(sa8775p_qmp_gen4_pcie_pcs_misc_tbl),
> >> +    },
> >> +
> >> +    .tbls_rc = &(const struct qmp_phy_cfg_tbls) {
> >> +        .serdes        = sa8775p_qmp_gen4x4_pcie_rc_serdes_alt_tbl,
> >> +        .serdes_num    =
> >> ARRAY_SIZE(sa8775p_qmp_gen4x4_pcie_rc_serdes_alt_tbl),
> >> +        .pcs_misc    = sa8775p_qmp_gen4_pcie_rc_pcs_misc_tbl,
> >> +        .pcs_misc_num    =
> >> ARRAY_SIZE(sa8775p_qmp_gen4_pcie_rc_pcs_misc_tbl),
> >> +    },
> >> +
> >> +    .clk_list        = sa8775p_pciephy_clk_l,
> >> +    .num_clks        = ARRAY_SIZE(sa8775p_pciephy_clk_l),
> >> +    .reset_list        = sdm845_pciephy_reset_l,
> >> +    .num_resets        = ARRAY_SIZE(sdm845_pciephy_reset_l),
> >> +    .vreg_list        = qmp_phy_vreg_l,
> >> +    .num_vregs        = ARRAY_SIZE(qmp_phy_vreg_l),
> >> +    .regs            = pciephy_v5_regs_layout,
> >> +
> >> +    .pwrdn_ctrl        = SW_PWRDN | REFCLK_DRV_DSBL,
> >> +    .phy_status        = PHYSTATUS_4_20,
> >> +};
> >> +
> >>   static void qmp_pcie_configure_lane(void __iomem *base,
> >>                       const struct qmp_phy_init_tbl tbl[],
> >>                       int num,
> >> @@ -3428,6 +3750,12 @@ static const struct of_device_id
> >> qmp_pcie_of_match_table[] = {
> >>       }, {
> >>           .compatible = "qcom,sm8550-qmp-gen4x2-pcie-phy",
> >>           .data = &sm8550_qmp_gen4x2_pciephy_cfg,
> >> +    }, {
> >> +        .compatible = "qcom,sa8775p-qmp-gen4x2-pcie-phy",
> >> +        .data = &sa8775p_qmp_gen4x2_pciephy_cfg,
> >> +    }, {
> >> +        .compatible = "qcom,sa8775p-qmp-gen4x4-pcie-phy",
> >> +        .data = &sa8775p_qmp_gen4x4_pciephy_cfg,
> >>       },
> >>       { },
> >>   };
> >> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5_20.h
> >> b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5_20.h
> >> index a3a056741fc7..cdf8c04ea078 100644
> >> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5_20.h
> >> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5_20.h
> >> @@ -7,6 +7,7 @@
> >>   #define QCOM_PHY_QMP_PCS_PCIE_V5_20_H_
> >>     /* Only for QMP V5_20 PHY - PCIe PCS registers */
> >> +#define QPHY_V5_20_PCS_PCIE_POWER_STATE_CONFIG2        0x00c
> >>   #define QPHY_V5_20_PCS_PCIE_ENDPOINT_REFCLK_DRIVE    0x01c
> >>   #define QPHY_V5_20_PCS_PCIE_OSC_DTCT_MODE2_CONFIG5    0x084
> >>   #define QPHY_V5_20_PCS_PCIE_OSC_DTCT_ACTIONS        0x090
> >> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v5_20.h
> >> b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v5_20.h
> >> index c7b12c1fb7f5..cf91154eed13 100644
> >> --- a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v5_20.h
> >> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v5_20.h
> >> @@ -19,6 +19,7 @@
> >>   /* Only for QMP V5_20 PHY - RX registers */
> >>   #define QSERDES_V5_20_RX_UCDR_FO_GAIN_RATE2        0x008
> >>   #define QSERDES_V5_20_RX_UCDR_FO_GAIN_RATE3        0x00c
> >> +#define QSERDES_V5_20_RX_UCDR_SO_GAIN_RATE3        0x01c
> >>   #define QSERDES_V5_20_RX_UCDR_PI_CONTROLS        0x020
> >>   #define QSERDES_V5_20_RX_AUX_DATA_THRESH_BIN_RATE_0_1    0x02c
> >>   #define QSERDES_V5_20_RX_AUX_DATA_THRESH_BIN_RATE_2_3    0x030
> >> @@ -80,5 +81,6 @@
> >>   #define QSERDES_V5_20_RX_RX_MARG_COARSE_THRESH4_RATE3    0x210
> >>   #define QSERDES_V5_20_RX_RX_MARG_COARSE_THRESH5_RATE3    0x218
> >>   #define QSERDES_V5_20_RX_RX_MARG_COARSE_THRESH6_RATE3    0x220
> >> +#define QSERDES_V5_20_RX_Q_PI_INTRINSIC_BIAS_RATE32    0x238
> >>     #endif
>
>
> Thanks,
> Mrinmay



-- 
With best wishes
Dmitry
