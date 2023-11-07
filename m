Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECB287E382B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 10:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233854AbjKGJwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 04:52:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233830AbjKGJwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 04:52:13 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6053D11A;
        Tue,  7 Nov 2023 01:52:10 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A799pOg025340;
        Tue, 7 Nov 2023 09:52:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=gRVHVnW6RyQwwjooSESskhWPcW7DSJvleK6kuyrci1I=;
 b=ACEiJAQ5jeZHVrKBDyF9zzLJm1VDx2EpVvySo2qSLgBkwvXyJkLFxuihA920CYUmXBAd
 J2CAjEHYwSsajCQ0X3RUig7Waur3lyeYFQ/BsdGU9NX26a6brRxLbz4uAcrrsCB1vbF7
 X4DH5cKGAX3tnV5Mz1uh+rk8oftOrRoaM31BpZrCuaeBun53/KtTEGhU+yvFtyAn9ijZ
 YvIFLP9FJfCRD0wurYe/hNRdCkRdgQs6lt/sI0fQS9Zx2dihLUKHbWPcyItWL5F0PmyX
 LVTNSZz/z/xSYoHS5cZI2heZvMD74QoKyKT4jMBoIMQlbJ4x//ODBM841s9rsYEJ3rqN ew== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u71bracdp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Nov 2023 09:52:01 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A79q0Yr026189
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 7 Nov 2023 09:52:00 GMT
Received: from [10.218.41.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Tue, 7 Nov
 2023 01:51:54 -0800
Message-ID: <9ce28fea-ab3e-0737-6749-3e00be6cc380@quicinc.com>
Date:   Tue, 7 Nov 2023 15:21:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 1/2] dt-bindings: phy: qcom,qmp: Add PCIe
 qcom,refclk-always-on property
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>
CC:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_vbadigan@quicinc.com>, <quic_ramkri@quicinc.com>,
        <quic_nitegupt@quicinc.com>, <quic_skananth@quicinc.com>,
        <quic_vpernami@quicinc.com>, <quic_parass@quicinc.com>
References: <20231106-refclk_always_on-v1-0-17a7fd8b532b@quicinc.com>
 <20231106-refclk_always_on-v1-1-17a7fd8b532b@quicinc.com>
 <wt47mf6vx5fx5ddghwb4aljfjqftkplsc2zieays2xwjhkxag3@plromlkrbyxz>
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <wt47mf6vx5fx5ddghwb4aljfjqftkplsc2zieays2xwjhkxag3@plromlkrbyxz>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 9wAizPbfiZzIX16tqmpdgZw4uO-g1Boe
X-Proofpoint-GUID: 9wAizPbfiZzIX16tqmpdgZw4uO-g1Boe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_15,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311070081
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/6/2023 9:50 PM, Bjorn Andersson wrote:
> On Mon, Nov 06, 2023 at 05:22:34PM +0530, Krishna chaitanya chundru wrote:
>> Document qcom,refclk-always-on property which is needed in some platforms
>> to supply refclk even in PCIe low power states.
>>
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> ---
>>   .../devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml          | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
>> index 2c3d6553a7ba..9daf0556ed3b 100644
>> --- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
>> +++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
>> @@ -93,6 +93,11 @@ properties:
>>     "#phy-cells":
>>       const: 0
>>   
>> +  qcom,refclk-always-on:
>> +    type: boolean
>> +    description: A boolean property indicating the refclk is
>> +      always on even in Low power states (optional)
> As with the driver patch, please improve this description (and use your
> 80 characters).
>
>
> It would also be preferable to capture (or at least indicate) the
> problem that this flash is working around - so that future readers
> doesn't need to go look in the commit history for the phy driver to
> figure out what this is doing.
>
> Regards,
> Bjorn

Sure I will update this in my next patch.

- Krishna Chaitanya.

>> +
>>   required:
>>     - compatible
>>     - reg
>>
>> -- 
>> 2.42.0
>>
