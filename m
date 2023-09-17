Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0255B7A35D0
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 16:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235463AbjIQOXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 10:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235320AbjIQOXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 10:23:21 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61187121;
        Sun, 17 Sep 2023 07:23:15 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38HEMxF7022599;
        Sun, 17 Sep 2023 14:22:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=g7AlTXelEL9xT8StkkUizvgzS/4s+ngCEg+VD4P26zo=;
 b=dIRhHLeGndA0F+lixcbG6QJCuoJB6luF6Cf7dVeNPcURbdYi/ed8FUSZzMkzCb6qEvtn
 bGSeGp1WzyZ+Y2T7BG+Ua1dlV2/MDi+IKTatPjubODz0iDVH6hliUn+rm/bgBpFJ95bF
 jn4eWk6ijoHOMzVmDvKaut+p7MDGYoEn9VYZbG03PqnD/ZCCNthDnqvQTQtdWb0n7Glu
 +84jGHcFqgaDfxcKmyOBYnVztN0K+mApVBMivL6FUYDh6pedNjLEWeXXmWmo3BapzIM1
 5x6siwyWsrMsQ3kcxumsRrdJw9kmBBN1xhRJz4vnMQg2sYYdR0npkU7IH2OtfOeLM1sK Qw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t55nehgu9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 17 Sep 2023 14:22:59 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38HEMwj2006481
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 17 Sep 2023 14:22:58 GMT
Received: from [10.216.13.111] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Sun, 17 Sep
 2023 07:22:53 -0700
Message-ID: <68e111ba-9a7b-511a-5765-24b491ad201b@quicinc.com>
Date:   Sun, 17 Sep 2023 19:52:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH V3 2/2] phy: qcom-qmp-ufs: Add Phy Configuration support
 for SC7280
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Manish Pandey <quic_mapa@quicinc.com>
References: <20230823091757.31311-1-quic_nitirawa@quicinc.com>
 <20230823091757.31311-3-quic_nitirawa@quicinc.com>
 <24cff590-c71f-4a30-9b80-fa9a0bd27957@linaro.org>
 <c9719d64-33c1-d13e-0ab6-289011282044@quicinc.com>
 <CAA8EJppYD8Oq_fkOOKf8_x7RdbjBx7XzV_5y4sKE3ZDv_WV9_Q@mail.gmail.com>
