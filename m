Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE5BA7DDCF9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 08:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjKAHLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 03:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKAHLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 03:11:22 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE1AED;
        Wed,  1 Nov 2023 00:11:16 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A15E7T7019694;
        Wed, 1 Nov 2023 07:10:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=xyWa2o4b/iezYFKnmRES5uOiC/IHE6kSxdojrrY3jok=;
 b=On63kjZkT1fEMtnhFF7Cq8dcuhTG4Y2YOLkJ5Sx92q6tKkvJ5dwGcff1ub1ZP9fuJRFJ
 B5kksSlGNUbekAqhUAcY69KbhPvu/nCegFcPZ1eH+1hhziHnyuWdAN0f2WS4B2gO5UY8
 q74zNeGQZnCEKz1992Db+KsQCkIWJQT8In18iWbFNXX8sm4s81EHTJxheNRYx43LCDGN
 aa4Zpve6pmFWdDxD7ZfYQliZkWICnX7OZManYkonPVmr3FFW660kxqN0jKsbXGj7A9Ld
 RcYb+K0FSsqhjFd7Cf93oWRv3FlhnIo4SJDB4D+EitXXtfadjeAnSdkbKqWBQ+pW6uXg Vg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u3a5eha18-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Nov 2023 07:10:57 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A17Au2G013733
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 1 Nov 2023 07:10:56 GMT
Received: from [10.239.133.211] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Wed, 1 Nov
 2023 00:10:51 -0700
Message-ID: <aded6ef6-fdfa-45ee-bae6-a57a8448eb5b@quicinc.com>
Date:   Wed, 1 Nov 2023 15:10:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/8] dt-bindings: arm: Add support for TPDM CMB MSR
 register
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
CC:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jinlong Mao <quic_jinlmao@quicinc.com>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Song Chai <quic_songchai@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <andersson@kernel.org>
References: <1698202408-14608-1-git-send-email-quic_taozha@quicinc.com>
 <1698202408-14608-8-git-send-email-quic_taozha@quicinc.com>
 <20231026212710.GA424453-robh@kernel.org>
From:   Tao Zhang <quic_taozha@quicinc.com>
In-Reply-To: <20231026212710.GA424453-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: v3GYE4Fw__KJTbqPc2dm-YsoCuqdqi8C
X-Proofpoint-ORIG-GUID: v3GYE4Fw__KJTbqPc2dm-YsoCuqdqi8C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_03,2023-10-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 impostorscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311010059
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/27/2023 5:27 AM, Rob Herring wrote:
> On Wed, Oct 25, 2023 at 10:53:27AM +0800, Tao Zhang wrote:
>> Add property "qcom,cmb_msr_num" to support CMB MSR(mux select register)
>> for TPDM. It specifies the number of CMB MSR registers supported by
>> the TDPM.
>>
>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
>> ---
>>   Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml b/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
>> index f9a2025..a586b80a 100644
>> --- a/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
>> +++ b/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
>> @@ -69,6 +69,15 @@ properties:
>>       minimum: 0
>>       maximum: 32
>>   
>> +  qcom,cmb-msrs-num:
>> +    description:
>> +      Specifies the number of CMB MSR(mux select register) registers supported
>> +      by the monitor. If this property is not configured or set to 0, it means
>> +      this TPDM doesn't support CMB MSR.
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    minimum: 0
>> +    maximum: 32
> default: 0

If the TPDM doesn't support CMB MSR, we will not configure this 
property. Set to 0 to indicate

that CMB MSR is not supported and is only an optional method.

Is it necessary to add this "default" value here?


Best,

Tao

>> +
>>     clocks:
>>       maxItems: 1
>>   
>> @@ -124,6 +133,7 @@ examples:
>>         reg-names = "tpdm-base";
>>   
>>         qcom,cmb-element-size = /bits/ 8 <64>;
>> +      qcom,cmb-msrs-num = <32>;
>>   
>>         clocks = <&aoss_qmp>;
>>         clock-names = "apb_pclk";
>> -- 
>> 2.7.4
>>
