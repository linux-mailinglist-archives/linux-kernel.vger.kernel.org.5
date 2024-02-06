Return-Path: <linux-kernel+bounces-55578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E94A84BE6E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 21:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94B9F289058
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 20:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6259918AF8;
	Tue,  6 Feb 2024 20:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nj0tB5yY"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AA617BCE;
	Tue,  6 Feb 2024 20:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707250001; cv=none; b=W8cz+5Tzjwz5vSQOosJ6u/cEimSGyKTuIt+jrAzt4kQ3oi315y5RpQ7RzOUEYsv9P58FgJ4Qj9SIXsUXfdSydJdx9Djt0S8kvXl/uB1j7RJnawiP8Q7YI/Yb9NtBk2ByLcJWWaVFCW1fNCYR5A6EEyaXMR6YtPoRgwU/u02UNF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707250001; c=relaxed/simple;
	bh=VQ0SGIi4z2XyvepZBFYEVNAzFUIqIq3PsOw+G721v/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kFCfzf4UNsaqiuDrO5DZjnDUEUai3qDtbYcHHi6r5XCxQuPLw22WlHxZLShknbuKv2XfjC+HjlkShvnKpfssccyGMscuWldD0YwbulBNmZMRlzu4FuitS5VsbLcVYZJOoFbl33yDsScfUkttRysj5jOBCQI62ap44NzgEu+scVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nj0tB5yY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 416K0WpP015007;
	Tue, 6 Feb 2024 20:06:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=H0bBGW7clRKEJWq0+cMgOgOlsVK8a4Po1YyUgny5KLs=; b=nj
	0tB5yY5YO9GBMbMsHnSk6svOI1x7Gpj1IJr5LYesokyWODku1Yzrxs0ioYDuY3VV
	afBlHT2Cupw/cx6uieMyjlZNR8XIBy9BO0NKY8e9riF8KYITOqI/YUaS/pRUFdO9
	jGzrSg0cTOITpNYpsgToO532TniRLTkiDsXJkInjYk+eDN3shfg870mvNTOvgBRn
	NFks3vI1hMOm0ahdqQrGFd/rnsTHIjxIotXcn8Axfouyg0EYI8qzs45Ia6hoWQIP
	WKDqqpMw6ZpKn9hHRQoadBZ+jZzTT05OLDupAlkSYy+8B0tkbdI5eCd7Z+76meZC
	d55dRSKZN0BCKAIstbpA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w3ud2r0sg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Feb 2024 20:06:35 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 416K6Yt4015727
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 6 Feb 2024 20:06:34 GMT
Received: from [10.110.41.143] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 6 Feb
 2024 12:06:31 -0800
Message-ID: <79a01e7c-3a88-49cf-b227-804155a65a4b@quicinc.com>
Date: Tue, 6 Feb 2024 12:06:31 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] arm64: dts: qcom: sm8450: Add mapping to llcc
 Broadcast_AND region
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>
References: <cover.1707202761.git.quic_uchalich@quicinc.com>
 <cf138f258ecbfbcc94717e4914de2f60153e5abb.1707202761.git.quic_uchalich@quicinc.com>
 <1e26c5b3-716b-4f16-bae4-2682667550a5@linaro.org>
From: Unnathi Chalicheemala <quic_uchalich@quicinc.com>
In-Reply-To: <1e26c5b3-716b-4f16-bae4-2682667550a5@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 2YAAIXSMdXVycn0rLv5z7Xr3R9POA_SH
X-Proofpoint-GUID: 2YAAIXSMdXVycn0rLv5z7Xr3R9POA_SH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-06_13,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 malwarescore=0 mlxscore=0 adultscore=0 mlxlogscore=463 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402060139

On 2/6/2024 12:35 AM, Krzysztof Kozlowski wrote:
> On 06/02/2024 08:15, Unnathi Chalicheemala wrote:
>> Mapping Broadcast_AND region for LLCC in SM8450.
> 
> Why?
> 
> And why your DTS is in the middle of driver changes? Driver cannot
> depend on DTS - you are now breaking all existing boards and users.
> 

I was following a similar patch which has DT and driver changes in the
same patchset:
https://lore.kernel.org/all/20230314080443.64635-1-manivannan.sadhasivam@linaro.org/

The AND region was added in the IP block in SM8450, but was not added to the DT or
driver. That is why I included both in the same patchset - if you think the DT
changes should be separate I can correct it in the next version.

Thanks a lot for taking the time to review Krzysztof.

> 
> Best regards,
> Krzysztof
> 

