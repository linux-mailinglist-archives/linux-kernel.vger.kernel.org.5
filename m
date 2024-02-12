Return-Path: <linux-kernel+bounces-61224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 747E0850F2C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 09:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFDFFB20A2E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 08:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519EA101C1;
	Mon, 12 Feb 2024 08:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ue1t7wBa"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E30F9F5;
	Mon, 12 Feb 2024 08:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707728182; cv=none; b=jHJFukAGgwFsMEnanNT5DxdA0uLGTFraNw5PveEyj2F44p3F5tfzZ3Bub/s2S26cVSvHUsjulrMLpY+Sl5PU4paTsVb9wETi+CAX2e+LeIQs3VjueN2zOlUmyVKuapxm3alCsfsgy6fHo+5N5i+12Aa9yN/jJmVz+XzeZVW8SyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707728182; c=relaxed/simple;
	bh=vANarlCVL7YQ/3338qTzKIhygSAtVwfBhAKCDdb2Qo8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pJhIS9dDKbu6cqidwI2pFcLa3hAIqoQ+SV3FqI3tHNEHwiOWbBe8kfRF6xYfGcjzo2+ASgBN8NAtZzEN5j8YN0SLbEKF4Svk2ddvrWPNXsAxqMivKK3h907GwPCtfRcFFkwOWyNX2F0gOPICQJMlB5anyZpfjTpng8EwRlVtr0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Ue1t7wBa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41C8JDsZ012823;
	Mon, 12 Feb 2024 08:56:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=t446M35Bn/q1ZvKyKNo6fRXbfCqkKlbDZSbGpUSGrjg=; b=Ue
	1t7wBa0yyl0ZqumMG/vjajnaH3TgNredLJnYC99aBwTPsXX5yC9uAVwjkbpmLGSt
	1M04IeJs9G8PVZuBD/mwgcnwG2q+lvIO3qsuvGWGULj1y/H/zQeTiTlhWYFpFPdW
	8Z6TdnwNuV6zNj1JVc+A3yEt6hLHs5htfe88pP0ek+l5OQU9jjYQzc2q5b7KXDqz
	UxXNkagUJX5h4JdMdcuXQBJQp4hrSYzOxAqzvWnjpMXcOoBLiJLKF5fK4h5+xiWK
	CKGOonsOSisxpj8IoaBXCZqKM5WccE+kiR+XuPpvljHOamkbZJjrYAny0jLmUdow
	V1luQWWLy+2h9jntQizw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w62r12tw8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 08:56:13 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41C8uCiK012862
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 08:56:12 GMT
Received: from [10.131.33.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 12 Feb
 2024 00:56:08 -0800
Message-ID: <de2b3cd3-95f9-4fc4-4d51-35be32a788e9@quicinc.com>
Date: Mon, 12 Feb 2024 14:26:05 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC 3/7] firmware: arm_scmi: Add QCOM vendor protocol
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>, <sudeep.holla@arm.com>,
        <cristian.marussi@arm.com>, <andersson@kernel.org>,
        <jassisinghbrar@gmail.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <quic_rgottimu@quicinc.com>,
        <quic_kshivnan@quicinc.com>, <conor+dt@kernel.org>,
        Amir Vajid
	<avajid@quicinc.com>
References: <20240117173458.2312669-1-quic_sibis@quicinc.com>
 <20240117173458.2312669-4-quic_sibis@quicinc.com>
 <3325c6ea-ca30-40ee-83ba-c489dc9964b1@linaro.org>
 <2b1d9578-39cc-7836-a51b-be698bb50c43@quicinc.com>
 <34af183c-638a-49f3-b0b3-784f757282b2@linaro.org>
From: Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <34af183c-638a-49f3-b0b3-784f757282b2@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -ifNDEs3z0tVHXtsbq6Xp-kbAs1pMKFr
X-Proofpoint-ORIG-GUID: -ifNDEs3z0tVHXtsbq6Xp-kbAs1pMKFr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_05,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 mlxscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 impostorscore=0 mlxlogscore=948 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2401310000
 definitions=main-2402120067



