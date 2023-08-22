Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA97784D8D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 01:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbjHVX6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 19:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjHVX6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 19:58:44 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185D0CF9;
        Tue, 22 Aug 2023 16:58:42 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37MNrc8w019427;
        Tue, 22 Aug 2023 23:58:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=VwpTXaMNlC8r9DEmyDGakUHDwr2NYiRXS33qig45UEg=;
 b=BlnT3RUeJSq2qrbCtYswCZmpqAtFs3A16Fz/K2dKMaDM/8EiCn1wawsgKH7aViSxCRDm
 RS0txAjKsP7Wois+WgiY3KuHB9ZQN1QId1W3JjhvCMvBE4Nmi5ofO/1ZZHVMgwdLbVdU
 O+qe9lo4m4ut/nZ/Fz8eb87PF53BpxVQhV3ETbxd5jbZX2seASNtikPuTQp5lfU4aGkc
 VLNFjdIf56VRK2eBbV6denib8AtEW+mjhN+TTN27dhu+EN1PX5mF5CpPEJ5J5vmoEThS
 iJaxsOrAOmd12P5UOXNTM9qg8oMgk4KKrdXhlP/uZg93EXGgkZfWaF0Q2MNWMCLUdyLo wA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sn2mvge89-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Aug 2023 23:58:34 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37MNwXxX007723
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Aug 2023 23:58:33 GMT
Received: from [10.110.87.122] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 22 Aug
 2023 16:58:32 -0700
Message-ID: <a0a6c561-6319-00ba-c6db-f1dec9f0f0aa@quicinc.com>
Date:   Tue, 22 Aug 2023 16:58:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4 2/3] dt-bindings: usb: snps,dwc3: Add
 runtime-suspend-on-usb-suspend property
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <gregkh@linuxfoundation.org>, <Thinh.Nguyen@synopsys.com>,
        <rogerq@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>
References: <20230814185043.9252-1-quic_eserrao@quicinc.com>
 <20230814185043.9252-3-quic_eserrao@quicinc.com>
 <a77403f5-8b99-3012-3843-1999ee8d12ce@linaro.org>
 <6b27cd55-4e44-7a26-30ff-9692344cae4c@quicinc.com>
 <31fa930a-51fb-6a7f-300d-e71f6b399eb1@linaro.org>
From:   Elson Serrao <quic_eserrao@quicinc.com>
In-Reply-To: <31fa930a-51fb-6a7f-300d-e71f6b399eb1@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: wOtcQ-jMWoVOhNoyIuQj7Dil_hFbl4_N
X-Proofpoint-GUID: wOtcQ-jMWoVOhNoyIuQj7Dil_hFbl4_N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-22_21,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 impostorscore=0 mlxscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 spamscore=0 mlxlogscore=359 bulkscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308220197
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/19/2023 2:35 AM, Krzysztof Kozlowski wrote:
> On 18/08/2023 21:16, Elson Serrao wrote:
>>
>>
>> On 8/15/2023 10:44 PM, Krzysztof Kozlowski wrote:
>>> On 14/08/2023 20:50, Elson Roy Serrao wrote:
>>>> This property allows dwc3 runtime suspend when bus suspend interrupt
>>>> is received even with cable connected. This would allow the dwc3
>>>> controller to enter low power mode during bus suspend scenario.
>>>>
>>>> This property would particularly benefit dwc3 IPs where hibernation is
>>>> not enabled and the dwc3 low power mode entry/exit is handled by the
>>>> glue driver. The assumption here is that the platform using this dt
>>>> property is capable of detecting resume events to bring the controller
>>>> out of suspend.
>>>>
>>>> Signed-off-by: Elson Roy Serrao <quic_eserrao@quicinc.com>
>>>> ---
>>>>    Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 5 +++++
>>>>    1 file changed, 5 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>>>> index a696f23730d3..e19a60d06d2b 100644
>>>> --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>>>> +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>>>> @@ -403,6 +403,11 @@ properties:
>>>>        description:
>>>>          Enable USB remote wakeup.
>>>>    
>>>> +  snps,runtime-suspend-on-usb-suspend:
>>>> +    description:
>>>> +      If True then dwc3 runtime suspend is allowed during bus suspend
>>>> +      case even with the USB cable connected.
>>>
>>> This was no tested... but anyway, this is no a DT property but OS
>>> policy. There is no such thing as "runtime suspend" in the hardware,
>>> because you describe one particular OS.
>>>
>>> Sorry, no a DT property, drop the change entirely.
>>>
>>>
>> Hi Krzysztof
>>
>> Sorry my local dt checker had some issue and it did not catch these
>> errors. I have rectified it now.
>>
>> This dt property is mainly for skipping dwc3 controller halt when a USB
>> suspend interrupt is received with usb cable connected, so that we dont
>> trigger a DISCONNECT event. Perhaps a better name would reflect the true
>> usage of this?
>>
>> Something like snps,skip-dwc3-halt-on-usb-suspend. dwc3 cores where
>> hibernation feature is not enabled/supported can use this property
> 
> So this is specific to DWC3 core, thus should be just implied by compatible.
> 

Hi Krzysztof

Apologies for not being clear. Below is the reasoning behind this dt entry.

When bus suspend interrupt is received and if usb cable is connected, 
dwc3 driver does not suspend. The aim of this series is to handle this 
interrupt when USB cable is connected to achieve power savings. OEMs 
might have their own implementation in their glue driver to turn off 
clocks and other resources when USB is not in use, thus saving power. 
But since glue layer has dependency on dwc3 driver (parent-child 
relationship) we need to allow dwc3 driver to NOT ignore the bus suspend 
interrupt and let the dwc3 driver suspend (so that glue driver can 
suspend as well)

Now it is the responsibility of glue driver to detect USB wakeup signal 
from the host during resume (since dwc3 driver is suspended at this 
point and cannot handle interrupts). Every OEM may not have the 
capability to detect wakeup signal. The goal of this dt property is for 
the dwc3 driver to allow handling of the bus suspend interrupt when such 
a capability exists on a given HW platform. When this property is 
defined dwc3 driver knows that the low power mode entry/exit is 
controlled by the glue driver and thus it can allow the suspend 
operation when bus suspend interrupt is received.

For example on Qualcomm platforms there is a phy sideband signalling 
which detects the wakeup signal when resume is initiated by the host. 
Thus qcom platforms can benefit from this feature by defining this dt 
property. (in a parallel discussion with Thinh N to come up with a 
better name for this dt entry).

Thanks
Elson


