Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACF217E8A12
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 10:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbjKKJsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 04:48:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjKKJsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 04:48:08 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4D43868;
        Sat, 11 Nov 2023 01:48:05 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AB9lqvQ027650;
        Sat, 11 Nov 2023 09:47:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=EArrppmS9FdoyRjpdteRNy11j3gNXGWyBi80uF9WpbM=;
 b=NtXNvikdMGIDl1TCsr2WEKoWUgUud8rMNt43+b4ioN3lnyIRZ8EM6YlzfmxqlunTku4o
 EqT4vva4iUO7Qm6dLOduyGEGZ5rdeOSRNkuAiv2G+y9F/s1hV+bm3h5xp2Qux1xEsAC6
 6RSJbEBm+GdPoxWijqwe7GiBMq6V021rn5FYISduLKt1HoT/eMxQt/dtMT+CLp3OPZJH
 vNgUsS1LjEw+mVvJQ/oEMEoO/DELNK0BNjybufIEikv2W4SZIJQMwt2zx/BE7+0KdRfD
 AAtRt7cImu0Wpl3n9xbuFSjKDaqz1wroJwUCUztYX5Sw1L48OelcRG2maYXZoo90xfLN Nw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ua2sw0a7j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 11 Nov 2023 09:47:52 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AB9lpt1023857
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 11 Nov 2023 09:47:51 GMT
Received: from [10.216.34.97] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Sat, 11 Nov
 2023 01:47:44 -0800
Message-ID: <c8b0af46-6513-43fc-994d-4d04f6c65b5e@quicinc.com>
Date:   Sat, 11 Nov 2023 15:17:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 02/13] dt-bindings: usb: Add bindings for multiport
 properties on DWC3 controller
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
To:     Johan Hovold <johan@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>, <quic_ppratap@quicinc.com>,
        <quic_jackp@quicinc.com>, <ahalaney@redhat.com>,
        <quic_shazhuss@quicinc.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Rob Herring <robh@kernel.org>
References: <20230828133033.11988-1-quic_kriskura@quicinc.com>
 <20230828133033.11988-3-quic_kriskura@quicinc.com>
 <ZU4wA9xhfjYBCaTU@hovoldconsulting.com>
 <bc3e9da6-c932-46a0-923a-44be817bd129@quicinc.com>
Content-Language: en-US
In-Reply-To: <bc3e9da6-c932-46a0-923a-44be817bd129@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: W0Old6QqYucfWI7FwvMn6_ca6I76Jk4I
X-Proofpoint-GUID: W0Old6QqYucfWI7FwvMn6_ca6I76Jk4I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-11_08,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501
 adultscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311110081
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/11/2023 2:00 PM, Krishna Kurapati PSSNV wrote:
> 
> 
> On 11/10/2023 6:58 PM, Johan Hovold wrote:
>> On Mon, Aug 28, 2023 at 07:00:22PM +0530, Krishna Kurapati wrote:
>>> Add bindings to indicate properties required to support multiport
>>> on Synopsys DWC3 controller.
>>>
>>> Suggested-by: Bjorn Andersson <quic_bjorande@quicinc.com>
>>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>>> Reviewed-by: Rob Herring <robh@kernel.org>
>>> ---
>>>   .../devicetree/bindings/usb/snps,dwc3.yaml          | 13 +++++++------
>>>   1 file changed, 7 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml 
>>> b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>>> index a696f23730d3..5bc941355b43 100644
>>> --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>>> +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>>> @@ -85,15 +85,16 @@ properties:
>>>     phys:
>>>       minItems: 1
>>> -    maxItems: 2
>>> +    maxItems: 8
>>>     phy-names:
>>>       minItems: 1
>>> -    maxItems: 2
>>> -    items:
>>> -      enum:
>>> -        - usb2-phy
>>> -        - usb3-phy
>>> +    maxItems: 8
>>> +    oneOf:
>>> +      - items:
>>> +          enum: [ usb2-phy, usb3-phy ]
>>> +      - items:
>>> +          pattern: "^usb[23]-port[0-3]$"
>>
>> Shouldn't this just be
>>
>>     pattern: "^usb[23]-[0-3]$"
>>
>> so that it matches the names that are used by the nvidia bindings?
>>
>> We already have some inconsistency in that Amlogic uses a variant based
>> on the legacy names that needlessly includes "phy" in the names:
>>
>>     const: usb2-phy0
>>     const: usb2-phy1
>>     const: usb3-phy0
>>     ...
>>
>> I don't think we should be introducing a third naming scheme here so I
>> suggest just following the nvidia bindings.
>> > In that case, why don't we use  "^usb[23]-phy[0-3]$". I think its close
> to what we have on dwc3 core already today (usb2-phy/usb3-phy).
> 
I mean, it isn't needless. It is a phy and shouldn't the binding suggest 
that and include "-phy" in the name ?

Regards,
Krishna,
