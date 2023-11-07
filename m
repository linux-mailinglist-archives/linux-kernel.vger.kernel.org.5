Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 160C07E3FEB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 14:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234105AbjKGNUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 08:20:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234843AbjKGNUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 08:20:12 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B752CB7
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 05:18:21 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5ae143e08b1so66259637b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 05:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699363101; x=1699967901; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XOAz7Yz1hVnc07cr1rJCT+D1AoFPWMmt2VOimzlCXr4=;
        b=smE6iSffQb54iGnF3g4uA32YXvwtQF5/LiG6TbcD+k2yAYk91eMV+xNG/R9B1WOSwG
         /MIXgyUAXbsMoCRjmZozvnIz1fF/lZqYDrBMNH4pl6e43QTZcl6KvMH4Rxqqtltw6FN3
         IVlq/SYAI+wnMpWupUeq3ESOdDrICdpUvGnCdYDhlm4QI3hSPYvjR8fkw3AqdBAZH8U3
         b6ZldiFEegi+o89eScQVfaLSwnoC02jPZ0zxjA5fr03uyizmP0xlSYjoq5nGTnno4aTq
         oo4NPadyZc1IEvd+1gMWJGIrMor5W/JjI6wjcGdnEjBfStgBfZmgYXxIjjVI/Uj8KDlE
         zzEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699363101; x=1699967901;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XOAz7Yz1hVnc07cr1rJCT+D1AoFPWMmt2VOimzlCXr4=;
        b=GRPH0UrUdTT6bzUQg0j3UulGTlKC0U9bDMNuyb9YNey7t38zT2m78/elISCM4m021+
         5ghfsIHEtvLdHH6GaNZwHSLL7FA5vaZV2M6xMI2Q5O10Gq726Vshx0gICXupzdjVEnKY
         dT5yLFf3g9VDY9kh5f/mSpLWMSlEMizbQx76CrqrXHM2CfBfy4x/Pb0J/Fms/r+Hmo39
         PhU1Z3c9t6Nld2cx37qwn8b9dYs5N1rttDV7vMMj7/oe/OwrLTJlWWfRHV7ZcdKkwpmm
         qTDErU+8UwrbqXX0KUrCdifLY4sFWgWN4hIAheKQwJysd/xkYoK8syJz6sHl7AmIAJ1u
         nvBw==
X-Gm-Message-State: AOJu0Yz5R62vsqiBEHSXQKIv/wUnFrUJMIlBNbR8mohJRCHjnZ0580et
        9WtfloVjUuEh8jM/FhvOY3LcA0KCfHLZLIheH2dLag==
X-Google-Smtp-Source: AGHT+IGjiofGZf3AMI79AUaglb/duL28Vfp5m996o1yTx4cU+bMCr2OeZOISVkb9Zrq8n9m8n0QkEK7vHqqD1uUZiAE=
X-Received: by 2002:a81:4e13:0:b0:5a8:d86b:7469 with SMTP id
 c19-20020a814e13000000b005a8d86b7469mr14993775ywb.8.1699363100762; Tue, 07
 Nov 2023 05:18:20 -0800 (PST)
MIME-Version: 1.0
References: <1699332374-9324-1-git-send-email-cang@qti.qualcomm.com> <1699332374-9324-7-git-send-email-cang@qti.qualcomm.com>
In-Reply-To: <1699332374-9324-7-git-send-email-cang@qti.qualcomm.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 7 Nov 2023 15:18:09 +0200
Message-ID: <CAA8EJpqEkkEoQ9vncNJU1t=mKbvBXKk1FUxnmGTE0Q++sf=oXA@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] phy: qualcomm: phy-qcom-qmp-ufs: Add High Speed
 Gear 5 support for SM8550
To:     Can Guo <cang@qti.qualcomm.com>
Cc:     quic_cang@quicinc.com, bvanassche@acm.org, mani@kernel.org,
        stanley.chu@mediatek.com, adrian.hunter@intel.com,
        beanhuo@micron.com, avri.altman@wdc.com, junwoo80.lee@samsung.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Nov 2023 at 06:47, Can Guo <cang@qti.qualcomm.com> wrote:
