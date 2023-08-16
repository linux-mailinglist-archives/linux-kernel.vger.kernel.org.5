Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5C2777EAB8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 22:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346150AbjHPUbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 16:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346152AbjHPUay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 16:30:54 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93062690
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 13:30:52 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-d62b8e2860dso6709677276.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 13:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692217852; x=1692822652;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oj6j0UTfHpcSFW9VWSKTIuwYq3syLxLFSaHojGg/8BU=;
        b=oyskU0VjEFTUCSJe+GtbdU6XRZefYsg8/zNlQPNN1Lvdc7MCXFuH4PmEIYOqBpVr3n
         yqcZiyzCpAHpE8r1Q54Dh9js/LEODJv1ovzn/2dATFBQpDHBx7K4/zxD4w5Cf5NPAh8o
         5V6Ue7s3wws4i+Kh9+xQS2oVW7rMLNh+akB3nxcqOBoL6KX3rbJrHVN1xAJkLdmWAVmM
         NfXpTE/N+yoSWWrEZsQzAL+orf1HvLYUdJzhhc8SRVhaVSWvp2Xx2cmzLjUqG8HyK/dQ
         8+W7HsyL5DhkfyjZcDuHuLlfbTy1qczL0cC6mH4T1YnwZ1JLww8aWYEghzqqk8HDIBoF
         ff7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692217852; x=1692822652;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oj6j0UTfHpcSFW9VWSKTIuwYq3syLxLFSaHojGg/8BU=;
        b=VgRbJjALoc3YUMLOdOWm9dfhH+xTRgwbqqe3PQ5VqzBPcf6TxKzE3HugGry350DHei
         XJeFWjUWGdI3OSjJnrPX46aOfjA5Gv3uxMupQhC4LENgNKJMpNFL6A8UQ1SGa2QTe0rx
         lec8XeLWDcQ5/EyVvIFinJfALQkMqLeahOY14V9BKT1jBF0RiIb/+G/8B6iNx4mMLzdT
         QMbRz9VW3Ns2H6eWpbLP9AuQ0oL9305MqN0qJKViqbUCXuFymTrlxGV24XsXYtFUQerV
         eWGjYFJXjriRvt9HrBuJYFjRqAfTgJSqac4oWgTqi6OB2z8vgfGZiZy43VBSE5t3tX5X
         6LwQ==
X-Gm-Message-State: AOJu0YznDNFd0igs78kmB2lTV0HbJk3TeoId8K6+jSIOVBIksjIFLQSg
        l3AN28xF7O1ikOrSq29XC4MDDZvokos2BR8cusjzgg==
X-Google-Smtp-Source: AGHT+IElXLWoEGgM6YkthVVmmyFQI0WOphZRgqH18CiggpK6VxOnrQ3koFNz/0WXlf4R0R4uh+NL6eBq57tcTXm8oA0=
X-Received: by 2002:a25:b286:0:b0:d0e:c72d:71f8 with SMTP id
 k6-20020a25b286000000b00d0ec72d71f8mr3625306ybj.58.1692217851831; Wed, 16 Aug
 2023 13:30:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230816154841.2183-1-quic_nitirawa@quicinc.com> <20230816154841.2183-3-quic_nitirawa@quicinc.com>
In-Reply-To: <20230816154841.2183-3-quic_nitirawa@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 16 Aug 2023 23:30:40 +0300
Message-ID: <CAA8EJpo2Rm0oBGC_Qd2QtmmdQcWW3zKeTb-X5VH3wazCsriSNA@mail.gmail.com>
Subject: Re: [PATCH V1 2/2] phy: qcom-qmp-ufs: Add Phy Configuration support
 for SC7280
To:     Nitin Rawat <quic_nitirawa@quicinc.com>
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org, vkoul@kernel.org,
        agross@kernel.org, kishon@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, Manish Pandey <quic_mapa@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Aug 2023 at 18:50, Nitin Rawat <quic_nitirawa@quicinc.com> wrote:
