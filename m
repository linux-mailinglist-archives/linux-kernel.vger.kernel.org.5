Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68A417FAFC6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 02:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbjK1Buv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 20:50:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjK1Bus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 20:50:48 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F541B6;
        Mon, 27 Nov 2023 17:50:54 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AS1h8Fk020602;
        Tue, 28 Nov 2023 01:50:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Ys4/6FFfW1SAvUPGmv86XCxA3FNAIi1MkHLRZxoOcBk=;
 b=Ws+75g1I1vgcxIlPy11nIbrzpMccCg84bcAj7cwlR2KzeoFwOtqcR+5zhw/UEA7QG33f
 f9ruaVWd9Arpe7v53ImQgBPgKMNmZsNCfKfoscRsTBaU9Im8TsDxIjZLHgrQyo8CVzcq
 Gq/S1dES9kPKMOwnWOJATq5Dkvwh5VhLrg41tn+Fb3lW1mgOCJA6Y/0xDNekPK/AGNpe
 dMZnNFom8BJwNm0E33WHhjsIi8uBfEuyeyc7Ub8g7hhTtQRDDMDLQX1coA1QkMJQkkvn
 UZzejRXGo6eT4DidiaQdna3hQXj9soNrNZnKL5dblIRvtMPD8CKzmSBK24uX2enDhgP4 1Q== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3umqxh29as-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Nov 2023 01:50:37 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AS1oaHN004445
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Nov 2023 01:50:36 GMT
Received: from [10.253.11.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 27 Nov
 2023 17:50:32 -0800
Message-ID: <a690f5c1-50e7-4d37-9e12-fff574917aba@quicinc.com>
Date:   Tue, 28 Nov 2023 09:50:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/10] phy: qualcomm: phy-qcom-qmp-ufs: Rectify SM8550
 UFS HS-G4 PHY Settings
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>
CC:     <bvanassche@acm.org>, <mani@kernel.org>, <adrian.hunter@intel.com>,
        <beanhuo@micron.com>, <avri.altman@wdc.com>,
        <junwoo80.lee@samsung.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        "open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1700729190-17268-1-git-send-email-quic_cang@quicinc.com>
 <1700729190-17268-9-git-send-email-quic_cang@quicinc.com>
 <ZWR4cN0sJNcVHPrL@matsya>
From:   Can Guo <quic_cang@quicinc.com>
In-Reply-To: <ZWR4cN0sJNcVHPrL@matsya>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jE2rucx1THA52q9EfdMqES3Sf4T1tPmF
X-Proofpoint-ORIG-GUID: jE2rucx1THA52q9EfdMqES3Sf4T1tPmF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_01,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 clxscore=1015 phishscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311280013
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

On 11/27/2023 7:07 PM, Vinod Koul wrote:
> On 23-11-23, 00:46, Can Guo wrote:
>> The registers, which are being touched in current SM8550 UFS PHY settings,
>> and the values being programmed are mainly the ones working for HS-G4 mode,
>> meanwhile, there are also a few ones somehow taken from HS-G5 PHY settings.
>> However, even consider HS-G4 mode only, some of them are incorrect and some
>> are missing. Rectify the HS-G4 PHY settings by strictly aligning with the
>> SM8550 UFS PHY Hardware Programming Guide suggested HS-G4 PHY settings.
> 
> can you copy on cover so that we know the context of the series, I just
> got hit with two patches out of the blue with this
> 

Will add you to the --to list in next version. The whole series is to 
enable HS-G5 support on SM8550. FYI, the two changes to UFS PHY driver, 
which you mentioned above, in the series are to 1. Rectify existing 
HS-G4 PHY setting for SM8550 and 2. Add HS-G5 PHY settings for SM8550.

Thanks,
Can Guo.

