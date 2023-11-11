Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8FA7E89DC
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 09:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjKKIab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 03:30:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjKKIaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 03:30:30 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001023C15;
        Sat, 11 Nov 2023 00:30:25 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AB8KPVt000864;
        Sat, 11 Nov 2023 08:30:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=6oio5Qy8QsXoJhLnkZbCRQo07ka9yYrRvnwasgLvLIg=;
 b=pnkXTb6F2Ih/MbTijpLkDAvO7k8vL1kENKEw6CCpnnV38aySlLisjXHAGRhGOup4U9e6
 23MPbWYnDgSb8wbi8Un1hiGDRY5hCO0c0cUZSTumkEWCYO+aPxrGoUekUYKbvRd0Vzi3
 DDtbrbKTI6mvJsG8ocrBXN7hppMwtIzSFDnj83Rk9jwPr9eri4rWnvUL/mFbInrx4UQ7
 4y5OBv9Ijf7e9Z5WqehK8PSrlGypLyR4FfR7g9MG+cCpi6VgGmlV8PTUhquTrbUlaiw/
 3a4ty410q8Yy4cEZswZg/4e9q885fjLJxYv0AokoU/Dxdbz0YUY+jpxOh9qzA7850YmY kA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ua2sw07pv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 11 Nov 2023 08:30:13 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AB8UCrj025810
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 11 Nov 2023 08:30:12 GMT
Received: from [10.216.34.97] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Sat, 11 Nov
 2023 00:30:05 -0800
Message-ID: <bc3e9da6-c932-46a0-923a-44be817bd129@quicinc.com>
Date:   Sat, 11 Nov 2023 14:00:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 02/13] dt-bindings: usb: Add bindings for multiport
 properties on DWC3 controller
To:     Johan Hovold <johan@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        "Wesley Cheng" <quic_wcheng@quicinc.com>,
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
Content-Language: en-US
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <ZU4wA9xhfjYBCaTU@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _GkF51NF8E-IZV4xko6SsTN60Gr-a9gA
X-Proofpoint-GUID: _GkF51NF8E-IZV4xko6SsTN60Gr-a9gA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-11_06,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501
 adultscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311110070
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/10/2023 6:58 PM, Johan Hovold wrote:
> On Mon, Aug 28, 2023 at 07:00:22PM +0530, Krishna Kurapati wrote:
>> Add bindings to indicate properties required to support multiport
>> on Synopsys DWC3 controller.
>>
>> Suggested-by: Bjorn Andersson <quic_bjorande@quicinc.com>
>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> ---
>>   .../devicetree/bindings/usb/snps,dwc3.yaml          | 13 +++++++------
>>   1 file changed, 7 insertions(+), 6 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>> index a696f23730d3..5bc941355b43 100644
>> --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>> +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>> @@ -85,15 +85,16 @@ properties:
>>   
>>     phys:
>>       minItems: 1
>> -    maxItems: 2
>> +    maxItems: 8
>>   
>>     phy-names:
>>       minItems: 1
>> -    maxItems: 2
>> -    items:
>> -      enum:
>> -        - usb2-phy
>> -        - usb3-phy
>> +    maxItems: 8
>> +    oneOf:
>> +      - items:
>> +          enum: [ usb2-phy, usb3-phy ]
>> +      - items:
>> +          pattern: "^usb[23]-port[0-3]$"
> 
> Shouldn't this just be
> 
> 	pattern: "^usb[23]-[0-3]$"
> 
> so that it matches the names that are used by the nvidia bindings?
> 
> We already have some inconsistency in that Amlogic uses a variant based
> on the legacy names that needlessly includes "phy" in the names:
> 
> 	const: usb2-phy0
> 	const: usb2-phy1
> 	const: usb3-phy0
> 	...
> 
> I don't think we should be introducing a third naming scheme here so I
> suggest just following the nvidia bindings.
> 
In that case, why don't we use  "^usb[23]-phy[0-3]$". I think its close 
to what we have on dwc3 core already today (usb2-phy/usb3-phy).

Regards,
Krishna,
