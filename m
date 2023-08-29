Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73FF078BF14
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 09:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233344AbjH2HTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 03:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233723AbjH2HTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 03:19:44 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408071A2;
        Tue, 29 Aug 2023 00:19:41 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37T7F6IK024827;
        Tue, 29 Aug 2023 07:19:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=4w7kpdgnlYaaGjXLKNe/8m9BMUJO5ML9qmG64LjatJ0=;
 b=Ta19UGfQfS8wtfkZ3EwAvg+TzYLVUF19SBQxdFllxebV2m4oBPhF5rFovr/D9sDkdaGb
 ptMTMTNeEW+LYrkEeDRk0B8vzs9TV5DA8DUCeCtbW7sGPr9XOTm1dfRUc3bKIl9rqTWt
 C4vfRh30jUbH5W17OQBpiRHIbJXZmbCe2HC0UlDUsP8wX/CQAbVvcrm0v2p7+xw8lRD6
 ke9u6bpBjqlnsH5lJVywXuDf7c5gUyf7IG9uVnwinvtacWavXxLCcC5Cgy9OeOrX42PE
 cuwKLTCxIRnhqIQMrRQOVMIKs83lwkmxAd/WhbzxskI2Krzpa0qD4mAj6uZAvMVVlRvs iw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ss4wq0q3m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 07:19:11 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37T7JAtL016950
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 07:19:10 GMT
Received: from [10.110.46.69] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 29 Aug
 2023 00:19:09 -0700
Message-ID: <9d31db9c-4e58-767a-15c5-65f7c04bd989@quicinc.com>
Date:   Tue, 29 Aug 2023 00:19:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 11/28] dt-bindings: usb: dwc3: Add
 snps,num-hc-interrupters definition
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
CC:     <srinivas.kandagatla@linaro.org>, <mathias.nyman@intel.com>,
        <perex@perex.cz>, <broonie@kernel.org>, <lgirdwood@gmail.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <agross@kernel.org>,
        <Thinh.Nguyen@synopsys.com>, <bgoswami@quicinc.com>,
        <andersson@kernel.org>, <gregkh@linuxfoundation.org>,
        <tiwai@suse.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <quic_jackp@quicinc.com>, <quic_plai@quicinc.com>
References: <20230308235751.495-1-quic_wcheng@quicinc.com>
 <20230308235751.495-12-quic_wcheng@quicinc.com>
 <20230311134008.GA20831-robh@kernel.org>
 <f7bd1ae7-fc38-0f29-546b-9ea4a323f42f@quicinc.com>
 <73655c17-5246-2c96-d415-6a30497966c3@linaro.org>
From:   Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <73655c17-5246-2c96-d415-6a30497966c3@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: c83IzVJ5kDQVRlU9rDZtIokB30vYCC3k
X-Proofpoint-ORIG-GUID: c83IzVJ5kDQVRlU9rDZtIokB30vYCC3k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_03,2023-08-28_04,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015
 spamscore=0 malwarescore=0 priorityscore=1501 mlxscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308290061
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 8/28/2023 11:33 PM, Krzysztof Kozlowski wrote:
> On 29/08/2023 04:05, Wesley Cheng wrote:
>> Hi Rob,
>>
>> On 3/11/2023 5:40 AM, Rob Herring wrote:
>>> On Wed, Mar 08, 2023 at 03:57:34PM -0800, Wesley Cheng wrote:
>>>> Add a new definition for specifying how many XHCI secondary interrupters
>>>> can be allocated.  XHCI in general can potentially support up to 1024
>>>> interrupters, which some uses may want to limit depending on how many
>>>> users utilize the interrupters.
>>>>
>>>> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
>>>> ---
>>>>    .../devicetree/bindings/usb/snps,dwc3.yaml          | 13 +++++++++++++
>>>>    1 file changed, 13 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>>>> index be36956af53b..4e2417191f93 100644
>>>> --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>>>> +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>>>> @@ -359,6 +359,19 @@ properties:
>>>>        items:
>>>>          enum: [1, 4, 8, 16, 32, 64, 128, 256]
>>>>    
>>>> +  snps,num-hc-interrupters:
>>>> +    description:
>>>> +      Defines the maximum number of XHCI host controller interrupters that can
>>>> +      be supported.  The XHCI host controller has support to allocate multiple
>>>> +      event rings, which can be assigned to different clients/users.  The DWC3
>>>> +      controller has a maximum of 8 interrupters.  If this is not defined then
>>>> +      the value will be defaulted to 1.  This parameter is used only when
>>>> +      operating in host mode.
>>>
>>> Is this an XHCI or DWC3 feature? The former should be added to the XHCI
>>> binding.
>>>
>>
>> Sorry for the late response...message got routed to a folder I don't
>> frequently check...
> 
> That is quite unfortunate, to put our feedback somewhere deep and then
> send new versions of patches thinking there is apparently no feedback.
> Fix your email process, so our reviews are not ignored. If they are, we
> obviously should ignore your patches.
> 

Spent some time fixing filters around, so should be addressed now.

>>
>> This is a XHCI feature, but the DWC3 design is built in a way that DWC3
>> host initializes the XHCI device and populates the properties associated
>> to XHCI dev.
> 
> You speak about driver now, not bindings. If driver has limitations,
> change it. Not really problem of bindings.
> 

Its the limitation of the HW.  Depending on how the SNPS DWC3 controller 
was implemented the vendor it can support less than the value mentioned 
in the Synopsys databook.

Thanks
Wesley Cheng
