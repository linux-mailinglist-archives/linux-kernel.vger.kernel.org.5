Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8EC07A2360
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 18:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235038AbjIOQPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 12:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235051AbjIOQOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 12:14:46 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B2910E6;
        Fri, 15 Sep 2023 09:14:40 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38FDivV8020663;
        Fri, 15 Sep 2023 16:14:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=erJuSEpdqAIVPeaGsYnZ3SEDURTnASwcYNladoGLgmc=;
 b=MQRHmAKUpdVaOWJn/41L5e0pO+oLk7nF3R/b3HCuFLarZsGsWBky91VxvrVoVGyT46+V
 xkj7E1Hl0jZoyPgmkQmtDAgOy+AHquQ5Qe2U5bPOkc7h7I6StumcT4fa4cK/MPjUPTMn
 IVAzBRrHH+KDs3zf631A/NbFAb4WFyyi0JDY16Hm2O16/ErP7O/l0zaCQ41gmhnfFdKD
 d9fXjNzhGas2E2Y6q8Zdah1t3OKZbBrGLCxxG+YiAosZQynz7+Ku6xl7yIzuH2R5yuHu
 3xAYYGE2RZwi385QVZ+pki8lO6MmpiMfxvnDQROaNVEqlYcQtOXyfhrD/no49qk3/pGz JQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t4dvqsv9m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 16:14:22 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38FGEMNG006287
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 16:14:22 GMT
Received: from [10.218.45.181] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Fri, 15 Sep
 2023 09:14:17 -0700
Message-ID: <c9719d64-33c1-d13e-0ab6-289011282044@quicinc.com>
Date:   Fri, 15 Sep 2023 21:44:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH V3 2/2] phy: qcom-qmp-ufs: Add Phy Configuration support
 for SC7280
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Manish Pandey <quic_mapa@quicinc.com>
References: <20230823091757.31311-1-quic_nitirawa@quicinc.com>
 <20230823091757.31311-3-quic_nitirawa@quicinc.com>
 <24cff590-c71f-4a30-9b80-fa9a0bd27957@linaro.org>
Content-Language: en-US
From:   Nitin Rawat <quic_nitirawa@quicinc.com>
In-Reply-To: <24cff590-c71f-4a30-9b80-fa9a0bd27957@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: nDrCdLQcMKzJTFPT7rnpBt26XwOzkXPh
X-Proofpoint-ORIG-GUID: nDrCdLQcMKzJTFPT7rnpBt26XwOzkXPh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_12,2023-09-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 bulkscore=0 clxscore=1011
 mlxlogscore=999 phishscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309150145
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/6/2023 1:34 AM, Dmitry Baryshkov wrote:
> On 23/08/2023 12:17, Nitin Rawat wrote:
>> Add SC7280 specific register layout and table configs.
>>
>> Co-developed-by: Manish Pandey <quic_mapa@quicinc.com>
>> Signed-off-by: Manish Pandey <quic_mapa@quicinc.com>
>> Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
>> ---
>>   drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 142 ++++++++++++++++++++++++
>>   1 file changed, 142 insertions(+)
>>
>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c 
>> b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
>> index 3927eba8e468..514fa14df634 100644
>> --- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> 
> [skipped tables programming]
> 
> 4),
Sorry I quite didn't get this comment. what exactly is skipped ?Please 
can you help explain?


>> @@ -888,6 +993,40 @@ static const struct qmp_phy_cfg 
>> sa8775p_ufsphy_cfg = {
>>       .regs            = ufsphy_v5_regs_layout,
>>   };
>>
>> +static const struct qmp_phy_cfg sc7280_ufsphy_cfg = {
>> +    .lanes                  = 2,
>> +
>> +    .offsets                = &qmp_ufs_offsets,
>> +
>> +    .tbls = {
>> +        .serdes         = sm8150_ufsphy_serdes,
>> +        .serdes_num     = ARRAY_SIZE(sm8150_ufsphy_serdes),
>> +        .tx             = sc7280_ufsphy_tx,
>> +        .tx_num         = ARRAY_SIZE(sc7280_ufsphy_tx),
>> +        .rx             = sc7280_ufsphy_rx,
>> +        .rx_num         = ARRAY_SIZE(sc7280_ufsphy_rx),
>> +        .pcs            = sc7280_ufsphy_pcs,
>> +        .pcs_num        = ARRAY_SIZE(sc7280_ufsphy_pcs),
>> +    },
>> +    .tbls_hs_b = {
>> +        .serdes         = sm8150_ufsphy_hs_b_serdes,
>> +        .serdes_num     = ARRAY_SIZE(sm8150_ufsphy_hs_b_serdes),
>> +    },
>> +    .tbls_hs_g4 = {
>> +        .tx             = sm8250_ufsphy_hs_g4_tx,
>> +        .tx_num         = ARRAY_SIZE(sm8250_ufsphy_hs_g4_tx),
>> +        .rx             = sc7280_ufsphy_hs_g4_rx,
>> +        .rx_num         = ARRAY_SIZE(sc7280_ufsphy_hs_g4_rx),
>> +        .pcs            = sm8150_ufsphy_hs_g4_pcs,
>> +        .pcs_num        = ARRAY_SIZE(sm8150_ufsphy_hs_g4_pcs),
>> +    },
>> +    .clk_list               = sm8450_ufs_phy_clk_l,
>> +    .num_clks               = ARRAY_SIZE(sm8450_ufs_phy_clk_l),
> 
> This doesn't correspond to the bindings. This array has 3 enries, while 
> in the bindings you have opted for two clocks for this PHY.
Sure. I'll update the bindings.

> 
>> +    .vreg_list              = qmp_phy_vreg_l,
>> +    .num_vregs              = ARRAY_SIZE(qmp_phy_vreg_l),
>> +    .regs                   = ufsphy_v4_regs_layout,
>> +};
>> +
>>   static const struct qmp_phy_cfg sc8280xp_ufsphy_cfg = {
>>       .lanes            = 2,
>>
>> @@ -1648,6 +1787,9 @@ static const struct of_device_id 
>> qmp_ufs_of_match_table[] = {
>>       }, {
>>           .compatible = "qcom,sa8775p-qmp-ufs-phy",
>>           .data = &sa8775p_ufsphy_cfg,
>> +    }, {
>> +        .compatible = "qcom,sc7280-qmp-ufs-phy",
>> +        .data = &sc7280_ufsphy_cfg,
>>       }, {
>>           .compatible = "qcom,sc8180x-qmp-ufs-phy",
>>           .data = &sm8150_ufsphy_cfg,
>> -- 
>> 2.17.1
>>
> 
Thanks,
Nitin
