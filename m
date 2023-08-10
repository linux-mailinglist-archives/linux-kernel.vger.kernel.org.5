Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D73776EC2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 05:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjHJDwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 23:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjHJDwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 23:52:22 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880071FF7;
        Wed,  9 Aug 2023 20:52:21 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37A3jfda001314;
        Thu, 10 Aug 2023 03:52:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=yZh7oHTyx8d7UV8EmrnUoj76dQshViawQm5OEXHnZd8=;
 b=ko8a8ndk/83JKxPtgdjMdtBl3B2q7vd3Tr5pEsgLOn01oxuny4ph37DCzGnU95Ny+jhm
 PJ1URnevrePRLJ8vcGBmkj0Rkq0p+gnVjdbEcOQ/Haoif7R36CYp7RcqYUJaPjjYJW5M
 bNyyTad79fm5weKV6RJjDapv1GFBOpIfAth6gk9vSKNWFK6Dnh5UIRRXcNhLsiQeuMsB
 FRLaMj404Nd4EWwoU0DnUnANeFq1wcROt8QLqNw3JZi8pHA8Kan9oi9+Nc+eCnvtcU4D
 cbyfHTF7RpReXkkCYBJISRrAJK0EpICmOXnQGN5BmrUe8GAqYJQFXpEg9ytjqWaYR2lv Zw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3scqsj01uy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 03:52:06 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37A3q5nf005078
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 03:52:05 GMT
Received: from [10.253.39.188] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 9 Aug
 2023 20:52:01 -0700
Message-ID: <7d52cff6-a175-5925-a4c6-087f5de153b2@quicinc.com>
Date:   Thu, 10 Aug 2023 11:51:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v1 2/4] dt-bindings: clock: add qca8386/qca8084 clock and
 reset definitions
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <andersson@kernel.org>, <agross@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <p.zabel@pengutronix.de>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_srichara@quicinc.com>
References: <20230809080047.19877-1-quic_luoj@quicinc.com>
 <20230809080047.19877-3-quic_luoj@quicinc.com>
 <19d885aa-3740-1287-715c-5ecb913c8a72@linaro.org>
From:   Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <19d885aa-3740-1287-715c-5ecb913c8a72@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: WHLskjog62_MObIxo7BIt1rsSROAhB3l
X-Proofpoint-GUID: WHLskjog62_MObIxo7BIt1rsSROAhB3l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_02,2023-08-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308100032
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/9/2023 11:34 PM, Krzysztof Kozlowski wrote:
> On 09/08/2023 10:00, Luo Jie wrote:
>> QCA8386/QCA8084 includes the clock & reset controller that is
>> accessed by MDIO bus. Two work modes are supported, qca8386 works
>> as switch mode, qca8084 works as PHY mode.
>>
>> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
>> ---
> 
> Thank you for your patch. There is something to discuss/improve.
> 
>> +
>> +properties:
>> +  compatible:
>> +    oneOf:
>> +      - const: qcom,qca8084-nsscc
>> +      - items:
>> +          - enum:
>> +              - qcom,qca8085-nsscc
>> +              - qcom,qca8082-nsscc
>> +              - qcom,qca8386-nsscc
>> +              - qcom,qca8385-nsscc
>> +              - qcom,qca8384-nsscc
> 
> Please keep this enum sorder alphanumerically.

Okay, will update this in the next patch set.

> 
>> +          - const: qcom,qca8084-nsscc
>> +
>> +  clocks:
>> +    items:
>> +      - description: Chip XO source
>> +      - description: UNIPHY0 RX 312P5M/125M clock source
>> +      - description: UNIPHY0 TX 312P5M/125M clock source
>> +      - description: UNIPHY1 RX 312P5M/125M clock source
>> +      - description: UNIPHY1 TX 312P5M/125M clock source
>> +      - description: UNIPHY1 RX 312P5M clock source
>> +      - description: UNIPHY1 TX 312P5M clock source
>> +
>> +  reg:
>> +    items:
>> +      - description: MDIO bus address for Clock & Reset Controller register
>> +
>> +required:
>> +  - compatible
>> +  - clocks
>> +  - reg
>> +
>> +allOf:
>> +  - $ref: qcom,gcc.yaml#
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    mdio {
>> +      #address-cells = <1>;
>> +      #size-cells = <0>;
>> +
>> +      clock-controller@800000 {
>> +        compatible = "qcom,qca8084-nsscc";
>> +        reg = <24>;
> 
> I think changes from your previous version... Unit address must match
> it, so clock-controller@24

okay, will use the clock-controller@24 in the next patch set, thanks.

> 
> 
>> +        clocks = <&qca8k_xo>,
>> +                 <&qca8k_uniphy0_rx>,
> 
> 
> Best regards,
> Krzysztof
> 
