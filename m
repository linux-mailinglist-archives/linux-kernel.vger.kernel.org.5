Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADCB37D29E4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 08:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjJWGGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 02:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjJWGGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 02:06:38 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA1B1A4;
        Sun, 22 Oct 2023 23:06:32 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39N4jJhh028372;
        Mon, 23 Oct 2023 06:06:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=wzCZp8sDLpOo0fEqh1ZFa1u9GorWd7JSSdgFS1xYavQ=;
 b=mlvsnUZbPJuAzLMTcPlIW81G5G8A15m1fsk/kOTDivkE11f6G7PwlxiigbdVHt3fDjEX
 ++TgaRVl4zhroHgW9PRg8pmULYCb/zqjdwSo2Yy8++/aMk+c3L7p83cYaC1RXnVCDOkg
 Vaz7VMeCphKDXik0FeQ9IhD1FpPQJGMshqAaVHLvBP49csVEzyPPXeSjiAJl3qjGv06+
 4NRacgTdfJJW3Mia8dHamAnpAmdN4bmD5P8mEB5eB7RSk5xZHwdm0iDbdxv2DijGM2s8
 w5QRMZV27LhInpxaUAn/eqG8FmCsejR21B099Yfwigt/I1nEJ93OsQOeqXIhqZEYXR82 yg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tv5ndu8v0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 06:06:00 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39N65xPG009185
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 06:05:59 GMT
Received: from [10.216.48.174] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Sun, 22 Oct
 2023 23:05:48 -0700
Message-ID: <0401d8fc-1162-ea60-bd91-ad18afece344@quicinc.com>
Date:   Mon, 23 Oct 2023 11:35:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 01/11] iio: adc: Update bindings for ADC7 name used on
 QCOM PMICs
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>
CC:     <agross@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linus.walleij@linaro.org>,
        <Jonathan.Cameron@huawei.com>, <sboyd@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <quic_subbaram@quicinc.com>,
        <quic_collinsd@quicinc.com>, <quic_kamalw@quicinc.com>,
        <quic_jestar@quicinc.com>, <marijn.suijten@somainline.org>,
        <andriy.shevchenko@linux.intel.com>,
        <krzysztof.kozlowski@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Daniel Lezcano" <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        "Zhang Rui" <rui.zhang@intel.com>, Luca Weiss <luca@z3ntu.xyz>,
        <linux-iio@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-arm-msm-owner@vger.kernel.org>
References: <20230708072835.3035398-1-quic_jprakash@quicinc.com>
 <20230708072835.3035398-2-quic_jprakash@quicinc.com>
 <20230708155844.31c55ca0@jic23-huawei>
From:   Jishnu Prakash <quic_jprakash@quicinc.com>
In-Reply-To: <20230708155844.31c55ca0@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: k8YO0WtFsvkr1CVvDUZB5KG2TsDfnNus
X-Proofpoint-ORIG-GUID: k8YO0WtFsvkr1CVvDUZB5KG2TsDfnNus
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-23_03,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 impostorscore=0 mlxscore=0 phishscore=0 priorityscore=1501
 clxscore=1011 suspectscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310230053
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

Sorry for the late reply, I could not get back earlier as I got occupied 
with other work till now. I have addressed your comments inline.

On 7/8/2023 8:28 PM, Jonathan Cameron wrote:
> On Sat, 8 Jul 2023 12:58:25 +0530
> Jishnu Prakash <quic_jprakash@quicinc.com> wrote:
>
>> The name used initially for this version of Qualcomm Technologies, Inc.
>> PMIC ADC was ADC7, following the convention of calling the PMIC generation
>> PMIC7. However, the names were later amended internally to ADC5 Gen2 and
>> PMIC5 Gen2. In addition, the latest PMIC generation now is known as
>> PMIC5 Gen3 with ADC5 Gen3 supported on it. With this addition, it makes more
>> sense to correct the name for this version of ADCs to ADC5 Gen2 from ADC7.
>> Since this affects ADC devices across some PMICs, update the names accordingly.
>>
>> In order to avoid breaking the existing implementations of ADC7, add
>> support for ADC5 Gen2 first now and remove the ADC7 support in a later
>> patch.
>>
>> Signed-off-by: Jishnu Prakash <quic_jprakash@quicinc.com>
> Hi Jishnu.
>
> Whilst I can appreciate why you've picked this particular approach to
> deal with the renames I'm not sure it's the smoothest path - or the
> easiest to review.
>
> If doing a single patch for the complete rename was too much, perhaps
> doing one header (or if it makes sense set of headers)
> at a time would be easier to read?  With a final patch doing the compatible
> addition.  Maybe let's see what other reviewers think though.