>
> Add SC7280 specific register layout and table configs.
>
> Co-developed-by: Manish Pandey <quic_mapa@quicinc.com>
> Signed-off-by: Manish Pandey <quic_mapa@quicinc.com>
> Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 142 ++++++++++++++++++++++++
>  1 file changed, 142 insertions(+)
>
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> index 03cd47faf3fd..c5ab5f0792f5 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> @@ -493,6 +493,70 @@ static const struct qmp_phy_init_tbl sm8150_ufsphy_hs_g4_pcs[] = {
>         QMP_PHY_INIT_CFG(QPHY_V4_PCS_UFS_BIST_FIXED_PAT_CTRL, 0x0a),
>  };
>
> +static const struct qmp_phy_init_tbl sc7280_ufsphy_tx[] = {
> +       QMP_PHY_INIT_CFG(QSERDES_V4_TX_PWM_GEAR_1_DIVIDER_BAND0_1, 0x06),
> +       QMP_PHY_INIT_CFG(QSERDES_V4_TX_PWM_GEAR_2_DIVIDER_BAND0_1, 0x03),
> +       QMP_PHY_INIT_CFG(QSERDES_V4_TX_PWM_GEAR_3_DIVIDER_BAND0_1, 0x01),
> +       QMP_PHY_INIT_CFG(QSERDES_V4_TX_PWM_GEAR_4_DIVIDER_BAND0_1, 0x00),
> +       QMP_PHY_INIT_CFG(QSERDES_V4_TX_LANE_MODE_1, 0x35),
> +       QMP_PHY_INIT_CFG(QSERDES_V4_TX_TRAN_DRVR_EMP_EN, 0x0c),
> +};
> +
> +static const struct qmp_phy_init_tbl sc7280_ufsphy_rx[] = {
> +       QMP_PHY_INIT_CFG(QSERDES_V4_RX_SIGDET_LVL, 0x24),
> +       QMP_PHY_INIT_CFG(QSERDES_V4_RX_SIGDET_CNTRL, 0x0f),
> +       QMP_PHY_INIT_CFG(QSERDES_V4_RX_SIGDET_DEGLITCH_CNTRL, 0x1e),
> +       QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_BAND, 0x18),
> +       QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_FASTLOCK_FO_GAIN, 0x0a),
> +       QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_SO_SATURATION_AND_ENABLE, 0x5a),
> +       QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_PI_CONTROLS, 0xf1),
> +       QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_FASTLOCK_COUNT_LOW, 0x80),
> +       QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_PI_CTRL2, 0x80),
> +       QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_FO_GAIN, 0x0e),
> +       QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_SO_GAIN, 0x04),
> +       QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_TERM_BW, 0x1b),
> +       QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL2, 0x06),
> +       QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL3, 0x04),
> +       QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL4, 0x1d),
> +       QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_OFFSET_ADAPTOR_CNTRL2, 0x00),
> +       QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_IDAC_MEASURE_TIME, 0x10),
> +       QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_IDAC_TSETTLE_LOW, 0xc0),
> +       QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_IDAC_TSETTLE_HIGH, 0x00),
> +       QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_LOW, 0x6d),
> +       QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH, 0x6d),
> +       QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH2, 0xed),
> +       QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH3, 0x3b),
> +       QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH4, 0x3c),
> +       QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_LOW, 0xe0),
> +       QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH, 0xc8),
> +       QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH2, 0xc8),
> +       QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH3, 0x3b),
> +       QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH4, 0xb1),
> +       QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_10_LOW, 0xe0),
> +       QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_10_HIGH, 0xc8),
> +       QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_10_HIGH2, 0xc8),
> +       QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_10_HIGH3, 0x3b),
> +       QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_10_HIGH4, 0xb1),
> +       QMP_PHY_INIT_CFG(QSERDES_V4_RX_DCC_CTRL1, 0x0c),
> +};
> +
> +static const struct qmp_phy_init_tbl sc7280_ufsphy_pcs[] = {
> +       QMP_PHY_INIT_CFG(QPHY_V4_PCS_UFS_RX_SIGDET_CTRL2, 0x6D),
> +       QMP_PHY_INIT_CFG(QPHY_V4_PCS_UFS_TX_LARGE_AMP_DRV_LVL, 0x0A),
> +       QMP_PHY_INIT_CFG(QPHY_V4_PCS_UFS_TX_SMALL_AMP_DRV_LVL, 0x02),
> +       QMP_PHY_INIT_CFG(QPHY_V4_PCS_UFS_TX_MID_TERM_CTRL1, 0x43),
> +       QMP_PHY_INIT_CFG(QPHY_V4_PCS_UFS_DEBUG_BUS_CLKSEL, 0x1F),
> +       QMP_PHY_INIT_CFG(QPHY_V4_PCS_UFS_RX_MIN_HIBERN8_TIME, 0xFF),
> +       QMP_PHY_INIT_CFG(QPHY_V4_PCS_UFS_MULTI_LANE_CTRL1, 0x02),
> +       QMP_PHY_INIT_CFG(QPHY_V4_PCS_UFS_PLL_CNTL, 0x03),
> +       QMP_PHY_INIT_CFG(QPHY_V4_PCS_UFS_TIMER_20US_CORECLK_STEPS_MSB, 0x16),
> +       QMP_PHY_INIT_CFG(QPHY_V4_PCS_UFS_TIMER_20US_CORECLK_STEPS_LSB, 0xD8),
> +       QMP_PHY_INIT_CFG(QPHY_V4_PCS_UFS_TX_PWM_GEAR_BAND, 0xAA),
> +       QMP_PHY_INIT_CFG(QPHY_V4_PCS_UFS_TX_HS_GEAR_BAND, 0x06),
> +       QMP_PHY_INIT_CFG(QPHY_V4_PCS_UFS_TX_HSGEAR_CAPABILITY, 0x03),
> +       QMP_PHY_INIT_CFG(QPHY_V4_PCS_UFS_RX_HSGEAR_CAPABILITY, 0x03),
> +};
> +
>  static const struct qmp_phy_init_tbl sm8250_ufsphy_hs_g4_tx[] = {
>         QMP_PHY_INIT_CFG(QSERDES_V4_TX_LANE_MODE_1, 0xe5),
>  };
> @@ -521,6 +585,47 @@ static const struct qmp_phy_init_tbl sm8250_ufsphy_hs_g4_rx[] = {
>         QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH4, 0x3c),
>  };
>
> +static const struct qmp_phy_init_tbl sc7280_ufsphy_hs_g4_rx[] = {

Please put this next to sc7280 register arrays.

> +       QMP_PHY_INIT_CFG(QSERDES_V4_RX_SIGDET_LVL, 0x24),
> +       QMP_PHY_INIT_CFG(QSERDES_V4_RX_SIGDET_CNTRL, 0x0f),
> +       QMP_PHY_INIT_CFG(QSERDES_V4_RX_SIGDET_DEGLITCH_CNTRL, 0x1e),
> +       QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_BAND, 0x18),
> +       QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_FASTLOCK_FO_GAIN, 0x0a),
> +       QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_SO_SATURATION_AND_ENABLE, 0x5a),
> +       QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_PI_CONTROLS, 0xf1),
> +       QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_FASTLOCK_COUNT_LOW, 0x80),
> +       QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_PI_CTRL2, 0x81),
> +       QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_FO_GAIN, 0x0e),
> +       QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_SO_GAIN, 0x04),
> +       QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_TERM_BW, 0x6f),
> +       QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL1, 0x04),
> +       QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL2, 0x00),
> +       QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL3, 0x09),
> +       QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL4, 0x07),
> +       QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQ_OFFSET_ADAPTOR_CNTRL1, 0x17),
> +       QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_OFFSET_ADAPTOR_CNTRL2, 0x00),
> +       QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_IDAC_MEASURE_TIME, 0x20),
> +       QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_IDAC_TSETTLE_LOW, 0x80),
> +       QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_IDAC_TSETTLE_HIGH, 0x01),
> +       QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_LOW, 0x3f),
> +       QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH, 0xff),
> +       QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH2, 0xff),
> +       QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH3, 0x7f),
> +       QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH4, 0x2c),
> +       QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_LOW, 0x6d),
> +       QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH, 0x6d),
> +       QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH2, 0xed),
> +       QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH3, 0x3b),
> +       QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH4, 0x3c),
> +       QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_10_LOW, 0xe0),
> +       QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_10_HIGH, 0xc8),
> +       QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_10_HIGH2, 0xc8),
> +       QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_10_HIGH3, 0x3b),
> +       QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_10_HIGH4, 0xb1),
> +       QMP_PHY_INIT_CFG(QSERDES_V4_RX_DCC_CTRL1, 0x0c),
> +       QMP_PHY_INIT_CFG(QSERDES_V4_RX_GM_CAL, 0x0f),
> +};
> +
>  static const struct qmp_phy_init_tbl sm8350_ufsphy_serdes[] = {
>         QMP_PHY_INIT_CFG(QSERDES_V5_COM_SYSCLK_EN_SEL, 0xd9),
>         QMP_PHY_INIT_CFG(QSERDES_V5_COM_HSCLK_SEL, 0x11),
> @@ -1162,6 +1267,40 @@ static const struct qmp_phy_cfg sm8550_ufsphy_cfg = {
>         .regs                   = ufsphy_v6_regs_layout,
>  };
>
> +static const struct qmp_phy_cfg sc7280_ufsphy_cfg = {

This should come before sc8280xp entry.

> +       .lanes                  = 2,
> +
> +       .offsets                = &qmp_ufs_offsets,
> +
> +       .tbls = {
> +               .serdes         = sm8150_ufsphy_serdes,
> +               .serdes_num     = ARRAY_SIZE(sm8150_ufsphy_serdes),
> +               .tx             = sc7280_ufsphy_tx,
> +               .tx_num         = ARRAY_SIZE(sc7280_ufsphy_tx),
> +               .rx             = sc7280_ufsphy_rx,
> +               .rx_num         = ARRAY_SIZE(sc7280_ufsphy_rx),
> +               .pcs            = sc7280_ufsphy_pcs,
> +               .pcs_num        = ARRAY_SIZE(sc7280_ufsphy_pcs),
> +       },
> +       .tbls_hs_b = {
> +               .serdes         = sm8150_ufsphy_hs_b_serdes,
> +               .serdes_num     = ARRAY_SIZE(sm8150_ufsphy_hs_b_serdes),
> +       },
> +       .tbls_hs_g4 = {
> +               .tx             = sm8250_ufsphy_hs_g4_tx,
> +               .tx_num         = ARRAY_SIZE(sm8250_ufsphy_hs_g4_tx),
> +               .rx             = sc7280_ufsphy_hs_g4_rx,
> +               .rx_num         = ARRAY_SIZE(sc7280_ufsphy_hs_g4_rx),
> +               .pcs            = sm8150_ufsphy_hs_g4_pcs,
> +               .pcs_num        = ARRAY_SIZE(sm8150_ufsphy_hs_g4_pcs),
> +       },
> +       .clk_list               = sm8450_ufs_phy_clk_l,
> +       .num_clks               = ARRAY_SIZE(sm8450_ufs_phy_clk_l),
> +       .vreg_list              = qmp_phy_vreg_l,
> +       .num_vregs              = ARRAY_SIZE(qmp_phy_vreg_l),
> +       .regs                   = ufsphy_v4_regs_layout,
> +};
> +
>  static void qmp_ufs_configure_lane(void __iomem *base,
>                                         const struct qmp_phy_init_tbl tbl[],
>                                         int num,
> @@ -1682,6 +1821,9 @@ static const struct of_device_id qmp_ufs_of_match_table[] = {
>         }, {
>                 .compatible = "qcom,sm8550-qmp-ufs-phy",
>                 .data = &sm8550_ufsphy_cfg,
> +       }, {
> +               .compatible = "qcom,sc7280-qmp-ufs-phy",
> +               .data = &sc7280_ufsphy_cfg,

This list is sorted, please put new data to the proper place.

>         },
>         { },
>  };
> --
> 2.17.1
>


-- 
With best wishes
Dmitry
