Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF177E5253
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 10:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235332AbjKHJDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 04:03:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232634AbjKHJDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 04:03:03 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6AF01716;
        Wed,  8 Nov 2023 01:03:01 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A851Ixm013767;
        Wed, 8 Nov 2023 09:02:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=8htYPSP8ebAjFJKstgOXCsdPCGHsMXa2RX+jP1KfnvM=;
 b=mtICPFTkg3ORLSJ8kAq4izHNDJ1Ot72QJuH+3PI2yo0s+PXyJeG/w2bcbkIqqyUJUYZo
 cAlq/bta4YDHwpeulh2u4NeJnqS5iutLhUF/PvKwRJD0kJmLFqsOhCBSIZdASfnVrCX1
 NgBwhrvnDLG6s17V1lROri+LDBHFWLt/klgWAhoZe2MrqyOY4RGj1554ovndtxaWllTn
 JkfDscViVWLF3goxB+1b7yX1smo9ShFZQwCWtfmU3Ymx/bCJps1e3uQCND45kgLLahjX
 pbRKhXiTYlVaLUBMlo31crmIUCT33/61/GV7F58s7WguoT5gyjz/Ftak6PDcb9qTtZkR kA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u7w2ch53d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Nov 2023 09:02:41 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A892eL1006809
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 8 Nov 2023 09:02:40 GMT
Received: from [10.253.34.202] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Wed, 8 Nov
 2023 01:02:35 -0800
Message-ID: <f6450530-c5c7-c523-8f89-952a0db10d3c@quicinc.com>
Date:   Wed, 8 Nov 2023 17:02:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 6/7] phy: qualcomm: phy-qcom-qmp-ufs: Add High Speed
 Gear 5 support for SM8550
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Can Guo <cang@qti.qualcomm.com>
CC:     <bvanassche@acm.org>, <mani@kernel.org>,
        <stanley.chu@mediatek.com>, <adrian.hunter@intel.com>,
        <beanhuo@micron.com>, <avri.altman@wdc.com>,
        <junwoo80.lee@samsung.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1699332374-9324-1-git-send-email-cang@qti.qualcomm.com>
 <1699332374-9324-7-git-send-email-cang@qti.qualcomm.com>
 <CAA8EJpqEkkEoQ9vncNJU1t=mKbvBXKk1FUxnmGTE0Q++sf=oXA@mail.gmail.com>
