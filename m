Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1707D2A1D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 08:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233328AbjJWGPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 02:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjJWGPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 02:15:07 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10EF3E8;
        Sun, 22 Oct 2023 23:15:05 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39N5hEnn016863;
        Mon, 23 Oct 2023 06:14:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=jXJGhutHq00IXvsWcIL8ucKPpdhbQG4Mvr41Nss6EE4=;
 b=Fb4QnLDhx6F8BcPjHDiQEr1b6eKwAuwRZHIHOQO4BHfx86xIDQjnMXgzhkJWcihu6Wgz
 EdknuDilaCulpQeu8GtIUA5cZYzuORo6DxJk+u3TSzbnbt8wLmCWZqHJUgQ0J86v5ksC
 ccWVTsEgVF41tigcgsRv9/xeKbTKT3zlGU3Ryln6IbezYpVq7ry/htJJrp+OsDczk3WP
 yOiY58vcyAGqwT5k1KLBdLVovCFsinWpYujbLwxIndoAfcgK7ye8+uu/rRRNS7hAPzBJ
 6YnwXH7Lim6kmIAY7rWr0V0oB607PWh7vvuSrm49bqSETT80+VfEce4FJSCYMUEDi7fd YA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tv6873824-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 06:14:44 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39N6EhUG015824
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 06:14:43 GMT
Received: from [10.216.48.174] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Sun, 22 Oct
 2023 23:14:34 -0700
Message-ID: <99070bce-6188-82eb-c92c-cf7a323394e2@quicinc.com>
Date:   Mon, 23 Oct 2023 11:44:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 06/11] iio: adc: Add QCOM PMIC5 Gen3 ADC bindings
Content-Language: en-US
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
From:   Jishnu Prakash <quic_jprakash@quicinc.com>
In-Reply-To: <bb225c12-f017-fac3-45f1-c828a10553e2@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Ozeg4xV4O683hfGq6uvZ6IMGI4SnrRU-
X-Proofpoint-ORIG-GUID: Ozeg4xV4O683hfGq6uvZ6IMGI4SnrRU-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-23_03,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 impostorscore=0
 spamscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310230054
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 7/9/2023 10:53 PM, Krzysztof Kozlowski wrote:
> On 08/07/2023 09:28, Jishnu Prakash wrote:
>> For the PMIC5-Gen3 type PMICs, ADC peripheral is present in HW for the
>> following PMICs: PMK8550, PM8550, PM8550B and PM8550VX PMICs.
>> It is similar to PMIC5-Gen2, with SW communication to ADCs on all PMICs
>> going through PBS firmware through a single register interface. This
>> interface is implemented on an SDAM peripheral on the master PMIC PMK8550
>> rather than a dedicated ADC peripheral.
>>
>> Signed-off-by: Jishnu Prakash <quic_jprakash@quicinc.com>
>> ---
>>   properties:
>>     compatible:
>> @@ -27,10 +27,11 @@ properties:
>>             - qcom,spmi-adc5
>>             - qcom,spmi-adc-rev2
>>             - qcom,spmi-adc5-gen2
>> +          - qcom,spmi-adc5-gen3
>
> This could be ordered...


Yes, will do that in the next patchset.


>>   
>>     reg:
>>       description: VADC base address in the SPMI PMIC register map
>> -    maxItems: 1
>> +    minItems: 1
> Why? This does not make any sense. With previous patches it looks like
> random set of changes.


The idea here is to convey that reg can have multiple values for ADC5 
Gen3 as there can be more than one peripheral used for ADC, so there can 
be multiple base addresses. I'll try to make this more clear in the next 
patchset.


>
>
>>   
>>     '#address-cells':
>>       const: 1
>> @@ -38,6 +39,12 @@ properties:
>>     '#size-cells':
>>       const: 0
>>   
>>   
>> +      qcom,adc-tm-type:
>> +        description: |
>> +            Indicates if ADC_TM monitoring is done on this channel.
> Description does not match property name.


You mean it sounds more like an enum which can take several values 
rather than just a boolean? I can update it to "qcom,adc-tm" if that 
looks better.


>
>> +            Defined for compatible property "qcom,spmi-adc5-gen3".
> Then you need if:then:.


Yes, will update this explicitly for ADC5 Gen3 in the next patchset.


>
>> +        type: boolean
>> +
>>       required:
>>         - reg
>>   
>> @@ -213,7 +227,9 @@ allOf:
>>         properties:
>>           compatible:
>>             contains:
>> -            const: qcom,spmi-adc5-gen2
>> +            enum:
>> +              - qcom,spmi-adc5-gen2
>> +              - qcom,spmi-adc5-gen3
>>   
>>       then:
>>         patternProperties:
>> @@ -299,7 +315,7 @@ examples:
>>                   label = "xo_therm";
>>               };
>>   
>> -            channel@47 {
>> +            channel@147 {
> Why?


It would be needed if this channel number was supposed to be the virtual 
channel number made by combining PMIC SID and actual channel 
number....but I could drop it for now and do it in a separate fix as 
Jonathan suggested.


>
>>                   reg = <PM8350_ADC5_GEN2_AMUX_THM4_100K_PU(1)>;
>>                   qcom,ratiometric;
>>                   qcom,hw-settle-time = <200>;
>> @@ -307,3 +323,80 @@ examples:
>>               };
>>           };
>>       };
>> +
>> +  - |
>> +    #include <dt-bindings/iio/qcom,spmi-adc5-gen3-pmk8550.h>
>> +    #include <dt-bindings/iio/qcom,spmi-adc5-gen3-pm8550.h>
>> +    #include <dt-bindings/iio/qcom,spmi-adc5-gen3-pm8550b.h>
>> +    #include <dt-bindings/iio/qcom,spmi-adc5-gen3-pm8550vx.h>
>> +
>> +    pmic {
>> +      #address-cells = <1>;
>> +      #size-cells = <0>;
>> +
>> +      /* VADC node */
>> +      pmk8550_vadc: vadc@9000 {
>> +        compatible = "qcom,spmi-adc5-gen3";
> Don't add new examples which differ only in compatible.


This example does have differences unique to ADC5 Gen3 such as use of 
"#thermal-sensor-cells" and "qcom,adc-tm-type" properties....to make it 
clearer, I'll delete some of the excess nodes which don't highlight 
these differences.


>
>
>> diff --git a/include/dt-bindings/iio/qcom,spmi-adc5-gen3-pm8550.h b/include/dt-bindings/iio/qcom,spmi-adc5-gen3-pm8550.h
>> new file mode 100644
>> index 000000000000..74e6e2f6f9ed
>> --- /dev/null
>> +++ b/include/dt-bindings/iio/qcom,spmi-adc5-gen3-pm8550.h
>> @@ -0,0 +1,48 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
> Dual license.


I think we do have an internal rule by which we do have to add these two 
licenses....I'll check again and update them if required.

Thanks,

Jishnu

>
>
>
> Best regards,
> Krzysztof
>
