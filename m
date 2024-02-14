Return-Path: <linux-kernel+bounces-65311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C06854AF7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA6361C28356
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840855576A;
	Wed, 14 Feb 2024 13:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ljkXjH4C"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0011D5C8FE;
	Wed, 14 Feb 2024 13:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707919154; cv=none; b=dNitJRw7i4/1AuTlv25dktPnOAn9KFNMQ28sd+zo8s7hneX2evl2LMTv9dKc3gxfoyCpBLeZPOHLOIrJRfQwG1C6LT+6EHLujzVzQDwz4P+/yX/HIvLZkGJfB15Y+UihSc2R0DY78EH/22Y0cVDz7u/1a7jEGyEFIPw0+R0IViU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707919154; c=relaxed/simple;
	bh=gvJJZ/u+oFmJe9o1bdHtO/O/5u2N3evyh8Zop5iY370=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XjFBcmmXx8L/Xp5ybq9KjVWh7XmwuCo/xhGtLhmMH/jdBNL9j6LuDt0Tgwf4Uq2K+K59apnRFNvlNvkFlSAIOk/G82vFF2tFknogr6GP/30CAtYl+ro81VsZ1ygHOY+oeTfozKFVQ+Uryib5G/OhKnQuN11ggyDFewUhPEuumLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ljkXjH4C; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41EAxMXw001851;
	Wed, 14 Feb 2024 13:58:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=UsRN04YgdttuRzXuuaPeRfbR90rptVxiln+xXdu7HOM=; b=lj
	kXjH4CFDMWOxTHHPA+dFro8BHptRBBZHD55vn6e728Un0kpyEwCNNbi3yTPzcfvc
	Z9frQZ9CfyqnIIhH74EPauBaZ3rDqjUJNFld/Id7QQWQdhQ5wecheYYbd7YbuSDR
	Mnv2ufEeexLbxdSdavuVptXyzF4txem6Lqui8MwrHw+62A41sesLPlxJFrj2VcPh
	s0vHwftM3XG+yMIREDFZdXnwGNyuKgGdsBPa+80rkGsDn1Mn+7g3fRmHjY08+67d
	6JaehgHgm/7Iw/eTsppRD/aYr30qLAWPAjzEPc5R80O6HArRaAlRRfJxViAekSKX
	MEmdMrhl5CLvunNSykKQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w8jn9hb6j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 13:58:47 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41EDwjva016998
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 13:58:45 GMT
Received: from [10.216.19.164] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 14 Feb
 2024 05:58:31 -0800
Message-ID: <e5a5b32c-bc9d-42b7-b1a8-90e22b957915@quicinc.com>
Date: Wed, 14 Feb 2024 19:28:26 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] iio: adc: Add support for QCOM PMIC5 Gen3 ADC
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: <jic23@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <lee@kernel.org>,
        <andriy.shevchenko@linux.intel.com>, <daniel.lezcano@linaro.org>,
        <lars@metafoo.de>, <luca@z3ntu.xyz>, <marijn.suijten@somainline.org>,
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
 <20231231171237.3322376-4-quic_jprakash@quicinc.com>
 <CAA8EJpr4q7pFF44oUjJSWGYKgiUCB_23zVHw6J3a3mwn7cKgyg@mail.gmail.com>
Content-Language: en-US
From: Jishnu Prakash <quic_jprakash@quicinc.com>
In-Reply-To: <CAA8EJpr4q7pFF44oUjJSWGYKgiUCB_23zVHw6J3a3mwn7cKgyg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jDzhMT2m9_qcniAuUC2Ibd9s1FWU_QVo
X-Proofpoint-ORIG-GUID: jDzhMT2m9_qcniAuUC2Ibd9s1FWU_QVo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-14_06,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 priorityscore=1501 clxscore=1011
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402140108

Hi Dmitry,

On 12/31/2023 11:16 PM, Dmitry Baryshkov wrote:
> On Sun, 31 Dec 2023 at 19:13, Jishnu Prakash <quic_jprakash@quicinc.com> wrote:
>> The ADC architecture on PMIC5 Gen3 is similar to that on PMIC5 Gen2,
>> with all SW communication to ADC going through PMK8550 which
>> communicates with other PMICs through PBS.

>> +static int adc_tm_register_tzd(struct adc5_chip *adc)
>> +{
>> +       unsigned int i, channel;
>> +       struct thermal_zone_device *tzd;
>> +
>> +       for (i = 0; i < adc->nchannels; i++) {
>> +               channel = V_CHAN(adc->chan_props[i]);
>> +
>> +               if (!adc->chan_props[i].adc_tm)
>> +                       continue;
>> +               tzd = devm_thermal_of_zone_register(adc->dev, channel,
>> +                       &adc->chan_props[i], &adc_tm_ops);
> It is _very_ useful to register a hwmon too by calling
> devm_thermal_add_hwmon_sysfs(). However this becomes tricky, as this
> function is not defined in one of the global headers.
>
> This actually points out an issue. You have the ADC driver fused
> together with the thermal driver. Can I suggest using the aux device
> to split the thermal functionality to the separate driver?
>
> This way it would be possible to use the ADC without any thermal
> monitoring in place.


There are a couple of issues which may make it harder to split the 
thermal functionality from this driver into an auxiliary driver as you 
mentioned.

For one, we use the same set of registers (offsets 0x4f-0x55) for both 
VADC function(requesting an immediate channel reading) and ADC_TM 
function (setting upper/lower thermal thresholds on a channel). To avoid 
any race conditions, we would need to share a mutex between the 
top-level ADC driver and the auxiliary ADC_TM thermal driver to avoid 
concurrently accessing these or any other shared registers.

In addition, the device has only one interrupt with one interrupt 
handler, and it gets triggered for both VADC and ADC_TM  events (end of 
conversion and threshold violation, respectively). The handler checks 
for both types of event and handles it as required.

For the shared interrupt, we may be able to keep the interrupt handler 
in the top-level driver and just notify the auxiliary TM driver if a 
threshold violation is detected. For the shared mutex, I think the 
auxiliary driver may be able to access the parent driver's mutex, but 
I'll need to check more for the implementation in both of these cases.

Please let me know if you see any problems with this kind of 
implementation or if you have any additional comments.

Thanks,

Jishnu

>> +
>> +               if (IS_ERR(tzd)) {
>> +                       if (PTR_ERR(tzd) == -ENODEV) {
>> +                               dev_warn(adc->dev, "thermal sensor on channel %d is not used\n",
>> +                                        channel);
>> +                               continue;
>> +                       }
>> +
>>
>