From:   Can Guo <quic_cang@quicinc.com>
In-Reply-To: <CAA8EJpqEkkEoQ9vncNJU1t=mKbvBXKk1FUxnmGTE0Q++sf=oXA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: m-w-6vNWFs3wrGSuZqkDWlF7KM8Of3iV
X-Proofpoint-ORIG-GUID: m-w-6vNWFs3wrGSuZqkDWlF7KM8Of3iV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-08_01,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1011 malwarescore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311080074
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On 11/7/2023 9:18 PM, Dmitry Baryshkov wrote:
> On Tue, 7 Nov 2023 at 06:47, Can Guo <cang@qti.qualcomm.com> wrote:
>>
>> From: Can Guo <quic_cang@quicinc.com>
>>
>> On SM8550, two sets of UFS PHY settings are provided, one set is to support
>> HS-G5, another set is to support HS-G4 and lower gears. The two sets of PHY
>> settings are programming different values to different registers, mixing
>> the two sets and/or overwriting one set with another set is definitely not
>> blessed by UFS PHY designers. In order to add HS-G5 support for SM8550, we
>> need to split the two sets into their dedicated tables, and leave only the
>> common settings in the .tlbs. To have the PHY programmed with the correct
>> set of PHY settings, the submode passed to PHY driver must be either HS-G4
>> or HS-G5.
>>
>> Signed-off-by: Can Guo <quic_cang@quicinc.com>
>> ---
>>   drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v6.h     |   2 +
>>   drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v6.h |   2 +
>>   .../qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h    |  12 +++
>>   drivers/phy/qualcomm/phy-qcom-qmp-ufs.c            | 112 ++++++++++++++++++---
>>   4 files changed, 115 insertions(+), 13 deletions(-)
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
>> index 15bcb4b..48f31c8 100644
>> --- a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h
>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h
>> @@ -10,10 +10,20 @@
>>   #define QSERDES_UFS_V6_TX_RES_CODE_LANE_RX                     0x2c
>>   #define QSERDES_UFS_V6_TX_RES_CODE_LANE_OFFSET_TX              0x30
>>   #define QSERDES_UFS_V6_TX_RES_CODE_LANE_OFFSET_RX              0x34
>> +#define QSERDES_UFS_V6_TX_LANE_MODE_1                          0x7c
>> +#define QSERDES_UFS_V6_TX_FR_DCC_CTRL                          0x108
>>
>>   #define QSERDES_UFS_V6_RX_UCDR_FASTLOCK_FO_GAIN_RATE2          0x08
>>   #define QSERDES_UFS_V6_RX_UCDR_FASTLOCK_FO_GAIN_RATE4          0x10
>> +#define QSERDES_UFS_V6_RX_UCDR_FASTLOCK_SO_GAIN_RATE4          0x24
>> +#define QSERDES_UFS_V6_RX_UCDR_FASTLOCK_COUNT_HIGH_RATE4       0x54
>> +#define QSERDES_UFS_V6_RX_UCDR_FO_GAIN_RATE2                   0xd4
>> +#define QSERDES_UFS_V6_RX_UCDR_FO_GAIN_RATE4                   0xdc
>> +#define QSERDES_UFS_V6_RX_UCDR_SO_GAIN_RATE4                   0xf0
>> +#define QSERDES_UFS_V6_RX_UCDR_PI_CONTROLS                     0xf4
>>   #define QSERDES_UFS_V6_RX_VGA_CAL_MAN_VAL                      0x178
>> +#define QSERDES_UFS_V6_RX_EQ_OFFSET_ADAPTOR_CNTRL1             0x1bc
>> +#define QSERDES_UFS_V6_RX_OFFSET_ADAPTOR_CNTRL3                        0x1c4
>>   #define QSERDES_UFS_V6_RX_MODE_RATE_0_1_B0                     0x208
>>   #define QSERDES_UFS_V6_RX_MODE_RATE_0_1_B1                     0x20c
>>   #define QSERDES_UFS_V6_RX_MODE_RATE_0_1_B3                     0x214
>> @@ -25,6 +35,8 @@
>>   #define QSERDES_UFS_V6_RX_MODE_RATE3_B5                                0x264
>>   #define QSERDES_UFS_V6_RX_MODE_RATE3_B8                                0x270
>>   #define QSERDES_UFS_V6_RX_MODE_RATE4_B3                                0x280
>> +#define QSERDES_UFS_V6_RX_MODE_RATE4_B4                                0x284
>>   #define QSERDES_UFS_V6_RX_MODE_RATE4_B6                                0x28c
>> +#define QSERDES_UFS_V6_RX_DLL0_FTUNE_CTRL                      0x2f8
>>
>>   #endif
>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
>> index 3927eba..e0a01497 100644
>> --- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
>> @@ -649,32 +649,51 @@ static const struct qmp_phy_init_tbl sm8550_ufsphy_serdes[] = {
>>          QMP_PHY_INIT_CFG(QSERDES_V6_COM_HSCLK_SEL_1, 0x11),
>>          QMP_PHY_INIT_CFG(QSERDES_V6_COM_HSCLK_HS_SWITCH_SEL_1, 0x00),
>>          QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP_EN, 0x01),
>> -       QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE_MAP, 0x04),
>> -       QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_IVCO, 0x0f),
>> +
>>          QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE_INITVAL2, 0x00),
>>          QMP_PHY_INIT_CFG(QSERDES_V6_COM_DEC_START_MODE0, 0x41),
>> -       QMP_PHY_INIT_CFG(QSERDES_V6_COM_CP_CTRL_MODE0, 0x0a),
>>          QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_RCTRL_MODE0, 0x18),
>>          QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_CCTRL_MODE0, 0x14),
>>          QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP1_MODE0, 0x7f),
>>          QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP2_MODE0, 0x06),
>> -       QMP_PHY_INIT_CFG(QSERDES_V6_COM_DEC_START_MODE0, 0x4c),
>> +};
>> +
>> +static const struct qmp_phy_init_tbl sm8550_ufsphy_hs_b_serdes[] = {
>> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE_MAP, 0x44),
>> +};
>> +
>> +static const struct qmp_phy_init_tbl sm8550_ufsphy_g4_serdes[] = {
>> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE_MAP, 0x04),
>> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_IVCO, 0x0f),
>>          QMP_PHY_INIT_CFG(QSERDES_V6_COM_CP_CTRL_MODE0, 0x0a),
>> -       QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_RCTRL_MODE0, 0x18),
>> -       QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_CCTRL_MODE0, 0x14),
>> -       QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP1_MODE0, 0x99),
>> -       QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP2_MODE0, 0x07),
> 
> Aside from moving these registers to the HS_G4 table, you are also
> changing these registers. It makes me think that there was an error in
> the original programming sequence.
> If that is correct, could you please split the patch into two pieces:
> - Fix programming sequence (add proper Fixes tags)
> - Split G4 and G5 tables.

You are correct, I don't know where the original values are from, but 
they look like a mixing of HS-G4 settings and HS-G5 settings to me, 
because I see some values are only supposed to be there for HS-G5, 
whereas the same MODE0 registers are programmed twice, I guess they 
should be MODE1 registers which are only required for HS-G4.

> 
>> +
>> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_DEC_START_MODE1, 0x4c),
>> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_CP_CTRL_MODE1, 0x0a),
>> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_RCTRL_MODE1, 0x18),
>> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_CCTRL_MODE1, 0x14),
>> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP1_MODE1, 0x99),
>> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP2_MODE1, 0x07),
> 
> I see all the MODE1 registers being only present in G4 and G5 tables.
> Should they be programmed for the modes lower than G4?
> 

As mentioned in the commit msg, on SM8550, only two sets of UFS PHY 
settings are provided, one set is to support HS-G5, another set is to 
support HS-G4.

Although HS-G5 set of PHY settings is backward comptiable and able to 
support all lower gears, UFS driver should make sure HS-G5 set of PHY 
settings are only used when UFS device really supports HS-G5.

For UFS devices which can only support HS-G4 or lower gears, UFS driver 
would use the HS-G4 set of PHY settings, in order to save power.

Thanks,
Can Guo.
