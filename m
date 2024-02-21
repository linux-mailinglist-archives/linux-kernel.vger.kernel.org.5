Return-Path: <linux-kernel+bounces-74086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C26A485CFCC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 06:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 210B3B22E86
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 05:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64BB53A1CB;
	Wed, 21 Feb 2024 05:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="csqpwUFz"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD85E39ADD;
	Wed, 21 Feb 2024 05:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708493810; cv=none; b=G3EfME8hhV2k5TRmA4vV6Az8YJS3twJkuXQNut6gXle43zaEmt2i9dvjWJxI762GFQq9xDqY/fgm1JwmzEPXguszxgJXMV8WupWRZOmLgpXO+877xGdBw6JhVH3jALjDpfHwYOlFurbmNuS2/TuNRJCCkMgM7AGv0vng6UryyWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708493810; c=relaxed/simple;
	bh=h/VjfafKWnZdt701kQi9hEaeMSuYAmya+J9erv+EEuM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IQ5U1Z3X/g7VApyNW81FVq+3M86IBWYaC1KUglVnbvUduzuAr9bh8w1+pjL50MXHsgI1w6JRsBX0MPUVUE2SSRcSplMkZbc8YkwJN0U2616I2c14YGXyd9Gvqv4iRuWhzCkgMDue1FzZzaJFAU2j/VCf5+anfHLPqUW5dRCaUTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=csqpwUFz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41L1jdSL030713;
	Wed, 21 Feb 2024 05:36:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=S5n/WpV8JcN0mx2fE3uU/d+OZrGuwRrR1d3N//9CiFA=; b=cs
	qpwUFzcl29oiOj+cr6STCjwPDDiknXqXp+BiwsKat9U3dEcTGj5KLCoLVseOafAy
	1W1jatIWVkw+PUhTbQOimI693MkpC89cxcVvDZUWN3NUq4D0Zb9gkgO6Xer4m8EI
	ALJuHSVKkF78jjz7xUrvWtDk7RWS9150zMExJmc3AfsSKDIxWNc3qpUFYKl3RiYm
	RtnWvktckBz9gHcfsGNN0fEe9lGCTlrxeRSKJ5jlpbeO3WKa7rPKO0rBJB59uIpx
	ax7IycEeJcNWjVCDKPkuqRjrAEwpoytBSQ+xePQTKMl31kXHH+oBzkDj595/zVQF
	yXBXHBIjbJxMSF/xm4pQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wd21s924s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 05:36:23 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41L5aMKl003639
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 05:36:22 GMT
Received: from [10.218.16.59] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 20 Feb
 2024 21:36:11 -0800
Message-ID: <0b9e807d-e0ca-411c-9a2b-3d804bdf168c@quicinc.com>
Date: Wed, 21 Feb 2024 11:06:07 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] dt-bindings: iio: adc: Add support for QCOM PMIC5
 Gen3 ADC
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
 <13f2b558-a50d-44d3-85de-38e230212732@quicinc.com>
 <f52b2d5e-b2b4-48ae-a6a6-fc00c89662d2@linaro.org>
Content-Language: en-US
From: Jishnu Prakash <quic_jprakash@quicinc.com>
In-Reply-To: <f52b2d5e-b2b4-48ae-a6a6-fc00c89662d2@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: fGcC1wH5IHx3LPFKis3LhLj_W6R4ZpCQ
X-Proofpoint-GUID: fGcC1wH5IHx3LPFKis3LhLj_W6R4ZpCQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 mlxscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2402210039

Hi Krzysztof,

On 2/17/2024 7:43 PM, Krzysztof Kozlowski wrote:
> On 16/02/2024 11:39, Jishnu Prakash wrote:
>> Hi Krzysztof,
>>
>> On 1/4/2024 1:48 PM, Krzysztof Kozlowski wrote:
>>> On 31/12/2023 18:12, Jishnu Prakash wrote:
>>>> For the PMIC5-Gen3 type PMICs, ADC peripheral is present in HW for the
>>>> following PMICs: PMK8550, PM8550, PM8550B and PM8550VX PMICs.
>>>>
>>>> It is similar to PMIC5-Gen2, with SW communication to ADCs on all PMICs
>>>> going through PBS(Programmable Boot Sequence) firmware through a single
>>>> register interface. This interface is implemented on an SDAM (Shared
>>>> Direct Access Memory) peripheral on the master PMIC PMK8550 rather
>>>> than a dedicated ADC peripheral.
>>>>
>>>> Add documentation for PMIC5 Gen3 ADC and macro definitions for ADC
>>>> channels and virtual channels (combination of ADC channel number and
>>>> PMIC SID number) per PMIC, to be used by clients of this device.
>>>>
>>>> Changes since v2:
>>>> - Moved ADC5 Gen3 documentation into a separate new file.
>>> Changelog goes under ---.
>>>
>>> Why did you do this? What is the rationale? Sorry, this patchset goes
>>> nowhere.
>>
>>
>> I'll elaborate this more in the next patchset. There are two main
>> reasons for adding this documentation in a new file:
> 
> This was more than a month ago? You reply to my comment with 1.5 months
> delay?
> 
> Sorry, I am not in the context and I am not going back to it. I have
> many other emails where my questions are addressed faster than 1.5 months.
> 
> The patch is not even in my mailbox, long gone.
> Why you are making it so difficult for reviewers?
> 
> You will get answers like I am not in context, sorry. Next time don't
> respond after 1.5 months.
> 

You're right - I'll do my best to get back to review comments in a 
reasonable time frame.

> 
>>
>> 1.This device is not exactly like the existing QCOM VADC drivers as it
>> now combines VADC functionality (reading ADC channel on client request)
>> with ADC_TM functionality (thermal threshold monitoring).
> 
> Does no explain touching bindings. Your drivers don't matter for bindings.
> 
>>
>> 2.Adding this device's bindings in the existing qcom,spmi-vadc.yaml file
> 
> No rationale was provided in commit msg.
> 
>> is not possible as it would require updating some of the existing
>> top-level constraints. (for the older devices in that file, "reg" and
>> "interrupts" can have at most one item, while this device can have more
>> than one item under these properties.)
> 

> How is this a problem?

In qcom,spmi-vadc.yaml, we have the following top-level constraints for 
the "reg" and "interrupts" properties:

   reg:
     maxItems: 1

   interrupts:
     maxItems: 1

For the ADC5 Gen3 device being added now, these constraints cannot be 
followed always, as there may be more than one peripheral under one 
device instance, each with a corresponding interrupt. For example, the 
above properties could be like this for a ADC5 Gen3 device:

     reg = <0x9000>, <0x9100>;
     interrupts = <0x0 0x90 0x1 IRQ_TYPE_EDGE_RISING>,
                  <0x0 0x91 0x1 IRQ_TYPE_EDGE_RISING>;


I could not overwrite the top-level constraints for the new device 
"qcom,spmi-adc5-gen3" alone in qcom,spmi-vadc.yaml, so I tried to remove 
the constraints from the top level and add them back conditionally for 
all the device types separately, but you told me not to remove them 
(full message: 
https://lore.kernel.org/linux-iio/832053f4-bd5d-4e58-81bb-1a8188e7f364@linaro.org/)

Since these constraints cannot be modified for a specific new device or 
removed, I think the only way to accommodate this new device is to add 
it in its own new file.

Is this a sufficient justification for adding this documentation in a 
new file or do you have any other suggestions?

Thanks,
Jishnu

> 
> 
> Best regards,
> Krzysztof
> 

