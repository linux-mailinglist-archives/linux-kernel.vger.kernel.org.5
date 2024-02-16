Return-Path: <linux-kernel+bounces-69048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3302A8583C4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DF21B254E9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5621C133985;
	Fri, 16 Feb 2024 17:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="a4dtjq7r"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2606D13340D;
	Fri, 16 Feb 2024 17:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708103519; cv=none; b=RXr5ADxVkWLmfxw2cIo2K3u1N2DFYjX30B2yrzUY5uJhJZbhLMupa95L36XKuNn/4+ay2MZHJC2h3QH71JE5/316Hjb2HvcbNAKZxAgQp9Iv5qtWR+Di+UxdDllHCfLL70IjKGrT8LB1mKd8tXs5iS+dKB8Vwrb2H0PIVulTEiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708103519; c=relaxed/simple;
	bh=/MFoTqyJXd01KvNV9TTovyv/By6QwAU0k3364teWeVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ucmd6k+IKa/pd0mVz3UJjrliNNMYNnhheTAonoDTJqwNvGMFpDiVZ5QIZ3BuudoQMeHPZcapWRG5PqCk53Q+dUwu2nb6+An0Kf8OsgIRCJRw41cEZrK2vQBRJ4WR0shf4caNpdMNn/WhlZx5CYAcR0RavTu0Wl/Jnpf/3qG8zlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=a4dtjq7r; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41GDo2C7030989;
	Fri, 16 Feb 2024 17:11:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=dg/zPGeP0Rmv6bQsqB+01fU8yXB+lq5E8mUg0hoHaR8=; b=a4
	dtjq7rKwiS0wXabK1LjiDEWBheHS4F1QaTMOTWU5HHgjFmSaMVHPLeKJSpOfKuqs
	7lTH3gtx+9EN/uZNgwM73WRtEYI1kAzyb3OAF9894HpYmxdYngiQUNIcAwqKJ0H3
	GqR9JA18YPaG+qktY4nkYCtU3urbd2UdyqbNYzXe1Ax3o4n6qcP8hwMXSweJPhIE
	kogT9kZf/f9MwmO9vsscrpekm5/9t4kFCCziP3rLmZcCK61za/WaGC0xxMirKOaQ
	17a5FeA52+2KaN95RXUql/zN0pBRXPC48OMj+KbGth71cdTesYeJ+DgutG36Uof6
	N+m8fTrDzzpt6Pc2yIrw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w9yta9eky-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 17:11:54 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41GHBrb9012023
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 17:11:53 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 16 Feb
 2024 09:11:52 -0800
Message-ID: <90079dd5-e138-e271-3eb3-88ca7f7da657@quicinc.com>
Date: Fri, 16 Feb 2024 10:11:51 -0700
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
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <87dab0be-df4a-453d-86cc-61ce8e2b706f@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: diU7cgBQtU3nMKdUaRqztT2P-26KULp8
X-Proofpoint-ORIG-GUID: diU7cgBQtU3nMKdUaRqztT2P-26KULp8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_16,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 adultscore=0 spamscore=0
 phishscore=0 clxscore=1015 mlxscore=0 malwarescore=0 mlxlogscore=858
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402160137

On 2/16/2024 10:08 AM, Georgi Djakov wrote:
> On 16.02.24 18:19, Jeffrey Hugo wrote:
>> On 2/5/2024 11:37 AM, Rob Herring wrote:
>>>
>>> On Fri, 02 Feb 2024 11:17:48 -0700, Jeffrey Hugo wrote:
>>>> The servers for the @codeaurora domain have long been retired and any
>>>> messages sent there will bounce.  Fix Odelu's address in the binding to
>>>> match the .mailmap entry so that folks see the correct address when
>>>> looking at the documentation.
>>>>
>>>> Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
>>>> ---
>>>>   Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>
>>> Acked-by: Rob Herring <robh@kernel.org>
>>>
>>
>> Will you take this into your tree?
> 
> Hi Jeff,
> 
> I'll apply it.

Works for me.  Thanks!

-Jeff

