Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 511507F41B3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 10:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343535AbjKVJbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 04:31:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235206AbjKVJbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 04:31:45 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84731199;
        Wed, 22 Nov 2023 01:31:39 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AM7WIIU005700;
        Wed, 22 Nov 2023 09:31:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=UZT6pMT3Yc+tJP/gvr5ZTm8gAzVVp21h0D3dSHbbqGM=;
 b=XySQsBPuU/LE+Bwo6ACuXQys/L5iNP777yFruwUIraHXi50kWyPREEJauDyIHOrAI+Ug
 2OWWNfTm45WAnaK7sJUfDBoP7z1Eu4Q6mFqoyWhSTSSC33ZBvVcxoo/IFE/H3Zo8xkHA
 999QkOy4wUelPaUIE/Z0JF+bt/Vycz1uLYbDFGzsipTGyJsCNiXXnkW4z9EF0KFNvdHY
 TdfAN9CB205TpilmniOrVcsVJELEgANXQZDvZ0uBH4GSR4GbNyl8QMqoWKIWqofLcQv0
 owJ4JIJaybbOvnoPAdPGSvyHgYeFciYSE9K0WVLaEhey72KSq5EQH/nqKdNPP/M7vDWQ Pw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uhbsp8pc0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Nov 2023 09:31:14 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AM9VDAL022553
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Nov 2023 09:31:13 GMT
Received: from [10.253.15.194] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 22 Nov
 2023 01:31:09 -0800
Message-ID: <3f040669-8ac3-46f4-b5ed-abe908e11042@quicinc.com>
Date:   Wed, 22 Nov 2023 17:31:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/11] phy: qualcomm: phy-qcom-qmp-ufs: Add High Speed
 Gear 5 support for SM8550
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     <bvanassche@acm.org>, <mani@kernel.org>,
        <stanley.chu@mediatek.com>, <adrian.hunter@intel.com>,
        <beanhuo@micron.com>, <avri.altman@wdc.com>,
        <junwoo80.lee@samsung.com>, <martin.petersen@oracle.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1700637042-11104-1-git-send-email-quic_cang@quicinc.com>
 <1700637042-11104-11-git-send-email-quic_cang@quicinc.com>
 <CAA8EJpqi=Xh0rbz9O6axtji_Vb5ebUiWqmM8s2OpFK13sE6S1Q@mail.gmail.com>
