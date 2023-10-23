Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7737D2A0A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 08:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233313AbjJWGN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 02:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233322AbjJWGNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 02:13:55 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ECB9D65;
        Sun, 22 Oct 2023 23:13:53 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39N6DTKm008903;
        Mon, 23 Oct 2023 06:13:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=XFUTI4lp00DPSq7wi9wUoTFjnu048dYJkFm0nrQKYCE=;
 b=S1MBkPNrGFwlq2tSXpl6SLUaDNc7JKyMnfDdg94nIgaIxEYujQkv9N4ShNU9Vr6y5R6Y
 LjAMNsG7IzySMYAW5ONzTOKn86ei/IHuUmdsfylibzDKIN99p7P+xnKevNcGERDv9krc
 C8sYnTHBivievszMuoMautrCJKWB8/Me94kV634NDnwNbym88otIqsmqNw46ireOiTVb
 1AACDSP2lTrDRxrCMNr78LbYSWEZH1D8AsGXIVnz7MIwHb51KX6hch5v88cFAgegKGrD
 RDlVN3UJeMw/fXS1Pb0yYwBI+YMiqijxEglxZsbG49g/B1V47i7Y7mEJCkuKE8FEwQ3+ tA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tv7dq3jxf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 06:13:29 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39N6DSfY014103
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 06:13:28 GMT
Received: from [10.216.48.174] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Sun, 22 Oct
 2023 23:13:19 -0700
Message-ID: <4fe37ae7-1d72-5404-a9f3-ec4b1b51358a@quicinc.com>
Date:   Mon, 23 Oct 2023 11:43:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 06/11] iio: adc: Add QCOM PMIC5 Gen3 ADC bindings
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>
CC:     <agross@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linus.walleij@linaro.org>,
        <Jonathan.Cameron@huawei.com>, <sboyd@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <quic_subbaram@quicinc.com>,
        <quic_collinsd@quicinc.com>, <quic_kamalw@quicinc.com>,
        <marijn.suijten@somainline.org>,
        <andriy.shevchenko@linux.intel.com>,
        <krzysztof.kozlowski@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Luca Weiss <luca@z3ntu.xyz>, <linux-iio@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-arm-msm-owner@vger.kernel.org>
References: <20230708072835.3035398-1-quic_jprakash@quicinc.com>
 <20230708072835.3035398-7-quic_jprakash@quicinc.com>
 <20230708161259.7af17fa9@jic23-huawei>
From:   Jishnu Prakash <quic_jprakash@quicinc.com>
In-Reply-To: <20230708161259.7af17fa9@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Z1KNR4PDochP21ueopLq3W3I_DSTjFUX
X-Proofpoint-GUID: Z1KNR4PDochP21ueopLq3W3I_DSTjFUX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-23_03,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 mlxscore=0 clxscore=1015 adultscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

Hi Jonathan,

On 7/8/2023 8:42 PM, Jonathan Cameron wrote:
> On Sat, 8 Jul 2023 12:58:30 +0530
> Jishnu Prakash <quic_jprakash@quicinc.com> wrote:
>
>> For the PMIC5-Gen3 type PMICs, ADC peripheral is present in HW for the
>> following PMICs: PMK8550, PM8550, PM8550B and PM8550VX PMICs.
>> It is similar to PMIC5-Gen2, with SW communication to ADCs on all PMICs
>>   
>>     reg:
>>       description: VADC base address in the SPMI PMIC register map
>> -    maxItems: 1
>> +    minItems: 1
> ?

The idea here is to convey that reg can have multiple values for ADC5 
Gen3 as there can be more than one peripheral used for ADC, so there can 
be multiple base addresses. I'll try to make this more clear in the next 
patchset.


>
>>   
>>     '#address-cells':
>>       const: 1
>> @@ -38,6 +39,12 @@ properties:
>>     '#size-cells':
>>       const: 0
>>   
>> +  "#thermal-sensor-cells":
>> +    const: 1
>> +    description:
>> +      Number of cells required to uniquely identify the thermal sensors. Since
>> +      we have multiple sensors this is set to 1.
>> +
> Defined only for the new gen3?  If so make make it false for the other devices.


Yes, will do that in the next patchset.

>
>>     '#io-channel-cells':
>>       const: 1
>>   
>> @@ -71,8 +78,8 @@ patternProperties:
>>           description: |
>>             ADC channel number.
>>   
>> +      qcom,adc-tm-type:
>> +        description: |
>> +            Indicates if ADC_TM monitoring is done on this channel.
>> +            Defined for compatible property "qcom,spmi-adc5-gen3".
>> +        type: boolean
> Enforce that in the binding, not via a comment. Once the binding
> performs that check (set it to false for non matching compatibles) then
> there is no need to also mention it in text.

Will do that in the next patchset.


>
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
> Side note - it's fine to have a single element enum, so you could
> use that option to reduce churn in this set...


I think we can remove this and instead specify properties explicitly for 
qcom,spmi-adc5-gen3 too separately in the next patchset.


>
>>   
>>       then:
>>         patternProperties:
>> @@ -299,7 +315,7 @@ examples:
>>                   label = "xo_therm";
>>               };
>>   
>> -            channel@47 {
>> +            channel@147 {
> ?  If that's a valid change, then it looks like a separate fix.


I think I can avoid this for now, although it would be needed if this 
channel number was the virtual channel number made by combining PMIC SID 
and actual channel number....maybe we can do it in a separate fix.


>
>>                   reg = <PM8350_ADC5_GEN2_AMUX_THM4_100K_PU(1)>;
>>                   qcom,ratiometric;
>>                   qcom,hw-settle-time = <200>;
>> @@ -307,3 +323,80 @@ examples:
>>               };
>>           };
>>       };
>> +
>> +#ifndef PM8550_SID
>> +#define PM8550_SID		1
>> +#endif
>> +
>> +/* ADC channels for PM8550_ADC for PMIC5 Gen3 */
>> +#define PM8550_ADC5_GEN3_OFFSET_REF			(PM8550_SID << 8 | 0x00)
> can we do the naming for the 0x00 as per Dmitry's set? That is get them from
> qcom,spmi-vadc.h
>
> https://patchwork.kernel.org/project/linux-iio/patch/20230707123027.1510723-2-dmitry.baryshkov@linaro.org/

Yes, will do that in the next patchset.

Thanks,

Jishnu


