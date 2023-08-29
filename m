Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5061F78BE27
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 08:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233059AbjH2GAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 02:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233204AbjH2GAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 02:00:18 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09C8109;
        Mon, 28 Aug 2023 23:00:15 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37T3r4pY015322;
        Tue, 29 Aug 2023 06:00:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=NjoQx7of7gZvUoNJcfHCAxqixOcJ5euA5VWBRBwebP0=;
 b=MrDcMwPHQb8VfRd7HTXg1tfqE9ivTb2M7q1X6/RDhTTmIC5KtPfFPoU5b6G23FX5NlpE
 VQZEo1anJscK2TlGEMu98LiSMdiRmqlG+BB2tL16wI/X/HNp1SInZ0Hfb92GV8TUc0Ac
 llK9t+Vf5330WDeutiHvvUsgpcvU/U9AnJPf/KDOrysByjVg2+wk4965ns1rrSdOqz3W
 4EZpmCSPPR/tVUCTMl/xDJoQwgly2laZsPalAmE6Yi9d1xPBHFk2vShRyj+mNGw/oSYn
 Xh/slr3dYssSMU/ouf/wqlgroZuT6IJml7+tsXCjziBErJ2t4alMBG1eS2IsWPlAN/j5 9A== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sruhnsr0j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 06:00:10 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37T609hr023075
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 06:00:09 GMT
Received: from [10.216.63.45] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 28 Aug
 2023 23:00:04 -0700
Message-ID: <7abd0b40-a364-b7f2-3057-2b522e5674e1@quicinc.com>
Date:   Tue, 29 Aug 2023 11:29:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 1/7] dt-bindings: thermal: qcom-tsens: Add ipq5018
 compatible
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <srinivas.kandagatla@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <thara.gopinath@gmail.com>,
        <rafael@kernel.org>, <daniel.lezcano@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
References: <1693250307-8910-1-git-send-email-quic_srichara@quicinc.com>
 <1693250307-8910-2-git-send-email-quic_srichara@quicinc.com>
 <97501b4f-614c-b3a3-c17f-5699b21e101f@linaro.org>
From:   Sricharan Ramabadhran <quic_srichara@quicinc.com>
In-Reply-To: <97501b4f-614c-b3a3-c17f-5699b21e101f@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9ZmKMdnUoDcl93d9CrUZiH2lCAhNmuMW
X-Proofpoint-ORIG-GUID: 9ZmKMdnUoDcl93d9CrUZiH2lCAhNmuMW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_03,2023-08-28_04,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 mlxlogscore=999 suspectscore=0 clxscore=1015 phishscore=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308290050
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 8/29/2023 12:51 AM, Krzysztof Kozlowski wrote:
> On 28/08/2023 21:18, Sricharan Ramabadhran wrote:
>> IPQ5018 has tsens v1.0 block with 4 sensors and 1 interrupt.
>>
>> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>> ---
>>   .../bindings/thermal/qcom-tsens.yaml          | 19 +++++++++++++++++++
>>   1 file changed, 19 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
>> index 27e9e16e6455..2309bb6dce1b 100644
>> --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
>> +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
>> @@ -42,6 +42,7 @@ properties:
>>                 - qcom,msm8956-tsens
>>                 - qcom,msm8976-tsens
>>                 - qcom,qcs404-tsens
>> +              - qcom,ipq5018-tsens
> 
> This does not look like placed in alphanumeric order.
> 

  ok, will sort.

>>             - const: qcom,tsens-v1
>>   
>>         - description: v2 of TSENS
>> @@ -409,4 +410,22 @@ examples:
>>              #qcom,sensors = <16>;
>>              #thermal-sensor-cells = <1>;
>>       };
>> +
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    // Example 5 (for any IPQ5018 based SoC-s):
> 
> No need for new example for a difference in compatible. Drop it.

  ok, will drop it.

Regards,
  Sricharan
