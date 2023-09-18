Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA90C7A3F43
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 03:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236457AbjIRBkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 21:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235866AbjIRBkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 21:40:05 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C3011C;
        Sun, 17 Sep 2023 18:40:00 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38I1dsoJ012864;
        Mon, 18 Sep 2023 01:39:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=fektZLu9V9H5UJ+0rOKIBNhaOjy+v1AhJEJMQgo9JkI=;
 b=IC6piAl0AVJVCWL+0cWa/IvS67M9eAIc0qje6aZL3b1gUr6PxokrUrmkaLCrCFsxSkMW
 i4dtPpWk/NxUJGImHD17LYF+jUuoe/5Jowu+YfrCymvoAql+RNDhcxx29SIpI0uaYGhe
 YizuKdYgOSyz12Zcxq6chhyCi7rzcEwPDO61BbTQSOBdczqfa62FHe5869kk69ytDj9K
 NOa9qeeJXjLgmbSQ+CqFTSUZVFnz0XcNOltuVWTxyj5sUmMgkZ2v6WDcwe8+BBRovsTN
 Wf+BB4mqHBuY4oTaMM/X7uMYIQ/WEVbeRzE79c8kaHkebPacXvc/1TCcC5qyQRfHJFn8 1Q== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t554pj2y1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Sep 2023 01:39:54 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38I1dree024140
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Sep 2023 01:39:53 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Sun, 17 Sep
 2023 18:39:46 -0700
Message-ID: <6e31d07f-133e-4abe-8225-45c822429bae@quicinc.com>
Date:   Mon, 18 Sep 2023 09:39:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: pinctrl: qcom: Add SM4450 pinctrl
To:     Rob Herring <robh@kernel.org>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <andersson@kernel.org>, <agross@kernel.org>,
        <konrad.dybcio@linaro.org>, <linus.walleij@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_tsoni@quicinc.com>, <quic_shashim@quicinc.com>,
        <quic_kaushalk@quicinc.com>, <quic_tdas@quicinc.com>,
        <quic_tingweiz@quicinc.com>, <quic_aiquny@quicinc.com>,
        <kernel@quicinc.com>
References: <20230915015808.18296-1-quic_tengfan@quicinc.com>
 <20230915015808.18296-2-quic_tengfan@quicinc.com>
 <6f40ee72-b763-c58d-44df-ea40d1309820@linaro.org>
 <35371580-8e5a-4f72-aec2-951268c296a3@quicinc.com>
 <20230915145947.GA3716246-robh@kernel.org>
From:   Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <20230915145947.GA3716246-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: MWke8LkhVPybNMe8Z95GKq2FrQujruRu
X-Proofpoint-ORIG-GUID: MWke8LkhVPybNMe8Z95GKq2FrQujruRu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_20,2023-09-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 mlxlogscore=999 adultscore=0 mlxscore=0
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309180014
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 9/15/2023 10:59 PM, Rob Herring 写道:
> On Fri, Sep 15, 2023 at 03:30:16PM +0800, Tengfei Fan wrote:
>>
>>
>> 在 9/15/2023 3:04 PM, Krzysztof Kozlowski 写道:
>>> On 15/09/2023 03:58, Tengfei Fan wrote:
>>>> Add device tree binding Documentation details for Qualcomm SM4450
>>>> TLMM device.
>>>>
>>>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>>>
>>> ...
>>>
>>>> +
>>>> +patternProperties:
>>>> +  "-state$":
>>>> +    oneOf:
>>>> +      - $ref: "#/$defs/qcom-sm4450-tlmm-state"
>>>> +      - patternProperties:
>>>> +          "-pins$":
>>>> +            $ref: "#/$defs/qcom-sm4450-tlmm-state"
>>>> +        additionalProperties: false
>>>> +
>>>> +$defs:
>>>> +  qcom-sm4450-tlmm-state:
>>>> +    type: object
>>>> +    description:
>>>> +      Pinctrl node's client devices use subnodes for desired pin configuration.
>>>> +      Client device subnodes use below standard properties.
>>>> +    $ref: qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state
>>>> +    unevaluatedProperties: false
>>>> +
>>>> +    properties:
>>>> +      pins:
>>>> +        description:
>>>> +          List of gpio pins affected by the properties specified in this
>>>> +          subnode.
>>>> +        items:
>>>> +          oneOf:
>>>> +            - pattern: "^gpio([0-9]|[1-9][0-9]|1[0-9][0-9])$"
>>>
>>> This is still wrong. How many GPIOs do you have? Please open existing
>>> bindings for recent device (e.g. sm8550) and look how it is done there.
>> yes, will update to "^gpio([0-9]|[1-9][0-9]|1[0-2][0-5])$".
> 
> What about 106, 116, etc.?
> 
> Rob
understand more, need "^gpio([0-9]|[1-9][0-9]|1[0-1][0-9]|12[0-5])$".

-- 
Thx and BRs,
Tengfei Fan
