Return-Path: <linux-kernel+bounces-68540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 641AE857BF6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 12:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D2E828341C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1815F77F39;
	Fri, 16 Feb 2024 11:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="h5/bJFDb"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6322F12E7E;
	Fri, 16 Feb 2024 11:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708083893; cv=none; b=n25/02p6bwrMTH7DMXtFygBxchiIy812HaP4Y+f6rTXMfOGVo8T5Kc0GOTRheJH3b5uJmotTzFYNMqJBc/kHUoUKsz8fWOAURgmQqYp4bK3EyVUea71QnZJc59rgisVsgJ/F5ff1zjnec66spHS+rCqcNqdpysk4z5L54+ThIfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708083893; c=relaxed/simple;
	bh=xg3H3S3ln6QEVC/6fQKGUWqyLA6D0eWw7f5BVs1Es5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=W4IYfx1QWWW2P43HA4s8xfUlWHNT837BLfPc+cNimA0MONGLqpRTqZAMpl7ZKzZ3jzlUdX9pd5JeUAOQWnkG3QQ8xL4Jb+cM0clEEBxWUQ5wXkx4vf8NDKJn1JmEZU0CT7Mb6FoBvckXDyJxNCJrKX9/bJZGQKvIu6oXYYtfM94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=h5/bJFDb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41GBY5lt010430;
	Fri, 16 Feb 2024 11:44:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=GrTWn4995ZuRctWZ1kMoEso1m63FAMtxfL+s1KsIQYk=; b=h5
	/bJFDb4ke/ktcaez5sz0bn+sz3g8p0P32U4MhvOOOfIWQ0X37GbguZbuVowehyBI
	Xks5xVhAxU6sNIzqb9dNssGRGTEJ/JuR9KTVTw3+YUFu+RSaUOPAnVFw4PYHT1Z5
	1yZnsgG4Mh/q5I/Y5Yzz7OXTQHqPUMs8oWDt5j9IIepnbPYwv9sU4Ugh6kUOzYvU
	t3kHI4f9OAV17q2D/19/TE0D4vDkf3F/aaZkzr6F5B/k3ac3bkasx88oPFkB6zw1
	UDb3SZoFqPxM5vcLC6POQ7LuVJq0zxUOY6YILeqbpXtCLlRxrpcjqvtxdRMOtW/y
	hrEGfbX1czkAamTYF75A==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w9fkfbfc6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 11:44:27 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41GBiQYp010439
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 11:44:26 GMT
Received: from [10.218.16.59] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 16 Feb
 2024 03:44:14 -0800
Message-ID: <d2f2cb91-983f-48e4-b53a-8af2cd87f3d2@quicinc.com>
Date: Fri, 16 Feb 2024 17:14:11 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] dt-bindings: iio: adc: Add support for QCOM PMIC5
 Gen3 ADC
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, <jic23@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <lee@kernel.org>,
        <andriy.shevchenko@linux.intel.com>, <daniel.lezcano@linaro.org>,
        <dmitry.baryshkov@linaro.org>
CC: <lars@metafoo.de>, <luca@z3ntu.xyz>, <marijn.suijten@somainline.org>,
        <agross@kernel.org>, <sboyd@kernel.org>, <rafael@kernel.org>,
        <rui.zhang@intel.com>, <lukasz.luba@arm.com>,
        <linus.walleij@linaro.org>, <quic_subbaram@quicinc.com>,
        <quic_collinsd@quicinc.com>, <quic_amelende@quicinc.com>,
        <quic_kamalw@quicinc.com>, <kernel@quicinc.com>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-arm-msm-owner@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <cros-qcom-dts-watchers@chromium.org>
References: <20231231171237.3322376-1-quic_jprakash@quicinc.com>
 <20231231171237.3322376-3-quic_jprakash@quicinc.com>
 <3f812ffa-ec33-448e-b72a-ce698618a8c1@linaro.org>
From: Jishnu Prakash <quic_jprakash@quicinc.com>
In-Reply-To: <3f812ffa-ec33-448e-b72a-ce698618a8c1@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ofKoIyoRhH9_CAwxDddvjHrndBr679Uc
X-Proofpoint-GUID: ofKoIyoRhH9_CAwxDddvjHrndBr679Uc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_09,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 suspectscore=0 mlxscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402160094

Hi Krzysztof,

(Resending this mail for tracking on mailing lists, as it got rejected 
from lists the first time due to HTML)

On 1/4/2024 1:48 PM, Krzysztof Kozlowski wrote:
> On 31/12/2023 18:12, Jishnu Prakash wrote:
>> For the PMIC5-Gen3 type PMICs, ADC peripheral is present in HW for the
>> following PMICs: PMK8550, PM8550, PM8550B and PM8550VX PMICs.
>>
>> It is similar to PMIC5-Gen2, with SW communication to ADCs on all PMICs
>> going through PBS(Programmable Boot Sequence) firmware through a single
>> register interface. This interface is implemented on an SDAM (Shared
>> Direct Access Memory) peripheral on the master PMIC PMK8550 rather
>> than a dedicated ADC peripheral.
>>
>> Add documentation for PMIC5 Gen3 ADC and macro definitions for ADC
>> channels and virtual channels (combination of ADC channel number and
>> PMIC SID number) per PMIC, to be used by clients of this device.
>>
>> Changes since v2:
>> - Moved ADC5 Gen3 documentation into a separate new file.
> 
> Changelog goes under ---.
> 
> Why did you do this? What is the rationale? Sorry, this patchset goes
> nowhere.

