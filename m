Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 258C378134A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 21:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379592AbjHRTQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 15:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379585AbjHRTQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 15:16:42 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B583A9A;
        Fri, 18 Aug 2023 12:16:40 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37IFgdB4032675;
        Fri, 18 Aug 2023 19:16:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=M7AyHtkOD7BP2Rqswxij2Lysdt0K7dux5u9Qwg9Ybmk=;
 b=JB2yEwP5qJsyquXhzvHhathfVQyWLk/+jswMuqQCOeWXKm2NDcvrfFjS+FndcvyGxD46
 btTD1obfdSIxWezol1UZzCyVcnHVHmV9ZI7yixFE2xdc1KjPNehIlMzgC2EC1bF4rVBl
 fmQvRC1wGWOWdxTUioxJq+mC9pgBq49vnYP5CGTRU0OaLAtMBhj8GVUQSvhRVfKewqas
 GIiTsCul181qb/IgRSQI7lrH8pupbJBCNb+uTbOMVPK0T0A0tX6JK022BYDe31j+QJTQ
 FAE8JmPL7Th3evnV5wbIoOOg1CLncJmS/ubeq+/+ibFEyvhQznAYRgerLKYSpnHVXgds Rg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sj3g9hecd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Aug 2023 19:16:34 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37IJGX86001768
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Aug 2023 19:16:33 GMT
Received: from [10.110.43.93] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Fri, 18 Aug
 2023 12:16:32 -0700
Message-ID: <6b27cd55-4e44-7a26-30ff-9692344cae4c@quicinc.com>
Date:   Fri, 18 Aug 2023 12:16:25 -0700
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
From:   Elson Serrao <quic_eserrao@quicinc.com>
In-Reply-To: <a77403f5-8b99-3012-3843-1999ee8d12ce@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: r9gQ5kqbUrkT1ITBW44BqoRBiLXjkaeK
X-Proofpoint-ORIG-GUID: r9gQ5kqbUrkT1ITBW44BqoRBiLXjkaeK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-18_24,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1011
 priorityscore=1501 spamscore=0 mlxlogscore=666 bulkscore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308180176
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/15/2023 10:44 PM, Krzysztof Kozlowski wrote:
> On 14/08/2023 20:50, Elson Roy Serrao wrote:
>> This property allows dwc3 runtime suspend when bus suspend interrupt
>> is received even with cable connected. This would allow the dwc3
>> controller to enter low power mode during bus suspend scenario.
>>
>> This property would particularly benefit dwc3 IPs where hibernation is
>> not enabled and the dwc3 low power mode entry/exit is handled by the
>> glue driver. The assumption here is that the platform using this dt
>> property is capable of detecting resume events to bring the controller
>> out of suspend.
>>
>> Signed-off-by: Elson Roy Serrao <quic_eserrao@quicinc.com>
>> ---
>>   Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>> index a696f23730d3..e19a60d06d2b 100644
>> --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>> +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>> @@ -403,6 +403,11 @@ properties:
>>       description:
>>         Enable USB remote wakeup.
>>   
>> +  snps,runtime-suspend-on-usb-suspend:
>> +    description:
>> +      If True then dwc3 runtime suspend is allowed during bus suspend
>> +      case even with the USB cable connected.
> 
> This was no tested... but anyway, this is no a DT property but OS
> policy. There is no such thing as "runtime suspend" in the hardware,
> because you describe one particular OS.
> 
> Sorry, no a DT property, drop the change entirely.
> 
> 
Hi Krzysztof

Sorry my local dt checker had some issue and it did not catch these 
errors. I have rectified it now.

This dt property is mainly for skipping dwc3 controller halt when a USB 
suspend interrupt is received with usb cable connected, so that we dont 
trigger a DISCONNECT event. Perhaps a better name would reflect the true 
usage of this?

Something like snps,skip-dwc3-halt-on-usb-suspend. dwc3 cores where 
hibernation feature is not enabled/supported can use this property

Hi Thinh,Roger
Please let me know your opinion on 'snps,skip-dwc3-halt-on-usb-suspend' 
as the quirk name.

Thanks
Elson
