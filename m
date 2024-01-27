Return-Path: <linux-kernel+bounces-41250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C210483EDFE
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 16:37:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 775391F2279C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 15:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1BB228E39;
	Sat, 27 Jan 2024 15:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Nn4e4sJE"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BF3200AB;
	Sat, 27 Jan 2024 15:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706369845; cv=none; b=OQtgqhiYjrYMJUoTKfIh6AancUwpDDCS3wDzoHU5Ru0H1dSvGbki7ESMm2N+Al9tf0t2Z6FP2G8tHjkBPdr7c0+qBNfsd/mrBdC/fx1QyRNA8tQsRQzrh0u3MCWdNOhPoSSxlOsDsBF9D/PL9Oqx3FYa8TjCoGztj5bhKNr0//U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706369845; c=relaxed/simple;
	bh=yeEb+DX6g1gaZS5hxdUJC6t92mKaMthuJkbpJ+wrn88=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=B5TFVh9sfMdkbMcMt9xOzRnaoFT+puSIJ1bnRySs44J8j6sOS2Q0UxokRYNyEdzFLUpVUudUdjKj3E/Hi+kMyQr14dduBLHxISYH+ZPoafCKcXBLtrC5lGUecxhfKuMS/0Fvt1nnHOb/rNua7kTH1G4bKozmLKUr9DMU2L0zz5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Nn4e4sJE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40RFM4Lb013249;
	Sat, 27 Jan 2024 15:37:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=GL6DcGHInWdFEK4wiTfvMS/9wuVoeUooATeGAfyk74g=; b=Nn
	4e4sJEnhmmnRkWBWJ94KqtJ3coDqiv9jsdQ/J9CbZsmWqGPHxml0MIyfSNyB0msi
	HoyLVSvR6E8sPw13CFryQh+3fwWllxpYYcicH9ePoZ5XhpCGym1xopAhArC0pkW6
	uV1ZX1S8C1XeynjrqKXqEc4ZZl9jK2Sv4Yr+Ek8b199oygyDi4auuCig4dsoAUGe
	pEDMTxlpYZUOfwUeRpRQBWqiFC/F1YSFg6WArP58P1REpow9l3j1wdKoNtiPG2UV
	PzHlRVZnWu7d2bYdqtb1lzEc3QZorzHpqrAy2R90cnwHXOIXOQJ2dLV0xwPsAMLN
	WuMAYHMCHcwcvUTJoNNg==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vvswy8phd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Jan 2024 15:37:08 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40RFb7ne028845
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Jan 2024 15:37:07 GMT
Received: from [10.216.45.141] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sat, 27 Jan
 2024 07:37:03 -0800
Message-ID: <1cd754e5-fc5e-bd8b-1d70-8de40c9a85e7@quicinc.com>
Date: Sat, 27 Jan 2024 21:07:00 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] thermal/drivers/tsens: Add suspend to RAM support for
 tsens
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
        Priyansh Jain
	<quic_priyjain@quicinc.com>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath
	<thara.gopinath@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        "Rafael J
 . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <",quic_mkshah"@quicinc.com>,
        ",Raghavendra
 Kakarla" <quic_rkakarla@quicinc.com>
References: <20240122100726.16993-1-quic_priyjain@quicinc.com>
 <548e2f24-a51e-4593-9463-09506488c70e@linaro.org>
 <f415a8cd-4cae-d7c3-60fc-674b3e660f6b@quicinc.com>
 <aeae2e69-8407-4d90-9d16-27798e2f3248@linaro.org>
 <be69e0a6-fdc8-c24b-9beb-adaac4a97776@quicinc.com>
 <b5ea1c8c-c35d-45e3-9b90-d3dc480f4463@linaro.org>
From: Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
In-Reply-To: <b5ea1c8c-c35d-45e3-9b90-d3dc480f4463@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: GACN8c85PyCVK4Yhzs7Uc5A2ahGGIDp1
X-Proofpoint-GUID: GACN8c85PyCVK4Yhzs7Uc5A2ahGGIDp1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 suspectscore=0 bulkscore=0 phishscore=0 clxscore=1011
 impostorscore=0 mlxlogscore=254 malwarescore=0 mlxscore=0
 lowpriorityscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2401190000 definitions=main-2401270117

+Maulik and Raghavendra

Hi Konrad,

On 1/25/2024 4:38 PM, Konrad Dybcio wrote:
>
>
> On 1/24/24 16:25, Priyansh Jain wrote:
>>
>>
>> On 1/24/2024 6:04 PM, Konrad Dybcio wrote:
>>>
>>>
>>> On 1/24/24 11:42, Priyansh Jain wrote:
>>>>
>>>>
>>>> On 1/22/2024 8:02 PM, Konrad Dybcio wrote:
>>>>> On 22.01.2024 11:07, Priyansh Jain wrote:
>>>>>> Add suspend callback support for tsens which disables tsens 
>>>>>> interrupts
>>>>>> in suspend to RAM callback.
>>>>>
>>>>> Would it not be preferrable to have the "critical overheat", wakeup-
>>>>> capable interrupts be enabled, even if the system is suspended?
>>>>>
>>>>
>>>>
>>>> As part of suspend to RAM, tsens hardware will be turned off and it 
>>>> cannot generate any interrupt.Also system doesn't want to abort 
>>>> suspend to RAM due to tsens interrupts since system is already 
>>>> going into lowest
>>>> power state. Hence disabling tsens interrupt during suspend to RAM 
>>>> callback.
>>>
>>> Is that a hardware limitation, or a software design choice? I'm not
>>> sure I want my phone to have thermal notifications disabled when
>>> it's suspended.
>>
>>> Konrad
>>
>> As part of suspend to RAM , entire SOC will be off,
>
> What do you mean by "entire SOC[sic] will be off"? Surely the memory
> controller must be on to keep refreshing the memory? Are you thinking
> of suspend-to-disk (hibernation), by chance?

Yes, Memory will be in self refreshing  mode(Retained). But SOC will be off

and will do cold boot to come out of S2R.

>
>> this mode (suspend to RAM) is not intended for Mobile product. Tsens 
>> interrupts are not
>> disabled as part of suspend to idle(suspend mode for mobile).
>
> That's clearly untrue, e.g. the PSCI firmware on SM8550 implements
> PSCI_SYSTEM_SUSPEND, which does S2R.

IIUC, PSCI_SYSTEM_SUSPEND will be enabled only for S2R supported 
products and will be removed it for others.

Maulik/Raghavendra can comment more

>
> Konrad

