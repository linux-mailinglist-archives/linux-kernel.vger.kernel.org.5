Return-Path: <linux-kernel+bounces-139866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 886DC8A08A3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CEF31F22D99
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 06:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C7613D886;
	Thu, 11 Apr 2024 06:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jSC3lve+"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEDE4F5FE;
	Thu, 11 Apr 2024 06:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712817695; cv=none; b=Ax6JoPhrtf3RFh7Xr2MNPWNIqzkqNQTGgmm0y9RpAYWtwtRS8y7CZ+uN3Uu8sipeaNmGcV5dMKjikGDFUeDHv46Y9I4lFpky8Km1eZ4GqlmFSe4U+R86h7joBdi9ZX+LElfgistp9uOasU9fNJbTDB8AdGi80RZtExt7JvhCLmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712817695; c=relaxed/simple;
	bh=i4ItlNX7TbuFsOHfmGQsx52q+0Kg3uL7qQOODxT6NHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pWJLOuIzzWucnf0YVcHBDlF5o9p7vDuiuteeWG0n4X8Rzq8meJqfcoY+6x6rO3J3EoYih454E1PRzJlmYDHKbioS8ulDLeudFg+JRcrcmL8KG4ThPnGNPi47ar+WVh3Qwd6Csyp2+5pxwlTcKze/8pGRYrlF7+elWjT+StPzBMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jSC3lve+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43B5Da1p028318;
	Thu, 11 Apr 2024 06:41:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=mcdDJkJCVkNz828CwmAMGvCGhf1VhflNoT6vWunNHR0=; b=jS
	C3lve+KDWKnr4lvhpAPj1NgN9omwb3q9sACmtTAtNI7hGT/Ah6qoe9MLTulgMJBa
	f0o36RhyqaNfgWV9GfUaRxjcmASLMDD2e12zimXSNeZErY5vePU/7kTFs8yYK01y
	mO4L5xvp5KApKUAKt/avOFmOzEEgo+GnUFeQNea9em3TOc9S3WPVAr2uncf3Ge0Q
	vkqUQDb1lvNwXt2YVFlru3viUjaF3WDIW+MIu5JzfSJTRM+r2Fu7QsHJkVotjAmM
	0oCY2pjh2b3GYFdtIK3QL71BkXQPdjYEgl/HYFIKjj6nmdNYtsQLj2GBf8+3HJwf
	JBEGd7K46AycI8x85RRg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xe5ehs963-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 06:41:22 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43B6fLjm019752
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 06:41:21 GMT
Received: from [10.253.12.44] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 10 Apr
 2024 23:41:15 -0700
Message-ID: <89bc03c9-9545-4886-aec7-91c9926257b3@quicinc.com>
Date: Thu, 11 Apr 2024 14:41:13 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/3] input: pm8xxx-vibrator: add new SPMI vibrator
 support
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>, <kernel@quicinc.com>,
        Andy Gross
	<agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Dmitry Torokhov
	<dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-input@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20240401-pm8xxx-vibrator-new-design-v8-0-6f2b8b03b4c7@quicinc.com>
 <20240401-pm8xxx-vibrator-new-design-v8-3-6f2b8b03b4c7@quicinc.com>
 <3f8c970c-6a0d-4fc3-a2d3-e0797e7055cf@linaro.org>
From: Fenglin Wu <quic_fenglinw@quicinc.com>
In-Reply-To: <3f8c970c-6a0d-4fc3-a2d3-e0797e7055cf@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8mxOIQfrsnj8gQvUfMzniYvrdn-kuydZ
X-Proofpoint-ORIG-GUID: 8mxOIQfrsnj8gQvUfMzniYvrdn-kuydZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-11_02,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 bulkscore=0 lowpriorityscore=0
 impostorscore=0 phishscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404110046

Hi Konrad,


On 4/11/2024 2:10 AM, Konrad Dybcio wrote:
> 
> 
>> -#define VIB_MAX_LEVEL_mV    (3100)
>> -#define VIB_MIN_LEVEL_mV    (1200)
>> -#define VIB_MAX_LEVELS        (VIB_MAX_LEVEL_mV - VIB_MIN_LEVEL_mV)
>> +#define VIB_MAX_LEVEL_mV(vib)    (vib->drv2_addr ? (3544) : (3100))
> 
> You shouldn't need the additional inside parentheses
> 
> Also, is this really a good discriminator for the voltage ranges? Do *all*
> PMIC vibrators with a drv2_addr operate within this range? If not, consider
> a struct field here
> 
Currently, yes, all PMIC vibrators with a drv2_addr (PMI632, PM7250B, 
PM7325B, PM7550BA) operate within the same range because they are the 
same type.

> 
>> +#define VIB_MIN_LEVEL_mV(vib)    (vib->drv2_addr ? (1504) : (1200))
>> +#define VIB_MAX_LEVELS(vib)    (VIB_MAX_LEVEL_mV(vib) - 
>> VIB_MIN_LEVEL_mV(vib))
> 
> If the ranges are supposed to be inclusive, this is off-by-one. But looking
> at the driver, it seems like MIN_LEVEL may be "off"? I'm not sure though.
> 
> Either way, this would be a separate fix.
> [...]
The voltage range [1504, 3544] for the new SPMI vibrator is inclusive. I 
checked the voltage range [1200 3100] for PM8916 SPMI vibrator is also 
inclusive. I couldn't find any document to confirm if the SSBI vibrator 
but I assume it is the same as PM8916. I will make change before the 
series to address it.

Thanks for reviewing the changes!

Fenglin

