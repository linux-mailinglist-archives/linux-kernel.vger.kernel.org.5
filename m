Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A24FC7EDA06
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 04:24:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344811AbjKPDYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 22:24:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343654AbjKPDYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 22:24:14 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C542D19B;
        Wed, 15 Nov 2023 19:24:11 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AG2p3Rq012166;
        Thu, 16 Nov 2023 03:23:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : from : subject : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=eDFGf4awORWbaYLq/EcD9RiLerGQD3fRnlZ8vXdy10g=;
 b=PI1Yal6cX16jVPsXCqTzxOoOxX+vJdgGYRC6k0VC7naCq4LLIlmr/eCU7L7Ug5Q70z2H
 jFTTIf7+UPif5RowReI1A42DqiP2h9BZKjW85soH/wnPP4bDassHZmpbByVu/J6bqLzv
 2waapKGBEYVXhdbh6K+eVVaXZ+acop1bSf0JCWxxEVyv+CIVEjsXceheVB3klzmiDxjW
 cQD309F5EI4UA7VedU+pRpyy/X7lY2GsPaTD5g/zKhVG7oBM3MwGGUGGRXc4wttjlAwV
 rw8ypOFQKxzaro5qSvRsTAGVoribQqU4i3T6om07IF54YJENvNh5r5WzFShqN4R/zZHy MQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ud6ecgg8v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Nov 2023 03:23:50 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AG3NnGu025759
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Nov 2023 03:23:49 GMT
Received: from [10.216.41.162] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Wed, 15 Nov
 2023 19:23:40 -0800
Message-ID: <06d0f06a-7a5a-44d1-0bad-27f56bfc1421@quicinc.com>
Date:   Thu, 16 Nov 2023 08:53:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
From:   Jishnu Prakash <quic_jprakash@quicinc.com>
Subject: Re: [PATCH 06/11] iio: adc: Add QCOM PMIC5 Gen3 ADC bindings
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linus.walleij@linaro.org>,
        <Jonathan.Cameron@huawei.com>, <sboyd@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <quic_subbaram@quicinc.com>,
        <quic_collinsd@quicinc.com>, <quic_kamalw@quicinc.com>,
        <marijn.suijten@somainline.org>,
        <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Luca Weiss <luca@z3ntu.xyz>, <linux-iio@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
CC:     <linux-arm-msm-owner@vger.kernel.org>
References: <20230708072835.3035398-1-quic_jprakash@quicinc.com>
 <20230708072835.3035398-7-quic_jprakash@quicinc.com>
 <bb225c12-f017-fac3-45f1-c828a10553e2@linaro.org>
 <99070bce-6188-82eb-c92c-cf7a323394e2@quicinc.com>
 <c4ef9cac-15ac-4c2c-9f9a-cb9e740e2900@linaro.org>
Content-Language: en-US
In-Reply-To: <c4ef9cac-15ac-4c2c-9f9a-cb9e740e2900@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Bjome4kBRawBaSie0Dt2rAgGW3KP7NRl
X-Proofpoint-ORIG-GUID: Bjome4kBRawBaSie0Dt2rAgGW3KP7NRl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-15_20,2023-11-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 adultscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311160025
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 10/23/2023 12:06 PM, Krzysztof Kozlowski wrote:
> On 23/10/2023 08:14, Jishnu Prakash wrote:
>> Hi Krzysztof,
>>
>> On 7/9/2023 10:53 PM, Krzysztof Kozlowski wrote:
>>
>>>>      reg:
>>>>        description: VADC base address in the SPMI PMIC register map
>>>> -    maxItems: 1
>>>> +    minItems: 1
>>> Why? This does not make any sense. With previous patches it looks like
>>> random set of changes.
>> The idea here is to convey that reg can have multiple values for ADC5
>> Gen3 as there can be more than one peripheral used for ADC, so there can
>> be multiple base addresses. I'll try to make this more clear in the next
>> patchset.
> You cannot remove constraints from an entry.


In this case, minItems: 1 will remain true for all other ADC devices 
documented here, but it will not be true for ADC5 Gen3, as this one can 
have multiple base addresses if more than one SDAM is used for ADC. I'll 
update this separately for each compatible, keeping it the same for the 
older ones, hope that should work.


>>>>    
>>>>      '#address-cells':
>>>>        const: 1
>>>> @@ -38,6 +39,12 @@ properties:
>>>>      '#size-cells':
>>>>        const: 0
>>>>    
>>>>    
>>>> +      qcom,adc-tm-type:
>>>> +        description: |
>>>> +            Indicates if ADC_TM monitoring is done on this channel.
>>> Description does not match property name.
>> You mean it sounds more like an enum which can take several values
>> rather than just a boolean? I can update it to "qcom,adc-tm" if that
>> looks better.
> The property name suggests this is type of monitoring. Property
> description says this will enable ADC_TM monitoring. These two do not match.
>
> Except that I wonder now whether this is a property of hardware at
> all... What is this monitoring? By the driver?


The property description is right, this property is used to indicate 
that one of the configurable channels on the ADC SDAMs will be used for 
ADC_TM functionality, for periodically monitoring this particular ADC 
channel . This is the exact same functionality as in the existing QCOM 
ADC_TM device, documented at 
devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml. I'll mention this 
too in the description.

It can be considered a property of the hardware as the monitoring is 
done by a sequence under PBS (Programmable Boot Sequence, can be 
considered firmware), which periodically gets the channel reading and 
checks it against upper/lower thresholds set by clients of this driver, 
for threshold violations.


> ...
>
>>>>        then:
>>>>          patternProperties:
>>>> @@ -299,7 +315,7 @@ examples:
>>>>                    label = "xo_therm";
>>>>                };
>>>>    

>>>> diff --git a/include/dt-bindings/iio/qcom,spmi-adc5-gen3-pm8550.h b/include/dt-bindings/iio/qcom,spmi-adc5-gen3-pm8550.h
>>>> new file mode 100644
>>>> index 000000000000..74e6e2f6f9ed
>>>> --- /dev/null
>>>> +++ b/include/dt-bindings/iio/qcom,spmi-adc5-gen3-pm8550.h
>>>> @@ -0,0 +1,48 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0-only */
>>> Dual license.
>> I think we do have an internal rule by which we do have to add these two
>> licenses....I'll check again and update them if required.
> Just to be clear: your internal rules are your internal affair. We
> expect here dual license.


I misunderstood what you meant earlier, I understand now that 
"GPL-2.0-only" is wrong, I'll update it.

Thanks,

Jishnu


> Best regards,
> Krzysztof
>
