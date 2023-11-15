Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB2D47EC6A0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 16:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344376AbjKOPDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 10:03:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344432AbjKOPDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 10:03:32 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3651AE;
        Wed, 15 Nov 2023 07:03:28 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AFCb2Jx015147;
        Wed, 15 Nov 2023 15:03:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=TArmughCiaySbtxApQ9r8oFmeuAAF7BBzQ/u9l67Jus=;
 b=UpHRzaZA3T8IVgbknuTXpky7MVb1eq50hslsnC4VnQ7l+Q2Xj5vCJdfenOgbvHhXtf2P
 kqH6F6GL2yx13JOHdESc7WSvLNLfNRa1T4/+q4pLacc94dZ2xij8m0r3SV7s8nxUxokQ
 2L98FALZSfXRJ64eKLSr9OCJhs4LGIs5bNgmPvyN8LGWFjtD9GI7HBA4aIfESdrDmCRE
 sH5E66Iu2vOY2jrFih34OFZ7QK08lGKOt9vrxOIqc88sanlvmOlXsApVeod6Y0A/ZdWE
 VK76n5EqWmq0mjUzL06FVdnz52B6z8QOaI2GG4JceR38SoDJJGe1Hpg4b8hfGJ7mpjZn nA== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ucanq3178-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 15:03:10 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AFF39YW019798
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 15:03:09 GMT
Received: from [10.111.175.193] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Wed, 15 Nov
 2023 07:03:06 -0800
Message-ID: <26a7eb74-7f54-4ade-a761-ce08e85f2a93@quicinc.com>
Date:   Wed, 15 Nov 2023 10:03:04 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: phy: Document sm8450 pcie phys as having 4
 clocks
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20231103230339.966792-1-quic_eberman@quicinc.com>
 <ZVRwKaUTDBaYsnQS@hovoldconsulting.com>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <ZVRwKaUTDBaYsnQS@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: RcazGwatS5aUDL0JxL6r0WQY5HjjpnDB
X-Proofpoint-ORIG-GUID: RcazGwatS5aUDL0JxL6r0WQY5HjjpnDB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-15_13,2023-11-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 priorityscore=1501 clxscore=1011
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311150115
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/15/2023 2:15 AM, Johan Hovold wrote:
> On Fri, Nov 03, 2023 at 04:03:38PM -0700, Elliot Berman wrote:
>> I noticed while running make dtbs_check that
>> qcom,sm8450-qmp-gen3x1-pcie-phy and qcom,sm8450-qmp-gen4x2-pcie-phy have
>> 4 clocks, not 5. There was also a typo for the 8450 bindings:
>> s/gen3x2/gen4x2/.
>>
>> Update the bindings to reflect the correct number of required clocks.
>>
>> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> Fixes: 505fb2541678 ("dt-bindings: phy: migrate QMP PCIe PHY bindings to qcom,sc8280xp-qmp-pcie-phy.yaml")
>> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
>> ---
>>  .../bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml | 16 ++++++++++++++--
>>  1 file changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
>> index 2c3d6553a7ba..1768f2016a9f 100644
>> --- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
>> +++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
>> @@ -128,6 +128,20 @@ allOf:
>>          reg:
>>            maxItems: 1
>>  
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - qcom,sm8450-qmp-gen3x1-pcie-phy
>> +              - qcom,sm8450-qmp-gen4x2-pcie-phy
>> +    then:
>> +      properties:
>> +        clocks:
>> +          minItems: 4
>> +        clock-names:
>> +          minItems: 4
>> +
> 
> I'm not sure which tree you think you're looking at but this is clearly
> not correct.
> 
> The phy nodes in arch/arm64/boot/dts/qcom/sm8450.dtsi have five clocks
> defined.
> 

You're right, next now has 5 clocks for 8450. -next vs. tip of tree strikes me again :)

I'll send out a fix for just the typo tomorrow/Friday when I do another sweep of
dtbs_check (on next/master instead of torvalds/master).

> Johan