Content-Language: en-US
From:   Can Guo <quic_cang@quicinc.com>
In-Reply-To: <CAA8EJpqi=Xh0rbz9O6axtji_Vb5ebUiWqmM8s2OpFK13sE6S1Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: cPmHzaOThoE5TTsWH2WGJMA-GgK6Z9db
X-Proofpoint-GUID: cPmHzaOThoE5TTsWH2WGJMA-GgK6Z9db
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-22_06,2023-11-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 phishscore=0 bulkscore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311220066
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/22/2023 5:07 PM, Dmitry Baryshkov wrote:
> On Wed, 22 Nov 2023 at 09:11, Can Guo <quic_cang@quicinc.com> wrote:
>>
>> On SM8550, two sets of UFS PHY settings are provided, one set is to support
>> HS-G5, another set is to support HS-G4 and lower gears. The two sets of PHY
>> settings are programming different values to different registers, mixing
>> the two sets and/or overwriting one set with another set is definitely not
>> blessed by UFS PHY designers.
>>
>> To add HS-G5 support for SM8550, split the two sets of PHY settings into
>> their dedicated tables, G5 specific settings are put into .tbls_hs_max,
>> no-G5 settings are put into .tbls_hs_not_max. Only the common parts of the
>> two sets of PHY settings are left in the .tbls.
>>
>> In this case, .tbls alone is not a complete set of PHY settings, so either
>> tbls_hs_max or tbls_hs_not_max should be applied on top of the .tbls to
>> become a complete set of PHY settings.
>>
>> Signed-off-by: Can Guo <quic_cang@quicinc.com>
>> ---
>>   drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v6.h     |   2 +
>>   drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v6.h |   2 +
>>   .../qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h    |   9 ++
>>   drivers/phy/qualcomm/phy-qcom-qmp-ufs.c            | 102 +++++++++++++++++++--
>>   4 files changed, 105 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v6.h b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v6.h
>> index c23d5e4..e563af5 100644
>> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v6.h
>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v6.h
>> @@ -18,6 +18,7 @@
>>   #define QPHY_V6_PCS_UFS_BIST_FIXED_PAT_CTRL            0x060
>>   #define QPHY_V6_PCS_UFS_TX_HSGEAR_CAPABILITY           0x074
>>   #define QPHY_V6_PCS_UFS_RX_HSGEAR_CAPABILITY           0x0bc
>> +#define QPHY_V6_PCS_UFS_RX_HS_G5_SYNC_LENGTH_CAPABILITY        0x12c
>>   #define QPHY_V6_PCS_UFS_DEBUG_BUS_CLKSEL               0x158
>>   #define QPHY_V6_PCS_UFS_LINECFG_DISABLE                        0x17c
>>   #define QPHY_V6_PCS_UFS_RX_MIN_HIBERN8_TIME            0x184
>> @@ -27,5 +28,6 @@
>>   #define QPHY_V6_PCS_UFS_READY_STATUS                   0x1a8
>>   #define QPHY_V6_PCS_UFS_TX_MID_TERM_CTRL1              0x1f4
>>   #define QPHY_V6_PCS_UFS_MULTI_LANE_CTRL1               0x1fc
>> +#define QPHY_V6_PCS_UFS_RX_HSG5_SYNC_WAIT_TIME         0x220
>>
>>   #endif
>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v6.h b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v6.h
>> index f420f8f..ef392ce 100644
>> --- a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v6.h
>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v6.h
>> @@ -56,6 +56,8 @@
>>   #define QSERDES_V6_COM_SYS_CLK_CTRL                            0xe4
>>   #define QSERDES_V6_COM_SYSCLK_BUF_ENABLE                       0xe8
>>   #define QSERDES_V6_COM_PLL_IVCO                                        0xf4
>> +#define QSERDES_V6_COM_CMN_IETRIM                              0xfc
>> +#define QSERDES_V6_COM_CMN_IPTRIM                              0x100
>>   #define QSERDES_V6_COM_SYSCLK_EN_SEL                           0x110
>>   #define QSERDES_V6_COM_RESETSM_CNTRL                           0x118
>>   #define QSERDES_V6_COM_LOCK_CMP_EN                             0x120
>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h
>> index 674f158..48f31c8 100644
>> --- a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h
>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h
>> @@ -15,8 +15,15 @@
>>
>>   #define QSERDES_UFS_V6_RX_UCDR_FASTLOCK_FO_GAIN_RATE2          0x08
>>   #define QSERDES_UFS_V6_RX_UCDR_FASTLOCK_FO_GAIN_RATE4          0x10
>> +#define QSERDES_UFS_V6_RX_UCDR_FASTLOCK_SO_GAIN_RATE4          0x24
>> +#define QSERDES_UFS_V6_RX_UCDR_FASTLOCK_COUNT_HIGH_RATE4       0x54
>>   #define QSERDES_UFS_V6_RX_UCDR_FO_GAIN_RATE2                   0xd4
>> +#define QSERDES_UFS_V6_RX_UCDR_FO_GAIN_RATE4                   0xdc
>> +#define QSERDES_UFS_V6_RX_UCDR_SO_GAIN_RATE4                   0xf0
>> +#define QSERDES_UFS_V6_RX_UCDR_PI_CONTROLS                     0xf4
>>   #define QSERDES_UFS_V6_RX_VGA_CAL_MAN_VAL                      0x178
>> +#define QSERDES_UFS_V6_RX_EQ_OFFSET_ADAPTOR_CNTRL1             0x1bc
>> +#define QSERDES_UFS_V6_RX_OFFSET_ADAPTOR_CNTRL3                        0x1c4
>>   #define QSERDES_UFS_V6_RX_MODE_RATE_0_1_B0                     0x208
>>   #define QSERDES_UFS_V6_RX_MODE_RATE_0_1_B1                     0x20c
>>   #define QSERDES_UFS_V6_RX_MODE_RATE_0_1_B3                     0x214
>> @@ -28,6 +35,8 @@
>>   #define QSERDES_UFS_V6_RX_MODE_RATE3_B5                                0x264
>>   #define QSERDES_UFS_V6_RX_MODE_RATE3_B8                                0x270
>>   #define QSERDES_UFS_V6_RX_MODE_RATE4_B3                                0x280
>> +#define QSERDES_UFS_V6_RX_MODE_RATE4_B4                                0x284
>>   #define QSERDES_UFS_V6_RX_MODE_RATE4_B6                                0x28c
>> +#define QSERDES_UFS_V6_RX_DLL0_FTUNE_CTRL                      0x2f8
>>
>>   #endif
>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
>> index cae27a9..7a382c4 100644
>> --- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
>> @@ -649,15 +649,22 @@ static const struct qmp_phy_init_tbl sm8550_ufsphy_serdes[] = {
>>          QMP_PHY_INIT_CFG(QSERDES_V6_COM_HSCLK_SEL_1, 0x11),
>>          QMP_PHY_INIT_CFG(QSERDES_V6_COM_HSCLK_HS_SWITCH_SEL_1, 0x00),
>>          QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP_EN, 0x01),
>> -       QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE_MAP, 0x04),
>> -       QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_IVCO, 0x0f),
>>          QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE_INITVAL2, 0x00),
>>          QMP_PHY_INIT_CFG(QSERDES_V6_COM_DEC_START_MODE0, 0x41),
>> -       QMP_PHY_INIT_CFG(QSERDES_V6_COM_CP_CTRL_MODE0, 0x0a),
>>          QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_RCTRL_MODE0, 0x18),
>>          QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_CCTRL_MODE0, 0x14),
>>          QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP1_MODE0, 0x7f),
>>          QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP2_MODE0, 0x06),
>> +};
>> +
>> +static const struct qmp_phy_init_tbl sm8550_ufsphy_hs_b_serdes[] = {
>> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE_MAP, 0x44),
>> +};
>> +
>> +static const struct qmp_phy_init_tbl sm8550_ufsphy_g4_serdes[] = {
>> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE_MAP, 0x04),
>> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_IVCO, 0x0f),
>> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_CP_CTRL_MODE0, 0x0a),
>>          QMP_PHY_INIT_CFG(QSERDES_V6_COM_DEC_START_MODE1, 0x4c),
>>          QMP_PHY_INIT_CFG(QSERDES_V6_COM_CP_CTRL_MODE1, 0x0a),
>>          QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_RCTRL_MODE1, 0x18),
>> @@ -666,19 +673,24 @@ static const struct qmp_phy_init_tbl sm8550_ufsphy_serdes[] = {
>>          QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP2_MODE1, 0x07),
>>   };
>>
>> -static const struct qmp_phy_init_tbl sm8550_ufsphy_hs_b_serdes[] = {
>> -       QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE_MAP, 0x44),
>> +static const struct qmp_phy_init_tbl sm8550_ufsphy_g5_serdes[] = {
>> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_IVCO, 0x1f),
>> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_CMN_IETRIM, 0x1b),
>> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_CMN_IPTRIM, 0x1c),
>> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_CP_CTRL_MODE0, 0x06),
>>   };
>>
>>   static const struct qmp_phy_init_tbl sm8550_ufsphy_tx[] = {
>>          QMP_PHY_INIT_CFG(QSERDES_UFS_V6_TX_LANE_MODE_1, 0x05),
>>          QMP_PHY_INIT_CFG(QSERDES_UFS_V6_TX_RES_CODE_LANE_OFFSET_TX, 0x07),
>> +};
>> +
>> +static const struct qmp_phy_init_tbl sm8550_ufsphy_g4_tx[] = {
>>          QMP_PHY_INIT_CFG(QSERDES_UFS_V6_TX_FR_DCC_CTRL, 0x4c),
>>   };
>>
>>   static const struct qmp_phy_init_tbl sm8550_ufsphy_rx[] = {
>>          QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_UCDR_FO_GAIN_RATE2, 0x0c),
>> -       QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_VGA_CAL_MAN_VAL, 0x0e),
>>
>>          QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE_0_1_B0, 0xc2),
>>          QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE_0_1_B1, 0xc2),
>> @@ -694,16 +706,45 @@ static const struct qmp_phy_init_tbl sm8550_ufsphy_rx[] = {
>>          QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE3_B8, 0x02),
>>   };
>>
>> +static const struct qmp_phy_init_tbl sm8550_ufsphy_g4_rx[] = {
>> +       QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_VGA_CAL_MAN_VAL, 0x0e),
>> +};
>> +
>> +static const struct qmp_phy_init_tbl sm8550_ufsphy_g5_rx[] = {
>> +       QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_UCDR_FO_GAIN_RATE4, 0x0c),
>> +       QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_UCDR_SO_GAIN_RATE4, 0x04),
>> +       QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_EQ_OFFSET_ADAPTOR_CNTRL1, 0x14),
>> +       QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_UCDR_PI_CONTROLS, 0x07),
>> +       QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_OFFSET_ADAPTOR_CNTRL3, 0x0e),
>> +       QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_UCDR_FASTLOCK_COUNT_HIGH_RATE4, 0x02),
>> +       QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_UCDR_FASTLOCK_FO_GAIN_RATE4, 0x1c),
>> +       QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_UCDR_FASTLOCK_SO_GAIN_RATE4, 0x06),
>> +       QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_VGA_CAL_MAN_VAL, 0x08),
>> +       QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE4_B3, 0xb9),
>> +       QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE4_B4, 0x4f),
>> +       QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE4_B6, 0xff),
>> +       QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_DLL0_FTUNE_CTRL, 0x30),
>> +};
>> +
>>   static const struct qmp_phy_init_tbl sm8550_ufsphy_pcs[] = {
>>          QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_RX_SIGDET_CTRL2, 0x69),
>>          QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_TX_LARGE_AMP_DRV_LVL, 0x0f),
>>          QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_TX_MID_TERM_CTRL1, 0x43),
>> -       QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_PLL_CNTL, 0x2b),
>>          QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_MULTI_LANE_CTRL1, 0x02),
>> +};
>> +
>> +static const struct qmp_phy_init_tbl sm8550_ufsphy_g4_pcs[] = {
>> +       QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_PLL_CNTL, 0x2b),
>>          QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_TX_HSGEAR_CAPABILITY, 0x04),
>>          QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_RX_HSGEAR_CAPABILITY, 0x04),
>>   };
>>
>> +static const struct qmp_phy_init_tbl sm8550_ufsphy_g5_pcs[] = {
>> +       QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_PLL_CNTL, 0x33),
>> +       QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_RX_HS_G5_SYNC_LENGTH_CAPABILITY, 0x4f),
>> +       QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_RX_HSG5_SYNC_WAIT_TIME, 0x9e),
>> +};
>> +
>>   struct qmp_ufs_offsets {
>>          u16 serdes;
>>          u16 pcs;
>> @@ -735,6 +776,8 @@ struct qmp_phy_cfg {
>>          const struct qmp_phy_cfg_tbls tbls;
>>          /* Additional sequence for HS Series B */
>>          const struct qmp_phy_cfg_tbls tbls_hs_b;
>> +       /* Additional sequence for HS Gears which are lower than the maximum supported HS Gear */
>> +       const struct qmp_phy_cfg_tbls tbls_hs_not_max;
> 
> I doubt that this is a good solution. What if at some point we want to
> have a third option? Would we add no-so-max? Or tbls-hs-in-the-middle?
>  > If you want to make this configurable, you can implement the array of
> gear-setting pairs and then loop over that array, selecting the
> correct programming sequence.

ok.

> 
>>          /* Additional sequence for maximum supported HS Gear */
>>          const struct qmp_phy_cfg_tbls tbls_hs_max;
>>
>> @@ -1155,7 +1198,7 @@ static const struct qmp_phy_cfg sm8550_ufsphy_cfg = {
>>          .lanes                  = 2,
>>
>>          .offsets                = &qmp_ufs_offsets_v6,
>> -       .max_hs_gear            = UFS_HS_G4,
>> +       .max_hs_gear            = UFS_HS_G5,
>>          .tbls = {
>>                  .serdes         = sm8550_ufsphy_serdes,
>>                  .serdes_num     = ARRAY_SIZE(sm8550_ufsphy_serdes),
>> @@ -1170,6 +1213,24 @@ static const struct qmp_phy_cfg sm8550_ufsphy_cfg = {
>>                  .serdes         = sm8550_ufsphy_hs_b_serdes,
>>                  .serdes_num     = ARRAY_SIZE(sm8550_ufsphy_hs_b_serdes),
>>          },
>> +       .tbls_hs_not_max = {
>> +               .serdes         = sm8550_ufsphy_g4_serdes,
>> +               .serdes_num     = ARRAY_SIZE(sm8550_ufsphy_g4_serdes),
>> +               .tx             = sm8550_ufsphy_g4_tx,
>> +               .tx_num         = ARRAY_SIZE(sm8550_ufsphy_g4_tx),
>> +               .rx             = sm8550_ufsphy_g4_rx,
>> +               .rx_num         = ARRAY_SIZE(sm8550_ufsphy_g4_rx),
>> +               .pcs            = sm8550_ufsphy_g4_pcs,
>> +               .pcs_num        = ARRAY_SIZE(sm8550_ufsphy_g4_pcs),
>> +       },
>> +       .tbls_hs_max = {
>> +               .serdes         = sm8550_ufsphy_g5_serdes,
>> +               .serdes_num     = ARRAY_SIZE(sm8550_ufsphy_g5_serdes),
>> +               .rx             = sm8550_ufsphy_g5_rx,
>> +               .rx_num         = ARRAY_SIZE(sm8550_ufsphy_g5_rx),
>> +               .pcs            = sm8550_ufsphy_g5_pcs,
>> +               .pcs_num        = ARRAY_SIZE(sm8550_ufsphy_g5_pcs),
>> +       },
>>          .clk_list               = sdm845_ufs_phy_clk_l,
>>          .num_clks               = ARRAY_SIZE(sdm845_ufs_phy_clk_l),
>>          .vreg_list              = qmp_phy_vreg_l,
>> @@ -1232,17 +1293,36 @@ static void qmp_ufs_pcs_init(struct qmp_ufs *qmp, const struct qmp_phy_cfg_tbls
>>          qmp_ufs_configure(pcs, tbls->pcs, tbls->pcs_num);
>>   }
>>
>> -static void qmp_ufs_init_registers(struct qmp_ufs *qmp, const struct qmp_phy_cfg *cfg)
>> +static int qmp_ufs_init_registers(struct qmp_ufs *qmp, const struct qmp_phy_cfg *cfg)
>>   {
>> +       if (qmp->submode > cfg->max_hs_gear) {
>> +               dev_err(qmp->dev, "PHY submode %u exceeds maximum supported gear %u\n",
>> +                       qmp->submode, cfg->max_hs_gear);
>> +               return -EINVAL;
>> +       }
>> +
>>          qmp_ufs_serdes_init(qmp, &cfg->tbls);
>> +       if (qmp->submode == cfg->max_hs_gear)
>> +               qmp_ufs_serdes_init(qmp, &cfg->tbls_hs_max);
>> +       else
>> +               qmp_ufs_serdes_init(qmp, &cfg->tbls_hs_not_max);
>> +
>>          if (qmp->mode == PHY_MODE_UFS_HS_B)
>>                  qmp_ufs_serdes_init(qmp, &cfg->tbls_hs_b);
>> +
>>          qmp_ufs_lanes_init(qmp, &cfg->tbls);
>>          if (qmp->submode == cfg->max_hs_gear)
>>                  qmp_ufs_lanes_init(qmp, &cfg->tbls_hs_max);
>> +       else
>> +               qmp_ufs_lanes_init(qmp, &cfg->tbls_hs_not_max);
>> +
>>          qmp_ufs_pcs_init(qmp, &cfg->tbls);
>>          if (qmp->submode == cfg->max_hs_gear)
>>                  qmp_ufs_pcs_init(qmp, &cfg->tbls_hs_max);
>> +       else
>> +               qmp_ufs_pcs_init(qmp, &cfg->tbls_hs_not_max);
> 
> Also, if I remember correctly from your and Mani's comments, the UFS
> host will not set HS_G2 on this SoC. Is my understanding correct?
> If so, I think, requesting the mode for which the driver doesn't have
> correct settings should result in the error rather than silently using
> the better gear.
> 
> Note: I might be wrong here. If it is really fine to use e.g. HS_G4
> settings as HS_G2, then it is fine.

Use HS-G4 setting, and put the UFS in HS-G2 mode is OK, HS_G4 settings 
support HS-G4 and any lower gear modes, so it is fine.

For any given platforms, our chipset validation team validate all 
possible gear modes with one set of settings, e.g., they validate 
G1/G2/G3/G4 modes with G4 settings and G1/G2/G3/G4/G5 modes with G5 
settings.

Thanks,
Can Guo.
> 
>> +
>> +       return 0;
>>   }
>>
>>   static int qmp_ufs_com_init(struct qmp_ufs *qmp)
>> @@ -1334,7 +1414,9 @@ static int qmp_ufs_power_on(struct phy *phy)
>>          unsigned int val;
>>          int ret;
>>
>> -       qmp_ufs_init_registers(qmp, cfg);
>> +       ret = qmp_ufs_init_registers(qmp, cfg);
>> +       if (ret)
>> +               return ret;
>>
>>          ret = reset_control_deassert(qmp->ufs_reset);
>>          if (ret)
>> --
>> 2.7.4
>>
>>
> 
> 
