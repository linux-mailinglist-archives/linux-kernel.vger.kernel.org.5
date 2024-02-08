Return-Path: <linux-kernel+bounces-57986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A59F84DFF2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4928281C56
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63F46F53A;
	Thu,  8 Feb 2024 11:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YlrkaB1K"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430EC6F51E;
	Thu,  8 Feb 2024 11:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707392727; cv=none; b=jry7AJBSpjCCipqSju9kud8TYLdMb09Y6ZezlN/ptsrSREvtafUdf4m+MrlDywwkgRsUi2iEL6DBx6PMvzgIdxGg+x0i6RXCNhLCV0ovcJjwbpeQS4y7jAIplDrqGzFbuEWc7eKlj0FvI5P5kHWIvaktGB3GHn6z/JlsozAorFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707392727; c=relaxed/simple;
	bh=N+3yVriiltjnljqFfHb3QxvNIOALWqc9omAJL8qGFF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=u1Xe+ryZpJHjsHbzcJt/SafAUG/+vBJ1IlCUSEzqY3kM0lZYvOnphSqa+K+VGHcSlN4RAZX7XTDjJKQV4M+ZgZmRbkMcrxQJKE0hEc7Lb/Pq3FCe4D0pV06h0VhOJjscqLOuIfm/uABqdsCpkfBRB8P0IvLHJp2pLmEicv/6pvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YlrkaB1K; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 418AsrvJ015356;
	Thu, 8 Feb 2024 11:45:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Vr8BwyMyZfo2JDAIKad5nzu7oOzSVNUT/aNXEZdyi5g=; b=Yl
	rkaB1K5Y1uoSYDSn6AytizEy6BwsVAIdX34kP4qE8xIr+66+LzGqrpwNiTIFJbIu
	owUIq7eUbr2zDPIL6X3wpHRfjMSHDFdSPtBSXHz1V2fck0W7ZdtK60LADuFnwDsO
	KkKBypwvHEgoQX48xFz8BaFVFltmzkIthbkNxtvGlOctGWCEfV8ruHUCiYEptwS9
	MccStUikryppPWAVAFckCtfN4CQHiFoSI0U9sTKc5WUB8tk2oAmz5X+JWP8W+Nmd
	h2JtVW3mMAIBZ2ugYKRWlRXAjAkinkWjB24tF06EdU22BzU7XbrVMWOJq0oZ9I3J
	VEZznj4youf2luFG2lyw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w4pavh8uw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 11:45:07 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 418Bj60X032460
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 8 Feb 2024 11:45:06 GMT
Received: from [10.131.33.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 8 Feb
 2024 03:45:01 -0800
Message-ID: <2b1d9578-39cc-7836-a51b-be698bb50c43@quicinc.com>
Date: Thu, 8 Feb 2024 17:14:58 +0530
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
From: Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <3325c6ea-ca30-40ee-83ba-c489dc9964b1@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: XDWfVud3sn7oSwSTbmzDGroEkiI5ZRgI
X-Proofpoint-GUID: XDWfVud3sn7oSwSTbmzDGroEkiI5ZRgI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_03,2024-02-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 malwarescore=0
 mlxlogscore=905 phishscore=0 bulkscore=0 adultscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2401310000 definitions=main-2402080061



On 1/18/24 01:45, Konrad Dybcio wrote:
> 
> 
> On 1/17/24 18:34, Sibi Sankar wrote:
>> From: Shivnandan Kumar <quic_kshivnan@quicinc.com>
>>
>> SCMI QCOM vendor protocol provides interface to communicate with SCMI
>> controller and enable vendor specific features like bus scaling capable
>> of running on it.
> 

Hey Konrad,

> "QCOM protocol" sounds overly generic, especially given how many
> different vendor protocols have historically been present in
> QC firmware..

Here it is specifically mentioned that way to communicate that
this is the only vendor protocol exposed by Qualcomm. It handles
all the other protocols which were usually handled separately on
older SoCs.

> 
>>
>> Signed-off-by: Shivnandan Kumar <quic_kshivnan@quicinc.com>
>> Co-developed-by: Ramakrishna Gottimukkula <quic_rgottimu@quicinc.com>
>> Signed-off-by: Ramakrishna Gottimukkula <quic_rgottimu@quicinc.com>
>> Co-developed-by: Amir Vajid <avajid@quicinc.com>
>> Signed-off-by: Amir Vajid <avajid@quicinc.com>
>> Co-developed-by: Sibi Sankar <quic_sibis@quicinc.com>
>> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
>> ---
> 
> So, this is another 0x80 protocol, different to the one that has
> been shipping on devices that got released with msm-5.4, msm-5.10
> and msm-5.15 [1][2]. They're totally incompatible (judging by the
> msg format), use the same protocol ID and they are (at a glance)
> providing access to the same HW/FW/tunables.

Thanks for bringing this up but like I already explained the only
SoC that was actually shipped with ^^ protocol was SC7180 and we
already have an alternative arrangement for memory dvfs upstreamed
on it. Further more it handles only L3 dvfs so it makes zero sense
to try to upstream the older protocol given that working dvfs solution
already exists upstream. All other SoCs don't have the 0x80 protocol
enabled for memory dvfs in production.

> 
> I'm not sure if this can be trusted not to change again.. Unless
> we get a strong commitment that all platforms (compute, mobile,
> auto, iot, whatever) stick to this one..

This is exactly that consolidation effort from Qualcomm. Here they
expose just one vendor protocol and implement all the algorithms just
through it.

> 
> That said, the spec (DEN0056C) says that protocol IDs 0x80-0xff
> are: "Reserved for vendor or platform-specific extensions to
> this interface.". So if perhaps there's a will to maintain
> multiple versions of this, with a way to discern between them..
> 
> Konrad
> 
> [1] 
> https://git.codelinaro.org/clo/la/kernel/msm-5.15/-/blob/KERNEL.PLATFORM.2.1.r5-05400-kernel.0/drivers/firmware/arm_scmi/memlat_vendor.c?ref_type=tags
> [2] 
> https://git.codelinaro.org/clo/la/kernel/msm-5.15/-/blob/KERNEL.PLATFORM.2.1.r5-05400-kernel.0/include/linux/scmi_memlat.h#L16

