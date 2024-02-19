Return-Path: <linux-kernel+bounces-71304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DE985A330
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAA10B2434F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF312E40C;
	Mon, 19 Feb 2024 12:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="T8lK5B3N"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F422D638;
	Mon, 19 Feb 2024 12:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708345665; cv=none; b=Apsd7vW+b4JD56/4Nw0QkwEu/lNqzEq9PLLhtTNs9Ps4NVuwsDukOL3BGVsFMsEH2NzpIOJ9z9twKe685WStz/RUUI1VnUxao7Rwsx+hG2i0/RA8J+FjlVQ3xbuZQ3ZPqxFTPyYqCqh9H8BcJgQVnCsJkYThjtqmrguIOIyof6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708345665; c=relaxed/simple;
	bh=QtyAmgyaqBP3Pw2hsyXdaBD838ZNokfapk5FB3vM9do=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RipRGigIOQng3AF9pNI2Xgb5vrpHNSONFeYl0I4+FStye+xGx6pFdUeWRVKIWmiJk5wQ42kECIum3C7kKEhXx3b4ePIv9Eak8GvxX6WFIrX5jY+eRVRrit9OwSQlogsOHk9E2BDEc4a9QIq28YzlxErftR0BNGPbA0MS6/MT4e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=T8lK5B3N; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41JAeoK2009496;
	Mon, 19 Feb 2024 12:27:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=k3n1beUOcmwlqVyyDnDeVwvl4hamR/xvV4h8XQhkusc=; b=T8
	lK5B3NiIBFlquw+7f0Ai1xSOO8osBXYtKp4T+ObjNl1UqRFzYkTnJ/+keYupjTKI
	VHKZsm6mKhqJEL6Yz3ZWQ/xrAXdJmb5E2d/xRX/EQarcg7uvyHlPFk0e2gj0RbHA
	DGuwM7FxdSey225lhGRReIlAXASOGYPWYNRnsaCm01a6YTqU/aRKnAdd4aDtl5hH
	H/kmP9f1NdSZoO9PqdgMLo0cHOsRAGOqCg9028ldNvyvWfyUahnImGrigTTpWd70
	9+6oPAPg2qXS7uCSk/c4DC15WorRpypGOzSofjOEoF+B0WOAvRBG0gB43rF6IlXh
	bCfegwQ2ADRDWvM1zoLQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wc5dtr6mx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 12:27:35 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41JCRZLx022733
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 12:27:35 GMT
Received: from [10.214.82.119] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 19 Feb
 2024 04:27:31 -0800
Message-ID: <34734d65-6be7-4fab-98b7-357726751af5@quicinc.com>
Date: Mon, 19 Feb 2024 17:57:28 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: interconnect: Add Qualcomm SM7150 DT
 bindings
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Danila Tikhonov
	<danila@jiaxyga.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <djakov@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240218183239.85319-1-danila@jiaxyga.com>
 <20240218183239.85319-2-danila@jiaxyga.com>
 <fce70468-05fb-4f51-a653-7921dd27bc6b@quicinc.com>
 <f522e679-3543-46ee-8b2d-92e384427382@linaro.org>
From: Naman Jain <quic_namajain@quicinc.com>
In-Reply-To: <f522e679-3543-46ee-8b2d-92e384427382@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: FdxgsSP__rrgBzXHnAKkDnCXCpPjd2pP
X-Proofpoint-GUID: FdxgsSP__rrgBzXHnAKkDnCXCpPjd2pP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-19_08,2024-02-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 impostorscore=0 mlxlogscore=805 lowpriorityscore=0 phishscore=0
 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402190093

On 2/19/2024 4:44 PM, Krzysztof Kozlowski wrote:
> On 19/02/2024 10:48, Naman Jain wrote:
>> On 2/19/2024 12:02 AM, Danila Tikhonov wrote:
>>> The Qualcomm SM7150 platform has several bus fabrics that could be
>>> controlled and tuned dynamically according to the bandwidth demand.
>>
>> Please add what you are trying to do with this patch.
>>
>> Ref:
>> https://docs.kernel.org/process/submitting-patches.html#describe-your-changes
> 
> The reason for this change is explained in commit msg, so what exactly
> are you missing?
> 
> Best regards,
> Krzysztof
> 

I was under the impression that we should have explained/mentioned the
subject of this patch in the description of the commit msg. It seems
that it's not required. Thanks for correcting me.

Regards,
Naman Jain

