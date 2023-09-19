Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2B77A68D2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 18:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbjISQ0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 12:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjISQ0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 12:26:37 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F39BEA9;
        Tue, 19 Sep 2023 09:26:31 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38JBu2AU004360;
        Tue, 19 Sep 2023 16:26:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=gCIY04ta2zwSB0oAu5savGSfd8+mF+dsGqBagg5pEfA=;
 b=YXb6RtvWq4pWLNeeALgralSOvLNoXDIHhn1gG7h6XedHjids4/mxFTouVGh1UmbVu7q9
 FyP52dC05vtrEUoKOanu2dpcN/OuoVfaBmeIyEOvdjN0s7dtG7Vzy4ZhLBS+yzYBzxS3
 QxqejNUaiEwjXEfVg6gZuBskE//5QSm5PZUQVNGbuyKsMUePqpGH3KdS6m6iWa+n6VjA
 5EJ7CmcfXE/Lmjt2av1vR/8vbv2BoU0VFXrYGiMUSBY8afR2hs+SHFC/7afFGTRLjjS5
 RHhDKrCY2Zs662QgV/4QoJaC/aB5I+oOMh1oEfyAJq60vJrueTSyW6yEuCwuiI+Dl6UE cg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t79180ya5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Sep 2023 16:26:22 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38JGQLG6015333
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Sep 2023 16:26:21 GMT
Received: from [10.216.36.122] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 19 Sep
 2023 09:26:16 -0700
Message-ID: <9c3d1857-5053-cd8f-75d5-d2691139dfc9@quicinc.com>
Date:   Tue, 19 Sep 2023 21:56:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH V2 1/4] dt-bindings: thermal: qcom-tsens: Add ipq5018
 compatible
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <srinivas.kandagatla@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <thara.gopinath@gmail.com>,
        <rafael@kernel.org>, <daniel.lezcano@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <dmitry.baryshkov@linaro.org>
References: <20230915121504.806672-1-quic_srichara@quicinc.com>
 <20230915121504.806672-2-quic_srichara@quicinc.com>
 <03b0cafa-49c7-8838-b116-927c9649cbd3@linaro.org>
 <f5aee51d-0345-1294-a85b-ea96ed937685@linaro.org>
 <1f09339e-b3b5-874c-4874-199e8c7ae890@quicinc.com>
 <ee19e076-8f9c-c5b2-3e25-2832dbdab25b@linaro.org>
 <affb1f63-c1ed-f0cc-ea79-887ae61b9b90@quicinc.com>
 <156f4705-ca1a-f82e-9282-534a22183f37@linaro.org>
From:   Sricharan Ramabadhran <quic_srichara@quicinc.com>
In-Reply-To: <156f4705-ca1a-f82e-9282-534a22183f37@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: w5D_J84Rb0vKzZ_2XoTkvdS3B7OxDg_5
X-Proofpoint-GUID: w5D_J84Rb0vKzZ_2XoTkvdS3B7OxDg_5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-19_07,2023-09-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=645 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309190142
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/19/2023 6:26 PM, Krzysztof Kozlowski wrote:
> On 19/09/2023 14:48, Sricharan Ramabadhran wrote:
>>
>>
>> On 9/19/2023 6:02 PM, Krzysztof Kozlowski wrote:
>>> On 19/09/2023 09:22, Sricharan Ramabadhran wrote:
>>>>
>>>>
>>>> On 9/15/2023 6:15 PM, Krzysztof Kozlowski wrote:
>>>>> On 15/09/2023 14:43, Krzysztof Kozlowski wrote:
>>>>>> On 15/09/2023 14:15, Sricharan Ramabadhran wrote:
>>>>>>> IPQ5018 has tsens v1.0 block with 4 sensors and 1 interrupt.
>>>>>>>
>>>>>>> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>>>>>>> ---
>>>>>>>     [v2] Sorted the compatible and removed example
>>>>>>>
>>>>>>
>>>>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>>>
>>>>> No, unreviewed. Your driver says it is not compatible with
>>>>> qcom,tsens-v1. This does not look right :/
>>>>>
>>>>
>>>>     Yes it is V1 IP, but since there is no RPM, to enable the IP/SENSORS
>>>>     have to do those steps after calling init_common. Similar reason
>>>>     added a new feat as well in patch #2 as well. Hence for this,
>>>>     new compatible was required.
>>>
>>> I dud not write about new or old compatible ("compatible" as noun). I
>>> wrote that it is not compatible ("compatible" as adjective) with v1.
>>>
>>
>>    Ho, in that case, yes it is not compatible with V1 init and features
>>    because of 'no rpm'. So in that case, should this be documented
>>    as a separate version of 'V1 without rpm' ?
> 
> It should not be mixed with regular v1, just as new entry there. I don't
> think fallback is needed - just use SoC specific compatible.
> 
  ok, sure, will add in V3.

Regards,
  Sricharan
