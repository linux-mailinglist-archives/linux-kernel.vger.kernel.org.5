Return-Path: <linux-kernel+bounces-61109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D59F850D6A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 06:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E51EE1F2246F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 05:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23FA56FCC;
	Mon, 12 Feb 2024 05:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Eq9cWNEy"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CD36AAD;
	Mon, 12 Feb 2024 05:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707716911; cv=none; b=c8VPfxCrveM/6da2gJAgrwVnxuICBV/NcS3E6Zzd2OzOTtftLCDcsbYbXd3W84TTKT56T86ANA6snOWe8n1icfzOinnmen/lOnMICz31zm1pzARe2ntBVMlozcXD6YqIRLNJKEOc3N+476xHlwf+0eqU7Qn9Q2pMPJmFzOCR9Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707716911; c=relaxed/simple;
	bh=vq+GSkXJvTGLfDJ2tYwni20Y5j/D/pob2af57SMbMio=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=T+P71E4ZtIL1HcIA+biixcrQkksvJgfcj+6dPqm5zyRakT+rMgH8TsbtOrLeu0+1p2zP0x65RhQWC5m0y0yoBTQqr9N79BZ4KHmbJp34AA51yNuR8cwj9CVB4BTxeg0z9CdrFDhT62WMwpeqXdrD5nvyIi+mFp/7MC0c3EzydX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Eq9cWNEy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41C4i3TO018415;
	Mon, 12 Feb 2024 05:48:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=dvPlOcvAxmbVcZwp7aEugXR4QyTL9P4EWOQRCnN/5bQ=; b=Eq
	9cWNEyDaYyOxpCPchEFH4BrmXoF0ExmoFj/LAn9RTB0a2zbnmj8O9UreWBYJ1/Nn
	YY3lztvNBFeA/R6sOmnEOdegd4BokrGHVlHBihxtsFIGoahSfgWFG30nxznFcHvQ
	U6/iPOP5MPDBv2RDa8cpitfGUUSRIP8uYQ/EhwYq06uPetXSeX+c1MZWknUnM/6R
	85TmxxkuiA5w9yEMq5fJc93GR+aOYryLuya8t/24sXzsezFfJl2DrseHxso6WJgw
	xEQo5yw8StV9fVYGizY9Caz2789Md0iQE+hRLqVb6IfRasgO3Lq2d0An/mcywHj7
	NYg7tbVM9d0RSl/g0CYw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w62n02jj2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 05:48:22 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41C5mLBN027772
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 05:48:21 GMT
Received: from [10.131.33.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sun, 11 Feb
 2024 21:48:17 -0800
Message-ID: <2b437106-2ae4-bfb2-3ca5-c603d0cf4e2f@quicinc.com>
Date: Mon, 12 Feb 2024 11:18:14 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC 1/7] dt-bindings: mailbox: qcom: Add CPUCP mailbox
 controller bindings
To: Konrad Dybcio <konrad.dybcio@linaro.org>, <sudeep.holla@arm.com>,
        <cristian.marussi@arm.com>, <andersson@kernel.org>,
        <jassisinghbrar@gmail.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <quic_rgottimu@quicinc.com>,
        <quic_kshivnan@quicinc.com>, <conor+dt@kernel.org>
References: <20240117173458.2312669-1-quic_sibis@quicinc.com>
 <20240117173458.2312669-2-quic_sibis@quicinc.com>
 <7bf729a4-f3ac-4751-9275-a2aa4d62c036@linaro.org>
 <1f0c2767-c489-58a6-e5ba-9f1974072bb7@quicinc.com>
 <7b294518-9d4b-4648-a2b7-3843aca033a1@linaro.org>
Content-Language: en-US
From: Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <7b294518-9d4b-4648-a2b7-3843aca033a1@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: LoYWeqpGnh50cOxUd8tlyQzklLVdgChI
X-Proofpoint-ORIG-GUID: LoYWeqpGnh50cOxUd8tlyQzklLVdgChI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_03,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 mlxlogscore=762 phishscore=0 priorityscore=1501 mlxscore=0 suspectscore=0
 spamscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402120042



On 2/9/24 04:44, Konrad Dybcio wrote:
> On 8.02.2024 11:22, Sibi Sankar wrote:
>>
>>
>> On 1/18/24 01:23, Konrad Dybcio wrote:
>>>
>>>
>>> On 1/17/24 18:34, Sibi Sankar wrote:
>>>> Add devicetree binding for CPUSS Control Processor (CPUCP) mailbox
>>>> controller.
>>>>
>>>> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
>>>> ---
>>>
>>
>> Hey Konrad,
>>
>> Thanks for taking time to review the series.
>>
>>> [...]
>>>
>>>> +  - |
>>>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>>>> +
>>>> +    mailbox@17430000 {
>>>> +        compatible = "qcom,x1e80100-cpucp-mbox", "qcom,cpucp-mbox";
>>>> +        reg = <0x17430000 0x10000>, <0x18830000 0x300>;
>>>
>>> These reg spaces are quite far apart.. On 7280-8550, a similar
>>> mailbox exists, although it's dubbed RIMPS-mbox instead. In
>>> that case, I separated the mbox into tx (via
>>> qcom-apcs-ipc-mailbox.c) and rx (with a simple driver). Still
>>> haven't pushed or posted that anywhere, I'd need to access
>>> another machine..
>>>
>>> On (some of) these SoCs, one of the channels (rx[1], iirc?) clearly
>>> bleeds into the CPUFREQ_HW/OSM register region, which gives an
>>> impression of misrepresenting the hardware. X1E doesn't have a
>>> node for cpufreq_hw defined, so I can't tell whether it's also the
>>> case here.
>>
>> I am aware of ^^ discussion and the X1E doesn't have this problem.
>> Both the regions described are only used for mailbox communication.
>> X1E uses the scmi perf protocol for cpu dvfs.
> 
> Yes, that's clear.
> 
> I am however asking for something different: I presume the CPUSS
> IP hasn't changed too much on this SoC, other than having new cores and
> OSM now being controlled through a different firmware interface, and I'd
> like to keep the hardware description in our DT as close to the metal as
> possible.
> 
> In other words, if the good ol' OSM hardware is indeed there under however
> many layers of firmware, and if RX does indeed bleed into its register
> space, I'd prefer there be at least a syscon node describing the actual
> block, and not a magic hwio entry that's many zeroes away.
> 

With the new cores X1E does not have any artifacts from the legacy
OSM way that Qualcomm has followed till now. If it indeed existed it
would make zero sense to vote for CPU frequencies through a mailbox than
vote for it directly.

-Sibi

> Konrad
> 

