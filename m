Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B04E7CCA17
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 19:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343934AbjJQRqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 13:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232025AbjJQRqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 13:46:35 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6037783;
        Tue, 17 Oct 2023 10:46:34 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39HGsRWY022257;
        Tue, 17 Oct 2023 17:46:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=wizOAI8PdKSoJNpWslPwAMKZwsvY0u4gK5kO6xEFiLU=;
 b=ixaO6Kz03PxmXAqt3FzQQ8W074Fkj7I3UiHTl0WwUjWUFkCCaCGToHOaUlMTpNRqXCK0
 b8auLdeGnl+aIJK9tZt4f8NVpYJTw1HVkjb1O9egHU431W1jABcFG7Eqk0UVN4h2bvqR
 i8plg7snU86MINhuXfWqs0cVjHdyQhKr2qhyrDSESoR8vH0DQEIxq7MPGHD+CxRx9vh8
 aLWrOaLjOMCxpFVLJ2VMYpvh1RkFxnOOYdBs+2VyBOEjZMKVzWsbNXSWpDFXqh4fbcfY
 AUXY021ck0s/ONg+5OJaR8eqbL6TARv2WDNqSaEZ14Ce9nA0fstq4YvN7GXn5v4kBydC JQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tsvxwrds1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 17:46:24 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39HHkNwK000725
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 17:46:23 GMT
Received: from [10.216.40.160] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Tue, 17 Oct
 2023 10:46:17 -0700
Message-ID: <189be124-efb1-4843-9a47-db84942838c9@quicinc.com>
Date:   Tue, 17 Oct 2023 23:16:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/8] dt-bindings: usb: qcom,dwc3: Add bindings to enable
 runtime
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <quic_ppratap@quicinc.com>, <quic_jackp@quicinc.com>,
        Conor Dooley <conor+dt@kernel.org>, <quic_wcheng@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>
References: <20231017131851.8299-1-quic_kriskura@quicinc.com>
 <20231017131851.8299-2-quic_kriskura@quicinc.com>
 <a3d612a8-1917-491d-a944-22ea39879a9d@linaro.org>
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <a3d612a8-1917-491d-a944-22ea39879a9d@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: GjAApdZHzVFdDuElrfluWIo4xkL-aJyZ
X-Proofpoint-ORIG-GUID: GjAApdZHzVFdDuElrfluWIo4xkL-aJyZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-17_03,2023-10-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 impostorscore=0 adultscore=0 clxscore=1011 mlxscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310170150
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/17/2023 10:49 PM, Krzysztof Kozlowski wrote:
> On 17/10/2023 15:18, Krishna Kurapati wrote:
>> Add enable-rt binding to let the device register vendor hooks to
>> core and facilitate runtime suspend and resume.
>>
>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>> ---
>>   Documentation/devicetree/bindings/usb/qcom,dwc3.yaml | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
>> index cb50261c6a36..788d9c510abc 100644
>> --- a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
>> +++ b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
>> @@ -151,6 +151,11 @@ properties:
>>         HS/FS/LS modes are supported.
>>       type: boolean
>>   
>> +  qcom,enable-rt:
>> +    description:
>> +      If present, register vendor hooks to facilitate runtime suspend/resume
> 
> You described the desired Linux feature or behavior, not the actual
> hardware. The bindings are about the latter, so instead you need to
> rephrase the property and its description to match actual hardware
> capabilities/features/configuration etc.
> 

Hi Krzysztof,

  Thanks for the review. Although it sounds like its a Linux property, 
internally what it does is configuring qscratch registers properly when 
(dr_mode == OTG)

  Would it be fine to rephrase the property name to 
"qcom,config-qscratch" and to make it dependent on dr_mode and 
usb-role-switch properties ? Would it be possible to make such a 
dependency in bindings ?

Regards,
Krishna,
