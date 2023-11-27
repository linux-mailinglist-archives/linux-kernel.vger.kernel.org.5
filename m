Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71BF37F9E23
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 12:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232665AbjK0LH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 06:07:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232552AbjK0LH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 06:07:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A455DB8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 03:07:34 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CAB8C433C8;
        Mon, 27 Nov 2023 11:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701083254;
        bh=Dw10XYMUkFAfrrpRKBAxCtpIpBU0J1LKx9Ba6WeTt9k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=USEmMTkU19UZvpcqjMaru6fo9yzOqTWivweY0uGhSl7JMzqXcxavaPXbdjObmAspY
         UJ67HtNTKU+TpLz7n8D0zLLuIWyFZSQuhYKUMMzz3l+dVZ7n7HVkjir5Y+s/0h/WZt
         9wpONPXol8Md2fv7HWjtPNzvtknHjLWlIEub323UtkKp3oKF/796Z5tXL4C4h79kQQ
         +QhcvEZuJq2Sz6xMB+q67idgnrE4yLhXYgvUF7N+i+9wxSgP89ejG0cx0HwZnyMyvp
         HVj6hptgywrtSBdxPakEDSOd2B9So9zzafLQJM5SBULjbgteY6NBAGRO2LDBT6Ajz7
         qofYYLMZRW1nQ==
Date:   Mon, 27 Nov 2023 16:37:28 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Can Guo <quic_cang@quicinc.com>
Cc:     bvanassche@acm.org, mani@kernel.org, adrian.hunter@intel.com,
        beanhuo@micron.com, avri.altman@wdc.com, junwoo80.lee@samsung.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        "open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 08/10] phy: qualcomm: phy-qcom-qmp-ufs: Rectify SM8550
 UFS HS-G4 PHY Settings
Message-ID: <ZWR4cN0sJNcVHPrL@matsya>
References: <1700729190-17268-1-git-send-email-quic_cang@quicinc.com>
 <1700729190-17268-9-git-send-email-quic_cang@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1700729190-17268-9-git-send-email-quic_cang@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-11-23, 00:46, Can Guo wrote:
> The registers, which are being touched in current SM8550 UFS PHY settings,
> and the values being programmed are mainly the ones working for HS-G4 mode,
> meanwhile, there are also a few ones somehow taken from HS-G5 PHY settings.
> However, even consider HS-G4 mode only, some of them are incorrect and some
> are missing. Rectify the HS-G4 PHY settings by strictly aligning with the
> SM8550 UFS PHY Hardware Programming Guide suggested HS-G4 PHY settings.

can you copy on cover so that we know the context of the series, I just
got hit with two patches out of the blue with this

> 
> Fixes: 1679bfef906f ("phy: qcom-qmp-ufs: Add SM8550 support")
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Reviewed-by: Abel Vesa <abel.vesa@linaro.org>
> Signed-off-by: Can Guo <quic_cang@quicinc.com>
> ---
>  .../qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h    |  3 +++
>  drivers/phy/qualcomm/phy-qcom-qmp-ufs.c            | 28 +++++++++++++++-------
>  2 files changed, 22 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h
> index 15bcb4b..674f158 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h
> @@ -10,9 +10,12 @@
>  #define QSERDES_UFS_V6_TX_RES_CODE_LANE_RX			0x2c
>  #define QSERDES_UFS_V6_TX_RES_CODE_LANE_OFFSET_TX		0x30
>  #define QSERDES_UFS_V6_TX_RES_CODE_LANE_OFFSET_RX		0x34
> +#define QSERDES_UFS_V6_TX_LANE_MODE_1				0x7c
> +#define QSERDES_UFS_V6_TX_FR_DCC_CTRL				0x108
>  
>  #define QSERDES_UFS_V6_RX_UCDR_FASTLOCK_FO_GAIN_RATE2		0x08
>  #define QSERDES_UFS_V6_RX_UCDR_FASTLOCK_FO_GAIN_RATE4		0x10
> +#define QSERDES_UFS_V6_RX_UCDR_FO_GAIN_RATE2			0xd4
>  #define QSERDES_UFS_V6_RX_VGA_CAL_MAN_VAL			0x178
>  #define QSERDES_UFS_V6_RX_MODE_RATE_0_1_B0			0x208
>  #define QSERDES_UFS_V6_RX_MODE_RATE_0_1_B1			0x20c
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> index 3927eba..ad91f92 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> @@ -658,22 +658,26 @@ static const struct qmp_phy_init_tbl sm8550_ufsphy_serdes[] = {
>  	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_CCTRL_MODE0, 0x14),
>  	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP1_MODE0, 0x7f),
>  	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP2_MODE0, 0x06),
> -	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DEC_START_MODE0, 0x4c),
> -	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CP_CTRL_MODE0, 0x0a),
> -	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_RCTRL_MODE0, 0x18),
> -	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_CCTRL_MODE0, 0x14),
> -	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP1_MODE0, 0x99),
> -	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP2_MODE0, 0x07),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DEC_START_MODE1, 0x4c),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CP_CTRL_MODE1, 0x0a),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_RCTRL_MODE1, 0x18),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_CCTRL_MODE1, 0x14),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP1_MODE1, 0x99),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP2_MODE1, 0x07),
> +};
> +
> +static const struct qmp_phy_init_tbl sm8550_ufsphy_hs_b_serdes[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE_MAP, 0x44),
>  };
>  
>  static const struct qmp_phy_init_tbl sm8550_ufsphy_tx[] = {
> -	QMP_PHY_INIT_CFG(QSERDES_V6_TX_LANE_MODE_1, 0x05),
> +	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_TX_LANE_MODE_1, 0x05),
>  	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_TX_RES_CODE_LANE_OFFSET_TX, 0x07),
> +	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_TX_FR_DCC_CTRL, 0x4c),
>  };
>  
>  static const struct qmp_phy_init_tbl sm8550_ufsphy_rx[] = {
> -	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_UCDR_FASTLOCK_FO_GAIN_RATE2, 0x0c),
> -	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_UCDR_FASTLOCK_FO_GAIN_RATE4, 0x0f),
> +	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_UCDR_FO_GAIN_RATE2, 0x0c),
>  	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_VGA_CAL_MAN_VAL, 0x0e),
>  
>  	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE_0_1_B0, 0xc2),
> @@ -696,6 +700,8 @@ static const struct qmp_phy_init_tbl sm8550_ufsphy_pcs[] = {
>  	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_TX_MID_TERM_CTRL1, 0x43),
>  	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_PLL_CNTL, 0x2b),
>  	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_MULTI_LANE_CTRL1, 0x02),
> +	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_TX_HSGEAR_CAPABILITY, 0x04),
> +	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_RX_HSGEAR_CAPABILITY, 0x04),
>  };
>  
>  struct qmp_ufs_offsets {
> @@ -1157,6 +1163,10 @@ static const struct qmp_phy_cfg sm8550_ufsphy_cfg = {
>  		.pcs		= sm8550_ufsphy_pcs,
>  		.pcs_num	= ARRAY_SIZE(sm8550_ufsphy_pcs),
>  	},
> +	.tbls_hs_b = {
> +		.serdes		= sm8550_ufsphy_hs_b_serdes,
> +		.serdes_num	= ARRAY_SIZE(sm8550_ufsphy_hs_b_serdes),
> +	},
>  	.clk_list		= sdm845_ufs_phy_clk_l,
>  	.num_clks		= ARRAY_SIZE(sdm845_ufs_phy_clk_l),
>  	.vreg_list		= qmp_phy_vreg_l,
> -- 
> 2.7.4

-- 
~Vinod