>
> From: Can Guo <quic_cang@quicinc.com>
>
> On SM8550, two sets of UFS PHY settings are provided, one set is to support
> HS-G5, another set is to support HS-G4 and lower gears. The two sets of PHY
> settings are programming different values to different registers, mixing
> the two sets and/or overwriting one set with another set is definitely not
> blessed by UFS PHY designers. In order to add HS-G5 support for SM8550, we
> need to split the two sets into their dedicated tables, and leave only the
> common settings in the .tlbs. To have the PHY programmed with the correct
> set of PHY settings, the submode passed to PHY driver must be either HS-G4
> or HS-G5.
>
> Signed-off-by: Can Guo <quic_cang@quicinc.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v6.h     |   2 +
>  drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v6.h |   2 +
>  .../qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h    |  12 +++
>  drivers/phy/qualcomm/phy-qcom-qmp-ufs.c            | 112 ++++++++++++++++++---
>  4 files changed, 115 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v6.h b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v6.h
> index c23d5e4..e563af5 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v6.h
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v6.h
> @@ -18,6 +18,7 @@
>  #define QPHY_V6_PCS_UFS_BIST_FIXED_PAT_CTRL            0x060
>  #define QPHY_V6_PCS_UFS_TX_HSGEAR_CAPABILITY           0x074
>  #define QPHY_V6_PCS_UFS_RX_HSGEAR_CAPABILITY           0x0bc
> +#define QPHY_V6_PCS_UFS_RX_HS_G5_SYNC_LENGTH_CAPABILITY        0x12c
>  #define QPHY_V6_PCS_UFS_DEBUG_BUS_CLKSEL               0x158
>  #define QPHY_V6_PCS_UFS_LINECFG_DISABLE                        0x17c
>  #define QPHY_V6_PCS_UFS_RX_MIN_HIBERN8_TIME            0x184
> @@ -27,5 +28,6 @@
>  #define QPHY_V6_PCS_UFS_READY_STATUS                   0x1a8
>  #define QPHY_V6_PCS_UFS_TX_MID_TERM_CTRL1              0x1f4
>  #define QPHY_V6_PCS_UFS_MULTI_LANE_CTRL1               0x1fc
> +#define QPHY_V6_PCS_UFS_RX_HSG5_SYNC_WAIT_TIME         0x220
>
>  #endif
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v6.h b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v6.h
> index f420f8f..ef392ce 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v6.h
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v6.h
> @@ -56,6 +56,8 @@
>  #define QSERDES_V6_COM_SYS_CLK_CTRL                            0xe4
>  #define QSERDES_V6_COM_SYSCLK_BUF_ENABLE                       0xe8
>  #define QSERDES_V6_COM_PLL_IVCO                                        0xf4
> +#define QSERDES_V6_COM_CMN_IETRIM                              0xfc
> +#define QSERDES_V6_COM_CMN_IPTRIM                              0x100
>  #define QSERDES_V6_COM_SYSCLK_EN_SEL                           0x110
>  #define QSERDES_V6_COM_RESETSM_CNTRL                           0x118
>  #define QSERDES_V6_COM_LOCK_CMP_EN                             0x120
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h
> index 15bcb4b..48f31c8 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h
> @@ -10,10 +10,20 @@
>  #define QSERDES_UFS_V6_TX_RES_CODE_LANE_RX                     0x2c
>  #define QSERDES_UFS_V6_TX_RES_CODE_LANE_OFFSET_TX              0x30
>  #define QSERDES_UFS_V6_TX_RES_CODE_LANE_OFFSET_RX              0x34
> +#define QSERDES_UFS_V6_TX_LANE_MODE_1                          0x7c
> +#define QSERDES_UFS_V6_TX_FR_DCC_CTRL                          0x108
>
>  #define QSERDES_UFS_V6_RX_UCDR_FASTLOCK_FO_GAIN_RATE2          0x08
>  #define QSERDES_UFS_V6_RX_UCDR_FASTLOCK_FO_GAIN_RATE4          0x10
> +#define QSERDES_UFS_V6_RX_UCDR_FASTLOCK_SO_GAIN_RATE4          0x24
> +#define QSERDES_UFS_V6_RX_UCDR_FASTLOCK_COUNT_HIGH_RATE4       0x54
> +#define QSERDES_UFS_V6_RX_UCDR_FO_GAIN_RATE2                   0xd4
> +#define QSERDES_UFS_V6_RX_UCDR_FO_GAIN_RATE4                   0xdc
> +#define QSERDES_UFS_V6_RX_UCDR_SO_GAIN_RATE4                   0xf0
> +#define QSERDES_UFS_V6_RX_UCDR_PI_CONTROLS                     0xf4
>  #define QSERDES_UFS_V6_RX_VGA_CAL_MAN_VAL                      0x178
> +#define QSERDES_UFS_V6_RX_EQ_OFFSET_ADAPTOR_CNTRL1             0x1bc
> +#define QSERDES_UFS_V6_RX_OFFSET_ADAPTOR_CNTRL3                        0x1c4
>  #define QSERDES_UFS_V6_RX_MODE_RATE_0_1_B0                     0x208
>  #define QSERDES_UFS_V6_RX_MODE_RATE_0_1_B1                     0x20c
>  #define QSERDES_UFS_V6_RX_MODE_RATE_0_1_B3                     0x214
> @@ -25,6 +35,8 @@
>  #define QSERDES_UFS_V6_RX_MODE_RATE3_B5                                0x264
>  #define QSERDES_UFS_V6_RX_MODE_RATE3_B8                                0x270
>  #define QSERDES_UFS_V6_RX_MODE_RATE4_B3                                0x280
> +#define QSERDES_UFS_V6_RX_MODE_RATE4_B4                                0x284
>  #define QSERDES_UFS_V6_RX_MODE_RATE4_B6                                0x28c
> +#define QSERDES_UFS_V6_RX_DLL0_FTUNE_CTRL                      0x2f8
>
>  #endif
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> index 3927eba..e0a01497 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> @@ -649,32 +649,51 @@ static const struct qmp_phy_init_tbl sm8550_ufsphy_serdes[] = {
>         QMP_PHY_INIT_CFG(QSERDES_V6_COM_HSCLK_SEL_1, 0x11),
>         QMP_PHY_INIT_CFG(QSERDES_V6_COM_HSCLK_HS_SWITCH_SEL_1, 0x00),
>         QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP_EN, 0x01),
> -       QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE_MAP, 0x04),
> -       QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_IVCO, 0x0f),
> +
>         QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE_INITVAL2, 0x00),
>         QMP_PHY_INIT_CFG(QSERDES_V6_COM_DEC_START_MODE0, 0x41),
> -       QMP_PHY_INIT_CFG(QSERDES_V6_COM_CP_CTRL_MODE0, 0x0a),
>         QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_RCTRL_MODE0, 0x18),
>         QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_CCTRL_MODE0, 0x14),
>         QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP1_MODE0, 0x7f),
>         QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP2_MODE0, 0x06),
> -       QMP_PHY_INIT_CFG(QSERDES_V6_COM_DEC_START_MODE0, 0x4c),
> +};
> +
> +static const struct qmp_phy_init_tbl sm8550_ufsphy_hs_b_serdes[] = {
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE_MAP, 0x44),
> +};
> +
> +static const struct qmp_phy_init_tbl sm8550_ufsphy_g4_serdes[] = {
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE_MAP, 0x04),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_IVCO, 0x0f),
>         QMP_PHY_INIT_CFG(QSERDES_V6_COM_CP_CTRL_MODE0, 0x0a),
> -       QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_RCTRL_MODE0, 0x18),
> -       QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_CCTRL_MODE0, 0x14),
> -       QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP1_MODE0, 0x99),
> -       QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP2_MODE0, 0x07),

