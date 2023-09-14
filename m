Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD07D7A03CB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 14:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238155AbjINM1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 08:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238399AbjINM1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 08:27:20 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0DFB1FE2;
        Thu, 14 Sep 2023 05:27:15 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38EAmaw0001373;
        Thu, 14 Sep 2023 12:27:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=4R0HLQ7hpU8vhzd5+jyzrB3t3k5XzZQ1YFvJngqOmXY=;
 b=A3lKTVOnjkuiHh4DI7fKHBvEOR3bLFQoaYBFs/4U61rCYAT5F2WooWUYmDKrYqtZefzA
 0EztcWrDVrXdXU8SQsWHKXS0sjBvQIn8eVdRybDScAXpdWhoPNdtdkxB3lsotkNAQvFo
 syG7SWg283dJ2Q51gdSOQP+3fwPnQuF3bdua0ffq6cWEUWzELhZh4lsjzjSIaPNtDRQJ
 PdORANeMcmvAoEv1wg1L+VQDwHuM67L3qscKthruLV9xmGiAST+ZXkPwQdu3sQ/pSSgM
 s2Ax7l+oMcusIvHy36nt7alwKN6o6+7sj6KVkdj8JpNrUF7dm66Y4aexWfGuwyeCFb2G aw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t3qqa9n9c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 12:27:05 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38ECR4xk000468
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 12:27:04 GMT
Received: from [10.218.45.181] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 14 Sep
 2023 05:26:59 -0700
Message-ID: <bce78c63-139a-852a-f8bb-50510f9c4e7d@quicinc.com>
Date:   Thu, 14 Sep 2023 17:56:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH 3/6] phy: qualcomm: phy-qcom-qmp-ufs: Add High Speed Gear
 5 support for SM8550
Content-Language: en-US
To:     Can Guo <quic_cang@quicinc.com>, <mani@kernel.org>,
        <quic_nguyenb@quicinc.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1694411968-14413-1-git-send-email-quic_cang@quicinc.com>
 <1694411968-14413-4-git-send-email-quic_cang@quicinc.com>
From:   Nitin Rawat <quic_nitirawa@quicinc.com>
In-Reply-To: <1694411968-14413-4-git-send-email-quic_cang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: rDwxIdVMRfoOZqKsXgyYlFcB7s-_-wqq
X-Proofpoint-GUID: rDwxIdVMRfoOZqKsXgyYlFcB7s-_-wqq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_09,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 phishscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 mlxlogscore=999 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309140107
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/11/2023 11:29 AM, Can Guo wrote:
> Split High Speed Gear 4 PHY settings from common tables, and add PHY
> settings to support High Speed Gear 5.
> 

Hi Can,

Can you please add more details explaining the change. We can mention 
that are we spliting serdes setting for g3 and g4.

Also how about having 2 patches, one for splitting serdes configuration 
b/w gear3 and gear4 and other patch about new g5 setting.

-Nitin

