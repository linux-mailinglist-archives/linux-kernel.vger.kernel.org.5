Return-Path: <linux-kernel+bounces-68460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D55857A7F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ADB51F2359B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F5050A98;
	Fri, 16 Feb 2024 10:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bsjpucCf"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FBB51C5A;
	Fri, 16 Feb 2024 10:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708080016; cv=none; b=XOKG/UT3wHLH41Tvn+G0JPOzvuu6F1qARH/I+XstaF+45oEFO8xzHEulPTnv3yNeXPopMwAcEfnZ2YttMwFb3IaBerx2742v+v/yQG90WtyqZdUjFs+tiAsUkV0EJ5GfQYa535U7HfD7UAgavyXkiub/X+Kwz/o6/cTU+WlrJCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708080016; c=relaxed/simple;
	bh=lKkTWjc5S0Zeir08AUyREHVP6BXIPt/Pb30uog3d1Xw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MFg5N9t+jMtLicKIkk7zJMBJ4U9s2ouAL/ZpCmJ4UesjDMRgUOCtWQGZVsjUYE1K2PDEByoGmyXQoKL1kPu05S0YQcdZvkGQqMu+UjaKRDXXl/LxBHjOqB2L0cgGPijTDUOFBlgp6JxtqWbVeTnjmzBWZL67UnPABcVkIOMyXe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bsjpucCf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41G6Kf2o023221;
	Fri, 16 Feb 2024 10:39:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=bHEy5IZPeB1t6hgx0UtqO2tRKR4Ki3BJPIXU08pxj80=; b=bs
	jpucCfLbGGmhMT4MFQMTs8uGvEkQWBrw4g4pM8lo9Cvx6EVgUxma2tSPDSpBQoaB
	vZNHa/Ux7zoSJKJ4rC5PvYzAp8dQd3x5FW0kZtD9vUuX9yZgPO3aOWAqjnhnI2zw
	x2o+ts2E2thgX92qiC5A7iPJ4EjGgoSw4a0YxipmkCjB5Zw+ZR9Wv1epnkBrVYob
	VQX+uKofpEG3vQRwhbVn2TZR+9LI4yOpGwKbINegZ1r8zXdLRY6xVzAtHCS/t73t
	lZtR7CEvf2JYe+hXRj6yDNlNC1CyWXWv9zgdYbAkjnI7lBJ69ckV3enoAkt7NLbq
	VH7cfI27pvC1VwGJ6riw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w9xdx8tg2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 10:39:50 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41GAdn7o014888
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 10:39:49 GMT
Received: from [10.218.16.59] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 16 Feb
 2024 02:39:38 -0800
Message-ID: <12723477-aee2-40bc-80f0-a86c16c98988@quicinc.com>
Date: Fri, 16 Feb 2024 16:09:38 +0530
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
To: Jonathan Cameron <jic23@kernel.org>
CC: <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <lee@kernel.org>,
        <andriy.shevchenko@linux.intel.com>, <daniel.lezcano@linaro.org>,
        <dmitry.baryshkov@linaro.org>, <lars@metafoo.de>, <luca@z3ntu.xyz>,
        <marijn.suijten@somainline.org>, <agross@kernel.org>,
        <sboyd@kernel.org>, <rafael@kernel.org>, <rui.zhang@intel.com>,
        <lukasz.luba@arm.com>, <linus.walleij@linaro.org>,
        <quic_subbaram@quicinc.com>, <quic_collinsd@quicinc.com>,
        <quic_amelende@quicinc.com>, <quic_kamalw@quicinc.com>,
        <kernel@quicinc.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-arm-msm-owner@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <cros-qcom-dts-watchers@chromium.org>
References: <20231231171237.3322376-1-quic_jprakash@quicinc.com>
 <20231231171237.3322376-3-quic_jprakash@quicinc.com>
 <20240101180209.56e04267@jic23-huawei>
From: Jishnu Prakash <quic_jprakash@quicinc.com>
In-Reply-To: <20240101180209.56e04267@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: AF-uuHRRXZAu6C46-PBrfZ69SzHtTBto
X-Proofpoint-GUID: AF-uuHRRXZAu6C46-PBrfZ69SzHtTBto
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_08,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 phishscore=0 mlxscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402160086

Hi Jonathan,

On 1/1/2024 11:32 PM, Jonathan Cameron wrote:
> On Sun, 31 Dec 2023 22:42:36 +0530
> Jishnu Prakash <quic_jprakash@quicinc.com> wrote:
>
>> For the PMIC5-Gen3 type PMICs, ADC peripheral is present in HW for the

>> +
>> +      label:
>> +        $ref: /schemas/types.yaml#/definitions/string
>> +        description: |
>> +            ADC input of the platform as seen in the schematics.
>> +            For thermistor inputs connected to generic AMUX or GPIO inputs
>> +            these can vary across platform for the same pins. Hence select
>> +            the platform schematics name for this channel.
> defined in adc.yaml, so should just have a reference to that here.
>
>> +
>> +      qcom,decimation:
>> +        $ref: /schemas/types.yaml#/definitions/uint32
>> +        description: |
>> +            This parameter is used to decrease ADC sampling rate.
>> +            Quicker measurements can be made by reducing decimation ratio.
> Why is this in DT rather than as a userspace control?


We don't intend this property to be something that can be controlled 
from userspace - if a client wants to read an ADC channel from 
userspace, we only intend to provide them the processed value, 
calculated with a fixed set of ADC properties mentioned in the 
corresponding channel node in DT.


>> +        enum: [ 85, 340, 1360 ]
>> +        default: 1360
>> +

>> +
>> +      qcom,hw-settle-time:
>> +        $ref: /schemas/types.yaml#/definitions/uint32
>> +        description: |
>> +            Time between AMUX getting configured and the ADC starting
>> +            conversion. The 'hw_settle_time' is an index used from valid values
>> +            and programmed in hardware to achieve the hardware settling delay.
>> +        enum: [ 15, 100, 200, 300, 400, 500, 600, 700, 1000, 2000, 4000,
>> +                8000, 16000, 32000, 64000, 128000 ]
>> +        default: 15
> only currently defined for muxes but we have settle-time-us which has benefit of
> providing the units (which are missing here from the description as well)
>
>> +
>> +      qcom,avg-samples:
>> +        $ref: /schemas/types.yaml#/definitions/uint32
>> +        description: |
>> +            Number of samples to be used for measurement.
>> +            Averaging provides the option to obtain a single measurement
>> +            from the ADC that is an average of multiple samples. The value
>> +            selected is 2^(value).
> Why is this in dt?  Why not just userspace control (in_voltageX_oversampling_ratio
>
> If it needs to be, we do have standard DT bindings for it in adc.yaml


avg-samples is also something we don't want the client to modify from 
userspace. As for using adc.yaml, I think I could use settling-time-us 
and oversampling-ratio from it for the above two properties.

However, Krzysztof has mentioned in another comment that I should put 
properties common to ADC5 Gen3 and older QCOM VADC devices in a common 
schema. If I now try replacing the existing qcom,hw-settle-time and 
qcom,avg-samples properties with settling-time-us and oversampling-ratio 
for older devices too, I would have to make several DT changes for 
existing devices...are you fine with this? Or should I just replace 
these two properties for ADC5 Gen3?


I'll address your other comments in the next patchset.


Thanks,

Jishnu


