Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F35AF7AA263
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232759AbjIUVQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232779AbjIUVOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:14:50 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6077173A;
        Thu, 21 Sep 2023 10:09:36 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38LF7SUj001730;
        Thu, 21 Sep 2023 17:09:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=5dKSzsyZM5JPtVbo5DfS/qJ3ZHwTE1rMzD1SnxB46FA=;
 b=ie1HxowFegRzzkWhYjJZ0E65hkj437NXMRkZbWJYHZUfm+VEKpKdstevytrL44zX35jR
 ukS4Gw9L0WHaBJuG52a+uAOJ+9nHGE4v0mCReVJ0RhR0H8nOgGq+a2mieUkjrJJMxx+s
 ij3oETuUSIHuwjGZXzmE1mpcgONyVylToul6LQ3AhG0IA9ryVWxg8d+vOCkkxuSLsvSe
 vbohb6q5W9FEG9jc67IstvSq3Uvh8WfZMn2zSYFBhNVxWM7bfTKydowR3Pr9eFXHSnq1
 4cl71pcf38W09fZs9SxwrbMoOV34URjixneGaiN2m+idRaK2Zv00c+14/xM4Eq1ceo+K mw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t8892252q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Sep 2023 17:09:30 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38LH9TWu030076
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Sep 2023 17:09:29 GMT
Received: from [10.71.115.175] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 21 Sep
 2023 10:09:28 -0700
Message-ID: <63c9ced1-6204-88e9-1dae-2979388bbc67@quicinc.com>
Date:   Thu, 21 Sep 2023 10:09:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4 2/3] dt-bindings: usb: snps,dwc3: Add
 runtime-suspend-on-usb-suspend property
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     Roger Quadros <rogerq@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        <quic_kriskura@quicinc.com>
References: <31fa930a-51fb-6a7f-300d-e71f6b399eb1@linaro.org>
 <a0a6c561-6319-00ba-c6db-f1dec9f0f0aa@quicinc.com>
 <5dfae814-7233-eb1f-cae7-f335e54ce1b6@linaro.org>
 <cf0227c8-cd02-81b6-9e13-2e7fe6f505f2@kernel.org>
 <20230826015257.mbogiefsbz5474ft@synopsys.com>
 <afd4843b-427a-8535-78e2-f81879378371@linaro.org>
 <969988f6-f01f-0e31-6a98-7d02c5a3a4ad@quicinc.com>
 <20230830013739.srnh2uyhly66yvu2@synopsys.com>
 <d30a8d6a-236a-b6eb-76d7-115cc9950ce1@quicinc.com>
 <6f70a710-c409-23c0-890b-370ccd23e088@linaro.org>
 <20230831030134.z46fjwyr6edl3t7x@synopsys.com>
 <cea3472a-e9f7-39cb-419c-d042b3bf0682@linaro.org>
From:   Elson Serrao <quic_eserrao@quicinc.com>
In-Reply-To: <cea3472a-e9f7-39cb-419c-d042b3bf0682@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: leAIDSd3QKQtagJEXnzmzO_uHngggWLO
X-Proofpoint-ORIG-GUID: leAIDSd3QKQtagJEXnzmzO_uHngggWLO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-21_14,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309210148
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/30/2023 11:29 PM, Krzysztof Kozlowski wrote:
> On 31/08/2023 05:01, Thinh Nguyen wrote:
>> On Wed, Aug 30, 2023, Krzysztof Kozlowski wrote:
>>> On 30/08/2023 06:31, Elson Serrao wrote:
>>>>
>>>>
>>>> On 8/29/2023 6:37 PM, Thinh Nguyen wrote:
>>>>> Just want to clarify, there are dwc3 properties and there are dt binding
>>>>> properties. Often the case that dt binding matches 1-to-1 with dwc3
>>>>> driver property. Now, we need to enhance the checkers so that the dwc3
>>>>> driver property to match cases where it is platform specific and through
>>>>> compatible string.
>>>>>
>>>>
>>>> Thank you for the clarification Thinh.
>>>> To confirm, we would need to modify the driver to parse a new compatible
>>>> string (say "snps,dwc3-ext-wakeup") and add .data field so that the
>>>> driver is aware that this particular platform supports external wakeup
>>>> detection.Right ?
>>>
>>> No, it's not then platform specific. You said it depends on each
>>> platform. Platform is Qualcomm SM8450 for example.
>>>
>>
>> Hi Elson,
>>
>> Use the compatible string of your platform.
>>
>> e.g.
>> if (dev->of_node) {
>> 	struct device_node *parent = of_get_parent(dev->of_node);
>>
>> 	dwc->no_disconnect_on_usb_suspend =
>> 		of_device_is_compatible(parent, "qcom,your-compatible-string") ||
>> 		of_device_is_compatible(parent, "some-other-platform");
>> }
>>
>> You need to enhance dwc3_get_properties(). This may get big as dwc3 adds
>> more properties. Perhaps you can help come up with ideas to keep this
>> clean. Perhaps we can separate this out of dwc3 core.c?

HI Thinh

Apologies for the delayed response.
Series 
https://patchwork.kernel.org/project/linux-usb/cover/1655094654-24052-1-git-send-email-quic_kriskura@quicinc.com/ 
from Krishna K, introduced a dt property 'wakeup-source' which indicates 
a platforms capability to handle wakeup interrupts. Based on this 
property, glue drivers can inform dwc3 core that the device is wakeup 
capable through device_init_wakeup(). For example dwc3-qcom driver 
informs it like below as per the implementation done in the above series

	wakeup_source = of_property_read_bool(dev->of_node, "wakeup-source");
	device_init_wakeup(&pdev->dev, wakeup_source);
	device_init_wakeup(&qcom->dwc3->dev, wakeup_source);

The dwc3 core now can access this info through 
device_may_wakeup(dwc->dev) while checking for bus suspend scenario to 
know whether the platform is capable of detecting wakeup.

Please let me know your thoughts on this approach.

Thanks
Elson

