Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1792C7CD01F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 00:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234147AbjJQW7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 18:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjJQW73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 18:59:29 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E72A4;
        Tue, 17 Oct 2023 15:59:28 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39HMH8TN014215;
        Tue, 17 Oct 2023 22:59:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=iz0L8alZ+dPfV19ATH3djg35IWvxdhzam4YmjqjCkjo=;
 b=jSoDuA7ev1ETkG3XAxlgNryICVimHkObpzvNxVmdmVJTO9JEfUEcVMClGgucImwmRsUo
 K1KLndqHvxqRsb4kyZhIAe1hso4YPXYFhvdyjULou5I1R5GoOcCqf8FPHlAdzpTLzeIG
 n/lFEJktp97sfjdA0q+R8YJOWMraekcPo890IUAc0U94Bd1YEte0/wnCjW0NzwK7sel6
 uebKONjziO+f/5ZkJbsjqFtwrtWTNlGCApUnHfRxAajsEtQxHRh8yhejeHzL1txQyXP+
 coBvW1eSSB6jPydVmEnrVJFSUbMq058BsqgFvO1AJkgFYLF6qbP8qoiHZT78N1fDQIeB 3A== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tstv9sb4p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 22:59:23 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39HMxMjZ020335
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 22:59:22 GMT
Received: from [10.110.113.170] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Tue, 17 Oct
 2023 15:59:21 -0700
Message-ID: <e668ca8a-8842-4500-ac8d-ae3798238890@quicinc.com>
Date:   Tue, 17 Oct 2023 15:59:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4 2/3] dt-bindings: usb: snps,dwc3: Add
 runtime-suspend-on-usb-suspend property
Content-Language: en-US
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Roger Quadros <rogerq@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_kriskura@quicinc.com" <quic_kriskura@quicinc.com>
References: <cf0227c8-cd02-81b6-9e13-2e7fe6f505f2@kernel.org>
 <20230826015257.mbogiefsbz5474ft@synopsys.com>
 <afd4843b-427a-8535-78e2-f81879378371@linaro.org>
 <969988f6-f01f-0e31-6a98-7d02c5a3a4ad@quicinc.com>
 <20230830013739.srnh2uyhly66yvu2@synopsys.com>
 <d30a8d6a-236a-b6eb-76d7-115cc9950ce1@quicinc.com>
 <6f70a710-c409-23c0-890b-370ccd23e088@linaro.org>
 <20230831030134.z46fjwyr6edl3t7x@synopsys.com>
 <cea3472a-e9f7-39cb-419c-d042b3bf0682@linaro.org>
 <63c9ced1-6204-88e9-1dae-2979388bbc67@quicinc.com>
 <20231002185606.eumc37ezthov7uge@synopsys.com>
From:   Elson Serrao <quic_eserrao@quicinc.com>
In-Reply-To: <20231002185606.eumc37ezthov7uge@synopsys.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Gbb8RL7rkAk20j4csSo-X87zomLET5Xa
X-Proofpoint-ORIG-GUID: Gbb8RL7rkAk20j4csSo-X87zomLET5Xa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-17_06,2023-10-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=777 impostorscore=0 suspectscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 clxscore=1011
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310170194
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>> HI Thinh
>>
>> Apologies for the delayed response.
>> Series https://urldefense.com/v3/__https://patchwork.kernel.org/project/linux-usb/cover/1655094654-24052-1-git-send-email-quic_kriskura@quicinc.com/__;!!A4F2R9G_pg!YGlVy7No98zfEM-X5iWRhIUJ-gJEJn_gbTR4k12avzENV1TXf7cwJLZUezYzAU-rnHIbbqA1UWM0IE0R-t5SMMTJLwLZ$
>> from Krishna K, introduced a dt property 'wakeup-source' which indicates a
>> platforms capability to handle wakeup interrupts. Based on this property,
>> glue drivers can inform dwc3 core that the device is wakeup capable through
>> device_init_wakeup(). For example dwc3-qcom driver informs it like below as
>> per the implementation done in the above series
>>
>> 	wakeup_source = of_property_read_bool(dev->of_node, "wakeup-source");
>> 	device_init_wakeup(&pdev->dev, wakeup_source);
>> 	device_init_wakeup(&qcom->dwc3->dev, wakeup_source);
>>
>> The dwc3 core now can access this info through device_may_wakeup(dwc->dev)
>> while checking for bus suspend scenario to know whether the platform is
>> capable of detecting wakeup.
>>
>> Please let me know your thoughts on this approach.
>>
> 
> Hi Elson,
> 
> I think that it may not work for everyone. Some platforms may indicate
> wakeup-source but should only be applicable in selected scenarios.
> (e.g. Roger's platform was only intended to keep connect on suspend)
> 
> Also, how will you disable it for certain platforms? Probably will need
> to use compatible string then too.
> 

Hi Thinh

Thank you for your feedback. As an alternative approach, how about 
exposing an API from dwc3 core that glue drivers can call to enable 
runtime suspend during bus suspend feature ( i.e this API sets 
dwc->runtime_suspend_on_usb_suspend field).

Only the platforms that need this feature to be enabled, can call this 
API after the child (dwc3 core) probe.

Thanks
Elson
