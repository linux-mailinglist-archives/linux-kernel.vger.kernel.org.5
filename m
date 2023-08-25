Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31687882C6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 10:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244032AbjHYI53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 04:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244006AbjHYI5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 04:57:06 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5D01BF6;
        Fri, 25 Aug 2023 01:57:01 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37P8L8rS016120;
        Fri, 25 Aug 2023 08:56:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=onBKAcug19tEB8vhIRdPk/6OlxISuNmM42XPXEW9QAc=;
 b=L6sGXD3j1xKckmgyy6crfOH22H3q1FH0wDeOdmZ5+LD/OPX9hntvHLuRnqwd9lg3+eic
 4ma3njb9LycwHx97qSRViKXddool054vv0l2MgQYkWsOEdITZeneKZr/hPpmEHMAmWlG
 ofaSl++LPQb3DFrXFvERU1ySWLE3UMo6BJy/VUPca6VA2JR4Ei5XvYGhLM+6ov6++Cno
 HG2bbj5H+VXTILcbNVMiliujhT/BXl+4gCjBoNC7Rw2F/KtEb5UI5+nakZIcAv6bHzmL
 El2mbvR7g3Kz/Uv0FCmQEpYMwWdSaMecLAusAKWWW094+VzqyS8DgJBSIr4ihcUePs01 wQ== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3spmm68j1t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Aug 2023 08:56:19 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37P8uIbh000424
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Aug 2023 08:56:19 GMT
Received: from [10.216.23.75] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Fri, 25 Aug
 2023 01:56:11 -0700
Message-ID: <a3a5a5a6-fb09-4904-81a0-c1de4653e378@quicinc.com>
Date:   Fri, 25 Aug 2023 14:26:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 3/6] dt-bindings: clock: Add ipq9574 NSSCC clock and reset
 definitions
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Kathiravan T <quic_kathirav@quicinc.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <p.zabel@pengutronix.de>, <richardcochran@gmail.com>,
        <arnd@arndb.de>, <geert+renesas@glider.be>,
        <neil.armstrong@linaro.org>, <nfraprado@collabora.com>,
        <rafal@milecki.pl>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>
CC:     <quic_saahtoma@quicinc.com>
References: <20230711093529.18355-1-quic_devipriy@quicinc.com>
 <20230711093529.18355-4-quic_devipriy@quicinc.com>
 <ea229d40-0bce-87e8-edef-72a7f251c051@quicinc.com>
 <868da572-cff1-42b6-9931-06b6a8c73809@linaro.org>
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <868da572-cff1-42b6-9931-06b6a8c73809@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Rp6KQ-52rhszQMjaKaWh-UHsgFMqZ8Fy
X-Proofpoint-GUID: Rp6KQ-52rhszQMjaKaWh-UHsgFMqZ8Fy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_07,2023-08-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 clxscore=1015 mlxscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308250077
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/24/2023 2:17 PM, Konrad Dybcio wrote:
> On 24.08.2023 07:18, Kathiravan T wrote:
>>
>> On 7/11/2023 3:05 PM, Devi Priya wrote:
>>> Add NSSCC clock and reset definitions for ipq9574.
>>>
>>> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
>>> ---
>>>    .../bindings/clock/qcom,ipq9574-nsscc.yaml    |  76 +++++++++
>>>    .../dt-bindings/clock/qcom,ipq9574-nsscc.h    | 152 ++++++++++++++++++
>>>    .../dt-bindings/reset/qcom,ipq9574-nsscc.h    | 134 +++++++++++++++
>>>    3 files changed, 362 insertions(+)
>>>    create mode 100644 Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml
>>>    create mode 100644 include/dt-bindings/clock/qcom,ipq9574-nsscc.h
>>>    create mode 100644 include/dt-bindings/reset/qcom,ipq9574-nsscc.h
>>>
>>> diff --git a/Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml b/Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml
>>> new file mode 100644
>>> index 000000000000..1e8754760785
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml
>>> @@ -0,0 +1,76 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/clock/qcom,ipq9574-nsscc.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Qualcomm Networking Sub System Clock & Reset Controller on IPQ9574
>>> +
>>> +maintainers:
>>> +  - Bjorn Andersson <andersson@kernel.org>
>>> +  - Anusha Rao <quic_anusha@quicinc.com>
>>> +
>>> +description: |
>>> +  Qualcomm networking sub system clock control module provides the clocks,
>>> +  resets and power domains on IPQ9574
>>> +
>>> +  See also::
>>> +    include/dt-bindings/clock/qcom,ipq9574-nsscc.h
>>> +    include/dt-bindings/reset/qcom,ipq9574-nsscc.h
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: qcom,ipq9574-nsscc
>>> +
>>> +  clocks:
>>> +    items:
>>> +      - description: Bias PLL cc clock source
>>> +      - description: Bias PLL nss noc clock source
>>> +      - description: Bias PLL ubi nc clock source
>>> +      - description: GCC GPLL0 out aux clock source
>>> +      - description: Uniphy0 GCC Rx clock source
>>> +      - description: Uniphy0 GCC Tx clock source
>>> +      - description: Uniphy1 GCC Rx clock source
>>> +      - description: Uniphy1 GCC Tx clock source
>>> +      - description: Uniphy2 GCC Rx clock source
>>> +      - description: Uniphy2 GCC Tx clock source
>>
>>
>> These are UniphyX *NSS* TX/RX clock source?
> Wouldn't that be "source from GCC"?
These clocks are not sourced from GCC

Thanks,
Devi Priya
> 
> Konrad
