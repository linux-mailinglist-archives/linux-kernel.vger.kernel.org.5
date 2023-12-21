Return-Path: <linux-kernel+bounces-7969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1A281AFEA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 707A91C2322C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 08:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB9415AFB;
	Thu, 21 Dec 2023 08:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DTJoTr1P"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDFC156CB;
	Thu, 21 Dec 2023 08:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BL7JsRx021287;
	Thu, 21 Dec 2023 08:01:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=xJQ0HXRIxO8h0lK22mFO3GttJHqvn1vwTveFbKO10TY=; b=DT
	JoTr1P9INICH8Y/KjtyNk+wLOr3FhXTaaFuFyLl9t2zrBpmzjbsMR4xMmPHvqleZ
	7IADYybca4ZTb55QMcvO4d3+aXO1RKLy6fTRTNdCyuo51VDn37Z93ytH2Q29fifL
	FzEw3eihIJv6haCLSKFw0fZNWLkP/BJoVtdpKJ4IX8FP62BntJAb0a7QQIF/V4kK
	E/ywdPnjsT2cjmTxGYCBV6sUKRg0DR9NL5PdRJqFgThgbRK09IzSKqxSEngrbRut
	6+cROi/crwYsB+rKZURKwh/LElEzSSyiKMSMfQWSaqtqeWsHczheWiY/VPCGTDoT
	VaC+apJoPIm4E/7K8tdA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v4gvh06um-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Dec 2023 08:01:04 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BL812nR017310
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Dec 2023 08:01:02 GMT
Received: from [10.216.32.244] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 21 Dec
 2023 00:00:49 -0800
Message-ID: <716cf526-59e3-e755-0a47-ff9ae496e87c@quicinc.com>
Date: Thu, 21 Dec 2023 13:30:45 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH V2 1/3] dt-bindings: iio: adc: Add QCOM PMIC5 Gen3 ADC
 bindings
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, <jic23@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <daniel.lezcano@linaro.org>,
        <dmitry.baryshkov@linaro.org>, <linus.walleij@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <andriy.shevchenko@linux.intel.com>,
        <quic_subbaram@quicinc.com>, <quic_collinsd@quicinc.com>,
        <quic_amelende@quicinc.com>, <quic_kamalw@quicinc.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <marijn.suijten@somainline.org>
CC: <lars@metafoo.de>, <luca@z3ntu.xyz>, <linux-iio@vger.kernel.org>,
        <lee@kernel.org>, <rafael@kernel.org>, <rui.zhang@intel.com>,
        <lukasz.luba@arm.com>, <cros-qcom-dts-watchers@chromium.org>,
        <sboyd@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-arm-msm-owner@vger.kernel.org>, <kernel@quicinc.com>
References: <20231116032530.753192-1-quic_jprakash@quicinc.com>
 <20231116032530.753192-2-quic_jprakash@quicinc.com>
 <832053f4-bd5d-4e58-81bb-1a8188e7f364@linaro.org>
Content-Language: en-US
From: Jishnu Prakash <quic_jprakash@quicinc.com>
In-Reply-To: <832053f4-bd5d-4e58-81bb-1a8188e7f364@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: l9CnmtUYeu1gfa2inySLTHIKfZfK3gTZ
X-Proofpoint-GUID: l9CnmtUYeu1gfa2inySLTHIKfZfK3gTZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 clxscore=1011 adultscore=0 suspectscore=0
 mlxlogscore=830 bulkscore=0 phishscore=0 malwarescore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312210058

Hi Krzysztof,

On 11/16/2023 5:13 PM, Krzysztof Kozlowski wrote:
> On 16/11/2023 04:25, Jishnu Prakash wrote:
>> For the PMIC5-Gen3 type PMICs, ADC peripheral is present in HW for the
>> following PMICs: PMK8550, PM8550, PM8550B and PM8550VX PMICs.
>>
> A nit, subject: drop second/last, redundant "bindings". The
> "dt-bindings" prefix is already stating that these are bindings.
>
>>   
>>     reg:
>> -    description: VADC base address in the SPMI PMIC register map
>> -    maxItems: 1
> NAK.
>
> I wrote it multiple times. You canno remove the widest constraints from
> top-level property.
>

>>     '#io-channel-cells':
>>       const: 1
>>   
>>     interrupts:
>> -    maxItems: 1
> No, srsly. We went through it.


Is it fine if I add the bindings for ADC5 Gen3 in a new file? It's not 
just for the reg and interrupts properties, I think it would make sense 
to have a new file as ADC5 Gen3 is a new device combining the functions 
of the existing QCOM VADC and ADC_TM devices.


>
>
>> -    description:
>> +    description: |
>>         End of conversion interrupt.
>> +      - For compatible property "qcom,spmi-adc5-gen3", interrupts are defined
>> +        for each SDAM being used.
>> +
>> +  interrupt-names:
>> +    description: |
> You must describe the names which also provides constraints.


I'll update this in the next patchset.

Thanks,

Jishnu


>
> I am not going to review the rest of the file.
>
> Best regards,
> Krzysztof
>

