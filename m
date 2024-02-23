Return-Path: <linux-kernel+bounces-77784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A86A860A31
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 06:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15E261F26462
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 05:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382BE11CAD;
	Fri, 23 Feb 2024 05:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aiV8mtXW"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD11101FA;
	Fri, 23 Feb 2024 05:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708665654; cv=none; b=GXZ4hgPIwoyste1+ICEvReuYXfKsEj6024pQTJNd+Udrw5YZoxkvMH+VmCGaygIkOyrddz7aKgjEMaWnryXqXkG6ONIKiMFbpOhmYBGC2MJQ0qbQu4drTWaRnSyKjxijzwjCzUySe2+aQe0lV4SHQcPyeXxrcpS/3n0aY3WhNF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708665654; c=relaxed/simple;
	bh=Mhdw9Zu4ydEVNNkZDl6MlHFqITqdLsrXh+2UiUSmICM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cXUCRIX+ve8zm2zCkgm0FkJ2qvBdHl0MvFe4z4qB6vQiTjTTR5ku4rkGAonhag0nByN9mZ2ObnuVA+H40b/eOjgGr7N4FiLGO07ZFrtx1q5CPjIkadSF55+oPVyhsIYO7sSEmd5QWWXvp8L81aNKomyjaJa0Jlzf8xQXhImamTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aiV8mtXW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41N3wLZw001771;
	Fri, 23 Feb 2024 05:20:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=XtP90d2oLGHAANc4Hry0XB7XCfCAgx7Z9UEZsQuUESs=; b=ai
	V8mtXWQ+ss7kaXUqUgc4Dyh54flRGB0gSiZf3MG9OzQBiexfm9XJENQTID2bJ6bz
	fZdU5hsNthYCgviFZJpllQh17SQhQJHUIufHQO/2XysxoDyJTZP5UW3D11gcDZGa
	DmT60KQ5oXQ4iQlMvJRXIqwncyzP/UAqz3cJorxDCHugg1SSR59hsC68vsZFTTvy
	mg4nYjIp9K2Au+3kN0ru+2u8RaGOopH5Yl0TcIV4axHXQgofJetUPoXkKZf0gFV8
	/4saDP59GT2ZEAeeX6PcWnn5yDI160Qi459pJvlIkE+dcXEe/RRb+DqUy5+dWbwG
	XE6AgYctFu2e44Dy6sCQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3weasbst7w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 05:20:42 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41N5Kgms001975
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 05:20:42 GMT
Received: from [10.216.26.154] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 22 Feb
 2024 21:20:37 -0800
Message-ID: <ef3f5a8a-f5c7-3a2c-191b-4ce0db5cd79f@quicinc.com>
Date: Fri, 23 Feb 2024 10:50:34 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] thermal/drivers/tsens: Add suspend to RAM support for
 tsens
To: Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath
	<thara.gopinath@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        "Rafael J
 . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_mkshah@quicinc.com>,
        "Raghavendra
 Kakarla" <quic_rkakarla@quicinc.com>
References: <20240122100726.16993-1-quic_priyjain@quicinc.com>
 <548e2f24-a51e-4593-9463-09506488c70e@linaro.org>
 <f415a8cd-4cae-d7c3-60fc-674b3e660f6b@quicinc.com>
 <aeae2e69-8407-4d90-9d16-27798e2f3248@linaro.org>
 <be69e0a6-fdc8-c24b-9beb-adaac4a97776@quicinc.com>
 <b5ea1c8c-c35d-45e3-9b90-d3dc480f4463@linaro.org>
 <1cd754e5-fc5e-bd8b-1d70-8de40c9a85e7@quicinc.com>
Content-Language: en-US
From: Priyansh Jain <quic_priyjain@quicinc.com>
In-Reply-To: <1cd754e5-fc5e-bd8b-1d70-8de40c9a85e7@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: cH7944HrqCUIXbrJjQXy0ezi4puFE66n
X-Proofpoint-GUID: cH7944HrqCUIXbrJjQXy0ezi4puFE66n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=1 mlxscore=1 suspectscore=0
 mlxlogscore=186 impostorscore=0 bulkscore=0 phishscore=0 spamscore=1
 clxscore=1011 lowpriorityscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402230035



On 1/27/2024 9:07 PM, Manaf Meethalavalappu Pallikunhi wrote:

> +Maulik and Raghavendra
> 
> Hi Konrad,
> 
> On 1/25/2024 4:38 PM, Konrad Dybcio wrote:
>>
>>
>> On 1/24/24 16:25, Priyansh Jain wrote:
>>>
>>>
>>> On 1/24/2024 6:04 PM, Konrad Dybcio wrote:
>>>>
>>>>
>>>> On 1/24/24 11:42, Priyansh Jain wrote:
>>>>>
>>>>>
>>>>> On 1/22/2024 8:02 PM, Konrad Dybcio wrote:
>>>>>> On 22.01.2024 11:07, Priyansh Jain wrote:
>>>>>>> Add suspend callback support for tsens which disables tsens 
>>>>>>> interrupts
>>>>>>> in suspend to RAM callback.
>>>>>>
>>>>>> Would it not be preferrable to have the "critical overheat", wakeup-
>>>>>> capable interrupts be enabled, even if the system is suspended?
>>>>>>
>>>>>
>>>>>
>>>>> As part of suspend to RAM, tsens hardware will be turned off and it 
>>>>> cannot generate any interrupt.Also system doesn't want to abort 
>>>>> suspend to RAM due to tsens interrupts since system is already 
>>>>> going into lowest
>>>>> power state. Hence disabling tsens interrupt during suspend to RAM 
>>>>> callback.
>>>>
>>>> Is that a hardware limitation, or a software design choice? I'm not
>>>> sure I want my phone to have thermal notifications disabled when
>>>> it's suspended.
>>>
>>>> Konrad
>>>
>>> As part of suspend to RAM , entire SOC will be off,
>>
>> What do you mean by "entire SOC[sic] will be off"? Surely the memory
>> controller must be on to keep refreshing the memory? Are you thinking
>> of suspend-to-disk (hibernation), by chance?
> 
> Yes, Memory will be in self refreshing  mode(Retained). But SOC will be off
> 
> and will do cold boot to come out of S2R.
> 
>>
>>> this mode (suspend to RAM) is not intended for Mobile product. Tsens 
>>> interrupts are not
>>> disabled as part of suspend to idle(suspend mode for mobile).
>>
>> That's clearly untrue, e.g. the PSCI firmware on SM8550 implements
>> PSCI_SYSTEM_SUSPEND, which does S2R.
> 
> IIUC, PSCI_SYSTEM_SUSPEND will be enabled only for S2R supported 
> products and will be removed it for others.
> 
> Maulik/Raghavendra can comment more
> 
Sorry for delayed response, we have discussed internally on this and
came to the conclusion that disabling tsens interrupt in S2R path is not 
correct approach as S2R is being exercised on mobile kind of products as 
well. I will update the required changes in the next patch.

Priyansh
>>
>> Konrad

