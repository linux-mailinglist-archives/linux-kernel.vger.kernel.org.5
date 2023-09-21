Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2A5E7AA205
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbjIUVLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233064AbjIUVFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:05:22 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45B24F3B1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:12:33 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id 006d021491bc7-57b64731334so292314eaf.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695319952; x=1695924752; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Sk5pQk4dTHXMdwQvECL7obtB6fEsGnIqEeboU8Vm3J4=;
        b=FUsaLQDqMQk/5/5aSnn8lpYkGNvynk1SEvTLYKHkSYptNQpV0LT4F4sZ453EtLwd2N
         KWjQ9y6U1fm7oq5TwKt0/G31S7yVxtfEemrqLO8tUj3Pj8sQujnYxICj5BajlqQBzqSc
         g8A4IZtaLn+nCQqwJ6A9JGLA1mhCwHAzJfd1Ri4+yWss+SLYYfNPdeQb6jyhOf4dqSxF
         g0DXD05xQCgPTpn7zlxmzCLKwqkDx23MpUiKu/aLr+DUOzzPeopPMwnJ+eGRWlzrgHy7
         xgq6zgy3SC/ZTpZc8zphj7BkD2k4DuGXoDOM+pjvUXxToSItRxvcq0TvqDLUqMQU43p0
         aXYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695319952; x=1695924752;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sk5pQk4dTHXMdwQvECL7obtB6fEsGnIqEeboU8Vm3J4=;
        b=UH3PEWggutWSM3UYKLT4Vtkw4JjOOFkGt3t6EYvxD5NH6nD5ADJ3c71aGFGswUztYa
         DnZrmvPfwt6QHBINh6mZIUWan8c8I4A6ygngGj+b8bRcavQJk21n1N1hvV+oHWz+Xa2g
         UaNZKdIyL9nn8RfkUg831Ut4zwSWLaOhJEs/Gwv0FqQlACZAGR3nGLQjJUK8TJmsm+Bv
         8b+9+Y1GbvDCDYuQYf71a+QLn/RDT2F1r7cJJ5EBAjeovKOgLBbd2Yo3HuYeFg7x8SZk
         ot1VkzzH5LxFc9lKoAZ4d9QXuyWLMFaGA+jtfLuMavlRUgrraY3eiv6CwuaO0pK76l58
         ViRg==
X-Gm-Message-State: AOJu0Yy39jHT9ayfdEtQRffZYQDO+rWveC3VNLbGh6KgNGKBUnS7xk26
        6uPsWDNBmilMYhluF/x4CUAjsKXwIwxo9/yCxion6YnYHJ+3J1s5igM=
X-Google-Smtp-Source: AGHT+IEqy+x8qZwJW+x/4Oyf21wG2EyTTqNSNUHHaVmE1pVFyAZ0elqtZmrqoRfmvmya7C3LiVkWxPXYVm3tnMoPVsg=
X-Received: by 2002:a25:8251:0:b0:d7a:c493:ef35 with SMTP id
 d17-20020a258251000000b00d7ac493ef35mr4862946ybn.58.1695298019847; Thu, 21
 Sep 2023 05:06:59 -0700 (PDT)
MIME-Version: 1.0
References: <1695291692-18850-1-git-send-email-quic_rohiagar@quicinc.com> <1695291692-18850-6-git-send-email-quic_rohiagar@quicinc.com>
In-Reply-To: <1695291692-18850-6-git-send-email-quic_rohiagar@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 21 Sep 2023 15:06:48 +0300
Message-ID: <CAA8EJpqsKpcABmkR0+ciOxhohTSmhL4SSxBj6BijMVLfkMv02A@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] phy: qcom-qmp-usb: Add Qualcomm SDX75 USB3 PHY support
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        vkoul@kernel.org, kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        gregkh@linuxfoundation.org, abel.vesa@linaro.org,
        quic_wcheng@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        kernel@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Sept 2023 at 13:21, Rohit Agarwal <quic_rohiagar@quicinc.com> wrote:
