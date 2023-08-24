Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6231878671D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 07:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239770AbjHXFYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 01:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239715AbjHXFYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 01:24:24 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1168C198;
        Wed, 23 Aug 2023 22:24:21 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37O4i9Fd018499;
        Thu, 24 Aug 2023 05:23:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=5j4GSitUJmKF6B+rp+adv4+uv8syounKcrCzealWNbo=;
 b=o2aiYcpwiSVS9umSpl2GYxDVIzx71kfFOEzx77XD7QnAHP94P2uVxybB3XUN2mwC0+IW
 Tis4XIFGoW0BmZ/PxtQKvFdIDm6+uE3E+cu8HEWBmAe6hxXVZgUO3N2R1/dakkTyFi8E
 8kn/mcv5u+xmeNg9gzLjhy0dNGCLhBMZg+fLgTpoJN6tRo0mca5yU8g/3eVZ6yxBXdCx
 Xh5HX9AstA+UG40EJ10S8qU0D1mCiGYJAkrZXzZY7uwpYLbwfE+IDrpmSLbmAbinwE4Q
 6JIwawAtXn4Q0N++AG8ltaDQBuoftBLzTzUxpyxgJh+XGxnrHWtVvMkBkvhPjjp/LOmN BA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3snt618kvy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Aug 2023 05:23:51 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37O5NntM010281
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Aug 2023 05:23:49 GMT
Received: from [10.216.48.216] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 23 Aug
 2023 22:23:41 -0700
Message-ID: <05b3d150-d592-01c4-c1d3-57c0634e039c@quicinc.com>
Date:   Thu, 24 Aug 2023 10:53:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 3/6] dt-bindings: clock: Add ipq9574 NSSCC clock and reset
 definitions
To:     Kathiravan T <quic_kathirav@quicinc.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <p.zabel@pengutronix.de>,
        <richardcochran@gmail.com>, <arnd@arndb.de>,
        <geert+renesas@glider.be>, <neil.armstrong@linaro.org>,
        <nfraprado@collabora.com>, <rafal@milecki.pl>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>
CC:     <quic_saahtoma@quicinc.com>
References: <20230711093529.18355-1-quic_devipriy@quicinc.com>
 <20230711093529.18355-4-quic_devipriy@quicinc.com>
 <ea229d40-0bce-87e8-edef-72a7f251c051@quicinc.com>
Content-Language: en-US
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <ea229d40-0bce-87e8-edef-72a7f251c051@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: rYh7Ph7rsWawXoSFK_w68zMQbrYC5B54
X-Proofpoint-GUID: rYh7Ph7rsWawXoSFK_w68zMQbrYC5B54
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-24_02,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2308240042
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/24/2023 10:48 AM, Kathiravan T wrote:
> 
> On 7/11/2023 3:05 PM, Devi Priya wrote:
>> Add NSSCC clock and reset definitions for ipq9574.
>>
>> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
>> ---
>>   .../bindings/clock/qcom,ipq9574-nsscc.yaml    |  76 +++++++++
>>   .../dt-bindings/clock/qcom,ipq9574-nsscc.h    | 152 ++++++++++++++++++
>>   .../dt-bindings/reset/qcom,ipq9574-nsscc.h    | 134 +++++++++++++++
>>   3 files changed, 362 insertions(+)
>>   create mode 100644 
>> Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml
>>   create mode 100644 include/dt-bindings/clock/qcom,ipq9574-nsscc.h
>>   create mode 100644 include/dt-bindings/reset/qcom,ipq9574-nsscc.h
>>
>> diff --git 
>> a/Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml 
>> b/Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml
>> new file mode 100644
>> index 000000000000..1e8754760785
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml
>> @@ -0,0 +1,76 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/clock/qcom,ipq9574-nsscc.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm Networking Sub System Clock & Reset Controller on 
>> IPQ9574
>> +
>> +maintainers:
>> +  - Bjorn Andersson <andersson@kernel.org>
>> +  - Anusha Rao <quic_anusha@quicinc.com>
>> +
>> +description: |
>> +  Qualcomm networking sub system clock control module provides the 
>> clocks,
>> +  resets and power domains on IPQ9574
>> +
>> +  See also::
>> +    include/dt-bindings/clock/qcom,ipq9574-nsscc.h
>> +    include/dt-bindings/reset/qcom,ipq9574-nsscc.h
>> +
>> +properties:
>> +  compatible:
>> +    const: qcom,ipq9574-nsscc
>> +
>> +  clocks:
>> +    items:
>> +      - description: Bias PLL cc clock source
>> +      - description: Bias PLL nss noc clock source
>> +      - description: Bias PLL ubi nc clock source
>> +      - description: GCC GPLL0 out aux clock source
>> +      - description: Uniphy0 GCC Rx clock source
>> +      - description: Uniphy0 GCC Tx clock source
>> +      - description: Uniphy1 GCC Rx clock source
>> +      - description: Uniphy1 GCC Tx clock source
>> +      - description: Uniphy2 GCC Rx clock source
>> +      - description: Uniphy2 GCC Tx clock source
> 
> 
> These are UniphyX *NSS* TX/RX clock source?
Yes right..Will update this in v2

Thanks,
Devi Priya
> 
> Thanks,
> 
