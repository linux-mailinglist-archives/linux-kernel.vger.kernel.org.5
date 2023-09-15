Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82BF7A1D50
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 13:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232403AbjIOLUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 07:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234119AbjIOLUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 07:20:17 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8438E1BB;
        Fri, 15 Sep 2023 04:20:10 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38F6Qn14020351;
        Fri, 15 Sep 2023 11:19:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=kN2RGYJN1SJPK38oh5iYZfN0XoVOmcJkxB7T4aFKpEQ=;
 b=np8rpH8terhUNHPW0HjPNs4ad3XJp7WtISzLCY1833/Xx69SINgzGXbU+pn7hA96DP5W
 7b8WOg6v97cqSJfrbqN9rVvhYu3sv9PqCamDm42OIqIWhLTearIF3F/p86jM2GsRIcO8
 2rd84FmbntEUGrWlV+K3NNwY90s6EqOMww/HLBJsefOXxScWz7/T5a7syIcz9BXszvUb
 8LESShpTRDxnXKQh5Xnpq0koT7IR3PoCX4WqULFoBQSCd3xU62ggoWVC2pNNVebMd/WP
 j89UfgI8wIT/O2lB6/GR8vARbBZ3VM77FFPvXKLKjJ9ENAMEb+rdJdC0zHLULX9r4L8e bw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t4dvqs57a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 11:19:33 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38FBJ7EL031499
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 11:19:07 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Fri, 15 Sep
 2023 04:18:58 -0700
Message-ID: <f76e1cc8-fc48-4208-bbe4-9204d9d28363@quicinc.com>
Date:   Fri, 15 Sep 2023 19:18:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/8] arm64: defconfig: enable interconnect and pinctrl
 for SM4450
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <catalin.marinas@arm.com>
CC:     <geert+renesas@glider.be>, <arnd@arndb.de>,
        <neil.armstrong@linaro.org>, <nfraprado@collabora.com>,
        <rafal@milecki.pl>, <peng.fan@nxp.com>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <quic_tsoni@quicinc.com>,
        <quic_shashim@quicinc.com>, <quic_kaushalk@quicinc.com>,
        <quic_tdas@quicinc.com>, <quic_tingweiz@quicinc.com>,
        <quic_aiquny@quicinc.com>, <kernel@quicinc.com>
References: <20230915021509.25773-1-quic_tengfan@quicinc.com>
 <20230915021509.25773-10-quic_tengfan@quicinc.com>
 <8f2c9664-a2c8-50dc-8a1c-e50a071ebeb2@linaro.org>
 <e9ff05b3-2742-416e-b417-5e2414036008@quicinc.com>
 <0a34dd35-7aea-4655-4cdd-e7196a1ba52b@linaro.org>
From:   Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <0a34dd35-7aea-4655-4cdd-e7196a1ba52b@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 2oA1-4iMP1AmKTZAV6n-MRvtsB6dudR6
X-Proofpoint-ORIG-GUID: 2oA1-4iMP1AmKTZAV6n-MRvtsB6dudR6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_08,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 mlxlogscore=950 phishscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309150101
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 9/15/2023 5:16 PM, Krzysztof Kozlowski 写道:
> On 15/09/2023 11:12, Tengfei Fan wrote:
>>
>>
>> 在 9/15/2023 3:21 PM, Krzysztof Kozlowski 写道:
>>> On 15/09/2023 04:15, Tengfei Fan wrote:
>>>> Add the SM4450 interconnect and pinctrl drivers as built-in for
>>>> support the Qualcomm SM4450 platform to boot to uart shell.
>>>>
>>>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>>>> ---
>>>>    arch/arm64/configs/defconfig | 2 ++
>>>>    1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
>>>> index ec59174b14db..e91993de865e 100644
>>>> --- a/arch/arm64/configs/defconfig
>>>> +++ b/arch/arm64/configs/defconfig
>>>> @@ -598,6 +598,7 @@ CONFIG_PINCTRL_SC8280XP=y
>>>>    CONFIG_PINCTRL_SDM660=y
>>>>    CONFIG_PINCTRL_SDM670=y
>>>>    CONFIG_PINCTRL_SDM845=y
>>>> +CONFIG_PINCTRL_SM4450=y
>>>>    CONFIG_PINCTRL_SM6115=y
>>>>    CONFIG_PINCTRL_SM6125=y
>>>>    CONFIG_PINCTRL_SM6350=y
>>>> @@ -1500,6 +1501,7 @@ CONFIG_INTERCONNECT_QCOM_SC7280=y
>>>>    CONFIG_INTERCONNECT_QCOM_SC8180X=y
>>>>    CONFIG_INTERCONNECT_QCOM_SC8280XP=y
>>>>    CONFIG_INTERCONNECT_QCOM_SDM845=y
>>>> +CONFIG_INTERCONNECT_QCOM_SM4450=y
>>>
>>> Why it cannot be =m?
>>>
>>> Best regards,
>>> Krzysztof
>>>
>>
>> Hi Krzysztof,
>> Because system haven't capacity of loading ko files at this time on
>> SM4450 platform, so setting to "Y".
> 
> Hm? System has this capability. All systems have. What is so different
> on SM4450 comparing to everything else we have here?
> 
> No, this should be =m and you need to fix your system.
> 
> Best regards,
> Krzysztof
> 
Hi Krzysztof,
Find new way which can load ko files on SM4450 platform, still need use 
"Y", because of some other modules have dependence to these two config, 
like scm, smmu module drivers, uart shell console cannot be got if set 
to "m".

Also do test for setting these two config to "m" on SM8450 platform, get 
uart shell consle failed if so setting.

-- 
Thx and BRs,
Tengfei Fan