From:   Nitin Rawat <quic_nitirawa@quicinc.com>
In-Reply-To: <CAA8EJppYD8Oq_fkOOKf8_x7RdbjBx7XzV_5y4sKE3ZDv_WV9_Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ROa9EjY8ROUN-Fb0HiWs1wkV6OT9pBPo
X-Proofpoint-ORIG-GUID: ROa9EjY8ROUN-Fb0HiWs1wkV6OT9pBPo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_20,2023-09-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 adultscore=0 spamscore=0 impostorscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309170131
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/16/2023 12:03 AM, Dmitry Baryshkov wrote:
> On Fri, 15 Sept 2023 at 19:14, Nitin Rawat <quic_nitirawa@quicinc.com> wrote:
>>
>>
>>
>> On 9/6/2023 1:34 AM, Dmitry Baryshkov wrote:
>>> On 23/08/2023 12:17, Nitin Rawat wrote:
>>>> Add SC7280 specific register layout and table configs.
>>>>
>>>> Co-developed-by: Manish Pandey <quic_mapa@quicinc.com>
>>>> Signed-off-by: Manish Pandey <quic_mapa@quicinc.com>
>>>> Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
>>>> ---
>>>>    drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 142 ++++++++++++++++++++++++
>>>>    1 file changed, 142 insertions(+)
>>>>
>>>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
>>>> b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
>>>> index 3927eba8e468..514fa14df634 100644
>>>> --- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
>>>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
>>>
>>> [skipped tables programming]
>>>
>>> 4),
>> Sorry I quite didn't get this comment. what exactly is skipped ?Please
>> can you help explain?
> 
> I skipped them, as I didn't have comments for them.
> 
>>
>>
>>>> @@ -888,6 +993,40 @@ static const struct qmp_phy_cfg
>>>> sa8775p_ufsphy_cfg = {
>>>>        .regs            = ufsphy_v5_regs_layout,
>>>>    };
>>>>
>>>> +static const struct qmp_phy_cfg sc7280_ufsphy_cfg = {
>>>> +    .lanes                  = 2,
>>>> +
>>>> +    .offsets                = &qmp_ufs_offsets,
>>>> +
>>>> +    .tbls = {
>>>> +        .serdes         = sm8150_ufsphy_serdes,
>>>> +        .serdes_num     = ARRAY_SIZE(sm8150_ufsphy_serdes),
>>>> +        .tx             = sc7280_ufsphy_tx,
>>>> +        .tx_num         = ARRAY_SIZE(sc7280_ufsphy_tx),
>>>> +        .rx             = sc7280_ufsphy_rx,
>>>> +        .rx_num         = ARRAY_SIZE(sc7280_ufsphy_rx),
>>>> +        .pcs            = sc7280_ufsphy_pcs,
>>>> +        .pcs_num        = ARRAY_SIZE(sc7280_ufsphy_pcs),
>>>> +    },
>>>> +    .tbls_hs_b = {
>>>> +        .serdes         = sm8150_ufsphy_hs_b_serdes,
>>>> +        .serdes_num     = ARRAY_SIZE(sm8150_ufsphy_hs_b_serdes),
>>>> +    },
>>>> +    .tbls_hs_g4 = {
>>>> +        .tx             = sm8250_ufsphy_hs_g4_tx,
>>>> +        .tx_num         = ARRAY_SIZE(sm8250_ufsphy_hs_g4_tx),
>>>> +        .rx             = sc7280_ufsphy_hs_g4_rx,
>>>> +        .rx_num         = ARRAY_SIZE(sc7280_ufsphy_hs_g4_rx),
>>>> +        .pcs            = sm8150_ufsphy_hs_g4_pcs,
>>>> +        .pcs_num        = ARRAY_SIZE(sm8150_ufsphy_hs_g4_pcs),
>>>> +    },
>>>> +    .clk_list               = sm8450_ufs_phy_clk_l,
>>>> +    .num_clks               = ARRAY_SIZE(sm8450_ufs_phy_clk_l),
>>>
>>> This doesn't correspond to the bindings. This array has 3 enries, while
>>> in the bindings you have opted for two clocks for this PHY.
>> Sure. I'll update the bindings.
> 
> Are you sure about the third clock? Neither sm8150 nor sm8250 used the
> qref clock. Or is that an omission on our side?
> 

Hi Dmitry,

For SC7280 we need all the three clocks for this target. Same is being 
used in downstream code as well. Hence I would need to update the 
binding as well.

Thanks,
Nitin


>>
>>>
>>>> +    .vreg_list              = qmp_phy_vreg_l,
>>>> +    .num_vregs              = ARRAY_SIZE(qmp_phy_vreg_l),
>>>> +    .regs                   = ufsphy_v4_regs_layout,
>>>> +};
>>>> +
>>>>    static const struct qmp_phy_cfg sc8280xp_ufsphy_cfg = {
>>>>        .lanes            = 2,
>>>>
>>>> @@ -1648,6 +1787,9 @@ static const struct of_device_id
>>>> qmp_ufs_of_match_table[] = {
>>>>        }, {
>>>>            .compatible = "qcom,sa8775p-qmp-ufs-phy",
>>>>            .data = &sa8775p_ufsphy_cfg,
>>>> +    }, {
>>>> +        .compatible = "qcom,sc7280-qmp-ufs-phy",
>>>> +        .data = &sc7280_ufsphy_cfg,
>>>>        }, {
>>>>            .compatible = "qcom,sc8180x-qmp-ufs-phy",
>>>>            .data = &sm8150_ufsphy_cfg,
>>>> --
>>>> 2.17.1
>>>>
>>>
>> Thanks,
>> Nitin
> 
> 
> 
