Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB0E7E8B06
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 14:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbjKKNFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 08:05:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjKKNFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 08:05:31 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD5D130E6;
        Sat, 11 Nov 2023 05:05:28 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ABD0fSk015903;
        Sat, 11 Nov 2023 13:05:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=abIu2MORsikqvY3d7KBcDOW2/Dr/HxEN9qt7rLxhROM=;
 b=l4Wx1J+HQXSPgoPAp9YqxN/JR/5P24Ga42hRiq7xsadFQAWh+hgGIo3EQpnoQGxhy1MO
 qzcmDYRv78VTfYLq506ngWFoJwHyd6MITA+870BQ+fO6dn13OhlpZwpAaLcQtmWV0oNH
 xM1tc7jgcuRXFoBcsNdTujqc/NBTnL8reD6QSj1ig3Nt/1Bzpe8jqZg+eLDuXbI1iM1G
 Q28q4F69Nv6PyNDJaQgF+zHZh6zCJzBT7XrbYt8X3mm1jICePehUB1H724PCZe+OZ91F
 Ty5mKqRfafjZTHXkTExs9H2rGJkybUJBZ72CyHcfFr9I3FbPINiN7wlUHaNV1w0IItru ew== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ua1778mvr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 11 Nov 2023 13:05:08 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3ABD57hL009576
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 11 Nov 2023 13:05:07 GMT
Received: from [10.216.23.41] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Sat, 11 Nov
 2023 05:05:00 -0800
Message-ID: <8591f3d1-5c29-4fa0-a791-62ffb26c90f1@quicinc.com>
Date:   Sat, 11 Nov 2023 18:34:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 02/13] dt-bindings: usb: Add bindings for multiport
 properties on DWC3 controller
To:     Johan Hovold <johan@kernel.org>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Andy Gross" <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Felipe Balbi" <balbi@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        "Mathias Nyman" <mathias.nyman@intel.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>, <quic_ppratap@quicinc.com>,
        <quic_jackp@quicinc.com>, <ahalaney@redhat.com>,
        <quic_shazhuss@quicinc.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        "Rob Herring" <robh@kernel.org>
References: <20230828133033.11988-1-quic_kriskura@quicinc.com>
 <20230828133033.11988-3-quic_kriskura@quicinc.com>
 <ZU4wA9xhfjYBCaTU@hovoldconsulting.com>
 <bc3e9da6-c932-46a0-923a-44be817bd129@quicinc.com>
 <c8b0af46-6513-43fc-994d-4d04f6c65b5e@quicinc.com>
 <ZU9dlfM8tdfdqKkx@hovoldconsulting.com>
Content-Language: en-US
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <ZU9dlfM8tdfdqKkx@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: zjWeNsImxlPMJuG07Jm__gxj8S3GoT91
X-Proofpoint-GUID: zjWeNsImxlPMJuG07Jm__gxj8S3GoT91
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-11_11,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 bulkscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 phishscore=0 mlxscore=0
 mlxlogscore=755 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311110110
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/11/2023 4:25 PM, Johan Hovold wrote:
> On Sat, Nov 11, 2023 at 03:17:40PM +0530, Krishna Kurapati PSSNV wrote:
>> On 11/11/2023 2:00 PM, Krishna Kurapati PSSNV wrote:
>>> On 11/10/2023 6:58 PM, Johan Hovold wrote:
> 
>>>>>      phy-names:
>>>>>        minItems: 1
>>>>> -    maxItems: 2
>>>>> -    items:
>>>>> -      enum:
>>>>> -        - usb2-phy
>>>>> -        - usb3-phy
>>>>> +    maxItems: 8
>>>>> +    oneOf:
>>>>> +      - items:
>>>>> +          enum: [ usb2-phy, usb3-phy ]
>>>>> +      - items:
>>>>> +          pattern: "^usb[23]-port[0-3]$"
>>>>
>>>> Shouldn't this just be
>>>>
>>>>      pattern: "^usb[23]-[0-3]$"
>>>>
>>>> so that it matches the names that are used by the nvidia bindings?
>>>>
>>>> We already have some inconsistency in that Amlogic uses a variant based
>>>> on the legacy names that needlessly includes "phy" in the names:
>>>>
>>>>      const: usb2-phy0
>>>>      const: usb2-phy1
>>>>      const: usb3-phy0
>>>>      ...
>>>>
>>>> I don't think we should be introducing a third naming scheme here so I
>>>> suggest just following the nvidia bindings.
> 
>>>>> In that case, why don't we use  "^usb[23]-phy[0-3]$". I think its close
>>> to what we have on dwc3 core already today (usb2-phy/usb3-phy).
>>
>> I mean, it isn't needless. It is a phy and shouldn't the binding suggest
>> that and include "-phy" in the name ?
> 
> No, adding a '-phy' suffix to each name is unnecessary since the
> property is called 'phy-names'.
> 
> This is also documented:
> 
> 	For names used in {clock,dma,interrupt,reset}-names, do not add
> 	any suffix, e.g.: "tx" instead of "txirq" (for interrupt).
> 
> 	https://docs.kernel.org/devicetree/bindings/writing-bindings.html
> 

Thanks for the explanation.

> and we've already discussed this when I asked you to drop the likewise
> redundant '_irq' suffix from the interrupt names.

Yes, we did discuss this in irq context. But in this case I thought it 
was fine because we already have usb(2/3)-"phy" already present.

When pushing v14, will make this change to usb(2/3)-(0-3) and skip port/phy.

Regards,
Krishna,
