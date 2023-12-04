Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 667F98036D4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 15:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235837AbjLDOeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 09:34:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234345AbjLDOdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 09:33:51 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B191BEC
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 06:33:25 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5d4f71f7e9fso30953767b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 06:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701700404; x=1702305204; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dSyhiNr64UTo7+978+Y0sEsbCTjgBZFdWg2FX3TTBfk=;
        b=xaLVGci36T2LTKXjx/atmD8sl2JpUI75dmUypnui+lP4BkJaBi6t5XqgFy9VbVk6D+
         Ca32njIdAcdbuG+jy5agWWYTA1/Nbv60vymBAJF8n62FMvFTl6sRp/rp5nFa2eN3QdKB
         SdmpFHGRhuAeslHWkeJnNfqUuVjqOQZ3vp1Lpf8hLluYD6yxEEqZSj4hudxqJADlk6XM
         0vZ/EB//1Erw5GNYFjxy66jbQz5EdYWsOCqlPeEXgKGK6yaMvqTuAHUeVfPAm4mpT5bS
         pUamhzIJq6/e4VuQZN6JCEHFGESdnNNIZM8cLmeYcGnZx8x2uzdF0nCWZnP5+mE8YEiC
         KANg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701700404; x=1702305204;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dSyhiNr64UTo7+978+Y0sEsbCTjgBZFdWg2FX3TTBfk=;
        b=ZRWOMJg30ioi0EkxuZxXp6FyBWf/THQLbbwljYznLPBLFXMvCe6NRONEYppKQpbpVu
         XxHFYuTGjebjixJP0OiFeuYCPjISvDSA+NZmto44+JJeKcF3a/xK85SHmJybfbLfJwJC
         dACIrWnOehlOqTS8jMoS2f+masE7VhInRqb7H9uviS8qL89QrHXAVE139ZlszFwB4gMM
         DB0BIQw04I3Mfpmm0E3wssSB2GEGyrMaAWiPSTRwKzfLYDnn5lRs3Lg7fbfJnOyOC41K
         hmDki86kX/ZFKx77E8DFMgDj/JLh8Uq5fKfIC+m4VGTnDkw8CPVQaTd6Oz3jFGmtMQck
         5AUQ==
X-Gm-Message-State: AOJu0YyqAF4IijI95hBC/vYBo9IXkm7W0bP2lWVD/5seGpy/jRYcDTgA
        QYG6iL8fYDMVjv4fn60H0p4WUAS+NQmAHeDQVpyOnw==
X-Google-Smtp-Source: AGHT+IFb6Mt++laGEUkgos3vQnmJn3TMArsVCfyJ9mARxtABEg3fRltfZzLdrzd7sG5LAV5TkFELa4x72oDSJETtWfA=
X-Received: by 2002:a81:ae11:0:b0:5d7:1940:dd64 with SMTP id
 m17-20020a81ae11000000b005d71940dd64mr2755208ywh.58.1701700404505; Mon, 04
 Dec 2023 06:33:24 -0800 (PST)
MIME-Version: 1.0
References: <20231122-phy-qualcomm-usb3-uniphy-x1e80100-v2-0-1a3e1d98564e@linaro.org>
 <20231122-phy-qualcomm-usb3-uniphy-x1e80100-v2-2-1a3e1d98564e@linaro.org>
