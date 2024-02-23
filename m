Return-Path: <linux-kernel+bounces-78648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB13F861681
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD13E1C24C3C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B6D82D81;
	Fri, 23 Feb 2024 15:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KXbMU2aL"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BFD81AD3;
	Fri, 23 Feb 2024 15:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708703781; cv=none; b=OyxVvLF/jWxMeNdYNTbgX7mpra7YG5lttRZC+YS7GlOnR2YeEI0iXVjIUNlRpFL+7zUXBi7kkQlWC2pakGi3F67XpcihZUODdGaklP7G/mtAbDSdcYHii0KQc1+VoDk5QpCEEzGa8DeJ2VxHWCRZO/ezAmQmH4daobiK7WiGRjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708703781; c=relaxed/simple;
	bh=ZCoPaJ7P5QbdVcSrT64XIFlda5HmQF4260dp6rmP2vE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=c/gj6Fn/hojbM8Qb8Zi3/NOWhTJJUodz0tv/ozJIh9GAkjbi1RLVh5JHuxPsgQ5y2qPBbrE7NB8f6fXgXcEERiN1YNP29NywPtm2nET8iQecLmVHoEc/w/+FpzL4zKd972RTBfU/LJl+gm7Yei0OS/lBewe8IYp01cP1MDo0Rnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KXbMU2aL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41NBabuc018103;
	Fri, 23 Feb 2024 15:56:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:from:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=CfJwnlx475j0F9r0xQlC24vXC7wtLwtZt3NnjJgKMd8=; b=KX
	bMU2aLT47iCU7pi8/CqZnaoGrgJKSi7AD2rnA9Gimlprf+mC3jqdF8Hcy7BIyWOc
	49Jge5OM2hIQAlDqMOgv5py8DFWBplrg1uzd0oV5npL/1sNAt+5IIi3qkXva77kf
	HNNT9YQJvM9Ab43gtlBLkBrBPxp4vxqdCJ4CLgixzXZWOHB0dWiDZCMrI/P80lhN
	iOftb3X+fZfauH5ipTMdgUIjCnq2EOOhuf2c16Y5GVrVzzhCshEAddodHWjumBco
	B1NUrcceVrGAh7wQvBIPYYhDPBgsZLLy4rA+J6BnRALU9f6JqAqwKNCCaVraOPpo
	OVS2aA0he+jW+zVBQRoA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3weq6x92dt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 15:56:15 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41NFuFcM000780
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 15:56:15 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 23 Feb
 2024 07:56:14 -0800
Message-ID: <64625079-4d9f-6624-eb94-0d665a1f1c4d@quicinc.com>
Date: Fri, 23 Feb 2024 08:56:13 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] dt-bindings: interconnect: qcom,rpmh: Fix bouncing
 @codeaurora address
Content-Language: en-US
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <konrad.dybcio@linaro.org>,
        <linux-pm@vger.kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <andersson@kernel.org>, <quic_okukatla@quicinc.com>,
        <devicetree@vger.kernel.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>
References: <20240202181748.4124411-1-quic_jhugo@quicinc.com>
 <170715826040.3958103.13885911803274019580.robh@kernel.org>
 <aca58fb4-b9c8-1730-cff4-56a2d73bd235@quicinc.com>
 <87dab0be-df4a-453d-86cc-61ce8e2b706f@kernel.org>
 <90079dd5-e138-e271-3eb3-88ca7f7da657@quicinc.com>
In-Reply-To: <90079dd5-e138-e271-3eb3-88ca7f7da657@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6RxcSN7NXV-04xIeJnRaWuvSJQerGU8f
X-Proofpoint-ORIG-GUID: 6RxcSN7NXV-04xIeJnRaWuvSJQerGU8f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_02,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 spamscore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 adultscore=0 mlxlogscore=902 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402230115

On 2/16/2024 10:11 AM, Jeffrey Hugo wrote:
> On 2/16/2024 10:08 AM, Georgi Djakov wrote:
>> On 16.02.24 18:19, Jeffrey Hugo wrote:
>>> On 2/5/2024 11:37 AM, Rob Herring wrote:
>>>>
>>>> On Fri, 02 Feb 2024 11:17:48 -0700, Jeffrey Hugo wrote:
>>>>> The servers for the @codeaurora domain have long been retired and any
>>>>> messages sent there will bounce.  Fix Odelu's address in the 
>>>>> binding to
>>>>> match the .mailmap entry so that folks see the correct address when
>>>>> looking at the documentation.
>>>>>
>>>>> Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
>>>>> ---
>>>>>   Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml | 2 +-
>>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>
>>>> Acked-by: Rob Herring <robh@kernel.org>
>>>>
>>>
>>> Will you take this into your tree?
>>
>> Hi Jeff,
>>
>> I'll apply it.
> 
> Works for me.  Thanks!
> 
> -Jeff

Georgi, I don't see this in -next.  Should I be looking elsewhere?

-Jeff