>>
>> Fixes: 1679bfef906f ("phy: qcom-qmp-ufs: Add SM8550 support")
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> Reviewed-by: Abel Vesa <abel.vesa@linaro.org>
>> Signed-off-by: Can Guo <quic_cang@quicinc.com>
>> ---
>>   .../qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h    |  3 +++
>>   drivers/phy/qualcomm/phy-qcom-qmp-ufs.c            | 28 +++++++++++++++-------
>>   2 files changed, 22 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h
>> index 15bcb4b..674f158 100644
>> --- a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h
>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h
>> @@ -10,9 +10,12 @@
>>   #define QSERDES_UFS_V6_TX_RES_CODE_LANE_RX			0x2c
>>   #define QSERDES_UFS_V6_TX_RES_CODE_LANE_OFFSET_TX		0x30
>>   #define QSERDES_UFS_V6_TX_RES_CODE_LANE_OFFSET_RX		0x34
>> +#define QSERDES_UFS_V6_TX_LANE_MODE_1				0x7c
>> +#define QSERDES_UFS_V6_TX_FR_DCC_CTRL				0x108
>>   
>>   #define QSERDES_UFS_V6_RX_UCDR_FASTLOCK_FO_GAIN_RATE2		0x08
>>   #define QSERDES_UFS_V6_RX_UCDR_FASTLOCK_FO_GAIN_RATE4		0x10
>> +#define QSERDES_UFS_V6_RX_UCDR_FO_GAIN_RATE2			0xd4
>>   #define QSERDES_UFS_V6_RX_VGA_CAL_MAN_VAL			0x178
>>   #define QSERDES_UFS_V6_RX_MODE_RATE_0_1_B0			0x208
>>   #define QSERDES_UFS_V6_RX_MODE_RATE_0_1_B1			0x20c
>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
>> index 3927eba..ad91f92 100644
>> --- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
>> @@ -658,22 +658,26 @@ static const struct qmp_phy_init_tbl sm8550_ufsphy_serdes[] = {
>>   	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_CCTRL_MODE0, 0x14),
>>   	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP1_MODE0, 0x7f),
>>   	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP2_MODE0, 0x06),
>> -	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DEC_START_MODE0, 0x4c),
>> -	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CP_CTRL_MODE0, 0x0a),
>> -	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_RCTRL_MODE0, 0x18),
>> -	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_CCTRL_MODE0, 0x14),
>> -	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP1_MODE0, 0x99),
>> -	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP2_MODE0, 0x07),
>> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DEC_START_MODE1, 0x4c),
>> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CP_CTRL_MODE1, 0x0a),
>> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_RCTRL_MODE1, 0x18),
>> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_CCTRL_MODE1, 0x14),
>> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP1_MODE1, 0x99),
>> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP2_MODE1, 0x07),
>> +};
>> +
>> +static const struct qmp_phy_init_tbl sm8550_ufsphy_hs_b_serdes[] = {
>> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE_MAP, 0x44),
>>   };
>>   
>>   static const struct qmp_phy_init_tbl sm8550_ufsphy_tx[] = {
>> -	QMP_PHY_INIT_CFG(QSERDES_V6_TX_LANE_MODE_1, 0x05),
>> +	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_TX_LANE_MODE_1, 0x05),
>>   	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_TX_RES_CODE_LANE_OFFSET_TX, 0x07),
>> +	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_TX_FR_DCC_CTRL, 0x4c),
>>   };
>>   
>>   static const struct qmp_phy_init_tbl sm8550_ufsphy_rx[] = {
>> -	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_UCDR_FASTLOCK_FO_GAIN_RATE2, 0x0c),
>> -	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_UCDR_FASTLOCK_FO_GAIN_RATE4, 0x0f),
>> +	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_UCDR_FO_GAIN_RATE2, 0x0c),
>>   	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_VGA_CAL_MAN_VAL, 0x0e),
>>   
>>   	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE_0_1_B0, 0xc2),
>> @@ -696,6 +700,8 @@ static const struct qmp_phy_init_tbl sm8550_ufsphy_pcs[] = {
>>   	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_TX_MID_TERM_CTRL1, 0x43),
>>   	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_PLL_CNTL, 0x2b),
>>   	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_MULTI_LANE_CTRL1, 0x02),
>> +	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_TX_HSGEAR_CAPABILITY, 0x04),
>> +	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_RX_HSGEAR_CAPABILITY, 0x04),
>>   };
>>   
>>   struct qmp_ufs_offsets {
>> @@ -1157,6 +1163,10 @@ static const struct qmp_phy_cfg sm8550_ufsphy_cfg = {
>>   		.pcs		= sm8550_ufsphy_pcs,
>>   		.pcs_num	= ARRAY_SIZE(sm8550_ufsphy_pcs),
>>   	},
>> +	.tbls_hs_b = {
>> +		.serdes		= sm8550_ufsphy_hs_b_serdes,
>> +		.serdes_num	= ARRAY_SIZE(sm8550_ufsphy_hs_b_serdes),
>> +	},
>>   	.clk_list		= sdm845_ufs_phy_clk_l,
>>   	.num_clks		= ARRAY_SIZE(sdm845_ufs_phy_clk_l),
>>   	.vreg_list		= qmp_phy_vreg_l,
>> -- 
>> 2.7.4
> 
