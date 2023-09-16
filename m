Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69777A2D75
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 04:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238658AbjIPC1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 22:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238595AbjIPC0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 22:26:52 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0717FA;
        Fri, 15 Sep 2023 19:26:46 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38G2Paik022074;
        Sat, 16 Sep 2023 02:26:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=hRrfhGgaCEHFqYFQ312/eamWY9b0btTEnhnCHh0IXD4=;
 b=B+Raxl5km1zQXM9ExEuzNRicv2RK3BUENCGBcOnOaiDzrj/IP9QAPxlEK/mv6I5vbGze
 pRf2iAD1B1FvLDUUVElipaDZ1bFhQhd4/2Rm9S5VWSokYXvZ9oKWu1MkBsdvO8se1evG
 2m4PMvfqDTRp2LsVRfMyuFq2xegmXXb5jM7LQKdZ/8igARpmnZsoOIZhUFbQt3sgBkdR
 ll2mpJjvAeX4IVAf8Cr0DG2WTBuwzuxnqQOrOXxwW0Pvn/0i0rUlsbKJQ79ok+5T/gas
 ejs+ksVOssf+m8FaL1Iuupt09319RRXpR3BXbKDxm315SfVNt3DEkZc5BdCHv1xBjBYo bQ== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t4vwc0rrv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 16 Sep 2023 02:26:04 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38G2Q365015685
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 16 Sep 2023 02:26:03 GMT
Received: from [10.110.15.95] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Fri, 15 Sep
 2023 19:25:59 -0700
Message-ID: <212f9bfa-6d4c-bba2-60d2-272c001a4322@quicinc.com>
Date:   Fri, 15 Sep 2023 19:25:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 8/8] arm64: defconfig: enable interconnect and pinctrl
 for SM4450
Content-Language: en-US
From:   Trilok Soni <quic_tsoni@quicinc.com>
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
 <01c020ae-a019-e4eb-14cb-64503bde05a6@quicinc.com>
In-Reply-To: <01c020ae-a019-e4eb-14cb-64503bde05a6@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: GcSFol10nsH_8H_vCyvWtczn51DTXjPF
X-Proofpoint-ORIG-GUID: GcSFol10nsH_8H_vCyvWtczn51DTXjPF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_20,2023-09-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 impostorscore=0 mlxscore=0 priorityscore=1501 adultscore=0 phishscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309160021
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/15/2023 7:21 PM, Trilok Soni wrote:
> On 9/15/2023 4:29 AM, Krzysztof Kozlowski wrote:
>> On 15/09/2023 13:18, Tengfei Fan wrote:
>>>
>>>
>>> 在 9/15/2023 5:16 PM, Krzysztof Kozlowski 写道:
>>>> On 15/09/2023 11:12, Tengfei Fan wrote:
>>>>>
>>>>>
>>>>> 在 9/15/2023 3:21 PM, Krzysztof Kozlowski 写道:
>>>>>> On 15/09/2023 04:15, Tengfei Fan wrote:
>>>>>>> Add the SM4450 interconnect and pinctrl drivers as built-in for
>>>>>>> support the Qualcomm SM4450 platform to boot to uart shell.
>>>>>>>
>>>>>>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>>>>>>> ---
>>>>>>>    arch/arm64/configs/defconfig | 2 ++
>>>>>>>    1 file changed, 2 insertions(+)
>>>>>>>
>>>>>>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
>>>>>>> index ec59174b14db..e91993de865e 100644
>>>>>>> --- a/arch/arm64/configs/defconfig
>>>>>>> +++ b/arch/arm64/configs/defconfig
>>>>>>> @@ -598,6 +598,7 @@ CONFIG_PINCTRL_SC8280XP=y
>>>>>>>    CONFIG_PINCTRL_SDM660=y
>>>>>>>    CONFIG_PINCTRL_SDM670=y
>>>>>>>    CONFIG_PINCTRL_SDM845=y
>>>>>>> +CONFIG_PINCTRL_SM4450=y
>>>>>>>    CONFIG_PINCTRL_SM6115=y
>>>>>>>    CONFIG_PINCTRL_SM6125=y
>>>>>>>    CONFIG_PINCTRL_SM6350=y
>>>>>>> @@ -1500,6 +1501,7 @@ CONFIG_INTERCONNECT_QCOM_SC7280=y
>>>>>>>    CONFIG_INTERCONNECT_QCOM_SC8180X=y
>>>>>>>    CONFIG_INTERCONNECT_QCOM_SC8280XP=y
>>>>>>>    CONFIG_INTERCONNECT_QCOM_SDM845=y
>>>>>>> +CONFIG_INTERCONNECT_QCOM_SM4450=y
>>>>>>
>>>>>> Why it cannot be =m?
>>>>>>
>>>>>> Best regards,
>>>>>> Krzysztof
>>>>>>
>>>>>
>>>>> Hi Krzysztof,
>>>>> Because system haven't capacity of loading ko files at this time on
>>>>> SM4450 platform, so setting to "Y".
>>>>
>>>> Hm? System has this capability. All systems have. What is so different
>>>> on SM4450 comparing to everything else we have here?
>>>>
>>>> No, this should be =m and you need to fix your system.
>>>>
>>>> Best regards,
>>>> Krzysztof
>>>>
>>> Hi Krzysztof,
>>> Find new way which can load ko files on SM4450 platform, still need use 
>>> "Y", because of some other modules have dependence to these two config, 
>>> like scm, smmu module drivers, uart shell console cannot be got if set 
>>> to "m".
>>
>> That's what I am asking, which device exactly needs it.
>>
>>>
>>> Also do test for setting these two config to "m" on SM8450 platform, get 
>>> uart shell consle failed if so setting.
>>
>> Yeah, this we know, I did this. I am asking about SM4450.
> 
> Why we have =m requirement when other drivers above are =Y?. Can we confirm
> w/ Georgi? I am not aware that Interconnect drivers needs to be =m only.
> 
> CONFIG_INTERCONNECT_QCOM_SC8180X=y
> CONFIG_INTERCONNECT_QCOM_SC8280XP=y
> CONFIG_INTERCONNECT_QCOM_SDM845=y

Complete list here, and it is inconsistent. Latest 8550 is also =y. Do we document
the reasons somewhere on why they are added as =y?

CONFIG_INTERCONNECT_QCOM=y
CONFIG_INTERCONNECT_QCOM_MSM8916=m
CONFIG_INTERCONNECT_QCOM_MSM8996=m
CONFIG_INTERCONNECT_QCOM_OSM_L3=m
CONFIG_INTERCONNECT_QCOM_QCM2290=m
CONFIG_INTERCONNECT_QCOM_QCS404=m
CONFIG_INTERCONNECT_QCOM_SA8775P=y
CONFIG_INTERCONNECT_QCOM_SC7180=y
CONFIG_INTERCONNECT_QCOM_SC7280=y
CONFIG_INTERCONNECT_QCOM_SC8180X=y
CONFIG_INTERCONNECT_QCOM_SC8280XP=y
CONFIG_INTERCONNECT_QCOM_SDM845=y
CONFIG_INTERCONNECT_QCOM_SM8150=m
CONFIG_INTERCONNECT_QCOM_SM8250=m
CONFIG_INTERCONNECT_QCOM_SM8350=m
CONFIG_INTERCONNECT_QCOM_SM8450=y
CONFIG_INTERCONNECT_QCOM_SM8550=y

-- 
---Trilok Soni