Aside from moving these registers to the HS_G4 table, you are also
changing these registers. It makes me think that there was an error in
the original programming sequence.
If that is correct, could you please split the patch into two pieces:
- Fix programming sequence (add proper Fixes tags)
- Split G4 and G5 tables.

> +
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_DEC_START_MODE1, 0x4c),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_CP_CTRL_MODE1, 0x0a),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_RCTRL_MODE1, 0x18),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_CCTRL_MODE1, 0x14),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP1_MODE1, 0x99),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP2_MODE1, 0x07),

I see all the MODE1 registers being only present in G4 and G5 tables.
Should they be programmed for the modes lower than G4?

> +};
> +
> +static const struct qmp_phy_init_tbl sm8550_ufsphy_g5_serdes[] = {
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_IVCO, 0x1f),
> +
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_CMN_IETRIM, 0x1b),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_CMN_IPTRIM, 0x1c),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_CP_CTRL_MODE0, 0x06),
>  };
>
>  static const struct qmp_phy_init_tbl sm8550_ufsphy_tx[] = {
> -       QMP_PHY_INIT_CFG(QSERDES_V6_TX_LANE_MODE_1, 0x05),
> +       QMP_PHY_INIT_CFG(QSERDES_UFS_V6_TX_LANE_MODE_1, 0x05),
>         QMP_PHY_INIT_CFG(QSERDES_UFS_V6_TX_RES_CODE_LANE_OFFSET_TX, 0x07),
>  };
>
> +static const struct qmp_phy_init_tbl sm8550_ufsphy_g4_tx[] = {
> +       QMP_PHY_INIT_CFG(QSERDES_UFS_V6_TX_FR_DCC_CTRL, 0x4c),
> +};
> +
>  static const struct qmp_phy_init_tbl sm8550_ufsphy_rx[] = {
> -       QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_UCDR_FASTLOCK_FO_GAIN_RATE2, 0x0c),
> -       QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_UCDR_FASTLOCK_FO_GAIN_RATE4, 0x0f),
> -       QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_VGA_CAL_MAN_VAL, 0x0e),
> +       QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_UCDR_FO_GAIN_RATE2, 0x0c),
>
>         QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE_0_1_B0, 0xc2),
>         QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE_0_1_B1, 0xc2),
> @@ -690,14 +709,46 @@ static const struct qmp_phy_init_tbl sm8550_ufsphy_rx[] = {
>         QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE3_B8, 0x02),
>  };
>
> +static const struct qmp_phy_init_tbl sm8550_ufsphy_g4_rx[] = {
> +       QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_VGA_CAL_MAN_VAL, 0x0e),
> +};
> +
> +static const struct qmp_phy_init_tbl sm8550_ufsphy_g5_rx[] = {
> +       QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_UCDR_FO_GAIN_RATE4, 0x0c),
> +       QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_UCDR_SO_GAIN_RATE4, 0x04),
> +       QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_EQ_OFFSET_ADAPTOR_CNTRL1, 0x14),
> +       QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_UCDR_PI_CONTROLS, 0x07),
> +       QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_OFFSET_ADAPTOR_CNTRL3, 0x0e),
> +       QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_UCDR_FASTLOCK_COUNT_HIGH_RATE4, 0x02),
> +       QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_UCDR_FASTLOCK_FO_GAIN_RATE4, 0x1c),
> +       QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_UCDR_FASTLOCK_SO_GAIN_RATE4, 0x06),
> +       QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_VGA_CAL_MAN_VAL, 0x08),
> +
> +       QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE4_B3, 0xb9),
> +       QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE4_B4, 0x4f),
> +       QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE4_B6, 0xff),
> +       QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_DLL0_FTUNE_CTRL, 0x30),
> +};
> +
>  static const struct qmp_phy_init_tbl sm8550_ufsphy_pcs[] = {
>         QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_RX_SIGDET_CTRL2, 0x69),
>         QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_TX_LARGE_AMP_DRV_LVL, 0x0f),
>         QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_TX_MID_TERM_CTRL1, 0x43),
> -       QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_PLL_CNTL, 0x2b),
>         QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_MULTI_LANE_CTRL1, 0x02),
>  };
>
> +static const struct qmp_phy_init_tbl sm8550_ufsphy_g4_pcs[] = {
> +       QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_PLL_CNTL, 0x2b),
> +       QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_TX_HSGEAR_CAPABILITY, 0x04),
> +       QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_RX_HSGEAR_CAPABILITY, 0x04),
> +};
> +
> +static const struct qmp_phy_init_tbl sm8550_ufsphy_g5_pcs[] = {
> +       QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_PLL_CNTL, 0x33),
> +       QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_RX_HS_G5_SYNC_LENGTH_CAPABILITY, 0x4f),
> +       QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_RX_HSG5_SYNC_WAIT_TIME, 0x9e),
> +};
> +
>  struct qmp_ufs_offsets {
>         u16 serdes;
>         u16 pcs;
> @@ -731,6 +782,8 @@ struct qmp_phy_cfg {
>         const struct qmp_phy_cfg_tbls tbls_hs_b;
>         /* Additional sequence for HS G4 */
>         const struct qmp_phy_cfg_tbls tbls_hs_g4;
> +       /* Additional sequence for HS G4 */
> +       const struct qmp_phy_cfg_tbls tbls_hs_g5;
>
>         /* clock ids to be requested */
>         const char * const *clk_list;
> @@ -1157,6 +1210,28 @@ static const struct qmp_phy_cfg sm8550_ufsphy_cfg = {
>                 .pcs            = sm8550_ufsphy_pcs,
>                 .pcs_num        = ARRAY_SIZE(sm8550_ufsphy_pcs),
>         },
> +       .tbls_hs_b = {
> +               .serdes         = sm8550_ufsphy_hs_b_serdes,
> +               .serdes_num     = ARRAY_SIZE(sm8550_ufsphy_hs_b_serdes),
> +       },
> +       .tbls_hs_g4 = {
> +               .serdes         = sm8550_ufsphy_g4_serdes,
> +               .serdes_num     = ARRAY_SIZE(sm8550_ufsphy_g4_serdes),
> +               .tx             = sm8550_ufsphy_g4_tx,
> +               .tx_num         = ARRAY_SIZE(sm8550_ufsphy_g4_tx),
> +               .rx             = sm8550_ufsphy_g4_rx,
> +               .rx_num         = ARRAY_SIZE(sm8550_ufsphy_g4_rx),
> +               .pcs            = sm8550_ufsphy_g4_pcs,
> +               .pcs_num        = ARRAY_SIZE(sm8550_ufsphy_g4_pcs),
> +       },
> +       .tbls_hs_g5 = {
> +               .serdes         = sm8550_ufsphy_g5_serdes,
> +               .serdes_num     = ARRAY_SIZE(sm8550_ufsphy_g5_serdes),
> +               .rx             = sm8550_ufsphy_g5_rx,
> +               .rx_num         = ARRAY_SIZE(sm8550_ufsphy_g5_rx),
> +               .pcs            = sm8550_ufsphy_g5_pcs,
> +               .pcs_num        = ARRAY_SIZE(sm8550_ufsphy_g5_pcs),
> +       },
>         .clk_list               = sdm845_ufs_phy_clk_l,
>         .num_clks               = ARRAY_SIZE(sdm845_ufs_phy_clk_l),
>         .vreg_list              = qmp_phy_vreg_l,
> @@ -1222,14 +1297,25 @@ static void qmp_ufs_pcs_init(struct qmp_ufs *qmp, const struct qmp_phy_cfg_tbls
>  static void qmp_ufs_init_registers(struct qmp_ufs *qmp, const struct qmp_phy_cfg *cfg)
>  {
>         qmp_ufs_serdes_init(qmp, &cfg->tbls);
> +       if (qmp->submode == UFS_HS_G4)
> +               qmp_ufs_serdes_init(qmp, &cfg->tbls_hs_g4);
> +       else if (qmp->submode == UFS_HS_G5)
> +               qmp_ufs_serdes_init(qmp, &cfg->tbls_hs_g5);
> +
>         if (qmp->mode == PHY_MODE_UFS_HS_B)
>                 qmp_ufs_serdes_init(qmp, &cfg->tbls_hs_b);
> +
>         qmp_ufs_lanes_init(qmp, &cfg->tbls);
>         if (qmp->submode == UFS_HS_G4)
>                 qmp_ufs_lanes_init(qmp, &cfg->tbls_hs_g4);
> +       else if (qmp->submode == UFS_HS_G5)
> +               qmp_ufs_lanes_init(qmp, &cfg->tbls_hs_g5);
> +
>         qmp_ufs_pcs_init(qmp, &cfg->tbls);
>         if (qmp->submode == UFS_HS_G4)
>                 qmp_ufs_pcs_init(qmp, &cfg->tbls_hs_g4);
> +       else if (qmp->submode == UFS_HS_G5)
> +               qmp_ufs_pcs_init(qmp, &cfg->tbls_hs_g5);
>  }
>
>  static int qmp_ufs_com_init(struct qmp_ufs *qmp)
> --
> 2.7.4
>
>


-- 
With best wishes
Dmitry