>
> Add support for USB3 QMP PHY found in SDX75 platform.
>
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-usb.c | 165 ++++++++++++++++++++++++++++++++
>  1 file changed, 165 insertions(+)
>
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
> index 2a094f2..3145814 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
> @@ -24,6 +24,7 @@
>  #include "phy-qcom-qmp-pcs-misc-v4.h"
>  #include "phy-qcom-qmp-pcs-usb-v4.h"
>  #include "phy-qcom-qmp-pcs-usb-v5.h"
> +#include "phy-qcom-qmp-pcs-usb-v6.h"
>
>  /* QPHY_SW_RESET bit */
>  #define SW_RESET                               BIT(0)
> @@ -151,6 +152,17 @@ static const unsigned int qmp_v5_usb3phy_regs_layout[QPHY_LAYOUT_SIZE] = {
>         [QPHY_PCS_LFPS_RXTERM_IRQ_CLEAR] = QPHY_V5_PCS_USB3_LFPS_RXTERM_IRQ_CLEAR,
>  };
>
> +static const unsigned int qmp_v6_usb3phy_regs_layout[QPHY_LAYOUT_SIZE] = {
> +       [QPHY_SW_RESET]                 = QPHY_V6_PCS_SW_RESET,
> +       [QPHY_START_CTRL]               = QPHY_V6_PCS_START_CONTROL,
> +       [QPHY_PCS_STATUS]               = QPHY_V6_PCS_PCS_STATUS1,
> +       [QPHY_PCS_POWER_DOWN_CONTROL]   = QPHY_V6_PCS_POWER_DOWN_CONTROL,
> +
> +       /* In PCS_USB */
> +       [QPHY_PCS_AUTONOMOUS_MODE_CTRL] = QPHY_V6_PCS_USB3_AUTONOMOUS_MODE_CTRL,
> +       [QPHY_PCS_LFPS_RXTERM_IRQ_CLEAR] = QPHY_V6_PCS_USB3_LFPS_RXTERM_IRQ_CLEAR,
> +};
> +
>  static const struct qmp_phy_init_tbl ipq9574_usb3_serdes_tbl[] = {
>         QMP_PHY_INIT_CFG(QSERDES_COM_SYSCLK_EN_SEL, 0x1a),
>         QMP_PHY_INIT_CFG(QSERDES_COM_BIAS_EN_CLKBUFLR_EN, 0x08),
> @@ -871,6 +883,134 @@ static const struct qmp_phy_init_tbl sdx65_usb3_uniphy_rx_tbl[] = {
>         QMP_PHY_INIT_CFG(QSERDES_V5_RX_SIGDET_ENABLES, 0x00),
>  };
>
> +static const struct qmp_phy_init_tbl sdx75_usb3_uniphy_serdes_tbl[] = {
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_SSC_STEP_SIZE1_MODE1, 0x9e),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_SSC_STEP_SIZE2_MODE1, 0x06),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_CP_CTRL_MODE1, 0x02),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_RCTRL_MODE1, 0x16),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_CCTRL_MODE1, 0x36),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_CORECLK_DIV_MODE1, 0x04),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP1_MODE1, 0x2e),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP2_MODE1, 0x82),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_DEC_START_MODE1, 0x82),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_DIV_FRAC_START1_MODE1, 0xab),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_DIV_FRAC_START2_MODE1, 0xea),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_DIV_FRAC_START3_MODE1, 0x02),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_HSCLK_SEL_1, 0x01),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE1_MODE1, 0x25),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE2_MODE1, 0x02),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_BIN_VCOCAL_CMP_CODE1_MODE1, 0xb7),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_BIN_VCOCAL_CMP_CODE2_MODE1, 0x1e),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_BIN_VCOCAL_CMP_CODE1_MODE0, 0xb7),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_BIN_VCOCAL_CMP_CODE2_MODE0, 0x1e),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_SSC_STEP_SIZE1_MODE0, 0x9e),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_SSC_STEP_SIZE2_MODE0, 0x06),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_CP_CTRL_MODE0, 0x02),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_RCTRL_MODE0, 0x16),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_CCTRL_MODE0, 0x36),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP1_MODE0, 0x12),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP2_MODE0, 0x34),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_DEC_START_MODE0, 0x82),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_DIV_FRAC_START1_MODE0, 0xab),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_DIV_FRAC_START2_MODE0, 0xea),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_DIV_FRAC_START3_MODE0, 0x02),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE1_MODE0, 0x25),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE2_MODE0, 0x02),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_BG_TIMER, 0x0e),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_SSC_EN_CENTER, 0x01),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_SSC_PER1, 0x31),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_SSC_PER2, 0x01),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_SYSCLK_BUF_ENABLE, 0x0a),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_SYSCLK_EN_SEL, 0x1a),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP_CFG, 0x14),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE_MAP, 0x04),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_CORE_CLK_EN, 0x20),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_CMN_CONFIG_1, 0x16),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_AUTO_GAIN_ADJ_CTRL_1, 0xb6),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_AUTO_GAIN_ADJ_CTRL_2, 0x4b),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_AUTO_GAIN_ADJ_CTRL_3, 0x37),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_ADDITIONAL_MISC, 0x0c),
> +};
> +
> +static const struct qmp_phy_init_tbl sdx75_usb3_uniphy_tx_tbl[] = {
> +       QMP_PHY_INIT_CFG(QSERDES_V6_TX_RES_CODE_LANE_TX, 0x00),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_TX_RES_CODE_LANE_RX, 0x00),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_TX_RES_CODE_LANE_OFFSET_TX, 0x1f),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_TX_RES_CODE_LANE_OFFSET_RX, 0x09),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_TX_LANE_MODE_1, 0xf5),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_TX_LANE_MODE_3, 0x3f),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_TX_LANE_MODE_4, 0x3f),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_TX_LANE_MODE_5, 0x5f),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_TX_RCV_DETECT_LVL_2, 0x12),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_TX_PI_QEC_CTRL, 0x21),
> +};
> +
> +static const struct qmp_phy_init_tbl sdx75_usb3_uniphy_rx_tbl[] = {
> +       QMP_PHY_INIT_CFG(QSERDES_V6_RX_UCDR_FO_GAIN, 0x0a),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_RX_UCDR_SO_GAIN, 0x06),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_RX_UCDR_FASTLOCK_FO_GAIN, 0x2f),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_RX_UCDR_SO_SATURATION_AND_ENABLE, 0x7f),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_RX_UCDR_FASTLOCK_COUNT_LOW, 0xff),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_RX_UCDR_FASTLOCK_COUNT_HIGH, 0x0f),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_RX_UCDR_PI_CONTROLS, 0x99),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_RX_UCDR_SB2_THRESH1, 0x08),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_RX_UCDR_SB2_THRESH2, 0x08),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_RX_UCDR_SB2_GAIN1, 0x00),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_RX_UCDR_SB2_GAIN2, 0x0a),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_RX_AUX_DATA_TCOARSE_TFINE, 0xa0),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_RX_VGA_CAL_CNTRL1, 0x54),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_RX_VGA_CAL_CNTRL2, 0x0f),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_RX_GM_CAL, 0x13),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_RX_RX_EQU_ADAPTOR_CNTRL2, 0x0f),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_RX_RX_EQU_ADAPTOR_CNTRL3, 0x4a),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_RX_RX_EQU_ADAPTOR_CNTRL4, 0x0a),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_RX_RX_IDAC_TSETTLE_LOW, 0x07),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_RX_RX_IDAC_TSETTLE_HIGH, 0x00),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_RX_RX_EQ_OFFSET_ADAPTOR_CNTRL1, 0x47),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_RX_SIGDET_CNTRL, 0x04),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_RX_SIGDET_DEGLITCH_CNTRL, 0x0e),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_RX_RX_MODE_00_LOW, 0x3f),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_RX_RX_MODE_00_HIGH, 0xbf),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_RX_RX_MODE_00_HIGH2, 0xff),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_RX_RX_MODE_00_HIGH3, 0xdf),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_RX_RX_MODE_00_HIGH4, 0xed),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_RX_RX_MODE_01_LOW, 0xdc),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_RX_RX_MODE_01_HIGH, 0x5c),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_RX_RX_MODE_01_HIGH2, 0x9c),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_RX_RX_MODE_01_HIGH3, 0x1d),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_RX_RX_MODE_01_HIGH4, 0x09),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_RX_DFE_EN_TIMER, 0x04),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_RX_DFE_CTLE_POST_CAL_OFFSET, 0x38),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_RX_DCC_CTRL1, 0x0c),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_RX_VTH_CODE, 0x10),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_RX_SIGDET_CAL_CTRL1, 0x14),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_RX_SIGDET_CAL_TRIM, 0x08),
> +};
> +
> +static const struct qmp_phy_init_tbl sdx75_usb3_uniphy_pcs_tbl[] = {
> +       QMP_PHY_INIT_CFG(QPHY_V6_PCS_LOCK_DETECT_CONFIG1, 0xc4),
> +       QMP_PHY_INIT_CFG(QPHY_V6_PCS_LOCK_DETECT_CONFIG2, 0x89),
> +       QMP_PHY_INIT_CFG(QPHY_V6_PCS_LOCK_DETECT_CONFIG3, 0x20),
> +       QMP_PHY_INIT_CFG(QPHY_V6_PCS_LOCK_DETECT_CONFIG6, 0x13),
> +       QMP_PHY_INIT_CFG(QPHY_V6_PCS_REFGEN_REQ_CONFIG1, 0x21),
> +       QMP_PHY_INIT_CFG(QPHY_V6_PCS_RX_SIGDET_LVL, 0xaa),
> +       QMP_PHY_INIT_CFG(QPHY_V6_PCS_RCVR_DTCT_DLY_P1U2_L, 0xe7),
> +       QMP_PHY_INIT_CFG(QPHY_V6_PCS_RCVR_DTCT_DLY_P1U2_H, 0x03),
> +       QMP_PHY_INIT_CFG(QPHY_V6_PCS_CDR_RESET_TIME, 0x0a),
> +       QMP_PHY_INIT_CFG(QPHY_V6_PCS_ALIGN_DETECT_CONFIG1, 0x88),
> +       QMP_PHY_INIT_CFG(QPHY_V6_PCS_ALIGN_DETECT_CONFIG2, 0x13),
> +       QMP_PHY_INIT_CFG(QPHY_V6_PCS_PCS_TX_RX_CONFIG, 0x0c),
> +       QMP_PHY_INIT_CFG(QPHY_V6_PCS_EQ_CONFIG1, 0x4b),
> +       QMP_PHY_INIT_CFG(QPHY_V6_PCS_EQ_CONFIG5, 0x10),
> +};
> +
> +static const struct qmp_phy_init_tbl sdx75_usb3_uniphy_pcs_usb_tbl[] = {
> +       QMP_PHY_INIT_CFG(QPHY_V6_PCS_USB3_LFPS_DET_HIGH_COUNT_VAL, 0xf8),
> +       QMP_PHY_INIT_CFG(QPHY_V6_PCS_USB3_RXEQTRAINING_DFE_TIME_S2, 0x07),
> +       QMP_PHY_INIT_CFG(QPHY_V6_PCS_USB3_RCVR_DTCT_DLY_U3_L, 0x40),
> +       QMP_PHY_INIT_CFG(QPHY_V6_PCS_USB3_RCVR_DTCT_DLY_U3_H, 0x00),
> +};
> +
>  static const struct qmp_phy_init_tbl sm8350_usb3_uniphy_tx_tbl[] = {
>         QMP_PHY_INIT_CFG(QSERDES_V5_TX_LANE_MODE_1, 0xa5),
>         QMP_PHY_INIT_CFG(QSERDES_V5_TX_LANE_MODE_2, 0x82),
> @@ -1531,6 +1671,28 @@ static const struct qmp_phy_cfg sdx65_usb3_uniphy_cfg = {
>         .has_pwrdn_delay        = true,
>  };
>
> +static const struct qmp_phy_cfg sdx75_usb3_uniphy_cfg = {
> +       .lanes                  = 1,
> +       .offsets                = &qmp_usb_offsets_v5,

This should be v6

> +
> +       .serdes_tbl             = sdx75_usb3_uniphy_serdes_tbl,
> +       .serdes_tbl_num         = ARRAY_SIZE(sdx75_usb3_uniphy_serdes_tbl),
> +       .tx_tbl                 = sdx75_usb3_uniphy_tx_tbl,
> +       .tx_tbl_num             = ARRAY_SIZE(sdx75_usb3_uniphy_tx_tbl),
> +       .rx_tbl                 = sdx75_usb3_uniphy_rx_tbl,
> +       .rx_tbl_num             = ARRAY_SIZE(sdx75_usb3_uniphy_rx_tbl),
> +       .pcs_tbl                = sdx75_usb3_uniphy_pcs_tbl,
> +       .pcs_tbl_num            = ARRAY_SIZE(sdx75_usb3_uniphy_pcs_tbl),
> +       .pcs_usb_tbl            = sdx75_usb3_uniphy_pcs_usb_tbl,
> +       .pcs_usb_tbl_num        = ARRAY_SIZE(sdx75_usb3_uniphy_pcs_usb_tbl),
> +       .vreg_list              = qmp_phy_vreg_l,
> +       .num_vregs              = ARRAY_SIZE(qmp_phy_vreg_l),
> +       .regs                   = qmp_v6_usb3phy_regs_layout,
> +       .pcs_usb_offset         = 0x1000,
> +
> +       .has_pwrdn_delay        = true,
> +};
> +
>  static const struct qmp_phy_cfg sm8350_usb3_uniphy_cfg = {
>         .lanes                  = 1,
>
> @@ -2243,6 +2405,9 @@ static const struct of_device_id qmp_usb_of_match_table[] = {
>                 .compatible = "qcom,sdx65-qmp-usb3-uni-phy",
>                 .data = &sdx65_usb3_uniphy_cfg,
>         }, {
> +               .compatible = "qcom,sdx75-qmp-usb3-uni-phy",
> +               .data = &sdx75_usb3_uniphy_cfg,
> +       }, {
>                 .compatible = "qcom,sm6115-qmp-usb3-phy",
>                 .data = &qcm2290_usb3phy_cfg,
>         }, {
> --
> 2.7.4
>


-- 
With best wishes
Dmitry