> Signed-off-by: Can Guo <quic_cang@quicinc.com>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v6.h     |   2 +
>   drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v6.h |   2 +
>   .../qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h    |  12 +++
>   drivers/phy/qualcomm/phy-qcom-qmp-ufs.c            | 112 ++++++++++++++++++---
>   4 files changed, 115 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v6.h b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v6.h
> index c23d5e4..e563af5 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v6.h
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v6.h
> @@ -18,6 +18,7 @@
>   #define QPHY_V6_PCS_UFS_BIST_FIXED_PAT_CTRL		0x060
>   #define QPHY_V6_PCS_UFS_TX_HSGEAR_CAPABILITY		0x074
>   #define QPHY_V6_PCS_UFS_RX_HSGEAR_CAPABILITY		0x0bc
> +#define QPHY_V6_PCS_UFS_RX_HS_G5_SYNC_LENGTH_CAPABILITY	0x12c
>   #define QPHY_V6_PCS_UFS_DEBUG_BUS_CLKSEL		0x158
>   #define QPHY_V6_PCS_UFS_LINECFG_DISABLE			0x17c
>   #define QPHY_V6_PCS_UFS_RX_MIN_HIBERN8_TIME		0x184
> @@ -27,5 +28,6 @@
>   #define QPHY_V6_PCS_UFS_READY_STATUS			0x1a8
>   #define QPHY_V6_PCS_UFS_TX_MID_TERM_CTRL1		0x1f4
>   #define QPHY_V6_PCS_UFS_MULTI_LANE_CTRL1		0x1fc
> +#define QPHY_V6_PCS_UFS_RX_HSG5_SYNC_WAIT_TIME		0x220
>   
>   #endif
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v6.h b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v6.h
> index f420f8f..ef392ce 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v6.h
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v6.h
> @@ -56,6 +56,8 @@
>   #define QSERDES_V6_COM_SYS_CLK_CTRL				0xe4
>   #define QSERDES_V6_COM_SYSCLK_BUF_ENABLE			0xe8
>   #define QSERDES_V6_COM_PLL_IVCO					0xf4
> +#define QSERDES_V6_COM_CMN_IETRIM				0xfc
> +#define QSERDES_V6_COM_CMN_IPTRIM				0x100
>   #define QSERDES_V6_COM_SYSCLK_EN_SEL				0x110
>   #define QSERDES_V6_COM_RESETSM_CNTRL				0x118
>   #define QSERDES_V6_COM_LOCK_CMP_EN				0x120
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h
> index 15bcb4b..48f31c8 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h
> @@ -10,10 +10,20 @@
>   #define QSERDES_UFS_V6_TX_RES_CODE_LANE_RX			0x2c
>   #define QSERDES_UFS_V6_TX_RES_CODE_LANE_OFFSET_TX		0x30
>   #define QSERDES_UFS_V6_TX_RES_CODE_LANE_OFFSET_RX		0x34
> +#define QSERDES_UFS_V6_TX_LANE_MODE_1				0x7c
> +#define QSERDES_UFS_V6_TX_FR_DCC_CTRL				0x108
>   
>   #define QSERDES_UFS_V6_RX_UCDR_FASTLOCK_FO_GAIN_RATE2		0x08
>   #define QSERDES_UFS_V6_RX_UCDR_FASTLOCK_FO_GAIN_RATE4		0x10
> +#define QSERDES_UFS_V6_RX_UCDR_FASTLOCK_SO_GAIN_RATE4		0x24
> +#define QSERDES_UFS_V6_RX_UCDR_FASTLOCK_COUNT_HIGH_RATE4	0x54
> +#define QSERDES_UFS_V6_RX_UCDR_FO_GAIN_RATE2			0xd4
> +#define QSERDES_UFS_V6_RX_UCDR_FO_GAIN_RATE4			0xdc
> +#define QSERDES_UFS_V6_RX_UCDR_SO_GAIN_RATE4			0xf0
> +#define QSERDES_UFS_V6_RX_UCDR_PI_CONTROLS			0xf4
>   #define QSERDES_UFS_V6_RX_VGA_CAL_MAN_VAL			0x178
> +#define QSERDES_UFS_V6_RX_EQ_OFFSET_ADAPTOR_CNTRL1		0x1bc
> +#define QSERDES_UFS_V6_RX_OFFSET_ADAPTOR_CNTRL3			0x1c4
>   #define QSERDES_UFS_V6_RX_MODE_RATE_0_1_B0			0x208
>   #define QSERDES_UFS_V6_RX_MODE_RATE_0_1_B1			0x20c
>   #define QSERDES_UFS_V6_RX_MODE_RATE_0_1_B3			0x214
> @@ -25,6 +35,8 @@
>   #define QSERDES_UFS_V6_RX_MODE_RATE3_B5				0x264
>   #define QSERDES_UFS_V6_RX_MODE_RATE3_B8				0x270
>   #define QSERDES_UFS_V6_RX_MODE_RATE4_B3				0x280
> +#define QSERDES_UFS_V6_RX_MODE_RATE4_B4				0x284
>   #define QSERDES_UFS_V6_RX_MODE_RATE4_B6				0x28c
> +#define QSERDES_UFS_V6_RX_DLL0_FTUNE_CTRL			0x2f8
>   
>   #endif
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> index 8c877b6..d0ecacf 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> @@ -650,32 +650,51 @@ static const struct qmp_phy_init_tbl sm8550_ufsphy_serdes[] = {
>   	QMP_PHY_INIT_CFG(QSERDES_V6_COM_HSCLK_SEL_1, 0x11),
>   	QMP_PHY_INIT_CFG(QSERDES_V6_COM_HSCLK_HS_SWITCH_SEL_1, 0x00),
>   	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP_EN, 0x01),
> -	QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE_MAP, 0x04),
> -	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_IVCO, 0x0f),
> +
>   	QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE_INITVAL2, 0x00),
>   	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DEC_START_MODE0, 0x41),
> -	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CP_CTRL_MODE0, 0x0a),
>   	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_RCTRL_MODE0, 0x18),
>   	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_CCTRL_MODE0, 0x14),
>   	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP1_MODE0, 0x7f),
>   	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP2_MODE0, 0x06),
> -	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DEC_START_MODE0, 0x4c),
> +};
> +
> +static const struct qmp_phy_init_tbl sm8550_ufsphy_hs_b_serdes[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE_MAP, 0x44),
> +};
> +
> +static const struct qmp_phy_init_tbl sm8550_ufsphy_g4_serdes[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE_MAP, 0x04),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_IVCO, 0x0f),
>   	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CP_CTRL_MODE0, 0x0a),
> -	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_RCTRL_MODE0, 0x18),
> -	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_CCTRL_MODE0, 0x14),
> -	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP1_MODE0, 0x99),
> -	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP2_MODE0, 0x07),
> +
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DEC_START_MODE1, 0x4c),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CP_CTRL_MODE1, 0x0a),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_RCTRL_MODE1, 0x18),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_CCTRL_MODE1, 0x14),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP1_MODE1, 0x99),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP2_MODE1, 0x07),
> +};
> +
> +static const struct qmp_phy_init_tbl sm8550_ufsphy_g5_serdes[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_IVCO, 0x1f),
> +
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CMN_IETRIM, 0x1b),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CMN_IPTRIM, 0x1c),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CP_CTRL_MODE0, 0x06),
>   };
>   
>   static const struct qmp_phy_init_tbl sm8550_ufsphy_tx[] = {
> -	QMP_PHY_INIT_CFG(QSERDES_V6_TX_LANE_MODE_1, 0x05),
> +	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_TX_LANE_MODE_1, 0x05),
>   	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_TX_RES_CODE_LANE_OFFSET_TX, 0x07),
>   };
>   
> +static const struct qmp_phy_init_tbl sm8550_ufsphy_g4_tx[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_TX_FR_DCC_CTRL, 0x4c),
> +};
> +
>   static const struct qmp_phy_init_tbl sm8550_ufsphy_rx[] = {
> -	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_UCDR_FASTLOCK_FO_GAIN_RATE2, 0x0c),
> -	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_UCDR_FASTLOCK_FO_GAIN_RATE4, 0x0f),
> -	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_VGA_CAL_MAN_VAL, 0x0e),
> +	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_UCDR_FO_GAIN_RATE2, 0x0c),
>   
>   	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE_0_1_B0, 0xc2),
>   	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE_0_1_B1, 0xc2),
> @@ -691,14 +710,46 @@ static const struct qmp_phy_init_tbl sm8550_ufsphy_rx[] = {
>   	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE3_B8, 0x02),
>   };
>   
> +static const struct qmp_phy_init_tbl sm8550_ufsphy_g4_rx[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_VGA_CAL_MAN_VAL, 0x0e),
> +};
> +
> +static const struct qmp_phy_init_tbl sm8550_ufsphy_g5_rx[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_UCDR_FO_GAIN_RATE4, 0x0c),
> +	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_UCDR_SO_GAIN_RATE4, 0x04),
> +	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_EQ_OFFSET_ADAPTOR_CNTRL1, 0x14),
> +	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_UCDR_PI_CONTROLS, 0x07),
> +	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_OFFSET_ADAPTOR_CNTRL3, 0x0e),
> +	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_UCDR_FASTLOCK_COUNT_HIGH_RATE4, 0x02),
> +	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_UCDR_FASTLOCK_FO_GAIN_RATE4, 0x1c),
> +	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_UCDR_FASTLOCK_SO_GAIN_RATE4, 0x06),
> +	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_VGA_CAL_MAN_VAL, 0x08),
> +
> +	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE4_B3, 0xb9),
> +	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE4_B4, 0x4f),
> +	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE4_B6, 0xff),
> +	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_DLL0_FTUNE_CTRL, 0x30),
> +};
> +
>   static const struct qmp_phy_init_tbl sm8550_ufsphy_pcs[] = {
>   	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_RX_SIGDET_CTRL2, 0x69),
>   	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_TX_LARGE_AMP_DRV_LVL, 0x0f),
>   	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_TX_MID_TERM_CTRL1, 0x43),
> -	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_PLL_CNTL, 0x2b),
>   	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_MULTI_LANE_CTRL1, 0x02),
>   };
>   
> +static const struct qmp_phy_init_tbl sm8550_ufsphy_g4_pcs[] = {
> +	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_PLL_CNTL, 0x2b),
> +	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_TX_HSGEAR_CAPABILITY, 0x04),
> +	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_RX_HSGEAR_CAPABILITY, 0x04),
> +};
> +
> +static const struct qmp_phy_init_tbl sm8550_ufsphy_g5_pcs[] = {
> +	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_PLL_CNTL, 0x33),
> +	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_RX_HS_G5_SYNC_LENGTH_CAPABILITY, 0x4f),
> +	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_RX_HSG5_SYNC_WAIT_TIME, 0x9e),
> +};
> +
>   struct qmp_ufs_offsets {
>   	u16 serdes;
>   	u16 pcs;
> @@ -732,6 +783,8 @@ struct qmp_phy_cfg {
>   	const struct qmp_phy_cfg_tbls tbls_hs_b;
>   	/* Additional sequence for HS G4 */
>   	const struct qmp_phy_cfg_tbls tbls_hs_g4;
> +	/* Additional sequence for HS G4 */
> +	const struct qmp_phy_cfg_tbls tbls_hs_g5;
>   
>   	/* clock ids to be requested */
>   	const char * const *clk_list;
> @@ -1146,6 +1199,28 @@ static const struct qmp_phy_cfg sm8550_ufsphy_cfg = {
>   		.pcs		= sm8550_ufsphy_pcs,
>   		.pcs_num	= ARRAY_SIZE(sm8550_ufsphy_pcs),
>   	},
> +	.tbls_hs_b = {
> +		.serdes		= sm8550_ufsphy_hs_b_serdes,
> +		.serdes_num	= ARRAY_SIZE(sm8550_ufsphy_hs_b_serdes),
> +	},
> +	.tbls_hs_g4 = {
> +		.serdes		= sm8550_ufsphy_g4_serdes,
> +		.serdes_num	= ARRAY_SIZE(sm8550_ufsphy_g4_serdes),
> +		.tx		= sm8550_ufsphy_g4_tx,
> +		.tx_num		= ARRAY_SIZE(sm8550_ufsphy_g4_tx),
> +		.rx		= sm8550_ufsphy_g4_rx,
> +		.rx_num		= ARRAY_SIZE(sm8550_ufsphy_g4_rx),
> +		.pcs		= sm8550_ufsphy_g4_pcs,
> +		.pcs_num	= ARRAY_SIZE(sm8550_ufsphy_g4_pcs),
> +	},
> +	.tbls_hs_g5 = {
> +		.serdes		= sm8550_ufsphy_g5_serdes,
> +		.serdes_num	= ARRAY_SIZE(sm8550_ufsphy_g5_serdes),
> +		.rx		= sm8550_ufsphy_g5_rx,
> +		.rx_num		= ARRAY_SIZE(sm8550_ufsphy_g5_rx),
> +		.pcs		= sm8550_ufsphy_g5_pcs,
> +		.pcs_num	= ARRAY_SIZE(sm8550_ufsphy_g5_pcs),
> +	},
>   	.clk_list		= sdm845_ufs_phy_clk_l,
>   	.num_clks		= ARRAY_SIZE(sdm845_ufs_phy_clk_l),
>   	.vreg_list		= qmp_phy_vreg_l,
> @@ -1211,14 +1286,25 @@ static void qmp_ufs_pcs_init(struct qmp_ufs *qmp, const struct qmp_phy_cfg_tbls
>   static void qmp_ufs_init_registers(struct qmp_ufs *qmp, const struct qmp_phy_cfg *cfg)
>   {
>   	qmp_ufs_serdes_init(qmp, &cfg->tbls);
> +	if (qmp->submode == UFS_HS_G4)
> +		qmp_ufs_serdes_init(qmp, &cfg->tbls_hs_g4);
> +	else if (qmp->submode == UFS_HS_G5)
> +		qmp_ufs_serdes_init(qmp, &cfg->tbls_hs_g5);
> +
>   	if (qmp->mode == PHY_MODE_UFS_HS_B)
>   		qmp_ufs_serdes_init(qmp, &cfg->tbls_hs_b);
> +
>   	qmp_ufs_lanes_init(qmp, &cfg->tbls);
>   	if (qmp->submode == UFS_HS_G4)
>   		qmp_ufs_lanes_init(qmp, &cfg->tbls_hs_g4);
> +	else if (qmp->submode == UFS_HS_G5)
> +		qmp_ufs_lanes_init(qmp, &cfg->tbls_hs_g5);
> +
>   	qmp_ufs_pcs_init(qmp, &cfg->tbls);
>   	if (qmp->submode == UFS_HS_G4)
>   		qmp_ufs_pcs_init(qmp, &cfg->tbls_hs_g4);
> +	else if (qmp->submode == UFS_HS_G5)
> +		qmp_ufs_pcs_init(qmp, &cfg->tbls_hs_g5);
>   }
>   
>   static int qmp_ufs_com_init(struct qmp_ufs *qmp)
