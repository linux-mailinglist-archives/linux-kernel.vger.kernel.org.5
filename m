Return-Path: <linux-kernel+bounces-129057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06708896404
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 07:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 053801C2287B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 05:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD14F4AECB;
	Wed,  3 Apr 2024 05:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="J1cjdzMh"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F1846425;
	Wed,  3 Apr 2024 05:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712122232; cv=none; b=ncJbhSyfk7I2CwqRExU3sFGHVRI+ajipKiUxg68rTh8LrQq7cy4hKPMAVDkArfZPGY0kqnYZyEYAj1y1lCp569rJ1ijD+CYKtzZ4K9xqDfz6VHIPDxoiDVblcIai2Yp0xInu/QNkbeH68BxxbXB5gQ2t4rSh8mTY9ALbUX5Z0dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712122232; c=relaxed/simple;
	bh=F+P7/1n/I/THPHzbh70jtYG7fUDUVpF824Km3d90icw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=s9NNrjIKrr9aLNuF5JibW/G1TNkgVRpmLINQYlZILYCOagKtTVvyI3zf4gQB5WPXNd2KjVsOAZpEqrVy0o30KLbczv491b6GaNAypfql0jvP2u+nEw+JMUtzIUmYSS2osMQBRx5kHez+gdCxnmvIy+EKWc/pnBBoF1T/TfR1SuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=J1cjdzMh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4333K4nT021640;
	Wed, 3 Apr 2024 05:30:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=ihqQBkI3scZyIcVdz4T1VFyYhYJ1SN6StLpyEalmDhw=; b=J1
	cjdzMhd+OIhN29tKQrCV/wSawxlatvvsBWO1JMIh8dl9uhov0yNVH1JqRZLkG278
	3Ah7L6W/9wswxZswJnWbZFoGHJ+Ia5PT2zYB3olIBRzPkQNH3xQB/kQzIlTnrGHX
	ehHiYBisIR3/2u+QT5NSDw3p7yeVvjpLTOAsIwIuSBYDV5PTYMX7rGgDKfGV8Kic
	6zHLnDQ4DyaeLnGdlk9mUnzydiyZwtTX0pN7LITbq+hU3Dt3jyW5V8ua7z6vWTVR
	wU0F+XFF1ChhsDBSceKYJcIZ5QF2ZmY7aU0xOk7IFbMj+LHWVw2Tazy5WKiofF21
	rGPCLEtOkhIpVDilMXSg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x8v3f8gus-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 05:30:20 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4335UJZQ031508
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Apr 2024 05:30:19 GMT
Received: from [10.239.154.73] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 2 Apr 2024
 22:30:13 -0700
Message-ID: <db301b10-6312-4d47-ba4a-9c462e5cbea0@quicinc.com>
Date: Wed, 3 Apr 2024 13:29:46 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/3] input: pm8xxx-vibrator: refactor to support new
 SPMI vibrator
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
 <20240401-pm8xxx-vibrator-new-design-v8-1-6f2b8b03b4c7@quicinc.com>
 <21641459-d7c0-412d-8244-6f2f2c458551@linaro.org>
From: Fenglin Wu <quic_fenglinw@quicinc.com>
In-Reply-To: <21641459-d7c0-412d-8244-6f2f2c458551@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ptSWHyJ8d6MRM52jQtVZhkIlouK4omGN
X-Proofpoint-GUID: ptSWHyJ8d6MRM52jQtVZhkIlouK4omGN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-03_04,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 suspectscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=607 clxscore=1011 spamscore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2404030035



On 4/2/2024 11:21 PM, Konrad Dybcio wrote:
> On 1.04.2024 10:38 AM, Fenglin Wu via B4 Relay wrote:
>> From: Fenglin Wu <quic_fenglinw@quicinc.com>
>>
>> Currently, vibrator control register addresses are hard coded,
>> including the base address and offsets, it's not flexible to
>> support new SPMI vibrator module which is usually included in
>> different PMICs with different base address. Refactor it by using
>> the base address defined in devicetree.
>>
>> Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
>> ---
> 
> [...]
> 
>>   	if (regs->enable_mask)
>> -		rc = regmap_update_bits(vib->regmap, regs->enable_addr,
>> +		rc = regmap_update_bits(vib->regmap, vib->enable_addr,
>>   					regs->enable_mask, on ? ~0 : 0);
> 
> The idiomatic way across the kernel seems to be writing the mask value
> instead of ~0 (which also saves like 2 cpu instructions)
> 
> 
> Not sure about how ssbi addressing works, but except for that lgtm
> 
Agree.
SSBI driver doesn't provide reg_update_bits function call so similar 
mathematics is done on the value before writing to the register,  I can 
update it to use enable_mask directly in next version.

> Konrad