I don't completely understand what you mean here - but first let me 
briefly recap what I was trying to do here.

In patches 1-5 of this series, I intended to update all existing support 
for ADC7 by renaming it to ADC5 Gen2 to match the correct name used 
internally. In addition, since I am adding support for ADC5 Gen3 in 
patches 6 and 7, I thought it would make sense to rename this older 
peripheral, to make it more obvious to everyone that this version lies 
between ADC5 and ADC5 Gen3.

The patches were organized like  this:

Patch 1 - Update documentation to add gen2 compatible and update 
examples(without removing older compatible). Add new binding files 
equivalent to existing ADC7 files, just with macros and file names 
updated to use "adc5_gen2" instead of "adc7"

Patch 2 - Update driver files to replace usage of "adc7" with "adc5 
gen2", adding new compatible for adc5 gen2 without removing exsiting one 
for adc7.

Patch 3 - Update compatible, macros and binding files included in all 
devicetree files, based on the earlier two changes.

Patch 4 - Delete all instances of adc7 compatible from documentation 
files. Delete all older binding files

Patch 5 - Delete the adc7 compatible from the driver


Based on the comments I got, I understand I cannot proceed as such with 
patches 4 and 5, I can amend/drop them. But to get back to your above 
point about my overall approach, how exactly would you like me to 
structure my patch series?

Should I make one big patch for documentation, bindings, driver and 
devicetree changes where I update the naming and deprecate adc7 usage? 
This may be straightforward but also hard to review.


Or a patch series like this:

One patch to update documentation

One patch to update the bindings (headers) (Or one patch per header file?)

One patch to update driver file (adding new compatible and comment to 
deprecate old one)

One patch to update all devicetree files (or separate patches?)

Please let me know what you think.

> A few other comments inline,
>
> Jonathan
>
>
>>   
>>   properties:
>> @@ -27,6 +27,7 @@ properties:
>>             - qcom,spmi-adc5
>>             - qcom,spmi-adc-rev2
>>             - qcom,spmi-adc7
>> +          - qcom,spmi-adc5-gen2
> Alphabetical order (roughly given currently list). So I'd stick
> this after qcom,spmi-adc5


Will reorder them in the next patchset.


>>   
>>     reg:
>>       description: VADC base address in the SPMI PMIC register map
>> @@ -71,7 +72,7 @@ patternProperties:
>>           description: |
>>             ADC channel number.
>>             See include/dt-bindings/iio/qcom,spmi-vadc.h
>> -          For PMIC7 ADC, the channel numbers are specified separately per PMIC
>> +          For PMIC5 Gen2 ADC, the channel numbers are specified separately per PMIC
>>             in the PMIC-specific files in include/dt-bindings/iio/.
>>   
>>         label:
>> @@ -114,7 +115,7 @@ patternProperties:
>>                 channel calibration. If property is not found, channel will be
>>                 calibrated with 0.625V and 1.25V reference channels, also
>>                 known as absolute calibration.
>> -            - For compatible property "qcom,spmi-adc5", "qcom,spmi-adc7" and
>> +            - For compatible property "qcom,spmi-adc5", "qcom,spmi-adc5-gen2" and
>>                 "qcom,spmi-adc-rev2", if this property is specified VADC will use
>>                 the VDD reference (1.875V) and GND for channel calibration. If
>>                 property is not found, channel will be calibrated with 0V and 1.25V
>> @@ -213,7 +214,9 @@ allOf:
>>         properties:
>>           compatible:
>>             contains:
>> -            const: qcom,spmi-adc7
>> +            enum :
>> +                - qcom,spmi-adc7
> There is a deprecated marking for dt-bindings. Might be good to use it here.


Thanks for your suggestion, I'll do this in the next patchset.


>
>> +                - qcom,spmi-adc5-gen2
>>   
>>       then:

Thanks,

Jishnu

>>
