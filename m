Return-Path: <linux-kernel+bounces-83567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B331869B92
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 691501C21558
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710261474A5;
	Tue, 27 Feb 2024 16:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="afoiQ37/"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494CF1468FF;
	Tue, 27 Feb 2024 16:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709050005; cv=none; b=N0AEPcs4KLGHuNBb8hYtyYIZKcqvP70q25IeShPn+FMAxLmd8dc6aTlAUJvCZ8ILHVlbDzLkoB+doEFo9EZ48Hyv9X4sHkllu3a0NDctaF616aTmw8q1WMLNyDlxn077y4aYQ49LFUP/3MW8SFZyrDj/nqY+mVRBtiqEnfd+aRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709050005; c=relaxed/simple;
	bh=A4aXiTDmIEAp8TItElIIbGiHyG8htDtJ8aMRi/aK0Hc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aVy3OGcZPXJ7Kh95zGEzqyktoOVaNPRoeEUVKvDtdwsaUkMqOwIS44mwQ6yflht7P/ge0G1oQAYOTFA758Ks0lP0V9oUApiTm6vSKTKwAVD8UBw2x5u6+bRjdmijN9fhOvxVAvCSBWa+7ODaB20q46B9Oarl9Cn4q7hTB9MtKoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=afoiQ37/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41RBKdbx006642;
	Tue, 27 Feb 2024 16:06:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=1GJRhGjod38oTbcKKelMDEYZhj6mr/kVO4Bxvb6vSzg=; b=af
	oiQ37/yfdjvpNl65qrgUYhpwy4ysiymztSLtKJHsyVDAhcX58F7boIhsacwGWBMX
	iw5ylBKftlrcYj+r8RxFTmR/baDgIaLHq+RL/hgXfDSKjWLtOqJgQeeSfyVFVJPu
	9DjpkPgPeffenTswOm8L7pAkVF7cLWCVGts+u8vMsDEaxzTps6L6AqLvTmrEJIMS
	4KSCu3k9OA7f+JLWIOOT3gHxoaccz/nC8aKyuD7Mi9SWrp+0T2fQx3TwBmF5Eapv
	4Uhe6qdxTkTQm/uuP0xrkil8FE8zTQuKO0zBIFwm0LwP9pNvHN5TRzw7Lss94qb7
	UfDesFhZvv6Gx5t6YDEg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wh64h1vag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 16:06:35 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41RG6Y6o000700
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 16:06:34 GMT
Received: from [10.216.55.24] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 27 Feb
 2024 08:06:30 -0800
Message-ID: <6962061f-d0c9-f3d3-ca1a-222f63653800@quicinc.com>
Date: Tue, 27 Feb 2024 21:36:19 +0530
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
Content-Language: en-US
To: Amit Kucheria <amitk@kernel.org>
CC: Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thara Gopinath
	<thara.gopinath@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        "Rafael J
 . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_manafm@quicinc.com>
References: <20240122100726.16993-1-quic_priyjain@quicinc.com>
 <548e2f24-a51e-4593-9463-09506488c70e@linaro.org>
 <f415a8cd-4cae-d7c3-60fc-674b3e660f6b@quicinc.com>
 <aeae2e69-8407-4d90-9d16-27798e2f3248@linaro.org>
 <be69e0a6-fdc8-c24b-9beb-adaac4a97776@quicinc.com>
 <CAHLCerNx4KxzmQF8HmTTFr+W7xn5vubA=Jcg4Kwyk=cCJ4w+Wg@mail.gmail.com>
From: Priyansh Jain <quic_priyjain@quicinc.com>
In-Reply-To: <CAHLCerNx4KxzmQF8HmTTFr+W7xn5vubA=Jcg4Kwyk=cCJ4w+Wg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: SrrKB6G30vMhWkgpKqSuOTta7Y85ecr4
X-Proofpoint-GUID: SrrKB6G30vMhWkgpKqSuOTta7Y85ecr4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-27_01,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 bulkscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 mlxlogscore=584 priorityscore=1501 adultscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2402270124



On 1/28/2024 1:41 AM, Amit Kucheria wrote:
> On Wed, Jan 24, 2024 at 8:55 PM Priyansh Jain <quic_priyjain@quicinc.com> wrote:
>>
>>
>>
>> On 1/24/2024 6:04 PM, Konrad Dybcio wrote:
>>>
>>>
>>> On 1/24/24 11:42, Priyansh Jain wrote:
> 
>>>>
>>>> As part of suspend to RAM, tsens hardware will be turned off and it
>>>> cannot generate any interrupt.Also system doesn't want to abort
>>>> suspend to RAM due to tsens interrupts since system is already going
>>>> into lowest
>>>> power state. Hence disabling tsens interrupt during suspend to RAM
>>>> callback.
>>>
>>> Is that a hardware limitation, or a software design choice? I'm not
>>> sure I want my phone to have thermal notifications disabled when
>>> it's suspended.
>>
>>> Konrad
>>
>> As part of suspend to RAM , entire SOC will be off, this mode (suspend
>> to RAM) is not intended for Mobile product. Tsens interrupts are not
>> disabled as part of suspend to idle(suspend mode for mobile).
> 
> You should hide the callbacks behind the CONFIG_SUSPEND Kconfig option
> so that it only gets enabled when S2R is enabled.

Yes i will take care of this in next version.

Priyansh

