Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC50757619
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 10:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbjGRIB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 04:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbjGRIBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 04:01:36 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C06E10F1;
        Tue, 18 Jul 2023 01:00:52 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36I6DPVP014126;
        Tue, 18 Jul 2023 07:59:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=mmRIA9BYdk6eGohD5TnYGznjvixrsuPS8i+DW7kqNi8=;
 b=jA4THV9SDpsyfK83SJ1myf0rmeCtOWKhdfJyjKSrbWXAHZzOhqNR+JgwozjS7GgDTl5T
 NgnkFx7CqFXktUf1C9ElItGS+MPiEDaJQpuNBD2pjB5+RSWm7xasNYtazb4TmZQXwy24
 epPqCSJH0xRe/RT8Z1VpyLQPFk12cA248HOKV6G+T7DVp/QVUTbzaPqatxo3GkTSlup9
 Mt6/Z8JJI0MqH00jhRxXubEi5CzE6/XtwrfscmhMjGLlYobq+6mzz090fiCPXtwLrcv6
 kt4dwriRdYl2Vilv2DhQatqmw9OjAZlfIepOv2S2DC43c1ydKm9MmY3IyB3dqtT7ajUo Kw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rwn90879y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jul 2023 07:59:20 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36I7xJmw006490
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jul 2023 07:59:19 GMT
Received: from [10.239.154.73] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 18 Jul
 2023 00:59:16 -0700
Message-ID: <4210b137-2d5d-a467-ea8c-d047701fdcc2@quicinc.com>
Date:   Tue, 18 Jul 2023 15:59:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
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
From:   Fenglin Wu <quic_fenglinw@quicinc.com>
In-Reply-To: <fec38f3a-f103-ff0f-138c-cffa3a808001@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: mIEPHgr6ZUCcJMIngeDxooebNboTt3vs
X-Proofpoint-ORIG-GUID: mIEPHgr6ZUCcJMIngeDxooebNboTt3vs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_15,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 bulkscore=0 phishscore=0 spamscore=0 adultscore=0 mlxlogscore=999
 lowpriorityscore=0 mlxscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307180071
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/18/2023 3:20 PM, Krzysztof Kozlowski wrote:
> On 18/07/2023 09:06, Fenglin Wu wrote:
>>
>>
>> On 7/18/2023 2:38 PM, Fenglin Wu wrote:
>>>
>>>
>>> On 7/18/2023 2:33 PM, Krzysztof Kozlowski wrote:
>>>> On 18/07/2023 08:26, Fenglin Wu wrote:
>>>>> Add support for vibrator module inside Qualcomm PMI632, PM7250B, PM7325B
>>>>> PMICs.
>>>>>
>>>>> Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
>>>>> ---
>>>>
>>>> I don't see changelog. No changes then?
>>>>
>>> Sorry, I updated the change log in the cover letter which didn't seems
>>> to be sent to a wider audience, I will resend it by adding more
>>> receivers in the to list
>>>
>>> Fenglin
>>
>> Just FYI,the change log was updated in the cover letter here:
>> https://lore.kernel.org/linux-arm-msm/20230718062639.2339589-1-quic_fenglinw@quicinc.com/T/#m3819b50503ef19e0933a10bf797351a4af35537f
>>
>> Also the commit text and the driver change were also updated accordingly
>> to address your review comment by removing 'pm7550ba-vib' compatible string.
> 
> Removing compatible was never my feedback. Did you read:
> https://elixir.bootlin.com/linux/v6.1-rc1/source/Documentation/devicetree/bindings/writing-bindings.rst#L42
> ?
> 
Okay, so do you want me to add 'pm7550ba-vib' as a fallback compatible 
like this?

  properties:
    compatible:
-    enum:
-      - qcom,pm8058-vib
-      - qcom,pm8916-vib
-      - qcom,pm8921-vib
-      - qcom,pmi632-vib
-      - qcom,pm7250b-vib
-      - qcom,pm7325b-vib
+    oneOf:
+      - enum:
+          - qcom,pm8058-vib
+          - qcom,pm8916-vib
+          - qcom,pm8921-vib
+          - qcom,pmi632-vib
+          - qcom,pm7250b-vib
+          - qcom,pm7325b-vib
+      - items:
+          - enum:
+              - qcom,pm7550ba-vib
+          - const: qcom,pm7325b-vib



> Best regards,
> Krzysztof
> 
