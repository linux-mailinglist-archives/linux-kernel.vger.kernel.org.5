Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 903197934EB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 07:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240123AbjIFFf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 01:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjIFFf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 01:35:56 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14809EA;
        Tue,  5 Sep 2023 22:35:53 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3864eDF1016002;
        Wed, 6 Sep 2023 05:35:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=K71dDfISUpoL/pGcHA7RhHkRhwFR2rHL+gv6H9gTCAY=;
 b=Asd4J4MwC9uzjlHOXoVFBgP0uiId2UnLFVU+v68q4xfSuBMhzHRS0cQSvyCCG1p6iZ/F
 zrjMGPvUtxMrkp0Oci+73y0SUHDEcvwtsrGaoPmX22Zj3fN/mwyfv1XlIy1NyGaZbRkv
 aZH2m7OSUN7f6Nav7vZhoxYSICiFYZ0OObXxiBJi62eLbRJQ/fToU/HiKO4zfQ3MWgQg
 m7Vex6v66Fhv1K8gA9t8y5S5e67GvGlxDAmehSqxma26QuilfsrtXMo4sfXURKLUy+P1
 NKTQy7EsDp4LomE3UO3MmVe7OTu+Vsk9uBvWCLMX7L9jnUb7BFsRMWjSazALm8ESN4cX 4Q== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sx62wt02p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Sep 2023 05:35:43 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3865ZgUN000725
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 6 Sep 2023 05:35:42 GMT
Received: from [10.214.66.58] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 5 Sep
 2023 22:35:34 -0700
Message-ID: <0d76f851-ef7a-2d09-a344-9ec31ba581a5@quicinc.com>
Date:   Wed, 6 Sep 2023 11:05:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v2 5/5] phy: qcom-qmp-usb: Add Qualcomm SDX75 USB3 PHY
 support
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <gregkh@linuxfoundation.org>, <abel.vesa@linaro.org>,
        <quic_wcheng@quicinc.com>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <kernel@quicinc.com>
References: <1693909838-6682-1-git-send-email-quic_rohiagar@quicinc.com>
 <1693909838-6682-6-git-send-email-quic_rohiagar@quicinc.com>
 <8aefd8f9-cfe9-4011-a24b-ebb13d28faa0@linaro.org>
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
In-Reply-To: <8aefd8f9-cfe9-4011-a24b-ebb13d28faa0@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: KMxD0XH2KVxsoNnQxgzWQnaQimkrD6st
X-Proofpoint-ORIG-GUID: KMxD0XH2KVxsoNnQxgzWQnaQimkrD6st
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_13,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 clxscore=1015 impostorscore=0 mlxscore=0 adultscore=0
 spamscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309060050
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/6/2023 2:08 AM, Dmitry Baryshkov wrote:
> On 05/09/2023 13:30, Rohit Agarwal wrote:
>> Add support for USB3 QMP PHY found in SDX75 platform.
>>
>> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
>> ---
>>   drivers/phy/qualcomm/phy-qcom-qmp-usb.c | 158 
>> ++++++++++++++++++++++++++++++++
>>   1 file changed, 158 insertions(+)
>>
>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c 
>> b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
>> index 0130bb8..57b8b5b 100644
>> --- a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
>> @@ -23,6 +23,7 @@
>>   #include "phy-qcom-qmp-pcs-misc-v3.h"
>>   #include "phy-qcom-qmp-pcs-usb-v4.h"
>>   #include "phy-qcom-qmp-pcs-usb-v5.h"
>> +#include "phy-qcom-qmp-pcs-usb-v6.h"
>>     /* QPHY_SW_RESET bit */
>>   #define SW_RESET                BIT(0)
>> @@ -858,6 +859,134 @@ static const struct qmp_phy_init_tbl 
>> sdx65_usb3_uniphy_rx_tbl[] = {
>
> [skipped the tables]
>
>> @@ -1556,6 +1685,32 @@ static const struct qmp_phy_cfg 
>> sdx65_usb3_uniphy_cfg = {
>>       .has_pwrdn_delay    = true,
>>   };
>>   +static const struct qmp_phy_cfg sdx75_usb3_uniphy_cfg = {
>> +    .lanes            = 1,
>> +    .offsets        = &qmp_usb_offsets_v5,
>
> v6?
Since the offsets for v5 and v6 are same, I did not introduce a new 
struct with the same values.
Please correct me if I have to introduce v6 offsets.
>
>> +
>> +    .serdes_tbl        = sdx75_usb3_uniphy_serdes_tbl,
>> +    .serdes_tbl_num        = ARRAY_SIZE(sdx75_usb3_uniphy_serdes_tbl),
>> +    .tx_tbl            = sdx75_usb3_uniphy_tx_tbl,
>> +    .tx_tbl_num        = ARRAY_SIZE(sdx75_usb3_uniphy_tx_tbl),
>> +    .rx_tbl            = sdx75_usb3_uniphy_rx_tbl,
>> +    .rx_tbl_num        = ARRAY_SIZE(sdx75_usb3_uniphy_rx_tbl),
>> +    .pcs_tbl        = sdx75_usb3_uniphy_pcs_tbl,
>> +    .pcs_tbl_num        = ARRAY_SIZE(sdx75_usb3_uniphy_pcs_tbl),
>> +    .pcs_usb_tbl        = sdx75_usb3_uniphy_pcs_usb_tbl,
>> +    .pcs_usb_tbl_num    = ARRAY_SIZE(sdx75_usb3_uniphy_pcs_usb_tbl),
>> +    .clk_list        = qmp_v4_sdx55_usbphy_clk_l,
>> +    .num_clks        = ARRAY_SIZE(qmp_v4_sdx55_usbphy_clk_l),
>> +    .reset_list        = msm8996_usb3phy_reset_l,
>> +    .num_resets        = ARRAY_SIZE(msm8996_usb3phy_reset_l),
>
> Clocks and resets are gone in 
> https://lore.kernel.org/linux-phy/20230824211952.1397699-1-dmitry.baryshkov@linaro.org/
>
Sure.
>> +    .vreg_list        = qmp_phy_vreg_l,
>> +    .num_vregs        = ARRAY_SIZE(qmp_phy_vreg_l),
>> +    .regs            = qmp_v5_usb3phy_regs_layout,
>
> This must be v6, if the rest of the PHY is using v6 register names.
Same, Shall I introduce v6 struct?

Thanks,
Rohit.
>
>> +    .pcs_usb_offset        = 0x1000,
>> +
>> +    .has_pwrdn_delay    = true,
>> +};
>> +
>>   static const struct qmp_phy_cfg sm8350_usb3_uniphy_cfg = {
>>       .lanes            = 1,
>>   @@ -2256,6 +2411,9 @@ static const struct of_device_id 
>> qmp_usb_of_match_table[] = {
>>           .compatible = "qcom,sdx65-qmp-usb3-uni-phy",
>>           .data = &sdx65_usb3_uniphy_cfg,
>>       }, {
>> +        .compatible = "qcom,sdx75-qmp-usb3-uni-phy",
>> +        .data = &sdx75_usb3_uniphy_cfg,
>> +    }, {
>>           .compatible = "qcom,sm6115-qmp-usb3-phy",
>>           .data = &qcm2290_usb3phy_cfg,
>>       }, {
>