I'll elaborate this more in the next patchset. There are two main 
reasons for adding this documentation in a new file:

1.This device is not exactly like the existing QCOM VADC drivers as it 
now combines VADC functionality (reading ADC channel on client request) 
with ADC_TM functionality (thermal threshold monitoring).

2.Adding this device's bindings in the existing qcom,spmi-vadc.yaml file 
is not possible as it would require updating some of the existing 
top-level constraints. (for the older devices in that file, "reg" and 
"interrupts" can have at most one item, while this device can have more 
than one item under these properties.)


> 
>>
>> Changes since v1:
>> - Updated properties separately for all compatibles to clarify usage
>>    of new properties and updates in usage of old properties for ADC5 Gen3.
>> - Avoided updating 'adc7' name to 'adc5 gen2' and just left a comment
>>    mentioning this convention.
>> - Used predefined channel IDs in individual PMIC channel definitions
>>    instead of numeric IDs.
>> - Addressed other comments from reviewers.
>>

>> +          per PMIC in the PMIC-specific files in include/dt-bindings/iio/adc.
>> +
>> +      label:
>> +        $ref: /schemas/types.yaml#/definitions/string
> 
> Why do you need it in the first place? Don't you miss some $ref?

This is just meant to show the ADC channel name in DT for our reference. 
I'll check if I can use adc.yaml, which includes this property already, 
as a reference in this case.

> 
>> +        description: |
> 
> Do not need '|' unless you need to preserve formatting. Applies everywhere.
> 
> 
> 
>> +            ADC input of the platform as seen in the schematics.
>> +            For thermistor inputs connected to generic AMUX or GPIO inputs
>> +            these can vary across platform for the same pins. Hence select
>> +            the platform schematics name for this channel.
>> +


>> +
>> +      qcom,adc-tm:
>> +        description: |
>> +            Indicates if ADC_TM monitoring is done on this channel.
>> +            Defined for compatible property "qcom,spmi-adc5-gen3".
>> +            This is the same functionality as in the existing QCOM ADC_TM
>> +            device, documented at devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml.
>> +        type: boolean
>> +
> 
> Why do you duplicate entire vadc file? Why it cannot be part of that
> file? Oh wait, it was in v2.
> 
> You now duplicated a lot of property definitions without clear reason.
> If this is intention, then you need to put them in common schema.

Many of the properties used for earlier QCOM VADC devices will be used 
for this device too.....do you mean I can add a new schema file (named 
something like qcom,vadc.yaml) and move common properties into it (like 
qcom,hw-settle-time, qcom,decimation, etc) from this file and 
qcom,spmi-vadc.yaml?


Dmitry suggests doing it in a separate patch, I'll follow his suggestion 
if there's no issue.


>> diff --git a/include/dt-bindings/iio/adc/qcom,spmi-adc7-smb139x.h b/include/dt-bindings/iio/adc/qcom,spmi-adc7-smb139x.h
>> index c0680d1285cf..750a526af2c1 100644
>> --- a/include/dt-bindings/iio/adc/qcom,spmi-adc7-smb139x.h
>> +++ b/include/dt-bindings/iio/adc/qcom,spmi-adc7-smb139x.h
>> @@ -6,7 +6,7 @@
>>   #ifndef _DT_BINDINGS_QCOM_SPMI_VADC_SMB139X_H
>>   #define _DT_BINDINGS_QCOM_SPMI_VADC_SMB139X_H
>>   
>> -#include <dt-bindings/iio/qcom,spmi-vadc.h>
>> +#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
> 
> ? How is it related?

This should have gone into patch 1, I'll fix it in the next patch series.

I'll address all your other comments in the next patchset.

Thanks,

Jishnu

> 
>>   
>>   #define SMB139x_1_ADC7_SMB_TEMP			(SMB139x_1_SID << 8 | ADC7_SMB_TEMP)
>>   #define SMB139x_1_ADC7_ICHG_SMB			(SMB139x_1_SID << 8 | ADC7_ICHG_SMB)
>> diff --git a/include/dt-bindings/iio/adc/qcom,spmi-vadc.h b/include/dt-bindings/iio/adc/qcom,spmi-vadc.h
>> index ef07ecd4d585..cfe653d945a4 100644
>> --- a/include/dt-bindings/iio/adc/qcom,spmi-vadc.h
>> +++ b/include/dt-bindings/iio/adc/qcom,spmi-vadc.h
>> @@ -1,6 +1,8 @@
>>   /* SPDX-License-Identifier: GPL-2.0 */
>>   /*
>>    * Copyright (c) 2012-2014,2018,2020 The Linux Foundation. All rights reserved.
>> + *
> 
> Drop stray blank line
> 
> Best regards,
> Krzysztof
> 

