Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 932FD773CD6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbjHHQKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbjHHQIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:08:23 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC80E72B1;
        Tue,  8 Aug 2023 08:46:15 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3784Emmx011882;
        Tue, 8 Aug 2023 05:19:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=PIdgMZR8W+Ik6UeWAcjVFurIfmZejnHlq4mvtB1MIRY=;
 b=HyW7PCKJacgBLG6Orka3HZgv2VdB/Qoiq6cGDeLrl6QaZ8CpgEgdpjmuyZL+X7PP3LI5
 WqaGs2HCSq9eiKIuP4F2ZwIuOSG1aZDrG/C7VXU3X4FlbUpFj6CUBYBONSAG114ifopZ
 KcfV69ckVlzFJI9r+Vy+VygrqSi5AfS+bB7iXjL1+QWoy5LtLGXOuoQMnh+iHvd+ZXmb
 gDJoTGCiPtQsPGfnM/UWEe00ENoPn3tf4oYG/L1XYVrHYcN7fKWBDcup+nyWU2YPuZAF
 2+dLC4PvvkVDjPfPUvZcFA324t6xhAYt6R7NsBoupF4uNaErAswGroJfIHHAK3L34Wwo Qw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sb7bb8sqh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Aug 2023 05:19:11 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3785J9qc031032
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 8 Aug 2023 05:19:10 GMT
Received: from [10.253.9.41] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 7 Aug
 2023 22:19:06 -0700
Message-ID: <cf9788f0-a115-5ff9-1195-f4f302551e04@quicinc.com>
Date:   Tue, 8 Aug 2023 13:19:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 2/3] dt-bindings: clock: add qca8386/qca8084 clock and
 reset definitions
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <p.zabel@pengutronix.de>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_srichara@quicinc.com>
References: <20230801085352.22873-1-quic_luoj@quicinc.com>
 <20230801085352.22873-3-quic_luoj@quicinc.com>
 <ef996a7e-6eba-4366-c3ea-0d08f2768e98@linaro.org>
Content-Language: en-US
From:   Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <ef996a7e-6eba-4366-c3ea-0d08f2768e98@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: OLwaJZaka2cXgwYjJ3UdM-BCW9JfqH3y
X-Proofpoint-ORIG-GUID: OLwaJZaka2cXgwYjJ3UdM-BCW9JfqH3y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-08_03,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 spamscore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308080046
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/7/2023 2:52 PM, Krzysztof Kozlowski wrote:
> On 01/08/2023 10:53, Luo Jie wrote:
>> QCA8386/QCA8084 includes the clock & reset controller that is
>> accessed by MDIO bus. Two work modes are supported, qca8386 works
>> as switch mode, qca8084 works as PHY mode.
>>
>> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
>> ---
>>   .../bindings/clock/qcom,nsscc-qca8k.yaml      |  59 ++++++++++
>>   include/dt-bindings/clock/qcom,nsscc-qca8k.h  | 102 ++++++++++++++++++
>>   include/dt-bindings/reset/qcom,nsscc-qca8k.h  |  76 +++++++++++++
>>   3 files changed, 237 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/clock/qcom,nsscc-qca8k.yaml
>>   create mode 100644 include/dt-bindings/clock/qcom,nsscc-qca8k.h
>>   create mode 100644 include/dt-bindings/reset/qcom,nsscc-qca8k.h
>>
>> diff --git a/Documentation/devicetree/bindings/clock/qcom,nsscc-qca8k.yaml b/Documentation/devicetree/bindings/clock/qcom,nsscc-qca8k.yaml
>> new file mode 100644
>> index 000000000000..8fb77156070c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/qcom,nsscc-qca8k.yaml
>> @@ -0,0 +1,59 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/clock/qcom,nsscc-qca8k.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm NSS Clock & Reset Controller on QCA8386/QCA8084
>> +
>> +maintainers:
>> +  - Luo Jie <quic_luoj@quicinc.com>
>> +
>> +description: |
>> +  Qualcomm NSS clock control module provides the clocks and resets
>> +  on QCA8386(switch mode)/QCA8084(PHY mode)
>> +
>> +  See also::
>> +    include/dt-bindings/clock/qcom,nsscc-qca8k.h
>> +    include/dt-bindings/reset/qcom,nsscc-qca8k.h
>> +
>> +properties:
>> +  compatible:
>> +    const: qcom,nsscc-qca8k
> 
> SoC name is before IP block names. See:
> Documentation/devicetree/bindings/arm/qcom-soc.yaml
> 
> qca8k is not SoC specific. I don't know what you are documenting here,
> but if this is a SoC, then follow SoC rules.
> 
> If this is not SoC, it confuses me a bit to use GCC binding.
> 
> Anyway, this was not tested, as pointed out by bot... Please test the
> code before sending.
> 
> Best regards,
> Krzysztof
> 

Hi Krzysztof,

Thanks for the review comments.
qca8383/qca8084 is a network chip that support switch mode and PHY mode,
the hardware register is accessed by MDIO bus, which is not a SOC.

But it has the self-contained clock controller system, the clock 
framework of qca8386/qca8084 is same as the GCC of ipq platform such as 
ipq9574.

would you help advise whether we can document it with the compatible
"qcom,qca8k-nsscc"?

Jie.
