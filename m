Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A52787574F6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 09:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbjGRHGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 03:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjGRHGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 03:06:45 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2081A8;
        Tue, 18 Jul 2023 00:06:44 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36I3u01W018974;
        Tue, 18 Jul 2023 07:06:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ojfwCYGTetwQwquRm+YxTfNINgoxmz2nWaG7WFx//TE=;
 b=iQQ1nwYwjRBkLzISXZD2lpAHW5xDNgG6yZC5ksAykmSN8llz8tjVqrI/S2XhLsuFYCyS
 PHjZVcSySmVVmpN5UplKg+cb0F+2yswOSs6vGE9sZVx/ECKTaHBGbRdTPs9LrdH5smeG
 5Bh7ySnP5mBlXoY+nc8o6m4msx49rDQ+clsW/wMHPCb0myY2fbbv7lXK14Li8MDDM26j
 QaTGrn9WjpsBSlXh69azgjUUjVYQVtLi3v6bUH+nvwp/r3kgl4lHYA84SWTebh2glD5F
 T3TlZMD6haltqiRzS2BrgtAq+vPkQA8orNJ2GumrHpxKaiIAEkvvZI+3Rsnt+QRh9End 4A== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rw7eesruw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jul 2023 07:06:40 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36I76d3w030358
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jul 2023 07:06:39 GMT
Received: from [10.239.154.73] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 18 Jul
 2023 00:06:35 -0700
Message-ID: <5b7e624b-5d06-826d-92d1-2a721b7c83b7@quicinc.com>
Date:   Tue, 18 Jul 2023 15:06:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 1/2] dt-bindings: input: qcom,pm8xxx-vib: add more PMIC
 support
Content-Language: en-US
From:   Fenglin Wu <quic_fenglinw@quicinc.com>
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
In-Reply-To: <4cb9f443-bdea-695a-f1b7-3963747e9a17@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: D9Eih4Ti_YLThL6srC6o8AEbmIsaRKwZ
X-Proofpoint-GUID: D9Eih4Ti_YLThL6srC6o8AEbmIsaRKwZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_15,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 mlxlogscore=999 adultscore=0 bulkscore=0 phishscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307180063
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/18/2023 2:38 PM, Fenglin Wu wrote:
> 
> 
> On 7/18/2023 2:33 PM, Krzysztof Kozlowski wrote:
>> On 18/07/2023 08:26, Fenglin Wu wrote:
>>> Add support for vibrator module inside Qualcomm PMI632, PM7250B, PM7325B
>>> PMICs.
>>>
>>> Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
>>> ---
>>
>> I don't see changelog. No changes then?
>>
> Sorry, I updated the change log in the cover letter which didn't seems 
> to be sent to a wider audience, I will resend it by adding more 
> receivers in the to list
> 
> Fenglin

Just FYI,the change log was updated in the cover letter here: 
https://lore.kernel.org/linux-arm-msm/20230718062639.2339589-1-quic_fenglinw@quicinc.com/T/#m3819b50503ef19e0933a10bf797351a4af35537f

Also the commit text and the driver change were also updated accordingly 
to address your review comment by removing 'pm7550ba-vib' compatible string.

Since the changes are receiving review comments, I will not resend it. I 
will add a larger to-list when pushing the next patchset.

>>>   Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.yaml | 3 +++
>>>   1 file changed, 3 insertions(+)
>>>
>>> diff --git 
>>> a/Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.yaml 
>>> b/Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.yaml
>>> index c8832cd0d7da..481163105d24 100644
>>> --- a/Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.yaml
>>> +++ b/Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.yaml
>>> @@ -15,6 +15,9 @@ properties:
>>>         - qcom,pm8058-vib
>>>         - qcom,pm8916-vib
>>>         - qcom,pm8921-vib
>>> +      - qcom,pmi632-vib
>>> +      - qcom,pm7250b-vib
>>> +      - qcom,pm7325b-vib
>>
>> Not much improved. With missing changelog, it seems you ignored the
>> feedback.
>>
>>
>> Best regards,
>> Krzysztof
>>
