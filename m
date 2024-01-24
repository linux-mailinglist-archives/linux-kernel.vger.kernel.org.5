Return-Path: <linux-kernel+bounces-37244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4FEC83AD35
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:25:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D3DB1C25DA0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75FFB7C08E;
	Wed, 24 Jan 2024 15:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="apFh6zJ0"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403E87A707;
	Wed, 24 Jan 2024 15:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706109944; cv=none; b=ZL+safbPAdIrr0y3G/hnY3e8ImadLK9cY9ikIlhjHU4W9foCJknnZGA/KhuS+n3TDzJQR5DTKbwbHvhmlU9HH0opY2tOAwkySTUykvLKdhrT2efkW2mULNGWrraeGQBu+Rjn0wQJVQST0JHDA5uExyamlgxsqYRLQ6S88UVMeZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706109944; c=relaxed/simple;
	bh=OQU/+q3vIDCVis27eIKAXr6BMKI4dpGBzkf75gwybr4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Shvda5kUNil6XNK0qHDi25ATKIi0YlOjNKCVClEobZgkyAyxwqzhRLk5SB3510rPpbcVCe7KUx67/uECB9kw0eRMdYIjggTjMYhw8YUmSvqasn4GYWXAZVtqAW3jnjkzSSYMNeSyJQ/chQzbyIsb6CWOgKgD35DvRw6HuzRcbv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=apFh6zJ0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40OCYpQn005760;
	Wed, 24 Jan 2024 15:25:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=TKqmN0ivHFHrIW/RN12lAs9vGB/kamk2FcWgpEX3Nh0=; b=ap
	Fh6zJ0fSqIuVfTIhGxZc3QR1QTbqwRdl0Ob1MTI3YqExSUwSVKhvoHicL09w66sH
	hBoc34LLrDRjUacu4/3zvUYDcalZmbRCbe4KCpLcGiclbRJFnYVYbVsvEY0kg3VD
	Oggxh5z0V6raClKgP8L+De6ZKekaJNwrVy1+uJC6eh9JNcTmGL09POxtvY0/TlKk
	KWbYKkFDvVRN8DeRy2Ta3v85KQ7TmH3j3ZigOsJL9xuCQ1cpjTJQGtbDu1oGUrQq
	gwy1yntfe9yEArvMSg3qd0kV9GKN4MZ/WFfvcXFRwwCIR6ESnXcB9owe6xtgXyXS
	BEBRyv2IX6W3zFLlKtQg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vtmh022xq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 15:25:34 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40OFPYp4030818
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 15:25:34 GMT
Received: from [10.216.38.76] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 24 Jan
 2024 07:25:29 -0800
Message-ID: <be69e0a6-fdc8-c24b-9beb-adaac4a97776@quicinc.com>
Date: Wed, 24 Jan 2024 20:55:26 +0530
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
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
        Amit Kucheria
	<amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Bjorn
 Andersson" <andersson@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <quic_manafm@quicinc.com>
References: <20240122100726.16993-1-quic_priyjain@quicinc.com>
 <548e2f24-a51e-4593-9463-09506488c70e@linaro.org>
 <f415a8cd-4cae-d7c3-60fc-674b3e660f6b@quicinc.com>
 <aeae2e69-8407-4d90-9d16-27798e2f3248@linaro.org>
From: Priyansh Jain <quic_priyjain@quicinc.com>
In-Reply-To: <aeae2e69-8407-4d90-9d16-27798e2f3248@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: JZpFstnIg1RdHONUyY59S75ploup1Uug
X-Proofpoint-ORIG-GUID: JZpFstnIg1RdHONUyY59S75ploup1Uug
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_06,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0 mlxlogscore=417
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401240111



On 1/24/2024 6:04 PM, Konrad Dybcio wrote:
> 
> 
> On 1/24/24 11:42, Priyansh Jain wrote:
>>
>>
>> On 1/22/2024 8:02 PM, Konrad Dybcio wrote:
>>> On 22.01.2024 11:07, Priyansh Jain wrote:
>>>> Add suspend callback support for tsens which disables tsens interrupts
>>>> in suspend to RAM callback.
>>>
>>> Would it not be preferrable to have the "critical overheat", wakeup-
>>> capable interrupts be enabled, even if the system is suspended?
>>>
>>
>>
>> As part of suspend to RAM, tsens hardware will be turned off and it 
>> cannot generate any interrupt.Also system doesn't want to abort 
>> suspend to RAM due to tsens interrupts since system is already going 
>> into lowest
>> power state. Hence disabling tsens interrupt during suspend to RAM 
>> callback.
> 
> Is that a hardware limitation, or a software design choice? I'm not
> sure I want my phone to have thermal notifications disabled when
> it's suspended.

> Konrad

As part of suspend to RAM , entire SOC will be off, this mode (suspend 
to RAM) is not intended for Mobile product. Tsens interrupts are not
disabled as part of suspend to idle(suspend mode for mobile).

Regards,
Priyansh

