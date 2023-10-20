Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4899E7D12B3
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 17:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377676AbjJTPaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 11:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377601AbjJTPaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 11:30:00 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68854D41;
        Fri, 20 Oct 2023 08:29:58 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39KDUosx005737;
        Fri, 20 Oct 2023 15:29:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Zivo8kx1pIerVJTmwPFk7leURv7N5iykBsr/H6Wnn2A=;
 b=QPmcon2GnKHdcKYFGDHMcTg56xRpOL9WMo6eVGOhI3dYrLUT2oIwEuBpshUMInXY0mcJ
 5rk/uFkQYwdphK2MgvRPXW4MOYsbJkJey5O/310rkSngtMA4bsXTZbn7EYxAkAa0Gwee
 E+TZS03KVJXBGZ5lG6ChLq/sjU9IBy3R4HNgoe3QQ5/RVQL598sON1rPypbfGeGvi4Ec
 YGTg33z6FIoUR3IWFqIGYjq7QmsEDJAiMIGx20aJzaUGJ6A2rvxAVk1EbPn1NIDRceSF
 +DM+IBbbB1s6qL+DmsUwCiTmoaeD/8WWjYGyhYa87qU+xWRBDGfSAKXrJs0fYzsyIwgu aQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tubwr2d8e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Oct 2023 15:29:35 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39KFTZPr007813
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Oct 2023 15:29:35 GMT
Received: from [10.216.54.41] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Fri, 20 Oct
 2023 08:29:27 -0700
Message-ID: <8bc2b104-130e-4cdd-952c-662bc1b8759a@quicinc.com>
Date:   Fri, 20 Oct 2023 20:59:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V15 2/4] dt-bindings: pwm: add IPQ6018 binding
Content-Language: en-US
To:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Devi Priya <quic_devipriy@quicinc.com>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <lee@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <thierry.reding@gmail.com>, <ndesaulniers@google.com>,
        <trix@redhat.com>, <baruch@tkos.co.il>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>,
        <linux-pwm@vger.kernel.org>, <nathan@kernel.org>
References: <20231005160550.2423075-1-quic_devipriy@quicinc.com>
 <20231005160550.2423075-3-quic_devipriy@quicinc.com>
 <20231018204608.qyifcnnzgi2bgzn6@pengutronix.de>
 <CAL_Jsq+df_nmNVuf46-a5Dafe4THxD-5HS-BPsTn_yzTckrOJw@mail.gmail.com>
From:   Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
In-Reply-To: <CAL_Jsq+df_nmNVuf46-a5Dafe4THxD-5HS-BPsTn_yzTckrOJw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Dlg4fU-dsgrfd7ApwWBMi8TZKnzjSAmh
X-Proofpoint-ORIG-GUID: Dlg4fU-dsgrfd7ApwWBMi8TZKnzjSAmh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-20_10,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=999 impostorscore=0
 adultscore=0 mlxscore=0 clxscore=1011 phishscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2310170001 definitions=main-2310200129
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/20/2023 8:44 PM, Rob Herring wrote:
> On Wed, Oct 18, 2023 at 3:46 PM Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> wrote:
>> Hello,
>>
>> On Thu, Oct 05, 2023 at 09:35:48PM +0530, Devi Priya wrote:
>>> DT binding for the PWM block in Qualcomm IPQ6018 SoC.
>>>
>>> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> Co-developed-by: Baruch Siach <baruch.siach@siklu.com>
>>> Signed-off-by: Baruch Siach <baruch.siach@siklu.com>
>>> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
>>> ---
>>> v15:
>>>
>>>    No change
>>>
>>> v14:
>>>
>>>    Picked up the R-b tag
>>>
>>> v13:
>>>
>>>    Updated the file name to match the compatible
>>>
>>>    Sorted the properties and updated the order in the required field
>>>
>>>    Dropped the syscon node from examples
>>>
>>> v12:
>>>
>>>    Picked up the R-b tag
>>>
>>> v11:
>>>
>>>    No change
>>>
>>> v10:
>>>
>>>    No change
>>>
>>> v9:
>>>
>>>    Add 'ranges' property to example (Rob)
>>>
>>>    Drop label in example (Rob)
>>>
>>> v8:
>>>
>>>    Add size cell to 'reg' (Rob)
>>>
>>> v7:
>>>
>>>    Use 'reg' instead of 'offset' (Rob)
>>>
>>>    Drop 'clock-names' and 'assigned-clock*' (Bjorn)
>>>
>>>    Use single cell address/size in example node (Bjorn)
>>>
>>>    Move '#pwm-cells' lower in example node (Bjorn)
>>>
>>>    List 'reg' as required
>>>
>>> v6:
>>>
>>>    Device node is child of TCSR; remove phandle (Rob Herring)
>>>
>>>    Add assigned-clocks/assigned-clock-rates (Uwe Kleine-König)
>>>
>>> v5: Use qcom,pwm-regs for phandle instead of direct regs (Bjorn
>>>      Andersson, Kathiravan T)
>>>
>>> v4: Update the binding example node as well (Rob Herring's bot)
>>>
>>> v3: s/qcom,pwm-ipq6018/qcom,ipq6018-pwm/ (Rob Herring)
>>>
>>> v2: Make #pwm-cells const (Rob Herring)
>>>
>>>   .../bindings/pwm/qcom,ipq6018-pwm.yaml        | 45 +++++++++++++++++++
>>>   1 file changed, 45 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml b/Documentation/devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml
>>> new file mode 100644
>>> index 000000000000..6d0d7ed271f7
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml
>>> @@ -0,0 +1,45 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/pwm/qcom,ipq6018-pwm.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Qualcomm IPQ6018 PWM controller
>>> +
>>> +maintainers:
>>> +  - Baruch Siach <baruch@tkos.co.il>
>> Not being very fluent in dt and binding yaml I wonder if adding
>>
>>          allOf:
>>            - $ref: pwm.yaml#
>>
>> would be beneficial?!
> Not really because the only thing you pick up is #pwm-cells, but
> that's still needed here since that varies by binding. A reference
> generally becomes useful when there are child nodes (e.g. a bus
> binding) or multiple properties.
>
>>> +properties:
>>> +  compatible:
>>> +    const: qcom,ipq6018-pwm
>>> +
>>> +  reg:
>>> +    description: Offset of PWM register in the TCSR block.
>>> +    maxItems: 1
>>> +
>>> +  clocks:
>>> +    maxItems: 1
>>> +
>>> +  "#pwm-cells":
>>> +    const: 2
>> The driver only supports normal polarity. Is this a shortcoming of the
>> driver, or is the hardware incapable to do that, too?
>>
>> If it's only the former I'd want #pwm-cells = <3> here. For ease of use
>> I'd not oppose if you pick #pwm-cells = <3> even if the hardware can
>> only do normal polarity.
> Devi, Can we get an answer here soon.


Rob, Devi is on vacation for couple of weeks. I don't have much idea on 
this as of now, how can I help here, if needed?


>
> The MFD part has been applied and it references this schema causing
> warnings. So this needs to land or MFD schema reverted.
>
> Rob