In-Reply-To: <20231122-phy-qualcomm-usb3-uniphy-x1e80100-v2-2-1a3e1d98564e@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 4 Dec 2023 16:33:13 +0200
Message-ID: <CAA8EJpqC-afe=WUkptXHZob0fr+R6GrYU1Q8iiHjLSO64cFxwA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] phy: qcom-qmp-usb: Add Qualcomm X1E80100 USB3 PHY support
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Mon, 4 Dec 2023 at 15:50, Abel Vesa <abel.vesa@linaro.org> wrote:
>
> The X1E80100 platform has two instances of the USB3 UNI phy attached
> to the multi-port USB controller, add definition for these.
>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-usb.c | 160 ++++++++++++++++++++++++++++++++
>  1 file changed, 160 insertions(+)
>
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
> index 77e91b3eae79..35c19da3d454 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
> @@ -25,6 +25,7 @@
>  #include "phy-qcom-qmp-pcs-usb-v4.h"
>  #include "phy-qcom-qmp-pcs-usb-v5.h"
>  #include "phy-qcom-qmp-pcs-usb-v6.h"
> +#include "phy-qcom-qmp-pcs-usb-v7.h"
>
>  /* QPHY_SW_RESET bit */
>  #define SW_RESET                               BIT(0)
> @@ -1301,6 +1302,134 @@ static const struct qmp_phy_init_tbl sa8775p_usb3_uniphy_pcs_usb_tbl[] = {
>         QMP_PHY_INIT_CFG(QPHY_V5_PCS_USB3_POWER_STATE_CONFIG1, 0x6f),
>  };
>
> +static const struct qmp_phy_init_tbl x1e80100_usb3_uniphy_serdes_tbl[] = {
> +       QMP_PHY_INIT_CFG(QSERDES_V7_COM_SSC_STEP_SIZE1_MODE1, 0xc0),
> +       QMP_PHY_INIT_CFG(QSERDES_V7_COM_SSC_STEP_SIZE2_MODE1, 0x01),
> +       QMP_PHY_INIT_CFG(QSERDES_V7_COM_CP_CTRL_MODE1, 0x02),
> +       QMP_PHY_INIT_CFG(QSERDES_V7_COM_PLL_RCTRL_MODE1, 0x16),
> +       QMP_PHY_INIT_CFG(QSERDES_V7_COM_PLL_CCTRL_MODE1, 0x36),
> +       QMP_PHY_INIT_CFG(QSERDES_V7_COM_CORECLK_DIV_MODE1, 0x04),
> +       QMP_PHY_INIT_CFG(QSERDES_V7_COM_LOCK_CMP1_MODE1, 0x16),
> +       QMP_PHY_INIT_CFG(QSERDES_V7_COM_LOCK_CMP2_MODE1, 0x41),
> +       QMP_PHY_INIT_CFG(QSERDES_V7_COM_DEC_START_MODE1, 0x41),
> +       QMP_PHY_INIT_CFG(QSERDES_V7_COM_DIV_FRAC_START1_MODE1, 0x55),
> +       QMP_PHY_INIT_CFG(QSERDES_V7_COM_DIV_FRAC_START2_MODE1, 0x75),
> +       QMP_PHY_INIT_CFG(QSERDES_V7_COM_DIV_FRAC_START3_MODE1, 0x01),
> +       QMP_PHY_INIT_CFG(QSERDES_V7_COM_HSCLK_SEL_1, 0x01),
> +       QMP_PHY_INIT_CFG(QSERDES_V7_COM_VCO_TUNE1_MODE1, 0x25),
> +       QMP_PHY_INIT_CFG(QSERDES_V7_COM_VCO_TUNE2_MODE1, 0x02),
> +       QMP_PHY_INIT_CFG(QSERDES_V7_COM_BIN_VCOCAL_CMP_CODE1_MODE1, 0x5c),
> +       QMP_PHY_INIT_CFG(QSERDES_V7_COM_BIN_VCOCAL_CMP_CODE2_MODE1, 0x0f),
> +       QMP_PHY_INIT_CFG(QSERDES_V7_COM_BIN_VCOCAL_CMP_CODE1_MODE0, 0x5c),
> +       QMP_PHY_INIT_CFG(QSERDES_V7_COM_BIN_VCOCAL_CMP_CODE2_MODE0, 0x0f),
> +       QMP_PHY_INIT_CFG(QSERDES_V7_COM_SSC_STEP_SIZE1_MODE0, 0xc0),
> +       QMP_PHY_INIT_CFG(QSERDES_V7_COM_SSC_STEP_SIZE2_MODE0, 0x01),
> +       QMP_PHY_INIT_CFG(QSERDES_V7_COM_CP_CTRL_MODE0, 0x02),
> +       QMP_PHY_INIT_CFG(QSERDES_V7_COM_PLL_RCTRL_MODE0, 0x16),
> +       QMP_PHY_INIT_CFG(QSERDES_V7_COM_PLL_CCTRL_MODE0, 0x36),
> +       QMP_PHY_INIT_CFG(QSERDES_V7_COM_LOCK_CMP1_MODE0, 0x08),
> +       QMP_PHY_INIT_CFG(QSERDES_V7_COM_LOCK_CMP2_MODE0, 0x1a),
> +       QMP_PHY_INIT_CFG(QSERDES_V7_COM_DEC_START_MODE0, 0x41),
> +       QMP_PHY_INIT_CFG(QSERDES_V7_COM_DIV_FRAC_START1_MODE0, 0x55),
> +       QMP_PHY_INIT_CFG(QSERDES_V7_COM_DIV_FRAC_START2_MODE0, 0x75),
> +       QMP_PHY_INIT_CFG(QSERDES_V7_COM_DIV_FRAC_START3_MODE0, 0x01),
> +       QMP_PHY_INIT_CFG(QSERDES_V7_COM_VCO_TUNE1_MODE0, 0x25),
> +       QMP_PHY_INIT_CFG(QSERDES_V7_COM_VCO_TUNE2_MODE0, 0x02),
> +       QMP_PHY_INIT_CFG(QSERDES_V7_COM_BG_TIMER, 0x0a),
> +       QMP_PHY_INIT_CFG(QSERDES_V7_COM_SSC_EN_CENTER, 0x01),
> +       QMP_PHY_INIT_CFG(QSERDES_V7_COM_SSC_PER1, 0x62),
> +       QMP_PHY_INIT_CFG(QSERDES_V7_COM_SSC_PER2, 0x02),
> +       QMP_PHY_INIT_CFG(QSERDES_V7_COM_SYSCLK_BUF_ENABLE, 0x0a),
> +       QMP_PHY_INIT_CFG(QSERDES_V7_COM_SYSCLK_EN_SEL, 0x1a),
> +       QMP_PHY_INIT_CFG(QSERDES_V7_COM_LOCK_CMP_CFG, 0x14),
> +       QMP_PHY_INIT_CFG(QSERDES_V7_COM_VCO_TUNE_MAP, 0x04),
> +       QMP_PHY_INIT_CFG(QSERDES_V7_COM_CORE_CLK_EN, 0x20),
> +       QMP_PHY_INIT_CFG(QSERDES_V7_COM_CMN_CONFIG_1, 0x16),
> +       QMP_PHY_INIT_CFG(QSERDES_V7_COM_AUTO_GAIN_ADJ_CTRL_1, 0xb6),
> +       QMP_PHY_INIT_CFG(QSERDES_V7_COM_AUTO_GAIN_ADJ_CTRL_2, 0x4b),
> +       QMP_PHY_INIT_CFG(QSERDES_V7_COM_AUTO_GAIN_ADJ_CTRL_3, 0x37),
> +       QMP_PHY_INIT_CFG(QSERDES_V7_COM_ADDITIONAL_MISC, 0x0c),
> +};
> +
> +static const struct qmp_phy_init_tbl x1e80100_usb3_uniphy_tx_tbl[] = {
> +       QMP_PHY_INIT_CFG(QSERDES_V7_TX_RES_CODE_LANE_TX, 0x00),
> +       QMP_PHY_INIT_CFG(QSERDES_V7_TX_RES_CODE_LANE_RX, 0x00),
> +       QMP_PHY_INIT_CFG(QSERDES_V7_TX_RES_CODE_LANE_OFFSET_TX, 0x1f),
> +       QMP_PHY_INIT_CFG(QSERDES_V7_TX_RES_CODE_LANE_OFFSET_RX, 0x09),
> +       QMP_PHY_INIT_CFG(QSERDES_V7_TX_LANE_MODE_1, 0xf5),
> +       QMP_PHY_INIT_CFG(QSERDES_V7_TX_LANE_MODE_3, 0x3f),
> +       QMP_PHY_INIT_CFG(QSERDES_V7_TX_LANE_MODE_4, 0x3f),
> +       QMP_PHY_INIT_CFG(QSERDES_V7_TX_LANE_MODE_5, 0x5f),
> +       QMP_PHY_INIT_CFG(QSERDES_V7_TX_RCV_DETECT_LVL_2, 0x12),
> +       QMP_PHY_INIT_CFG(QSERDES_V7_TX_PI_QEC_CTRL, 0x21),
> +};
> +
> +static const struct qmp_phy_init_tbl x1e80100_usb3_uniphy_rx_tbl[] = {
> +       QMP_PHY_INIT_CFG(QSERDES_V7_RX_UCDR_FO_GAIN, 0x0a),
> +       QMP_PHY_INIT_CFG(QSERDES_V7_RX_UCDR_SO_GAIN, 0x06),
> +       QMP_PHY_INIT_CFG(QSERDES_V7_RX_UCDR_FASTLOCK_FO_GAIN, 0x2f),
> +       QMP_PHY_INIT_CFG(QSERDES_V7_RX_UCDR_SO_SATURATION_AND_ENABLE, 0x7f),
> +       QMP_PHY_INIT_CFG(QSERDES_V7_RX_UCDR_FASTLOCK_COUNT_LOW, 0xff),
> +       QMP_PHY_INIT_CFG(QSERDES_V7_RX_UCDR_FASTLOCK_COUNT_HIGH, 0x0f),
> +       QMP_PHY_INIT_CFG(QSERDES_V7_RX_UCDR_PI_CONTROLS, 0x99),
> +       QMP_PHY_INIT_CFG(QSERDES_V7_RX_UCDR_SB2_THRESH1, 0x08),
> +       QMP_PHY_INIT_CFG(QSERDES_V7_RX_UCDR_SB2_THRESH2, 0x08),
> +       QMP_PHY_INIT_CFG(QSERDES_V7_RX_UCDR_SB2_GAIN1, 0x00),
> +       QMP_PHY_INIT_CFG(QSERDES_V7_RX_UCDR_SB2_GAIN2, 0x0a),
> +       QMP_PHY_INIT_CFG(QSERDES_V7_RX_AUX_DATA_TCOARSE_TFINE, 0xa0),
> +       QMP_PHY_INIT_CFG(QSERDES_V7_RX_VGA_CAL_CNTRL1, 0x54),
> +       QMP_PHY_INIT_CFG(QSERDES_V7_RX_VGA_CAL_CNTRL2, 0x0f),
> +       QMP_PHY_INIT_CFG(QSERDES_V7_RX_GM_CAL, 0x13),
> +       QMP_PHY_INIT_CFG(QSERDES_V7_RX_RX_EQU_ADAPTOR_CNTRL2, 0x0f),
> +       QMP_PHY_INIT_CFG(QSERDES_V7_RX_RX_EQU_ADAPTOR_CNTRL3, 0x4a),
> +       QMP_PHY_INIT_CFG(QSERDES_V7_RX_RX_EQU_ADAPTOR_CNTRL4, 0x0a),
> +       QMP_PHY_INIT_CFG(QSERDES_V7_RX_RX_IDAC_TSETTLE_LOW, 0x07),
> +       QMP_PHY_INIT_CFG(QSERDES_V7_RX_RX_IDAC_TSETTLE_HIGH, 0x00),
> +       QMP_PHY_INIT_CFG(QSERDES_V7_RX_RX_EQ_OFFSET_ADAPTOR_CNTRL1, 0x47),
> +       QMP_PHY_INIT_CFG(QSERDES_V7_RX_SIGDET_CNTRL, 0x04),
> +       QMP_PHY_INIT_CFG(QSERDES_V7_RX_SIGDET_DEGLITCH_CNTRL, 0x0e),
> +       QMP_PHY_INIT_CFG(QSERDES_V7_RX_RX_MODE_00_LOW, 0x3f),
> +       QMP_PHY_INIT_CFG(QSERDES_V7_RX_RX_MODE_00_HIGH, 0xbf),
> +       QMP_PHY_INIT_CFG(QSERDES_V7_RX_RX_MODE_00_HIGH2, 0xff),
> +       QMP_PHY_INIT_CFG(QSERDES_V7_RX_RX_MODE_00_HIGH3, 0xdf),
> +       QMP_PHY_INIT_CFG(QSERDES_V7_RX_RX_MODE_00_HIGH4, 0xed),
> +       QMP_PHY_INIT_CFG(QSERDES_V7_RX_RX_MODE_01_LOW, 0xdc),
> +       QMP_PHY_INIT_CFG(QSERDES_V7_RX_RX_MODE_01_HIGH, 0x5c),
> +       QMP_PHY_INIT_CFG(QSERDES_V7_RX_RX_MODE_01_HIGH2, 0x9c),
> +       QMP_PHY_INIT_CFG(QSERDES_V7_RX_RX_MODE_01_HIGH3, 0x1d),
> +       QMP_PHY_INIT_CFG(QSERDES_V7_RX_RX_MODE_01_HIGH4, 0x09),
> +       QMP_PHY_INIT_CFG(QSERDES_V7_RX_DFE_EN_TIMER, 0x04),
> +       QMP_PHY_INIT_CFG(QSERDES_V7_RX_DFE_CTLE_POST_CAL_OFFSET, 0x38),
> +       QMP_PHY_INIT_CFG(QSERDES_V7_RX_DCC_CTRL1, 0x0c),
> +       QMP_PHY_INIT_CFG(QSERDES_V7_RX_VTH_CODE, 0x10),
> +       QMP_PHY_INIT_CFG(QSERDES_V7_RX_SIGDET_CAL_CTRL1, 0x14),
> +       QMP_PHY_INIT_CFG(QSERDES_V7_RX_SIGDET_CAL_TRIM, 0x08),
> +};
> +
> +static const struct qmp_phy_init_tbl x1e80100_usb3_uniphy_pcs_tbl[] = {
> +       QMP_PHY_INIT_CFG(QPHY_V7_PCS_LOCK_DETECT_CONFIG1, 0xc4),
> +       QMP_PHY_INIT_CFG(QPHY_V7_PCS_LOCK_DETECT_CONFIG2, 0x89),
> +       QMP_PHY_INIT_CFG(QPHY_V7_PCS_LOCK_DETECT_CONFIG3, 0x20),
> +       QMP_PHY_INIT_CFG(QPHY_V7_PCS_LOCK_DETECT_CONFIG6, 0x13),
> +       QMP_PHY_INIT_CFG(QPHY_V7_PCS_REFGEN_REQ_CONFIG1, 0x21),
> +       QMP_PHY_INIT_CFG(QPHY_V7_PCS_RX_SIGDET_LVL, 0xaa),
> +       QMP_PHY_INIT_CFG(QPHY_V7_PCS_RCVR_DTCT_DLY_P1U2_L, 0xe7),
> +       QMP_PHY_INIT_CFG(QPHY_V7_PCS_RCVR_DTCT_DLY_P1U2_H, 0x03),
> +       QMP_PHY_INIT_CFG(QPHY_V7_PCS_CDR_RESET_TIME, 0x0a),
> +       QMP_PHY_INIT_CFG(QPHY_V7_PCS_ALIGN_DETECT_CONFIG1, 0x88),
> +       QMP_PHY_INIT_CFG(QPHY_V7_PCS_ALIGN_DETECT_CONFIG2, 0x13),
> +       QMP_PHY_INIT_CFG(QPHY_V7_PCS_PCS_TX_RX_CONFIG, 0x0c),
> +       QMP_PHY_INIT_CFG(QPHY_V7_PCS_EQ_CONFIG1, 0x4b),
> +       QMP_PHY_INIT_CFG(QPHY_V7_PCS_EQ_CONFIG5, 0x10),
> +};
> +
> +static const struct qmp_phy_init_tbl x1e80100_usb3_uniphy_pcs_usb_tbl[] = {
> +       QMP_PHY_INIT_CFG(QPHY_V7_PCS_USB3_LFPS_DET_HIGH_COUNT_VAL, 0xf8),
> +       QMP_PHY_INIT_CFG(QPHY_V7_PCS_USB3_RXEQTRAINING_DFE_TIME_S2, 0x07),
> +       QMP_PHY_INIT_CFG(QPHY_V7_PCS_USB3_RCVR_DTCT_DLY_U3_L, 0x40),
> +       QMP_PHY_INIT_CFG(QPHY_V7_PCS_USB3_RCVR_DTCT_DLY_U3_H, 0x00),
> +};
> +
>  struct qmp_usb_offsets {
>         u16 serdes;
>         u16 pcs;
> @@ -1465,6 +1594,14 @@ static const struct qmp_usb_offsets qmp_usb_offsets_v6 = {
>         .rx             = 0x1000,
>  };
>
> +static const struct qmp_usb_offsets qmp_usb_offsets_v7 = {
> +       .serdes         = 0,
> +       .pcs            = 0x0200,
> +       .pcs_usb        = 0x1200,
> +       .tx             = 0x0e00,
> +       .rx             = 0x1000,
> +};
> +
>  static const struct qmp_phy_cfg ipq8074_usb3phy_cfg = {
>         .lanes                  = 1,
>
> @@ -1752,6 +1889,26 @@ static const struct qmp_phy_cfg qcm2290_usb3phy_cfg = {
>         .regs                   = qmp_v3_usb3phy_regs_layout_qcm2290,
>  };
>
> +static const struct qmp_phy_cfg x1e80100_usb3_uniphy_cfg = {
> +       .lanes                  = 1,
> +
> +       .offsets                = &qmp_usb_offsets_v7,
> +
> +       .serdes_tbl             = x1e80100_usb3_uniphy_serdes_tbl,
> +       .serdes_tbl_num         = ARRAY_SIZE(x1e80100_usb3_uniphy_serdes_tbl),
> +       .tx_tbl                 = x1e80100_usb3_uniphy_tx_tbl,
> +       .tx_tbl_num             = ARRAY_SIZE(x1e80100_usb3_uniphy_tx_tbl),
> +       .rx_tbl                 = x1e80100_usb3_uniphy_rx_tbl,
> +       .rx_tbl_num             = ARRAY_SIZE(x1e80100_usb3_uniphy_rx_tbl),
> +       .pcs_tbl                = x1e80100_usb3_uniphy_pcs_tbl,
> +       .pcs_tbl_num            = ARRAY_SIZE(x1e80100_usb3_uniphy_pcs_tbl),
> +       .pcs_usb_tbl            = x1e80100_usb3_uniphy_pcs_usb_tbl,
> +       .pcs_usb_tbl_num        = ARRAY_SIZE(x1e80100_usb3_uniphy_pcs_usb_tbl),
> +       .vreg_list              = qmp_phy_vreg_l,
> +       .num_vregs              = ARRAY_SIZE(qmp_phy_vreg_l),
> +       .regs                   = qmp_v5_usb3phy_regs_layout,

Probably I missed that during v1 review. Please add v7 regs layout.

With that fixed:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> +};
> +
>  static void qmp_usb_configure_lane(void __iomem *base,
>                                         const struct qmp_phy_init_tbl tbl[],
>                                         int num,
> @@ -2441,6 +2598,9 @@ static const struct of_device_id qmp_usb_of_match_table[] = {
>         }, {
>                 .compatible = "qcom,sm8350-qmp-usb3-uni-phy",
>                 .data = &sm8350_usb3_uniphy_cfg,
> +       }, {
> +               .compatible = "qcom,x1e80100-qmp-usb3-uni-phy",
> +               .data = &x1e80100_usb3_uniphy_cfg,
>         },
>         { },
>  };
>
> --
> 2.34.1
>


-- 
With best wishes
Dmitry
