Return-Path: <linux-kernel+bounces-42233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C78BF83FE4D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 07:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC3541C21B43
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 06:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD7A4CB55;
	Mon, 29 Jan 2024 06:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HtncqdXY"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998EF4CB20;
	Mon, 29 Jan 2024 06:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706509688; cv=none; b=E9RCzKkjzYX0ZJm0um6z+0nkZ9vJTgky0yMGye9NVceIulXXo6/KJp1PijvC3goixbznaPf4xGwMSLEwzmqS6xwccVl8rn+V35Fk3QOHaD/F/TVxOvzJWN6pKEBJN9fp+MmwsFa1IQnl3d3Na5G54vgj9OfD0zeV5go1JCbUj44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706509688; c=relaxed/simple;
	bh=MJ8dmrrNeH24dihPagf9VsNviY6mf4kB3heVGxf5pxY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aRsLi7Q1isP9S73XEOqv/67aotKidF/jX+/qxY/jG6zboPaoRCLwL+Zb5KZdL67E9dXAg+YFoQkm3gOdHJwta8PmDiFMBCHIuTIre9WjdH8O+hUXblMdzwYvn2llH02Kk6Wy/NtUD6HDDdAVPq/g9jVt058hlUK9PwRaCmM2mUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HtncqdXY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40T6CEUI005049;
	Mon, 29 Jan 2024 06:28:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=iPuxWaexrafzEjbzvtOZ3NDk0BwxrfAdr+ss7HokmLo=; b=Ht
	ncqdXYZ3uwMrNWCeQpL5OG9XqBwpqTmqvs1ogh1L+drMbjEI4Zo9vRiGmk+27ss3
	KG53M+5KExPXzXeHieJLEy8GAUmrA2D/S0CTCK1WWPjByhBoEqCCuVvysKt1HqYv
	W+60qiAllKQnlFNVtlVgYu68kDPTEi0m4i7OZE0DAEWFwold4ZRwnucTBO7cM2Ry
	IkoWxR1QEKRjPMZjCZsXwuNdsbii4irmNa0vziXj+IQeVf9RSGbwywaW95tBh3BN
	9hQIAm36qU5ppkDehVsWo7cCBLsiQfEpehF3rE/bAJjw9e2Lv9yyBaR0T2XEmi2G
	ac/Ts5jpDSXY3Qdk6pmQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vvu4ctver-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 06:28:01 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40T6S0Jv016826
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 06:28:00 GMT
Received: from [10.217.198.224] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sun, 28 Jan
 2024 22:27:57 -0800
Message-ID: <b3643a21-d0a8-4c4c-85de-852055a2d08b@quicinc.com>
Date: Mon, 29 Jan 2024 11:57:54 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] soc: qcom: rpmh-rsc: Enhance check for VREG in-flight
 request
Content-Language: en-US
To: Andrew Halaney <ahalaney@redhat.com>
CC: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_eberman@quicinc.com>, <quic_collinsd@quicinc.com>,
        <quic_lsrao@quicinc.com>
References: <20240119-rpmh-rsc-fixes-v2-1-e42c0a9e36f0@quicinc.com>
 <dahguk6hyo35ydugwno5t5lbteporwkiddhvxp6uni5ggbtxcm@3bu6ptvg7mdg>
From: "Maulik Shah (mkshah)" <quic_mkshah@quicinc.com>
In-Reply-To: <dahguk6hyo35ydugwno5t5lbteporwkiddhvxp6uni5ggbtxcm@3bu6ptvg7mdg>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: RCtyLaC3rPkkjR5ke5GHoucGrpmMwyXe
X-Proofpoint-ORIG-GUID: RCtyLaC3rPkkjR5ke5GHoucGrpmMwyXe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_02,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 clxscore=1011 priorityscore=1501 lowpriorityscore=0 adultscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=586 phishscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401290045

Hi,

On 1/19/2024 9:17 PM, Andrew Halaney wrote:

>> Signed-off-by: Maulik Shah <quic_mkshah@quicinc.com>
>> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> 
> Just noticed I commented on v1 when v2 was already out, sorry. Copy
> pasting this just to keep it on the latest thread:
> 
> Two minor things:
> 
>      1. Does this deserve a Fixes: tag?
>      2. The Signed-off-by chain here confuses me, you sent the patch
>         so your SOB should be last, but then that makes me believe Elliot
>         was the author which I don't think is reflected here (no From:
>         line). Please read [0] for a bit more details
> 
> [0] https://www.kernel.org/doc/html/latest/process/submitting-patches.html#developer-s-certificate-of-origin-1-1

Yes, this looks good to have patch, will include fixes:  tag and will 
fix SOB in v3.

Thanks,
Maulik

