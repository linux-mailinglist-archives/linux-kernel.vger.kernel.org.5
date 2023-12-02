Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1949801C29
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 11:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbjLBKLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 05:11:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232210AbjLBKLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 05:11:31 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F1B181;
        Sat,  2 Dec 2023 02:11:37 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B2ABCvA027494;
        Sat, 2 Dec 2023 10:11:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=3kibO4udjOungBApnJYuOvCQkp77DLoZ4l7doiXrJBs=;
 b=nYE3bjZDsetQesN82pYm0/m1CfcSPueqaYHRRU8DRYs1jRxotBtjxmuA1QCT5PXjWD0j
 jHAWX8x0QbTo6omgmnVMBQg56WthMv5Pyz+W/I1JMruS0CYHVZ3BMgN1yYrOE1mdsrn+
 36lojtGkumQ+BstChd/X1C+Cvik+kTyb0VgZxgCJkAYgkaxcqPLShy2A8JX9y1Rq43k1
 iByrGiGYPLMye2Q5S2FfwGok47Av/61ZeuSf7HiQsex4JLj0ZmDZDDMhGiUxhTyZ2IOB
 efhXHS5p0B9rtZ0Lv/x80cj0vFMwSFIF48/QbrzMcCIYsiyPLf7eLL4Upoh0MIr5Flpi DQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uqsxw0p59-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 02 Dec 2023 10:11:11 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B2ABApt023215
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 2 Dec 2023 10:11:10 GMT
Received: from [10.253.72.107] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sat, 2 Dec
 2023 02:11:05 -0800
Message-ID: <e7883e6b-4d65-d997-a9fb-83497e2ad8f1@quicinc.com>
Date:   Sat, 2 Dec 2023 18:11:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v7 09/10] phy: qualcomm: phy-qcom-qmp-ufs: Rectify SM8550
 UFS HS-G4 PHY Settings
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>
CC:     <bvanassche@acm.org>, <mani@kernel.org>, <adrian.hunter@intel.com>,
        <vkoul@kernel.org>, <beanhuo@micron.com>, <avri.altman@wdc.com>,
        <junwoo80.lee@samsung.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        "open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1701407001-471-1-git-send-email-quic_cang@quicinc.com>
 <1701407001-471-10-git-send-email-quic_cang@quicinc.com>
 <ZWmOc/L/2najkwKf@linaro.org>
From:   Can Guo <quic_cang@quicinc.com>
In-Reply-To: <ZWmOc/L/2najkwKf@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 0AmNZe6pJcDQTw_Kw3u19s-ezWxNmWxC
X-Proofpoint-GUID: 0AmNZe6pJcDQTw_Kw3u19s-ezWxNmWxC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-02_07,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 mlxscore=0 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=851 malwarescore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312020074
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/1/2023 3:42 PM, Abel Vesa wrote:
> On 23-11-30 21:03:19, Can Guo wrote:
>> The registers, which are being touched in current SM8550 UFS PHY settings,
>> and the values being programmed are mainly the ones working for HS-G4 mode,
>> meanwhile, there are also a few ones somehow taken from HS-G5 PHY settings.
>> However, even consider HS-G4 mode only, some of them are incorrect and some
>> are missing. Rectify the HS-G4 PHY settings by strictly aligning with the
>> SM8550 UFS PHY Hardware Programming Guide suggested HS-G4 PHY settings.
>>
>> Fixes: 1679bfef906f ("phy: qcom-qmp-ufs: Add SM8550 support")
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> Reviewed-by: Abel Vesa <abel.vesa@linaro.org>
>> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>> Signed-off-by: Can Guo <quic_cang@quicinc.com>
>> ---
> Hi Can,
>
> Since you are not CC'ing everyone on all patches from this series,
> please write the changes made since the last version in every patch (if
> applicable) from now on.
>
> Thanks,
> Abel

Sure.


Thanks,

Can Guo.

>
>>   .../qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h    |  1 +
>>   drivers/phy/qualcomm/phy-qcom-qmp-ufs.c            | 28 +++++++++++++++-------
>>   2 files changed, 20 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h
>> index ae220fd..35d497f 100644
>> --- a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h
>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h
>> @@ -11,6 +11,7 @@
>>   #define QSERDES_UFS_V6_TX_RES_CODE_LANE_OFFSET_TX		0x30
>>   #define QSERDES_UFS_V6_TX_RES_CODE_LANE_OFFSET_RX		0x34
>>   #define QSERDES_UFS_V6_TX_LANE_MODE_1				0x7c
>> +#define QSERDES_UFS_V6_TX_FR_DCC_CTRL				0x108
>>   
>>   #define QSERDES_UFS_V6_RX_UCDR_FASTLOCK_FO_GAIN_RATE2		0x08
>>   #define QSERDES_UFS_V6_RX_UCDR_FASTLOCK_FO_GAIN_RATE4		0x10
>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
>> index 5f79d18..3c2e625 100644
>> --- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
>> @@ -763,22 +763,26 @@ static const struct qmp_phy_init_tbl sm8550_ufsphy_serdes[] = {
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
>> @@ -801,6 +805,8 @@ static const struct qmp_phy_init_tbl sm8550_ufsphy_pcs[] = {
>>   	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_TX_MID_TERM_CTRL1, 0x43),
>>   	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_PLL_CNTL, 0x2b),
>>   	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_MULTI_LANE_CTRL1, 0x02),
>> +	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_TX_HSGEAR_CAPABILITY, 0x04),
>> +	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_RX_HSGEAR_CAPABILITY, 0x04),
>>   };
>>   
>>   static const struct qmp_phy_init_tbl sm8650_ufsphy_serdes[] = {
>> @@ -1357,6 +1363,10 @@ static const struct qmp_phy_cfg sm8550_ufsphy_cfg = {
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
>>
