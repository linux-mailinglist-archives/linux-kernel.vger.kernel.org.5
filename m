Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF24F7FF04E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 14:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345620AbjK3Nhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 08:37:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345606AbjK3Nhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 08:37:52 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4ADC4;
        Thu, 30 Nov 2023 05:37:58 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AUBt4CI032596;
        Thu, 30 Nov 2023 13:37:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=D4urVbhmcVHg+zDN+1uI7L+DvfPy0F3NUE4iAdZuAMU=;
 b=iAg/YnWET+uB+v8h2hMrfuDlzbImm0aglXwfYSLmR8CkvKREDyetOhfXG2AY9NC9FMAG
 0GWHV2RYIIO69gI8K6cMRwZrYcLdbq5fhxzY2pycAADYSitv0d4ap7h3D93bKC5Jwrqc
 W5PHs+oB+E6B4NxUw4GrpJ1iGLXX2NJMJj7Z8L8yXABlIXYlFRYMOgxqkzYSwty4HzC7
 NMu4zkYHADQUOYAv8X0jjnpD481/i74WkipnDty0k0pIf69eNA1EsUTJbvBk0JH3PbY4
 e/45cYC3B7WMeSVNZiGzourt5f8PHxHrxjjEoViYdNbBBhWDTF8PJsdaQdjOpH778KdC wg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3up2byuwcr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Nov 2023 13:37:53 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AUDbqp6011305
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Nov 2023 13:37:52 GMT
Received: from [10.239.133.49] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 30 Nov
 2023 05:37:49 -0800
Message-ID: <22ddb4aa-a908-49c3-8eb4-2399c7c5bc37@quicinc.com>
Date:   Thu, 30 Nov 2023 21:37:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] arm64: dts: qcom: msm8996: Fix 'in-ports' is a
 required property
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>
References: <20231129143815.7892-1-quic_jinlmao@quicinc.com>
 <20231129143815.7892-2-quic_jinlmao@quicinc.com>
 <3527d540-3e3f-4edb-b5f2-6ac481132c06@linaro.org>
 <591e1aca-20ca-4d42-809d-12cd12ddadb3@quicinc.com>
 <35916812-af55-4b2a-99e5-8566e945cb6e@linaro.org>
 <5ef0372a-2b9d-4a19-bbb4-2c6ce29dbe79@quicinc.com>
 <5bc8b7e3-7a4f-48d4-a1fa-9e3cb0b39a3a@linaro.org>
Content-Language: en-US
From:   Jinlong Mao <quic_jinlmao@quicinc.com>
In-Reply-To: <5bc8b7e3-7a4f-48d4-a1fa-9e3cb0b39a3a@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: S0Mg-Hzo3MbnhYpjJn879lFcmTDDG2rT
X-Proofpoint-ORIG-GUID: S0Mg-Hzo3MbnhYpjJn879lFcmTDDG2rT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-30_11,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 impostorscore=0 bulkscore=0
 mlxlogscore=617 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311300101
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/30/2023 9:35 PM, Krzysztof Kozlowski wrote:
> On 30/11/2023 14:12, Jinlong Mao wrote:
>>
>>
>> On 11/30/2023 8:06 PM, Krzysztof Kozlowski wrote:
>>> On 30/11/2023 12:15, Jinlong Mao wrote:
>>>>
>>>>
>>>> On 11/30/2023 4:55 PM, Krzysztof Kozlowski wrote:
>>>>> On 29/11/2023 15:38, Mao Jinlong wrote:
>>>>>> The inport of funnel@3023000 connects to a source which is not supported
>>>>>> in current linux kernel. Remove the device tree node of funnel@3023000
>>>>>> to fix the warning. It will be added once the driver support to the
>>>>>> source is added to linux kernel.
>>>>>
>>>>> Thanks for the changes, but that's not correct reason to remove DTS
>>>>> code. What kernel supports or not, should be irrelevant for the DTS. DTS
>>>>> for example is used in other projects - did you check if they have the
>>>>> same issues? Anyway, DTS describes the hardware, so how current kernel
>>>>> support defines what is and what is not in the hardware?
>>>>>
>>>>>
>>>>> Best regards,
>>>>> Krzysztof
>>>>
>>>> Hi Krzysztof,
>>>>
>>>> The funnel dt node must have in-ports node. It is to describe the input
>>>> connection of funnel HW. But there is no dt_binding doc to describe the
>>>> DT node of the HW connected to funnel@3023000. So remove the funnel to
>>>> solve the warning as of now. The funnel will be added back once driver
>>>> and dt_binding are added for the HW.
>>>>
>>>> Documentation/devicetree/bindings/arm/arm,coresight-dynamic-funnel.yaml
>>>
>>> Why we cannot add now the binding for the connected hardware? It's not
>>> really related to the driver.
>>>
>>> Best regards,
>>> Krzysztof
>>
>> Do you mean yaml file can be added before the driver code is merged ?
> 
> Yes, the binding. YAML is only the language. We don't write YAMLs, we
> write bindings.
> 
> Best regards,
> Krzysztof

ok, Thanks. I will prepare the binding file.

Thanks
Jinlong Mao

> 

