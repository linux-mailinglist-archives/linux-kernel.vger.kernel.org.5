Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59A347A2D6E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 04:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238480AbjIPCXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 22:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238685AbjIPCWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 22:22:30 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A777E6;
        Fri, 15 Sep 2023 19:22:24 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38G1x1YN011725;
        Sat, 16 Sep 2023 02:21:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=1R36WjfkZxHYOJy2LplpgS3S6JdXrNHUUNIhn81PzLo=;
 b=erNsIUqyzVmW1vk4+h25EqnpMvPOIzjPpWsdP386H7zkeTZhSg07K0FoOHHCqIJRPCiC
 igkGoZkxAmkTy93uxaIArR0PzMvLwF0QDFfxyDc42V0s/+CcmUV1ebC5yQr0+A5xlaf6
 9DtkOqEGcfKQ0wXSU9rXqQTBf5T+8wQ60wugKZUaqNTJLZgCUNuhMOw5ZLSyCMBNeKqQ
 cyiRbeKNbZ5QwS74n6Ue5yy1YNG5Rd30yRd2nOMxrk2YTQq7mO3Q+3o6S7VmBxFtmuqK
 bfKCiD1U8D+AIrYHGMNyJH3TXSBfIkOHFTHVxYknXHr73m/tHiMbKj0TVdUkyyk5f8bZ jw== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t51qug50q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 16 Sep 2023 02:21:46 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38G2Ljgn011180
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 16 Sep 2023 02:21:45 GMT
Received: from [10.110.15.95] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Fri, 15 Sep
 2023 19:21:41 -0700
Message-ID: <01c020ae-a019-e4eb-14cb-64503bde05a6@quicinc.com>
Date:   Fri, 15 Sep 2023 19:21:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 8/8] arm64: defconfig: enable interconnect and pinctrl
 for SM4450
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Tengfei Fan <quic_tengfan@quicinc.com>, <will@kernel.org>,
        <robin.murphy@arm.com>, <joro@8bytes.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <catalin.marinas@arm.com>
CC:     <geert+renesas@glider.be>, <arnd@arndb.de>,
        <neil.armstrong@linaro.org>, <nfraprado@collabora.com>,
        <rafal@milecki.pl>, <peng.fan@nxp.com>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <quic_shashim@quicinc.com>,
        <quic_kaushalk@quicinc.com>, <quic_tdas@quicinc.com>,
        <quic_tingweiz@quicinc.com>, <quic_aiquny@quicinc.com>,
        <kernel@quicinc.com>
References: <20230915021509.25773-1-quic_tengfan@quicinc.com>
 <20230915021509.25773-10-quic_tengfan@quicinc.com>
 <8f2c9664-a2c8-50dc-8a1c-e50a071ebeb2@linaro.org>
 <e9ff05b3-2742-416e-b417-5e2414036008@quicinc.com>
 <0a34dd35-7aea-4655-4cdd-e7196a1ba52b@linaro.org>
 <f76e1cc8-fc48-4208-bbe4-9204d9d28363@quicinc.com>
 <b7398390-23bc-467c-5b83-411110d60f43@linaro.org>
From:   Trilok Soni <quic_tsoni@quicinc.com>
In-Reply-To: <b7398390-23bc-467c-5b83-411110d60f43@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6VUDJoTl82cWLQ9nXyAeN5rzv0gbgnqd
X-Proofpoint-ORIG-GUID: 6VUDJoTl82cWLQ9nXyAeN5rzv0gbgnqd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_20,2023-09-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=999
 impostorscore=0 lowpriorityscore=0 mlxscore=0 clxscore=1011 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309160020
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/15/2023 4:29 AM, Krzysztof Kozlowski wrote:
> On 15/09/2023 13:18, Tengfei Fan wrote:
>>
>>
>> 在 9/15/2023 5:16 PM, Krzysztof Kozlowski 写道:
>>> On 15/09/2023 11:12, Tengfei Fan wrote:
>>>>
>>>>
>>>> 在 9/15/2023 3:21 PM, Krzysztof Kozlowski 写道:
>>>>> On 15/09/2023 04:15, Tengfei Fan wrote:
>>>>>> Add the SM4450 interconnect and pinctrl drivers as built-in for
>>>>>> support the Qualcomm SM4450 platform to boot to uart shell.
>>>>>>
>>>>>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>>>>>> ---
>>>>>>    arch/arm64/configs/defconfig | 2 ++
>>>>>>    1 file changed, 2 insertions(+)
>>>>>>
>>>>>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
>>>>>> index ec59174b14db..e91993de865e 100644
>>>>>> --- a/arch/arm64/configs/defconfig
>>>>>> +++ b/arch/arm64/configs/defconfig
>>>>>> @@ -598,6 +598,7 @@ CONFIG_PINCTRL_SC8280XP=y
>>>>>>    CONFIG_PINCTRL_SDM660=y
>>>>>>    CONFIG_PINCTRL_SDM670=y
>>>>>>    CONFIG_PINCTRL_SDM845=y
>>>>>> +CONFIG_PINCTRL_SM4450=y
>>>>>>    CONFIG_PINCTRL_SM6115=y
>>>>>>    CONFIG_PINCTRL_SM6125=y
>>>>>>    CONFIG_PINCTRL_SM6350=y
>>>>>> @@ -1500,6 +1501,7 @@ CONFIG_INTERCONNECT_QCOM_SC7280=y
>>>>>>    CONFIG_INTERCONNECT_QCOM_SC8180X=y
>>>>>>    CONFIG_INTERCONNECT_QCOM_SC8280XP=y
>>>>>>    CONFIG_INTERCONNECT_QCOM_SDM845=y
>>>>>> +CONFIG_INTERCONNECT_QCOM_SM4450=y
>>>>>
>>>>> Why it cannot be =m?
>>>>>
>>>>> Best regards,
>>>>> Krzysztof
>>>>>
>>>>
>>>> Hi Krzysztof,
>>>> Because system haven't capacity of loading ko files at this time on
>>>> SM4450 platform, so setting to "Y".
>>>
>>> Hm? System has this capability. All systems have. What is so different
>>> on SM4450 comparing to everything else we have here?
>>>
>>> No, this should be =m and you need to fix your system.
>>>
>>> Best regards,
>>> Krzysztof
>>>
>> Hi Krzysztof,
>> Find new way which can load ko files on SM4450 platform, still need use 
>> "Y", because of some other modules have dependence to these two config, 
>> like scm, smmu module drivers, uart shell console cannot be got if set 
>> to "m".
> 
> That's what I am asking, which device exactly needs it.
> 
>>
>> Also do test for setting these two config to "m" on SM8450 platform, get 
>> uart shell consle failed if so setting.
> 
> Yeah, this we know, I did this. I am asking about SM4450.

Why we have =m requirement when other drivers above are =Y?. Can we confirm
w/ Georgi? I am not aware that Interconnect drivers needs to be =m only.

CONFIG_INTERCONNECT_QCOM_SC8180X=y
CONFIG_INTERCONNECT_QCOM_SC8280XP=y
CONFIG_INTERCONNECT_QCOM_SDM845=y

-- 
---Trilok Soni

