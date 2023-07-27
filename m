Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96504764994
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233641AbjG0H5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233603AbjG0H4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:56:33 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D78C1BDA;
        Thu, 27 Jul 2023 00:54:20 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36R6LsVC022679;
        Thu, 27 Jul 2023 07:54:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=SK86K+XmrXyN/7JdJDNBpbp60GMLpXyh+m3lcNCox8M=;
 b=BrJd9M4A+2KMw+BoO9aNJTLU7AGWJw+ex/phoeBPWWYwti0Ncq9ngm4JKCCRdZvF64Q3
 P2Fl+Q7UU/zED3jrBiQ2ZzvNgycs4fHI6U/CB+xzCS8QqREY4LWL19BdiewCS0QNWnvt
 1SHJlKMoSqDV5TpPWZ3sHWogdwNX3mdzL5YsItlHpI5UrqFC3awZIeUMvudkvgPC6Z+H
 pg8m+ekRpVKq+sYoQHO8p2SIaHOgsjD/SOYxx+D+zLqfQZteCnqr8RrXBfTWjhxN6d9a
 1OjVw8tv+Yfr6L2M3yJNBzqLJh7fExlZ9JHOuyA8UyRLSyWeOY5U16BzMPgWH1KYlpYX Gw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s3k7u05f9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 07:54:15 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36R7s9Ew027830
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 07:54:09 GMT
Received: from [10.253.74.152] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 27 Jul
 2023 00:54:05 -0700
Message-ID: <f1286da7-05a6-c8aa-d13b-075c0fd45b77@quicinc.com>
Date:   Thu, 27 Jul 2023 15:54:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/2] dt-bindings: input: qcom,pm8xxx-vib: add more PMIC
 support
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-input@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <quic_collinsd@quicinc.com>, <quic_subbaram@quicinc.com>,
        <quic_kamalw@quicinc.com>, <jestar@qti.qualcomm.com>,
        <quic_huliu@quicinc.com>
References: <20230718062639.2339589-1-quic_fenglinw@quicinc.com>
 <20230718062639.2339589-2-quic_fenglinw@quicinc.com>
 <cb534cdb-508e-b03e-4e39-50cd6654377a@linaro.org>
 <4cb9f443-bdea-695a-f1b7-3963747e9a17@quicinc.com>
 <5b7e624b-5d06-826d-92d1-2a721b7c83b7@quicinc.com>
 <fec38f3a-f103-ff0f-138c-cffa3a808001@linaro.org>
 <4210b137-2d5d-a467-ea8c-d047701fdcc2@quicinc.com>
 <dd5864ee-7df2-eb64-c7f2-0fb234900d6a@linaro.org>
 <2fa3f27d-ff08-b923-2fb1-cf7cc888e5d5@linaro.org>
From:   Fenglin Wu <quic_fenglinw@quicinc.com>
In-Reply-To: <2fa3f27d-ff08-b923-2fb1-cf7cc888e5d5@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5WBv3UlbII-Ctx52Oj20pwpNWJcOIXSA
X-Proofpoint-ORIG-GUID: 5WBv3UlbII-Ctx52Oj20pwpNWJcOIXSA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_08,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 priorityscore=1501 clxscore=1015 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307270068
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/27/2023 3:10 PM, Krzysztof Kozlowski wrote:
> On 18/07/2023 10:02, Krzysztof Kozlowski wrote:
>> On 18/07/2023 09:59, Fenglin Wu wrote:
>>
>>>>> Just FYI,the change log was updated in the cover letter here:
>>>>> https://lore.kernel.org/linux-arm-msm/20230718062639.2339589-1-quic_fenglinw@quicinc.com/T/#m3819b50503ef19e0933a10bf797351a4af35537f
>>>>>
>>>>> Also the commit text and the driver change were also updated accordingly
>>>>> to address your review comment by removing 'pm7550ba-vib' compatible string.
>>>>
>>>> Removing compatible was never my feedback. Did you read:
>>>> https://elixir.bootlin.com/linux/v6.1-rc1/source/Documentation/devicetree/bindings/writing-bindings.rst#L42
>>>> ?
>>>>
>>> Okay, so do you want me to add 'pm7550ba-vib' as a fallback compatible
>>> like this?
>>>
>>>    properties:
>>>      compatible:
>>> -    enum:
>>> -      - qcom,pm8058-vib
>>> -      - qcom,pm8916-vib
>>> -      - qcom,pm8921-vib
>>> -      - qcom,pmi632-vib
>>> -      - qcom,pm7250b-vib
>>> -      - qcom,pm7325b-vib
>>> +    oneOf:
>>> +      - enum:
>>> +          - qcom,pm8058-vib
>>> +          - qcom,pm8916-vib
>>> +          - qcom,pm8921-vib
>>> +          - qcom,pmi632-vib
>>> +          - qcom,pm7250b-vib
>>> +          - qcom,pm7325b-vib
>>> +      - items:
>>> +          - enum:
>>> +              - qcom,pm7550ba-vib
>>> +          - const: qcom,pm7325b-vib
>>>
>>
>> Yes
> 
> I wonder why this approved change turned out to something incorrect in
> your v3 patch...
> 
Since I got review comments in the driver change and I was told to 
refactor the driver before adding new HW support. I added the HW type 
logic in the driver and I was thinking it might be good to add some 
generic compatible strings to match with the HW type introduced in the 
driver change.

Anyway, I will update it to what you suggested in next patch.

> Best regards,
> Krzysztof
> 