On 2/10/24 04:15, Konrad Dybcio wrote:
> On 8.02.2024 12:44, Sibi Sankar wrote:
>>
>>
>> On 1/18/24 01:45, Konrad Dybcio wrote:
>>>
>>>
>>> On 1/17/24 18:34, Sibi Sankar wrote:
>>>> From: Shivnandan Kumar <quic_kshivnan@quicinc.com>
>>>>
>>>> SCMI QCOM vendor protocol provides interface to communicate with SCMI
>>>> controller and enable vendor specific features like bus scaling capable
>>>> of running on it.
>>>
>>
>> Hey Konrad,
>>
>>> "QCOM protocol" sounds overly generic, especially given how many
>>> different vendor protocols have historically been present in
>>> QC firmware..
>>
>> Here it is specifically mentioned that way to communicate that
>> this is the only vendor protocol exposed by Qualcomm. It handles
>> all the other protocols which were usually handled separately on
>> older SoCs.
> 
> I'm no SCMI specialist but that's a rather.. peculiar design decision,
> I guess
> 
> 
>>
>>>
>>>>
>>>> Signed-off-by: Shivnandan Kumar <quic_kshivnan@quicinc.com>
>>>> Co-developed-by: Ramakrishna Gottimukkula <quic_rgottimu@quicinc.com>
>>>> Signed-off-by: Ramakrishna Gottimukkula <quic_rgottimu@quicinc.com>
>>>> Co-developed-by: Amir Vajid <avajid@quicinc.com>
>>>> Signed-off-by: Amir Vajid <avajid@quicinc.com>
>>>> Co-developed-by: Sibi Sankar <quic_sibis@quicinc.com>
>>>> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
>>>> ---
>>>
>>> So, this is another 0x80 protocol, different to the one that has
>>> been shipping on devices that got released with msm-5.4, msm-5.10
>>> and msm-5.15 [1][2]. They're totally incompatible (judging by the
>>> msg format), use the same protocol ID and they are (at a glance)
>>> providing access to the same HW/FW/tunables.
>>
>> Thanks for bringing this up but like I already explained the only
>> SoC that was actually shipped with ^^ protocol was SC7180 and we
>> already have an alternative arrangement for memory dvfs upstreamed
>> on it.
> 
> Ok, that makes sense.
> 
> I took my 8550 phone, enabled some debug prints and it looks like the
> only SCMI protocol exposed is 0x19 (which doesn't seem to be defined).
> 
> Not sure what other devices would spit out, but I assume what you said
> is true.
> 
> For completeness, the reported rev is:
> 
> arm-scmi firmware:scmi: SCMI Protocol v2.0 'Qualcomm:' Firmware version 0x10000
> 
>> Further more it handles only L3 dvfs so it makes zero sense
>> to try to upstream the older protocol given that working dvfs solution
>> already exists upstream.
> 
> We don't have any sort of governor for it though, so I wouldn't go as
> far as calling it working :P

It is a working solution (it is equivalent to the compute mon mapping in
downstream implementation) but isn't feature complete ¯\_(ツ)_/¯.

> 
>> All other SoCs don't have the 0x80 protocol
>> enabled for memory dvfs in production.
>>
>>>
>>> I'm not sure if this can be trusted not to change again.. Unless
>>> we get a strong commitment that all platforms (compute, mobile,
>>> auto, iot, whatever) stick to this one..
>>
>> This is exactly that consolidation effort from Qualcomm. Here they
>> expose just one vendor protocol and implement all the algorithms just
>> through it.
> 
> And I'm very glad you're taking such consolidation steps.. Just a little
> worried that in case this protocol's extensibility is exhausted, the next
> one would need to be called.. "Qualcomm2"?

We don't see ^^ happening in the near future (meaning this doesn't apply
to just X1E). The consolidation would still be better than spinning out
n number of protocols per SoC.

-Sibi

> 
> Konrad

